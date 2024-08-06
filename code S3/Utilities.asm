; =============== S U B R O U T I N E =======================================


sndDriverInput:
		; Dummy leftover from Sonic 2.
		rts
; End of function sndDriverInput


; =============== S U B R O U T I N E =======================================


Init_Controllers:
		stopZ80
		moveq	#$40,d0
		move.b	d0,(HW_Port_1_Control).l
		move.b	d0,(HW_Port_2_Control).l
		move.b	d0,(HW_Expansion_Control).l
		startZ80
		rts
; End of function Init_Controllers


; =============== S U B R O U T I N E =======================================


Poll_Controllers:
		lea	(Ctrl_1).w,a0
		lea	(HW_Port_1_Data).l,a1
		bsr.s	+ ;Poll_Controller	; poll first controller
		addq.w	#2,a1	; poll second controller
; End of function Poll_Controllers


; =============== S U B R O U T I N E =======================================


+ ;Poll_Controller:
		move.b	#0,(a1)			; Poll controller data port
		nop
		nop
		move.b	(a1),d0			; Get controller port data (start/A)
		lsl.b	#2,d0
		andi.b	#$C0,d0
		move.b	#$40,(a1)		; Poll controller data port again
		nop
		nop
		move.b	(a1),d1			; Get controller port data (B/C/Dpad)
		andi.b	#$3F,d1
		or.b	d1,d0			; Fuse together into one controller bit array
		not.b	d0
		move.b	(a0),d1			; Get press button data
		eor.b	d0,d1			; Toggle off buttons that are being held
		move.b	d0,(a0)+		; Put raw controller input (for held buttons) in F604/F606
		and.b	d0,d1
		move.b	d1,(a0)+		; Put pressed controller input in F605/F607
		rts
; End of function Poll_Controller


; =============== S U B R O U T I N E =======================================


Init_VDP:
		lea	(VDP_control_port).l,a0
		lea	(VDP_data_port).l,a1
		lea	(VDP_register_values).l,a2
		moveq	#19-1,d7

- ;$$setRegisters:
		move.w	(a2)+,(a0)
		dbf	d7,- ;$$setRegisters
		move.w	(VDP_register_values+2).l,d0	; get command for register #1
		move.w	d0,(VDP_reg_1_command).w	; and store it in RAM (for easy display blanking/enabling)
		move.w	#$8ADF,(H_int_counter_command).w
		moveq	#0,d0
		move.l	#vdpComm($0000,VSRAM,WRITE),(VDP_control_port).l
		move.w	d0,(a1)
		move.w	d0,(a1)
		move.l	#vdpComm($0000,CRAM,WRITE),(VDP_control_port).l
		move.w	#bytesToWcnt($80),d7

- ;$$clearCRAM:
		move.w	d0,(a1)
		dbf	d7,- ;$$clearCRAM
		clr.l	(V_scroll_value).w
		clr.l	(_unkF61A).w
		move.l	d1,-(sp)
		dmaFillVRAM 0,$0000,$10000	; clear entire VRAM
		move.l	(sp)+,d1
		rts
; End of function Init_VDP

; ---------------------------------------------------------------------------
VDP_register_values:
		dc.w $8004	; H-int disabled
		dc.w $8134	; V-int enabled, display blanked, DMA enabled, 224 line display
		dc.w $8230	; Scroll A PNT base $C000
		dc.w $8320	; Window PNT base $8000
		dc.w $8407	; Scroll B PNT base $E000
		dc.w $857C	; Sprite attribute table base $F800
		dc.w $8600
		dc.w $8700	; Backdrop color is color 0 of the first palette line
		dc.w $8800
		dc.w $8900
		dc.w $8A00
		dc.w $8B00	; Full-screen horizontal and vertical scrolling
		dc.w $8C81	; 40 cell wide display, no interlace
		dc.w $8D3C	; Horizontal scroll table base $F000
		dc.w $8E00
		dc.w $8F02	; Auto-increment is 2
		dc.w $9001	; Scroll planes are 64x32 cells
		dc.w $9100
		dc.w $9200	; Window disabled

; =============== S U B R O U T I N E =======================================


Clear_DisplayData:
		stopZ80
		dmaFillVRAM 0,$0000,$40

		tst.w	(Competition_mode).w
		beq.s	.No2P
		dmaFillVRAM 0,$8000,$4000
		bra.s	.Cont
; ---------------------------------------------------------------------------

.No2P:
		dmaFillVRAM 0,$C000,$1000	; clear plane A PNT
		dmaFillVRAM 0,$E000,$1000	; clear plane B PNT

.Cont:
		clr.l	(V_scroll_value).w
		clr.l	(_unkF61A).w
		; Bug: this should be $280
		clearRAM Sprite_table,$280+4
		; Bug: this should be $400
		clearRAM H_scroll_buffer,$400+4

		startZ80
		rts
; End of function Clear_DisplayData


; =============== S U B R O U T I N E =======================================


SndDrvInit:
		nop
		move.w	#$100,(Z80_bus_request).l
		move.w	#$100,(Z80_reset).l	; release Z80 reset

		; Load SMPS sound driver
		lea	(Z80_SoundDriver).l,a0
		lea	(Z80_RAM).l,a1
		move.w	#zDataStart-2,d0

- ;loc_1584:
		move.b	(a0)+,(a1)+
		dbf	d0,- ;loc_1584
		; Load default variables
		lea	(Z80_DefaultVariables).l,a0
		lea	(Z80_RAM+zDataStart).l,a1
		move.w	#Z80_DefaultVariables.end-Z80_DefaultVariables-1,d0

- ;loc_159A:
		move.b	(a0)+,(a1)+
		dbf	d0,- ;loc_159A
		; Detect PAL region consoles
		btst	#6,(Graphics_flags).w
		beq.s	+ ;loc_15B0
		move.b	#1,(Z80_RAM+$1C02).l

+ ;loc_15B0:
		move.w	#0,(Z80_reset).l	; reset Z80
		nop
		nop
		nop
		nop
		move.w	#$100,(Z80_reset).l	; release reset
		startZ80
		rts
; End of function SndDrvInit

; ---------------------------------------------------------------------------
; Default Z80 variables. These are actually set to more meaningful values
; in other SMPS Z80 drivers.
; ---------------------------------------------------------------------------
Z80_DefaultVariables:
		dc.b 0	; Unused 1
		dc.b 0	; Unused 2
		dc.b 0	; zPalFlag
		dc.b 0	; Unused 3
		dc.b 0	; zPalDblUpdCounter
		dc.b 0	; zSoundQueue0
		dc.b 0	; zSoundQueue1
		dc.b 0	; zSoundQueue2
		dc.b 0	; zTempoSpeedup
		dc.b 0	; zNextSound
		dc.b 0	; zMusicNumber
		dc.b 0	; zSFXNumber0
		dc.b 0	; zSFXNumber1
		dc.b 0	; zFadeOutTimeout
		dc.b 0	; zFadeDelay
		dc.b 0	; zFadeDelayTimeout
.end:

; ---------------------------------------------------------------------------
; Always replaces an index previous passed to this function
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Play_Music:
		stopZ80
		move.b	d0,(Z80_RAM+$1C0A).l
		startZ80
		rts
; End of function Play_Music

; ---------------------------------------------------------------------------
; plays a sound if the source object is on-screen
; unused/dead code, left over from Sonic 2

Play_SFX_Local:
		tst.b	render_flags(a0)
		bpl.s	Play_SFX.Done

; ---------------------------------------------------------------------------
; Can handle up to two different indexes in one frame
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Play_SFX:
		stopZ80
		cmp.b	(Z80_RAM+$1C0B).l,d0
		beq.s	++ ;loc_1642
		tst.b	(Z80_RAM+$1C0B).l
		bne.s	+ ;loc_163C
		move.b	d0,(Z80_RAM+$1C0B).l
		startZ80
		rts

+ ;loc_163C:
		move.b	d0,(Z80_RAM+$1C0C).l

+ ;loc_1642:
		startZ80

.Done:
		rts
; End of function Play_SFX


; =============== S U B R O U T I N E =======================================


Change_Music_Tempo:
		stopZ80
		move.b	d0,(Z80_RAM+$1C08).l
		startZ80
		rts
; End of function Change_Music_Tempo


; =============== S U B R O U T I N E =======================================


Pause_Game:
		nop
		tst.b	(Life_count).w
		beq.w	Pause_Unpause
		tst.w	(Game_paused).w
		bne.s	+ ;loc_168E
		move.b	(Ctrl_1_pressed).w,d0
		or.b	(Ctrl_2_pressed).w,d0
		andi.b	#$80,d0	; is Start pressed?
		beq.w	Pause_NoPause	; if not, branch

+ ;loc_168E:
		move.w	#1,(Game_paused).w
		stopZ80
		move.b	#1,(Z80_RAM+$1C10).l	; Pause the music
		startZ80

Pause_Loop:
		move.b	#$10,(V_int_routine).w
		bsr.w	Wait_VSync
		tst.b	(Slow_motion_flag).w
		beq.s	Pause_NoSlowMo
		btst	#button_A,(Ctrl_1_pressed).w
		beq.s	Pause_ChkFrameAdvance	; branch if A isn't pressed
		move.b	#$28,(Game_mode).w
		nop
		bra.s	Pause_ResumeMusic
; ---------------------------------------------------------------------------

Pause_ChkFrameAdvance:
		btst	#button_B,(Ctrl_1_held).w
		bne.s	Pause_FrameAdvance	; branch if B is held
		btst	#button_C,(Ctrl_1_pressed).w
		bne.s	Pause_FrameAdvance	; branch if C is pressed

Pause_NoSlowMo:
		cmpi.b	#$E,(Current_zone).w
		blo.s	Pause_ChkStart	; if the zone is below ALZ
		cmpi.b	#$12,(Current_zone).w
		bhi.s	Pause_ChkStart	; if the zone is above EMZ
		tst.b	(Competition_type).w
		bpl.s	Pause_ChkStart
		btst	#button_B,(Ctrl_1_pressed).w
		beq.s	Pause_ChkStart
		move.b	#$C0,(Game_mode).w	; If in time attack mode, go back to 2P menu if B is pressed
		bra.s	Pause_ResumeMusic
; ---------------------------------------------------------------------------

Pause_ChkStart:
		move.b	(Ctrl_1_pressed).w,d0
		or.b	(Ctrl_2_pressed).w,d0
		andi.b	#button_start_mask,d0
		beq.s	Pause_Loop

Pause_ResumeMusic:
		stopZ80
		move.b	#$80,(Z80_RAM+$1C10).l	; Unpause music
		startZ80

Pause_Unpause:
		move.w	#0,(Game_paused).w

Pause_NoPause:
		rts
; ---------------------------------------------------------------------------

Pause_FrameAdvance:
		move.w	#1,(Game_paused).w
		stopZ80
		move.b	#$80,(Z80_RAM+$1C10).l	; Unpause music
		startZ80
		rts	; advance by a single frame
; End of function Pause_Game

; ---------------------------------------------------------------------------
; Copies a plane map to a plane PNT
; Inputs:
; a1 = map address
; d0 = VDP command to write to the PNT
; d1 = number of cells in a row - 1
; d2 = number of cell rows - 1
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Plane_Map_To_VRAM:
		lea	(VDP_data_port).l,a6
		move.l	#$80<<16,d4	; row increment value

- ;loc_177C:
		move.l	d0,VDP_control_port-VDP_data_port(a6)
		move.w	d1,d3

- ;loc_1782:
		move.w	(a1)+,(a6)
		dbf	d3,- ;loc_1782	; copy one row
		add.l	d4,d0	; move onto next row
		dbf	d2,-- ;loc_177C	; and copy it
		rts
; End of function Plane_Map_To_VRAM

; ---------------------------------------------------------------------------
; Copies a plane map to a plane PNT, used for a 128-cell wide plane
; Inputs:
; a1 = map address
; d0 = VDP command to write to the PNT
; d1 = number of cells in a row - 1
; d2 = number of cell rows - 1
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Plane_Map_To_VRAM_2:
		lea	(VDP_data_port).l,a6
		move.l	#$100<<16,d4	; row increment value

- ;loc_179C:
		move.l	d0,VDP_control_port-VDP_data_port(a6)
		move.w	d1,d3

- ;loc_17A2:
		move.w	(a1)+,(a6)
		dbf	d3,- ;loc_17A2	; copy one row
		add.l	d4,d0	; move onto next row
		dbf	d2,-- ;loc_179C	; and copy it
		rts
; End of function Plane_Map_To_VRAM_2

; ---------------------------------------------------------------------------
; Adds art to the DMA queue
; Inputs:
; d1 = source address
; d2 = destination VRAM address
; d3 = number of words to transfer
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Add_To_DMA_Queue:
		movea.l	(DMA_queue_slot).w,a1
		cmpa.w	#DMA_queue_slot,a1	; is the queue full?
		beq.s	Add_To_DMA_Queue_Done	; if it is, return

		move.w	#$9300,d0
		move.b	d3,d0
		move.w	d0,(a1)+	; command to specify transfer length in words & $00FF

		move.w	#$9400,d0
		lsr.w	#8,d3
		move.b	d3,d0
		move.w	d0,(a1)+	; command to specify transfer length in words & $FF00

		move.w	#$9500,d0
		lsr.l	#1,d1
		move.b	d1,d0
		move.w	d0,(a1)+	; command to specify transfer source & $0001FE

		move.w	#$9600,d0
		lsr.l	#8,d1
		move.b	d1,d0
		move.w	d0,(a1)+	; command to specify transfer source & $01FE00

		move.w	#$9700,d0
		lsr.l	#8,d1
		andi.b	#$7F,d1		; this instruction safely allows source to be in RAM; S2's lacks this
		move.b	d1,d0
		move.w	d0,(a1)+	; command to specify transfer source & $FE0000

		andi.l	#$FFFF,d2
		lsl.l	#2,d2
		lsr.w	#2,d2
		swap	d2
		ori.l	#vdpComm($0000,VRAM,DMA),d2
		move.l	d2,(a1)+	; command to specify transfer destination and begin DMA

		move.l	a1,(DMA_queue_slot).w	; set new free slot address
		cmpa.w	#DMA_queue_slot,a1	; has the end of the queue been reached?
		beq.s	Add_To_DMA_Queue_Done	; if it has, branch
		move.w	#0,(a1)	; place stop token at the end of the queue

Add_To_DMA_Queue_Done:
		rts
; End of function Add_To_DMA_Queue


; =============== S U B R O U T I N E =======================================


Process_DMA_Queue:
		lea	(VDP_control_port).l,a5
		lea	(DMA_queue).w,a1

$$loop:
		move.w	(a1)+,d0	; has a stop token been encountered?
		beq.s	$$stop	; if it has, branch
		move.w	d0,(a5)
		move.w	(a1)+,(a5)
		move.w	(a1)+,(a5)
		move.w	(a1)+,(a5)
		move.w	(a1)+,(a5)
		move.w	(a1)+,(a5)
		move.w	(a1)+,(a5)
		cmpa.w	#DMA_queue_slot,a1	; has the end of the queue been reached?
		bne.s	$$loop	; if not, loop

$$stop:
		move.w	#0,(DMA_queue).w
		move.l	#DMA_queue,(DMA_queue_slot).w
		rts
; End of function Process_DMA_Queue

; ---------------------------------------------------------------------------
; Nemesis decompression subroutine, decompresses art directly to VRAM
; Inputs:
; a0 = art address
; a VDP command to write to the destination VRAM address must be issued
; before calling this routine
; See http://www.segaretro.org/Nemesis_compression for format description
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Nem_Decomp:
		movem.l	d0-a1/a3-a5,-(sp)
		lea	(Nem_PCD_WriteRowToVDP).l,a3
		lea	(VDP_data_port).l,a4	; write all rows to the VDP data port
		bra.s	Nem_Decomp_Main

; ---------------------------------------------------------------------------
; Nemesis decompression subroutine, decompresses art to RAM
; Inputs:
; a0 = art address
; a4 = destination RAM address
; ---------------------------------------------------------------------------


Nem_Decomp_To_RAM:
		movem.l	d0-a1/a3-a5,-(sp)
		lea	(Nem_PCD_WriteRowToRAM).l,a3

; ---------------------------------------------------------------------------
; Main Nemesis decompression subroutine
; ---------------------------------------------------------------------------


Nem_Decomp_Main:
		lea	(Nem_code_table).w,a1
		move.w	(a0)+,d2	; get number of patterns
		lsl.w	#1,d2
		bcc.s	+ ;loc_186E	; branch if the sign bit isn't set
		adda.w	#Nem_PCD_WriteRowToVDP_XOR-Nem_PCD_WriteRowToVDP,a3	; otherwise the file uses XOR mode

+ ;loc_186E:
		lsl.w	#2,d2	; get number of 8-pixel rows in the uncompressed data
		movea.w	d2,a5	; and store it in a5 because there aren't any spare data registers
		moveq	#8,d3	; 8 pixels in a pattern row
		moveq	#0,d2
		moveq	#0,d4
		bsr.w	Nem_Build_Code_Table
		move.b	(a0)+,d5	; get first byte of compressed data
		asl.w	#8,d5	; shift up by a byte
		move.b	(a0)+,d5	; get second byte of compressed data
		move.w	#$10,d6	; set initial shift value
		bsr.s	Nem_Process_Compressed_Data
		movem.l	(sp)+,d0-a1/a3-a5
		rts

; ---------------------------------------------------------------------------
; Part of the Nemesis decompressor, processes the actual compressed data
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================

; PCD is used throughout this subroutine as an initialism for Process_Compressed_Data
Nem_Process_Compressed_Data:
		move.w	d6,d7
		subq.w	#8,d7	; get shift value
		move.w	d5,d1
		lsr.w	d7,d1	; shift so that high bit of the code is in bit position 7
		cmpi.b	#%11111100,d1	; are the high 6 bits set?
		bhs.s	Nem_PCD_InlineData	; if they are, it signifies inline data
		andi.w	#$FF,d1
		add.w	d1,d1
		move.b	(a1,d1.w),d0	; get the length of the code in bits
		ext.w	d0
		sub.w	d0,d6	; subtract from shift value so that the next code is read next time around
		cmpi.w	#9,d6	; does a new byte need to be read?
		bhs.s	+ ;loc_18B6	; if not, branch
		addq.w	#8,d6
		asl.w	#8,d5
		move.b	(a0)+,d5	; read next byte

+ ;loc_18B6:
		move.b	1(a1,d1.w),d1
		move.w	d1,d0
		andi.w	#$F,d1	; get palette index for pixel
		andi.w	#$F0,d0

Nem_PCD_GetRepeatCount:
		lsr.w	#4,d0	; get repeat count

- ;Nem_PCD_WritePixel:
		lsl.l	#4,d4	; shift up by a nybble
		or.b	d1,d4	; write pixel
		subq.w	#1,d3	; has an entire 8-pixel row been written?
		bne.s	Nem_PCD_WritePixel_Loop	; if not, loop
		jmp	(a3)	; otherwise, write the row to its destination
; ---------------------------------------------------------------------------

Nem_PCD_NewRow:
		moveq	#0,d4	; reset row
		moveq	#8,d3	; reset nybble counter

Nem_PCD_WritePixel_Loop:
		dbf	d0,- ;Nem_PCD_WritePixel
		bra.s	Nem_Process_Compressed_Data
; ---------------------------------------------------------------------------

Nem_PCD_InlineData:
		subq.w	#6,d6	; 6 bits needed to signal inline data
		cmpi.w	#9,d6
		bhs.s	+ ;loc_18E8
		addq.w	#8,d6
		asl.w	#8,d5
		move.b	(a0)+,d5

+ ;loc_18E8:
		subq.w	#7,d6	; and 7 bits needed for the inline data itself
		move.w	d5,d1
		lsr.w	d6,d1	; shift so that low bit of the code is in bit position 0
		move.w	d1,d0
		andi.w	#$F,d1	; get palette index for pixel
		andi.w	#$70,d0	; high nybble is repeat count for pixel
		cmpi.w	#9,d6
		bhs.s	Nem_PCD_GetRepeatCount
		addq.w	#8,d6
		asl.w	#8,d5
		move.b	(a0)+,d5
		bra.s	Nem_PCD_GetRepeatCount
; ---------------------------------------------------------------------------

Nem_PCD_WriteRowToVDP:
		move.l	d4,(a4)	; write 8-pixel row
		subq.w	#1,a5
		move.w	a5,d4	; have all the 8-pixel rows been written?
		bne.s	Nem_PCD_NewRow	; if not, branch
		rts	; otherwise the decompression is finished
; ---------------------------------------------------------------------------

Nem_PCD_WriteRowToVDP_XOR:
		eor.l	d4,d2	; XOR the previous row by the current row
		move.l	d2,(a4)	; and write the result
		subq.w	#1,a5
		move.w	a5,d4
		bne.s	Nem_PCD_NewRow
		rts
; ---------------------------------------------------------------------------

Nem_PCD_WriteRowToRAM:
		move.l	d4,(a4)+
		subq.w	#1,a5
		move.w	a5,d4
		bne.s	Nem_PCD_NewRow
		rts
; ---------------------------------------------------------------------------

Nem_PCD_WriteRowToRAM_XOR:
		eor.l	d4,d2
		move.l	d2,(a4)+
		subq.w	#1,a5
		move.w	a5,d4
		bne.s	Nem_PCD_NewRow
		rts

; ---------------------------------------------------------------------------
; Part of the Nemesis decompressor, builds the code table (in RAM)
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================

; BCT is used throughout this subroutine as an initialism for Build_Code_Table
Nem_Build_Code_Table:
		move.b	(a0)+,d0	; read first byte

Nem_BCT_ChkEnd:
		cmpi.b	#$FF,d0	; has the end of the code table description been reached?
		bne.s	Nem_BCT_NewPalIndex	; if not, branch
		rts	; otherwise, this subroutine's work is done
; ---------------------------------------------------------------------------

Nem_BCT_NewPalIndex:
		move.w	d0,d7

Nem_BCT_Loop:
		move.b	(a0)+,d0	; read next byte
		cmpi.b	#$80,d0	; sign bit being set signifies a new palette index
		bhs.s	Nem_BCT_ChkEnd	; a bmi could have been used instead of a compare and bcc
		move.b	d0,d1
		andi.w	#$F,d7	; get palette index
		andi.w	#$70,d1	; get repeat count for palette index
		or.w	d1,d7	; combine the two
		andi.w	#$F,d0	; get the length of the code in bits
		move.b	d0,d1
		lsl.w	#8,d1
		or.w	d1,d7	; combine with palette index and repeat count to form code table entry
		moveq	#8,d1
		sub.w	d0,d1	; is the code 8 bits long?
		bne.s	Nem_BCT_ShortCode	; if not, a bit of extra processing is needed
		move.b	(a0)+,d0	; get code
		add.w	d0,d0	; each code gets a word-sized entry in the table
		move.w	d7,(a1,d0.w)	; store the entry for the code
		bra.s	Nem_BCT_Loop	; repeat
; ---------------------------------------------------------------------------

; the Nemesis decompressor uses prefix-free codes (no valid code is a prefix of a longer code)
; e.g. if 10 is a valid 2-bit code, 110 is a valid 3-bit code but 100 isn't
; also, when the actual compressed data is processed the high bit of each code is in bit position 7
; so the code needs to be bit-shifted appropriately over here before being used as a code table index
; additionally, the code needs multiple entries in the table because no masking is done during compressed data processing
; so if 11000 is a valid code then all indices of the form 11000XXX need to have the same entry
Nem_BCT_ShortCode:
		move.b	(a0)+,d0	; get code
		lsl.w	d1,d0	; shift so that high bit is in bit position 7
		add.w	d0,d0	; get index into code table
		moveq	#1,d5
		lsl.w	d1,d5
		subq.w	#1,d5	; d5 = 2^d1 - 1

- ;Nem_BCT_ShortCode_Loop:
		move.w	d7,(a1,d0.w)	; store entry
		addq.w	#2,d0	; increment index
		dbf	d5,- ;Nem_BCT_ShortCode_Loop	; repeat for required number of entries
		bra.s	Nem_BCT_Loop
; End of function Nem_Build_Code_Table

; ---------------------------------------------------------------------------
; Adds pattern load requests to the Nemesis decompression queue
; Input: d0 = ID of the PLC to load
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Load_PLC:
		movem.l	a1-a2,-(sp)
		lea	(Offs_PLC).l,a1
		add.w	d0,d0
		move.w	(a1,d0.w),d0
		lea	(a1,d0.w),a1
		lea	(Nem_decomp_queue).w,a2

$$findFreeSlot:
		tst.l	(a2)	; is the current slot in the queue free?
		beq.s	$$getPieceCount	; if it is, branch
		addq.w	#6,a2	; otherwise check the next slot
		bra.s	$$findFreeSlot
; ---------------------------------------------------------------------------

$$getPieceCount:
		move.w	(a1)+,d0
		bmi.s	$$done

$$queuePieces:
		move.l	(a1)+,(a2)+	; store compressed data location
		move.w	(a1)+,(a2)+	; store destination in VRAM
		dbf	d0,$$queuePieces

$$done:
		movem.l	(sp)+,a1-a2
		rts
; End of function Load_PLC

; ---------------------------------------------------------------------------
; Loads a raw PLC from ROM
; Input: a1 = address of the PLC
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Load_PLC_Raw:
		lea	(Nem_decomp_queue).w,a2

$$findFreeSlot:
		tst.l	(a2)
		beq.s	$$getPieceCount
		addq.w	#6,a2
		bra.s	$$findFreeSlot
; ---------------------------------------------------------------------------

$$getPieceCount:
		move.w	(a1)+,d0
		bmi.s	$$done

$$queuePieces:
		move.l	(a1)+,(a2)+
		move.w	(a1)+,(a2)+
		dbf	d0,$$queuePieces

$$done:
		rts
; End of function Load_PLC_Raw

; ---------------------------------------------------------------------------
; Adds pattern load requests to the Nemesis decompression queue
; Differs from Load_PLC in that it clears the queue before loading
; Input: d0 = ID of the PLC to load
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Load_PLC_2:
		movem.l	a1-a2,-(sp)		; This differs from Load_PLC in that it overrides any PLCs already in the queue
		lea	(Offs_PLC).l,a1
		add.w	d0,d0
		move.w	(a1,d0.w),d0
		lea	(a1,d0.w),a1
		bsr.s	Clear_Nem_Queue
		lea	(Nem_decomp_queue).w,a2
		move.w	(a1)+,d0
		bmi.s	$$done

$$queuePieces:
		move.l	(a1)+,(a2)+
		move.w	(a1)+,(a2)+
		dbf	d0,$$queuePieces

$$done:
		movem.l	(sp)+,a1-a2
		rts
; End of function Load_PLC_2

; ---------------------------------------------------------------------------
; Clears the Nemesis decompression queue and its associated variables
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Clear_Nem_Queue:
		lea	(Nem_decomp_queue).w,a2
		moveq	#bytesToLcnt($80),d0	; clear till the end of Nem_decomp_vars

$$loop:
		clr.l	(a2)+
		dbf	d0,$$loop
		rts
; End of function Clear_Nem_Queue

; ---------------------------------------------------------------------------
; Initializes Nemesis decompression queue processing
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Process_Nem_Queue_Init:
		tst.l	(Nem_decomp_queue).w
		beq.s	.locret_1A60	; return if the queue is empty
		tst.w	(Nem_patterns_left).w
		bne.s	.locret_1A60	; return if processing of a previous piece is still going on
		movea.l	(Nem_decomp_queue).w,a0
		lea	(Nem_PCD_WriteRowToVDP).l,a3
		nop
		lea	(Nem_code_table).w,a1
		move.w	(a0)+,d2
		bpl.s	+ ;loc_1A2E
		adda.w	#Nem_PCD_WriteRowToVDP_XOR-Nem_PCD_WriteRowToVDP,a3

+ ;loc_1A2E:
		andi.w	#$7FFF,d2
		bsr.w	Nem_Build_Code_Table
		move.b	(a0)+,d5
		asl.w	#8,d5
		move.b	(a0)+,d5
		moveq	#$10,d6
		moveq	#0,d0
		move.l	a0,(Nem_decomp_queue).w
		move.l	a3,(Nem_decomp_vars).w
		move.l	d0,(Nem_repeat_count).w
		move.l	d0,(Nem_palette_index).w
		move.l	d0,(Nem_previous_row).w
		move.l	d5,(Nem_data_word).w
		move.l	d6,(Nem_shift_value).w
		move.w	d2,(Nem_patterns_left).w

.locret_1A60:
		rts
; End of function Process_Nem_Queue_Init

; ---------------------------------------------------------------------------
; Processes the first piece on the Nemesis decompression queue
; Decompresses 6 patterns per frame
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Process_Nem_Queue:
		tst.w	(Nem_patterns_left).w
		beq.w	Process_Nem_Queue_Done
		move.w	#6,(Nem_frame_patterns_left).w	; decompress 6 patterns per frame
		moveq	#0,d0
		move.w	(Nem_decomp_destination).w,d0
		addi.w	#6*$20,(Nem_decomp_destination).w	; increment by 6 patterns' worth of data
		bra.s	Process_Nem_Queue_Main
; End of function Process_Nem_Queue

; ---------------------------------------------------------------------------
; Processes the first piece on the Nemesis decompression queue
; Decompresses 3 patterns per frame
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Process_Nem_Queue_2:
		tst.w	(Nem_patterns_left).w
		beq.s	Process_Nem_Queue_Done
		move.w	#3,(Nem_frame_patterns_left).w	; decompress 3 patterns per frame
		moveq	#0,d0
		move.w	(Nem_decomp_destination).w,d0
		addi.w	#3*$20,(Nem_decomp_destination).w	; increment by 3 patterns' worth of data
; End of function Process_Nem_Queue_2

; ---------------------------------------------------------------------------
; Main Nemesis decompression queue processor
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Process_Nem_Queue_Main:
		lea	(VDP_control_port).l,a4
		lsl.l	#2,d0
		lsr.w	#2,d0
		ori.w	#$4000,d0
		swap	d0	; d0 = VDP command word to write to VRAM destination
		move.l	d0,(a4)
		subq.w	#VDP_control_port-VDP_data_port,a4	; a4 = VDP_data_port
		movea.l	(Nem_decomp_queue).w,a0
		movea.l	(Nem_decomp_vars).w,a3
		move.l	(Nem_repeat_count).w,d0
		move.l	(Nem_palette_index).w,d1
		move.l	(Nem_previous_row).w,d2
		move.l	(Nem_data_word).w,d5
		move.l	(Nem_shift_value).w,d6
		lea	(Nem_code_table).w,a1

Process_Nem_Queue_Loop:
		movea.w	#8,a5	; decompress all 8 rows in a pattern
		bsr.w	Nem_PCD_NewRow
		subq.w	#1,(Nem_patterns_left).w	; have all the patterns been decompressed?
		beq.s	Process_Nem_Queue_ShiftUp	; if yes, shift all other queue entries up
		subq.w	#1,(Nem_frame_patterns_left).w	; has the current frame's worth of patterns been decompressed?
		bne.s	Process_Nem_Queue_Loop	; if not, loop
		move.l	a0,(Nem_decomp_queue).w
		move.l	a3,(Nem_decomp_vars).w
		move.l	d0,(Nem_repeat_count).w
		move.l	d1,(Nem_palette_index).w
		move.l	d2,(Nem_previous_row).w
		move.l	d5,(Nem_data_word).w
		move.l	d6,(Nem_shift_value).w

Process_Nem_Queue_Done:
		rts
; ---------------------------------------------------------------------------

; Bug: filling in all $10 slots is dangerous because this routine
; doesn't copy the VRAM location for the last entry in the queue,
; nor does it mark the last slot in the queue as clear
Process_Nem_Queue_ShiftUp:
		lea	(Nem_decomp_queue).w,a0
		moveq	#$16-1,d0

- ;.loop:
		move.l	6(a0),(a0)+
		dbf	d0,- ;.loop
		rts
; End of function Process_Nem_Queue_Main

; ---------------------------------------------------------------------------
		lea	(Offs_PLC).l,a1
		add.w	d0,d0
		move.w	(a1,d0.w),d0
		lea	(a1,d0.w),a1
		move.w	(a1)+,d1

; ---------------------------------------------------------------------------
; Loads a raw PLC from the ROM and decompresses it immediately
; Input: a1 = the address of the PLC
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Load_PLC_Immediate:
$$decompPieces:
		movea.l	(a1)+,a0	; get source address
		moveq	#0,d0
		move.w	(a1)+,d0	; get destination VRAM address
		lsl.l	#2,d0
		lsr.w	#2,d0
		ori.w	#$4000,d0
		swap	d0	; d0 = VDP command to write to destination
		move.l	d0,(VDP_control_port).l
		bsr.w	Nem_Decomp
		dbf	d1,$$decompPieces
		rts
; End of function Load_PLC_Immediate

; ---------------------------------------------------------------------------
; Enigma decompression subroutine
; Inputs:
; a0 = compressed data location
; a1 = destination (in RAM)
; d0 = starting art tile
; See http://www.segaretro.org/Enigma_compression for format description
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Eni_Decomp:
		movem.l	d0-d7/a1-a5,-(sp)
		movea.w	d0,a3	; store starting art tile
		move.b	(a0)+,d0
		ext.w	d0
		movea.w	d0,a5	; store number of bits in inline copy value
		move.b	(a0)+,d4
		lsl.b	#3,d4	; store PCCVH flags bitfield
		movea.w	(a0)+,a2
		adda.w	a3,a2	; store incremental copy word
		movea.w	(a0)+,a4
		adda.w	a3,a4	; store literal copy word
		move.b	(a0)+,d5
		asl.w	#8,d5
		move.b	(a0)+,d5	; get first word in format list
		moveq	#$10,d6		; initial shift value

Eni_Decomp_Loop:
		moveq	#7,d0	; assume a format list entry is 7 bits
		move.w	d6,d7
		sub.w	d0,d7
		move.w	d5,d1
		lsr.w	d7,d1
		andi.w	#$7F,d1	; get format list entry
		move.w	d1,d2	; and copy it
		cmpi.w	#$40,d1	; is the high bit of the entry set?
		bhs.s	+ ;loc_1B78
		moveq	#6,d0	; if it isn't, the entry is actually 6 bits
		lsr.w	#1,d2

+ ;loc_1B78:
		bsr.w	Eni_Decomp_FetchByte
		andi.w	#$F,d2	; get repeat count
		lsr.w	#4,d1
		add.w	d1,d1
		jmp	Eni_Decomp_Index(pc,d1.w)
; ---------------------------------------------------------------------------

Eni_Decomp_00:
		move.w	a2,(a1)+	; copy incremental copy word
		addq.w	#1,a2	; increment it
		dbf	d2,Eni_Decomp_00	; repeat
		bra.s	Eni_Decomp_Loop
; ---------------------------------------------------------------------------

Eni_Decomp_01:
		move.w	a4,(a1)+	; copy literal copy word
		dbf	d2,Eni_Decomp_01	; repeat
		bra.s	Eni_Decomp_Loop
; ---------------------------------------------------------------------------

Eni_Decomp_100:
		bsr.w	Eni_Decomp_FetchInlineValue

$$loop:
		move.w	d1,(a1)+	; copy inline value
		dbf	d2,$$loop	; repeat
		bra.s	Eni_Decomp_Loop
; ---------------------------------------------------------------------------

Eni_Decomp_101:
		bsr.w	Eni_Decomp_FetchInlineValue

$$loop:
		move.w	d1,(a1)+	; copy inline value
		addq.w	#1,d1	; increment
		dbf	d2,$$loop	; repeat
		bra.s	Eni_Decomp_Loop
; ---------------------------------------------------------------------------

Eni_Decomp_110:
		bsr.w	Eni_Decomp_FetchInlineValue

$$loop:
		move.w	d1,(a1)+	; copy inline value
		subq.w	#1,d1	; decrement
		dbf	d2,$$loop	; repeat
		bra.s	Eni_Decomp_Loop
; ---------------------------------------------------------------------------

Eni_Decomp_111:
		cmpi.w	#$F,d2
		beq.s	Eni_Decomp_Done

$$loop:
		bsr.w	Eni_Decomp_FetchInlineValue	; fetch new inline value
		move.w	d1,(a1)+	; copy it
		dbf	d2,$$loop	; and repeat
		bra.s	Eni_Decomp_Loop
; ---------------------------------------------------------------------------

Eni_Decomp_Index:
		bra.s	Eni_Decomp_00
; ---------------------------------------------------------------------------
		bra.s	Eni_Decomp_00
; ---------------------------------------------------------------------------
		bra.s	Eni_Decomp_01
; ---------------------------------------------------------------------------
		bra.s	Eni_Decomp_01
; ---------------------------------------------------------------------------
		bra.s	Eni_Decomp_100
; ---------------------------------------------------------------------------
		bra.s	Eni_Decomp_101
; ---------------------------------------------------------------------------
		bra.s	Eni_Decomp_110
; ---------------------------------------------------------------------------
		bra.s	Eni_Decomp_111
; ---------------------------------------------------------------------------

Eni_Decomp_Done:
		subq.w	#1,a0	; go back by one byte
		cmpi.w	#$10,d6
		bne.s	+ ;loc_1BEE
		subq.w	#1,a0	; and another one if needed

+ ;loc_1BEE:
		move.w	a0,d0
		lsr.w	#1,d0
		bcc.s	+ ;loc_1BF6
		addq.w	#1,a0	; make sure it's an even address

+ ;loc_1BF6:
		movem.l	(sp)+,d0-d7/a1-a5
		rts
; End of function Eni_Decomp

; ---------------------------------------------------------------------------
; Part of the Enigma decompressor
; Fetches an inline copy value and stores it in d1
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Eni_Decomp_FetchInlineValue:
		move.w	a3,d3	; copy starting art tile
		move.b	d4,d1	; copy PCCVH bitfield
		add.b	d1,d1	; is the priority bit set?
		bcc.s	+ ;loc_1C0E	; if not, branch
		subq.w	#1,d6
		btst	d6,d5	; is the priority bit set in the inline render flags?
		beq.s	+ ;loc_1C0E	; if not, branch
		ori.w	#$8000,d3	; otherwise set priority bit in art tile

+ ;loc_1C0E:
		add.b	d1,d1	; is the high palette line bit set?
		bcc.s	+ ;loc_1C1C	; if not, branch
		subq.w	#1,d6
		btst	d6,d5
		beq.s	+ ;loc_1C1C
		addi.w	#$4000,d3

+ ;loc_1C1C:
		add.b	d1,d1	; is the low palette line bit set?
		bcc.s	+ ;loc_1C2A	; if not, branch
		subq.w	#1,d6
		btst	d6,d5
		beq.s	+ ;loc_1C2A
		addi.w	#$2000,d3

+ ;loc_1C2A:
		add.b	d1,d1	; is the vertical flip flag set?
		bcc.s	+ ;loc_1C38	; if not, branch
		subq.w	#1,d6
		btst	d6,d5
		beq.s	+ ;loc_1C38
		ori.w	#$1000,d3

+ ;loc_1C38:
		add.b	d1,d1	; is the horizontal flip flag set?
		bcc.s	+ ;loc_1C46	; if not, branch
		subq.w	#1,d6
		btst	d6,d5
		beq.s	+ ;loc_1C46
		ori.w	#$800,d3

+ ;loc_1C46:
		move.w	d5,d1
		move.w	d6,d7
		sub.w	a5,d7	; subtract length in bits of inline copy value
		bcc.s	$$enoughBits	; branch if a new word doesn't need to be read
		move.w	d7,d6
		addi.w	#$10,d6
		neg.w	d7	; calculate bit deficit
		lsl.w	d7,d1	; and make space for that many bits
		move.b	(a0),d5	; get next byte
		rol.b	d7,d5	; and rotate the required bits into the lowest positions
		add.w	d7,d7
		and.w	Eni_Decomp_Masks-2(pc,d7.w),d5
		add.w	d5,d1	; combine upper bits with lower bits

$$maskValue:
		move.w	a5,d0	; get length in bits of inline copy value
		add.w	d0,d0
		and.w	Eni_Decomp_Masks-2(pc,d0.w),d1	; mask value appropriately
		add.w	d3,d1	; add starting art tile
		move.b	(a0)+,d5
		lsl.w	#8,d5
		move.b	(a0)+,d5	; get next word
		rts
; ---------------------------------------------------------------------------

$$enoughBits:
		beq.s	$$justEnough	; if the word has been exactly exhausted, branch
		lsr.w	d7,d1	; get inline copy value
		move.w	a5,d0
		add.w	d0,d0
		and.w	Eni_Decomp_Masks-2(pc,d0.w),d1	; and mask it appropriately
		add.w	d3,d1	; add starting art tile
		move.w	a5,d0
		bra.s	Eni_Decomp_FetchByte
; ---------------------------------------------------------------------------

$$justEnough:
		moveq	#$10,d6	; reset shift value
		bra.s	$$maskValue
; End of function Eni_Decomp_FetchInlineValue

; ---------------------------------------------------------------------------
Eni_Decomp_Masks:
		dc.w     1
		dc.w     3
		dc.w     7
		dc.w    $F
		dc.w   $1F
		dc.w   $3F
		dc.w   $7F
		dc.w   $FF
		dc.w  $1FF
		dc.w  $3FF
		dc.w  $7FF
		dc.w  $FFF
		dc.w $1FFF
		dc.w $3FFF
		dc.w $7FFF
		dc.w $FFFF
; ---------------------------------------------------------------------------
; Part of the Enigma decompressor, fetches the next byte if needed
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Eni_Decomp_FetchByte:
		sub.w	d0,d6	; subtract length of current entry from shift value so that next entry is read next time around
		cmpi.w	#9,d6	; does a new byte need to be read?
		bhs.s	.locret_1CBA	; if not, branch
		addq.w	#8,d6
		asl.w	#8,d5
		move.b	(a0)+,d5

.locret_1CBA:
		rts
; End of function Eni_Decomp_FetchByte

; ---------------------------------------------------------------------------
; Kosinski decompression subroutine
; Inputs:
; a0 = compressed data location
; a1 = destination
; See http://www.segaretro.org/Kosinski_compression for format description
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Kos_Decomp:
		subq.l	#2,sp	; make space for two bytes on the stack
		move.b	(a0)+,1(sp)
		move.b	(a0)+,(sp)
		move.w	(sp),d5	; copy first description field
		moveq	#$F,d4	; 16 bits in a byte

Kos_Decomp_Loop:
		lsr.w	#1,d5	; bit which is shifted out goes into C flag
		move	sr,d6
		dbf	d4,Kos_Decomp_ChkBit
		move.b	(a0)+,1(sp)
		move.b	(a0)+,(sp)
		move.w	(sp),d5	; get next description field if needed
		moveq	#$F,d4	; reset bit counter

Kos_Decomp_ChkBit:
		move	d6,ccr	; was the bit set?
		bcc.s	Kos_Decomp_Match	; if not, branch (C flag clear means bit was clear)
		move.b	(a0)+,(a1)+	; otherwise, copy byte as-is
		bra.s	Kos_Decomp_Loop
; ---------------------------------------------------------------------------

Kos_Decomp_Match:
		moveq	#0,d3
		lsr.w	#1,d5	; get next bit
		move	sr,d6
		dbf	d4,Kos_Decomp_ChkBit2
		move.b	(a0)+,1(sp)
		move.b	(a0)+,(sp)
		move.w	(sp),d5
		moveq	#$F,d4

Kos_Decomp_ChkBit2:
		move	d6,ccr	; was the bit set?
		bcs.s	Kos_Decomp_FullMatch	; if it was, branch
		lsr.w	#1,d5	; bit which is shifted out goes into X flag
		dbf	d4,+ ;loc_1D0A
		move.b	(a0)+,1(sp)
		move.b	(a0)+,(sp)
		move.w	(sp),d5
		moveq	#$F,d4

+ ;loc_1D0A:
		roxl.w	#1,d3	; get high repeat count bit (shift X flag in)
		lsr.w	#1,d5
		dbf	d4,+ ;loc_1D1C
		move.b	(a0)+,1(sp)
		move.b	(a0)+,(sp)
		move.w	(sp),d5
		moveq	#$F,d4

+ ;loc_1D1C:
		roxl.w	#1,d3	; get low repeat count bit
		addq.w	#1,d3	; increment repeat count
		moveq	#-1,d2
		move.b	(a0)+,d2	; calculate offset
		bra.s	Kos_Decomp_MatchLoop
; ---------------------------------------------------------------------------

Kos_Decomp_FullMatch:
		move.b	(a0)+,d0	; get first byte
		move.b	(a0)+,d1	; get second byte
		moveq	#-1,d2
		move.b	d1,d2
		lsl.w	#5,d2
		move.b	d0,d2	; calculate offset
		andi.w	#7,d1	; does a third byte need to be read?
		beq.s	Kos_Decomp_FullMatch2	; if it does, branch
		move.b	d1,d3	; copy repeat count
		addq.w	#1,d3	; and increment it

Kos_Decomp_MatchLoop:
		move.b	(a1,d2.w),d0
		move.b	d0,(a1)+	; copy appropriate byte
		dbf	d3,Kos_Decomp_MatchLoop	; and repeat the copying
		bra.s	Kos_Decomp_Loop
; ---------------------------------------------------------------------------

Kos_Decomp_FullMatch2:
		move.b	(a0)+,d1
		beq.s	Kos_Decomp_Done	; 0 indicates end of compressed data
		cmpi.b	#1,d1
		beq.w	Kos_Decomp_Loop	; 1 indicates a new description needs to be read
		move.b	d1,d3	; otherwise, copy repeat count
		bra.s	Kos_Decomp_MatchLoop
; ---------------------------------------------------------------------------

Kos_Decomp_Done:
		addq.l	#2,sp	; restore stack pointer to original state
		rts
; End of function Kos_Decomp

; ---------------------------------------------------------------------------
; Adds a Kosinski Moduled archive to the module queue
; Inputs:
; a1 = address of the archive
; d2 = destination in VRAM
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Queue_Kos_Module:
		lea	(Kos_module_queue).w,a2
		tst.l	(a2)	; is the first slot free?
		beq.s	Process_Kos_Module_Queue_Init	; if it is, branch
		addq.w	#6,a2	; otherwise, check next slot

$$findFreeSlot:
		tst.l	(a2)
		beq.s	$$freeSlotFound
		addq.w	#6,a2
		bra.s	$$findFreeSlot
; ---------------------------------------------------------------------------

$$freeSlotFound:
		move.l	a1,(a2)+	; store source address
		move.w	d2,(a2)+	; store destination VRAM address
		rts
; End of function Queue_Kos_Module

; ---------------------------------------------------------------------------
; Initializes processing of the first module on the queue
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Process_Kos_Module_Queue_Init:
		move.w	(a1)+,d3	; get uncompressed size
		cmpi.w	#$A000,d3
		bne.s	+ ;loc_1D80
		move.w	#$8000,d3	; $A000 means $8000 for some reason

+ ;loc_1D80:
		lsr.w	#1,d3
		move.w	d3,d0
		rol.w	#5,d0
		andi.w	#$1F,d0	; get number of complete modules
		move.b	d0,(Kos_modules_left).w
		andi.l	#$7FF,d3	; get size of last module in words
		bne.s	+ ;loc_1DA0	; branch if it's non-zero
		subq.b	#1,(Kos_modules_left).w	; otherwise decrement the number of modules
		move.l	#$800,d3	; and take the size of the last module to be $800 words

+ ;loc_1DA0:
		move.w	d3,(Kos_last_module_size).w
		move.w	d2,(Kos_module_destination).w
		move.l	a1,(Kos_module_queue).w
		addq.b	#1,(Kos_modules_left).w	; store total number of modules
		rts
; End of function Process_Kos_Module_Queue_Init

; ---------------------------------------------------------------------------
; Processes the first module on the queue
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Process_Kos_Module_Queue:
		tst.b	(Kos_modules_left).w
		bne.s	$$modulesLeft

$$done:
		rts
; ---------------------------------------------------------------------------

$$modulesLeft:
		bmi.s	$$decompressionStarted
		cmpi.w	#4,(Kos_decomp_queue_count).w
		bhs.s	$$done	; branch if the Kosinski decompression queue is full
		movea.l	(Kos_module_queue).w,a1
		lea	(Kos_decomp_buffer).w,a2
		bsr.w	Queue_Kos	; add current module to decompression queue
		ori.b	#$80,(Kos_modules_left).w	; and set bit to signify decompression in progress
		rts
; ---------------------------------------------------------------------------

$$decompressionStarted:
		tst.w	(Kos_decomp_queue_count).w
		bne.s	$$done	; branch if the decompression isn't complete

		; otherwise, DMA the decompressed data to VRAM
		andi.b	#$7F,(Kos_modules_left).w
		move.l	#$800,d3
		subq.b	#1,(Kos_modules_left).w
		bne.s	+ ;loc_1DF4	; branch if it isn't the last module
		move.w	(Kos_last_module_size).w,d3

+ ;loc_1DF4:
		move.w	(Kos_module_destination).w,d2
		move.w	d2,d0
		add.w	d3,d0
		add.w	d3,d0
		move.w	d0,(Kos_module_destination).w	; set new destination
		move.l	(Kos_module_queue).w,d0
		move.l	(Kos_decomp_queue).w,d1
		sub.l	d1,d0
		andi.l	#$F,d0
		add.l	d0,d1	; round to the nearest $10 boundary
		move.l	d1,(Kos_module_queue).w	; and set new source
		move.l	#Kos_decomp_buffer,d1
		andi.l	#$FFFFFF,d1
		jsr	(Add_To_DMA_Queue).l
		tst.b	(Kos_modules_left).w
		bne.s	.locret_1E60	; return if this wasn't the last module
		lea	(Kos_module_queue).w,a0
		lea	(Kos_module_queue+6).w,a1
		move.l	(a1)+,(a0)+	; otherwise, shift all entries up
		move.w	(a1)+,(a0)+
		move.l	(a1)+,(a0)+
		move.w	(a1)+,(a0)+
		move.l	(a1)+,(a0)+
		move.w	(a1)+,(a0)+
		move.l	#0,(a0)+	; and mark the last slot as free
		move.w	#0,(a0)+
		move.l	(Kos_module_queue).w,d0
		beq.s	.locret_1E60	; return if the queue is now empty
		movea.l	d0,a1
		move.w	(Kos_module_destination).w,d2
		jmp	(Process_Kos_Module_Queue_Init).l

.locret_1E60:
		rts
; End of function Process_Kos_Module_Queue

; ---------------------------------------------------------------------------
; Adds Kosinski-compressed data to the decompression queue
; Inputs:
; a1 = compressed data address
; a2 = decompression destination in RAM
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Queue_Kos:
		move.w	(Kos_decomp_queue_count).w,d0
		lsl.w	#3,d0
		lea	(Kos_decomp_queue).w,a3
		move.l	a1,(a3,d0.w)	; store source
		move.l	a2,4(a3,d0.w)	; store destination
		addq.w	#1,(Kos_decomp_queue_count).w
		rts
; End of function Queue_Kos

; ---------------------------------------------------------------------------
; Checks if V-int occured in the middle of Kosinski queue processing
; and stores the location from which processing is to resume if it did
; ---------------------------------------------------------------------------


Set_Kos_Bookmark:
		tst.w	(Kos_decomp_queue_count).w
		bpl.s	.return	; branch if decompression wasn't in progress
		move.l	$42(sp),d0	; check address V-int is supposed to rte to
		cmpi.l	#Process_Kos_Queue_Main,d0
		blo.s	.return
		cmpi.l	#Process_Kos_Queue_Done,d0
		bhs.s	.return
		move.l	$42(sp),(Kos_decomp_bookmark).w
		move.l	#Backup_Kos_Registers,$42(sp)	; force V-int to rte here instead if needed

.return:
		rts

; ---------------------------------------------------------------------------
; Processes the first entry in the Kosinski decompression queue
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Process_Kos_Queue:
		tst.w	(Kos_decomp_queue_count).w
		beq.w	Process_Kos_Queue_Done
		bmi.w	Restore_Kos_Bookmark	; branch if decompression was interrupted by V-int

Process_Kos_Queue_Main:
		ori.w	#$8000,(Kos_decomp_queue_count).w	; set sign bit to signify decompression in progress
		movea.l	(Kos_decomp_queue).w,a0
		movea.l	(Kos_decomp_destination).w,a1

		; what follows is identical to the normal Kosinski decompressor except for using Kos_description_field instead of the stack
		lea	(Kos_description_field).w,a2
		move.b	(a0)+,1(a2)
		move.b	(a0)+,(a2)
		move.w	(a2),d5
		moveq	#$F,d4

Process_Kos_Queue_Loop:
		lsr.w	#1,d5
		move	sr,d6
		dbf	d4,Process_Kos_Queue_ChkBit
		move.b	(a0)+,1(a2)
		move.b	(a0)+,(a2)
		move.w	(a2),d5
		moveq	#$F,d4

Process_Kos_Queue_ChkBit:
		move	d6,ccr
		bcc.s	Process_Kos_Queue_RLE
		move.b	(a0)+,(a1)+
		bra.s	Process_Kos_Queue_Loop
; ---------------------------------------------------------------------------

Process_Kos_Queue_RLE:
		moveq	#0,d3
		lsr.w	#1,d5
		move	sr,d6
		dbf	d4,Process_Kos_Queue_ChkBit2
		move.b	(a0)+,1(a2)
		move.b	(a0)+,(a2)
		move.w	(a2),d5
		moveq	#$F,d4

Process_Kos_Queue_ChkBit2:
		move	d6,ccr
		bcs.s	Process_Kos_Queue_SeparateRLE
		lsr.w	#1,d5
		dbf	d4,+ ;loc_1F0E
		move.b	(a0)+,1(a2)
		move.b	(a0)+,(a2)
		move.w	(a2),d5
		moveq	#$F,d4

+ ;loc_1F0E:
		roxl.w	#1,d3
		lsr.w	#1,d5
		dbf	d4,+ ;loc_1F20
		move.b	(a0)+,1(a2)
		move.b	(a0)+,(a2)
		move.w	(a2),d5
		moveq	#$F,d4

+ ;loc_1F20:
		roxl.w	#1,d3
		addq.w	#1,d3
		moveq	#-1,d2
		move.b	(a0)+,d2
		bra.s	Process_Kos_Queue_RLELoop
; ---------------------------------------------------------------------------

Process_Kos_Queue_SeparateRLE:
		move.b	(a0)+,d0
		move.b	(a0)+,d1
		moveq	#-1,d2
		move.b	d1,d2
		lsl.w	#5,d2
		move.b	d0,d2
		andi.w	#7,d1
		beq.s	Process_Kos_Queue_SeparateRLE2
		move.b	d1,d3
		addq.w	#1,d3

Process_Kos_Queue_RLELoop:
		move.b	(a1,d2.w),d0
		move.b	d0,(a1)+
		dbf	d3,Process_Kos_Queue_RLELoop
		bra.s	Process_Kos_Queue_Loop
; ---------------------------------------------------------------------------

Process_Kos_Queue_SeparateRLE2:
		move.b	(a0)+,d1
		beq.s	Process_Kos_Queue_EndReached
		cmpi.b	#1,d1
		beq.w	Process_Kos_Queue_Loop
		move.b	d1,d3
		bra.s	Process_Kos_Queue_RLELoop
; ---------------------------------------------------------------------------

Process_Kos_Queue_EndReached:
		move.l	a0,(Kos_decomp_queue).w
		move.l	a1,(Kos_decomp_destination).w
		andi.w	#$7FFF,(Kos_decomp_queue_count).w	; clear decompression in progress bit
		subq.w	#1,(Kos_decomp_queue_count).w
		beq.s	Process_Kos_Queue_Done	; branch if there aren't any entries remaining in the queue
		lea	(Kos_decomp_queue).w,a0
		lea	(Kos_decomp_queue+8).w,a1	; otherwise, shift all entries up
		move.l	(a1)+,(a0)+
		move.l	(a1)+,(a0)+
		move.l	(a1)+,(a0)+
		move.l	(a1)+,(a0)+
		move.l	(a1)+,(a0)+
		move.l	(a1)+,(a0)+

Process_Kos_Queue_Done:
		rts
; ---------------------------------------------------------------------------

Restore_Kos_Bookmark:
		movem.l	(Kos_decomp_stored_registers).w,d0-d6/a0-a2
		move.l	(Kos_decomp_bookmark).w,-(sp)
		move.w	(Kos_decomp_stored_SR).w,-(sp)
		rte
; ---------------------------------------------------------------------------

Backup_Kos_Registers:
		move	sr,(Kos_decomp_stored_SR).w
		movem.l	d0-d6/a0-a2,(Kos_decomp_stored_registers).w
		rts

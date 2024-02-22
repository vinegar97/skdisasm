; =============== S U B R O U T I N E =======================================


KosArt_To_VDP:
		movea.l	a1,a3		; a1 will be changed by Kos_Decomp, so we're backing it up to a3
		jsr	(Kos_Decomp).l

		move.l	a3,d1		; move the backed-up a1 to d1
		andi.l	#$FFFFFF,d1	; d1 will be used in the DMA transfer as the Source Address

		move.l	a1,d3		; move end address of decompressed art to d3
		sub.l	a3,d3		; subtract 'start address of decompressed art' from 'end address of decompressed art', giving you the size of the decompressed art
		lsr.l	#1,d3		; divide size of decompressed art by two, d3 will be used in the DMA transfer as the Transfer Length (size/2)

		move.w	a2,d2		; move VRAM address to d2, d2 will be used in the DMA transfer as the Destination Address

		movea.l	a1,a3		; backup a1, this allows the same address to be used by multiple calls to KosArt_To_VDP without constant redefining
		jsr	(Add_To_DMA_Queue).l	; transfer *Transfer Length* of data from *Source Address* to *Destination Address*
		movea.l	a3,a1		; restore a1
		rts
; End of function KosArt_To_VDP


; =============== S U B R O U T I N E =======================================


sub_C02A:
		move.l	#$80008000,d0
		move.w	#$800-1,d1
		move.l	#vdpComm(VRAM_Plane_A_Name_Table,VRAM,WRITE),(VDP_control_port).l
		lea	(VDP_data_port).l,a6

.loop:
		move.l	d0,(a6)
		dbf	d1,.loop
		rts
; End of function sub_C02A


; =============== S U B R O U T I N E =======================================


sub_C04C:
		moveq	#8-1,d2
		lea	(VDP_data_port).l,a6
		moveq	#0,d1

.loop:
		move.w	d0,d3
		bsr.s	sub_C068
		addi.w	#$80,d0
		andi.w	#$DFFF,d0
		dbf	d2,.loop
		rts
; End of function sub_C04C


; =============== S U B R O U T I N E =======================================


sub_C068:
		swap	d3
		clr.w	d3
		swap	d3
		lsl.l	#2,d3
		lsr.w	#2,d3
		ori.w	#$4000,d3
		swap	d3
		move.l	d3,VDP_control_port-VDP_data_port(a6)
		move.l	d1,(a6)
		move.l	d1,(a6)
		move.l	d1,(a6)
		move.l	d1,(a6)
		move.w	d1,(a6)
		rts
; End of function sub_C068


; =============== S U B R O U T I N E =======================================


Copy_Listed_Data_To_VRAM:
		move.w	(a0)+,d7

.loop:
		movea.l	(a0)+,a1
		move.w	(a0)+,d0
		swap	d0
		clr.w	d0
		swap	d0
		lsl.l	#2,d0
		lsr.w	#2,d0
		ori.w	#$4000,d0
		swap	d0
		move.w	(a0)+,d1
		move.w	(a0)+,d2
		jsr	(Plane_Map_To_VRAM).l
		dbf	d7,.loop
		rts
; End of function Copy_Listed_Data_To_VRAM


; =============== S U B R O U T I N E =======================================


sub_C0AE:
		lea	(Dynamic_object_RAM).w,a0
		bsr.s	sub_C0B8
		lea	(Dynamic_object_RAM+(object_size*5)).w,a0
; End of function sub_C0AE


; =============== S U B R O U T I N E =======================================


sub_C0B8:
		lea	next_object(a0),a1
		lea	next_object(a1),a2
		bsr.s	sub_C0EA
		bsr.s	sub_C0EA
		move.w	#$80,priority(a0)
		move.w	#$100,priority(a1)
		move.w	#$180,priority(a2)
		bset	#7,art_tile(a0)
		bclr	#7,art_tile(a1)
		bclr	#7,art_tile(a2)
		rts
; End of function sub_C0B8


; =============== S U B R O U T I N E =======================================


sub_C0EA:
		move.w	y_pos(a0),d0
		cmp.w	y_pos(a1),d0
		bgt.s	loc_C0F6
		exg	a0,a1

loc_C0F6:
		move.w	y_pos(a1),d0
		cmp.w	y_pos(a2),d0
		bgt.s	locret_C102
		exg	a1,a2

locret_C102:
		rts
; End of function sub_C0EA


; =============== S U B R O U T I N E =======================================


sub_C104:
		move.w	#1,(Competition_mode).w
		bra.s	loc_C110
; ---------------------------------------------------------------------------

Set_Lives_and_Continues:
		clr.w	(Competition_mode).w

loc_C110:
		move.b	#3,(Life_count).w
		move.b	#3,(Life_count_P2).w
		moveq	#0,d0
		move.b	d0,(Last_star_post_hit).w
		move.b	d0,(Special_bonus_entry_flag).w
		move.w	d0,(Ring_count).w
		move.l	d0,(Timer).w
		move.l	d0,(Score).w
		move.w	d0,(Ring_count_P2).w
		move.l	d0,(Timer_P2).w
		move.l	d0,(Score_P2).w
		move.b	d0,(Continue_count).w
		move.l	#5000,(Next_extra_life_score).w
		move.l	#5000,(Next_extra_life_score_P2).w
		rts
; End of function sub_C104


; =============== S U B R O U T I N E =======================================


SRAM_Load:
		tst.w	(SK_alone_flag).w
		bne.w	locret_C260		; Don't bother if we're playing only Sonic and Knuckles
		clr.w	(SRAM_mask_interrupts_flag).w	; No interrupt shenanigans needed
		lea	($200011).l,a0
		lea	($2000BD).l,a1
		lea	(Competition_saved_data).w,a2
		moveq	#$29,d0
		move.w	#$4C44,d1		; RAM integrity value
		jsr	Get_From_SRAM(pc)
		beq.s	loc_C190		; If the data read was successful, branch
		lea	SaveData_GeneralDefault(pc),a0
		lea	(Competition_saved_data).w,a1
		moveq	#$29-1,d0

loc_C186:
		move.w	(a0)+,(a1)+		; Reset the general save data to the default
		dbf	d0,loc_C186
		jsr	Write_SaveGeneral2(pc)	; Write default data back to SRAM

loc_C190:
		lea	($200281).l,a0
		lea	($20032D).l,a1
		lea	(Saved_data).w,a2
		moveq	#$29,d0
		move.w	#$4244,d1		; RAM integrity value for save game data
		jsr	Get_From_SRAM(pc)
		bne.s	loc_C1C0		; If the data read was not successful, branch
		lea	(Saved_data).w,a0
		moveq	#8-1,d0

loc_C1B2:
		tst.b	(a0)
		bpl.w	loc_C256		; If any of the save files are active, then we're done here
		lea	$A(a0),a0
		dbf	d0,loc_C1B2			; if not then we load them up with default data

loc_C1C0:
		lea	SaveData_GameDefault(pc),a0
		lea	(Saved_data).w,a1
		moveq	#bytesToWcnt(($A*8)+2),d0

loc_C1CA:
		move.w	(a0)+,(a1)+
		dbf	d0,loc_C1CA			; Write default game data
		lea	($200169).l,a0
		lea	($2001F5).l,a1
		lea	($FF0000).l,a2		; Attempt to see if there's any existing S3 save data
		moveq	#$19,d0
		move.w	#$4244,d1
		jsr	Get_From_SRAM(pc)
		bne.s	loc_C252		; If write was not successful, branch
		lea	(Saved_data).w,a0	; If there's valid data from Sonic 3, we'll now go through the process of migrating it to SK
		lea	($FF0000).l,a1
		lea	SaveData_S3LevRef(pc),a2
		moveq	#6-1,d0

loc_C1FE:
		tst.b	(a1)
		bmi.s	loc_C248		; If not an active save slot, branch
		clr.b	(a0)
		move.b	1(a1),4(a0)		; Special stage ring memory migration
		move.b	7(a1),5(a0)
		move.b	2(a1),d1
		lsl.b	#4,d1
		move.b	d1,2(a0)		; Character ID is stored differently
		moveq	#0,d1
		move.b	3(a1),d1
		move.b	(a2,d1.w),3(a0)	; Current level IDs are changed slightly between S3 and SK and need to be converted
		move.b	4(a1),d1
		or.b	d1,2(a0)		; The last completed special stage was previously its own byte
		move.b	6(a1),d1
		moveq	#0,d2
		moveq	#7-1,d3

loc_C236:
		lsl.b	#1,d1
		bcc.s	loc_C23E
		ori.w	#1,d2

loc_C23E:
		lsl.w	#2,d2
		dbf	d3,loc_C236
		move.w	d2,6(a0)	; The chaos/super emerald data is interleaved in SK and needs to be converted

loc_C248:
		lea	$A(a0),a0
		addq.w	#8,a1
		dbf	d0,loc_C1FE

loc_C252:
		jsr	Write_SaveGame(pc)

loc_C256:
		clr.w	(Dataselect_nosave_player).w
		move.b	#1,(Dataselect_entry).w

locret_C260:
		rts
; End of function SRAM_Load

; ---------------------------------------------------------------------------
SaveData_GeneralDefault:
		dc.w  $8000,     0, $8000,     0, $8000,     0,     1,  $200
		dc.w  $8000,     0, $8000,     0, $8000,     0,     1,  $200
		dc.w  $8000,     0, $8000,     0, $8000,     0,     1,  $200
		dc.w  $8000,     0, $8000,     0, $8000,     0,     1,  $200
		dc.w  $8000,     0, $8000,     0, $8000,     0,     1,  $200
		dc.w  $4C44
SaveData_GameDefault:
		dc.w  $8000,     0,     0,     0,  $300
		dc.w  $8000,     0,     0,     0,  $300
		dc.w  $8000,     0,     0,     0,  $300
		dc.w  $8000,     0,     0,     0,  $300
		dc.w  $8000,     0,     0,     0,  $300
		dc.w  $8000,     0,     0,     0,  $300
		dc.w  $8000,     0,     0,     0,  $300
		dc.w  $8000,     0,     0,     0,  $300
		dc.w  $4244
SaveData_S3LevRef:
		dc.b    0
		dc.b    1
		dc.b    2
		dc.b    3
		dc.b    0
		dc.b    4
		dc.b    5
		dc.b    6
		even

; =============== S U B R O U T I N E =======================================


Get_From_SRAM:
		movea.l	a2,a3
		move.w	d0,d2
		bsr.s	Read_SRAM
		beq.s	.end
		movea.l	a1,a0
		movea.l	a3,a2
		move.w	d2,d0
		bsr.s	Read_SRAM

.end:
		rts
; End of function Get_From_SRAM


; =============== S U B R O U T I N E =======================================


Read_SRAM:
		tst.w	(SRAM_mask_interrupts_flag).w
		beq.s	loc_C32A
		move	#$2700,sr		; Disable interrupts if EF56 is set

loc_C32A:
		move.b	#1,(SRAM_access_flag).l	; Access SRAM
		movea.l	a2,a6
		move.w	d0,d6

loc_C336:
		movep.w	0(a0),d3
		move.w	d3,(a2)+		; Read data from SRAM
		addq.w	#4,a0
		dbf	d0,loc_C336
		move.b	#0,(SRAM_access_flag).l	; No longer access SRAM
		tst.w	(SRAM_mask_interrupts_flag).w
		beq.s	loc_C354
		move	#$2300,sr		; Restore interrupts if EF56 is set

loc_C354:
		subq.w	#1,d6
		bsr.s	Create_SRAMChecksum	; Get the checksum of the given data
		cmp.w	(a6),d7		; Compare the result
		bne.s	locret_C360
		cmp.w	-2(a6),d1	; Also compare the data before with the data given in d1

locret_C360:
		rts
; End of function Read_SRAM


; =============== S U B R O U T I N E =======================================


Create_SRAMChecksum:
		moveq	#0,d7

.loop:
		move.w	(a6)+,d5
		eor.w	d5,d7
		lsr.w	#1,d7
		bcc.s	.skip
		eori.w	#$8810,d7

.skip:
		dbf	d6,.loop
		rts
; End of function Create_SRAMChecksum


; =============== S U B R O U T I N E =======================================


Write_SRAM:
		movea.l	a2,a6
		move.w	d0,d6
		subq.w	#1,d6
		bsr.s	Create_SRAMChecksum
		move.w	d7,(a6)
		tst.w	(SRAM_mask_interrupts_flag).w
		beq.s	loc_C38A
		move	#$2700,sr		; If EF56 is set, disable interrupts while saving is occuring

loc_C38A:
		move.b	#1,(SRAM_access_flag).l	; Send I/O signal to SRAM, mapping it to $200001
		movea.l	a2,a3
		move.w	d0,d1

loc_C396:
		move.w	(a2)+,d2
		movep.w	d2,0(a0)	; Copy data to SRAM
		addq.w	#4,a0
		dbf	d0,loc_C396

loc_C3A2:
		move.w	(a3)+,d2
		movep.w	d2,0(a1)	; Copy data to backup SRAM
		addq.w	#4,a1
		dbf	d1,loc_C3A2
		move.b	#0,(SRAM_access_flag).l	; Stop SRAM access
		tst.w	(SRAM_mask_interrupts_flag).w
		beq.s	locret_C3C0
		move	#$2300,sr		; Restore interrupts if EF56 was set

locret_C3C0:
		rts
; End of function Write_SRAM


; =============== S U B R O U T I N E =======================================


Write_SaveGeneral:
		st	(SRAM_mask_interrupts_flag).w
; End of function Write_SaveGeneral


; =============== S U B R O U T I N E =======================================


Write_SaveGeneral2:
		move.l	a0,-(sp)
		move.w	d7,-(sp)
		lea	($200011).l,a0		; Save general SRAM
		lea	($2000BD).l,a1		; Save general Backup SRAM
		lea	(Competition_saved_data).w,a2	; Save general RAM
		moveq	#$2A-1,d0
		bsr.s	Write_SRAM
		move.w	(sp)+,d7
		movea.l	(sp)+,a0
		rts
; End of function Write_SaveGeneral2


; =============== S U B R O U T I N E =======================================


Write_SaveGame:
		move.l	a0,-(sp)
		move.w	d7,-(sp)
		lea	($200281).l,a0		; Save game SRAM
		lea	($20032D).l,a1		; Save game backup SRAM
		lea	(Saved_data).w,a2	; Save game RAM
		moveq	#$2A-1,d0
		jsr	Write_SRAM(pc)
		move.w	(sp)+,d7
		movea.l	(sp)+,a0
		rts
; End of function Write_SaveGame

; ---------------------------------------------------------------------------
SaveGame_NextLevel:
		dc.b    1,   1
		dc.b    2,   2
		dc.b    3,   3
		dc.b    4,   4
		dc.b    8,   8
		dc.b    5,   5
		dc.b    6,   6
		dc.b    7,   7
		dc.b    9,   9
		dc.b   $A,  $A
		dc.b   $C,  $C
		dc.b   $D,  $D
		dc.b   $E,  $E
		dc.b    0,   0
		dc.b    0,   0
		dc.b    0,   0
		dc.b    0,   0
		dc.b    0,   0
		dc.b    0,   0
		dc.b    0,   0
		dc.b    0,   0
		dc.b    0,   0
		dc.b   $A,  $B
		dc.b   $D,   0
		even

; =============== S U B R O U T I N E =======================================


SaveGame:
		tst.w	(SK_alone_flag).w
		bne.w	loc_C4CC			; If this is SK, saving is disabled
		move.l	(Save_pointer).w,d0
		beq.w	loc_C4CC			; If not playing on a save file, get out
		movea.l	d0,a1
		move.w	(Current_zone_and_act).w,d0
		ror.b	#1,d0
		lsr.w	#7,d0
		move.b	SaveGame_NextLevel(pc,d0.w),d0
		move.b	(a1),d1
		andi.w	#3,d1
		beq.s	loc_C464
		cmp.b	3(a1),d0		; If game is complete, make it uncomplete if last level is less than the current level
		blo.s	loc_C4B4		; Think of, say, getting all the super emeralds then going to Doomsday on a completed save file
		andi.b	#$FC,(a1)

loc_C464:
		move.b	d0,3(a1)			; Move next level into current level
		cmpi.w	#3,(Player_mode).w
		bne.s	loc_C478
		cmpi.b	#$C,d0
		blo.s	loc_C4B0
		bra.s	loc_C498		; If playing as Knuckles and level code is Death Egg or higher, make it a completed save file
; ---------------------------------------------------------------------------

loc_C478:
		cmpi.w	#2,(Player_mode).w
		bne.s	loc_C488
		cmpi.b	#$D,d0
		blo.s	loc_C4B0
		bra.s	loc_C498		; If playing as Tails and level code is Doomsday or higher, make it a completed save file
; ---------------------------------------------------------------------------

loc_C488:
		cmpi.b	#$D,d0
		bhi.s	loc_C498			; If next level above Doomsday's code, make it a completed save file
		bne.s	loc_C4B0
		cmpi.b	#7,(Chaos_emerald_count).w	; If next level IS Doomsday but the emeralds aren't collected, make it a completed save file
		bhs.s	loc_C4B0

loc_C498:
		moveq	#1,d0
		cmpi.b	#7,(Chaos_emerald_count).w
		blo.s	loc_C4AE		; code 1 is completed without all emeralds
		addq.b	#1,d0
		cmpi.b	#7,(Super_emerald_count).w
		blo.s	loc_C4AE		; code 2 is completed with all chaos emeralds
		addq.b	#1,d0			; code 3 is completed with all super emeralds

loc_C4AE:
		move.b	d0,(a1)

loc_C4B0:
		clr.w	4(a1)			; Clear the special stage ring collection memory

loc_C4B4:
		move.b	(Life_count).w,d0		; Get number of lives
		cmpi.b	#99,d0
		bls.s	loc_C4C0
		moveq	#99,d0

loc_C4C0:
		move.b	d0,8(a1)				; Put number of lives into memory
		move.b	d0,(Life_count).w
		jsr	Write_SaveGame(pc)

loc_C4CC:
		clr.l	(Collected_special_ring_array).w	; Clear special stage ring collection RAM
		rts
; End of function SaveGame


; =============== S U B R O U T I N E =======================================


SaveGame_SpecialStage:
		tst.w	(SK_alone_flag).w
		bne.s	locret_C530			; If playing Sonic and Knuckles, don't bother
		move.l	(Save_pointer).w,d0
		beq.s	locret_C530
		movea.l	d0,a1				; Get address of save slot
		tst.b	(SK_special_stage_flag).w
		bne.s	loc_C4F8
		andi.b	#$F0,2(a1)
		move.b	(Current_special_stage).w,d0
		andi.b	#$F,d0
		or.b	d0,2(a1)			; Write last played special stage only if Sonic 3 special stages are in effect

loc_C4F8:
		lea	(Collected_emeralds_array).w,a2
		moveq	#0,d0
		moveq	#7-1,d1

loc_C500:
		move.b	(a2)+,d2
		andi.b	#3,d2
		or.b	d2,d0
		lsl.w	#2,d0
		dbf	d1,loc_C500
		move.w	d0,6(a1)		; Compress emerald collection RAM and put it into Save Game
		move.w	(Collected_special_ring_array+2).w,4(a1)	; Special stage entry ring memory is copied as well
		move.b	(Continue_count).w,d0
		cmpi.b	#99,d0
		bls.s	loc_C524
		moveq	#99,d0

loc_C524:
		move.b	d0,9(a1)		; Save number of continues
		move.b	d0,(Continue_count).w
		jmp	Write_SaveGame(pc)
; ---------------------------------------------------------------------------

locret_C530:
		rts
; End of function SaveGame_SpecialStage


; =============== S U B R O U T I N E =======================================


SaveGame_LivesContinues:
		tst.w	(SK_alone_flag).w
		bne.s	locret_C56C		; If playing Sonic and Knuckles, don't bother
		move.l	(Save_pointer).w,d0
		beq.s	locret_C56C
		movea.l	d0,a1
		move.b	(Life_count).w,d0
		cmpi.b	#99,d0
		bls.s	loc_C54C
		moveq	#99,d0

loc_C54C:
		move.b	d0,8(a1)		; Save number of lives
		move.b	d0,(Life_count).w
		move.b	(Continue_count).w,d0
		cmpi.b	#99,d0
		bls.s	loc_C560
		moveq	#99,d0

loc_C560:
		move.b	d0,9(a1)		; Save number of continues
		move.b	d0,(Continue_count).w
		jmp	Write_SaveGame(pc)
; ---------------------------------------------------------------------------

locret_C56C:
		rts
; End of function SaveGame_LivesContinues

; ---------------------------------------------------------------------------

locret_C56E:
		rts
; ---------------------------------------------------------------------------

SaveScreen:
		jsr	(Pal_FadeToBlack).l
		move	#$2700,sr
		move.w	(VDP_reg_1_command).w,d0
		andi.b	#$BF,d0
		move.w	d0,(VDP_control_port).l
		jsr	(Clear_DisplayData).l

		dmaFillVRAM 0,$D000,$1000

		lea	(VDP_control_port).l,a6
		move.w	#$8004,(a6)
		move.w	#$8238,(a6)
		move.w	#$8338,(a6)
		move.w	#$8406,(a6)
		move.w	#$8700,(a6)
		move.w	#$8B00,(a6)
		move.w	#$8C81,(a6)
		move.w	#$9003,(a6)
		move.w	#$9280,(a6)
		clearRAM	Sprite_table_input,$400
		clearRAM	Object_RAM,(Kos_decomp_buffer-Object_RAM)
		clr.w	(DMA_queue).w
		move.l	#DMA_queue,(DMA_queue_slot).w
		clr.w	(Level_frame_counter).w
		clr.w	(Events_bg+$10).w
		clr.w	(Events_bg+$12).w
		lea	(MapEni_S3MenuBG).l,a0
		lea	(RAM_start).l,a1
		move.w	#make_art_tile(ArtTile_ArtKos_S3MenuBG,0,0),d0
		jsr	(Eni_Decomp).l
		lea	(RAM_start).l,a1
		move.l	#vdpComm(VRAM_Plane_B_Name_Table,VRAM,WRITE),d0
		moveq	#$28-1,d1
		moveq	#$1C-1,d2
		jsr	(Plane_Map_To_VRAM).l
		lea	(MapEni_SaveScreen_Layout).l,a0
		lea	(RAM_start).l,a1
		move.w	#make_art_tile(ArtTile_ArtKos_Save_Misc,0,1),d0
		jsr	(Eni_Decomp).l
		lea	word_CD58(pc),a0
		jsr	sub_C866(pc)
		move.l	#vdpComm(tiles_to_bytes($562),VRAM,WRITE),(VDP_control_port).l
		lea	(ArtNem_S22POptions).l,a0
		jsr	(Nem_Decomp).l
		lea	byte_DB1C(pc),a1
		move.w	#VRAM_Plane_A_Name_Table+$C06,d0
		jsr	sub_D9F4(pc)
		move.w	#VRAM_Plane_A_Name_Table+$C0C,d0
		jsr	sub_D9F4(pc)
		move.w	#VRAM_Plane_A_Name_Table+$CEC,d0
		jsr	sub_D9F4(pc)
		lea	(ArtKos_S3MenuBG).l,a0				; Decompress source
		lea	(RAM_start).l,a1				; Decompress destination/Transfer source
		movea.w	#tiles_to_bytes(ArtTile_ArtKos_S3MenuBG),a2	; Transfer destination
		jsr	(KosArt_To_VDP).l
		move.l	#locret_C56E,(_unkEF44_1).w
		move.b	#$1E,(V_int_routine).w
		jsr	(Wait_VSync).l
		lea	(ArtKos_SaveScreenMisc).l,a0			; Decompress source
		lea	(RAM_start).l,a1				; Decompress destination/Transfer source
		movea.w	#tiles_to_bytes(ArtTile_ArtKos_Save_Misc),a2	; Transfer destination
		jsr	KosArt_To_VDP(pc)
		move.b	#$1E,(V_int_routine).w
		jsr	(Wait_VSync).l
		lea	(ArtKos_SaveScreen).l,a0			; Decompress source
		lea	(RAM_start).l,a1				; Decompress destination/Transfer source
		movea.w	#tiles_to_bytes(ArtTile_ArtKos_Save_Extra),a2	; Transfer destination
		jsr	KosArt_To_VDP(pc)
		move.b	#$1E,(V_int_routine).w
		jsr	(Wait_VSync).l
		lea	(Pal_SaveMenuBG).l,a0
		lea	(Target_palette).w,a1
		moveq	#bytesToLcnt($20),d0

loc_C710:
		move.l	(a0)+,(a1)+
		dbf	d0,loc_C710
		lea	Pal_Save_Chars(pc),a0
		moveq	#bytesToLcnt($40),d0

loc_C71C:

		move.l	(a0)+,(a1)+
		dbf	d0,loc_C71C
		lea	(Object_RAM).w,a0
		lea	ObjDat_SaveScreen(pc),a1
		moveq	#$C-1,d0

loc_C72C:
		move.l	(a1)+,(a0)
		move.w	#make_art_tile(ArtTile_ArtKos_Save_Misc,0,1),art_tile(a0)
		move.l	#Map_SaveScreen,mappings(a0)
		move.w	(a1),x_pos(a0)
		move.w	(a1)+,objoff_12(a0)	; copy of object's x_pos
		move.w	(a1)+,y_pos(a0)
		move.b	(a1)+,mapping_frame(a0)
		move.b	(a1)+,objoff_2E(a0)	; used for save slot id
		move.b	#$40,render_flags(a0)	; sets multi-sprite flag
		lea	next_object(a0),a0
		dbf	d0,loc_C72C
		jsr	(Init_SpriteTable).l
		jsr	(Process_Sprites).l
		jsr	(Render_Sprites).l
		lea	(Normal_palette_line_4).w,a0
		lea	(Target_palette_line_4).w,a1
		moveq	#8-1,d0

loc_C77A:
		move.l	(a0),(a1)+
		clr.l	(a0)+
		dbf	d0,loc_C77A
		lea	(ArtKos_SaveScreenS3Zone).l,a0
		lea	(RAM_start).l,a1
		jsr	(Kos_Decomp).l
		lea	(RAM_start+$2BC0).l,a0
		lea	(RAM_start+$2300).l,a1
		move.w	#$230-1,d0

loc_C7A4:
		move.l	(a0)+,(a1)+
		move.l	(a0)+,(a1)+
		dbf	d0,loc_C7A4
		lea	(ArtKos_SaveScreenSKZone).l,a0
		jsr	(Kos_Decomp).l
		lea	(ArtKos_SaveScreenPortrait).l,a0
		jsr	(Kos_Decomp).l
		lea	-$8C0(a1),a0
		move.w	#$150-1,d0

loc_C7CC:
		move.l	(a0)+,(a1)+
		dbf	d0,loc_C7CC
		moveq	#signextendB(mus_DataSelect),d0
		jsr	(Play_Music).l
		move.l	#loc_C890,(_unkEF44_1).w
		move.b	#$1E,(V_int_routine).w
		jsr	(Wait_VSync).l
		move.w	(VDP_reg_1_command).w,d0
		ori.b	#$40,d0
		move.w	d0,(VDP_control_port).l
		jsr	(Pal_FadeFromBlack).l

SaveScreen_MainLoop:
		move.b	#$1E,(V_int_routine).w
		jsr	(Wait_VSync).l
		addq.w	#1,(Level_frame_counter).w
		jsr	(Process_Sprites).l
		move.w	(Camera_X_pos_copy).w,d0
		neg.w	d0
		move.w	d0,(H_scroll_buffer+2).w
		jsr	(Render_Sprites).l
		lea	(Normal_palette_line_3+$2).w,a0
		moveq	#$E,d0
		move.w	(Emerald_flicker_flag).w,d1
		addq.w	#1,d1
		cmpi.w	#3,d1
		blo.s	loc_C83C
		moveq	#0,d1

loc_C83C:
		move.w	d1,(Emerald_flicker_flag).w
		beq.s	loc_C84E
		lea	Pal_Save_Emeralds(pc),a1

loc_C846:
		move.w	(a1)+,(a0)+
		dbf	d0,loc_C846
		bra.s	loc_C856
; ---------------------------------------------------------------------------

loc_C84E:
		move.w	#$EEE,(a0)+
		dbf	d0,loc_C84E

loc_C856:
		cmpi.b	#$4C,(Game_mode).w	; are we still in the savescreen mode?
		beq.s	SaveScreen_MainLoop	; if so, loop
		moveq	#signextendB(sfx_EnterSS),d0
		jmp	(Play_SFX).l

; =============== S U B R O U T I N E =======================================


sub_C866:
		move.w	(a0)+,d7

.loop:
		movea.l	(a0)+,a1
		move.w	(a0)+,d0
		bsr.s	sub_C87E
		move.w	(a0)+,d1
		move.w	(a0)+,d2
		jsr	(Plane_Map_To_VRAM_2).l
		dbf	d7,.loop
		rts
; End of function sub_C866


; =============== S U B R O U T I N E =======================================


sub_C87E:
		swap	d0
		clr.w	d0
		swap	d0
		lsl.l	#2,d0
		lsr.w	#2,d0
		ori.w	#$4000,d0
		swap	d0
		rts
; End of function sub_C87E

; ---------------------------------------------------------------------------
; selects whether to display the static screen, or new screen
; and is called during vblank
next_SaveSlot = $A

loc_C890:
		move.w	(Level_frame_counter).w,d0
		andi.w	#$C,d0
		lea	(MapPtrs_SaveScreenStatic).l,a2
		movea.l	(a2,d0.w),a2
	if Sonic3_Complete=0
		adda.l	#LockOnROM_Start,a2
	endif
		move.w	#VRAM_Plane_A_Name_Table+$21A,d7
		lea	(Saved_data).w,a0
		moveq	#8-1,d6

loc_C8B2:
		lea	(MapUnc_SaveScreenNEW).l,a1
		tst.b	(a0)		; is a game in progress?
		bmi.s	loc_C8BE
		movea.l	a2,a1

loc_C8BE:
		move.w	d7,d0
		bsr.s	sub_C87E
		moveq	#$A-1,d1
		moveq	#7-1,d2
		jsr	(Plane_Map_To_VRAM_2).l
		addi.w	#$1A,d7
		lea	next_SaveSlot(a0),a0
		dbf	d6,loc_C8B2
		lea	(Dynamic_object_RAM+object_size).w,a3	; load the first save slot object
		move.w	#VRAM_Plane_A_Name_Table+$A20,d7
		lea	(Saved_data).w,a0
		moveq	#8-1,d3

loc_C8E6:
		move.w	d7,d0
		subq.w	#2,d0
		jsr	sub_C87E(pc)
		move.l	d0,VDP_control_port-VDP_data_port(a6)
		move.w	#make_art_tile($2B1,0,1),(a6)
		lea	byte_DB2B(pc),a1
		tst.b	(a0)
		bmi.s	loc_C946
		lea	byte_DB36(pc),a1
		move.b	objoff_3A(a3),d0
		cmp.b	objoff_37(a3),d0
		bne.s	loc_C912
		tst.b	objoff_3B(a3)
		bne.s	loc_C946

loc_C912:
		lea	byte_DB31(pc),a1
		move.w	d7,d0
		subq.w	#2,d0
		jsr	sub_D9F4(pc)
		move.w	objoff_36(a3),d0
		add.w	d0,d0
		moveq	#0,d1
		move.b	byte_C95E(pc,d0.w),d1
		bpl.s	loc_C932
		move.w	#high_priority,d1
		bra.s	loc_C936
; ---------------------------------------------------------------------------

loc_C932:
		addi.w	#make_art_tile($562,1,1),d1

loc_C936:
		move.w	d1,(a6)
		moveq	#0,d1
		move.b	byte_C95E+1(pc,d0.w),d1
		addi.w	#make_art_tile($562,1,1),d1
		move.w	d1,(a6)
		bra.s	loc_C94C
; ---------------------------------------------------------------------------

loc_C946:
		move.w	d7,d0
		jsr	sub_D9F4(pc)

loc_C94C:
		addi.w	#$1A,d7
		lea	next_SaveSlot(a0),a0
		lea	next_object(a3),a3
		dbf	d3,loc_C8E6
		bra.s	loc_C97A
; ---------------------------------------------------------------------------
; shows level number 1-14
; NOTE: $FF acts as zero
byte_C95E:
		dc.b  $FF,   1	; 01
		dc.b  $FF,   2	; 02
		dc.b  $FF,   3	; 03
		dc.b  $FF,   4	; 04
		dc.b  $FF,   5	; 05
		dc.b  $FF,   6	; 06
		dc.b  $FF,   7	; 07
		dc.b  $FF,   8	; 08
		dc.b  $FF,   9	; 09
		dc.b    1,   0	; 10
		dc.b    1,   1	; 11
		dc.b    1,   2	; 12
		dc.b    1,   3	; 13
		dc.b    1,   4	; 14
; ---------------------------------------------------------------------------

loc_C97A:
		lea	word_DA8A(pc),a2
		lea	(Dynamic_object_RAM+object_size).w,a3
		move.w	#VRAM_Plane_A_Name_Table+$1220,d7
		lea	(Saved_data).w,a0
		moveq	#8-1,d6

loc_C98C:
		move.w	objoff_34(a3),d0
		bne.s	loc_C994
		moveq	#1,d0

loc_C994:
		tst.b	(a0)
		bpl.s	loc_C99A
		moveq	#0,d0

loc_C99A:
		lsl.w	#5,d0
		movea.l	a2,a1
		adda.w	d0,a1
		move.w	d7,d0
		bsr.w	sub_C87E
		moveq	#3-1,d1
		moveq	#5-1,d2
		jsr	(Plane_Map_To_VRAM_2).l
		tst.b	(a0)
		bpl.s	loc_C9CC
		lea	word_DB08(pc),a1
		move.w	d7,d0
		addq.w	#6,d0
		bsr.w	sub_C87E
		moveq	#2-1,d1
		moveq	#5-1,d2
		jsr	(Plane_Map_To_VRAM_2).l
		bra.s	loc_CA02
; ---------------------------------------------------------------------------

loc_C9CC:
		move.b	objoff_3E(a3),d0
		jsr	sub_CA14(pc)
		move.w	d7,d0
		addq.w	#6,d0
		bsr.w	sub_C87E
		moveq	#2-1,d1
		moveq	#2-1,d2
		jsr	(Plane_Map_To_VRAM_2).l
		move.b	objoff_3F(a3),d0
		jsr	sub_CA14(pc)
		move.w	d7,d0
		addi.w	#$306,d0
		bsr.w	sub_C87E
		moveq	#2-1,d1
		moveq	#2-1,d2
		jsr	(Plane_Map_To_VRAM_2).l

loc_CA02:
		addi.w	#$1A,d7
		lea	next_SaveSlot(a0),a0
		lea	next_object(a3),a3
		dbf	d6,loc_C98C
		rts

; =============== S U B R O U T I N E =======================================


sub_CA14:
		moveq	#0,d1

loc_CA16:
		addq.w	#1,d1
		subi.b	#$A,d0
		bcc.s	loc_CA16
		subq.w	#1,d1
		addi.b	#$A,d0
		lea	(_unkEEEA).w,a1
		lsl.w	#2,d1
		bne.s	loc_CA2E
		moveq	#$28,d1

loc_CA2E:
		move.w	word_CA4C(pc,d1.w),(a1)
		move.w	word_CA4C+2(pc,d1.w),4(a1)
		andi.w	#$FF,d0
		lsl.w	#2,d0
		move.w	word_CA4C(pc,d0.w),2(a1)
		move.w	word_CA4C+2(pc,d0.w),6(a1)
		rts
; End of function sub_CA14

; ---------------------------------------------------------------------------
word_CA4C:
		dc.w make_art_tile($49A,1,1), make_art_tile($49B,1,1)	; 0
		dc.w make_art_tile($49C,1,1), make_art_tile($49D,1,1)	; 1
		dc.w make_art_tile($49E,1,1), make_art_tile($49F,1,1)	; 2
		dc.w make_art_tile($4A0,1,1), make_art_tile($4A1,1,1)	; 3
		dc.w make_art_tile($4A2,1,1), make_art_tile($4A3,1,1)	; 4
		dc.w make_art_tile($4A4,1,1), make_art_tile($4A5,1,1)	; 5
		dc.w make_art_tile($4A6,1,1), make_art_tile($4A7,1,1)	; 6
		dc.w make_art_tile($4A8,1,1), make_art_tile($4A9,1,1)	; 7
		dc.w make_art_tile($4AA,1,1), make_art_tile($4AB,1,1)	; 8
		dc.w make_art_tile($4AC,1,1), make_art_tile($4AD,1,1)	; 9
		dc.w make_art_tile($000,0,1), make_art_tile($000,0,1)	; blank
Pal_Save_Chars:
		binclude "General/Save Menu/Palettes/Chars.bin"
		even
Pal_Save_Emeralds:
		binclude "General/Save Menu/Palettes/Emeralds.bin"
		even
Pal_Save_FinishCard1:
		binclude "General/Save Menu/Palettes/Finish Card 1.bin"
		even
Pal_Save_FinishCard2:
		binclude "General/Save Menu/Palettes/Finish Card 2.bin"
		even
Pal_Save_FinishCard3:
		binclude "General/Save Menu/Palettes/Finish Card 3.bin"
		even
Pal_Save_ZoneCard1:
		binclude "General/Save Menu/Palettes/Zone Card 1.bin"
		even
Pal_Save_ZoneCard2:
		binclude "General/Save Menu/Palettes/Zone Card 2.bin"
		even
Pal_Save_ZoneCard3:
		binclude "General/Save Menu/Palettes/Zone Card 3.bin"
		even
Pal_Save_ZoneCard4:
		binclude "General/Save Menu/Palettes/Zone Card 4.bin"
		even
Pal_Save_ZoneCard5:
		binclude "General/Save Menu/Palettes/Zone Card 5.bin"
		even
Pal_Save_ZoneCard6:
		binclude "General/Save Menu/Palettes/Zone Card 6.bin"
		even
Pal_Save_ZoneCard7:
		binclude "General/Save Menu/Palettes/Zone Card 7.bin"
		even
Pal_Save_ZoneCard8:
		binclude "General/Save Menu/Palettes/Zone Card 8.bin"
		even
Pal_Save_ZoneCard9:
		binclude "General/Save Menu/Palettes/Zone Card 9.bin"
		even
Pal_Save_ZoneCardA:
		binclude "General/Save Menu/Palettes/Zone Card A.bin"
		even
Pal_Save_ZoneCardB:
		binclude "General/Save Menu/Palettes/Zone Card B.bin"
		even
Pal_Save_ZoneCardC:
		binclude "General/Save Menu/Palettes/Zone Card C.bin"
		even
Pal_Save_ZoneCardD:
		binclude "General/Save Menu/Palettes/Zone Card D.bin"
		even
Pal_Save_ZoneCardE:
		binclude "General/Save Menu/Palettes/Zone Card E.bin"
		even
Pal_Save_ZoneCardF:
		binclude "General/Save Menu/Palettes/Zone Card F.bin"
		even
Pal_Save_ZoneCard10:
		binclude "General/Save Menu/Palettes/Zone Card 10.bin"
		even
Pal_Save_ZoneCard11:
		binclude "General/Save Menu/Palettes/Zone Card 11.bin"
		even
Pal_Save_ZoneCard12:
		binclude "General/Save Menu/Palettes/Zone Card 12.bin"
		even
word_CD58:
		dc.w $12-1
		dc.l RAM_start+$0222
		dc.w VRAM_Plane_A_Name_Table+$102, $B-1,  $C-1
		dc.l RAM_start+$0000
		dc.w VRAM_Plane_A_Name_Table+$118, $D-1, $15-1
		dc.l RAM_start+$0000
		dc.w VRAM_Plane_A_Name_Table+$132, $D-1, $15-1
		dc.l RAM_start+$0000
		dc.w VRAM_Plane_A_Name_Table+$14C, $D-1, $15-1
		dc.l RAM_start+$0000
		dc.w VRAM_Plane_A_Name_Table+$166, $D-1, $15-1
		dc.l RAM_start+$0000
		dc.w VRAM_Plane_A_Name_Table+$180, $D-1, $15-1
		dc.l RAM_start+$0000
		dc.w VRAM_Plane_A_Name_Table+$19A, $D-1, $15-1
		dc.l RAM_start+$0104
		dc.w VRAM_Plane_A_Name_Table+$E18, $D-1,  $B-1
		dc.l RAM_start+$0104
		dc.w VRAM_Plane_A_Name_Table+$E32, $D-1,  $B-1
		dc.l RAM_start+$0104
		dc.w VRAM_Plane_A_Name_Table+$E4C, $D-1,  $B-1
		dc.l RAM_start+$0104
		dc.w VRAM_Plane_A_Name_Table+$E66, $D-1,  $B-1
		dc.l RAM_start+$0104
		dc.w VRAM_Plane_A_Name_Table+$E80, $D-1,  $B-1
		dc.l RAM_start+$0104
		dc.w VRAM_Plane_A_Name_Table+$E9A, $D-1,  $B-1
		dc.l RAM_start+$0000
		dc.w VRAM_Plane_A_Name_Table+$1B4, $D-1, $15-1
		dc.l RAM_start+$0000
		dc.w VRAM_Plane_A_Name_Table+$1CE, $D-1, $15-1
		dc.l RAM_start+$0222
		dc.w VRAM_Plane_A_Name_Table+$1E8, $B-1,  $C-1
		dc.l RAM_start+$0104
		dc.w VRAM_Plane_A_Name_Table+$EB4, $D-1,  $B-1
		dc.l RAM_start+$0104
		dc.w VRAM_Plane_A_Name_Table+$ECE, $D-1,  $B-1
Map_SaveScreen:
		include "General/Save Menu/Map - Save Screen General.asm"
ObjDat_SaveScreen:
		dc.l Draw_Sprite				; "Data Select" Text
		dc.w   $120						; x_pos, objoff_12 (x_pos copy)
		dc.w   $14C						; y_pos
		dc.b    3						; mapping_frame
		dc.b    0						; unused
		dc.l Obj_SaveScreen_Selector	; Highlights the current selected slot
		dc.w   $120						; x_pos, objoff_12 (x_pos copy)
		dc.w    $E2						; y_pos
		dc.b    1						; mapping_frame
		dc.b    0						; unused
		dc.l Obj_SaveScreen_Delete_Save	; Delete Icon that erases a saved game
		dc.w   $448						; x_pos, objoff_12 (x_pos copy)
		dc.w    $D8						; y_pos
		dc.b   $D						; mapping_frame
		dc.b    0						; unused
		dc.l Obj_SaveScreen_NoSave_Slot	; Slot that starts a non-saving game
		dc.w    $B0						; x_pos, objoff_12 (x_pos copy)
		dc.w    $C8						; y_pos
		dc.b    0						; unused
		dc.b    0						; unused
		dc.l Obj_SaveScreen_Save_Slot	; Save Slot
		dc.w   $110						; x_pos, objoff_12 (x_pos copy)
		dc.w   $108						; y_pos
		dc.b    0						; mapping_frame
		dc.b    0						; Save Slot ID Number
		dc.l Obj_SaveScreen_Save_Slot	; Save Slot
		dc.w   $178						; x_pos, objoff_12 (x_pos copy)
		dc.w   $108						; y_pos
		dc.b    0						; unused
		dc.b    1						; Save Slot ID Number
		dc.l Obj_SaveScreen_Save_Slot	; Save Slot
		dc.w   $1E0						; x_pos, objoff_12 (x_pos copy)
		dc.w   $108						; y_pos
		dc.b    0						; unused
		dc.b    2						; Save Slot ID Number
		dc.l Obj_SaveScreen_Save_Slot	; Save Slot
		dc.w   $248						; x_pos, objoff_12 (x_pos copy)
		dc.w   $108						; y_pos
		dc.b    0						; unused
		dc.b    3						; Save Slot ID Number
		dc.l Obj_SaveScreen_Save_Slot	; Save Slot
		dc.w   $2B0						; x_pos, objoff_12 (x_pos copy)
		dc.w   $108						; y_pos
		dc.b    0						; unused
		dc.b    4						; Save Slot ID Number
		dc.l Obj_SaveScreen_Save_Slot	; Save Slot
		dc.w   $318						; x_pos, objoff_12 (x_pos copy)
		dc.w   $108						; y_pos
		dc.b    0						; unused
		dc.b    5						; Save Slot ID Number
		dc.l Obj_SaveScreen_Save_Slot	; Save Slot
		dc.w   $380						; x_pos, objoff_12 (x_pos copy)
		dc.w   $108						; y_pos
		dc.b    0						; unused
		dc.b    6						; Save Slot ID Number
		dc.l Obj_SaveScreen_Save_Slot	; Save Slot
		dc.w   $3E8						; x_pos, objoff_12 (x_pos copy)
		dc.w   $108						; y_pos
		dc.b    0						; unused
		dc.b    7						; Save Slot ID Number
; ---------------------------------------------------------------------------

Obj_SaveScreen_Selector:
		move.w	#$A8,d0
		moveq	#0,d1
		moveq	#0,d2
		move.b	(Dataselect_entry).w,d2
		subq.w	#1,d2
		bcs.s	loc_D1E6

loc_D1C6:
		moveq	#$D-1,d4

loc_D1C8:
		addq.w	#8,d0
		cmpi.w	#$120,d0
		bls.s	loc_D1DE
		subq.w	#8,d0
		addq.w	#8,d1
		cmpi.w	#$2C0,d1
		bls.s	loc_D1DE
		subq.w	#8,d1
		addq.w	#8,d0

loc_D1DE:
		dbf	d4,loc_D1C8
		dbf	d2,loc_D1C6

loc_D1E6:
		move.w	d0,$12(a0)
		move.w	d1,(Camera_X_pos_copy).w
		neg.w	d1
		move.w	d1,(H_scroll_buffer+2).w
		move.l	#loc_D1FA,(a0)

loc_D1FA:
		tst.w	(Events_bg+$12).w
		bne.s	loc_D212
		btst	#button_B,(Ctrl_1_pressed).w
		beq.s	loc_D212
		move.b	#4,(Game_mode).w
		bra.w	loc_D2CE
; ---------------------------------------------------------------------------

loc_D212:
		tst.w	(Events_bg+$10).w
		bne.w	loc_D2CE
		tst.w	$30(a0)
		bne.s	loc_D28A
		moveq	#0,d0
		btst	#button_left,(Ctrl_1_pressed).w
		beq.s	loc_D254
		tst.w	(Events_bg+$12).w
		beq.s	loc_D238
		cmpi.b	#1,(Dataselect_entry).w
		beq.s	loc_D254

loc_D238:
		tst.b	(Dataselect_entry).w
		beq.s	loc_D254
		subq.b	#1,(Dataselect_entry).w
		moveq	#signextendB(sfx_SlotMachine),d0
		tst.w	(Events_bg+$12).w
		beq.s	loc_D24C
		moveq	#signextendB(sfx_SmallBumpers),d0

loc_D24C:
		jsr	(Play_SFX).l
		moveq	#-8,d0

loc_D254:
		btst	#button_right,(Ctrl_1_pressed).w
		beq.s	loc_D27A
		cmpi.b	#9,(Dataselect_entry).w
		beq.s	loc_D27A
		addq.b	#1,(Dataselect_entry).w
		moveq	#signextendB(sfx_SlotMachine),d0
		tst.w	(Events_bg+$12).w
		beq.s	loc_D272
		moveq	#signextendB(sfx_SmallBumpers),d0

loc_D272:
		jsr	(Play_SFX).l
		moveq	#8,d0

loc_D27A:
		move.w	d0,$2E(a0)
		beq.s	loc_D288
		move.w	#$D,$30(a0)
		bra.s	loc_D28A
; ---------------------------------------------------------------------------

loc_D288:
		bra.s	loc_D2CE
; ---------------------------------------------------------------------------

loc_D28A:
		move.w	$12(a0),d0
		move.w	(Camera_X_pos_copy).w,d1
		move.w	$2E(a0),d2
		bmi.s	loc_D2B0
		add.w	d2,d0
		cmpi.w	#$120,d0
		bls.s	loc_D2C2
		sub.w	d2,d0
		add.w	d2,d1
		cmpi.w	#$2C0,d1
		bls.s	loc_D2C2
		sub.w	d2,d1
		add.w	d2,d0
		bra.s	loc_D2C2
; ---------------------------------------------------------------------------

loc_D2B0:
		add.w	d2,d0
		cmpi.w	#$120,d0
		bhs.s	loc_D2C2
		sub.w	d2,d0
		add.w	d2,d1
		bpl.s	loc_D2C2
		sub.w	d2,d1
		add.w	d2,d0

loc_D2C2:
		move.w	d0,$12(a0)
		move.w	d1,(Camera_X_pos_copy).w
		subq.w	#1,$30(a0)

loc_D2CE:
		moveq	#8,d2
		move.b	(Dataselect_entry).w,d1
		beq.s	loc_D2E0
		neg.w	d2
		cmpi.b	#9,d1
		beq.s	loc_D2E0
		moveq	#0,d2

loc_D2E0:
		add.w	$12(a0),d2
		move.w	d2,x_pos(a0)
		moveq	#2,d0
		cmpi.w	#$F0,d2
		blo.s	loc_D2F8
		cmpi.w	#$148,d2
		bhi.s	loc_D2F8
		moveq	#1,d0

loc_D2F8:
		move.b	d0,mapping_frame(a0)
		btst	#2,(Level_frame_counter+1).w
		beq.s	locret_D30A
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

locret_D30A:
		rts
; ---------------------------------------------------------------------------

Obj_SaveScreen_NoSave_Slot:
		move.b	#$F,sub2_mapframe(a0)
		move.w	(Dataselect_nosave_player).w,d0
		addq.w	#4,d0
		move.b	d0,mapping_frame(a0)
		tst.b	(Dataselect_entry).w
		bne.s	loc_D396
		move.w	(Player_2+object_control).w,d0
		or.w	(Events_bg+$12).w,d0
		bne.s	loc_D396
		move.b	(Ctrl_1_pressed).w,d0
		andi.w	#button_A_mask|button_C_mask|button_start_mask,d0
		beq.s	loc_D376
		move.b	#$C,(Game_mode).w
		move.w	(Dataselect_nosave_player).w,(Player_option).w
		clr.w	(Current_zone_and_act).w
		clr.w	(Apparent_zone_and_act).w
		clr.w	(Current_special_stage).w
		clr.w	(Emerald_counts).w
		clr.l	(Collected_emeralds_array).w
		clr.w	(Collected_emeralds_array+4).w
		clr.b	(Collected_emeralds_array+6).w
		clr.l	(Collected_special_ring_array).w
		clr.b	(Emeralds_converted_flag).w
		clr.l	(Save_pointer).w
		jsr	(Set_Lives_and_Continues).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_D376:
		move.w	(Dataselect_nosave_player).w,d0
		jsr	sub_D6D0(pc)
		move.w	d0,(Dataselect_nosave_player).w
		addq.w	#4,d0
		move.b	d0,mapping_frame(a0)
		move.w	#1,mainspr_childsprites(a0)
		btst	#4,(Level_frame_counter+1).w
		bne.s	loc_D39A

loc_D396:
		clr.w	mainspr_childsprites(a0)

loc_D39A:
		bra.w	Set_ChildSprites
; ---------------------------------------------------------------------------

Obj_SaveScreen_Save_Slot:
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	loc_D3B0
		move.l	#Obj_SaveScreen_Emeralds,(a1)
		move.w	a0,parent2(a1)

loc_D3B0:
		moveq	#0,d0
		move.b	$2E(a0),d0
		mulu.w	#$A,d0
		addi.l	#Saved_data,d0
		move.l	d0,$30(a0)
		movea.l	d0,a1
		move.b	2(a1),d0
		lsr.b	#4,d0
		move.b	d0,$35(a0)
		move.b	3(a1),d0
		move.b	d0,$37(a0)
		move.b	d0,$3A(a0)
		move.b	(a1),d0
		andi.b	#3,d0
		move.b	d0,$3B(a0)
		move.w	6(a1),d0
		lea	(Collected_emeralds_array).w,a2
		jsr	sub_DA1E(pc)
		move.b	d1,$3C(a0)
		move.b	d2,$3D(a0)
		tst.b	9(a1)
		bne.s	loc_D41A
		cmpi.b	#3,8(a1)
		bhs.s	loc_D41A
		move.b	#3,8(a1)
		move.l	a1,-(sp)
		st	(SRAM_mask_interrupts_flag).w
		jsr	Write_SaveGame(pc)
		movea.l	(sp)+,a1

loc_D41A:
		move.b	8(a1),$3E(a0)
		move.b	9(a1),$3F(a0)
		move.l	#loc_D42C,(a0)

loc_D42C:
		clr.w	mainspr_childsprites(a0)
		movea.l	$30(a0),a1
		move.b	(Dataselect_entry).w,d0
		subq.b	#1,d0
		cmp.b	$2E(a0),d0
		beq.s	Load_Level_Icons
		move.b	3(a1),$37(a0)
		clr.w	$38(a0)

loc_D44A:
		move.w	$34(a0),d0
		addq.w	#4,d0
		move.b	d0,mapping_frame(a0)
		bra.w	Set_ChildSprites
; ---------------------------------------------------------------------------

Load_Level_Icons:
		tst.b	(a1)
		bmi.w	loc_D5FE
		move.w	$36(a0),d1
		jsr	Load_Icon_Art(pc)
		move.b	#$17,sub3_mapframe(a0)
		move.w	$36(a0),d1
		cmp.b	$3A(a0),d1
		bne.s	loc_D4A4
		move.b	$3B(a0),d0
		beq.s	loc_D4A4
		addq.b	#1,sub3_mapframe(a0)
		cmpi.b	#1,d0
		beq.s	loc_D496
		addq.b	#1,sub3_mapframe(a0)
		cmpi.b	#2,d0
		beq.s	loc_D496
		addq.b	#2,sub3_mapframe(a0)
		bra.s	loc_D4A4
; ---------------------------------------------------------------------------

loc_D496:
		cmpi.w	#1,$34(a0)
		bls.s	loc_D4A4
		move.b	#$23,sub3_mapframe(a0)

loc_D4A4:
		tst.w	$38(a0)
		bne.s	loc_D4B6
		tst.b	$3B(a0)
		beq.w	loc_D534
		st	$38(a0)

loc_D4B6:
		tst.w	(Player_2+object_control).w
		bne.s	loc_D44A
		tst.w	(Events_bg+$12).w
		beq.s	loc_D4D0
		clr.b	sub2_mapframe(a0)
		move.w	#2,mainspr_childsprites(a0)
		bra.w	loc_D44A
; ---------------------------------------------------------------------------

loc_D4D0:
		moveq	#$B,d6
		cmpi.w	#3,$34(a0)
		beq.s	loc_D4EE
		moveq	#$C,d6
		cmpi.w	#2,$34(a0)
		beq.s	loc_D4EE
		cmpi.b	#2,$3B(a0)
		blo.s	loc_D4EE
		moveq	#$D,d6

loc_D4EE:
		moveq	#0,d2
		move.w	$36(a0),d1
		move.b	(Ctrl_1_pressed).w,d0
		btst	#1,d0
		beq.s	loc_D508
		moveq	#signextendB(sfx_Switch),d2
		subq.w	#1,d1
		bpl.s	loc_D518
		move.w	d6,d1
		bra.s	loc_D518
; ---------------------------------------------------------------------------

loc_D508:
		btst	#0,d0
		beq.s	loc_D518
		moveq	#signextendB(sfx_Switch),d2
		addq.w	#1,d1
		cmp.w	d6,d1
		bls.s	loc_D518
		moveq	#0,d1

loc_D518:
		move.w	d1,$36(a0)
		move.l	d2,d0
		jsr	(Play_SFX).l
		move.b	#$1A,sub2_mapframe(a0)
		btst	#4,(Level_frame_counter+1).w
		beq.s	loc_D53C
		bra.s	loc_D540
; ---------------------------------------------------------------------------

loc_D534:
		tst.w	(Player_2+object_control).w
		bne.w	loc_D44A

loc_D53C:
		clr.b	sub2_mapframe(a0)

loc_D540:
		move.w	#2,mainspr_childsprites(a0)
		tst.w	(Events_bg+$12).w
		bne.w	loc_D44A
		move.b	(Ctrl_1_pressed).w,d0
		andi.w	#button_A_mask|button_C_mask|button_start_mask,d0
		beq.w	loc_D44A
		move.w	4(a1),(Collected_special_ring_array+2).w
		move.b	3(a1),d0
		tst.b	$3B(a0)
		beq.s	loc_D57A
		move.w	$36(a0),d0
		cmp.b	$3A(a0),d0
		bhs.w	loc_D44A
		clr.l	(Collected_special_ring_array).w

loc_D57A:
		jsr	sub_DA4E(pc)
		move.w	d0,(Current_zone_and_act).w
		move.w	d0,(Apparent_zone_and_act).w
		moveq	#0,d0
		move.b	2(a1),d0
		lsr.b	#4,d0
		move.w	d0,(Player_option).w
		move.b	2(a1),d0
		andi.b	#$F,d0
		move.b	d0,(Current_special_stage).w
		move.w	6(a1),d0
		lea	(Collected_emeralds_array).w,a2
		jsr	sub_DA1E(pc)
		move.b	d1,(Chaos_emerald_count).w
		move.b	d2,(Super_emerald_count).w
		move.l	a1,(Save_pointer).w
		jsr	(Set_Lives_and_Continues).l
		move.b	8(a1),d0
		beq.s	loc_D5CE
		cmpi.b	#3,d0
		bhs.s	loc_D5DE
		tst.b	9(a1)
		bne.s	loc_D5DE

loc_D5CE:
		move.b	#3,8(a1)
		subq.b	#1,9(a1)
		bcc.s	loc_D5DE
		clr.b	9(a1)

loc_D5DE:
		move.b	8(a1),(Life_count).w
		move.b	9(a1),(Continue_count).w
		st	(SRAM_mask_interrupts_flag).w
		jsr	Write_SaveGame(pc)
		move.b	#$C,(Game_mode).w
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_D5FE:
		move.b	#$F,sub2_mapframe(a0)
		clr.b	sub3_mapframe(a0)
		move.w	(Player_2+object_control).w,d0
		or.w	(Events_bg+$12).w,d0
		bne.w	loc_D44A
		move.b	(Ctrl_1_pressed).w,d0
		andi.w	#button_A_mask|button_C_mask|button_start_mask,d0
		beq.s	loc_D67A
		move.b	#$C,(Game_mode).w
		clr.l	(a1)
		clr.l	4(a1)
		move.w	#$300,8(a1)
		move.w	$34(a0),d0
		move.w	d0,(Player_option).w
		lsl.b	#4,d0
		move.b	d0,2(a1)
		clr.w	(Current_zone_and_act).w
		clr.w	(Apparent_zone_and_act).w
		clr.w	(Current_special_stage).w
		clr.w	(Emerald_counts).w
		clr.l	(Collected_emeralds_array).w
		clr.w	(Collected_emeralds_array+4).w
		clr.b	(Collected_emeralds_array+6).w
		clr.l	(Collected_special_ring_array).w
		clr.b	(Emeralds_converted_flag).w
		move.l	a1,(Save_pointer).w
		jsr	(Set_Lives_and_Continues).l
		st	(SRAM_mask_interrupts_flag).w
		jsr	Write_SaveGame(pc)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_D67A:
		move.w	$34(a0),d0
		jsr	sub_D6D0(pc)
		move.w	d0,$34(a0)
		addq.w	#4,d0
		move.b	d0,mapping_frame(a0)
		move.w	#1,mainspr_childsprites(a0)
		btst	#4,(Level_frame_counter+1).w
		bne.s	Set_ChildSprites
		clr.w	mainspr_childsprites(a0)

Set_ChildSprites:
		move.w	$12(a0),d0
		sub.w	(Camera_X_pos_copy).w,d0
		move.w	d0,x_pos(a0)
		move.w	y_pos(a0),d1
		move.w	d0,sub2_x_pos(a0)
		move.w	d1,sub2_y_pos(a0)
		move.w	d0,sub3_x_pos(a0)
		move.w	d1,sub3_y_pos(a0)
		cmpi.b	#$1A,sub2_mapframe(a0)
		bne.s	loc_D6CA
		subq.w	#8,sub2_y_pos(a0)

loc_D6CA:
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_D6D0:
		moveq	#0,d2
		tst.w	(Player_2+objoff_30).w
		bne.s	loc_D6FA
		move.b	(Ctrl_1_pressed).w,d1
		lsr.w	#1,d1
		bcc.s	loc_D6EE
		moveq	#signextendB(sfx_Switch),d2
		addq.w	#1,d0
		cmpi.w	#3,d0
		bls.s	loc_D6FA
		moveq	#0,d0
		bra.s	loc_D6FA
; ---------------------------------------------------------------------------

loc_D6EE:
		lsr.w	#1,d1
		bcc.s	loc_D6FA
		moveq	#signextendB(sfx_Switch),d2
		subq.w	#1,d0
		bpl.s	loc_D6FA
		moveq	#3,d0

loc_D6FA:
		tst.w	d2
		beq.s	locret_D70A
		move.l	d0,-(sp)
		move.l	d2,d0
		jsr	(Play_SFX).l
		move.l	(sp)+,d0

locret_D70A:
		rts
; End of function sub_D6D0

; ---------------------------------------------------------------------------

Obj_SaveScreen_Emeralds:
		move.b	#$40,render_flags(a0)
		move.w	#make_art_tile(ArtTile_ArtKos_Save_Misc,0,1),art_tile(a0)
		move.l	#Map_SaveScreen,mappings(a0)
		move.b	#$40,width_pixels(a0)
		move.w	#7,mainspr_childsprites(a0)
		movea.w	parent2(a0),a1
		movea.l	$30(a1),a2
		move.w	6(a2),d4
		move.w	x_pos(a1),d0
		move.w	y_pos(a1),d1
		move.w	d0,x_pos(a0)
		move.w	d1,y_pos(a0)
		lea	sub2_x_pos(a0),a1
		moveq	#$10,d2
		moveq	#7-1,d3

loc_D750:
		clr.b	5(a1)
		moveq	#0,d6
		rol.w	#2,d4
		move.w	d4,d5
		andi.w	#3,d5
		beq.s	loc_D774
		cmpi.w	#3,d5
		bne.s	loc_D768
		moveq	#$C,d6

loc_D768:
		add.b	d2,d6
		move.w	d0,(a1)
		move.w	d1,sub2_y_pos-sub2_x_pos(a1)
		move.b	d6,sub2_mapframe-sub2_x_pos(a1)

loc_D774:
		addq.w	#1,d2
		addq.w	#6,a1
		dbf	d3,loc_D750
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_SaveScreen_Delete_Save:
		moveq	#0,d0
		move.b	routine(a0),d0
		jmp	SaveScreen_Delete_Save_Index(pc,d0.w)
; ---------------------------------------------------------------------------

SaveScreen_Delete_Save_Index:
		bra.w	loc_D7A4
; ---------------------------------------------------------------------------
		bra.w	loc_D7C0
; ---------------------------------------------------------------------------
		bra.w	loc_D7EA
; ---------------------------------------------------------------------------
		bra.w	loc_D884
; ---------------------------------------------------------------------------
		bra.w	loc_D8A4
; ---------------------------------------------------------------------------
		bra.w	loc_D8C4
; ---------------------------------------------------------------------------

loc_D7A4:
		move.b	#$40,render_flags(a0)
		move.b	#$30,width_pixels(a0)
		move.w	#1,mainspr_childsprites(a0)
		move.b	#8,sub2_mapframe(a0)
		addq.b	#4,routine(a0)

loc_D7C0:
		cmpi.b	#9,(Dataselect_entry).w
		bne.w	loc_D8A0
		move.b	(Ctrl_1_pressed).w,d0
		andi.w	#button_A_mask|button_C_mask|button_start_mask,d0
		beq.w	loc_D8A0
		moveq	#signextendB(sfx_Starpost),d0
		jsr	(Play_SFX).l
		st	(Events_bg+$12).w
		addq.b	#4,routine(a0)
		bra.w	loc_D8A0
; ---------------------------------------------------------------------------

loc_D7EA:
		jsr	sub_D912(pc)
		jsr	sub_D94A(pc)
		tst.w	(Player_2+object_control).w
		bne.s	loc_D83C
		move.b	(Ctrl_1_pressed).w,d0
		btst	#button_B,d0
		bne.s	loc_D854
		andi.w	#button_A_mask|button_C_mask|button_start_mask,d0
		beq.s	loc_D83C
		cmpi.b	#9,(Dataselect_entry).w
		beq.s	loc_D854
		moveq	#0,d0
		move.b	(Dataselect_entry).w,d0
		subq.w	#1,d0
		mulu.w	#$A,d0
		addi.l	#Saved_data,d0
		move.l	d0,$2E(a0)
		movea.l	d0,a1
		tst.b	(a1)
		bmi.s	loc_D854
		moveq	#signextendB(sfx_Starpost),d0
		jsr	(Play_SFX).l
		st	(Events_bg+$10).w
		addq.b	#8,routine(a0)

loc_D83C:
		move.w	(Player_2+x_pos).w,d0
		move.w	d0,x_pos(a0)
		move.w	d0,sub2_x_pos(a0)
		move.w	y_pos(a0),sub2_y_pos(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_D854:
		clr.b	$24(a0)
		clr.b	$23(a0)
		clr.b	$25(a0)
		clr.b	$28(a0)
		move.b	#$D,mapping_frame(a0)
		move.b	#8,sub2_mapframe(a0)
		move.w	(Player_2+x_pos).w,d0
		add.w	(Camera_X_pos_copy).w,d0
		move.w	d0,$12(a0)
		addq.b	#4,routine(a0)
		bra.w	Set_ChildSprites
; ---------------------------------------------------------------------------

loc_D884:
		clr.w	(Events_bg+$12).w
		move.w	$12(a0),d0
		cmpi.w	#$448,d0
		blo.s	loc_D89A
		move.b	#4,routine(a0)
		bra.s	loc_D8A0
; ---------------------------------------------------------------------------

loc_D89A:
		addq.w	#8,d0
		move.w	d0,$12(a0)

loc_D8A0:
		bra.w	Set_ChildSprites
; ---------------------------------------------------------------------------

loc_D8A4:
		jsr	sub_D912(pc)
		jsr	sub_D94A(pc)
		cmpi.b	#$B,sub2_mapframe(a0)
		bne.s	loc_D8BE
		move.b	#$C,sub2_mapframe(a0)
		addq.b	#4,routine(a0)

loc_D8BE:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_D8C4:
		jsr	sub_D912(pc)
		btst	#button_right,(Ctrl_1_pressed).w
		bne.s	loc_D8FE
		btst	#button_left,(Ctrl_1_pressed).w
		beq.s	loc_D90C
		moveq	#signextendB(sfx_Perfect),d0
		jsr	(Play_SFX).l
		movea.l	$2E(a0),a1
		move.w	#$8000,(a1)
		clr.l	2(a1)
		clr.w	6(a1)
		move.w	#$300,8(a1)
		st	(SRAM_mask_interrupts_flag).w
		jsr	Write_SaveGame(pc)

loc_D8FE:
		move.b	#8,routine(a0)
		clr.w	(Events_bg+$10).w
		bra.w	loc_D854
; ---------------------------------------------------------------------------

loc_D90C:
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_D912:
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	locret_D938
		move.b	#5,anim_frame_timer(a0)

loc_D91E:
		moveq	#0,d0
		move.b	anim_frame(a0),d0
		addq.b	#1,anim_frame(a0)
		move.b	byte_D93A(pc,d0.w),d0
		bpl.s	loc_D934
		clr.b	anim_frame(a0)
		bra.s	loc_D91E
; ---------------------------------------------------------------------------

loc_D934:
		move.b	d0,mapping_frame(a0)

locret_D938:
		rts
; End of function sub_D912

; ---------------------------------------------------------------------------
byte_D93A:
		dc.b   $D,  $E,  $D,  $E,  $D,  $E,  $D,  $E,  $D,  $E,  $D,  $D,  $D,  $D, $FF
		even

; =============== S U B R O U T I N E =======================================


sub_D94A:
		subq.b	#1,$25(a0)
		bpl.s	locret_D968
		move.b	#3,$25(a0)
		addq.b	#1,$28(a0)
		move.b	$28(a0),d0
		andi.b	#3,d0
		addq.b	#8,d0
		move.b	d0,sub2_mapframe(a0)

locret_D968:
		rts
; End of function sub_D94A


; =============== S U B R O U T I N E =======================================


Load_Icon_Art:
		cmp.b	$3A(a0),d1
		bne.s	loc_D9A2
		tst.b	$3B(a0)
		beq.s	loc_D9A2
		cmpi.w	#1,$34(a0)
		bls.s	loc_D9C8
		cmpi.b	#3,$3B(a0)
		beq.s	loc_D9C8
		moveq	#$E,d1
		cmpi.w	#3,$34(a0)
		beq.s	loc_D992
		addq.w	#2,d1

loc_D992:
		cmpi.b	#1,$3B(a0)
		beq.s	loc_D99C
		addq.w	#1,d1

loc_D99C:
		move.w	#tiles_to_bytes($51C),d2
		bra.s	loc_D9A6
; ---------------------------------------------------------------------------

loc_D9A2:
		move.w	#tiles_to_bytes($5BA),d2

loc_D9A6:
		move.l	a1,-(sp)
		move.w	d1,-(sp)
		mulu.w	#$8C0,d1
		addi.l	#RAM_start,d1
		move.w	#$460,d3
		jsr	(Add_To_DMA_Queue).l
		move.w	(sp)+,d0
		movea.l	(sp)+,a1
		lea	Pal_Save_ZoneCard1(pc),a2
		bra.s	loc_D9E2
; ---------------------------------------------------------------------------

loc_D9C8:
		lea	Pal_Save_FinishCard1(pc),a2
		moveq	#0,d0
		cmpi.b	#1,$3B(a0)
		beq.s	loc_D9E2
		addq.w	#1,d0
		cmpi.b	#2,$3B(a0)
		beq.s	loc_D9E2
		addq.w	#1,d0

loc_D9E2:
		lsl.w	#5,d0
		adda.w	d0,a2
		lea	(Normal_palette_line_4).w,a3
		moveq	#bytesToLcnt($20),d0

loc_D9EC:
		move.l	(a2)+,(a3)+
		dbf	d0,loc_D9EC
		rts
; End of function Load_Icon_Art


; =============== S U B R O U T I N E =======================================


sub_D9F4:
		lea	(VDP_data_port).l,a6
		jsr	sub_C87E(pc)
		move.l	d0,VDP_control_port-VDP_data_port(a6)
		move.w	#make_art_tile($552,1,1),d5
		moveq	#0,d6

loc_DA08:
		move.b	(a1)+,d6
		bne.s	loc_DA12
		move.w	#$8000,(a6)
		bra.s	loc_DA08
; ---------------------------------------------------------------------------

loc_DA12:
		bmi.s	locret_DA1C
		move.w	d5,d4
		add.w	d6,d4
		move.w	d4,(a6)
		bra.s	loc_DA08
; ---------------------------------------------------------------------------

locret_DA1C:
		rts
; End of function sub_D9F4


; =============== S U B R O U T I N E =======================================


sub_DA1E:
		clr.b	(Emeralds_converted_flag).w
		moveq	#0,d1
		moveq	#0,d2
		moveq	#7-1,d3

loc_DA28:
		rol.w	#2,d0
		move.w	d0,d4
		andi.w	#3,d4
		move.b	d4,(a2)+
		beq.s	loc_DA3E
		addq.w	#1,d1
		cmpi.w	#3,d4
		bne.s	loc_DA3E
		addq.w	#1,d2

loc_DA3E:
		cmpi.w	#2,d4
		blo.s	loc_DA48
		st	(Emeralds_converted_flag).w

loc_DA48:
		dbf	d3,loc_DA28
		rts
; End of function sub_DA1E


; =============== S U B R O U T I N E =======================================


sub_DA4E:
		cmpi.w	#3,$34(a0)
		bne.s	loc_DA62
		cmpi.b	#$B,d0
		bne.s	loc_DA62
		move.w	#$A01,d0
		bra.s	locret_DA6C
; ---------------------------------------------------------------------------

loc_DA62:
		andi.w	#$F,d0
		add.w	d0,d0
		move.w	LevelList_DA6E(pc,d0.w),d0

locret_DA6C:
		rts
; End of function sub_DA4E

; ---------------------------------------------------------------------------
LevelList_DA6E:
		dc.w      0
		dc.w   $100
		dc.w   $200
		dc.w   $300
		dc.w   $500
		dc.w   $600
		dc.w   $700
		dc.w   $400
		dc.w   $800
		dc.w   $900
		dc.w  $1601
		dc.w   $A00
		dc.w   $B00
		dc.w   $C00
word_DA8A:
		dc.w make_art_tile($000,0,1), make_art_tile($000,0,1), make_art_tile($000,0,1)
		dc.w make_art_tile($000,0,1), make_art_tile($000,0,1), make_art_tile($000,0,1)
		dc.w make_art_tile($000,0,1), make_art_tile($000,0,1), make_art_tile($000,0,1)
		dc.w make_art_tile($000,0,1), make_art_tile($000,0,1), make_art_tile($000,0,1)
		dc.w make_art_tile($000,0,1), make_art_tile($000,0,1), make_art_tile($000,0,1)
		dc.w      0
		dc.w make_art_tile($4C2,1,1), make_art_tile($4C4,1,1), make_art_tile($4AE,1,1)
		dc.w make_art_tile($4C3,1,1), make_art_tile($4C5,1,1), make_art_tile($4AF,1,1)
		dc.w make_art_tile($4B0,1,1), make_art_tile($4B3,1,1), make_art_tile($000,1,1)
		dc.w make_art_tile($4B1,1,1), make_art_tile($4B4,1,1), make_art_tile($4AE,1,1)
		dc.w make_art_tile($4B2,1,1), make_art_tile($4B5,1,1), make_art_tile($4AF,1,1)
		dc.w      0
		dc.w make_art_tile($4C6,1,1), make_art_tile($4C8,1,1), make_art_tile($4AE,1,1)
		dc.w make_art_tile($4C7,1,1), make_art_tile($4C9,1,1), make_art_tile($4AF,1,1)
		dc.w make_art_tile($4B6,1,1), make_art_tile($4B9,1,1), make_art_tile($000,1,1)
		dc.w make_art_tile($4B7,1,1), make_art_tile($4BA,1,1), make_art_tile($4AE,1,1)
		dc.w make_art_tile($4B8,1,1), make_art_tile($4BB,1,1), make_art_tile($4AF,1,1)
		dc.w      0
		dc.w make_art_tile($4CA,1,1), make_art_tile($4CC,1,1), make_art_tile($4AE,1,1)
		dc.w make_art_tile($4CB,1,1), make_art_tile($4CD,1,1), make_art_tile($4AF,1,1)
		dc.w make_art_tile($4BC,1,1), make_art_tile($4BF,1,1), make_art_tile($000,1,1)
		dc.w make_art_tile($4BD,1,1), make_art_tile($4C0,1,1), make_art_tile($4AE,1,1)
		dc.w make_art_tile($4BE,1,1), make_art_tile($4C1,1,1), make_art_tile($4AF,1,1)
word_DB08:
		dc.w make_art_tile($000,0,1), make_art_tile($000,0,1)
		dc.w make_art_tile($000,0,1), make_art_tile($000,0,1)
		dc.w make_art_tile($000,0,1), make_art_tile($000,0,1)
		dc.w make_art_tile($000,0,1), make_art_tile($000,0,1)
		dc.w make_art_tile($000,0,1), make_art_tile($000,0,1)
byte_DB1C:
		dc.b  $2B, $2C, $FF, $30, $1E, $33, $22, $FF, $21, $22, $29, $22, $31, $22, $FF
byte_DB2B:
		dc.b    0,   0,   0,   0,   0, $FF
byte_DB31:
		dc.b  $37, $2C, $2B, $22, $FF
byte_DB36:
		dc.b  $20, $29, $22, $1E, $2F, $FF
		even

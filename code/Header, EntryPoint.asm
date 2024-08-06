Vectors:	dc.l	$00000000,	EntryPoint,	ErrorTrap,	ErrorTrap	; 0
		dc.l	ErrorTrap,	ErrorTrap,	ErrorTrap,	ErrorTrap	; 4
		dc.l	ErrorTrap,	ErrorTrap,	ErrorTrap,	ErrorTrap	; 8
		dc.l	ErrorTrap,	ErrorTrap,	ErrorTrap,	ErrorTrap	; 12
		dc.l	ErrorTrap,	ErrorTrap,	ErrorTrap,	ErrorTrap	; 16
		dc.l	ErrorTrap,	ErrorTrap,	ErrorTrap,	ErrorTrap	; 20
		dc.l	ErrorTrap,	ErrorTrap,	ErrorTrap,	ErrorTrap	; 24
		dc.l	H_int_jump,	ErrorTrap,	V_int_jump,	ErrorTrap	; 28
		dc.l	ErrorTrap,	ErrorTrap,	ErrorTrap,	ErrorTrap	; 32
		dc.l	ErrorTrap,	ErrorTrap,	ErrorTrap,	ErrorTrap	; 36
		dc.l	ErrorTrap,	ErrorTrap,	ErrorTrap,	ErrorTrap	; 40
		dc.l	ErrorTrap,	ErrorTrap,	ErrorTrap,	ErrorTrap	; 44
		dc.l	ErrorTrap,	ErrorTrap,	ErrorTrap,	ErrorTrap	; 48
		dc.l	ErrorTrap,	ErrorTrap,	ErrorTrap,	ErrorTrap	; 52
		dc.l	ErrorTrap,	ErrorTrap,	ErrorTrap,	ErrorTrap	; 56
		dc.l	ErrorTrap,	ErrorTrap,	ErrorTrap,	ErrorTrap	; 60
Header:		dc.b "SEGA GENESIS    "
Copyright:	dc.b "(C)SEGA 1994.JUN"
Domestic_Name:	dc.b "SONIC & KNUCKLES                                "
Overseas_Name:	dc.b "SONIC & KNUCKLES                                "
Serial_Number:	dc.b "GM MK-1563 -00"
Checksum:	dc.w $DFB3
Input:		dc.b "J               "
ROMStartLoc:	dc.l StartOfROM
ROMEndLoc:	dc.l EndOfROM-1
RAMStartLoc:	dc.l (RAM_start&$FFFFFF)
RAMEndLoc:	dc.l (RAM_start&$FFFFFF)+$FFFF
	if Sonic3_Complete
CartRAM_Info:	dc.b "RA"
CartRAM_Type:	dc.w %1111100000100000
CartRAMStartLoc:dc.l $00200001
CartRAMEndLoc:	dc.l $002003FF
	else
CartRAM_Info:	dc.b "  "
CartRAM_Type:	dc.w %10000000100000
CartRAMStartLoc:dc.b "    "
CartRAMEndLoc:	dc.b "    "
	endif
Modem_Info:	dc.b "  "
		dc.b "          "
Unknown_Header:	dc.w 0
		dc.b "      "
		dc.w 0, 0
		dc.l EndOfROM-1	; 0	;CHECKLATER (ROM Bank Info)
		dc.b "        "
KiS2ROM_Info:	dc.b "RO"
KiS2ROM_Type:	dc.w %10000000100000
KiS2ROMStartLoc:	tribyte $300000
KiS2ROMEndLoc:		tribyte $33FFFF
KiS2ROMStartLoc2:	tribyte $300000
KiS2ROMEndLoc2:		tribyte $33FFFF
Country_Code:	dc.b "JUE             "
; ---------------------------------------------------------------------------

ErrorTrap:
		nop
		nop
		nop
; ---------------------------------------------------------------------------

EntryPoint:
		lea	(System_stack).w,sp
		tst.l	(HW_Port_1_Control-1).l
		bne.s	+
		tst.w	(HW_Expansion_Control-1).l

+
		bne.s	++ ;Init_SkipPowerOn	; in case of a soft reset
		lea	SetupValues(pc),a5
		movem.w	(a5)+,d5-d7
		movem.l	(a5)+,a0-a4
		move.b	HW_Version-Z80_bus_request(a1),d0	; get hardware version
		andi.b	#$F,d0
		beq.s	+ ;SkipSecurity	; branch if hardware is older than Genesis III
		move.l	#'SEGA',Security_addr-Z80_bus_request(a1)	; satisfy the TMSS

+ ;SkipSecurity:
		move.w	(a4),d0	; check if VDP works
		moveq	#0,d0
		movea.l	d0,a6
		move.l	a6,usp	; set usp to $0
		moveq	#VDPInitValues.End-VDPInitValues-1,d1

- ;Init_VDPRegs:
		move.b	(a5)+,d5
		move.w	d5,(a4)
		add.w	d7,d5
		dbf	d1,- ;Init_VDPRegs	; set all 24 registers

		move.l	(a5)+,(a4)	; set VRAM write mode
		move.w	d0,(a3)	; clear the screen
		move.w	d7,(a1)	; stop the Z80
		move.w	d7,(a2)	; reset the Z80

- ;WaitForZ80:
		btst	d0,(a1)	; has the Z80 stopped?
		bne.s	- ;WaitForZ80	; if not, branch
		moveq	#Z80StartupCodeEnd-Z80StartupCodeBegin-1,d2

- ;Init_SoundRAM:
		move.b	(a5)+,(a0)+
		dbf	d2,- ;Init_SoundRAM
		move.w	d0,(a2)
		move.w	d0,(a1)	; start the Z80
		move.w	d7,(a2)	; reset the Z80

- ;Init_ClearRAM:
		move.l	d0,-(a6)		; Clear normal RAM
		dbf	d6,- ;Init_ClearRAM
		move.l	(a5)+,(a4)	; set VDP display mode and increment
		move.l	(a5)+,(a4)	; set VDP to CRAM write
		moveq	#bytesToLcnt($80),d3

- ;Init_ClearCRAM:
		move.l	d0,(a3)			; Clear CRAM
		dbf	d3,- ;Init_ClearCRAM
		move.l	(a5)+,(a4)
		moveq	#bytesToLcnt($50),d4

- ;Init_ClearVSRAM:
		move.l	d0,(a3)			; Clear VSRAM
		dbf	d4,- ;Init_ClearVSRAM
		moveq	#PSGInitValues.End-PSGInitValues-1,d5

- ;Init_InputPSG:
		move.b	(a5)+,PSG_input-VDP_data_port(a3)	; reset the PSG
		dbf	d5,- ;Init_InputPSG
		move.w	d0,(a2)
		movem.l	(a6),d0-a6	; clear all registers
		move	#$2700,sr	; set the sr

+ ;Init_SkipPowerOn:
		bra.s	Test_LockOn
; ---------------------------------------------------------------------------
SetupValues:
		dc.w $8000,bytesToLcnt($10000),$100
		dc.l Z80_RAM
		dc.l Z80_bus_request
		dc.l Z80_reset
		dc.l VDP_data_port, VDP_control_port

; values for VDP registers
VDPInitValues:
		dc.b 4			; Command $8004 - HInt off, Enable HV counter read
		dc.b $14		; Command $8114 - Display off, VInt off, DMA on, PAL off
		dc.b $30		; Command $8230 - Scroll A Address $C000
		dc.b $3C		; Command $833C - Window Address $F000
		dc.b 7			; Command $8407 - Scroll B Address $E000
		dc.b $6C		; Command $856C - Sprite Table Address $D800
		dc.b 0			; Command $8600 - Null
		dc.b 0			; Command $8700 - Background color Pal 0 Color 0
		dc.b 0			; Command $8800 - Null
		dc.b 0			; Command $8900 - Null
		dc.b $FF		; Command $8AFF - Hint timing $FF scanlines
		dc.b 0			; Command $8B00 - Ext Int off, VScroll full, HScroll full
		dc.b $81		; Command $8C81 - 40 cell mode, shadow/highlight off, no interlace
		dc.b $37		; Command $8D37 - HScroll Table Address $DC00
		dc.b 0			; Command $8E00 - Null
		dc.b 1			; Command $8F01 - VDP auto increment 1 byte
		dc.b 1			; Command $9001 - 64x32 cell scroll size
		dc.b 0			; Command $9100 - Window H left side, Base Point 0
		dc.b 0			; Command $9200 - Window V upside, Base Point 0
		dc.b $FF		; Command $93FF - DMA Length Counter $FFFF
		dc.b $FF		; Command $94FF - See above
		dc.b 0			; Command $9500 - DMA Source Address $0
		dc.b 0			; Command $9600 - See above
		dc.b $80		; Command $9700 - See above + VRAM fill mode
.End:
		dc.l	vdpComm($0000,VRAM,DMA)	; value for VRAM write mode

; Z80 instructions (not the sound driver; that gets loaded later)
Z80StartupCodeBegin:
		save
		cpu Z80			; start assembling Z80 code
		phase 0			; pretend we're at address 0

		xor	a		; clear a to 0
		ld	bc,((Z80_RAM_end-Z80_RAM)-zStartupCodeEndLoc)-1	; prepare to loop this many times
		ld	de,zStartupCodeEndLoc+1	; initial destination address
		ld	hl,zStartupCodeEndLoc	; initial source address
		ld	sp,hl		; set the address the stack starts at
		ld	(hl),a		; set first byte of the stack to 0
		ldir			; loop to fill the stack (entire remaining available Z80 RAM) with 0
		pop	ix		; clear ix
		pop	iy		; clear iy
		ld	i,a		; clear i
		ld	r,a		; clear r
		pop	de		; clear de
		pop	hl		; clear hl
		pop	af		; clear af
		ex	af,af'		; swap af with af'
		exx			; swap bc/de/hl with their shadow registers too
		pop	bc		; clear bc
		pop	de		; clear de
		pop	hl		; clear hl
		pop	af		; clear af
		ld	sp,hl		; clear sp
		di			; clear iff1 (for interrupt handler)
		im	1		; interrupt handling mode = 1
		ld	(hl),0E9h	; replace the first instruction with a jump to itself
		jp	(hl)		; jump to the first instruction (to stay there forever)
zStartupCodeEndLoc:
		dephase			; stop pretending
		restore
		padding off	; unfortunately our flags got reset so we have to set them again...
Z80StartupCodeEnd:

		dc.w $8104			; value for VDP display mode
		dc.w $8F02			; value for VDP increment
		dc.l vdpComm($0000,CRAM,WRITE)	; value for CRAM write mode
		dc.l vdpComm($0000,VSRAM,WRITE)	; value for VSRAM write mode
PSGInitValues:
		dc.b $9F,$BF,$DF,$FF		; values for PSG channel volumes
.End:
; ---------------------------------------------------------------------------

Test_LockOn:
		tst.w	(VDP_control_port).l
		move.w	#$4EF9,(V_int_jump).w	; machine code for jmp
		move.l	#VInt,(V_int_addr).w
		move.w	#$4EF9,(H_int_jump).w
		move.l	#HInt,(H_int_addr).w

-
		move.w	(VDP_control_port).l,d1
		btst	#1,d1
		bne.s	-	; wait till a DMA is completed
		lea	((RAM_start&$FFFFFF)).l,a6
		moveq	#0,d7
		move.w	#bytesToLcnt($FE00),d6

-
		move.l	d7,(a6)+
		dbf	d6,-

	if Sonic3_Complete
		moveq	#0,d1
		bra.s	SonicAndKnucklesStartup
	else
		move.b	#0,(SRAM_access_flag).l		; disable SRAM access
		lea	(SegaHeadersText).l,a1
		moveq	#1,d4	; test for both MEGA DRIVE and GENESIS

Test_SystemString:
		lea	(LockonHeader).l,a0
		moveq	#0,d3
		moveq	#$10-1,d2

$$compareChars:
		move.b	(a1)+,d0
		cmp.b	(a0)+,d0
		beq.s	$$matchingChar
		moveq	#1,d3

$$matchingChar:
		dbf	d2,$$compareChars
		tst.b	d3
		beq.s	DetermineWhichGame
		dbf	d4,Test_SystemString
		moveq	#-1,d1
		move.l	(SegaHeadersText).l,d0		; test to see if SEGA is at the locked on ROM's $100
		cmp.l	(LockonHeader).l,d0
		bne.w	SonicAndKnucklesStartup

DetermineWhichGame:
		lea	(LockonSerialsText).l,a1
		moveq	#3,d1	; 3 Sonic 2 headers, 1 Sonic 3 header

$$compareSerials:
		lea	(LockonSerialNumber).l,a0
		moveq	#0,d3
		moveq	#$E-1,d2

$$compareChars:
		move.b	(a1)+,d0
		cmp.b	(a0)+,d0
		beq.s	$$matchingChar
		moveq	#1,d3

$$matchingChar:
		dbf	d2,$$compareChars
		tst.b	d3
		beq.s	+ ;S2orS3LockedOn
		dbf	d1,$$compareSerials
		bra.s	BlueSpheresStartup
; ---------------------------------------------------------------------------

+ ;S2orS3LockedOn:
		tst.w	d1
		beq.w	SonicAndKnucklesStartup
		move.b	#1,(SRAM_access_flag).l
		jmp	($300000).l				; May be changed at a later date to become compatible with S2K disassembly
; ---------------------------------------------------------------------------
LockonSerialsText:
		dc.b "GM 00001051-00"	; Sonic 2 REV00/1/2
		dc.b "GM 00001051-01"
		dc.b "GM 00001051-02"
		dc.b "GM MK-1079 -00"	; Sonic 3
SegaHeadersText:
		dc.b "SEGA MEGA DRIVE "
		dc.b "SEGA GENESIS    "
; ---------------------------------------------------------------------------

BlueSpheresStartup:
		bsr.s	Test_Checksum
		move.b	d4,(Blue_spheres_header_flag).w
		bsr.w	Init_VDP
		bsr.w	SndDrvInit
		bsr.w	Init_Controllers
		move.b	#0,(Blue_spheres_menu_flag).w
		move.b	#$2C,(Game_mode).w
		bra.w	GameLoop
	endif

; ---------------------------------------------------------------------------
; Checksum testing subroutine
; The instructions to loop over the entire ROM and branch to the incorrect
; checksum routine have been NOPed out, so this is quite useless
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Test_Checksum:
		btst	#6,(HW_Expansion_Control).l
		beq.s	+
		cmpi.l	#Ref_Checksum_String,(Checksum_string).w
		beq.w	.Done

+
		movea.l	#ErrorTrap,a6
		move.l	(ROMEndLoc).w,d6
		moveq	#0,d7
		add.w	(a6)+,d7
		cmp.l	a6,d6
		nop
		nop
		cmp.w	(Checksum).w,d7
		nop
		nop
		lea	(System_stack).w,a6
		moveq	#0,d7
		move.w	#bytesToLcnt($1F0),d6

-
		move.l	d7,(a6)+
		dbf	d6,-	; clear RAM from $FFFE00 to $FFFFEF
		move.b	(HW_Version).l,d6
		andi.b	#$C0,d6
		move.b	d6,(Graphics_flags).w
		move.l	#Ref_Checksum_String,(Checksum_string).w

.Done:
		rts
; End of function Test_Checksum

; ---------------------------------------------------------------------------

SonicAndKnucklesStartup:
		bsr.s	Test_Checksum
		move.w	d1,(SK_alone_flag).w
		bsr.w	DetectPAL
		bsr.w	Init_VDP
		bsr.w	SndDrvInit
		bsr.w	Init_Controllers
		jsr	(SRAM_Load).l
		move.b	#0,(Game_mode).w

GameLoop:
-
		move.b	(Game_mode).w,d0
		andi.w	#$7C,d0
		movea.l	.Modes(pc,d0.w),a0
		jsr	(a0)
		bra.s	- ;GameLoop
; ---------------------------------------------------------------------------
;GameModes:
.Modes:
		dc.l Sega_Screen		;   0
		dc.l Title_Screen		;   4
		dc.l Level			;   8
		dc.l Level			;  $C
		dc.l JumpToSegaScreen		; $10
		dc.l ContinueScreen		; $14
		dc.l JumpToSegaScreen		; $18
		dc.l LevelSelect_S2Options	; $1C
		dc.l S3Credits			; $20
		dc.l LevelSelect_S2Options	; $24
		dc.l LevelSelect_S2Options	; $28
		dc.l BlueSpheresTitle		; $2C
		dc.l BlueSpheresResults		; $30
		dc.l SpecialStage		; $34
		dc.l Competition_Menu		; $38
		dc.l Competition_PlayerSelect	; $3C
		dc.l Competition_LevelSelect	; $40
		dc.l Competition_Results	; $44
		dc.l SpecialStage_Results	; $48
		dc.l SaveScreen			; $4C
		dc.l TimeAttack_Records		; $50
; ---------------------------------------------------------------------------

JumpToSegaScreen:
		move.b	#0,(Game_mode).w
		rts
; ---------------------------------------------------------------------------
; unused/dead code
; weird routine, makes the screen go haywire pretty much

ChecksumError2:
		move.l	d1,-(sp)
		bsr.w	Init_VDP
		move.l	(sp)+,d1

- ;.Loop:
		move.l	#vdpComm($0000,CRAM,WRITE),(VDP_control_port).l
		move.w	d7,(VDP_data_port).l
		addq.w	#1,d7
		bra.s	- ;.Loop
; ---------------------------------------------------------------------------
; unused/dead code

ChecksumError:
		move.l	#vdpComm($0000,CRAM,WRITE),(VDP_control_port).l
		moveq	#bytesToWcnt($80),d7

- ;.loop:
		move.w	#$E,(VDP_data_port).l
		dbf	d7,- ;.loop	; fill entire CRAM with red

;ChecksumError_Loop:
		bra.s	* ;ChecksumError_Loop

; =============== S U B R O U T I N E =======================================


DetectPAL:
		lea	(VDP_control_port).l,a5
		move.w	#$8174,(a5)		; VDP Command $8174 - Display on, VInt on, DMA on, PAL off
		moveq	#0,d0

$$waitForVBlankStart:
		move.w	(a5),d1
		andi.w	#8,d1
		beq.s	$$waitForVBlankStart

$$waitForVBlankEnd:
		move.w	(a5),d1
		andi.w	#8,d1
		bne.s	$$waitForVBlankEnd	; Wait for VBlank to run once

$$waitForNextVBlank:
		addq.w	#1,d0
		move.w	(a5),d1
		andi.w	#8,d1
		beq.s	$$waitForNextVBlank
		move.w	d0,(V_blank_cycles).w	; Count cycles between VBlanks (likely to detect PAL systems and/or for other timing mechanisms
		rts
; End of function DetectPAL

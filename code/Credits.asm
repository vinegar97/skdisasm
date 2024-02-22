; =============== S U B R O U T I N E =======================================


sub_5B18E:
		move.w	(_unkFA86).w,d0
		move.w	off_5B19A(pc,d0.w),d0
		jmp	off_5B19A(pc,d0.w)
; End of function sub_5B18E

; ---------------------------------------------------------------------------
off_5B19A:
		dc.w loc_5B1A2-off_5B19A
		dc.w loc_5B1F4-off_5B19A
		dc.w loc_5B204-off_5B19A
		dc.w locret_5B2D4-off_5B19A
; ---------------------------------------------------------------------------

loc_5B1A2:
		addq.w	#2,(_unkFA86).w
		clr.b	(_unkFACC).w
		clr.l	(Camera_Y_pos).w
		clr.l	(V_scroll_value).w
		clr.w	(_unkFAAE).w
		cmpi.w	#3,(Player_mode).w
		bne.s	loc_5B1D2
		jsr	(AllocateObject).l
		bne.s	loc_5B1D2
		move.l	#Obj_Song_Fade_Transition,(a1)
		move.b	#mus_CreditsK,subtype(a1)

loc_5B1D2:
		bsr.w	sub_5B514
		move.w	#$EEE,(Normal_palette+$2).w
		move.w	#$EE,(Normal_palette_line_2+$2).w
		lea	PLC_SKCredits(pc),a1
		jmp	(Load_PLC_Raw).l
; ---------------------------------------------------------------------------
PLC_SKCredits: plrlistheader
		plreq $347, ArtNem_CreditsText
PLC_SKCredits_End
; ---------------------------------------------------------------------------

loc_5B1F4:
		subq.w	#1,(_unkF660).w
		bpl.s	locret_5B202
		addq.w	#2,(_unkFA86).w
		bsr.w	sub_5B42A

locret_5B202:
		rts
; ---------------------------------------------------------------------------

loc_5B204:
		move.l	(Camera_Y_pos).w,d0
		move.l	d0,d1
		add.l	(_unkFAC8).w,d0
		move.l	d0,(Camera_Y_pos).w
		swap	d0
		swap	d1
		eor.w	d0,d1
		btst	#4,d1
		beq.s	locret_5B282
		lsl.w	#4,d0
		addi.w	#$E00,d0
		move.w	d0,d1
		andi.w	#$F00,d1
		bsr.w	sub_5B2D6
		moveq	#0,d2
		tst.w	(SK_alone_flag).w
		beq.s	loc_5B238
		moveq	#8,d2

loc_5B238:
		add.w	(_unkFAAE).w,d2
		movea.l	off_5B284(pc,d2.w),a1
		move.w	(_unkFA84).w,d2
		move.w	(a1,d2.w),d2
		lea	(a1,d2.w),a1
		move.w	(a1)+,d2
		cmpi.w	#-8,d2
		beq.s	loc_5B294
		cmpi.w	#-$C,d2
		beq.s	loc_5B29E
		move.w	d2,d3
		andi.w	#$FF00,d0
		andi.w	#$FF00,d3
		cmp.w	d0,d3
		bne.s	locret_5B282
		move.w	#make_art_tile($347,0,1),d6
		bclr	#0,d2
		beq.s	loc_5B276
		move.w	#make_art_tile($347,1,1),d6

loc_5B276:
		andi.w	#$FFE,d2
		bsr.w	sub_5B318
		addq.w	#2,(_unkFA84).w

locret_5B282:
		rts
; ---------------------------------------------------------------------------
off_5B284:
		dc.l CreditsText_Part1
		dc.l CreditsText_Part2
		dc.l CreditsText_Part1_SK
		dc.l CreditsText_Part2_SK
; ---------------------------------------------------------------------------

loc_5B294:
		addq.w	#4,(_unkFAAE).w
		clr.w	(_unkFA84).w
		rts
; ---------------------------------------------------------------------------

loc_5B29E:
		addq.w	#2,(_unkFA86).w
		clr.l	(Timer).w
		st	(Events_fg_4).w
		st	(_unkFACC).w
		cmpi.w	#3,(Player_mode).w
		beq.s	loc_5B2B8
		rts
; ---------------------------------------------------------------------------

loc_5B2B8:
		tst.b	(_unkFA88).w
		bmi.s	loc_5B2CE
		jsr	(AllocateObject).l
		bne.s	locret_5B2CC
		move.l	#Obj_5EF68,(a1)

locret_5B2CC:
		rts
; ---------------------------------------------------------------------------

loc_5B2CE:
		clr.b	(_unkFAB9).w
		rts
; ---------------------------------------------------------------------------

locret_5B2D4:
		rts

; =============== S U B R O U T I N E =======================================


sub_5B2D6:
		move	#$2700,sr
		lea	(VDP_data_port).l,a6
		move.w	d1,d2
		addi.w	#VRAM_Plane_A_Name_Table,d2
		swap	d2
		clr.w	d2
		swap	d2
		lsl.l	#2,d2
		lsr.w	#2,d2
		ori.w	#$4000,d2
		swap	d2
		move.l	#$80<<16,d3
		moveq	#0,d4
		moveq	#2-1,d5

loc_5B300:
		move.l	d2,VDP_control_port-VDP_data_port(a6)
		moveq	#$28-1,d6

loc_5B306:
		move.w	d4,(a6)
		dbf	d6,loc_5B306
		add.l	d3,d2
		dbf	d5,loc_5B300
		move	#$2300,sr

locret_5B316:
		rts
; End of function sub_5B2D6


; =============== S U B R O U T I N E =======================================


sub_5B318:
		bsr.w	sub_5B36C
		move	#$2700,sr
		lea	(VDP_data_port).l,a6
		addi.w	#VRAM_Plane_A_Name_Table,d2
		swap	d2
		clr.w	d2
		swap	d2
		lsl.l	#2,d2
		lsr.w	#2,d2
		ori.w	#$4000,d2
		swap	d2
		move.l	d2,d3
		addi.l	#$80<<16,d3
		lea	(Chunk_table+$7000).l,a1
		move.l	d2,VDP_control_port-VDP_data_port(a6)
		subq.w	#1,d0
		move.w	d0,d1

loc_5B350:
		move.w	(a1)+,(a6)
		dbf	d0,loc_5B350
		lea	(Chunk_table+$7080).l,a1
		move.l	d3,VDP_control_port-VDP_data_port(a6)

loc_5B360:
		move.w	(a1)+,(a6)
		dbf	d1,loc_5B360
		move	#$2300,sr
		rts
; End of function sub_5B318


; =============== S U B R O U T I N E =======================================


sub_5B36C:
		lea	(Chunk_table+$7000).l,a2
		lea	(Chunk_table+$7080).l,a3
		moveq	#0,d0

loc_5B37A:
		moveq	#0,d1
		move.b	(a1)+,d1
		beq.s	locret_5B316
		cmpi.b	#" ",d1
		beq.w	loc_5B420
		cmpi.b	#"?",d1
		beq.w	loc_5B418
		cmpi.b	#"!",d1
		beq.s	loc_5B410
		cmpi.b	#"&",d1
		beq.s	loc_5B408
		cmpi.b	#")",d1
		beq.s	loc_5B400
		cmpi.b	#"(",d1
		beq.s	loc_5B3F8
		cmpi.b	#".",d1
		beq.s	loc_5B3F0
		cmpi.b	#"I",d1
		beq.s	loc_5B3DC
		addq.w	#2,d0
		subi.b	#"A",d1
		lsl.w	#3,d1
		lea	CreditsText_PlaneMap(pc),a4
		adda.w	d1,a4

loc_5B3C2:
		move.w	(a4)+,d5
		add.w	d6,d5
		move.w	d5,(a2)+
		move.w	(a4)+,d5
		add.w	d6,d5
		move.w	d5,(a2)+
		move.w	(a4)+,d5
		add.w	d6,d5
		move.w	d5,(a3)+
		move.w	(a4)+,d5
		add.w	d6,d5
		move.w	d5,(a3)+
		bra.s	loc_5B37A
; ---------------------------------------------------------------------------

loc_5B3DC:
		addq.w	#1,d0
		lea	CreditsText_PlaneMap.LetterI(pc),a4

loc_5B3E2:
		move.w	(a4)+,d5
		add.w	d6,d5
		move.w	d5,(a2)+
		move.w	(a4)+,d5
		add.w	d6,d5
		move.w	d5,(a3)+
		bra.s	loc_5B37A
; ---------------------------------------------------------------------------

loc_5B3F0:
		addq.w	#1,d0
		lea	CreditsText_PlaneMap.Period(pc),a4
		bra.s	loc_5B3E2
; ---------------------------------------------------------------------------

loc_5B3F8:
		addq.w	#1,d0
		lea	CreditsText_PlaneMap.LeftBracket(pc),a4
		bra.s	loc_5B3E2
; ---------------------------------------------------------------------------

loc_5B400:
		addq.w	#1,d0
		lea	CreditsText_PlaneMap.RightBracket(pc),a4
		bra.s	loc_5B3E2
; ---------------------------------------------------------------------------

loc_5B408:
		addq.w	#2,d0
		lea	CreditsText_PlaneMap.Ampersand(pc),a4
		bra.s	loc_5B3C2
; ---------------------------------------------------------------------------

loc_5B410:
		addq.w	#1,d0
		lea	CreditsText_PlaneMap.Exclamation(pc),a4
		bra.s	loc_5B3E2
; ---------------------------------------------------------------------------

loc_5B418:
		addq.w	#2,d0
		lea	CreditsText_PlaneMap.QuestionMark(pc),a4
		bra.s	loc_5B3C2
; ---------------------------------------------------------------------------

loc_5B420:
		addq.w	#1,d0
		clr.w	(a2)+
		clr.w	(a3)+
		bra.w	loc_5B37A
; End of function sub_5B36C


; =============== S U B R O U T I N E =======================================


sub_5B42A:
		lea	(ArtKosM_ANDKnuckles).l,a1
		move.w	#tiles_to_bytes($3EF),d2
		jsr	(Queue_Kos_Module).l
		move.w	(Player_mode).w,d0
		moveq	#0,d1
		andi.w	#3,d0
		subq.w	#2,d0
		bmi.s	loc_5B452
		beq.s	loc_5B44E
		addi.w	#$18,d1

loc_5B44E:
		addi.w	#$18,d1

loc_5B452:
		tst.w	(SK_alone_flag).w
		bne.s	loc_5B45C
		addi.w	#$C,d1

loc_5B45C:
		tst.b	(_unkFA88).w
		bmi.s	loc_5B46C
		beq.s	loc_5B468
		addi.w	#4,d1

loc_5B468:
		addi.w	#4,d1

loc_5B46C:
		movea.l	off_5B472(pc,d1.w),a2
		jmp	(a2)
; End of function sub_5B42A

; ---------------------------------------------------------------------------
off_5B472:
		dc.l loc_5B4C4
		dc.l loc_5B4C4
		dc.l loc_5B4C4
		dc.l sub_5B4E8
		dc.l sub_5B4E8
		dc.l loc_5B4F8
		dc.l sub_5B4E8
		dc.l sub_5B4E8
		dc.l loc_5B4F8
		dc.l sub_5B4E8
		dc.l sub_5B4E8
		dc.l loc_5B4F8
		dc.l loc_5B4C4
		dc.l loc_5B4BA
		dc.l loc_5B4BA
		dc.l sub_5B4E8
		dc.l loc_5B4DE
		dc.l loc_5B4D4
; ---------------------------------------------------------------------------

loc_5B4BA:
		lea	PLC_CreditsKnuxPose(pc),a1
		jsr	(Load_PLC_Raw).l

loc_5B4C4:
		lea	(ArtKosM_SKPoseBanner).l,a1
		move.w	#tiles_to_bytes($415),d2
		jmp	(Queue_Kos_Module).l
; ---------------------------------------------------------------------------

loc_5B4D4:
		lea	PLC_S3EndingGraphics(pc),a1
		jsr	(Load_PLC_Raw).l

loc_5B4DE:
		lea	PLC_CreditsKnuxPose(pc),a1
		jsr	(Load_PLC_Raw).l

; =============== S U B R O U T I N E =======================================


sub_5B4E8:
		lea	(ArtKosM_S3PoseBanner).l,a1
		move.w	#tiles_to_bytes($415),d2
		jmp	(Queue_Kos_Module).l
; End of function sub_5B4E8

; ---------------------------------------------------------------------------

loc_5B4F8:
		bsr.s	sub_5B4E8
		lea	PLC_S3EndingGraphics(pc),a1
		jmp	(Load_PLC_Raw).l
; ---------------------------------------------------------------------------
PLC_S3EndingGraphics: plrlistheader
		plreq $45D, ArtNem_S3EndingGraphics
PLC_S3EndingGraphics_End

PLC_CreditsKnuxPose: plrlistheader
		plreq $2C1, ArtNem_KnuxEndPose
PLC_CreditsKnuxPose_End

; =============== S U B R O U T I N E =======================================


sub_5B514:
		moveq	#0,d1
		tst.w	(SK_alone_flag).w
		bne.s	loc_5B520
		addi.w	#$24,d1

loc_5B520:
		btst	#6,(Graphics_flags).w
		beq.s	loc_5B52C
		addi.w	#$12,d1

loc_5B52C:
		move.w	(Player_mode).w,d0
		subq.w	#2,d0
		bmi.s	loc_5B53E
		beq.s	loc_5B53A
		addi.w	#6,d1

loc_5B53A:
		addi.w	#6,d1

loc_5B53E:
		tst.b	(_unkFA88).w
		bmi.s	loc_5B54A
		beq.s	loc_5B548
		addq.w	#2,d1

loc_5B548:
		addq.w	#2,d1

loc_5B54A:
		lea	CreditsText_ScrollSpeed(pc),a1
		moveq	#0,d0
		move.w	(a1,d1.w),d0
		lsl.l	#8,d0
		move.l	d0,(_unkFAC8).w
		lea	CreditsText_ScrollDelay(pc),a1
		move.w	(a1,d1.w),(_unkF660).w
		rts
; End of function sub_5B514

; ---------------------------------------------------------------------------
CreditsText_PlaneMap:
		dc.w      0,  $800,     1,     2	; A
		dc.w      3,     4,     5,     6	; B
		dc.w      7,     8,     9,    $A	; C
		dc.w      3,  $807,    $B,  $809	; D
		dc.w      3,    $C,     5,    $D	; E
		dc.w      3,    $C,    $E,    $F	; F
		dc.w      7,     8,     9,   $10	; G
		dc.w    $11,  $811,    $E, $180B	; H
.LetterI:	dc.w    $11,   $12,     0,     0	; I
		dc.w    $13,  $811,   $14,   $15	; J
		dc.w    $16,   $17,   $18,   $19	; K
		dc.w    $11,   $13,    $B,   $1A	; L
		dc.w    $1B,   $1C,   $1D,   $1E	; M
		dc.w    $1B,  $811,   $1D,   $1F	; N
		dc.w      7,  $807,     9,  $809	; O
		dc.w    $20,   $21,   $22,   $23	; P
		dc.w      7,  $807,     9,   $24	; Q
		dc.w    $20,   $21,   $25,   $26	; R
		dc.w   $821,    $C,   $27,     6	; S
		dc.w    $28,   $29,   $2A,   $2B	; T
		dc.w    $11,  $811,  $815,   $15	; U
		dc.w    $2C,  $82C,   $2D,  $82D	; V
		dc.w    $2E,  $811,   $2F,   $30	; W
		dc.w    $31,  $831,   $32,  $832	; X
		dc.w    $31,   $33,   $2A,   $2B	; Y
		dc.w   $80C,   $34,   $35,   $36	; Z
.Period:	dc.w    $13,   $37			; .
.LeftBracket:	dc.w    $38, $1038			; (
.RightBracket:	dc.w   $838, $1838			; )
.Ampersand:	dc.w    $39,   $3A,   $3B,   $3C	; &
.Exclamation:	dc.w   $812,   $3D			; !
.QuestionMark:	dc.w  $180A,   $3E,   $3F,   $40	; ?
CreditsText_ScrollDelay:
		; S&K NTSC     None  Chaos Emeralds  Super Emeralds
		dc.w      13*60  +0,      11*60 +30,      13*60  +0	; Sonic
		dc.w      12*60 +30,      12*60 +30,      12*60 +30	; Tails (unused)
		dc.w       2*60 +45,       2*60  +0,       2*60  +0	; Knuckles
		; S&K PAL      None  Chaos Emeralds  Super Emeralds
		dc.w      11*50  +0,       8*50 +48,      11*50  +0	; Sonic
		dc.w       1*50 +10,       1*50 +10,       1*50 +10	; Tails (unused)
		dc.w       2*50 +35,       3*50  +0,       2*50  +0	; Knuckles
		; S3K NTSC     None  Chaos Emeralds  Super Emeralds
		dc.w      12*60 +30,      11*60  +0,              0	; Sonic
		dc.w      12*60 +30,      12*60 +30,              0	; Tails
		dc.w       2*60 +45,       2*60  +0,       2*60  +0	; Knuckles
		; S3K PAL      None  Chaos Emeralds  Super Emeralds
		dc.w      10*50 +20,       8*50 +13,              0	; Sonic
		dc.w      10*50 +20,      10*50 +20,              0	; Tails
		dc.w       2*50  +0,       3*50  +0,       3*50  +0	; Knuckles
CreditsText_ScrollSpeed:
		; S&K NTSC     None  Chaos Emeralds  Super Emeralds
		dc.w            $C3,            $C3,            $C3	; Sonic
		dc.w           $100,           $100,           $100	; Tails (unused)
		dc.w            $BD,            $B1,            $B1	; Knuckles
		; S&K PAL      None  Chaos Emeralds  Super Emeralds
		dc.w            $E8,            $E8,           $100	; Sonic
		dc.w           $100,           $100,           $100	; Tails (unused)
		dc.w            $E5,            $D6,           $100	; Knuckles
		; S3K NTSC     None  Chaos Emeralds  Super Emeralds
		dc.w            $CE,            $CE,            $CF	; Sonic
		dc.w            $CE,            $CE,            $CD	; Tails
		dc.w            $C8,            $BC,            $BC	; Knuckles
		; S3K PAL      None  Chaos Emeralds  Super Emeralds
		dc.w            $F5,            $F5,            $FD	; Sonic
		dc.w            $F5,            $F5,            $FB	; Tails
		dc.w            $F2,            $E2,            $E2	; Knuckles
CreditsText_Part1_SK:
		dc.w byte_5B72E-CreditsText_Part1_SK
		dc.w byte_5B744-CreditsText_Part1_SK
		dc.w byte_5B756-CreditsText_Part1_SK
		dc.w byte_5B76A-CreditsText_Part1_SK
		dc.w byte_5B77C-CreditsText_Part1_SK
		dc.w byte_5B78E-CreditsText_Part1_SK
		dc.w byte_5B7A0-CreditsText_Part1_SK
		dc.w byte_5B7AC-CreditsText_Part1_SK
		dc.w byte_5B7B8-CreditsText_Part1_SK
		dc.w byte_5B7C4-CreditsText_Part1_SK
		dc.w byte_5B7D8-CreditsText_Part1_SK
		dc.w byte_5B7EE-CreditsText_Part1_SK
		dc.w byte_5B802-CreditsText_Part1_SK
		dc.w byte_5B81A-CreditsText_Part1_SK
		dc.w byte_5B82E-CreditsText_Part1_SK
		dc.w byte_5B840-CreditsText_Part1_SK
		dc.w byte_5B852-CreditsText_Part1_SK
		dc.w byte_5B85E-CreditsText_Part1_SK
		dc.w byte_5B874-CreditsText_Part1_SK
		dc.w byte_5B886-CreditsText_Part1_SK
		dc.w byte_5B89A-CreditsText_Part1_SK
		dc.w byte_5B8B0-CreditsText_Part1_SK
		dc.w byte_5B8C6-CreditsText_Part1_SK
		dc.w byte_5B8D4-CreditsText_Part1_SK
		dc.w byte_5B8E4-CreditsText_Part1_SK
		dc.w byte_5B8F4-CreditsText_Part1_SK
		dc.w byte_5B908-CreditsText_Part1_SK
		dc.w byte_5B918-CreditsText_Part1_SK
		dc.w byte_5B928-CreditsText_Part1_SK
		dc.w byte_5B938-CreditsText_Part1_SK
		dc.w byte_5B948-CreditsText_Part1_SK
		dc.w byte_5B958-CreditsText_Part1_SK
		dc.w byte_5B96E-CreditsText_Part1_SK
		dc.w byte_5B982-CreditsText_Part1_SK
		dc.w byte_5B992-CreditsText_Part1_SK
		dc.w byte_5B9A2-CreditsText_Part1_SK
byte_5B72E:	dc.b $F
		dc.b 7
		dc.b "EXECUTIVE PRODUCER",0
		even
byte_5B744:	dc.b $11
		dc.b $E
		dc.b "HAYAO NAKAYAMA",0
		even
byte_5B756:	dc.b $21
		dc.b $B
		dc.b "PROJECT MANAGERS",0
		even
byte_5B76A:	dc.b $23
		dc.b $10
		dc.b "HISASHI SUZUKI",0
		even
byte_5B77C:	dc.b $24
		dc.b $E
		dc.b "SHINOBU TOYODA",0
		even
byte_5B78E:	dc.b $25
		dc.b $E
		dc.b "MASAHARU YOSHII",0
		even
byte_5B7A0:	dc.b $35
		dc.b $19
		dc.b "PRODUCER",0
		even
byte_5B7AC:	dc.b $37
		dc.b $18
		dc.b "YUJI NAKA",0
		even
byte_5B7B8:	dc.b $47
		dc.b $1B
		dc.b "DIRECTOR",0
		even
byte_5B7C4:	dc.b $49
		dc.b 8
		dc.b "HIROKAZU YASUHARA",0
		even
byte_5B7D8:	dc.b $59
		dc.b 9
		dc.b "LEAD GAME DESIGNER",0
		even
byte_5B7EE:	dc.b $5B
		dc.b 8
		dc.b "HIROKAZU YASUHARA",0
		even
byte_5B802:	dc.b $6B
		dc.b 3
		dc.b "SENIOR GAME DESIGNERS",0
		even
byte_5B81A:	dc.b $6D
		dc.b $A
		dc.b "HISAYOSHI YOSHIDA",0
		even
byte_5B82E:	dc.b $6E
		dc.b $10
		dc.b "TAKASHI IIZUKA",0
		even
byte_5B840:	dc.b $7E
		dc.b $B
		dc.b "LEAD PROGRAMMER",0
		even
byte_5B852:	dc.b $80
		dc.b $18
		dc.b "YUJI NAKA",0
		even
byte_5B85E:	dc.b $90
		dc.b 7
		dc.b "SENIOR PROGRAMMERS",0
		even
byte_5B874:	dc.b $92
		dc.b $C
		dc.b "TAKAHIRO HAMANO",0
		even
byte_5B886:	dc.b $93
		dc.b 8
		dc.b "MASANOBU YAMAMOTO",0
		even
byte_5B89A:	dc.b $A3
		dc.b 7
		dc.b "CHARACTER DESIGNER",0
		even
byte_5B8B0:	dc.b $A5
		dc.b 6
		dc.b "TAKASHI THOMAS YUDA",0
		even
byte_5B8C6:	dc.b $B5
		dc.b $17
		dc.b "C.G. ARTIST",0
		even
byte_5B8D4:	dc.b $B7
		dc.b $12
		dc.b "KUNITAKE AOKI",0
		even
byte_5B8E4:	dc.b $C7
		dc.b $13
		dc.b "ENEMY ARTIST",0
		even
byte_5B8F4:	dc.b $C9
		dc.b $A
		dc.b "SATOSHI YOKOKAWA",0
		even
byte_5B908:	dc.b $D9
		dc.b $11
		dc.b "SCENE ARTISTS",0
		even
byte_5B918:	dc.b $DB
		dc.b $12
		dc.b "KUNITAKE AOKI",0
		even
byte_5B928:	dc.b $DC
		dc.b $14
		dc.b "CHIE YOSHIDA",0
		even
byte_5B938:	dc.b $DD
		dc.b $12
		dc.b "TSUNEKO AOKI",0
		even
byte_5B948:	dc.b $DE
		dc.b $10
		dc.b "SHIGERU OKADA",0
		even
byte_5B958:	dc.b $DF
		dc.b 6
		dc.b "TAKASHI THOMAS YUDA",0
		even
byte_5B96E:	dc.b $E0
		dc.b $A
		dc.b "SATOSHI YOKOKAWA",0
		even
byte_5B982:	dc.b $F0
		dc.b $11
		dc.b "ART ASSISTANT",0
		even
byte_5B992:	dc.b $F2
		dc.b $12
		dc.b "OSAMU OHASHI",0
		even
byte_5B9A2:	dc.b $FF
		dc.b $F8
CreditsText_Part2_SK:
		dc.w byte_5B9F6-CreditsText_Part2_SK
		dc.w byte_5BA08-CreditsText_Part2_SK
		dc.w byte_5BA1A-CreditsText_Part2_SK
		dc.w byte_5BA2C-CreditsText_Part2_SK
		dc.w byte_5BA32-CreditsText_Part2_SK
		dc.w byte_5BA42-CreditsText_Part2_SK
		dc.w byte_5BA4A-CreditsText_Part2_SK
		dc.w byte_5BA5E-CreditsText_Part2_SK
		dc.w byte_5BA70-CreditsText_Part2_SK
		dc.w byte_5BA82-CreditsText_Part2_SK
		dc.w byte_5BA94-CreditsText_Part2_SK
		dc.w byte_5BAA2-CreditsText_Part2_SK
		dc.w byte_5BABA-CreditsText_Part2_SK
		dc.w byte_5BAD2-CreditsText_Part2_SK
		dc.w byte_5BAE2-CreditsText_Part2_SK
		dc.w byte_5BAF0-CreditsText_Part2_SK
		dc.w byte_5BB02-CreditsText_Part2_SK
		dc.w byte_5BB12-CreditsText_Part2_SK
		dc.w byte_5BB2A-CreditsText_Part2_SK
		dc.w byte_5BB3C-CreditsText_Part2_SK
		dc.w byte_5BB4C-CreditsText_Part2_SK
		dc.w byte_5BB62-CreditsText_Part2_SK
		dc.w byte_5BB72-CreditsText_Part2_SK
		dc.w byte_5BB88-CreditsText_Part2_SK
		dc.w byte_5BB92-CreditsText_Part2_SK
		dc.w byte_5BB9E-CreditsText_Part2_SK
		dc.w byte_5BBAC-CreditsText_Part2_SK
		dc.w byte_5BBBC-CreditsText_Part2_SK
		dc.w byte_5BBD4-CreditsText_Part2_SK
		dc.w byte_5BBE2-CreditsText_Part2_SK
		dc.w byte_5BBF0-CreditsText_Part2_SK
		dc.w byte_5BC04-CreditsText_Part2_SK
		dc.w byte_5BC14-CreditsText_Part2_SK
		dc.w byte_5BC26-CreditsText_Part2_SK
		dc.w byte_5BC38-CreditsText_Part2_SK
		dc.w byte_5BC48-CreditsText_Part2_SK
		dc.w byte_5BC5C-CreditsText_Part2_SK
		dc.w byte_5BC6A-CreditsText_Part2_SK
		dc.w byte_5BC7A-CreditsText_Part2_SK
		dc.w byte_5BC82-CreditsText_Part2_SK
		dc.w byte_5BC88-CreditsText_Part2_SK
byte_5B9F6:	dc.b 2
		dc.b $D
		dc.b "MUSIC COMPOSERS",0
		even
byte_5BA08:	dc.b 4
		dc.b $E
		dc.b "HOWARD DROSSIN",0
		even
byte_5BA1A:	dc.b $14
		dc.b $D
		dc.b "SEGA SOUND TEAM",0
		even
byte_5BA2C:	dc.b $16
		dc.b $24
		dc.b "BO",0
		even
byte_5BA32:	dc.b $17
		dc.b $12
		dc.b "SACHIO OGAWA",0
		even
byte_5BA42:	dc.b $18
		dc.b $20
		dc.b "MILPO",0
		even
byte_5BA4A:	dc.b $19
		dc.b $A
		dc.b "MASARU SETSUMARU",0
		even
byte_5BA5E:	dc.b $1A
		dc.b $C
		dc.b "TATSUYUKI MAEDA",0
		even
byte_5BA70:	dc.b $1B
		dc.b $C
		dc.b "TOMONORI SAWADA",0
		even
byte_5BA82:	dc.b $1C
		dc.b $E
		dc.b "MASAYUKI NAGAO",0
		even
byte_5BA94:	dc.b $1D
		dc.b $16
		dc.b "JUN SENOUE",0
		even
byte_5BAA2:	dc.b $2D
		dc.b 3
		dc.b "EXECUTIVE MANAGEMENT",0
		even
byte_5BABA:	dc.b $2F
		dc.b 6
		dc.b $53
		dc.b "HOUICHIROU IRIMAJIRI",0
		even
byte_5BAD2:	dc.b $30
		dc.b $12
		dc.b "TOM KALINSKE",0
		even
byte_5BAE2:	dc.b $31
		dc.b $16
		dc.b "PAUL RIOUX",0
		even
byte_5BAF0:	dc.b $41
		dc.b $D
		dc.b "PRODUCT MANAGER",0
		even
byte_5BB02:	dc.b $43
		dc.b $12
		dc.b "PAMELA KELLY",0
		even
byte_5BB12:	dc.b $53
		dc.b 3
		dc.b "EXECUTIVE COORDINATOR",0
		even
byte_5BB2A:	dc.b $55
		dc.b $E
		dc.b "MAMORU SHIGETA",0
		even
byte_5BB3C:	dc.b $56
		dc.b $14
		dc.b "TOMIO TAKAMI",0
		even
byte_5BB4C:	dc.b $57
		dc.b $A
		dc.b "DIANE A. FORNASIER ",0
		even
byte_5BB62:	dc.b $58
		dc.b $12
		dc.b "ROGER HECTOR",0
		even
byte_5BB72:	dc.b $59
		dc.b 4
		dc.b "TAKAHARU UTSUNOMIYA",0
		even
byte_5BB88:	dc.b $69
		dc.b $1B
		dc.b "TESTERS",0
		even
byte_5BB92:	dc.b $6B
		dc.b $16
		dc.b "JASON KUO",0
		even
byte_5BB9E:	dc.b $6C
		dc.b $16
		dc.b "RICK GREER",0
		even
byte_5BBAC:	dc.b $6D
		dc.b $12
		dc.b "MIKE WILLIAMS",0
		even
byte_5BBBC:	dc.b $7D
		dc.b 5
		dc.b "SOUND SPECIAL THANKS",0
		even
byte_5BBD4:	dc.b $7F
		dc.b $16
		dc.b "CUBE CORP.",0
		even
byte_5BBE2:	dc.b $80
		dc.b $16
		dc.b "OPUS CORP.",0
		even
byte_5BBF0:	dc.b $81
		dc.b 8
		dc.b "MASANORI NAKAYAMA",0
		even
byte_5BC04:	dc.b $82
		dc.b $14
		dc.b "(STUDIO WHO)",0
		even
byte_5BC14:	dc.b $92
		dc.b $F
		dc.b "SPECIAL THANKS",0
		even
byte_5BC26:	dc.b $94
		dc.b $10
		dc.b "JINA ISHIWATARI",0
		even
byte_5BC38:	dc.b $95
		dc.b $12
		dc.b "EMI KAWAMURA",0
		even
byte_5BC48:	dc.b $96
		dc.b 8
		dc.b "DEBORAH MCCRACKEN",0
		even
byte_5BC5C:	dc.b $97
		dc.b $14
		dc.b "TAKU MAKINO",0
		even
byte_5BC6A:	dc.b $AB
		dc.b $13
		dc.b "PRESENTED BY",0
		even
byte_5BC7A:	dc.b $AD
		dc.b $20
		dc.b "SEGA",0
		even
byte_5BC82:	dc.b $BD
		dc.b $20
		dc.b "  ",0
		even
byte_5BC88:	dc.b $FF
		dc.b $F4
CreditsText_Part1:
		dc.w byte_5BCD2-CreditsText_Part1
		dc.w byte_5BCE8-CreditsText_Part1
		dc.w byte_5BCFA-CreditsText_Part1
		dc.w byte_5BD0E-CreditsText_Part1
		dc.w byte_5BD20-CreditsText_Part1
		dc.w byte_5BD32-CreditsText_Part1
		dc.w byte_5BD44-CreditsText_Part1
		dc.w byte_5BD50-CreditsText_Part1
		dc.w byte_5BD5C-CreditsText_Part1
		dc.w byte_5BD68-CreditsText_Part1
		dc.w byte_5BD7C-CreditsText_Part1
		dc.w byte_5BD92-CreditsText_Part1
		dc.w byte_5BDA6-CreditsText_Part1
		dc.w byte_5BDBE-CreditsText_Part1
		dc.w byte_5BDD2-CreditsText_Part1
		dc.w byte_5BDE4-CreditsText_Part1
		dc.w byte_5BDF6-CreditsText_Part1
		dc.w byte_5BE02-CreditsText_Part1
		dc.w byte_5BE18-CreditsText_Part1
		dc.w byte_5BE2A-CreditsText_Part1
		dc.w byte_5BE3E-CreditsText_Part1
		dc.w byte_5BE54-CreditsText_Part1
		dc.w byte_5BE6A-CreditsText_Part1
		dc.w byte_5BE78-CreditsText_Part1
		dc.w byte_5BE88-CreditsText_Part1
		dc.w byte_5BE98-CreditsText_Part1
		dc.w byte_5BEAC-CreditsText_Part1
		dc.w byte_5BEBC-CreditsText_Part1
		dc.w byte_5BECC-CreditsText_Part1
		dc.w byte_5BEDC-CreditsText_Part1
		dc.w byte_5BEEC-CreditsText_Part1
		dc.w byte_5BEFC-CreditsText_Part1
		dc.w byte_5BF12-CreditsText_Part1
		dc.w byte_5BF26-CreditsText_Part1
		dc.w byte_5BF36-CreditsText_Part1
		dc.w byte_5BF46-CreditsText_Part1
byte_5BCD2:	dc.b $F
		dc.b 7
		dc.b "EXECUTIVE PRODUCER",0
		even
byte_5BCE8:	dc.b $11
		dc.b $E
		dc.b "HAYAO NAKAYAMA",0
		even
byte_5BCFA:	dc.b $21
		dc.b $B
		dc.b "PROJECT MANAGERS",0
		even
byte_5BD0E:	dc.b $23
		dc.b $10
		dc.b "HISASHI SUZUKI",0
		even
byte_5BD20:	dc.b $24
		dc.b $E
		dc.b "SHINOBU TOYODA",0
		even
byte_5BD32:	dc.b $25
		dc.b $E
		dc.b "MASAHARU YOSHII",0
		even
byte_5BD44:	dc.b $35
		dc.b $19
		dc.b "PRODUCER",0
		even
byte_5BD50:	dc.b $37
		dc.b $18
		dc.b "YUJI NAKA",0
		even
byte_5BD5C:	dc.b $47
		dc.b $1B
		dc.b "DIRECTOR",0
		even
byte_5BD68:	dc.b $49
		dc.b 8
		dc.b "HIROKAZU YASUHARA",0
		even
byte_5BD7C:	dc.b $59
		dc.b 9
		dc.b "LEAD GAME DESIGNER",0
		even
byte_5BD92:	dc.b $5B
		dc.b 8
		dc.b "HIROKAZU YASUHARA",0
		even
byte_5BDA6:	dc.b $6B
		dc.b 3
		dc.b "SENIOR GAME DESIGNERS",0
		even
byte_5BDBE:	dc.b $6D
		dc.b $A
		dc.b "HISAYOSHI YOSHIDA",0
		even
byte_5BDD2:	dc.b $6E
		dc.b $10
		dc.b "TAKASHI IIZUKA",0
		even
byte_5BDE4:	dc.b $7E
		dc.b $B
		dc.b "LEAD PROGRAMMER",0
		even
byte_5BDF6:	dc.b $80
		dc.b $18
		dc.b "YUJI NAKA",0
		even
byte_5BE02:	dc.b $90
		dc.b 7
		dc.b "SENIOR PROGRAMMERS",0
		even
byte_5BE18:	dc.b $92
		dc.b $C
		dc.b "TAKAHIRO HAMANO",0
		even
byte_5BE2A:	dc.b $93
		dc.b 8
		dc.b "MASANOBU YAMAMOTO",0
		even
byte_5BE3E:	dc.b $A3
		dc.b 7
		dc.b "CHARACTER DESIGNER",0
		even
byte_5BE54:	dc.b $A5
		dc.b 6
		dc.b "TAKASHI THOMAS YUDA",0
		even
byte_5BE6A:	dc.b $B5
		dc.b $17
		dc.b "C.G. ARTIST",0
		even
byte_5BE78:	dc.b $B7
		dc.b $12
		dc.b "KUNITAKE AOKI",0
		even
byte_5BE88:	dc.b $C7
		dc.b $13
		dc.b "ENEMY ARTIST",0
		even
byte_5BE98:	dc.b $C9
		dc.b $A
		dc.b "SATOSHI YOKOKAWA",0
		even
byte_5BEAC:	dc.b $D9
		dc.b $11
		dc.b "SCENE ARTISTS",0
		even
byte_5BEBC:	dc.b $DB
		dc.b $12
		dc.b "KUNITAKE AOKI",0
		even
byte_5BECC:	dc.b $DC
		dc.b $14
		dc.b "CHIE YOSHIDA",0
		even
byte_5BEDC:	dc.b $DD
		dc.b $12
		dc.b "TSUNEKO AOKI",0
		even
byte_5BEEC:	dc.b $DE
		dc.b $10
		dc.b "SHIGERU OKADA",0
		even
byte_5BEFC:	dc.b $DF
		dc.b 6
		dc.b "TAKASHI THOMAS YUDA",0
		even
byte_5BF12:	dc.b $E0
		dc.b $A
		dc.b "SATOSHI YOKOKAWA",0
		even
byte_5BF26:	dc.b $F0
		dc.b $11
		dc.b "ART ASSISTANT",0
		even
byte_5BF36:	dc.b $F2
		dc.b $12
		dc.b "OSAMU OHASHI",0
		even
byte_5BF46:	dc.b $FF
		dc.b $F8
CreditsText_Part2:
		dc.w byte_5BFAE-CreditsText_Part2
		dc.w byte_5BFC0-CreditsText_Part2
		dc.w byte_5BFCE-CreditsText_Part2
		dc.w byte_5BFDE-CreditsText_Part2
		dc.w byte_5BFEC-CreditsText_Part2
		dc.w byte_5BFFA-CreditsText_Part2
		dc.w byte_5C00E-CreditsText_Part2
		dc.w byte_5C01A-CreditsText_Part2
		dc.w byte_5C02C-CreditsText_Part2
		dc.w byte_5C03E-CreditsText_Part2
		dc.w byte_5C044-CreditsText_Part2
		dc.w byte_5C054-CreditsText_Part2
		dc.w byte_5C05C-CreditsText_Part2
		dc.w byte_5C070-CreditsText_Part2
		dc.w byte_5C082-CreditsText_Part2
		dc.w byte_5C094-CreditsText_Part2
		dc.w byte_5C0A6-CreditsText_Part2
		dc.w byte_5C0B4-CreditsText_Part2
		dc.w byte_5C0C8-CreditsText_Part2
		dc.w byte_5C0D8-CreditsText_Part2
		dc.w byte_5C0F0-CreditsText_Part2
		dc.w byte_5C108-CreditsText_Part2
		dc.w byte_5C118-CreditsText_Part2
		dc.w byte_5C126-CreditsText_Part2
		dc.w byte_5C138-CreditsText_Part2
		dc.w byte_5C148-CreditsText_Part2
		dc.w byte_5C160-CreditsText_Part2
		dc.w byte_5C172-CreditsText_Part2
		dc.w byte_5C182-CreditsText_Part2
		dc.w byte_5C198-CreditsText_Part2
		dc.w byte_5C1A8-CreditsText_Part2
		dc.w byte_5C1BE-CreditsText_Part2
		dc.w byte_5C1C8-CreditsText_Part2
		dc.w byte_5C1D4-CreditsText_Part2
		dc.w byte_5C1E2-CreditsText_Part2
		dc.w byte_5C1F2-CreditsText_Part2
		dc.w byte_5C20A-CreditsText_Part2
		dc.w byte_5C222-CreditsText_Part2
		dc.w byte_5C22A-CreditsText_Part2
		dc.w byte_5C238-CreditsText_Part2
		dc.w byte_5C246-CreditsText_Part2
		dc.w byte_5C25A-CreditsText_Part2
		dc.w byte_5C26A-CreditsText_Part2
		dc.w byte_5C27C-CreditsText_Part2
		dc.w byte_5C28E-CreditsText_Part2
		dc.w byte_5C29E-CreditsText_Part2
		dc.w byte_5C2B2-CreditsText_Part2
		dc.w byte_5C2C0-CreditsText_Part2
		dc.w byte_5C2D0-CreditsText_Part2
		dc.w byte_5C2D8-CreditsText_Part2
		dc.w byte_5C2DE-CreditsText_Part2
byte_5BFAE:	dc.b 2
		dc.b $D
		dc.b "MUSIC COMPOSERS",0
		even
byte_5BFC0:	dc.b 4
		dc.b $16
		dc.b "BRAD BUXER",0
		even
byte_5BFCE:	dc.b 5
		dc.b $12
		dc.b "BOBBY BROOKS",0
		even
byte_5BFDE:	dc.b 6
		dc.b $14
		dc.b "DARRYL ROSS",0
		even
byte_5BFEC:	dc.b 7
		dc.b $14
		dc.b "GEOFF GRACE",0
		even
byte_5BFFA:	dc.b 8
		dc.b $E
		dc.b "DOUG GRIGSBY III",0
		even
byte_5C00E:	dc.b 9
		dc.b $1A
		dc.b "SCIROCCO",0
		even
byte_5C01A:	dc.b $A
		dc.b $E
		dc.b "HOWARD DROSSIN",0
		even
byte_5C02C:	dc.b $1A
		dc.b $D
		dc.b "SEGA SOUND TEAM",0
		even
byte_5C03E:	dc.b $1C
		dc.b $24
		dc.b "BO",0
		even
byte_5C044:	dc.b $1D
		dc.b $12
		dc.b "SACHIO OGAWA",0
		even
byte_5C054:	dc.b $1E
		dc.b $20
		dc.b "MILPO",0
		even
byte_5C05C:	dc.b $1F
		dc.b $A
		dc.b "MASARU SETSUMARU",0
		even
byte_5C070:	dc.b $20
		dc.b $C
		dc.b "TATSUYUKI MAEDA",0
		even
byte_5C082:	dc.b $21
		dc.b $C
		dc.b "TOMONORI SAWADA",0
		even
byte_5C094:	dc.b $22
		dc.b $E
		dc.b "MASAYUKI NAGAO",0
		even
byte_5C0A6:	dc.b $23
		dc.b $16
		dc.b "JUN SENOUE",0
		even
byte_5C0B4:	dc.b $33
		dc.b 9
		dc.b "SOUND COORDINATOR",0
		even
byte_5C0C8:	dc.b $35
		dc.b $14
		dc.b "HISAKI NIMIYA",0
		even
byte_5C0D8:	dc.b $45
		dc.b 3
		dc.b "EXECUTIVE MANAGEMENT",0
		even
byte_5C0F0:	dc.b $47
		dc.b 6
		dc.b "SHOUICHIROU IRIMAJIRI",0
		even
byte_5C108:	dc.b $48
		dc.b $12
		dc.b "TOM KALINSKE",0
		even
byte_5C118:	dc.b $49
		dc.b $16
		dc.b "PAUL RIOUX",0
		even
byte_5C126:	dc.b $59
		dc.b $D
		dc.b "PRODUCT MANAGER",0
		even
byte_5C138:	dc.b $5B
		dc.b $12
		dc.b "PAMELA KELLY",0
		even
byte_5C148:	dc.b $6B
		dc.b 3
		dc.b "EXECUTIVE COORDINATOR",0
		even
byte_5C160:	dc.b $6D
		dc.b $E
		dc.b "MAMORU SHIGETA",0
		even
byte_5C172:	dc.b $6E
		dc.b $14
		dc.b "TOMIO TAKAMI",0
		even
byte_5C182:	dc.b $6F
		dc.b $A
		dc.b "DIANE A. FORNASIER ",0
		even
byte_5C198:	dc.b $70
		dc.b $12
		dc.b "ROGER HECTOR",0
		even
byte_5C1A8:	dc.b $71
		dc.b 4
		dc.b "TAKAHARU UTSUNOMIYA",0
		even
byte_5C1BE:	dc.b $81
		dc.b $1B
		dc.b "TESTERS",0
		even
byte_5C1C8:	dc.b $83
		dc.b $16
		dc.b "JASON KUO",0
		even
byte_5C1D4:	dc.b $84
		dc.b $16
		dc.b "RICK GREER",0
		even
byte_5C1E2:	dc.b $85
		dc.b $12
		dc.b "MIKE WILLIAMS",0
		even
byte_5C1F2:	dc.b $95
		dc.b 5
		dc.b "SOUND SPECIAL THANKS",0
		even
byte_5C20A:	dc.b $97
		dc.b 6
		dc.b "MAYUMI NINA SAKAZAKI",0
		even
byte_5C222:	dc.b $98
		dc.b $20
		dc.b "(MRM)",0
		even
byte_5C22A:	dc.b $99
		dc.b $16
		dc.b "CUBE CORP.",0
		even
byte_5C238:	dc.b $9A
		dc.b $16
		dc.b "OPUS CORP.",0
		even
byte_5C246:	dc.b $9B
		dc.b 8
		dc.b "MASANORI NAKAYAMA",0
		even
byte_5C25A:	dc.b $9C
		dc.b $14
		dc.b "(STUDIO WHO)",0
		even
byte_5C26A:	dc.b $AC
		dc.b $F
		dc.b "SPECIAL THANKS",0
		even
byte_5C27C:	dc.b $AE
		dc.b $10
		dc.b "JINA ISHIWATARI",0
		even
byte_5C28E:	dc.b $AF
		dc.b $12
		dc.b "EMI KAWAMURA",0
		even
byte_5C29E:	dc.b $B0
		dc.b 8
		dc.b "DEBORAH MCCRACKEN",0
		even
byte_5C2B2:	dc.b $B1
		dc.b $14
		dc.b "TAKU MAKINO",0
		even
byte_5C2C0:	dc.b $C5
		dc.b $13
		dc.b "PRESENTED BY",0
		even
byte_5C2D0:	dc.b $C7
		dc.b $20
		dc.b "SEGA",0
		even
byte_5C2D8:	dc.b $D7
		dc.b $20
		dc.b "  ",0
		even
byte_5C2DE:	dc.b $FF
		dc.b $F4

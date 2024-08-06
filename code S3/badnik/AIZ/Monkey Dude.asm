Obj_MonkeyDude:
		jsr	Obj_WaitOffscreen(pc)
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	.Index(pc,d0.w),d1
		jsr	.Index(pc,d1.w)
		jmp	Sprite_CheckDeleteTouch(pc)
; ---------------------------------------------------------------------------
.Index:
		dc.w loc_54F6E-.Index
		dc.w loc_54FB8-.Index
		dc.w loc_54FD6-.Index
; ---------------------------------------------------------------------------

loc_54F6E:
		lea	ObjDat_MonkeyDude(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		moveq	#0,d0
		move.b	subtype(a0),d0
		lsr.w	#2,d0
		move.b	d0,subtype(a0)
		lsr.w	#1,d0
		move.b	d0,$39(a0)
		move.l	#byte_554B0,$30(a0)
		move.w	#60-1,$2E(a0)
		move.l	#loc_54FBE,$34(a0)
		btst	#0,render_flags(a0)
		bne.w	+ ;loc_54FB0
		lea	ChildObjDat_5547C(pc),a2
		jmp	CreateChild4_LinkListRepeated(pc)
; ---------------------------------------------------------------------------

+ ;loc_54FB0:
		lea	ChildObjDat_55482(pc),a2
		jmp	CreateChild4_LinkListRepeated(pc)
; ---------------------------------------------------------------------------

loc_54FB8:
		jmp	(loc_53CD6).l
; ---------------------------------------------------------------------------

loc_54FBE:
		move.b	#4,routine(a0)
		clr.b	anim_frame(a0)
		clr.b	anim_frame_timer(a0)
		move.l	#byte_554B4,$30(a0)
		rts
; ---------------------------------------------------------------------------

loc_54FD6:
		jsr	Animate_RawMultiDelay(pc)
		tst.w	d2
		beq.s	locret_54FFE
		btst	#2,$38(a0)
		bne.s	+ ;loc_55000
		cmpi.b	#0,mapping_frame(a0)
		bne.s	locret_54FFE
		addq.w	#8,y_pos(a0)
		subq.b	#1,$39(a0)
		cmpi.b	#1,$39(a0)
		beq.s	++ ;loc_55014

locret_54FFE:
		rts
; ---------------------------------------------------------------------------

+ ;loc_55000:
		cmpi.b	#2,mapping_frame(a0)
		bne.s	locret_54FFE
		subq.b	#1,$39(a0)
		beq.s	+ ;loc_55014
		subq.w	#8,y_pos(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_55014:
		move.b	#2,routine(a0)
		move.b	subtype(a0),$39(a0)
		bchg	#2,$38(a0)
		move.w	#60-1,$2E(a0)
		move.l	#byte_554B0,$30(a0)
		move.b	#0,mapping_frame(a0)
		clr.b	anim_frame(a0)
		clr.b	anim_frame_timer(a0)
		rts
; ---------------------------------------------------------------------------

loc_55044:
		bset	#3,$38(a0)

loc_5504A:
		lea	word_55462(pc),a1
		jsr	SetUp_ObjAttributes3(pc)
		clr.b	routine(a0)
		move.b	subtype(a0),d0
		add.b	d0,d0
		move.b	d0,$3B(a0)
		move.b	d0,$3A(a0)
		tst.b	subtype(a0)
		bne.s	++ ;loc_5508E
		move.l	#loc_550C8,(a0)
		moveq	#$E,d0
		btst	#3,$38(a0)
		bne.s	+ ;loc_5507C
		neg.w	d0

+ ;loc_5507C:
		add.w	d0,x_pos(a0)
		subq.w	#2,y_pos(a0)
		move.w	y_pos(a0),$3E(a0)
		jmp	Child_Draw_Sprite(pc)
; ---------------------------------------------------------------------------

+ ;loc_5508E:
		cmpi.b	#8,subtype(a0)
		beq.s	+ ;loc_550A0
		move.l	#loc_55218,(a0)
		jmp	Child_Draw_Sprite(pc)
; ---------------------------------------------------------------------------

+ ;loc_550A0:
		move.l	#loc_55248,(a0)
		move.b	#6,mapping_frame(a0)
		movea.w	parent3(a0),a1
		movea.w	parent3(a1),a1
		move.w	a1,$3E(a0)
		movea.w	parent3(a1),a1
		movea.w	parent3(a1),a1
		move.w	a1,$44(a0)
		jmp	Child_Draw_Sprite(pc)
; ---------------------------------------------------------------------------

loc_550C8:
		bsr.w	sub_552FC
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_550DE(pc,d0.w),d1
		jsr	off_550DE(pc,d1.w)
		jmp	Child_Draw_Sprite(pc)
; ---------------------------------------------------------------------------
off_550DE:
		dc.w loc_550EA-off_550DE
		dc.w loc_55126-off_550DE
		dc.w loc_5517E-off_550DE
		dc.w loc_551B0-off_550DE
		dc.w loc_551E6-off_550DE
		dc.w loc_5512C-off_550DE
; ---------------------------------------------------------------------------

loc_550EA:
		move.b	$3C(a0),d0
		btst	#3,$38(a0)
		beq.s	+ ;loc_55104
		addq.b	#4,d0
		cmpi.b	#$80,d0
		bhs.s	++ ;loc_55112
		move.b	d0,$3C(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_55104:
		subq.b	#4,d0
		cmpi.b	#$80,d0
		bls.s	+ ;loc_55112
		move.b	d0,$3C(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_55112:
		move.b	#2,routine(a0)

loc_55118:
		bsr.w	sub_55434
		move.l	#loc_5516C,$34(a0)

locret_55124:
		rts
; ---------------------------------------------------------------------------

loc_55126:
		bsr.w	sub_55320
		beq.s	loc_55170

loc_5512C:
		btst	#3,$38(a0)
		beq.s	+ ;loc_5514A
		move.b	$41(a0),d1
		bsr.w	sub_5533C
		subi.b	#$20,d0
		cmpi.b	#$60,d0
		bhs.s	++ ;loc_5515C
		bra.w	+++ ;loc_55168
; ---------------------------------------------------------------------------

+ ;loc_5514A:
		move.b	$41(a0),d1
		bsr.w	sub_5533C
		subi.b	#$80,d0
		cmpi.b	#$60,d0
		blo.s	++ ;loc_55168

+ ;loc_5515C:
		neg.w	$40(a0)
		move.b	$41(a0),d1
		bsr.w	sub_5533C

+ ;loc_55168:
		jmp	Obj_Wait(pc)
; ---------------------------------------------------------------------------

loc_5516C:
		bra.w	sub_55434
; ---------------------------------------------------------------------------

loc_55170:
		move.b	#4,routine(a0)
		bset	#1,$38(a0)
		rts
; ---------------------------------------------------------------------------

loc_5517E:
		btst	#3,$38(a0)
		beq.s	+ ;loc_55194
		moveq	#4,d1
		bsr.w	sub_5533C
		cmpi.b	#-$40,d0
		bhs.s	++ ;loc_551A2
		rts
; ---------------------------------------------------------------------------

+ ;loc_55194:
		moveq	#-4,d1
		bsr.w	sub_5533C
		cmpi.b	#$40,d0
		bls.s	+ ;loc_551A2
		rts
; ---------------------------------------------------------------------------

+ ;loc_551A2:
		move.b	#6,routine(a0)
		bset	#2,$38(a0)
		rts
; ---------------------------------------------------------------------------

loc_551B0:
		btst	#3,$38(a0)
		beq.s	+ ;loc_551C6
		moveq	#-8,d1
		bsr.w	sub_5533C
		moveq	#$60,d1
		cmp.b	d1,d0
		bls.s	++ ;loc_551D4
		rts
; ---------------------------------------------------------------------------

+ ;loc_551C6:
		moveq	#8,d1
		bsr.w	sub_5533C
		moveq	#-$60,d1
		cmp.b	d1,d0
		bhs.s	+ ;loc_551D4
		rts
; ---------------------------------------------------------------------------

+ ;loc_551D4:
		move.b	#8,routine(a0)
		move.b	d1,$3C(a0)
		bclr	#1,$38(a0)
		rts
; ---------------------------------------------------------------------------

loc_551E6:
		btst	#3,$38(a0)
		bne.s	+ ;loc_551FC
		moveq	#-2,d1
		bsr.w	sub_5533C
		moveq	#-$80,d1
		cmp.b	d1,d0
		bls.s	++ ;loc_5520A
		rts
; ---------------------------------------------------------------------------

+ ;loc_551FC:
		moveq	#2,d1
		bsr.w	sub_5533C
		moveq	#-$80,d1
		cmp.b	d1,d0
		bhs.s	+ ;loc_5520A
		rts
; ---------------------------------------------------------------------------

+ ;loc_5520A:
		move.b	#$A,routine(a0)
		move.b	d1,$3C(a0)
		bra.w	loc_55118
; ---------------------------------------------------------------------------

loc_55218:
		bsr.w	sub_55314
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_5522E(pc,d0.w),d1
		jsr	off_5522E(pc,d1.w)
		jmp	Child_Draw_Sprite(pc)
; ---------------------------------------------------------------------------
off_5522E:
		dc.w loc_55234-off_5522E
		dc.w loc_5523E-off_5522E
		dc.w loc_5523A-off_5522E
; ---------------------------------------------------------------------------

loc_55234:
		moveq	#2,d1
		bsr.w	sub_55366

loc_5523A:
		bra.w	loc_55348
; ---------------------------------------------------------------------------

loc_5523E:
		moveq	#4,d1
		bsr.w	sub_5538E
		bra.w	loc_55348
; ---------------------------------------------------------------------------

loc_55248:
		bsr.w	sub_55314
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_5525E(pc,d0.w),d1
		jsr	off_5525E(pc,d1.w)
		jmp	Child_Draw_Sprite(pc)
; ---------------------------------------------------------------------------
off_5525E:
		dc.w loc_55264-off_5525E
		dc.w loc_5526E-off_5525E
		dc.w loc_5526A-off_5525E
; ---------------------------------------------------------------------------

loc_55264:
		moveq	#2,d1
		bsr.w	sub_55366

loc_5526A:
		bra.w	loc_55348
; ---------------------------------------------------------------------------

loc_5526E:
		bsr.w	sub_553B0
		moveq	#4,d1
		bsr.w	sub_5538E
		bra.w	loc_55348
; ---------------------------------------------------------------------------

loc_5527C:
		lea	word_55468(pc),a1
		jsr	SetUp_ObjAttributes2(pc)
		move.l	#loc_552B2,(a0)
		move.l	#byte_554B9,$30(a0)
		move.l	#loc_552C6,$34(a0)
		move.b	#8,y_radius(a0)
		move.w	#-$200,x_vel(a0)
		move.w	#-$400,y_vel(a0)
		jmp	(Sprite_CheckDeleteTouch3).l
; ---------------------------------------------------------------------------

loc_552B2:
		jsr	(MoveSprite_LightGravity).l
		jsr	Animate_RawMultiDelay(pc)
		jsr	ObjHitFloor_DoRoutine(pc)
		jmp	(Sprite_CheckDeleteTouch3).l
; ---------------------------------------------------------------------------

loc_552C6:
		move.l	#loc_552CE,(a0)
		rts
; ---------------------------------------------------------------------------

loc_552CE:
		jmp	(Sprite_CheckDeleteTouch3).l
; ---------------------------------------------------------------------------
		movea.w	parent3(a0),a1
		move.b	render_flags(a1),d0
		btst	#3,$38(a0)
		beq.s	+ ;loc_552E8
		bchg	#0,d0

+ ;loc_552E8:
		move.w	#$200,priority(a0)
		btst	#0,d0
		beq.s	locret_552FA
		move.w	#$300,priority(a0)

locret_552FA:
		rts

; =============== S U B R O U T I N E =======================================


sub_552FC:
		movea.w	parent3(a0),a1
		move.w	y_pos(a1),d0
		subq.w	#2,d0
		tst.b	mapping_frame(a1)
		beq.s	+ ;loc_5530E
		subq.w	#2,d0

+ ;loc_5530E:
		move.w	d0,y_pos(a0)
		rts
; End of function sub_552FC


; =============== S U B R O U T I N E =======================================


sub_55314:
		movea.w	parent3(a0),a1
		move.w	priority(a1),priority(a0)
		rts
; End of function sub_55314


; =============== S U B R O U T I N E =======================================


sub_55320:
		jsr	Find_SonicTails(pc)
		cmpi.w	#$80,d2
		bhs.s	++ ;loc_55338
		btst	#3,$38(a0)
		beq.s	+ ;loc_55334
		subq.w	#2,d0

+ ;loc_55334:
		tst.w	d0
		rts
; ---------------------------------------------------------------------------

+ ;loc_55338:
		moveq	#1,d4
		rts
; End of function sub_55320


; =============== S U B R O U T I N E =======================================


sub_5533C:
		move.b	$3C(a0),d0
		add.b	d1,d0
		move.b	d0,$3C(a0)
		rts
; End of function sub_5533C

; ---------------------------------------------------------------------------

loc_55348:
		subq.b	#1,$3B(a0)
		bne.s	+ ;loc_5535E
		move.b	$3A(a0),$3B(a0)
		movea.w	parent3(a0),a1
		move.b	$3C(a1),$3C(a0)

+ ;loc_5535E:
		moveq	#5,d2
		jsr	MoveSprite_CircularSimple(pc)
		rts

; =============== S U B R O U T I N E =======================================


sub_55366:
		movea.w	parent3(a0),a1
		btst	#1,$38(a1)
		beq.s	locret_5538C
		move.b	d1,routine(a0)
		bset	#1,$38(a0)
		move.b	$3A(a0),d0
		lsr.b	#1,d0
		move.b	d0,$3A(a0)
		move.b	#1,$3B(a0)

locret_5538C:
		rts
; End of function sub_55366


; =============== S U B R O U T I N E =======================================


sub_5538E:
		movea.w	parent3(a0),a1
		btst	#1,$38(a1)
		bne.s	locret_553AE
		move.b	d1,routine(a0)
		move.b	$3A(a0),d0
		add.b	d0,d0
		move.b	d0,$3A(a0)
		move.b	#1,$3B(a0)

locret_553AE:
		rts
; End of function sub_5538E


; =============== S U B R O U T I N E =======================================


sub_553B0:
		btst	#3,$38(a0)
		beq.s	+ ;loc_553DC
		btst	#0,$38(a0)
		bne.w	locret_55124
		movea.w	$44(a0),a1
		btst	#2,$38(a1)
		beq.s	locret_553DA
		movea.w	$3E(a0),a1
		cmpi.b	#-$7C,$3C(a1)
		blo.s	++ ;loc_55406

locret_553DA:
		rts
; ---------------------------------------------------------------------------

+ ;loc_553DC:
		btst	#0,$38(a0)
		bne.w	locret_55124
		movea.w	$44(a0),a1
		btst	#2,$38(a1)
		beq.s	locret_553DA
		movea.w	$3E(a0),a1
		cmpi.b	#$7C,$3C(a1)
		blo.w	locret_55124
		move.w	#make_art_tile($548,1,0),art_tile(a0)

+ ;loc_55406:
		bset	#0,$38(a0)
		move.b	#4,mapping_frame(a0)
		moveq	#signextendB(sfx_MissileThrow),d0
		jsr	(Play_SFX).l
		lea	(ChildObjDat_55498).l,a2
		jsr	CreateChild2_Complex(pc)
		bne.s	locret_553DA
		btst	#3,$38(a0)
		beq.s	locret_553DA
		neg.w	x_vel(a1)
		rts
; End of function sub_553B0


; =============== S U B R O U T I N E =======================================


sub_55434:
		jsr	(Random_Number).l
		move.w	(RNG_seed).w,d0
		moveq	#1,d1
		btst	#0,d0
		beq.s	+ ;loc_55448
		neg.w	d1

+ ;loc_55448:
		move.w	d1,$40(a0)
		andi.w	#$3C,d0
		move.w	d0,$2E(a0)
		rts
; End of function sub_55434

; ---------------------------------------------------------------------------
ObjDat_MonkeyDude:
		dc.l Map_MonkeyDude
		dc.w make_art_tile($548,1,0)
		dc.w   $280
		dc.b  $20, $20,   0,  $B
word_55462:
		dc.w   $300
		dc.b    4,   4,   3,   0
word_55468:
		dc.w make_art_tile($548,1,1)
		dc.w   $280
		dc.b  $20, $20,   6,  $B
ObjDat3_55470:
		dc.l Map_MonkeyDude
		dc.w make_art_tile($548,0,0)
		dc.w   $280
		dc.b  $20, $20,   6, $98
ChildObjDat_5547C:
		dc.w 5-1
		dc.l loc_5504A
ChildObjDat_55482:
		dc.w 5-1
		dc.l loc_55044
		dc.w 1-1
		dc.l loc_5504A
		dc.b    0,   8
		dc.w 1-1
		dc.l loc_5527C
		dc.b    0,   0
ChildObjDat_55498:
		dc.w 1-1
		dc.l loc_54B46
		dc.l ObjDat3_55470
		dc.l 0
		dc.l MoveSprite_LightGravity
		dc.b    0,   0
		dc.w  -$200, -$400
byte_554B0:
		dc.b    7,   0,   1, $FC
byte_554B4:
		dc.b    0,   7
		dc.b    2,   7
		dc.b  $FC
byte_554B9:
		dc.b    8,  $F
		dc.b    8,  $F
		dc.b    9,  $F
		dc.b   $A,  $F
		dc.b  $F8,  $A
		dc.b    6, $7E
		dc.b  $FC
		even
; ---------------------------------------------------------------------------

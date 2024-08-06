Obj_TechnoSqueek:
		jsr	(Obj_WaitOffscreen).l

Obj_TechnoSqueek_2:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	.Index(pc,d0.w),d1
		jsr	.Index(pc,d1.w)
		jmp	Sprite_CheckDeleteTouch(pc)
; ---------------------------------------------------------------------------
.Index:
		dc.w loc_89842-.Index
		dc.w loc_898DC-.Index
		dc.w loc_8992E-.Index
		dc.w loc_8995C-.Index
		dc.w loc_899A0-.Index
; ---------------------------------------------------------------------------

loc_89842:
		move.w	#$800,$2E(a0)
		move.l	#loc_89926,$34(a0)
		cmpi.b	#4,subtype(a0)
		beq.s	loc_8989E
		lea	ObjDat_89B06(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		move.l	#byte_89B2C,$30(a0)
		bset	#0,render_flags(a0)
		cmpi.b	#2,subtype(a0)
		bne.s	loc_8987C
		bset	#1,render_flags(a0)

loc_8987C:
		lea	ChildObjDat_89B24(pc),a2
		jsr	CreateChild1_Normal(pc)
		move.w	#$400,d0
		move.w	d0,$3A(a0)
		move.w	d0,x_vel(a0)
		move.w	#$20,$3C(a0)
		bclr	#3,$38(a0)
		rts
; ---------------------------------------------------------------------------

loc_8989E:
		lea	ObjDat3_89B12(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		move.b	#6,routine(a0)
		move.l	#byte_89B52,$30(a0)
		bset	#1,render_flags(a0)
		lea	ChildObjDat_89B24(pc),a2
		jsr	CreateChild1_Normal(pc)
		move.w	#$400,d0
		move.w	d0,$3E(a0)
		move.w	d0,y_vel(a0)
		move.w	#$20,$40(a0)
		bclr	#0,$38(a0)
		rts
; ---------------------------------------------------------------------------

loc_898DC:
		jsr	Animate_RawMultiDelayFlipX(pc)
		tst.w	d2
		beq.s	loc_898F2
		cmpi.b	#6,anim_frame(a0)
		bne.s	loc_898F2
		bset	#1,$38(a0)

loc_898F2:
		jsr	Swing_LeftAndRight(pc)
		tst.w	x_vel(a0)
		beq.s	loc_89906
		jsr	(MoveSprite2).l
		jmp	Obj_Wait(pc)
; ---------------------------------------------------------------------------

loc_89906:
		move.b	#4,routine(a0)
		move.l	#byte_89B42,$30(a0)
		move.l	#loc_89932,$34(a0)

loc_8991C:
		clr.b	anim_frame(a0)
		clr.b	anim_frame_timer(a0)
		rts
; ---------------------------------------------------------------------------

loc_89926:
		bclr	#5,$38(a0)

locret_8992C:
		rts
; ---------------------------------------------------------------------------

loc_8992E:
		jmp	Animate_RawAdjustFlipX(pc)
; ---------------------------------------------------------------------------

loc_89932:
		move.b	#2,routine(a0)
		move.l	#byte_89B37,$30(a0)

loc_89940:
		bclr	#1,$38(a0)
		bset	#5,$38(a0)
		move.w	#$10,$2E(a0)
		move.l	#loc_89926,$34(a0)
		bra.s	loc_8991C
; ---------------------------------------------------------------------------

loc_8995C:
		jsr	Animate_RawMultiDelayFlipY(pc)
		tst.w	d2
		beq.s	loc_89972
		cmpi.b	#6,anim_frame(a0)
		bne.s	loc_89972
		bset	#1,$38(a0)

loc_89972:
		jsr	Swing_UpAndDown(pc)
		tst.w	y_vel(a0)
		beq.s	loc_89986
		jsr	(MoveSprite2).l
		jmp	Obj_Wait(pc)
; ---------------------------------------------------------------------------

loc_89986:
		move.b	#8,routine(a0)
		move.l	#byte_89B68,$30(a0)
		move.l	#loc_899A4,$34(a0)
		bra.w	loc_8991C
; ---------------------------------------------------------------------------

loc_899A0:
		jmp	Animate_RawAdjustFlipY(pc)
; ---------------------------------------------------------------------------

loc_899A4:
		move.b	#6,routine(a0)
		move.l	#byte_89B5D,$30(a0)
		bra.s	loc_89940
; ---------------------------------------------------------------------------

loc_899B4:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_899C6(pc,d0.w),d1
		jsr	off_899C6(pc,d1.w)
		jmp	Child_Draw_Sprite(pc)
; ---------------------------------------------------------------------------
off_899C6:
		dc.w loc_899CC-off_899C6
		dc.w loc_899E8-off_899C6
		dc.w loc_89A20-off_899C6
; ---------------------------------------------------------------------------

loc_899CC:
		lea	word_89B1E(pc),a1
		jsr	SetUp_ObjAttributes3(pc)
		movea.w	parent3(a0),a1
		cmpi.b	#4,subtype(a1)
		bne.s	locret_899E6
		move.b	#4,routine(a0)

locret_899E6:
		rts
; ---------------------------------------------------------------------------

loc_899E8:
		lea	byte_89B4D(pc),a1
		jsr	Animate_RawNoSST(pc)
		movea.w	parent3(a0),a1
		moveq	#0,d0
		move.b	mapping_frame(a1),d0
		btst	#1,$38(a1)
		beq.s	loc_89A04
		moveq	#2,d0

loc_89A04:
		add.w	d0,d0
		move.w	byte_89A1A(pc,d0.w),child_dx(a0)	; and child_dy
		btst	#5,$38(a1)
		bne.w	locret_8992C
		jmp	Refresh_ChildPositionAdjusted(pc)
; ---------------------------------------------------------------------------
byte_89A1A:
		dc.b  $14,   4
		dc.b   $C,   4
		dc.b    0,   4
		even
; ---------------------------------------------------------------------------

loc_89A20:
		lea	byte_89B73(pc),a1
		jsr	Animate_RawNoSST(pc)
		movea.w	parent3(a0),a1
		moveq	#0,d0
		move.b	mapping_frame(a1),d0
		subq.w	#5,d0
		btst	#1,$38(a1)
		beq.s	loc_89A3E
		moveq	#2,d0

loc_89A3E:
		add.w	d0,d0
		move.w	byte_89A54(pc,d0.w),child_dx(a0)	; and child_dy
		btst	#5,$38(a1)
		bne.w	locret_8992C
		jmp	Refresh_ChildPositionAdjusted(pc)
; ---------------------------------------------------------------------------
byte_89A54:
		dc.b   -4, $14
		dc.b   -4,  $C
		dc.b   -4,   0
		even
; ---------------------------------------------------------------------------

loc_89A5A:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_89A6C(pc,d0.w),d1
		jsr	off_89A6C(pc,d1.w)
		jmp	Sprite_CheckDeleteTouch(pc)
; ---------------------------------------------------------------------------
off_89A6C:
		dc.w loc_89A70-off_89A6C
		dc.w loc_89AA2-off_89A6C
; ---------------------------------------------------------------------------

loc_89A70:
		lea	ObjDat_89B06(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		move.b	#7,y_radius(a0)
		move.l	#loc_89AB6,$34(a0)
		move.w	#$90,d0
		jsr	(Set_IndexedVelocity).l
		jsr	(Change_FlipXWithVelocity).l
		clr.b	subtype(a0)
		lea	ChildObjDat_89B24(pc),a2
		jmp	CreateChild1_Normal(pc)
; ---------------------------------------------------------------------------

loc_89AA2:
		jsr	(MoveSprite_LightGravity).l
		tst.w	y_vel(a0)
		bmi.w	locret_8992C
		jmp	(ObjHitFloor_DoRoutine).l
; ---------------------------------------------------------------------------

loc_89AB6:
		move.l	#Obj_TechnoSqueek_2,(a0)
		move.b	#2,routine(a0)
		move.w	#$800,$2E(a0)
		move.l	#loc_89926,$34(a0)
		move.l	#byte_89B2C,$30(a0)
		move.w	#$400,d0
		move.w	d0,$3A(a0)
		bclr	#3,$38(a0)
		btst	#0,render_flags(a0)
		bne.s	loc_89AF6
		neg.w	d0
		bset	#3,$38(a0)

loc_89AF6:
		move.w	d0,x_vel(a0)
		move.w	#$20,$3C(a0)
		clr.w	y_vel(a0)
		rts
; ---------------------------------------------------------------------------
ObjDat_89B06:
		dc.l Map_TechnoSqueek
		dc.w make_art_tile($52E,1,1)
		dc.w   $280
		dc.b   $C,   8,   0,  $B
ObjDat3_89B12:
		dc.l Map_TechnoSqueek
		dc.w make_art_tile($52E,1,1)
		dc.w   $280
		dc.b    8,  $C,   5,  $B
word_89B1E:
		dc.w   $280
		dc.b    8,   4,   2,   0
ChildObjDat_89B24:
		dc.w 1-1
		dc.l loc_899B4
		dc.b  $14,   4
byte_89B2C:
		dc.b    0,       0
		dc.b    0,     $17
		dc.b    1,       1
		dc.b    1|$40,   1
		dc.b    0,     $1F
		dc.b  $F4
byte_89B37:
		dc.b    0,       0
		dc.b    0,     $37
		dc.b    1,       1
		dc.b    1|$40,   1
		dc.b    0,     $1F
		dc.b  $F4
byte_89B42:
		dc.b    3,   0,   0,   1, 1|$40,   0,   0,   1, 1|$40,   0, $F4
byte_89B4D:
		dc.b    3,   2,   3,   4, $FC
byte_89B52:
		dc.b    5,       0
		dc.b    5,     $17
		dc.b    6,       1
		dc.b    6|$40,   1
		dc.b    0,     $1F
		dc.b  $F4
byte_89B5D:
		dc.b    5,       0
		dc.b    5,     $37
		dc.b    6,       1
		dc.b    6|$40,   1
		dc.b    5,     $1F
		dc.b  $F4
byte_89B68:
		dc.b    3,   5,   5,   6, 6|$40,   5,   5,   6, 6|$40,   5, $F4
byte_89B73:
		dc.b    3,   7,   8,   9, $FC
		even
Map_TechnoSqueek:
		include "General/Sprites/Technosqueek/Map - Technosqueek.asm"
; ---------------------------------------------------------------------------

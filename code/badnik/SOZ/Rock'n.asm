Obj_Rockn:
		jsr	(Obj_WaitOffscreen).l
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	Rockn_Index(pc,d0.w),d1
		jsr	Rockn_Index(pc,d1.w)
		jmp	(Sprite_CheckDeleteTouch).l
; ---------------------------------------------------------------------------
Rockn_Index:
		dc.w loc_8EDC0-Rockn_Index
		dc.w loc_8EE1C-Rockn_Index
		dc.w loc_8EE3A-Rockn_Index
; ---------------------------------------------------------------------------

loc_8EDC0:
		lea	ObjDat3_8F04E(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.b	#7,y_radius(a0)
		move.b	subtype(a0),d0
		bne.s	loc_8EDE4
		clr.w	$3A(a0)
		move.w	#$7FFF,$3C(a0)
		bra.w	loc_8EE02
; ---------------------------------------------------------------------------

loc_8EDE4:
		move.b	d0,d1
		andi.w	#$F0,d0
		neg.w	d0
		add.w	x_pos(a0),d0
		move.w	d0,$3A(a0)
		andi.w	#$F,d1
		lsl.w	#4,d1
		add.w	x_pos(a0),d1
		move.w	d1,$3C(a0)

loc_8EE02:
		moveq	#-$80,d0
		btst	#0,render_flags(a0)
		beq.s	loc_8EE0E
		neg.w	d0

loc_8EE0E:
		move.w	d0,x_vel(a0)
		lea	ChildObjDat_8F072(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_8EE1C:
		btst	#2,$38(a0)
		beq.s	locret_8EE38
		move.b	#4,routine(a0)
		move.b	#$D9,collision_flags(a0)
		move.l	#loc_8EF1C,$34(a0)

locret_8EE38:
		rts
; ---------------------------------------------------------------------------

loc_8EE3A:
		lea	(byte_8F080).l,a1
		jsr	(Animate_RawNoSST).l
		bclr	#0,$38(a0)
		lea	(Player_1).w,a1
		move.w	x_pos(a1),d0
		cmp.w	$3A(a0),d0
		blo.s	loc_8EE86
		cmp.w	$3C(a0),d0
		bhs.s	loc_8EE86
		move.w	y_pos(a1),d1
		sub.w	y_pos(a0),d1
		bpl.s	loc_8EE6C
		neg.w	d1

loc_8EE6C:
		cmpi.w	#$10,d1
		bhs.s	loc_8EE86
		bset	#0,$38(a0)
		moveq	#-$80,d1
		sub.w	x_pos(a0),d0
		bcs.s	loc_8EE82
		neg.w	d1

loc_8EE82:
		move.w	d1,x_vel(a0)

loc_8EE86:
		tst.w	x_vel(a0)
		beq.s	loc_8EE92
		jsr	(ObjHitFloor2_DoRoutine).l

loc_8EE92:
		move.w	x_pos(a0),d0
		move.w	x_vel(a0),d1
		bne.s	loc_8EEA6
		btst	#0,$38(a0)
		bne.s	loc_8EEDC
		tst.w	d1

loc_8EEA6:
		bmi.s	loc_8EEBC
		move.w	#$80,d1
		bset	#0,render_flags(a0)
		cmp.w	$3C(a0),d0
		bhs.s	loc_8EECA
		bra.w	loc_8EED2
; ---------------------------------------------------------------------------

loc_8EEBC:
		moveq	#-$80,d1
		bclr	#0,render_flags(a0)
		cmp.w	$3A(a0),d0
		bhs.s	loc_8EED2

loc_8EECA:
		neg.w	d1
		bchg	#0,render_flags(a0)

loc_8EED2:
		move.w	d1,x_vel(a0)
		jsr	(MoveSprite2).l

loc_8EEDC:
		lea	word_8EF14(pc),a1
		jsr	(Check_PlayerInRange).l
		tst.w	d0
		beq.s	loc_8EEEE
		bsr.w	sub_8EEF4

loc_8EEEE:
		swap	d0
		tst.w	d0
		beq.s	locret_8EF12

; =============== S U B R O U T I N E =======================================


sub_8EEF4:
		movea.w	d0,a1
		jsr	(Check_PlayerAttack).l
		beq.s	locret_8EF12
		btst	#Status_InAir,status(a1)
		bne.s	locret_8EF12
		move.w	a1,$44(a0)
		jsr	(EnemyDefeated).l
		addq.w	#4,sp

locret_8EF12:
		rts
; End of function sub_8EEF4

; ---------------------------------------------------------------------------
word_8EF14:
		dc.w   -$29,   $52,  -$10,   $20
; ---------------------------------------------------------------------------

loc_8EF1C:
		btst	#0,$38(a0)
		bne.s	loc_8EF36
		moveq	#-$80,d0
		bchg	#0,render_flags(a0)
		bne.s	loc_8EF30
		neg.w	d0

loc_8EF30:
		move.w	d0,x_vel(a0)
		rts
; ---------------------------------------------------------------------------

loc_8EF36:
		clr.w	x_vel(a0)
		rts
; ---------------------------------------------------------------------------

loc_8EF3C:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_8EF7A(pc,d0.w),d1
		move.w	x_pos(a0),-(sp)
		jsr	off_8EF7A(pc,d1.w)
		moveq	#$23,d1
		moveq	#$10,d2
		moveq	#$11,d3
		move.w	(sp)+,d4
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.s	loc_8EF6E
		jsr	(SolidObjectFull).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_8EF6E:
		jsr	(Displace_PlayerOffObject).l
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------
off_8EF7A:
		dc.w loc_8EF84-off_8EF7A
		dc.w loc_8EF94-off_8EF7A
		dc.w loc_8EFC4-off_8EF7A
		dc.w loc_8EFD8-off_8EF7A
		dc.w loc_8EFF6-off_8EF7A
; ---------------------------------------------------------------------------

loc_8EF84:
		lea	ObjDat3_8F05A(pc),a1
		jsr	(SetUp_ObjAttributes).l
		jmp	(Refresh_ChildPositionAdjusted).l
; ---------------------------------------------------------------------------

loc_8EF94:
		lea	(Player_1).w,a1
		jsr	(Find_OtherObject).l
		cmpi.w	#$28,d2
		bhi.w	locret_8EE38
		cmpi.w	#$40,d3
		bhi.w	locret_8EE38
		move.b	#4,routine(a0)
		move.w	#7,$2E(a0)
		lea	ChildObjDat_8F07A(pc),a2
		jmp	(CreateChild6_Simple).l
; ---------------------------------------------------------------------------

loc_8EFC4:
		subq.w	#1,$2E(a0)
		bpl.s	locret_8EFD6
		move.b	#6,routine(a0)
		move.w	#7,$2E(a0)

locret_8EFD6:
		rts
; ---------------------------------------------------------------------------

loc_8EFD8:
		subq.w	#2,y_pos(a0)
		subq.w	#1,$2E(a0)
		bmi.s	loc_8EFE4
		rts
; ---------------------------------------------------------------------------

loc_8EFE4:
		move.b	#8,routine(a0)
		movea.w	parent3(a0),a1
		bset	#2,$38(a1)
		rts
; ---------------------------------------------------------------------------

loc_8EFF6:
		movea.w	parent3(a0),a1
		moveq	#-$18,d0
		tst.b	mapping_frame(a1)
		beq.s	loc_8F004
		moveq	#-$17,d0

loc_8F004:
		move.b	d0,child_dy(a0)
		jmp	(Refresh_ChildPositionAdjusted).l
; ---------------------------------------------------------------------------

loc_8F00E:
		lea	ObjDat3_8F066(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_8F024,(a0)
		move.w	#5,$2E(a0)

loc_8F024:
		subq.w	#1,$2E(a0)
		bpl.s	loc_8F036
		move.l	#loc_8F042,(a0)
		move.b	#3,mapping_frame(a0)

loc_8F036:
		jsr	(Refresh_ChildPositionAdjusted).l
		jmp	(Child_Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_8F042:
		jsr	(Refresh_ChildPositionAdjusted).l
		jmp	(Child_Draw_Sprite).l
; ---------------------------------------------------------------------------
ObjDat3_8F04E:
		dc.l Map_Rockn
		dc.w make_art_tile($500,1,0)
		dc.w   $280
		dc.b  $10,   8,   0,   0
ObjDat3_8F05A:
		dc.l Map_SOZBreakableSandRock
		dc.w make_art_tile($3D9,2,0)
		dc.w   $200
		dc.b  $18, $10,   0,   0
ObjDat3_8F066:
		dc.l Map_Rockn
		dc.w make_art_tile($500,1,0)
		dc.w   $180
		dc.b  $18, $10,   4,   0
ChildObjDat_8F072:
		dc.w 1-1
		dc.l loc_8EF3C
		dc.b    0,  -8
ChildObjDat_8F07A:
		dc.w 1-1
		dc.l loc_8F00E
byte_8F080:
		dc.b    8,   0,   1,   0,   2, $FC
		even
Map_Rockn:
		include "General/Sprites/Rockn/Map - Rock'n.asm"

; ' <-- lol TextWrangler; it assumes ' is the string delimiter for all assembly files; I don't want
;     my screen to be filled with pink
; ---------------------------------------------------------------------------

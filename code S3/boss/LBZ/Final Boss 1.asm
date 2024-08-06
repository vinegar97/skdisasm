Obj_LBZFinalBoss1:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	.Index(pc,d0.w),d1
		jsr	.Index(pc,d1.w)
		bsr.w	sub_500DA
		jmp	Draw_And_Touch_Sprite(pc)
; ---------------------------------------------------------------------------
.Index:
		dc.w loc_4F9CE-.Index
		dc.w loc_4FA2E-.Index
		dc.w loc_4FA46-.Index
		dc.w locret_4FAC2-.Index
		dc.w loc_4FAC4-.Index
		dc.w loc_4FADA-.Index
; ---------------------------------------------------------------------------

loc_4F9CE:
		lea	ObjDat_LBZFinalBoss1(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		move.b	#9,collision_property(a0)
		move.b	#1,(Boss_flag).w
		move.w	#$7F,$2E(a0)
		move.l	#loc_4FA32,$34(a0)
		moveq	#$71,d0
		jsr	(Load_PLC).l
		jsr	(AllocateObject).l
		bne.s	loc_4FA0C
		move.l	#Obj_Song_Fade_Transition,(a1)
		move.b	#mus_EndBoss,subtype(a1)

loc_4FA0C:
		lea	(Child1_MakeRoboHead3).l,a2
		jsr	CreateChild1_Normal(pc)
		lea	ChildObjDat_503B8(pc),a2
		jsr	CreateChild1_Normal(pc)
		lea	ChildObjDat_5032E(pc),a2
		jsr	CreateChild1_Normal(pc)
		lea	ChildObjDat_503B0(pc),a2
		jmp	CreateChild3_NormalRepeated(pc)
; ---------------------------------------------------------------------------

loc_4FA2E:
		jmp	Obj_Wait(pc)
; ---------------------------------------------------------------------------

loc_4FA32:
		move.b	#4,routine(a0)
		move.w	#-$100,y_vel(a0)
		lea	Pal_LBZFinalBoss1(pc),a1
		jmp	PalLoad_Line1(pc)
; ---------------------------------------------------------------------------

loc_4FA46:
		move.w	y_pos(a0),d0
		move.w	(Camera_Y_pos).w,d1
		tst.w	y_vel(a0)
		bmi.s	loc_4FA62
		addi.w	#$118,d1
		cmp.w	d1,d0
		bhs.s	loc_4FA70
		jmp	(MoveSprite2).l
; ---------------------------------------------------------------------------

loc_4FA62:
		subi.w	#$B0,d1
		cmp.w	d1,d0
		bls.s	loc_4FA70
		jmp	(MoveSprite2).l
; ---------------------------------------------------------------------------

loc_4FA70:
		cmpi.b	#2,collision_property(a0)
		bls.s	loc_4FA80
		btst	#3,$38(a0)
		beq.s	locret_4FABC

loc_4FA80:
		jsr	(Random_Number).l
		swap	d0
		moveq	#0,d1
		bclr	#0,render_flags(a0)
		btst	#0,d0
		beq.s	loc_4FA9E
		moveq	#2,d1
		bset	#0,render_flags(a0)

loc_4FA9E:
		move.w	word_4FABE(pc,d1.w),d1
		move.w	(Camera_X_pos).w,d2
		add.w	d1,d2
		move.w	d2,x_pos(a0)
		move.w	#$100,d0
		tst.w	y_vel(a0)
		bmi.s	loc_4FAB8
		neg.w	d0

loc_4FAB8:
		move.w	d0,y_vel(a0)

locret_4FABC:
		rts
; ---------------------------------------------------------------------------
word_4FABE:
		dc.w   $110
		dc.w    $30
; ---------------------------------------------------------------------------

locret_4FAC2:
		rts
; ---------------------------------------------------------------------------

loc_4FAC4:
		subq.b	#1,$40(a0)
		bmi.s	loc_4FACC
		rts
; ---------------------------------------------------------------------------

loc_4FACC:
		move.b	#$A,routine(a0)
		move.b	#4,$40(a0)

locret_4FAD8:
		rts
; ---------------------------------------------------------------------------

loc_4FADA:
		addq.w	#8,y_pos(a0)
		subq.b	#1,$40(a0)
		bmi.s	loc_4FAE6
		rts
; ---------------------------------------------------------------------------

loc_4FAE6:
		move.b	#6,routine(a0)
		rts
; ---------------------------------------------------------------------------

loc_4FAEE:
		move.w	y_pos(a0),d0
		addq.w	#1,d0
		move.w	(Camera_Y_pos).w,d1
		addi.w	#$140,d1
		cmp.w	d1,d0
		bcc.s	loc_4FB0A
		move.w	d0,y_pos(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_4FB0A:
		bset	#5,$38(a0)
		move.w	(Camera_X_pos).w,d2
		addi.w	#$100,d2
		move.w	d2,x_pos(a0)
		move.w	d1,y_pos(a0)
		bclr	#0,render_flags(a0)
		bclr	#7,art_tile(a0)
		jsr	(AllocateObject).l
		bne.s	loc_4FB46
		move.l	#Obj_LBZFinalBoss2,(a1)
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)

loc_4FB46:
		jmp	(Go_Delete_Sprite_2).l
; ---------------------------------------------------------------------------

loc_4FB4C:
		move.w	y_pos(a0),d0
		subq.w	#1,d0
		move.w	(Camera_Y_pos).w,d1
		subi.w	#$40,d1
		cmp.w	d1,d0
		bcs.s	loc_4FB68
		move.w	d0,y_pos(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_4FB68:
		move.l	#loc_4FB8C,(a0)
		bset	#5,$38(a0)
		bset	#0,render_flags(a0)
		move.w	(Camera_X_pos).w,d2
		addi.w	#$40,d2
		move.w	d2,x_pos(a0)
		move.w	d1,y_pos(a0)
		rts
; ---------------------------------------------------------------------------

loc_4FB8C:
		move.w	y_pos(a0),d0
		addq.w	#1,d0
		move.w	(Camera_Y_pos).w,d1
		addi.w	#$40,d1
		cmp.w	d1,d0
		bcc.s	loc_4FBA8
		move.w	d0,y_pos(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_4FBA8:
		move.l	#loc_4FBBE,(a0)
		lea	(Child1_MakeRoboShipFlame).l,a2
		jsr	CreateChild1_Normal(pc)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_4FBBE:
		move.w	x_pos(a0),d0
		addq.w	#2,d0
		move.w	(Camera_X_pos).w,d1
		addi.w	#$A0,d1
		cmp.w	d1,d0
		bcc.s	loc_4FBDA
		move.w	d0,x_pos(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_4FBDA:
		move.w	d0,x_pos(a0)
		move.l	#loc_4FBF2,(a0)
		lea	ChildObjDat_50326(pc),a2
		jsr	CreateChild1_Normal(pc)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_4FBF2:
		move.w	x_pos(a0),d0
		addq.w	#2,d0
		move.w	(Camera_X_pos).w,d1
		addi.w	#$1C0,d1
		cmp.w	d1,d0
		bcc.s	loc_4FC0E
		move.w	d0,x_pos(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_4FC0E:
		move.l	#loc_4FC26,(a0)
		bset	#6,status(a0)
		bset	#4,$38(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_4FC26:
		clr.b	(Boss_flag).w
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_4FC30:
		lea	ObjDat3_502C0(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		move.l	#loc_4FC4E,(a0)
		move.l	#loc_4FC4E,$34(a0)
		lea	ChildObjDat_50382(pc),a2
		jmp	CreateChild3_NormalRepeated(pc)
; ---------------------------------------------------------------------------

loc_4FC4E:
		jsr	Refresh_ChildPositionAdjusted(pc)
		bsr.w	sub_501FA
		jmp	Draw_And_Touch_Sprite(pc)
; ---------------------------------------------------------------------------

loc_4FC5A:
		movea.w	parent3(a0),a1
		btst	#6,status(a1)
		bne.s	loc_4FC86
		move.l	$34(a0),(a0)
		btst	#5,status(a1)
		beq.s	loc_4FC86
		subi.b	#$28,child_dy(a0)
		cmpi.b	#4,subtype(a0)
		bne.s	loc_4FC86
		bclr	#5,status(a1)

loc_4FC86:
		jmp	Draw_And_Touch_Sprite(pc)
; ---------------------------------------------------------------------------

loc_4FC8A:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_4FC90:
		move.w	#1,$3C(a0)
		bra.s	loc_4FC30
; ---------------------------------------------------------------------------

loc_4FC98:
		lea	ObjDat3_502CC(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		move.l	#loc_4FCBC,(a0)
		move.l	#loc_4FCBC,$34(a0)
		move.w	#2,$3C(a0)
		lea	ChildObjDat_503A2(pc),a2
		jmp	CreateChild1_Normal(pc)
; ---------------------------------------------------------------------------

loc_4FCBC:
		jsr	Refresh_ChildPositionAdjusted(pc)
		bsr.w	sub_501FA
		jmp	Draw_And_Touch_Sprite(pc)
; ---------------------------------------------------------------------------

loc_4FCC8:
		lea	word_502E0(pc),a1
		jsr	SetUp_ObjAttributes3(pc)
		move.l	#loc_4FCE0,(a0)
		move.w	#$60,$2E(a0)
		bsr.w	sub_5025A

loc_4FCE0:
		jsr	(MoveSprite).l
		jsr	TimedSprite_ScreenLock(pc)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_4FCF0:
		move.l	#loc_4FCFE,(a0)
		lea	ObjDat3_50306(pc),a1
		jmp	SetUp_ObjAttributes(pc)
; ---------------------------------------------------------------------------

loc_4FCFE:
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.s	loc_4FD14
		jsr	Refresh_ChildPositionAdjusted(pc)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_4FD14:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_4FD1A:
		lea	ObjDat3_50312(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		move.l	#loc_4FD36,(a0)
		tst.b	subtype(a0)
		beq.s	locret_4FD34
		move.b	#$22,mapping_frame(a0)

locret_4FD34:
		rts
; ---------------------------------------------------------------------------

loc_4FD36:
		movea.w	parent3(a0),a1
		btst	#6,status(a1)
		beq.s	loc_4FD4C
		jsr	Refresh_ChildPositionAdjusted(pc)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_4FD4C:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_4FD52:
		lea	word_502E6(pc),a1
		jsr	SetUp_ObjAttributes3(pc)
		move.l	#loc_4FD76,(a0)
		movea.w	parent3(a0),a1
		move.w	parent3(a1),$44(a0)
		tst.b	subtype(a0)
		beq.s	loc_4FD76
		move.b	#8,$39(a0)

loc_4FD76:
		bsr.w	sub_4FFDE
		moveq	#4,d0
		jmp	Child_Draw_Sprite_FlickerMove(pc)
; ---------------------------------------------------------------------------
		movea.w	$44(a0),a1
		btst	#6,status(a1)
		bne.s	loc_4FD92
		move.l	#loc_4FD76,(a0)

loc_4FD92:
		moveq	#4,d0
		jmp	Child_Draw_Sprite_FlickerMove(pc)
; ---------------------------------------------------------------------------

loc_4FD98:
		lea	word_502EC(pc),a1
		jsr	SetUp_ObjAttributes2(pc)
		move.l	#loc_4FDAE,(a0)
		move.w	#8,$3A(a0)
		rts
; ---------------------------------------------------------------------------

loc_4FDAE:
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.s	loc_4FDE4
		jsr	Refresh_ChildPositionAdjusted(pc)
		subq.w	#1,$2E(a0)
		bpl.w	locret_4FAD8
		move.w	$3A(a0),$2E(a0)
		subq.w	#1,$3A(a0)
		bpl.s	loc_4FDDE
		move.l	#loc_4FDEA,(a0)
		move.w	#$18,$2E(a0)

loc_4FDDE:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_4FDE4:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_4FDEA:
		jsr	Refresh_ChildPositionAdjusted(pc)
		subq.w	#1,$2E(a0)
		bmi.s	loc_4FE04
		btst	#0,$2F(a0)
		bne.w	locret_4FAD8
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_4FE04:
		move.l	#loc_4FE20,(a0)
		move.l	#byte_503D3,$30(a0)
		move.l	#loc_4FE2E,$34(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_4FE20:
		jsr	Refresh_ChildPositionAdjusted(pc)
		jsr	Animate_Raw(pc)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_4FE2E:
		move.l	#loc_4FE6A,(a0)
		tst.b	render_flags(a0)
		bpl.s	loc_4FE42
		moveq	#signextendB(sfx_Laser),d0
		jsr	(Play_SFX).l

loc_4FE42:
		move.b	#$9C,collision_flags(a0)
		move.b	#$11,mapping_frame(a0)
		moveq	#-$2C,d0
		move.w	#-$800,d1
		btst	#0,render_flags(a0)
		beq.s	loc_4FE60
		neg.w	d0
		neg.w	d1

loc_4FE60:
		add.w	d0,x_pos(a0)
		move.w	d1,x_vel(a0)
		rts
; ---------------------------------------------------------------------------

loc_4FE6A:
		btst	#0,(V_int_run_count+3).w
		bne.s	loc_4FE8A
		lea	ChildObjDat_5039A(pc),a2
		jsr	CreateChild1_Normal(pc)
		move.l	#byte_503DB,$30(a1)
		bsr.w	sub_500C4
		bra.w	loc_4FE9E
; ---------------------------------------------------------------------------

loc_4FE8A:
		lea	ChildObjDat_5039A(pc),a2
		jsr	CreateChild1_Normal(pc)
		move.l	#byte_503E1,$30(a1)
		bsr.w	sub_500C4

loc_4FE9E:
		jsr	(MoveSprite2).l
		jmp	(Sprite_CheckDeleteTouch).l
; ---------------------------------------------------------------------------

loc_4FEAA:
		lea	word_502F4(pc),a1
		jsr	SetUp_ObjAttributes3(pc)
		move.l	#loc_4FEC4,(a0)
		move.l	#Go_Delete_Sprite,$34(a0)
		jsr	Refresh_ChildPositionAdjusted(pc)

loc_4FEC4:
		jsr	Animate_Raw(pc)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_4FECE:
		lea	word_502D8(pc),a1
		jsr	SetUp_ObjAttributes2(pc)
		move.l	#loc_4FEE6,(a0)
		move.l	#byte_503CE,$30(a0)
		rts
; ---------------------------------------------------------------------------

loc_4FEE6:
		jsr	Refresh_ChildPositionAdjusted(pc)
		jsr	Animate_Raw(pc)
		jmp	Child_DrawTouch_Sprite(pc)
; ---------------------------------------------------------------------------

loc_4FEF2:
		lea	word_502B0(pc),a1
		jsr	SetUp_ObjAttributes2(pc)
		move.l	#loc_4FF02,(a0)
		rts
; ---------------------------------------------------------------------------

loc_4FF02:
		jsr	Refresh_ChildPositionAdjusted(pc)
		jmp	Child_Draw_Sprite2(pc)
; ---------------------------------------------------------------------------

loc_4FF0A:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_4FF1C(pc,d0.w),d1
		jsr	off_4FF1C(pc,d1.w)
		jmp	Draw_And_Touch_Sprite(pc)
; ---------------------------------------------------------------------------
off_4FF1C:
		dc.w loc_4FF22-off_4FF1C
		dc.w loc_4FF3A-off_4FF1C
		dc.w loc_4FF7A-off_4FF1C
; ---------------------------------------------------------------------------

loc_4FF22:
		lea	word_502B8(pc),a1
		jsr	SetUp_ObjAttributes2(pc)
		move.b	#$10,y_radius(a0)
		move.l	#loc_4FF4C,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_4FF3A:
		jsr	(MoveSprite).l
		tst.w	y_vel(a0)
		bmi.w	locret_4FAD8
		jmp	ObjHitFloor_DoRoutine(pc)
; ---------------------------------------------------------------------------

loc_4FF4C:
		move.w	y_vel(a0),d0
		cmpi.w	#$100,d0
		bcs.s	loc_4FF60
		asr.w	#1,d0
		neg.w	d0
		move.w	d0,y_vel(a0)
		rts
; ---------------------------------------------------------------------------

loc_4FF60:
		move.b	#4,routine(a0)
		lea	(ChildObjDat_46FEE).l,a2
		jsr	CreateChild1_Normal(pc)
		lea	(Child6_CreateBossExplosion).l,a2
		jmp	CreateChild1_Normal(pc)
; ---------------------------------------------------------------------------

loc_4FF7A:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_4FF80:
		lea	ObjDat3_502FA(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		move.l	#loc_4FFB2,(a0)
		move.l	#byte_503E7,$30(a0)
		move.l	#loc_4FFC4,$34(a0)
		move.b	#-$14,child_dy(a0)
		tst.b	subtype(a0)
		beq.s	locret_4FFB0
		move.b	#$80,$3C(a0)

locret_4FFB0:
		rts
; ---------------------------------------------------------------------------

loc_4FFB2:
		jsr	Animate_Raw(pc)
		addq.b	#1,$3C(a0)
		moveq	#3,d2
		jsr	MoveSprite_CircularSimpleOffset(pc)
		jmp	Child_DrawTouch_Sprite(pc)
; ---------------------------------------------------------------------------

loc_4FFC4:
		move.b	$39(a0),d0
		addq.b	#1,d0
		move.b	d0,$39(a0)
		andi.b	#3,d0
		andi.b	#$FC,render_flags(a0)
		or.b	d0,render_flags(a0)
		rts

; =============== S U B R O U T I N E =======================================


sub_4FFDE:
		moveq	#0,d0
		move.b	$39(a0),d0
		subq.w	#1,$2E(a0)
		bmi.s	loc_4FFF0
		add.w	d0,d0
		bra.w	loc_50064
; ---------------------------------------------------------------------------

loc_4FFF0:
		movea.w	$44(a0),a1
		btst	#0,render_flags(a1)
		sne	d2
		beq.s	loc_50008
		subq.b	#1,d0

loc_50000:
		bpl.s	loc_50012
		moveq	#$B,d0
		bra.w	loc_50012
; ---------------------------------------------------------------------------

loc_50008:
		addq.b	#1,d0
		cmpi.b	#$C,d0
		blo.s	loc_50012
		moveq	#0,d0

loc_50012:
		move.b	d0,$39(a0)
		lea	byte_5008A(pc),a2
		move.b	(a2,d0.w),d1
		bset	#0,render_flags(a0)
		bclr	#7,d1
		bne.s	loc_50032
		bclr	#0,render_flags(a0)
		not.b	d2

loc_50032:
		bclr	#3,$38(a1)
		cmpi.b	#4,d1
		bne.s	loc_50058
		bset	#3,$38(a1)
		tst.b	d2
		beq.s	loc_50058
		movem.l	d0-d1,-(sp)
		lea	ChildObjDat_5038A(pc),a2
		jsr	CreateChild1_Normal(pc)
		movem.l	(sp)+,d0-d1

loc_50058:
		move.b	d1,mapping_frame(a0)
		add.w	d0,d0
		move.w	word_50096(pc,d0.w),$2E(a0)

loc_50064:
		lea	byte_500AE(pc,d0.w),a1
		movea.w	parent3(a0),a2
		move.b	(a1)+,d1
		ext.w	d1
		move.w	x_pos(a2),d2
		add.w	d1,d2
		move.w	d2,x_pos(a0)
		move.b	(a1)+,d1
		ext.w	d1
		move.w	y_pos(a2),d2
		add.w	d1,d2
		move.w	d2,y_pos(a0)
		rts
; End of function sub_4FFDE

; ---------------------------------------------------------------------------
byte_5008A:
		dc.b    3|$80
		dc.b    4|$80
		dc.b    5|$80
		dc.b    6|$80
		dc.b    7|$80
		dc.b    8|$80
		dc.b    7
		dc.b    6
		dc.b    5
		dc.b    4
		dc.b    3
		dc.b  $2D
		even
word_50096:
		dc.w      7
		dc.w    $5F
		dc.w      7
		dc.w      7
		dc.w      7
		dc.w      7
		dc.w      7
		dc.w      7
		dc.w      7
		dc.w    $5F
		dc.w      7
		dc.w    $27
byte_500AE:
		dc.b  $27,  -8
		dc.b  $24,  -8
		dc.b  $24,  -8
		dc.b  $14,  -8
		dc.b   $C,  -8
		dc.b    0,  -8
		dc.b  -$C,  -8
		dc.b -$14,  -8
		dc.b -$24,  -8
		dc.b -$24,  -8
		dc.b -$27,  -8

; =============== S U B R O U T I N E =======================================


sub_500C4:
		jsr	(Random_Number).l
		swap	d0
		andi.b	#7,d0
		addi.b	#$18,d0
		move.b	d0,child_dx(a1)
		rts
; End of function sub_500C4


; =============== S U B R O U T I N E =======================================


sub_500DA:
		tst.b	collision_flags(a0)
		bne.w	locret_50192
		tst.b	collision_property(a0)
		beq.w	loc_50194
		tst.b	$20(a0)
		bne.s	loc_50162
		move.b	routine(a0),$3A(a0)
		move.b	#6,routine(a0)
		move.b	#$20,$20(a0)
		bset	#6,status(a0)
		moveq	#signextendB(sfx_BossHit),d0
		jsr	(Play_SFX).l
		move.w	y_vel(a0),d0
		asl.w	#1,d0
		cmpi.w	#-$800,d0
		blt.s	loc_50126
		cmpi.w	#$800,d0
		bgt.s	loc_50126
		move.w	d0,y_vel(a0)

loc_50126:
		cmpi.b	#5,collision_property(a0)
		beq.s	loc_5013C
		cmpi.b	#1,collision_property(a0)
		bne.s	loc_50162
		bset	#3,$38(a0)

loc_5013C:
		move.w	$3C(a0),d0
		bset	d0,$38(a0)
		addq.w	#1,$3C(a0)
		move.b	#8,routine(a0)
		move.b	#$F,$40(a0)
		bset	#5,status(a0)
		lea	ChildObjDat_503C0(pc),a2
		jsr	CreateChild1_Normal(pc)

loc_50162:
		moveq	#0,d0
		btst	#0,$20(a0)
		bne.s	loc_50170
		addi.w	#2*2,d0

loc_50170:
		bsr.w	sub_501E2
		subq.b	#1,$20(a0)
		bne.s	locret_50192
		move.b	$3A(a0),routine(a0)
		move.w	#$EEE,(Normal_palette_line_2+2).w
		move.b	$25(a0),collision_flags(a0)
		bclr	#6,status(a0)

locret_50192:
		rts
; ---------------------------------------------------------------------------

loc_50194:
		jsr	BossDefeated(pc)
		move.b	#5,mapping_frame(a0)
		bset	#6,status(a0)
		bset	#7,status(a0)
		clr.b	collision_flags(a0)
		move.w	$3C(a0),d0
		bset	d0,$38(a0)
		lea	(Child6_CreateBossExplosion).l,a2
		jsr	CreateChild1_Normal(pc)
		move.b	#4,subtype(a1)
		tst.b	(_unkFA80+1).w
		bne.s	loc_501D4
		move.l	#loc_4FAEE,(a0)
		rts
; ---------------------------------------------------------------------------

loc_501D4:
		move.l	#loc_4FB4C,(a0)
		lea	ChildObjDat_5031E(pc),a2
		jmp	CreateChild1_Normal(pc)
; End of function sub_500DA


; =============== S U B R O U T I N E =======================================


sub_501E2:
		lea	word_501EE(pc),a1
		lea	word_501F2(pc,d0.w),a2
		jmp	CopyWordData_2(pc)
; End of function sub_501E2

; ---------------------------------------------------------------------------
word_501EE:
		dc.w Normal_palette_line_2+$08, Normal_palette_line_2+$1C
word_501F2:
		dc.w    $26,   $20
		dc.w   $EEE,  $EEE

; =============== S U B R O U T I N E =======================================


sub_501FA:
		movea.w	parent3(a0),a1
		move.w	$3C(a0),d0
		btst	d0,$38(a1)
		beq.s	loc_5024A
		move.l	#byte_5029A,$3E(a0)
		bset	#7,status(a0)
		lea	(ChildObjDat_50342).l,a2
		cmpi.w	#2,d0
		bne.s	loc_50230
		move.l	#byte_5029E,$3E(a0)
		lea	(ChildObjDat_5035C).l,a2

loc_50230:
		move.w	#$10,$2E(a0)
		move.l	#loc_4FC8A,(a0)
		jsr	CreateChild1_Normal(pc)
		lea	(Child6_CreateBossExplosion).l,a2
		jmp	CreateChild1_Normal(pc)
; ---------------------------------------------------------------------------

loc_5024A:
		btst	#6,status(a1)
		beq.s	locret_50258
		move.l	#loc_4FC5A,(a0)

locret_50258:
		rts
; End of function sub_501FA


; =============== S U B R O U T I N E =======================================


sub_5025A:
		moveq	#0,d0
		move.b	subtype(a0),d0
		move.w	d0,d1
		lsr.w	#1,d1
		movea.w	parent3(a0),a1
		movea.l	$3E(a1),a1
		move.b	(a1,d1.w),mapping_frame(a0)
		add.w	d0,d0
		lea	word_50282(pc,d0.w),a1
		move.w	(a1)+,x_vel(a0)
		move.w	(a1)+,y_vel(a0)
		rts
; End of function sub_5025A

; ---------------------------------------------------------------------------
word_50282:
		dc.w  -$100, -$200
		dc.w   $100, -$200
		dc.w  -$200, -$100
		dc.w   $200, -$100
		dc.w  -$300, -$300
		dc.w   $300, -$300
byte_5029A:
		dc.b  $23
		dc.b  $25
		dc.b  $24
		dc.b  $26
byte_5029E:
		dc.b  $27
		dc.b  $29
		dc.b  $28
		dc.b  $2A
		dc.b  $2B
		dc.b  $2C
		even
ObjDat_LBZFinalBoss1:
		dc.l Map_RobotnikShip
		dc.w make_art_tile($52E,0,1)
		dc.w   $280
		dc.b  $20, $20,  $C,  $F
word_502B0:
		dc.w make_art_tile($3AA,1,1)
		dc.w   $200
		dc.b  $10,   4, $15,   0
word_502B8:
		dc.w make_art_tile($3AA,1,1)
		dc.w   $300
		dc.b   $C, $10, $16,   0
ObjDat3_502C0:
		dc.l Map_LBZFinalBoss1
		dc.w make_art_tile($3AA,1,1)
		dc.w   $200
		dc.b  $20, $14,   0, $AD
ObjDat3_502CC:
		dc.l Map_LBZFinalBoss1
		dc.w make_art_tile($3AA,1,1)
		dc.w   $200
		dc.b  $28, $18,   1, $AD
word_502D8:
		dc.w make_art_tile($3AA,0,1)
		dc.w   $280
		dc.b   $C, $18,   9, $89
word_502E0:
		dc.w   $200
		dc.b  $10, $10, $2A,   0
word_502E6:
		dc.w   $180
		dc.b   $C,  $C,   3,   0
word_502EC:
		dc.w make_art_tile($3AA,0,1)
		dc.w   $100
		dc.b  $18,   8,  $F,   0
word_502F4:
		dc.w   $100
		dc.b    8,   8, $1C,   0
ObjDat3_502FA:
		dc.l Map_LBZFinalBoss1
		dc.w make_art_tile($3AA,1,1)
		dc.w   $300
		dc.b   $C,  $C,  $C, $97
ObjDat3_50306:
		dc.l Map_LBZFinalBoss1
		dc.w make_art_tile($3AA,1,1)
		dc.w   $200
		dc.b  $28,   8,   2,   0
ObjDat3_50312:
		dc.l Map_LBZFinalBoss1
		dc.w make_art_tile($3AA,1,1)
		dc.w   $280
		dc.b  $10,  $C, $10,   0
ChildObjDat_5031E:
		dc.w 1-1
		dc.l loc_4FEF2
		dc.b    0, $10
ChildObjDat_50326:
		dc.w 1-1
		dc.l loc_4FF0A
		dc.b    0,   8
ChildObjDat_5032E:
		dc.w 3-1
		dc.l loc_4FC30
		dc.b    0,   8
		dc.l loc_4FC90
		dc.b    0, $30
		dc.l loc_4FC98
		dc.b    0, $5C
ChildObjDat_50342:
		dc.w 4-1
		dc.l loc_4FCC8
		dc.b -$10,  -4
		dc.l loc_4FCC8
		dc.b  $10,  -4
		dc.l loc_4FCC8
		dc.b -$10, $10
		dc.l loc_4FCC8
		dc.b  $10, $10
ChildObjDat_5035C:
		dc.w 6-1
		dc.l loc_4FCC8
		dc.b -$10,  -8
		dc.l loc_4FCC8
		dc.b  $10,  -8
		dc.l loc_4FCC8
		dc.b -$10, $10
		dc.l loc_4FCC8
		dc.b  $10, $10
		dc.l loc_4FCC8
		dc.b -$14,-$20
		dc.l loc_4FCC8
		dc.b  $14,-$20
ChildObjDat_50382:
		dc.w 2-1
		dc.l loc_4FD52
		dc.b    0,   0
ChildObjDat_5038A:
		dc.w 1-1
		dc.l loc_4FD98
		dc.b   -8,   0
		dc.w 1-1
		dc.l loc_4FD98
		dc.b    8,   0
ChildObjDat_5039A:
		dc.w 1-1
		dc.l loc_4FEAA
		dc.b  $20,   0
ChildObjDat_503A2:
		dc.w 2-1
		dc.l loc_4FECE
		dc.b -$14, $30
		dc.l loc_4FECE
		dc.b  $14, $30
ChildObjDat_503B0:
		dc.w 1-1
		dc.l loc_4FF80
		dc.b    0,   0
ChildObjDat_503B8:
		dc.w 1-1
		dc.l loc_4FCF0
		dc.b    0,-$14
ChildObjDat_503C0:
		dc.w 2-1
		dc.l loc_4FD1A
		dc.b -$10,   0
		dc.l loc_4FD1A
		dc.b  $10,   0
byte_503CE:
		dc.b    2,   9,  $A,  $B, $FC
byte_503D3:
		dc.b    0, $17, $17, $18, $19, $1A, $1B, $F4
byte_503DB:
		dc.b    0, $1C, $1C, $1D, $1E, $F4
byte_503E1:
		dc.b    0, $1F, $1F, $20, $21, $F4
byte_503E7:
		dc.b    1,  $C,  $D,  $E,  $D,  $C, $F4
		even
Pal_LBZFinalBoss1:
		binclude "Levels/LBZ/Palettes/Final Boss 1.bin"
		even
; ---------------------------------------------------------------------------

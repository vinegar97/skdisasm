Obj_LBZFinalBoss2:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	LBZFinalBoss2_Index(pc,d0.w),d1
		jsr	LBZFinalBoss2_Index(pc,d1.w)
		jsr	(sub_51CDE).l
		jmp	Draw_And_Touch_Sprite(pc)
; ---------------------------------------------------------------------------
LBZFinalBoss2_Index:
		dc.w loc_50CEE-LBZFinalBoss2_Index
		dc.w loc_50D28-LBZFinalBoss2_Index
		dc.w loc_50D74-LBZFinalBoss2_Index
		dc.w loc_50D8C-LBZFinalBoss2_Index
		dc.w loc_50D74-LBZFinalBoss2_Index
		dc.w loc_50E2C-LBZFinalBoss2_Index
		dc.w loc_50E6E-LBZFinalBoss2_Index
		dc.w loc_50E9C-LBZFinalBoss2_Index
		dc.w loc_50EAE-LBZFinalBoss2_Index
		dc.w loc_50ED0-LBZFinalBoss2_Index
		dc.w loc_50EFA-LBZFinalBoss2_Index
		dc.w loc_50F3A-LBZFinalBoss2_Index
		dc.w loc_50F50-LBZFinalBoss2_Index
		dc.w loc_50F7A-LBZFinalBoss2_Index
		dc.w loc_50F92-LBZFinalBoss2_Index
		dc.w loc_50FAC-LBZFinalBoss2_Index
		dc.w loc_50FC4-LBZFinalBoss2_Index
		dc.w loc_50FF0-LBZFinalBoss2_Index
		dc.w loc_5102E-LBZFinalBoss2_Index
		dc.w loc_51064-LBZFinalBoss2_Index
		dc.w loc_51086-LBZFinalBoss2_Index
		dc.w loc_510CE-LBZFinalBoss2_Index
; ---------------------------------------------------------------------------

loc_50CEE:
		lea	ObjDat_LBZFinalBoss2(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		move.b	#8,collision_property(a0)
		bset	#3,$38(a0)
		st	(Disable_death_plane).w
		lea	Pal_LBZFinalBoss2(pc),a1
		jsr	PalLoad_Line1(pc)
		lea	(ArtKosM_LBZFinalBoss2).l,a1
		move.w	#tiles_to_bytes($3D9),d2
		jsr	(Queue_Kos_Module).l
		lea	(Child1_MakeRoboHead4).l,a2
		jmp	CreateChild1_Normal(pc)
; ---------------------------------------------------------------------------

loc_50D28:
		subq.w	#1,y_pos(a0)
		move.w	(Camera_Y_pos).w,d0
		subi.w	#$40,d0
		cmp.w	y_pos(a0),d0
		bcc.s	loc_50D3C
		rts
; ---------------------------------------------------------------------------

loc_50D3C:
		move.b	#4,routine(a0)
		move.w	#$9F,$2E(a0)
		move.l	#loc_50D78,$34(a0)
		jsr	(AllocateObject).l
		bne.s	loc_50D64
		move.l	#Obj_Song_Fade_Transition,(a1)
		move.b	#mus_FinalBoss,subtype(a1)

loc_50D64:
		jsr	(AllocateObject).l
		bne.s	locret_50D72
		move.l	#loc_517FE,(a1)

locret_50D72:
		rts
; ---------------------------------------------------------------------------

loc_50D74:
		jmp	Obj_Wait(pc)
; ---------------------------------------------------------------------------

loc_50D78:
		move.b	#6,routine(a0)
		move.b	#8,mapping_frame(a0)
		lea	ChildObjDat_51FB4(pc),a2
		jmp	CreateChild1_Normal(pc)
; ---------------------------------------------------------------------------

loc_50D8C:
		jsr	MoveSprite_LightGravity(pc)
		move.w	(Camera_Y_pos).w,d0
		addi.w	#$120,d0
		cmp.w	y_pos(a0),d0
		blo.s	loc_50DA0
		rts
; ---------------------------------------------------------------------------

loc_50DA0:
		bset	#7,art_tile(a0)
		clr.w	y_vel(a0)
		move.b	#$F,collision_flags(a0)
		bchg	#0,render_flags(a0)
		lea	ChildObjDat_51FCE(pc),a2
		jsr	CreateChild1_Normal(pc)

loc_50DBE:
		move.b	#8,routine(a0)
		move.w	#$7F,$2E(a0)
		move.l	#loc_50DD4,$34(a0)

locret_50DD2:
		rts
; ---------------------------------------------------------------------------

loc_50DD4:
		bchg	#0,render_flags(a0)
		move.b	$39(a0),d0
		addq.b	#1,$39(a0)
		btst	#1,d0
		bne.s	loc_50E0C
		move.b	#$A,routine(a0)
		bclr	#3,$38(a0)
		bclr	#2,$38(a0)
		move.w	#$AF,$2E(a0)
		move.l	#loc_50DBE,$34(a0)
		bra.w	loc_51C30
; ---------------------------------------------------------------------------

loc_50E0C:
		move.b	#$C,routine(a0)
		clr.b	$39(a0)
		clr.w	y_vel(a0)
		move.l	#loc_50E82,$34(a0)
		move.w	(Camera_Y_pos).w,y_pos(a0)
		bra.w	loc_51C8E
; ---------------------------------------------------------------------------

loc_50E2C:
		move.w	$3A(a0),d0
		move.w	off_50E42(pc,d0.w),d0
		jsr	off_50E42(pc,d0.w)
		jsr	(MoveSprite2).l
		jmp	Obj_Wait(pc)
; ---------------------------------------------------------------------------
off_50E42:
		dc.w locret_50E50-off_50E42
		dc.w loc_50E4C-off_50E42
		dc.w loc_50E52-off_50E42
		dc.w locret_50E50-off_50E42
		dc.w loc_50E68-off_50E42
; ---------------------------------------------------------------------------

loc_50E4C:
		subq.w	#4,y_vel(a0)

locret_50E50:
		rts
; ---------------------------------------------------------------------------

loc_50E52:
		move.w	y_vel(a0),d0
		add.w	$3C(a0),d0
		move.w	d0,y_vel(a0)
		bne.s	locret_50E66
		move.w	#2,$3C(a0)

locret_50E66:
		rts
; ---------------------------------------------------------------------------

loc_50E68:
		subq.w	#4,y_pos(a0)
		rts
; ---------------------------------------------------------------------------

loc_50E6E:
		moveq	#$50,d1
		move.w	#$F0,d2
		bsr.w	sub_51CB4
		jsr	(MoveSprite2).l
		jmp	Obj_Wait(pc)
; ---------------------------------------------------------------------------

loc_50E82:
		move.b	#$E,routine(a0)
		clr.w	x_vel(a0)
		move.w	#$1F,$2E(a0)
		move.l	#loc_50EA0,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_50E9C:
		jmp	Obj_Wait(pc)
; ---------------------------------------------------------------------------

loc_50EA0:
		move.b	#$10,routine(a0)
		bset	#3,$38(a0)
		rts
; ---------------------------------------------------------------------------

loc_50EAE:
		jsr	MoveSprite_LightGravity(pc)
		move.w	(Camera_Y_pos_copy).w,d0
		addi.w	#$C0,d0
		cmp.w	y_pos(a0),d0
		blo.s	loc_50EC2
		rts
; ---------------------------------------------------------------------------

loc_50EC2:
		move.b	#$12,routine(a0)
		bset	#2,$38(a0)
		rts
; ---------------------------------------------------------------------------

loc_50ED0:
		addi.w	#-$80,y_vel(a0)
		jsr	(MoveSprite2).l
		tst.w	y_vel(a0)
		bpl.s	locret_50EF0
		move.w	(Camera_Y_pos_copy).w,d0
		addi.w	#$E0,d0
		cmp.w	y_pos(a0),d0
		bhs.s	loc_50EF2

locret_50EF0:
		rts
; ---------------------------------------------------------------------------

loc_50EF2:
		move.b	#$14,routine(a0)
		rts
; ---------------------------------------------------------------------------

loc_50EFA:
		addi.w	#$40,y_vel(a0)
		jsr	(MoveSprite2).l
		tst.w	y_vel(a0)
		bmi.s	locret_50F1A
		move.w	(Camera_Y_pos_copy).w,d0
		addi.w	#$D0,d0
		cmp.w	y_pos(a0),d0
		bls.s	loc_50F1C

locret_50F1A:
		rts
; ---------------------------------------------------------------------------

loc_50F1C:
		move.b	#$16,routine(a0)
		move.w	d0,y_pos(a0)
		clr.w	y_vel(a0)
		move.w	#$1F,$2E(a0)
		move.l	#loc_50F3E,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_50F3A:
		jmp	Obj_Wait(pc)
; ---------------------------------------------------------------------------

loc_50F3E:
		move.b	#$18,routine(a0)
		move.l	#loc_50F64,$34(a0)
		bra.w	loc_51C8E
; ---------------------------------------------------------------------------

loc_50F50:
		moveq	#$30,d1
		move.w	#$110,d2
		bsr.w	sub_51CB4
		jsr	(MoveSprite2).l
		jmp	Obj_Wait(pc)
; ---------------------------------------------------------------------------

loc_50F64:
		move.b	#$1A,routine(a0)
		move.w	#$1F,$2E(a0)
		move.l	#loc_50F7E,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_50F7A:
		jmp	Obj_Wait(pc)
; ---------------------------------------------------------------------------

loc_50F7E:
		move.b	#$1C,routine(a0)
		move.w	#-$400,y_vel(a0)
		bclr	#3,$38(a0)
		rts
; ---------------------------------------------------------------------------

loc_50F92:
		jsr	(MoveSprite2).l
		move.w	(Camera_Y_pos).w,d0
		subi.w	#$60,d0
		cmp.w	y_pos(a0),d0
		bhs.s	loc_50FA8
		rts
; ---------------------------------------------------------------------------

loc_50FA8:
		bra.w	loc_50DBE
; ---------------------------------------------------------------------------

loc_50FAC:
		jmp	Obj_Wait(pc)
; ---------------------------------------------------------------------------

loc_50FB0:
		move.b	#$20,routine(a0)
		move.w	#-$400,y_vel(a0)
		bchg	#1,$39(a0)
		rts
; ---------------------------------------------------------------------------

loc_50FC4:
		jsr	(MoveSprite2).l
		move.w	(Camera_Y_pos).w,d0
		subi.w	#$60,d0
		cmp.w	y_pos(a0),d0
		bhs.s	loc_50FDA
		rts
; ---------------------------------------------------------------------------

loc_50FDA:
		move.b	#$22,routine(a0)
		move.w	#$3F,$2E(a0)
		move.l	#loc_50FF4,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_50FF0:
		jmp	Obj_Wait(pc)
; ---------------------------------------------------------------------------

loc_50FF4:
		move.b	#$24,routine(a0)
		movea.w	$44(a0),a1
		clr.b	$3C(a1)
		move.w	(Camera_X_pos).w,d0
		move.w	d0,d1
		addi.w	#$A0,d0
		bclr	#0,render_flags(a0)
		move.w	#$E0,d2
		cmp.w	x_pos(a0),d0
		blo.s	loc_51026
		bset	#0,render_flags(a0)
		move.w	#$60,d2

loc_51026:
		add.w	d2,d1
		move.w	d1,x_pos(a0)
		rts
; ---------------------------------------------------------------------------

loc_5102E:
		move.w	(Camera_Y_pos_copy).w,d0
		addi.w	#$88,d0
		cmp.w	y_pos(a0),d0
		bls.s	loc_51042
		addq.w	#8,y_pos(a0)
		rts
; ---------------------------------------------------------------------------

loc_51042:
		move.b	#$26,routine(a0)
		bset	#1,$38(a0)
		move.w	#$14,(Screen_shake_flag).w
		move.w	#3,$2E(a0)
		moveq	#signextendB(sfx_BossHitFloor),d0
		jsr	(Play_SFX).l
		rts
; ---------------------------------------------------------------------------

loc_51064:
		addq.w	#4,y_pos(a0)
		subq.w	#1,$2E(a0)
		bmi.s	loc_51070
		rts
; ---------------------------------------------------------------------------

loc_51070:
		move.b	#$28,routine(a0)
		move.w	#7,$2E(a0)
		move.l	#loc_5108A,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_51086:
		jmp	Obj_Wait(pc)
; ---------------------------------------------------------------------------

loc_5108A:
		move.b	#$2A,routine(a0)
		clr.b	$30(a0)
		subi.w	#$10,y_pos(a0)
		bclr	#1,$38(a0)
		move.w	#$400,d0
		btst	#0,render_flags(a0)
		beq.s	loc_510AE
		neg.w	d0

loc_510AE:
		move.w	d0,x_vel(a0)
		move.w	#-$600,y_vel(a0)
		move.w	#$3F,$2E(a0)
		movea.l	a0,a2
		lea	(Player_1).w,a0
		jsr	(HurtCharacter).l
		movea.l	a2,a0
		rts
; ---------------------------------------------------------------------------

loc_510CE:
		jsr	(MoveSprite).l
		subq.w	#1,$2E(a0)
		bmi.w	loc_50DBE
		rts
; ---------------------------------------------------------------------------

loc_510DE:
		move.l	#loc_510F8,(a0)
		move.b	#5,mapping_frame(a0)
		bset	#4,$38(a0)
		lea	ChildObjDat_51FF0(pc),a2
		jmp	CreateChild1_Normal(pc)
; ---------------------------------------------------------------------------

loc_510F8:
		move.w	y_pos(a0),d0
		addq.w	#1,d0
		move.w	d0,y_pos(a0)
		move.w	(Camera_Y_pos).w,d1
		addi.w	#$140,d1
		cmp.w	d1,d0
		blo.s	loc_51142
		move.l	#loc_51148,(a0)
		bclr	#7,render_flags(a0)
		bset	#5,$38(a0)
		move.w	a0,(_unkFAA4).w
		clr.w	(Ctrl_1_logical).w
		st	(Ctrl_1_locked).w
		move.b	#$80,(Player_1+object_control).w
		lea	(ArtKosM_LBZ2DeathEggSmall).l,a1
		move.w	#tiles_to_bytes($4AE),d2
		jsr	(Queue_Kos_Module).l

loc_51142:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_51148:
		lea	(Player_1).w,a1
		btst	#Status_InAir,status(a1)
		bne.s	locret_51178
		move.w	(Camera_X_pos).w,d0
		addi.w	#$A0,d0
		sub.w	x_pos(a1),d0
		scs	d2
		bpl.s	loc_51166
		neg.w	d0

loc_51166:
		cmpi.w	#4,d0
		blo.s	loc_5117A
		moveq	#button_right,d1
		tst.b	d2
		beq.s	loc_51174
		moveq	#button_left,d1

loc_51174:
		bset	d1,(Ctrl_1_held_logical).w

locret_51178:
		rts
; ---------------------------------------------------------------------------

loc_5117A:
		move.l	#locret_511CC,(a0)
		clr.b	(_unkFA88).w
		clr.w	ground_vel(a1)
		clr.w	x_vel(a1)
		clr.w	y_vel(a1)
		bclr	#0,render_flags(a1)
		bclr	#Status_Facing,status(a1)
		move.w	#(button_up_mask<<8)|button_up_mask,(Ctrl_1_logical).w
		st	(Ctrl_1_locked).w
		jsr	(AllocateObject).l
		bne.s	loc_511C4
		move.l	#loc_5182E,(a1)
		lea	(Player_1).w,a2
		move.w	x_pos(a2),x_pos(a1)
		move.w	y_pos(a2),y_pos(a1)

loc_511C4:
		lea	ChildObjDat_52010(pc),a2
		jmp	CreateChild6_Simple(pc)
; ---------------------------------------------------------------------------

locret_511CC:
		rts
; ---------------------------------------------------------------------------

loc_511CE:
		lea	ObjDat3_51F24(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		move.l	#loc_511DC,(a0)

loc_511DC:
		jsr	Child_GetPriorityOnce(pc)
		jsr	Refresh_ChildPositionAdjusted(pc)
		jmp	Child_Draw_Sprite2(pc)
; ---------------------------------------------------------------------------

loc_511E8:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_511FC(pc,d0.w),d1
		jsr	off_511FC(pc,d1.w)
		moveq	#$C,d0
		jmp	Child_DrawTouch_Sprite_FlickerMove(pc)
; ---------------------------------------------------------------------------
off_511FC:
		dc.w loc_51202-off_511FC
		dc.w loc_51226-off_511FC
		dc.w loc_5124E-off_511FC
; ---------------------------------------------------------------------------

loc_51202:
		lea	ObjDat3_51F30(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		movea.w	parent3(a0),a1
		move.w	a0,$44(a1)
		move.b	#$14,child_dx(a0)
		move.b	#-6,child_dy(a0)
		lea	ChildObjDat_51FD6(pc),a2
		jmp	CreateChild1_Normal(pc)
; ---------------------------------------------------------------------------

loc_51226:
		movea.w	parent3(a0),a1
		btst	#7,art_tile(a1)
		beq.s	loc_51244
		bset	#7,art_tile(a0)
		move.b	#4,routine(a0)
		move.b	#$AD,collision_flags(a0)

loc_51244:
		lea	(LBZFinalBoss2_CircleLookup).l,a2
		jmp	MoveSprite_CircularLookup(pc)
; ---------------------------------------------------------------------------

loc_5124E:
		movea.w	parent3(a0),a1
		btst	#1,$38(a1)
		bne.w	locret_50DD2
		btst	#2,$38(a1)
		bne.s	loc_51298
		lea	(Player_1).w,a1
		move.b	$3C(a0),d0
		move.w	y_pos(a0),d1
		sub.w	y_pos(a1),d1
		cmpi.w	#-2,d1
		blt.s	loc_5128C
		cmpi.w	#2,d1
		ble.s	loc_51298
		subq.b	#1,d0
		cmpi.b	#-$30,d0
		blt.s	loc_51298
		bra.w	loc_51294
; ---------------------------------------------------------------------------

loc_5128C:
		addq.b	#1,d0
		cmpi.b	#0,d0
		bgt.s	loc_51298

loc_51294:
		move.b	d0,$3C(a0)

loc_51298:
		jsr	Change_FlipXUseParent(pc)
		lea	(LBZFinalBoss2_CircleLookup).l,a2
		jmp	MoveSprite_CircularLookup(pc)
; ---------------------------------------------------------------------------

loc_512A6:
		lea	word_51F42(pc),a1
		jsr	SetUp_ObjAttributes3(pc)
		move.l	#loc_512D4,(a0)
		movea.w	parent3(a0),a1
		movea.w	parent3(a1),a2
		move.w	a2,parent3(a0)
		move.w	a1,$44(a0)
		move.w	a1,$44(a0)
		move.b	#$18,child_dx(a0)
		move.b	#-6,child_dy(a0)

loc_512D4:
		jsr	Child_GetPriorityOnce(pc)
		jsr	Change_FlipXUseParent(pc)
		movea.w	$44(a0),a1
		move.b	$3C(a1),d0
		addi.b	#$14,d0
		move.b	d0,$3C(a0)
		lea	(LBZ2FinalBoss2_CircleLookup2).l,a2
		jsr	MoveSprite_CircularLookup(pc)
		moveq	#$C,d0
		jmp	Child_DrawTouch_Sprite_FlickerMove(pc)
; ---------------------------------------------------------------------------

loc_512FC:
		lea	word_51F3C(pc),a1
		jsr	SetUp_ObjAttributes3(pc)
		movea.w	parent3(a0),a1
		move.w	parent3(a1),$44(a0)
		move.l	#loc_51336,(a0)
		move.l	#byte_5205A,$30(a0)
		tst.b	subtype(a0)
		beq.s	loc_51336
		move.b	#8,mapping_frame(a0)
		move.w	#$180,priority(a0)
		move.l	#byte_52062,$30(a0)

loc_51336:
		jsr	Child_GetPriorityOnce(pc)

loc_5133A:
		jsr	Refresh_ChildPositionAdjusted(pc)
		jsr	Animate_Raw(pc)
		movea.w	$44(a0),a1
		tst.b	$30(a1)
		beq.s	loc_51368
		move.l	#loc_5136E,(a0)
		move.b	#7,mapping_frame(a0)
		tst.b	subtype(a0)
		beq.s	loc_51368
		move.b	#$B,mapping_frame(a0)
		addq.b	#8,child_dx(a0)

loc_51368:
		moveq	#$C,d0
		jmp	Child_DrawTouch_Sprite_FlickerMove(pc)
; ---------------------------------------------------------------------------

loc_5136E:
		jsr	Refresh_ChildPositionAdjusted(pc)
		movea.w	$44(a0),a1
		tst.b	$30(a1)
		bne.s	loc_5138C
		move.l	#loc_5133A,(a0)
		tst.b	subtype(a0)
		beq.s	loc_5138C
		subq.b	#8,child_dx(a0)

loc_5138C:
		moveq	#$C,d0
		jmp	Child_DrawTouch_Sprite_FlickerMove(pc)
; ---------------------------------------------------------------------------

loc_51392:
		lea	ObjDat3_51F48(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		move.l	#loc_513A0,(a0)

loc_513A0:
		jsr	Child_GetPriorityOnce(pc)
		jsr	Refresh_ChildPositionAdjusted(pc)
		jmp	Child_Draw_Sprite2(pc)
; ---------------------------------------------------------------------------

loc_513AC:
		lea	ObjDat3_51F54(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		move.l	#loc_513BA,(a0)

loc_513BA:
		move.b	#$9A,d0
		bsr.w	sub_51BC8
		jsr	Refresh_ChildPositionAdjusted(pc)
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.s	loc_513E2
		btst	#0,(V_int_run_count+3).w
		bne.w	locret_50DD2
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_513E2:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_513E8:
		move.l	#loc_513F4,(a0)
		move.b	#$99,collision_flags(a0)

loc_513F4:
		jsr	Refresh_ChildPositionAdjusted(pc)
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.s	loc_513E2
		jmp	(Add_SpriteToCollisionResponseList).l
; ---------------------------------------------------------------------------

loc_5140A:
		move.l	#loc_5141A,(a0)
		movea.w	parent3(a0),a1
		move.w	parent3(a1),$44(a0)

loc_5141A:
		jsr	Refresh_ChildPositionAdjusted(pc)
		movea.w	$44(a0),a1
		btst	#7,status(a1)
		bne.s	loc_5145E
		btst	#3,$38(a1)
		bne.w	locret_50DD2
		btst	#6,status(a1)
		bne.w	locret_50DD2
		lea	word_51468(pc),a1
		jsr	(Check_PlayerInRange).l
		tst.w	d0
		beq.s	locret_5145C
		movea.w	d0,a1
		tst.b	invulnerability_timer(a1)
		bne.s	locret_5145C
		cmpi.b	#6,routine(a1)
		blo.s	loc_51470

locret_5145C:
		rts
; ---------------------------------------------------------------------------

loc_5145E:
		clr.b	(Player_1+object_control).w
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------
word_51468:
		dc.w   -$18,   $30,  -$18,   $30
; ---------------------------------------------------------------------------

loc_51470:
		move.l	#loc_514B0,(a0)
		movea.w	$44(a0),a1
		st	$30(a1)
		move.b	#$1E,routine(a1)
		move.w	#$40,$2E(a1)
		move.l	#loc_50FB0,$34(a1)
		lea	(Player_1).w,a1
		move.b	#$81,object_control(a1)
		move.b	#2,anim(a1)
		moveq	#0,d0
		move.w	d0,x_vel(a1)
		move.w	d0,y_vel(a1)
		move.w	d0,ground_vel(a1)

loc_514B0:
		movea.w	$44(a0),a1
		tst.b	$30(a1)
		beq.s	loc_514DA
		btst	#7,status(a1)
		bne.w	loc_513E2
		jsr	Refresh_ChildPositionAdjusted(pc)
		lea	(Player_1).w,a1
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		rts
; ---------------------------------------------------------------------------

loc_514DA:
		move.l	#loc_514E6,(a0)
		move.w	#$40,$2E(a0)

loc_514E6:
		subq.w	#1,$2E(a0)
		bmi.s	loc_514EE
		rts
; ---------------------------------------------------------------------------

loc_514EE:
		move.l	#loc_5141A,(a0)
		rts
; ---------------------------------------------------------------------------

loc_514F6:
		lea	ObjDat3_51F60(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		jsr	Refresh_ChildPositionAdjusted(pc)
		move.l	#Obj_FlickerMove,(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		lsr.w	#1,d0
		addi.b	#$D,d0
		move.b	d0,mapping_frame(a0)
		moveq	#0,d0
		jsr	Set_IndexedVelocity(pc)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_51524:
		move.l	#loc_5155A,(a0)
		move.w	#$4430,x_pos(a0)
		move.w	#$728,y_pos(a0)
		move.w	#$1010,$3A(a0)
		move.w	#$200,d0
		tst.b	subtype(a0)
		beq.s	loc_51548
		neg.w	d0

loc_51548:
		move.w	d0,x_vel(a0)
		move.w	#$41,$2E(a0)
		move.l	#loc_51576,$34(a0)

loc_5155A:
		subq.b	#1,$39(a0)
		bpl.s	loc_5156C
		move.b	#3,$39(a0)
		jsr	(sub_52850).l

loc_5156C:
		jsr	(MoveSprite2).l
		jmp	Obj_Wait(pc)
; ---------------------------------------------------------------------------

loc_51576:
		clr.w	x_vel(a0)
		move.w	#-$200,y_vel(a0)
		move.w	#$57,$2E(a0)
		move.l	#loc_51590,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_51590:
		lea	Child6_CreateBossExplosion(pc),a2
		jsr	CreateChild1_Normal(pc)
		bne.s	loc_515AC
		move.w	#$4430,x_pos(a1)
		move.w	#$678,y_pos(a1)
		move.b	#$C,subtype(a1)

loc_515AC:
		tst.b	subtype(a0)
		bne.s	loc_515DE
		jsr	(AllocateObject).l
		bne.s	loc_515DE
		move.l	#loc_515E2,(a1)
		move.w	(Camera_X_pos).w,d0
		addi.w	#$D0,d0
		move.w	d0,x_pos(a1)
		move.w	(Camera_Y_pos).w,d0
		subi.w	#$20,d0
		move.w	d0,y_pos(a1)
		move.w	#5,$3A(a1)

loc_515DE:
		jmp	Go_Delete_Sprite(pc)
; ---------------------------------------------------------------------------

loc_515E2:
		subq.w	#1,$2E(a0)
		bpl.s	locret_51618
		addq.b	#1,$39(a0)
		cmpi.b	#8,$39(a0)
		bne.s	loc_515F8
		st	(Events_fg_5).w

loc_515F8:
		cmpi.b	#$18,$39(a0)
		bcc.s	loc_5161A
		move.w	$3A(a0),$2E(a0)
		addq.w	#1,$3A(a0)
		jsr	(AllocateObject).l
		bne.s	locret_51618
		move.l	#loc_5165C,(a1)

locret_51618:
		rts
; ---------------------------------------------------------------------------

loc_5161A:
		move.l	#loc_51626,(a0)
		move.w	#$17F,$2E(a0)

loc_51626:
		subq.w	#1,$2E(a0)
		bmi.s	loc_5162E
		rts
; ---------------------------------------------------------------------------

loc_5162E:
		bset	#0,(_unkFA88).w
		clr.b	$39(a0)
		clr.w	$2E(a0)
		jsr	(AllocateObject).l
		bne.s	loc_51650
		move.l	#loc_517FE,(a1)
		move.b	#4,subtype(a1)

loc_51650:
		lea	ChildObjDat_52016(pc),a2
		jsr	CreateChild1_Normal(pc)
		jmp	Go_Delete_Sprite(pc)
; ---------------------------------------------------------------------------

loc_5165C:
		lea	ObjDat3_51F6C(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		move.l	#MoveChkDel,(a0)
		jsr	(Random_Number).l
		andi.w	#7,d0
		move.b	RawAni_5169C(pc,d0.w),mapping_frame(a0)
		swap	d0
		andi.w	#$FF,d0
		move.w	(Camera_X_pos).w,d1
		addi.w	#$20,d1
		add.w	d0,d1
		move.w	d1,x_pos(a0)
		move.w	(Camera_Y_pos).w,d0
		subi.w	#$20,d0
		move.w	d0,y_pos(a0)
		rts
; ---------------------------------------------------------------------------
RawAni_5169C:
		dc.b    7,   8,   9,  $A,  $B,   7,   8,   9
		even
; ---------------------------------------------------------------------------

loc_516A4:
		lea	ObjDat3_51F78(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		move.l	#loc_516FA,(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		beq.s	loc_516C0
		move.l	#loc_5173E,(a0)

loc_516C0:
		move.w	word_516EA(pc,d0.w),y_vel(a0)
		lea	byte_516DC(pc,d0.w),a1
		move.b	(a1)+,mapping_frame(a0)
		move.b	(a1)+,d0
		or.b	d0,render_flags(a0)
		lea	Pal_LBZEnding(pc),a1
		jmp	PalLoad_Line1(pc)
; ---------------------------------------------------------------------------
byte_516DC:
		dc.b    0,   0
		dc.b    1,   0
		dc.b    1,   0
		dc.b    2,   0
		dc.b    2,   1
		dc.b    2,   2
		dc.b    2,   3
		even
word_516EA:
		dc.w    $40
		dc.w    $38
		dc.w    $3C
		dc.w    $40
		dc.w    $44
		dc.w    $48
		dc.w    $4C
		dc.w    $50
; ---------------------------------------------------------------------------

loc_516FA:
		bsr.w	sub_5174A
		move.b	(V_int_run_count+3).w,d0
		andi.b	#$F,d0
		bne.s	loc_51730
		lea	ChildObjDat_52042(pc),a2
		jsr	CreateChild6_Simple(pc)
		jsr	(Random_Number).l
		andi.w	#$1F,d0
		subi.w	#$10,d0
		add.w	d0,x_pos(a1)
		swap	d0
		andi.w	#$1F,d0
		subi.w	#$10,d0
		add.w	d0,y_pos(a1)

loc_51730:
		move.w	(Camera_Y_pos).w,d0
		addi.w	#$A0,d0
		cmp.w	y_pos(a0),d0
		bcs.s	loc_51764

loc_5173E:
		jsr	(MoveSprite2).l
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_5174A:
		move.w	(Camera_Y_pos).w,d0
		addi.w	#$80,d0
		cmp.w	y_pos(a0),d0
		bcc.s	locret_51762
		moveq	#signextendB(mus_FadeOut),d0
		jsr	(Play_Music).l
		move.l	(sp),(a0)

locret_51762:
		rts
; End of function sub_5174A

; ---------------------------------------------------------------------------

loc_51764:
		lea	ChildObjDat_5204E(pc),a2
		jsr	CreateChild6_Simple(pc)
		bne.w	locret_50DD2
		move.w	a1,$44(a0)
		lea	(Normal_palette).w,a1
		lea	(Target_palette).w,a2
		moveq	#bytesToLcnt($80),d0

loc_5177E:
		move.l	(a1)+,(a2)+
		dbf	d0,loc_5177E
		move.l	#loc_517BA,(a0)
		moveq	#signextendB(sfx_FlamethrowerQuiet),d0
		jsr	(Play_SFX).l
		moveq	#signextendB(mus_Ending),d0
		jsr	(Play_Music).l
		jsr	sub_5439C(pc)
		lsl.w	#2,d0
		movea.l	off_517AE(pc,d0.w),a1
		move.w	#tiles_to_bytes($3D9),d2
		jmp	(Queue_Kos_Module).l
; ---------------------------------------------------------------------------
off_517AE:
		dc.l ArtKosM_SonicEndPose
		dc.l ArtKosM_TailsEndPose
		dc.l ArtKosM_SuperSonicEndPose
; ---------------------------------------------------------------------------

loc_517BA:
		movea.w	$44(a0),a1
		btst	#7,status(a1)
		beq.s	loc_517DE
		clr.b	(Level_started_flag).w
		lea	ChildObjDat_52054(pc),a2
		jsr	CreateChild6_Simple(pc)
		bne.s	loc_517DE
		move.w	a1,$44(a0)
		move.l	#loc_517E4,(a0)

loc_517DE:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_517E4:
		movea.w	$44(a0),a1
		btst	#7,status(a1)
		beq.w	locret_50DD2
		bset	#1,(_unkFA88).w
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_517FE:
		move.l	#loc_5182A,(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		movea.l	off_51822(pc,d0.w),a1
		lea	(Palette_rotation_data).w,a2
		move.l	(a1)+,(a2)+
		move.l	(a1)+,(a2)+
		clr.w	(a2)
		move.l	#Go_Delete_Sprite,(Palette_rotation_custom).w
		rts
; ---------------------------------------------------------------------------
off_51822:
		dc.l PalSPtr_LBZFinalBoss2_FadeIn
		dc.l PalSPtr_LBZFinalBoss2_FadeOut
; ---------------------------------------------------------------------------

loc_5182A:
		jmp	Run_PalRotationScript(pc)
; ---------------------------------------------------------------------------

loc_5182E:
		btst	#0,(_unkFA88).w
		beq.w	locret_50DD2
		move.l	#loc_5185A,(a0)
		move.l	#loc_51868,$34(a0)
		clr.b	(Ctrl_1_locked).w
		lea	(Player_1).w,a1
		move.b	#$53,object_control(a1)
		move.b	#0,anim(a1)

loc_5185A:
		lea	byte_52070(pc),a1
		bsr.w	Animate_ExternalPlayerSprite
		jmp	(Player_Load_PLC).l
; ---------------------------------------------------------------------------

loc_51868:
		move.l	#loc_5186E,(a0)

loc_5186E:
		btst	#1,(_unkFA88).w
		beq.w	locret_50DD2
		move.l	#loc_5188E,(a0)
		move.l	#loc_5189C,$34(a0)
		clr.b	anim_frame(a0)
		clr.b	anim_frame_timer(a0)

loc_5188E:
		lea	byte_5207A(pc),a1
		bsr.w	Animate_ExternalPlayerSprite
		jmp	(Player_Load_PLC).l
; ---------------------------------------------------------------------------

loc_5189C:
		move.l	#loc_518CE,(a0)
		move.w	#$FF,$2E(a0)
		move.l	#loc_518E2,$34(a0)
		clr.b	anim_frame(a0)
		clr.b	anim_frame_timer(a0)
		lea	(Player_1).w,a1
		moveq	#0,d0
		move.b	character_id(a1),d0
		lsl.w	#2,d0
		lea	off_52090(pc),a2
		move.l	(a2,d0.w),$30(a0)

loc_518CE:
		movea.l	$30(a0),a1
		bsr.w	Animate_ExternalPlayerSprite
		jsr	(Player_Load_PLC).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_518E2:
		move.l	#loc_518E8,(a0)

loc_518E8:
		lea	ObjDat3_51FA8(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		lea	(Player_1).w,a1
		move.w	x_pos(a1),x_pos(a0)
		move.w	y_pos(a1),y_pos(a0)
		movea.w	(_unkFAA4).w,a1
		move.l	#Go_Delete_Sprite,(a1)
		jsr	sub_5439C(pc)
		moveq	#0,d1
		subq.w	#1,d0
		beq.s	loc_51920
		bmi.s	loc_51922
		tst.b	(Super_Sonic_Knux_flag).w
		beq.s	loc_5191E
		addq.w	#4,d1

loc_5191E:
		addq.w	#4,d1

loc_51920:
		addq.w	#4,d1

loc_51922:
		move.l	off_5192C(pc,d1.w),(a0)
		move.w	d1,$3A(a0)
		rts
; ---------------------------------------------------------------------------
off_5192C:
		dc.l loc_5193C
		dc.l loc_51994
		dc.l loc_519B8
		dc.l loc_51A62
; ---------------------------------------------------------------------------

loc_5193C:
		move.l	#loc_5195E,(a0)
		move.w	#6,$2E(a0)
		move.b	#0,mapping_frame(a0)
		subi.w	#$10,y_pos(a0)
		move.b	#0,(Player_1+mapping_frame).w
		bsr.w	sub_51EB0

loc_5195E:
		subq.w	#1,$2E(a0)
		bpl.s	loc_51982
		move.l	#Wait_Draw,(a0)
		addq.b	#1,mapping_frame(a0)
		move.w	#5*60,$2E(a0)
		move.l	#loc_51988,$34(a0)
		subi.w	#$20,y_pos(a0)

loc_51982:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_51988:
		move.b	#$20,(Game_mode).w
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

loc_51994:
		move.l	#loc_5195E,(a0)
		move.w	#4,$2E(a0)
		move.b	#2,mapping_frame(a0)
		subi.w	#$10,y_pos(a0)
		move.b	#0,(Player_1+mapping_frame).w
		bsr.w	sub_51EB0
		bra.s	loc_5195E
; ---------------------------------------------------------------------------

loc_519B8:
		move.l	#loc_519E0,(a0)
		move.b	#4,mapping_frame(a0)
		move.w	#$100,x_vel(a0)
		move.w	#-$600,y_vel(a0)
		lea	(Player_1).w,a1
		move.b	#$81,object_control(a1)
		move.b	#2,anim(a1)

loc_519E0:
		lea	(Player_1).w,a1
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		jsr	(MoveSprite).l
		move.w	(Camera_Y_pos).w,d0
		addi.w	#$140,d0
		cmp.w	y_pos(a0),d0
		bcs.s	loc_51A06
		rts
; ---------------------------------------------------------------------------

loc_51A06:
		move.l	#loc_51A34,(a0)
		move.w	(Camera_X_pos).w,d0
		addi.w	#$180,d0
		move.w	d0,x_pos(a0)
		move.w	(Camera_Y_pos).w,d0
		addi.w	#$C0,d0
		move.w	d0,y_pos(a0)
		move.w	#-$800,x_vel(a0)
		move.w	#-$400,y_vel(a0)
		bra.w	sub_51EB0
; ---------------------------------------------------------------------------

loc_51A34:
		jsr	(MoveSprite2).l
		move.w	(Camera_X_pos).w,d0
		addi.w	#$A0,d0
		cmp.w	x_pos(a0),d0
		bcs.s	loc_51A5C
		move.l	#Wait_Draw,(a0)
		move.w	#3*60,$2E(a0)
		move.l	#loc_51988,$34(a0)

loc_51A5C:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_51A62:
		move.l	#loc_51A90,(a0)
		move.b	#4,mapping_frame(a0)
		move.w	#$600,x_vel(a0)
		lea	(Player_1).w,a1
		move.b	#$81,object_control(a1)
		move.b	#0,anim(a1)
		move.w	#$600,x_vel(a1)
		move.w	#$600,ground_vel(a1)

loc_51A90:
		lea	(Player_1).w,a1
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		jsr	(MoveSprite2).l
		move.w	(Camera_X_pos).w,d0
		addi.w	#$180,d0
		cmp.w	y_pos(a0),d0
		bcs.w	loc_51A06
		rts
; ---------------------------------------------------------------------------

loc_51AB8:
		lea	ObjDat3_51F84(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		move.l	#loc_51AE2,(a0)
		move.w	#-$40,y_vel(a0)
		move.w	#$7F,$2E(a0)
		move.l	#Go_Delete_Sprite,$34(a0)
		lea	ChildObjDat_52048(pc),a2
		jsr	CreateChild6_Simple(pc)

loc_51AE2:
		move.b	(V_int_run_count+3).w,d0
		andi.b	#3,d0
		bne.s	loc_51B08
		move.b	$39(a0),d0
		addq.b	#1,d0
		move.b	d0,$39(a0)
		andi.b	#3,d0
		move.b	render_flags(a0),d1
		andi.b	#$FC,d1
		or.b	d0,d1
		move.b	d1,render_flags(a0)

loc_51B08:
		jsr	(MoveSprite2).l
		jsr	Obj_Wait(pc)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_51B18:
		lea	ObjDat3_51F90(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		move.l	#loc_51B3C,(a0)
		move.l	#byte_5206A,$30(a0)
		move.l	#Go_Delete_Sprite,$34(a0)
		move.w	#$40,y_vel(a0)

loc_51B3C:
		jsr	Animate_Raw(pc)
		jsr	(MoveSprite2).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_LBZ2UnusedRobotnik:
		lea	ObjDat_LBZ2UnusedRobotnik(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		move.l	#loc_51BB6,(a0)
		bset	#0,render_flags(a0)
		move.w	#tiles_to_bytes($3D9),$3A(a0)
		move.b	#$30,$25(a0)
		move.w	(Camera_X_pos).w,d0
		addi.w	#$60,d0
		move.w	d0,x_pos(a0)
		move.w	d0,$30(a0)
		move.w	(Camera_Y_pos).w,d0
		addi.w	#$100,d0
		move.w	d0,y_pos(a0)
		move.w	d0,$34(a0)
		move.w	#$800,x_vel(a0)
		move.w	#-$3C0,y_vel(a0)
		move.b	#4,$40(a0)
		move.l	#ArtScaled_LBZ2UnusedRobotnik,$42(a0)
		move.b	#1,$3E(a0)
		bsr.w	Perform_Art_Scaling
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_51BB6:
		bsr.w	sub_51E3A
		bsr.w	sub_51DEA
		bsr.w	sub_51E10
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_51BC8:
		movea.w	parent3(a0),a1
		btst	#7,art_tile(a1)
		beq.s	locret_51BE0
		bset	#7,art_tile(a0)
		move.l	(sp),(a0)
		move.b	d0,collision_flags(a0)

locret_51BE0:
		rts
; End of function sub_51BC8

; ---------------------------------------------------------------------------
		movea.w	$44(a0),a1
		movea.w	parent3(a0),a2
		move.w	x_pos(a1),d0
		moveq	#$10,d2
		btst	#0,render_flags(a2)
		beq.s	loc_51BFA
		neg.w	d2

loc_51BFA:
		add.w	d2,d0
		move.w	x_pos(a2),d1
		moveq	#$C,d2
		btst	#0,render_flags(a2)
		beq.s	loc_51C0C
		neg.w	d2

loc_51C0C:
		add.w	d2,d1
		sub.w	d1,d0
		asr.w	#1,d0
		add.w	d0,d1
		move.w	d1,x_pos(a0)
		move.w	y_pos(a1),d0
		subq.w	#4,d0
		move.w	y_pos(a2),d1
		subq.w	#4,d1
		sub.w	d1,d0
		asr.w	#1,d0
		add.w	d0,d1
		move.w	d1,y_pos(a0)
		rts
; ---------------------------------------------------------------------------

loc_51C30:
		jsr	(Random_Number).l
		andi.w	#6,d0
		move.w	d0,$3A(a0)
		move.w	(Camera_X_pos).w,d1
		move.w	#$1A8,d2
		move.w	#-$300,d3
		btst	#0,render_flags(a0)
		beq.s	loc_51C58
		move.w	#-$68,d2
		neg.w	d3

loc_51C58:
		add.w	d2,d1
		move.w	d1,x_pos(a0)
		move.w	d3,x_vel(a0)
		move.w	(Camera_Y_pos).w,d1
		move.w	word_51C7E(pc,d0.w),d2
		add.w	d1,d2
		move.w	d2,y_pos(a0)
		move.w	word_51C86(pc,d0.w),y_vel(a0)
		move.w	#8,$3C(a0)
		rts
; ---------------------------------------------------------------------------
word_51C7E:
		dc.w    $60,   $10,   $A0,   $80
word_51C86:
		dc.w      0,  $200, -$200,     0
; ---------------------------------------------------------------------------

loc_51C8E:
		move.w	#-$300,d0
		btst	#0,render_flags(a0)
		beq.s	loc_51C9C
		neg.w	d0

loc_51C9C:
		move.w	d0,x_vel(a0)
		jsr	(Random_Number).l
		andi.w	#$7F,d0
		addi.w	#$C0,d0
		move.w	d0,$2E(a0)
		rts

; =============== S U B R O U T I N E =======================================


sub_51CB4:
		move.w	(Camera_X_pos).w,d0
		tst.w	x_vel(a0)
		bmi.s	loc_51CCA
		add.w	d2,d0
		cmp.w	x_pos(a0),d0
		bls.s	loc_51CD2
		bra.w	locret_51CDC
; ---------------------------------------------------------------------------

loc_51CCA:
		add.w	d1,d0
		cmp.w	x_pos(a0),d0
		blo.s	locret_51CDC

loc_51CD2:
		bchg	#0,render_flags(a0)
		neg.w	x_vel(a0)

locret_51CDC:
		rts
; End of function sub_51CB4


; =============== S U B R O U T I N E =======================================


sub_51CDE:
		cmpi.b	#8,routine(a0)
		blo.s	locret_51D50
		tst.b	collision_flags(a0)
		bne.s	locret_51D50
		move.b	collision_property(a0),d0
		beq.s	loc_51D52
		tst.b	$20(a0)
		bne.s	loc_51D1C
		cmpi.b	#$A,routine(a0)
		bne.s	loc_51D06
		move.w	#8,$3A(a0)

loc_51D06:
		move.b	#$3C,$20(a0)
		moveq	#signextendB(sfx_BossHit),d0
		jsr	(Play_SFX).l
		movea.w	$44(a0),a1
		clr.b	collision_flags(a1)

loc_51D1C:
		bset	#6,status(a0)
		moveq	#0,d0
		btst	#0,$20(a0)
		bne.s	loc_51D30
		addi.w	#2*6,d0

loc_51D30:
		bsr.w	sub_51D88
		subq.b	#1,$20(a0)
		bne.s	locret_51D50
		bclr	#6,status(a0)
		move.b	$25(a0),collision_flags(a0)
		movea.w	$44(a0),a1
		move.b	#$AD,collision_flags(a1)

locret_51D50:
		rts
; ---------------------------------------------------------------------------

loc_51D52:
		move.l	#Wait_Draw,(a0)
		move.l	#loc_510DE,$34(a0)
		jsr	BossDefeated_StopTimer(pc)
		lea	(Child6_CreateBossExplosion).l,a2
		jsr	(CreateChild1_Normal).l
		bne.s	loc_51D78
		move.b	#4,subtype(a1)

loc_51D78:
		tst.b	$30(a0)
		; Bug: this branch is inverted, freeing the player if they're _not_ being held
		bne.s	loc_51D82
		jsr	Restore_PlayerControl(pc)

loc_51D82:
		jmp	(SaveGame).l
; End of function sub_51CDE


; =============== S U B R O U T I N E =======================================


sub_51D88:
		lea	word_51D94(pc),a1
		lea	word_51DA0(pc,d0.w),a2
		jmp	CopyWordData_6(pc)
; End of function sub_51D88

; ---------------------------------------------------------------------------
word_51D94:
		dc.w Normal_palette_line_2+$08, Normal_palette_line_2+$0E, Normal_palette_line_2+$10
		dc.w Normal_palette_line_2+$18, Normal_palette_line_2+$1A, Normal_palette_line_2+$1C
word_51DA0:
		dc.w      8,    $A,     4,  $644,  $422,     0
		dc.w   $888,  $666,  $AAA,  $AAA,  $EEE,  $EEE

; =============== S U B R O U T I N E =======================================


Perform_Art_Scaling:
		clr.w	(_unkF740).w
		move.l	a0,-(sp)
		jsr	(Init_ArtScaling).l
		movea.l	(sp)+,a0
		move.l	a0,-(sp)
		move.w	art_tile(a0),d0
		jsr	(sub_22C90).l
		movea.l	(sp)+,a0
		move.w	(_unkF740).w,d3
		lsl.w	#4,d3
		move.l	#Kos_decomp_buffer,d1
		move.w	$3A(a0),d2
		jmp	(Add_To_DMA_Queue).l
; End of function Perform_Art_Scaling


; =============== S U B R O U T I N E =======================================


sub_51DEA:
		move.w	x_vel(a0),d0
		addi.w	#-$28,d0
		cmpi.w	#-$80,d0
		blt.s	loc_51DFC
		move.w	d0,x_vel(a0)

loc_51DFC:
		move.w	y_vel(a0),d0
		addi.w	#8,d0
		cmpi.w	#$40,d0
		bge.s	locret_51E0E
		move.w	d0,y_vel(a0)

locret_51E0E:
		rts
; End of function sub_51DEA


; =============== S U B R O U T I N E =======================================


sub_51E10:
		bsr.w	sub_4B30A
		move.w	$30(a0),d2
		move.w	$34(a0),d3
		moveq	#0,d0
		move.b	$40(a0),d0
		addq.w	#4,d0
		move.l	#$100,d4
		divu.w	d0,d4
		sub.w	d4,d2
		sub.w	d4,d3
		move.w	d2,x_pos(a0)
		move.w	d3,y_pos(a0)
		rts
; End of function sub_51E10


; =============== S U B R O U T I N E =======================================


sub_51E3A:
		subq.w	#1,$1C(a0)
		bpl.s	loc_51E62
		moveq	#0,d0
		move.b	anim_frame(a0),d0
		addq.b	#1,d0
		cmpi.b	#6,d0
		bhi.s	loc_51E80
		move.b	d0,anim_frame(a0)
		add.w	d0,d0
		move.w	word_51E86(pc,d0.w),$1C(a0)
		add.w	d0,d0
		move.l	off_51E94(pc,d0.w),$42(a0)

loc_51E62:
		subq.b	#1,$25(a0)
		bpl.s	locret_51E7E
		move.b	#4,$25(a0)
		move.b	$40(a0),d0
		addq.b	#1,d0
		bmi.s	locret_51E7E
		move.b	d0,$40(a0)
		bsr.w	Perform_Art_Scaling

locret_51E7E:
		rts
; ---------------------------------------------------------------------------

loc_51E80:
		jmp	(Go_Delete_Sprite).l
; End of function sub_51E3A

; ---------------------------------------------------------------------------
word_51E86:
		dc.w    $20
		dc.w    $20
		dc.w    $10
		dc.w      8
		dc.w      8
		dc.w      8
		dc.w   $200
off_51E94:
		dc.l ArtScaled_LBZ2UnusedRobotnik
		dc.l ArtScaled_LBZ2UnusedRobotnik
		dc.l ArtScaled_LBZ2UnusedRobotnik+$1000
		dc.l ArtScaled_LBZ2UnusedRobotnik+$2000
		dc.l ArtScaled_LBZ2UnusedRobotnik+$3000
		dc.l ArtScaled_LBZ2UnusedRobotnik+$4000
		dc.l ArtScaled_LBZ2UnusedRobotnik+$5000

; =============== S U B R O U T I N E =======================================


sub_51EB0:
		move.w	$3A(a0),d1
		movea.l	off_51EC6(pc,d1.w),a1
		lea	(Normal_palette).w,a2
		moveq	#bytesToLcnt($20),d0

loc_51EBE:
		move.l	(a1)+,(a2)+
		dbf	d0,loc_51EBE
		rts
; End of function sub_51EB0

; ---------------------------------------------------------------------------
off_51EC6:
		dc.l Pal_SonicEndPose
		dc.l Pal_TailsEndPose
		dc.l Pal_SuperSonicEndPose
		dc.l Pal_SuperSonicEndPose

; =============== S U B R O U T I N E =======================================


Animate_ExternalPlayerSprite:
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	locret_51F10
		lea	(Player_1).w,a2
		move.b	(a1),anim_frame_timer(a0)
		moveq	#0,d0
		move.b	anim_frame(a0),d0
		addq.b	#2,d0
		move.b	d0,anim_frame(a0)
		move.b	1(a1,d0.w),d1
		cmpi.b	#-1,d1
		beq.s	loc_51F12
		move.b	d1,mapping_frame(a2)
		bclr	#0,render_flags(a2)
		tst.b	2(a1,d0.w)
		beq.s	locret_51F10
		bset	#0,render_flags(a2)

locret_51F10:
		rts
; ---------------------------------------------------------------------------

loc_51F12:
		movea.l	$34(a0),a1
		jmp	(a1)
; End of function Animate_ExternalPlayerSprite

; ---------------------------------------------------------------------------
ObjDat_LBZFinalBoss2:
		dc.l Map_RobotnikShip
		dc.w make_art_tile($52E,0,0)
		dc.w   $280
		dc.b  $1C, $20,   5,   0
ObjDat3_51F24:
		dc.l Map_LBZFinalBoss2
		dc.w make_art_tile($3D9,1,0)
		dc.w   $200
		dc.b  $28, $28,   0,   0
ObjDat3_51F30:
		dc.l Map_LBZFinalBoss2
		dc.w make_art_tile($3D9,1,0)
		dc.w   $180
		dc.b  $20, $10,   2,   0
word_51F3C:
		dc.w    $80
		dc.b  $14, $14,   4,   0
word_51F42:
		dc.w   $180
		dc.b    8,   8,   3,   0
ObjDat3_51F48:
		dc.l Map_LBZFinalBoss2
		dc.w make_art_tile($3D9,1,0)
		dc.w   $300
		dc.b  $14,  $C,   1,   0
ObjDat3_51F54:
		dc.l Map_LBZFinalBoss2
		dc.w make_art_tile($3D9,0,0)
		dc.w   $300
		dc.b   $C,  $C,  $C,   0
ObjDat3_51F60:
		dc.l Map_LBZFinalBoss2
		dc.w make_art_tile($3D9,1,1)
		dc.w   $100
		dc.b  $10, $14,  $D,   0
ObjDat3_51F6C:
		dc.l Map_LBZDeathEggSmall
		dc.w make_art_tile($4AE,2,0)
		dc.w   $300
		dc.b   $C,  $C,   7,   0
ObjDat3_51F78:
		dc.l Map_LBZDeathEggSmall
		dc.w make_art_tile($4AE,1,0)
		dc.w   $380
		dc.b  $18, $18,   0,   0
ObjDat3_51F84:
		dc.l Map_LBZDeathEggSmall
		dc.w make_art_tile($4AE,1,0)
		dc.w   $300
		dc.b    4,   4,   3,   0
ObjDat3_51F90:
		dc.l Map_LBZDeathEggSmall
		dc.w make_art_tile($4AE,1,0)
		dc.w   $300
		dc.b    4,   4,   4,   0
ObjDat_LBZ2UnusedRobotnik:
		dc.l Map_ScaledArt
		dc.w make_art_tile($3D9,0,0)
		dc.w   $300
		dc.b  $20, $20,   0,   0
ObjDat3_51FA8:
		dc.l Map_SonicTailsEndPoses
		dc.w make_art_tile($3D9,0,1)
		dc.w   $300
		dc.b  $40, $40,   0,   0
ChildObjDat_51FB4:
		dc.w 4-1
		dc.l loc_511E8
		dc.b  $14, $24
		dc.l loc_511CE
		dc.b   $C,-$14
		dc.l loc_51392
		dc.b    0,-$18
		dc.l loc_513AC
		dc.b  $38,-$14
ChildObjDat_51FCE:
		dc.w 1-1
		dc.l loc_513E8
		dc.b    4,-$34
ChildObjDat_51FD6:
		dc.w 4-1
		dc.l loc_512FC
		dc.b -$2A,  -2
		dc.l loc_512FC
		dc.b -$4A,  -2
		dc.l loc_512A6
		dc.b    0,   0
		dc.l loc_5140A
		dc.b -$40,  -2
ChildObjDat_51FF0:
		dc.w 5-1
		dc.l loc_514F6
		dc.b  -$C,-$2C
		dc.l loc_514F6
		dc.b  $14,-$2C
		dc.l loc_514F6
		dc.b  $2C,-$18
		dc.l loc_514F6
		dc.b  -$C,  -4
		dc.l loc_514F6
		dc.b  $14,  -4
ChildObjDat_52010:
		dc.w 2-1
		dc.l loc_51524
ChildObjDat_52016:
		dc.w 7-1
		dc.l loc_516A4
		dc.b    0,   0
		dc.l loc_516A4
		dc.b -$10, $28
		dc.l loc_516A4
		dc.b -$70,   0
		dc.l loc_516A4
		dc.b -$48, $28
		dc.l loc_516A4
		dc.b  $18, $10
		dc.l loc_516A4
		dc.b -$24,  -8
		dc.l loc_516A4
		dc.b -$50, $1C
ChildObjDat_52042:
		dc.w 1-1
		dc.l loc_51AB8
ChildObjDat_52048:
		dc.w 1-1
		dc.l loc_51B18
ChildObjDat_5204E:
		dc.w 1-1
		dc.l loc_542B8
ChildObjDat_52054:
		dc.w 1-1
		dc.l loc_54322
byte_5205A:
		dc.b    9,   7,   4,   5,   6,   5,   4, $FC
byte_52062:
		dc.b    9,  $B,   8,   9,  $A,   9,   8, $FC
byte_5206A:
		dc.b    2,   4,   4,   5,   6, $F4
byte_52070:
		dc.b    5, $C4
		dc.b    0, $55
		dc.b    0, $59
		dc.b    1, $5A
		dc.b    1, $FF
byte_5207A:
		dc.b    7, $5A
		dc.b    1, $5A
		dc.b    1, $5A
		dc.b    1, $5A
		dc.b    1, $59
		dc.b    1, $55
		dc.b    0, $56
		dc.b    0, $57
		dc.b    0, $57
		dc.b    0, $57
		dc.b    0, $FF
off_52090:
		dc.l byte_52098
		dc.l byte_520D2
byte_52098:
		dc.b   $F, $B1
		dc.b    0, $B2
		dc.b    0, $B1
		dc.b    0, $B2
		dc.b    0, $B1
		dc.b    0, $B2
		dc.b    0, $B1
		dc.b    0, $B2
		dc.b    0, $B1
		dc.b    0, $B2
		dc.b    0, $B1
		dc.b    0, $B2
		dc.b    0, $B1
		dc.b    0, $B2
		dc.b    0, $B1
		dc.b    0, $B2
		dc.b    0, $B1
		dc.b    0, $B2
		dc.b    0, $B1
		dc.b    0, $B2
		dc.b    0, $B1
		dc.b    0, $B2
		dc.b    0, $B1
		dc.b    0, $B2
		dc.b    0, $B1
		dc.b    0, $B2
		dc.b    0, $B1
		dc.b    0, $B2
		dc.b    0, $FF
byte_520D2:
		dc.b  $7F, $A6
		dc.b    0, $A6
		dc.b    0, $A6
		dc.b    0, $A6
		dc.b    0, $FF
Pal_LBZFinalBoss2:
		binclude "Levels/LBZ/Palettes/Final Boss 2.bin"
		even
Pal_LBZEnding:
		binclude "Levels/LBZ/Palettes/Ending.bin"
		even
Pal_SonicEndPose:
		binclude "General/Ending/Palettes/Sonic End Pose.bin"
		even
Pal_TailsEndPose:
		binclude "General/Ending/Palettes/Tails End Pose.bin"
		even
Pal_SuperSonicEndPose:
		binclude "General/Ending/Palettes/S3 Super Sonic End Pose.bin"
		even
Map_SonicTailsEndPoses:
		include "General/Ending/Map - Sonic Tails Ending Poses S3.asm"

PalSPtr_LBZFinalBoss2_FadeIn:
		palscriptptr .header, .data
		dc.w 0
.header	palscripthdr	Normal_palette_line_4+$16, 4, 2-1
.data	palscriptdata	16, $ECE, $E8A, $E48, $E46
	palscriptdata	16, $CAC, $C68, $C46, $A44
	palscriptdata	16, $A88, $A46, $824, $622
	palscriptdata	16, $844, $622, $400, $200
	palscriptrun

PalSPtr_LBZFinalBoss2_FadeOut:
		palscriptptr .header, .data
		dc.w 0
.header	palscripthdr	Normal_palette_line_4+$16, 4, 2-1
.data	palscriptdata	16, $844, $622, $400, $200
	palscriptdata	16, $A88, $A46, $824, $622
	palscriptdata	16, $CAC, $C68, $C46, $A44
	palscriptdata	16, $ECE, $E8A, $E48, $E46
	palscriptrun

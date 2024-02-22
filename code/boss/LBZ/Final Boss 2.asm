Obj_LBZFinalBoss2:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	LBZFinalBoss2_Index(pc,d0.w),d1
		jsr	LBZFinalBoss2_Index(pc,d1.w)
		jsr	(sub_74FD2).l
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------
LBZFinalBoss2_Index:
		dc.w loc_742A8-LBZFinalBoss2_Index
		dc.w loc_7430E-LBZFinalBoss2_Index
		dc.w loc_7430E-LBZFinalBoss2_Index
		dc.w loc_7432A-LBZFinalBoss2_Index
		dc.w loc_7430E-LBZFinalBoss2_Index
		dc.w loc_743CE-LBZFinalBoss2_Index
		dc.w loc_74412-LBZFinalBoss2_Index
		dc.w loc_74442-LBZFinalBoss2_Index
		dc.w loc_74456-LBZFinalBoss2_Index
		dc.w loc_7447A-LBZFinalBoss2_Index
		dc.w loc_744A4-LBZFinalBoss2_Index
		dc.w loc_744E4-LBZFinalBoss2_Index
		dc.w loc_744FC-LBZFinalBoss2_Index
		dc.w loc_74528-LBZFinalBoss2_Index
		dc.w loc_74542-LBZFinalBoss2_Index
		dc.w loc_7455C-LBZFinalBoss2_Index
		dc.w loc_74576-LBZFinalBoss2_Index
		dc.w loc_745A2-LBZFinalBoss2_Index
		dc.w loc_745E2-LBZFinalBoss2_Index
		dc.w loc_74618-LBZFinalBoss2_Index
		dc.w loc_7463A-LBZFinalBoss2_Index
		dc.w loc_746C8-LBZFinalBoss2_Index
; ---------------------------------------------------------------------------

loc_742A8:
		lea	ObjDat_LBZFinalBoss2(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.b	#8,collision_property(a0)
		bset	#3,$38(a0)
		st	(Disable_death_plane).w
		move.w	(Camera_X_pos).w,d0
		addi.w	#$A0,d0
		move.w	d0,x_pos(a0)
		move.w	(Camera_Y_pos).w,d0
		subi.w	#$50,d0
		move.w	d0,y_pos(a0)
		move.w	#$59,$2E(a0)
		move.l	#loc_74314,$34(a0)
		lea	Pal_LBZFinalBoss2(pc),a1
		jsr	(PalLoad_Line1).l
		lea	(ArtKosM_LBZFinalBoss2).l,a1
		move.w	#tiles_to_bytes($3D9),d2
		jsr	(Queue_Kos_Module).l
		lea	(Child1_MakeRoboHead4).l,a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_7430E:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_74314:
		move.b	#6,routine(a0)
		move.b	#8,mapping_frame(a0)
		lea	ChildObjDat_75122(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_7432A:
		jsr	(MoveSprite_LightGravity).l
		move.w	(Camera_Y_pos).w,d0
		addi.w	#$120,d0
		cmp.w	y_pos(a0),d0
		blo.s	loc_74340
		rts
; ---------------------------------------------------------------------------

loc_74340:
		bset	#7,art_tile(a0)
		clr.w	y_vel(a0)
		move.b	#$F,$28(a0)
		bchg	#0,render_flags(a0)
		lea	ChildObjDat_7513C(pc),a2
		jsr	(CreateChild1_Normal).l

loc_74360:
		move.b	#8,routine(a0)
		move.w	#$7F,$2E(a0)
		move.l	#loc_74376,$34(a0)

locret_74374:
		rts
; ---------------------------------------------------------------------------

loc_74376:
		bchg	#0,render_flags(a0)
		move.b	$39(a0),d0
		addq.b	#1,$39(a0)
		btst	#2,d0
		bne.s	loc_743AE
		move.b	#$A,routine(a0)
		bclr	#3,$38(a0)
		bclr	#2,$38(a0)
		move.w	#$AF,$2E(a0)
		move.l	#loc_74360,$34(a0)
		bra.w	loc_74F24
; ---------------------------------------------------------------------------

loc_743AE:
		move.b	#$C,routine(a0)
		clr.b	$39(a0)
		clr.w	y_vel(a0)
		move.l	#loc_74428,$34(a0)
		move.w	(Camera_Y_pos).w,y_pos(a0)
		bra.w	loc_74F82
; ---------------------------------------------------------------------------

loc_743CE:
		move.w	$3A(a0),d0
		move.w	off_743E6(pc,d0.w),d0
		jsr	off_743E6(pc,d0.w)
		jsr	(MoveSprite2).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------
off_743E6:
		dc.w locret_743F4-off_743E6
		dc.w loc_743F0-off_743E6
		dc.w loc_743F6-off_743E6
		dc.w locret_743F4-off_743E6
		dc.w loc_7440C-off_743E6
; ---------------------------------------------------------------------------

loc_743F0:
		subq.w	#4,y_vel(a0)

locret_743F4:
		rts
; ---------------------------------------------------------------------------

loc_743F6:
		move.w	y_vel(a0),d0
		add.w	$3C(a0),d0
		move.w	d0,y_vel(a0)
		bne.s	locret_7440A
		move.w	#2,$3C(a0)

locret_7440A:
		rts
; ---------------------------------------------------------------------------

loc_7440C:
		subq.w	#4,y_pos(a0)
		rts
; ---------------------------------------------------------------------------

loc_74412:
		moveq	#$50,d1
		move.w	#$F0,d2
		bsr.w	sub_74FA8
		jsr	(MoveSprite2).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_74428:
		move.b	#$E,routine(a0)
		clr.w	x_vel(a0)
		move.w	#$1F,$2E(a0)
		move.l	#loc_74448,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_74442:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_74448:
		move.b	#$10,routine(a0)
		bset	#3,$38(a0)
		rts
; ---------------------------------------------------------------------------

loc_74456:
		jsr	(MoveSprite_LightGravity).l
		move.w	(Camera_Y_pos_copy).w,d0
		addi.w	#$C0,d0
		cmp.w	y_pos(a0),d0
		blo.s	loc_7446C
		rts
; ---------------------------------------------------------------------------

loc_7446C:
		move.b	#$12,routine(a0)
		bset	#2,$38(a0)
		rts
; ---------------------------------------------------------------------------

loc_7447A:
		addi.w	#-$80,y_vel(a0)
		jsr	(MoveSprite2).l
		tst.w	y_vel(a0)
		bpl.s	locret_7449A
		move.w	(Camera_Y_pos_copy).w,d0
		addi.w	#$E0,d0
		cmp.w	y_pos(a0),d0
		bhs.s	loc_7449C

locret_7449A:
		rts
; ---------------------------------------------------------------------------

loc_7449C:
		move.b	#$14,routine(a0)
		rts
; ---------------------------------------------------------------------------

loc_744A4:
		addi.w	#$40,y_vel(a0)
		jsr	(MoveSprite2).l
		tst.w	y_vel(a0)
		bmi.s	locret_744C4
		move.w	(Camera_Y_pos_copy).w,d0
		addi.w	#$D0,d0
		cmp.w	y_pos(a0),d0
		bls.s	loc_744C6

locret_744C4:
		rts
; ---------------------------------------------------------------------------

loc_744C6:
		move.b	#$16,routine(a0)
		move.w	d0,y_pos(a0)
		clr.w	y_vel(a0)
		move.w	#$1F,$2E(a0)
		move.l	#loc_744EA,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_744E4:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_744EA:
		move.b	#$18,routine(a0)
		move.l	#loc_74512,$34(a0)
		bra.w	loc_74F82
; ---------------------------------------------------------------------------

loc_744FC:
		moveq	#$30,d1
		move.w	#$110,d2
		bsr.w	sub_74FA8
		jsr	(MoveSprite2).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_74512:
		move.b	#$1A,routine(a0)
		move.w	#$1F,$2E(a0)
		move.l	#loc_7452E,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_74528:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_7452E:
		move.b	#$1C,routine(a0)
		move.w	#-$400,y_vel(a0)
		bclr	#3,$38(a0)
		rts
; ---------------------------------------------------------------------------

loc_74542:
		jsr	(MoveSprite2).l
		move.w	(Camera_Y_pos).w,d0
		subi.w	#$60,d0
		cmp.w	y_pos(a0),d0
		bhs.s	loc_74558
		rts
; ---------------------------------------------------------------------------

loc_74558:
		bra.w	loc_74360
; ---------------------------------------------------------------------------

loc_7455C:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_74562:
		move.b	#$20,routine(a0)
		move.w	#-$400,y_vel(a0)
		bchg	#1,$39(a0)
		rts
; ---------------------------------------------------------------------------

loc_74576:
		jsr	(MoveSprite2).l
		move.w	(Camera_Y_pos).w,d0
		subi.w	#$60,d0
		cmp.w	y_pos(a0),d0
		bhs.s	loc_7458C
		rts
; ---------------------------------------------------------------------------

loc_7458C:
		move.b	#$22,routine(a0)
		move.w	#$3F,$2E(a0)
		move.l	#loc_745A8,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_745A2:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_745A8:
		move.b	#$24,routine(a0)
		movea.w	$44(a0),a1
		clr.b	$3C(a1)
		move.w	(Camera_X_pos).w,d0
		move.w	d0,d1
		addi.w	#$A0,d0
		bclr	#0,render_flags(a0)
		move.w	#$E0,d2
		cmp.w	x_pos(a0),d0
		blo.s	loc_745DA
		bset	#0,render_flags(a0)
		move.w	#$60,d2

loc_745DA:
		add.w	d2,d1
		move.w	d1,x_pos(a0)
		rts
; ---------------------------------------------------------------------------

loc_745E2:
		move.w	(Camera_Y_pos_copy).w,d0
		addi.w	#$88,d0
		cmp.w	y_pos(a0),d0
		bls.s	loc_745F6
		addq.w	#8,y_pos(a0)
		rts
; ---------------------------------------------------------------------------

loc_745F6:
		move.b	#$26,routine(a0)
		bset	#1,$38(a0)
		move.w	#$14,(Screen_shake_flag).w
		move.w	#3,$2E(a0)
		moveq	#signextendB(sfx_BossHitFloor),d0
		jsr	(Play_SFX).l
		rts
; ---------------------------------------------------------------------------

loc_74618:
		addq.w	#4,y_pos(a0)
		subq.w	#1,$2E(a0)
		bmi.s	loc_74624
		rts
; ---------------------------------------------------------------------------

loc_74624:
		move.b	#$28,routine(a0)
		move.w	#7,$2E(a0)
		move.l	#loc_74640,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_7463A:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_74640:
		move.b	#$2A,routine(a0)
		clr.b	$30(a0)
		subi.w	#$10,y_pos(a0)
		bclr	#1,$38(a0)
		move.w	#$400,d0
		btst	#0,render_flags(a0)
		beq.s	loc_74664
		neg.w	d0

loc_74664:
		move.w	d0,x_vel(a0)
		move.w	#-$600,y_vel(a0)
		move.w	#$3F,$2E(a0)
		btst	#Status_Invincible,(Player_1+status_secondary).w
		bne.s	loc_7468C
		movea.l	a0,a2
		lea	(Player_1).w,a0
		jsr	(HurtCharacter).l
		movea.l	a2,a0
		rts
; ---------------------------------------------------------------------------

loc_7468C:
		lea	(Player_1).w,a1
		clr.b	object_control(a1)
		neg.w	d0
		move.w	d0,x_vel(a1)
		move.w	#-$400,y_vel(a1)
		bset	#Status_InAir,status(a1)
		bclr	#Status_OnObj,status(a1)
		clr.b	jumping(a1)
		clr.b	spin_dash_flag(a1)
		move.b	#2,anim(a1)
		move.b	#2,routine(a1)
		moveq	#signextendB(sfx_Spring),d0
		jmp	(Play_SFX).l
; ---------------------------------------------------------------------------

loc_746C8:
		jsr	(MoveSprite).l
		subq.w	#1,$2E(a0)
		bmi.w	loc_74360
		rts
; ---------------------------------------------------------------------------

loc_746D8:
		move.l	#loc_746F4,(a0)
		move.b	#5,mapping_frame(a0)
		bset	#4,$38(a0)
		lea	ChildObjDat_7515E(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_746F4:
		move.w	y_pos(a0),d0
		subq.w	#1,d0
		move.w	d0,y_pos(a0)
		move.w	(Camera_Y_pos).w,d1
		subi.w	#$40,d1
		cmp.w	d1,d0
		blo.s	loc_74710
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_74710:
		move.l	#loc_7473A,(a0)
		bclr	#7,render_flags(a0)
		bset	#5,$38(a0)
		bset	#0,render_flags(a0)
		move.w	(Camera_X_pos).w,d2
		addi.w	#$40,d2
		move.w	d2,x_pos(a0)
		jmp	(loc_694AA).l
; ---------------------------------------------------------------------------

loc_7473A:
		tst.b	(_unkFAA8).w
		bne.w	locret_74374
		tst.b	(_unkFAA2).w
		beq.w	locret_74374
		move.l	#loc_74768,(a0)
		jsr	sub_7302E(pc)
		bclr	#7,status(a0)
		jsr	(Restore_PlayerControl).l
		clr.w	(Ctrl_1_logical).w
		st	(Ctrl_1_locked).w

loc_74768:
		lea	(Player_1).w,a1
		move.w	#(button_right_mask<<8)|button_right_mask,d0
		move.w	(Camera_X_pos).w,d1
		addi.w	#$50,d1
		sub.w	x_pos(a1),d1
		bcc.s	loc_74784
		move.w	#(button_left_mask<<8)|button_left_mask,d0
		neg.w	d1

loc_74784:
		move.w	d0,(Ctrl_1_logical).w
		cmpi.w	#8,d1
		bhs.w	locret_74374
		move.l	#loc_747D6,(a0)
		clr.w	(Ctrl_1_logical).w
		bset	#0,render_flags(a1)
		bset	#Status_Facing,status(a1)
		jsr	(Stop_Object).l
		moveq	#$71,d0
		jsr	(Load_PLC).l
		lea	(ArtKosM_EggRoboHead).l,a1
		move.w	#tiles_to_bytes($52E),d2
		jsr	(Queue_Kos_Module).l
		bclr	#5,$38(a0)
		lea	(Child1_MakeRoboHead4).l,a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_747D6:
		move.w	#(button_up_mask<<8)|button_up_mask,(Ctrl_1_logical).w
		move.w	y_pos(a0),d0
		addq.w	#1,d0
		move.w	(Camera_Y_pos).w,d1
		addi.w	#$40,d1
		cmp.w	d1,d0
		bhs.s	loc_747F8
		move.w	d0,y_pos(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_747F8:
		move.l	#loc_7481C,(a0)
		move.w	#$200,x_vel(a0)
		jsr	(Swing_Setup1).l
		lea	(Child1_MakeRoboShipFlame).l,a2
		jsr	(CreateChild1_Normal).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_7481C:
		move.w	#(button_up_mask<<8)|button_up_mask,(Ctrl_1_logical).w
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		move.w	x_pos(a0),d0
		lea	(Player_1).w,a1
		bclr	#0,render_flags(a1)
		bclr	#Status_Facing,status(a1)
		cmp.w	x_pos(a1),d0
		bhs.s	loc_74854
		bset	#0,render_flags(a1)
		bset	#Status_Facing,status(a1)

loc_74854:
		move.w	(Camera_X_pos).w,d1
		addi.w	#$A0,d1
		cmp.w	d1,d0
		bhs.s	loc_74866
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_74866:
		move.w	d0,x_pos(a0)
		move.l	#loc_74894,(a0)
		move.w	#$1F,$2E(a0)
		move.l	#loc_748A0,$34(a0)
		bclr	#3,$38(a0)
		lea	ChildObjDat_7517E(pc),a2
		jsr	(CreateChild1_Normal).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_74894:
		jsr	(Obj_Wait).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_748A0:
		move.l	#loc_748AE,(a0)
		move.w	#$400,x_vel(a0)
		rts
; ---------------------------------------------------------------------------

loc_748AE:
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		move.w	x_pos(a0),d0
		move.w	(Camera_X_pos).w,d1
		addi.w	#$1C0,d1
		cmp.w	d1,d0
		bhs.s	loc_748D0
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_748D0:
		move.l	#loc_748F4,(a0)
		bset	#6,status(a0)
		bset	#4,$38(a0)
		bset	#5,$38(a0)
		clr.b	(Boss_flag).w
		bclr	#7,render_flags(a0)
		rts
; ---------------------------------------------------------------------------

loc_748F4:
		btst	#3,$38(a0)
		beq.s	locret_74908
		move.l	#loc_7490A,(a0)
		move.w	#(button_right_mask<<8)|button_right_mask,(Ctrl_1_logical).w

locret_74908:
		rts
; ---------------------------------------------------------------------------

loc_7490A:
		cmpi.w	#$4510,(Player_1+x_pos).w
		blo.s	locret_74950
		move.l	#loc_74952,(a0)
		lea	(Player_1).w,a1
		move.w	x_pos(a1),x_pos(a0)
		move.w	y_pos(a1),y_pos(a0)
		move.b	#$83,object_control(a1)
		move.b	#$8C,mapping_frame(a1)
		jsr	(Player_Load_PLC).l
		clr.b	anim_frame(a0)
		move.b	#$A,anim_frame_timer(a0)
		move.w	#$200,x_vel(a0)
		move.w	#-$400,y_vel(a0)

locret_74950:
		rts
; ---------------------------------------------------------------------------

loc_74952:
		jsr	(MoveSprite_LightGravity).l
		lea	(Player_1).w,a1
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	loc_7498E
		move.b	#$A,anim_frame_timer(a0)
		addq.b	#1,anim_frame(a0)
		moveq	#signextendB($8C),d0
		btst	#0,anim_frame(a0)
		bne.s	loc_74984
		moveq	#signextendB($8D),d0

loc_74984:
		move.b	d0,mapping_frame(a1)
		jsr	(Player_Load_PLC).l

loc_7498E:
		move.w	(_unkFAB0).w,d0
		addi.w	#$200,d0
		cmp.w	(Player_1+y_pos).w,d0
		bhi.w	locret_74374
		move.w	#$700,d0
		jsr	(StartNewLevel).l
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_749AE:
		lea	ObjDat3_750C2(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_749BE,(a0)

loc_749BE:
		jsr	(Child_GetPriorityOnce).l
		jsr	(Refresh_ChildPositionAdjusted).l
		jmp	(Child_Draw_Sprite2).l
; ---------------------------------------------------------------------------

loc_749D0:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_749E6(pc,d0.w),d1
		jsr	off_749E6(pc,d1.w)
		moveq	#$C,d0
		jmp	(Child_DrawTouch_Sprite_FlickerMove).l
; ---------------------------------------------------------------------------
off_749E6:
		dc.w loc_749EC-off_749E6
		dc.w loc_74A14-off_749E6
		dc.w loc_74A3E-off_749E6
; ---------------------------------------------------------------------------

loc_749EC:
		lea	ObjDat3_750CE(pc),a1
		jsr	(SetUp_ObjAttributes).l
		movea.w	parent3(a0),a1
		move.w	a0,$44(a1)
		move.b	#$14,child_dx(a0)
		move.b	#-6,child_dy(a0)
		lea	ChildObjDat_75144(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_74A14:
		movea.w	parent3(a0),a1
		btst	#7,art_tile(a1)
		beq.s	loc_74A32
		bset	#7,art_tile(a0)
		move.b	#4,routine(a0)
		move.b	#$AD,collision_flags(a0)

loc_74A32:
		lea	(LBZFinalBoss2_CircleLookup).l,a2
		jmp	(MoveSprite_CircularLookup).l
; ---------------------------------------------------------------------------

loc_74A3E:
		movea.w	parent3(a0),a1
		btst	#1,$38(a1)
		bne.w	locret_74374
		btst	#2,$38(a1)
		bne.s	loc_74A88
		lea	(Player_1).w,a1
		move.b	$3C(a0),d0
		move.w	y_pos(a0),d1
		sub.w	y_pos(a1),d1
		cmpi.w	#-2,d1
		blt.s	loc_74A7C
		cmpi.w	#2,d1
		ble.s	loc_74A88
		subq.b	#1,d0
		cmpi.b	#-$30,d0
		blt.s	loc_74A88
		bra.w	loc_74A84
; ---------------------------------------------------------------------------

loc_74A7C:
		addq.b	#1,d0
		cmpi.b	#0,d0
		bgt.s	loc_74A88

loc_74A84:
		move.b	d0,$3C(a0)

loc_74A88:
		jsr	(Change_FlipXUseParent).l
		lea	(LBZFinalBoss2_CircleLookup).l,a2
		jmp	(MoveSprite_CircularLookup).l
; ---------------------------------------------------------------------------

loc_74A9A:
		lea	word_750E0(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#loc_74ACA,(a0)
		movea.w	parent3(a0),a1
		movea.w	parent3(a1),a2
		move.w	a2,parent3(a0)
		move.w	a1,$44(a0)
		move.w	a1,$44(a0)
		move.b	#$18,child_dx(a0)
		move.b	#-6,child_dy(a0)

loc_74ACA:
		jsr	(Child_GetPriorityOnce).l
		jsr	(Change_FlipXUseParent).l
		movea.w	$44(a0),a1
		move.b	$3C(a1),d0
		addi.b	#$14,d0
		move.b	d0,$3C(a0)
		lea	(LBZ2FinalBoss2_CircleLookup2).l,a2
		jsr	(MoveSprite_CircularLookup).l
		moveq	#$C,d0
		jmp	(Child_DrawTouch_Sprite_FlickerMove).l
; ---------------------------------------------------------------------------

loc_74AFA:
		lea	word_750DA(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		movea.w	parent3(a0),a1
		move.w	parent3(a1),$44(a0)
		move.l	#loc_74B36,(a0)
		move.l	#byte_75194,$30(a0)
		tst.b	subtype(a0)
		beq.s	loc_74B36
		move.b	#8,mapping_frame(a0)
		move.w	#$180,priority(a0)
		move.l	#byte_7519C,$30(a0)

loc_74B36:
		jsr	(Child_GetPriorityOnce).l

loc_74B3C:
		jsr	(Refresh_ChildPositionAdjusted).l
		jsr	(Animate_Raw).l
		movea.w	$44(a0),a1
		tst.b	$30(a1)
		beq.s	loc_74B6E
		move.l	#loc_74B76,(a0)
		move.b	#7,mapping_frame(a0)
		tst.b	subtype(a0)
		beq.s	loc_74B6E
		move.b	#$B,mapping_frame(a0)
		addq.b	#8,child_dx(a0)

loc_74B6E:
		moveq	#$C,d0
		jmp	(Child_DrawTouch_Sprite_FlickerMove).l
; ---------------------------------------------------------------------------

loc_74B76:
		jsr	(Refresh_ChildPositionAdjusted).l
		movea.w	$44(a0),a1
		tst.b	$30(a1)
		bne.s	loc_74B96
		move.l	#loc_74B3C,(a0)
		tst.b	subtype(a0)
		beq.s	loc_74B96
		subq.b	#8,child_dx(a0)

loc_74B96:
		moveq	#$C,d0
		jmp	(Child_DrawTouch_Sprite_FlickerMove).l
; ---------------------------------------------------------------------------

loc_74B9E:
		lea	ObjDat3_750E6(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_74BAE,(a0)

loc_74BAE:
		jsr	(Child_GetPriorityOnce).l
		jsr	(Refresh_ChildPositionAdjusted).l
		jmp	(Child_Draw_Sprite2).l
; ---------------------------------------------------------------------------

loc_74BC0:
		lea	ObjDat3_750F2(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_74BD0,(a0)

loc_74BD0:
		move.b	#$9A,d0
		bsr.w	sub_74EBC
		jsr	(Refresh_ChildPositionAdjusted).l
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.s	loc_74BFA
		btst	#0,(V_int_run_count+3).w
		bne.w	locret_74374
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_74BFA:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_74C00:
		move.l	#loc_74C0C,(a0)
		move.b	#$9C,collision_flags(a0)

loc_74C0C:
		jsr	(Refresh_ChildPositionAdjusted).l
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.s	loc_74BFA
		jmp	(Add_SpriteToCollisionResponseList).l
; ---------------------------------------------------------------------------

loc_74C24:
		move.l	#loc_74C34,(a0)
		movea.w	parent3(a0),a1
		move.w	parent3(a1),$44(a0)

loc_74C34:
		jsr	(Refresh_ChildPositionAdjusted).l
		movea.w	$44(a0),a1
		btst	#7,status(a1)
		bne.s	loc_74C7A
		btst	#3,$38(a1)
		bne.w	locret_74374
		btst	#6,status(a1)
		bne.w	locret_74374
		lea	word_74C84(pc),a1
		jsr	(Check_PlayerInRange).l
		tst.w	d0
		beq.s	locret_74C78
		movea.w	d0,a1
		tst.b	invulnerability_timer(a1)
		bne.s	locret_74C78
		cmpi.b	#6,routine(a1)
		blo.s	loc_74C8C

locret_74C78:
		rts
; ---------------------------------------------------------------------------

loc_74C7A:
		clr.b	(Player_1+object_control).w
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------
word_74C84:
		dc.w   -$10,   $20,  -$10,   $20
; ---------------------------------------------------------------------------

loc_74C8C:
		move.l	#loc_74CCC,(a0)
		movea.w	$44(a0),a1
		st	$30(a1)
		move.b	#$1E,routine(a1)
		move.w	#$40,$2E(a1)
		move.l	#loc_74562,$34(a1)
		lea	(Player_1).w,a1
		move.b	#$81,object_control(a1)
		move.b	#2,anim(a1)
		moveq	#0,d0
		move.w	d0,x_vel(a1)
		move.w	d0,y_vel(a1)
		move.w	d0,ground_vel(a1)

loc_74CCC:
		movea.w	$44(a0),a1
		tst.b	$30(a1)
		beq.s	loc_74CF8
		btst	#7,status(a1)
		bne.w	loc_74BFA
		jsr	(Refresh_ChildPositionAdjusted).l
		lea	(Player_1).w,a1
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		rts
; ---------------------------------------------------------------------------

loc_74CF8:
		move.l	#loc_74D04,(a0)
		move.w	#$40,$2E(a0)

loc_74D04:
		subq.w	#1,$2E(a0)
		bmi.s	loc_74D0C
		rts
; ---------------------------------------------------------------------------

loc_74D0C:
		move.l	#loc_74C34,(a0)
		rts
; ---------------------------------------------------------------------------

loc_74D14:
		lea	ObjDat3_750FE(pc),a1
		jsr	(SetUp_ObjAttributes).l
		jsr	(Refresh_ChildPositionAdjusted).l
		move.l	#Obj_FlickerMove,(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		lsr.w	#1,d0
		addi.b	#$D,d0
		move.b	d0,mapping_frame(a0)
		moveq	#0,d0
		jsr	(Set_IndexedVelocity).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_74D48:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_74D5C(pc,d0.w),d1
		jsr	off_74D5C(pc,d1.w)
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------
off_74D5C:
		dc.w loc_74D62-off_74D5C
		dc.w loc_74D7C-off_74D5C
		dc.w loc_74DEA-off_74D5C
; ---------------------------------------------------------------------------

loc_74D62:
		lea	ObjDat3_7510A(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.b	#$10,y_radius(a0)
		move.l	#loc_74D90,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_74D7C:
		jsr	(MoveSprite).l
		tst.w	y_vel(a0)
		bmi.w	locret_74374
		jmp	(ObjHitFloor_DoRoutine).l
; ---------------------------------------------------------------------------

loc_74D90:
		move.w	y_vel(a0),d0
		cmpi.w	#$100,d0
		blo.s	loc_74DA4
		asr.w	#1,d0
		neg.w	d0
		move.w	d0,y_vel(a0)
		rts
; ---------------------------------------------------------------------------

loc_74DA4:
		move.l	#loc_74DEA,(a0)
		move.b	#$7F,$39(a0)
		movea.w	parent3(a0),a1
		bset	#3,$38(a1)
		lea	(ChildObjDat_690D8).l,a2
		jsr	(CreateChild1_Normal).l
		move.w	#$1000,d0
		move.w	d0,(Camera_stored_max_Y_pos).w
		move.w	d0,(Camera_target_max_Y_pos).w
		move.w	#$6000,(Camera_stored_max_X_pos).w
		move.w	#0,(Camera_stored_min_Y_pos).w
		lea	(Child1_Act2LevelSize).l,a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_74DEA:
		bclr	#7,render_flags(a0)
		move.b	(V_int_run_count+3).w,d0
		andi.b	#3,d0
		bne.w	locret_74374
		subq.b	#1,$39(a0)
		bmi.s	loc_74E0C
		lea	ChildObjDat_7518E(pc),a2
		jmp	(CreateChild6_Simple).l
; ---------------------------------------------------------------------------

loc_74E0C:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_74E12:
		lea	ObjDat3_75116(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_74E24,(a0)
		rts
; ---------------------------------------------------------------------------

loc_74E24:
		jsr	(Refresh_ChildPosition).l
		jmp	(Child_Draw_Sprite2).l
; ---------------------------------------------------------------------------

loc_74E30:
		jsr	(Random_Number).l
		andi.w	#$3C,d0
		lea	word_74E7C(pc,d0.w),a1
		move.w	(a1)+,x_pos(a0)
		move.w	(a1)+,y_pos(a0)
		move.l	#Obj_Wait,(a0)
		move.w	#$60,$2E(a0)
		move.l	#loc_74E70,$34(a0)
		lea	(Child6_CreateBossExplosion).l,a2
		jsr	(CreateChild1_Normal).l
		bne.s	locret_74E6E
		move.b	#4,subtype(a1)

locret_74E6E:
		rts
; ---------------------------------------------------------------------------

loc_74E70:
		bset	#5,$38(a0)
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------
word_74E7C:
		dc.w  $4310,  $3ED
		dc.w  $4330,  $3F0
		dc.w  $4350,  $3F0
		dc.w  $4370,  $3F0
		dc.w  $4390,  $3F0
		dc.w  $43B0,  $3F0
		dc.w  $43D0,  $3F0
		dc.w  $43F0,  $3F0
		dc.w  $4410,  $3F0
		dc.w  $4430,  $3ED
		dc.w  $4450,  $3E5
		dc.w  $4470,  $3D6
		dc.w  $4490,  $3B8
		dc.w  $44B0,  $3A2
		dc.w  $44D0,  $395
		dc.w  $44F0,  $390

; =============== S U B R O U T I N E =======================================


sub_74EBC:
		movea.w	parent3(a0),a1
		btst	#7,art_tile(a1)
		beq.s	locret_74ED4
		bset	#7,art_tile(a0)
		move.l	(sp),(a0)
		move.b	d0,collision_flags(a0)

locret_74ED4:
		rts
; End of function sub_74EBC

; ---------------------------------------------------------------------------
		movea.w	$44(a0),a1
		movea.w	parent3(a0),a2
		move.w	x_pos(a1),d0
		moveq	#$10,d2
		btst	#0,render_flags(a2)
		beq.s	loc_74EEE
		neg.w	d2

loc_74EEE:
		add.w	d2,d0
		move.w	x_pos(a2),d1
		moveq	#$C,d2
		btst	#0,render_flags(a2)
		beq.s	loc_74F00
		neg.w	d2

loc_74F00:
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

loc_74F24:
		jsr	(Random_Number).l
		andi.w	#6,d0
		move.w	d0,$3A(a0)
		move.w	(Camera_X_pos).w,d1
		move.w	#$1A8,d2
		move.w	#-$300,d3
		btst	#0,render_flags(a0)
		beq.s	loc_74F4C
		move.w	#-$68,d2
		neg.w	d3

loc_74F4C:
		add.w	d2,d1
		move.w	d1,x_pos(a0)
		move.w	d3,x_vel(a0)
		move.w	(Camera_Y_pos).w,d1
		move.w	word_74F72(pc,d0.w),d2
		add.w	d1,d2
		move.w	d2,y_pos(a0)
		move.w	word_74F7A(pc,d0.w),y_vel(a0)
		move.w	#8,$3C(a0)
		rts
; ---------------------------------------------------------------------------
word_74F72:
		dc.w    $60,   $10,   $A0,   $80
word_74F7A:
		dc.w      0,  $200, -$200,     0
; ---------------------------------------------------------------------------

loc_74F82:
		move.w	#-$300,d0
		btst	#0,render_flags(a0)
		beq.s	loc_74F90
		neg.w	d0

loc_74F90:
		move.w	d0,x_vel(a0)
		jsr	(Random_Number).l
		andi.w	#$7F,d0
		addi.w	#$C0,d0
		move.w	d0,$2E(a0)
		rts

; =============== S U B R O U T I N E =======================================


sub_74FA8:
		move.w	(Camera_X_pos).w,d0
		tst.w	x_vel(a0)
		bmi.s	loc_74FBE
		add.w	d2,d0
		cmp.w	x_pos(a0),d0
		bls.s	loc_74FC6
		bra.w	locret_74FD0
; ---------------------------------------------------------------------------

loc_74FBE:
		add.w	d1,d0
		cmp.w	x_pos(a0),d0
		blo.s	locret_74FD0

loc_74FC6:
		bchg	#0,render_flags(a0)
		neg.w	x_vel(a0)

locret_74FD0:
		rts
; End of function sub_74FA8


; =============== S U B R O U T I N E =======================================


sub_74FD2:
		cmpi.b	#8,routine(a0)
		blo.s	locret_75044
		tst.b	collision_flags(a0)
		bne.s	locret_75044
		move.b	collision_property(a0),d0
		beq.s	loc_75046
		tst.b	$20(a0)
		bne.s	loc_75010
		cmpi.b	#$A,routine(a0)
		bne.s	loc_74FFA
		move.w	#8,$3A(a0)

loc_74FFA:
		move.b	#$3C,$20(a0)
		moveq	#signextendB(sfx_BossHit),d0
		jsr	(Play_SFX).l
		movea.w	$44(a0),a1
		clr.b	collision_flags(a1)

loc_75010:
		bset	#6,status(a0)
		moveq	#0,d0
		btst	#0,$20(a0)
		bne.s	loc_75024
		addi.w	#2*6,d0

loc_75024:
		bsr.w	sub_75084
		subq.b	#1,$20(a0)
		bne.s	locret_75044
		bclr	#6,status(a0)
		move.b	$25(a0),collision_flags(a0)
		movea.w	$44(a0),a1
		move.b	#$AD,collision_flags(a1)

locret_75044:
		rts
; ---------------------------------------------------------------------------

loc_75046:
		move.l	#Wait_FadeToLevelMusic,(a0)
		move.l	#loc_746D8,$34(a0)
		jsr	(BossDefeated_StopTimer).l
		lea	(Child6_CreateBossExplosion).l,a2
		jsr	(CreateChild6_Simple).l
		bne.s	loc_7506E
		move.b	#4,subtype(a1)

loc_7506E:
		tst.b	$30(a0)
		; Bug: this branch is inverted, freeing the player if they're _not_ being held
		bne.s	loc_7507A
		jsr	(Restore_PlayerControl).l

loc_7507A:
		lea	ChildObjDat_75186(pc),a2
		jmp	(CreateChild1_Normal).l
; End of function sub_74FD2


; =============== S U B R O U T I N E =======================================


sub_75084:
		lea	word_75092(pc),a1
		lea	word_7509E(pc,d0.w),a2
		jmp	(CopyWordData_6).l
; End of function sub_75084

; ---------------------------------------------------------------------------
word_75092:
		dc.w Normal_palette_line_2+$08, Normal_palette_line_2+$0E, Normal_palette_line_2+$10
		dc.w Normal_palette_line_2+$18, Normal_palette_line_2+$1A, Normal_palette_line_2+$1C
word_7509E:
		dc.w      8,    $A,     4,  $644,  $422,     0
		dc.w   $888,  $666,  $AAA,  $AAA,  $EEE,  $EEE
ObjDat_LBZFinalBoss2:
		dc.l Map_RobotnikShip
		dc.w make_art_tile($52E,0,0)
		dc.w   $280
		dc.b  $1C, $20,   5,   0
ObjDat3_750C2:
		dc.l Map_LBZFinalBoss2
		dc.w make_art_tile($3D9,1,0)
		dc.w $200
		dc.b  $28, $28,   0,   0
ObjDat3_750CE:
		dc.l Map_LBZFinalBoss2
		dc.w make_art_tile($3D9,1,0)
		dc.w   $180
		dc.b  $20, $10,   2,   0
word_750DA:
		dc.w    $80
		dc.b  $14, $14,   4,   0
word_750E0:
		dc.w   $180
		dc.b    8,   8,   3,   0
ObjDat3_750E6:
		dc.l Map_LBZFinalBoss2
		dc.w make_art_tile($23D9,1,0)
		dc.w   $300
		dc.b  $14,  $C,   1,   0
ObjDat3_750F2:
		dc.l Map_LBZFinalBoss2
		dc.w make_art_tile($3D9,0,0)
		dc.w   $300
		dc.b   $C,  $C,  $C,   0
ObjDat3_750FE:
		dc.l Map_LBZFinalBoss2
		dc.w make_art_tile($3D9,1,1)
		dc.w   $100
		dc.b  $10, $14,  $D,   0
ObjDat3_7510A:
		dc.l Map_LBZFinalBoss1
		dc.w make_art_tile($3AA,1,1)
		dc.w   $300
		dc.b   $C, $10, $16,   0
ObjDat3_75116:
		dc.l Map_LBZFinalBoss1
		dc.w make_art_tile($3AA,1,1)
		dc.w   $200
		dc.b  $10,   4, $15,   0
ChildObjDat_75122:
		dc.w 4-1
		dc.l loc_749D0
		dc.b  $14, $24
		dc.l loc_749AE
		dc.b   $C,-$14
		dc.l loc_74B9E
		dc.b    0,-$18
		dc.l loc_74BC0
		dc.b  $38,-$14
ChildObjDat_7513C:
		dc.w 1-1
		dc.l loc_74C00
		dc.b    4,-$34
ChildObjDat_75144:
		dc.w 4-1
		dc.l loc_74AFA
		dc.b -$2A,  -2
		dc.l loc_74AFA
		dc.b -$4A,  -2
		dc.l loc_74A9A
		dc.b    0,   0
		dc.l loc_74C24
		dc.b -$40,  -2
ChildObjDat_7515E:
		dc.w 4
		dc.l loc_74D14
		dc.b  -$C,-$2C
		dc.l loc_74D14
		dc.b  $14,-$2C
		dc.l loc_74D14
		dc.b  $2C,-$18
		dc.l loc_74D14
		dc.b  -$C,  -4
		dc.l loc_74D14
		dc.b  $14,  -4
ChildObjDat_7517E:
		dc.w 1-1
		dc.l loc_74D48
		dc.b    0,   8
ChildObjDat_75186:
		dc.w 1-1
		dc.l loc_74E12
		dc.b    0, $10
ChildObjDat_7518E:
		dc.w 1-1
		dc.l loc_74E30
byte_75194:
		dc.b    9,   7,   4,   5,   6,   5,   4, $FC
byte_7519C:
		dc.b    9,  $B,   8,   9,  $A,   9,   8, $FC
byte_751A4:	; used in S3, unused in S3K
		dc.b    2,   4,   4,   5,   6, $F4
Pal_LBZFinalBoss2:
		binclude "Levels/LBZ/Palettes/Final Boss 2.bin"
		even
; ---------------------------------------------------------------------------

Obj_HCZEndBoss:
		move.w	#$4050,(Camera_max_X_pos).w
		lea	word_48D26(pc),a1
		jsr	(Check_CameraInRange).l
		move.l	#loc_48D2E,(a0)
		move.b	#1,(Boss_flag).w
		moveq	#signextendB(mus_FadeOut),d0
		jsr	(Play_Music).l
		move.w	#2*60,$2E(a0)
		move.b	#mus_EndBoss,$26(a0)
		move.w	(Camera_target_max_Y_pos).w,(Camera_stored_max_Y_pos).w
		move.w	#$738,(Camera_target_max_Y_pos).w
		move.w	#$4000,$1C(a0)
		move.l	#loc_48D34,$34(a0)
		rts
; ---------------------------------------------------------------------------
word_48D26:
		dc.w   $400,  $880, $3E80, $4090
; ---------------------------------------------------------------------------

loc_48D2E:
		jmp	(loc_541C8).l
; ---------------------------------------------------------------------------

loc_48D34:
		move.l	#loc_48D3C,(a0)

locret_48D3A:
		rts
; ---------------------------------------------------------------------------

loc_48D3C:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_48D54(pc,d0.w),d1
		jsr	off_48D54(pc,d1.w)
		bsr.w	sub_49A06
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------
off_48D54:
		dc.w loc_48D62-off_48D54
		dc.w loc_48DBC-off_48D54
		dc.w loc_48DFE-off_48D54
		dc.w loc_48DBC-off_48D54
		dc.w loc_48DBC-off_48D54
		dc.w loc_48DFE-off_48D54
		dc.w loc_48EAA-off_48D54
; ---------------------------------------------------------------------------

loc_48D62:
		lea	ObjDat_HCZEndBoss(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.b	#8,collision_property(a0)
		move.w	#$80,y_vel(a0)
		move.w	#$EF,$2E(a0)
		move.l	#loc_48DC8,$34(a0)
		moveq	#$6C,d0
		jsr	(Load_PLC).l
		move.w	#0,(Normal_palette+$1E).w
		lea	Pal_HCZEndBoss(pc),a1
		jsr	(PalLoad_Line1).l
		lea	(ChildObjDat_49C2E).l,a2
		jsr	(CreateChild1_Normal).l
		bne.s	loc_48DB2
		move.b	#5,subtype(a1)

loc_48DB2:
		lea	ChildObjDat_49BCC(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_48DBC:
		jsr	(MoveSprite2).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_48DC8:
		move.b	#4,routine(a0)
		move.w	y_pos(a0),$3A(a0)
		move.w	#-$100,$44(a0)
		move.w	#$9F,$30(a0)
		move.w	#$3F,$2E(a0)
		move.l	#loc_48E10,$34(a0)
		lea	(PLC_Explosion).l,a1
		jsr	(Load_PLC_Raw).l
		jmp	Swing_Setup1(pc)
; ---------------------------------------------------------------------------

loc_48DFE:
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_48E10:
		bset	#3,$38(a0)
		tst.b	(_unkFA80+1).w
		bne.s	loc_48E38
		move.b	#6,routine(a0)
		move.w	#$80,y_vel(a0)
		move.w	#$9F,$2E(a0)
		move.l	#loc_48E4E,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_48E38:
		move.b	#$A,routine(a0)
		move.w	#$1FF,$2E(a0)
		move.l	#loc_48E80,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_48E4E:
		move.w	#-$100,y_vel(a0)
		move.w	#$4F,$2E(a0)
		move.l	#loc_48E64,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_48E64:
		move.b	#$A,routine(a0)
		move.w	#$FF,$2E(a0)
		move.w	$3A(a0),y_pos(a0)
		move.l	#loc_48E80,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_48E80:
		move.b	#$C,routine(a0)
		bclr	#3,$38(a0)
		move.w	$44(a0),x_vel(a0)
		move.w	#$BF,$2E(a0)
		move.l	#loc_48ED4,$34(a0)
		move.b	#8,$39(a0)
		jmp	Swing_Setup1(pc)
; ---------------------------------------------------------------------------

loc_48EAA:
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		jsr	(Obj_Wait).l
		subq.w	#1,$30(a0)
		bpl.s	locret_48ED2
		neg.w	x_vel(a0)
		bchg	#0,render_flags(a0)
		move.w	#$13F,$30(a0)

locret_48ED2:
		rts
; ---------------------------------------------------------------------------

loc_48ED4:
		move.w	#$5F,$2E(a0)
		subq.b	#1,$39(a0)
		bmi.s	loc_48EE8
		bset	#1,$38(a0)
		rts
; ---------------------------------------------------------------------------

loc_48EE8:
		move.w	x_vel(a0),$44(a0)
		clr.w	x_vel(a0)
		bra.w	loc_48E10
; ---------------------------------------------------------------------------

loc_48EF6:
		move.l	#loc_48F20,(a0)
		bset	#4,$38(a0)
		move.w	#$7F,$2E(a0)
		move.l	#loc_48F3C,$34(a0)
		moveq	#signextendB(mus_FadeOut),d0
		jsr	(Play_Music).l
		moveq	#$C,d0
		jmp	(Set_IndexedVelocity).l
; ---------------------------------------------------------------------------

loc_48F20:
		jsr	(MoveSprite).l
		jsr	(Obj_Wait).l
		btst	#0,(V_int_run_count+3).w
		beq.w	locret_48D3A
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_48F3C:
		move.l	#loc_48F68,(a0)
		bclr	#7,render_flags(a0)
		st	(_unkFAA8).w
		clr.b	(Boss_flag).w
		jsr	(Restore_LevelMusic).l
		move.w	#$4230,(Camera_stored_max_X_pos).w
		lea	(Child6_IncLevX).l,a2
		jmp	(CreateChild6_Simple).l
; ---------------------------------------------------------------------------

loc_48F68:
		move.w	(Camera_X_pos).w,(Camera_min_X_pos).w
		tst.b	(_unkFAA8).w
		bne.w	locret_48D3A
		clr.w	(Ctrl_1_logical).w
		clr.w	(Ctrl_2_logical).w
		st	(Ctrl_1_locked).w
		st	(Ctrl_2_locked).w
		move.b	#$80,(Player_1+object_control).w
		jsr	(Restore_PlayerControl).l
		lea	(Player_2).w,a1
		jsr	(Restore_PlayerControl2).l
		lea	ChildObjDat_49C36(pc),a2
		jsr	(CreateChild6_Simple).l
		move.w	#0,(Camera_min_Y_pos).w
		jmp	(Go_Delete_Sprite_2).l
; ---------------------------------------------------------------------------

loc_48FB2:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_48FCE(pc,d0.w),d1
		jsr	off_48FCE(pc,d1.w)
		jsr	(Refresh_ChildPosition).l
		moveq	#0,d0
		jmp	(Child_DrawTouch_Sprite2_FlickerMove).l
; ---------------------------------------------------------------------------
off_48FCE:
		dc.w loc_48FD8-off_48FCE
		dc.w loc_48FE2-off_48FCE
		dc.w loc_4900E-off_48FCE
		dc.w loc_49034-off_48FCE
		dc.w loc_49066-off_48FCE
; ---------------------------------------------------------------------------

loc_48FD8:
		lea	word_49B74(pc),a1
		jmp	(SetUp_ObjAttributes3).l
; ---------------------------------------------------------------------------

loc_48FE2:
		movea.w	parent3(a0),a1
		btst	#3,$38(a1)
		bne.s	loc_48FF0
		rts
; ---------------------------------------------------------------------------

loc_48FF0:
		move.b	#4,routine(a0)
		move.b	#$A6,collision_flags(a0)
		move.l	#byte_49C3C,$30(a0)
		move.l	#loc_4901C,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_4900E:
		moveq	#signextendB(sfx_FanBig),d0
		jsr	(Play_SFX_Continuous).l
		jmp	(Animate_RawGetFaster).l
; ---------------------------------------------------------------------------

loc_4901C:
		move.b	#6,routine(a0)
		move.l	#byte_49C43,$30(a0)
		lea	ChildObjDat_49BFC(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_49034:
		jsr	(Animate_Raw).l
		movea.w	parent3(a0),a1
		btst	#3,$38(a1)
		beq.s	loc_4904E
		moveq	#signextendB(sfx_FanBig),d0
		jmp	(Play_SFX_Continuous).l
; ---------------------------------------------------------------------------

loc_4904E:
		move.b	#8,routine(a0)
		move.l	#byte_49C49,$30(a0)
		move.l	#loc_4906C,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_49066:
		jmp	(Animate_RawGetSlower).l
; ---------------------------------------------------------------------------

loc_4906C:
		move.b	#2,routine(a0)
		clr.b	collision_flags(a0)
		rts
; ---------------------------------------------------------------------------

loc_49078:
		move.w	x_pos(a0),-(sp)
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_490A8(pc,d0.w),d1
		jsr	off_490A8(pc,d1.w)
		move.w	#$1F,d1
		move.w	#$C,d2
		move.w	#$C,d3
		move.w	(sp)+,d4
		jsr	(SolidObjectTop).l
		bsr.w	sub_49A84
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
off_490A8:
		dc.w loc_490B4-off_490A8
		dc.w loc_490FC-off_490A8
		dc.w loc_49128-off_490A8
		dc.w loc_49140-off_490A8
		dc.w loc_49128-off_490A8
		dc.w loc_4919E-off_490A8
; ---------------------------------------------------------------------------

loc_490B4:
		lea	word_49B80(pc),a1
		jsr	(SetUp_ObjAttributes2).l
		move.w	(Water_level).w,d0
		subq.w	#8,d0
		move.w	d0,y_pos(a0)
		move.w	d0,$3A(a0)
		move.l	#byte_49C54,$30(a0)
		move.l	#loc_49102,$34(a0)
		lea	ChildObjDat_49C0C(pc),a2
		jsr	(CreateChild1_Normal).l
		lea	ChildObjDat_49C28(pc),a2
		jsr	(CreateChild6_Simple).l
		movea.w	parent3(a0),a1
		move.w	parent3(a1),$44(a0)
		rts
; ---------------------------------------------------------------------------

loc_490FC:
		jmp	(Animate_Raw).l
; ---------------------------------------------------------------------------

loc_49102:
		move.b	#4,routine(a0)
		move.l	#byte_49C5D,$30(a0)
		move.w	#-$100,y_vel(a0)
		move.l	#loc_49138,$34(a0)
		lea	ChildObjDat_49C04(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_49128:
		jsr	(MoveSprite2).l
		jsr	(Animate_Raw).l
		bra.w	sub_49ACC
; ---------------------------------------------------------------------------

loc_49138:
		move.b	#6,routine(a0)
		rts
; ---------------------------------------------------------------------------

loc_49140:
		jsr	(Animate_Raw).l
		movea.w	$44(a0),a1
		btst	#3,$38(a1)
		beq.s	loc_49154
		rts
; ---------------------------------------------------------------------------

loc_49154:
		move.b	#8,routine(a0)
		bset	#3,$38(a0)
		move.w	#$80,y_vel(a0)
		move.l	#loc_49184,$34(a0)
		move.w	#$80,x_vel(a0)
		tst.w	x_vel(a1)
		bpl.s	locret_4917E
		neg.w	x_vel(a0)

locret_4917E:
		rts
; ---------------------------------------------------------------------------
		bra.w	sub_49ACC
; ---------------------------------------------------------------------------

loc_49184:
		move.l	#loc_4919E,(a0)
		move.w	#$F,$2E(a0)
		clr.w	x_vel(a0)
		move.l	#loc_491C6,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_4919E:
		move.w	#$1F,d1
		move.w	#$C,d2
		move.w	#$C,d3
		move.w	x_pos(a0),d4
		jsr	(SolidObjectTop).l
		jsr	(Animate_Raw).l
		jsr	(Obj_Wait).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_491C6:
		jsr	(Displace_PlayerOffObject).l
		jmp	(Go_Delete_Sprite_2).l
; ---------------------------------------------------------------------------

loc_491D2:
		jsr	(MoveSprite2).l
		jsr	(Animate_Raw).l
		bsr.w	sub_49ACC
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_491E8:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_49200(pc,d0.w),d1
		jsr	off_49200(pc,d1.w)
		bsr.w	sub_49AB2
		jmp	(Child_Draw_Sprite2).l
; ---------------------------------------------------------------------------
off_49200:
		dc.w loc_49206-off_49200
		dc.w loc_4921A-off_49200
		dc.w loc_4924A-off_49200
; ---------------------------------------------------------------------------

loc_49206:
		lea	word_49B88(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#byte_49C61,$30(a0)
		rts
; ---------------------------------------------------------------------------

loc_4921A:
		bsr.w	sub_4981E
		bsr.w	sub_497E8
		bsr.w	sub_49752
		jsr	(Animate_Raw).l
		movea.w	parent3(a0),a1
		btst	#3,$38(a1)
		bne.s	loc_4923A
		rts
; ---------------------------------------------------------------------------

loc_4923A:
		move.b	#4,routine(a0)
		move.w	x_vel(a1),x_vel(a0)
		bra.w	loc_49960
; ---------------------------------------------------------------------------

loc_4924A:
		bsr.w	sub_49752
		move.w	x_vel(a1),x_vel(a0)
		jsr	(MoveSprite2).l
		jmp	(Animate_Raw).l
; ---------------------------------------------------------------------------

loc_49260:
		lea	word_49B8E(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#loc_49284,(a0)
		move.l	#byte_49C7A,$30(a0)

loc_49278:
		move.w	(Water_level).w,d0
		subq.w	#4,d0
		move.w	d0,y_pos(a0)
		rts
; ---------------------------------------------------------------------------

loc_49284:
		jsr	(Animate_Raw).l
		moveq	#0,d0
		move.b	subtype(a0),d0
		move.w	word_492A8(pc,d0.w),d0
		movea.w	parent3(a0),a1
		move.w	x_pos(a1),d1
		add.w	d0,d1
		move.w	d1,x_pos(a0)
		jmp	(Child_Draw_Sprite2).l
; ---------------------------------------------------------------------------
word_492A8:
		dc.w     -4,     4
; ---------------------------------------------------------------------------

loc_492AC:
		lea	word_49B94(pc),a1
		jsr	(SetUp_ObjAttributes2).l
		move.l	#AnimateRaw_DrawTouch,(a0)
		move.l	#byte_49C7E,$30(a0)
		move.l	#Go_Delete_Sprite,$34(a0)
		bra.s	loc_49278
; ---------------------------------------------------------------------------

loc_492CE:
		lea	ObjDat3_49B9C(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#Obj_Wait,(a0)
		move.l	#loc_492FC,$34(a0)
		bsr.w	sub_497A8
		tst.b	subtype(a0)
		bne.w	locret_48D3A
		lea	ChildObjDat_49C0C(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_492FC:
		move.l	#loc_4930C,(a0)
		move.l	#Go_Delete_Sprite_2,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_4930C:
		bsr.w	sub_49982
		jmp	(AnimateRaw_DrawTouch).l
; ---------------------------------------------------------------------------

loc_49316:
		lea	ObjDat3_49BB4(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_49376,(a0)
		jsr	(Random_Number).l
		andi.w	#$FF,d0
		ext.w	d0
		add.w	d0,x_pos(a0)
		swap	d0
		move.w	(Water_level).w,d1
		andi.w	#$1F,d0
		add.w	d0,d1
		move.w	d1,y_pos(a0)
		andi.w	#3,d0
		move.b	d0,mapping_frame(a0)
		lsl.w	#2,d0
		move.l	off_49366(pc,d0.w),$30(a0)
		move.w	#$1F,$2E(a0)
		move.l	#loc_49390,$34(a0)
		rts
; ---------------------------------------------------------------------------
off_49366:
		dc.l byte_48C8A
		dc.l byte_48C8E
		dc.l byte_48C92
		dc.l byte_48C96
; ---------------------------------------------------------------------------

loc_49376:
		movea.w	parent3(a0),a3
		bsr.w	sub_499DC
		jsr	(Animate_Raw).l
		jsr	(Obj_Wait).l
		jmp	(Child_Draw_Sprite2).l
; ---------------------------------------------------------------------------

loc_49390:
		move.l	#loc_493A2,(a0)
		movea.l	$30(a0),a1
		move.b	1(a1),mapping_frame(a0)
		rts
; ---------------------------------------------------------------------------

loc_493A2:
		movea.w	parent3(a0),a3
		btst	#3,$38(a3)
		bne.s	loc_493B8
		bsr.w	sub_499DC
		jmp	(Child_Draw_Sprite2).l
; ---------------------------------------------------------------------------

loc_493B8:
		move.l	#loc_49376,(a0)
		move.w	#$1F,$2E(a0)
		move.l	#Go_Delete_Sprite,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_493CE:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_493E2(pc,d0.w),d1
		jsr	off_493E2(pc,d1.w)
		jmp	(Child_DrawTouch_Sprite).l
; ---------------------------------------------------------------------------
off_493E2:
		dc.w loc_493F0-off_493E2
		dc.w loc_4940A-off_493E2
		dc.w loc_4944E-off_493E2
		dc.w loc_49482-off_493E2
		dc.w loc_494F0-off_493E2
		dc.w loc_49518-off_493E2
		dc.w loc_4953E-off_493E2
; ---------------------------------------------------------------------------

loc_493F0:
		lea	word_49B7A(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.b	#8,y_radius(a0)
		bsr.w	sub_4972C
		jmp	(Refresh_ChildPositionAdjusted).l
; ---------------------------------------------------------------------------

loc_4940A:
		jsr	(Refresh_ChildPositionAdjusted).l
		movea.w	parent3(a0),a1
		btst	#1,$38(a1)
		bne.s	loc_4941E
		rts
; ---------------------------------------------------------------------------

loc_4941E:
		move.b	#4,routine(a0)
		tst.b	subtype(a0)
		beq.s	loc_4942C
		rts
; ---------------------------------------------------------------------------

loc_4942C:
		move.b	#6,routine(a0)
		move.w	#3,$2E(a0)
		move.l	#loc_494C4,$34(a0)
		move.b	#1,$40(a0)
		move.b	#0,$41(a0)
		rts
; ---------------------------------------------------------------------------

loc_4944E:
		jsr	(Refresh_ChildPositionAdjusted).l
		movea.w	parent3(a0),a1
		btst	#1,$38(a1)
		beq.s	loc_49462
		rts
; ---------------------------------------------------------------------------

loc_49462:
		move.b	#6,routine(a0)
		subq.b	#2,subtype(a0)
		move.w	#7,$2E(a0)
		move.l	#loc_4949E,$34(a0)
		bsr.w	sub_4972C
		bra.w	loc_49740
; ---------------------------------------------------------------------------

loc_49482:
		move.b	$40(a0),d0
		add.b	d0,$42(a0)
		move.b	$41(a0),d0
		add.b	d0,$43(a0)
		jsr	(Refresh_ChildPositionAdjusted).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_4949E:
		move.b	#2,routine(a0)
		tst.b	subtype(a0)
		bne.s	locret_494C2
		lea	ChildObjDat_49BEC(pc),a2
		jsr	(CreateChild7_Normal2).l
		bne.s	locret_494C2
		move.w	parent3(a0),parent3(a1)
		move.b	#4,subtype(a1)

locret_494C2:
		rts
; ---------------------------------------------------------------------------

loc_494C4:
		move.b	#8,routine(a0)
		move.l	#loc_49526,$34(a0)
		move.w	#$100,x_vel(a0)
		movea.w	parent3(a0),a1
		bclr	#1,$38(a1)
		btst	#0,render_flags(a1)
		beq.s	locret_494EE
		neg.w	x_vel(a0)

locret_494EE:
		rts
; ---------------------------------------------------------------------------

loc_494F0:
		move.w	y_pos(a0),d0
		cmp.w	(Water_level).w,d0
		bhs.s	loc_49508
		jsr	(MoveSprite_LightGravity).l
		jsr	(ObjHitFloor_DoRoutine).l
		rts
; ---------------------------------------------------------------------------

loc_49508:
		move.b	#$A,routine(a0)
		lea	ChildObjDat_49C1A(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_49518:
		jsr	(MoveSprite_LightGravity).l
		jsr	(ObjHitFloor_DoRoutine).l
		rts
; ---------------------------------------------------------------------------

loc_49526:
		move.b	#$C,routine(a0)
		move.l	#byte_49C4F,$30(a0)
		move.l	#loc_49544,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_4953E:
		jmp	(Animate_RawGetFaster).l
; ---------------------------------------------------------------------------

loc_49544:
		lea	ChildObjDat_49C22(pc),a2
		jsr	(CreateChild6_Simple).l
		moveq	#signextendB(sfx_MissileExplode),d0
		jsr	(Play_SFX).l
		lea	ChildObjDat_49BF4(pc),a2
		jsr	(CreateChild1_Normal).l
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

loc_49566:
		lea	word_49B6E(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#loc_49578,(a0)
		rts
; ---------------------------------------------------------------------------

loc_49578:
		jsr	(Refresh_ChildPositionAdjusted).l
		moveq	#0,d0
		jmp	(Child_Draw_Sprite2_FlickerMove).l
; ---------------------------------------------------------------------------

loc_49586:
		lea	ObjDat3_49BA8(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_495AC,(a0)
		move.l	#byte_49D4A,$30(a0)
		move.l	#Go_Delete_Sprite,$34(a0)
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------

loc_495AC:
		jsr	(Animate_Raw).l
		cmpi.b	#3,mapping_frame(a0)
		bhs.s	loc_495C0
		jsr	(Add_SpriteToCollisionResponseList).l

loc_495C0:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_495C6:
		lea	(ArtKosM_HCZGeyserVert).l,a1
		move.w	#tiles_to_bytes($36B),d2
		jsr	(Queue_Kos_Module).l
		move.l	#loc_495DC,(a0)

loc_495DC:
		tst.b	(Kos_modules_left).w
		bne.w	locret_48D3A
		move.l	#loc_495FE,(a0)
		move.w	#$5F,$2E(a0)
		move.l	#loc_49616,$34(a0)
		st	(Screen_shake_flag).w
		rts
; ---------------------------------------------------------------------------

loc_495FE:
		move.b	(V_int_run_count+3).w,d0
		andi.b	#7,d0
		bne.s	loc_49610
		moveq	#signextendB(sfx_Rumble2),d0
		jsr	(Play_SFX).l

loc_49610:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_49616:
		move.l	#loc_4961C,(a0)

loc_4961C:
		lea	ObjDat3_49BC0(pc),a1
		jsr	(SetUp_ObjAttributes).l
		st	(Screen_shake_flag).w
		moveq	#signextendB(sfx_Geyser),d0
		jsr	(Play_SFX).l
		lea	(Player_1).w,a1
		move.w	x_pos(a1),d0
		move.w	d0,x_pos(a0)
		move.w	(Camera_Y_pos).w,d1
		addi.w	#$130,d1
		move.w	d1,y_pos(a0)
		clr.w	$44(a0)
		lea	(Player_2).w,a1
		addi.w	#$30,d0
		sub.w	x_pos(a1),d0
		cmpi.w	#$60,d0
		bcc.s	loc_49664
		move.w	a1,$44(a0)

loc_49664:
		jsr	(sub_49AF4).l
		move.l	#loc_49674,(a0)
		st	(Palette_cycle_counters+$00).w

loc_49674:
		lea	(Player_1).w,a1
		move.w	y_pos(a0),d0
		subq.w	#6,d0
		move.w	d0,y_pos(a0)
		subi.w	#$60,d0
		cmp.w	y_pos(a1),d0
		bhs.s	loc_496A4
		move.b	#$81,object_control(a1)
		move.b	#$1A,anim(a1)
		move.l	#loc_496B8,(a0)
		move.w	#$5F,$2E(a0)

loc_496A4:
		bsr.w	sub_496F4
		move.l	a0,-(sp)
		jsr	(AnPal_HCZ1).l
		movea.l	(sp)+,a0
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_496B8:
		lea	(Player_1).w,a1
		move.b	#$1A,anim(a1)
		subq.w	#6,y_pos(a0)
		subq.w	#6,(Player_1+y_pos).w
		bsr.w	sub_496F4
		subq.w	#1,$2E(a0)
		bmi.s	loc_496E4
		move.l	a0,-(sp)
		jsr	(AnPal_HCZ1).l
		movea.l	(sp)+,a0
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_496E4:
		move.w	#$200,d0
		jsr	(StartNewLevel).l
		jmp	(Delete_Current_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_496F4:
		move.w	$44(a0),d0
		beq.s	locret_4972A
		movea.w	d0,a1
		btst	#2,$38(a0)
		bne.s	loc_49726
		move.w	y_pos(a0),d0
		subi.w	#$60,d0
		cmp.w	y_pos(a1),d0
		bcc.s	locret_4972A
		bset	#2,$38(a0)
		move.b	#$81,object_control(a1)
		move.b	#$1A,anim(a1)
		rts
; ---------------------------------------------------------------------------

loc_49726:
		subq.w	#8,y_pos(a1)

locret_4972A:
		rts
; End of function sub_496F4


; =============== S U B R O U T I N E =======================================


sub_4972C:
		moveq	#0,d0
		move.b	subtype(a0),d0
		move.w	word_4973A(pc,d0.w),priority(a0)
		rts
; End of function sub_4972C

; ---------------------------------------------------------------------------
word_4973A:
		dc.w   $280
		dc.w   $200
		dc.w   $180
; ---------------------------------------------------------------------------

loc_49740:
		moveq	#0,d0
		move.b	subtype(a0),d0
		move.w	word_4974E(pc,d0.w),$40(a0)
		rts
; ---------------------------------------------------------------------------
word_4974E:
		dc.w   $101
		dc.w   $100

; =============== S U B R O U T I N E =======================================


sub_49752:
		movea.w	parent3(a0),a1
		moveq	#0,d0
		move.b	$39(a1),d0
		cmp.b	$39(a0),d0
		beq.s	locret_49782
		move.b	d0,$39(a0)
		move.b	byte_49784+1(pc,d0.w),d1
		ext.w	d1
		move.w	(Water_level).w,d2
		add.w	d1,d2
		move.w	d2,y_pos(a0)
		lsl.w	#2,d0
		move.l	off_49790(pc,d0.w),$30(a0)
		clr.b	anim_frame_timer(a0)

locret_49782:
		rts
; End of function sub_49752

; ---------------------------------------------------------------------------
byte_49784:
		dc.b   -8
		dc.b   -8
		dc.b -$10
		dc.b -$18
		dc.b -$20
		dc.b -$28
		dc.b -$28
		dc.b    0
		dc.b    0
		dc.b    4
		dc.b -$64
		dc.b  $61
		even
off_49790:
		dc.l byte_49C61
		dc.l byte_49C66
		dc.l byte_49C6B
		dc.l byte_49C70
		dc.l byte_49C75
		dc.l byte_49C75

; =============== S U B R O U T I N E =======================================


sub_497A8:
		moveq	#0,d0
		move.b	subtype(a0),d0
		move.w	d0,$2E(a0)
		move.w	word_497CA(pc,d0.w),d1
		move.w	(Water_level).w,d2
		add.w	d1,d2
		move.w	d2,y_pos(a0)
		add.w	d0,d0
		move.l	off_497D4(pc,d0.w),$30(a0)
		rts
; End of function sub_497A8

; ---------------------------------------------------------------------------
word_497CA:
		dc.w     -8
		dc.w   -$18
		dc.w   -$28
		dc.w   -$38
		dc.w   -$48
off_497D4:
		dc.l byte_49C87
		dc.l byte_49CBE
		dc.l byte_49CED
		dc.l byte_49D14
		dc.l byte_49D33

; =============== S U B R O U T I N E =======================================


sub_497E8:
		move.w	x_pos(a0),d0
		move.w	(Water_level).w,d1
		addq.w	#8,d1
		move.l	#$20000,d2
		lea	(Player_1).w,a1
		bsr.w	sub_49804
		lea	(Player_2).w,a1
; End of function sub_497E8


; =============== S U B R O U T I N E =======================================


sub_49804:
		tst.b	object_control(a1)
		bne.s	locret_4981C
		cmp.w	y_pos(a1),d1
		bhs.s	locret_4981C
		cmp.w	x_pos(a1),d0
		bhs.s	loc_49818
		neg.l	d2

loc_49818:
		add.l	d2,x_pos(a1)

locret_4981C:
		rts
; End of function sub_49804


; =============== S U B R O U T I N E =======================================


sub_4981E:
		movea.w	parent3(a0),a1
		moveq	#0,d0
		move.b	$39(a1),d0
		lsl.w	#2,d0
		lea	word_498FE(pc),a1
		lea	(a1,d0.w),a1
		moveq	#$42,d4
		lea	(Player_1).w,a2
		bsr.w	sub_49842
		moveq	#$43,d4
		lea	(Player_2).w,a2
; End of function sub_4981E


; =============== S U B R O U T I N E =======================================


sub_49842:
		movea.w	parent3(a0),a3
		btst	#7,status(a3)
		bne.w	sub_4993E
		cmpi.b	#6,routine(a2)
		bhs.w	loc_498EE
		tst.b	invulnerability_timer(a2)
		bne.w	loc_498EE
		tst.b	object_control(a2)
		beq.s	loc_4986E
		tst.b	(a0,d4.w)
		bne.s	loc_498A8

loc_4986E:
		move.w	y_pos(a0),d0
		move.w	y_pos(a2),d2
		add.w	(a1),d0
		cmp.w	d0,d2
		blo.w	locret_4993C
		add.w	2(a1),d0
		cmp.w	d0,d2
		bhs.w	locret_4993C
		move.w	x_pos(a0),d0
		move.w	x_pos(a2),d2
		sub.w	d2,d0
		addi.w	#$10,d0
		cmpi.w	#$20,d0
		bhs.w	locret_4993C
		tst.b	object_control(a2)
		bne.s	loc_498A8
		bsr.w	sub_49916

loc_498A8:
		move.w	y_pos(a0),d0
		move.w	y_pos(a2),d2
		add.w	(a1)+,d0
		cmp.w	d0,d2
		blo.w	sub_4993E
		move.w	x_pos(a2),d0
		move.w	x_vel(a2),d1
		move.w	#$80,d2
		sub.w	x_pos(a0),d0
		cmpi.w	#-$12,d0
		ble.s	sub_4993E
		cmpi.w	#$12,d0
		bge.s	sub_4993E
		tst.w	d0
		bmi.s	loc_498DA
		neg.w	d2

loc_498DA:
		add.w	d2,d1
		move.w	d1,x_vel(a2)
		ext.l	d1
		lsl.l	#8,d1
		add.l	d1,x_pos(a2)
		subq.w	#2,y_pos(a2)
		rts
; ---------------------------------------------------------------------------

loc_498EE:
		jsr	(Displace_PlayerOffObject).l
		clr.b	(a0,d4.w)
		clr.b	object_control(a2)
		rts
; End of function sub_49842

; ---------------------------------------------------------------------------
word_498FE:
		dc.w   -$18,   $48
		dc.w   -$20,   $58
		dc.w   -$28,   $68
		dc.w   -$30,   $78
		dc.w   -$38,   $88
		dc.w   -$48,   $88

; =============== S U B R O U T I N E =======================================


sub_49916:
		st	(a0,d4.w)
		bset	#Status_InAir,status(a2)
		move.b	#1,object_control(a2)
		move.b	#$18,anim(a2)
		clr.b	spin_dash_flag(a2)
		clr.w	x_vel(a2)
		clr.w	y_vel(a2)
		clr.w	ground_vel(a2)

locret_4993C:
		rts
; End of function sub_49916


; =============== S U B R O U T I N E =======================================


sub_4993E:
		clr.b	(a0,d4.w)
		bset	#Status_InAir,status(a2)
		clr.b	object_control(a2)
		; Bug: this causes Super Sonic to partially detransform if sucked up.
		; As a result, Sonic & Knuckles removes this.
		move.b	#0,routine(a2)
		move.b	#2,anim(a2)
		move.w	#-$200,y_vel(a2)
		rts
; End of function sub_4993E

; ---------------------------------------------------------------------------

loc_49960:
		tst.b	$42(a0)
		beq.s	loc_49970
		clr.b	$42(a0)
		lea	(Player_1).w,a2
		bsr.s	sub_4993E

loc_49970:
		tst.b	$43(a0)
		beq.s	locret_49980
		clr.b	$43(a0)
		lea	(Player_2).w,a2
		bsr.s	sub_4993E

locret_49980:
		rts

; =============== S U B R O U T I N E =======================================


sub_49982:
		cmpi.b	#$30,anim_frame(a0)
		bhs.s	locret_499D2
		lea	word_499D4(pc),a1
		lea	(Player_1).w,a2
		bsr.w	sub_4999E
		lea	word_499D4(pc),a1
		lea	(Player_2).w,a2
; End of function sub_49982


; =============== S U B R O U T I N E =======================================


sub_4999E:
		tst.b	object_control(a2)
		bne.s	locret_499D2
		move.w	x_pos(a0),d0
		move.w	x_pos(a2),d1
		add.w	(a1)+,d0
		cmp.w	d0,d1
		blo.s	locret_499D2
		add.w	(a1)+,d0
		cmp.w	d0,d1
		bhs.s	locret_499D2
		move.w	y_pos(a0),d0
		move.w	y_pos(a2),d1
		add.w	(a1)+,d0
		cmp.w	d0,d1
		blo.s	locret_499D2
		add.w	(a1)+,d0
		cmp.w	d0,d1
		bhs.s	locret_499D2
		move.w	#-$800,y_vel(a2)

locret_499D2:
		rts
; End of function sub_4999E

; ---------------------------------------------------------------------------
word_499D4:
		dc.w    -$C,   $18
		dc.w   -$38,   $40

; =============== S U B R O U T I N E =======================================


sub_499DC:
		movea.w	parent3(a0),a1
		move.w	x_pos(a0),d0
		move.w	x_vel(a0),d1
		move.w	#$80,d2
		sub.w	x_pos(a1),d0
		tst.w	d0
		bmi.s	loc_499F6
		neg.w	d2

loc_499F6:
		add.w	d2,d1
		move.w	d1,x_vel(a0)
		ext.l	d1
		lsl.l	#8,d1
		add.l	d1,x_pos(a0)
		rts
; End of function sub_499DC


; =============== S U B R O U T I N E =======================================


sub_49A06:
		tst.l	(a0)
		beq.s	locret_49A5C
		tst.b	collision_flags(a0)
		bne.s	locret_49A5C
		tst.b	collision_property(a0)
		beq.s	loc_49A5E
		tst.b	$20(a0)
		bne.s	loc_49A2A
		move.b	#$20,$20(a0)
		moveq	#signextendB(sfx_BossHit),d0
		jsr	(Play_SFX).l

loc_49A2A:
		bset	#6,status(a0)
		moveq	#0,d0
		btst	#0,$20(a0)
		bne.s	loc_49A3C
		addq.w	#2*3,d0

loc_49A3C:
		lea	word_49A72(pc),a1
		lea	word_49A78(pc,d0.w),a2
		jsr	(CopyWordData_3).l
		subq.b	#1,$20(a0)
		bne.s	locret_49A5C
		bclr	#6,status(a0)
		move.b	$25(a0),collision_flags(a0)

locret_49A5C:
		rts
; ---------------------------------------------------------------------------

loc_49A5E:
		move.l	#Wait_Draw,(a0)
		move.l	#loc_48EF6,$34(a0)
		jmp	(BossDefeated_StopTimer).l
; End of function sub_49A06

; ---------------------------------------------------------------------------
word_49A72:
		dc.w Normal_palette_line_2+$14, Normal_palette_line_2+$16, Normal_palette_line_2+$1C
word_49A78:
		dc.w      6,   $20,  $624
		dc.w   $EEE,  $EEE,  $EEE

; =============== S U B R O U T I N E =======================================


sub_49A84:
		movea.w	$44(a0),a1
		btst	#7,status(a1)
		beq.s	locret_49AB0
		bset	#7,status(a0)
		move.l	#loc_491D2,(a0)
		move.w	#$100,y_vel(a0)
		move.l	#Go_Delete_Sprite_2,$34(a0)
		jsr	(Displace_PlayerOffObject).l

locret_49AB0:
		rts
; End of function sub_49A84


; =============== S U B R O U T I N E =======================================


sub_49AB2:
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		beq.s	locret_49ACA
		bset	#7,status(a0)
		move.b	#4,routine(a0)

locret_49ACA:
		rts
; End of function sub_49AB2


; =============== S U B R O U T I N E =======================================


sub_49ACC:
		move.w	$3A(a0),d0
		sub.w	y_pos(a0),d0
		bcs.s	loc_49AEE
		andi.w	#$F0,d0
		lsr.w	#4,d0
		move.b	d0,$39(a0)
		tst.w	y_vel(a0)
		bpl.s	locret_49AEC
		cmpi.b	#5,d0
		bhs.s	loc_49AEE

locret_49AEC:
		rts
; ---------------------------------------------------------------------------

loc_49AEE:
		movea.l	$34(a0),a2
		jmp	(a2)
; End of function sub_49ACC

; ---------------------------------------------------------------------------

sub_49AF4:
		lea	(byte_2EC7A).l,a3
		move.w	x_pos(a0),d2
		move.w	y_pos(a0),d3
		subi.w	#$80,d3
		moveq	#8-1,d1

loc_49B08:
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	locret_49B60
		move.l	#loc_2E9AA,(a1)
		move.l	#Map_HCZWaterWallDebris,mappings(a1)
		move.w	#make_art_tile($3C3,2,0),art_tile(a1)
		move.b	#$84,render_flags(a1)
		move.b	(a3)+,d0
		ext.w	d0
		add.w	d2,d0
		move.w	d0,x_pos(a1)
		move.b	(a3)+,d0
		ext.w	d0
		add.w	d3,d0
		move.w	d0,y_pos(a1)
		move.w	#$280,priority(a1)
		move.b	#$18,width_pixels(a1)
		move.b	#$18,height_pixels(a1)
		move.w	(a3)+,x_vel(a1)
		move.w	(a3)+,y_vel(a1)
		move.b	d1,mapping_frame(a1)
		dbf	d1,loc_49B08

locret_49B60:
		rts
; ---------------------------------------------------------------------------
ObjDat_HCZEndBoss:
		dc.l Map_HCZEndBoss
		dc.w make_art_tile($320,1,1)
		dc.w   $100
		dc.b  $2C, $1C,   0,   6
word_49B6E:
		dc.w   $200
		dc.b   $C,   4,   1,   0
word_49B74:
		dc.w   $200
		dc.b  $1C,   4,   2,   0
word_49B7A:
		dc.w   $200
		dc.b  $1C,   4,   6,   0
word_49B80:
		dc.w make_art_tile($320,0,1)
		dc.w    $80
		dc.b  $14,  $C, $17,   0
word_49B88:
		dc.w    $80
		dc.b  $14, $30,  $D,   0
word_49B8E:
		dc.w      0
		dc.b  $10,   4, $1A,   0
word_49B94:
		dc.w make_art_tile($320,0,1)
		dc.w    $80
		dc.b   $C,   8, $18,   0
ObjDat3_49B9C:
		dc.l Map_HCZEndBoss
		dc.w make_art_tile($320,0,1)
		dc.w   $100
		dc.b   $C, $10,   8,   0
ObjDat3_49BA8:
		dc.l Map_Explosion
		dc.w make_art_tile(ArtTile_Explosion,0,1)
		dc.w    $80
		dc.b   $C,  $C,   0, $8B
ObjDat3_49BB4:
		dc.l Map_Bubbler
		dc.w make_art_tile($45C,0,1)
		dc.w   $280
		dc.b  $10, $10,   0,   0
ObjDat3_49BC0:
		dc.l Map_HCZWaterWall
		dc.w make_art_tile($36B,2,0)
		dc.w   $280
		dc.b  $20, $60,   1,   0
ChildObjDat_49BCC:
		dc.w 5-1
		dc.l loc_493CE
		dc.b  $23, $12
		dc.l loc_493CE
		dc.b  $1B,  $A
		dc.l loc_493CE
		dc.b  $13,  $A
		dc.l loc_49566
		dc.b    0, $1C
		dc.l loc_48FB2
		dc.b    0, $24
ChildObjDat_49BEC:
		dc.w 1-1
		dc.l loc_493CE
		dc.b  $13,  $A
ChildObjDat_49BF4:
		dc.w 1-1
		dc.l loc_49586
		dc.b    0,   0
ChildObjDat_49BFC:
		dc.w 1-1
		dc.l loc_49078
		dc.b    0,   0
ChildObjDat_49C04:
		dc.w 1-1
		dc.l loc_491E8
		dc.b    0,   0
ChildObjDat_49C0C:
		dc.w 2-1
		dc.l loc_49260
		dc.b   -4,   0
		dc.l loc_49260
		dc.b    4,   0
ChildObjDat_49C1A:
		dc.w 1-1
		dc.l loc_492AC
		dc.b    0,   0
ChildObjDat_49C22:
		dc.w 5-1
		dc.l loc_492CE
ChildObjDat_49C28:
		dc.w $14-1
		dc.l loc_49316
ChildObjDat_49C2E:
		dc.w 1-1
		dc.l Obj_RobotnikShip2
		dc.b    0,  $C
ChildObjDat_49C36:
		dc.w 1-1
		dc.l loc_495C6
byte_49C3C:
		dc.b    7,   8,   2,   3,   4,   5, $FC
byte_49C43:
		dc.b    0,   2,   3,   4,   5, $FC
byte_49C49:
		dc.b    7,   2,   3,   4,   5, $FC
byte_49C4F:
		dc.b    5,   8,   6,   7, $FC
byte_49C54:
		dc.b    3, $17, $17, $22, $16, $21, $15, $20, $F4
byte_49C5D:
		dc.b    3, $15, $20, $FC
byte_49C61:
		dc.b    3,  $D,  $F, $11, $FC
byte_49C66:
		dc.b    3, $24, $25, $26, $FC
byte_49C6B:
		dc.b    3, $27, $28, $29, $FC
byte_49C70:
		dc.b    3, $2A, $2B, $2C, $FC
byte_49C75:
		dc.b    3, $2D, $2E, $2F, $FC
byte_49C7A:
		dc.b    1, $1A, $23, $FC
byte_49C7E:
		dc.b  $18,   2
		dc.b  $18,   2
		dc.b  $30,   3
		dc.b  $19,   4
		dc.b  $F4
byte_49C87:
		dc.b    8,   0
		dc.b    8,   0
		dc.b  $1B,   0
		dc.b    9,   0
		dc.b  $1C,   0
		dc.b   $A,   0
		dc.b  $1D,   0
		dc.b   $A,   0
		dc.b  $1D,   0
		dc.b   $A,   0
		dc.b  $1D,   0
		dc.b   $A,   0
		dc.b  $1D,   0
		dc.b   $A,   0
		dc.b  $1D,   0
		dc.b   $A,   0
		dc.b  $1D,   0
		dc.b   $A,   0
		dc.b  $1D,   0
		dc.b   $A,   0
		dc.b  $1D,   0
		dc.b   $A,   0
		dc.b  $1D,   0
		dc.b   $B,   2
		dc.b  $1E,   2
		dc.b   $C,   3
		dc.b  $1F,   3
		dc.b  $F4
byte_49CBE:
		dc.b    8,   0
		dc.b    8,   0
		dc.b  $1B,   0
		dc.b    9,   0
		dc.b  $1C,   0
		dc.b   $A,   0
		dc.b  $1D,   0
		dc.b   $A,   0
		dc.b  $1D,   0
		dc.b   $A,   0
		dc.b  $1D,   0
		dc.b   $A,   0
		dc.b  $1D,   0
		dc.b   $A,   0
		dc.b  $1D,   0
		dc.b   $A,   0
		dc.b  $1D,   0
		dc.b   $A,   0
		dc.b  $1D,   0
		dc.b   $B,   2
		dc.b  $1E,   2
		dc.b   $C,   3
		dc.b  $1F,   3
		dc.b  $F4
byte_49CED:
		dc.b    8,   0
		dc.b    8,   0
		dc.b  $1B,   0
		dc.b    9,   0
		dc.b  $1C,   0
		dc.b   $A,   0
		dc.b  $1D,   0
		dc.b   $A,   0
		dc.b  $1D,   0
		dc.b   $A,   0
		dc.b  $1D,   0
		dc.b   $A,   0
		dc.b  $1D,   0
		dc.b   $A,   0
		dc.b  $1D,   0
		dc.b   $B,   2
		dc.b  $1E,   2
		dc.b   $C,   3
		dc.b  $1F,   3
		dc.b  $F4
byte_49D14:
		dc.b    8,   0
		dc.b    8,   0
		dc.b  $1B,   0
		dc.b    9,   0
		dc.b  $1C,   0
		dc.b   $A,   0
		dc.b  $1D,   0
		dc.b   $A,   0
		dc.b  $1D,   0
		dc.b   $A,   0
		dc.b  $1D,   0
		dc.b   $B,   2
		dc.b  $1E,   2
		dc.b   $C,   3
		dc.b  $1F,   3
		dc.b  $F4
byte_49D33:
		dc.b    8,   0
		dc.b    8,   0
		dc.b  $1B,   0
		dc.b    9,   0
		dc.b  $1C,   0
		dc.b   $A,   0
		dc.b  $1D,   0
		dc.b   $B,   2
		dc.b  $1E,   2
		dc.b   $C,   3
		dc.b  $1F,   3
		dc.b  $F4
byte_49D4A:
		dc.b    7,   0,   0,   1,   2,   3,   4, $F4
		even
Pal_HCZEndBoss:
		binclude "Levels/HCZ/Palettes/End Boss.bin"
		even
; ---------------------------------------------------------------------------

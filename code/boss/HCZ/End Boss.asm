; ---------------------------------------------------------------------------
word_6AE96:
		dc.w   $438,  $838, $3F00, $4100
		dc.w   $738,  $738, $4000, $4050
word_6AEA6:
		dc.w      0,  $3B8, $44E0, $4640
		dc.w   $2B8,  $2B8, $4540, $4590
; ---------------------------------------------------------------------------

Obj_HCZEndBoss:
		lea	word_6AE96(pc),a1
		cmpi.b	#2,(Player_1+character_id).w
		bne.s	+ ;loc_6AEC6
		lea	word_6AEA6(pc),a1

+ ;loc_6AEC6:
		jsr	(Check_CameraInRange).l
		move.b	#mus_EndBoss,$26(a0)
		jsr	(sub_85D6A).l
		move.l	#loc_6AEFE,(a0)
		move.l	#loc_6AF04,$34(a0)
		moveq	#$6C,d0
		jsr	(Load_PLC).l
		move.w	#0,(Normal_palette+$1E).w
		lea	Pal_HCZEndBoss(pc),a1
		jmp	(PalLoad_Line1).l
; ---------------------------------------------------------------------------

loc_6AEFE:
		jmp	(loc_85CA4).l
; ---------------------------------------------------------------------------

loc_6AF04:
		move.l	#loc_6AF0C,(a0)

locret_6AF0A:
		rts
; ---------------------------------------------------------------------------

loc_6AF0C:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_6AF24(pc,d0.w),d1
		jsr	off_6AF24(pc,d1.w)
		bsr.w	sub_6BBC4
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------
off_6AF24:
		dc.w loc_6AF32-off_6AF24
		dc.w loc_6AF74-off_6AF24
		dc.w loc_6AFB6-off_6AF24
		dc.w loc_6AF74-off_6AF24
		dc.w loc_6AF74-off_6AF24
		dc.w loc_6AFB6-off_6AF24
		dc.w loc_6B064-off_6AF24
; ---------------------------------------------------------------------------

loc_6AF32:
		lea	ObjDat_HCZEndBoss(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.b	#8,collision_property(a0)
		move.w	#$80,y_vel(a0)
		move.w	#$EF,$2E(a0)
		move.l	#loc_6AF80,$34(a0)
		lea	(ChildObjDat_6BDEC).l,a2
		jsr	(CreateChild1_Normal).l
		bne.s	+ ;loc_6AF6A
		move.b	#5,subtype(a1)

+ ;loc_6AF6A:
		lea	ChildObjDat_6BD8A(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_6AF74:
		jsr	(MoveSprite2).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_6AF80:
		move.b	#4,routine(a0)
		move.w	y_pos(a0),$3A(a0)
		move.w	#-$100,$44(a0)
		move.w	#$9F,$30(a0)
		move.w	#$3F,$2E(a0)
		move.l	#loc_6AFC8,$34(a0)
		lea	(PLC_Explosion).l,a1
		jsr	(Load_PLC_Raw).l
		jmp	Swing_Setup1(pc)
; ---------------------------------------------------------------------------

loc_6AFB6:
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_6AFC8:
		bset	#3,$38(a0)
		cmpi.b	#2,(Player_1+character_id).w
		beq.s	+ ;loc_6AFF2
		move.b	#6,routine(a0)
		move.w	#$80,y_vel(a0)
		move.w	#$9F,$2E(a0)
		move.l	#loc_6B008,$34(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_6AFF2:
		move.b	#$A,routine(a0)
		move.w	#$1FF,$2E(a0)
		move.l	#loc_6B03A,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_6B008:
		move.w	#-$100,y_vel(a0)
		move.w	#$4F,$2E(a0)
		move.l	#loc_6B01E,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_6B01E:
		move.b	#$A,routine(a0)
		move.w	#$FF,$2E(a0)
		move.w	$3A(a0),y_pos(a0)
		move.l	#loc_6B03A,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_6B03A:
		move.b	#$C,routine(a0)
		bclr	#3,$38(a0)
		move.w	$44(a0),x_vel(a0)
		move.w	#$BF,$2E(a0)
		move.l	#loc_6B08E,$34(a0)
		move.b	#8,$39(a0)
		jmp	Swing_Setup1(pc)
; ---------------------------------------------------------------------------

loc_6B064:
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		jsr	(Obj_Wait).l
		subq.w	#1,$30(a0)
		bpl.s	locret_6B08C
		neg.w	x_vel(a0)
		bchg	#0,render_flags(a0)
		move.w	#$13F,$30(a0)

locret_6B08C:
		rts
; ---------------------------------------------------------------------------

loc_6B08E:
		move.w	#$5F,$2E(a0)
		subq.b	#1,$39(a0)
		bmi.s	+ ;loc_6B0A2
		bset	#1,$38(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_6B0A2:
		move.w	x_vel(a0),$44(a0)
		clr.w	x_vel(a0)
		bra.w	loc_6AFC8
; ---------------------------------------------------------------------------

loc_6B0B0:
		move.l	#loc_6B0CC,(a0)
		bset	#4,$38(a0)
		move.l	#loc_6B0E8,$34(a0)
		moveq	#$C,d0
		jmp	(Set_IndexedVelocity).l
; ---------------------------------------------------------------------------

loc_6B0CC:
		jsr	(MoveSprite).l
		jsr	(Obj_Wait).l
		btst	#0,(V_int_run_count+3).w
		beq.w	locret_6AF0A
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_6B0E8:
		move.l	#loc_6B154,(a0)
		bclr	#7,render_flags(a0)
		st	(_unkFAA8).w
		clr.b	(Boss_flag).w
		move.w	(_unkFAB4).w,d0
		addi.w	#$180,d0
		move.w	d0,(Camera_stored_max_X_pos).w
		lea	(Child6_IncLevX).l,a2
		jsr	(CreateChild6_Simple).l
		cmpi.b	#2,(Player_1+character_id).w
		beq.s	+ ;loc_6B138
		jsr	(AllocateObject).l
		bne.s	locret_6B136
		move.l	#Obj_EggCapsule,(a1)
		move.w	#$4250,x_pos(a1)
		move.w	#$7E0,y_pos(a1)

locret_6B136:
		rts
; ---------------------------------------------------------------------------

+ ;loc_6B138:
		jsr	(AllocateObject).l
		bne.s	locret_6B152
		move.l	#Obj_EggCapsule,(a1)
		move.w	#$4760,x_pos(a1)
		move.w	#$360,y_pos(a1)

locret_6B152:
		rts
; ---------------------------------------------------------------------------

loc_6B154:
		move.w	(Camera_X_pos).w,(Camera_min_X_pos).w
		tst.b	(_unkFAA8).w
		bne.w	locret_6AF0A
		clr.w	(Ctrl_1_logical).w
		clr.w	(Ctrl_2_logical).w
		st	(Ctrl_1_locked).w
		st	(Ctrl_2_locked).w
		move.b	#$80,(Player_1+object_control).w
		jsr	(Restore_PlayerControl).l
		lea	(Player_2).w,a1
		jsr	(Restore_PlayerControl2).l
		jsr	(Restore_LevelMusic).l
		jsr	(AllocateObject).l
		bne.s	+ ;loc_6B19C
		move.l	#loc_6B7BC,(a1)

+ ;loc_6B19C:
		move.w	#0,(Camera_min_Y_pos).w
		jmp	(Go_Delete_Sprite_2).l
; ---------------------------------------------------------------------------

loc_6B1A8:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_6B1C4(pc,d0.w),d1
		jsr	off_6B1C4(pc,d1.w)
		jsr	(Refresh_ChildPosition).l
		moveq	#0,d0
		jmp	(Child_DrawTouch_Sprite2_FlickerMove).l
; ---------------------------------------------------------------------------
off_6B1C4:
		dc.w loc_6B1CE-off_6B1C4
		dc.w loc_6B1D8-off_6B1C4
		dc.w loc_6B204-off_6B1C4
		dc.w loc_6B22A-off_6B1C4
		dc.w loc_6B25C-off_6B1C4
; ---------------------------------------------------------------------------

loc_6B1CE:
		lea	word_6BD32(pc),a1
		jmp	(SetUp_ObjAttributes3).l
; ---------------------------------------------------------------------------

loc_6B1D8:
		movea.w	parent3(a0),a1
		btst	#3,$38(a1)
		bne.s	+ ;loc_6B1E6
		rts
; ---------------------------------------------------------------------------

+ ;loc_6B1E6:
		move.b	#4,routine(a0)
		move.b	#$A6,collision_flags(a0)
		move.l	#byte_6BDF4,$30(a0)
		move.l	#loc_6B212,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_6B204:
		moveq	#signextendB(sfx_FanBig),d0
		jsr	(Play_SFX_Continuous).l
		jmp	(Animate_RawGetFaster).l
; ---------------------------------------------------------------------------

loc_6B212:
		move.b	#6,routine(a0)
		move.l	#byte_6BDFB,$30(a0)
		lea	ChildObjDat_6BDBA(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_6B22A:
		jsr	(Animate_Raw).l
		movea.w	parent3(a0),a1
		btst	#3,$38(a1)
		beq.s	+ ;loc_6B244
		moveq	#signextendB(sfx_FanBig),d0
		jmp	(Play_SFX_Continuous).l
; ---------------------------------------------------------------------------

+ ;loc_6B244:
		move.b	#8,routine(a0)
		move.l	#byte_6BE01,$30(a0)
		move.l	#loc_6B262,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_6B25C:
		jmp	(Animate_RawGetSlower).l
; ---------------------------------------------------------------------------

loc_6B262:
		move.b	#2,routine(a0)
		clr.b	collision_flags(a0)
		rts
; ---------------------------------------------------------------------------

loc_6B26E:
		move.w	x_pos(a0),-(sp)
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_6B29E(pc,d0.w),d1
		jsr	off_6B29E(pc,d1.w)
		move.w	#$1F,d1
		move.w	#$C,d2
		move.w	#$C,d3
		move.w	(sp)+,d4
		jsr	(SolidObjectTop).l
		bsr.w	sub_6BC42
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
off_6B29E:
		dc.w loc_6B2AA-off_6B29E
		dc.w loc_6B2F2-off_6B29E
		dc.w loc_6B31E-off_6B29E
		dc.w loc_6B336-off_6B29E
		dc.w loc_6B31E-off_6B29E
		dc.w loc_6B394-off_6B29E
; ---------------------------------------------------------------------------

loc_6B2AA:
		lea	word_6BD3E(pc),a1
		jsr	(SetUp_ObjAttributes2).l
		move.w	(Water_level).w,d0
		subq.w	#8,d0
		move.w	d0,y_pos(a0)
		move.w	d0,$3A(a0)
		move.l	#byte_6BE0C,$30(a0)
		move.l	#loc_6B2F8,$34(a0)
		lea	ChildObjDat_6BDCA(pc),a2
		jsr	(CreateChild1_Normal).l
		lea	ChildObjDat_6BDE6(pc),a2
		jsr	(CreateChild6_Simple).l
		movea.w	parent3(a0),a1
		move.w	parent3(a1),$44(a0)
		rts
; ---------------------------------------------------------------------------

loc_6B2F2:
		jmp	(Animate_Raw).l
; ---------------------------------------------------------------------------

loc_6B2F8:
		move.b	#4,routine(a0)
		move.l	#byte_6BE15,$30(a0)
		move.w	#-$100,y_vel(a0)
		move.l	#loc_6B32E,$34(a0)
		lea	ChildObjDat_6BDC2(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_6B31E:
		jsr	(MoveSprite2).l
		jsr	(Animate_Raw).l
		bra.w	sub_6BC8A
; ---------------------------------------------------------------------------

loc_6B32E:
		move.b	#6,routine(a0)
		rts
; ---------------------------------------------------------------------------

loc_6B336:
		jsr	(Animate_Raw).l
		movea.w	$44(a0),a1
		btst	#3,$38(a1)
		beq.s	+ ;loc_6B34A
		rts
; ---------------------------------------------------------------------------

+ ;loc_6B34A:
		move.b	#8,routine(a0)
		bset	#3,$38(a0)
		move.w	#$80,y_vel(a0)
		move.l	#loc_6B37A,$34(a0)
		move.w	#$80,x_vel(a0)
		tst.w	x_vel(a1)
		bpl.s	locret_6B374
		neg.w	x_vel(a0)

locret_6B374:
		rts
; ---------------------------------------------------------------------------
		bra.w	sub_6BC8A
; ---------------------------------------------------------------------------

loc_6B37A:
		move.l	#loc_6B394,(a0)
		move.w	#$F,$2E(a0)
		clr.w	x_vel(a0)
		move.l	#loc_6B3BC,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_6B394:
		move.w	#$1F,d1
		move.w	#$C,d2
		move.w	#$C,d3
		move.w	x_pos(a0),d4
		jsr	(SolidObjectTop).l
		jsr	(Animate_Raw).l
		jsr	(Obj_Wait).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_6B3BC:
		jsr	(Displace_PlayerOffObject).l
		jmp	(Go_Delete_Sprite_2).l
; ---------------------------------------------------------------------------

loc_6B3C8:
		jsr	(MoveSprite2).l
		jsr	(Animate_Raw).l
		bsr.w	sub_6BC8A
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_6B3DE:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_6B3F6(pc,d0.w),d1
		jsr	off_6B3F6(pc,d1.w)
		bsr.w	sub_6BC70
		jmp	(Child_Draw_Sprite2).l
; ---------------------------------------------------------------------------
off_6B3F6:
		dc.w loc_6B3FC-off_6B3F6
		dc.w loc_6B410-off_6B3F6
		dc.w loc_6B440-off_6B3F6
; ---------------------------------------------------------------------------

loc_6B3FC:
		lea	word_6BD46(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#byte_6BE19,$30(a0)
		rts
; ---------------------------------------------------------------------------

loc_6B410:
		bsr.w	sub_6B9E2
		bsr.w	sub_6B9AC
		bsr.w	sub_6B916
		jsr	(Animate_Raw).l
		movea.w	parent3(a0),a1
		btst	#3,$38(a1)
		bne.s	+ ;loc_6B430
		rts
; ---------------------------------------------------------------------------

+ ;loc_6B430:
		move.b	#4,routine(a0)
		move.w	x_vel(a1),x_vel(a0)
		bra.w	loc_6BB1E
; ---------------------------------------------------------------------------

loc_6B440:
		bsr.w	sub_6B916
		move.w	x_vel(a1),x_vel(a0)
		jsr	(MoveSprite2).l
		jmp	(Animate_Raw).l
; ---------------------------------------------------------------------------

loc_6B456:
		lea	word_6BD4C(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#loc_6B47A,(a0)
		move.l	#byte_6BE32,$30(a0)

loc_6B46E:
		move.w	(Water_level).w,d0
		subq.w	#4,d0
		move.w	d0,y_pos(a0)
		rts
; ---------------------------------------------------------------------------

loc_6B47A:
		jsr	(Animate_Raw).l
		moveq	#0,d0
		move.b	subtype(a0),d0
		move.w	word_6B49E(pc,d0.w),d0
		movea.w	parent3(a0),a1
		move.w	x_pos(a1),d1
		add.w	d0,d1
		move.w	d1,x_pos(a0)
		jmp	(Child_Draw_Sprite2).l
; ---------------------------------------------------------------------------
word_6B49E:
		dc.w     -4,     4
; ---------------------------------------------------------------------------

loc_6B4A2:
		lea	word_6BD52(pc),a1
		jsr	(SetUp_ObjAttributes2).l
		move.l	#AnimateRaw_DrawTouch,(a0)
		move.l	#byte_6BE36,$30(a0)
		move.l	#Go_Delete_Sprite,$34(a0)
		bra.s	loc_6B46E
; ---------------------------------------------------------------------------

loc_6B4C4:
		lea	ObjDat3_6BD5A(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#Obj_Wait,(a0)
		move.l	#loc_6B4F2,$34(a0)
		bsr.w	sub_6B96C
		tst.b	subtype(a0)
		bne.w	locret_6AF0A
		lea	ChildObjDat_6BDCA(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_6B4F2:
		move.l	#loc_6B502,(a0)
		move.l	#Go_Delete_Sprite_2,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_6B502:
		bsr.w	sub_6BB40
		jmp	(AnimateRaw_DrawTouch).l
; ---------------------------------------------------------------------------

loc_6B50C:
		lea	ObjDat3_6BD72(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_6B56C,(a0)
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
		move.l	off_6B55C(pc,d0.w),$30(a0)
		move.w	#$1F,$2E(a0)
		move.l	#loc_6B586,$34(a0)
		rts
; ---------------------------------------------------------------------------
off_6B55C:
		dc.l byte_6AE46
		dc.l byte_6AE4A
		dc.l byte_6AE4E
		dc.l byte_6AE52
; ---------------------------------------------------------------------------

loc_6B56C:
		movea.w	parent3(a0),a3
		bsr.w	sub_6BB9A
		jsr	(Animate_Raw).l
		jsr	(Obj_Wait).l
		jmp	(Child_Draw_Sprite2).l
; ---------------------------------------------------------------------------

loc_6B586:
		move.l	#loc_6B598,(a0)
		movea.l	$30(a0),a1
		move.b	1(a1),mapping_frame(a0)
		rts
; ---------------------------------------------------------------------------

loc_6B598:
		movea.w	parent3(a0),a3
		btst	#3,$38(a3)
		bne.s	+ ;loc_6B5AE
		bsr.w	sub_6BB9A
		jmp	(Child_Draw_Sprite2).l
; ---------------------------------------------------------------------------

+ ;loc_6B5AE:
		move.l	#loc_6B56C,(a0)
		move.w	#$1F,$2E(a0)
		move.l	#Go_Delete_Sprite,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_6B5C4:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_6B5D8(pc,d0.w),d1
		jsr	off_6B5D8(pc,d1.w)
		jmp	(Child_DrawTouch_Sprite).l
; ---------------------------------------------------------------------------
off_6B5D8:
		dc.w loc_6B5E6-off_6B5D8
		dc.w loc_6B600-off_6B5D8
		dc.w loc_6B644-off_6B5D8
		dc.w loc_6B678-off_6B5D8
		dc.w loc_6B6E6-off_6B5D8
		dc.w loc_6B70E-off_6B5D8
		dc.w loc_6B734-off_6B5D8
; ---------------------------------------------------------------------------

loc_6B5E6:
		lea	word_6BD38(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.b	#8,y_radius(a0)
		bsr.w	sub_6B8F0
		jmp	(Refresh_ChildPositionAdjusted).l
; ---------------------------------------------------------------------------

loc_6B600:
		jsr	(Refresh_ChildPositionAdjusted).l
		movea.w	parent3(a0),a1
		btst	#1,$38(a1)
		bne.s	+ ;loc_6B614
		rts
; ---------------------------------------------------------------------------

+ ;loc_6B614:
		move.b	#4,routine(a0)
		tst.b	subtype(a0)
		beq.s	+ ;loc_6B622
		rts
; ---------------------------------------------------------------------------

+ ;loc_6B622:
		move.b	#6,routine(a0)
		move.w	#3,$2E(a0)
		move.l	#loc_6B6BA,$34(a0)
		move.b	#1,$40(a0)
		move.b	#0,$41(a0)
		rts
; ---------------------------------------------------------------------------

loc_6B644:
		jsr	(Refresh_ChildPositionAdjusted).l
		movea.w	parent3(a0),a1
		btst	#1,$38(a1)
		beq.s	+ ;loc_6B658
		rts
; ---------------------------------------------------------------------------

+ ;loc_6B658:
		move.b	#6,routine(a0)
		subq.b	#2,subtype(a0)
		move.w	#7,$2E(a0)
		move.l	#loc_6B694,$34(a0)
		bsr.w	sub_6B8F0
		bra.w	loc_6B904
; ---------------------------------------------------------------------------

loc_6B678:
		move.b	$40(a0),d0
		add.b	d0,$42(a0)
		move.b	$41(a0),d0
		add.b	d0,$43(a0)
		jsr	(Refresh_ChildPositionAdjusted).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_6B694:
		move.b	#2,routine(a0)
		tst.b	subtype(a0)
		bne.s	locret_6B6B8
		lea	ChildObjDat_6BDAA(pc),a2
		jsr	(CreateChild7_Normal2).l
		bne.s	locret_6B6B8
		move.w	parent3(a0),parent3(a1)
		move.b	#4,subtype(a1)

locret_6B6B8:
		rts
; ---------------------------------------------------------------------------

loc_6B6BA:
		move.b	#8,routine(a0)
		move.l	#loc_6B71C,$34(a0)
		move.w	#$100,x_vel(a0)
		movea.w	parent3(a0),a1
		bclr	#1,$38(a1)
		btst	#0,render_flags(a1)
		beq.s	locret_6B6E4
		neg.w	x_vel(a0)

locret_6B6E4:
		rts
; ---------------------------------------------------------------------------

loc_6B6E6:
		move.w	y_pos(a0),d0
		cmp.w	(Water_level).w,d0
		bhs.s	+ ;loc_6B6FE
		jsr	(MoveSprite_LightGravity).l
		jsr	(ObjHitFloor_DoRoutine).l
		rts
; ---------------------------------------------------------------------------

+ ;loc_6B6FE:
		move.b	#$A,routine(a0)
		lea	ChildObjDat_6BDD8(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_6B70E:
		jsr	(MoveSprite_LightGravity).l
		jsr	(ObjHitFloor_DoRoutine).l
		rts
; ---------------------------------------------------------------------------

loc_6B71C:
		move.b	#$C,routine(a0)
		move.l	#byte_6BE07,$30(a0)
		move.l	#loc_6B73A,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_6B734:
		jmp	(Animate_RawGetFaster).l
; ---------------------------------------------------------------------------

loc_6B73A:
		lea	ChildObjDat_6BDE0(pc),a2
		jsr	(CreateChild6_Simple).l
		moveq	#signextendB(sfx_MissileExplode),d0
		jsr	(Play_SFX).l
		lea	ChildObjDat_6BDB2(pc),a2
		jsr	(CreateChild1_Normal).l
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

loc_6B75C:
		lea	word_6BD2C(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#loc_6B76E,(a0)
		rts
; ---------------------------------------------------------------------------

loc_6B76E:
		jsr	(Refresh_ChildPositionAdjusted).l
		moveq	#0,d0
		jmp	(Child_Draw_Sprite2_FlickerMove).l
; ---------------------------------------------------------------------------

loc_6B77C:
		lea	ObjDat3_6BD66(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_6B7A2,(a0)
		move.l	#byte_6BF02,$30(a0)
		move.l	#Go_Delete_Sprite,$34(a0)
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------

loc_6B7A2:
		jsr	(Animate_Raw).l
		cmpi.b	#3,mapping_frame(a0)
		bhs.s	+ ;loc_6B7B6
		jsr	(Add_SpriteToCollisionResponseList).l

+ ;loc_6B7B6:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_6B7BC:
		lea	(ArtKosM_HCZGeyserVert).l,a1
		move.w	#tiles_to_bytes($36B),d2
		jsr	(Queue_Kos_Module).l
		move.l	#loc_6B7D2,(a0)

loc_6B7D2:
		move.l	#loc_6B7EC,(a0)
		move.w	#$5F,$2E(a0)
		move.l	#loc_6B804,$34(a0)
		st	(Screen_shake_flag).w
		rts
; ---------------------------------------------------------------------------

loc_6B7EC:
		move.b	(V_int_run_count+3).w,d0
		andi.b	#7,d0
		bne.s	+ ;loc_6B7FE
		moveq	#signextendB(sfx_Rumble2),d0
		jsr	(Play_SFX).l

+ ;loc_6B7FE:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_6B804:
		jsr	(AllocateObject).l
		bne.s	+ ;loc_6B81C
		move.l	#loc_6B824,(a1)
		st	subtype(a1)
		move.w	#4,$2E(a1)

+ ;loc_6B81C:
		lea	loc_6B832(pc),a1
		move.l	a1,(a0)
		jmp	(a1)
; ---------------------------------------------------------------------------

loc_6B824:
		subq.w	#1,$2E(a0)
		bpl.w	locret_6AF0A
		move.l	#loc_6B832,(a0)

loc_6B832:
		lea	ObjDat3_6BD7E(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_6B882,(a0)
		tst.b	subtype(a0)
		bne.s	+ ;loc_6B860
		st	(Palette_cycle_counters+$00).w
		st	(Screen_shake_flag).w
		moveq	#signextendB(sfx_Geyser),d0
		jsr	(Play_SFX).l
		lea	(Player_1).w,a1
		bra.w	++ ;loc_6B864
; ---------------------------------------------------------------------------

+ ;loc_6B860:
		lea	(Player_2).w,a1

+ ;loc_6B864:
		move.w	a1,$44(a0)
		move.w	x_pos(a1),d0
		move.w	d0,x_pos(a0)
		move.w	(Camera_Y_pos).w,d1
		addi.w	#$130,d1
		move.w	d1,y_pos(a0)
		jmp	(loc_6BCB2).l
; ---------------------------------------------------------------------------

loc_6B882:
		movea.w	$44(a0),a1
		move.w	y_pos(a0),d0
		subq.w	#6,d0
		move.w	d0,y_pos(a0)
		subi.w	#$60,d0
		cmp.w	y_pos(a1),d0
		bhs.s	loc_6B8B2
		move.b	#$81,object_control(a1)
		move.b	#$1A,anim(a1)
		move.l	#loc_6B8C8,(a0)
		move.w	#$5F,$2E(a0)

loc_6B8B2:
		tst.b	subtype(a0)
		bne.s	loc_6B8C2
		move.l	a0,-(sp)
		jsr	(AnPal_HCZ1).l
		movea.l	(sp)+,a0

loc_6B8C2:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_6B8C8:
		movea.w	$44(a0),a1
		subq.w	#6,y_pos(a0)
		subq.w	#6,y_pos(a1)
		tst.b	subtype(a0)
		bne.s	loc_6B8C2
		subq.w	#1,$2E(a0)
		bpl.s	loc_6B8B2
		move.w	#$200,d0
		jsr	(StartNewLevel).l
		jmp	(Delete_Current_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_6B8F0:
		moveq	#0,d0
		move.b	subtype(a0),d0
		move.w	word_6B8FE(pc,d0.w),priority(a0)
		rts
; End of function sub_6B8F0

; ---------------------------------------------------------------------------
word_6B8FE:
		dc.w   $280
		dc.w   $200
		dc.w   $180
; ---------------------------------------------------------------------------

loc_6B904:
		moveq	#0,d0
		move.b	subtype(a0),d0
		move.w	word_6B912(pc,d0.w),$40(a0)
		rts
; ---------------------------------------------------------------------------
word_6B912:
		dc.w   $101
		dc.w   $100

; =============== S U B R O U T I N E =======================================


sub_6B916:
		movea.w	parent3(a0),a1
		moveq	#0,d0
		move.b	$39(a1),d0
		cmp.b	$39(a0),d0
		beq.s	locret_6B946
		move.b	d0,$39(a0)
		move.b	byte_6B948+1(pc,d0.w),d1
		ext.w	d1
		move.w	(Water_level).w,d2
		add.w	d1,d2
		move.w	d2,y_pos(a0)
		lsl.w	#2,d0
		move.l	off_6B954(pc,d0.w),$30(a0)
		clr.b	anim_frame_timer(a0)

locret_6B946:
		rts
; End of function sub_6B916

; ---------------------------------------------------------------------------
byte_6B948:
		dc.b   -8
		dc.b   -8
		dc.b -$10
		dc.b -$18
		dc.b -$20
		dc.b -$28
		dc.b -$28
		dc.b    0
		dc.b    0
		dc.b    6
		dc.b -$42
		dc.b  $19
		even
off_6B954:
		dc.l byte_6BE19
		dc.l byte_6BE1E
		dc.l byte_6BE23
		dc.l byte_6BE28
		dc.l byte_6BE2D
		dc.l byte_6BE2D

; =============== S U B R O U T I N E =======================================


sub_6B96C:
		moveq	#0,d0
		move.b	subtype(a0),d0
		move.w	d0,$2E(a0)
		move.w	word_6B98E(pc,d0.w),d1
		move.w	(Water_level).w,d2
		add.w	d1,d2
		move.w	d2,y_pos(a0)
		add.w	d0,d0
		move.l	off_6B998(pc,d0.w),$30(a0)
		rts
; End of function sub_6B96C

; ---------------------------------------------------------------------------
word_6B98E:
		dc.w     -8
		dc.w   -$18
		dc.w   -$28
		dc.w   -$38
		dc.w   -$48
off_6B998:
		dc.l byte_6BE3F
		dc.l byte_6BE76
		dc.l byte_6BEA5
		dc.l byte_6BECC
		dc.l byte_6BEEB

; =============== S U B R O U T I N E =======================================


sub_6B9AC:
		move.w	x_pos(a0),d0
		move.w	(Water_level).w,d1
		addq.w	#8,d1
		move.l	#$20000,d2
		lea	(Player_1).w,a1
		bsr.w	sub_6B9C8
		lea	(Player_2).w,a1
; End of function sub_6B9AC


; =============== S U B R O U T I N E =======================================


sub_6B9C8:
		tst.b	object_control(a1)
		bne.s	locret_6B9E0
		cmp.w	y_pos(a1),d1
		bhs.s	locret_6B9E0
		cmp.w	x_pos(a1),d0
		bhs.s	+ ;loc_6B9DC
		neg.l	d2

+ ;loc_6B9DC:
		add.l	d2,x_pos(a1)

locret_6B9E0:
		rts
; End of function sub_6B9C8


; =============== S U B R O U T I N E =======================================


sub_6B9E2:
		movea.w	parent3(a0),a1
		moveq	#0,d0
		move.b	$39(a1),d0
		lsl.w	#2,d0
		lea	word_6BAC2(pc),a1
		lea	(a1,d0.w),a1
		moveq	#$42,d4
		lea	(Player_1).w,a2
		bsr.w	sub_6BA06
		moveq	#$43,d4
		lea	(Player_2).w,a2
; End of function sub_6B9E2


; =============== S U B R O U T I N E =======================================


sub_6BA06:
		movea.w	parent3(a0),a3
		btst	#7,status(a3)
		bne.w	sub_6BB02
		cmpi.b	#6,routine(a2)
		bhs.w	loc_6BAB2
		tst.b	invulnerability_timer(a2)
		bne.w	loc_6BAB2
		tst.b	object_control(a2)
		beq.s	+ ;loc_6BA32
		tst.b	(a0,d4.w)
		bne.s	++ ;loc_6BA6C

+ ;loc_6BA32:
		move.w	y_pos(a0),d0
		move.w	y_pos(a2),d2
		add.w	(a1),d0
		cmp.w	d0,d2
		blo.w	locret_6BB00
		add.w	2(a1),d0
		cmp.w	d0,d2
		bhs.w	locret_6BB00
		move.w	x_pos(a0),d0
		move.w	x_pos(a2),d2
		sub.w	d2,d0
		addi.w	#$10,d0
		cmpi.w	#$20,d0
		bhs.w	locret_6BB00
		tst.b	object_control(a2)
		bne.s	+ ;loc_6BA6C
		bsr.w	sub_6BADA

+ ;loc_6BA6C:
		move.w	y_pos(a0),d0
		move.w	y_pos(a2),d2
		add.w	(a1)+,d0
		cmp.w	d0,d2
		blo.w	sub_6BB02
		move.w	x_pos(a2),d0
		move.w	x_vel(a2),d1
		move.w	#$80,d2
		sub.w	x_pos(a0),d0
		cmpi.w	#-$12,d0
		ble.s	sub_6BB02
		cmpi.w	#$12,d0
		bge.s	sub_6BB02
		tst.w	d0
		bmi.s	+ ;loc_6BA9E
		neg.w	d2

+ ;loc_6BA9E:
		add.w	d2,d1
		move.w	d1,x_vel(a2)
		ext.l	d1
		lsl.l	#8,d1
		add.l	d1,x_pos(a2)
		subq.w	#2,y_pos(a2)
		rts
; ---------------------------------------------------------------------------

loc_6BAB2:
		jsr	(Displace_PlayerOffObject).l
		clr.b	(a0,d4.w)
		clr.b	object_control(a2)
		rts
; End of function sub_6BA06

; ---------------------------------------------------------------------------
word_6BAC2:
		dc.w   -$18,   $48
		dc.w   -$20,   $58
		dc.w   -$28,   $68
		dc.w   -$30,   $78
		dc.w   -$38,   $88
		dc.w   -$48,   $88

; =============== S U B R O U T I N E =======================================


sub_6BADA:
		st	(a0,d4.w)
		bset	#Status_InAir,status(a2)
		move.b	#1,object_control(a2)
		move.b	#$18,anim(a2)
		clr.b	spin_dash_flag(a2)
		clr.w	x_vel(a2)
		clr.w	y_vel(a2)
		clr.w	ground_vel(a2)

locret_6BB00:
		rts
; End of function sub_6BADA


; =============== S U B R O U T I N E =======================================


sub_6BB02:
		clr.b	(a0,d4.w)
		bset	#Status_InAir,status(a2)
		clr.b	object_control(a2)
		move.b	#2,anim(a2)
		move.w	#-$200,y_vel(a2)
		rts
; End of function sub_6BB02

; ---------------------------------------------------------------------------

loc_6BB1E:
		tst.b	$42(a0)
		beq.s	+ ;loc_6BB2E
		clr.b	$42(a0)
		lea	(Player_1).w,a2
		bsr.s	sub_6BB02

+ ;loc_6BB2E:
		tst.b	$43(a0)
		beq.s	locret_6BB3E
		clr.b	$43(a0)
		lea	(Player_2).w,a2
		bsr.s	sub_6BB02

locret_6BB3E:
		rts

; =============== S U B R O U T I N E =======================================


sub_6BB40:
		cmpi.b	#$30,anim_frame(a0)
		bhs.s	locret_6BB90
		lea	word_6BB92(pc),a1
		lea	(Player_1).w,a2
		bsr.w	sub_6BB5C
		lea	word_6BB92(pc),a1
		lea	(Player_2).w,a2
; End of function sub_6BB40


; =============== S U B R O U T I N E =======================================


sub_6BB5C:
		tst.b	object_control(a2)
		bne.s	locret_6BB90
		move.w	x_pos(a0),d0
		move.w	x_pos(a2),d1
		add.w	(a1)+,d0
		cmp.w	d0,d1
		blo.s	locret_6BB90
		add.w	(a1)+,d0
		cmp.w	d0,d1
		bhs.s	locret_6BB90
		move.w	y_pos(a0),d0
		move.w	y_pos(a2),d1
		add.w	(a1)+,d0
		cmp.w	d0,d1
		blo.s	locret_6BB90
		add.w	(a1)+,d0
		cmp.w	d0,d1
		bhs.s	locret_6BB90
		move.w	#-$800,y_vel(a2)

locret_6BB90:
		rts
; End of function sub_6BB5C

; ---------------------------------------------------------------------------
word_6BB92:
		dc.w    -$C,   $18
		dc.w   -$38,   $40

; =============== S U B R O U T I N E =======================================


sub_6BB9A:
		movea.w	parent3(a0),a1
		move.w	x_pos(a0),d0
		move.w	x_vel(a0),d1
		move.w	#$80,d2
		sub.w	x_pos(a1),d0
		tst.w	d0
		bmi.s	+ ;loc_6BBB4
		neg.w	d2

+ ;loc_6BBB4:
		add.w	d2,d1
		move.w	d1,x_vel(a0)
		ext.l	d1
		lsl.l	#8,d1
		add.l	d1,x_pos(a0)
		rts
; End of function sub_6BB9A


; =============== S U B R O U T I N E =======================================


sub_6BBC4:
		tst.l	(a0)
		beq.s	locret_6BC1A
		tst.b	collision_flags(a0)
		bne.s	locret_6BC1A
		tst.b	collision_property(a0)
		beq.s	loc_6BC1C
		tst.b	$20(a0)
		bne.s	+ ;loc_6BBE8
		move.b	#$20,$20(a0)
		moveq	#signextendB(sfx_BossHit),d0
		jsr	(Play_SFX).l

+ ;loc_6BBE8:
		bset	#6,status(a0)
		moveq	#0,d0
		btst	#0,$20(a0)
		bne.s	+ ;loc_6BBFA
		addq.w	#2*3,d0

+ ;loc_6BBFA:
		lea	word_6BC30(pc),a1
		lea	word_6BC36(pc,d0.w),a2
		jsr	(CopyWordData_3).l
		subq.b	#1,$20(a0)
		bne.s	locret_6BC1A
		bclr	#6,status(a0)
		move.b	$25(a0),collision_flags(a0)

locret_6BC1A:
		rts
; ---------------------------------------------------------------------------

loc_6BC1C:
		move.l	#Wait_FadeToLevelMusic,(a0)
		move.l	#loc_6B0B0,$34(a0)
		jmp	(BossDefeated_StopTimer).l
; End of function sub_6BBC4

; ---------------------------------------------------------------------------
word_6BC30:
		dc.w Normal_palette_line_2+$14, Normal_palette_line_2+$16, Normal_palette_line_2+$1C
word_6BC36:
		dc.w      6,   $20,  $624
		dc.w   $EEE,  $EEE,  $EEE

; =============== S U B R O U T I N E =======================================


sub_6BC42:
		movea.w	$44(a0),a1
		btst	#7,status(a1)
		beq.s	locret_6BC6E
		bset	#7,status(a0)
		move.l	#loc_6B3C8,(a0)
		move.w	#$100,y_vel(a0)
		move.l	#Go_Delete_Sprite_2,$34(a0)
		jsr	(Displace_PlayerOffObject).l

locret_6BC6E:
		rts
; End of function sub_6BC42


; =============== S U B R O U T I N E =======================================


sub_6BC70:
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		beq.s	locret_6BC88
		bset	#7,status(a0)
		move.b	#4,routine(a0)

locret_6BC88:
		rts
; End of function sub_6BC70


; =============== S U B R O U T I N E =======================================


sub_6BC8A:
		move.w	$3A(a0),d0
		sub.w	y_pos(a0),d0
		bcs.s	+ ;loc_6BCAC
		andi.w	#$F0,d0
		lsr.w	#4,d0
		move.b	d0,$39(a0)
		tst.w	y_vel(a0)
		bpl.s	locret_6BCAA
		cmpi.b	#5,d0
		bhs.s	+ ;loc_6BCAC

locret_6BCAA:
		rts
; ---------------------------------------------------------------------------

+ ;loc_6BCAC:
		movea.l	$34(a0),a2
		jmp	(a2)
; End of function sub_6BC8A

; ---------------------------------------------------------------------------

loc_6BCB2:
		lea	(byte_303EA).l,a3
		move.w	x_pos(a0),d2
		move.w	y_pos(a0),d3
		subi.w	#$80,d3
		moveq	#8-1,d1

- ;loc_6BCC6:
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	locret_6BD1E
		move.l	#loc_3011A,(a1)
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
		dbf	d1,- ;loc_6BCC6

locret_6BD1E:
		rts
; ---------------------------------------------------------------------------
ObjDat_HCZEndBoss:
		dc.l Map_HCZEndBoss
		dc.w make_art_tile($320,1,1)
		dc.w   $100
		dc.b  $2C, $1C,   0,   6
word_6BD2C:
		dc.w   $200
		dc.b   $C,   4,   1,   0
word_6BD32:
		dc.w   $200
		dc.b  $1C,   4,   2,   0
word_6BD38:
		dc.w   $200
		dc.b  $1C,   4,   6,   0
word_6BD3E:
		dc.w make_art_tile($320,0,1)
		dc.w    $80
		dc.b  $14,  $C, $17,   0
word_6BD46:
		dc.w    $80
		dc.b  $14, $30,  $D,   0
word_6BD4C:
		dc.w      0
		dc.b  $10,   4, $1A,   0
word_6BD52:
		dc.w make_art_tile($320,0,1)
		dc.w    $80
		dc.b   $C,   8, $18,   0
ObjDat3_6BD5A:
		dc.l Map_HCZEndBoss
		dc.w make_art_tile($320,0,1)
		dc.w   $100
		dc.b   $C, $10,   8,   0
ObjDat3_6BD66:
		dc.l Map_Explosion
		dc.w make_art_tile(ArtTile_Explosion,0,1)
		dc.w    $80
		dc.b   $C,  $C,   0, $8B
ObjDat3_6BD72:
		dc.l Map_Bubbler
		dc.w make_art_tile($45C,0,1)
		dc.w   $280
		dc.b  $10, $10,   0,   0
ObjDat3_6BD7E:
		dc.l Map_HCZWaterWall
		dc.w make_art_tile($36B,2,0)
		dc.w   $280
		dc.b  $20, $60,   1,   0
ChildObjDat_6BD8A:
		dc.w 5-1
		dc.l loc_6B5C4
		dc.b  $23, $12
		dc.l loc_6B5C4
		dc.b  $1B,  $A
		dc.l loc_6B5C4
		dc.b  $13,  $A
		dc.l loc_6B75C
		dc.b    0, $1C
		dc.l loc_6B1A8
		dc.b    0, $24
ChildObjDat_6BDAA:
		dc.w 1-1
		dc.l loc_6B5C4
		dc.b  $13,  $A
ChildObjDat_6BDB2:
		dc.w 1-1
		dc.l loc_6B77C
		dc.b    0,   0
ChildObjDat_6BDBA:
		dc.w 1-1
		dc.l loc_6B26E
		dc.b    0,   0
ChildObjDat_6BDC2:
		dc.w 1-1
		dc.l loc_6B3DE
		dc.b    0,   0
ChildObjDat_6BDCA:
		dc.w 2-1
		dc.l loc_6B456
		dc.b   -4,   0
		dc.l loc_6B456
		dc.b    4,   0
ChildObjDat_6BDD8:
		dc.w 1-1
		dc.l loc_6B4A2
		dc.b    0,   0
ChildObjDat_6BDE0:
		dc.w 5-1
		dc.l loc_6B4C4
ChildObjDat_6BDE6:
		dc.w $14-1
		dc.l loc_6B50C
ChildObjDat_6BDEC:
		dc.w 1-1
		dc.l Obj_RobotnikShip2
		dc.b    0,  $C
byte_6BDF4:
		dc.b    7,   8,   2,   3,   4,   5, $FC
byte_6BDFB:
		dc.b    0,   2,   3,   4,   5, $FC
byte_6BE01:
		dc.b    7,   2,   3,   4,   5, $FC
byte_6BE07:
		dc.b    5,   8,   6,   7, $FC
byte_6BE0C:
		dc.b    3, $17, $17, $22, $16, $21, $15, $20, $F4
byte_6BE15:
		dc.b    3, $15, $20, $FC
byte_6BE19:
		dc.b    3,  $D,  $F, $11, $FC
byte_6BE1E:
		dc.b    3, $24, $25, $26, $FC
byte_6BE23:
		dc.b    3, $27, $28, $29, $FC
byte_6BE28:
		dc.b    3, $2A, $2B, $2C, $FC
byte_6BE2D:
		dc.b    3, $2D, $2E, $2F, $FC
byte_6BE32:
		dc.b    1, $1A, $23, $FC
byte_6BE36:
		dc.b  $18,   2
		dc.b  $18,   2
		dc.b  $30,   3
		dc.b  $19,   4
		dc.b  $F4
byte_6BE3F:
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
byte_6BE76:
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
byte_6BEA5:
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
byte_6BECC:
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
byte_6BEEB:
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
byte_6BF02:
		dc.b    7,   0,   0,   1,   2,   3,   4, $F4
		even
Pal_HCZEndBoss:
		binclude "Levels/HCZ/Palettes/End Boss.bin"
		even
; ---------------------------------------------------------------------------

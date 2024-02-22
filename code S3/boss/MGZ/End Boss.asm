Obj_MGZ2DrillingRobotnik:
		move.l	#Obj_Wait,(a0)
		move.b	#1,(Boss_flag).w
		move.w	#2*60,$2E(a0)
		move.l	#Obj_MGZ2DrillingRobotnikGo,$34(a0)
		clr.b	subtype(a0)
		moveq	#signextendB(mus_FadeOut),d0
		jsr	(Play_Music).l
		lea	(ArtKosM_MGZEndBoss).l,a1
		move.w	#tiles_to_bytes($33F),d2
		jsr	(Queue_Kos_Module).l
		lea	(ArtKosM_MGZEndBossDebris).l,a1
		move.w	#tiles_to_bytes($45E),d2
		jsr	(Queue_Kos_Module).l
		moveq	#$6D,d0
		jsr	(Load_PLC).l
		lea	Pal_MGZEndBoss(pc),a1
		jmp	(PalLoad_Line1).l
; ---------------------------------------------------------------------------

Obj_MGZ2DrillingRobotnikGo:
		move.l	#Obj_MGZ2DrillingRobotnikStart,(a0)
		moveq	#signextendB(mus_EndBoss),d0		; Play boss music
		jsr	(Play_Music).l

locret_49DD8:
		rts
; ---------------------------------------------------------------------------

Obj_MGZ2DrillingRobotnikStart:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	MGZ2DrillingRobotnik_Index(pc,d0.w),d1
		jsr	MGZ2DrillingRobotnik_Index(pc,d1.w)
		bsr.w	MGZ2_SpecialCheckHit
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------
MGZ2DrillingRobotnik_Index:
		dc.w loc_49E0C-MGZ2DrillingRobotnik_Index
		dc.w loc_49E56-MGZ2DrillingRobotnik_Index
		dc.w loc_49E6E-MGZ2DrillingRobotnik_Index
		dc.w loc_49EC8-MGZ2DrillingRobotnik_Index
		dc.w loc_49EFC-MGZ2DrillingRobotnik_Index
		dc.w loc_49F2E-MGZ2DrillingRobotnik_Index
		dc.w loc_49F6C-MGZ2DrillingRobotnik_Index
		dc.w loc_49F80-MGZ2DrillingRobotnik_Index
		dc.w loc_49F2E-MGZ2DrillingRobotnik_Index
		dc.w loc_49FB4-MGZ2DrillingRobotnik_Index
		dc.w loc_49F2E-MGZ2DrillingRobotnik_Index
		dc.w loc_4A01E-MGZ2DrillingRobotnik_Index
		dc.w loc_4A0EC-MGZ2DrillingRobotnik_Index
; ---------------------------------------------------------------------------

loc_49E0C:
		lea	ObjDat_MGZDrillBoss(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.b	#-1,collision_property(a0)
		move.b	#$30,x_radius(a0)
		move.b	#$24,y_radius(a0)
		move.w	#$C,angle(a0)
		bset	#3,$38(a0)
		move.w	#-$800,y_vel(a0)
		lea	Child1_MakeRoboShip3(pc),a2
		jsr	(CreateChild1_Normal).l
		bne.s	loc_49E4C
		move.b	#9,subtype(a1)

loc_49E4C:
		lea	ChildObjDat_4B3D4(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_49E56:
		tst.l	(Nem_decomp_queue).w
		bne.w	locret_49DD8
		move.b	#4,routine(a0)
		moveq	#signextendB(sfx_Collapse),d0
		jsr	(Play_SFX).l
		rts
; ---------------------------------------------------------------------------

loc_49E6E:
		move.w	y_vel(a0),d0
		addi.w	#$40,d0
		cmpi.w	#$C0,d0
		bge.s	loc_49EB8
		move.w	d0,y_vel(a0)
		btst	#7,$38(a0)
		bne.s	loc_49EB2
		move.w	(Camera_Y_pos).w,d1
		addi.w	#$120,d1
		cmp.w	y_pos(a0),d1
		blo.s	loc_49EB2
		bset	#7,$38(a0)
		lea	ChildObjDat_4B3FE(pc),a2
		btst	#0,render_flags(a0)
		beq.s	loc_49EAC
		lea	ChildObjDat_4B406(pc),a2

loc_49EAC:
		jsr	(CreateChild3_NormalRepeated).l

loc_49EB2:
		jmp	(MoveSprite2).l
; ---------------------------------------------------------------------------

loc_49EB8:
		move.b	#6,routine(a0)
		move.b	#5,$39(a0)
		jmp	Swing_Setup1(pc)
; ---------------------------------------------------------------------------

loc_49EC8:
		btst	#6,status(a0)
		bne.s	loc_49EDC
		jsr	(Swing_UpAndDown_Count).l
		tst.b	$39(a0)
		bpl.s	loc_49EF6

loc_49EDC:
		move.b	#$16,routine(a0)
		move.w	#-$400,y_vel(a0)
		move.w	#$7F,$2E(a0)
		move.l	#loc_4A04A,$34(a0)

loc_49EF6:
		jmp	(MoveSprite2).l
; ---------------------------------------------------------------------------

loc_49EFC:
		subq.w	#1,$2E(a0)
		bpl.s	loc_49F22
		move.w	#3,$2E(a0)
		subq.w	#2,angle(a0)
		bne.s	loc_49F22
		move.b	#$A,routine(a0)
		move.w	#$3F,$2E(a0)
		move.l	#loc_49F40,$34(a0)

loc_49F22:
		jsr	(Swing_UpAndDown).l
		jmp	(MoveSprite2).l
; ---------------------------------------------------------------------------

loc_49F2E:
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_49F40:
		move.l	#loc_49F56,$34(a0)

loc_49F48:
		bset	#3,$38(a0)
		move.w	#$5F,$2E(a0)
		rts
; ---------------------------------------------------------------------------

loc_49F56:
		move.b	#$C,routine(a0)
		move.w	#$1F,$2E(a0)
		move.l	#loc_49F72,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_49F6C:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_49F72:
		move.b	#$E,routine(a0)
		bset	#1,$38(a0)
		rts
; ---------------------------------------------------------------------------

loc_49F80:
		btst	#1,$38(a0)
		beq.s	loc_49F8A
		rts
; ---------------------------------------------------------------------------

loc_49F8A:
		move.b	#$10,routine(a0)
		bclr	#3,$38(a0)
		move.w	#$5F,$2E(a0)
		move.l	#loc_49FA6,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_49FA6:
		move.b	#$12,routine(a0)
		move.w	#3,$2E(a0)
		rts
; ---------------------------------------------------------------------------

loc_49FB4:
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		subq.w	#1,$2E(a0)
		bpl.s	locret_49FD8
		move.w	#3,$2E(a0)
		addq.w	#2,angle(a0)
		cmpi.w	#$C,angle(a0)
		bhs.s	loc_49FDA

locret_49FD8:
		rts
; ---------------------------------------------------------------------------

loc_49FDA:
		move.b	#$14,routine(a0)
		move.w	#$1F,$2E(a0)
		move.l	#loc_49FF0,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_49FF0:
		move.l	#loc_49FFC,$34(a0)
		bra.w	loc_49F48
; ---------------------------------------------------------------------------

loc_49FFC:
		move.b	#$16,routine(a0)
		move.w	#-$400,y_vel(a0)
		move.w	#$7F,$2E(a0)
		move.l	#loc_4A04A,$34(a0)
		bclr	#7,$38(a0)
		rts
; ---------------------------------------------------------------------------

loc_4A01E:
		jsr	(ObjCheckCeilingDist).l
		tst.w	d1
		bmi.s	loc_4A02E
		jmp	(Move_WaitNoFall).l
; ---------------------------------------------------------------------------

loc_4A02E:
		move.b	#$18,routine(a0)
		lea	ChildObjDat_4B3FE(pc),a2
		btst	#0,render_flags(a0)
		beq.s	loc_4A044
		lea	ChildObjDat_4B406(pc),a2

loc_4A044:
		jmp	(CreateChild3_NormalRepeated).l
; ---------------------------------------------------------------------------

loc_4A04A:
		bset	#5,$38(a0)
		clr.b	(Boss_flag).w
		move.l	#Delete_Current_Sprite,(a0)
		jsr	(Restore_LevelMusic).l
		lea	(MGZ_8x8_Primary_KosM).l,a1
		move.w	#tiles_to_bytes($000),d2
		jsr	(Queue_Kos_Module).l
		lea	(MGZ2_8x8_Secondary_KosM).l,a1
		move.w	#tiles_to_bytes($252),d2
		jsr	(Queue_Kos_Module).l
		moveq	#$14,d0
		jsr	(Load_PLC).l
		lea	(ArtKosM_Spiker).l,a1
		move.w	#tiles_to_bytes($530),d2
		jsr	(Queue_Kos_Module).l
		lea	(ArtKosM_Mantis).l,a1
		move.w	#tiles_to_bytes($54F),d2
		jsr	(Queue_Kos_Module).l
		lea	(PLC_MonitorsSpikesSprings).l,a1
		jsr	(Load_PLC_Raw).l
		lea	(Pal_MGZ).l,a1
		jsr	(PalLoad_Line1).l
		btst	#0,render_flags(a0)
		bne.s	loc_4A0DA
		lea	(Child6_IncLevX).l,a2
		move.w	#$6000,(Camera_stored_max_X_pos).w
		jmp	(CreateChild6_Simple).l
; ---------------------------------------------------------------------------

loc_4A0DA:
		lea	(Child6_DecLevX).l,a2
		move.w	#0,(Camera_stored_min_X_pos).w
		jmp	(CreateChild6_Simple).l
; ---------------------------------------------------------------------------

loc_4A0EC:
		jsr	(MoveSprite2).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

Obj_MGZEndBoss:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	MGZEndBoss_Index(pc,d0.w),d1
		jsr	MGZEndBoss_Index(pc,d1.w)
		bsr.w	MGZ2_SpecialCheckHit
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------
MGZEndBoss_Index:
		dc.w loc_4A132-MGZEndBoss_Index
		dc.w loc_4A1C2-MGZEndBoss_Index
		dc.w loc_4A1EC-MGZEndBoss_Index
		dc.w loc_4A210-MGZEndBoss_Index
		dc.w loc_4A230-MGZEndBoss_Index
		dc.w loc_4A1C2-MGZEndBoss_Index
		dc.w loc_4A288-MGZEndBoss_Index
		dc.w loc_4A2C8-MGZEndBoss_Index
		dc.w loc_4A2EA-MGZEndBoss_Index
		dc.w loc_4A1C2-MGZEndBoss_Index
		dc.w loc_4A31C-MGZEndBoss_Index
		dc.w loc_4A1C2-MGZEndBoss_Index
		dc.w loc_4A2EA-MGZEndBoss_Index
		dc.w loc_4A39A-MGZEndBoss_Index
		dc.w loc_4A3D4-MGZEndBoss_Index
		dc.w loc_4A2C8-MGZEndBoss_Index
		dc.w loc_4A2EA-MGZEndBoss_Index
; ---------------------------------------------------------------------------

loc_4A132:
		lea	ObjDat_MGZDrillBoss(pc),a1
		jsr	(SetUp_ObjAttributes).l
		bset	#7,art_tile(a0)
		st	$46(a0)
		move.b	#8,collision_property(a0)
		move.b	#1,(Boss_flag).w
		move.b	#$1C,y_radius(a0)
		move.w	#$C,angle(a0)
		moveq	#signextendB(mus_FadeOut),d0
		jsr	(Play_Music).l
		move.w	#2*60,$2E(a0)
		move.l	#loc_4A1C8,$34(a0)
		lea	(ArtKosM_MGZEndBoss).l,a1
		move.w	#tiles_to_bytes($33F),d2
		jsr	(Queue_Kos_Module).l
		lea	(ArtKosM_MGZEndBossDebris).l,a1
		move.w	#tiles_to_bytes($45E),d2
		jsr	(Queue_Kos_Module).l
		moveq	#$6D,d0
		jsr	(Load_PLC).l
		lea	Pal_MGZEndBoss(pc),a1
		jsr	(PalLoad_Line1).l
		lea	(Child1_MakeRoboShip3).l,a2
		jsr	(CreateChild1_Normal).l
		move.b	#9,subtype(a1)
		lea	ChildObjDat_4B3D4(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_4A1C2:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_4A1C8:
		move.b	#4,routine(a0)
		moveq	#signextendB(mus_EndBoss),d0
		jsr	(Play_Music).l
		move.w	#$80,y_vel(a0)
		move.w	#$BF,$2E(a0)
		move.l	#loc_4A1F8,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_4A1EC:
		jsr	(MoveSprite2).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_4A1F8:
		move.b	#6,routine(a0)
		move.w	#$3F,$2E(a0)
		move.l	#loc_4A222,$34(a0)
		jmp	Swing_Setup1(pc)
; ---------------------------------------------------------------------------

loc_4A210:
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_4A222:
		move.b	#8,routine(a0)
		move.w	#3,$2E(a0)
		rts
; ---------------------------------------------------------------------------

loc_4A230:
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		subq.w	#1,$2E(a0)
		bpl.s	locret_4A254
		move.w	#3,$2E(a0)
		subq.w	#2,angle(a0)
		cmpi.w	#4,angle(a0)
		bls.s	loc_4A256

locret_4A254:
		rts
; ---------------------------------------------------------------------------

loc_4A256:
		move.b	#$A,routine(a0)
		bset	#3,$38(a0)
		move.w	#$5F,$2E(a0)
		move.l	#loc_4A272,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_4A272:
		move.b	#$C,routine(a0)
		move.w	#$400,y_vel(a0)
		move.l	#loc_4A294,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_4A288:
		jsr	(MoveSprite2).l
		jmp	(ObjHitFloor_DoRoutine).l
; ---------------------------------------------------------------------------

loc_4A294:
		move.b	#$E,routine(a0)
		move.w	#$3F,$2E(a0)
		move.l	#loc_4A2CE,$34(a0)
		st	(Events_fg_4).w
		st	(Disable_death_plane).w
		moveq	#signextendB(sfx_BossHitFloor),d0
		jsr	(Play_SFX).l
		jsr	(AllocateObject).l
		bne.s	locret_4A2C6
		move.l	#Obj_MGZ2_BossTransition,(a1)

locret_4A2C6:
		rts
; ---------------------------------------------------------------------------

loc_4A2C8:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_4A2CE:
		move.b	#$10,routine(a0)
		move.w	#-$400,y_vel(a0)
		move.w	#$17,$2E(a0)
		move.l	#loc_4A2F0,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_4A2EA:
		jmp	(Move_WaitNoFall).l
; ---------------------------------------------------------------------------

loc_4A2F0:
		move.b	#$12,routine(a0)
		bclr	#3,$38(a0)
		move.w	#$7F,$2E(a0)
		move.l	#loc_4A30E,$34(a0)
		jmp	Swing_Setup1(pc)
; ---------------------------------------------------------------------------

loc_4A30E:
		move.b	#$14,routine(a0)
		move.w	#3,$2E(a0)
		rts
; ---------------------------------------------------------------------------

loc_4A31C:
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		subq.w	#1,$2E(a0)
		bpl.s	locret_4A33A
		move.w	#3,$2E(a0)
		subq.w	#2,angle(a0)
		beq.s	loc_4A33C

locret_4A33A:
		rts
; ---------------------------------------------------------------------------

loc_4A33C:
		move.b	#$16,routine(a0)
		move.w	#$3F,$2E(a0)
		move.l	#loc_4A352,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_4A352:
		move.b	#$18,routine(a0)
		move.w	#-$400,y_vel(a0)
		move.w	#$1F,$2E(a0)
		move.l	#loc_4A36E,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_4A36E:
		move.b	#$1A,routine(a0)
		clr.b	$46(a0)
		bset	#0,render_flags(a0)
		move.w	#$3E80,x_pos(a0)
		move.w	#$700,y_pos(a0)
		move.w	#-$80,x_vel(a0)
		move.b	#6,$3A(a0)
		jmp	Swing_Setup1(pc)
; ---------------------------------------------------------------------------

loc_4A39A:
		jsr	(MoveSprite2).l
		btst	#6,status(a0)
		bne.s	loc_4A3BE
		move.w	(Player_1+x_pos).w,d0
		cmp.w	x_pos(a0),d0
		bhs.s	loc_4A3BE
		jsr	(Swing_UpAndDown).l
		jmp	(MoveSprite2).l
; ---------------------------------------------------------------------------

loc_4A3BE:
		move.b	#$1C,routine(a0)
		move.w	#$200,x_vel(a0)
		move.l	#loc_4A3EA,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_4A3D4:
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		cmpi.w	#$3E00,x_pos(a0)
		blo.w	locret_49DD8

loc_4A3EA:
		move.b	#$1E,routine(a0)
		moveq	#signextendB(sfx_BossZoom),d0
		jsr	(Play_SFX).l
		bclr	#3,$38(a0)
		bclr	#2,$38(a0)
		move.w	#$9F,$2E(a0)
		move.l	#loc_4A41C,$34(a0)
		lea	ChildObjDat_4B44A(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_4A41C:
		move.w	#$1F,$2E(a0)
		move.l	#loc_4A42E,$34(a0)
		bra.w	loc_4B324
; ---------------------------------------------------------------------------

loc_4A42E:
		bset	#3,$38(a0)
		move.w	#$9F,$2E(a0)
		move.l	#loc_4A442,$34(a0)

loc_4A442:
		move.b	#$20,routine(a0)
		move.w	#$FF,$2E(a0)
		move.l	#loc_4A3EA,$34(a0)
		bset	#2,$38(a0)
		rts
; ---------------------------------------------------------------------------

Obj_MGZEndBossKnux:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	MGZEndBossKnux_Index(pc,d0.w),d1
		jsr	MGZEndBossKnux_Index(pc,d1.w)
		bsr.w	MGZ2_SpecialCheckHit
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------
MGZEndBossKnux_Index:
		dc.w loc_4A132-MGZEndBossKnux_Index
		dc.w loc_4A488-MGZEndBossKnux_Index
		dc.w loc_4A4C2-MGZEndBossKnux_Index
		dc.w loc_4A4DE-MGZEndBossKnux_Index
		dc.w loc_4A542-MGZEndBossKnux_Index
		dc.w loc_4A520-MGZEndBossKnux_Index
		dc.w loc_4A542-MGZEndBossKnux_Index
		dc.w loc_4A520-MGZEndBossKnux_Index
		dc.w loc_4A542-MGZEndBossKnux_Index
; ---------------------------------------------------------------------------

loc_4A488:
		jsr	(Obj_Wait).l
		move.w	#$3A50,d0
		cmp.w	(Camera_X_pos).w,d0
		bls.s	loc_4A49A
		rts
; ---------------------------------------------------------------------------

loc_4A49A:
		move.b	#4,routine(a0)
		move.w	(Camera_max_X_pos).w,(Camera_stored_max_X_pos).w
		move.w	d0,(Camera_min_X_pos).w
		move.w	d0,(Camera_max_X_pos).w
		move.w	#3*60,$30(a0)
		move.b	#2,subtype(a0)
		bset	#3,$38(a0)
		rts
; ---------------------------------------------------------------------------

loc_4A4C2:
		jsr	(Obj_Wait).l
		subq.w	#1,$30(a0)
		bmi.s	loc_4A4D0
		rts
; ---------------------------------------------------------------------------

loc_4A4D0:
		move.b	#6,routine(a0)
		bset	#1,$38(a0)
		rts
; ---------------------------------------------------------------------------

loc_4A4DE:
		btst	#2,$38(a0)
		bne.s	loc_4A4E8
		rts
; ---------------------------------------------------------------------------

loc_4A4E8:
		move.b	#8,routine(a0)
		move.w	#$1F,$2E(a0)
		move.l	#loc_4A504,$34(a0)
		move.b	#0,subtype(a0)
		rts
; ---------------------------------------------------------------------------

loc_4A504:
		move.b	#$A,routine(a0)
		move.w	#$7F,$2E(a0)
		move.l	#loc_4A52C,$34(a0)
		lea	(_unkFA82).w,a1
		bra.w	loc_4B184
; ---------------------------------------------------------------------------

loc_4A520:
		jsr	(MoveSprite2).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_4A52C:
		move.b	#$C,routine(a0)
		move.w	#$3F,$2E(a0)
		move.l	#loc_4A548,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_4A542:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_4A548:
		move.b	#$E,routine(a0)
		move.w	#$9F,$2E(a0)
		move.l	#loc_4A56A,$34(a0)
		move.b	#2,subtype(a0)
		lea	(_unkFA8A).w,a1
		bra.w	loc_4B184
; ---------------------------------------------------------------------------

loc_4A56A:
		move.b	#$10,routine(a0)
		move.w	#$3AF0,x_pos(a0)
		move.w	#$4C0,y_pos(a0)
		move.w	#(2*60)-1,$2E(a0)
		move.l	#loc_4A4D0,$34(a0)
		bclr	#2,$38(a0)
		rts
; ---------------------------------------------------------------------------

loc_4A592:
		move.l	#Obj_Wait,(a0)
		bclr	#7,render_flags(a0)
		bset	#4,$38(a0)
		moveq	#signextendB(mus_FadeOut),d0
		jsr	(Play_Music).l
		move.w	#$7F,$2E(a0)
		move.l	#loc_4A5CA,$34(a0)
		move.w	#$200,priority(a0)
		lea	ChildObjDat_4B436(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_4A5CA:
		move.l	#loc_4A5D6,(a0)
		jmp	(loc_47396).l
; ---------------------------------------------------------------------------

loc_4A5D6:
		tst.b	(_unkFAA8).w
		bne.w	locret_49DD8
		move.l	#locret_4A5FA,(a0)
		bset	#4,$38(a0)
		jsr	(AllocateObject).l
		bne.s	locret_4A5F8
		move.l	#loc_4AE36,(a1)

locret_4A5F8:
		rts
; ---------------------------------------------------------------------------

locret_4A5FA:
		rts
; ---------------------------------------------------------------------------

loc_4A5FC:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_4A612(pc,d0.w),d1
		jsr	off_4A612(pc,d1.w)
		moveq	#0,d0
		jmp	(Child_Draw_Sprite_FlickerMove).l
; ---------------------------------------------------------------------------
off_4A612:
		dc.w loc_4A616-off_4A612
		dc.w loc_4A63C-off_4A612
; ---------------------------------------------------------------------------

loc_4A616:
		lea	word_4B396(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		movea.w	parent3(a0),a1
		cmpi.l	#Obj_MGZEndBoss,(a1)
		bne.s	loc_4A632
		bclr	#7,art_tile(a0)

loc_4A632:
		lea	ChildObjDat_4B3EE(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_4A63C:
		movea.w	parent3(a0),a1
		btst	#5,$38(a1)
		bne.s	loc_4A696
		cmpi.b	#2,subtype(a1)
		beq.s	loc_4A680
		btst	#1,$38(a1)
		beq.s	loc_4A67A
		bset	#1,$38(a0)
		bne.s	loc_4A680
		lea	ChildObjDat_4B416(pc),a2
		btst	#0,render_flags(a0)
		beq.s	loc_4A670
		lea	ChildObjDat_4B41E(pc),a2

loc_4A670:
		jsr	(CreateChild3_NormalRepeated).l
		bra.w	loc_4A680
; ---------------------------------------------------------------------------

loc_4A67A:
		bclr	#1,$38(a0)

loc_4A680:
		lea	byte_4AEBC(pc),a2
		bsr.w	sub_4AE9A
		lea	byte_4AEF6(pc),a2
		bsr.w	sub_4AEDC
		jmp	(Refresh_ChildPositionAdjusted).l
; ---------------------------------------------------------------------------

loc_4A696:
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

loc_4A69C:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_4A6B2(pc,d0.w),d1
		jsr	off_4A6B2(pc,d1.w)
		moveq	#0,d0
		jmp	(Child_DrawTouch_Sprite_FlickerMove).l
; ---------------------------------------------------------------------------
off_4A6B2:
		dc.w loc_4A6C6-off_4A6B2
		dc.w loc_4A6E2-off_4A6B2
		dc.w loc_4A716-off_4A6B2
		dc.w loc_4A7B6-off_4A6B2
		dc.w loc_4A7DA-off_4A6B2
		dc.w loc_4A80C-off_4A6B2
		dc.w loc_4A7DA-off_4A6B2
		dc.w loc_4A80C-off_4A6B2
		dc.w loc_4A7DA-off_4A6B2
		dc.w loc_4A8C2-off_4A6B2
; ---------------------------------------------------------------------------

loc_4A6C6:
		lea	word_4B39C(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.b	#2,routine(a0)
		movea.w	parent3(a0),a1
		move.w	parent3(a1),$44(a0)
		rts
; ---------------------------------------------------------------------------

loc_4A6E2:
		movea.w	$44(a0),a1
		btst	#5,$38(a1)
		bne.s	loc_4A696
		btst	#3,$38(a1)
		bne.s	loc_4A70C
		lea	byte_4AECC(pc),a2
		bsr.w	sub_4AE9A

loc_4A6FE:
		lea	byte_4AF06(pc),a2
		bsr.w	sub_4AEDC
		jmp	(Refresh_ChildPositionAdjusted).l
; ---------------------------------------------------------------------------

loc_4A70C:
		move.b	#4,routine(a0)
		bra.w	loc_4AF6C
; ---------------------------------------------------------------------------

loc_4A716:
		movea.w	$44(a0),a1
		btst	#5,$38(a1)
		bne.w	loc_4A696
		btst	#3,$38(a1)
		beq.s	loc_4A73C
		btst	#1,$38(a1)
		bne.s	loc_4A74E
		jsr	(Animate_RawMultiDelay).l
		bra.s	loc_4A6FE
; ---------------------------------------------------------------------------

loc_4A73C:
		move.b	#6,routine(a0)
		move.l	#loc_4A7C0,$34(a0)
		bra.w	loc_4B01A
; ---------------------------------------------------------------------------

loc_4A74E:
		cmpi.b	#2,subtype(a1)
		beq.s	loc_4A77E
		move.b	#8,routine(a0)
		move.w	#$27,$2E(a0)
		move.l	#loc_4A7EC,$34(a0)
		bsr.w	sub_4AFA6
		bclr	#5,$38(a0)
		lea	ChildObjDat_4B40E(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_4A77E:
		move.b	#8,routine(a0)
		move.w	#$2F,$2E(a0)
		move.l	#loc_4A854,$34(a0)
		bclr	#2,$38(a0)
		bsr.w	sub_4B0A0
		lea	ChildObjDat_4B426(pc),a2
		jsr	(CreateChild1_Normal).l

loc_4A7A6:
		bclr	#5,$38(a0)
		lea	ChildObjDat_4B40E(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_4A7B6:
		jsr	(Animate_RawMultiDelay).l
		bra.w	loc_4A6FE
; ---------------------------------------------------------------------------

loc_4A7C0:
		move.b	#2,routine(a0)
		move.w	#$1F,$2E(a0)
		movea.w	$44(a0),a1
		move.l	#loc_4A7EC,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_4A7DA:
		jsr	(MoveSprite2).l
		jsr	(Animate_RawMultiDelay).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_4A7EC:
		move.b	#$A,routine(a0)
		movea.w	parent3(a0),a1
		bset	#3,$38(a1)
		move.w	#0,$2E(a0)
		move.l	#loc_4A818,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_4A80C:
		jsr	(Animate_RawMultiDelay).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_4A818:
		move.b	#8,routine(a0)
		movea.w	parent3(a0),a1
		bclr	#3,$38(a1)
		neg.w	x_vel(a0)
		move.w	#$27,$2E(a0)
		move.l	#loc_4A83C,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_4A83C:
		move.b	#4,routine(a0)
		movea.w	$44(a0),a1
		bset	#5,$38(a0)
		bclr	#1,$38(a1)
		rts
; ---------------------------------------------------------------------------

loc_4A854:
		move.b	#$E,routine(a0)
		move.w	#$1F,$2E(a0)
		move.l	#loc_4A870,$34(a0)
		bset	#5,$38(a0)
		rts
; ---------------------------------------------------------------------------

loc_4A870:
		move.b	#8,routine(a0)
		move.w	#$2F,$2E(a0)
		move.l	#loc_4A89E,$34(a0)
		bsr.w	sub_4B146
		lea	ChildObjDat_4B426(pc),a2
		jsr	(CreateChild1_Normal).l
		bne.s	loc_4A89A
		move.b	#2,subtype(a1)

loc_4A89A:
		bra.w	loc_4A7A6
; ---------------------------------------------------------------------------

loc_4A89E:
		move.b	#$12,routine(a0)
		ori.b	#$24,$38(a0)
		movea.w	$44(a0),a1
		bset	#2,$38(a1)
		bclr	#1,$38(a1)
		subi.w	#$80,y_pos(a0)
		rts
; ---------------------------------------------------------------------------

loc_4A8C2:
		movea.w	$44(a0),a1
		btst	#2,$38(a1)
		bne.s	locret_4A8D4
		move.b	#4,routine(a0)

locret_4A8D4:
		rts
; ---------------------------------------------------------------------------

loc_4A8D6:
		lea	word_4B390(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#loc_4A8E8,(a0)
		rts
; ---------------------------------------------------------------------------

loc_4A8E8:
		movea.w	parent3(a0),a1
		btst	#5,$38(a1)
		bne.w	loc_4A696
		jsr	(Refresh_ChildPositionAdjusted).l
		jmp	(Child_Draw_Sprite2).l
; ---------------------------------------------------------------------------

loc_4A902:
		lea	word_4B39C(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		clr.b	collision_flags(a0)
		move.w	#$200,priority(a0)
		move.l	#loc_4A950,(a0)
		movea.w	parent3(a0),a1
		move.w	angle(a1),d0
		move.w	byte_4A938(pc,d0.w),child_dx(a0)	; and child_dy
		lsr.w	#1,d0
		move.b	RawAni_4A948(pc,d0.w),mapping_frame(a0)
		jmp	(Refresh_ChildPositionAdjusted).l
; ---------------------------------------------------------------------------
byte_4A938:
		dc.b   $C,   0
		dc.b    3,  -7
		dc.b    0,-$10
		dc.b   -3,  -7
		dc.b  -$C,   0
		dc.b   -3,   7
		dc.b    0, $10
		dc.b   $C,   0
RawAni_4A948:
		dc.b  $1C, $15, $2C, $2A, $2D, $2B, $29, $1C
		even
; ---------------------------------------------------------------------------

loc_4A950:
		jsr	(Refresh_ChildPositionAdjusted).l
		movea.w	parent3(a0),a1
		btst	#5,$38(a1)
		bne.s	loc_4A970
		btst	#4,$38(a1)
		bne.s	loc_4A970
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_4A970:
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

loc_4A976:
		move.l	#loc_4A99C,(a0)
		move.l	#loc_4A9BC,$34(a0)
		movea.w	parent3(a0),a1
		move.w	angle(a1),angle(a0)
		move.b	render_flags(a1),render_flags(a0)
		move.w	#4,$2E(a0)
		rts
; ---------------------------------------------------------------------------

loc_4A99C:
		movea.w	parent3(a0),a1
		btst	#2,$38(a1)
		bne.s	loc_4A9B6
		btst	#4,$38(a1)
		bne.s	loc_4A9B6
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_4A9B6:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_4A9BC:
		move.w	#4,$2E(a0)
		lea	ChildObjDat_4B42E(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_4A9CC:
		lea	word_4B3A2(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#loc_4AA0A,(a0)
		move.w	#$2F,$2E(a0)
		move.l	#Go_Delete_Sprite,$34(a0)
		movea.w	parent3(a0),a1
		movea.w	parent3(a1),a2
		move.w	a2,$44(a0)
		move.w	angle(a1),angle(a0)
		move.w	subtype(a1),subtype(a0)
		bsr.w	sub_4AFA6
		bra.w	loc_4B2A0
; ---------------------------------------------------------------------------

loc_4AA0A:
		movea.w	$44(a0),a1
		btst	#2,$38(a1)
		bne.s	loc_4AA26
		jsr	(MoveSprite2).l
		jsr	(Obj_Wait).l
		bra.w	loc_4B2A0
; ---------------------------------------------------------------------------

loc_4AA26:
		move.l	#loc_4AA3A,(a0)
		movea.w	$44(a0),a1
		move.w	parent3(a1),$44(a0)
		bra.w	loc_4B2A0
; ---------------------------------------------------------------------------

loc_4AA3A:
		movea.w	$44(a0),a1
		movea.w	parent3(a1),a2
		move.w	y_pos(a1),d0
		move.b	subtype(a2),d1
		cmp.b	subtype(a0),d1
		bne.s	loc_4AA82
		tst.b	d1
		bne.s	loc_4AA6E
		moveq	#$10,d1
		btst	#1,(_unkFA83).w
		bne.s	loc_4AA60
		moveq	#$18,d1

loc_4AA60:
		add.w	d1,d0
		cmp.w	y_pos(a0),d0
		bcs.s	loc_4AA82

loc_4AA68:
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

loc_4AA6E:
		moveq	#$14,d1
		btst	#1,(_unkFA8A+1).w
		bne.s	loc_4AA7A
		moveq	#$1C,d1

loc_4AA7A:
		sub.w	d1,d0
		cmp.w	y_pos(a0),d0
		bls.s	loc_4AA68

loc_4AA82:
		bra.w	loc_4B2A0
; ---------------------------------------------------------------------------

loc_4AA86:
		lea	word_4B3A2(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#loc_4AAA2,(a0)
		bsr.w	sub_4AFE0
		move.l	#loc_4AABC,$34(a0)

loc_4AAA2:
		subq.w	#1,$2E(a0)
		bmi.s	loc_4AABC
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		beq.w	locret_49DD8
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

loc_4AABC:
		move.l	#loc_4AAD4,(a0)
		move.b	#$17,mapping_frame(a0)
		clr.w	$2E(a0)
		moveq	#0,d0
		jmp	(Child_DrawTouch_Sprite_FlickerMove).l
; ---------------------------------------------------------------------------

loc_4AAD4:
		movea.w	parent3(a0),a1
		btst	#3,$38(a1)
		bne.s	loc_4AAF6
		move.b	#$16,mapping_frame(a0)
		addq.w	#1,$2E(a0)
		jsr	(MoveSprite2).l
		jmp	(Child_DrawTouch_Sprite_FlickerMove).l
; ---------------------------------------------------------------------------

loc_4AAF6:
		move.l	#loc_4AB04,(a0)
		moveq	#0,d0
		jmp	(Child_DrawTouch_Sprite_FlickerMove).l
; ---------------------------------------------------------------------------

loc_4AB04:
		movea.w	parent3(a0),a1
		btst	#3,$38(a1)
		beq.s	loc_4AB16
		jmp	(Child_DrawTouch_Sprite_FlickerMove).l
; ---------------------------------------------------------------------------

loc_4AB16:
		move.l	#loc_4AB28,(a0)
		neg.w	x_vel(a0)
		moveq	#0,d0
		jmp	(Child_DrawTouch_Sprite_FlickerMove).l
; ---------------------------------------------------------------------------

loc_4AB28:
		subq.w	#1,$2E(a0)
		bmi.s	loc_4AB3A
		jsr	(MoveSprite2).l
		jmp	(Child_DrawTouch_Sprite_FlickerMove).l
; ---------------------------------------------------------------------------

loc_4AB3A:
		move.b	#$17,mapping_frame(a0)
		move.l	#Delete_Current_Sprite,(a0)
		moveq	#0,d0
		jmp	(Child_DrawTouch_Sprite_FlickerMove).l
; ---------------------------------------------------------------------------

loc_4AB4E:
		lea	word_4B3A8(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#loc_4AB8E,(a0)
		move.b	subtype(a0),d0
		subi.b	#4,d0
		move.b	d0,subtype(a0)
		beq.s	loc_4AB84
		move.w	#$380,priority(a0)
		movea.w	parent3(a0),a1
		cmpi.l	#Obj_MGZEndBoss,(a1)
		bne.s	loc_4AB84
		bclr	#7,art_tile(a0)

loc_4AB84:
		lea	ChildObjDat_4B3F6(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_4AB8E:
		movea.w	parent3(a0),a1
		btst	#5,$38(a1)
		bne.s	loc_4ABB0
		lea	byte_4AF44(pc),a2
		bsr.w	sub_4AF16
		jsr	(Refresh_ChildPositionAdjusted).l
		moveq	#$14,d0
		jmp	(Child_Draw_Sprite2_FlickerMove).l
; ---------------------------------------------------------------------------

loc_4ABB0:
		bset	#5,$38(a0)
		move.l	#Delete_Current_Sprite,(a0)
		rts
; ---------------------------------------------------------------------------

loc_4ABBE:
		lea	word_4B3AE(pc),a1
		jsr	(SetUp_ObjAttributes2).l
		move.l	#loc_4ABFA,(a0)
		movea.w	parent3(a0),a1
		move.w	parent3(a1),$44(a0)
		tst.b	subtype(a1)
		beq.s	loc_4ABE4
		move.w	#$300,priority(a0)

loc_4ABE4:
		bclr	#7,art_tile(a0)
		btst	#7,art_tile(a1)
		beq.s	locret_4ABF8
		bset	#7,art_tile(a0)

locret_4ABF8:
		rts
; ---------------------------------------------------------------------------

loc_4ABFA:
		movea.w	parent3(a0),a1
		btst	#5,$38(a1)
		bne.s	loc_4AC30
		lea	byte_4AF58(pc),a2
		bsr.w	sub_4AF16
		jsr	(Refresh_ChildPositionAdjusted).l
		movea.w	$44(a0),a1
		btst	#7,status(a1)
		bne.s	loc_4AC30
		btst	#0,(V_int_run_count+3).w
		bne.w	locret_49DD8
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------

loc_4AC30:
		jmp	(Go_Delete_Sprite_2).l
; ---------------------------------------------------------------------------

loc_4AC36:
		lea	ObjDat3_4B3B6(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_4AC4A,(a0)
		bra.w	loc_4B054
; ---------------------------------------------------------------------------

loc_4AC4A:
		jsr	(MoveSprite_LightGravity).l
		jmp	(Sprite_CheckDeleteXY).l
; ---------------------------------------------------------------------------
		lea	word_4B3C2(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#loc_4AC72,(a0)
		movea.w	parent3(a0),a1
		move.w	parent3(a1),$44(a0)
		rts
; ---------------------------------------------------------------------------

loc_4AC72:
		jsr	(Refresh_ChildPositionAdjusted).l
		movea.w	$44(a0),a1
		btst	#7,status(a1)
		bne.s	loc_4ACA8
		btst	#6,status(a1)
		bne.s	loc_4AC9C
		lea	RawAni_4B584(pc),a1
		jsr	(Animate_RawNoSST).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_4AC9C:
		move.b	#2,mapping_frame(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_4ACA8:
		move.l	#loc_4ACBA,(a0)
		move.b	#3,mapping_frame(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_4ACBA:
		jsr	(Refresh_ChildPositionAdjusted).l
		jmp	(Child_Draw_Sprite2).l
; ---------------------------------------------------------------------------

loc_4ACC6:
		lea	word_4B396(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		jsr	(Refresh_ChildPositionAdjusted).l
		move.l	#Obj_FlickerMove,(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		beq.s	loc_4ACEA
		move.w	#$200,priority(a0)

loc_4ACEA:
		lsr.w	#1,d0
		addi.b	#$2E,d0
		move.b	d0,mapping_frame(a0)
		moveq	#$28,d0
		jmp	(Set_IndexedVelocity).l
; ---------------------------------------------------------------------------

loc_4ACFC:
		lea	ObjDat3_4B3C8(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_4AD68,(a0)
		move.w	#tiles_to_bytes($469),$3A(a0)
		move.w	(Camera_X_pos).w,d0
		addi.w	#$140,d0
		move.w	d0,x_pos(a0)
		move.w	d0,$30(a0)
		move.w	(Camera_Y_pos).w,d0
		addi.w	#$50,d0
		move.w	d0,y_pos(a0)
		move.w	d0,$34(a0)
		move.w	#-$400,x_vel(a0)
		move.b	#4,$40(a0)
		move.l	#ArtScaled_MGZEndBoss,$42(a0)
		move.b	#1,$3E(a0)
		bsr.w	sub_4B2C6
		moveq	#6,d0
		move.w	ground_vel(a0),d1
		beq.s	loc_4AD60
		cmpi.w	#$C,d1
		beq.s	loc_4AD60
		moveq	#$10,d0

loc_4AD60:
		move.w	d0,$2E(a0)
		bra.w	loc_4ADF4
; ---------------------------------------------------------------------------

loc_4AD68:
		movea.w	parent3(a0),a1
		btst	#2,$38(a1)
		bne.w	loc_4AE30
		move.w	x_vel(a0),d0
		add.w	$2E(a0),d0
		cmpi.w	#-$100,d0
		bgt.s	loc_4AD88
		move.w	d0,x_vel(a0)

loc_4AD88:
		move.w	y_vel(a0),d0
		move.w	$3C(a0),d1
		bmi.s	loc_4AD9E
		add.w	d1,d0
		cmpi.w	#$400,d0
		ble.s	loc_4ADA6
		bra.w	loc_4ADAA
; ---------------------------------------------------------------------------

loc_4AD9E:
		add.w	d1,d0
		cmpi.w	#-$400,d0
		blt.s	loc_4ADAA

loc_4ADA6:
		move.w	d0,y_vel(a0)

loc_4ADAA:
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
		move.b	(V_int_run_count+3).w,d0
		andi.b	#3,d0
		bne.s	loc_4AE26
		move.b	$40(a0),d0
		add.b	$3E(a0),d0
		andi.b	#$7F,d0
		cmpi.b	#4,d0
		blo.w	loc_4ADF4
		move.b	d0,$40(a0)

loc_4ADF4:
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
		jsr	(Add_To_DMA_Queue).l

loc_4AE26:
		move.w	$30(a0),d0
		jmp	(Sprite_OnScreen_Test2).l
; ---------------------------------------------------------------------------

loc_4AE30:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_4AE36:
		subq.w	#1,$2E(a0)
		bpl.s	locret_4AE6A
		moveq	#0,d0
		move.b	$39(a0),d0
		move.w	word_4AE7C(pc,d0.w),$2E(a0)
		lsl.w	#4,d0
		lea	(Pal_MGZFadeCNZ).l,a1
		adda.w	d0,a1
		lea	(Normal_palette_line_4).w,a2
		moveq	#bytesToLcnt($20),d1

loc_4AE58:
		move.l	(a1)+,(a2)+
		dbf	d1,loc_4AE58
		addq.b	#2,$39(a0)
		cmpi.b	#$20,$39(a0)
		bhs.s	loc_4AE6C

locret_4AE6A:
		rts
; ---------------------------------------------------------------------------

loc_4AE6C:
		move.w	#$300,d0
		jsr	(StartNewLevel).l
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------
word_4AE7C:
		dc.w     $A
		dc.w     $A
		dc.w     $A
		dc.w     $A
		dc.w     $A
		dc.w     $A
		dc.w     $A
		dc.w     $A
		dc.w     $A
		dc.w    $64
		dc.w      5
		dc.w      5
		dc.w      5
		dc.w      5
		dc.w    $14

; =============== S U B R O U T I N E =======================================


sub_4AE9A:
		movea.w	parent3(a0),a1
		move.w	angle(a1),d0
		move.w	d0,angle(a0)
		lea	(a2,d0.w),a3
		move.b	(a3)+,mapping_frame(a0)
		moveq	#0,d0
		move.b	(a3)+,d0
		beq.s	locret_4AEBA
		lsl.w	#4,d0
		move.w	d0,priority(a0)

locret_4AEBA:
		rts
; End of function sub_4AE9A

; ---------------------------------------------------------------------------
byte_4AEBC:
		dc.b    2, $30
		dc.b    3, $30
		dc.b  $1E, $30
		dc.b  $1F, $30
		dc.b    5, $30
		dc.b    3, $30
		dc.b    4, $30
		dc.b    2, $30
byte_4AECC:
		dc.b    9, $28
		dc.b   $C, $28
		dc.b  $20, $28
		dc.b  $14, $30
		dc.b  $13, $30
		dc.b  $12, $30
		dc.b   $F, $28
		dc.b    9, $28
		even

; =============== S U B R O U T I N E =======================================


sub_4AEDC:
		movea.w	parent3(a0),a1
		move.w	angle(a1),d0
		move.w	d0,angle(a0)
		lea	(a2,d0.w),a3
		move.b	(a3)+,child_dx(a0)
		move.b	(a3)+,child_dy(a0)
		rts
; End of function sub_4AEDC

; ---------------------------------------------------------------------------
byte_4AEF6:
		dc.b -$1C, $10
		dc.b  -$A, $18
		dc.b   $C, $1C
		dc.b  $18, $14
		dc.b  $2C,   8
		dc.b  $20, -$C
		dc.b  $14,-$14
		dc.b -$1C, $10
byte_4AF06:
		dc.b -$17,   0
		dc.b -$11, $16
		dc.b    0, $20
		dc.b  $10,  $F
		dc.b  $11,   0
		dc.b  $10,-$10
		dc.b    0,-$20
		dc.b -$17,   0
		even

; =============== S U B R O U T I N E =======================================


sub_4AF16:
		movea.w	parent3(a0),a1
		moveq	#0,d0
		move.b	$3A(a1),d0
		move.b	d0,$3A(a0)
		add.w	d0,d0
		lea	(a2,d0.w),a3
		move.b	(a3)+,child_dx(a0)
		move.b	(a3)+,child_dy(a0)
		move.b	(a3)+,mapping_frame(a0)
		tst.b	subtype(a0)
		beq.s	locret_4AF42
		subi.b	#$14,child_dx(a0)

locret_4AF42:
		rts
; End of function sub_4AF16

; ---------------------------------------------------------------------------
byte_4AF44:
		dc.b    8, $18,   6
		even
		dc.b   -8, $14,   7
		even
		dc.b  $18, $14,   8
		even
		dc.b  $18,   8, $18
		even
		dc.b  $18,  -4, $23
		even
byte_4AF58:
		dc.b    0, $10, $19
		even
		dc.b   -8,   8, $1A
		even
		dc.b    8,   8, $24
		even
		dc.b  $10,   0, $1B
		even
		dc.b    9,  -7, $25
		even
; ---------------------------------------------------------------------------

loc_4AF6C:
		movea.w	$44(a0),a1
		move.w	angle(a1),d0
		add.w	d0,d0
		move.l	off_4AF86(pc,d0.w),$30(a0)
		clr.b	anim_frame(a0)
		clr.b	anim_frame_timer(a0)
		rts
; ---------------------------------------------------------------------------
off_4AF86:
		dc.l byte_4B45B
		dc.l byte_4B482
		dc.l byte_4B4A9
		dc.l byte_4B4D0
		dc.l byte_4B4D5
		dc.l byte_4B4DA
		dc.l byte_4B4E1
		dc.l byte_4B45B

; =============== S U B R O U T I N E =======================================


sub_4AFA6:
		move.w	angle(a0),d0
		add.w	d0,d0
		move.l	word_4AFC0(pc,d0.w),x_vel(a0)	; and y_vel
		btst	#0,render_flags(a1)
		beq.s	.return
		neg.w	x_vel(a0)

.return:
		rts
; End of function sub_4AFA6

; ---------------------------------------------------------------------------
word_4AFC0:
		dc.w  -$400,     0
		dc.w  -$400,  $400
		dc.w      0,  $400
		dc.w   $400,  $400
		dc.w   $400,     0
		dc.w   $400, -$400
		dc.w      0, -$400
		dc.w  -$400,     0

; =============== S U B R O U T I N E =======================================


sub_4AFE0:
		movea.w	parent3(a0),a1
		move.w	angle(a1),d0
		add.w	d0,d0
		move.l	word_4AFC0(pc,d0.w),x_vel(a0)	; and y_vel
		btst	#0,render_flags(a1)
		beq.s	loc_4AFFC
		neg.w	x_vel(a0)

loc_4AFFC:
		moveq	#0,d0
		move.b	subtype(a0),d0
		move.w	word_4B00A(pc,d0.w),$2E(a0)
		rts
; End of function sub_4AFE0

; ---------------------------------------------------------------------------
word_4B00A:
		dc.w      4,     9,    $E,   $13,   $18,   $1D,   $22,   $27
; ---------------------------------------------------------------------------

loc_4B01A:
		movea.w	$44(a0),a1
		move.w	angle(a1),d0
		add.w	d0,d0
		move.l	off_4B034(pc,d0.w),$30(a0)
		clr.b	anim_frame(a0)
		clr.b	anim_frame_timer(a0)
		rts
; ---------------------------------------------------------------------------
off_4B034:
		dc.l byte_4B508
		dc.l byte_4B527
		dc.l byte_4B546
		dc.l byte_4B4D0
		dc.l byte_4B4D5
		dc.l byte_4B4DA
		dc.l byte_4B565
		dc.l byte_4B508
; ---------------------------------------------------------------------------

loc_4B054:
		moveq	#0,d0
		move.b	subtype(a0),d0
		move.w	d0,d1
		lsr.w	#1,d0
		move.b	RawAni_4B06E(pc,d0.w),mapping_frame(a0)
		add.w	d1,d1
		move.l	word_4B078(pc,d1.w),x_vel(a0)	; and y_vel
		rts
; ---------------------------------------------------------------------------
RawAni_4B06E:
		dc.b    0,   1,   2,   0,   0,   1,   0,   2,   0,   1
		even
word_4B078:
		dc.w  -$400, -$400
		dc.w   $400, -$400
		dc.w   -$80, -$400
		dc.w    $80, -$400
		dc.w  -$300, -$200
		dc.w   $300, -$200
		dc.w  -$200, -$300
		dc.w   $200, -$300
		dc.w   -$80, -$200
		dc.w    $80, -$200

; =============== S U B R O U T I N E =======================================


sub_4B0A0:
		jsr	(Random_Number).l
		andi.w	#$FF,d0
		move.w	d0,d1
		andi.w	#1,d1
		bclr	#0,render_flags(a0)
		subi.w	#$80,d0
		bcc.s	loc_4B0C4
		addq.w	#2,d1
		bset	#0,render_flags(a0)

loc_4B0C4:
		move.w	#$550,d3
		lea	(_unkFA82).w,a2

loc_4B0CC:
		move.w	#$3AF0,d2
		add.w	d0,d2
		add.w	d1,d1
		move.w	word_4B116(pc,d1.w),d4
		move.w	d4,angle(a0)
		move.w	d2,x_pos(a0)
		move.w	d3,y_pos(a0)
		move.w	d1,(a2)+
		move.w	d4,(a2)+
		move.w	d2,(a2)+
		move.w	d3,(a2)+
		add.w	d1,d1
		move.l	off_4B126(pc,d1.w),$30(a0)
		clr.b	anim_frame(a0)
		clr.b	anim_frame_timer(a0)
		add.w	d4,d4
		lea	word_4AFC0(pc),a3
		move.l	(a3,d4.w),x_vel(a0)	; and y_vel
		btst	#0,render_flags(a0)
		beq.s	locret_4B114
		neg.w	x_vel(a0)

locret_4B114:
		rts
; End of function sub_4B0A0

; ---------------------------------------------------------------------------
word_4B116:
		dc.w      4,     2,     4,     2,    $C,    $A,    $C,    $A
off_4B126:
		dc.l byte_4B4C9
		dc.l byte_4B4A2
		dc.l byte_4B4C9
		dc.l byte_4B4A2
		dc.l byte_4B501
		dc.l byte_4B4DA
		dc.l byte_4B501
		dc.l byte_4B4DA

; =============== S U B R O U T I N E =======================================


sub_4B146:
		jsr	(Random_Number).l
		andi.w	#$7F,d0
		move.w	d0,d1
		andi.w	#1,d1
		addq.w	#4,d1
		move.w	(_unkFA82).w,d2
		lsr.w	#1,d2
		bset	#0,render_flags(a0)
		move.b	byte_4B180(pc,d2.w),d3
		beq.s	loc_4B172
		neg.w	d0
		bclr	#0,render_flags(a0)

loc_4B172:
		add.b	d3,d1
		move.w	#$610,d3
		lea	(_unkFA8A).w,a2
		bra.w	loc_4B0CC
; End of function sub_4B146

; ---------------------------------------------------------------------------
byte_4B180:
		dc.b    2,   0,   0,   2
		even
; ---------------------------------------------------------------------------

loc_4B184:
		move.w	(a1)+,d0
		move.w	(a1)+,d1
		move.w	d1,angle(a0)
		move.w	(a1)+,d2
		move.w	(a1)+,d3
		lea	byte_4B1E2(pc,d0.w),a2
		move.b	(a2)+,d4
		ext.w	d4
		add.w	d4,d2
		move.w	d2,x_pos(a0)
		move.b	(a2)+,d4
		ext.w	d4
		add.w	d4,d3
		move.w	d3,y_pos(a0)
		lsr.w	#1,d0
		move.b	byte_4B1F2(pc,d0.w),$3A(a0)
		lsr.w	#1,d0
		move.b	byte_4B1FA(pc,d0.w),d2
		andi.b	#$FC,render_flags(a0)
		or.b	d2,render_flags(a0)
		add.w	d1,d1
		lea	word_4AFC0(pc),a2
		move.l	(a2,d1.w),x_vel(a0)	; and y_vel
		asr	x_vel(a0)
		asr	y_vel(a0)
		btst	#0,render_flags(a0)
		beq.s	locret_4B1E0
		neg.w	x_vel(a0)

locret_4B1E0:
		rts
; ---------------------------------------------------------------------------
byte_4B1E2:
		dc.b  -$C,-$2C
		dc.b  $1A,-$28
		dc.b   $C,-$2C
		dc.b -$1A,-$28
		dc.b  $14, $24
		dc.b  $30, $1C
		dc.b -$14, $24
		dc.b -$30, $1C
byte_4B1F2:
		dc.b    0,   8,   0,   8,   0,   2,   0,   2
byte_4B1FA:
		dc.b    0,   1,   1,   0
		even

; =============== S U B R O U T I N E =======================================


MGZ2_SpecialCheckHit:
		tst.b	collision_flags(a0)
		bne.s	locret_4B262	; If collision is on, don't do anything
		tst.b	collision_property(a0)
		bne.s	loc_4B21C		; If still has a hit point, branch
		tst.b	$46(a0)
		beq.s	loc_4B264		; ONLY kill the boss is $46 isn't set. If it is set, this is an event instance of the object
		move.b	#1,collision_property(a0)
		bclr	#7,status(a0)

loc_4B21C:
		tst.b	$20(a0)
		bne.s	loc_4B230
		move.b	#$20,$20(a0)
		moveq	#signextendB(sfx_BossHit),d0			; Play hit sound
		jsr	(Play_SFX).l

loc_4B230:
		bset	#6,status(a0)
		moveq	#0,d0
		btst	#0,$20(a0)
		bne.s	loc_4B244
		addi.w	#2*3,d0

loc_4B244:
		bsr.w	MGZ2_BossPalAdjust
		subq.b	#1,$20(a0)
		bne.s	locret_4B262
		bclr	#6,status(a0)
		cmpi.b	#0,mapping_frame(a0)
		bne.s	locret_4B262
		move.b	$25(a0),collision_flags(a0)	; Put backup of collision back into $28

locret_4B262:
		rts
; ---------------------------------------------------------------------------

loc_4B264:
		move.l	#Wait_Draw,(a0)
		move.l	#loc_4A592,$34(a0)
		jmp	(BossDefeated_StopTimer).l
; End of function MGZ2_SpecialCheckHit


; =============== S U B R O U T I N E =======================================


MGZ2_BossPalAdjust:
		lea	word_4B28E(pc),a1
		lea	word_4B294(pc,d0.w),a2
	rept 3
		movea.w	(a1)+,a3
		move.w	(a2)+,(a3)+
	endm
		rts
; End of function MGZ2_BossPalAdjust

; ---------------------------------------------------------------------------
word_4B28E:
		dc.w Normal_palette_line_2+$16, Normal_palette_line_2+$1A, Normal_palette_line_2+$1C
word_4B294:
		dc.w    $20,  $866,  $644
		dc.w   $EEE,  $888,  $AAA
; ---------------------------------------------------------------------------

loc_4B2A0:
		movea.w	$44(a0),a1
		movea.w	parent3(a1),a1
		btst	#7,status(a1)
		bne.s	loc_4B2B6
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------

loc_4B2B6:
		jsr	(Random_Number).l
		andi.w	#$3C,d0
		jmp	(loc_5312A).l

; =============== S U B R O U T I N E =======================================


sub_4B2C6:
		movea.w	parent3(a0),a2
		moveq	#0,d0
		move.b	$39(a2),d0
		addq.b	#1,$39(a2)
		andi.b	#7,d0
		move.b	byte_4B302(pc,d0.w),d0
		move.w	d0,ground_vel(a0)
		move.w	d0,$3C(a2)
		lea	word_4B2F2(pc,d0.w),a1
		move.w	(a1)+,y_vel(a0)
		move.w	(a1)+,$3C(a0)
		rts
; End of function sub_4B2C6

; ---------------------------------------------------------------------------
word_4B2F2:
		dc.w  -$200,     8
		dc.w  -$600,   $40
		dc.w   $600,  -$40
		dc.w  -$200,     8
byte_4B302:
		dc.b    0,   8,   4,   0,   0,   4,   0,   8
		even

; =============== S U B R O U T I N E =======================================


sub_4B30A:
		move.w	x_vel(a0),d0
		ext.l	d0
		lsl.l	#8,d0
		add.l	d0,$30(a0)
		move.w	y_vel(a0),d0
		ext.l	d0
		lsl.l	#8,d0
		add.l	d0,$34(a0)
		rts
; End of function sub_4B30A

; ---------------------------------------------------------------------------

loc_4B324:
		move.w	$3C(a0),d0
		lea	word_4B358(pc,d0.w),a2
		move.w	(a2)+,d1
		add.w	(Camera_X_pos).w,d1
		move.w	d1,x_pos(a0)
		move.w	(a2)+,d1
		add.w	(Camera_Y_pos).w,d1
		move.w	d1,y_pos(a0)
		move.l	word_4B368(pc,d0.w),x_vel(a0)	; and y_vel
		lsr.w	#1,d0
		move.w	word_4B378(pc,d0.w),angle(a0)
		lsr.w	#1,d0
		move.b	byte_4B380(pc,d0.w),$3A(a0)
		rts
; ---------------------------------------------------------------------------
word_4B358:
		dc.w   -$40,   $70
		dc.w    $A0,  $120
		dc.w    $A0,  -$50
		dc.w   -$40,   $70
word_4B368:
		dc.w   $200,     0
		dc.w    $80, -$200
		dc.w    $80,  $200
		dc.w   $200,     0
word_4B378:
		dc.w      0,    $C,     4,     0
byte_4B380:
		dc.b    6,   4,   8,   6
		even
ObjDat_MGZDrillBoss:
		dc.l Map_MGZEndBoss
		dc.w make_art_tile($33F,1,0)
		dc.w   $300
		dc.b  $24, $20,   0,  $F
word_4B390:
		dc.w   $380
		dc.b  $10, $10,   1,   0
word_4B396:
		dc.w   $300
		dc.b  $18, $18,   2,   0
word_4B39C:
		dc.w   $280
		dc.b   $C,  $C,   9, $8B
word_4B3A2:
		dc.w   $200
		dc.b    4,   4, $16, $98
word_4B3A8:
		dc.w   $180
		dc.b   $C,  $C,   6,   0
word_4B3AE:
		dc.w make_art_tile($33F,0,0)
		dc.w   $180
		dc.b   $C,  $C, $19, $9A
ObjDat3_4B3B6:
		dc.l Map_MGZEndBossDebris
		dc.w make_art_tile($45E,2,1)
		dc.w   $100
		dc.b  $10, $10,   0,   0
word_4B3C2:
		dc.w   $200
		dc.b  $10,   4,   0,   0
ObjDat3_4B3C8:
		dc.l Map_ScaledArt
		dc.w make_art_tile($469,1,0)
		dc.w   $300
		dc.b  $20, $20,   0,   0
ChildObjDat_4B3D4:
		dc.w 4-1
		dc.l loc_4A8D6
		dc.b -$14,  $F
		dc.l loc_4A5FC
		dc.b -$1C, $10
		dc.l loc_4AB4E
		dc.b    8, $18
		dc.l loc_4AB4E
		dc.b  -$C, $18
ChildObjDat_4B3EE:
		dc.w 1-1
		dc.l loc_4A69C
		dc.b -$17,   0
ChildObjDat_4B3F6:
		dc.w 1-1
		dc.l loc_4ABBE
		dc.b    0, $10
ChildObjDat_4B3FE:
		dc.w $A-1
		dc.l loc_4AC36
		dc.b  $18,-$40
ChildObjDat_4B406:
		dc.w $A-1
		dc.l loc_4AC36
		dc.b -$18,-$40
ChildObjDat_4B40E:
		dc.w 1-1
		dc.l loc_4A902
		dc.b   $C,   0
ChildObjDat_4B416:
		dc.w 8-1
		dc.l loc_4AA86
		dc.b -$10,   0
ChildObjDat_4B41E:
		dc.w 8-1
		dc.l loc_4AA86
		dc.b  $10,   0
ChildObjDat_4B426:
		dc.w 1-1
		dc.l loc_4A976
		dc.b    0,   0
ChildObjDat_4B42E:
		dc.w 1-1
		dc.l loc_4A9CC
		dc.b    0,   0
ChildObjDat_4B436:
		dc.w 3-1
		dc.l loc_4ACC6
		dc.b   $C,-$14
		dc.l loc_4ACC6
		dc.b -$10,   8
		dc.l loc_4ACC6
		dc.b  $14,   8
ChildObjDat_4B44A:
		dc.w 1-1
		dc.l loc_4ACFC
		dc.b    0,   0
byte_4B450:	; unused
		dc.b    0,   5
		dc.b    1,   5
		dc.b    2,   5
		dc.b    3,   5
		dc.b  $FC
byte_4B45B:
		dc.b    9,   7
		dc.b   $A,   7
		dc.b   $B,   7
		dc.b    9,   6
		dc.b   $A,   6
		dc.b   $B,   6
		dc.b    9,   5
		dc.b   $A,   5
		dc.b   $B,   5
		dc.b    9,   4
		dc.b   $A,   4
		dc.b   $B,   4
		dc.b    9,   3
		dc.b   $A,   3
		dc.b   $B,   3
		dc.b  $F8, $20
byte_4B47B:	; unused
		dc.b    9,   2
		dc.b   $A,   2
		dc.b   $B,   2
		dc.b  $FC
byte_4B482:
		dc.b   $C,   7
		dc.b   $D,   7
		dc.b   $E,   7
		dc.b   $C,   6
		dc.b   $D,   6
		dc.b   $E,   6
		dc.b   $C,   5
		dc.b   $D,   5
		dc.b   $E,   5
		dc.b   $C,   4
		dc.b   $D,   4
		dc.b   $E,   4
		dc.b   $C,   3
		dc.b   $D,   3
		dc.b   $E,   3
		dc.b  $F8, $20
byte_4B4A2:
		dc.b   $C,   2
		dc.b   $D,   2
		dc.b   $E,   2
		dc.b  $FC
byte_4B4A9:
		dc.b  $20,   7
		dc.b  $21,   7
		dc.b  $22,   7
		dc.b  $20,   6
		dc.b  $21,   6
		dc.b  $22,   6
		dc.b  $20,   5
		dc.b  $21,   5
		dc.b  $22,   5
		dc.b  $20,   4
		dc.b  $21,   4
		dc.b  $22,   4
		dc.b  $20,   3
		dc.b  $21,   3
		dc.b  $22,   3
		dc.b  $F8, $20
byte_4B4C9:
		dc.b  $20,   2
		dc.b  $21,   2
		dc.b  $22,   2
		dc.b  $FC
byte_4B4D0:
		dc.b  $14, $7F
		dc.b  $14, $7F
		dc.b  $FC
byte_4B4D5:
		dc.b  $13, $7F
		dc.b  $13, $7F
		dc.b  $FC
byte_4B4DA:
		dc.b  $26,   2
		dc.b  $27,   2
		dc.b  $28,   2
		dc.b  $FC
byte_4B4E1:
		dc.b   $F,   7
		dc.b  $10,   7
		dc.b  $11,   7
		dc.b   $F,   6
		dc.b  $10,   6
		dc.b  $11,   6
		dc.b   $F,   5
		dc.b  $10,   5
		dc.b  $11,   5
		dc.b   $F,   4
		dc.b  $10,   4
		dc.b  $11,   4
		dc.b   $F,   3
		dc.b  $10,   3
		dc.b  $11,   3
		dc.b  $F8, $20
byte_4B501:
		dc.b   $F,   2
		dc.b  $10,   2
		dc.b  $11,   2
		dc.b  $FC
byte_4B508:
		dc.b    9,   3
		dc.b   $A,   3
		dc.b   $B,   3
		dc.b    9,   4
		dc.b   $A,   4
		dc.b   $B,   4
		dc.b    9,   5
		dc.b   $A,   5
		dc.b   $B,   5
		dc.b    9,   6
		dc.b   $A,   6
		dc.b   $B,   6
		dc.b    9,   7
		dc.b   $A,   7
		dc.b   $B,   7
		dc.b  $F4
byte_4B527:
		dc.b   $C,   3
		dc.b   $D,   3
		dc.b   $E,   3
		dc.b   $C,   4
		dc.b   $D,   4
		dc.b   $E,   4
		dc.b   $C,   5
		dc.b   $D,   5
		dc.b   $E,   5
		dc.b   $C,   6
		dc.b   $D,   6
		dc.b   $E,   6
		dc.b   $C,   7
		dc.b   $D,   7
		dc.b   $E,   7
		dc.b  $F4
byte_4B546:
		dc.b  $20,   3
		dc.b  $21,   3
		dc.b  $22,   3
		dc.b  $20,   4
		dc.b  $21,   4
		dc.b  $22,   4
		dc.b  $20,   5
		dc.b  $21,   5
		dc.b  $22,   5
		dc.b  $20,   6
		dc.b  $21,   6
		dc.b  $22,   6
		dc.b  $20,   7
		dc.b  $21,   7
		dc.b  $22,   7
		dc.b  $F4
byte_4B565:
		dc.b   $F,   3
		dc.b  $10,   3
		dc.b  $11,   3
		dc.b   $F,   4
		dc.b  $10,   4
		dc.b  $11,   4
		dc.b   $F,   5
		dc.b  $10,   5
		dc.b  $11,   5
		dc.b   $F,   6
		dc.b  $10,   6
		dc.b  $11,   6
		dc.b   $F,   7
		dc.b  $10,   7
		dc.b  $11,   7
		dc.b  $F4
RawAni_4B584:
		dc.b    5,   0,   1, $FC
		even
Pal_MGZEndBoss:
		binclude "Levels/MGZ/Palettes/End Boss.bin"
		even
; ---------------------------------------------------------------------------

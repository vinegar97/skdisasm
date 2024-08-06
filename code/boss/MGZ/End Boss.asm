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
		move.b	#mus_EndBoss,(Current_music+1).w

locret_6BF96:
		rts
; ---------------------------------------------------------------------------

Obj_MGZ2DrillingRobotnikStart:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	.Index(pc,d0.w),d1
		jsr	.Index(pc,d1.w)
		bsr.w	MGZ2_SpecialCheckHit
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------
.Index:
		dc.w loc_6BFCA-.Index
		dc.w loc_6C014-.Index
		dc.w loc_6C024-.Index
		dc.w loc_6C07E-.Index
		dc.w loc_6C0B2-.Index
		dc.w loc_6C0E4-.Index
		dc.w loc_6C122-.Index
		dc.w loc_6C136-.Index
		dc.w loc_6C0E4-.Index
		dc.w loc_6C16A-.Index
		dc.w loc_6C0E4-.Index
		dc.w loc_6C1D4-.Index
		dc.w loc_6C2B2-.Index
; ---------------------------------------------------------------------------

loc_6BFCA:
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
		bne.s	loc_6C00A
		move.b	#9,subtype(a1)

loc_6C00A:
		lea	ChildObjDat_6D7C0(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_6C014:
		move.b	#4,routine(a0)
		moveq	#signextendB(sfx_Collapse),d0
		jsr	(Play_SFX).l
		rts
; ---------------------------------------------------------------------------

loc_6C024:
		move.w	y_vel(a0),d0
		addi.w	#$40,d0
		cmpi.w	#$C0,d0
		bge.s	loc_6C06E
		move.w	d0,y_vel(a0)
		btst	#7,$38(a0)
		bne.s	loc_6C068
		move.w	(Camera_Y_pos).w,d1
		addi.w	#$120,d1
		cmp.w	y_pos(a0),d1
		blo.s	loc_6C068
		bset	#7,$38(a0)
		lea	ChildObjDat_6D7EA(pc),a2
		btst	#0,render_flags(a0)
		beq.s	loc_6C062
		lea	ChildObjDat_6D7F2(pc),a2

loc_6C062:
		jsr	(CreateChild3_NormalRepeated).l

loc_6C068:
		jmp	(MoveSprite2).l
; ---------------------------------------------------------------------------

loc_6C06E:
		move.b	#6,routine(a0)
		move.b	#5,$39(a0)
		jmp	Swing_Setup1(pc)
; ---------------------------------------------------------------------------

loc_6C07E:
		btst	#6,status(a0)
		bne.s	loc_6C092
		jsr	(Swing_UpAndDown_Count).l
		tst.b	$39(a0)
		bpl.s	loc_6C0AC

loc_6C092:
		move.b	#$16,routine(a0)
		move.w	#-$400,y_vel(a0)
		move.w	#$7F,$2E(a0)
		move.l	#loc_6C200,$34(a0)

loc_6C0AC:
		jmp	(MoveSprite2).l
; ---------------------------------------------------------------------------

loc_6C0B2:
		subq.w	#1,$2E(a0)
		bpl.s	loc_6C0D8
		move.w	#3,$2E(a0)
		subq.w	#2,angle(a0)
		bne.s	loc_6C0D8
		move.b	#$A,routine(a0)
		move.w	#$3F,$2E(a0)
		move.l	#loc_6C0F6,$34(a0)

loc_6C0D8:
		jsr	(Swing_UpAndDown).l
		jmp	(MoveSprite2).l
; ---------------------------------------------------------------------------

loc_6C0E4:
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_6C0F6:
		move.l	#loc_6C10C,$34(a0)

loc_6C0FE:
		bset	#3,$38(a0)
		move.w	#$5F,$2E(a0)
		rts
; ---------------------------------------------------------------------------

loc_6C10C:
		move.b	#$C,routine(a0)
		move.w	#$1F,$2E(a0)
		move.l	#loc_6C128,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_6C122:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_6C128:
		move.b	#$E,routine(a0)
		bset	#1,$38(a0)
		rts
; ---------------------------------------------------------------------------

loc_6C136:
		btst	#1,$38(a0)
		beq.s	loc_6C140
		rts
; ---------------------------------------------------------------------------

loc_6C140:
		move.b	#$10,routine(a0)
		bclr	#3,$38(a0)
		move.w	#$5F,$2E(a0)
		move.l	#loc_6C15C,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_6C15C:
		move.b	#$12,routine(a0)
		move.w	#3,$2E(a0)
		rts
; ---------------------------------------------------------------------------

loc_6C16A:
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		subq.w	#1,$2E(a0)
		bpl.s	locret_6C18E
		move.w	#3,$2E(a0)
		addq.w	#2,angle(a0)
		cmpi.w	#$C,angle(a0)
		bhs.s	loc_6C190

locret_6C18E:
		rts
; ---------------------------------------------------------------------------

loc_6C190:
		move.b	#$14,routine(a0)
		move.w	#$1F,$2E(a0)
		move.l	#loc_6C1A6,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_6C1A6:
		move.l	#loc_6C1B2,$34(a0)
		bra.w	loc_6C0FE
; ---------------------------------------------------------------------------

loc_6C1B2:
		move.b	#$16,routine(a0)
		move.w	#-$400,y_vel(a0)
		move.w	#$7F,$2E(a0)
		move.l	#loc_6C200,$34(a0)
		bclr	#7,$38(a0)
		rts
; ---------------------------------------------------------------------------

loc_6C1D4:
		jsr	(ObjCheckCeilingDist).l
		tst.w	d1
		bmi.s	loc_6C1E4
		jmp	(Move_WaitNoFall).l
; ---------------------------------------------------------------------------

loc_6C1E4:
		move.b	#$18,routine(a0)
		lea	ChildObjDat_6D7EA(pc),a2
		btst	#0,render_flags(a0)
		beq.s	loc_6C1FA
		lea	ChildObjDat_6D7F2(pc),a2

loc_6C1FA:
		jmp	(CreateChild3_NormalRepeated).l
; ---------------------------------------------------------------------------

loc_6C200:
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
		move.w	#$1DF,(Camera_min_Y_pos).w
		st	(Events_fg_2).w
		btst	#0,render_flags(a0)
		bne.s	loc_6C29E
		move.w	#$6000,(Camera_stored_max_X_pos).w
		jsr	(AllocateObject).l
		bne.s	locret_6C29C
		move.l	#Obj_IncLevEndXGradual,(a1)

locret_6C29C:
		rts
; ---------------------------------------------------------------------------

loc_6C29E:
		clr.w	(Camera_stored_min_X_pos).w
		jsr	(AllocateObject).l
		bne.s	locret_6C2B0
		move.l	#Obj_DecLevStartXGradual,(a1)

locret_6C2B0:
		rts
; ---------------------------------------------------------------------------

loc_6C2B2:
		jsr	(MoveSprite2).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_6C2BE:
		move.l	#Obj_Wait,(a0)
		bset	#4,$38(a0)
		move.l	#loc_6C2E2,$34(a0)
		move.w	#$200,priority(a0)
		lea	ChildObjDat_6D822(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_6C2E2:
		move.l	#loc_6C2EE,(a0)
		jmp	(loc_694AA).l
; ---------------------------------------------------------------------------

loc_6C2EE:
		tst.b	(_unkFAA8).w
		bne.w	locret_6BF96
		move.l	#locret_6C318,(a0)
		bset	#4,$38(a0)
		jsr	(Restore_LevelMusic).l
		jsr	(AllocateObject).l
		bne.s	locret_6C316
		move.l	#loc_6D104,(a1)

locret_6C316:
		rts
; ---------------------------------------------------------------------------

locret_6C318:
		rts
; ---------------------------------------------------------------------------

Obj_MGZEndBoss:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	.Index(pc,d0.w),d1
		jsr	.Index(pc,d1.w)
		bsr.w	MGZ2_SpecialCheckHit
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------
.Index:
		dc.w loc_6C354-.Index
		dc.w loc_6C3E6-.Index
		dc.w loc_6C416-.Index
		dc.w loc_6C43A-.Index
		dc.w loc_6C45A-.Index
		dc.w loc_6C3E6-.Index
		dc.w loc_6C4B2-.Index
		dc.w loc_6C4F2-.Index
		dc.w loc_6C514-.Index
		dc.w loc_6C3E6-.Index
		dc.w loc_6C546-.Index
		dc.w loc_6C3E6-.Index
		dc.w loc_6C514-.Index
		dc.w loc_6C5C4-.Index
		dc.w loc_6C5FE-.Index
		dc.w loc_6C4F2-.Index
		dc.w loc_6C514-.Index
; ---------------------------------------------------------------------------

loc_6C354:
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
		move.l	#loc_6C3EC,$34(a0)
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
		bne.s	loc_6C3DC
		move.b	#9,subtype(a1)

loc_6C3DC:
		lea	ChildObjDat_6D7C0(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_6C3E6:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_6C3EC:
		move.b	#4,routine(a0)
		moveq	#signextendB(mus_EndBoss),d0
		jsr	(Play_Music).l
		move.b	#mus_EndBoss,(Current_music+1).w
		move.w	#$80,y_vel(a0)
		move.w	#$BF,$2E(a0)
		move.l	#loc_6C422,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_6C416:
		jsr	(MoveSprite2).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_6C422:
		move.b	#6,routine(a0)
		move.w	#$3F,$2E(a0)
		move.l	#loc_6C44C,$34(a0)
		jmp	Swing_Setup1(pc)
; ---------------------------------------------------------------------------

loc_6C43A:
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_6C44C:
		move.b	#8,routine(a0)
		move.w	#3,$2E(a0)
		rts
; ---------------------------------------------------------------------------

loc_6C45A:
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		subq.w	#1,$2E(a0)
		bpl.s	locret_6C47E
		move.w	#3,$2E(a0)
		subq.w	#2,angle(a0)
		cmpi.w	#4,angle(a0)
		bls.s	loc_6C480

locret_6C47E:
		rts
; ---------------------------------------------------------------------------

loc_6C480:
		move.b	#$A,routine(a0)
		bset	#3,$38(a0)
		move.w	#$5F,$2E(a0)
		move.l	#loc_6C49C,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_6C49C:
		move.b	#$C,routine(a0)
		move.w	#$400,y_vel(a0)
		move.l	#loc_6C4BE,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_6C4B2:
		jsr	(MoveSprite2).l
		jmp	(ObjHitFloor_DoRoutine).l
; ---------------------------------------------------------------------------

loc_6C4BE:
		move.b	#$E,routine(a0)
		move.w	#$3F,$2E(a0)
		move.l	#loc_6C4F8,$34(a0)
		st	(Events_fg_4).w
		st	(Disable_death_plane).w
		moveq	#signextendB(sfx_BossHitFloor),d0
		jsr	(Play_SFX).l
		jsr	(AllocateObject).l
		bne.s	locret_6C4F0
		move.l	#Obj_MGZ2_BossTransition,(a1)

locret_6C4F0:
		rts
; ---------------------------------------------------------------------------

loc_6C4F2:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_6C4F8:
		move.b	#$10,routine(a0)
		move.w	#-$400,y_vel(a0)
		move.w	#$17,$2E(a0)
		move.l	#loc_6C51A,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_6C514:
		jmp	(Move_WaitNoFall).l
; ---------------------------------------------------------------------------

loc_6C51A:
		move.b	#$12,routine(a0)
		bclr	#3,$38(a0)
		move.w	#$7F,$2E(a0)
		move.l	#loc_6C538,$34(a0)
		jmp	Swing_Setup1(pc)
; ---------------------------------------------------------------------------

loc_6C538:
		move.b	#$14,routine(a0)
		move.w	#3,$2E(a0)
		rts
; ---------------------------------------------------------------------------

loc_6C546:
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		subq.w	#1,$2E(a0)
		bpl.s	locret_6C564
		move.w	#3,$2E(a0)
		subq.w	#2,angle(a0)
		beq.s	loc_6C566

locret_6C564:
		rts
; ---------------------------------------------------------------------------

loc_6C566:
		move.b	#$16,routine(a0)
		move.w	#$3F,$2E(a0)
		move.l	#loc_6C57C,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_6C57C:
		move.b	#$18,routine(a0)
		move.w	#-$400,y_vel(a0)
		move.w	#$1F,$2E(a0)
		move.l	#loc_6C598,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_6C598:
		move.b	#$1A,routine(a0)
		clr.b	$46(a0)
		bset	#0,render_flags(a0)
		move.w	#$3E80,x_pos(a0)
		move.w	#$700,y_pos(a0)
		move.w	#-$80,x_vel(a0)
		move.b	#6,$3A(a0)
		jmp	Swing_Setup1(pc)
; ---------------------------------------------------------------------------

loc_6C5C4:
		jsr	(MoveSprite2).l
		btst	#6,status(a0)
		bne.s	loc_6C5E8
		move.w	(Player_1+x_pos).w,d0
		cmp.w	x_pos(a0),d0
		bhs.s	loc_6C5E8
		jsr	(Swing_UpAndDown).l
		jmp	(MoveSprite2).l
; ---------------------------------------------------------------------------

loc_6C5E8:
		move.b	#$1C,routine(a0)
		move.w	#$200,x_vel(a0)
		move.l	#loc_6C614,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_6C5FE:
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		cmpi.w	#$3E00,x_pos(a0)
		blo.w	locret_6BF96

loc_6C614:
		move.b	#$1E,routine(a0)
		moveq	#signextendB(sfx_BossZoom),d0
		jsr	(Play_SFX).l
		bclr	#3,$38(a0)
		bclr	#2,$38(a0)
		move.w	#$9F,$2E(a0)
		move.l	#loc_6C646,$34(a0)
		lea	ChildObjDat_6D836(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_6C646:
		move.w	#$1F,$2E(a0)
		move.l	#loc_6C658,$34(a0)
		bra.w	loc_6D710
; ---------------------------------------------------------------------------

loc_6C658:
		bset	#3,$38(a0)
		move.w	#$9F,$2E(a0)
		move.l	#loc_6C66C,$34(a0)

loc_6C66C:
		move.b	#$20,routine(a0)
		move.w	#$FF,$2E(a0)
		move.l	#loc_6C614,$34(a0)
		bset	#2,$38(a0)
		rts
; ---------------------------------------------------------------------------
word_6C688:
		dc.w      0,  $128, $3C78, $3E78
		dc.w    $28,   $28, $3D78, $3D78
; ---------------------------------------------------------------------------

Obj_MGZEndBossKnux:
		lea	word_6C688(pc),a1
		jsr	(Check_CameraInRange).l
		move.b	#mus_Miniboss,$26(a0)	; different song than other end bosses
		jsr	(sub_85D6A).l
		move.l	#loc_6C6F4,(a0)
		move.l	#loc_6C6FA,$34(a0)
		lea	(ArtKosM_MGZEndBoss).l,a1
		move.w	#tiles_to_bytes($33F),d2
		jsr	(Queue_Kos_Module).l
		lea	(ArtKosM_MGZEndBossDebris).l,a1
		move.w	#tiles_to_bytes($45E),d2
		jsr	(Queue_Kos_Module).l
		moveq	#$6D,d0
		jsr	(Load_PLC).l
		cmpi.b	#2,(Player_1+character_id).w
		lea	Pal_MGZEndBoss(pc),a1
		jmp	(PalLoad_Line1).l
; ---------------------------------------------------------------------------

loc_6C6F4:
		jmp	(loc_85CA4).l
; ---------------------------------------------------------------------------

loc_6C6FA:
		move.l	#loc_6C702,(a0)
		rts
; ---------------------------------------------------------------------------

loc_6C702:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	MGZEndBossKnux_Index(pc,d0.w),d1
		jsr	MGZEndBossKnux_Index(pc,d1.w)
		bsr.w	loc_6D61E
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------
MGZEndBossKnux_Index:
		dc.w loc_6C72A-MGZEndBossKnux_Index
		dc.w loc_6C782-MGZEndBossKnux_Index
		dc.w loc_6C796-MGZEndBossKnux_Index
		dc.w loc_6C814-MGZEndBossKnux_Index
		dc.w loc_6C7D8-MGZEndBossKnux_Index
		dc.w loc_6C814-MGZEndBossKnux_Index
		dc.w loc_6C83C-MGZEndBossKnux_Index
		dc.w loc_6C88A-MGZEndBossKnux_Index
; ---------------------------------------------------------------------------

loc_6C72A:
		lea	ObjDat_MGZDrillBoss(pc),a1
		jsr	(SetUp_ObjAttributes).l
		st	$46(a0)
		move.b	#8,collision_property(a0)
		move.b	#$1C,y_radius(a0)
		move.w	#$C,angle(a0)
		move.b	#2,subtype(a0)
		bset	#3,$38(a0)
		move.w	#$3F,$2E(a0)
		move.l	#loc_6C788,$34(a0)
		lea	(Child1_MakeRoboShip3).l,a2
		jsr	(CreateChild1_Normal).l
		bne.s	loc_6C778
		move.b	#9,subtype(a1)

loc_6C778:
		lea	ChildObjDat_6D7C0(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_6C782:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_6C788:
		move.b	#4,routine(a0)
		bset	#1,$38(a0)
		rts
; ---------------------------------------------------------------------------

loc_6C796:
		btst	#2,$38(a0)
		bne.s	loc_6C7A0
		rts
; ---------------------------------------------------------------------------

loc_6C7A0:
		move.b	#6,routine(a0)
		move.w	#$1F,$2E(a0)
		move.l	#loc_6C7BC,$34(a0)
		move.b	#0,subtype(a0)
		rts
; ---------------------------------------------------------------------------

loc_6C7BC:
		move.b	#8,routine(a0)
		move.w	#$87,$2E(a0)
		move.l	#loc_6C7FE,$34(a0)
		lea	(_unkFA82).w,a1
		bra.w	loc_6D51A
; ---------------------------------------------------------------------------

loc_6C7D8:
		cmpi.w	#$28,$2E(a0)
		bne.s	loc_6C7F2
		moveq	#signextendB(sfx_Collapse),d0
		jsr	(Play_SFX).l
		lea	ChildObjDat_6D83E(pc),a2
		jsr	(CreateChild6_Simple).l

loc_6C7F2:
		jsr	(MoveSprite2).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_6C7FE:
		move.b	#$A,routine(a0)
		move.w	#$3F,$2E(a0)
		move.l	#loc_6C81A,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_6C814:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_6C81A:
		move.b	#$C,routine(a0)
		move.w	#$9F,$2E(a0)
		move.l	#loc_6C862,$34(a0)
		move.b	#2,subtype(a0)
		lea	(_unkFA8A).w,a1
		bra.w	loc_6D51A
; ---------------------------------------------------------------------------

loc_6C83C:
		cmpi.w	#$48,$2E(a0)
		bne.s	loc_6C856
		moveq	#signextendB(sfx_Collapse),d0
		jsr	(Play_SFX).l
		lea	ChildObjDat_6D83E(pc),a2
		jsr	(CreateChild6_Simple).l

loc_6C856:
		jsr	(MoveSprite2).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_6C862:
		move.b	#$E,routine(a0)
		move.w	#$3E18,x_pos(a0)
		move.w	#-$58,y_pos(a0)
		move.w	#(2*60)-1,$2E(a0)
		move.l	#loc_6C788,$34(a0)
		bclr	#2,$38(a0)
		rts
; ---------------------------------------------------------------------------

loc_6C88A:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_6C890:
		move.l	#Obj_Wait,(a0)
		move.w	#$200,priority(a0)
		move.l	#loc_6C8B4,$34(a0)
		bset	#4,$38(a0)
		lea	ChildObjDat_6D822(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_6C8B4:
		move.l	#loc_6C8F4,(a0)
		st	(_unkFAA8).w
		clr.b	(Boss_flag).w
		jsr	(AllocateObject).l
		bne.s	loc_6C8DC
		move.l	#Obj_EggCapsule,(a1)
		move.w	#$3F40,x_pos(a1)
		move.w	#$B0,y_pos(a1)

loc_6C8DC:
		move.w	(_unkFAB4).w,d0
		addi.w	#$118,d0
		move.w	d0,(Camera_stored_max_X_pos).w
		lea	(Child6_IncLevX).l,a2
		jmp	(CreateChild6_Simple).l
; ---------------------------------------------------------------------------

loc_6C8F4:
		move.w	(Camera_X_pos).w,(Camera_min_X_pos).w
		tst.b	(_unkFAA8).w
		bne.w	locret_6BF96
		move.l	#loc_6C932,(a0)
		clr.b	(_unkFAA8).w
		jsr	(Restore_PlayerControl).l
		jsr	(Restore_LevelMusic).l
		clr.w	(Ctrl_1_logical).w
		st	(Ctrl_1_locked).w
		clr.w	$2E(a0)
		move.b	#1,(Scroll_lock).w
		addi.w	#$30,(Camera_max_X_pos).w
		rts
; ---------------------------------------------------------------------------

loc_6C932:
		move.w	(Camera_X_pos).w,d0
		addi.w	#$150,d0
		cmp.w	(Player_1+x_pos).w,d0
		bls.w	loc_6D13C
		jmp	(loc_86334).l
; ---------------------------------------------------------------------------

loc_6C948:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_6C95E(pc,d0.w),d1
		jsr	off_6C95E(pc,d1.w)
		moveq	#0,d0
		jmp	(Child_Draw_Sprite_FlickerMove).l
; ---------------------------------------------------------------------------
off_6C95E:
		dc.w loc_6C962-off_6C95E
		dc.w loc_6C988-off_6C95E
; ---------------------------------------------------------------------------

loc_6C962:
		lea	word_6D782(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		movea.w	parent3(a0),a1
		cmpi.l	#Obj_MGZEndBoss,(a1)
		bne.s	loc_6C97E
		bclr	#7,art_tile(a0)

loc_6C97E:
		lea	ChildObjDat_6D7DA(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_6C988:
		movea.w	parent3(a0),a1
		btst	#5,$38(a1)
		bne.s	loc_6C9E2
		cmpi.b	#2,subtype(a1)
		beq.s	loc_6C9CC
		btst	#1,$38(a1)
		beq.s	loc_6C9C6
		bset	#1,$38(a0)
		bne.s	loc_6C9CC
		lea	ChildObjDat_6D802(pc),a2
		btst	#0,render_flags(a0)
		beq.s	loc_6C9BC
		lea	ChildObjDat_6D80A(pc),a2

loc_6C9BC:
		jsr	(CreateChild3_NormalRepeated).l
		bra.w	loc_6C9CC
; ---------------------------------------------------------------------------

loc_6C9C6:
		bclr	#1,$38(a0)

loc_6C9CC:
		lea	byte_6D24A(pc),a2
		bsr.w	sub_6D228
		lea	byte_6D284(pc),a2
		bsr.w	sub_6D26A
		jmp	(Refresh_ChildPositionAdjusted).l
; ---------------------------------------------------------------------------

loc_6C9E2:
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

loc_6C9E8:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_6C9FE(pc,d0.w),d1
		jsr	off_6C9FE(pc,d1.w)
		moveq	#0,d0
		jmp	(Child_DrawTouch_Sprite_FlickerMove).l
; ---------------------------------------------------------------------------
off_6C9FE:
		dc.w loc_6CA12-off_6C9FE
		dc.w loc_6CA2E-off_6C9FE
		dc.w loc_6CA62-off_6C9FE
		dc.w loc_6CB14-off_6C9FE
		dc.w loc_6CB38-off_6C9FE
		dc.w loc_6CB6A-off_6C9FE
		dc.w loc_6CB38-off_6C9FE
		dc.w loc_6CB6A-off_6C9FE
		dc.w loc_6CB38-off_6C9FE
		dc.w loc_6CC32-off_6C9FE
; ---------------------------------------------------------------------------

loc_6CA12:
		lea	word_6D788(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.b	#2,routine(a0)
		movea.w	parent3(a0),a1
		move.w	parent3(a1),$44(a0)
		rts
; ---------------------------------------------------------------------------

loc_6CA2E:
		movea.w	$44(a0),a1
		btst	#5,$38(a1)
		bne.s	loc_6C9E2
		btst	#3,$38(a1)
		bne.s	loc_6CA58
		lea	byte_6D25A(pc),a2
		bsr.w	sub_6D228

loc_6CA4A:
		lea	byte_6D294(pc),a2
		bsr.w	sub_6D26A
		jmp	(Refresh_ChildPositionAdjusted).l
; ---------------------------------------------------------------------------

loc_6CA58:
		move.b	#4,routine(a0)
		bra.w	loc_6D2FA
; ---------------------------------------------------------------------------

loc_6CA62:
		movea.w	$44(a0),a1
		btst	#5,$38(a1)
		bne.w	loc_6C9E2
		btst	#3,$38(a1)
		beq.s	loc_6CA88
		btst	#1,$38(a1)
		bne.s	loc_6CA9A
		jsr	(Animate_RawMultiDelay).l
		bra.s	loc_6CA4A
; ---------------------------------------------------------------------------

loc_6CA88:
		move.b	#6,routine(a0)
		move.l	#loc_6CB1E,$34(a0)
		bra.w	loc_6D3A8
; ---------------------------------------------------------------------------

loc_6CA9A:
		cmpi.b	#2,subtype(a1)
		beq.s	loc_6CACA
		move.b	#8,routine(a0)
		move.w	#$27,$2E(a0)
		move.l	#loc_6CB4A,$34(a0)
		bsr.w	sub_6D334
		bclr	#5,$38(a0)
		lea	ChildObjDat_6D7FA(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_6CACA:
		move.b	#8,routine(a0)
		move.w	#$37,$2E(a0)
		move.l	#loc_6CBB2,$34(a0)
		bclr	#2,$38(a0)
		bsr.w	sub_6D42E
		lea	ChildObjDat_6D812(pc),a2
		jsr	(CreateChild1_Normal).l
		moveq	#signextendB(sfx_Collapse),d0
		jsr	(Play_SFX).l
		lea	ChildObjDat_6D83E(pc),a2
		jsr	(CreateChild6_Simple).l

loc_6CB04:
		bclr	#5,$38(a0)
		lea	ChildObjDat_6D7FA(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_6CB14:
		jsr	(Animate_RawMultiDelay).l
		bra.w	loc_6CA4A
; ---------------------------------------------------------------------------

loc_6CB1E:
		move.b	#2,routine(a0)
		move.w	#$1F,$2E(a0)
		movea.w	$44(a0),a1
		move.l	#loc_6CB4A,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_6CB38:
		jsr	(MoveSprite2).l
		jsr	(Animate_RawMultiDelay).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_6CB4A:
		move.b	#$A,routine(a0)
		movea.w	parent3(a0),a1
		bset	#3,$38(a1)
		move.w	#0,$2E(a0)
		move.l	#loc_6CB76,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_6CB6A:
		jsr	(Animate_RawMultiDelay).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_6CB76:
		move.b	#8,routine(a0)
		movea.w	parent3(a0),a1
		bclr	#3,$38(a1)
		neg.w	x_vel(a0)
		move.w	#$27,$2E(a0)
		move.l	#loc_6CB9A,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_6CB9A:
		move.b	#4,routine(a0)
		movea.w	$44(a0),a1
		bset	#5,$38(a0)
		bclr	#1,$38(a1)
		rts
; ---------------------------------------------------------------------------

loc_6CBB2:
		move.b	#$E,routine(a0)
		move.w	#$1F,$2E(a0)
		move.l	#loc_6CBCE,$34(a0)
		bset	#5,$38(a0)
		rts
; ---------------------------------------------------------------------------

loc_6CBCE:
		move.b	#8,routine(a0)
		move.w	#$2F,$2E(a0)
		move.l	#loc_6CC0E,$34(a0)
		bsr.w	sub_6D4DC
		lea	ChildObjDat_6D812(pc),a2
		jsr	(CreateChild1_Normal).l
		bne.s	loc_6CBF8
		move.b	#2,subtype(a1)

loc_6CBF8:
		moveq	#signextendB(sfx_Collapse),d0
		jsr	(Play_SFX).l
		lea	ChildObjDat_6D83E(pc),a2
		jsr	(CreateChild6_Simple).l
		bra.w	loc_6CB04
; ---------------------------------------------------------------------------

loc_6CC0E:
		move.b	#$12,routine(a0)
		ori.b	#$24,$38(a0)
		movea.w	$44(a0),a1
		bset	#2,$38(a1)
		bclr	#1,$38(a1)
		subi.w	#$80,y_pos(a0)
		rts
; ---------------------------------------------------------------------------

loc_6CC32:
		movea.w	$44(a0),a1
		btst	#2,$38(a1)
		bne.s	locret_6CC44
		move.b	#4,routine(a0)

locret_6CC44:
		rts
; ---------------------------------------------------------------------------

loc_6CC46:
		lea	word_6D77C(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#loc_6CC58,(a0)
		rts
; ---------------------------------------------------------------------------

loc_6CC58:
		movea.w	parent3(a0),a1
		btst	#5,$38(a1)
		bne.w	loc_6C9E2
		jsr	(Refresh_ChildPositionAdjusted).l
		jmp	(Child_Draw_Sprite2).l
; ---------------------------------------------------------------------------

loc_6CC72:
		lea	word_6D788(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		clr.b	collision_flags(a0)
		move.w	#$200,priority(a0)
		move.l	#loc_6CCC0,(a0)
		movea.w	parent3(a0),a1
		move.w	angle(a1),d0
		move.w	byte_6CCA8(pc,d0.w),child_dx(a0)	; and child_dy
		lsr.w	#1,d0
		move.b	RawAni_6CCB8(pc,d0.w),mapping_frame(a0)
		jmp	(Refresh_ChildPositionAdjusted).l
; ---------------------------------------------------------------------------
byte_6CCA8:
		dc.b   $C,   0
		dc.b    3,  -7
		dc.b    0,-$10
		dc.b   -3,  -7
		dc.b  -$C,   0
		dc.b   -3,   7
		dc.b    0, $10
		dc.b   $C,   0
RawAni_6CCB8:
		dc.b  $1C, $15, $2C, $2A, $2D, $2B, $29, $1C
		even
; ---------------------------------------------------------------------------

loc_6CCC0:
		jsr	(Refresh_ChildPositionAdjusted).l
		movea.w	parent3(a0),a1
		btst	#5,$38(a1)
		bne.s	loc_6CCE0
		btst	#4,$38(a1)
		bne.s	loc_6CCE0
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_6CCE0:
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

loc_6CCE6:
		move.l	#loc_6CD12,(a0)
		move.l	#loc_6CD32,$34(a0)
		movea.w	parent3(a0),a1
		move.w	angle(a1),angle(a0)
		move.b	render_flags(a1),render_flags(a0)
		bclr	#7,render_flags(a0)
		move.w	#4,$2E(a0)
		rts
; ---------------------------------------------------------------------------

loc_6CD12:
		movea.w	parent3(a0),a1
		btst	#2,$38(a1)
		bne.s	loc_6CD2C
		btst	#4,$38(a1)
		bne.s	loc_6CD2C
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_6CD2C:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_6CD32:
		move.w	#4,$2E(a0)
		lea	ChildObjDat_6D81A(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_6CD42:
		lea	word_6D794(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#loc_6CD80,(a0)
		move.w	#$2F,$2E(a0)
		move.l	#Go_Delete_Sprite,$34(a0)
		movea.w	parent3(a0),a1
		movea.w	parent3(a1),a2
		move.w	a2,$44(a0)
		move.w	angle(a1),angle(a0)
		move.w	subtype(a1),subtype(a0)
		bsr.w	sub_6D334
		bra.w	loc_6D6A6
; ---------------------------------------------------------------------------

loc_6CD80:
		movea.w	$44(a0),a1
		btst	#2,$38(a1)
		bne.s	loc_6CD9C
		jsr	(MoveSprite2).l
		jsr	(Obj_Wait).l
		bra.w	loc_6D6A6
; ---------------------------------------------------------------------------

loc_6CD9C:
		move.l	#loc_6CDB0,(a0)
		movea.w	$44(a0),a1
		move.w	parent3(a1),$44(a0)
		bra.w	loc_6D6A6
; ---------------------------------------------------------------------------

loc_6CDB0:
		movea.w	$44(a0),a1
		movea.w	parent3(a1),a2
		move.w	y_pos(a1),d0
		move.b	subtype(a2),d1
		cmp.b	subtype(a0),d1
		bne.s	loc_6CDE4
		tst.b	d1
		bne.s	loc_6CDDA
		moveq	#8,d1
		add.w	d1,d0
		cmp.w	y_pos(a0),d0
		blt.s	loc_6CDE4

loc_6CDD4:
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

loc_6CDDA:
		moveq	#8,d1
		sub.w	d1,d0
		cmp.w	y_pos(a0),d0
		ble.s	loc_6CDD4

loc_6CDE4:
		bra.w	loc_6D6A6
; ---------------------------------------------------------------------------

loc_6CDE8:
		lea	word_6D78E(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#loc_6CE04,(a0)
		bsr.w	sub_6D36E
		move.l	#loc_6CE1E,$34(a0)

loc_6CE04:
		subq.w	#1,$2E(a0)
		bmi.s	loc_6CE1E
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		beq.w	locret_6BF96
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

loc_6CE1E:
		move.l	#loc_6CE36,(a0)
		move.b	#$17,mapping_frame(a0)
		clr.w	$2E(a0)
		moveq	#0,d0
		jmp	(Child_DrawTouch_Sprite_FlickerMove).l
; ---------------------------------------------------------------------------

loc_6CE36:
		movea.w	parent3(a0),a1
		btst	#3,$38(a1)
		bne.s	loc_6CE58
		move.b	#$16,mapping_frame(a0)
		addq.w	#1,$2E(a0)
		jsr	(MoveSprite2).l
		jmp	(Child_DrawTouch_Sprite_FlickerMove).l
; ---------------------------------------------------------------------------

loc_6CE58:
		move.l	#loc_6CE66,(a0)
		moveq	#0,d0
		jmp	(Child_DrawTouch_Sprite_FlickerMove).l
; ---------------------------------------------------------------------------

loc_6CE66:
		movea.w	parent3(a0),a1
		btst	#3,$38(a1)
		beq.s	loc_6CE78
		jmp	(Child_DrawTouch_Sprite_FlickerMove).l
; ---------------------------------------------------------------------------

loc_6CE78:
		move.l	#loc_6CE8A,(a0)
		neg.w	x_vel(a0)
		moveq	#0,d0
		jmp	(Child_DrawTouch_Sprite_FlickerMove).l
; ---------------------------------------------------------------------------

loc_6CE8A:
		subq.w	#1,$2E(a0)
		bmi.s	loc_6CE9C
		jsr	(MoveSprite2).l
		jmp	(Child_DrawTouch_Sprite_FlickerMove).l
; ---------------------------------------------------------------------------

loc_6CE9C:
		move.b	#$17,mapping_frame(a0)
		move.l	#Delete_Current_Sprite,(a0)
		moveq	#0,d0
		jmp	(Child_DrawTouch_Sprite_FlickerMove).l
; ---------------------------------------------------------------------------

loc_6CEB0:
		lea	word_6D79A(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#loc_6CEF0,(a0)
		move.b	subtype(a0),d0
		subi.b	#4,d0
		move.b	d0,subtype(a0)
		beq.s	loc_6CEE6
		move.w	#$380,priority(a0)
		movea.w	parent3(a0),a1
		cmpi.l	#Obj_MGZEndBoss,(a1)
		bne.s	loc_6CEE6
		bclr	#7,art_tile(a0)

loc_6CEE6:
		lea	ChildObjDat_6D7E2(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_6CEF0:
		movea.w	parent3(a0),a1
		btst	#5,$38(a1)
		bne.s	loc_6CF12
		lea	byte_6D2D2(pc),a2
		bsr.w	sub_6D2A4
		jsr	(Refresh_ChildPositionAdjusted).l
		moveq	#$14,d0
		jmp	(Child_Draw_Sprite2_FlickerMove).l
; ---------------------------------------------------------------------------

loc_6CF12:
		bset	#5,$38(a0)
		move.l	#Delete_Current_Sprite,(a0)
		rts
; ---------------------------------------------------------------------------

loc_6CF20:
		lea	word_6D7A0(pc),a1
		jsr	(SetUp_ObjAttributes2).l
		move.l	#loc_6CF62,(a0)
		bset	#4,shield_reaction(a0)
		movea.w	parent3(a0),a1
		move.w	parent3(a1),$44(a0)
		tst.b	subtype(a1)
		beq.s	loc_6CF4C
		move.w	#$300,priority(a0)

loc_6CF4C:
		bclr	#7,art_tile(a0)
		btst	#7,art_tile(a1)
		beq.s	locret_6CF60
		bset	#7,art_tile(a0)

locret_6CF60:
		rts
; ---------------------------------------------------------------------------

loc_6CF62:
		movea.w	parent3(a0),a1
		btst	#5,$38(a1)
		bne.s	loc_6CF98
		lea	byte_6D2E6(pc),a2
		bsr.w	sub_6D2A4
		jsr	(Refresh_ChildPositionAdjusted).l
		movea.w	$44(a0),a1
		btst	#7,status(a1)
		bne.s	loc_6CF98
		btst	#0,(V_int_run_count+3).w
		bne.w	locret_6BF96
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------

loc_6CF98:
		jmp	(Go_Delete_Sprite_2).l
; ---------------------------------------------------------------------------

loc_6CF9E:
		lea	ObjDat3_6D7A8(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_6CFB2,(a0)
		bra.w	loc_6D3E2
; ---------------------------------------------------------------------------

loc_6CFB2:
		jsr	(MoveSprite_LightGravity).l
		jmp	(Sprite_CheckDeleteXY).l
; ---------------------------------------------------------------------------

loc_6CFBE:
		lea	word_6D782(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		jsr	(Refresh_ChildPositionAdjusted).l
		move.l	#Obj_FlickerMove,(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		beq.s	loc_6CFE2
		move.w	#$200,priority(a0)

loc_6CFE2:
		lsr.w	#1,d0
		addi.b	#$2E,d0
		move.b	d0,mapping_frame(a0)
		moveq	#$28,d0
		jmp	(Set_IndexedVelocity).l
; ---------------------------------------------------------------------------

loc_6CFF4:
		lea	ObjDat3_6D7B4(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_6D060,(a0)
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
		bsr.w	sub_6D6CC
		moveq	#6,d0
		move.w	ground_vel(a0),d1
		beq.s	loc_6D058
		cmpi.w	#$C,d1
		beq.s	loc_6D058
		moveq	#$10,d0

loc_6D058:
		move.w	d0,$2E(a0)
		bra.w	loc_6D0EE
; ---------------------------------------------------------------------------

loc_6D060:
		movea.w	parent3(a0),a1
		btst	#2,$38(a1)
		bne.w	loc_6D0FE
		move.w	x_vel(a0),d0
		add.w	$2E(a0),d0
		cmpi.w	#-$100,d0
		bgt.s	loc_6D080
		move.w	d0,x_vel(a0)

loc_6D080:
		move.w	y_vel(a0),d0
		move.w	$3C(a0),d1
		bmi.s	loc_6D096
		add.w	d1,d0
		cmpi.w	#$400,d0
		ble.s	loc_6D09E
		bra.w	loc_6D0A2
; ---------------------------------------------------------------------------

loc_6D096:
		add.w	d1,d0
		cmpi.w	#-$400,d0
		blt.s	loc_6D0A2

loc_6D09E:
		move.w	d0,y_vel(a0)

loc_6D0A2:
		jsr	(sub_86180).l
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
		bne.s	loc_6D0F4
		move.b	$40(a0),d0
		add.b	$3E(a0),d0
		andi.b	#$7F,d0
		cmpi.b	#4,d0
		blo.w	loc_6D0EE
		move.b	d0,$40(a0)

loc_6D0EE:
		jsr	(Perform_Art_Scaling).l

loc_6D0F4:
		move.w	$30(a0),d0
		jmp	(Sprite_OnScreen_Test2).l
; ---------------------------------------------------------------------------

loc_6D0FE:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_6D104:
		subq.w	#1,$2E(a0)
		bpl.w	locret_6BF96
		moveq	#0,d0
		move.b	$39(a0),d0
		move.w	word_6D14C(pc,d0.w),$2E(a0)
		lsl.w	#4,d0
		lea	(Pal_MGZFadeCNZ).l,a1
		adda.w	d0,a1
		lea	(Normal_palette_line_4).w,a2
		moveq	#bytesToLcnt($20),d1

loc_6D128:
		move.l	(a1)+,(a2)+
		dbf	d1,loc_6D128
		addq.b	#2,$39(a0)
		cmpi.b	#$20,$39(a0)
		blo.w	locret_6BF96

loc_6D13C:
		move.w	#$300,d0
		jsr	(StartNewLevel).l
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------
word_6D14C:
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
; ---------------------------------------------------------------------------

loc_6D16A:
		movea.w	parent3(a0),a1
		move.w	(Camera_Y_pos).w,d0
		move.w	d0,d1
		moveq	#$18,d2
		addi.w	#$70,d0
		cmp.w	y_pos(a1),d0
		bge.s	loc_6D18A
		move.w	#$C8,d2
		bset	#2,$38(a0)

loc_6D18A:
		add.w	d2,d1
		move.w	d1,y_pos(a0)
		move.l	#Obj_Wait,(a0)
		move.b	#9,$39(a0)
		move.l	#loc_6D1A6,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_6D1A6:
		subq.b	#1,$39(a0)
		bmi.w	loc_6CD2C
		move.w	#3,$2E(a0)
		lea	ChildObjDat_6D844(pc),a2
		jmp	(CreateChild6_Simple).l
; ---------------------------------------------------------------------------

loc_6D1BE:
		lea	ObjDat3_6D7A8(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_6D1D2,(a0)
		bsr.w	sub_6D1DE

loc_6D1D2:
		jsr	(MoveSprite_LightGravity).l
		jmp	(Sprite_CheckDeleteXY).l

; =============== S U B R O U T I N E =======================================


sub_6D1DE:
		jsr	(Random_Number).l
		move.w	d0,d1
		andi.w	#3,d0
		move.b	RawAni_6D224(pc,d0.w),mapping_frame(a0)
		andi.w	#$3FF,d1
		btst	#0,d1
		beq.s	loc_6D1FC
		neg.w	d1

loc_6D1FC:
		move.w	d1,x_vel(a0)
		swap	d0
		movea.w	parent3(a0),a1
		btst	#2,$38(a1)
		beq.s	locret_6D222
		andi.w	#$1FF,d0
		addi.w	#$200,d0
		btst	#0,d0
		beq.s	loc_6D21E
		neg.w	d0

loc_6D21E:
		move.w	d0,$1A(a0)

locret_6D222:
		rts
; End of function sub_6D1DE

; ---------------------------------------------------------------------------
RawAni_6D224:
		dc.b    0,   1,   2,   0
		even

; =============== S U B R O U T I N E =======================================


sub_6D228:
		movea.w	parent3(a0),a1
		move.w	angle(a1),d0
		move.w	d0,angle(a0)
		lea	(a2,d0.w),a3
		move.b	(a3)+,mapping_frame(a0)
		moveq	#0,d0
		move.b	(a3)+,d0
		beq.s	locret_6D248
		lsl.w	#4,d0
		move.w	d0,priority(a0)

locret_6D248:
		rts
; End of function sub_6D228

; ---------------------------------------------------------------------------
byte_6D24A:
		dc.b    2, $30
		dc.b    3, $30
		dc.b  $1E, $30
		dc.b  $1F, $30
		dc.b    5, $30
		dc.b    3, $30
		dc.b    4, $30
		dc.b    2, $30
byte_6D25A:
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


sub_6D26A:
		movea.w	parent3(a0),a1
		move.w	angle(a1),d0
		move.w	d0,angle(a0)
		lea	(a2,d0.w),a3
		move.b	(a3)+,child_dx(a0)
		move.b	(a3)+,child_dy(a0)
		rts
; End of function sub_6D26A

; ---------------------------------------------------------------------------
byte_6D284:
		dc.b -$1C, $10
		dc.b  -$A, $18
		dc.b   $C, $1C
		dc.b  $18, $14
		dc.b  $2C,   8
		dc.b  $20, -$C
		dc.b  $14,-$14
		dc.b -$1C, $10
byte_6D294:
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


sub_6D2A4:
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
		beq.s	locret_6D2D0
		subi.b	#$14,child_dx(a0)

locret_6D2D0:
		rts
; End of function sub_6D2A4

; ---------------------------------------------------------------------------
byte_6D2D2:
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
byte_6D2E6:
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

loc_6D2FA:
		movea.w	$44(a0),a1
		move.w	angle(a1),d0
		add.w	d0,d0
		move.l	off_6D314(pc,d0.w),$30(a0)
		clr.b	anim_frame(a0)
		clr.b	anim_frame_timer(a0)
		rts
; ---------------------------------------------------------------------------
off_6D314:
		dc.l byte_6D853
		dc.l byte_6D87A
		dc.l byte_6D8A1
		dc.l byte_6D8C8
		dc.l byte_6D8CD
		dc.l byte_6D8D2
		dc.l byte_6D8D9
		dc.l byte_6D853

; =============== S U B R O U T I N E =======================================


sub_6D334:
		move.w	angle(a0),d0
		add.w	d0,d0
		move.l	word_6D34E(pc,d0.w),x_vel(a0)	; and y_vel
		btst	#0,render_flags(a1)
		beq.s	.return
		neg.w	x_vel(a0)

.return:
		rts
; End of function sub_6D334

; ---------------------------------------------------------------------------
word_6D34E:
		dc.w  -$400,     0
		dc.w  -$400,  $400
		dc.w      0,  $400
		dc.w   $400,  $400
		dc.w   $400,     0
		dc.w   $400, -$400
		dc.w      0, -$400
		dc.w  -$400,     0

; =============== S U B R O U T I N E =======================================


sub_6D36E:
		movea.w	parent3(a0),a1
		move.w	angle(a1),d0
		add.w	d0,d0
		move.l	word_6D34E(pc,d0.w),x_vel(a0)	; and y_vel
		btst	#0,render_flags(a1)
		beq.s	loc_6D38A
		neg.w	x_vel(a0)

loc_6D38A:
		moveq	#0,d0
		move.b	subtype(a0),d0
		move.w	word_6D398(pc,d0.w),$2E(a0)
		rts
; End of function sub_6D36E

; ---------------------------------------------------------------------------
word_6D398:
		dc.w      4,     9,    $E,   $13,   $18,   $1D,   $22,   $27
; ---------------------------------------------------------------------------

loc_6D3A8:
		movea.w	$44(a0),a1
		move.w	angle(a1),d0
		add.w	d0,d0
		move.l	off_6D3C2(pc,d0.w),$30(a0)
		clr.b	anim_frame(a0)
		clr.b	anim_frame_timer(a0)
		rts
; ---------------------------------------------------------------------------
off_6D3C2:
		dc.l byte_6D900
		dc.l byte_6D91F
		dc.l byte_6D93E
		dc.l byte_6D8C8
		dc.l byte_6D8CD
		dc.l byte_6D8D2
		dc.l byte_6D95D
		dc.l byte_6D900
; ---------------------------------------------------------------------------

loc_6D3E2:
		moveq	#0,d0
		move.b	subtype(a0),d0
		move.w	d0,d1
		lsr.w	#1,d0
		move.b	RawAni_6D3FC(pc,d0.w),mapping_frame(a0)
		add.w	d1,d1
		move.l	word_6D406(pc,d1.w),x_vel(a0)	; and y_vel
		rts
; ---------------------------------------------------------------------------
RawAni_6D3FC:
		dc.b    0,   1,   2,   0,   0,   1,   0,   2,   0,   1
		even
word_6D406:
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


sub_6D42E:
		jsr	(Random_Number).l
		andi.w	#$FF,d0
		move.w	d0,d1
		andi.w	#1,d1
		bclr	#0,render_flags(a0)
		subi.w	#$80,d0
		bcc.s	loc_6D452
		addq.w	#2,d1
		bset	#0,render_flags(a0)

loc_6D452:
		move.w	(Camera_Y_pos).w,d3
		addi.w	#8,d3
		lea	(_unkFA82).w,a2

loc_6D45E:
		move.w	(Camera_X_pos).w,d2
		addi.w	#$A8,d2
		add.w	d0,d2
		add.w	d1,d1
		move.w	word_6D4AC(pc,d1.w),d4
		move.w	d4,angle(a0)
		move.w	d2,x_pos(a0)
		move.w	d3,y_pos(a0)
		move.w	d1,(a2)+
		move.w	d4,(a2)+
		move.w	d2,(a2)+
		move.w	d3,(a2)+
		add.w	d1,d1
		move.l	off_6D4BC(pc,d1.w),$30(a0)
		clr.b	anim_frame(a0)
		clr.b	anim_frame_timer(a0)
		add.w	d4,d4
		lea	word_6D34E(pc),a3
		move.l	(a3,d4.w),x_vel(a0)	; and y_vel
		btst	#0,render_flags(a0)
		beq.s	locret_6D4AA
		neg.w	x_vel(a0)

locret_6D4AA:
		rts
; End of function sub_6D42E

; ---------------------------------------------------------------------------
word_6D4AC:
		dc.w      4,     2,     4,     2,    $C,    $A,    $C,    $A
off_6D4BC:
		dc.l byte_6D8C1
		dc.l byte_6D89A
		dc.l byte_6D8C1
		dc.l byte_6D89A
		dc.l byte_6D8F9
		dc.l byte_6D8D2
		dc.l byte_6D8F9
		dc.l byte_6D8D2

; =============== S U B R O U T I N E =======================================


sub_6D4DC:
		jsr	(Random_Number).l
		andi.w	#$7F,d0
		move.w	d0,d1
		andi.w	#1,d1
		addq.w	#4,d1
		move.w	(_unkFA82).w,d2
		lsr.w	#1,d2
		bset	#0,render_flags(a0)
		move.b	byte_6D516(pc,d2.w),d3
		beq.s	loc_6D508
		neg.w	d0
		bclr	#0,render_flags(a0)

loc_6D508:
		add.b	d3,d1
		move.w	#$F8,d3
		lea	(_unkFA8A).w,a2
		bra.w	loc_6D45E
; End of function sub_6D4DC

; ---------------------------------------------------------------------------
byte_6D516:
		dc.b    2,   0,   0,   2
		even
; ---------------------------------------------------------------------------

loc_6D51A:
		move.w	(a1)+,d0
		move.w	(a1)+,d1
		move.w	d1,angle(a0)
		move.w	(a1)+,d2
		move.w	(a1)+,d3
		lea	byte_6D588(pc,d0.w),a2
		move.b	(a2)+,d4
		ext.w	d4
		add.w	d4,d2
		move.w	d2,x_pos(a0)
		move.b	(a2)+,d4
		ext.w	d4
		add.w	d4,d3
		move.w	d3,y_pos(a0)
		lsr.w	#1,d0
		move.b	byte_6D598(pc,d0.w),$3A(a0)
		lsr.w	#1,d0
		move.b	byte_6D5A0(pc,d0.w),d2
		andi.b	#$FC,render_flags(a0)
		or.b	d2,render_flags(a0)
		add.w	d1,d1
		lea	word_6D34E(pc),a2
		move.l	(a2,d1.w),x_vel(a0)	; and y_vel
		asr	x_vel(a0)
		asr	y_vel(a0)
		btst	#0,render_flags(a0)
		beq.s	loc_6D576
		neg.w	x_vel(a0)

loc_6D576:
		moveq	#signextendB(sfx_Collapse),d0
		jsr	(Play_SFX).l
		lea	ChildObjDat_6D83E(pc),a2
		jmp	(CreateChild6_Simple).l
; ---------------------------------------------------------------------------
byte_6D588:
		dc.b  -$C,-$2C
		dc.b  $1A,-$28
		dc.b   $C,-$2C
		dc.b -$1A,-$28
		dc.b  $14, $24
		dc.b  $30, $1C
		dc.b -$14, $24
		dc.b -$30, $1C
byte_6D598:
		dc.b    0,   8,   0,   8,   0,   2,   0,   2
byte_6D5A0:
		dc.b    0,   1,   1,   0
		even

; =============== S U B R O U T I N E =======================================


MGZ2_SpecialCheckHit:
		tst.b	collision_flags(a0)
		bne.s	locret_6D608	; If collision is on, don't do anything
		tst.b	collision_property(a0)
		bne.s	loc_6D5C2		; If still has a hit point, branch
		tst.b	$46(a0)
		beq.s	loc_6D60A		; ONLY kill the boss is $46 isn't set. If it is set, this is an event instance of the object
		move.b	#1,collision_property(a0)
		bclr	#7,status(a0)

loc_6D5C2:
		tst.b	$20(a0)
		bne.s	loc_6D5D6
		move.b	#$20,$20(a0)
		moveq	#signextendB(sfx_BossHit),d0			; Play hit sound
		jsr	(Play_SFX).l

loc_6D5D6:
		bset	#6,status(a0)
		moveq	#0,d0
		btst	#0,$20(a0)
		bne.s	loc_6D5EA
		addi.w	#2*3,d0

loc_6D5EA:
		bsr.w	MGZ2_BossPalAdjust
		subq.b	#1,$20(a0)
		bne.s	locret_6D608
		bclr	#6,status(a0)
		cmpi.b	#0,mapping_frame(a0)
		bne.s	locret_6D608
		move.b	$25(a0),collision_flags(a0)	; Put backup of collision back into $28

locret_6D608:
		rts
; ---------------------------------------------------------------------------

loc_6D60A:
		move.l	#Wait_FadeToLevelMusic,(a0)
		move.l	#loc_6C2BE,$34(a0)
		jmp	(BossDefeated_StopTimer).l
; End of function MGZ2_SpecialCheckHit

; ---------------------------------------------------------------------------

loc_6D61E:
		tst.b	collision_flags(a0)
		bne.s	locret_6D668
		tst.b	collision_property(a0)
		beq.s	loc_6D66A
		tst.b	$20(a0)
		bne.s	loc_6D644
		move.b	#$20,$20(a0)
		moveq	#signextendB(sfx_BossHit),d0
		jsr	(Play_SFX).l
		bset	#6,status(a0)

loc_6D644:
		moveq	#0,d0
		btst	#0,$20(a0)
		bne.s	loc_6D652
		addi.w	#6,d0

loc_6D652:
		bsr.w	MGZ2_BossPalAdjust
		subq.b	#1,$20(a0)
		bne.s	locret_6D668
		bclr	#6,status(a0)
		move.b	$25(a0),collision_flags(a0)

locret_6D668:
		rts
; ---------------------------------------------------------------------------

loc_6D66A:
		move.l	#Wait_FadeToLevelMusic,(a0)
		move.l	#loc_6C890,$34(a0)
		jmp	(BossDefeated_StopTimer).l

; =============== S U B R O U T I N E =======================================


MGZ2_BossPalAdjust:
		lea	word_6D694(pc),a1
		lea	word_6D69A(pc,d0.w),a2
	rept 3
		movea.w	(a1)+,a3
		move.w	(a2)+,(a3)+
	endm
		rts
; End of function MGZ2_BossPalAdjust

; ---------------------------------------------------------------------------
word_6D694:
		dc.w Normal_palette_line_2+$16, Normal_palette_line_2+$1A, Normal_palette_line_2+$1C
word_6D69A:
		dc.w    $20,  $866,  $644
		dc.w   $EEE,  $888,  $AAA
; ---------------------------------------------------------------------------

loc_6D6A6:
		movea.w	$44(a0),a1
		movea.w	parent3(a1),a1
		btst	#7,status(a1)
		bne.s	loc_6D6BC
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------

loc_6D6BC:
		jsr	(Random_Number).l
		andi.w	#$3C,d0
		jmp	(loc_849D8).l

; =============== S U B R O U T I N E =======================================


sub_6D6CC:
		movea.w	$46(a0),a2
		moveq	#0,d0
		move.b	$39(a2),d0
		addq.b	#1,$39(a2)
		andi.b	#7,d0
		move.b	byte_6D708(pc,d0.w),d0
		move.w	d0,ground_vel(a0)
		move.w	d0,$3C(a2)
		lea	word_6D6F8(pc,d0.w),a1
		move.w	(a1)+,y_vel(a0)
		move.w	(a1)+,$3C(a0)
		rts
; End of function sub_6D6CC

; ---------------------------------------------------------------------------
word_6D6F8:
		dc.w  -$200,     8
		dc.w  -$600,   $40
		dc.w   $600,  -$40
		dc.w  -$200,     8
byte_6D708:
		dc.b    0,   8,   4,   0,   0,   4,   0,   8
		even
; ---------------------------------------------------------------------------

loc_6D710:
		move.w	$3C(a0),d0
		lea	word_6D744(pc,d0.w),a2
		move.w	(a2)+,d1
		add.w	(Camera_X_pos).w,d1
		move.w	d1,x_pos(a0)
		move.w	(a2)+,d1
		add.w	(Camera_Y_pos).w,d1
		move.w	d1,y_pos(a0)
		move.l	word_6D754(pc,d0.w),x_vel(a0)	; and y_vel
		lsr.w	#1,d0
		move.w	word_6D764(pc,d0.w),angle(a0)
		lsr.w	#1,d0
		move.b	byte_6D76C(pc,d0.w),$3A(a0)
		rts
; ---------------------------------------------------------------------------
word_6D744:
		dc.w   -$40,   $70
		dc.w    $A0,  $120
		dc.w    $A0,  -$50
		dc.w   -$40,   $70
word_6D754:
		dc.w   $200,     0
		dc.w    $80, -$200
		dc.w    $80,  $200
		dc.w   $200,     0
word_6D764:
		dc.w      0,    $C,     4,     0
byte_6D76C:
		dc.b    6,   4,   8,   6
		even
ObjDat_MGZDrillBoss:
		dc.l Map_MGZEndBoss
		dc.w make_art_tile($33F,1,0)
		dc.w   $300
		dc.b  $24, $20,   0,  $F
word_6D77C:
		dc.w   $380
		dc.b  $10, $10,   1,   0
word_6D782:
		dc.w   $300
		dc.b  $18, $18,   2,   0
word_6D788:
		dc.w   $280
		dc.b   $C,  $C,   9, $8B
word_6D78E:
		dc.w   $200
		dc.b    4,   4, $16, $98
word_6D794:
		dc.w   $300
		dc.b    4,   4, $16, $98
word_6D79A:
		dc.w   $180
		dc.b   $C,  $C,   6,   0
word_6D7A0:
		dc.w make_art_tile($33F,0,0)
		dc.w   $180
		dc.b   $C,  $C, $19, $9A
ObjDat3_6D7A8:
		dc.l Map_MGZEndBossDebris
		dc.w make_art_tile($45E,2,1)
		dc.w   $100
		dc.b  $10, $10,   0,   0
ObjDat3_6D7B4:
		dc.l Map_ScaledArt
		dc.w make_art_tile($469,1,0)
		dc.w   $300
		dc.b  $20, $20,   0,   0
ChildObjDat_6D7C0:
		dc.w 4-1
		dc.l loc_6CC46
		dc.b -$14,  $F
		dc.l loc_6C948
		dc.b -$1C, $10
		dc.l loc_6CEB0
		dc.b    8, $18
		dc.l loc_6CEB0
		dc.b  -$C, $18
ChildObjDat_6D7DA:
		dc.w 1-1
		dc.l loc_6C9E8
		dc.b -$17,   0
ChildObjDat_6D7E2:
		dc.w 1-1
		dc.l loc_6CF20
		dc.b    0, $10
ChildObjDat_6D7EA:
		dc.w $A-1
		dc.l loc_6CF9E
		dc.b  $18,-$40
ChildObjDat_6D7F2:
		dc.w $A-1
		dc.l loc_6CF9E
		dc.b -$18,-$40
ChildObjDat_6D7FA:
		dc.w 1-1
		dc.l loc_6CC72
		dc.b   $C,   0
ChildObjDat_6D802:
		dc.w 8-1
		dc.l loc_6CDE8
		dc.b -$10,   0
ChildObjDat_6D80A:
		dc.w 8-1
		dc.l loc_6CDE8
		dc.b  $10,   0
ChildObjDat_6D812:
		dc.w 1-1
		dc.l loc_6CCE6
		dc.b    0,   0
ChildObjDat_6D81A:
		dc.w 1-1
		dc.l loc_6CD42
		dc.b    0,   0
ChildObjDat_6D822:
		dc.w 3-1
		dc.l loc_6CFBE
		dc.b   $C,-$14
		dc.l loc_6CFBE
		dc.b -$10,   8
		dc.l loc_6CFBE
		dc.b  $14,   8
ChildObjDat_6D836:
		dc.w 1-1
		dc.l loc_6CFF4
		dc.b    0,   0
ChildObjDat_6D83E:
		dc.w 1-1
		dc.l loc_6D16A
ChildObjDat_6D844:
		dc.w 1-1
		dc.l loc_6D1BE
byte_6D84A:	; unused
		dc.b    0,   5
		dc.b    1,   5
		dc.b    2,   5
		dc.b    3,   5
		dc.b  $FC
byte_6D853:
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
byte_6D873:	; unused
		dc.b    9,   2
		dc.b   $A,   2
		dc.b   $B,   2
		dc.b  $FC
byte_6D87A:
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
byte_6D89A:
		dc.b   $C,   2
		dc.b   $D,   2
		dc.b   $E,   2
		dc.b  $FC
byte_6D8A1:
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
byte_6D8C1:
		dc.b  $20,   2
		dc.b  $21,   2
		dc.b  $22,   2
		dc.b  $FC
byte_6D8C8:
		dc.b  $14, $7F
		dc.b  $14, $7F
		dc.b  $FC
byte_6D8CD:
		dc.b  $13, $7F
		dc.b  $13, $7F
		dc.b  $FC
byte_6D8D2:
		dc.b  $26,   2
		dc.b  $27,   2
		dc.b  $28,   2
		dc.b  $FC
byte_6D8D9:
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
byte_6D8F9:
		dc.b   $F,   2
		dc.b  $10,   2
		dc.b  $11,   2
		dc.b  $FC
byte_6D900:
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
byte_6D91F:
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
byte_6D93E:
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
byte_6D95D:
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
Pal_MGZEndBoss:
		binclude "Levels/MGZ/Palettes/End Boss.bin"
		even
; ---------------------------------------------------------------------------

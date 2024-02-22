Obj_SSZEndBoss:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	SSZEndBoss_Index(pc,d0.w),d1
		jsr	SSZEndBoss_Index(pc,d1.w)
		lea	sub_7D35A(pc),a4
		bsr.w	sub_7D312
		bsr.w	sub_7D2D8
		lea	DPLCPtr_MechaSonic(pc),a2
		jsr	(Perform_DPLC).l
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------
SSZEndBoss_Index:
		dc.w loc_7B2DC-SSZEndBoss_Index
		dc.w loc_7B3AC-SSZEndBoss_Index
		dc.w loc_7B3E6-SSZEndBoss_Index
		dc.w loc_7B416-SSZEndBoss_Index
		dc.w loc_7B44A-SSZEndBoss_Index
		dc.w loc_7B478-SSZEndBoss_Index
		dc.w loc_7B4DA-SSZEndBoss_Index
		dc.w loc_7B53E-SSZEndBoss_Index
		dc.w loc_7B5AC-SSZEndBoss_Index
		dc.w loc_7B53E-SSZEndBoss_Index
		dc.w loc_7B53E-SSZEndBoss_Index
		dc.w loc_7B63A-SSZEndBoss_Index
		dc.w loc_7B67C-SSZEndBoss_Index
		dc.w loc_7B6A0-SSZEndBoss_Index
		dc.w loc_7B6DA-SSZEndBoss_Index
		dc.w loc_7B6EE-SSZEndBoss_Index
		dc.w loc_7B748-SSZEndBoss_Index
		dc.w loc_7B77E-SSZEndBoss_Index
		dc.w loc_7B7BA-SSZEndBoss_Index
		dc.w loc_7B748-SSZEndBoss_Index
		dc.w loc_7B804-SSZEndBoss_Index
; ---------------------------------------------------------------------------

loc_7B2DC:
		lea	ObjSlot_MechaSonic(pc),a1
		jsr	(SetUp_ObjAttributesSlotted).l
		move.b	#8,collision_property(a0)
		move.l	(V_int_run_count).w,(RNG_seed).w
		tst.b	(Current_act).w
		beq.s	loc_7B308
		move.w	#$220,x_pos(a0)
		move.w	#$4A0,y_pos(a0)
		bra.w	loc_7B35A
; ---------------------------------------------------------------------------

loc_7B308:
		move.b	#4,routine(a0)
		move.b	#2,mapping_frame(a0)
		move.w	#-$800,x_vel(a0)
		bset	#2,$38(a0)
		lea	ChildObjDat_7D47A(pc),a2
		jsr	(CreateChild6_Simple).l
		move.w	(Camera_X_pos).w,d0
		addi.w	#$20,d0
		move.w	d0,(_unkFAB4).w
		addi.w	#$100,d0
		move.w	d0,(_unkFAB6).w
		addi.w	#$40,d0
		move.w	d0,x_pos(a0)
		move.w	(Camera_Y_pos).w,d0
		addi.w	#$30,d0
		move.w	d0,(_unkFAB0).w
		addi.w	#$70,d0
		move.w	d0,y_pos(a0)

loc_7B35A:
		lea	(ArtKosM_MechaSonicExtra).l,a1
		move.w	#tiles_to_bytes($41C),d2
		jsr	(Queue_Kos_Module).l
		lea	(PLC_BossExplosion).l,a1
		jsr	(Load_PLC_Raw).l
		lea	(Pal_SSZGHZMisc).l,a1
		jsr	(PalLoad_Line1).l
		tst.b	(Current_act).w
		bne.s	loc_7B39C
		jsr	(AllocateObject).l
		bne.s	loc_7B39C
		move.l	#Obj_Song_Fade_Transition,(a1)
		move.b	#mus_EndBoss,subtype(a1)

loc_7B39C:
		lea	ChildObjDat_7D474(pc),a2
		jsr	(CreateChild6_Simple).l
		jmp	(AllocateObject).l
; ---------------------------------------------------------------------------

loc_7B3AC:
		btst	#4,(_unkFAB8).w
		beq.w	locret_7B448
		move.b	#$14,routine(a0)
		move.b	#2,$3B(a0)
		move.w	(Camera_X_pos).w,d0
		addi.w	#$20,d0
		move.w	d0,(_unkFAB4).w
		addi.w	#$100,d0
		move.w	d0,(_unkFAB6).w
		move.w	(Camera_Y_pos).w,d0
		addi.w	#$30,d0
		move.w	d0,(_unkFAB0).w
		bra.w	loc_7B57A
; ---------------------------------------------------------------------------

loc_7B3E6:
		jsr	(MoveSprite2).l
		move.w	(Camera_X_pos).w,d0
		subi.w	#$20,d0
		cmp.w	x_pos(a0),d0
		blo.s	locret_7B414
		move.b	#6,routine(a0)
		bclr	#2,$38(a0)
		move.w	#$3F,$2E(a0)
		move.l	#loc_7B41C,$34(a0)

locret_7B414:
		rts
; ---------------------------------------------------------------------------

loc_7B416:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_7B41C:
		move.b	#8,routine(a0)
		bset	#0,render_flags(a0)
		move.w	(Camera_Y_pos).w,d0
		addi.w	#$40,d0
		move.w	d0,y_pos(a0)
		move.w	#$400,x_vel(a0)
		move.b	#3,mapping_frame(a0)
		move.l	#byte_7D523,$30(a0)

locret_7B448:
		rts
; ---------------------------------------------------------------------------

loc_7B44A:
		jsr	(Animate_RawMultiDelay).l
		jsr	(MoveSprite2).l
		move.w	x_pos(a0),d0
		cmp.w	(_unkFAB6).w,d0
		bhs.s	loc_7B462
		rts
; ---------------------------------------------------------------------------

loc_7B462:
		move.b	#$A,routine(a0)
		move.w	#$1F,$2E(a0)
		move.l	#loc_7B484,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_7B478:
		jsr	(Animate_RawMultiDelay).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_7B484:
		move.b	#$C,routine(a0)
		move.b	#$1F,y_radius(a0)
		clr.w	x_vel(a0)
		clr.w	y_vel(a0)
		clr.b	anim_frame(a0)
		clr.b	anim_frame_timer(a0)
		move.l	#loc_7B4EC,$34(a0)
		jsr	(Random_Number).l
		tst.w	d0
		bmi.s	loc_7B4CA
		bclr	#4,(_unkFAB8).w
		bne.s	loc_7B4CA
		move.l	#byte_7D4DE,$30(a0)
		bclr	#3,$38(a0)
		rts
; ---------------------------------------------------------------------------

loc_7B4CA:
		move.l	#byte_7D4EF,$30(a0)
		bset	#3,$38(a0)
		rts
; ---------------------------------------------------------------------------

loc_7B4DA:
		jsr	(Animate_RawMultiDelay).l
		jsr	(MoveSprite_LightGravity).l
		jmp	(ObjHitFloor_DoRoutine).l
; ---------------------------------------------------------------------------

loc_7B4EC:
		move.b	#$E,routine(a0)
		clr.w	$16(a0)
		clr.b	anim_frame(a0)
		clr.b	anim_frame_timer(a0)
		moveq	#signextendB(sfx_MechaLand),d0
		jsr	(Play_SFX).l
		btst	#3,$38(a0)
		bne.s	loc_7B520
		move.l	#byte_7D596,$30(a0)
		move.l	#loc_7B544,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_7B520:
		bchg	#0,render_flags(a0)
		move.b	#1,mapping_frame(a0)
		move.l	#byte_7D5A2,$30(a0)
		move.l	#loc_7B57A,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_7B53E:
		jmp	(Animate_RawMultiDelay).l
; ---------------------------------------------------------------------------

loc_7B544:
		move.b	#$10,routine(a0)
		move.w	#$820,d0
		move.w	#-$20,d1
		btst	#0,render_flags(a0)
		beq.s	loc_7B55E
		neg.w	d0
		neg.w	d1

loc_7B55E:
		move.w	d0,x_vel(a0)
		move.w	d1,$40(a0)
		clr.w	y_vel(a0)
		bset	#2,$38(a0)
		lea	ChildObjDat_7D486(pc),a2
		jmp	(CreateChild6_Simple).l
; ---------------------------------------------------------------------------

loc_7B57A:
		move.b	#$14,routine(a0)
		move.l	#byte_7D541,$30(a0)
		move.l	#loc_7B5E8,$34(a0)
		move.w	(Camera_X_pos).w,d0
		addi.w	#$A0,d0
		bset	#0,render_flags(a0)
		cmp.w	x_pos(a0),d0
		bhs.s	locret_7B5AA
		bclr	#0,render_flags(a0)

locret_7B5AA:
		rts
; ---------------------------------------------------------------------------

loc_7B5AC:
		move.w	$40(a0),d0
		add.w	d0,x_vel(a0)
		jsr	(MoveSprite2).l
		lea	loc_7B5C2(pc),a1
		bra.w	loc_7D216
; ---------------------------------------------------------------------------

loc_7B5C2:
		move.b	#$12,routine(a0)
		move.w	d0,x_pos(a0)
		clr.w	$12(a0)
		bclr	#2,$38(a0)
		move.l	#byte_7D59B,$30(a0)
		move.l	#loc_7B57A,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_7B5E8:
		move.b	#$F,y_radius(a0)
		lea	byte_7D54A(pc),a1
		jsr	(Set_Raw_Animation).l
		move.w	#$200,d0
		btst	#0,render_flags(a0)
		bne.s	loc_7B606
		neg.w	d0

loc_7B606:
		move.w	d0,x_vel(a0)
		move.w	#-$600,y_vel(a0)
		move.b	$3B(a0),d0
		addq.b	#1,$3B(a0)
		andi.w	#7,d0
		moveq	#0,d1
		move.b	byte_7B62E(pc,d0.w),d1
		move.b	d1,$3A(a0)
		move.b	byte_7B636(pc,d1.w),routine(a0)
		rts
; ---------------------------------------------------------------------------
byte_7B62E:
		dc.b    0,   1,   2,   0,   1,   2,   0,   1
byte_7B636:
		dc.b  $16, $1A, $1E
		even
; ---------------------------------------------------------------------------

loc_7B63A:
		jsr	(Animate_RawMultiDelay).l
		jsr	(MoveSprite).l
		tst.w	y_vel(a0)
		bpl.s	loc_7B64E
		rts
; ---------------------------------------------------------------------------

loc_7B64E:
		move.b	#$18,routine(a0)
		move.w	#$780,d0
		moveq	#-$20,d1
		btst	#0,render_flags(a0)
		bne.s	loc_7B666
		neg.w	d0
		neg.w	d1

loc_7B666:
		move.w	d0,x_vel(a0)
		move.w	d1,$40(a0)
		clr.w	y_vel(a0)
		moveq	#signextendB(sfx_Dash),d0
		jsr	(Play_SFX).l
		rts
; ---------------------------------------------------------------------------

loc_7B67C:
		jsr	(Animate_RawMultiDelay).l
		move.w	$40(a0),d0
		add.w	d0,x_vel(a0)
		jsr	(MoveSprite2).l
		lea	loc_7B698(pc),a1
		bra.w	loc_7D216
; ---------------------------------------------------------------------------

loc_7B698:
		move.w	d0,x_pos(a0)
		bra.w	loc_7B462
; ---------------------------------------------------------------------------

loc_7B6A0:
		jsr	(Animate_RawMultiDelay).l
		jsr	(MoveSprite).l
		tst.w	y_vel(a0)
		bmi.s	locret_7B6BE
		jsr	(ObjCheckFloorDist).l
		tst.w	d1
		bmi.s	loc_7B6C0
		beq.s	loc_7B6C0

locret_7B6BE:
		rts
; ---------------------------------------------------------------------------

loc_7B6C0:
		add.w	d1,y_pos(a0)
		move.b	#$1C,routine(a0)
		move.w	#-$900,y_vel(a0)
		moveq	#signextendB(sfx_Thump),d0
		jsr	(Play_SFX).l
		rts
; ---------------------------------------------------------------------------

loc_7B6DA:
		jsr	(Animate_RawMultiDelay).l
		jsr	(MoveSprite).l
		lea	loc_7B462(pc),a1
		bra.w	loc_7D216
; ---------------------------------------------------------------------------

loc_7B6EE:
		jsr	(Animate_RawMultiDelay).l
		jsr	(MoveSprite).l
		tst.w	y_vel(a0)
		bmi.s	locret_7B70C
		jsr	(ObjCheckFloorDist).l
		tst.w	d1
		bmi.s	loc_7B70E
		beq.s	loc_7B70E

locret_7B70C:
		rts
; ---------------------------------------------------------------------------

loc_7B70E:
		add.w	d1,y_pos(a0)
		move.b	#$20,routine(a0)
		move.w	#$F,$2E(a0)
		move.l	#loc_7B754,$34(a0)
		bset	#2,$38(a0)
		moveq	#signextendB(sfx_MechaLand),d0
		jsr	(Play_SFX).l
		lea	ChildObjDat_7D480(pc),a2
		jsr	(CreateChild6_Simple).l
		bne.s	locret_7B70C
		move.b	#8,subtype(a1)
		rts
; ---------------------------------------------------------------------------

loc_7B748:
		jsr	(Animate_RawMultiDelay).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_7B754:
		move.b	#$22,routine(a0)
		move.w	#$100,d0
		tst.w	x_vel(a0)
		bmi.s	loc_7B766
		neg.w	d0

loc_7B766:
		move.w	d0,x_vel(a0)
		clr.w	y_vel(a0)
		move.w	#7,$2E(a0)
		move.l	#loc_7B790,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_7B77E:
		jsr	(Animate_RawMultiDelay).l
		jsr	(MoveSprite2).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_7B790:
		move.b	#$24,routine(a0)
		move.w	#$640,d0
		move.w	#-$20,d1
		tst.w	x_vel(a0)
		bmi.s	loc_7B7A8
		neg.w	d0
		neg.w	d1

loc_7B7A8:
		move.w	d0,x_vel(a0)
		move.w	d1,$40(a0)
		moveq	#signextendB(sfx_Dash),d0
		jsr	(Play_SFX).l
		rts
; ---------------------------------------------------------------------------

loc_7B7BA:
		jsr	(Animate_RawMultiDelay).l
		move.w	$40(a0),d0
		add.w	d0,x_vel(a0)
		jsr	(MoveSprite2).l
		lea	loc_7B7D6(pc),a1
		bra.w	loc_7D216
; ---------------------------------------------------------------------------

loc_7B7D6:
		move.b	#$26,routine(a0)
		move.w	#$F,$2E(a0)
		move.l	#loc_7B7EC,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_7B7EC:
		move.b	#$28,routine(a0)
		bclr	#2,$38(a0)
		clr.w	x_vel(a0)
		move.w	#-$640,y_vel(a0)
		rts
; ---------------------------------------------------------------------------

loc_7B804:
		jsr	(Animate_RawMultiDelay).l
		jsr	(MoveSprite).l
		tst.w	y_vel(a0)
		bpl.w	loc_7B462
		rts
; ---------------------------------------------------------------------------

loc_7B81A:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_7B838(pc,d0.w),d1
		jsr	off_7B838(pc,d1.w)
		lea	DPLCPtr_MechaSonic(pc),a2
		jsr	(Perform_DPLC).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
off_7B838:
		dc.w loc_7B852-off_7B838
		dc.w loc_7B87C-off_7B838
		dc.w loc_7B93E-off_7B838
		dc.w loc_7B972-off_7B838
		dc.w loc_7B984-off_7B838
		dc.w loc_7B9D2-off_7B838
		dc.w loc_7B9FA-off_7B838
		dc.w loc_7BA28-off_7B838
		dc.w loc_7BA90-off_7B838
		dc.w loc_7BABE-off_7B838
		dc.w loc_7BB06-off_7B838
		dc.w loc_7BBAC-off_7B838
		dc.w loc_7BBE0-off_7B838
; ---------------------------------------------------------------------------

loc_7B852:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_7B858:
		move.b	#2,routine(a0)
		move.b	#$E,mapping_frame(a0)
		move.b	#$1F,y_radius(a0)
		clr.w	x_vel(a0)
		clr.w	y_vel(a0)
		move.l	#loc_7B888,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_7B87C:
		jsr	(MoveSprite_LightGravity).l
		jmp	(ObjHitFloor_DoRoutine).l
; ---------------------------------------------------------------------------

loc_7B888:
		move.b	#$23,y_radius(a0)
		lea	byte_7D5E4(pc),a1
		jsr	(Set_Raw_Animation).l
		lea	(word_7D842).l,a1
		bsr.w	sub_7C678
		lea	ChildObjDat_7D48C(pc),a2
		jsr	(CreateChild6_Simple).l
		moveq	#signextendB(sfx_MechaLand),d0
		jsr	(Play_SFX).l
		tst.b	(Current_act).w
		bne.s	loc_7B8E6
		move.b	#4,routine(a0)
		st	(_unkFAA8).w
		bset	#5,$38(a0)
		bclr	#3,$38(a0)
		move.w	#(2*60)-1,$2E(a0)
		jsr	(AllocateObject).l
		bne.s	locret_7B8E4
		move.l	#loc_7D056,(a1)

locret_7B8E4:
		rts
; ---------------------------------------------------------------------------

loc_7B8E6:
		btst	#7,$38(a0)
		bne.s	loc_7B916
		bset	#5,$38(a0)
		move.b	#8,routine(a0)
		move.w	#$BF,$2E(a0)
		move.l	#loc_7B996,$34(a0)
		moveq	#signextendB(mus_FadeOut),d0
		jsr	(Play_Music).l
		st	(Ctrl_2_locked).w
		rts
; ---------------------------------------------------------------------------

loc_7B916:
		move.l	#loc_7BC32,(a0)
		clr.b	(Update_HUD_timer).w
		move.w	#$BF,$2E(a0)
		jsr	(AllocateObject).l
		bne.s	loc_7B934
		move.l	#loc_8642E,(a1)

loc_7B934:
		lea	ChildObjDat_7D4D0(pc),a2
		jmp	(CreateChild6_Simple).l
; ---------------------------------------------------------------------------

loc_7B93E:
		jsr	(Run_PalRotationScript).l
		jmp	(Animate_RawMultiDelay).l
; ---------------------------------------------------------------------------
		jsr	(ObjCheckFloorDist).l
		tst.w	d1
		bmi.w	locret_7B448
		beq.w	locret_7B448
		move.b	#6,routine(a0)
		bset	#7,art_tile(a0)
		lea	(Pal_SSZGHZMisc).l,a1
		jmp	(PalLoad_Line1).l
; ---------------------------------------------------------------------------

loc_7B972:
		tst.b	render_flags(a0)
		bpl.s	loc_7B97E
		jmp	(MoveSprite).l
; ---------------------------------------------------------------------------

loc_7B97E:
		jmp	(Go_Delete_Sprite_2).l
; ---------------------------------------------------------------------------

loc_7B984:
		jsr	(Run_PalRotationScript).l
		jsr	(Animate_RawMultiDelay).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_7B996:
		move.b	#$A,routine(a0)
		move.b	#1,(Update_HUD_timer).w
		clr.b	status(a0)
		clr.b	$38(a0)
		ori.b	#$50,$38(a0)
		moveq	#signextendB(mus_DDZ),d0
		jsr	(Play_Music).l
		lea	ChildObjDat_7D492(pc),a2
		jsr	(CreateChild1_Normal).l
		lea	(ArtKosM_EndingMasterEmerald).l,a1
		move.w	#tiles_to_bytes($52E),d2
		jmp	(Queue_Kos_Module).l
; ---------------------------------------------------------------------------

loc_7B9D2:
		btst	#6,$38(a0)
		bne.s	locret_7B9F8
		move.b	#$C,routine(a0)
		lea	byte_7D5EF(pc),a1
		jsr	(Set_Raw_Animation).l
		move.b	#$E,mapping_frame(a0)
		move.l	#loc_7BA00,$34(a0)

locret_7B9F8:
		rts
; ---------------------------------------------------------------------------

loc_7B9FA:
		jmp	(Animate_RawMultiDelay).l
; ---------------------------------------------------------------------------

loc_7BA00:
		move.b	#$E,routine(a0)
		move.w	#$3B,$2E(a0)
		bset	#2,$38(a0)
		lea	ChildObjDat_7D486(pc),a2
		btst	#0,render_flags(a0)
		beq.s	loc_7BA22
		lea	ChildObjDat_7D47A(pc),a2

loc_7BA22:
		jmp	(CreateChild6_Simple).l
; ---------------------------------------------------------------------------

loc_7BA28:
		moveq	#signextendB(sfx_Spindash),d0
		jsr	(Play_SFX_Continuous).l
		subq.w	#1,$2E(a0)
		bmi.s	loc_7BA38
		rts
; ---------------------------------------------------------------------------

loc_7BA38:
		move.b	#$10,routine(a0)
		clr.w	(Ctrl_1_logical).w
		st	(Ctrl_1_locked).w
		lea	(Player_1).w,a1
		jsr	(Stop_Object).l
		move.w	(Camera_max_X_pos).w,d0
		addi.w	#$140,d0
		move.w	d0,(Camera_max_X_pos).w
		addi.w	#$100,d0
		move.w	d0,(_unkFAB6).w
		move.w	#$600,x_vel(a0)
		clr.w	y_vel(a0)
		jsr	(AllocateObject).l
		bne.s	loc_7BA80
		move.l	#loc_7C818,(a1)
		move.w	a1,$44(a0)

loc_7BA80:
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	locret_7BA8E
		move.l	#loc_7C9E8,(a1)

locret_7BA8E:
		rts
; ---------------------------------------------------------------------------

loc_7BA90:
		jsr	(MoveSprite2).l
		move.w	(_unkFAB6).w,d0
		subi.w	#$AA,d0
		cmp.w	x_pos(a0),d0
		bls.s	loc_7BAA6
		rts
; ---------------------------------------------------------------------------

loc_7BAA6:
		move.b	#$12,routine(a0)
		move.l	#loc_7BAD0,$34(a0)
		lea	byte_7D5F6(pc),a1
		jmp	(Set_Raw_Animation).l
; ---------------------------------------------------------------------------

loc_7BABE:
		addi.w	#-$30,x_vel(a0)
		jsr	(MoveSprite2).l
		jmp	(Animate_RawMultiDelay).l
; ---------------------------------------------------------------------------

loc_7BAD0:
		move.b	#$14,routine(a0)
		bclr	#2,$38(a0)
		move.w	#-$400,y_vel(a0)
		move.b	#$4B,y_radius(a0)
		move.l	#loc_7BB20,$34(a0)
		lea	byte_7D61A(pc),a1
		btst	#0,render_flags(a0)
		beq.s	loc_7BB00
		lea	byte_7D60A(pc),a1

loc_7BB00:
		jmp	(Set_Raw_Animation).l
; ---------------------------------------------------------------------------

loc_7BB06:
		jsr	(Animate_RawMultiDelayFlipX).l
		jsr	(MoveSprite_LightGravity).l
		tst.w	y_vel(a0)
		bmi.w	locret_7B448
		jmp	(ObjHitFloor_DoRoutine).l
; ---------------------------------------------------------------------------

loc_7BB20:
		move.w	(Camera_min_X_pos).w,d0
		addi.w	#$A0,d0
		move.w	d0,(Camera_min_X_pos).w
		addi.w	#$10,d0
		move.w	d0,(_unkFA82).w
		addi.w	#$50,d0
		move.w	d0,(_unkFA84).w
		addi.w	#$50,d0
		move.w	d0,(_unkFA86).w
		addi.w	#$40,d0
		move.w	d0,(_unkFA88).w
		addi.w	#$40,d0
		move.w	d0,(_unkFA8A).w
		addi.w	#$50,d0
		move.w	d0,(_unkFA8C).w
		addi.w	#$50,d0
		move.w	d0,(_unkFA8E).w
		move.b	#$16,routine(a0)
		move.l	#loc_7BBC6,$34(a0)
		lea	byte_7D5AB(pc),a1
		jsr	(Set_Raw_Animation).l

loc_7BB7C:
		clr.b	$38(a0)
		bset	#7,$38(a0)
		moveq	#signextendB(sfx_MechaLand),d0
		jsr	(Play_SFX).l
		lea	(word_7D9EA).l,a1
		bsr.w	sub_7C678
		lea	ChildObjDat_7D48C(pc),a2
		jsr	(CreateChild6_Simple).l
		bne.s	locret_7BBAA
		move.b	#8,subtype(a1)

locret_7BBAA:
		rts
; ---------------------------------------------------------------------------

loc_7BBAC:
		moveq	#signextendB(sfx_MechaTransform),d0
		jsr	(Play_SFX_Continuous).l
		jsr	(Run_PalRotationScript).l
		bchg	#6,(_unkFAB8).w
		jmp	(Animate_RawMultiDelay).l
; ---------------------------------------------------------------------------

loc_7BBC6:
		move.b	#$18,routine(a0)
		lea	(Player_1).w,a1
		clr.b	status(a1)
		clr.b	spin_dash_flag(a1)
		move.w	#$782,spin_dash_counter(a1)
		rts
; ---------------------------------------------------------------------------

loc_7BBE0:
		jsr	(Run_PalRotationScript).l
		bchg	#6,(_unkFAB8).w
		move.w	#(button_right_mask<<8)|button_right_mask,(Ctrl_1_logical).w
		lea	(Player_1).w,a1
		move.w	x_pos(a1),d0
		move.w	(_unkFA8A).w,d1
		addi.w	#$10,d1
		cmp.w	d1,d0
		blo.w	locret_7B448
		clr.b	(Scroll_lock).w
		clr.w	(H_scroll_frame_offset).w
		clr.w	(Ctrl_1_logical).w
		clr.b	(Ctrl_1_locked).w
		bsr.w	sub_7D150
		move.l	#Obj_SSZ2_Boss,(a0)
		move.b	#8,collision_property(a0)
		move.b	#$23,collision_flags(a0)
		bra.w	loc_7BDD8
; ---------------------------------------------------------------------------

loc_7BC32:
		subq.w	#1,$2E(a0)
		bmi.s	loc_7BC3E
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_7BC3E:
		move.l	#Obj_Wait,(a0)
		move.w	#$1F,$2E(a0)
		move.l	#loc_7BC70,$34(a0)
		bclr	#7,render_flags(a0)
		moveq	#signextendB(mus_FadeOut),d0
		jsr	(Play_Music).l
		addi.w	#$20,y_pos(a0)
		lea	ChildObjDat_7D4CA(pc),a2
		jmp	(CreateChild6_Simple).l
; ---------------------------------------------------------------------------

loc_7BC70:
		move.l	#loc_7BCB0,(a0)
		bset	#5,$38(a0)
		clr.w	$3A(a0)
		move.b	#4,$39(a0)
		lea	(Normal_palette).w,a1
		lea	(Target_palette).w,a2
		moveq	#bytesToLcnt($80),d6

loc_7BC90:
		move.l	(a1)+,(a2)+
		dbf	d6,loc_7BC90
		jsr	(AllocateObject).l
		bne.s	locret_7BCAE
		move.w	a1,$44(a0)
		move.l	#loc_85E64,(a1)
		move.w	#7,$3A(a1)

locret_7BCAE:
		rts
; ---------------------------------------------------------------------------

loc_7BCB0:
		bsr.w	sub_7BD30
		movea.w	$44(a0),a1
		btst	#7,status(a1)
		beq.w	locret_7B448
		move.l	#loc_7BCFC,(a0)
		move.w	#(2*60)-1,$2E(a0)
		st	(_unkFAA2).w
		st	(Events_fg_4+1).w
		lea	(Player_1).w,a1
		move.b	#$83,object_control(a1)
		clr.b	mapping_frame(a1)
		bclr	#Status_OnObj,status(a1)
		clr.b	jumping(a1)
		clr.b	spin_dash_flag(a1)
		st	(SRAM_mask_interrupts_flag).w
		jmp	(SaveGame).l
; ---------------------------------------------------------------------------

loc_7BCFC:
		bsr.w	sub_7BD30
		subq.w	#1,$2E(a0)
		bpl.w	locret_7B448
		move.w	#3,(Player_mode).w
		jsr	(AllocateObject).l
		bne.s	loc_7BD1C
		move.l	#loc_5E6C0,(a1)

loc_7BD1C:
		jsr	(AllocateObject).l
		bne.s	loc_7BD2A
		move.l	#loc_85EE6,(a1)

loc_7BD2A:
		jmp	(Delete_Current_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_7BD30:
		subq.w	#1,$3A(a0)
		bpl.s	locret_7BD4A
		move.w	#$1F,$3A(a0)
		subq.b	#1,$39(a0)
		bmi.s	locret_7BD4A
		moveq	#signextendB(sfx_MissileExplode),d0
		jsr	(Play_SFX).l

locret_7BD4A:
		rts
; End of function sub_7BD30

; ---------------------------------------------------------------------------

Obj_SSZ2_Boss:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	SSZ2_Boss_Index(pc,d0.w),d1
		jsr	SSZ2_Boss_Index(pc,d1.w)
		lea	loc_7D39E(pc),a4
		bsr.w	sub_7D312
		bsr.w	sub_7D2D8
		lea	DPLCPtr_MechaSonic(pc),a2
		jsr	(Perform_DPLC).l
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------
SSZ2_Boss_Index:
		dc.w loc_7BDBE-SSZ2_Boss_Index
		dc.w loc_7BDBE-SSZ2_Boss_Index
		dc.w loc_7BE0E-SSZ2_Boss_Index
		dc.w loc_7BE42-SSZ2_Boss_Index
		dc.w loc_7BE9C-SSZ2_Boss_Index
		dc.w loc_7BF28-SSZ2_Boss_Index
		dc.w loc_7BF5A-SSZ2_Boss_Index
		dc.w loc_7BFA0-SSZ2_Boss_Index
		dc.w loc_7C062-SSZ2_Boss_Index
		dc.w loc_7C11C-SSZ2_Boss_Index
		dc.w loc_7C144-SSZ2_Boss_Index
		dc.w loc_7C11C-SSZ2_Boss_Index
		dc.w loc_7C18C-SSZ2_Boss_Index
		dc.w loc_7C1D8-SSZ2_Boss_Index
		dc.w loc_7C1F2-SSZ2_Boss_Index
		dc.w loc_7C144-SSZ2_Boss_Index
		dc.w loc_7C250-SSZ2_Boss_Index
		dc.w loc_7C2A4-SSZ2_Boss_Index
		dc.w loc_7C2DC-SSZ2_Boss_Index
		dc.w loc_7C302-SSZ2_Boss_Index
		dc.w loc_7C328-SSZ2_Boss_Index
		dc.w loc_7C37A-SSZ2_Boss_Index
		dc.w loc_7C37A-SSZ2_Boss_Index
		dc.w loc_7C3F8-SSZ2_Boss_Index
		dc.w loc_7C430-SSZ2_Boss_Index
		dc.w loc_7C458-SSZ2_Boss_Index
		dc.w loc_7C49E-SSZ2_Boss_Index
		dc.w loc_7C4E0-SSZ2_Boss_Index
		dc.w loc_7C51C-SSZ2_Boss_Index
		dc.w loc_7C55E-SSZ2_Boss_Index
		dc.w loc_7C59A-SSZ2_Boss_Index
		dc.w loc_7C630-SSZ2_Boss_Index
		dc.w loc_7C64E-SSZ2_Boss_Index
		dc.w loc_7C65C-SSZ2_Boss_Index
		dc.w loc_7C684-SSZ2_Boss_Index
		dc.w loc_7C6F0-SSZ2_Boss_Index
; ---------------------------------------------------------------------------

loc_7BDBE:
		moveq	#signextendB(sfx_MechaTransform),d0
		jsr	(Play_SFX_Continuous).l
		jsr	(Run_PalRotationScript).l
		bchg	#6,(_unkFAB8).w
		jmp	(Animate_RawMultiDelay).l
; ---------------------------------------------------------------------------

loc_7BDD8:
		move.b	#2,routine(a0)
		bset	#6,$38(a0)
		move.l	#loc_7BDF6,$34(a0)
		lea	byte_7D5FF(pc),a1
		jmp	(Set_Raw_Animation).l
; ---------------------------------------------------------------------------

loc_7BDF6:
		move.b	#4,routine(a0)
		clr.w	x_vel(a0)
		move.w	#-$480,y_vel(a0)
		bclr	#6,(_unkFAB8).w
		rts
; ---------------------------------------------------------------------------

loc_7BE0E:
		jsr	(Run_PalRotationScript).l
		jsr	(MoveSprite_LightGravity).l
		move.w	(_unkFAB0).w,d0
		cmp.w	y_pos(a0),d0
		bhs.s	loc_7BE26
		rts
; ---------------------------------------------------------------------------

loc_7BE26:
		move.w	d0,y_pos(a0)
		move.b	#6,routine(a0)
		move.l	#loc_7BE4E,$34(a0)
		lea	byte_7D645(pc),a1
		jmp	(Set_Raw_Animation).l
; ---------------------------------------------------------------------------

loc_7BE42:
		jsr	(Run_PalRotationScript).l
		jmp	(Animate_RawMultiDelay).l
; ---------------------------------------------------------------------------

loc_7BE4E:
		move.b	#8,routine(a0)
		clr.b	$39(a0)
		bclr	#1,$38(a0)
		lea	word_7DA60(pc),a1
		bsr.w	sub_7C678
		move.w	#$3F,$2E(a0)
		move.l	#loc_7BEA8,$34(a0)
		lea	(Normal_palette).w,a1
		lea	(Target_palette).w,a2
		moveq	#bytesToLcnt($80),d6

loc_7BE7E:
		move.l	(a1)+,(a2)+
		dbf	d6,loc_7BE7E
		jsr	(AllocateObject).l
		bne.s	loc_7BE92
		move.l	#loc_7D09C,(a1)

loc_7BE92:
		moveq	#signextendB(sfx_SuperTransform),d0
		jsr	(Play_SFX).l
		rts
; ---------------------------------------------------------------------------

loc_7BE9C:
		jsr	(Run_PalRotationScript).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_7BEA8:
		cmpi.b	#2,collision_property(a0)
		bls.s	loc_7BF0C

loc_7BEB0:
		move.w	x_pos(a0),d0
		move.w	(_unkFA82).w,d1
		bclr	#0,render_flags(a0)
		cmp.w	(_unkFA88).w,d0
		bhs.s	loc_7BECE
		move.w	(_unkFA8E).w,d1
		bset	#0,render_flags(a0)

loc_7BECE:
		move.w	d1,$3C(a0)

loc_7BED2:
		move.b	#$A,routine(a0)
		clr.w	x_vel(a0)
		clr.w	y_vel(a0)
		move.w	#$80,d0
		btst	#0,render_flags(a0)
		bne.s	loc_7BEEE
		neg.w	d0

loc_7BEEE:
		move.w	d0,$40(a0)
		lea	byte_7D652(pc),a1
		jsr	(Set_Raw_Animation).l
		bset	#6,$38(a0)
		lea	ChildObjDat_7D49A(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_7BF0C:
		move.b	#$3C,routine(a0)
		move.b	#8,mapping_frame(a0)
		move.w	#$80,$2E(a0)
		move.b	#5,$39(a0)
		bra.w	loc_7C34C
; ---------------------------------------------------------------------------

loc_7BF28:
		jsr	(Run_PalRotationScript).l
		jsr	(Animate_RawMultiDelay).l
		move.w	x_vel(a0),d0
		add.w	$40(a0),d0
		move.w	d0,x_vel(a0)
		cmpi.w	#-$800,d0
		ble.s	loc_7BF52
		cmpi.w	#$800,d0
		bge.s	loc_7BF52
		jmp	(MoveSprite2).l
; ---------------------------------------------------------------------------

loc_7BF52:
		move.b	#$C,routine(a0)
		rts
; ---------------------------------------------------------------------------

loc_7BF5A:
		jsr	(Run_PalRotationScript).l
		jsr	(MoveSprite2).l
		tst.w	x_vel(a0)
		bmi.s	loc_7BF7C
		move.w	$3C(a0),d0
		sub.w	x_pos(a0),d0
		cmpi.w	#$38,d0
		blo.s	loc_7BF8C
		rts
; ---------------------------------------------------------------------------

loc_7BF7C:
		move.w	x_pos(a0),d0
		sub.w	$3C(a0),d0
		cmpi.w	#$38,d0
		blo.s	loc_7BF8C
		rts
; ---------------------------------------------------------------------------

loc_7BF8C:
		move.b	#$E,routine(a0)
		neg.w	$40(a0)
		lea	byte_7D626(pc),a1
		jmp	(Set_Raw_Animation).l
; ---------------------------------------------------------------------------

loc_7BFA0:
		jsr	(Run_PalRotationScript).l
		jsr	(Animate_RawMultiDelayFlipX).l
		move.w	$40(a0),d0
		add.w	d0,x_vel(a0)
		jsr	(MoveSprite2).l
		move.w	$3C(a0),d0
		tst.w	x_vel(a0)
		bmi.s	loc_7BFCC
		cmp.w	x_pos(a0),d0
		bls.s	loc_7BFD4
		rts
; ---------------------------------------------------------------------------

loc_7BFCC:
		cmp.w	x_pos(a0),d0
		bhs.s	loc_7BFD4
		rts
; ---------------------------------------------------------------------------

loc_7BFD4:
		move.b	#$10,routine(a0)
		bclr	#6,$38(a0)
		btst	#1,$38(a0)
		bne.s	loc_7C008
		move.w	#7,$2E(a0)
		move.b	$39(a0),d0
		addq.b	#1,d0
		move.b	d0,$39(a0)
		cmpi.b	#2,d0
		bhs.s	loc_7C018

loc_7BFFE:
		move.l	#loc_7BEB0,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_7C008:
		move.w	#$1F,$2E(a0)
		move.l	#loc_7C06E,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_7C018:
		bsr.w	sub_7D1EA
		move.b	d2,child_dy(a0)
		move.w	x_pos(a0),d0
		cmp.w	(_unkFA88).w,d0
		blo.s	loc_7C02C
		not.b	d3

loc_7C02C:
		tst.b	d3
		bne.s	loc_7BFFE
		bset	#1,$38(a0)
		move.l	#loc_7BED2,$34(a0)
		move.b	byte_7C050-1(pc,d2.w),child_dx(a0)
		add.w	d2,d2
		movea.w	word_7C056-2(pc,d2.w),a1
		move.w	(a1),$3C(a0)
		rts
; ---------------------------------------------------------------------------
byte_7C050:
		dc.b   4,   5,   6,   1,   2,   3
		even
word_7C056:
		dc.w _unkFA8A, _unkFA8C, _unkFA8E
		dc.w _unkFA82, _unkFA84, _unkFA86
; ---------------------------------------------------------------------------

loc_7C062:
		jsr	(Run_PalRotationScript).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_7C06E:
		bsr.w	sub_7D1B6
		beq.s	loc_7C0B6
		move.b	#$12,routine(a0)
		move.w	#$1F,$2E(a0)
		move.l	#loc_7C12E,$34(a0)
		moveq	#signextendB(sfx_Roll),d0
		jsr	(Play_SFX).l
		lea	(Player_1).w,a1
		moveq	#0,d0
		move.w	x_pos(a1),d0
		moveq	#0,d1
		move.w	(Camera_Y_pos).w,d1
		addi.w	#$B0,d1
		moveq	#3,d5
		jsr	(sub_861D0).l
		lea	byte_7D52A(pc),a1
		jmp	(Set_Raw_Animation).l
; ---------------------------------------------------------------------------

loc_7C0B6:
		jsr	(Random_Number).l
		andi.b	#3,d0
		bne.s	loc_7C104
		move.b	#$1C,routine(a0)
		clr.w	x_vel(a0)
		clr.w	y_vel(a0)
		move.w	x_pos(a0),d0
		move.w	#-$80,d1
		cmp.w	(_unkFA88).w,d0
		bhs.s	loc_7C0E0
		neg.w	d1

loc_7C0E0:
		move.w	d1,$40(a0)
		moveq	#signextendB(sfx_MissileShoot),d0
		jsr	(Play_SFX).l
		lea	byte_7D652(pc),a1
		jsr	(Set_Raw_Animation).l
		bset	#6,$38(a0)
		lea	ChildObjDat_7D49A(pc),a2
		jmp	CreateChild1_Normal(pc)
; ---------------------------------------------------------------------------

loc_7C104:
		move.b	#$28,routine(a0)
		clr.w	x_vel(a0)
		clr.w	y_vel(a0)
		lea	byte_7D57C(pc),a1
		jmp	(Set_Raw_Animation).l
; ---------------------------------------------------------------------------

loc_7C11C:
		jsr	(Run_PalRotationScript).l
		jsr	(Animate_RawMultiDelay).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_7C12E:
		move.b	#$14,routine(a0)
		move.b	#$13,y_radius(a0)
		move.l	#loc_7C15C,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_7C144:
		jsr	(Run_PalRotationScript).l
		jsr	(Animate_RawMultiDelay).l
		jsr	(MoveSprite2).l
		jmp	(ObjHitFloor_DoRoutine).l
; ---------------------------------------------------------------------------

loc_7C15C:
		move.b	#$16,routine(a0)
		move.w	#$3F,$2E(a0)
		move.l	#loc_7C17A,$34(a0)
		moveq	#signextendB(sfx_Crash),d0
		jsr	(Play_SFX).l
		rts
; ---------------------------------------------------------------------------

loc_7C17A:
		move.b	#$18,routine(a0)
		clr.w	x_vel(a0)
		move.w	#-$400,y_vel(a0)
		rts
; ---------------------------------------------------------------------------

loc_7C18C:
		jsr	(Run_PalRotationScript).l
		jsr	(Animate_RawMultiDelay).l
		jsr	(MoveSprite2).l
		move.w	(_unkFAB0).w,d0
		cmp.w	y_pos(a0),d0
		bhs.s	loc_7C1AA
		rts
; ---------------------------------------------------------------------------

loc_7C1AA:
		move.b	#$1A,routine(a0)
		move.l	#loc_7C1E4,$34(a0)
		move.w	x_pos(a0),d0
		bclr	#0,render_flags(a0)
		cmp.w	(_unkFA88).w,d0
		bhs.s	loc_7C1CE
		bset	#0,render_flags(a0)

loc_7C1CE:
		lea	byte_7D538(pc),a1
		jmp	(Set_Raw_Animation).l
; ---------------------------------------------------------------------------

loc_7C1D8:
		jsr	(Run_PalRotationScript).l
		jmp	(Animate_RawMultiDelay).l
; ---------------------------------------------------------------------------

loc_7C1E4:
		clr.b	$39(a0)
		bclr	#1,$38(a0)
		bra.w	loc_7BEB0
; ---------------------------------------------------------------------------

loc_7C1F2:
		jsr	(Run_PalRotationScript).l
		jsr	(Animate_RawMultiDelay).l
		move.w	$40(a0),d0
		add.w	d0,x_vel(a0)
		move.w	y_vel(a0),d0
		addi.w	#$80,d0
		move.w	d0,y_vel(a0)
		cmpi.w	#$800,d0
		blo.s	loc_7C22C
		move.b	#$1E,routine(a0)
		move.b	#$57,y_radius(a0)
		move.l	#loc_7C232,$34(a0)

loc_7C22C:
		jmp	(MoveSprite2).l
; ---------------------------------------------------------------------------

loc_7C232:
		move.b	#$20,routine(a0)
		move.b	#$1F,y_radius(a0)
		move.l	#loc_7C274,$34(a0)
		moveq	#signextendB(sfx_MechaLand),d0
		jsr	(Play_SFX).l
		rts
; ---------------------------------------------------------------------------

loc_7C250:
		jsr	(Run_PalRotationScript).l
		jsr	(Animate_RawMultiDelay).l
		move.w	y_vel(a0),d0
		addi.w	#-$80,d0
		move.w	d0,y_vel(a0)
		jsr	(MoveSprite2).l
		jmp	(ObjHitFloor_DoRoutine).l
; ---------------------------------------------------------------------------

loc_7C274:
		move.b	#$22,routine(a0)
		move.w	$40(a0),d0
		neg.w	d0
		asr.w	#1,d0
		move.w	d0,$40(a0)
		clr.w	y_vel(a0)
		move.l	#loc_7C2BE,$34(a0)
		moveq	#signextendB(sfx_MechaLand),d0
		jsr	(Play_SFX).l
		lea	byte_7D556(pc),a1
		jmp	(Set_Raw_Animation).l
; ---------------------------------------------------------------------------

loc_7C2A4:
		jsr	(Run_PalRotationScript).l
		jsr	(Animate_RawMultiDelay).l
		move.w	$40(a0),d0
		add.w	d0,x_vel(a0)
		jmp	(MoveSprite2).l
; ---------------------------------------------------------------------------

loc_7C2BE:
		move.b	#$24,routine(a0)
		bclr	#6,$38(a0)
		move.l	#loc_7C2E8,$34(a0)
		lea	byte_7D561(pc),a1
		jmp	(Set_Raw_Animation).l
; ---------------------------------------------------------------------------

loc_7C2DC:
		jsr	(Run_PalRotationScript).l
		jmp	(Animate_RawMultiDelay).l
; ---------------------------------------------------------------------------

loc_7C2E8:
		move.b	#$26,routine(a0)
		clr.w	x_vel(a0)
		move.w	#-$600,y_vel(a0)
		lea	byte_7D56C(pc),a1
		jmp	(Set_Raw_Animation).l
; ---------------------------------------------------------------------------

loc_7C302:
		jsr	(Run_PalRotationScript).l
		jsr	(Animate_RawMultiDelayFlipX).l
		jsr	(MoveSprite_LightGravity).l
		move.w	(_unkFAB0).w,d0
		cmp.w	y_pos(a0),d0
		bhs.s	loc_7C320
		rts
; ---------------------------------------------------------------------------

loc_7C320:
		move.w	d0,y_pos(a0)
		bra.w	loc_7C1E4
; ---------------------------------------------------------------------------

loc_7C328:
		jsr	(Run_PalRotationScript).l
		jsr	(Animate_RawMultiDelayFlipX).l
		moveq	#$10,d1
		jsr	(MoveSprite_CustomGravity).l
		cmpi.w	#$100,y_vel(a0)
		bhs.s	loc_7C346
		rts
; ---------------------------------------------------------------------------

loc_7C346:
		move.b	#$2A,routine(a0)

loc_7C34C:
		move.w	#$100,d0
		move.w	d0,$3E(a0)
		move.w	d0,y_vel(a0)
		move.w	#$10,$40(a0)
		bclr	#0,$38(a0)
		move.b	#3,$39(a0)
		move.w	#$1F,$2E(a0)
		move.l	#loc_7C39E,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_7C37A:
		jsr	(Run_PalRotationScript).l
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		jsr	(Find_SonicTails).l
		jsr	(Change_FlipX).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_7C39E:
		move.w	#$2F,$2E(a0)
		lea	ChildObjDat_7D4AE(pc),a2
		jsr	CreateChild1_Normal(pc)
		subq.b	#1,$39(a0)
		bpl.w	locret_7B448
		move.b	#8,subtype(a1)
		move.b	#$2C,routine(a0)
		move.l	#loc_7C3CA,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_7C3CA:
		move.b	#$2E,routine(a0)
		move.b	#$1F,y_radius(a0)
		move.l	#loc_7C410,$34(a0)
		bclr	#7,$38(a0)
		lea	(word_7DB66).l,a1
		bsr.w	sub_7C678
		lea	byte_7D508(pc),a1
		jmp	(Set_Raw_Animation).l
; ---------------------------------------------------------------------------

loc_7C3F8:
		jsr	(Run_PalRotationScript).l
		jsr	(Animate_RawMultiDelay).l
		jsr	(MoveSprite).l
		jmp	(ObjHitFloor_DoRoutine).l
; ---------------------------------------------------------------------------

loc_7C410:
		move.b	#$30,routine(a0)
		move.l	#loc_7C436,$34(a0)
		moveq	#signextendB(sfx_MechaLand),d0
		jsr	(Play_SFX).l
		lea	byte_7D510(pc),a1
		jmp	(Set_Raw_Animation).l
; ---------------------------------------------------------------------------

loc_7C430:
		jmp	(Animate_RawMultiDelay).l
; ---------------------------------------------------------------------------

loc_7C436:
		move.b	#$32,routine(a0)
		clr.b	y_vel(a0)
		move.b	#$13,$1E(a0)
		move.l	#loc_7C46A,$34(a0)
		move.l	#byte_7D519,$30(a0)
		rts
; ---------------------------------------------------------------------------

loc_7C458:
		jsr	(Animate_RawMultiDelay).l
		jsr	(MoveSprite_LightGravity).l
		jmp	(ObjHitFloor_DoRoutine).l
; ---------------------------------------------------------------------------

loc_7C46A:
		move.b	#$34,routine(a0)
		moveq	#signextendB(sfx_MechaLand),d0
		jsr	(Play_SFX).l
		bset	#0,render_flags(a0)
		move.w	#$400,d0
		move.w	x_pos(a0),d1
		cmp.w	(_unkFAB6).w,d1
		blo.s	loc_7C494
		bclr	#0,render_flags(a0)
		neg.w	d0

loc_7C494:
		move.w	d0,x_vel(a0)
		clr.w	y_vel(a0)
		rts
; ---------------------------------------------------------------------------

loc_7C49E:
		jsr	(Animate_RawMultiDelay).l
		jsr	(MoveSprite2).l
		move.w	(_unkFAB6).w,d0
		tst.w	x_vel(a0)
		bmi.s	loc_7C4BC
		cmp.w	x_pos(a0),d0
		bls.s	loc_7C4C4
		rts
; ---------------------------------------------------------------------------

loc_7C4BC:
		cmp.w	x_pos(a0),d0
		bhs.s	loc_7C4C4
		rts
; ---------------------------------------------------------------------------

loc_7C4C4:
		move.w	d0,x_pos(a0)
		move.b	#$36,routine(a0)
		move.b	#$1F,y_radius(a0)
		clr.w	x_vel(a0)
		move.w	#-$200,y_vel(a0)
		rts
; ---------------------------------------------------------------------------

loc_7C4E0:
		jsr	(Animate_RawMultiDelay).l
		jsr	(MoveSprite_LightGravity).l
		jsr	(ObjCheckFloorDist).l
		tst.w	d1
		bpl.s	loc_7C4F8
		rts
; ---------------------------------------------------------------------------

loc_7C4F8:
		add.w	d1,y_pos(a0)
		move.b	#$38,routine(a0)
		move.l	#loc_7C522,$34(a0)
		moveq	#signextendB(sfx_MechaLand),d0
		jsr	(Play_SFX).l
		lea	byte_7D5C1(pc),a1
		jmp	(Set_Raw_Animation).l
; ---------------------------------------------------------------------------

loc_7C51C:
		jmp	(Animate_RawMultiDelay).l
; ---------------------------------------------------------------------------

loc_7C522:
		move.b	#$3A,routine(a0)
		move.w	#-$400,y_vel(a0)
		move.b	#$4B,y_radius(a0)
		move.l	#loc_7C578,$34(a0)
		bclr	#0,render_flags(a0)
		bne.s	loc_7C54E
		move.l	#byte_7D61A,$30(a0)
		rts
; ---------------------------------------------------------------------------

loc_7C54E:
		move.b	#$C,mapping_frame(a0)
		move.l	#byte_7D5D8,$30(a0)
		rts
; ---------------------------------------------------------------------------

loc_7C55E:
		jsr	(Animate_RawMultiDelay).l
		jsr	(MoveSprite_LightGravity).l
		tst.w	y_vel(a0)
		bmi.w	locret_7B448
		jmp	(ObjHitFloor_DoRoutine).l
; ---------------------------------------------------------------------------

loc_7C578:
		move.b	#0,routine(a0)
		move.l	#loc_7BDD8,$34(a0)
		moveq	#signextendB(sfx_MechaLand),d0
		jsr	(Play_SFX).l
		lea	byte_7D5B6(pc),a1
		jsr	Set_Raw_Animation(pc)
		bra.w	loc_7BB7C
; ---------------------------------------------------------------------------

loc_7C59A:
		jsr	(Run_PalRotationScript).l
		subq.w	#1,$2E(a0)
		bmi.s	loc_7C61A
		jsr	(Swing_UpAndDown_Count).l
		bne.s	loc_7C5EA
		jsr	(MoveSprite2).l
		jsr	(Find_SonicTails).l
		move.w	#-$100,d1
		btst	#0,render_flags(a0)
		beq.s	loc_7C5CA
		subq.w	#2,d0
		neg.w	d1

loc_7C5CA:
		tst.w	d0
		bne.s	loc_7C5D4
		move.w	d1,x_vel(a0)
		rts
; ---------------------------------------------------------------------------

loc_7C5D4:
		move.b	#$3E,routine(a0)
		move.l	#loc_7C646,$34(a0)
		lea	byte_7D636(pc),a1
		jmp	Set_Raw_Animation(pc)
; ---------------------------------------------------------------------------

loc_7C5EA:
		move.b	#$40,routine(a0)
		bclr	#7,$38(a0)
		move.w	#$100,d0
		btst	#0,render_flags(a0)
		bne.s	loc_7C604
		neg.w	d0

loc_7C604:
		move.w	d0,x_vel(a0)
		move.l	#loc_7C654,(Palette_rotation_custom).w
		lea	(word_7DC7E).l,a1
		bra.w	sub_7C678
; ---------------------------------------------------------------------------

loc_7C61A:
		move.b	#$46,routine(a0)
		move.l	#loc_7C718,$34(a0)
		lea	byte_7D587(pc),a1
		jmp	Set_Raw_Animation(pc)
; ---------------------------------------------------------------------------

loc_7C630:
		jsr	(Run_PalRotationScript).l
		jsr	Animate_RawMultiDelayFlipX(pc)
		jsr	(Swing_UpAndDown).l
		jmp	(MoveSprite2).l
; ---------------------------------------------------------------------------

loc_7C646:
		move.b	#$3C,routine(a0)
		rts
; ---------------------------------------------------------------------------

loc_7C64E:
		jmp	(Run_PalRotationScript).l
; ---------------------------------------------------------------------------

loc_7C654:
		move.b	#$42,routine(a0)
		rts
; ---------------------------------------------------------------------------

loc_7C65C:
		jsr	(MoveSprite_LightGravity).l
		cmpi.w	#$400,y_vel(a0)
		bge.s	loc_7C66C
		rts
; ---------------------------------------------------------------------------

loc_7C66C:
		move.b	#$44,routine(a0)
		lea	(word_7DC06).l,a1

; =============== S U B R O U T I N E =======================================


sub_7C678:
		lea	(Palette_rotation_data).w,a2
		move.l	(a1)+,(a2)+
		move.l	(a1)+,(a2)+
		clr.w	(a2)
		rts
; End of function sub_7C678

; ---------------------------------------------------------------------------

loc_7C684:
		jsr	(Run_PalRotationScript).l
		bclr	#7,$38(a0)
		cmpi.l	#word_7DC06.header,(Palette_rotation_data+4).w
		beq.s	loc_7C6A0
		bset	#7,$38(a0)

loc_7C6A0:
		move.w	y_vel(a0),d0
		addi.w	#-$40,d0
		cmpi.w	#-$400,d0
		blt.s	loc_7C6B2
		move.w	d0,y_vel(a0)

loc_7C6B2:
		jsr	(MoveSprite2).l
		move.w	(_unkFAB0).w,d0
		cmp.w	y_pos(a0),d0
		bhs.s	loc_7C6C4
		rts
; ---------------------------------------------------------------------------

loc_7C6C4:
		move.w	d0,y_pos(a0)
		move.b	#$3C,routine(a0)
		move.b	#6,$39(a0)
		move.w	#$100,d0
		move.w	d0,$3E(a0)
		neg.w	d0
		move.w	d0,y_vel(a0)
		move.w	#$10,$40(a0)
		bset	#0,$38(a0)
		rts
; ---------------------------------------------------------------------------

loc_7C6F0:
		jsr	(Run_PalRotationScript).l
		jsr	Animate_RawMultiDelay(pc)
		beq.w	locret_7B448
		cmpi.b	#8,anim_frame(a0)
		bne.w	locret_7B448
		moveq	#signextendB(sfx_BossProjectile),d0
		jsr	(Play_SFX).l
		lea	ChildObjDat_7D4A8(pc),a2
		jmp	CreateChild6_Simple(pc)
; ---------------------------------------------------------------------------

loc_7C718:
		move.b	#$3C,routine(a0)
		move.w	#$7F,$2E(a0)
		rts
; ---------------------------------------------------------------------------

loc_7C726:
		lea	ObjDat3_7D444(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		move.l	#loc_7C738,(a0)
		bsr.w	sub_7D162

loc_7C738:
		jsr	(MoveSprite2).l
		jmp	(Sprite_CheckDeleteTouchXY).l
; ---------------------------------------------------------------------------

loc_7C744:
		lea	ObjDat3_7D438(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		move.l	#loc_7C756,(a0)
		bsr.w	sub_7D192

loc_7C756:
		jsr	Animate_Raw(pc)
		jsr	Refresh_ChildPositionAdjusted(pc)
		jmp	(Child_DrawTouch_Sprite).l
; ---------------------------------------------------------------------------

loc_7C764:
		move.l	#loc_7C77A,(a0)
		moveq	#signextendB(sfx_BossLaser),d0
		jsr	(Play_SFX).l
		moveq	#2,d5
		jmp	(loc_861C0).l
; ---------------------------------------------------------------------------

loc_7C77A:
		lea	byte_7D6A3(pc),a1
		jsr	Animate_RawNoSST(pc)
		jsr	(MoveSprite2).l
		jmp	(Sprite_CheckDeleteTouchXY).l
; ---------------------------------------------------------------------------

loc_7C78E:
		lea	ObjDat3_7D426(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		move.l	#loc_7C79C,(a0)

loc_7C79C:
		lea	byte_7D67B(pc),a1
		jsr	Animate_RawNoSST(pc)
		jsr	Refresh_ChildPositionAdjusted(pc)
		movea.w	parent3(a0),a1
		btst	#6,$38(a1)
		beq.w	loc_7C8F8
		cmpi.b	#$12,mapping_frame(a1)
		bne.w	locret_7B448
		btst	#0,(V_int_run_count+3).w
		lea	ChildObjDat_7D4A2(pc),a2
		jsr	CreateChild6_Simple(pc)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_7C7D4:
		lea	word_7D432(pc),a1
		jsr	SetUp_ObjAttributes3(pc)
		move.l	#loc_7C80A,(a0)
		move.l	#Go_Delete_Sprite,$34(a0)
		jsr	(Random_Number).l
		andi.w	#$1F,d0
		subi.w	#$F,d0
		add.w	d0,x_pos(a0)
		swap	d0
		andi.w	#$1F,d0
		subi.w	#$F,d0
		add.w	d0,y_pos(a0)

loc_7C80A:
		lea	byte_7D683(pc),a1
		jsr	Animate_RawNoSSTMultiDelay(pc)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_7C818:
		lea	ObjDat3_7D450(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		move.w	(Camera_max_X_pos).w,d0
		addi.w	#$100,d0
		move.w	d0,x_pos(a0)
		move.w	(Camera_Y_pos).w,d0
		addi.w	#$A8,d0
		move.w	d0,y_pos(a0)
		move.l	#loc_7C864,(a0)
		lea	(Collected_emeralds_array).w,a1
		moveq	#3,d0
		moveq	#7-1,d1

loc_7C846:
		cmp.b	(a1)+,d0
		bne.s	locret_7C854
		dbf	d1,loc_7C846
		move.l	#loc_7C856,(a0)

locret_7C854:
		rts
; ---------------------------------------------------------------------------

loc_7C856:
		lea	off_7DD5A(pc),a1
		lea	(Normal_palette_line_3+$1C).w,a2
		jsr	(Run_PalRotationScript2).l

loc_7C864:
		move.b	#0,mapping_frame(a0)
		btst	#6,(_unkFAB8).w
		beq.s	loc_7C878
		move.b	#1,mapping_frame(a0)

loc_7C878:
		tst.b	(_unkFAA2).w
		bne.w	loc_7C8F8
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_7C886:
		lea	ObjDat3_7D41A(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		movea.w	parent3(a0),a1
		btst	#2,render_flags(a1)
		bne.s	loc_7C8A0
		bclr	#2,render_flags(a0)

loc_7C8A0:
		move.l	#loc_7C8BA,(a0)
		move.l	#byte_7D668,$30(a0)
		move.l	#loc_7C8C4,$34(a0)
		jsr	Refresh_ChildPositionAdjusted(pc)

loc_7C8BA:
		jsr	Animate_RawMultiDelay(pc)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_7C8C4:
		move.l	#loc_7C8D6,(a0)
		movea.w	parent3(a0),a1
		bclr	#6,$38(a1)
		rts
; ---------------------------------------------------------------------------

loc_7C8D6:
		move.b	#-7,child_dx(a0)
		move.b	#3,child_dy(a0)
		jsr	Refresh_ChildPositionAdjusted(pc)
		movea.w	parent3(a0),a1
		cmpi.b	#$E,mapping_frame(a1)
		bne.s	loc_7C8F8
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_7C8F8:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_7C8FE:
		addq.b	#4,subtype(a0)

loc_7C902:
		lea	ObjDat3_7D402(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		move.l	#loc_7C91C,(a0)
		bsr.w	sub_7D236
		moveq	#signextendB(sfx_Roll),d0
		jsr	(Play_SFX).l

loc_7C91C:
		lea	byte_7D65F(pc),a1
		jsr	Animate_RawNoSSTMultiDelay(pc)
		jsr	Refresh_ChildPositionAdjusted(pc)
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.s	loc_7C942
		btst	#2,$38(a1)
		beq.s	loc_7C942
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_7C942:
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

Obj_MechaSonic_Sparks:
		lea	ObjDat_MechaSonic_Sparks(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		move.l	#loc_7C964,(a0)
		bclr	#7,subtype(a0)
		beq.s	loc_7C964
		bclr	#2,render_flags(a0)

loc_7C964:
		movea.w	parent3(a0),a1
		btst	#6,$38(a1)
		bne.w	loc_7C8F8
		cmpi.w	#$E88,(Normal_palette_line_2+$12).w
		bne.w	locret_7B448
		moveq	#signextendB(sfx_MechaSpark),d0
		jsr	(Play_SFX).l
		moveq	#0,d0
		bchg	#0,$39(a0)
		bne.s	loc_7C990
		moveq	#4,d0

loc_7C990:
		add.b	subtype(a0),d0
		lea	byte_7C9AA(pc,d0.w),a2
		move.w	(a2)+,child_dx(a0)	; and child_dy
		move.b	(a2)+,mapping_frame(a0)
		jsr	Refresh_ChildPositionAdjusted(pc)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
byte_7C9AA:
		dc.b   -4,  $C,   4
		even
		dc.b    0,   8,   5
		even
		dc.b    8,   4,   6
		even
		dc.b    8,   4,   7
		even
; ---------------------------------------------------------------------------

loc_7C9BA:
		lea	word_7D3FC(pc),a1
		jsr	SetUp_ObjAttributes3(pc)
		move.l	#loc_7C9C8,(a0)

loc_7C9C8:
		bsr.w	sub_7D260
		jsr	Refresh_ChildPositionAdjusted(pc)
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.s	loc_7C9E2
		jmp	(Add_SpriteToCollisionResponseList).l
; ---------------------------------------------------------------------------

loc_7C9E2:
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

loc_7C9E8:
		move.b	#1,(Scroll_lock).w
		move.l	#loc_7C9F6,(a0)
		rts
; ---------------------------------------------------------------------------

loc_7C9F6:
		bsr.w	sub_7D150
		move.w	(Camera_X_pos).w,d0
		move.w	x_vel(a0),d1
		move.w	(Camera_max_X_pos).w,d2
		addq.w	#6,d0
		cmp.w	d2,d0
		bhs.s	loc_7CA12
		move.w	d0,(Camera_X_pos).w
		rts
; ---------------------------------------------------------------------------

loc_7CA12:
		move.w	d2,(Camera_X_pos).w
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

Obj_KnuxFinalBossCrane:
		move.l	#loc_7CA3A,(a0)
		move.w	(Camera_min_X_pos).w,(Camera_max_X_pos).w
		lea	PLC_KnuxFinalBossCrane(pc),a1
		jmp	(Load_PLC_Raw).l
; ---------------------------------------------------------------------------
PLC_KnuxFinalBossCrane: plrlistheader
		plreq $52E, ArtNem_RobotnikShip
PLC_KnuxFinalBossCrane_End
; ---------------------------------------------------------------------------

loc_7CA3A:
		lea	(Player_1).w,a1
		btst	#Status_InAir,status(a1)
		beq.w	locret_7B448
		move.l	#loc_7CAAA,(a0)
		lea	(ObjDat3_664EE).l,a1
		jsr	SetUp_ObjAttributes(pc)
		move.w	#-$80,x_vel(a0)
		jsr	(Swing_Setup1).l
		jsr	(AllocateObject).l
		bne.s	loc_7CA78
		move.l	#Obj_Song_Fade_Transition,(a1)
		move.b	#mus_EndBoss,subtype(a1)

loc_7CA78:
		lea	(Child1_MakeRoboHead4).l,a2
		jsr	CreateChild1_Normal(pc)
		lea	ChildObjDat_7D4BC(pc),a2
		jsr	CreateChild1_Normal(pc)
		lea	(Child1_MakeRoboShipFlame).l,a2
		jsr	CreateChild1_Normal(pc)
		lea	(ArtKosM_KnuxFinalBossCrane).l,a1
		move.w	#tiles_to_bytes($4A7),d2
		jsr	(Queue_Kos_Module).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_7CAAA:
		jsr	Swing_UpAndDown(pc)
		jsr	(MoveSprite2).l
		cmpi.w	#$120,x_pos(a0)
		bhs.s	loc_7CACC
		move.l	#loc_7CAD2,(a0)
		clr.w	x_vel(a0)
		bset	#0,(_unkFAB8).w

loc_7CACC:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_7CAD2:
		btst	#1,(_unkFAB8).w
		beq.s	loc_7CAE6
		move.l	#loc_7CAE6,(a0)
		move.w	#-$80,x_vel(a0)

loc_7CAE6:
		btst	#2,(_unkFAB8).w
		beq.s	loc_7CAF8
		move.l	#loc_7CAF8,(a0)
		clr.w	x_vel(a0)

loc_7CAF8:
		btst	#3,(_unkFAB8).w
		beq.s	loc_7CB18
		move.l	#loc_7CB28,(a0)
		move.w	#$80,x_vel(a0)
		bset	#0,render_flags(a0)
		bclr	#0,(Player_1+render_flags).w

loc_7CB18:
		jsr	Swing_UpAndDown(pc)
		jsr	(MoveSprite2).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_7CB28:
		jsr	Swing_UpAndDown(pc)
		jsr	(MoveSprite2).l
		cmpi.w	#$120,x_pos(a0)
		blo.s	loc_7CB5E
		move.l	#loc_7CB64,(a0)
		clr.w	x_vel(a0)
		move.w	#60-1,$2E(a0)
		jsr	(AllocateObject).l
		bne.s	loc_7CB5E
		move.l	#Obj_Song_Fade_Transition,(a1)
		move.b	#mus_FinalBoss,subtype(a1)

loc_7CB5E:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_7CB64:
		subq.w	#1,$2E(a0)
		bne.s	loc_7CB94
		move.l	#loc_7CBA4,(a0)
		st	(Scroll_lock).w
		jsr	(AllocateObject).l
		bne.s	loc_7CB82
		move.l	#loc_7D11C,(a1)

loc_7CB82:
		jsr	(AllocateObject).l
		bne.s	loc_7CB90
		move.l	#Obj_SSZEndBoss,(a1)

loc_7CB90:
		move.w	a1,(_unkFAA4).w

loc_7CB94:
		jsr	Swing_UpAndDown(pc)
		jsr	(MoveSprite2).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_7CBA4:
		movea.w	(_unkFAA4).w,a1
		lea	word_7CC16(pc),a2
		jsr	(Check_InMyRange).l
		beq.s	loc_7CBCE
		move.l	#loc_7CBCE,(a0)
		jsr	(AllocateObject).l
		bne.s	loc_7CBC8
		move.l	#loc_7CC3A,(a1)

loc_7CBC8:
		bset	#5,(_unkFAB8).w

loc_7CBCE:
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		movea.w	(_unkFAA4).w,a1
		lea	word_7CC1E(pc),a2
		jsr	(Check_InMyRange).l
		beq.s	loc_7CC10
		move.l	#Wait_Draw,(a0)
		move.w	#$80,priority(a0)
		move.w	#$3F,$2E(a0)
		move.l	#loc_7CC26,$34(a0)
		lea	(Child6_CreateBossExplosion).l,a2
		jsr	(CreateChild6_Simple).l

loc_7CC10:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
word_7CC16:
		dc.w   -$20,   $40,     0,   $78
word_7CC1E:
		dc.w   -$20,   $40,     0,   $30
; ---------------------------------------------------------------------------

loc_7CC26:
		lea	ChildObjDat_7D4C4(pc),a2
		jsr	CreateChild6_Simple(pc)
		ori.b	#$30,$38(a0)
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

loc_7CC3A:
		move.l	#loc_7CC68,(a0)
		lea	(Player_1).w,a1
		move.w	x_pos(a1),x_pos(a0)
		move.w	y_pos(a1),y_pos(a0)
		move.b	#$C0,mapping_frame(a1)
		move.w	#$400,x_vel(a0)
		move.w	#$80,y_vel(a0)
		jsr	(Player_Load_PLC).l

loc_7CC68:
		jsr	(MoveSprite2).l
		lea	(Player_1).w,a1
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		move.w	x_pos(a0),d0
		cmp.w	(_unkFAB6).w,d0
		blo.w	locret_7B448
		move.l	#loc_7CCB0,(a0)
		move.w	#6,$2E(a0)
		clr.w	x_vel(a0)
		clr.w	y_vel(a0)
		move.b	#$13,y_radius(a0)
		move.b	#$CA,mapping_frame(a1)
		jmp	(Player_Load_PLC).l
; ---------------------------------------------------------------------------

loc_7CCB0:
		subq.w	#1,$2E(a0)
		bne.s	loc_7CCC6
		lea	(Player_1).w,a1
		move.b	#$CB,mapping_frame(a1)
		jsr	(Player_Load_PLC).l

loc_7CCC6:
		jsr	(MoveSprite).l
		lea	(Player_1).w,a1
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		jsr	(ObjCheckFloorDist).l
		tst.w	d1
		bpl.w	locret_7B448
		lea	(Player_1).w,a1
		add.w	d1,y_pos(a1)
		clr.b	$2E(a1)
		jsr	Stop_Object(pc)
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_7CCFE:
		lea	(ObjDat3_664FA).l,a1
		jsr	(SetUp_ObjAttributes).l
		move.w	#0,priority(a0)
		move.l	#loc_7CD22,(a0)
		lea	(ChildObjDat_66610).l,a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_7CD22:
		btst	#0,(_unkFAB8).w
		bne.s	loc_7CD36
		jsr	(Refresh_ChildPositionAdjusted).l
		jmp	(Child_Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_7CD36:
		move.l	#loc_7CD42,(a0)
		move.b	child_dy(a0),$3A(a0)

loc_7CD42:
		lea	(Player_1).w,a1
		move.w	y_pos(a1),d0
		subi.w	#$10,d0
		cmp.w	y_pos(a0),d0
		bls.s	loc_7CD76
		move.b	y_vel(a0),d0
		addi.b	#1,d0
		move.b	d0,y_vel(a0)
		move.b	$3A(a0),d1
		add.b	d0,d1
		move.b	d1,child_dy(a0)
		jsr	(Refresh_ChildPositionAdjusted).l
		jmp	(Child_Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_7CD76:
		move.l	#loc_7CD82,(a0)
		bset	#1,(_unkFAB8).w

loc_7CD82:
		move.b	$3A(a0),d0
		ext.w	d0
		movea.w	parent3(a0),a1
		move.w	y_pos(a1),d1
		add.w	d0,d1
		lea	(Player_1).w,a1
		move.w	y_pos(a1),d2
		subi.w	#$10,d2
		sub.w	d1,d2
		bpl.s	loc_7CDA4
		moveq	#0,d2

loc_7CDA4:
		move.b	d2,y_vel(a0)
		add.b	d2,d0
		bpl.s	loc_7CDB0
		move.b	#$7F,d0

loc_7CDB0:
		move.b	d0,child_dy(a0)
		move.w	x_pos(a0),d0
		cmpi.w	#8,d0
		bls.s	loc_7CDD2
		move.w	x_pos(a1),d1
		subi.w	#$C,d0
		cmp.w	d0,d1
		blo.s	loc_7CE12
		addi.w	#$18,d0
		cmp.w	d0,d1
		bhs.s	loc_7CE12

loc_7CDD2:
		move.l	#loc_7CE1E,(a0)
		bset	#2,(_unkFAB8).w
		move.b	#2,mapping_frame(a0)
		move.b	#$83,object_control(a1)
		move.b	#$CB,mapping_frame(a1)
		bset	#0,render_flags(a1)
		bclr	#Status_OnObj,status(a1)
		clr.b	jumping(a1)
		clr.b	spin_dash_flag(a1)
		jsr	(Player_Load_PLC).l
		moveq	#signextendB(sfx_Grab),d0
		jsr	(Play_SFX).l

loc_7CE12:
		jsr	(Refresh_ChildPositionAdjusted).l
		jmp	(Child_Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_7CE1E:
		move.b	y_vel(a0),d0
		subq.b	#1,d0
		bpl.s	loc_7CE34
		move.l	#loc_7CE42,(a0)
		bset	#3,(_unkFAB8).w
		moveq	#0,d0

loc_7CE34:
		move.b	d0,y_vel(a0)
		move.b	$3A(a0),d1
		add.b	d0,d1
		move.b	d1,child_dy(a0)

loc_7CE42:
		jsr	(Refresh_ChildPositionAdjusted).l
		btst	#5,(_unkFAB8).w
		bne.s	loc_7CE66
		lea	(Player_1).w,a1
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),d0
		addi.w	#$16,d0
		move.w	d0,y_pos(a1)

loc_7CE66:
		jmp	(Child_Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_7CE6C:
		lea	ObjDat3_7D45C(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#Obj_FlickerMove,(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		lsr.w	#1,d0
		move.b	d0,mapping_frame(a0)
		moveq	#8,d0
		jmp	(Set_IndexedVelocity).l
; ---------------------------------------------------------------------------

loc_7CE90:
		lea	ObjDat3_7D468(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_7CF02,(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		lea	byte_7CEE2(pc,d0.w),a1
		move.b	(a1)+,d1
		ext.w	d1
		movea.w	parent3(a0),a2
		btst	#0,render_flags(a2)
		beq.s	loc_7CEC2
		neg.w	d2
		bset	#0,render_flags(a0)

loc_7CEC2:
		add.w	d1,x_pos(a0)
		move.b	(a1)+,d2
		ext.w	d2
		add.w	d2,y_pos(a0)
		asl.w	#5,d1
		move.w	d1,x_vel(a0)
		asl.w	#4,d2
		move.w	d2,y_vel(a0)
		lsr.w	#1,d0
		move.b	d0,mapping_frame(a0)
		rts
; ---------------------------------------------------------------------------
byte_7CEE2:
		dc.b -$14,-$24
		dc.b  -$C,-$28
		dc.b  -$C,-$18
		dc.b   -4,-$28
		dc.b   -4,-$18
		dc.b    4,-$28
		dc.b    4,-$18
		dc.b   $C,-$28
		dc.b   $C,-$18
		dc.b  $14,-$20
		dc.b  $14,-$10
		dc.b -$14,  -4
		dc.b  -$C,  -8
		dc.b   -4,  -8
		dc.b    4,  -8
		dc.b   $C,  -8
		even
; ---------------------------------------------------------------------------

loc_7CF02:
		tst.b	(_unkFAA2).w
		bne.s	loc_7CF0E
		jmp	(Obj_FlickerMove).l
; ---------------------------------------------------------------------------

loc_7CF0E:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_7CF14:
		move.b	subtype(a0),d0
		subq.b	#2,d0
		bpl.s	loc_7CF4E
		move.w	(Camera_X_pos).w,d0
		addi.w	#$A0,d0
		move.w	d0,x_pos(a0)
		move.w	(Camera_Y_pos).w,d0
		addi.w	#$D0,d0
		move.w	d0,y_pos(a0)
		lea	(Child6_CreateBossExplosion).l,a2
		jsr	(CreateChild6_Simple).l
		bne.s	loc_7CF48
		move.b	#$C,subtype(a1)

loc_7CF48:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_7CF4E:
		move.l	#loc_7CF7C,(a0)
		addi.w	#$30,y_pos(a0)
		moveq	#2,d1
		tst.b	d0
		bne.s	loc_7CF62
		neg.w	d1

loc_7CF62:
		move.w	d1,x_vel(a0)
		lea	(Child6_CreateBossExplosion).l,a2
		jsr	(CreateChild6_Simple).l
		bne.s	locret_7CF7A
		move.b	#$1E,subtype(a1)

locret_7CF7A:
		rts
; ---------------------------------------------------------------------------

loc_7CF7C:
		move.w	x_vel(a0),d0
		move.w	x_pos(a0),d1
		add.w	d0,d1
		move.w	d1,x_pos(a0)
		move.w	(Camera_X_pos).w,d0
		subi.w	#$10,d0
		cmp.w	d0,d1
		blo.w	loc_7C8F8
		addi.w	#$160,d0
		cmp.w	d0,d1
		bhi.w	loc_7C8F8
		rts
; ---------------------------------------------------------------------------

Obj_Difficulty_MechaSonic:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	Difficulty_MechaSonic_Index(pc,d0.w),d1
		jsr	Difficulty_MechaSonic_Index(pc,d1.w)
		lea	DPLCPtr_MechaSonic(pc),a2
		jsr	(Perform_DPLC).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
Difficulty_MechaSonic_Index:
		dc.w Difficulty_MechaSonic_Init-Difficulty_MechaSonic_Index
		dc.w Difficulty_MechaSonic_Return-Difficulty_MechaSonic_Index
; ---------------------------------------------------------------------------

Difficulty_MechaSonic_Init:
		lea	ObjSlot_MechaSonic(pc),a1
		jsr	(SetUp_ObjAttributesSlotted).l
		move.w	#make_art_tile($3F4,2,0),art_tile(a0)
		bclr	#2,render_flags(a0)
		bset	#0,render_flags(a0)
		move.w	#$D8,x_pos(a0)
		move.w	#$104,y_pos(a0)

Difficulty_MechaSonic_Return:
		rts
; ---------------------------------------------------------------------------

Obj_Difficulty_MasterEmerald:
		move.l	#Map_SSZMasterEmerald,mappings(a0)
		move.w	#make_art_tile($1EE,3,0),art_tile(a0)
		move.w	#$280,priority(a0)
		move.b	#$20,width_pixels(a0)
		move.b	#$18,height_pixels(a0)
		move.b	#2,mapping_frame(a0)
		move.w	#$120,x_pos(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		move.w	word_7D03E(pc,d0.w),y_pos(a0)
		move.l	#loc_7D042,(a0)
		cmpi.b	#7,(Super_emerald_count).w
		beq.s	locret_7D03C
		move.l	#loc_7D050,(a0)

locret_7D03C:
		rts
; ---------------------------------------------------------------------------
word_7D03E:
		dc.w    $F0,  $120
; ---------------------------------------------------------------------------

loc_7D042:
		lea	off_7DD5A(pc),a1
		lea	(Normal_palette_line_4+$1C).w,a2
		jsr	(Run_PalRotationScript2).l

loc_7D050:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_7D056:
		move.l	#loc_7D062,(a0)
		move.w	#(2*60)-1,$2E(a0)

loc_7D062:
		moveq	#2,d0
		jsr	(sub_868F8).l
		tst.b	routine(a0)
		beq.s	locret_7D076
		move.l	#loc_7D078,(a0)

locret_7D076:
		rts
; ---------------------------------------------------------------------------

loc_7D078:
		jsr	(Check_TailsEndPose).l
		tst.b	(_unkFAA8).w
		bne.w	locret_7B448
		jsr	(Restore_PlayerControl).l
		lea	(Player_2).w,a1
		jsr	(Restore_PlayerControl2).l
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_7D09C:
		move.b	#2,$39(a0)
		move.l	#loc_7D0A8,(a0)

loc_7D0A8:
		subq.w	#1,$2E(a0)
		bpl.s	locret_7D0CA
		move.w	#5,$2E(a0)
		lea	(Normal_palette).w,a1
		moveq	#$40-1,d0

loc_7D0BA:
		jsr	(sub_85EB4).l
		dbf	d0,loc_7D0BA
		subq.b	#1,$39(a0)
		bmi.s	loc_7D0CC

locret_7D0CA:
		rts
; ---------------------------------------------------------------------------

loc_7D0CC:
		move.l	#loc_7D0E0,(a0)
		move.b	#2,$39(a0)
		move.w	#30-1,$2E(a0)
		rts
; ---------------------------------------------------------------------------

loc_7D0E0:
		subq.w	#1,$2E(a0)
		bpl.s	locret_7D0CA
		move.w	#3,$2E(a0)
		lea	(Normal_palette).w,a1
		lea	(Target_palette).w,a2
		moveq	#$40-1,d0

loc_7D0F6:
		jsr	(sub_85F2A).l
		dbf	d0,loc_7D0F6
		subq.b	#1,$39(a0)
		bpl.s	locret_7D0CA
		lea	(Target_palette).w,a1
		lea	(Normal_palette).w,a2
		moveq	#bytesToLcnt($80),d6

loc_7D110:
		move.l	(a1)+,(a2)+
		dbf	d6,loc_7D110
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

loc_7D11C:
		move.w	#$100,d0
		cmp.w	(Camera_X_pos).w,d0
		bls.s	loc_7D134
		addq.w	#1,(Camera_X_pos).w
		addq.w	#1,(Camera_min_X_pos).w
		addq.w	#1,(Camera_max_X_pos).w
		rts
; ---------------------------------------------------------------------------

loc_7D134:
		move.w	d0,(Camera_X_pos).w
		move.w	d0,(Camera_min_X_pos).w
		move.w	d0,(Camera_max_X_pos).w
		clr.b	(Scroll_lock).w
		bset	#4,(_unkFAB8).w
		jmp	(Delete_Current_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_7D150:
		lea	(Player_1).w,a1
		clr.w	x_vel(a1)
		clr.w	y_vel(a1)
		clr.w	ground_vel(a1)
		rts
; End of function sub_7D150


; =============== S U B R O U T I N E =======================================


sub_7D162:
		moveq	#0,d0
		move.b	subtype(a0),d0
		add.w	d0,d0
		move.l	word_7D172(pc,d0.w),x_vel(a0)	; and y_vel
		rts
; End of function sub_7D162

; ---------------------------------------------------------------------------
word_7D172:
		dc.w      0,  $400
		dc.w   $2D4,  $2D4
		dc.w   $400,     0
		dc.w   $2D4, -$2D4
		dc.w      0, -$400
		dc.w  -$2D4, -$2D4
		dc.w  -$400,     0
		dc.w  -$2D4,  $2D4

; =============== S U B R O U T I N E =======================================


sub_7D192:
		moveq	#0,d0
		move.b	subtype(a0),d0
		lea	off_7D1A6(pc,d0.w),a1
		move.l	(a1)+,$30(a0)
		move.l	(a1)+,$34(a0)
		rts
; End of function sub_7D192

; ---------------------------------------------------------------------------
off_7D1A6:
		dc.l byte_7D68C
		dc.l loc_7C764
		dc.l byte_7D6B3
		dc.l Go_Delete_Sprite

; =============== S U B R O U T I N E =======================================


sub_7D1B6:
		bsr.w	sub_7D1EA
		moveq	#0,d0
		move.b	child_dx(a0),d0
		lsl.w	#2,d0
		lea	byte_7D1D2-4(pc,d0.w),a1

loc_7D1C6:
		move.b	(a1)+,d1
		beq.s	locret_7D1D0
		cmp.b	d1,d2
		bne.s	loc_7D1C6
		moveq	#1,d0

locret_7D1D0:
		rts
; End of function sub_7D1B6

; ---------------------------------------------------------------------------
byte_7D1D2:
		dc.b    1
		dc.b    0
		dc.b    0
		dc.b    0
		dc.b    1
		dc.b    2
		dc.b    0
		dc.b    0
		dc.b    1
		dc.b    2
		dc.b    3
		dc.b    0
		dc.b    4
		dc.b    5
		dc.b    6
		dc.b    0
		dc.b    5
		dc.b    6
		dc.b    0
		dc.b    0
		dc.b    6
		dc.b    0
		dc.b    0
		dc.b    0
		even

; =============== S U B R O U T I N E =======================================


sub_7D1EA:
		move.w	(Player_1+x_pos).w,d0
		sub.w	(Camera_min_X_pos).w,d0
		move.w	d0,d1
		subi.w	#$F0,d1
		scc	d3
		bcc.s	loc_7D202
		moveq	#1,d2
		bra.w	loc_7D204
; ---------------------------------------------------------------------------

loc_7D202:
		moveq	#4,d2

loc_7D204:
		cmpi.w	#$50,d0
		blo.s	locret_7D214
		addq.w	#1,d2
		cmpi.w	#$A0,d0
		blo.s	locret_7D214
		addq.w	#1,d2

locret_7D214:
		rts
; End of function sub_7D1EA

; ---------------------------------------------------------------------------

loc_7D216:
		tst.w	x_vel(a0)
		bmi.s	loc_7D228
		move.w	(_unkFAB6).w,d0
		cmp.w	x_pos(a0),d0
		bls.s	loc_7D234
		rts
; ---------------------------------------------------------------------------

loc_7D228:
		move.w	(_unkFAB4).w,d0
		cmp.w	x_pos(a0),d0
		bhs.s	loc_7D234
		rts
; ---------------------------------------------------------------------------

loc_7D234:
		jmp	(a1)

; =============== S U B R O U T I N E =======================================


sub_7D236:
		moveq	#0,d0
		move.b	subtype(a0),d0
		add.w	d0,d0
		lea	byte_7D24C(pc,d0.w),a1
		move.w	(a1)+,child_dx(a0)	; and child_dy
		move.w	(a1)+,priority(a0)
		rts
; End of function sub_7D236

; ---------------------------------------------------------------------------
byte_7D24C:
		dc.b   -4, $1C
		dc.w   $300
		dc.b    8, $1C
		dc.w   $200
		dc.b   -8, $1C
		dc.w   $200
		dc.b    4, $1C
		dc.w   $300
		dc.b   $C,  $C
		dc.w   $200

; =============== S U B R O U T I N E =======================================


sub_7D260:
		lea	byte_7D280(pc),a1
		movea.w	parent3(a0),a2
		moveq	#0,d0
		move.b	mapping_frame(a2),d0
		lsl.w	#2,d0
		adda.w	d0,a1
		move.w	(a1)+,child_dx(a0)	; and child_dy
		move.b	(a1)+,collision_flags(a0)
		move.b	(a1)+,mapping_frame(a0)
		rts
; End of function sub_7D260

; ---------------------------------------------------------------------------
byte_7D280:
		dc.b  $10, -$C, $B4,   2
		dc.b  $10,  -4, $B4,   2
		dc.b  $10,   0, $B4,   2
		dc.b    0,   0,   0,   0
		dc.b    0,   0,   0,   0
		dc.b    0,   0,   0,   0
		dc.b    0,   0,   0,   0
		dc.b  $14,  -8, $9E,   1
		dc.b  $10, -$C, $9E,   1
		dc.b   $C,-$14, $98,   0
		dc.b    0,-$14, $B3,   8
		dc.b  -$C,-$14, $98,   0
		dc.b -$10, -$C, $B4,   2
		dc.b  $10, -$C, $B4,   2
		dc.b  $10,   4, $B4,   2
		dc.b  $14,  $C, $B4,   2
		dc.b  $17,   5, $B4,   2
		dc.b  $10, -$C, $B4,   2
		dc.b   $C, -$C, $9E,   1
		dc.b  $10, -$C, $B4,   2
		dc.b  $10, -$C, $B4,   2
		dc.b  $10, -$C, $B4,   2
		even

; =============== S U B R O U T I N E =======================================


sub_7D2D8:
		btst	#6,status(a0)
		bne.s	locret_7D2FA
		moveq	#0,d0
		move.b	mapping_frame(a0),d0
		move.b	byte_7D2FC(pc,d0.w),d0
		btst	#7,$38(a0)
		beq.s	loc_7D2F6
		ori.b	#$80,d0

loc_7D2F6:
		move.b	d0,collision_flags(a0)

locret_7D2FA:
		rts
; End of function sub_7D2D8

; ---------------------------------------------------------------------------
byte_7D2FC:
		dc.b  $23
		dc.b  $23
		dc.b    9
		dc.b  $86
		dc.b  $86
		dc.b  $86
		dc.b  $86
		dc.b  $1A
		dc.b  $23
		dc.b  $23
		dc.b  $23
		dc.b  $23
		dc.b  $23
		dc.b  $23
		dc.b    9
		dc.b    0
		dc.b    9
		dc.b  $23
		dc.b    6
		dc.b  $23
		dc.b  $23
		dc.b  $23
		even

; =============== S U B R O U T I N E =======================================


sub_7D312:
		tst.b	collision_flags(a0)
		bne.s	locret_7D356
		move.b	collision_property(a0),d0
		beq.s	loc_7D358
		tst.b	$20(a0)
		bne.s	loc_7D338
		move.b	#$20,$20(a0)
		moveq	#signextendB(sfx_BossHit),d0
		jsr	(Play_SFX).l
		bset	#6,status(a0)

loc_7D338:
		moveq	#0,d0
		btst	#0,$20(a0)
		bne.s	loc_7D346
		; Bug: this should be 2*5
		addi.w	#2*4,d0

loc_7D346:
		bsr.w	sub_7D3BE
		subq.b	#1,$20(a0)
		bne.s	locret_7D356
		bclr	#6,status(a0)

locret_7D356:
		rts
; ---------------------------------------------------------------------------

loc_7D358:
		jmp	(a4)
; End of function sub_7D312


; =============== S U B R O U T I N E =======================================


sub_7D35A:
		move.l	#loc_7B81A,(a0)
		clr.b	routine(a0)
		move.l	#loc_7B858,$34(a0)
		bset	#6,status(a0)
		clr.b	(Update_HUD_timer).w
		move.w	#$7F,$2E(a0)
		moveq	#100,d0
		jsr	(HUD_AddToScore).l
		bclr	#7,render_flags(a0)
		lea	(Child6_CreateBossExplosion).l,a2
		jsr	CreateChild1_Normal(pc)
		bne.s	locret_7D39C
		move.b	#4,subtype(a1)

locret_7D39C:
		rts
; End of function sub_7D35A

; ---------------------------------------------------------------------------

loc_7D39E:
		bset	#7,$38(a0)
		bsr.s	sub_7D35A
		move.w	(Camera_X_pos).w,d0
		move.w	d0,(Camera_min_X_pos).w
		move.w	d0,(Camera_max_X_pos).w
		lea	(Pal_SSZGHZMisc).l,a1
		jmp	(PalLoad_Line1).l

; =============== S U B R O U T I N E =======================================


sub_7D3BE:
		lea	word_7D3CC(pc),a1
		lea	word_7D3D6(pc,d0.w),a2
		jmp	(CopyWordData_5).l
; End of function sub_7D3BE

; ---------------------------------------------------------------------------
word_7D3CC:
		dc.w Normal_palette_line_2+$08, Normal_palette_line_2+$14, Normal_palette_line_2+$16, Normal_palette_line_2+$18, Normal_palette_line_2+$1C
word_7D3D6:
		dc.w      8,  $A24,  $624,  $422,   $20
		dc.w   $888,  $666,  $888,  $AAA,  $EEE
ObjSlot_MechaSonic:
		dc.w 3-1
		dc.w make_art_tile($3F4,1,1)
		dc.w    $28,     0
		dc.l Map_MechaSonic
		dc.w   $280
		dc.b  $20, $20,   0, $23
word_7D3FC:
		dc.w    $80
		dc.b  $10, $10,   0,   0
ObjDat3_7D402:
		dc.l Map_MechaSonicExtra
		dc.w make_art_tile($41C,0,1)
		dc.w   $200
		dc.b   $C,   4,   0,   0
ObjDat_MechaSonic_Sparks:
		dc.l Map_MechaSonicExtra
		dc.w make_art_tile($41C,1,1)
		dc.w   $200
		dc.b  $14, $10,   4,   0
ObjDat3_7D41A:
		dc.l Map_MechaSonicExtra
		dc.w make_art_tile($41C,1,1)
		dc.w   $200
		dc.b    4,   4, $11,   0
ObjDat3_7D426:
		dc.l Map_MechaSonicExtra
		dc.w make_art_tile($41C,1,1)
		dc.w   $280
		dc.b  $18, $18,   8,   0
word_7D432:
		dc.w   $280
		dc.b    4,   4,   8,   0
ObjDat3_7D438:
		dc.l Map_MechaSonicExtra
		dc.w make_art_tile($41C,1,1)
		dc.w   $200
		dc.b  $18, $18,  $A, $86
ObjDat3_7D444:
		dc.l Map_MechaSonicExtra
		dc.w make_art_tile($41C,1,1)
		dc.w   $280
		dc.b    8,   8, $15, $87
ObjDat3_7D450:
		dc.l Map_SSZMasterEmerald
		dc.w make_art_tile($52E,0,1)
		dc.w   $300
		dc.b  $20, $18,   0,   0
ObjDat3_7D45C:
		dc.l Map_RoboshipPieces
		dc.w make_art_tile($52E,0,1)
		dc.w      0
		dc.b  $1C, $20,   0,   0
ObjDat3_7D468:
		dc.l Map_MechaSonicPieces
		dc.w make_art_tile($3F4,1,1)
		dc.w      0
		dc.b    4,   8,   0,   0
ChildObjDat_7D474:
		dc.w 1-1
		dc.l loc_7C9BA
ChildObjDat_7D47A:
		dc.w 1
		dc.l loc_7C902
ChildObjDat_7D480:
		dc.w 1-1
		dc.l loc_7C902
ChildObjDat_7D486:
		dc.w 2-1
		dc.l loc_7C8FE
ChildObjDat_7D48C:
		dc.w 1-1
		dc.l Obj_MechaSonic_Sparks
ChildObjDat_7D492:
		dc.w 1-1
		dc.l loc_7C886
		dc.b   -4,  $C
ChildObjDat_7D49A:
		dc.w 1-1
		dc.l loc_7C78E
		dc.b  $14,  -4
ChildObjDat_7D4A2:
		dc.w 1-1
		dc.l loc_7C7D4
ChildObjDat_7D4A8:
		dc.w 8-1
		dc.l loc_7C726
ChildObjDat_7D4AE:
		dc.w 1-1
		dc.l loc_7C744
		dc.b   -7,  -8
		dc.w 1-1
		dc.l loc_7C818
ChildObjDat_7D4BC:
		dc.w 1-1
		dc.l loc_7CCFE
		dc.b    0, $23
ChildObjDat_7D4C4:
		dc.w 4-1
		dc.l loc_7CE6C
ChildObjDat_7D4CA:
		dc.w $10-1
		dc.l loc_7CE90
ChildObjDat_7D4D0:
		dc.w 3-1
		dc.l loc_7CF14
DPLCPtr_MechaSonic:
		dc.l ArtUnc_MechaSonic
		dc.l DPLC_MechaSonic
byte_7D4DE:
		dc.b    3,   0
		dc.b    4,   1
		dc.b    5,   2
		dc.b    6,   3
		dc.b    7,   4
		dc.b    8,   5
		dc.b  $F8,  $E
		dc.b    8, $7F
		dc.b  $FC
byte_7D4EF:
		dc.b    3,   0
		dc.b    4,   1
		dc.b    5,   2
		dc.b    6,   3
		dc.b    7,   4
		dc.b    8,   4
		dc.b    9,   4
		dc.b   $A,   4
		dc.b   $B,   4
		dc.b   $C,   4
		dc.b  $F8, $16
		dc.b   $C, $7F
		dc.b  $FC
byte_7D508:
		dc.b  $13,   5
		dc.b  $13,   5
		dc.b    8, $7F
		dc.b  $F8, $E4
byte_7D510:
		dc.b    1,   5
		dc.b    1,   5
		dc.b    2,   9
		dc.b    1,   5
		dc.b  $F4
byte_7D519:
		dc.b    3,   1
		dc.b    3,   1
		dc.b    4,   1
		dc.b    5,   1
		dc.b  $F8,  $A
byte_7D523:
		dc.b    3,   0
		dc.b    4,   0
		dc.b    5,   0
		dc.b  $FC
byte_7D52A:
		dc.b    8,   0
		dc.b    7,   3
		dc.b    6,   3
		dc.b    3,   1
		dc.b    4,   1
		dc.b    5,   1
		dc.b  $F8, $F9
byte_7D538:
		dc.b    6,   3
		dc.b    6,   3
		dc.b    7,   3
		dc.b    8, $1F
		dc.b  $F4
byte_7D541:
		dc.b    0,   0
		dc.b    1,   5
		dc.b    2,   9
		dc.b    1,   0
		dc.b  $F4
byte_7D54A:
		dc.b    1,   0
		dc.b    1,   1
		dc.b    3,   1
		dc.b    4,   1
		dc.b    5,   1
		dc.b  $F8, $D9
byte_7D556:
		dc.b  $12,   0
		dc.b  $12,   5
		dc.b   $D,   3
		dc.b    8,   5
		dc.b    1,   1
		dc.b  $F4
byte_7D561:
		dc.b    1,   3
		dc.b    1,   7
		dc.b    2,   7
		dc.b    1,   3
		dc.b    8,   0
		dc.b  $F4
byte_7D56C:
		dc.b     8,   5
		dc.b     8,   5
		dc.b     9,   3
		dc.b    $A,   3
		dc.b    $B,   3
		dc.b    $C,   3
		dc.b $40|8, $7F
		dc.b   $F8, $80
byte_7D57C:
		dc.b    8,   5
		dc.b  $13,   5
		dc.b  $14, $7F
		dc.b  $F8,   8
		dc.b  $15, $7F
		dc.b  $FC
byte_7D587:
		dc.b    1,   5
		dc.b    1,   5
		dc.b  $10,  $F
		dc.b    1,   5
		dc.b  $11, $17
		dc.b    0,   5
		dc.b    8,   3
		dc.b  $F4
byte_7D596:
		dc.b    1,   5
		dc.b    2, $1F
		dc.b  $F4
byte_7D59B:
		dc.b    2,   0
		dc.b    1,   5
		dc.b    0, $3F
		dc.b  $F4
byte_7D5A2:
		dc.b    1,   5
		dc.b    2,   9
		dc.b    1,   5
		dc.b    0, $3F
		dc.b  $F4
byte_7D5AB:
		dc.b    1,   5
		dc.b    1,   5
		dc.b    2,   9
		dc.b  $13,   5
		dc.b  $15,   3
		dc.b  $F4
byte_7D5B6:
		dc.b    1,   5
		dc.b    1,   5
		dc.b    2,   9
		dc.b  $13,   5
		dc.b  $15, $7F
		dc.b  $F4
byte_7D5C1:
		dc.b    3,   1
		dc.b    3,   1
		dc.b    4,   1
		dc.b    5,   1
		dc.b    6,   3
		dc.b    7,   4
		dc.b    8,   3
		dc.b    1,   5
		dc.b    2,   9
		dc.b    1,   5
		dc.b    0,   3
		dc.b  $F4
byte_7D5D8:
		dc.b   $C,   3
		dc.b   $C,   3
		dc.b   $A,   3
		dc.b    9,   3
		dc.b    8,   3
		dc.b  $F8, $42
byte_7D5E4:
		dc.b   $E,   5
		dc.b   $E,   5
		dc.b   $F,   3
		dc.b  $F8,   8
		dc.b   $F, $7F
		dc.b  $FC
byte_7D5EF:
		dc.b   $F,   5
		dc.b   $E,   5
		dc.b    2,   1
		dc.b  $F4
byte_7D5F6:
		dc.b    2,   5
		dc.b    2,  $F
		dc.b    1,   5
		dc.b    8,   0
		dc.b  $F4
byte_7D5FF:
		dc.b    1,   3
		dc.b    1,   3
		dc.b    2,  $F
		dc.b    1,   3
		dc.b    8,   0
		dc.b  $F4
byte_7D60A:
		dc.b     8,   7
		dc.b     8,   7
		dc.b     9,   5
		dc.b    $A,   5
		dc.b    $B,   5
		dc.b    $C,   5
		dc.b $40|8, $7F
		dc.b   $F8, $10
byte_7D61A:
		dc.b    8, $7F
		dc.b  $FC
		dc.b    2,   5
		dc.b    2,   5
		dc.b    1,   5
		dc.b    8,   0
		dc.b  $F4
byte_7D626:
		dc.b     8,   1
		dc.b     8,   1
		dc.b     9,   1
		dc.b    $A,   1
		dc.b    $B,   1
		dc.b    $C,   0
		dc.b $40|8, $7F
		dc.b   $F8, $24
byte_7D636:
		dc.b     8,   3
		dc.b     8,   3
		dc.b     9,   3
		dc.b    $A,   3
		dc.b    $B,   3
		dc.b    $C,   3
		dc.b $40|8,   3
		dc.b   $F4
byte_7D645:
		dc.b    8,   3
		dc.b    8,  $F
		dc.b    1,   5
		dc.b  $10,  $F
		dc.b    1,   5
		dc.b  $11,   0
		dc.b  $F4
byte_7D652:
		dc.b    8,   1
		dc.b    8,   1
		dc.b   $D,   5
		dc.b  $12, $7F
		dc.b  $F8,  $A
		dc.b  $12, $7F
		dc.b  $FC
byte_7D65F:
		dc.b    1,   1
		dc.b    2,   1
		dc.b    3,   1
		dc.b    0,   0
		dc.b  $FC
byte_7D668:
		dc.b  $11,   3
		dc.b  $11,   3
		dc.b    0,   3
		dc.b  $11,   3
		dc.b    0,   3
		dc.b  $11,   3
		dc.b  $12, $1B
		dc.b  $13,   5
		dc.b  $14, $3F
		dc.b  $F4
byte_7D67B:
		dc.b    0,   0,   8,   9,   0, $17, $18, $FC
byte_7D683:
		dc.b   $E,   1
		dc.b   $E,   1
		dc.b   $F,   2
		dc.b  $10,   3
		dc.b  $F4
byte_7D68C:
		dc.b    0
		dc.b   $A,  $A,   0
		dc.b   $A,  $B,   0
		dc.b   $A,  $C,   0
		dc.b   $A,  $B,   0
		dc.b   $A,  $D,   0
		dc.b  $19,  $D,   0
		dc.b   $B,  $D,   0
		dc.b  $F4
byte_7D6A3:
		dc.b    0
		dc.b    0,  $D, $16
		dc.b    0,  $D,  $C, $16
		dc.b    0,  $D, $16
		dc.b    0,  $D, $19, $16
		dc.b  $FC
byte_7D6B3:
		dc.b    0
		dc.b   $B,  $B,  $D,   0
		dc.b   $B,  $D,   0
		dc.b   $B,  $D,   0
		dc.b   $A,  $B,   0
		dc.b   $A,  $B,   0
		dc.b   $A,  $B,   0
		dc.b   $A,   0
		dc.b   $A,   0
		dc.b   $A,   0
		dc.b   $A,   0
		dc.b   $A,   0
		dc.b   $A,   0
		dc.b   $A,   0
		dc.b   $A,   0
		dc.b  $F4
		even
Map_RoboshipPieces:
		include "General/Sprites/Robotnik/Map - Robotnik Ship Pieces.asm"
Map_SSZMasterEmerald:
		include "General/Sprites/SSZ Master Emerald/Map - Master Emerald.asm"
Map_MechaSonicPieces:
		include "General/Sprites/Mecha Sonic/Map - Mecha Sonic Pieces.asm"

word_7D842:	palscriptptr .header, .data
		dc.w 0
.header	palscripthdr	Normal_palette_line_2+$00, 16, 0
.data	palscriptfile	50,"General/Sprites/Mecha Sonic/Palettes/Main.bin"
	palscriptfile	2, "General/Sprites/Mecha Sonic/Palettes/Flash 2.bin"
	palscriptfile	1, "General/Sprites/Mecha Sonic/Palettes/Flash 1.bin"
	palscriptfile	5, "General/Sprites/Mecha Sonic/Palettes/Main.bin"
	palscriptfile	2, "General/Sprites/Mecha Sonic/Palettes/Flash 2.bin"
	palscriptfile	1, "General/Sprites/Mecha Sonic/Palettes/Flash 1.bin"
	palscriptfile	50,"General/Sprites/Mecha Sonic/Palettes/Main.bin"
	palscriptfile	2, "General/Sprites/Mecha Sonic/Palettes/Flash 2.bin"
	palscriptfile	1, "General/Sprites/Mecha Sonic/Palettes/Flash 1.bin"
	palscriptfile	20,"General/Sprites/Mecha Sonic/Palettes/Main.bin"
	palscriptfile	2, "General/Sprites/Mecha Sonic/Palettes/Flash 2.bin"
	palscriptfile	1, "General/Sprites/Mecha Sonic/Palettes/Flash 1.bin"
	palscriptrept

Pal_SSZGHZMisc =	word_7D842.data			; yeah Sonic 3 is a fun game

word_7D9EA:	palscriptptr .header, .data
		dc.w 0
.header	palscripthdr	Normal_palette_line_2+$00, 16, 0
.data	palscriptfile	3, "General/Sprites/Mecha Sonic/Palettes/Main.bin"
	palscriptfile	2, "General/Sprites/Mecha Sonic/Palettes/Flash 2.bin"
	palscriptfile	1, "General/Sprites/Mecha Sonic/Palettes/Flash 1.bin"
	palscriptrept

word_7DA60:	palscriptptr .header, .data
		dc.w 0
.header	palscripthdr	Normal_palette_line_2+$00, 16, 2-1
.data	palscriptfile	6, "General/Sprites/Mecha Sonic/Palettes/Flash 1.bin"
	palscriptfile	6, "General/Sprites/Mecha Sonic/Palettes/Flash 2.bin"
	palscriptfile	30,"General/Sprites/Mecha Sonic/Palettes/Flash 3.bin"
	palscriptloop	.headr2
.headr2	palscripthdr	Normal_palette_line_2+$00, 16, 0
	palscriptfile	6, "General/Sprites/Mecha Sonic/Palettes/Super 1.bin"
	palscriptfile	6, "General/Sprites/Mecha Sonic/Palettes/Super 2.bin"
	palscriptfile	6, "General/Sprites/Mecha Sonic/Palettes/Super 3.bin"
	palscriptfile	6, "General/Sprites/Mecha Sonic/Palettes/Super 2.bin"
	palscriptrept

word_7DB66:	palscriptptr .header, .data
		dc.w 0
.header	palscripthdr	Normal_palette_line_2+$00, 16, 2-1
.data	palscriptfile	6,  "General/Sprites/Mecha Sonic/Palettes/Flash 2.bin"
	palscriptfile	6,  "General/Sprites/Mecha Sonic/Palettes/Flash 1.bin"
	palscriptfile	128,"General/Sprites/Mecha Sonic/Palettes/Main.bin"
	palscriptloop	.headr2
.headr2	palscripthdr	Normal_palette_line_2+$00, 16, 0
	palscriptfile	128,"General/Sprites/Mecha Sonic/Palettes/Main.bin"
	palscriptrept


word_7DC06:	palscriptptr .header, .data
		dc.w 0
.header	palscripthdr	Normal_palette_line_2+$00, 16, 2-1
.data	palscriptfile	8, "General/Sprites/Mecha Sonic/Palettes/Main.bin"
	palscriptfile	8, "General/Sprites/Mecha Sonic/Palettes/Flash 2.bin"
	palscriptfile	8, "General/Sprites/Mecha Sonic/Palettes/Flash 1.bin"
	palscriptloop	word_7DA60.headr2

word_7DC7E:	palscriptptr .header, .data
		dc.w 0
.header	palscripthdr	Normal_palette_line_2+$00, 16, 2-1
.data	palscriptfile	2, "General/Sprites/Mecha Sonic/Palettes/Flash 2.bin"
	palscriptfile	2, "General/Sprites/Mecha Sonic/Palettes/Flash 1.bin"
	palscriptfile	2, "General/Sprites/Mecha Sonic/Palettes/Main.bin"
	palscriptfile	4, "General/Sprites/Mecha Sonic/Palettes/Flash 2.bin"
	palscriptfile	4, "General/Sprites/Mecha Sonic/Palettes/Flash 1.bin"
	palscriptfile	4, "General/Sprites/Mecha Sonic/Palettes/Main.bin"
	palscriptrun

off_7DD5A:
		dc.l off_7DD7A
		dc.w 2-1
		dc.b    0,  $F
		dc.b    1,   9
		dc.b    2,   9
		dc.b    3,   7
		dc.b    4,   7
		dc.b    5,   5
		dc.b    6,   5
		dc.b    5,   5
		dc.b    4,   7
		dc.b    3,   7
		dc.b    2,   9
		dc.b    1,   9
		dc.b  $FF, $FC
off_7DD7A:
		dc.w word_7DD88-off_7DD7A
		dc.w word_7DD8C-off_7DD7A
		dc.w word_7DD90-off_7DD7A
		dc.w word_7DD94-off_7DD7A
		dc.w word_7DD98-off_7DD7A
		dc.w word_7DD9C-off_7DD7A
		dc.w word_7DDA0-off_7DD7A
word_7DD88:
		dc.w   $480,  $6A0
word_7DD8C:
		dc.w   $680,  $8A0
word_7DD90:
		dc.w   $680,  $8C0
word_7DD94:
		dc.w   $6A0,  $AC0
word_7DD98:
		dc.w   $8A0,  $AE0
word_7DD9C:
		dc.w   $8C0,  $CE0
word_7DDA0:
		dc.w   $AC0,  $EE0
; ---------------------------------------------------------------------------

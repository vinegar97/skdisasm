; ---------------------------------------------------------------------------
AIZBossSonicDat:
		dc.w  $4880, $48E0,  $15A
AIZBossKnuxDat:
		dc.w  $4100, $4160,  $5DA
; ---------------------------------------------------------------------------

Obj_AIZEndBoss:
		move.l	#Obj_AIZEndBossWait,(a0)
		lea	AIZBossSonicDat(pc),a1
		cmpi.b	#2,(Player_1+character_id).w
		bne.s	+ ;loc_691BE
		lea	AIZBossKnuxDat(pc),a1

+ ;loc_691BE:
		lea	(_unkFA82).w,a2
		move.w	(a1)+,(a2)+
		move.w	(a1)+,(a2)+
		move.w	(a1)+,(a2)+			; Load relative positional data depending on the character

Obj_AIZEndBossWait:
		move.w	(_unkFA82).w,d0
		cmp.w	(Camera_X_pos).w,d0
		bls.s	+ ;loc_691D4			; Only branch if Sonic has reached the boss area
		rts
; ---------------------------------------------------------------------------

+ ;loc_691D4:
		move.w	d0,(Camera_min_X_pos).w
		move.w	d0,(Camera_max_X_pos).w
		move.l	#Obj_Wait,(a0)			; Set up object to wait $78 frames
		move.w	#2*60,$2E(a0)
		move.l	#Obj_AIZEndBossMusic,$34(a0)
		moveq	#signextendB(mus_FadeOut),d0
		jsr	(Play_Music).l
		move.b	#1,(Boss_flag).w		; Lock the screen
		clr.b	(_unkFAA2).w
		clr.b	(_unkFAA3).w
		moveq	#$6B,d0
		jsr	(Load_PLC).l					; Load Robotnik's ship and explosions
		lea	(ArtKosM_AIZEndBoss).l,a1
		move.w	#tiles_to_bytes($180),d2
		jsr	(Queue_Kos_Module).l		; Load the AIZ boss ship
		lea	Pal_AIZEndBoss(pc),a1
		jmp	(PalLoad_Line1).l				; Load the AIZ boss palette
; ---------------------------------------------------------------------------

Obj_AIZEndBossMusic:
		move.l	#Obj_AIZEndBossMain,(a0)
		moveq	#signextendB(mus_EndBoss),d0					; Play the boss music
		jsr	(Play_Music).l
		move.b	#mus_EndBoss,(Current_music+1).w
		rts
; ---------------------------------------------------------------------------

Obj_AIZEndBossMain:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	.Index(pc,d0.w),d1
		jsr	.Index(pc,d1.w)
		btst	#6,$38(a0)
		bne.w	locret_69366			; Only draw and touch when boss has revealed itself
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------
.Index:
		dc.w Obj_AIZEndBossInit-.Index
		dc.w loc_692E2-.Index
		dc.w loc_6932C-.Index
		dc.w loc_69368-.Index
		dc.w loc_693F0-.Index
		dc.w loc_692E2-.Index
		dc.w loc_69456-.Index
		dc.w loc_6946A-.Index
; ---------------------------------------------------------------------------

Obj_AIZEndBossInit:
		lea	ObjDat_AIZEndBoss(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.b	#8,collision_property(a0)	; 8 hits defeats it
		bset	#0,render_flags(a0)
		lea	(Child1_MakeRoboShip).l,a2
		jsr	(CreateChild1_Normal).l
		bne.s	+ ;loc_69296
		move.b	#8,subtype(a1)

+ ;loc_69296:
		lea	ChildObjDat_69D18(pc),a2
		jsr	(CreateChild1_Normal).l

loc_692A0:
		move.b	#2,routine(a0)
		moveq	#signextendB(sfx_WaterfallSplash),d0
		jsr	(Play_SFX).l
		ori.b	#$48,$38(a0)
		move.l	#loc_69302,$34(a0)
		clr.b	collision_flags(a0)
		bsr.w	sub_69C94
		bclr	#0,render_flags(a0)
		cmpi.w	#8,angle(a0)
		bhs.s	+ ;loc_692D8
		bset	#0,render_flags(a0)

+ ;loc_692D8:
		lea	ChildObjDat_69D2E(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_692E2:
		lea	byte_69D98(pc),a1
		jsr	(Animate_RawNoSSTMultiDelay).l
		bclr	#6,$38(a0)
		cmpi.b	#$2B,mapping_frame(a0)
		bne.s	locret_69300
		bset	#6,$38(a0)

locret_69300:
		rts
; ---------------------------------------------------------------------------

loc_69302:
		move.b	#4,routine(a0)
		bclr	#6,$38(a0)
		bset	#7,art_tile(a0)
		move.b	#$16,collision_flags(a0)
		move.l	#loc_6933A,$34(a0)
		lea	ChildObjDat_69D36(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_6932C:
		lea	byte_69DB3(pc),a1
		jsr	(Animate_RawNoSSTMultiDelay).l
		bra.w	sub_69BE2
; ---------------------------------------------------------------------------

loc_6933A:
		move.b	#6,routine(a0)
		move.w	#$1F,$2E(a0)
		move.l	#loc_6937E,$34(a0)
		move.w	#$C0,d0
		move.w	d0,$3E(a0)
		move.w	d0,y_vel(a0)
		move.w	#$10,$40(a0)
		bclr	#0,$38(a0)

locret_69366:
		rts
; ---------------------------------------------------------------------------

loc_69368:
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		jsr	(Obj_Wait).l
		bra.w	sub_69BE2
; ---------------------------------------------------------------------------

loc_6937E:
		bset	#1,$38(a0)
		btst	#7,$38(a0)
		bne.s	+ ;loc_693A2
		move.w	#4,angle(a0)
		move.w	#$2F,$2E(a0)
		move.l	#loc_693DC,$34(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_693A2:
		move.w	#$BF,d0
		cmpi.b	#2,(Player_1+character_id).w
		bne.s	+ ;loc_693B2
		move.w	#$FF,d0

+ ;loc_693B2:
		move.w	d0,$2E(a0)
		move.l	#loc_693C0,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_693C0:
		move.b	#8,routine(a0)
		move.w	#$3F,$2E(a0)
		move.l	#loc_693FA,$34(a0)
		andi.b	#$F5,$38(a0)
		rts
; ---------------------------------------------------------------------------

loc_693DC:
		st	(_unkFAA2).w
		move.w	#$8F,$2E(a0)
		move.l	#loc_693C0,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_693F0:
		bsr.w	sub_69BE2
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_693FA:
		move.b	#$A,routine(a0)
		moveq	#signextendB(sfx_WaterfallSplash),d0
		jsr	(Play_SFX).l
		move.l	#loc_6942A,$34(a0)
		clr.b	collision_flags(a0)
		bsr.w	sub_69C94
		lea	ChildObjDat_69D2E(pc),a2
		jsr	(CreateChild1_Normal).l
		move.b	#2,subtype(a1)
		rts
; ---------------------------------------------------------------------------

loc_6942A:
		move.b	#$C,routine(a0)
		bset	#7,$38(a0)
		beq.s	+ ;loc_6943E
		move.b	#$E,routine(a0)

+ ;loc_6943E:
		move.l	#loc_69476,$34(a0)
		bclr	#7,art_tile(a0)
		move.b	#0,mapping_frame(a0)
		bra.w	loc_69A66
; ---------------------------------------------------------------------------

loc_69456:
		move.w	(Camera_min_X_pos).w,d0
		addq.w	#2,d0
		cmp.w	(_unkFA84).w,d0
		bhi.s	+ ;loc_69466
		move.w	d0,(Camera_min_X_pos).w

+ ;loc_69466:
		addq.w	#2,(Camera_max_X_pos).w

loc_6946A:
		jsr	(MoveSprite2).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_69476:
		clr.w	x_vel(a0)
		clr.w	y_vel(a0)
		bra.w	loc_692A0
; ---------------------------------------------------------------------------

loc_69482:
		move.l	#loc_694A4,$34(a0)
		st	(_unkFAA3).w
		move.l	#Obj_Wait,(a0)
		bset	#4,$38(a0)
		lea	ChildObjDat_69D66(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_694A4:
		move.l	#loc_694D4,(a0)

loc_694AA:
		st	(_unkFAA8).w
		clr.b	(Boss_flag).w
		lea	(PLC_EggCapsule).l,a1
		jsr	(Load_PLC_Raw).l
		lea	ChildObjDat_69D8C(pc),a2
		jsr	(CreateChild6_Simple).l
		bset	#1,render_flags(a1)
		jmp	(PLCLoad_AnimalsAndExplosion).l
; ---------------------------------------------------------------------------

loc_694D4:
		tst.b	(_unkFAA8).w
		bne.w	locret_69366
		move.l	#loc_69526,(a0)
		jsr	(Restore_PlayerControl).l
		lea	(Player_2).w,a1
		jsr	(Restore_PlayerControl2).l
		jsr	(Restore_LevelMusic).l
		st	(Ctrl_1_locked).w
		clr.w	(Ctrl_1_logical).w
		jsr	(AllocateObject).l
		bne.s	+ ;loc_6950E
		move.l	#loc_863C0,(a1)

+ ;loc_6950E:
		move.w	(_unkFA84).w,d0
		addi.w	#$158,d0
		move.w	d0,(Camera_stored_max_X_pos).w
		lea	(Child6_IncLevX).l,a2
		jmp	(CreateChild6_Simple).l
; ---------------------------------------------------------------------------

loc_69526:
		move.b	#5,(Flying_picking_Sonic_timer).w
		lea	(Player_1).w,a1
		move.w	(_unkFA84).w,d0
		addi.w	#$1F8,d0
		cmp.w	x_pos(a1),d0
		bls.s	+ ;loc_69546
		move.w	#(button_right_mask<<8)|button_right_mask,(Ctrl_1_logical).w
		rts
; ---------------------------------------------------------------------------

+ ;loc_69546:
		jsr	(Stop_Object).l
		cmpi.b	#2,(Player_1+character_id).w
		beq.s	++ ;loc_6957A
		move.l	#loc_69588,(a0)
		jsr	(AllocateObject).l
		bne.s	+ ;loc_6956E
		move.l	#Obj_CutsceneKnuckles,(a1)
		move.b	#4,subtype(a1)

+ ;loc_6956E:
		lea	(PLC_Explosion).l,a1
		jmp	(Load_PLC_Raw).l
; ---------------------------------------------------------------------------

+ ;loc_6957A:
		move.l	#loc_695CE,(a0)
		move.w	#(button_C_mask<<8)|button_C_mask,(Ctrl_1_logical).w
		rts
; ---------------------------------------------------------------------------

loc_69588:
		move.b	#5,(Flying_picking_Sonic_timer).w
		tst.b	(Ctrl_1_locked).w
		beq.s	+ ;loc_695A0
		move.w	#(button_up_mask<<8)|button_up_mask,(Ctrl_1_logical).w
		clr.w	(Ctrl_2_logical).w
		rts
; ---------------------------------------------------------------------------

+ ;loc_695A0:
		move.l	#loc_695A8,(a0)
		rts
; ---------------------------------------------------------------------------

loc_695A8:
		move.b	#5,(Flying_picking_Sonic_timer).w

loc_695AE:
		move.w	(_unkFA86).w,d0
		addi.w	#$1E6,d0
		cmp.w	(Player_1+y_pos).w,d0
		bhi.w	locret_69366
		move.w	#$100,d0
		jsr	(StartNewLevel).l
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_695CE:
		move.w	#button_C_mask<<8,(Ctrl_1_logical).w
		lea	(Player_1).w,a1
		bset	#7,art_tile(a1)
		tst.w	y_vel(a1)
		bmi.w	locret_69366
		move.l	#loc_69616,(a0)
		move.b	#$83,object_control(a1)
		move.b	#$CB,mapping_frame(a1)
		jsr	(Player_Load_PLC).l
		move.w	#$1000,d0
		move.w	d0,(Camera_stored_max_Y_pos).w
		move.w	d0,(Camera_target_max_Y_pos).w
		lea	(Child6_IncLevY).l,a2
		jmp	(CreateChild6_Simple).l
; ---------------------------------------------------------------------------

loc_69616:
		lea	(Player_1).w,a1
		jsr	(MoveSprite_NormGravity).l
		bra.s	loc_695AE
; ---------------------------------------------------------------------------

loc_69622:
		jsr	(Refresh_ChildPositionAdjusted).l
		bsr.w	Child_SyncDraw
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_6964E(pc,d0.w),d1
		jsr	off_6964E(pc,d1.w)
		btst	#6,$38(a0)
		bne.w	locret_69366
		bsr.w	sub_69CA4
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
off_6964E:
		dc.w loc_6965A-off_6964E
		dc.w loc_69682-off_6964E
		dc.w loc_696B4-off_6964E
		dc.w loc_696CA-off_6964E
		dc.w loc_696E2-off_6964E
		dc.w loc_69704-off_6964E
; ---------------------------------------------------------------------------

loc_6965A:
		lea	word_69CE0(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		moveq	#0,d0
		tst.b	subtype(a0)
		beq.s	+ ;loc_69678
		move.b	#$2A,mapping_frame(a0)
		move.w	#$280,priority(a0)

+ ;loc_69678:
		lea	ChildObjDat_69D26(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_69682:
		movea.w	parent3(a0),a1
		btst	#3,$38(a1)
		bne.s	+ ;loc_69690
		rts
; ---------------------------------------------------------------------------

+ ;loc_69690:
		tst.b	subtype(a0)
		bne.s	+ ;loc_696AC
		move.b	#4,routine(a0)
		move.w	#4,$2E(a0)
		move.l	#loc_696BA,$34(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_696AC:
		move.b	#8,routine(a0)
		rts
; ---------------------------------------------------------------------------

loc_696B4:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_696BA:
		move.b	#6,routine(a0)
		move.l	#loc_696DA,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_696CA:
		bclr	#6,$38(a0)
		lea	byte_69DBE(pc),a1
		jmp	(Animate_RawNoSSTMultiDelay).l
; ---------------------------------------------------------------------------

loc_696DA:
		move.b	#8,routine(a0)
		rts
; ---------------------------------------------------------------------------

loc_696E2:
		movea.w	parent3(a0),a1
		btst	#1,$38(a1)
		bne.s	+ ;loc_696F0
		rts
; ---------------------------------------------------------------------------

+ ;loc_696F0:
		move.b	#$A,routine(a0)
		bset	#1,$38(a0)
		move.w	angle(a1),angle(a0)
		rts
; ---------------------------------------------------------------------------

loc_69704:
		movea.w	parent3(a0),a1
		btst	#1,$38(a1)
		beq.s	+ ;loc_69712
		rts
; ---------------------------------------------------------------------------

+ ;loc_69712:
		move.b	#2,routine(a0)
		bclr	#1,$38(a0)
		rts
; ---------------------------------------------------------------------------

loc_69720:
		move.l	#Obj_FlickerMove,(a0)
		move.b	#1,mapping_frame(a0)
		clr.b	collision_flags(a0)
		moveq	#$C,d0
		jmp	(Set_IndexedVelocity).l
; ---------------------------------------------------------------------------

loc_69738:
		bsr.w	Child_SyncDraw
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_69760(pc,d0.w),d1
		jsr	off_69760(pc,d1.w)
		jsr	(Refresh_ChildPositionAdjusted).l
		btst	#6,$38(a0)
		bne.w	locret_69366
		jmp	(Child_Draw_Sprite).l
; ---------------------------------------------------------------------------
off_69760:
		dc.w loc_69768-off_69760
		dc.w loc_69774-off_69760
		dc.w loc_697BA-off_69760
		dc.w loc_6981E-off_69760
; ---------------------------------------------------------------------------

loc_69768:
		lea	word_69CE6(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		rts
; ---------------------------------------------------------------------------

loc_69774:
		movea.w	parent3(a0),a1
		btst	#1,$38(a1)
		bne.s	+ ;loc_69782
		rts
; ---------------------------------------------------------------------------

+ ;loc_69782:
		move.b	#4,routine(a0)
		move.b	#1,anim_frame(a0)
		bset	#1,$38(a0)
		move.b	#1,$3A(a0)
		move.l	#loc_697D8,$34(a0)
		move.w	angle(a1),angle(a0)
		clr.w	$2E(a0)
		tst.b	subtype(a1)
		beq.s	locret_697B8
		move.w	#$4F,$2E(a0)

locret_697B8:
		rts
; ---------------------------------------------------------------------------

loc_697BA:
		subq.w	#1,$2E(a0)
		bpl.s	locret_697D6
		move.w	#3,$2E(a0)
		bsr.w	sub_69AD8
		subq.b	#1,anim_frame(a0)
		bpl.s	locret_697D6
		movea.l	$34(a0),a1
		jsr	(a1)

locret_697D6:
		rts
; ---------------------------------------------------------------------------

loc_697D8:
		move.b	#6,routine(a0)
		cmpi.b	#2,(Player_1+character_id).w
		beq.s	+ ;loc_69802

loc_697E6:
		movea.w	parent3(a0),a1
		bclr	#1,$38(a1)
		move.w	#$5F,$2E(a0)
		move.l	#loc_69824,$34(a0)
		bra.w	loc_69B5E
; ---------------------------------------------------------------------------

+ ;loc_69802:
		subq.b	#1,$3A(a0)
		bmi.s	loc_697E6
		move.w	#$2F,$2E(a0)
		bra.w	loc_69B5E
; ---------------------------------------------------------------------------

loc_69812:
		move.b	#2,routine(a0)
		clr.b	$39(a0)
		rts
; ---------------------------------------------------------------------------

loc_6981E:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_69824:
		move.b	#4,routine(a0)
		move.b	#1,anim_frame(a0)
		bclr	#1,$38(a0)
		clr.w	$2E(a0)
		move.l	#loc_69812,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_69844:
		lea	word_69CEC(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#loc_6989E,(a0)
		bset	#4,shield_reaction(a0)
		move.l	#loc_698BC,$34(a0)
		movea.w	parent3(a0),a1
		movea.w	parent3(a1),a2
		movea.w	parent3(a2),a2
		move.w	a2,$44(a0)
		move.w	angle(a1),d0
		move.w	d0,angle(a0)
		move.l	off_6988E(pc,d0.w),$30(a0)
		cmpi.w	#8,d0
		bhs.s	locret_6988C
		bset	#0,render_flags(a0)

locret_6988C:
		rts
; ---------------------------------------------------------------------------
off_6988E:
		dc.l byte_69DC9
		dc.l byte_69DF3
		dc.l byte_69DF3
		dc.l byte_69DC9
; ---------------------------------------------------------------------------

loc_6989E:
		movea.w	$44(a0),a1
		btst	#7,status(a1)
		bne.s	+ ;loc_698C6
		jsr	(Refresh_ChildPosition).l
		jsr	(Animate_Raw).l
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------

loc_698BC:
		lea	ChildObjDat_69D56(pc),a2
		jsr	(CreateChild1_Normal).l

+ ;loc_698C6:
		bset	#6,$38(a0)
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

loc_698D2:
		lea	word_69CF2(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		bset	#4,shield_reaction(a0)
		moveq	#signextendB(sfx_Projectile),d0
		jsr	(Play_SFX).l
		move.b	#$C,y_radius(a0)
		move.w	#$9F,$2E(a0)
		move.l	#loc_69908,(a0)
		move.l	#loc_69946,$34(a0)
		bra.w	loc_69B7A
; ---------------------------------------------------------------------------

loc_69908:
		tst.w	x_vel(a0)
		beq.s	loc_69914
		jsr	(ObjHitFloor_DoRoutine).l

loc_69914:
		jsr	(Animate_Raw).l
		jsr	(MoveSprite2).l
		subq.w	#1,$2E(a0)
		bmi.s	++ ;loc_69940
		move.b	(V_int_run_count+3).w,d0
		andi.b	#3,d0
		bne.s	+ ;loc_6993A
		lea	ChildObjDat_69D5E(pc),a2
		jsr	(CreateChild1_Normal).l

+ ;loc_6993A:
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------

+ ;loc_69940:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_69946:
		move.l	#loc_69914,(a0)
		move.l	#byte_69E29,$30(a0)
		clr.w	y_vel(a0)
		rts
; ---------------------------------------------------------------------------

loc_6995A:
		lea	word_69CF8(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#loc_6998A,(a0)
		move.l	#Go_Delete_Sprite,$34(a0)
		move.l	#byte_69E2F,$30(a0)
		tst.w	x_vel(a0)
		bne.s	locret_69988
		move.l	#byte_69E38,$30(a0)

locret_69988:
		rts
; ---------------------------------------------------------------------------

loc_6998A:
		jsr	(Animate_RawMultiDelay).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_69996:
		lea	ObjDat_AIZEndBoss2(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_699B0,(a0)
		move.l	#Go_Delete_Sprite,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_699B0:
		lea	byte_69E41(pc),a1
		jsr	(Animate_RawNoSSTMultiDelay).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_699C0:
		lea	word_69CFE(pc),a1
		jsr	(SetUp_ObjAttributes2).l
		move.l	#loc_699EA,(a0)
		tst.b	subtype(a0)
		bne.s	+ ;loc_699E0
		move.l	#Go_Delete_Sprite,$34(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_699E0:
		move.l	#loc_69A04,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_699EA:
		lea	byte_69E4A(pc),a1
		jsr	(Animate_RawNoSSTMultiDelayFlipX).l
		cmpi.b	#$2B,mapping_frame(a0)
		beq.w	locret_69366
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_69A04:
		move.l	#loc_69A1A,(a0)
		move.w	#$800,y_vel(a0)
		move.l	#Go_Delete_Sprite,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_69A1A:
		jsr	(MoveSprite2).l
		lea	byte_69E65(pc),a1
		jsr	(Animate_RawNoSSTMultiDelayFlipX).l
		cmpi.b	#$2B,mapping_frame(a0)
		beq.w	locret_69366
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_69A3A:
		lea	word_69D12(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#Obj_FlickerMove,(a0)
		move.b	subtype(a0),d0
		lsr.b	#1,d0
		addi.b	#$32,d0
		move.b	d0,mapping_frame(a0)
		moveq	#0,d0
		jsr	(Set_IndexedVelocity).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_69A66:
		jsr	(Random_Number).l
		andi.w	#$C,d0
		move.w	angle(a0),d1
		move.w	d0,angle(a0)
		cmp.w	d1,d0
		beq.s	loc_69A66
		lea	word_69AC8(pc,d0.w),a1
		moveq	#0,d2
		move.w	(_unkFA84).w,d2
		add.w	(a1)+,d2
		swap	d2
		sub.l	x_pos(a0),d2
		add.l	d2,d2
		swap	d2
		move.w	d2,x_vel(a0)
		moveq	#0,d3
		move.w	(_unkFA86).w,d3
		add.w	(a1)+,d3
		swap	d3
		sub.l	y_pos(a0),d3
		add.l	d3,d3
		swap	d3
		move.w	d3,y_vel(a0)
		move.w	#$7F,$2E(a0)
		tst.w	d2
		beq.s	locret_69AC6
		bclr	#0,render_flags(a0)
		tst.w	d2
		bmi.s	locret_69AC6
		bset	#0,render_flags(a0)

locret_69AC6:
		rts
; ---------------------------------------------------------------------------
word_69AC8:
		dc.w   $058,   $76
		dc.w   $0A0,   $46
		dc.w   $160,   $46
		dc.w   $1A8,   $76

; =============== S U B R O U T I N E =======================================


sub_69AD8:
		move.w	angle(a0),d0
		moveq	#0,d1
		eori.w	#$C,d0
		beq.s	+ ;loc_69AEE
		cmpi.w	#$C,d0
		beq.s	+ ;loc_69AEE
		addi.w	#$10,d1

+ ;loc_69AEE:
		moveq	#0,d2
		move.b	$39(a0),d2
		add.w	d2,d1
		lea	byte_69B0E(pc,d1.w),a1
		move.b	(a1)+,child_dx(a0)
		move.b	(a1)+,child_dy(a0)
		move.b	(a1)+,mapping_frame(a0)
		addq.b	#4,d2
		move.b	d2,$39(a0)
		rts
; End of function sub_69AD8

; ---------------------------------------------------------------------------
byte_69B0E:
		dc.b -$18,   8,   5
		even
		dc.b -$18,   8,   5
		even
		dc.b -$1C,   0,   4
		even
		dc.b -$1C,   0,   4
		even
		dc.b -$18,   8,   5
		even
		dc.b -$10, $10,   6
		even
		dc.b -$18,   8,   5
		even
		dc.b -$1C,   0,   4
		even

; =============== S U B R O U T I N E =======================================


Child_SyncDraw:
		movea.w	parent3(a0),a1
		btst	#6,$38(a1)
		bne.s	+ ;loc_69B56
		bclr	#6,$38(a0)
		bset	#7,art_tile(a0)
		btst	#7,art_tile(a1)
		bne.s	locret_69B54
		bclr	#7,art_tile(a0)

locret_69B54:
		rts
; ---------------------------------------------------------------------------

+ ;loc_69B56:
		bset	#6,$38(a0)
		rts
; End of function Child_SyncDraw

; ---------------------------------------------------------------------------

loc_69B5E:
		move.w	angle(a0),d0
		lsr.w	#1,d0
		move.w	off_69B72(pc,d0.w),d0
		lea	off_69B72(pc,d0.w),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------
off_69B72:
		dc.w ChildObjDat_69D3E-off_69B72
		dc.w ChildObjDat_69D46-off_69B72
		dc.w ChildObjDat_69D46-off_69B72
		dc.w ChildObjDat_69D4E-off_69B72
; ---------------------------------------------------------------------------

loc_69B7A:
		movea.w	parent3(a0),a1
		move.w	angle(a1),d0
		cmpi.w	#8,d0
		bhs.s	+ ;loc_69B8E
		bset	#0,render_flags(a0)

+ ;loc_69B8E:
		move.l	off_69BB2(pc,d0.w),$30(a0)
		lea	word_69BC2(pc,d0.w),a1
		move.w	(a1)+,d1
		add.w	d1,x_pos(a0)
		move.w	(a1)+,d1
		add.w	d1,y_pos(a0)
		lea	word_69BD2(pc,d0.w),a1
		move.w	(a1)+,x_vel(a0)
		move.w	(a1)+,y_vel(a0)
		rts
; ---------------------------------------------------------------------------
off_69BB2:
		dc.l byte_69E1D
		dc.l byte_69E23
		dc.l byte_69E23
		dc.l byte_69E1D
word_69BC2:
		dc.w    $14,   $14
		dc.w      0,   $18
		dc.w      0,   $18
		dc.w   -$14,   $14
word_69BD2:
		dc.w   $300,  $300
		dc.w      0,  $400
		dc.w      0,  $400
		dc.w  -$300,  $300

; =============== S U B R O U T I N E =======================================


sub_69BE2:
		tst.b	collision_flags(a0)
		bne.s	locret_69C34
		tst.b	collision_property(a0)
		beq.s	+++ ;loc_69C36
		tst.b	$20(a0)
		bne.s	+ ;loc_69C02
		move.b	#$20,$20(a0)
		moveq	#signextendB(sfx_BossHit),d0
		jsr	(Play_SFX).l

+ ;loc_69C02:
		bset	#6,status(a0)
		moveq	#0,d0
		btst	#0,$20(a0)
		bne.s	+ ;loc_69C16
		addi.w	#2*7,d0

+ ;loc_69C16:
		bsr.w	sub_69C5C
		subq.b	#1,$20(a0)
		bne.s	locret_69C34
		bclr	#6,status(a0)
		cmpi.b	#0,mapping_frame(a0)
		bne.s	locret_69C34
		move.b	$25(a0),collision_flags(a0)

locret_69C34:
		rts
; ---------------------------------------------------------------------------

+ ;loc_69C36:
		move.l	#Wait_FadeToLevelMusic,(a0)
		bclr	#6,$38(a0)
		bset	#7,art_tile(a0)
		move.b	#0,mapping_frame(a0)
		move.l	#loc_69482,$34(a0)
		jmp	(BossDefeated_StopTimer).l
; End of function sub_69BE2


; =============== S U B R O U T I N E =======================================


sub_69C5C:
		lea	word_69C6A(pc),a1
		lea	word_69C78(pc,d0.w),a2
		jmp	(CopyWordData_7).l
; End of function sub_69C5C

; ---------------------------------------------------------------------------
word_69C6A:
		dc.w Normal_palette_line_2+$08, Normal_palette_line_2+$0E, Normal_palette_line_2+$12, Normal_palette_line_2+$14
		dc.w Normal_palette_line_2+$16, Normal_palette_line_2+$1A, Normal_palette_line_2+$1C
word_69C78:
		dc.w   $222,     8,   $4C,     6,   $20,  $A24,  $622
		dc.w   $AAA,  $AAA,  $AAA,  $CCC,  $EEE,  $666,  $888

; =============== S U B R O U T I N E =======================================


sub_69C94:
		moveq	#0,d0
		bsr.s	sub_69C5C
		bclr	#6,status(a0)
		clr.b	$20(a0)
		rts
; End of function sub_69C94


; =============== S U B R O U T I N E =======================================


sub_69CA4:
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.s	+ ;loc_69CB2
		rts
; ---------------------------------------------------------------------------

+ ;loc_69CB2:
		move.l	#Wait_Draw,(a0)
		bset	#7,status(a0)
		move.b	#1,mapping_frame(a0)
		move.w	#$1F,$2E(a0)
		move.l	#loc_69720,$34(a0)
		rts
; End of function sub_69CA4

; ---------------------------------------------------------------------------
ObjDat_AIZEndBoss:
		dc.l Map_AIZEndBoss
		dc.w make_art_tile($180,1,1)	; VRAM
		dc.w   $280			; Priority
		dc.b  $28, $20,   0, $10	; Width, Height, Frame, Collision
word_69CE0:
		dc.w   $200
		dc.b  $24, $14,   1,   0
word_69CE6:
		dc.w   $180
		dc.b   $C,  $C,   4,   0
word_69CEC:
		dc.w   $100
		dc.b    8,   4,  $B, $97
word_69CF2:
		dc.w   $100
		dc.b  $14, $18,  $F, $9A
word_69CF8:
		dc.w   $100
		dc.b    8,   8, $18,   0
word_69CFE:
		dc.w make_art_tile($180,0,1)
		dc.w   $100
		dc.b  $30, $30, $24,   0
ObjDat_AIZEndBoss2:
		dc.l Map_AIZEndBoss
		dc.w make_art_tile($180,0,1)
		dc.w   $100
		dc.b  $18, $10, $21,   0
word_69D12:
		dc.w   $180
		dc.b  $10, $10,   0,   0
ChildObjDat_69D18:
		dc.w 2-1
		dc.l loc_69622
		dc.b  $14,  -4
		dc.l loc_69622
		dc.b -$14,  -4
ChildObjDat_69D26:
		dc.w 1-1
		dc.l loc_69738
		dc.b -$1C,   0
ChildObjDat_69D2E:
		dc.w 1-1
		dc.l loc_699C0
		dc.b    0,   0
ChildObjDat_69D36:
		dc.w 1-1
		dc.l loc_69996
		dc.b    0,-$30
ChildObjDat_69D3E:
		dc.w 1-1
		dc.l loc_69844
		dc.b    3,   5
ChildObjDat_69D46:
		dc.w 1-1
		dc.l loc_69844
		dc.b    0,   7
ChildObjDat_69D4E:
		dc.w 1-1
		dc.l loc_69844
		dc.b   -3,   5
ChildObjDat_69D56:
		dc.w 1-1
		dc.l loc_698D2
		dc.b    0,   0
ChildObjDat_69D5E:
		dc.w 1-1
		dc.l loc_6995A
		dc.b    0,   0
ChildObjDat_69D66:
		dc.w 6-1
		dc.l loc_69A3A
		dc.b -$10,-$10
		dc.l loc_69A3A
		dc.b  $10,-$10
		dc.l loc_69A3A
		dc.b -$10,   8
		dc.l loc_69A3A
		dc.b  $10,   8
		dc.l loc_69A3A
		dc.b  -$C, $18
		dc.l loc_69A3A
		dc.b   $C, $18
ChildObjDat_69D8C:
		dc.w 1-1
		dc.l Obj_EggCapsule
ChildObjDat_69D92:	; used in S3, unused in S&K
		dc.w 1-1
		dc.l Obj_CutsceneKnuckles
byte_69D98:
		dc.b  $2B,   0
		dc.b  $2B,   0
		dc.b  $2B,   0
		dc.b    0,   0
		dc.b  $2B,   0
		dc.b  $2B,   0
		dc.b    0,   0
		dc.b  $2B,   0
		dc.b  $2B,   0
		dc.b    0,   0
		dc.b  $2B,   0
		dc.b  $2B,   0
		dc.b    0,   0
		dc.b  $F4
byte_69DB3:
		dc.b  $1B,   0
		dc.b  $1B,   4
		dc.b  $1C,   5
		dc.b  $1D,   6
		dc.b    0,   0
		dc.b  $F4
byte_69DBE:
		dc.b  $1E,   0
		dc.b  $1E,   4
		dc.b  $1F,   5
		dc.b  $20,   6
		dc.b    1,   0
		dc.b  $F4
byte_69DC9:
		dc.b    0
		dc.b    7, $2B
		dc.b    7, $2B
		dc.b    8, $2B
		dc.b    8, $2B
		dc.b    9, $2B
		dc.b    9, $2B
		dc.b   $A, $2B
		dc.b   $A, $2B
		dc.b   $A, $2B
		dc.b   $A, $2B
		dc.b   $A, $2B
		dc.b   $A, $2B
		dc.b   $A, $2B
		dc.b   $A, $2B
		dc.b   $A, $2B
		dc.b   $A, $2B
		dc.b   $A, $2B
		dc.b   $A, $2B
		dc.b   $A, $2B
		dc.b   $A, $2B
		dc.b  $F4
byte_69DF3:
		dc.b    0
		dc.b   $B, $2B
		dc.b   $B, $2B
		dc.b   $C, $2B
		dc.b   $C, $2B
		dc.b   $D, $2B
		dc.b   $D, $2B
		dc.b   $E, $2B
		dc.b   $E, $2B
		dc.b   $E, $2B
		dc.b   $E, $2B
		dc.b   $E, $2B
		dc.b   $E, $2B
		dc.b   $E, $2B
		dc.b   $E, $2B
		dc.b   $E, $2B
		dc.b   $E, $2B
		dc.b   $E, $2B
		dc.b   $E, $2B
		dc.b   $E, $2B
		dc.b   $E, $2B
		dc.b  $F4
byte_69E1D:
		dc.b    1, $26, $27, $28, $29, $FC
byte_69E23:
		dc.b    1, $16, $17, $2F, $30, $FC
byte_69E29:
		dc.b    1, $10, $11, $2D, $2E, $FC
byte_69E2F:
		dc.b  $12,   0
		dc.b  $12,   9
		dc.b  $13,   2
		dc.b  $14,   2
		dc.b  $F4
byte_69E38:
		dc.b  $18,   0
		dc.b  $18,   9
		dc.b  $19,   2
		dc.b  $1A,   2
		dc.b  $F4
byte_69E41:
		dc.b  $21,   0
		dc.b  $21,   4
		dc.b  $22,   5
		dc.b  $23,   6
		dc.b  $F4
byte_69E4A:
		dc.b  $2B|$00,   0
		dc.b  $24|$00,   0
		dc.b  $24|$40,   0
		dc.b  $2B|$40,   0
		dc.b  $2C|$00,   0
		dc.b  $2C|$40,   0
		dc.b  $2B|$40,   0
		dc.b  $24|$00,   0
		dc.b  $24|$40,   0
		dc.b  $2B|$40,   0
		dc.b  $2C|$00,   0
		dc.b  $2C|$40,   0
		dc.b  $2B|$40,   0
		dc.b  $F4
byte_69E65:
		dc.b  $2B|$00,   0
		dc.b  $24|$00,   0
		dc.b  $24|$40,   0
		dc.b  $2B|$40,   0
		dc.b  $2C|$00,   0
		dc.b  $2C|$40,   0
		dc.b  $2B|$40,   0
		dc.b  $31|$00,   0
		dc.b  $31|$40,   0
		dc.b  $2B|$40,   0
		dc.b  $31|$00,   0
		dc.b  $31|$40,   0
		dc.b  $2B|$40,   0
		dc.b  $F4
		even
Pal_AIZEndBoss:
		binclude "Levels/AIZ/Palettes/End Boss.bin"
		even
; ---------------------------------------------------------------------------

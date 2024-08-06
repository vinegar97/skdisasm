Obj_DEZEndBoss:
		lea	word_7F0BE(pc),a1
		jsr	(Check_CameraInRange).l
		move.l	#loc_7F0CE,(a0)
		move.l	#loc_7F0D2,$34(a0)
		lea	word_7F0C6(pc),a1
		move.b	#mus_EndBoss,$26(a0)
		jsr	sub_85D6A(pc)
		clr.b	(_unkFAB8).w
		moveq	#$76,d0
		jsr	(Load_PLC).l
		lea	(ArtKosM_DEZEndBoss).l,a1
		move.w	#tiles_to_bytes($38A),d2
		jsr	(Queue_Kos_Module).l
		lea	Pal_DEZEndBoss(pc),a1
		jsr	PalLoad_Line1(pc)
		lea	ChildObjDat_7FC8C(pc),a2
		jmp	CreateChild1_Normal(pc)
; ---------------------------------------------------------------------------
word_7F0BE:
		dc.w   $198,  $498, $33E0, $3480
word_7F0C6:
		dc.w   $218,  $288, $3400, $34E0
; ---------------------------------------------------------------------------

loc_7F0CE:
		jmp	loc_85CA4(pc)
; ---------------------------------------------------------------------------

loc_7F0D2:
		move.l	#loc_7F0DA,(a0)

locret_7F0D8:
		rts
; ---------------------------------------------------------------------------

loc_7F0DA:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_7F102(pc,d0.w),d1
		jsr	off_7F102(pc,d1.w)
		bsr.w	sub_7FB92
		move.b	(V_int_run_count+3).w,d0
		andi.b	#$3F,d0
		bne.s	+ ;loc_7F0FE
		moveq	#signextendB(sfx_WaveHover),d0
		jsr	(Play_SFX).l

+ ;loc_7F0FE:
		jmp	Draw_And_Touch_Sprite(pc)
; ---------------------------------------------------------------------------
off_7F102:
		dc.w loc_7F10E-off_7F102
		dc.w loc_7F150-off_7F102
		dc.w loc_7F182-off_7F102
		dc.w loc_7F1CC-off_7F102
		dc.w loc_7F182-off_7F102
		dc.w loc_7F1CC-off_7F102
; ---------------------------------------------------------------------------

loc_7F10E:
		lea	ObjDat_DEZEndBoss(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		move.b	#8,collision_property(a0)
		move.w	#$100,y_vel(a0)
		move.w	#$BF,$2E(a0)
		move.l	#loc_7F15A,$34(a0)
		lea	ChildObjDat_7FC9A(pc),a2
		jsr	CreateChild6_Simple(pc)
		tst.l	(Player_2).w
		beq.s	locret_7F14E
		lea	ChildObjDat_7FC9A(pc),a2
		jsr	CreateChild6_Simple(pc)
		bne.s	locret_7F14E
		move.b	#2,subtype(a1)

locret_7F14E:
		rts
; ---------------------------------------------------------------------------

loc_7F150:
		jsr	(MoveSprite2).l
		jmp	Obj_Wait(pc)
; ---------------------------------------------------------------------------

loc_7F15A:
		jsr	(Swing_Setup1).l
		move.w	#$100,x_vel(a0)

loc_7F166:
		move.b	#4,routine(a0)
		andi.b	#$F3,$38(a0)
		move.w	#$B3,$2E(a0)
		move.l	#loc_7F194,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_7F182:
		jsr	Swing_UpAndDown(pc)
		jsr	(MoveSprite2).l
		bsr.w	sub_7FA60
		jmp	Obj_Wait(pc)
; ---------------------------------------------------------------------------

loc_7F194:
		cmpi.b	#3,$39(a0)
		bhs.s	+ ;loc_7F1C4
		move.b	#6,routine(a0)
		addq.b	#1,$39(a0)
		bset	#3,$38(a0)
		move.l	#loc_7F1DE,$34(a0)
		lea	byte_7FCD4(pc),a1
		jsr	Set_Raw_Animation(pc)
		lea	ChildObjDat_7FCA0(pc),a2
		jmp	CreateChild1_Normal(pc)
; ---------------------------------------------------------------------------

+ ;loc_7F1C4:
		move.w	#$F,$2E(a0)
		rts
; ---------------------------------------------------------------------------

loc_7F1CC:
		jsr	Swing_UpAndDown(pc)
		jsr	(MoveSprite2).l
		bsr.w	sub_7FA60
		jmp	Animate_Raw(pc)
; ---------------------------------------------------------------------------

loc_7F1DE:
		move.b	#8,routine(a0)
		bset	#2,$38(a0)
		move.w	#$3F,$2E(a0)
		move.l	#loc_7F1FA,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_7F1FA:
		move.b	#$A,routine(a0)
		move.l	#loc_7F166,$34(a0)
		lea	byte_7FCD9(pc),a1
		jmp	Set_Raw_Animation(pc)
; ---------------------------------------------------------------------------

loc_7F210:
		move.l	#loc_7F220,(a0)
		clr.w	x_vel(a0)
		clr.w	y_vel(a0)
		rts
; ---------------------------------------------------------------------------

loc_7F220:
		jsr	(MoveSprite_LightGravity).l
		cmpi.w	#$318,y_pos(a0)
		bhs.s	+ ;loc_7F234
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

+ ;loc_7F234:
		move.l	#loc_7F266,(a0)
		bclr	#7,render_flags(a0)
		lea	ChildObjDat_7FCCE(pc),a2
		jsr	CreateChild6_Simple(pc)
		lea	ChildObjDat_7FCC8(pc),a2
		jsr	CreateChild6_Simple(pc)
		lea	(Child6_CreateBossExplosion).l,a2
		jsr	(CreateChild6_Simple).l
		moveq	#signextendB(mus_FadeOut),d0
		jsr	(Play_Music).l
		rts
; ---------------------------------------------------------------------------

loc_7F266:
		btst	#1,(_unkFAB8).w
		beq.s	locret_7F298
		move.l	#loc_7F29A,(a0)
		bset	#4,$38(a0)
		move.w	#$3F,$2E(a0)
		move.w	#$35D0,x_pos(a0)
		move.w	#$328,y_pos(a0)
		lea	(Child6_CreateBossExplosion).l,a2
		jsr	(CreateChild6_Simple).l

locret_7F298:
		rts
; ---------------------------------------------------------------------------

loc_7F29A:
		move.w	$2E(a0),d0
		subq.w	#1,d0
		move.w	d0,$2E(a0)
		beq.s	+ ;loc_7F2B4
		cmpi.w	#$30,$2E(a0)
		bne.s	locret_7F2DA
		st	(Events_fg_4).w
		rts
; ---------------------------------------------------------------------------

+ ;loc_7F2B4:
		move.l	#loc_7F2DC,(a0)
		clr.b	(Boss_flag).w
		moveq	#signextendB(mus_DEZ2),d0
		jsr	(Play_Music).l
		move.w	#$3620,(Camera_stored_max_X_pos).w
		jsr	(AllocateObject).l
		bne.s	locret_7F2DA
		move.l	#Obj_IncLevEndXGradual,(a1)

locret_7F2DA:
		rts
; ---------------------------------------------------------------------------

loc_7F2DC:
		move.w	(Camera_X_pos).w,(Camera_min_X_pos).w
		cmpi.w	#$3620,(Camera_X_pos).w
		blo.s	locret_7F2FC
		move.l	#loc_7F2FE,(a0)
		move.b	#1,(Scroll_lock).w
		addi.w	#$40,(Camera_max_X_pos).w

locret_7F2FC:
		rts
; ---------------------------------------------------------------------------

loc_7F2FE:
		move.w	(Camera_X_pos).w,d0
		addi.w	#$160,d0
		cmp.w	(Player_1+x_pos).w,d0
		bls.w	+ ;loc_7F310
		rts
; ---------------------------------------------------------------------------

+ ;loc_7F310:
		st	(Act3_flag).w
		move.w	(Ring_count).w,(Act3_ring_count).w
		move.l	(Timer).w,(Act3_timer).w
		move.b	(Player_1+status_secondary).w,(Saved2_status_secondary).w
		move.w	#$1700,d0
		jsr	(StartNewLevel).l
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_7F336:
		lea	word_7FC50(pc),a1
		jsr	SetUp_ObjAttributes3(pc)
		move.l	#loc_7F344,(a0)

loc_7F344:
		lea	(Player_1).w,a2
		tst.b	subtype(a0)
		beq.s	+ ;loc_7F352
		lea	(Player_2).w,a2

+ ;loc_7F352:
		movea.w	parent3(a0),a1
		jsr	sub_8622C(pc)
		movea.w	parent3(a0),a1
		btst	#3,$38(a1)
		beq.s	+ ;loc_7F37C
		move.b	d0,d1
		smi	d2
		addi.b	#$30,d1
		cmpi.b	#$60,d1
		bhs.s	+ ;loc_7F37C
		moveq	#$30,d0
		tst.b	d2
		beq.s	+ ;loc_7F37C
		moveq	#-$30,d0

+ ;loc_7F37C:
		move.b	d0,$3C(a0)
		lea	(byte_7FD28).l,a2
		jsr	MoveSprite_AtAngleLookup(pc)
		bsr.w	sub_7FA7E
		bsr.w	sub_7FACC
		moveq	#8,d0
		jmp	Child_DrawTouch_Sprite_FlickerMove(pc)
; ---------------------------------------------------------------------------

loc_7F398:
		lea	word_7FC62(pc),a1
		jsr	SetUp_ObjAttributes3(pc)
		move.l	#loc_7F3B0,(a0)
		move.b	#$B,y_radius(a0)
		jmp	Child_Draw_Sprite(pc)
; ---------------------------------------------------------------------------

loc_7F3B0:
		movea.w	parent3(a0),a1
		btst	#2,$38(a1)
		bne.s	+ ;loc_7F3C4
		jsr	Refresh_ChildPosition(pc)
		jmp	Child_Draw_Sprite(pc)
; ---------------------------------------------------------------------------

+ ;loc_7F3C4:
		move.l	#loc_7F3D0,(a0)
		move.w	#$10,$2E(a0)

loc_7F3D0:
		subq.w	#1,$2E(a0)
		bmi.s	++ ;loc_7F3EA
		bchg	#2,$38(a0)
		bne.s	+ ;loc_7F3E2
		addq.b	#1,child_dy(a0)

+ ;loc_7F3E2:
		jsr	Refresh_ChildPosition(pc)
		jmp	Child_Draw_Sprite(pc)
; ---------------------------------------------------------------------------

+ ;loc_7F3EA:
		move.l	#loc_7F3F6,(a0)
		move.w	#7,$2E(a0)

loc_7F3F6:
		subq.w	#1,$2E(a0)
		bpl.s	+ ;loc_7F40A
		move.l	#loc_7F414,(a0)
		moveq	#signextendB(sfx_MushroomBounce),d0
		jsr	(Play_SFX).l

+ ;loc_7F40A:
		movea.w	parent3(a0),a1
		move.w	x_pos(a1),x_pos(a0)

loc_7F414:
		bsr.w	sub_7F8A0
		tst.w	y_vel(a0)
		bpl.s	+ ;loc_7F430
		jsr	(ObjCheckCeilingDist).l
		tst.w	d1
		bpl.s	++ ;loc_7F43E
		bsr.w	sub_7F45A
		bra.w	++ ;loc_7F43E
; ---------------------------------------------------------------------------

+ ;loc_7F430:
		jsr	(ObjCheckFloorDist).l
		tst.w	d1
		bpl.s	+ ;loc_7F43E
		bsr.w	sub_7F472

+ ;loc_7F43E:
		movea.w	parent3(a0),a1
		btst	#7,status(a0)
		bne.s	sub_7F4AC
		btst	#0,(V_int_run_count+3).w
		bne.w	locret_7F0D8
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_7F45A:
		sub.w	d1,y_pos(a0)
		move.b	#0,routine(a0)
		move.b	#$C6,collision_flags(a0)
		st	$3A(a0)
		bra.w	+ ;loc_7F486
; End of function sub_7F45A


; =============== S U B R O U T I N E =======================================


sub_7F472:
		add.w	d1,y_pos(a0)
		move.b	#2,routine(a0)
		move.b	#$C6,collision_flags(a0)
		clr.b	$3A(a0)

+ ;loc_7F486:
		move.l	#loc_7F4FA,(a0)
		move.w	#(10*60)-1,$2E(a0)
		jsr	(Random_Number).l
		move.w	#$80,d1
		tst.b	d0
		bpl.s	+ ;loc_7F4A2
		neg.w	d1

+ ;loc_7F4A2:
		move.w	d1,x_vel(a0)
		clr.w	y_vel(a0)
		rts
; End of function sub_7F472


; =============== S U B R O U T I N E =======================================


sub_7F4AC:
		move.l	#Go_Delete_Sprite,$34(a0)
		bra.w	+ ;loc_7F4C0
; End of function sub_7F4AC


; =============== S U B R O U T I N E =======================================


sub_7F4B8:
		move.l	#loc_7F4EE,$34(a0)

+ ;loc_7F4C0:
		lea	(Child6_CreateBossExplosion).l,a2
		jsr	(CreateChild6_Simple).l
		bne.s	+ ;loc_7F4D4
		move.b	#6,subtype(a1)

+ ;loc_7F4D4:
		move.l	#Wait_Draw,(a0)
		movea.w	parent3(a0),a1
		subq.b	#1,$39(a1)
		move.w	#7,$2E(a0)
		jmp	(Draw_Sprite).l
; End of function sub_7F4B8

; ---------------------------------------------------------------------------

loc_7F4EE:
		lea	ChildObjDat_7FCB4(pc),a2
		jsr	CreateChild1_Normal(pc)
		jmp	Go_Delete_Sprite(pc)
; ---------------------------------------------------------------------------

loc_7F4FA:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_7F51E(pc,d0.w),d1
		jsr	off_7F51E(pc,d1.w)
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.w	sub_7F4AC
		bsr.w	sub_7FB4E
		jmp	Draw_And_Touch_Sprite(pc)
; ---------------------------------------------------------------------------
off_7F51E:
		dc.w loc_7F528-off_7F51E
		dc.w loc_7F538-off_7F51E
		dc.w loc_7F568-off_7F51E
		dc.w loc_7F5D2-off_7F51E
		dc.w loc_7F5FC-off_7F51E
; ---------------------------------------------------------------------------

loc_7F528:
		bsr.w	sub_7F900
		bsr.w	sub_7F8CA
		subq.w	#1,$2E(a0)
		bmi.s	+ ;loc_7F55A
		rts
; ---------------------------------------------------------------------------

loc_7F538:
		jsr	(MoveSprite2).l
		bsr.w	sub_7F9A8
		bsr.w	sub_7FA60
		lea	byte_7FCDE(pc),a1
		jsr	Animate_RawNoSST(pc)
		bsr.w	sub_7F8CA
		subq.w	#1,$2E(a0)
		bpl.w	locret_7F0D8

+ ;loc_7F55A:
		move.b	#8,routine(a0)
		move.w	#$1F,$2E(a0)
		rts
; ---------------------------------------------------------------------------

loc_7F568:
		jsr	(sub_7F8A0).l

loc_7F56E:
		bsr.w	sub_7F9F8
		tst.w	y_vel(a0)
		bpl.s	+ ;loc_7F5A0
		jsr	(ObjCheckCeilingDist).l
		tst.w	d1
		bpl.s	locret_7F5D0
		sub.w	d1,y_pos(a0)
		st	$3A(a0)
		btst	#1,render_flags(a0)
		bne.s	++ ;loc_7F5BA

loc_7F592:
		move.b	#0,routine(a0)
		move.b	#$C6,collision_flags(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_7F5A0:
		jsr	(ObjCheckFloorDist).l
		tst.w	d1
		bpl.s	locret_7F5D0
		add.w	d1,y_pos(a0)
		clr.b	$3A(a0)
		btst	#1,render_flags(a0)
		bne.s	loc_7F592

+ ;loc_7F5BA:
		move.b	#2,routine(a0)
		move.b	#$C6,collision_flags(a0)
		move.w	$3C(a0),x_vel(a0)
		clr.w	y_vel(a0)

locret_7F5D0:
		rts
; ---------------------------------------------------------------------------

loc_7F5D2:
		subq.w	#1,child_dx(a0)
		bne.s	+ ;loc_7F5DE
		bchg	#1,render_flags(a0)

+ ;loc_7F5DE:
		jsr	(sub_7F8A0).l
		bsr.w	sub_7FA60
		move.w	#$80,d0
		tst.w	x_vel(a0)
		bpl.s	+ ;loc_7F5F4
		neg.w	d0

+ ;loc_7F5F4:
		move.w	d0,$3C(a0)
		bra.w	loc_7F56E
; ---------------------------------------------------------------------------

loc_7F5FC:
		subq.w	#1,$2E(a0)
		bpl.s	locret_7F608
		bsr.w	sub_7F4B8
		addq.w	#4,sp

locret_7F608:
		rts
; ---------------------------------------------------------------------------

loc_7F60A:
		lea	word_7FC68(pc),a1
		jsr	SetUp_ObjAttributes3(pc)
		move.l	#loc_7F62E,(a0)
		jsr	Refresh_ChildPositionAdjusted(pc)
		bsr.w	sub_7FB1A
		movea.w	parent3(a0),a1
		movea.w	parent3(a1),a1
		move.w	a1,parent3(a0)
		rts
; ---------------------------------------------------------------------------

loc_7F62E:
		jsr	(MoveSprite2).l
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.s	+ ;loc_7F644
		jmp	Sprite_CheckDeleteTouchXY(pc)
; ---------------------------------------------------------------------------

+ ;loc_7F644:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_7F64A:
		lea	word_7FC56(pc),a1
		jsr	SetUp_ObjAttributes3(pc)
		move.l	#loc_7F66C,(a0)
		move.l	#byte_7FCEF,$30(a0)
		lea	ChildObjDat_7FCAE(pc),a2
		jsr	CreateChild6_Simple(pc)
		jmp	Child_DrawTouch_Sprite(pc)
; ---------------------------------------------------------------------------

loc_7F66C:
		movea.w	parent3(a0),a1
		btst	#2,$38(a1)
		bne.s	+ ;loc_7F684
		jsr	Refresh_ChildPosition(pc)
		jsr	Animate_RawMultiDelay(pc)
		jmp	Child_DrawTouch_Sprite(pc)
; ---------------------------------------------------------------------------

+ ;loc_7F684:
		move.l	#loc_7F690,(a0)
		move.w	#$10,$2E(a0)

loc_7F690:
		subq.w	#1,$2E(a0)
		bmi.s	++ ;loc_7F6AE
		bchg	#2,$38(a0)
		bne.s	+ ;loc_7F6A2
		addq.b	#1,child_dy(a0)

+ ;loc_7F6A2:
		jsr	Refresh_ChildPosition(pc)
		jsr	Animate_RawMultiDelay(pc)
		jmp	Child_Draw_Sprite(pc)
; ---------------------------------------------------------------------------

+ ;loc_7F6AE:
		move.l	#loc_7F6BA,(a0)
		move.w	#7,$2E(a0)

loc_7F6BA:
		subq.w	#1,$2E(a0)
		bmi.s	+ ;loc_7F6CC
		jsr	Refresh_ChildPosition(pc)
		jsr	Animate_RawMultiDelay(pc)
		jmp	Child_Draw_Sprite(pc)
; ---------------------------------------------------------------------------

+ ;loc_7F6CC:
		move.l	#loc_7F6D2,(a0)

loc_7F6D2:
		bchg	#2,$38(a0)
		bne.s	+ ;loc_7F6DE
		subq.b	#1,child_dy(a0)

+ ;loc_7F6DE:
		jsr	Refresh_ChildPosition(pc)
		jsr	Animate_RawMultiDelay(pc)
		movea.w	parent3(a0),a1
		btst	#3,$38(a1)
		beq.s	+ ;loc_7F6F6
		jmp	Child_DrawTouch_Sprite(pc)
; ---------------------------------------------------------------------------

+ ;loc_7F6F6:
		jmp	Go_Delete_Sprite(pc)
; ---------------------------------------------------------------------------

loc_7F6FA:
		lea	word_7FC5C(pc),a1
		jsr	SetUp_ObjAttributes3(pc)
		move.l	#loc_7F708,(a0)

loc_7F708:
		movea.w	parent3(a0),a1
		move.w	x_pos(a1),x_pos(a0)
		move.w	y_pos(a1),y_pos(a0)
		jmp	Child_Draw_Sprite(pc)
; ---------------------------------------------------------------------------

loc_7F71C:
		lea	ObjDat3_7FC74(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		move.l	#loc_70068,(a0)
		move.l	#loc_7F74C,$34(a0)
		move.l	#byte_7FCE2,$30(a0)
		move.w	#$3610,x_pos(a0)
		move.w	#$324,y_pos(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_7F74C:
		lea	(Player_1).w,a1
		move.w	x_pos(a0),d0
		move.w	x_pos(a1),d1
		sub.w	d1,d0
		bmi.s	+ ;loc_7F76A
		cmpi.w	#$40,d0
		bhs.s	+ ;loc_7F76A
		addi.w	#$40,d1
		move.w	d1,x_pos(a0)

+ ;loc_7F76A:
		lea	(byte_70419).l,a1
		jsr	(Animate_RawNoSST).l
		jsr	(MoveSprite2).l
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------

loc_7F782:
		lea	ObjDat3_7FC80(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		move.l	#loc_7F79C,(a0)
		move.w	#$3600,x_pos(a0)
		move.w	#$32C,y_pos(a0)

loc_7F79C:
		movea.w	parent3(a0),a1
		btst	#4,$38(a1)
		beq.s	+ ;loc_7F7C8
		move.l	#Sprite_OnScreen_Test,(a0)
		move.b	#$15,mapping_frame(a0)
		lea	(Child6_CreateBossExplosion).l,a2
		jsr	(CreateChild6_Simple).l
		bne.s	+ ;loc_7F7C8
		move.b	#6,subtype(a1)

+ ;loc_7F7C8:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_7F7CE:
		lea	word_7FC6E(pc),a1
		jsr	SetUp_ObjAttributes3(pc)
		move.l	#Obj_FlickerMove,(a0)
		move.b	subtype(a0),d0
		lsr.b	#1,d0
		addi.b	#$22,d0
		move.b	d0,mapping_frame(a0)
		moveq	#8,d0
		jsr	Set_IndexedVelocity(pc)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_7F7F6:
		move.l	#loc_7F81E,(a0)
		addi.w	#$38,y_pos(a0)
		move.w	#$1010,$3A(a0)
		moveq	#2,d0
		moveq	#4,d1
		tst.b	subtype(a0)
		beq.s	+ ;loc_7F816
		neg.w	d0
		moveq	#2,d1

+ ;loc_7F816:
		move.w	d0,x_vel(a0)
		move.b	d1,$39(a0)

loc_7F81E:
		subq.b	#1,$39(a0)
		bpl.s	+ ;loc_7F830
		move.b	#3,$39(a0)
		jsr	(sub_83E84).l

+ ;loc_7F830:
		move.w	x_vel(a0),d0
		move.w	x_pos(a0),d1
		add.w	d0,d1
		move.w	d1,x_pos(a0)
		tst.w	d0
		bmi.s	+ ;loc_7F84C
		move.w	#$35D0,d2
		cmp.w	d2,d1
		bhs.s	++ ;loc_7F854
		rts
; ---------------------------------------------------------------------------

+ ;loc_7F84C:
		move.w	#$3450,d2
		cmp.w	d2,d1
		bhi.s	locret_7F870

+ ;loc_7F854:
		move.w	d2,x_pos(a0)
		move.l	#loc_7F872,(a0)
		move.w	#-2,y_vel(a0)
		tst.b	subtype(a0)
		bne.s	locret_7F870
		bset	#1,(_unkFAB8).w

locret_7F870:
		rts
; ---------------------------------------------------------------------------

loc_7F872:
		subq.b	#1,$39(a0)
		bpl.s	+ ;loc_7F884
		move.b	#3,$39(a0)
		jsr	(sub_83E84).l

+ ;loc_7F884:
		move.w	y_vel(a0),d0
		move.w	y_pos(a0),d1
		add.w	d0,d1
		move.w	d1,y_pos(a0)
		cmpi.w	#$240,d1
		bhs.w	locret_7F0D8
		jmp	(Delete_Current_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_7F8A0:
		move.w	x_vel(a0),d0
		ext.l	d0
		lsl.l	#8,d0
		add.l	d0,x_pos(a0)
		move.w	y_vel(a0),d0
		moveq	#$38,d1
		tst.b	(Reverse_gravity_flag).w
		beq.s	+ ;loc_7F8BA
		neg.w	d1

+ ;loc_7F8BA:
		add.w	d1,d0
		move.w	d0,y_vel(a0)
		ext.l	d0
		lsl.l	#8,d0
		add.l	d0,y_pos(a0)
		rts
; End of function sub_7F8A0


; =============== S U B R O U T I N E =======================================


sub_7F8CA:
		tst.b	$3A(a0)
		sne	d0
		tst.b	(Reverse_gravity_flag).w
		beq.s	+ ;loc_7F8D8
		not.b	d0

+ ;loc_7F8D8:
		tst.b	d0
		beq.s	locret_7F8FE
		move.b	#4,routine(a0)
		move.b	#$C6,collision_flags(a0)
		clr.b	$39(a0)
		move.w	x_vel(a0),d0
		beq.s	+ ;loc_7F8FA
		move.w	d0,$3C(a0)
		clr.w	x_vel(a0)

+ ;loc_7F8FA:
		clr.w	y_vel(a0)

locret_7F8FE:
		rts
; End of function sub_7F8CA


; =============== S U B R O U T I N E =======================================


sub_7F900:
		jsr	Check_PlayerCollision(pc)
		beq.w	locret_7F9A6
		cmpi.b	#2,anim(a1)
		beq.s	+ ;loc_7F926
		tst.b	invulnerability_timer(a1)
		bne.w	locret_7F9A6
		btst	#Status_InAir,status_secondary(a1)
		bne.w	locret_7F9A6
		jmp	HurtCharacter_Directly(pc)
; ---------------------------------------------------------------------------

+ ;loc_7F926:
		btst	#Status_InAir,status(a1)
		beq.s	+ ;loc_7F95C
		bset	#Status_Roll,status(a1)
		move.b	#$E,y_radius(a1)
		move.b	#7,x_radius(a1)
		move.b	#2,anim(a1)
		move.w	#-$300,y_vel(a1)
		bset	#Status_InAir,status(a1)
		bsr.w	sub_7F4AC
		adda.w	#8,sp
		rts
; ---------------------------------------------------------------------------

+ ;loc_7F95C:
		move.b	#6,routine(a0)
		move.b	#$C6,collision_flags(a0)
		move.w	#7,child_dx(a0)
		move.b	#8,$39(a0)
		move.w	#$200,d4
		tst.w	x_vel(a1)
		bpl.s	+ ;loc_7F980
		neg.w	d4

+ ;loc_7F980:
		move.w	d4,x_vel(a0)
		move.w	ground_vel(a1),d4
		bpl.s	+ ;loc_7F98C
		neg.w	d4

+ ;loc_7F98C:
		cmpi.w	#$500,d4
		bhs.s	+ ;loc_7F996
		move.w	#$500,d4

+ ;loc_7F996:
		btst	#1,render_flags(a0)
		beq.s	+ ;loc_7F9A0
		neg.w	d4

+ ;loc_7F9A0:
		move.w	d4,y_vel(a0)
		addq.w	#4,sp

locret_7F9A6:
		rts
; End of function sub_7F900


; =============== S U B R O U T I N E =======================================


sub_7F9A8:
		jsr	Check_PlayerCollision(pc)
		beq.w	locret_7F9F6
		cmpi.b	#2,anim(a1)
		bne.s	+ ;loc_7F9C0
		btst	#Status_InAir,status(a1)
		beq.s	++ ;loc_7F9D6

+ ;loc_7F9C0:
		tst.b	invulnerability_timer(a1)
		bne.w	locret_7F9F6
		btst	#Status_InAir,status_secondary(a1)
		bne.w	locret_7F9F6
		jmp	HurtCharacter_Directly(pc)
; ---------------------------------------------------------------------------

+ ;loc_7F9D6:
		move.w	x_pos(a0),d0
		sub.w	x_pos(a1),d0
		smi	d1
		move.w	x_vel(a1),d2
		bmi.s	+ ;loc_7F9E8
		not.b	d1

+ ;loc_7F9E8:
		tst.b	d1
		beq.s	locret_7F9F6
		neg.w	d2
		move.w	d2,x_vel(a1)
		neg.w	ground_vel(a1)

locret_7F9F6:
		rts
; End of function sub_7F9A8


; =============== S U B R O U T I N E =======================================


sub_7F9F8:
		jsr	Check_PlayerCollision(pc)
		beq.s	locret_7FA5E
		tst.b	$39(a0)
		beq.s	+ ;loc_7FA0A
		subq.b	#1,$39(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_7FA0A:
		cmpi.b	#2,anim(a1)
		beq.s	+ ;loc_7FA2C
		cmpi.b	#9,anim(a1)
		beq.s	+ ;loc_7FA2C

loc_7FA1A:
		tst.b	$34(a1)
		bne.s	locret_7FA5E
		btst	#Status_Invincible,status_secondary(a1)
		bne.s	locret_7FA5E
		jmp	HurtCharacter_Directly(pc)
; ---------------------------------------------------------------------------

+ ;loc_7FA2C:
		jsr	(Find_OtherObject).l
		cmpi.w	#$10,d2
		bhs.s	loc_7FA1A
		btst	#1,render_flags(a0)
		sne	d2
		tst.w	d1
		bne.s	+ ;loc_7FA46
		not.b	d2

+ ;loc_7FA46:
		tst.b	d2
		bne.s	loc_7FA1A
		neg.w	x_vel(a1)
		neg.w	y_vel(a1)
		neg.w	ground_vel(a1)
		bsr.w	sub_7F4AC
		adda.w	#8,sp

locret_7FA5E:
		rts
; End of function sub_7F9F8


; =============== S U B R O U T I N E =======================================


sub_7FA60:
		move.w	x_pos(a0),d0
		tst.w	x_vel(a0)
		bmi.s	+ ;loc_7FA72
		cmpi.w	#$3598,d0
		bhs.s	++ ;loc_7FA78
		rts
; ---------------------------------------------------------------------------

+ ;loc_7FA72:
		cmpi.w	#$3488,d0
		bhi.s	locret_7FA7C

+ ;loc_7FA78:
		neg.w	x_vel(a0)

locret_7FA7C:
		rts
; End of function sub_7FA60


; =============== S U B R O U T I N E =======================================


sub_7FA7E:
		jsr	Check_PlayerCollision(pc)
		beq.s	locret_7FACA
		move.b	$3C(a0),d0
		move.b	(V_int_run_count+3).w,d1
		andi.b	#3,d1
		subq.b	#2,d1
		add.w	d1,d0
		jsr	(GetSineCosine).l
		lsl.w	#3,d0
		lsl.w	#3,d1
		move.w	d0,x_vel(a1)
		move.w	d1,y_vel(a1)
		bset	#Status_InAir,status(a1)
		bclr	#Status_RollJump,status(a1)
		bclr	#Status_Push,status(a1)
		clr.b	jumping(a1)
		move.b	#1,anim(a0)
		moveq	#signextendB(sfx_Bumper),d0
		jsr	(Play_SFX).l

locret_7FACA:
		rts
; End of function sub_7FA7E


; =============== S U B R O U T I N E =======================================


sub_7FACC:
		moveq	#0,d0
		move.b	$3C(a0),d0
		bclr	#7,d0
		sne	d2
		moveq	#4,d3
		lea	byte_7FB0A(pc),a1
		btst	#6,d0
		beq.s	loc_7FAE8
		moveq	#$A,d3
		addq.w	#8,a1

loc_7FAE8:
		cmp.b	(a1)+,d0
		blo.s	+ ;loc_7FAF0
		addq.w	#1,d3
		bra.s	loc_7FAE8
; ---------------------------------------------------------------------------

+ ;loc_7FAF0:
		move.b	d3,mapping_frame(a0)
		move.b	render_flags(a0),d0
		andi.b	#$FC,d0
		tst.b	d2
		beq.s	+ ;loc_7FB04
		ori.b	#3,d0

+ ;loc_7FB04:
		move.b	d0,render_flags(a0)
		rts
; End of function sub_7FACC

; ---------------------------------------------------------------------------
byte_7FB0A:
		dc.b    5, $10, $1B, $26, $31, $3C, $40
		even
		dc.b  $45, $50, $5B, $66, $71, $7C, $80
		even

; =============== S U B R O U T I N E =======================================


sub_7FB1A:
		moveq	#0,d0
		move.b	subtype(a0),d0
		move.w	d0,d1
		lsr.w	#1,d0
		addi.b	#$1F,d0
		move.b	d0,mapping_frame(a0)
		add.w	d1,d1
		move.l	word_7FB42(pc,d1.w),x_vel(a0)	; and y_vel
		btst	#1,render_flags(a0)
		beq.s	locret_7FB40
		neg.w	y_vel(a0)

locret_7FB40:
		rts
; End of function sub_7FB1A

; ---------------------------------------------------------------------------
word_7FB42:
		dc.w  -$16A, -$16A
		dc.w      0, -$200
		dc.w   $16A, -$16A

; =============== S U B R O U T I N E =======================================


sub_7FB4E:
		movea.w	parent3(a0),a1
		btst	#6,status(a1)
		bne.s	locret_7FB88
		lea	word_7FB8A(pc),a2
		jsr	Check_InMyRange(pc)
		beq.s	locret_7FB88
		btst	#1,render_flags(a0)
		sne	d0
		tst.w	y_vel(a0)
		bpl.s	+ ;loc_7FB74
		not.b	d0

+ ;loc_7FB74:
		tst.b	d0
		beq.s	+ ;loc_7FB82
		st	$42(a1)
		bset	#6,status(a1)

+ ;loc_7FB82:
		bsr.w	sub_7F4B8
		addq.w	#4,sp

locret_7FB88:
		rts
; End of function sub_7FB4E

; ---------------------------------------------------------------------------
word_7FB8A:
		dc.w   -$28,   $50,  -$28,   $50

; =============== S U B R O U T I N E =======================================


sub_7FB92:
		tst.b	$42(a0)
		beq.s	locret_7FBD4
		tst.b	$20(a0)
		bne.s	+ ;loc_7FBB2
		subq.b	#1,collision_property(a0)
		beq.s	+++ ;loc_7FBD6
		move.b	#$20,$20(a0)
		moveq	#signextendB(sfx_BossHit),d0
		jsr	(Play_SFX).l

+ ;loc_7FBB2:
		moveq	#0,d0
		btst	#0,$20(a0)
		bne.s	+ ;loc_7FBC0
		addi.w	#2*6,d0

+ ;loc_7FBC0:
		bsr.w	sub_7FC0E
		subq.b	#1,$20(a0)
		bne.s	locret_7FBD4
		bclr	#6,status(a0)
		clr.b	$42(a0)

locret_7FBD4:
		rts
; ---------------------------------------------------------------------------

+ ;loc_7FBD6:
		move.l	#Wait_NewDelay,(a0)
		bset	#7,status(a0)
		bset	#0,(_unkFAB8).w
		move.l	#loc_7F210,$34(a0)
		lea	(Child6_CreateBossExplosion).l,a2
		jsr	(CreateChild6_Simple).l
		jsr	(AllocateObject).l
		bne.s	+ ;loc_7FC0A
		move.l	#loc_7FC3E,(a1)

+ ;loc_7FC0A:
		jmp	BossDefeated_StopTimer(pc)
; End of function sub_7FB92


; =============== S U B R O U T I N E =======================================


sub_7FC0E:
		lea	word_7FC1A(pc),a1
		lea	word_7FC26(pc,d0.w),a2
		jmp	CopyWordData_6(pc)
; End of function sub_7FC0E

; ---------------------------------------------------------------------------
word_7FC1A:
		dc.w Normal_palette_line_2+$06, Normal_palette_line_2+$08, Normal_palette_line_2+$16
		dc.w Normal_palette_line_2+$18, Normal_palette_line_2+$1A, Normal_palette_line_2+$1C
word_7FC26:
		dc.w    $2A,     6,  $A48,  $644,  $422,     0
		dc.w   $888,  $AAA,  $888,  $AAA,  $CCC,  $EEE
; ---------------------------------------------------------------------------

loc_7FC3E:
		clr.b	(Reverse_gravity_flag).w
		rts
; ---------------------------------------------------------------------------
ObjDat_DEZEndBoss:
		dc.l Map_DEZEndBoss
		dc.w make_art_tile($38A,1,1)
		dc.w   $200
		dc.b  $20, $20,   0,   0
word_7FC50:
		dc.w   $180
		dc.b  $18, $18,   4, $D7
word_7FC56:
		dc.w   $200
		dc.b  $18,   4, $16, $9C
word_7FC5C:
		dc.w   $200
		dc.b  $18,  $C, $13, $9C
word_7FC62:
		dc.w   $280
		dc.b  $10, $18, $11,   0
word_7FC68:
		dc.w   $280
		dc.b    8,   8, $1F, $98
word_7FC6E:
		dc.w      0
		dc.b  $28, $28, $22,   0
ObjDat3_7FC74:
		dc.l Map_FBZRobotnikStand
		dc.w make_art_tile($466,0,1)
		dc.w   $200
		dc.b  $20, $20,   0,   0
ObjDat3_7FC80:
		dc.l Map_DEZEndBoss
		dc.w make_art_tile($38A,1,1)
		dc.w   $180
		dc.b   $C, $14, $14,   0
ChildObjDat_7FC8C:
		dc.w 2-1
		dc.l loc_7F71C
		dc.b    0,   0
		dc.l loc_7F782
		dc.b    0,   0
ChildObjDat_7FC9A:
		dc.w 1-1
		dc.l loc_7F336
ChildObjDat_7FCA0:
		dc.w 2-1
		dc.l loc_7F64A
		dc.b    0, $14
		dc.l loc_7F398
		dc.b    0,  $C
ChildObjDat_7FCAE:
		dc.w 1-1
		dc.l loc_7F6FA
ChildObjDat_7FCB4:
		dc.w 3-1
		dc.l loc_7F60A
		dc.b -$10,  -9
		dc.l loc_7F60A
		dc.b    0, -$C
		dc.l loc_7F60A
		dc.b  $10,  -9
ChildObjDat_7FCC8:
		dc.w 6-1
		dc.l loc_7F7CE
ChildObjDat_7FCCE:
		dc.w 2-1
		dc.l loc_7F7F6
byte_7FCD4:
		dc.b    3,   0,   1,   2, $F4
byte_7FCD9:
		dc.b    3,   2,   1,   0, $F4
byte_7FCDE:
		dc.b    3, $11, $12, $FC
byte_7FCE2:
		dc.b    0,   7
		dc.b    1, $17
		dc.b    0,   7
		dc.b    1,  $F
		dc.b    0, $3F
		dc.b    1,   7
		dc.b  $FC
byte_7FCEF:
		dc.b  $16,   0
		dc.b  $17,   1
		dc.b  $1E,   1
		dc.b  $18,   0
		dc.b  $19,   1
		dc.b  $1E,   1
		dc.b  $1A,   0
		dc.b  $1B,   1
		dc.b  $1E,   4
		dc.b  $1C,   0
		dc.b  $1D,   1
		dc.b  $1E,   1
		dc.b  $FC
		even
Pal_DEZEndBoss:
		binclude "Levels/DEZ/Palettes/End Boss.bin"
		even
byte_7FD28:
		dc.b    0
		dc.b    1
		dc.b    2
		dc.b    3
		dc.b    4
		dc.b    5
		dc.b    6
		dc.b    7
		dc.b    8
		dc.b    9
		dc.b   $A
		dc.b   $B
		dc.b   $C
		dc.b   $D
		dc.b   $D
		dc.b   $E
		dc.b   $F
		dc.b  $10
		dc.b  $11
		dc.b  $12
		dc.b  $13
		dc.b  $14
		dc.b  $15
		dc.b  $15
		dc.b  $16
		dc.b  $17
		dc.b  $18
		dc.b  $19
		dc.b  $19
		dc.b  $1A
		dc.b  $1B
		dc.b  $1C
		dc.b  $1C
		dc.b  $1D
		dc.b  $1E
		dc.b  $1E
		dc.b  $1F
		dc.b  $20
		dc.b  $20
		dc.b  $21
		dc.b  $21
		dc.b  $22
		dc.b  $22
		dc.b  $23
		dc.b  $23
		dc.b  $24
		dc.b  $24
		dc.b  $25
		dc.b  $25
		dc.b  $25
		dc.b  $26
		dc.b  $26
		dc.b  $26
		dc.b  $27
		dc.b  $27
		dc.b  $27
		dc.b  $27
		dc.b  $27
		dc.b  $28
		dc.b  $28
		dc.b  $28
		dc.b  $28
		dc.b  $28
		dc.b  $28
		even
; ---------------------------------------------------------------------------

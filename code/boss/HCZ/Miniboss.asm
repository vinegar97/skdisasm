Obj_HCZMiniboss:
		lea	word_69ED2(pc),a1
		jsr	(Check_CameraInRange).l
		move.l	#loc_69EDA,(a0)
		move.b	#1,(Boss_flag).w
		st	(Events_bg+$16).w
		moveq	#$5B,d0
		jsr	(Load_PLC).l
		move.w	#$300,(Camera_min_Y_pos).w
		lea	ChildObjDat_6AD6E(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------
word_69ED2:
		dc.w   $300,  $400, $3500, $3700
; ---------------------------------------------------------------------------

loc_69EDA:
		btst	#0,$38(a0)
		bne.s	loc_69EFE
		move.w	#$638,d0
		cmp.w	(Camera_Y_pos).w,d0
		bhi.s	loc_69EFE
		bset	#0,$38(a0)
		move.w	d0,(Camera_min_Y_pos).w
		move.w	d0,(Camera_max_Y_pos).w
		move.w	d0,(Camera_target_max_Y_pos).w

loc_69EFE:
		btst	#1,$38(a0)
		move.w	#$3680,d0
		move.w	(Camera_X_pos).w,d1
		move.w	d1,(Camera_min_X_pos).w
		cmp.w	d1,d0
		bhi.s	loc_69F22
		bset	#1,$38(a0)
		move.w	d0,(Camera_min_X_pos).w
		move.w	d0,(Camera_max_X_pos).w

loc_69F22:
		cmpi.b	#3,$38(a0)
		beq.s	loc_69F2C
		rts
; ---------------------------------------------------------------------------

loc_69F2C:
		move.w	(Camera_max_X_pos).w,(Camera_stored_max_X_pos).w
		move.w	y_pos(a0),$44(a0)
		move.l	#Obj_Wait,(a0)
		move.w	#2*60,$2E(a0)
		move.l	#loc_69F64,$34(a0)
		moveq	#signextendB(mus_FadeOut),d0
		jsr	(Play_Music).l
		bset	#3,$38(a0)
		lea	Pal_HCZMiniboss(pc),a1
		jmp	(PalLoad_Line1).l
; ---------------------------------------------------------------------------

loc_69F64:
		move.l	#Obj_HCZ_MinibossLoop,(a0)
		moveq	#signextendB(mus_Miniboss),d0
		jsr	(Play_Music).l
		move.b	#mus_Miniboss,(Current_music+1).w

locret_69F78:
		rts
; ---------------------------------------------------------------------------

Obj_HCZ_MinibossLoop:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	HCZ_MinibossLoop_Index(pc,d0.w),d1
		jsr	HCZ_MinibossLoop_Index(pc,d1.w)
		bsr.w	sub_6AC48
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------
HCZ_MinibossLoop_Index:
		dc.w loc_69FAA-HCZ_MinibossLoop_Index
		dc.w loc_69FE4-HCZ_MinibossLoop_Index
		dc.w loc_6A00A-HCZ_MinibossLoop_Index
		dc.w loc_69FE4-HCZ_MinibossLoop_Index
		dc.w loc_6A00A-HCZ_MinibossLoop_Index
		dc.w loc_6A076-HCZ_MinibossLoop_Index
		dc.w loc_6A0C2-HCZ_MinibossLoop_Index
		dc.w loc_6A0F8-HCZ_MinibossLoop_Index
		dc.w loc_6A110-HCZ_MinibossLoop_Index
		dc.w loc_6A15A-HCZ_MinibossLoop_Index
		dc.w loc_6A00A-HCZ_MinibossLoop_Index
		dc.w loc_6A216-HCZ_MinibossLoop_Index
; ---------------------------------------------------------------------------

loc_69FAA:
		lea	ObjDat_HCZMiniboss_Loop(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.b	#6,collision_property(a0)
		move.b	#$28,y_radius(a0)
		bset	#3,$38(a0)
		move.w	#$100,y_vel(a0)
		move.w	#$DF,$2E(a0)
		move.l	#loc_69FF0,$34(a0)
		lea	Child1_HCZMiniboss_RocketsEngine(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_69FE4:
		jsr	(MoveSprite2).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_69FF0:
		move.b	#4,routine(a0)
		clr.w	y_vel(a0)
		move.w	#60-1,$2E(a0)
		move.l	#loc_6A010,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_6A00A:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_6A010:
		move.b	#6,routine(a0)
		move.w	#-$400,y_vel(a0)
		move.w	#$37,$2E(a0)
		move.l	#loc_6A02C,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_6A02C:
		move.b	#8,routine(a0)
		move.w	#60-1,$2E(a0)
		move.l	#loc_6A042,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_6A042:
		bsr.w	sub_6AAD2

loc_6A046:
		move.b	#$A,routine(a0)
		moveq	#signextendB(sfx_Roll),d0
		jsr	(Play_SFX).l
		bset	#6,$38(a0)
		bclr	#7,$38(a0)
		move.w	#$400,y_vel(a0)
		move.w	#$47,$2E(a0)
		move.l	#loc_6A098,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_6A076:
		btst	#7,$38(a0)
		bne.s	loc_6A08C
		move.w	y_pos(a0),d0
		cmp.w	(Water_level).w,d0
		blo.s	loc_6A08C
		bsr.w	sub_6AAB6

loc_6A08C:
		jsr	(MoveSprite2).l
		jmp	(ObjHitFloor_DoRoutine).l
; ---------------------------------------------------------------------------

loc_6A098:
		move.b	#$C,routine(a0)
		move.w	$40(a0),x_vel(a0)
		neg.w	$40(a0)
		clr.w	y_vel(a0)
		move.w	#$2F,$2E(a0)
		move.l	#loc_6A0D8,$34(a0)
		bclr	#7,$38(a0)
		rts
; ---------------------------------------------------------------------------

loc_6A0C2:
		jsr	(MoveSprite2).l
		jsr	(ObjCheckFloorDist).l
		add.w	d1,y_pos(a0)
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_6A0D8:
		move.w	#-$400,y_vel(a0)
		clr.w	x_vel(a0)
		subq.b	#1,$39(a0)
		bmi.s	loc_6A0F0
		move.b	#$E,routine(a0)
		rts
; ---------------------------------------------------------------------------

loc_6A0F0:
		move.b	#$10,routine(a0)
		rts
; ---------------------------------------------------------------------------

loc_6A0F8:
		bsr.w	sub_6AAA0
		jsr	(MoveSprite2).l
		move.w	y_pos(a0),d0
		cmp.w	$44(a0),d0
		bls.w	loc_6A046
		rts
; ---------------------------------------------------------------------------

loc_6A110:
		bsr.w	sub_6AAA0
		jsr	(MoveSprite2).l
		move.w	$44(a0),d0
		addi.w	#$108,d0
		cmp.w	y_pos(a0),d0
		bhs.s	loc_6A12A
		rts
; ---------------------------------------------------------------------------

loc_6A12A:
		move.b	#$12,routine(a0)
		bclr	#7,$38(a0)
		move.w	d0,y_pos(a0)
		move.w	#$180,d0
		tst.w	$40(a0)
		bpl.s	loc_6A146
		neg.w	d0

loc_6A146:
		move.w	d0,x_vel(a0)
		move.w	#$3F,$2E(a0)
		move.l	#loc_6A16C,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_6A15A:
		addi.w	#$20,y_vel(a0)
		jsr	(MoveSprite2).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_6A16C:
		move.b	#$14,routine(a0)
		moveq	#signextendB(sfx_DoorClose),d0
		jsr	(Play_SFX).l
		bclr	#3,$38(a0)
		move.w	#$9F,$2E(a0)
		move.l	#loc_6A194,$34(a0)
		clr.w	x_vel(a0)
		rts
; ---------------------------------------------------------------------------

loc_6A194:
		bset	#2,$38(a0)
		move.w	#$17F,$2E(a0)
		move.l	#loc_6A1AA,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_6A1AA:
		bclr	#2,$38(a0)
		move.w	#$7F,$2E(a0)
		move.l	#loc_6A1C0,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_6A1C0:
		bset	#3,$38(a0)
		move.w	#$3F,$2E(a0)
		move.l	#loc_6A1C0,$34(a0)
		move.l	#loc_6A1DE,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_6A1DE:
		move.b	#2,routine(a0)
		move.w	#-$20,y_vel(a0)
		move.w	#$7F,$2E(a0)
		move.l	#loc_6A1FA,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_6A1FA:
		move.b	#$16,routine(a0)
		bclr	#6,$38(a0)
		move.w	#-$400,y_vel(a0)
		moveq	#signextendB(sfx_LavaBall),d0
		jsr	(Play_SFX).l
		rts
; ---------------------------------------------------------------------------

loc_6A216:
		jsr	(MoveSprite2).l
		move.w	y_pos(a0),d0
		cmp.w	$44(a0),d0
		bls.w	loc_6A042
		rts
; ---------------------------------------------------------------------------

loc_6A22A:
		st	(_unkFAA2).w
		jsr	(Obj_EndSignControl).l
		jsr	(AllocateObject).l
		bne.s	loc_6A242
		move.l	#loc_6A24C,(a1)

loc_6A242:
		lea	ChildObjDat_6ADAA(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_6A24C:
		tst.b	(_unkFAA8).w
		bne.w	locret_69F78
		move.l	#loc_6A270,(a0)
		clr.w	(Ctrl_1_logical).w
		clr.w	(Ctrl_2_logical).w
		st	(Ctrl_1_locked).w
		st	(Ctrl_2_locked).w
		move.b	#$80,(Player_1+object_control).w

loc_6A270:
		tst.b	(End_of_level_flag).w
		beq.w	locret_69F78
		move.l	#loc_6A2A0,(a0)
		lea	ChildObjDat_6ADA4(pc),a2
		tst.b	(Player_mode+1).w
		beq.s	loc_6A28C
		lea	ChildObjDat_6AD9E(pc),a2

loc_6A28C:
		jsr	(CreateChild6_Simple).l
		move.w	#$2F,$2E(a0)
		move.l	#Go_Delete_Sprite,$34(a0)

loc_6A2A0:
		btst	#0,$38(a0)
		beq.w	locret_69F78
		lea	ChildObjDat_6AD98(pc),a2
		jsr	(CreateChild6_Simple).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

Obj_HCZMiniboss_Rockets:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	HCZMiniboss_Rockets_Index(pc,d0.w),d1
		jsr	HCZMiniboss_Rockets_Index(pc,d1.w)
		moveq	#$20,d0
		jmp	(Child_DrawTouch_Sprite_FlickerMove).l
; ---------------------------------------------------------------------------
HCZMiniboss_Rockets_Index:
		dc.w loc_6A2DE-HCZMiniboss_Rockets_Index
		dc.w loc_6A2F8-HCZMiniboss_Rockets_Index
		dc.w loc_6A34C-HCZMiniboss_Rockets_Index
		dc.w loc_6A36C-HCZMiniboss_Rockets_Index
		dc.w loc_6A37A-HCZMiniboss_Rockets_Index
		dc.w loc_6A404-HCZMiniboss_Rockets_Index
		dc.w loc_6A41E-HCZMiniboss_Rockets_Index
; ---------------------------------------------------------------------------

loc_6A2DE:
		lea	ObjDat_HCZMiniboss_Rockets(pc),a1
		jsr	(SetUp_ObjAttributes).l
		bset	#6,$38(a0)
		lea	ChildObjDat_6AD76(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_6A2F8:
		clr.b	collision_flags(a0)
		movea.w	parent3(a0),a1
		btst	#3,$38(a1)
		beq.w	locret_69F78
		move.b	#4,routine(a0)
		move.b	#1,$40(a0)
		move.w	#$3F,$2E(a0)
		move.l	#loc_6A356,$34(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		move.w	word_6A344(pc,d0.w),$3C(a0)
		cmpi.b	#4,d0
		blo.s	locret_6A342
		bset	#0,render_flags(a0)
		move.b	#6,routine(a0)

locret_6A342:
		rts
; ---------------------------------------------------------------------------
word_6A344:
		dc.w      0, $8080, $8000,   $80
; ---------------------------------------------------------------------------

loc_6A34C:
		bsr.w	sub_6AB1A
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_6A356:
		move.b	#8,routine(a0)
		move.w	#$3F,$2E(a0)
		move.l	#loc_6A384,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_6A36C:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_6A372:
		move.b	#2,routine(a0)
		rts
; ---------------------------------------------------------------------------

loc_6A37A:
		bsr.w	sub_6AB1A
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_6A384:
		move.b	#2,$40(a0)
		move.b	#$8B,collision_flags(a0)
		move.w	#$1F,$2E(a0)
		move.l	#loc_6A3A0,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_6A3A0:
		move.b	#$A,routine(a0)
		move.b	#4,$40(a0)
		move.l	#loc_6A416,$34(a0)
		bclr	#6,$38(a0)
		moveq	#signextendB(sfx_LevelProjectile),d0
		jsr	(Play_SFX).l
		rts
; ---------------------------------------------------------------------------

loc_6A3C4:
		move.b	#2,$40(a0)
		move.w	#$1F,$2E(a0)
		move.l	#loc_6A3DA,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_6A3DA:
		move.b	#6,routine(a0)
		cmpi.b	#4,subtype(a0)
		blo.s	loc_6A3EE
		move.b	#4,routine(a0)

loc_6A3EE:
		move.b	#1,$40(a0)
		move.w	#$3F,$2E(a0)
		move.l	#loc_6A372,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_6A404:
		bsr.w	sub_6AB1A
		movea.w	parent3(a0),a1
		btst	#3,$38(a1)
		bne.w	locret_69F78

loc_6A416:
		move.b	#$C,routine(a0)
		rts
; ---------------------------------------------------------------------------

loc_6A41E:
		bsr.w	sub_6AB1A
		moveq	#0,d0
		move.b	subtype(a0),d0
		lsr.b	#1,d0
		move.b	byte_6A45C(pc,d0.w),d1
		cmp.b	$3C(a0),d1
		beq.s	loc_6A436
		rts
; ---------------------------------------------------------------------------

loc_6A436:
		move.b	#8,routine(a0)
		clr.b	collision_flags(a0)
		move.b	#2,$40(a0)
		move.w	#$1F,$2E(a0)
		move.l	#loc_6A3C4,$34(a0)
		bset	#6,$38(a0)
		rts
; ---------------------------------------------------------------------------
byte_6A45C:
		dc.b  $80,   0, $C0, $40
; ---------------------------------------------------------------------------

loc_6A460:
		lea	word_6AD08(pc),a1
		jsr	(SetUp_ObjAttributes2).l
		move.l	#loc_6A478,(a0)
		bset	#4,shield_reaction(a0)
		rts
; ---------------------------------------------------------------------------

loc_6A478:
		bsr.w	sub_6ABA8

loc_6A47C:
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.s	loc_6A4A2
		btst	#6,$38(a1)
		bne.w	locret_69F78
		btst	#0,(V_int_run_count+3).w
		bne.w	locret_69F78
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------

loc_6A4A2:
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

Obj_HCZMiniboss_Engine:
		lea	ObjDat2_HCZMiniboss_Engine(pc),a1
		jsr	(SetUp_ObjAttributes2).l
		move.l	#loc_6A4C0,(a0)
		bset	#4,shield_reaction(a0)
		rts
; ---------------------------------------------------------------------------

loc_6A4C0:
		jsr	(Refresh_ChildPosition).l
		bra.s	loc_6A47C
; ---------------------------------------------------------------------------

loc_6A4C8:
		lea	ObjSlot_6AD30(pc),a1
		jsr	(SetUp_ObjAttributesSlotted).l
		move.w	(Water_level).w,y_pos(a0)
		move.l	#Obj_Wait,(a0)
		tst.b	subtype(a0)
		beq.s	loc_6A4EA
		move.w	#7,$2E(a0)

loc_6A4EA:
		move.l	#loc_6A4F4,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_6A4F4:
		move.l	#loc_6A504,(a0)
		move.l	#Go_Delete_SpriteSlotted3,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_6A504:
		lea	byte_6AE3B(pc),a1
		jsr	(Animate_RawNoSST).l
		lea	DPLCPtr_HCZMinibossSplash(pc),a2
		jsr	(Perform_DPLC).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_6A51E:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_6A536(pc,d0.w),d1
		jsr	off_6A536(pc,d1.w)
		bsr.w	sub_6A960
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------
off_6A536:
		dc.w loc_6A542-off_6A536
		dc.w loc_6A55C-off_6A536
		dc.w loc_6A57C-off_6A536
		dc.w loc_6A5B2-off_6A536
		dc.w loc_6A5D8-off_6A536
		dc.w loc_6A618-off_6A536
; ---------------------------------------------------------------------------

loc_6A542:
		lea	ObjDat3_6AD18(pc),a1
		jsr	(SetUp_ObjAttributes).l
		addi.w	#$148,y_pos(a0)
		clr.w	$42(a0)
		clr.w	$44(a0)
		rts
; ---------------------------------------------------------------------------

loc_6A55C:
		tst.b	render_flags(a0)
		bpl.w	locret_69F78
		move.b	#4,routine(a0)
		lea	Pal_HCZMinibossWater(pc),a1
		lea	(Water_palette_line_2).w,a2
		moveq	#bytesToLcnt($20),d0

loc_6A574:
		move.l	(a1)+,(a2)+
		dbf	d0,loc_6A574
		rts
; ---------------------------------------------------------------------------

loc_6A57C:
		movea.w	parent3(a0),a1
		btst	#2,$38(a1)
		beq.w	locret_69F78
		move.b	#6,routine(a0)
		move.l	#byte_6ADEC,$30(a0)
		move.l	#loc_6A5BC,$34(a0)
		moveq	#signextendB(sfx_FanBig),d0
		jsr	(Play_SFX).l
		lea	ChildObjDat_6AD92(pc),a2
		jmp	(CreateChild6_Simple).l
; ---------------------------------------------------------------------------

loc_6A5B2:
		lea	byte_6ADEC(pc),a1
		jmp	(Animate_RawNoSSTMultiDelay).l
; ---------------------------------------------------------------------------

loc_6A5BC:
		move.b	#8,routine(a0)
		move.l	#byte_6ADEC,$30(a0)
		move.l	#loc_6A622,$34(a0)
		clr.b	collision_property(a0)
		rts
; ---------------------------------------------------------------------------

loc_6A5D8:
		bsr.w	sub_6A9B8
		movea.w	parent3(a0),a1
		btst	#2,$38(a1)
		beq.s	loc_6A5FA
		moveq	#signextendB(sfx_BossRotate),d0
		jsr	(Play_SFX_Continuous).l
		lea	byte_6AE11(pc),a1
		jmp	(Animate_RawNoSST).l
; ---------------------------------------------------------------------------

loc_6A5FA:
		move.b	#$A,routine(a0)
		bset	#3,$38(a0)
		move.l	#loc_6A622,$34(a0)
		bsr.w	loc_6A986
		jmp	(Animate_RawMultiDelay).l
; ---------------------------------------------------------------------------

loc_6A618:
		lea	byte_6AE16(pc),a1
		jmp	(Animate_RawNoSSTMultiDelay).l
; ---------------------------------------------------------------------------

loc_6A622:
		move.b	#4,routine(a0)
		move.b	#$16,mapping_frame(a0)
		bclr	#3,$38(a0)
		rts
; ---------------------------------------------------------------------------

loc_6A636:
		movea.w	parent3(a0),a1
		btst	#4,$38(a1)
		beq.s	loc_6A656
		lea	ChildObjDat_6ADC4(pc),a2
		jsr	(CreateChild1_Normal).l
		bsr.w	loc_6A986
		jsr	(Go_Delete_Sprite_2).l

loc_6A656:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_6A65C:
		lea	ObjDat3_6AD24(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_6A6B8,(a0)
		jsr	(Random_Number).l
		andi.w	#$FF,d0
		ext.w	d0
		add.w	d0,x_pos(a0)
		swap	d0
		andi.w	#$3F,d0
		subq.w	#8,d0
		add.w	d0,y_pos(a0)
		andi.w	#3,d0
		move.b	d0,mapping_frame(a0)
		lsl.w	#2,d0
		move.l	off_6A6A8(pc,d0.w),$30(a0)
		move.w	#$1F,$2E(a0)
		move.l	#loc_6A6D2,$34(a0)
		rts
; ---------------------------------------------------------------------------
off_6A6A8:
		dc.l byte_6AE46
		dc.l byte_6AE4A
		dc.l byte_6AE4E
		dc.l byte_6AE52
; ---------------------------------------------------------------------------

loc_6A6B8:
		movea.w	parent3(a0),a3
		bsr.w	sub_6A9AA
		jsr	(Animate_Raw).l
		jsr	(Obj_Wait).l
		jmp	(Child_Draw_Sprite2).l
; ---------------------------------------------------------------------------

loc_6A6D2:
		move.l	#loc_6A6E4,(a0)
		movea.l	$30(a0),a1
		move.b	1(a1),mapping_frame(a0)
		rts
; ---------------------------------------------------------------------------

loc_6A6E4:
		movea.w	parent3(a0),a3
		btst	#3,$38(a3)
		bne.s	loc_6A6FA
		bsr.w	sub_6A9AA
		jmp	(Child_Draw_Sprite2).l
; ---------------------------------------------------------------------------

loc_6A6FA:
		move.l	#loc_6A6B8,(a0)
		move.w	#$1F,$2E(a0)
		move.l	#Go_Delete_Sprite,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_6A710:
		lea	ObjDat3_6AD24(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_6A79C,(a0)
		move.w	(Camera_X_pos).w,d0
		addi.w	#$A0,d0
		move.w	d0,x_pos(a0)
		move.w	d0,$3A(a0)
		move.w	(Water_level).w,d0
		addq.w	#8,d0
		move.w	d0,y_pos(a0)
		jsr	(Random_Number).l
		andi.w	#$FF,d0
		move.w	d0,d1
		ext.w	d0
		bpl.s	loc_6A74E
		st	$3C(a0)

loc_6A74E:
		add.w	d0,x_pos(a0)
		bsr.w	sub_6A940
		lsl.w	#4,d0
		move.w	d0,x_vel(a0)
		andi.b	#1,d1
		move.b	d1,anim_frame(a0)
		swap	d0
		andi.w	#$1F,d0
		add.w	d0,y_pos(a0)
		andi.w	#3,d0
		move.b	d0,mapping_frame(a0)
		lsl.w	#2,d0
		lea	off_6A6A8(pc),a1
		move.l	(a1,d0.w),$30(a0)
		move.w	#$200,y_vel(a0)
		move.w	#$BF,$2E(a0)
		move.l	#Go_Delete_Sprite,$34(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_6A79C:
		tst.b	render_flags(a0)
		bpl.s	loc_6A7BE
		bsr.w	sub_6A916
		jsr	(MoveSprite2).l
		jsr	(Animate_Raw).l
		jsr	(Obj_Wait).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_6A7BE:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_6A7C4:
		lea	(Player_1).w,a1
		btst	#Status_Underwater,status(a1)
		beq.w	locret_69F78
		move.l	#loc_6A872,(a0)
		clr.b	(_unkFAA2).w
		movea.w	parent3(a0),a1
		bset	#0,$38(a1)
		move.b	#4,render_flags(a0)
		lea	(Player_1).w,a1
		lea	(Ctrl_1_locked).w,a2
		tst.b	subtype(a0)
		beq.s	loc_6A80C
		lea	(Player_2).w,a1
		lea	(Ctrl_2_locked).w,a2
		btst	#Status_Underwater,status(a1)
		beq.w	loc_6A86C

loc_6A80C:
		clr.b	(a2)
		tst.l	(a1)
		beq.s	loc_6A86C
		move.w	a1,$44(a0)
		bclr	#7,art_tile(a0)
		move.w	x_pos(a1),d0
		move.w	d0,x_pos(a0)
		move.w	y_pos(a1),y_pos(a0)
		move.w	(Camera_X_pos).w,d1
		addi.w	#$A0,d1
		move.w	d1,$3A(a0)
		sub.w	d1,d0
		bpl.s	loc_6A83E
		st	$3C(a0)

loc_6A83E:
		bsr.w	sub_6A940
		move.w	#$200,y_vel(a0)
		bset	#Status_InAir,status(a1)
		move.b	#1,object_control(a1)
		move.b	#$F,anim(a1)
		clr.b	spin_dash_flag(a1)
		clr.w	x_vel(a1)
		clr.w	y_vel(a1)
		clr.w	ground_vel(a1)
		rts
; ---------------------------------------------------------------------------

loc_6A86C:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_6A872:
		bsr.w	sub_6A916
		jsr	(MoveSprite2).l
		movea.w	$44(a0),a1
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),d0
		move.w	d0,y_pos(a1)
		cmpi.w	#$828,d0
		bhs.s	loc_6A896
		rts
; ---------------------------------------------------------------------------

loc_6A896:
		tst.b	subtype(a0)
		beq.s	loc_6A8AE
		lea	(Player_2).w,a1
		tst.l	(a1)
		beq.s	loc_6A8C0
		jsr	(Restore_PlayerControl2).l
		bra.w	loc_6A8C0
; ---------------------------------------------------------------------------

loc_6A8AE:
		jsr	(Restore_PlayerControl).l
		move.w	#0,(Camera_stored_min_Y_pos).w
		jsr	(Make_LevelSizeObj).l

loc_6A8C0:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_6A8C6:
		lea	word_6AD42(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#Obj_FlickerMove,(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		lsr.w	#1,d0
		addi.b	#$1B,d0
		move.b	d0,mapping_frame(a0)
		moveq	#$20,d0
		jmp	(Set_IndexedVelocity).l
; ---------------------------------------------------------------------------

loc_6A8EE:
		lea	word_6AD48(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#MoveChkDel,(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		lsr.w	#1,d0
		addi.b	#$1F,d0
		move.b	d0,mapping_frame(a0)
		moveq	#$1C,d0
		jmp	(Set_IndexedVelocity).l

; =============== S U B R O U T I N E =======================================


sub_6A916:
		move.w	x_pos(a0),d0
		move.w	x_vel(a0),d1
		move.w	#$100,d2
		cmp.w	$3A(a0),d0
		scs	d3
		bcs.s	loc_6A92C
		neg.w	d2

loc_6A92C:
		add.w	d2,d1
		cmp.b	$3C(a0),d3
		beq.s	loc_6A93A
		move.b	d3,$3C(a0)
		add.w	d2,d1

loc_6A93A:
		move.w	d1,x_vel(a0)
		rts
; End of function sub_6A916


; =============== S U B R O U T I N E =======================================


sub_6A940:
		add.w	d0,d0
		smi	d2
		bpl.s	loc_6A948
		neg.w	d0

loc_6A948:
		move.w	#$100,d3
		sub.w	d0,d3
		bpl.s	loc_6A952
		moveq	#0,d3

loc_6A952:
		lsl.w	#4,d3
		tst.b	d2
		beq.s	loc_6A95A
		neg.w	d3

loc_6A95A:
		move.w	d3,x_vel(a0)
		rts
; End of function sub_6A940


; =============== S U B R O U T I N E =======================================


sub_6A960:
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		beq.w	locret_69F78
		move.l	#loc_6A636,(a0)
		clr.b	collision_flags(a0)
		bclr	#3,$38(a0)
		beq.w	locret_69F78
		bra.w	loc_6A986

loc_6A986:
		move.w	$42(a0),d0
		beq.s	loc_6A990
		bsr.w	sub_6A996

loc_6A990:
		move.w	$44(a0),d0
		beq.s	locret_6A9A8
; End of function sub_6A960


; =============== S U B R O U T I N E =======================================


sub_6A996:
		movea.w	d0,a2
		bset	#Status_InAir,status(a2)
		clr.b	object_control(a2)
		move.w	#$100,priority(a2)

locret_6A9A8:
		rts
; End of function sub_6A996


; =============== S U B R O U T I N E =======================================


sub_6A9AA:
		movea.l	a0,a1
		movea.l	a0,a2
		movea.l	a3,a0
		bsr.w	sub_6AA30
		movea.l	a1,a0
		rts
; End of function sub_6A9AA


; =============== S U B R O U T I N E =======================================


sub_6A9B8:
		clr.l	$42(a0)
		move.w	y_pos(a0),d0
		subi.w	#$20,d0
		lea	(Player_1).w,a2
		cmp.w	y_pos(a2),d0
		bhi.s	loc_6A9E0
		move.w	a2,$42(a0)
		bsr.w	sub_6AA30
		tst.b	object_control(a2)
		bne.s	loc_6A9E0
		bsr.w	sub_6AA00

loc_6A9E0:
		lea	(Player_2).w,a2
		cmp.w	y_pos(a2),d0
		bhi.s	locret_6AA22
		cmpi.b	#6,routine(a2)
		bhs.s	locret_6AA22
		move.w	a2,$44(a0)
		bsr.w	sub_6AA30
		tst.b	object_control(a2)
		bne.s	locret_6AA22
; End of function sub_6A9B8


; =============== S U B R O U T I N E =======================================


sub_6AA00:
		bset	#Status_InAir,status(a2)
		move.b	#1,object_control(a2)
		move.b	#$F,anim(a2)
		clr.b	spin_dash_flag(a2)
		clr.w	x_vel(a2)
		clr.w	y_vel(a2)
		clr.w	ground_vel(a2)

locret_6AA22:
		rts
; End of function sub_6AA00

; ---------------------------------------------------------------------------
		dc.w Player_1
		dc.w 0
		dc.w Player_2
		dc.w 0
		dc.w Player_2
		dc.w Player_2

; =============== S U B R O U T I N E =======================================


sub_6AA30:
		move.w	x_pos(a2),d0
		move.w	x_vel(a2),d1
		move.w	#$40,d2
		sub.w	x_pos(a0),d0
		scs	d3
		bcc.s	loc_6AA46
		neg.w	d0

loc_6AA46:
		cmpi.w	#3,d0
		bhi.s	loc_6AA54
		tst.w	d1
		bpl.s	loc_6AA62
		bra.w	loc_6AA60
; ---------------------------------------------------------------------------

loc_6AA54:
		cmpi.w	#$70,d0
		bls.s	loc_6AA5C
		moveq	#0,d1

loc_6AA5C:
		tst.b	d3
		bne.s	loc_6AA62

loc_6AA60:
		neg.w	d2

loc_6AA62:
		add.w	d2,d1
		move.w	#$100,priority(a2)
		move.w	d1,x_vel(a2)
		bpl.s	loc_6AA76
		move.w	#$300,priority(a2)

loc_6AA76:
		ext.l	d1
		lsl.l	#8,d1
		add.l	d1,x_pos(a2)
		move.l	#$8000,d4
		move.w	y_pos(a2),d5
		sub.w	y_pos(a0),d5
		cmpi.w	#-$10,d5
		blt.s	loc_6AA9A
		cmpi.w	#$10,d5
		ble.s	locret_6AA9E
		neg.l	d4

loc_6AA9A:
		add.l	d4,y_pos(a2)

locret_6AA9E:
		rts
; End of function sub_6AA30


; =============== S U B R O U T I N E =======================================


sub_6AAA0:
		btst	#7,$38(a0)
		bne.w	locret_69F78
		move.w	y_pos(a0),d0
		cmp.w	(Water_level).w,d0
		blo.w	locret_69F78
; End of function sub_6AAA0


; =============== S U B R O U T I N E =======================================


sub_6AAB6:
		bset	#7,$38(a0)
		moveq	#signextendB(sfx_Splash),d0
		jsr	(Play_SFX).l
		clr.w	(Slotted_object_bits).w
		lea	ChildObjDat_6AD7E(pc),a2
		jmp	(CreateChild1_Normal).l
; End of function sub_6AAB6


; =============== S U B R O U T I N E =======================================


sub_6AAD2:
		move.b	$3A(a0),d0
		addq.b	#2,$3A(a0)
		andi.w	#$E,d0
		lea	byte_6AB0A(pc,d0.w),a1
		move.b	(a1)+,d0
		bne.s	loc_6AAEA
		move.w	#$100,d0

loc_6AAEA:
		move.w	#$400,d2
		cmpi.w	#$A0,d0
		blo.s	loc_6AAF6
		neg.w	d2

loc_6AAF6:
		move.w	d2,$40(a0)
		move.w	(Camera_X_pos).w,d1
		add.w	d0,d1
		move.w	d1,x_pos(a0)
		move.b	(a1)+,$39(a0)
		rts
; End of function sub_6AAD2

; ---------------------------------------------------------------------------
byte_6AB0A:
		dc.b  $40,   1
		dc.b    0,   1
		dc.b  $40,   0
		dc.b  $40,   1
		dc.b    0,   0
		dc.b    0,   1
		dc.b  $40,   0
		dc.b    0,   0
		even

; =============== S U B R O U T I N E =======================================


sub_6AB1A:
		move.b	$40(a0),d2
		add.b	d2,$3C(a0)
		bsr.w	sub_6AB60
		add.b	d2,$3D(a0)
		bsr.w	sub_6AB94
		moveq	#0,d0
		move.b	$3D(a0),d0
		lsr.w	#4,d0
		move.b	byte_6AB50(pc,d0.w),mapping_frame(a0)
		move.w	#$200,priority(a0)
		cmpi.b	#8,d0
		blo.s	locret_6AB4E
		move.w	#$280,priority(a0)

locret_6AB4E:
		rts
; End of function sub_6AB1A

; ---------------------------------------------------------------------------
byte_6AB50:
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
		dc.b  $1A
		dc.b  $1A
		dc.b  $1A
		dc.b   $C
		dc.b   $D
		even

; =============== S U B R O U T I N E =======================================


sub_6AB60:
		moveq	#0,d0
		move.b	$3C(a0),d0
		bsr.w	sub_6AB76
		move.w	x_pos(a2),d0
		add.w	d1,d0
		move.w	d0,x_pos(a0)
		rts
; End of function sub_6AB60


; =============== S U B R O U T I N E =======================================


sub_6AB76:
		cmpi.b	#$80,d0
		blo.s	loc_6AB82
		moveq	#-1,d1
		sub.b	d0,d1
		move.b	d1,d0

loc_6AB82:
		lea	(HCZMiniboss_RocketTwistLookup).l,a1
		move.b	(a1,d0.w),d1
		ext.w	d1
		movea.w	parent3(a0),a2
		rts
; End of function sub_6AB76


; =============== S U B R O U T I N E =======================================


sub_6AB94:
		moveq	#0,d0
		move.b	$3D(a0),d0
		bsr.s	sub_6AB76
		move.w	y_pos(a2),d0
		add.w	d1,d0
		move.w	d0,y_pos(a0)
		rts
; End of function sub_6AB94


; =============== S U B R O U T I N E =======================================


sub_6ABA8:
		movea.w	parent3(a0),a2
		moveq	#0,d0
		move.b	$3D(a2),d0
		lsr.w	#3,d0
		andi.w	#$FFFE,d0
		move.w	word_6ABF8(pc,d0.w),priority(a0)
		lea	byte_6AC18(pc,d0.w),a1
		move.b	(a1)+,d1
		ext.w	d1
		btst	#0,render_flags(a2)
		beq.s	loc_6ABD6
		neg.w	d1
		bset	#0,render_flags(a0)

loc_6ABD6:
		move.b	(a1)+,d2
		ext.w	d2
		move.w	x_pos(a2),d3
		add.w	d1,d3
		move.w	d3,x_pos(a0)
		move.w	y_pos(a2),d3
		add.w	d2,d3
		move.w	d3,y_pos(a0)
		lsr.w	#1,d0
		move.b	byte_6AC38(pc,d0.w),mapping_frame(a0)
		rts
; End of function sub_6ABA8

; ---------------------------------------------------------------------------
word_6ABF8:
		dc.w   $280
		dc.w   $200
		dc.w   $200
		dc.w   $200
		dc.w   $200
		dc.w   $180
		dc.w   $180
		dc.w   $180
		dc.w   $180
		dc.w   $180
		dc.w   $180
		dc.w   $280
		dc.w   $280
		dc.w   $280
		dc.w   $280
		dc.w   $280
byte_6AC18:
		dc.b    3,   3
		dc.b    0,   0
		dc.b    6,   6
		dc.b   $C,  $C
		dc.b  $12, $12
		dc.b   $C,  $C
		dc.b    8,   8
		dc.b    0,   0
		dc.b    3,   3
		dc.b    0,   0
		dc.b    0,   0
		dc.b    0,   0
		dc.b   -6,  -6
		dc.b  -$A, -$A
		dc.b    0,   0
		dc.b    0,   0
byte_6AC38:
		dc.b   $E,  $F
		dc.b  $10, $11
		dc.b  $12, $11
		dc.b  $10,  $F
		dc.b   $E, $1A
		dc.b  $1A, $1A
		dc.b   $E,  $E
		dc.b  $1A, $1A
		even

; =============== S U B R O U T I N E =======================================


sub_6AC48:
		tst.b	collision_flags(a0)
		bne.s	locret_6ACA4
		tst.b	collision_property(a0)
		beq.s	loc_6ACA6
		tst.b	$20(a0)
		bne.s	loc_6AC68
		move.b	#$20,$20(a0)
		moveq	#signextendB(sfx_BossHit),d0
		jsr	(Play_SFX).l

loc_6AC68:
		bset	#6,status(a0)
		moveq	#0,d0
		btst	#0,$20(a0)
		bne.s	loc_6AC7C
		addi.w	#2*7,d0

loc_6AC7C:
		lea	word_6ACC6(pc),a1
		lea	word_6ACD4(pc,d0.w),a2
		jsr	(CopyWordData_7).l
		subq.b	#1,$20(a0)
		bne.s	locret_6ACA4
		bclr	#6,status(a0)
		cmpi.b	#0,mapping_frame(a0)
		bne.s	locret_6ACA4
		move.b	$25(a0),collision_flags(a0)

locret_6ACA4:
		rts
; ---------------------------------------------------------------------------

loc_6ACA6:
		move.l	#Wait_FadeToLevelMusic,(a0)
		move.l	#loc_6A22A,$34(a0)
		lea	(Child6_CreateBossExplosion).l,a2
		jsr	(CreateChild1_Normal).l
		jmp	(BossDefeated_StopTimer).l
; End of function sub_6AC48

; ---------------------------------------------------------------------------
word_6ACC6:
		dc.w Normal_palette_line_2+$08, Normal_palette_line_2+$0E, Normal_palette_line_2+$12, Normal_palette_line_2+$14
		dc.w Normal_palette_line_2+$16, Normal_palette_line_2+$1A, Normal_palette_line_2+$1C
word_6ACD4:
		dc.w      4,     0,    $C,     8,   $20,  $826,  $624
		dc.w   $AAA,  $AAA,  $888,  $AAA,  $EEE,  $888,  $AAA
ObjDat_HCZMiniboss_Loop:
		dc.l Map_HCZMiniboss
		dc.w make_art_tile($304,1,1)
		dc.w   $280
		dc.b  $20, $20,   0,  $F
ObjDat_HCZMiniboss_Rockets:
		dc.l Map_HCZMiniboss
		dc.w make_art_tile($304,1,1)
		dc.w   $200
		dc.b  $10, $10,   1, $8B
word_6AD08:
		dc.w make_art_tile($304,0,1)
		dc.w   $280
		dc.b  $10, $10, $15,   0
ObjDat2_HCZMiniboss_Engine:
		dc.w make_art_tile($304,0,1)
		dc.w   $280
		dc.b  $10, $10, $15, $92
ObjDat3_6AD18:
		dc.l Map_HCZMiniboss
		dc.w make_art_tile($304,1,1)
		dc.w   $280
		dc.b  $10, $28, $16,   0
ObjDat3_6AD24:
		dc.l Map_Bubbler
		dc.w make_art_tile($45C,1,1)
		dc.w   $280
		dc.b  $10, $10,   0,   0
ObjSlot_6AD30:
		dc.w 3-1
		dc.w make_art_tile($3FC,0,1)
		dc.w    $10,     0
		dc.l Map_HCZMinibossSplash
		dc.w    $80
		dc.b  $10, $10,   0,   0
word_6AD42:
		dc.w   $280
		dc.b   $C,  $C,   0,   0
word_6AD48:
		dc.w   $280
		dc.b  $14, $24,   0,   0
Child1_HCZMiniboss_RocketsEngine:
		dc.w 5-1
		dc.l Obj_HCZMiniboss_Rockets
		dc.b  $18, $18
		dc.l Obj_HCZMiniboss_Rockets
		dc.b -$18,-$18
		dc.l Obj_HCZMiniboss_Rockets
		dc.b -$18, $18
		dc.l Obj_HCZMiniboss_Rockets
		dc.b  $18,-$18
		dc.l Obj_HCZMiniboss_Engine
		dc.b    0, $24
ChildObjDat_6AD6E:
		dc.w 1-1
		dc.l loc_6A51E
		dc.b    0,   0
ChildObjDat_6AD76:
		dc.w 1-1
		dc.l loc_6A460
		dc.b    0,   0
ChildObjDat_6AD7E:
		dc.w 3-1
		dc.l loc_6A4C8
		dc.b    0,   0
		dc.l loc_6A4C8
		dc.b -$10,   0
		dc.l loc_6A4C8
		dc.b  $10,   0
ChildObjDat_6AD92:
		dc.w $1E-1
		dc.l loc_6A65C
ChildObjDat_6AD98:
		dc.w 1-1
		dc.l loc_6A710
ChildObjDat_6AD9E:
		dc.w 1-1
		dc.l loc_6A7C4
ChildObjDat_6ADA4:
		dc.w 2-1
		dc.l loc_6A7C4
ChildObjDat_6ADAA:
		dc.w 4-1
		dc.l loc_6A8C6
		dc.b  -$C, -$C
		dc.l loc_6A8C6
		dc.b  -$C,  $C
		dc.l loc_6A8C6
		dc.b   $C, -$C
		dc.l loc_6A8C6
		dc.b   $C,  $C
ChildObjDat_6ADC4:
		dc.w 5-1
		dc.l loc_6A8EE
		dc.b    0,-$24
		dc.l loc_6A8EE
		dc.b   -8,   0
		dc.l loc_6A8EE
		dc.b    8,   0
		dc.l loc_6A8EE
		dc.b  -$C, $30
		dc.l loc_6A8EE
		dc.b   $C, $30
DPLCPtr_HCZMinibossSplash:
		dc.l ArtUnc_DashDust
		dc.l DPLC_HCZMinibossSplash
byte_6ADEC:
		dc.b  $16,   7
		dc.b  $17,   7
		dc.b  $18,   7
		dc.b  $16,   6
		dc.b  $17,   6
		dc.b  $18,   6
		dc.b  $16,   5
		dc.b  $17,   5
		dc.b  $18,   5
		dc.b  $16,   4
		dc.b  $17,   4
		dc.b  $18,   4
		dc.b  $16,   3
		dc.b  $17,   3
		dc.b  $18,   3
		dc.b  $16,   2
		dc.b  $17,   2
		dc.b  $18,   2
		dc.b  $F4
byte_6AE11:
		dc.b    1, $16, $17, $18, $FC
byte_6AE16:
		dc.b  $16,   2
		dc.b  $17,   2
		dc.b  $18,   2
		dc.b  $16,   3
		dc.b  $17,   3
		dc.b  $18,   3
		dc.b  $16,   4
		dc.b  $17,   4
		dc.b  $18,   4
		dc.b  $16,   5
		dc.b  $17,   5
		dc.b  $18,   5
		dc.b  $16,   6
		dc.b  $17,   6
		dc.b  $18,   6
		dc.b  $16,   7
		dc.b  $17,   7
		dc.b  $18,   7
		dc.b  $F4
byte_6AE3B:
		dc.b    3,   0,   1,   2,   3,   4,   5,   6,   7,   8, $F4
byte_6AE46:
		dc.b    0,   0, $16, $FC
byte_6AE4A:
		dc.b    0,   1, $16, $FC
byte_6AE4E:
		dc.b    0,   2, $16, $FC
byte_6AE52:
		dc.b    0,   3, $16, $FC
		even
Pal_HCZMiniboss:
		binclude "Levels/HCZ/Palettes/Miniboss.bin"
		even
Pal_HCZMinibossWater:
		binclude "Levels/HCZ/Palettes/Miniboss Water.bin"
		even

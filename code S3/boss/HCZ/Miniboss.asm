Obj_HCZMiniboss:
		lea	word_47D28(pc),a1
		jsr	(Check_CameraInRange).l
		move.l	#loc_47D30,(a0)
		move.b	#1,(Boss_flag).w
		st	(Events_bg+$16).w
		moveq	#$5B,d0
		jsr	(Load_PLC).l
		move.w	#$300,(Camera_min_Y_pos).w
		lea	ChildObjDat_48BB2(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------
word_47D28:
		dc.w   $300,  $400, $3500, $3700
; ---------------------------------------------------------------------------

loc_47D30:
		btst	#0,$38(a0)
		bne.s	+ ;loc_47D54
		move.w	#$638,d0
		cmp.w	(Camera_Y_pos).w,d0
		bhi.s	+ ;loc_47D54
		bset	#0,$38(a0)
		move.w	d0,(Camera_min_Y_pos).w
		move.w	d0,(Camera_max_Y_pos).w
		move.w	d0,(Camera_target_max_Y_pos).w

+ ;loc_47D54:
		btst	#1,$38(a0)
		move.w	#$3680,d0
		move.w	(Camera_X_pos).w,d1
		move.w	d1,(Camera_min_X_pos).w
		cmp.w	d1,d0
		bhi.s	+ ;loc_47D78
		bset	#1,$38(a0)
		move.w	d0,(Camera_min_X_pos).w
		move.w	d0,(Camera_max_X_pos).w

+ ;loc_47D78:
		cmpi.b	#3,$38(a0)
		beq.s	+ ;loc_47D82
		rts
; ---------------------------------------------------------------------------

+ ;loc_47D82:
		move.w	(Camera_max_X_pos).w,(Camera_stored_max_X_pos).w
		move.w	y_pos(a0),$44(a0)
		move.l	#Obj_Wait,(a0)
		move.w	#2*60,$2E(a0)
		move.l	#loc_47DBA,$34(a0)
		moveq	#signextendB(mus_FadeOut),d0
		jsr	(Play_Music).l
		bset	#3,$38(a0)
		lea	Pal_HCZMiniboss(pc),a1
		jmp	(PalLoad_Line1).l
; ---------------------------------------------------------------------------

loc_47DBA:
		move.l	#Obj_HCZ_MinibossLoop,(a0)
		moveq	#signextendB(mus_EndBoss),d0
		jsr	(Play_Music).l

locret_47DC8:
		rts
; ---------------------------------------------------------------------------

Obj_HCZ_MinibossLoop:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	.Index(pc,d0.w),d1
		jsr	.Index(pc,d1.w)
		bsr.w	sub_48A8C
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------
.Index:
		dc.w loc_47DFA-.Index
		dc.w loc_47E34-.Index
		dc.w loc_47E5A-.Index
		dc.w loc_47E34-.Index
		dc.w loc_47E5A-.Index
		dc.w loc_47EC6-.Index
		dc.w loc_47F12-.Index
		dc.w loc_47F48-.Index
		dc.w loc_47F60-.Index
		dc.w loc_47FAA-.Index
		dc.w loc_47E5A-.Index
		dc.w loc_48066-.Index
; ---------------------------------------------------------------------------

loc_47DFA:
		lea	ObjDat_HCZMiniboss_Loop(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.b	#6,collision_property(a0)
		move.b	#$28,y_radius(a0)
		bset	#3,$38(a0)
		move.w	#$100,y_vel(a0)
		move.w	#$DF,$2E(a0)
		move.l	#loc_47E40,$34(a0)
		lea	Child1_HCZMiniboss_RocketsEngine(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_47E34:
		jsr	(MoveSprite2).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_47E40:
		move.b	#4,routine(a0)
		clr.w	y_vel(a0)
		move.w	#60-1,$2E(a0)
		move.l	#loc_47E60,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_47E5A:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_47E60:
		move.b	#6,routine(a0)
		move.w	#-$400,y_vel(a0)
		move.w	#$37,$2E(a0)
		move.l	#loc_47E7C,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_47E7C:
		move.b	#8,routine(a0)
		move.w	#60-1,$2E(a0)
		move.l	#loc_47E92,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_47E92:
		bsr.w	sub_48916

loc_47E96:
		move.b	#$A,routine(a0)
		moveq	#signextendB(sfx_Roll),d0
		jsr	(Play_SFX).l
		bset	#6,$38(a0)
		bclr	#7,$38(a0)
		move.w	#$400,y_vel(a0)
		move.w	#$47,$2E(a0)
		move.l	#loc_47EE8,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_47EC6:
		btst	#7,$38(a0)
		bne.s	+ ;loc_47EDC
		move.w	y_pos(a0),d0
		cmp.w	(Water_level).w,d0
		blo.s	+ ;loc_47EDC
		bsr.w	sub_488FA

+ ;loc_47EDC:
		jsr	(MoveSprite2).l
		jmp	(ObjHitFloor_DoRoutine).l
; ---------------------------------------------------------------------------

loc_47EE8:
		move.b	#$C,routine(a0)
		move.w	$40(a0),x_vel(a0)
		neg.w	$40(a0)
		clr.w	y_vel(a0)
		move.w	#$2F,$2E(a0)
		move.l	#loc_47F28,$34(a0)
		bclr	#7,$38(a0)
		rts
; ---------------------------------------------------------------------------

loc_47F12:
		jsr	(MoveSprite2).l
		jsr	(ObjCheckFloorDist).l
		add.w	d1,y_pos(a0)
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_47F28:
		move.w	#-$400,y_vel(a0)
		clr.w	x_vel(a0)
		subq.b	#1,$39(a0)
		bmi.s	+ ;loc_47F40
		move.b	#$E,routine(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_47F40:
		move.b	#$10,routine(a0)
		rts
; ---------------------------------------------------------------------------

loc_47F48:
		bsr.w	sub_488E4
		jsr	(MoveSprite2).l
		move.w	y_pos(a0),d0
		cmp.w	$44(a0),d0
		bls.w	loc_47E96
		rts
; ---------------------------------------------------------------------------

loc_47F60:
		bsr.w	sub_488E4
		jsr	(MoveSprite2).l
		move.w	$44(a0),d0
		addi.w	#$108,d0
		cmp.w	y_pos(a0),d0
		bhs.s	+ ;loc_47F7A
		rts
; ---------------------------------------------------------------------------

+ ;loc_47F7A:
		move.b	#$12,routine(a0)
		bclr	#7,$38(a0)
		move.w	d0,y_pos(a0)
		move.w	#$180,d0
		tst.w	$40(a0)
		bpl.s	+ ;loc_47F96
		neg.w	d0

+ ;loc_47F96:
		move.w	d0,x_vel(a0)
		move.w	#$3F,$2E(a0)
		move.l	#loc_47FBC,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_47FAA:
		addi.w	#$20,y_vel(a0)
		jsr	(MoveSprite2).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_47FBC:
		move.b	#$14,routine(a0)
		moveq	#signextendB(sfx_DoorClose),d0
		jsr	(Play_SFX).l
		bclr	#3,$38(a0)
		move.w	#$9F,$2E(a0)
		move.l	#loc_47FE4,$34(a0)
		clr.w	x_vel(a0)
		rts
; ---------------------------------------------------------------------------

loc_47FE4:
		bset	#2,$38(a0)
		move.w	#$17F,$2E(a0)
		move.l	#loc_47FFA,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_47FFA:
		bclr	#2,$38(a0)
		move.w	#$7F,$2E(a0)
		move.l	#loc_48010,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_48010:
		bset	#3,$38(a0)
		move.w	#$3F,$2E(a0)
		move.l	#loc_48010,$34(a0)
		move.l	#loc_4802E,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_4802E:
		move.b	#2,routine(a0)
		move.w	#-$20,y_vel(a0)
		move.w	#$7F,$2E(a0)
		move.l	#loc_4804A,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_4804A:
		move.b	#$16,routine(a0)
		bclr	#6,$38(a0)
		move.w	#-$400,y_vel(a0)
		moveq	#signextendB(sfx_LavaBall),d0
		jsr	(Play_SFX).l
		rts
; ---------------------------------------------------------------------------

loc_48066:
		jsr	(MoveSprite2).l
		move.w	y_pos(a0),d0
		cmp.w	$44(a0),d0
		bls.w	loc_47E92
		rts
; ---------------------------------------------------------------------------

loc_4807A:
		st	(_unkFAA2).w
		jsr	(Obj_EndSignControl).l
		jsr	(AllocateObject).l
		bne.s	+ ;loc_48092
		move.l	#loc_4809C,(a1)

+ ;loc_48092:
		lea	ChildObjDat_48BEE(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_4809C:
		tst.b	(_unkFAA8).w
		bne.w	locret_47DC8
		move.l	#loc_480C0,(a0)
		clr.w	(Ctrl_1_logical).w
		clr.w	(Ctrl_2_logical).w
		st	(Ctrl_1_locked).w
		st	(Ctrl_2_locked).w
		move.b	#$80,(Player_1+object_control).w

loc_480C0:
		tst.b	(End_of_level_flag).w
		beq.w	locret_47DC8
		move.l	#loc_480F0,(a0)
		lea	ChildObjDat_48BE8(pc),a2
		tst.b	(Player_mode+1).w
		beq.s	+ ;loc_480DC
		lea	ChildObjDat_48BE2(pc),a2

+ ;loc_480DC:
		jsr	(CreateChild6_Simple).l
		move.w	#$2F,$2E(a0)
		move.l	#Go_Delete_Sprite,$34(a0)

loc_480F0:
		btst	#0,$38(a0)
		beq.w	locret_47DC8
		lea	ChildObjDat_48BDC(pc),a2
		jsr	(CreateChild6_Simple).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

Obj_HCZMiniboss_Rockets:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	.Index(pc,d0.w),d1
		jsr	.Index(pc,d1.w)
		moveq	#$20,d0
		jmp	(Child_DrawTouch_Sprite_FlickerMove).l
; ---------------------------------------------------------------------------
.Index:
		dc.w loc_4812E-.Index
		dc.w loc_48148-.Index
		dc.w loc_4819C-.Index
		dc.w loc_481BC-.Index
		dc.w loc_481CA-.Index
		dc.w loc_48254-.Index
		dc.w loc_4826E-.Index
; ---------------------------------------------------------------------------

loc_4812E:
		lea	ObjDat_HCZMiniboss_Rockets(pc),a1
		jsr	(SetUp_ObjAttributes).l
		bset	#6,$38(a0)
		lea	ChildObjDat_48BBA(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_48148:
		clr.b	collision_flags(a0)
		movea.w	parent3(a0),a1
		btst	#3,$38(a1)
		beq.w	locret_47DC8
		move.b	#4,routine(a0)
		move.b	#1,$40(a0)
		move.w	#$3F,$2E(a0)
		move.l	#loc_481A6,$34(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		move.w	word_48194(pc,d0.w),$3C(a0)
		cmpi.b	#4,d0
		blo.s	locret_48192
		bset	#0,render_flags(a0)
		move.b	#6,routine(a0)

locret_48192:
		rts
; ---------------------------------------------------------------------------
word_48194:
		dc.w      0, $8080, $8000,   $80
; ---------------------------------------------------------------------------

loc_4819C:
		bsr.w	sub_4895E
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_481A6:
		move.b	#8,routine(a0)
		move.w	#$3F,$2E(a0)
		move.l	#loc_481D4,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_481BC:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_481C2:
		move.b	#2,routine(a0)
		rts
; ---------------------------------------------------------------------------

loc_481CA:
		bsr.w	sub_4895E
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_481D4:
		move.b	#2,$40(a0)
		move.b	#$8B,collision_flags(a0)
		move.w	#$1F,$2E(a0)
		move.l	#loc_481F0,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_481F0:
		move.b	#$A,routine(a0)
		move.b	#4,$40(a0)
		move.l	#loc_48266,$34(a0)
		bclr	#6,$38(a0)
		moveq	#signextendB(sfx_LevelProjectile),d0
		jsr	(Play_SFX).l
		rts
; ---------------------------------------------------------------------------

loc_48214:
		move.b	#2,$40(a0)
		move.w	#$1F,$2E(a0)
		move.l	#loc_4822A,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_4822A:
		move.b	#6,routine(a0)
		cmpi.b	#4,subtype(a0)
		blo.s	+ ;loc_4823E
		move.b	#4,routine(a0)

+ ;loc_4823E:
		move.b	#1,$40(a0)
		move.w	#$3F,$2E(a0)
		move.l	#loc_481C2,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_48254:
		bsr.w	sub_4895E
		movea.w	parent3(a0),a1
		btst	#3,$38(a1)
		bne.w	locret_47DC8

loc_48266:
		move.b	#$C,routine(a0)
		rts
; ---------------------------------------------------------------------------

loc_4826E:
		bsr.w	sub_4895E
		moveq	#0,d0
		move.b	subtype(a0),d0
		lsr.b	#1,d0
		move.b	byte_482AC(pc,d0.w),d1
		cmp.b	$3C(a0),d1
		beq.s	+ ;loc_48286
		rts
; ---------------------------------------------------------------------------

+ ;loc_48286:
		move.b	#8,routine(a0)
		clr.b	collision_flags(a0)
		move.b	#2,$40(a0)
		move.w	#$1F,$2E(a0)
		move.l	#loc_48214,$34(a0)
		bset	#6,$38(a0)
		rts
; ---------------------------------------------------------------------------
byte_482AC:
		dc.b  $80,   0, $C0, $40
; ---------------------------------------------------------------------------

loc_482B0:
		lea	word_48B4C(pc),a1
		jsr	(SetUp_ObjAttributes2).l
		move.l	#loc_482C2,(a0)
		rts
; ---------------------------------------------------------------------------

loc_482C2:
		bsr.w	sub_489EC

loc_482C6:
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.s	+ ;loc_482EC
		btst	#6,$38(a1)
		bne.w	locret_47DC8
		btst	#0,(V_int_run_count+3).w
		bne.w	locret_47DC8
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------

+ ;loc_482EC:
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

Obj_HCZMiniboss_Engine:
		lea	ObjDat2_HCZMiniboss_Engine(pc),a1
		jsr	(SetUp_ObjAttributes2).l
		move.l	#loc_48304,(a0)
		rts
; ---------------------------------------------------------------------------

loc_48304:
		jsr	(Refresh_ChildPosition).l
		bra.s	loc_482C6
; ---------------------------------------------------------------------------

loc_4830C:
		lea	ObjSlot_48B74(pc),a1
		jsr	(SetUp_ObjAttributesSlotted).l
		move.w	(Water_level).w,y_pos(a0)
		move.l	#Obj_Wait,(a0)
		tst.b	subtype(a0)
		beq.s	+ ;loc_4832E
		move.w	#7,$2E(a0)

+ ;loc_4832E:
		move.l	#loc_48338,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_48338:
		move.l	#loc_48348,(a0)
		move.l	#Go_Delete_SpriteSlotted3,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_48348:
		lea	byte_48C7F(pc),a1
		jsr	(Animate_RawNoSST).l
		lea	DPLCPtr_HCZMinibossSplash(pc),a2
		jsr	(Perform_DPLC).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_48362:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_4837A(pc,d0.w),d1
		jsr	off_4837A(pc,d1.w)
		bsr.w	sub_487A4
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------
off_4837A:
		dc.w loc_48386-off_4837A
		dc.w loc_483A0-off_4837A
		dc.w loc_483C0-off_4837A
		dc.w loc_483F6-off_4837A
		dc.w loc_4841C-off_4837A
		dc.w loc_4845C-off_4837A
; ---------------------------------------------------------------------------

loc_48386:
		lea	ObjDat3_48B5C(pc),a1
		jsr	(SetUp_ObjAttributes).l
		addi.w	#$148,y_pos(a0)
		clr.w	$42(a0)
		clr.w	$44(a0)
		rts
; ---------------------------------------------------------------------------

loc_483A0:
		tst.b	render_flags(a0)
		bpl.w	locret_47DC8
		move.b	#4,routine(a0)
		lea	Pal_HCZMinibossWater(pc),a1
		lea	(Water_palette_line_2).w,a2
		moveq	#bytesToLcnt($20),d0

- ;loc_483B8:
		move.l	(a1)+,(a2)+
		dbf	d0,- ;loc_483B8
		rts
; ---------------------------------------------------------------------------

loc_483C0:
		movea.w	parent3(a0),a1
		btst	#2,$38(a1)
		beq.w	locret_47DC8
		move.b	#6,routine(a0)
		move.l	#byte_48C30,$30(a0)
		move.l	#loc_48400,$34(a0)
		moveq	#signextendB(sfx_FanBig),d0
		jsr	(Play_SFX).l
		lea	ChildObjDat_48BD6(pc),a2
		jmp	(CreateChild6_Simple).l
; ---------------------------------------------------------------------------

loc_483F6:
		lea	byte_48C30(pc),a1
		jmp	(Animate_RawNoSSTMultiDelay).l
; ---------------------------------------------------------------------------

loc_48400:
		move.b	#8,routine(a0)
		move.l	#byte_48C30,$30(a0)
		move.l	#loc_48466,$34(a0)
		clr.b	collision_property(a0)
		rts
; ---------------------------------------------------------------------------

loc_4841C:
		bsr.w	sub_487FC
		movea.w	parent3(a0),a1
		btst	#2,$38(a1)
		beq.s	+ ;loc_4843E
		moveq	#signextendB(sfx_BossRotate),d0
		jsr	(Play_SFX_Continuous).l
		lea	byte_48C55(pc),a1
		jmp	(Animate_RawNoSST).l
; ---------------------------------------------------------------------------

+ ;loc_4843E:
		move.b	#$A,routine(a0)
		bset	#3,$38(a0)
		move.l	#loc_48466,$34(a0)
		bsr.w	loc_487CA
		jmp	(Animate_RawMultiDelay).l
; ---------------------------------------------------------------------------

loc_4845C:
		lea	byte_48C5A(pc),a1
		jmp	(Animate_RawNoSSTMultiDelay).l
; ---------------------------------------------------------------------------

loc_48466:
		move.b	#4,routine(a0)
		move.b	#$16,mapping_frame(a0)
		bclr	#3,$38(a0)
		rts
; ---------------------------------------------------------------------------

loc_4847A:
		movea.w	parent3(a0),a1
		btst	#4,$38(a1)
		beq.s	+ ;loc_4849A
		lea	ChildObjDat_48C08(pc),a2
		jsr	(CreateChild1_Normal).l
		bsr.w	loc_487CA
		jsr	(Go_Delete_Sprite_2).l

+ ;loc_4849A:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_484A0:
		lea	ObjDat3_48B68(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_484FC,(a0)
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
		move.l	off_484EC(pc,d0.w),$30(a0)
		move.w	#$1F,$2E(a0)
		move.l	#loc_48516,$34(a0)
		rts
; ---------------------------------------------------------------------------
off_484EC:
		dc.l byte_48C8A
		dc.l byte_48C8E
		dc.l byte_48C92
		dc.l byte_48C96
; ---------------------------------------------------------------------------

loc_484FC:
		movea.w	parent3(a0),a3
		bsr.w	sub_487EE
		jsr	(Animate_Raw).l
		jsr	(Obj_Wait).l
		jmp	(Child_Draw_Sprite2).l
; ---------------------------------------------------------------------------

loc_48516:
		move.l	#loc_48528,(a0)
		movea.l	$30(a0),a1
		move.b	1(a1),mapping_frame(a0)
		rts
; ---------------------------------------------------------------------------

loc_48528:
		movea.w	parent3(a0),a3
		btst	#3,$38(a3)
		bne.s	+ ;loc_4853E
		bsr.w	sub_487EE
		jmp	(Child_Draw_Sprite2).l
; ---------------------------------------------------------------------------

+ ;loc_4853E:
		move.l	#loc_484FC,(a0)
		move.w	#$1F,$2E(a0)
		move.l	#Go_Delete_Sprite,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_48554:
		lea	ObjDat3_48B68(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_485E0,(a0)
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
		bpl.s	+ ;loc_48592
		st	$3C(a0)

+ ;loc_48592:
		add.w	d0,x_pos(a0)
		bsr.w	sub_48784
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
		lea	off_484EC(pc),a1
		move.l	(a1,d0.w),$30(a0)
		move.w	#$200,y_vel(a0)
		move.w	#$BF,$2E(a0)
		move.l	#Go_Delete_Sprite,$34(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_485E0:
		tst.b	render_flags(a0)
		bpl.s	+ ;loc_48602
		bsr.w	sub_4875A
		jsr	(MoveSprite2).l
		jsr	(Animate_Raw).l
		jsr	(Obj_Wait).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

+ ;loc_48602:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_48608:
		lea	(Player_1).w,a1
		btst	#Status_Underwater,status(a1)
		beq.w	locret_47DC8
		move.l	#loc_486B6,(a0)
		clr.b	(_unkFAA2).w
		movea.w	parent3(a0),a1
		bset	#0,$38(a1)
		move.b	#4,render_flags(a0)
		lea	(Player_1).w,a1
		lea	(Ctrl_1_locked).w,a2
		tst.b	subtype(a0)
		beq.s	+ ;loc_48650
		lea	(Player_2).w,a1
		lea	(Ctrl_2_locked).w,a2
		btst	#Status_Underwater,status(a1)
		beq.w	+++ ;loc_486B0

+ ;loc_48650:
		clr.b	(a2)
		tst.l	(a1)
		beq.s	++ ;loc_486B0
		move.w	a1,$44(a0)
		bclr	#7,art_tile(a0)
		move.w	x_pos(a1),d0
		move.w	d0,x_pos(a0)
		move.w	y_pos(a1),y_pos(a0)
		move.w	(Camera_X_pos).w,d1
		addi.w	#$A0,d1
		move.w	d1,$3A(a0)
		sub.w	d1,d0
		bpl.s	+ ;loc_48682
		st	$3C(a0)

+ ;loc_48682:
		bsr.w	sub_48784
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

+ ;loc_486B0:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_486B6:
		bsr.w	sub_4875A
		jsr	(MoveSprite2).l
		movea.w	$44(a0),a1
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),d0
		move.w	d0,y_pos(a1)
		cmpi.w	#$828,d0
		bhs.s	+ ;loc_486DA
		rts
; ---------------------------------------------------------------------------

+ ;loc_486DA:
		tst.b	subtype(a0)
		beq.s	+ ;loc_486F2
		lea	(Player_2).w,a1
		tst.l	(a1)
		beq.s	++ ;loc_48704
		jsr	(Restore_PlayerControl2).l
		bra.w	++ ;loc_48704
; ---------------------------------------------------------------------------

+ ;loc_486F2:
		jsr	(Restore_PlayerControl).l
		move.w	#0,(Camera_stored_min_Y_pos).w
		jsr	(Make_LevelSizeObj).l

+ ;loc_48704:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_4870A:
		lea	word_48B86(pc),a1
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

loc_48732:
		lea	word_48B8C(pc),a1
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


sub_4875A:
		move.w	x_pos(a0),d0
		move.w	x_vel(a0),d1
		move.w	#$100,d2
		cmp.w	$3A(a0),d0
		scs	d3
		bcs.s	+ ;loc_48770
		neg.w	d2

+ ;loc_48770:
		add.w	d2,d1
		cmp.b	$3C(a0),d3
		beq.s	+ ;loc_4877E
		move.b	d3,$3C(a0)
		add.w	d2,d1

+ ;loc_4877E:
		move.w	d1,x_vel(a0)
		rts
; End of function sub_4875A


; =============== S U B R O U T I N E =======================================


sub_48784:
		add.w	d0,d0
		smi	d2
		bpl.s	+ ;loc_4878C
		neg.w	d0

+ ;loc_4878C:
		move.w	#$100,d3
		sub.w	d0,d3
		bpl.s	+ ;loc_48796
		moveq	#0,d3

+ ;loc_48796:
		lsl.w	#4,d3
		tst.b	d2
		beq.s	+ ;loc_4879E
		neg.w	d3

+ ;loc_4879E:
		move.w	d3,x_vel(a0)
		rts
; End of function sub_48784


; =============== S U B R O U T I N E =======================================


sub_487A4:
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		beq.w	locret_47DC8
		move.l	#loc_4847A,(a0)
		clr.b	collision_flags(a0)
		bclr	#3,$38(a0)
		beq.w	locret_47DC8
		bra.w	loc_487CA

loc_487CA:
		move.w	$42(a0),d0
		beq.s	+ ;loc_487D4
		bsr.w	sub_487DA

+ ;loc_487D4:
		move.w	$44(a0),d0
		beq.s	locret_487EC
; End of function sub_487A4


; =============== S U B R O U T I N E =======================================


sub_487DA:
		movea.w	d0,a2
		bset	#Status_InAir,status(a2)
		clr.b	object_control(a2)
		move.w	#$100,priority(a2)

locret_487EC:
		rts
; End of function sub_487DA


; =============== S U B R O U T I N E =======================================


sub_487EE:
		movea.l	a0,a1
		movea.l	a0,a2
		movea.l	a3,a0
		bsr.w	sub_48874
		movea.l	a1,a0
		rts
; End of function sub_487EE


; =============== S U B R O U T I N E =======================================


sub_487FC:
		clr.l	$42(a0)
		move.w	y_pos(a0),d0
		subi.w	#$20,d0
		lea	(Player_1).w,a2
		cmp.w	y_pos(a2),d0
		bhi.s	+ ;loc_48824
		move.w	a2,$42(a0)
		bsr.w	sub_48874
		tst.b	object_control(a2)
		bne.s	+ ;loc_48824
		bsr.w	sub_48844

+ ;loc_48824:
		lea	(Player_2).w,a2
		cmp.w	y_pos(a2),d0
		bhi.s	locret_48866
		cmpi.b	#6,routine(a2)
		bhs.s	locret_48866
		move.w	a2,$44(a0)
		bsr.w	sub_48874
		tst.b	object_control(a2)
		bne.s	locret_48866
; End of function sub_487FC


; =============== S U B R O U T I N E =======================================


sub_48844:
		bset	#Status_InAir,status(a2)
		move.b	#1,object_control(a2)
		move.b	#$F,anim(a2)
		clr.b	spin_dash_flag(a2)
		clr.w	x_vel(a2)
		clr.w	y_vel(a2)
		clr.w	ground_vel(a2)

locret_48866:
		rts
; End of function sub_48844

; ---------------------------------------------------------------------------
		dc.w Player_1
		dc.w 0
		dc.w Player_2
		dc.w 0
		dc.w Player_1
		dc.w Player_2

; =============== S U B R O U T I N E =======================================


sub_48874:
		move.w	x_pos(a2),d0
		move.w	x_vel(a2),d1
		move.w	#$40,d2
		sub.w	x_pos(a0),d0
		scs	d3
		bcc.s	+ ;loc_4888A
		neg.w	d0

+ ;loc_4888A:
		cmpi.w	#3,d0
		bhi.s	+ ;loc_48898
		tst.w	d1
		bpl.s	loc_488A6
		bra.w	+++ ;loc_488A4
; ---------------------------------------------------------------------------

+ ;loc_48898:
		cmpi.w	#$70,d0
		bls.s	+ ;loc_488A0
		moveq	#0,d1

+ ;loc_488A0:
		tst.b	d3
		bne.s	loc_488A6

+ ;loc_488A4:
		neg.w	d2

loc_488A6:
		add.w	d2,d1
		move.w	#$100,priority(a2)
		move.w	d1,x_vel(a2)
		bpl.s	+ ;loc_488BA
		move.w	#$300,priority(a2)

+ ;loc_488BA:
		ext.l	d1
		lsl.l	#8,d1
		add.l	d1,x_pos(a2)
		move.l	#$8000,d4
		move.w	y_pos(a2),d5
		sub.w	y_pos(a0),d5
		cmpi.w	#-$10,d5
		blt.s	+ ;loc_488DE
		cmpi.w	#$10,d5
		ble.s	locret_488E2
		neg.l	d4

+ ;loc_488DE:
		add.l	d4,y_pos(a2)

locret_488E2:
		rts
; End of function sub_48874


; =============== S U B R O U T I N E =======================================


sub_488E4:
		btst	#7,$38(a0)
		bne.w	locret_47DC8
		move.w	y_pos(a0),d0
		cmp.w	(Water_level).w,d0
		blo.w	locret_47DC8
; End of function sub_488E4


; =============== S U B R O U T I N E =======================================


sub_488FA:
		bset	#7,$38(a0)
		moveq	#signextendB(sfx_Splash),d0
		jsr	(Play_SFX).l
		clr.w	(Slotted_object_bits).w
		lea	ChildObjDat_48BC2(pc),a2
		jmp	(CreateChild1_Normal).l
; End of function sub_488FA


; =============== S U B R O U T I N E =======================================


sub_48916:
		move.b	$3A(a0),d0
		addq.b	#2,$3A(a0)
		andi.w	#$E,d0
		lea	byte_4894E(pc,d0.w),a1
		move.b	(a1)+,d0
		bne.s	+ ;loc_4892E
		move.w	#$100,d0

+ ;loc_4892E:
		move.w	#$400,d2
		cmpi.w	#$A0,d0
		blo.s	+ ;loc_4893A
		neg.w	d2

+ ;loc_4893A:
		move.w	d2,$40(a0)
		move.w	(Camera_X_pos).w,d1
		add.w	d0,d1
		move.w	d1,x_pos(a0)
		move.b	(a1)+,$39(a0)
		rts
; End of function sub_48916

; ---------------------------------------------------------------------------
byte_4894E:
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


sub_4895E:
		move.b	$40(a0),d2
		add.b	d2,$3C(a0)
		bsr.w	sub_489A4
		add.b	d2,$3D(a0)
		bsr.w	sub_489D8
		moveq	#0,d0
		move.b	$3D(a0),d0
		lsr.w	#4,d0
		move.b	byte_48994(pc,d0.w),mapping_frame(a0)
		move.w	#$200,priority(a0)
		cmpi.b	#8,d0
		blo.s	locret_48992
		move.w	#$280,priority(a0)

locret_48992:
		rts
; End of function sub_4895E

; ---------------------------------------------------------------------------
byte_48994:
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


sub_489A4:
		moveq	#0,d0
		move.b	$3C(a0),d0
		bsr.w	sub_489BA
		move.w	x_pos(a2),d0
		add.w	d1,d0
		move.w	d0,x_pos(a0)
		rts
; End of function sub_489A4


; =============== S U B R O U T I N E =======================================


sub_489BA:
		cmpi.b	#$80,d0
		blo.s	loc_489C6
		moveq	#-1,d1
		sub.b	d0,d1
		move.b	d1,d0

loc_489C6:
		lea	(HCZMiniboss_RocketTwistLookup).l,a1
		move.b	(a1,d0.w),d1
		ext.w	d1
		movea.w	parent3(a0),a2
		rts
; End of function sub_489BA


; =============== S U B R O U T I N E =======================================


sub_489D8:
		moveq	#0,d0
		move.b	$3D(a0),d0
		bsr.s	sub_489BA
		move.w	y_pos(a2),d0
		add.w	d1,d0
		move.w	d0,y_pos(a0)
		rts
; End of function sub_489D8


; =============== S U B R O U T I N E =======================================


sub_489EC:
		movea.w	parent3(a0),a2
		moveq	#0,d0
		move.b	$3D(a2),d0
		lsr.w	#3,d0
		andi.w	#$FFFE,d0
		move.w	word_48A3C(pc,d0.w),priority(a0)
		lea	byte_48A5C(pc,d0.w),a1
		move.b	(a1)+,d1
		ext.w	d1
		btst	#0,render_flags(a2)
		beq.s	+ ;loc_48A1A
		neg.w	d1
		bset	#0,render_flags(a0)

+ ;loc_48A1A:
		move.b	(a1)+,d2
		ext.w	d2
		move.w	x_pos(a2),d3
		add.w	d1,d3
		move.w	d3,x_pos(a0)
		move.w	y_pos(a2),d3
		add.w	d2,d3
		move.w	d3,y_pos(a0)
		lsr.w	#1,d0
		move.b	byte_48A7C(pc,d0.w),mapping_frame(a0)
		rts
; End of function sub_489EC

; ---------------------------------------------------------------------------
word_48A3C:
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
byte_48A5C:
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
byte_48A7C:
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


sub_48A8C:
		tst.b	collision_flags(a0)
		bne.s	locret_48AE8
		tst.b	collision_property(a0)
		beq.s	+++ ;loc_48AEA
		tst.b	$20(a0)
		bne.s	+ ;loc_48AAC
		move.b	#$20,$20(a0)
		moveq	#signextendB(sfx_BossHit),d0
		jsr	(Play_SFX).l

+ ;loc_48AAC:
		bset	#6,status(a0)
		moveq	#0,d0
		btst	#0,$20(a0)
		bne.s	+ ;loc_48AC0
		addi.w	#2*7,d0

+ ;loc_48AC0:
		lea	word_48B0A(pc),a1
		lea	word_48B18(pc,d0.w),a2
		jsr	(CopyWordData_7).l
		subq.b	#1,$20(a0)
		bne.s	locret_48AE8
		bclr	#6,status(a0)
		cmpi.b	#0,mapping_frame(a0)
		bne.s	locret_48AE8
		move.b	$25(a0),collision_flags(a0)

locret_48AE8:
		rts
; ---------------------------------------------------------------------------

+ ;loc_48AEA:
		move.l	#Wait_Draw,(a0)
		move.l	#loc_4807A,$34(a0)
		lea	(Child6_CreateBossExplosion).l,a2
		jsr	(CreateChild1_Normal).l
		jmp	(BossDefeated_StopTimer).l
; End of function sub_48A8C

; ---------------------------------------------------------------------------
word_48B0A:
		dc.w Normal_palette_line_2+$08, Normal_palette_line_2+$0E, Normal_palette_line_2+$12, Normal_palette_line_2+$14
		dc.w Normal_palette_line_2+$16, Normal_palette_line_2+$1A, Normal_palette_line_2+$1C
word_48B18:
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
word_48B4C:
		dc.w make_art_tile($304,0,1)
		dc.w   $280
		dc.b  $10, $10, $15,   0
ObjDat2_HCZMiniboss_Engine:
		dc.w make_art_tile($304,0,1)
		dc.w   $280
		dc.b  $10, $10, $15, $92
ObjDat3_48B5C:
		dc.l Map_HCZMiniboss
		dc.w make_art_tile($304,1,1)
		dc.w   $280
		dc.b  $10, $28, $16,   0
ObjDat3_48B68:
		dc.l Map_Bubbler
		dc.w make_art_tile($45C,1,1)
		dc.w   $280
		dc.b  $10, $10,   0,   0
ObjSlot_48B74:
		dc.w 3-1
		dc.w make_art_tile($3FC,0,1)
		dc.w    $10,     0
		dc.l Map_HCZMinibossSplash
		dc.w    $80
		dc.b  $10, $10,   0,   0
word_48B86:
		dc.w   $280
		dc.b   $C,  $C,   0,   0
word_48B8C:
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
ChildObjDat_48BB2:
		dc.w 1-1
		dc.l loc_48362
		dc.b    0,   0
ChildObjDat_48BBA:
		dc.w 1-1
		dc.l loc_482B0
		dc.b    0,   0
ChildObjDat_48BC2:
		dc.w 3-1
		dc.l loc_4830C
		dc.b    0,   0
		dc.l loc_4830C
		dc.b -$10,   0
		dc.l loc_4830C
		dc.b  $10,   0
ChildObjDat_48BD6:
		dc.w $1E-1
		dc.l loc_484A0
ChildObjDat_48BDC:
		dc.w 1-1
		dc.l loc_48554
ChildObjDat_48BE2:
		dc.w 1-1
		dc.l loc_48608
ChildObjDat_48BE8:
		dc.w 2-1
		dc.l loc_48608
ChildObjDat_48BEE:
		dc.w 4-1
		dc.l loc_4870A
		dc.b  -$C, -$C
		dc.l loc_4870A
		dc.b  -$C,  $C
		dc.l loc_4870A
		dc.b   $C, -$C
		dc.l loc_4870A
		dc.b   $C,  $C
ChildObjDat_48C08:
		dc.w 5-1
		dc.l loc_48732
		dc.b    0,-$24
		dc.l loc_48732
		dc.b   -8,   0
		dc.l loc_48732
		dc.b    8,   0
		dc.l loc_48732
		dc.b  -$C, $30
		dc.l loc_48732
		dc.b   $C, $30
DPLCPtr_HCZMinibossSplash:
		dc.l ArtUnc_DashDust
		dc.l DPLC_HCZMinibossSplash
byte_48C30:
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
byte_48C55:
		dc.b    1, $16, $17, $18, $FC
byte_48C5A:
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
byte_48C7F:
		dc.b    3,   0,   1,   2,   3,   4,   5,   6,   7,   8, $F4
byte_48C8A:
		dc.b    0,   0, $16, $FC
byte_48C8E:
		dc.b    0,   1, $16, $FC
byte_48C92:
		dc.b    0,   2, $16, $FC
byte_48C96:
		dc.b    0,   3, $16, $FC
		even
Pal_HCZMiniboss:
		binclude "Levels/HCZ/Palettes/Miniboss.bin"
		even
Pal_HCZMinibossWater:
		binclude "Levels/HCZ/Palettes/Miniboss Water.bin"
		even
; ---------------------------------------------------------------------------

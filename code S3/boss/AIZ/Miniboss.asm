Obj_AIZMinibossCutscene:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	.Index(pc,d0.w),d1
		jsr	.Index(pc,d1.w)
		bra.w	loc_46E80
; ---------------------------------------------------------------------------
.Index:
		dc.w loc_4645E-.Index
		dc.w loc_46482-.Index
		dc.w loc_464CA-.Index
		dc.w loc_46508-.Index
		dc.w loc_4654C-.Index
; ---------------------------------------------------------------------------

loc_4645E:
		lea	ObjDat_AIZMiniboss(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.b	#$60,collision_property(a0)
		move.w	(Camera_max_X_pos).w,(Camera_stored_max_X_pos).w
		move.b	#1,(Boss_flag).w
		moveq	#$5A,d0
		jmp	(Load_PLC).l
; ---------------------------------------------------------------------------

loc_46482:
		move.w	(Camera_X_pos).w,d0
		move.w	#$2F10,d5
		cmp.w	d5,d0
		bhs.s	loc_46490
		rts
; ---------------------------------------------------------------------------

loc_46490:
		move.l	#loc_464D0,$34(a0)
		lea	ChildObjDat_46F80(pc),a2
		jsr	(CreateChild3_NormalRepeated).l
		lea	Pal_AIZMiniboss(pc),a1
		jsr	(PalLoad_Line1).l

loc_464AC:
		move.b	#4,routine(a0)
		move.w	#3*60,$2E(a0)
		move.w	d5,(Camera_min_X_pos).w
		move.w	d5,(Camera_max_X_pos).w
		moveq	#signextendB(mus_FadeOut),d0
		jsr	(Play_Music).l

locret_464C8:
		rts
; ---------------------------------------------------------------------------

loc_464CA:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_464D0:
		move.l	#loc_4650E,$34(a0)
		move.b	#6,routine(a0)
		lea	ChildObjDat_46F72(pc),a2
		jsr	(CreateChild1_Normal).l
		lea	ChildObjDat_46F88(pc),a2
		jsr	(CreateChild1_Normal).l

; =============== S U B R O U T I N E =======================================


sub_464F2:
		move.w	#$100,y_vel(a0)
		move.w	#$AF,$2E(a0)
		moveq	#signextendB(mus_Miniboss),d0
		jsr	(Play_Music).l
		rts
; End of function sub_464F2

; ---------------------------------------------------------------------------

loc_46508:
		jmp	(MoveWaitTouch).l
; ---------------------------------------------------------------------------

loc_4650E:
		move.w	#$7F,$2E(a0)
		move.l	#loc_4657E,$34(a0)
		move.b	#3,$39(a0)
		bset	#1,$38(a0)

loc_46528:
		move.b	#8,routine(a0)
		clr.w	y_vel(a0)

; =============== S U B R O U T I N E =======================================


Swing_Setup1:
		move.w	#$C0,d0
		move.w	d0,$3E(a0)
		move.w	d0,y_vel(a0)
		move.w	#$10,$40(a0)
		bclr	#0,$38(a0)
		rts
; End of function Swing_Setup1

; ---------------------------------------------------------------------------

loc_4654C:
		jsr	(Swing_UpAndDown).l
		jmp	(MoveWaitTouch).l
; ---------------------------------------------------------------------------
		subq.b	#1,$39(a0)
		bpl.s	loc_46566
		move.l	#loc_4657E,$34(a0)

loc_46566:
		move.w	#$40,$2E(a0)
		moveq	#signextendB(sfx_FlamethrowerQuiet),d0
		jsr	(Play_SFX).l
		lea	Child1_AIZ_MinibossFlames(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_4657E:
		move.w	#$10,$2E(a0)
		move.l	#loc_46596,$34(a0)
		lea	ChildObjDat_4701A(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_46596:
		move.l	#loc_465E0,(a0)
		lea	Pal_AIZMiniboss(pc),a1
		jsr	(PalLoad_Line1).l
		move.b	#$F,collision_flags(a0)
		moveq	#signextendB(mus_FadeOut),d0
		jsr	(Play_Music).l
		move.w	#$400,x_vel(a0)
		clr.w	y_vel(a0)
		move.w	#$40,$2E(a0)
		cmpi.w	#0,(Current_zone_and_act).w
		bne.s	loc_465D2
		move.w	#$120,$2E(a0)

loc_465D2:
		move.l	#Go_Delete_Sprite,$34(a0)
		st	(Events_fg_5).w
		rts
; ---------------------------------------------------------------------------

loc_465E0:
		jsr	(MoveSprite2).l
		subq.w	#1,$2E(a0)
		bmi.s	loc_465F2
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_465F2:
		clr.b	(Boss_flag).w
		jsr	(Restore_LevelMusic).l
		lea	(PLC_Monitors).l,a1
		jsr	(Load_PLC_Raw).l
		jmp	(Go_Delete_Sprite_2).l
; ---------------------------------------------------------------------------

loc_4660E:
		jsr	(Refresh_ChildPositionAdjusted).l
		lea	word_46F20(pc),a1
		jsr	(SetUp_ObjAttributes2).l
		bset	#4,shield_reaction(a0)
		move.l	#byte_4703C,$30(a0)
		move.l	#loc_46638,(a0)
		jmp	(Child_DrawTouch_Sprite2).l
; ---------------------------------------------------------------------------

loc_46638:
		jsr	(Refresh_ChildPositionAdjusted).l
		jsr	(Animate_Raw).l
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		beq.s	loc_46654
		clr.b	collision_flags(a0)

loc_46654:
		jmp	(Child_DrawTouch_Sprite2).l
; ---------------------------------------------------------------------------

loc_4665A:
		jsr	(Refresh_ChildPositionAdjusted).l
		move.l	#loc_46670,(a0)
		lea	word_46F28(pc),a1
		jmp	(SetUp_ObjAttributes2).l
; ---------------------------------------------------------------------------

loc_46670:
		jsr	(Refresh_ChildPositionAdjusted).l
		jmp	(Child_Draw_Sprite2).l
; ---------------------------------------------------------------------------

loc_4667C:
		jsr	(Refresh_ChildPositionAdjusted).l
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_46696(pc,d0.w),d1
		jsr	off_46696(pc,d1.w)
		jmp	(Child_Draw_Sprite2).l
; ---------------------------------------------------------------------------
off_46696:
		dc.w loc_466A4-off_46696
		dc.w loc_466AE-off_46696
		dc.w loc_466CE-off_46696
		dc.w loc_466EC-off_46696
		dc.w loc_4672C-off_46696
		dc.w loc_466EC-off_46696
		dc.w locret_464C8-off_46696
; ---------------------------------------------------------------------------

loc_466A4:
		lea	word_46F30(pc),a1
		jmp	(SetUp_ObjAttributes2).l
; ---------------------------------------------------------------------------

loc_466AE:
		movea.w	parent3(a0),a1
		btst	#1,$38(a1)
		bne.s	loc_466BC
		rts
; ---------------------------------------------------------------------------

loc_466BC:
		move.b	#4,routine(a0)
		move.l	#loc_466D4,$34(a0)
		bra.w	loc_46DDE
; ---------------------------------------------------------------------------

loc_466CE:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_466D4:
		move.l	#loc_466F2,$34(a0)

loc_466DC:
		move.b	#6,routine(a0)
		move.l	#byte_47045,$30(a0)
		rts
; ---------------------------------------------------------------------------

loc_466EC:
		jmp	(Animate_RawMultiDelay).l
; ---------------------------------------------------------------------------

loc_466F2:
		move.b	#8,routine(a0)
		move.b	#3,$39(a0)
		move.l	#loc_46706,$34(a0)

loc_46706:
		move.w	#$1C,$2E(a0)
		subq.b	#1,$39(a0)
		cmpi.b	#1,$39(a0)
		beq.s	loc_46722
		lea	ChildObjDat_46FB0(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_46722:
		lea	ChildObjDat_46FBE(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_4672C:
		jsr	(Obj_Wait).l
		tst.b	$39(a0)
		bmi.s	loc_4673A
		rts
; ---------------------------------------------------------------------------

loc_4673A:
		move.b	#$A,routine(a0)
		move.l	#byte_4704C,$30(a0)
		move.l	#loc_46752,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_46752:
		move.b	#$C,routine(a0)
		rts
; ---------------------------------------------------------------------------

loc_4675A:
		jsr	(Refresh_ChildPositionAdjusted).l
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_46774(pc,d0.w),d1
		jsr	off_46774(pc,d1.w)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
off_46774:
		dc.w loc_46778-off_46774
		dc.w loc_466EC-off_46774
; ---------------------------------------------------------------------------

loc_46778:
		lea	word_46F38(pc),a1
		jsr	(SetUp_ObjAttributes2).l
		move.l	#byte_47055,$30(a0)
		move.l	#Go_Delete_Sprite,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_46794:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_467A2(pc,d0.w),d1
		jmp	off_467A2(pc,d1.w)
; ---------------------------------------------------------------------------
off_467A2:
		dc.w sub_467AA-off_467A2
		dc.w loc_467DE-off_467A2
		dc.w loc_464CA-off_467A2
		dc.w loc_467DE-off_467A2

; =============== S U B R O U T I N E =======================================


sub_467AA:
		lea	word_46F40(pc),a1
		jsr	(SetUp_ObjAttributes2).l
		moveq	#signextendB(sfx_Projectile),d0
		jsr	(Play_SFX).l
		move.l	#byte_47062,$30(a0)
		move.l	#loc_467EA,$34(a0)
		move.w	#-$400,y_vel(a0)
		move.w	#$60,$2E(a0)
		jmp	(Draw_Sprite).l
; End of function sub_467AA

; ---------------------------------------------------------------------------

loc_467DE:
		jsr	(Move_AnimateRaw_Wait).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_467EA:
		move.b	#4,routine(a0)
		move.w	#8,$2E(a0)
		move.l	#loc_46800,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_46800:
		move.b	#6,routine(a0)
		moveq	#signextendB(sfx_MissileThrow),d0
		jsr	(Play_SFX).l
		move.w	#$80,priority(a0)
		bset	#1,render_flags(a0)
		move.l	#Go_Delete_Sprite,$34(a0)
		move.w	#$60,$2E(a0)
		movea.w	parent3(a0),a1
		moveq	#0,d0
		move.b	subtype(a1),d0
		bsr.w	loc_46E02
		move.w	(Camera_Y_pos).w,d0
		subi.w	#$20,d0
		move.w	d0,y_pos(a0)
		rts
; ---------------------------------------------------------------------------

Obj_AIZMiniboss_Flame:
		jsr	(Refresh_ChildPositionAdjusted).l
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	.Index(pc,d0.w),d1
		jmp	.Index(pc,d1.w)
; ---------------------------------------------------------------------------
.Index:
		dc.w sub_4685E-.Index
		dc.w loc_464CA-.Index
		dc.w loc_468A6-.Index

; =============== S U B R O U T I N E =======================================


sub_4685E:
		lea	ObjDat_AIZMiniboss_Flame(pc),a1
		jsr	(SetUp_ObjAttributes).l
		bset	#4,shield_reaction(a0)
		move.l	#loc_4688E,$34(a0)
		moveq	#6,d1

loc_46878:
		moveq	#0,d0
		move.b	subtype(a0),d0
		sub.w	d0,d1
		add.b	d1,d1
		move.w	d1,$2E(a0)
		rts
; ---------------------------------------------------------------------------
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_4688E:
		move.b	#4,routine(a0)
		move.l	#byte_47075,$30(a0)
		move.l	#loc_468B2,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_468A6:
		jsr	(Animate_RawMultiDelay).l
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------

loc_468B2:
		move.l	#Map_BossExplosion,mappings(a0)
		move.w	#make_art_tile($4D2,0,1),art_tile(a0)
		move.l	#byte_4707A,$30(a0)
		move.l	#Go_Delete_Sprite,$34(a0)
		cmpi.b	#6,subtype(a0)
		bne.w	locret_464C8
		lea	ChildObjDat_46FE6(pc),a2
		jmp	(CreateChild1_Normal).l
; End of function sub_4685E

; ---------------------------------------------------------------------------

loc_468E4:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_468F8(pc,d0.w),d1
		jsr	off_468F8(pc,d1.w)
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------
off_468F8:
		dc.w loc_468FC-off_468F8
		dc.w loc_46948-off_468F8
; ---------------------------------------------------------------------------

loc_468FC:
		bsr.w	sub_4685E
		move.w	#$100,priority(a0)
		move.l	#byte_47085,$30(a0)
		move.l	#Go_Delete_Sprite,$34(a0)
		movea.w	parent3(a0),a1
		movea.w	parent3(a1),a1
		move.w	a1,parent3(a0)
		move.w	y_pos(a1),y_pos(a0)
		move.w	#-$60,d0
		btst	#0,render_flags(a1)
		beq.s	loc_4693C
		neg.w	d0
		bset	#0,render_flags(a0)

loc_4693C:
		move.w	x_pos(a1),d1
		add.w	d0,d1
		move.w	d1,x_pos(a0)
		rts
; ---------------------------------------------------------------------------

loc_46948:
		jsr	(Animate_RawMultiDelay).l
		tst.w	d2
		beq.s	locret_46966
		bmi.s	locret_46966
		move.w	word_46968(pc,d0.w),d0
		btst	#0,render_flags(a0)
		bne.s	loc_46962
		neg.w	d0

loc_46962:
		add.w	d0,x_pos(a0)

locret_46966:
		rts
; ---------------------------------------------------------------------------
word_46968:
		dc.w     0
		dc.w     0
		dc.w     0
		dc.w   $10
		dc.w     8
		dc.w     8
; ---------------------------------------------------------------------------

Obj_AIZMiniboss:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	.Index(pc,d0.w),d1
		jsr	.Index(pc,d1.w)
		bra.w	loc_46E80
; ---------------------------------------------------------------------------
.Index:
		dc.w loc_46996-.Index
		dc.w loc_469BE-.Index
		dc.w loc_464CA-.Index
		dc.w loc_469FE-.Index
		dc.w loc_4654C-.Index
		dc.w loc_46A5E-.Index
		dc.w loc_46AAA-.Index
		dc.w loc_46AFE-.Index
; ---------------------------------------------------------------------------

loc_46996:
		lea	ObjDat_AIZMiniboss(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.b	#6,collision_property(a0)
		move.b	#1,(Boss_flag).w
		moveq	#$5A,d0
		jsr	(Load_PLC).l
		lea	Pal_AIZMiniboss(pc),a1
		jmp	(PalLoad_Line1).l
; ---------------------------------------------------------------------------

loc_469BE:
		move.w	(Camera_X_pos).w,d0
		move.w	#$10E0,d5
		cmp.w	d5,d0
		bhs.s	loc_469CC
		rts
; ---------------------------------------------------------------------------

loc_469CC:
		move.l	#loc_469D8,$34(a0)
		bra.w	loc_464AC
; ---------------------------------------------------------------------------

loc_469D8:
		move.l	#loc_46A10,$34(a0)
		move.b	#6,routine(a0)
		bsr.w	sub_464F2
		lea	ChildObjDat_46F72(pc),a2
		jsr	(CreateChild1_Normal).l
		lea	ChildObjDat_46F9C(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_469FE:
		jsr	(MoveSprite2).l
		jsr	(Obj_Wait).l
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------

loc_46A10:
		move.l	#loc_46A22,$34(a0)
		move.w	#20,$2E(a0)
		bra.w	loc_46528
; ---------------------------------------------------------------------------

loc_46A22:
		move.l	#loc_46A40,$34(a0)
		move.w	#30,$2E(a0)
		tst.b	(_unkFA80+1).w
		beq.w	locret_464C8
		bset	#1,$38(a0)
		rts
; ---------------------------------------------------------------------------

loc_46A40:
		move.b	#$A,routine(a0)
		move.b	#8,$39(a0)
		moveq	#signextendB(sfx_FlamethrowerQuiet),d0
		jsr	(Play_SFX).l
		lea	Child1_AIZ_MinibossFlames(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_46A5E:
		jsr	(Swing_UpAndDown_Count).l
		beq.s	loc_46A6A
		tst.w	d1
		bmi.s	loc_46A76

loc_46A6A:
		jsr	(MoveSprite2).l
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------

loc_46A76:
		move.b	#6,routine(a0)
		move.w	#$5F,$2E(a0)
		move.l	#loc_46AB6,$34(a0)
		move.w	#-$100,d0
		bchg	#2,$38(a0)
		beq.s	loc_46AA0
		neg.w	d0
		move.l	#loc_46A10,$34(a0)

loc_46AA0:
		move.w	d0,y_vel(a0)
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------

loc_46AAA:
		jsr	(Obj_Wait).l
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------

loc_46AB6:
		move.l	#loc_46AD4,$34(a0)

loc_46ABE:
		move.b	#$C,routine(a0)
		clr.w	x_vel(a0)
		clr.w	y_vel(a0)
		move.w	#$10,$2E(a0)
		rts
; ---------------------------------------------------------------------------

loc_46AD4:
		move.b	#$E,routine(a0)
		move.b	#4,$39(a0)
		move.l	#loc_46B1E,$34(a0)
		move.w	#$100,d0
		bchg	#3,$38(a0)
		bne.s	loc_46AF6
		neg.w	d0

loc_46AF6:
		move.w	d0,x_vel(a0)
		bra.w	Swing_Setup1
; ---------------------------------------------------------------------------

loc_46AFE:
		jsr	(Swing_UpAndDown_Count).l
		bne.s	loc_46B12
		jsr	(MoveSprite2).l
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------

loc_46B12:
		movea.l	$34(a0),a1
		jsr	(a1)
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------

loc_46B1E:
		move.b	#4,$39(a0)
		move.l	#loc_46B38,$34(a0)
		bchg	#0,render_flags(a0)
		jmp	(MoveSprite2).l
; ---------------------------------------------------------------------------

loc_46B38:
		move.l	#loc_46A76,$34(a0)
		bra.w	loc_46ABE
; ---------------------------------------------------------------------------

loc_46B44:
		jsr	(Obj_EndSignControl).l
		lea	ChildObjDat_47022(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_46B54:
		jsr	(Refresh_ChildPositionAdjusted).l
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_46B6E(pc,d0.w),d1
		jsr	off_46B6E(pc,d1.w)
		jmp	(Child_Draw_Sprite2).l
; ---------------------------------------------------------------------------
off_46B6E:
		dc.w loc_466A4-off_46B6E
		dc.w loc_46B7A-off_46B6E
		dc.w loc_464CA-off_46B6E
		dc.w loc_466EC-off_46B6E
		dc.w loc_466EC-off_46B6E
		dc.w locret_464C8-off_46B6E
; ---------------------------------------------------------------------------

loc_46B7A:
		movea.w	parent3(a0),a1
		btst	#1,$38(a1)
		bne.s	loc_46B88
		rts
; ---------------------------------------------------------------------------

loc_46B88:
		move.b	#4,routine(a0)
		move.l	#loc_46B9A,$34(a0)
		bra.w	loc_46DDE
; ---------------------------------------------------------------------------

loc_46B9A:
		move.l	#loc_46BA6,$34(a0)
		bra.w	loc_466DC
; ---------------------------------------------------------------------------

loc_46BA6:
		move.b	#8,routine(a0)
		move.l	#loc_46BC6,$34(a0)
		move.l	#byte_4704C,$30(a0)
		lea	ChildObjDat_46FBE(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_46BC6:
		move.b	#2,routine(a0)
		movea.w	parent3(a0),a1
		bclr	#1,$38(a1)
		rts
; ---------------------------------------------------------------------------

loc_46BD8:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_46BEC(pc,d0.w),d1
		jsr	off_46BEC(pc,d1.w)
		jmp	(Child_DrawTouch_Sprite).l
; ---------------------------------------------------------------------------
off_46BEC:
		dc.w loc_46BF6-off_46BEC
		dc.w loc_46C1A-off_46BEC
		dc.w loc_464CA-off_46BEC
		dc.w loc_46C68-off_46BEC
		dc.w loc_46C84-off_46BEC
; ---------------------------------------------------------------------------

loc_46BF6:
		bsr.w	sub_467AA
		movea.w	parent3(a0),a1
		cmpi.l	#loc_4667C,(a1)
		bne.s	loc_46C0A
		clr.b	collision_flags(a0)

loc_46C0A:
		move.l	#loc_46C2C,$34(a0)
		move.b	#8,y_radius(a0)
		rts
; ---------------------------------------------------------------------------

loc_46C1A:
		jsr	(Animate_Raw).l
		jsr	(MoveSprite2).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_46C2C:
		move.b	#4,routine(a0)
		move.w	#8,$2E(a0)
		move.l	#loc_46C42,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_46C42:
		move.b	#6,routine(a0)
		move.l	#loc_46C6E,$34(a0)
		bset	#1,render_flags(a0)
		bsr.w	sub_46DF2
		move.w	(Camera_Y_pos).w,d0
		subi.w	#$20,d0
		move.w	d0,y_pos(a0)
		rts
; ---------------------------------------------------------------------------

loc_46C68:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_46C6E:
		move.b	#8,routine(a0)
		move.w	#$80,priority(a0)
		move.l	#loc_46C96,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_46C84:
		jsr	(Animate_Raw).l
		jsr	(MoveSprite2).l
		jmp	(ObjHitFloor_DoRoutine).l
; ---------------------------------------------------------------------------

loc_46C96:
		moveq	#signextendB(sfx_MissileExplode),d0
		jsr	(Play_SFX).l
		lea	ChildObjDat_46FEE(pc),a2
		jsr	(CreateChild1_Normal).l
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

loc_46CAE:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_46CBC(pc,d0.w),d1
		jmp	off_46CBC(pc,d1.w)
; ---------------------------------------------------------------------------
off_46CBC:
		dc.w loc_46CC2-off_46CBC
		dc.w loc_464CA-off_46CBC
		dc.w loc_46D00-off_46CBC
; ---------------------------------------------------------------------------

loc_46CC2:
		lea	ObjDat3_46F48(pc),a1
		jsr	(SetUp_ObjAttributes).l
		movea.w	parent3(a0),a1
		tst.b	collision_flags(a1)
		bne.s	loc_46CDA
		clr.b	collision_flags(a0)

loc_46CDA:
		move.l	#AniRaw_BossExplosion,$30(a0)
		move.l	#loc_46CF0,$34(a0)
		moveq	#$C,d1
		bra.w	loc_46878
; ---------------------------------------------------------------------------

loc_46CF0:
		move.b	#4,routine(a0)
		move.l	#Go_Delete_Sprite,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_46D00:
		jsr	(Animate_RawMultiDelay).l
		tst.b	collision_flags(a0)
		beq.s	loc_46D12
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------

loc_46D12:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_46D18:
		lea	ObjDat3_46F60(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_46D9C,(a0)
		move.l	#loc_46DA2,$34(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		move.w	(Camera_X_pos).w,d1
		move.w	word_46D66(pc,d0.w),d2
		add.w	d2,d1
		move.w	d1,x_pos(a0)
		move.w	(Camera_Y_pos).w,d1
		move.w	word_46D72(pc,d0.w),d2
		move.w	d2,y_pos(a0)
		move.w	word_46D7E(pc,d0.w),x_vel(a0)
		move.w	word_46D7E(pc,d0.w),$2E(a0)
		lsr.w	#1,d0
		move.b	byte_46D96(pc,d0.w),mapping_frame(a0)
		rts
; ---------------------------------------------------------------------------
word_46D66:
		dc.w   -$20
		dc.w   -$68
		dc.w   -$10
		dc.w   -$58
		dc.w     -8
		dc.w   -$50
word_46D72:
		dc.w   $310
		dc.w   $310
		dc.w   $31C
		dc.w   $31C
		dc.w   $328
		dc.w   $328
word_46D7E:
		dc.w   $200
		dc.w   $200
		dc.w   $180
		dc.w   $180
		dc.w   $100
		dc.w   $100
		dc.w      0
		dc.w      0
		dc.w      0
		dc.w      0
		dc.w      0
		dc.w      0
byte_46D96:
		dc.b    0
		dc.b    0
		dc.b    1
		dc.b    1
		dc.b    2
		dc.b    2
		even
; ---------------------------------------------------------------------------

loc_46D9C:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_46DA2:
		move.l	#loc_46DAA,(a0)
		rts
; ---------------------------------------------------------------------------

loc_46DAA:
		jsr	(MoveSprite2).l
		jmp	(Child_Draw_Sprite2).l
; ---------------------------------------------------------------------------

loc_46DB6:
		lea	word_46F6C(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#Obj_FlickerMove,(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		lsr.w	#1,d0
		addi.b	#$E,d0
		move.b	d0,mapping_frame(a0)
		moveq	#8,d0
		jmp	(Set_IndexedVelocity).l
; ---------------------------------------------------------------------------

loc_46DDE:
		moveq	#0,d0
		move.b	subtype(a0),d0
		move.w	word_46DEC(pc,d0.w),$2E(a0)
		rts
; ---------------------------------------------------------------------------
word_46DEC:
		dc.w      0
		dc.w    $10
		dc.w    $20

; =============== S U B R O U T I N E =======================================


sub_46DF2:
		movea.w	parent3(a0),a1
		moveq	#0,d0
		move.b	subtype(a1),d0
		move.w	word_46E46(pc,d0.w),$2E(a0)

loc_46E02:
		lsr.w	#1,d0
		move.b	$39(a1),d1
		addq.b	#4,d1
		move.b	d1,$39(a1)
		andi.w	#$C,d1
		add.w	d1,d0
		lea	byte_46E4C(pc),a2
		lea	word_46E6C(pc),a3
		btst	#0,render_flags(a1)
		beq.s	loc_46E2C
		lea	byte_46E5C(pc),a2
		lea	word_46E76(pc),a3

loc_46E2C:
		move.b	(a2,d0.w),d0
		add.w	d0,d0
		move.w	(a3,d0.w),d0
		add.w	(Camera_X_pos).w,d0
		move.w	d0,x_pos(a0)
		move.w	#$400,y_vel(a0)
		rts
; End of function sub_46DF2

; ---------------------------------------------------------------------------
word_46E46:
		dc.w      0
		dc.w    $20
		dc.w    $40
byte_46E4C:
		dc.b    2
		dc.b    3
		dc.b    4
		dc.b    0
		dc.b    0
		dc.b    2
		dc.b    4
		dc.b    0
		dc.b    1
		dc.b    3
		dc.b    4
		dc.b    0
		dc.b    0
		dc.b    1
		dc.b    4
		dc.b    0
byte_46E5C:
		dc.b    3
		dc.b    2
		dc.b    0
		dc.b    0
		dc.b    4
		dc.b    3
		dc.b    1
		dc.b    0
		dc.b    4
		dc.b    2
		dc.b    0
		dc.b    0
		dc.b    3
		dc.b    2
		dc.b    1
		dc.b    0
		even
word_46E6C:
		dc.w    $24
		dc.w    $4C
		dc.w    $74
		dc.w    $9C
		dc.w    $C4
word_46E76:
		dc.w    $7C
		dc.w    $A4
		dc.w    $CC
		dc.w    $F4
		dc.w   $11C
; ---------------------------------------------------------------------------

loc_46E80:
		tst.b	collision_flags(a0)
		bne.s	locret_46ED2
		tst.b	collision_property(a0)
		beq.s	loc_46ED4
		tst.b	$20(a0)
		bne.s	loc_46EA6
		move.b	#$20,$20(a0)
		moveq	#signextendB(sfx_BossHit),d0
		jsr	(Play_SFX).l
		bset	#6,status(a0)

loc_46EA6:
		moveq	#0,d0
		btst	#0,$20(a0)
		bne.s	loc_46EB2
		addq.w	#2*4,d0

loc_46EB2:
		lea	word_46EFC(pc),a1
		lea	word_46F04(pc,d0.w),a2
		jsr	(CopyWordData_4).l
		subq.b	#1,$20(a0)
		bne.s	locret_46ED2
		bclr	#6,status(a0)
		move.b	$25(a0),collision_flags(a0)

locret_46ED2:
		rts
; ---------------------------------------------------------------------------

loc_46ED4:
		move.l	#Wait_Draw,(a0)
		move.l	#loc_46B44,$34(a0)
		clr.w	x_vel(a0)
		clr.w	y_vel(a0)
		lea	(Child6_CreateBossExplosion).l,a2
		jsr	(CreateChild1_Normal).l
		jmp	(BossDefeated_StopTimer).l
; ---------------------------------------------------------------------------
word_46EFC:
		dc.w Normal_palette_line_2+$0E, Normal_palette_line_2+$14, Normal_palette_line_2+$16, Normal_palette_line_2+$1C
word_46F04:
		dc.w   $644,  $240,   $20,  $644
		dc.w   $888,  $AAA,  $EEE,  $AAA
ObjDat_AIZMiniboss:
		dc.l Map_AIZMiniboss
		dc.w make_art_tile($41A,1,1)
		dc.w   $200
		dc.b  $20, $20,   0,  $F
word_46F20:
		dc.w make_art_tile($41A,0,1)
		dc.w   $180
		dc.b  $28, $10,   2, $9C
word_46F28:
		dc.w make_art_tile($41A,1,1)
		dc.w   $200
		dc.b    4,   8,   6,   0
word_46F30:
		dc.w make_art_tile($41A,1,1)
		dc.w   $280
		dc.b    8,   8,   3,   0
word_46F38:
		dc.w make_art_tile($41A,0,0)
		dc.w   $200
		dc.b    8,   8,   7,   0
word_46F40:
		dc.w make_art_tile($41A,0,0)
		dc.w   $280
		dc.b    8, $10,  $C, $98
ObjDat3_46F48:
		dc.l Map_BossExplosion
		dc.w make_art_tile($4D2,0,0)
		dc.w    $80
		dc.b   $C,  $C,   0, $97
ObjDat_AIZMiniboss_Flame:
		dc.l Map_AIZMinibossFlame
		dc.w make_art_tile($482,0,1)
		dc.w   $100
		dc.b  $10, $10,   0, $8B
ObjDat3_46F60:
		dc.l Map_AIZMinibossSmall
		dc.w make_art_tile($474,1,0)
		dc.w   $380
		dc.b  $10, $10,   0,   0
word_46F6C:
		dc.w   $200
		dc.b  $10, $14,   0,   0
ChildObjDat_46F72:
		dc.w 2-1
		dc.l loc_4660E
		dc.b    0, $20
		dc.l loc_4665A
		dc.b -$24,   8
ChildObjDat_46F80:
		dc.w 6-1
		dc.l loc_46D18
		dc.b    0,   0
ChildObjDat_46F88:
		dc.w 3-1
		dc.l loc_4667C
		dc.b    0,-$20
		dc.l loc_4667C
		dc.b    9,-$1C
		dc.l loc_4667C
		dc.b  $12,-$18
ChildObjDat_46F9C:
		dc.w 3-1
		dc.l loc_46B54
		dc.b    0,-$20
		dc.l loc_46B54
		dc.b    9,-$1C
		dc.l loc_46B54
		dc.b  $12,-$18
ChildObjDat_46FB0:
		dc.w 2-1
		dc.l loc_4675A
		dc.b    0,   4
		dc.l loc_46794
		dc.b    0,   4
ChildObjDat_46FBE:
		dc.w 2-1
		dc.l loc_4675A
		dc.b    0,   4
		dc.l loc_46BD8
		dc.b    0,   4
Child1_AIZ_MinibossFlames:
		dc.w 4-1
		dc.l Obj_AIZMiniboss_Flame
		dc.b -$64,   4
		dc.l Obj_AIZMiniboss_Flame
		dc.b -$54,   4
		dc.l Obj_AIZMiniboss_Flame
		dc.b -$44,   4
		dc.l Obj_AIZMiniboss_Flame
		dc.b -$2C,   3
ChildObjDat_46FE6:
		dc.w 1-1
		dc.l loc_468E4
		dc.b    0,   0
ChildObjDat_46FEE:
		dc.w 7-1
		dc.l loc_46CAE
		dc.b    0,-$24
		dc.l loc_46CAE
		dc.b    8,-$1C
		dc.l loc_46CAE
		dc.b   -8,-$1C
		dc.l loc_46CAE
		dc.b    4,-$14
		dc.l loc_46CAE
		dc.b   -4,-$14
		dc.l loc_46CAE
		dc.b    4,  -4
		dc.l loc_46CAE
		dc.b   -4,  -4
ChildObjDat_4701A:
		dc.w 1-1
		dc.l Obj_BossExplosionSpecial
		dc.b    0,   0
ChildObjDat_47022:
		dc.w 4-1
		dc.l loc_46DB6
		dc.b -$10,  -8
		dc.l loc_46DB6
		dc.b   $C,-$10
		dc.l loc_46DB6
		dc.b -$10, $14
		dc.l loc_46DB6
		dc.b  $10,  $C
byte_4703C:
		dc.b    1,   1,   2, $FC
		dc.b    7,   3,   4,   5, $F4
byte_47045:
		dc.b    3,   5
		dc.b    4,   5
		dc.b    5, $17
		dc.b  $F4
byte_4704C:
		dc.b    5, $17
		dc.b    5, $17
		dc.b    4,   5
		dc.b    3,   5
		dc.b  $F4
byte_47055:
		dc.b    7,   1
		dc.b    7,   1
		dc.b    8,   1
		dc.b    9,   3
		dc.b   $A,   3
		dc.b   $B,   3
		dc.b  $F4
byte_47062:
		dc.b    1,  $C,  $D, $FC
		dc.b    0,   0
		dc.b    0,   0
		dc.b    1,   1
		dc.b    2,   2
		dc.b    3,   3
		dc.b    4,   4
		dc.b    5,   4
		dc.b  $F4
byte_47075:
		dc.b    0,   1
		dc.b    0,   1
		dc.b  $F4
byte_4707A:
		dc.b    2,   1
		dc.b    2,   1
		dc.b    3,   2
		dc.b    4,   4
		dc.b    5,   1
		dc.b  $F4
byte_47085:
		dc.b    0,   1
		dc.b    0,   1
		dc.b    1,   2
		dc.b    2,   2
		dc.b    3,   4
		dc.b    4,   4
		dc.b  $F4
		even
Pal_AIZMiniboss:
		binclude "Levels/AIZ/Palettes/Miniboss.bin"
		even
; ---------------------------------------------------------------------------

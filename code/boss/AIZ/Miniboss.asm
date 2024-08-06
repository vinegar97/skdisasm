Obj_AIZMinibossCutscene:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	.Index(pc,d0.w),d1
		jsr	.Index(pc,d1.w)
		bra.w	loc_68F62
; ---------------------------------------------------------------------------
.Index:
		dc.w loc_68508-.Index
		dc.w loc_6852C-.Index
		dc.w loc_68574-.Index
		dc.w loc_685B8-.Index
		dc.w loc_685FC-.Index
; ---------------------------------------------------------------------------

loc_68508:
		lea	ObjDat_AIZMiniboss(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.b	#$60,collision_property(a0)
		move.w	(Camera_max_X_pos).w,(Camera_stored_max_X_pos).w
		move.b	#1,(Boss_flag).w
		moveq	#$5A,d0
		jmp	(Load_PLC).l
; ---------------------------------------------------------------------------

loc_6852C:
		move.w	(Camera_X_pos).w,d0
		move.w	#$2F10,d5
		cmp.w	d5,d0
		bhs.s	+ ;loc_6853A
		rts
; ---------------------------------------------------------------------------

+ ;loc_6853A:
		move.l	#loc_6857A,$34(a0)
		lea	ChildObjDat_6906A(pc),a2
		jsr	(CreateChild3_NormalRepeated).l
		lea	Pal_AIZMiniboss(pc),a1
		jsr	(PalLoad_Line1).l

loc_68556:
		move.b	#4,routine(a0)
		move.w	#3*60,$2E(a0)
		move.w	d5,(Camera_min_X_pos).w
		move.w	d5,(Camera_max_X_pos).w
		moveq	#signextendB(mus_FadeOut),d0
		jsr	(Play_Music).l

locret_68572:
		rts
; ---------------------------------------------------------------------------

loc_68574:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_6857A:
		move.l	#loc_685BE,$34(a0)
		move.b	#6,routine(a0)
		lea	ChildObjDat_6905C(pc),a2
		jsr	(CreateChild1_Normal).l
		lea	ChildObjDat_69072(pc),a2
		jsr	(CreateChild1_Normal).l

; =============== S U B R O U T I N E =======================================


sub_6859C:
		move.w	#$100,y_vel(a0)
		move.w	#$AF,$2E(a0)
		moveq	#signextendB(mus_Miniboss),d0
		jsr	(Play_Music).l
		move.b	#mus_Miniboss,(Current_music+1).w
		rts
; End of function sub_6859C

; ---------------------------------------------------------------------------

loc_685B8:
		jmp	(MoveWaitTouch).l
; ---------------------------------------------------------------------------

loc_685BE:
		move.w	#$7F,$2E(a0)
		move.l	#loc_6862E,$34(a0)
		move.b	#3,$39(a0)
		bset	#1,$38(a0)

loc_685D8:
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

loc_685FC:
		jsr	(Swing_UpAndDown).l
		jmp	(MoveWaitTouch).l
; ---------------------------------------------------------------------------
		subq.b	#1,$39(a0)
		bpl.s	+ ;loc_68616
		move.l	#loc_6862E,$34(a0)

+ ;loc_68616:
		move.w	#$40,$2E(a0)
		moveq	#signextendB(sfx_FlamethrowerQuiet),d0
		jsr	(Play_SFX).l
		lea	Child1_AIZ_MinibossFlames(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_6862E:
		move.w	#$10,$2E(a0)
		move.l	#loc_68646,$34(a0)
		lea	ChildObjDat_69104(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_68646:
		move.l	#loc_68690,(a0)
		lea	Pal_AIZMiniboss(pc),a1
		jsr	(PalLoad_Line1).l
		move.b	#$F,collision_flags(a0)
		moveq	#signextendB(mus_FadeOut),d0
		jsr	(Play_Music).l
		move.w	#$400,x_vel(a0)
		clr.w	y_vel(a0)
		move.w	#$40,$2E(a0)
		cmpi.w	#0,(Current_zone_and_act).w
		bne.s	+ ;loc_68682
		move.w	#$120,$2E(a0)

+ ;loc_68682:
		move.l	#Go_Delete_Sprite,$34(a0)
		st	(Events_fg_5).w
		rts
; ---------------------------------------------------------------------------

loc_68690:
		jsr	(MoveSprite2).l
		subq.w	#1,$2E(a0)
		bmi.s	+ ;loc_686A2
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

+ ;loc_686A2:
		clr.b	(Boss_flag).w
		jsr	(Restore_LevelMusic).l
		lea	(PLC_Monitors).l,a1
		jsr	(Load_PLC_Raw).l
		jmp	(Go_Delete_Sprite_2).l
; ---------------------------------------------------------------------------

loc_686BE:
		jsr	(Refresh_ChildPositionAdjusted).l
		lea	word_6900A(pc),a1
		jsr	(SetUp_ObjAttributes2).l
		bset	#4,shield_reaction(a0)
		move.l	#byte_69126,$30(a0)
		move.l	#loc_686E8,(a0)
		jmp	(Child_DrawTouch_Sprite2).l
; ---------------------------------------------------------------------------

loc_686E8:
		jsr	(Refresh_ChildPositionAdjusted).l
		jsr	(Animate_Raw).l
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		beq.s	+ ;loc_68704
		clr.b	collision_flags(a0)

+ ;loc_68704:
		jmp	(Child_DrawTouch_Sprite2).l
; ---------------------------------------------------------------------------

loc_6870A:
		jsr	(Refresh_ChildPositionAdjusted).l
		move.l	#loc_68720,(a0)
		lea	word_69012(pc),a1
		jmp	(SetUp_ObjAttributes2).l
; ---------------------------------------------------------------------------

loc_68720:
		jsr	(Refresh_ChildPositionAdjusted).l
		jmp	(Child_Draw_Sprite2).l
; ---------------------------------------------------------------------------

loc_6872C:
		jsr	(Refresh_ChildPositionAdjusted).l
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_68746(pc,d0.w),d1
		jsr	off_68746(pc,d1.w)
		jmp	(Child_Draw_Sprite2).l
; ---------------------------------------------------------------------------
off_68746:
		dc.w loc_68754-off_68746
		dc.w loc_6875E-off_68746
		dc.w loc_6877E-off_68746
		dc.w loc_6879C-off_68746
		dc.w loc_687DC-off_68746
		dc.w loc_6879C-off_68746
		dc.w locret_68572-off_68746
; ---------------------------------------------------------------------------

loc_68754:
		lea	word_6901A(pc),a1
		jmp	(SetUp_ObjAttributes2).l
; ---------------------------------------------------------------------------

loc_6875E:
		movea.w	parent3(a0),a1
		btst	#1,$38(a1)
		bne.s	+ ;loc_6876C
		rts
; ---------------------------------------------------------------------------

+ ;loc_6876C:
		move.b	#4,routine(a0)
		move.l	#loc_68784,$34(a0)
		bra.w	loc_68EC0
; ---------------------------------------------------------------------------

loc_6877E:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_68784:
		move.l	#loc_687A2,$34(a0)

loc_6878C:
		move.b	#6,routine(a0)
		move.l	#byte_6912F,$30(a0)
		rts
; ---------------------------------------------------------------------------

loc_6879C:
		jmp	(Animate_RawMultiDelay).l
; ---------------------------------------------------------------------------

loc_687A2:
		move.b	#8,routine(a0)
		move.b	#3,$39(a0)
		move.l	#loc_687B6,$34(a0)

loc_687B6:
		move.w	#$1C,$2E(a0)
		subq.b	#1,$39(a0)
		cmpi.b	#1,$39(a0)
		beq.s	+ ;loc_687D2
		lea	ChildObjDat_6909A(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

+ ;loc_687D2:
		lea	ChildObjDat_690A8(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_687DC:
		jsr	(Obj_Wait).l
		tst.b	$39(a0)
		bmi.s	+ ;loc_687EA
		rts
; ---------------------------------------------------------------------------

+ ;loc_687EA:
		move.b	#$A,routine(a0)
		move.l	#byte_69136,$30(a0)
		move.l	#loc_68802,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_68802:
		move.b	#$C,routine(a0)
		rts
; ---------------------------------------------------------------------------

loc_6880A:
		jsr	(Refresh_ChildPositionAdjusted).l
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_68824(pc,d0.w),d1
		jsr	off_68824(pc,d1.w)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
off_68824:
		dc.w loc_68828-off_68824
		dc.w loc_6879C-off_68824
; ---------------------------------------------------------------------------

loc_68828:
		lea	byte_69022(pc),a1
		jsr	(SetUp_ObjAttributes2).l
		move.l	#byte_6913F,$30(a0)
		move.l	#Go_Delete_Sprite,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_68844:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_68852(pc,d0.w),d1
		jmp	off_68852(pc,d1.w)
; ---------------------------------------------------------------------------
off_68852:
		dc.w sub_6885A-off_68852
		dc.w loc_6888E-off_68852
		dc.w loc_68574-off_68852
		dc.w loc_6888E-off_68852

; =============== S U B R O U T I N E =======================================


sub_6885A:
		lea	word_6902A(pc),a1
		jsr	(SetUp_ObjAttributes2).l
		moveq	#signextendB(sfx_Projectile),d0
		jsr	(Play_SFX).l
		move.l	#byte_6914C,$30(a0)
		move.l	#loc_6889A,$34(a0)
		move.w	#-$400,y_vel(a0)
		move.w	#$60,$2E(a0)
		jmp	(Draw_Sprite).l
; End of function sub_6885A

; ---------------------------------------------------------------------------

loc_6888E:
		jsr	(Move_AnimateRaw_Wait).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_6889A:
		move.b	#4,routine(a0)
		move.w	#8,$2E(a0)
		move.l	#loc_688B0,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_688B0:
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
		bsr.w	sub_68EE4
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
		dc.w sub_6890E-.Index
		dc.w loc_68574-.Index
		dc.w loc_68956-.Index

; =============== S U B R O U T I N E =======================================


sub_6890E:
		lea	ObjDat_AIZMiniboss_Flame(pc),a1
		jsr	(SetUp_ObjAttributes).l
		bset	#4,shield_reaction(a0)
		move.l	#loc_6893E,$34(a0)
		moveq	#6,d1

loc_68928:
		moveq	#0,d0
		move.b	subtype(a0),d0
		sub.w	d0,d1
		add.b	d1,d1
		move.w	d1,$2E(a0)
		rts
; ---------------------------------------------------------------------------
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_6893E:
		move.b	#4,routine(a0)
		move.l	#byte_6915F,$30(a0)
		move.l	#loc_68962,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_68956:
		jsr	(Animate_RawMultiDelay).l
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------

loc_68962:
		move.l	#Map_BossExplosion,mappings(a0)
		move.w	#make_art_tile($4D2,0,1),art_tile(a0)
		move.l	#byte_69164,$30(a0)
		move.l	#Go_Delete_Sprite,$34(a0)
		cmpi.b	#6,subtype(a0)
		bne.w	locret_68572
		lea	ChildObjDat_690D0(pc),a2
		jmp	(CreateChild1_Normal).l
; End of function sub_6890E

; ---------------------------------------------------------------------------

loc_68994:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_689A8(pc,d0.w),d1
		jsr	off_689A8(pc,d1.w)
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------
off_689A8:
		dc.w loc_689AC-off_689A8
		dc.w loc_689F8-off_689A8
; ---------------------------------------------------------------------------

loc_689AC:
		bsr.w	sub_6890E
		move.w	#$100,priority(a0)
		move.l	#byte_6916F,$30(a0)
		move.l	#Go_Delete_Sprite,$34(a0)
		movea.w	parent3(a0),a1
		movea.w	parent3(a1),a1
		move.w	a1,parent3(a0)
		move.w	y_pos(a1),y_pos(a0)
		move.w	#-$60,d0
		btst	#0,render_flags(a1)
		beq.s	+ ;loc_689EC
		neg.w	d0
		bset	#0,render_flags(a0)

+ ;loc_689EC:
		move.w	x_pos(a1),d1
		add.w	d0,d1
		move.w	d1,x_pos(a0)
		rts
; ---------------------------------------------------------------------------

loc_689F8:
		jsr	(Animate_RawMultiDelay).l
		tst.w	d2
		beq.s	locret_68A16
		bmi.s	locret_68A16
		move.w	word_68A18(pc,d0.w),d0
		btst	#0,render_flags(a0)
		bne.s	+ ;loc_68A12
		neg.w	d0

+ ;loc_68A12:
		add.w	d0,x_pos(a0)

locret_68A16:
		rts
; ---------------------------------------------------------------------------
word_68A18:
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
		bra.w	loc_68F62
; ---------------------------------------------------------------------------
.Index:
		dc.w loc_68A46-.Index
		dc.w loc_68A6E-.Index
		dc.w loc_68574-.Index
		dc.w loc_68ABA-.Index
		dc.w loc_685FC-.Index
		dc.w loc_68B1C-.Index
		dc.w loc_68B68-.Index
		dc.w loc_68BBC-.Index
; ---------------------------------------------------------------------------

loc_68A46:
		lea	ObjDat_AIZMiniboss(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.b	#6,collision_property(a0)
		move.b	#1,(Boss_flag).w
		moveq	#$5A,d0
		jsr	(Load_PLC).l
		lea	Pal_AIZMiniboss(pc),a1
		jmp	(PalLoad_Line1).l
; ---------------------------------------------------------------------------

loc_68A6E:
		move.w	(Camera_X_pos).w,d0
		move.w	#$10E0,d5
		cmpi.b	#2,(Player_1+character_id).w
		bne.s	+ ;loc_68A82
		move.w	#$10C0,d5

+ ;loc_68A82:
		cmp.w	d5,d0
		bhs.s	+ ;loc_68A88
		rts
; ---------------------------------------------------------------------------

+ ;loc_68A88:
		move.l	#loc_68A94,$34(a0)
		bra.w	loc_68556
; ---------------------------------------------------------------------------

loc_68A94:
		move.l	#loc_68ACC,$34(a0)
		move.b	#6,routine(a0)
		bsr.w	sub_6859C
		lea	ChildObjDat_6905C(pc),a2
		jsr	(CreateChild1_Normal).l
		lea	ChildObjDat_69086(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_68ABA:
		jsr	(MoveSprite2).l
		jsr	(Obj_Wait).l
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------

loc_68ACC:
		move.l	#loc_68ADE,$34(a0)
		move.w	#20,$2E(a0)
		bra.w	loc_685D8
; ---------------------------------------------------------------------------

loc_68ADE:
		move.l	#loc_68AFE,$34(a0)
		move.w	#30,$2E(a0)
		cmpi.b	#2,(Player_1+character_id).w
		bne.w	locret_68572
		bset	#1,$38(a0)
		rts
; ---------------------------------------------------------------------------

loc_68AFE:
		move.b	#$A,routine(a0)
		move.b	#8,$39(a0)
		moveq	#signextendB(sfx_FlamethrowerQuiet),d0
		jsr	(Play_SFX).l
		lea	Child1_AIZ_MinibossFlames(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_68B1C:
		jsr	(Swing_UpAndDown_Count).l
		beq.s	+ ;loc_68B28
		tst.w	d1
		bmi.s	loc_68B34

+ ;loc_68B28:
		jsr	(MoveSprite2).l
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------

loc_68B34:
		move.b	#6,routine(a0)
		move.w	#$5F,$2E(a0)
		move.l	#loc_68B74,$34(a0)
		move.w	#-$100,d0
		bchg	#2,$38(a0)
		beq.s	+ ;loc_68B5E
		neg.w	d0
		move.l	#loc_68ACC,$34(a0)

+ ;loc_68B5E:
		move.w	d0,y_vel(a0)
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------

loc_68B68:
		jsr	(Obj_Wait).l
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------

loc_68B74:
		move.l	#loc_68B92,$34(a0)

loc_68B7C:
		move.b	#$C,routine(a0)
		clr.w	x_vel(a0)
		clr.w	y_vel(a0)
		move.w	#$10,$2E(a0)
		rts
; ---------------------------------------------------------------------------

loc_68B92:
		move.b	#$E,routine(a0)
		move.b	#4,$39(a0)
		move.l	#loc_68BDC,$34(a0)
		move.w	#$100,d0
		bchg	#3,$38(a0)
		bne.s	+ ;loc_68BB4
		neg.w	d0

+ ;loc_68BB4:
		move.w	d0,x_vel(a0)
		bra.w	Swing_Setup1
; ---------------------------------------------------------------------------

loc_68BBC:
		jsr	(Swing_UpAndDown_Count).l
		bne.s	+ ;loc_68BD0
		jsr	(MoveSprite2).l
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------

+ ;loc_68BD0:
		movea.l	$34(a0),a1
		jsr	(a1)
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------

loc_68BDC:
		move.b	#4,$39(a0)
		move.l	#loc_68BF6,$34(a0)
		bchg	#0,render_flags(a0)
		jmp	(MoveSprite2).l
; ---------------------------------------------------------------------------

loc_68BF6:
		move.l	#loc_68B34,$34(a0)
		bra.w	loc_68B7C
; ---------------------------------------------------------------------------

loc_68C02:
		jsr	(Obj_EndSignControl).l
		lea	ChildObjDat_6910C(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_68C12:
		jsr	(Refresh_ChildPositionAdjusted).l
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_68C2C(pc,d0.w),d1
		jsr	off_68C2C(pc,d1.w)
		jmp	(Child_Draw_Sprite2).l
; ---------------------------------------------------------------------------
off_68C2C:
		dc.w loc_68754-off_68C2C
		dc.w loc_68C38-off_68C2C
		dc.w loc_68574-off_68C2C
		dc.w loc_6879C-off_68C2C
		dc.w loc_6879C-off_68C2C
		dc.w locret_68572-off_68C2C
; ---------------------------------------------------------------------------

loc_68C38:
		movea.w	parent3(a0),a1
		btst	#1,$38(a1)
		bne.s	+ ;loc_68C46
		rts
; ---------------------------------------------------------------------------

+ ;loc_68C46:
		move.b	#4,routine(a0)
		move.l	#loc_68C58,$34(a0)
		bra.w	loc_68EC0
; ---------------------------------------------------------------------------

loc_68C58:
		move.l	#loc_68C64,$34(a0)
		bra.w	loc_6878C
; ---------------------------------------------------------------------------

loc_68C64:
		move.b	#8,routine(a0)
		move.l	#loc_68C84,$34(a0)
		move.l	#byte_69136,$30(a0)
		lea	ChildObjDat_690A8(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_68C84:
		move.b	#2,routine(a0)
		movea.w	parent3(a0),a1
		bclr	#1,$38(a1)
		rts
; ---------------------------------------------------------------------------

loc_68C96:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_68CC6(pc,d0.w),d1
		jsr	off_68CC6(pc,d1.w)
		movea.w	parent3(a0),a1
		movea.w	parent3(a1),a1
		btst	#7,status(a1)
		bne.s	+ ;loc_68CC0
		jsr	(Add_SpriteToCollisionResponseList).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

+ ;loc_68CC0:
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------
off_68CC6:
		dc.w loc_68CD0-off_68CC6
		dc.w loc_68CF4-off_68CC6
		dc.w loc_68574-off_68CC6
		dc.w loc_68D42-off_68CC6
		dc.w loc_68D5E-off_68CC6
; ---------------------------------------------------------------------------

loc_68CD0:
		bsr.w	sub_6885A
		movea.w	parent3(a0),a1
		cmpi.l	#loc_6872C,(a1)
		bne.s	+ ;loc_68CE4
		clr.b	collision_flags(a0)

+ ;loc_68CE4:
		move.l	#loc_68D06,$34(a0)
		move.b	#8,y_radius(a0)
		rts
; ---------------------------------------------------------------------------

loc_68CF4:
		jsr	(Animate_Raw).l
		jsr	(MoveSprite2).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_68D06:
		move.b	#4,routine(a0)
		move.w	#8,$2E(a0)
		move.l	#loc_68D1C,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_68D1C:
		move.b	#6,routine(a0)
		move.l	#loc_68D48,$34(a0)
		bset	#1,render_flags(a0)
		bsr.w	sub_68ED4
		move.w	(Camera_Y_pos).w,d0
		subi.w	#$20,d0
		move.w	d0,y_pos(a0)
		rts
; ---------------------------------------------------------------------------

loc_68D42:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_68D48:
		move.b	#8,routine(a0)
		move.w	#$80,priority(a0)
		move.l	#loc_68D70,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_68D5E:
		jsr	(Animate_Raw).l
		jsr	(MoveSprite2).l
		jmp	(ObjHitFloor_DoRoutine).l
; ---------------------------------------------------------------------------

loc_68D70:
		moveq	#signextendB(sfx_MissileExplode),d0
		jsr	(Play_SFX).l
		lea	ChildObjDat_690D8(pc),a2
		jsr	(CreateChild1_Normal).l
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

loc_68D88:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_68D96(pc,d0.w),d1
		jmp	off_68D96(pc,d1.w)
; ---------------------------------------------------------------------------
off_68D96:
		dc.w loc_68D9C-off_68D96
		dc.w loc_68DD8-off_68D96
		dc.w loc_68DEE-off_68D96
; ---------------------------------------------------------------------------

loc_68D9C:
		lea	ObjDat3_69032(pc),a1
		jsr	(SetUp_ObjAttributes).l
		cmpi.b	#0,(Current_zone).w
		beq.s	+ ;loc_68DB4
		move.w	#make_art_tile($500,0,0),art_tile(a0)

+ ;loc_68DB4:
		movea.w	parent3(a0),a1
		tst.b	collision_flags(a1)
		bne.s	+ ;loc_68DC2
		clr.b	collision_flags(a0)

+ ;loc_68DC2:
		move.l	#AniRaw_BossExplosion,$30(a0)
		move.l	#loc_68DDE,$34(a0)
		moveq	#$C,d1
		bra.w	loc_68928
; ---------------------------------------------------------------------------

loc_68DD8:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_68DDE:
		move.b	#4,routine(a0)
		move.l	#Go_Delete_Sprite,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_68DEE:
		jsr	(Animate_RawMultiDelay).l
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------

loc_68DFA:
		lea	ObjDat3_6904A(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_68E7E,(a0)
		move.l	#loc_68E84,$34(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		move.w	(Camera_X_pos).w,d1
		move.w	word_68E48(pc,d0.w),d2
		add.w	d2,d1
		move.w	d1,x_pos(a0)
		move.w	(Camera_Y_pos).w,d1
		move.w	word_68E54(pc,d0.w),d2
		move.w	d2,y_pos(a0)
		move.w	word_68E60(pc,d0.w),x_vel(a0)
		move.w	word_68E60(pc,d0.w),$2E(a0)
		lsr.w	#1,d0
		move.b	byte_68E78(pc,d0.w),mapping_frame(a0)
		rts
; ---------------------------------------------------------------------------
word_68E48:
		dc.w   -$20
		dc.w   -$68
		dc.w   -$10
		dc.w   -$58
		dc.w     -8
		dc.w   -$50
word_68E54:
		dc.w   $310
		dc.w   $310
		dc.w   $31C
		dc.w   $31C
		dc.w   $328
		dc.w   $328
word_68E60:
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
byte_68E78:
		dc.b    0
		dc.b    0
		dc.b    1
		dc.b    1
		dc.b    2
		dc.b    2
		even
; ---------------------------------------------------------------------------

loc_68E7E:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_68E84:
		move.l	#loc_68E8C,(a0)
		rts
; ---------------------------------------------------------------------------

loc_68E8C:
		jsr	(MoveSprite2).l
		jmp	(Child_Draw_Sprite2).l
; ---------------------------------------------------------------------------

loc_68E98:
		lea	word_69056(pc),a1
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

loc_68EC0:
		moveq	#0,d0
		move.b	subtype(a0),d0
		move.w	word_68ECE(pc,d0.w),$2E(a0)
		rts
; ---------------------------------------------------------------------------
word_68ECE:
		dc.w      0
		dc.w    $10
		dc.w    $20

; =============== S U B R O U T I N E =======================================


sub_68ED4:
		movea.w	parent3(a0),a1
		moveq	#0,d0
		move.b	subtype(a1),d0
		move.w	word_68F28(pc,d0.w),$2E(a0)

sub_68EE4:
		lsr.w	#1,d0
		move.b	$39(a1),d1
		addq.b	#4,d1
		move.b	d1,$39(a1)
		andi.w	#$C,d1
		add.w	d1,d0
		lea	byte_68F2E(pc),a2
		lea	word_68F4E(pc),a3
		btst	#0,render_flags(a1)
		beq.s	+ ;loc_68F0E
		lea	byte_68F3E(pc),a2
		lea	word_68F58(pc),a3

+ ;loc_68F0E:
		move.b	(a2,d0.w),d0
		add.w	d0,d0
		move.w	(a3,d0.w),d0
		add.w	(Camera_X_pos).w,d0
		move.w	d0,x_pos(a0)
		move.w	#$400,y_vel(a0)
		rts
; End of function sub_68ED4

; ---------------------------------------------------------------------------
word_68F28:
		dc.w      0
		dc.w    $20
		dc.w    $40
byte_68F2E:
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
byte_68F3E:
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
word_68F4E:
		dc.w    $24
		dc.w    $4C
		dc.w    $74
		dc.w    $9C
		dc.w    $C4
word_68F58:
		dc.w    $7C
		dc.w    $A4
		dc.w    $CC
		dc.w    $F4
		dc.w   $11C
; ---------------------------------------------------------------------------

loc_68F62:
		tst.b	collision_flags(a0)
		bne.s	locret_68FB4
		tst.b	collision_property(a0)
		beq.s	+++ ;loc_68FB6
		tst.b	$20(a0)
		bne.s	+ ;loc_68F88
		move.b	#$20,$20(a0)
		moveq	#signextendB(sfx_BossHit),d0
		jsr	(Play_SFX).l
		bset	#6,status(a0)

+ ;loc_68F88:
		moveq	#0,d0
		btst	#0,$20(a0)
		bne.s	+ ;loc_68F94
		addq.w	#2*4,d0

+ ;loc_68F94:
		lea	word_68FE6(pc),a1
		lea	word_68FEE(pc,d0.w),a2
		jsr	(CopyWordData_4).l
		subq.b	#1,$20(a0)
		bne.s	locret_68FB4
		bclr	#6,status(a0)
		move.b	$25(a0),collision_flags(a0)

locret_68FB4:
		rts
; ---------------------------------------------------------------------------

+ ;loc_68FB6:
		move.l	#Wait_FadeToLevelMusic,(a0)
		move.l	#loc_68C02,$34(a0)
		clr.w	x_vel(a0)
		clr.w	y_vel(a0)
		lea	(Child6_CreateBossExplosion).l,a2
		jsr	(CreateChild6_Simple).l
		bne.s	+ ;loc_68FE0
		move.b	#$10,subtype(a1)

+ ;loc_68FE0:
		jmp	(BossDefeated_StopTimer).l
; ---------------------------------------------------------------------------
word_68FE6:
		dc.w Normal_palette_line_2+$0E, Normal_palette_line_2+$14, Normal_palette_line_2+$16, Normal_palette_line_2+$1C
word_68FEE:
		dc.w   $644,  $240,   $20,  $644
		dc.w   $888,  $AAA,  $EEE,  $AAA
ObjDat_AIZMiniboss:
		dc.l Map_AIZMiniboss
		dc.w make_art_tile($41A,1,1)
		dc.w   $200
		dc.b  $20, $20,   0,  $F
word_6900A:
		dc.w make_art_tile($41A,0,1)
		dc.w   $180
		dc.b  $28, $10,   2, $9C
word_69012:
		dc.w make_art_tile($41A,1,1)
		dc.w   $200
		dc.b    4,   8,   6,   0
word_6901A:
		dc.w make_art_tile($41A,1,1)
		dc.w   $280
		dc.b    8,   8,   3,   0
byte_69022:
		dc.w make_art_tile($41A,0,0)
		dc.w   $200
		dc.b    8,   8,   7,   0
word_6902A:
		dc.w make_art_tile($41A,0,0)
		dc.w   $280
		dc.b    8, $10,  $C, $98
ObjDat3_69032:
		dc.l Map_BossExplosion
		dc.w make_art_tile($4D2,0,0)
		dc.w    $80
		dc.b   $C,  $C,   0, $97
ObjDat_AIZMiniboss_Flame:
		dc.l Map_AIZMinibossFlame
		dc.w make_art_tile($482,0,1)
		dc.w   $100
		dc.b  $10, $10,   0, $8B
ObjDat3_6904A:
		dc.l Map_AIZMinibossSmall
		dc.w make_art_tile($474,1,0)
		dc.w   $380
		dc.b  $10, $10,   0,   0
word_69056:
		dc.w   $200
		dc.b  $10, $14,   0,   0
ChildObjDat_6905C:
		dc.w 2-1
		dc.l loc_686BE
		dc.b    0, $20
		dc.l loc_6870A
		dc.b -$24,   8
ChildObjDat_6906A:
		dc.w 6-1
		dc.l loc_68DFA
		dc.b    0,   0
ChildObjDat_69072:
		dc.w 3-1
		dc.l loc_6872C
		dc.b    0,-$20
		dc.l loc_6872C
		dc.b    9,-$1C
		dc.l loc_6872C
		dc.b  $12,-$18
ChildObjDat_69086:
		dc.w 3-1
		dc.l loc_68C12
		dc.b    0,-$20
		dc.l loc_68C12
		dc.b    9,-$1C
		dc.l loc_68C12
		dc.b  $12,-$18
ChildObjDat_6909A:
		dc.w 2-1
		dc.l loc_6880A
		dc.b    0,   4
		dc.l loc_68844
		dc.b    0,   4
ChildObjDat_690A8:
		dc.w 2-1
		dc.l loc_6880A
		dc.b    0,   4
		dc.l loc_68C96
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
ChildObjDat_690D0:
		dc.w 1-1
		dc.l loc_68994
		dc.b    0,   0
ChildObjDat_690D8:
		dc.w 7-1
		dc.l loc_68D88
		dc.b    0,-$24
		dc.l loc_68D88
		dc.b    8,-$1C
		dc.l loc_68D88
		dc.b   -8,-$1C
		dc.l loc_68D88
		dc.b    4,-$14
		dc.l loc_68D88
		dc.b   -4,-$14
		dc.l loc_68D88
		dc.b    4,  -4
		dc.l loc_68D88
		dc.b   -4,  -4
ChildObjDat_69104:
		dc.w 1-1
		dc.l Obj_BossExplosionSpecial
		dc.b    0,   0
ChildObjDat_6910C:
		dc.w 4-1
		dc.l loc_68E98
		dc.b -$10,  -8
		dc.l loc_68E98
		dc.b   $C,-$10
		dc.l loc_68E98
		dc.b -$10, $14
		dc.l loc_68E98
		dc.b  $10,  $C
byte_69126:
		dc.b    1,   1,   2, $FC
		dc.b    7,   3,   4,   5, $F4
byte_6912F:
		dc.b    3,   5
		dc.b    4,   5
		dc.b    5, $17
		dc.b  $F4
byte_69136:
		dc.b    5, $17
		dc.b    5, $17
		dc.b    4,   5
		dc.b    3,   5
		dc.b  $F4
byte_6913F:
		dc.b    7,   1
		dc.b    7,   1
		dc.b    8,   1
		dc.b    9,   3
		dc.b   $A,   3
		dc.b   $B,   3
		dc.b  $F4
byte_6914C:
		dc.b    1,  $C,  $D, $FC
		dc.b    0,   0
		dc.b    0,   0
		dc.b    1,   1
		dc.b    2,   2
		dc.b    3,   3
		dc.b    4,   4
		dc.b    5,   4
		dc.b  $F4
byte_6915F:
		dc.b    0,   1
		dc.b    0,   1
		dc.b  $F4
byte_69164:
		dc.b    2,   1
		dc.b    2,   1
		dc.b    3,   2
		dc.b    4,   4
		dc.b    5,   1
		dc.b  $F4
byte_6916F:
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

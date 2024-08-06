Obj_SOZEndBoss:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	.Index(pc,d0.w),d1
		jsr	.Index(pc,d1.w)
		move.w	x_pos(a0),(Events_bg+$0C).w
		move.w	y_pos(a0),(Events_bg+$0E).w
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------
.Index:
		dc.w loc_7767C-.Index
		dc.w loc_776EA-.Index
		dc.w loc_77710-.Index
		dc.w loc_77772-.Index
		dc.w loc_77790-.Index
		dc.w loc_777CC-.Index
		dc.w loc_777F0-.Index
; ---------------------------------------------------------------------------

loc_7767C:
		lea	ObjDat_SOZEndBoss(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.b	#8,collision_property(a0)
		move.w	y_pos(a0),$3A(a0)
		move.w	#$C0,(_unkFA82).w
		lea	(ArtKosM_SOZEndBoss).l,a1
		move.w	#tiles_to_bytes($3A4),d2
		jsr	(Queue_Kos_Module).l
		moveq	#$6D,d0
		jsr	(Load_PLC).l
		lea	Pal_SOZEndBoss1(pc),a1
		jsr	(PalLoad_Line1).l
		lea	(Pal_SOZEndBoss2).l,a1
		lea	(Normal_palette_line_4).w,a2
		moveq	#bytesToLcnt($20),d6

loc_776C6:
		move.l	(a1)+,(a2)+
		dbf	d6,loc_776C6
		lea	ChildObjDat_782FA(pc),a2
		jsr	(CreateChild1_Normal).l
		lea	ChildObjDat_78320(pc),a2
		jsr	(CreateChild8_TreeListRepeated).l
		lea	ChildObjDat_78326(pc),a2
		jmp	(CreateChild8_TreeListRepeated).l
; ---------------------------------------------------------------------------

loc_776EA:
		lea	(Player_1).w,a1
		jsr	(Find_OtherObject).l
		cmpi.w	#$C0,d2
		bhs.s	locret_7770E
		move.b	#4,routine(a0)
		move.w	#60-1,$2E(a0)
		moveq	#signextendB(mus_FadeOut),d0
		jsr	(Play_Music).l

locret_7770E:
		rts
; ---------------------------------------------------------------------------

loc_77710:
		subq.w	#1,$2E(a0)
		bpl.w	locret_77AF6
		move.b	#6,routine(a0)
		moveq	#signextendB(mus_EndBoss),d0
		jsr	(Play_Music).l
		move.b	#mus_EndBoss,(Current_music+1).w

loc_7772C:
		lea	word_7775A(pc),a1
		cmpi.b	#2,(Player_1+character_id).w
		bne.s	loc_7773C
		lea	word_77766(pc),a1

loc_7773C:
		move.w	(a1)+,x_vel(a0)
		move.w	(a1)+,$3E(a0)
		move.w	(a1)+,$40(a0)
		move.w	(a1),$30(a0)
		move.w	(a1)+,$2E(a0)
		move.w	(a1)+,$32(a0)
		move.w	(a1)+,$46(a0)
		rts
; ---------------------------------------------------------------------------
word_7775A:
		dc.w   -$40,  $100,  -$80,   $3F,   $7F,   $1F
word_77766:
		dc.w   -$80,  $200, -$100,   $1F,   $3F,   $1F
; ---------------------------------------------------------------------------

loc_77772:
		jsr	(MoveSprite2).l
		bsr.w	sub_7808C
		subq.w	#1,$2E(a0)
		bpl.s	locret_7778E
		move.b	#8,routine(a0)
		move.w	$30(a0),$2E(a0)

locret_7778E:
		rts
; ---------------------------------------------------------------------------

loc_77790:
		bsr.w	sub_7806C
		jsr	(MoveSprite2).l
		bsr.w	sub_7808C
		move.w	$3C(a0),d0
		add.w	$40(a0),d0
		move.w	d0,$3C(a0)
		subq.w	#1,$2E(a0)
		bpl.s	locret_777CA
		move.b	#$A,routine(a0)
		move.w	$46(a0),$2E(a0)
		move.w	#$14,(Screen_shake_flag).w
		moveq	#signextendB(sfx_ThumpBoss),d0
		jsr	(Play_SFX).l

locret_777CA:
		rts
; ---------------------------------------------------------------------------

loc_777CC:
		bsr.w	sub_7806C
		subq.w	#1,$2E(a0)
		bpl.s	locret_777EE
		move.b	#8,routine(a0)
		bsr.w	sub_78038
		neg.b	$3E(a0)
		neg.w	$40(a0)
		move.w	$32(a0),$2E(a0)

locret_777EE:
		rts
; ---------------------------------------------------------------------------

loc_777F0:
		tst.w	(Events_bg+$0A).w
		beq.s	loc_777FA
		bra.w	loc_781E4
; ---------------------------------------------------------------------------

loc_777FA:
		move.b	$42(a0),routine(a0)
		clr.b	collision_flags(a0)
		moveq	#0,d0
		bra.w	sub_7825E
; ---------------------------------------------------------------------------

loc_7780A:
		move.l	#loc_77822,(a0)
		bset	#4,$38(a0)
		bset	#7,art_tile(a0)
		clr.w	x_vel(a0)
		rts
; ---------------------------------------------------------------------------

loc_77822:
		jsr	(MoveSprite_LightGravity).l
		cmpi.w	#$200,y_vel(a0)
		blt.s	loc_77842
		move.l	#loc_77848,(a0)
		bclr	#7,status(a0)
		bset	#0,render_flags(a0)

loc_77842:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_77848:
		addi.w	#-$40,y_vel(a0)
		jsr	(MoveSprite2).l
		cmpi.w	#-$100,y_vel(a0)
		bgt.s	loc_77894
		move.l	#loc_7789A,(a0)
		jsr	(Swing_Setup1).l
		jsr	(AllocateObject).l
		bne.s	loc_77882
		move.l	#Obj_EggCapsule,(a1)
		move.w	#$5360,x_pos(a1)
		move.w	#$720,y_pos(a1)

loc_77882:
		bclr	#4,$38(a0)
		lea	(Child1_MakeRoboShipFlame).l,a2
		jsr	(CreateChild1_Normal).l

loc_77894:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_7789A:
		move.w	(Camera_X_pos).w,(Camera_min_X_pos).w
		jsr	(Swing_UpAndDown).l
		subq.w	#1,y_pos(a0)
		move.w	x_vel(a0),d0
		addi.w	#$20,d0
		cmpi.w	#$400,d0
		bls.s	loc_778BC
		move.w	#$400,d0

loc_778BC:
		move.w	d0,x_vel(a0)
		jsr	(MoveSprite2).l
		move.w	(Camera_X_pos).w,d0
		addi.w	#$1A0,d0
		cmp.w	x_pos(a0),d0
		blo.s	loc_778DA
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_778DA:
		move.l	#loc_778F2,(a0)
		st	(_unkFAA8).w
		ori.b	#$30,$38(a0)
		bclr	#7,render_flags(a0)
		rts
; ---------------------------------------------------------------------------

loc_778F2:
		move.w	(Camera_X_pos).w,(Camera_min_X_pos).w
		tst.b	(_unkFAA8).w
		bne.w	locret_77AF6
		move.l	#loc_77966,(a0)
		jsr	(Restore_PlayerControl).l
		jsr	(Restore_LevelMusic).l
		clr.w	(Ctrl_1_logical).w
		st	(Ctrl_1_locked).w
		clr.w	$2E(a0)
		lea	(Player_2).w,a1
		jsr	(Restore_PlayerControl2).l
		jsr	(AllocateObject).l
		bne.s	loc_77936
		move.l	#loc_77A6E,(a1)

loc_77936:
		jsr	(AllocateObject).l
		bne.s	loc_77944
		move.l	#loc_863C0,(a1)

loc_77944:
		move.w	#-$100,(Camera_min_Y_pos).w
		move.w	#$800,(Camera_target_max_Y_pos).w
		move.w	#$5440,(Camera_stored_max_X_pos).w
		jsr	(AllocateObject).l
		bne.s	locret_77964
		move.l	#Obj_IncLevEndXGradual,(a1)

locret_77964:
		rts
; ---------------------------------------------------------------------------

loc_77966:
		cmpi.w	#$700,(Camera_target_max_Y_pos).w
		blo.s	loc_77974
		move.w	#$800,(Camera_max_Y_pos).w

loc_77974:
		lea	(Player_1).w,a1
		cmpi.w	#$5468,x_pos(a1)
		bhs.s	loc_77986
		jmp	(loc_86334).l
; ---------------------------------------------------------------------------

loc_77986:
		move.w	x_pos(a1),x_pos(a0)
		move.w	y_pos(a1),y_pos(a0)
		move.w	x_vel(a1),x_vel(a0)
		clr.w	y_vel(a0)
		cmpi.b	#2,character_id(a1)
		beq.s	loc_779B8
		move.l	#loc_779C0,(a0)
		move.b	#$81,object_control(a1)
		move.b	#$1A,anim(a1)
		rts
; ---------------------------------------------------------------------------

loc_779B8:
		move.l	#loc_77A3E,(a0)
		rts
; ---------------------------------------------------------------------------

loc_779C0:
		jsr	(MoveSprite2).l
		lea	(Player_1).w,a1
		move.w	y_pos(a0),y_pos(a1)
		move.w	x_pos(a0),d0
		move.w	#$54C0,d1
		cmp.w	d1,d0
		blo.s	loc_779FC
		move.l	#loc_77A02,(a0)
		bset	#0,(_unkFAB8).w
		clr.w	x_vel(a0)
		clr.w	y_vel(a0)
		move.w	d1,d0
		st	(Fast_V_scroll_flag).w
		move.w	#$7F,$2E(a0)

loc_779FC:
		move.w	d0,x_pos(a1)
		rts
; ---------------------------------------------------------------------------

loc_77A02:
		cmpi.w	#$1000,y_vel(a0)
		blo.s	loc_77A10
		move.w	#$1000,y_vel(a0)

loc_77A10:
		jsr	(MoveSprite).l
		lea	(Player_1).w,a1
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		subq.w	#1,$2E(a0)
		bmi.s	loc_77A2E
		rts
; ---------------------------------------------------------------------------

loc_77A2E:
		move.w	#$900,d0
		jsr	(StartNewLevel).l
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_77A3E:
		jsr	(MoveSprite2).l
		lea	(Player_1).w,a1
		move.w	y_pos(a0),y_pos(a1)
		move.w	x_pos(a0),d0
		move.w	d0,x_pos(a1)
		cmpi.w	#$5560,d0
		bhs.s	loc_77A5E
		rts
; ---------------------------------------------------------------------------

loc_77A5E:
		move.w	#$900,d0
		jsr	(StartNewLevel).l
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_77A6E:
		btst	#0,(_unkFAB8).w
		beq.w	locret_77AF6
		move.l	#loc_77A98,(a0)
		lea	(Player_2).w,a1
		bclr	#7,art_tile(a1)
		move.b	#$81,object_control(a1)
		move.b	#$1A,anim(a1)
		clr.b	(Ctrl_2_locked).w

loc_77A98:
		lea	(Player_1).w,a1
		lea	(Player_2).w,a2
		move.w	x_pos(a1),x_pos(a2)
		move.w	y_pos(a1),d0
		subi.w	#$20,d0
		move.w	d0,y_pos(a2)
		rts
; ---------------------------------------------------------------------------

loc_77AB4:
		addq.b	#6,subtype(a0)

loc_77AB8:
		move.l	#Map_SOZEndBoss,mappings(a0)
		move.w	#make_art_tile($3A4,3,1),art_tile(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		move.w	off_77AD4(pc,d0.w),d0
		jmp	off_77AD4(pc,d0.w)
; ---------------------------------------------------------------------------
off_77AD4:
		dc.w loc_77AE0-off_77AD4
		dc.w loc_77B6C-off_77AD4
		dc.w loc_77C08-off_77AD4
		dc.w loc_77AF8-off_77AD4
		dc.w loc_77B7E-off_77AD4
		dc.w loc_77C1A-off_77AD4
; ---------------------------------------------------------------------------

loc_77AE0:
		lea	word_782AE(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#loc_77B16,(a0)
		move.b	#$28,child_dy(a0)

locret_77AF6:
		rts
; ---------------------------------------------------------------------------

loc_77AF8:
		lea	word_782B4(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#loc_77B50,(a0)
		move.b	#$28,child_dy(a0)
		bclr	#7,art_tile(a0)
		rts
; ---------------------------------------------------------------------------

loc_77B16:
		movea.w	parent3(a0),a1
		move.b	$3C(a1),d0
		asr.b	#2,d0
		move.b	d0,child_dx(a0)
		move.w	x_pos(a0),-(sp)
		jsr	(Refresh_ChildPosition).l
		moveq	#$1F,d1
		moveq	#$14,d2
		moveq	#$14,d3
		move.w	(sp)+,d4
		jsr	(SolidObjectFull).l
		movea.w	parent3(a0),a1
		btst	#4,$38(a1)
		bne.w	loc_77C7A
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_77B50:
		jsr	(Refresh_ChildPosition).l
		movea.w	parent3(a0),a1
		btst	#4,$38(a1)
		beq.w	locret_77AF6
		moveq	#0,d0
		jmp	(loc_849D8).l
; ---------------------------------------------------------------------------

loc_77B6C:
		lea	word_782BA(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#loc_77B9A,(a0)
		rts
; ---------------------------------------------------------------------------

loc_77B7E:
		lea	word_782C0(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#loc_77BE0,(a0)
		bclr	#7,art_tile(a0)
		st	$3A(a0)
		rts
; ---------------------------------------------------------------------------

loc_77B9A:
		move.w	x_pos(a0),-(sp)
		movea.w	$44(a0),a1
		move.b	$3C(a1),d0
		tst.b	$3A(a0)
		beq.s	loc_77BAE
		neg.b	d0

loc_77BAE:
		move.b	d0,$3C(a0)
		lea	(AngleLookup_3).l,a2
		jsr	(MoveSprite_AtAngleLookup).l
		moveq	#$1B,d1
		moveq	#$10,d2
		moveq	#$10,d3
		move.w	(sp)+,d4
		jsr	(SolidObjectFull).l
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.w	loc_77C7A
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_77BE0:
		movea.w	$44(a0),a1
		move.b	$3C(a1),d0
		tst.b	$3A(a0)
		beq.s	loc_77BF0
		neg.b	d0

loc_77BF0:
		move.b	d0,$3C(a0)
		lea	(AngleLookup_3).l,a2
		jsr	(MoveSprite_AtAngleLookup).l
		moveq	#0,d0
		jmp	(Child_Draw_Sprite_FlickerMove).l
; ---------------------------------------------------------------------------

loc_77C08:
		lea	word_782C6(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#loc_77C32,(a0)
		rts
; ---------------------------------------------------------------------------

loc_77C1A:
		lea	word_782CC(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#loc_77C88,(a0)
		bclr	#7,art_tile(a0)
		rts
; ---------------------------------------------------------------------------

loc_77C32:
		move.w	x_pos(a0),-(sp)
		movea.w	$44(a0),a1
		move.b	$3C(a1),$3C(a0)
		lea	(AngleLookup_2).l,a2
		jsr	(MoveSprite_AtAngleLookup).l
		subi.w	#$1C,x_pos(a0)
		subq.w	#4,y_pos(a0)
		moveq	#$2B,d1
		moveq	#$14,d2
		moveq	#$C,d3
		move.w	(sp)+,d4
		jsr	(SolidObjectFull).l
		bsr.w	sub_7815A
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.s	loc_77C7A
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_77C7A:
		jsr	(Displace_PlayerOffObject).l
		moveq	#0,d0
		jmp	(loc_849D8).l
; ---------------------------------------------------------------------------

loc_77C88:
		movea.w	$44(a0),a1
		move.b	$3C(a1),d0
		neg.b	d0
		move.b	d0,$3C(a0)
		lea	(AngleLookup_2).l,a2
		jsr	(MoveSprite_AtAngleLookup).l
		subi.w	#$1C,x_pos(a0)
		subq.w	#4,y_pos(a0)
		moveq	#0,d0
		jmp	(Child_Draw_Sprite_FlickerMove).l
; ---------------------------------------------------------------------------

loc_77CB4:
		move.b	#$20,width_pixels(a0)
		move.b	#$50,height_pixels(a0)
		move.l	#loc_77CC6,(a0)

loc_77CC6:
		move.w	x_pos(a0),-(sp)
		movea.w	parent3(a0),a1
		move.w	x_pos(a1),x_pos(a0)
		move.w	y_pos(a1),d0
		subi.w	#$14,d0
		move.w	d0,y_pos(a0)
		moveq	#$2B,d1
		moveq	#$28,d2
		moveq	#$28,d3
		move.w	(sp)+,d4
		jsr	(SolidObjectFull2).l
		bsr.w	sub_780AC

loc_77CF2:
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.s	loc_77D00
		rts
; ---------------------------------------------------------------------------

loc_77D00:
		jsr	(Displace_PlayerOffObject).l
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

loc_77D0C:
		tst.w	(Events_bg+$0A).w
		bne.s	loc_77D18
		move.l	#loc_77CC6,(a0)

loc_77D18:
		bra.s	loc_77CF2
; ---------------------------------------------------------------------------

loc_77D1A:
		move.b	#$30,width_pixels(a0)
		move.b	#$30,height_pixels(a0)
		move.l	#loc_77D2C,(a0)

loc_77D2C:
		tst.w	(Events_bg+$0A).w
		bne.s	loc_77D60
		move.w	x_pos(a0),-(sp)
		movea.w	parent3(a0),a1
		move.w	x_pos(a1),x_pos(a0)
		move.w	y_pos(a1),d0
		addi.w	#$44,d0
		move.w	d0,y_pos(a0)
		moveq	#$3B,d1
		moveq	#$30,d2
		moveq	#$30,d3
		move.w	(sp)+,d4
		jsr	(SolidObjectFull2).l
		bsr.w	sub_78120
		bra.s	loc_77CF2
; ---------------------------------------------------------------------------

loc_77D60:
		move.l	#loc_77D6C,(a0)
		jsr	(Displace_PlayerOffObject).l

loc_77D6C:
		tst.w	(Events_bg+$0A).w
		bne.w	loc_77CF2
		move.l	#loc_77D2C,(a0)
		jsr	(Displace_PlayerOffObject).l
		bra.s	loc_77D2C
; ---------------------------------------------------------------------------

loc_77D82:
		move.b	#$20,width_pixels(a0)
		move.b	#$FF,height_pixels(a0)
		move.l	#loc_77D94,(a0)

loc_77D94:
		movea.w	parent3(a0),a1
		move.w	x_pos(a1),d0
		addi.w	#$20,d0
		move.w	d0,x_pos(a0)
		move.w	y_pos(a1),y_pos(a0)
		moveq	#$2B,d1
		move.w	#$200,d2
		move.w	#$200,d3
		move.w	x_pos(a0),d4
		jsr	(SolidObjectFull2).l
		movea.w	parent3(a0),a1
		btst	#4,$38(a1)
		bne.s	loc_77DCC
		rts
; ---------------------------------------------------------------------------

loc_77DCC:
		jsr	(Displace_PlayerOffObject).l
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

loc_77DD8:
		lea	ObjDat3_78296(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_77DEA,(a0)
		rts
; ---------------------------------------------------------------------------

loc_77DEA:
		jsr	(Refresh_ChildPosition).l
		moveq	#0,d0
		jmp	(Child_Draw_Sprite2_FlickerMove).l
; ---------------------------------------------------------------------------

loc_77DF8:
		lea	ObjDat3_782D2(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_77E16,(a0)
		lea	ChildObjDat_78334(pc),a2
		jsr	(CreateChild6_Simple).l
		move.w	a1,$44(a0)

loc_77E16:
		movea.w	$44(a0),a1
		btst	#4,$38(a1)
		bne.s	loc_77E56

loc_77E22:
		jsr	(Refresh_ChildPosition).l
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.s	loc_77E4A
		tst.w	(Events_bg+$0A).w
		bne.s	loc_77E4A
		btst	#0,(V_int_run_count+3).w
		bne.w	locret_77AF6
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_77E4A:
		bset	#7,status(a0)
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_77E56:
		move.l	#loc_77E74,(a0)
		move.w	#8,$2E(a0)
		moveq	#signextendB(sfx_Laser),d0
		jsr	(Play_SFX).l
		lea	ChildObjDat_7833A(pc),a2
		jsr	(CreateChild1_Normal).l

loc_77E74:
		subq.w	#1,$2E(a0)
		bmi.s	loc_77E4A
		bra.s	loc_77E22
; ---------------------------------------------------------------------------

loc_77E7C:
		lea	word_782DE(pc),a1
		jsr	(SetUp_ObjAttributes2).l
		move.l	#loc_77E90,(a0)
		bsr.w	sub_7819A

loc_77E90:
		subq.w	#1,$2E(a0)
		bmi.s	loc_77EAA
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.s	loc_77E4A
		tst.w	(Events_bg+$0A).w
		bne.s	loc_77E4A
		rts
; ---------------------------------------------------------------------------

loc_77EAA:
		move.l	#loc_77EB8,(a0)
		move.l	#Go_Delete_Sprite_2,$34(a0)

loc_77EB8:
		lea	byte_78348(pc),a1
		jsr	(Animate_RawNoSST).l
		move.w	x_vel(a0),d0
		addi.w	#$10,d0
		move.w	d0,x_vel(a0)
		add.w	d0,$3A(a0)
		btst	#2,$38(a0)
		bne.s	loc_77F02
		moveq	#$10,d0
		move.w	$3C(a0),d1
		bmi.s	loc_77EE4
		neg.w	d0

loc_77EE4:
		move.w	y_vel(a0),d2
		add.w	d0,d2
		move.w	d2,y_vel(a0)
		move.w	d1,d3
		add.w	d2,d1
		eor.w	d1,d3
		bpl.s	loc_77EFE
		moveq	#0,d1
		bset	#2,$38(a0)

loc_77EFE:
		move.w	d1,$3C(a0)

loc_77F02:
		movea.w	parent3(a0),a1
		move.w	x_pos(a1),d0
		move.w	y_pos(a1),d1
		move.b	$3A(a0),d2
		ext.w	d2
		add.w	d2,d0
		move.w	d0,x_pos(a0)
		move.b	$3C(a0),d3
		ext.w	d3
		add.w	d3,d1
		move.w	d1,y_pos(a0)
		btst	#7,status(a1)
		bne.w	loc_77E4A
		tst.w	(Events_bg+$0A).w
		bne.w	loc_77E4A
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_77F3E:
		lea	word_782E6(pc),a1
		jsr	(SetUp_ObjAttributes2).l
		move.l	#loc_77F94,(a0)
		move.w	#7,$2E(a0)
		lea	(Player_1).w,a1
		move.w	x_pos(a0),d0
		sub.w	x_pos(a1),d0
		bpl.s	loc_77F64
		neg.w	d0

loc_77F64:
		cmpi.w	#$80,d0
		bhs.s	loc_77F7A
		move.w	#-$400,x_vel(a0)
		move.w	#$400,y_vel(a0)
		bra.w	locret_77F92
; ---------------------------------------------------------------------------

loc_77F7A:
		move.b	#$F,mapping_frame(a0)
		move.w	#(8<<8)|((-8)&$FF),child_dx(a0)	; and child_dy
		move.w	#-$400,x_vel(a0)
		move.w	#$300,y_vel(a0)

locret_77F92:
		rts
; ---------------------------------------------------------------------------

loc_77F94:
		subq.w	#1,$2E(a0)
		bmi.s	loc_77FB6
		move.b	x_vel(a0),d0
		add.b	d0,child_dx(a0)
		move.b	y_vel(a0),d0
		add.b	d0,child_dy(a0)
		jsr	(Refresh_ChildPosition).l
		jmp	(Child_Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_77FB6:
		move.l	#loc_77FBC,(a0)

loc_77FBC:
		jsr	(MoveSprite2).l
		jsr	(Add_SpriteToCollisionResponseList).l
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------

loc_77FCE:
		lea	ObjDat3_782EE(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_77FEC,(a0)
		move.w	#8,$2E(a0)
		move.l	#Go_Delete_Sprite,$34(a0)

loc_77FEC:
		st	(Spritemask_flag).w
		jsr	(Refresh_ChildPosition).l
		jmp	(Wait_Draw).l
; ---------------------------------------------------------------------------

loc_77FFC:
		lea	ObjDat3_782A2(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_78018,(a0)
		move.w	#$5260,x_pos(a0)
		move.w	#$710,y_pos(a0)

loc_78018:
		movea.w	parent3(a0),a1
		cmpi.w	#$5180,x_pos(a0)
		blo.s	loc_78032
		btst	#7,status(a1)
		bne.s	loc_78032
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_78032:
		jmp	(Delete_Current_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_78038:
		tst.b	$3C(a0)
		bpl.s	locret_7805E
		tst.w	x_vel(a0)
		bpl.s	loc_78054
		cmpi.w	#$4E80,x_pos(a0)
		bhs.s	locret_7805E
		lea	word_78060(pc),a1
		bra.w	loc_7773C
; ---------------------------------------------------------------------------

loc_78054:
		cmpi.w	#$5210,x_pos(a0)
		bhs.w	loc_7772C

locret_7805E:
		rts
; End of function sub_78038

; ---------------------------------------------------------------------------
word_78060:
		dc.w   $400,  $800, -$400,   $1F,    $F,     7

; =============== S U B R O U T I N E =======================================


sub_7806C:
		subq.w	#1,(_unkFA82).w
		bpl.w	locret_77AF6
		move.w	#$200,(_unkFA82).w
		moveq	#signextendB(sfx_Charging),d0
		jsr	(Play_SFX).l
		lea	ChildObjDat_7832C(pc),a2
		jmp	(CreateChild1_Normal).l
; End of function sub_7806C


; =============== S U B R O U T I N E =======================================


sub_7808C:
		move.b	angle(a0),d0
		sub.b	$3E(a0),d0
		move.b	d0,angle(a0)
		jsr	(GetSineCosine).l
		asr.w	#4,d0
		move.w	$3A(a0),d1
		add.w	d0,d1
		move.w	d1,y_pos(a0)
		rts
; End of function sub_7808C


; =============== S U B R O U T I N E =======================================


sub_780AC:
		swap	d6
		moveq	#0,d0
		lea	(Player_1).w,a1
		bsr.w	sub_780BE
		moveq	#1,d0
		lea	(Player_2).w,a1
; End of function sub_780AC


; =============== S U B R O U T I N E =======================================


sub_780BE:
		btst	d0,d6
		beq.s	locret_78118
		move.w	x_pos(a0),d0
		sub.w	x_pos(a1),d0
		bcs.s	loc_7811A
		cmpi.b	#2,anim(a1)
		beq.s	loc_780E4
		cmpi.b	#2,character_id(a1)
		bne.s	loc_780E4
		cmpi.b	#1,double_jump_flag(a1)
		bne.s	locret_78118

loc_780E4:
		move.w	y_pos(a1),(Events_bg+$0A).w
		move.l	#loc_77D0C,(a0)
		move.w	#-$400,x_vel(a1)
		move.w	#-$300,y_vel(a1)
		movea.w	parent3(a0),a2
		move.b	routine(a2),$42(a2)
		move.b	#$C,routine(a2)
		move.b	#$F,collision_flags(a2)
		jsr	(Displace_PlayerOffObject).l

locret_78118:
		rts
; ---------------------------------------------------------------------------

loc_7811A:
		jmp	(sub_24280).l
; End of function sub_780BE


; =============== S U B R O U T I N E =======================================


sub_78120:
		swap	d6
		moveq	#0,d0
		moveq	#p1_standing_bit,d1
		lea	(Player_1).w,a1
		bsr.w	sub_78136
		moveq	#1,d0
		moveq	#p2_standing_bit,d1
		lea	(Player_2).w,a1
; End of function sub_78120


; =============== S U B R O U T I N E =======================================


sub_78136:
		btst	d0,d6
		bne.s	loc_78140
		bclr	d1,status(a0)
		beq.s	locret_78158

loc_78140:
		bclr	#Status_OnObj,status(a1)
		tst.b	invulnerability_timer(a1)
		bne.s	locret_78158
		andi.b	#$9F,status(a0)
		jsr	(sub_24280).l

locret_78158:
		rts
; End of function sub_78136


; =============== S U B R O U T I N E =======================================


sub_7815A:
		movea.w	$44(a0),a1
		btst	#7,status(a1)
		bne.s	locret_78198
		swap	d6
		moveq	#0,d0
		lea	(Player_1).w,a1
		bsr.w	sub_78178
		moveq	#1,d0
		lea	(Player_2).w,a1
; End of function sub_7815A


; =============== S U B R O U T I N E =======================================


sub_78178:
		btst	d0,d6
		beq.s	locret_78198
		tst.b	$34(a1)
		bne.s	locret_78198
		move.w	x_pos(a0),d0
		sub.w	x_pos(a1),d0
		bcs.s	locret_78198
		andi.b	#$9F,status(a0)
		jsr	(sub_24280).l

locret_78198:
		rts
; End of function sub_78178


; =============== S U B R O U T I N E =======================================


sub_7819A:
		moveq	#0,d0
		move.b	subtype(a0),d0
		lea	byte_781BC(pc,d0.w),a1
		move.b	(a1)+,$3A(a0)
		move.b	(a1)+,$3C(a0)
		move.w	byte_781BC(pc,d0.w),child_dx(a0)	; and child_dy
		addq.w	#2,d0
		lsl.w	#2,d0
		move.w	d0,$2E(a0)
		rts
; End of function sub_7819A

; ---------------------------------------------------------------------------
byte_781BC:
		dc.b -$16,   2
		dc.b -$10,  -8
		dc.b -$14,   9
		dc.b -$1B,  -4
		dc.b  -$D,   8
		dc.b -$16,  -5
		dc.b -$1F,   4
		dc.b -$12,  $D
		dc.b -$18,  -8
		dc.b -$14,  -1
		dc.b -$20,  -2
		dc.b -$1C,  $C
		dc.b -$1A,  -1
		dc.b -$24,   9
		dc.b -$1F, -$A
		dc.b -$1A,   4
		dc.b -$14,   2
		dc.b -$16,   6
		dc.b -$18, -$C
		dc.b -$26,  $C
		even
; ---------------------------------------------------------------------------

loc_781E4:
		tst.b	collision_flags(a0)
		bne.s	locret_7822E
		tst.b	collision_property(a0)
		beq.s	loc_78230
		tst.b	$20(a0)
		bne.s	loc_7820A
		bset	#6,status(a0)
		move.b	#$20,$20(a0)
		moveq	#signextendB(sfx_BossHit),d0
		jsr	(Play_SFX).l

loc_7820A:
		moveq	#0,d0
		btst	#0,$20(a0)
		bne.s	loc_78218
		addi.w	#2*5,d0

loc_78218:
		bsr.w	sub_7825E
		subq.b	#1,$20(a0)
		bne.s	locret_7822E
		bclr	#6,status(a0)
		move.b	$25(a0),collision_flags(a0)

locret_7822E:
		rts
; ---------------------------------------------------------------------------

loc_78230:
		move.l	#Wait_FadeToLevelMusic,(a0)
		move.l	#loc_7780A,$34(a0)
		move.w	#$55,(Events_fg_5).w
		lea	(Child6_CreateBossExplosion).l,a2
		jsr	(CreateChild6_Simple).l
		move.w	(Camera_X_pos).w,d0
		move.w	d0,(Camera_min_X_pos).w
		jmp	(BossDefeated_StopTimer).l

; =============== S U B R O U T I N E =======================================


sub_7825E:
		lea	word_7826C(pc),a1
		lea	word_78276(pc,d0.w),a2
		; Bug: this should go to CopyWordData_5
		jmp	(CopyWordData_3).l
; End of function sub_7825E

; ---------------------------------------------------------------------------
word_7826C:
		dc.w Normal_palette_line_4+$0C, Normal_palette_line_4+$0E, Normal_palette_line_4+$10
		dc.w Normal_palette_line_4+$12, Normal_palette_line_4+$14
word_78276:
		dc.w    $6E,  $24C,   $28,     4,     2
		dc.w   $AAA,  $CCC,  $CCC,  $EEE,  $EEE
ObjDat_SOZEndBoss:
		dc.l Map_RobotnikShip
		dc.w make_art_tile($52E,0,0)
		dc.w   $300
		dc.b  $20, $20,  $A,   0
ObjDat3_78296:
		dc.l Map_SOZEndBoss
		dc.w make_art_tile($3A4,1,0)
		dc.w   $280
		dc.b  $18, $1C,   6,   0
ObjDat3_782A2:
		dc.l Map_SOZEndBossBody
		dc.w make_art_tile($001,0,0)
		dc.w      0
		dc.b  $10, $30,   0,   0
word_782AE:
		dc.w   $200
		dc.b  $18, $18,   0,   0
word_782B4:
		dc.w   $300
		dc.b  $18, $18,   3,   0
word_782BA:
		dc.w   $180
		dc.b  $14, $14,   1,   0
word_782C0:
		dc.w   $300
		dc.b  $14, $14,   4,   0
word_782C6:
		dc.w   $100
		dc.b  $28, $14,   2,   0
word_782CC:
		dc.w   $300
		dc.b  $28, $14,   5,   0
ObjDat3_782D2:
		dc.l Map_SOZEndBoss
		dc.w make_art_tile($3A4,1,1)
		dc.w   $180
		dc.b    8,   8,  $D,   0
word_782DE:
		dc.w make_art_tile($3A4,1,0)
		dc.w   $200
		dc.b    4,   4,  $A,   0
word_782E6:
		dc.w make_art_tile($3A4,1,0)
		dc.w   $300
		dc.b  $14, $14,  $E, $98
ObjDat3_782EE:
		dc.l Map_SpriteMask
		dc.w make_art_tile($000,0,0)
		dc.w   $280
		dc.b  $20, $20,   4,   0
ChildObjDat_782FA:
		dc.w 6-1
		dc.l loc_77CB4
		dc.b    0,-$14
		dc.l loc_77D1A
		dc.b    0, $40
		dc.l loc_77D82
		dc.b  $20,   0
		dc.l loc_77FFC
		dc.b    0,   0
		dc.l loc_77DD8
		dc.b    0, $24
		dc.l Obj_RobotnikHead4
		dc.b    0,-$1C
ChildObjDat_78320:
		dc.w 3-1
		dc.l loc_77AB8
ChildObjDat_78326:
		dc.w 3-1
		dc.l loc_77AB4
ChildObjDat_7832C:
		dc.w 1-1
		dc.l loc_77DF8
		dc.b -$18,-$2E
ChildObjDat_78334:
		dc.w $14-1
		dc.l loc_77E7C
ChildObjDat_7833A:
		dc.w 2-1
		dc.l loc_77FCE
		dc.b    0,-$14
		dc.l loc_77F3E
		dc.b    4, -$A
byte_78348:
		dc.b    7,  $A,  $A,  $B,  $C, $F4
		even
Map_SOZEndBoss:
		include "Levels/SOZ/Misc Object Data/Map - End Boss.asm"
Map_SOZEndBossBody:
		include "Levels/SOZ/Misc Object Data/Map - End Boss Body.asm"
Pal_SOZEndBoss1:
		binclude "Levels/SOZ/Palettes/End Boss 1.bin"
		even
Pal_SOZEndBoss2:
		binclude "Levels/SOZ/Palettes/End Boss 2.bin"
		even
; ---------------------------------------------------------------------------

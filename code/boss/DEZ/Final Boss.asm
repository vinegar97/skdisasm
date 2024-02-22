Obj_DEZ3_Boss:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	DEZ3_Boss_Index(pc,d0.w),d1
		jsr	DEZ3_Boss_Index(pc,d1.w)
		move.w	x_pos(a0),(Events_bg+$02).w
		move.w	y_pos(a0),(Events_bg+$04).w
		rts
; ---------------------------------------------------------------------------
DEZ3_Boss_Index:
		dc.w loc_7FD9E-DEZ3_Boss_Index
		dc.w loc_7FE2C-DEZ3_Boss_Index
		dc.w loc_7FE74-DEZ3_Boss_Index
		dc.w loc_7FE96-DEZ3_Boss_Index
		dc.w loc_7FEE2-DEZ3_Boss_Index
		dc.w loc_7FEF6-DEZ3_Boss_Index
		dc.w sub_7FF3E-DEZ3_Boss_Index
		dc.w loc_7FFD2-DEZ3_Boss_Index
		dc.w loc_8001C-DEZ3_Boss_Index
		dc.w loc_80058-DEZ3_Boss_Index
		dc.w loc_80082-DEZ3_Boss_Index
		dc.w loc_800DE-DEZ3_Boss_Index
		dc.w loc_800EE-DEZ3_Boss_Index
; ---------------------------------------------------------------------------

loc_7FD9E:
		move.b	#2,routine(a0)
		bset	#2,render_flags(a0)
		move.w	a0,(_unkFAA4).w
		clr.l	(_unkFA84).w
		lea	(ArtKosM_DEZFinalBossMisc).l,a1
		move.w	#tiles_to_bytes($38F),d2
		jsr	(Queue_Kos_Module).l
		jsr	(AllocateObject).l
		bne.s	loc_7FDD0
		move.l	#loc_80DE0,(a1)

loc_7FDD0:
		jsr	(AllocateObject).l
		bne.s	loc_7FDE2
		move.l	#loc_80D72,(a1)
		move.w	a0,parent3(a1)

loc_7FDE2:
		lea	(Player_1).w,a1
		move.w	#$30,x_pos(a1)
		move.w	#$CD,y_pos(a1)
		bsr.w	sub_7FE06
		lea	(Player_2).w,a1
		move.w	#$10,x_pos(a1)
		move.w	#$CD,y_pos(a1)

; =============== S U B R O U T I N E =======================================


sub_7FE06:
		move.b	#$81,object_control(a1)
		move.b	#0,anim(a1)
		move.w	#$600,x_vel(a1)
		move.w	#$600,ground_vel(a1)
		cmpi.b	#1,character_id(a1)
		bne.s	locret_7FE2A
		addq.w	#4,y_pos(a1)

locret_7FE2A:
		rts
; End of function sub_7FE06

; ---------------------------------------------------------------------------

loc_7FE2C:
		bsr.w	sub_7FE5C
		move.w	(Camera_X_pos).w,d1
		addi.w	#$98,d1
		cmp.w	d1,d0
		blo.s	locret_7FE5A
		move.b	#4,routine(a0)
		clr.b	(Scroll_lock).w
		jsr	(AllocateObject).l
		bne.s	locret_7FE5A
		move.l	#Obj_Song_Fade_Transition,(a1)
		move.b	#mus_FinalBoss,subtype(a1)

locret_7FE5A:
		rts

; =============== S U B R O U T I N E =======================================


sub_7FE5C:
		lea	(Player_2).w,a1
		bsr.w	sub_7FE68
		lea	(Player_1).w,a1
; End of function sub_7FE5C


; =============== S U B R O U T I N E =======================================


sub_7FE68:
		move.w	x_pos(a1),d0
		addq.w	#6,d0
		move.w	d0,x_pos(a1)
		rts
; End of function sub_7FE68

; ---------------------------------------------------------------------------

loc_7FE74:
		bsr.s	sub_7FE5C
		cmpi.w	#$360,d0
		blo.s	locret_7FE94
		move.b	#6,routine(a0)
		bsr.w	sub_7FE8A
		lea	(Player_2).w,a1

; =============== S U B R O U T I N E =======================================


sub_7FE8A:
		jsr	Stop_Object(pc)
		move.b	#5,anim(a1)

locret_7FE94:
		rts
; End of function sub_7FE8A

; ---------------------------------------------------------------------------

loc_7FE96:
		btst	#1,(_unkFAB8).w
		beq.s	locret_7FEE0
		move.b	#8,routine(a0)
		move.w	#$BF,$2E(a0)
		move.w	#-$80,y_vel(a0)
		clr.b	(Player_1+object_control).w
		clr.b	(Player_2+object_control).w
		jsr	(AllocateObject).l
		bne.s	loc_7FEC6
		move.l	#loc_8642E,(a1)

loc_7FEC6:
		lea	(PLC_BossExplosion).l,a1
		jsr	(Load_PLC_Raw).l
		jsr	(AllocateObject).l
		bne.s	locret_7FEE0
		move.l	#loc_810A0,(a1)

locret_7FEE0:
		rts
; ---------------------------------------------------------------------------

loc_7FEE2:
		jsr	(MoveSprite2).l
		subq.w	#1,$2E(a0)
		bpl.s	locret_7FEF4
		move.b	#$A,routine(a0)

locret_7FEF4:
		rts
; ---------------------------------------------------------------------------

loc_7FEF6:
		btst	#2,(_unkFAB8).w
		beq.s	locret_7FF3C
		move.b	#$C,routine(a0)
		move.w	y_pos(a0),$3A(a0)
		move.w	#1,$40(a0)
		jsr	(AllocateObject).l
		bne.s	loc_7FF22
		move.l	#loc_804F0,(a1)
		move.w	a0,parent3(a1)

loc_7FF22:
		jsr	(AllocateObject).l
		bne.s	loc_7FF34
		move.l	#loc_806DA,(a1)
		move.w	a0,parent3(a1)

loc_7FF34:
		lea	ChildObjDat_81310(pc),a2
		jsr	CreateChild6_Simple(pc)

locret_7FF3C:
		rts

; =============== S U B R O U T I N E =======================================


sub_7FF3E:
		move.w	$40(a0),d0
		add.w	d0,x_pos(a0)
		move.b	angle(a0),d0
		addq.b	#2,d0
		andi.b	#$7F,d0
		move.b	d0,angle(a0)
		beq.s	loc_7FF6A
		jsr	(GetSineCosine).l
		asr.w	#4,d0
		move.w	$3A(a0),d1
		sub.w	d0,d1
		move.w	d1,y_pos(a0)
		rts
; ---------------------------------------------------------------------------

loc_7FF6A:
		move.b	#$E,routine(a0)
		move.w	#$1F,$2E(a0)
		move.w	#$14,(Screen_shake_flag).w
		moveq	#signextendB(sfx_ThumpBoss),d0
		jsr	(Play_SFX).l
		moveq	#0,d0
		move.b	$30(a0),d0
		jmp	loc_7FF8E(pc,d0.w)
; End of function sub_7FF3E

; ---------------------------------------------------------------------------

loc_7FF8E:
		bra.w	loc_7FF9A
; ---------------------------------------------------------------------------
		bra.w	loc_7FFB2
; ---------------------------------------------------------------------------
		bra.w	loc_7FFBC
; ---------------------------------------------------------------------------

loc_7FF9A:
		move.l	#loc_7FFD8,$34(a0)
		cmpi.w	#$540,x_pos(a0)
		blo.s	locret_7FFD0
		move.b	#4,$30(a0)
		rts
; ---------------------------------------------------------------------------

loc_7FFB2:
		move.l	#loc_8000E,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_7FFBC:
		move.b	#$18,routine(a0)
		move.w	#$F,$2E(a0)
		move.l	#loc_800D0,$34(a0)

locret_7FFD0:
		rts
; ---------------------------------------------------------------------------

loc_7FFD2:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_7FFD8:
		move.b	#$C,routine(a0)
		moveq	#1,d2
		move.w	(Player_1+x_pos).w,d0
		cmpi.w	#$610,d0
		bhs.s	loc_7FFFA
		move.w	x_pos(a0),d1
		subi.w	#$80,d1
		cmp.w	d1,d0
		bhs.s	loc_80008
		bra.w	loc_80006
; ---------------------------------------------------------------------------

loc_7FFFA:
		move.w	x_pos(a0),d1
		addi.w	#$80,d1
		cmp.w	d1,d0
		bhs.s	loc_80008

loc_80006:
		neg.w	d2

loc_80008:
		move.w	d2,$40(a0)
		rts
; ---------------------------------------------------------------------------

loc_8000E:
		move.b	#$10,routine(a0)
		bset	#1,$38(a0)
		rts
; ---------------------------------------------------------------------------

loc_8001C:
		cmpi.w	#-1,(_unkFA82).w
		beq.s	loc_80030
		btst	#1,$38(a0)
		beq.w	loc_7FFD8
		rts
; ---------------------------------------------------------------------------

loc_80030:
		move.b	#$12,routine(a0)
		bset	#5,$38(a0)
		jsr	(AllocateObject).l
		bne.s	loc_8004A
		move.l	#loc_8642E,(a1)

loc_8004A:
		move.w	(Camera_X_pos).w,d0
		move.w	d0,(Camera_max_X_pos).w
		move.w	d0,(Camera_min_X_pos).w
		rts
; ---------------------------------------------------------------------------

loc_80058:
		move.w	y_pos(a0),d0
		addq.w	#1,d0
		move.w	d0,y_pos(a0)
		cmpi.w	#$18F,d0
		blo.s	locret_80080
		move.b	#$14,routine(a0)
		move.w	#$6C0,(Events_bg+$00).w
		move.w	(Camera_X_pos).w,d0
		subi.w	#$40,d0
		move.w	d0,x_pos(a0)

locret_80080:
		rts
; ---------------------------------------------------------------------------

loc_80082:
		move.w	y_pos(a0),d0
		subq.w	#1,d0
		move.w	d0,y_pos(a0)
		cmpi.w	#$AF,d0
		bhi.w	locret_80C88
		move.b	#8,$30(a0)
		move.w	#$80,$1C(a0)
		move.w	y_pos(a0),$3A(a0)
		clr.w	angle(a0)
		st	(Scroll_lock).w
		jsr	(AllocateObject).l
		bne.s	loc_800C0
		move.l	#loc_80590,(a1)
		move.w	a0,parent3(a1)

loc_800C0:
		lea	(ArtKosM_BossMasterEmerald).l,a1
		move.w	#tiles_to_bytes($4D0),d2
		jsr	(Queue_Kos_Module).l

loc_800D0:
		move.b	#$16,routine(a0)
		move.w	#1,$40(a0)
		rts
; ---------------------------------------------------------------------------

loc_800DE:
		bsr.w	sub_80F3A
		bsr.w	sub_81046
		bsr.w	sub_7FF3E
		bra.w	sub_8100E
; ---------------------------------------------------------------------------

loc_800EE:
		bsr.w	sub_80F3A
		bsr.w	sub_81046
		addq.w	#1,x_pos(a0)
		bsr.w	sub_8100E
		jmp	Obj_Wait(pc)
; ---------------------------------------------------------------------------

loc_80102:
		jsr	(MoveSprite2).l
		cmpi.w	#$18F,y_pos(a0)
		bhs.s	loc_8011E
		move.w	x_pos(a0),(Events_bg+$02).w
		move.w	y_pos(a0),(Events_bg+$04).w
		rts
; ---------------------------------------------------------------------------

loc_8011E:
		clr.w	(Screen_shake_flag).w
		clr.w	(Events_bg+$00).w
		bset	#5,$38(a0)
		jsr	(AllocateObject).l
		bne.s	loc_8013A
		move.l	#loc_80160,(a1)

loc_8013A:
		lea	(ArtKosM_KnuxFinalBossCrane).l,a1
		move.w	#tiles_to_bytes($49D),d2
		jsr	(Queue_Kos_Module).l
		lea	(ArtKosM_DEZFinalBossDebris).l,a1
		move.w	#tiles_to_bytes($100),d2
		jsr	(Queue_Kos_Module).l
		jmp	(Go_Delete_Sprite_2).l
; ---------------------------------------------------------------------------

loc_80160:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_8017A(pc,d0.w),d1
		jsr	off_8017A(pc,d1.w)
		jsr	(sub_80E2C).l
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------
off_8017A:
		dc.w loc_80184-off_8017A
		dc.w loc_801D8-off_8017A
		dc.w loc_80208-off_8017A
		dc.w loc_8023E-off_8017A
		dc.w loc_80264-off_8017A
; ---------------------------------------------------------------------------

loc_80184:
		lea	ObjDat3_812EC(pc),a1
		jsr	(SetUp_ObjAttributes).l
		bset	#0,render_flags(a0)
		move.b	#$F,collision_flags(a0)
		move.b	#8,collision_property(a0)
		move.w	(Camera_X_pos_copy).w,d0
		addi.w	#$60,d0
		move.w	d0,x_pos(a0)
		move.w	(Camera_Y_pos_copy).w,d0
		addi.w	#$140,d0
		move.w	d0,y_pos(a0)
		jsr	(AllocateObject).l
		bne.s	loc_801C6
		move.l	#loc_8642E,(a1)

loc_801C6:
		lea	(Child1_MakeRoboHead3).l,a2
		jsr	CreateChild1_Normal(pc)
		lea	ChildObjDat_81330(pc),a2
		jmp	CreateChild1_Normal(pc)
; ---------------------------------------------------------------------------

loc_801D8:
		subq.w	#1,y_pos(a0)
		move.w	(Camera_Y_pos).w,d0
		addi.w	#$50,d0
		cmp.w	y_pos(a0),d0
		blo.w	locret_80C88
		move.b	#4,routine(a0)
		move.w	#$500,x_vel(a0)
		lea	(Child1_MakeRoboShipFlame).l,a2
		jsr	CreateChild1_Normal(pc)
		jmp	(Swing_Setup1).l
; ---------------------------------------------------------------------------

loc_80208:
		bsr.w	sub_80F0E
		jsr	Swing_UpAndDown(pc)
		jsr	(MoveSprite2).l
		move.w	(Camera_X_pos).w,d0
		addi.w	#$100,d0
		cmp.w	x_pos(a0),d0
		bhi.s	locret_8023C
		move.b	#6,routine(a0)
		clr.w	x_vel(a0)
		move.w	#$1F,$2E(a0)
		move.l	#loc_80250,$34(a0)

locret_8023C:
		rts
; ---------------------------------------------------------------------------

loc_8023E:
		bsr.w	sub_80EF4
		jsr	Swing_UpAndDown(pc)
		jsr	(MoveSprite2).l
		jmp	Obj_Wait(pc)
; ---------------------------------------------------------------------------

loc_80250:
		move.b	#8,routine(a0)
		move.w	#$500,x_vel(a0)
		bset	#7,$38(a0)
		rts
; ---------------------------------------------------------------------------

loc_80264:
		bsr.w	sub_80F0E
		bsr.w	sub_80EF4
		jsr	Swing_UpAndDown(pc)
		move.w	x_vel(a0),d0
		cmpi.w	#$280,d0
		bls.s	loc_80282
		subi.w	#$10,d0
		move.w	d0,x_vel(a0)

loc_80282:
		jsr	(MoveSprite2).l
		move.w	(Camera_X_pos).w,d0
		addi.w	#$100,d0
		cmp.w	x_pos(a0),d0
		bls.s	locret_8029A
		move.w	d0,x_pos(a0)

locret_8029A:
		rts
; ---------------------------------------------------------------------------

loc_8029C:
		bset	#3,(_unkFAB8).w
		move.w	#$F,$2E(a0)
		move.l	#loc_802B2,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_802B2:
		move.l	#loc_802C0,(a0)
		bset	#4,(_unkFAB8).w
		rts
; ---------------------------------------------------------------------------

loc_802C0:
		jsr	Swing_UpAndDown(pc)
		jsr	(MoveSprite2).l
		move.w	(Camera_X_pos).w,d0
		addi.w	#$180,d0
		cmp.w	x_pos(a0),d0
		blo.s	loc_802DE
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_802DE:
		move.l	#loc_8030E,(a0)
		bset	#5,(_unkFAB8).w
		ori.b	#$30,$38(a0)
		jsr	(AllocateObject).l
		bne.s	loc_802FE
		move.l	#loc_8642E,(a1)

loc_802FE:
		lea	(ArtKosM_BadnikExplosion).l,a1
		move.w	#tiles_to_bytes($5A0),d2
		jmp	(Queue_Kos_Module).l
; ---------------------------------------------------------------------------

loc_8030E:
		move.l	#loc_80382,(a0)
		clr.b	$38(a0)
		move.w	(Camera_X_pos).w,d0
		subi.w	#$80,d0
		move.w	d0,x_pos(a0)
		move.w	(Camera_Y_pos).w,d0
		addi.w	#$80,d0
		move.w	d0,y_pos(a0)
		lea	(Child6_CreateBossExplosion).l,a2
		jsr	(CreateChild6_Simple).l
		bne.s	loc_80344
		move.b	#$16,subtype(a1)

loc_80344:
		lea	(Child6_CreateBossExplosion).l,a2
		jsr	(CreateChild6_Simple).l
		bne.s	loc_80358
		move.b	#$16,subtype(a1)

loc_80358:
		lea	(Child6_CreateBossExplosion).l,a2
		jsr	(CreateChild6_Simple).l
		bne.s	loc_8036C
		move.b	#$18,subtype(a1)

loc_8036C:
		lea	(Child6_CreateBossExplosion).l,a2
		jsr	(CreateChild6_Simple).l
		bne.s	locret_80380
		move.b	#$18,subtype(a1)

locret_80380:
		rts
; ---------------------------------------------------------------------------

loc_80382:
		addq.w	#2,x_pos(a0)
		move.w	(Camera_X_pos).w,d0
		addi.w	#$80,d0
		cmp.w	x_pos(a0),d0
		bhs.s	locret_803D4
		move.l	#loc_803D6,(a0)
		jsr	(AllocateObject).l
		bne.s	loc_803B4
		move.l	#loc_85E64,(a1)
		move.w	a1,$44(a0)
		move.w	#3,$3A(a1)
		rts
; ---------------------------------------------------------------------------

loc_803B4:
		lea	(Dynamic_object_RAM+(object_size*61)).w,a1
		movea.l	a1,a2
		moveq	#0,d0
		moveq	#bytesToWcnt(object_size),d1

loc_803BE:
		move.w	d0,(a1)+
		dbf	d1,loc_803BE
		move.l	#loc_85E64,(a2)
		move.w	a2,$44(a0)
		move.w	#3,$3A(a2)

locret_803D4:
		rts
; ---------------------------------------------------------------------------

loc_803D6:
		movea.w	$44(a0),a1
		btst	#7,status(a1)
		beq.s	locret_80424
		st	(SRAM_mask_interrupts_flag).w
		jsr	(SaveGame).l
		jsr	(Go_Delete_Sprite).l
		cmpi.w	#2,(Player_mode).w
		bhs.s	loc_8040C
		cmpi.b	#7,(Chaos_emerald_count).w
		bne.s	loc_8040C
		move.w	#$C00,d0
		jmp	(StartNewLevel).l
; ---------------------------------------------------------------------------

loc_8040C:
		cmpi.w	#3,(Player_mode).w
		beq.s	loc_8041E
		move.w	#$D01,d0
		jmp	(StartNewLevel).l
; ---------------------------------------------------------------------------

loc_8041E:
		move.b	#0,(Game_mode).w

locret_80424:
		rts
; ---------------------------------------------------------------------------

loc_80426:
		lea	ObjDat3_81304(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_80494,(a0)
		jsr	(Random_Number).l
		move.w	#0,priority(a0)
		tst.w	d0
		bpl.s	loc_8044C
		move.w	#$300,priority(a0)

loc_8044C:
		andi.w	#$1FF,d0
		move.w	(Camera_X_pos).w,d1
		add.w	d0,d1
		addi.w	#$20,d1
		move.w	d1,x_pos(a0)
		move.w	(Camera_Y_pos).w,d1
		subi.w	#$20,d1
		move.w	d1,y_pos(a0)
		andi.b	#3,d0
		or.b	d0,render_flags(a0)
		swap	d0
		move.w	d0,d1
		andi.w	#3,d0
		lea	RawAni_80490(pc,d0.w),a1
		move.b	(a1)+,mapping_frame(a0)
		andi.w	#$300,d1
		addi.w	#$100,d1
		move.w	d1,y_vel(a0)
		rts
; ---------------------------------------------------------------------------
RawAni_80490:
		dc.b    0,   1,   2,   1
		even
; ---------------------------------------------------------------------------

loc_80494:
		jsr	(MoveSprite2).l
		move.w	(Camera_Y_pos).w,d0
		addi.w	#$108,d0
		cmp.w	y_pos(a0),d0
		blt.w	loc_810D0
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------

loc_804B0:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_804C4(pc,d0.w),d1
		jsr	off_804C4(pc,d1.w)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
off_804C4:
		dc.w loc_804C8-off_804C4
		dc.w loc_804D2-off_804C4
; ---------------------------------------------------------------------------

loc_804C8:
		lea	ObjDat3_812F8(pc),a1
		jmp	(SetUp_ObjAttributes).l
; ---------------------------------------------------------------------------

loc_804D2:
		btst	#3,(_unkFAB8).w
		bne.s	loc_804E0
		jmp	(Refresh_ChildPositionAdjusted).l
; ---------------------------------------------------------------------------

loc_804E0:
		move.l	#Wait_Draw,(a0)
		move.l	#Go_Delete_Sprite,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_804F0:
		lea	ObjDat3_812C8(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_80512,(a0)
		move.w	#$6C,$42(a0)
		move.w	#8,$44(a0)
		move.b	#8,collision_property(a0)

loc_80512:
		tst.b	(_unkFAA9).w
		bne.s	loc_8051C
		bra.w	sub_8125C
; ---------------------------------------------------------------------------

loc_8051C:
		move.l	#loc_80522,(a0)

loc_80522:
		tst.b	(_unkFAA9).w
		bmi.s	loc_80536
		bsr.w	sub_8125C
		bsr.w	sub_81024
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_80536:
		move.l	#loc_80542,(a0)
		move.b	#$16,collision_flags(a0)

loc_80542:
		tst.b	(_unkFAA9).w
		bpl.s	loc_8055C
		bsr.w	sub_81024
		bsr.w	sub_8119A
		jsr	(Add_SpriteToCollisionResponseList).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_8055C:
		move.l	#loc_80562,(a0)

loc_80562:
		tst.b	(_unkFAA9).w
		beq.s	loc_80576
		bsr.w	sub_81024
		bsr.w	sub_8125C
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_80576:
		move.l	#loc_80512,(a0)
		bclr	#7,render_flags(a0)
		rts
; ---------------------------------------------------------------------------

loc_80584:
		clr.w	(Events_bg+$10).w
		bsr.w	sub_81024
		jmp	Child_Draw_Sprite2(pc)
; ---------------------------------------------------------------------------

loc_80590:
		move.l	#loc_805AE,(a0)
		move.b	#8,collision_flags(a0)
		move.b	#-1,collision_property(a0)
		move.w	#$A0,$42(a0)
		move.w	#-$34,$44(a0)

loc_805AE:
		tst.b	collision_flags(a0)
		beq.s	loc_805C2
		bsr.w	sub_81024
		jsr	(Add_SpriteToCollisionResponseList).l
		jmp	Child_CheckParent(pc)
; ---------------------------------------------------------------------------

loc_805C2:
		move.l	#loc_805F0,(a0)
		move.b	#-1,collision_property(a0)
		movea.w	parent3(a0),a1
		bset	#2,$38(a1)
		st	(Events_fg_5).w
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	loc_805F0
		move.l	#loc_8060C,(a1)
		move.w	parent3(a0),parent3(a1)

loc_805F0:
		movea.w	parent3(a0),a1
		btst	#2,$38(a1)
		bne.s	loc_80608
		move.l	#loc_805AE,(a0)
		move.b	$25(a0),collision_flags(a0)

loc_80608:
		jmp	Child_CheckParent(pc)
; ---------------------------------------------------------------------------

loc_8060C:
		lea	ObjDat3_812AA(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_80634,(a0)
		bset	#0,render_flags(a0)
		move.w	#$7C,$42(a0)
		move.w	#$28,$44(a0)
		move.b	#1,(_unkFAA9).w

loc_80634:
		move.w	$44(a0),d0
		addq.w	#4,d0
		move.w	d0,$44(a0)
		cmpi.w	#$68,d0
		blo.s	loc_80672
		move.l	#loc_8067A,(a0)
		bset	#2,$38(a0)
		move.b	#$80,(_unkFAA9).w
		st	(Events_fg_5).w
		jsr	(AllocateObject).l
		bne.s	loc_80672
		move.l	#loc_807BC,(a1)
		move.w	parent3(a0),parent3(a1)
		move.w	a0,$3A(a1)

loc_80672:
		bsr.w	sub_81024
		jmp	Child_Draw_Sprite(pc)
; ---------------------------------------------------------------------------

loc_8067A:
		btst	#2,$38(a0)
		beq.s	loc_8068A
		bsr.w	sub_81024
		jmp	Child_CheckParent(pc)
; ---------------------------------------------------------------------------

loc_8068A:
		move.l	#loc_806A6,(a0)
		move.w	#$80,$2E(a0)
		move.b	#1,(_unkFAA9).w
		st	(Events_fg_5).w
		move.b	#1,(_unkFAA9).w

loc_806A6:
		move.w	$44(a0),d0
		subq.w	#4,d0
		move.w	d0,$44(a0)
		cmpi.w	#$28,d0
		bhi.s	loc_806D2
		movea.w	parent3(a0),a1
		bclr	#2,$38(a1)
		clr.w	$1C(a1)
		clr.b	(_unkFAA9).w
		st	(Events_fg_5).w
		jsr	(Go_Delete_Sprite).l

loc_806D2:
		bsr.w	sub_81024
		jmp	Child_Draw_Sprite(pc)
; ---------------------------------------------------------------------------

loc_806DA:
		lea	ObjDat3_812D4(pc),a1
		jsr	(SetUp_ObjAttributes).l
		lea	(Collected_emeralds_array).w,a1
		moveq	#3,d0
		moveq	#7-1,d1

loc_806EC:
		cmp.b	(a1)+,d0
		bne.s	loc_8070A
		dbf	d1,loc_806EC
		st	$3A(a0)
		lea	word_813AA(pc),a1
		lea	(Palette_rotation_data).w,a2
		moveq	#bytesToLcnt($10),d0

loc_80702:
		move.l	(a1)+,(a2)+
		dbf	d0,loc_80702
		clr.w	(a2)

loc_8070A:
		tst.b	$2C(a0)
		bne.s	loc_80724
		move.l	#loc_80730,(a0)
		move.w	#$58,$42(a0)
		move.w	#8,$44(a0)
		rts
; ---------------------------------------------------------------------------

loc_80724:
		move.l	#loc_80760,(a0)
		clr.b	mapping_frame(a0)
		rts
; ---------------------------------------------------------------------------

loc_80730:
		tst.b	$3A(a0)
		beq.s	loc_8073A
		jsr	Run_PalRotationScript(pc)

loc_8073A:
		bsr.w	sub_81024
		movea.w	parent3(a0),a1
		btst	#4,$38(a1)
		bne.w	loc_810D0
		tst.b	(_unkFAA9).w
		beq.s	loc_80758
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_80758:
		bclr	#7,render_flags(a0)
		rts
; ---------------------------------------------------------------------------

loc_80760:
		tst.b	$3A(a0)
		beq.s	loc_8076A
		jsr	Run_PalRotationScript(pc)

loc_8076A:
		jsr	Refresh_ChildPosition(pc)
		btst	#4,(_unkFAB8).w
		beq.s	loc_8077C
		move.l	#loc_80782,(a0)

loc_8077C:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_80782:
		tst.b	$3A(a0)
		beq.s	loc_8078C
		jsr	Run_PalRotationScript(pc)

loc_8078C:
		jsr	(MoveSprite).l
		cmpi.w	#$CF,y_pos(a0)
		blo.s	loc_807A6
		move.l	#loc_807AC,(a0)
		move.w	#$CF,y_pos(a0)

loc_807A6:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_807AC:
		tst.b	$3A(a0)
		beq.s	loc_807B6
		jsr	Run_PalRotationScript(pc)

loc_807B6:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_807BC:
		lea	ObjDat3_812B6(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_807EE,(a0)
		move.w	#$58,$42(a0)
		move.w	#4,$44(a0)
		move.l	#loc_80802,$34(a0)
		move.b	#$13,$39(a0)
		moveq	#signextendB(sfx_Charging),d0
		jsr	(Play_SFX).l

loc_807EE:
		bsr.w	sub_80FFA
		lea	byte_8135A(pc),a1
		jsr	Animate_RawNoSSTMultiDelay(pc)
		bsr.w	sub_81024
		jmp	Child_Draw_Sprite(pc)
; ---------------------------------------------------------------------------

loc_80802:
		move.l	#loc_80810,(a0)
		move.w	#2*60,$2E(a0)
		rts
; ---------------------------------------------------------------------------

loc_80810:
		subq.w	#1,$2E(a0)
		bmi.s	loc_8083C
		cmpi.w	#$28,$2E(a0)
		blo.s	loc_80822
		bsr.w	sub_80FFA

loc_80822:
		move.b	#$1A,mapping_frame(a0)
		btst	#0,d0
		bne.s	loc_80834
		move.b	#$1F,mapping_frame(a0)

loc_80834:
		bsr.w	sub_81024
		jmp	Child_Draw_Sprite(pc)
; ---------------------------------------------------------------------------

loc_8083C:
		move.l	#loc_8086C,(a0)
		addi.w	#$34,$42(a0)
		addi.w	#4,$44(a0)
		lea	byte_81397(pc),a1
		jsr	Set_Raw_Animation(pc)
		move.l	#loc_80888,$34(a0)
		bclr	#7,render_flags(a0)
		moveq	#signextendB(sfx_MissileExplode),d0
		jsr	(Play_SFX).l

loc_8086C:
		jsr	Animate_RawMultiDelay(pc)
		beq.s	loc_8087C
		moveq	#0,d0
		move.b	mapping_frame(a0),d0
		move.w	d0,(Events_bg+$10).w

loc_8087C:
		bsr.w	sub_80FA6
		bsr.w	sub_81024
		jmp	Child_CheckParent(pc)
; ---------------------------------------------------------------------------

loc_80888:
		move.l	#loc_80894,(a0)
		move.w	#$5F,$2E(a0)

loc_80894:
		subq.w	#1,$2E(a0)
		bmi.s	loc_8089E
		jmp	Child_CheckParent(pc)
; ---------------------------------------------------------------------------

loc_8089E:
		movea.w	$3A(a0),a1
		bclr	#2,$38(a1)
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_808AE:
		lea	word_812C2(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#loc_808FA,(a0)
		move.l	#Go_Delete_Sprite,$34(a0)
		movea.w	parent3(a0),a1
		move.w	x_pos(a1),d2
		addi.w	#$64,d2
		move.w	y_pos(a1),d3
		addq.w	#4,d3
		jsr	(Random_Number).l
		andi.w	#$1F,d0
		add.w	d0,d2
		swap	d0
		andi.w	#$7F,d0
		subi.w	#$40,d0
		add.w	d0,d3
		move.w	d2,x_pos(a0)
		move.w	d3,y_pos(a0)
		rts
; ---------------------------------------------------------------------------

loc_808FA:
		lea	byte_8138E(pc),a1
		jsr	Animate_RawNoSSTMultiDelay(pc)
		subi.w	#$40,x_vel(a0)
		movea.w	parent3(a0),a1
		move.w	y_pos(a1),d0
		sub.w	y_pos(a0),d0
		jsr	(GetSineCosine).l
		add.w	d0,d0
		move.w	d0,y_vel(a0)
		jsr	(MoveSprite2).l
		move.w	x_pos(a1),d0
		addi.w	#$3C,d0
		cmp.w	x_pos(a0),d0
		blo.s	loc_8093A
		jsr	(Go_Delete_Sprite).l

loc_8093A:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_DEZ3_Boss_Fireball:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	DEZ3_Boss_Fireball_Index(pc,d0.w),d1
		jsr	DEZ3_Boss_Fireball_Index(pc,d1.w)
		bra.w	sub_81024
; ---------------------------------------------------------------------------
DEZ3_Boss_Fireball_Index:
		dc.w loc_80956-DEZ3_Boss_Fireball_Index
		dc.w loc_80980-DEZ3_Boss_Fireball_Index
; ---------------------------------------------------------------------------

loc_80956:
		move.b	#2,routine(a0)
		bset	#2,render_flags(a0)
		clr.b	$39(a0)
		clr.b	anim_frame(a0)
		move.w	#$B0,$42(a0)
		move.w	#-$18,$44(a0)
		moveq	#signextendB(sfx_Blast),d0
		jsr	(Play_SFX).l
		rts
; ---------------------------------------------------------------------------

loc_80980:
		subq.w	#1,$2E(a0)
		bpl.w	locret_80C88
		cmpi.w	#$C7,y_pos(a0)
		bhs.s	loc_809CA
		move.w	#1,$2E(a0)
		move.b	anim_frame(a0),d0
		move.b	d0,d1
		addq.b	#1,d0
		cmpi.b	#3,d0
		blo.s	loc_809A6
		moveq	#0,d0

loc_809A6:
		move.b	d0,anim_frame(a0)
		andi.w	#3,d1
		add.w	d1,d1
		lea	byte_809EE(pc,d0.w),a1
		move.b	(a1)+,d0
		ext.w	d0
		add.w	d0,$42(a0)
		move.b	(a1)+,d0
		ext.w	d0
		add.w	d0,$44(a0)
		moveq	#0,d2
		bra.w	sub_8106E
; ---------------------------------------------------------------------------

loc_809CA:
		move.l	#loc_809F4,(a0)
		move.w	#$CF,y_pos(a0)
		clr.b	anim_frame(a0)
		move.w	#2,$2E(a0)
		bsr.w	sub_80A26
		moveq	#2,d2
		bsr.w	sub_8106E
		addq.w	#4,sp
		rts
; ---------------------------------------------------------------------------
byte_809EE:
		dc.b    8,   8
		dc.b   -4,   4
		dc.b   $C,  $C
		even
; ---------------------------------------------------------------------------

loc_809F4:
		subq.w	#1,$2E(a0)
		bpl.s	sub_80A26
		move.w	#2,$2E(a0)
		addq.w	#8,$42(a0)
		cmpi.w	#$300,$42(a0)
		bhs.w	loc_810D0
		moveq	#8,d0
		moveq	#1,d2
		bchg	#0,anim_frame(a0)
		beq.s	loc_80A1E
		neg.w	d0
		moveq	#2,d2

loc_80A1E:
		add.w	d0,y_pos(a0)
		bsr.w	sub_8106E

; =============== S U B R O U T I N E =======================================


sub_80A26:
		movea.w	parent3(a0),a1
		move.w	$42(a0),d0
		move.w	x_pos(a1),d1
		add.w	d0,d1
		move.w	d1,x_pos(a0)
		rts
; End of function sub_80A26

; ---------------------------------------------------------------------------

loc_80A3A:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_80A5C(pc,d0.w),d1
		jsr	off_80A5C(pc,d1.w)
		tst.b	subtype(a0)
		bne.s	loc_80A56
		bsr.w	sub_81024
		jmp	Draw_And_Touch_Sprite(pc)
; ---------------------------------------------------------------------------

loc_80A56:
		bsr.s	sub_80A26
		jmp	Draw_And_Touch_Sprite(pc)
; ---------------------------------------------------------------------------
off_80A5C:
		dc.w loc_80A60-off_80A5C
		dc.w loc_80A98-off_80A5C
; ---------------------------------------------------------------------------

loc_80A60:
		lea	ObjDat3_8129E(pc),a1
		jsr	(SetUp_ObjAttributes).l
		bset	#4,shield_reaction(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		cmpi.b	#2,d0
		bne.s	loc_80A82
		bset	#0,render_flags(a0)

loc_80A82:
		lsl.w	#2,d0
		move.l	off_80A8C(pc,d0.w),$30(a0)
		rts
; ---------------------------------------------------------------------------
off_80A8C:
		dc.l byte_80AD4
		dc.l byte_80AEE
		dc.l byte_80B08
; ---------------------------------------------------------------------------

loc_80A98:
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	locret_80ACE
		moveq	#0,d0
		move.b	anim_frame(a0),d0
		addq.b	#4,d0
		move.b	d0,anim_frame(a0)
		movea.l	$30(a0),a1
		lea	(a1,d0.w),a1
		move.b	(a1)+,d1
		bmi.s	loc_80AD0
		move.b	d1,mapping_frame(a0)
		move.b	(a1)+,anim_frame_timer(a0)
		move.b	(a1)+,d0
		ext.w	d0
		add.w	d0,$42(a0)
		move.b	(a1)+,d0
		ext.w	d0
		add.w	d0,$44(a0)

locret_80ACE:
		rts
; ---------------------------------------------------------------------------

loc_80AD0:
		jmp	Go_Delete_Sprite(pc)
; ---------------------------------------------------------------------------
byte_80AD4:
		dc.b    6,   0,   0,   0
		dc.b    7,   1,   0,   4
		dc.b    8,   4,   0,   4
		dc.b    9,   4,   0,   0
		dc.b   $A,   5,   0,   4
		dc.b   $B,   5,   0,   0
		dc.b  $FF, $F4
byte_80AEE:
		dc.b   $C,   0,   0,   0
		dc.b   $D,   1,   4,  -4
		dc.b   $E,   4,   4,  -4
		dc.b   $F,   4,   0,   0
		dc.b  $10,   5,   0,   0
		dc.b  $11,   5,   0,   4
		dc.b  $FF, $F4
byte_80B08:
		dc.b   $C,   0,   0,   0
		dc.b   $D,   1,   4,  -4
		dc.b   $E,   4,   4,  -4
		dc.b   $F,   4,   0,   0
		dc.b  $10,   5,   0,   0
		dc.b  $12,   5,   4,  -4
		dc.b  $FF, $F4
; ---------------------------------------------------------------------------

loc_80B22:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_80B58(pc,d0.w),d1
		jsr	off_80B58(pc,d1.w)
		move.b	$3A(a0),d0
		andi.b	#7,d0
		cmpi.b	#7,d0
		beq.s	loc_80B42
		bra.w	sub_80A26
; ---------------------------------------------------------------------------

loc_80B42:
		lea	(_unkFA82).w,a1
		tst.b	subtype(a0)
		beq.s	loc_80B50
		lea	(_unkFA83).w,a1

loc_80B50:
		st	(a1)
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------
off_80B58:
		dc.w loc_80B66-off_80B58
		dc.w loc_80B90-off_80B58
		dc.w loc_80C2A-off_80B58
		dc.w loc_80C58-off_80B58
		dc.w loc_80C8A-off_80B58
		dc.w loc_80CA6-off_80B58
		dc.w loc_80C2A-off_80B58
; ---------------------------------------------------------------------------

loc_80B66:
		move.b	#2,routine(a0)
		move.b	#3,$39(a0)
		lea	ChildObjDat_81316(pc),a2
		jsr	CreateChild1_Normal(pc)
		move.w	#-$80,d0
		tst.b	subtype(a0)
		beq.s	loc_80B86
		neg.w	d0

loc_80B86:
		move.w	d0,$42(a0)
		move.w	#$E3,y_pos(a0)

loc_80B90:
		movea.w	parent3(a0),a1
		btst	#1,$38(a1)
		bne.s	loc_80C0E
		move.w	(Player_1+x_pos).w,d0
		move.w	x_pos(a0),d1
		move.b	$3A(a0),d2
		moveq	#0,d3
		lsr.b	#1,d2
		bcc.s	loc_80BB6
		moveq	#-$20,d3
		lsr.b	#1,d2
		bcc.s	loc_80BB6
		moveq	#$20,d3

loc_80BB6:
		add.w	d3,d1
		sub.w	d1,d0
		smi	d1
		bpl.s	loc_80BC0
		neg.w	d0

loc_80BC0:
		cmpi.w	#$80,d0
		bhs.s	locret_80C0C
		cmpi.w	#4,d0
		bls.s	locret_80C0C
		move.w	#-$80,d0
		tst.b	subtype(a0)
		beq.s	loc_80BD8
		neg.w	d0

loc_80BD8:
		move.w	$42(a0),d2
		move.b	$3A(a0),d3
		moveq	#2,d4
		moveq	#2,d5

loc_80BE4:
		lsr.b	#1,d3
		bcc.s	loc_80BEA
		addq.w	#2,d4

loc_80BEA:
		dbf	d5,loc_80BE4
		tst.b	d1
		bne.s	loc_80C00
		addi.w	#$40,d0
		cmp.w	d0,d2
		bge.s	locret_80C0C
		add.w	d4,$42(a0)
		rts
; ---------------------------------------------------------------------------

loc_80C00:
		subi.w	#$40,d0
		cmp.w	d0,d2
		blt.s	locret_80C0C
		sub.w	d4,$42(a0)

locret_80C0C:
		rts
; ---------------------------------------------------------------------------

loc_80C0E:
		move.b	#4,routine(a0)
		move.w	#-$80,y_vel(a0)
		move.w	#7,$2E(a0)
		move.l	#loc_80C34,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_80C2A:
		jsr	(MoveSprite2).l
		jmp	Obj_Wait(pc)
; ---------------------------------------------------------------------------

loc_80C34:
		move.w	#$10,$2E(a0)
		clr.w	y_vel(a0)
		move.l	#loc_80C48,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_80C48:
		move.b	#6,routine(a0)
		move.l	#loc_80C60,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_80C58:
		lea	byte_8133E(pc),a1
		jmp	Animate_RawNoSSTMultiDelay(pc)
; ---------------------------------------------------------------------------

loc_80C60:
		move.b	#8,routine(a0)
		move.w	#$2F,$2E(a0)
		bset	#1,$38(a0)
		move.b	$39(a0),d0
		lsl.w	#2,d0
		andi.w	#$C,d0
		move.w	d0,(Screen_shake_flag).w
		moveq	#signextendB(sfx_ThumpBoss),d0
		jsr	(Play_SFX).l

locret_80C88:
		rts
; ---------------------------------------------------------------------------

loc_80C8A:
		subq.w	#1,$2E(a0)
		bpl.s	locret_80CA4
		move.b	#$A,routine(a0)
		bclr	#1,$38(a0)
		move.l	#loc_80CAE,$34(a0)

locret_80CA4:
		rts
; ---------------------------------------------------------------------------

loc_80CA6:
		lea	byte_81349(pc),a1
		jmp	Animate_RawNoSSTMultiDelay(pc)
; ---------------------------------------------------------------------------

loc_80CAE:
		move.b	#$C,routine(a0)
		move.w	#$80,y_vel(a0)
		move.w	#7,$2E(a0)
		move.l	#loc_80CCA,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_80CCA:
		move.b	#2,routine(a0)
		move.w	#$E3,y_pos(a0)
		movea.w	parent3(a0),a1
		bclr	#1,$38(a1)
		rts
; ---------------------------------------------------------------------------

loc_80CE2:
		lea	ObjDat3_81292(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_80CF8,(a0)
		move.b	#3,collision_property(a0)

loc_80CF8:
		movea.w	parent3(a0),a1
		move.b	mapping_frame(a1),mapping_frame(a0)
		btst	#1,$38(a1)
		bne.s	loc_80D18
		jsr	Refresh_ChildPosition(pc)
		bsr.w	sub_810D6
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_80D18:
		move.l	#loc_80D30,(a0)
		move.b	#$1A,collision_flags(a0)
		bset	#7,art_tile(a0)
		move.w	#$80,priority(a0)

loc_80D30:
		movea.w	parent3(a0),a1
		move.b	mapping_frame(a1),mapping_frame(a0)
		btst	#1,$38(a1)
		beq.s	loc_80D50
		jsr	Refresh_ChildPosition(pc)
		bsr.w	sub_810FA
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------

loc_80D50:
		move.l	#loc_80CF8,(a0)
		bclr	#7,art_tile(a0)
		move.w	#$280,priority(a0)
		bra.s	loc_80CF8
; ---------------------------------------------------------------------------

loc_80D64:
		jsr	Refresh_ChildPosition(pc)
		jsr	Obj_Wait(pc)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_80D72:
		lea	ObjDat3_81286(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_80D9E,(a0)
		movea.w	parent3(a0),a1
		move.w	x_pos(a1),d0
		subi.w	#$10,d0
		move.w	d0,x_pos(a0)
		move.w	y_pos(a1),d0
		subi.w	#$3C,d0
		move.w	d0,y_pos(a0)

loc_80D9E:
		btst	#0,(_unkFAB8).w
		beq.s	loc_80DB8
		move.l	#loc_80DBE,(a0)
		move.w	#$1F,$2E(a0)
		move.w	#-$80,x_vel(a0)

loc_80DB8:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_80DBE:
		subq.w	#1,$2E(a0)
		bmi.s	loc_80DD0
		jsr	(MoveSprite2).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_80DD0:
		bset	#1,(_unkFAB8).w
		st	(Events_fg_5).w
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_80DE0:
		lea	ObjDat3_812E0(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_80E02,(a0)
		move.w	#$70,x_pos(a0)
		move.w	#$C0,y_pos(a0)
		bset	#0,render_flags(a0)

loc_80E02:
		lea	byte_81354(pc),a1
		jsr	Animate_RawNoSST(pc)
		move.w	x_pos(a0),d0
		addq.w	#6,d0
		move.w	d0,x_pos(a0)
		cmpi.w	#$3D0,d0
		bhs.s	loc_80E20
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_80E20:
		bset	#0,(_unkFAB8).w
		jmp	(Delete_Current_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_80E2C:
		tst.b	collision_flags(a0)
		bne.s	locret_80EA2
		move.b	collision_property(a0),d0
		beq.s	loc_80EA4
		tst.b	$20(a0)
		bne.s	loc_80E70
		move.b	#$20,$20(a0)
		moveq	#signextendB(sfx_BossHit),d0
		jsr	(Play_SFX).l
		bset	#6,status(a0)
		btst	#7,$38(a0)
		beq.s	loc_80E70
		lea	(Player_1).w,a1
		tst.b	$1C(a0)
		beq.s	loc_80E68
		lea	(Player_2).w,a1

loc_80E68:
		clr.w	x_vel(a1)
		clr.w	ground_vel(a1)

loc_80E70:
		moveq	#0,d0
		btst	#0,$20(a0)
		bne.s	loc_80E7E
		; Bug: this should be 2*3
		addi.w	#2*2,d0

loc_80E7E:
		bsr.w	sub_80ED6
		subq.b	#1,$20(a0)
		bne.s	locret_80EA2
		bclr	#6,status(a0)
		move.b	$25(a0),collision_flags(a0)
		cmpi.b	#8,routine(a0)
		blo.s	locret_80EA2
		move.w	#$800,x_vel(a0)

locret_80EA2:
		rts
; ---------------------------------------------------------------------------

loc_80EA4:
		move.l	#Wait_Draw,(a0)
		move.w	#$2F,$2E(a0)
		move.l	#loc_8029C,$34(a0)
		lea	(Child6_CreateBossExplosion).l,a2
		jsr	(CreateChild6_Simple).l
		bne.s	loc_80ECC
		move.b	#4,subtype(a1)

loc_80ECC:
		moveq	#100,d0
		jsr	(HUD_AddToScore).l
		rts
; End of function sub_80E2C


; =============== S U B R O U T I N E =======================================


sub_80ED6:
		lea	word_80EE2(pc),a1
		lea	word_80EE8(pc,d0.w),a2
		jmp	CopyWordData_3(pc)
; End of function sub_80ED6

; ---------------------------------------------------------------------------
word_80EE2:
		dc.w Normal_palette+$0E, Normal_palette+$1C, Normal_palette+$1E
word_80EE8:
		dc.w      8,  $866,  $222
		dc.w   $888,  $CCC,  $EEE

; =============== S U B R O U T I N E =======================================


sub_80EF4:
		move.b	(V_int_run_count+3).w,d0
		andi.b	#$F,d0
		bne.s	locret_80F0C
		jsr	(AllocateObject).l
		bne.s	locret_80F0C
		move.l	#loc_80426,(a1)

locret_80F0C:
		rts
; End of function sub_80EF4


; =============== S U B R O U T I N E =======================================


sub_80F0E:
		move.l	(_unkFA84).w,d0
		addi.l	#$1000,d0
		cmpi.l	#$40000,d0
		bhi.s	loc_80F24
		move.l	d0,(_unkFA84).w

loc_80F24:
		move.l	(Camera_X_pos).w,d1
		add.l	d0,d1
		move.l	d1,(Camera_X_pos).w
		swap	d1
		move.w	d1,(Camera_min_X_pos).w
		move.w	d1,(Camera_max_X_pos).w
		rts
; End of function sub_80F0E


; =============== S U B R O U T I N E =======================================


sub_80F3A:
		btst	#7,status(a0)
		beq.s	locret_80F9C
		move.l	#loc_80102,(a0)
		move.w	#$80,x_vel(a0)
		move.w	#$80,y_vel(a0)
		jsr	(AllocateObject).l
		bne.s	loc_80F62
		move.l	#loc_8642E,(a1)

loc_80F62:
		bclr	#5,$38(a0)
		lea	(Child6_CreateBossExplosion).l,a2
		jsr	(CreateChild6_Simple).l
		bne.s	loc_80F7C
		move.b	#$16,subtype(a1)

loc_80F7C:
		lea	(Child6_CreateBossExplosion).l,a2
		jsr	(CreateChild6_Simple).l
		bne.s	loc_80F90
		move.b	#$16,subtype(a1)

loc_80F90:
		lea	PLC_DEZ3_Boss(pc),a1
		jsr	(Load_PLC_Raw).l
		addq.w	#4,sp

locret_80F9C:
		rts
; End of function sub_80F3A

; ---------------------------------------------------------------------------
PLC_DEZ3_Boss: plrlistheader
		plreq $52E, ArtNem_RobotnikShip
PLC_DEZ3_Boss_End

; =============== S U B R O U T I N E =======================================


sub_80FA6:
		cmpi.b	#$1E,mapping_frame(a0)
		bne.s	locret_80FF0
		lea	word_80FF2(pc),a1
		jsr	Check_PlayerInRange(pc)
		tst.l	d0
		beq.s	locret_80FF0
		tst.w	d0
		beq.s	loc_80FD6
		movea.w	d0,a1
		tst.b	invulnerability_timer(a1)
		bne.s	loc_80FD6
		btst	#Status_Invincible,status_secondary(a1)
		bne.s	loc_80FD6
		move.l	d0,-(sp)
		jsr	HurtCharacter_Directly(pc)
		move.l	(sp)+,d0

loc_80FD6:
		swap	d0
		tst.w	d0
		beq.s	locret_80FF0
		movea.w	d0,a1
		tst.b	invulnerability_timer(a1)
		bne.s	locret_80FF0
		btst	#Status_Invincible,status_secondary(a1)
		bne.s	locret_80FF0
		jsr	HurtCharacter_Directly(pc)

locret_80FF0:
		rts
; End of function sub_80FA6

; ---------------------------------------------------------------------------
word_80FF2:
		dc.w      0,  $120,  -$20,   $40

; =============== S U B R O U T I N E =======================================


sub_80FFA:
		move.b	(V_int_run_count+3).w,d0
		andi.b	#3,d0
		bne.s	locret_8100C
		lea	ChildObjDat_8132A(pc),a2
		jsr	CreateChild6_Simple(pc)

locret_8100C:
		rts
; End of function sub_80FFA


; =============== S U B R O U T I N E =======================================


sub_8100E:
		move.w	x_pos(a0),d0
		addi.w	#$40,d0
		move.w	d0,(Camera_min_X_pos).w
		move.w	d0,(Camera_max_X_pos).w
		addq.w	#1,(Camera_X_pos).w
		rts
; End of function sub_8100E


; =============== S U B R O U T I N E =======================================


sub_81024:
		movea.w	parent3(a0),a1
		move.w	$42(a0),d0
		move.w	x_pos(a1),d1
		add.w	d0,d1
		move.w	d1,x_pos(a0)
		move.w	$44(a0),d0
		move.w	y_pos(a1),d1
		add.w	d0,d1
		move.w	d1,y_pos(a0)
		rts
; End of function sub_81024


; =============== S U B R O U T I N E =======================================


sub_81046:
		btst	#2,$38(a0)
		bne.s	locret_8106C
		subq.w	#1,$1C(a0)
		bpl.s	locret_8106C
		move.w	#$140,$1C(a0)
		jsr	(AllocateObject).l
		bne.s	locret_8106C
		move.l	#Obj_DEZ3_Boss_Fireball,(a1)
		move.w	a0,parent3(a1)

locret_8106C:
		rts
; End of function sub_81046


; =============== S U B R O U T I N E =======================================


sub_8106E:
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	locret_8109E
		move.l	#loc_80A3A,(a1)
		move.w	parent3(a0),parent3(a1)
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		move.w	$42(a0),$42(a1)
		move.w	$44(a0),$44(a1)
		move.b	d2,subtype(a1)

locret_8109E:
		rts
; End of function sub_8106E

; ---------------------------------------------------------------------------

loc_810A0:
		move.w	(Camera_X_pos).w,d0
		move.w	d0,(Camera_min_X_pos).w
		move.w	#$520,d1
		cmp.w	d1,d0
		blo.w	locret_80C88
		bset	#2,(_unkFAB8).w
		move.w	d1,(Camera_min_X_pos).w
		addi.w	#$A0,d1
		move.w	d1,(Camera_max_X_pos).w
		move.w	#$2C0,(Events_bg+$00).w
		addi.w	#$100,x_pos(a0)

loc_810D0:
		jmp	(Delete_Current_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_810D6:
		move.b	collision_property(a0),d0
		beq.s	loc_81140
		tst.b	$20(a0)
		beq.s	locret_810F8
		bsr.w	sub_8117A
		subq.b	#1,$20(a0)
		bne.s	locret_810F8
		bclr	#6,status(a0)
		move.b	$25(a0),collision_flags(a0)

locret_810F8:
		rts
; End of function sub_810D6


; =============== S U B R O U T I N E =======================================


sub_810FA:
		cmpi.b	#4,mapping_frame(a0)
		bne.s	sub_810D6
		tst.b	collision_flags(a0)
		bne.s	locret_8113E
		move.b	collision_property(a0),d0
		beq.s	loc_81140
		tst.b	$20(a0)
		bne.s	loc_81128
		move.b	#$20,$20(a0)
		moveq	#signextendB(sfx_BossHit),d0
		jsr	(Play_SFX).l
		bset	#6,status(a0)

loc_81128:
		bsr.w	sub_8117A
		subq.b	#1,$20(a0)
		bne.s	locret_8113E
		bclr	#6,status(a0)
		move.b	$25(a0),collision_flags(a0)

locret_8113E:
		rts
; ---------------------------------------------------------------------------

loc_81140:
		move.l	#loc_80D64,(a0)
		move.w	#$1F,$2E(a0)
		move.l	#Go_Delete_Sprite,$34(a0)
		lea	(Child6_CreateBossExplosion).l,a2
		jsr	(CreateChild6_Simple).l
		bne.s	loc_81168
		move.b	#6,subtype(a1)

loc_81168:
		moveq	#0,d0
		move.b	subtype(a0),d0
		lsr.w	#1,d0
		movea.w	parent3(a0),a1
		bset	d0,$3A(a1)
		rts
; End of function sub_810FA


; =============== S U B R O U T I N E =======================================


sub_8117A:
		movea.w	parent3(a0),a1
		move.b	mapping_frame(a1),d0
		btst	#0,$20(a0)
		beq.s	loc_81190
		move.b	d0,mapping_frame(a0)
		rts
; ---------------------------------------------------------------------------

loc_81190:
		addi.b	#$13,d0
		move.b	d0,mapping_frame(a0)
		rts
; End of function sub_8117A


; =============== S U B R O U T I N E =======================================


sub_8119A:
		tst.b	collision_flags(a0)
		bne.s	locret_81204
		tst.b	collision_property(a0)
		beq.s	loc_81206
		tst.b	$20(a0)
		bne.s	loc_811DA
		move.b	#$20,$20(a0)
		moveq	#signextendB(sfx_BossHit),d0
		jsr	(Play_SFX).l
		lea	(Player_1).w,a1
		tst.b	$1C(a0)
		beq.s	loc_811C8
		lea	(Player_2).w,a1

loc_811C8:
		move.w	#$600,d0
		move.w	d0,ground_vel(a1)
		move.w	d0,x_vel(a1)
		move.w	#-$300,y_vel(a1)

loc_811DA:
		bset	#6,status(a0)
		moveq	#0,d0
		btst	#0,$20(a0)
		bne.s	loc_811EE
		addi.w	#2*5,d0

loc_811EE:
		bsr.w	sub_81230
		subq.b	#1,$20(a0)
		bne.s	locret_81204
		bclr	#6,status(a0)
		move.b	$25(a0),collision_flags(a0)

locret_81204:
		rts
; ---------------------------------------------------------------------------

loc_81206:
		move.l	#loc_80584,(a0)
		lea	(Child6_CreateBossExplosion).l,a2
		jsr	(CreateChild6_Simple).l
		bne.s	loc_81220
		move.b	#4,subtype(a1)

loc_81220:
		movea.w	parent3(a0),a1
		bset	#7,status(a1)
		jmp	(BossDefeated_StopTimer).l
; End of function sub_8119A


; =============== S U B R O U T I N E =======================================


sub_81230:
		lea	word_8123E(pc),a1
		lea	word_81248(pc,d0.w),a2
		jmp	(CopyWordData_5).l
; End of function sub_81230

; ---------------------------------------------------------------------------
word_8123E:
		dc.w Normal_palette_line_2+$14, Normal_palette_line_2+$16, Normal_palette_line_2+$18, Normal_palette_line_2+$1A, Normal_palette_line_2+$1C
word_81248:
		dc.w   $888,  $666,  $444,  $222,     0
		dc.w   $EEE,  $EEE,  $CCC,  $AAA,  $888

; =============== S U B R O U T I N E =======================================


sub_8125C:
		tst.b	collision_property(a0)
		beq.s	loc_81206
		tst.b	$20(a0)
		beq.s	locret_81284
		moveq	#0,d0
		btst	#0,$20(a0)
		bne.s	loc_81276
		addi.w	#2*5,d0

loc_81276:
		bsr.s	sub_81230
		subq.b	#1,$20(a0)
		bne.s	locret_81284
		bclr	#6,status(a0)

locret_81284:
		rts
; End of function sub_8125C

; ---------------------------------------------------------------------------
ObjDat3_81286:
		dc.l Map_DEZFinalBossMisc
		dc.w make_art_tile($38F,1,0)
		dc.w   $280
		dc.b  $20, $20,   5,   0
ObjDat3_81292:
		dc.l Map_DEZFinalBossMisc
		dc.w make_art_tile($38F,1,0)
		dc.w   $280
		dc.b  $10, $60,   0,   0
ObjDat3_8129E:
		dc.l Map_DEZFinalBossMisc
		dc.w make_art_tile($38F,1,1)
		dc.w   $300
		dc.b  $10, $10,   6, $8B
ObjDat3_812AA:
		dc.l Map_DEZFinalBossMisc
		dc.w make_art_tile($001,1,0)
		dc.w   $180
		dc.b  $40, $40, $1E,   0
ObjDat3_812B6:
		dc.l Map_DEZFinalBossMisc
		dc.w make_art_tile($38F,1,0)
		dc.w   $180
		dc.b  $10, $24, $1A,   0
word_812C2:
		dc.w   $200
		dc.b    4,   4, $1B,   0
ObjDat3_812C8:
		dc.l Map_DEZFinalBossMisc
		dc.w make_art_tile($38F,1,0)
		dc.w   $280
		dc.b    4, $20, $18,   0
ObjDat3_812D4:
		dc.l Map_BossMasterEmerald
		dc.w make_art_tile($4D0,2,0)
		dc.w   $300
		dc.b  $20, $18,   1,   0
ObjDat3_812E0:
		dc.l Map_FBZRobotnikRun
		dc.w make_art_tile($58C,0,0)
		dc.w   $280
		dc.b  $20, $20,   0,   0
ObjDat3_812EC:
		dc.l Map_RobotnikShip
		dc.w make_art_tile($52E,0,0)
		dc.w $200
		dc.b  $20, $20,   5,   0
ObjDat3_812F8:
		dc.l Map_KnuxFinalBossCrane
		dc.w make_art_tile($49D,0,0)
		dc.w   $200
		dc.b  $14, $14,   0,   0
ObjDat3_81304:
		dc.l Map_DEZFinalBossDebris
		dc.w make_art_tile($100,2,1)
		dc.w   $300
		dc.b  $18, $10,   0,   0
ChildObjDat_81310:
		dc.w 2-1
		dc.l loc_80B22
ChildObjDat_81316:
		dc.w 3-1
		dc.l loc_80CE2
		dc.b    0,-$10
		dc.l loc_80CE2
		dc.b -$20,-$10
		dc.l loc_80CE2
		dc.b  $20,-$10
ChildObjDat_8132A:
		dc.w 1-1
		dc.l loc_808AE
ChildObjDat_81330:
		dc.w 2-1
		dc.l loc_804B0
		dc.b    0, $23
		dc.l loc_806DA
		dc.b    0, $3B
byte_8133E:
		dc.b    0,   1
		dc.b    1,   1
		dc.b    2,   1
		dc.b    3,   1
		dc.b    4,   0
		dc.b  $F4
byte_81349:
		dc.b    4,   3
		dc.b    3,   3
		dc.b    2,   3
		dc.b    1,   3
		dc.b    0,  $F
		dc.b  $F4
byte_81354:
		dc.b    2,   0,   1,   2,   1, $FC
byte_8135A:
		dc.b  $1F,   5
		dc.b  $1A,   0
		dc.b  $1F,   5
		dc.b  $1A,   0
		dc.b  $1F,   5
		dc.b  $1A,   0
		dc.b  $1F,   4
		dc.b  $1A,   0
		dc.b  $1F,   4
		dc.b  $1A,   0
		dc.b  $1F,   3
		dc.b  $1A,   0
		dc.b  $1F,   3
		dc.b  $1A,   0
		dc.b  $1F,   2
		dc.b  $1A,   0
		dc.b  $1F,   2
		dc.b  $1A,   0
		dc.b  $1F,   1
		dc.b  $1A,   0
		dc.b  $1F,   1
		dc.b  $F4, $1A
		dc.b    0, $1F
		dc.b    0, $1A
		dc.b    0, $1F
		dc.b    0, $F4
byte_8138E:
		dc.b  $1B,   7
		dc.b  $1B,   7
		dc.b  $1C,   5
		dc.b  $1D,   3
		dc.b  $F4
byte_81397:
		dc.b    0,   0
		dc.b    6,   0
		dc.b   $E,   1
		dc.b  $16,   2
		dc.b  $1E,   3
		dc.b  $16,   1
		dc.b   $E,   2
		dc.b    6,   3
		dc.b    0,   0
		dc.b  $F4
		even

word_813AA:	palscriptptr .hdr1, .data1
		palscriptptr .hdr2, .data2
.hdr1	palscripthdr	Normal_palette_line_3+$12, 1, 0
.data1	palscriptdata	15,$660
	palscriptdata	18,$680
	palscriptdata	7, $880
	palscriptdata	7, $6A2
	palscriptdata	5, $AC0
	palscriptdata	5, $CE8
	palscriptdata	5, $AC0
	palscriptdata	7, $6A2
	palscriptdata	7, $880
	palscriptdata	18,$680
	palscriptrept
.hdr2	palscripthdr	Normal_palette_line_3+$16, 1, 0
.data2	palscriptdata	15,$6A0
	palscriptdata	9, $8C0
	palscriptdata	9, $AC0
	palscriptdata	7, $CE0
	palscriptdata	7, $CE6
	palscriptdata	5, $CE8
	palscriptdata	5, $EEC
	palscriptdata	5, $CE8
	palscriptdata	7, $CE6
	palscriptdata	7, $CE0
	palscriptdata	9, $AC0
	palscriptdata	9, $8C0
	palscriptrept

word_8141E:	palscriptptr .hdr1, .data1
		palscriptptr .hdr2, .data2
.hdr1	palscripthdr	Normal_palette_line_4+$12, 1, 0
.data1	palscriptdata	15,$660
	palscriptdata	18,$680
	palscriptdata	7, $880
	palscriptdata	7, $6A2
	palscriptdata	5, $AC0
	palscriptdata	5, $CE8
	palscriptdata	5, $AC0
	palscriptdata	7, $6A2
	palscriptdata	7, $880
	palscriptdata	18,$680
	palscriptrept
.hdr2	palscripthdr	Normal_palette_line_4+$16, 1, 0
.data2	palscriptdata	15,$6A0
	palscriptdata	9, $8C0
	palscriptdata	9, $AC0
	palscriptdata	7, $CE0
	palscriptdata	7, $CE6
	palscriptdata	5, $CE8
	palscriptdata	5, $EEC
	palscriptdata	5, $CE8
	palscriptdata	7, $CE6
	palscriptdata	7, $CE0
	palscriptdata	9, $AC0
	palscriptdata	9, $8C0
	palscriptrept
; ---------------------------------------------------------------------------

loc_81492:
		bsr.w	sub_82742
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_81514(pc,d0.w),d1
		jsr	off_81514(pc,d1.w)
		move.w	(_unkFABC).w,d0
		move.w	(Debug_placement_mode).w,d1
		move.w	d1,(_unkFABC).w
		eor.w	d1,d0
		beq.s	loc_814B8
		bsr.w	sub_8151C

loc_814B8:
		tst.w	d1
		bne.s	locret_81512
		bsr.w	sub_82920
		bsr.w	sub_829D2
		btst	#1,(_unkFAB8).w
		beq.s	locret_81512
		move.l	#loc_816FC,(a0)
		bset	#3,$38(a0)
		move.l	(Camera_X_pos).w,d0
		move.l	d0,(_unkFA86).w
		swap	d0
		move.w	d0,(Camera_stored_min_X_pos).w
		move.w	d0,(Camera_min_X_pos).w
		move.w	d0,(Camera_max_X_pos).w
		addi.w	#$140,d0
		move.w	d0,(Camera_stored_max_X_pos).w
		jsr	(AllocateObject).l
		bne.s	loc_81504
		move.l	#Obj_DecLevStartXGradual,(a1)

loc_81504:
		jsr	(AllocateObject).l
		bne.s	locret_81512
		move.l	#Obj_IncLevEndXGradual,(a1)

locret_81512:
		rts
; ---------------------------------------------------------------------------
off_81514:
		dc.w loc_81554-off_81514
		dc.w loc_8160A-off_81514
		dc.w loc_8167C-off_81514
		dc.w loc_816F4-off_81514

; =============== S U B R O U T I N E =======================================


sub_8151C:
		tst.w	d1
		bne.s	loc_81548
		lea	(Player_1).w,a1
		move.w	x_pos(a1),x_pos(a0)
		move.w	y_pos(a1),y_pos(a0)
		move.b	#1,object_control(a1)
		clr.b	anim(a1)
		move.w	#$800,x_vel(a1)
		move.w	#$800,ground_vel(a1)
		rts
; ---------------------------------------------------------------------------

loc_81548:
		clr.w	(Camera_min_X_pos).w
		move.w	#$7FFF,(Camera_max_X_pos).w
		rts
; End of function sub_8151C

; ---------------------------------------------------------------------------

loc_81554:
		move.b	#2,routine(a0)
		move.w	a0,(_unkFA8E).w
		move.w	#$17,$2E(a0)
		move.w	#$400,x_vel(a0)
		st	(Scroll_lock).w
		move.b	#1,(Boss_flag).w
		move.l	#$10000,(_unkFA82).w
		move.l	#$800,(_unkFA8A).w
		lea	(Player_1).w,a1
		bset	#7,art_tile(a1)
		move.b	#$81,object_control(a1)
		move.b	#2,anim(a1)
		clr.b	status(a1)
		move.w	(Camera_X_pos).w,d0
		subi.w	#$20,d0
		move.w	d0,x_pos(a0)
		move.w	(Camera_Y_pos).w,d0
		addi.w	#$20,d0
		move.w	d0,y_pos(a0)
		lea	word_81602(pc),a1
		lea	(_unkFAB0).w,a2
		move.l	(a1)+,(a2)+
		move.l	(a1)+,(a2)+
		move.w	#0,(Camera_min_Y_pos).w
		move.w	#$120,(Camera_max_Y_pos).w
		move.w	#$120,(Camera_target_max_Y_pos).w
		lea	(Player_2).w,a1
		moveq	#0,d0
		moveq	#$12-1,d1

loc_815DC:
		move.l	d0,(a1)+
		dbf	d1,loc_815DC
		clr.w	(a1)
		jsr	(AllocateObject).l
		bne.s	loc_815F2
		move.l	#loc_82722,(a1)

loc_815F2:
		lea	(ArtKosM_DDZMisc).l,a1
		move.w	#tiles_to_bytes($2DB),d2
		jmp	(Queue_Kos_Module).l
; ---------------------------------------------------------------------------
word_81602:
		dc.w    $20,   $C0
		dc.w    $20,   $C0
; ---------------------------------------------------------------------------

loc_8160A:
		jsr	(MoveSprite_LightGravity).l
		subq.w	#1,$2E(a0)
		bpl.w	locret_82ABA
		move.b	#4,routine(a0)
		bset	#7,$38(a0)
		addi.w	#50,(Ring_count).w
		move.b	#1,(Super_palette_status).w
		move.b	#$F,(Palette_timer).w
		move.b	#1,(Super_Sonic_Knux_flag).w
		move.w	#60,(Super_frame_count).w
		move.l	#Map_SuperSonic,(Player_1+mappings).w
		move.b	#$81,(Player_1+object_control).w
		move.b	#$1F,(Player_1+anim).w
		move.w	#$A00,(Max_speed).w
		move.w	#$30,(Acceleration).w
		move.w	#$100,(Deceleration).w
		move.b	#0,(Player_1+invincibility_timer).w
		bset	#Status_Invincible,(Player_1+status_secondary).w
		moveq	#signextendB(sfx_Whistle),d0			; This is not the normal Super transformation SFX
		jmp	(Play_SFX).l
; ---------------------------------------------------------------------------

loc_8167C:
		subi.w	#$20,y_vel(a0)
		jsr	(MoveSprite2).l
		lea	(Player_1).w,a1
		tst.b	object_control(a1)
		bne.w	locret_82ABA
		move.b	#6,routine(a0)
		clr.w	x_vel(a0)
		clr.w	y_vel(a0)
		bset	#2,$38(a0)
		move.b	#1,object_control(a1)
		clr.b	anim(a1)
		move.w	#$1000,x_vel(a1)
		move.w	#$1000,ground_vel(a1)
		cmpi.b	#7,(Super_emerald_count).w
		beq.s	loc_816D2
		move.l	#loc_8242A,(Super_stars).w
		bra.w	loc_816E8
; ---------------------------------------------------------------------------

loc_816D2:
		jsr	(sub_5FCCE).l
		move.l	#Obj_HyperSonic_Stars,(Invincibility_stars).w
		move.l	#Obj_HyperSonicKnux_Trail,(Super_stars).w

loc_816E8:
		lea	(PLC_BossExplosion).l,a1
		jmp	(Load_PLC_Raw).l
; ---------------------------------------------------------------------------

loc_816F4:
		bsr.w	sub_82772
		bra.w	sub_828B2
; ---------------------------------------------------------------------------

loc_816FC:
		bsr.w	sub_82742
		bsr.w	sub_82772
		bsr.w	sub_828B2
		bsr.w	sub_829A0
		bsr.w	sub_829D2
		btst	#0,(_unkFAB8).w
		beq.s	locret_81724
		move.l	#loc_81726,(a0)
		move.w	#$140,$3C(a0)

locret_81724:
		rts
; ---------------------------------------------------------------------------

loc_81726:
		clr.w	(_unkFAAE).w
		move.w	(Camera_X_pos).w,d0
		cmpi.w	#$7400,d0
		blo.s	loc_81770
		move.w	#$2000,d1
		sub.w	d1,d0
		move.w	d0,(Camera_X_pos).w
		jsr	(Seek_Object_Manager).l
		moveq	#0,d0
		lea	(Ring_status_table).w,a1
		move.w	#bytesToLcnt($400),d1

loc_8174E:
		move.l	d0,(a1)+
		dbf	d1,loc_8174E
		move.w	(Camera_X_pos).w,d0
		subi.w	#$80,d0
		andi.w	#$FF80,d0
		move.w	d0,(Camera_X_pos_coarse_back).w
		move.w	#$2000,d1
		move.w	d1,(_unkFAAE).w
		sub.w	d1,x_pos(a0)

loc_81770:
		bsr.w	sub_82742
		bsr.w	sub_82772
		bsr.w	sub_828B2
		move.w	(_unkFABC).w,d0
		move.w	(Debug_placement_mode).w,d1
		move.w	d1,(_unkFABC).w
		eor.w	d1,d0
		beq.s	loc_81790
		bsr.w	sub_8151C

loc_81790:
		tst.w	d1
		bne.w	locret_82ABA
		bsr.w	sub_82920
		bra.w	sub_829D2
; ---------------------------------------------------------------------------

loc_8179E:
		lea	(Player_1).w,a1
		jsr	(MoveSprite).l
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		move.w	(Camera_Y_pos).w,d0
		addi.w	#$F0,d0
		cmp.w	y_pos(a0),d0
		bhs.w	locret_82ABA
		movea.l	a0,a2
		lea	(Player_1).w,a1
		movea.l	a1,a0
		jsr	(Kill_Character).l
		movea.l	a2,a0
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

Obj_DDZEndBoss:
		move.w	(_unkFAAE).w,d0
		sub.w	d0,x_pos(a0)
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	.Index(pc,d0.w),d1
		jsr	.Index(pc,d1.w)
		move.w	x_pos(a0),(Events_bg+$02).w
		move.w	y_pos(a0),(Events_bg+$04).w
		rts
; ---------------------------------------------------------------------------
.Index:
		dc.w loc_8180E-.Index
		dc.w loc_81856-.Index
		dc.w loc_818B4-.Index
		dc.w loc_81914-.Index
		dc.w loc_81958-.Index
		dc.w loc_81A00-.Index
		dc.w loc_81A74-.Index
		dc.w loc_81B26-.Index
; ---------------------------------------------------------------------------

loc_8180E:
		move.b	#2,routine(a0)
		bset	#1,(_unkFAB8).w
		move.w	#$200,(Events_bg+$00).w
		move.w	(Camera_X_pos).w,d0
		addi.w	#$140,d0
		move.w	d0,x_pos(a0)
		move.w	#$A0,y_pos(a0)
		move.w	#$8F,$2E(a0)
		jsr	(Swing_Setup1).l
		lea	ChildObjDat_8325C(pc),a2
		jsr	CreateChild6_Simple(pc)
		lea	ChildObjDat_83262(pc),a2
		jsr	CreateChild6_Simple(pc)
		lea	ChildObjDat_83268(pc),a2
		jmp	CreateChild6_Simple(pc)
; ---------------------------------------------------------------------------

loc_81856:
		jsr	Swing_UpAndDown(pc)
		jsr	(MoveSprite2).l
		subq.w	#1,x_pos(a0)
		subq.w	#1,$2E(a0)
		bpl.s	locret_818B2
		move.b	#4,routine(a0)
		bset	#3,$38(a0)
		move.w	(Camera_min_X_pos).w,d0
		subi.w	#$100,d0
		move.w	d0,(Camera_stored_min_X_pos).w
		jsr	(AllocateObject).l
		bne.s	loc_81890
		move.l	#Obj_DecLevStartXGradual,(a1)

loc_81890:
		jsr	(AllocateObject).l
		bne.s	locret_818B2
		move.l	#loc_81F94,(a1)
		move.w	a0,parent3(a1)
		st	$39(a1)
		move.w	#$D8,$42(a1)
		move.w	#$80,$44(a1)

locret_818B2:
		rts
; ---------------------------------------------------------------------------

loc_818B4:
		jsr	Swing_UpAndDown(pc)
		jsr	(MoveSprite2).l
		move.w	#$160,d2
		move.w	#$130,d3
		bsr.w	sub_830C0
		move.w	(_unkFAA4).w,d0
		beq.s	locret_81912
		movea.w	d0,a1
		btst	#7,status(a1)
		beq.s	locret_81912
		move.b	#6,5(a0)
		bset	#7,status(a0)
		move.w	#(5*60)-1,$2E(a0)
		move.l	#-$20,(_unkFA8A).w
		jsr	(AllocateObject).l
		bne.s	locret_81912
		move.l	#loc_82E9A,(a1)
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		move.w	a0,parent3(a1)

locret_81912:
		rts
; ---------------------------------------------------------------------------

loc_81914:
		move.w	#$160,d2
		move.w	#$130,d3
		bsr.w	sub_830C0
		subq.w	#1,$2E(a0)
		bpl.s	locret_81956
		move.b	#8,routine(a0)
		move.w	#60-1,$3A(a0)
		move.b	#3,$39(a0)
		move.w	#-$300,x_vel(a0)
		move.w	#$100,y_vel(a0)
		jsr	(AllocateObject).l
		bne.s	locret_81956
		move.l	#loc_83004,(a1)
		move.w	a0,parent3(a1)

locret_81956:
		rts
; ---------------------------------------------------------------------------

loc_81958:
		subq.w	#1,$3A(a0)
		bpl.s	loc_8197C
		move.w	#$59,$3A(a0)
		subq.b	#1,$39(a0)
		bmi.s	loc_8197C
		lea	(Normal_palette_line_3).w,a1
		moveq	#$10-1,d0
		moveq	#$E,d1
		moveq	#-$20,d2

loc_81974:
		jsr	DecColor_Obj(pc)
		dbf	d0,loc_81974

loc_8197C:
		moveq	#signextendB(sfx_Rumble2),d0
		jsr	(Play_SFX_Continuous).l
		move.w	#$160,d2
		move.w	#$130,d3
		bsr.w	sub_830C0
		jsr	(MoveSprite2).l
		move.w	(Camera_max_Y_pos).w,d0
		addi.w	#$D0,d0
		cmp.w	y_pos(a0),d0
		bhs.w	locret_82ABA
		move.b	#$A,routine(a0)
		ori.b	#$30,$38(a0)
		move.w	#$1F,$2E(a0)
		moveq	#signextendB(sfx_MissileExplode),d0
		jsr	(Play_SFX).l
		jsr	(AllocateObject).l
		bne.s	loc_819CE
		move.l	#loc_83108,(a1)

loc_819CE:
		lea	(Pal_DDZ+$20).l,a1
		lea	(Normal_palette_line_3).w,a2
		moveq	#bytesToLcnt($20),d6

loc_819DA:
		move.l	(a1)+,(a2)+
		dbf	d6,loc_819DA
		lea	(Normal_palette).w,a1
		lea	(Target_palette).w,a2
		moveq	#bytesToLcnt($80),d6

loc_819EA:
		move.l	(a1)+,(a2)+
		dbf	d6,loc_819EA
		lea	(ArtKosM_BossMasterEmerald).l,a1
		move.w	#tiles_to_bytes($4D0),d2
		jmp	(Queue_Kos_Module).l
; ---------------------------------------------------------------------------

loc_81A00:
		subq.w	#1,$2E(a0)
		bpl.w	locret_82ABA
		move.b	#$C,routine(a0)
		bclr	#7,status(a0)
		andi.b	#$CF,$38(a0)
		move.w	(_unkFA8E).w,d0
		beq.s	loc_81A28
		movea.w	d0,a1
		andi.b	#$F3,$38(a1)

loc_81A28:
		move.w	#$600,(Events_bg+$00).w
		move.w	(Camera_X_pos).w,d0
		move.w	d0,(Camera_min_X_pos).w
		move.w	d0,(Camera_max_X_pos).w
		subi.w	#$80,d0
		move.w	d0,x_pos(a0)
		move.w	(Camera_Y_pos).w,d0
		move.w	d0,(Camera_min_Y_pos).w
		move.w	d0,(Camera_max_Y_pos).w
		move.w	d0,(Camera_target_max_Y_pos).w
		addi.w	#$E0,d0
		move.w	d0,y_pos(a0)
		clr.w	x_vel(a0)
		move.w	#-$200,y_vel(a0)
		lea	ChildObjDat_83274(pc),a2
		jsr	CreateChild6_Simple(pc)
		lea	ChildObjDat_83282(pc),a2
		jmp	CreateChild6_Simple(pc)
; ---------------------------------------------------------------------------

loc_81A74:
		jsr	(MoveSprite2).l
		move.w	(Camera_Y_pos).w,d0
		addi.w	#$20,d0
		cmp.w	y_pos(a0),d0
		blo.s	loc_81A9C
		bset	#7,$38(a0)
		bne.s	loc_81A9C
		moveq	#signextendB(sfx_Blast),d0
		jsr	(Play_SFX).l
		clr.w	y_vel(a0)

loc_81A9C:
		addi.w	#$10,x_vel(a0)
		move.w	(Camera_X_pos).w,d0
		addi.w	#$1C0,d0
		cmp.w	x_pos(a0),d0
		bhi.s	locret_81B24
		move.b	#$E,routine(a0)
		bclr	#4,$38(a0)
		move.l	#$800,(_unkFA8A).w
		bset	#0,(_unkFAB8).w
		move.b	#7,collision_property(a0)
		clr.w	$2E(a0)
		clr.w	x_vel(a0)
		jsr	(Swing_Setup1).l
		move.w	#0,d0
		move.w	d0,(Camera_stored_min_Y_pos).w
		addi.w	#$C0,d0
		move.w	d0,y_pos(a0)
		jsr	(AllocateObject).l
		bne.s	loc_81AFC
		move.l	#Obj_DecLevStartYGradual,(a1)

loc_81AFC:
		move.w	#$120,d0
		move.w	d0,(Camera_stored_max_Y_pos).w
		move.w	d0,(Camera_target_max_Y_pos).w
		jsr	(AllocateObject).l
		bne.s	loc_81B16
		move.l	#Obj_IncLevEndYGradual,(a1)

loc_81B16:
		move.w	(_unkFA8E).w,d0
		beq.s	locret_81B24
		movea.w	d0,a1
		bset	#2,$38(a1)

locret_81B24:
		rts
; ---------------------------------------------------------------------------

loc_81B26:
		jsr	Swing_UpAndDown(pc)
		jsr	(MoveSprite2).l
		move.w	#$40,d2
		move.w	#$60,d3
		movea.w	(_unkFA8E).w,a1
		move.b	x_vel(a1),d1
		bmi.s	loc_81B44
		moveq	#0,d1

loc_81B44:
		ext.w	d1
		neg.w	d1
		asr.w	#1,d1
		btst	#button_right,(Ctrl_1_held).w
		bne.s	loc_81B68
		move.w	x_pos(a0),d0
		addi.w	#2,d0
		add.w	d1,d0
		move.w	(Camera_max_X_pos).w,d1
		add.w	d2,d1
		cmp.w	d1,d0
		blo.s	loc_81B7C
		rts
; ---------------------------------------------------------------------------

loc_81B68:
		move.w	x_pos(a0),d0
		addi.w	#-2,d0
		add.w	d1,d0
		move.w	(Camera_min_X_pos).w,d1
		add.w	d3,d1
		cmp.w	d1,d0
		bls.s	loc_81B82

loc_81B7C:
		swap	d0
		move.l	d0,x_pos(a0)

loc_81B82:
		move.l	x_pos(a0),d0
		addi.l	#$70000,d0
		tst.b	$20(a0)
		beq.s	loc_81B98
		addi.l	#$80000,d0

loc_81B98:
		move.l	(Camera_min_X_pos).w,d1
		addi.l	#$600000,d1
		cmp.l	d1,d0
		blo.s	loc_81BB0
		addi.l	#$1500000,d1
		cmp.l	d1,d0
		blo.s	loc_81BB2

loc_81BB0:
		move.l	d1,d0

loc_81BB2:
		move.l	d0,x_pos(a0)
		bsr.w	sub_8307C
		bra.w	loc_82DCE
; ---------------------------------------------------------------------------

loc_81BBE:
		move.w	(_unkFAAE).w,d0
		sub.w	d0,x_pos(a0)
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_81BEA(pc,d0.w),d1
		jsr	off_81BEA(pc,d1.w)
		move.w	(_unkFA90).w,d0
		add.w	d0,x_pos(a0)
		move.w	x_pos(a0),(Events_bg+$02).w
		move.w	y_pos(a0),(Events_bg+$04).w
		rts
; ---------------------------------------------------------------------------
off_81BEA:
		dc.w loc_81BF2-off_81BEA
		dc.w loc_81C2C-off_81BEA
		dc.w loc_81C70-off_81BEA
		dc.w loc_81CA4-off_81BEA
; ---------------------------------------------------------------------------

loc_81BF2:
		move.w	(Camera_X_pos).w,d0
		addq.w	#1,d0
		move.w	d0,(Camera_X_pos).w
		addi.w	#$40,d0
		cmp.w	x_pos(a0),d0
		blo.s	locret_81C2A
		move.b	#2,routine(a0)
		bset	#4,$38(a0)
		move.w	#$40,$2E(a0)
		jsr	(AllocateObject).l
		bne.s	locret_81C2A
		move.l	#loc_8303E,(a1)
		move.w	a0,parent3(a1)

locret_81C2A:
		rts
; ---------------------------------------------------------------------------

loc_81C2C:
		move.b	(V_int_run_count+3).w,d0
		andi.b	#7,d0
		bne.s	loc_81C3E
		moveq	#signextendB(sfx_MissileExplode),d0
		jsr	(Play_SFX).l

loc_81C3E:
		addi.w	#$10,y_vel(a0)
		jsr	(MoveSprite2).l
		subq.w	#1,$2E(a0)
		bpl.s	locret_81C6E
		move.b	#4,routine(a0)
		jsr	(AllocateObject).l
		bne.s	locret_81C6E
		move.l	#loc_85E64,(a1)
		move.w	a1,$44(a0)
		move.w	#7,$3A(a1)

locret_81C6E:
		rts
; ---------------------------------------------------------------------------

loc_81C70:
		movea.w	(_unkFA8E).w,a1
		addq.w	#8,x_pos(a1)
		addi.w	#$10,y_vel(a0)
		jsr	(MoveSprite2).l
		movea.w	$44(a0),a1
		btst	#7,status(a1)
		beq.w	locret_82ABA
		move.b	#6,routine(a0)
		move.w	#$1F,$2E(a0)
		clr.b	(Super_palette_status).w
		rts
; ---------------------------------------------------------------------------

loc_81CA4:
		subq.w	#1,$2E(a0)
		bpl.w	locret_82ABA
		st	(SRAM_mask_interrupts_flag).w
		jsr	(SaveGame).l
		move.w	#$D01,d0
		jsr	(StartNewLevel).l
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_81CC6:
		lea	ObjDat3_83226(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		move.l	#loc_81D0E,(a0)
		move.b	$43(a0),$3C(a0)
		movea.w	parent3(a0),a1
		move.w	parent3(a1),$44(a0)
		lea	(Collected_emeralds_array).w,a1
		moveq	#3,d0
		moveq	#7-1,d1

loc_81CEC:
		cmp.b	(a1)+,d0
		bne.s	locret_81D0C
		dbf	d1,loc_81CEC
		st	$3A(a0)
		lea	(word_8141E).l,a1
		lea	(Palette_rotation_data).w,a2
		moveq	#bytesToLcnt($10),d0

loc_81D04:
		move.l	(a1)+,(a2)+
		dbf	d0,loc_81D04
		clr.w	(a2)

locret_81D0C:
		rts
; ---------------------------------------------------------------------------

loc_81D0E:
		movea.w	parent3(a0),a1
		move.b	mapping_frame(a1),d0
		subi.b	#$3A,d0
		move.b	$3C(a0),d1
		add.b	d0,d1
		move.b	d1,$43(a0)
		jsr	Refresh_ChildPosition(pc)
		tst.b	$3A(a0)
		beq.s	loc_81D32
		jsr	Run_PalRotationScript(pc)

loc_81D32:
		movea.w	$44(a0),a1
		btst	#4,$38(a1)
		bne.s	loc_81D44
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_81D44:
		move.l	#loc_81D4A,(a0)

loc_81D4A:
		move.w	(_unkFAAE).w,d0
		sub.w	d0,x_pos(a0)
		lea	(Player_1).w,a1
		move.w	x_pos(a1),d0
		cmp.w	x_pos(a0),d0
		blo.s	loc_81D64
		move.w	d0,x_pos(a0)

loc_81D64:
		move.w	(_unkFA90).w,d0
		add.w	d0,x_pos(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_81D72:
		lea	ObjDat3_8320E(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		move.l	#loc_81DCC,(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		add.w	d0,d0
		lea	word_81DB4(pc,d0.w),a1
		move.w	(a1)+,$42(a0)
		move.w	(a1)+,$44(a0)
		move.l	off_81DC0(pc,d0.w),$30(a0)
		lsr.w	#2,d0
		move.b	byte_81DB0(pc,d0.w),mapping_frame(a0)
		tst.w	d0
		bne.w	locret_82ABA
		lea	ChildObjDat_8327A(pc),a2
		jmp	CreateChild1_Normal(pc)
; ---------------------------------------------------------------------------
byte_81DB0:
		dc.b  $3A
		dc.b    5
		dc.b  $3D
		even
word_81DB4:
		dc.w    $64,   $4C
		dc.w    $10,   $20
		dc.w    $1C,   $8C
off_81DC0:
		dc.l byte_832D0
		dc.l 0
		dc.l byte_832D9
; ---------------------------------------------------------------------------

loc_81DCC:
		move.l	$30(a0),d0
		beq.s	loc_81DD8
		movea.l	d0,a1
		jsr	Animate_RawNoSSTMultiDelay(pc)

loc_81DD8:
		bsr.w	sub_82C86
		movea.w	parent3(a0),a1
		btst	#4,$38(a1)
		beq.s	loc_81E16
		move.l	#loc_81E28,(a0)
		bset	#7,status(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		add.w	d0,d0
		move.l	word_81E1C(pc,d0.w),x_vel(a0)	; and y_vel
		lea	(Child6_CreateBossExplosion).l,a2
		jsr	(CreateChild6_Simple).l
		bne.s	loc_81E16
		move.b	#4,subtype(a1)

loc_81E16:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
word_81E1C:
		dc.w    $80, -$200
		dc.w  -$100, -$100
		dc.w  -$200, -$300
; ---------------------------------------------------------------------------

loc_81E28:
		move.w	(_unkFAAE).w,d0
		sub.w	d0,x_pos(a0)
		move.w	(_unkFA90).w,d0
		add.w	d0,x_pos(a0)
		jmp	Obj_FlickerMove(pc)
; ---------------------------------------------------------------------------

loc_81E3C:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_81E50(pc,d0.w),d1
		jsr	off_81E50(pc,d1.w)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
off_81E50:
		dc.w loc_81E54-off_81E50
		dc.w loc_81E72-off_81E50
; ---------------------------------------------------------------------------

loc_81E54:
		lea	ObjDat3_831CC(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		move.w	a0,(_unkFAA4).w
		move.w	#$C0,$42(a0)
		move.w	#$4B,$44(a0)
		move.b	#7,collision_property(a0)

loc_81E72:
		bsr.w	sub_82C86
		bra.w	loc_82D18
; ---------------------------------------------------------------------------

loc_81E7A:
		bsr.w	sub_82C86
		jmp	Child_Draw_Sprite2(pc)
; ---------------------------------------------------------------------------

loc_81E82:
		lea	ObjDat3_831BA(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		move.l	#loc_81EB8,(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		add.w	d0,d0
		lea	word_81EAC(pc,d0.w),a1
		move.w	(a1)+,$42(a0)
		move.w	(a1)+,$44(a0)
		lsl.w	#2,d0
		move.w	d0,$2E(a0)
		rts
; ---------------------------------------------------------------------------
word_81EAC:
		dc.w    $90,   $60
		dc.w    $B0,   $58
		dc.w    $A8,   $78
; ---------------------------------------------------------------------------

loc_81EB8:
		movea.w	parent3(a0),a1
		btst	#3,$38(a1)
		beq.s	loc_81EDE
		move.l	#loc_81ECA,(a0)

loc_81ECA:
		subq.w	#1,$2E(a0)
		bpl.s	loc_81EDE
		move.w	#$60,$2E(a0)
		lea	ChildObjDat_8326E(pc),a2
		jsr	CreateChild6_Simple(pc)

loc_81EDE:
		move.b	(V_int_run_count+3).w,d0
		andi.b	#$F,d0
		bne.s	loc_81F0A
		movea.l	a0,a1
		lea	(Player_1).w,a2
		jsr	sub_8622C(pc)
		addi.b	#$10,d0
		lsr.b	#4,d0
		andi.w	#$FE,d0
		move.w	d0,angle(a0)
		lsr.w	#1,d0
		addi.b	#$1C,d0
		move.b	d0,mapping_frame(a0)

loc_81F0A:
		bsr.w	sub_82CD6
		moveq	#0,d0
		jmp	Child_Draw_Sprite_FlickerMove(pc)
; ---------------------------------------------------------------------------

loc_81F14:
		lea	word_831C6(pc),a1
		jsr	SetUp_ObjAttributes3(pc)
		move.l	#loc_81F26,(a0)
		bsr.w	sub_82CA4

loc_81F26:
		jsr	(MoveSprite2).l
		jsr	(sub_82BE4).l
		jmp	Sprite_CheckDeleteXY(pc)
; ---------------------------------------------------------------------------

loc_81F36:
		lea	ObjDat3_831D8(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		lea	word_81F5E(pc),a1

loc_81F42:
		move.l	#loc_81F6A,(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		add.w	d0,d0
		lea	(a1,d0.w),a1
		move.w	(a1)+,$42(a0)
		move.w	(a1)+,$44(a0)
		rts
; ---------------------------------------------------------------------------
word_81F5E:
		dc.w    $10,   $38
		dc.w    $10,   $87
		dc.w    $28,   $60
; ---------------------------------------------------------------------------

loc_81F6A:
		bsr.w	sub_82C86
		btst	#1,(V_int_run_count+3).w
		bne.s	loc_81F7A
		jmp	Child_Draw_Sprite(pc)
; ---------------------------------------------------------------------------

loc_81F7A:
		jmp	Child_CheckParent(pc)
; ---------------------------------------------------------------------------

loc_81F7E:
		lea	ObjDat3_831E4(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		lea	word_81F8C(pc),a1
		bra.s	loc_81F42
; ---------------------------------------------------------------------------
word_81F8C:
		dc.w   -$20,   $24
		dc.w   -$10,   $44
; ---------------------------------------------------------------------------

loc_81F94:
		bsr.w	sub_82C86
		tst.b	$39(a0)
		bpl.s	loc_81FDA
		move.w	(Player_1+x_pos).w,d0
		cmp.w	x_pos(a0),d0
		blo.s	loc_81FDA
		moveq	#2,d1
		move.b	d1,$39(a0)
		moveq	#0,d2

loc_81FB0:
		jsr	(AllocateObject).l
		bne.s	loc_81FDA
		move.l	#Obj_DDZMissile,(a1)
		move.b	#1,subtype(a1)
		move.w	a0,parent3(a1)
		move.b	d2,$39(a1)
		addq.w	#1,d2
		dbf	d1,loc_81FB0
		moveq	#signextendB(sfx_TubeLauncher),d0
		jsr	(Play_SFX).l

loc_81FDA:
		movea.w	parent3(a0),a1
		btst	#7,$2A(a1)
		beq.w	locret_82ABA
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

Obj_DDZMissile:
		lea	ObjDat_DDZMissile(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		lea	ChildObjDat_83250(pc),a2
		jsr	CreateChild6_Simple(pc)
		tst.b	subtype(a0)
		bne.s	loc_82014
		move.l	#loc_82038,(a0)
		move.w	#-$3FFA,$3C(a0)
		bra.w	sub_82AA6
; ---------------------------------------------------------------------------

loc_82014:
		move.l	#loc_82060,(a0)
		moveq	#0,d0
		move.b	$39(a0),d0
		add.w	d0,d0
		move.w	word_82032(pc,d0.w),d1
		add.w	d1,y_pos(a0)
		lsl.w	#3,d0
		move.w	d0,$2E(a0)
		bra.s	loc_81FDA
; ---------------------------------------------------------------------------
word_82032:
		dc.w      0,    -8,     8
; ---------------------------------------------------------------------------

loc_82038:
		tst.b	render_flags(a0)
		bpl.s	loc_8204C
		move.l	#loc_8204C,(a0)
		moveq	#signextendB(sfx_Dash),d0
		jsr	(Play_SFX).l

loc_8204C:
		move.w	(_unkFAAE).w,d0
		sub.w	d0,x_pos(a0)
		subq.w	#2,x_pos(a0)
		bsr.w	sub_82B06
		jmp	Sprite_CheckDelete(pc)
; ---------------------------------------------------------------------------

loc_82060:
		movea.w	parent3(a0),a1
		move.w	x_pos(a1),x_pos(a0)
		move.w	y_pos(a1),y_pos(a0)
		subq.w	#1,$2E(a0)
		bpl.s	loc_8209A
		move.l	#loc_8209E,(a0)
		move.b	#$40,$3C(a0)
		bsr.w	sub_82AA6
		move.w	#$200,x_vel(a0)
		move.w	#$B,$2E(a0)
		move.l	#loc_820B6,$34(a0)

loc_8209A:
		bra.w	loc_81FDA
; ---------------------------------------------------------------------------

loc_8209E:
		movea.w	parent3(a0),a1
		move.w	y_pos(a1),y_pos(a0)
		jsr	(MoveSprite2).l
		jsr	Obj_Wait(pc)
		jmp	Child_Draw_Sprite(pc)
; ---------------------------------------------------------------------------

loc_820B6:
		move.l	#loc_820D0,(a0)
		clr.b	routine(a0)
		move.w	#$1F,$2E(a0)
		move.l	#loc_820F8,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_820D0:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_820E8(pc,d0.w),d1
		jsr	off_820E8(pc,d1.w)
		bsr.w	sub_82B06
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
off_820E8:
		dc.w loc_820EE-off_820E8
		dc.w loc_82122-off_820E8
		dc.w loc_8213E-off_820E8
; ---------------------------------------------------------------------------

loc_820EE:
		jsr	(MoveSprite2).l
		jmp	Obj_Wait(pc)
; ---------------------------------------------------------------------------

loc_820F8:
		move.b	#2,routine(a0)
		move.w	#$1F,$2E(a0)
		bset	#7,art_tile(a0)
		move.w	#$180,priority(a0)
		moveq	#0,d0
		move.b	$39(a0),d0
		move.b	byte_8211E(pc,d0.w),$40(a0)
		rts
; ---------------------------------------------------------------------------
byte_8211E:
		dc.b    4,   2,  -2
		even
; ---------------------------------------------------------------------------

loc_82122:
		subq.w	#1,$2E(a0)
		bpl.s	loc_8212E
		move.b	#4,routine(a0)

loc_8212E:
		move.b	$40(a0),d0
		add.b	d0,$3C(a0)
		bsr.w	sub_82AA6
		bra.w	loc_82ABC
; ---------------------------------------------------------------------------

loc_8213E:
		bsr.w	sub_82A82
		bsr.w	sub_82AA6
		bra.w	loc_82ABC
; ---------------------------------------------------------------------------

loc_8214A:
		lea	word_831FC(pc),a1
		jsr	SetUp_ObjAttributes3(pc)
		move.l	#loc_8215C,(a0)
		bsr.w	sub_82AD8

loc_8215C:
		bsr.w	sub_82AD8

loc_82160:
		jsr	Child_GetPriority(pc)
		move.b	(V_int_run_count+3).w,d3
		andi.b	#7,d3
		bne.s	loc_82176
		lea	ChildObjDat_83256(pc),a2
		jsr	CreateChild6_Simple(pc)

loc_82176:
		btst	#1,d3
		bne.s	loc_82184
		jsr	Refresh_ChildPosition(pc)
		jmp	Child_Draw_Sprite(pc)
; ---------------------------------------------------------------------------

loc_82184:
		bclr	#7,render_flags(a0)
		jmp	Child_CheckParent(pc)
; ---------------------------------------------------------------------------

loc_8218E:
		lea	word_83202(pc),a1
		jsr	SetUp_ObjAttributes3(pc)
		move.l	#loc_821C2,(a0)
		move.l	#Go_Delete_Sprite,$34(a0)
		movea.w	parent3(a0),a1
		movea.w	parent3(a1),a1
		move.b	$3C(a1),d0
		jsr	(GetSineCosine).l
		neg.w	d0
		neg.w	d1
		move.w	d0,x_vel(a0)
		move.w	d1,y_vel(a0)

loc_821C2:
		move.w	(_unkFAAE).w,d0
		sub.w	d0,x_pos(a0)
		lea	byte_832B4(pc),a1
		jsr	Animate_RawNoSSTMultiDelay(pc)
		jsr	(MoveSprite2).l
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------

Obj_DDZAsteroid:
		move.l	#loc_821FC,(a0)
		move.l	#Map_DDZMissileAsteroid,mappings(a0)
		move.w	#make_art_tile($2DB,1,1),art_tile(a0)
		move.w	#0,priority(a0)
		bsr.w	sub_83146

loc_821FC:
		tst.w	(Debug_placement_mode).w
		bne.s	loc_82208
		jsr	(MoveSprite2).l

loc_82208:
		move.w	(_unkFAAE).w,d0
		sub.w	d0,x_pos(a0)
		tst.b	(Super_Sonic_Knux_flag).w
		beq.s	loc_82224
		lea	(Player_1).w,a1
		movea.l	$30(a0),a2
		jsr	Check_InMyRange(pc)
		bne.s	loc_8222A

loc_82224:
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------

loc_8222A:
		moveq	#signextendB(sfx_Collapse),d0
		jsr	(Play_SFX).l
		move.w	(_unkFA8E).w,d0
		beq.s	loc_82240
		movea.w	d0,a2
		move.w	#-$400,x_vel(a2)

loc_82240:
		move.l	(_unkFA82).w,d0
		move.l	#$10000,d1
		sub.l	d1,d0
		cmp.l	d1,d0
		bhs.s	loc_82252
		move.l	d1,d0

loc_82252:
		move.l	d0,(_unkFA82).w
		moveq	#0,d0
		move.b	subtype(a0),d0
		andi.b	#$F0,d0
		cmpi.b	#$20,d0
		bne.s	loc_822D8
		moveq	#0,d1
		move.w	y_pos(a0),d2
		sub.w	(Player_1+y_pos).w,d2
		smi	d3
		bpl.s	loc_82276
		neg.w	d2

loc_82276:
		cmpi.w	#$10,d2
		blo.s	loc_82284
		moveq	#4,d1
		tst.b	d3
		beq.s	loc_82284
		moveq	#8,d1

loc_82284:
		lea	off_82346(pc),a2
		movea.l	(a2,d1.w),a2
		moveq	#3-1,d4

loc_8228E:
		jsr	(AllocateObject).l
		bne.w	loc_82334
		move.l	#Obj_DDZAsteroid,(a1)
		move.w	x_pos(a0),d2
		add.w	(a2)+,d2
		move.w	d2,x_pos(a1)
		move.w	y_pos(a0),d3
		add.w	(a2)+,d3
		move.w	d3,y_pos(a1)
		move.b	subtype(a0),d0
		andi.b	#$F,d0
		addi.b	#$10,d0
		move.b	d0,subtype(a1)
		dbf	d4,loc_8228E
		lea	word_82376(pc),a1
		adda.w	d1,a1
		move.w	(a1)+,d1
		add.w	d1,x_pos(a0)
		move.w	(a1)+,d1
		add.w	d1,y_pos(a0)

loc_822D8:
		move.b	subtype(a0),d0
		andi.w	#$10,d0
		lsr.w	#2,d0
		lea	off_82382(pc),a2
		movea.l	(a2,d0.w),a2
		move.l	#loc_823EE,d1
		move.w	x_pos(a0),d2
		move.w	y_pos(a0),d3
		move.w	(a2)+,d4

loc_822FA:
		jsr	(AllocateObject).l
		bne.s	loc_82334
		move.l	d1,(a1)
		move.l	mappings(a0),mappings(a1)
		move.w	art_tile(a0),art_tile(a1)
		move.b	(a2)+,d5
		ext.w	d5
		add.w	d2,d5
		move.w	d5,x_pos(a1)
		move.b	(a2)+,d5
		ext.w	d5
		add.w	d3,d5
		move.w	d5,y_pos(a1)
		move.w	(a2)+,subtype(a1)
		move.w	(a2)+,x_vel(a1)
		move.w	(a2)+,y_vel(a1)
		dbf	d4,loc_822FA

loc_82334:
		move.w	respawn_addr(a0),d0
		beq.s	loc_82340
		movea.w	d0,a2
		bclr	#7,(a2)

loc_82340:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------
off_82346:
		dc.l word_82352
		dc.l word_8235E
		dc.l word_8236A
word_82352:
		dc.w      0, $FFE8
		dc.w    $18,     0
		dc.w      0,   $18
word_8235E:
		dc.w   -$18,     0
		dc.w      0,   $18
		dc.w    $18,     0
word_8236A:
		dc.w   -$18,     0
		dc.w      0,  -$18
		dc.w    $18,     0
word_82376:
		dc.w   -$10,     0
		dc.w      0,  -$18
		dc.w      0,   $18
off_82382:
		dc.l word_8238A
		dc.l word_823B4
word_8238A:
		dc.w 5-1
		dc.b   -8,   2
		dc.w      0,  -$80,  $140
		dc.b    8,  -4
		dc.w      0,  -$C0, -$100
		dc.b   -4,  -8
		dc.w   $100, -$100, -$200
		dc.b    8,   4
		dc.w   $100, -$200,  $100
		dc.b    4,   8
		dc.w   $100, -$180,  $280
word_823B4:
		dc.w 7-1
		dc.b  -$C,  -4
		dc.w      0,  -$80, -$180
		dc.b   -4,  $C
		dc.w      0, -$100,  $100
		dc.b    6,  -8
		dc.w      0,  -$C0,  -$80
		dc.b  -$C,  $C
		dc.w   $100, -$200,  $100
		dc.b   -4, -$C
		dc.w   $100, -$100,  -$80
		dc.b    8,   8
		dc.w   $100,  -$C0,   $60
		dc.b    0,   0
		dc.w   $100, -$140,   $80
; ---------------------------------------------------------------------------

loc_823EE:
		lea	word_83208(pc),a1
		jsr	SetUp_ObjAttributes3(pc)
		move.l	#loc_82412,(a0)
		move.l	#byte_832A8,$30(a0)
		tst.b	subtype(a0)
		beq.s	loc_82412
		move.l	#byte_832AE,$30(a0)

loc_82412:
		move.w	(_unkFAAE).w,d0
		sub.w	d0,x_pos(a0)
		jsr	Animate_Raw(pc)
		jsr	(MoveSprite2).l
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------

loc_8242A:
		lea	ObjDat3_8321A(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		move.l	#loc_82452,(a0)
		move.b	#6,mapping_frame(a0)
		move.l	#ArtUnc_SuperSonic_Stars,d1
		move.w	#tiles_to_bytes(ArtTile_Shield),d2
		move.w	#$1A0,d3
		jmp	(Add_To_DMA_Queue).l
; ---------------------------------------------------------------------------

loc_82452:
		tst.b	(Super_Sonic_Knux_flag).w
		beq.w	locret_82ABA
		move.w	(_unkFAAE).w,d0
		sub.w	d0,x_pos(a0)
		subq.w	#8,x_pos(a0)
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	loc_82494
		move.b	#1,anim_frame_timer(a0)
		move.b	mapping_frame(a0),d0
		addq.b	#1,d0
		cmpi.b	#6,d0
		blo.s	loc_82490
		moveq	#0,d0
		lea	(Player_1).w,a1
		move.w	x_pos(a1),x_pos(a0)
		move.w	y_pos(a1),y_pos(a0)

loc_82490:
		move.b	d0,mapping_frame(a0)

loc_82494:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_8249A:
		lea	ObjDat3_83232(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		move.l	#loc_824F4,(a0)
		move.w	#$400,x_vel(a0)
		move.b	(V_int_run_count+3).w,d0
		andi.w	#$18,d0
		moveq	#0,d1
		move.b	subtype(a0),d1
		add.w	d1,d0
		move.w	word_824D4(pc,d0.w),y_vel(a0)
		lsl.w	#3,d1
		move.w	d1,$2E(a0)
		move.w	(_unkFAAE).w,d0
		sub.w	d0,x_pos(a0)
		rts
; ---------------------------------------------------------------------------
word_824D4:
		dc.w  -$140
		dc.w  -$120
		dc.w   $100
		dc.w    $E0
		dc.w   -$C0
		dc.w   -$A0
		dc.w    $80
		dc.w    $60
		dc.w   -$80
		dc.w   -$60
		dc.w    $40
		dc.w    $20
		dc.w  -$100
		dc.w   -$E0
		dc.w    $C0
		dc.w    $A0
; ---------------------------------------------------------------------------

loc_824F4:
		move.w	(_unkFAAE).w,d0
		sub.w	d0,x_pos(a0)
		subq.w	#1,$2E(a0)
		bpl.w	locret_82ABA
		move.l	#loc_8253C,(a0)
		move.w	#$10,$2E(a0)
		movea.w	parent3(a0),a1
		move.w	x_pos(a1),d0
		addi.w	#$20,d0
		move.w	d0,x_pos(a0)
		move.w	y_pos(a1),d0
		addi.w	#$20,d0
		move.w	d0,y_pos(a0)
		moveq	#signextendB(sfx_TubeLauncher),d0
		jsr	(Play_SFX).l
		lea	ChildObjDat_83294(pc),a2
		jmp	CreateChild1_Normal(pc)
; ---------------------------------------------------------------------------

loc_8253C:
		subq.w	#1,$2E(a0)
		bpl.s	loc_82554
		move.l	#loc_8255C,(a0)
		move.w	#$180,priority(a0)
		bset	#7,$38(a0)

loc_82554:
		addq.w	#4,x_pos(a0)
		bra.w	loc_82568
; ---------------------------------------------------------------------------

loc_8255C:
		addi.w	#-$20,x_vel(a0)
		jsr	(MoveSprite2).l

loc_82568:
		lea	byte_832BF(pc),a1
		jsr	Animate_RawNoSST(pc)
		move.w	(_unkFA90).w,d0
		add.w	d0,x_pos(a0)
		move.w	(_unkFAAE).w,d0
		sub.w	d0,x_pos(a0)
		bsr.w	sub_82C28
		jmp	Sprite_CheckDelete(pc)
; ---------------------------------------------------------------------------

loc_82588:
		move.l	#loc_8259A,(a0)
		lea	word_8323E(pc),a1
		jsr	SetUp_ObjAttributes3(pc)
		jmp	Child_Draw_Sprite(pc)
; ---------------------------------------------------------------------------

loc_8259A:
		movea.w	parent3(a0),a1
		btst	#7,$38(a1)
		beq.s	loc_825AC
		move.w	#$100,priority(a0)

loc_825AC:
		lea	byte_832C3(pc),a1
		jsr	Animate_RawNoSSTMultiDelay(pc)
		jsr	Refresh_ChildPosition(pc)
		jmp	Child_Draw_Sprite(pc)
; ---------------------------------------------------------------------------

loc_825BC:
		move.l	#loc_82160,(a0)
		lea	word_831FC(pc),a1
		jmp	SetUp_ObjAttributes3(pc)
; ---------------------------------------------------------------------------

loc_825CA:
		lea	ObjDat3_83244(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		move.l	#loc_82606,(a0)
		movea.w	parent3(a0),a1
		move.w	x_pos(a0),d0
		addi.w	#$52,d0
		move.w	d0,x_pos(a0)
		move.w	y_pos(a0),d0
		addi.w	#$5A,d0
		move.w	d0,y_pos(a0)
		move.w	#$200,x_vel(a0)
		move.w	#$200,y_vel(a0)
		move.w	#4,$2E(a0)

loc_82606:
		move.w	(_unkFAAE).w,d0
		sub.w	d0,x_pos(a0)
		subq.w	#1,$2E(a0)
		bpl.s	loc_82632
		move.l	#loc_82652,(a0)
		move.w	#$80,priority(a0)
		bset	#7,art_tile(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		lsl.w	#3,d0
		move.w	d0,$2E(a0)

loc_82632:
		jsr	(MoveSprite2).l
		move.w	(_unkFA90).w,d0
		add.w	d0,x_pos(a0)
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.w	loc_83038
		jmp	Sprite_CheckDeleteXY(pc)
; ---------------------------------------------------------------------------

loc_82652:
		move.w	(_unkFAAE).w,d0
		sub.w	d0,x_pos(a0)
		subq.w	#1,$2E(a0)
		bpl.s	loc_82678
		addi.w	#-$40,x_vel(a0)
		move.w	y_vel(a0),d0
		addi.w	#-$20,d0
		bmi.s	loc_8268A
		move.w	d0,y_vel(a0)
		bra.w	loc_8268A
; ---------------------------------------------------------------------------

loc_82678:
		move.b	(V_int_run_count+3).w,d3
		andi.b	#7,d3
		bne.s	loc_8268A
		lea	ChildObjDat_832A2(pc),a2
		jsr	CreateChild6_Simple(pc)

loc_8268A:
		jsr	(MoveSprite2).l
		move.w	(_unkFA90).w,d0
		add.w	d0,x_pos(a0)
		bsr.w	sub_82C28
		jmp	Sprite_CheckDeleteXY(pc)
; ---------------------------------------------------------------------------

loc_826A0:
		lea	word_83202(pc),a1
		jsr	SetUp_ObjAttributes3(pc)
		move.l	#loc_821C2,(a0)
		move.l	#Go_Delete_Sprite,$34(a0)
		move.w	#-$200,x_vel(a0)
		move.w	#-$200,y_vel(a0)
		move.w	(_unkFAAE).w,d0
		sub.w	d0,x_pos(a0)
		rts
; ---------------------------------------------------------------------------

loc_826CC:
		lea	ObjDat_BossExplosion1(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		move.l	#loc_826E2,(a0)
		move.l	#Go_Delete_Sprite,$34(a0)

loc_826E2:
		movea.w	parent3(a0),a1
		tst.b	subtype(a1)
		beq.s	loc_826FC
		move.w	(_unkFAAE).w,d0
		sub.w	d0,x_pos(a0)
		move.w	(_unkFA90).w,d0
		add.w	d0,x_pos(a0)

loc_826FC:
		lea	(AniRaw_BossExplosion).l,a1
		jsr	Animate_RawNoSSTMultiDelay(pc)
		move.w	$3A(a0),d0
		add.w	d0,x_vel(a0)
		move.w	$3C(a0),d0
		add.w	d0,y_vel(a0)
		jsr	(MoveSprite2).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_82722:
		move.w	$3A(a0),d1
		moveq	#0,d0
		cmpi.w	#10,(Ring_count).w
		bhi.s	loc_82732
		moveq	#8,d0

loc_82732:
		cmp.w	d1,d0
		beq.w	locret_82ABA
		move.w	d0,$3A(a0)
		jmp	(Change_Music_Tempo).l

; =============== S U B R O U T I N E =======================================


sub_82742:
		btst	#7,$38(a0)
		beq.s	locret_82750
		tst.b	(Super_Sonic_Knux_flag).w
		beq.s	loc_82752

locret_82750:
		rts
; ---------------------------------------------------------------------------

loc_82752:
		move.l	#loc_8179E,(a0)
		clr.w	x_vel(a0)
		clr.w	y_vel(a0)
		lea	(Player_1).w,a1
		move.b	#$81,object_control(a1)
		move.b	#$1A,anim(a1)
		rts
; End of function sub_82742


; =============== S U B R O U T I N E =======================================


sub_82772:
		lea	(Player_1).w,a1
		tst.b	invulnerability_timer(a1)
		beq.s	loc_827A0
		addi.b	#$10,angle(a1)
		cmpi.b	#30,invulnerability_timer(a1)
		blo.s	loc_827A8
		clr.w	x_vel(a0)
		clr.w	y_vel(a0)
		move.l	(_unkFA82).w,d2
		lsr.l	#8,d2
		neg.w	d2
		moveq	#0,d3
		bra.w	loc_82828
; ---------------------------------------------------------------------------

loc_827A0:
		clr.b	angle(a1)
		clr.b	status(a1)

loc_827A8:
		moveq	#0,d2
		moveq	#0,d3
		moveq	#$40,d0
		move.w	x_vel(a0),d2
		beq.s	loc_827CA
		bmi.s	loc_827C0
		neg.w	d0
		add.w	d0,d2
		bpl.s	loc_827C6
		bra.w	loc_827C4
; ---------------------------------------------------------------------------

loc_827C0:
		add.w	d0,d2
		bmi.s	loc_827C6

loc_827C4:
		moveq	#0,d2

loc_827C6:
		move.w	d2,x_vel(a0)

loc_827CA:
		moveq	#$40,d0
		move.w	y_vel(a0),d3
		beq.s	loc_827E8
		bmi.s	loc_827DE
		neg.w	d0
		add.w	d0,d3
		bpl.s	loc_827E4
		bra.w	loc_827E2
; ---------------------------------------------------------------------------

loc_827DE:
		add.w	d0,d3
		bmi.s	loc_827E4

loc_827E2:
		moveq	#0,d3

loc_827E4:
		move.w	d3,y_vel(a0)

loc_827E8:
		lea	(Ctrl_1).w,a2
		tst.w	(a2)
		beq.s	loc_82828
		tst.b	(Ctrl_1_locked).w
		bne.s	loc_82828
		move.b	(a2)+,d0
		move.b	(a2)+,d1
		andi.w	#button_up_mask|button_down_mask|button_left_mask|button_right_mask,d0
		lsl.w	#2,d0
		andi.w	#button_A_mask|button_B_mask|button_C_mask,d1
		beq.s	loc_8281A
		tst.b	invulnerability_timer(a1)
		bne.s	loc_8281A
		movem.w	word_82872(pc,d0.w),d2-d3
		move.w	d2,x_vel(a0)
		move.w	d3,y_vel(a0)

loc_8281A:
		tst.w	d0
		beq.s	loc_82828
		movem.w	word_82832(pc,d0.w),d4-d5
		add.w	d4,d2
		add.w	d5,d3

loc_82828:
		move.w	d2,x_vel(a1)
		move.w	d3,y_vel(a1)
		rts
; End of function sub_82772

; ---------------------------------------------------------------------------
word_82832:	; neither A, B, nor C are pressed
		dc.w      0,     0	; no D-pad
		dc.w      0, -$300	; up
		dc.w      0,  $300	; down
		dc.w      0,     0	; up + down (shouldn't happen)
		dc.w  -$300,     0	; left
		dc.w  -$21F, -$21F	; left + up
		dc.w  -$21F,  $21F	; left + down
		dc.w      0,     0	; left + up + down (shouldn't happen)
		dc.w   $300,     0	; right
		dc.w   $21F, -$21F	; right + up
		dc.w   $21F,  $21F	; right + down
		dc.w      0,     0	; right + up + down (shouldn't happen)
		dc.w      0,     0	; left + right(shouldn't happen)
		dc.w      0,     0	; left + right + up (shouldn't happen)
		dc.w      0,     0	; left + right + down (shouldn't happen)
		dc.w      0,     0	; left + right + up + down (shouldn't happen)
word_82872:	; either A, B, or C is pressed
		dc.w   $600,     0	; no D-pad
		dc.w      0, -$600	; up
		dc.w      0,  $600	; down
		dc.w      0,     0	; up + down (shouldn't happen)
		dc.w  -$600,     0	; left
		dc.w  -$43E, -$43E	; left + up
		dc.w  -$43E,  $43E	; left + down
		dc.w      0,     0	; left + up + down (shouldn't happen)
		dc.w   $600,     0	; right
		dc.w   $43E, -$43E	; right + up
		dc.w   $43E,  $43E	; right + down
		dc.w      0,     0	; right + up + down (shouldn't happen)
		dc.w      0,     0	; left + right (shouldn't happen)
		dc.w      0,     0	; left + right + up (shouldn't happen)
		dc.w      0,     0	; left + right + down (shouldn't happen)
		dc.w      0,     0	; left + right + up + down (shouldn't happen)

; =============== S U B R O U T I N E =======================================


sub_828B2:
		tst.w	d2
		beq.s	loc_828EE
		move.l	x_pos(a0),d0
		move.w	(Camera_X_pos).w,d1
		ext.l	d2
		lsl.l	#8,d2
		add.l	d2,d0
		swap	d0
		move.w	(_unkFAB4).w,d4
		add.w	d4,d1
		cmp.w	d1,d0
		blo.s	loc_828EE
		move.w	(_unkFAB6).w,d5
		sub.w	d4,d5
		add.w	d5,d1
		bset	#1,$38(a0)
		cmp.w	d1,d0
		bhs.s	loc_828EE
		bclr	#1,$38(a0)
		swap	d0
		move.l	d0,x_pos(a0)

loc_828EE:
		tst.w	d3
		beq.s	locret_8291E
		move.l	y_pos(a0),d0
		move.w	(Camera_Y_pos).w,d1
		ext.l	d3
		lsl.l	#8,d3
		add.l	d3,d0
		swap	d0
		move.w	(_unkFAB0).w,d4
		add.w	d4,d1
		cmp.w	d1,d0
		blo.s	locret_8291E
		move.w	(_unkFAB2).w,d5
		sub.w	d4,d5
		add.w	d5,d1
		cmp.w	d1,d0
		bhs.s	locret_8291E
		swap	d0
		move.l	d0,y_pos(a0)

locret_8291E:
		rts
; End of function sub_828B2


; =============== S U B R O U T I N E =======================================


sub_82920:
		move.l	(_unkFA82).w,d0
		add.l	(_unkFA8A).w,d0
		move.l	#$60000,d2
		move.w	(_unkFA8E).w,d1
		beq.s	loc_82952
		movea.w	d1,a1
		btst	#1,$38(a1)
		beq.s	loc_82952
		move.w	x_vel(a1),d1
		bmi.s	loc_82952
		beq.s	loc_82952
		ext.l	d1
		lsl.l	#4,d1
		add.l	d1,d0
		move.l	#$80000,d2

loc_82952:
		cmp.l	d2,d0
		ble.s	loc_82958
		move.l	d2,d0

loc_82958:
		cmpi.l	#$10000,d0
		ble.s	loc_82964
		move.l	d0,(_unkFA82).w

loc_82964:
		move.l	(Camera_X_pos).w,d1
		move.l	d1,d2
		add.l	d0,d1
		andi.l	#$7FFFFFFF,d1
		move.l	d1,(Camera_X_pos).w
		swap	d0
		add.w	d0,(Events_bg+$06).w
		swap	d1
		swap	d2
		move.w	d1,(Camera_min_X_pos).w
		move.w	$3C(a0),d3
		add.w	d1,d3
		move.w	d3,(Camera_max_X_pos).w
		sub.w	d2,d1
		move.w	d1,(_unkFA90).w
		move.w	x_pos(a0),d2
		add.w	d1,d2
		move.w	d2,x_pos(a0)
		rts
; End of function sub_82920


; =============== S U B R O U T I N E =======================================


sub_829A0:
		move.l	(_unkFA82).w,d0
		add.l	(_unkFA8A).w,d0
		cmpi.l	#$60000,d0
		bhi.s	loc_829B4
		move.l	d0,(_unkFA82).w

loc_829B4:
		move.l	(_unkFA86).w,d1
		move.l	d1,d2
		add.l	d0,d1
		move.l	d1,(_unkFA86).w
		swap	d0
		add.w	d0,(Events_bg+$06).w
		swap	d1
		swap	d2
		sub.w	d2,d1
		move.w	d1,(_unkFA90).w
		rts
; End of function sub_829A0


; =============== S U B R O U T I N E =======================================


sub_829D2:
		lea	(Player_1).w,a1
		move.w	(Camera_X_pos).w,d0
		move.w	d0,d1
		move.w	x_pos(a0),d2
		move.w	d2,x_pos(a1)
		btst	#3,$38(a0)
		beq.s	loc_82A2E
		move.w	d2,d3
		addi.w	#$80,d0
		sub.w	d0,d2
		bcc.s	loc_82A10
		add.w	d2,d1
		cmp.w	(Camera_min_X_pos).w,d1
		blt.s	loc_82A06
		move.w	d1,(Camera_X_pos).w
		bra.w	loc_82A2E
; ---------------------------------------------------------------------------

loc_82A06:
		move.w	(Camera_min_X_pos).w,(Camera_X_pos).w
		bra.w	loc_82A2E
; ---------------------------------------------------------------------------

loc_82A10:
		addi.w	#$20,d0
		sub.w	d0,d3
		bls.s	loc_82A2E
		add.w	d3,d1
		cmp.w	(Camera_max_X_pos).w,d1
		bge.s	loc_82A28
		move.w	d1,(Camera_X_pos).w
		bra.w	loc_82A2E
; ---------------------------------------------------------------------------

loc_82A28:
		move.w	(Camera_max_X_pos).w,(Camera_X_pos).w

loc_82A2E:
		move.w	(Camera_Y_pos).w,d0
		move.w	d0,d1
		move.w	y_pos(a0),d2
		move.w	d2,y_pos(a1)
		btst	#2,$38(a0)
		beq.s	locret_82A80
		move.w	d2,d3
		addi.w	#$60,d0
		sub.w	d0,d2
		bcc.s	loc_82A64
		add.w	d2,d1
		cmp.w	(Camera_min_Y_pos).w,d1
		blt.s	loc_82A5C
		move.w	d1,(Camera_Y_pos).w
		rts
; ---------------------------------------------------------------------------

loc_82A5C:
		move.w	(Camera_min_Y_pos).w,(Camera_Y_pos).w
		rts
; ---------------------------------------------------------------------------

loc_82A64:
		addi.w	#$20,d0
		sub.w	d0,d3
		ble.s	locret_82A80
		add.w	d3,d1
		cmp.w	(Camera_max_Y_pos).w,d1
		bge.s	loc_82A7A
		move.w	d1,(Camera_Y_pos).w
		rts
; ---------------------------------------------------------------------------

loc_82A7A:
		move.w	(Camera_max_Y_pos).w,(Camera_Y_pos).w

locret_82A80:
		rts
; End of function sub_829D2


; =============== S U B R O U T I N E =======================================


sub_82A82:
		move.b	(V_int_run_count+3).w,d0
		andi.b	#3,d0
		beq.s	locret_82AA4
		movea.l	a0,a1
		lea	(Player_1).w,a2
		jsr	sub_8622C(pc)
		moveq	#2,d1
		sub.b	$3C(a0),d0
		bpl.s	loc_82AA0
		neg.w	d1

loc_82AA0:
		add.b	d1,$3C(a0)

locret_82AA4:
		rts
; End of function sub_82A82


; =============== S U B R O U T I N E =======================================


sub_82AA6:
		move.b	$3C(a0),d0
		addi.b	#$10,d0
		lsr.b	#5,d0
		move.b	d0,$3D(a0)
		addq.b	#8,d0
		move.b	d0,mapping_frame(a0)

locret_82ABA:
		rts
; End of function sub_82AA6

; ---------------------------------------------------------------------------

loc_82ABC:
		move.b	$3C(a0),d0
		jsr	(GetSineCosine).l
		add.w	d0,d0
		add.w	d1,d1
		move.w	d0,x_vel(a0)
		move.w	d1,y_vel(a0)
		jmp	(MoveSprite2).l

; =============== S U B R O U T I N E =======================================


sub_82AD8:
		movea.w	parent3(a0),a1
		moveq	#0,d0
		move.b	$3D(a1),d0
		move.b	#$10,mapping_frame(a0)
		add.b	d0,mapping_frame(a0)
		add.w	d0,d0
		move.w	byte_82AF6(pc,d0.w),child_dx(a0)	; and child_dy
		rts
; End of function sub_82AD8

; ---------------------------------------------------------------------------
byte_82AF6:
		dc.b    0,-$20
		dc.b -$16,-$16
		dc.b -$20,   0
		dc.b -$16, $16
		dc.b    0, $20
		dc.b  $16, $16
		dc.b  $20,   0
		dc.b  $16,-$16
		even

; =============== S U B R O U T I N E =======================================


sub_82B06:
		tst.b	(Super_Sonic_Knux_flag).w
		beq.s	locret_82B60
		tst.b	render_flags(a0)
		bpl.s	loc_82B30
		tst.b	subtype(a0)
		beq.s	loc_82B30
		move.w	(_unkFAA4).w,d0
		beq.s	loc_82B30
		movea.w	d0,a1
		tst.b	collision_flags(a1)
		bne.s	loc_82B30
		lea	word_82BB4(pc),a2
		jsr	Check_InTheirRange(pc)
		bne.s	loc_82B62

loc_82B30:
		lea	(Player_1).w,a1
		tst.b	invulnerability_timer(a1)
		bne.s	loc_82B50
		moveq	#0,d0
		move.b	$3D(a0),d0
		add.w	d0,d0
		move.w	off_82BBC(pc,d0.w),d1
		lea	off_82BBC(pc,d1.w),a2
		jsr	Check_InMyRange(pc)
		bne.s	loc_82B6E

loc_82B50:
		move.w	parent3(a0),d0
		beq.s	locret_82B60
		movea.w	d0,a1
		btst	#7,status(a1)
		bne.s	loc_82B84

locret_82B60:
		rts
; ---------------------------------------------------------------------------

loc_82B62:
		subq.b	#1,collision_property(a1)
		st	collision_flags(a1)
		bra.w	loc_82B78
; ---------------------------------------------------------------------------

loc_82B6E:
		lea	(Player_1).w,a1
		move.b	#90-1,invulnerability_timer(a1)

loc_82B78:
		move.w	parent3(a0),d0
		beq.s	loc_82B84
		movea.w	d0,a1
		subq.b	#1,$39(a1)

loc_82B84:
		move.l	#Wait_Draw,(a0)
		move.w	#3,$2E(a0)
		move.l	#loc_85088,$34(a0)
		lea	(Child6_CreateBossExplosion).l,a2
		jsr	(CreateChild6_Simple).l
		bne.s	loc_82BAC
		move.b	#6,subtype(a1)

loc_82BAC:
		bset	#7,status(a0)
		rts
; End of function sub_82B06

; ---------------------------------------------------------------------------
word_82BB4:
		dc.w      0,   $38,  -$2C,   $18
off_82BBC:
		dc.w word_82BCC-off_82BBC
		dc.w word_82BD4-off_82BBC
		dc.w word_82BDC-off_82BBC
		dc.w word_82BD4-off_82BBC
		dc.w word_82BCC-off_82BBC
		dc.w word_82BD4-off_82BBC
		dc.w word_82BDC-off_82BBC
		dc.w word_82BD4-off_82BBC
word_82BCC:
		dc.w   -$18,   $30,  -$24,   $48
word_82BD4:
		dc.w   -$1C,   $38,  -$1C,   $38
word_82BDC:
		dc.w   -$24,   $48,  -$18,   $30

; =============== S U B R O U T I N E =======================================


sub_82BE4:
		tst.b	(Super_Sonic_Knux_flag).w
		beq.s	locret_82C1E
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.s	loc_82C18
		lea	(Player_1).w,a1
		tst.b	invulnerability_timer(a1)
		bne.s	locret_82C1E
		lea	word_82C20(pc),a2
		jsr	Check_InMyRange(pc)
		beq.s	locret_82C1E
		move.b	#60-1,invulnerability_timer(a1)
		moveq	#signextendB(sfx_Explode),d0
		jsr	(Play_SFX).l

loc_82C18:
		jsr	(Go_Delete_Sprite).l

locret_82C1E:
		rts
; End of function sub_82BE4

; ---------------------------------------------------------------------------
word_82C20:
		dc.w   -$10,   $20,  -$10,   $20

; =============== S U B R O U T I N E =======================================


sub_82C28:
		tst.b	(Super_Sonic_Knux_flag).w
		beq.s	locret_82C4E
		lea	(Player_1).w,a1
		tst.b	invulnerability_timer(a1)
		lea	word_82C62(pc),a2
		jsr	Check_InMyRange(pc)
		bne.s	loc_82C50
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.w	loc_82B84

locret_82C4E:
		rts
; ---------------------------------------------------------------------------

loc_82C50:
		lea	(Player_1).w,a1
		move.b	#90-1,invulnerability_timer(a1)
		bsr.w	sub_82C6A
		bra.w	loc_82B84
; End of function sub_82C28

; ---------------------------------------------------------------------------
word_82C62:
		dc.w   -$10,   $20,  -$10,   $20

; =============== S U B R O U T I N E =======================================


sub_82C6A:
		move.l	(_unkFA82).w,d0
		move.l	#$10000,d1
		subi.l	#$30000,d0
		cmp.l	d1,d0
		bge.s	loc_82C80
		move.l	d1,d0

loc_82C80:
		move.l	d0,(_unkFA82).w
		rts
; End of function sub_82C6A


; =============== S U B R O U T I N E =======================================


sub_82C86:
		movea.w	parent3(a0),a1
		move.w	x_pos(a1),d0
		move.w	y_pos(a1),d1
		add.w	$42(a0),d0
		add.w	$44(a0),d1
		move.w	d0,x_pos(a0)
		move.w	d1,$14(a0)
		rts
; End of function sub_82C86


; =============== S U B R O U T I N E =======================================


sub_82CA4:
		movea.w	parent3(a0),a1
		move.w	angle(a1),d0
		add.w	d0,d0
		move.l	word_82CB6(pc,d0.w),x_vel(a0)	; and y_vel
		rts
; End of function sub_82CA4

; ---------------------------------------------------------------------------
word_82CB6:
		dc.w      0,  $400
		dc.w   $2D4,  $2D4
		dc.w   $400,     0
		dc.w   $2D4, -$2D4
		dc.w      0, -$400
		dc.w  -$2D4, -$2D4
		dc.w  -$400,     0
		dc.w  -$2D4,  $2D4

; =============== S U B R O U T I N E =======================================


sub_82CD6:
		move.w	angle(a0),d0
		lea	byte_82D08(pc,d0.w),a1
		movea.w	parent3(a0),a2
		move.b	(a1)+,d1
		ext.w	d1
		move.w	x_pos(a2),d2
		add.w	$42(a0),d2
		add.w	d1,d2
		move.w	d2,x_pos(a0)
		move.b	(a1)+,d1
		ext.w	d1
		move.w	y_pos(a2),d2
		add.w	$44(a0),d2
		add.w	d1,d2
		move.w	d2,y_pos(a0)
		rts
; End of function sub_82CD6

; ---------------------------------------------------------------------------
byte_82D08:
		dc.b    0,   8
		dc.b    8,   8
		dc.b    8,   0
		dc.b    8,  -8
		dc.b    0,  -8
		dc.b   -8,  -8
		dc.b   -8,   0
		dc.b   -8,   8
		even
; ---------------------------------------------------------------------------

loc_82D18:
		tst.b	(Super_Sonic_Knux_flag).w
		beq.s	locret_82D5A
		tst.b	collision_flags(a0)
		beq.s	locret_82D5A
		tst.b	collision_property(a0)
		bmi.s	loc_82D5C
		tst.b	$20(a0)
		bne.s	loc_82D3E
		move.b	#$20,$20(a0)
		moveq	#signextendB(sfx_ThumpBoss),d0
		jsr	(Play_SFX).l

loc_82D3E:
		moveq	#0,d0
		btst	#0,$20(a0)
		bne.s	loc_82D4C
		addi.w	#2*$C,d0

loc_82D4C:
		bsr.w	sub_82D72
		subq.b	#1,$20(a0)
		bne.s	locret_82D5A
		clr.b	collision_flags(a0)

locret_82D5A:
		rts
; ---------------------------------------------------------------------------

loc_82D5C:
		moveq	#100,d0
		jsr	(HUD_AddToScore).l
		bset	#7,status(a0)
		move.l	#loc_81E7A,(a0)
		rts


; =============== S U B R O U T I N E =======================================


sub_82D72:
		lea	word_82D86(pc),a1
		lea	word_82D9E(pc,d0.w),a2
		moveq	#$C-1,d1

.loop:
		movea.w	(a1)+,a3
		move.w	(a2)+,(a3)+
		dbf	d1,.loop
		rts
; End of function sub_82D72

; ---------------------------------------------------------------------------
word_82D86:
		dc.w Normal_palette_line_3+$06, Normal_palette_line_3+$08, Normal_palette_line_3+$0C
		dc.w Normal_palette_line_3+$0E, Normal_palette_line_3+$10, Normal_palette_line_3+$12
		dc.w Normal_palette_line_3+$14, Normal_palette_line_3+$16, Normal_palette_line_3+$18
		dc.w Normal_palette_line_3+$1A, Normal_palette_line_3+$1C, Normal_palette_line_3+$1E
word_82D9E:
		dc.w     $A,     6,  $CAA,  $A88,  $866,  $444,  $E42,  $E00,  $C00,  $600,  $200,     0
		dc.w   $888,  $AAA,  $CCC,  $AAA,  $888,  $666,  $ECC,  $ECA,  $AAA,  $AAA,  $CCC,  $EEE
; ---------------------------------------------------------------------------

loc_82DCE:
		tst.b	(Super_Sonic_Knux_flag).w
		beq.s	locret_82E2A
		tst.b	$20(a0)
		bne.s	loc_82E14
		lea	(Player_1).w,a1
		lea	word_82E92(pc),a2
		jsr	Check_InMyRange(pc)
		beq.s	locret_82E2A
		subq.b	#1,collision_property(a0)
		bmi.s	loc_82E2C
		move.b	#$20,$20(a0)
		move.b	#90,(Player_1+invulnerability_timer).w
		moveq	#signextendB(sfx_BossHit),d0
		jsr	(Play_SFX).l
		bsr.w	sub_82C6A
		move.w	(_unkFA8E).w,d0
		beq.s	loc_82E14
		movea.w	d0,a1
		move.w	#-$1000,x_vel(a1)

loc_82E14:
		moveq	#0,d0
		btst	#0,$20(a0)
		bne.s	loc_82E22
		addi.w	#2*$C,d0

loc_82E22:
		bsr.w	sub_82D72
		subq.b	#1,$20(a0)

locret_82E2A:
		rts
; ---------------------------------------------------------------------------

loc_82E2C:
		moveq	#100,d0
		jsr	(HUD_AddToScore).l
		move.l	#loc_81BBE,(a0)
		clr.b	routine(a0)
		bset	#7,status(a0)
		st	(Ctrl_1_locked).w
		move.w	#$7FFF,(Super_frame_count).w
		move.w	(Camera_Y_pos).w,d0
		move.w	d0,(Camera_min_Y_pos).w
		move.w	d0,(Camera_max_Y_pos).w
		move.w	(_unkFA8E).w,d0
		beq.s	loc_82E72
		movea.w	d0,a1
		bclr	#2,$38(a1)
		move.w	#-$400,x_vel(a1)
		clr.w	y_vel(a1)

loc_82E72:
		jsr	(AllocateObject).l
		bne.s	locret_82E2A
		move.l	#loc_82F1C,(a1)
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		move.w	a0,parent3(a1)
		rts
; ---------------------------------------------------------------------------
word_82E92:
		dc.w    $20,   $40,   $20,   $40
; ---------------------------------------------------------------------------

loc_82E9A:
		bsr.w	sub_82C86
		subq.w	#1,$2E(a0)
		bpl.s	loc_82EEE
		moveq	#$18,d0
		bsr.w	sub_82D72
		moveq	#signextendB(sfx_MissileExplode),d0
		jsr	(Play_SFX).l
		move.w	#$1F,$2E(a0)
		moveq	#0,d1
		move.b	$39(a0),d1
		lea	word_82EF4(pc,d1.w),a2
		jsr	(AllocateObject).l
		bne.s	loc_82EDC
		move.l	#loc_82F78,(a1)
		move.w	a0,parent3(a1)
		move.w	(a2)+,$42(a1)
		move.w	(a2)+,$44(a1)

loc_82EDC:
		addq.b	#4,d1
		cmpi.b	#$28,d1
		bhs.s	loc_82EEA
		move.b	d1,$39(a0)
		rts
; ---------------------------------------------------------------------------

loc_82EEA:
		jsr	Go_Delete_Sprite(pc)

loc_82EEE:
		moveq	#0,d0
		bra.w	sub_82D72
; ---------------------------------------------------------------------------
word_82EF4:
		dc.w    $C0,   $38
		dc.w    $78,   $80
		dc.w    $B0,   $78
		dc.w    $58,   $40
		dc.w    $98,   $60
		dc.w    $E0,   $70
		dc.w    $C8,   $40
		dc.w    $70,   $80
		dc.w    $98,   $70
		dc.w    $50,   $40
; ---------------------------------------------------------------------------

loc_82F1C:
		bsr.w	sub_82C86
		subq.w	#1,$2E(a0)
		bpl.s	locret_82F6A
		move.w	#$1F,$2E(a0)
		moveq	#signextendB(sfx_MissileExplode),d0
		jsr	(Play_SFX).l
		moveq	#0,d1
		move.b	$39(a0),d1
		lea	word_82F6C(pc,d1.w),a2
		jsr	(AllocateObject).l
		bne.s	loc_82F5C
		move.l	#loc_82F78,(a1)
		move.w	a0,parent3(a1)
		move.w	(a2)+,$42(a1)
		move.w	(a2)+,$44(a1)
		st	subtype(a1)

loc_82F5C:
		addq.b	#4,d1
		cmpi.b	#$C,d1
		bhs.w	loc_83038
		move.b	d1,$39(a0)

locret_82F6A:
		rts
; ---------------------------------------------------------------------------
word_82F6C:
		dc.w    $50,   $48
		dc.w    $30,   $30
		dc.w    $30,   $68
; ---------------------------------------------------------------------------

loc_82F78:
		bsr.w	sub_82C86
		moveq	#0,d0
		move.b	$39(a0),d0
		cmpi.b	#$30,d0
		bhs.w	loc_83038
		addq.b	#2,$39(a0)
		lea	byte_82FD4(pc,d0.w),a2
		jsr	(AllocateObject).l
		bne.s	locret_82FD2
		move.l	#loc_826CC,(a1)
		move.w	a0,parent3(a1)
		move.w	x_pos(a0),d0
		move.b	(a2)+,d1
		ext.w	d1
		add.w	d1,d0
		move.w	d0,x_pos(a1)
		move.w	y_pos(a0),d0
		move.b	(a2)+,d1
		ext.w	d1
		add.w	d1,d0
		move.w	d0,y_pos(a1)
		asr.w	#4,d1
		move.w	d1,y_vel(a1)
		move.w	#$100,x_vel(a1)
		move.w	#-$100,$3A(a1)

locret_82FD2:
		rts
; ---------------------------------------------------------------------------
byte_82FD4:
		dc.b    0,   0
		dc.b -$10,  -8
		dc.b    0,   8
		dc.b    8,  -8
		dc.b -$10,   8
		dc.b    0,-$10
		dc.b -$10,-$18
		dc.b  $10,   8
		dc.b  $10,-$10
		dc.b -$18,   0
		dc.b   -8,-$20
		dc.b  $18,   0
		dc.b   -8, $10
		dc.b -$20,-$10
		dc.b    8,-$20
		dc.b    8, $18
		dc.b -$18,-$20
		dc.b -$20, $10
		dc.b  $20,-$10
		dc.b  $20, $10
		dc.b  $18,-$28
		dc.b -$28,  -8
		dc.b -$10, $20
		dc.b  $28,   0
		even
; ---------------------------------------------------------------------------

loc_83004:
		move.l	#loc_8302A,(a0)
		move.w	#$90,$42(a0)
		move.w	#$60,$44(a0)
		lea	(Child6_CreateBossExplosion).l,a2
		jsr	(CreateChild6_Simple).l
		bne.s	loc_8302A
		move.b	#$1C,subtype(a1)

loc_8302A:
		movea.w	parent3(a0),a1
		btst	#4,$38(a1)
		beq.w	sub_82C86

loc_83038:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_8303E:
		move.l	#loc_83078,(a0)
		move.w	#$40,$42(a0)
		move.w	#$40,$44(a0)
		lea	(Child6_CreateBossExplosion).l,a2
		jsr	(CreateChild6_Simple).l
		bne.s	loc_83064
		move.b	#$E,subtype(a1)

loc_83064:
		lea	(Child6_CreateBossExplosion).l,a2
		jsr	(CreateChild6_Simple).l
		bne.s	loc_83078
		move.b	#$E,subtype(a1)

loc_83078:
		bra.w	sub_82C86

; =============== S U B R O U T I N E =======================================


sub_8307C:
		move.w	(Camera_X_pos).w,d0
		addi.w	#$140,d0
		cmp.w	x_pos(a0),d0
		blo.w	locret_82ABA
		subq.w	#1,$2E(a0)
		bpl.w	locret_82ABA
		move.w	#$82,$2E(a0)
		move.w	y_pos(a0),d0
		addi.w	#$68,d0
		cmp.w	(Player_1+y_pos).w,d0
		bhs.s	loc_830B8
		moveq	#signextendB(sfx_BossProjectile),d0
		jsr	(Play_SFX).l
		lea	ChildObjDat_83288(pc),a2
		jmp	CreateChild6_Simple(pc)
; ---------------------------------------------------------------------------

loc_830B8:
		lea	ChildObjDat_8328E(pc),a2
		jmp	CreateChild6_Simple(pc)
; End of function sub_8307C


; =============== S U B R O U T I N E =======================================


sub_830C0:
		movea.w	(_unkFA8E).w,a1
		move.b	x_vel(a1),d1
		ext.w	d1
		neg.w	d1
		asr.w	#1,d1
		btst	#button_right,(Ctrl_1_held).w
		bne.s	loc_830EC
		move.w	x_pos(a0),d0
		addi.w	#2,d0
		add.w	d1,d0
		move.w	(Camera_max_X_pos).w,d1
		add.w	d2,d1
		cmp.w	d1,d0
		blo.s	loc_83100
		rts
; ---------------------------------------------------------------------------

loc_830EC:
		move.w	x_pos(a0),d0
		addi.w	#-2,d0
		add.w	d1,d0
		move.w	(Camera_min_X_pos).w,d1
		add.w	d3,d1
		cmp.w	d1,d0
		bls.s	locret_83106

loc_83100:
		swap	d0
		move.l	d0,x_pos(a0)

locret_83106:
		rts
; End of function sub_830C0

; ---------------------------------------------------------------------------

loc_83108:
		move.b	#4,$39(a0)
		move.l	#loc_8311A,(a0)
		move.w	#3,$3A(a0)

loc_8311A:
		subq.w	#1,$2E(a0)
		bpl.w	locret_82ABA
		move.w	$3A(a0),$2E(a0)
		lea	(Normal_palette).w,a1
		moveq	#$40-1,d0

loc_8312E:
		jsr	sub_85EB4(pc)
		dbf	d0,loc_8312E
		subq.b	#1,$39(a0)
		bmi.s	loc_8313E
		rts
; ---------------------------------------------------------------------------

loc_8313E:
		move.l	#loc_85EE6,(a0)
		rts

; =============== S U B R O U T I N E =======================================


sub_83146:
		move.b	subtype(a0),d0
		move.w	d0,d1
		andi.w	#$F0,d0
		lsr.w	#1,d0
		lea	byte_8318A(pc,d0.w),a1
		move.b	(a1)+,width_pixels(a0)
		move.b	(a1)+,height_pixels(a0)
		move.b	(a1)+,mapping_frame(a0)
		move.b	(a1)+,collision_flags(a0)
		move.l	(a1)+,$30(a0)
		bset	#2,render_flags(a0)
		andi.w	#$F,d1
		add.w	d1,d1
		move.w	word_8317E(pc,d1.w),x_vel(a0)
		rts
; End of function sub_83146

; ---------------------------------------------------------------------------
word_8317E:
		dc.w   -$80,  -$40,     0,   $40,   $80, -$200
byte_8318A:
		dc.b  $10, $10, $26,   0
		dc.l word_831A2
		dc.b  $18, $18, $27,   0
		dc.l word_831AA
		dc.b  $28, $28, $28,   0
		dc.l word_831B2
word_831A2:
		dc.w   -$18,   $30,  -$18,   $30
word_831AA:
		dc.w   -$20,   $40,  -$20,   $40
word_831B2:
		dc.w   -$28,   $50,  -$38,   $68
ObjDat3_831BA:
		dc.l Map_DDZMissileAsteroid
		dc.w make_art_tile($2DB,2,1)
		dc.w   $280
		dc.b    8,   8, $1C,   0
word_831C6:
		dc.w   $280
		dc.b    4,   4, $24,   0
ObjDat3_831CC:
		dc.l Map_DDZMissileAsteroid
		dc.w make_art_tile($2DB,2,0)
		dc.w   $300
		dc.b  $38, $2C, $38,   0
ObjDat3_831D8:
		dc.l Map_DDZMissileAsteroid
		dc.w make_art_tile($2DB,2,1)
		dc.w   $280
		dc.b  $10, $18,   7,   0
ObjDat3_831E4:
		dc.l Map_DDZMissileAsteroid
		dc.w make_art_tile($2DB,2,1)
		dc.w   $180
		dc.b  $10, $10,   6,   0
ObjDat_DDZMissile:
		dc.l Map_DDZMissileAsteroid
		dc.w make_art_tile($2DB,2,0)
		dc.w   $180
		dc.b  $18, $18,   8,   0
word_831FC:
		dc.w   $180
		dc.b    8,   8, $12,   0
word_83202:
		dc.w   $200
		dc.b    8,   8, $18,   0
word_83208:
		dc.w   $300
		dc.b   $C,  $C, $29,   0
ObjDat3_8320E:
		dc.l Map_DDZMissileAsteroid
		dc.w make_art_tile($2DB,2,0)
		dc.w   $200
		dc.b  $40, $24,   1,   0
ObjDat3_8321A:
		dc.l Map_SuperSonic_Stars
		dc.w make_art_tile($79C,0,1)
		dc.w    $80
		dc.b  $18, $18,   0,   0
ObjDat3_83226:
		dc.l Map_BossMasterEmerald
		dc.w make_art_tile($4D0,3,0)
		dc.w   $280
		dc.b  $20, $18,   0,   0
ObjDat3_83232:
		dc.l Map_DDZMissileAsteroid
		dc.w make_art_tile($2DB,2,0)
		dc.w   $300
		dc.b  $10,  $C, $31,   0
word_8323E:
		dc.w   $280
		dc.b    8, $10, $33,   0
ObjDat3_83244:
		dc.l Map_DDZMissileAsteroid
		dc.w make_art_tile($2DB,2,0)
		dc.w   $300
		dc.b    8,   8, $25,   0
ChildObjDat_83250:
		dc.w 1-1
		dc.l loc_8214A
ChildObjDat_83256:
		dc.w 1-1
		dc.l loc_8218E
ChildObjDat_8325C:
		dc.w 1-1
		dc.l loc_81E3C
ChildObjDat_83262:
		dc.w 3-1
		dc.l loc_81F36
ChildObjDat_83268:
		dc.w 3-1
		dc.l loc_81E82
ChildObjDat_8326E:
		dc.w 1-1
		dc.l loc_81F14
ChildObjDat_83274:
		dc.w 3-1
		dc.l loc_81D72
ChildObjDat_8327A:
		dc.w 1-1
		dc.l loc_81CC6
		dc.b  $1C,  -4
ChildObjDat_83282:
		dc.w 2-1
		dc.l loc_81F7E
ChildObjDat_83288:
		dc.w 4-1
		dc.l loc_825CA
ChildObjDat_8328E:
		dc.w 4-1
		dc.l loc_8249A
ChildObjDat_83294:
		dc.w 2-1
		dc.l loc_82588
		dc.b    8,   0
		dc.l loc_825BC
		dc.b -$18,   0
ChildObjDat_832A2:
		dc.w 1-1
		dc.l loc_826A0
byte_832A8:
		dc.b    3, $29, $2A, $2B, $2C, $FC
byte_832AE:
		dc.b    3, $2D, $2E, $2F, $30, $FC
byte_832B4:
		dc.b  $18,   3
		dc.b  $18,   3
		dc.b  $19,   3
		dc.b  $1A,   4
		dc.b  $1B,   5
		dc.b  $F4
byte_832BF:
		dc.b    1, $31, $32, $FC
byte_832C3:
		dc.b  $33,   3
		dc.b  $34,   3
		dc.b  $35,   3
		dc.b  $39,   7
		dc.b  $37,   3
		dc.b  $36,   3
		dc.b  $FC
byte_832D0:
		dc.b  $3A, $2F
		dc.b  $3B,   9
		dc.b  $3C,   9
		dc.b  $3B,   9
		dc.b  $FC
byte_832D9:
		dc.b  $3D, $2F
		dc.b  $3E,   9
		dc.b  $3F,   9
		dc.b  $3E,   9
		dc.b  $FC
		even
Map_DDZMissileAsteroid:
		include "Levels/DDZ/Misc Object Data/Map - Missile Asteroid.asm"

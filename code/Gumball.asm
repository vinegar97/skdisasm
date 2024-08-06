Obj_GumballMachine:
		lea	ObjDat_GumballMachine(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_60CB8,(a0)
		move.w	a0,(_unkFAA4).w
		subi.w	#$100,y_pos(a0)
		move.w	y_pos(a0),$3A(a0)
		st	(Disable_death_plane).w
		move.l	(V_int_run_count).w,(RNG_seed).w
		move.w	(Saved_ring_count).w,(Ring_count).w
		move.b	(Saved_extra_life_flags).w,(Extra_life_flags).w
		move.b	#1,(Update_HUD_ring_count).w
		bset	#7,(Player_1+art_tile).w
		bset	#7,(Player_2+art_tile).w
		lea	($FF2000).l,a1
		moveq	#-1,d0
		moveq	#bytesToLcnt($24),d1

loc_60CA8:
		move.l	d0,(a1)+
		dbf	d1,loc_60CA8
		lea	ChildObjDat_613F8(pc),a2
		jsr	(CreateChild1_Normal).l

loc_60CB8:
		bsr.w	sub_6126C
		lea	word_60D16(pc),a1
		jsr	(Check_PlayerInRange).l
		tst.w	d0
		bne.s	loc_60CD0
		swap	d0
		tst.w	d0
		beq.s	loc_60D10

loc_60CD0:
		move.l	#loc_60D1E,(a0)
		move.l	#loc_60D32,$34(a0)
		bset	#1,$38(a0)
		movea.w	d0,a1
		move.w	x_pos(a0),d0
		cmp.w	x_pos(a1),d0
		scs	d1
		tst.w	y_vel(a1)
		bmi.s	loc_60CF8
		not.b	d1

loc_60CF8:
		bclr	#0,render_flags(a0)
		tst.b	d1
		beq.s	loc_60D08
		bset	#0,render_flags(a0)

loc_60D08:
		moveq	#signextendB(sfx_GumballTab),d0
		jsr	(Play_SFX).l

loc_60D10:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
word_60D16:
		dc.w   -$24,   $48,    -8,   $10
; ---------------------------------------------------------------------------

loc_60D1E:
		bsr.w	sub_6126C
		lea	byte_61450(pc),a1
		jsr	(Animate_RawNoSST).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_60D32:
		move.l	#loc_60D40,(a0)
		bset	#3,$38(a0)
		rts
; ---------------------------------------------------------------------------

loc_60D40:
		bsr.w	sub_6126C
		btst	#1,$38(a0)
		bne.s	loc_60D52
		move.l	#loc_60CB8,(a0)

loc_60D52:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_60D58:
		lea	ObjDat3_61398(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.w	#$100,x_pos(a0)
		move.w	#$310,y_pos(a0)
		lea	ChildObjDat_61424(pc),a2
		jsr	(CreateChild1_Normal).l
		move.l	#loc_60D7E,(a0)

loc_60D7E:
		btst	#1,$38(a0)
		bne.s	loc_60D96
		lea	(SolidObjectFull).l,a1
		bsr.w	sub_61314
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_60D96:
		clr.b	($FF2022).l
		lea	ChildObjDat_6143E(pc),a2
		jsr	(CreateChild6_Simple).l
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

loc_60DAC:
		lea	ObjDat3_613C8(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.w	#-$1000,$30(a0)
		movea.w	parent3(a0),a1
		btst	#1,$38(a1)
		bne.s	loc_60E36
		move.w	#$1B,d1
		move.w	#8,d2
		move.w	#$10,d3
		move.w	x_pos(a0),d4
		lea	(Player_1).w,a1
		moveq	#p1_standing_bit,d6
		movem.l	d1-d4,-(sp)
		jsr	SolidObjectFull2_1P
		btst	#p1_standing_bit,status(a0)
		beq.s	loc_60DFC
		bset	#5,$38(a0)
		jsr	(sub_22F98).l

loc_60DFC:
		movem.l	(sp)+,d1-d4
		lea	(Player_2).w,a1
		moveq	#p2_standing_bit,d6
		jsr	SolidObjectFull2_1P
		btst	#p2_standing_bit,status(a0)
		beq.s	loc_60E1A
		jsr	(sub_22F98).l

loc_60E1A:
		lea	(Ani_Spring).l,a1
		jsr	(Animate_Sprite).l
		btst	#5,$38(a0)
		beq.s	loc_60E46
		cmpi.b	#1,prev_anim(a0)
		bne.s	loc_60E46

loc_60E36:
		move.l	#MoveChkDel,(a0)
		movea.w	parent3(a0),a1
		bset	#1,$38(a1)

loc_60E46:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_60E4C:
		lea	ObjDat3_613BC(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_60E5C,(a0)

loc_60E5C:
		movea.w	parent3(a0),a1
		btst	#3,$38(a1)
		beq.s	loc_60E80
		move.l	#loc_60E8C,(a0)
		move.l	#loc_60EA2,$34(a0)
		lea	ChildObjDat_61444(pc),a2
		jsr	(CreateChild6_Simple).l

loc_60E80:
		jsr	(Refresh_ChildPosition).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_60E8C:
		lea	byte_6145B(pc),a1
		jsr	(Animate_RawNoSSTMultiDelay).l
		jsr	(Refresh_ChildPosition).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_60EA2:
		move.l	#loc_60E5C,(a0)
		movea.w	parent3(a0),a1
		bclr	#1,$38(a1)
		bclr	#3,$38(a1)

locret_60EB8:
		rts
; ---------------------------------------------------------------------------

loc_60EBA:
		lea	ObjDat3_613E0(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_60ECE,(a0)
		bsr.w	sub_612A8

loc_60ECE:
		move.w	y_vel(a0),d0
		addi.w	#$10,d0
		cmpi.w	#$200,d0
		bhi.s	loc_60EE0
		move.w	d0,y_vel(a0)

loc_60EE0:
		jsr	(MoveSprite2).l
		movea.w	parent3(a0),a1
		move.w	y_pos(a1),d0
		cmp.w	y_pos(a0),d0
		bls.s	loc_60EFC
		move.w	d0,y_pos(a0)
		bra.w	loc_60F0E
; ---------------------------------------------------------------------------

loc_60EFC:
		addi.w	#$10,d0
		cmp.w	y_pos(a0),d0
		bhi.s	loc_60F0E
		jsr	(sub_610E0).l
		bne.s	loc_60F28

loc_60F0E:
		move.w	(Camera_Y_pos).w,d0
		addi.w	#$240,d0
		cmp.w	y_pos(a0),d0
		blo.s	loc_60F28
		jsr	(Animate_Raw).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_60F28:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

Obj_GumballTriangleBumper:
		lea	ObjDat3_613A4(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_60F3E,(a0)

loc_60F3E:
		tst.w	($FF2020).l
		bpl.s	loc_60F8E
		moveq	#$D,d1
		moveq	#8,d2
		moveq	#$11,d3
		move.w	x_pos(a0),d4
		jsr	(SolidObjectFull).l
		btst	#$10,d6
		bne.s	loc_60F64
		btst	#p1_standing_bit,status(a0)
		beq.s	loc_60F72

loc_60F64:
		lea	(Player_1).w,a1
		bsr.w	sub_60F94
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_60F72:
		btst	#$11,d6
		bne.s	loc_60F80
		btst	#p2_standing_bit,status(a0)
		beq.s	loc_60F8E

loc_60F80:
		lea	(Player_2).w,a1
		bsr.w	sub_60F94
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_60F8E:
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_60F94:
		move.w	#-$300,d0
		move.w	#-$600,y_vel(a1)
		bset	#Status_Facing,status(a1)
		btst	#0,render_flags(a0)
		bne.s	loc_60FB4
		bclr	#Status_Facing,status(a1)
		neg.w	d0

loc_60FB4:
		move.w	d0,x_vel(a1)
		move.w	d0,ground_vel(a1)
		bset	#Status_InAir,status(a1)
		bclr	#Status_OnObj,status(a1)
		move.b	#$10,anim(a1)
		clr.b	jumping(a1)
		moveq	#0,d0
		move.b	subtype(a0),d0
		lea	($FF2000).l,a1
		clr.b	(a1,d0.w)
		move.w	#$F,($FF2020).l
		movea.w	(_unkFAA4).w,a1
		bset	#0,$38(a1)
		moveq	#signextendB(sfx_Spring),d0
		jsr	(Play_SFX).l
		rts
; End of function sub_60F94

; ---------------------------------------------------------------------------

loc_60FFE:
		lea	ObjDat3_6138C(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_61012,(a0)
		bsr.w	sub_61362

loc_61012:
		jsr	(Refresh_ChildPosition).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_6101E:
		lea	ObjDat3_613D4(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_61032,(a0)
		bsr.w	sub_61320

loc_61032:
		subq.b	#1,$2E(a0)
		bpl.s	loc_6103E
		move.l	#MoveChkDel,(a0)

loc_6103E:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_61044:
		addi.w	#$2A0,y_pos(a0)
		move.l	#loc_61050,(a0)

loc_61050:
		subq.w	#1,($FF2020).l
		lea	word_610AE(pc),a1
		jsr	(Check_PlayerInRange).l
		tst.w	d0
		bne.s	loc_61076
		swap	d0
		tst.w	d0
		beq.w	locret_60EB8
		lea	(Player_2).w,a1
		jmp	(Delete_Referenced_Sprite).l
; ---------------------------------------------------------------------------

loc_61076:
		move.w	(Saved_zone_and_act).w,(Current_zone_and_act).w
		move.w	(Saved_apparent_zone_and_act).w,(Apparent_zone_and_act).w
		move.b	(Saved_last_star_post_hit).w,(Last_star_post_hit).w
		move.b	#0,(Special_bonus_entry_flag).w
		move.b	#1,(Restart_level_flag).w
		move.w	(Ring_count).w,(Saved_ring_count).w
		move.b	(Extra_life_flags).w,(Saved_extra_life_flags).w
		move.b	(Player_1+status_secondary).w,d0
		andi.b	#$71,d0
		move.b	d0,(Saved_status_secondary).w
		rts
; ---------------------------------------------------------------------------
word_610AE:
		dc.w  -$100,  $200,  -$10,   $40
; ---------------------------------------------------------------------------

loc_610B6:
		lea	ObjDat3_613EC(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_610C6,(a0)

loc_610C6:
		st	(Spritemask_flag).w
		movea.w	parent3(a0),a1
		move.w	x_pos(a1),x_pos(a0)
		move.w	y_pos(a1),y_pos(a0)
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_610E0:
		lea	word_610F0(pc),a1
		jsr	(Check_PlayerInRange).l
		tst.l	d0
		bne.s	loc_610F8
		rts
; ---------------------------------------------------------------------------
word_610F0:
		dc.w   -$18,   $30,  -$18,   $30
; ---------------------------------------------------------------------------

loc_610F8:
		moveq	#0,d1
		moveq	#1,d2
		move.b	subtype(a0),d1

loc_61100:
		add.w	d1,d1
		move.w	off_6110E(pc,d1.w),d1
		jsr	off_6110E(pc,d1.w)
		tst.w	d2

locret_6110C:
		rts
; End of function sub_610E0

; ---------------------------------------------------------------------------
off_6110E:
		dc.w loc_61120-off_6110E
		dc.w loc_61130-off_6110E
		dc.w loc_6114E-off_6110E
		dc.w locret_6114C-off_6110E
		dc.w loc_6115C-off_6110E
		dc.w loc_611D6-off_6110E
		dc.w loc_61200-off_6110E
		dc.w loc_6122A-off_6110E
		dc.w loc_61264-off_6110E
; ---------------------------------------------------------------------------

loc_61120:
		addq.b	#1,(Life_count).w
		addq.b	#1,(Update_HUD_life_count).w
		moveq	#signextendB(mus_ExtraLife),d0
		jmp	(Play_Music).l
; ---------------------------------------------------------------------------

loc_61130:
		tst.b	($FF2022).l
		bne.s	locret_6110C
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	locret_6110C
		move.l	#loc_60D58,(a1)
		st	($FF2022).l

locret_6114C:
		rts
; ---------------------------------------------------------------------------

loc_6114E:
		addi.w	#20,(Saved_ring_count).w
		moveq	#10,d0
		jmp	(AddRings).l
; ---------------------------------------------------------------------------

loc_6115C:
		move.l	d0,-(sp)
		tst.w	d0
		beq.s	loc_61164
		bsr.s	sub_61176

loc_61164:
		move.l	(sp)+,d0
		swap	d0
		tst.w	d0
		beq.s	loc_6116E
		bsr.s	sub_61176

loc_6116E:
		clr.b	collision_property(a0)
		moveq	#0,d2
		rts

; =============== S U B R O U T I N E =======================================


sub_61176:
		movea.w	d0,a1
		move.w	x_pos(a0),d1
		move.w	y_pos(a0),d2
		sub.w	x_pos(a1),d1
		sub.w	y_pos(a1),d2
		jsr	(GetArcTan).l
		move.b	(Level_frame_counter).w,d1
		andi.w	#3,d1
		add.w	d1,d0
		jsr	(GetSineCosine).l
		muls.w	#-$700,d1
		asr.l	#8,d1
		move.w	d1,x_vel(a1)
		muls.w	#-$700,d0
		asr.l	#8,d0
		move.w	d0,y_vel(a1)
		bset	#Status_InAir,status(a1)
		bclr	#Status_RollJump,status(a1)
		bclr	#Status_Push,status(a1)
		clr.b	jumping(a1)
		move.b	#1,anim(a0)
		moveq	#signextendB(sfx_SmallBumpers),d0
		jmp	(Play_SFX).l
; End of function sub_61176

; ---------------------------------------------------------------------------

loc_611D6:
		lea	(Player_1).w,a1
		move.l	#Obj_FireShield,(Shield).w
		move.w	a1,(Shield+parent).w
		andi.b	#$8E,status_secondary(a1)
		bset	#Status_Shield,status_secondary(a1)
		moveq	#Status_FireShield,d0
		bsr.w	sub_61254
		moveq	#signextendB(sfx_FireShield),d0
		jmp	(Play_Music).l
; ---------------------------------------------------------------------------

loc_61200:
		lea	(Player_1).w,a1
		move.l	#Obj_BubbleShield,(Shield).w
		move.w	a1,(Shield+parent).w
		andi.b	#$8E,status_secondary(a1)
		bset	#Status_Shield,status_secondary(a1)
		moveq	#Status_BublShield,d0
		bsr.w	sub_61254
		moveq	#signextendB(sfx_BubbleShield),d0
		jmp	(Play_Music).l
; ---------------------------------------------------------------------------

loc_6122A:
		lea	(Player_1).w,a1
		move.l	#Obj_LightningShield,(Shield).w
		move.w	a1,(Shield+parent).w
		andi.b	#$8E,status_secondary(a1)
		bset	#Status_Shield,status_secondary(a1)
		moveq	#Status_LtngShield,d0
		bsr.w	sub_61254
		moveq	#signextendB(sfx_LightningShield),d0
		jmp	(Play_Music).l

; =============== S U B R O U T I N E =======================================


sub_61254:
		bset	d0,status_secondary(a1)
		lea	(Saved_status_secondary).w,a2
		andi.b	#$8F,(a2)
		bset	d0,(a2)
		rts
; End of function sub_61254

; ---------------------------------------------------------------------------

loc_61264:
		bset	#7,(Saved_status_secondary).w
		rts

; =============== S U B R O U T I N E =======================================


sub_6126C:
		bclr	#0,$38(a0)
		beq.s	loc_61294
		lea	($FF2000).l,a1
		moveq	#0,d0
		moveq	#$E-1,d1

loc_6127E:
		tst.w	(a1)+
		bne.s	loc_6128A
		addi.w	#$20,d0
		dbf	d1,loc_6127E

loc_6128A:
		move.w	$3A(a0),d1
		add.w	d0,d1
		move.w	d1,$3C(a0)

loc_61294:
		move.w	$3C(a0),d1
		move.w	y_pos(a0),d2
		cmp.w	d1,d2
		bhs.s	.locret_612A6
		addq.w	#4,d2
		move.w	d2,y_pos(a0)

.locret_612A6:
		rts
; End of function sub_6126C


; =============== S U B R O U T I N E =======================================


sub_612A8:
		jsr	(Random_Number).l
		andi.w	#$F,d0
		bne.s	loc_612C2
		movea.w	parent3(a0),a1
		bset	#7,$38(a1)
		beq.s	loc_612C2
		moveq	#3,d0

loc_612C2:
		move.b	byte_612E0(pc,d0.w),d0
		move.b	d0,subtype(a0)
		cmpi.b	#4,d0
		bne.s	loc_612D6
		move.b	#$D7,collision_flags(a0)

loc_612D6:
		lsl.w	#2,d0
		move.l	off_612F0(pc,d0.w),$30(a0)
		rts
; End of function sub_612A8

; ---------------------------------------------------------------------------
byte_612E0:
		dc.b    0
		dc.b    3
		dc.b    1
		dc.b    4
		dc.b    2
		dc.b    4
		dc.b    5
		dc.b    4
		dc.b    6
		dc.b    3
		dc.b    7
		dc.b    4
		dc.b    5
		dc.b    6
		dc.b    7
		dc.b    2
		even
off_612F0:
		dc.l byte_61466
		dc.l byte_6146A
		dc.l byte_6146E
		dc.l byte_61472
		dc.l byte_61476
		dc.l byte_6147A
		dc.l byte_6147E
		dc.l byte_61482
		dc.l byte_61486

; =============== S U B R O U T I N E =======================================


sub_61314:
		moveq	#$4B,d1
		moveq	#$10,d2
		moveq	#$11,d3
		move.w	x_pos(a0),d4
		jmp	(a1)
; End of function sub_61314


; =============== S U B R O U T I N E =======================================


sub_61320:
		moveq	#0,d0
		move.b	subtype(a0),d0
		move.b	d0,$2E(a0)
		lea	byte_61342(pc,d0.w),a1
		move.b	(a1)+,d0
		ext.w	d0
		add.w	d0,x_pos(a0)
		moveq	#0,d0
		move.b	(a1)+,d0
		ext.w	d0
		add.w	d0,y_pos(a0)
		rts
; End of function sub_61320

; ---------------------------------------------------------------------------
byte_61342:
		dc.b   -8,   8
		dc.b    8,   8
		dc.b   -8,  -8
		dc.b    8,  -8
		dc.b -$18,   8
		dc.b  $18,   8
		dc.b -$18,  -8
		dc.b  $18,  -8
		dc.b -$28,   8
		dc.b  $28,   8
		dc.b -$28,  -8
		dc.b  $28,  -8
		dc.b -$38,   8
		dc.b  $38,   8
		dc.b -$38,  -8
		dc.b  $38,  -8
		even

; =============== S U B R O U T I N E =======================================


sub_61362:
		moveq	#0,d0
		move.b	subtype(a0),d0
		subi.w	#6,d0
		lsr.w	#1,d0
		move.b	RawAni_61388(pc,d0.w),d0
		move.b	d0,mapping_frame(a0)
		cmpi.b	#$16,d0
		bne.w	locret_60EB8
		lea	ChildObjDat_6144A(pc),a2
		jmp	(CreateChild6_Simple).l
; End of function sub_61362

; ---------------------------------------------------------------------------
RawAni_61388:
		dc.b    0,   1,   0, $16
ObjDat3_6138C:
		dc.l Map_GumballBonus
		dc.w make_art_tile($15B,0,0)
		dc.w   $200
		dc.b  $10, $20,   0,   0
ObjDat3_61398:
		dc.l Map_GumballBonus
		dc.w make_art_tile($15B,1,1)
		dc.w   $100
		dc.b  $40, $10, $13,   0
ObjDat3_613A4:
		dc.l Map_GumballBonus
		dc.w make_art_tile($15B,1,1)
		dc.w   $100
		dc.b    4, $10, $12,   0
ObjDat_GumballMachine:
		dc.l Map_GumballBonus
		dc.w make_art_tile($15B,1,1)
		dc.w   $100
		dc.b  $18, $18,   5,   0
ObjDat3_613BC:
		dc.l Map_GumballBonus
		dc.w make_art_tile($15B,1,1)
		dc.w   $100
		dc.b  $14, $14,   2,   0
ObjDat3_613C8:
		dc.l Map_Spring
		dc.w make_art_tile($4A4,0,0)
		dc.w   $100
		dc.b  $10, $10,   0,   0
ObjDat3_613D4:
		dc.l Map_GumballBonus
		dc.w make_art_tile($15B,1,1)
		dc.w   $100
		dc.b    8,   8, $15,   0
ObjDat3_613E0:
		dc.l Map_GumballBonus
		dc.w make_art_tile($15B,0,1)
		dc.w   $100
		dc.b    8,   8,   8,   0
ObjDat3_613EC:
		dc.l Map_GumballBonus
		dc.w make_art_tile($000,0,0)
		dc.w   $180
		dc.b    4, $10, $17,   0
ChildObjDat_613F8:
		dc.w 7-1
		dc.l loc_60D58
		dc.b    0,   0
		dc.l loc_60E4C
		dc.b    0, $24
		dc.l loc_61044
		dc.b    0,   0
		dc.l loc_60FFE
		dc.b -$38,-$2C
		dc.l loc_60FFE
		dc.b    0,-$2C
		dc.l loc_60FFE
		dc.b  $38,-$2C
		dc.l loc_60FFE
		dc.b    0,-$28
ChildObjDat_61424:
		dc.w 4-1
		dc.l loc_60DAC
		dc.b -$30,-$18
		dc.l loc_60DAC
		dc.b -$10,-$18
		dc.l loc_60DAC
		dc.b  $10,-$18
		dc.l loc_60DAC
		dc.b  $30,-$18
ChildObjDat_6143E:
		dc.w $10-1
		dc.l loc_6101E
ChildObjDat_61444:
		dc.w 1-1
		dc.l loc_60EBA
ChildObjDat_6144A:
		dc.w 1-1
		dc.l loc_610B6
byte_61450:
		dc.b    3,   5,   6,   7, $14,   5, $F4
		dc.b  $7F,   5,   5, $FC
byte_6145B:
		dc.b    2,   3,   3,   3,   4,  $F,   3,   3,   2,   3, $F4
byte_61466:
		dc.b  $7F,   8,   8, $FC
byte_6146A:
		dc.b  $7F,   9,   9, $FC
byte_6146E:
		dc.b  $7F,  $A,  $A, $FC
byte_61472:
		dc.b  $7F,  $B,  $B, $FC
byte_61476:
		dc.b  $7F,  $C,  $C, $FC
byte_6147A:
		dc.b  $7F,  $D,  $D, $FC
byte_6147E:
		dc.b  $7F,  $E,  $E, $FC
byte_61482:
		dc.b  $7F,  $F,  $F, $FC
byte_61486:
		dc.b    1, $10, $11, $FC
Map_GumballBonus:
		include "Levels/Gumball/Misc Object Data/Map - Gumball Bonus.asm"

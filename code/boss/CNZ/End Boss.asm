Obj_CNZEndBoss:
		lea	word_6E46E(pc),a1
		jsr	(Check_CameraInRange).l
		move.l	#loc_6E4B8,(a0)
		move.l	#loc_6E4BE,$34(a0)
		lea	word_6E476(pc),a1
		move.b	#mus_EndBoss,$26(a0)
		jsr	(sub_85D6A).l
		moveq	#$6E,d0
		jsr	(Load_PLC).l
		lea	Pal_CNZEndBoss(pc),a1
		jmp	(PalLoad_Line1).l
; ---------------------------------------------------------------------------

loc_6E4B8:
		jmp	(loc_85CA4).l
; ---------------------------------------------------------------------------

loc_6E4BE:
		move.l	#loc_6E4C6,(a0)

locret_6E4C4:
		rts
; ---------------------------------------------------------------------------

loc_6E4C6:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_6E4E2(pc,d0.w),d1
		jsr	off_6E4E2(pc,d1.w)
		bsr.w	sub_6EC3A
		bsr.w	sub_6EC9E
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------
off_6E4E2:
		dc.w loc_6E4F2-off_6E4E2
		dc.w loc_6E548-off_6E4E2
		dc.w loc_6E574-off_6E4E2
		dc.w loc_6E5B6-off_6E4E2
		dc.w loc_6E5D8-off_6E4E2
		dc.w loc_6E62C-off_6E4E2
		dc.w loc_6E680-off_6E4E2
		dc.w loc_6E6AA-off_6E4E2
; ---------------------------------------------------------------------------

loc_6E4F2:
		lea	ObjDat_CNZEndBoss(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.b	#8,collision_property(a0)
		move.w	y_pos(a0),$3A(a0)
		move.w	#$7F,$2E(a0)
		move.l	#loc_6E55E,$34(a0)
		move.w	#-$100,x_vel(a0)
		jsr	Swing_Setup1(pc)
		lea	(Child1_MakeRoboShip4).l,a2
		jsr	(CreateChild1_Normal).l
		bne.s	loc_6E534
		move.b	#9,subtype(a1)

loc_6E534:
		lea	ChildObjDat_6EDCC(pc),a2
		jsr	(CreateChild1_Normal).l
		lea	ChildObjDat_6EDD4(pc),a2
		jmp	(CreateChild3_NormalRepeated).l
; ---------------------------------------------------------------------------

loc_6E548:
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_6E55A:
		jsr	Swing_Setup1(pc)

loc_6E55E:
		move.b	#4,routine(a0)
		move.w	#3*60,$2E(a0)
		move.l	#loc_6E5A4,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_6E574:
		jsr	(Find_SonicTails).l
		addi.w	#$10,d2
		cmpi.w	#$20,d2
		blo.s	loc_6E59E
		move.w	#$100,d1
		bset	#0,render_flags(a0)
		tst.w	d0
		bne.s	loc_6E59A
		neg.w	d1
		bclr	#0,render_flags(a0)

loc_6E59A:
		move.w	d1,x_vel(a0)

loc_6E59E:
		jmp	(Swing_MoveWaitNoFall).l
; ---------------------------------------------------------------------------

loc_6E5A4:
		move.b	#6,routine(a0)
		bset	#1,$38(a0)
		clr.w	x_vel(a0)
		rts
; ---------------------------------------------------------------------------

loc_6E5B6:
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		btst	#1,$38(a0)
		beq.s	loc_6E5CC
		rts
; ---------------------------------------------------------------------------

loc_6E5CC:
		move.b	#8,routine(a0)
		clr.w	x_vel(a0)
		rts
; ---------------------------------------------------------------------------

loc_6E5D8:
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		move.w	x_pos(a0),d0
		movea.w	$44(a0),a1
		cmp.w	x_pos(a1),d0
		beq.s	loc_6E610
		bhi.s	loc_6E602
		addq.w	#1,d0
		move.w	d0,x_pos(a0)
		bset	#0,render_flags(a0)
		rts
; ---------------------------------------------------------------------------

loc_6E602:
		subq.w	#1,d0
		bclr	#0,render_flags(a0)
		move.w	d0,x_pos(a0)
		rts
; ---------------------------------------------------------------------------

loc_6E610:
		move.b	#$A,routine(a0)
		bset	#3,$38(a0)
		move.w	#$BF,$2E(a0)
		move.l	#loc_6E632,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_6E62C:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_6E632:
		bset	#2,$38(a0)
		move.w	#$FF,$2E(a0)
		move.l	#loc_6E650,$34(a0)
		lea	ChildObjDat_6EDE4(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_6E650:
		bclr	#2,$38(a0)
		bset	#7,$38(a0)
		move.w	#$FF,$2E(a0)
		move.l	#loc_6E66C,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_6E66C:
		move.b	#$C,routine(a0)
		bclr	#3,$38(a0)
		bclr	#7,$38(a0)
		rts
; ---------------------------------------------------------------------------

loc_6E680:
		move.w	y_pos(a0),d0
		addq.w	#1,d0
		movea.w	$44(a0),a1
		move.w	y_pos(a1),d1
		subi.w	#$14,d1
		cmp.w	d1,d0
		bhs.s	loc_6E69C
		move.w	d0,y_pos(a0)
		rts
; ---------------------------------------------------------------------------

loc_6E69C:
		move.b	#$E,routine(a0)
		bset	#3,$38(a0)
		rts
; ---------------------------------------------------------------------------

loc_6E6AA:
		move.w	y_pos(a0),d0
		subq.w	#1,d0
		cmp.w	$3A(a0),d0
		bls.s	loc_6E6BC
		move.w	d0,y_pos(a0)
		rts
; ---------------------------------------------------------------------------

loc_6E6BC:
		move.w	$3A(a0),y_pos(a0)
		bra.w	loc_6E55A
; ---------------------------------------------------------------------------

loc_6E6C6:
		move.l	#Obj_Wait,(a0)
		bset	#4,$38(a0)
		move.l	#loc_6E6E4,$34(a0)
		lea	ChildObjDat_6EE00(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_6E6E4:
		move.l	#loc_6E724,(a0)
		st	(_unkFAA8).w
		clr.b	(Boss_flag).w
		move.w	(_unkFAB4).w,d0
		addi.w	#$190,d0
		move.w	d0,(Camera_stored_max_X_pos).w
		jsr	(AllocateObject).l
		bne.s	loc_6E718
		move.l	#Obj_EggCapsule,(a1)
		move.w	#$4990,x_pos(a1)
		move.w	#$2E0,y_pos(a1)

loc_6E718:
		lea	(Child6_IncLevX).l,a2
		jmp	(CreateChild6_Simple).l
; ---------------------------------------------------------------------------

loc_6E724:
		move.w	(Camera_X_pos).w,(Camera_min_X_pos).w
		tst.b	(_unkFAA8).w
		bne.w	locret_6E4C4
		move.l	#loc_6E778,(a0)
		jsr	(Restore_PlayerControl).l
		lea	(Player_2).w,a1
		jsr	(Restore_PlayerControl2).l
		jsr	(Restore_LevelMusic).l
		move.w	#$200,(Camera_stored_min_Y_pos).w
		lea	(Child6_DecLevY).l,a2
		jsr	(CreateChild6_Simple).l
		move.w	(_unkFAB4).w,d0
		addi.w	#$310,d0
		move.w	d0,(Camera_stored_max_X_pos).w
		lea	(Child6_IncLevX).l,a2
		jmp	(CreateChild6_Simple).l
; ---------------------------------------------------------------------------

loc_6E778:
		cmpi.w	#$4A30,(Player_1+x_pos).w
		blo.s	locret_6E7B4
		move.l	#loc_6E7B6,(a0)
		lea	(ArtKosM_BadnikExplosion).l,a1
		move.w	#tiles_to_bytes($5A0),d2
		jsr	(Queue_Kos_Module).l
		jsr	(AllocateObject).l
		bne.s	locret_6E7B4
		move.w	a1,$44(a0)
		move.l	#Obj_CNZCannon,(a1)
		move.w	#$4B20,x_pos(a1)
		move.w	#$2A8,y_pos(a1)

locret_6E7B4:
		rts
; ---------------------------------------------------------------------------

loc_6E7B6:
		move.w	(Camera_X_pos).w,(Camera_min_X_pos).w
		movea.w	$44(a0),a1
		cmpi.b	#1,$30(a1)
		bne.w	locret_6E4C4
		move.l	#loc_6E7E4,(a0)
		move.w	#$200,d0
		move.w	d0,(Camera_target_max_Y_pos).w
		move.w	#$BF,$2E(a0)
		st	(Ctrl_1_locked).w
		rts
; ---------------------------------------------------------------------------

loc_6E7E4:
		subq.w	#1,$2E(a0)
		bpl.w	locret_6E4C4
		movea.w	$44(a0),a1
		cmpi.b	#$12,angle(a1)
		bne.w	locret_6E4C4
		move.l	#loc_6E80C,(a0)
		move.w	#((button_A_mask|button_B_mask|button_C_mask)<<8)|(button_A_mask|button_B_mask|button_C_mask),(Ctrl_1_logical).w
		st	(Ctrl_1_locked).w
		rts
; ---------------------------------------------------------------------------

loc_6E80C:
		move.w	(Camera_Y_pos).w,d0
		addi.w	#$20,d0
		cmp.w	(Player_1+y_pos).w,d0
		blo.w	locret_6E4C4
		move.w	#$500,d0
		jsr	(StartNewLevel).l
		jmp	(Go_Delete_Sprite_2).l
; ---------------------------------------------------------------------------

loc_6E82C:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_6E844(pc,d0.w),d1
		jsr	off_6E844(pc,d1.w)
		bsr.w	sub_6ED22
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------
off_6E844:
		dc.w loc_6E850-off_6E844
		dc.w loc_6E86A-off_6E844
		dc.w loc_6E8A2-off_6E844
		dc.w loc_6E8E8-off_6E844
		dc.w loc_6E8FE-off_6E844
		dc.w loc_6E920-off_6E844
; ---------------------------------------------------------------------------

loc_6E850:
		lea	ObjDat3_6ED9C(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.b	#$10,y_radius(a0)
		move.l	#byte_6EE1D,$30(a0)
		rts
; ---------------------------------------------------------------------------

loc_6E86A:
		jsr	(Refresh_ChildPositionAdjusted).l
		movea.w	parent3(a0),a1
		btst	#1,$38(a1)
		bne.s	loc_6E87E
		rts
; ---------------------------------------------------------------------------

loc_6E87E:
		move.b	#4,routine(a0)
		move.l	#loc_6E8B6,$34(a0)
		jsr	(Find_SonicTails).l
		move.w	#$100,d1
		tst.w	d0
		bne.s	loc_6E89C
		neg.w	d1

loc_6E89C:
		move.w	d1,x_vel(a0)
		rts
; ---------------------------------------------------------------------------

loc_6E8A2:
		jsr	(MoveSprite).l
		tst.w	y_vel(a0)
		bmi.w	locret_6E4C4
		jmp	(ObjHitFloor_DoRoutine).l
; ---------------------------------------------------------------------------

loc_6E8B6:
		moveq	#signextendB(sfx_FloorThump),d0
		jsr	(Play_SFX).l
		move.w	y_vel(a0),d0
		cmpi.w	#$80,d0
		blo.s	loc_6E8D2
		asr.w	#1,d0
		neg.w	d0
		move.w	d0,y_vel(a0)
		rts
; ---------------------------------------------------------------------------

loc_6E8D2:
		move.b	#6,routine(a0)
		movea.w	parent3(a0),a1
		move.w	a0,$44(a1)
		bclr	#1,$38(a1)
		rts
; ---------------------------------------------------------------------------

loc_6E8E8:
		movea.w	parent3(a0),a1
		btst	#3,$38(a1)
		bne.s	loc_6E8F6
		rts
; ---------------------------------------------------------------------------

loc_6E8F6:
		move.b	#8,routine(a0)
		rts
; ---------------------------------------------------------------------------

loc_6E8FE:
		movea.w	parent3(a0),a1
		btst	#3,$38(a1)
		beq.s	loc_6E910
		jmp	(Animate_RawMultiDelay).l
; ---------------------------------------------------------------------------

loc_6E910:
		move.b	#$A,routine(a0)
		move.b	#4,mapping_frame(a0)
		bra.w	loc_6EAD0
; ---------------------------------------------------------------------------

loc_6E920:
		movea.w	parent3(a0),a1
		bclr	#3,$38(a1)
		bne.s	loc_6E92E
		rts
; ---------------------------------------------------------------------------

loc_6E92E:
		move.b	#2,routine(a0)
		rts
; ---------------------------------------------------------------------------

loc_6E936:
		lea	word_6EDA8(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#Obj_FlickerMove,(a0)
		tst.b	subtype(a0)
		beq.s	loc_6E952
		bset	#0,render_flags(a0)

loc_6E952:
		moveq	#8,d0
		jmp	(Set_IndexedVelocity).l
; ---------------------------------------------------------------------------

loc_6E95A:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_6E986(pc,d0.w),d1
		jsr	off_6E986(pc,d1.w)
		lea	(CNZEndBossMagnet_AngleX).l,a1
		jsr	(MoveSprite_AngleXLookupOffset).l
		bsr.w	sub_6EBD8
		bsr.w	sub_6EBF0
		bsr.w	sub_6ED4C
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------
off_6E986:
		dc.w loc_6E994-off_6E986
		dc.w loc_6E9B2-off_6E986
		dc.w loc_6E9E2-off_6E986
		dc.w loc_6EA26-off_6E986
		dc.w loc_6EA5C-off_6E986
		dc.w loc_6EA92-off_6E986
		dc.w loc_6EAB2-off_6E986
; ---------------------------------------------------------------------------

loc_6E994:
		lea	ObjDat3_6EDB4(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.b	subtype(a0),d0
		lsl.b	#5,d0
		move.b	d0,$3C(a0)
		move.l	#byte_6EE0E,$30(a0)
		rts
; ---------------------------------------------------------------------------

loc_6E9B2:
		movea.w	parent3(a0),a1
		btst	#3,$38(a1)
		bne.s	loc_6E9C0
		rts
; ---------------------------------------------------------------------------

loc_6E9C0:
		move.b	#4,routine(a0)
		move.b	#1,$40(a0)
		move.w	#$40,$2E(a0)
		move.l	#loc_6EA1A,$34(a0)
		move.b	$3C(a0),$3A(a0)
		rts
; ---------------------------------------------------------------------------

loc_6E9E2:
		movea.w	parent3(a0),a1
		btst	#2,$38(a1)
		bne.s	loc_6EA02
		move.b	$40(a0),d0
		add.b	d0,$3C(a0)
		jsr	(Animate_RawMultiDelay).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_6EA02:
		move.b	#6,routine(a0)
		lea	ChildObjDat_6EDDC(pc),a2
		jsr	(CreateChild1_Normal).l
		move.b	subtype(a0),subtype(a1)
		rts
; ---------------------------------------------------------------------------

loc_6EA1A:
		addq.b	#1,$40(a0)
		move.w	#$40,$2E(a0)
		rts
; ---------------------------------------------------------------------------

loc_6EA26:
		movea.w	parent3(a0),a1
		btst	#2,$38(a1)
		beq.s	loc_6EA40
		move.b	$40(a0),d0
		add.b	d0,$3C(a0)
		jmp	(Animate_RawMultiDelay).l
; ---------------------------------------------------------------------------

loc_6EA40:
		move.b	#8,routine(a0)
		bset	#7,$38(a0)
		move.w	#$40,$2E(a0)
		move.l	#loc_6EA70,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_6EA5C:
		move.b	$40(a0),d0
		add.b	d0,$3C(a0)
		jsr	(Animate_RawMultiDelay).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_6EA70:
		cmpi.b	#1,$40(a0)
		beq.s	loc_6EA84
		subq.b	#1,$40(a0)
		move.w	#$40,$2E(a0)
		rts
; ---------------------------------------------------------------------------

loc_6EA84:
		move.b	#$A,routine(a0)
		bclr	#7,$38(a0)
		rts
; ---------------------------------------------------------------------------

loc_6EA92:
		jsr	(Animate_RawMultiDelay).l
		move.b	$3C(a0),d0
		addq.b	#1,d0
		move.b	d0,$3C(a0)
		cmp.b	$3A(a0),d0
		beq.s	loc_6EAAA
		rts
; ---------------------------------------------------------------------------

loc_6EAAA:
		move.b	#$C,routine(a0)
		rts
; ---------------------------------------------------------------------------

loc_6EAB2:
		movea.w	parent3(a0),a1
		btst	#3,$38(a1)
		beq.s	loc_6EAC4
		jmp	(Animate_RawMultiDelay).l
; ---------------------------------------------------------------------------

loc_6EAC4:
		move.b	#2,routine(a0)
		move.b	#1,mapping_frame(a0)

loc_6EAD0:
		clr.b	anim_frame_timer(a0)
		clr.b	anim_frame(a0)
		rts
; ---------------------------------------------------------------------------

loc_6EADA:
		lea	ObjDat3_6EDC0(pc),a1
		jsr	(SetUp_ObjAttributes).l
		bset	#5,shield_reaction(a0)
		move.l	#byte_6EE2C,$30(a0)
		move.l	#loc_6EB34,$34(a0)
		btst	#1,subtype(a0)
		beq.s	loc_6EB0C
		move.l	#loc_6EB0C,(a0)
		bra.w	sub_6EC1E
; ---------------------------------------------------------------------------

loc_6EB0C:
		move.l	#loc_6EB16,(a0)
		bra.w	sub_6EC1E
; ---------------------------------------------------------------------------

loc_6EB16:
		moveq	#signextendB(sfx_GravityMachine),d0
		jsr	(Play_SFX_Continuous).l
		jsr	(Refresh_ChildPosition).l
		jsr	(Animate_Raw).l
		bsr.w	sub_6EC1E
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------

loc_6EB34:
		move.b	#9,mapping_frame(a0)
		move.b	$39(a0),d0
		addq.b	#1,d0
		move.b	d0,$39(a0)
		andi.b	#3,d0
		andi.b	#$FC,render_flags(a0)
		or.b	d0,render_flags(a0)
		rts
; ---------------------------------------------------------------------------
		lea	ObjDat3_6EDC0(pc),a1
		jsr	(SetUp_ObjAttributes).l
		bset	#5,shield_reaction(a0)
		move.l	#loc_6EB34,$34(a0)
		move.b	subtype(a0),d0
		beq.s	loc_6EB84
		move.l	#byte_6EE3B,$30(a0)
		move.l	#loc_6EB8C,(a0)
		bra.w	sub_6EC1E
; ---------------------------------------------------------------------------

loc_6EB84:
		move.l	#byte_6EE32,$30(a0)

loc_6EB8C:
		move.l	#loc_6EB96,(a0)
		bra.w	sub_6EC1E
; ---------------------------------------------------------------------------

loc_6EB96:
		jsr	(Refresh_ChildPosition).l
		jsr	(Animate_RawMultiDelay).l
		bsr.w	sub_6EC1E
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------

loc_6EBAC:
		lea	word_6EDAE(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#Obj_FlickerMove,(a0)
		move.b	subtype(a0),d0
		lsr.b	#1,d0
		addi.b	#$B,d0
		move.b	d0,mapping_frame(a0)
		moveq	#0,d0
		jsr	(Set_IndexedVelocity).l
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_6EBD8:
		move.b	$3C(a0),d0
		move.w	#$200,priority(a0)
		addi.b	#$40,d0
		bpl.s	locret_6EBEE
		move.w	#$280,priority(a0)

locret_6EBEE:
		rts
; End of function sub_6EBD8


; =============== S U B R O U T I N E =======================================


sub_6EBF0:
		cmpi.b	#3,mapping_frame(a0)
		beq.s	locret_6EC12
		move.b	$3C(a0),d0
		lea	byte_6EC14(pc),a1
		moveq	#5-1,d6

loc_6EC02:
		cmp.b	(a1)+,d0
		blo.s	loc_6EC0E
		addq.w	#1,a1
		dbf	d6,loc_6EC02
		rts
; ---------------------------------------------------------------------------

loc_6EC0E:
		move.b	(a1)+,mapping_frame(a0)

locret_6EC12:
		rts
; End of function sub_6EBF0

; ---------------------------------------------------------------------------
byte_6EC14:
		dc.b  $30,   1
		dc.b  $58,   8
		dc.b  $A8,   2
		dc.b  $D0,   8
		dc.b  $FF,   1
		even

; =============== S U B R O U T I N E =======================================


sub_6EC1E:
		movea.w	parent3(a0),a1
		btst	#7,$38(a1)
		bne.s	loc_6EC34
		btst	#7,status(a1)
		bne.s	loc_6EC34
		rts
; ---------------------------------------------------------------------------

loc_6EC34:
		jmp	(Go_Delete_Sprite).l
; End of function sub_6EC1E


; =============== S U B R O U T I N E =======================================


sub_6EC3A:
		btst	#2,$38(a0)
		bne.s	loc_6EC44
		rts
; ---------------------------------------------------------------------------

loc_6EC44:
		lea	(Player_1).w,a1
		bsr.w	sub_6EC50
		lea	(Player_2).w,a1
; End of function sub_6EC3A


; =============== S U B R O U T I N E =======================================


sub_6EC50:
		move.w	x_pos(a0),d0
		sub.w	x_pos(a1),d0
		spl	d1
		bpl.s	loc_6EC5E
		neg.w	d0

loc_6EC5E:
		andi.w	#$FFC0,d0
		cmpi.w	#$1C0,d0
		blo.s	loc_6EC6C
		move.w	#$1C0,d0

loc_6EC6C:
		lsr.w	#4,d0
		move.l	dword_6EC7E(pc,d0.w),d2
		tst.b	d1
		bne.s	loc_6EC78
		neg.l	d2

loc_6EC78:
		add.l	d2,x_pos(a1)
		rts
; End of function sub_6EC50

; ---------------------------------------------------------------------------
dword_6EC7E:
		dc.l     $28000
		dc.l     $20000
		dc.l     $1C000
		dc.l     $18000
		dc.l     $14000
		dc.l     $10000
		dc.l      $C000
		dc.l      $8000

; =============== S U B R O U T I N E =======================================


sub_6EC9E:
		tst.l	(a0)
		beq.s	locret_6ECF4
		tst.b	collision_flags(a0)
		bne.s	locret_6ECF4
		tst.b	collision_property(a0)
		beq.s	loc_6ECF6
		tst.b	$20(a0)
		bne.s	loc_6ECC2
		move.b	#$20,$20(a0)
		moveq	#signextendB(sfx_BossHit),d0
		jsr	(Play_SFX).l

loc_6ECC2:
		bset	#6,status(a0)
		moveq	#0,d0
		btst	#0,$20(a0)
		bne.s	loc_6ECD4
		addq.w	#2*4,d0

loc_6ECD4:
		lea	word_6ED0A(pc),a1
		lea	word_6ED12(pc,d0.w),a2
		jsr	(CopyWordData_4).l
		subq.b	#1,$20(a0)
		bne.s	locret_6ECF4
		bclr	#6,status(a0)
		move.b	$25(a0),collision_flags(a0)

locret_6ECF4:
		rts
; ---------------------------------------------------------------------------

loc_6ECF6:
		move.l	#Wait_FadeToLevelMusic,(a0)
		move.l	#loc_6E6C6,$34(a0)
		jmp	(BossDefeated_StopTimer).l
; End of function sub_6EC9E

; ---------------------------------------------------------------------------
word_6ED0A:
		dc.w Normal_palette_line_2+$12, Normal_palette_line_2+$14, Normal_palette_line_2+$16, Normal_palette_line_2+$1C
word_6ED12:
		dc.w    $60,   $20,   $20,  $640
		dc.w   $888,  $EEE,  $EEE,  $AAA

; =============== S U B R O U T I N E =======================================


sub_6ED22:
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		beq.s	loc_6ED32
		clr.b	collision_flags(a0)

loc_6ED32:
		btst	#4,$38(a1)
		bne.s	loc_6ED3C
		rts
; ---------------------------------------------------------------------------

loc_6ED3C:
		move.l	#Delete_Current_Sprite,(a0)
		lea	ChildObjDat_6EDF2(pc),a2
		jmp	(CreateChild1_Normal).l
; End of function sub_6ED22


; =============== S U B R O U T I N E =======================================


sub_6ED4C:
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		beq.s	loc_6ED5C
		clr.b	collision_flags(a0)

loc_6ED5C:
		btst	#4,$38(a1)
		bne.s	loc_6ED66
		rts
; ---------------------------------------------------------------------------

loc_6ED66:
		bset	#7,status(a0)
		move.b	#1,mapping_frame(a0)
		clr.b	collision_flags(a0)
		move.l	#Obj_FlickerMove,(a0)
		moveq	#0,d0
		jmp	(Set_IndexedVelocity).l
; End of function sub_6ED4C

; ---------------------------------------------------------------------------
ObjDat_CNZEndBoss:
		dc.l Map_CNZEndBoss
		dc.w make_art_tile($430,1,0)
		dc.w   $280
		dc.b  $40, $14,   0,   6
		dc.l Map_RobotnikShip
		dc.w make_art_tile($52E,0,1)
		dc.w   $280
		dc.b  $20, $20,   5,   0
ObjDat3_6ED9C:
		dc.l Map_CNZEndBoss
		dc.w make_art_tile($430,1,0)
		dc.w   $280
		dc.b  $10, $10,   4, $8B
word_6EDA8:
		dc.w   $280
		dc.b    8, $10,  $A,   0
word_6EDAE:
		dc.w   $280
		dc.b  $14, $14,   0,   0
ObjDat3_6EDB4:
		dc.l Map_CNZEndBoss
		dc.w make_art_tile($430,1,0)
		dc.w   $200
		dc.b    8, $10,   1, $9E
ObjDat3_6EDC0:
		dc.l Map_CNZEndBoss
		dc.w make_art_tile($430,1,0)
		dc.w    $80
		dc.b  $10, $40,   6, $AB
ChildObjDat_6EDCC:
		dc.w 1-1
		dc.l loc_6E82C
		dc.b    0, $14
ChildObjDat_6EDD4:
		dc.w 4-1
		dc.l loc_6E95A
		dc.b    0,   8
ChildObjDat_6EDDC:
		dc.w 1-1
		dc.l loc_6EADA
		dc.b    0, $4C
ChildObjDat_6EDE4:
		dc.w 2-1
		dc.l loc_6EADA
		dc.b  -$C, $54
		dc.l loc_6EADA
		dc.b   $C, $54
ChildObjDat_6EDF2:
		dc.w 2-1
		dc.l loc_6E936
		dc.b   -8,   0
		dc.l loc_6E936
		dc.b    8,   0
ChildObjDat_6EE00:
		dc.w 2-1
		dc.l loc_6EBAC
		dc.b -$14,   0
		dc.l loc_6EBAC
		dc.b  $14,   0
byte_6EE0E:
		dc.b    1,   0
		dc.b    3,   0
		dc.b    1,   0
		dc.b    3,   0
		dc.b    1,   4
		dc.b    3,   0
		dc.b    1,   9
		dc.b  $FC
byte_6EE1D:
		dc.b    4,   0
		dc.b    5,   0
		dc.b    4,   0
		dc.b    5,   0
		dc.b    4,   4
		dc.b    5,   0
		dc.b    4,   9
		dc.b  $FC
byte_6EE2C:
		dc.b    0,   9,   6,   9,   7, $F4
byte_6EE32:
		dc.b    9, $1F
		dc.b    6,   0
		dc.b    9,   2
		dc.b    7,   0
		dc.b  $FC
byte_6EE3B:
		dc.b    9, $24
		dc.b    6,   0
		dc.b    9,   2
		dc.b    7,   0
		dc.b  $FC
		dc.b    7,   0,   1, $FC
		even
Pal_CNZEndBoss:
		binclude "Levels/CNZ/Palettes/End Boss.bin"
		even
; ---------------------------------------------------------------------------

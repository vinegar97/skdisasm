Obj_MHZMiniboss:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	MHZMiniboss_Index(pc,d0.w),d1
		jsr	MHZMiniboss_Index(pc,d1.w)
		move.w	(Level_repeat_offset).w,d0
		beq.s	loc_751E2
		sub.w	d0,x_pos(a0)

loc_751E2:
		bsr.w	sub_75D80
		bsr.w	sub_75D50
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------
MHZMiniboss_Index:
		dc.w loc_75220-MHZMiniboss_Index
		dc.w loc_752D4-MHZMiniboss_Index
		dc.w loc_7531C-MHZMiniboss_Index
		dc.w loc_752D4-MHZMiniboss_Index
		dc.w loc_75392-MHZMiniboss_Index
		dc.w loc_753B6-MHZMiniboss_Index
		dc.w loc_753DE-MHZMiniboss_Index
		dc.w loc_7541A-MHZMiniboss_Index
		dc.w loc_7544C-MHZMiniboss_Index
		dc.w loc_754A0-MHZMiniboss_Index
		dc.w loc_754E0-MHZMiniboss_Index
		dc.w loc_75532-MHZMiniboss_Index
		dc.w loc_75564-MHZMiniboss_Index
		dc.w loc_754A0-MHZMiniboss_Index
		dc.w loc_755AE-MHZMiniboss_Index
		dc.w loc_754A0-MHZMiniboss_Index
		dc.w loc_7560C-MHZMiniboss_Index
		dc.w loc_7565C-MHZMiniboss_Index
		dc.w loc_754A0-MHZMiniboss_Index
		dc.w loc_75694-MHZMiniboss_Index
		dc.w loc_756C6-MHZMiniboss_Index
		dc.w loc_756FC-MHZMiniboss_Index
		dc.w loc_7571C-MHZMiniboss_Index
		dc.w loc_757A0-MHZMiniboss_Index
; ---------------------------------------------------------------------------

loc_75220:
		lea	ObjDat_MHZMiniboss(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.w	(Camera_X_pos).w,d0
		addi.w	#$110,d0
		move.w	d0,x_pos(a0)
		move.w	(Camera_Y_pos).w,d0
		subi.w	#$78,d0
		move.w	d0,y_pos(a0)
		move.b	#6,collision_property(a0)
		move.w	a0,(_unkFAA4).w
		move.b	#5,$42(a0)
		move.l	(V_int_run_count).w,(RNG_seed).w
		move.b	#1,(Boss_flag).w
		move.w	#$100,y_vel(a0)
		move.w	#$97,$2E(a0)
		move.l	#loc_752E6,$34(a0)
		move.l	#byte_75EAE,$30(a0)
		move.b	#$18,y_radius(a0)
		lea	ChildObjDat_75E84(pc),a2
		jsr	(CreateChild1_Normal).l
		jsr	(AllocateObject).l
		bne.s	loc_7529E
		move.l	#Obj_Song_Fade_Transition,(a1)
		move.b	#mus_Miniboss,subtype(a1)

loc_7529E:
		lea	(ArtKosM_MHZMiniboss).l,a1
		move.w	#tiles_to_bytes($3AD),d2
		jsr	(Queue_Kos_Module).l
		lea	(ArtKosM_MHZMinibossLog).l,a1
		move.w	#tiles_to_bytes($49F),d2
		jsr	(Queue_Kos_Module).l
		lea	(PLC_MHZMiniboss_Explosion).l,a1
		jsr	(Load_PLC_Raw).l
		lea	Pal_MHZMiniboss(pc),a1
		jmp	(PalLoad_Line1).l
; ---------------------------------------------------------------------------

loc_752D4:
		jsr	(Animate_RawMultiDelay).l
		jsr	(MoveSprite2).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_752E6:
		move.b	#4,routine(a0)
		clr.w	y_vel(a0)
		move.b	x_pos+1(a0),$3A(a0)
		move.w	y_pos(a0),$3C(a0)
		move.b	#3,$39(a0)

loc_75302:
		move.w	#$80,d0
		move.w	d0,$3E(a0)
		move.w	d0,y_vel(a0)
		move.w	#$10,$40(a0)
		bclr	#0,$38(a0)
		rts
; ---------------------------------------------------------------------------

loc_7531C:
		jsr	(Animate_RawMultiDelay).l
		jsr	(Swing_UpAndDown_Count).l
		bne.s	loc_75330
		jmp	(MoveSprite2).l
; ---------------------------------------------------------------------------

loc_75330:
		move.b	#6,routine(a0)
		move.w	$3C(a0),y_pos(a0)
		move.w	#$400,x_vel(a0)
		clr.w	y_vel(a0)
		move.w	#$1F,$2E(a0)
		move.l	#loc_75356,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_75356:
		move.b	#8,routine(a0)
		move.b	#5,mapping_frame(a0)
		move.w	#$4F,$2E(a0)
		move.l	#loc_753A4,$34(a0)
		move.w	#$6000,(Camera_target_max_X_pos).w
		move.w	#$6000,(Camera_stored_max_X_pos).w
		jsr	(AllocateObject).l
		bne.s	locret_75390
		move.l	#loc_75E1A,(a1)
		move.w	(Camera_max_X_pos).w,$34(a1)

locret_75390:
		rts
; ---------------------------------------------------------------------------

loc_75392:
		tst.b	render_flags(a0)
		bpl.s	locret_753B4
		jsr	(MoveSprite2).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_753A4:
		move.b	#$A,routine(a0)
		move.b	#4,mapping_frame(a0)
		addq.w	#2,x_pos(a0)

locret_753B4:
		rts
; ---------------------------------------------------------------------------

loc_753B6:
		move.w	x_vel(a0),d0
		addi.w	#-$20,d0
		move.w	d0,x_vel(a0)
		beq.s	loc_753CA
		jmp	(MoveSprite2).l
; ---------------------------------------------------------------------------

loc_753CA:
		move.b	#$C,routine(a0)
		move.b	$3A(a0),x_pos+1(a0)
		clr.w	x_vel(a0)
		bra.w	loc_75302
; ---------------------------------------------------------------------------

loc_753DE:
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		move.w	x_pos(a0),d0
		sub.w	(Camera_X_pos).w,d0
		cmpi.w	#$110,d0
		bls.s	loc_753FA
		rts
; ---------------------------------------------------------------------------

loc_753FA:
		move.b	#$E,routine(a0)
		move.l	#byte_75EBB,$30(a0)
		move.l	#loc_75444,$34(a0)
		clr.b	anim_frame_timer(a0)
		clr.b	anim_frame(a0)
		rts
; ---------------------------------------------------------------------------

loc_7541A:
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		jsr	(Animate_RawMultiDelay).l
		beq.s	locret_75442
		cmpi.b	#$A,anim_frame(a0)
		bne.s	locret_75442
		subq.b	#1,$42(a0)
		moveq	#signextendB(sfx_ChopTree),d0
		jsr	(Play_SFX).l

locret_75442:
		rts
; ---------------------------------------------------------------------------

loc_75444:
		move.b	#$10,routine(a0)
		rts
; ---------------------------------------------------------------------------

loc_7544C:
		jsr	(Swing_UpAndDown).l
		tst.w	d3
		bne.s	loc_7545C
		jmp	(MoveSprite2).l
; ---------------------------------------------------------------------------

loc_7545C:
		move.b	#$12,routine(a0)
		move.w	#$200,y_vel(a0)
		cmpi.b	#1,$42(a0)
		beq.s	loc_75480
		move.w	#$F,$2E(a0)
		move.l	#loc_754AC,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_75480:
		move.w	#7,$2E(a0)
		move.l	#loc_754BE,$34(a0)
		cmpi.b	#2,(Player_1+character_id).w
		bne.s	locret_7549E
		move.l	#loc_754D6,$34(a0)

locret_7549E:
		rts
; ---------------------------------------------------------------------------

loc_754A0:
		jsr	(MoveSprite2).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_754AC:
		move.b	#$E,routine(a0)
		move.l	#loc_75444,$34(a0)
		bra.w	loc_75302
; ---------------------------------------------------------------------------

loc_754BE:
		move.b	#$14,routine(a0)
		move.l	#byte_75ED0,$30(a0)
		move.l	#loc_75508,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_754D6:
		move.b	#$20,routine(a0)
		bra.w	loc_75302
; ---------------------------------------------------------------------------

loc_754E0:
		jsr	(Animate_RawMultiDelay).l
		beq.s	locret_75506
		cmpi.b	#$12,mapping_frame(a0)
		bne.s	loc_754F8
		moveq	#signextendB(sfx_ChopStuck),d0
		jsr	(Play_SFX).l

loc_754F8:
		cmpi.b	#$C,anim_frame(a0)
		bne.s	locret_75506
		subi.w	#$20,x_pos(a0)

locret_75506:
		rts
; ---------------------------------------------------------------------------

loc_75508:
		move.b	#$16,routine(a0)
		bset	#6,$38(a0)
		move.l	#byte_75EF3,$30(a0)
		move.w	#-$400,x_vel(a0)
		move.w	#-$400,y_vel(a0)
		moveq	#signextendB(sfx_ChopStuck),d0
		jsr	(Play_SFX).l
		rts
; ---------------------------------------------------------------------------

loc_75532:
		jsr	(Animate_RawMultiDelay).l
		jsr	(MoveSprite).l
		tst.w	y_vel(a0)
		bmi.s	locret_7554E
		jsr	(ObjCheckFloorDist).l
		tst.w	d1
		bmi.s	loc_75550

locret_7554E:
		rts
; ---------------------------------------------------------------------------

loc_75550:
		move.b	#$18,routine(a0)
		move.w	#-$200,x_vel(a0)
		move.w	#-$300,y_vel(a0)
		rts
; ---------------------------------------------------------------------------

loc_75564:
		jsr	(MoveSprite).l
		move.w	y_vel(a0),d0
		bmi.s	locret_75576
		cmpi.w	#$100,d0
		bhs.s	loc_75578

locret_75576:
		rts
; ---------------------------------------------------------------------------

loc_75578:
		move.b	#$1A,routine(a0)
		bclr	#6,$38(a0)
		move.w	#$100,x_vel(a0)
		move.w	#-$400,y_vel(a0)
		move.w	#$10,$2E(a0)
		move.l	#loc_755A0,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_755A0:
		move.b	#$1C,routine(a0)
		bset	#6,$38(a0)
		rts
; ---------------------------------------------------------------------------

loc_755AE:
		jsr	(MoveSprite).l
		tst.w	y_vel(a0)
		bmi.s	locret_755C4
		move.w	y_pos(a0),d0
		cmp.w	$3C(a0),d0
		bhs.s	loc_755C6

locret_755C4:
		rts
; ---------------------------------------------------------------------------

loc_755C6:
		move.b	#$1E,routine(a0)
		move.b	#5,mapping_frame(a0)
		bclr	#6,$38(a0)
		move.w	$3C(a0),y_pos(a0)
		clr.w	y_pos+2(a0)
		clr.w	y_vel(a0)
		move.w	#$400,x_vel(a0)
		move.w	#$2A,$2E(a0)
		move.l	#loc_75330,$34(a0)
		clr.b	anim_frame(a0)
		clr.b	anim_frame_timer(a0)
		move.l	#byte_75F0D,$30(a0)
		rts
; ---------------------------------------------------------------------------

loc_7560C:
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		jsr	(Animate_RawMultiDelay).l
		beq.s	locret_7565A
		cmpi.b	#$A,anim_frame(a0)
		bne.s	locret_7565A
		move.b	#$22,routine(a0)
		move.b	#$F,mapping_frame(a0)
		clr.b	anim_frame(a0)
		clr.b	anim_frame_timer(a0)
		move.l	#byte_75F02,$30(a0)
		move.l	#loc_7566E,$34(a0)
		subq.b	#1,$42(a0)
		lea	ChildObjDat_75E9E(pc),a2
		jsr	(CreateChild1_Normal).l

locret_7565A:
		rts
; ---------------------------------------------------------------------------

loc_7565C:
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		jmp	(Animate_RawMultiDelay).l
; ---------------------------------------------------------------------------

loc_7566E:
		move.b	#$24,routine(a0)
		move.w	#-$80,y_vel(a0)
		move.w	#$3F,$2E(a0)
		move.l	#loc_7568A,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_7568A:
		move.b	#$26,routine(a0)
		bra.w	loc_75302
; ---------------------------------------------------------------------------

loc_75694:
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		btst	#2,$38(a0)
		bne.s	loc_756AA
		rts
; ---------------------------------------------------------------------------

loc_756AA:
		move.b	#$28,routine(a0)
		move.b	#0,mapping_frame(a0)
		move.w	#-$200,y_vel(a0)
		move.l	#byte_75EAE,$30(a0)
		rts
; ---------------------------------------------------------------------------

loc_756C6:
		jsr	(Animate_RawMultiDelay).l
		jsr	(MoveSprite2).l
		move.w	(Camera_Y_pos).w,d0
		addi.w	#$30,d0
		cmp.w	y_pos(a0),d0
		bhs.s	loc_756E2
		rts
; ---------------------------------------------------------------------------

loc_756E2:
		move.b	#$2A,routine(a0)
		move.w	d0,y_pos(a0)
		move.w	#$1F,$2E(a0)
		move.l	#loc_75708,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_756FC:
		jsr	(Animate_RawMultiDelay).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_75708:
		move.b	#$2C,routine(a0)
		move.w	#-$400,x_vel(a0)
		move.w	#$700,y_vel(a0)
		rts
; ---------------------------------------------------------------------------

loc_7571C:
		jsr	(Animate_RawMultiDelay).l
		move.w	y_vel(a0),d0
		addi.w	#-$48,d0
		cmpi.w	#-$700,d0
		blt.s	loc_75734
		move.w	d0,y_vel(a0)

loc_75734:
		jsr	(MoveSprite2).l
		move.w	(Camera_Y_pos).w,d0
		subi.w	#$80,d0
		cmp.w	y_pos(a0),d0
		bhs.s	loc_7574A
		rts
; ---------------------------------------------------------------------------

loc_7574A:
		move.b	#$2E,routine(a0)
		move.b	#5,mapping_frame(a0)
		move.w	(Camera_X_pos_copy).w,d0
		addi.w	#$30,d0
		move.w	d0,x_pos(a0)
		move.w	(Camera_Y_pos_copy).w,d0
		subi.w	#$5C,d0
		move.w	d0,y_pos(a0)
		move.w	#$400,x_vel(a0)
		move.w	#$400,y_vel(a0)
		move.w	#$37,$2E(a0)
		move.l	#loc_75330,$34(a0)
		clr.b	anim_frame(a0)
		clr.b	anim_frame_timer(a0)
		move.l	#byte_75F0D,$30(a0)
		bclr	#2,$38(a0)
		rts
; ---------------------------------------------------------------------------

loc_757A0:
		move.w	y_vel(a0),d0
		addi.w	#-$10,d0
		bmi.s	loc_757AE
		move.w	d0,y_vel(a0)

loc_757AE:
		jsr	(MoveSprite2).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_757BA:
		jmp	(Obj_EndSignControl).l
; ---------------------------------------------------------------------------

loc_757C0:
		move.l	#loc_757D6,(a0)
		bset	#4,shield_reaction(a0)
		lea	word_75E5E(pc),a1
		jmp	(SetUp_ObjAttributes2).l
; ---------------------------------------------------------------------------

loc_757D6:
		bsr.w	sub_75C8A
		jsr	(Refresh_ChildPositionAdjusted).l
		movea.w	parent3(a0),a1
		btst	#6,$38(a1)
		bne.w	loc_7582A
		move.b	(V_int_run_count+3).w,d0
		btst	#0,d0
		bne.w	loc_7582A
		andi.b	#$F,d0
		bne.s	loc_75824
		tst.b	render_flags(a0)
		bpl.s	loc_75824
		jsr	(AllocateObject).l
		bne.s	loc_75824
		move.l	#loc_759FC,(a1)
		move.w	a0,parent3(a1)
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)

loc_75824:
		jmp	(Child_DrawTouch_Sprite).l
; ---------------------------------------------------------------------------

loc_7582A:
		btst	#7,status(a1)
		bne.s	loc_75834
		rts
; ---------------------------------------------------------------------------

loc_75834:
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

loc_7583A:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_7584E(pc,d0.w),d1
		jsr	off_7584E(pc,d1.w)
		jmp	(Child_DrawTouch_Sprite).l
; ---------------------------------------------------------------------------
off_7584E:
		dc.w loc_7585A-off_7584E
		dc.w loc_7589E-off_7584E
		dc.w loc_7592A-off_7584E
		dc.w loc_75924-off_7584E
		dc.w loc_7592A-off_7584E
		dc.w loc_75986-off_7584E
; ---------------------------------------------------------------------------

loc_7585A:
		lea	word_75E7E(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.b	#6,y_radius(a0)
		move.w	#-$300,y_vel(a0)
		move.l	#byte_75F1C,$30(a0)
		moveq	#0,d0
		lea	(Player_1).w,a1
		move.w	x_pos(a1),d0
		sub.w	x_pos(a0),d0
		beq.s	loc_7589A
		smi	d1
		bpl.s	loc_7588E
		neg.w	d0

loc_7588E:
		swap	d0
		divu.w	#$3800,d0
		tst.b	d1
		beq.s	loc_7589A
		neg.w	d0

loc_7589A:
		move.w	d0,x_vel(a0)

loc_7589E:
		jsr	(MoveSprite_LightGravity).l
		tst.w	y_vel(a0)
		bmi.s	loc_758B8
		jsr	(ObjCheckFloorDist).l
		tst.w	d1
		bpl.s	loc_758B8
		bsr.w	sub_758BE

loc_758B8:
		jmp	(Animate_RawMultiDelay).l

; =============== S U B R O U T I N E =======================================


sub_758BE:
		bset	#7,$38(a0)
		bne.s	loc_758E2
		add.w	d1,y_pos(a0)
		move.w	x_vel(a0),d0
		asr.w	#1,d0
		move.w	d0,x_vel(a0)
		move.w	y_vel(a0),d0
		asr.w	#1,d0
		neg.w	d0
		move.w	d0,y_vel(a0)
		rts
; ---------------------------------------------------------------------------

loc_758E2:
		move.b	#4,routine(a0)
		add.w	d1,y_pos(a0)
		move.w	#$1F,$2E(a0)
		move.l	#loc_758FC,$34(a0)
		rts
; End of function sub_758BE

; ---------------------------------------------------------------------------

loc_758FC:
		move.b	#6,routine(a0)
		clr.w	x_vel(a0)
		move.w	#-$200,y_vel(a0)
		move.w	#$1F,$2E(a0)
		move.l	#loc_75936,$34(a0)
		lea	ChildObjDat_75EA6(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_75924:
		jsr	(MoveSprite2).l

loc_7592A:
		jsr	(Animate_RawMultiDelay).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_75936:
		move.b	#8,routine(a0)
		move.w	#$1F,$2E(a0)
		move.l	#loc_7594C,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_7594C:
		move.b	#$A,routine(a0)
		move.w	#$180,priority(a0)
		move.w	#-$300,y_vel(a0)
		movea.w	parent3(a0),a1
		moveq	#0,d0
		move.w	x_pos(a1),d0
		subq.w	#6,d0
		sub.w	x_pos(a0),d0
		smi	d1
		bpl.s	loc_75974
		neg.w	d0

loc_75974:
		swap	d0
		divu.w	#$6100,d0
		tst.b	d1
		beq.s	loc_75980
		neg.w	d0

loc_75980:
		move.w	d0,x_vel(a0)
		rts
; ---------------------------------------------------------------------------

loc_75986:
		addi.w	#$10,y_vel(a0)
		jsr	(MoveSprite2).l
		tst.w	y_vel(a0)
		bmi.s	loc_759AA
		movea.w	parent3(a0),a1
		move.w	y_pos(a1),d0
		addi.w	#-8,d0
		cmp.w	y_pos(a0),d0
		bls.s	loc_759B0

loc_759AA:
		jmp	(Animate_RawMultiDelay).l
; ---------------------------------------------------------------------------

loc_759B0:
		movea.w	parent3(a0),a1
		bset	#2,$38(a1)
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

loc_759C0:
		lea	word_75E5E(pc),a1
		jsr	(SetUp_ObjAttributes2).l
		move.l	#loc_759D0,(a0)

loc_759D0:
		movea.w	parent3(a0),a1
		move.b	(V_int_run_count+3).w,d0
		btst	#0,d0
		bne.w	loc_759EC
		jsr	(Refresh_ChildPosition).l
		jmp	(Child_DrawTouch_Sprite).l
; ---------------------------------------------------------------------------

loc_759EC:
		btst	#7,status(a1)
		bne.s	loc_759F6
		rts
; ---------------------------------------------------------------------------

loc_759F6:
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

loc_759FC:
		lea	(ObjDat3_6646E).l,a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_75A24,(a0)
		bsr.w	sub_75C06
		move.w	(Camera_Y_pos).w,d0
		addi.w	#$AC,d0
		move.w	d0,y_pos(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_75A24:
		move.w	x_vel(a0),d0
		add.w	$40(a0),d0
		cmpi.w	#-$100,d0
		ble.s	loc_75A44
		cmpi.w	#$100,d0
		bge.s	loc_75A48
		move.l	#loc_75A48,(a0)
		bset	#0,$38(a0)

loc_75A44:
		move.w	d0,x_vel(a0)

loc_75A48:
		move.w	y_vel(a0),d0
		move.w	$3E(a0),d1
		btst	#0,$38(a0)
		beq.s	loc_75A5A
		moveq	#-1,d1

loc_75A5A:
		sub.w	d1,d0
		cmpi.w	#$80,d0
		blt.s	loc_75A68
		move.l	#loc_75A6C,(a0)

loc_75A68:
		move.w	d0,y_vel(a0)

loc_75A6C:
		jsr	(MoveSprite2).l
		tst.b	render_flags(a0)
		bpl.s	loc_75A7E
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_75A7E:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

Obj_MHZMinibossTree:
		lea	ObjDat_MHZMinibossTree(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_75A94,(a0)

loc_75A94:
		move.w	(_unkFAA4).w,d0
		beq.s	loc_75ACE
		movea.w	d0,a1
		cmpi.l	#Obj_MHZMiniboss,(a1)
		bne.s	loc_75ACE
		tst.b	render_flags(a0)
		bmi.s	loc_75AB0
		move.b	#5,$42(a1)

loc_75AB0:
		move.b	$42(a1),d0
		cmp.b	mapping_frame(a0),d0
		beq.s	loc_75ACE
		move.b	d0,mapping_frame(a0)
		cmpi.b	#5,d0
		bhs.s	loc_75ACE
		lea	ChildObjDat_75E98(pc),a2
		jsr	(CreateChild6_Simple).l

loc_75ACE:
		jmp	(Sprite_CheckDelete).l
; ---------------------------------------------------------------------------

loc_75AD4:
		lea	ObjDat3_75E72(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_75B34,(a0)
		move.b	#$18,y_radius(a0)
		movea.w	(_unkFAA4).w,a1
		moveq	#0,d2
		move.b	$42(a1),d2
		move.b	byte_75B2E(pc,d2.w),d3
		ext.w	d3
		add.w	d3,y_pos(a0)
		jsr	(Random_Number).l
		cmpi.b	#2,(Player_1+character_id).w
		beq.s	loc_75B0E
		moveq	#0,d0

loc_75B0E:
		move.w	#-$400,d1
		btst	#0,d0
		beq.s	loc_75B24
		tst.b	d2
		beq.s	loc_75B24
		move.w	#-$200,d1
		sne	$3A(a0)

loc_75B24:
		move.w	d1,x_vel(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
byte_75B2E:
		dc.b  $40, $20,   0,-$20,-$40,   0
		even
; ---------------------------------------------------------------------------

loc_75B34:
		lea	byte_75F12(pc),a1
		jsr	(Animate_RawNoSST).l
		tst.b	$3A(a0)
		beq.s	loc_75B58
		addi.w	#$20,y_vel(a0)
		jsr	(ObjCheckFloorDist).l
		tst.w	d1
		bpl.s	loc_75B58
		neg.w	y_vel(a0)

loc_75B58:
		jsr	(MoveSprite2).l
		jmp	(Sprite_CheckDeleteTouch).l
; ---------------------------------------------------------------------------

loc_75B64:
		bsr.w	sub_75B6E
		jmp	(Child_AddToTouchList).l

; =============== S U B R O U T I N E =======================================


sub_75B6E:
		movea.w	parent3(a0),a1
		moveq	#0,d0
		move.b	mapping_frame(a1),d0
		lsl.w	#2,d0
		lea	byte_75BAE(pc,d0.w),a2
		move.b	(a2)+,d0
		ext.w	d0
		move.w	x_pos(a1),d1
		btst	#0,render_flags(a1)
		beq.s	loc_75B90
		neg.w	d0

loc_75B90:
		add.w	d0,d1
		move.w	d1,x_pos(a0)
		move.b	(a2)+,d0
		ext.w	d0
		move.w	y_pos(a1),d1
		add.w	d0,d1
		move.w	d1,y_pos(a0)
		move.b	(a2)+,collision_flags(a0)
		move.b	(a2)+,mapping_frame(a0)
		rts
; End of function sub_75B6E

; ---------------------------------------------------------------------------
byte_75BAE:
		dc.b -$2A, $28, $A3,  $B
		dc.b -$2A, $29, $A3,  $B
		dc.b -$2A, $2A, $A3,  $B
		dc.b -$2A, $2B, $A3,  $B
		dc.b -$38,-$10, $9A,  $A
		dc.b -$38,-$10, $9A,  $A
		dc.b -$38,-$10, $9A,  $A
		dc.b -$28, -$B, $9A,  $A
		dc.b -$31, -$B, $9A,  $A
		dc.b   -8,  -8, $9A,  $A
		dc.b -$11,  -8, $9A,  $A
		dc.b  $24,  $E, $9B,   4
		dc.b  $24,  $D, $9B,   4
		dc.b    0,   0,   0,   0
		dc.b  $24,  $E, $9B,   4
		dc.b    0,   0,   0,   0
		dc.b  $2B,  $E, $9B,   4
		dc.b  $2A,  $E, $9B,   4
		dc.b  $29,  $E, $9B,   4
		dc.b    0,   0,   0,   0
		dc.b -$21, $28, $A3,  $B
		dc.b -$2A, $28, $A3,  $B
		even

; =============== S U B R O U T I N E =======================================


sub_75C06:
		move.w	(Camera_Y_pos).w,d2
		addi.w	#$E0,d2
		sub.w	y_pos(a0),d2
		lsr.w	#3,d2
		andi.w	#$1E,d2
		jsr	(Random_Number).l
		move.w	word_75C4A(pc,d2.w),d3
		andi.w	#$1FF,d0
		add.w	d0,d3
		moveq	#-$C,d4
		btst	#1,d0
		beq.s	loc_75C34
		neg.w	d3
		neg.w	d4

loc_75C34:
		move.w	d3,x_vel(a0)
		move.w	d4,$40(a0)
		swap	d0
		andi.w	#$F,d0
		addq.w	#8,d0
		move.w	d0,$3E(a0)
		rts
; End of function sub_75C06

; ---------------------------------------------------------------------------
word_75C4A:
		dc.w   $400
		dc.w   $400
		dc.w   $400
		dc.w   $400
		dc.w   $380
		dc.w   $300
		dc.w   $280
		dc.w   $200
		dc.w   $180
		dc.w   $140
		dc.w   $100
		dc.w    $C0
		dc.w    $80
		dc.w    $80
		dc.w    $80
		dc.w    $80
		dc.w    $40
		dc.w    $40
		dc.w    $40
		dc.w    $40
		dc.w    $3C
		dc.w    $38
		dc.w    $34
		dc.w    $30
		dc.w    $2C
		dc.w    $28
		dc.w    $24
		dc.w    $20
		dc.w    $1C
		dc.w    $18
		dc.w    $14
		dc.w    $10

; =============== S U B R O U T I N E =======================================


sub_75C8A:
		movea.w	parent3(a0),a1
		moveq	#0,d0
		move.b	mapping_frame(a1),d0
		move.b	RawAni_75CB6(pc,d0.w),mapping_frame(a0)
		add.w	d0,d0
		move.w	d0,d1
		lea	word_75CCC(pc,d0.w),a2
		move.w	(a2)+,priority(a0)
		add.w	d1,d1
		add.b	subtype(a0),d1
		lea	byte_75CF8(pc,d1.w),a2
		move.w	(a2)+,child_dx(a0)	; and child_dy
		rts
; End of function sub_75C8A

; ---------------------------------------------------------------------------
RawAni_75CB6:
		dc.b  $16, $16, $16, $16, $16, $17, $16, $16, $16, $16, $16, $16, $16, $16, $16, $16, $16, $16, $16, $16
		dc.b  $16, $16
		even
word_75CCC:
		dc.w   $280
		dc.w   $280
		dc.w   $280
		dc.w   $280
		dc.w   $280
		dc.w   $280
		dc.w   $280
		dc.w   $280
		dc.w   $280
		dc.w   $280
		dc.w   $280
		dc.w   $180
		dc.w   $180
		dc.w   $180
		dc.w   $180
		dc.w   $180
		dc.w   $280
		dc.w   $280
		dc.w   $280
		dc.w   $180
		dc.w   $280
		dc.w   $280
byte_75CF8:
		dc.b   $B, $1C
		dc.b    1, $1C
		dc.b   $B, $1C
		dc.b    1, $1C
		dc.b   $B, $1C
		dc.b    1, $1C
		dc.b   $B, $1C
		dc.b    1, $1C
		dc.b   -8, $1C
		dc.b   -1, $1C
		dc.b -$18, $12
		dc.b -$11, $12
		dc.b   -8, $1C
		dc.b   -1, $1C
		dc.b   -8, $1C
		dc.b   -1, $1C
		dc.b -$11, $1C
		dc.b  -$A, $1C
		dc.b   -8, $1C
		dc.b   -1, $1C
		dc.b -$11, $1C
		dc.b  -$A, $1C
		dc.b   -8, $1C
		dc.b   $B, $1C
		dc.b   -8, $1B
		dc.b   $B, $1B
		dc.b   -8, $1C
		dc.b   $B, $1C
		dc.b   -8, $1C
		dc.b   $B, $1C
		dc.b   -8, $1C
		dc.b   $B, $1C
		dc.b   -8, $1C
		dc.b   -1, $1C
		dc.b -$10, $1C
		dc.b   -9, $1C
		dc.b -$11, $1C
		dc.b  -$A, $1C
		dc.b   -8, $1C
		dc.b   $B, $1C
		dc.b   $C, $1C
		dc.b    6, $1C
		dc.b   $B, $1C
		dc.b    1, $1C
		even

; =============== S U B R O U T I N E =======================================


sub_75D50:
		moveq	#0,d0
		move.b	mapping_frame(a0),d0
		move.w	#$200,priority(a0)
		move.b	byte_75D6A(pc,d0.w),d0
		beq.s	locret_75D68
		move.w	#$80,priority(a0)

locret_75D68:
		rts
; End of function sub_75D50

; ---------------------------------------------------------------------------
byte_75D6A:
		dc.b    0
		dc.b    0
		dc.b    0
		dc.b    0
		dc.b    1
		dc.b    1
		dc.b    1
		dc.b    1
		dc.b    1
		dc.b    0
		dc.b    0
		dc.b    0
		dc.b    0
		dc.b    0
		dc.b    0
		dc.b    0
		dc.b    0
		dc.b    0
		dc.b    0
		dc.b    0
		dc.b    0
		dc.b    0
		even

; =============== S U B R O U T I N E =======================================


sub_75D80:
		tst.b	collision_flags(a0)
		bne.s	locret_75DCA
		move.b	collision_property(a0),d0
		beq.s	loc_75DCC
		tst.b	$20(a0)
		bne.s	loc_75DA0
		move.b	#$20,$20(a0)
		moveq	#signextendB(sfx_BossHit),d0
		jsr	(Play_SFX).l


loc_75DA0:
		bset	#6,status(a0)
		moveq	#0,d0
		btst	#0,$20(a0)
		bne.s	loc_75DB4
		addi.w	#2*4,d0

loc_75DB4:
		bsr.w	sub_75DF4
		subq.b	#1,$20(a0)
		bne.s	locret_75DCA
		bclr	#6,status(a0)
		move.b	$25(a0),collision_flags(a0)

locret_75DCA:
		rts
; ---------------------------------------------------------------------------

loc_75DCC:
		move.l	#Wait_FadeToLevelMusic,(a0)
		move.l	#loc_757BA,$34(a0)
		lea	(Child6_CreateBossExplosion).l,a2
		jsr	(CreateChild6_Simple).l
		bne.s	loc_75DEE
		move.b	#$10,subtype(a1)

loc_75DEE:
		jmp	(BossDefeated_StopTimer).l
; End of function sub_75D80


; =============== S U B R O U T I N E =======================================


sub_75DF4:
		lea	word_75E02(pc),a1
		lea	word_75E0A(pc,d0.w),a2
		jmp	(CopyWordData_4).l
; End of function sub_75DF4

; ---------------------------------------------------------------------------
word_75E02:
		dc.w Normal_palette_line_2+$0E, Normal_palette_line_2+$16, Normal_palette_line_2+$1A, Normal_palette_line_2+$1C
word_75E0A:
		dc.w   $224,  $222,  $A64,  $642
		dc.w   $AAA,  $EEE,  $888,  $666
; ---------------------------------------------------------------------------

loc_75E1A:
		move.w	(Camera_max_X_pos).w,d0
		cmp.w	$34(a0),d0
		bne.s	loc_75E4C
		move.l	$30(a0),d1
		addi.l	#$4000,d1
		move.l	d1,$30(a0)
		swap	d1
		add.w	d1,d0
		cmp.w	(Camera_stored_max_X_pos).w,d0
		bhs.s	loc_75E46
		move.w	d0,(Camera_max_X_pos).w
		move.w	d0,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_75E46:
		move.w	(Camera_stored_max_X_pos).w,(Camera_max_X_pos).w

loc_75E4C:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------
ObjDat_MHZMiniboss:
		dc.l Map_MHZMiniboss
		dc.w make_art_tile($3AD,1,1)
		dc.w   $200
		dc.b  $48, $40,   0,  $F
word_75E5E:
		dc.w make_art_tile($3AD,0,1)
		dc.w   $280
		dc.b   $C,  $C, $16, $9A
ObjDat_MHZMinibossTree:
		dc.l Map_MHZMinibossTree
		dc.w make_art_tile($001,3,0)
		dc.w   $380
		dc.b  $14, $90,   5,   0
ObjDat3_75E72:
		dc.l Map_MHZMinibossLog
		dc.w make_art_tile($49F,3,0)
		dc.w   $380
		dc.b  $14, $14,   6, $86
word_75E7E:
		dc.w   $300
		dc.b    8,   8, $18, $8B
ChildObjDat_75E84:
		dc.w 1
		dc.l loc_757C0
		dc.b    0,   0
		dc.l loc_757C0
		dc.b    0,   0
		dc.l loc_75B64
		dc.b    0,   0
ChildObjDat_75E98:
		dc.w 1-1
		dc.l loc_75AD4
ChildObjDat_75E9E:
		dc.w 1-1
		dc.l loc_7583A
		dc.b    0,  -8
ChildObjDat_75EA6:
		dc.w 1-1
		dc.l loc_759C0
		dc.b    1, $13
byte_75EAE:
		dc.b    0,  $B
		dc.b    1,   5
		dc.b    2,   5
		dc.b    3,  $B
		dc.b    2,   5
		dc.b    1,   5
		dc.b  $FC
byte_75EBB:
		dc.b    4, $27
		dc.b    4, $27
		dc.b    7,   2
		dc.b    9,   2
		dc.b   $C,   2
		dc.b   $D, $3B
		dc.b   $B,   2
		dc.b    9,   2
		dc.b    7,   2
		dc.b    4, $27
		dc.b  $F4
byte_75ED0:
		dc.b    4, $27
		dc.b    4, $27
		dc.b    7,   2
		dc.b    9,   2
		dc.b   $C,   2
		dc.b   $D, $27
		dc.b  $10,   3
		dc.b  $11,   7
		dc.b  $12,   7
		dc.b  $11,   7
		dc.b  $12,   7
		dc.b  $11,   7
		dc.b  $12,   7
		dc.b  $11,   7
		dc.b  $12,   7
		dc.b  $11,   7
		dc.b  $12, $31
		dc.b  $F4
byte_75EF3:
		dc.b   $A,   3
		dc.b   $A,   3
		dc.b    8,   3
		dc.b    6,   3
		dc.b  $F8,  $A
		dc.b    6, $7F
		dc.b    6, $7F
		dc.b  $FC
byte_75F02:
		dc.b   $F, $31
		dc.b   $F, $31
		dc.b  $13,   4
		dc.b  $14,   4
		dc.b  $15,   4
		dc.b  $F4
byte_75F0D:
		dc.b    5, $7F
		dc.b    5, $7F
		dc.b  $FC
byte_75F12:
		dc.b    1,   0,   1,   2,   3,   4,   5,   6,   7, $FC
byte_75F1C:
		dc.b  $18,   3
		dc.b  $19,   3
		dc.b  $1A,   3
		dc.b  $1B,   3
		dc.b  $1C,  $B
		dc.b  $FC
		even
Pal_MHZMiniboss:
		binclude "Levels/MHZ/Palettes/Miniboss.bin"
		even
PLC_MHZMiniboss_Explosion: plrlistheader
		plreq $4D2, ArtNem_BossExplosion
PLC_MHZMiniboss_Explosion_End
; ---------------------------------------------------------------------------

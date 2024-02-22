word_7DDA4:
		dc.w   $18C,  $38C, $3400, $3780
		dc.w   $28C,  $28C, $3680, $36C0
; ---------------------------------------------------------------------------

Obj_DEZMiniboss:
		lea	word_7DDA4(pc),a1
		jsr	(Check_CameraInRange).l
		move.b	#mus_Miniboss,$26(a0)
		jsr	(sub_85D6A).l
		move.l	#loc_7DE28,(a0)
		move.l	#loc_7DE2C,$34(a0)
		lea	ObjDat_DEZMiniboss(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		clr.b	routine(a0)
		clr.b	collision_property(a0)
		clr.b	$42(a0)
		move.w	#$4000,$3A(a0)
		move.w	#$8000,$3C(a0)
		lea	ChildObjDat_7EF8E(pc),a2
		jsr	CreateChild1_Normal(pc)
		lea	ChildObjDat_7EF96(pc),a2
		jsr	CreateChild6_Simple(pc)
		moveq	#$7B,d0
		jsr	(Load_PLC).l
		lea	(ArtKosM_DEZMinibossMisc).l,a1
		move.w	#tiles_to_bytes($400),d2
		jsr	(Queue_Kos_Module).l
		lea	Pal_DEZMiniboss1(pc),a1
		jmp	PalLoad_Line1(pc)
; ---------------------------------------------------------------------------

loc_7DE28:
		jmp	loc_85CA4(pc)
; ---------------------------------------------------------------------------

loc_7DE2C:
		move.l	#loc_7DE46,(a0)
		addi.w	#$E0,(_unkFAB2).w
		addi.w	#$40,(_unkFAB4).w
		addi.w	#$100,(_unkFAB6).w

locret_7DE44:
		rts
; ---------------------------------------------------------------------------

loc_7DE46:
		addq.b	#4,$3C(a0)
		bpl.s	loc_7DE4E
		rts
; ---------------------------------------------------------------------------

loc_7DE4E:
		move.l	#loc_7DE6E,(a0)

loc_7DE54:
		move.b	#0,routine(a0)
		clr.w	$3C(a0)
		move.w	#$7F,$2E(a0)
		move.l	#loc_7DEA6,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_7DE6E:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_7DE92(pc,d0.w),d1
		jsr	off_7DE92(pc,d1.w)
		move.b	(V_int_run_count+3).w,d0
		andi.b	#$1F,d0
		bne.s	loc_7DE8E
		moveq	#signextendB(sfx_GravityTunnel),d0
		jsr	(Play_SFX).l

loc_7DE8E:
		bra.w	loc_7EE36
; ---------------------------------------------------------------------------
off_7DE92:
		dc.w loc_7DEA2-off_7DE92
		dc.w loc_7DEC6-off_7DE92
		dc.w loc_7DEA2-off_7DE92
		dc.w loc_7DF14-off_7DE92
		dc.w loc_7DEA2-off_7DE92
		dc.w loc_7DF40-off_7DE92
		dc.w loc_7DEA2-off_7DE92
		dc.w loc_7DF84-off_7DE92
; ---------------------------------------------------------------------------

loc_7DEA2:
		jmp	Obj_Wait(pc)
; ---------------------------------------------------------------------------

loc_7DEA6:
		move.b	#2,routine(a0)
		move.w	#$F,$2E(a0)
		move.l	#loc_7DEF6,$34(a0)
		move.b	#2,$39(a0)
		clr.w	$40(a0)
		rts
; ---------------------------------------------------------------------------

loc_7DEC6:
		move.w	$40(a0),d0
		move.w	$3C(a0),d1
		addi.w	#$20,d0
		add.w	d0,d1
		cmpi.w	#$7000,d1
		blo.s	loc_7DEEC
		move.w	#$7000,d1
		lsr.w	#1,d0
		neg.w	d0
		subq.b	#1,$39(a0)
		bpl.s	loc_7DEEC
		bsr.w	loc_7DEF6

loc_7DEEC:
		move.w	d0,$40(a0)
		move.w	d1,$3C(a0)
		rts
; ---------------------------------------------------------------------------

loc_7DEF6:
		move.b	#4,routine(a0)
		move.w	#$9F,$2E(a0)
		move.l	#loc_7DF0C,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_7DF0C:
		move.b	#6,routine(a0)
		rts
; ---------------------------------------------------------------------------

loc_7DF14:
		move.b	$3A(a0),d0
		addq.b	#2,d0
		bmi.s	loc_7DF22
		move.b	d0,$3A(a0)
		rts
; ---------------------------------------------------------------------------

loc_7DF22:
		move.b	#8,routine(a0)
		move.w	#$1F,$2E(a0)
		move.l	#loc_7DF38,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_7DF38:
		move.b	#$A,routine(a0)
		rts
; ---------------------------------------------------------------------------

loc_7DF40:
		move.b	$3A(a0),d0
		subq.b	#4,d0
		cmpi.b	#$40,d0
		bls.s	loc_7DF52
		move.b	d0,$3A(a0)
		rts
; ---------------------------------------------------------------------------

loc_7DF52:
		move.b	#$40,$3A(a0)
		move.b	#$C,routine(a0)
		move.w	#$9F,$2E(a0)
		move.l	#loc_7DF6E,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_7DF6E:
		move.b	#$E,routine(a0)
		move.w	#$1B,$2E(a0)
		move.l	#loc_7DE54,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_7DF84:
		subq.b	#4,$3C(a0)
		jmp	Obj_Wait(pc)
; ---------------------------------------------------------------------------

loc_7DF8C:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_7DF9A(pc,d0.w),d1
		jmp	off_7DF9A(pc,d1.w)
; ---------------------------------------------------------------------------
off_7DF9A:
		dc.w loc_7DFA2-off_7DF9A
		dc.w loc_7E00C-off_7DF9A
		dc.w loc_7E006-off_7DF9A
		dc.w loc_7E00C-off_7DF9A
; ---------------------------------------------------------------------------

loc_7DFA2:
		move.b	(V_int_run_count+3).w,d0
		andi.b	#7,d0
		bne.s	loc_7DFB4
		lea	ChildObjDat_7EFA2(pc),a2
		jsr	CreateChild6_Simple(pc)

loc_7DFB4:
		jmp	Obj_Wait(pc)
; ---------------------------------------------------------------------------

loc_7DFB8:
		move.b	#2,routine(a0)
		move.w	#$5F,$2E(a0)
		move.l	#loc_7DFDE,$34(a0)
		st	(Events_fg_4).w
		lea	ChildObjDat_7EFA8(pc),a2
		jsr	CreateChild1_Normal(pc)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_7DFDE:
		move.b	#4,routine(a0)
		bset	#5,$38(a0)
		move.w	#-$80,x_vel(a0)
		move.w	#$40,y_vel(a0)
		move.w	#$1F,$2E(a0)
		move.l	#loc_7E016,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_7E006:
		jsr	(MoveSprite2).l

loc_7E00C:
		jsr	Obj_Wait(pc)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_7E016:
		move.b	#6,routine(a0)
		move.w	#$1F,$2E(a0)
		move.l	#loc_7E044,$34(a0)
		move.w	#0,$3A(a0)
		move.w	#$200,$3C(a0)
		move.w	#$100,$26(a0)
		lea	ChildObjDat_7EFB6(pc),a2
		jmp	CreateChild8_TreeListRepeated(pc)
; ---------------------------------------------------------------------------

loc_7E044:
		move.l	#loc_7E0A6,(a0)
		clr.b	routine(a0)
		bclr	#6,status(a0)
		clr.b	collision_property(a0)
		clr.b	$42(a0)
		move.w	y_pos(a0),$30(a0)
		bclr	#5,$38(a0)
		jsr	(AllocateObject).l
		bne.s	sub_7E08C
		move.w	a0,parent3(a1)
		move.l	#Obj_SpriteMask,(a1)
		move.w	#$3740,x_pos(a1)
		move.w	#$360,y_pos(a1)
		move.b	#$89,subtype(a1)

; =============== S U B R O U T I N E =======================================


sub_7E08C:
		move.w	#$80,d0
		move.w	d0,$3E(a0)
		move.w	d0,y_vel(a0)
		move.w	#8,$40(a0)
		bclr	#0,$38(a0)
		rts
; End of function sub_7E08C

; ---------------------------------------------------------------------------

loc_7E0A6:
		move.b	(V_int_run_count+3).w,d0
		andi.b	#$3F,d0
		bne.s	loc_7E0B8
		moveq	#signextendB(sfx_WaveHover),d0
		jsr	(Play_SFX).l

loc_7E0B8:
		bsr.w	sub_7EE88
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_7E0CA(pc,d0.w),d1
		jmp	off_7E0CA(pc,d1.w)
; ---------------------------------------------------------------------------
off_7E0CA:
		dc.w loc_7E0D6-off_7E0CA
		dc.w loc_7E108-off_7E0CA
		dc.w loc_7E13C-off_7E0CA
		dc.w loc_7E186-off_7E0CA
		dc.w loc_7E1AC-off_7E0CA
		dc.w loc_7E1FC-off_7E0CA
; ---------------------------------------------------------------------------

loc_7E0D6:
		jsr	Swing_UpAndDown(pc)
		jsr	(MoveSprite2).l
		bsr.w	sub_7EC64
		bsr.w	sub_7EB8E
		btst	#1,$38(a0)
		beq.s	loc_7E0F4
		bsr.w	sub_7E0FA

loc_7E0F4:
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_7E0FA:
		move.b	#2,routine(a0)
		bset	#7,$38(a0)
		rts
; End of function sub_7E0FA

; ---------------------------------------------------------------------------

loc_7E108:
		jsr	Run_PalRotationScript(pc)
		jsr	Swing_UpAndDown(pc)
		jsr	(MoveSprite2).l
		bsr.w	sub_7EC84
		bsr.w	sub_7EB8E
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_7E124:
		move.b	#4,routine(a0)
		clr.w	x_vel(a0)
		bclr	#1,$38(a0)
		bset	#3,$38(a0)
		rts
; ---------------------------------------------------------------------------

loc_7E13C:
		jsr	Swing_UpAndDown(pc)
		jsr	(MoveSprite2).l
		btst	#1,$38(a0)
		bne.s	loc_7E15C
		btst	#3,$38(a0)
		beq.s	loc_7E16A
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_7E15C:
		bsr.s	sub_7E0FA
		bclr	#3,$38(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_7E16A:
		move.b	#6,routine(a0)
		clr.w	x_vel(a0)
		move.w	#-$400,y_vel(a0)
		bset	#2,$38(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_7E186:
		btst	#1,$38(a0)
		bne.s	loc_7E1A0
		addi.w	#$20,y_vel(a0)
		jsr	(MoveSprite2).l
		tst.w	y_vel(a0)
		bmi.s	loc_7E1A6

loc_7E1A0:
		move.b	#8,routine(a0)

loc_7E1A6:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_7E1AC:
		btst	#2,$38(a0)
		bne.s	loc_7E1DE
		move.b	#$A,routine(a0)
		move.w	#$100,y_vel(a0)
		clr.w	$3A(a0)
		btst	#1,$38(a0)
		bne.s	loc_7E1E4
		bset	#6,$38(a0)
		move.w	#$100,$26(a0)
		move.w	#$100,$3C(a0)

loc_7E1DE:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_7E1E4:
		bset	#7,$38(a0)
		move.w	#$800,$26(a0)
		move.w	#$800,$3C(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_7E1FC:
		jsr	(MoveSprite2).l
		move.w	$30(a0),d0
		cmp.w	y_pos(a0),d0
		bhi.s	loc_7E236
		move.w	d0,y_pos(a0)
		move.b	#0,routine(a0)
		bclr	#6,$38(a0)
		lea	(Player_1).w,a1
		jsr	Find_OtherObject(pc)
		move.w	#-$80,d1
		tst.w	d0
		beq.s	loc_7E22E
		neg.w	d1

loc_7E22E:
		move.w	d1,x_vel(a0)
		bsr.w	sub_7E08C

loc_7E236:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_7E23C:
		jsr	(AllocateObject).l
		bne.s	loc_7E24A
		move.l	#loc_7E25C,(a1)

loc_7E24A:
		bset	#5,$38(a0)
		lea	ChildObjDat_7EFD2(pc),a2
		jsr	CreateChild1_Normal(pc)
		jmp	Obj_EndSignControl(pc)
; ---------------------------------------------------------------------------

loc_7E25C:
		tst.b	(_unkFAA8).w
		beq.w	locret_7DE44
		move.l	#loc_7E26A,(a0)

loc_7E26A:
		tst.b	(_unkFAA8).w
		bne.w	locret_7DE44
		move.l	#loc_7E298,(a0)
		st	(Ctrl_1_locked).w
		jsr	(AllocateObject).l
		bne.s	loc_7E28A
		move.l	#loc_863C0,(a1)

loc_7E28A:
		cmpi.w	#$140,(Player_1+x_pos).w
		blo.s	loc_7E298
		bset	#3,$38(a0)

loc_7E298:
		lea	(Player_1).w,a1
		move.w	#$140,d0
		tst.w	x_vel(a0)
		btst	#3,$38(a0)
		bne.s	loc_7E2CA
		cmp.w	x_pos(a1),d0
		bls.s	loc_7E2E8
		moveq	#0,d1
		btst	#Status_Push,status(a1)
		beq.s	loc_7E2C0
		ori.w	#(button_A_mask<<8)|button_A_mask,d1

loc_7E2C0:
		ori.w	#(button_right_mask<<8)|button_right_mask,d1
		move.w	d1,(Ctrl_1_logical).w
		rts
; ---------------------------------------------------------------------------

loc_7E2CA:
		cmp.w	x_pos(a1),d0
		bhs.s	loc_7E2E8
		moveq	#0,d1
		btst	#Status_Push,status(a1)
		beq.s	loc_7E2DE
		ori.w	#(button_A_mask<<8)|button_A_mask,d1

loc_7E2DE:
		ori.w	#(button_left_mask<<8)|button_left_mask,d1
		move.w	d1,(Ctrl_1_logical).w
		rts
; ---------------------------------------------------------------------------

loc_7E2E8:
		move.w	d0,x_pos(a1)
		move.l	#loc_7E342,(a0)
		jsr	Stop_Object(pc)
		clr.w	(Ctrl_1_logical).w
		move.w	#$1F,$2E(a0)
		jsr	(AllocateObject).l
		bne.s	loc_7E320
		move.l	#Obj_CreateBossExplosion,(a1)
		move.w	#$100,x_pos(a1)
		move.w	#$760,y_pos(a1)
		move.b	#$14,subtype(a1)

loc_7E320:
		jsr	(AllocateObject).l
		bne.s	locret_7E340
		move.l	#Obj_CreateBossExplosion,(a1)
		move.w	#$180,x_pos(a1)
		move.w	#$760,y_pos(a1)
		move.b	#$14,subtype(a1)

locret_7E340:
		rts
; ---------------------------------------------------------------------------

loc_7E342:
		subq.w	#1,$2E(a0)
		bpl.s	locret_7E382
		move.l	#loc_7E384,(a0)
		st	(Events_fg_4).w
		move.w	#0,(Camera_stored_min_Y_pos).w
		jsr	(AllocateObject).l
		bne.s	loc_7E366
		move.l	#Obj_DecLevStartYGradual,(a1)

loc_7E366:
		move.w	#$2000,(Camera_stored_max_Y_pos).w
		jsr	(AllocateObject).l
		bne.s	loc_7E37A
		move.l	#Obj_IncLevEndYGradual,(a1)

loc_7E37A:
		moveq	#signextendB(sfx_BigRumble),d0
		jsr	(Play_SFX).l

locret_7E382:
		rts
; ---------------------------------------------------------------------------

loc_7E384:
		lea	(Player_1).w,a1
		cmpi.w	#$360,y_pos(a1)
		blo.s	locret_7E3C8
		btst	#1,status(a1)
		bne.s	locret_7E3C8
		move.l	#loc_7E3CA,(a0)
		move.b	#$83,object_control(a1)
		move.b	#0,anim(a1)
		jsr	(Stop_Object).l
		bclr	#Status_Push,status(a1)
		bset	#Status_InAir,status(a1)
		bclr	#Status_Facing,status(a1)
		bclr	#0,render_flags(a1)

locret_7E3C8:
		rts
; ---------------------------------------------------------------------------

loc_7E3CA:
		addq.w	#8,$1C(a0)
		cmpi.w	#$300,$1C(a0)
		bne.s	loc_7E3E8
		move.l	#loc_7E3EC,(a0)
		move.w	#$24,$2E(a0)
		bclr	#7,(Player_1+art_tile).w

loc_7E3E8:
		bra.w	sub_7EEEE
; ---------------------------------------------------------------------------

loc_7E3EC:
		subq.w	#1,$2E(a0)
		bpl.s	loc_7E416
		move.l	#loc_7E420,(a0)
		move.w	#-$1000,y_vel(a0)
		lea	(Player_1).w,a1
		move.w	x_pos(a1),x_pos(a0)
		move.w	y_pos(a1),y_pos(a0)
		moveq	#signextendB(sfx_SuperTransform),d0
		jsr	(Play_SFX).l

loc_7E416:
		subi.w	#$10,(Player_1+y_pos).w
		bra.w	sub_7EEEE
; ---------------------------------------------------------------------------

loc_7E420:
		bsr.w	sub_7EEEE
		tst.w	y_vel(a0)
		bmi.s	loc_7E44C
		move.l	#loc_7E44C,(a0)
		jsr	(sub_5FD88).l
		lea	(Player_1).w,a1
		bclr	#0,render_flags(a1)
		bclr	#Status_Facing,status(a1)
		move.w	#5<<8,anim(a1)	; and prev_anim

loc_7E44C:
		jsr	(MoveSprite).l
		tst.w	y_vel(a0)
		bmi.s	loc_7E490
		move.w	#$3AC,d0
		cmpi.w	#2,(Player_mode).w
		bne.s	loc_7E468
		move.w	#$3B0,d0

loc_7E468:
		cmp.w	y_pos(a0),d0
		bhi.s	loc_7E490
		move.w	d0,y_pos(a0)
		move.l	#loc_7E4A2,(a0)
		move.w	#(2*60)-1,$2E(a0)
		jsr	(AllocateObject).l
		bne.s	loc_7E490
		move.l	#Obj_TitleCard,(a1)
		st	$3E(a1)

loc_7E490:
		lea	(Player_1).w,a1
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		rts
; ---------------------------------------------------------------------------

loc_7E4A2:
		subq.w	#1,$2E(a0)
		bpl.w	locret_7DE44
		lea	(Pal_DEZMiniboss2).l,a1
		lea	(Normal_palette_line_2).w,a2
		moveq	#bytesToLcnt($20),d6

loc_7E4B6:
		move.l	(a1)+,(a2)+
		dbf	d6,loc_7E4B6
		clr.b	(Player_1+object_control).w
		clr.b	(Ctrl_1_locked).w
		clr.b	(Ctrl_2_locked).w
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_7E4CE:
		lea	word_7EF70(pc),a1
		jsr	SetUp_ObjAttributes3(pc)
		addi.w	#$C,y_pos(a0)
		move.b	#0,child_dx(a0)
		move.b	#$C,child_dy(a0)
		move.w	#-$200,d0
		moveq	#-$40,d1
		tst.b	subtype(a0)
		beq.s	loc_7E4F8
		neg.w	d0
		moveq	#$40,d1

loc_7E4F8:
		move.w	d0,x_vel(a0)
		move.b	d1,$3C(a0)
		move.w	#$1F,$2E(a0)
		move.l	#loc_7E52A,$34(a0)
		move.l	#loc_7E51C,(a0)
		lea	ChildObjDat_7EFBC(pc),a2
		jsr	CreateChild1_Normal(pc)

loc_7E51C:
		jsr	(MoveSprite2).l
		jsr	Obj_Wait(pc)
		bra.w	loc_7EC46
; ---------------------------------------------------------------------------

loc_7E52A:
		move.l	#loc_7E566,(a0)
		tst.b	subtype(a0)
		beq.s	locret_7E54A
		move.l	#loc_7E54C,(a0)
		movea.w	parent3(a0),a1
		move.w	a0,$44(a1)
		move.w	$44(a0),parent3(a0)

locret_7E54A:
		rts
; ---------------------------------------------------------------------------

loc_7E54C:
		movea.w	parent3(a0),a1
		btst	#7,$38(a1)
		bne.s	loc_7E582
		bclr	#3,$38(a0)
		bne.w	loc_7E63E
		bra.w	loc_7EBF2
; ---------------------------------------------------------------------------

loc_7E566:
		movea.w	parent3(a0),a1
		btst	#7,$38(a1)
		bne.s	loc_7E582
		btst	#3,$38(a1)
		bne.s	loc_7E590

loc_7E57A:
		bsr.w	sub_7EBC2
		bra.w	loc_7EBF2
; ---------------------------------------------------------------------------

loc_7E582:
		move.l	#loc_7E6E8,(a0)
		move.w	#$4000,$3A(a0)
		bra.s	loc_7E57A
; ---------------------------------------------------------------------------

loc_7E590:
		move.l	#loc_7E598,(a0)
		bra.s	loc_7E57A
; ---------------------------------------------------------------------------

loc_7E598:
		movea.w	parent3(a0),a1
		btst	#7,$38(a1)
		bne.s	loc_7E582
		bsr.w	sub_7EBC2
		movea.w	parent3(a0),a1
		move.b	$3C(a0),d0
		tst.w	$3C(a1)
		bmi.s	loc_7E5C4
		subi.b	#$40,d0
		cmpi.b	#$10,d0
		bls.s	loc_7E5CE
		bra.w	loc_7E5D4
; ---------------------------------------------------------------------------

loc_7E5C4:
		subi.b	#$30,d0
		cmpi.b	#$10,d0
		bhi.s	loc_7E5D4

loc_7E5CE:
		move.l	#loc_7E5D8,(a0)

loc_7E5D4:
		bra.w	loc_7EBF2
; ---------------------------------------------------------------------------

loc_7E5D8:
		movea.w	parent3(a0),a1
		move.w	$3C(a0),d0
		btst	#7,$38(a1)
		bne.s	loc_7E582
		move.w	$3A(a1),d1
		move.w	$3C(a1),d2
		bmi.s	loc_7E606
		subi.w	#$100,d1
		add.w	d1,d0
		tst.w	d1
		bpl.s	loc_7E616
		cmpi.w	#$4000,d0
		blo.s	loc_7E622
		bra.w	loc_7E616
; ---------------------------------------------------------------------------

loc_7E606:
		addi.w	#$100,d1
		add.w	d1,d0
		tst.w	d1
		bmi.s	loc_7E616
		cmpi.w	#$4000,d0
		bhi.s	loc_7E622

loc_7E616:
		move.w	d0,$3C(a0)
		move.w	d1,$3A(a1)
		bra.w	loc_7EBF2
; ---------------------------------------------------------------------------

loc_7E622:
		move.w	#$4000,d0
		move.w	d0,$3C(a0)
		move.w	d1,$3A(a1)
		bclr	#3,$38(a1)
		movea.w	$44(a0),a2
		bset	#3,$38(a2)

loc_7E63E:
		move.l	#loc_7E64C,(a0)
		clr.w	x_vel(a0)
		bra.w	loc_7EBF2
; ---------------------------------------------------------------------------

loc_7E64C:
		movea.w	parent3(a0),a1
		btst	#2,$38(a1)
		beq.s	loc_7E664
		move.l	#loc_7E668,(a0)
		move.w	#7,$2E(a0)

loc_7E664:
		bra.w	loc_7EC46
; ---------------------------------------------------------------------------

loc_7E668:
		subq.w	#1,$2E(a0)
		bpl.s	loc_7E67A
		move.l	#loc_7E67E,(a0)
		move.w	#-$400,y_vel(a0)

loc_7E67A:
		bra.w	loc_7EC46
; ---------------------------------------------------------------------------

loc_7E67E:
		addi.w	#$20,y_vel(a0)
		jsr	(MoveSprite2).l
		movea.w	parent3(a0),a1
		move.w	y_pos(a1),d0
		addi.w	#$C,d0
		tst.w	y_vel(a0)
		bpl.s	loc_7E6A2
		cmp.w	y_pos(a0),d0
		blo.s	loc_7E6B2

loc_7E6A2:
		move.w	d0,y_pos(a0)
		move.l	#loc_7E6B6,(a0)
		bclr	#2,$38(a1)

loc_7E6B2:
		bra.w	loc_7EC46
; ---------------------------------------------------------------------------

loc_7E6B6:
		movea.w	parent3(a0),a1
		btst	#7,$38(a1)
		bne.w	loc_7E582
		btst	#6,$38(a1)
		beq.s	loc_7E6D0
		bsr.w	sub_7E6D4

loc_7E6D0:
		bra.w	loc_7EBF2

; =============== S U B R O U T I N E =======================================


sub_7E6D4:
		move.l	#loc_7E566,(a0)
		tst.b	subtype(a0)
		beq.s	locret_7E6E6
		move.l	#loc_7E54C,(a0)

locret_7E6E6:
		rts
; ---------------------------------------------------------------------------

loc_7E6E8:
		bsr.w	sub_7EBC2
		move.b	$3A(a0),d0
		addq.b	#1,d0
		cmpi.b	#$60,d0
		bhs.s	loc_7E700
		move.b	d0,$3A(a0)
		bra.w	loc_7EC52
; ---------------------------------------------------------------------------

loc_7E700:
		move.l	#loc_7E710,(a0)
		move.w	#$3F,$2E(a0)
		bra.w	loc_7EC52
; ---------------------------------------------------------------------------

loc_7E710:
		subq.w	#1,$2E(a0)
		bpl.s	loc_7E71C
		move.l	#loc_7E724,(a0)

loc_7E71C:
		bsr.w	sub_7EBC2
		bra.w	loc_7EC52
; ---------------------------------------------------------------------------

loc_7E724:
		bsr.w	sub_7EBC2
		move.b	$3A(a0),d0
		subq.b	#1,d0
		cmpi.b	#$40,d0
		bhi.s	loc_7E742
		bsr.s	sub_7E6D4
		movea.w	parent3(a0),a1
		bclr	#7,$38(a1)
		moveq	#$40,d0

loc_7E742:
		move.b	d0,$3A(a0)
		bra.w	loc_7EC52
; End of function sub_7E6D4

; ---------------------------------------------------------------------------

loc_7E74A:
		lea	word_7EF76(pc),a1
		jsr	SetUp_ObjAttributes3(pc)
		move.l	#loc_7E758,(a0)

loc_7E758:
		lea	byte_7EFEC(pc),a1
		jsr	Animate_RawNoSST(pc)
		jsr	Refresh_ChildPosition(pc)
		jmp	Child_DrawTouch_Sprite2(pc)
; ---------------------------------------------------------------------------

loc_7E768:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_7E77C(pc,d0.w),d1
		jsr	off_7E77C(pc,d1.w)
		moveq	#$14,d0
		jmp	Child_Draw_Sprite_FlickerMove(pc)
; ---------------------------------------------------------------------------
off_7E77C:
		dc.w loc_7E786-off_7E77C
		dc.w loc_7E79C-off_7E77C
		dc.w loc_7E7B4-off_7E77C
		dc.w loc_7E7D6-off_7E77C
		dc.w loc_7E800-off_7E77C
; ---------------------------------------------------------------------------

loc_7E786:
		lea	word_7EF52(pc),a1
		jsr	SetUp_ObjAttributes3(pc)
		move.b	#-1,collision_property(a0)
		movea.w	parent3(a0),a1
		move.w	d0,$44(a1)

loc_7E79C:
		bsr.w	sub_7ED6C
		movea.w	parent3(a0),a1
		cmpi.l	#loc_7DE6E,(a1)
		beq.s	loc_7E7AE
		rts
; ---------------------------------------------------------------------------

loc_7E7AE:
		move.b	#4,routine(a0)

loc_7E7B4:
		bsr.w	sub_7ED6C
		bsr.w	sub_7EDD0
		movea.w	parent3(a0),a1
		btst	#6,status(a1)
		bne.s	loc_7E7CE
		jmp	(Add_SpriteToCollisionResponseList).l
; ---------------------------------------------------------------------------

loc_7E7CE:
		move.b	#6,routine(a0)
		rts
; ---------------------------------------------------------------------------

loc_7E7D6:
		bsr.w	sub_7ED6C
		movea.w	parent3(a0),a1
		btst	#6,status(a1)
		beq.s	loc_7E7E8
		rts
; ---------------------------------------------------------------------------

loc_7E7E8:
		move.b	#8,routine(a0)
		move.b	#-1,collision_property(a0)
		move.b	#$17,collision_flags(a0)
		clr.b	anim(a0)
		rts
; ---------------------------------------------------------------------------

loc_7E800:
		bsr.w	sub_7ED6C
		bsr.w	sub_7EDD0
		jmp	(Add_SpriteToCollisionResponseList).l
; ---------------------------------------------------------------------------

loc_7E80E:
		lea	word_7EF58(pc),a1
		jsr	SetUp_ObjAttributes3(pc)
		move.l	#loc_7E820,(a0)
		bsr.w	sub_7ED54

loc_7E820:
		bsr.w	sub_7EB76
		addq.b	#4,$3C(a0)
		movea.w	parent3(a0),a1
		btst	#1,$38(a1)
		bne.s	loc_7E89C
		move.b	$3C(a0),d0
		jsr	(GetSineCosine).l
		move.w	$3A(a1),d1
		muls.w	d1,d0
		swap	d0
		move.w	d0,d1
		add.w	x_pos(a1),d0
		move.w	d0,x_pos(a0)
		addi.w	#$20,d1
		cmpi.w	#$40,d1
		scs	d5
		move.b	$3C(a1),d0
		ext.w	d0
		add.w	y_pos(a1),d0
		move.w	d0,y_pos(a0)
		move.b	$3C(a0),d0
		bpl.s	loc_7E870
		not.b	d0

loc_7E870:
		lsr.w	#2,d0
		andi.w	#$1C,d0
		lea	byte_7E8C2(pc,d0.w),a2
		move.b	(a2)+,mapping_frame(a0)
		bclr	#7,art_tile(a0)
		move.b	(a2)+,d1
		or.b	d1,art_tile(a0)
		move.w	(a2)+,priority(a0)
		tst.b	d5
		beq.s	loc_7E898
		tst.b	d1
		beq.w	locret_7DE44

loc_7E898:
		jmp	Draw_And_Touch_Sprite(pc)
; ---------------------------------------------------------------------------

loc_7E89C:
		bclr	#1,$38(a1)
		move.l	#loc_7E8E2,(a0)
		move.b	#$15,mapping_frame(a0)
		bset	#7,art_tile(a0)
		move.w	#$180,priority(a0)
		move.w	#-$400,y_vel(a0)
		rts
; ---------------------------------------------------------------------------
byte_7E8C2:
		dc.b  $15, $80
		dc.w   $180
		dc.b  $15, $80
		dc.w   $180
		dc.b  $15, $80
		dc.w   $180
		dc.b  $16, $80
		dc.w   $180
		dc.b  $16,   0
		dc.w   $300
		dc.b  $17,   0
		dc.w   $300
		dc.b  $17,   0
		dc.w   $300
		dc.b  $17,   0
		dc.w   $300
; ---------------------------------------------------------------------------

loc_7E8E2:
		bsr.w	sub_7EB76
		jsr	(MoveSprite).l
		tst.w	y_vel(a0)
		bpl.s	loc_7E8F6
		jmp	Draw_And_Touch_Sprite(pc)
; ---------------------------------------------------------------------------

loc_7E8F6:
		lea	(Child6_CreateBossExplosion).l,a2
		jsr	CreateChild1_Normal(pc)
		bne.s	loc_7E908
		move.b	#6,subtype(a1)

loc_7E908:
		lea	ChildObjDat_7EF9C(pc),a2
		jsr	CreateChild6_Simple(pc)
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

loc_7E916:
		lea	word_7EF5E(pc),a1
		jsr	SetUp_ObjAttributes3(pc)
		move.l	#loc_7E972,(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		lea	byte_7E942(pc,d0.w),a1
		move.b	(a1)+,mapping_frame(a0)
		move.b	(a1)+,d1
		or.b	d1,render_flags(a0)
		add.w	d0,d0
		move.l	word_7E952(pc,d0.w),x_vel(a0)	; and y_vel
		rts
; ---------------------------------------------------------------------------
byte_7E942:
		dc.b  $19,   2
		dc.b  $18,   3
		dc.b  $1A,   1
		dc.b  $18,   1
		dc.b  $19,   0
		dc.b  $18,   0
		dc.b  $1A,   0
		dc.b  $18,   2
word_7E952:
		dc.w      0,  $200
		dc.w   $16A,  $16A
		dc.w   $200,     0
		dc.w   $16A, -$16A
		dc.w      0, -$200
		dc.w  -$16A, -$16A
		dc.w  -$200,     0
		dc.w  -$16A,  $16A
; ---------------------------------------------------------------------------

loc_7E972:
		jsr	(MoveSprite2).l
		jmp	(Sprite_CheckDeleteTouchXY).l
; ---------------------------------------------------------------------------

loc_7E97E:
		lea	word_7EF7C(pc),a1
		jsr	SetUp_ObjAttributes3(pc)
		move.l	#loc_7E98C,(a0)

loc_7E98C:
		jsr	Refresh_ChildPosition(pc)
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.s	loc_7E9D0
		btst	#0,(V_int_run_count+3).w
		bne.w	locret_7DE44
		move.b	child_dy(a0),d0
		addq.b	#1,d0
		move.b	d0,child_dy(a0)
		cmpi.b	#$24,d0
		blo.s	loc_7E9CA
		move.l	#loc_7E9D4,(a0)
		move.w	#$3F,$2E(a0)
		move.l	#loc_7E9FC,$34(a0)

loc_7E9CA:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_7E9D0:
		jmp	Go_Delete_Sprite(pc)
; ---------------------------------------------------------------------------

loc_7E9D4:
		jsr	Refresh_ChildPosition(pc)
		jsr	Obj_Wait(pc)
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.s	loc_7E9F8
		btst	#0,(V_int_run_count+3).w
		bne.w	locret_7DE44
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_7E9F8:
		jmp	Go_Delete_Sprite(pc)
; ---------------------------------------------------------------------------

loc_7E9FC:
		move.l	#loc_7EA12,(a0)
		move.b	#$1B,mapping_frame(a0)
		clr.b	$39(a0)
		subq.b	#4,child_dy(a0)
		rts
; ---------------------------------------------------------------------------

loc_7EA12:
		move.b	mapping_frame(a0),d0
		addq.b	#1,d0
		move.b	d0,mapping_frame(a0)
		cmpi.b	#$22,d0
		blo.s	loc_7EA30
		move.l	#loc_7EA3C,(a0)
		lea	ChildObjDat_7EFCC(pc),a2
		jsr	CreateChild6_Simple(pc)

loc_7EA30:
		addq.b	#8,child_dy(a0)
		jsr	Refresh_ChildPosition(pc)
		jmp	Child_Draw_Sprite(pc)
; ---------------------------------------------------------------------------

loc_7EA3C:
		movea.w	parent3(a0),a1
		btst	#1,$38(a1)
		beq.s	loc_7EA66
		jsr	Refresh_ChildPosition(pc)
		move.b	(V_int_run_count+3).w,d0
		andi.b	#$1F,d0
		bne.s	loc_7EA5E
		moveq	#signextendB(sfx_BossPanic),d0
		jsr	(Play_SFX).l

loc_7EA5E:
		bsr.w	sub_7EB34
		jmp	Child_Draw_Sprite(pc)
; ---------------------------------------------------------------------------

loc_7EA66:
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

loc_7EA6C:
		lea	word_7EF82(pc),a1
		jsr	SetUp_ObjAttributes3(pc)
		move.l	#loc_7EA9A,(a0)
		move.w	(_unkFAB0).w,d0
		addi.w	#$B0,d0
		move.w	d0,y_pos(a0)
		moveq	#-$10,d0
		tst.b	subtype(a0)
		beq.s	loc_7EA96
		neg.w	d0
		bset	#0,render_flags(a0)

loc_7EA96:
		move.w	d0,$3A(a0)

loc_7EA9A:
		lea	byte_7EFF4(pc),a1
		jsr	Animate_RawNoSST(pc)
		movea.w	parent3(a0),a1
		move.w	x_pos(a1),d0
		add.w	$3A(a0),d0
		move.w	d0,x_pos(a0)
		jmp	Child_Draw_Sprite(pc)
; ---------------------------------------------------------------------------

loc_7EAB6:
		lea	word_7EF64(pc),a1
		jsr	SetUp_ObjAttributes3(pc)
		bsr.w	sub_7ECF4
		move.l	#loc_7EAC8,(a0)

loc_7EAC8:
		jmp	Obj_FlickerMove(pc)
; ---------------------------------------------------------------------------

loc_7EACC:
		lea	word_7EF6A(pc),a1
		jsr	SetUp_ObjAttributes3(pc)
		move.l	#loc_7EAFC,(a0)
		move.w	#-$200,y_vel(a0)
		move.w	#-$200,d0
		tst.b	subtype(a0)
		beq.s	loc_7EAF2
		bset	#0,render_flags(a0)
		neg.w	d0

loc_7EAF2:
		move.w	d0,x_vel(a0)
		move.w	#$3F,$2E(a0)

loc_7EAFC:
		subq.w	#1,$2E(a0)
		bpl.s	loc_7EB08
		move.l	#Obj_FlickerMove,(a0)

loc_7EB08:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_7EB0E:
		lea	word_7EF88(pc),a1
		jsr	SetUp_ObjAttributes3(pc)
		move.l	#Obj_FlickerMove,(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		lsr.w	#1,d0
		addi.b	#$23,d0
		move.b	d0,mapping_frame(a0)
		moveq	#8,d0
		jmp	(Set_IndexedVelocity).l

; =============== S U B R O U T I N E =======================================


sub_7EB34:
		lea	word_7EB6E(pc),a1
		jsr	(Check_PlayerInRange).l
		tst.w	d0
		beq.s	loc_7EB46
		bsr.w	sub_7EB4C

loc_7EB46:
		swap	d0
		tst.w	d0
		beq.s	locret_7EB6C
; End of function sub_7EB34


; =============== S U B R O U T I N E =======================================


sub_7EB4C:
		movea.w	d0,a1
		tst.b	$34(a1)
		bne.s	locret_7EB6C
		btst	#Status_OnObj,status(a1)
		bne.s	locret_7EB6C
		btst	#Status_Invincible,status_secondary(a1)
		bne.s	locret_7EB6C
		move.l	d0,-(sp)
		jsr	HurtCharacter_Directly(pc)
		move.l	(sp)+,d0

locret_7EB6C:
		rts
; End of function sub_7EB4C

; ---------------------------------------------------------------------------
word_7EB6E:
		dc.w   -$18,   $30,  -$48,   $90

; =============== S U B R O U T I N E =======================================


sub_7EB76:
		move.b	#$86,collision_flags(a0)
		movea.w	parent3(a0),a1
		btst	#6,status(a1)
		beq.s	locret_7EB8C
		clr.b	collision_flags(a0)

locret_7EB8C:
		rts
; End of function sub_7EB76


; =============== S U B R O U T I N E =======================================


sub_7EB8E:
		btst	#3,(Player_1+status).w
		bne.s	loc_7EBBA
		move.b	(V_int_run_count+3).w,d0
		andi.w	#$1F,d0
		bne.s	locret_7EBB8
		lea	(Player_1).w,a1
		jsr	(Find_OtherObject).l
		move.w	$26(a0),d1
		tst.w	d0
		beq.s	loc_7EBB4
		neg.w	d1

loc_7EBB4:
		move.w	d1,$3C(a0)

locret_7EBB8:
		rts
; ---------------------------------------------------------------------------

loc_7EBBA:
		move.w	$26(a0),$3C(a0)
		rts
; End of function sub_7EB8E


; =============== S U B R O U T I N E =======================================


sub_7EBC2:
		movea.w	parent3(a0),a1
		moveq	#8,d0
		move.w	$3A(a1),d1
		move.w	$3C(a1),d2
		bmi.s	loc_7EBDE
		add.w	d0,d1
		cmp.w	d2,d1
		blt.s	loc_7EBE8
		move.w	d2,d1
		bra.w	loc_7EBE8
; ---------------------------------------------------------------------------

loc_7EBDE:
		neg.w	d0
		add.w	d0,d1
		cmp.w	d2,d1
		bgt.s	loc_7EBE8
		move.w	d2,d1

loc_7EBE8:
		add.w	d1,$3C(a0)
		move.w	d1,$3A(a1)
		rts
; End of function sub_7EBC2

; ---------------------------------------------------------------------------

loc_7EBF2:
		movea.w	parent3(a0),a1
		tst.b	subtype(a0)
		bne.s	loc_7EC06
		move.b	$3C(a0),child_dy(a1)
		bra.w	loc_7EC12
; ---------------------------------------------------------------------------

loc_7EC06:
		move.b	child_dy(a1),d0
		addi.b	#$80,d0
		move.b	d0,$3C(a0)

loc_7EC12:
		move.w	x_pos(a0),-(sp)
		moveq	#2,d2
		jsr	MoveSprite_CircularSimpleOffset(pc)
		moveq	#$23,d1
		moveq	#8,d2
		moveq	#$15,d3
		move.w	(sp)+,d4

loc_7EC24:
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.s	loc_7EC3C
		jsr	(SolidObjectTop).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_7EC3C:
		jsr	Displace_PlayerOffObject(pc)
		moveq	#0,d0
		jmp	loc_849D8(pc)
; ---------------------------------------------------------------------------

loc_7EC46:
		moveq	#$23,d1
		moveq	#8,d2
		moveq	#$15,d3
		move.w	x_pos(a0),d4
		bra.s	loc_7EC24
; ---------------------------------------------------------------------------

loc_7EC52:
		move.w	x_pos(a0),-(sp)
		jsr	MoveSprite_Circular(pc)
		moveq	#$23,d1
		moveq	#8,d2
		moveq	#$15,d3
		move.w	(sp)+,d4
		bra.s	loc_7EC24

; =============== S U B R O U T I N E =======================================


sub_7EC64:
		move.w	x_pos(a0),d0
		tst.w	x_vel(a0)
		beq.s	locret_7EC82
		bmi.s	loc_7EC78
		cmp.w	(_unkFAB6).w,d0
		bhi.s	loc_7EC7E
		rts
; ---------------------------------------------------------------------------

loc_7EC78:
		cmp.w	(_unkFAB4).w,d0
		bhs.s	locret_7EC82

loc_7EC7E:
		neg.w	x_vel(a0)

locret_7EC82:
		rts
; End of function sub_7EC64


; =============== S U B R O U T I N E =======================================


sub_7EC84:
		move.w	x_pos(a0),d0
		move.w	#-$80,d1
		move.w	(Player_1+x_pos).w,d2
		sub.w	d0,d2
		bls.s	loc_7EC96
		neg.w	d1

loc_7EC96:
		move.w	d1,x_vel(a0)
		beq.s	locret_7ECB0
		bmi.s	loc_7ECA6
		cmp.w	(_unkFAB6).w,d0
		bhs.s	loc_7ECAC
		rts
; ---------------------------------------------------------------------------

loc_7ECA6:
		cmp.w	(_unkFAB4).w,d0
		bhi.s	locret_7ECB0

loc_7ECAC:
		clr.w	x_vel(a0)

locret_7ECB0:
		rts
; End of function sub_7EC84

; ---------------------------------------------------------------------------
		move.w	x_pos(a0),d0
		tst.w	x_vel(a0)
		beq.s	loc_7ECD2
		bmi.s	loc_7ECC8
		cmp.w	(_unkFAB6).w,d0
		bhs.s	loc_7ECCE
		bra.w	loc_7ECD2
; ---------------------------------------------------------------------------

loc_7ECC8:
		cmp.w	(_unkFAB4).w,d0
		bhi.s	loc_7ECD2

loc_7ECCE:
		clr.w	x_vel(a0)

loc_7ECD2:
		move.w	y_pos(a0),d0
		tst.w	y_vel(a0)
		beq.s	locret_7ECF2
		bmi.s	loc_7ECE8
		cmp.w	(_unkFAB2).w,d0
		bhs.s	loc_7ECEE
		bra.w	locret_7ECF2
; ---------------------------------------------------------------------------

loc_7ECE8:
		cmp.w	(_unkFAB0).w,d0
		bhi.s	locret_7ECF2

loc_7ECEE:
		clr.w	y_vel(a0)

locret_7ECF2:
		rts

; =============== S U B R O U T I N E =======================================


sub_7ECF4:
		jsr	(Random_Number).l
		move.w	d0,d1
		andi.w	#$C,d1
		move.l	word_7ED40(pc,d1.w),x_vel(a0)	; and y_vel
		andi.w	#$1F,d0
		btst	#0,d0
		beq.s	loc_7ED1C
		neg.w	d0
		neg.w	x_vel(a0)
		bset	#0,render_flags(a0)

loc_7ED1C:
		add.w	d0,x_pos(a0)
		swap	d0
		move.w	d0,d1
		andi.w	#3,d1
		move.b	byte_7ED50(pc,d1.w),mapping_frame(a0)
		andi.w	#$1F,d0
		btst	#0,d0
		beq.s	loc_7ED3A
		neg.w	d0

loc_7ED3A:
		add.w	d0,y_pos(a0)
		rts
; End of function sub_7ECF4

; ---------------------------------------------------------------------------
word_7ED40:
		dc.w   $300, -$400
		dc.w   $200, -$300
		dc.w   $400, -$500
		dc.w   $300, -$200
byte_7ED50:
		dc.b  $12
		dc.b  $13
		dc.b  $14
		dc.b  $12
		even

; =============== S U B R O U T I N E =======================================


sub_7ED54:
		moveq	#0,d0
		move.b	subtype(a0),d0
		lsr.w	#1,d0
		move.b	byte_7ED64(pc,d0.w),$3C(a0)
		rts
; End of function sub_7ED54

; ---------------------------------------------------------------------------
byte_7ED64:
		dc.b    0, $80
		dc.b  $20, $A0
		dc.b  $40, $C0
		dc.b  $60, $E0
		even

; =============== S U B R O U T I N E =======================================


sub_7ED6C:
		movea.w	parent3(a0),a1
		move.w	y_pos(a1),y_pos(a0)
		move.w	(Player_1+x_pos).w,d0
		move.w	x_pos(a1),d1
		sub.w	d1,d0
		smi	d2
		bpl.s	loc_7ED86
		neg.w	d0

loc_7ED86:
		cmpi.w	#$A0,d0
		bls.s	loc_7ED90
		move.w	#$A0,d0

loc_7ED90:
		lsr.w	#3,d0
		andi.w	#$FE,d0
		lea	byte_7EDBA(pc,d0.w),a2
		move.b	(a2)+,d0
		bclr	#0,render_flags(a0)
		tst.b	d2
		beq.s	loc_7EDAE
		bset	#0,render_flags(a0)
		neg.w	d0

loc_7EDAE:
		add.w	d0,d1
		move.w	d1,x_pos(a0)
		move.b	(a2)+,mapping_frame(a0)
		rts
; End of function sub_7ED6C

; ---------------------------------------------------------------------------
byte_7EDBA:
		dc.b    0,   2
		dc.b    1,   2
		dc.b    2,   3
		dc.b    4,   3
		dc.b    5,   3
		dc.b    6,   4
		dc.b    8,   4
		dc.b    9,   4
		dc.b   $A,   5
		dc.b   $B,   5
		dc.b   $C,   5
		even

; =============== S U B R O U T I N E =======================================


sub_7EDD0:
		tst.b	collision_flags(a0)
		bne.s	locret_7EE10
		tst.b	$20(a0)
		bne.s	loc_7EDF2
		move.b	#$20,$20(a0)
		moveq	#signextendB(sfx_BossHit),d0
		jsr	(Play_SFX).l
		movea.w	parent3(a0),a1
		addq.b	#1,collision_property(a1)

loc_7EDF2:
		moveq	#0,d0
		btst	#0,$20(a0)
		bne.s	loc_7EE00
		addi.w	#2*4,d0

loc_7EE00:
		bsr.w	sub_7EE12
		subq.b	#1,$20(a0)
		bne.s	locret_7EE10
		move.b	$25(a0),collision_flags(a0)

locret_7EE10:
		rts
; End of function sub_7EDD0


; =============== S U B R O U T I N E =======================================


sub_7EE12:
		lea	word_7EE1E(pc),a1
		lea	word_7EE26(pc,d0.w),a2
		jmp	CopyWordData_4(pc)
; End of function sub_7EE12

; ---------------------------------------------------------------------------
word_7EE1E:
		dc.w Normal_palette_line_2+$16, Normal_palette_line_2+$18, Normal_palette_line_2+$1A, Normal_palette_line_2+$1C
word_7EE26:
		dc.w   $666,  $444,  $222,     0
		dc.w   $888,  $AAA,  $CCC,  $EEE
; ---------------------------------------------------------------------------

loc_7EE36:
		move.b	collision_property(a0),d0
		cmp.b	$42(a0),d0
		bne.s	loc_7EE42
		rts
; ---------------------------------------------------------------------------

loc_7EE42:
		move.b	d0,$42(a0)
		bset	#1,$38(a0)
		cmpi.b	#8,d0
		blo.s	locret_7EE86
		move.l	#loc_7DF8C,(a0)
		clr.b	routine(a0)
		move.w	#$7F,$2E(a0)
		move.l	#loc_7DFB8,$34(a0)
		bset	#6,status(a0)
		bsr.w	loc_7EE74

loc_7EE74:
		lea	(Child6_CreateBossExplosion).l,a2
		jsr	CreateChild1_Normal(pc)
		bne.s	locret_7EE86
		move.b	#$E,subtype(a1)

locret_7EE86:
		rts

; =============== S U B R O U T I N E =======================================


sub_7EE88:
		move.b	collision_property(a0),d0
		cmp.b	$42(a0),d0
		bne.s	loc_7EE94

locret_7EE92:
		rts
; ---------------------------------------------------------------------------

loc_7EE94:
		move.b	d0,$42(a0)
		cmpi.b	#8,d0
		bhs.s	loc_7EECC
		move.w	#$800,$26(a0)
		lea	(word_7F03C).l,a1
		lea	(Palette_rotation_data).w,a2
		move.l	(a1)+,(a2)+
		move.l	(a1)+,(a2)+
		clr.w	(a2)
		move.l	#loc_7E124,(Palette_rotation_custom).w
		bset	#1,$38(a0)
		bne.s	locret_7EE92
		lea	ChildObj_7EFC4(pc),a2
		jmp	CreateChild1_Normal(pc)
; ---------------------------------------------------------------------------

loc_7EECC:
		bset	#7,status(a0)
		move.l	#Wait_FadeToLevelMusic,(a0)
		move.l	#loc_7E23C,$34(a0)
		lea	(Child6_CreateBossExplosion).l,a2
		jsr	CreateChild1_Normal(pc)
		jmp	BossDefeated_StopTimer(pc)
; End of function sub_7EE88


; =============== S U B R O U T I N E =======================================


sub_7EEEE:
		move.w	$3C(a0),d0
		add.w	$1C(a0),d0
		cmpi.w	#$C00,d0
		blo.s	loc_7EF00
		subi.w	#$C00,d0

loc_7EF00:
		move.w	d0,$3C(a0)
		moveq	#0,d0
		move.b	$3C(a0),d0
		lea	(Player_1).w,a1
		move.b	byte_7EF2E(pc,d0.w),mapping_frame(a1)
		andi.b	#$FC,render_flags(a1)
		move.b	byte_7EF3A(pc,d0.w),d0
		or.b	d0,render_flags(a1)
		moveq	#0,d0
		move.b	mapping_frame(a1),d0
		jmp	(Player_Load_PLC).l
; End of function sub_7EEEE

; ---------------------------------------------------------------------------
byte_7EF2E:
		dc.b  $55, $59, $5A, $5B, $5A, $59, $55, $56, $57, $58, $57, $56
byte_7EF3A:
		dc.b    0,   1,   1,   0,   0,   0,   1,   1,   1,   0,   0,   0
		even
ObjDat_DEZMiniboss:
		dc.l Map_DEZMiniboss
		dc.w make_art_tile($400,1,1)
		dc.w   $280
		dc.b  $20, $20,   0,   0
word_7EF52:
		dc.w   $200
		dc.b   $C,  $C,   2, $17
word_7EF58:
		dc.w   $180
		dc.b  $10, $10, $15, $86
word_7EF5E:
		dc.w   $100
		dc.b    4,   4, $15, $98
word_7EF64:
		dc.w    $80
		dc.b    8,   8, $12,   0
word_7EF6A:
		dc.w   $180
		dc.b  $10, $18, $11,   0
word_7EF70:
		dc.w   $300
		dc.b  $18, $10,   1,   0
word_7EF76:
		dc.w   $280
		dc.b  $18,   4,  $B, $9E
word_7EF7C:
		dc.w   $380
		dc.b  $10, $80,   6,   0
word_7EF82:
		dc.w   $300
		dc.b    8,   4,   8,   0
word_7EF88:
		dc.w   $100
		dc.b  $10, $14, $23,   0
ChildObjDat_7EF8E:
		dc.w 1-1
		dc.l loc_7E768
		dc.b    0,  -4
ChildObjDat_7EF96:
		dc.w 8-1
		dc.l loc_7E80E
ChildObjDat_7EF9C:
		dc.w 8-1
		dc.l loc_7E916
ChildObjDat_7EFA2:
		dc.w 1-1
		dc.l loc_7EAB6
ChildObjDat_7EFA8:
		dc.w 2-1
		dc.l loc_7EACC
		dc.b -$28,   0
		dc.l loc_7EACC
		dc.b  $28,   0
ChildObjDat_7EFB6:
		dc.w 1
		dc.l loc_7E4CE
ChildObjDat_7EFBC:
		dc.w 1-1
		dc.l loc_7E74A
		dc.b    0,   4
ChildObj_7EFC4:
		dc.w 1-1
		dc.l loc_7E97E
		dc.b    0, $1E
ChildObjDat_7EFCC:
		dc.w 2-1
		dc.l loc_7EA6C
ChildObjDat_7EFD2:
		dc.w 4-1
		dc.l loc_7EB0E
		dc.b -$10,   0
		dc.l loc_7EB0E
		dc.b  $10,   0
		dc.l loc_7EB0E
		dc.b  -$C, $18
		dc.l loc_7EB0E
		dc.b   $C, $18
byte_7EFEC:
		dc.b    1,  $B,  $C,  $D,  $E,  $F, $10, $FC
byte_7EFF4:
		dc.b    0,   8,   7,   9,   7,  $A,   7, $FC
		even
Pal_DEZMiniboss1:
		binclude "Levels/DEZ/Palettes/Miniboss 1.bin"
		even
Pal_DEZMiniboss2:
		binclude "Levels/DEZ/Palettes/Miniboss 2.bin"
		even
word_7F03C:	palscriptptr .header, .data
		dc.w 0
.header	palscripthdr	Normal_palette_line_2+$16, 3, 11-1
.data	palscriptdata	8, $66A, $448, $226
	palscriptdata	8, $66C, $44A, $228
	palscriptdata	8, $66A, $448, $226
	palscriptdata	8, $666, $444, $222
	palscriptrun
; ---------------------------------------------------------------------------

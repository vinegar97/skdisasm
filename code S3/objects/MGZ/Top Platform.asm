Obj_MGZTopPlatform:
		move.l	#Map_MGZTopPlatform,mappings(a0)
		move.w	#make_art_tile($35F,1,0),art_tile(a0)
		ori.b	#4,render_flags(a0)
		move.w	#$280,priority(a0)
		move.b	#$18,width_pixels(a0)
		move.b	#$C,height_pixels(a0)
		move.b	#$1F,y_radius(a0)
		move.b	#$18,x_radius(a0)
		move.b	#$1F,default_y_radius(a0)
		move.b	#$18,default_x_radius(a0)
		move.w	x_pos(a0),$30(a0)
		move.w	y_pos(a0),$32(a0)
		move.b	#$C,top_solid_bit(a0)
		move.b	#$D,lrb_solid_bit(a0)
		move.l	#loc_341EC,(a0)

loc_341EC:
		lea	(Player_1).w,a1
		lea	$40(a0),a4
		move.w	(Ctrl_1_logical).w,d5
		moveq	#p1_standing_bit,d6
		bsr.w	sub_34484
		lea	(Player_2).w,a1
		lea	$42(a0),a4
		move.w	(Ctrl_2_logical).w,d5
		moveq	#p2_standing_bit,d6
		bsr.w	sub_34484
		tst.b	subtype(a0)
		bne.w	loc_342FA
		btst	#1,status(a0)
		beq.w	loc_342A6
		cmpi.w	#$200,y_vel(a0)
		bge.s	+ ;loc_34230
		addi.w	#8,y_vel(a0)

+ ;loc_34230:
		jsr	(MoveSprite2).l
		subi.w	#$13,y_pos(a0)
		move.l	a1,-(sp)
		jsr	(sub_347FC).l
		movea.l	(sp)+,a1
		addi.w	#$13,y_pos(a0)
		tst.b	$2D(a0)
		beq.s	+ ;loc_34268
		move.w	#0,y_vel(a0)
		move.w	#0,x_vel(a0)
		bclr	#1,status(a0)
		bra.w	loc_342FA
; ---------------------------------------------------------------------------

+ ;loc_34268:
		btst	#1,status(a0)
		bne.w	loc_342FA
		move.w	x_vel(a0),d0
		bpl.s	+ ;loc_3427A
		neg.w	d0

+ ;loc_3427A:
		cmpi.w	#$40,d0
		blo.s	loc_342FA
		move.w	#$800,d1
		cmpi.w	#$100,d0
		blo.s	+ ;loc_3428E
		move.w	#$C00,d1

+ ;loc_3428E:
		tst.w	x_vel(a0)
		bpl.s	+ ;loc_34296
		neg.w	d1

+ ;loc_34296:
		move.w	d1,x_vel(a0)
		move.w	d1,ground_vel(a0)
		move.b	#1,$34(a0)
		bra.s	loc_342FA
; ---------------------------------------------------------------------------

loc_342A6:
		tst.b	$35(a0)
		beq.s	+ ;loc_342B6
		bsr.w	sub_34DFA
		addq.w	#4,$24(a0)
		bra.s	loc_342FA
; ---------------------------------------------------------------------------

+ ;loc_342B6:
		move.b	angle(a0),d0
		jsr	(GetSineCosine).l
		muls.w	ground_vel(a0),d1
		asr.l	#8,d1
		move.w	d1,x_vel(a0)
		muls.w	ground_vel(a0),d0
		asr.l	#8,d0
		move.w	d0,y_vel(a0)
		bsr.s	sub_34354
		jsr	(MoveSprite2).l
		tst.b	$2D(a0)
		bne.s	+ ;loc_342E6
		bsr.w	sub_34406

+ ;loc_342E6:
		addq.w	#4,$24(a0)
		tst.w	ground_vel(a0)
		bne.s	+ ;loc_342F6
		move.b	#0,$34(a0)

+ ;loc_342F6:
		bsr.w	sub_34BF8

loc_342FA:
		lea	(Player_1).w,a1
		lea	$40(a0),a4
		moveq	#p1_standing_bit,d6
		bsr.w	sub_34794
		lea	(Player_2).w,a1
		lea	$42(a0),a4
		moveq	#p2_standing_bit,d6
		bsr.w	sub_34794
		move.w	$24(a0),d0
		asr.w	#3,d0
		andi.w	#1,d0
		move.b	d0,mapping_frame(a0)
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------

loc_3432A:
		jsr	(MoveSprite).l
		addq.w	#4,$24(a0)
		move.w	$24(a0),d0
		asr.w	#3,d0
		andi.w	#1,d0
		move.b	d0,mapping_frame(a0)
		tst.b	render_flags(a0)
		bmi.s	+ ;loc_3434E
		move.w	#$7F00,x_pos(a0)

+ ;loc_3434E:
		jmp	(Sprite_OnScreen_Test).l

; =============== S U B R O U T I N E =======================================


sub_34354:
		move.b	#$40,d1
		tst.w	ground_vel(a0)
		beq.s	locret_343CE
		bmi.s	+ ;loc_34362
		neg.w	d1

+ ;loc_34362:
		move.b	angle(a0),d0
		add.b	d1,d0
		move.w	d0,-(sp)
		move.b	#$13,y_radius(a0)
		move.b	#$18,x_radius(a0)
		subi.w	#$C,y_pos(a0)
		jsr	(sub_10A10).l
		addi.w	#$C,y_pos(a0)
		move.w	(sp)+,d0
		tst.w	d1
		bpl.s	locret_343CE
		asl.w	#8,d1
		addi.b	#$20,d0
		andi.b	#$C0,d0
		beq.s	+++ ;loc_34400
		cmpi.b	#$40,d0
		beq.s	++ ;loc_343D6
		cmpi.b	#$80,d0
		beq.s	+ ;loc_343D0
		addi.b	#$30,d3
		cmpi.b	#$60,d3
		blo.s	locret_343CE
		add.w	d1,x_vel(a0)
		move.w	#0,y_vel(a0)
		move.w	#0,ground_vel(a0)
		btst	#0,status(a0)
		bne.s	locret_343CE
		bset	#5,status(a0)

locret_343CE:
		rts
; ---------------------------------------------------------------------------

+ ;loc_343D0:
		sub.w	d1,y_vel(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_343D6:
		addi.b	#$30,d3
		cmpi.b	#$60,d3
		blo.s	locret_343CE
		sub.w	d1,x_vel(a0)
		move.w	#0,y_vel(a0)
		move.w	#0,ground_vel(a0)
		btst	#0,status(a0)
		beq.s	locret_343CE
		bset	#5,status(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_34400:
		add.w	d1,y_vel(a0)
		rts
; End of function sub_34354


; =============== S U B R O U T I N E =======================================


sub_34406:
		move.b	#$C,y_radius(a0)
		move.b	#$A,x_radius(a0)
		moveq	#3,d0
		move.b	d0,(Primary_Angle).w
		move.b	d0,(Secondary_Angle).w
		jsr	(Sonic_CheckFloor).l
		tst.b	d3
		bpl.s	+ ;loc_34432
		cmpi.b	#-$1E,d3
		bhs.s	++ ;loc_3443C
		move.b	#-$1E,d3
		bra.s	++ ;loc_3443C
; ---------------------------------------------------------------------------

+ ;loc_34432:
		cmpi.b	#$1E,d3
		bls.s	+ ;loc_3443C
		move.b	#$1E,d3

+ ;loc_3443C:
		move.b	d3,angle(a0)
		tst.w	d1
		beq.s	locret_34450
		bpl.s	+ ;loc_34452
		cmpi.w	#-$E,d1
		blt.s	locret_34450
		add.w	d1,y_pos(a0)

locret_34450:
		rts
; ---------------------------------------------------------------------------

+ ;loc_34452:
		move.b	x_vel(a0),d0
		bpl.s	+ ;loc_3445A
		neg.b	d0

+ ;loc_3445A:
		addq.b	#4,d0
		cmpi.b	#$E,d0
		blo.s	+ ;loc_34466
		move.b	#$E,d0

+ ;loc_34466:
		cmp.b	d0,d1
		bgt.s	+ ;loc_34470
		add.w	d1,y_pos(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_34470:
		bset	#1,status(a0)
		bclr	#5,status(a0)
		move.b	#0,$34(a0)
		rts
; End of function sub_34406


; =============== S U B R O U T I N E =======================================


sub_34484:
		moveq	#0,d0
		move.b	(a4),d0
		move.w	off_34490(pc,d0.w),d0
		jmp	off_34490(pc,d0.w)
; End of function sub_34484

; ---------------------------------------------------------------------------
off_34490:
		dc.w loc_3449C-off_34490
		dc.w loc_344E4-off_34490
		dc.w loc_34554-off_34490
		dc.w loc_34498-off_34490
; ---------------------------------------------------------------------------

loc_34498:
		clr.w	(a4)
		rts
; ---------------------------------------------------------------------------

loc_3449C:
		moveq	#0,d1
		move.b	width_pixels(a0),d1
		addi.w	#$B,d1
		moveq	#0,d2
		move.b	height_pixels(a0),d2
		move.w	d2,d3
		addq.w	#1,d3
		move.w	x_pos(a0),d4
		jsr	(SolidObjectFull_1P).l
		btst	d6,status(a0)
		bne.s	+ ;loc_344C2
		rts
; ---------------------------------------------------------------------------

+ ;loc_344C2:
		tst.b	status_tertiary(a1)
		bmi.s	locret_344E2
		addq.b	#2,(a4)
		move.b	#0,1(a4)
		move.w	x_pos(a0),d0
		sub.w	x_pos(a1),d0
		bcc.s	+ ;loc_344E0
		move.b	#1,1(a4)

+ ;loc_344E0:
		bra.s	+ ;loc_34502
; ---------------------------------------------------------------------------

locret_344E2:
		rts
; ---------------------------------------------------------------------------

loc_344E4:
		moveq	#0,d1
		move.b	width_pixels(a0),d1
		addi.w	#$B,d1
		moveq	#0,d2
		move.b	height_pixels(a0),d2
		move.w	d2,d3
		addq.w	#1,d3
		move.w	x_pos(a0),d4
		jsr	(SolidObjectFull_1P).l

+ ;loc_34502:
		btst	d6,status(a0)
		bne.s	+ ;loc_3450A
		clr.b	(a4)

+ ;loc_3450A:
		move.w	x_pos(a1),d0
		sub.w	x_pos(a0),d0
		tst.b	1(a4)
		beq.s	+ ;loc_3451C
		addi.w	#$F,d0

+ ;loc_3451C:
		cmpi.w	#$10,d0
		bhs.s	locret_34552
		move.w	x_pos(a0),x_pos(a1)
		move.b	default_y_radius(a1),d0
		addi.b	#$18,d0
		move.b	d0,y_radius(a1)
		bset	#0,object_control(a1)
		move.b	#$80,status_tertiary(a1)
		bclr	d6,status(a0)
		bclr	#Status_OnObj,status(a1)
		bset	#Status_InAir,status(a1)
		addq.b	#2,(a4)

locret_34552:
		rts
; ---------------------------------------------------------------------------

loc_34554:
		cmpi.b	#4,routine(a1)
		bhs.w	sub_3472C
		tst.w	(Debug_placement_mode).w
		bne.s	+ ;loc_3459C
		move.w	d5,d0
		andi.w	#button_A_mask|button_B_mask|button_C_mask,d0
		beq.w	++ ;loc_345BA
		move.w	#-$680,y_vel(a1)
		move.b	#1,jumping(a1)
		move.b	#$E,y_radius(a1)
		move.b	#7,x_radius(a1)
		move.b	#2,anim(a1)
		bset	#Status_Roll,status(a1)
		move.w	#sfx_Jump,d0
		jsr	(Play_SFX).l

+ ;loc_3459C:
		bclr	#0,object_control(a1)
		move.b	#0,status_tertiary(a1)
		bset	#Status_InAir,status(a1)
		clr.b	(a4)
		cmpa.w	#Player_1,a1
		beq.w	sub_3472C

locret_345B8:
		rts
; ---------------------------------------------------------------------------

+ ;loc_345BA:
		move.w	d5,d0
		andi.w	#$C00,d0
		bne.s	+ ;loc_345DA
		tst.w	x_vel(a0)
		beq.s	+ ;loc_345DA
		bclr	#Status_Facing,status(a1)
		tst.w	x_vel(a0)
		bpl.s	+ ;loc_345DA
		bset	#Status_Facing,status(a1)

+ ;loc_345DA:
		move.b	default_y_radius(a1),d0
		addi.b	#$18,d0
		move.b	d0,y_radius(a1)
		cmpa.w	#Player_2,a1
		bne.s	+ ;loc_345EE
		rts
; ---------------------------------------------------------------------------

+ ;loc_345EE:
		move.l	a0,-(sp)
		movea.l	a1,a0
		move.w	d5,d3
		cmpi.b	#$10,anim(a0)
		beq.s	+ ;loc_34602
		jsr	(sub_34A96).l

+ ;loc_34602:
		jsr	(Player_LevelBound).l
		jsr	(MoveSprite2).l
		movea.l	(sp)+,a0
		cmpi.b	#$10,anim(a1)
		bne.s	+ ;loc_34638
		move.w	x_vel(a1),x_vel(a0)
		move.w	y_vel(a1),y_vel(a0)
		addi.w	#$38,y_vel(a1)
		bset	#1,status(a0)
		move.b	#0,$34(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_34638:
		bclr	#6,status_tertiary(a1)
		beq.s	+ ;loc_3464C
		move.w	#0,ground_vel(a0)
		move.w	#0,x_vel(a0)

+ ;loc_3464C:
		bclr	#5,status_tertiary(a1)
		beq.s	+ ;loc_3465A
		move.w	#0,y_vel(a0)

+ ;loc_3465A:
		move.w	x_vel(a0),x_vel(a1)
		move.w	y_vel(a0),y_vel(a1)
		move.w	top_solid_bit(a1),top_solid_bit(a0)
		tst.b	$34(a0)
		bne.w	locret_345B8
		move.w	x_pos(a1),d0
		sub.w	x_pos(a0),d0
		beq.w	loc_34702
		bcc.w	+++ ;loc_346C2
		cmpi.w	#-$200,x_vel(a0)
		ble.s	+ ;loc_3469C
		add.w	d0,x_vel(a0)
		add.w	d0,x_vel(a0)
		add.w	d0,x_vel(a0)
		add.w	d0,x_vel(a0)

+ ;loc_3469C:
		add.w	d0,$24(a0)
		move.w	x_vel(a0),d0
		bpl.s	+ ;loc_346BA
		asr.w	#4,d0
		subi.w	#8,y_vel(a0)
		cmpi.w	#-$100,y_vel(a0)
		ble.s	+ ;loc_346BA
		add.w	d0,y_vel(a0)

+ ;loc_346BA:
		bset	#1,status(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_346C2:
		cmpi.w	#$200,x_vel(a0)
		bge.s	+ ;loc_346DA
		add.w	d0,x_vel(a0)
		add.w	d0,x_vel(a0)
		add.w	d0,x_vel(a0)
		add.w	d0,x_vel(a0)

+ ;loc_346DA:
		add.w	d0,$24(a0)
		move.w	x_vel(a0),d0
		bmi.s	+ ;loc_346FA
		neg.w	d0
		asr.w	#4,d0
		subi.w	#8,y_vel(a0)
		cmpi.w	#-$100,y_vel(a0)
		ble.s	+ ;loc_346FA
		add.w	d0,y_vel(a0)

+ ;loc_346FA:
		bset	#1,status(a0)
		rts
; ---------------------------------------------------------------------------

loc_34702:
		moveq	#1,d0
		tst.w	x_vel(a0)
		beq.s	++ ;loc_34712
		bmi.s	+ ;loc_3470E
		neg.w	d0

+ ;loc_3470E:
		add.w	d0,x_vel(a0)

+ ;loc_34712:
		add.w	d0,$24(a0)
		tst.w	y_vel(a0)
		bpl.s	locret_34720
		clr.w	y_vel(a0)

locret_34720:
		rts
; ---------------------------------------------------------------------------
		clr.w	x_vel(a0)
		clr.w	y_vel(a0)
		rts

; =============== S U B R O U T I N E =======================================


sub_3472C:
		move.l	#loc_3432A,(a0)
		lea	(Player_1).w,a2
		cmpi.b	#4,$40(a0)
		bne.s	+ ;loc_34750
		bclr	#0,object_control(a2)
		move.b	#0,status_tertiary(a2)
		bset	#Status_InAir,status(a2)

+ ;loc_34750:
		tst.b	$40(a0)
		beq.s	+ ;loc_3475C
		bclr	#Status_OnObj,status(a2)

+ ;loc_3475C:
		lea	(Player_2).w,a2
		cmpi.b	#4,$42(a0)
		bne.s	+ ;loc_3477A
		bclr	#0,object_control(a2)
		move.b	#0,status_tertiary(a2)
		bset	#1,status(a2)

+ ;loc_3477A:
		tst.b	$42(a0)
		beq.s	+ ;loc_34786
		bclr	#Status_OnObj,status(a2)

+ ;loc_34786:
		move.b	#6,$40(a0)
		move.b	#6,$42(a0)
		rts
; End of function sub_3472C


; =============== S U B R O U T I N E =======================================


sub_34794:
		btst	#Status_OnObj,status(a1)
		bne.s	+ ;loc_347C4
		cmpi.b	#4,(a4)
		blo.s	locret_347C2
		move.w	y_pos(a0),d0
		subi.w	#$C,d0
		moveq	#0,d1
		move.b	default_y_radius(a1),d1
		sub.w	d1,d0
		move.w	d0,y_pos(a1)
		move.w	x_pos(a0),x_pos(a1)
		move.b	#0,$2D(a0)

locret_347C2:
		rts
; ---------------------------------------------------------------------------

+ ;loc_347C4:
		cmpi.b	#4,(a4)
		blo.s	locret_347FA
		movea.w	interact(a1),a2
		cmpi.l	#loc_31D3E,(a2)
		bne.s	+ ;loc_347DA
		bsr.w	sub_3472C

+ ;loc_347DA:
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a1),d0
		moveq	#0,d1
		move.b	default_y_radius(a1),d1
		add.w	d1,d0
		addi.w	#$D,d0
		move.w	d0,y_pos(a0)
		move.b	#1,$2D(a0)

locret_347FA:
		rts
; End of function sub_34794


; =============== S U B R O U T I N E =======================================


sub_347FC:
		move.l	(Primary_collision_addr).w,(Collision_addr).w
		cmpi.b	#$C,top_solid_bit(a0)
		beq.s	+ ;loc_34810
		move.l	(Secondary_collision_addr).w,(Collision_addr).w

+ ;loc_34810:
		move.b	lrb_solid_bit(a0),d5
		move.w	x_vel(a0),d1
		move.w	y_vel(a0),d2
		jsr	(GetArcTan).l
		subi.b	#$20,d0
		andi.b	#$C0,d0
		cmpi.b	#$40,d0
		beq.w	loc_34900
		cmpi.b	#$80,d0
		beq.w	loc_3498A
		cmpi.b	#-$40,d0
		beq.w	loc_34A0C
		move.b	#$C,y_radius(a0)
		move.b	#$18,x_radius(a0)
		jsr	(sub_1100E).l
		tst.w	d1
		bpl.s	+ ;loc_34862
		sub.w	d1,x_pos(a0)
		move.w	#0,x_vel(a0)

+ ;loc_34862:
		jsr	(sub_10D76).l
		tst.w	d1
		bpl.s	+ ;loc_34876
		add.w	d1,x_pos(a0)
		move.w	#0,x_vel(a0)

+ ;loc_34876:
		move.b	#$1F,y_radius(a0)
		move.b	#$A,x_radius(a0)
		jsr	(Sonic_CheckFloor).l
		tst.w	d1
		bpl.s	locret_348FE
		move.b	y_vel(a0),d2
		addq.b	#8,d2
		neg.b	d2
		cmp.b	d2,d1
		bge.s	+ ;loc_3489C
		cmp.b	d2,d0
		blt.s	locret_348FE

+ ;loc_3489C:
		add.w	d1,y_pos(a0)
		move.b	d3,angle(a0)
		bclr	#1,status(a0)
		move.b	#0,$2D(a0)
		move.b	d3,d0
		addi.b	#$20,d0
		andi.b	#$40,d0
		bne.s	++ ;loc_348DC
		move.b	d3,d0
		addi.b	#$10,d0
		andi.b	#$20,d0
		beq.s	+ ;loc_348CE
		asr	y_vel(a0)
		bra.s	loc_348F0
; ---------------------------------------------------------------------------

+ ;loc_348CE:
		move.w	#0,y_vel(a0)
		move.w	x_vel(a0),ground_vel(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_348DC:
		move.w	#0,x_vel(a0)
		cmpi.w	#$FC0,y_vel(a0)
		ble.s	loc_348F0
		move.w	#$FC0,y_vel(a0)

loc_348F0:
		move.w	y_vel(a0),ground_vel(a0)
		tst.b	d3
		bpl.s	locret_348FE
		neg.w	ground_vel(a0)

locret_348FE:
		rts
; ---------------------------------------------------------------------------

loc_34900:
		move.b	#$C,y_radius(a0)
		move.b	#$18,x_radius(a0)
		jsr	(sub_1100E).l
		tst.w	d1
		bpl.s	+ ;loc_34930
		sub.w	d1,x_pos(a0)
		addi.b	#$30,d3
		cmpi.b	#$60,d3
		blo.s	+ ;loc_34930
		move.w	#0,x_vel(a0)
		move.w	y_vel(a0),ground_vel(a0)

+ ;loc_34930:
		move.b	#$1F,y_radius(a0)
		move.b	#$A,x_radius(a0)
		jsr	(sub_10EB6).l
		tst.w	d1
		bpl.s	+ ;loc_34958
		sub.w	d1,y_pos(a0)
		tst.w	y_vel(a0)
		bpl.s	locret_34956
		move.w	#0,y_vel(a0)

locret_34956:
		rts
; ---------------------------------------------------------------------------

+ ;loc_34958:
		tst.w	y_vel(a0)
		bmi.s	locret_34988
		jsr	(Sonic_CheckFloor).l
		tst.w	d1
		bpl.s	locret_34988
		add.w	d1,y_pos(a0)
		move.b	d3,angle(a0)
		bclr	#1,status(a0)
		move.b	#0,$2D(a0)
		move.w	#0,y_vel(a0)
		move.w	x_vel(a0),ground_vel(a0)

locret_34988:
		rts
; ---------------------------------------------------------------------------

loc_3498A:
		move.b	#$C,y_radius(a0)
		move.b	#$18,x_radius(a0)
		jsr	(sub_1100E).l
		tst.w	d1
		bpl.s	+ ;loc_349AA
		sub.w	d1,x_pos(a0)
		move.w	#0,x_vel(a0)

+ ;loc_349AA:
		jsr	(sub_10D76).l
		tst.w	d1
		bpl.s	+ ;loc_349BE
		add.w	d1,x_pos(a0)
		move.w	#0,x_vel(a0)

+ ;loc_349BE:
		move.b	#$1F,y_radius(a0)
		move.b	#$A,x_radius(a0)
		jsr	(sub_10EB6).l
		tst.w	d1
		bpl.s	locret_34A0A
		sub.w	d1,y_pos(a0)
		move.b	d3,d0
		addi.b	#$20,d0
		andi.b	#$40,d0
		bne.s	+ ;loc_349EC
		move.w	#0,y_vel(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_349EC:
		move.b	d3,angle(a0)
		bclr	#1,status(a0)
		move.b	#0,$2D(a0)
		move.w	y_vel(a0),ground_vel(a0)
		tst.b	d3
		bpl.s	locret_34A0A
		neg.w	ground_vel(a0)

locret_34A0A:
		rts
; ---------------------------------------------------------------------------

loc_34A0C:
		move.b	#$C,y_radius(a0)
		move.b	#$18,x_radius(a0)
		jsr	(sub_10D76).l
		tst.w	d1
		bpl.s	+ ;loc_34A3C
		add.w	d1,x_pos(a0)
		addi.b	#$30,d3
		cmpi.b	#$60,d3
		blo.s	+ ;loc_34A3C
		move.w	#0,x_vel(a0)
		move.w	y_vel(a0),ground_vel(a0)

+ ;loc_34A3C:
		move.b	#$1F,y_radius(a0)
		move.b	#$A,x_radius(a0)
		jsr	(sub_10EB6).l
		tst.w	d1
		bpl.s	+ ;loc_34A64
		sub.w	d1,y_pos(a0)
		tst.w	y_vel(a0)
		bpl.s	locret_34A62
		move.w	#0,y_vel(a0)

locret_34A62:
		rts
; ---------------------------------------------------------------------------

+ ;loc_34A64:
		tst.w	y_vel(a0)
		bmi.s	locret_34A94
		jsr	(Sonic_CheckFloor).l
		tst.w	d1
		bpl.s	locret_34A94
		add.w	d1,y_pos(a0)
		move.b	d3,angle(a0)
		bclr	#1,status(a0)
		move.b	#0,$2D(a0)
		move.w	#0,y_vel(a0)
		move.w	x_vel(a0),ground_vel(a0)

locret_34A94:
		rts
; End of function sub_347FC


; =============== S U B R O U T I N E =======================================


sub_34A96:
		move.w	#$600,d6
		move.w	#$C,d5
		move.w	#$80,d4
		btst	#$A,d3
		beq.s	+ ;loc_34AAC
		bsr.w	sub_34AEE

+ ;loc_34AAC:
		btst	#$B,d3
		beq.s	+ ;loc_34AB6
		bsr.w	sub_34B76

+ ;loc_34AB6:
		move.w	d3,d0
		andi.w	#$C00,d0
		bne.s	loc_34AE0
		move.w	ground_vel(a0),d0
		beq.s	loc_34AE0
		bmi.s	++ ;loc_34AD4
		sub.w	d5,d0
		bcc.s	+ ;loc_34ACE
		move.w	#0,d0

+ ;loc_34ACE:
		move.w	d0,ground_vel(a0)
		bra.s	loc_34AE0
; ---------------------------------------------------------------------------

+ ;loc_34AD4:
		add.w	d5,d0
		bcc.s	+ ;loc_34ADC
		move.w	#0,d0

+ ;loc_34ADC:
		move.w	d0,ground_vel(a0)

loc_34AE0:
		move.w	ground_vel(a0),x_vel(a0)
		move.w	#0,y_vel(a0)
		rts
; End of function sub_34A96


; =============== S U B R O U T I N E =======================================


sub_34AEE:
		move.w	ground_vel(a0),d0
		beq.s	+ ;loc_34AF6
		bpl.s	loc_34B28

+ ;loc_34AF6:
		bset	#0,status(a0)
		bne.s	+ ;loc_34B0A
		bclr	#5,status(a0)
		move.b	#1,prev_anim(a0)

+ ;loc_34B0A:
		sub.w	d5,d0
		move.w	d6,d1
		neg.w	d1
		cmp.w	d1,d0
		bgt.s	+ ;loc_34B1C
		add.w	d5,d0
		cmp.w	d1,d0
		ble.s	+ ;loc_34B1C
		move.w	d1,d0

+ ;loc_34B1C:
		move.w	d0,ground_vel(a0)
		move.b	#0,anim(a0)
		rts
; ---------------------------------------------------------------------------

loc_34B28:
		sub.w	d4,d0
		bcc.s	+ ;loc_34B30
		move.w	#-$80,d0

+ ;loc_34B30:
		move.w	d0,ground_vel(a0)
		move.b	angle(a0),d0
		addi.b	#$20,d0
		andi.b	#$C0,d0
		bne.s	locret_34B74
		cmpi.w	#$400,d0
		blt.s	locret_34B74
		move.b	#$D,anim(a0)
		bclr	#0,status(a0)
		move.w	#sfx_Skid,d0
		jsr	(Play_SFX).l
		movea.l	a0,a2
		suba.w	#Player_1,a2
		adda.w	#Dust,a2
		move.b	#6,routine(a2)
		move.b	#$15,mapping_frame(a2)

locret_34B74:
		rts
; End of function sub_34AEE


; =============== S U B R O U T I N E =======================================


sub_34B76:
		move.w	ground_vel(a0),d0
		bmi.s	+++ ;loc_34BAA
		bclr	#0,status(a0)
		beq.s	+ ;loc_34B90
		bclr	#5,status(a0)
		move.b	#1,prev_anim(a0)

+ ;loc_34B90:
		add.w	d5,d0
		cmp.w	d6,d0
		blt.s	+ ;loc_34B9E
		sub.w	d5,d0
		cmp.w	d6,d0
		bge.s	+ ;loc_34B9E
		move.w	d6,d0

+ ;loc_34B9E:
		move.w	d0,ground_vel(a0)
		move.b	#0,anim(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_34BAA:
		add.w	d4,d0
		bcc.s	+ ;loc_34BB2
		move.w	#$80,d0

+ ;loc_34BB2:
		move.w	d0,ground_vel(a0)
		move.b	angle(a0),d0
		addi.b	#$20,d0
		andi.b	#$C0,d0
		bne.s	locret_34BF6
		cmpi.w	#-$400,d0
		bgt.s	locret_34BF6
		move.b	#$D,anim(a0)
		bset	#0,status(a0)
		move.w	#sfx_Skid,d0
		jsr	(Play_SFX).l
		movea.l	a0,a2
		suba.w	#Player_1,a2
		adda.w	#Dust,a2
		move.b	#6,routine(a2)
		move.b	#$15,mapping_frame(a2)

locret_34BF6:
		rts
; End of function sub_34B76


; =============== S U B R O U T I N E =======================================


sub_34BF8:
		tst.w	(Debug_placement_mode).w
		bne.s	locret_34C5A
		tst.b	$34(a0)
		beq.s	locret_34C5A
		lea	(word_34D16).l,a1
		tst.b	(Current_act).w
		beq.s	+ ;loc_34C16
		lea	(word_34D88).l,a1

+ ;loc_34C16:
		move.w	(a1)+,d6
		move.w	x_pos(a0),d2
		move.w	y_pos(a0),d3

- ;loc_34C20:
		move.w	(a1),d0
		sub.w	d2,d0
		addi.w	#$10,d0
		cmpi.w	#$20,d0
		bhs.s	++ ;loc_34C52
		move.w	2(a1),d1
		sub.w	d3,d1
		addi.w	#$10,d1
		cmpi.w	#$20,d1
		bhs.s	++ ;loc_34C52
		move.w	ground_vel(a0),d0
		move.b	4(a1),d2
		andi.b	#$7F,d2
		beq.s	+ ;loc_34C4E
		neg.w	d0

+ ;loc_34C4E:
		tst.w	d0
		bpl.s	++ ;loc_34C5C

+ ;loc_34C52:
		adda.w	#$10,a1
		dbf	d6,- ;loc_34C20

locret_34C5A:
		rts
; ---------------------------------------------------------------------------

+ ;loc_34C5C:
		move.b	#1,$35(a0)
		move.w	4(a1),$3E(a0)
		addq.w	#6,a1
		move.w	(a1)+,d4
		move.w	d4,$30(a0)
		move.w	(a1)+,d5
		move.w	d5,d0
		move.b	$3F(a0),d1
		andi.b	#$7F,d1
		beq.s	+ ;loc_34C80
		sub.w	(a1),d0

+ ;loc_34C80:
		move.w	d0,$32(a0)
		move.l	a1,$36(a0)
		move.w	ground_vel(a0),d2
		bpl.s	+ ;loc_34C90
		neg.w	d2

+ ;loc_34C90:
		tst.w	d2
		bne.s	loc_34C98
		move.w	#$800,d2

loc_34C98:
		moveq	#0,d0
		move.w	d2,d3
		move.w	d4,d0
		sub.w	x_pos(a0),d0
		bge.s	+ ;loc_34CA8
		neg.w	d0
		neg.w	d2

+ ;loc_34CA8:
		moveq	#0,d1
		move.w	d5,d1
		sub.w	y_pos(a0),d1
		bge.s	+ ;loc_34CB6
		neg.w	d1
		neg.w	d3

+ ;loc_34CB6:
		cmp.w	d0,d1
		blo.s	+++ ;loc_34CE8
		moveq	#0,d1
		move.w	d5,d1
		sub.w	y_pos(a0),d1
		swap	d1
		divs.w	d3,d1
		moveq	#0,d0
		move.w	d4,d0
		sub.w	x_pos(a0),d0
		beq.s	+ ;loc_34CD4
		swap	d0
		divs.w	d1,d0

+ ;loc_34CD4:
		move.w	d0,x_vel(a0)
		move.w	d3,y_vel(a0)
		tst.w	d1
		bpl.s	+ ;loc_34CE2
		neg.w	d1

+ ;loc_34CE2:
		move.w	d1,$3A(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_34CE8:
		moveq	#0,d0
		move.w	d4,d0
		sub.w	x_pos(a0),d0
		swap	d0
		divs.w	d2,d0
		moveq	#0,d1
		move.w	d5,d1
		sub.w	y_pos(a0),d1
		beq.s	+ ;loc_34D02
		swap	d1
		divs.w	d0,d1

+ ;loc_34D02:
		move.w	d1,y_vel(a0)
		move.w	d2,x_vel(a0)
		tst.w	d0
		bpl.s	+ ;loc_34D10
		neg.w	d0

+ ;loc_34D10:
		move.w	d0,$3A(a0)
		rts
; End of function sub_34BF8

; ---------------------------------------------------------------------------
word_34D16:	dc.w 7-1
		dc.w  $1BA0,   $C6,     0, $1C40,   $E6,  $280, $1CE0,  $385
		dc.w  $1BA0,  $3C4, $8001, $1C40,  $3A6,  $2C0, $1BA0,   $C6
		dc.w  $1CE0,  $385,  $101, $1C40,  $366,  $280, $1BA0,   $C6
		dc.w  $2720,  $846,     0, $27C0,  $866,  $200, $2860,  $A86
		dc.w  $2860,  $846,  $180, $27C0,  $866,  $200, $2720,  $A86
		dc.w  $2720,  $A86,   $81, $27C0,  $A66,  $200, $2860,  $846
		dc.w  $2860,  $A86,  $101, $27C0,  $A66,  $200, $2720,  $846
word_34D88:	dc.w 7-1
		dc.w  $1760,  $546, $8180, $16C0,  $566,  $140, $1760,  $6C5
		dc.w  $1760,  $6C5, $8181, $16C0,  $6A6,  $140, $1760,  $546
		dc.w  $1620,  $6C4,   $81, $16C0,  $6C6,  $180, $1760,  $546
		dc.w  $2AA0,  $444, $8000, $2B40,  $466,  $2C0, $2AA0,  $744
		dc.w  $2BE0,  $446, $8180, $2B40,  $466,  $2C0, $2BE0,  $746
		dc.w  $2AA0,  $744, $8001, $2B40,  $726,  $2C0, $2AA0,  $444
		dc.w  $2BE0,  $746, $8181, $2B40,  $726,  $2C0, $2BE0,  $446

; =============== S U B R O U T I N E =======================================


sub_34DFA:
		cmpi.b	#2,$35(a0)
		beq.s	loc_34E72
		subq.b	#1,$3A(a0)
		bpl.s	++ ;loc_34E3A
		cmpi.b	#3,$35(a0)
		beq.s	+++ ;loc_34E60
		move.w	#0,$3C(a0)
		move.b	#2,$35(a0)
		movea.l	$36(a0),a1
		move.w	(a1)+,d0
		move.w	d0,$2E(a0)
		move.b	$3F(a0),d1
		andi.b	#$7F,d1
		beq.s	+ ;loc_34E34
		move.w	d0,$3C(a0)

+ ;loc_34E34:
		move.l	a1,$36(a0)
		bra.s	loc_34E72
; ---------------------------------------------------------------------------

+ ;loc_34E3A:
		move.l	x_pos(a0),d2
		move.l	y_pos(a0),d3
		move.w	x_vel(a0),d0
		ext.l	d0
		asl.l	#8,d0
		add.l	d0,d2
		move.w	y_vel(a0),d0
		ext.l	d0
		asl.l	#8,d0
		add.l	d0,d3
		move.l	d2,x_pos(a0)
		move.l	d3,y_pos(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_34E60:
		tst.b	$3E(a0)
		bpl.s	+ ;loc_34E6A
		neg.w	ground_vel(a0)

+ ;loc_34E6A:
		move.b	#0,$35(a0)
		rts
; ---------------------------------------------------------------------------

loc_34E72:
		move.w	$3C(a0),d0
		add.w	d0,d0
		tst.b	$3F(a0)
		bpl.s	+ ;loc_34E80
		neg.w	d0

+ ;loc_34E80:
		jsr	(GetSineCosine).l
		muls.w	#$5800,d0
		swap	d0
		add.w	$30(a0),d0
		move.w	d0,x_pos(a0)
		move.w	$32(a0),d0
		add.w	$3C(a0),d0
		move.w	d0,y_pos(a0)
		moveq	#2,d1
		move.w	ground_vel(a0),d0
		bpl.s	+ ;loc_34EAA
		neg.w	d0

+ ;loc_34EAA:
		cmpi.w	#$C00,d0
		bne.s	+ ;loc_34EB2
		moveq	#3,d1

+ ;loc_34EB2:
		move.b	$3F(a0),d0
		andi.b	#$7F,d0
		beq.s	+ ;loc_34EC4
		sub.w	d1,$3C(a0)
		bgt.s	locret_34EF4
		bra.s	++ ;loc_34ED2
; ---------------------------------------------------------------------------

+ ;loc_34EC4:
		add.w	d1,$3C(a0)
		move.w	$2E(a0),d0
		cmp.w	$3C(a0),d0
		bhi.s	locret_34EF4

+ ;loc_34ED2:
		move.b	#3,$35(a0)
		movea.l	$36(a0),a2
		move.w	(a2)+,d4
		move.w	(a2)+,d5
		move.w	ground_vel(a0),d2
		bpl.s	+ ;loc_34EE8
		neg.w	d2

+ ;loc_34EE8:
		tst.w	d2
		bne.s	+ ;loc_34EF0
		move.w	#$800,d2

+ ;loc_34EF0:
		bra.w	loc_34C98
; ---------------------------------------------------------------------------

locret_34EF4:
		rts
; End of function sub_34DFA

; ---------------------------------------------------------------------------
Map_MGZTopPlatform:
		include "Levels/MGZ/Misc Object Data/Map - Top Platform.asm"
; ---------------------------------------------------------------------------

Obj_MGZTopLauncher:
		move.l	#Map_MGZTopPlatform,mappings(a0)
		move.w	#make_art_tile($3FF,2,0),art_tile(a0)
		ori.b	#4,render_flags(a0)
		move.w	#$200,priority(a0)
		move.b	#$C,width_pixels(a0)
		move.b	#8,height_pixels(a0)
		move.b	#2,mapping_frame(a0)
		move.w	#$10,$30(a0)
		move.w	#$C00,d0
		btst	#0,status(a0)
		beq.s	+ ;loc_34F60
		neg.w	d0

+ ;loc_34F60:
		move.w	d0,x_vel(a0)
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	+ ;loc_34F7C
		move.l	#Obj_MGZTopPlatform,(a1)
		move.b	#1,subtype(a1)
		move.w	a1,$3E(a0)

+ ;loc_34F7C:
		move.l	#loc_34F82,(a0)

loc_34F82:
		movea.w	$3E(a0),a1
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		addq.w	#4,$24(a1)
		cmpi.b	#4,$40(a1)
		beq.s	+ ;loc_34FA6
		cmpi.b	#4,$42(a1)
		bne.s	++ ;loc_34FAC

+ ;loc_34FA6:
		move.l	#loc_34FB2,(a0)

+ ;loc_34FAC:
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------

loc_34FB2:
		movea.w	$3E(a0),a1
		addq.w	#1,y_pos(a0)
		subq.w	#1,$30(a0)
		bne.s	+ ;loc_34FCC
		move.l	#loc_35006,(a0)
		move.w	#$7F00,x_pos(a0)

+ ;loc_34FCC:
		cmpi.w	#4,$30(a0)
		beq.s	+ ;loc_34FE8
		bcs.s	loc_35006
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		addq.w	#4,$24(a1)
		bra.s	loc_35006
; ---------------------------------------------------------------------------

+ ;loc_34FE8:
		move.w	x_vel(a0),d1
		move.w	d1,x_vel(a1)
		move.w	d1,ground_vel(a1)
		move.b	#1,$34(a1)
		bclr	#1,status(a1)
		move.b	#0,subtype(a1)

loc_35006:
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------

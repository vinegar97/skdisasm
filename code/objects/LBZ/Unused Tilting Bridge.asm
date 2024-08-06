Obj_LBZUnusedTiltingBridge:
		move.l	#Map_LBZUnusedTiltingBridge,mappings(a0)
		move.w	#make_art_tile($3C3,2,0),art_tile(a0)
		ori.b	#4,render_flags(a0)
		move.b	#$40,width_pixels(a0)
		move.b	#$40,height_pixels(a0)
		move.w	#$200,priority(a0)
		move.b	#$80,$42(a0)
		move.b	#1,mapping_frame(a0)
		jsr	(AllocateObjectAfterCurrent).l
		bne.w	+ ;loc_27190
		move.l	#loc_271E0,(a1)
		move.l	#Map_LBZUnusedTiltingBridge,mappings(a1)
		move.w	#make_art_tile($3C3,2,0),art_tile(a1)
		ori.b	#4,render_flags(a1)
		move.b	#$40,width_pixels(a1)
		move.b	#$40,height_pixels(a1)
		move.w	#$200,priority(a1)
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		move.b	#$80,$42(a1)
		bset	#6,render_flags(a1)
		move.w	#6,mainspr_childsprites(a1)
		move.w	a0,$3C(a1)

+ ;loc_27190:
		move.b	#$10,$42(a0)
		move.l	#loc_2719C,(a0)

loc_2719C:
		btst	#button_B,(Ctrl_2_held).w
		beq.s	+ ;loc_271AA
		move.b	#0,$42(a0)

+ ;loc_271AA:
		btst	#button_C,(Ctrl_2_held).w
		beq.s	+ ;loc_271B8
		addi.b	#1,$42(a0)

+ ;loc_271B8:
		btst	#button_A,(Ctrl_2_held).w
		beq.s	+ ;loc_271C6
		subi.b	#1,$42(a0)

+ ;loc_271C6:
		moveq	#0,d1
		move.b	width_pixels(a0),d1
		moveq	#8,d2
		move.w	d2,d3
		addq.w	#1,d3
		move.w	x_pos(a0),d4
		bsr.w	++ ;sub_27270
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------

loc_271E0:
		movea.w	$3C(a0),a1
		move.b	$42(a1),$42(a0)
		bsr.w	+ ;sub_271F4
		jmp	(Sprite_OnScreen_Test).l

; =============== S U B R O U T I N E =======================================


+ ;sub_271F4:
		move.b	$42(a0),d0
		jsr	(GetSineCosine).l
		move.w	y_pos(a0),d2
		move.w	x_pos(a0),d3
		swap	d0
		swap	d1
		asr.l	#5,d0
		asr.l	#5,d1
		move.l	d0,d4
		move.l	d1,d5
		add.l	d0,d0
		add.l	d1,d1
		movem.l	d0-d5,-(sp)
		add.l	d0,d4
		add.l	d1,d5
		lea	sub2_x_pos(a0),a2
		moveq	#3-1,d6

- ;loc_27224:
		movem.l	d4-d5,-(sp)
		swap	d4
		swap	d5
		add.w	d2,d4
		add.w	d3,d5
		move.w	d5,(a2)+
		move.w	d4,(a2)+
		movem.l	(sp)+,d4-d5
		add.l	d0,d4
		add.l	d1,d5
		addq.w	#2,a2
		dbf	d6,- ;loc_27224
		movem.l	(sp)+,d0-d5
		neg.l	d4
		neg.l	d5
		sub.l	d0,d4
		sub.l	d1,d5
		moveq	#3-1,d6

- ;loc_27250:
		movem.l	d4-d5,-(sp)
		swap	d4
		swap	d5
		add.w	d2,d4
		add.w	d3,d5
		move.w	d5,(a2)+
		move.w	d4,(a2)+
		movem.l	(sp)+,d4-d5
		sub.l	d0,d4
		sub.l	d1,d5
		addq.w	#2,a2
		dbf	d6,- ;loc_27250
		rts
; End of function sub_271F4


; =============== S U B R O U T I N E =======================================


+ ;sub_27270:
		; Bug: probably meant to be $30(a0)
		lea	$30,a2
		lea	(Player_1).w,a1
		moveq	#p1_standing_bit,d6
		movem.l	d1-d3,-(sp)
		bsr.s	+ ;sub_2728E
		movem.l	(sp)+,d1-d3
		; Bug: probably meant to be $34(a0)
		lea	$34,a2
		lea	(Player_2).w,a1
		addq.b	#p2_standing_bit-p1_standing_bit,d6
; End of function sub_27270


; =============== S U B R O U T I N E =======================================


+ ;sub_2728E:
		btst	d6,status(a0)
		beq.w	loc_2734C
		move.w	ground_vel(a1),d0
		move.b	$42(a0),d4
		addi.b	#$40,d4
		bpl.s	+ ;loc_272A6
		neg.w	d0

+ ;loc_272A6:
		add.w	d0,(a2)
		btst	#Status_InAir,status(a1)
		bne.s	++ ;loc_272D4
		move.b	$42(a0),d0
		jsr	(GetSineCosine).l
		tst.w	d1
		bmi.s	+ ;loc_272C0
		neg.w	d1

+ ;loc_272C0:
		asr.w	#2,d1
		move.w	x_pos(a1),d0
		sub.w	x_pos(a0),d0
		cmp.w	d1,d0
		blt.s	+ ;loc_272D4
		neg.w	d1
		cmp.w	d1,d0
		blt.s	++ ;loc_272E8

+ ;loc_272D4:
		bclr	#Status_OnObj,status(a1)
		bset	#Status_InAir,status(a1)
		bclr	d6,status(a0)
		moveq	#0,d4
		rts
; ---------------------------------------------------------------------------

+ ;loc_272E8:
		bsr.w	sub_272F0
		moveq	#0,d4
		rts
; End of function sub_2728E


; =============== S U B R O U T I N E =======================================


sub_272F0:
		move.w	d3,d5
		move.b	$42(a0),d0
		jsr	(GetSineCosine).l
		move.w	y_pos(a0),d2
		move.w	x_pos(a0),d3
		move.w	(a2),d4
		muls.w	d4,d0
		muls.w	d4,d1
		swap	d0
		swap	d1
		add.w	d0,d2
		add.w	d1,d3
		move.b	$42(a0),d0
		move.b	d0,d1
		addi.b	#$40,d1
		bpl.s	+ ;loc_27322
		addi.b	#$80,d0

+ ;loc_27322:
		move.b	d0,angle(a1)
		moveq	#0,d1
		move.b	y_radius(a1),d1
		add.w	d1,d5
		lsl.w	#8,d5
		jsr	(GetSineCosine).l
		muls.w	d5,d0
		muls.w	d5,d1
		swap	d0
		swap	d1
		add.w	d0,d3
		sub.w	d1,d2
		move.w	d2,y_pos(a1)
		move.w	d3,x_pos(a1)
		rts
; End of function sub_272F0

; ---------------------------------------------------------------------------

loc_2734C:
		tst.w	y_vel(a1)
		bmi.w	locret_273E2
		move.b	$42(a0),d0
		jsr	(GetSineCosine).l
		move.w	d0,d4
		move.w	d1,d2
		tst.w	d1
		bmi.s	+ ;loc_27368
		neg.w	d1

+ ;loc_27368:
		asr.w	#2,d1
		move.w	x_pos(a1),d0
		sub.w	x_pos(a0),d0
		cmp.w	d1,d0
		blt.s	locret_273E2
		neg.w	d1
		cmp.w	d1,d0
		bge.s	locret_273E2
		swap	d0
		divs.w	d2,d0
		move.w	d0,(a2)
		neg.w	d4
		muls.w	d4,d0
		swap	d0
		move.w	d3,d5
		add.w	d0,d3
		move.w	y_pos(a0),d0
		sub.w	d3,d0
		move.w	y_pos(a1),d2
		move.b	y_radius(a1),d1
		ext.w	d1
		add.w	d2,d1
		addq.w	#4,d1
		sub.w	d1,d0
		bhi.s	locret_273E2
		cmpi.w	#-$10,d0
		blo.s	locret_273E2
		tst.b	object_control(a1)
		bmi.s	locret_273E2
		cmpi.b	#6,routine(a1)
		bhs.s	locret_273E2
		move.b	$42(a0),d0
		move.b	d0,d1
		addi.b	#$40,d1
		bpl.s	+ ;loc_273C8
		addi.b	#$80,d0

+ ;loc_273C8:
		jsr	(GetSineCosine).l
		muls.w	#$1B00,d0
		swap	d0
		sub.w	d0,(a2)
		move.w	d5,d3
		bsr.w	sub_272F0
		jmp	(RideObject_SetRide).l
; ---------------------------------------------------------------------------

locret_273E2:
		rts
; ---------------------------------------------------------------------------

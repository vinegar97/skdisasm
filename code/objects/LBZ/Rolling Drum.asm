Obj_LBZRollingDrum:
		moveq	#0,d0
		move.b	subtype(a0),d0
		move.w	d0,$32(a0)
		neg.w	d0
		move.w	d0,$30(a0)
		move.b	#$80,width_pixels(a0)
		move.l	#loc_2C3CA,(a0)

loc_2C3CA:
		lea	(Player_1).w,a1
		lea	(_unkF7B0+0).w,a2
		moveq	#p1_standing_bit,d6
		bsr.s	+ ;sub_2C3E8
		lea	(Player_2).w,a1
		lea	(_unkF7B0+1).w,a2
		addq.b	#p2_standing_bit-p1_standing_bit,d6
		bsr.s	+ ;sub_2C3E8
		jmp	(Delete_Sprite_If_Not_In_Range).l

; =============== S U B R O U T I N E =======================================


+ ;sub_2C3E8:
		btst	d6,status(a0)
		bne.w	loc_2C46E
		move.w	x_pos(a1),d0
		sub.w	x_pos(a0),d0
		cmp.w	$30(a0),d0
		blt.s	locret_2C46C
		cmp.w	$32(a0),d0
		bge.s	locret_2C46C
		move.w	y_pos(a1),d0
		sub.w	y_pos(a0),d0
		addi.w	#$53,d0
		cmpi.w	#$A6,d0
		bhs.s	locret_2C46C
		cmpi.w	#$53,d0
		bhs.s	+ ;loc_2C424
		tst.w	y_vel(a1)
		bmi.s	locret_2C46C
		bra.s	++ ;loc_2C42C
; ---------------------------------------------------------------------------

+ ;loc_2C424:
		cmpi.w	#$38,y_vel(a1)
		bgt.s	locret_2C46C

+ ;loc_2C42C:
		cmpi.b	#6,routine(a1)
		bhs.s	locret_2C46C
		tst.w	(Debug_placement_mode).w
		bne.s	locret_2C46C
		cmpi.w	#8,d0
		bhs.s	+ ;loc_2C444
		move.b	#$81,(a2)

+ ;loc_2C444:
		cmpi.w	#$9E,d0
		blo.s	+ ;loc_2C44E
		move.b	#1,(a2)

+ ;loc_2C44E:
		jsr	(RideObject_SetRide).l
		move.b	#$80,flip_type(a1)
		move.w	#1,anim(a1)	; and prev_anim
		tst.w	ground_vel(a1)
		bne.s	locret_2C46C
		move.w	#1,ground_vel(a1)

locret_2C46C:
		rts
; ---------------------------------------------------------------------------

loc_2C46E:
		btst	#Status_InAir,status(a1)
		bne.s	+ ;loc_2C4A8
		move.w	x_pos(a1),d0
		sub.w	x_pos(a0),d0
		cmp.w	$30(a0),d0
		blt.s	loc_2C48A
		cmp.w	$32(a0),d0
		blt.s	++ ;loc_2C4BA

loc_2C48A:
		bclr	#Status_OnObj,status(a1)
		bclr	d6,status(a0)
		move.b	#0,flips_remaining(a1)
		move.b	#4,flip_speed(a1)
		bset	#Status_InAir,status(a1)
		rts
; ---------------------------------------------------------------------------

+ ;loc_2C4A8:
		move.w	y_pos(a1),d0
		sub.w	y_pos(a0),d0
		bmi.s	loc_2C48A
		move.w	#$400,y_vel(a1)
		bra.s	loc_2C48A
; ---------------------------------------------------------------------------

+ ;loc_2C4BA:
		btst	#Status_OnObj,status(a1)
		beq.s	locret_2C46C
		move.b	(a2),d0
		jsr	(GetSineCosine).l
		moveq	#0,d2
		move.b	y_radius(a1),d2
		lsl.w	#8,d2
		addi.w	#$4000,d2
		muls.w	d2,d1
		swap	d1
		add.w	y_pos(a0),d1
		move.w	d1,y_pos(a1)
		move.b	(a2),d0
		addi.b	#$80,d0
		move.b	d0,flip_angle(a1)
		addq.b	#2,(a2)
		move.b	#$80,flip_type(a1)
		tst.w	ground_vel(a1)
		bne.s	+ ;loc_2C506
		move.w	#1,ground_vel(a1)
		move.b	#$81,flip_type(a1)

+ ;loc_2C506:
		bset	#7,art_tile(a1)
		tst.b	d0
		bpl.s	locret_2C516
		bclr	#7,art_tile(a1)

locret_2C516:
		rts
; End of function sub_2C3E8

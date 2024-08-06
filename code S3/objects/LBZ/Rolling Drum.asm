Obj_LBZRollingDrum:
		moveq	#0,d0
		move.b	subtype(a0),d0
		move.w	d0,$32(a0)
		neg.w	d0
		move.w	d0,$30(a0)
		move.b	#$80,width_pixels(a0)
		move.l	#loc_2B9D2,(a0)

loc_2B9D2:
		lea	(Player_1).w,a1
		lea	(_unkF7B0+2).w,a2
		moveq	#p1_standing_bit,d6
		bsr.s	+ ;sub_2B9F0
		lea	(Player_2).w,a1
		lea	(_unkF7B0+3).w,a2
		addq.b	#p2_standing_bit-p1_standing_bit,d6
		bsr.s	+ ;sub_2B9F0
		jmp	(Delete_Sprite_If_Not_In_Range).l

; =============== S U B R O U T I N E =======================================


+ ;sub_2B9F0:
		btst	d6,status(a0)
		bne.w	loc_2BA76
		move.w	x_pos(a1),d0
		sub.w	x_pos(a0),d0
		cmp.w	$30(a0),d0
		blt.s	locret_2BA74
		cmp.w	$32(a0),d0
		bge.s	locret_2BA74
		move.w	y_pos(a1),d0
		sub.w	y_pos(a0),d0
		addi.w	#$53,d0
		cmpi.w	#$A6,d0
		bhs.s	locret_2BA74
		cmpi.w	#$53,d0
		bhs.s	+ ;loc_2BA2C
		tst.w	y_vel(a1)
		bmi.s	locret_2BA74
		bra.s	++ ;loc_2BA34
; ---------------------------------------------------------------------------

+ ;loc_2BA2C:
		cmpi.w	#$38,y_vel(a1)
		bgt.s	locret_2BA74

+ ;loc_2BA34:
		cmpi.b	#6,routine(a1)
		bhs.s	locret_2BA74
		tst.w	(Debug_placement_mode).w
		bne.s	locret_2BA74
		cmpi.w	#8,d0
		bhs.s	+ ;loc_2BA4C
		move.b	#$81,(a2)

+ ;loc_2BA4C:
		cmpi.w	#$9E,d0
		blo.s	+ ;loc_2BA56
		move.b	#1,(a2)

+ ;loc_2BA56:
		jsr	(RideObject_SetRide).l
		move.b	#$80,flip_type(a1)
		move.w	#1,anim(a1)	; and prev_anim
		tst.w	ground_vel(a1)
		bne.s	locret_2BA74
		move.w	#1,ground_vel(a1)

locret_2BA74:
		rts
; ---------------------------------------------------------------------------

loc_2BA76:
		btst	#Status_InAir,status(a1)
		bne.s	+ ;loc_2BAB0
		move.w	x_pos(a1),d0
		sub.w	x_pos(a0),d0
		cmp.w	$30(a0),d0
		blt.s	loc_2BA92
		cmp.w	$32(a0),d0
		blt.s	++ ;loc_2BAC2

loc_2BA92:
		bclr	#Status_OnObj,status(a1)
		bclr	d6,status(a0)
		move.b	#0,flips_remaining(a1)
		move.b	#4,flip_speed(a1)
		bset	#Status_InAir,status(a1)
		rts
; ---------------------------------------------------------------------------

+ ;loc_2BAB0:
		move.w	y_pos(a1),d0
		sub.w	y_pos(a0),d0
		bmi.s	loc_2BA92
		move.w	#$400,y_vel(a1)
		bra.s	loc_2BA92
; ---------------------------------------------------------------------------

+ ;loc_2BAC2:
		btst	#Status_OnObj,status(a1)
		beq.s	locret_2BA74
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
		bne.s	+ ;loc_2BB0E
		move.w	#1,ground_vel(a1)
		move.b	#$81,flip_type(a1)

+ ;loc_2BB0E:
		bset	#7,art_tile(a1)
		tst.b	d0
		bpl.s	locret_2BB1E
		bclr	#7,art_tile(a1)

locret_2BB1E:
		rts
; End of function sub_2B9F0

Obj_AIZHollowTree:
		move.b	#$D0,width_pixels(a0)
		move.l	#loc_1D3D0,(a0)

loc_1D3D0:
		bsr.w	sub_1D436
		move.b	status(a0),d0
		andi.b	#$18,d0
		bne.s	loc_1D430
		tst.w	$38(a0)
		beq.s	loc_1D430
		subq.w	#1,$38(a0)
		bne.s	loc_1D3F8
		move.w	#$1300,(Camera_min_X_pos).w
		move.w	#$4000,(Camera_max_X_pos).w
		bra.s	loc_1D430
; ---------------------------------------------------------------------------

loc_1D3F8:
		cmpi.w	#$1300,(Camera_min_X_pos).w
		beq.s	loc_1D414
		cmpi.w	#$2D00,(Player_1+x_pos).w
		blo.s	loc_1D410
		move.w	#$1300,(Camera_min_X_pos).w
		bra.s	loc_1D414
; ---------------------------------------------------------------------------

loc_1D410:
		subq.w	#4,(Camera_min_X_pos).w

loc_1D414:
		cmpi.w	#$4000,(Camera_max_X_pos).w
		beq.s	loc_1D430
		cmpi.w	#$2D00,(Player_1+x_pos).w
		bhs.s	loc_1D42C
		move.w	#$4000,(Camera_max_X_pos).w
		bra.s	loc_1D430
; ---------------------------------------------------------------------------

loc_1D42C:
		addq.w	#4,(Camera_max_X_pos).w

loc_1D430:
		jmp	(Delete_Sprite_If_Not_In_Range).l

; =============== S U B R O U T I N E =======================================


sub_1D436:
		lea	(Player_1).w,a1
		lea	$30(a0),a2
		moveq	#p1_standing_bit,d6
		bsr.s	sub_1D44C
		lea	(Player_2).w,a1
		lea	$34(a0),a2
		; Bug: if player 1 was riding the object, then d6 may have become dirty from
		; a call to Perform_Player_DPLC, causing player 2 to behave erratically
		addq.b	#p2_standing_bit-p1_standing_bit,d6
; End of function sub_1D436


; =============== S U B R O U T I N E =======================================


sub_1D44C:
		btst	d6,status(a0)
		bne.w	loc_1D4DA
		btst	#Status_InAir,status(a1)
		bne.w	locret_1D4D8
		move.w	x_pos(a1),d0
		addi.w	#$10,d0
		sub.w	x_pos(a0),d0
		bcs.s	locret_1D4D8
		cmpi.w	#$40,d0
		bge.s	locret_1D4D8
		move.w	y_pos(a1),d0
		sub.w	y_pos(a0),d0
		cmpi.w	#-$5A,d0
		blt.s	locret_1D4D8
		cmpi.w	#$A0,d0
		bgt.s	locret_1D4D8
		cmpi.w	#$600,x_vel(a1)
		blt.s	locret_1D4D8
		tst.b	object_control(a1)
		bne.s	locret_1D4D8
		bsr.w	RideObject_SetRide
		move.l	#0,(a2)
		bset	#6,object_control(a1)
		bset	#1,object_control(a1)
		move.b	#0,anim(a1)
		cmpa.w	#Player_1,a1
		bne.s	locret_1D4D8
		jsr	(AllocateObjectAfterCurrent).l
		bne.w	loc_1D4C6
		move.l	#Obj_AIZ1TreeRevealControl,(a1)

loc_1D4C6:
		move.w	#$2C60,(Camera_min_X_pos).w
		move.w	#$2C60,(Camera_max_X_pos).w
		move.w	#$3C,$38(a0)

locret_1D4D8:
		rts
; ---------------------------------------------------------------------------

loc_1D4DA:
		move.w	ground_vel(a1),d0
		bpl.s	loc_1D4E2
		neg.w	d0

loc_1D4E2:
		cmpi.w	#$600,d0
		blo.w	loc_1D57C
		btst	#Status_InAir,status(a1)
		bne.s	loc_1D50A
		move.w	y_pos(a1),d0
		sub.w	y_pos(a0),d0
		addi.w	#$90,d0
		bmi.s	AIZTree_FallOff
		cmpi.w	#$130,d0
		bls.w	AIZTree_SetPlayerPos
		bra.s	AIZTree_FallOff
; ---------------------------------------------------------------------------

loc_1D50A:
		cmpi.w	#$2C99,x_pos(a1)
		bhs.s	loc_1D51E
		move.w	#$2C99,x_pos(a1)
		move.w	#$400,x_vel(a1)

loc_1D51E:
		cmpi.w	#$2D66,x_pos(a1)
		blo.s	AIZTree_FallOff
		move.w	#$2D66,x_pos(a1)
		move.w	#-$400,x_vel(a1)

AIZTree_FallOff:
		bset	#Status_InAir,status(a1)
		bclr	#Status_Roll,status(a1)
		move.b	#$13,y_radius(a1)
		move.b	#9,x_radius(a1)
		move.w	#1,anim(a1)
		bclr	#Status_OnObj,status(a1)
		bclr	d6,status(a0)
		move.b	#0,flips_remaining(a1)
		move.b	#4,flip_speed(a1)
		bclr	#6,object_control(a1)
		bclr	#1,object_control(a1)
		asr	x_vel(a1)
		asr	y_vel(a1)
		rts
; ---------------------------------------------------------------------------

loc_1D57C:
		cmpi.w	#$400,(a2)
		bhs.s	AIZTree_FallOff
		move.l	d6,-(sp)
		move.l	a1,-(sp)
		bsr.s	AIZTree_SetPlayerPos
		movea.l	(sp)+,a1
		move.l	(sp)+,d6
		bra.s	AIZTree_FallOff
; End of function sub_1D44C

; ---------------------------------------------------------------------------
		bra.w	loc_1D50A

; =============== S U B R O U T I N E =======================================


AIZTree_SetPlayerPos:
		btst	#Status_OnObj,status(a1)
		beq.w	locret_1D4D8
		move.w	ground_vel(a1),d0
		ext.l	d0
		lsl.l	#8,d0
		add.l	d0,(a2)
		bmi.s	AIZTree_FallOff
		cmpi.w	#$400,(a2)
		blo.s	loc_1D5BA
		move.w	#$1300,(Camera_min_X_pos).w
		move.w	#$4000,(Camera_max_X_pos).w

loc_1D5BA:
		move.w	x_pos(a1),d2
		move.w	(a2),d0
		lsr.w	#1,d0
		jsr	(GetSineCosine).l
		muls.w	#$7000,d0
		swap	d0
		add.w	x_pos(a0),d0
		move.w	d0,x_pos(a1)
		sub.w	d2,d0
		asl.w	#8,d0
		move.w	d0,x_vel(a1)
		move.w	y_pos(a1),d2
		move.w	(a2),d0
		lsr.w	#2,d0
		neg.w	d0
		addi.w	#$90,d0
		add.w	y_pos(a0),d0
		move.w	d0,y_pos(a1)
		sub.w	d2,d0
		asl.w	#8,d0
		move.w	d0,y_vel(a1)
		moveq	#0,d0
		move.w	(a2),d0
		lsr.w	#1,d0
		divu.w	#$B,d0
		move.b	AIZTree_PlayerFrames(pc,d0.w),mapping_frame(a1)
		moveq	#0,d0
		move.b	mapping_frame(a1),d0
		jmp	(Perform_Player_DPLC).l
; End of function AIZTree_SetPlayerPos

; ---------------------------------------------------------------------------
AIZTree_PlayerFrames:
		dc.b  $69, $6A, $6B, $77, $6C, $6C, $6D, $6D, $6E, $6E, $6F, $6F, $70, $70, $71, $71, $72, $72, $73, $73
		dc.b  $74, $74, $75, $75, $76, $76, $77, $77, $6C, $6C, $6D, $6D, $6E, $6E, $6F, $6F, $70, $70, $71, $71
		dc.b  $72, $72, $73, $73, $74, $74, $75, $75, $6B, $6B, $6A, $6A, $69, $69
; ---------------------------------------------------------------------------

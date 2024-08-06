; =============== S U B R O U T I N E =======================================


SolidObjectFull:
		lea	(Player_1).w,a1
		moveq	#p1_standing_bit,d6
		movem.l	d1-d4,-(sp)
		bsr.s	SolidObjectFull_1P
		movem.l	(sp)+,d1-d4
		lea	(Player_2).w,a1
		tst.b	render_flags(a1)
		bpl.w	locret_1BA6A
		addq.b	#p2_standing_bit-p1_standing_bit,d6
; End of function SolidObjectFull


; =============== S U B R O U T I N E =======================================


SolidObjectFull_1P:
		btst	d6,status(a0)
		beq.w	loc_1BD3E
		move.w	d1,d2
		add.w	d2,d2
		btst	#Status_InAir,status(a1)
		bne.s	loc_1BA4E
		move.w	x_pos(a1),d0
		sub.w	x_pos(a0),d0
		add.w	d1,d0
		bmi.s	loc_1BA4E
		cmp.w	d2,d0
		blo.s	loc_1BA62

loc_1BA4E:
		bclr	#Status_OnObj,status(a1)
		bset	#Status_InAir,status(a1)
		bclr	d6,status(a0)
		moveq	#0,d4
		rts
; ---------------------------------------------------------------------------

loc_1BA62:
		move.w	d4,d2
		bsr.w	MvSonicOnPtfm
		moveq	#0,d4

locret_1BA6A:
		rts
; End of function SolidObjectFull_1P


; =============== S U B R O U T I N E =======================================


SolidObjectFull2:
		lea	(Player_1).w,a1
		moveq	#p1_standing_bit,d6
		movem.l	d1-d4,-(sp)
		bsr.s	SolidObjectFull2_1P
		movem.l	(sp)+,d1-d4
		lea	(Player_2).w,a1
		addq.b	#p2_standing_bit-p1_standing_bit,d6
; End of function SolidObjectFull2


; =============== S U B R O U T I N E =======================================


SolidObjectFull2_1P:
		btst	d6,status(a0)
		beq.w	SolidObject_cont
		move.w	d1,d2
		add.w	d2,d2
		btst	#Status_InAir,status(a1)
		bne.s	loc_1BAA6
		move.w	x_pos(a1),d0
		sub.w	x_pos(a0),d0
		add.w	d1,d0
		bmi.s	loc_1BAA6
		cmp.w	d2,d0
		blo.s	loc_1BABA

loc_1BAA6:
		bclr	#Status_OnObj,status(a1)
		bset	#Status_InAir,status(a1)
		bclr	d6,status(a0)
		moveq	#0,d4
		rts
; ---------------------------------------------------------------------------

loc_1BABA:
		move.w	d4,d2
		bsr.w	MvSonicOnPtfm
		moveq	#0,d4
		rts
; End of function SolidObjectFull2_1P


; =============== S U B R O U T I N E =======================================


sub_1BAC4:
		lea	(Player_1).w,a1
		moveq	#p1_standing_bit,d6
		movem.l	d1-d4,-(sp)
		bsr.s	sub_1BADA
		movem.l	(sp)+,d1-d4
		lea	(Player_2).w,a1
		addq.b	#p2_standing_bit-p1_standing_bit,d6
; End of function sub_1BAC4


; =============== S U B R O U T I N E =======================================


sub_1BADA:
		btst	d6,status(a0)
		beq.w	loc_1BC84
		move.w	d1,d2
		add.w	d2,d2
		btst	#Status_InAir,status(a1)
		bne.s	loc_1BAFE
		move.w	x_pos(a1),d0
		sub.w	x_pos(a0),d0
		add.w	d1,d0
		bmi.s	loc_1BAFE
		cmp.w	d2,d0
		blo.s	loc_1BB12

loc_1BAFE:
		bclr	#Status_OnObj,status(a1)
		bset	#Status_InAir,status(a1)
		bclr	d6,status(a0)
		moveq	#0,d4
		rts
; ---------------------------------------------------------------------------

loc_1BB12:
		move.w	d4,d2
		bsr.w	SolidObjSloped2
		move.w	d6,d4
		addi.b	#$11,d4
		bset	d4,d6
		moveq	#0,d4
		rts
; End of function sub_1BADA

; ---------------------------------------------------------------------------
		lea	(Player_1).w,a1
		moveq	#p1_standing_bit,d6
		movem.l	d1-d4,-(sp)
		bsr.s	sub_1BB3A
		movem.l	(sp)+,d1-d4
		lea	(Player_2).w,a1
		addq.b	#p2_standing_bit-p1_standing_bit,d6

; =============== S U B R O U T I N E =======================================


sub_1BB3A:
		btst	d6,status(a0)
		beq.w	loc_1BCDE
		move.w	d1,d2
		add.w	d2,d2
		btst	#Status_InAir,status(a1)
		bne.s	loc_1BB5E
		move.w	x_pos(a1),d0
		sub.w	x_pos(a0),d0
		add.w	d1,d0
		bmi.s	loc_1BB5E
		cmp.w	d2,d0
		blo.s	loc_1BB72

loc_1BB5E:
		bclr	#Status_OnObj,status(a1)
		bset	#Status_InAir,status(a1)
		bclr	d6,status(a0)
		moveq	#0,d4
		rts
; ---------------------------------------------------------------------------

loc_1BB72:
		move.w	d4,d2
		bsr.w	SolidObjSloped4
		moveq	#0,d4
		rts
; End of function sub_1BB3A


; =============== S U B R O U T I N E =======================================


sub_1BB7C:
		lea	(Player_1).w,a1
		moveq	#p1_standing_bit,d6
		movem.l	d1-d4,-(sp)
		bsr.s	sub_1BB92
		movem.l	(sp)+,d1-d4
		lea	(Player_2).w,a1
		addq.b	#p2_standing_bit-p1_standing_bit,d6
; End of function sub_1BB7C


; =============== S U B R O U T I N E =======================================


sub_1BB92:
		btst	d6,status(a0)
		beq.w	loc_1BC84
		move.w	d1,d2
		add.w	d2,d2
		btst	#Status_InAir,status(a1)
		bne.s	loc_1BBB6
		move.w	x_pos(a1),d0
		sub.w	x_pos(a0),d0
		add.w	d1,d0
		bmi.s	loc_1BBB6
		cmp.w	d2,d0
		blo.s	loc_1BBC4

loc_1BBB6:
		bclr	#Status_OnObj,status(a1)
		bclr	d6,status(a0)
		moveq	#0,d4
		rts
; ---------------------------------------------------------------------------

loc_1BBC4:
		move.w	d4,d2
		bsr.w	SolidObjSloped2
		move.w	d6,d4
		addi.b	#$11,d4
		bset	d4,d6
		moveq	#0,d4
		rts
; End of function sub_1BB92


; =============== S U B R O U T I N E =======================================


SolidObjectFull_Offset:
		lea	(Player_1).w,a1
		moveq	#p1_standing_bit,d6
		movem.l	d1-d4,-(sp)
		bsr.s	SolidObjectFull_Offset_1P
		movem.l	(sp)+,d1-d4
		lea	(Player_2).w,a1
		addq.b	#p2_standing_bit-p1_standing_bit,d6
; End of function SolidObjectFull_Offset


; =============== S U B R O U T I N E =======================================


SolidObjectFull_Offset_1P:
		btst	d6,status(a0)
		beq.w	loc_1BC42
		btst	#Status_InAir,status(a1)
		bne.s	loc_1BC0E
		move.w	x_pos(a1),d0
		sub.w	x_pos(a0),d0
		add.w	d1,d0
		bmi.s	loc_1BC0E
		add.w	d1,d1
		cmp.w	d1,d0
		blo.s	loc_1BC22

loc_1BC0E:
		bclr	#Status_OnObj,status(a1)
		bset	#Status_InAir,status(a1)
		bclr	d6,status(a0)
		moveq	#0,d4
		rts
; ---------------------------------------------------------------------------

loc_1BC22:
		move.w	y_pos(a0),d0
		sub.w	d2,d0
		add.w	d3,d0
		moveq	#0,d1
		move.b	y_radius(a1),d1
		sub.w	d1,d0
		move.w	d0,y_pos(a1)
		sub.w	x_pos(a0),d4
		sub.w	d4,x_pos(a1)
		moveq	#0,d4
		rts
; ---------------------------------------------------------------------------

loc_1BC42:
		move.w	x_pos(a1),d0
		sub.w	x_pos(a0),d0
		add.w	d1,d0
		bmi.w	loc_1BE2E
		move.w	d1,d4
		add.w	d4,d4
		cmp.w	d4,d0
		bhi.w	loc_1BE2E
		move.w	y_pos(a0),d5
		add.w	d3,d5
		move.b	y_radius(a1),d3
		ext.w	d3
		add.w	d3,d2
		move.w	y_pos(a1),d3
		sub.w	d5,d3
		addq.w	#4,d3
		add.w	d2,d3
		bmi.w	loc_1BE2E
		move.w	d2,d4
		add.w	d4,d4
		cmp.w	d4,d3
		bhs.w	loc_1BE2E
		bra.w	loc_1BD8A
; ---------------------------------------------------------------------------

loc_1BC84:
		move.w	x_pos(a1),d0
		sub.w	x_pos(a0),d0
		add.w	d1,d0
		bmi.w	loc_1BE2E
		move.w	d1,d3
		add.w	d3,d3
		cmp.w	d3,d0
		bhi.w	loc_1BE2E
		move.w	d0,d5
		btst	#0,render_flags(a0)
		beq.s	loc_1BCAA
		not.w	d5
		add.w	d3,d5

loc_1BCAA:
		lsr.w	#1,d5
		move.b	(a2,d5.w),d3
		sub.b	(a2),d3
		ext.w	d3
		move.w	y_pos(a0),d5
		sub.w	d3,d5
		move.b	y_radius(a1),d3
		ext.w	d3
		add.w	d3,d2
		move.w	y_pos(a1),d3
		sub.w	d5,d3
		addq.w	#4,d3
		add.w	d2,d3
		bmi.w	loc_1BE2E
		move.w	d2,d4
		add.w	d4,d4
		cmp.w	d4,d3
		bhs.w	loc_1BE2E
		bra.w	loc_1BD8A
; ---------------------------------------------------------------------------

loc_1BCDE:
		move.w	x_pos(a1),d0
		sub.w	x_pos(a0),d0
		add.w	d1,d0
		bmi.w	loc_1BE2E
		move.w	d1,d3
		add.w	d3,d3
		cmp.w	d3,d0
		bhi.w	loc_1BE2E
		move.w	d0,d5
		btst	#0,render_flags(a0)
		beq.s	loc_1BD04
		not.w	d5
		add.w	d3,d5

loc_1BD04:
		andi.w	#$FFFE,d5
		move.b	(a2,d5.w),d3
		move.b	1(a2,d5.w),d2
		ext.w	d2
		ext.w	d3
		move.w	y_pos(a0),d5
		sub.w	d3,d5
		move.w	y_pos(a1),d3
		sub.w	d5,d3
		move.b	y_radius(a1),d5
		ext.w	d5
		add.w	d5,d3
		addq.w	#4,d3
		bmi.w	loc_1BE2E
		add.w	d5,d2
		move.w	d2,d4
		add.w	d5,d4
		cmp.w	d4,d3
		bhs.w	loc_1BE2E
		bra.w	loc_1BD8A
; ---------------------------------------------------------------------------

loc_1BD3E:
		tst.b	render_flags(a0)
		bpl.w	loc_1BE2E

SolidObject_cont:
		move.w	x_pos(a1),d0
		sub.w	x_pos(a0),d0
		add.w	d1,d0
		bmi.w	loc_1BE2E
		move.w	d1,d3
		add.w	d3,d3
		cmp.w	d3,d0
		bhi.w	loc_1BE2E
		move.b	default_y_radius(a1),d4
		ext.w	d4
		add.w	d2,d4
		move.b	y_radius(a1),d3
		ext.w	d3
		add.w	d3,d2
		move.w	y_pos(a1),d3
		sub.w	y_pos(a0),d3
		addq.w	#4,d3
		add.w	d2,d3
		bmi.w	loc_1BE2E
		andi.w	#$FFF,d3
		add.w	d2,d4
		cmp.w	d4,d3
		bhs.w	loc_1BE2E

loc_1BD8A:
		tst.b	object_control(a1)
		bmi.w	loc_1BE2E
		cmpi.b	#6,routine(a1)
		bhs.w	loc_1BE54
		tst.w	(Debug_placement_mode).w
		bne.w	loc_1BE54
		move.w	d0,d5
		cmp.w	d0,d1
		bhs.s	loc_1BDB2
		add.w	d1,d1
		sub.w	d1,d0
		move.w	d0,d5
		neg.w	d5

loc_1BDB2:
		move.w	d3,d1
		cmp.w	d3,d2
		bhs.s	loc_1BDC0
		subq.w	#4,d3
		sub.w	d4,d3
		move.w	d3,d1
		neg.w	d1

loc_1BDC0:
		cmp.w	d1,d5
		bhi.w	loc_1BE58

loc_1BDC6:
		cmpi.w	#4,d1
		bls.w	loc_1BE58
		tst.w	d0
		beq.s	loc_1BDFA
		bmi.s	loc_1BDDC
		tst.w	x_vel(a1)
		bmi.s	loc_1BDFA
		bra.s	loc_1BDE2
; ---------------------------------------------------------------------------

loc_1BDDC:
		tst.w	x_vel(a1)
		bpl.s	loc_1BDFA

loc_1BDE2:
		move.w	#0,ground_vel(a1)
		move.w	#0,x_vel(a1)
		tst.b	status_tertiary(a1)
		bpl.s	loc_1BDFA
		bset	#6,status_tertiary(a1)

loc_1BDFA:
		sub.w	d0,x_pos(a1)
		btst	#Status_InAir,status(a1)
		bne.s	loc_1BE20
		move.l	d6,d4
		addq.b	#pushing_bit_delta,d4
		bset	d4,status(a0)
		bset	#Status_Push,status(a1)
		move.w	d6,d4
		addi.b	#$D,d4
		bset	d4,d6
		moveq	#1,d4
		rts
; ---------------------------------------------------------------------------

loc_1BE20:
		bsr.s	sub_1BE46
		move.w	d6,d4
		addi.b	#$D,d4
		bset	d4,d6
		moveq	#1,d4
		rts
; ---------------------------------------------------------------------------

loc_1BE2E:
		move.l	d6,d4
		addq.b	#pushing_bit_delta,d4
		btst	d4,status(a0)
		beq.s	loc_1BE54
		cmpi.b	#2,anim(a1)
		beq.s	sub_1BE46
		move.w	#1,anim(a1)
; End of function SolidObjectFull_Offset_1P


; =============== S U B R O U T I N E =======================================


sub_1BE46:
		move.l	d6,d4
		addq.b	#pushing_bit_delta,d4
		bclr	d4,status(a0)
		bclr	#Status_Push,status(a1)

loc_1BE54:
		moveq	#0,d4
		rts
; End of function sub_1BE46

; ---------------------------------------------------------------------------

loc_1BE58:
		tst.w	d3
		bmi.s	loc_1BE64
		cmpi.w	#$10,d3
		blo.s	loc_1BED0
		bra.s	loc_1BE2E
; ---------------------------------------------------------------------------

loc_1BE64:
		btst	#Status_InAir,status(a1)
		bne.s	loc_1BE7A
		tst.w	y_vel(a1)
		beq.s	loc_1BEA2
		bpl.s	loc_1BE8A
		tst.w	d3
		bpl.s	loc_1BE8A
		bra.s	loc_1BE80
; ---------------------------------------------------------------------------

loc_1BE7A:
		move.w	#0,ground_vel(a1)

loc_1BE80:
		sub.w	d3,y_pos(a1)
		move.w	#0,y_vel(a1)

loc_1BE8A:
		tst.b	status_tertiary(a1)
		bpl.s	loc_1BE96
		bset	#5,status_tertiary(a1)

loc_1BE96:
		move.w	d6,d4
		addi.b	#$F,d4
		bset	d4,d6
		moveq	#-2,d4
		rts
; ---------------------------------------------------------------------------

loc_1BEA2:
		btst	#Status_InAir,status(a1)
		bne.s	loc_1BE8A
		move.w	d0,d4
		bpl.s	loc_1BEB0
		neg.w	d4

loc_1BEB0:
		cmpi.w	#$10,d4
		blo.w	loc_1BDC6
		move.l	a0,-(sp)
		movea.l	a1,a0
		jsr	(Kill_Character).l
		movea.l	(sp)+,a0
		move.w	d6,d4
		addi.b	#$F,d4
		bset	d4,d6
		moveq	#-2,d4
		rts
; ---------------------------------------------------------------------------

loc_1BED0:
		subq.w	#4,d3
		moveq	#0,d1
		move.b	width_pixels(a0),d1
		move.w	d1,d2
		add.w	d2,d2
		add.w	x_pos(a1),d1
		sub.w	x_pos(a0),d1
		bmi.s	loc_1BF08
		cmp.w	d2,d1
		bhs.s	loc_1BF08
		sub.w	d3,y_pos(a1)
		subq.w	#1,y_pos(a1)
		tst.w	y_vel(a1)
		bmi.s	loc_1BF08
		bsr.w	RideObject_SetRide
		move.w	d6,d4
		addi.b	#$11,d4
		bset	d4,d6
		moveq	#-1,d4
		rts
; ---------------------------------------------------------------------------

loc_1BF08:
		moveq	#0,d4
		rts

; =============== S U B R O U T I N E =======================================


MvSonicOnPtfm:
		move.w	y_pos(a0),d0
		sub.w	d3,d0
		bra.s	loc_1BF1C
; ---------------------------------------------------------------------------
		move.w	y_pos(a0),d0
		subi.w	#9,d0

loc_1BF1C:
		tst.b	object_control(a1)
		bmi.s	locret_1BF44
		cmpi.b	#6,routine(a1)
		bhs.s	locret_1BF44
		tst.w	(Debug_placement_mode).w
		bne.s	locret_1BF44
		moveq	#0,d1
		move.b	y_radius(a1),d1
		sub.w	d1,d0
		move.w	d0,y_pos(a1)
		sub.w	x_pos(a0),d2
		sub.w	d2,x_pos(a1)

locret_1BF44:
		rts
; End of function MvSonicOnPtfm


; =============== S U B R O U T I N E =======================================


SolidObjSloped2:
		btst	#Status_OnObj,status(a1)
		beq.s	locret_1BF86
		move.w	x_pos(a1),d0
		sub.w	x_pos(a0),d0
		add.w	d1,d0
		lsr.w	#1,d0
		btst	#0,render_flags(a0)
		beq.s	loc_1BF66
		not.w	d0
		add.w	d1,d0

loc_1BF66:
		move.b	(a2,d0.w),d1
		ext.w	d1
		move.w	y_pos(a0),d0
		sub.w	d1,d0
		moveq	#0,d1
		move.b	y_radius(a1),d1
		sub.w	d1,d0
		move.w	d0,y_pos(a1)
		sub.w	x_pos(a0),d2
		sub.w	d2,x_pos(a1)

locret_1BF86:
		rts
; End of function SolidObjSloped2


; =============== S U B R O U T I N E =======================================


SolidObjSloped4:
		btst	#Status_OnObj,status(a1)
		beq.s	locret_1BF86
		move.w	x_pos(a1),d0
		sub.w	x_pos(a0),d0
		add.w	d1,d0
		btst	#0,render_flags(a0)
		beq.s	loc_1BFA6
		not.w	d0
		add.w	d1,d0

loc_1BFA6:
		andi.w	#$FFFE,d0
		bra.s	loc_1BF66
; End of function SolidObjSloped4


; =============== S U B R O U T I N E =======================================


SolidObjectTop:
		lea	(Player_1).w,a1
		moveq	#p1_standing_bit,d6
		movem.l	d1-d4,-(sp)
		bsr.s	SolidObjectTop_1P
		movem.l	(sp)+,d1-d4
		lea	(Player_2).w,a1
		addq.b	#p2_standing_bit-p1_standing_bit,d6
; End of function SolidObjectTop


; =============== S U B R O U T I N E =======================================


SolidObjectTop_1P:
		btst	d6,status(a0)
		beq.w	loc_1C0DC
		move.w	d1,d2
		add.w	d2,d2
		btst	#Status_InAir,status(a1)
		bne.s	loc_1BFE6
		move.w	x_pos(a1),d0
		sub.w	x_pos(a0),d0
		add.w	d1,d0
		bmi.s	loc_1BFE6
		cmp.w	d2,d0
		blo.s	loc_1BFFA

loc_1BFE6:
		bclr	#Status_OnObj,status(a1)
		bset	#Status_InAir,status(a1)
		bclr	d6,status(a0)
		moveq	#0,d4
		rts
; ---------------------------------------------------------------------------

loc_1BFFA:
		move.w	d4,d2
		bsr.w	MvSonicOnPtfm
		moveq	#0,d4
		rts
; End of function SolidObjectTop_1P


; =============== S U B R O U T I N E =======================================


SolidObjectTopSloped2:
		lea	(Player_1).w,a1
		moveq	#p1_standing_bit,d6
		movem.l	d1-d4,-(sp)
		bsr.s	SolidObjectTopSloped2_1P
		movem.l	(sp)+,d1-d4
		lea	(Player_2).w,a1
		addq.b	#p2_standing_bit-p1_standing_bit,d6
; End of function SolidObjectTopSloped2


; =============== S U B R O U T I N E =======================================


SolidObjectTopSloped2_1P:
		btst	d6,status(a0)
		beq.w	SolidObjCheckSloped2
		move.w	d1,d2
		add.w	d2,d2
		btst	#Status_InAir,status(a1)
		bne.s	loc_1C03E
		move.w	x_pos(a1),d0
		sub.w	x_pos(a0),d0
		add.w	d1,d0
		bmi.s	loc_1C03E
		cmp.w	d2,d0
		blo.s	loc_1C052

loc_1C03E:
		bclr	#Status_OnObj,status(a1)
		bset	#Status_InAir,status(a1)
		bclr	d6,status(a0)
		moveq	#0,d4
		rts
; ---------------------------------------------------------------------------

loc_1C052:
		move.w	d4,d2
		bsr.w	SolidObjSloped2
		moveq	#0,d4
		rts
; End of function SolidObjectTopSloped2_1P


; =============== S U B R O U T I N E =======================================


SolidObjectTopSloped:
		lea	(Player_1).w,a1
		moveq	#p1_standing_bit,d6
		movem.l	d1-d4,-(sp)
		bsr.s	SolidObjectTopSloped_1P
		movem.l	(sp)+,d1-d4
		lea	(Player_2).w,a1
		addq.b	#p2_standing_bit-p1_standing_bit,d6
; End of function SolidObjectTopSloped


; =============== S U B R O U T I N E =======================================


SolidObjectTopSloped_1P:
		btst	d6,status(a0)
		bne.s	loc_1C084
		btst	#Status_OnObj,status(a1)
		bne.s	loc_1C0B0
		bra.w	loc_1C0DC
; ---------------------------------------------------------------------------

loc_1C084:
		move.w	d1,d2
		add.w	d2,d2
		btst	#Status_InAir,status(a1)
		bne.s	loc_1C0A0
		move.w	x_pos(a1),d0
		sub.w	x_pos(a0),d0
		add.w	d1,d0
		bmi.s	loc_1C0A0
		cmp.w	d2,d0
		blo.s	loc_1C0B4

loc_1C0A0:
		bclr	#Status_OnObj,status(a1)
		bset	#Status_InAir,status(a1)
		bclr	d6,status(a0)

loc_1C0B0:
		moveq	#0,d4
		rts
; ---------------------------------------------------------------------------

loc_1C0B4:
		move.w	d4,d2
		bsr.w	MvSonicOnPtfm
		moveq	#0,d4
		rts
; End of function SolidObjectTopSloped_1P


; =============== S U B R O U T I N E =======================================


sub_1C0BE:
		tst.w	y_vel(a1)
		bmi.w	locret_1C17A
		move.w	x_pos(a1),d0
		sub.w	x_pos(a0),d0
		add.w	d1,d0
		bmi.w	locret_1C17A
		cmp.w	d2,d0
		bhs.w	locret_1C17A
		bra.s	loc_1C0FA
; ---------------------------------------------------------------------------

loc_1C0DC:
		tst.w	y_vel(a1)
		bmi.w	locret_1C17A
		move.w	x_pos(a1),d0
		sub.w	x_pos(a0),d0
		add.w	d1,d0
		bmi.w	locret_1C17A
		add.w	d1,d1
		cmp.w	d1,d0
		bhs.w	locret_1C17A

loc_1C0FA:
		move.w	y_pos(a0),d0
		sub.w	d3,d0

loc_1C100:
		move.w	y_pos(a1),d2
		move.b	y_radius(a1),d1
		ext.w	d1
		add.w	d2,d1
		addq.w	#4,d1
		sub.w	d1,d0
		bhi.w	locret_1C17A
		cmpi.w	#-$10,d0
		blo.w	locret_1C17A
		tst.b	object_control(a1)
		bmi.w	locret_1C17A
		cmpi.b	#6,routine(a1)
		bhs.w	locret_1C17A
		add.w	d0,d2
		addq.w	#3,d2
		move.w	d2,y_pos(a1)
; End of function sub_1C0BE


; =============== S U B R O U T I N E =======================================


RideObject_SetRide:
		btst	#Status_OnObj,status(a1)
		beq.s	loc_1C146
		movea.w	interact(a1),a3
		bclr	d6,status(a3)

loc_1C146:
		move.w	a0,interact(a1)
		move.b	#0,angle(a1)
		move.w	#0,y_vel(a1)
		move.w	x_vel(a1),ground_vel(a1)
		bset	#Status_OnObj,status(a1)
		bset	d6,status(a0)
		bclr	#Status_InAir,status(a1)
		beq.s	locret_1C17A
		move.l	a0,-(sp)
		movea.l	a1,a0
		jsr	(Player_TouchFloor).l
		movea.l	(sp)+,a0

locret_1C17A:
		rts
; End of function RideObject_SetRide

; ---------------------------------------------------------------------------

SolidObjCheckSloped2:
		tst.w	y_vel(a1)
		bmi.w	locret_1C17A
		move.w	x_pos(a1),d0
		sub.w	x_pos(a0),d0
		add.w	d1,d0
		bmi.s	locret_1C17A
		add.w	d1,d1
		cmp.w	d1,d0
		bhs.s	locret_1C17A
		btst	#0,render_flags(a0)
		beq.s	loc_1C1A2
		not.w	d0
		add.w	d1,d0

loc_1C1A2:
		lsr.w	#1,d0
		move.b	(a2,d0.w),d3
		ext.w	d3
		move.w	y_pos(a0),d0
		sub.w	d3,d0
		bra.w	loc_1C100

; =============== S U B R O U T I N E =======================================


CheckPlayerReleaseFromObj:
		lea	(Player_1).w,a1
		btst	#p1_standing_bit,status(a0)
		beq.s	loc_1C1E2
		jsr	(SonicOnObjHitFloor).l
		tst.w	d1
		beq.s	loc_1C1CC
		bpl.s	loc_1C1E2

loc_1C1CC:
		lea	(Player_1).w,a1
		bclr	#Status_OnObj,status(a1)
		bset	#Status_InAir,status(a1)
		bclr	#p1_standing_bit,status(a0)

loc_1C1E2:
		lea	(Player_2).w,a1
		btst	#p2_standing_bit,status(a0)
		beq.s	loc_1C210
		jsr	(SonicOnObjHitFloor).l
		tst.w	d1
		beq.s	loc_1C1FA
		bpl.s	loc_1C210

loc_1C1FA:
		lea	(Player_2).w,a1
		bclr	#Status_OnObj,status(a1)
		bset	#Status_InAir,status(a1)
		bclr	#p2_standing_bit,status(a0)

loc_1C210:
		moveq	#0,d4
		rts
; End of function CheckPlayerReleaseFromObj

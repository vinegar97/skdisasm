word_3863A:
		dc.w $840
		dc.w $120
		dc.l byte_38604
		dc.w $1540
		dc.w $620
		dc.l byte_3860C
		dc.w $1740
		dc.w $3A0
		dc.l byte_3860C
		dc.w $1CC0
		dc.w $620
		dc.l byte_38604
		dc.w $1FC0
		dc.w $2A0
		dc.l byte_3861A
		dc.w $24C0
		dc.w $220
		dc.l byte_38626
		dc.w $26C0
		dc.w $120
		dc.l byte_38604
		dc.w $3040
		dc.w $620
		dc.l byte_3860C
; ---------------------------------------------------------------------------

Obj_HCZTwistingLoop:
		move.b	subtype(a0),d0
		andi.w	#$7F,d0
		lsl.w	#3,d0
		lea	word_3863A(pc,d0.w),a1
		move.w	(a1)+,$30(a0)
		move.w	(a1)+,$32(a0)
		move.l	(a1)+,$40(a0)
		move.l	#loc_3869A,(a0)

loc_3869A:
		lea	(Player_1).w,a1
		lea	$34(a0),a4
		bsr.s	++ ;sub_386C0
		lea	(Player_2).w,a1
		lea	$3A(a0),a4
		bsr.s	++ ;sub_386C0
		move.b	$34(a0),d0
		add.b	$3A(a0),d0
		beq.s	+ ;loc_386BA
		rts
; ---------------------------------------------------------------------------

+ ;loc_386BA:
		jmp	(Delete_Sprite_If_Not_In_Range).l

; =============== S U B R O U T I N E =======================================


+ ;sub_386C0:
		moveq	#0,d0
		move.b	(a4),d0
		move.w	off_386F0(pc,d0.w),d0
		jsr	off_386F0(pc,d0.w)
		tst.b	(a4)
		beq.s	locret_386EE
		bsr.w	sub_38806
		moveq	#0,d0
		move.w	2(a4),d0
		divu.w	#$60,d0
		movea.l	$40(a0),a2
		move.b	(a2,d0.w),(a4)
		bne.s	locret_386EE
		move.b	#0,object_control(a1)

locret_386EE:
		rts
; End of function sub_386C0

; ---------------------------------------------------------------------------
off_386F0:
		dc.w loc_38700-off_386F0
		dc.w loc_3885A-off_386F0
		dc.w loc_388B4-off_386F0
		dc.w loc_388EC-off_386F0
		dc.w loc_3891C-off_386F0
		dc.w loc_3895C-off_386F0
		dc.w loc_3898C-off_386F0
		dc.w loc_389BC-off_386F0
; ---------------------------------------------------------------------------

loc_38700:
		tst.w	(Debug_placement_mode).w
		bne.w	locret_38794
		tst.b	subtype(a0)
		bmi.w	+++ ;loc_38796
		move.w	x_pos(a1),d0
		sub.w	x_pos(a0),d0
		addi.w	#8,d0
		cmpi.w	#$10,d0
		bhs.s	locret_38794
		move.w	y_pos(a1),d1
		sub.w	y_pos(a0),d1
		cmpi.w	#$30,d1
		bhs.s	locret_38794
		tst.b	object_control(a1)
		bne.s	locret_38794
		btst	#0,status(a0)
		beq.s	+ ;loc_38750
		tst.w	ground_vel(a1)
		bpl.s	locret_38794
		tst.w	x_vel(a1)
		bpl.s	locret_38794
		neg.w	ground_vel(a1)
		bra.s	++ ;loc_38756
; ---------------------------------------------------------------------------

+ ;loc_38750:
		tst.w	ground_vel(a1)
		bmi.s	locret_38794

+ ;loc_38756:
		addq.b	#2,(a4)
		move.b	#1,object_control(a1)
		move.b	#2,anim(a1)
		move.b	#$E,y_radius(a1)
		move.b	#7,x_radius(a1)
		move.b	#2,anim(a1)
		bset	#Status_Roll,status(a1)
		bclr	#Status_Push,status(a1)
		move.b	#$28,angle(a1)
		move.w	y_pos(a1),d1
		sub.w	$32(a0),d1
		move.w	d1,2(a4)

locret_38794:
		rts
; ---------------------------------------------------------------------------

+ ;loc_38796:
		move.w	x_pos(a1),d0
		sub.w	x_pos(a0),d0
		addi.w	#$10,d0
		cmpi.w	#$20,d0
		bhs.s	locret_38794
		move.w	y_pos(a1),d1
		sub.w	y_pos(a0),d1
		addi.w	#$10,d1
		cmpi.w	#$10,d1
		bhs.s	locret_38794
		tst.b	object_control(a1)
		bne.s	locret_38794
		tst.w	ground_vel(a1)
		bpl.s	locret_38794
		addq.b	#2,(a4)
		move.b	#1,object_control(a1)
		move.b	#2,anim(a1)
		move.b	#$E,y_radius(a1)
		move.b	#7,x_radius(a1)
		move.b	#2,anim(a1)
		bset	#Status_Roll,status(a1)
		bclr	#Status_Push,status(a1)
		move.b	#$28,angle(a1)
		move.w	y_pos(a1),d1
		sub.w	$32(a0),d1
		move.w	d1,2(a4)
		rts

; =============== S U B R O U T I N E =======================================


sub_38806:
		move.b	angle(a1),d0
		jsr	(GetSineCosine).l
		muls.w	ground_vel(a1),d1
		asr.l	#8,d1
		move.w	d1,x_vel(a1)
		muls.w	ground_vel(a1),d0
		asr.l	#8,d0
		move.w	d0,y_vel(a1)
		move.b	angle(a1),d0
		jsr	(GetSineCosine).l
		muls.w	#$50,d0
		asr.l	#8,d0
		tst.w	ground_vel(a1)
		bmi.s	++ ;loc_3884E
		tst.w	d0
		bpl.s	+ ;loc_38840
		asr.l	#2,d0

+ ;loc_38840:
		cmpi.w	#$1800,ground_vel(a1)
		bge.s	locret_38858
		add.w	d0,ground_vel(a1)
		rts
; ---------------------------------------------------------------------------

+ ;loc_3884E:
		tst.w	d0
		bmi.s	+ ;loc_38854
		asr.l	#2,d0

+ ;loc_38854:
		add.w	d0,ground_vel(a1)

locret_38858:
		rts
; End of function sub_38806

; ---------------------------------------------------------------------------

loc_3885A:
		move.w	2(a4),d0
		subi.w	#$16,d0
		bcc.s	++ ;loc_38880
		tst.w	ground_vel(a1)
		bpl.s	+ ;loc_3887E
		move.b	#0,(a4)
		move.b	#0,object_control(a1)
		move.b	#$70,angle(a1)
		bra.w	sub_38806
; ---------------------------------------------------------------------------

+ ;loc_3887E:
		moveq	#0,d0

+ ;loc_38880:
		mulu.w	#$DD,d0
		lsr.w	#8,d0
		jsr	(GetSineCosine).l
		muls.w	#-$2800,d0
		swap	d0
		add.w	$30(a0),d0
		move.w	d0,x_pos(a1)
		move.w	2(a4),d0
		add.w	$32(a0),d0
		move.w	d0,y_pos(a1)
		move.w	y_vel(a1),d0
		ext.l	d0
		asl.l	#8,d0
		add.l	d0,2(a4)
		rts
; ---------------------------------------------------------------------------

loc_388B4:
		move.w	2(a4),d0
		mulu.w	#$AA,d0
		asr.w	#8,d0
		jsr	(GetSineCosine).l
		muls.w	#-$2800,d0
		swap	d0
		add.w	$30(a0),d0
		move.w	d0,x_pos(a1)
		move.w	2(a4),d0
		add.w	$32(a0),d0
		move.w	d0,y_pos(a1)
		move.w	y_vel(a1),d0
		ext.l	d0
		asl.l	#8,d0
		add.l	d0,2(a4)
		rts
; ---------------------------------------------------------------------------

loc_388EC:
		move.w	2(a4),d0
		subi.w	#$C0,d0
		muls.w	#$AA,d0
		asr.l	#8,d0
		add.w	$30(a0),d0
		move.w	d0,x_pos(a1)
		move.w	2(a4),d0
		add.w	$32(a0),d0
		move.w	d0,y_pos(a1)
		move.w	y_vel(a1),d0
		ext.l	d0
		asl.l	#8,d0
		add.l	d0,2(a4)
		rts
; ---------------------------------------------------------------------------

loc_3891C:
		move.w	2(a4),d0
		subi.w	#$180,d0
		mulu.w	#$AA,d0
		asr.w	#8,d0
		jsr	(GetSineCosine).l
		muls.w	#-$2800,d0
		swap	d0
		addi.w	#$100,d0
		add.w	$30(a0),d0
		move.w	d0,x_pos(a1)
		move.w	2(a4),d0
		add.w	$32(a0),d0
		move.w	d0,y_pos(a1)
		move.w	y_vel(a1),d0
		ext.l	d0
		asl.l	#8,d0
		add.l	d0,2(a4)
		rts
; ---------------------------------------------------------------------------

loc_3895C:
		move.w	2(a4),d0
		subi.w	#$240,d0
		muls.w	#$AA,d0
		asr.l	#8,d0
		add.w	$30(a0),d0
		move.w	d0,x_pos(a1)
		move.w	2(a4),d0
		add.w	$32(a0),d0
		move.w	d0,y_pos(a1)
		move.w	y_vel(a1),d0
		ext.l	d0
		asl.l	#8,d0
		add.l	d0,2(a4)
		rts
; ---------------------------------------------------------------------------

loc_3898C:
		move.w	2(a4),d0
		subi.w	#$240,d0
		muls.w	#$AA,d0
		asr.l	#8,d0
		add.w	$30(a0),d0
		move.w	d0,x_pos(a1)
		move.w	2(a4),d0
		add.w	$32(a0),d0
		move.w	d0,y_pos(a1)
		move.w	y_vel(a1),d0
		ext.l	d0
		asl.l	#8,d0
		add.l	d0,2(a4)
		rts
; ---------------------------------------------------------------------------

loc_389BC:
		move.w	2(a4),d0
		subi.w	#$540,d0
		muls.w	#$AA,d0
		asr.l	#8,d0
		add.w	$30(a0),d0
		move.w	d0,x_pos(a1)
		move.w	2(a4),d0
		add.w	$32(a0),d0
		move.w	d0,y_pos(a1)
		move.w	y_vel(a1),d0
		ext.l	d0
		asl.l	#8,d0
		add.l	d0,2(a4)
		rts

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
		move.l	#loc_34C54,(a0)

loc_34C54:
		lea	(Player_1).w,a1
		lea	$40(a0),a4
		move.w	(Ctrl_1_logical).w,d5
		moveq	#p1_standing_bit,d6
		bsr.w	sub_34EEC
		lea	(Player_2).w,a1
		lea	$42(a0),a4
		move.w	(Ctrl_2_logical).w,d5
		moveq	#p2_standing_bit,d6
		bsr.w	sub_34EEC
		tst.b	subtype(a0)
		bne.w	loc_34D62
		btst	#1,status(a0)
		beq.w	loc_34D0E
		cmpi.w	#$200,y_vel(a0)
		bge.s	+ ;loc_34C98
		addi.w	#8,y_vel(a0)

+ ;loc_34C98:
		jsr	(MoveSprite2).l
		subi.w	#$13,y_pos(a0)
		move.l	a1,-(sp)
		jsr	(sub_3526A).l
		movea.l	(sp)+,a1
		addi.w	#$13,y_pos(a0)
		tst.b	$2D(a0)
		beq.s	+ ;loc_34CD0
		move.w	#0,y_vel(a0)
		move.w	#0,x_vel(a0)
		bclr	#1,status(a0)
		bra.w	loc_34D62
; ---------------------------------------------------------------------------

+ ;loc_34CD0:
		btst	#1,status(a0)
		bne.w	loc_34D62
		move.w	x_vel(a0),d0
		bpl.s	+ ;loc_34CE2
		neg.w	d0

+ ;loc_34CE2:
		cmpi.w	#$40,d0
		blo.s	loc_34D62
		move.w	#$800,d1
		cmpi.w	#$100,d0
		blo.s	+ ;loc_34CF6
		move.w	#$C00,d1

+ ;loc_34CF6:
		tst.w	x_vel(a0)
		bpl.s	+ ;loc_34CFE
		neg.w	d1

+ ;loc_34CFE:
		move.w	d1,x_vel(a0)
		move.w	d1,ground_vel(a0)
		move.b	#1,$34(a0)
		bra.s	loc_34D62
; ---------------------------------------------------------------------------

loc_34D0E:
		tst.b	$35(a0)
		beq.s	+ ;loc_34D1E
		bsr.w	sub_35868
		addq.w	#4,$24(a0)
		bra.s	loc_34D62
; ---------------------------------------------------------------------------

+ ;loc_34D1E:
		move.b	angle(a0),d0
		jsr	(GetSineCosine).l
		muls.w	ground_vel(a0),d1
		asr.l	#8,d1
		move.w	d1,x_vel(a0)
		muls.w	ground_vel(a0),d0
		asr.l	#8,d0
		move.w	d0,y_vel(a0)
		bsr.s	sub_34DBC
		jsr	(MoveSprite2).l
		tst.b	$2D(a0)
		bne.s	+ ;loc_34D4E
		bsr.w	sub_34E6E

+ ;loc_34D4E:
		addq.w	#4,$24(a0)
		tst.w	ground_vel(a0)
		bne.s	+ ;loc_34D5E
		move.b	#0,$34(a0)

+ ;loc_34D5E:
		bsr.w	sub_35666

loc_34D62:
		lea	(Player_1).w,a1
		lea	$40(a0),a4
		moveq	#p1_standing_bit,d6
		bsr.w	sub_35202
		lea	(Player_2).w,a1
		lea	$42(a0),a4
		moveq	#p2_standing_bit,d6
		bsr.w	sub_35202
		move.w	$24(a0),d0
		asr.w	#3,d0
		andi.w	#1,d0
		move.b	d0,mapping_frame(a0)
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------

loc_34D92:
		jsr	(MoveSprite).l
		addq.w	#4,$24(a0)
		move.w	$24(a0),d0
		asr.w	#3,d0
		andi.w	#1,d0
		move.b	d0,mapping_frame(a0)
		tst.b	render_flags(a0)
		bmi.s	+ ;loc_34DB6
		move.w	#$7F00,x_pos(a0)

+ ;loc_34DB6:
		jmp	(Sprite_OnScreen_Test).l

; =============== S U B R O U T I N E =======================================


sub_34DBC:
		move.b	#$40,d1
		tst.w	ground_vel(a0)
		beq.s	locret_34E36
		bmi.s	+ ;loc_34DCA
		neg.w	d1

+ ;loc_34DCA:
		move.b	angle(a0),d0
		add.b	d1,d0
		move.w	d0,-(sp)
		move.b	#$13,y_radius(a0)
		move.b	#$18,x_radius(a0)
		subi.w	#$C,y_pos(a0)
		jsr	(sub_F6B4).l
		addi.w	#$C,y_pos(a0)
		move.w	(sp)+,d0
		tst.w	d1
		bpl.s	locret_34E36
		asl.w	#8,d1
		addi.b	#$20,d0
		andi.b	#$C0,d0
		beq.s	+++ ;loc_34E68
		cmpi.b	#$40,d0
		beq.s	++ ;loc_34E3E
		cmpi.b	#$80,d0
		beq.s	+ ;loc_34E38
		addi.b	#$30,d3
		cmpi.b	#$60,d3
		blo.s	locret_34E36
		add.w	d1,x_vel(a0)
		move.w	#0,y_vel(a0)
		move.w	#0,ground_vel(a0)
		btst	#0,status(a0)
		bne.s	locret_34E36
		bset	#5,status(a0)

locret_34E36:
		rts
; ---------------------------------------------------------------------------

+ ;loc_34E38:
		sub.w	d1,y_vel(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_34E3E:
		addi.b	#$30,d3
		cmpi.b	#$60,d3
		blo.s	locret_34E36
		sub.w	d1,x_vel(a0)
		move.w	#0,y_vel(a0)
		move.w	#0,ground_vel(a0)
		btst	#0,status(a0)
		beq.s	locret_34E36
		bset	#5,status(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_34E68:
		add.w	d1,y_vel(a0)
		rts
; End of function sub_34DBC


; =============== S U B R O U T I N E =======================================


sub_34E6E:
		move.b	#$C,y_radius(a0)
		move.b	#$A,x_radius(a0)
		moveq	#3,d0
		move.b	d0,(Primary_Angle).w
		move.b	d0,(Secondary_Angle).w
		jsr	(Sonic_CheckFloor).l
		tst.b	d3
		bpl.s	+ ;loc_34E9A
		cmpi.b	#-$1E,d3
		bhs.s	++ ;loc_34EA4
		move.b	#-$1E,d3
		bra.s	++ ;loc_34EA4
; ---------------------------------------------------------------------------

+ ;loc_34E9A:
		cmpi.b	#$1E,d3
		bls.s	+ ;loc_34EA4
		move.b	#$1E,d3

+ ;loc_34EA4:
		move.b	d3,angle(a0)
		tst.w	d1
		beq.s	locret_34EB8
		bpl.s	+ ;loc_34EBA
		cmpi.w	#-$E,d1
		blt.s	locret_34EB8
		add.w	d1,y_pos(a0)

locret_34EB8:
		rts
; ---------------------------------------------------------------------------

+ ;loc_34EBA:
		move.b	x_vel(a0),d0
		bpl.s	+ ;loc_34EC2
		neg.b	d0

+ ;loc_34EC2:
		addq.b	#4,d0
		cmpi.b	#$E,d0
		blo.s	+ ;loc_34ECE
		move.b	#$E,d0

+ ;loc_34ECE:
		cmp.b	d0,d1
		bgt.s	+ ;loc_34ED8
		add.w	d1,y_pos(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_34ED8:
		bset	#1,status(a0)
		bclr	#5,status(a0)
		move.b	#0,$34(a0)
		rts
; End of function sub_34E6E


; =============== S U B R O U T I N E =======================================


sub_34EEC:
		moveq	#0,d0
		move.b	(a4),d0
		move.w	off_34EF8(pc,d0.w),d0
		jmp	off_34EF8(pc,d0.w)
; End of function sub_34EEC

; ---------------------------------------------------------------------------
off_34EF8:
		dc.w loc_34F04-off_34EF8
		dc.w loc_34F4C-off_34EF8
		dc.w loc_34FBC-off_34EF8
		dc.w loc_34F00-off_34EF8
; ---------------------------------------------------------------------------

loc_34F00:
		clr.w	(a4)
		rts
; ---------------------------------------------------------------------------

loc_34F04:
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
		bne.s	+ ;loc_34F2A
		rts
; ---------------------------------------------------------------------------

+ ;loc_34F2A:
		tst.b	status_tertiary(a1)
		bmi.s	locret_34F4A
		addq.b	#2,(a4)
		move.b	#0,1(a4)
		move.w	x_pos(a0),d0
		sub.w	x_pos(a1),d0
		bcc.s	+ ;loc_34F48
		move.b	#1,1(a4)

+ ;loc_34F48:
		bra.s	+ ;loc_34F6A
; ---------------------------------------------------------------------------

locret_34F4A:
		rts
; ---------------------------------------------------------------------------

loc_34F4C:
		moveq	#0,d1
		move.b	width_pixels(a0),d1
		addi.w	#$B,d1
		moveq	#0,d2
		move.b	height_pixels(a0),d2
		move.w	d2,d3
		addq.w	#1,d3
		move.w	x_pos(a0),d4
		jsr	(SolidObjectFull_1P).l

+ ;loc_34F6A:
		btst	d6,status(a0)
		bne.s	+ ;loc_34F72
		clr.b	(a4)

+ ;loc_34F72:
		move.w	x_pos(a1),d0
		sub.w	x_pos(a0),d0
		tst.b	1(a4)
		beq.s	+ ;loc_34F84
		addi.w	#$F,d0

+ ;loc_34F84:
		cmpi.w	#$10,d0
		bhs.s	locret_34FBA
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

locret_34FBA:
		rts
; ---------------------------------------------------------------------------

loc_34FBC:
		tst.b	render_flags(a1)
		bpl.s	+ ;loc_3500A
		cmpi.b	#4,routine(a1)
		bhs.w	+ ;loc_3500A
		tst.w	(Debug_placement_mode).w
		bne.s	+ ;loc_3500A
		move.w	d5,d0
		andi.w	#button_A_mask|button_B_mask|button_C_mask,d0
		beq.w	++ ;loc_35028
		move.w	#-$680,y_vel(a1)
		move.b	#1,jumping(a1)
		move.b	#$E,y_radius(a1)
		move.b	#7,x_radius(a1)
		move.b	#2,anim(a1)
		bset	#Status_Roll,status(a1)
		move.w	#sfx_Jump,d0
		jsr	(Play_SFX).l

+ ;loc_3500A:
		bclr	#0,object_control(a1)
		move.b	#0,status_tertiary(a1)
		bset	#Status_InAir,status(a1)
		clr.b	(a4)
		cmpa.w	#Player_1,a1
		beq.w	sub_3519A

locret_35026:
		rts
; ---------------------------------------------------------------------------

+ ;loc_35028:
		move.w	d5,d0
		andi.w	#$C00,d0
		bne.s	+ ;loc_35048
		tst.w	x_vel(a0)
		beq.s	+ ;loc_35048
		bclr	#Status_Facing,status(a1)
		tst.w	x_vel(a0)
		bpl.s	+ ;loc_35048
		bset	#Status_Facing,status(a1)

+ ;loc_35048:
		move.b	default_y_radius(a1),d0
		addi.b	#$18,d0
		move.b	d0,y_radius(a1)
		cmpa.w	#Player_2,a1
		bne.s	+ ;loc_3505C
		rts
; ---------------------------------------------------------------------------

+ ;loc_3505C:
		move.l	a0,-(sp)
		movea.l	a1,a0
		move.w	d5,d3
		cmpi.b	#$10,anim(a0)
		beq.s	+ ;loc_35070
		jsr	(sub_35504).l

+ ;loc_35070:
		jsr	(Player_LevelBound).l
		jsr	(MoveSprite2).l
		movea.l	(sp)+,a0
		cmpi.b	#$10,anim(a1)
		bne.s	+ ;loc_350A6
		move.w	x_vel(a1),x_vel(a0)
		move.w	y_vel(a1),y_vel(a0)
		addi.w	#$38,y_vel(a1)
		bset	#1,status(a0)
		move.b	#0,$34(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_350A6:
		bclr	#6,status_tertiary(a1)
		beq.s	+ ;loc_350BA
		move.w	#0,ground_vel(a0)
		move.w	#0,x_vel(a0)

+ ;loc_350BA:
		bclr	#5,status_tertiary(a1)
		beq.s	+ ;loc_350C8
		move.w	#0,y_vel(a0)

+ ;loc_350C8:
		move.w	x_vel(a0),x_vel(a1)
		move.w	y_vel(a0),y_vel(a1)
		move.w	top_solid_bit(a1),top_solid_bit(a0)
		tst.b	$34(a0)
		bne.w	locret_35026
		move.w	x_pos(a1),d0
		sub.w	x_pos(a0),d0
		beq.w	loc_35170
		bcc.w	+++ ;loc_35130
		cmpi.w	#-$200,x_vel(a0)
		ble.s	+ ;loc_3510A
		add.w	d0,x_vel(a0)
		add.w	d0,x_vel(a0)
		add.w	d0,x_vel(a0)
		add.w	d0,x_vel(a0)

+ ;loc_3510A:
		add.w	d0,$24(a0)
		move.w	x_vel(a0),d0
		bpl.s	+ ;loc_35128
		asr.w	#4,d0
		subi.w	#8,y_vel(a0)
		cmpi.w	#-$100,y_vel(a0)
		ble.s	+ ;loc_35128
		add.w	d0,y_vel(a0)

+ ;loc_35128:
		bset	#1,status(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_35130:
		cmpi.w	#$200,x_vel(a0)
		bge.s	+ ;loc_35148
		add.w	d0,x_vel(a0)
		add.w	d0,x_vel(a0)
		add.w	d0,x_vel(a0)
		add.w	d0,x_vel(a0)

+ ;loc_35148:
		add.w	d0,$24(a0)
		move.w	x_vel(a0),d0
		bmi.s	+ ;loc_35168
		neg.w	d0
		asr.w	#4,d0
		subi.w	#8,y_vel(a0)
		cmpi.w	#-$100,y_vel(a0)
		ble.s	+ ;loc_35168
		add.w	d0,y_vel(a0)

+ ;loc_35168:
		bset	#1,status(a0)
		rts
; ---------------------------------------------------------------------------

loc_35170:
		moveq	#1,d0
		tst.w	x_vel(a0)
		beq.s	++ ;loc_35180
		bmi.s	+ ;loc_3517C
		neg.w	d0

+ ;loc_3517C:
		add.w	d0,x_vel(a0)

+ ;loc_35180:
		add.w	d0,$24(a0)
		tst.w	y_vel(a0)
		bpl.s	locret_3518E
		clr.w	y_vel(a0)

locret_3518E:
		rts
; ---------------------------------------------------------------------------
		clr.w	x_vel(a0)
		clr.w	y_vel(a0)
		rts

; =============== S U B R O U T I N E =======================================


sub_3519A:
		move.l	#loc_34D92,(a0)
		lea	(Player_1).w,a2
		cmpi.b	#4,$40(a0)
		bne.s	+ ;loc_351BE
		bclr	#0,object_control(a2)
		move.b	#0,status_tertiary(a2)
		bset	#Status_InAir,status(a2)

+ ;loc_351BE:
		tst.b	$40(a0)
		beq.s	+ ;loc_351CA
		bclr	#Status_OnObj,status(a2)

+ ;loc_351CA:
		lea	(Player_2).w,a2
		cmpi.b	#4,$42(a0)
		bne.s	+ ;loc_351E8
		bclr	#0,object_control(a2)
		move.b	#0,status_tertiary(a2)
		bset	#Status_InAir,status(a2)

+ ;loc_351E8:
		tst.b	$42(a0)
		beq.s	+ ;loc_351F4
		bclr	#Status_OnObj,status(a2)

+ ;loc_351F4:
		move.b	#6,$40(a0)
		move.b	#6,$42(a0)
		rts
; End of function sub_3519A


; =============== S U B R O U T I N E =======================================


sub_35202:
		btst	#Status_OnObj,status(a1)
		bne.s	+ ;loc_35232
		cmpi.b	#4,(a4)
		blo.s	locret_35230
		move.w	y_pos(a0),d0
		subi.w	#$C,d0
		moveq	#0,d1
		move.b	default_y_radius(a1),d1
		sub.w	d1,d0
		move.w	d0,y_pos(a1)
		move.w	x_pos(a0),x_pos(a1)
		move.b	#0,$2D(a0)

locret_35230:
		rts
; ---------------------------------------------------------------------------

+ ;loc_35232:
		cmpi.b	#4,(a4)
		blo.s	locret_35268
		movea.w	interact(a1),a2
		cmpi.l	#loc_32AAE,(a2)
		bne.s	+ ;loc_35248
		bsr.w	sub_3519A

+ ;loc_35248:
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a1),d0
		moveq	#0,d1
		move.b	default_y_radius(a1),d1
		add.w	d1,d0
		addi.w	#$D,d0
		move.w	d0,y_pos(a0)
		move.b	#1,$2D(a0)

locret_35268:
		rts
; End of function sub_35202


; =============== S U B R O U T I N E =======================================


sub_3526A:
		move.l	(Primary_collision_addr).w,(Collision_addr).w
		cmpi.b	#$C,top_solid_bit(a0)
		beq.s	+ ;loc_3527E
		move.l	(Secondary_collision_addr).w,(Collision_addr).w

+ ;loc_3527E:
		move.b	lrb_solid_bit(a0),d5
		move.w	x_vel(a0),d1
		move.w	y_vel(a0),d2
		jsr	(GetArcTan).l
		subi.b	#$20,d0
		andi.b	#$C0,d0
		cmpi.b	#$40,d0
		beq.w	loc_3536E
		cmpi.b	#$80,d0
		beq.w	loc_353F8
		cmpi.b	#-$40,d0
		beq.w	loc_3547A
		move.b	#$C,y_radius(a0)
		move.b	#$18,x_radius(a0)
		jsr	(sub_FD32).l
		tst.w	d1
		bpl.s	+ ;loc_352D0
		sub.w	d1,x_pos(a0)
		move.w	#0,x_vel(a0)

+ ;loc_352D0:
		jsr	(sub_FA1A).l
		tst.w	d1
		bpl.s	+ ;loc_352E4
		add.w	d1,x_pos(a0)
		move.w	#0,x_vel(a0)

+ ;loc_352E4:
		move.b	#$1F,y_radius(a0)
		move.b	#$A,x_radius(a0)
		jsr	(Sonic_CheckFloor).l
		tst.w	d1
		bpl.s	locret_3536C
		move.b	y_vel(a0),d2
		addq.b	#8,d2
		neg.b	d2
		cmp.b	d2,d1
		bge.s	+ ;loc_3530A
		cmp.b	d2,d0
		blt.s	locret_3536C

+ ;loc_3530A:
		add.w	d1,y_pos(a0)
		move.b	d3,angle(a0)
		bclr	#1,status(a0)
		move.b	#0,$2D(a0)
		move.b	d3,d0
		addi.b	#$20,d0
		andi.b	#$40,d0
		bne.s	++ ;loc_3534A
		move.b	d3,d0
		addi.b	#$10,d0
		andi.b	#$20,d0
		beq.s	+ ;loc_3533C
		asr	y_vel(a0)
		bra.s	loc_3535E
; ---------------------------------------------------------------------------

+ ;loc_3533C:
		move.w	#0,y_vel(a0)
		move.w	x_vel(a0),ground_vel(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_3534A:
		move.w	#0,x_vel(a0)
		cmpi.w	#$FC0,y_vel(a0)
		ble.s	loc_3535E
		move.w	#$FC0,y_vel(a0)

loc_3535E:
		move.w	y_vel(a0),ground_vel(a0)
		tst.b	d3
		bpl.s	locret_3536C
		neg.w	ground_vel(a0)

locret_3536C:
		rts
; ---------------------------------------------------------------------------

loc_3536E:
		move.b	#$C,y_radius(a0)
		move.b	#$18,x_radius(a0)
		jsr	(sub_FD32).l
		tst.w	d1
		bpl.s	+ ;loc_3539E
		sub.w	d1,x_pos(a0)
		addi.b	#$30,d3
		cmpi.b	#$60,d3
		blo.s	+ ;loc_3539E
		move.w	#0,x_vel(a0)
		move.w	y_vel(a0),ground_vel(a0)

+ ;loc_3539E:
		move.b	#$1F,y_radius(a0)
		move.b	#$A,x_radius(a0)
		jsr	(sub_FB5A).l
		tst.w	d1
		bpl.s	+ ;loc_353C6
		sub.w	d1,y_pos(a0)
		tst.w	y_vel(a0)
		bpl.s	locret_353C4
		move.w	#0,y_vel(a0)

locret_353C4:
		rts
; ---------------------------------------------------------------------------

+ ;loc_353C6:
		tst.w	y_vel(a0)
		bmi.s	locret_353F6
		jsr	(Sonic_CheckFloor).l
		tst.w	d1
		bpl.s	locret_353F6
		add.w	d1,y_pos(a0)
		move.b	d3,angle(a0)
		bclr	#1,status(a0)
		move.b	#0,$2D(a0)
		move.w	#0,y_vel(a0)
		move.w	x_vel(a0),ground_vel(a0)

locret_353F6:
		rts
; ---------------------------------------------------------------------------

loc_353F8:
		move.b	#$C,y_radius(a0)
		move.b	#$18,x_radius(a0)
		jsr	(sub_FD32).l
		tst.w	d1
		bpl.s	+ ;loc_35418
		sub.w	d1,x_pos(a0)
		move.w	#0,x_vel(a0)

+ ;loc_35418:
		jsr	(sub_FA1A).l
		tst.w	d1
		bpl.s	+ ;loc_3542C
		add.w	d1,x_pos(a0)
		move.w	#0,x_vel(a0)

+ ;loc_3542C:
		move.b	#$1F,y_radius(a0)
		move.b	#$A,x_radius(a0)
		jsr	(sub_FB5A).l
		tst.w	d1
		bpl.s	locret_35478
		sub.w	d1,y_pos(a0)
		move.b	d3,d0
		addi.b	#$20,d0
		andi.b	#$40,d0
		bne.s	+ ;loc_3545A
		move.w	#0,y_vel(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_3545A:
		move.b	d3,angle(a0)
		bclr	#1,status(a0)
		move.b	#0,$2D(a0)
		move.w	y_vel(a0),ground_vel(a0)
		tst.b	d3
		bpl.s	locret_35478
		neg.w	ground_vel(a0)

locret_35478:
		rts
; ---------------------------------------------------------------------------

loc_3547A:
		move.b	#$C,y_radius(a0)
		move.b	#$18,x_radius(a0)
		jsr	(sub_FA1A).l
		tst.w	d1
		bpl.s	+ ;loc_354AA
		add.w	d1,x_pos(a0)
		addi.b	#$30,d3
		cmpi.b	#$60,d3
		blo.s	+ ;loc_354AA
		move.w	#0,x_vel(a0)
		move.w	y_vel(a0),ground_vel(a0)

+ ;loc_354AA:
		move.b	#$1F,y_radius(a0)
		move.b	#$A,x_radius(a0)
		jsr	(sub_FB5A).l
		tst.w	d1
		bpl.s	+ ;loc_354D2
		sub.w	d1,y_pos(a0)
		tst.w	y_vel(a0)
		bpl.s	locret_354D0
		move.w	#0,y_vel(a0)

locret_354D0:
		rts
; ---------------------------------------------------------------------------

+ ;loc_354D2:
		tst.w	y_vel(a0)
		bmi.s	locret_35502
		jsr	(Sonic_CheckFloor).l
		tst.w	d1
		bpl.s	locret_35502
		add.w	d1,y_pos(a0)
		move.b	d3,angle(a0)
		bclr	#1,status(a0)
		move.b	#0,$2D(a0)
		move.w	#0,y_vel(a0)
		move.w	x_vel(a0),ground_vel(a0)

locret_35502:
		rts
; End of function sub_3526A


; =============== S U B R O U T I N E =======================================


sub_35504:
		move.w	#$600,d6
		move.w	#$C,d5
		move.w	#$80,d4
		btst	#$A,d3
		beq.s	+ ;loc_3551A
		bsr.w	sub_3555C

+ ;loc_3551A:
		btst	#$B,d3
		beq.s	+ ;loc_35524
		bsr.w	sub_355E4

+ ;loc_35524:
		move.w	d3,d0
		andi.w	#$C00,d0
		bne.s	loc_3554E
		move.w	ground_vel(a0),d0
		beq.s	loc_3554E
		bmi.s	++ ;loc_35542
		sub.w	d5,d0
		bcc.s	+ ;loc_3553C
		move.w	#0,d0

+ ;loc_3553C:
		move.w	d0,ground_vel(a0)
		bra.s	loc_3554E
; ---------------------------------------------------------------------------

+ ;loc_35542:
		add.w	d5,d0
		bcc.s	+ ;loc_3554A
		move.w	#0,d0

+ ;loc_3554A:
		move.w	d0,ground_vel(a0)

loc_3554E:
		move.w	ground_vel(a0),x_vel(a0)
		move.w	#0,y_vel(a0)
		rts
; End of function sub_35504


; =============== S U B R O U T I N E =======================================


sub_3555C:
		move.w	ground_vel(a0),d0
		beq.s	+ ;loc_35564
		bpl.s	loc_35596

+ ;loc_35564:
		bset	#0,status(a0)
		bne.s	+ ;loc_35578
		bclr	#5,status(a0)
		move.b	#1,prev_anim(a0)

+ ;loc_35578:
		sub.w	d5,d0
		move.w	d6,d1
		neg.w	d1
		cmp.w	d1,d0
		bgt.s	+ ;loc_3558A
		add.w	d5,d0
		cmp.w	d1,d0
		ble.s	+ ;loc_3558A
		move.w	d1,d0

+ ;loc_3558A:
		move.w	d0,ground_vel(a0)
		move.b	#0,anim(a0)
		rts
; ---------------------------------------------------------------------------

loc_35596:
		sub.w	d4,d0
		bcc.s	+ ;loc_3559E
		move.w	#-$80,d0

+ ;loc_3559E:
		move.w	d0,ground_vel(a0)
		move.b	angle(a0),d0
		addi.b	#$20,d0
		andi.b	#$C0,d0
		bne.s	locret_355E2
		cmpi.w	#$400,d0
		blt.s	locret_355E2
		move.b	#$D,anim(a0)
		bclr	#0,status(a0)
		move.w	#sfx_Skid,d0
		jsr	(Play_SFX).l
		movea.l	a0,a2
		suba.w	#Player_1,a2
		adda.w	#Dust,a2
		move.b	#6,routine(a2)
		move.b	#$15,mapping_frame(a2)

locret_355E2:
		rts
; End of function sub_3555C


; =============== S U B R O U T I N E =======================================


sub_355E4:
		move.w	ground_vel(a0),d0
		bmi.s	+++ ;loc_35618
		bclr	#0,status(a0)
		beq.s	+ ;loc_355FE
		bclr	#5,status(a0)
		move.b	#1,prev_anim(a0)

+ ;loc_355FE:
		add.w	d5,d0
		cmp.w	d6,d0
		blt.s	+ ;loc_3560C
		sub.w	d5,d0
		cmp.w	d6,d0
		bge.s	+ ;loc_3560C
		move.w	d6,d0

+ ;loc_3560C:
		move.w	d0,ground_vel(a0)
		move.b	#0,anim(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_35618:
		add.w	d4,d0
		bcc.s	+ ;loc_35620
		move.w	#$80,d0

+ ;loc_35620:
		move.w	d0,ground_vel(a0)
		move.b	angle(a0),d0
		addi.b	#$20,d0
		andi.b	#$C0,d0
		bne.s	locret_35664
		cmpi.w	#-$400,d0
		bgt.s	locret_35664
		move.b	#$D,anim(a0)
		bset	#0,status(a0)
		move.w	#sfx_Skid,d0
		jsr	(Play_SFX).l
		movea.l	a0,a2
		suba.w	#Player_1,a2
		adda.w	#Dust,a2
		move.b	#6,routine(a2)
		move.b	#$15,mapping_frame(a2)

locret_35664:
		rts
; End of function sub_355E4


; =============== S U B R O U T I N E =======================================


sub_35666:
		tst.w	(Debug_placement_mode).w
		bne.s	locret_356C8
		tst.b	$34(a0)
		beq.s	locret_356C8
		lea	(word_35784).l,a1
		tst.b	(Current_act).w
		beq.s	+ ;loc_35684
		lea	(word_357F6).l,a1

+ ;loc_35684:
		move.w	(a1)+,d6
		move.w	x_pos(a0),d2
		move.w	y_pos(a0),d3

- ;loc_3568E:
		move.w	(a1),d0
		sub.w	d2,d0
		addi.w	#$10,d0
		cmpi.w	#$20,d0
		bhs.s	++ ;loc_356C0
		move.w	2(a1),d1
		sub.w	d3,d1
		addi.w	#$10,d1
		cmpi.w	#$20,d1
		bhs.s	++ ;loc_356C0
		move.w	ground_vel(a0),d0
		move.b	4(a1),d2
		andi.b	#$7F,d2
		beq.s	+ ;loc_356BC
		neg.w	d0

+ ;loc_356BC:
		tst.w	d0
		bpl.s	++ ;loc_356CA

+ ;loc_356C0:
		adda.w	#$10,a1
		dbf	d6,- ;loc_3568E

locret_356C8:
		rts
; ---------------------------------------------------------------------------

+ ;loc_356CA:
		move.b	#1,$35(a0)
		move.w	4(a1),$3E(a0)
		addq.w	#6,a1
		move.w	(a1)+,d4
		move.w	d4,$30(a0)
		move.w	(a1)+,d5
		move.w	d5,d0
		move.b	$3F(a0),d1
		andi.b	#$7F,d1
		beq.s	+ ;loc_356EE
		sub.w	(a1),d0

+ ;loc_356EE:
		move.w	d0,$32(a0)
		move.l	a1,$36(a0)
		move.w	ground_vel(a0),d2
		bpl.s	+ ;loc_356FE
		neg.w	d2

+ ;loc_356FE:
		tst.w	d2
		bne.s	loc_35706
		move.w	#$800,d2

loc_35706:
		moveq	#0,d0
		move.w	d2,d3
		move.w	d4,d0
		sub.w	x_pos(a0),d0
		bge.s	+ ;loc_35716
		neg.w	d0
		neg.w	d2

+ ;loc_35716:
		moveq	#0,d1
		move.w	d5,d1
		sub.w	y_pos(a0),d1
		bge.s	+ ;loc_35724
		neg.w	d1
		neg.w	d3

+ ;loc_35724:
		cmp.w	d0,d1
		blo.s	+++ ;loc_35756
		moveq	#0,d1
		move.w	d5,d1
		sub.w	y_pos(a0),d1
		swap	d1
		divs.w	d3,d1
		moveq	#0,d0
		move.w	d4,d0
		sub.w	x_pos(a0),d0
		beq.s	+ ;loc_35742
		swap	d0
		divs.w	d1,d0

+ ;loc_35742:
		move.w	d0,x_vel(a0)
		move.w	d3,y_vel(a0)
		tst.w	d1
		bpl.s	+ ;loc_35750
		neg.w	d1

+ ;loc_35750:
		move.w	d1,$3A(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_35756:
		moveq	#0,d0
		move.w	d4,d0
		sub.w	x_pos(a0),d0
		swap	d0
		divs.w	d2,d0
		moveq	#0,d1
		move.w	d5,d1
		sub.w	y_pos(a0),d1
		beq.s	+ ;loc_35770
		swap	d1
		divs.w	d0,d1

+ ;loc_35770:
		move.w	d1,y_vel(a0)
		move.w	d2,x_vel(a0)
		tst.w	d0
		bpl.s	+ ;loc_3577E
		neg.w	d0

+ ;loc_3577E:
		move.w	d0,$3A(a0)
		rts
; End of function sub_35666

; ---------------------------------------------------------------------------
word_35784:	dc.w 7-1
		dc.w  $1BA0,   $C6,     0, $1C40,   $E6,  $280, $1CE0,  $385
		dc.w  $1BA0,  $3C4, $8001, $1C40,  $3A6,  $2C0, $1BA0,   $C6
		dc.w  $1CE0,  $385,  $101, $1C40,  $366,  $280, $1BA0,   $C6
		dc.w  $2720,  $846,     0, $27C0,  $866,  $200, $2860,  $A86
		dc.w  $2860,  $846,  $180, $27C0,  $866,  $200, $2720,  $A86
		dc.w  $2720,  $A86,   $81, $27C0,  $A66,  $200, $2860,  $846
		dc.w  $2860,  $A86,  $101, $27C0,  $A66,  $200, $2720,  $846
word_357F6:	dc.w 7-1
		dc.w  $1760,  $546, $8180, $16C0,  $566,  $140, $1760,  $6C5
		dc.w  $1760,  $6C5, $8181, $16C0,  $6A6,  $140, $1760,  $546
		dc.w  $1620,  $6C4,   $81, $16C0,  $6C6,  $180, $1760,  $546
		dc.w  $2AA0,  $444, $8000, $2B40,  $466,  $2C0, $2AA0,  $744
		dc.w  $2BE0,  $446, $8180, $2B40,  $466,  $2C0, $2BE0,  $746
		dc.w  $2AA0,  $744, $8001, $2B40,  $726,  $2C0, $2AA0,  $444
		dc.w  $2BE0,  $746, $8181, $2B40,  $726,  $2C0, $2BE0,  $446

; =============== S U B R O U T I N E =======================================


sub_35868:
		cmpi.b	#2,$35(a0)
		beq.s	loc_358E0
		subq.b	#1,$3A(a0)
		bpl.s	++ ;loc_358A8
		cmpi.b	#3,$35(a0)
		beq.s	+++ ;loc_358CE
		move.w	#0,$3C(a0)
		move.b	#2,$35(a0)
		movea.l	$36(a0),a1
		move.w	(a1)+,d0
		move.w	d0,$2E(a0)
		move.b	$3F(a0),d1
		andi.b	#$7F,d1
		beq.s	+ ;loc_358A2
		move.w	d0,$3C(a0)

+ ;loc_358A2:
		move.l	a1,$36(a0)
		bra.s	loc_358E0
; ---------------------------------------------------------------------------

+ ;loc_358A8:
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

+ ;loc_358CE:
		tst.b	$3E(a0)
		bpl.s	+ ;loc_358D8
		neg.w	ground_vel(a0)

+ ;loc_358D8:
		move.b	#0,$35(a0)
		rts
; ---------------------------------------------------------------------------

loc_358E0:
		move.w	$3C(a0),d0
		add.w	d0,d0
		tst.b	$3F(a0)
		bpl.s	+ ;loc_358EE
		neg.w	d0

+ ;loc_358EE:
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
		bpl.s	+ ;loc_35918
		neg.w	d0

+ ;loc_35918:
		cmpi.w	#$C00,d0
		bne.s	+ ;loc_35920
		moveq	#3,d1

+ ;loc_35920:
		move.b	$3F(a0),d0
		andi.b	#$7F,d0
		beq.s	+ ;loc_35932
		sub.w	d1,$3C(a0)
		bgt.s	locret_35962
		bra.s	++ ;loc_35940
; ---------------------------------------------------------------------------

+ ;loc_35932:
		add.w	d1,$3C(a0)
		move.w	$2E(a0),d0
		cmp.w	$3C(a0),d0
		bhi.s	locret_35962

+ ;loc_35940:
		move.b	#3,$35(a0)
		movea.l	$36(a0),a2
		move.w	(a2)+,d4
		move.w	(a2)+,d5
		move.w	ground_vel(a0),d2
		bpl.s	+ ;loc_35956
		neg.w	d2

+ ;loc_35956:
		tst.w	d2
		bne.s	+ ;loc_3595E
		move.w	#$800,d2

+ ;loc_3595E:
		bra.w	loc_35706
; ---------------------------------------------------------------------------

locret_35962:
		rts
; End of function sub_35868

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
		beq.s	+ ;loc_359CE
		neg.w	d0

+ ;loc_359CE:
		move.w	d0,x_vel(a0)
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	+ ;loc_359EA
		move.l	#Obj_MGZTopPlatform,(a1)
		move.b	#1,subtype(a1)
		move.w	a1,$3E(a0)

+ ;loc_359EA:
		move.l	#loc_359F0,(a0)

loc_359F0:
		movea.w	$3E(a0),a1
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		addq.w	#4,$24(a1)
		cmpi.b	#4,$40(a1)
		beq.s	+ ;loc_35A14
		cmpi.b	#4,$42(a1)
		bne.s	++ ;loc_35A1A

+ ;loc_35A14:
		move.l	#loc_35A20,(a0)

+ ;loc_35A1A:
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------

loc_35A20:
		movea.w	$3E(a0),a1
		addq.w	#1,y_pos(a0)
		subq.w	#1,$30(a0)
		bne.s	+ ;loc_35A3A
		move.l	#loc_35A74,(a0)
		move.w	#$7F00,x_pos(a0)

+ ;loc_35A3A:
		cmpi.w	#4,$30(a0)
		beq.s	+ ;loc_35A56
		bcs.s	loc_35A74
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		addq.w	#4,$24(a1)
		bra.s	loc_35A74
; ---------------------------------------------------------------------------

+ ;loc_35A56:
		move.w	x_vel(a0),d1
		move.w	d1,x_vel(a1)
		move.w	d1,ground_vel(a1)
		move.b	#1,$34(a1)
		bclr	#1,status(a1)
		move.b	#0,subtype(a1)

loc_35A74:
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------

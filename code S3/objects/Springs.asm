; =============== S U B R O U T I N E =======================================


Obj_Spring:
		move.l	#Map_Spring,mappings(a0)
		move.w	#make_art_tile($4A4,0,0),art_tile(a0)
		ori.b	#4,render_flags(a0)
		move.b	#$10,width_pixels(a0)
		move.b	#$10,height_pixels(a0)
		move.w	#$200,priority(a0)
		move.w	x_pos(a0),$32(a0)
		move.w	y_pos(a0),$34(a0)
		move.b	subtype(a0),d0
		lsr.w	#3,d0
		andi.w	#$E,d0
		move.w	Spring_Index(pc,d0.w),d0
		jmp	Spring_Index(pc,d0.w)
; End of function Obj_Spring

; ---------------------------------------------------------------------------
Spring_Index:
		dc.w Spring_Up-Spring_Index
		dc.w Spring_Horizontal-Spring_Index
		dc.w Spring_Down-Spring_Index
		dc.w Spring_UpDiag-Spring_Index
		dc.w Spring_DownDiag-Spring_Index

; =============== S U B R O U T I N E =======================================


sub_21426:
		move.l	#Map_Spring,mappings(a0)
		move.w	#make_art_tile($4A4,0,0),art_tile(a0)
		ori.b	#4,render_flags(a0)
		move.b	#$10,width_pixels(a0)
		move.b	#$10,height_pixels(a0)
		move.w	#$200,priority(a0)
		move.w	x_pos(a0),$32(a0)
		move.w	y_pos(a0),$34(a0)
		move.b	subtype(a0),d0
		lsr.w	#3,d0
		andi.w	#$E,d0
		move.w	off_21472(pc,d0.w),d0
		jsr	off_21472(pc,d0.w)
		move.w	#-$800,$30(a0)
		rts
; End of function sub_21426

; ---------------------------------------------------------------------------
off_21472:
		dc.w Spring_Up-off_21472
		dc.w Spring_Horizontal-off_21472
		dc.w Spring_Down-off_21472
		dc.w Spring_Horizontal-off_21472
		dc.w Spring_Up-off_21472
		dc.w Spring_Down-off_21472
		dc.w Spring_Up-off_21472
		dc.w Spring_Down-off_21472
; ---------------------------------------------------------------------------

Spring_Horizontal:
		move.b	#2,anim(a0)
		move.b	#3,mapping_frame(a0)
		move.w	#make_art_tile($4B4,0,0),art_tile(a0)
		move.b	#8,width_pixels(a0)
		move.l	#Obj_Spring_Horizontal,(a0)
		tst.w	(Competition_mode).w
		beq.w	Spring_Common
		move.l	#Map_2PSpring,mappings(a0)
		move.w	#make_art_tile($3AD,0,0),art_tile(a0)
		move.l	#Obj_2PSpring_Horizontal,(a0)
		bra.w	Spring_Common
; ---------------------------------------------------------------------------

Spring_Down:
		move.b	#6,mapping_frame(a0)
		bset	#1,status(a0)
		move.l	#Obj_Spring_Down,(a0)
		tst.w	(Competition_mode).w
		beq.w	Spring_Common
		move.l	#Obj_2PSpring_Down,(a0)
		move.l	#Map_2PSpring,mappings(a0)
		move.w	#make_art_tile($391,0,0),art_tile(a0)
		bra.w	Spring_Common
; ---------------------------------------------------------------------------

Spring_UpDiag:
		move.b	#4,anim(a0)
		move.b	#7,mapping_frame(a0)
		move.w	#make_art_tile($43A,0,0),art_tile(a0)
		cmpi.b	#2,(Current_zone).w
		bne.s	loc_21512
		move.w	#make_art_tile($478,0,0),art_tile(a0)

loc_21512:
		move.l	#Obj_Spring_UpDiag,(a0)
		bra.s	Spring_Common
; ---------------------------------------------------------------------------

Spring_DownDiag:
		move.b	#4,anim(a0)
		move.b	#$A,mapping_frame(a0)
		move.w	#make_art_tile($43A,0,0),art_tile(a0)
		cmpi.b	#2,(Current_zone).w
		bne.s	loc_2153A
		move.w	#make_art_tile($478,0,0),art_tile(a0)

loc_2153A:
		bset	#1,status(a0)
		move.l	#Obj_Spring_DownDiag,(a0)
		bra.s	Spring_Common
; ---------------------------------------------------------------------------

Spring_Up:
		move.l	#Obj_Spring_Up,(a0)
		tst.w	(Competition_mode).w
		beq.s	Spring_Common
		move.l	#Obj_2PSpring_Up,(a0)
		move.l	#Map_2PSpring,mappings(a0)
		move.w	#make_art_tile($391,0,0),art_tile(a0)
		cmpi.b	#$12,(Current_zone).w
		bne.s	Spring_Common
		ori.w	#high_priority,art_tile(a0)

Spring_Common:
		move.b	subtype(a0),d0
		andi.w	#2,d0
		move.w	word_215A2(pc,d0.w),$30(a0)
		btst	#1,d0
		beq.s	locret_215A0
		move.l	#Map_Spring2,mappings(a0)
		tst.w	(Competition_mode).w
		beq.s	locret_215A0
		move.l	#Map_Spring3,mappings(a0)

locret_215A0:
		rts
; ---------------------------------------------------------------------------
word_215A2:
		dc.w -$1000
		dc.w  -$A00
; ---------------------------------------------------------------------------

Obj_Spring_Up:
		move.w	#$1B,d1
		move.w	#8,d2
		move.w	#$10,d3
		move.w	x_pos(a0),d4
		lea	(Player_1).w,a1
		moveq	#p1_standing_bit,d6
		movem.l	d1-d4,-(sp)
		bsr.w	SolidObjectFull2_1P
		btst	#p1_standing_bit,status(a0)
		beq.s	loc_215CE
		bsr.s	sub_2164A

loc_215CE:
		movem.l	(sp)+,d1-d4
		lea	(Player_2).w,a1
		moveq	#p2_standing_bit,d6
		bsr.w	SolidObjectFull2_1P
		btst	#p2_standing_bit,status(a0)
		beq.s	loc_215E6
		bsr.s	sub_2164A

loc_215E6:
		lea	(Ani_Spring).l,a1
		jsr	(Animate_Sprite).l
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------

Obj_2PSpring_Up:
		move.w	#$13,d1
		move.w	#8,d2
		move.w	#$10,d3
		move.w	x_pos(a0),d4
		lea	(Player_1).w,a1
		moveq	#p1_standing_bit,d6
		movem.l	d1-d4,-(sp)
		bsr.w	SolidObjectFull2_1P
		btst	#p1_standing_bit,status(a0)
		beq.s	loc_21620
		bsr.s	sub_2164A

loc_21620:
		movem.l	(sp)+,d1-d4
		lea	(Player_2).w,a1
		moveq	#p2_standing_bit,d6
		bsr.w	SolidObjectFull2_1P
		btst	#p2_standing_bit,status(a0)
		beq.s	loc_21638
		bsr.s	sub_2164A

loc_21638:
		lea	(Ani_Spring).l,a1
		jsr	(Animate_Sprite).l
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_2164A:
		move.w	#1<<8,anim(a0)	; and prev_anim
		addq.w	#8,y_pos(a1)
		move.w	$30(a0),y_vel(a1)
		bset	#1,status(a1)
		bclr	#3,status(a1)
		clr.b	jumping(a1)
		clr.b	spin_dash_flag(a1)
		move.b	#$10,anim(a1)
		move.b	#2,routine(a1)
		move.b	subtype(a0),d0
		bpl.s	loc_21686
		move.w	#0,x_vel(a1)

loc_21686:
		btst	#0,d0
		beq.s	loc_216C6
		move.w	#1,ground_vel(a1)
		move.b	#1,flip_angle(a1)
		move.b	#0,anim(a1)
		move.b	#0,flips_remaining(a1)
		move.b	#4,flip_speed(a1)
		btst	#1,d0
		bne.s	loc_216B6
		move.b	#1,flips_remaining(a1)

loc_216B6:
		btst	#0,status(a1)
		beq.s	loc_216C6
		neg.b	flip_angle(a1)
		neg.w	ground_vel(a1)

loc_216C6:
		andi.b	#$C,d0
		cmpi.b	#4,d0
		bne.s	loc_216DC
		move.b	#$C,top_solid_bit(a1)
		move.b	#$D,lrb_solid_bit(a1)

loc_216DC:
		cmpi.b	#8,d0
		bne.s	loc_216EE
		move.b	#$E,top_solid_bit(a1)
		move.b	#$F,lrb_solid_bit(a1)

loc_216EE:
		moveq	#signextendB(sfx_Spring),d0
		jmp	(Play_SFX).l
; End of function sub_2164A

; ---------------------------------------------------------------------------

Obj_Spring_Horizontal:
		move.w	#$13,d1
		move.w	#$E,d2
		move.w	#$F,d3
		move.w	x_pos(a0),d4
		lea	(Player_1).w,a1
		moveq	#p1_standing_bit,d6
		movem.l	d1-d4,-(sp)
		bsr.w	SolidObjectFull2_1P
		swap	d6
		andi.w	#1,d6
		beq.s	loc_21738
		move.b	status(a0),d1
		move.w	x_pos(a0),d0
		sub.w	x_pos(a1),d0
		bcs.s	loc_2172E
		eori.b	#1,d1

loc_2172E:
		andi.b	#1,d1
		bne.s	loc_21738
		bsr.w	sub_21836

loc_21738:
		movem.l	(sp)+,d1-d4
		lea	(Player_2).w,a1
		moveq	#p2_standing_bit,d6
		bsr.w	SolidObjectFull2_1P
		swap	d6
		andi.w	#2,d6
		beq.s	loc_2176A
		move.b	status(a0),d1
		move.w	x_pos(a0),d0
		sub.w	x_pos(a1),d0
		bcs.s	loc_21760
		eori.b	#1,d1

loc_21760:
		andi.b	#1,d1
		bne.s	loc_2176A
		bsr.w	sub_21836

loc_2176A:
		bsr.w	sub_2190C
		lea	(Ani_Spring).l,a1
		jsr	(Animate_Sprite).l
		move.w	$32(a0),d0
		jmp	(Sprite_OnScreen_Test2).l
; ---------------------------------------------------------------------------

Obj_2PSpring_Horizontal:
		move.w	#$F,d1
		move.w	#$C,d2
		move.w	#$D,d3
		move.w	x_pos(a0),d4
		lea	(Player_1).w,a1
		moveq	#p1_standing_bit,d6
		movem.l	d1-d4,-(sp)
		bsr.w	SolidObjectFull2_1P
		swap	d6
		andi.w	#1,d6
		beq.s	loc_217C4
		move.b	status(a0),d1
		move.w	x_pos(a0),d0
		sub.w	x_pos(a1),d0
		bcs.s	loc_217BC
		eori.b	#1,d1

loc_217BC:
		andi.b	#1,d1
		bne.s	loc_217C4
		bsr.s	sub_21806

loc_217C4:
		movem.l	(sp)+,d1-d4
		lea	(Player_2).w,a1
		moveq	#p2_standing_bit,d6
		bsr.w	SolidObjectFull2_1P
		swap	d6
		andi.w	#2,d6
		beq.s	loc_217F4
		move.b	status(a0),d1
		move.w	x_pos(a0),d0
		sub.w	x_pos(a1),d0
		bcs.s	loc_217EC
		eori.b	#1,d1

loc_217EC:
		andi.b	#1,d1
		bne.s	loc_217F4
		bsr.s	sub_21806

loc_217F4:
		lea	(Ani_Spring).l,a1
		jsr	(Animate_Sprite).l
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_21806:
		move.w	#3<<8,anim(a0)	; and prev_anim
		move.w	$30(a0),x_vel(a1)
		addq.w	#4,x_pos(a1)
		bset	#Status_Facing,status(a1)
		btst	#0,status(a0)
		bne.s	loc_21834
		bclr	#Status_Facing,status(a1)
		subi.w	#2*4,x_pos(a1)
		neg.w	x_vel(a1)

loc_21834:
		bra.s	loc_21864
; End of function sub_21806


; =============== S U B R O U T I N E =======================================


sub_21836:
		move.w	#3<<8,anim(a0)	; and prev_anim
		move.w	$30(a0),x_vel(a1)
		addq.w	#8,x_pos(a1)
		bset	#Status_Facing,status(a1)
		btst	#0,status(a0)
		bne.s	loc_21864
		bclr	#Status_Facing,status(a1)
		subi.w	#2*8,x_pos(a1)
		neg.w	x_vel(a1)

loc_21864:
		move.w	#$F,$32(a1)
		move.w	x_vel(a1),ground_vel(a1)
		btst	#Status_Roll,status(a1)
		bne.s	loc_2187E
		move.b	#0,anim(a1)

loc_2187E:
		move.b	subtype(a0),d0
		bpl.s	loc_2188A
		move.w	#0,y_vel(a1)

loc_2188A:
		btst	#0,d0
		beq.s	loc_218CA
		move.w	#1,ground_vel(a1)
		move.b	#1,flip_angle(a1)
		move.b	#0,anim(a1)
		move.b	#1,flips_remaining(a1)
		move.b	#8,flip_speed(a1)
		btst	#1,d0
		bne.s	loc_218BA
		move.b	#3,flips_remaining(a1)

loc_218BA:
		btst	#Status_Facing,status(a1)
		beq.s	loc_218CA
		neg.b	flip_angle(a1)
		neg.w	ground_vel(a1)

loc_218CA:
		andi.b	#$C,d0
		cmpi.b	#4,d0
		bne.s	loc_218E0
		move.b	#$C,top_solid_bit(a1)
		move.b	#$D,lrb_solid_bit(a1)

loc_218E0:
		cmpi.b	#8,d0
		bne.s	loc_218F2
		move.b	#$E,top_solid_bit(a1)
		move.b	#$F,lrb_solid_bit(a1)

loc_218F2:
		bclr	#p1_pushing_bit,status(a0)
		bclr	#p2_pushing_bit,status(a0)
		bclr	#Status_Push,status(a1)
		moveq	#signextendB(sfx_Spring),d0
		jmp	(Play_SFX).l
; End of function sub_21836


; =============== S U B R O U T I N E =======================================


sub_2190C:
		cmpi.b	#3,anim(a0)
		beq.w	locret_219C4
		move.w	x_pos(a0),d0
		move.w	d0,d1
		addi.w	#$28,d1
		btst	#0,status(a0)
		beq.s	loc_2192E
		move.w	d0,d1
		subi.w	#$28,d0

loc_2192E:
		move.w	y_pos(a0),d2
		move.w	d2,d3
		subi.w	#$18,d2
		addi.w	#$18,d3
		lea	(Player_1).w,a1
		btst	#1,status(a1)
		bne.s	loc_21982
		move.w	ground_vel(a1),d4
		btst	#0,status(a0)
		beq.s	loc_21956
		neg.w	d4

loc_21956:
		tst.w	d4
		bmi.s	loc_21982
		move.w	x_pos(a1),d4
		cmp.w	d0,d4
		blo.w	loc_21982
		cmp.w	d1,d4
		bhs.w	loc_21982
		move.w	y_pos(a1),d4
		cmp.w	d2,d4
		blo.w	loc_21982
		cmp.w	d3,d4
		bhs.w	loc_21982
		move.w	d0,-(sp)
		bsr.w	sub_21836
		move.w	(sp)+,d0

loc_21982:
		lea	(Player_2).w,a1
		btst	#Status_InAir,status(a1)
		bne.s	locret_219C4
		move.w	ground_vel(a1),d4
		btst	#0,status(a0)
		beq.s	loc_2199C
		neg.w	d4

loc_2199C:
		tst.w	d4
		bmi.s	locret_219C4
		move.w	x_pos(a1),d4
		cmp.w	d0,d4
		blo.w	locret_219C4
		cmp.w	d1,d4
		bhs.w	locret_219C4
		move.w	y_pos(a1),d4
		cmp.w	d2,d4
		blo.w	locret_219C4
		cmp.w	d3,d4
		bhs.w	locret_219C4
		bsr.w	sub_21836

locret_219C4:
		rts
; End of function sub_2190C

; ---------------------------------------------------------------------------

Obj_Spring_Down:
		move.w	#$1B,d1
		move.w	#8,d2
		move.w	#9,d3
		move.w	x_pos(a0),d4
		lea	(Player_1).w,a1
		moveq	#p1_standing_bit,d6
		movem.l	d1-d4,-(sp)
		bsr.w	SolidObjectFull2_1P
		cmpi.w	#-2,d4
		bne.s	loc_219EC
		bsr.s	sub_21A6A

loc_219EC:
		movem.l	(sp)+,d1-d4
		lea	(Player_2).w,a1
		moveq	#p2_standing_bit,d6
		bsr.w	SolidObjectFull2_1P
		cmpi.w	#-2,d4
		bne.s	loc_21A02
		bsr.s	sub_21A6A

loc_21A02:
		lea	(Ani_Spring).l,a1
		jsr	(Animate_Sprite).l
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------

Obj_2PSpring_Down:
		move.w	#$13,d1
		move.w	#8,d2
		move.w	#9,d3
		move.w	x_pos(a0),d4
		lea	(Player_1).w,a1
		moveq	#p1_standing_bit,d6
		movem.l	d1-d4,-(sp)
		bsr.w	SolidObjectFull2_1P
		cmpi.w	#-2,d4
		bne.s	loc_21A3E
		subq.w	#4,y_pos(a1)
		bsr.s	loc_21A6E

loc_21A3E:
		movem.l	(sp)+,d1-d4
		lea	(Player_2).w,a1
		moveq	#p2_standing_bit,d6
		bsr.w	SolidObjectFull2_1P
		cmpi.w	#-2,d4
		bne.s	loc_21A58
		subq.w	#4,y_pos(a1)
		bsr.s	loc_21A6E

loc_21A58:
		lea	(Ani_Spring).l,a1
		jsr	(Animate_Sprite).l
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_21A6A:
		subq.w	#8,y_pos(a1)

loc_21A6E:
		move.w	#1<<8,anim(a0)	; and prev_anim
		move.w	$30(a0),y_vel(a1)
		neg.w	y_vel(a1)
		cmpi.w	#$1000,y_vel(a1)
		bne.s	loc_21A8C
		move.w	#$D00,y_vel(a1)

loc_21A8C:
		move.b	subtype(a0),d0
		bpl.s	loc_21A98
		move.w	#0,x_vel(a1)

loc_21A98:
		btst	#0,d0
		beq.s	loc_21AD8
		move.w	#1,ground_vel(a1)
		move.b	#1,flip_angle(a1)
		move.b	#0,anim(a1)
		move.b	#0,flips_remaining(a1)
		move.b	#4,flip_speed(a1)
		btst	#1,d0
		bne.s	loc_21AC8
		move.b	#1,flips_remaining(a1)

loc_21AC8:
		btst	#Status_Facing,status(a1)
		beq.s	loc_21AD8
		neg.b	flip_angle(a1)
		neg.w	ground_vel(a1)

loc_21AD8:
		andi.b	#$C,d0
		cmpi.b	#4,d0
		bne.s	loc_21AEE
		move.b	#$C,top_solid_bit(a1)
		move.b	#$D,lrb_solid_bit(a1)

loc_21AEE:
		cmpi.b	#8,d0
		bne.s	loc_21B00
		move.b	#$E,top_solid_bit(a1)
		move.b	#$F,lrb_solid_bit(a1)

loc_21B00:
		bset	#Status_InAir,status(a1)
		bclr	#Status_OnObj,status(a1)
		clr.b	jumping(a1)
		move.b	#2,routine(a1)
		moveq	#signextendB(sfx_Spring),d0
		jmp	(Play_SFX).l
; End of function sub_21A6A

; ---------------------------------------------------------------------------

Obj_Spring_UpDiag:
		move.w	#$1B,d1
		move.w	#$10,d2
		move.w	x_pos(a0),d4
		lea	byte_21D78(pc),a2
		lea	(Player_1).w,a1
		moveq	#p1_standing_bit,d6
		movem.l	d1-d4,-(sp)
		bsr.w	sub_1BADA
		btst	#p1_standing_bit,status(a0)
		beq.s	loc_21B46
		bsr.s	sub_21B74

loc_21B46:
		movem.l	(sp)+,d1-d4
		lea	(Player_2).w,a1
		moveq	#p2_standing_bit,d6
		bsr.w	sub_1BADA
		btst	#p2_standing_bit,status(a0)
		beq.s	loc_21B5E
		bsr.s	sub_21B74

loc_21B5E:
		lea	(Ani_Spring).l,a1
		jsr	(Animate_Sprite).l
		move.w	$32(a0),d0
		jmp	(Sprite_OnScreen_Test2).l

; =============== S U B R O U T I N E =======================================


sub_21B74:
		btst	#0,status(a0)
		bne.s	loc_21B8A
		move.w	x_pos(a0),d0
		subq.w	#4,d0
		cmp.w	x_pos(a1),d0
		blo.s	loc_21B98
		rts
; ---------------------------------------------------------------------------

loc_21B8A:
		move.w	x_pos(a0),d0
		addq.w	#4,d0
		cmp.w	x_pos(a1),d0
		bhs.s	loc_21B98
		rts
; ---------------------------------------------------------------------------

loc_21B98:
		move.w	#5<<8,anim(a0)	; and prev_anim
		move.w	$30(a0),y_vel(a1)
		move.w	$30(a0),x_vel(a1)
		addq.w	#6,y_pos(a1)
		addq.w	#6,x_pos(a1)
		bset	#Status_Facing,status(a1)
		btst	#0,status(a0)
		bne.s	loc_21BD0
		bclr	#Status_Facing,status(a1)
		subi.w	#2*6,x_pos(a1)
		neg.w	x_vel(a1)

loc_21BD0:
		bset	#Status_InAir,status(a1)
		bclr	#Status_OnObj,status(a1)
		clr.b	jumping(a1)
		move.b	#$10,anim(a1)
		move.b	#2,routine(a1)
		move.b	subtype(a0),d0
		btst	#0,d0
		beq.s	loc_21C30
		move.w	#1,ground_vel(a1)
		move.b	#1,flip_angle(a1)
		move.b	#0,anim(a1)
		move.b	#1,flips_remaining(a1)
		move.b	#8,flip_speed(a1)
		btst	#1,d0
		bne.s	loc_21C20
		move.b	#3,flips_remaining(a1)

loc_21C20:
		btst	#0,status(a1)
		beq.s	loc_21C30
		neg.b	flip_angle(a1)
		neg.w	ground_vel(a1)

loc_21C30:
		andi.b	#$C,d0
		cmpi.b	#4,d0
		bne.s	loc_21C46
		move.b	#$C,top_solid_bit(a1)
		move.b	#$D,lrb_solid_bit(a1)

loc_21C46:
		cmpi.b	#8,d0
		bne.s	loc_21C58
		move.b	#$E,top_solid_bit(a1)
		move.b	#$F,lrb_solid_bit(a1)

loc_21C58:
		moveq	#signextendB(sfx_Spring),d0
		jmp	(Play_SFX).l
; End of function sub_21B74

; ---------------------------------------------------------------------------

Obj_Spring_DownDiag:
		move.w	#$1B,d1
		move.w	#$10,d2
		move.w	x_pos(a0),d4
		lea	byte_21D94(pc),a2
		lea	(Player_1).w,a1
		moveq	#p1_standing_bit,d6
		movem.l	d1-d4,-(sp)
		bsr.w	sub_1BADA
		cmpi.w	#-2,d4
		bne.s	loc_21C86
		bsr.s	sub_21CB2

loc_21C86:
		movem.l	(sp)+,d1-d4
		lea	(Player_2).w,a1
		moveq	#p2_standing_bit,d6
		bsr.w	sub_1BADA
		cmpi.w	#-2,d4
		bne.s	loc_21C9C
		bsr.s	sub_21CB2

loc_21C9C:
		lea	(Ani_Spring).l,a1
		jsr	(Animate_Sprite).l
		move.w	$32(a0),d0
		jmp	(Sprite_OnScreen_Test2).l

; =============== S U B R O U T I N E =======================================


sub_21CB2:
		move.w	#5<<8,anim(a0)	; and prev_anim
		move.w	$30(a0),y_vel(a1)
		neg.w	y_vel(a1)
		move.w	$30(a0),x_vel(a1)
		subq.w	#6,y_pos(a1)
		addq.w	#6,x_pos(a1)
		bset	#Status_Facing,status(a1)
		btst	#0,status(a0)
		bne.s	loc_21CEE
		bclr	#Status_Facing,status(a1)
		subi.w	#2*6,x_pos(a1)
		neg.w	x_vel(a1)

loc_21CEE:
		bset	#Status_InAir,status(a1)
		bclr	#Status_OnObj,status(a1)
		clr.b	jumping(a1)
		move.b	#2,routine(a1)
		move.b	subtype(a0),d0
		btst	#0,d0
		beq.s	loc_21D48
		move.w	#1,ground_vel(a1)
		move.b	#1,flip_angle(a1)
		move.b	#0,anim(a1)
		move.b	#1,flips_remaining(a1)
		move.b	#8,flip_speed(a1)
		btst	#1,d0
		bne.s	loc_21D38
		move.b	#3,flips_remaining(a1)

loc_21D38:
		btst	#Status_Facing,status(a1)
		beq.s	loc_21D48
		neg.b	flip_angle(a1)
		neg.w	ground_vel(a1)

loc_21D48:
		andi.b	#$C,d0
		cmpi.b	#4,d0
		bne.s	loc_21D5E
		move.b	#$C,top_solid_bit(a1)
		move.b	#$D,lrb_solid_bit(a1)

loc_21D5E:
		cmpi.b	#8,d0
		bne.s	loc_21D70
		move.b	#$E,top_solid_bit(a1)
		move.b	#$F,lrb_solid_bit(a1)

loc_21D70:
		moveq	#signextendB(sfx_Spring),d0
		jmp	(Play_SFX).l
; End of function sub_21CB2

; ---------------------------------------------------------------------------
byte_21D78:
		dc.b  $10
		dc.b  $10
		dc.b  $10
		dc.b  $10
		dc.b  $10
		dc.b  $10
		dc.b  $10
		dc.b  $10
		dc.b  $10
		dc.b  $10
		dc.b  $10
		dc.b  $10
		dc.b   $E
		dc.b   $C
		dc.b   $A
		dc.b    8
		dc.b    6
		dc.b    4
		dc.b    2
		dc.b    0
		dc.b   -2
		dc.b   -4
		dc.b   -4
		dc.b   -4
		dc.b   -4
		dc.b   -4
		dc.b   -4
		dc.b   -4
byte_21D94:
		dc.b  -$C
		dc.b -$10
		dc.b -$10
		dc.b -$10
		dc.b -$10
		dc.b -$10
		dc.b -$10
		dc.b -$10
		dc.b -$10
		dc.b -$10
		dc.b -$10
		dc.b -$10
		dc.b  -$E
		dc.b  -$C
		dc.b  -$A
		dc.b   -8
		dc.b   -6
		dc.b   -4
		dc.b   -2
		dc.b    0
		dc.b    2
		dc.b    4
		dc.b    4
		dc.b    4
		dc.b    4
		dc.b    4
		dc.b    4
		dc.b    4
		even
Ani_Spring:
		include "General/Sprites/Level Misc/Anim - Spring.asm"
Map_Spring:
		include "General/Sprites/Level Misc/Map - Spring.asm"
Map_2PSpring:
		include "General/Sprites/Level Misc/Map - 2P Spring.asm"
; ---------------------------------------------------------------------------

Obj_RetractingSpring:
		bsr.w	Obj_Spring
		move.b	subtype(a0),d0
		lsr.w	#3,d0
		andi.w	#$E,d0
		move.w	RetractingSpring_Index(pc,d0.w),d1
		jmp	RetractingSpring_Index(pc,d1.w)
; ---------------------------------------------------------------------------
RetractingSpring_Index:
		dc.w loc_22092-RetractingSpring_Index
		dc.w loc_220AE-RetractingSpring_Index
		dc.w loc_220CA-RetractingSpring_Index
		dc.w loc_220E6-RetractingSpring_Index
		dc.w loc_22116-RetractingSpring_Index
; ---------------------------------------------------------------------------

loc_22092:
		move.l	#loc_22098,(a0)

loc_22098:
		bsr.w	sub_22146
		moveq	#0,d0
		move.b	$36(a0),d0
		add.w	$34(a0),d0
		move.w	d0,y_pos(a0)
		bra.w	Obj_Spring_Up
; ---------------------------------------------------------------------------

loc_220AE:
		move.l	#loc_220B4,(a0)

loc_220B4:
		bsr.w	sub_22146
		moveq	#0,d0
		move.b	$36(a0),d0
		add.w	$32(a0),d0
		move.w	d0,x_pos(a0)
		bra.w	Obj_Spring_Horizontal
; ---------------------------------------------------------------------------

loc_220CA:
		move.l	#loc_220D0,(a0)

loc_220D0:
		bsr.w	sub_22146
		moveq	#0,d0
		move.b	$36(a0),d0
		add.w	$34(a0),d0
		move.w	d0,y_pos(a0)
		bra.w	Obj_Spring_Down
; ---------------------------------------------------------------------------

loc_220E6:
		move.l	#loc_220EC,(a0)

loc_220EC:
		bsr.w	sub_22146
		moveq	#0,d0
		move.b	$36(a0),d0
		move.w	d0,d1
		btst	#0,status(a0)
		bne.s	loc_22102
		neg.w	d0

loc_22102:
		add.w	$32(a0),d0
		move.w	d0,x_pos(a0)
		add.w	$34(a0),d1
		move.w	d1,y_pos(a0)
		bra.w	Obj_Spring_UpDiag
; ---------------------------------------------------------------------------

loc_22116:
		move.l	#loc_2211C,(a0)

loc_2211C:
		bsr.w	sub_22146
		moveq	#0,d0
		move.b	$36(a0),d0
		move.w	d0,d1
		btst	#0,status(a0)
		beq.s	loc_22132
		neg.w	d0

loc_22132:
		add.w	$32(a0),d0
		move.w	d0,x_pos(a0)
		add.w	$34(a0),d1
		move.w	d1,y_pos(a0)
		bra.w	Obj_Spring_DownDiag

; =============== S U B R O U T I N E =======================================


sub_22146:
		tst.w	$3A(a0)
		beq.s	loc_22162
		subq.w	#1,$3A(a0)
		bne.s	locret_221A4
		tst.b	render_flags(a0)
		bpl.s	locret_221A4
		moveq	#signextendB(sfx_SpikeMove),d0
		jsr	(Play_SFX).l
		bra.s	locret_221A4
; ---------------------------------------------------------------------------

loc_22162:
		tst.w	$38(a0)
		beq.s	loc_22184
		subi.w	#$800,$36(a0)
		bcc.s	locret_221A4
		move.w	#0,$36(a0)
		move.w	#0,$38(a0)
		move.w	#60,$3A(a0)
		bra.s	locret_221A4
; ---------------------------------------------------------------------------

loc_22184:
		addi.w	#$800,$36(a0)
		cmpi.w	#$2000,$36(a0)
		blo.s	locret_221A4
		move.w	#$2000,$36(a0)
		move.w	#1,$38(a0)
		move.w	#60,$3A(a0)

locret_221A4:
		rts
; End of function sub_22146

; ---------------------------------------------------------------------------
byte_221A6:
		dc.b   $C,   8,   0,   1
		dc.b   $C,   8,   0,   0
		dc.b   $C,   8,   0,   1
		dc.b    8,  $C,   1,   0
		dc.b   $C,   8,   2,   1
		dc.b   $C,   8,   3,   1
		dc.b   $C,   8,   2,   1
		dc.b   $C,   8,   3,   1
		even
; ---------------------------------------------------------------------------

Obj_2PRetractingSpring:
		jsr	(AllocateObjectAfterCurrent).l
		bne.w	loc_2229C
		move.l	#loc_2255E,(a1)
		move.l	#Map_2PRetractingSpring,mappings(a1)
		move.w	#make_art_tile($391,0,0),art_tile(a1)
		cmpi.b	#$12,(Current_zone).w
		bne.s	loc_221F4
		move.l	#Map_2PRetractingSpring_2,mappings(a1)

loc_221F4:
		move.b	subtype(a0),d0
		move.b	d0,subtype(a1)
		lsr.b	#2,d0
		andi.w	#$1C,d0
		lea	byte_221A6(pc,d0.w),a2
		move.b	(a2)+,width_pixels(a1)
		move.b	(a2)+,height_pixels(a1)
		move.b	(a2)+,d0
		move.b	d0,mapping_frame(a1)
		bne.s	loc_2221C
		move.l	#loc_225B8,(a1)

loc_2221C:
		andi.b	#$F0,subtype(a0)
		move.b	(a2)+,d1
		or.b	d1,subtype(a0)
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		moveq	#0,d2
		moveq	#0,d3
		cmpi.b	#1,d0
		bne.s	loc_2224E
		moveq	#$C,d2
		btst	#0,status(a0)
		bne.s	loc_2224A
		neg.w	d2

loc_2224A:
		add.w	d2,x_pos(a1)

loc_2224E:
		cmpi.b	#2,d0
		bne.s	loc_2225A
		moveq	#$B,d3
		add.w	d3,y_pos(a1)

loc_2225A:
		cmpi.b	#3,d0
		bne.s	loc_22266
		moveq	#-$B,d3
		add.w	d3,y_pos(a1)

loc_22266:
		move.w	d2,$30(a1)
		move.w	d3,$32(a1)
		bclr	#1,status(a0)
		beq.s	loc_2227C
		move.b	#1,$3C(a0)

loc_2227C:
		move.b	status(a0),status(a1)
		move.b	render_flags(a0),render_flags(a1)
		ori.b	#4,render_flags(a1)
		move.w	#$200,priority(a1)
		move.w	a0,$3E(a1)
		move.w	a1,$3E(a0)

loc_2229C:
		bsr.w	sub_21426

loc_222A0:
		move.b	subtype(a0),d0
		lsr.w	#3,d0
		andi.w	#$E,d0
		move.w	off_222B2(pc,d0.w),d1
		jmp	off_222B2(pc,d1.w)
; ---------------------------------------------------------------------------
off_222B2:
		dc.w loc_222C2-off_222B2
		dc.w loc_222DE-off_222B2
		dc.w loc_222FA-off_222B2
		dc.w loc_22316-off_222B2
		dc.w loc_22332-off_222B2
		dc.w loc_2234E-off_222B2
		dc.w loc_22332-off_222B2
		dc.w loc_2234E-off_222B2
; ---------------------------------------------------------------------------

loc_222C2:
		move.l	#loc_222C8,(a0)

loc_222C8:
		bsr.w	sub_2236A
		moveq	#0,d0
		move.b	$36(a0),d0
		add.w	$34(a0),d0
		move.w	d0,y_pos(a0)
		bra.w	Obj_2PSpring_Up
; ---------------------------------------------------------------------------

loc_222DE:
		move.l	#loc_222E4,(a0)

loc_222E4:
		bsr.w	sub_2236A
		moveq	#0,d0
		move.b	$36(a0),d0
		add.w	$32(a0),d0
		move.w	d0,x_pos(a0)
		bra.w	Obj_2PSpring_Horizontal
; ---------------------------------------------------------------------------

loc_222FA:
		move.l	#loc_22300,(a0)

loc_22300:
		bsr.w	sub_2236A
		moveq	#0,d0
		move.b	$36(a0),d0
		add.w	$34(a0),d0
		move.w	d0,y_pos(a0)
		bra.w	Obj_2PSpring_Down
; ---------------------------------------------------------------------------

loc_22316:
		move.l	#loc_2231C,(a0)

loc_2231C:
		bsr.w	sub_2236A
		moveq	#0,d0
		move.b	$36(a0),d0
		add.w	$34(a0),d0
		move.w	d0,y_pos(a0)
		bra.w	Obj_2PSpring_Horizontal
; ---------------------------------------------------------------------------

loc_22332:
		move.l	#loc_22338,(a0)

loc_22338:
		bsr.w	sub_2236A
		moveq	#0,d0
		move.b	$36(a0),d0
		add.w	$32(a0),d0
		move.w	d0,x_pos(a0)
		bra.w	Obj_2PSpring_Up
; ---------------------------------------------------------------------------

loc_2234E:
		move.l	#loc_22354,(a0)

loc_22354:
		bsr.w	sub_2236A
		moveq	#0,d0
		move.b	$36(a0),d0
		add.w	$32(a0),d0
		move.w	d0,x_pos(a0)
		bra.w	Obj_2PSpring_Down

; =============== S U B R O U T I N E =======================================


sub_2236A:
		tst.b	subtype(a0)
		bmi.s	loc_223D0
		tst.w	$3A(a0)
		beq.s	loc_2238C
		subq.w	#1,$3A(a0)
		bne.s	locret_223CE
		tst.b	render_flags(a0)
		bpl.s	locret_223CE
		moveq	#signextendB(sfx_SpikeMove),d0
		jsr	(Play_SFX).l
		bra.s	locret_223CE
; ---------------------------------------------------------------------------

loc_2238C:
		tst.w	$38(a0)
		beq.s	loc_223AE
		subi.w	#$800,$36(a0)
		bcc.s	locret_223CE
		move.w	#0,$36(a0)
		move.w	#0,$38(a0)
		move.w	#60,$3A(a0)
		bra.s	locret_223CE
; ---------------------------------------------------------------------------

loc_223AE:
		addi.w	#$800,$36(a0)
		cmpi.w	#$1800,$36(a0)
		blo.s	locret_223CE
		move.w	#$1800,$36(a0)
		move.w	#1,$38(a0)
		move.w	#60,$3A(a0)

locret_223CE:
		rts
; ---------------------------------------------------------------------------

loc_223D0:
		tst.b	$3C(a0)
		beq.w	loc_2249A
		tst.w	$3A(a0)
		beq.s	loc_223F0
		subq.w	#1,$3A(a0)
		bne.w	locret_22498
		move.w	#0,$38(a0)
		bra.w	locret_22498
; ---------------------------------------------------------------------------

loc_223F0:
		tst.w	$38(a0)
		bne.w	loc_2247E
		tst.w	$36(a0)
		beq.w	locret_22498
		subi.w	#$800,$36(a0)
		bhi.w	locret_22498
		move.w	#0,$36(a0)
		move.b	subtype(a0),d0
		andi.b	#$F0,d0
		cmpi.b	#$E0,d0
		bne.s	loc_2244A
		addi.w	#$16,y_pos(a0)
		bchg	#1,status(a0)
		bchg	#1,render_flags(a0)
		andi.b	#$F,subtype(a0)
		ori.b	#$F0,subtype(a0)
		move.l	#loc_222A0,(a0)
		movea.w	$3E(a0),a1
		neg.w	$32(a1)

loc_2244A:
		cmpi.b	#$F0,d0
		bne.s	loc_2247C
		subi.w	#$16,y_pos(a0)
		bchg	#1,status(a0)
		bchg	#1,render_flags(a0)
		andi.b	#$F,subtype(a0)
		ori.b	#$E0,subtype(a0)
		move.l	#loc_222A0,(a0)
		movea.w	$3E(a0),a1
		neg.w	$32(a1)

loc_2247C:
		bra.s	locret_22498
; ---------------------------------------------------------------------------

loc_2247E:
		addi.w	#$800,$36(a0)
		cmpi.w	#$1800,$36(a0)
		blo.s	locret_22498
		move.w	#$1800,$36(a0)
		move.w	#3*60,$3A(a0)

locret_22498:
		rts
; ---------------------------------------------------------------------------

loc_2249A:
		tst.w	$3A(a0)
		beq.s	loc_224B2
		subq.w	#1,$3A(a0)
		bne.w	locret_2255C
		move.w	#0,$38(a0)
		bra.w	locret_2255C
; ---------------------------------------------------------------------------

loc_224B2:
		tst.w	$38(a0)
		beq.s	loc_224D2
		subi.w	#$800,$36(a0)
		bcc.w	locret_2255C
		move.w	#0,$36(a0)
		move.w	#3*60,$3A(a0)
		bra.w	locret_2255C
; ---------------------------------------------------------------------------

loc_224D2:
		cmpi.w	#$1800,$36(a0)
		beq.w	locret_2255C
		addi.w	#$800,$36(a0)
		cmpi.w	#$1800,$36(a0)
		blo.s	locret_2255C
		move.w	#$1800,$36(a0)
		move.b	subtype(a0),d0
		andi.b	#$F0,d0
		cmpi.b	#$E0,d0
		bne.s	loc_2252A
		addi.w	#$16,y_pos(a0)
		bchg	#1,status(a0)
		bchg	#1,render_flags(a0)
		andi.b	#$F,subtype(a0)
		ori.b	#$F0,subtype(a0)
		move.l	#loc_222A0,(a0)
		movea.w	$3E(a0),a1
		neg.w	$32(a1)

loc_2252A:
		cmpi.b	#$F0,d0
		bne.s	locret_2255C
		subi.w	#$16,y_pos(a0)
		bchg	#1,status(a0)
		bchg	#1,render_flags(a0)
		andi.b	#$F,subtype(a0)
		ori.b	#$E0,subtype(a0)
		move.l	#loc_222A0,(a0)
		movea.w	$3E(a0),a1
		neg.w	$32(a1)

locret_2255C:
		rts
; End of function sub_2236A

; ---------------------------------------------------------------------------

loc_2255E:
		movea.w	$3E(a0),a1
		move.w	x_pos(a1),d2
		move.w	y_pos(a1),d3
		add.w	$30(a0),d2
		add.w	$32(a0),d3
		move.w	d2,x_pos(a0)
		move.w	d3,y_pos(a0)
		move.b	subtype(a0),d1
		bpl.s	loc_22594
		andi.w	#$F,d1
		lea	(Level_trigger_array).w,a3
		tst.b	(a3,d1.w)
		beq.s	loc_22594
		move.w	#1,$38(a1)

loc_22594:
		moveq	#0,d1
		move.b	width_pixels(a0),d1
		addi.w	#7,d1
		moveq	#0,d2
		move.b	height_pixels(a0),d2
		move.w	d2,d3
		addq.w	#1,d3
		move.w	x_pos(a0),d4
		jsr	(SolidObjectFull).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_225B8:
		move.b	subtype(a0),d1
		bpl.s	locret_225D6
		andi.w	#$F,d1
		lea	(Level_trigger_array).w,a3
		tst.b	(a3,d1.w)
		beq.s	locret_225D6
		movea.w	$3E(a0),a1
		move.w	#1,$38(a1)

locret_225D6:
		rts
; ---------------------------------------------------------------------------
Map_2PRetractingSpring:
		include "General/Sprites/Level Misc/Map - 2P Retracting Spring.asm"

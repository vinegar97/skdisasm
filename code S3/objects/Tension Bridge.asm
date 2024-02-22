Obj_TensionBridge:
		move.l	#loc_37DDE,(a0)
		move.l	#Map_TensionBridge,mappings(a0)
		move.w	#make_art_tile($038,2,0),art_tile(a0)
		move.w	#$200,priority(a0)
		cmpi.b	#5,(Current_zone).w
		bne.s	loc_37CDC
		move.l	#loc_37E80,(a0)
		move.l	#Map_ICZTensionBridge,mappings(a0)
		move.w	#make_art_tile($3B6,2,0),art_tile(a0)
		tst.b	subtype(a0)
		bpl.s	loc_37CDC
		move.l	#loc_37F44,(a0)
		andi.b	#$7F,subtype(a0)

loc_37CDC:
		tst.b	subtype(a0)
		bpl.s	loc_37CEE
		move.l	#loc_37DB4,(a0)
		andi.b	#$7F,subtype(a0)

loc_37CEE:
		move.b	#4,render_flags(a0)
		move.b	#$80,width_pixels(a0)
		move.b	#8,height_pixels(a0)
		move.w	y_pos(a0),d2
		move.w	d2,$3C(a0)
		move.w	x_pos(a0),d3
		lea	subtype(a0),a2
		moveq	#0,d1
		move.b	(a2),d1
		move.w	d1,d0
		lsr.w	#1,d0
		lsl.w	#4,d0
		sub.w	d0,d3
		swap	d1
		move.w	#8,d1
		bsr.s	sub_37D54
		move.w	$30(a1),d0
		subq.w	#8,d0
		move.w	d0,x_pos(a1)
		move.l	a1,$30(a0)
		swap	d1
		subq.w	#8,d1
		bls.s	loc_37D50
		move.w	d1,d4
		bsr.s	sub_37D54
		move.l	a1,$34(a0)
		move.w	d4,d0
		add.w	d0,d0
		add.w	d4,d0
		move.w	sub2_x_pos(a1,d0.w),d0
		subq.w	#8,d0
		move.w	d0,x_pos(a1)

loc_37D50:
		bra.w	loc_37DDE

; =============== S U B R O U T I N E =======================================


sub_37D54:
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	locret_37DB2
		move.l	#loc_37E7A,(a1)
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		move.l	mappings(a0),mappings(a1)
		move.w	art_tile(a0),art_tile(a1)
		move.b	render_flags(a0),render_flags(a1)
		move.w	priority(a0),priority(a1)
		bset	#6,render_flags(a1)
		move.b	#$40,width_pixels(a1)
		move.b	#8,height_pixels(a1)
		move.w	d1,mainspr_childsprites(a1)
		subq.b	#1,d1
		lea	sub2_x_pos(a1),a2

loc_37DA2:
		move.w	d3,(a2)+
		move.w	d2,(a2)+
		move.w	#0,(a2)+
		addi.w	#$10,d3
		dbf	d1,loc_37DA2

locret_37DB2:
		rts
; End of function sub_37D54

; ---------------------------------------------------------------------------

loc_37DB4:
		move.b	subtype(a0),d0
		andi.w	#$F,d0
		lea	(Level_trigger_array).w,a3
		lea	(a3,d0.w),a3
		tst.b	(a3)
		beq.s	loc_37DDE
		move.l	#loc_37F0A,(a0)
		move.b	#$E,$34(a0)
		move.l	#loc_37EE2,d4
		bra.w	loc_37FC6
; ---------------------------------------------------------------------------

loc_37DDE:
		move.b	status(a0),d0
		andi.b	#standing_mask,d0
		bne.s	loc_37DF4
		tst.b	$3E(a0)
		beq.s	loc_37E20
		subq.b	#4,$3E(a0)
		bra.s	loc_37E1C
; ---------------------------------------------------------------------------

loc_37DF4:
		andi.b	#$10,d0
		beq.s	loc_37E10
		move.b	$3F(a0),d0
		sub.b	$3B(a0),d0
		beq.s	loc_37E10
		bcc.s	loc_37E0C
		addq.b	#1,$3F(a0)
		bra.s	loc_37E10
; ---------------------------------------------------------------------------

loc_37E0C:
		subq.b	#1,$3F(a0)

loc_37E10:
		cmpi.b	#$40,$3E(a0)
		beq.s	loc_37E1C
		addq.b	#4,$3E(a0)

loc_37E1C:
		bsr.w	sub_382C0

loc_37E20:
		moveq	#0,d1
		move.b	subtype(a0),d1
		lsl.w	#3,d1
		move.w	d1,d2
		addq.w	#8,d1
		add.w	d2,d2
		moveq	#8,d3
		move.w	x_pos(a0),d4
		bsr.w	sub_38086

loc_37E38:
		move.w	x_pos(a0),d0
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.s	loc_37E4C
		rts
; ---------------------------------------------------------------------------

loc_37E4C:
		movea.l	$30(a0),a1
		jsr	(Delete_Referenced_Sprite).l
		cmpi.b	#8,subtype(a0)
		bls.s	loc_37E68
		movea.l	$34(a0),a1
		jsr	(Delete_Referenced_Sprite).l

loc_37E68:
		move.w	respawn_addr(a0),d0
		beq.s	loc_37E74
		movea.w	d0,a2
		bclr	#7,(a2)

loc_37E74:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_37E7A:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_37E80:
		move.b	status(a0),d0
		andi.b	#standing_mask,d0
		bne.s	loc_37E96
		tst.b	$3E(a0)
		beq.s	loc_37EC2
		subq.b	#4,$3E(a0)
		bra.s	loc_37EBE
; ---------------------------------------------------------------------------

loc_37E96:
		andi.b	#p2_standing,d0
		beq.s	loc_37EB2
		move.b	$3F(a0),d0
		sub.b	$3B(a0),d0
		beq.s	loc_37EB2
		bcc.s	loc_37EAE
		addq.b	#1,$3F(a0)
		bra.s	loc_37EB2
; ---------------------------------------------------------------------------

loc_37EAE:
		subq.b	#1,$3F(a0)

loc_37EB2:
		cmpi.b	#$40,$3E(a0)
		beq.s	loc_37EBE
		addq.b	#4,$3E(a0)

loc_37EBE:
		bsr.w	sub_382C0

loc_37EC2:
		moveq	#0,d1
		move.b	subtype(a0),d1
		lsl.w	#3,d1
		move.w	d1,d2
		addq.w	#8,d1
		add.w	d2,d2
		moveq	#8,d3
		move.w	x_pos(a0),d4
		bsr.w	sub_38086
		bsr.w	sub_38210
		bra.w	loc_37E38
; ---------------------------------------------------------------------------

loc_37EE2:
		tst.b	$34(a0)
		beq.s	loc_37EF2
		subq.b	#1,$34(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_37EF2:
		jsr	(MoveSprite).l
		tst.b	render_flags(a0)
		bpl.s	loc_37F04
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_37F04:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_37F0A:
		tst.b	$34(a0)
		beq.s	loc_37F16
		subq.b	#1,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_37F16:
		bclr	#p1_standing_bit,status(a0)
		beq.s	loc_37F2A
		bclr	#Status_OnObj,(Player_1+status).w
		bset	#Status_InAir,(Player_1+status).w

loc_37F2A:
		bclr	#p2_standing_bit,status(a0)
		beq.s	loc_37F3E
		bclr	#Status_OnObj,(Player_2+status).w
		bset	#Status_InAir,(Player_2+status).w

loc_37F3E:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_37F44:
		bsr.w	sub_38372
		move.l	#loc_37F4E,(a0)

loc_37F4E:
		move.b	status(a0),d0
		andi.b	#standing_mask,d0
		bne.s	loc_37F64
		tst.b	$3E(a0)
		beq.s	loc_37FA6
		subq.b	#4,$3E(a0)
		bra.s	loc_37FA2
; ---------------------------------------------------------------------------

loc_37F64:
		moveq	#0,d1
		move.b	subtype(a0),d1
		lsl.w	#3,d1
		move.w	d1,d2
		addq.w	#8,d1
		add.w	d2,d2
		bsr.w	sub_381D6
		move.b	status(a0),d0
		andi.b	#p2_standing,d0
		beq.s	loc_37F96
		move.b	$3F(a0),d0
		sub.b	$3B(a0),d0
		beq.s	loc_37F96
		bcc.s	loc_37F92
		addq.b	#1,$3F(a0)
		bra.s	loc_37F96
; ---------------------------------------------------------------------------

loc_37F92:
		subq.b	#1,$3F(a0)

loc_37F96:
		cmpi.b	#$40,$3E(a0)
		beq.s	loc_37FA2
		addq.b	#4,$3E(a0)

loc_37FA2:
		bsr.w	sub_38372

loc_37FA6:
		moveq	#0,d1
		move.b	subtype(a0),d1
		lsl.w	#3,d1
		move.w	d1,d2
		addq.w	#8,d1
		add.w	d2,d2
		moveq	#8,d3
		move.w	x_pos(a0),d4
		bsr.w	sub_38128
		bsr.w	sub_38210
		bra.w	loc_37E38
; ---------------------------------------------------------------------------

loc_37FC6:
		movea.l	$30(a0),a3
		bsr.s	sub_37FDC
		cmpi.b	#8,subtype(a0)
		bls.s	locret_37FDA
		movea.l	$34(a0),a3
		bsr.s	sub_37FDC

locret_37FDA:
		rts

; =============== S U B R O U T I N E =======================================


sub_37FDC:
		lea	(byte_38076).l,a4
		lea	sub2_x_pos(a3),a2
		move.w	mainspr_childsprites(a3),d6
		subq.w	#1,d6
		bclr	#6,render_flags(a3)
		movea.l	a3,a1
		bra.s	loc_37FFE
; ---------------------------------------------------------------------------

loc_37FF6:
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	loc_38062

loc_37FFE:
		move.l	d4,(a1)
		move.l	mappings(a3),mappings(a1)
		move.b	render_flags(a3),render_flags(a1)
		move.w	art_tile(a3),art_tile(a1)
		move.w	priority(a3),priority(a1)
		move.b	width_pixels(a3),width_pixels(a1)
		move.b	height_pixels(a3),height_pixels(a1)
		move.w	priority(a3),priority(a1)
		move.w	(a2)+,x_pos(a1)
		move.w	(a2)+,y_pos(a1)
		move.w	(a2)+,d0
		move.b	d0,mapping_frame(a1)
		move.b	(a4)+,$34(a1)
		movea.l	a1,a5
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	loc_38062
		move.l	#loc_1C31E,(a1)
		move.w	x_pos(a5),x_pos(a1)
		move.w	y_pos(a5),y_pos(a1)
		move.b	-1(a4),$24(a1)
		dbf	d6,loc_37FF6

loc_38062:
		move.w	#0,sub2_x_pos(a3)
		move.w	#0,sub2_y_pos(a3)
		moveq	#signextendB(sfx_BridgeCollapse),d0
		jmp	(Play_SFX).l
; End of function sub_37FDC

; ---------------------------------------------------------------------------
byte_38076:
		dc.b    8, $10,  $C,  $E,   6,  $A,   4,   2
		dc.b    8, $10,  $C,  $E,   6,  $A,   4,   2

; =============== S U B R O U T I N E =======================================


sub_38086:
		lea	(Player_2).w,a1
		moveq	#p2_standing_bit,d6
		moveq	#$3B,d5
		movem.l	d1-d4,-(sp)
		bsr.s	sub_380A0
		movem.l	(sp)+,d1-d4
		lea	(Player_1).w,a1
		subq.b	#p2_standing_bit-p1_standing_bit,d6
		moveq	#$3F,d5
; End of function sub_38086


; =============== S U B R O U T I N E =======================================


sub_380A0:
		btst	d6,status(a0)
		beq.s	loc_38104
		btst	#Status_InAir,status(a1)
		bne.s	loc_380C0
		moveq	#0,d0
		move.w	x_pos(a1),d0
		sub.w	x_pos(a0),d0
		add.w	d1,d0
		bmi.s	loc_380C0
		cmp.w	d2,d0
		blo.s	loc_380CE

loc_380C0:
		bclr	#Status_OnObj,status(a1)
		bclr	d6,status(a0)
		moveq	#0,d4
		rts
; ---------------------------------------------------------------------------

loc_380CE:
		lsr.w	#4,d0
		move.b	d0,(a0,d5.w)
		movea.l	$30(a0),a2
		cmpi.w	#8,d0
		blo.s	loc_380E6
		movea.l	$34(a0),a2
		subi.w	#8,d0

loc_380E6:
		add.w	d0,d0
		move.w	d0,d1
		add.w	d0,d0
		add.w	d1,d0
		move.w	sub2_y_pos(a2,d0.w),d0
		subq.w	#8,d0
		moveq	#0,d1
		move.b	y_radius(a1),d1
		sub.w	d1,d0
		move.w	d0,y_pos(a1)
		moveq	#0,d4
		rts
; ---------------------------------------------------------------------------

loc_38104:
		move.w	d1,-(sp)
		jsr	(sub_1C0BE).l
		move.w	(sp)+,d1
		btst	d6,status(a0)
		beq.s	locret_38126
		moveq	#0,d0
		move.w	x_pos(a1),d0
		sub.w	x_pos(a0),d0
		add.w	d1,d0
		lsr.w	#4,d0
		move.b	d0,(a0,d5.w)

locret_38126:
		rts
; End of function sub_380A0


; =============== S U B R O U T I N E =======================================


sub_38128:
		lea	(Player_2).w,a1
		moveq	#p2_standing_bit,d6
		moveq	#$3B,d5
		movem.l	d1-d4,-(sp)
		bsr.s	sub_38142
		movem.l	(sp)+,d1-d4
		lea	(Player_1).w,a1
		subq.b	#p2_standing_bit-p1_standing_bit,d6
		moveq	#$3F,d5
; End of function sub_38128


; =============== S U B R O U T I N E =======================================


sub_38142:
		btst	d6,status(a0)
		beq.s	loc_381A2
		btst	#Status_InAir,status(a1)
		bne.s	loc_38162
		moveq	#0,d0
		move.w	x_pos(a1),d0
		sub.w	x_pos(a0),d0
		add.w	d1,d0
		bmi.s	loc_38162
		cmp.w	d2,d0
		blo.s	loc_38170

loc_38162:
		bclr	#Status_OnObj,status(a1)
		bclr	d6,status(a0)
		moveq	#0,d4
		rts
; ---------------------------------------------------------------------------

loc_38170:
		lsr.w	#4,d0
		movea.l	$30(a0),a2
		cmpi.w	#8,d0
		blo.s	loc_38184
		movea.l	$34(a0),a2
		subi.w	#8,d0

loc_38184:
		add.w	d0,d0
		move.w	d0,d1
		add.w	d0,d0
		add.w	d1,d0
		move.w	sub2_y_pos(a2,d0.w),d0
		subq.w	#8,d0
		moveq	#0,d1
		move.b	y_radius(a1),d1
		sub.w	d1,d0
		move.w	d0,y_pos(a1)
		moveq	#0,d4
		rts
; ---------------------------------------------------------------------------

loc_381A2:
		bsr.s	sub_381A6
		rts
; End of function sub_38142


; =============== S U B R O U T I N E =======================================


sub_381A6:
		tst.w	y_vel(a1)
		bmi.s	locret_381D4
		move.w	x_pos(a1),d0
		sub.w	x_pos(a0),d0
		add.w	d1,d0
		bmi.s	locret_381D4
		cmp.w	d2,d0
		bhs.s	locret_381D4
		lsr.w	#4,d0
		move.w	d0,d3
		add.w	d0,d0
		add.w	d0,d3
		neg.w	d3
		addq.w	#8,d3
		move.w	y_pos(a0),d0
		sub.w	d3,d0
		jmp	(loc_1C100).l
; ---------------------------------------------------------------------------

locret_381D4:
		rts
; End of function sub_381A6


; =============== S U B R O U T I N E =======================================


sub_381D6:
		lea	(Player_2).w,a1
		moveq	#p2_standing_bit,d6
		moveq	#$3B,d5
		bsr.s	sub_381E8
		lea	(Player_1).w,a1
		subq.b	#p2_standing_bit-p1_standing_bit,d6
		moveq	#$3F,d5
; End of function sub_381D6


; =============== S U B R O U T I N E =======================================


sub_381E8:
		btst	d6,status(a0)
		beq.s	locret_3820E
		btst	#Status_InAir,status(a1)
		bne.s	locret_3820E
		moveq	#0,d0
		move.w	x_pos(a1),d0
		sub.w	x_pos(a0),d0
		add.w	d1,d0
		bmi.s	locret_3820E
		cmp.w	d2,d0
		bhs.s	locret_3820E
		lsr.w	#4,d0
		move.b	d0,(a0,d5.w)

locret_3820E:
		rts
; End of function sub_381E8


; =============== S U B R O U T I N E =======================================


sub_38210:
		movea.l	$30(a0),a1
		lea	sub2_mapframe(a1),a1
		movea.l	$34(a0),a2
		lea	sub2_mapframe(a2),a2
		moveq	#-2,d3
		moveq	#-2,d4
		move.b	status(a0),d0
		andi.w	#p1_standing,d0
		beq.s	loc_3823C
		tst.w	(Player_1+x_vel).w
		beq.s	loc_3823C
		move.b	$3F(a0),d0
		bsr.w	sub_3828C

loc_3823C:
		move.b	status(a0),d0
		andi.w	#p2_standing,d0
		beq.s	loc_38254
		tst.w	(Player_2+x_vel).w
		beq.s	loc_38254
		move.b	$3B(a0),d0
		bsr.w	sub_3828C

loc_38254:
		movea.l	$30(a0),a1
		lea	$4D(a1),a2
		lea	sub2_mapframe(a1),a1
		moveq	#0,d1
		move.b	subtype(a0),d1
		subq.b	#1,d1

loc_38268:
		tst.b	(a1)
		beq.s	loc_38278
		addq.b	#1,(a1)
		cmpi.b	#$C,(a1)
		blo.s	loc_38278
		move.b	#0,(a1)

loc_38278:
		addq.w	#next_subspr,a1
		cmpa.w	a2,a1
		bne.s	loc_38286
		movea.l	$34(a0),a1
		lea	sub2_mapframe(a1),a1

loc_38286:
		dbf	d1,loc_38268
		rts
; End of function sub_38210


; =============== S U B R O U T I N E =======================================


sub_3828C:
		cmpi.b	#8,d0
		bhs.s	loc_382A8
		move.w	d0,d1
		add.w	d0,d0
		add.w	d1,d0
		add.w	d0,d0
		tst.b	(a1,d0.w)
		bne.s	locret_382A6
		move.b	#1,(a1,d0.w)

locret_382A6:
		rts
; ---------------------------------------------------------------------------

loc_382A8:
		subq.w	#8,d0
		move.w	d0,d1
		add.w	d0,d0
		add.w	d1,d0
		add.w	d0,d0
		tst.b	(a2,d0.w)
		bne.s	locret_382BE
		move.b	#1,(a2,d0.w)

locret_382BE:
		rts
; End of function sub_3828C


; =============== S U B R O U T I N E =======================================


sub_382C0:
		move.b	$3E(a0),d0
		jsr	(GetSineCosine).l
		move.w	d0,d4
		lea	(BridgeBendData).l,a4
		moveq	#0,d0
		move.b	subtype(a0),d0
		lsl.w	#4,d0
		moveq	#0,d3
		move.b	$3F(a0),d3
		move.w	d3,d2
		add.w	d0,d3
		moveq	#0,d5
		lea	(byte_38428-$80).l,a5
		move.b	(a5,d3.w),d5
		andi.w	#$F,d3
		lsl.w	#4,d3
		lea	(a4,d3.w),a3
		movea.l	$30(a0),a1
		lea	next_object(a1),a2
		lea	sub2_y_pos(a1),a1

loc_38306:
		moveq	#0,d0
		move.b	(a3)+,d0
		addq.w	#1,d0
		mulu.w	d5,d0
		mulu.w	d4,d0
		swap	d0
		add.w	$3C(a0),d0
		move.w	d0,(a1)
		addq.w	#next_subspr,a1
		cmpa.w	a2,a1
		bne.s	loc_38326
		movea.l	$34(a0),a1
		lea	sub2_y_pos(a1),a1

loc_38326:
		dbf	d2,loc_38306
		moveq	#0,d0
		move.b	subtype(a0),d0
		moveq	#0,d3
		move.b	$3F(a0),d3
		addq.b	#1,d3
		sub.b	d0,d3
		neg.b	d3
		bmi.s	locret_38370
		move.w	d3,d2
		lsl.w	#4,d3
		lea	(a4,d3.w),a3
		adda.w	d2,a3
		subq.w	#1,d2
		bcs.s	locret_38370

loc_3834C:
		moveq	#0,d0
		move.b	-(a3),d0
		addq.w	#1,d0
		mulu.w	d5,d0
		mulu.w	d4,d0
		swap	d0
		add.w	$3C(a0),d0
		move.w	d0,(a1)
		addq.w	#next_subspr,a1
		cmpa.w	a2,a1
		bne.s	loc_3836C
		movea.l	$34(a0),a1
		lea	sub2_y_pos(a1),a1

loc_3836C:
		dbf	d2,loc_3834C

locret_38370:
		rts
; End of function sub_382C0


; =============== S U B R O U T I N E =======================================


sub_38372:
		move.b	$3E(a0),d0
		jsr	(GetSineCosine).l
		move.w	d0,d4
		lea	(BridgeBendData).l,a4
		moveq	#0,d0
		move.b	subtype(a0),d0
		lsl.w	#4,d0
		moveq	#0,d3
		move.b	$3F(a0),d3
		move.w	d3,d2
		add.w	d0,d3
		moveq	#0,d5
		lea	(byte_38428-$80).l,a5
		move.b	(a5,d3.w),d5
		andi.w	#$F,d3
		lsl.w	#4,d3
		lea	(a4,d3.w),a3
		move.w	$3C(a0),d6
		movea.l	$30(a0),a1
		lea	next_object(a1),a2
		lea	sub2_y_pos(a1),a1

loc_383BC:
		moveq	#0,d0
		move.b	(a3)+,d0
		addq.w	#1,d0
		mulu.w	d5,d0
		mulu.w	d4,d0
		swap	d0
		add.w	d6,d0
		addq.w	#3,d6
		move.w	d0,(a1)
		addq.w	#next_subspr,a1
		cmpa.w	a2,a1
		bne.s	loc_383DC
		movea.l	$34(a0),a1
		lea	sub2_y_pos(a1),a1

loc_383DC:
		dbf	d2,loc_383BC
		moveq	#0,d0
		move.b	subtype(a0),d0
		moveq	#0,d3
		move.b	$3F(a0),d3
		addq.b	#1,d3
		sub.b	d0,d3
		neg.b	d3
		bmi.s	locret_38426
		move.w	d3,d2
		lsl.w	#4,d3
		lea	(a4,d3.w),a3
		adda.w	d2,a3
		subq.w	#1,d2
		bcs.s	locret_38426

loc_38402:
		moveq	#0,d0
		move.b	-(a3),d0
		addq.w	#1,d0
		mulu.w	d5,d0
		mulu.w	d4,d0
		swap	d0
		add.w	d6,d0
		addq.w	#3,d6
		move.w	d0,(a1)
		addq.w	#6,a1
		cmpa.w	a2,a1
		bne.s	loc_38422
		movea.l	$34(a0),a1
		lea	sub2_y_pos(a1),a1

loc_38422:
		dbf	d2,loc_38402

locret_38426:
		rts
; End of function sub_38372

; ---------------------------------------------------------------------------
byte_38428:
		dc.b    2,   4,   6,   8,   8,   6,   4,   2,   0,   0,   0,   0,   0,   0,   0,   0
		dc.b    2,   4,   6,   8,  $A,   8,   6,   4,   2,   0,   0,   0,   0,   0,   0,   0
		dc.b    2,   4,   6,   8,  $A,  $A,   8,   6,   4,   2,   0,   0,   0,   0,   0,   0
		dc.b    2,   4,   6,   8,  $A,  $C,  $A,   8,   6,   4,   2,   0,   0,   0,   0,   0
		dc.b    2,   4,   6,   8,  $A,  $C,  $C,  $A,   8,   6,   4,   2,   0,   0,   0,   0
		dc.b    2,   4,   6,   8,  $A,  $C,  $E,  $C,  $A,   8,   6,   4,   2,   0,   0,   0
		dc.b    2,   4,   6,   8,  $A,  $C,  $E,  $E,  $C,  $A,   8,   6,   4,   2,   0,   0
		dc.b    2,   4,   6,   8,  $A,  $C,  $E, $10,  $E,  $C,  $A,   8,   6,   4,   2,   0
		dc.b    2,   4,   6,   8,  $A,  $C,  $E, $10, $10,  $E,  $C,  $A,   8,   6,   4,   2
BridgeBendData:
		dc.b  $FF,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0
		dc.b  $B5, $FF,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0
		dc.b  $7E, $DB, $FF,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0
		dc.b  $61, $B5, $EC, $FF,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0
		dc.b  $4A, $93, $CD, $F3, $FF,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0
		dc.b  $3E, $7E, $B0, $DB, $F6, $FF,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0
		dc.b  $38, $6D, $9D, $C5, $E4, $F8, $FF,   0,   0,   0,   0,   0,   0,   0,   0,   0
		dc.b  $31, $61, $8E, $B5, $D4, $EC, $FB, $FF,   0,   0,   0,   0,   0,   0,   0,   0
		dc.b  $2B, $56, $7E, $A2, $C1, $DB, $EE, $FB, $FF,   0,   0,   0,   0,   0,   0,   0
		dc.b  $25, $4A, $73, $93, $B0, $CD, $E1, $F3, $FC, $FF,   0,   0,   0,   0,   0,   0
		dc.b  $1F, $44, $67, $88, $A7, $BD, $D4, $E7, $F4, $FD, $FF,   0,   0,   0,   0,   0
		dc.b  $1F, $3E, $5C, $7E, $98, $B0, $C9, $DB, $EA, $F6, $FD, $FF,   0,   0,   0,   0
		dc.b  $19, $38, $56, $73, $8E, $A7, $BD, $D1, $E1, $EE, $F8, $FE, $FF,   0,   0,   0
		dc.b  $19, $38, $50, $6D, $83, $9D, $B0, $C5, $D8, $E4, $F1, $F8, $FE, $FF,   0,   0
		dc.b  $19, $31, $4A, $67, $7E, $93, $A7, $BD, $CD, $DB, $E7, $F3, $F9, $FE, $FF,   0
		dc.b  $19, $31, $4A, $61, $78, $8E, $A2, $B5, $C5, $D4, $E1, $EC, $F4, $FB, $FE, $FF
Map_ICZTensionBridge:
		include "Levels/ICZ/Misc Object Data/Map - ICZ Tension Bridge.asm"
Map_TensionBridge:
		include "Levels/Misc/Map - Tension Bridge.asm"
; ---------------------------------------------------------------------------
byte_38604:
		dc.b    2,   4,   4,   4,   4,   4,  $C,   0
		even
byte_3860C:
		dc.b    2,   4,   6,   6,   6,   6,   8,   8,   8,   8,  $A,  $A,   0
		even
byte_3861A:
		dc.b    2,   4,   6,   6,   6,   6,   8,   8,   8,   8,  $A,   0
		even
byte_38626:
		dc.b    2,   4,   6,   6,   6,   6,   8,   8,   8,   8,   8,   8,   8,   8,   8,   8,   8,   8,  $E,   0
		even
; ---------------------------------------------------------------------------

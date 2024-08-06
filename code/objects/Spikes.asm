byte_23F74:
		dc.b  $10, $10
		dc.b  $20, $10
		dc.b  $30, $10
		dc.b  $40, $10
		dc.b  $10, $10
		dc.b  $10, $20
		dc.b  $10, $30
		dc.b  $10, $40
		even
; ---------------------------------------------------------------------------

Obj_Spikes:
		ori.b	#4,render_flags(a0)
		move.w	#$200,priority(a0)
		move.b	subtype(a0),d0
		andi.w	#$F0,d0
		lsr.w	#3,d0
		tst.w	(Competition_mode).w
		bne.w	loc_24034
		lea	byte_23F74(pc,d0.w),a1
		move.b	(a1)+,width_pixels(a0)
		move.b	(a1)+,height_pixels(a0)
		move.l	#loc_24090,(a0)
		move.l	#Map_Spikes,mappings(a0)
		move.w	#make_art_tile($49C,0,0),art_tile(a0)
		cmpi.b	#4,(Current_zone).w
		bne.s	+ ;loc_23FD0
		move.w	#make_art_tile($200,0,0),art_tile(a0)

+ ;loc_23FD0:
		lsr.w	#1,d0
		move.b	d0,mapping_frame(a0)
		cmpi.b	#4,d0
		blo.s	+ ;loc_23FE8
		move.l	#loc_240E2,(a0)
		move.w	#make_art_tile($494,0,0),art_tile(a0)

+ ;loc_23FE8:
		move.b	status(a0),d0
		tst.b	(Reverse_gravity_flag).w
		beq.s	+ ;loc_23FF6
		eori.b	#2,d0

+ ;loc_23FF6:
		andi.b	#2,d0
		beq.s	+ ;loc_24002
		move.l	#loc_2413E,(a0)

+ ;loc_24002:
		move.w	#$20,$3C(a0)
		move.w	x_pos(a0),$30(a0)
		move.w	y_pos(a0),$32(a0)
		move.b	subtype(a0),d0
		andi.b	#$F,d0
		add.b	d0,d0
		move.b	d0,$2C(a0)
		rts
; ---------------------------------------------------------------------------
byte_24024:
		dc.b   $C,  $C
		dc.b  $18,  $C
		dc.b  $24,  $C
		dc.b  $30,  $C
		dc.b   $C,  $C
		dc.b   $C, $18
		dc.b   $C, $24
		dc.b   $C, $30
; ---------------------------------------------------------------------------

loc_24034:
		lea	byte_24024(pc,d0.w),a1
		move.b	(a1)+,width_pixels(a0)
		move.b	(a1)+,height_pixels(a0)
		move.l	#loc_2418E,(a0)
		move.l	#Map_2PSpikes,mappings(a0)
		move.w	#make_art_tile($391,0,0),art_tile(a0)
		lsr.w	#1,d0
		move.b	d0,mapping_frame(a0)
		cmpi.b	#4,d0
		blo.s	+ ;loc_24066
		move.l	#loc_241DC,(a0)

+ ;loc_24066:
		btst	#1,status(a0)
		beq.s	+ ;loc_24074
		move.l	#loc_24234,(a0)

+ ;loc_24074:
		move.w	x_pos(a0),$30(a0)
		move.w	y_pos(a0),$32(a0)
		move.b	subtype(a0),d0
		andi.b	#$F,d0
		add.b	d0,d0
		move.b	d0,subtype(a0)
		rts
; ---------------------------------------------------------------------------

loc_24090:
		bsr.w	sub_242B6
		moveq	#0,d1
		move.b	width_pixels(a0),d1
		addi.w	#$B,d1
		moveq	#0,d2
		move.b	height_pixels(a0),d2
		move.w	d2,d3
		addq.w	#1,d3
		move.w	x_pos(a0),d4
		bsr.w	SolidObjectFull
		move.b	status(a0),d6
		andi.b	#standing_mask,d6
		beq.s	++ ;loc_240D8
		move.b	d6,d0
		andi.b	#p1_standing,d0
		beq.s	+ ;loc_240CA
		lea	(Player_1).w,a1
		bsr.w	sub_24280

+ ;loc_240CA:
		andi.b	#p2_standing,d6
		beq.s	+ ;loc_240D8
		lea	(Player_2).w,a1
		bsr.w	sub_24280

+ ;loc_240D8:
		move.w	$30(a0),d0
		jmp	(Sprite_OnScreen_Test2).l
; ---------------------------------------------------------------------------

loc_240E2:
		bsr.w	sub_242B6
		moveq	#0,d1
		move.b	width_pixels(a0),d1
		addi.w	#$B,d1
		moveq	#0,d2
		move.b	height_pixels(a0),d2
		move.w	d2,d3
		addq.w	#1,d3
		move.w	x_pos(a0),d4
		bsr.w	SolidObjectFull
		swap	d6
		andi.w	#1|2,d6
		beq.s	++ ;loc_24134
		move.b	d6,d0
		andi.b	#1,d0
		beq.s	+ ;loc_24120
		lea	(Player_1).w,a1
		bsr.w	sub_24280
		bclr	#p1_pushing_bit,status(a0)

+ ;loc_24120:
		andi.b	#2,d6
		beq.s	+ ;loc_24134
		lea	(Player_2).w,a1
		bsr.w	sub_24280
		bclr	#p2_pushing_bit,status(a0)

+ ;loc_24134:
		move.w	$30(a0),d0
		jmp	(Sprite_OnScreen_Test2).l
; ---------------------------------------------------------------------------

loc_2413E:
		bsr.w	sub_242B6
		moveq	#0,d1
		move.b	width_pixels(a0),d1
		addi.w	#$B,d1
		moveq	#0,d2
		move.b	height_pixels(a0),d2
		move.w	d2,d3
		addq.w	#1,d3
		move.w	x_pos(a0),d4
		bsr.w	SolidObjectFull
		swap	d6
		andi.w	#4|8,d6
		beq.s	++ ;loc_24184
		move.b	d6,d0
		andi.b	#4,d0
		beq.s	+ ;loc_24176
		lea	(Player_1).w,a1
		bsr.w	sub_24280

+ ;loc_24176:
		andi.b	#8,d6
		beq.s	+ ;loc_24184
		lea	(Player_2).w,a1
		bsr.w	sub_24280

+ ;loc_24184:
		move.w	$30(a0),d0
		jmp	(Sprite_OnScreen_Test2).l
; ---------------------------------------------------------------------------

loc_2418E:
		bsr.w	sub_243BA
		moveq	#0,d1
		move.b	width_pixels(a0),d1
		addi.w	#7,d1
		moveq	#0,d2
		move.b	height_pixels(a0),d2
		move.w	d2,d3
		addq.w	#1,d3
		move.w	x_pos(a0),d4
		bsr.w	SolidObjectFull
		move.b	status(a0),d6
		andi.b	#standing_mask,d6
		beq.s	++ ;loc_241D6
		move.b	d6,d0
		andi.b	#p1_standing,d0
		beq.s	+ ;loc_241C8
		lea	(Player_1).w,a1
		bsr.w	sub_24280

+ ;loc_241C8:
		andi.b	#p2_standing,d6
		beq.s	+ ;loc_241D6
		lea	(Player_2).w,a1
		bsr.w	sub_24280

+ ;loc_241D6:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_241DC:
		bsr.w	sub_243BA
		moveq	#0,d1
		move.b	width_pixels(a0),d1
		addi.w	#7,d1
		moveq	#0,d2
		move.b	height_pixels(a0),d2
		move.w	d2,d3
		addq.w	#1,d3
		move.w	x_pos(a0),d4
		bsr.w	SolidObjectFull
		swap	d6
		andi.w	#1|2,d6
		beq.s	++ ;loc_2422E
		move.b	d6,d0
		andi.b	#1,d0
		beq.s	+ ;loc_2421A
		lea	(Player_1).w,a1
		bsr.w	sub_24280
		bclr	#p1_pushing_bit,status(a0)

+ ;loc_2421A:
		andi.b	#2,d6
		beq.s	+ ;loc_2422E
		lea	(Player_2).w,a1
		bsr.w	sub_24280
		bclr	#p2_pushing_bit,status(a0)

+ ;loc_2422E:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_24234:
		bsr.w	sub_243BA
		moveq	#0,d1
		move.b	width_pixels(a0),d1
		addi.w	#7,d1
		moveq	#0,d2
		move.b	height_pixels(a0),d2
		move.w	d2,d3
		addq.w	#1,d3
		move.w	x_pos(a0),d4
		bsr.w	SolidObjectFull
		swap	d6
		andi.w	#4|8,d6
		beq.s	++ ;loc_2427A
		move.b	d6,d0
		andi.b	#4,d0
		beq.s	+ ;loc_2426C
		lea	(Player_1).w,a1
		bsr.w	sub_24280

+ ;loc_2426C:
		andi.b	#8,d6
		beq.s	+ ;loc_2427A
		lea	(Player_2).w,a1
		bsr.w	sub_24280

+ ;loc_2427A:
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_24280:
		btst	#Status_Invincible,status_secondary(a1)
		bne.s	locret_242B4
		tst.b	invulnerability_timer(a1)
		bne.s	locret_242B4
		cmpi.b	#4,routine(a1)
		bhs.s	locret_242B4
		move.l	y_pos(a1),d3
		move.w	y_vel(a1),d0
		ext.l	d0
		asl.l	#8,d0
		sub.l	d0,d3
		move.l	d3,y_pos(a1)
		movea.l	a0,a2
		movea.l	a1,a0
		jsr	(HurtCharacter).l
		movea.l	a2,a0

locret_242B4:
		rts
; End of function sub_24280


; =============== S U B R O U T I N E =======================================


sub_242B6:
		moveq	#0,d0
		move.b	subtype(a0),d0
		move.w	off_242C4(pc,d0.w),d1
		jmp	off_242C4(pc,d1.w)
; End of function sub_242B6

; ---------------------------------------------------------------------------
off_242C4:
		dc.w locret_242CC-off_242C4
		dc.w loc_242CE-off_242C4
		dc.w loc_242E2-off_242C4
		dc.w loc_24356-off_242C4
; ---------------------------------------------------------------------------

locret_242CC:
		rts
; ---------------------------------------------------------------------------

loc_242CE:
		bsr.w	sub_242F6
		moveq	#0,d0
		move.b	$34(a0),d0
		add.w	$32(a0),d0
		move.w	d0,y_pos(a0)
		rts
; ---------------------------------------------------------------------------

loc_242E2:
		bsr.w	sub_242F6
		moveq	#0,d0
		move.b	$34(a0),d0
		add.w	$30(a0),d0
		move.w	d0,x_pos(a0)
		rts

; =============== S U B R O U T I N E =======================================


sub_242F6:
		tst.w	$38(a0)
		beq.s	+ ;loc_24312
		subq.w	#1,$38(a0)
		bne.s	locret_24354
		tst.b	render_flags(a0)
		bpl.s	locret_24354
		moveq	#signextendB(sfx_SpikeMove),d0
		jsr	(Play_SFX).l
		bra.s	locret_24354
; ---------------------------------------------------------------------------

+ ;loc_24312:
		tst.w	$36(a0)
		beq.s	+ ;loc_24334
		subi.w	#$800,$34(a0)
		bcc.s	locret_24354
		move.w	#0,$34(a0)
		move.w	#0,$36(a0)
		move.w	#60,$38(a0)
		bra.s	locret_24354
; ---------------------------------------------------------------------------

+ ;loc_24334:
		addi.w	#$800,$34(a0)
		cmpi.w	#$2000,$34(a0)
		blo.s	locret_24354
		move.w	#$2000,$34(a0)
		move.w	#1,$36(a0)
		move.w	#60,$38(a0)

locret_24354:
		rts
; End of function sub_242F6

; ---------------------------------------------------------------------------

loc_24356:
		move.b	status(a0),d3
		andi.b	#pushing_mask,d3
		beq.s	+ ;loc_2437C
		move.w	x_pos(a0),d2
		lea	(Player_1).w,a1
		move.b	$3E(a0),d0
		moveq	#5,d6
		bsr.s	++ ;sub_2438A
		lea	(Player_2).w,a1
		move.b	$3F(a0),d0
		moveq	#6,d6
		bsr.s	++ ;sub_2438A

+ ;loc_2437C:
		move.b	(Player_1+status).w,$3E(a0)
		move.b	(Player_2+status).w,$3F(a0)
		rts

; =============== S U B R O U T I N E =======================================


+ ;sub_2438A:
		btst	d6,d3
		beq.s	locret_243B8
		cmp.w	x_pos(a1),d2
		blo.s	locret_243B8
		btst	#5,d0
		beq.s	locret_243B8
		subq.w	#1,$3A(a0)
		bpl.s	locret_243B8
		move.w	#$10,$3A(a0)
		tst.w	$3C(a0)
		beq.s	locret_243B8
		subq.w	#1,$3C(a0)
		addq.w	#1,x_pos(a0)
		addq.w	#1,x_pos(a1)

locret_243B8:
		rts
; End of function sub_2438A


; =============== S U B R O U T I N E =======================================


sub_243BA:
		moveq	#0,d0
		move.b	subtype(a0),d0
		move.w	word_243C8(pc,d0.w),d1
		jmp	word_243C8(pc,d1.w)
; End of function sub_243BA

; ---------------------------------------------------------------------------
word_243C8:
		dc.w locret_242CC-word_243C8
		dc.w loc_243CE-word_243C8
		dc.w loc_243E2-word_243C8
; ---------------------------------------------------------------------------

loc_243CE:
		bsr.w	sub_243F6
		moveq	#0,d0
		move.b	$34(a0),d0
		add.w	$32(a0),d0
		move.w	d0,y_pos(a0)
		rts
; ---------------------------------------------------------------------------

loc_243E2:
		bsr.w	sub_243F6
		moveq	#0,d0
		move.b	$34(a0),d0
		add.w	$30(a0),d0
		move.w	d0,x_pos(a0)
		rts

; =============== S U B R O U T I N E =======================================


sub_243F6:
		tst.w	$38(a0)
		beq.s	+ ;loc_24412
		subq.w	#1,$38(a0)
		bne.s	locret_24454
		tst.b	render_flags(a0)
		bpl.s	locret_24454
		moveq	#signextendB(sfx_SpikeMove),d0
		jsr	(Play_SFX).l
		bra.s	locret_24454
; ---------------------------------------------------------------------------

+ ;loc_24412:
		tst.w	$36(a0)
		beq.s	+ ;loc_24434
		subi.w	#$800,$34(a0)
		bcc.s	locret_24454
		move.w	#0,$34(a0)
		move.w	#0,$36(a0)
		move.w	#60,$38(a0)
		bra.s	locret_24454
; ---------------------------------------------------------------------------

+ ;loc_24434:
		addi.w	#$800,$34(a0)
		cmpi.w	#$1800,$34(a0)
		blo.s	locret_24454
		move.w	#$1800,$34(a0)
		move.w	#1,$36(a0)
		move.w	#60,$38(a0)

locret_24454:
		rts
; End of function sub_243F6

; ---------------------------------------------------------------------------
Map_Spikes:
		include "General/Sprites/Level Misc/Map - Spikes.asm"
Map_2PSpikes:
		include "General/2P Zone/Map - Spikes.asm"

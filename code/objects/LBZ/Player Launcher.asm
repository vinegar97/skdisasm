word_2612C:
		dc.w $1000
		dc.w  $A00
; ---------------------------------------------------------------------------

Obj_LBZPlayerLauncher:
		move.l	#Map_LBZPlayerLauncher,mappings(a0)
		move.w	#make_art_tile($3C3,2,0),art_tile(a0)
		ori.b	#4,render_flags(a0)
		move.b	#$20,width_pixels(a0)
		move.w	#$80,priority(a0)
		move.b	subtype(a0),d0
		andi.w	#2,d0
		move.w	word_2612C(pc,d0.w),$34(a0)
		move.l	#loc_26164,(a0)

loc_26164:
		move.w	x_pos(a0),d0
		move.w	d0,d1
		subi.w	#$10,d0
		addi.w	#$10,d1
		move.w	y_pos(a0),d2
		move.w	d2,d3
		subi.w	#$10,d2
		addi.w	#$10,d3
		lea	(Player_1).w,a1
		btst	#Status_InAir,status(a1)
		bne.s	+ ;loc_261B8
		move.w	x_pos(a1),d4
		cmp.w	d0,d4
		blo.w	+ ;loc_261B8
		cmp.w	d1,d4
		bhs.w	+ ;loc_261B8
		move.w	y_pos(a1),d4
		cmp.w	d2,d4
		blo.w	+ ;loc_261B8
		cmp.w	d3,d4
		bhs.w	+ ;loc_261B8
		move.w	d0,-(sp)
		lea	$38(a0),a2
		bsr.w	+++ ;sub_261F2
		move.w	(sp)+,d0

+ ;loc_261B8:
		lea	(Player_2).w,a1
		btst	#Status_InAir,status(a1)
		bne.s	+ ;loc_261EC
		move.w	x_pos(a1),d4
		cmp.w	d0,d4
		blo.w	+ ;loc_261EC
		cmp.w	d1,d4
		bhs.w	+ ;loc_261EC
		move.w	y_pos(a1),d4
		cmp.w	d2,d4
		blo.w	+ ;loc_261EC
		cmp.w	d3,d4
		bhs.w	+ ;loc_261EC
		lea	$3A(a0),a2
		bsr.w	++ ;sub_261F2

+ ;loc_261EC:
		jmp	(Sprite_OnScreen_Test).l

; =============== S U B R O U T I N E =======================================


+ ;sub_261F2:
		tst.w	(a2)
		bne.s	++ ;loc_26220
		move.l	a1,-(sp)
		jsr	(AllocateObjectAfterCurrent).l
		bne.w	+ ;loc_2621E
		move.l	#loc_2629C,(a1)
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		move.b	render_flags(a0),render_flags(a1)
		move.w	a2,$3C(a1)

+ ;loc_2621E:
		movea.l	(sp)+,a1

+ ;loc_26220:
		addq.w	#1,(a2)
		cmpi.w	#4,(a2)
		beq.s	++ ;loc_26244
		move.w	x_vel(a1),d0
		btst	#0,render_flags(a0)
		beq.s	+ ;loc_26236
		neg.w	d0

+ ;loc_26236:
		tst.w	d0
		bpl.s	locret_26242
		asr	ground_vel(a1)
		asr	x_vel(a1)

locret_26242:
		rts
; ---------------------------------------------------------------------------

+ ;loc_26244:
		move.w	x_vel(a1),d0
		btst	#0,status(a0)
		beq.s	+ ;loc_26252
		neg.w	d0

+ ;loc_26252:
		cmpi.w	#$1000,d0
		bge.s	++ ;loc_26294
		move.w	$34(a0),x_vel(a1)
		bclr	#Status_Facing,status(a1)
		btst	#0,status(a0)
		beq.s	+ ;loc_26276
		bset	#Status_Facing,status(a1)
		neg.w	x_vel(a1)

+ ;loc_26276:
		move.w	#15,move_lock(a1)
		move.w	x_vel(a1),ground_vel(a1)
		bclr	#p1_pushing_bit,status(a0)
		bclr	#p2_pushing_bit,status(a0)
		bclr	#Status_Push,status(a1)

+ ;loc_26294:
		moveq	#signextendB(sfx_Spring),d0
		jmp	(Play_SFX).l
; End of function sub_261F2

; ---------------------------------------------------------------------------

loc_2629C:
		move.l	#Map_LBZPlayerLauncher,mappings(a0)
		move.w	#make_art_tile($3C3,2,0),art_tile(a0)
		ori.b	#4,render_flags(a0)
		move.b	#8,width_pixels(a0)
		move.w	#$80,priority(a0)
		move.w	x_pos(a0),$30(a0)
		addi.w	#$10,y_pos(a0)
		move.w	y_pos(a0),$32(a0)
		move.b	#1,mapping_frame(a0)
		move.b	#$80,$40(a0)
		bset	#6,render_flags(a0)
		move.w	#4,mainspr_childsprites(a0)
		move.l	#loc_262EC,(a0)

loc_262EC:
		move.w	$36(a0),d0
		move.w	off_26302(pc,d0.w),d1
		jsr	off_26302(pc,d1.w)
		bsr.w	sub_26338
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------
off_26302:
		dc.w loc_26306-off_26302
		dc.w loc_26322-off_26302
; ---------------------------------------------------------------------------

loc_26306:
		addi.b	#$10,$40(a0)
		cmpi.b	#$D0,$40(a0)
		bne.s	locret_26320
		movea.w	$3C(a0),a2
		move.w	#0,(a2)
		addq.w	#2,$36(a0)

locret_26320:
		rts
; ---------------------------------------------------------------------------

loc_26322:
		subi.b	#4,$40(a0)
		cmpi.b	#$80,$40(a0)
		bne.s	locret_26336
		move.w	#$7F00,$30(a0)

locret_26336:
		rts

; =============== S U B R O U T I N E =======================================


sub_26338:
		move.b	$40(a0),d0
		btst	#0,render_flags(a0)
		beq.s	+ ;loc_2634A
		neg.b	d0
		addi.b	#$80,d0

+ ;loc_2634A:
		jsr	(GetSineCosine).l
		move.w	$32(a0),d2
		move.w	$30(a0),d3
		moveq	#0,d6
		move.w	mainspr_childsprites(a0),d6
		subq.w	#1,d6
		bcs.s	locret_263A8
		swap	d0
		swap	d1
		asr.l	#4,d0
		asr.l	#4,d1
		moveq	#0,d4
		moveq	#0,d5
		add.l	d0,d4
		add.l	d1,d5
		lea	sub2_x_pos(a0),a2

- ;loc_26376:
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
		addq.w	#1,a2
		move.b	#1,(a2)+
		dbf	d6,- ;loc_26376
		swap	d4
		swap	d5
		add.w	d2,d4
		add.w	d3,d5
		move.w	d5,x_pos(a0)
		move.w	d4,y_pos(a0)

locret_263A8:
		rts
; End of function sub_26338


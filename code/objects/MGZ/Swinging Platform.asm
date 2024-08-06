Obj_MGZSwingingPlatform:
		move.l	#Map_MGZSwingingPlatform,mappings(a0)
		move.w	#make_art_tile($35F,2,0),art_tile(a0)
		move.b	#4,render_flags(a0)
		move.b	#$18,width_pixels(a0)
		move.b	#$C,height_pixels(a0)
		move.w	#$200,priority(a0)
		move.w	x_pos(a0),$30(a0)
		move.w	y_pos(a0),$32(a0)
		move.b	#2,mapping_frame(a0)
		jsr	(AllocateObjectAfterCurrent).l
		bne.w	++ ;loc_3401C
		move.l	#loc_3406E,(a1)
		move.l	#Map_MGZSwingingPlatform,mappings(a1)
		move.w	#make_art_tile($35F,2,0),art_tile(a1)
		move.b	#4,render_flags(a1)
		move.b	#$50,width_pixels(a1)
		move.b	#$50,height_pixels(a1)
		move.w	#$280,priority(a1)
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		btst	#1,status(a0)
		bne.s	+ ;loc_3400C
		move.b	#1,mapping_frame(a1)

+ ;loc_3400C:
		bset	#6,render_flags(a1)
		move.w	#4,mainspr_childsprites(a1)
		move.w	a1,$3C(a0)

+ ;loc_3401C:
		moveq	#1,d0
		btst	#0,status(a0)
		beq.s	+ ;loc_34028
		neg.w	d0

+ ;loc_34028:
		move.b	d0,$36(a0)
		move.b	subtype(a0),d0
		move.b	d0,$34(a0)
		move.l	#loc_3403A,(a0)

loc_3403A:
		move.w	x_pos(a0),-(sp)
		movea.w	$3C(a0),a1
		bsr.w	+ ;sub_34074
		move.b	$36(a0),d0
		add.b	d0,$34(a0)
		moveq	#0,d1
		move.b	width_pixels(a0),d1
		moveq	#0,d3
		move.b	height_pixels(a0),d3
		addq.w	#1,d3
		move.w	(sp)+,d4
		jsr	(SolidObjectTop).l
		move.w	$30(a0),d0
		jmp	(Sprite_OnScreen_Test2).l
; ---------------------------------------------------------------------------

loc_3406E:
		jmp	(Sprite_OnScreen_Test).l

; =============== S U B R O U T I N E =======================================


+ ;sub_34074:
		move.b	$34(a0),d0
		jsr	(GetSineCosine).l
		move.w	$32(a0),d2
		move.w	$30(a0),d3
		swap	d0
		swap	d1
		asr.l	#4,d0
		asr.l	#4,d1
		move.l	d0,d4
		move.l	d1,d5
		lea	sub2_x_pos(a1),a2
		move.w	mainspr_childsprites(a1),d6
		subq.w	#1,d6

- ;loc_3409C:
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
		addq.w	#2,a2
		dbf	d6,- ;loc_3409C
		swap	d4
		swap	d5
		add.w	d2,d4
		add.w	d3,d5
		move.w	d5,x_pos(a0)
		move.w	d4,y_pos(a0)
		rts
; End of function sub_34074

; ---------------------------------------------------------------------------

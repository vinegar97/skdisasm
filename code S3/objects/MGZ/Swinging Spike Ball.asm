Obj_MGZSwingingSpikeBall:
		move.l	#Map_MGZSwingingSpikeBall,mappings(a0)
		move.w	#make_art_tile($35F,1,0),art_tile(a0)
		ori.b	#4,render_flags(a0)
		move.b	#$20,width_pixels(a0)
		move.b	#$20,height_pixels(a0)
		move.w	#$200,priority(a0)
		move.w	x_pos(a0),$30(a0)
		move.w	y_pos(a0),$32(a0)
		move.b	#3,mapping_frame(a0)
		move.b	#$8F,collision_flags(a0)
		jsr	(AllocateObjectAfterCurrent).l
		bne.w	loc_333F0
		move.l	#loc_334B4,(a1)
		move.l	#Map_MGZSwingingSpikeBall,mappings(a1)
		move.w	#make_art_tile($35F,1,0),art_tile(a1)
		move.b	render_flags(a0),render_flags(a1)
		move.b	#$50,width_pixels(a1)
		move.b	#$50,height_pixels(a1)
		move.w	#$280,priority(a1)
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		bset	#6,render_flags(a1)
		move.w	#4,mainspr_childsprites(a1)
		lea	sub2_x_pos(a1),a2
		move.w	mainspr_childsprites(a1),d0

loc_333D0:
		move.w	x_pos(a0),(a2)+
		move.w	y_pos(a0),(a2)+
		move.w	#0,(a2)+
		dbf	d0,loc_333D0
		move.w	#1,-2(a2)
		move.b	#1,mapping_frame(a1)
		move.w	a1,$3C(a0)

loc_333F0:
		move.b	subtype(a0),d0
		beq.s	loc_33416
		move.w	#2,-2(a2)
		move.b	#2,mapping_frame(a1)
		move.w	#$8000,$34(a0)
		move.w	#$100,$36(a0)
		move.l	#loc_3346A,(a0)
		bra.s	loc_3346A
; ---------------------------------------------------------------------------

loc_33416:
		moveq	#2,d0
		btst	#1,status(a0)
		beq.s	loc_33422
		neg.w	d0

loc_33422:
		move.b	d0,$36(a0)
		move.l	#loc_3342C,(a0)

loc_3342C:
		movea.w	$3C(a0),a1
		bsr.w	sub_334BA
		move.b	$34(a0),d2
		move.b	$36(a0),d0
		add.b	d0,$34(a0)
		tst.b	render_flags(a0)
		bpl.s	loc_33460
		move.b	$34(a0),d0
		eor.b	d0,d2
		andi.b	#$40,d2
		beq.s	loc_33460
		andi.b	#$40,d0
		beq.s	loc_33460
		moveq	#signextendB(sfx_SpikeBalls),d0
		jsr	(Play_SFX).l

loc_33460:
		move.w	$30(a0),d0
		jmp	(loc_19CC8).l
; ---------------------------------------------------------------------------

loc_3346A:
		movea.w	$3C(a0),a1
		bsr.w	sub_33516
		move.b	$34(a0),d2
		bpl.s	loc_33480
		addi.w	#$10,$36(a0)
		bra.s	loc_33486
; ---------------------------------------------------------------------------

loc_33480:
		subi.w	#$10,$36(a0)

loc_33486:
		move.w	$36(a0),d0
		add.w	d0,$34(a0)
		tst.b	render_flags(a0)
		bpl.s	loc_334AE
		move.b	$34(a0),d0
		eor.b	d0,d2
		andi.b	#$40,d2
		beq.s	loc_334AE
		andi.b	#$40,d0
		beq.s	loc_334AE
		moveq	#signextendB(sfx_SpikeBalls),d0
		jsr	(Play_SFX).l

loc_334AE:
		jmp	(Sprite_CheckDeleteTouch3).l
; ---------------------------------------------------------------------------

loc_334B4:
		jmp	(Sprite_OnScreen_Test).l

; =============== S U B R O U T I N E =======================================


sub_334BA:
		move.w	#$200,priority(a0)
		move.b	#0,mapping_frame(a1)
		move.w	#5,mainspr_childsprites(a1)
		move.b	$34(a0),d0
		bpl.s	loc_334E4
		move.w	#$300,priority(a0)
		move.b	#1,mapping_frame(a1)
		move.w	#4,mainspr_childsprites(a1)

loc_334E4:
		jsr	(GetSineCosine).l
		move.w	$30(a0),d3
		swap	d1
		asr.l	#4,d1
		move.l	d1,d5
		lea	sub2_x_pos(a1),a2
		moveq	#4-1,d6

loc_334FA:
		move.l	d5,d4
		swap	d4
		add.w	d3,d4
		move.w	d4,(a2)+
		add.l	d1,d5
		addq.w	#4,a2
		dbf	d6,loc_334FA
		add.l	d1,d5
		swap	d5
		add.w	d3,d5
		move.w	d5,x_pos(a0)
		rts
; End of function sub_334BA


; =============== S U B R O U T I N E =======================================


sub_33516:
		move.w	#$200,priority(a0)
		move.b	#0,mapping_frame(a1)
		move.w	#5,mainspr_childsprites(a1)
		move.b	$34(a0),d0
		bpl.s	loc_33540
		move.w	#$300,priority(a0)
		move.b	#2,mapping_frame(a1)
		move.w	#4,mainspr_childsprites(a1)

loc_33540:
		jsr	(GetSineCosine).l
		move.w	$32(a0),d3
		swap	d1
		asr.l	#4,d1
		move.l	d1,d5
		lea	sub2_y_pos(a1),a2
		moveq	#4-1,d6

loc_33556:
		move.l	d5,d4
		swap	d4
		add.w	d3,d4
		move.w	d4,(a2)+
		add.l	d1,d5
		addq.w	#4,a2
		dbf	d6,loc_33556
		add.l	d1,d5
		swap	d5
		add.w	d3,d5
		move.w	d5,y_pos(a0)
		rts
; End of function sub_33516

; ---------------------------------------------------------------------------
Map_MGZSwingingSpikeBall:
		include "Levels/MGZ/Misc Object Data/Map - Swinging Spike Ball.asm"
; ---------------------------------------------------------------------------

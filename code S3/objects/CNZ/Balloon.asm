Obj_CNZBalloon:
		move.l	#Map_CNZBalloon,mappings(a0)
		move.w	#make_art_tile($351,0,0),art_tile(a0)
		ori.b	#4,render_flags(a0)
		move.w	#$280,priority(a0)
		move.b	#$10,width_pixels(a0)
		move.b	#$20,height_pixels(a0)
		move.b	#$D7,collision_flags(a0)
		move.w	y_pos(a0),$32(a0)
		move.b	subtype(a0),d0
		add.b	d0,d0
		andi.b	#$E,d0
		move.b	d0,anim(a0)
		jsr	(Random_Number).l
		move.b	d0,angle(a0)
		move.l	#loc_303B8,(a0)

loc_303B8:
		tst.b	collision_property(a0)
		beq.s	++ ;loc_303DA
		lea	(Player_1).w,a1
		bclr	#0,collision_property(a0)
		beq.s	+ ;loc_303CC
		bsr.s	sub_30412

+ ;loc_303CC:
		lea	(Player_2).w,a1
		bclr	#1,collision_property(a0)
		beq.s	+ ;loc_303DA
		bsr.s	sub_30412

+ ;loc_303DA:
		lea	(Ani_CNZBalloon).l,a1
		jsr	(Animate_Sprite).l
		; Bug: probably meant to be 5(a0), and at some point the animation terminated
		; with code $FC (increment routine counter) rather than $FB (move offscreen)
		tst.b	5
		beq.s	+ ;loc_303F2
		move.w	#$7F00,x_pos(a0)

+ ;loc_303F2:
		moveq	#0,d0
		move.b	angle(a0),d0
		addq.b	#1,angle(a0)
		jsr	(GetSineCosine).l
		asr.w	#5,d0
		add.w	$32(a0),d0
		move.w	d0,y_pos(a0)
		jmp	(Sprite_CheckDeleteTouch3).l

; =============== S U B R O U T I N E =======================================


sub_30412:
		move.w	#-$700,y_vel(a1)
		bset	#Status_InAir,status(a1)
		bclr	#Status_RollJump,status(a1)
		bclr	#Status_Push,status(a1)
		clr.b	jumping(a1)
		move.b	#0,object_control(a1)
		bset	#0,anim(a0)
		tst.b	subtype(a0)
		bpl.s	+ ;loc_30466
		move.w	#-$380,y_vel(a1)
		tst.b	$34(a0)
		bne.s	+ ;loc_30466
		lea	(byte_304B8).l,a2
		bsr.s	sub_3047C
		bsr.s	sub_3047C
		bsr.s	sub_3047C
		bsr.s	sub_3047C
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)

+ ;loc_30466:
		tst.b	$34(a0)
		bne.s	locret_3047A
		moveq	#signextendB(sfx_Balloon),d0
		jsr	(Play_SFX).l
		move.b	#1,$34(a0)

locret_3047A:
		rts
; End of function sub_30412


; =============== S U B R O U T I N E =======================================


sub_3047C:
		jsr	(AllocateObject).l
		bne.s	locret_304B6
		move.l	#Obj_Bubbler,(a1)
		move.w	x_pos(a0),x_pos(a1)
		jsr	(Random_Number).l
		move.w	d0,d1
		andi.w	#$F,d0
		subq.w	#8,d0
		add.w	d0,x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		andi.w	#$F,d1
		subq.w	#8,d1
		add.w	d1,y_pos(a1)
		move.b	(a2)+,subtype(a1)

locret_304B6:
		rts
; End of function sub_3047C

; ---------------------------------------------------------------------------
byte_304B8:
		dc.b    0,   0,   1,   3
		even
Ani_CNZBalloon:
		include "Levels/CNZ/Misc Object Data/Anim - Balloon.asm"
Map_CNZBalloon:
		include "Levels/CNZ/Misc Object Data/Map - Balloon.asm"
; ---------------------------------------------------------------------------

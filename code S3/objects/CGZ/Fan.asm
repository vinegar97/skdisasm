loc_2F51C:
		move.l	#Map_CGZFan,mappings(a0)
		move.w	#make_art_tile($300,3,0),art_tile(a0)
		ori.b	#4,render_flags(a0)
		move.w	#$200,priority(a0)
		move.b	#$10,width_pixels(a0)
		move.b	#4,height_pixels(a0)
		move.b	subtype(a0),d0
		andi.w	#$F,d0
		addq.w	#8,d0
		lsl.w	#4,d0
		move.w	d0,$36(a0)
		addi.w	#$30,d0
		move.w	d0,$38(a0)
		move.l	#loc_2F560,(a0)

loc_2F560:
		lea	(Player_1).w,a1
		bsr.w	sub_2F588
		lea	(Player_2).w,a1
		bsr.w	sub_2F588
		addq.b	#1,mapping_frame(a0)
		cmpi.b	#3,mapping_frame(a0)
		blo.s	loc_2F582
		move.b	#0,mapping_frame(a0)

loc_2F582:
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_2F588:
		cmpi.b	#4,routine(a1)
		bhs.w	locret_2F61E
		tst.b	object_control(a1)
		bne.w	locret_2F61E
		move.w	x_pos(a1),d0
		sub.w	x_pos(a0),d0
		addi.w	#$14,d0
		cmpi.w	#$28,d0
		bhs.s	locret_2F61E
		moveq	#0,d1
		move.b	(Oscillating_table+$16).w,d1
		add.w	y_pos(a1),d1
		add.w	$36(a0),d1
		sub.w	y_pos(a0),d1
		bcs.s	locret_2F61E
		cmp.w	$38(a0),d1
		bhs.s	locret_2F61E
		sub.w	$36(a0),d1
		bcs.s	loc_2F5D0
		not.w	d1
		add.w	d1,d1

loc_2F5D0:
		add.w	$36(a0),d1
		neg.w	d1
		asr.w	#6,d1
		add.w	d1,y_pos(a1)
		bset	#Status_InAir,status(a1)
		bclr	#Status_RollJump,status(a1)
		move.w	#0,y_vel(a1)
		move.b	#0,double_jump_flag(a1)
		move.b	#0,jumping(a1)
		move.w	#1,ground_vel(a1)
		tst.b	flip_angle(a1)
		bne.s	locret_2F61E
		move.b	#1,flip_angle(a1)
		move.b	#0,anim(a1)
		move.b	#$7F,flips_remaining(a1)
		move.b	#8,flip_speed(a1)

locret_2F61E:
		rts
; End of function sub_2F588

; ---------------------------------------------------------------------------
Map_CGZFan:
		include "Levels/CGZ/Misc Object Data/Map - Fan.asm"
; ---------------------------------------------------------------------------

Obj_2PGoalMarker:
		move.l	#Map_2PGoalMarker,mappings(a0)
		move.w	#make_art_tile($6BC,0,0),art_tile(a0)
		ori.b	#4,render_flags(a0)
		move.w	#$280,priority(a0)
		move.b	#8,width_pixels(a0)
		move.b	#$20,height_pixels(a0)
		move.w	x_pos(a0),$30(a0)
		move.w	y_pos(a0),$32(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		lsl.w	#3,d0
		subi.w	#$14,d0
		move.w	d0,$38(a0)
		move.b	#5,(Competition_total_laps).w
		clr.w	(Competition_current_lap).w
		clr.w	(Events_bg+$14).w
		clr.b	(Update_HUD_timer).w
		clr.l	(Timer).w
		clr.b	(Update_HUD_timer_P2).w
		clr.l	(Timer_P2).w
		clr.w	(Ring_count).w
		clr.w	(Ring_count_P2).w
		jsr	sub_364EC(pc)
		jsr	(AllocateObjectAfterCurrent).l
		bne.w	loc_36276
		move.l	#loc_37454,(a1)
		jsr	(AllocateObjectAfterCurrent).l
		bne.w	loc_36276
		move.l	#loc_37454,(a1)
		move.b	#1,subtype(a1)
		jsr	(AllocateObjectAfterCurrent).l
		bne.w	loc_36276
		move.l	#loc_365CC,(a1)
		jsr	(AllocateObjectAfterCurrent).l
		bne.w	loc_36276
		move.l	#loc_365CC,(a1)
		move.b	#1,subtype(a1)
		jsr	(AllocateObjectAfterCurrent).l
		bne.w	loc_36276
		move.l	#loc_366CC,(a1)
		move.w	#$120,x_pos(a1)
		move.w	#$B8,y_pos(a1)
		jsr	(AllocateObjectAfterCurrent).l
		bne.w	loc_36276
		move.l	#loc_37220,(a1)
		jsr	(AllocateObjectAfterCurrent).l
		bne.w	loc_36276
		move.l	#loc_37292,(a1)
		jsr	(AllocateObjectAfterCurrent).l
		bne.w	loc_36276
		move.l	#locret_3780C,(a1)

loc_36276:
		move.l	#loc_3627C,(a0)

loc_3627C:
		move.w	x_pos(a0),d1
		lea	$34(a0),a2
		lea	(Player_1).w,a1
		lea	(Competition_current_lap).w,a3
		lea	(_unkF74A).w,a4
		lea	(Timer).w,a5
		lea	($FF7828).l,a6
		bsr.w	sub_3638E
		lea	(Player_2).w,a1
		lea	(Competition_current_lap_2P).w,a3
		lea	(_unkF74B).w,a4
		lea	(Timer_P2).w,a5
		lea	($FF7840).l,a6
		bsr.w	sub_3638E
		lea	(Ani_2PGoalMarker).l,a1
		jsr	(Animate_Sprite).l
		move.w	$36(a0),(Competition_lap_count).w
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_362D0:
		subq.w	#1,$3C(a0)
		bne.w	loc_3637C
		lea	(Player_1).w,a1
		move.w	(Saved_X_pos).w,x_pos(a1)
		move.w	(Saved_Y_pos).w,y_pos(a1)
		move.w	(Saved_art_tile).w,art_tile(a1)
		move.w	(Saved_solid_bits).w,top_solid_bit(a1)
		move.w	#0,x_vel(a1)
		move.w	#0,y_vel(a1)
		move.w	#0,ground_vel(a1)
		move.b	#1<<Status_InAir,status(a1)
		move.w	#0,move_lock(a1)
		tst.b	(Not_ghost_flag).w
		beq.s	loc_36352
		lea	(Player_2).w,a1
		move.w	(Saved2_X_pos).w,x_pos(a1)
		move.w	(Saved2_Y_pos).w,y_pos(a1)
		move.w	(Saved2_art_tile).w,art_tile(a1)
		move.w	(Saved2_solid_bits).w,top_solid_bit(a1)
		move.w	#0,x_vel(a1)
		move.w	#0,y_vel(a1)
		move.w	#0,ground_vel(a1)
		move.b	#1<<Status_InAir,status(a1)
		move.w	#0,move_lock(a1)

loc_36352:
		clr.w	(Competition_current_lap).w
		clr.b	(Update_HUD_timer).w
		clr.l	(Timer).w
		clr.b	(Update_HUD_timer_P2).w
		clr.l	(Timer_P2).w
		clr.b	(Ctrl_1_locked).w
		clr.b	(Ctrl_2_locked).w
		jsr	sub_364EC(pc)
		clr.w	(Events_bg+$14).w
		move.l	#loc_3627C,(a0)

loc_3637C:
		lea	(Ani_2PGoalMarker).l,a1
		jsr	(Animate_Sprite).l
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_3638E:
		tst.b	(a4)
		bne.w	loc_3648E
		tst.b	(a2)+
		bne.w	loc_3649E
		cmp.w	x_pos(a1),d1
		bhi.w	locret_364EA
		move.b	#1,-1(a2)
		move.w	y_pos(a0),d2
		move.w	d2,d3
		sub.w	$38(a0),d2
		addi.w	#$14,d3
		move.w	y_pos(a1),d4
		cmp.w	d2,d4
		blt.w	locret_364EA
		cmp.w	d3,d4
		bge.w	locret_364EA
		move.w	x_pos(a1),d2
		sub.w	d1,d2
		bcc.s	loc_363D0
		neg.w	d2

loc_363D0:
		cmpi.w	#$20,d2
		bhs.w	locret_364EA
		cmpi.b	#$C,top_solid_bit(a1)
		bne.s	locret_3642C
		move.b	(a3),d0
		beq.s	loc_3642E
		cmp.b	1(a2),d0
		bls.s	loc_3642A
		move.b	d0,1(a2)
		subq.b	#1,d0
		bmi.s	loc_3640E
		cmpi.b	#5,d0
		bhs.s	loc_3640E
		ext.w	d0
		lsl.w	#2,d0
		move.l	(a6,d0.w),d5
		move.l	$14(a6),d6
		jsr	sub_36508(pc)
		move.l	d6,$14(a6)
		clr.l	(a5)

loc_3640E:
		sub.w	y_pos(a0),d4
		neg.w	d4
		cmpi.w	#$14,d4
		bge.s	loc_3642A
		move.w	$3A(a0),d0
		andi.w	#$F,d0
		bsr.w	sub_3653C
		addq.w	#2,$3A(a0)

loc_3642A:
		addq.b	#1,(a3)

locret_3642C:
		rts
; ---------------------------------------------------------------------------

loc_3642E:
		tst.b	1(a2)
		bne.s	loc_3642A
		tst.b	(Update_HUD_timer).w
		bne.s	loc_3642A
		move.b	#1,(Ctrl_1_locked).w
		move.b	#1,(Ctrl_2_locked).w
		move.w	#0,(Ctrl_1_logical).w
		move.w	#0,(Ctrl_2_logical).w
		move.l	#loc_362D0,(a0)
		move.w	#2*60,$3C(a0)
		st	(Events_bg+$14).w
		movea.l	a1,a6
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	locret_3648C
		move.l	#loc_36A4A,(a1)
		move.b	#8,render_flags(a1)
		cmpa.w	#Player_1,a6
		beq.s	loc_36484
		eori.b	#$18,render_flags(a1)

loc_36484:
		moveq	#signextendB(sfx_Error),d0
		jmp	(Play_SFX).l
; ---------------------------------------------------------------------------

locret_3648C:
		rts
; ---------------------------------------------------------------------------

loc_3648E:
		clr.b	(a4)
		move.b	#0,(a2)+
		subq.b	#1,(a3)
		bcc.s	locret_3649C
		move.b	#0,(a3)

locret_3649C:
		rts
; ---------------------------------------------------------------------------

loc_3649E:
		cmp.w	x_pos(a1),d1
		bls.w	locret_364EA
		move.b	#0,-1(a2)
		move.w	y_pos(a0),d2
		move.w	d2,d3
		sub.w	$38(a0),d2
		addi.w	#$14,d3
		move.w	y_pos(a1),d4
		cmp.w	d2,d4
		blt.w	locret_364EA
		cmp.w	d3,d4
		bge.w	locret_364EA
		move.w	x_pos(a1),d2
		sub.w	d1,d2
		bcc.s	loc_364D4
		neg.w	d2

loc_364D4:
		cmpi.w	#$20,d2
		bhs.s	locret_364EA
		cmpi.b	#$C,top_solid_bit(a1)
		bne.s	locret_364EA
		subq.b	#1,(a3)
		bcc.s	locret_364EA
		move.b	#0,(a3)

locret_364EA:
		rts
; End of function sub_3638E


; =============== S U B R O U T I N E =======================================


sub_364EC:
		lea	($FF7828).l,a1
		moveq	#$C-1,d0

.loop:
		clr.l	(a1)+
		dbf	d0,.loop
		clr.l	(Competition_time_record).w
		clr.l	(Competition_time_record_P2).w
		st	(Competition_time_attack_new_top_record).w
		rts
; End of function sub_364EC


; =============== S U B R O U T I N E =======================================


sub_36508:
		add.b	d5,d6
		moveq	#0,d3
		cmpi.b	#100,d6
		blo.s	loc_36518
		subi.b	#100,d6
		moveq	#1,d3

loc_36518:
		ror.l	#8,d5
		ror.l	#8,d6
		add.b	d3,d6
		add.b	d5,d6
		moveq	#0,d3
		cmpi.b	#60,d6
		blo.s	loc_3652E
		subi.b	#60,d6
		moveq	#1,d3

loc_3652E:
		ror.l	#8,d5
		ror.l	#8,d6
		add.b	d3,d6
		add.b	d5,d6
		swap	d5
		swap	d6
		rts
; End of function sub_36508


; =============== S U B R O U T I N E =======================================


sub_3653C:
		tst.b	(Competition_items).w
		bne.s	locret_3656A
		lea	(byte_3656C).l,a4
		adda.w	d0,a4
		lea	(Dynamic_object_RAM).w,a1
		moveq	#(Dynamic_object_RAM_end-Dynamic_object_RAM)/object_size-1,d0

loc_36550:
		lea	next_object(a1),a1
		cmpi.l	#loc_35962,(a1)
		bne.s	loc_36566
		move.b	(a4)+,anim(a1)
		move.b	#$C7,collision_flags(a1)

loc_36566:
		dbf	d0,loc_36550

locret_3656A:
		rts
; End of function sub_3653C

; ---------------------------------------------------------------------------
byte_3656C:
		dc.b    0,   1,   2,   3,   4,   5,   6,   0,   1,   2,   3,   4,   5,   6,   2,   3,   0,   1,   2,   3
		dc.b    4,   5,   6,   0
		even
Ani_2PGoalMarker:
		include "General/2P Zone/Anim - Goal Marker.asm"
Map_2PGoalMarker:
		include "General/2P Zone/Map - Goal Marker.asm"
; ---------------------------------------------------------------------------

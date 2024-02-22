loc_365CC:
		move.l	#Map_2PLapNumbers,mappings(a0)
		move.w	#make_art_tile($700,0,1),art_tile(a0)
		move.w	#0,priority(a0)
		move.b	#8,width_pixels(a0)
		move.b	#$C,height_pixels(a0)
		move.w	#$190,x_pos(a0)
		move.w	#$98,y_pos(a0)
		tst.b	subtype(a0)
		beq.s	loc_36618
		tst.b	(Not_ghost_flag).w
		bne.s	loc_3660A
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_3660A:
		bset	#4,render_flags(a0)
		move.l	#loc_36646,(a0)
		bra.s	loc_36646
; ---------------------------------------------------------------------------

loc_36618:
		bset	#3,render_flags(a0)
		move.l	#loc_36624,(a0)

loc_36624:
		move.b	(Competition_current_lap).w,d0
		cmp.b	(Competition_total_laps).w,d0
		ble.s	loc_36632
		move.b	(Competition_total_laps).w,d0

loc_36632:
		subi.b	#$A,d0
		bcc.s	loc_36632
		addi.b	#$A,d0
		move.b	d0,mapping_frame(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_36646:
		move.b	(Competition_current_lap_2P).w,d0
		cmp.b	(Competition_total_laps).w,d0
		ble.s	loc_36654
		move.b	(Competition_total_laps).w,d0

loc_36654:
		subi.b	#$A,d0
		bcc.s	loc_36654
		addi.b	#$A,d0
		move.b	d0,mapping_frame(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
Map_2PLapNumbers:
		include "General/2P Zone/Map - Lap Numbers.asm"
; ---------------------------------------------------------------------------

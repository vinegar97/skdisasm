loc_37454:
		move.l	#Map_2PItemIcon,mappings(a0)
		move.w	#make_art_tile($750,0,1),art_tile(a0)
		move.w	#0,priority(a0)
		move.b	#$10,width_pixels(a0)
		move.b	#$10,height_pixels(a0)
		move.w	#$120,x_pos(a0)
		move.w	#$E0,y_pos(a0)
		tst.b	subtype(a0)
		beq.s	loc_374A0
		tst.b	(Not_ghost_flag).w
		bne.s	loc_37492
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_37492:
		bset	#4,render_flags(a0)
		move.l	#loc_374D4,(a0)
		bra.s	loc_374D4
; ---------------------------------------------------------------------------

loc_374A0:
		bset	#3,render_flags(a0)
		move.l	#loc_374AC,(a0)

loc_374AC:
		moveq	#0,d0
		tst.w	(Ring_count).w
		beq.s	loc_374B6
		moveq	#3,d0

loc_374B6:
		btst	#Status_SpeedShoes,(Player_1+status_secondary).w
		beq.s	loc_374CA
		moveq	#1,d0
		cmpi.w	#$C00,(Max_speed).w
		beq.s	loc_374CA
		moveq	#2,d0

loc_374CA:
		move.b	d0,mapping_frame(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_374D4:
		moveq	#0,d0
		tst.w	(Ring_count_P2).w
		beq.s	loc_374DE
		moveq	#3,d0

loc_374DE:
		btst	#2,(Player_2+status_secondary).w
		beq.s	loc_374F2
		moveq	#1,d0
		cmpi.w	#$C00,(Max_speed_P2).w
		beq.s	loc_374F2
		moveq	#2,d0

loc_374F2:
		move.b	d0,mapping_frame(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
Map_2PItemIcon:
		include "General/2P Zone/Map - Item Icon.asm"
; ---------------------------------------------------------------------------

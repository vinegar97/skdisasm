		move.l	#Map_2PPosition,mappings(a0)
		move.w	#make_art_tile($75E,0,1),art_tile(a0)
		move.w	#0,priority(a0)
		move.b	#4,width_pixels(a0)
		move.b	#4,height_pixels(a0)
		tst.b	subtype(a0)
		beq.s	loc_38044
		tst.b	(Not_ghost_flag).w
		bne.s	loc_3801E
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_3801E:
		move.w	#$90,x_pos(a0)
		move.w	#$84,y_pos(a0)
		move.w	(Player_2+x_pos).w,$30(a0)
		bset	#4,render_flags(a0)
		move.b	#2,mapping_frame(a0)
		move.l	#loc_380BC,(a0)
		bra.s	loc_380BC
; ---------------------------------------------------------------------------

loc_38044:
		move.w	#$90,x_pos(a0)
		move.w	#$E8,y_pos(a0)
		move.w	(Player_1+x_pos).w,$30(a0)
		bset	#3,render_flags(a0)
		move.b	#1,mapping_frame(a0)
		move.l	#loc_38068,(a0)

loc_38068:
		move.w	(Player_1+x_pos).w,d0
		move.w	(Saved_X_pos).w,d1

loc_38070:
		tst.w	(Events_bg+$14).w
		beq.s	loc_38080
		move.w	#0,$34(a0)
		move.w	d1,$30(a0)

loc_38080:
		move.w	d0,d1
		sub.w	$30(a0),d0
		beq.s	loc_380A8
		bcc.s	loc_38096
		cmpi.w	#-$200,d0
		bge.s	loc_380A0
		addi.w	#$400,d0
		bra.s	loc_380A0
; ---------------------------------------------------------------------------

loc_38096:
		cmpi.w	#$200,d0
		blt.s	loc_380A0
		subi.w	#$400,d0

loc_380A0:
		add.w	d0,$34(a0)
		move.w	d1,$30(a0)

loc_380A8:
		move.w	$34(a0),d0
		asr.w	#6,d0
		addi.w	#$90,d0
		move.w	d0,x_pos(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_380BC:
		move.w	(Player_2+x_pos).w,d0
		move.w	(Saved2_X_pos).w,d1
		bra.s	loc_38070
; ---------------------------------------------------------------------------
Map_2PPosition:
		include "General/2P Zone/Map - Position Icons (Unused).asm"
; ---------------------------------------------------------------------------

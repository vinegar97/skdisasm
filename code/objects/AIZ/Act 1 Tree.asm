Obj_AIZ1Tree:
		move.l	#Map_AIZ1Tree,mappings(a0)
		move.w	#$180,priority(a0)
		move.b	#8,width_pixels(a0)
		move.b	#4,render_flags(a0)
		move.w	#make_art_tile($001,2,0),art_tile(a0)
		move.l	#loc_1E7B0,(a0)

loc_1E7B0:
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------

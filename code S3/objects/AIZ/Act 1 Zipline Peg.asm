Obj_AIZ1ZiplinePeg:
		move.l	#Map_AIZ1ZiplinePeg,mappings(a0)
		move.w	#$380,priority(a0)
		move.b	#$20,width_pixels(a0)
		move.b	#4,render_flags(a0)
		move.w	#make_art_tile($324,2,0),art_tile(a0)
		move.l	#loc_1C424,(a0)

loc_1C424:
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------
Map_AIZ1ZiplinePeg:
		include "Levels/AIZ/Misc Object Data/Map - Act 1 Zipline Peg.asm"
; ---------------------------------------------------------------------------

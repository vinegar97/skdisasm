Obj_AIZ2FGTree:
		move.l	#Map_AIZ2FGTree,mappings(a0)
		ori.b	#4,render_flags(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		move.b	d0,mapping_frame(a0)
		add.w	d0,d0
		move.w	d0,d1
		add.w	d0,d0
		add.w	d1,d0
		lea	word_2B994(pc,d0.w),a1
		move.w	(a1)+,art_tile(a0)
		move.w	(a1)+,priority(a0)
		move.b	(a1)+,width_pixels(a0)
		move.b	(a1)+,height_pixels(a0)
		move.l	#loc_2B98E,(a0)

loc_2B98E:
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------
word_2B994:
		dc.w make_art_tile($438,2,0)
		dc.w   $300
		dc.b    8, $40
Map_AIZ2FGTree:
		include "Levels/AIZ/Misc Object Data/Map - Act 2 Foreground Tree.asm"
; ---------------------------------------------------------------------------

; ---------------------------------------------------------------------------
byte_1CFEA:
		dc.b $10, $10
		dc.b $20, $10
		dc.b $30, $10
		dc.b $40, $10
; ---------------------------------------------------------------------------

Obj_HCZBlock:
		moveq	#0,d0
		move.b	subtype(a0),d0
		move.b	d0,mapping_frame(a0)
		add.w	d0,d0
		lea	byte_1CFEA(pc,d0.w),a1
		move.b	(a1)+,width_pixels(a0)
		move.b	(a1)+,height_pixels(a0)
		move.l	#Map_HCZBlock,mappings(a0)
		move.w	#make_art_tile($3D4,2,0),art_tile(a0)
		ori.b	#4,render_flags(a0)
		move.w	#$280,priority(a0)
		move.l	#loc_1D02A,(a0)

loc_1D02A:
		moveq	#0,d1
		move.b	width_pixels(a0),d1
		addi.w	#$B,d1
		moveq	#0,d2
		move.b	height_pixels(a0),d2
		move.w	d2,d3
		addq.w	#1,d3
		move.w	x_pos(a0),d4
		bsr.w	SolidObjectFull2
		bra.w	Sprite_OnScreen_Test
; ---------------------------------------------------------------------------
Map_HCZBlock:
		include "Levels/HCZ/Misc Object Data/Map - Block.asm"
; ---------------------------------------------------------------------------

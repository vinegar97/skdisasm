Obj_HCZWaterRush:
		move.l	#Map_HCZWaterRush,mappings(a0)
		ori.b	#4,render_flags(a0)
		move.w	#make_art_tile($37A,2,0),art_tile(a0)
		move.b	#4,render_flags(a0)
		move.w	#$80,priority(a0)
		move.b	#$40,width_pixels(a0)
		move.b	#$20,height_pixels(a0)
		move.b	#2,mapping_frame(a0)
		jsr	(AllocateObjectAfterCurrent).l
		bne.w	loc_2E53E
		move.l	#loc_2E5C8,(a1)
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		subi.w	#$30,x_pos(a1)
		move.l	#Map_HCZWaterRushBlock,mappings(a1)
		move.w	#make_art_tile($3D4,2,0),art_tile(a1)
		move.b	#$10,width_pixels(a1)
		move.b	#$20,height_pixels(a1)
		move.b	#4,render_flags(a1)
		move.w	#$280,priority(a1)
		move.b	#1,mapping_frame(a1)
		move.w	a1,$3C(a0)

loc_2E53E:
		move.b	#3,(_unkF7C7).w
		move.l	#loc_2E54A,(a0)

loc_2E54A:
		tst.b	(Level_trigger_array).w
		beq.s	loc_2E56E
		move.b	#3,mapping_frame(a0)
		move.b	#1,anim_frame_timer(a0)
		move.l	#loc_2E574,(a0)
		move.b	#0,(_unkF7C7).w
		move.b	#1,(Palette_cycle_counters+$00).w

loc_2E56E:
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------

loc_2E574:
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	loc_2E5B4
		move.b	#1,anim_frame_timer(a0)
		addq.b	#1,mapping_frame(a0)
		cmpi.b	#2,mapping_frame(a0)
		bne.s	loc_2E5AE
		addi.w	#$20,x_pos(a0)
		cmpi.w	#$580,x_pos(a0)
		bne.s	loc_2E5AE
		cmpi.w	#$5A0,y_pos(a0)
		bne.s	loc_2E5AE
		subi.w	#$20,x_pos(a0)
		subi.w	#$20,y_pos(a0)

loc_2E5AE:
		andi.b	#1,mapping_frame(a0)

loc_2E5B4:
		cmpi.w	#$980,x_pos(a0)
		blo.s	loc_2E5C2
		move.w	#$7F00,x_pos(a0)

loc_2E5C2:
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------

loc_2E5C8:
		tst.b	(Level_trigger_array).w
		beq.s	loc_2E5E8
		move.l	#loc_2E5D4,(a0)

loc_2E5D4:
		subi.w	#$10,y_pos(a0)
		cmpi.w	#$560,y_pos(a0)
		bne.s	loc_2E5E8
		move.w	#$7F00,x_pos(a0)

loc_2E5E8:
		moveq	#0,d1
		move.b	width_pixels(a0),d1
		addi.w	#$B,d1
		moveq	#0,d2
		move.b	height_pixels(a0),d2
		move.w	d2,d3
		addq.w	#1,d3
		move.w	x_pos(a0),d4
		jsr	(SolidObjectFull).l
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------
Map_HCZWaterRush:
		include "Levels/HCZ/Misc Object Data/Map - Water Rush.asm"
Map_HCZWaterRushBlock:
		include "Levels/HCZ/Misc Object Data/Map - Water Rush Block.asm"
; ---------------------------------------------------------------------------

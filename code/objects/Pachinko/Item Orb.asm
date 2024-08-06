Obj_PachinkoItemOrb:
		move.l	#Map_PachinkoItemOrb,mappings(a0)
		move.w	#make_art_tile($364,3,1),art_tile(a0)
		ori.b	#4,render_flags(a0)
		move.b	#$10,width_pixels(a0)
		move.b	#$10,height_pixels(a0)
		move.w	#$200,priority(a0)
		move.b	#$D7,collision_flags(a0)
		move.l	#loc_4A218,(a0)

loc_4A218:
		tst.b	collision_property(a0)
		beq.s	+ ;loc_4A228
		clr.b	collision_property(a0)
		move.l	#loc_4A238,(a0)

+ ;loc_4A228:
		lea	(Ani_PachinkoItemOrb).l,a1
		jsr	(Animate_Sprite).l
		bra.w	loc_4A31A
; ---------------------------------------------------------------------------

loc_4A238:
		tst.b	collision_property(a0)
		bne.s	+ ;loc_4A274
		clr.b	mapping_frame(a0)
		moveq	#signextendB(sfx_BlueSphere),d0
		jsr	(Play_SFX).l
		move.b	y_pos(a0),d1
		andi.w	#$F,d1
		lsl.w	#2,d1
		move.w	(Level_frame_counter).w,d0
		andi.w	#3,d0
		add.w	d1,d0
		lea	(byte_1E4484).l,a1
		move.b	(a1,d0.w),subtype(a0)
		move.l	#loc_4A34C,(a0)
		bra.w	loc_4A2CC
; ---------------------------------------------------------------------------

+ ;loc_4A274:
		clr.b	collision_property(a0)
		lea	(Ani_PachinkoItemOrb).l,a1
		jsr	(Animate_Sprite).l
		bra.w	loc_4A31A
; ---------------------------------------------------------------------------
Ani_PachinkoItemOrb:
		include "Levels/Pachinko/Misc Object Data/Anim - Item Orb.asm"
Map_PachinkoItemOrb:
		include "Levels/Pachinko/Misc Object Data/Map - Item Orb.asm"
; ---------------------------------------------------------------------------

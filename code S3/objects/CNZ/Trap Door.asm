Obj_CNZTrapDoor:
		move.l	#Map_CNZTrapDoor,mappings(a0)
		move.w	#make_art_tile($3F0,2,0),art_tile(a0)
		ori.b	#4,render_flags(a0)
		move.w	#$80,priority(a0)
		move.b	#$20,width_pixels(a0)
		move.b	#8,height_pixels(a0)
		move.l	#loc_30D5C,(a0)

loc_30D5C:
		lea	(Player_1).w,a1
		bsr.s	sub_30D8C
		lea	(Player_2).w,a1
		bsr.s	sub_30D8C
		move.w	#$20,d1
		move.w	#9,d3
		move.w	x_pos(a0),d4
		jsr	(SolidObjectTop).l
		lea	(Ani_CNZTrapDoor).l,a1
		jsr	(Animate_Sprite).l
		jmp	(Sprite_OnScreen_Test).l

; =============== S U B R O U T I N E =======================================


sub_30D8C:
		move.w	x_pos(a0),d0
		sub.w	x_pos(a1),d0
		addi.w	#$20,d0
		cmpi.w	#$40,d0
		bhs.s	locret_30DBE
		move.w	y_pos(a0),d0
		sub.w	y_pos(a1),d0
		addi.w	#$20,d0
		cmpi.w	#$20,d0
		bhs.s	locret_30DBE
		move.b	#1,anim(a0)
		moveq	#signextendB(sfx_TrapDoor),d0
		jsr	(Play_SFX).l

locret_30DBE:
		rts
; End of function sub_30D8C

; ---------------------------------------------------------------------------
Ani_CNZTrapDoor:
		include "Levels/CNZ/Misc Object Data/Anim - Trap Door.asm"
Map_CNZTrapDoor:
		include "Levels/CNZ/Misc Object Data/Map - Trap Door.asm"
; ---------------------------------------------------------------------------
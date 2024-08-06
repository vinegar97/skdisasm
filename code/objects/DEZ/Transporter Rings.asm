Obj_DEZTransRingSpawner:
		move.w	#7,objoff_30(a0)
		move.l	#Obj_DEZTransRingSpawner_Main,(a0)

Obj_DEZTransRingSpawner_Main:
		subq.w	#1,objoff_30(a0)
		bpl.w	loc_48896
		move.w	#1,objoff_30(a0)
		jsr	(AllocateObjectAfterCurrent).l
		bne.w	loc_4888E
		move.l	#Obj_DEZTransRing,(a1)
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		move.l	#Map_DEZTransRings,mappings(a1)
		move.w	#make_art_tile($385,1,0),art_tile(a1)
		ori.b	#4,render_flags(a1)
		move.b	#$10,width_pixels(a1)
		move.b	#$10,height_pixels(a1)
		move.w	#$80,priority(a1)
		cmpi.b	#-1,angle(a0)
		bne.s	.NormalAnim
		move.b	flip_angle(a0),d1
		move.w	#0,priority(a1)
		move.b	d1,d0
		add.b	d0,d0
		bpl.s	.SineAnim
		bset	#0,status(a1)
		move.w	#$80,priority(a1)

.SineAnim:
		addq.b	#8,d1
		lsr.b	#4,d1
		andi.b	#7,d1
		addq.b	#8,d1
		move.b	d1,anim(a1)
		bra.s	loc_4888E
; ---------------------------------------------------------------------------

.NormalAnim:
		move.w	x_vel(a0),d1
		move.w	y_vel(a0),d2
		jsr	(GetArcTan).l
		addq.b	#8,d0
		lsr.b	#4,d0
		andi.b	#7,d0
		move.b	d0,anim(a1)

loc_4888E:
		moveq	#signextendB(sfx_LightTunnel),d0
		jsr	(Play_SFX).l

loc_48896:
		tst.b	object_control(a0)
		beq.s	loc_4889E
		rts
; ---------------------------------------------------------------------------

loc_4889E:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

Obj_DEZTransRing:
		lea	(Ani_DEZTransRings).l,a1
		jsr	(Animate_Sprite).l
		tst.b	routine(a0)
		beq.s	loc_488BC
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_488BC:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
Ani_DEZTransRings:
		include "Levels/DEZ/Misc Object Data/Anim - Transporter Rings.asm"
Map_DEZTransRings:
		include "Levels/DEZ/Misc Object Data/Map - Transporter Rings.asm"
; ---------------------------------------------------------------------------

Obj_GumballItem:
		move.l	#loc_4A312,(a0)

loc_4A2CC:
		move.l	#Map_PachinkoFItem,mappings(a0)
		move.w	#make_art_tile($378,3,0),art_tile(a0)
		move.b	subtype(a0),d0
		beq.s	loc_4A2F4
		move.l	#Map_GumballBonus,mappings(a0)
		move.w	#make_art_tile($388,0,0),art_tile(a0)
		addq.b	#7,d0
		move.b	d0,mapping_frame(a0)

loc_4A2F4:
		ori.b	#4,render_flags(a0)
		move.b	#$10,width_pixels(a0)
		move.b	#$10,height_pixels(a0)
		move.w	#$200,priority(a0)
		move.b	#$D7,collision_flags(a0)

loc_4A312:
		tst.b	collision_property(a0)
		beq.s	loc_4A31A
		bsr.s	sub_4A362

loc_4A31A:
		move.w	y_pos(a0),d0
		andi.w	#$FF80,d0
		sub.w	(Camera_Y_pos_coarse_back).w,d0
		cmpi.w	#$200,d0
		bhi.w	loc_4A33A
		jsr	(Add_SpriteToCollisionResponseList).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_4A33A:
		move.w	respawn_addr(a0),d0
		beq.s	loc_4A346
		movea.w	d0,a2
		bclr	#7,(a2)

loc_4A346:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_4A34C:
		tst.b	collision_property(a0)
		beq.s	loc_4A354
		bsr.s	sub_4A362

loc_4A354:
		jsr	(MoveSprite2).l
		subi.w	#4,y_vel(a0)
		bra.s	loc_4A31A

; =============== S U B R O U T I N E =======================================


sub_4A362:
		lea	(Player_1).w,a1
		bclr	#0,collision_property(a0)
		beq.s	loc_4A370
		bsr.s	sub_4A384

loc_4A370:
		lea	(Player_2).w,a1
		bclr	#1,collision_property(a0)
		beq.s	loc_4A37E
		bsr.s	sub_4A384

loc_4A37E:
		clr.b	collision_property(a0)
		rts
; End of function sub_4A362


; =============== S U B R O U T I N E =======================================


sub_4A384:
		move.l	#Delete_Current_Sprite,(a0)
		moveq	#0,d1
		moveq	#1,d2
		move.b	subtype(a0),d1
		cmpi.b	#3,d1
		beq.s	loc_4A3B6
		cmpi.b	#2,d1
		beq.s	loc_4A3AC
		subq.w	#1,d1
		bcs.s	loc_4A3AC
		moveq	#0,d0
		move.w	a1,d0
		jmp	(loc_61100).l
; ---------------------------------------------------------------------------

loc_4A3AC:
		moveq	#signextendB(sfx_SmallBumpers),d0
		jsr	(Play_SFX).l
		rts
; ---------------------------------------------------------------------------

loc_4A3B6:
		move.b	y_pos(a0),d0
		andi.w	#$F,d0
		lea	(byte_1E44C4).l,a1
		move.b	(a1,d0.w),d0
		add.w	d0,(Saved_ring_count).w
		jmp	(AddRings).l
; End of function sub_4A384

; ---------------------------------------------------------------------------
Map_PachinkoFItem:
		include "Levels/Pachinko/Misc Object Data/Map - F Item.asm"
; ---------------------------------------------------------------------------

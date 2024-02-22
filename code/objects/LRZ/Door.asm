Obj_LRZDoor:
		move.l	#Map_LRZDoor,mappings(a0)
		move.w	#make_art_tile($3A1,2,0),art_tile(a0)
		ori.b	#4,render_flags(a0)
		move.b	#$10,width_pixels(a0)
		move.b	#$28,height_pixels(a0)
		move.w	#$200,priority(a0)
		move.w	y_pos(a0),$46(a0)
		tst.b	(Current_act).w
		beq.s	loc_4296E
		move.b	#1,mapping_frame(a0)
		move.w	#make_art_tile($090,2,0),art_tile(a0)
		move.b	#$20,height_pixels(a0)

loc_4296E:
		move.l	#loc_42974,(a0)

loc_42974:
		move.b	subtype(a0),d0
		andi.w	#$F,d0
		lea	(Level_trigger_array).w,a3
		tst.b	(a3,d0.w)
		beq.s	loc_429BC
		move.l	#loc_42994,(a0)
		moveq	#signextendB(sfx_DoorOpen),d0
		jsr	(Play_SFX).l

loc_42994:
		addq.b	#1,$2E(a0)
		cmpi.b	#$40,$2E(a0)
		bne.s	loc_429A6
		move.l	#loc_429BC,(a0)

loc_429A6:
		move.b	$2E(a0),d0
		jsr	(GetSineCosine).l
		asr.w	#2,d0
		neg.w	d0
		add.w	$46(a0),d0
		move.w	d0,y_pos(a0)

loc_429BC:
		move.w	#$1B,d1
		moveq	#0,d2
		move.b	height_pixels(a0),d2
		move.w	d2,d3
		addq.w	#1,d3
		move.w	x_pos(a0),d4
		jsr	(SolidObjectFull).l
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------
Map_LRZDoor:
		include "Levels/LRZ/Misc Object Data/Map - Door.asm"
; ---------------------------------------------------------------------------

Obj_LRZBigDoor:
		move.l	#Map_LRZBigDoor,mappings(a0)
		move.w	#make_art_tile($3A1,2,0),art_tile(a0)
		ori.b	#4,render_flags(a0)
		move.b	#$30,width_pixels(a0)
		move.b	#$40,height_pixels(a0)
		move.w	#$280,priority(a0)
		move.w	y_pos(a0),$46(a0)
		move.w	respawn_addr(a0),d0
		beq.s	loc_42A62
		movea.w	d0,a2
		btst	#0,(a2)
		beq.s	loc_42A62
		addi.w	#$80,y_pos(a0)
		move.l	#loc_42B08,(a0)
		bra.w	loc_42B08
; ---------------------------------------------------------------------------

loc_42A62:
		move.l	#loc_42A68,(a0)

loc_42A68:
		lea	(Player_1).w,a1
		move.w	y_pos(a1),d0
		sub.w	y_pos(a0),d0
		addi.w	#-$40,d0
		cmpi.w	#$80,d0
		bhs.w	loc_42B08
		move.w	x_pos(a1),d0
		sub.w	x_pos(a0),d0
		cmpi.w	#$50,d0
		blt.s	loc_42B08
		move.l	#loc_42AAE,(a0)
		move.w	#-1,(Screen_shake_flag).w
		moveq	#signextendB(sfx_BigRumble),d0
		jsr	(Play_SFX).l
		move.w	respawn_addr(a0),d0
		beq.s	loc_42AAE
		movea.w	d0,a2
		bset	#0,(a2)

loc_42AAE:
		addq.b	#1,$2E(a0)
		cmpi.b	#$40,$2E(a0)
		bne.s	loc_42AC6
		move.l	#loc_42B08,(a0)
		move.w	#0,(Screen_shake_flag).w

loc_42AC6:
		move.b	$2E(a0),d0
		jsr	(GetSineCosine).l
		asr.w	#1,d0
		add.w	$46(a0),d0
		move.w	d0,y_pos(a0)
		move.b	(Level_frame_counter+1).w,d0
		andi.b	#$F,d0
		bne.s	loc_42AEC
		moveq	#signextendB(sfx_BigRumble),d0
		jsr	(Play_SFX).l

loc_42AEC:
		move.w	#$3B,d1
		move.w	#$40,d2
		move.w	#$41,d3
		move.w	x_pos(a0),d4
		jsr	(SolidObjectFull).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_42B08:
		move.w	#$3B,d1
		move.w	#$40,d2
		move.w	#$41,d3
		move.w	x_pos(a0),d4
		jsr	(SolidObjectFull).l
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------
Map_LRZBigDoor:
		include "Levels/LRZ/Misc Object Data/Map - Big Door.asm"
; ---------------------------------------------------------------------------
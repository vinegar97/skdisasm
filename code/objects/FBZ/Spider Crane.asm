Obj_FBZSpiderCrane:
		move.l	#Map_FBZSpiderCrane,mappings(a0)
		move.w	#make_art_tile($339,1,0),art_tile(a0)
		ori.b	#4,render_flags(a0)
		move.b	#$18,width_pixels(a0)
		move.b	#$60,height_pixels(a0)
		move.w	#$80,priority(a0)
		move.w	x_pos(a0),$44(a0)
		move.w	y_pos(a0),$46(a0)
		bset	#6,render_flags(a0)
		move.w	#1,mainspr_childsprites(a0)
		lea	sub2_x_pos(a0),a2
		move.w	x_pos(a0),(a2)+
		move.w	y_pos(a0),(a2)+
		move.w	#0,(a2)+
		move.b	#$A,mapping_frame(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		lsl.w	#2,d0
		move.w	d0,$38(a0)
		move.l	#loc_3D0F6,(a0)

loc_3D0F6:
		lea	(Player_1).w,a1
		move.w	x_pos(a1),d0
		sub.w	x_pos(a0),d0
		addi.w	#$10,d0
		cmpi.w	#$20,d0
		bhs.s	+ ;loc_3D118
		tst.w	(Debug_placement_mode).w
		bne.s	+ ;loc_3D118
		move.l	#loc_3D11E,(a0)

+ ;loc_3D118:
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------

loc_3D11E:
		cmpi.w	#$40,$34(a0)
		bhs.s	+ ;loc_3D12A
		addq.w	#1,$34(a0)

+ ;loc_3D12A:
		move.w	$34(a0),d0
		add.w	$46(a0),d0
		move.w	d0,y_pos(a0)
		move.w	y_pos(a0),sub2_y_pos(a0)
		move.w	$34(a0),d0
		addq.w	#7,d0
		lsr.w	#3,d0
		move.b	d0,sub2_mapframe(a0)
		lea	(Player_1).w,a1
		move.w	x_pos(a1),d0
		sub.w	x_pos(a0),d0
		addi.w	#$10,d0
		cmpi.w	#$20,d0
		bhs.w	+ ;loc_3D1AC
		move.w	y_pos(a1),d0
		sub.w	y_pos(a0),d0
		subi.w	#5,d0
		cmpi.w	#$14,d0
		bhs.w	+ ;loc_3D1AC
		btst	#Status_InAir,status(a1)
		bne.s	+ ;loc_3D1AC
		move.b	#$E,anim(a1)
		move.b	#$C1,object_control(a1)
		clr.b	spin_dash_flag(a1)
		moveq	#0,d0
		move.b	d0,status(a1)
		move.w	d0,x_vel(a1)
		move.w	d0,y_vel(a1)
		move.b	default_y_radius(a1),y_radius(a1)
		move.b	default_x_radius(a1),x_radius(a1)
		move.l	#loc_3D1B2,(a0)

+ ;loc_3D1AC:
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------

loc_3D1B2:
		move.w	x_pos(a0),(Player_1+x_pos).w
		move.w	y_pos(a0),d0
		addi.w	#$10,d0
		move.w	d0,(Player_1+y_pos).w
		jsr	(AllocateObjectAfterCurrent).l
		bne.w	+ ;loc_3D20E
		move.l	#loc_3D2F6,(a1)
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		move.b	render_flags(a0),render_flags(a1)
		move.l	mappings(a0),mappings(a1)
		move.w	art_tile(a0),art_tile(a1)
		move.w	#$280,priority(a1)
		move.b	#$18,width_pixels(a1)
		move.b	#$18,height_pixels(a1)
		move.b	#$B,mapping_frame(a1)
		move.w	a1,$3C(a0)

+ ;loc_3D20E:
		move.b	#9,mapping_frame(a0)
		move.l	#loc_3D220,(a0)
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------

loc_3D220:
		tst.w	$34(a0)
		beq.s	+ ;loc_3D232
		subq.w	#1,$34(a0)
		bne.s	+ ;loc_3D232
		move.l	#loc_3D278,(a0)

+ ;loc_3D232:
		move.w	$34(a0),d0
		add.w	$46(a0),d0
		move.w	d0,y_pos(a0)
		move.w	y_pos(a0),sub2_y_pos(a0)
		move.w	$34(a0),d0
		addq.w	#7,d0
		lsr.w	#3,d0
		move.b	d0,sub2_mapframe(a0)
		movea.w	$3C(a0),a1
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		move.w	x_pos(a0),(Player_1+x_pos).w
		move.w	y_pos(a0),d0
		addi.w	#$10,d0
		move.w	d0,(Player_1+y_pos).w
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------

loc_3D278:
		tst.b	$36(a0)
		bne.s	+ ;loc_3D29C
		addi.l	#$1000,$30(a0)
		move.w	x_pos(a0),d0
		sub.w	$44(a0),d0
		cmp.w	$38(a0),d0
		blt.s	++ ;loc_3D2D2
		move.b	#1,$36(a0)
		bra.s	++ ;loc_3D2D2
; ---------------------------------------------------------------------------

+ ;loc_3D29C:
		subi.l	#$1000,$30(a0)
		bne.s	+ ;loc_3D2D2
		lea	(Player_1).w,a1
		move.b	#0,anim(a1)
		move.b	#0,object_control(a1)
		bset	#Status_InAir,status(a1)
		move.l	#loc_3D2F6,(a0)
		move.b	#$A,mapping_frame(a0)
		movea.w	$3C(a0),a1
		move.b	#0,mapping_frame(a1)

+ ;loc_3D2D2:
		move.l	$30(a0),d0
		add.l	d0,x_pos(a0)
		move.w	x_pos(a0),x_vel(a0)
		movea.w	$3C(a0),a1
		move.w	x_pos(a0),x_pos(a1)
		move.w	x_pos(a0),(Player_1+x_pos).w
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------

loc_3D2F6:
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------
Map_FBZSpiderCrane:
		include "Levels/FBZ/Misc Object Data/Map - Spider Crane.asm"
; ---------------------------------------------------------------------------

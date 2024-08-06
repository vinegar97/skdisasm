Obj_CNZTriangleBumpers:
		moveq	#0,d0
		move.b	subtype(a0),d0
		move.w	d0,$34(a0)
		add.w	d0,d0
		move.w	d0,$32(a0)
		move.l	#loc_31C36,(a0)

loc_31C36:
		lea	(Player_1).w,a1
		bsr.s	+ ;sub_31C48
		lea	(Player_2).w,a1
		bsr.s	+ ;sub_31C48
		jmp	(Delete_Sprite_If_Not_In_Range).l

; =============== S U B R O U T I N E =======================================


+ ;sub_31C48:
		move.w	x_pos(a1),d0
		sub.w	x_pos(a0),d0
		add.w	$34(a0),d0
		cmp.w	$32(a0),d0
		bhs.s	locret_31C74
		move.w	y_pos(a1),d1
		sub.w	y_pos(a0),d1
		addi.w	#$14,d1
		cmpi.w	#$28,d1
		bhs.s	locret_31C74
		cmpi.b	#4,routine(a1)
		blo.s	+ ;loc_31C76

locret_31C74:
		rts
; ---------------------------------------------------------------------------

+ ;loc_31C76:
		move.w	#-$800,x_vel(a1)
		move.w	#-$800,y_vel(a1)
		bset	#Status_Facing,status(a1)
		btst	#0,status(a0)
		bne.s	+ ;loc_31C9A
		bclr	#Status_Facing,status(a1)
		neg.w	x_vel(a1)

+ ;loc_31C9A:
		btst	#1,status(a0)
		beq.s	+ ;loc_31CA6
		neg.w	y_vel(a1)

+ ;loc_31CA6:
		move.w	#15,move_lock(a1)
		move.w	x_vel(a1),ground_vel(a1)
		btst	#Status_Roll,status(a1)
		bne.s	+ ;loc_31CC0
		move.b	#0,anim(a1)

+ ;loc_31CC0:
		tst.b	flip_angle(a1)
		bne.s	+ ;loc_31CEA
		move.b	#1,flip_angle(a1)
		move.b	#0,anim(a1)
		move.b	#3,flips_remaining(a1)
		move.b	#8,flip_speed(a1)
		btst	#Status_Facing,status(a1)
		beq.s	+ ;loc_31CEA
		neg.b	flip_angle(a1)

+ ;loc_31CEA:
		clr.b	jumping(a1)
		bset	#Status_InAir,status(a1)
		bclr	#Status_RollJump,status(a1)
		bclr	#Status_Push,status(a1)
		moveq	#signextendB(sfx_SmallBumpers),d0
		jmp	(Play_SFX).l
; End of function sub_31C48

; ---------------------------------------------------------------------------

Obj_SinkingMud:
		move.b	subtype(a0),d0
		lsl.w	#3,d0
		move.b	d0,width_pixels(a0)
		move.w	y_pos(a0),$30(a0)
		move.b	#$30,$38(a0)
		move.b	#$30,$3A(a0)
		bset	#7,status(a0)
		move.l	#loc_31E1C,(a0)
		tst.w	(Competition_mode).w
		bne.w	loc_31E1C
		move.l	#loc_31D3E,(a0)

loc_31D3E:
		tst.w	(Debug_placement_mode).w
		bne.w	loc_31DF2
		lea	(Player_1).w,a1
		btst	#p1_standing_bit,status(a0)
		bne.s	++ ;loc_31D7A
		cmpi.b	#$30,$38(a0)
		bhs.s	+ ;loc_31D5E
		addq.b	#2,$38(a0)

+ ;loc_31D5E:
		btst	#Status_OnObj,status(a1)
		beq.s	++ ;loc_31D84
		movea.w	interact(a1),a2
		cmpi.l	#loc_31D3E,(a2)
		bne.s	++ ;loc_31D84
		move.b	$38(a2),$38(a0)
		bra.s	++ ;loc_31D84
; ---------------------------------------------------------------------------

+ ;loc_31D7A:
		tst.b	$38(a0)
		beq.s	loc_31DF8
		subq.b	#1,$38(a0)

+ ;loc_31D84:
		moveq	#0,d1
		move.b	width_pixels(a0),d1
		moveq	#0,d3
		move.b	$38(a0),d3
		moveq	#p1_standing_bit,d6
		move.w	x_pos(a0),d4
		jsr	(SolidObjectTop_1P).l
		lea	(Player_2).w,a1
		btst	#p2_standing_bit,status(a0)
		bne.s	loc_31DD0
		cmpi.b	#$30,$3A(a0)
		bhs.s	+ ;loc_31DB4
		addq.b	#2,$3A(a0)

+ ;loc_31DB4:
		btst	#Status_OnObj,status(a1)
		beq.s	+ ;loc_31DDA
		movea.w	interact(a1),a2
		cmpi.l	#loc_31D3E,(a2)
		bne.s	+ ;loc_31DDA
		move.b	$3A(a2),$3A(a0)
		bra.s	+ ;loc_31DDA
; ---------------------------------------------------------------------------

loc_31DD0:
		tst.b	$3A(a0)
		beq.s	++ ;loc_31E00
		subq.b	#1,$3A(a0)

+ ;loc_31DDA:
		moveq	#0,d1
		move.b	width_pixels(a0),d1
		moveq	#0,d3
		move.b	$3A(a0),d3
		moveq	#p2_standing_bit,d6
		move.w	x_pos(a0),d4
		jsr	(SolidObjectTop_1P).l

loc_31DF2:
		jmp	(Delete_Sprite_If_Not_In_Range).l
; ---------------------------------------------------------------------------

loc_31DF8:
		move.b	#$30,$38(a0)
		bra.s	++ ;loc_31E06
; ---------------------------------------------------------------------------

+ ;loc_31E00:
		move.b	#$30,$3A(a0)

+ ;loc_31E06:
		not.b	d1
		and.b	d1,status(a0)
		move.l	a0,-(sp)
		movea.l	a0,a2
		movea.l	a1,a0
		jsr	(Kill_Character).l
		movea.l	(sp)+,a0
		rts
; ---------------------------------------------------------------------------

loc_31E1C:
		tst.w	(Debug_placement_mode).w
		bne.w	locret_31ED4
		lea	(Player_1).w,a1
		btst	#p1_standing_bit,status(a0)
		bne.s	++ ;loc_31E58
		cmpi.b	#$30,$38(a0)
		bhs.s	+ ;loc_31E3C
		addq.b	#2,$38(a0)

+ ;loc_31E3C:
		btst	#Status_OnObj,status(a1)
		beq.s	++ ;loc_31E62
		movea.w	interact(a1),a2
		cmpi.l	#loc_31D3E,(a2)
		bne.s	++ ;loc_31E62
		move.b	$38(a2),$38(a0)
		bra.s	++ ;loc_31E62
; ---------------------------------------------------------------------------

+ ;loc_31E58:
		tst.b	$38(a0)
		beq.s	loc_31ED6
		subq.b	#1,$38(a0)

+ ;loc_31E62:
		moveq	#0,d1
		move.b	width_pixels(a0),d1
		moveq	#0,d3
		move.b	$38(a0),d3
		lsr.w	#1,d3
		moveq	#p1_standing_bit,d6
		move.w	x_pos(a0),d4
		jsr	(SolidObjectTop_1P).l
		lea	(Player_2).w,a1
		btst	#p2_standing_bit,status(a0)
		bne.s	++ ;loc_31EB0
		cmpi.b	#$30,$3A(a0)
		bhs.s	+ ;loc_31E94
		addq.b	#2,$3A(a0)

+ ;loc_31E94:
		btst	#Status_OnObj,status(a1)
		beq.s	++ ;loc_31EBA
		movea.w	interact(a1),a2
		cmpi.l	#loc_31D3E,(a2)
		bne.s	++ ;loc_31EBA
		move.b	$3A(a2),$3A(a0)
		bra.s	++ ;loc_31EBA
; ---------------------------------------------------------------------------

+ ;loc_31EB0:
		tst.b	$3A(a0)
		beq.s	++ ;loc_31EDE
		subq.b	#1,$3A(a0)

+ ;loc_31EBA:
		moveq	#0,d1
		move.b	width_pixels(a0),d1
		moveq	#0,d3
		move.b	$3A(a0),d3
		lsr.w	#1,d3
		moveq	#p2_standing_bit,d6
		move.w	x_pos(a0),d4
		jsr	(SolidObjectTop_1P).l

locret_31ED4:
		rts
; ---------------------------------------------------------------------------

loc_31ED6:
		move.b	#$30,$38(a0)
		bra.s	++ ;loc_31EE4
; ---------------------------------------------------------------------------

+ ;loc_31EDE:
		move.b	#$30,$3A(a0)

+ ;loc_31EE4:
		not.b	d1
		and.b	d1,status(a0)
		move.l	a0,-(sp)
		movea.l	a0,a2
		movea.l	a1,a0
		jsr	(Kill_Character).l
		movea.l	(sp)+,a0
		rts
; ---------------------------------------------------------------------------

Obj_CGZTriangleBumpers:
		move.b	#8,width_pixels(a0)
		move.b	#$40,height_pixels(a0)
		move.b	subtype(a0),d0
		lsr.b	#4,d0
		andi.b	#7,d0
		move.b	d0,mapping_frame(a0)
		beq.s	+ ;loc_31F1C
		move.b	#$80,height_pixels(a0)

+ ;loc_31F1C:
		move.l	#loc_31F22,(a0)

loc_31F22:
		move.w	#$10,d1
		moveq	#0,d2
		move.b	height_pixels(a0),d2
		move.w	d2,d3
		addq.w	#1,d3
		move.w	x_pos(a0),d4
		lea	(Player_1).w,a1
		moveq	#p1_standing_bit,d6
		movem.l	d1-d4,-(sp)
		jsr	(SolidObjectFull2_1P).l
		cmpi.b	#1,d4
		bne.s	++ ;loc_31F6C
		btst	#Status_InAir,status(a1)
		beq.s	++ ;loc_31F6C
		move.b	status(a0),d1
		move.w	x_pos(a0),d0
		sub.w	x_pos(a1),d0
		bcs.s	+ ;loc_31F64
		eori.b	#1,d1

+ ;loc_31F64:
		andi.b	#1,d1
		bne.s	+ ;loc_31F6C
		bsr.s	sub_31FA6

+ ;loc_31F6C:
		movem.l	(sp)+,d1-d4
		lea	(Player_2).w,a1
		moveq	#p2_standing_bit,d6
		jsr	(SolidObjectFull2_1P).l
		cmpi.b	#1,d4
		bne.s	locret_31FA4
		btst	#Status_InAir,status(a1)
		beq.s	locret_31FA4
		move.b	status(a0),d1
		move.w	x_pos(a0),d0
		sub.w	x_pos(a1),d0
		bcs.s	+ ;loc_31F9C
		eori.b	#1,d1

+ ;loc_31F9C:
		andi.b	#1,d1
		bne.s	locret_31FA4
		bsr.s	sub_31FA6

locret_31FA4:
		rts

; =============== S U B R O U T I N E =======================================


sub_31FA6:
		cmpi.b	#4,routine(a1)
		blo.s	+ ;loc_31FB0
		rts
; ---------------------------------------------------------------------------

+ ;loc_31FB0:
		move.w	#-$800,x_vel(a1)
		move.w	#$400,y_vel(a1)
		bset	#Status_Facing,status(a1)
		btst	#0,status(a0)
		bne.s	+ ;loc_31FD4
		bclr	#Status_Facing,status(a1)
		neg.w	x_vel(a1)

+ ;loc_31FD4:
		move.w	#15,move_lock(a1)
		move.w	x_vel(a1),ground_vel(a1)
		btst	#Status_Roll,status(a1)
		bne.s	+ ;loc_31FEE
		move.b	#0,anim(a1)

+ ;loc_31FEE:
		move.b	subtype(a0),d0
		bpl.s	+ ;loc_31FFA
		move.w	#0,y_vel(a1)

+ ;loc_31FFA:
		btst	#0,d0
		beq.s	++ ;loc_3203A
		move.w	#1,ground_vel(a1)
		move.b	#1,flip_angle(a1)
		move.b	#0,anim(a1)
		move.b	#1,flips_remaining(a1)
		move.b	#8,flip_speed(a1)
		btst	#1,d0
		bne.s	+ ;loc_3202A
		move.b	#3,flips_remaining(a1)

+ ;loc_3202A:
		btst	#Status_Facing,status(a1)
		beq.s	+ ;loc_3203A
		neg.b	flip_angle(a1)
		neg.w	ground_vel(a1)

+ ;loc_3203A:
		andi.b	#$C,d0
		cmpi.b	#4,d0
		bne.s	+ ;loc_32050
		move.b	#$C,top_solid_bit(a1)
		move.b	#$D,lrb_solid_bit(a1)

+ ;loc_32050:
		cmpi.b	#8,d0
		bne.s	+ ;loc_32062
		move.b	#$E,top_solid_bit(a1)
		move.b	#$F,lrb_solid_bit(a1)

+ ;loc_32062:
		bclr	#5,status(a0)
		bclr	#6,status(a0)
		bclr	#Status_Push,status(a1)
		bclr	#Status_RollJump,status(a1)
		moveq	#signextendB(sfx_SmallBumpers),d0
		jmp	(Play_SFX).l
; End of function sub_31FA6

; ---------------------------------------------------------------------------

Obj_Bumper:
		move.l	#Map_Bumper,mappings(a0)
		move.w	#make_art_tile($364,2,0),art_tile(a0)
		move.b	#4,render_flags(a0)
		move.b	#$10,width_pixels(a0)
		move.b	#$10,height_pixels(a0)
		move.w	#$80,priority(a0)
		move.b	#$D7,collision_flags(a0)
		move.w	x_pos(a0),$30(a0)
		move.w	y_pos(a0),$32(a0)
		tst.w	(Competition_mode).w
		beq.s	+ ;loc_320D8
		move.l	#Map_2PBumper,mappings(a0)
		move.w	#make_art_tile($300,1,0),art_tile(a0)
		move.l	#loc_3221C,(a0)
		bra.w	loc_3221C
; ---------------------------------------------------------------------------

+ ;loc_320D8:
		move.l	#loc_3211A,(a0)
		move.b	subtype(a0),d0
		beq.s	loc_3211A
		move.b	d0,angle(a0)
		move.l	#loc_320EE,(a0)

loc_320EE:
		move.b	(Level_frame_counter+1).w,d0
		btst	#0,status(a0)
		beq.s	+ ;loc_320FC
		neg.b	d0

+ ;loc_320FC:
		add.b	angle(a0),d0
		jsr	(GetSineCosine).l
		asr.w	#2,d1
		asr.w	#2,d0
		add.w	$30(a0),d1
		add.w	$32(a0),d0
		move.w	d1,x_pos(a0)
		move.w	d0,y_pos(a0)

loc_3211A:
		tst.b	collision_property(a0)
		beq.w	loc_321E0
		lea	(Player_1).w,a1
		bclr	#0,collision_property(a0)
		beq.s	+ ;loc_32130
		bsr.s	+++ ;sub_32146

+ ;loc_32130:
		lea	(Player_2).w,a1
		bclr	#1,collision_property(a0)
		beq.s	+ ;loc_3213E
		bsr.s	++ ;sub_32146

+ ;loc_3213E:
		clr.b	collision_property(a0)
		bra.w	loc_321E0

; =============== S U B R O U T I N E =======================================


+ ;sub_32146:
		move.w	x_pos(a0),d1
		move.w	y_pos(a0),d2
		sub.w	x_pos(a1),d1
		sub.w	y_pos(a1),d2
		jsr	(GetArcTan).l
		move.b	(Level_frame_counter).w,d1
		andi.w	#3,d1
		add.w	d1,d0
		jsr	(GetSineCosine).l
		muls.w	#-$700,d1
		asr.l	#8,d1
		move.w	d1,x_vel(a1)
		muls.w	#-$700,d0
		asr.l	#8,d0
		move.w	d0,y_vel(a1)
		bset	#Status_InAir,status(a1)
		bclr	#Status_RollJump,status(a1)
		bclr	#Status_Push,status(a1)
		clr.b	jumping(a1)
		move.b	#1,anim(a0)
		moveq	#signextendB(sfx_Bumper),d0
		jsr	(Play_SFX).l
		move.w	respawn_addr(a0),d0
		beq.s	+ ;loc_321B4
		movea.w	d0,a2
		cmpi.b	#$8A,(a2)
		bhs.s	locret_321DE
		addq.b	#1,(a2)

+ ;loc_321B4:
		moveq	#1,d0
		movea.w	a1,a3
		jsr	(HUD_AddToScore).l
		jsr	(AllocateObject).l
		bne.s	locret_321DE
		move.l	#Obj_EnemyScore,(a1)
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		move.b	#4,mapping_frame(a1)

locret_321DE:
		rts
; End of function sub_32146

; ---------------------------------------------------------------------------

loc_321E0:
		lea	(Ani_Bumper).l,a1
		jsr	(Animate_Sprite).l
		move.w	$30(a0),d0
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.s	+ ;loc_3220A
		jsr	(Add_SpriteToCollisionResponseList).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

+ ;loc_3220A:
		move.w	respawn_addr(a0),d0
		beq.s	+ ;loc_32216
		movea.w	d0,a2
		bclr	#7,(a2)

+ ;loc_32216:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_3221C:
		tst.b	collision_property(a0)
		beq.w	loc_322A8
		lea	(Player_1).w,a1
		bclr	#0,collision_property(a0)
		beq.s	+ ;loc_32232
		bsr.s	+++ ;sub_32248

+ ;loc_32232:
		lea	(Player_2).w,a1
		bclr	#1,collision_property(a0)
		beq.s	+ ;loc_32240
		bsr.s	++ ;sub_32248

+ ;loc_32240:
		clr.b	collision_property(a0)
		bra.w	loc_322A8

; =============== S U B R O U T I N E =======================================


+ ;sub_32248:
		move.w	x_pos(a0),d1
		move.w	y_pos(a0),d2
		sub.w	x_pos(a1),d1
		sub.w	y_pos(a1),d2
		jsr	(GetArcTan).l
		move.b	(Level_frame_counter).w,d1
		andi.w	#3,d1
		add.w	d1,d0
		jsr	(GetSineCosine).l
		muls.w	#-$700,d1
		asr.l	#8,d1
		move.w	d1,x_vel(a1)
		muls.w	#-$700,d0
		asr.l	#8,d0
		move.w	d0,y_vel(a1)
		bset	#Status_InAir,status(a1)
		bclr	#Status_RollJump,status(a1)
		bclr	#Status_Push,status(a1)
		clr.b	jumping(a1)
		move.b	#1,anim(a0)
		moveq	#signextendB(sfx_SmallBumpers),d0
		jsr	(Play_SFX).l
		rts
; End of function sub_32248

; ---------------------------------------------------------------------------

loc_322A8:
		lea	(Ani_Bumper).l,a1
		jsr	(Animate_Sprite).l
		jsr	(Add_SpriteToCollisionResponseList).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
Ani_Bumper:
		include "General/Sprites/Level Misc/Anim - Bumper.asm"
Map_Bumper:
		include "General/Sprites/Level Misc/Map - Bumper.asm"
Map_2PBumper:
		include "General/2P Zone/Map - 2P Bumper.asm"

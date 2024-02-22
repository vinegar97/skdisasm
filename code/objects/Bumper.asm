Obj_CNZTriangleBumpers:
		moveq	#0,d0
		move.b	subtype(a0),d0
		move.w	d0,$34(a0)
		add.w	d0,d0
		move.w	d0,$32(a0)
		move.l	#loc_329A6,(a0)

loc_329A6:
		lea	(Player_1).w,a1
		bsr.s	sub_329B8
		lea	(Player_2).w,a1
		bsr.s	sub_329B8
		jmp	(Delete_Sprite_If_Not_In_Range).l

; =============== S U B R O U T I N E =======================================


sub_329B8:
		move.w	x_pos(a1),d0
		sub.w	x_pos(a0),d0
		add.w	$34(a0),d0
		cmp.w	$32(a0),d0
		bhs.s	locret_329E4
		move.w	y_pos(a1),d1
		sub.w	y_pos(a0),d1
		addi.w	#$14,d1
		cmpi.w	#$28,d1
		bhs.s	locret_329E4
		cmpi.b	#4,routine(a1)
		blo.s	loc_329E6

locret_329E4:
		rts
; ---------------------------------------------------------------------------

loc_329E6:
		move.w	#-$800,x_vel(a1)
		move.w	#-$800,y_vel(a1)
		bset	#Status_Facing,status(a1)
		btst	#0,status(a0)
		bne.s	loc_32A0A
		bclr	#Status_Facing,status(a1)
		neg.w	x_vel(a1)

loc_32A0A:
		btst	#1,status(a0)
		beq.s	loc_32A16
		neg.w	y_vel(a1)

loc_32A16:
		move.w	#15,move_lock(a1)
		move.w	x_vel(a1),ground_vel(a1)
		btst	#Status_Roll,status(a1)
		bne.s	loc_32A30
		move.b	#0,anim(a1)

loc_32A30:
		tst.b	flip_angle(a1)
		bne.s	loc_32A5A
		move.b	#1,flip_angle(a1)
		move.b	#0,anim(a1)
		move.b	#3,flips_remaining(a1)
		move.b	#8,flip_speed(a1)
		btst	#Status_Facing,status(a1)
		beq.s	loc_32A5A
		neg.b	flip_angle(a1)

loc_32A5A:
		clr.b	jumping(a1)
		bset	#Status_InAir,status(a1)
		bclr	#Status_RollJump,status(a1)
		bclr	#Status_Push,status(a1)
		moveq	#signextendB(sfx_SmallBumpers),d0
		jmp	(Play_SFX).l
; End of function sub_329B8

; ---------------------------------------------------------------------------

Obj_SinkingMud:
		move.b	subtype(a0),d0
		lsl.w	#3,d0
		move.b	d0,width_pixels(a0)
		move.w	y_pos(a0),$30(a0)
		move.b	#$30,$38(a0)
		move.b	#$30,$3A(a0)
		bset	#7,status(a0)
		move.l	#loc_32B8C,(a0)
		tst.w	(Competition_mode).w
		bne.w	loc_32B8C
		move.l	#loc_32AAE,(a0)

loc_32AAE:
		tst.w	(Debug_placement_mode).w
		bne.w	loc_32B62
		lea	(Player_1).w,a1
		btst	#p1_standing_bit,status(a0)
		bne.s	loc_32AEA
		cmpi.b	#$30,$38(a0)
		bhs.s	loc_32ACE
		addq.b	#2,$38(a0)

loc_32ACE:
		btst	#Status_OnObj,status(a1)
		beq.s	loc_32AF4
		movea.w	interact(a1),a2
		cmpi.l	#loc_32AAE,(a2)
		bne.s	loc_32AF4
		move.b	$38(a2),$38(a0)
		bra.s	loc_32AF4
; ---------------------------------------------------------------------------

loc_32AEA:
		tst.b	$38(a0)
		beq.s	loc_32B68
		subq.b	#1,$38(a0)

loc_32AF4:
		moveq	#0,d1
		move.b	width_pixels(a0),d1
		moveq	#0,d3
		move.b	$38(a0),d3
		moveq	#p1_standing_bit,d6
		move.w	x_pos(a0),d4
		jsr	(SolidObjectTop_1P).l
		lea	(Player_2).w,a1
		btst	#p2_standing_bit,status(a0)
		bne.s	loc_32B40
		cmpi.b	#$30,$3A(a0)
		bhs.s	loc_32B24
		addq.b	#2,$3A(a0)

loc_32B24:
		btst	#Status_OnObj,status(a1)
		beq.s	loc_32B4A
		movea.w	interact(a1),a2
		cmpi.l	#loc_32AAE,(a2)
		bne.s	loc_32B4A
		move.b	$3A(a2),$3A(a0)
		bra.s	loc_32B4A
; ---------------------------------------------------------------------------

loc_32B40:
		tst.b	$3A(a0)
		beq.s	loc_32B70
		subq.b	#1,$3A(a0)

loc_32B4A:
		moveq	#0,d1
		move.b	width_pixels(a0),d1
		moveq	#0,d3
		move.b	$3A(a0),d3
		moveq	#p2_standing_bit,d6
		move.w	x_pos(a0),d4
		jsr	(SolidObjectTop_1P).l

loc_32B62:
		jmp	(Delete_Sprite_If_Not_In_Range).l
; ---------------------------------------------------------------------------

loc_32B68:
		move.b	#$30,$38(a0)
		bra.s	loc_32B76
; ---------------------------------------------------------------------------

loc_32B70:
		move.b	#$30,$3A(a0)

loc_32B76:
		not.b	d1
		and.b	d1,status(a0)
		move.l	a0,-(sp)
		movea.l	a0,a2
		movea.l	a1,a0
		jsr	(Kill_Character).l
		movea.l	(sp)+,a0
		rts
; ---------------------------------------------------------------------------

loc_32B8C:
		tst.w	(Debug_placement_mode).w
		bne.w	locret_32C44
		lea	(Player_1).w,a1
		btst	#p1_standing_bit,status(a0)
		bne.s	loc_32BC8
		cmpi.b	#$30,$38(a0)
		bhs.s	loc_32BAC
		addq.b	#2,$38(a0)

loc_32BAC:
		btst	#Status_OnObj,status(a1)
		beq.s	loc_32BD2
		movea.w	interact(a1),a2
		cmpi.l	#loc_32AAE,(a2)
		bne.s	loc_32BD2
		move.b	$38(a2),$38(a0)
		bra.s	loc_32BD2
; ---------------------------------------------------------------------------

loc_32BC8:
		tst.b	$38(a0)
		beq.s	loc_32C46
		subq.b	#1,$38(a0)

loc_32BD2:
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
		bne.s	loc_32C20
		cmpi.b	#$30,$3A(a0)
		bhs.s	loc_32C04
		addq.b	#2,$3A(a0)

loc_32C04:
		btst	#Status_OnObj,status(a1)
		beq.s	loc_32C2A
		movea.w	interact(a1),a2
		cmpi.l	#loc_32AAE,(a2)
		bne.s	loc_32C2A
		move.b	$3A(a2),$3A(a0)
		bra.s	loc_32C2A
; ---------------------------------------------------------------------------

loc_32C20:
		tst.b	$3A(a0)
		beq.s	loc_32C4E
		subq.b	#1,$3A(a0)

loc_32C2A:
		moveq	#0,d1
		move.b	width_pixels(a0),d1
		moveq	#0,d3
		move.b	$3A(a0),d3
		lsr.w	#1,d3
		moveq	#p2_standing_bit,d6
		move.w	x_pos(a0),d4
		jsr	(SolidObjectTop_1P).l

locret_32C44:
		rts
; ---------------------------------------------------------------------------

loc_32C46:
		move.b	#$30,$38(a0)
		bra.s	loc_32C54
; ---------------------------------------------------------------------------

loc_32C4E:
		move.b	#$30,$3A(a0)

loc_32C54:
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
		beq.s	loc_32C8C
		move.b	#$80,height_pixels(a0)

loc_32C8C:
		move.l	#loc_32C92,(a0)

loc_32C92:
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
		bne.s	loc_32CDC
		btst	#Status_InAir,status(a1)
		beq.s	loc_32CDC
		move.b	status(a0),d1
		move.w	x_pos(a0),d0
		sub.w	x_pos(a1),d0
		bcs.s	loc_32CD4
		eori.b	#1,d1

loc_32CD4:
		andi.b	#1,d1
		bne.s	loc_32CDC
		bsr.s	sub_32D16

loc_32CDC:
		movem.l	(sp)+,d1-d4
		lea	(Player_2).w,a1
		moveq	#p2_standing_bit,d6
		jsr	(SolidObjectFull2_1P).l
		cmpi.b	#1,d4
		bne.s	locret_32D14
		btst	#Status_InAir,status(a1)
		beq.s	locret_32D14
		move.b	status(a0),d1
		move.w	x_pos(a0),d0
		sub.w	x_pos(a1),d0
		bcs.s	loc_32D0C
		eori.b	#1,d1

loc_32D0C:
		andi.b	#1,d1
		bne.s	locret_32D14
		bsr.s	sub_32D16

locret_32D14:
		rts

; =============== S U B R O U T I N E =======================================


sub_32D16:
		cmpi.b	#4,routine(a1)
		blo.s	loc_32D20
		rts
; ---------------------------------------------------------------------------

loc_32D20:
		move.w	#-$800,x_vel(a1)
		move.w	#$400,y_vel(a1)
		bset	#Status_Facing,status(a1)
		btst	#0,status(a0)
		bne.s	loc_32D44
		bclr	#Status_Facing,status(a1)
		neg.w	x_vel(a1)

loc_32D44:
		move.w	#15,move_lock(a1)
		move.w	x_vel(a1),ground_vel(a1)
		btst	#Status_Roll,status(a1)
		bne.s	loc_32D5E
		move.b	#0,anim(a1)

loc_32D5E:
		move.b	subtype(a0),d0
		bpl.s	loc_32D6A
		move.w	#0,y_vel(a1)

loc_32D6A:
		btst	#0,d0
		beq.s	loc_32DAA
		move.w	#1,ground_vel(a1)
		move.b	#1,flip_angle(a1)
		move.b	#0,anim(a1)
		move.b	#1,flips_remaining(a1)
		move.b	#8,flip_speed(a1)
		btst	#1,d0
		bne.s	loc_32D9A
		move.b	#3,flips_remaining(a1)

loc_32D9A:
		btst	#Status_Facing,status(a1)
		beq.s	loc_32DAA
		neg.b	flip_angle(a1)
		neg.w	ground_vel(a1)

loc_32DAA:
		andi.b	#$C,d0
		cmpi.b	#4,d0
		bne.s	loc_32DC0
		move.b	#$C,top_solid_bit(a1)
		move.b	#$D,lrb_solid_bit(a1)

loc_32DC0:
		cmpi.b	#8,d0
		bne.s	loc_32DD2
		move.b	#$E,top_solid_bit(a1)
		move.b	#$F,lrb_solid_bit(a1)

loc_32DD2:
		bclr	#5,status(a0)
		bclr	#6,status(a0)
		bclr	#Status_Push,status(a1)
		bclr	#Status_RollJump,status(a1)
		moveq	#signextendB(sfx_SmallBumpers),d0
		jmp	(Play_SFX).l
; End of function sub_32D16

; ---------------------------------------------------------------------------

Obj_Bumper:
		move.b	#4,render_flags(a0)
		move.b	#$10,width_pixels(a0)
		move.b	#$10,height_pixels(a0)
		move.w	#$80,priority(a0)
		move.b	#$D7,collision_flags(a0)
		move.w	x_pos(a0),$30(a0)
		move.w	y_pos(a0),$32(a0)
		cmpi.b	#$14,(Current_zone).w
		bne.s	loc_32E3C
		move.l	#Map_PachinkoBumper,mappings(a0)
		move.w	#make_art_tile($2CD,3,0),art_tile(a0)
		move.l	#loc_32EF0,(a0)
		bra.w	loc_32EF0
; ---------------------------------------------------------------------------

loc_32E3C:
		tst.w	(Competition_mode).w
		beq.s	loc_32E5A
		move.l	#Map_2PBumper,mappings(a0)
		move.w	#make_art_tile($300,1,0),art_tile(a0)
		move.l	#loc_32FF0,(a0)
		bra.w	loc_32FF0
; ---------------------------------------------------------------------------

loc_32E5A:
		move.l	#Map_Bumper,mappings(a0)
		move.w	#make_art_tile($364,2,0),art_tile(a0)
		move.l	#loc_32EAA,(a0)
		move.b	subtype(a0),d0
		beq.s	loc_32EAA
		move.b	d0,angle(a0)
		move.l	#loc_32E7E,(a0)

loc_32E7E:
		move.b	(Level_frame_counter+1).w,d0
		btst	#0,status(a0)
		beq.s	loc_32E8C
		neg.b	d0

loc_32E8C:
		add.b	angle(a0),d0
		jsr	(GetSineCosine).l
		asr.w	#2,d1
		asr.w	#2,d0
		add.w	$30(a0),d1
		add.w	$32(a0),d0
		move.w	d1,x_pos(a0)
		move.w	d0,y_pos(a0)

loc_32EAA:
		tst.b	collision_property(a0)
		beq.s	loc_32EB4
		bsr.w	sub_32F34

loc_32EB4:
		lea	(Ani_Bumper).l,a1
		jsr	(Animate_Sprite).l
		move.w	$30(a0),d0
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.s	loc_32EDE
		jsr	(Add_SpriteToCollisionResponseList).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_32EDE:
		move.w	respawn_addr(a0),d0
		beq.s	loc_32EEA
		movea.w	d0,a2
		bclr	#7,(a2)

loc_32EEA:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_32EF0:
		tst.b	collision_property(a0)
		beq.s	loc_32EF8
		bsr.s	sub_32F34

loc_32EF8:
		lea	(Ani_Bumper).l,a1
		jsr	(Animate_Sprite).l
		move.w	y_pos(a0),d0
		andi.w	#$FF80,d0
		sub.w	(Camera_Y_pos_coarse_back).w,d0
		cmpi.w	#$200,d0
		bhi.s	loc_32F22
		jsr	(Add_SpriteToCollisionResponseList).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_32F22:
		move.w	respawn_addr(a0),d0
		beq.s	loc_32F2E
		movea.w	d0,a2
		bclr	#7,(a2)

loc_32F2E:
		jmp	(Delete_Current_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_32F34:
		lea	(Player_1).w,a1
		bclr	#0,collision_property(a0)
		beq.s	loc_32F42
		bsr.s	sub_32F56

loc_32F42:
		lea	(Player_2).w,a1
		bclr	#1,collision_property(a0)
		beq.s	loc_32F50
		bsr.s	sub_32F56

loc_32F50:
		clr.b	collision_property(a0)
		rts
; End of function sub_32F34


; =============== S U B R O U T I N E =======================================


sub_32F56:
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
		beq.s	loc_32FC4
		movea.w	d0,a2
		cmpi.b	#$8A,(a2)
		bhs.s	locret_32FEE
		addq.b	#1,(a2)

loc_32FC4:
		moveq	#1,d0
		movea.w	a1,a3
		jsr	(HUD_AddToScore).l
		jsr	(AllocateObject).l
		bne.s	locret_32FEE
		move.l	#Obj_EnemyScore,(a1)
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		move.b	#4,mapping_frame(a1)

locret_32FEE:
		rts
; End of function sub_32F56

; ---------------------------------------------------------------------------

loc_32FF0:
		tst.b	collision_property(a0)
		beq.w	loc_3307C
		lea	(Player_1).w,a1
		bclr	#0,collision_property(a0)
		beq.s	loc_33006
		bsr.s	sub_3301C

loc_33006:
		lea	(Player_2).w,a1
		bclr	#1,collision_property(a0)
		beq.s	loc_33014
		bsr.s	sub_3301C

loc_33014:
		clr.b	collision_property(a0)
		bra.w	loc_3307C

; =============== S U B R O U T I N E =======================================


sub_3301C:
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
; End of function sub_3301C

; ---------------------------------------------------------------------------

loc_3307C:
		lea	(Ani_Bumper).l,a1
		jsr	(Animate_Sprite).l
		jsr	(Add_SpriteToCollisionResponseList).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
Ani_Bumper:
		include "General/Sprites/Level Misc/Anim - Bumper.asm"
Map_PachinkoBumper:
		include "Levels/Pachinko/Misc Object Data/Map - Bumper.asm"

loc_393EE:
		move.w	#make_art_tile(ArtTile_Player_1,0,0),art_tile(a0)
		move.l	#Map_SonicSnowboard,mappings(a0)
		move.w	#$100,priority(a0)
		move.b	#$20,width_pixels(a0)
		move.b	#$20,height_pixels(a0)
		move.b	#4,render_flags(a0)
		move.b	#6,mapping_frame(a0)
		move.w	#1,anim(a0)
		jsr	(AllocateObjectAfterCurrent).l
		bne.w	loc_39434
		move.l	#loc_398E0,(a1)
		move.w	a0,$30(a1)

loc_39434:
		move.l	#loc_3943A,(a0)

loc_3943A:
		lea	(Player_1).w,a1
		move.w	x_pos(a1),x_pos(a0)
		move.w	y_pos(a1),y_pos(a0)
		btst	#Status_InAir,status(a1)
		bne.s	loc_3945E
		move.b	#1,anim(a0)
		move.l	#loc_394A0,(a0)

loc_3945E:
		lea	(Ani_SonicSnowboard).l,a1
		jsr	(Animate_Sprite).l
		jsr	(sub_3968E).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
Ani_SonicSnowboard:
		include "General/Sprites/Sonic/Anim - Sonic Snowboard.asm"
; ---------------------------------------------------------------------------

loc_394A0:
		lea	(Player_1).w,a2
		move.w	x_pos(a2),x_pos(a0)
		move.w	y_pos(a2),y_pos(a0)
		moveq	#0,d0
		move.b	angle(a2),d0
		addq.b	#5,d0
		lsr.w	#4,d0
		move.b	byte_394F2(pc,d0.w),anim(a0)
		btst	#Status_InAir,status(a2)
		beq.s	loc_39502
		move.b	#0,anim(a0)
		tst.w	x_vel(a2)
		beq.s	loc_394E2
		cmpi.w	#$1000,x_vel(a2)
		blt.s	loc_394E2
		move.w	#$1000,x_vel(a2)

loc_394E2:
		cmpi.w	#-$200,y_vel(a2)
		bge.s	loc_39554
		move.w	#-$200,y_vel(a2)
		bra.s	loc_39554
; ---------------------------------------------------------------------------
byte_394F2:
		dc.b    4,   5,   2,   1,   1,   1,   1,   1,   0,   1,   2,   0,   1,   2,   0,   4
; ---------------------------------------------------------------------------

loc_39502:
		move.b	(Level_frame_counter+1).w,d0
		andi.b	#$F,d0
		bne.s	loc_39514
		moveq	#signextendB(sfx_SlideSkidQuiet),d0
		jsr	(Play_SFX).l

loc_39514:
		cmpi.w	#$1310,x_pos(a2)
		blo.s	loc_39554
		moveq	#1,d0
		cmpi.w	#$1330,x_pos(a2)
		blo.s	loc_39538
		cmpi.w	#$2210,x_pos(a2)
		blo.s	loc_39554
		cmpi.w	#$2230,x_pos(a2)
		bhs.s	loc_39554
		moveq	#2,d0

loc_39538:
		cmp.b	$36(a0),d0
		beq.s	loc_39554
		move.b	d0,$36(a0)
		move.b	#3,object_control(a2)
		move.l	#loc_395FE,(a0)
		move.w	#0,$34(a0)

loc_39554:
		lea	(Ani_SonicSnowboard).l,a1
		jsr	(Animate_Sprite).l
		cmpi.b	#8,mapping_frame(a0)
		bne.s	loc_39578
		cmpi.w	#$1000,ground_vel(a2)
		blt.s	loc_39578
		subi.w	#8,ground_vel(a2)
		bra.s	loc_39586
; ---------------------------------------------------------------------------

loc_39578:
		cmpi.w	#$1000,ground_vel(a2)
		bge.s	loc_39586
		move.w	#$1000,ground_vel(a2)

loc_39586:
		cmpi.w	#$3880,x_pos(a2)
		blo.s	loc_395CC
		tst.w	x_vel(a2)
		bne.s	loc_395CC
		move.l	#loc_39676,(a0)
		bset	#Status_InAir,status(a2)
		move.w	#-$200,x_vel(a2)
		move.w	#-$400,y_vel(a2)
		move.b	#$19,anim(a2)
		move.b	#0,object_control(a2)
		move.w	#$14,(Screen_shake_flag).w
		moveq	#signextendB(sfx_Crash),d0
		jsr	(Play_SFX).l
		move.w	#2,(Tails_CPU_routine).w

loc_395CC:
		btst	#Status_InAir,status(a2)
		bne.s	loc_395F2
		move.b	mapping_frame(a0),d0
		cmp.b	$32(a0),d0
		beq.s	loc_395F2
		cmpi.b	#7,d0
		beq.s	loc_395EA
		cmpi.b	#8,d0
		bne.s	loc_395F2

loc_395EA:
		moveq	#signextendB(sfx_GroundSlide),d0
		jsr	(Play_SFX).l

loc_395F2:
		jsr	(sub_3968E).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_395FE:
		lea	(Player_1).w,a2
		move.w	$34(a0),d0
		addq.w	#6,$34(a0)
		lea	(ICZSnowboard_Slope1).l,a1
		cmpi.b	#1,$36(a0)
		beq.s	loc_3961E
		lea	(ICZSnowboard_Slope2).l,a1

loc_3961E:
		lea	(a1,d0.w),a1
		move.w	(a1)+,d0
		move.w	d0,x_pos(a0)
		move.w	d0,x_pos(a2)
		move.w	(a1)+,d0
		move.w	d0,y_pos(a0)
		move.w	d0,y_pos(a2)
		move.w	(a1)+,d0
		move.b	d0,mapping_frame(a0)
		tst.w	(a1)
		bpl.s	loc_39658
		move.b	#$E,top_solid_bit(a2)
		move.b	#$F,lrb_solid_bit(a2)
		move.b	#2,object_control(a2)
		move.l	#loc_394A0,(a0)

loc_39658:
		move.b	mapping_frame(a0),d0
		cmp.b	$32(a0),d0
		beq.s	loc_3966A
		moveq	#signextendB(sfx_GroundSlide),d0
		jsr	(Play_SFX).l

loc_3966A:
		jsr	(sub_3968E).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_39676:
		jmp	(Delete_Current_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_3967C:
		move.w	#tiles_to_bytes($320),d4
		move.l	#ArtUnc_Snowboard,d6
		lea	(DPLC_Snowboard).l,a2
		bra.s	loc_3969E
; End of function sub_3967C


; =============== S U B R O U T I N E =======================================


sub_3968E:
		move.w	#tiles_to_bytes(ArtTile_Player_1),d4
		move.l	#ArtUnc_SonicSnowboard,d6
		lea	(DPLC_SonicSnowboard).l,a2

loc_3969E:
		moveq	#0,d0
		move.b	mapping_frame(a0),d0
		cmp.b	$32(a0),d0
		beq.s	locret_396E2
		move.b	d0,$32(a0)
		add.w	d0,d0
		adda.w	(a2,d0.w),a2
		move.w	(a2)+,d5
		subq.w	#1,d5
		bmi.s	locret_396E2

loc_396BA:
		moveq	#0,d1
		move.w	(a2)+,d1
		move.w	d1,d3
		lsr.w	#8,d3
		andi.w	#$F0,d3
		addi.w	#$10,d3
		andi.w	#$FFF,d1
		lsl.l	#5,d1
		add.l	d6,d1
		move.w	d4,d2
		add.w	d3,d4
		add.w	d3,d4
		jsr	(Add_To_DMA_Queue).l
		dbf	d5,loc_396BA

locret_396E2:
		rts
; End of function sub_3968E

; ---------------------------------------------------------------------------

Obj_LevelIntroICZ1:
		lea	(Player_1).w,a1
		move.w	#$800,x_vel(a1)
		move.w	#$280,y_vel(a1)
		move.w	#$800,ground_vel(a1)
		bset	#Status_InAir,status(a1)
		move.b	#0,jumping(a1)
		move.b	#$E,y_radius(a1)
		move.b	#7,x_radius(a1)
		move.b	#2,anim(a1)
		bset	#Status_Roll,status(a1)
		move.b	#1,(Ctrl_1_locked).w
		move.w	#0,(Ctrl_1_logical).w
		move.w	#0,(Ctrl_1).w
		move.b	#0,mapping_frame(a1)
		move.b	#3,object_control(a1)
		move.b	#30,anim_frame_timer(a0)
		move.l	#Map_Snowboard,mappings(a0)
		move.w	#make_art_tile($320,0,0),art_tile(a0)
		move.w	#$80,priority(a0)
		move.b	#$20,width_pixels(a0)
		move.b	#$20,height_pixels(a0)
		move.b	#4,render_flags(a0)
		move.b	#8,mapping_frame(a0)
		move.w	#$C0,x_pos(a0)
		move.w	#$170,y_pos(a0)
		move.l	#loc_39780,(a0)

loc_39780:
		subq.b	#1,anim_frame_timer(a0)
		bne.s	loc_39796
		lea	(Player_1).w,a2
		move.b	#0,object_control(a2)
		move.l	#loc_39796,(a0)

loc_39796:
		move.b	#1,(Ctrl_1_locked).w
		move.w	#0,(Ctrl_1_logical).w
		lea	(Player_1).w,a2
		cmpi.w	#$C0,x_pos(a2)
		blo.s	loc_397C6
		move.w	#-$600,y_vel(a0)
		move.w	#$400,x_vel(a2)
		move.w	#-$800,y_vel(a2)
		move.l	#loc_397D2,(a0)

loc_397C6:
		jsr	(sub_3967C).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_397D2:
		lea	(Player_1).w,a2
		move.w	x_pos(a2),x_pos(a0)
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	loc_397FA
		move.b	#1,anim_frame_timer(a0)
		addq.b	#1,mapping_frame(a0)
		cmpi.b	#9,mapping_frame(a0)
		blo.s	loc_397FA
		move.b	#1,mapping_frame(a0)

loc_397FA:
		cmpi.w	#$184,x_pos(a2)
		blo.s	loc_3983E
		move.b	#0,mapping_frame(a2)
		move.b	#2,object_control(a2)
		jsr	(AllocateObjectAfterCurrent).l
		bne.w	loc_39836
		move.l	#loc_393EE,(a1)
		move.w	x_pos(a2),x_pos(a1)
		move.w	y_pos(a2),y_pos(a1)
		move.w	x_vel(a2),x_vel(a1)
		move.w	y_vel(a2),y_vel(a1)

loc_39836:
		move.l	#loc_3984E,(a0)
		rts
; ---------------------------------------------------------------------------

loc_3983E:
		jsr	(MoveSprite2).l
		addi.w	#$28,y_vel(a0)
		bra.w	loc_397C6
; ---------------------------------------------------------------------------

loc_3984E:
		lea	(Player_1).w,a2
		move.w	x_pos(a2),x_pos(a0)
		move.w	y_pos(a2),y_pos(a0)
		move.w	(Ctrl_1).w,d0
		andi.w	#((button_A_mask|button_B_mask|button_C_mask|button_start_mask)<<8)|button_A_mask|button_B_mask|button_C_mask|button_start_mask,d0
		move.w	d0,(Ctrl_1_logical).w
		tst.b	object_control(a2)
		bne.s	locret_398A4
		move.b	#0,(Ctrl_1_locked).w
		move.l	#loc_398A6,(a0)
		addi.w	#$14,y_pos(a0)
		move.w	#-$200,x_vel(a0)
		move.w	#-$400,y_vel(a0)
		move.b	#$84,render_flags(a0)
		move.b	#1,mapping_frame(a0)
		move.b	#1,anim_frame_timer(a0)
		bra.w	loc_397C6
; ---------------------------------------------------------------------------

locret_398A4:
		rts
; ---------------------------------------------------------------------------

loc_398A6:
		tst.b	render_flags(a0)
		bmi.s	loc_398B2
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_398B2:
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	loc_398D0
		move.b	#1,anim_frame_timer(a0)
		addq.b	#1,mapping_frame(a0)
		cmpi.b	#9,mapping_frame(a0)
		blo.s	loc_398D0
		move.b	#1,mapping_frame(a0)

loc_398D0:
		jsr	(MoveSprite2).l
		addi.w	#$28,y_vel(a0)
		bra.w	loc_397C6
; ---------------------------------------------------------------------------

loc_398E0:
		move.l	#loc_398E6,(a0)

loc_398E6:
		movea.w	$30(a0),a3
		lea	(Player_1).w,a2
		tst.b	object_control(a2)
		bne.s	loc_398FA
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_398FA:
		btst	#Status_InAir,status(a2)
		bne.s	locret_39922
		bsr.s	sub_39924
		bsr.s	sub_39924
		cmpi.b	#7,mapping_frame(a3)
		beq.s	loc_39916
		cmpi.b	#8,mapping_frame(a3)
		bne.s	locret_39922

loc_39916:
		bsr.s	sub_39924
		bsr.s	sub_39924
		bsr.s	sub_39924
		bsr.s	sub_39924
		bsr.s	sub_39924
		bsr.s	sub_39924

locret_39922:
		rts

; =============== S U B R O U T I N E =======================================


sub_39924:
		jsr	(AllocateObjectAfterCurrent).l
		bne.w	locret_399A4
		move.l	#loc_399A6,(a1)
		move.w	#make_art_tile($6B8,0,0),art_tile(a1)
		move.l	#Map_SnowboardDust,mappings(a1)
		move.w	#$100,priority(a1)
		move.b	#4,width_pixels(a1)
		move.b	#4,height_pixels(a1)
		move.b	#$84,render_flags(a1)
		move.w	#1,anim(a1)
		move.w	x_pos(a2),x_pos(a1)
		move.w	y_pos(a2),y_pos(a1)
		addi.w	#$14,y_pos(a1)
		jsr	(Random_Number).l
		move.l	d0,d1
		andi.w	#$1FF,d0
		neg.w	d0
		subi.w	#$200,y_vel(a1)
		move.w	d0,y_vel(a1)
		move.w	#-$100,x_vel(a1)
		move.l	d1,d0
		andi.w	#$F,d0
		sub.w	d0,x_pos(a1)
		swap	d0
		andi.w	#$F,d0
		sub.w	d0,y_pos(a1)

locret_399A4:
		rts
; End of function sub_39924

; ---------------------------------------------------------------------------

loc_399A6:
		tst.b	render_flags(a0)
		bpl.s	loc_399CA
		jsr	(MoveSprite2).l
		lea	(Ani_SnowboardDust).l,a1
		jsr	(Animate_Sprite).l
		tst.b	routine(a0)
		bne.s	loc_399CA
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_399CA:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------
Ani_SnowboardDust:
		include "General/Sprites/Snowboard/Anim - Snowboard Dust.asm"
Map_SnowboardDust:
		include "General/Sprites/Snowboard/Map - Snowboard Dust.asm"
ArtNem_SnowboardDust:
		binclude "General/Sprites/Snowboard/Snowboard Dust.bin"
		even
; ---------------------------------------------------------------------------

Obj_LevelIntro_PlayerLaunchFromGround:
		move.l	#loc_39A80,(a0)
		move.b	#1,(Ctrl_1_locked).w
		move.b	#1,(Ctrl_2_locked).w
		moveq	#0,d0
		move.w	d0,(Ctrl_1_logical).w
		move.w	d0,(Ctrl_1).w
		move.w	d0,(Ctrl_2_logical).w
		move.w	d0,(Ctrl_2).w
		move.b	#30,anim_frame_timer(a0)
		lea	(Player_1).w,a1
		bsr.s	sub_39A78
		lea	(Player_2).w,a1
		tst.l	(a1)
		beq.s	locret_39A7E

; =============== S U B R O U T I N E =======================================


sub_39A78:
		move.b	#3,object_control(a1)

locret_39A7E:
		rts
; End of function sub_39A78

; ---------------------------------------------------------------------------

loc_39A80:
		move.b	#1,(Ctrl_1_locked).w
		move.b	#1,(Ctrl_2_locked).w
		move.w	#0,(Ctrl_1_logical).w
		move.w	#0,(Ctrl_2_logical).w
		subq.b	#1,anim_frame_timer(a0)
		beq.s	loc_39AA0
		rts
; ---------------------------------------------------------------------------

loc_39AA0:
		move.l	#loc_39AD2,(a0)
		lea	(Player_1).w,a1
		bsr.s	sub_39AB4
		lea	(Player_2).w,a1
		tst.l	(a1)
		beq.s	locret_39AD0

; =============== S U B R O U T I N E =======================================


sub_39AB4:
		move.w	#-$B00,y_vel(a1)
		bset	#Status_InAir,status(a1)
		clr.b	jumping(a1)
		move.b	#$10,anim(a1)
		move.b	#1,object_control(a1)

locret_39AD0:
		rts
; End of function sub_39AB4

; ---------------------------------------------------------------------------

loc_39AD2:
		move.b	#1,(Ctrl_1_locked).w
		move.b	#1,(Ctrl_2_locked).w
		move.w	#0,(Ctrl_1_logical).w
		move.w	#0,(Ctrl_2_logical).w
		lea	(Player_1).w,a2
		cmpi.w	#$5C0,y_pos(a2)
		bhs.s	loc_39B3C
		move.b	#0,object_control(a2)
		move.w	#4<<8,(Dust+anim).w	; and prev_anim
		move.w	#$5C0,(Dust+y_pos).w
		lea	(Player_2).w,a2
		tst.l	(a2)
		beq.s	loc_39B22
		move.b	#0,object_control(a2)
		move.w	#4<<8,(Dust_P2+anim).w	; and prev_anim
		move.w	#$5C0,(Dust_P2+y_pos).w

loc_39B22:
		moveq	#signextendB(sfx_SandSplash),d0
		jsr	(Play_SFX).l
		move.b	#0,(Ctrl_1_locked).w
		move.b	#0,(Ctrl_2_locked).w
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_39B3C:
		bsr.s	sub_39B46
		lea	(Player_2).w,a2
		tst.l	(a2)
		beq.s	locret_39B64

; =============== S U B R O U T I N E =======================================


sub_39B46:
		move.w	x_vel(a2),d0
		ext.l	d0
		lsl.l	#8,d0
		add.l	d0,x_pos(a2)
		move.w	y_vel(a2),d0
		addi.w	#$38,y_vel(a2)
		ext.l	d0
		lsl.l	#8,d0
		add.l	d0,y_pos(a2)

locret_39B64:
		rts
; End of function sub_39B46

; ---------------------------------------------------------------------------

Obj_LevelIntroICZ1Tails:
		lea	(Player_1).w,a1
		move.w	#$800,x_vel(a1)
		move.w	#$480,y_vel(a1)
		move.w	#$800,ground_vel(a1)
		bset	#Status_InAir,status(a1)
		move.b	#0,jumping(a1)
		move.b	#$E,y_radius(a1)
		move.b	#7,x_radius(a1)
		move.b	#2,anim(a1)
		bset	#Status_Roll,status(a1)
		move.b	#3,object_control(a1)
		move.b	#1,(Ctrl_1_locked).w
		move.w	#0,(Ctrl_1_logical).w
		move.w	#0,(Ctrl_1).w
		move.b	#30,anim_frame_timer(a0)
		move.l	#loc_39BC4,(a0)

loc_39BC4:
		move.b	#1,(Ctrl_1_locked).w
		move.w	#0,(Ctrl_1_logical).w
		move.w	#0,(Ctrl_2_logical).w
		subq.b	#1,anim_frame_timer(a0)
		beq.s	loc_39BDE
		rts
; ---------------------------------------------------------------------------

loc_39BDE:
		lea	(Player_1).w,a2
		move.b	#0,object_control(a2)
		move.l	#loc_39BEE,(a0)

loc_39BEE:
		move.b	#1,(Ctrl_1_locked).w
		move.w	#0,(Ctrl_1_logical).w
		lea	(Player_1).w,a2
		cmpi.w	#$38F0,x_pos(a2)
		blo.s	locret_39C4E
		bset	#Status_InAir,status(a2)
		move.w	#-$200,x_vel(a2)
		move.w	#-$400,y_vel(a2)
		move.b	#$19,anim(a2)
		move.b	#0,object_control(a2)
		move.b	#0,(Ctrl_1_locked).w
		move.w	#$14,(Screen_shake_flag).w
		move.w	#-$100,d0
		move.w	d0,(Camera_min_Y_pos).w
		move.w	d0,(Camera_target_min_Y_pos).w
		move.w	d0,(Camera_min_Y_pos_P2).w
		moveq	#signextendB(sfx_Crash),d0
		jsr	(Play_SFX).l
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

locret_39C4E:
		rts
; ---------------------------------------------------------------------------

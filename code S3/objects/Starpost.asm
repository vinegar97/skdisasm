Obj_StarPost:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	StarPost_Index(pc,d0.w),d1
		jmp	StarPost_Index(pc,d1.w)
; ---------------------------------------------------------------------------
StarPost_Index:
		dc.w loc_2C436-StarPost_Index
		dc.w loc_2C488-StarPost_Index
		dc.w loc_2C56E-StarPost_Index
		dc.w loc_2C580-StarPost_Index
		dc.w loc_2C8AE-StarPost_Index
; ---------------------------------------------------------------------------

loc_2C436:
		addq.b	#2,routine(a0)
		move.l	#Map_StarPost,mappings(a0)
		move.w	#make_art_tile(ArtTile_StarPost+8,0,0),art_tile(a0)
		move.b	#4,render_flags(a0)
		move.b	#8,width_pixels(a0)
		move.b	#$28,height_pixels(a0)
		move.w	#$280,priority(a0)
		movea.w	respawn_addr(a0),a2
		btst	#0,(a2)
		bne.s	loc_2C47E
		move.b	(Last_star_post_hit).w,d1
		andi.b	#$7F,d1
		move.b	subtype(a0),d2
		andi.b	#$7F,d2
		cmp.b	d2,d1
		blo.s	loc_2C488

loc_2C47E:
		bset	#0,(a2)
		move.b	#2,anim(a0)

loc_2C488:
		tst.w	(Debug_placement_mode).w
		bne.w	loc_2C56E
		lea	(Player_1).w,a3
		move.b	(Last_star_post_hit).w,d1
		bsr.s	sub_2C49E
		bra.w	loc_2C56E

; =============== S U B R O U T I N E =======================================


sub_2C49E:
		andi.b	#$7F,d1
		move.b	subtype(a0),d2
		andi.b	#$7F,d2
		cmp.b	d2,d1
		bhs.w	loc_2C560
		move.w	x_pos(a3),d0
		sub.w	x_pos(a0),d0
		addi.w	#8,d0
		cmpi.w	#$10,d0
		bhs.w	locret_2C55E
		move.w	y_pos(a3),d0
		sub.w	y_pos(a0),d0
		addi.w	#$40,d0
		cmpi.w	#$68,d0
		bcc.w	locret_2C55E
		moveq	#signextendB(sfx_Starpost),d0
		jsr	(Play_SFX).l
		jsr	(AllocateObject).l
		bne.s	loc_2C546
		move.l	#Obj_StarPost,(a1)
		move.b	#6,routine(a1)
		move.w	x_pos(a0),$30(a1)
		move.w	y_pos(a0),$32(a1)
		subi.w	#$14,$32(a1)
		move.l	mappings(a0),mappings(a1)
		move.w	art_tile(a0),art_tile(a1)
		move.b	#4,render_flags(a1)
		move.b	#8,width_pixels(a1)
		move.b	#8,height_pixels(a1)
		move.w	#$200,priority(a1)
		move.b	#2,mapping_frame(a1)
		move.w	#$20,$36(a1)
		move.w	a0,$3E(a1)
		cmpi.w	#50,(Ring_count).w
		blo.s	loc_2C546
		bsr.w	sub_2C83E

loc_2C546:
		move.b	#1,anim(a0)
		bsr.w	sub_2C5DA
		move.b	#4,routine(a0)
		movea.w	respawn_addr(a0),a2
		bset	#0,(a2)

locret_2C55E:
		rts
; ---------------------------------------------------------------------------

loc_2C560:
		tst.b	anim(a0)
		bne.s	locret_2C56C
		move.b	#2,anim(a0)

locret_2C56C:
		rts
; End of function sub_2C49E

; ---------------------------------------------------------------------------

loc_2C56E:
		lea	(Ani_Starpost).l,a1
		jsr	(Animate_Sprite).l
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------

loc_2C580:
		subq.w	#1,$36(a0)
		bpl.s	loc_2C5A4
		movea.w	$3E(a0),a1
		cmpi.l	#Obj_StarPost,(a1)
		bne.s	loc_2C59E
		move.b	#2,anim(a1)
		move.b	#0,mapping_frame(a1)

loc_2C59E:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_2C5A4:
		move.b	angle(a0),d0
		subi.b	#$10,angle(a0)
		subi.b	#$40,d0
		jsr	(GetSineCosine).l
		muls.w	#$C00,d1
		swap	d1
		add.w	$30(a0),d1
		move.w	d1,x_pos(a0)
		muls.w	#$C00,d0
		swap	d0
		add.w	$32(a0),d0
		move.w	d0,y_pos(a0)
		jmp	(Sprite_OnScreen_Test).l

; =============== S U B R O U T I N E =======================================


sub_2C5DA:
		move.b	subtype(a0),(Last_star_post_hit).w
		move.w	x_pos(a0),(Saved_X_pos).w
		move.w	y_pos(a0),(Saved_Y_pos).w
; End of function sub_2C5DA


; =============== S U B R O U T I N E =======================================


Save_Level_Data:
		move.b	(Last_star_post_hit).w,(Saved_last_star_post_hit).w
		move.w	(Current_zone_and_act).w,(Saved_zone_and_act).w
		move.w	(Apparent_zone_and_act).w,(Saved_apparent_zone_and_act).w
		move.w	(Player_1+art_tile).w,(Saved_art_tile).w
		move.w	(Player_1+top_solid_bit).w,(Saved_solid_bits).w
		move.w	(Ring_count).w,(Saved_ring_count).w
		move.b	(Extra_life_flags).w,(Saved_extra_life_flags).w
		move.l	(Timer).w,(Saved_timer).w
		move.b	(Dynamic_resize_routine).w,(Saved_dynamic_resize_routine).w
		move.w	(Camera_max_Y_pos).w,(Saved_camera_max_Y_pos).w
		move.w	(Camera_X_pos).w,(Saved_camera_X_pos).w
		move.w	(Camera_Y_pos).w,(Saved_camera_Y_pos).w
		move.w	(Mean_water_level).w,(Saved_mean_water_level).w
		move.b	(Water_full_screen_flag).w,(Saved_water_full_screen_flag).w
		rts
; End of function Save_Level_Data


; =============== S U B R O U T I N E =======================================


Save_Level_Data2:
		move.b	(Last_star_post_hit).w,(Saved2_last_star_post_hit).w
		move.w	(Current_zone_and_act).w,(Saved2_zone_and_act).w
		move.w	(Apparent_zone_and_act).w,(Saved2_apparent_zone_and_act).w
		move.w	x_pos(a0),(Saved2_X_pos).w
		move.w	y_pos(a0),(Saved2_Y_pos).w
		move.w	(Player_1+art_tile).w,(Saved2_art_tile).w
		move.w	(Player_1+top_solid_bit).w,(Saved2_solid_bits).w
		move.w	(Ring_count).w,(Saved2_ring_count).w
		move.b	(Extra_life_flags).w,(Saved2_extra_life_flags).w
		move.l	(Timer).w,(Saved2_timer).w
		move.b	(Dynamic_resize_routine).w,(Saved2_dynamic_resize_routine).w
		move.w	(Camera_max_Y_pos).w,(Saved2_camera_max_Y_pos).w
		move.w	(Camera_X_pos).w,(Saved2_camera_X_pos).w
		move.w	(Camera_Y_pos).w,(Saved2_camera_Y_pos).w
		move.w	(Mean_water_level).w,(Saved2_mean_water_level).w
		move.b	(Water_full_screen_flag).w,(Saved2_water_full_screen_flag).w
		move.b	(Player_1+status_secondary).w,(Saved2_status_secondary).w
		rts
; End of function Save_Level_Data2


; =============== S U B R O U T I N E =======================================


Load_Starpost_Settings:
		tst.b	(Special_bonus_entry_flag).w
		bne.w	loc_2C738
		move.b	(Saved_last_star_post_hit).w,(Last_star_post_hit).w
		move.w	(Saved_zone_and_act).w,(Current_zone_and_act).w
		move.w	(Saved_apparent_zone_and_act).w,(Apparent_zone_and_act).w
		move.w	(Saved_X_pos).w,(Player_1+x_pos).w
		move.w	(Saved_Y_pos).w,(Player_1+y_pos).w
		move.w	(Saved_ring_count).w,(Ring_count).w
		move.b	(Saved_extra_life_flags).w,(Extra_life_flags).w
		tst.b	(Respawn_table_keep).w
		bne.s	loc_2C6EA
		clr.w	(Ring_count).w
		clr.b	(Extra_life_flags).w

loc_2C6EA:
		move.l	(Saved_timer).w,(Timer).w
		move.b	#60-1,(Timer_frame).w
		subq.b	#1,(Timer_second).w
		move.w	(Saved_art_tile).w,(Player_1+art_tile).w
		move.w	(Saved_solid_bits).w,(Player_1+top_solid_bit).w
		move.b	(Saved_dynamic_resize_routine).w,(Dynamic_resize_routine).w
		move.w	(Saved_camera_max_Y_pos).w,(Camera_max_Y_pos).w
		move.w	(Saved_camera_max_Y_pos).w,(Camera_target_max_Y_pos).w
		move.w	(Saved_camera_X_pos).w,(Camera_X_pos).w
		move.w	(Saved_camera_Y_pos).w,(Camera_Y_pos).w
		tst.b	(Water_flag).w
		beq.s	locret_2C736
		move.w	(Saved_mean_water_level).w,(Mean_water_level).w
		move.b	(Saved_water_full_screen_flag).w,(Water_full_screen_flag).w

locret_2C736:
		rts
; ---------------------------------------------------------------------------

loc_2C738:
		clr.b	(Special_bonus_entry_flag).w
		move.w	(Saved2_zone_and_act).w,(Current_zone_and_act).w
		move.w	(Saved2_apparent_zone_and_act).w,(Apparent_zone_and_act).w
		move.w	(Saved2_X_pos).w,(Player_1+x_pos).w
		move.w	(Saved2_Y_pos).w,(Player_1+y_pos).w
		move.w	(Saved2_ring_count).w,(Ring_count).w
		move.b	(Saved2_extra_life_flags).w,(Extra_life_flags).w
		move.l	(Saved2_timer).w,(Timer).w
		move.b	#60-1,(Timer_frame).w
		subq.b	#1,(Timer_second).w
		move.w	(Saved2_art_tile).w,(Player_1+art_tile).w
		move.w	(Saved2_solid_bits).w,(Player_1+top_solid_bit).w
		move.b	(Saved2_dynamic_resize_routine).w,(Dynamic_resize_routine).w
		move.w	(Saved2_camera_max_Y_pos).w,(Camera_max_Y_pos).w
		move.w	(Saved2_camera_max_Y_pos).w,(Camera_target_max_Y_pos).w
		move.w	(Saved2_camera_X_pos).w,(Camera_X_pos).w
		move.w	(Saved2_camera_Y_pos).w,(Camera_Y_pos).w
		tst.b	(Water_flag).w
		beq.s	locret_2C7AC
		move.w	(Saved2_mean_water_level).w,(Mean_water_level).w
		move.b	(Saved2_water_full_screen_flag).w,(Water_full_screen_flag).w

locret_2C7AC:
		rts
; End of function Load_Starpost_Settings

; ---------------------------------------------------------------------------
Ani_Starpost:
		include "General/Sprites/Starpost/Anim - Starpost.asm"
Map_StarPost:
		include "General/Sprites/Starpost/Map - Starpost.asm"
Map_StarpostStars:
		include "General/Sprites/Starpost/Map - Starpost Stars.asm"

; =============== S U B R O U T I N E =======================================


sub_2C83E:
		moveq	#4-1,d1
		moveq	#0,d2

loc_2C842:
		jsr	(AllocateObject).l
		bne.s	locret_2C8AC
		move.l	(a0),(a1)
		move.l	#Map_StarpostStars,mappings(a1)
		move.w	#make_art_tile(ArtTile_StarPost+8,0,0),art_tile(a1)
		move.b	#4,render_flags(a1)
		move.b	#8,routine(a1)
		move.w	x_pos(a0),d0
		move.w	d0,x_pos(a1)
		move.w	d0,$30(a1)
		move.w	y_pos(a0),d0
		subi.w	#$30,d0
		move.w	d0,y_pos(a1)
		move.w	d0,$32(a1)
		move.w	priority(a0),priority(a1)
		move.b	#8,width_pixels(a1)
		move.b	#1,mapping_frame(a1)
		move.w	#-$400,x_vel(a1)
		move.w	#0,y_vel(a1)
		move.w	d2,$34(a1)
		addi.w	#$40,d2
		dbf	d1,loc_2C842

locret_2C8AC:
		rts
; End of function sub_2C83E

; ---------------------------------------------------------------------------

loc_2C8AE:
		move.b	collision_property(a0),d0
		beq.w	loc_2C8F0
		andi.b	#1,d0
		beq.s	loc_2C8EC
		move.b	#2,(Special_bonus_entry_flag).w
		move.w	#$1300,(Current_zone_and_act).w
		move.w	#$1300,(Apparent_zone_and_act).w
		move.b	#0,(Last_star_post_hit).w
		move.b	#1,(Restart_level_flag).w
		move.b	(Player_1+status_secondary).w,(Saved2_status_secondary).w
		move.b	#1,(Respawn_table_keep).w
		jsr	(Clear_SpriteRingMem).l

loc_2C8EC:
		clr.b	collision_property(a0)

loc_2C8F0:
		addi.w	#$A,$34(a0)
		move.w	$34(a0),d0
		andi.w	#$FF,d0
		jsr	(GetSineCosine).l
		asr.w	#5,d0
		asr.w	#3,d1
		move.w	d1,d3
		move.w	$34(a0),d2
		andi.w	#$3E0,d2
		lsr.w	#5,d2
		moveq	#2,d5
		moveq	#0,d4
		cmpi.w	#$10,d2
		ble.s	loc_2C920
		neg.w	d1

loc_2C920:
		andi.w	#$F,d2
		cmpi.w	#8,d2
		ble.s	loc_2C930
		neg.w	d2
		andi.w	#7,d2

loc_2C930:
		lsr.w	#1,d2
		beq.s	loc_2C936
		add.w	d1,d4

loc_2C936:
		asl.w	#1,d1
		dbf	d5,loc_2C930
		asr.w	#4,d4
		add.w	d4,d0
		addq.w	#1,$36(a0)
		move.w	$36(a0),d1
		cmpi.w	#$80,d1
		beq.s	loc_2C95A
		bgt.s	loc_2C960

loc_2C950:
		muls.w	d1,d0
		muls.w	d1,d3
		asr.w	#7,d0
		asr.w	#7,d3
		bra.s	loc_2C972
; ---------------------------------------------------------------------------

loc_2C95A:
		move.b	#$D8,collision_flags(a0)

loc_2C960:
		cmpi.w	#$180,d1
		ble.s	loc_2C972
		neg.w	d1
		addi.w	#$200,d1
		bmi.w	loc_2C9A6
		bra.s	loc_2C950
; ---------------------------------------------------------------------------

loc_2C972:
		move.w	$30(a0),d2
		add.w	d3,d2
		move.w	d2,x_pos(a0)
		move.w	$32(a0),d2
		add.w	d0,d2
		move.w	d2,y_pos(a0)
		addq.b	#1,anim_frame(a0)
		move.b	anim_frame(a0),d0
		andi.w	#6,d0
		lsr.w	#1,d0
		cmpi.b	#3,d0
		bne.s	loc_2C99C
		moveq	#1,d0

loc_2C99C:
		move.b	d0,mapping_frame(a0)
		jmp	(Sprite_CheckDeleteTouch3).l
; ---------------------------------------------------------------------------

loc_2C9A6:
		jmp	(Delete_Current_Sprite).l
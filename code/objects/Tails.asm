Obj_Tails2P:
		cmpa.w	#Player_1,a0
		bne.s	loc_13130
		lea	(Max_speed).w,a4
		lea	(Distance_from_top).w,a5
		lea	(Dust).w,a6
		move.b	(Player_2+character_id).w,d0
		cmp.b	character_id(a0),d0
		bne.s	loc_13124
		bchg	#3,render_flags(a0)

loc_13124:
		tst.w	(Debug_placement_mode).w
		beq.s	loc_1314C
		jmp	(DebugMode).l
; ---------------------------------------------------------------------------

loc_13130:
		lea	(Max_speed_P2).w,a4
		lea	(Distance_from_top_P2).w,a5
		lea	(Dust_P2).w,a6
		move.b	(Player_1+character_id).w,d0
		cmp.b	character_id(a0),d0
		bne.s	loc_1314C
		bchg	#4,render_flags(a0)

loc_1314C:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	Tails2P_Index(pc,d0.w),d1
		jmp	Tails2P_Index(pc,d1.w)
; ---------------------------------------------------------------------------
Tails2P_Index:
		dc.w loc_13166-Tails2P_Index
		dc.w loc_13274-Tails2P_Index
		dc.w loc_1569C-Tails2P_Index
		dc.w loc_1578E-Tails2P_Index
		dc.w loc_157E0-Tails2P_Index
		dc.w loc_157F4-Tails2P_Index
; ---------------------------------------------------------------------------

loc_13166:
		addq.b	#2,routine(a0)
		move.b	#$B,y_radius(a0)
		move.b	#5,x_radius(a0)
		move.b	#$B,default_y_radius(a0)
		move.b	#5,default_x_radius(a0)
		move.l	#Map_Tails2P,mappings(a0)
		move.w	#$100,priority(a0)
		move.b	#$C,width_pixels(a0)
		move.b	#$C,height_pixels(a0)
		move.b	#$84,render_flags(a0)
		move.b	#1,character_id(a0)
		lea	(Character_Speeds).l,a1
		moveq	#0,d0
		move.b	character_id(a0),d0
		lsl.w	#3,d0
		lea	(a1,d0.w),a1
		move.w	(a1)+,Max_speed_P2-Max_speed_P2(a4)
		move.w	(a1)+,Acceleration_P2-Max_speed_P2(a4)
		move.w	(a1)+,Deceleration_P2-Max_speed_P2(a4)
		tst.b	(Last_star_post_hit).w
		bne.w	loc_13250
		move.b	#$C,top_solid_bit(a0)
		move.b	#$D,lrb_solid_bit(a0)
		cmpa.w	#Player_1,a0
		bne.s	loc_13218
		move.w	#make_art_tile(ArtTile_Player_1,0,0),art_tile(a0)
		cmpi.b	#$12,(Current_zone).w
		bne.s	loc_131F2
		ori.w	#high_priority,art_tile(a0)

loc_131F2:
		move.w	x_pos(a0),(Saved_X_pos).w
		move.w	y_pos(a0),(Saved_Y_pos).w
		move.w	art_tile(a0),(Saved_art_tile).w
		move.w	top_solid_bit(a0),(Saved_solid_bits).w
		move.l	#Obj_Tails2P_Tail,(Tails_tails_2P).w
		move.w	a0,(Tails_tails_2P+$30).w
		bra.s	loc_13250
; ---------------------------------------------------------------------------

loc_13218:
		move.w	#make_art_tile(ArtTile_Player_2,0,0),art_tile(a0)
		cmpi.b	#$12,(Current_zone).w
		bne.s	loc_1322C
		ori.w	#high_priority,art_tile(a0)

loc_1322C:
		move.w	x_pos(a0),(Saved2_X_pos).w
		move.w	y_pos(a0),(Saved2_Y_pos).w
		move.w	art_tile(a0),(Saved2_art_tile).w
		move.w	top_solid_bit(a0),(Saved2_solid_bits).w
		move.l	#Obj_Tails2P_Tail,(Tails_tails).w
		move.w	a0,(Tails_tails+$30).w

loc_13250:
		move.b	#0,flips_remaining(a0)
		move.b	#4,flip_speed(a0)
		move.b	#30,air_left(a0)
		move.w	#0,(Tails_CPU_routine).w
		move.w	#10*60,(Tails_CPU_idle_timer).w
		move.w	#0,(Tails_CPU_flight_timer).w

loc_13274:
		tst.w	(Debug_mode_flag).w
		beq.s	loc_13294
		cmpa.w	#Player_1,a0
		bne.s	loc_13294
		btst	#button_B,(Ctrl_1_pressed).w
		beq.s	loc_13294
		move.w	#1,(Debug_placement_mode).w
		clr.b	(Ctrl_1_locked).w
		rts
; ---------------------------------------------------------------------------

loc_13294:
		cmpa.w	#Player_1,a0
		bne.s	loc_132B4
		move.w	(Ctrl_1_logical).w,(Ctrl_2_logical).w
		tst.b	(Ctrl_1_locked).w
		bne.s	loc_132C0
		move.w	(Ctrl_1).w,(Ctrl_2_logical).w
		move.w	(Ctrl_1).w,(Ctrl_1_logical).w
		bra.s	loc_132C0
; ---------------------------------------------------------------------------

loc_132B4:
		tst.b	(Ctrl_2_locked).w
		bne.s	loc_132C0
		move.w	(Ctrl_2).w,(Ctrl_2_logical).w

loc_132C0:
		bsr.w	Tails_Display
		btst	#0,object_control(a0)
		bne.s	loc_132DE
		moveq	#0,d0
		move.b	status(a0),d0
		andi.w	#6,d0
		move.w	off_1332E(pc,d0.w),d1
		jsr	off_1332E(pc,d1.w)

loc_132DE:
		cmpi.w	#-$100,(Camera_min_Y_pos).w
		bne.s	loc_132EE
		move.w	(Screen_Y_wrap_value).w,d0
		and.w	d0,y_pos(a0)

loc_132EE:
		move.w	(Screen_X_wrap_value).w,d0
		and.w	d0,x_pos(a0)
		addi.w	#$400,x_pos(a0)
		bsr.w	Sonic_RecordPos
		move.b	(Primary_Angle).w,next_tilt(a0)
		move.b	(Secondary_Angle).w,tilt(a0)
		btst	#1,object_control(a0)
		bne.s	loc_1331C
		bsr.w	Animate_Tails2P
		bsr.w	Tails2P_Load_PLC

loc_1331C:
		move.b	object_control(a0),d0
		andi.b	#$A0,d0
		bne.s	locret_1332C
		jsr	(TouchResponse_CompetitionMode).l

locret_1332C:
		rts
; ---------------------------------------------------------------------------
off_1332E:
		dc.w loc_13336-off_1332E
		dc.w loc_1335A-off_1332E
		dc.w loc_1346A-off_1332E
		dc.w loc_1348C-off_1332E
; ---------------------------------------------------------------------------

loc_13336:
		bsr.w	sub_13520
		bsr.w	Tails_Jump
		bsr.w	Player_SlopeResist
		bsr.w	Tails_InputAcceleration_Path
		bsr.w	sub_134BA
		jsr	(MoveSprite2).l
		bsr.w	Player_AnglePos
		bsr.w	Player_SlopeRepel
		rts
; ---------------------------------------------------------------------------

loc_1335A:
		tst.b	double_jump_flag(a0)
		bne.s	loc_1338E
		bsr.w	Tails_JumpHeight
		bsr.w	Tails_InputAcceleration_Freespace
		jsr	(MoveSprite).l
		btst	#Status_Underwater,status(a0)
		beq.s	loc_1337C
		subi.w	#$28,y_vel(a0)

loc_1337C:
		bsr.w	Player_JumpAngle
		movem.l	a4-a6,-(sp)
		bsr.w	Tails_DoLevelCollision
		movem.l	(sp)+,a4-a6
		rts
; ---------------------------------------------------------------------------

loc_1338E:
		bsr.w	sub_133AE
		bsr.w	Tails_InputAcceleration_Freespace
		jsr	(MoveSprite2).l
		bsr.w	Player_JumpAngle
		movem.l	a4-a6,-(sp)
		bsr.w	Tails_DoLevelCollision
		movem.l	(sp)+,a4-a6
		rts

; =============== S U B R O U T I N E =======================================


sub_133AE:
		move.b	(Level_frame_counter+1).w,d0
		andi.b	#1,d0
		beq.s	loc_133C2
		tst.b	double_jump_property(a0)
		beq.s	loc_133C2
		subq.b	#1,double_jump_property(a0)

loc_133C2:
		cmpi.b	#1,double_jump_flag(a0)
		beq.s	loc_133EC
		cmpi.w	#-$100,y_vel(a0)
		blt.s	loc_133E4
		subi.w	#$20,y_vel(a0)
		addq.b	#1,double_jump_flag(a0)
		cmpi.b	#$20,double_jump_flag(a0)
		bne.s	loc_133EA

loc_133E4:
		move.b	#1,double_jump_flag(a0)

loc_133EA:
		bra.s	loc_1341E
; ---------------------------------------------------------------------------

loc_133EC:
		move.b	(Ctrl_2_pressed_logical).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0
		beq.s	loc_13418
		cmpi.w	#-$100,y_vel(a0)
		blt.s	loc_13418
		tst.b	double_jump_property(a0)
		beq.s	loc_13418
		btst	#Status_Underwater,status(a0)
		beq.s	loc_13412
		tst.b	(Flying_carrying_Sonic_flag).w
		bne.s	loc_13418

loc_13412:
		move.b	#2,double_jump_flag(a0)

loc_13418:
		addi.w	#8,y_vel(a0)

loc_1341E:
		move.w	(Camera_min_Y_pos).w,d0
		addi.w	#$10,d0
		cmp.w	y_pos(a0),d0
		blt.s	loc_13438
		tst.w	y_vel(a0)
		bpl.s	loc_13438
		move.w	#0,y_vel(a0)

loc_13438:
		tst.b	double_jump_property(a0)
		bne.s	loc_13454
		move.b	(Level_frame_counter+1).w,d0
		addq.b	#8,d0
		andi.b	#$F,d0
		bne.s	locret_13452
		moveq	#signextendB(sfx_FlyTired),d0
		jsr	(Play_SFX).l

locret_13452:
		rts
; ---------------------------------------------------------------------------

loc_13454:
		move.b	(Level_frame_counter+1).w,d0
		addq.b	#8,d0
		andi.b	#$F,d0
		bne.s	locret_13468
		moveq	#signextendB(sfx_Flying),d0
		jsr	(Play_SFX).l

locret_13468:
		rts
; End of function sub_133AE

; ---------------------------------------------------------------------------

loc_1346A:
		tst.b	spin_dash_flag(a0)
		bne.s	loc_13474
		bsr.w	Tails_Jump

loc_13474:
		bsr.w	Player_RollRepel
		bsr.w	Tails_RollSpeed
		jsr	(MoveSprite2).l
		bsr.w	Player_AnglePos
		bsr.w	Player_SlopeRepel
		rts
; ---------------------------------------------------------------------------

loc_1348C:
		bsr.w	Tails_JumpHeight
		bsr.w	Tails_InputAcceleration_Freespace
		jsr	(MoveSprite).l
		btst	#Status_Underwater,status(a0)
		beq.s	loc_134A8
		subi.w	#$28,y_vel(a0)

loc_134A8:
		bsr.w	Player_JumpAngle
		movem.l	a4-a6,-(sp)
		bsr.w	Tails_DoLevelCollision
		movem.l	(sp)+,a4-a6
		rts

; =============== S U B R O U T I N E =======================================


sub_134BA:
		tst.b	status_secondary(a0)
		bmi.s	locret_134E0
		move.w	ground_vel(a0),d0
		bpl.s	loc_134C8
		neg.w	d0

loc_134C8:
		cmpi.w	#$80,d0
		blo.s	locret_134E0
		move.b	(Ctrl_2_held_logical).w,d0
		andi.b	#button_left_mask|button_right_mask,d0
		bne.s	locret_134E0
		btst	#button_down,(Ctrl_2_held_logical).w
		bne.s	loc_134E2

locret_134E0:
		rts
; ---------------------------------------------------------------------------

loc_134E2:
		btst	#Status_Roll,status(a0)
		beq.s	loc_134EC
		rts
; ---------------------------------------------------------------------------

loc_134EC:
		bset	#Status_Roll,status(a0)
		move.b	#7,y_radius(a0)
		move.b	#3,x_radius(a0)
		move.b	#2,anim(a0)
		addq.w	#4,y_pos(a0)
		move.w	#sfx_Roll,d0
		jsr	(Play_SFX).l
		tst.w	ground_vel(a0)
		bne.s	locret_1351E
		move.w	#$200,ground_vel(a0)

locret_1351E:
		rts
; End of function sub_134BA


; =============== S U B R O U T I N E =======================================


sub_13520:
		tst.b	spin_dash_flag(a0)
		bne.s	loc_13570
		cmpi.b	#8,anim(a0)
		bne.s	locret_1356E
		move.b	(Ctrl_2_pressed_logical).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0
		beq.w	locret_1356E
		move.b	#9,anim(a0)
		move.w	#signextendB(sfx_Spindash),d0
		jsr	(Play_SFX).l
		addq.l	#4,sp
		move.b	#1,spin_dash_flag(a0)
		move.w	#0,spin_dash_counter(a0)
		cmpi.b	#12,air_left(a0)
		blo.s	loc_13566
		move.b	#2,anim(a6)

loc_13566:
		bsr.w	Tails_Check_Screen_Boundaries
		bsr.w	Player_AnglePos

locret_1356E:
		rts
; ---------------------------------------------------------------------------

loc_13570:
		move.b	(Ctrl_2_held_logical).w,d0
		btst	#button_down,d0
		bne.w	loc_13600
		move.b	#7,y_radius(a0)
		move.b	#3,x_radius(a0)
		move.b	#2,anim(a0)
		addq.w	#4,y_pos(a0)
		move.b	#0,spin_dash_flag(a0)
		moveq	#0,d0
		move.b	spin_dash_counter(a0),d0
		add.w	d0,d0
		move.w	word_135EE(pc,d0.w),ground_vel(a0)
		move.w	ground_vel(a0),d0
		subi.w	#$800,d0
		add.w	d0,d0
		andi.w	#$1F00,d0
		neg.w	d0
		addi.w	#$2000,d0
		lea	(H_scroll_frame_offset).w,a1
		cmpa.w	#Player_1,a0
		beq.s	loc_135C8
		lea	(H_scroll_frame_offset_P2).w,a1

loc_135C8:
		move.w	d0,(a1)
		btst	#Status_Facing,status(a0)
		beq.s	loc_135D6
		neg.w	ground_vel(a0)

loc_135D6:
		bset	#Status_Roll,status(a0)
		move.b	#0,anim(a6)
		move.w	#signextendB(sfx_Dash),d0
		jsr	(Play_SFX).l
		bra.s	loc_13648
; ---------------------------------------------------------------------------
word_135EE:
		dc.w   $800
		dc.w   $880
		dc.w   $900
		dc.w   $980
		dc.w   $A00
		dc.w   $A80
		dc.w   $B00
		dc.w   $B80
		dc.w   $C00
; ---------------------------------------------------------------------------

loc_13600:
		tst.w	spin_dash_counter(a0)
		beq.s	loc_13618
		move.w	spin_dash_counter(a0),d0
		lsr.w	#5,d0
		sub.w	d0,spin_dash_counter(a0)
		bcc.s	loc_13618
		move.w	#0,spin_dash_counter(a0)

loc_13618:
		move.b	(Ctrl_2_pressed_logical).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0
		beq.w	loc_13648
		move.w	#9<<8,anim(a0)	; and prev_anim
		move.w	#signextendB(sfx_Spindash),d0
		jsr	(Play_SFX).l
		addi.w	#$200,spin_dash_counter(a0)
		cmpi.w	#$800,spin_dash_counter(a0)
		blo.s	loc_13648
		move.w	#$800,spin_dash_counter(a0)

loc_13648:
		addq.l	#4,sp
		cmpi.w	#$60,(a5)
		beq.s	loc_13656
		bcc.s	loc_13654
		addq.w	#4,(a5)

loc_13654:
		subq.w	#2,(a5)

loc_13656:
		bsr.w	Player_AnglePos
		rts
; End of function sub_13520

; ---------------------------------------------------------------------------

Obj_Tails:
		lea	(Max_speed_P2).w,a4
		lea	(Distance_from_top_P2).w,a5
		lea	(Dust_P2).w,a6
		cmpi.w	#2,(Player_mode).w
		bne.s	Tails_Normal
		tst.w	(Debug_placement_mode).w
		beq.s	Tails_Normal
		cmpi.b	#1,(Debug_placement_type).w
		beq.s	loc_136A8
		btst	#button_B,(Ctrl_1_pressed).w
		beq.s	loc_1368C
		move.w	#0,(Debug_placement_mode).w

loc_1368C:
		addq.b	#1,mapping_frame(a0)
		cmpi.b	#$FB,mapping_frame(a0)
		blo.s	loc_1369E
		move.b	#0,mapping_frame(a0)

loc_1369E:
		bsr.w	Tails_Load_PLC
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_136A8:
		jmp	(DebugMode).l
; ---------------------------------------------------------------------------

Tails_Normal:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	Tails_Index(pc,d0.w),d1
		jmp	Tails_Index(pc,d1.w)
; ---------------------------------------------------------------------------
Tails_Index:
		dc.w Tails_Init-Tails_Index
		dc.w Tails_Control-Tails_Index
		dc.w loc_1569C-Tails_Index
		dc.w loc_1578E-Tails_Index
		dc.w loc_157E0-Tails_Index
		dc.w loc_157F4-Tails_Index
		dc.w loc_15810-Tails_Index
; ---------------------------------------------------------------------------

Tails_Init:
		addq.b	#2,routine(a0)
		move.b	#$F,y_radius(a0)
		move.b	#9,x_radius(a0)
		move.b	#$F,default_y_radius(a0)
		move.b	#9,default_x_radius(a0)
		move.l	#Map_Tails,mappings(a0)
		move.w	#$100,priority(a0)
		move.b	#$18,width_pixels(a0)
		move.b	#$18,height_pixels(a0)
		move.b	#$84,render_flags(a0)
		move.b	#1,character_id(a0)
		move.w	#$600,Max_speed_P2-Max_speed_P2(a4)
		move.w	#$C,Acceleration_P2-Max_speed_P2(a4)
		move.w	#$80,Deceleration_P2-Max_speed_P2(a4)
		cmpi.w	#2,(Player_mode).w
		bne.s	loc_1375E
		tst.b	(Last_star_post_hit).w
		bne.s	Tails_Init_Continued
		move.w	#make_art_tile(ArtTile_Player_2,0,0),art_tile(a0)
		move.b	#$C,top_solid_bit(a0)
		move.b	#$D,lrb_solid_bit(a0)
		cmpi.b	#2,(Special_bonus_entry_flag).w
		beq.s	Tails_Init_Continued
		move.w	x_pos(a0),(Saved_X_pos).w
		move.w	y_pos(a0),(Saved_Y_pos).w
		move.w	art_tile(a0),(Saved_art_tile).w
		move.w	top_solid_bit(a0),(Saved_solid_bits).w
		bra.s	Tails_Init_Continued
; ---------------------------------------------------------------------------

loc_1375E:
		move.w	#make_art_tile(ArtTile_Player_2,0,0),art_tile(a0)
		move.w	(Player_1+top_solid_bit).w,top_solid_bit(a0)
		tst.w	(Player_1+art_tile).w
		bpl.s	Tails_Init_Continued
		ori.w	#high_priority,art_tile(a0)

Tails_Init_Continued:
		move.b	#0,flips_remaining(a0)
		move.b	#4,flip_speed(a0)
		move.b	#0,(Super_Tails_flag).w
		move.b	#30,air_left(a0)
		cmpi.w	#$20,(Tails_CPU_routine).w
		beq.s	loc_137A4
		cmpi.w	#$12,(Tails_CPU_routine).w
		beq.s	loc_137A4
		move.w	#0,(Tails_CPU_routine).w

loc_137A4:
		move.w	#0,(Tails_CPU_idle_timer).w
		move.w	#0,(Tails_CPU_flight_timer).w
		move.l	#Obj_Tails_Tail,(Tails_tails).w
		move.w	a0,(Tails_tails+$30).w
		move.b	(Last_star_post_hit).w,(Tails_CPU_star_post_flag).w
		rts
; ---------------------------------------------------------------------------

Tails_Control:
		cmpi.w	#2,(Player_mode).w
		bne.s	loc_13808
		tst.w	(Debug_mode_flag).w
		beq.s	loc_13808
		bclr	#button_A,(Ctrl_1_pressed).w
		beq.s	loc_137E0
		eori.b	#1,(Reverse_gravity_flag).w

loc_137E0:
		btst	#button_B,(Ctrl_1_pressed).w
		beq.s	loc_13808
		move.w	#1,(Debug_placement_mode).w
		clr.b	(Ctrl_1_locked).w
		btst	#button_C,(Ctrl_1_held).w
		beq.s	locret_13806
		move.w	#2,(Debug_placement_mode).w
		move.b	#0,anim(a0)

locret_13806:
		rts
; ---------------------------------------------------------------------------

loc_13808:
		cmpa.w	#Player_1,a0
		bne.s	loc_13830
		move.w	(Ctrl_1_logical).w,(Ctrl_2_logical).w
		tst.b	(Ctrl_1_locked).w
		bne.s	loc_1384A
		move.w	(Ctrl_1).w,(Ctrl_2_logical).w
		move.w	(Ctrl_1).w,(Ctrl_1_logical).w
		cmpi.w	#$1A,(Tails_CPU_routine).w
		bhs.s	loc_13840
		bra.s	loc_1384A
; ---------------------------------------------------------------------------

loc_13830:
		tst.b	(Ctrl_2_locked).w
		beq.s	loc_1383A
		bpl.s	loc_13840
		bra.s	loc_1384A
; ---------------------------------------------------------------------------

loc_1383A:
		move.w	(Ctrl_2).w,(Ctrl_2_logical).w

loc_13840:
		tst.w	(Competition_mode).w
		bne.s	loc_1384A
		bsr.w	Tails_CPU_Control

loc_1384A:
		btst	#0,object_control(a0)
		beq.s	loc_13872
		move.b	#0,double_jump_flag(a0)
		tst.b	(Flying_carrying_Sonic_flag).w
		beq.s	loc_1388C
		lea	(Player_1).w,a1
		clr.b	object_control(a1)
		bset	#Status_InAir,status(a1)
		clr.w	(Flying_carrying_Sonic_flag).w
		bra.s	loc_1388C
; ---------------------------------------------------------------------------

loc_13872:
		movem.l	a4-a6,-(sp)
		moveq	#0,d0
		move.b	status(a0),d0
		andi.w	#6,d0
		move.w	Tails_Modes(pc,d0.w),d1
		jsr	Tails_Modes(pc,d1.w)
		movem.l	(sp)+,a4-a6

loc_1388C:
		cmpi.w	#-$100,(Camera_min_Y_pos).w
		bne.s	loc_1389C
		move.w	(Screen_Y_wrap_value).w,d0
		and.w	d0,y_pos(a0)

loc_1389C:
		bsr.s	Tails_Display
		bsr.w	Tails_Super
		bsr.w	Sonic_RecordPos
		bsr.w	Tails_Water
		move.b	(Primary_Angle).w,next_tilt(a0)
		move.b	(Secondary_Angle).w,tilt(a0)
		tst.b	(WindTunnel_flag_P2).w
		beq.s	loc_138C8
		tst.b	anim(a0)
		bne.s	loc_138C8
		move.b	prev_anim(a0),anim(a0)

loc_138C8:
		btst	#1,object_control(a0)
		bne.s	loc_138E4
		bsr.w	Animate_Tails
		tst.b	(Reverse_gravity_flag).w
		beq.s	loc_138E0
		eori.b	#2,render_flags(a0)

loc_138E0:
		bsr.w	Tails_Load_PLC

loc_138E4:
		move.b	object_control(a0),d0
		andi.b	#$A0,d0
		bne.s	locret_138F4
		jsr	(TouchResponse).l

locret_138F4:
		rts
; ---------------------------------------------------------------------------
Tails_Modes:
		dc.w Tails_Stand_Path-Tails_Modes
		dc.w Tails_Stand_Freespace-Tails_Modes
		dc.w Tails_Spin_Path-Tails_Modes
		dc.w Tails_Spin_Freespace-Tails_Modes
; ---------------------------------------------------------------------------

Tails_Display:
		move.b	invulnerability_timer(a0),d0
		beq.s	loc_1390C
		subq.b	#1,invulnerability_timer(a0)
		lsr.b	#3,d0
		bcc.s	loc_13912

loc_1390C:
		jsr	(Draw_Sprite).l

loc_13912:
		btst	#Status_Invincible,status_secondary(a0)
		beq.s	loc_1394E
		tst.b	invincibility_timer(a0)
		beq.s	loc_1394E
		move.b	(Level_frame_counter+1).w,d0
		andi.b	#7,d0
		bne.s	loc_1394E
		subq.b	#1,invincibility_timer(a0)
		bne.s	loc_1394E
		tst.b	(Boss_flag).w
		bne.s	loc_13948
		cmpi.b	#12,air_left(a0)
		blo.s	loc_13948
		move.w	(Current_music).w,d0
		jsr	(Play_Music).l

loc_13948:
		bclr	#Status_Invincible,status_secondary(a0)

loc_1394E:
		btst	#Status_SpeedShoes,status_secondary(a0)
		beq.s	locret_139A6
		tst.b	speed_shoes_timer(a0)
		beq.s	locret_139A6
		move.b	(Level_frame_counter+1).w,d0
		andi.b	#7,d0
		bne.s	locret_139A6
		subq.b	#1,speed_shoes_timer(a0)
		bne.s	locret_139A6
		tst.w	(Competition_mode).w
		bne.s	loc_139A8
		move.w	#$600,Max_speed_P2-Max_speed_P2(a4)
		move.w	#$C,Acceleration_P2-Max_speed_P2(a4)
		move.w	#$80,Deceleration_P2-Max_speed_P2(a4)
		tst.b	(Super_Tails_flag).w
		beq.s	loc_13998
		move.w	#$800,Max_speed_P2-Max_speed_P2(a4)
		move.w	#$18,Acceleration_P2-Max_speed_P2(a4)
		move.w	#$C0,Deceleration_P2-Max_speed_P2(a4)

loc_13998:
		bclr	#Status_SpeedShoes,status_secondary(a0)
		moveq	#0,d0
		jmp	(Change_Music_Tempo).l
; ---------------------------------------------------------------------------

locret_139A6:
		rts
; ---------------------------------------------------------------------------

loc_139A8:
		lea	(Character_Speeds).l,a1
		moveq	#0,d0
		move.b	character_id(a0),d0
		lsl.w	#3,d0
		lea	(a1,d0.w),a1
		move.w	(a1)+,Max_speed_P2-Max_speed_P2(a4)
		move.w	(a1)+,Acceleration_P2-Max_speed_P2(a4)
		move.w	(a1)+,Deceleration_P2-Max_speed_P2(a4)
		bclr	#Status_SpeedShoes,status_secondary(a0)
		rts

; =============== S U B R O U T I N E =======================================


Tails_CPU_Control:
		move.b	(Ctrl_2_held_logical).w,d0
		andi.b	#$7F,d0
		beq.s	loc_139DC
		move.w	#10*60,(Tails_CPU_idle_timer).w

loc_139DC:
		lea	(Player_1).w,a1
		move.w	(Tails_CPU_routine).w,d0
		move.w	Tails_CPU_Control.Index(pc,d0.w),d0
		jmp	Tails_CPU_Control.Index(pc,d0.w)
; End of function Tails_CPU_Control

; ---------------------------------------------------------------------------
Tails_CPU_Control.Index:
		dc.w loc_13A10-Tails_CPU_Control.Index
		dc.w Tails_Catch_Up_Flying-Tails_CPU_Control.Index
		dc.w Tails_FlySwim_Unknown-Tails_CPU_Control.Index
		dc.w loc_13D4A-Tails_CPU_Control.Index
		dc.w loc_13F40-Tails_CPU_Control.Index
		dc.w locret_13FC0-Tails_CPU_Control.Index
		dc.w loc_13FC2-Tails_CPU_Control.Index
		dc.w loc_13FFA-Tails_CPU_Control.Index
		dc.w loc_1408A-Tails_CPU_Control.Index
		dc.w loc_140C6-Tails_CPU_Control.Index
		dc.w loc_140CE-Tails_CPU_Control.Index
		dc.w loc_14106-Tails_CPU_Control.Index
		dc.w loc_1414C-Tails_CPU_Control.Index
		dc.w loc_141F2-Tails_CPU_Control.Index
		dc.w loc_1421C-Tails_CPU_Control.Index
		dc.w loc_14254-Tails_CPU_Control.Index
		dc.w loc_1425C-Tails_CPU_Control.Index
		dc.w loc_14286-Tails_CPU_Control.Index
; ---------------------------------------------------------------------------

loc_13A10:
		tst.b	(Tails_CPU_star_post_flag).w
		bne.w	loc_13AF4
		cmpi.w	#0,(Current_zone_and_act).w
		bne.s	loc_13A32
		bsr.w	sub_13ECA
		move.w	#$A,(Tails_CPU_routine).w
		move.b	#$83,object_control(a0)
		rts
; ---------------------------------------------------------------------------

loc_13A32:
		cmpi.w	#$100,(Current_zone_and_act).w
		beq.w	loc_13B12
		cmpi.w	#$200,(Current_zone_and_act).w
		beq.w	loc_13B12
		cmpi.w	#$300,(Current_zone_and_act).w
		bne.s	loc_13A74
		move.w	#$18,x_pos(a0)
		move.w	#$600,y_pos(a0)

loc_13A5A:
		move.w	#0,(Tails_CPU_idle_timer).w
		move.w	#0,(Tails_CPU_flight_timer).w
		move.b	#2,status(a0)
		move.w	#$C,(Tails_CPU_routine).w
		rts
; ---------------------------------------------------------------------------

loc_13A74:
		cmpi.w	#$500,(Current_zone_and_act).w
		bne.s	loc_13A8E
		bsr.w	sub_13ECA
		move.w	#$A,(Tails_CPU_routine).w
		move.b	#$83,object_control(a0)
		rts
; ---------------------------------------------------------------------------

loc_13A8E:
		cmpi.w	#$600,(Current_zone_and_act).w
		beq.w	loc_13B12
		cmpi.w	#$700,(Current_zone_and_act).w
		bne.s	loc_13AB4
		tst.w	(SK_alone_flag).w
		bne.s	loc_13AB4
		move.w	#$D8,x_pos(a0)
		move.w	#$500,y_pos(a0)
		bra.s	loc_13A5A
; ---------------------------------------------------------------------------

loc_13AB4:
		cmpi.w	#$800,(Current_zone_and_act).w
		beq.w	loc_13B18
		cmpi.w	#$900,(Current_zone_and_act).w
		beq.w	loc_13B12
		cmpi.w	#$A00,(Current_zone_and_act).w
		bne.s	loc_13AE2
		bsr.w	sub_13ECA
		move.w	#$A,(Tails_CPU_routine).w
		move.b	#$83,object_control(a0)
		rts
; ---------------------------------------------------------------------------

loc_13AE2:
		cmpi.w	#$1600,(Current_zone_and_act).w
		beq.w	loc_13B12
		cmpi.b	#$17,(Current_zone).w
		beq.s	loc_13B18

loc_13AF4:
		move.b	#0,anim(a0)
		move.w	#0,x_vel(a0)
		move.w	#0,y_vel(a0)
		move.w	#0,ground_vel(a0)
		move.b	#0,status(a0)

loc_13B12:
		move.b	#0,object_control(a0)

loc_13B18:
		move.w	#6,(Tails_CPU_routine).w
		move.w	#0,(Tails_CPU_flight_timer).w
		rts
; ---------------------------------------------------------------------------

Tails_Catch_Up_Flying:
		move.b	(Ctrl_2_logical).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask|button_start_mask,d0
		bne.s	loc_13B50
		move.w	(Level_frame_counter).w,d0
		andi.w	#$3F,d0
		bne.w	locret_13BF6
		tst.b	object_control(a1)
		bmi.w	locret_13BF6
		move.b	status(a1),d0
		andi.b	#$80,d0
		bne.w	locret_13BF6

loc_13B50:
		move.w	#4,(Tails_CPU_routine).w
		move.w	x_pos(a1),d0
		move.w	d0,x_pos(a0)
		move.w	d0,(Tails_CPU_target_X).w
		move.w	y_pos(a1),d0
		move.w	d0,(Tails_CPU_target_Y).w
		subi.w	#$C0,d0
		tst.b	(Reverse_gravity_flag).w
		beq.s	loc_13B78
		addi.w	#2*$C0,d0

loc_13B78:
		move.w	d0,y_pos(a0)
		ori.w	#high_priority,art_tile(a0)
		move.w	#$100,priority(a0)
		moveq	#0,d0
		move.w	d0,x_vel(a0)
		move.w	d0,y_vel(a0)
		move.w	d0,ground_vel(a0)
		move.b	d0,flip_type(a0)
		move.b	d0,double_jump_flag(a0)
		move.b	#2,status(a0)
		move.b	#30,air_left(a0)
		move.b	#$81,object_control(a0)
		move.b	d0,flips_remaining(a0)
		move.b	d0,flip_speed(a0)
		move.w	d0,move_lock(a0)
		move.b	d0,invulnerability_timer(a0)
		move.b	d0,invincibility_timer(a0)
		move.b	d0,speed_shoes_timer(a0)
		move.b	d0,status_tertiary(a0)
		move.b	d0,scroll_delay_counter(a0)
		move.w	d0,next_tilt(a0)	; and tilt
		move.b	d0,stick_to_convex(a0)
		move.b	d0,spin_dash_flag(a0)
		move.b	d0,spin_dash_flag(a0)
		move.w	d0,spin_dash_counter(a0)
		move.b	d0,jumping(a0)
		move.b	d0,$41(a0)
		move.b	#(8*60)/2,double_jump_property(a0)
		bsr.w	Tails_Set_Flying_Animation

locret_13BF6:
		rts
; ---------------------------------------------------------------------------

Tails_FlySwim_Unknown:
		tst.b	render_flags(a0)
		bmi.s	loc_13C3A
		addq.w	#1,(Tails_CPU_flight_timer).w
		cmpi.w	#5*60,(Tails_CPU_flight_timer).w
		blo.s	loc_13C50
		move.w	#0,(Tails_CPU_flight_timer).w
		move.w	#2,(Tails_CPU_routine).w
		move.b	#$81,object_control(a0)
		move.b	#1<<Status_InAir,status(a0)
		move.w	#0,x_pos(a0)
		move.w	#0,y_pos(a0)
		move.b	#(8*60)/2,double_jump_property(a0)
		bsr.w	Tails_Set_Flying_Animation
		rts
; ---------------------------------------------------------------------------

loc_13C3A:
		move.b	#(8*60)/2,double_jump_property(a0)
		ori.b	#1<<Status_InAir,status(a0)
		bsr.w	Tails_Set_Flying_Animation
		move.w	#0,(Tails_CPU_flight_timer).w

loc_13C50:
		lea	(Pos_table).w,a2
		move.w	#$10,d2
		lsl.b	#2,d2
		addq.b	#4,d2
		move.w	(Pos_table_index).w,d3
		sub.b	d2,d3
		move.w	(a2,d3.w),(Tails_CPU_target_X).w
		move.w	2(a2,d3.w),(Tails_CPU_target_Y).w
		move.w	x_pos(a0),d0
		sub.w	(Tails_CPU_target_X).w,d0
		beq.s	loc_13CBE
		move.w	d0,d2
		bpl.s	loc_13C7E
		neg.w	d2

loc_13C7E:
		lsr.w	#4,d2
		cmpi.w	#$C,d2
		blo.s	loc_13C88
		moveq	#$C,d2

loc_13C88:
		move.b	x_vel(a1),d1
		bpl.s	loc_13C90
		neg.b	d1

loc_13C90:
		add.b	d1,d2
		addq.w	#1,d2
		tst.w	d0
		bmi.s	loc_13CAA
		bset	#Status_Facing,status(a0)
		cmp.w	d0,d2
		blo.s	loc_13CA6
		move.w	d0,d2
		moveq	#0,d0

loc_13CA6:
		neg.w	d2
		bra.s	loc_13CBA
; ---------------------------------------------------------------------------

loc_13CAA:
		bclr	#Status_Facing,status(a0)
		neg.w	d0
		cmp.w	d0,d2
		blo.s	loc_13CBA
		move.b	d0,d2
		moveq	#0,d0

loc_13CBA:
		add.w	d2,x_pos(a0)

loc_13CBE:
		moveq	#1,d2
		move.w	y_pos(a0),d1
		sub.w	(Tails_CPU_target_Y).w,d1
		beq.s	loc_13CD2
		bmi.s	loc_13CCE
		neg.w	d2

loc_13CCE:
		add.w	d2,y_pos(a0)

loc_13CD2:
		lea	(Stat_table).w,a2
		move.b	2(a2,d3.w),d2
		andi.b	#$80,d2
		bne.s	loc_13D42
		or.w	d0,d1
		bne.s	loc_13D42
		cmpi.b	#6,(Player_1+routine).w
		bhs.s	loc_13D42
		move.w	#6,(Tails_CPU_routine).w
		move.b	#0,object_control(a0)
		move.b	#0,anim(a0)
		move.w	#0,x_vel(a0)
		move.w	#0,y_vel(a0)
		move.w	#0,ground_vel(a0)
		andi.b	#1<<Status_Underwater,status(a0)
		ori.b	#1<<Status_InAir,status(a0)
		move.w	#0,move_lock(a0)
		andi.w	#drawing_mask,art_tile(a0)
		tst.b	art_tile(a1)
		bpl.s	loc_13D34
		ori.w	#high_priority,art_tile(a0)

loc_13D34:
		move.b	top_solid_bit(a1),top_solid_bit(a0)
		move.b	lrb_solid_bit(a1),lrb_solid_bit(a0)
		rts
; ---------------------------------------------------------------------------

loc_13D42:
		move.b	#$81,object_control(a0)
		rts
; ---------------------------------------------------------------------------

loc_13D4A:
		cmpi.b	#6,(Player_1+routine).w
		blo.s	loc_13D78
		move.w	#4,(Tails_CPU_routine).w
		move.b	#0,spin_dash_flag(a0)
		move.w	#0,spin_dash_counter(a0)
		move.b	#$81,object_control(a0)
		move.b	#1<<Status_InAir,status(a0)
		move.b	#$20,anim(a0)
		rts
; ---------------------------------------------------------------------------

loc_13D78:
		bsr.w	sub_13EFC
		tst.w	(Tails_CPU_idle_timer).w
		bne.w	loc_13EBE
		tst.b	object_control(a0)
		bmi.w	loc_13EBE
		tst.b	status_tertiary(a1)
		bmi.w	loc_13EBE
		tst.w	move_lock(a0)
		beq.s	loc_13DA6
		tst.w	ground_vel(a0)
		bne.s	loc_13DA6
		move.w	#8,(Tails_CPU_routine).w

loc_13DA6:
		lea	(Pos_table).w,a2
		move.w	#$10,d1
		lsl.b	#2,d1
		addq.b	#4,d1
		move.w	(Pos_table_index).w,d0
		sub.b	d1,d0
		move.w	(a2,d0.w),d2
		btst	#Status_OnObj,status(a1)
		bne.s	loc_13DD0
		cmpi.w	#$400,ground_vel(a1)
		bge.s	loc_13DD0
		subi.w	#$20,d2

loc_13DD0:
		move.w	2(a2,d0.w),d3
		lea	(Stat_table).w,a2
		move.w	(a2,d0.w),d1
		move.b	2(a2,d0.w),d4
		move.w	d1,d0
		btst	#Status_Push,status(a0)
		beq.s	loc_13DF2
		btst	#5,d4
		beq.w	loc_13E9C

loc_13DF2:
		sub.w	x_pos(a0),d2
		beq.s	loc_13E50
		bpl.s	loc_13E26
		neg.w	d2
		cmpi.w	#$30,d2
		blo.s	loc_13E0A
		andi.w	#$F3F3,d1
		ori.w	#$404,d1

loc_13E0A:
		tst.w	ground_vel(a0)
		beq.s	loc_13E64
		btst	#Status_Facing,status(a0)
		beq.s	loc_13E64
		btst	#0,object_control(a0)
		bne.s	loc_13E64
		subq.w	#1,x_pos(a0)
		bra.s	loc_13E64
; ---------------------------------------------------------------------------

loc_13E26:
		cmpi.w	#$30,d2
		blo.s	loc_13E34
		andi.w	#$F3F3,d1
		ori.w	#$808,d1

loc_13E34:
		tst.w	ground_vel(a0)
		beq.s	loc_13E64
		btst	#Status_Facing,status(a0)
		bne.s	loc_13E64
		btst	#0,object_control(a0)
		bne.s	loc_13E64
		addq.w	#1,x_pos(a0)
		bra.s	loc_13E64
; ---------------------------------------------------------------------------

loc_13E50:
		bclr	#Status_Facing,status(a0)
		move.b	d4,d0
		andi.b	#1,d0
		beq.s	loc_13E64
		bset	#Status_Facing,status(a0)

loc_13E64:
		tst.b	(Tails_CPU_auto_jump_flag).w
		beq.s	loc_13E7C
		ori.w	#((button_A_mask|button_B_mask|button_C_mask)<<8)|0,d1
		btst	#Status_InAir,status(a0)
		bne.s	loc_13EB8
		move.b	#0,(Tails_CPU_auto_jump_flag).w

loc_13E7C:
		move.w	(Level_frame_counter).w,d0
		andi.w	#$FF,d0
		beq.s	loc_13E8C
		cmpi.w	#$40,d2
		bhs.s	loc_13EB8

loc_13E8C:
		sub.w	y_pos(a0),d3
		beq.s	loc_13EB8
		bpl.s	loc_13EB8
		neg.w	d3
		cmpi.w	#$20,d3
		blo.s	loc_13EB8

loc_13E9C:
		move.b	(Level_frame_counter+1).w,d0
		andi.b	#$3F,d0
		bne.s	loc_13EB8
		cmpi.b	#8,anim(a0)
		beq.s	loc_13EB8
		ori.w	#((button_A_mask|button_B_mask|button_C_mask)<<8)|(button_A_mask|button_B_mask|button_C_mask),d1
		move.b	#1,(Tails_CPU_auto_jump_flag).w

loc_13EB8:
		move.w	d1,(Ctrl_2_logical).w
		rts
; ---------------------------------------------------------------------------

loc_13EBE:
		tst.w	(Tails_CPU_idle_timer).w
		beq.s	locret_13EC8
		subq.w	#1,(Tails_CPU_idle_timer).w

locret_13EC8:
		rts

; =============== S U B R O U T I N E =======================================


sub_13ECA:
		move.w	#0,(Tails_CPU_idle_timer).w
		move.w	#0,(Tails_CPU_flight_timer).w
		move.w	#2,(Tails_CPU_routine).w
		move.b	#$81,object_control(a0)
		move.b	#1<<Status_InAir,status(a0)
		move.w	#$7F00,x_pos(a0)
		move.w	#0,y_pos(a0)
		move.b	#0,double_jump_flag(a0)
		rts
; End of function sub_13ECA


; =============== S U B R O U T I N E =======================================


sub_13EFC:
		tst.b	render_flags(a0)
		bmi.s	loc_13F28
		btst	#Status_OnObj,status(a0)
		beq.s	loc_13F18
		moveq	#0,d0
		movea.w	interact(a0),a3
		move.w	(Tails_CPU_interact).w,d0
		cmp.w	(a3),d0
		bne.s	loc_13F24

loc_13F18:
		addq.w	#1,(Tails_CPU_flight_timer).w
		cmpi.w	#5*60,(Tails_CPU_flight_timer).w
		blo.s	loc_13F2E

loc_13F24:
		bra.w	sub_13ECA
; ---------------------------------------------------------------------------

loc_13F28:
		move.w	#0,(Tails_CPU_flight_timer).w

loc_13F2E:
		btst	#Status_OnObj,status(a0)
		beq.s	locret_13F3E
		movea.w	interact(a0),a3
		move.w	(a3),(Tails_CPU_interact).w

locret_13F3E:
		rts
; End of function sub_13EFC

; ---------------------------------------------------------------------------

loc_13F40:
		bsr.w	sub_13EFC
		tst.w	(Tails_CPU_idle_timer).w
		bne.w	locret_13FBE
		tst.w	move_lock(a0)
		bne.s	locret_13FBE
		tst.b	spin_dash_flag(a0)
		bne.s	loc_13F94
		tst.w	ground_vel(a0)
		bne.s	locret_13FBE
		bclr	#Status_Facing,status(a0)
		move.w	x_pos(a0),d0
		sub.w	x_pos(a1),d0
		bcs.s	loc_13F74
		bset	#Status_Facing,status(a0)

loc_13F74:
		move.w	#(button_down_mask<<8)|button_down_mask,(Ctrl_2_logical).w
		move.b	(Level_frame_counter+1).w,d0
		andi.b	#$7F,d0
		beq.s	loc_13FA4
		cmpi.b	#8,anim(a0)
		bne.s	locret_13FBE
		move.w	#((button_A_mask|button_B_mask|button_C_mask|button_down_mask)<<8)|(button_A_mask|button_B_mask|button_C_mask|button_down_mask),(Ctrl_2_logical).w
		rts
; ---------------------------------------------------------------------------

loc_13F94:
		move.w	#(button_down_mask<<8)|button_down_mask,(Ctrl_2_logical).w
		move.b	(Level_frame_counter+1).w,d0
		andi.b	#$7F,d0
		bne.s	loc_13FB2

loc_13FA4:
		move.w	#(0<<8)|0,(Ctrl_2_logical).w
		move.w	#6,(Tails_CPU_routine).w
		rts
; ---------------------------------------------------------------------------

loc_13FB2:
		andi.b	#$1F,d0
		bne.s	locret_13FBE
		ori.w	#((button_A_mask|button_B_mask|button_C_mask)<<8)|(button_A_mask|button_B_mask|button_C_mask),(Ctrl_2_logical).w

locret_13FBE:
		rts
; ---------------------------------------------------------------------------

locret_13FC0:
		rts
; ---------------------------------------------------------------------------

loc_13FC2:
		move.b	#1,double_jump_flag(a0)
		move.b	#(8*60)/2,double_jump_property(a0)
		move.b	#1<<Status_InAir,status(a0)
		move.w	#$100,x_vel(a0)
		move.w	#0,y_vel(a0)
		move.w	#0,ground_vel(a0)
		lea	(Player_1).w,a1
		bsr.w	sub_1459E
		move.b	#1,(Flying_carrying_Sonic_flag).w
		move.w	#$E,(Tails_CPU_routine).w

loc_13FFA:
		move.w	#0,(Tails_CPU_idle_timer).w
		move.w	#0,(Ctrl_2_logical).w
		move.b	(Level_frame_counter+1).w,d0
		andi.b	#$1F,d0
		bne.s	loc_14016
		ori.w	#(button_right_mask<<8)|button_right_mask,(Ctrl_2_logical).w

loc_14016:
		lea	(Flying_carrying_Sonic_flag).w,a2
		lea	(Player_1).w,a1
		btst	#Status_InAir,status(a1)
		bne.s	loc_14082
		move.w	#6,(Tails_CPU_routine).w
		move.b	#0,object_control(a0)
		move.b	#0,anim(a0)
		move.w	#0,x_vel(a0)
		move.w	#0,y_vel(a0)
		move.w	#0,ground_vel(a0)
		move.b	#1<<Status_InAir,status(a0)
		move.w	#0,move_lock(a0)
		andi.w	#drawing_mask,art_tile(a0)
		tst.b	art_tile(a1)
		bpl.s	loc_14068
		ori.w	#high_priority,art_tile(a0)

loc_14068:
		move.b	top_solid_bit(a1),top_solid_bit(a0)
		move.b	lrb_solid_bit(a1),lrb_solid_bit(a0)
		cmpi.w	#1,(Player_mode).w
		bne.s	loc_14082
		move.w	#$10,(Tails_CPU_routine).w

loc_14082:
		move.w	(Ctrl_1).w,d0
		bra.w	Tails_Carry_Sonic
; ---------------------------------------------------------------------------

loc_1408A:
		move.w	#0,(Tails_CPU_idle_timer).w
		move.b	#(8*60)/2,double_jump_property(a0)
		move.w	#(0<<8)|0,(Ctrl_2_logical).w
		move.b	(Level_frame_counter+1).w,d0
		andi.b	#$F,d0
		bne.s	loc_140AC
		ori.w	#((button_A_mask|button_B_mask|button_C_mask|button_right_mask)<<8)|(button_A_mask|button_B_mask|button_C_mask|button_right_mask),(Ctrl_2_logical).w

loc_140AC:
		tst.b	render_flags(a0)
		bmi.s	locret_140C4
		moveq	#0,d0
		move.l	d0,(a0)
		move.w	d0,x_pos(a0)
		move.w	d0,y_pos(a0)
		move.w	#$A,(Tails_CPU_routine).w

locret_140C4:
		rts
; ---------------------------------------------------------------------------

loc_140C6:
		move.w	#(0<<8)|0,(Ctrl_2_logical).w
		rts
; ---------------------------------------------------------------------------

loc_140CE:
		move.b	#1,double_jump_flag(a0)
		move.b	#(8*60)/2,double_jump_property(a0)
		move.b	#1<<Status_InAir,status(a0)
		move.w	#0,x_vel(a0)
		move.w	#0,y_vel(a0)
		move.w	#0,ground_vel(a0)
		lea	(Player_1).w,a1
		bsr.w	sub_1459E
		move.b	#1,(Flying_carrying_Sonic_flag).w
		move.w	#$16,(Tails_CPU_routine).w

loc_14106:
		move.w	#0,(Tails_CPU_idle_timer).w
		move.b	#(8*60)/2,double_jump_property(a0)
		move.w	#0,(Ctrl_2_logical).w
		move.b	(Level_frame_counter+1).w,d0
		andi.b	#7,d0
		bne.s	loc_14128
		ori.w	#((button_A_mask|button_B_mask|button_C_mask)<<8)|(button_A_mask|button_B_mask|button_C_mask),(Ctrl_2_logical).w

loc_14128:
		move.w	(Camera_Y_pos).w,d0
		addi.w	#$90,d0
		cmp.w	y_pos(a0),d0
		blo.s	loc_1413C
		move.w	#$18,(Tails_CPU_routine).w

loc_1413C:
		lea	(Flying_carrying_Sonic_flag).w,a2
		lea	(Player_1).w,a1
		move.w	(Ctrl_1).w,d0
		bra.w	Tails_Carry_Sonic
; ---------------------------------------------------------------------------

loc_1414C:
		move.b	#(8*60)/2,double_jump_property(a0)
		tst.w	(Tails_CPU_idle_timer).w
		beq.s	loc_14164
		tst.b	(Flying_carrying_Sonic_flag).w
		bne.w	loc_141E2
		bra.w	loc_142E2
; ---------------------------------------------------------------------------

loc_14164:
		move.w	#(0<<8)|0,(Ctrl_2_logical).w
		tst.b	(Flying_carrying_Sonic_flag).w
		beq.w	loc_142E2
		clr.b	(_unkFAAC).w
		btst	#button_down,(Ctrl_1_held).w
		beq.s	loc_14198
		addq.b	#1,(Tails_CPU_auto_fly_timer).w
		cmpi.b	#$C0,(Tails_CPU_auto_fly_timer).w
		blo.s	loc_141D2
		move.b	#0,(Tails_CPU_auto_fly_timer).w
		ori.w	#((button_A_mask|button_B_mask|button_C_mask)<<8)|(button_A_mask|button_B_mask|button_C_mask),(Ctrl_2_logical).w
		bra.s	loc_141D2
; ---------------------------------------------------------------------------

loc_14198:
		btst	#button_up,(Ctrl_1_held).w
		beq.s	loc_141BA
		addq.b	#1,(Tails_CPU_auto_fly_timer).w
		cmpi.b	#$20,(Tails_CPU_auto_fly_timer).w
		blo.s	loc_141D2
		move.b	#0,(Tails_CPU_auto_fly_timer).w
		ori.w	#((button_A_mask|button_B_mask|button_C_mask)<<8)|(button_A_mask|button_B_mask|button_C_mask),(Ctrl_2_logical).w
		bra.s	loc_141D2
; ---------------------------------------------------------------------------

loc_141BA:
		addq.b	#1,(Tails_CPU_auto_fly_timer).w
		cmpi.b	#$58,(Tails_CPU_auto_fly_timer).w
		blo.s	loc_141D2
		move.b	#0,(Tails_CPU_auto_fly_timer).w
		ori.w	#((button_A_mask|button_B_mask|button_C_mask)<<8)|(button_A_mask|button_B_mask|button_C_mask),(Ctrl_2_logical).w

loc_141D2:
		move.b	(Ctrl_1).w,d0
		andi.b	#button_left_mask|button_right_mask,d0
		or.b	(Ctrl_2_logical).w,d0
		move.b	d0,(Ctrl_2_logical).w

loc_141E2:
		lea	(Flying_carrying_Sonic_flag).w,a2
		lea	(Player_1).w,a1
		move.w	(Ctrl_1).w,d0
		bra.w	Tails_Carry_Sonic
; ---------------------------------------------------------------------------

loc_141F2:
		move.b	#1,double_jump_flag(a0)
		move.b	#(8*60)/2,double_jump_property(a0)
		move.b	#1<<Status_InAir,status(a0)
		move.w	#0,x_vel(a0)
		move.w	#0,y_vel(a0)
		move.w	#0,ground_vel(a0)
		move.w	#$1C,(Tails_CPU_routine).w

loc_1421C:
		move.w	#0,(Tails_CPU_idle_timer).w
		move.b	#(8*60)/2,double_jump_property(a0)
		move.w	#0,(Ctrl_2_logical).w
		move.b	(Level_frame_counter+1).w,d0
		andi.b	#7,d0
		bne.s	loc_1423E
		ori.w	#((button_A_mask|button_B_mask|button_C_mask)<<8)|(button_A_mask|button_B_mask|button_C_mask),(Ctrl_2_logical).w

loc_1423E:
		move.w	(Camera_Y_pos).w,d0
		addi.w	#$90,d0
		cmp.w	y_pos(a0),d0
		blo.s	locret_14252
		move.w	#$1E,(Tails_CPU_routine).w

locret_14252:
		rts
; ---------------------------------------------------------------------------

loc_14254:
		move.b	#(8*60)/2,double_jump_property(a0)
		rts
; ---------------------------------------------------------------------------

loc_1425C:
		move.b	#1,double_jump_flag(a0)
		move.b	#(8*60)/2,double_jump_property(a0)
		move.b	#2,status(a0)
		move.w	#$100,x_vel(a0)
		move.w	#0,y_vel(a0)
		move.w	#0,ground_vel(a0)
		move.w	#$22,(Tails_CPU_routine).w

loc_14286:
		move.w	#0,(Tails_CPU_idle_timer).w
		move.w	#(0<<8)|0,(Ctrl_2_logical).w
		move.b	(Level_frame_counter+1).w,d0
		andi.b	#$1F,d0
		bne.s	loc_142A2
		ori.w	#(button_right_mask<<8)|button_right_mask,(Ctrl_2_logical).w

loc_142A2:
		btst	#Status_InAir,status(a0)
		bne.s	locret_142E0
		move.w	#6,(Tails_CPU_routine).w
		move.b	#0,object_control(a0)
		move.b	#0,anim(a0)
		move.w	#0,x_vel(a0)
		move.w	#0,y_vel(a0)
		move.w	#0,ground_vel(a0)
		move.b	#1<<Status_InAir,status(a0)
		move.w	#0,move_lock(a0)
		andi.w	#drawing_mask,art_tile(a0)

locret_142E0:
		rts
; ---------------------------------------------------------------------------

loc_142E2:
		tst.b	(_unkFAAC).w
		bne.s	loc_14362
		lea	(Player_1).w,a1
		tst.b	render_flags(a1)
		bpl.s	loc_14330
		tst.w	(Tails_CPU_idle_timer).w
		bne.w	loc_143AA
		cmpi.w	#$300,y_vel(a1)
		bge.s	loc_14330
		move.w	#0,x_vel(a0)
		move.w	#(0<<8)|0,(Ctrl_2_logical).w
		cmpi.w	#$200,y_vel(a0)
		bge.s	loc_14328
		addq.b	#1,(Tails_CPU_auto_fly_timer).w
		cmpi.b	#$58,(Tails_CPU_auto_fly_timer).w
		blo.s	loc_1432E
		move.b	#0,(Tails_CPU_auto_fly_timer).w

loc_14328:
		ori.w	#((button_A_mask|button_B_mask|button_C_mask)<<8)|(button_A_mask|button_B_mask|button_C_mask),(Ctrl_2_logical).w

loc_1432E:
		bra.s	loc_143AA
; ---------------------------------------------------------------------------

loc_14330:
		st	(_unkFAAC).w
		move.w	y_pos(a1),d1
		sub.w	y_pos(a0),d1
		bpl.s	loc_14340
		neg.w	d1

loc_14340:
		lsr.w	#2,d1
		move.w	d1,d2
		lsr.w	#1,d2
		add.w	d2,d1
		move.w	d1,(Camera_stored_min_X_pos).w
		move.w	x_pos(a1),d1
		sub.w	x_pos(a0),d1
		bpl.s	loc_14358
		neg.w	d1

loc_14358:
		lsr.w	#2,d1
		move.w	d1,(Camera_stored_max_X_pos).w
		bra.w	loc_143AA
; ---------------------------------------------------------------------------

loc_14362:
		move.w	#(0<<8)|0,(Ctrl_2_logical).w
		lea	(Player_1).w,a1
		move.w	x_pos(a0),d0
		move.w	y_pos(a0),d1
		subi.w	#$10,d1
		move.w	(Camera_stored_max_X_pos).w,d2
		bclr	#Status_Facing,status(a0)
		cmp.w	x_pos(a1),d0
		blo.s	loc_14390
		bset	#Status_Facing,status(a0)
		neg.w	d2

loc_14390:
		add.w	d2,x_vel(a0)
		cmp.w	y_pos(a1),d1
		bhs.s	loc_143AA
		move.w	(Camera_stored_min_X_pos).w,d2
		cmp.w	y_pos(a1),d1
		blo.s	loc_143A6
		neg.w	d2

loc_143A6:
		add.w	d2,y_vel(a0)

loc_143AA:
		lea	(Flying_carrying_Sonic_flag).w,a2
		lea	(Player_1).w,a1
		move.w	(Ctrl_1).w,d0
		bra.w	Tails_Carry_Sonic

; =============== S U B R O U T I N E =======================================


Tails_Carry_Sonic:
		tst.b	(a2)
		beq.w	loc_14534
		cmpi.b	#4,routine(a1)
		bhs.w	loc_14466
		btst	#Status_InAir,status(a1)
		beq.w	loc_1445A
		move.w	(_unkF744).w,d1
		cmp.w	x_vel(a1),d1
		bne.s	loc_1445A
		move.w	(_unkF74C).w,d1
		cmp.w	y_vel(a1),d1
		bne.s	loc_14460
		tst.b	object_control(a1)
		bmi.s	loc_1446A
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0
		beq.w	loc_14474
		clr.b	object_control(a1)
		clr.b	(a2)
		move.b	#$12,1(a2)
		andi.w	#(button_up_mask|button_down_mask|button_left_mask|button_right_mask)<<8,d0
		beq.w	loc_14410
		move.b	#$3C,1(a2)

loc_14410:
		btst	#button_left+8,d0
		beq.s	loc_1441C
		move.w	#-$200,x_vel(a1)

loc_1441C:
		btst	#button_right+8,d0
		beq.s	loc_14428
		move.w	#$200,x_vel(a1)

loc_14428:
		move.w	#-$380,y_vel(a1)
		bset	#Status_InAir,status(a1)
		move.b	#1,jumping(a1)
		move.b	#$E,y_radius(a1)
		move.b	#7,x_radius(a1)
		move.b	#2,anim(a1)
		bset	#Status_Roll,status(a1)
		bclr	#Status_RollJump,status(a1)
		rts
; ---------------------------------------------------------------------------

loc_1445A:
		move.w	#-$100,y_vel(a1)

loc_14460:
		move.b	#0,jumping(a1)

loc_14466:
		clr.b	object_control(a1)

loc_1446A:
		clr.b	(a2)
		move.b	#$3C,1(a2)
		rts
; ---------------------------------------------------------------------------

loc_14474:
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		addi.w	#$1C,y_pos(a1)
		tst.b	(Reverse_gravity_flag).w
		beq.s	loc_14492
		subi.w	#2*$1C,y_pos(a1)

loc_14492:
		andi.b	#$FC,render_flags(a1)
		andi.b	#$FE,status(a1)
		move.b	status(a0),d0
		andi.b	#1,d0
		or.b	d0,render_flags(a1)
		or.b	d0,status(a1)
		tst.b	(Reverse_gravity_flag).w
		beq.s	loc_144BA
		eori.b	#2,render_flags(a1)

loc_144BA:
		subq.b	#1,anim_frame_timer(a1)
		bpl.s	loc_144F8
		move.b	#$B,anim_frame_timer(a1)
		moveq	#0,d1
		move.b	anim_frame(a1),d1
		addq.b	#1,anim_frame(a1)
		move.b	AniRaw_Tails_Carry(pc,d1.w),d0
		cmpi.b	#-1,d0
		bne.s	loc_144E4
		move.b	#0,anim_frame(a1)
		move.b	AniRaw_Tails_Carry(pc),d0

loc_144E4:
		move.b	d0,mapping_frame(a1)
		moveq	#0,d0
		move.b	mapping_frame(a1),d0
		move.l	a2,-(sp)
		jsr	(Perform_Player_DPLC).l
		movea.l	(sp)+,a2

loc_144F8:
		move.w	x_vel(a0),(Player_1+x_vel).w
		move.w	x_vel(a0),(_unkF744).w
		move.w	y_vel(a0),(Player_1+y_vel).w
		move.w	y_vel(a0),(_unkF74C).w
		movem.l	d0-a6,-(sp)
		lea	(Player_1).w,a0
		bsr.w	SonicKnux_DoLevelCollision
		movem.l	(sp)+,d0-a6
		rts
; ---------------------------------------------------------------------------
AniRaw_Tails_Carry:
		dc.b  $91, $91, $90, $90, $90, $90, $90, $90, $92, $92, $92, $92, $92, $92, $91, $91, $FF
		even
; ---------------------------------------------------------------------------

loc_14534:
		tst.b	1(a2)
		beq.s	loc_14542
		subq.b	#1,1(a2)
		bne.w	locret_1459C

loc_14542:
		move.w	x_pos(a1),d0
		sub.w	x_pos(a0),d0
		addi.w	#$10,d0
		cmpi.w	#$20,d0
		bhs.w	locret_1459C
		move.w	y_pos(a1),d1
		sub.w	y_pos(a0),d1
		subi.w	#$20,d1
		tst.b	(Reverse_gravity_flag).w
		beq.s	loc_1456C
		addi.w	#$50,d1

loc_1456C:
		cmpi.w	#$10,d1
		bhs.w	locret_1459C
		tst.b	object_control(a1)
		bne.s	locret_1459C
		cmpi.b	#4,routine(a1)
		bhs.s	locret_1459C
		tst.w	(Debug_placement_mode).w
		bne.s	locret_1459C
		tst.b	spin_dash_flag(a1)
		bne.s	locret_1459C
		bsr.s	sub_1459E
		moveq	#signextendB(sfx_Grab),d0
		jsr	(Play_SFX).l
		move.b	#1,(a2)

locret_1459C:
		rts
; End of function Tails_Carry_Sonic


; =============== S U B R O U T I N E =======================================


sub_1459E:
		clr.w	x_vel(a1)
		clr.w	y_vel(a1)
		clr.w	ground_vel(a1)
		clr.w	angle(a1)
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		addi.w	#$1C,y_pos(a1)
		move.w	#$22<<8,anim(a1)	; and prev_anim
		move.b	#0,anim_frame_timer(a1)
		move.b	#0,anim_frame(a1)
		move.b	#3,object_control(a1)
		bset	#Status_InAir,status(a1)
		bclr	#Status_RollJump,status(a1)
		move.b	#0,spin_dash_flag(a1)
		andi.b	#$FC,render_flags(a1)
		andi.b	#$FE,status(a1)
		move.b	status(a0),d0
		andi.b	#1,d0
		or.b	d0,render_flags(a1)
		or.b	d0,status(a1)
		move.w	x_vel(a0),(_unkF744).w
		move.w	x_vel(a0),x_vel(a1)
		move.w	y_vel(a0),(_unkF74C).w
		move.w	y_vel(a0),y_vel(a1)
		tst.b	(Reverse_gravity_flag).w
		beq.s	locret_14630
		subi.w	#$38,y_pos(a1)
		eori.b	#2,render_flags(a1)

locret_14630:
		rts
; End of function sub_1459E


; =============== S U B R O U T I N E =======================================


Tails_Water:
		tst.b	(Water_flag).w
		bne.s	loc_1463A

locret_14638:
		rts
; ---------------------------------------------------------------------------

loc_1463A:
		move.w	(Water_level).w,d0
		cmp.w	y_pos(a0),d0
		bge.s	loc_146BA
		bset	#Status_Underwater,status(a0)
		bne.s	locret_14638
		addq.b	#1,(Water_entered_counter).w
		movea.l	a0,a1
		bsr.w	Player_ResetAirTimer
		move.l	#Obj_AirCountdown,(Breathing_bubbles_P2).w
		move.b	#$81,(Breathing_bubbles_P2+subtype).w
		move.l	a0,(Breathing_bubbles_P2+$40).w
		move.w	#$300,Max_speed-Max_speed(a4)
		move.w	#6,Acceleration-Max_speed(a4)
		move.w	#$40,Deceleration-Max_speed(a4)
		tst.b	(Super_Tails_flag).w
		beq.s	loc_1468E
		move.w	#$400,Max_speed-Max_speed(a4)
		move.w	#$C,Acceleration-Max_speed(a4)
		move.w	#$60,Deceleration-Max_speed(a4)

loc_1468E:
		cmpi.w	#4,(Tails_CPU_routine).w
		beq.s	loc_1469C
		tst.b	object_control(a0)
		bne.s	locret_14638

loc_1469C:
		asr	x_vel(a0)
		asr	y_vel(a0)
		asr	y_vel(a0)
		beq.s	locret_14638
		move.w	#1<<8,anim(a6)	; and prev_anim
		move.w	#sfx_Splash,d0
		jmp	(Play_SFX).l
; ---------------------------------------------------------------------------

loc_146BA:
		bclr	#Status_Underwater,status(a0)
		beq.w	locret_14638
		addq.b	#1,(Water_entered_counter).w
		movea.l	a0,a1
		bsr.w	Player_ResetAirTimer
		move.w	#$600,Max_speed-Max_speed(a4)
		move.w	#$C,Acceleration-Max_speed(a4)
		move.w	#$80,Deceleration-Max_speed(a4)
		tst.b	(Super_Tails_flag).w
		beq.s	loc_146F4
		move.w	#$800,Max_speed-Max_speed(a4)
		move.w	#$18,Acceleration-Max_speed(a4)
		move.w	#$C0,Deceleration-Max_speed(a4)

loc_146F4:
		cmpi.b	#4,routine(a0)
		beq.s	loc_14718
		cmpi.w	#4,(Tails_CPU_routine).w
		beq.s	loc_1470A
		tst.b	object_control(a0)
		bne.s	loc_14718

loc_1470A:
		move.w	y_vel(a0),d0
		cmpi.w	#-$400,d0
		blt.s	loc_14718
		asl	y_vel(a0)

loc_14718:
		cmpi.b	#$1C,anim(a0)
		beq.w	locret_14638
		tst.w	y_vel(a0)
		beq.w	locret_14638
		move.w	#1<<8,anim(a6)	; and prev_anim
		cmpi.w	#-$1000,y_vel(a0)
		bgt.s	loc_1473E
		move.w	#-$1000,y_vel(a0)

loc_1473E:
		move.w	#sfx_Splash,d0
		jmp	(Play_SFX).l
; End of function Tails_Water

; ---------------------------------------------------------------------------

Tails_Stand_Path:
		tst.b	(Flying_carrying_Sonic_flag).w
		beq.s	loc_14760
		lea	(Player_1).w,a1
		clr.b	object_control(a1)
		bset	#Status_InAir,status(a1)
		clr.w	(Flying_carrying_Sonic_flag).w

loc_14760:
		bsr.w	Tails_Spindash
		bsr.w	Tails_Jump
		bsr.w	Player_SlopeResist
		bsr.w	Tails_InputAcceleration_Path
		bsr.w	Tails_Roll
		bsr.w	Tails_Check_Screen_Boundaries
		jsr	(MoveSprite_TestGravity2).l
		bsr.w	Call_Player_AnglePos
		bsr.w	Player_SlopeRepel
		tst.b	(Background_collision_flag).w
		beq.s	locret_147B6
		bsr.w	sub_F846
		tst.w	d1
		bmi.w	Kill_Character
		movem.l	a4-a6,-(sp)
		bsr.w	CheckLeftWallDist
		tst.w	d1
		bpl.s	loc_147A6
		sub.w	d1,x_pos(a0)

loc_147A6:
		bsr.w	CheckRightWallDist
		tst.w	d1
		bpl.s	loc_147B2
		add.w	d1,x_pos(a0)

loc_147B2:
		movem.l	(sp)+,a4-a6

locret_147B6:
		rts
; ---------------------------------------------------------------------------

Tails_Stand_Freespace:
		tst.b	double_jump_flag(a0)
		bne.s	Tails_FlyingSwimming
		bsr.w	Tails_JumpHeight
		bsr.w	Tails_InputAcceleration_Freespace
		bsr.w	Tails_Check_Screen_Boundaries
		jsr	(MoveSprite_TestGravity).l
		btst	#Status_Underwater,status(a0)
		beq.s	loc_147DE
		subi.w	#$28,y_vel(a0)

loc_147DE:
		bsr.w	Player_JumpAngle
		bsr.w	Tails_DoLevelCollision
		rts
; ---------------------------------------------------------------------------

Tails_FlyingSwimming:
		bsr.w	Tails_Move_FlySwim
		bsr.w	Tails_InputAcceleration_Freespace
		bsr.w	Tails_Check_Screen_Boundaries
		jsr	(MoveSprite_TestGravity2).l
		bsr.w	Player_JumpAngle
		movem.l	a4-a6,-(sp)
		bsr.w	Tails_DoLevelCollision
		movem.l	(sp)+,a4-a6
		tst.w	(Player_mode).w
		bne.s	locret_14820
		lea	(Flying_carrying_Sonic_flag).w,a2
		lea	(Player_1).w,a1
		move.w	(Ctrl_1).w,d0
		bsr.w	Tails_Carry_Sonic

locret_14820:
		rts

; =============== S U B R O U T I N E =======================================


Tails_Move_FlySwim:
		move.b	(Level_frame_counter+1).w,d0
		andi.b	#1,d0
		beq.s	loc_14836
		tst.b	double_jump_property(a0)
		beq.s	loc_14836
		subq.b	#1,double_jump_property(a0)

loc_14836:
		cmpi.b	#1,double_jump_flag(a0)
		beq.s	loc_14860
		cmpi.w	#-$100,y_vel(a0)
		blt.s	loc_14858
		subi.w	#$20,y_vel(a0)
		addq.b	#1,double_jump_flag(a0)
		cmpi.b	#$20,double_jump_flag(a0)
		bne.s	loc_1485E

loc_14858:
		move.b	#1,double_jump_flag(a0)

loc_1485E:
		bra.s	loc_14892
; ---------------------------------------------------------------------------

loc_14860:
		move.b	(Ctrl_2_pressed_logical).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0
		beq.s	loc_1488C
		cmpi.w	#-$100,y_vel(a0)
		blt.s	loc_1488C
		tst.b	double_jump_property(a0)
		beq.s	loc_1488C
		btst	#Status_Underwater,status(a0)
		beq.s	loc_14886
		tst.b	(Flying_carrying_Sonic_flag).w
		bne.s	loc_1488C

loc_14886:
		move.b	#2,double_jump_flag(a0)

loc_1488C:
		addi.w	#8,y_vel(a0)

loc_14892:
		move.w	(Camera_min_Y_pos).w,d0
		addi.w	#$10,d0
		cmp.w	y_pos(a0),d0
		blt.s	Tails_Set_Flying_Animation
		tst.w	y_vel(a0)
		bpl.s	Tails_Set_Flying_Animation
		move.w	#0,y_vel(a0)
; End of function Tails_Move_FlySwim


; =============== S U B R O U T I N E =======================================


Tails_Set_Flying_Animation:
		btst	#Status_Underwater,status(a0)
		bne.s	loc_14914
		moveq	#$20,d0
		tst.w	(Competition_mode).w
		bne.s	loc_148F4
		tst.w	y_vel(a0)
		bpl.s	loc_148C4
		moveq	#$21,d0

loc_148C4:
		tst.b	(Flying_carrying_Sonic_flag).w
		beq.s	loc_148CC
		addq.b	#2,d0

loc_148CC:
		tst.b	double_jump_property(a0)
		bne.s	loc_148F4
		moveq	#$24,d0
		move.b	d0,anim(a0)
		tst.b	render_flags(a0)
		bpl.s	locret_148F2
		move.b	(Level_frame_counter+1).w,d0
		addq.b	#8,d0
		andi.b	#$F,d0
		bne.s	locret_148F2
		moveq	#signextendB(sfx_FlyTired),d0
		jsr	(Play_SFX).l

locret_148F2:
		rts
; ---------------------------------------------------------------------------

loc_148F4:
		move.b	d0,anim(a0)
		tst.b	render_flags(a0)
		bpl.s	locret_14912
		move.b	(Level_frame_counter+1).w,d0
		addq.b	#8,d0
		andi.b	#$F,d0
		bne.s	locret_14912
		moveq	#signextendB(sfx_Flying),d0
		jsr	(Play_SFX).l

locret_14912:
		rts
; ---------------------------------------------------------------------------

loc_14914:
		moveq	#$25,d0
		tst.w	y_vel(a0)
		bpl.s	loc_1491E
		moveq	#$26,d0

loc_1491E:
		tst.b	(Flying_carrying_Sonic_flag).w
		beq.s	loc_14926
		moveq	#$27,d0

loc_14926:
		tst.b	double_jump_property(a0)
		bne.s	loc_1492E
		moveq	#$28,d0

loc_1492E:
		move.b	d0,anim(a0)
		rts
; End of function Tails_Set_Flying_Animation

; ---------------------------------------------------------------------------

Tails_Spin_Path:
		tst.b	(Flying_carrying_Sonic_flag).w
		beq.s	loc_1494C
		lea	(Player_1).w,a1
		clr.b	object_control(a1)
		bset	#1,status(a1)
		clr.w	(Flying_carrying_Sonic_flag).w

loc_1494C:
		tst.b	spin_dash_flag(a0)
		bne.s	loc_14956
		bsr.w	Tails_Jump

loc_14956:
		bsr.w	Player_RollRepel
		bsr.w	Tails_RollSpeed
		bsr.w	Tails_Check_Screen_Boundaries
		jsr	(MoveSprite_TestGravity2).l
		bsr.w	Call_Player_AnglePos
		bsr.w	Player_SlopeRepel
		tst.b	(Background_collision_flag).w
		beq.s	locret_149A0
		bsr.w	sub_F846
		tst.w	d1
		bmi.w	Kill_Character
		movem.l	a4-a6,-(sp)
		bsr.w	CheckLeftWallDist
		tst.w	d1
		bpl.s	loc_14990
		sub.w	d1,x_pos(a0)

loc_14990:
		bsr.w	CheckRightWallDist
		tst.w	d1
		bpl.s	loc_1499C
		add.w	d1,x_pos(a0)

loc_1499C:
		movem.l	(sp)+,a4-a6

locret_149A0:
		rts
; ---------------------------------------------------------------------------

Tails_Spin_Freespace:
		tst.b	(Flying_carrying_Sonic_flag).w
		beq.s	loc_149BA
		lea	(Player_1).w,a1
		clr.b	object_control(a1)
		bset	#Status_InAir,status(a1)
		clr.w	(Flying_carrying_Sonic_flag).w

loc_149BA:
		bsr.w	Tails_JumpHeight
		bsr.w	Tails_InputAcceleration_Freespace
		bsr.w	Tails_Check_Screen_Boundaries
		jsr	(MoveSprite_TestGravity).l
		btst	#Status_Underwater,status(a0)
		beq.s	loc_149DA
		subi.w	#$28,y_vel(a0)

loc_149DA:
		bsr.w	Player_JumpAngle
		bsr.w	Tails_DoLevelCollision
		rts

; =============== S U B R O U T I N E =======================================


Tails_InputAcceleration_Path:
		move.w	Max_speed_P2-Max_speed_P2(a4),d6
		move.w	Acceleration_P2-Max_speed_P2(a4),d5
		move.w	Deceleration_P2-Max_speed_P2(a4),d4
		tst.b	status_secondary(a0)
		bmi.w	loc_14B5C
		tst.w	move_lock(a0)
		bne.w	loc_14B14
		btst	#button_left,(Ctrl_2_held_logical).w
		beq.s	loc_14A0A
		bsr.w	sub_14C20

loc_14A0A:
		btst	#button_right,(Ctrl_2_logical).w
		beq.s	loc_14A16
		bsr.w	sub_14CAC

loc_14A16:
		move.b	angle(a0),d0
		addi.b	#$20,d0
		andi.b	#$C0,d0
		bne.w	loc_14B14
		tst.w	ground_vel(a0)
		bne.w	loc_14B14
		bclr	#Status_Push,status(a0)
		move.b	#5,anim(a0)
		btst	#Status_OnObj,status(a0)
		beq.s	loc_14A6C
		movea.w	interact(a0),a1
		tst.b	status(a1)
		bmi.s	loc_14AA0
		moveq	#0,d1
		move.b	width_pixels(a1),d1
		move.w	d1,d2
		add.w	d2,d2
		subq.w	#4,d2
		add.w	x_pos(a0),d1
		sub.w	x_pos(a1),d1
		cmpi.w	#4,d1
		blt.s	loc_14A92
		cmp.w	d2,d1
		bge.s	loc_14A82
		bra.s	loc_14AA0
; ---------------------------------------------------------------------------

loc_14A6C:
		move.w	x_pos(a0),d3
		bsr.w	ChooseChkFloorEdge
		cmpi.w	#$C,d1
		blt.s	loc_14AA0
		cmpi.b	#3,next_tilt(a0)
		bne.s	loc_14A8A

loc_14A82:
		bclr	#Status_Facing,status(a0)
		bra.s	loc_14A98
; ---------------------------------------------------------------------------

loc_14A8A:
		cmpi.b	#3,tilt(a0)
		bne.s	loc_14AA0

loc_14A92:
		bset	#Status_Facing,status(a0)

loc_14A98:
		move.b	#6,anim(a0)
		bra.s	loc_14B14
; ---------------------------------------------------------------------------

loc_14AA0:
		btst	#button_down,(Ctrl_2_held_logical).w
		beq.s	loc_14ADA
		move.b	#8,anim(a0)
		addq.b	#1,scroll_delay_counter(a0)
		cmpi.b	#2*60,scroll_delay_counter(a0)
		blo.s	loc_14B1A
		move.b	#2*60,scroll_delay_counter(a0)
		tst.b	(Reverse_gravity_flag).w
		bne.s	loc_14AD0
		cmpi.w	#8,(a5)
		beq.s	loc_14B26
		subq.w	#2,(a5)
		bra.s	loc_14B26
; ---------------------------------------------------------------------------

loc_14AD0:
		cmpi.w	#$D8,(a5)
		beq.s	loc_14B26
		addq.w	#2,(a5)
		bra.s	loc_14B26
; ---------------------------------------------------------------------------

loc_14ADA:
		btst	#button_up,(Ctrl_2_logical).w
		beq.s	loc_14B14
		move.b	#7,anim(a0)
		addq.b	#1,scroll_delay_counter(a0)
		cmpi.b	#2*60,scroll_delay_counter(a0)
		blo.s	loc_14B1A
		move.b	#2*60,scroll_delay_counter(a0)
		tst.b	(Reverse_gravity_flag).w
		bne.s	loc_14B0A
		cmpi.w	#$C8,(a5)
		beq.s	loc_14B26
		addq.w	#2,(a5)
		bra.s	loc_14B26
; ---------------------------------------------------------------------------

loc_14B0A:
		cmpi.w	#$18,(a5)
		beq.s	loc_14B26
		subq.w	#2,(a5)
		bra.s	loc_14B26
; ---------------------------------------------------------------------------

loc_14B14:
		move.b	#0,scroll_delay_counter(a0)

loc_14B1A:
		cmpi.w	#$60,(a5)
		beq.s	loc_14B26
		bcc.s	loc_14B24
		addq.w	#4,(a5)

loc_14B24:
		subq.w	#2,(a5)

loc_14B26:
		tst.b	(Super_Tails_flag).w
		beq.s	loc_14B30
		move.w	#$C,d5

loc_14B30:
		move.b	(Ctrl_2_held_logical).w,d0
		andi.b	#button_left_mask|button_right_mask,d0
		bne.s	loc_14B5C
		move.w	ground_vel(a0),d0
		beq.s	loc_14B5C
		bmi.s	loc_14B50
		sub.w	d5,d0
		bcc.s	loc_14B4A
		move.w	#0,d0

loc_14B4A:
		move.w	d0,ground_vel(a0)
		bra.s	loc_14B5C
; ---------------------------------------------------------------------------

loc_14B50:
		add.w	d5,d0
		bcc.s	loc_14B58
		move.w	#0,d0

loc_14B58:
		move.w	d0,ground_vel(a0)

loc_14B5C:
		move.b	angle(a0),d0
		jsr	(GetSineCosine).l
		muls.w	ground_vel(a0),d1
		asr.l	#8,d1
		move.w	d1,x_vel(a0)
		muls.w	ground_vel(a0),d0
		asr.l	#8,d0
		move.w	d0,y_vel(a0)

loc_14B7A:
		btst	#6,object_control(a0)
		bne.w	locret_14C1E
		move.b	angle(a0),d0
		andi.b	#$3F,d0
		beq.s	loc_14B9A
		move.b	angle(a0),d0
		addi.b	#$40,d0
		bmi.w	locret_14C1E

loc_14B9A:
		move.b	#$40,d1
		tst.w	ground_vel(a0)
		beq.s	locret_14C1E
		bmi.s	loc_14BA8
		neg.w	d1

loc_14BA8:
		move.b	angle(a0),d0
		add.b	d1,d0
		move.w	d0,-(sp)
		bsr.w	sub_F61C
		move.w	(sp)+,d0
		tst.w	d1
		bpl.s	locret_14C1E
		asl.w	#8,d1
		cmpi.b	#8,(Current_zone).w
		bne.s	loc_14BCA
		tst.b	d0
		bpl.s	loc_14BCA
		subq.b	#1,d0

loc_14BCA:
		addi.b	#$20,d0
		andi.b	#$C0,d0
		beq.s	loc_14C1A
		cmpi.b	#$40,d0
		beq.s	loc_14C00
		cmpi.b	#$80,d0
		beq.s	loc_14BFA
		add.w	d1,x_vel(a0)
		move.w	#0,ground_vel(a0)
		btst	#Status_Facing,status(a0)
		bne.s	locret_14BF8
		bset	#Status_Push,status(a0)

locret_14BF8:
		rts
; ---------------------------------------------------------------------------

loc_14BFA:
		sub.w	d1,y_vel(a0)
		rts
; ---------------------------------------------------------------------------

loc_14C00:
		sub.w	d1,x_vel(a0)
		move.w	#0,ground_vel(a0)
		btst	#Status_Facing,status(a0)
		beq.s	locret_14BF8
		bset	#Status_Push,status(a0)
		rts
; ---------------------------------------------------------------------------

loc_14C1A:
		add.w	d1,y_vel(a0)

locret_14C1E:
		rts
; End of function Tails_InputAcceleration_Path


; =============== S U B R O U T I N E =======================================


sub_14C20:
		move.w	ground_vel(a0),d0
		beq.s	loc_14C28
		bpl.s	loc_14C5A

loc_14C28:
		bset	#Status_Facing,status(a0)
		bne.s	loc_14C3C
		bclr	#Status_Push,status(a0)
		move.b	#1,prev_anim(a0)

loc_14C3C:
		sub.w	d5,d0
		move.w	d6,d1
		neg.w	d1
		cmp.w	d1,d0
		bgt.s	loc_14C4E
		add.w	d5,d0
		cmp.w	d1,d0
		ble.s	loc_14C4E
		move.w	d1,d0

loc_14C4E:
		move.w	d0,ground_vel(a0)
		move.b	#0,anim(a0)
		rts
; ---------------------------------------------------------------------------

loc_14C5A:
		sub.w	d4,d0
		bcc.s	loc_14C62
		move.w	#-$80,d0

loc_14C62:
		move.w	d0,ground_vel(a0)
		move.b	angle(a0),d0
		addi.b	#$20,d0
		andi.b	#$C0,d0
		bne.s	locret_14CAA
		cmpi.w	#$400,d0
		blt.s	locret_14CAA
		tst.b	flip_type(a0)
		bmi.s	locret_14CAA
		move.w	#sfx_Skid,d0
		jsr	(Play_SFX).l
		move.b	#$D,anim(a0)
		bclr	#Status_Facing,status(a0)
		cmpi.b	#12,air_left(a0)
		blo.s	locret_14CAA
		move.b	#6,routine(a6)
		move.b	#$15,mapping_frame(a6)

locret_14CAA:
		rts
; End of function sub_14C20


; =============== S U B R O U T I N E =======================================


sub_14CAC:
		move.w	ground_vel(a0),d0
		bmi.s	loc_14CE0
		bclr	#Status_Facing,status(a0)
		beq.s	loc_14CC6
		bclr	#Status_Push,status(a0)
		move.b	#1,prev_anim(a0)

loc_14CC6:
		add.w	d5,d0
		cmp.w	d6,d0
		blt.s	loc_14CD4
		sub.w	d5,d0
		cmp.w	d6,d0
		bge.s	loc_14CD4
		move.w	d6,d0

loc_14CD4:
		move.w	d0,ground_vel(a0)
		move.b	#0,anim(a0)
		rts
; ---------------------------------------------------------------------------

loc_14CE0:
		add.w	d4,d0
		bcc.s	loc_14CE8
		move.w	#$80,d0

loc_14CE8:
		move.w	d0,ground_vel(a0)
		move.b	angle(a0),d0
		addi.b	#$20,d0
		andi.b	#$C0,d0
		bne.s	locret_14D30
		cmpi.w	#-$400,d0
		bgt.s	locret_14D30
		tst.b	flip_type(a0)
		bmi.s	locret_14D30
		move.w	#sfx_Skid,d0
		jsr	(Play_SFX).l
		move.b	#$D,anim(a0)
		bset	#Status_Facing,status(a0)
		cmpi.b	#12,air_left(a0)
		blo.s	locret_14D30
		move.b	#6,routine(a6)
		move.b	#$15,mapping_frame(a6)

locret_14D30:
		rts
; End of function sub_14CAC


; =============== S U B R O U T I N E =======================================


Tails_RollSpeed:
		move.w	Max_speed_P2-Max_speed_P2(a4),d6
		asl.w	#1,d6
		move.w	Acceleration_P2-Max_speed_P2(a4),d5
		asr.w	#1,d5
		tst.b	(Super_Tails_flag).w
		beq.s	loc_14D46
		move.w	#6,d5

loc_14D46:
		move.w	#$20,d4
		tst.b	spin_dash_flag(a0)
		bmi.w	loc_14DF0
		tst.b	status_secondary(a0)
		bmi.w	loc_14DF0
		tst.w	move_lock(a0)
		bne.s	loc_14D78
		btst	#button_left,(Ctrl_2_held_logical).w
		beq.s	loc_14D6C
		bsr.w	sub_14E32

loc_14D6C:
		btst	#button_right,(Ctrl_2_held_logical).w
		beq.s	loc_14D78
		bsr.w	sub_14E56

loc_14D78:
		move.w	ground_vel(a0),d0
		beq.s	loc_14D9A
		bmi.s	loc_14D8E
		sub.w	d5,d0
		bcc.s	loc_14D88
		move.w	#0,d0

loc_14D88:
		move.w	d0,ground_vel(a0)
		bra.s	loc_14D9A
; ---------------------------------------------------------------------------

loc_14D8E:
		add.w	d5,d0
		bcc.s	loc_14D96
		move.w	#0,d0

loc_14D96:
		move.w	d0,ground_vel(a0)

loc_14D9A:
		move.w	ground_vel(a0),d0
		bpl.s	loc_14DA2
		neg.w	d0

loc_14DA2:
		cmpi.w	#$80,d0
		bhs.s	loc_14DF0
		tst.b	spin_dash_flag(a0)
		bne.s	loc_14DDE
		bclr	#Status_Roll,status(a0)
		move.b	y_radius(a0),d0
		move.b	default_y_radius(a0),y_radius(a0)
		move.b	default_x_radius(a0),x_radius(a0)
		move.b	#5,anim(a0)
		sub.b	default_y_radius(a0),d0
		ext.w	d0
		tst.b	(Reverse_gravity_flag).w
		beq.s	loc_14DD8
		neg.w	d0

loc_14DD8:
		add.w	d0,y_pos(a0)
		bra.s	loc_14DF0
; ---------------------------------------------------------------------------

loc_14DDE:
		move.w	#$400,ground_vel(a0)
		btst	#Status_Facing,status(a0)
		beq.s	loc_14DF0
		neg.w	ground_vel(a0)

loc_14DF0:
		cmpi.w	#$60,(a5)
		beq.s	loc_14DFC
		bcc.s	loc_14DFA
		addq.w	#4,(a5)

loc_14DFA:
		subq.w	#2,(a5)

loc_14DFC:
		move.b	angle(a0),d0
		jsr	(GetSineCosine).l
		muls.w	ground_vel(a0),d0
		asr.l	#8,d0
		move.w	d0,y_vel(a0)
		muls.w	ground_vel(a0),d1
		asr.l	#8,d1
		cmpi.w	#$1000,d1
		ble.s	loc_14E20
		move.w	#$1000,d1

loc_14E20:
		cmpi.w	#-$1000,d1
		bge.s	loc_14E2A
		move.w	#-$1000,d1

loc_14E2A:
		move.w	d1,x_vel(a0)
		bra.w	loc_14B7A
; End of function Tails_RollSpeed


; =============== S U B R O U T I N E =======================================


sub_14E32:
		move.w	ground_vel(a0),d0
		beq.s	loc_14E3A
		bpl.s	loc_14E48

loc_14E3A:
		bset	#Status_Facing,status(a0)
		move.b	#2,anim(a0)
		rts
; ---------------------------------------------------------------------------

loc_14E48:
		sub.w	d4,d0
		bcc.s	loc_14E50
		move.w	#-$80,d0

loc_14E50:
		move.w	d0,ground_vel(a0)
		rts
; End of function sub_14E32


; =============== S U B R O U T I N E =======================================


sub_14E56:
		move.w	ground_vel(a0),d0
		bmi.s	loc_14E6A
		bclr	#Status_Facing,status(a0)
		move.b	#2,anim(a0)
		rts
; ---------------------------------------------------------------------------

loc_14E6A:
		add.w	d4,d0
		bcc.s	loc_14E72
		move.w	#$80,d0

loc_14E72:
		move.w	d0,ground_vel(a0)
		rts
; End of function sub_14E56


; =============== S U B R O U T I N E =======================================


Tails_InputAcceleration_Freespace:
		move.w	Max_speed_P2-Max_speed_P2(a4),d6
		move.w	Acceleration_P2-Max_speed_P2(a4),d5
		asl.w	#1,d5
		btst	#Status_RollJump,status(a0)
		bne.s	loc_14ECC
		move.w	x_vel(a0),d0
		btst	#button_left,(Ctrl_2_held_logical).w
		beq.s	loc_14EAC
		bset	#Status_Facing,status(a0)
		sub.w	d5,d0
		move.w	d6,d1
		neg.w	d1
		cmp.w	d1,d0
		bgt.s	loc_14EAC
		add.w	d5,d0
		cmp.w	d1,d0
		ble.s	loc_14EAC
		move.w	d1,d0

loc_14EAC:
		btst	#button_right,(Ctrl_2_held_logical).w
		beq.s	loc_14EC8
		bclr	#Status_Facing,status(a0)
		add.w	d5,d0
		cmp.w	d6,d0
		blt.s	loc_14EC8
		sub.w	d5,d0
		cmp.w	d6,d0
		bge.s	loc_14EC8
		move.w	d6,d0

loc_14EC8:
		move.w	d0,x_vel(a0)

loc_14ECC:
		cmpi.w	#$60,(a5)
		beq.s	loc_14ED8
		bcc.s	loc_14ED6
		addq.w	#4,(a5)

loc_14ED6:
		subq.w	#2,(a5)

loc_14ED8:
		cmpi.w	#-$400,y_vel(a0)
		blo.s	locret_14F06
		move.w	x_vel(a0),d0
		move.w	d0,d1
		asr.w	#5,d1
		beq.s	locret_14F06
		bmi.s	loc_14EFA
		sub.w	d1,d0
		bcc.s	loc_14EF4
		move.w	#0,d0

loc_14EF4:
		move.w	d0,x_vel(a0)
		rts
; ---------------------------------------------------------------------------

loc_14EFA:
		sub.w	d1,d0
		bcs.s	loc_14F02
		move.w	#0,d0

loc_14F02:
		move.w	d0,x_vel(a0)

locret_14F06:
		rts
; End of function Tails_InputAcceleration_Freespace


; =============== S U B R O U T I N E =======================================


Tails_Check_Screen_Boundaries:
		move.l	x_pos(a0),d1
		move.w	x_vel(a0),d0
		ext.l	d0
		asl.l	#8,d0
		add.l	d0,d1
		swap	d1
		move.w	(Camera_min_X_pos).w,d0
		addi.w	#$10,d0
		cmp.w	d1,d0
		bhi.s	loc_14F5C
		move.w	(Camera_max_X_pos).w,d0
		addi.w	#$128,d0
		cmp.w	d1,d0
		blo.s	loc_14F5C

loc_14F30:
		tst.b	(Disable_death_plane).w
		bne.s	locret_14F4A
		tst.b	(Reverse_gravity_flag).w
		bne.s	loc_14F4C
		move.w	(Camera_max_Y_pos).w,d0
		addi.w	#$E0,d0
		cmp.w	y_pos(a0),d0
		blt.s	loc_14F56

locret_14F4A:
		rts
; ---------------------------------------------------------------------------

loc_14F4C:
		move.w	(Camera_min_Y_pos).w,d0
		cmp.w	y_pos(a0),d0
		blt.s	locret_14F4A

loc_14F56:
		jmp	(Kill_Character).l
; ---------------------------------------------------------------------------

loc_14F5C:
		move.w	d0,x_pos(a0)
		move.w	#0,2+x_pos(a0)
		move.w	#0,x_vel(a0)
		move.w	#0,ground_vel(a0)
		bra.s	loc_14F30
; End of function Tails_Check_Screen_Boundaries


; =============== S U B R O U T I N E =======================================


Tails_Roll:
		tst.b	status_secondary(a0)
		bmi.s	locret_14FA8
		move.b	(Ctrl_2_held_logical).w,d0
		andi.b	#button_left_mask|button_right_mask,d0
		bne.s	locret_14FA8
		btst	#button_down,(Ctrl_2_held_logical).w
		beq.s	loc_14FAA
		move.w	ground_vel(a0),d0
		bpl.s	loc_14F94
		neg.w	d0

loc_14F94:
		cmpi.w	#$100,d0
		bhs.s	loc_14FBA
		btst	#Status_OnObj,status(a0)
		bne.s	locret_14FA8
		move.b	#8,anim(a0)

locret_14FA8:
		rts
; ---------------------------------------------------------------------------

loc_14FAA:
		cmpi.b	#8,anim(a0)
		bne.s	locret_14FA8
		move.b	#0,anim(a0)
		rts
; ---------------------------------------------------------------------------

loc_14FBA:
		btst	#Status_Roll,status(a0)
		beq.s	loc_14FC4
		rts
; ---------------------------------------------------------------------------

loc_14FC4:
		bset	#Status_Roll,status(a0)
		move.b	#$E,y_radius(a0)
		move.b	#7,x_radius(a0)
		move.b	#2,anim(a0)
		addq.w	#1,y_pos(a0)
		tst.b	(Reverse_gravity_flag).w
		beq.s	loc_14FEA
		subq.w	#2,y_pos(a0)

loc_14FEA:
		move.w	#sfx_Roll,d0
		jsr	(Play_SFX).l
		tst.w	ground_vel(a0)
		bne.s	locret_15000
		move.w	#$200,ground_vel(a0)

locret_15000:
		rts
; End of function Tails_Roll


; =============== S U B R O U T I N E =======================================


Tails_Jump:
		move.b	(Ctrl_2_pressed_logical).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0
		beq.w	locret_150D0
		moveq	#0,d0
		move.b	angle(a0),d0
		tst.b	(Reverse_gravity_flag).w
		beq.s	loc_15024
		addi.b	#$40,d0
		neg.b	d0
		subi.b	#$40,d0

loc_15024:
		addi.b	#$80,d0
		movem.l	a4-a6,-(sp)
		bsr.w	CalcRoomOverHead
		movem.l	(sp)+,a4-a6
		cmpi.w	#6,d1
		blt.w	locret_150D0
		move.w	#$680,d2
		btst	#Status_Underwater,status(a0)
		beq.s	loc_1504C
		move.w	#$380,d2

loc_1504C:
		moveq	#0,d0
		move.b	angle(a0),d0
		subi.b	#$40,d0
		jsr	(GetSineCosine).l
		muls.w	d2,d1
		asr.l	#8,d1
		add.w	d1,x_vel(a0)
		muls.w	d2,d0
		asr.l	#8,d0
		add.w	d0,y_vel(a0)
		bset	#Status_InAir,status(a0)
		bclr	#Status_Push,status(a0)
		addq.l	#4,sp
		move.b	#1,jumping(a0)
		clr.b	stick_to_convex(a0)
		move.w	#sfx_Jump,d0
		jsr	(Play_SFX).l
		move.b	default_y_radius(a0),y_radius(a0)
		move.b	default_x_radius(a0),x_radius(a0)
		btst	#Status_Roll,status(a0)
		bne.s	loc_150D2
		move.b	#$E,y_radius(a0)
		move.b	#7,x_radius(a0)
		move.b	#2,anim(a0)
		bset	#Status_Roll,status(a0)
		move.b	y_radius(a0),d0
		sub.b	default_y_radius(a0),d0
		ext.w	d0
		tst.b	(Reverse_gravity_flag).w
		beq.s	loc_150CC
		neg.w	d0

loc_150CC:
		sub.w	d0,y_pos(a0)

locret_150D0:
		rts
; ---------------------------------------------------------------------------

loc_150D2:
		bset	#Status_RollJump,status(a0)
		rts
; End of function Tails_Jump


; =============== S U B R O U T I N E =======================================


Tails_JumpHeight:
		tst.b	jumping(a0)
		beq.s	loc_15106
		move.w	#-$400,d1
		btst	#Status_Underwater,status(a0)
		beq.s	loc_150F0
		move.w	#-$200,d1

loc_150F0:
		cmp.w	y_vel(a0),d1
		ble.s	Tails_Test_For_Flight
		move.b	(Ctrl_2_held_logical).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0
		bne.s	locret_15104
		move.w	d1,y_vel(a0)

locret_15104:
		rts
; ---------------------------------------------------------------------------

loc_15106:
		tst.b	spin_dash_flag(a0)
		bne.s	locret_1511A
		cmpi.w	#-$FC0,y_vel(a0)
		bge.s	locret_1511A
		move.w	#-$FC0,y_vel(a0)

locret_1511A:
		rts
; ---------------------------------------------------------------------------

Tails_Test_For_Flight:
		tst.b	double_jump_flag(a0)
		bne.w	locret_151A2
		move.b	(Ctrl_2_pressed_logical).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0
		beq.w	locret_151A2
		cmpi.w	#2,(Player_mode).w
		bne.s	loc_15156
		tst.b	(Super_Tails_flag).w
		bne.s	loc_1515C
		cmpi.b	#7,(Super_emerald_count).w
		blo.s	loc_1515C
		cmpi.w	#50,(Ring_count).w
		blo.s	loc_1515C
		tst.b	(Update_HUD_timer).w
		bne.s	Tails_Transform
		bra.s	loc_1515C
; ---------------------------------------------------------------------------

loc_15156:
		tst.w	(Tails_CPU_idle_timer).w
		beq.s	locret_151A2

loc_1515C:
		btst	#Status_Roll,status(a0)
		beq.s	loc_1518C
		bclr	#Status_Roll,status(a0)
		move.b	y_radius(a0),d1
		move.b	default_y_radius(a0),y_radius(a0)
		move.b	default_x_radius(a0),x_radius(a0)
		sub.b	default_y_radius(a0),d1
		ext.w	d1
		tst.b	(Reverse_gravity_flag).w
		beq.s	loc_15188
		neg.w	d0

loc_15188:
		add.w	d1,y_pos(a0)

loc_1518C:
		bclr	#Status_RollJump,status(a0)
		move.b	#1,double_jump_flag(a0)
		move.b	#(8*60)/2,double_jump_property(a0)
		bsr.w	Tails_Set_Flying_Animation

locret_151A2:
		rts
; ---------------------------------------------------------------------------

Tails_Transform:
		move.b	#1,(Super_palette_status).w	; set Super/Hyper palette status to 'fading'
		move.b	#$F,(Palette_timer).w
		move.b	#1,(Super_Tails_flag).w			; set flag to Super Tails
		move.w	#60,(Super_frame_count).w
		move.b	#$81,object_control(a0)
		move.b	#$29,anim(a0)				; enter 'transformation' animation
		move.l	#Obj_SuperTailsBirds,(Invincibility_stars).w	; load Super Flickies object
		move.w	#$800,Max_speed_P2-Max_speed_P2(a4)
		move.w	#$18,Acceleration_P2-Max_speed_P2(a4)
		move.w	#$C0,Deceleration_P2-Max_speed_P2(a4)
		move.b	#0,invincibility_timer(a0)
		bset	#Status_Invincible,status_secondary(a0)
		moveq	#signextendB(sfx_SuperTransform),d0
		jsr	(Play_SFX).l
		moveq	#signextendB(mus_Invincibility),d0		; play invincibility theme
		jmp	(Play_Music).l
; End of function Tails_JumpHeight


; =============== S U B R O U T I N E =======================================


Tails_Spindash:
		tst.b	spin_dash_flag(a0)
		bne.s	loc_1527C
		cmpi.b	#8,anim(a0)
		bne.s	locret_1527A
		move.b	(Ctrl_2_pressed_logical).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0
		beq.w	locret_1527A
		move.b	#9,anim(a0)
		move.w	#signextendB(sfx_Spindash),d0
		jsr	(Play_SFX).l
		addq.l	#4,sp
		move.b	#1,spin_dash_flag(a0)
		move.w	#0,spin_dash_counter(a0)
		cmpi.b	#12,air_left(a0)
		blo.s	loc_15242
		move.b	#2,anim(a6)

loc_15242:
		bsr.w	Tails_Check_Screen_Boundaries
		bsr.w	Call_Player_AnglePos
		tst.b	(Background_collision_flag).w
		beq.s	locret_1527A
		bsr.w	sub_F846
		tst.w	d1
		bmi.w	Kill_Character
		movem.l	a4-a6,-(sp)
		bsr.w	CheckLeftWallDist
		tst.w	d1
		bpl.s	loc_1526A
		sub.w	d1,x_pos(a0)

loc_1526A:
		bsr.w	CheckRightWallDist
		tst.w	d1
		bpl.s	loc_15276
		add.w	d1,x_pos(a0)

loc_15276:
		movem.l	(sp)+,a4-a6

locret_1527A:
		rts
; ---------------------------------------------------------------------------

loc_1527C:
		move.b	(Ctrl_2_held_logical).w,d0
		btst	#button_down,d0
		bne.w	loc_15332
		move.b	#$E,y_radius(a0)
		move.b	#7,x_radius(a0)
		move.b	#2,anim(a0)
		addq.w	#1,y_pos(a0)
		tst.b	(Reverse_gravity_flag).w
		beq.s	loc_152A8
		subq.w	#2,y_pos(a0)

loc_152A8:
		move.b	#0,spin_dash_flag(a0)
		moveq	#0,d0
		move.b	spin_dash_counter(a0),d0
		add.w	d0,d0
		move.w	word_1530E(pc,d0.w),ground_vel(a0)
		tst.b	(Super_Tails_flag).w
		beq.s	loc_152C8
		move.w	word_15320(pc,d0.w),ground_vel(a0)

loc_152C8:
		move.w	ground_vel(a0),d0
		subi.w	#$800,d0
		add.w	d0,d0
		andi.w	#$1F00,d0
		neg.w	d0
		addi.w	#$2000,d0
		lea	(H_scroll_frame_offset).w,a1
		cmpa.w	#Player_1,a0
		beq.s	loc_152EA
		lea	(H_scroll_frame_offset_P2).w,a1

loc_152EA:
		move.w	d0,(a1)
		btst	#Status_Facing,status(a0)
		beq.s	loc_152F8
		neg.w	ground_vel(a0)

loc_152F8:
		bset	#Status_Roll,status(a0)
		move.b	#0,anim(a6)
		moveq	#signextendB(sfx_Dash),d0
		jsr	(Play_SFX).l
		bra.s	loc_1537A
; ---------------------------------------------------------------------------
word_1530E:
		dc.w   $800
		dc.w   $880
		dc.w   $900
		dc.w   $980
		dc.w   $A00
		dc.w   $A80
		dc.w   $B00
		dc.w   $B80
		dc.w   $C00
word_15320:
		dc.w   $A00
		dc.w   $A80
		dc.w   $B00
		dc.w   $B80
		dc.w   $C00
		dc.w   $C80
		dc.w   $D00
		dc.w   $D80
		dc.w   $E00
; ---------------------------------------------------------------------------

loc_15332:
		tst.w	spin_dash_counter(a0)
		beq.s	loc_1534A
		move.w	spin_dash_counter(a0),d0
		lsr.w	#5,d0
		sub.w	d0,spin_dash_counter(a0)
		bcc.s	loc_1534A
		move.w	#0,spin_dash_counter(a0)

loc_1534A:
		move.b	(Ctrl_2_pressed_logical).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0
		beq.w	loc_1537A
		move.w	#9<<8,anim(a0)	; and prev_anim
		move.w	#signextendB(sfx_Spindash),d0
		jsr	(Play_SFX).l
		addi.w	#$200,spin_dash_counter(a0)
		cmpi.w	#$800,spin_dash_counter(a0)
		blo.s	loc_1537A
		move.w	#$800,spin_dash_counter(a0)

loc_1537A:
		addq.l	#4,sp
		cmpi.w	#$60,(a5)
		beq.s	loc_15388
		bcc.s	loc_15386
		addq.w	#4,(a5)

loc_15386:
		subq.w	#2,(a5)

loc_15388:
		bsr.w	Tails_Check_Screen_Boundaries
		bsr.w	Call_Player_AnglePos
		tst.b	(Background_collision_flag).w
		beq.s	locret_153C0
		bsr.w	sub_F846
		tst.w	d1
		bmi.w	Kill_Character
		movem.l	a4-a6,-(sp)
		bsr.w	CheckLeftWallDist
		tst.w	d1
		bpl.s	loc_153B0
		sub.w	d1,x_pos(a0)

loc_153B0:
		bsr.w	CheckRightWallDist
		tst.w	d1
		bpl.s	loc_153BC
		add.w	d1,x_pos(a0)

loc_153BC:
		movem.l	(sp)+,a4-a6

locret_153C0:
		rts
; End of function Tails_Spindash


; =============== S U B R O U T I N E =======================================


Tails_DoLevelCollision:
		move.l	(Primary_collision_addr).w,(Collision_addr).w
		cmpi.b	#$C,top_solid_bit(a0)
		beq.s	loc_153D6
		move.l	(Secondary_collision_addr).w,(Collision_addr).w

loc_153D6:
		move.b	lrb_solid_bit(a0),d5
		move.w	x_vel(a0),d1
		move.w	y_vel(a0),d2
		jsr	(GetArcTan).l
		subi.b	#$20,d0
		andi.b	#$C0,d0
		cmpi.b	#$40,d0
		beq.w	loc_154AC
		cmpi.b	#$80,d0
		beq.w	loc_15538
		cmpi.b	#$C0,d0
		beq.w	loc_1559C
		bsr.w	CheckLeftWallDist
		tst.w	d1
		bpl.s	loc_1541A
		sub.w	d1,x_pos(a0)
		move.w	#0,x_vel(a0)

loc_1541A:
		bsr.w	CheckRightWallDist
		tst.w	d1
		bpl.s	loc_1542C
		add.w	d1,x_pos(a0)
		move.w	#0,x_vel(a0)

loc_1542C:
		bsr.w	sub_11FD6
		tst.w	d1
		bpl.s	locret_154AA
		move.b	y_vel(a0),d2
		addq.b	#8,d2
		neg.b	d2
		cmp.b	d2,d1
		bge.s	loc_15444
		cmp.b	d2,d0
		blt.s	locret_154AA

loc_15444:
		move.b	d3,angle(a0)
		tst.b	(Reverse_gravity_flag).w
		beq.s	loc_15450
		neg.w	d1

loc_15450:
		add.w	d1,y_pos(a0)
		move.b	d3,d0
		addi.b	#$20,d0
		andi.b	#$40,d0
		bne.s	loc_15484
		move.b	d3,d0
		addi.b	#$10,d0
		andi.b	#$20,d0
		beq.s	loc_15472
		asr	y_vel(a0)
		bra.s	loc_15498
; ---------------------------------------------------------------------------

loc_15472:
		move.w	#0,y_vel(a0)
		move.w	x_vel(a0),ground_vel(a0)
		bsr.w	Tails_TouchFloor_Check_Spindash
		rts
; ---------------------------------------------------------------------------

loc_15484:
		move.w	#0,x_vel(a0)
		cmpi.w	#$FC0,y_vel(a0)
		ble.s	loc_15498
		move.w	#$FC0,y_vel(a0)

loc_15498:
		bsr.w	Tails_TouchFloor_Check_Spindash
		move.w	y_vel(a0),ground_vel(a0)
		tst.b	d3
		bpl.s	locret_154AA
		neg.w	ground_vel(a0)

locret_154AA:
		rts
; ---------------------------------------------------------------------------

loc_154AC:
		bsr.w	CheckLeftWallDist
		tst.w	d1
		bpl.s	loc_154C4
		sub.w	d1,x_pos(a0)
		move.w	#0,x_vel(a0)
		move.w	y_vel(a0),ground_vel(a0)

loc_154C4:
		bsr.w	sub_11FEE
		tst.w	d1
		bpl.s	loc_15502
		neg.w	d1
		cmpi.w	#$14,d1
		bhs.s	loc_154EE
		tst.b	(Reverse_gravity_flag).w
		beq.s	loc_154DC
		neg.w	d1

loc_154DC:
		add.w	d1,y_pos(a0)
		tst.w	y_vel(a0)
		bpl.s	locret_154EC
		move.w	#0,y_vel(a0)

locret_154EC:
		rts
; ---------------------------------------------------------------------------

loc_154EE:
		bsr.w	CheckRightWallDist
		tst.w	d1
		bpl.s	locret_15500
		add.w	d1,x_pos(a0)
		move.w	#0,x_vel(a0)

locret_15500:
		rts
; ---------------------------------------------------------------------------

loc_15502:
		tst.b	(WindTunnel_flag_P2).w
		bne.s	loc_1550E
		tst.w	y_vel(a0)
		bmi.s	locret_15536

loc_1550E:
		bsr.w	sub_11FD6
		tst.w	d1
		bpl.s	locret_15536
		tst.b	(Reverse_gravity_flag).w
		beq.s	loc_1551E
		neg.w	d1

loc_1551E:
		add.w	d1,y_pos(a0)
		move.b	d3,angle(a0)
		move.w	#0,y_vel(a0)
		move.w	x_vel(a0),ground_vel(a0)
		bsr.w	Tails_TouchFloor_Check_Spindash

locret_15536:
		rts
; ---------------------------------------------------------------------------

loc_15538:
		bsr.w	CheckLeftWallDist
		tst.w	d1
		bpl.s	loc_1554A
		sub.w	d1,x_pos(a0)
		move.w	#0,x_vel(a0)

loc_1554A:
		bsr.w	CheckRightWallDist
		tst.w	d1
		bpl.s	loc_1555C
		add.w	d1,x_pos(a0)
		move.w	#0,x_vel(a0)

loc_1555C:
		bsr.w	sub_11FEE
		tst.w	d1
		bpl.s	locret_1559A
		tst.b	(Reverse_gravity_flag).w
		beq.s	loc_1556C
		neg.w	d1

loc_1556C:
		sub.w	d1,y_pos(a0)
		move.b	d3,d0
		addi.b	#$20,d0
		andi.b	#$40,d0
		bne.s	loc_15584
		move.w	#0,y_vel(a0)
		rts
; ---------------------------------------------------------------------------

loc_15584:
		move.b	d3,angle(a0)
		bsr.w	Tails_TouchFloor_Check_Spindash
		move.w	y_vel(a0),ground_vel(a0)
		tst.b	d3
		bpl.s	locret_1559A
		neg.w	ground_vel(a0)

locret_1559A:
		rts
; ---------------------------------------------------------------------------

loc_1559C:
		bsr.w	CheckRightWallDist
		tst.w	d1
		bpl.s	loc_155B4
		add.w	d1,x_pos(a0)
		move.w	#0,x_vel(a0)
		move.w	y_vel(a0),ground_vel(a0)

loc_155B4:
		bsr.w	sub_11FEE
		tst.w	d1
		bpl.s	loc_155D6
		tst.b	(Reverse_gravity_flag).w
		beq.s	loc_155C4
		neg.w	d1

loc_155C4:
		sub.w	d1,y_pos(a0)
		tst.w	y_vel(a0)
		bpl.s	locret_155D4
		move.w	#0,y_vel(a0)

locret_155D4:
		rts
; ---------------------------------------------------------------------------

loc_155D6:
		tst.b	(WindTunnel_flag_P2).w
		bne.s	loc_155E2
		tst.w	y_vel(a0)
		bmi.s	locret_1560A

loc_155E2:
		bsr.w	sub_11FD6
		tst.w	d1
		bpl.s	locret_1560A
		tst.b	(Reverse_gravity_flag).w
		beq.s	loc_155F2
		neg.w	d1

loc_155F2:
		add.w	d1,y_pos(a0)
		move.b	d3,angle(a0)
		move.w	#0,y_vel(a0)
		move.w	x_vel(a0),ground_vel(a0)
		bsr.w	Tails_TouchFloor_Check_Spindash

locret_1560A:
		rts
; End of function Tails_DoLevelCollision


; =============== S U B R O U T I N E =======================================


Tails_TouchFloor_Check_Spindash:
		tst.b	spin_dash_flag(a0)
		bne.s	loc_1565E
		move.b	#0,anim(a0)
; End of function Tails_TouchFloor_Check_Spindash


; =============== S U B R O U T I N E =======================================


Tails_TouchFloor:
		move.b	y_radius(a0),d0
		move.b	default_y_radius(a0),y_radius(a0)
		move.b	default_x_radius(a0),x_radius(a0)
		btst	#Status_Roll,status(a0)
		beq.s	loc_1565E
		bclr	#Status_Roll,status(a0)
		move.b	#0,anim(a0)
		sub.b	default_y_radius(a0),d0
		ext.w	d0
		tst.b	(Reverse_gravity_flag).w
		beq.s	loc_1564A
		neg.w	d0

loc_1564A:
		move.w	d0,-(sp)
		move.b	angle(a0),d0
		addi.b	#$40,d0
		bpl.s	loc_15658
		neg.w	(sp)

loc_15658:
		move.w	(sp)+,d0
		add.w	d0,y_pos(a0)

loc_1565E:
		bclr	#Status_InAir,status(a0)
		bclr	#Status_Push,status(a0)
		bclr	#Status_RollJump,status(a0)
		move.b	#0,jumping(a0)
		move.w	#0,(Chain_bonus_counter).w
		move.b	#0,flip_angle(a0)
		move.b	#0,flip_type(a0)
		move.b	#0,flips_remaining(a0)
		move.b	#0,scroll_delay_counter(a0)
		move.b	#0,double_jump_flag(a0)
		rts
; End of function Tails_TouchFloor

; ---------------------------------------------------------------------------

loc_1569C:
		cmpi.w	#2,(Player_mode).w
		bne.s	loc_156BE
		tst.w	(Debug_mode_flag).w
		beq.s	loc_156BE
		btst	#button_B,(Ctrl_1_pressed).w
		beq.s	loc_156BE
		move.w	#1,(Debug_placement_mode).w
		clr.b	(Ctrl_1_locked).w
		rts
; ---------------------------------------------------------------------------

loc_156BE:
		tst.b	(Flying_carrying_Sonic_flag).w
		beq.s	loc_156D6
		lea	(Player_1).w,a1
		clr.b	object_control(a1)
		bset	#Status_InAir,status(a1)
		clr.w	(Flying_carrying_Sonic_flag).w

loc_156D6:
		jsr	(MoveSprite_TestGravity2).l
		addi.w	#$30,y_vel(a0)
		btst	#Status_Underwater,status(a0)
		beq.s	loc_156F0
		subi.w	#$20,y_vel(a0)

loc_156F0:
		cmpi.w	#-$100,(Camera_min_Y_pos).w
		bne.s	loc_15700
		move.w	(Screen_Y_wrap_value).w,d0
		and.w	d0,y_pos(a0)

loc_15700:
		bsr.w	sub_15716
		bsr.w	Tails_Check_Screen_Boundaries
		bsr.w	Sonic_RecordPos
		bsr.w	sub_15842
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_15716:
		tst.b	(Disable_death_plane).w
		bne.s	loc_15742
		tst.b	(Reverse_gravity_flag).w
		bne.s	loc_15734
		move.w	(Camera_max_Y_pos).w,d0
		addi.w	#$E0,d0
		cmp.w	y_pos(a0),d0
		blt.w	loc_15788
		bra.s	loc_15742
; ---------------------------------------------------------------------------

loc_15734:
		move.w	(Camera_min_Y_pos).w,d0
		cmp.w	y_pos(a0),d0
		blt.s	loc_15742
		bra.w	loc_15788
; ---------------------------------------------------------------------------

loc_15742:
		movem.l	a4-a6,-(sp)
		bsr.w	Tails_DoLevelCollision
		movem.l	(sp)+,a4-a6
		btst	#Status_InAir,status(a0)
		bne.s	locret_15786
		moveq	#0,d0
		move.w	d0,y_vel(a0)
		move.w	d0,x_vel(a0)
		move.w	d0,ground_vel(a0)
		move.b	d0,object_control(a0)
		move.b	#0,anim(a0)
		move.w	#$100,priority(a0)
		move.b	#2,routine(a0)
		move.b	#2*60,invulnerability_timer(a0)
		move.b	#0,spin_dash_flag(a0)

locret_15786:
		rts
; ---------------------------------------------------------------------------

loc_15788:
		jmp	(Kill_Character).l
; End of function sub_15716

; ---------------------------------------------------------------------------

loc_1578E:
		cmpi.w	#2,(Player_mode).w
		bne.s	loc_157B0
		tst.w	(Debug_mode_flag).w
		beq.s	loc_157B0
		btst	#button_B,(Ctrl_1_pressed).w
		beq.s	loc_157B0
		move.w	#1,(Debug_placement_mode).w
		clr.b	(Ctrl_1_locked).w
		rts
; ---------------------------------------------------------------------------

loc_157B0:
		tst.b	(Flying_carrying_Sonic_flag).w
		beq.s	loc_157C8
		lea	(Player_1).w,a1
		clr.b	object_control(a1)
		bset	#Status_InAir,status(a1)
		clr.w	(Flying_carrying_Sonic_flag).w

loc_157C8:
		bsr.w	sub_123C2
		jsr	(MoveSprite_TestGravity).l
		bsr.w	Sonic_RecordPos
		bsr.w	sub_15842
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_157E0:
		tst.w	$3E(a0)
		beq.s	locret_157F2
		subq.w	#1,$3E(a0)
		bne.s	locret_157F2
		move.w	#1,(Restart_level_flag).w

locret_157F2:
		rts
; ---------------------------------------------------------------------------

loc_157F4:
		tst.w	(H_scroll_amount_P2).w
		bne.s	loc_15806
		tst.w	(V_scroll_amount_P2).w
		bne.s	loc_15806
		move.b	#2,routine(a0)

loc_15806:
		bsr.w	sub_15842
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_15810:
		tst.b	(Flying_carrying_Sonic_flag).w
		beq.s	loc_15828
		lea	(Player_1).w,a1
		clr.b	object_control(a1)
		bset	#Status_InAir,status(a1)
		clr.w	(Flying_carrying_Sonic_flag).w

loc_15828:
		jsr	(MoveSprite_TestGravity2).l
		addi.w	#$10,y_vel(a0)
		bsr.w	Sonic_RecordPos
		bsr.w	sub_15842
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_15842:
		tst.w	(Competition_mode).w
		bne.s	loc_1585A
		bsr.s	Animate_Tails
		tst.b	(Reverse_gravity_flag).w
		beq.s	loc_15856
		eori.b	#2,render_flags(a0)

loc_15856:
		bra.w	Tails_Load_PLC
; ---------------------------------------------------------------------------

loc_1585A:
		bsr.w	Animate_Tails2P
		bra.w	Tails2P_Load_PLC
; End of function sub_15842


; =============== S U B R O U T I N E =======================================


Animate_Tails:
		lea	(AniTails).l,a1

Animate_Tails_Part2:
		moveq	#0,d0
		move.b	anim(a0),d0
		cmp.b	prev_anim(a0),d0
		beq.s	loc_1588A
		move.b	d0,prev_anim(a0)
		move.b	#0,anim_frame(a0)
		move.b	#0,anim_frame_timer(a0)
		bclr	#Status_Push,status(a0)

loc_1588A:
		add.w	d0,d0
		adda.w	(a1,d0.w),a1
		move.b	(a1),d0
		bmi.s	loc_158FA
		move.b	status(a0),d1
		andi.b	#1,d1
		andi.b	#$FC,render_flags(a0)
		or.b	d1,render_flags(a0)
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	locret_158C8
		move.b	d0,anim_frame_timer(a0)
; End of function Animate_Tails


; =============== S U B R O U T I N E =======================================


sub_158B0:
		moveq	#0,d1
		move.b	anim_frame(a0),d1
		move.b	1(a1,d1.w),d0
		cmpi.b	#$FC,d0
		bhs.s	loc_158CA

loc_158C0:
		move.b	d0,mapping_frame(a0)
		addq.b	#1,anim_frame(a0)

locret_158C8:
		rts
; ---------------------------------------------------------------------------

loc_158CA:
		addq.b	#1,d0
		bne.s	loc_158DA
		move.b	#0,anim_frame(a0)
		move.b	1(a1),d0
		bra.s	loc_158C0
; ---------------------------------------------------------------------------

loc_158DA:
		addq.b	#1,d0
		bne.s	loc_158EE
		move.b	2(a1,d1.w),d0
		sub.b	d0,anim_frame(a0)
		sub.b	d0,d1
		move.b	1(a1,d1.w),d0
		bra.s	loc_158C0
; ---------------------------------------------------------------------------

loc_158EE:
		addq.b	#1,d0
		bne.s	locret_158F8
		move.b	2(a1,d1.w),anim(a0)

locret_158F8:
		rts
; End of function sub_158B0

; ---------------------------------------------------------------------------

loc_158FA:
		addq.b	#1,d0
		bne.w	loc_159C8
		moveq	#0,d0
		tst.b	flip_type(a0)
		bmi.w	Anim_Tumble
		move.b	flip_angle(a0),d0
		bne.w	Anim_Tumble
		moveq	#0,d1
		move.b	angle(a0),d0
		bmi.s	loc_1591E
		beq.s	loc_1591E
		subq.b	#1,d0

loc_1591E:
		move.b	status(a0),d2
		andi.b	#1,d2
		bne.s	loc_1592A
		not.b	d0

loc_1592A:
		addi.b	#$10,d0
		bpl.s	loc_15932
		moveq	#3,d1

loc_15932:
		andi.b	#$FC,render_flags(a0)
		eor.b	d1,d2
		or.b	d2,render_flags(a0)
		btst	#Status_Push,status(a0)
		bne.w	loc_15A14
		lsr.b	#4,d0
		andi.b	#6,d0
		move.w	ground_vel(a0),d2
		bpl.s	loc_15956
		neg.w	d2

loc_15956:
		tst.b	status_secondary(a0)
		bpl.w	loc_15960
		add.w	d2,d2

loc_15960:
		move.b	d0,d3
		add.b	d3,d3
		add.b	d3,d3
		lea	(AniTails00).l,a1
		cmpi.w	#$600,d2
		blo.s	loc_1598A
		lea	(AniTails01).l,a1
		move.b	d0,d3
		add.b	d3,d3
		cmpi.w	#$700,d2
		blo.s	loc_1598A
		lea	(AniTails1F).l,a1
		move.b	d0,d3

loc_1598A:
		moveq	#0,d1
		move.b	anim_frame(a0),d1
		move.b	1(a1,d1.w),d0
		cmpi.b	#-1,d0
		bne.s	loc_159A4
		move.b	#0,anim_frame(a0)
		move.b	1(a1),d0

loc_159A4:
		move.b	d0,mapping_frame(a0)
		add.b	d3,mapping_frame(a0)
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	locret_159C6
		neg.w	d2
		addi.w	#$800,d2
		bpl.s	loc_159BC
		moveq	#0,d2

loc_159BC:
		lsr.w	#8,d2
		move.b	d2,anim_frame_timer(a0)
		addq.b	#1,anim_frame(a0)

locret_159C6:
		rts
; ---------------------------------------------------------------------------

loc_159C8:
		addq.b	#1,d0
		bne.s	loc_15A3C
		move.b	status(a0),d1
		andi.b	#1,d1
		andi.b	#$FC,render_flags(a0)
		or.b	d1,render_flags(a0)
		subq.b	#1,anim_frame_timer(a0)
		bpl.w	locret_158C8
		move.w	ground_vel(a0),d2
		bpl.s	loc_159EE
		neg.w	d2

loc_159EE:
		lea	(AniTails03).l,a1
		cmpi.w	#$600,d2
		bhs.s	loc_15A00
		lea	(AniTails02).l,a1

loc_15A00:
		neg.w	d2
		addi.w	#$400,d2
		bpl.s	loc_15A0A
		moveq	#0,d2

loc_15A0A:
		lsr.w	#8,d2
		move.b	d2,anim_frame_timer(a0)
		bra.w	sub_158B0
; ---------------------------------------------------------------------------

loc_15A14:
		subq.b	#1,anim_frame_timer(a0)
		bpl.w	locret_158C8
		move.w	ground_vel(a0),d2
		bmi.s	loc_15A24
		neg.w	d2

loc_15A24:
		addi.w	#$800,d2
		bpl.s	loc_15A2C
		moveq	#0,d2

loc_15A2C:
		lsr.w	#6,d2
		move.b	d2,anim_frame_timer(a0)
		lea	(AniTails04).l,a1
		bra.w	sub_158B0
; ---------------------------------------------------------------------------

loc_15A3C:
		subq.b	#1,anim_frame_timer(a0)
		bpl.w	locret_158C8
		move.w	x_vel(a2),d1
		move.w	y_vel(a2),d2
		jsr	(GetArcTan).l
		cmpi.b	#$15,(Current_zone).w
		bne.s	loc_15A5E
		add.b	(Stat_table).w,d0

loc_15A5E:
		moveq	#0,d1
		move.b	status(a0),d2
		andi.b	#1,d2
		bne.s	loc_15A6E
		not.b	d0
		bra.s	loc_15A72
; ---------------------------------------------------------------------------

loc_15A6E:
		addi.b	#$80,d0

loc_15A72:
		addi.b	#$10,d0
		bpl.s	loc_15A7A
		moveq	#3,d1

loc_15A7A:
		andi.b	#$FC,render_flags(a0)
		eor.b	d1,d2
		or.b	d2,render_flags(a0)
		tst.b	(Reverse_gravity_flag).w
		beq.s	loc_15A92
		eori.b	#2,render_flags(a0)

loc_15A92:
		lsr.b	#3,d0
		andi.b	#$C,d0
		move.b	d0,d3
		lea	(AniTails_Tail03).l,a1
		move.b	#3,anim_frame_timer(a0)
		bsr.w	sub_158B0
		add.b	d3,mapping_frame(a0)
		rts
; ---------------------------------------------------------------------------
AniTails:
		include "General/Sprites/Tails/Anim - Tails.asm"
; ---------------------------------------------------------------------------

Tails_Tail_Load_PLC:
		moveq	#0,d0
		move.b	mapping_frame(a0),d0
		cmp.b	(Player_prev_frame_P2_tail).w,d0
		beq.w	locret_15CCE
		move.b	d0,(Player_prev_frame_P2_tail).w
		lea	(PLC_Tails_Tail).l,a2
		add.w	d0,d0
		adda.w	(a2,d0.w),a2
		move.w	(a2)+,d5
		subq.w	#1,d5
		bmi.s	locret_15CCE
		move.w	#tiles_to_bytes(ArtTile_Player_2_Tail),d4
		move.l	#ArtUnc_Tails_Tail,d6
		bra.s	loc_15CA6

; =============== S U B R O U T I N E =======================================


Tails_Load_PLC:
		moveq	#0,d0
		move.b	mapping_frame(a0),d0

Tails_Load_PLC2:
		cmp.b	(Player_prev_frame_P2).w,d0
		beq.s	locret_15CCE
		move.b	d0,(Player_prev_frame_P2).w
		lea	(PLC_Tails).l,a2
		add.w	d0,d0
		adda.w	(a2,d0.w),a2
		move.w	(a2)+,d5
		subq.w	#1,d5
		bmi.s	locret_15CCE
		move.w	#tiles_to_bytes(ArtTile_Player_2),d4
		move.l	#ArtUnc_Tails,d6
		cmpi.w	#2*$D1,d0
		blo.s	loc_15CA6
		move.l	#ArtUnc_Tails_Extra,d6

loc_15CA6:
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
		dbf	d5,loc_15CA6

locret_15CCE:
		rts
; End of function Tails_Load_PLC


; =============== S U B R O U T I N E =======================================


Animate_Tails2P:
		lea	(AniTails2P).l,a1

Animate_Tails_Tail2P:
		moveq	#0,d0
		move.b	anim(a0),d0
		cmp.b	prev_anim(a0),d0
		beq.s	loc_15CF8
		move.b	d0,prev_anim(a0)
		move.b	#0,anim_frame(a0)
		move.b	#0,anim_frame_timer(a0)
		bclr	#Status_Push,status(a0)

loc_15CF8:
		add.w	d0,d0
		adda.w	(a1,d0.w),a1
		move.b	(a1),d0
		bmi.s	loc_15D68
		move.b	status(a0),d1
		andi.b	#1,d1
		andi.b	#$FC,render_flags(a0)
		or.b	d1,render_flags(a0)
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	locret_15D36
		move.b	d0,anim_frame_timer(a0)
; End of function Animate_Tails2P


; =============== S U B R O U T I N E =======================================


sub_15D1E:
		moveq	#0,d1
		move.b	anim_frame(a0),d1
		move.b	1(a1,d1.w),d0
		cmpi.b	#$F0,d0
		bhs.s	loc_15D38

loc_15D2E:
		move.b	d0,mapping_frame(a0)
		addq.b	#1,anim_frame(a0)

locret_15D36:
		rts
; ---------------------------------------------------------------------------

loc_15D38:
		addq.b	#1,d0
		bne.s	loc_15D48
		move.b	#0,anim_frame(a0)
		move.b	1(a1),d0
		bra.s	loc_15D2E
; ---------------------------------------------------------------------------

loc_15D48:
		addq.b	#1,d0
		bne.s	loc_15D5C
		move.b	2(a1,d1.w),d0
		sub.b	d0,anim_frame(a0)
		sub.b	d0,d1
		move.b	1(a1,d1.w),d0
		bra.s	loc_15D2E
; ---------------------------------------------------------------------------

loc_15D5C:
		addq.b	#1,d0
		bne.s	locret_15D66
		move.b	2(a1,d1.w),anim(a0)

locret_15D66:
		rts
; End of function sub_15D1E

; ---------------------------------------------------------------------------

loc_15D68:
		addq.b	#1,d0
		bne.w	loc_15E82
		moveq	#0,d0
		move.b	flip_angle(a0),d0
		bne.w	loc_15E1C
		moveq	#0,d1
		move.b	angle(a0),d0
		bmi.s	loc_15D84
		beq.s	loc_15D84
		subq.b	#1,d0

loc_15D84:
		move.b	status(a0),d2
		andi.b	#1,d2
		bne.s	loc_15D90
		not.b	d0

loc_15D90:
		addi.b	#$10,d0
		bpl.s	loc_15D98
		moveq	#3,d1

loc_15D98:
		andi.b	#$FC,render_flags(a0)
		eor.b	d1,d2
		or.b	d2,render_flags(a0)
		btst	#Status_Push,status(a0)
		bne.w	loc_15ECE
		lsr.b	#5,d0
		andi.b	#3,d0
		move.w	ground_vel(a0),d2
		bpl.s	loc_15DBC
		neg.w	d2

loc_15DBC:
		tst.b	status_secondary(a0)
		bpl.w	loc_15DC6
		add.w	d2,d2

loc_15DC6:
		move.b	d0,d3
		lea	(AniTails2P01).l,a1
		cmpi.w	#$600,d2
		bhs.s	loc_15DDC
		lea	(AniTails2P00).l,a1
		add.b	d0,d0

loc_15DDC:
		add.b	d0,d3
		moveq	#0,d1
		move.b	anim_frame(a0),d1
		move.b	1(a1,d1.w),d0
		cmpi.b	#-1,d0
		bne.s	loc_15DF8
		move.b	#0,anim_frame(a0)
		move.b	1(a1),d0

loc_15DF8:
		move.b	d0,mapping_frame(a0)
		add.b	d3,mapping_frame(a0)
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	locret_15E1A
		neg.w	d2
		addi.w	#$800,d2
		bpl.s	loc_15E10
		moveq	#0,d2

loc_15E10:
		lsr.w	#8,d2
		move.b	d2,anim_frame_timer(a0)
		addq.b	#1,anim_frame(a0)

locret_15E1A:
		rts
; ---------------------------------------------------------------------------

loc_15E1C:
		move.b	flip_angle(a0),d0
		moveq	#0,d1
		move.b	status(a0),d2
		andi.b	#1,d2
		bne.s	loc_15E4A
		andi.b	#$FC,render_flags(a0)
		addi.b	#$16,d0
		divu.w	#$2C,d0
		addi.b	#$15,d0
		move.b	d0,mapping_frame(a0)
		move.b	#0,anim_frame_timer(a0)
		rts
; ---------------------------------------------------------------------------

loc_15E4A:
		andi.b	#$FC,render_flags(a0)
		tst.b	flip_type(a0)
		bpl.s	loc_15E62
		ori.b	#1,render_flags(a0)
		addi.b	#$16,d0
		bra.s	loc_15E6E
; ---------------------------------------------------------------------------

loc_15E62:
		ori.b	#3,render_flags(a0)
		neg.b	d0
		addi.b	#$9A,d0

loc_15E6E:
		divu.w	#$2C,d0
		addi.b	#$15,d0
		move.b	d0,mapping_frame(a0)
		move.b	#0,anim_frame_timer(a0)
		rts
; ---------------------------------------------------------------------------

loc_15E82:
		subq.b	#1,anim_frame_timer(a0)
		bpl.w	locret_15D36
		addq.b	#1,d0
		bne.s	loc_15F08
		move.w	ground_vel(a0),d2
		bpl.s	loc_15E96
		neg.w	d2

loc_15E96:
		lea	(AniTails2P03).l,a1
		cmpi.w	#$600,d2
		bhs.s	loc_15EA8
		lea	(AniTails2P02).l,a1

loc_15EA8:
		neg.w	d2
		addi.w	#$400,d2
		bpl.s	loc_15EB2
		moveq	#0,d2

loc_15EB2:
		lsr.w	#8,d2
		move.b	d2,anim_frame_timer(a0)
		move.b	status(a0),d1
		andi.b	#1,d1
		andi.b	#$FC,render_flags(a0)
		or.b	d1,render_flags(a0)
		bra.w	sub_15D1E
; ---------------------------------------------------------------------------

loc_15ECE:
		subq.b	#1,anim_frame_timer(a0)
		bpl.w	locret_15D36
		move.w	ground_vel(a0),d2
		bmi.s	loc_15EDE
		neg.w	d2

loc_15EDE:
		addi.w	#$800,d2
		bpl.s	loc_15EE6
		moveq	#0,d2

loc_15EE6:
		lsr.w	#6,d2
		move.b	d2,anim_frame_timer(a0)
		lea	(AniTails2P04).l,a1
		move.b	status(a0),d1
		andi.b	#1,d1
		andi.b	#$FC,render_flags(a0)
		or.b	d1,render_flags(a0)
		bra.w	sub_15D1E
; ---------------------------------------------------------------------------

loc_15F08:
		move.w	x_vel(a2),d1
		move.w	y_vel(a2),d2
		jsr	(GetArcTan).l
		moveq	#0,d1
		move.b	status(a0),d2
		andi.b	#1,d2
		bne.s	loc_15F26
		not.b	d0
		bra.s	loc_15F2A
; ---------------------------------------------------------------------------

loc_15F26:
		addi.b	#$80,d0

loc_15F2A:
		addi.b	#$10,d0
		bpl.s	loc_15F32
		moveq	#3,d1

loc_15F32:
		andi.b	#$FC,render_flags(a0)
		eor.b	d1,d2
		or.b	d2,render_flags(a0)
		lsr.b	#5,d0
		andi.b	#3,d0
		move.b	d0,d3
		add.b	d0,d0
		add.b	d0,d3
		lea	(AniTails2P_Tail03).l,a1
		move.b	#3,anim_frame_timer(a0)
		bsr.w	sub_15D1E
		add.b	d3,mapping_frame(a0)
		rts
; ---------------------------------------------------------------------------
AniTails2P:
		include "General/Sprites/Tails/Anim - Tails 2P.asm"

; =============== S U B R O U T I N E =======================================


Tails2P_Tail_Load_PLC:
		moveq	#0,d0
		move.b	mapping_frame(a0),d0
		lea	(DPLC_Tails2P_Tail).l,a2
		add.w	d0,d0
		adda.w	(a2,d0.w),a2
		move.w	(a2)+,d5
		subq.w	#1,d5
		bmi.s	locret_160A4
		move.l	#ArtUnc_Tails2P_Tail,d6
		move.w	#tiles_to_bytes(ArtTile_Player_2_Tail),d4
		cmpa.w	#Tails_tails,a0
		beq.s	loc_1607C
		move.w	#tiles_to_bytes($690),d4
		bra.s	loc_1607C
; End of function Tails2P_Tail_Load_PLC


; =============== S U B R O U T I N E =======================================


Tails2P_Load_PLC:
		moveq	#0,d0
		move.b	mapping_frame(a0),d0
		lea	(PLC_Tails2P).l,a2
		add.w	d0,d0
		adda.w	(a2,d0.w),a2
		move.w	(a2)+,d5
		subq.w	#1,d5
		bmi.s	locret_160A4
		move.l	#ArtUnc_Tails2P,d6
		move.w	#tiles_to_bytes(ArtTile_Player_1),d4
		cmpa.w	#Player_1,a0
		beq.s	loc_1607C
		move.w	#tiles_to_bytes(ArtTile_Player_2),d4

loc_1607C:
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
		dbf	d5,loc_1607C

locret_160A4:
		rts
; End of function Tails2P_Load_PLC

; ---------------------------------------------------------------------------

Obj_Tails_Tail:
		; Init
		move.l	#Map_Tails_Tail,mappings(a0)
		move.w	#make_art_tile(ArtTile_Player_2_Tail,0,0),art_tile(a0)
		move.w	#$100,priority(a0)
		move.b	#$18,width_pixels(a0)
		move.b	#$18,height_pixels(a0)
		move.b	#4,render_flags(a0)
		move.l	#Obj_Tails_Tail_Main,(a0)

Obj_Tails_Tail_Main:
		; Here, several SSTs are inheritied from the parent, normally Tails
		movea.w	$30(a0),a2	; Is Parent in S2
		move.b	angle(a2),angle(a0)
		move.b	status(a2),status(a0)
		move.w	x_pos(a2),x_pos(a0)
		move.w	y_pos(a2),y_pos(a0)
		move.w	priority(a2),priority(a0)
		andi.w	#drawing_mask,art_tile(a0)
		tst.w	art_tile(a2)
		bpl.s	loc_16106
		ori.w	#high_priority,art_tile(a0)

loc_16106:
		moveq	#0,d0
		move.b	anim(a2),d0
		btst	#Status_Push,status(a2)
		beq.s	loc_1612C
		tst.b	(WindTunnel_flag_P2).w
		bne.s	loc_1612C
		; This is checking if parent (Tails) is in its pushing animation
		cmpi.b	#$A9,mapping_frame(a2)
		blo.s	loc_1612C
		cmpi.b	#$AC,mapping_frame(a2)
		bhi.s	loc_1612C
		moveq	#4,d0

loc_1612C:
		cmp.b	objoff_34(a0),d0	; Has the input parent anim changed since last check?
		beq.s	loc_1613C		; If not, branch and skip setting a matching Tails' Tails anim
		move.b	d0,objoff_34(a0)	; Store d0 for the above comparision
		move.b	Obj_Tails_Tail_AniSelection(pc,d0.w),anim(a0)	; Load anim relative to parent's

loc_1613C:
		lea	(AniTails_Tail).l,a1
		bsr.w	Animate_Tails_Part2
		tst.b	(Reverse_gravity_flag).w
		beq.s	loc_1615A
		cmpi.b	#3,anim(a0)		; Is this the Directional animation?
		beq.s	loc_1615A		; If so, skip the mirroring
		eori.b	#2,render_flags(a0)	; Reverse the vertical mirror render flag bit (on if off beforehand and vice versa)

loc_1615A:
		bsr.w	Tails_Tail_Load_PLC
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
; animation master script table for the tails
; chooses which animation script to run depending on what Tails is doing

Obj_Tails_Tail_AniSelection:
		dc.b 0,0	; TailsAni_Walk,Run	->
		dc.b 3		; TailsAni_Roll		-> Directional
		dc.b 3		; TailsAni_Roll2	-> Directional
		dc.b 9		; TailsAni_Push		-> Pushing
		dc.b 1		; TailsAni_Wait		-> Swish
		dc.b 0		; TailsAni_Balance	-> Blank
		dc.b 2		; TailsAni_LookUp	-> Flick
		dc.b 1		; TailsAni_Duck		-> Swish
		dc.b 7		; TailsAni_Spindash	-> Spindash
		dc.b 0,0,0	; TailsAni_Dummy1,2,3	->
		dc.b 8		; TailsAni_Stop		-> Skidding
		dc.b 0,0	; TailsAni_Float,2	->
		dc.b 0		; TailsAni_Spring	->
		dc.b 0		; TailsAni_Hang		->
		dc.b 0		;
		dc.b 0		; TailsAni_Victory	->
		dc.b $A		; TailsAni_Hang2	-> Hanging
		dc.b 0		; TailsAni_Bubble	->
		dc.b 0,0,0	; TailsAni_Death,2,3	->
		dc.b 0		; TailsAni_Slide2?	->
		dc.b 0,0	; TailsAni_Hurt,Slide	->
		dc.b 0		; TailsAni_Blank	->
		dc.b 0,0	; TailsAni_Dummy4,5	->
		dc.b 0		; TailsAni_HaulAss	->
		dc.b $B,$C	; TailsAni_Fly,2	-> Fly1,2
		dc.b $B		; TailsAni_Carry	-> Fly1
		dc.b $C		; TailsAni_Ascend	-> Fly2
		dc.b $B		; TailsAni_Tired	-> Fly1
		dc.b 0,0	; TailsAni_Swim,2	->
		dc.b 0		; TailsAni_Tired2	->
		dc.b 0		; TailsAni_Tired3	->
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 0
		even
AniTails_Tail:
		include "General/Sprites/Tails/Anim - Tails Tail.asm"
; ---------------------------------------------------------------------------

Obj_Tails2P_Tail:
		move.l	#Map_Tails2P_Tail,mappings(a0)
		move.w	#make_art_tile(ArtTile_Player_2_Tail,0,0),art_tile(a0)
		cmpa.w	#Tails_tails,a0
		beq.s	loc_16214
		move.w	#make_art_tile($690,0,0),art_tile(a0)

loc_16214:
		move.w	#$100,priority(a0)
		move.b	#$18,width_pixels(a0)
		move.b	#$18,height_pixels(a0)
		move.b	#4,render_flags(a0)
		move.l	#loc_16232,(a0)

loc_16232:
		movea.w	$30(a0),a2
		move.b	angle(a2),angle(a0)
		move.b	status(a2),status(a0)
		move.w	x_pos(a2),x_pos(a0)
		move.w	y_pos(a2),y_pos(a0)
		move.w	priority(a2),priority(a0)
		andi.w	#drawing_mask,art_tile(a0)
		tst.w	art_tile(a2)
		bpl.s	loc_16266
		ori.w	#high_priority,art_tile(a0)

loc_16266:
		moveq	#0,d0
		move.b	anim(a2),d0
		btst	#Status_Push,status(a2)
		beq.s	loc_1627C
		cmpi.b	#5,d0
		beq.s	loc_1627C
		moveq	#4,d0

loc_1627C:
		cmp.b	$34(a0),d0
		beq.s	loc_1628C
		move.b	d0,$34(a0)
		move.b	byte_162A0(pc,d0.w),anim(a0)

loc_1628C:
		lea	(AniTails2P_Tail).l,a1
		bsr.w	Animate_Tails_Tail2P
		bsr.w	Tails2P_Tail_Load_PLC
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
byte_162A0:
		dc.b 0,0
		dc.b 3
		dc.b 3
		dc.b 0
		dc.b 1
		dc.b 1
		dc.b 1
		dc.b 1
		dc.b 0
		dc.b 1,1,1
		dc.b 0
		dc.b 0,0
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 0
		dc.b 0,0,0
		dc.b 0
		dc.b 0,0
		dc.b 0
		dc.b 0,0
		dc.b 0
		dc.b 0,0
		even
AniTails2P_Tail:
		include "General/Sprites/Tails/Anim - Tails 2P Tail.asm"
; ---------------------------------------------------------------------------

Obj_MGZ2_BossTransition:
		cmpi.w	#2,(Player_mode).w
		beq.w	loc_163D0
		move.w	(Camera_X_pos).w,d0
		addi.w	#$40,d0
		move.w	d0,x_pos(a0)
		move.w	(Camera_Y_pos).w,d0
		addi.w	#$100,d0
		move.w	d0,y_pos(a0)
		lea	(Player_2).w,a1
		tst.b	render_flags(a1)
		bmi.s	loc_16328
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		subq.w	#1,y_pos(a1)
		move.l	#Obj_Tails,(Player_2).w
		move.w	#$12,(Tails_CPU_routine).w
		move.w	#0,(Flying_carrying_Sonic_flag).w

loc_16328:
		move.w	#$168,$30(a0)
		move.l	#loc_16334,(a0)

loc_16334:
		subq.w	#1,$30(a0)
		bne.s	loc_16340
		move.l	#loc_16340,(a0)

loc_16340:
		tst.b	(Flying_carrying_Sonic_flag).w
		bne.s	loc_16384
		lea	(Player_1).w,a1
		move.w	y_pos(a0),d0
		cmp.w	y_pos(a1),d0
		bhs.s	loc_16384
		move.w	d0,y_pos(a1)
		move.w	#0,x_vel(a1)
		move.w	#0,y_vel(a1)
		move.w	#0,ground_vel(a1)
		move.b	#0,spin_dash_flag(a1)
		cmpi.w	#$14,(Tails_CPU_routine).w
		blo.s	loc_1637E
		move.w	x_pos(a1),x_pos(a0)

loc_1637E:
		move.b	#2,routine(a1)

loc_16384:
		tst.b	(Player_1+render_flags).w
		bmi.s	locret_163CE
		cmpi.b	#2,(Player_1+routine).w
		bne.s	locret_163CE
		lea	(Player_2).w,a1
		move.w	y_pos(a0),d0
		cmp.w	y_pos(a1),d0
		bhs.s	locret_163CE
		move.w	#$12,(Tails_CPU_routine).w
		tst.w	$30(a0)
		bne.s	locret_163CE
		move.w	d0,y_pos(a1)
		move.b	#2,routine(a1)
		move.b	#0,object_control(a1)
		move.b	#0,spin_dash_flag(a1)
		move.w	x_pos(a0),x_pos(a1)
		move.w	#$14,(Tails_CPU_routine).w

locret_163CE:
		rts
; ---------------------------------------------------------------------------

loc_163D0:
		move.w	(Camera_X_pos).w,d0
		addi.w	#$40,d0
		move.w	d0,x_pos(a0)
		move.w	(Camera_Y_pos).w,d0
		addi.w	#$100,d0
		move.w	d0,y_pos(a0)
		move.w	#$168,$30(a0)
		move.l	#loc_163F4,(a0)

loc_163F4:
		subq.w	#1,$30(a0)
		bne.s	loc_1640A
		move.l	#loc_1640A,(a0)
		lea	(Player_1).w,a1
		move.w	x_pos(a0),x_pos(a1)

loc_1640A:
		lea	(Player_1).w,a1
		move.w	y_pos(a0),d0
		cmp.w	y_pos(a1),d0
		bhs.s	locret_16442
		move.w	d0,y_pos(a1)
		addq.w	#8,y_pos(a1)
		tst.w	$30(a0)
		bne.s	locret_16442
		move.w	d0,y_pos(a1)
		move.b	#2,routine(a1)
		move.b	#0,object_control(a1)
		move.b	#0,spin_dash_flag(a1)
		move.w	#$1A,(Tails_CPU_routine).w

locret_16442:
		rts
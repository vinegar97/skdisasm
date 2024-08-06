Obj_Tails2P:
		cmpa.w	#Player_1,a0
		bne.s	++ ;loc_13E86
		lea	(Max_speed).w,a4
		lea	(Distance_from_top).w,a5
		lea	(Dust).w,a6
		move.b	(Player_2+character_id).w,d0
		cmp.b	character_id(a0),d0
		bne.s	+ ;loc_13E7A
		bchg	#3,render_flags(a0)

+ ;loc_13E7A:
		tst.w	(Debug_placement_mode).w
		beq.s	++ ;loc_13EA2
		jmp	(DebugMode).l
; ---------------------------------------------------------------------------

+ ;loc_13E86:
		lea	(Max_speed_P2).w,a4
		lea	(Distance_from_top_P2).w,a5
		lea	(Dust_P2).w,a6
		move.b	(Player_1+character_id).w,d0
		cmp.b	character_id(a0),d0
		bne.s	+ ;loc_13EA2
		bchg	#4,render_flags(a0)

+ ;loc_13EA2:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	.Index(pc,d0.w),d1
		jmp	.Index(pc,d1.w)
; ---------------------------------------------------------------------------
.Index:
		dc.w loc_13EBC-.Index
		dc.w loc_13FCA-.Index
		dc.w loc_1620A-.Index
		dc.w loc_162C4-.Index
		dc.w loc_162F4-.Index
		dc.w loc_16308-.Index
; ---------------------------------------------------------------------------

loc_13EBC:
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
		bne.w	loc_13FA6
		move.b	#$C,top_solid_bit(a0)
		move.b	#$D,lrb_solid_bit(a0)
		cmpa.w	#Player_1,a0
		bne.s	++ ;loc_13F6E
		move.w	#make_art_tile(ArtTile_Player_1,0,0),art_tile(a0)
		cmpi.b	#$12,(Current_zone).w
		bne.s	+ ;loc_13F48
		ori.w	#high_priority,art_tile(a0)

+ ;loc_13F48:
		move.w	x_pos(a0),(Saved_X_pos).w
		move.w	y_pos(a0),(Saved_Y_pos).w
		move.w	art_tile(a0),(Saved_art_tile).w
		move.w	top_solid_bit(a0),(Saved_solid_bits).w
		move.l	#Obj_Tails2P_Tail,(Tails_tails_2P).w
		move.w	a0,(Tails_tails_2P+$30).w
		bra.s	loc_13FA6
; ---------------------------------------------------------------------------

+ ;loc_13F6E:
		move.w	#make_art_tile(ArtTile_Player_2,0,0),art_tile(a0)
		cmpi.b	#$12,(Current_zone).w
		bne.s	+ ;loc_13F82
		ori.w	#high_priority,art_tile(a0)

+ ;loc_13F82:
		move.w	x_pos(a0),(Saved2_X_pos).w
		move.w	y_pos(a0),(Saved2_Y_pos).w
		move.w	art_tile(a0),(Saved2_art_tile).w
		move.w	top_solid_bit(a0),(Saved2_solid_bits).w
		move.l	#Obj_Tails2P_Tail,(Tails_tails).w
		move.w	a0,(Tails_tails+$30).w

loc_13FA6:
		move.b	#0,flips_remaining(a0)
		move.b	#4,flip_speed(a0)
		move.b	#30,air_left(a0)
		move.w	#0,(Tails_CPU_routine).w
		move.w	#10*60,(Tails_CPU_idle_timer).w
		move.w	#0,(Tails_CPU_flight_timer).w

loc_13FCA:
		tst.w	(Debug_mode_flag).w
		beq.s	+ ;loc_13FEA
		cmpa.w	#Player_1,a0
		bne.s	+ ;loc_13FEA
		btst	#button_B,(Ctrl_1_pressed).w
		beq.s	+ ;loc_13FEA
		move.w	#1,(Debug_placement_mode).w
		clr.b	(Ctrl_1_locked).w
		rts
; ---------------------------------------------------------------------------

+ ;loc_13FEA:
		cmpa.w	#Player_1,a0
		bne.s	+ ;loc_1400A
		move.w	(Ctrl_1_logical).w,(Ctrl_2_logical).w
		tst.b	(Ctrl_1_locked).w
		bne.s	++ ;loc_14016
		move.w	(Ctrl_1).w,(Ctrl_2_logical).w
		move.w	(Ctrl_1).w,(Ctrl_1_logical).w
		bra.s	++ ;loc_14016
; ---------------------------------------------------------------------------

+ ;loc_1400A:
		tst.b	(Ctrl_2_locked).w
		bne.s	+ ;loc_14016
		move.w	(Ctrl_2).w,(Ctrl_2_logical).w

+ ;loc_14016:
		bsr.w	Tails_Display
		btst	#0,object_control(a0)
		bne.s	+ ;loc_14034
		moveq	#0,d0
		move.b	status(a0),d0
		andi.w	#6,d0
		move.w	off_14084(pc,d0.w),d1
		jsr	off_14084(pc,d1.w)

+ ;loc_14034:
		cmpi.w	#-$100,(Camera_min_Y_pos).w
		bne.s	+ ;loc_14044
		move.w	(Screen_Y_wrap_value).w,d0
		and.w	d0,y_pos(a0)

+ ;loc_14044:
		move.w	(Screen_X_wrap_value).w,d0
		and.w	d0,x_pos(a0)
		addi.w	#$400,x_pos(a0)
		bsr.w	Sonic_RecordPos
		move.b	(Primary_Angle).w,next_tilt(a0)
		move.b	(Secondary_Angle).w,tilt(a0)
		btst	#1,object_control(a0)
		bne.s	+ ;loc_14072
		bsr.w	Animate_Tails2P
		bsr.w	Tails2P_Load_PLC

+ ;loc_14072:
		move.b	object_control(a0),d0
		andi.b	#$A0,d0
		bne.s	locret_14082
		jsr	(TouchResponse_CompetitionMode).l

locret_14082:
		rts
; ---------------------------------------------------------------------------
off_14084:
		dc.w loc_1408C-off_14084
		dc.w loc_140B0-off_14084
		dc.w loc_141C0-off_14084
		dc.w loc_141E2-off_14084
; ---------------------------------------------------------------------------

loc_1408C:
		bsr.w	sub_14276
		bsr.w	Tails_Jump
		bsr.w	Tails_SlopeResist
		bsr.w	Tails_InputAcceleration_Path
		bsr.w	sub_14210
		jsr	(MoveSprite2).l
		bsr.w	Player_AnglePos
		bsr.w	Tails_SlopeRepel
		rts
; ---------------------------------------------------------------------------

loc_140B0:
		tst.b	double_jump_flag(a0)
		bne.s	++ ;loc_140E4
		bsr.w	Tails_JumpHeight
		bsr.w	Tails_InputAcceleration_Freespace
		jsr	(MoveSprite).l
		btst	#Status_Underwater,status(a0)
		beq.s	+ ;loc_140D2
		subi.w	#$28,y_vel(a0)

+ ;loc_140D2:
		bsr.w	Tails_JumpAngle
		movem.l	a4-a6,-(sp)
		bsr.w	Tails_DoLevelCollision
		movem.l	(sp)+,a4-a6
		rts
; ---------------------------------------------------------------------------

+ ;loc_140E4:
		bsr.w	+ ;sub_14104
		bsr.w	Tails_InputAcceleration_Freespace
		jsr	(MoveSprite2).l
		bsr.w	Tails_JumpAngle
		movem.l	a4-a6,-(sp)
		bsr.w	Tails_DoLevelCollision
		movem.l	(sp)+,a4-a6
		rts

; =============== S U B R O U T I N E =======================================


+ ;sub_14104:
		move.b	(Level_frame_counter+1).w,d0
		andi.b	#1,d0
		beq.s	+ ;loc_14118
		tst.b	double_jump_property(a0)
		beq.s	+ ;loc_14118
		subq.b	#1,double_jump_property(a0)

+ ;loc_14118:
		cmpi.b	#1,double_jump_flag(a0)
		beq.s	+++ ;loc_14142
		cmpi.w	#-$100,y_vel(a0)
		blt.s	+ ;loc_1413A
		subi.w	#$20,y_vel(a0)
		addq.b	#1,double_jump_flag(a0)
		cmpi.b	#$20,double_jump_flag(a0)
		bne.s	++ ;loc_14140

+ ;loc_1413A:
		move.b	#1,double_jump_flag(a0)

+ ;loc_14140:
		bra.s	loc_14174
; ---------------------------------------------------------------------------

+ ;loc_14142:
		move.b	(Ctrl_2_pressed_logical).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0
		beq.s	++ ;loc_1416E
		cmpi.w	#-$100,y_vel(a0)
		blt.s	++ ;loc_1416E
		tst.b	double_jump_property(a0)
		beq.s	++ ;loc_1416E
		btst	#Status_Underwater,status(a0)
		beq.s	+ ;loc_14168
		tst.b	(Flying_carrying_Sonic_flag).w
		bne.s	++ ;loc_1416E

+ ;loc_14168:
		move.b	#2,double_jump_flag(a0)

+ ;loc_1416E:
		addi.w	#8,y_vel(a0)

loc_14174:
		move.w	(Camera_min_Y_pos).w,d0
		addi.w	#$10,d0
		cmp.w	y_pos(a0),d0
		blt.s	+ ;loc_1418E
		tst.w	y_vel(a0)
		bpl.s	+ ;loc_1418E
		move.w	#0,y_vel(a0)

+ ;loc_1418E:
		tst.b	double_jump_property(a0)
		bne.s	+ ;loc_141AA
		move.b	(Level_frame_counter+1).w,d0
		addq.b	#8,d0
		andi.b	#$F,d0
		bne.s	locret_141A8
		moveq	#signextendB(sfx_FlyTired),d0
		jsr	(Play_SFX).l

locret_141A8:
		rts
; ---------------------------------------------------------------------------

+ ;loc_141AA:
		move.b	(Level_frame_counter+1).w,d0
		addq.b	#8,d0
		andi.b	#$F,d0
		bne.s	locret_141BE
		moveq	#signextendB(sfx_Flying),d0
		jsr	(Play_SFX).l

locret_141BE:
		rts
; End of function sub_14104

; ---------------------------------------------------------------------------

loc_141C0:
		tst.b	spin_dash_flag(a0)
		bne.s	+ ;loc_141CA
		bsr.w	Tails_Jump

+ ;loc_141CA:
		bsr.w	Tails_RollRepel
		bsr.w	Tails_RollSpeed
		jsr	(MoveSprite2).l
		bsr.w	Player_AnglePos
		bsr.w	Tails_SlopeRepel
		rts
; ---------------------------------------------------------------------------

loc_141E2:
		bsr.w	Tails_JumpHeight
		bsr.w	Tails_InputAcceleration_Freespace
		jsr	(MoveSprite).l
		btst	#Status_Underwater,status(a0)
		beq.s	+ ;loc_141FE
		subi.w	#$28,y_vel(a0)

+ ;loc_141FE:
		bsr.w	Tails_JumpAngle
		movem.l	a4-a6,-(sp)
		bsr.w	Tails_DoLevelCollision
		movem.l	(sp)+,a4-a6
		rts

; =============== S U B R O U T I N E =======================================


sub_14210:
		tst.b	status_secondary(a0)
		bmi.s	locret_14236
		move.w	ground_vel(a0),d0
		bpl.s	+ ;loc_1421E
		neg.w	d0

+ ;loc_1421E:
		cmpi.w	#$80,d0
		bcs.s	locret_14236
		move.b	(Ctrl_2_held_logical).w,d0
		andi.b	#button_left_mask|button_right_mask,d0
		bne.s	locret_14236
		btst	#button_down,(Ctrl_2_held_logical).w
		bne.s	+ ;loc_14238

locret_14236:
		rts
; ---------------------------------------------------------------------------

+ ;loc_14238:
		btst	#Status_Roll,status(a0)
		beq.s	+ ;loc_14242
		rts
; ---------------------------------------------------------------------------

+ ;loc_14242:
		bset	#Status_Roll,status(a0)
		move.b	#7,y_radius(a0)
		move.b	#3,x_radius(a0)
		move.b	#2,anim(a0)
		addq.w	#4,y_pos(a0)
		move.w	#sfx_Roll,d0
		jsr	(Play_SFX).l
		tst.w	ground_vel(a0)
		bne.s	locret_14274
		move.w	#$200,ground_vel(a0)

locret_14274:
		rts
; End of function sub_14210


; =============== S U B R O U T I N E =======================================


sub_14276:
		tst.b	spin_dash_flag(a0)
		bne.s	++ ;loc_142C6
		cmpi.b	#8,anim(a0)
		bne.s	locret_142C4
		move.b	(Ctrl_2_pressed_logical).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0
		beq.w	locret_142C4
		move.b	#9,anim(a0)
		move.w	#signextendB(sfx_Spindash),d0
		jsr	(Play_SFX).l
		addq.l	#4,sp
		move.b	#1,spin_dash_flag(a0)
		move.w	#0,spin_dash_counter(a0)
		cmpi.b	#12,air_left(a0)
		blo.s	+ ;loc_142BC
		move.b	#2,anim(a6)

+ ;loc_142BC:
		bsr.w	Tails_Check_Screen_Boundaries
		bsr.w	Player_AnglePos

locret_142C4:
		rts
; ---------------------------------------------------------------------------

+ ;loc_142C6:
		move.b	(Ctrl_2_held_logical).w,d0
		btst	#button_down,d0
		bne.w	+++ ;loc_14356
		move.b	#7,y_radius(a0)
		move.b	#3,x_radius(a0)
		move.b	#2,anim(a0)
		addq.w	#4,y_pos(a0)
		move.b	#0,spin_dash_flag(a0)
		moveq	#0,d0
		move.b	spin_dash_counter(a0),d0
		add.w	d0,d0
		move.w	word_14344(pc,d0.w),ground_vel(a0)
		move.w	ground_vel(a0),d0
		subi.w	#$800,d0
		add.w	d0,d0
		andi.w	#$1F00,d0
		neg.w	d0
		addi.w	#$2000,d0
		lea	(H_scroll_frame_offset).w,a1
		cmpa.w	#Player_1,a0
		beq.s	+ ;loc_1431E
		lea	(H_scroll_frame_offset_P2).w,a1

+ ;loc_1431E:
		move.w	d0,(a1)
		btst	#Status_Facing,status(a0)
		beq.s	+ ;loc_1432C
		neg.w	ground_vel(a0)

+ ;loc_1432C:
		bset	#Status_Roll,status(a0)
		move.b	#0,anim(a6)
		move.w	#signextendB(sfx_Dash),d0
		jsr	(Play_SFX).l
		bra.s	+++ ;loc_1439E
; ---------------------------------------------------------------------------
word_14344:
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

+ ;loc_14356:
		tst.w	spin_dash_counter(a0)
		beq.s	+ ;loc_1436E
		move.w	spin_dash_counter(a0),d0
		lsr.w	#5,d0
		sub.w	d0,spin_dash_counter(a0)
		bcc.s	+ ;loc_1436E
		move.w	#0,spin_dash_counter(a0)

+ ;loc_1436E:
		move.b	(Ctrl_2_pressed_logical).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0
		beq.w	+ ;loc_1439E
		move.w	#9<<8,anim(a0)	; and prev_anim
		move.w	#signextendB(sfx_Spindash),d0
		jsr	(Play_SFX).l
		addi.w	#$200,spin_dash_counter(a0)
		cmpi.w	#$800,spin_dash_counter(a0)
		blo.s	+ ;loc_1439E
		move.w	#$800,spin_dash_counter(a0)

+ ;loc_1439E:
		addq.l	#4,sp
		cmpi.w	#$60,(a5)
		beq.s	++ ;loc_143AC
		bcc.s	+ ;loc_143AA
		addq.w	#4,(a5)

+ ;loc_143AA:
		subq.w	#2,(a5)

+ ;loc_143AC:
		bsr.w	Player_AnglePos
		rts
; End of function sub_14276

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
		beq.s	+++ ;loc_143FE
		btst	#button_B,(Ctrl_1_pressed).w
		beq.s	+ ;loc_143E2
		move.w	#0,(Debug_placement_mode).w

+ ;loc_143E2:
		addq.b	#1,mapping_frame(a0)
		cmpi.b	#$D1,mapping_frame(a0)
		blo.s	+ ;loc_143F4
		move.b	#0,mapping_frame(a0)

+ ;loc_143F4:
		bsr.w	Tails_Load_PLC
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

+ ;loc_143FE:
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
		dc.w loc_1620A-Tails_Index
		dc.w loc_162C4-Tails_Index
		dc.w loc_162F4-Tails_Index
		dc.w loc_16308-Tails_Index
		dc.w loc_16324-Tails_Index
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
		bne.s	+ ;loc_144B4
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

+ ;loc_144B4:
		move.w	#make_art_tile(ArtTile_Player_2,0,0),art_tile(a0)
		move.w	(Player_1+top_solid_bit).w,top_solid_bit(a0)
		tst.w	(Player_1+art_tile).w
		bpl.s	Tails_Init_Continued
		ori.w	#high_priority,art_tile(a0)

Tails_Init_Continued:
		move.b	#0,flips_remaining(a0)
		move.b	#4,flip_speed(a0)
		move.b	#30,air_left(a0)
		cmpi.w	#$20,(Tails_CPU_routine).w
		beq.s	+ ;loc_144F4
		cmpi.w	#$12,(Tails_CPU_routine).w
		beq.s	+ ;loc_144F4
		move.w	#0,(Tails_CPU_routine).w

+ ;loc_144F4:
		move.w	#0,(Tails_CPU_idle_timer).w
		move.w	#0,(Tails_CPU_flight_timer).w
		move.l	#Obj_Tails_Tail,(Tails_tails).w
		move.w	a0,(Tails_tails+$30).w
		move.b	(Last_star_post_hit).w,(Tails_CPU_star_post_flag).w
		rts
; ---------------------------------------------------------------------------

Tails_Control:
		cmpi.w	#2,(Player_mode).w
		bne.s	+ ;loc_14544
		tst.w	(Debug_mode_flag).w
		beq.s	+ ;loc_14544
		btst	#button_B,(Ctrl_1_pressed).w
		beq.s	+ ;loc_14544
		move.w	#1,(Debug_placement_mode).w
		clr.b	(Ctrl_1_locked).w
		btst	#button_C,(Ctrl_1_held).w
		beq.s	locret_14542
		move.w	#2,(Debug_placement_mode).w

locret_14542:
		rts
; ---------------------------------------------------------------------------

+ ;loc_14544:
		cmpa.w	#Player_1,a0
		bne.s	+ ;loc_1456C
		move.w	(Ctrl_1_logical).w,(Ctrl_2_logical).w
		tst.b	(Ctrl_1_locked).w
		bne.s	+++ ;loc_14582
		move.w	(Ctrl_1).w,(Ctrl_2_logical).w
		move.w	(Ctrl_1).w,(Ctrl_1_logical).w
		cmpi.w	#$1A,(Tails_CPU_routine).w
		bhs.s	++ ;loc_14578
		bra.s	+++ ;loc_14582
; ---------------------------------------------------------------------------

+ ;loc_1456C:
		tst.b	(Ctrl_2_locked).w
		bne.s	++ ;loc_14582
		move.w	(Ctrl_2).w,(Ctrl_2_logical).w

+ ;loc_14578:
		tst.w	(Competition_mode).w
		bne.s	+ ;loc_14582
		bsr.w	Tails_CPU_Control

+ ;loc_14582:
		btst	#0,object_control(a0)
		beq.s	+ ;loc_145AA
		move.b	#0,double_jump_flag(a0)
		tst.b	(Flying_carrying_Sonic_flag).w
		beq.s	++ ;loc_145C4
		lea	(Player_1).w,a1
		clr.b	object_control(a1)
		bset	#Status_InAir,status(a1)
		clr.w	(Flying_carrying_Sonic_flag).w
		bra.s	++ ;loc_145C4
; ---------------------------------------------------------------------------

+ ;loc_145AA:
		movem.l	a4-a6,-(sp)
		moveq	#0,d0
		move.b	status(a0),d0
		andi.w	#6,d0
		move.w	Tails_Modes(pc,d0.w),d1
		jsr	Tails_Modes(pc,d1.w)
		movem.l	(sp)+,a4-a6

+ ;loc_145C4:
		cmpi.w	#-$100,(Camera_min_Y_pos).w
		bne.s	+ ;loc_145D4
		move.w	(Screen_Y_wrap_value).w,d0
		and.w	d0,y_pos(a0)

+ ;loc_145D4:
		bsr.s	Tails_Display
		bsr.w	Sonic_RecordPos
		bsr.w	Tails_Water
		move.b	(Primary_Angle).w,next_tilt(a0)
		move.b	(Secondary_Angle).w,tilt(a0)
		tst.b	(WindTunnel_flag_P2).w
		beq.s	+ ;loc_145FC
		tst.b	anim(a0)
		bne.s	+ ;loc_145FC
		move.b	prev_anim(a0),anim(a0)

+ ;loc_145FC:
		btst	#1,object_control(a0)
		bne.s	+ ;loc_1460C
		bsr.w	Animate_Tails
		bsr.w	Tails_Load_PLC

+ ;loc_1460C:
		move.b	object_control(a0),d0
		andi.b	#$A0,d0
		bne.s	locret_1461C
		jsr	(TouchResponse).l

locret_1461C:
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
		beq.s	+ ;loc_14634
		subq.b	#1,invulnerability_timer(a0)
		lsr.b	#3,d0
		bcc.s	++ ;loc_1463A

+ ;loc_14634:
		jsr	(Draw_Sprite).l

+ ;loc_1463A:
		btst	#Status_Invincible,status_secondary(a0)
		beq.s	++ ;loc_14676
		tst.b	invincibility_timer(a0)
		beq.s	++ ;loc_14676
		move.b	(Level_frame_counter+1).w,d0
		andi.b	#7,d0
		bne.s	++ ;loc_14676
		subq.b	#1,invincibility_timer(a0)
		bne.s	++ ;loc_14676
		tst.b	(Boss_flag).w
		bne.s	+ ;loc_14670
		cmpi.b	#12,air_left(a0)
		blo.s	+ ;loc_14670
		move.w	(Current_music).w,d0
		jsr	(Play_Music).l

+ ;loc_14670:
		bclr	#Status_Invincible,status_secondary(a0)

+ ;loc_14676:
		btst	#Status_SpeedShoes,status_secondary(a0)
		beq.s	locret_146B8
		tst.b	speed_shoes_timer(a0)
		beq.s	locret_146B8
		move.b	(Level_frame_counter+1).w,d0
		andi.b	#7,d0
		bne.s	locret_146B8
		subq.b	#1,speed_shoes_timer(a0)
		bne.s	locret_146B8
		tst.w	(Competition_mode).w
		bne.s	+ ;loc_146BA
		move.w	#$600,Max_speed_P2-Max_speed_P2(a4)
		move.w	#$C,Acceleration_P2-Max_speed_P2(a4)
		move.w	#$80,Deceleration_P2-Max_speed_P2(a4)
		bclr	#Status_SpeedShoes,status_secondary(a0)
		moveq	#0,d0
		jmp	(Change_Music_Tempo).l
; ---------------------------------------------------------------------------

locret_146B8:
		rts
; ---------------------------------------------------------------------------

+ ;loc_146BA:
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
		move.b	(Ctrl_2_held).w,d0
		andi.b	#$7F,d0
		beq.s	+ ;loc_146EE
		move.w	#10*60,(Tails_CPU_idle_timer).w

+ ;loc_146EE:
		lea	(Player_1).w,a1
		move.w	(Tails_CPU_routine).w,d0
		move.w	Tails_CPU_Control.Index(pc,d0.w),d0
		jmp	Tails_CPU_Control.Index(pc,d0.w)
; End of function Tails_CPU_Control

; ---------------------------------------------------------------------------
Tails_CPU_Control.Index:
		dc.w loc_14722-Tails_CPU_Control.Index
		dc.w Tails_Catch_Up_Flying-Tails_CPU_Control.Index
		dc.w Tails_FlySwim_Unknown-Tails_CPU_Control.Index
		dc.w loc_149E8-Tails_CPU_Control.Index
		dc.w loc_14BC6-Tails_CPU_Control.Index
		dc.w locret_14C46-Tails_CPU_Control.Index
		dc.w loc_14C48-Tails_CPU_Control.Index
		dc.w loc_14C80-Tails_CPU_Control.Index
		dc.w loc_14D10-Tails_CPU_Control.Index
		dc.w loc_14D4C-Tails_CPU_Control.Index
		dc.w loc_14D54-Tails_CPU_Control.Index
		dc.w loc_14D8C-Tails_CPU_Control.Index
		dc.w loc_14DD2-Tails_CPU_Control.Index
		dc.w loc_14E78-Tails_CPU_Control.Index
		dc.w loc_14EA2-Tails_CPU_Control.Index
		dc.w loc_14EDA-Tails_CPU_Control.Index
		dc.w loc_14EE2-Tails_CPU_Control.Index
		dc.w loc_14F0C-Tails_CPU_Control.Index
; ---------------------------------------------------------------------------

loc_14722:
		tst.b	(Tails_CPU_star_post_flag).w
		bne.w	loc_147A8
		cmpi.w	#0,(Current_zone_and_act).w
		bne.s	+ ;loc_14744
		bsr.w	sub_14B58
		move.w	#$A,(Tails_CPU_routine).w
		move.b	#$83,object_control(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_14744:
		cmpi.w	#$100,(Current_zone_and_act).w
		beq.w	+++ ;loc_147C6
		cmpi.w	#$200,(Current_zone_and_act).w
		beq.w	+++ ;loc_147C6
		cmpi.w	#$300,(Current_zone_and_act).w
		bne.s	+ ;loc_14786
		move.w	#0,(Tails_CPU_idle_timer).w
		move.w	#0,(Tails_CPU_flight_timer).w
		move.b	#2,status(a0)
		move.w	#$18,x_pos(a0)
		move.w	#$600,y_pos(a0)
		move.w	#$C,(Tails_CPU_routine).w
		rts
; ---------------------------------------------------------------------------

+ ;loc_14786:
		cmpi.w	#$500,(Current_zone_and_act).w
		bne.s	+ ;loc_147A0
		bsr.w	sub_14B58
		move.w	#$A,(Tails_CPU_routine).w
		move.b	#$83,object_control(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_147A0:
		cmpi.w	#$600,(Current_zone_and_act).w
		beq.s	+ ;loc_147C6

loc_147A8:
		move.b	#0,anim(a0)
		move.w	#0,x_vel(a0)
		move.w	#0,y_vel(a0)
		move.w	#0,ground_vel(a0)
		move.b	#0,status(a0)

+ ;loc_147C6:
		move.w	#6,(Tails_CPU_routine).w
		move.b	#0,object_control(a0)
		move.w	#0,(Tails_CPU_flight_timer).w
		rts
; ---------------------------------------------------------------------------

Tails_Catch_Up_Flying:
		move.b	(Ctrl_2_held_logical).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask|button_start_mask,d0
		bne.s	+ ;loc_14804
		move.w	(Level_frame_counter).w,d0
		andi.w	#$3F,d0
		bne.w	locret_148A0
		tst.b	object_control(a1)
		bne.w	locret_148A0
		move.b	status(a1),d0
		andi.b	#$92,d0
		bne.w	locret_148A0

+ ;loc_14804:
		move.w	#4,(Tails_CPU_routine).w
		move.w	x_pos(a1),d0
		move.w	d0,x_pos(a0)
		move.w	d0,(Tails_CPU_target_X).w
		move.w	y_pos(a1),d0
		move.w	d0,(Tails_CPU_target_Y).w
		subi.w	#$C0,d0
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

locret_148A0:
		rts
; ---------------------------------------------------------------------------

Tails_FlySwim_Unknown:
		tst.b	render_flags(a0)
		bmi.s	+ ;loc_148E4
		addq.w	#1,(Tails_CPU_flight_timer).w
		cmpi.w	#5*60,(Tails_CPU_flight_timer).w
		blo.s	++ ;loc_148FA
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

+ ;loc_148E4:
		move.b	#(8*60)/2,double_jump_property(a0)
		ori.b	#1<<Status_InAir,status(a0)
		bsr.w	Tails_Set_Flying_Animation
		move.w	#0,(Tails_CPU_flight_timer).w

+ ;loc_148FA:
		lea	(Pos_table).w,a2
		move.w	#$10,d2
		lsl.b	#2,d2
		addq.b	#4,d2
		move.w	(Pos_table_index).w,d3
		sub.b	d2,d3
		move.w	(a2,d3.w),(Tails_CPU_target_X).w
		move.w	2(a2,d3.w),(Tails_CPU_target_Y).w
		bsr.w	Tails_Set_Flying_Animation
		move.w	x_pos(a0),d0
		sub.w	(Tails_CPU_target_X).w,d0
		beq.s	loc_1496C
		move.w	d0,d2
		bpl.s	+ ;loc_1492C
		neg.w	d2

+ ;loc_1492C:
		lsr.w	#4,d2
		cmpi.w	#$C,d2
		blo.s	+ ;loc_14936
		moveq	#$C,d2

+ ;loc_14936:
		move.b	x_vel(a1),d1
		bpl.s	+ ;loc_1493E
		neg.b	d1

+ ;loc_1493E:
		add.b	d1,d2
		addq.w	#1,d2
		tst.w	d0
		bmi.s	++ ;loc_14958
		bset	#Status_Facing,status(a0)
		cmp.w	d0,d2
		blo.s	+ ;loc_14954
		move.w	d0,d2
		moveq	#0,d0

+ ;loc_14954:
		neg.w	d2
		bra.s	++ ;loc_14968
; ---------------------------------------------------------------------------

+ ;loc_14958:
		bclr	#Status_Facing,status(a0)
		neg.w	d0
		cmp.w	d0,d2
		blo.s	+ ;loc_14968
		move.b	d0,d2
		moveq	#0,d0

+ ;loc_14968:
		add.w	d2,x_pos(a0)

loc_1496C:
		moveq	#1,d2
		move.w	y_pos(a0),d1
		sub.w	(Tails_CPU_target_Y).w,d1
		beq.s	++ ;loc_14980
		bmi.s	+ ;loc_1497C
		neg.w	d2

+ ;loc_1497C:
		add.w	d2,y_pos(a0)

+ ;loc_14980:
		lea	(Stat_table).w,a2
		move.b	2(a2,d3.w),d2
		andi.b	#$92,d2
		bne.s	locret_149E6
		or.w	d0,d1
		bne.s	locret_149E6
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
		bpl.s	+ ;loc_149DA
		ori.w	#high_priority,art_tile(a0)

+ ;loc_149DA:
		move.b	top_solid_bit(a1),top_solid_bit(a0)
		move.b	lrb_solid_bit(a1),lrb_solid_bit(a0)

locret_149E6:
		rts
; ---------------------------------------------------------------------------

loc_149E8:
		cmpi.b	#6,(Player_1+routine).w
		blo.s	loc_14A16
		move.w	#4,(Tails_CPU_routine).w
		move.b	#0,spin_dash_flag(a0)
		move.w	#0,spin_dash_counter(a0)
		move.b	#$81,object_control(a0)
		move.b	#1<<Status_InAir,status(a0)
		move.b	#$20,anim(a0)
		rts
; ---------------------------------------------------------------------------

loc_14A16:
		bsr.w	sub_14B8A
		tst.w	(Tails_CPU_idle_timer).w
		bne.w	loc_14B4C
		tst.b	object_control(a0)
		bmi.w	loc_14B4C
		tst.b	status_tertiary(a1)
		bmi.w	loc_14B4C
		tst.w	move_lock(a0)
		beq.s	+ ;loc_14A44
		tst.w	ground_vel(a0)
		bne.s	+ ;loc_14A44
		move.w	#8,(Tails_CPU_routine).w

+ ;loc_14A44:
		lea	(Pos_table).w,a2
		move.w	#$10,d1
		lsl.b	#2,d1
		addq.b	#4,d1
		move.w	(Pos_table_index).w,d0
		sub.b	d1,d0
		move.w	(a2,d0.w),d2
		btst	#Status_OnObj,status(a1)
		bne.s	+ ;loc_14A6E
		cmpi.w	#$400,ground_vel(a1)
		bge.s	+ ;loc_14A6E
		subi.w	#$20,d2

+ ;loc_14A6E:
		move.w	2(a2,d0.w),d3
		lea	(Stat_table).w,a2
		move.w	(a2,d0.w),d1
		move.b	2(a2,d0.w),d4
		move.w	d1,d0
		btst	#Status_Push,status(a0)
		beq.s	+ ;loc_14A90
		btst	#5,d4
		beq.w	loc_14B2A

+ ;loc_14A90:
		sub.w	x_pos(a0),d2
		beq.s	loc_14ADE
		bpl.s	++ ;loc_14ABC
		neg.w	d2
		cmpi.w	#$30,d2
		bcs.s	+ ;loc_14AA8
		andi.w	#$F3F3,d1
		ori.w	#$404,d1

+ ;loc_14AA8:
		tst.w	ground_vel(a0)
		beq.s	+++ ;loc_14AF2
		btst	#Status_Facing,status(a0)
		beq.s	+++ ;loc_14AF2
		subq.w	#1,x_pos(a0)
		bra.s	+++ ;loc_14AF2
; ---------------------------------------------------------------------------

+ ;loc_14ABC:
		cmpi.w	#$30,d2
		blo.s	+ ;loc_14ACA
		andi.w	#$F3F3,d1
		ori.w	#$808,d1

+ ;loc_14ACA:
		tst.w	ground_vel(a0)
		beq.s	+ ;loc_14AF2
		btst	#Status_Facing,status(a0)
		bne.s	+ ;loc_14AF2
		addq.w	#1,x_pos(a0)
		bra.s	+ ;loc_14AF2
; ---------------------------------------------------------------------------

loc_14ADE:
		bclr	#Status_Facing,status(a0)
		move.b	d4,d0
		andi.b	#1,d0
		beq.s	+ ;loc_14AF2
		bset	#Status_Facing,status(a0)

+ ;loc_14AF2:
		tst.b	(Tails_CPU_auto_jump_flag).w
		beq.s	+ ;loc_14B0A
		ori.w	#((button_A_mask|button_B_mask|button_C_mask)<<8)|0,d1
		btst	#Status_InAir,status(a0)
		bne.s	+++ ;loc_14B46
		move.b	#0,(Tails_CPU_auto_jump_flag).w

+ ;loc_14B0A:
		move.w	(Level_frame_counter).w,d0
		andi.w	#$FF,d0
		beq.s	+ ;loc_14B1A
		cmpi.w	#$40,d2
		bhs.s	++ ;loc_14B46

+ ;loc_14B1A:
		sub.w	y_pos(a0),d3
		beq.s	+ ;loc_14B46
		bpl.s	+ ;loc_14B46
		neg.w	d3
		cmpi.w	#$20,d3
		blo.s	+ ;loc_14B46

loc_14B2A:
		move.b	(Level_frame_counter+1).w,d0
		andi.b	#$3F,d0
		bne.s	+ ;loc_14B46
		cmpi.b	#8,anim(a0)
		beq.s	+ ;loc_14B46
		ori.w	#((button_A_mask|button_B_mask|button_C_mask)<<8)|(button_A_mask|button_B_mask|button_C_mask),d1
		move.b	#1,(Tails_CPU_auto_jump_flag).w

+ ;loc_14B46:
		move.w	d1,(Ctrl_2_logical).w
		rts
; ---------------------------------------------------------------------------

loc_14B4C:
		tst.w	(Tails_CPU_idle_timer).w
		beq.s	locret_14B56
		subq.w	#1,(Tails_CPU_idle_timer).w

locret_14B56:
		rts

; =============== S U B R O U T I N E =======================================


sub_14B58:
		move.w	#0,(Tails_CPU_idle_timer).w
		move.w	#0,(Tails_CPU_flight_timer).w
		move.w	#2,(Tails_CPU_routine).w
		move.b	#$81,object_control(a0)
		move.b	#1<<Status_InAir,status(a0)
		move.w	#$7F00,x_pos(a0)
		move.w	#0,y_pos(a0)
		move.b	#0,double_jump_flag(a0)
		rts
; End of function sub_14B58


; =============== S U B R O U T I N E =======================================


sub_14B8A:
		tst.b	render_flags(a0)
		bmi.s	+++ ;loc_14BB6
		btst	#Status_OnObj,status(a0)
		beq.s	+ ;loc_14BA6
		moveq	#0,d0
		movea.w	interact(a0),a3
		move.w	(Tails_CPU_interact).w,d0
		cmp.w	(a3),d0
		bne.s	++ ;loc_14BB2

+ ;loc_14BA6:
		addq.w	#1,(Tails_CPU_flight_timer).w
		cmpi.w	#5*60,(Tails_CPU_flight_timer).w
		blo.s	+++ ;loc_14BBC

+ ;loc_14BB2:
		bra.w	sub_14B58
; ---------------------------------------------------------------------------

+ ;loc_14BB6:
		move.w	#0,(Tails_CPU_flight_timer).w

+ ;loc_14BBC:
		movea.w	interact(a0),a3
		move.w	(a3),(Tails_CPU_interact).w
		rts
; End of function sub_14B8A

; ---------------------------------------------------------------------------

loc_14BC6:
		bsr.w	sub_14B8A
		tst.w	(Tails_CPU_idle_timer).w
		bne.w	locret_14C44
		tst.w	move_lock(a0)
		bne.s	locret_14C44
		tst.b	spin_dash_flag(a0)
		bne.s	++ ;loc_14C1A
		tst.w	ground_vel(a0)
		bne.s	locret_14C44
		bclr	#Status_Facing,status(a0)
		move.w	x_pos(a0),d0
		sub.w	x_pos(a1),d0
		bcs.s	+ ;loc_14BFA
		bset	#Status_Facing,status(a0)

+ ;loc_14BFA:
		move.w	#(button_down_mask<<8)|button_down_mask,(Ctrl_2_logical).w
		move.b	(Level_frame_counter+1).w,d0
		andi.b	#$7F,d0
		beq.s	++ ;loc_14C2A
		cmpi.b	#8,anim(a0)
		bne.s	locret_14C44
		move.w	#((button_A_mask|button_B_mask|button_C_mask|button_down_mask)<<8)|(button_A_mask|button_B_mask|button_C_mask|button_down_mask),(Ctrl_2_logical).w
		rts
; ---------------------------------------------------------------------------

+ ;loc_14C1A:
		move.w	#(button_down_mask<<8)|button_down_mask,(Ctrl_2_logical).w
		move.b	(Level_frame_counter+1).w,d0
		andi.b	#$7F,d0
		bne.s	++ ;loc_14C38

+ ;loc_14C2A:
		move.w	#(0<<8)|0,(Ctrl_2_logical).w
		move.w	#6,(Tails_CPU_routine).w
		rts
; ---------------------------------------------------------------------------

+ ;loc_14C38:
		andi.b	#$1F,d0
		bne.s	locret_14C44
		ori.w	#((button_A_mask|button_B_mask|button_C_mask)<<8)|(button_A_mask|button_B_mask|button_C_mask),(Ctrl_2_logical).w

locret_14C44:
		rts
; ---------------------------------------------------------------------------

locret_14C46:
		rts
; ---------------------------------------------------------------------------

loc_14C48:
		move.b	#1,double_jump_flag(a0)
		move.b	#(8*60)/2,double_jump_property(a0)
		move.b	#1<<Status_InAir,status(a0)
		move.w	#$100,x_vel(a0)
		move.w	#0,y_vel(a0)
		move.w	#0,ground_vel(a0)
		lea	(Player_1).w,a1
		bsr.w	sub_15202
		move.b	#1,(Flying_carrying_Sonic_flag).w
		move.w	#$E,(Tails_CPU_routine).w

loc_14C80:
		move.w	#0,(Tails_CPU_idle_timer).w
		move.w	#0,(Ctrl_2_logical).w
		move.b	(Level_frame_counter+1).w,d0
		andi.b	#$1F,d0
		bne.s	+ ;loc_14C9C
		ori.w	#(button_right_mask<<8)|button_right_mask,(Ctrl_2_logical).w

+ ;loc_14C9C:
		lea	(Flying_carrying_Sonic_flag).w,a2
		lea	(Player_1).w,a1
		btst	#Status_InAir,status(a1)
		bne.s	++ ;loc_14D08
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
		bpl.s	+ ;loc_14CEE
		ori.w	#high_priority,art_tile(a0)

+ ;loc_14CEE:
		move.b	top_solid_bit(a1),top_solid_bit(a0)
		move.b	lrb_solid_bit(a1),lrb_solid_bit(a0)
		cmpi.w	#1,(Player_mode).w
		bne.s	+ ;loc_14D08
		move.w	#$10,(Tails_CPU_routine).w

+ ;loc_14D08:
		move.w	(Ctrl_1).w,d0
		bra.w	Tails_Carry_Sonic
; ---------------------------------------------------------------------------

loc_14D10:
		move.w	#0,(Tails_CPU_idle_timer).w
		move.b	#(8*60)/2,double_jump_property(a0)
		move.w	#(0<<8)|0,(Ctrl_2_logical).w
		move.b	(Level_frame_counter+1).w,d0
		andi.b	#$F,d0
		bne.s	+ ;loc_14D32
		ori.w	#((button_A_mask|button_B_mask|button_C_mask|button_right_mask)<<8)|(button_A_mask|button_B_mask|button_C_mask|button_right_mask),(Ctrl_2_logical).w

+ ;loc_14D32:
		tst.b	render_flags(a0)
		bmi.s	locret_14D4A
		move.w	#$7F00,x_pos(a0)
		move.w	#0,y_pos(a0)
		move.w	#$A,(Tails_CPU_routine).w

locret_14D4A:
		rts
; ---------------------------------------------------------------------------

loc_14D4C:
		move.w	#(0<<8)|0,(Ctrl_2_logical).w
		rts
; ---------------------------------------------------------------------------

loc_14D54:
		move.b	#1,double_jump_flag(a0)
		move.b	#(8*60)/2,double_jump_property(a0)
		move.b	#1<<Status_InAir,status(a0)
		move.w	#0,x_vel(a0)
		move.w	#0,y_vel(a0)
		move.w	#0,ground_vel(a0)
		lea	(Player_1).w,a1
		bsr.w	sub_15202
		move.b	#1,(Flying_carrying_Sonic_flag).w
		move.w	#$16,(Tails_CPU_routine).w

loc_14D8C:
		move.w	#0,(Tails_CPU_idle_timer).w
		move.b	#(8*60)/2,double_jump_property(a0)
		move.w	#0,(Ctrl_2_logical).w
		move.b	(Level_frame_counter+1).w,d0
		andi.b	#7,d0
		bne.s	loc_14DAE
		ori.w	#((button_A_mask|button_B_mask|button_C_mask)<<8)|(button_A_mask|button_B_mask|button_C_mask),(Ctrl_2_logical).w

loc_14DAE:
		move.w	(Camera_Y_pos).w,d0
		addi.w	#$90,d0
		cmp.w	y_pos(a0),d0
		blo.s	+ ;loc_14DC2
		move.w	#$18,(Tails_CPU_routine).w

+ ;loc_14DC2:
		lea	(Flying_carrying_Sonic_flag).w,a2
		lea	(Player_1).w,a1
		move.w	(Ctrl_1).w,d0
		bra.w	Tails_Carry_Sonic
; ---------------------------------------------------------------------------

loc_14DD2:
		move.b	#(8*60)/2,double_jump_property(a0)
		tst.w	(Tails_CPU_idle_timer).w
		beq.s	+ ;loc_14DEA
		tst.b	(Flying_carrying_Sonic_flag).w
		bne.w	loc_14E68
		bra.w	loc_14F68
; ---------------------------------------------------------------------------

+ ;loc_14DEA:
		move.w	#(0<<8)|0,(Ctrl_2_logical).w
		tst.b	(Flying_carrying_Sonic_flag).w
		beq.w	loc_14F68
		clr.b	(_unkFAAC).w
		btst	#button_down,(Ctrl_1_held).w
		beq.s	+ ;loc_14E1E
		addq.b	#1,(Tails_CPU_auto_fly_timer).w
		cmpi.b	#$C0,(Tails_CPU_auto_fly_timer).w
		blo.s	+++ ;loc_14E58
		move.b	#0,(Tails_CPU_auto_fly_timer).w
		ori.w	#((button_A_mask|button_B_mask|button_C_mask)<<8)|(button_A_mask|button_B_mask|button_C_mask),(Ctrl_2_logical).w
		bra.s	+++ ;loc_14E58
; ---------------------------------------------------------------------------

+ ;loc_14E1E:
		btst	#button_up,(Ctrl_1_held).w
		beq.s	+ ;loc_14E40
		addq.b	#1,(Tails_CPU_auto_fly_timer).w
		cmpi.b	#$20,(Tails_CPU_auto_fly_timer).w
		blo.s	++ ;loc_14E58
		move.b	#0,(Tails_CPU_auto_fly_timer).w
		ori.w	#((button_A_mask|button_B_mask|button_C_mask)<<8)|(button_A_mask|button_B_mask|button_C_mask),(Ctrl_2_logical).w
		bra.s	++ ;loc_14E58
; ---------------------------------------------------------------------------

+ ;loc_14E40:
		addq.b	#1,(Tails_CPU_auto_fly_timer).w
		cmpi.b	#$58,(Tails_CPU_auto_fly_timer).w
		bcs.s	+ ;loc_14E58
		move.b	#0,(Tails_CPU_auto_fly_timer).w
		ori.w	#((button_A_mask|button_B_mask|button_C_mask)<<8)|(button_A_mask|button_B_mask|button_C_mask),(Ctrl_2_logical).w

+ ;loc_14E58:
		move.b	(Ctrl_1_held).w,d0
		andi.b	#button_left_mask|button_right_mask,d0
		or.b	(Ctrl_2_held_logical).w,d0
		move.b	d0,(Ctrl_2_logical).w

loc_14E68:
		lea	(Flying_carrying_Sonic_flag).w,a2
		lea	(Player_1).w,a1
		move.w	(Ctrl_1).w,d0
		bra.w	Tails_Carry_Sonic
; ---------------------------------------------------------------------------

loc_14E78:
		move.b	#1,double_jump_flag(a0)
		move.b	#(8*60)/2,double_jump_property(a0)
		move.b	#1<<Status_InAir,status(a0)
		move.w	#0,x_vel(a0)
		move.w	#0,y_vel(a0)
		move.w	#0,ground_vel(a0)
		move.w	#$1C,(Tails_CPU_routine).w

loc_14EA2:
		move.w	#0,(Tails_CPU_idle_timer).w
		move.b	#(8*60)/2,double_jump_property(a0)
		move.w	#0,(Ctrl_2_logical).w
		move.b	(Level_frame_counter+1).w,d0
		andi.b	#7,d0
		bne.s	+ ;loc_14EC4
		ori.w	#((button_A_mask|button_B_mask|button_C_mask)<<8)|(button_A_mask|button_B_mask|button_C_mask),(Ctrl_2_logical).w

+ ;loc_14EC4:
		move.w	(Camera_Y_pos).w,d0
		addi.w	#$90,d0
		cmp.w	y_pos(a0),d0
		blo.s	locret_14ED8
		move.w	#$1E,(Tails_CPU_routine).w

locret_14ED8:
		rts
; ---------------------------------------------------------------------------

loc_14EDA:
		move.b	#(8*60)/2,double_jump_property(a0)
		rts
; ---------------------------------------------------------------------------

loc_14EE2:
		move.b	#1,double_jump_flag(a0)
		move.b	#(8*60)/2,double_jump_property(a0)
		move.b	#2,status(a0)
		move.w	#$100,x_vel(a0)
		move.w	#0,y_vel(a0)
		move.w	#0,ground_vel(a0)
		move.w	#$22,(Tails_CPU_routine).w

loc_14F0C:
		move.w	#0,(Tails_CPU_idle_timer).w
		move.w	#(0<<8)|0,(Ctrl_2_logical).w
		move.b	(Level_frame_counter+1).w,d0
		andi.b	#$1F,d0
		bne.s	+ ;loc_14F28
		ori.w	#(button_right_mask<<8)|button_right_mask,(Ctrl_2_logical).w

+ ;loc_14F28:
		btst	#Status_InAir,status(a0)
		bne.s	locret_14F66
		move.w	#6,(Tails_CPU_routine).w
		move.b	#0,object_control(a0)
		move.b	#0,anim(a0)
		move.w	#0,x_vel(a0)
		move.w	#0,y_vel(a0)
		move.w	#0,ground_vel(a0)
		move.b	#1<<Status_InAir,status(a0)
		move.w	#0,move_lock(a0)
		andi.w	#drawing_mask,art_tile(a0)

locret_14F66:
		rts
; ---------------------------------------------------------------------------

loc_14F68:
		tst.b	(_unkFAAC).w
		bne.s	loc_14FE8
		lea	(Player_1).w,a1
		tst.b	render_flags(a1)
		bpl.s	loc_14FB6
		tst.w	(Tails_CPU_idle_timer).w
		bne.w	loc_15030
		cmpi.w	#$300,y_vel(a1)
		bge.s	loc_14FB6
		move.w	#0,x_vel(a0)
		move.w	#(0<<8)|0,(Ctrl_2_logical).w
		cmpi.w	#$200,y_vel(a0)
		bge.s	loc_14FAE
		addq.b	#1,(Tails_CPU_auto_fly_timer).w
		cmpi.b	#$58,(Tails_CPU_auto_fly_timer).w
		blo.s	loc_14FB4
		move.b	#0,(Tails_CPU_auto_fly_timer).w

loc_14FAE:
		ori.w	#((button_A_mask|button_B_mask|button_C_mask)<<8)|(button_A_mask|button_B_mask|button_C_mask),(Ctrl_2_logical).w

loc_14FB4:
		bra.s	loc_15030
; ---------------------------------------------------------------------------

loc_14FB6:
		st	(_unkFAAC).w
		move.w	y_pos(a1),d1
		sub.w	y_pos(a0),d1
		bpl.s	+ ;loc_14FC6
		neg.w	d1

+ ;loc_14FC6:
		lsr.w	#2,d1
		move.w	d1,d2
		lsr.w	#1,d2
		add.w	d2,d1
		move.w	d1,(Camera_stored_min_X_pos).w
		move.w	x_pos(a1),d1
		sub.w	x_pos(a0),d1
		bpl.s	+ ;loc_14FDE
		neg.w	d1

+ ;loc_14FDE:
		lsr.w	#2,d1
		move.w	d1,(Camera_stored_max_X_pos).w
		bra.w	loc_15030
; ---------------------------------------------------------------------------

loc_14FE8:
		move.w	#(0<<8)|0,(Ctrl_2_logical).w
		lea	(Player_1).w,a1
		move.w	x_pos(a0),d0
		move.w	y_pos(a0),d1
		subi.w	#$10,d1
		move.w	(Camera_stored_max_X_pos).w,d2
		bclr	#Status_Facing,status(a0)
		cmp.w	x_pos(a1),d0
		blo.s	+ ;loc_15016
		bset	#Status_Facing,status(a0)
		neg.w	d2

+ ;loc_15016:
		add.w	d2,x_vel(a0)
		cmp.w	y_pos(a1),d1
		bhs.s	loc_15030
		move.w	(Camera_stored_min_X_pos).w,d2
		cmp.w	y_pos(a1),d1
		blo.s	+ ;loc_1502C
		neg.w	d2

+ ;loc_1502C:
		add.w	d2,y_vel(a0)

loc_15030:
		lea	(Flying_carrying_Sonic_flag).w,a2
		lea	(Player_1).w,a1
		move.w	(Ctrl_1).w,d0
		bra.w	Tails_Carry_Sonic

; =============== S U B R O U T I N E =======================================


Tails_Carry_Sonic:
		tst.b	(a2)
		beq.w	loc_151A2
		cmpi.b	#4,routine(a1)
		bhs.w	loc_150EC
		btst	#Status_InAir,status(a1)
		beq.w	loc_150E0
		move.w	(_unkF744).w,d1
		cmp.w	x_vel(a1),d1
		bne.s	loc_150E0
		move.w	(_unkF74C).w,d1
		cmp.w	y_vel(a1),d1
		bne.s	loc_150E6
		tst.b	object_control(a1)
		bmi.s	loc_150F0
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0
		beq.w	loc_150FA
		clr.b	object_control(a1)
		clr.b	(a2)
		move.b	#$12,1(a2)
		andi.w	#(button_up_mask|button_down_mask|button_left_mask|button_right_mask)<<8,d0
		beq.w	loc_15096
		move.b	#$3C,1(a2)

loc_15096:
		btst	#button_left+8,d0
		beq.s	+ ;loc_150A2
		move.w	#-$200,x_vel(a1)

+ ;loc_150A2:
		btst	#button_right+8,d0
		beq.s	+ ;loc_150AE
		move.w	#$200,x_vel(a1)

+ ;loc_150AE:
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

loc_150E0:
		move.w	#-$100,y_vel(a1)

loc_150E6:
		move.b	#0,jumping(a1)

loc_150EC:
		clr.b	object_control(a1)

loc_150F0:
		clr.b	(a2)
		move.b	#$3C,1(a2)
		rts
; ---------------------------------------------------------------------------

loc_150FA:
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		addi.w	#$1C,y_pos(a1)
		andi.b	#$FC,render_flags(a1)
		andi.b	#$FE,status(a1)
		move.b	status(a0),d0
		andi.b	#1,d0
		or.b	d0,render_flags(a1)
		or.b	d0,status(a1)
		subq.b	#1,anim_frame_timer(a1)
		bpl.s	++ ;loc_15166
		move.b	#$B,anim_frame_timer(a1)
		moveq	#0,d1
		move.b	anim_frame(a1),d1
		addq.b	#1,anim_frame(a1)
		move.b	AniRaw_Tails_Carry(pc,d1.w),d0
		cmpi.b	#-1,d0
		bne.s	+ ;loc_15152
		move.b	#0,anim_frame(a1)
		move.b	AniRaw_Tails_Carry(pc),d0

+ ;loc_15152:
		move.b	d0,mapping_frame(a1)
		moveq	#0,d0
		move.b	mapping_frame(a1),d0
		move.l	a2,-(sp)
		jsr	(Perform_Player_DPLC).l
		movea.l	(sp)+,a2

+ ;loc_15166:
		move.w	x_vel(a0),(Player_1+x_vel).w
		move.w	x_vel(a0),(_unkF744).w
		move.w	y_vel(a0),(Player_1+y_vel).w
		move.w	y_vel(a0),(_unkF74C).w
		movem.l	d0-a6,-(sp)
		lea	(Player_1).w,a0
		bsr.w	Sonic_DoLevelCollision
		movem.l	(sp)+,d0-a6
		rts
; ---------------------------------------------------------------------------
AniRaw_Tails_Carry:
		dc.b  $91, $91, $90, $90, $90, $90, $90, $90, $92, $92, $92, $92, $92, $92, $91, $91, $FF
		even
; ---------------------------------------------------------------------------

loc_151A2:
		tst.b	1(a2)
		beq.s	+ ;loc_151B0
		subq.b	#1,1(a2)
		bne.w	locret_15200

+ ;loc_151B0:
		move.w	x_pos(a1),d0
		sub.w	x_pos(a0),d0
		addi.w	#$10,d0
		cmpi.w	#$20,d0
		bhs.w	locret_15200
		move.w	y_pos(a1),d1
		sub.w	y_pos(a0),d1
		subi.w	#$20,d1
		cmpi.w	#$10,d1
		bhs.w	locret_15200
		tst.b	object_control(a1)
		bne.s	locret_15200
		cmpi.b	#4,routine(a1)
		bhs.s	locret_15200
		tst.w	(Debug_placement_mode).w
		bne.s	locret_15200
		tst.b	spin_dash_flag(a1)
		bne.s	locret_15200
		bsr.s	sub_15202
		moveq	#signextendB(sfx_Grab),d0
		jsr	(Play_SFX).l
		move.b	#1,(a2)

locret_15200:
		rts
; End of function Tails_Carry_Sonic


; =============== S U B R O U T I N E =======================================


sub_15202:
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
		rts
; End of function sub_15202


; =============== S U B R O U T I N E =======================================


Tails_Water:
		tst.b	(Water_flag).w
		bne.s	+ ;loc_1528C

locret_1528A:
		rts
; ---------------------------------------------------------------------------

+ ;loc_1528C:
		move.w	(Water_level).w,d0
		cmp.w	y_pos(a0),d0
		bge.s	++ ;loc_152F6
		bset	#Status_Underwater,status(a0)
		bne.s	locret_1528A
		addq.b	#1,(Water_entered_counter).w
		movea.l	a0,a1
		bsr.w	Player_ResetAirTimer
		move.l	#Obj_AirCountdown,(Breathing_bubbles_P2).w
		move.b	#$81,(Breathing_bubbles_P2+subtype).w
		move.l	a0,(Breathing_bubbles_P2+$40).w
		move.w	#$300,Max_speed-Max_speed(a4)
		move.w	#6,Acceleration-Max_speed(a4)
		move.w	#$40,Deceleration-Max_speed(a4)
		cmpi.w	#4,(Tails_CPU_routine).w
		beq.s	+ ;loc_152D8
		tst.b	object_control(a0)
		bne.s	locret_1528A

+ ;loc_152D8:
		asr	x_vel(a0)
		asr	y_vel(a0)
		asr	y_vel(a0)
		beq.s	locret_1528A
		move.w	#1<<8,anim(a6)	; and prev_anim
		move.w	#sfx_Splash,d0
		jmp	(Play_SFX).l
; ---------------------------------------------------------------------------

+ ;loc_152F6:
		bclr	#Status_Underwater,status(a0)
		beq.s	locret_1528A
		addq.b	#1,(Water_entered_counter).w
		movea.l	a0,a1
		bsr.w	Player_ResetAirTimer
		move.w	#$600,Max_speed-Max_speed(a4)
		move.w	#$C,Acceleration-Max_speed(a4)
		move.w	#$80,Deceleration-Max_speed(a4)
		cmpi.b	#4,routine(a0)
		beq.s	++ ;loc_1533C
		cmpi.w	#4,(Tails_CPU_routine).w
		beq.s	+ ;loc_1532E
		tst.b	object_control(a0)
		bne.s	++ ;loc_1533C

+ ;loc_1532E:
		move.w	y_vel(a0),d0
		cmpi.w	#-$400,d0
		blt.s	+ ;loc_1533C
		asl	y_vel(a0)

+ ;loc_1533C:
		cmpi.b	#$1C,anim(a0)
		beq.w	locret_1528A
		tst.w	y_vel(a0)
		beq.w	locret_1528A
		move.w	#1<<8,anim(a6)	; and prev_anim
		cmpi.w	#-$1000,y_vel(a0)
		bgt.s	+ ;loc_15362
		move.w	#-$1000,y_vel(a0)

+ ;loc_15362:
		move.w	#sfx_Splash,d0
		jmp	(Play_SFX).l
; End of function Tails_Water

; ---------------------------------------------------------------------------

Tails_Stand_Path:
		tst.b	(Flying_carrying_Sonic_flag).w
		beq.s	+ ;loc_15384
		lea	(Player_1).w,a1
		clr.b	object_control(a1)
		bset	#Status_InAir,status(a1)
		clr.w	(Flying_carrying_Sonic_flag).w

+ ;loc_15384:
		bsr.w	Tails_Spindash
		bsr.w	Tails_Jump
		bsr.w	Tails_SlopeResist
		bsr.w	Tails_InputAcceleration_Path
		bsr.w	Tails_Roll
		bsr.w	Tails_Check_Screen_Boundaries
		jsr	(MoveSprite2).l
		bsr.w	Player_AnglePos
		bsr.w	Tails_SlopeRepel
		tst.b	(Background_collision_flag).w
		beq.s	locret_153CE
		bsr.w	sub_10BA2
		tst.w	d1
		bmi.w	Kill_Character
		movem.l	a4-a6,-(sp)
		bsr.w	CheckLeftWallDist
		movem.l	(sp)+,a4-a6
		tst.w	d1
		bpl.s	locret_153CE
		sub.w	d1,x_pos(a0)

locret_153CE:
		rts
; ---------------------------------------------------------------------------

Tails_Stand_Freespace:
		tst.b	double_jump_flag(a0)
		bne.s	Tails_FlyingSwimming
		bsr.w	Tails_JumpHeight
		bsr.w	Tails_InputAcceleration_Freespace
		bsr.w	Tails_Check_Screen_Boundaries
		jsr	(MoveSprite).l
		btst	#Status_Underwater,status(a0)
		beq.s	+ ;loc_153F6
		subi.w	#$28,y_vel(a0)

+ ;loc_153F6:
		bsr.w	Tails_JumpAngle
		bsr.w	Tails_DoLevelCollision
		rts
; ---------------------------------------------------------------------------

Tails_FlyingSwimming:
		bsr.w	Tails_Move_FlySwim
		bsr.w	Tails_InputAcceleration_Freespace
		bsr.w	Tails_Check_Screen_Boundaries
		jsr	(MoveSprite2).l
		bsr.w	Tails_JumpAngle
		movem.l	a4-a6,-(sp)
		bsr.w	Tails_DoLevelCollision
		movem.l	(sp)+,a4-a6
		tst.w	(Player_mode).w
		bne.s	locret_15438
		lea	(Flying_carrying_Sonic_flag).w,a2
		lea	(Player_1).w,a1
		move.w	(Ctrl_1).w,d0
		bsr.w	Tails_Carry_Sonic

locret_15438:
		rts

; =============== S U B R O U T I N E =======================================


Tails_Move_FlySwim:
		move.b	(Level_frame_counter+1).w,d0
		andi.b	#1,d0
		beq.s	+ ;loc_1544E
		tst.b	double_jump_property(a0)
		beq.s	+ ;loc_1544E
		subq.b	#1,double_jump_property(a0)

+ ;loc_1544E:
		cmpi.b	#1,double_jump_flag(a0)
		beq.s	+++ ;loc_15478
		cmpi.w	#-$100,y_vel(a0)
		blt.s	+ ;loc_15470
		subi.w	#$20,y_vel(a0)
		addq.b	#1,double_jump_flag(a0)
		cmpi.b	#$20,double_jump_flag(a0)
		bne.s	++ ;loc_15476

+ ;loc_15470:
		move.b	#1,double_jump_flag(a0)

+ ;loc_15476:
		bra.s	loc_154AA
; ---------------------------------------------------------------------------

+ ;loc_15478:
		move.b	(Ctrl_2_pressed_logical).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0
		beq.s	++ ;loc_154A4
		cmpi.w	#-$100,y_vel(a0)
		blt.s	++ ;loc_154A4
		tst.b	double_jump_property(a0)
		beq.s	++ ;loc_154A4
		btst	#Status_Underwater,status(a0)
		beq.s	+ ;loc_1549E
		tst.b	(Flying_carrying_Sonic_flag).w
		bne.s	++ ;loc_154A4

+ ;loc_1549E:
		move.b	#2,double_jump_flag(a0)

+ ;loc_154A4:
		addi.w	#8,y_vel(a0)

loc_154AA:
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
		bne.s	loc_1552C
		moveq	#$20,d0
		tst.w	(Competition_mode).w
		bne.s	+++ ;loc_1550C
		tst.w	y_vel(a0)
		bpl.s	+ ;loc_154DC
		moveq	#$21,d0

+ ;loc_154DC:
		tst.b	(Flying_carrying_Sonic_flag).w
		beq.s	+ ;loc_154E4
		addq.b	#2,d0

+ ;loc_154E4:
		tst.b	double_jump_property(a0)
		bne.s	+ ;loc_1550C
		moveq	#$24,d0
		move.b	d0,anim(a0)
		tst.b	render_flags(a0)
		bpl.s	locret_1550A
		move.b	(Level_frame_counter+1).w,d0
		addq.b	#8,d0
		andi.b	#$F,d0
		bne.s	locret_1550A
		moveq	#signextendB(sfx_FlyTired),d0
		jsr	(Play_SFX).l

locret_1550A:
		rts
; ---------------------------------------------------------------------------

+ ;loc_1550C:
		move.b	d0,anim(a0)
		tst.b	render_flags(a0)
		bpl.s	locret_1552A
		move.b	(Level_frame_counter+1).w,d0
		addq.b	#8,d0
		andi.b	#$F,d0
		bne.s	locret_1552A
		moveq	#signextendB(sfx_Flying),d0
		jsr	(Play_SFX).l

locret_1552A:
		rts
; ---------------------------------------------------------------------------

loc_1552C:
		moveq	#$25,d0
		tst.w	y_vel(a0)
		bpl.s	+ ;loc_15536
		moveq	#$26,d0

+ ;loc_15536:
		tst.b	(Flying_carrying_Sonic_flag).w
		beq.s	+ ;loc_1553E
		moveq	#$27,d0

+ ;loc_1553E:
		tst.b	double_jump_property(a0)
		bne.s	+ ;loc_15546
		moveq	#$28,d0

+ ;loc_15546:
		move.b	d0,anim(a0)
		rts
; End of function Tails_Set_Flying_Animation

; ---------------------------------------------------------------------------

Tails_Spin_Path:
		tst.b	(Flying_carrying_Sonic_flag).w
		beq.s	+ ;loc_15564
		lea	(Player_1).w,a1
		clr.b	object_control(a1)
		bset	#1,status(a1)
		clr.w	(Flying_carrying_Sonic_flag).w

+ ;loc_15564:
		tst.b	spin_dash_flag(a0)
		bne.s	+ ;loc_1556E
		bsr.w	Tails_Jump

+ ;loc_1556E:
		bsr.w	Tails_RollRepel
		bsr.w	Tails_RollSpeed
		bsr.w	Tails_Check_Screen_Boundaries
		jsr	(MoveSprite2).l
		bsr.w	Player_AnglePos
		bsr.w	Tails_SlopeRepel
		tst.b	(Background_collision_flag).w
		beq.s	locret_155AC
		bsr.w	sub_10BA2
		tst.w	d1
		bmi.w	Kill_Character
		movem.l	a4-a6,-(sp)
		bsr.w	CheckLeftWallDist
		movem.l	(sp)+,a4-a6
		tst.w	d1
		bpl.s	locret_155AC
		sub.w	d1,x_pos(a0)

locret_155AC:
		rts
; ---------------------------------------------------------------------------

Tails_Spin_Freespace:
		tst.b	(Flying_carrying_Sonic_flag).w
		beq.s	+ ;loc_155C6
		lea	(Player_1).w,a1
		clr.b	object_control(a1)
		bset	#Status_InAir,status(a1)
		clr.w	(Flying_carrying_Sonic_flag).w

+ ;loc_155C6:
		bsr.w	Tails_JumpHeight
		bsr.w	Tails_InputAcceleration_Freespace
		bsr.w	Tails_Check_Screen_Boundaries
		jsr	(MoveSprite).l
		btst	#Status_Underwater,status(a0)
		beq.s	+ ;loc_155E6
		subi.w	#$28,y_vel(a0)

+ ;loc_155E6:
		bsr.w	Tails_JumpAngle
		bsr.w	Tails_DoLevelCollision
		rts

; =============== S U B R O U T I N E =======================================


Tails_InputAcceleration_Path:
		move.w	Max_speed_P2-Max_speed_P2(a4),d6
		move.w	Acceleration_P2-Max_speed_P2(a4),d5
		move.w	Deceleration_P2-Max_speed_P2(a4),d4
		tst.b	status_secondary(a0)
		bmi.w	loc_1573C
		tst.w	move_lock(a0)
		bne.w	loc_156FE
		btst	#button_left,(Ctrl_2_held_logical).w
		beq.s	+ ;loc_15616
		bsr.w	sub_157E6

+ ;loc_15616:
		btst	#button_right,(Ctrl_2_held_logical).w
		beq.s	+ ;loc_15622
		bsr.w	sub_15872

+ ;loc_15622:
		move.b	angle(a0),d0
		addi.b	#$20,d0
		andi.b	#$C0,d0
		bne.w	loc_156FE
		tst.w	ground_vel(a0)
		bne.w	loc_156FE
		bclr	#Status_Push,status(a0)
		move.b	#5,anim(a0)
		btst	#Status_OnObj,status(a0)
		beq.s	loc_15678
		movea.w	interact(a0),a1
		tst.b	status(a1)
		bmi.s	loc_156AA
		moveq	#0,d1
		move.b	width_pixels(a1),d1
		move.w	d1,d2
		add.w	d2,d2
		subq.w	#4,d2
		add.w	x_pos(a0),d1
		sub.w	x_pos(a1),d1
		cmpi.w	#4,d1
		blt.s	loc_1569C
		cmp.w	d2,d1
		bge.s	loc_1568C
		bra.s	loc_156AA
; ---------------------------------------------------------------------------

loc_15678:
		jsr	(ChkFloorEdge).l
		cmpi.w	#$C,d1
		blt.s	loc_156AA
		cmpi.b	#3,next_tilt(a0)
		bne.s	+ ;loc_15694

loc_1568C:
		bclr	#Status_Facing,status(a0)
		bra.s	++ ;loc_156A2
; ---------------------------------------------------------------------------

+ ;loc_15694:
		cmpi.b	#3,tilt(a0)
		bne.s	loc_156AA

loc_1569C:
		bset	#Status_Facing,status(a0)

+ ;loc_156A2:
		move.b	#6,anim(a0)
		bra.s	loc_156FE
; ---------------------------------------------------------------------------

loc_156AA:
		btst	#button_up,(Ctrl_2_held_logical).w
		beq.s	+ ;loc_156D4
		move.b	#7,anim(a0)
		addq.b	#1,scroll_delay_counter(a0)
		cmpi.b	#2*60,scroll_delay_counter(a0)
		blo.s	loc_15704
		move.b	#2*60,scroll_delay_counter(a0)
		cmpi.w	#$C8,(a5)
		beq.s	loc_15710
		addq.w	#2,(a5)
		bra.s	loc_15710
; ---------------------------------------------------------------------------

+ ;loc_156D4:
		btst	#button_down,(Ctrl_2_held_logical).w
		beq.s	loc_156FE
		move.b	#8,anim(a0)
		addq.b	#1,scroll_delay_counter(a0)
		cmpi.b	#2*60,scroll_delay_counter(a0)
		blo.s	loc_15704
		move.b	#2*60,scroll_delay_counter(a0)
		cmpi.w	#8,(a5)
		beq.s	loc_15710
		subq.w	#2,(a5)
		bra.s	loc_15710
; ---------------------------------------------------------------------------

loc_156FE:
		move.b	#0,scroll_delay_counter(a0)

loc_15704:
		cmpi.w	#$60,(a5)
		beq.s	loc_15710
		bcc.s	+ ;loc_1570E
		addq.w	#4,(a5)

+ ;loc_1570E:
		subq.w	#2,(a5)

loc_15710:
		move.b	(Ctrl_2_held_logical).w,d0
		andi.b	#button_left_mask|button_right_mask,d0
		bne.s	loc_1573C
		move.w	ground_vel(a0),d0
		beq.s	loc_1573C
		bmi.s	++ ;loc_15730
		sub.w	d5,d0
		bcc.s	+ ;loc_1572A
		move.w	#0,d0

+ ;loc_1572A:
		move.w	d0,ground_vel(a0)
		bra.s	loc_1573C
; ---------------------------------------------------------------------------

+ ;loc_15730:
		add.w	d5,d0
		bcc.s	+ ;loc_15738
		move.w	#0,d0

+ ;loc_15738:
		move.w	d0,ground_vel(a0)

loc_1573C:
		move.b	angle(a0),d0
		jsr	(GetSineCosine).l
		muls.w	ground_vel(a0),d1
		asr.l	#8,d1
		move.w	d1,x_vel(a0)
		muls.w	ground_vel(a0),d0
		asr.l	#8,d0
		move.w	d0,y_vel(a0)

loc_1575A:
		btst	#6,object_control(a0)
		bne.w	locret_157E4
		move.b	angle(a0),d0
		addi.b	#$40,d0
		bmi.s	locret_157E4
		move.b	#$40,d1
		tst.w	ground_vel(a0)
		beq.s	locret_157E4
		bmi.s	+ ;loc_1577C
		neg.w	d1

+ ;loc_1577C:
		move.b	angle(a0),d0
		add.b	d1,d0
		move.w	d0,-(sp)
		bsr.w	sub_10980
		move.w	(sp)+,d0
		tst.w	d1
		bpl.s	locret_157E4
		asl.w	#8,d1
		addi.b	#$20,d0
		andi.b	#$C0,d0
		beq.s	+++ ;loc_157E0
		cmpi.b	#$40,d0
		beq.s	++ ;loc_157C6
		cmpi.b	#$80,d0
		beq.s	+ ;loc_157C0
		add.w	d1,x_vel(a0)
		move.w	#0,ground_vel(a0)
		btst	#Status_Facing,status(a0)
		bne.s	locret_157BE
		bset	#Status_Push,status(a0)

locret_157BE:
		rts
; ---------------------------------------------------------------------------

+ ;loc_157C0:
		sub.w	d1,y_vel(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_157C6:
		sub.w	d1,x_vel(a0)
		move.w	#0,ground_vel(a0)
		btst	#Status_Facing,status(a0)
		beq.s	locret_157BE
		bset	#Status_Push,status(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_157E0:
		add.w	d1,y_vel(a0)

locret_157E4:
		rts
; End of function Tails_InputAcceleration_Path


; =============== S U B R O U T I N E =======================================


sub_157E6:
		move.w	ground_vel(a0),d0
		beq.s	+ ;loc_157EE
		bpl.s	loc_15820

+ ;loc_157EE:
		bset	#Status_Facing,status(a0)
		bne.s	+ ;loc_15802
		bclr	#Status_Push,status(a0)
		move.b	#1,prev_anim(a0)

+ ;loc_15802:
		sub.w	d5,d0
		move.w	d6,d1
		neg.w	d1
		cmp.w	d1,d0
		bgt.s	+ ;loc_15814
		add.w	d5,d0
		cmp.w	d1,d0
		ble.s	+ ;loc_15814
		move.w	d1,d0

+ ;loc_15814:
		move.w	d0,ground_vel(a0)
		move.b	#0,anim(a0)
		rts
; ---------------------------------------------------------------------------

loc_15820:
		sub.w	d4,d0
		bcc.s	+ ;loc_15828
		move.w	#-$80,d0

+ ;loc_15828:
		move.w	d0,ground_vel(a0)
		move.b	angle(a0),d0
		addi.b	#$20,d0
		andi.b	#$C0,d0
		bne.s	locret_15870
		cmpi.w	#$400,d0
		blt.s	locret_15870
		tst.b	flip_type(a0)
		bmi.s	locret_15870
		move.w	#sfx_Skid,d0
		jsr	(Play_SFX).l
		move.b	#$D,anim(a0)
		bclr	#Status_Facing,status(a0)
		cmpi.b	#12,air_left(a0)
		blo.s	locret_15870
		move.b	#6,routine(a6)
		move.b	#$15,mapping_frame(a6)

locret_15870:
		rts
; End of function sub_157E6


; =============== S U B R O U T I N E =======================================


sub_15872:
		move.w	ground_vel(a0),d0
		bmi.s	+++ ;loc_158A6
		bclr	#Status_Facing,status(a0)
		beq.s	+ ;loc_1588C
		bclr	#Status_Push,status(a0)
		move.b	#1,prev_anim(a0)

+ ;loc_1588C:
		add.w	d5,d0
		cmp.w	d6,d0
		blt.s	+ ;loc_1589A
		sub.w	d5,d0
		cmp.w	d6,d0
		bge.s	+ ;loc_1589A
		move.w	d6,d0

+ ;loc_1589A:
		move.w	d0,ground_vel(a0)
		move.b	#0,anim(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_158A6:
		add.w	d4,d0
		bcc.s	+ ;loc_158AE
		move.w	#$80,d0

+ ;loc_158AE:
		move.w	d0,ground_vel(a0)
		move.b	angle(a0),d0
		addi.b	#$20,d0
		andi.b	#$C0,d0
		bne.s	locret_158F6
		cmpi.w	#-$400,d0
		bgt.s	locret_158F6
		tst.b	flip_type(a0)
		bmi.s	locret_158F6
		move.w	#sfx_Skid,d0
		jsr	(Play_SFX).l
		move.b	#$D,anim(a0)
		bset	#Status_Facing,status(a0)
		cmpi.b	#12,air_left(a0)
		blo.s	locret_158F6
		move.b	#6,routine(a6)
		move.b	#$15,mapping_frame(a6)

locret_158F6:
		rts
; End of function sub_15872


; =============== S U B R O U T I N E =======================================


Tails_RollSpeed:
		move.w	Max_speed_P2-Max_speed_P2(a4),d6
		asl.w	#1,d6
		move.w	Acceleration_P2-Max_speed_P2(a4),d5
		asr.w	#1,d5
		move.w	Deceleration_P2-Max_speed_P2(a4),d4
		asr.w	#2,d4
		tst.b	spin_dash_flag(a0)
		bmi.w	loc_1599E
		tst.b	status_secondary(a0)
		bmi.w	loc_1599E
		tst.w	move_lock(a0)
		bne.s	++ ;loc_15936
		btst	#button_left,(Ctrl_2_held_logical).w
		beq.s	+ ;loc_1592A
		bsr.w	sub_159E0

+ ;loc_1592A:
		btst	#button_right,(Ctrl_2_held_logical).w
		beq.s	+ ;loc_15936
		bsr.w	sub_15A04

+ ;loc_15936:
		move.w	ground_vel(a0),d0
		beq.s	loc_15958
		bmi.s	++ ;loc_1594C
		sub.w	d5,d0
		bcc.s	+ ;loc_15946
		move.w	#0,d0

+ ;loc_15946:
		move.w	d0,ground_vel(a0)
		bra.s	loc_15958
; ---------------------------------------------------------------------------

+ ;loc_1594C:
		add.w	d5,d0
		bcc.s	+ ;loc_15954
		move.w	#0,d0

+ ;loc_15954:
		move.w	d0,ground_vel(a0)

loc_15958:
		tst.w	ground_vel(a0)
		bne.s	loc_1599E
		tst.b	spin_dash_flag(a0)
		bne.s	+ ;loc_1598C
		bclr	#Status_Roll,status(a0)
		move.b	y_radius(a0),d0
		move.b	default_y_radius(a0),y_radius(a0)
		move.b	default_x_radius(a0),x_radius(a0)
		move.b	#5,anim(a0)
		sub.b	default_y_radius(a0),d0
		ext.w	d0
		add.w	d0,y_pos(a0)
		bra.s	loc_1599E
; ---------------------------------------------------------------------------

+ ;loc_1598C:
		move.w	#$400,ground_vel(a0)
		btst	#0,status(a0)
		beq.s	loc_1599E
		neg.w	ground_vel(a0)

loc_1599E:
		cmpi.w	#$60,(a5)
		beq.s	++ ;loc_159AA
		bcc.s	+ ;loc_159A8
		addq.w	#4,(a5)

+ ;loc_159A8:
		subq.w	#2,(a5)

+ ;loc_159AA:
		move.b	angle(a0),d0
		jsr	(GetSineCosine).l
		muls.w	ground_vel(a0),d0
		asr.l	#8,d0
		move.w	d0,y_vel(a0)
		muls.w	ground_vel(a0),d1
		asr.l	#8,d1
		cmpi.w	#$1000,d1
		ble.s	+ ;loc_159CE
		move.w	#$1000,d1

+ ;loc_159CE:
		cmpi.w	#-$1000,d1
		bge.s	+ ;loc_159D8
		move.w	#-$1000,d1

+ ;loc_159D8:
		move.w	d1,x_vel(a0)
		bra.w	loc_1575A
; End of function Tails_RollSpeed


; =============== S U B R O U T I N E =======================================


sub_159E0:
		move.w	ground_vel(a0),d0
		beq.s	+ ;loc_159E8
		bpl.s	++ ;loc_159F6

+ ;loc_159E8:
		bset	#Status_Facing,status(a0)
		move.b	#2,anim(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_159F6:
		sub.w	d4,d0
		bcc.s	+ ;loc_159FE
		move.w	#-$80,d0

+ ;loc_159FE:
		move.w	d0,ground_vel(a0)
		rts
; End of function sub_159E0


; =============== S U B R O U T I N E =======================================


sub_15A04:
		move.w	ground_vel(a0),d0
		bmi.s	+ ;loc_15A18
		bclr	#Status_Facing,status(a0)
		move.b	#2,anim(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_15A18:
		add.w	d4,d0
		bcc.s	+ ;loc_15A20
		move.w	#$80,d0

+ ;loc_15A20:
		move.w	d0,ground_vel(a0)
		rts
; End of function sub_15A04


; =============== S U B R O U T I N E =======================================


Tails_InputAcceleration_Freespace:
		move.w	Max_speed_P2-Max_speed_P2(a4),d6
		move.w	Acceleration_P2-Max_speed_P2(a4),d5
		asl.w	#1,d5
		btst	#Status_RollJump,status(a0)
		bne.s	+++ ;loc_15A7A
		move.w	x_vel(a0),d0
		btst	#button_left,(Ctrl_2_held_logical).w
		beq.s	+ ;loc_15A5A
		bset	#Status_Facing,status(a0)
		sub.w	d5,d0
		move.w	d6,d1
		neg.w	d1
		cmp.w	d1,d0
		bgt.s	+ ;loc_15A5A
		add.w	d5,d0
		cmp.w	d1,d0
		ble.s	+ ;loc_15A5A
		move.w	d1,d0

+ ;loc_15A5A:
		btst	#button_right,(Ctrl_2_held_logical).w
		beq.s	+ ;loc_15A76
		bclr	#Status_Facing,status(a0)
		add.w	d5,d0
		cmp.w	d6,d0
		blt.s	+ ;loc_15A76
		sub.w	d5,d0
		cmp.w	d6,d0
		bge.s	+ ;loc_15A76
		move.w	d6,d0

+ ;loc_15A76:
		move.w	d0,x_vel(a0)

+ ;loc_15A7A:
		cmpi.w	#$60,(a5)
		beq.s	++ ;loc_15A86
		bcc.s	+ ;loc_15A84
		addq.w	#4,(a5)

+ ;loc_15A84:
		subq.w	#2,(a5)

+ ;loc_15A86:
		cmpi.w	#-$400,y_vel(a0)
		blo.s	locret_15AB4
		move.w	x_vel(a0),d0
		move.w	d0,d1
		asr.w	#5,d1
		beq.s	locret_15AB4
		bmi.s	++ ;loc_15AA8
		sub.w	d1,d0
		bcc.s	+ ;loc_15AA2
		move.w	#0,d0

+ ;loc_15AA2:
		move.w	d0,x_vel(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_15AA8:
		sub.w	d1,d0
		bcs.s	+ ;loc_15AB0
		move.w	#0,d0

+ ;loc_15AB0:
		move.w	d0,x_vel(a0)

locret_15AB4:
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
		bhi.s	loc_15AFA
		move.w	(Camera_max_X_pos).w,d0
		addi.w	#$128,d0
		cmp.w	d1,d0
		bls.s	loc_15AFA

loc_15ADE:
		tst.b	(Disable_death_plane).w
		bne.s	locret_15AF2
		move.w	(Camera_max_Y_pos).w,d0
		addi.w	#$E0,d0
		cmp.w	y_pos(a0),d0
		blt.s	+ ;loc_15AF4

locret_15AF2:
		rts
; ---------------------------------------------------------------------------

+ ;loc_15AF4:
		jmp	(Kill_Character).l
; ---------------------------------------------------------------------------

loc_15AFA:
		move.w	d0,x_pos(a0)
		move.w	#0,2+x_pos(a0)
		move.w	#0,x_vel(a0)
		move.w	#0,ground_vel(a0)
		bra.s	loc_15ADE
; End of function Tails_Check_Screen_Boundaries


; =============== S U B R O U T I N E =======================================


Tails_Roll:
		tst.b	status_secondary(a0)
		bmi.s	locret_15B38
		move.w	ground_vel(a0),d0
		bpl.s	+ ;loc_15B20
		neg.w	d0

+ ;loc_15B20:
		cmpi.w	#$80,d0
		bcs.s	locret_15B38
		move.b	(Ctrl_2_held_logical).w,d0
		andi.b	#button_left_mask|button_right_mask,d0
		bne.s	locret_15B38
		btst	#button_down,(Ctrl_2_held_logical).w
		bne.s	+ ;loc_15B3A

locret_15B38:
		rts
; ---------------------------------------------------------------------------

+ ;loc_15B3A:
		btst	#Status_Roll,status(a0)
		beq.s	+ ;loc_15B44
		rts
; ---------------------------------------------------------------------------

+ ;loc_15B44:
		bset	#Status_Roll,status(a0)
		move.b	#$E,y_radius(a0)
		move.b	#7,x_radius(a0)
		move.b	#2,anim(a0)
		addq.w	#1,y_pos(a0)
		move.w	#sfx_Roll,d0
		jsr	(Play_SFX).l
		tst.w	ground_vel(a0)
		bne.s	locret_15B76
		move.w	#$200,ground_vel(a0)

locret_15B76:
		rts
; End of function Tails_Roll


; =============== S U B R O U T I N E =======================================


Tails_Jump:
		move.b	(Ctrl_2_pressed_logical).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0
		beq.w	locret_15C2E
		moveq	#0,d0
		move.b	angle(a0),d0
		addi.b	#$80,d0
		movem.l	a4-a6,-(sp)
		bsr.w	CalcRoomOverHead
		movem.l	(sp)+,a4-a6
		cmpi.w	#6,d1
		blt.w	locret_15C2E
		move.w	#$680,d2
		btst	#Status_Underwater,status(a0)
		beq.s	+ ;loc_15BB2
		move.w	#$380,d2

+ ;loc_15BB2:
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
		bne.s	+ ;loc_15C30
		move.b	#$E,y_radius(a0)
		move.b	#7,x_radius(a0)
		move.b	#2,anim(a0)
		bset	#Status_Roll,status(a0)
		move.b	y_radius(a0),d0
		sub.b	default_y_radius(a0),d0
		ext.w	d0
		sub.w	d0,y_pos(a0)

locret_15C2E:
		rts
; ---------------------------------------------------------------------------

+ ;loc_15C30:
		bset	#Status_RollJump,status(a0)
		rts
; End of function Tails_Jump


; =============== S U B R O U T I N E =======================================


Tails_JumpHeight:
		tst.b	jumping(a0)
		beq.s	++ ;loc_15C64
		move.w	#-$400,d1
		btst	#Status_Underwater,status(a0)
		beq.s	+ ;loc_15C4E
		move.w	#-$200,d1

+ ;loc_15C4E:
		cmp.w	y_vel(a0),d1
		ble.s	Tails_Test_For_Flight
		move.b	(Ctrl_2_held_logical).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0
		bne.s	locret_15C62
		move.w	d1,y_vel(a0)

locret_15C62:
		rts
; ---------------------------------------------------------------------------

+ ;loc_15C64:
		tst.b	spin_dash_flag(a0)
		bne.s	locret_15C78
		cmpi.w	#-$FC0,y_vel(a0)
		bge.s	locret_15C78
		move.w	#-$FC0,y_vel(a0)

locret_15C78:
		rts
; ---------------------------------------------------------------------------

Tails_Test_For_Flight:
		tst.b	double_jump_flag(a0)
		bne.w	locret_15CDA
		move.b	(Ctrl_2_pressed_logical).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0
		beq.w	locret_15CDA
		cmpi.w	#2,(Player_mode).w
		beq.s	+ ;loc_15C9C
		tst.w	(Tails_CPU_idle_timer).w
		beq.s	locret_15CDA

+ ;loc_15C9C:
		btst	#Status_Roll,status(a0)
		beq.s	+ ;loc_15CC4
		bclr	#Status_Roll,status(a0)
		move.b	y_radius(a0),d1
		move.b	default_y_radius(a0),y_radius(a0)
		move.b	default_x_radius(a0),x_radius(a0)
		sub.b	default_y_radius(a0),d1
		ext.w	d1
		add.w	d1,y_pos(a0)

+ ;loc_15CC4:
		bclr	#Status_RollJump,status(a0)
		move.b	#1,double_jump_flag(a0)
		move.b	#(8*60)/2,double_jump_property(a0)
		bsr.w	Tails_Set_Flying_Animation

locret_15CDA:
		rts
; End of function Tails_JumpHeight


; =============== S U B R O U T I N E =======================================


Tails_Spindash:
		tst.b	spin_dash_flag(a0)
		bne.s	++ ;loc_15D50
		cmpi.b	#8,anim(a0)
		bne.s	locret_15D4E
		move.b	(Ctrl_2_pressed_logical).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0
		beq.w	locret_15D4E
		move.b	#9,anim(a0)
		move.w	#signextendB(sfx_Spindash),d0
		jsr	(Play_SFX).l
		addq.l	#4,sp
		move.b	#1,spin_dash_flag(a0)
		move.w	#0,spin_dash_counter(a0)
		cmpi.b	#12,air_left(a0)
		blo.s	+ ;loc_15D22
		move.b	#2,anim(a6)

+ ;loc_15D22:
		bsr.w	Tails_Check_Screen_Boundaries
		bsr.w	Player_AnglePos
		tst.b	(Background_collision_flag).w
		beq.s	locret_15D4E
		bsr.w	sub_10BA2
		tst.w	d1
		bmi.w	Kill_Character
		movem.l	a4-a6,-(sp)
		bsr.w	CheckLeftWallDist
		movem.l	(sp)+,a4-a6
		tst.w	d1
		bpl.s	locret_15D4E
		sub.w	d1,x_pos(a0)

locret_15D4E:
		rts
; ---------------------------------------------------------------------------

+ ;loc_15D50:
		move.b	(Ctrl_2_held_logical).w,d0
		btst	#button_down,d0
		bne.w	+++ ;loc_15DE0
		move.b	#$E,y_radius(a0)
		move.b	#7,x_radius(a0)
		move.b	#2,anim(a0)
		addq.w	#1,y_pos(a0)
		move.b	#0,spin_dash_flag(a0)
		moveq	#0,d0
		move.b	spin_dash_counter(a0),d0
		add.w	d0,d0
		move.w	word_15DCE(pc,d0.w),ground_vel(a0)
		move.w	ground_vel(a0),d0
		subi.w	#$800,d0
		add.w	d0,d0
		andi.w	#$1F00,d0
		neg.w	d0
		addi.w	#$2000,d0
		lea	(H_scroll_frame_offset).w,a1
		cmpa.w	#Player_1,a0
		beq.s	+ ;loc_15DA8
		lea	(H_scroll_frame_offset_P2).w,a1

+ ;loc_15DA8:
		move.w	d0,(a1)
		btst	#Status_Facing,status(a0)
		beq.s	+ ;loc_15DB6
		neg.w	ground_vel(a0)

+ ;loc_15DB6:
		bset	#Status_Roll,status(a0)
		move.b	#0,anim(a6)
		move.w	#signextendB(sfx_Dash),d0
		jsr	(Play_SFX).l
		bra.s	+++ ;loc_15E28
; ---------------------------------------------------------------------------
word_15DCE:
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

+ ;loc_15DE0:
		tst.w	spin_dash_counter(a0)
		beq.s	+ ;loc_15DF8
		move.w	spin_dash_counter(a0),d0
		lsr.w	#5,d0
		sub.w	d0,spin_dash_counter(a0)
		bcc.s	+ ;loc_15DF8
		move.w	#0,spin_dash_counter(a0)

+ ;loc_15DF8:
		move.b	(Ctrl_2_pressed_logical).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0
		beq.w	+ ;loc_15E28
		move.w	#9<<8,anim(a0)	; and prev_anim
		move.w	#signextendB(sfx_Spindash),d0
		jsr	(Play_SFX).l
		addi.w	#$200,spin_dash_counter(a0)
		cmpi.w	#$800,spin_dash_counter(a0)
		blo.s	+ ;loc_15E28
		move.w	#$800,spin_dash_counter(a0)

+ ;loc_15E28:
		addq.l	#4,sp
		cmpi.w	#$60,(a5)
		beq.s	++ ;loc_15E36
		bcc.s	+ ;loc_15E34
		addq.w	#4,(a5)

+ ;loc_15E34:
		subq.w	#2,(a5)

+ ;loc_15E36:
		bsr.w	Tails_Check_Screen_Boundaries
		bsr.w	Player_AnglePos
		tst.b	(Background_collision_flag).w
		beq.s	locret_15E62
		bsr.w	sub_10BA2
		tst.w	d1
		bmi.w	Kill_Character
		movem.l	a4-a6,-(sp)
		bsr.w	CheckLeftWallDist
		movem.l	(sp)+,a4-a6
		tst.w	d1
		bpl.s	locret_15E62
		sub.w	d1,x_pos(a0)

locret_15E62:
		rts
; End of function Tails_Spindash


; =============== S U B R O U T I N E =======================================


Tails_SlopeResist:
		move.b	angle(a0),d0
		addi.b	#$60,d0
		cmpi.b	#-$40,d0
		bcc.s	locret_15E98
		move.b	angle(a0),d0
		jsr	(GetSineCosine).l
		muls.w	#$20,d0
		asr.l	#8,d0
		tst.w	ground_vel(a0)
		beq.s	locret_15E98
		bmi.s	+ ;loc_15E94
		tst.w	d0
		beq.s	locret_15E92
		add.w	d0,ground_vel(a0)

locret_15E92:
		rts
; ---------------------------------------------------------------------------

+ ;loc_15E94:
		add.w	d0,ground_vel(a0)

locret_15E98:
		rts
; End of function Tails_SlopeResist


; =============== S U B R O U T I N E =======================================


Tails_RollRepel:
		move.b	angle(a0),d0
		addi.b	#$60,d0
		cmpi.b	#-$40,d0
		bcc.s	locret_15ED4
		move.b	angle(a0),d0
		jsr	(GetSineCosine).l
		muls.w	#$50,d0
		asr.l	#8,d0
		tst.w	ground_vel(a0)
		bmi.s	++ ;loc_15ECA
		tst.w	d0
		bpl.s	+ ;loc_15EC4
		asr.l	#2,d0

+ ;loc_15EC4:
		add.w	d0,ground_vel(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_15ECA:
		tst.w	d0
		bmi.s	+ ;loc_15ED0
		asr.l	#2,d0

+ ;loc_15ED0:
		add.w	d0,ground_vel(a0)

locret_15ED4:
		rts
; End of function Tails_RollRepel


; =============== S U B R O U T I N E =======================================


Tails_SlopeRepel:
		nop
		tst.b	stick_to_convex(a0)
		bne.s	locret_15F10
		tst.w	move_lock(a0)
		bne.s	++ ;loc_15F12
		move.b	angle(a0),d0
		addi.b	#$20,d0
		andi.b	#$C0,d0
		beq.s	locret_15F10
		move.w	ground_vel(a0),d0
		bpl.s	+ ;loc_15EFA
		neg.w	d0

+ ;loc_15EFA:
		cmpi.w	#$280,d0
		bcc.s	locret_15F10
		clr.w	ground_vel(a0)
		bset	#Status_InAir,status(a0)
		move.w	#30,move_lock(a0)

locret_15F10:
		rts
; ---------------------------------------------------------------------------

+ ;loc_15F12:
		subq.w	#1,move_lock(a0)
		rts
; End of function Tails_SlopeRepel


; =============== S U B R O U T I N E =======================================


Tails_JumpAngle:
		move.b	angle(a0),d0
		beq.s	loc_15F32
		bpl.s	++ ;loc_15F28
		addq.b	#2,d0
		bcc.s	+ ;loc_15F26
		moveq	#0,d0

+ ;loc_15F26:
		bra.s	++ ;loc_15F2E
; ---------------------------------------------------------------------------

+ ;loc_15F28:
		subq.b	#2,d0
		bcc.s	+ ;loc_15F2E
		moveq	#0,d0

+ ;loc_15F2E:
		move.b	d0,angle(a0)

loc_15F32:
		move.b	flip_angle(a0),d0
		beq.s	locret_15F76
		tst.w	ground_vel(a0)
		bmi.s	++ ;loc_15F56

loc_15F3E:
		move.b	flip_speed(a0),d1
		add.b	d1,d0
		bcc.s	+ ;loc_15F54
		subq.b	#1,flips_remaining(a0)
		bcc.s	+ ;loc_15F54
		move.b	#0,flips_remaining(a0)
		moveq	#0,d0

+ ;loc_15F54:
		bra.s	++ ;loc_15F72
; ---------------------------------------------------------------------------

+ ;loc_15F56:
		tst.b	flip_type(a0)
		bmi.s	loc_15F3E
		move.b	flip_speed(a0),d1
		sub.b	d1,d0
		bcc.s	+ ;loc_15F72
		subq.b	#1,flips_remaining(a0)
		bcc.s	+ ;loc_15F72
		move.b	#0,flips_remaining(a0)
		moveq	#0,d0

+ ;loc_15F72:
		move.b	d0,flip_angle(a0)

locret_15F76:
		rts
; End of function Tails_JumpAngle


; =============== S U B R O U T I N E =======================================


Tails_DoLevelCollision:
		move.l	(Primary_collision_addr).w,(Collision_addr).w
		cmpi.b	#$C,top_solid_bit(a0)
		beq.s	+ ;loc_15F8C
		move.l	(Secondary_collision_addr).w,(Collision_addr).w

+ ;loc_15F8C:
		move.b	lrb_solid_bit(a0),d5
		move.w	x_vel(a0),d1
		move.w	y_vel(a0),d2
		jsr	(GetArcTan).l
		subi.b	#$20,d0
		andi.b	#$C0,d0
		cmpi.b	#$40,d0
		beq.w	loc_1605A
		cmpi.b	#$80,d0
		beq.w	loc_160D6
		cmpi.b	#$C0,d0
		beq.w	loc_16132
		bsr.w	CheckLeftWallDist
		tst.w	d1
		bpl.s	+ ;loc_15FD0
		sub.w	d1,x_pos(a0)
		move.w	#0,x_vel(a0)

+ ;loc_15FD0:
		bsr.w	CheckRightWallDist
		tst.w	d1
		bpl.s	+ ;loc_15FE2
		add.w	d1,x_pos(a0)
		move.w	#0,x_vel(a0)

+ ;loc_15FE2:
		bsr.w	Sonic_CheckFloor
		tst.w	d1
		bpl.s	locret_16058
		move.b	y_vel(a0),d2
		addq.b	#8,d2
		neg.b	d2
		cmp.b	d2,d1
		bge.s	+ ;loc_15FFA
		cmp.b	d2,d0
		blt.s	locret_16058

+ ;loc_15FFA:
		add.w	d1,y_pos(a0)
		move.b	d3,angle(a0)
		move.b	d3,d0
		addi.b	#$20,d0
		andi.b	#$40,d0
		bne.s	++ ;loc_16032
		move.b	d3,d0
		addi.b	#$10,d0
		andi.b	#$20,d0
		beq.s	+ ;loc_16020
		asr	y_vel(a0)
		bra.s	+++ ;loc_16046
; ---------------------------------------------------------------------------

+ ;loc_16020:
		move.w	#0,y_vel(a0)
		move.w	x_vel(a0),ground_vel(a0)
		bsr.w	Tails_TouchFloor_Check_Spindash
		rts
; ---------------------------------------------------------------------------

+ ;loc_16032:
		move.w	#0,x_vel(a0)
		cmpi.w	#$FC0,y_vel(a0)
		ble.s	+ ;loc_16046
		move.w	#$FC0,y_vel(a0)

+ ;loc_16046:
		bsr.w	Tails_TouchFloor_Check_Spindash
		move.w	y_vel(a0),ground_vel(a0)
		tst.b	d3
		bpl.s	locret_16058
		neg.w	ground_vel(a0)

locret_16058:
		rts
; ---------------------------------------------------------------------------

loc_1605A:
		bsr.w	CheckLeftWallDist
		tst.w	d1
		bpl.s	+ ;loc_16072
		sub.w	d1,x_pos(a0)
		move.w	#0,x_vel(a0)
		move.w	y_vel(a0),ground_vel(a0)

+ ;loc_16072:
		bsr.w	Sonic_CheckCeiling
		tst.w	d1
		bpl.s	++ ;loc_160A8
		neg.w	d1
		cmpi.w	#$14,d1
		bhs.s	+ ;loc_16094
		add.w	d1,y_pos(a0)
		tst.w	y_vel(a0)
		bpl.s	locret_16092
		move.w	#0,y_vel(a0)

locret_16092:
		rts
; ---------------------------------------------------------------------------

+ ;loc_16094:
		bsr.w	CheckRightWallDist
		tst.w	d1
		bpl.s	locret_160A6
		add.w	d1,x_pos(a0)
		move.w	#0,x_vel(a0)

locret_160A6:
		rts
; ---------------------------------------------------------------------------

+ ;loc_160A8:
		tst.b	(WindTunnel_flag_P2).w
		bne.s	+ ;loc_160B4
		tst.w	y_vel(a0)
		bmi.s	locret_160D4

+ ;loc_160B4:
		bsr.w	Sonic_CheckFloor
		tst.w	d1
		bpl.s	locret_160D4
		add.w	d1,y_pos(a0)
		move.b	d3,angle(a0)
		move.w	#0,y_vel(a0)
		move.w	x_vel(a0),ground_vel(a0)
		bsr.w	Tails_TouchFloor_Check_Spindash

locret_160D4:
		rts
; ---------------------------------------------------------------------------

loc_160D6:
		bsr.w	CheckLeftWallDist
		tst.w	d1
		bpl.s	+ ;loc_160E8
		sub.w	d1,x_pos(a0)
		move.w	#0,x_vel(a0)

+ ;loc_160E8:
		bsr.w	CheckRightWallDist
		tst.w	d1
		bpl.s	+ ;loc_160FA
		add.w	d1,x_pos(a0)
		move.w	#0,x_vel(a0)

+ ;loc_160FA:
		bsr.w	Sonic_CheckCeiling
		tst.w	d1
		bpl.s	locret_16130
		sub.w	d1,y_pos(a0)
		move.b	d3,d0
		addi.b	#$20,d0
		andi.b	#$40,d0
		bne.s	+ ;loc_1611A
		move.w	#0,y_vel(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_1611A:
		move.b	d3,angle(a0)
		bsr.w	Tails_TouchFloor_Check_Spindash
		move.w	y_vel(a0),ground_vel(a0)
		tst.b	d3
		bpl.s	locret_16130
		neg.w	ground_vel(a0)

locret_16130:
		rts
; ---------------------------------------------------------------------------

loc_16132:
		bsr.w	CheckRightWallDist
		tst.w	d1
		bpl.s	+ ;loc_1614A
		add.w	d1,x_pos(a0)
		move.w	#0,x_vel(a0)
		move.w	y_vel(a0),ground_vel(a0)

+ ;loc_1614A:
		bsr.w	Sonic_CheckCeiling
		tst.w	d1
		bpl.s	+ ;loc_16164
		sub.w	d1,y_pos(a0)
		tst.w	y_vel(a0)
		bpl.s	locret_16162
		move.w	#0,y_vel(a0)

locret_16162:
		rts
; ---------------------------------------------------------------------------

+ ;loc_16164:
		tst.b	(WindTunnel_flag_P2).w
		bne.s	+ ;loc_16170
		tst.w	y_vel(a0)
		bmi.s	locret_16190

+ ;loc_16170:
		bsr.w	Sonic_CheckFloor
		tst.w	d1
		bpl.s	locret_16190
		add.w	d1,y_pos(a0)
		move.b	d3,angle(a0)
		move.w	#0,y_vel(a0)
		move.w	x_vel(a0),ground_vel(a0)
		bsr.w	Tails_TouchFloor_Check_Spindash

locret_16190:
		rts
; End of function Tails_DoLevelCollision


; =============== S U B R O U T I N E =======================================


Tails_TouchFloor_Check_Spindash:
		tst.b	spin_dash_flag(a0)
		bne.s	+ ;loc_161CC
		move.b	#0,anim(a0)
; End of function Tails_TouchFloor_Check_Spindash


; =============== S U B R O U T I N E =======================================


Tails_TouchFloor:
		move.b	y_radius(a0),d0
		move.b	default_y_radius(a0),y_radius(a0)
		move.b	default_x_radius(a0),x_radius(a0)
		btst	#Status_Roll,status(a0)
		beq.s	+ ;loc_161CC
		bclr	#Status_Roll,status(a0)
		move.b	#0,anim(a0)
		sub.b	default_y_radius(a0),d0
		ext.w	d0
		add.w	d0,y_pos(a0)

+ ;loc_161CC:
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

loc_1620A:
		tst.b	(Flying_carrying_Sonic_flag).w
		beq.s	+ ;loc_16222
		lea	(Player_1).w,a1
		clr.b	object_control(a1)
		bset	#Status_InAir,status(a1)
		clr.w	(Flying_carrying_Sonic_flag).w

+ ;loc_16222:
		jsr	(MoveSprite2).l
		addi.w	#$30,y_vel(a0)
		btst	#Status_Underwater,status(a0)
		beq.s	+ ;loc_1623C
		subi.w	#$20,y_vel(a0)

+ ;loc_1623C:
		cmpi.w	#-$100,(Camera_min_Y_pos).w
		bne.s	+ ;loc_1624C
		move.w	(Screen_Y_wrap_value).w,d0
		and.w	d0,y_pos(a0)

+ ;loc_1624C:
		bsr.w	+ ;sub_16262
		bsr.w	Tails_Check_Screen_Boundaries
		bsr.w	Sonic_RecordPos
		bsr.w	sub_16356
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


+ ;sub_16262:
		tst.b	(Disable_death_plane).w
		bne.s	+ ;loc_16278
		move.w	(Camera_max_Y_pos).w,d0
		addi.w	#$E0,d0
		cmp.w	y_pos(a0),d0
		blt.w	++ ;loc_162BE

+ ;loc_16278:
		movem.l	a4-a6,-(sp)
		bsr.w	Tails_DoLevelCollision
		movem.l	(sp)+,a4-a6
		btst	#Status_InAir,status(a0)
		bne.s	locret_162BC
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

locret_162BC:
		rts
; ---------------------------------------------------------------------------

+ ;loc_162BE:
		jmp	(Kill_Character).l
; End of function sub_16262

; ---------------------------------------------------------------------------

loc_162C4:
		tst.b	(Flying_carrying_Sonic_flag).w
		beq.s	+ ;loc_162DC
		lea	(Player_1).w,a1
		clr.b	object_control(a1)
		bset	#Status_InAir,status(a1)
		clr.w	(Flying_carrying_Sonic_flag).w

+ ;loc_162DC:
		bsr.w	sub_13230
		jsr	(MoveSprite).l
		bsr.w	Sonic_RecordPos
		bsr.w	sub_16356
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_162F4:
		tst.w	$3E(a0)
		beq.s	locret_16306
		subq.w	#1,$3E(a0)
		bne.s	locret_16306
		move.w	#1,(Restart_level_flag).w

locret_16306:
		rts
; ---------------------------------------------------------------------------

loc_16308:
		tst.w	(H_scroll_amount_P2).w
		bne.s	+ ;loc_1631A
		tst.w	(V_scroll_amount_P2).w
		bne.s	+ ;loc_1631A
		move.b	#2,routine(a0)

+ ;loc_1631A:
		bsr.w	sub_16356
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_16324:
		tst.b	(Flying_carrying_Sonic_flag).w
		beq.s	+ ;loc_1633C
		lea	(Player_1).w,a1
		clr.b	object_control(a1)
		bset	#Status_InAir,status(a1)
		clr.w	(Flying_carrying_Sonic_flag).w

+ ;loc_1633C:
		jsr	(MoveSprite2).l
		addi.w	#$10,y_vel(a0)
		bsr.w	Sonic_RecordPos
		bsr.w	sub_16356
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_16356:
		tst.w	(Competition_mode).w
		bne.s	+ ;loc_16362
		bsr.s	Animate_Tails
		bra.w	Tails_Load_PLC
; ---------------------------------------------------------------------------

+ ;loc_16362:
		bsr.w	Animate_Tails2P
		bra.w	Tails2P_Load_PLC
; End of function sub_16356


; =============== S U B R O U T I N E =======================================


Animate_Tails:
		lea	(AniTails).l,a1

Animate_Tails_Part2:
		moveq	#0,d0
		move.b	anim(a0),d0
		cmp.b	prev_anim(a0),d0
		beq.s	+ ;loc_16392
		move.b	d0,prev_anim(a0)
		move.b	#0,anim_frame(a0)
		move.b	#0,anim_frame_timer(a0)
		bclr	#Status_Push,status(a0)

+ ;loc_16392:
		add.w	d0,d0
		adda.w	(a1,d0.w),a1
		move.b	(a1),d0
		bmi.s	loc_16402
		move.b	status(a0),d1
		andi.b	#1,d1
		andi.b	#$FC,render_flags(a0)
		or.b	d1,render_flags(a0)
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	locret_163D0
		move.b	d0,anim_frame_timer(a0)
; End of function Animate_Tails


; =============== S U B R O U T I N E =======================================


sub_163B8:
		moveq	#0,d1
		move.b	anim_frame(a0),d1
		move.b	1(a1,d1.w),d0
		cmpi.b	#$F0,d0
		bhs.s	+ ;loc_163D2

loc_163C8:
		move.b	d0,mapping_frame(a0)
		addq.b	#1,anim_frame(a0)

locret_163D0:
		rts
; ---------------------------------------------------------------------------

+ ;loc_163D2:
		addq.b	#1,d0
		bne.s	+ ;loc_163E2
		move.b	#0,anim_frame(a0)
		move.b	1(a1),d0
		bra.s	loc_163C8
; ---------------------------------------------------------------------------

+ ;loc_163E2:
		addq.b	#1,d0
		bne.s	+ ;loc_163F6
		move.b	2(a1,d1.w),d0
		sub.b	d0,anim_frame(a0)
		sub.b	d0,d1
		move.b	1(a1,d1.w),d0
		bra.s	loc_163C8
; ---------------------------------------------------------------------------

+ ;loc_163F6:
		addq.b	#1,d0
		bne.s	locret_16400
		move.b	2(a1,d1.w),anim(a0)

locret_16400:
		rts
; End of function sub_163B8

; ---------------------------------------------------------------------------

loc_16402:
		addq.b	#1,d0
		bne.w	loc_164D0
		moveq	#0,d0
		tst.b	flip_type(a0)
		bmi.w	Anim_Tumble
		move.b	flip_angle(a0),d0
		bne.w	Anim_Tumble
		moveq	#0,d1
		move.b	angle(a0),d0
		bmi.s	+ ;loc_16426
		beq.s	+ ;loc_16426
		subq.b	#1,d0

+ ;loc_16426:
		move.b	status(a0),d2
		andi.b	#1,d2
		bne.s	+ ;loc_16432
		not.b	d0

+ ;loc_16432:
		addi.b	#$10,d0
		bpl.s	+ ;loc_1643A
		moveq	#3,d1

+ ;loc_1643A:
		andi.b	#$FC,render_flags(a0)
		eor.b	d1,d2
		or.b	d2,render_flags(a0)
		btst	#Status_Push,status(a0)
		bne.w	loc_1651C
		lsr.b	#4,d0
		andi.b	#6,d0
		move.w	ground_vel(a0),d2
		bpl.s	+ ;loc_1645E
		neg.w	d2

+ ;loc_1645E:
		tst.b	status_secondary(a0)
		bpl.w	+ ;loc_16468
		add.w	d2,d2

+ ;loc_16468:
		move.b	d0,d3
		add.b	d3,d3
		add.b	d3,d3
		lea	(AniTails00).l,a1
		cmpi.w	#$600,d2
		blo.s	+ ;loc_16492
		lea	(AniTails01).l,a1
		move.b	d0,d3
		add.b	d3,d3
		cmpi.w	#$700,d2
		blo.s	+ ;loc_16492
		lea	(AniTails1F).l,a1
		move.b	d0,d3

+ ;loc_16492:
		moveq	#0,d1
		move.b	anim_frame(a0),d1
		move.b	1(a1,d1.w),d0
		cmpi.b	#-1,d0
		bne.s	+ ;loc_164AC
		move.b	#0,anim_frame(a0)
		move.b	1(a1),d0

+ ;loc_164AC:
		move.b	d0,mapping_frame(a0)
		add.b	d3,mapping_frame(a0)
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	locret_164CE
		neg.w	d2
		addi.w	#$800,d2
		bpl.s	+ ;loc_164C4
		moveq	#0,d2

+ ;loc_164C4:
		lsr.w	#8,d2
		move.b	d2,anim_frame_timer(a0)
		addq.b	#1,anim_frame(a0)

locret_164CE:
		rts
; ---------------------------------------------------------------------------

loc_164D0:
		subq.b	#1,anim_frame_timer(a0)
		bpl.w	locret_163D0
		addq.b	#1,d0
		bne.s	loc_16556
		move.w	ground_vel(a0),d2
		bpl.s	+ ;loc_164E4
		neg.w	d2

+ ;loc_164E4:
		lea	(AniTails03).l,a1
		cmpi.w	#$600,d2
		bhs.s	+ ;loc_164F6
		lea	(AniTails02).l,a1

+ ;loc_164F6:
		neg.w	d2
		addi.w	#$400,d2
		bpl.s	+ ;loc_16500
		moveq	#0,d2

+ ;loc_16500:
		lsr.w	#8,d2
		move.b	d2,anim_frame_timer(a0)
		move.b	status(a0),d1
		andi.b	#1,d1
		andi.b	#$FC,render_flags(a0)
		or.b	d1,render_flags(a0)
		bra.w	sub_163B8
; ---------------------------------------------------------------------------

loc_1651C:
		subq.b	#1,anim_frame_timer(a0)
		bpl.w	locret_163D0
		move.w	ground_vel(a0),d2
		bmi.s	+ ;loc_1652C
		neg.w	d2

+ ;loc_1652C:
		addi.w	#$800,d2
		bpl.s	+ ;loc_16534
		moveq	#0,d2

+ ;loc_16534:
		lsr.w	#6,d2
		move.b	d2,anim_frame_timer(a0)
		lea	(AniTails04).l,a1
		move.b	status(a0),d1
		andi.b	#1,d1
		andi.b	#$FC,render_flags(a0)
		or.b	d1,render_flags(a0)
		bra.w	sub_163B8
; ---------------------------------------------------------------------------

loc_16556:
		move.w	x_vel(a2),d1
		move.w	y_vel(a2),d2
		jsr	(GetArcTan).l
		moveq	#0,d1
		move.b	status(a0),d2
		andi.b	#1,d2
		bne.s	+ ;loc_16574
		not.b	d0
		bra.s	++ ;loc_16578
; ---------------------------------------------------------------------------

+ ;loc_16574:
		addi.b	#$80,d0

+ ;loc_16578:
		addi.b	#$10,d0
		bpl.s	+ ;loc_16580
		moveq	#3,d1

+ ;loc_16580:
		andi.b	#$FC,render_flags(a0)
		eor.b	d1,d2
		or.b	d2,render_flags(a0)
		lsr.b	#3,d0
		andi.b	#$C,d0
		move.b	d0,d3
		lea	(AniTails_Tail03).l,a1
		move.b	#3,anim_frame_timer(a0)
		bsr.w	sub_163B8
		add.b	d3,mapping_frame(a0)
		rts
; ---------------------------------------------------------------------------
AniTails:
		include "General/Sprites/Tails/Anim - Tails S3.asm"
; ---------------------------------------------------------------------------

Tails_Tail_Load_PLC:
		moveq	#0,d0
		move.b	mapping_frame(a0),d0
		cmp.b	(Player_prev_frame_P2_tail).w,d0
		beq.s	locret_167AA
		move.b	d0,(Player_prev_frame_P2_tail).w
		lea	(PLC_Tails_Tail).l,a2
		add.w	d0,d0
		adda.w	(a2,d0.w),a2
		move.w	(a2)+,d5
		subq.w	#1,d5
		bmi.s	locret_167AA
		move.w	#tiles_to_bytes(ArtTile_Player_2_Tail),d4
		move.l	#ArtUnc_Tails_Tail,d6
		bra.s	+ ;loc_16782

; =============== S U B R O U T I N E =======================================


Tails_Load_PLC:
		moveq	#0,d0
		move.b	mapping_frame(a0),d0

Tails_Load_PLC2:
		cmp.b	(Player_prev_frame_P2).w,d0
		beq.s	locret_167AA
		move.b	d0,(Player_prev_frame_P2).w
		lea	(PLC_Tails).l,a2
		add.w	d0,d0
		adda.w	(a2,d0.w),a2
		move.w	(a2)+,d5
		subq.w	#1,d5
		bmi.s	locret_167AA
		move.w	#tiles_to_bytes(ArtTile_Player_2),d4
		move.l	#ArtUnc_Tails,d6

/ ;loc_16782:
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
		dbf	d5,- ;loc_16782

locret_167AA:
		rts
; End of function Tails_Load_PLC


; =============== S U B R O U T I N E =======================================


Animate_Tails2P:
		lea	(AniTails2P).l,a1

Animate_Tails_Tail2P:
		moveq	#0,d0
		move.b	anim(a0),d0
		cmp.b	prev_anim(a0),d0
		beq.s	+ ;loc_167D4
		move.b	d0,prev_anim(a0)
		move.b	#0,anim_frame(a0)
		move.b	#0,anim_frame_timer(a0)
		bclr	#Status_Push,status(a0)

+ ;loc_167D4:
		add.w	d0,d0
		adda.w	(a1,d0.w),a1
		move.b	(a1),d0
		bmi.s	loc_16844
		move.b	status(a0),d1
		andi.b	#1,d1
		andi.b	#$FC,render_flags(a0)
		or.b	d1,render_flags(a0)
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	locret_16812
		move.b	d0,anim_frame_timer(a0)
; End of function Animate_Tails2P


; =============== S U B R O U T I N E =======================================


sub_167FA:
		moveq	#0,d1
		move.b	anim_frame(a0),d1
		move.b	1(a1,d1.w),d0
		cmpi.b	#$F0,d0
		bhs.s	+ ;loc_16814

loc_1680A:
		move.b	d0,mapping_frame(a0)
		addq.b	#1,anim_frame(a0)

locret_16812:
		rts
; ---------------------------------------------------------------------------

+ ;loc_16814:
		addq.b	#1,d0
		bne.s	+ ;loc_16824
		move.b	#0,anim_frame(a0)
		move.b	1(a1),d0
		bra.s	loc_1680A
; ---------------------------------------------------------------------------

+ ;loc_16824:
		addq.b	#1,d0
		bne.s	+ ;loc_16838
		move.b	2(a1,d1.w),d0
		sub.b	d0,anim_frame(a0)
		sub.b	d0,d1
		move.b	1(a1,d1.w),d0
		bra.s	loc_1680A
; ---------------------------------------------------------------------------

+ ;loc_16838:
		addq.b	#1,d0
		bne.s	locret_16842
		move.b	2(a1,d1.w),anim(a0)

locret_16842:
		rts
; End of function sub_167FA

; ---------------------------------------------------------------------------

loc_16844:
		addq.b	#1,d0
		bne.w	loc_1695E
		moveq	#0,d0
		move.b	flip_angle(a0),d0
		bne.w	loc_168F8
		moveq	#0,d1
		move.b	angle(a0),d0
		bmi.s	+ ;loc_16860
		beq.s	+ ;loc_16860
		subq.b	#1,d0

+ ;loc_16860:
		move.b	status(a0),d2
		andi.b	#1,d2
		bne.s	+ ;loc_1686C
		not.b	d0

+ ;loc_1686C:
		addi.b	#$10,d0
		bpl.s	+ ;loc_16874
		moveq	#3,d1

+ ;loc_16874:
		andi.b	#$FC,render_flags(a0)
		eor.b	d1,d2
		or.b	d2,render_flags(a0)
		btst	#Status_Push,status(a0)
		bne.w	loc_169AA
		lsr.b	#5,d0
		andi.b	#3,d0
		move.w	ground_vel(a0),d2
		bpl.s	+ ;loc_16898
		neg.w	d2

+ ;loc_16898:
		tst.b	status_secondary(a0)
		bpl.w	+ ;loc_168A2
		add.w	d2,d2

+ ;loc_168A2:
		move.b	d0,d3
		lea	(AniTails2P01).l,a1
		cmpi.w	#$600,d2
		bhs.s	+ ;loc_168B8
		lea	(AniTails2P00).l,a1
		add.b	d0,d0

+ ;loc_168B8:
		add.b	d0,d3
		moveq	#0,d1
		move.b	anim_frame(a0),d1
		move.b	1(a1,d1.w),d0
		cmpi.b	#-1,d0
		bne.s	+ ;loc_168D4
		move.b	#0,anim_frame(a0)
		move.b	1(a1),d0

+ ;loc_168D4:
		move.b	d0,mapping_frame(a0)
		add.b	d3,mapping_frame(a0)
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	locret_168F6
		neg.w	d2
		addi.w	#$800,d2
		bpl.s	+ ;loc_168EC
		moveq	#0,d2

+ ;loc_168EC:
		lsr.w	#8,d2
		move.b	d2,anim_frame_timer(a0)
		addq.b	#1,anim_frame(a0)

locret_168F6:
		rts
; ---------------------------------------------------------------------------

loc_168F8:
		move.b	flip_angle(a0),d0
		moveq	#0,d1
		move.b	status(a0),d2
		andi.b	#1,d2
		bne.s	+ ;loc_16926
		andi.b	#$FC,render_flags(a0)
		addi.b	#$16,d0
		divu.w	#$2C,d0
		addi.b	#$15,d0
		move.b	d0,mapping_frame(a0)
		move.b	#0,anim_frame_timer(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_16926:
		andi.b	#$FC,render_flags(a0)
		tst.b	flip_type(a0)
		bpl.s	+ ;loc_1693E
		ori.b	#1,render_flags(a0)
		addi.b	#$16,d0
		bra.s	++ ;loc_1694A
; ---------------------------------------------------------------------------

+ ;loc_1693E:
		ori.b	#3,render_flags(a0)
		neg.b	d0
		addi.b	#$9A,d0

+ ;loc_1694A:
		divu.w	#$2C,d0
		addi.b	#$15,d0
		move.b	d0,mapping_frame(a0)
		move.b	#0,anim_frame_timer(a0)
		rts
; ---------------------------------------------------------------------------

loc_1695E:
		subq.b	#1,anim_frame_timer(a0)
		bpl.w	locret_16812
		addq.b	#1,d0
		bne.s	loc_169E4
		move.w	ground_vel(a0),d2
		bpl.s	+ ;loc_16972
		neg.w	d2

+ ;loc_16972:
		lea	(AniTails2P03).l,a1
		cmpi.w	#$600,d2
		bhs.s	+ ;loc_16984
		lea	(AniTails2P02).l,a1

+ ;loc_16984:
		neg.w	d2
		addi.w	#$400,d2
		bpl.s	+ ;loc_1698E
		moveq	#0,d2

+ ;loc_1698E:
		lsr.w	#8,d2
		move.b	d2,anim_frame_timer(a0)
		move.b	status(a0),d1
		andi.b	#1,d1
		andi.b	#$FC,render_flags(a0)
		or.b	d1,render_flags(a0)
		bra.w	sub_167FA
; ---------------------------------------------------------------------------

loc_169AA:
		subq.b	#1,anim_frame_timer(a0)
		bpl.w	locret_16812
		move.w	ground_vel(a0),d2
		bmi.s	+ ;loc_169BA
		neg.w	d2

+ ;loc_169BA:
		addi.w	#$800,d2
		bpl.s	+ ;loc_169C2
		moveq	#0,d2

+ ;loc_169C2:
		lsr.w	#6,d2
		move.b	d2,anim_frame_timer(a0)
		lea	(AniTails2P04).l,a1
		move.b	status(a0),d1
		andi.b	#1,d1
		andi.b	#$FC,render_flags(a0)
		or.b	d1,render_flags(a0)
		bra.w	sub_167FA
; ---------------------------------------------------------------------------

loc_169E4:
		move.w	x_vel(a2),d1
		move.w	y_vel(a2),d2
		jsr	(GetArcTan).l
		moveq	#0,d1
		move.b	status(a0),d2
		andi.b	#1,d2
		bne.s	+ ;loc_16A02
		not.b	d0
		bra.s	++ ;loc_16A06
; ---------------------------------------------------------------------------

+ ;loc_16A02:
		addi.b	#$80,d0

+ ;loc_16A06:
		addi.b	#$10,d0
		bpl.s	+ ;loc_16A0E
		moveq	#3,d1

+ ;loc_16A0E:
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
		bsr.w	sub_167FA
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
		bmi.s	locret_16B80
		move.l	#ArtUnc_Tails2P_Tail,d6
		move.w	#tiles_to_bytes(ArtTile_Player_2_Tail),d4
		cmpa.w	#Tails_tails,a0
		beq.s	+ ;loc_16B58
		move.w	#tiles_to_bytes($690),d4
		bra.s	+ ;loc_16B58
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
		bmi.s	locret_16B80
		move.l	#ArtUnc_Tails2P,d6
		move.w	#tiles_to_bytes(ArtTile_Player_1),d4
		cmpa.w	#Player_1,a0
		beq.s	+ ;loc_16B58
		move.w	#tiles_to_bytes(ArtTile_Player_2),d4

/ ;loc_16B58:
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
		dbf	d5,- ;loc_16B58

locret_16B80:
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
		bpl.s	+ ;loc_16BE2
		ori.w	#high_priority,art_tile(a0)

+ ;loc_16BE2:
		moveq	#0,d0
		move.b	anim(a2),d0
		btst	#Status_Push,status(a2)
		beq.s	+ ;loc_16BF8
		tst.b	(WindTunnel_flag_P2).w
		bne.s	+ ;loc_16BF8
		moveq	#4,d0

+ ;loc_16BF8:
		cmp.b	objoff_34(a0),d0	; Has the input parent anim changed since last check?
		beq.s	+ ;loc_16C08		; If not, branch and skip setting a matching Tails' Tails anim
		move.b	d0,objoff_34(a0)	; Store d0 for the above comparision
		move.b	Obj_Tails_Tail_AniSelection(pc,d0.w),anim(a0)	; Load anim relative to parent's

+ ;loc_16C08:
		lea	(AniTails_Tail).l,a1
		bsr.w	Animate_Tails_Part2
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
		beq.s	+ ;loc_16CCC
		move.w	#make_art_tile($690,0,0),art_tile(a0)

+ ;loc_16CCC:
		move.w	#$100,priority(a0)
		move.b	#$18,width_pixels(a0)
		move.b	#$18,height_pixels(a0)
		move.b	#4,render_flags(a0)
		move.l	#loc_16CEA,(a0)

loc_16CEA:
		movea.w	$30(a0),a2
		move.b	angle(a2),angle(a0)
		move.b	status(a2),status(a0)
		move.w	x_pos(a2),x_pos(a0)
		move.w	y_pos(a2),y_pos(a0)
		move.w	priority(a2),priority(a0)
		andi.w	#drawing_mask,art_tile(a0)
		tst.w	art_tile(a2)
		bpl.s	+ ;loc_16D1E
		ori.w	#high_priority,art_tile(a0)

+ ;loc_16D1E:
		moveq	#0,d0
		move.b	anim(a2),d0
		btst	#Status_Push,status(a2)
		beq.s	+ ;loc_16D34
		cmpi.b	#5,d0
		beq.s	+ ;loc_16D34
		moveq	#4,d0

+ ;loc_16D34:
		cmp.b	$34(a0),d0
		beq.s	+ ;loc_16D44
		move.b	d0,$34(a0)
		move.b	byte_16D58(pc,d0.w),anim(a0)

+ ;loc_16D44:
		lea	(AniTails2P_Tail).l,a1
		bsr.w	Animate_Tails_Tail2P
		bsr.w	Tails2P_Tail_Load_PLC
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
byte_16D58:
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
		beq.w	loc_16E88
		move.w	(Camera_X_pos).w,d0
		addi.w	#$40,d0
		move.w	d0,x_pos(a0)
		move.w	(Camera_Y_pos).w,d0
		addi.w	#$100,d0
		move.w	d0,y_pos(a0)
		lea	(Player_2).w,a1
		tst.b	render_flags(a1)
		bmi.s	+ ;loc_16DE0
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		subq.w	#1,y_pos(a1)
		move.l	#Obj_Tails,(Player_2).w
		move.w	#$12,(Tails_CPU_routine).w
		move.w	#0,(Flying_carrying_Sonic_flag).w

+ ;loc_16DE0:
		move.w	#$168,$30(a0)
		move.l	#loc_16DEC,(a0)

loc_16DEC:
		subq.w	#1,$30(a0)
		bne.s	loc_16DF8
		move.l	#loc_16DF8,(a0)

loc_16DF8:
		tst.b	(Flying_carrying_Sonic_flag).w
		bne.s	++ ;loc_16E3C
		lea	(Player_1).w,a1
		move.w	y_pos(a0),d0
		cmp.w	y_pos(a1),d0
		bhs.s	++ ;loc_16E3C
		move.w	d0,y_pos(a1)
		move.w	#0,x_vel(a1)
		move.w	#0,y_vel(a1)
		move.w	#0,ground_vel(a1)
		move.b	#0,spin_dash_flag(a1)
		cmpi.w	#$14,(Tails_CPU_routine).w
		blo.s	+ ;loc_16E36
		move.w	x_pos(a1),x_pos(a0)

+ ;loc_16E36:
		move.b	#2,routine(a1)

+ ;loc_16E3C:
		tst.b	(Player_1+render_flags).w
		bmi.s	locret_16E86
		cmpi.b	#2,(Player_1+routine).w
		bne.s	locret_16E86
		lea	(Player_2).w,a1
		move.w	y_pos(a0),d0
		cmp.w	y_pos(a1),d0
		bhs.s	locret_16E86
		move.w	#$12,(Tails_CPU_routine).w
		tst.w	$30(a0)
		bne.s	locret_16E86
		move.w	d0,y_pos(a1)
		move.b	#2,routine(a1)
		move.b	#0,object_control(a1)
		move.b	#0,spin_dash_flag(a1)
		move.w	x_pos(a0),x_pos(a1)
		move.w	#$14,(Tails_CPU_routine).w

locret_16E86:
		rts
; ---------------------------------------------------------------------------

loc_16E88:
		move.w	(Camera_X_pos).w,d0
		addi.w	#$40,d0
		move.w	d0,x_pos(a0)
		move.w	(Camera_Y_pos).w,d0
		addi.w	#$100,d0
		move.w	d0,y_pos(a0)
		move.w	#$168,$30(a0)
		move.l	#loc_16EAC,(a0)

loc_16EAC:
		subq.w	#1,$30(a0)
		bne.s	loc_16EC2
		move.l	#loc_16EC2,(a0)
		lea	(Player_1).w,a1
		move.w	x_pos(a0),x_pos(a1)

loc_16EC2:
		lea	(Player_1).w,a1
		move.w	y_pos(a0),d0
		cmp.w	y_pos(a1),d0
		bhs.s	locret_16EFA
		move.w	d0,y_pos(a1)
		addq.w	#8,y_pos(a1)
		tst.w	$30(a0)
		bne.s	locret_16EFA
		move.w	d0,y_pos(a1)
		move.b	#2,routine(a1)
		move.b	#0,object_control(a1)
		move.b	#0,spin_dash_flag(a1)
		move.w	#$1A,(Tails_CPU_routine).w

locret_16EFA:
		rts

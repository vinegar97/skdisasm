Obj_Sonic2P:
		cmpa.w	#Player_1,a0
		bne.s	loc_105F2
		lea	(Max_speed).w,a4
		lea	(Distance_from_top).w,a5
		lea	(Dust).w,a6
		move.b	(Player_2+character_id).w,d0
		cmp.b	character_id(a0),d0
		bne.s	loc_105E6
		bchg	#3,render_flags(a0)

loc_105E6:
		tst.w	(Debug_placement_mode).w
		beq.s	loc_1060E
		jmp	(DebugMode).l
; ---------------------------------------------------------------------------

loc_105F2:
		lea	(Max_speed_P2).w,a4
		lea	(Distance_from_top_P2).w,a5
		lea	(Dust_P2).w,a6
		move.b	(Player_1+character_id).w,d0
		cmp.b	character_id(a0),d0
		bne.s	loc_1060E
		bchg	#4,render_flags(a0)

loc_1060E:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	Sonic2P_Index(pc,d0.w),d1
		jmp	Sonic2P_Index(pc,d1.w)
; ---------------------------------------------------------------------------
Sonic2P_Index:
		dc.w loc_10628-Sonic2P_Index
		dc.w loc_10740-Sonic2P_Index
		dc.w loc_122BE-Sonic2P_Index
		dc.w loc_12390-Sonic2P_Index
		dc.w loc_1257C-Sonic2P_Index
		dc.w loc_12590-Sonic2P_Index
; ---------------------------------------------------------------------------

loc_10628:
		addq.b	#2,routine(a0)
		move.b	#$B,y_radius(a0)
		move.b	#5,x_radius(a0)
		move.b	#$B,default_y_radius(a0)
		move.b	#5,default_x_radius(a0)
		move.w	#$100,priority(a0)
		move.b	#$C,width_pixels(a0)
		move.b	#$C,height_pixels(a0)
		move.b	#4,render_flags(a0)
		lea	(Character_Speeds).l,a1
		moveq	#0,d0
		move.b	character_id(a0),d0
		lsl.w	#3,d0
		lea	(a1,d0.w),a1
		move.w	(a1)+,Max_speed-Max_speed(a4)
		move.w	(a1)+,Acceleration-Max_speed(a4)
		move.w	(a1)+,Deceleration-Max_speed(a4)
		tst.b	(Last_star_post_hit).w
		bne.w	loc_10724
		move.b	#$C,top_solid_bit(a0)
		move.b	#$D,lrb_solid_bit(a0)
		cmpa.w	#Player_1,a0
		bne.s	loc_106DC
		move.w	#make_art_tile(ArtTile_Player_1,0,0),art_tile(a0)
		move.l	#Map_Sonic2P,mappings(a0)
		tst.b	character_id(a0)
		beq.s	loc_106B4
		move.l	#Map_Knuckles2P,mappings(a0)
		addi.w	#palette_line_1,art_tile(a0)

loc_106B4:
		cmpi.b	#$12,(Current_zone).w
		bne.s	loc_106C2
		ori.w	#high_priority,art_tile(a0)

loc_106C2:
		move.w	x_pos(a0),(Saved_X_pos).w
		move.w	y_pos(a0),(Saved_Y_pos).w
		move.w	art_tile(a0),(Saved_art_tile).w
		move.w	top_solid_bit(a0),(Saved_solid_bits).w
		bra.s	loc_10724
; ---------------------------------------------------------------------------

loc_106DC:
		move.w	#make_art_tile(ArtTile_Player_2,0,0),art_tile(a0)
		move.l	#Map_Sonic2P,mappings(a0)
		tst.b	character_id(a0)
		beq.s	loc_106FE
		move.l	#Map_Knuckles2P,mappings(a0)
		addi.w	#palette_line_1,art_tile(a0)

loc_106FE:
		cmpi.b	#$12,(Current_zone).w
		bne.s	loc_1070C
		ori.w	#high_priority,art_tile(a0)

loc_1070C:
		move.w	x_pos(a0),(Saved2_X_pos).w
		move.w	y_pos(a0),(Saved2_Y_pos).w
		move.w	art_tile(a0),(Saved2_art_tile).w
		move.w	top_solid_bit(a0),(Saved2_solid_bits).w

loc_10724:
		move.b	#0,flips_remaining(a0)
		move.b	#4,flip_speed(a0)
		move.b	#0,(Super_Sonic_Knux_flag).w
		move.b	#30,air_left(a0)
		bsr.w	Reset_Player_Position_Array

loc_10740:
		tst.w	(Debug_mode_flag).w
		beq.s	loc_10760
		cmpa.w	#Player_1,a0
		bne.s	loc_10760
		btst	#button_B,(Ctrl_1_pressed).w
		beq.s	loc_10760
		move.w	#1,(Debug_placement_mode).w
		clr.b	(Ctrl_1_locked).w
		rts
; ---------------------------------------------------------------------------

loc_10760:
		cmpa.w	#Player_1,a0
		bne.s	loc_10774
		tst.b	(Ctrl_1_locked).w
		bne.s	loc_10780
		move.w	(Ctrl_1).w,(Ctrl_1_logical).w
		bra.s	loc_10780
; ---------------------------------------------------------------------------

loc_10774:
		tst.b	(Ctrl_2_locked).w
		bne.s	loc_10780
		move.w	(Ctrl_2).w,(Ctrl_1_logical).w

loc_10780:
		bsr.w	Sonic_Display
		btst	#0,object_control(a0)
		bne.s	loc_1079E
		moveq	#0,d0
		move.b	status(a0),d0
		andi.w	#6,d0
		move.w	off_107EE(pc,d0.w),d1
		jsr	off_107EE(pc,d1.w)

loc_1079E:
		cmpi.w	#-$100,(Camera_min_Y_pos).w
		bne.s	loc_107AE
		move.w	(Screen_Y_wrap_value).w,d0
		and.w	d0,y_pos(a0)

loc_107AE:
		move.w	(Screen_X_wrap_value).w,d0
		and.w	d0,x_pos(a0)
		addi.w	#$400,x_pos(a0)
		bsr.w	Sonic_RecordPos
		move.b	(Primary_Angle).w,next_tilt(a0)
		move.b	(Secondary_Angle).w,tilt(a0)
		btst	#1,object_control(a0)
		bne.s	loc_107DC
		bsr.w	Animate_SonicKnuckles_2P
		bsr.w	SonicKnuckles2P_Load_PLC

loc_107DC:
		move.b	object_control(a0),d0
		andi.b	#$A0,d0
		bne.s	locret_107EC
		jsr	(TouchResponse_CompetitionMode).l

locret_107EC:
		rts
; ---------------------------------------------------------------------------
off_107EE:
		dc.w loc_107F6-off_107EE
		dc.w loc_10868-off_107EE
		dc.w loc_10896-off_107EE
		dc.w loc_108B8-off_107EE
; ---------------------------------------------------------------------------

loc_107F6:
		move.b	(Ctrl_1_pressed_logical).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0
		bne.s	loc_10844
		cmpi.b	#$A,anim(a0)
		beq.s	locret_10866
		cmpi.b	#$B,anim(a0)
		beq.s	locret_10866
		cmpi.b	#5,anim(a0)
		bne.s	loc_10844
		cmpi.b	#$1E,anim_frame(a0)
		blo.s	loc_10844
		bsr.w	Player_SlopeResist
		move.b	(Ctrl_1_logical).w,d0
		andi.b	#$7F,d0
		beq.s	loc_1085E
		move.b	#$A,anim(a0)
		cmpi.b	#$AC,anim_frame(a0)
		blo.s	loc_1085E
		move.b	#$B,anim(a0)
		bra.s	loc_1085E
; ---------------------------------------------------------------------------

loc_10844:
		bsr.w	sub_1094C
		bsr.w	Sonic_Jump
		bsr.w	Player_SlopeResist
		bsr.w	Sonic_Move
		bsr.w	sub_108E6
		jsr	(MoveSprite2).l

loc_1085E:
		bsr.w	Player_AnglePos
		bsr.w	Player_SlopeRepel

locret_10866:
		rts
; ---------------------------------------------------------------------------

loc_10868:
		bsr.w	Sonic_JumpHeight
		bsr.w	Sonic_ChgJumpDir
		jsr	(MoveSprite).l
		btst	#Status_Underwater,status(a0)
		beq.s	loc_10884
		subi.w	#$28,y_vel(a0)

loc_10884:
		bsr.w	Player_JumpAngle
		movem.l	a4-a6,-(sp)
		bsr.w	SonicKnux_DoLevelCollision
		movem.l	(sp)+,a4-a6
		rts
; ---------------------------------------------------------------------------

loc_10896:
		tst.b	spin_dash_flag(a0)
		bne.s	loc_108A0
		bsr.w	Sonic_Jump

loc_108A0:
		bsr.w	Player_RollRepel
		bsr.w	Sonic_RollSpeed
		jsr	(MoveSprite2).l
		bsr.w	Player_AnglePos
		bsr.w	Player_SlopeRepel
		rts
; ---------------------------------------------------------------------------

loc_108B8:
		bsr.w	Sonic_JumpHeight
		bsr.w	Sonic_ChgJumpDir
		jsr	(MoveSprite).l
		btst	#Status_Underwater,status(a0)
		beq.s	loc_108D4
		subi.w	#$28,y_vel(a0)

loc_108D4:
		bsr.w	Player_JumpAngle
		movem.l	a4-a6,-(sp)
		bsr.w	SonicKnux_DoLevelCollision
		movem.l	(sp)+,a4-a6
		rts

; =============== S U B R O U T I N E =======================================


sub_108E6:
		tst.b	status_secondary(a0)
		bmi.s	locret_1090C
		move.w	ground_vel(a0),d0
		bpl.s	loc_108F4
		neg.w	d0

loc_108F4:
		cmpi.w	#$80,d0
		blo.s	locret_1090C
		move.b	(Ctrl_1_logical).w,d0
		andi.b	#button_left_mask|button_right_mask,d0
		bne.s	locret_1090C
		btst	#button_down,(Ctrl_1_held_logical).w
		bne.s	loc_1090E

locret_1090C:
		rts
; ---------------------------------------------------------------------------

loc_1090E:
		btst	#2,status(a0)
		beq.s	loc_10918
		rts
; ---------------------------------------------------------------------------

loc_10918:
		bset	#Status_Roll,status(a0)
		move.b	#7,y_radius(a0)
		move.b	#3,x_radius(a0)
		move.b	#2,anim(a0)
		addq.w	#4,y_pos(a0)
		move.w	#sfx_Roll,d0
		jsr	(Play_SFX).l
		tst.w	ground_vel(a0)
		bne.s	locret_1094A
		move.w	#$200,ground_vel(a0)

locret_1094A:
		rts
; End of function sub_108E6


; =============== S U B R O U T I N E =======================================


sub_1094C:
		tst.b	spin_dash_flag(a0)
		bne.s	loc_10998
		cmpi.b	#8,anim(a0)
		bne.s	locret_10996
		move.b	(Ctrl_1_pressed_logical).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0
		beq.w	locret_10996
		move.b	#9,anim(a0)
		move.w	#signextendB(sfx_Spindash),d0
		jsr	(Play_SFX).l
		addq.l	#4,sp
		move.b	#1,spin_dash_flag(a0)
		move.w	#0,spin_dash_counter(a0)
		cmpi.b	#12,air_left(a0)
		blo.s	loc_10992
		move.b	#2,anim(a6)

loc_10992:
		bsr.w	Player_AnglePos

locret_10996:
		rts
; ---------------------------------------------------------------------------

loc_10998:
		move.b	(Ctrl_1_logical).w,d0
		btst	#button_down,d0
		bne.w	loc_10A38
		move.b	#7,y_radius(a0)
		move.b	#3,x_radius(a0)
		move.b	#2,anim(a0)
		addq.w	#4,y_pos(a0)
		move.b	#0,spin_dash_flag(a0)
		moveq	#0,d0
		move.b	spin_dash_counter(a0),d0
		add.w	d0,d0
		move.w	word_10A14(pc,d0.w),ground_vel(a0)
		move.w	ground_vel(a0),d0
		subi.w	#$800,d0
		add.w	d0,d0
		andi.w	#$1F00,d0
		neg.w	d0
		addi.w	#$2000,d0
		lea	(H_scroll_frame_offset).w,a1
		cmpa.w	#Player_1,a0
		beq.s	loc_109F0
		lea	(H_scroll_frame_offset_P2).w,a1

loc_109F0:
		move.w	d0,(a1)
		btst	#Status_Facing,status(a0)
		beq.s	loc_109FE
		neg.w	ground_vel(a0)

loc_109FE:
		bset	#Status_Roll,status(a0)
		move.b	#0,anim(a6)
		moveq	#signextendB(sfx_Dash),d0
		jsr	(Play_SFX).l
		bra.s	loc_10A80
; ---------------------------------------------------------------------------
word_10A14:
		dc.w   $800
		dc.w   $880
		dc.w   $900
		dc.w   $980
		dc.w   $A00
		dc.w   $A80
		dc.w   $B00
		dc.w   $B80
		dc.w   $C00
word_10A26:
		dc.w   $B00
		dc.w   $B80
		dc.w   $C00
		dc.w   $C80
		dc.w   $D00
		dc.w   $D80
		dc.w   $E00
		dc.w   $E80
		dc.w   $F00
; ---------------------------------------------------------------------------

loc_10A38:
		tst.w	spin_dash_counter(a0)
		beq.s	loc_10A50
		move.w	spin_dash_counter(a0),d0
		lsr.w	#5,d0
		sub.w	d0,spin_dash_counter(a0)
		bcc.s	loc_10A50
		move.w	#0,spin_dash_counter(a0)

loc_10A50:
		move.b	(Ctrl_1_pressed_logical).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0
		beq.w	loc_10A80
		move.w	#9<<8,anim(a0)	; and prev_anim
		move.w	#signextendB(sfx_Spindash),d0
		jsr	(Play_SFX).l
		addi.w	#$200,spin_dash_counter(a0)
		cmpi.w	#$800,spin_dash_counter(a0)
		blo.s	loc_10A80
		move.w	#$800,spin_dash_counter(a0)

loc_10A80:
		addq.l	#4,sp
		cmpi.w	#$60,(a5)
		beq.s	loc_10A8E
		bcc.s	loc_10A8C
		addq.w	#4,(a5)

loc_10A8C:
		subq.w	#2,(a5)

loc_10A8E:
		bsr.w	Player_AnglePos
		rts
; End of function sub_1094C

; ---------------------------------------------------------------------------

Obj_Sonic:
		; Load some addresses into registers
		; This is done to allow some subroutines to be
		; shared with Tails/Knuckles.
		lea	(Max_speed).w,a4
		lea	(Distance_from_top).w,a5
		lea	(Dust).w,a6

		tst.w	(Debug_placement_mode).w
		beq.s	Sonic_Normal

		; Debug only code
		cmpi.b	#1,(Debug_placement_type).w	; Is Sonic in debug object placement mode?
		beq.s	JmpTo_DebugMode			; If so, skip to debug mode routine
		; By this point, we're assuming you're in frame cycling mode
		btst	#button_B,(Ctrl_1_pressed).w
		beq.s	loc_10ABC
		move.w	#0,(Debug_placement_mode).w	; Leave debug mode

loc_10ABC:
		addq.b	#1,mapping_frame(a0)		; Next frame
		cmpi.b	#$FB,mapping_frame(a0)		; Have we reached the end of Sonic's frames?
		blo.s	loc_10ACE
		move.b	#0,mapping_frame(a0)		; If so, reset to Sonic's first frame

loc_10ACE:
		bsr.w	Sonic_Load_PLC
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

JmpTo_DebugMode:
		jmp	(DebugMode).l
; ---------------------------------------------------------------------------

Sonic_Normal:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	Sonic_Index(pc,d0.w),d1
		jmp	Sonic_Index(pc,d1.w)
; ---------------------------------------------------------------------------
Sonic_Index:
		dc.w Sonic_Init-Sonic_Index	;  0
		dc.w Sonic_Control-Sonic_Index	;  2
		dc.w loc_122BE-Sonic_Index	;  4
		dc.w loc_12390-Sonic_Index	;  6
		dc.w loc_1257C-Sonic_Index	;  8
		dc.w loc_12590-Sonic_Index	; $A
		dc.w loc_125AC-Sonic_Index	; $C
; ---------------------------------------------------------------------------

Sonic_Init:	; Routine 0
		addq.b	#2,routine(a0)		; => Sonic_Control
		move.b	#$13,y_radius(a0)	; this sets Sonic's collision height (2*pixels)
		move.b	#9,x_radius(a0)
		move.b	#$13,default_y_radius(a0)
		move.b	#9,default_x_radius(a0)
		move.l	#Map_Sonic,mappings(a0)
		move.w	#$100,priority(a0)
		move.b	#$18,width_pixels(a0)
		move.b	#$18,height_pixels(a0)
		move.b	#4,render_flags(a0)
		move.b	#0,character_id(a0)
		move.w	#$600,Max_speed-Max_speed(a4)
		move.w	#$C,Acceleration-Max_speed(a4)
		move.w	#$80,Deceleration-Max_speed(a4)
		tst.b	(Last_star_post_hit).w
		bne.s	Sonic_Init_Continued
		; only happens when not starting at a checkpoint:
		move.w	#make_art_tile(ArtTile_Player_1,0,0),art_tile(a0)
		move.b	#$C,top_solid_bit(a0)
		move.b	#$D,lrb_solid_bit(a0)
		cmpi.b	#2,(Special_bonus_entry_flag).w
		beq.s	Sonic_Init_Continued
		; only happens when not starting at a Special Stage ring:
		move.w	x_pos(a0),(Saved_X_pos).w
		move.w	y_pos(a0),(Saved_Y_pos).w
		move.w	art_tile(a0),(Saved_art_tile).w
		move.w	top_solid_bit(a0),(Saved_solid_bits).w

Sonic_Init_Continued:
		move.b	#0,flips_remaining(a0)
		move.b	#4,flip_speed(a0)
		move.b	#0,(Super_Sonic_Knux_flag).w
		move.b	#30,air_left(a0)
		subi.w	#$20,x_pos(a0)
		addi.w	#4,y_pos(a0)
		bsr.w	Reset_Player_Position_Array
		addi.w	#$20,x_pos(a0)
		subi.w	#4,y_pos(a0)
		rts

; ---------------------------------------------------------------------------
; Normal state for Sonic
; ---------------------------------------------------------------------------

Sonic_Control:	; Routine 2
		tst.w	(Debug_mode_flag).w		; is debug cheat enabled?
		beq.s	loc_10BF0			; if not, branch
		bclr	#button_A,(Ctrl_1_pressed).w	; is button A pressed?
		beq.s	loc_10BCE			; if not, branch
		eori.b	#1,(Reverse_gravity_flag).w	; toggle reverse gravity

loc_10BCE:
		btst	#button_B,(Ctrl_1_pressed).w	; is button B pressed?
		beq.s	loc_10BF0			; if not, branch
		move.w	#1,(Debug_placement_mode).w	; change Sonic into a ring/item
		clr.b	(Ctrl_1_locked).w		; unlock control
		btst	#button_C,(Ctrl_1_held).w	; was button C held before pressing B?
		beq.s	locret_10BEE			; if not, branch
		move.w	#2,(Debug_placement_mode).w	; enter animation cycle mode

locret_10BEE:
		rts
; ---------------------------------------------------------------------------

loc_10BF0:
		tst.b	(Ctrl_1_locked).w		; are controls locked?
		bne.s	loc_10BFC			; if yes, branch
		move.w	(Ctrl_1).w,(Ctrl_1_logical).w	; copy new held buttons, to enable joypad control

loc_10BFC:
		btst	#0,object_control(a0)	; is Sonic interacting with another object that holds him in place or controls his movement somehow?
		beq.s	loc_10C0C		; if yes, branch to skip Sonic's control
		move.b	#0,double_jump_flag(a0)	; enable double jump
		bra.s	loc_10C26
; ---------------------------------------------------------------------------

loc_10C0C:
		movem.l	a4-a6,-(sp)
		moveq	#0,d0
		move.b	status(a0),d0
		andi.w	#6,d0
		move.w	Sonic_Modes(pc,d0.w),d1
		jsr	Sonic_Modes(pc,d1.w)	; run Sonic's movement control code
		movem.l	(sp)+,a4-a6

loc_10C26:
		cmpi.w	#-$100,(Camera_min_Y_pos).w	; is vertical wrapping enabled?
		bne.s	loc_10C36			; if not, branch
		move.w	(Screen_Y_wrap_value).w,d0
		and.w	d0,y_pos(a0)			; perform wrapping of Sonic's y position

loc_10C36:
		bsr.s	Sonic_Display
		bsr.w	SonicKnux_SuperHyper
		bsr.w	Sonic_RecordPos
		bsr.w	Sonic_Water
		move.b	(Primary_Angle).w,next_tilt(a0)
		move.b	(Secondary_Angle).w,tilt(a0)
		tst.b	(WindTunnel_flag).w
		beq.s	loc_10C62
		tst.b	anim(a0)
		bne.s	loc_10C62
		move.b	prev_anim(a0),anim(a0)

loc_10C62:
		btst	#1,object_control(a0)
		bne.s	loc_10C7E
		bsr.w	Animate_Sonic
		tst.b	(Reverse_gravity_flag).w
		beq.s	loc_10C7A
		eori.b	#2,render_flags(a0)

loc_10C7A:
		bsr.w	Sonic_Load_PLC

loc_10C7E:
		move.b	object_control(a0),d0
		andi.b	#$A0,d0
		bne.s	locret_10C8E
		jsr	(TouchResponse).l

locret_10C8E:
		rts
; ---------------------------------------------------------------------------
; secondary states under state Sonic_Control
Sonic_Modes:
		dc.w Sonic_MdNormal-Sonic_Modes
		dc.w Sonic_MdAir-Sonic_Modes
		dc.w Sonic_MdRoll-Sonic_Modes
		dc.w Sonic_MdJump-Sonic_Modes

; =============== S U B R O U T I N E =======================================


Sonic_Display:
		move.b	invulnerability_timer(a0),d0
		beq.s	loc_10CA6
		subq.b	#1,invulnerability_timer(a0)
		lsr.b	#3,d0
		bcc.s	Sonic_ChkInvin

loc_10CA6:
		jsr	(Draw_Sprite).l

Sonic_ChkInvin:	; Checks if invincibility has expired and disables it if it has.
		btst	#Status_Invincible,status_secondary(a0)
		beq.s	Sonic_ChkShoes
		tst.b	invincibility_timer(a0)
		beq.s	Sonic_ChkShoes	; If there wasn't any time left, that means we're in Super/Hyper mode
		move.b	(Level_frame_counter+1).w,d0
		andi.b	#7,d0
		bne.s	Sonic_ChkShoes
		subq.b	#1,invincibility_timer(a0)	; reduce invincibility_timer only on every 8th frame
		bne.s	Sonic_ChkShoes			; if time is still left, branch
		tst.b	(Boss_flag).w		; Don't change music if in a boss fight
		bne.s	Sonic_RmvInvin
		cmpi.b	#12,air_left(a0)	; Don't change music if drowning
		blo.s	Sonic_RmvInvin
		move.w	(Current_music).w,d0
		jsr	(Play_Music).l		; stop playing invincibility theme and resume normal level music

Sonic_RmvInvin:
		bclr	#Status_Invincible,status_secondary(a0)

Sonic_ChkShoes:	; Checks if Speed Shoes have expired and disables them if they have.
		btst	#Status_SpeedShoes,status_secondary(a0)	; does Sonic have speed shoes?
		beq.s	Sonic_ExitChk				; if so, branch
		tst.b	speed_shoes_timer(a0)
		beq.s	Sonic_ExitChk
		move.b	(Level_frame_counter+1).w,d0
		andi.b	#7,d0
		bne.s	Sonic_ExitChk
		subq.b	#1,speed_shoes_timer(a0)	; reduce speed_shoes_timer only on every 8th frame
		bne.s	Sonic_ExitChk
		tst.w	(Competition_mode).w		; is this Competition mode?
		bne.s	Sonic_ChkShoesCompetition	; if so, branch
		move.w	#$600,Max_speed-Max_speed(a4)		; set Max_speed
		move.w	#$C,Acceleration-Max_speed(a4)		; set Acceleration
		move.w	#$80,Deceleration-Max_speed(a4)		; set Deceleration
		tst.b	(Super_Sonic_Knux_flag).w
		beq.s	loc_10D32	; if Super/Hyper, set different values
		move.w	#$A00,Max_speed-Max_speed(a4)		; set Max_speed
		move.w	#$30,Acceleration-Max_speed(a4)		; set Acceleration
		move.w	#$100,Deceleration-Max_speed(a4)	; set Deceleration

loc_10D32:
		bclr	#Status_SpeedShoes,status_secondary(a0)
		moveq	#0,d0		; Slow down tempo
		jmp	(Change_Music_Tempo).l
; ---------------------------------------------------------------------------

Sonic_ExitChk:
		rts
; ---------------------------------------------------------------------------

Sonic_ChkShoesCompetition:
		lea	(Character_Speeds).l,a1
		moveq	#0,d0
		move.b	character_id(a0),d0
		lsl.w	#3,d0
		lea	(a1,d0.w),a1
		move.w	(a1)+,Max_speed-Max_speed(a4)
		move.w	(a1)+,Acceleration-Max_speed(a4)
		move.w	(a1)+,Deceleration-Max_speed(a4)
		bclr	#Status_SpeedShoes,status_secondary(a0)
		rts
; End of function Sonic_Display

; ---------------------------------------------------------------------------
; Subroutine to record Sonic's previous positions for invincibility stars
; and input/status flags for Tails' AI to follow
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Sonic_RecordPos:
		tst.w	(Competition_mode).w		; are we in Competition mode?
		bne.s	Sonic_RecordPosCompetition	; if so, branch
		cmpa.w	#Player_1,a0			; is Sonic the sidekick?
		bne.s	locret_10D9E			; if so, branch
		move.w	(Pos_table_index).w,d0
		lea	(Pos_table).w,a1
		lea	(a1,d0.w),a1
		move.w	x_pos(a0),(a1)+			; write location to pos_table
		move.w	y_pos(a0),(a1)+
		addq.b	#4,(Pos_table_index+1).w	; increment index as the post-increments did a1
		lea	(Stat_table).w,a1
		lea	(a1,d0.w),a1
		move.w	(Ctrl_1_logical).w,(a1)+
		move.b	status(a0),(a1)+
		move.b	art_tile(a0),(a1)+

locret_10D9E:
		rts
; ---------------------------------------------------------------------------

Sonic_RecordPosCompetition:
		cmpa.w	#Player_1,a0			; is object player 1?
		bne.s	Sonic_RecordPosCompetitionP2	; if not, branch
		move.w	(Pos_table_index).w,d0
		lea	(Pos_table).w,a1
		lea	(a1,d0.w),a1
		move.w	x_pos(a0),(a1)+			; write location to pos_table
		move.w	y_pos(a0),(a1)+
		addq.b	#4,(Pos_table_index+1).w	; increment index as the post-increments did a1
		rts
; ---------------------------------------------------------------------------

Sonic_RecordPosCompetitionP2:
		move.w	(Pos_table_index_P2).w,d0
		lea	(Stat_table).w,a1
		lea	(a1,d0.w),a1
		move.w	x_pos(a0),(a1)+			; write location to pos_table
		move.w	y_pos(a0),(a1)+
		addq.b	#4,(Pos_table_index_P2+1).w	; increment index as the post-increments did a1
		rts
; End of function Sonic_RecordPos


; =============== S U B R O U T I N E =======================================


Reset_Player_Position_Array:
		cmpa.w	#Player_1,a0			; is object player 1?
		bne.s	Reset_Player_Position_ArrayP2	; if not, branch
		lea	(Pos_table).w,a1
		lea	(Stat_table).w,a2
		move.w	#bytesToLcnt($100),d0

.loop:
		move.w	x_pos(a0),(a1)+			; write location to pos_table
		move.w	y_pos(a0),(a1)+
		move.l	#0,(a2)+
		dbf	d0,.loop
		move.w	#0,(Pos_table_index).w

Reset_Player_Position_ArrayP2:
		tst.w	(Competition_mode).w	; are we in Competition mode?
		beq.s	.return		; if not, branch
		lea	(Stat_table).w,a1
		move.w	#bytesToLcnt($100),d0

.loop:
		move.w	x_pos(a0),(a1)+
		move.w	y_pos(a0),(a1)+
		dbf	d0,.loop
		move.w	#0,(Pos_table_index_P2).w

.return:
		rts
; End of function Reset_Player_Position_Array

; ---------------------------------------------------------------------------
; Subroutine for Sonic when he's underwater
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Sonic_Water:
		tst.b	(Water_flag).w	; does level have water?
		bne.s	Sonic_InWater	; if yes, branch

locret_10E2C:
		rts
; ---------------------------------------------------------------------------

Sonic_InWater:
		move.w	(Water_level).w,d0
		cmp.w	y_pos(a0),d0	; is Sonic above the water?
		bge.s	Sonic_OutWater	; if yes, branch

		bset	#Status_Underwater,status(a0)	; set underwater flag
		bne.s	locret_10E2C	; if already underwater, branch

		addq.b	#1,(Water_entered_counter).w
		movea.l	a0,a1
		bsr.w	Player_ResetAirTimer
		move.l	#Obj_AirCountdown,(Breathing_bubbles).w	; load Sonic's breathing bubbles
		move.b	#$81,(Breathing_bubbles+subtype).w
		move.l	a0,(Breathing_bubbles+objoff_40).w
		move.w	#$300,Max_speed-Max_speed(a4)
		move.w	#6,Acceleration-Max_speed(a4)
		move.w	#$40,Deceleration-Max_speed(a4)
		tst.b	(Super_Sonic_Knux_flag).w
		beq.s	loc_10E82		; if Super/Hyper, set different values
		move.w	#$500,Max_speed-Max_speed(a4)
		move.w	#$18,Acceleration-Max_speed(a4)
		move.w	#$80,Deceleration-Max_speed(a4)

loc_10E82:
		tst.b	object_control(a0)
		bne.s	locret_10E2C
		asr	x_vel(a0)
		asr	y_vel(a0)		; memory operands can only be shifted one bit at a time
		asr	y_vel(a0)
		beq.s	locret_10E2C
		move.w	#1<<8,anim(a6)		; splash animation, write 1 to anim and clear prev_anim
		move.w	#sfx_Splash,d0
		jmp	(Play_SFX).l
; ---------------------------------------------------------------------------

Sonic_OutWater:
		bclr	#Status_Underwater,status(a0)	; unset underwater flag
		beq.w	locret_10E2C			; if already above water, branch
		addq.b	#1,(Water_entered_counter).w

		movea.l	a0,a1
		bsr.w	Player_ResetAirTimer
		move.w	#$600,Max_speed-Max_speed(a4)
		move.w	#$C,Acceleration-Max_speed(a4)
		move.w	#$80,Deceleration-Max_speed(a4)
		tst.b	(Super_Sonic_Knux_flag).w
		beq.s	loc_10EE0	; if Super/Hyper, set different values
		move.w	#$A00,Max_speed-Max_speed(a4)
		move.w	#$30,Acceleration-Max_speed(a4)
		move.w	#$100,Deceleration-Max_speed(a4)

loc_10EE0:
		cmpi.b	#4,routine(a0)	; is Sonic falling back from getting hurt?
		beq.s	loc_10EFC	; if yes, branch
		tst.b	object_control(a0)
		bne.s	loc_10EFC
		move.w	y_vel(a0),d0
		cmpi.w	#-$400,d0
		blt.s	loc_10EFC
		asl	y_vel(a0)

loc_10EFC:
		cmpi.b	#$1C,anim(a0)	; is Sonic in his 'blank' animation?
		beq.w	locret_10E2C	; if so, branch
		tst.w	y_vel(a0)
		beq.w	locret_10E2C
		move.w	#1<<8,anim(a6)	; splash animation, write 1 to anim and clear prev_anim
		cmpi.w	#-$1000,y_vel(a0)
		bgt.s	loc_10F22
		move.w	#-$1000,y_vel(a0)	; limit upward y velocity exiting the water

loc_10F22:
		move.w	#sfx_Splash,d0
		jmp	(Play_SFX).l
; End of function Sonic_Water

; ---------------------------------------------------------------------------
; ---------------------------------------------------------------------------
; Start of subroutine Obj01_MdNormal
; Called if Sonic is neither airborne nor rolling this frame
; ---------------------------------------------------------------------------

Sonic_MdNormal:
		bsr.w	SonicKnux_Spindash
		bsr.w	Sonic_Jump
		bsr.w	Player_SlopeResist
		bsr.w	Sonic_Move
		bsr.w	SonicKnux_Roll
		bsr.w	Player_LevelBound
		jsr	(MoveSprite_TestGravity2).l
		bsr.w	Call_Player_AnglePos
		bsr.w	Player_SlopeRepel
		tst.b	(Background_collision_flag).w
		beq.s	locret_10F82
		bsr.w	sub_F846
		tst.w	d1
		bmi.w	Kill_Character
		movem.l	a4-a6,-(sp)
		bsr.w	CheckLeftWallDist
		tst.w	d1
		bpl.s	loc_10F72
		sub.w	d1,x_pos(a0)

loc_10F72:
		bsr.w	CheckRightWallDist
		tst.w	d1
		bpl.s	loc_10F7E
		add.w	d1,x_pos(a0)

loc_10F7E:
		movem.l	(sp)+,a4-a6

locret_10F82:
		rts

; =============== S U B R O U T I N E =======================================


Call_Player_AnglePos:
		tst.b	(Reverse_gravity_flag).w
		beq.w	Player_AnglePos
		move.b	angle(a0),d0
		addi.b	#$40,d0
		neg.b	d0
		subi.b	#$40,d0
		move.b	d0,angle(a0)
		bsr.w	Player_AnglePos
		move.b	angle(a0),d0
		addi.b	#$40,d0
		neg.b	d0
		subi.b	#$40,d0
		move.b	d0,angle(a0)
		rts
; End of function Call_Player_AnglePos

; ---------------------------------------------------------------------------
; Start of subroutine Sonic_MdAir
; Called if Sonic is airborne, but not in a ball (thus, probably not jumping)

Sonic_MdAir:
		bsr.w	Sonic_JumpHeight
		bsr.w	Sonic_ChgJumpDir
		bsr.w	Player_LevelBound
		jsr	(MoveSprite_TestGravity).l
		btst	#Status_Underwater,status(a0)	; is Sonic underwater?
		beq.s	loc_10FD6			; if not, branch
		subi.w	#$28,y_vel(a0)			; reduce gravity by $28 ($38-$28=$10)

loc_10FD6:
		bsr.w	Player_JumpAngle
		bsr.w	SonicKnux_DoLevelCollision
		rts
; ---------------------------------------------------------------------------
; Start of subroutine Sonic_MdRoll
; Called if Sonic is in a ball, but not airborne (thus, probably rolling)

Sonic_MdRoll:
		tst.b	spin_dash_flag(a0)
		bne.s	loc_10FEA
		bsr.w	Sonic_Jump

loc_10FEA:
		bsr.w	Player_RollRepel
		bsr.w	Sonic_RollSpeed
		bsr.w	Player_LevelBound
		jsr	(MoveSprite_TestGravity2).l
		bsr.w	Call_Player_AnglePos
		bsr.w	Player_SlopeRepel
		tst.b	(Background_collision_flag).w
		beq.s	locret_11034
		bsr.w	sub_F846
		tst.w	d1
		bmi.w	Kill_Character
		movem.l	a4-a6,-(sp)
		bsr.w	CheckLeftWallDist
		tst.w	d1
		bpl.s	loc_11024
		sub.w	d1,x_pos(a0)

loc_11024:
		bsr.w	CheckRightWallDist
		tst.w	d1
		bpl.s	loc_11030
		add.w	d1,x_pos(a0)

loc_11030:
		movem.l	(sp)+,a4-a6

locret_11034:
		rts
; ---------------------------------------------------------------------------
; Start of subroutine Sonic_MdJump
; Called if Sonic is in a ball and airborne (he could be jumping but not necessarily)
; Notes: This is identical to Sonic_MdAir, at least at this outer level.
;        Why they gave it a separate copy of the code, I don't know.

Sonic_MdJump:
		bsr.w	Sonic_JumpHeight
		bsr.w	Sonic_ChgJumpDir
		bsr.w	Player_LevelBound
		jsr	(MoveSprite_TestGravity).l
		btst	#Status_Underwater,status(a0)	; is Sonic underwater?
		beq.s	loc_11056			; if not, branch
		subi.w	#$28,y_vel(a0)			; reduce gravity by $28 ($38-$28=$10)

loc_11056:
		bsr.w	Player_JumpAngle
		bsr.w	SonicKnux_DoLevelCollision
		rts

; ---------------------------------------------------------------------------
; Subroutine to make Sonic walk/run
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Sonic_Move:
		move.w	Max_speed-Max_speed(a4),d6	; set Max_speed
		move.w	Acceleration-Max_speed(a4),d5	; set Acceleration
		move.w	Deceleration-Max_speed(a4),d4	; set Deceleration
		tst.b	status_secondary(a0)	; is bit 7 set? (Infinite inertia)
		bmi.w	loc_11332		; if so, branch
		tst.w	move_lock(a0)
		bne.w	loc_112EA
		btst	#button_left,(Ctrl_1_held_logical).w	; is left being pressed?
		beq.s	Sonic_NotLeft			; if not, branch
		bsr.w	sub_113F6

Sonic_NotLeft:
		btst	#button_right,(Ctrl_1_held_logical).w	; is right being pressed?
		beq.s	Sonic_NotRight				; if not, branch
		bsr.w	sub_11482

Sonic_NotRight:
		move.b	angle(a0),d0
		addi.b	#$20,d0
		andi.b	#$C0,d0		; is Sonic on a slope?
		bne.w	loc_112EA	; if yes, branch
		tst.w	ground_vel(a0)	; is Sonic moving?
		bne.w	loc_112EA	; if yes, branch
		bclr	#Status_Push,status(a0)
		move.b	#5,anim(a0)	; use standing animation
		btst	#Status_OnObj,status(a0)
		beq.w	Sonic_Balance
		movea.w	interact(a0),a1	; load interacting object's RAM space
		tst.b	status(a1)	; is status bit 7 set? (unused?)
		bmi.w	loc_11276	; if so, branch

		; Calculations to determine where on the object Sonic is, and make him balance accordingly
		moveq	#0,d1			; Clear d1
		move.b	width_pixels(a1),d1	; Load interacting object's width into d1
		move.w	d1,d2			; Move to d2 for seperate calculations
		add.w	d2,d2			; Double object width, converting it to X pos' units of measurement
		subq.w	#2,d2			; Subtract 2: This is the margin for 'on edge'
		add.w	x_pos(a0),d1		; Add Sonic's X position to object width
		sub.w	x_pos(a1),d1		; Subtract object's X position from width+Sonic's X pos, giving you Sonic's distance from left edge of object
		tst.b	(Super_Sonic_Knux_flag).w	; is Sonic Super/Hyper?
		bne.w	SuperSonic_Balance		; if so, branch
		cmpi.w	#2,d1		; is Sonic within two units of object's left edge?
		blt.s	Sonic_BalanceOnObjLeft	; if so, branch
		cmp.w	d2,d1
		bge.s	Sonic_BalanceOnObjRight	; if Sonic is within two units of object's right edge, branch (Realistically, it checks this, and BEYOND the right edge of the object)
		bra.w	loc_11276	; if Sonic is more than 2 units from both edges, branch
; ---------------------------------------------------------------------------

SuperSonic_Balance:
		cmpi.w	#2,d1		; is Sonic within two units of object's left edge?
		blt.w	loc_11268	; if so, branch
		cmp.w	d2,d1
		bge.w	loc_11258	; if Sonic is within two units of object's right edge, branch (Realistically, it checks this, and BEYOND the right edge of the object)
		bra.w	loc_11276	; if Sonic is more than 2 units from both edges, branch
; ---------------------------------------------------------------------------
; balancing checks for when you're on the right edge of an object

Sonic_BalanceOnObjRight:
		btst	#Status_Facing,status(a0)	; is Sonic facing right?
		bne.s	loc_11128			; if so, branch
		move.b	#6,anim(a0)	; Balance animation 1
		addq.w	#6,d2		; extend balance range
		cmp.w	d2,d1		; is Sonic within (two units before and) four units past the right edge?
		blt.w	loc_112EA	; if so, branch
		move.b	#$C,anim(a0)	; if REALLY close to the edge, use different animation (Balance animation 2)
		bra.w	loc_112EA

loc_11128:
		; Somewhat dummied out/redundant code from Sonic 2
		; Originally, Sonic displayed different animations for each direction faced
		; But now, Sonic uses only the one set of animations no matter what, making the check pointless, and the code redundant
		bclr	#Status_Facing,status(a0)
		move.b	#6,anim(a0)	; Balance animation 1
		addq.w	#6,d2		; extend balance range
		cmp.w	d2,d1		; is Sonic within (two units before and) four units past the right edge?
		blt.w	loc_112EA	; if so, branch
		move.b	#$C,anim(a0)	; if REALLY close to the edge, use different animation (Balance animation 2)
		bra.w	loc_112EA
; ---------------------------------------------------------------------------

Sonic_BalanceOnObjLeft:
		btst	#Status_Facing,status(a0)	; is Sonic facing right?
		beq.s	loc_11166
		move.b	#6,anim(a0)	; Balance animation 1
		cmpi.w	#-4,d1		; is Sonic within (two units before and) four units past the left edge?
		bge.w	loc_112EA	; if so branch (instruction signed to match)
		move.b	#$C,anim(a0)	; if REALLY close to the edge, use different animation (Balance animation 2)
		bra.w	loc_112EA

loc_11166:
		; Somewhat dummied out/redundant code from Sonic 2
		; Originally, Sonic displayed different animations for each direction faced
		; But now, Sonic uses only the one set of animations no matter what, making the check pointless, and the code redundant
		bset	#Status_Facing,status(a0)	; is Sonic facing right?
		move.b	#6,anim(a0)	; Balance animation 1
		cmpi.w	#-4,d1		; is Sonic within (two units before and) four units past the left edge?
		bge.w	loc_112EA	; if so branch (instruction signed to match)
		move.b	#$C,anim(a0)	; if REALLY close to the edge, use different animation (Balance animation 2)
		bra.w	loc_112EA
; ---------------------------------------------------------------------------
; balancing checks for when you're on the edge of part of the level

Sonic_Balance:
		move.w	x_pos(a0),d3
		bsr.w	ChooseChkFloorEdge
		cmpi.w	#$C,d1
		blt.w	loc_11276
		tst.b	(Super_Sonic_Knux_flag).w	; is Sonic Super/Hyper?
		bne.w	loc_11250			; if so, branch
		cmpi.b	#3,next_tilt(a0)
		bne.s	loc_111F6
		btst	#Status_Facing,status(a0)
		bne.s	loc_111CE
		move.b	#6,anim(a0)
		move.w	x_pos(a0),d3
		subq.w	#6,d3
		bsr.w	ChooseChkFloorEdge
		cmpi.w	#$C,d1
		blt.w	loc_112EA
		move.b	#$C,anim(a0)
		bra.w	loc_112EA
		; on right edge but facing left:

loc_111CE:
		; Somewhat dummied out/redundant code from Sonic 2
		; Originally, Sonic displayed different animations for each direction faced
		; But now, Sonic uses only the one set of animations no matter what, making the check pointless, and the code redundant
		bclr	#Status_Facing,status(a0)
		move.b	#6,anim(a0)
		move.w	x_pos(a0),d3
		subq.w	#6,d3
		bsr.w	ChooseChkFloorEdge
		cmpi.w	#$C,d1
		blt.w	loc_112EA
		move.b	#$C,anim(a0)
		bra.w	loc_112EA
; ---------------------------------------------------------------------------

loc_111F6:
		cmpi.b	#3,tilt(a0)
		bne.s	loc_11276
		btst	#Status_Facing,status(a0)
		beq.s	loc_11228
		move.b	#6,anim(a0)
		move.w	x_pos(a0),d3
		addq.w	#6,d3
		bsr.w	ChooseChkFloorEdge
		cmpi.w	#$C,d1
		blt.w	loc_112EA
		move.b	#$C,anim(a0)
		bra.w	loc_112EA
; ---------------------------------------------------------------------------

loc_11228:
		bset	#Status_Facing,status(a0)
		move.b	#6,anim(a0)
		move.w	x_pos(a0),d3
		addq.w	#6,d3
		bsr.w	ChooseChkFloorEdge
		cmpi.w	#$C,d1
		blt.w	loc_112EA
		move.b	#$C,anim(a0)
		bra.w	loc_112EA
; ---------------------------------------------------------------------------

loc_11250:
		cmpi.b	#3,next_tilt(a0)
		bne.s	loc_11260

loc_11258:
		bclr	#Status_Facing,status(a0)
		bra.s	loc_1126E
; ---------------------------------------------------------------------------

loc_11260:
		cmpi.b	#3,tilt(a0)
		bne.s	loc_11276

loc_11268:
		bset	#Status_Facing,status(a0)

loc_1126E:
		move.b	#6,anim(a0)
		bra.s	loc_112EA
; ---------------------------------------------------------------------------

loc_11276:
		btst	#button_down,(Ctrl_1_logical).w
		beq.s	loc_112B0
		move.b	#8,anim(a0)
		addq.b	#1,scroll_delay_counter(a0)
		cmpi.b	#120,scroll_delay_counter(a0)
		blo.s	loc_112F0
		move.b	#120,scroll_delay_counter(a0)
		tst.b	(Reverse_gravity_flag).w
		bne.s	loc_112A6
		cmpi.w	#8,(a5)
		beq.s	loc_112FC
		subq.w	#2,(a5)
		bra.s	loc_112FC
; ---------------------------------------------------------------------------

loc_112A6:
		cmpi.w	#$D8,(a5)
		beq.s	loc_112FC
		addq.w	#2,(a5)
		bra.s	loc_112FC
; ---------------------------------------------------------------------------

loc_112B0:
		btst	#button_up,(Ctrl_1_held_logical).w
		beq.s	loc_112EA
		move.b	#7,anim(a0)
		addq.b	#1,scroll_delay_counter(a0)
		cmpi.b	#120,scroll_delay_counter(a0)
		blo.s	loc_112F0
		move.b	#120,scroll_delay_counter(a0)
		tst.b	(Reverse_gravity_flag).w
		bne.s	loc_112E0
		cmpi.w	#$C8,(a5)
		beq.s	loc_112FC
		addq.w	#2,(a5)
		bra.s	loc_112FC
; ---------------------------------------------------------------------------

loc_112E0:
		cmpi.w	#$18,(a5)
		beq.s	loc_112FC
		subq.w	#2,(a5)
		bra.s	loc_112FC
; ---------------------------------------------------------------------------

loc_112EA:
		move.b	#0,scroll_delay_counter(a0)

loc_112F0:
		cmpi.w	#$60,(a5)
		beq.s	loc_112FC
		bcc.s	loc_112FA
		addq.w	#4,(a5)

loc_112FA:
		subq.w	#2,(a5)

loc_112FC:
		tst.b	(Super_Sonic_Knux_flag).w
		beq.s	loc_11306
		move.w	#$C,d5

loc_11306:
		move.b	(Ctrl_1_held_logical).w,d0
		andi.b	#button_left_mask|button_right_mask,d0
		bne.s	loc_11332
		move.w	ground_vel(a0),d0
		beq.s	loc_11332
		bmi.s	loc_11326
		sub.w	d5,d0
		bcc.s	loc_11320
		move.w	#0,d0

loc_11320:
		move.w	d0,ground_vel(a0)
		bra.s	loc_11332
; ---------------------------------------------------------------------------

loc_11326:
		add.w	d5,d0
		bcc.s	loc_1132E
		move.w	#0,d0

loc_1132E:
		move.w	d0,ground_vel(a0)

loc_11332:
		move.b	angle(a0),d0
		jsr	(GetSineCosine).l
		muls.w	ground_vel(a0),d1
		asr.l	#8,d1
		move.w	d1,x_vel(a0)
		muls.w	ground_vel(a0),d0
		asr.l	#8,d0
		move.w	d0,y_vel(a0)

loc_11350:
		btst	#6,object_control(a0)
		bne.w	locret_113F4
		move.b	angle(a0),d0
		andi.b	#$3F,d0
		beq.s	loc_11370
		move.b	angle(a0),d0
		addi.b	#$40,d0
		bmi.w	locret_113F4

loc_11370:
		move.b	#$40,d1
		tst.w	ground_vel(a0)
		beq.s	locret_113F4
		bmi.s	loc_1137E
		neg.w	d1

loc_1137E:
		move.b	angle(a0),d0
		add.b	d1,d0
		move.w	d0,-(sp)
		bsr.w	sub_F61C
		move.w	(sp)+,d0
		tst.w	d1
		bpl.s	locret_113F4
		asl.w	#8,d1
		cmpi.b	#8,(Current_zone).w
		bne.s	loc_113A0
		tst.b	d0
		bpl.s	loc_113A0
		subq.b	#1,d0

loc_113A0:
		addi.b	#$20,d0
		andi.b	#$C0,d0
		beq.s	loc_113F0
		cmpi.b	#$40,d0
		beq.s	loc_113D6
		cmpi.b	#$80,d0
		beq.s	loc_113D0
		add.w	d1,x_vel(a0)
		move.w	#0,ground_vel(a0)
		btst	#Status_Facing,status(a0)
		bne.s	locret_113CE
		bset	#Status_Push,status(a0)

locret_113CE:
		rts
; ---------------------------------------------------------------------------

loc_113D0:
		sub.w	d1,y_vel(a0)
		rts
; ---------------------------------------------------------------------------

loc_113D6:
		sub.w	d1,x_vel(a0)
		move.w	#0,ground_vel(a0)
		btst	#Status_Facing,status(a0)
		beq.s	locret_113CE
		bset	#Status_Push,status(a0)
		rts
; ---------------------------------------------------------------------------

loc_113F0:
		add.w	d1,y_vel(a0)

locret_113F4:
		rts
; End of function Sonic_Move


; =============== S U B R O U T I N E =======================================


sub_113F6:
		move.w	ground_vel(a0),d0
		beq.s	loc_113FE
		bpl.s	loc_11430

loc_113FE:
		bset	#Status_Facing,status(a0)
		bne.s	loc_11412
		bclr	#Status_Push,status(a0)
		move.b	#1,prev_anim(a0)

loc_11412:
		sub.w	d5,d0
		move.w	d6,d1
		neg.w	d1
		cmp.w	d1,d0
		bgt.s	loc_11424
		add.w	d5,d0
		cmp.w	d1,d0
		ble.s	loc_11424
		move.w	d1,d0

loc_11424:
		move.w	d0,ground_vel(a0)
		move.b	#0,anim(a0)
		rts
; ---------------------------------------------------------------------------

loc_11430:
		sub.w	d4,d0
		bcc.s	loc_11438
		move.w	#-$80,d0

loc_11438:
		move.w	d0,ground_vel(a0)
		move.b	angle(a0),d0
		addi.b	#$20,d0
		andi.b	#$C0,d0
		bne.s	locret_11480
		cmpi.w	#$400,d0
		blt.s	locret_11480
		tst.b	flip_type(a0)
		bmi.s	locret_11480
		move.w	#sfx_Skid,d0
		jsr	(Play_SFX).l
		move.b	#$D,anim(a0)
		bclr	#Status_Facing,status(a0)
		cmpi.b	#12,air_left(a0)
		blo.s	locret_11480
		move.b	#6,routine(a6)
		move.b	#$15,mapping_frame(a6)

locret_11480:
		rts
; End of function sub_113F6


; =============== S U B R O U T I N E =======================================


sub_11482:
		move.w	ground_vel(a0),d0
		bmi.s	loc_114B6
		bclr	#Status_Facing,status(a0)
		beq.s	loc_1149C
		bclr	#Status_Push,status(a0)
		move.b	#1,prev_anim(a0)

loc_1149C:
		add.w	d5,d0
		cmp.w	d6,d0
		blt.s	loc_114AA
		sub.w	d5,d0
		cmp.w	d6,d0
		bge.s	loc_114AA
		move.w	d6,d0

loc_114AA:
		move.w	d0,ground_vel(a0)
		move.b	#0,anim(a0)
		rts
; ---------------------------------------------------------------------------

loc_114B6:
		add.w	d4,d0
		bcc.s	loc_114BE
		move.w	#$80,d0

loc_114BE:
		move.w	d0,ground_vel(a0)
		move.b	angle(a0),d0
		addi.b	#$20,d0
		andi.b	#$C0,d0
		bne.s	locret_11506
		cmpi.w	#-$400,d0
		bgt.s	locret_11506
		tst.b	flip_type(a0)
		bmi.s	locret_11506
		move.w	#sfx_Skid,d0
		jsr	(Play_SFX).l
		move.b	#$D,anim(a0)
		bset	#Status_Facing,status(a0)
		cmpi.b	#12,air_left(a0)
		blo.s	locret_11506
		move.b	#6,routine(a6)
		move.b	#$15,mapping_frame(a6)

locret_11506:
		rts
; End of function sub_11482


; =============== S U B R O U T I N E =======================================


Sonic_RollSpeed:
		move.w	Max_speed-Max_speed(a4),d6
		asl.w	#1,d6
		move.w	Acceleration-Max_speed(a4),d5
		asr.w	#1,d5
		tst.b	(Super_Sonic_Knux_flag).w
		beq.s	loc_1151C
		move.w	#6,d5

loc_1151C:
		move.w	#$20,d4
		tst.b	spin_dash_flag(a0)
		bmi.w	loc_115C6
		tst.b	status_secondary(a0)
		bmi.w	loc_115C6
		tst.w	move_lock(a0)
		bne.s	loc_1154E
		btst	#button_left,(Ctrl_1_logical).w
		beq.s	loc_11542
		bsr.w	sub_11608

loc_11542:
		btst	#button_right,(Ctrl_1_logical).w
		beq.s	loc_1154E
		bsr.w	sub_1162C

loc_1154E:
		move.w	ground_vel(a0),d0
		beq.s	loc_11570
		bmi.s	loc_11564
		sub.w	d5,d0
		bcc.s	loc_1155E
		move.w	#0,d0

loc_1155E:
		move.w	d0,ground_vel(a0)
		bra.s	loc_11570
; ---------------------------------------------------------------------------

loc_11564:
		add.w	d5,d0
		bcc.s	loc_1156C
		move.w	#0,d0

loc_1156C:
		move.w	d0,ground_vel(a0)

loc_11570:
		move.w	ground_vel(a0),d0
		bpl.s	loc_11578
		neg.w	d0

loc_11578:
		cmpi.w	#$80,d0
		bhs.s	loc_115C6
		tst.b	spin_dash_flag(a0)
		bne.s	loc_115B4
		bclr	#2,status(a0)
		move.b	y_radius(a0),d0
		move.b	default_y_radius(a0),y_radius(a0)
		move.b	default_x_radius(a0),x_radius(a0)
		move.b	#5,anim(a0)
		sub.b	default_y_radius(a0),d0
		ext.w	d0
		tst.b	(Reverse_gravity_flag).w
		beq.s	loc_115AE
		neg.w	d0

loc_115AE:
		add.w	d0,y_pos(a0)
		bra.s	loc_115C6
; ---------------------------------------------------------------------------

loc_115B4:
		move.w	#$400,ground_vel(a0)
		btst	#Status_Facing,status(a0)
		beq.s	loc_115C6
		neg.w	ground_vel(a0)

loc_115C6:
		cmpi.w	#$60,(a5)
		beq.s	loc_115D2
		bcc.s	loc_115D0
		addq.w	#4,(a5)

loc_115D0:
		subq.w	#2,(a5)

loc_115D2:
		move.b	angle(a0),d0
		jsr	(GetSineCosine).l
		muls.w	ground_vel(a0),d0
		asr.l	#8,d0
		move.w	d0,y_vel(a0)
		muls.w	ground_vel(a0),d1
		asr.l	#8,d1
		cmpi.w	#$1000,d1
		ble.s	loc_115F6
		move.w	#$1000,d1

loc_115F6:
		cmpi.w	#-$1000,d1
		bge.s	loc_11600
		move.w	#-$1000,d1

loc_11600:
		move.w	d1,x_vel(a0)
		bra.w	loc_11350
; End of function Sonic_RollSpeed


; =============== S U B R O U T I N E =======================================


sub_11608:
		move.w	ground_vel(a0),d0
		beq.s	loc_11610
		bpl.s	loc_1161E

loc_11610:
		bset	#Status_Facing,status(a0)
		move.b	#2,anim(a0)
		rts
; ---------------------------------------------------------------------------

loc_1161E:
		sub.w	d4,d0
		bcc.s	loc_11626
		move.w	#-$80,d0

loc_11626:
		move.w	d0,ground_vel(a0)
		rts
; End of function sub_11608


; =============== S U B R O U T I N E =======================================


sub_1162C:
		move.w	ground_vel(a0),d0
		bmi.s	loc_11640
		bclr	#Status_Facing,status(a0)
		move.b	#2,anim(a0)
		rts
; ---------------------------------------------------------------------------

loc_11640:
		add.w	d4,d0
		bcc.s	loc_11648
		move.w	#$80,d0

loc_11648:
		move.w	d0,ground_vel(a0)
		rts
; End of function sub_1162C

; ---------------------------------------------------------------------------
; Subroutine for moving Sonic left or right when he's in the air
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Sonic_ChgJumpDir:
		move.w	Max_speed-Max_speed(a4),d6
		move.w	Acceleration-Max_speed(a4),d5
		asl.w	#1,d5
		btst	#Status_RollJump,status(a0)		; did Sonic jump from rolling?
		bne.s	Sonic_Jump_ResetScr	; if yes, branch to skip midair control
		move.w	x_vel(a0),d0
		btst	#button_left,(Ctrl_1_held_logical).w
		beq.s	loc_11682	; if not holding left, branch

		bset	#Status_Facing,status(a0)
		sub.w	d5,d0	; add acceleration to the left
		move.w	d6,d1
		neg.w	d1
		cmp.w	d1,d0	; compare new speed with top speed
		bgt.s	loc_11682	; if new speed is less than the maximum, branch
		add.w	d5,d0		; remove this frame's acceleration change
		cmp.w	d1,d0		; compare speed with top speed
		ble.s	loc_11682	; if speed was already greater than the maximum, branch
		move.w	d1,d0

loc_11682:
		btst	#button_right,(Ctrl_1_held_logical).w
		beq.s	loc_1169E	; if not holding right, branch

		bclr	#Status_Facing,status(a0)
		add.w	d5,d0	; accelerate right in the air
		cmp.w	d6,d0	; compare new speed with top speed
		blt.s	loc_1169E	; if new speed is less than the maximum, branch
		sub.w	d5,d0		; remove this frame's acceleration change
		cmp.w	d6,d0		; compare speed with top speed
		bge.s	loc_1169E	; if speed was already greater than the maximum, branch
		move.w	d6,d0

loc_1169E:
		move.w	d0,x_vel(a0)

Sonic_Jump_ResetScr:
		cmpi.w	#$60,(a5)	; is screen in its default position?
		beq.s	Sonic_JumpPeakDecelerate	; if yes, branch
		bhs.s	loc_116AC	; depending on the sign of the difference,
		addq.w	#4,(a5)		; either add 2

loc_116AC:
		subq.w	#2,(a5)		; or subtract 2

Sonic_JumpPeakDecelerate:
		cmpi.w	#-$400,y_vel(a0)	; is Sonic moving faster than -$400 upwards?
		blo.s	locret_116DC		; if yes, return
		move.w	x_vel(a0),d0
		move.w	d0,d1
		asr.w	#5,d1		; d1 = x_velocity / 32
		beq.s	locret_116DC	; return if d1 is 0
		bmi.s	Sonic_JumpPeakDecelerateLeft	; branch if moving left

		sub.w	d1,d0	; reduce x velocity by d1
		bcc.s	loc_116CA
		move.w	#0,d0

loc_116CA:
		move.w	d0,x_vel(a0)
		rts
; ---------------------------------------------------------------------------

Sonic_JumpPeakDecelerateLeft:
		sub.w	d1,d0	; reduce x velocity by d1
		bcs.s	loc_116D8
		move.w	#0,d0

loc_116D8:
		move.w	d0,x_vel(a0)

locret_116DC:
		rts
; End of function Sonic_ChgJumpDir


; ---------------------------------------------------------------------------
; Subroutine to prevent Sonic from leaving the boundaries of a level
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Player_LevelBound:
		move.l	x_pos(a0),d1
		move.w	x_vel(a0),d0
		ext.l	d0
		asl.l	#8,d0
		add.l	d0,d1
		swap	d1
		move.w	(Camera_min_X_pos).w,d0
		addi.w	#$10,d0
		cmp.w	d1,d0			; has Sonic touched the left boundary?
		bhi.s	Player_Boundary_Sides	; if yes, branch
		move.w	(Camera_max_X_pos).w,d0
		addi.w	#$128,d0
		cmp.w	d1,d0
		blo.s	Player_Boundary_Sides

Player_Boundary_CheckBottom:
		tst.b	(Disable_death_plane).w
		bne.s	locret_11720
		tst.b	(Reverse_gravity_flag).w
		bne.s	loc_11722
		move.w	(Camera_max_Y_pos).w,d0
		addi.w	#$E0,d0
		cmp.w	y_pos(a0),d0		; has Sonic touched the bottom boundary?
		blt.s	Player_Boundary_Bottom	; if yes, branch

locret_11720:
		rts
; ---------------------------------------------------------------------------

loc_11722:
		move.w	(Camera_min_Y_pos).w,d0
		cmp.w	y_pos(a0),d0
		blt.s	locret_11720

Player_Boundary_Bottom:
		jmp	(Kill_Character).l
; ---------------------------------------------------------------------------

Player_Boundary_Sides:
		move.w	d0,x_pos(a0)
		move.w	#0,2+x_pos(a0)	; subpixel x
		move.w	#0,x_vel(a0)
		move.w	#0,ground_vel(a0)
		bra.s	Player_Boundary_CheckBottom
; End of function Player_LevelBound


; =============== S U B R O U T I N E =======================================


SonicKnux_Roll:
		tst.b	status_secondary(a0)
		bmi.s	locret_1177E
		move.b	(Ctrl_1_held_logical).w,d0
		andi.b	#button_left_mask|button_right_mask,d0	; is left/right being pressed?
		bne.s	locret_1177E	; if yes, branch
		btst	#button_down,(Ctrl_1_logical).w	; is down being pressed?
		beq.s	Player_ChkWalk			; if not, branch
		move.w	ground_vel(a0),d0
		bpl.s	loc_1176A
		neg.w	d0

loc_1176A:
		cmpi.w	#$100,d0		; is Sonic moving at $100 speed or faster?
		bhs.s	Player_ChkRoll		; if so, branch
		btst	#Status_OnObj,status(a0)
		bne.s	locret_1177E
		move.b	#8,anim(a0)	; enter ducking animation

locret_1177E:
		rts
; ---------------------------------------------------------------------------

Player_ChkWalk:
		cmpi.b	#8,anim(a0)	; is Sonic ducking?
		bne.s	locret_1177E
		move.b	#0,anim(a0)	; if so, enter walking animation
		rts
; ---------------------------------------------------------------------------

Player_ChkRoll:
		btst	#Status_Roll,status(a0)	; is Sonic already rolling?
		beq.s	Player_DoRoll	; if not, branch
		rts
; ---------------------------------------------------------------------------

Player_DoRoll:
		bset	#Status_Roll,status(a0)
		move.b	#$E,y_radius(a0)
		move.b	#7,x_radius(a0)
		move.b	#2,anim(a0)	; enter roll animation
		addq.w	#5,y_pos(a0)
		tst.b	(Reverse_gravity_flag).w
		beq.s	loc_117C2
		subi.w	#2*5,y_pos(a0)

loc_117C2:
		move.w	#sfx_Roll,d0
		jsr	(Play_SFX).l
		tst.w	ground_vel(a0)
		bne.s	locret_117D8
		move.w	#$200,ground_vel(a0)

locret_117D8:
		rts
; End of function SonicKnux_Roll


; ---------------------------------------------------------------------------
; Subroutine allowing Sonic to jump
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Sonic_Jump:
		move.b	(Ctrl_1_pressed_logical).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0	; is A, B or C pressed?
		beq.w	locret_118B2	; if not, return
		moveq	#0,d0
		move.b	angle(a0),d0
		tst.b	(Reverse_gravity_flag).w
		beq.s	loc_117FC
		addi.b	#$40,d0
		neg.b	d0
		subi.b	#$40,d0

loc_117FC:
		addi.b	#$80,d0
		movem.l	a4-a6,-(sp)
		bsr.w	CalcRoomOverHead
		movem.l	(sp)+,a4-a6
		cmpi.w	#6,d1			; does Sonic have enough room to jump?
		blt.w	locret_118B2		; if not, branch
		move.w	#$680,d2
		tst.b	(Super_Sonic_Knux_flag).w
		beq.s	loc_11822
		move.w	#$800,d2	; set higher jump speed if super

loc_11822:
		btst	#Status_Underwater,status(a0)	; Test if underwater
		beq.s	loc_1182E
		move.w	#$380,d2	; set lower jump speed if under

loc_1182E:
		moveq	#0,d0
		move.b	angle(a0),d0
		subi.b	#$40,d0
		jsr	(GetSineCosine).l
		muls.w	d2,d1
		asr.l	#8,d1
		add.w	d1,x_vel(a0)	; make Sonic jump (in X... this adds nothing on level ground)
		muls.w	d2,d0
		asr.l	#8,d0
		add.w	d0,y_vel(a0)	; make Sonic jump (in Y)
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
		bne.s	Sonic_RollJump
		move.b	#$E,y_radius(a0)
		move.b	#7,x_radius(a0)
		move.b	#2,anim(a0)	; use "jumping" animation
		bset	#Status_Roll,status(a0)
		move.b	y_radius(a0),d0
		sub.b	default_y_radius(a0),d0
		ext.w	d0
		tst.b	(Reverse_gravity_flag).w
		beq.s	loc_118AE
		neg.w	d0

loc_118AE:
		sub.w	d0,y_pos(a0)

locret_118B2:
		rts
; ---------------------------------------------------------------------------

Sonic_RollJump:
		bset	#Status_RollJump,status(a0)	; set the rolling+jumping flag
		rts
; End of function Sonic_Jump


; =============== S U B R O U T I N E =======================================

Sonic_JumpHeight:
		tst.b	jumping(a0)	; is Sonic jumping?
		beq.s	Sonic_UpVelCap	; if not, branch

		move.w	#-$400,d1
		btst	#Status_Underwater,status(a0)	; is Sonic underwater?
		beq.s	loc_118D2			; if not, branch
		move.w	#-$200,d1			; Underwater-specific

loc_118D2:
		cmp.w	y_vel(a0),d1		; is y speed greater than 4? (2 if underwater)
		ble.w	Sonic_ShieldMoves	; if not, branch
		move.b	(Ctrl_1_held_logical).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0	; are buttons A, B or C being pressed?
		bne.s	locret_118E8		; if yes, branch
		move.w	d1,y_vel(a0)		; cap jump height

locret_118E8:
		rts
; ---------------------------------------------------------------------------

Sonic_UpVelCap:
		tst.b	spin_dash_flag(a0)	; is Sonic charging his spin dash?
		bne.s	locret_118FE		; if yes, branch
		cmpi.w	#-$FC0,y_vel(a0)	; is Sonic's Y speed faster (less than) than -15.75 (-$FC0)?
		bge.s	locret_118FE		; if not, branch
		move.w	#-$FC0,y_vel(a0)	; cap upward speed

locret_118FE:
		rts
; ---------------------------------------------------------------------------

Sonic_ShieldMoves:
		tst.b	double_jump_flag(a0)		; is Sonic currently performing a double jump?
		bne.w	locret_11A14			; if yes, branch
		move.b	(Ctrl_1_pressed_logical).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0	; are buttons A, B, or C being pressed?
		beq.w	locret_11A14			; if not, branch
		bclr	#Status_RollJump,status(a0)
		tst.b	(Super_Sonic_Knux_flag).w	; check Super-state
		beq.s	Sonic_FireShield		; if not in a super-state, branch
		bmi.w	Sonic_HyperDash			; if Hyper, branch
		move.b	#1,double_jump_flag(a0)
		rts
; ---------------------------------------------------------------------------

Sonic_FireShield:
		btst	#Status_Invincible,status_secondary(a0)	; first, does Sonic have invincibility?
		bne.w	locret_11A14				; if yes, branch
		btst	#Status_FireShield,status_secondary(a0)	; does Sonic have a Fire Shield?
		beq.s	Sonic_LightningShield			; if not, branch
		move.b	#1,(Shield+anim).w
		move.b	#1,double_jump_flag(a0)
		move.w	#$800,d0
		btst	#Status_Facing,status(a0)		; is Sonic facing left?
		beq.s	loc_11958				; if not, branch
		neg.w	d0					; reverse speed value, moving Sonic left

loc_11958:
		move.w	d0,x_vel(a0)		; apply velocity...
		move.w	d0,ground_vel(a0)	; ...both ground and air
		move.w	#0,y_vel(a0)		; kill y-velocity
		move.w	#$2000,(H_scroll_frame_offset).w
		bsr.w	Reset_Player_Position_Array
		move.w	#sfx_FireAttack,d0
		jmp	(Play_SFX).l
; ---------------------------------------------------------------------------

Sonic_LightningShield:
		btst	#Status_LtngShield,status_secondary(a0)	; does Sonic have a Lightning Shield?
		beq.s	Sonic_BubbleShield			; if not, branch
		move.b	#1,(Shield+anim).w
		move.b	#1,double_jump_flag(a0)
		move.w	#-$580,y_vel(a0)	; bounce Sonic up, creating the double jump effect
		clr.b	jumping(a0)
		move.w	#sfx_ElectricAttack,d0
		jmp	(Play_SFX).l
; ---------------------------------------------------------------------------

Sonic_BubbleShield:
		btst	#Status_BublShield,status_secondary(a0)	; does Sonic have a Bubble Shield?
		beq.s	Sonic_CheckTransform			; if not, branch
		move.b	#1,(Shield+anim).w
		move.b	#1,double_jump_flag(a0)
		move.w	#0,x_vel(a0)		; halt horizontal speed...
		move.w	#0,ground_vel(a0)	; ...both ground and air
		move.w	#$800,y_vel(a0)		; force Sonic down
		move.w	#sfx_BubbleAttack,d0
		jmp	(Play_SFX).l
; ---------------------------------------------------------------------------
; Code that transforms Sonic into Super/Hyper Sonic
; if he has enough rings and emeralds
; ---------------------------------------------------------------------------

Sonic_CheckTransform:
		cmpi.b	#7,(Super_emerald_count).w	; does Sonic have all 7 Super Emeralds?
		bhs.s	loc_119E8			; if yes, branch
		cmpi.b	#7,(Chaos_emerald_count).w	; does Sonic have all 7 Chaos Emeralds?
		blo.s	Sonic_InstaShield		; if not, branch
		tst.b	(Emeralds_converted_flag).w
		bne.s	Sonic_InstaShield

loc_119E8:
		cmpi.w	#50,(Ring_count).w	; does Sonic have at least 50 rings?
		blo.s	Sonic_InstaShield	; if not, perform Insta-Shield
		tst.b	(Update_HUD_timer).w
		bne.s	Sonic_Transform

Sonic_InstaShield:
		btst	#Status_Shield,status_secondary(a0)	; does Sonic have an S2 shield? (the elementals were already filtered out at this point)
		bne.s	locret_11A14				; if yes, branch
		move.b	#1,(Shield+anim).w
		move.b	#1,double_jump_flag(a0)
		move.w	#sfx_InstaAttack,d0
		jmp	(Play_SFX).l
; ---------------------------------------------------------------------------

locret_11A14:
		rts
; ---------------------------------------------------------------------------

Sonic_Transform:
		move.b	#1,(Super_palette_status).w	; set Super/Hyper palette status to 'fading'
		move.b	#$F,(Palette_timer).w
		move.w	#60,(Super_frame_count).w
		move.l	#Map_SuperSonic,mappings(a0)
		move.b	#$81,object_control(a0)
		move.b	#$1F,anim(a0)				; enter 'transformation' animation
		cmpi.b	#7,(Super_emerald_count).w		; does Sonic have all 7 Super Emeralds?
		blo.s	.super					; if not, turn Super

		move.b	#-1,(Super_Sonic_Knux_flag).w		; set flag to Hyper Sonic
		move.l	#Obj_HyperSonic_Stars,(Invincibility_stars).w	; load Hyper Stars object
		move.l	#Obj_HyperSonicKnux_Trail,(Super_stars).w	; load After-Images object
		bra.s	.continued
; ---------------------------------------------------------------------------

	.super:
		move.b	#1,(Super_Sonic_Knux_flag).w		; set flag to Super Sonic
		move.l	#Obj_SuperSonicKnux_Stars,(Super_stars).w	; load Super Stars object

	.continued:
		move.w	#$A00,Max_speed-Max_speed(a4)
		move.w	#$30,Acceleration-Max_speed(a4)
		move.w	#$100,Deceleration-Max_speed(a4)
		move.b	#0,invincibility_timer(a0)
		bset	#Status_Invincible,status_secondary(a0)
		moveq	#signextendB(sfx_SuperTransform),d0
		jsr	(Play_SFX).l
		moveq	#signextendB(mus_Invincibility),d0		; play invincibility theme
		jmp	(Play_Music).l
; ---------------------------------------------------------------------------

Sonic_HyperDash:
		bsr.w	HyperAttackTouchResponse
		move.w	#$2000,(H_scroll_frame_offset).w
		bsr.w	Reset_Player_Position_Array
		move.b	#1,double_jump_flag(a0)
		move.b	#1,(Invincibility_stars+anim).w	; This causes the screen flash, and sparks to come out of Sonic
		moveq	#signextendB(sfx_Dash),d0
		jsr	(Play_SFX).l
		move.b	(Ctrl_1_logical).w,d0
		andi.w	#button_up_mask|button_down_mask|button_left_mask|button_right_mask,d0	; Get D-pad input
		beq.s	.noInput
		; Any values totaling $B or above are produced by holding
		; both opposing directions on the D-pad, which is invalid
		cmpi.b	#$B,d0
		bhs.s	.noInput
		lsl.w	#2,d0
		lea	Sonic_HyperDash_Velocities-4(pc,d0.w),a1
		move.w	(a1)+,d0
		move.w	d0,x_vel(a0)
		move.w	d0,ground_vel(a0)
		move.w	(a1)+,d0
		move.w	d0,y_vel(a0)
		rts
; ---------------------------------------------------------------------------

	.noInput:
		; If there's no directional input, we just dash forward
		move.w	#$800,d0	; Go right...
		btst	#Status_Facing,status(a0)	; ...unless Sonic is facing left...
		beq.s	.applySpeeds
		neg.w	d0		; ...in which case, go left

	.applySpeeds:
		move.w	d0,x_vel(a0)
		move.w	d0,ground_vel(a0)
		move.w	#0,y_vel(a0)
		rts
; End of function Sonic_JumpHeight

; ---------------------------------------------------------------------------
Sonic_HyperDash_Velocities:
		dc.w      0, -$800	; up
		dc.w      0,  $800	; down
		dc.w      0,     0	; up + down (shouldn't happen)
		dc.w  -$800,     0	; left
		dc.w  -$800, -$800	; left + up
		dc.w  -$800,  $800	; left + down
		dc.w      0,     0	; left + up + down (shouldn't happen)
		dc.w   $800,     0	; right
		dc.w   $800, -$800	; right + up
		dc.w   $800,  $800	; right + down
		; Everything after this would be bad button combinations
; ---------------------------------------------------------------------------

Tails_Super:
		tst.b	(Super_Tails_flag).w
		beq.w	SonicKnux_SuperHyper.return
		bra.s	SonicKnux_SuperHyper.continued

; =============== S U B R O U T I N E =======================================


SonicKnux_SuperHyper:
		tst.b	(Super_Sonic_Knux_flag).w
		beq.w	.return		; If not Super/Hyper, return

	.continued:
		tst.b	(Update_HUD_timer).w	; Level over?
		beq.s	.revertToNormal
		subq.w	#1,(Super_frame_count).w
		bpl.w	.return			; This should be a 'bhi'; currently counts down 61 frames
		move.w	#60,(Super_frame_count).w
		tst.w	(Ring_count).w
		beq.s	.revertToNormal	; If rings depleted, return to normal
		; This checks if the ring counter needs to be blanked
		; for example, this ticks '10' down to ' 9' instead of '19' (yes, this does happen)
		ori.b	#1,(Update_HUD_ring_count).w	; Update ring counter
		cmpi.w	#1,(Ring_count).w
		beq.s	.resetHUD
		cmpi.w	#10,(Ring_count).w
		beq.s	.resetHUD
		cmpi.w	#100,(Ring_count).w
		bne.s	.updateHUD

	.resetHUD:
		ori.b	#$80,(Update_HUD_ring_count).w	; Re-init ring counter

	.updateHUD:
		subq.w	#1,(Ring_count).w
		bne.s	.return	; If rings aren't depleted, we're done here
		; If rings depleted, return to normal

	.revertToNormal:
		move.b	#2,(Super_palette_status).w
		move.w	#$1E,(Palette_frame).w
		move.b	#0,(Super_Sonic_Knux_flag).w
		move.b	#0,(Super_Tails_flag).w
		move.b	#-1,(Player_prev_frame).w
		tst.b	character_id(a0)	; Is this Sonic?
		bne.s	.notSonic
		move.l	#Map_Sonic,mappings(a0)	; If so, load Sonic's normal mappings (was using Super/Hyper mappings)

	.notSonic:
		move.b	#1,prev_anim(a0)
		move.b	#1,invincibility_timer(a0)
		move.w	#$600,Max_speed-Max_speed(a4)
		move.w	#$C,Acceleration-Max_speed(a4)
		move.w	#$80,Deceleration-Max_speed(a4)
		btst	#Status_Underwater,status(a0)
		beq.s	.return
		; If underwater, apply corrected speed/acceleration/deceleration
		move.w	#$300,Max_speed-Max_speed(a4)
		move.w	#6,Acceleration-Max_speed(a4)
		move.w	#$40,Deceleration-Max_speed(a4)

	.return:
		rts
; End of function SonicKnux_SuperHyper


; =============== S U B R O U T I N E =======================================


SonicKnux_Spindash:
		tst.b	spin_dash_flag(a0)
		bne.s	loc_11C5E
		cmpi.b	#8,anim(a0)
		bne.s	locret_11C5C
		move.b	(Ctrl_1_pressed_logical).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0
		beq.w	locret_11C5C
		move.b	#9,anim(a0)
		move.w	#signextendB(sfx_Spindash),d0
		jsr	(Play_SFX).l
		addq.l	#4,sp
		move.b	#1,spin_dash_flag(a0)
		move.w	#0,spin_dash_counter(a0)
		cmpi.b	#12,air_left(a0)
		blo.s	loc_11C24
		move.b	#2,anim(a6)

loc_11C24:
		bsr.w	Player_LevelBound
		bsr.w	Call_Player_AnglePos
		tst.b	(Background_collision_flag).w
		beq.s	locret_11C5C
		bsr.w	sub_F846
		tst.w	d1
		bmi.w	Kill_Character
		movem.l	a4-a6,-(sp)
		bsr.w	CheckLeftWallDist
		tst.w	d1
		bpl.s	loc_11C4C
		sub.w	d1,x_pos(a0)

loc_11C4C:
		bsr.w	CheckRightWallDist
		tst.w	d1
		bpl.s	loc_11C58
		add.w	d1,x_pos(a0)

loc_11C58:
		movem.l	(sp)+,a4-a6

locret_11C5C:
		rts
; ---------------------------------------------------------------------------

loc_11C5E:
		move.b	(Ctrl_1_held_logical).w,d0
		btst	#button_down,d0
		bne.w	loc_11D16
		move.b	#$E,y_radius(a0)
		move.b	#7,x_radius(a0)
		move.b	#2,anim(a0)
		addq.w	#5,y_pos(a0)
		tst.b	(Reverse_gravity_flag).w
		beq.s	loc_11C8C
		subi.w	#5*2,y_pos(a0)

loc_11C8C:
		move.b	#0,spin_dash_flag(a0)
		moveq	#0,d0
		move.b	spin_dash_counter(a0),d0
		add.w	d0,d0
		move.w	word_11CF2(pc,d0.w),ground_vel(a0)
		tst.b	(Super_Sonic_Knux_flag).w
		beq.s	loc_11CAC
		move.w	word_11D04(pc,d0.w),ground_vel(a0)

loc_11CAC:
		move.w	ground_vel(a0),d0
		subi.w	#$800,d0
		add.w	d0,d0
		andi.w	#$1F00,d0
		neg.w	d0
		addi.w	#$2000,d0
		lea	(H_scroll_frame_offset).w,a1
		cmpa.w	#Player_1,a0
		beq.s	loc_11CCE
		lea	(H_scroll_frame_offset_P2).w,a1

loc_11CCE:
		move.w	d0,(a1)
		btst	#Status_Facing,status(a0)
		beq.s	loc_11CDC
		neg.w	ground_vel(a0)

loc_11CDC:
		bset	#Status_Roll,status(a0)
		move.b	#0,anim(a6)
		moveq	#signextendB(sfx_Dash),d0
		jsr	(Play_SFX).l
		bra.s	loc_11D5E
; ---------------------------------------------------------------------------
word_11CF2:
		dc.w   $800
		dc.w   $880
		dc.w   $900
		dc.w   $980
		dc.w   $A00
		dc.w   $A80
		dc.w   $B00
		dc.w   $B80
		dc.w   $C00
word_11D04:
		dc.w   $B00
		dc.w   $B80
		dc.w   $C00
		dc.w   $C80
		dc.w   $D00
		dc.w   $D80
		dc.w   $E00
		dc.w   $E80
		dc.w   $F00
; ---------------------------------------------------------------------------

loc_11D16:
		tst.w	spin_dash_counter(a0)
		beq.s	loc_11D2E
		move.w	spin_dash_counter(a0),d0
		lsr.w	#5,d0
		sub.w	d0,spin_dash_counter(a0)
		bcc.s	loc_11D2E
		move.w	#0,spin_dash_counter(a0)

loc_11D2E:
		move.b	(Ctrl_1_pressed_logical).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0
		beq.w	loc_11D5E
		move.w	#9<<8,anim(a0)	; and prev_anim
		move.w	#signextendB(sfx_Spindash),d0
		jsr	(Play_SFX).l
		addi.w	#$200,spin_dash_counter(a0)
		cmpi.w	#$800,spin_dash_counter(a0)
		blo.s	loc_11D5E
		move.w	#$800,spin_dash_counter(a0)

loc_11D5E:
		addq.l	#4,sp
		cmpi.w	#$60,(a5)
		beq.s	loc_11D6C
		bcc.s	loc_11D6A
		addq.w	#4,(a5)

loc_11D6A:
		subq.w	#2,(a5)

loc_11D6C:
		bsr.w	Player_LevelBound
		bsr.w	Call_Player_AnglePos
		tst.b	(Background_collision_flag).w
		beq.s	locret_11DA4
		bsr.w	sub_F846
		tst.w	d1
		bmi.w	Kill_Character
		movem.l	a4-a6,-(sp)
		bsr.w	CheckLeftWallDist
		tst.w	d1
		bpl.s	loc_11D94
		sub.w	d1,x_pos(a0)

loc_11D94:
		bsr.w	CheckRightWallDist
		tst.w	d1
		bpl.s	loc_11DA0
		add.w	d1,x_pos(a0)

loc_11DA0:
		movem.l	(sp)+,a4-a6

locret_11DA4:
		rts
; End of function SonicKnux_Spindash


; ---------------------------------------------------------------------------
; Subroutine to slow Sonic walking up a slope
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Player_SlopeResist:
		move.b	angle(a0),d0
		addi.b	#$60,d0
		cmpi.b	#-$40,d0
		bhs.s	locret_11DDA
		move.b	angle(a0),d0
		jsr	(GetSineCosine).l
		muls.w	#$20,d0
		asr.l	#8,d0
		tst.w	ground_vel(a0)
		beq.s	loc_11DDC
		bmi.s	loc_11DD6
		tst.w	d0
		beq.s	locret_11DD4
		add.w	d0,ground_vel(a0)

locret_11DD4:
		rts
; ---------------------------------------------------------------------------

loc_11DD6:
		add.w	d0,ground_vel(a0)

locret_11DDA:
		rts
; ---------------------------------------------------------------------------

loc_11DDC:
		move.w	d0,d1
		bpl.s	loc_11DE2
		neg.w	d1

loc_11DE2:
		cmpi.w	#$D,d1
		blo.s	locret_11DDA
		add.w	d0,ground_vel(a0)
		rts
; End of function Player_SlopeResist

; ---------------------------------------------------------------------------
; Subroutine to push Sonic down a slope while he's rolling
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Player_RollRepel:
		move.b	angle(a0),d0
		addi.b	#$60,d0
		cmpi.b	#-$40,d0
		bhs.s	locret_11E28
		move.b	angle(a0),d0
		jsr	(GetSineCosine).l
		muls.w	#$50,d0
		asr.l	#8,d0
		tst.w	ground_vel(a0)
		bmi.s	loc_11E1E
		tst.w	d0
		bpl.s	loc_11E18
		asr.l	#2,d0

loc_11E18:
		add.w	d0,ground_vel(a0)
		rts
; ---------------------------------------------------------------------------

loc_11E1E:
		tst.w	d0
		bmi.s	loc_11E24
		asr.l	#2,d0

loc_11E24:
		add.w	d0,ground_vel(a0)

locret_11E28:
		rts
; End of function Player_RollRepel


; ---------------------------------------------------------------------------
; Subroutine to push Sonic down a slope
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Player_SlopeRepel:
		nop
		tst.b	stick_to_convex(a0)
		bne.s	locret_11E6E
		tst.w	move_lock(a0)
		bne.s	loc_11E86
		move.b	angle(a0),d0
		addi.b	#$18,d0
		cmpi.b	#$30,d0
		blo.s	locret_11E6E
		move.w	ground_vel(a0),d0
		bpl.s	loc_11E4E
		neg.w	d0

loc_11E4E:
		cmpi.w	#$280,d0
		bhs.s	locret_11E6E
		move.w	#30,move_lock(a0)
		move.b	angle(a0),d0
		addi.b	#$30,d0
		cmpi.b	#$60,d0
		blo.s	loc_11E70
		bset	#Status_InAir,status(a0)

locret_11E6E:
		rts
; ---------------------------------------------------------------------------

loc_11E70:
		cmpi.b	#$30,d0
		blo.s	loc_11E7E
		addi.w	#$80,ground_vel(a0)
		rts
; ---------------------------------------------------------------------------

loc_11E7E:
		subi.w	#$80,ground_vel(a0)
		rts
; ---------------------------------------------------------------------------

loc_11E86:
		subq.w	#1,move_lock(a0)
		rts
; End of function Player_SlopeRepel


; ---------------------------------------------------------------------------
; Subroutine to return Sonic's angle to 0 as he jumps
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Player_JumpAngle:
		move.b	angle(a0),d0	; get Sonic's angle
		beq.s	Player_JumpFlip	; if already 0, branch
		bpl.s	loc_11E9C	; if higher than 0, branch

		addq.b	#2,d0		; increase angle
		bcc.s	loc_11E9A
		moveq	#0,d0

loc_11E9A:
		bra.s	Player_JumpAngleSet
; ---------------------------------------------------------------------------

loc_11E9C:
		subq.b	#2,d0		; decrease angle
		bcc.s	Player_JumpAngleSet
		moveq	#0,d0

Player_JumpAngleSet:
		move.b	d0,angle(a0)
; End of function Player_JumpAngle
	; continue straight to Player_JumpFlip

; ---------------------------------------------------------------------------
; Updates Sonic's secondary angle if he's tumbling
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Player_JumpFlip:
		move.b	flip_angle(a0),d0
		beq.s	locret_11EEA
		tst.w	ground_vel(a0)
		bmi.s	Player_JumpLeftFlip

Player_JumpRightFlip:
		move.b	flip_speed(a0),d1
		add.b	d1,d0
		bcc.s	loc_11EC8
		subq.b	#1,flips_remaining(a0)
		bcc.s	loc_11EC8
		move.b	#0,flips_remaining(a0)
		moveq	#0,d0

loc_11EC8:
		bra.s	Player_JumpFlipSet
; ---------------------------------------------------------------------------

Player_JumpLeftFlip:
		tst.b	flip_type(a0)
		bmi.s	Player_JumpRightFlip
		move.b	flip_speed(a0),d1
		sub.b	d1,d0
		bcc.s	Player_JumpFlipSet
		subq.b	#1,flips_remaining(a0)
		bcc.s	Player_JumpFlipSet
		move.b	#0,flips_remaining(a0)
		moveq	#0,d0

Player_JumpFlipSet:
		move.b	d0,flip_angle(a0)

locret_11EEA:
		rts
; End of function Player_JumpAngle


; ---------------------------------------------------------------------------
; Subroutine for Sonic to interact with the floor and walls when he's in the air
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


SonicKnux_DoLevelCollision:
		move.l	(Primary_collision_addr).w,(Collision_addr).w
		cmpi.b	#$C,top_solid_bit(a0)
		beq.s	loc_11F00
		move.l	(Secondary_collision_addr).w,(Collision_addr).w

loc_11F00:
		move.b	lrb_solid_bit(a0),d5
		move.w	x_vel(a0),d1
		move.w	y_vel(a0),d2
		jsr	(GetArcTan).l
		subi.b	#$20,d0
		andi.b	#$C0,d0
		cmpi.b	#$40,d0
		beq.w	Player_HitLeftWall
		cmpi.b	#$80,d0
		beq.w	Player_HitCeilingAndWalls
		cmpi.b	#$C0,d0
		beq.w	loc_12102
		bsr.w	CheckLeftWallDist
		tst.w	d1
		bpl.s	loc_11F44
		sub.w	d1,x_pos(a0)
		move.w	#0,x_vel(a0)	; stop Sonic since he hit a wall

loc_11F44:
		bsr.w	CheckRightWallDist
		tst.w	d1
		bpl.s	loc_11F56
		add.w	d1,x_pos(a0)
		move.w	#0,x_vel(a0)	; stop Sonic since he hit a wall

loc_11F56:
		bsr.w	sub_11FD6
		tst.w	d1
		bpl.s	locret_11FD4
		move.b	y_vel(a0),d2
		addq.b	#8,d2
		neg.b	d2
		cmp.b	d2,d1
		bge.s	loc_11F6E
		cmp.b	d2,d0
		blt.s	locret_11FD4

loc_11F6E:
		move.b	d3,angle(a0)
		tst.b	(Reverse_gravity_flag).w
		beq.s	loc_11F7A
		neg.w	d1

loc_11F7A:
		add.w	d1,y_pos(a0)
		move.b	d3,d0
		addi.b	#$20,d0
		andi.b	#$40,d0
		bne.s	loc_11FAE
		move.b	d3,d0
		addi.b	#$10,d0
		andi.b	#$20,d0
		beq.s	loc_11F9C
		asr	y_vel(a0)
		bra.s	loc_11FC2
; ---------------------------------------------------------------------------

loc_11F9C:
		move.w	#0,y_vel(a0)
		move.w	x_vel(a0),ground_vel(a0)
		bsr.w	Player_TouchFloor_Check_Spindash
		rts
; ---------------------------------------------------------------------------

loc_11FAE:
		move.w	#0,x_vel(a0)	; stop Sonic since he hit a wall
		cmpi.w	#$FC0,y_vel(a0)
		ble.s	loc_11FC2
		move.w	#$FC0,y_vel(a0)

loc_11FC2:
		bsr.w	Player_TouchFloor_Check_Spindash
		move.w	y_vel(a0),ground_vel(a0)
		tst.b	d3
		bpl.s	locret_11FD4
		neg.w	ground_vel(a0)

locret_11FD4:
		rts
; End of function SonicKnux_DoLevelCollision


; =============== S U B R O U T I N E =======================================


sub_11FD6:
		tst.b	(Reverse_gravity_flag).w
		beq.w	Sonic_CheckFloor
		bsr.w	Sonic_CheckCeiling
		addi.b	#$40,d3
		neg.b	d3
		subi.b	#$40,d3
		rts
; End of function sub_11FD6


; =============== S U B R O U T I N E =======================================


sub_11FEE:
		tst.b	(Reverse_gravity_flag).w
		beq.w	Sonic_CheckCeiling
		bsr.w	Sonic_CheckFloor
		addi.b	#$40,d3
		neg.b	d3
		subi.b	#$40,d3
		rts
; End of function sub_11FEE


; =============== S U B R O U T I N E =======================================


ChooseChkFloorEdge:
		tst.b	(Reverse_gravity_flag).w
		beq.w	ChkFloorEdge_Part2
		bra.w	ChkFloorEdge_ReverseGravity
; End of function ChooseChkFloorEdge

; ---------------------------------------------------------------------------

Player_HitLeftWall:
		bsr.w	CheckLeftWallDist
		tst.w	d1
		bpl.s	Player_HitCeiling	; branch if distance is positive (not inside wall)
		sub.w	d1,x_pos(a0)
		move.w	#0,x_vel(a0)	; stop Sonic since he hit a wall
		move.w	y_vel(a0),ground_vel(a0)

Player_HitCeiling:
		bsr.w	sub_11FEE
		tst.w	d1
		bpl.s	loc_12068	; branch if distance is positive (not inside ceiling)
		neg.w	d1
		cmpi.w	#$14,d1
		bhs.s	loc_12054
		tst.b	(Reverse_gravity_flag).w
		beq.s	loc_12042
		neg.w	d1

loc_12042:
		add.w	d1,y_pos(a0)
		tst.w	y_vel(a0)
		bpl.s	locret_12052
		move.w	#0,y_vel(a0)	; stop Sonic in y since he hit a ceiling

locret_12052:
		rts
; ---------------------------------------------------------------------------

loc_12054:
		bsr.w	CheckRightWallDist
		tst.w	d1
		bpl.s	locret_12066
		add.w	d1,x_pos(a0)
		move.w	#0,x_vel(a0)

locret_12066:
		rts
; ---------------------------------------------------------------------------

loc_12068:
		tst.b	(WindTunnel_flag).w
		bne.s	loc_12074
		tst.w	y_vel(a0)
		bmi.s	locret_1209C

loc_12074:
		bsr.w	sub_11FD6
		tst.w	d1
		bpl.s	locret_1209C
		tst.b	(Reverse_gravity_flag).w
		beq.s	loc_12084
		neg.w	d1

loc_12084:
		add.w	d1,y_pos(a0)
		move.b	d3,angle(a0)
		move.w	#0,y_vel(a0)
		move.w	x_vel(a0),ground_vel(a0)
		bsr.w	Player_TouchFloor_Check_Spindash

locret_1209C:
		rts
; ---------------------------------------------------------------------------

Player_HitCeilingAndWalls:
		bsr.w	CheckLeftWallDist
		tst.w	d1
		bpl.s	loc_120B0
		sub.w	d1,x_pos(a0)
		move.w	#0,x_vel(a0)	; stop Sonic since he hit a wall

loc_120B0:
		bsr.w	CheckRightWallDist
		tst.w	d1
		bpl.s	loc_120C2
		add.w	d1,x_pos(a0)
		move.w	#0,x_vel(a0)	; stop Sonic since he hit a wall

loc_120C2:
		bsr.w	sub_11FEE
		tst.w	d1
		bpl.s	locret_12100
		tst.b	(Reverse_gravity_flag).w
		beq.s	loc_120D2
		neg.w	d1

loc_120D2:
		sub.w	d1,y_pos(a0)
		move.b	d3,d0
		addi.b	#$20,d0
		andi.b	#$40,d0
		bne.s	loc_120EA
		move.w	#0,y_vel(a0)	; stop Sonic in y since he hit a ceiling
		rts
; ---------------------------------------------------------------------------

loc_120EA:
		move.b	d3,angle(a0)
		bsr.w	Player_TouchFloor_Check_Spindash
		move.w	y_vel(a0),ground_vel(a0)
		tst.b	d3
		bpl.s	locret_12100
		neg.w	ground_vel(a0)

locret_12100:
		rts
; ---------------------------------------------------------------------------

loc_12102:
		bsr.w	CheckRightWallDist
		tst.w	d1
		bpl.s	loc_1211A
		add.w	d1,x_pos(a0)
		move.w	#0,x_vel(a0)
		move.w	y_vel(a0),ground_vel(a0)

loc_1211A:
		bsr.w	sub_11FEE
		tst.w	d1
		bpl.s	loc_1213C
		tst.b	(Reverse_gravity_flag).w
		beq.s	loc_1212A
		neg.w	d1

loc_1212A:
		sub.w	d1,y_pos(a0)
		tst.w	y_vel(a0)
		bpl.s	locret_1213A
		move.w	#0,y_vel(a0)

locret_1213A:
		rts
; ---------------------------------------------------------------------------

loc_1213C:
		tst.b	(WindTunnel_flag).w
		bne.s	loc_12148
		tst.w	y_vel(a0)
		bmi.s	locret_12170

loc_12148:
		bsr.w	sub_11FD6
		tst.w	d1
		bpl.s	locret_12170
		tst.b	(Reverse_gravity_flag).w
		beq.s	loc_12158
		neg.w	d1

loc_12158:
		add.w	d1,y_pos(a0)
		move.b	d3,angle(a0)
		move.w	#0,y_vel(a0)
		move.w	x_vel(a0),ground_vel(a0)
		bsr.w	Player_TouchFloor_Check_Spindash

locret_12170:
		rts

; =============== S U B R O U T I N E =======================================


Player_TouchFloor_Check_Spindash:
		tst.b	spin_dash_flag(a0)
		bne.s	loc_121D8
		move.b	#0,anim(a0)
; End of function Player_TouchFloor_Check_Spindash


; =============== S U B R O U T I N E =======================================


Player_TouchFloor:
		cmpi.b	#1,character_id(a0)
		beq.w	Tails_TouchFloor
		cmpi.b	#2,character_id(a0)
		beq.w	Knux_TouchFloor

		move.b	y_radius(a0),d0
		move.b	default_y_radius(a0),y_radius(a0)
		move.b	default_x_radius(a0),x_radius(a0)
		btst	#Status_Roll,status(a0)
		beq.s	loc_121D8
		bclr	#Status_Roll,status(a0)
		move.b	#0,anim(a0)
		sub.b	default_y_radius(a0),d0
		ext.w	d0
		tst.b	(Reverse_gravity_flag).w
		beq.s	loc_121C4
		neg.w	d0

loc_121C4:
		move.w	d0,-(sp)
		move.b	angle(a0),d0
		addi.b	#$40,d0
		bpl.s	loc_121D2
		neg.w	(sp)

loc_121D2:
		move.w	(sp)+,d0
		add.w	d0,y_pos(a0)

loc_121D8:
		bclr	#Status_InAir,status(a0)
		bclr	#Status_Push,status(a0)
		bclr	#Status_RollJump,status(a0)
		move.b	#0,jumping(a0)
		move.w	#0,(Chain_bonus_counter).w
		move.b	#0,flip_angle(a0)
		move.b	#0,flip_type(a0)
		move.b	#0,flips_remaining(a0)
		move.b	#0,scroll_delay_counter(a0)
		tst.b	double_jump_flag(a0)
		beq.s	locret_12230
		tst.b	character_id(a0)
		bne.s	loc_1222A
		tst.b	(Super_Sonic_Knux_flag).w
		bne.s	loc_1222A
		btst	#Status_BublShield,status_secondary(a0)
		beq.s	loc_1222A
		bsr.s	BubbleShield_Bounce

loc_1222A:
		move.b	#0,double_jump_flag(a0)

locret_12230:
		rts
; End of function Player_TouchFloor


; =============== S U B R O U T I N E =======================================


BubbleShield_Bounce:
		movem.l	d1-d2,-(sp)
		move.w	#$780,d2
		btst	#Status_Underwater,status(a0)
		beq.s	loc_12246
		move.w	#$400,d2

loc_12246:
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
		movem.l	(sp)+,d1-d2
		bset	#Status_InAir,status(a0)
		bclr	#Status_Push,status(a0)
		move.b	#1,jumping(a0)
		clr.b	stick_to_convex(a0)
		move.b	#$E,y_radius(a0)
		move.b	#7,x_radius(a0)
		move.b	#2,anim(a0)
		bset	#Status_Roll,status(a0)
		move.b	y_radius(a0),d0
		sub.b	default_y_radius(a0),d0
		ext.w	d0
		tst.b	(Reverse_gravity_flag).w
		beq.s	loc_122AA
		neg.w	d0

loc_122AA:
		sub.w	d0,y_pos(a0)
		move.b	#2,(Shield+anim).w
		move.w	#sfx_BubbleAttack,d0
		jmp	(Play_SFX).l
; End of function BubbleShield_Bounce

; ---------------------------------------------------------------------------

loc_122BE:
		tst.w	(Debug_mode_flag).w
		beq.s	loc_122D8
		btst	#button_B,(Ctrl_1_pressed).w
		beq.s	loc_122D8
		move.w	#1,(Debug_placement_mode).w
		clr.b	(Ctrl_1_locked).w
		rts
; ---------------------------------------------------------------------------

loc_122D8:
		jsr	(MoveSprite_TestGravity2).l
		addi.w	#$30,y_vel(a0)
		btst	#6,status(a0)
		beq.s	loc_122F2
		subi.w	#$20,y_vel(a0)

loc_122F2:
		cmpi.w	#-$100,(Camera_min_Y_pos).w
		bne.s	loc_12302
		move.w	(Screen_Y_wrap_value).w,d0
		and.w	d0,y_pos(a0)

loc_12302:
		bsr.w	sub_12318
		bsr.w	Player_LevelBound
		bsr.w	Sonic_RecordPos
		bsr.w	sub_125E0
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_12318:
		tst.b	(Disable_death_plane).w
		bne.s	loc_12344
		tst.b	(Reverse_gravity_flag).w
		bne.s	loc_12336
		move.w	(Camera_max_Y_pos).w,d0
		addi.w	#$E0,d0
		cmp.w	y_pos(a0),d0
		blt.w	loc_1238A
		bra.s	loc_12344
; ---------------------------------------------------------------------------

loc_12336:
		move.w	(Camera_min_Y_pos).w,d0
		cmp.w	y_pos(a0),d0
		blt.s	loc_12344
		bra.w	loc_1238A
; ---------------------------------------------------------------------------

loc_12344:
		movem.l	a4-a6,-(sp)
		bsr.w	SonicKnux_DoLevelCollision
		movem.l	(sp)+,a4-a6
		btst	#1,status(a0)
		bne.s	locret_12388
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

locret_12388:
		rts
; ---------------------------------------------------------------------------

loc_1238A:
		jmp	(Kill_Character).l
; End of function sub_12318

; ---------------------------------------------------------------------------

loc_12390:
		tst.w	(Debug_mode_flag).w
		beq.s	loc_123AA
		btst	#button_B,(Ctrl_1_pressed).w
		beq.s	loc_123AA
		move.w	#1,(Debug_placement_mode).w
		clr.b	(Ctrl_1_locked).w
		rts
; ---------------------------------------------------------------------------

loc_123AA:
		bsr.w	sub_123C2
		jsr	(MoveSprite_TestGravity).l
		bsr.w	Sonic_RecordPos
		bsr.w	sub_125E0
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_123C2:
		cmpa.w	#Player_1,a0
		bne.s	loc_123D4
		move.w	(Camera_Y_pos).w,d0
		move.b	#1,(Scroll_lock).w
		bra.s	loc_123DE
; ---------------------------------------------------------------------------

loc_123D4:
		move.w	(Camera_Y_pos).w,d0
		move.b	#1,(Scroll_lock_P2).w

loc_123DE:
		move.b	#0,spin_dash_flag(a0)
		tst.b	(Reverse_gravity_flag).w
		beq.s	loc_123FA
		subi.w	#$10,d0
		cmp.w	y_pos(a0),d0
		bge.w	loc_12410
		bra.w	locret_124C6
; ---------------------------------------------------------------------------

loc_123FA:
		addi.w	#$100,d0
		tst.w	(Competition_mode).w
		beq.s	loc_12408
		subi.w	#$70,d0

loc_12408:
		cmp.w	y_pos(a0),d0
		bge.w	locret_124C6

loc_12410:
		tst.w	(Competition_mode).w
		bne.w	loc_124C8
		cmpi.b	#1,character_id(a0)
		bne.s	loc_12432
		cmpi.w	#2,(Player_mode).w
		beq.s	loc_12432
		move.b	#2,routine(a0)
		bra.w	sub_13ECA
; ---------------------------------------------------------------------------

loc_12432:
		move.b	#8,routine(a0)
		move.w	#60,$3E(a0)
		move.b	#0,(Respawn_table_keep).w
		addq.b	#1,(Update_HUD_life_count).w
		subq.b	#1,(Life_count).w
		bne.s	loc_12498
		move.w	#0,$3E(a0)
		move.l	#Obj_GameOver,(Reserved_object_3).w
		move.l	#Obj_GameOver,(Dynamic_object_RAM).w
		move.b	#0,(Reserved_object_3+mapping_frame).w
		move.b	#1,(Dynamic_object_RAM+mapping_frame).w
		move.w	a0,(Reserved_object_3+objoff_3E).w
		clr.b	(Time_over_flag).w

loc_12478:
		clr.b	(Update_HUD_timer).w
		clr.b	(Update_HUD_timer_P2).w
		move.b	#8,routine(a0)
		move.w	#mus_GameOver,d0
		jsr	(Play_Music).l
		moveq	#3,d0
		jmp	(Load_PLC_2).l
; ---------------------------------------------------------------------------

loc_12498:
		tst.b	(Time_over_flag).w
		beq.s	locret_124C6
		move.w	#0,$3E(a0)
		move.l	#Obj_GameOver,(Reserved_object_3).w
		move.l	#Obj_GameOver,(Dynamic_object_RAM).w
		move.b	#2,(Reserved_object_3+mapping_frame).w
		move.b	#3,(Dynamic_object_RAM+mapping_frame).w
		move.w	a0,(Reserved_object_3+objoff_3E).w
		bra.s	loc_12478
; ---------------------------------------------------------------------------

locret_124C6:
		rts
; ---------------------------------------------------------------------------

loc_124C8:
		move.b	#2,routine(a0)
		cmpa.w	#Player_1,a0
		bne.s	loc_12502
		move.b	#0,(Scroll_lock).w
		move.w	(Saved_X_pos).w,x_pos(a0)
		move.w	(Saved_Y_pos).w,y_pos(a0)
		move.w	(Saved_art_tile).w,art_tile(a0)
		move.w	(Saved_solid_bits).w,top_solid_bit(a0)
		clr.w	(Ring_count).w
		clr.b	(Extra_life_flags).w
		move.b	#1,(_unkF74A).w
		bra.s	loc_1252A
; ---------------------------------------------------------------------------

loc_12502:
		move.b	#0,(Scroll_lock_P2).w
		move.w	(Saved2_X_pos).w,x_pos(a0)
		move.w	(Saved2_Y_pos).w,y_pos(a0)
		move.w	(Saved2_art_tile).w,art_tile(a0)
		move.w	(Saved2_solid_bits).w,top_solid_bit(a0)
		clr.w	(Ring_count_P2).w
		move.b	#1,(_unkF74B).w

loc_1252A:
		move.b	#0,object_control(a0)
		move.b	#5,anim(a0)
		move.w	#0,x_vel(a0)
		move.w	#0,y_vel(a0)
		move.w	#0,ground_vel(a0)
		move.b	#2,status(a0)
		move.w	#0,move_lock(a0)
		move.w	#0,spin_dash_counter(a0)
		clr.b	speed_shoes_timer(a0)
		lea	(Character_Speeds).l,a1
		moveq	#0,d0
		move.b	character_id(a0),d0
		lsl.w	#3,d0
		lea	(a1,d0.w),a1
		move.w	(a1)+,Max_speed-Max_speed(a4)
		move.w	(a1)+,Acceleration-Max_speed(a4)
		move.w	(a1)+,Deceleration-Max_speed(a4)
		rts
; End of function sub_123C2

; ---------------------------------------------------------------------------

loc_1257C:
		tst.w	$3E(a0)
		beq.s	locret_1258E
		subq.w	#1,$3E(a0)
		bne.s	locret_1258E
		move.w	#1,(Restart_level_flag).w

locret_1258E:
		rts
; ---------------------------------------------------------------------------

loc_12590:
		tst.w	(H_scroll_amount).w
		bne.s	loc_125A2
		tst.w	(V_scroll_amount).w
		bne.s	loc_125A2
		move.b	#2,routine(a0)

loc_125A2:
		bsr.w	sub_125E0
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_125AC:
		tst.w	(Debug_mode_flag).w
		beq.s	loc_125C6
		btst	#button_B,(Ctrl_1_pressed).w
		beq.s	loc_125C6
		move.w	#1,(Debug_placement_mode).w
		clr.b	(Ctrl_1_locked).w
		rts
; ---------------------------------------------------------------------------

loc_125C6:
		jsr	(MoveSprite_TestGravity2).l
		addi.w	#$10,y_vel(a0)
		bsr.w	Sonic_RecordPos
		bsr.w	sub_125E0
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_125E0:
		tst.w	(Competition_mode).w
		bne.s	loc_125F8
		bsr.s	Animate_Sonic
		tst.b	(Reverse_gravity_flag).w
		beq.s	loc_125F4
		eori.b	#2,render_flags(a0)

loc_125F4:
		bra.w	Sonic_Load_PLC
; ---------------------------------------------------------------------------

loc_125F8:
		bsr.w	Animate_SonicKnuckles_2P
		bra.w	SonicKnuckles2P_Load_PLC
; End of function sub_125E0


; =============== S U B R O U T I N E =======================================


Animate_Sonic:
		lea	(AniSonic).l,a1
		tst.b	(Super_Sonic_Knux_flag).w
		beq.s	loc_12612
		lea	(AniSuperSonic).l,a1

loc_12612:
		moveq	#0,d0
		move.b	anim(a0),d0
		cmp.b	prev_anim(a0),d0
		beq.s	loc_12634
		move.b	d0,prev_anim(a0)
		move.b	#0,anim_frame(a0)
		move.b	#0,anim_frame_timer(a0)
		bclr	#5,status(a0)

loc_12634:
		add.w	d0,d0
		adda.w	(a1,d0.w),a1
		move.b	(a1),d0
		bmi.s	loc_126A4
		move.b	status(a0),d1
		andi.b	#1,d1
		andi.b	#$FC,render_flags(a0)
		or.b	d1,render_flags(a0)
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	locret_12672
		move.b	d0,anim_frame_timer(a0)

loc_1265A:
		moveq	#0,d1
		move.b	anim_frame(a0),d1
		move.b	1(a1,d1.w),d0
		cmpi.b	#$FC,d0
		bhs.s	loc_12674

loc_1266A:
		move.b	d0,mapping_frame(a0)
		addq.b	#1,anim_frame(a0)

locret_12672:
		rts
; ---------------------------------------------------------------------------

loc_12674:
		addq.b	#1,d0
		bne.s	loc_12684
		move.b	#0,anim_frame(a0)
		move.b	1(a1),d0
		bra.s	loc_1266A
; ---------------------------------------------------------------------------

loc_12684:
		addq.b	#1,d0
		bne.s	loc_12698
		move.b	2(a1,d1.w),d0
		sub.b	d0,anim_frame(a0)
		sub.b	d0,d1
		move.b	1(a1,d1.w),d0
		bra.s	loc_1266A
; ---------------------------------------------------------------------------

loc_12698:
		addq.b	#1,d0
		bne.s	locret_126A2
		move.b	2(a1,d1.w),anim(a0)

locret_126A2:
		rts
; ---------------------------------------------------------------------------

loc_126A4:
		addq.b	#1,d0
		bne.w	loc_12A2A
		moveq	#0,d0
		tst.b	flip_type(a0)
		bmi.w	Anim_Tumble
		move.b	flip_angle(a0),d0
		bne.w	Anim_Tumble
		moveq	#0,d1
		move.b	angle(a0),d0
		bmi.s	loc_126C8
		beq.s	loc_126C8
		subq.b	#1,d0

loc_126C8:
		move.b	status(a0),d2
		andi.b	#1,d2
		bne.s	loc_126D4
		not.b	d0

loc_126D4:
		addi.b	#$10,d0
		bpl.s	loc_126DC
		moveq	#3,d1

loc_126DC:
		andi.b	#$FC,render_flags(a0)
		eor.b	d1,d2
		or.b	d2,render_flags(a0)
		btst	#5,status(a0)
		bne.w	loc_12A72
		lsr.b	#4,d0
		andi.b	#6,d0
		move.w	ground_vel(a0),d2
		bpl.s	loc_12700
		neg.w	d2

loc_12700:
		tst.b	status_secondary(a0)
		bpl.w	loc_1270A
		add.w	d2,d2

loc_1270A:
		tst.b	(Super_Sonic_Knux_flag).w
		bne.s	loc_12766
		lea	(AniSonic01).l,a1
		cmpi.w	#$600,d2
		bhs.s	loc_12724
		lea	(AniSonic00).l,a1
		add.b	d0,d0

loc_12724:
		add.b	d0,d0
		move.b	d0,d3
		moveq	#0,d1
		move.b	anim_frame(a0),d1
		move.b	1(a1,d1.w),d0
		cmpi.b	#-1,d0
		bne.s	loc_12742
		move.b	#0,anim_frame(a0)
		move.b	1(a1),d0

loc_12742:
		move.b	d0,mapping_frame(a0)
		add.b	d3,mapping_frame(a0)
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	locret_12764
		neg.w	d2
		addi.w	#$800,d2
		bpl.s	loc_1275A
		moveq	#0,d2

loc_1275A:
		lsr.w	#8,d2
		move.b	d2,anim_frame_timer(a0)
		addq.b	#1,anim_frame(a0)

locret_12764:
		rts
; ---------------------------------------------------------------------------

loc_12766:
		lea	(AniSuperSonic01).l,a1
		cmpi.w	#$800,d2
		bhs.s	loc_1277E
		lea	(AniSuperSonic00).l,a1
		add.b	d0,d0
		add.b	d0,d0
		bra.s	loc_12780
; ---------------------------------------------------------------------------

loc_1277E:
		add.b	d0,d0

loc_12780:
		move.b	d0,d3
		moveq	#0,d1
		move.b	anim_frame(a0),d1
		move.b	1(a1,d1.w),d0
		cmpi.b	#-1,d0
		bne.s	loc_1279C
		move.b	#0,anim_frame(a0)
		move.b	1(a1),d0

loc_1279C:
		move.b	d0,mapping_frame(a0)
		add.b	d3,mapping_frame(a0)
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	locret_127BE
		neg.w	d2
		addi.w	#$800,d2
		bpl.s	loc_127B4
		moveq	#0,d2

loc_127B4:
		lsr.w	#8,d2
		move.b	d2,anim_frame_timer(a0)
		addq.b	#1,anim_frame(a0)

locret_127BE:
		rts
; ---------------------------------------------------------------------------

;loc_127C0:
Anim_Tumble:
		move.b	flip_type(a0),d1
		andi.w	#$7F,d1
		bne.w	loc_12872
		move.b	flip_angle(a0),d0
		moveq	#0,d1
		move.b	status(a0),d2
		andi.b	#1,d2
		bne.s	Anim_TumbleLeft
		andi.b	#$FC,render_flags(a0)
		tst.b	flip_type(a0)
		bpl.s	loc_12806
		cmpi.b	#$B,(Current_zone).w	; is this DEZ?
		beq.s	loc_1280A		; if so, branch
		cmpi.b	#4,(Current_zone).w	; is this FBZ?
		beq.s	loc_1280A		; if so, branch
		ori.b	#2,render_flags(a0)
		neg.b	d0
		addi.b	#$8F,d0
		bra.s	loc_1280A
; ---------------------------------------------------------------------------

loc_12806:
		addi.b	#$B,d0

loc_1280A:
		divu.w	#$16,d0
		addi.b	#$31,d0
		move.b	d0,mapping_frame(a0)
		move.b	#0,anim_frame_timer(a0)
		rts
; ---------------------------------------------------------------------------

;loc_1281E:
Anim_TumbleLeft:
		andi.b	#$FC,render_flags(a0)
		tst.b	flip_type(a0)
		bpl.s	loc_1284E
		cmpi.b	#4,(Current_zone).w	; is this FBZ?
		beq.s	loc_12842		; if so, branch
		cmpi.b	#$B,(Current_zone).w	; is this DEZ?
		beq.s	loc_12842		; if so, branch
		cmpi.b	#7,(Current_zone).w	; is this MHZ?
		bne.s	loc_1284E		; if not, branch

loc_12842:
		ori.b	#1,render_flags(a0)
		addi.b	#$B,d0
		bra.s	loc_1285A
; ---------------------------------------------------------------------------

loc_1284E:
		ori.b	#3,render_flags(a0)
		neg.b	d0
		addi.b	#$8F,d0

loc_1285A:
		divu.w	#$16,d0
		addi.b	#$31,d0
		move.b	d0,mapping_frame(a0)
		move.b	#0,anim_frame_timer(a0)
		rts
; ---------------------------------------------------------------------------
byte_1286E:
		dc.b    0, $3D, $49, $49
		even
; ---------------------------------------------------------------------------

loc_12872:
		move.b	byte_1286E(pc,d1.w),d3
		cmpi.b	#1,d1
		bne.s	loc_128CA
		move.b	flip_angle(a0),d0
		moveq	#0,d1
		move.b	status(a0),d2
		andi.b	#1,d2
		bne.s	loc_128A8
		andi.b	#$FC,render_flags(a0)
		addi.b	#-8,d0
		divu.w	#$16,d0
		add.b	d3,d0
		move.b	d0,mapping_frame(a0)
		move.b	#0,anim_frame_timer(a0)
		rts
; ---------------------------------------------------------------------------

loc_128A8:
		andi.b	#$FC,render_flags(a0)
		ori.b	#1,render_flags(a0)
		addi.b	#-8,d0
		divu.w	#$16,d0
		add.b	d3,d0
		move.b	d0,mapping_frame(a0)
		move.b	#0,anim_frame_timer(a0)
		rts
; ---------------------------------------------------------------------------

loc_128CA:
		cmpi.b	#2,d1
		bne.s	loc_12920
		move.b	flip_angle(a0),d0
		moveq	#0,d1
		move.b	status(a0),d2
		andi.b	#1,d2
		bne.s	loc_128FC
		andi.b	#$FC,render_flags(a0)
		addi.b	#$B,d0
		divu.w	#$16,d0
		add.b	d3,d0
		move.b	d0,mapping_frame(a0)
		move.b	#0,anim_frame_timer(a0)
		rts
; ---------------------------------------------------------------------------

loc_128FC:
		andi.b	#$FC,render_flags(a0)
		ori.b	#3,render_flags(a0)
		neg.b	d0
		addi.b	#$8F,d0
		divu.w	#$16,d0
		add.b	d3,d0
		move.b	d0,mapping_frame(a0)
		move.b	#0,anim_frame_timer(a0)
		rts
; ---------------------------------------------------------------------------

loc_12920:
		cmpi.b	#3,d1
		bne.s	loc_1297C
		move.b	flip_angle(a0),d0
		moveq	#0,d1
		move.b	status(a0),d2
		andi.b	#1,d2
		bne.s	loc_1295A
		andi.b	#$FC,render_flags(a0)
		ori.b	#2,render_flags(a0)
		neg.b	d0
		addi.b	#$8F,d0
		divu.w	#$16,d0
		add.b	d3,d0
		move.b	d0,mapping_frame(a0)
		move.b	#0,anim_frame_timer(a0)
		rts
; ---------------------------------------------------------------------------

loc_1295A:
		andi.b	#$FC,render_flags(a0)
		ori.b	#1,render_flags(a0)
		addi.b	#$B,d0
		divu.w	#$16,d0
		add.b	d3,d0
		move.b	d0,mapping_frame(a0)
		move.b	#0,anim_frame_timer(a0)
		rts
; ---------------------------------------------------------------------------

loc_1297C:
		cmpi.b	#4,d1
		bne.s	loc_129F6
		move.b	flip_angle(a0),d0
		moveq	#0,d1
		move.b	status(a0),d2
		andi.b	#1,d2
		bne.s	loc_129BC
		andi.b	#$FC,render_flags(a0)
		tst.b	flip_type(a0)
		bpl.s	loc_129A4
		addi.b	#$B,d0
		bra.s	loc_129A8
; ---------------------------------------------------------------------------

loc_129A4:
		addi.b	#$B,d0

loc_129A8:
		divu.w	#$16,d0
		addi.b	#$31,d0
		move.b	d0,mapping_frame(a0)
		move.b	#0,anim_frame_timer(a0)
		rts
; ---------------------------------------------------------------------------

loc_129BC:
		andi.b	#$FC,render_flags(a0)
		tst.b	flip_type(a0)
		bpl.s	loc_129D6
		ori.b	#3,render_flags(a0)
		neg.b	d0
		addi.b	#$8F,d0
		bra.s	loc_129E2
; ---------------------------------------------------------------------------

loc_129D6:
		ori.b	#3,render_flags(a0)
		neg.b	d0
		addi.b	#$8F,d0

loc_129E2:
		divu.w	#$16,d0
		addi.b	#$31,d0
		move.b	d0,mapping_frame(a0)
		move.b	#0,anim_frame_timer(a0)
		rts
; ---------------------------------------------------------------------------

loc_129F6:
		move.b	flip_angle(a0),d0
		andi.b	#$FC,render_flags(a0)
		moveq	#0,d1
		move.b	status(a0),d2
		andi.b	#1,d2
		beq.s	loc_12A12
		ori.b	#1,render_flags(a0)

loc_12A12:
		addi.b	#$B,d0
		divu.w	#$16,d0
		addi.b	#$31,d0
		move.b	d0,mapping_frame(a0)
		move.b	#0,anim_frame_timer(a0)
		rts
; ---------------------------------------------------------------------------

loc_12A2A:
		move.b	status(a0),d1
		andi.b	#1,d1
		andi.b	#$FC,render_flags(a0)
		or.b	d1,render_flags(a0)
		subq.b	#1,anim_frame_timer(a0)
		bpl.w	locret_12672
		move.w	ground_vel(a0),d2
		bpl.s	loc_12A4C
		neg.w	d2

loc_12A4C:
		lea	(AniSonic03).l,a1
		cmpi.w	#$600,d2
		bhs.s	loc_12A5E
		lea	(AniSonic02).l,a1

loc_12A5E:
		neg.w	d2
		addi.w	#$400,d2
		bpl.s	loc_12A68
		moveq	#0,d2

loc_12A68:
		lsr.w	#8,d2
		move.b	d2,anim_frame_timer(a0)
		bra.w	loc_1265A
; ---------------------------------------------------------------------------

loc_12A72:
		subq.b	#1,anim_frame_timer(a0)
		bpl.w	locret_12672
		move.w	ground_vel(a0),d2
		bmi.s	loc_12A82
		neg.w	d2

loc_12A82:
		addi.w	#$800,d2
		bpl.s	loc_12A8A
		moveq	#0,d2

loc_12A8A:
		lsr.w	#6,d2
		move.b	d2,anim_frame_timer(a0)
		lea	(AniSonic04).l,a1
		tst.b	(Super_Sonic_Knux_flag).w
		beq.s	loc_12AA2
		lea	(AniSuperSonic04).l,a1

loc_12AA2:
		bra.w	loc_1265A
; End of function Animate_Sonic

; ---------------------------------------------------------------------------
AniSonic:
		include "General/Sprites/Sonic/Anim - Sonic.asm"

; =============== S U B R O U T I N E =======================================


Sonic_Load_PLC:
		moveq	#0,d0
		move.b	mapping_frame(a0),d0

Sonic_Load_PLC2:
		cmp.b	(Player_prev_frame).w,d0
		beq.s	locret_12D20
		move.b	d0,(Player_prev_frame).w
		lea	(PLC_Sonic).l,a2
		tst.b	(Super_Sonic_Knux_flag).w
		beq.s	loc_12CD6
		lea	(PLC_SuperSonic).l,a2

loc_12CD6:
		add.w	d0,d0
		adda.w	(a2,d0.w),a2
		move.w	(a2)+,d5
		subq.w	#1,d5
		bmi.s	locret_12D20
		move.w	#tiles_to_bytes(ArtTile_Player_1),d4
		move.l	#ArtUnc_Sonic,d6
		cmpi.w	#2*$DA,d0
		blo.s	loc_12CF8
		move.l	#ArtUnc_Sonic_Extra,d6

loc_12CF8:
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
		dbf	d5,loc_12CF8

locret_12D20:
		rts
; End of function Sonic_Load_PLC


; =============== S U B R O U T I N E =======================================


Perform_Player_DPLC:
		tst.b	character_id(a1)
		beq.s	Sonic_Load_PLC2
		cmpi.b	#1,character_id(a1)
		beq.w	Tails_Load_PLC2
		bra.w	Knuckles_Load_PLC2
; End of function Perform_Player_DPLC


; =============== S U B R O U T I N E =======================================


Animate_SonicKnuckles_2P:
		lea	(AniSonic2P).l,a1
		tst.b	character_id(a0)
		beq.s	loc_12D48
		lea	(AniKnuckles2P).l,a1

loc_12D48:
		moveq	#0,d0
		move.b	anim(a0),d0
		cmp.b	prev_anim(a0),d0
		beq.s	loc_12D6A
		move.b	d0,prev_anim(a0)
		move.b	#0,anim_frame(a0)
		move.b	#0,anim_frame_timer(a0)
		bclr	#Status_Push,status(a0)

loc_12D6A:
		add.w	d0,d0
		adda.w	(a1,d0.w),a1
		move.b	(a1),d0
		bmi.s	loc_12DDA
		move.b	status(a0),d1
		andi.b	#1,d1
		andi.b	#$FC,render_flags(a0)
		or.b	d1,render_flags(a0)
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	locret_12DA8
		move.b	d0,anim_frame_timer(a0)

loc_12D90:
		moveq	#0,d1
		move.b	anim_frame(a0),d1
		move.b	1(a1,d1.w),d0
		cmpi.b	#$FC,d0
		bhs.s	loc_12DAA

loc_12DA0:
		move.b	d0,mapping_frame(a0)
		addq.b	#1,anim_frame(a0)

locret_12DA8:
		rts
; ---------------------------------------------------------------------------

loc_12DAA:
		addq.b	#1,d0
		bne.s	loc_12DBA
		move.b	#0,anim_frame(a0)
		move.b	1(a1),d0
		bra.s	loc_12DA0
; ---------------------------------------------------------------------------

loc_12DBA:
		addq.b	#1,d0
		bne.s	loc_12DCE
		move.b	2(a1,d1.w),d0
		sub.b	d0,anim_frame(a0)
		sub.b	d0,d1
		move.b	1(a1,d1.w),d0
		bra.s	loc_12DA0
; ---------------------------------------------------------------------------

loc_12DCE:
		addq.b	#1,d0
		bne.s	locret_12DD8
		move.b	2(a1,d1.w),anim(a0)

locret_12DD8:
		rts
; ---------------------------------------------------------------------------

loc_12DDA:
		addq.b	#1,d0
		bne.w	loc_12EF4
		moveq	#0,d0
		move.b	flip_angle(a0),d0
		bne.w	loc_12E8E
		moveq	#0,d1
		move.b	angle(a0),d0
		bmi.s	loc_12DF6
		beq.s	loc_12DF6
		subq.b	#1,d0

loc_12DF6:
		move.b	status(a0),d2
		andi.b	#1,d2
		bne.s	loc_12E02
		not.b	d0

loc_12E02:
		addi.b	#$10,d0
		bpl.s	loc_12E0A
		moveq	#3,d1

loc_12E0A:
		andi.b	#$FC,render_flags(a0)
		eor.b	d1,d2
		or.b	d2,render_flags(a0)
		btst	#Status_Push,status(a0)
		bne.w	loc_12F3C
		lsr.b	#5,d0
		andi.b	#3,d0
		move.w	ground_vel(a0),d2
		bpl.s	loc_12E2E
		neg.w	d2

loc_12E2E:
		tst.b	status_secondary(a0)
		bpl.w	loc_12E38
		add.w	d2,d2

loc_12E38:
		move.b	d0,d3
		lea	(AniSonic2P01).l,a1
		cmpi.w	#$600,d2
		bhs.s	loc_12E4E
		lea	(AniSonic2P00).l,a1
		add.b	d0,d0

loc_12E4E:
		add.b	d0,d3
		moveq	#0,d1
		move.b	anim_frame(a0),d1
		move.b	1(a1,d1.w),d0
		cmpi.b	#-1,d0
		bne.s	loc_12E6A
		move.b	#0,anim_frame(a0)
		move.b	1(a1),d0

loc_12E6A:
		move.b	d0,mapping_frame(a0)
		add.b	d3,mapping_frame(a0)
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	locret_12E8C
		neg.w	d2
		addi.w	#$800,d2
		bpl.s	loc_12E82
		moveq	#0,d2

loc_12E82:
		lsr.w	#8,d2
		move.b	d2,anim_frame_timer(a0)
		addq.b	#1,anim_frame(a0)

locret_12E8C:
		rts
; ---------------------------------------------------------------------------

loc_12E8E:
		move.b	flip_angle(a0),d0
		moveq	#0,d1
		move.b	status(a0),d2
		andi.b	#1,d2
		bne.s	loc_12EBC
		andi.b	#$FC,render_flags(a0)
		addi.b	#$16,d0
		divu.w	#$2C,d0
		addi.b	#$15,d0
		move.b	d0,mapping_frame(a0)
		move.b	#0,anim_frame_timer(a0)
		rts
; ---------------------------------------------------------------------------

loc_12EBC:
		andi.b	#$FC,render_flags(a0)
		tst.b	flip_type(a0)
		bpl.s	loc_12ED4
		ori.b	#1,render_flags(a0)
		addi.b	#$16,d0
		bra.s	loc_12EE0
; ---------------------------------------------------------------------------

loc_12ED4:
		ori.b	#3,render_flags(a0)
		neg.b	d0
		addi.b	#$9A,d0

loc_12EE0:
		divu.w	#$2C,d0
		addi.b	#$15,d0
		move.b	d0,mapping_frame(a0)
		move.b	#0,anim_frame_timer(a0)
		rts
; ---------------------------------------------------------------------------

loc_12EF4:
		subq.b	#1,anim_frame_timer(a0)
		bpl.w	locret_12DA8
		move.w	ground_vel(a0),d2
		bpl.s	loc_12F04
		neg.w	d2

loc_12F04:
		lea	(AniSonic2P03).l,a1
		cmpi.w	#$600,d2
		bhs.s	loc_12F16
		lea	(AniSonic2P02).l,a1

loc_12F16:
		neg.w	d2
		addi.w	#$400,d2
		bpl.s	loc_12F20
		moveq	#0,d2

loc_12F20:
		lsr.w	#8,d2
		move.b	d2,anim_frame_timer(a0)
		move.b	status(a0),d1
		andi.b	#1,d1
		andi.b	#$FC,render_flags(a0)
		or.b	d1,render_flags(a0)
		bra.w	loc_12D90
; ---------------------------------------------------------------------------

loc_12F3C:
		subq.b	#1,anim_frame_timer(a0)
		bpl.w	locret_12DA8
		move.w	ground_vel(a0),d2
		bmi.s	loc_12F4C
		neg.w	d2

loc_12F4C:
		addi.w	#$800,d2
		bpl.s	loc_12F54
		moveq	#0,d2

loc_12F54:
		lsr.w	#6,d2
		lea	(AniSonic2P04).l,a1
		tst.b	character_id(a0)
		beq.s	loc_12F6A
		lea	(AniKnuckles2P04).l,a1
		lsr.w	#2,d2

loc_12F6A:
		move.b	d2,anim_frame_timer(a0)
		move.b	status(a0),d1
		andi.b	#1,d1
		andi.b	#$FC,render_flags(a0)
		or.b	d1,render_flags(a0)
		bra.w	loc_12D90
; End of function Animate_SonicKnuckles_2P

; ---------------------------------------------------------------------------
AniSonic2P:
		include "General/Sprites/Sonic/Anim - Sonic Knuckles 2P.asm"

; =============== S U B R O U T I N E =======================================


SonicKnuckles2P_Load_PLC:
		moveq	#0,d0
		move.b	mapping_frame(a0),d0
		lea	(PLC_Sonic2P).l,a2
		move.l	#ArtUnc_Sonic2P,d6
		tst.b	character_id(a0)
		beq.s	loc_130BE
		lea	(PLC_Knuckles2P).l,a2
		move.l	#ArtUnc_Knuckles2P,d6

loc_130BE:
		add.w	d0,d0
		adda.w	(a2,d0.w),a2
		move.w	(a2)+,d5
		subq.w	#1,d5
		bmi.s	locret_13100
		move.w	#tiles_to_bytes(ArtTile_Player_1),d4
		cmpa.w	#Player_1,a0
		beq.s	loc_130D8
		move.w	#tiles_to_bytes(ArtTile_Player_2),d4

loc_130D8:
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
		dbf	d5,loc_130D8

locret_13100:
		rts
; End of function SonicKnuckles2P_Load_PLC

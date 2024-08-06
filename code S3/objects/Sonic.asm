Obj_Sonic2P:
		cmpa.w	#Player_1,a0
		bne.s	++ ;loc_1170A
		lea	(Max_speed).w,a4
		lea	(Distance_from_top).w,a5
		lea	(Dust).w,a6
		move.b	(Player_2+character_id).w,d0
		cmp.b	character_id(a0),d0
		bne.s	+ ;loc_116FE
		bchg	#3,render_flags(a0)

+ ;loc_116FE:
		tst.w	(Debug_placement_mode).w
		beq.s	++ ;loc_11726
		jmp	(DebugMode).l
; ---------------------------------------------------------------------------

+ ;loc_1170A:
		lea	(Max_speed_P2).w,a4
		lea	(Distance_from_top_P2).w,a5
		lea	(Dust_P2).w,a6
		move.b	(Player_1+character_id).w,d0
		cmp.b	character_id(a0),d0
		bne.s	+ ;loc_11726
		bchg	#4,render_flags(a0)

+ ;loc_11726:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	.Index(pc,d0.w),d1
		jmp	.Index(pc,d1.w)
; ---------------------------------------------------------------------------
.Index:
		dc.w loc_11740-.Index
		dc.w loc_11858-.Index
		dc.w loc_13142-.Index
		dc.w loc_131FE-.Index
		dc.w loc_133D4-.Index
		dc.w loc_133E8-.Index
; ---------------------------------------------------------------------------

loc_11740:
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
		bne.w	loc_1183C
		move.b	#$C,top_solid_bit(a0)
		move.b	#$D,lrb_solid_bit(a0)
		cmpa.w	#Player_1,a0
		bne.s	+++ ;loc_117F4
		move.w	#make_art_tile(ArtTile_Player_1,0,0),art_tile(a0)
		move.l	#Map_Sonic2P,mappings(a0)
		tst.b	character_id(a0)
		beq.s	+ ;loc_117CC
		move.l	#Map_Knuckles2P,mappings(a0)
		addi.w	#palette_line_1,art_tile(a0)

+ ;loc_117CC:
		cmpi.b	#$12,(Current_zone).w
		bne.s	+ ;loc_117DA
		ori.w	#high_priority,art_tile(a0)

+ ;loc_117DA:
		move.w	x_pos(a0),(Saved_X_pos).w
		move.w	y_pos(a0),(Saved_Y_pos).w
		move.w	art_tile(a0),(Saved_art_tile).w
		move.w	top_solid_bit(a0),(Saved_solid_bits).w
		bra.s	loc_1183C
; ---------------------------------------------------------------------------

+ ;loc_117F4:
		move.w	#make_art_tile(ArtTile_Player_2,0,0),art_tile(a0)
		move.l	#Map_Sonic2P,mappings(a0)
		tst.b	character_id(a0)
		beq.s	+ ;loc_11816
		move.l	#Map_Knuckles2P,mappings(a0)
		addi.w	#palette_line_1,art_tile(a0)

+ ;loc_11816:
		cmpi.b	#$12,(Current_zone).w
		bne.s	+ ;loc_11824
		ori.w	#high_priority,art_tile(a0)

+ ;loc_11824:
		move.w	x_pos(a0),(Saved2_X_pos).w
		move.w	y_pos(a0),(Saved2_Y_pos).w
		move.w	art_tile(a0),(Saved2_art_tile).w
		move.w	top_solid_bit(a0),(Saved2_solid_bits).w

loc_1183C:
		move.b	#0,flips_remaining(a0)
		move.b	#4,flip_speed(a0)
		move.b	#0,(Super_Sonic_Knux_flag).w
		move.b	#30,air_left(a0)
		bsr.w	Reset_Player_Position_Array

loc_11858:
		tst.w	(Debug_mode_flag).w
		beq.s	+ ;loc_11878
		cmpa.w	#Player_1,a0
		bne.s	+ ;loc_11878
		btst	#button_B,(Ctrl_1_pressed).w
		beq.s	+ ;loc_11878
		move.w	#1,(Debug_placement_mode).w
		clr.b	(Ctrl_1_locked).w
		rts
; ---------------------------------------------------------------------------

+ ;loc_11878:
		cmpa.w	#Player_1,a0
		bne.s	+ ;loc_1188C
		tst.b	(Ctrl_1_locked).w
		bne.s	++ ;loc_11898
		move.w	(Ctrl_1).w,(Ctrl_1_logical).w
		bra.s	++ ;loc_11898
; ---------------------------------------------------------------------------

+ ;loc_1188C:
		tst.b	(Ctrl_2_locked).w
		bne.s	+ ;loc_11898
		move.w	(Ctrl_2).w,(Ctrl_1_logical).w

+ ;loc_11898:
		bsr.w	Sonic_Display
		btst	#0,object_control(a0)
		bne.s	+ ;loc_118B6
		moveq	#0,d0
		move.b	status(a0),d0
		andi.w	#6,d0
		move.w	off_11906(pc,d0.w),d1
		jsr	off_11906(pc,d1.w)

+ ;loc_118B6:
		cmpi.w	#-$100,(Camera_min_Y_pos).w
		bne.s	+ ;loc_118C6
		move.w	(Screen_Y_wrap_value).w,d0
		and.w	d0,y_pos(a0)

+ ;loc_118C6:
		move.w	(Screen_X_wrap_value).w,d0
		and.w	d0,x_pos(a0)
		addi.w	#$400,x_pos(a0)
		bsr.w	Sonic_RecordPos
		move.b	(Primary_Angle).w,next_tilt(a0)
		move.b	(Secondary_Angle).w,tilt(a0)
		btst	#1,object_control(a0)
		bne.s	+ ;loc_118F4
		bsr.w	Animate_SonicKnuckles_2P
		bsr.w	SonicKnuckles2P_Load_PLC

+ ;loc_118F4:
		move.b	object_control(a0),d0
		andi.b	#$A0,d0
		bne.s	locret_11904
		jsr	(TouchResponse_CompetitionMode).l

locret_11904:
		rts
; ---------------------------------------------------------------------------
off_11906:
		dc.w loc_1190E-off_11906
		dc.w loc_11980-off_11906
		dc.w loc_119AE-off_11906
		dc.w loc_119D0-off_11906
; ---------------------------------------------------------------------------

loc_1190E:
		move.b	(Ctrl_1_pressed_logical).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0
		bne.s	+ ;loc_1195C
		cmpi.b	#$A,anim(a0)
		beq.s	locret_1197E
		cmpi.b	#$B,anim(a0)
		beq.s	locret_1197E
		cmpi.b	#5,anim(a0)
		bne.s	+ ;loc_1195C
		cmpi.b	#$1E,anim_frame(a0)
		blo.s	+ ;loc_1195C
		bsr.w	Player_SlopeResist
		move.b	(Ctrl_1_held_logical).w,d0
		andi.b	#$7F,d0
		beq.s	++ ;loc_11976
		move.b	#$A,anim(a0)
		cmpi.b	#$AC,anim_frame(a0)
		blo.s	++ ;loc_11976
		move.b	#$B,anim(a0)
		bra.s	++ ;loc_11976
; ---------------------------------------------------------------------------

+ ;loc_1195C:
		bsr.w	sub_11A64
		bsr.w	Sonic_Jump
		bsr.w	Player_SlopeResist
		bsr.w	Sonic_Move
		bsr.w	sub_119FE
		jsr	(MoveSprite2).l

+ ;loc_11976:
		bsr.w	Player_AnglePos
		bsr.w	Player_SlopeRepel

locret_1197E:
		rts
; ---------------------------------------------------------------------------

loc_11980:
		bsr.w	Sonic_JumpHeight
		bsr.w	Sonic_ChgJumpDir
		jsr	(MoveSprite).l
		btst	#Status_Underwater,status(a0)
		beq.s	+ ;loc_1199C
		subi.w	#$28,y_vel(a0)

+ ;loc_1199C:
		bsr.w	Player_JumpAngle
		movem.l	a4-a6,-(sp)
		bsr.w	Sonic_DoLevelCollision
		movem.l	(sp)+,a4-a6
		rts
; ---------------------------------------------------------------------------

loc_119AE:
		tst.b	spin_dash_flag(a0)
		bne.s	+ ;loc_119B8
		bsr.w	Sonic_Jump

+ ;loc_119B8:
		bsr.w	Player_RollRepel
		bsr.w	Sonic_RollSpeed
		jsr	(MoveSprite2).l
		bsr.w	Player_AnglePos
		bsr.w	Player_SlopeRepel
		rts
; ---------------------------------------------------------------------------

loc_119D0:
		bsr.w	Sonic_JumpHeight
		bsr.w	Sonic_ChgJumpDir
		jsr	(MoveSprite).l
		btst	#Status_Underwater,status(a0)
		beq.s	+ ;loc_119EC
		subi.w	#$28,y_vel(a0)

+ ;loc_119EC:
		bsr.w	Player_JumpAngle
		movem.l	a4-a6,-(sp)
		bsr.w	Sonic_DoLevelCollision
		movem.l	(sp)+,a4-a6
		rts

; =============== S U B R O U T I N E =======================================


sub_119FE:
		tst.b	status_secondary(a0)
		bmi.s	locret_11A24
		move.w	ground_vel(a0),d0
		bpl.s	+ ;loc_11A0C
		neg.w	d0

+ ;loc_11A0C:
		cmpi.w	#$80,d0
		blo.s	locret_11A24
		move.b	(Ctrl_1_held_logical).w,d0
		andi.b	#button_left_mask|button_right_mask,d0
		bne.s	locret_11A24
		btst	#button_down,(Ctrl_1_held_logical).w
		bne.s	+ ;loc_11A26

locret_11A24:
		rts
; ---------------------------------------------------------------------------

+ ;loc_11A26:
		btst	#2,status(a0)
		beq.s	+ ;loc_11A30
		rts
; ---------------------------------------------------------------------------

+ ;loc_11A30:
		bset	#Status_Roll,status(a0)
		move.b	#7,y_radius(a0)
		move.b	#3,x_radius(a0)
		move.b	#2,anim(a0)
		addq.w	#4,y_pos(a0)
		move.w	#sfx_Roll,d0
		jsr	(Play_SFX).l
		tst.w	ground_vel(a0)
		bne.s	locret_11A62
		move.w	#$200,ground_vel(a0)

locret_11A62:
		rts
; End of function sub_119FE


; =============== S U B R O U T I N E =======================================


sub_11A64:
		tst.b	spin_dash_flag(a0)
		bne.s	++ ;loc_11AB0
		cmpi.b	#8,anim(a0)
		bne.s	locret_11AAE
		move.b	(Ctrl_1_pressed_logical).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0
		beq.w	locret_11AAE
		move.b	#9,anim(a0)
		move.w	#signextendB(sfx_Spindash),d0
		jsr	(Play_SFX).l
		addq.l	#4,sp
		move.b	#1,spin_dash_flag(a0)
		move.w	#0,spin_dash_counter(a0)
		cmpi.b	#12,air_left(a0)
		blo.s	+ ;loc_11AAA
		move.b	#2,anim(a6)

+ ;loc_11AAA:
		bsr.w	Player_AnglePos

locret_11AAE:
		rts
; ---------------------------------------------------------------------------

+ ;loc_11AB0:
		move.b	(Ctrl_1_held_logical).w,d0
		btst	#button_down,d0
		bne.w	+++ ;loc_11B5C
		move.b	#7,y_radius(a0)
		move.b	#3,x_radius(a0)
		move.b	#2,anim(a0)
		addq.w	#4,y_pos(a0)
		move.b	#0,spin_dash_flag(a0)
		moveq	#0,d0
		move.b	spin_dash_counter(a0),d0
		add.w	d0,d0
		move.w	word_11B38(pc,d0.w),ground_vel(a0)
		tst.b	(Super_Sonic_Knux_flag).w
		beq.s	loc_11AF2
		move.w	word_11B4A(pc,d0.w),ground_vel(a0)

loc_11AF2:
		move.w	ground_vel(a0),d0
		subi.w	#$800,d0
		add.w	d0,d0
		andi.w	#$1F00,d0
		neg.w	d0
		addi.w	#$2000,d0
		lea	(H_scroll_frame_offset).w,a1
		cmpa.w	#Player_1,a0
		beq.s	+ ;loc_11B14
		lea	(H_scroll_frame_offset_P2).w,a1

+ ;loc_11B14:
		move.w	d0,(a1)
		btst	#Status_Facing,status(a0)
		beq.s	+ ;loc_11B22
		neg.w	ground_vel(a0)

+ ;loc_11B22:
		bset	#Status_Roll,status(a0)
		move.b	#0,anim(a6)
		moveq	#signextendB(sfx_Dash),d0
		jsr	(Play_SFX).l
		bra.s	+++ ;loc_11BA4
; ---------------------------------------------------------------------------
word_11B38:
		dc.w   $800
		dc.w   $880
		dc.w   $900
		dc.w   $980
		dc.w   $A00
		dc.w   $A80
		dc.w   $B00
		dc.w   $B80
		dc.w   $C00
word_11B4A:
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

+ ;loc_11B5C:
		tst.w	spin_dash_counter(a0)
		beq.s	+ ;loc_11B74
		move.w	spin_dash_counter(a0),d0
		lsr.w	#5,d0
		sub.w	d0,spin_dash_counter(a0)
		bcc.s	+ ;loc_11B74
		move.w	#0,spin_dash_counter(a0)

+ ;loc_11B74:
		move.b	(Ctrl_1_pressed_logical).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0
		beq.w	+ ;loc_11BA4
		move.w	#9<<8,anim(a0)	; and prev_anim
		move.w	#signextendB(sfx_Spindash),d0
		jsr	(Play_SFX).l
		addi.w	#$200,spin_dash_counter(a0)
		cmpi.w	#$800,spin_dash_counter(a0)
		blo.s	+ ;loc_11BA4
		move.w	#$800,spin_dash_counter(a0)

+ ;loc_11BA4:
		addq.l	#4,sp
		cmpi.w	#$60,(a5)
		beq.s	++ ;loc_11BB2
		bcc.s	+ ;loc_11BB0
		addq.w	#4,(a5)

+ ;loc_11BB0:
		subq.w	#2,(a5)

+ ;loc_11BB2:
		bsr.w	Player_AnglePos
		rts
; End of function sub_11A64

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
		beq.s	+ ;loc_11BE0
		move.w	#0,(Debug_placement_mode).w	; Leave debug mode

+ ;loc_11BE0:
		addq.b	#1,mapping_frame(a0)		; Next frame
		cmpi.b	#$D9,mapping_frame(a0)		; Have we reached the end of Sonic's frames?
		bcs.s	+ ;loc_11BF2
		move.b	#0,mapping_frame(a0)		; If so, reset to Sonic's first frame

+ ;loc_11BF2:
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
		dc.w loc_13142-Sonic_Index	;  4
		dc.w loc_131FE-Sonic_Index	;  6
		dc.w loc_133D4-Sonic_Index	;  8
		dc.w loc_133E8-Sonic_Index	; $A
		dc.w loc_13404-Sonic_Index	; $C
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
		beq.s	+ ;loc_11D06			; if not, branch
		btst	#button_B,(Ctrl_1_pressed).w	; is button B pressed?
		beq.s	+ ;loc_11D06			; if not, branch
		move.w	#1,(Debug_placement_mode).w	; change Sonic into a ring/item
		clr.b	(Ctrl_1_locked).w		; unlock control
		btst	#button_C,(Ctrl_1_held).w	; was button C held before pressing B?
		beq.s	locret_11D04			; if not, branch
		move.w	#2,(Debug_placement_mode).w	; enter animation cycle mode

locret_11D04:
		rts
; ---------------------------------------------------------------------------

+ ;loc_11D06:
		tst.b	(Ctrl_1_locked).w		; are controls locked?
		bne.s	+ ;loc_11D12			; if yes, branch
		move.w	(Ctrl_1).w,(Ctrl_1_logical).w	; copy new held buttons, to enable joypad control

+ ;loc_11D12:
		btst	#0,object_control(a0)	; is Sonic interacting with another object that holds him in place or controls his movement somehow?
		beq.s	+ ;loc_11D22		; if yes, branch to skip Sonic's control
		move.b	#0,double_jump_flag(a0)	; enable double jump
		bra.s	++ ;loc_11D3C
; ---------------------------------------------------------------------------

+ ;loc_11D22:
		movem.l	a4-a6,-(sp)
		moveq	#0,d0
		move.b	status(a0),d0
		andi.w	#6,d0
		move.w	Sonic_Modes(pc,d0.w),d1
		jsr	Sonic_Modes(pc,d1.w)	; run Sonic's movement control code
		movem.l	(sp)+,a4-a6

+ ;loc_11D3C:
		cmpi.w	#-$100,(Camera_min_Y_pos).w	; is vertical wrapping enabled?
		bne.s	+ ;loc_11D4C
		move.w	(Screen_Y_wrap_value).w,d0
		and.w	d0,y_pos(a0)			; perform wrapping of Sonic's y position

+ ;loc_11D4C:
		bsr.s	Sonic_Display
		bsr.w	Sonic_Super
		bsr.w	Sonic_RecordPos
		bsr.w	Sonic_Water
		move.b	(Primary_Angle).w,next_tilt(a0)
		move.b	(Secondary_Angle).w,tilt(a0)
		tst.b	(WindTunnel_flag).w
		beq.s	+ ;loc_11D78
		tst.b	anim(a0)
		bne.s	+ ;loc_11D78
		move.b	prev_anim(a0),anim(a0)

+ ;loc_11D78:
		btst	#1,object_control(a0)
		bne.s	+ ;loc_11D88
		bsr.w	Animate_Sonic
		bsr.w	Sonic_Load_PLC

+ ;loc_11D88:
		move.b	object_control(a0),d0
		andi.b	#$A0,d0
		bne.s	locret_11D98
		jsr	(TouchResponse).l

locret_11D98:
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
		beq.s	+ ;loc_11DB0
		subq.b	#1,invulnerability_timer(a0)
		lsr.b	#3,d0
		bcc.s	Sonic_ChkInvin

+ ;loc_11DB0:
		jsr	(Draw_Sprite).l

Sonic_ChkInvin:	; Checks if invincibility has expired and disables it if it has.
		btst	#Status_Invincible,status_secondary(a0)
		beq.s	Sonic_ChkShoes
		tst.b	invincibility_timer(a0)
		beq.s	Sonic_ChkShoes	; If there wasn't any time left, that means we're in Super mode
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
		beq.s	+ ;loc_11E3C	; if Super, set different values
		move.w	#$A00,Max_speed-Max_speed(a4)		; set Max_speed
		move.w	#$30,Acceleration-Max_speed(a4)		; set Acceleration
		move.w	#$100,Deceleration-Max_speed(a4)	; set Deceleration

+ ;loc_11E3C:
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
		bne.s	locret_11EA4			; if so, branch
		move.w	(Pos_table_index).w,d0
		lea	(Pos_table).w,a1
		lea	(a1,d0.w),a1
		move.w	x_pos(a0),(a1)+			; write location to pos_table
		move.w	y_pos(a0),(a1)+
		addq.b	#4,(Pos_table_index+1).w	; increment index as the post-increments did a1
		lea	(Stat_table).w,a1
		lea	(a1,d0.w),a1
		move.w	(Ctrl_1_logical).w,(a1)+
		move.w	status(a0),(a1)+

locret_11EA4:
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
		addq.b	#4,(Pos_table_index_P2+1).w
		rts	; increment index as the post-increments did a1
; End of function Sonic_RecordPos


; =============== S U B R O U T I N E =======================================


Reset_Player_Position_Array:
		cmpa.w	#Player_1,a0			; is object player 1?
		bne.s	Reset_Player_Position_ArrayP2	; if not, branch
		lea	(Pos_table).w,a1
		lea	(Stat_table).w,a2
		move.w	#bytesToLcnt($100),d0

- ;.loop:
		move.w	x_pos(a0),(a1)+			; write location to pos_table
		move.w	y_pos(a0),(a1)+
		move.l	#0,(a2)+
		dbf	d0,- ;.loop
		move.w	#0,(Pos_table_index).w

Reset_Player_Position_ArrayP2:
		tst.w	(Competition_mode).w	; are we in Competition mode?
		beq.s	.return		; if not, branch
		lea	(Stat_table).w,a1
		move.w	#bytesToLcnt($100),d0

- ;.loop:
		move.w	x_pos(a0),(a1)+
		move.w	y_pos(a0),(a1)+
		dbf	d0,- ;.loop
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

locret_11F32:
		rts
; ---------------------------------------------------------------------------

Sonic_InWater:
		move.w	(Water_level).w,d0
		cmp.w	y_pos(a0),d0	; is Sonic above the water?
		bge.s	Sonic_OutWater	; if yes, branch

		bset	#Status_Underwater,status(a0)	; set underwater flag
		bne.s	locret_11F32	; if already underwater, branch

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
		beq.s	+ ;loc_11F88
		move.w	#$500,Max_speed-Max_speed(a4)
		move.w	#$18,Acceleration-Max_speed(a4)
		move.w	#$80,Deceleration-Max_speed(a4)

+ ;loc_11F88:
		tst.b	object_control(a0)
		bne.s	locret_11F32
		asr	x_vel(a0)
		asr	y_vel(a0)		; memory operands can only be shifted one bit at a time
		asr	y_vel(a0)
		beq.s	locret_11F32
		move.w	#1<<8,anim(a6)		; splash animation, write 1 to anim and clear prev_anim
		move.w	#sfx_Splash,d0
		jmp	(Play_SFX).l
; ---------------------------------------------------------------------------

Sonic_OutWater:
		bclr	#Status_Underwater,status(a0)	; unset underwater flag
		beq.w	locret_11F32			; if already above water, branch
		addq.b	#1,(Water_entered_counter).w

		movea.l	a0,a1
		bsr.w	Player_ResetAirTimer
		move.w	#$600,Max_speed-Max_speed(a4)
		move.w	#$C,Acceleration-Max_speed(a4)
		move.w	#$80,Deceleration-Max_speed(a4)
		tst.b	(Super_Sonic_Knux_flag).w
		beq.s	+ ;loc_11FE6	; if Super, set different values
		move.w	#$A00,Max_speed-Max_speed(a4)
		move.w	#$30,Acceleration-Max_speed(a4)
		move.w	#$100,Deceleration-Max_speed(a4)

+ ;loc_11FE6:
		cmpi.b	#4,routine(a0)	; is Sonic falling back from getting hurt?
		beq.s	+ ;loc_12002	; if yes, branch
		tst.b	object_control(a0)
		bne.s	+ ;loc_12002
		move.w	y_vel(a0),d0
		cmpi.w	#-$400,d0
		blt.s	+ ;loc_12002
		asl	y_vel(a0)

+ ;loc_12002:
		cmpi.b	#$1C,anim(a0)	; is Sonic in his 'blank' animation?
		beq.w	locret_11F32	; if so, branch
		tst.w	y_vel(a0)
		beq.w	locret_11F32
		move.w	#1<<8,anim(a6)	; splash animation, write 1 to anim and clear prev_anim
		cmpi.w	#-$1000,y_vel(a0)
		bgt.s	+ ;loc_12028
		move.w	#-$1000,y_vel(a0)	; limit upward y velocity exiting the water

+ ;loc_12028:
		move.w	#sfx_Splash,d0
		jmp	(Play_SFX).l
; End of function Sonic_Water

; ---------------------------------------------------------------------------
; ---------------------------------------------------------------------------
; Start of subroutine Obj01_MdNormal
; Called if Sonic is neither airborne nor rolling this frame
; ---------------------------------------------------------------------------

Sonic_MdNormal:
		bsr.w	Sonic_Spindash
		bsr.w	Sonic_Jump
		bsr.w	Player_SlopeResist
		bsr.w	Sonic_Move
		bsr.w	Sonic_Roll
		bsr.w	Player_LevelBound
		jsr	(MoveSprite2).l
		bsr.w	Player_AnglePos
		bsr.w	Player_SlopeRepel
		tst.b	(Background_collision_flag).w
		beq.s	locret_1207C
		bsr.w	sub_10BA2
		tst.w	d1
		bmi.w	Kill_Character
		movem.l	a4-a6,-(sp)
		bsr.w	CheckLeftWallDist
		movem.l	(sp)+,a4-a6
		tst.w	d1
		bpl.s	locret_1207C
		sub.w	d1,x_pos(a0)

locret_1207C:
		rts
; ---------------------------------------------------------------------------
; Start of subroutine Sonic_MdAir
; Called if Sonic is airborne, but not in a ball (thus, probably not jumping)

Sonic_MdAir:
		bsr.w	Sonic_JumpHeight
		bsr.w	Sonic_ChgJumpDir
		bsr.w	Player_LevelBound
		jsr	(MoveSprite).l
		btst	#Status_Underwater,status(a0)	; is Sonic underwater?
		beq.s	+ ;loc_1209E			; if not, branch
		subi.w	#$28,y_vel(a0)			; reduce gravity by $28 ($38-$28=$10)

+ ;loc_1209E:
		bsr.w	Player_JumpAngle
		bsr.w	Sonic_DoLevelCollision
		rts
; ---------------------------------------------------------------------------
; Start of subroutine Sonic_MdRoll
; Called if Sonic is in a ball, but not airborne (thus, probably rolling)

Sonic_MdRoll:
		tst.b	spin_dash_flag(a0)
		bne.s	+ ;loc_120B2
		bsr.w	Sonic_Jump

+ ;loc_120B2:
		bsr.w	Player_RollRepel
		bsr.w	Sonic_RollSpeed
		bsr.w	Player_LevelBound
		jsr	(MoveSprite2).l
		bsr.w	Player_AnglePos
		bsr.w	Player_SlopeRepel
		tst.b	(Background_collision_flag).w
		beq.s	locret_120F0
		bsr.w	sub_10BA2
		tst.w	d1
		bmi.w	Kill_Character
		movem.l	a4-a6,-(sp)
		bsr.w	CheckLeftWallDist
		movem.l	(sp)+,a4-a6
		tst.w	d1
		bpl.s	locret_120F0
		sub.w	d1,x_pos(a0)

locret_120F0:
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
		jsr	(MoveSprite).l
		btst	#Status_Underwater,status(a0)	; is Sonic underwater?
		beq.s	+ ;loc_12112			; if not, branch
		subi.w	#$28,y_vel(a0)			; reduce gravity by $28 ($38-$28=$10)

+ ;loc_12112:
		bsr.w	Player_JumpAngle
		bsr.w	Sonic_DoLevelCollision
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
		bmi.w	loc_123D6		; if so, branch
		tst.w	move_lock(a0)
		bne.w	loc_1238C
		btst	#button_left,(Ctrl_1_held_logical).w	; is left being pressed?
		beq.s	+ ;Sonic_NotLeft			; if not, branch
		bsr.w	sub_12480

+ ;Sonic_NotLeft:
		btst	#button_right,(Ctrl_1_held_logical).w	; is right being pressed?
		beq.s	+ ;Sonic_NotRight				; if not, branch
		bsr.w	sub_1250C

+ ;Sonic_NotRight:
		move.b	angle(a0),d0
		addi.b	#$20,d0
		andi.b	#$C0,d0		; is Sonic on a slope?
		bne.w	loc_1238C	; if yes, branch
		tst.w	ground_vel(a0)	; is Sonic moving?
		bne.w	loc_1238C	; if yes, branch
		bclr	#Status_Push,status(a0)
		move.b	#5,anim(a0)	; use standing animation
		btst	#Status_OnObj,status(a0)
		beq.w	Sonic_Balance
		movea.w	interact(a0),a1	; load interacting object's RAM space
		tst.b	status(a1)	; is status bit 7 set? (unused?)
		bmi.w	loc_12338	; if so, branch

		; Calculations to determine where on the object Sonic is, and make him balance accordingly
		moveq	#0,d1			; Clear d1
		move.b	width_pixels(a1),d1	; Load interacting object's width into d1
		move.w	d1,d2			; Move to d2 for seperate calculations
		add.w	d2,d2			; Double object width, converting it to X pos' units of measurement
		subq.w	#2,d2			; Subtract 2: This is the margin for 'on edge'
		add.w	x_pos(a0),d1		; Add Sonic's X position to object width
		sub.w	x_pos(a1),d1		; Subtract object's X position from width+Sonic's X pos, giving you Sonic's distance from left edge of object
		tst.b	(Super_Sonic_Knux_flag).w	; is Sonic Super?
		bne.w	+ ;SuperSonic_Balance
		cmpi.w	#2,d1		; is Sonic within two units of object's left edge?
		blt.s	Sonic_BalanceOnObjLeft	; if so, branch
		cmp.w	d2,d1
		bge.s	Sonic_BalanceOnObjRight	; if Sonic is within two units of object's right edge, branch (Realistically, it checks this, and BEYOND the right edge of the object)
		bra.w	loc_12338	; if Sonic is more than 2 units from both edges, branch
; ---------------------------------------------------------------------------

+ ;SuperSonic_Balance:
		cmpi.w	#2,d1		; is Sonic within two units of object's left edge?
		blt.w	loc_1232A	; if so, branch
		cmp.w	d2,d1
		bge.w	loc_1231A	; if Sonic is within two units of object's right edge, branch (Realistically, it checks this, and BEYOND the right edge of the object)
		bra.w	loc_12338	; if Sonic is more than 2 units from both edges, branch
; ---------------------------------------------------------------------------
; balancing checks for when you're on the right edge of an object

Sonic_BalanceOnObjRight:
		btst	#Status_Facing,status(a0)	; is Sonic facing right?
		bne.s	+ ;loc_121E4			; if so, branch
		move.b	#6,anim(a0)	; Balance animation 1
		addq.w	#6,d2		; extend balance range
		cmp.w	d2,d1		; is Sonic within (two units before and) four units past the right edge?
		blt.w	loc_1238C	; if so, branch
		move.b	#$C,anim(a0)	; if REALLY close to the edge, use different animation (Balance animation 2)
		bra.w	loc_1238C

+ ;loc_121E4:
		; Somewhat dummied out/redundant code from Sonic 2
		; Originally, Sonic displayed different animations for each direction faced
		; But now, Sonic uses only the one set of animations no matter what, making the check pointless, and the code redundant
		bclr	#Status_Facing,status(a0)
		move.b	#6,anim(a0)	; Balance animation 1
		addq.w	#6,d2		; extend balance range
		cmp.w	d2,d1		; is Sonic within (two units before and) four units past the right edge?
		blt.w	loc_1238C	; if so, branch
		move.b	#$C,anim(a0)	; if REALLY close to the edge, use different animation (Balance animation 2)
		bra.w	loc_1238C
; ---------------------------------------------------------------------------

Sonic_BalanceOnObjLeft:
		btst	#Status_Facing,status(a0)	; is Sonic facing right?
		beq.s	+ ;loc_12222
		move.b	#6,anim(a0)	; Balance animation 1
		cmpi.w	#-4,d1		; is Sonic within (two units before and) four units past the left edge?
		bge.w	loc_1238C	; if so branch (instruction signed to match)
		move.b	#$C,anim(a0)	; if REALLY close to the edge, use different animation (Balance animation 2)
		bra.w	loc_1238C

+ ;loc_12222:
		; Somewhat dummied out/redundant code from Sonic 2
		; Originally, Sonic displayed different animations for each direction faced
		; But now, Sonic uses only the one set of animations no matter what, making the check pointless, and the code redundant
		bset	#Status_Facing,status(a0)	; is Sonic facing right?
		move.b	#6,anim(a0)	; Balance animation 1
		cmpi.w	#-4,d1		; is Sonic within (two units before and) four units past the left edge?
		bge.w	loc_1238C	; if so branch (instruction signed to match)
		move.b	#$C,anim(a0)	; if REALLY close to the edge, use different animation (Balance animation 2)
		bra.w	loc_1238C
; ---------------------------------------------------------------------------
; balancing checks for when you're on the edge of part of the level

Sonic_Balance:
		jsr	(ChkFloorEdge).l
		cmpi.w	#$C,d1
		blt.w	loc_12338
		tst.b	(Super_Sonic_Knux_flag).w	; is Sonic Super?
		bne.w	loc_12312			; if so, branch
		cmpi.b	#3,next_tilt(a0)
		bne.s	++ ;loc_122B4
		btst	#Status_Facing,status(a0)
		bne.s	+ ;loc_1228A
		move.b	#6,anim(a0)
		move.w	x_pos(a0),d3
		subq.w	#6,d3
		jsr	(ChkFloorEdge_Part2).l
		cmpi.w	#$C,d1
		blt.w	loc_1238C
		move.b	#$C,anim(a0)
		bra.w	loc_1238C
		; on right edge but facing left:

+ ;loc_1228A:
		; Somewhat dummied out/redundant code from Sonic 2
		; Originally, Sonic displayed different animations for each direction faced
		; But now, Sonic uses only the one set of animations no matter what, making the check pointless, and the code redundant
		bclr	#Status_Facing,status(a0)
		move.b	#6,anim(a0)
		move.w	x_pos(a0),d3
		subq.w	#6,d3
		jsr	(ChkFloorEdge_Part2).l
		cmpi.w	#$C,d1
		blt.w	loc_1238C
		move.b	#$C,anim(a0)
		bra.w	loc_1238C
; ---------------------------------------------------------------------------

+ ;loc_122B4:
		cmpi.b	#3,tilt(a0)
		bne.s	loc_12338
		btst	#Status_Facing,status(a0)
		beq.s	+ ;loc_122E8
		move.b	#6,anim(a0)
		move.w	x_pos(a0),d3
		addq.w	#6,d3
		jsr	(ChkFloorEdge_Part2).l
		cmpi.w	#$C,d1
		blt.w	loc_1238C
		move.b	#$C,anim(a0)
		bra.w	loc_1238C
; ---------------------------------------------------------------------------

+ ;loc_122E8:
		bset	#Status_Facing,status(a0)
		move.b	#6,anim(a0)
		move.w	x_pos(a0),d3
		addq.w	#6,d3
		jsr	(ChkFloorEdge_Part2).l
		cmpi.w	#$C,d1
		blt.w	loc_1238C
		move.b	#$C,anim(a0)
		bra.w	loc_1238C
; ---------------------------------------------------------------------------

loc_12312:
		cmpi.b	#3,next_tilt(a0)
		bne.s	+ ;loc_12322

loc_1231A:
		bclr	#Status_Facing,status(a0)
		bra.s	++ ;loc_12330
; ---------------------------------------------------------------------------

+ ;loc_12322:
		cmpi.b	#3,tilt(a0)
		bne.s	loc_12338

loc_1232A:
		bset	#Status_Facing,status(a0)

+ ;loc_12330:
		move.b	#6,anim(a0)
		bra.s	loc_1238C
; ---------------------------------------------------------------------------

loc_12338:
		btst	#button_up,(Ctrl_1_held_logical).w
		beq.s	+ ;loc_12362
		move.b	#7,anim(a0)
		addq.b	#1,scroll_delay_counter(a0)
		cmpi.b	#120,scroll_delay_counter(a0)
		blo.s	loc_12392
		move.b	#120,scroll_delay_counter(a0)
		cmpi.w	#$C8,(a5)
		beq.s	loc_1239E
		addq.w	#2,(a5)
		bra.s	loc_1239E
; ---------------------------------------------------------------------------

+ ;loc_12362:
		btst	#button_down,(Ctrl_1_held_logical).w
		beq.s	loc_1238C
		move.b	#8,anim(a0)
		addq.b	#1,scroll_delay_counter(a0)
		cmpi.b	#120,scroll_delay_counter(a0)
		bcs.s	loc_12392
		move.b	#120,scroll_delay_counter(a0)
		cmpi.w	#8,(a5)
		beq.s	loc_1239E
		subq.w	#2,(a5)
		bra.s	loc_1239E
; ---------------------------------------------------------------------------

loc_1238C:
		move.b	#0,scroll_delay_counter(a0)

loc_12392:
		cmpi.w	#$60,(a5)
		beq.s	loc_1239E
		bcc.s	+ ;loc_1239C
		addq.w	#4,(a5)

+ ;loc_1239C:
		subq.w	#2,(a5)

loc_1239E:
		tst.b	(Super_Sonic_Knux_flag).w
		beq.w	+ ;loc_123AA
		move.w	#$C,d5

+ ;loc_123AA:
		move.b	(Ctrl_1_held_logical).w,d0
		andi.b	#button_left_mask|button_right_mask,d0
		bne.s	loc_123D6
		move.w	ground_vel(a0),d0
		beq.s	loc_123D6
		bmi.s	++ ;loc_123CA
		sub.w	d5,d0
		bcc.s	+ ;loc_123C4
		move.w	#0,d0

+ ;loc_123C4:
		move.w	d0,ground_vel(a0)
		bra.s	loc_123D6
; ---------------------------------------------------------------------------

+ ;loc_123CA:
		add.w	d5,d0
		bcc.s	+ ;loc_123D2
		move.w	#0,d0

+ ;loc_123D2:
		move.w	d0,ground_vel(a0)

loc_123D6:
		move.b	angle(a0),d0
		jsr	(GetSineCosine).l
		muls.w	ground_vel(a0),d1
		asr.l	#8,d1
		move.w	d1,x_vel(a0)
		muls.w	ground_vel(a0),d0
		asr.l	#8,d0
		move.w	d0,y_vel(a0)

loc_123F4:
		btst	#6,object_control(a0)
		bne.w	locret_1247E
		move.b	angle(a0),d0
		addi.b	#$40,d0
		bmi.s	locret_1247E
		move.b	#$40,d1
		tst.w	ground_vel(a0)
		beq.s	locret_1247E
		bmi.s	+ ;loc_12416
		neg.w	d1

+ ;loc_12416:
		move.b	angle(a0),d0
		add.b	d1,d0
		move.w	d0,-(sp)
		bsr.w	sub_10980
		move.w	(sp)+,d0
		tst.w	d1
		bpl.s	locret_1247E
		asl.w	#8,d1
		addi.b	#$20,d0
		andi.b	#$C0,d0
		beq.s	+++ ;loc_1247A
		cmpi.b	#$40,d0
		beq.s	++ ;loc_12460
		cmpi.b	#$80,d0
		beq.s	+ ;loc_1245A
		add.w	d1,x_vel(a0)
		move.w	#0,ground_vel(a0)
		btst	#Status_Facing,status(a0)
		bne.s	locret_12458
		bset	#Status_Push,status(a0)

locret_12458:
		rts
; ---------------------------------------------------------------------------

+ ;loc_1245A:
		sub.w	d1,y_vel(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_12460:
		sub.w	d1,x_vel(a0)
		move.w	#0,ground_vel(a0)
		btst	#Status_Facing,status(a0)
		beq.s	locret_12458
		bset	#Status_Push,status(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_1247A:
		add.w	d1,y_vel(a0)

locret_1247E:
		rts
; End of function Sonic_Move


; =============== S U B R O U T I N E =======================================


sub_12480:
		move.w	ground_vel(a0),d0
		beq.s	+ ;loc_12488
		bpl.s	loc_124BA

+ ;loc_12488:
		bset	#Status_Facing,status(a0)
		bne.s	+ ;loc_1249C
		bclr	#Status_Push,status(a0)
		move.b	#1,prev_anim(a0)

+ ;loc_1249C:
		sub.w	d5,d0
		move.w	d6,d1
		neg.w	d1
		cmp.w	d1,d0
		bgt.s	+ ;loc_124AE
		add.w	d5,d0
		cmp.w	d1,d0
		ble.s	+ ;loc_124AE
		move.w	d1,d0

+ ;loc_124AE:
		move.w	d0,ground_vel(a0)
		move.b	#0,anim(a0)
		rts
; ---------------------------------------------------------------------------

loc_124BA:
		sub.w	d4,d0
		bcc.s	+ ;loc_124C2
		move.w	#-$80,d0

+ ;loc_124C2:
		move.w	d0,ground_vel(a0)
		move.b	angle(a0),d0
		addi.b	#$20,d0
		andi.b	#$C0,d0
		bne.s	locret_1250A
		cmpi.w	#$400,d0
		blt.s	locret_1250A
		tst.b	flip_type(a0)
		bmi.s	locret_1250A
		move.w	#sfx_Skid,d0
		jsr	(Play_SFX).l
		move.b	#$D,anim(a0)
		bclr	#Status_Facing,status(a0)
		cmpi.b	#12,air_left(a0)
		blo.s	locret_1250A
		move.b	#6,routine(a6)
		move.b	#$15,mapping_frame(a6)

locret_1250A:
		rts
; End of function sub_12480


; =============== S U B R O U T I N E =======================================


sub_1250C:
		move.w	ground_vel(a0),d0
		bmi.s	+++ ;loc_12540
		bclr	#Status_Facing,status(a0)
		beq.s	+ ;loc_12526
		bclr	#Status_Push,status(a0)
		move.b	#1,prev_anim(a0)

+ ;loc_12526:
		add.w	d5,d0
		cmp.w	d6,d0
		blt.s	+ ;loc_12534
		sub.w	d5,d0
		cmp.w	d6,d0
		bge.s	+ ;loc_12534
		move.w	d6,d0

+ ;loc_12534:
		move.w	d0,ground_vel(a0)
		move.b	#0,anim(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_12540:
		add.w	d4,d0
		bcc.s	+ ;loc_12548
		move.w	#$80,d0

+ ;loc_12548:
		move.w	d0,ground_vel(a0)
		move.b	angle(a0),d0
		addi.b	#$20,d0
		andi.b	#$C0,d0
		bne.s	locret_12590
		cmpi.w	#-$400,d0
		bgt.s	locret_12590
		tst.b	flip_type(a0)
		bmi.s	locret_12590
		move.w	#sfx_Skid,d0
		jsr	(Play_SFX).l
		move.b	#$D,anim(a0)
		bset	#Status_Facing,status(a0)
		cmpi.b	#12,air_left(a0)
		blo.s	locret_12590
		move.b	#6,routine(a6)
		move.b	#$15,mapping_frame(a6)

locret_12590:
		rts
; End of function sub_1250C


; =============== S U B R O U T I N E =======================================


Sonic_RollSpeed:
		move.w	Max_speed-Max_speed(a4),d6
		asl.w	#1,d6
		move.w	Acceleration-Max_speed(a4),d5
		asr.w	#1,d5
		move.w	#$20,d4
		tst.b	spin_dash_flag(a0)
		bmi.w	loc_12636
		tst.b	status_secondary(a0)
		bmi.w	loc_12636
		tst.w	move_lock(a0)
		bne.s	++ ;loc_125CE
		btst	#button_left,(Ctrl_1_held_logical).w
		beq.s	+ ;loc_125C2
		bsr.w	sub_12678

+ ;loc_125C2:
		btst	#button_right,(Ctrl_1_held_logical).w
		beq.s	+ ;loc_125CE
		bsr.w	sub_1269C

+ ;loc_125CE:
		move.w	ground_vel(a0),d0
		beq.s	loc_125F0
		bmi.s	++ ;loc_125E4
		sub.w	d5,d0
		bcc.s	+ ;loc_125DE
		move.w	#0,d0

+ ;loc_125DE:
		move.w	d0,ground_vel(a0)
		bra.s	loc_125F0
; ---------------------------------------------------------------------------

+ ;loc_125E4:
		add.w	d5,d0
		bcc.s	+ ;loc_125EC
		move.w	#0,d0

+ ;loc_125EC:
		move.w	d0,ground_vel(a0)

loc_125F0:
		tst.w	ground_vel(a0)
		bne.s	loc_12636
		tst.b	spin_dash_flag(a0)
		bne.s	+ ;loc_12624
		bclr	#2,status(a0)
		move.b	y_radius(a0),d0
		move.b	default_y_radius(a0),y_radius(a0)
		move.b	default_x_radius(a0),x_radius(a0)
		move.b	#5,anim(a0)
		sub.b	default_y_radius(a0),d0
		ext.w	d0
		add.w	d0,y_pos(a0)
		bra.s	loc_12636
; ---------------------------------------------------------------------------

+ ;loc_12624:
		move.w	#$400,ground_vel(a0)
		btst	#Status_Facing,status(a0)
		beq.s	loc_12636
		neg.w	ground_vel(a0)

loc_12636:
		cmpi.w	#$60,(a5)
		beq.s	++ ;loc_12642
		bcc.s	+ ;loc_12640
		addq.w	#4,(a5)

+ ;loc_12640:
		subq.w	#2,(a5)

+ ;loc_12642:
		move.b	angle(a0),d0
		jsr	(GetSineCosine).l
		muls.w	ground_vel(a0),d0
		asr.l	#8,d0
		move.w	d0,y_vel(a0)
		muls.w	ground_vel(a0),d1
		asr.l	#8,d1
		cmpi.w	#$1000,d1
		ble.s	+ ;loc_12666
		move.w	#$1000,d1

+ ;loc_12666:
		cmpi.w	#-$1000,d1
		bge.s	+ ;loc_12670
		move.w	#-$1000,d1

+ ;loc_12670:
		move.w	d1,x_vel(a0)
		bra.w	loc_123F4
; End of function Sonic_RollSpeed


; =============== S U B R O U T I N E =======================================


sub_12678:
		move.w	ground_vel(a0),d0
		beq.s	+ ;loc_12680
		bpl.s	++ ;loc_1268E

+ ;loc_12680:
		bset	#Status_Facing,status(a0)
		move.b	#2,anim(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_1268E:
		sub.w	d4,d0
		bcc.s	+ ;loc_12696
		move.w	#-$80,d0

+ ;loc_12696:
		move.w	d0,ground_vel(a0)
		rts
; End of function sub_12678


; =============== S U B R O U T I N E =======================================


sub_1269C:
		move.w	ground_vel(a0),d0
		bmi.s	+ ;loc_126B0
		bclr	#Status_Facing,status(a0)
		move.b	#2,anim(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_126B0:
		add.w	d4,d0
		bcc.s	+ ;loc_126B8
		move.w	#$80,d0

+ ;loc_126B8:
		move.w	d0,ground_vel(a0)
		rts
; End of function sub_1269C

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
		beq.s	+ ;loc_126F2	; if not holding left, branch

		bset	#Status_Facing,status(a0)
		sub.w	d5,d0	; add acceleration to the left
		move.w	d6,d1
		neg.w	d1
		cmp.w	d1,d0	; compare new speed with top speed
		bgt.s	+ ;loc_126F2	; if new speed is less than the maximum, branch
		add.w	d5,d0		; remove this frame's acceleration change
		cmp.w	d1,d0		; compare speed with top speed
		ble.s	+ ;loc_126F2	; if speed was already greater than the maximum, branch
		move.w	d1,d0

+ ;loc_126F2:
		btst	#button_right,(Ctrl_1_held_logical).w
		beq.s	+ ;loc_1270E	; if not holding right, branch

		bclr	#Status_Facing,status(a0)
		add.w	d5,d0	; accelerate right in the air
		cmp.w	d6,d0	; compare new speed with top speed
		blt.s	+ ;loc_1270E	; if new speed is less than the maximum, branch
		sub.w	d5,d0		; remove this frame's acceleration change
		cmp.w	d6,d0		; compare speed with top speed
		bge.s	+ ;loc_1270E	; if speed was already greater than the maximum, branch
		move.w	d6,d0

+ ;loc_1270E:
		move.w	d0,x_vel(a0)

Sonic_Jump_ResetScr:
		cmpi.w	#$60,(a5)	; is screen in its default position?
		beq.s	Sonic_JumpPeakDecelerate	; if yes, branch
		bhs.s	+ ;loc_1271C	; depending on the sign of the difference,
		addq.w	#4,(a5)		; either add 2

+ ;loc_1271C:
		subq.w	#2,(a5)		; or subtract 2

Sonic_JumpPeakDecelerate:
		cmpi.w	#-$400,y_vel(a0)	; is Sonic moving faster than -$400 upwards?
		blo.s	locret_1274C		; if yes, return
		move.w	x_vel(a0),d0
		move.w	d0,d1
		asr.w	#5,d1		; d1 = x_velocity / 32
		beq.s	locret_1274C	; return if d1 is 0
		bmi.s	Sonic_JumpPeakDecelerateLeft	; branch if moving left

		sub.w	d1,d0	; reduce x velocity by d1
		bcc.s	+ ;loc_1273A
		move.w	#0,d0

+ ;loc_1273A:
		move.w	d0,x_vel(a0)
		rts
; ---------------------------------------------------------------------------

Sonic_JumpPeakDecelerateLeft:
		sub.w	d1,d0	; reduce x velocity by d1
		bcs.s	+ ;loc_12748
		move.w	#0,d0

+ ;loc_12748:
		move.w	d0,x_vel(a0)

locret_1274C:
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
		bls.s	Player_Boundary_Sides

Player_Boundary_CheckBottom:
		tst.b	(Disable_death_plane).w
		bne.s	locret_1278A
		move.w	(Camera_max_Y_pos).w,d0
		addi.w	#$E0,d0
		cmp.w	y_pos(a0),d0		; has Sonic touched the bottom boundary?
		blt.s	Player_Boundary_Bottom	; if yes, branch

locret_1278A:
		rts
; ---------------------------------------------------------------------------

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


Sonic_Roll:
		tst.b	status_secondary(a0)
		bmi.s	locret_127D0
		move.w	ground_vel(a0),d0
		bpl.s	+ ;loc_127B8
		neg.w	d0

+ ;loc_127B8:
		cmpi.w	#$80,d0		; is Sonic moving at $80 speed or faster?
		blo.s	locret_127D0		; if so, branch
		move.b	(Ctrl_1_held_logical).w,d0
		andi.b	#button_left_mask|button_right_mask,d0	; is left/right being pressed?
		bne.s	locret_127D0	; if yes, branch
		btst	#button_down,(Ctrl_1_held_logical).w	; is down being pressed?
		bne.s	+ ;Player_ChkRoll			; if not, branch

locret_127D0:
		rts
; ---------------------------------------------------------------------------

+ ;Player_ChkRoll:
		btst	#Status_Roll,status(a0)	; is Sonic already rolling?
		beq.s	+ ;Player_DoRoll	; if not, branch
		rts
; ---------------------------------------------------------------------------

+ ;Player_DoRoll:
		bset	#Status_Roll,status(a0)
		move.b	#$E,y_radius(a0)
		move.b	#7,x_radius(a0)
		move.b	#2,anim(a0)	; enter roll animation
		addq.w	#5,y_pos(a0)
		move.w	#sfx_Roll,d0
		jsr	(Play_SFX).l
		tst.w	ground_vel(a0)
		bne.s	locret_1280E
		move.w	#$200,ground_vel(a0)

locret_1280E:
		rts
; End of function Sonic_Roll


; ---------------------------------------------------------------------------
; Subroutine allowing Sonic to jump
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Sonic_Jump:
		move.b	(Ctrl_1_pressed_logical).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0	; is A, B or C pressed?
		beq.w	locret_128D0	; if not, return
		moveq	#0,d0
		move.b	angle(a0),d0
		addi.b	#$80,d0
		movem.l	a4-a6,-(sp)
		bsr.w	CalcRoomOverHead
		movem.l	(sp)+,a4-a6
		cmpi.w	#6,d1			; does Sonic have enough room to jump?
		blt.w	locret_128D0		; if not, branch
		move.w	#$680,d2
		tst.b	(Super_Sonic_Knux_flag).w
		beq.s	+ ;loc_12848
		move.w	#$800,d2	; set higher jump speed if super

+ ;loc_12848:
		btst	#Status_Underwater,status(a0)	; Test if underwater
		beq.s	+ ;loc_12854
		move.w	#$380,d2	; set lower jump speed if under

+ ;loc_12854:
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
		bne.s	+ ;Sonic_RollJump
		move.b	#$E,y_radius(a0)
		move.b	#7,x_radius(a0)
		move.b	#2,anim(a0)	; use "jumping" animation
		bset	#Status_Roll,status(a0)
		move.b	y_radius(a0),d0
		sub.b	default_y_radius(a0),d0
		ext.w	d0
		sub.w	d0,y_pos(a0)

locret_128D0:
		rts
; ---------------------------------------------------------------------------

+ ;Sonic_RollJump:
		bset	#Status_RollJump,status(a0)	; set the rolling+jumping flag
		rts
; End of function Sonic_Jump


; =============== S U B R O U T I N E =======================================

Sonic_JumpHeight:
		tst.b	jumping(a0)	; is Sonic jumping?
		beq.s	++ ;Sonic_UpVelCap	; if not, branch

		move.w	#-$400,d1
		btst	#Status_Underwater,status(a0)	; is Sonic underwater?
		beq.s	+ ;loc_128F0			; if not, branch
		move.w	#-$200,d1			; Underwater-specific

+ ;loc_128F0:
		cmp.w	y_vel(a0),d1		; is y speed greater than 4? (2 if underwater)
		ble.w	++ ;Sonic_ShieldMoves	; if not, branch
		move.b	(Ctrl_1_held_logical).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0	; are buttons A, B or C being pressed?
		bne.s	locret_12906		; if yes, branch
		move.w	d1,y_vel(a0)		; cap jump height

locret_12906:
		rts
; ---------------------------------------------------------------------------

+ ;Sonic_UpVelCap:
		tst.b	spin_dash_flag(a0)	; is Sonic charging his spin dash?
		bne.s	locret_1291C		; if yes, branch
		cmpi.w	#-$FC0,y_vel(a0)	; is Sonic's Y speed faster (less than) than -15.75 (-$FC0)?
		bge.s	locret_1291C		; if not, branch
		move.w	#-$FC0,y_vel(a0)	; cap upward speed

locret_1291C:
		rts
; ---------------------------------------------------------------------------

+ ;Sonic_ShieldMoves:
		tst.b	double_jump_flag(a0)		; is Sonic currently performing a double jump?
		bne.w	locret_12A20			; if yes, branch
		move.b	(Ctrl_1_pressed_logical).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0	; are buttons A, B, or C being pressed?
		beq.w	locret_12A20			; if not, branch
		bclr	#Status_RollJump,status(a0)
		tst.b	(Super_Sonic_Knux_flag).w	; check Super-state
		beq.s	+ ;Sonic_FireShield		; if not in a super-state, branch
		move.b	#1,double_jump_flag(a0)
		rts
; ---------------------------------------------------------------------------

+ ;Sonic_FireShield:
		btst	#Status_Invincible,status_secondary(a0)	; first, does Sonic have invincibility?
		bne.w	locret_12A20				; if yes, branch
		btst	#Status_FireShield,status_secondary(a0)	; does Sonic have a Fire Shield?
		beq.s	++ ;Sonic_LightningShield			; if not, branch
		move.b	#1,(Shield+anim).w
		move.b	#1,double_jump_flag(a0)
		move.w	#$800,d0
		btst	#Status_Facing,status(a0)		; is Sonic facing left?
		beq.s	+ ;loc_12972				; if not, branch
		neg.w	d0					; reverse speed value, moving Sonic left

+ ;loc_12972:
		move.w	d0,x_vel(a0)		; apply velocity...
		move.w	d0,ground_vel(a0)	; ...both ground and air
		move.w	#0,y_vel(a0)		; kill y-velocity
		move.w	#$2000,(H_scroll_frame_offset).w
		bsr.w	Reset_Player_Position_Array
		move.w	#sfx_FireAttack,d0
		jmp	(Play_SFX).l
; ---------------------------------------------------------------------------

+ ;Sonic_LightningShield:
		btst	#Status_LtngShield,status_secondary(a0)	; does Sonic have a Lightning Shield?
		beq.s	+ ;Sonic_BubbleShield			; if not, branch
		move.b	#1,(Shield+anim).w
		move.b	#1,double_jump_flag(a0)
		move.w	#-$580,y_vel(a0)	; bounce Sonic up, creating the double jump effect
		clr.b	jumping(a0)
		move.w	#sfx_ElectricAttack,d0
		jmp	(Play_SFX).l
; ---------------------------------------------------------------------------

+ ;Sonic_BubbleShield:
		btst	#Status_BublShield,status_secondary(a0)	; does Sonic have a Bubble Shield?
		beq.s	+ ;Sonic_CheckTransform			; if not, branch
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

+ ;Sonic_CheckTransform:
		cmpi.w	#7,(Chaos_emerald_count).w	; does Sonic have all 7 Chaos Emeralds?
		blo.s	+ ;Sonic_InstaShield		; if not, branch
		cmpi.w	#50,(Ring_count).w	; does Sonic have at least 50 rings?
		blo.s	+ ;Sonic_InstaShield	; if not, perform Insta-Shield
		tst.b	(Update_HUD_timer).w
		bne.s	++ ;Sonic_Transform

+ ;Sonic_InstaShield:
		btst	#Status_Shield,status_secondary(a0)	; does Sonic have an S2 shield? (the elementals were already filtered out at this point)
		bne.s	locret_12A20				; if yes, branch
		move.b	#1,(Shield+anim).w
		move.b	#1,double_jump_flag(a0)
		move.w	#sfx_InstaAttack,d0
		jmp	(Play_SFX).l
; ---------------------------------------------------------------------------

locret_12A20:
		rts
; ---------------------------------------------------------------------------

+ ;Sonic_Transform:
		move.b	#1,(Super_palette_status).w	; set Super palette status to 'fading'
		move.b	#$F,(Palette_timer).w
		move.b	#1,(Super_Sonic_Knux_flag).w		; set flag to Super Sonic
		move.w	#60,(Super_frame_count).w
		move.l	#Map_SuperSonic,mappings(a0)
		move.b	#$81,object_control(a0)
		move.b	#$1F,anim(a0)				; enter 'transformation' animation
		move.l	#Obj_SuperSonic_Stars,(Super_stars).w	; load Super Stars object
		move.w	#$A00,Max_speed-Max_speed(a4)
		move.w	#$30,Acceleration-Max_speed(a4)
		move.w	#$100,Deceleration-Max_speed(a4)
		move.b	#0,invincibility_timer(a0)
		bset	#Status_Invincible,status_secondary(a0)
		move.w	#signextendB(sfx_SuperTransform),d0
		jsr	(Play_SFX).l
		move.w	#signextendB(mus_Invincibility),d0		; play invincibility theme
		jmp	(Play_Music).l
; End of function Sonic_JumpHeight


; =============== S U B R O U T I N E =======================================


Sonic_Super:
		tst.b	(Super_Sonic_Knux_flag).w
		beq.w	.return		; If not Super, return
		tst.b	(Update_HUD_timer).w	; Level over?
		beq.s	+++ ;.revertToNormal
		subq.w	#1,(Super_frame_count).w
		bpl.w	.return			; This should be a 'bhi'; currently counts down 61 frames
		move.w	#60,(Super_frame_count).w
		tst.w	(Ring_count).w
		beq.s	+++ ;.revertToNormal	; If rings depleted, return to normal
		; This checks if the ring counter needs to be blanked
		; for example, this ticks '10' down to ' 9' instead of '19' (yes, this does happen)
		ori.b	#1,(Update_HUD_ring_count).w	; Update ring counter
		cmpi.w	#1,(Ring_count).w
		beq.s	+ ;.resetHUD
		cmpi.w	#10,(Ring_count).w
		beq.s	+ ;.resetHUD
		cmpi.w	#100,(Ring_count).w
		bne.s	++ ;.updateHUD

+ ;	.resetHUD:
		ori.b	#$80,(Update_HUD_ring_count).w	; Re-init ring counter

+ ;	.updateHUD:
		subq.w	#1,(Ring_count).w
		bne.s	.return	; If rings aren't depleted, we're done here
		; If rings depleted, return to normal

+ ;	.revertToNormal:
		move.b	#2,(Super_palette_status).w
		move.w	#$1E,(Palette_frame).w
		move.b	#0,(Super_Sonic_Knux_flag).w
		move.b	#-1,(Player_prev_frame).w
		move.l	#Map_Sonic,mappings(a0)	; load Sonic's normal mappings (was using Super mappings)
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
; End of function Sonic_Super


; =============== S U B R O U T I N E =======================================


Sonic_Spindash:
		tst.b	spin_dash_flag(a0)
		bne.s	++ ;loc_12B9C
		cmpi.b	#8,anim(a0)
		bne.s	locret_12B9A
		move.b	(Ctrl_1_pressed_logical).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0
		beq.w	locret_12B9A
		move.b	#9,anim(a0)
		move.w	#signextendB(sfx_Spindash),d0
		jsr	(Play_SFX).l
		addq.l	#4,sp
		move.b	#1,spin_dash_flag(a0)
		move.w	#0,spin_dash_counter(a0)
		cmpi.b	#12,air_left(a0)
		blo.s	+ ;loc_12B6E
		move.b	#2,anim(a6)

+ ;loc_12B6E:
		bsr.w	Player_LevelBound
		bsr.w	Player_AnglePos
		tst.b	(Background_collision_flag).w
		beq.s	locret_12B9A
		bsr.w	sub_10BA2
		tst.w	d1
		bmi.w	Kill_Character
		movem.l	a4-a6,-(sp)
		bsr.w	CheckLeftWallDist
		movem.l	(sp)+,a4-a6
		tst.w	d1
		bpl.s	locret_12B9A
		sub.w	d1,x_pos(a0)

locret_12B9A:
		rts
; ---------------------------------------------------------------------------

+ ;loc_12B9C:
		move.b	(Ctrl_1_held_logical).w,d0
		btst	#button_down,d0
		bne.w	loc_12C48
		move.b	#$E,y_radius(a0)
		move.b	#7,x_radius(a0)
		move.b	#2,anim(a0)
		addq.w	#5,y_pos(a0)
		move.b	#0,spin_dash_flag(a0)
		moveq	#0,d0
		move.b	spin_dash_counter(a0),d0
		add.w	d0,d0
		move.w	word_12C24(pc,d0.w),ground_vel(a0)
		tst.b	(Super_Sonic_Knux_flag).w
		beq.s	+ ;loc_12BDE
		move.w	word_12C36(pc,d0.w),ground_vel(a0)

+ ;loc_12BDE:
		move.w	ground_vel(a0),d0
		subi.w	#$800,d0
		add.w	d0,d0
		andi.w	#$1F00,d0
		neg.w	d0
		addi.w	#$2000,d0
		lea	(H_scroll_frame_offset).w,a1
		cmpa.w	#Player_1,a0
		beq.s	+ ;loc_12C00
		lea	(H_scroll_frame_offset_P2).w,a1

+ ;loc_12C00:
		move.w	d0,(a1)
		btst	#Status_Facing,status(a0)
		beq.s	+ ;loc_12C0E
		neg.w	ground_vel(a0)

+ ;loc_12C0E:
		bset	#Status_Roll,status(a0)
		move.b	#0,anim(a6)
		moveq	#signextendB(sfx_Dash),d0
		jsr	(Play_SFX).l
		bra.s	++ ;loc_12C90
; ---------------------------------------------------------------------------
word_12C24:
		dc.w   $800
		dc.w   $880
		dc.w   $900
		dc.w   $980
		dc.w   $A00
		dc.w   $A80
		dc.w   $B00
		dc.w   $B80
		dc.w   $C00
word_12C36:
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

loc_12C48:
		tst.w	spin_dash_counter(a0)
		beq.s	+ ;loc_12C60
		move.w	spin_dash_counter(a0),d0
		lsr.w	#5,d0
		sub.w	d0,spin_dash_counter(a0)
		bcc.s	+ ;loc_12C60
		move.w	#0,spin_dash_counter(a0)

+ ;loc_12C60:
		move.b	(Ctrl_1_pressed_logical).w,d0
		andi.b	#button_A_mask|button_B_mask|button_C_mask,d0
		beq.w	+ ;loc_12C90
		move.w	#9<<8,anim(a0)	; and prev_anim
		move.w	#signextendB(sfx_Spindash),d0
		jsr	(Play_SFX).l
		addi.w	#$200,spin_dash_counter(a0)
		cmpi.w	#$800,spin_dash_counter(a0)
		blo.s	+ ;loc_12C90
		move.w	#$800,spin_dash_counter(a0)

+ ;loc_12C90:
		addq.l	#4,sp
		cmpi.w	#$60,(a5)
		beq.s	++ ;loc_12C9E
		bcc.s	+ ;loc_12C9C
		addq.w	#4,(a5)

+ ;loc_12C9C:
		subq.w	#2,(a5)

+ ;loc_12C9E:
		bsr.w	Player_LevelBound
		bsr.w	Player_AnglePos
		tst.b	(Background_collision_flag).w
		beq.s	locret_12CCA
		bsr.w	sub_10BA2
		tst.w	d1
		bmi.w	Kill_Character
		movem.l	a4-a6,-(sp)
		bsr.w	CheckLeftWallDist
		movem.l	(sp)+,a4-a6
		tst.w	d1
		bpl.s	locret_12CCA
		sub.w	d1,x_pos(a0)

locret_12CCA:
		rts
; End of function Sonic_Spindash


; ---------------------------------------------------------------------------
; Subroutine to slow Sonic walking up a slope
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Player_SlopeResist:
		move.b	angle(a0),d0
		addi.b	#$60,d0
		cmpi.b	#-$40,d0
		bhs.s	locret_12D00
		move.b	angle(a0),d0
		jsr	(GetSineCosine).l
		muls.w	#$20,d0
		asr.l	#8,d0
		tst.w	ground_vel(a0)
		beq.s	++ ;loc_12D02
		bmi.s	+ ;loc_12CFC
		tst.w	d0
		beq.s	locret_12CFA
		add.w	d0,ground_vel(a0)

locret_12CFA:
		rts
; ---------------------------------------------------------------------------

+ ;loc_12CFC:
		add.w	d0,ground_vel(a0)

locret_12D00:
		rts
; ---------------------------------------------------------------------------

+ ;loc_12D02:
		move.w	d0,d1
		bpl.s	+ ;loc_12D08
		neg.w	d1

+ ;loc_12D08:
		cmpi.w	#$D,d1
		blo.s	locret_12D00
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
		bhs.s	locret_12D4E
		move.b	angle(a0),d0
		jsr	(GetSineCosine).l
		muls.w	#$50,d0
		asr.l	#8,d0
		tst.w	ground_vel(a0)
		bmi.s	++ ;loc_12D44
		tst.w	d0
		bpl.s	+ ;loc_12D3E
		asr.l	#2,d0

+ ;loc_12D3E:
		add.w	d0,ground_vel(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_12D44:
		tst.w	d0
		bmi.s	+ ;loc_12D4A
		asr.l	#2,d0

+ ;loc_12D4A:
		add.w	d0,ground_vel(a0)

locret_12D4E:
		rts
; End of function Player_RollRepel


; ---------------------------------------------------------------------------
; Subroutine to push Sonic down a slope
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Player_SlopeRepel:
		nop
		tst.b	stick_to_convex(a0)
		bne.s	locret_12D94
		tst.w	move_lock(a0)
		bne.s	loc_12DAC
		move.b	angle(a0),d0
		addi.b	#$18,d0
		cmpi.b	#$30,d0
		blo.s	locret_12D94
		move.w	ground_vel(a0),d0
		bpl.s	+ ;loc_12D74
		neg.w	d0

+ ;loc_12D74:
		cmpi.w	#$280,d0
		bhs.s	locret_12D94
		move.w	#30,move_lock(a0)
		move.b	angle(a0),d0
		addi.b	#$30,d0
		cmpi.b	#$60,d0
		blo.s	+ ;loc_12D96
		bset	#Status_InAir,status(a0)

locret_12D94:
		rts
; ---------------------------------------------------------------------------

+ ;loc_12D96:
		cmpi.b	#$30,d0
		blo.s	+ ;loc_12DA4
		addi.w	#$80,ground_vel(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_12DA4:
		subi.w	#$80,ground_vel(a0)
		rts
; ---------------------------------------------------------------------------

loc_12DAC:
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
		bpl.s	++ ;loc_12DC2	; if higher than 0, branch

		addq.b	#2,d0		; increase angle
		bcc.s	+ ;loc_12DC0
		moveq	#0,d0

+ ;loc_12DC0:
		bra.s	Player_JumpAngleSet
; ---------------------------------------------------------------------------

+ ;loc_12DC2:
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
		beq.s	locret_12E10
		tst.w	ground_vel(a0)
		bmi.s	Player_JumpLeftFlip

Player_JumpRightFlip:
		move.b	flip_speed(a0),d1
		add.b	d1,d0
		bcc.s	+ ;loc_12DEE
		subq.b	#1,flips_remaining(a0)
		bcc.s	+ ;loc_12DEE
		move.b	#0,flips_remaining(a0)
		moveq	#0,d0

+ ;loc_12DEE:
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

locret_12E10:
		rts
; End of function Player_JumpAngle


; ---------------------------------------------------------------------------
; Subroutine for Sonic to interact with the floor and walls when he's in the air
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Sonic_DoLevelCollision:
		move.l	(Primary_collision_addr).w,(Collision_addr).w
		cmpi.b	#$C,top_solid_bit(a0)
		beq.s	+ ;loc_12E26
		move.l	(Secondary_collision_addr).w,(Collision_addr).w

+ ;loc_12E26:
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
		beq.w	loc_12FCC
		bsr.w	CheckLeftWallDist
		tst.w	d1
		bpl.s	+ ;loc_12E6A
		sub.w	d1,x_pos(a0)
		move.w	#0,x_vel(a0)	; stop Sonic since he hit a wall

+ ;loc_12E6A:
		bsr.w	CheckRightWallDist
		tst.w	d1
		bpl.s	+ ;loc_12E7C
		add.w	d1,x_pos(a0)
		move.w	#0,x_vel(a0)	; stop Sonic since he hit a wall

+ ;loc_12E7C:
		bsr.w	Sonic_CheckFloor
		tst.w	d1
		bpl.s	locret_12EF2
		move.b	y_vel(a0),d2
		addq.b	#8,d2
		neg.b	d2
		cmp.b	d2,d1
		bge.s	+ ;loc_12E94
		cmp.b	d2,d0
		blt.s	locret_12EF2

+ ;loc_12E94:
		add.w	d1,y_pos(a0)
		move.b	d3,angle(a0)
		move.b	d3,d0
		addi.b	#$20,d0
		andi.b	#$40,d0
		bne.s	++ ;loc_12ECC
		move.b	d3,d0
		addi.b	#$10,d0
		andi.b	#$20,d0
		beq.s	+ ;loc_12EBA
		asr	y_vel(a0)
		bra.s	+++ ;loc_12EE0
; ---------------------------------------------------------------------------

+ ;loc_12EBA:
		move.w	#0,y_vel(a0)
		move.w	x_vel(a0),ground_vel(a0)
		bsr.w	Player_TouchFloor_Check_Spindash
		rts
; ---------------------------------------------------------------------------

+ ;loc_12ECC:
		move.w	#0,x_vel(a0)	; stop Sonic since he hit a wall
		cmpi.w	#$FC0,y_vel(a0)
		ble.s	+ ;loc_12EE0
		move.w	#$FC0,y_vel(a0)

+ ;loc_12EE0:
		bsr.w	Player_TouchFloor_Check_Spindash
		move.w	y_vel(a0),ground_vel(a0)
		tst.b	d3
		bpl.s	locret_12EF2
		neg.w	ground_vel(a0)

locret_12EF2:
		rts
; ---------------------------------------------------------------------------

Player_HitLeftWall:
		bsr.w	CheckLeftWallDist
		tst.w	d1
		bpl.s	+ ;Player_HitCeiling	; branch if distance is positive (not inside wall)
		sub.w	d1,x_pos(a0)
		move.w	#0,x_vel(a0)	; stop Sonic since he hit a wall
		move.w	y_vel(a0),ground_vel(a0)

+ ;Player_HitCeiling:
		bsr.w	Sonic_CheckCeiling
		tst.w	d1
		bpl.s	++ ;loc_12F42	; branch if distance is positive (not inside ceiling)
		neg.w	d1
		cmpi.w	#$14,d1
		bhs.s	+ ;loc_12F2E
		add.w	d1,y_pos(a0)
		tst.w	y_vel(a0)
		bpl.s	locret_12F2C
		move.w	#0,y_vel(a0)	; stop Sonic in y since he hit a ceiling

locret_12F2C:
		rts
; ---------------------------------------------------------------------------

+ ;loc_12F2E:
		bsr.w	CheckRightWallDist
		tst.w	d1
		bpl.s	locret_12F40
		add.w	d1,x_pos(a0)
		move.w	#0,x_vel(a0)

locret_12F40:
		rts
; ---------------------------------------------------------------------------

+ ;loc_12F42:
		tst.b	(WindTunnel_flag).w
		bne.s	loc_12F4E
		tst.w	y_vel(a0)
		bmi.s	locret_12F6E

loc_12F4E:
		bsr.w	Sonic_CheckFloor
		tst.w	d1
		bpl.s	locret_12F6E
		add.w	d1,y_pos(a0)
		move.b	d3,angle(a0)
		move.w	#0,y_vel(a0)
		move.w	x_vel(a0),ground_vel(a0)
		bsr.w	Player_TouchFloor_Check_Spindash

locret_12F6E:
		rts
; ---------------------------------------------------------------------------

Player_HitCeilingAndWalls:
		bsr.w	CheckLeftWallDist
		tst.w	d1
		bpl.s	+ ;loc_12F82
		sub.w	d1,x_pos(a0)
		move.w	#0,x_vel(a0)	; stop Sonic since he hit a wall

+ ;loc_12F82:
		bsr.w	CheckRightWallDist
		tst.w	d1
		bpl.s	+ ;loc_12F94
		add.w	d1,x_pos(a0)
		move.w	#0,x_vel(a0)	; stop Sonic since he hit a wall

+ ;loc_12F94:
		bsr.w	Sonic_CheckCeiling
		tst.w	d1
		bpl.s	locret_12FCA
		sub.w	d1,y_pos(a0)
		move.b	d3,d0
		addi.b	#$20,d0
		andi.b	#$40,d0
		bne.s	+ ;loc_12FB4
		move.w	#0,y_vel(a0)	; stop Sonic in y since he hit a ceiling
		rts
; ---------------------------------------------------------------------------

+ ;loc_12FB4:
		move.b	d3,angle(a0)
		bsr.w	Player_TouchFloor_Check_Spindash
		move.w	y_vel(a0),ground_vel(a0)
		tst.b	d3
		bpl.s	locret_12FCA
		neg.w	ground_vel(a0)

locret_12FCA:
		rts
; ---------------------------------------------------------------------------

loc_12FCC:
		bsr.w	CheckRightWallDist
		tst.w	d1
		bpl.s	+ ;loc_12FE4
		add.w	d1,x_pos(a0)
		move.w	#0,x_vel(a0)
		move.w	y_vel(a0),ground_vel(a0)

+ ;loc_12FE4:
		bsr.w	Sonic_CheckCeiling
		tst.w	d1
		bpl.s	+ ;loc_12FFE
		sub.w	d1,y_pos(a0)
		tst.w	y_vel(a0)
		bpl.s	locret_12FFC
		move.w	#0,y_vel(a0)

locret_12FFC:
		rts
; ---------------------------------------------------------------------------

+ ;loc_12FFE:
		tst.b	(WindTunnel_flag).w
		bne.s	+ ;loc_1300A
		tst.w	y_vel(a0)
		bmi.s	locret_1302A

+ ;loc_1300A:
		bsr.w	Sonic_CheckFloor
		tst.w	d1
		bpl.s	locret_1302A
		add.w	d1,y_pos(a0)
		move.b	d3,angle(a0)
		move.w	#0,y_vel(a0)
		move.w	x_vel(a0),ground_vel(a0)
		bsr.w	Player_TouchFloor_Check_Spindash

locret_1302A:
		rts
; End of function Sonic_DoLevelCollision


; =============== S U B R O U T I N E =======================================


Player_TouchFloor_Check_Spindash:
		tst.b	spin_dash_flag(a0)
		bne.s	+ ;loc_13070
		move.b	#0,anim(a0)
; End of function Player_TouchFloor_Check_Spindash


; =============== S U B R O U T I N E =======================================


Player_TouchFloor:
		cmpi.l	#Obj_Tails,(a0)
		beq.w	Tails_TouchFloor

		move.b	y_radius(a0),d0
		move.b	default_y_radius(a0),y_radius(a0)
		move.b	default_x_radius(a0),x_radius(a0)
		btst	#Status_Roll,status(a0)
		beq.s	+ ;loc_13070
		bclr	#Status_Roll,status(a0)
		move.b	#0,anim(a0)
		sub.b	default_y_radius(a0),d0
		ext.w	d0
		add.w	d0,y_pos(a0)

+ ;loc_13070:
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
		beq.s	locret_130BC
		btst	#Status_BublShield,status_secondary(a0)
		beq.s	+ ;loc_130B6
		bsr.s	BubbleShield_Bounce

+ ;loc_130B6:
		move.b	#0,double_jump_flag(a0)

locret_130BC:
		rts
; End of function Player_TouchFloor


; =============== S U B R O U T I N E =======================================


BubbleShield_Bounce:
		movem.l	d1-d2,-(sp)
		move.w	#$780,d2
		btst	#Status_Underwater,status(a0)
		beq.s	+ ;loc_130D2
		move.w	#$400,d2

+ ;loc_130D2:
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
		sub.w	d0,y_pos(a0)
		move.b	#2,(Shield+anim).w
		move.w	#sfx_BubbleAttack,d0
		jmp	(Play_SFX).l
; End of function BubbleShield_Bounce

; ---------------------------------------------------------------------------

loc_13142:
		tst.w	(Debug_mode_flag).w
		beq.s	+ ;loc_1315C
		btst	#button_B,(Ctrl_1_pressed).w
		beq.s	+ ;loc_1315C
		move.w	#1,(Debug_placement_mode).w
		clr.b	(Ctrl_1_locked).w
		rts
; ---------------------------------------------------------------------------

+ ;loc_1315C:
		jsr	(MoveSprite2).l
		addi.w	#$30,y_vel(a0)
		btst	#6,status(a0)
		beq.s	+ ;loc_13176
		subi.w	#$20,y_vel(a0)

+ ;loc_13176:
		cmpi.w	#-$100,(Camera_min_Y_pos).w
		bne.s	+ ;loc_13186
		move.w	(Screen_Y_wrap_value).w,d0
		and.w	d0,y_pos(a0)

+ ;loc_13186:
		bsr.w	sub_1319C
		bsr.w	Player_LevelBound
		bsr.w	Sonic_RecordPos
		bsr.w	sub_13438
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_1319C:
		tst.b	(Disable_death_plane).w
		bne.s	+ ;loc_131B2
		move.w	(Camera_max_Y_pos).w,d0
		addi.w	#$E0,d0
		cmp.w	y_pos(a0),d0
		blt.w	++ ;loc_131F8

+ ;loc_131B2:
		movem.l	a4-a6,-(sp)
		bsr.w	Sonic_DoLevelCollision
		movem.l	(sp)+,a4-a6
		btst	#1,status(a0)
		bne.s	locret_131F6
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

locret_131F6:
		rts
; ---------------------------------------------------------------------------

+ ;loc_131F8:
		jmp	(Kill_Character).l
; End of function sub_1319C

; ---------------------------------------------------------------------------

loc_131FE:
		tst.w	(Debug_mode_flag).w
		beq.s	+ ;loc_13218
		btst	#button_B,(Ctrl_1_pressed).w
		beq.s	+ ;loc_13218
		move.w	#1,(Debug_placement_mode).w
		clr.b	(Ctrl_1_locked).w
		rts
; ---------------------------------------------------------------------------

+ ;loc_13218:
		bsr.w	sub_13230
		jsr	(MoveSprite).l
		bsr.w	Sonic_RecordPos
		bsr.w	sub_13438
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_13230:
		cmpa.w	#Player_1,a0
		bne.s	+ ;loc_13242
		move.w	(Camera_Y_pos).w,d0
		move.b	#1,(Scroll_lock).w
		bra.s	++ ;loc_1324C
; ---------------------------------------------------------------------------

+ ;loc_13242:
		move.w	(Camera_Y_pos).w,d0
		move.b	#1,(Scroll_lock_P2).w

+ ;loc_1324C:
		move.b	#0,spin_dash_flag(a0)
		addi.w	#$100,d0
		tst.w	(Competition_mode).w
		beq.s	loc_13260
		subi.w	#$70,d0

loc_13260:
		cmp.w	y_pos(a0),d0
		bge.w	locret_1331E
		tst.w	(Competition_mode).w
		bne.w	loc_13320
		cmpi.b	#1,character_id(a0)
		bne.s	loc_1328A
		cmpi.w	#2,(Player_mode).w
		beq.s	loc_1328A
		move.b	#2,routine(a0)
		bra.w	sub_14B58
; ---------------------------------------------------------------------------

loc_1328A:
		move.b	#8,routine(a0)
		move.w	#60,$3E(a0)
		move.b	#0,(Respawn_table_keep).w
		addq.b	#1,(Update_HUD_life_count).w
		subq.b	#1,(Life_count).w
		bne.s	+ ;loc_132F0
		move.w	#0,$3E(a0)
		move.l	#Obj_GameOver,(Reserved_object_3).w
		move.l	#Obj_GameOver,(Dynamic_object_RAM).w
		move.b	#0,(Reserved_object_3+mapping_frame).w
		move.b	#1,(Dynamic_object_RAM+mapping_frame).w
		move.w	a0,(Reserved_object_3+objoff_3E).w
		clr.b	(Time_over_flag).w

loc_132D0:
		clr.b	(Update_HUD_timer).w
		clr.b	(Update_HUD_timer_P2).w
		move.b	#8,routine(a0)
		move.w	#mus_GameOver,d0
		jsr	(Play_Music).l
		moveq	#3,d0
		jmp	(Load_PLC_2).l
; ---------------------------------------------------------------------------

+ ;loc_132F0:
		tst.b	(Time_over_flag).w
		beq.s	locret_1331E
		move.w	#0,$3E(a0)
		move.l	#Obj_GameOver,(Reserved_object_3).w
		move.l	#Obj_GameOver,(Dynamic_object_RAM).w
		move.b	#2,(Reserved_object_3+mapping_frame).w
		move.b	#3,(Dynamic_object_RAM+mapping_frame).w
		move.w	a0,(Reserved_object_3+objoff_3E).w
		bra.s	loc_132D0
; ---------------------------------------------------------------------------

locret_1331E:
		rts
; ---------------------------------------------------------------------------

loc_13320:
		move.b	#2,routine(a0)
		cmpa.w	#Player_1,a0
		bne.s	+ ;loc_1335A
		move.b	#0,(Scroll_lock).w
		move.w	(Saved_X_pos).w,x_pos(a0)
		move.w	(Saved_Y_pos).w,y_pos(a0)
		move.w	(Saved_art_tile).w,art_tile(a0)
		move.w	(Saved_solid_bits).w,top_solid_bit(a0)
		clr.w	(Ring_count).w
		clr.b	(Extra_life_flags).w
		move.b	#1,(_unkF74A).w
		bra.s	++ ;loc_13382
; ---------------------------------------------------------------------------

+ ;loc_1335A:
		move.b	#0,(Scroll_lock_P2).w
		move.w	(Saved2_X_pos).w,x_pos(a0)
		move.w	(Saved2_Y_pos).w,y_pos(a0)
		move.w	(Saved2_art_tile).w,art_tile(a0)
		move.w	(Saved2_solid_bits).w,top_solid_bit(a0)
		clr.w	(Ring_count_P2).w
		move.b	#1,(_unkF74B).w

+ ;loc_13382:
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
; End of function sub_13230

; ---------------------------------------------------------------------------

loc_133D4:
		tst.w	$3E(a0)
		beq.s	locret_133E6
		subq.w	#1,$3E(a0)
		bne.s	locret_133E6
		move.w	#1,(Restart_level_flag).w

locret_133E6:
		rts
; ---------------------------------------------------------------------------

loc_133E8:
		tst.w	(Camera_RAM).w
		bne.s	+ ;loc_133FA
		tst.w	(V_scroll_amount).w
		bne.s	+ ;loc_133FA
		move.b	#2,routine(a0)

+ ;loc_133FA:
		bsr.w	sub_13438
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_13404:
		tst.w	(Debug_mode_flag).w
		beq.s	+ ;loc_1341E
		btst	#button_B,(Ctrl_1_pressed).w
		beq.s	+ ;loc_1341E
		move.w	#1,(Debug_placement_mode).w
		clr.b	(Ctrl_1_locked).w
		rts
; ---------------------------------------------------------------------------

+ ;loc_1341E:
		jsr	(MoveSprite2).l
		addi.w	#$10,y_vel(a0)
		bsr.w	Sonic_RecordPos
		bsr.w	sub_13438
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_13438:
		tst.w	(Competition_mode).w
		bne.s	+ ;loc_13444
		bsr.s	Animate_Sonic
		bra.w	Sonic_Load_PLC
; ---------------------------------------------------------------------------

+ ;loc_13444:
		bsr.w	Animate_SonicKnuckles_2P
		bra.w	SonicKnuckles2P_Load_PLC
; End of function sub_13438


; =============== S U B R O U T I N E =======================================


Animate_Sonic:
		lea	(AniSonic).l,a1
		tst.b	(Super_Sonic_Knux_flag).w
		beq.s	+ ;loc_1345E
		lea	(AniSuperSonic).l,a1

+ ;loc_1345E:
		moveq	#0,d0
		move.b	anim(a0),d0
		cmp.b	prev_anim(a0),d0
		beq.s	+ ;loc_13480
		move.b	d0,prev_anim(a0)
		move.b	#0,anim_frame(a0)
		move.b	#0,anim_frame_timer(a0)
		bclr	#5,status(a0)

+ ;loc_13480:
		add.w	d0,d0
		adda.w	(a1,d0.w),a1
		move.b	(a1),d0
		bmi.s	loc_134F0
		move.b	status(a0),d1
		andi.b	#1,d1
		andi.b	#$FC,render_flags(a0)
		or.b	d1,render_flags(a0)
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	locret_134BE
		move.b	d0,anim_frame_timer(a0)

loc_134A6:
		moveq	#0,d1
		move.b	anim_frame(a0),d1
		move.b	1(a1,d1.w),d0
		cmpi.b	#$FC,d0
		bhs.s	+ ;loc_134C0

loc_134B6:
		move.b	d0,mapping_frame(a0)
		addq.b	#1,anim_frame(a0)

locret_134BE:
		rts
; ---------------------------------------------------------------------------

+ ;loc_134C0:
		addq.b	#1,d0
		bne.s	+ ;loc_134D0
		move.b	#0,anim_frame(a0)
		move.b	1(a1),d0
		bra.s	loc_134B6
; ---------------------------------------------------------------------------

+ ;loc_134D0:
		addq.b	#1,d0
		bne.s	+ ;loc_134E4
		move.b	2(a1,d1.w),d0
		sub.b	d0,anim_frame(a0)
		sub.b	d0,d1
		move.b	1(a1,d1.w),d0
		bra.s	loc_134B6
; ---------------------------------------------------------------------------

+ ;loc_134E4:
		addq.b	#1,d0
		bne.s	locret_134EE
		move.b	2(a1,d1.w),anim(a0)

locret_134EE:
		rts
; ---------------------------------------------------------------------------

loc_134F0:
		addq.b	#1,d0
		bne.w	loc_13786
		moveq	#0,d0
		tst.b	flip_type(a0)
		bmi.w	Anim_Tumble
		move.b	flip_angle(a0),d0
		bne.w	Anim_Tumble
		moveq	#0,d1
		move.b	angle(a0),d0
		bmi.s	+ ;loc_13514
		beq.s	+ ;loc_13514
		subq.b	#1,d0

+ ;loc_13514:
		move.b	status(a0),d2
		andi.b	#1,d2
		bne.s	+ ;loc_13520
		not.b	d0

+ ;loc_13520:
		addi.b	#$10,d0
		bpl.s	+ ;loc_13528
		moveq	#3,d1

+ ;loc_13528:
		andi.b	#$FC,render_flags(a0)
		eor.b	d1,d2
		or.b	d2,render_flags(a0)
		btst	#5,status(a0)
		bne.w	loc_137CE
		lsr.b	#4,d0
		andi.b	#6,d0
		move.w	ground_vel(a0),d2
		bpl.s	+ ;loc_1354C
		neg.w	d2

+ ;loc_1354C:
		tst.b	status_secondary(a0)
		bpl.w	+ ;loc_13556
		add.w	d2,d2

+ ;loc_13556:
		tst.b	(Super_Sonic_Knux_flag).w
		bne.s	loc_135B2
		lea	(AniSonic01).l,a1
		cmpi.w	#$600,d2
		bhs.s	+ ;loc_13570
		lea	(AniSonic00).l,a1
		add.b	d0,d0

+ ;loc_13570:
		add.b	d0,d0
		move.b	d0,d3
		moveq	#0,d1
		move.b	anim_frame(a0),d1
		move.b	1(a1,d1.w),d0
		cmpi.b	#-1,d0
		bne.s	+ ;loc_1358E
		move.b	#0,anim_frame(a0)
		move.b	1(a1),d0

+ ;loc_1358E:
		move.b	d0,mapping_frame(a0)
		add.b	d3,mapping_frame(a0)
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	locret_135B0
		neg.w	d2
		addi.w	#$800,d2
		bpl.s	+ ;loc_135A6
		moveq	#0,d2

+ ;loc_135A6:
		lsr.w	#8,d2
		move.b	d2,anim_frame_timer(a0)
		addq.b	#1,anim_frame(a0)

locret_135B0:
		rts
; ---------------------------------------------------------------------------

loc_135B2:
		lea	(AniSuperSonic01).l,a1
		cmpi.w	#$800,d2
		bhs.s	+ ;loc_135CA
		lea	(AniSuperSonic00).l,a1
		add.b	d0,d0
		add.b	d0,d0
		bra.s	++ ;loc_135CC
; ---------------------------------------------------------------------------

+ ;loc_135CA:
		add.b	d0,d0

+ ;loc_135CC:
		move.b	d0,d3
		moveq	#0,d1
		move.b	anim_frame(a0),d1
		move.b	1(a1,d1.w),d0
		cmpi.b	#-1,d0
		bne.s	+ ;loc_135E8
		move.b	#0,anim_frame(a0)
		move.b	1(a1),d0

+ ;loc_135E8:
		move.b	d0,mapping_frame(a0)
		add.b	d3,mapping_frame(a0)
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	locret_1360A
		neg.w	d2
		addi.w	#$800,d2
		bpl.s	+ ;loc_13600
		moveq	#0,d2

+ ;loc_13600:
		lsr.w	#8,d2
		move.b	d2,anim_frame_timer(a0)
		addq.b	#1,anim_frame(a0)

locret_1360A:
		rts
; ---------------------------------------------------------------------------

;loc_1360C:
Anim_Tumble:
		move.b	flip_type(a0),d1
		andi.w	#$7F,d1
		bne.s	loc_13682
		move.b	flip_angle(a0),d0
		moveq	#0,d1
		move.b	status(a0),d2
		andi.b	#1,d2
		bne.s	Anim_TumbleLeft
		andi.b	#$FC,render_flags(a0)
		tst.b	flip_type(a0)
		bpl.s	+ ;loc_13640
		ori.b	#2,render_flags(a0)
		neg.b	d0
		addi.b	#$8F,d0
		bra.s	++ ;loc_13644
; ---------------------------------------------------------------------------

+ ;loc_13640:
		addi.b	#$B,d0

+ ;loc_13644:
		divu.w	#$16,d0
		addi.b	#$31,d0
		move.b	d0,mapping_frame(a0)
		move.b	#0,anim_frame_timer(a0)
		rts
; ---------------------------------------------------------------------------

;loc_13658:
Anim_TumbleLeft:
		andi.b	#$FC,render_flags(a0)
		ori.b	#3,render_flags(a0)
		neg.b	d0
		addi.b	#$8F,d0
		divu.w	#$16,d0
		addi.b	#$31,d0
		move.b	d0,mapping_frame(a0)
		move.b	#0,anim_frame_timer(a0)
		rts
; ---------------------------------------------------------------------------
byte_1367E:
		dc.b    0, $3D, $49, $49
		even
; ---------------------------------------------------------------------------

loc_13682:
		move.b	byte_1367E(pc,d1.w),d3
		cmpi.b	#1,d1
		bne.s	++ ;loc_136DA
		move.b	flip_angle(a0),d0
		moveq	#0,d1
		move.b	status(a0),d2
		andi.b	#1,d2
		bne.s	+ ;loc_136B8
		andi.b	#$FC,render_flags(a0)
		addi.b	#-8,d0
		divu.w	#$16,d0
		add.b	d3,d0
		move.b	d0,mapping_frame(a0)
		move.b	#0,anim_frame_timer(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_136B8:
		andi.b	#$FC,render_flags(a0)
		ori.b	#1,render_flags(a0)
		addi.b	#-8,d0
		divu.w	#$16,d0
		add.b	d3,d0
		move.b	d0,mapping_frame(a0)
		move.b	#0,anim_frame_timer(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_136DA:
		cmpi.b	#2,d1
		bne.s	++ ;loc_13730
		move.b	flip_angle(a0),d0
		moveq	#0,d1
		move.b	status(a0),d2
		andi.b	#1,d2
		bne.s	+ ;loc_1370C
		andi.b	#$FC,render_flags(a0)
		addi.b	#$B,d0
		divu.w	#$16,d0
		add.b	d3,d0
		move.b	d0,mapping_frame(a0)
		move.b	#0,anim_frame_timer(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_1370C:
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

+ ;loc_13730:
		move.b	flip_angle(a0),d0
		moveq	#0,d1
		move.b	status(a0),d2
		andi.b	#1,d2
		bne.s	+ ;loc_13764
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

+ ;loc_13764:
		andi.b	#$FC,render_flags(a0)
		ori.b	#1,render_flags(a0)
		addi.b	#$B,d0
		divu.w	#$16,d0
		add.b	d3,d0
		move.b	d0,mapping_frame(a0)
		move.b	#0,anim_frame_timer(a0)
		rts
; ---------------------------------------------------------------------------

loc_13786:
		subq.b	#1,anim_frame_timer(a0)
		bpl.w	locret_134BE
		move.w	ground_vel(a0),d2
		bpl.s	+ ;loc_13796
		neg.w	d2

+ ;loc_13796:
		lea	(AniSonic03).l,a1
		cmpi.w	#$600,d2
		bhs.s	+ ;loc_137A8
		lea	(AniSonic02).l,a1

+ ;loc_137A8:
		neg.w	d2
		addi.w	#$400,d2
		bpl.s	+ ;loc_137B2
		moveq	#0,d2

+ ;loc_137B2:
		lsr.w	#8,d2
		move.b	d2,anim_frame_timer(a0)
		move.b	status(a0),d1
		andi.b	#1,d1
		andi.b	#$FC,render_flags(a0)
		or.b	d1,render_flags(a0)
		bra.w	loc_134A6
; ---------------------------------------------------------------------------

loc_137CE:
		subq.b	#1,anim_frame_timer(a0)
		bpl.w	locret_134BE
		move.w	ground_vel(a0),d2
		bmi.s	+ ;loc_137DE
		neg.w	d2

+ ;loc_137DE:
		addi.w	#$800,d2
		bpl.s	+ ;loc_137E6
		moveq	#0,d2

+ ;loc_137E6:
		lsr.w	#6,d2
		move.b	d2,anim_frame_timer(a0)
		lea	(AniSonic04).l,a1
		tst.b	(Super_Sonic_Knux_flag).w
		beq.s	+ ;loc_137FE
		lea	(AniSuperSonic04).l,a1

+ ;loc_137FE:
		move.b	status(a0),d1
		andi.b	#1,d1
		andi.b	#$FC,render_flags(a0)
		or.b	d1,render_flags(a0)
		bra.w	loc_134A6
; End of function Animate_Sonic

; ---------------------------------------------------------------------------
AniSonic:
		include "General/Sprites/Sonic/Anim - Sonic S3.asm"

; =============== S U B R O U T I N E =======================================


Sonic_Load_PLC:
		moveq	#0,d0
		move.b	mapping_frame(a0),d0

Sonic_Load_PLC2:
		cmp.b	(Player_prev_frame).w,d0
		beq.s	locret_13A80
		move.b	d0,(Player_prev_frame).w
		lea	(PLC_Sonic).l,a2
		tst.b	(Super_Sonic_Knux_flag).w
		beq.s	+ ;loc_13A44
		lea	(PLC_SuperSonic).l,a2

+ ;loc_13A44:
		add.w	d0,d0
		adda.w	(a2,d0.w),a2
		move.w	(a2)+,d5
		subq.w	#1,d5
		bmi.s	locret_13A80
		move.w	#tiles_to_bytes(ArtTile_Player_1),d4

- ;loc_13A54:
		moveq	#0,d1
		move.w	(a2)+,d1
		move.w	d1,d3
		lsr.w	#8,d3
		andi.w	#$F0,d3
		addi.w	#$10,d3
		andi.w	#$FFF,d1
		lsl.l	#5,d1
		addi.l	#ArtUnc_Sonic,d1
		move.w	d4,d2
		add.w	d3,d4
		add.w	d3,d4
		jsr	(Add_To_DMA_Queue).l
		dbf	d5,- ;loc_13A54

locret_13A80:
		rts
; End of function Sonic_Load_PLC


; =============== S U B R O U T I N E =======================================


Perform_Player_DPLC:
		tst.b	character_id(a1)
		beq.s	Sonic_Load_PLC2
		bra.w	Tails_Load_PLC2
; End of function Perform_Player_DPLC


; =============== S U B R O U T I N E =======================================


Animate_SonicKnuckles_2P:
		lea	(AniSonic2P).l,a1
		tst.b	character_id(a0)
		beq.s	+ ;loc_13A9E
		lea	(AniKnuckles2P).l,a1

+ ;loc_13A9E:
		moveq	#0,d0
		move.b	anim(a0),d0
		cmp.b	prev_anim(a0),d0
		beq.s	+ ;loc_13AC0
		move.b	d0,prev_anim(a0)
		move.b	#0,anim_frame(a0)
		move.b	#0,anim_frame_timer(a0)
		bclr	#Status_Push,status(a0)

+ ;loc_13AC0:
		add.w	d0,d0
		adda.w	(a1,d0.w),a1
		move.b	(a1),d0
		bmi.s	loc_13B30
		move.b	status(a0),d1
		andi.b	#1,d1
		andi.b	#$FC,render_flags(a0)
		or.b	d1,render_flags(a0)
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	locret_13AFE
		move.b	d0,anim_frame_timer(a0)

loc_13AE6:
		moveq	#0,d1
		move.b	anim_frame(a0),d1
		move.b	1(a1,d1.w),d0
		cmpi.b	#$FC,d0
		bhs.s	+ ;loc_13B00

loc_13AF6:
		move.b	d0,mapping_frame(a0)
		addq.b	#1,anim_frame(a0)

locret_13AFE:
		rts
; ---------------------------------------------------------------------------

+ ;loc_13B00:
		addq.b	#1,d0
		bne.s	+ ;loc_13B10
		move.b	#0,anim_frame(a0)
		move.b	1(a1),d0
		bra.s	loc_13AF6
; ---------------------------------------------------------------------------

+ ;loc_13B10:
		addq.b	#1,d0
		bne.s	+ ;loc_13B24
		move.b	2(a1,d1.w),d0
		sub.b	d0,anim_frame(a0)
		sub.b	d0,d1
		move.b	1(a1,d1.w),d0
		bra.s	loc_13AF6
; ---------------------------------------------------------------------------

+ ;loc_13B24:
		addq.b	#1,d0
		bne.s	locret_13B2E
		move.b	2(a1,d1.w),anim(a0)

locret_13B2E:
		rts
; ---------------------------------------------------------------------------

loc_13B30:
		addq.b	#1,d0
		bne.w	loc_13C4A
		moveq	#0,d0
		move.b	flip_angle(a0),d0
		bne.w	loc_13BE4
		moveq	#0,d1
		move.b	angle(a0),d0
		bmi.s	+ ;loc_13B4C
		beq.s	+ ;loc_13B4C
		subq.b	#1,d0

+ ;loc_13B4C:
		move.b	status(a0),d2
		andi.b	#1,d2
		bne.s	+ ;loc_13B58
		not.b	d0

+ ;loc_13B58:
		addi.b	#$10,d0
		bpl.s	+ ;loc_13B60
		moveq	#3,d1

+ ;loc_13B60:
		andi.b	#$FC,render_flags(a0)
		eor.b	d1,d2
		or.b	d2,render_flags(a0)
		btst	#Status_Push,status(a0)
		bne.w	loc_13C92
		lsr.b	#5,d0
		andi.b	#3,d0
		move.w	ground_vel(a0),d2
		bpl.s	+ ;loc_13B84
		neg.w	d2

+ ;loc_13B84:
		tst.b	status_secondary(a0)
		bpl.w	+ ;loc_13B8E
		add.w	d2,d2

+ ;loc_13B8E:
		move.b	d0,d3
		lea	(AniSonic2P01).l,a1
		cmpi.w	#$600,d2
		bhs.s	+ ;loc_13BA4
		lea	(AniSonic2P00).l,a1
		add.b	d0,d0

+ ;loc_13BA4:
		add.b	d0,d3
		moveq	#0,d1
		move.b	anim_frame(a0),d1
		move.b	1(a1,d1.w),d0
		cmpi.b	#-1,d0
		bne.s	+ ;loc_13BC0
		move.b	#0,anim_frame(a0)
		move.b	1(a1),d0

+ ;loc_13BC0:
		move.b	d0,mapping_frame(a0)
		add.b	d3,mapping_frame(a0)
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	locret_13BE2
		neg.w	d2
		addi.w	#$800,d2
		bpl.s	+ ;loc_13BD8
		moveq	#0,d2

+ ;loc_13BD8:
		lsr.w	#8,d2
		move.b	d2,anim_frame_timer(a0)
		addq.b	#1,anim_frame(a0)

locret_13BE2:
		rts
; ---------------------------------------------------------------------------

loc_13BE4:
		move.b	flip_angle(a0),d0
		moveq	#0,d1
		move.b	status(a0),d2
		andi.b	#1,d2
		bne.s	+ ;loc_13C12
		andi.b	#$FC,render_flags(a0)
		addi.b	#$16,d0
		divu.w	#$2C,d0
		addi.b	#$15,d0
		move.b	d0,mapping_frame(a0)
		move.b	#0,anim_frame_timer(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_13C12:
		andi.b	#$FC,render_flags(a0)
		tst.b	flip_type(a0)
		bpl.s	+ ;loc_13C2A
		ori.b	#1,render_flags(a0)
		addi.b	#$16,d0
		bra.s	++ ;loc_13C36
; ---------------------------------------------------------------------------

+ ;loc_13C2A:
		ori.b	#3,render_flags(a0)
		neg.b	d0
		addi.b	#$9A,d0

+ ;loc_13C36:
		divu.w	#$2C,d0
		addi.b	#$15,d0
		move.b	d0,mapping_frame(a0)
		move.b	#0,anim_frame_timer(a0)
		rts
; ---------------------------------------------------------------------------

loc_13C4A:
		subq.b	#1,anim_frame_timer(a0)
		bpl.w	locret_13AFE
		move.w	ground_vel(a0),d2
		bpl.s	+ ;loc_13C5A
		neg.w	d2

+ ;loc_13C5A:
		lea	(AniSonic2P03).l,a1
		cmpi.w	#$600,d2
		bhs.s	+ ;loc_13C6C
		lea	(AniSonic2P02).l,a1

+ ;loc_13C6C:
		neg.w	d2
		addi.w	#$400,d2
		bpl.s	+ ;loc_13C76
		moveq	#0,d2

+ ;loc_13C76:
		lsr.w	#8,d2
		move.b	d2,anim_frame_timer(a0)
		move.b	status(a0),d1
		andi.b	#1,d1
		andi.b	#$FC,render_flags(a0)
		or.b	d1,render_flags(a0)
		bra.w	loc_13AE6
; ---------------------------------------------------------------------------

loc_13C92:
		subq.b	#1,anim_frame_timer(a0)
		bpl.w	locret_13AFE
		move.w	ground_vel(a0),d2
		bmi.s	+ ;loc_13CA2
		neg.w	d2

+ ;loc_13CA2:
		addi.w	#$800,d2
		bpl.s	+ ;loc_13CAA
		moveq	#0,d2

+ ;loc_13CAA:
		lsr.w	#6,d2
		lea	(AniSonic2P04).l,a1
		tst.b	character_id(a0)
		beq.s	+ ;loc_13CC0
		lea	(AniKnuckles2P04).l,a1
		lsr.w	#2,d2

+ ;loc_13CC0:
		move.b	d2,anim_frame_timer(a0)
		move.b	status(a0),d1
		andi.b	#1,d1
		andi.b	#$FC,render_flags(a0)
		or.b	d1,render_flags(a0)
		bra.w	loc_13AE6
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
		beq.s	+ ;loc_13E14
		lea	(PLC_Knuckles2P).l,a2
		move.l	#ArtUnc_Knuckles2P,d6

+ ;loc_13E14:
		add.w	d0,d0
		adda.w	(a2,d0.w),a2
		move.w	(a2)+,d5
		subq.w	#1,d5
		bmi.s	locret_13E56
		move.w	#tiles_to_bytes(ArtTile_Player_1),d4
		cmpa.w	#Player_1,a0
		beq.s	+ ;loc_13E2E
		move.w	#tiles_to_bytes(ArtTile_Player_2),d4

/ ;loc_13E2E:
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
		dbf	d5,- ;loc_13E2E

locret_13E56:
		rts
; End of function SonicKnuckles2P_Load_PLC

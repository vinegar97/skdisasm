Obj_AutomaticTunnelDelayed:
		subq.b	#1,anim_frame_timer(a0)
		bmi.s	loc_2853C
		rts
; ---------------------------------------------------------------------------

loc_2853C:
		move.b	#0,anim_frame_timer(a0)

Obj_AutomaticTunnel:
		ori.b	#4,render_flags(a0)
		move.b	#$10,width_pixels(a0)
		move.w	#$280,priority(a0)
		move.l	#loc_2855A,(a0)

loc_2855A:
		lea	(Player_1).w,a1
		lea	$30(a0),a4
		bsr.s	sub_28580
		lea	(Player_2).w,a1
		lea	$3A(a0),a4
		bsr.s	sub_28580
		move.b	$30(a0),d0
		add.b	$3A(a0),d0
		beq.s	loc_2857A		; As long as this object is attached to a character, do not destroy it
		rts
; ---------------------------------------------------------------------------

loc_2857A:
		jmp	(Delete_Sprite_If_Not_In_Range).l

; =============== S U B R O U T I N E =======================================


sub_28580:
		moveq	#0,d0
		move.b	(a4),d0
		move.w	AutoTunnel_Index(pc,d0.w),d0
		jmp	AutoTunnel_Index(pc,d0.w)
; End of function sub_28580

; ---------------------------------------------------------------------------
AutoTunnel_Index:
		dc.w Obj_AutoTunnelInit-AutoTunnel_Index
		dc.w Obj_AutoTunnelRun-AutoTunnel_Index
		dc.w Obj_AutoTunnelLastMove-AutoTunnel_Index
; ---------------------------------------------------------------------------

Obj_AutoTunnelInit:
		tst.w	(Debug_placement_mode).w
		bne.w	locret_28644		; If debug mode is on, don't bother
		move.w	x_pos(a1),d0
		sub.w	x_pos(a0),d0
		addi.w	#$10,d0
		cmpi.w	#$20,d0
		bhs.w	locret_28644
		move.w	y_pos(a1),d1
		sub.w	y_pos(a0),d1
		addi.w	#$18,d1
		cmpi.w	#$28,d1
		bhs.w	locret_28644		; Only activate if player is in range
		tst.b	object_control(a1)
		bne.s	locret_28644		; If under control of another object, don't activate
		addq.b	#2,(a4)
		move.b	#$81,object_control(a1)	; Lock this object to Sonic/Tails
		move.b	#2,anim(a1)		; Set player to rolling animation
		clr.b	jumping(a1)		; Ensure they're no longer jumping
		move.w	#$800,ground_vel(a1)
		move.w	#0,x_vel(a1)
		move.w	#0,y_vel(a1)
		bclr	#p1_pushing_bit,status(a0)
		bclr	#Status_Push,status(a1)
		bset	#Status_InAir,status(a1)	; Player is not pushing anything and not in the air
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)	; Lock player's position to object's position
		clr.b	1(a4)
		bsr.w	AutoTunnel_GetPath	; Get the first path of the tunnel
		moveq	#signextendB(sfx_Roll),d0
		jsr	(Play_SFX).l
		btst	#5,subtype(a0)
		beq.s	locret_28644
		tst.b	(Current_act).w		; If bit 5 of object subtype is set and we're in an act 2
		beq.s	locret_28644
		bclr	#Status_FireShield,status_secondary(a1)
		beq.s	loc_28636
		bclr	#Status_Shield,status_secondary(a1)

loc_28636:
		bclr	#Status_LtngShield,status_secondary(a1)
		beq.s	locret_28644
		bclr	#Status_Shield,status_secondary(a1)	; Disable fire/lightning shields. This is probably for the water tunnels in LBZ2

locret_28644:
		rts
; ---------------------------------------------------------------------------

Obj_AutoTunnelRun:
		subq.b	#1,2(a4)
		bhi.w	loc_286DA
		movea.l	6(a4),a2		; If timer has exhausted, get address of path data
		move.w	(a2)+,d4
		move.w	d4,x_pos(a1)
		move.w	(a2)+,d5
		move.w	d5,y_pos(a1)		; Get the new starting position
		tst.b	subtype(a0)
		bpl.s	loc_28666
		subq.w	#8,a2			; See if we're going backwards

loc_28666:
		move.l	a2,6(a4)		; Replace address of path
		subq.w	#4,4(a4)
		beq.s	loc_2867C		; If path has exhausted, branch
		move.w	(a2)+,d4
		move.w	(a2)+,d5
		move.w	#$1000,d2
		bra.w	AutoTunnel_CalcSpeed		; Get new velocity
; ---------------------------------------------------------------------------

loc_2867C:
		addq.b	#2,(a4)			; Go to next routine
		move.b	#2,2(a4)
		andi.w	#$FFF,y_pos(a1)	; Make sure the player's Y position remains valid
		btst	#6,subtype(a0)		; If bit 6 is not set
		bne.s	loc_2869E
		move.w	#0,x_vel(a1)		; Then stop player movement. Otherwise he'll continue moving
		move.w	#0,y_vel(a1)

loc_2869E:
		moveq	#signextendB(sfx_TubeLauncher),d0
		jsr	(Play_SFX).l	; Play that nifty little cannon shooting sound
		btst	#5,subtype(a0)
		beq.s	loc_286DA
		movea.l	a1,a2			; If bit 5 set (for LBZ2, again), make the waterfall
		jsr	(AllocateObjectAfterCurrent).l
		bne.w	loc_286D8
		move.l	#Obj_TunnelExhaustControl,(a1)
		move.w	x_pos(a2),x_pos(a1)
		move.w	y_pos(a2),y_pos(a1)
		move.w	x_vel(a2),x_vel(a1)
		move.w	y_vel(a2),y_vel(a1)

loc_286D8:
		movea.l	a2,a1

loc_286DA:
		move.l	x_pos(a1),d2		; Perform movement
		move.l	y_pos(a1),d3
		move.w	x_vel(a1),d0
		ext.l	d0
		asl.l	#8,d0
		add.l	d0,d2
		move.w	y_vel(a1),d0
		ext.l	d0
		asl.l	#8,d0
		add.l	d0,d3			; Add velocity to player
		move.l	d2,x_pos(a1)
		move.l	d3,y_pos(a1)
		rts
; ---------------------------------------------------------------------------

Obj_AutoTunnelLastMove:
		subq.b	#1,2(a4)
		bne.s	loc_2870C		; This is the last movement
		clr.b	object_control(a1)
		clr.b	(a4)

loc_2870C:
		addi.w	#$38,y_vel(a1)	; Reapply gravity
		bra.s	loc_286DA

; =============== S U B R O U T I N E =======================================


AutoTunnel_GetPath:
		move.b	subtype(a0),d0
		bpl.s	loc_28748
		andi.w	#$1F,d0			; If negative, then the path is reversed
		add.w	d0,d0
		add.w	d0,d0
		lea	(AutoTunnel_Data).l,a2
		movea.l	(a2,d0.w),a2	; Get address of movement data
		move.w	(a2)+,d0
		subq.w	#4,d0
		move.w	d0,4(a4)
		lea	(a2,d0.w),a2
		move.w	(a2)+,d4
		move.w	d4,x_pos(a1)
		move.w	(a2)+,d5
		move.w	d5,y_pos(a1)		; Set absolute position of player
		subq.w	#8,a2
		bra.s	loc_2877E
; ---------------------------------------------------------------------------

loc_28748:
		cmpi.b	#$10,d0
		bne.s	loc_28758
		cmpi.w	#2,(Player_mode).w
		bne.s	loc_28758
		moveq	#0,d0			; If playing as Tails, use path 0 when doing path $10

loc_28758:
		andi.w	#$1F,d0
		add.w	d0,d0
		add.w	d0,d0
		lea	(AutoTunnel_Data).l,a2
		movea.l	(a2,d0.w),a2
		move.w	(a2)+,4(a4)
		subq.w	#4,4(a4)
		move.w	(a2)+,d4
		move.w	d4,x_pos(a1)
		move.w	(a2)+,d5
		move.w	d5,y_pos(a1)		; Set absolute position of player

loc_2877E:
		move.l	a2,6(a4)
		move.w	(a2)+,d4
		move.w	(a2)+,d5		; Get next position
		move.w	#$1000,d2

AutoTunnel_CalcSpeed:
		moveq	#0,d0
		move.w	d2,d3
		move.w	d4,d0
		sub.w	x_pos(a1),d0
		bge.s	loc_2879A
		neg.w	d0
		neg.w	d2			; Change X velocity depending on direction of destination

loc_2879A:
		moveq	#0,d1
		move.w	d5,d1
		sub.w	$14(a1),d1
		bge.s	loc_287A8
		neg.w	d1
		neg.w	d3			; Change Y velocity depending on direction of destination

loc_287A8:
		cmp.w	d0,d1
		blo.s	loc_287DA
		moveq	#0,d1
		move.w	d5,d1
		sub.w	y_pos(a1),d1
		swap	d1
		divs.w	d3,d1
		moveq	#0,d0
		move.w	d4,d0
		sub.w	x_pos(a1),d0
		beq.s	loc_287C6
		swap	d0
		divs.w	d1,d0

loc_287C6:
		move.w	d0,x_vel(a1)		; Calculate and set X velocity assuming a Y velocity of $10 pixels
		move.w	d3,y_vel(a1)
		tst.w	d1
		bpl.s	loc_287D4
		neg.w	d1

loc_287D4:
		move.w	d1,2(a4)		; The quotient of the distance/speed produces a proper timer used for movement
		rts
; ---------------------------------------------------------------------------

loc_287DA:
		moveq	#0,d0			; If Y distance is less than X distance
		move.w	d4,d0
		sub.w	x_pos(a1),d0
		swap	d0
		divs.w	d2,d0
		moveq	#0,d1
		move.w	d5,d1
		sub.w	y_pos(a1),d1
		beq.s	loc_287F4
		swap	d1
		divs.w	d0,d1

loc_287F4:
		move.w	d1,y_vel(a1)	; Calculate and set Y velocity assuming a X velocity of $10 pixels
		move.w	d2,x_vel(a1)
		tst.w	d0
		bpl.s	loc_28802
		neg.w	d0

loc_28802:
		move.w	d0,2(a4)	; See above
		rts
; End of function AutoTunnel_GetPath

; ---------------------------------------------------------------------------

Obj_TunnelExhaustControl:
		move.l	#Map_TunnelExhaust,mappings(a0)
		move.w	#make_art_tile($2EA,2,0),art_tile(a0)
		move.b	#$10,width_pixels(a0)
		move.b	#$10,height_pixels(a0)
		ori.b	#4,render_flags(a0)
		move.w	#$180,priority(a0)
		tst.b	subtype(a0)
		beq.s	loc_2883E
		move.l	#Obj_TunnelExContinuous,(a0)
		bra.w	Obj_TunnelExContinuous
; ---------------------------------------------------------------------------

loc_2883E:
		move.w	#60,$30(a0)
		tst.w	y_vel(a0)
		beq.s	loc_28854
		bmi.s	loc_28866
		move.w	#6,angle(a0)		; angle is 6 if moving downward, 0 if moving upward
		bra.s	loc_28866
; ---------------------------------------------------------------------------

loc_28854:
		move.w	#$C,angle(a0)		; If vertical movement is null
		tst.w	x_vel(a0)
		bmi.s	loc_28866
		move.w	#$12,angle(a0)		; angle is $C if X velocity is to the left, $12 if to the right

loc_28866:
		tst.b	(Current_act).w
		bne.s	loc_28876
		move.l	#Obj_TunnelExSmoke,(a0)		; If in act 1, just make smoke
		bra.w	Obj_TunnelExSmoke
; ---------------------------------------------------------------------------

loc_28876:
		move.l	#Obj_TunnelExhaustControlMain,(a0)	; If in act 2

Obj_TunnelExhaustControlMain:
		subq.w	#1,$2E(a0)
		bpl.s	loc_288F2
		move.w	#4-1,$2E(a0)		; Make a new exhaust sprite every 4 frames
		jsr	(AllocateObjectAfterCurrent).l
		bne.w	loc_288F2
		move.l	#Obj_TunnelExhaustUp,(a1)
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		move.l	#Map_TunnelExhaust,mappings(a1)
		move.w	#make_art_tile($2EA,2,0),art_tile(a1)
		move.b	#$10,width_pixels(a1)
		move.b	#$10,height_pixels(a1)
		move.w	#$380,priority(a1)
		move.w	angle(a0),d0
		cmpi.w	#6,d0
		bne.s	loc_288D4
		move.l	#Obj_TunnelExhaustDown,(a1)	; If moving downward, change the object to use

loc_288D4:
		lea	word_28904(pc,d0.w),a2
		move.w	(a2)+,x_vel(a1)
		move.w	(a2)+,y_vel(a1)
		move.b	(a2)+,render_flags(a1)
		move.b	(a2)+,mapping_frame(a1)
		bne.s	loc_288F2
		move.l	#Obj_TunnelExhaustHorz,(a1)
		bsr.s	sub_2891C

loc_288F2:
		subq.w	#1,$30(a0)		; Continue doing this until timer runs out
		bpl.s	loc_288FE
		move.w	#$7FF0,x_pos(a0)

loc_288FE:
		jmp	(Delete_Sprite_If_Not_In_Range).l
; ---------------------------------------------------------------------------
word_28904:
		dc.w      0	; X velocity
		dc.w  -$600	; Y velocity
		dc.b  $86	; Flip value
		dc.b    1	; Mapping frame
		dc.w      0
		dc.w   $400
		dc.b  $84
		dc.b    1
		dc.w  -$600
		dc.w      0
		dc.b  $85
		dc.b    0
		dc.w   $600
		dc.w      0
		dc.b  $84
		dc.b    0

; =============== S U B R O U T I N E =======================================


sub_2891C:
		moveq	#0,d0			; Slow down exhaust trickle over time
		move.w	$30(a0),d0
		subi.w	#$3C,d0
		neg.w	d0
		lsl.w	#4,d0
		tst.w	x_vel(a1)
		bmi.s	loc_28932
		neg.w	d0

loc_28932:
		add.w	d0,x_vel(a1)
		rts
; End of function sub_2891C

; ---------------------------------------------------------------------------

Obj_TunnelExhaustUp:
		move.b	(Level_frame_counter+1).w,d0
		andi.b	#1,d0
		bne.s	loc_28948
		bchg	#0,render_flags(a0)	; Change X flip every 2 frames

loc_28948:
		jsr	(MoveSprite).l
		tst.b	render_flags(a0)
		bmi.s	loc_28960	; If on-screen, branch
		tst.w	y_vel(a0)
		bmi.s	loc_28960	; If vertical velocity is going upwards, branch
		move.w	#$7FF0,x_pos(a0)	; Ensure that the object is definitely offscreen

loc_28960:
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------

Obj_TunnelExhaustDown:
		move.b	(Level_frame_counter+1).w,d0
		andi.b	#1,d0
		bne.s	loc_28976
		bchg	#0,render_flags(a0)	; Change X flip every 2 frames

loc_28976:
		jsr	(MoveSprite).l
		tst.b	render_flags(a0)
		bmi.s	loc_28990	; If on-screen, branch
		cmpi.w	#$C00,y_vel(a0)
		blt.s	loc_28990	; If vertical velocity is less than $C00, branch
		move.w	#$7FF0,x_pos(a0)

loc_28990:
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------

Obj_TunnelExhaustHorz:
		move.b	(Level_frame_counter+1).w,d0
		andi.b	#1,d0
		bne.s	loc_289A6
		bchg	#1,render_flags(a0)

loc_289A6:
		jsr	(MoveSprite).l
		tst.b	render_flags(a0)
		bmi.s	loc_289C0
		cmpi.w	#$600,y_vel(a0)
		blt.s	loc_289C0
		move.w	#$7FF0,x_pos(a0)

loc_289C0:
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------

Obj_TunnelExContinuous:
		move.b	(Level_frame_counter+1).w,d0	; This control object creates new sprites continuously
		andi.b	#3,d0
		bne.s	loc_28A2A
		jsr	(AllocateObjectAfterCurrent).l		; Create a new sprite every four frames
		bne.w	loc_28A2A
		move.l	#Obj_TunnelExhaustTimed,(a1)	; This is a timed exhaust (the short waterfalls in LBZ2 for example)
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		move.l	#Map_TunnelExhaust,mappings(a1)
		move.w	#make_art_tile($2EA,2,0),art_tile(a1)
		move.b	#$10,width_pixels(a1)
		move.b	#$10,height_pixels(a1)
		move.w	#$380,priority(a1)
		move.w	#0,x_vel(a1)
		move.w	#$400,y_vel(a1)
		move.b	#$84,render_flags(a1)
		move.b	#1,mapping_frame(a1)
		move.w	#$C-1,$2E(a1)

loc_28A2A:
		jmp	(Delete_Sprite_If_Not_In_Range).l
; ---------------------------------------------------------------------------

Obj_TunnelExhaustTimed:
		subq.w	#1,$2E(a0)
		bpl.s	loc_28A42
		move.w	#$C-1,$2E(a0)
		move.w	#$7FF0,x_pos(a0)

loc_28A42:
		move.b	(Level_frame_counter+1).w,d0
		andi.b	#1,d0
		bne.s	loc_28A52
		bchg	#0,render_flags(a0)

loc_28A52:
		jsr	(MoveSprite).l
		tst.b	render_flags(a0)
		bmi.s	loc_28A64
		move.w	#$7FF0,x_pos(a0)

loc_28A64:
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------

Obj_TunnelExSmoke:
		move.b	(Level_frame_counter+1).w,d0
		andi.b	#3,d0
		bne.s	loc_28A9C
		jsr	(AllocateObjectAfterCurrent).l
		bne.w	loc_28A9C
		move.l	#Obj_FireShield_Dissipate,(a1)
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		move.w	x_vel(a0),x_vel(a1)
		move.w	y_vel(a0),y_vel(a1)

loc_28A9C:
		subq.w	#1,$30(a0)
		bpl.s	loc_28AA8
		move.w	#$7FF0,x_pos(a0)

loc_28AA8:
		jmp	(Delete_Sprite_If_Not_In_Range).l
; ---------------------------------------------------------------------------
		move.l	#Map_TunnelExhaust,mappings(a0)
		move.w	#make_art_tile($2EA,2,0),art_tile(a0)
		move.b	#$10,width_pixels(a0)
		move.b	#$10,height_pixels(a0)
		ori.b	#4,render_flags(a0)
		move.w	#$180,priority(a0)
		move.w	#2*60,$30(a0)
		move.l	#loc_28AE0,(a0)

loc_28AE0:
		tst.b	$32(a0)
		bne.s	loc_28B5A
		subq.w	#1,$2E(a0)
		bpl.s	loc_28B5A
		move.w	#4-1,$2E(a0)
		jsr	(AllocateObjectAfterCurrent).l
		bne.w	loc_28B5A
		move.l	#loc_28B72,(a1)
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		move.l	#Map_TunnelExhaust,mappings(a1)
		move.w	#make_art_tile($2EA,2,0),art_tile(a1)
		move.b	#$10,width_pixels(a1)
		move.b	#$10,height_pixels(a1)
		move.w	#$380,priority(a1)
		ori.b	#4,render_flags(a1)
		bset	#0,render_flags(a1)
		move.w	#-$800,x_vel(a1)
		moveq	#0,d0
		move.b	subtype(a0),d0
		addq.w	#1,d0
		add.w	d0,d0
		move.w	d0,$2E(a1)
		addi.w	#$10,x_pos(a1)
		move.b	#$C6,collision_flags(a1)

loc_28B5A:
		subq.w	#1,$30(a0)
		bpl.s	loc_28B6C
		move.w	#2*60,$30(a0)
		eori.b	#$FF,$32(a0)

loc_28B6C:
		jmp	(Delete_Sprite_If_Not_In_Range).l
; ---------------------------------------------------------------------------

loc_28B72:
		move.b	(Level_frame_counter+1).w,d0
		andi.b	#1,d0
		bne.s	loc_28B82
		bchg	#1,render_flags(a0)

loc_28B82:
		jsr	(MoveSprite2).l
		subq.w	#1,$2E(a0)
		bpl.s	loc_28B94
		move.w	#$7FF0,x_pos(a0)

loc_28B94:
		move.b	collision_property(a0),d0
		beq.w	loc_28BB8
		lea	(Player_1).w,a1
		bclr	#0,collision_property(a0)
		beq.s	loc_28BAA
		bsr.s	sub_28BBE

loc_28BAA:
		lea	(Player_2).w,a1
		bclr	#1,collision_property(a0)
		beq.s	loc_28BB8
		bsr.s	sub_28BBE

loc_28BB8:
		jmp	(Sprite_CheckDeleteTouch3).l

; =============== S U B R O U T I N E =======================================


sub_28BBE:
		tst.b	object_control(a1)
		bne.s	locret_28BFA
		move.w	y_pos(a0),y_pos(a1)
		cmpi.w	#-$1000,x_vel(a1)
		beq.s	locret_28BFA
		move.b	#$1A,anim(a1)
		clr.b	jumping(a1)
		move.w	#0,ground_vel(a1)
		move.w	#-$1000,x_vel(a1)
		move.w	#0,y_vel(a1)
		bclr	#Status_Push,status(a1)
		bset	#Status_InAir,status(a1)

locret_28BFA:
		rts
; End of function sub_28BBE

; ---------------------------------------------------------------------------
Map_TunnelExhaust:
		include "Levels/LBZ/Misc Object Data/Map - (&LRZ) Tunnel Exhaust.asm"
; ---------------------------------------------------------------------------

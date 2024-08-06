; =============== S U B R O U T I N E =======================================


DebugMode:
		moveq	#0,d0
		move.b	(Debug_placement_routine).w,d0
		move.w	.Index(pc,d0.w),d1
		jmp	.Index(pc,d1.w)
; End of function DebugMode

; ---------------------------------------------------------------------------
.Index:
		dc.w loc_92A20-.Index
		dc.w loc_92AB0-.Index
; ---------------------------------------------------------------------------

loc_92A20:
		addq.b	#2,(Debug_placement_routine).w
		move.l	mappings(a0),(Debug_saved_mappings).w
		cmpi.b	#6,routine(a0)
		bhs.s	loc_92A38
		move.w	art_tile(a0),(Debug_saved_art_tile).w

loc_92A38:
		move.w	(Screen_Y_wrap_value).w,d0
		and.w	d0,(Player_1+y_pos).w
		and.w	d0,(Camera_Y_pos).w
		clr.b	(Scroll_lock).w
		clr.w	(WindTunnel_flag).w
		bclr	#Status_Underwater,status(a0)
		beq.s	loc_92A6E
		movea.l	a0,a1
		jsr	(Player_ResetAirTimer).l
		move.w	#$600,(Max_speed).w
		move.w	#$C,(Acceleration).w
		move.w	#$80,(Deceleration).w

loc_92A6E:
		move.b	#0,mapping_frame(a0)
		move.b	#0,anim(a0)
		moveq	#0,d0
		move.w	(Current_zone_and_act).w,d0
		ror.b	#1,d0
		lsr.w	#6,d0
		andi.w	#$7E,d0
		lea	(DebugOffs).l,a2
		adda.w	(a2,d0.w),a2
		move.w	(a2)+,d6
		cmp.b	(Debug_object).w,d6
		bhi.s	loc_92AA0
		move.b	#0,(Debug_object).w

loc_92AA0:
		bsr.w	sub_92C88
		move.b	#$C,(Debug_camera_delay).w
		move.b	#1,(Debug_camera_speed).w

loc_92AB0:
		moveq	#0,d0
		move.w	(Current_zone_and_act).w,d0
		ror.b	#1,d0
		lsr.w	#6,d0
		andi.w	#$7E,d0
		lea	(DebugOffs).l,a2
		adda.w	(a2,d0.w),a2
		move.w	(a2)+,d6
		bsr.w	sub_92AD4
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_92AD4:
		moveq	#0,d4
		move.w	#1,d1
		move.b	(Ctrl_1_pressed).w,d4
		andi.w	#button_up_mask|button_down_mask|button_left_mask|button_right_mask,d4
		bne.s	loc_92B16
		move.b	(Ctrl_1_held).w,d0
		andi.w	#button_up_mask|button_down_mask|button_left_mask|button_right_mask,d0
		bne.s	loc_92AFE
		move.b	#$C,(Debug_camera_delay).w
		move.b	#$F,(Debug_camera_speed).w
		bra.w	loc_92B7A
; ---------------------------------------------------------------------------

loc_92AFE:
		subq.b	#1,(Debug_camera_delay).w
		bne.s	loc_92B1A
		move.b	#1,(Debug_camera_delay).w
		addq.b	#1,(Debug_camera_speed).w
		bne.s	loc_92B16
		move.b	#255,(Debug_camera_speed).w

loc_92B16:
		move.b	(Ctrl_1_held).w,d4

loc_92B1A:
		moveq	#0,d1
		move.b	(Debug_camera_speed).w,d1
		addq.w	#1,d1
		swap	d1
		asr.l	#4,d1
		move.l	y_pos(a0),d2
		move.l	x_pos(a0),d3
		btst	#button_up,d4
		beq.s	loc_92B44
		sub.l	d1,d2
		moveq	#0,d0
		move.w	(Camera_min_Y_pos).w,d0
		swap	d0
		cmp.l	d0,d2
		bge.s	loc_92B44
		move.l	d0,d2

loc_92B44:
		btst	#button_down,d4
		beq.s	loc_92B5E
		add.l	d1,d2
		moveq	#0,d0
		move.w	(Camera_target_max_Y_pos).w,d0
		addi.w	#$DF,d0
		swap	d0
		cmp.l	d0,d2
		blt.s	loc_92B5E
		move.l	d0,d2

loc_92B5E:
		btst	#button_left,d4
		beq.s	loc_92B6A
		sub.l	d1,d3
		bcc.s	loc_92B6A
		moveq	#0,d3

loc_92B6A:
		btst	#button_right,d4
		beq.s	loc_92B72
		add.l	d1,d3

loc_92B72:
		move.l	d2,y_pos(a0)
		move.l	d3,x_pos(a0)

loc_92B7A:
		btst	#button_A,(Ctrl_1_held).w
		beq.s	loc_92BB2
		btst	#button_C,(Ctrl_1_pressed).w
		beq.s	loc_92B96
		subq.b	#1,(Debug_object).w
		bcc.s	loc_92BAE
		add.b	d6,(Debug_object).w
		bra.s	loc_92BAE
; ---------------------------------------------------------------------------

loc_92B96:
		btst	#button_A,(Ctrl_1_pressed).w
		beq.s	loc_92BB2
		addq.b	#1,(Debug_object).w
		cmp.b	(Debug_object).w,d6
		bhi.s	loc_92BAE
		move.b	#0,(Debug_object).w

loc_92BAE:
		bra.w	sub_92C88
; ---------------------------------------------------------------------------

loc_92BB2:
		btst	#button_C,(Ctrl_1_pressed).w
		beq.s	loc_92C0C
		jsr	(AllocateObject).l
		bne.s	loc_92C0C
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		move.b	render_flags(a0),render_flags(a1)
		move.b	render_flags(a0),status(a1)
		andi.b	#$7F,status(a1)
		moveq	#0,d0
		move.b	(Debug_object).w,d0
		add.w	d0,d0
		move.w	d0,d1
		lsl.w	#2,d0
		add.w	d1,d0
		move.b	4(a2,d0.w),subtype(a1)
		move.l	(a2,d0.w),(a1)
		move.b	#0,(a1)
		cmpi.l	#Obj_Monitor,(a1)
		bne.s	locret_92C0A
		move.b	#9,subtype(a1)

locret_92C0A:
		rts
; ---------------------------------------------------------------------------

loc_92C0C:
		btst	#button_B,(Ctrl_1_pressed).w
		beq.s	locret_92C52
		moveq	#0,d0
		move.w	d0,(Debug_placement_mode).w
		move	#$2700,sr
		jsr	(HUD_DrawInitial).l
		move.b	#1,(Update_HUD_score).w
		move.b	#$80,(Update_HUD_ring_count).w
		move	#$2300,sr
		lea	(Player_1).w,a1
		move.l	(Debug_saved_mappings).w,mappings(a1)
		move.w	(Debug_saved_art_tile).w,art_tile(a1)
		bsr.s	sub_92C54
		move.b	#$13,y_radius(a1)
		move.b	#9,x_radius(a1)

locret_92C52:
		rts
; End of function sub_92AD4


; =============== S U B R O U T I N E =======================================


sub_92C54:
		; Bug: this tries to clear the player's variables using d0, but d0 becomes
		; dirty after the HUD_DrawInitial call, which wasn't there in S3.
		; Miraculously, drawing the lives HUD sets d0 back to zero, but since that
		; part is skipped in Competition mode, exiting debug is broken there.
		move.b	d0,anim(a1)
		move.w	d0,x_pos+2(a1)
		move.w	d0,y_pos+2(a1)
		move.b	d0,object_control(a1)
		move.b	d0,spin_dash_flag(a1)
		move.w	d0,x_vel(a1)
		move.w	d0,y_vel(a1)
		move.w	d0,ground_vel(a1)
		andi.b	#1<<Status_Facing,status(a1)
		ori.b	#1<<Status_InAir,status(a1)
		move.b	#2,routine(a1)
		rts
; End of function sub_92C54


; =============== S U B R O U T I N E =======================================


sub_92C88:
		moveq	#0,d0
		move.b	(Debug_object).w,d0
		add.w	d0,d0
		move.w	d0,d1
		lsl.w	#2,d0
		add.w	d1,d0
		move.l	4(a2,d0.w),mappings(a0)
		move.w	8(a2,d0.w),art_tile(a0)
		move.b	(a2,d0.w),mapping_frame(a0)
		rts
; End of function sub_92C88

; ---------------------------------------------------------------------------
DebugOffs:
		include "Levels/Misc/Debug list pointers.asm"

Debug_AIZ1: dbglistheader
		include "Levels/AIZ/Debug/Act 1.asm"
Debug_AIZ1_End

Debug_AIZ2: dbglistheader
		include "Levels/AIZ/Debug/Act 2.asm"
Debug_AIZ2_End

Debug_HCZ: dbglistheader
		include "Levels/HCZ/Debug/Main.asm"
Debug_HCZ_End

Debug_MGZ: dbglistheader
		include "Levels/MGZ/Debug/Main.asm"
Debug_MGZ_End

Debug_CNZ: dbglistheader
		include "Levels/CNZ/Debug/Main.asm"
Debug_CNZ_End

Debug_FBZ1: dbglistheader
		include "Levels/FBZ/Debug/Act 1.asm"
Debug_FBZ1_End

Debug_FBZ2: dbglistheader
		include "Levels/FBZ/Debug/Act 2.asm"
Debug_FBZ2_End

Debug_ICZ1: dbglistheader
		include "Levels/ICZ/Debug/Act 1.asm"
Debug_ICZ1_End

Debug_ICZ2: dbglistheader
		include "Levels/ICZ/Debug/Act 2.asm"
Debug_ICZ2_End

Debug_LBZ1: dbglistheader
		include "Levels/LBZ/Debug/Act 1.asm"
Debug_LBZ1_End

Debug_LBZ2: dbglistheader
		include "Levels/LBZ/Debug/Act 2.asm"
Debug_LBZ2_End

Debug_MHZ: dbglistheader
		include "Levels/MHZ/Debug/Main.asm"
Debug_MHZ_End

Debug_SOZ1: dbglistheader
		include "Levels/SOZ/Debug/Act 1.asm"
Debug_SOZ1_End

Debug_SOZ2: dbglistheader
		include "Levels/SOZ/Debug/Act 2.asm"
Debug_SOZ2_End

Debug_LRZ1: dbglistheader
		include "Levels/LRZ/Debug/Act 1.asm"
Debug_LRZ1_End

Debug_LRZ2: dbglistheader
		include "Levels/LRZ/Debug/Act 2.asm"
Debug_LRZ2_End

Debug_SSZ: dbglistheader
		include "Levels/SSZ/Debug/Main.asm"
Debug_SSZ_End

Debug_DEZ1: dbglistheader
		include "Levels/DEZ/Debug/Act 1.asm"
Debug_DEZ1_End

Debug_DEZ2: dbglistheader
		include "Levels/DEZ/Debug/Act 2.asm"
Debug_DEZ2_End

Debug_DDZ1: dbglistheader
		include "Levels/DDZ/Debug/Main.asm"
Debug_DDZ1_End

Debug_DDZ2: dbglistheader
		include "Levels/DEZ/Debug/Boss.asm"
Debug_DDZ2_End

Debug_Ending: dbglistheader
		include "Levels/SSZ/Debug/Ending.asm"
Debug_Ending_End

Debug_ALZ: dbglistheader
		include "Levels/ALZ/Debug/Main.asm"
Debug_ALZ_End

Debug_BPZ: dbglistheader
		include "Levels/BPZ/Debug/Main.asm"
Debug_BPZ_End

Debug_DPZ: dbglistheader
		include "Levels/DPZ/Debug/Main.asm"
Debug_DPZ_End

Debug_CGZ: dbglistheader
		include "Levels/CGZ/Debug/Main.asm"
Debug_CGZ_End

Debug_EMZ: dbglistheader
		include "Levels/EMZ/Debug/Main.asm"
Debug_EMZ_End

Debug_Pachinko_Special: dbglistheader
		include "Levels/Pachinko/Debug/Main.asm"
Debug_Pachinko_Special_End

Debug_HPZ: dbglistheader
		include "Levels/HPZ/Debug/Main.asm"
Debug_HPZ_End

Debug_Gumball_Special: dbglistheader
		include "Levels/Gumball/Debug/Main.asm"
Debug_Gumball_Special_End

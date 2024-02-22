; =============== S U B R O U T I N E =======================================


Get_LevelSizeStart:
		clr.b	(Deform_lock).w
		clr.b	(_unkEE08).w
		clr.b	(Scroll_lock).w
		clr.b	(Scroll_lock_P2).w
		clr.b	(Fast_V_scroll_flag).w
		moveq	#0,d0
		move.b	d0,(Dynamic_resize_routine).w
		move.w	d0,(_unkF660).w
		move.w	d0,(_unkF662).w
		move.w	(Current_zone_and_act).w,d0
		ror.b	#1,d0
		lsr.w	#4,d0
		lea	LevelSizes(pc,d0.w),a0
		move.l	(a0)+,d0
		move.l	d0,(Camera_min_X_pos).w
		move.l	d0,(Camera_target_min_X_pos).w
		move.l	d0,(Camera_min_X_pos_P2).w
		move.l	(a0)+,d0
		move.l	d0,(Camera_min_Y_pos).w
		move.l	d0,(Camera_target_min_Y_pos).w
		move.l	d0,(Camera_min_Y_pos_P2).w
		move.w	#$60,(Distance_from_top).w
		move.w	#$60,(Distance_from_top_P2).w
		move.w	#-1,(Screen_X_wrap_value).w
		move.w	#-1,(Screen_Y_wrap_value).w
		bra.w	loc_1BE46
; ---------------------------------------------------------------------------
LevelSizes:	;     xstart    xend  ystart    yend	; Level
		dc.w   $1308,  $6000,      0,   $390	; AIZ1
		dc.w       0,  $4640,      0,   $590	; AIZ2
		dc.w       0,  $6000,      0,  $1000	; HCZ1
		dc.w       0,  $6000,      0,  $1000	; HCZ2
		dc.w       0,  $6000,  -$100,  $1000	; MGZ1
		dc.w       0,  $6000,      0,  $1000	; MGZ2
		dc.w       0,  $6000,      0,   $B20	; CNZ1
		dc.w       0,  $6000,   $580,  $1000	; CNZ2
		dc.w       0,  $2E60,      0,   $B00	; FBZ1
		dc.w       0,  $6000,      0,   $B00	; FBZ2
		dc.w       0,  $7000,  -$100,   $800	; ICZ1
		dc.w       0,  $7000,      0,   $B20	; ICZ2
		dc.w       0,  $6000,      0,  $1000	; LBZ1
		dc.w       0,  $6000,      0,   $B20	; LBZ2
		dc.w       0,  $4298,      0,   $AA0	; MHZ1
		dc.w     $98,  $3C90,   $620,   $9A0	; MHZ2
		dc.w       0,  $4310,      0,   $B20	; SOZ1
		dc.w       0,  $6000,  -$100,   $800	; SOZ2
		dc.w       0,  $2CC0,      0,   $B20	; LRZ1
		dc.w    $940,  $3EC0,      0,   $B20	; LRZ2
		dc.w       0,  $19A0,  -$100,  $1000	; SSZ1
		dc.w       0,  $6000,      0,   $400	; SSZ2
		dc.w       0,  $6000,      0,   $B20	; DEZ1
		dc.w       0,  $6000,      0,   $F10	; DEZ2
		dc.w       0,  $6000,      0,  $1000	; DDZ
		dc.w       0,  $6000,      0,  $1000	; DDZ
		dc.w       0,  $6000,      0,  $1000	; AIZ Intro (?)
		dc.w       0,  $6000,      0,  $1000	; Ending scene
		dc.w       0,  $12C0,   $100,   $190	; ALZ
		dc.w       0,  $12C0,   $100,   $190	; ALZ
		dc.w       0,  $12C0,   $200,   $390	; BPZ
		dc.w       0,  $12C0,   $200,   $390	; BPZ
		dc.w       0,  $12C0,   $100,   $190	; DPZ
		dc.w       0,  $12C0,   $100,   $190	; DPZ
		dc.w       0,  $12C0,  -$100,  $1000	; CGZ
		dc.w       0,  $12C0,      0,    $90	; CGZ
		dc.w       0,  $12C0,   $100,   $190	; EMZ
		dc.w       0,  $12C0,   $100,   $190	; EMZ
		dc.w     $60,    $60,      0,   $240	; Gumball
		dc.w     $60,    $60,      0,   $240	; Gumball
		dc.w       0,   $140,      0,   $F00	; Pachinko
		dc.w       0,   $140,      0,   $F00	; Pachinko
		dc.w       0,  $6000,      0,  $1000	; Slots
		dc.w       0,  $6000,      0,  $1000	; Slots
		dc.w       0,   $EC0,      0,   $430	; LRZ Boss
		dc.w       0,  $1880,      0,   $B20	; HPZ
		dc.w       0,  $6000,    $20,    $20	; DEZ Boss
		dc.w   $1500,  $1640,   $320,   $320	; Special Stage Arena (HPZ)
; ---------------------------------------------------------------------------

loc_1BE46:
		tst.b	(Last_star_post_hit).w
		beq.s	loc_1BE5E
		jsr	(Load_Starpost_Settings).l
		move.w	(Player_1+x_pos).w,d1
		move.w	(Player_1+y_pos).w,d0
		bra.w	loc_1BF74
; ---------------------------------------------------------------------------

loc_1BE5E:
		move.w	(Current_zone_and_act).w,d0
		ror.b	#1,d0
		lsr.w	#5,d0
		lea	(Sonic_Start_Locations).l,a1
		cmpi.w	#3,(Player_mode).w
		bne.s	loc_1BE7A
		lea	(Knux_Start_Locations).l,a1

loc_1BE7A:
		lea	(a1,d0.w),a1
		moveq	#0,d1
		move.w	(a1)+,d1
		move.w	d1,(Player_1+x_pos).w
		moveq	#0,d0
		move.w	(a1),d0
		move.w	d0,(Player_1+y_pos).w
		tst.b	(Last_star_post_hit).w
		bne.w	loc_1BF74
		cmpi.w	#0,(Current_zone_and_act).w
		bne.s	loc_1BEC6
		cmpi.w	#2,(Player_mode).w
		bhs.s	loc_1BEC6
		move.w	#$40,d1				; If in Angel Island Zone and playing as Sonic, the start position is overridden for the intro
		move.w	d1,(Player_1+x_pos).w
		move.w	#$420,d0
		move.w	d0,(Player_1+y_pos).w
		move.w	#0,d1
		move.w	d1,(Camera_min_X_pos).w
		move.w	d1,(Camera_target_min_X_pos).w
		move.w	d1,(Camera_min_X_pos_P2).w

loc_1BEC6:
		cmpi.w	#$500,(Current_zone_and_act).w
		bne.s	loc_1BF1E
		cmpi.w	#2,(Player_mode).w
		blo.s	loc_1BF1E
		bne.s	loc_1BF1E
		move.w	#$35A0,d1			; If in Ice Cap Act 1 and playing as Tails,
		move.w	d1,(Camera_min_X_pos).w	; we use a different start position and different level sizes
		move.w	d1,(Camera_target_min_X_pos).w	; to skip the snowboarding sequence
		move.w	d1,(Camera_min_X_pos_P2).w
		move.w	#$3780,d1
		move.w	d1,(Player_1+x_pos).w
		move.w	#$36F0,d1
		move.w	d1,(Camera_X_pos).w
		move.w	d1,(Camera_X_pos_P2).w
		move.w	#$1E0,d0
		move.w	d0,(Player_1+y_pos).w
		move.w	#$200,d0
		move.w	d0,(Camera_min_Y_pos).w
		move.w	d0,(Camera_target_min_Y_pos).w
		move.w	d0,(Camera_min_Y_pos_P2).w
		move.w	d0,(Camera_Y_pos).w
		move.w	d0,(Camera_Y_pos_P2).w
		rts
; ---------------------------------------------------------------------------

loc_1BF1E:
		cmpi.w	#$700,(Current_zone_and_act).w
		bne.s	loc_1BF48
		cmpi.w	#3,(Player_mode).w
		bhs.s	loc_1BF48
		tst.w	(SK_alone_flag).w
		bne.s	loc_1BF48
		move.w	#$C0,d2				; If playing as Sonic/Tails in MHZ 1 with Sonic 3 locked on, modify level size
		move.w	d2,(Camera_min_X_pos).w
		move.w	d2,(Camera_target_min_X_pos).w
		move.w	d2,(Camera_min_X_pos_P2).w
		move.w	#$160,d1

loc_1BF48:
		cmpi.w	#$1601,(Current_zone_and_act).w
		beq.s	loc_1BF70
		cmpi.w	#$B00,(Current_zone_and_act).w
		beq.s	loc_1BF70
		cmpi.w	#$900,(Current_zone_and_act).w
		beq.s	loc_1BF68
		cmpi.w	#$300,(Current_zone_and_act).w
		bne.s	loc_1BF74

loc_1BF68:
		cmpi.w	#3,(Player_mode).w
		bne.s	loc_1BF74

loc_1BF70:
		addi.w	#$B0,d1		; Only if in Hidden Palace, in Death Egg 1, in Lava Reef 1 as Knuckles, in Carnival Night 1 as Knuckles
							; This is likely for level intros that start behind the camera

loc_1BF74:
		subi.w	#$A0,d1
		bcc.s	loc_1BF7C
		moveq	#0,d1

loc_1BF7C:
		tst.w	(Competition_mode).w
		bne.s	loc_1BF8C
		move.w	(Camera_max_X_pos).w,d2
		cmp.w	d2,d1
		blo.s	loc_1BF8C
		move.w	d2,d1

loc_1BF8C:
		move.w	d1,(Camera_X_pos).w
		move.w	d1,(Camera_X_pos_P2).w
		subi.w	#$60,d0
		bcc.s	loc_1BF9C
		moveq	#0,d0

loc_1BF9C:
		cmp.w	(Camera_max_Y_pos).w,d0
		blt.s	loc_1BFA6
		move.w	(Camera_max_Y_pos).w,d0

loc_1BFA6:
		move.w	d0,(Camera_Y_pos).w
		move.w	d0,(Camera_Y_pos_P2).w
		rts
; End of function Get_LevelSizeStart


; =============== S U B R O U T I N E =======================================


DeformBgLayer:
		tst.b	(Deform_lock).w
		beq.s	loc_1BFB8
		rts
; ---------------------------------------------------------------------------

loc_1BFB8:
		clr.w	(Camera_RAM).w
		clr.w	(V_scroll_amount).w
		clr.w	(H_scroll_amount_P2).w
		clr.w	(V_scroll_amount_P2).w
		tst.w	(Competition_mode).w
		bne.w	loc_1C02C
		tst.b	(Scroll_lock).w
		bne.s	loc_1C028
		lea	(Player_1).w,a0
		tst.b	(Scroll_force_positions).w
		beq.s	loc_1BFF0
		move.b	#0,(Scroll_force_positions).w
		move.w	#0,(H_scroll_frame_offset).w
		lea	(Palette_frame_Tails).w,a0

loc_1BFF0:
		lea	(Camera_X_pos).w,a1
		lea	(Camera_min_X_pos).w,a2
		lea	(Camera_RAM).w,a4
		lea	(H_scroll_frame_offset).w,a5
		lea	(Pos_table).w,a6
		bsr.w	MoveCameraX
		lea	(Camera_Y_pos).w,a1
		lea	(Camera_min_X_pos).w,a2
		lea	(V_scroll_amount).w,a4
		move.w	(Distance_from_top).w,d3
		cmpi.w	#2,(Player_mode).w
		bne.s	loc_1C024
		move.w	(Distance_from_top_P2).w,d3

loc_1C024:
		bsr.w	MoveCameraY

loc_1C028:
		bra.w	Do_ResizeEvents
; ---------------------------------------------------------------------------

loc_1C02C:
		tst.b	(Scroll_lock).w
		bne.s	loc_1C06E
		lea	(Player_1).w,a0
		lea	(Camera_X_pos).w,a1
		lea	(Camera_min_X_pos).w,a2
		lea	(Camera_RAM).w,a4
		lea	(H_scroll_frame_offset).w,a5
		lea	(Pos_table).w,a6
		bsr.w	MoveCameraX_2P
		lea	(Camera_Y_pos).w,a1
		lea	(Camera_min_X_pos).w,a2
		lea	(V_scroll_amount).w,a4
		move.w	(Distance_from_top).w,d3
		cmpi.w	#2,(Player_mode).w
		bne.s	loc_1C06A
		move.w	(Distance_from_top_P2).w,d3

loc_1C06A:
		bsr.w	MoveCameraY

loc_1C06E:
		tst.b	(Scroll_lock_P2).w
		bne.s	loc_1C0A4
		lea	(Player_2).w,a0
		lea	(Camera_X_pos_P2).w,a1
		lea	(Camera_min_X_pos_P2).w,a2
		lea	(H_scroll_amount_P2).w,a4
		lea	(H_scroll_frame_offset_P2).w,a5
		lea	(Stat_table).w,a6
		bsr.w	MoveCameraX_2P
		lea	(Camera_Y_pos_P2).w,a1
		lea	(Camera_min_X_pos_P2).w,a2
		lea	(V_scroll_amount_P2).w,a4
		move.w	(Distance_from_top_P2).w,d3
		bsr.w	MoveCameraY

loc_1C0A4:
		bra.w	Do_ResizeEvents
; End of function DeformBgLayer


; =============== S U B R O U T I N E =======================================


MoveCameraX:
		move.w	(a1),d4
		tst.b	(Teleport_active_flag).w
		bne.s	locret_1C0E6
		move.w	(a5),d1
		beq.s	loc_1C0D2
		subi.w	#$100,d1
		move.w	d1,(a5)
		moveq	#0,d1
		move.b	(a5),d1
		lsl.b	#2,d1
		addq.b	#4,d1
		move.w	2(a5),d0
		sub.b	d1,d0
		move.w	(a6,d0.w),d0
		andi.w	#$7FFF,d0
		bra.s	loc_1C0D6
; ---------------------------------------------------------------------------

loc_1C0D2:
		move.w	x_pos(a0),d0

loc_1C0D6:
		sub.w	(a1),d0
		subi.w	#$90,d0
		blt.s	loc_1C0E8
		subi.w	#$10,d0
		bge.s	loc_1C0FC
		clr.w	(a4)

locret_1C0E6:
		rts
; ---------------------------------------------------------------------------

loc_1C0E8:
		cmpi.w	#-$18,d0
		bgt.s	loc_1C0F2
		move.w	#-$18,d0

loc_1C0F2:
		add.w	(a1),d0
		cmp.w	(a2),d0
		bgt.s	loc_1C112
		move.w	(a2),d0
		bra.s	loc_1C112
; ---------------------------------------------------------------------------

loc_1C0FC:
		cmpi.w	#$18,d0
		blo.s	loc_1C106
		move.w	#$18,d0

loc_1C106:
		add.w	(a1),d0
		cmp.w	2(a2),d0
		blt.s	loc_1C112
		move.w	2(a2),d0

loc_1C112:
		move.w	d0,d1
		sub.w	(a1),d1
		asl.w	#8,d1
		move.w	d0,(a1)
		move.w	d1,(a4)
		rts
; End of function MoveCameraX


; =============== S U B R O U T I N E =======================================


MoveCameraY:
		moveq	#0,d1
		move.w	y_pos(a0),d0
		sub.w	(a1),d0
		cmpi.w	#-$100,(Camera_min_Y_pos).w
		bne.s	loc_1C132
		and.w	(Screen_Y_wrap_value).w,d0

loc_1C132:
		btst	#Status_Roll,status(a0)
		beq.s	loc_1C13C
		subq.w	#5,d0

loc_1C13C:
		move.w	d3,d1
		tst.w	(Competition_mode).w
		beq.s	loc_1C146
		lsr.w	#1,d1

loc_1C146:
		btst	#Status_InAir,status(a0)
		beq.s	loc_1C164
		addi.w	#$20,d0
		sub.w	d1,d0
		bcs.s	loc_1C1B0
		subi.w	#$40,d0
		bcc.s	loc_1C1B0
		tst.b	(Camera_max_Y_pos_changing).w
		bne.s	loc_1C1C2
		bra.s	loc_1C16E
; ---------------------------------------------------------------------------

loc_1C164:
		sub.w	d1,d0
		bne.s	loc_1C172
		tst.b	(Camera_max_Y_pos_changing).w
		bne.s	loc_1C1C2

loc_1C16E:
		clr.w	(a4)
		rts
; ---------------------------------------------------------------------------

loc_1C172:
		cmpi.w	#$60,d3
		bne.s	loc_1C19E
		tst.b	(Fast_V_scroll_flag).w
		bne.s	loc_1C1B0
		move.w	ground_vel(a0),d1
		bpl.s	loc_1C186
		neg.w	d1

loc_1C186:
		cmpi.w	#$800,d1
		bhs.s	loc_1C1B0
		move.w	#$600,d1
		cmpi.w	#6,d0
		bgt.s	loc_1C1FA
		cmpi.w	#-6,d0
		blt.s	loc_1C1D8
		bra.s	loc_1C1C8
; ---------------------------------------------------------------------------

loc_1C19E:
		move.w	#$200,d1
		cmpi.w	#2,d0
		bgt.s	loc_1C1FA
		cmpi.w	#-2,d0
		blt.s	loc_1C1D8
		bra.s	loc_1C1C8
; ---------------------------------------------------------------------------

loc_1C1B0:
		move.w	#$1800,d1
		cmpi.w	#$18,d0
		bgt.s	loc_1C1FA
		cmpi.w	#-$18,d0
		blt.s	loc_1C1D8
		bra.s	loc_1C1C8
; ---------------------------------------------------------------------------

loc_1C1C2:
		moveq	#0,d0
		move.b	d0,(Camera_max_Y_pos_changing).w

loc_1C1C8:
		moveq	#0,d1
		move.w	d0,d1
		add.w	(a1),d1
		tst.w	d0
		bpl.w	loc_1C202
		bra.w	loc_1C1E2
; ---------------------------------------------------------------------------

loc_1C1D8:
		neg.w	d1
		ext.l	d1
		asl.l	#8,d1
		add.l	(a1),d1
		swap	d1

loc_1C1E2:
		cmp.w	4(a2),d1
		bgt.s	loc_1C21A
		cmpi.w	#-$100,d1
		bgt.s	loc_1C1F4
		and.w	(Screen_Y_wrap_value).w,d1
		bra.s	loc_1C21A
; ---------------------------------------------------------------------------

loc_1C1F4:
		move.w	4(a2),d1
		bra.s	loc_1C21A
; ---------------------------------------------------------------------------

loc_1C1FA:
		ext.l	d1
		asl.l	#8,d1
		add.l	(a1),d1
		swap	d1

loc_1C202:
		cmp.w	6(a2),d1
		blt.s	loc_1C21A
		move.w	(Screen_Y_wrap_value).w,d3
		addq.w	#1,d3
		sub.w	d3,d1
		bcs.s	loc_1C216
		sub.w	d3,(a1)
		bra.s	loc_1C21A
; ---------------------------------------------------------------------------

loc_1C216:
		move.w	6(a2),d1

loc_1C21A:
		move.w	(a1),d4
		swap	d1
		move.l	d1,d3
		sub.l	(a1),d3
		ror.l	#8,d3
		move.w	d3,(a4)
		move.l	d1,(a1)
		tst.w	(Competition_mode).w
		beq.s	locret_1C236
		swap	d1
		and.w	(Screen_Y_wrap_value).w,d1
		move.w	d1,(a1)

locret_1C236:
		rts
; End of function MoveCameraY


; =============== S U B R O U T I N E =======================================


MoveCameraX_2P:
		move.w	(a1),d4
		tst.b	(Teleport_active_flag).w
		bne.s	locret_1C27C
		move.w	(a5),d1
		beq.s	loc_1C262
		subi.w	#$100,d1
		move.w	d1,(a5)
		moveq	#0,d1
		move.b	(a5),d1
		lsl.b	#2,d1
		addq.b	#4,d1
		move.w	2(a5),d0
		sub.b	d1,d0
		move.w	(a6,d0.w),d0
		andi.w	#$7FFF,d0
		bra.s	loc_1C266
; ---------------------------------------------------------------------------

loc_1C262:
		move.w	x_pos(a0),d0

loc_1C266:
		move.w	(Screen_X_wrap_value).w,d2
		sub.w	(a1),d0
		and.w	d2,d0
		subi.w	#$90,d0
		blt.s	loc_1C27E
		subi.w	#$10,d0
		bge.s	loc_1C28C
		clr.w	(a4)

locret_1C27C:
		rts
; ---------------------------------------------------------------------------

loc_1C27E:
		cmpi.w	#-$10,d0
		bgt.s	loc_1C288
		move.w	#-$10,d0

loc_1C288:
		add.w	(a1),d0
		bra.s	loc_1C298
; ---------------------------------------------------------------------------

loc_1C28C:
		cmpi.w	#$10,d0
		blo.s	loc_1C296
		move.w	#$10,d0

loc_1C296:
		add.w	(a1),d0

loc_1C298:
		move.w	d0,d1
		sub.w	(a1),d1
		asl.w	#8,d1
		and.w	d2,d0
		addi.w	#$400,d0
		move.w	d0,(a1)
		move.w	d1,(a4)
		rts
; End of function MoveCameraX_2P


; =============== S U B R O U T I N E =======================================


j_LevelSetup:
		jmp	(LevelSetup).l
; End of function j_LevelSetup


; =============== S U B R O U T I N E =======================================


LoadLevelLoadBlock2:
		move.w	(Current_zone_and_act).w,d0
		bne.s	loc_1C2C8
		cmpi.w	#2,(Player_mode).w
		bhs.s	loc_1C2C4
		tst.b	(Last_star_post_hit).w
		beq.s	loc_1C2C8

loc_1C2C4:
		move.w	#$D00,d0

loc_1C2C8:
		ror.b	#1,d0
		lsr.w	#4,d0
		andi.w	#$1F8,d0
		move.w	d0,d1
		add.w	d0,d0
		add.w	d1,d0
		lea	(LevelLoadBlock).l,a2
		lea	(a2,d0.w),a2
		move.l	a2,-(sp)
		addq.w	#8,a2
		move.l	(a2)+,d0
		andi.l	#$FFFFFF,d0
		move.l	d0,d7
		movea.l	d0,a0
		lea	(Block_table).w,a1
		jsr	(Kos_Decomp).l
		move.l	(a2)+,d0
		andi.l	#$FFFFFF,d0
		cmp.l	d0,d7
		beq.s	loc_1C30E
		movea.l	d0,a0
		jsr	(Kos_Decomp).l

loc_1C30E:
		move.l	(a2)+,d0
		andi.l	#$FFFFFF,d0
		move.l	d0,d7
		movea.l	d0,a0
		lea	(RAM_start).l,a1
		jsr	(Kos_Decomp).l
		move.l	(a2)+,d0
		andi.l	#$FFFFFF,d0
		cmp.l	d0,d7
		beq.s	loc_1C33A
		movea.l	d0,a0
		jsr	(Kos_Decomp).l

loc_1C33A:
		bsr.w	Load_Level
		movea.l	(sp)+,a2
		move.b	(a2),d1
		addq.w	#4,a2
		moveq	#0,d0
		move.b	(a2),d0
		beq.s	loc_1C354
		cmp.b	d0,d1
		beq.s	loc_1C354
		jsr	(Load_PLC).l

loc_1C354:
		addq.w	#4,a2
		moveq	#0,d0
		move.b	(a2),d0
		jsr	(LoadPalette).l
		rts
; End of function LoadLevelLoadBlock2


; =============== S U B R O U T I N E =======================================


Load_Level:
		moveq	#0,d0
		move.w	(Current_zone_and_act).w,d0
		ror.b	#1,d0
		lsr.w	#5,d0
		andi.w	#$FC,d0
		lea	(LevelPtrs).l,a0
		movea.l	(a0,d0.w),a0
		lea	(Level_layout_header).w,a1
		move.w	#bytesToWcnt($1000),d2

.loop:
		move.w	(a0)+,(a1)+
		dbf	d2,.loop
		rts
; End of function Load_Level

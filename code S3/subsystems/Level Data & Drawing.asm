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
		bra.w	loc_1A374
; ---------------------------------------------------------------------------
LevelSizes:	;     xstart    xend  ystart    yend	; Level
		dc.w   $1308,  $6000,      0,   $390	; AIZ1
		dc.w       0,  $4640,      0,   $590	; AIZ2
		dc.w       0,  $6000,      0,  $1000	; HCZ1
		dc.w       0,  $6000,      0,  $1000	; HCZ2
		dc.w       0,  $6000,  -$100,  $1000	; MGZ1
		dc.w       0,  $6000,      0,  $1000	; MGZ2
		dc.w       0,  $6000,      0,   $B20	; CNZ1
		dc.w       0,  $6000,      0,  $1000	; CNZ2
		dc.w       0,  $6000,      0,  $1000	; FBZ1
		dc.w       0,  $6000,      0,  $1000	; FBZ2
		dc.w       0,  $7000,  -$100,   $800	; ICZ1
		dc.w       0,  $7000,      0,   $B20	; ICZ2
		dc.w       0,  $6000,      0,  $1000	; LBZ1
		dc.w       0,  $6000,      0,  $1000	; LBZ2
		dc.w       0,  $6000,      0,  $1000	; MHZ1
		dc.w       0,  $6000,      0,  $1000	; MHZ2
		dc.w       0,  $6000,      0,  $1000	; SOZ1
		dc.w       0,  $6000,      0,  $1000	; SOZ2
		dc.w       0,  $6000,      0,  $1000	; LRZ1
		dc.w       0,  $6000,      0,  $1000	; LRZ2
		dc.w       0,  $6000,      0,  $1000	; SSZ1
		dc.w       0,  $6000,      0,  $1000	; SSZ2
		dc.w       0,  $6000,      0,  $1000	; DEZ1
		dc.w       0,  $6000,      0,  $1000	; DEZ2
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
		dc.w       0,  $6000,      0,  $1000	; Pachinko
		dc.w       0,  $6000,      0,  $1000	; Pachinko
		dc.w       0,  $6000,      0,  $1000	; Slots
		dc.w       0,  $6000,      0,  $1000	; Slots
		dc.w       0,  $6000,      0,  $1000	; LRZ Boss
		dc.w       0,  $6000,      0,  $1000	; HPZ
		dc.w       0,  $6000,      0,  $1000	; DEZ Boss
		dc.w       0,  $6000,      0,  $1000	; Special Stage Arena (HPZ)
; ---------------------------------------------------------------------------

loc_1A374:
		tst.b	(Last_star_post_hit).w
		beq.s	loc_1A38C
		jsr	(Load_Starpost_Settings).l
		move.w	(Player_1+x_pos).w,d1
		move.w	(Player_1+y_pos).w,d0
		bra.w	loc_1A43C
; ---------------------------------------------------------------------------

loc_1A38C:
		move.w	(Current_zone_and_act).w,d0
		ror.b	#1,d0
		lsr.w	#5,d0
		lea	(Start_Locations).l,a1
		lea	(a1,d0.w),a1
		moveq	#0,d1
		move.w	(a1)+,d1
		move.w	d1,(Player_1+x_pos).w
		moveq	#0,d0
		move.w	(a1),d0
		move.w	d0,(Player_1+y_pos).w
		tst.b	(Last_star_post_hit).w
		bne.w	loc_1A43C
		cmpi.w	#0,(Current_zone_and_act).w
		bne.s	loc_1A3E6
		cmpi.w	#2,(Player_mode).w
		bhs.s	loc_1A3E6
		move.w	#$40,d1				; If in Angel Island Zone and playing as Sonic, the start position is overridden for the intro
		move.w	d1,(Player_1+x_pos).w
		move.w	#$420,d0
		move.w	d0,(Player_1+y_pos).w
		move.w	#0,d1
		move.w	d1,(Camera_min_X_pos).w
		move.w	d1,(Camera_target_min_X_pos).w
		move.w	d1,(Camera_min_X_pos_P2).w

loc_1A3E6:
		cmpi.w	#$500,(Current_zone_and_act).w
		bne.s	loc_1A43C
		cmpi.w	#2,(Player_mode).w
		blo.s	loc_1A43C
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

loc_1A43C:
		subi.w	#$A0,d1
		bcc.s	loc_1A444
		moveq	#0,d1

loc_1A444:
		tst.w	(Competition_mode).w
		bne.s	loc_1A454
		move.w	(Camera_max_X_pos).w,d2
		cmp.w	d2,d1
		blo.s	loc_1A454
		move.w	d2,d1

loc_1A454:
		move.w	d1,(Camera_X_pos).w
		move.w	d1,(Camera_X_pos_P2).w
		subi.w	#$60,d0
		bcc.s	loc_1A464
		moveq	#0,d0

loc_1A464:
		cmp.w	(Camera_max_Y_pos).w,d0
		blt.s	loc_1A46E
		move.w	(Camera_max_Y_pos).w,d0

loc_1A46E:
		move.w	d0,(Camera_Y_pos).w
		move.w	d0,(Camera_Y_pos_P2).w
		rts
; End of function Get_LevelSizeStart


; =============== S U B R O U T I N E =======================================


DeformBgLayer:
		tst.b	(Deform_lock).w
		beq.s	loc_1A480
		rts
; ---------------------------------------------------------------------------

loc_1A480:
		clr.w	(Camera_RAM).w
		clr.w	(V_scroll_amount).w
		clr.w	(H_scroll_amount_P2).w
		clr.w	(V_scroll_amount_P2).w
		tst.w	(Competition_mode).w
		bne.w	loc_1A4DE
		tst.b	(Scroll_lock).w
		bne.s	loc_1A4DA
		lea	(Player_1).w,a0
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
		bne.s	loc_1A4D6
		move.w	(Distance_from_top_P2).w,d3

loc_1A4D6:
		bsr.w	MoveCameraY

loc_1A4DA:
		bra.w	Do_ResizeEvents
; ---------------------------------------------------------------------------

loc_1A4DE:
		tst.b	(Scroll_lock).w
		bne.s	loc_1A520
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
		bne.s	loc_1A51C
		move.w	(Distance_from_top_P2).w,d3

loc_1A51C:
		bsr.w	MoveCameraY

loc_1A520:
		tst.b	(Scroll_lock_P2).w
		bne.s	loc_1A556
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

loc_1A556:
		bra.w	Do_ResizeEvents
; End of function DeformBgLayer


; =============== S U B R O U T I N E =======================================


MoveCameraX:
		move.w	(a1),d4
		tst.b	(Teleport_active_flag).w
		bne.s	locret_1A598
		move.w	(a5),d1
		beq.s	loc_1A584
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
		bra.s	loc_1A588
; ---------------------------------------------------------------------------

loc_1A584:
		move.w	x_pos(a0),d0

loc_1A588:
		sub.w	(a1),d0
		subi.w	#$90,d0
		blt.s	loc_1A59A
		subi.w	#$10,d0
		bge.s	loc_1A5AE
		clr.w	(a4)

locret_1A598:
		rts
; ---------------------------------------------------------------------------

loc_1A59A:
		cmpi.w	#-$18,d0
		bgt.s	loc_1A5A4
		move.w	#-$18,d0

loc_1A5A4:
		add.w	(a1),d0
		cmp.w	(a2),d0
		bgt.s	loc_1A5C4
		move.w	(a2),d0
		bra.s	loc_1A5C4
; ---------------------------------------------------------------------------

loc_1A5AE:
		cmpi.w	#$18,d0
		blo.s	loc_1A5B8
		move.w	#$18,d0

loc_1A5B8:
		add.w	(a1),d0
		cmp.w	2(a2),d0
		blt.s	loc_1A5C4
		move.w	2(a2),d0

loc_1A5C4:
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
		bne.s	loc_1A5E4
		and.w	(Screen_Y_wrap_value).w,d0

loc_1A5E4:
		btst	#Status_Roll,status(a0)
		beq.s	loc_1A5EE
		subq.w	#5,d0

loc_1A5EE:
		move.w	d3,d1
		tst.w	(Competition_mode).w
		beq.s	loc_1A5F8
		lsr.w	#1,d1

loc_1A5F8:
		btst	#Status_InAir,status(a0)
		beq.s	loc_1A616
		addi.w	#$20,d0
		sub.w	d1,d0
		bcs.s	loc_1A662
		subi.w	#$40,d0
		bcc.s	loc_1A662
		tst.b	(Camera_max_Y_pos_changing).w
		bne.s	loc_1A674
		bra.s	loc_1A620
; ---------------------------------------------------------------------------

loc_1A616:
		sub.w	d1,d0
		bne.s	loc_1A624
		tst.b	(Camera_max_Y_pos_changing).w
		bne.s	loc_1A674

loc_1A620:
		clr.w	(a4)
		rts
; ---------------------------------------------------------------------------

loc_1A624:
		cmpi.w	#$60,d3
		bne.s	loc_1A650
		tst.b	(Fast_V_scroll_flag).w
		bne.s	loc_1A662
		move.w	ground_vel(a0),d1
		bpl.s	loc_1A638
		neg.w	d1

loc_1A638:
		cmpi.w	#$800,d1
		bhs.s	loc_1A662
		move.w	#$600,d1
		cmpi.w	#6,d0
		bgt.s	loc_1A6AC
		cmpi.w	#-6,d0
		blt.s	loc_1A68A
		bra.s	loc_1A67A
; ---------------------------------------------------------------------------

loc_1A650:
		move.w	#$200,d1
		cmpi.w	#2,d0
		bgt.s	loc_1A6AC
		cmpi.w	#-2,d0
		blt.s	loc_1A68A
		bra.s	loc_1A67A
; ---------------------------------------------------------------------------

loc_1A662:
		move.w	#$1800,d1
		cmpi.w	#$18,d0
		bgt.s	loc_1A6AC
		cmpi.w	#-$18,d0
		blt.s	loc_1A68A
		bra.s	loc_1A67A
; ---------------------------------------------------------------------------

loc_1A674:
		moveq	#0,d0
		move.b	d0,(Camera_max_Y_pos_changing).w

loc_1A67A:
		moveq	#0,d1
		move.w	d0,d1
		add.w	(a1),d1
		tst.w	d0
		bpl.w	loc_1A6B4
		bra.w	loc_1A694
; ---------------------------------------------------------------------------

loc_1A68A:
		neg.w	d1
		ext.l	d1
		asl.l	#8,d1
		add.l	(a1),d1
		swap	d1

loc_1A694:
		cmp.w	4(a2),d1
		bgt.s	loc_1A6CC
		cmpi.w	#-$100,d1
		bgt.s	loc_1A6A6
		and.w	(Screen_Y_wrap_value).w,d1
		bra.s	loc_1A6CC
; ---------------------------------------------------------------------------

loc_1A6A6:
		move.w	4(a2),d1
		bra.s	loc_1A6CC
; ---------------------------------------------------------------------------

loc_1A6AC:
		ext.l	d1
		asl.l	#8,d1
		add.l	(a1),d1
		swap	d1

loc_1A6B4:
		cmp.w	6(a2),d1
		blt.s	loc_1A6CC
		move.w	(Screen_Y_wrap_value).w,d3
		addq.w	#1,d3
		sub.w	d3,d1
		bcs.s	loc_1A6C8
		sub.w	d3,(a1)
		bra.s	loc_1A6CC
; ---------------------------------------------------------------------------

loc_1A6C8:
		move.w	6(a2),d1

loc_1A6CC:
		move.w	(a1),d4
		swap	d1
		move.l	d1,d3
		sub.l	(a1),d3
		ror.l	#8,d3
		move.w	d3,(a4)
		move.l	d1,(a1)
		tst.w	(Competition_mode).w
		beq.s	locret_1A6E8
		swap	d1
		and.w	(Screen_Y_wrap_value).w,d1
		move.w	d1,(a1)

locret_1A6E8:
		rts
; End of function MoveCameraY


; =============== S U B R O U T I N E =======================================


MoveCameraX_2P:
		move.w	(a1),d4
		tst.b	(Teleport_active_flag).w
		bne.s	locret_1A72E
		move.w	(a5),d1
		beq.s	loc_1A714
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
		bra.s	loc_1A718
; ---------------------------------------------------------------------------

loc_1A714:
		move.w	x_pos(a0),d0

loc_1A718:
		move.w	(Screen_X_wrap_value).w,d2
		sub.w	(a1),d0
		and.w	d2,d0
		subi.w	#$90,d0
		blt.s	loc_1A730
		subi.w	#$10,d0
		bge.s	loc_1A73E
		clr.w	(a4)

locret_1A72E:
		rts
; ---------------------------------------------------------------------------

loc_1A730:
		cmpi.w	#-$10,d0
		bgt.s	loc_1A73A
		move.w	#-$10,d0

loc_1A73A:
		add.w	(a1),d0
		bra.s	loc_1A74A
; ---------------------------------------------------------------------------

loc_1A73E:
		cmpi.w	#$10,d0
		blo.s	loc_1A748
		move.w	#$10,d0

loc_1A748:
		add.w	(a1),d0

loc_1A74A:
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
		bne.s	loc_1A77A
		cmpi.w	#2,(Player_mode).w
		beq.s	loc_1A776
		tst.b	(Last_star_post_hit).w
		beq.s	loc_1A77A

loc_1A776:
		move.w	#$D00,d0

loc_1A77A:
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
		beq.s	loc_1A7C0
		movea.l	d0,a0
		jsr	(Kos_Decomp).l

loc_1A7C0:
		move.l	(a2)+,d0
		andi.l	#$FFFFFF,d0
		move.l	d0,d7
		movea.l	d0,a0
		lea	(RAM_start).l,a1
		jsr	(Kos_Decomp).l
		move.l	(a2)+,d0
		andi.l	#$FFFFFF,d0
		cmp.l	d0,d7
		beq.s	loc_1A7EC
		movea.l	d0,a0
		jsr	(Kos_Decomp).l

loc_1A7EC:
		bsr.w	Load_Level
		movea.l	(sp)+,a2
		move.b	(a2),d1
		addq.w	#4,a2
		moveq	#0,d0
		move.b	(a2),d0
		beq.s	loc_1A806
		cmp.b	d0,d1
		beq.s	loc_1A806
		jsr	(Load_PLC).l

loc_1A806:
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

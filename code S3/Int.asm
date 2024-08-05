; ---------------------------------------------------------------------------
; Vertical interrupt handler
; ---------------------------------------------------------------------------

VInt:
		nop
		movem.l	d0-a6,-(sp)
		tst.b	(V_int_routine).w
		beq.w	VInt_0.Main

- ;loc_810:
		move.w	(VDP_control_port).l,d0
		andi.w	#8,d0
		beq.s	- ;loc_810	; wait until vertical blanking is taking place

		move.l	#vdpComm($0000,VSRAM,WRITE),(VDP_control_port).l
		move.l	(V_scroll_value).w,(VDP_data_port).l
		btst	#6,(Graphics_flags).w
		beq.s	+ ;loc_83E	; branch if it's not a PAL system
		move.w	#$700,d0
		dbf	d0,*	; otherwise, waste a bit of time here

+ ;loc_83E:
		move.b	(V_int_routine).w,d0
		move.b	#0,(V_int_routine).w
		move.w	#1,(H_int_flag).w		; Allow H Interrupt code to run
		andi.w	#$3E,d0
		move.w	.Table(pc,d0.w),d0
		jsr	.Table(pc,d0.w)

.Done:
		addq.l	#1,(V_int_run_count).w
		movem.l	(sp)+,d0-a6
		rte
; ---------------------------------------------------------------------------
.Table:
		dc.w VInt_0-.Table
		dc.w VInt_2-.Table
		dc.w VInt_4-.Table
		dc.w VInt_6-.Table
		dc.w VInt_8-.Table
		dc.w VInt_A_C-.Table
		dc.w VInt_A_C-.Table
		dc.w VInt_E-.Table
		dc.w VInt_10-.Table
		dc.w VInt_12-.Table
		dc.w VInt_14-.Table
		dc.w VInt_16-.Table
		dc.w VInt_18-.Table
		dc.w VInt_1A-.Table
		dc.w VInt_1C-.Table
		dc.w VInt_1E-.Table
; ---------------------------------------------------------------------------

VInt_0:
		addq.w	#4,sp

.Main:
		addq.w	#1,(Lag_frame_count).w

		; branch if a level or demo is running
		cmpi.b	#$88,(Game_mode).w
		beq.s	+ ;.Level
		cmpi.b	#$8C,(Game_mode).w
		beq.s	+ ;.Level
		cmpi.b	#8,(Game_mode).w
		beq.s	+ ;.Level
		cmpi.b	#$C,(Game_mode).w
		beq.s	+ ;.Level
		stopZ80
		bsr.w	sndDriverInput
		startZ80
		bra.s	VInt.Done	; otherwise, return from V-int
; ---------------------------------------------------------------------------

+ ;.Level:
		tst.b	(Water_flag).w
		beq.w	.NoWater
		move.w	(VDP_control_port).l,d0
		btst	#6,(Graphics_flags).w
		beq.s	+	; branch if it isn't a PAL system
		move.w	#$700,d0
		dbf	d0,*	; otherwise waste a bit of time here

+
		move.w	#1,(H_int_flag).w
		stopZ80
		tst.b	(Water_full_screen_flag).w
		bne.s	+ ;.FullyUnderwater
		dma68kToVDP Normal_palette,$0000,$80,CRAM
		bra.s	++ ;.Water_Cont
; ---------------------------------------------------------------------------

+ ;.FullyUnderwater:
		dma68kToVDP Water_palette,$0000,$80,CRAM

+ ;.Water_Cont:
		move.w	(H_int_counter_command).w,(a5)
		bsr.w	sndDriverInput
		startZ80
		bra.w	VInt.Done
; ---------------------------------------------------------------------------

.NoWater:
		move.w	(VDP_control_port).l,d0
		btst	#6,(Graphics_flags).w
		beq.s	+	; branch if it isn't a PAL system
		move.w	#$700,d0
		dbf	d0,*	; otherwise, waste a bit of time here

+
		move.w	#1,(H_int_flag).w
		move.w	(H_int_counter_command).w,(VDP_control_port).l
		stopZ80

		; In Competition Mode, we have to update the sprite table
		; even during a lag frame so that the top half of the screen
		; shows the correct sprites.
		tst.w	(Competition_mode).w
		beq.s	.Done

		; Update V-Scroll.
		move.l	#vdpComm($0000,VSRAM,WRITE),(VDP_control_port).l
		move.l	(V_scroll_value).w,(VDP_data_port).l

		; Unlike in Sonic 2, the sprite tables are page-flipped in two-player mode.
		; This fixes a race-condition where incomplete sprite tables can be uploaded
		; to the VDP on lag frames, causing corrupted sprites to appear.

		; Upload the front buffer.
		tst.w	(Current_sprite_table_page).w
		beq.s	+
		dma68kToVDP Sprite_table,$F800,$280,VRAM
		bra.s	.Done

+
		dma68kToVDP Sprite_table_alternate,$F800,$280,VRAM

.Done:
		bsr.w	sndDriverInput
		startZ80
		bra.w	VInt.Done
; ---------------------------------------------------------------------------

VInt_2:
		bsr.w	Do_ControllerPal
		dma68kToVDP H_scroll_buffer,$F000,$380,VRAM
		jsr	(SegaScr_VInt).l
		tst.w	(Demo_timer).w
		beq.w	.locret_A4C
		subq.w	#1,(Demo_timer).w

.locret_A4C:
		rts
; ---------------------------------------------------------------------------

VInt_14:
		move.b	(V_int_run_count+3).w,d0
		andi.w	#$F,d0
		bne.s	+ ;loc_A76	; run the following code once every 16 frames

		stopZ80
		bsr.w	Poll_Controllers
		startZ80

+ ;loc_A76:
		tst.w	(Demo_timer).w
		beq.w	.locret_A82
		subq.w	#1,(Demo_timer).w

.locret_A82:
		rts
; ---------------------------------------------------------------------------

VInt_4:
		bsr.w	TitleAnim_FlipBuffer
		bsr.w	Do_ControllerPal
		move.w	(Ctrl_1).w,(Ctrl_1_title).w
		bsr.w	Process_Nem_Queue
		tst.w	(Demo_timer).w
		beq.w	.locret_AA2
		subq.w	#1,(Demo_timer).w

.locret_AA2:
		rts
; ---------------------------------------------------------------------------

VInt_6:
		bsr.w	Do_ControllerPal
		rts
; ---------------------------------------------------------------------------

VInt_10:
		cmpi.b	#$34,(Game_mode).w
		beq.w	VInt_1C		; If in a special stage, branch

VInt_8:
		stopZ80
		bsr.w	Poll_Controllers

;.NoFlash:
		tst.b	(Water_full_screen_flag).w
		bne.s	+
		dma68kToVDP Normal_palette,$0000,$80,CRAM
		bra.s	++

+
		dma68kToVDP Water_palette,$0000,$80,CRAM

+
		move.w	(H_int_counter_command).w,(a5)

;.Cont:
		dma68kToVDP H_scroll_buffer,$F000,$380,VRAM

		tst.w	(Competition_mode).w
		beq.s	++
		; Unlike in Sonic 2, the sprite tables are page-flipped in two-player mode.
		; This fixes a race-condition where incomplete sprite tables can be uploaded
		; to the VDP on lag frames, causing corrupted sprites to appear.

		; Perform page-flipping.
		tst.w	(Sprite_table_page_flip_pending).w
		beq.s	+
		clr.w	(Sprite_table_page_flip_pending).w
		eori.w	#$FFFF,(Current_sprite_table_page).w	; a not.w would've accomplished the same thing ...

+
		; Upload the front buffer.
		tst.w	(Current_sprite_table_page).w
		bne.s	+
		dma68kToVDP Sprite_table_alternate,$F800,$280,VRAM
		bra.s	++

+
		dma68kToVDP Sprite_table,$F800,$280,VRAM

+
		bsr.w	Process_DMA_Queue
		move.l	(V_scroll_value_P2).w,(V_scroll_value_P2_copy).w
		jsr	(SpecialVInt_Function).l
		jsr	(VInt_DrawLevel).l
		bsr.w	sndDriverInput
		startZ80
		move	#$2300,sr
		tst.b	(Water_flag).w
		beq.s	+
		cmpi.b	#92,(H_int_counter).w	; is H-int occuring on or below line 92?
		bhs.s	+	; if it is, branch
		move.b	#1,(Do_Updates_in_H_int).w
		jmp	(Set_Kos_Bookmark).l

+
		bsr.s	Do_Updates
		jmp	(Set_Kos_Bookmark).l

; =============== S U B R O U T I N E =======================================


Do_Updates:
		jsr	(UpdateHUD).l
		move.w	#0,(Lag_frame_count).w
		bsr.w	Process_Nem_Queue_2
		tst.w	(Demo_timer).w
		beq.w	.locret_C0C
		subq.w	#1,(Demo_timer).w

.locret_C0C:
		rts
; End of function Do_Updates

; ---------------------------------------------------------------------------

VInt_A_C:
		stopZ80
		bsr.w	Poll_Controllers
		tst.b	(Water_full_screen_flag).w
		bne.s	+
		dma68kToVDP Normal_palette,$0000,$80,CRAM
		bra.s	++

+
		dma68kToVDP Water_palette,$0000,$80,CRAM

+
		move.w	(H_int_counter_command).w,(a5)
		dma68kToVDP H_scroll_buffer,$F000,$380,VRAM

		tst.w	(Competition_mode).w
		beq.s	++
		; Unlike in Sonic 2, the sprite tables are page-flipped in two-player mode.
		; This fixes a race-condition where incomplete sprite tables can be uploaded
		; to the VDP on lag frames, causing corrupted sprites to appear.

		; Perform page-flipping.
		tst.w	(Sprite_table_page_flip_pending).w
		beq.s	+
		clr.w	(Sprite_table_page_flip_pending).w
		eori.w	#$FFFF,(Current_sprite_table_page).w	; a not.w would've accomplished the same thing...

+
		; Upload the front buffer.
		tst.w	(Current_sprite_table_page).w
		bne.s	+
		dma68kToVDP Sprite_table_alternate,$F800,$280,VRAM
		bra.s	++

+
		dma68kToVDP Sprite_table,$F800,$280,VRAM

+
		bsr.w	Process_DMA_Queue
		move.l	(V_scroll_value_P2).w,(V_scroll_value_P2_copy).w
		jsr	(sndDriverInput).l
		startZ80
		bsr.w	Process_Nem_Queue
		jmp	(Set_Kos_Bookmark).l
; ---------------------------------------------------------------------------

VInt_E:
		bsr.w	Do_ControllerPal
		move.b	#$E,(V_int_routine).w
		rts
; ---------------------------------------------------------------------------

VInt_12:
		bsr.w	Do_ControllerPal
		move.w	(H_int_counter_command).w,(a5)
		bra.w	Process_Nem_Queue
; ---------------------------------------------------------------------------

VInt_18:
		stopZ80
		bsr.w	Poll_Controllers

		dma68kToVDP Normal_palette,$0000,$80,CRAM
		dma68kToVDP Sprite_table,$F800,$280,VRAM
		dma68kToVDP H_scroll_buffer,$F000,$380,VRAM

		bclr	#0,(_unkFA88).w
		beq.s	+ ;loc_DEA
		dma68kToVDP $FF2000,$C000,$2000,VRAM

+ ;loc_DEA:
		bsr.w	Process_DMA_Queue
		bsr.w	sndDriverInput
		startZ80
		rts
; ---------------------------------------------------------------------------

VInt_16:
		stopZ80
		bsr.w	Poll_Controllers

		dma68kToVDP Normal_palette,$0000,$80,CRAM
		dma68kToVDP Sprite_table,$F800,$280,VRAM
		dma68kToVDP H_scroll_buffer,$F000,$380,VRAM

		bsr.w	Process_DMA_Queue
		bsr.w	sndDriverInput
		startZ80
		bsr.w	Process_Nem_Queue
		tst.w	(Demo_timer).w
		beq.w	.locret_E9E
		subq.w	#1,(Demo_timer).w

.locret_E9E:
		rts
; ---------------------------------------------------------------------------

VInt_1A:
		bsr.w	Do_ControllerPal
		bsr.w	Process_Nem_Queue
		jmp	(Set_Kos_Bookmark).l
; ---------------------------------------------------------------------------

VInt_1C:
		bsr.w	Rotate_SSPal
		bsr.w	Do_ControllerPal
		bsr.w	Update_SSMap
		tst.w	(Demo_timer).w
		beq.w	+ ;loc_EC6
		subq.w	#1,(Demo_timer).w

+ ;loc_EC6:
		jmp	(Set_Kos_Bookmark).l
; ---------------------------------------------------------------------------

VInt_1E:
		bsr.s	Do_ControllerPal
		movea.l	(_unkEF44_1).w,a0
		jsr	(a0)
		bsr.w	Process_Nem_Queue_2
		jmp	(Set_Kos_Bookmark).l

; =============== S U B R O U T I N E =======================================


Do_ControllerPal:
		stopZ80
		bsr.w	Poll_Controllers
		tst.b	(Water_full_screen_flag).w
		bne.s	+ ;loc_F20
		dma68kToVDP Normal_palette,$0000,$80,CRAM
		bra.s	++ ;loc_F44

+ ;loc_F20:
		dma68kToVDP Water_palette,$0000,$80,CRAM

+ ;loc_F44:
		dma68kToVDP Sprite_table,$F800,$280,VRAM
		dma68kToVDP H_scroll_buffer,$F000,$380,VRAM
		bsr.w	Process_DMA_Queue
		bsr.w	sndDriverInput
		startZ80
		rts
; End of function Do_ControllerPal

; ---------------------------------------------------------------------------

JmpTo_HInt:
		jmp	(H_int_jump).w

; ---------------------------------------------------------------------------
; Horizontal interrupt handler for Competition Mode
; ---------------------------------------------------------------------------

HInt:
		tst.w	(H_int_flag).w
		beq.w	.Done
		move.w	#0,(H_int_flag).w
		move.l	a5,-(sp)
		move.l	d0,-(sp)

-
		move.w	(VDP_control_port).l,d0
		andi.w	#4,d0	; is horizontal blanking occuring?
		beq.s	-	; if not, wait until it is

		move.w	(VDP_reg_1_command).w,d0
		andi.b	#$BF,d0
		move.w	d0,(VDP_control_port).l	; blank the display

		; Update V-Scroll.
		move.l	#vdpComm($0000,VSRAM,WRITE),(VDP_control_port).l
		move.l	(V_scroll_value_P2_copy).w,(VDP_data_port).l

		stopZ80
		; Unlike in Sonic 2, the sprite tables are page-flipped in two-player mode.
		; This fixes a race-condition where incomplete sprite tables can be uploaded
		; to the VDP on lag frames, causing corrupted sprites to appear.

		; Upload the front buffer.
		tst.w	(Current_sprite_table_page).w
		beq.s	+
		dma68kToVDP Sprite_table_P2,$F800,$280,VRAM
		bra.s	++

+
		dma68kToVDP Sprite_table_P2_alternate,$F800,$280,VRAM

+
		startZ80

-
		move.w	(VDP_control_port).l,d0
		andi.w	#4,d0	; is a horizontal blank occuring?
		beq.s	-	; if not, wait
		move.w	(VDP_reg_1_command).w,d0
		ori.b	#$40,d0
		move.w	d0,(VDP_control_port).l	; enable display
		move.l	(sp)+,d0
		movea.l	(sp)+,a5

.Done:
		rte

; ---------------------------------------------------------------------------
; Used for water levels apart from Hydrocity, for uneven water surfaces
; ---------------------------------------------------------------------------

HInt3:
		tst.w	(H_int_flag).w
		beq.s	.Done
		move.w	#0,(H_int_flag).w
		movem.l	d0-d1/a0-a2,-(sp)

		lea	(VDP_data_port).l,a1
		move.w	#$8AFF,VDP_control_port-VDP_data_port(a1)		; Reset HInt timing
		stopZ80
		movea.l	(Water_palette_data_addr).w,a2
		moveq	#$C,d0
		dbf	d0,*	; waste a few cycles here
		move.w	(a2)+,d1
		move.b	(H_int_counter).w,d0
		subi.b	#200,d0	; is H-int occurring below line 200?
		bcs.s	$$transferColors	; if it is, branch
		sub.b	d0,d1
		bcs.s	$$skipTransfer

$$transferColors:
		move.w	(a2)+,d0
		lea	(Water_palette).w,a0
		adda.w	d0,a0
		addi.w	#$C000,d0
		swap	d0
		move.l	d0,VDP_control_port-VDP_data_port(a1)	; write to CRAM at appropriate address
		move.l	(a0)+,(a1)	; transfer two colors
		move.w	(a0)+,(a1)	; transfer the third color
		nop
		nop
		moveq	#$24,d0
		dbf	d0,*	; waste some cycles
		dbf	d1,$$transferColors	; repeat for number of colors

$$skipTransfer:
		startZ80
		movem.l	(sp)+,d0-d1/a0-a2
		tst.b	(Do_Updates_in_H_int).w
		bne.s	.Do_Updates

.Done:
		rte
; ---------------------------------------------------------------------------

.Do_Updates:
		clr.b	(Do_Updates_in_H_int).w
		movem.l	d0-a6,-(sp)
		jsr	(Do_Updates).l
		movem.l	(sp)+,d0-a6
		rte

; ---------------------------------------------------------------------------
; Identical to HInt3 except it transfers colors from the above water palette
; Seems to be unused
; ---------------------------------------------------------------------------

HInt5:
		tst.w	(H_int_flag).w		; Seems to be a compliment to HInt 3, but doesn't seem to be used
		beq.s	.Done
		move.w	#0,(H_int_flag).w
		movem.l	d0-d1/a0-a2,-(sp)

		lea	(VDP_data_port).l,a1
		move.w	#$8AFF,VDP_control_port-VDP_data_port(a1)
		stopZ80
		movea.l	(Water_palette_data_addr).w,a2
		moveq	#$C,d0
		dbf	d0,*

		move.w	(a2)+,d1
		move.b	(H_int_counter).w,d0
		subi.b	#200,d0
		bcs.s	$$transferColors
		sub.b	d0,d1
		bcs.s	$$skipTransfer

$$transferColors:
		move.w	(a2)+,d0
		lea	(Normal_palette).w,a0
		adda.w	d0,a0
		addi.w	#$C000,d0
		swap	d0
		move.l	d0,VDP_control_port-VDP_data_port(a1)
		move.l	(a0)+,(a1)
		move.w	(a0)+,(a1)
		nop
		nop
		moveq	#$24,d0
		dbf	d0,*	; waste some cycles
		dbf	d1,$$transferColors

$$skipTransfer:
		startZ80
		movem.l	(sp)+,d0-d1/a0-a2
		tst.b	(Do_Updates_in_H_int).w
		bne.s	.Do_Updates

.Done:
		rte
; ---------------------------------------------------------------------------

.Do_Updates:
		clr.b	(Do_Updates_in_H_int).w
		movem.l	d0-a6,-(sp)
		jsr	(Do_Updates).l
		movem.l	(sp)+,d0-a6
		rte

; ---------------------------------------------------------------------------
; Identical to HInt3, except for faster systems
; ---------------------------------------------------------------------------

HInt4:
		tst.w	(H_int_flag).w
		beq.s	.Done
		move.w	#0,(H_int_flag).w
		movem.l	d0-d1/a0-a2,-(sp)

		lea	(VDP_data_port).l,a1
		move.w	#$8AFF,VDP_control_port-VDP_data_port(a1)
		stopZ80
		movea.l	(Water_palette_data_addr).w,a2
		moveq	#$1B,d0
		dbf	d0,*

		move.w	(a2)+,d1
		move.b	(H_int_counter).w,d0
		subi.b	#200,d0
		bcs.s	$$transferColors
		sub.b	d0,d1
		bcs.s	$$skipTransfer

$$transferColors:
		move.w	(a2)+,d0
		lea	(Water_palette).w,a0
		adda.w	d0,a0
		addi.w	#$C000,d0
		swap	d0
		move.l	d0,VDP_control_port-VDP_data_port(a1)
		move.l	(a0)+,(a1)
		move.w	(a0)+,(a1)
		nop
		moveq	#$33,d0
		dbf	d0,*	; waste some cycles
		dbf	d1,$$transferColors

$$skipTransfer:
		startZ80
		movem.l	(sp)+,d0-d1/a0-a2
		tst.b	(Do_Updates_in_H_int).w
		bne.s	.Do_Updates

.Done:
		rte
; ---------------------------------------------------------------------------

.Do_Updates:
		clr.b	(Do_Updates_in_H_int).w
		movem.l	d0-a6,-(sp)
		jsr	(Do_Updates).l
		movem.l	(sp)+,d0-a6
		rte

; ---------------------------------------------------------------------------
; Identical to HInt5, except for faster systems
; ---------------------------------------------------------------------------

HInt_6:
		tst.w	(H_int_flag).w
		beq.s	.Done
		move.w	#0,(H_int_flag).w
		movem.l	d0-d1/a0-a2,-(sp)

		lea	(VDP_data_port).l,a1
		move.w	#$8AFF,VDP_control_port-VDP_data_port(a1)
		stopZ80
		movea.l	(Water_palette_data_addr).w,a2
		moveq	#$1B,d0
		dbf	d0,*

		move.w	(a2)+,d1
		move.b	(H_int_counter).w,d0
		subi.b	#200,d0
		bcs.s	$$transferColors
		sub.b	d0,d1
		bcs.s	$$skipTransfer

$$transferColors:
		move.w	(a2)+,d0
		lea	(Normal_palette).w,a0
		adda.w	d0,a0
		addi.w	#$C000,d0
		swap	d0
		move.l	d0,VDP_control_port-VDP_data_port(a1)
		move.l	(a0)+,(a1)
		move.w	(a0)+,(a1)
		nop
		moveq	#$33,d0
		dbf	d0,*	; waste some cycles
		dbf	d1,$$transferColors

$$skipTransfer:
		startZ80
		movem.l	(sp)+,d0-d1/a0-a2
		tst.b	(Do_Updates_in_H_int).w
		bne.s	.Do_Updates

.Done:
		rte
; ---------------------------------------------------------------------------

.Do_Updates:
		clr.b	(Do_Updates_in_H_int).w
		movem.l	d0-a6,-(sp)
		jsr	(Do_Updates).l
		movem.l	(sp)+,d0-a6
		rte

; ---------------------------------------------------------------------------
; Copies the entire water palette to CRAM, used only in Hydrocity
; ---------------------------------------------------------------------------

HInt2:
		move	#$2700,sr
		tst.w	(H_int_flag).w
		beq.s	.Done
		move.w	#0,(H_int_flag).w
		movem.l	a0-a1,-(sp)

		lea	(VDP_data_port).l,a1
		move.w	#$8ADF,VDP_control_port-VDP_data_port(a1)
		lea	(Water_palette).w,a0
		move.l	#vdpComm($0000,CRAM,WRITE),VDP_control_port-VDP_data_port(a1)
	rept 32
		move.l	(a0)+,(a1)
	endm
		movem.l	(sp)+,a0-a1
		tst.b	(Do_Updates_in_H_int).w
		bne.s	.Do_Updates

.Done:
		rte
; ---------------------------------------------------------------------------

.Do_Updates:
		clr.b	(Do_Updates_in_H_int).w
		movem.l	d0-a6,-(sp)
		bsr.w	Do_Updates
		movem.l	(sp)+,d0-a6
		rte


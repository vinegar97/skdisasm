LevelSetup:
		clr.b	(Background_collision_flag).w
		clr.l	(Plane_double_update_flag).w
		clr.w	(Special_events_routine).w
		clr.l	(Level_repeat_offset).w
		clr.l	(Events_routine_fg).w
		clr.l	(Events_fg_4).w
		clr.w	(Screen_shake_flag).w
		clr.l	(Screen_shake_offset).w
		clr.l	(Events_bg+$00).w
		clr.l	(Events_bg+$04).w
		clr.l	(Events_bg+$08).w
		clr.l	(Events_bg+$0C).w
		move.w	#$FFF,(Screen_Y_wrap_value).w
		move.w	#$FF0,(Camera_Y_pos_mask).w
		move.w	#$7C,(Layout_row_index_mask).w
		move.w	(Camera_X_pos).w,(Camera_X_pos_copy).w
		move.w	(Camera_Y_pos).w,(Camera_Y_pos_copy).w
		lea	(Plane_buffer).w,a0
		lea	(Block_table).w,a2
		lea	(Level_layout_main).w,a3
		move.w	#VRAM_Plane_A_Name_Table,d7
		move.w	(Current_zone_and_act).w,d0
		ror.b	#2,d0
		lsr.w	#3,d0
		movea.l	LevelSetupArray(pc,d0.w),a1
		jsr	(a1)
		addq.w	#2,a3
		move.w	#VRAM_Plane_B_Name_Table,d7
		move.w	(Current_zone_and_act).w,d0
		ror.b	#2,d0
		lsr.w	#3,d0
		movea.l	LevelSetupArray+4(pc,d0.w),a1
		jsr	(a1)
		move.w	(Camera_Y_pos_copy).w,(V_scroll_value).w
		move.w	(Camera_Y_pos_BG_copy).w,(V_scroll_value_BG).w
		rts

; =============== S U B R O U T I N E =======================================


ScreenEvents:
		move.w	(Camera_X_pos).w,(Camera_X_pos_copy).w
		move.w	(Camera_Y_pos).w,(Camera_Y_pos_copy).w
		lea	(Plane_buffer).w,a0
		lea	(Block_table).w,a2
		lea	(Level_layout_main).w,a3
		move.w	#VRAM_Plane_A_Name_Table,d7
		move.w	(Current_zone_and_act).w,d0
		ror.b	#2,d0
		lsr.w	#3,d0
		movea.l	LevelEventArray(pc,d0.w),a1
		jsr	(a1)
		addq.w	#2,a3
		move.w	#VRAM_Plane_B_Name_Table,d7
		move.w	(Current_zone_and_act).w,d0
		ror.b	#2,d0
		lsr.w	#3,d0
		movea.l	LevelEventArray+4(pc,d0.w),a1
		jsr	(a1)
		move.w	(Camera_Y_pos_copy).w,(V_scroll_value).w
		move.w	(Camera_Y_pos_BG_copy).w,(V_scroll_value_BG).w
		rts
; End of function ScreenEvents

; ---------------------------------------------------------------------------
LevelSetupArray:dc.l	AIZ1_ScreenInit,	AIZ1_BackgroundInit
		dc.l	AIZ2_ScreenInit,	AIZ2_BackgroundInit
LevelEventArray:dc.l	AIZ1_ScreenEvent,	AIZ1_BackgroundEvent
		dc.l	AIZ2_ScreenEvent,	AIZ2_BackgroundEvent
		dc.l	HCZ1_ScreenInit,	HCZ1_BackgroundInit
		dc.l	HCZ2_ScreenInit,	HCZ2_BackgroundInit
		dc.l	HCZ1_ScreenEvent,	HCZ1_BackgroundEvent
		dc.l	HCZ2_ScreenEvent,	HCZ2_BackgroundEvent
		dc.l	MGZ1_ScreenInit,	MGZ1_BackgroundInit
		dc.l	MGZ2_ScreenInit,	MGZ2_BackgroundInit
		dc.l	MGZ1_ScreenEvent,	MGZ1_BackgroundEvent
		dc.l	MGZ2_ScreenEvent,	MGZ2_BackgroundEvent
		dc.l	CNZ1_ScreenInit,	CNZ1_BackgroundInit
		dc.l	CNZ2_ScreenInit,	CNZ2_BackgroundInit
		dc.l	CNZ1_ScreenEvent,	CNZ1_BackgroundEvent
		dc.l	CNZ2_ScreenEvent,	CNZ2_BackgroundEvent
		dc.l	NoScreenInit,		NoBackgroundInit
		dc.l	NoScreenInit,		NoBackgroundInit
		dc.l	NoScreenEvent,		NoBackgroundEvent
		dc.l	NoScreenEvent,		NoBackgroundEvent
		dc.l	ICZ1_ScreenInit,	ICZ1_BackgroundInit
		dc.l	ICZ2_ScreenInit,	ICZ2_BackgroundInit
		dc.l	ICZ1_ScreenEvent,	ICZ1_BackgroundEvent
		dc.l	ICZ2_ScreenEvent,	ICZ2_BackgroundEvent
		dc.l	LBZ1_ScreenInit,	LBZ1_BackgroundInit
		dc.l	LBZ2_ScreenInit,	LBZ2_BackgroundInit
		dc.l	LBZ1_ScreenEvent,	LBZ1_BackgroundEvent
		dc.l	LBZ2_ScreenEvent,	LBZ2_BackgroundEvent
		dc.l	NoScreenInit,		NoBackgroundInit
		dc.l	NoScreenInit,		NoBackgroundInit
		dc.l	NoScreenEvent,		NoBackgroundEvent
		dc.l	NoScreenEvent,		NoBackgroundEvent
		dc.l	NoScreenInit,		NoBackgroundInit
		dc.l	NoScreenInit,		NoBackgroundInit
		dc.l	NoScreenEvent,		NoBackgroundEvent
		dc.l	NoScreenEvent,		NoBackgroundEvent
		dc.l	NoScreenInit,		NoBackgroundInit
		dc.l	NoScreenInit,		NoBackgroundInit
		dc.l	NoScreenEvent,		NoBackgroundEvent
		dc.l	NoScreenEvent,		NoBackgroundEvent
		dc.l	NoScreenInit,		NoBackgroundInit
		dc.l	NoScreenInit,		NoBackgroundInit
		dc.l	NoScreenEvent,		NoBackgroundEvent
		dc.l	NoScreenEvent,		NoBackgroundEvent
		dc.l	NoScreenInit,		NoBackgroundInit
		dc.l	NoScreenInit,		NoBackgroundInit
		dc.l	NoScreenEvent,		NoBackgroundEvent
		dc.l	NoScreenEvent,		NoBackgroundEvent
		dc.l	NoScreenInit,		NoBackgroundInit
		dc.l	NoScreenInit,		NoBackgroundInit
		dc.l	NoScreenEvent,		NoBackgroundEvent
		dc.l	NoScreenEvent,		NoBackgroundEvent
		dc.l	NoScreenInit,		NoBackgroundInit
		dc.l	NoScreenInit,		NoBackgroundInit
		dc.l	NoScreenEvent,		NoBackgroundEvent
		dc.l	NoScreenEvent,		NoBackgroundEvent
		dc.l	Comp_ScreenInit,	ALZ_BackgroundInit
		dc.l	Comp_ScreenInit,	ALZ_BackgroundInit
		dc.l	Comp_ScreenEvent,	ALZ_BackgroundEvent
		dc.l	Comp_ScreenEvent,	ALZ_BackgroundEvent
		dc.l	Comp_ScreenInit,	BPZ_BackgroundInit
		dc.l	Comp_ScreenInit,	BPZ_BackgroundInit
		dc.l	Comp_ScreenEvent,	BPZ_BackgroundEvent
		dc.l	Comp_ScreenEvent,	BPZ_BackgroundEvent
		dc.l	Comp_ScreenInit,	DPZ_BackgroundInit
		dc.l	Comp_ScreenInit,	DPZ_BackgroundInit
		dc.l	Comp_ScreenEvent,	DPZ_BackgroundEvent
		dc.l	Comp_ScreenEvent,	DPZ_BackgroundEvent
		dc.l	Comp_ScreenInit,	CGZ_BackgroundInit
		dc.l	Comp_ScreenInit,	CGZ_BackgroundInit
		dc.l	CGZ_ScreenEvent,	CGZ_BackgroundEvent
		dc.l	CGZ_ScreenEvent,	CGZ_BackgroundEvent
		dc.l	Comp_ScreenInit,	EMZ_BackgroundInit
		dc.l	Comp_ScreenInit,	EMZ_BackgroundInit
		dc.l	Comp_ScreenEvent,	EMZ_BackgroundEvent
		dc.l	Comp_ScreenEvent,	EMZ_BackgroundEvent
		dc.l	Gumball_ScreenInit,	Gumball_BackgroundInit
		dc.l	Gumball_ScreenInit,	Gumball_BackgroundInit
		dc.l	Gumball_ScreenEvent,	Gumball_BackgroundEvent
		dc.l	Gumball_ScreenEvent,	Gumball_BackgroundEvent
		dc.l	NoScreenInit,		NoBackgroundInit
		dc.l	NoScreenInit,		NoBackgroundInit
		dc.l	NoScreenEvent,		NoBackgroundEvent
		dc.l	NoScreenEvent,		NoBackgroundEvent
		dc.l	NoScreenInit,		NoBackgroundInit
		dc.l	NoScreenInit,		NoBackgroundInit
		dc.l	NoScreenEvent,		NoBackgroundEvent
		dc.l	NoScreenEvent,		NoBackgroundEvent
		dc.l	NoScreenInit,		NoBackgroundInit
		dc.l	NoScreenInit,		NoBackgroundInit
		dc.l	NoScreenEvent,		NoBackgroundEvent
		dc.l	NoScreenEvent,		NoBackgroundEvent
		dc.l	NoScreenInit,		NoBackgroundInit
		dc.l	NoScreenInit,		NoBackgroundInit
		dc.l	NoScreenEvent,		NoBackgroundEvent
		dc.l	NoScreenEvent,		NoBackgroundEvent

; =============== S U B R O U T I N E =======================================


VInt_DrawLevel:
		lea	(VDP_data_port).l,a6
		lea	(Plane_buffer).w,a0
; End of function VInt_DrawLevel


; =============== S U B R O U T I N E =======================================


VInt_DrawLevel_2:
		move.w	(a0),d0
		beq.s	VInt_DrawLevel_Done
		clr.w	(a0)+
		move.w	(a0)+,d1
		bmi.s	VInt_DrawLevel_Col
		move.w	#$8F02,d2		; VRAM increment at 2 bytes (horizontal level write)
		move.w	#$80,d3
		bra.s	VInt_DrawLevel_Draw
; ---------------------------------------------------------------------------

VInt_DrawLevel_Col:
		move.w	#$8F80,d2		; VRAM increment at $80 bytes (vertical level write)
		moveq	#2,d3
		andi.w	#$7FFF,d1

VInt_DrawLevel_Draw:
		move.w	d2,VDP_control_port-VDP_data_port(a6)
		move.w	d0,d2
		move.w	d1,d4
		bsr.s	VInt_VRAMWrite
		move.w	d2,d0
		add.w	d3,d0
		move.w	d4,d1
		bsr.s	VInt_VRAMWrite
		bra.s	VInt_DrawLevel_2
; ---------------------------------------------------------------------------

VInt_DrawLevel_Done:
		move.w	#$8F02,VDP_control_port-VDP_data_port(a6)
		rts
; End of function VInt_DrawLevel_2


; =============== S U B R O U T I N E =======================================


VInt_VRAMWrite:
		swap	d0
		clr.w	d0
		swap	d0
		lsl.l	#2,d0
		lsr.w	#2,d0
		ori.w	#$4000,d0
		swap	d0
		move.l	d0,VDP_control_port-VDP_data_port(a6)

.loop:
		move.l	(a0)+,(a6)
		dbf	d1,.loop
		rts
; End of function VInt_VRAMWrite


; =============== S U B R O U T I N E =======================================


SpecialVInt_VRAMRead:
		swap	d0
		clr.w	d0
		swap	d0
		lsl.l	#2,d0
		lsr.w	#2,d0
		swap	d0
		move.l	d0,VDP_control_port-VDP_data_port(a6)

.loop:
		move.l	(a6),(a0)+
		dbf	d1,.loop
		rts
; End of function SpecialVInt_VRAMRead


; =============== S U B R O U T I N E =======================================


VInt_DrawLevel_Competition:
		lea	(VDP_data_port).l,a6
		lea	(Plane_buffer).w,a0

loc_3969A:
		move.w	(a0),d0
		beq.s	locret_396B4
		clr.w	(a0)+
		move.w	(a0)+,d1
		move.w	d0,d2
		move.w	d1,d4
		bsr.s	VInt_VRAMWrite
		move.w	d2,d0
		add.w	(_unkEEB0).w,d0
		move.w	d4,d1
		bsr.s	VInt_VRAMWrite
		bra.s	loc_3969A
; ---------------------------------------------------------------------------

locret_396B4:
		rts
; End of function VInt_DrawLevel_Competition


; =============== S U B R O U T I N E =======================================


SpecialVInt_Function:
		lea	(VDP_data_port).l,a6
		move.w	(Special_V_int_routine).w,d0
		jmp	SpecialVInt_Array(pc,d0.w)
; End of function SpecialVInt_Function

; ---------------------------------------------------------------------------

SpecialVInt_Array:
		rts					; $00
		nop
; ---------------------------------------------------------------------------
		bra.w	SpecialVInt_VScrollOn		; $04
; ---------------------------------------------------------------------------
		bra.w	SpecialVInt_VScrollCopy		; $08
; ---------------------------------------------------------------------------
		bra.w	SpecialVInt_VScrollOff		; $0C
; ---------------------------------------------------------------------------
		bra.w	SpecialVInt_LBZ2WindowCopy	; $10
; ---------------------------------------------------------------------------
		bra.w	SpecialVInt_LBZ2ScrollAClear	; $14
; ---------------------------------------------------------------------------
		bra.w	SpecialVInt_LBZ2ScrollAClear2	; $18
; ---------------------------------------------------------------------------
		bra.w	SpecialVInt_LBZ2WindowClear	; $1C
; ---------------------------------------------------------------------------

SpecialVInt_VScrollOn:
		move.w	#$8B07,VDP_control_port-VDP_data_port(a6)		; Command $8B07 - VScroll cell-based, HScroll line-based
		addq.w	#4,(Special_V_int_routine).w

SpecialVInt_VScrollCopy:
		lea	(Vscroll_buffer).w,a0
		move.l	#vdpComm($0000,VSRAM,WRITE),VDP_control_port-VDP_data_port(a6)
		moveq	#$14-1,d0

.loop:
		move.l	(a0)+,(a6)
		dbf	d0,.loop
		rts
; ---------------------------------------------------------------------------

SpecialVInt_VScrollOff:
		move.w	#$8B03,VDP_control_port-VDP_data_port(a6)		; Command $8B03 - VScroll full, HScroll line-based
		clr.w	(Special_V_int_routine).w
		rts
; ---------------------------------------------------------------------------

SpecialVInt_LBZ2WindowCopy:
		lea	(VRAM_buffer).w,a0		; Used specifically by the Death Egg platform at the end of LBZ2
		move.w	(Draw_delayed_rowcount).w,d0
		addi.w	#$D,d0
		andi.w	#$1F,d0
		lsl.w	#7,d0
		addi.w	#VRAM_Plane_A_Name_Table,d0
		move.w	d0,d2
		addi.w	#$64,d0
		moveq	#7-1,d1
		jsr	SpecialVInt_VRAMRead(pc)	; Grabs the nametable area of the Death Egg platform
		move.w	d2,d0
		moveq	#$19-1,d1
		jsr	SpecialVInt_VRAMRead(pc)
		lea	(VRAM_buffer).w,a0
		move.w	(Draw_delayed_rowcount).w,d0
		lsl.w	#7,d0
		addi.w	#$8000,d0
		moveq	#$20-1,d1
		jsr	VInt_VRAMWrite(pc)			; Copies the pertinent data from scroll A to the window nametable
		subq.w	#1,(Draw_delayed_rowcount).w		; Do this (EECA) number of times
		bpl.s	.return
		addq.w	#4,(Special_V_int_routine).w

.return:
		rts
; ---------------------------------------------------------------------------

SpecialVInt_LBZ2ScrollAClear:
		move.l	#vdpComm(VRAM_Plane_A_Name_Table+$900,VRAM,WRITE),(VDP_control_port).l	; VRAM base $C900
		moveq	#0,d0
		moveq	#$60-1,d1

.loop:
		move.l	d0,(a6)				; Clear 6 cell lines from VRAM A for when it scrolls upward
		move.l	d0,(a6)
		dbf	d1,.loop
		move.w	#$8320,VDP_control_port-VDP_data_port(a6)		; VRAM command $8320 - Window at base address $8000
		move.w	#$9285,VDP_control_port-VDP_data_port(a6)		; VRAM command $9285 - Window starts 5 cells down from top
		clr.w	(Special_V_int_routine).w
		rts
; ---------------------------------------------------------------------------

SpecialVInt_LBZ2ScrollAClear2:
		move.l	#vdpComm(VRAM_Plane_A_Name_Table+$600,VRAM,WRITE),(VDP_control_port).l	; VRAM base $C600
		moveq	#0,d0
		moveq	#$60-1,d1

.loop:
		move.l	d0,(a6)					; Erase remainder of upper area of VRAM A
		move.l	d0,(a6)
		dbf	d1,.loop
		addq.w	#4,(Special_V_int_routine).w
		rts
; ---------------------------------------------------------------------------

SpecialVInt_LBZ2WindowClear:
		lea	(VRAM_buffer).w,a0
		move.w	#$829C,d0
		moveq	#$19-1,d1
		jsr	SpecialVInt_VRAMRead(pc)
		move.w	#$8280,d0
		moveq	#7-1,d1
		jsr	SpecialVInt_VRAMRead(pc)	; Copy from window data. Luckily, all 6 cell lines are identical so it only needs to be done once
		move.l	#vdpComm(VRAM_Plane_A_Name_Table+$900,VRAM,WRITE),(VDP_control_port).l	; VRAM position $C900
		moveq	#6-1,d0

loc_397C2:
		lea	(VRAM_buffer).w,a0
		moveq	#$10-1,d1

loc_397C8:
		move.l	(a0)+,(a6)
		move.l	(a0)+,(a6)				; Write cell lines back to Scroll A
		dbf	d1,loc_397C8
		dbf	d0,loc_397C2
		move.w	#$9200,VDP_control_port-VDP_data_port(a6)			; VRAM command $9200 - Zero out window position
		clr.w	(Special_V_int_routine).w
		rts

; =============== S U B R O U T I N E =======================================


Draw_TileColumn:
		move.w	(a6),d0
		andi.w	#$FFF0,d0
		move.w	(a5),d2
		move.w	d0,(a5)
		move.w	d2,d3
		sub.w	d0,d2
		beq.w	locret_3996C
		tst.b	d2
		bpl.s	loc_397FE
		neg.w	d2
		move.w	d3,d0
		addi.w	#$150,d0

loc_397FE:
		andi.w	#$30,d2
		cmpi.w	#$10,d2
		sne	(Plane_double_update_flag).w
		movem.w	d1/d6,-(sp)
		bsr.s	Setup_TileColumnDraw
		movem.w	(sp)+,d1/d6
		tst.b	(Plane_double_update_flag).w
		beq.w	locret_3996C
		addi.w	#$10,d0
		bra.s	Setup_TileColumnDraw
; End of function Draw_TileColumn


; =============== S U B R O U T I N E =======================================


Draw_TileColumn2:
		move.w	(a6),d0
		andi.w	#$FFF0,d0
		move.w	(a5),d2
		move.w	d0,(a5)
		move.w	d2,d3
		sub.w	d0,d2
		beq.w	locret_3996C
		tst.b	d2
		bpl.s	loc_39842
		neg.w	d2
		move.w	d3,d0
		addi.w	#$150,d0
		swap	d1

loc_39842:
		andi.w	#$30,d2
		cmpi.w	#$10,d2
		sne	(Plane_double_update_flag).w
		movem.w	d1/d6,-(sp)
		bsr.s	Setup_TileColumnDraw
		movem.w	(sp)+,d1/d6
		tst.b	(Plane_double_update_flag).w
		beq.w	locret_3996C
		addi.w	#$10,d0
; End of function Draw_TileColumn2


; =============== S U B R O U T I N E =======================================


Setup_TileColumnDraw:
		move.w	d1,d2
		andi.w	#$70,d2
		move.w	d1,d3
		lsl.w	#4,d3
		andi.w	#$F00,d3
		asr.w	#4,d1
		move.w	d1,d4
		asr.w	#1,d1
		and.w	(Layout_row_index_mask).w,d1
		andi.w	#$F,d4
		moveq	#$10,d5
		sub.w	d4,d5
		move.w	d5,d4
		sub.w	d6,d5
		bmi.s	loc_398B2
		move.w	d0,d5
		asr.w	#2,d5
		andi.w	#$7C,d5
		add.w	d7,d5
		add.w	d3,d5
		move.w	d5,(a0)+
		move.w	d6,d5
		subq.w	#1,d6
		move.w	d6,(a0)+
		bset	#7,-2(a0)
		lea	(a0),a1
		add.w	d5,d5
		add.w	d5,d5
		adda.w	d5,a0
		jsr	Get_LevelChunkColumn(pc)
		bra.s	loc_39900
; ---------------------------------------------------------------------------

loc_398B2:
		neg.w	d5
		move.w	d5,-(sp)
		move.w	d0,d5
		asr.w	#2,d5
		andi.w	#$7C,d5
		add.w	d7,d5
		add.w	d3,d5
		move.w	d5,(a0)+
		move.w	d4,d6
		subq.w	#1,d6
		move.w	d6,(a0)+
		bset	#7,-2(a0)
		lea	(a0),a1
		add.w	d4,d4
		add.w	d4,d4
		adda.w	d4,a0
		jsr	Get_LevelChunkColumn(pc)
		bsr.s	loc_39900
		move.w	(sp)+,d6
		move.w	d0,d5
		asr.w	#2,d5
		andi.w	#$7C,d5
		add.w	d7,d5
		move.w	d5,(a0)+
		move.w	d6,d5
		subq.w	#1,d6
		move.w	d6,(a0)+
		bset	#7,-2(a0)
		lea	(a0),a1
		add.w	d5,d5
		add.w	d5,d5
		adda.w	d5,a0

loc_39900:
		swap	d7

loc_39902:
		move.w	(a5,d2.w),d3
		move.w	d3,d4
		andi.w	#$3FF,d3
		lsl.w	#3,d3
		move.w	(a2,d3.w),d5
		swap	d5
		move.w	4(a2,d3.w),d5
		move.w	6(a2,d3.w),d7
		move.w	2(a2,d3.w),d3
		swap	d3
		move.w	d7,d3
		btst	#$B,d4
		beq.s	loc_3993A
		eori.l	#$10001000,d5
		eori.l	#$10001000,d3
		swap	d5
		swap	d3

loc_3993A:
		btst	#$A,d4
		beq.s	loc_3994E
		eori.l	#$8000800,d5
		eori.l	#$8000800,d3
		exg	d3,d5

loc_3994E:
		move.l	d5,(a1)+
		move.l	d3,(a0)+
		addi.w	#$10,d2
		andi.w	#$70,d2
		bne.s	loc_39964
		addq.w	#4,d1
		and.w	(Layout_row_index_mask).w,d1
		bsr.s	Get_LevelChunkColumn

loc_39964:
		dbf	d6,loc_39902
		swap	d7
		clr.w	(a0)

locret_3996C:
		rts
; End of function Setup_TileColumnDraw


; =============== S U B R O U T I N E =======================================


Get_LevelChunkColumn:
		movea.w	(a3,d1.w),a4
		move.w	d0,d3
		asr.w	#7,d3
		adda.w	d3,a4
		moveq	#-1,d3
		clr.w	d3
		move.b	(a4),d3
		lsl.w	#7,d3
		move.w	d0,d4
		asr.w	#3,d4
		andi.w	#$E,d4
		add.w	d4,d3
		movea.l	d3,a5
		rts
; End of function Get_LevelChunkColumn


; =============== S U B R O U T I N E =======================================


Draw_TileRow:
		move.w	(a6),d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	(a5),d2
		move.w	d0,(a5)
		move.w	d2,d3
		sub.w	d0,d2
		beq.w	locret_39AFC
		tst.b	d2
		bpl.s	loc_399B0
		neg.w	d2
		move.w	d3,d0
		addi.w	#$F0,d0
		and.w	(Camera_Y_pos_mask).w,d0

loc_399B0:
		andi.w	#$30,d2
		cmpi.w	#$10,d2
		sne.b	(Plane_double_update_flag).w
		movem.w	d1/d6,-(sp)
		bsr.s	Setup_TileRowDraw
		movem.w	(sp)+,d1/d6
		tst.b	(Plane_double_update_flag).w
		beq.w	locret_39AFC
		addi.w	#$10,d0
		and.w	(Camera_Y_pos_mask).w,d0
		bra.s	Setup_TileRowDraw
; End of function Draw_TileRow


; =============== S U B R O U T I N E =======================================


Draw_TileRow2:
		move.w	(a6),d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	(a5),d2
		move.w	d0,(a5)
		move.w	d2,d3
		sub.w	d0,d2
		beq.w	locret_39AFC
		tst.b	d2
		bpl.s	loc_399FC
		neg.w	d2
		move.w	d3,d0
		addi.w	#$F0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		swap	d1

loc_399FC:
		andi.w	#$30,d2
		cmpi.w	#$10,d2
		sne	(Plane_double_update_flag).w
		movem.w	d1/d6,-(sp)
		bsr.s	Setup_TileRowDraw
		movem.w	(sp)+,d1/d6
		tst.b	(Plane_double_update_flag).w
		beq.w	locret_39AFC
		addi.w	#$10,d0
		and.w	(Camera_Y_pos_mask).w,d0
; End of function Draw_TileRow2


; =============== S U B R O U T I N E =======================================


Setup_TileRowDraw:
		asr.w	#4,d1
		move.w	d1,d2
		move.w	d1,d4
		asr.w	#3,d1
		add.w	d2,d2
		move.w	d2,d3
		andi.w	#$E,d2
		add.w	d3,d3
		andi.w	#$7C,d3
		andi.w	#$1F,d4
		moveq	#$20,d5
		sub.w	d4,d5
		move.w	d5,d4
		sub.w	d6,d5
		bmi.s	loc_39A68
		move.w	d0,d5
		andi.w	#$F0,d5		; If the length of the write can fit without wrapping the nametable
		lsl.w	#4,d5
		add.w	d7,d5
		add.w	d3,d5
		move.w	d5,(a0)+
		move.w	d6,d5
		subq.w	#1,d6
		move.w	d6,(a0)+
		lea	(a0),a1
		add.w	d5,d5
		add.w	d5,d5
		adda.w	d5,a0
		jsr	Get_LevelAddrChunkRow(pc)
		bra.s	loc_39AA8
; ---------------------------------------------------------------------------

loc_39A68:
		neg.w	d5			; If the length of the write wraps over the length of the nametable
		move.w	d5,-(sp)
		move.w	d0,d5
		andi.w	#$F0,d5
		lsl.w	#4,d5
		add.w	d7,d5
		add.w	d3,d5
		move.w	d5,(a0)+
		move.w	d4,d6
		subq.w	#1,d6
		move.w	d6,(a0)+
		lea	(a0),a1
		add.w	d4,d4
		add.w	d4,d4
		adda.w	d4,a0
		bsr.s	Get_LevelAddrChunkRow
		bsr.s	loc_39AA8
		move.w	(sp)+,d6	; Must place one more write command to account for rollover
		move.w	d0,d5
		andi.w	#$F0,d5
		lsl.w	#4,d5
		add.w	d7,d5
		move.w	d5,(a0)+
		move.w	d6,d5
		subq.w	#1,d6
		move.w	d6,(a0)+
		lea	(a0),a1
		add.w	d5,d5
		add.w	d5,d5
		adda.w	d5,a0

loc_39AA8:
		move.w	(a5,d2.w),d3
		move.w	d3,d4
		andi.w	#$3FF,d3
		lsl.w	#3,d3
		move.l	(a2,d3.w),d5
		move.l	4(a2,d3.w),d3
		btst	#$B,d4
		beq.s	loc_39AD0
		eori.l	#$10001000,d5
		eori.l	#$10001000,d3
		exg	d3,d5

loc_39AD0:
		btst	#$A,d4
		beq.s	loc_39AE6
		eori.l	#$8000800,d5
		eori.l	#$8000800,d3
		swap	d5
		swap	d3

loc_39AE6:
		move.l	d5,(a1)+
		move.l	d3,(a0)+
		addq.w	#2,d2
		andi.w	#$E,d2
		bne.s	loc_39AF6
		addq.w	#1,d1
		bsr.s	Get_ChunkRow

loc_39AF6:
		dbf	d6,loc_39AA8
		clr.w	(a0)

locret_39AFC:
		rts
; End of function Setup_TileRowDraw

; =============== S U B R O U T I N E =======================================


Get_LevelAddrChunkRow:
		move.w	d0,d3
		asr.w	#5,d3
		and.w	(Layout_row_index_mask).w,d3
		movea.w	(a3,d3.w),a4

Get_ChunkRow:
		moveq	#-1,d3
		clr.w	d3
		move.b	(a4,d1.w),d3
		lsl.w	#7,d3
		move.w	d0,d4
		andi.w	#$70,d4
		add.w	d4,d3
		movea.l	d3,a5
		rts
; End of function Get_LevelAddrChunkRow


; =============== S U B R O U T I N E =======================================


Setup_TileRowDraw_Competition:
		asr.w	#3,d1
		move.w	d1,d2
		asr.w	#4,d1
		andi.w	#$E,d2
		cmpi.w	#$100,(_unkEEB0).w
		beq.s	loc_39B3A
		moveq	#4,d3
		move.w	#$1F80,d4
		bra.s	loc_39B40
; ---------------------------------------------------------------------------

loc_39B3A:
		moveq	#5,d3
		move.w	#$1F00,d4

loc_39B40:
		move.w	d0,d5
		lsl.w	d3,d5
		and.w	d4,d5
		add.w	d7,d5
		move.w	d5,(a0)+
		move.w	d6,d5
		subq.w	#1,d6
		move.w	d6,(a0)+
		lea	(a0),a1
		add.w	d5,d5
		add.w	d5,d5
		adda.w	d5,a0
		jsr	Get_LevelAddrChunkRow(pc)
		bra.w	loc_39AA8
; End of function Setup_TileRowDraw_Competition


; =============== S U B R O U T I N E =======================================


Refresh_PlaneFull:
		moveq	#$10-1,d2

.loop:
		movem.l	d0-d2/a0,-(sp)
		moveq	#$20,d6
		jsr	Setup_TileRowDraw(pc)
		jsr	VInt_DrawLevel(pc)
		movem.l	(sp)+,d0-d2/a0
		addi.w	#$10,d0
		dbf	d2,.loop
		rts
; End of function Refresh_PlaneFull


; =============== S U B R O U T I N E =======================================


Refresh_PlaneTileDeform:
		move.w	(a4)+,d2
		moveq	#$10-1,d3

loc_39B82:
		cmp.w	d2,d0
		bmi.s	loc_39B8C
		add.w	(a4)+,d2
		addq.w	#4,a5
		bra.s	loc_39B82
; ---------------------------------------------------------------------------

loc_39B8C:
		move.w	(a5),d1
		moveq	#$20,d6
		movem.l	d0/d2-d3/a0/a4-a5,-(sp)
		jsr	Setup_TileRowDraw(pc)
		jsr	VInt_DrawLevel(pc)
		movem.l	(sp)+,d0/d2-d3/a0/a4-a5
		addi.w	#$10,d0
		dbf	d3,loc_39B82
		rts
; End of function Refresh_PlaneTileDeform

; ---------------------------------------------------------------------------

Refresh_PlaneDirectVScroll:
		move.w	(a4)+,d2
		moveq	#$20-1,d3

loc_39BAE:
		cmp.w	d2,d0
		bmi.s	loc_39BB8
		add.w	(a4)+,d2
		addq.w	#4,a5
		bra.s	loc_39BAE
; ---------------------------------------------------------------------------

loc_39BB8:
		move.w	(a5),d1
		moveq	#$10,d6
		movem.l	d0/d2-d3/a0/a4-a5,-(sp)
		jsr	Setup_TileColumnDraw(pc)
		jsr	VInt_DrawLevel(pc)
		movem.l	(sp)+,d0/d2-d3/a0/a4-a5
		addi.w	#$10,d0
		dbf	d3,loc_39BAE
		rts
; ---------------------------------------------------------------------------

Refresh_PlaneFull_Competition:
		movem.l	d0-d2/d6/a0,-(sp)
		jsr	Setup_TileRowDraw_Competition(pc)
		jsr	VInt_DrawLevel_Competition(pc)
		movem.l	(sp)+,d0-d2/d6/a0
		addi.w	#$10,d0
		dbf	d2,Refresh_PlaneFull_Competition
		rts
; ---------------------------------------------------------------------------

Refresh_PlaneScreenDirect:
		move	#$2700,sr
		move.w	(Camera_Y_pos_copy).w,d0
		move.w	(Camera_X_pos_copy).w,d1
		moveq	#$F-1,d2

loc_39BFE:
		movem.l	d0-d2/a0,-(sp)		; Redraws the entire plane in one go during 68k execution
		moveq	#$15,d6
		jsr	Setup_TileRowDraw(pc)
		jsr	VInt_DrawLevel(pc)
		movem.l	(sp)+,d0-d2/a0
		addi.w	#$10,d0
		dbf	d2,loc_39BFE
		move	#$2300,sr
		rts

; =============== S U B R O U T I N E =======================================


DrawTilesAsYouMove:
		lea	(Camera_X_pos_copy).w,a6
		lea	(Camera_X_pos_rounded).w,a5
		move.w	(Camera_Y_pos_copy).w,d1
		moveq	#$F,d6
		jsr	Draw_TileColumn(pc)
		lea	(Camera_Y_pos_copy).w,a6
		lea	(Camera_Y_pos_rounded).w,a5
		move.w	(Camera_X_pos_copy).w,d1
		moveq	#$15,d6
		jmp	Draw_TileRow(pc)
; End of function DrawTilesAsYouMove


; =============== S U B R O U T I N E =======================================


DrawBGAsYouMove:
		lea	(Camera_X_pos_BG_copy).w,a6
		lea	(Camera_X_pos_BG_rounded).w,a5
		move.w	(Camera_Y_pos_BG_copy).w,d1
		moveq	#$F,d6
		jsr	Draw_TileColumn(pc)
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		move.w	(Camera_X_pos_BG_copy).w,d1
		moveq	#$15,d6
		jmp	Draw_TileRow(pc)
; End of function DrawBGAsYouMove

; ---------------------------------------------------------------------------
		movem.l	d5/a4-a5,-(sp)
		lea	(Camera_Y_pos_copy).w,a6
		jsr	Get_DeformDrawPosVert(pc)
		lea	(Camera_Y_pos_rounded).w,a5
		jsr	Draw_TileRow2(pc)
		movem.l	(sp)+,d5/a4/a6
		move.w	(Camera_Y_pos_rounded).w,d6
		bra.s	Draw_BGNoVert

; =============== S U B R O U T I N E =======================================


Draw_BG:
		movem.l	d5/a4-a5,-(sp)
		lea	(Camera_Y_pos_BG_copy).w,a6
		jsr	Get_DeformDrawPosVert(pc)
		lea	(Camera_Y_pos_BG_rounded).w,a5
		jsr	Draw_TileRow2(pc)
		movem.l	(sp)+,d5/a4/a6
		move.w	(Camera_Y_pos_BG_rounded).w,d6

Draw_BGNoVert:
		move.w	d6,d1

loc_39CA2:
		sub.w	(a4)+,d6
		bmi.s	loc_39CB2
		move.w	(a6)+,d0
		andi.w	#$FFF0,d0
		move.w	d0,(a6)+
		subq.w	#1,d5
		bra.s	loc_39CA2
; ---------------------------------------------------------------------------

loc_39CB2:
		neg.w	d6
		lsr.w	#4,d6
		moveq	#$F,d4
		sub.w	d6,d4
		bcc.s	loc_39CC0
		moveq	#0,d4
		moveq	#$F,d6

loc_39CC0:
		movem.w	d1/d4-d6,-(sp)
		movem.l	a4/a6,-(sp)
		lea	2(a6),a5
		jsr	Draw_TileColumn(pc)
		movem.l	(sp)+,a4/a6
		movem.w	(sp)+,d1/d4-d6
		addq.w	#4,a6
		tst.w	d4
		beq.s	loc_39CF4
		lsl.w	#4,d6
		add.w	d6,d1
		subq.w	#1,d5
		move.w	(a4)+,d6
		lsr.w	#4,d6
		move.w	d4,d0
		sub.w	d6,d4
		bpl.s	loc_39CC0
		move.w	d0,d6
		moveq	#0,d4
		bra.s	loc_39CC0
; ---------------------------------------------------------------------------

loc_39CF4:
		subq.w	#1,d5
		beq.s	locret_39D02
		move.w	(a6)+,d0
		andi.w	#$FFF0,d0
		move.w	d0,(a6)+
		bra.s	loc_39CF4
; ---------------------------------------------------------------------------

locret_39D02:
		rts
; End of function Draw_BG


; =============== S U B R O U T I N E =======================================


Get_DeformDrawPosVert:
		move.w	(a4)+,d2
		move.w	(a6),d0
		bsr.s	sub_39D0E
		addi.w	#$E0,d0
; End of function Get_DeformDrawPosVert


; =============== S U B R O U T I N E =======================================


sub_39D0E:
		cmp.w	d2,d0
		bmi.s	loc_39D18
		add.w	(a4)+,d2
		addq.w	#4,a5
		bra.s	sub_39D0E
; ---------------------------------------------------------------------------

loc_39D18:
		move.w	(a5),d1
		swap	d1
		rts
; End of function sub_39D0E

; ---------------------------------------------------------------------------

DrawTilesVDeform:
		movem.l	d5/a4-a5,-(sp)
		lea	(Camera_X_pos_copy).w,a6
		jsr	Get_XDeformRange(pc)
		lea	(Camera_X_pos_rounded).w,a5
		jsr	Draw_TileColumn2(pc)
		movem.l	(sp)+,d5/a4/a6
		move.w	(Camera_X_pos_rounded).w,d6
		bra.s	loc_39D58

; ---------------------------------------------------------------------------

DrawTilesVDeform2:
		movem.l	d5/a4-a5,-(sp)
		lea	(Camera_X_pos_BG_copy).w,a6
		jsr	Get_XDeformRange(pc)
		lea	(Camera_X_pos_BG_rounded).w,a5
		jsr	Draw_TileColumn2(pc)
		movem.l	(sp)+,d5/a4/a6
		move.w	(Camera_X_pos_BG_rounded).w,d6

loc_39D58:
		move.w	d6,d1

loc_39D5A:
		sub.w	(a4)+,d6
		bcs.s	loc_39D6A
		move.w	(a6)+,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(a6)+
		subq.w	#1,d5
		bra.s	loc_39D5A
; ---------------------------------------------------------------------------

loc_39D6A:
		neg.w	d6
		lsr.w	#4,d6
		moveq	#$15,d4
		sub.w	d6,d4
		bcc.s	loc_39D78
		moveq	#0,d4
		moveq	#$15,d6

loc_39D78:
		movem.w	d1/d4-d6,-(sp)
		movem.l	a4/a6,-(sp)
		lea	2(a6),a5
		jsr	Draw_TileRow(pc)
		movem.l	(sp)+,a4/a6
		movem.w	(sp)+,d1/d4-d6
		addq.w	#4,a6
		tst.w	d4
		beq.s	loc_39DAC
		lsl.w	#4,d6
		add.w	d6,d1
		subq.w	#1,d5
		move.w	(a4)+,d6
		lsr.w	#4,d6
		move.w	d4,d0
		sub.w	d6,d4
		bcc.s	loc_39D78
		move.w	d0,d6
		moveq	#0,d4
		bra.s	loc_39D78
; ---------------------------------------------------------------------------

loc_39DAC:
		subq.w	#1,d5
		beq.s	locret_39DBA
		move.w	(a6)+,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(a6)+
		bra.s	loc_39DAC
; ---------------------------------------------------------------------------

locret_39DBA:
		rts


; =============== S U B R O U T I N E =======================================


Get_XDeformRange:
		move.w	(a4)+,d2
		move.w	(a6),d0
		bsr.s	sub_39DC6
		addi.w	#$140,d0
; End of function Get_XDeformRange


; =============== S U B R O U T I N E =======================================


sub_39DC6:
		cmp.w	d2,d0
		blo.s	loc_39DD0
		add.w	(a4)+,d2
		addq.w	#4,a5
		bra.s	sub_39DC6
; ---------------------------------------------------------------------------

loc_39DD0:
		move.w	(a5),d1
		swap	d1
		rts
; End of function sub_39DC6


; =============== S U B R O U T I N E =======================================


Draw_PlaneVertBottomUp:
		movem.w	d1-d2,-(sp)
		bsr.s	Draw_PlaneVertSingleBottomUp
		movem.w	(sp)+,d1-d2
		bpl.s	Draw_PlaneVertSingleBottomUp
		rts
; End of function Draw_PlaneVertBottomUp


; =============== S U B R O U T I N E =======================================


Draw_PlaneVertSingleBottomUp:
		and.w	(Camera_Y_pos_mask).w,d2
		move.w	d2,d3
		addi.w	#$F0,d3
		and.w	(Camera_Y_pos_mask).w,d3
		move.w	(Draw_delayed_position).w,d0
		cmp.w	d2,d0
		blo.s	loc_39E04
		cmp.w	d3,d0
		bhi.s	loc_39E04
		moveq	#$20,d6
		jsr	Setup_TileRowDraw(pc)

loc_39E04:
		subi.w	#$10,(Draw_delayed_position).w
		subq.w	#1,(Draw_delayed_rowcount).w
		rts
; End of function Draw_PlaneVertSingleBottomUp


; =============== S U B R O U T I N E =======================================


Draw_PlaneVertBottomUpComplex:
		movem.l	d1/a4-a5,-(sp)
		bsr.s	sub_39E1E
		movem.l	(sp)+,d1/a4-a5
		bpl.s	sub_39E1E
		rts
; End of function Draw_PlaneVertBottomUpComplex


; =============== S U B R O U T I N E =======================================


sub_39E1E:
		and.w	(Camera_Y_pos_mask).w,d1
		move.w	d1,d2
		addi.w	#$F0,d2
		and.w	(Camera_Y_pos_mask).w,d2
		move.w	(Draw_delayed_position).w,d0
		cmp.w	d1,d0
		blo.s	loc_39E46
		cmp.w	d2,d0
		bhi.s	loc_39E46

loc_39E38:
		addq.w	#4,a5
		cmp.w	(a4)+,d0
		bpl.s	loc_39E38
		move.w	(a5),d1
		moveq	#$20,d6
		jsr	Setup_TileRowDraw(pc)

loc_39E46:
		subi.w	#$10,(Draw_delayed_position).w
		subq.w	#1,(Draw_delayed_rowcount).w
		rts
; End of function sub_39E1E


; =============== S U B R O U T I N E =======================================


PlainDeformation:
		lea	(H_scroll_buffer).w,a1
		move.w	(Camera_X_pos_copy).w,d0
		neg.w	d0
		swap	d0
		move.w	(Camera_X_pos_BG_copy).w,d0
		neg.w	d0
		moveq	#$38-1,d1

loc_39E66:
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		dbf	d1,loc_39E66
		rts
; End of function PlainDeformation


; =============== S U B R O U T I N E =======================================


MakeFGDeformArray:
		move.w	d1,d0
		lsr.w	#1,d0
		bcc.s	loc_39E80

loc_39E7A:
		move.w	(a6)+,d5
		add.w	d6,d5
		move.w	d5,(a1)+

loc_39E80:
		move.w	(a6)+,d5
		add.w	d6,d5
		move.w	d5,(a1)+
		dbf	d0,loc_39E7A
		rts
; End of function MakeFGDeformArray


; =============== S U B R O U T I N E =======================================


ApplyDeformation:
		move.w	#$E0-1,d1

ApplyDeformation3:
		lea	(H_scroll_buffer).w,a1
		move.w	(Camera_Y_pos_BG_copy).w,d0
		move.w	(Camera_X_pos_copy).w,d3

ApplyDeformation2:
		move.w	(a4)+,d2
		smi	d4
		bpl.s	loc_39EA6
		andi.w	#$7FFF,d2

loc_39EA6:
		sub.w	d2,d0
		bmi.s	loc_39EB8
		addq.w	#2,a5
		tst.b	d4
		beq.s	ApplyDeformation2
		subq.w	#2,a5
		add.w	d2,d2
		adda.w	d2,a5
		bra.s	ApplyDeformation2
; ---------------------------------------------------------------------------

loc_39EB8:
		tst.b	d4
		beq.s	loc_39EC2
		add.w	d0,d2
		add.w	d2,d2
		adda.w	d2,a5

loc_39EC2:
		neg.w	d0
		move.w	d1,d2
		sub.w	d0,d2
		bcc.s	loc_39ECE
		move.w	d1,d0
		addq.w	#1,d0

loc_39ECE:
		neg.w	d3
		swap	d3

loc_39ED2:
		subq.w	#1,d0

loc_39ED4:
		tst.b	d4
		beq.s	loc_39EEE
		lsr.w	#1,d0
		bcc.s	loc_39EE2

loc_39EDC:
		move.w	(a5)+,d3
		neg.w	d3
		move.l	d3,(a1)+

loc_39EE2:
		move.w	(a5)+,d3
		neg.w	d3
		move.l	d3,(a1)+
		dbf	d0,loc_39EDC
		bra.s	loc_39EFE
; ---------------------------------------------------------------------------

loc_39EEE:
		move.w	(a5)+,d3
		neg.w	d3
		lsr.w	#1,d0
		bcc.s	loc_39EF8

loc_39EF6:
		move.l	d3,(a1)+

loc_39EF8:
		move.l	d3,(a1)+
		dbf	d0,loc_39EF6

loc_39EFE:
		tst.w	d2
		bmi.s	locret_39F16
		move.w	(a4)+,d0
		smi	d4
		bpl.s	loc_39F0C
		andi.w	#$7FFF,d0

loc_39F0C:
		move.w	d2,d3
		sub.w	d0,d2
		bpl.s	loc_39ED2
		move.w	d3,d0
		bra.s	loc_39ED4
; ---------------------------------------------------------------------------

locret_39F16:
		rts
; End of function ApplyDeformation


; =============== S U B R O U T I N E =======================================


ApplyFGandBGDeformation:
		swap	d7
		swap	d3

loc_39F1C:
		move.w	(a4)+,d3
		smi	d7
		bpl.s	loc_39F26
		andi.w	#$7FFF,d3

loc_39F26:
		sub.w	d3,d0
		bmi.s	loc_39F38
		addq.w	#2,a5
		tst.b	d7
		beq.s	loc_39F1C
		subq.w	#2,a5
		add.w	d3,d3
		adda.w	d3,a5
		bra.s	loc_39F1C
; ---------------------------------------------------------------------------

loc_39F38:
		tst.b	d7
		beq.s	loc_39F42
		add.w	d0,d3
		add.w	d3,d3
		adda.w	d3,a5

loc_39F42:
		swap	d3
		neg.w	d0
		move.w	d1,d4
		sub.w	d0,d4
		bcc.s	loc_39F50
		move.w	d1,d0
		addq.w	#1,d0

loc_39F50:
		subq.w	#1,d0

loc_39F52:
		tst.b	d7
		beq.s	loc_39F78
		lsr.w	#1,d0
		bcc.s	loc_39F66

loc_39F5A:
		move.w	(a2)+,d6
		swap	d6
		move.w	(a5)+,d6
		neg.w	d6
		add.w	(a6)+,d6
		move.l	d6,(a1)+

loc_39F66:
		move.w	(a2)+,d6
		swap	d6
		move.w	(a5)+,d6
		neg.w	d6
		add.w	(a6)+,d6
		move.l	d6,(a1)+
		dbf	d0,loc_39F5A
		bra.s	loc_39F98
; ---------------------------------------------------------------------------

loc_39F78:
		move.w	(a5)+,d5
		neg.w	d5
		lsr.w	#1,d0
		bcc.s	loc_39F8A

loc_39F80:
		move.w	(a2)+,d6
		swap	d6
		move.w	(a6)+,d6
		add.w	d5,d6
		move.l	d6,(a1)+

loc_39F8A:
		move.w	(a2)+,d6
		swap	d6
		move.w	(a6)+,d6
		add.w	d5,d6
		move.l	d6,(a1)+
		dbf	d0,loc_39F80

loc_39F98:
		tst.w	d4
		bmi.s	loc_39FB0
		move.w	(a4)+,d0
		smi	d7
		bpl.s	loc_39FA6
		andi.w	#$7FFF,d0

loc_39FA6:
		move.w	d4,d5
		sub.w	d0,d4
		bpl.s	loc_39F50
		move.w	d5,d0
		bra.s	loc_39F52
; ---------------------------------------------------------------------------

loc_39FB0:
		swap	d7
		rts

; =============== S U B R O U T I N E =======================================


Apply_FGVScroll:
		lea	(Vscroll_buffer).w,a1
		move.w	(Camera_Y_pos_BG_copy).w,d1
		move.w	(Camera_X_pos_copy).w,d0
		move.w	d0,d2
		andi.w	#$F,d2
		beq.s	loc_39FCC
		addi.w	#$10,d0

loc_39FCC:
		lsr.w	#4,d0

loc_39FCE:
		addq.w	#2,a5
		move.w	(a4)+,d2
		lsr.w	#4,d2
		sub.w	d2,d0
		bpl.s	loc_39FCE
		neg.w	d0
		moveq	#$13,d2
		sub.w	d0,d2
		bcc.s	loc_39FE2
		moveq	#$14,d0

loc_39FE2:
		subq.w	#1,d0

loc_39FE4:
		move.w	(a5)+,d3

loc_39FE6:
		move.w	d3,(a1)+
		move.w	d1,(a1)+
		dbf	d0,loc_39FE6
		tst.w	d2
		bmi.s	locret_3A000
		move.w	(a4)+,d0
		lsr.w	#4,d0
		move.w	d2,d3
		sub.w	d0,d2
		bpl.s	loc_39FE2
		move.w	d3,d0
		bra.s	loc_39FE4
; ---------------------------------------------------------------------------

locret_3A000:
		rts
; End of function Apply_FGVScroll


; =============== S U B R O U T I N E =======================================


Reset_TileOffsetPositionActual:
		move.w	(Camera_X_pos_copy).w,d0
		move.w	d0,d1
		andi.w	#$FFF0,d0
		move.w	d0,(Camera_X_pos_rounded).w
		move.w	(Camera_Y_pos_copy).w,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Camera_Y_pos_rounded).w
		rts
; End of function Reset_TileOffsetPositionActual


; =============== S U B R O U T I N E =======================================


Reset_TileOffsetPositionEff:
		move.w	(Camera_X_pos_BG_copy).w,d0
		move.w	d0,d1
		andi.w	#$FFF0,d0
		move.w	d0,d2
		move.w	d0,(Camera_X_pos_BG_rounded).w
		move.w	(Camera_Y_pos_BG_copy).w,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Camera_Y_pos_BG_rounded).w
		rts
; End of function Reset_TileOffsetPositionEff


; =============== S U B R O U T I N E =======================================


Update_CameraPositionP2:
		move.w	(Camera_X_pos_P2).w,(Camera_X_pos_P2_copy).w
		move.w	(Camera_Y_pos_P2).w,(Camera_Y_pos_P2_copy).w
		rts
; End of function Update_CameraPositionP2

; ---------------------------------------------------------------------------

Update_VScrollValueP2:
		move.w	(Camera_Y_pos_P2_copy).w,d0
		subi.w	#$70,d0
		move.w	d0,(V_scroll_value_P2).w
		move.w	(_unkEE74).w,d0
		subi.w	#$70,d0
		move.w	d0,(V_scroll_value_BG_P2).w
		rts

; =============== S U B R O U T I N E =======================================


SpecialEvents:
		cmpi.b	#6,(Player_1+routine).w
		bhs.s	locret_3A07E
		move.w	(Special_events_routine).w,d0
		movea.l	.Index(pc,d0.w),a0
		jmp	(a0)
; ---------------------------------------------------------------------------
.Index:
		dc.l locret_3A07E
		dc.l AIZ2_DoShipLoop
; ---------------------------------------------------------------------------

locret_3A07E:
		rts
; End of function SpecialEvents


; =============== S U B R O U T I N E =======================================


Adjust_BGDuringLoop:
		move.w	(a1),d1
		move.w	d0,(a1)+
		sub.w	d1,d0
		bpl.s	loc_3A094
		neg.w	d0
		cmp.w	d2,d0
		blo.s	loc_3A090
		sub.w	d3,d0

loc_3A090:
		sub.w	d0,(a1)+
		rts
; ---------------------------------------------------------------------------

loc_3A094:
		cmp.w	d2,d0
		blo.s	loc_3A09A
		sub.w	d3,d0

loc_3A09A:
		add.w	d0,(a1)+
		rts
; End of function Adjust_BGDuringLoop


; =============== S U B R O U T I N E =======================================


Get_BGActualEffectiveDiff:
		move.w	(Camera_X_pos_copy).w,d0
		sub.w	(Camera_X_pos_BG_copy).w,d0
		move.w	d0,(Camera_X_diff).w
		move.w	(Camera_Y_pos_copy).w,d0
		sub.w	(Camera_Y_pos_BG_copy).w,d0
		move.w	d0,(Camera_Y_diff).w
		rts
; End of function Get_BGActualEffectiveDiff


; =============== S U B R O U T I N E =======================================


ShakeScreen_Setup:
		move.w	(Screen_shake_offset).w,(Screen_shake_last_offset).w
		cmpi.b	#6,(Player_1+routine).w
		bhs.s	loc_3A0F2
		move.w	(Screen_shake_flag).w,d0
		beq.s	loc_3A0F2
		bmi.s	loc_3A0E0
		subq.w	#1,d0					; If EECC is positive, then it's a timed screen shake
		move.w	d0,(Screen_shake_flag).w
		move.b	ScreenShakeArray(pc,d0.w),d0
		ext.w	d0
		move.w	d0,(Screen_shake_offset).w
		rts
; ---------------------------------------------------------------------------

loc_3A0E0:
		move.w	(Level_frame_counter).w,d0		; If EECC is negative, it's a constant screen shake
		andi.w	#$3F,d0
		move.b	ScreenShakeArray2(pc,d0.w),d0
		move.w	d0,(Screen_shake_offset).w
		rts
; ---------------------------------------------------------------------------

loc_3A0F2:
		clr.w	(Screen_shake_offset).w
		rts
; End of function ShakeScreen_Setup


; =============== S U B R O U T I N E =======================================


Offset_ObjectsDuringTransition:
		lea	(Dynamic_object_RAM+object_size).w,a1
		moveq	#((Breathing_bubbles)-(Dynamic_object_RAM+object_size))/object_size-1,d2

loc_3A0FE:
		tst.l	(a1)
		beq.s	loc_3A112
		btst	#2,render_flags(a1)
		beq.s	loc_3A112
		sub.w	d0,x_pos(a1)
		sub.w	d1,y_pos(a1)

loc_3A112:
		lea	next_object(a1),a1
		dbf	d2,loc_3A0FE
		rts
; End of function Offset_ObjectsDuringTransition

; ---------------------------------------------------------------------------
ScreenShakeArray:
		dc.b   1, -1,  1, -1,  2, -2,  2, -2,  3, -3,  3, -3,  4, -4,  4, -4
		dc.b   5, -5,  5, -5
ScreenShakeArray2:
		dc.b   1,  2,  1,  3,  1,  2,  2,  1,  2,  3,  1,  2,  1,  2,  0,  0
		dc.b   2,  0,  3,  2,  2,  3,  2,  2,  1,  3,  0,  0,  1,  0,  1,  3
		dc.b   1,  2,  1,  3,  1,  2,  2,  1,  2,  3,  1,  2,  1,  2,  0,  0
		dc.b   2,  0,  3,  2,  2,  3,  2,  2,  1,  3,  0,  0,  1,  0,  1,  3
		even
AIZ1_WaterFGDeformDelta:
		dc.w   1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  0,  0,  0,  0
		dc.w   0,  0,  0,  0,  0,  0, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1
		dc.w  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,  0,  0,  0,  0
		dc.w   0,  0,  0,  0,  0,  0,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1
		dc.w   1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  0,  0,  0,  0
		dc.w   0,  0,  0,  0,  0,  0, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1
		dc.w  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,  0,  0,  0,  0
		dc.w   0,  0,  0,  0,  0,  0,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1
		dc.w   1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  0,  0,  0,  0
		dc.w   0,  0,  0,  0,  0,  0, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1
		dc.w  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,  0,  0,  0,  0
		dc.w   0,  0,  0,  0,  0,  0,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1
		dc.w   1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  0,  0,  0,  0
		dc.w   0,  0,  0,  0,  0,  0, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1
		dc.w  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,  0,  0,  0,  0
		dc.w   0,  0,  0,  0,  0,  0,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1
		dc.w   1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  0,  0,  0,  0
		dc.w   0,  0,  0,  0,  0,  0, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1
AIZ1_WaterBGDeformDelta:
		dc.w   0,  0, -1, -1, -1, -1, -1, -1,  0,  0,  0,  1,  1,  1,  1,  1
		dc.w   1,  0,  0,  0, -1, -1, -1, -1, -1, -1,  0,  0,  0,  1,  1,  1
		dc.w   1,  1,  1,  0,  0,  0, -1, -1, -1, -1, -1, -1,  0,  0,  0,  1
		dc.w   1,  1,  1,  1,  1,  0, -1, -2, -2, -1,  0,  2,  2,  2,  2,  0
		dc.w   0,  0, -1, -1, -1, -1, -1, -1,  0,  0,  0,  1,  1,  1,  1,  1
		dc.w   1,  0,  0,  0, -1, -1, -1, -1, -1, -1,  0,  0,  0,  1,  1,  1
LBZ_WaterWaveArray2:
		dc.w   1,  1,  1,  0,  0,  0, -1, -1, -1, -1, -1, -1,  0,  0,  0,  1
		dc.w   1,  1,  1,  1,  1,  0, -1, -2, -2, -1,  0,  2,  2,  2,  2,  0
		dc.w   0,  0, -1, -1, -1, -1, -1, -1,  0,  0,  0,  1,  1,  1,  1,  1
		dc.w   1,  0,  0,  0, -1, -1, -1, -1, -1, -1,  0,  0,  0,  1,  1,  1
		dc.w   1,  1,  1,  0,  0,  0, -1, -1, -1, -1, -1, -1,  0,  0,  0,  1
		dc.w   1,  1,  1,  1,  1,  0, -1, -2, -2, -1,  0,  2,  2,  2,  2,  0
		dc.w   0,  0, -1, -1, -1, -1, -1, -1,  0,  0,  0,  1,  1,  1,  1,  1
		dc.w   1,  0,  0,  0, -1, -1, -1, -1, -1, -1,  0,  0,  0,  1,  1,  1
LBZ_WaterWaveArray:
		dc.w   1,  1,  1,  0,  0,  0, -1, -1, -1, -1, -1, -1,  0,  0,  0,  1
		dc.w   1,  1,  1,  1,  1,  0, -1, -2, -2, -1,  0,  2,  2,  2,  2,  0
		dc.w   0,  0, -1, -1, -1, -1, -1, -1,  0,  0,  0,  1,  1,  1,  1,  1
		dc.w   1,  0,  0,  0, -1, -1, -1, -1, -1, -1,  0,  0,  0,  1,  1,  1

; =============== S U B R O U T I N E =======================================


Clear_Switches:
		lea	(Level_trigger_array).w,a1
		moveq	#bytesToLcnt($20),d0

.loop:
		clr.l	(a1)+
		dbf	d0,.loop
		rts
; End of function Clear_Switches

; ---------------------------------------------------------------------------

NoScreenInit:
		jsr	Reset_TileOffsetPositionActual(pc)
		jmp	Refresh_PlaneFull(pc)
; ---------------------------------------------------------------------------

NoScreenEvent:
		jmp	DrawTilesAsYouMove(pc)
; ---------------------------------------------------------------------------

NoBackgroundInit:
		jsr	No_Deform(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		jsr	Refresh_PlaneFull(pc)
		jmp	PlainDeformation(pc)
; ---------------------------------------------------------------------------

NoBackgroundEvent:
		jsr	No_Deform(pc)
		jsr	DrawBGAsYouMove(pc)
		jmp	PlainDeformation(pc)

; =============== S U B R O U T I N E =======================================


No_Deform:
		move.w	(Camera_X_pos_copy).w,d0
		asr.w	#3,d0
		move.w	d0,(Camera_X_pos_BG_copy).w
		move.w	(Camera_Y_pos_copy).w,d0
		asr.w	#3,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		rts
; End of function No_Deform

; ---------------------------------------------------------------------------

Comp_ScreenInit:
		jsr	Update_CameraPositionP2(pc)
		move.w	(Camera_X_pos_copy).w,d0
		move.w	d0,(Events_fg_0).w
		move.w	d0,(Events_fg_1).w
		move.w	(Camera_X_pos_P2_copy).w,d0
		move.w	d0,(Events_fg_2).w
		move.w	d0,(_unkEEBA).w
		moveq	#0,d0
		move.b	(Current_zone).w,d0
		lsl.w	#4,d0
		lea	Comp_ScreenInitArray-$E0(pc),a1
		adda.w	d0,a1
		move.w	(a1)+,(Screen_X_wrap_value).w
		move.w	(a1)+,(Screen_Y_wrap_value).w
		move.w	(a1)+,(Camera_Y_pos_mask).w
		move.w	(a1)+,(Layout_row_index_mask).w
		move.w	(a1)+,(_unkEEB0).w
		move.w	(a1)+,d0
		move.w	(a1)+,d2
		move.w	(a1)+,d6
		moveq	#0,d1
		move.w	#$8000,d7
		jmp	Refresh_PlaneFull_Competition(pc)
; ---------------------------------------------------------------------------

Comp_ScreenEvent:
		jsr	Update_CameraPositionP2(pc)
		move.w	(Screen_X_wrap_value).w,d2
		addq.w	#1,d2
		move.w	d2,d3
		lsr.w	#1,d2
		lea	(Events_fg_0).w,a1
		move.w	(Camera_X_pos_copy).w,d0
		jsr	Adjust_BGDuringLoop(pc)
		move.w	(Camera_X_pos_P2_copy).w,d0
		jmp	Adjust_BGDuringLoop(pc)
; ---------------------------------------------------------------------------

CGZ_ScreenEvent:
		bsr.s	Comp_ScreenEvent
		move.w	(Screen_Y_wrap_value).w,d2
		addq.w	#1,d2
		move.w	d2,d3
		lsr.w	#1,d2
		lea	(Events_bg+$00).w,a1
		move.w	(Camera_Y_pos_copy).w,d0
		jsr	Adjust_BGDuringLoop(pc)
		move.w	(Camera_Y_pos_P2_copy).w,d0
		jmp	Adjust_BGDuringLoop(pc)
; ---------------------------------------------------------------------------

ALZ_BackgroundInit:
		jsr	ALZ_BackgroundEvent(pc)
		bra.s	Comp_BackgroundInit
; ---------------------------------------------------------------------------

BPZ_BackgroundInit:
		jsr	BPZ_BackgroundEvent(pc)
		bra.s	Comp_BackgroundInit
; ---------------------------------------------------------------------------

DPZ_BackgroundInit:
		jsr	DPZ_BackgroundEvent(pc)
		bra.s	Comp_BackgroundInit
; ---------------------------------------------------------------------------

CGZ_BackgroundInit:
		move.w	(Camera_Y_pos_copy).w,d0
		move.w	d0,(Events_bg+$00).w
		move.w	d0,(Events_bg+$02).w
		move.w	(Camera_Y_pos_P2_copy).w,d0
		move.w	d0,(Events_bg+$04).w
		move.w	d0,(Events_bg+$06).w
		moveq	#0,d0
		move.b	(Competition_total_laps).w,d0
		addq.w	#1,d0
		lsl.w	#8,d0
		subi.w	#$70,d0
		move.l	#$900000,d1
		divu.w	d0,d1
		move.w	d1,(Events_bg+$08).w
		jsr	CGZ_BackgroundEvent(pc)
		bra.s	Comp_BackgroundInit
; ---------------------------------------------------------------------------

EMZ_BackgroundInit:
		jsr	EMZ_BackgroundEvent(pc)

Comp_BackgroundInit:
		move.l	(V_scroll_value_P2).w,(V_scroll_value_P2_copy).w
		moveq	#0,d0
		move.b	(Current_zone).w,d0
		lsl.w	#4,d0
		lea	Comp_ScreenInitArray-$D4(pc),a1
		adda.w	d0,a1
		move.w	(a1)+,d2
		move.w	(a1)+,d6
		moveq	#0,d0
		moveq	#0,d1
		move.w	#$A000,d7
		jmp	Refresh_PlaneFull_Competition(pc)
; ---------------------------------------------------------------------------

ALZ_BackgroundEvent:
		jsr	ALZ_Deformation(pc)
		lea	ALZ_BGDeformArray(pc),a4
		bra.s	loc_3A764
; ---------------------------------------------------------------------------

BPZ_BackgroundEvent:
		jsr	BPZ_Deformation(pc)
		lea	BPZ_BGDeformArray(pc),a4
		bra.s	loc_3A764
; ---------------------------------------------------------------------------

CGZ_BackgroundEvent:
		jsr	CGZ_Deformation(pc)
		lea	CGZ_BGDeformArray(pc),a4
		bra.s	loc_3A764
; ---------------------------------------------------------------------------

EMZ_BackgroundEvent:
		jsr	EMZ_Deformation(pc)
		lea	EMZ_BGDeformArray(pc),a4

loc_3A764:
		lea	(H_scroll_buffer).w,a1
		movea.l	a4,a6
		lea	(HScroll_table).w,a5
		move.w	(Camera_Y_pos_BG_copy).w,d0
		move.w	(Camera_X_pos_copy).w,d3
		moveq	#$6C-1,d1
		jsr	ApplyDeformation2(pc)
		movea.l	a6,a4
		lea	(HScroll_table+$100).w,a5
		move.w	(_unkEE74).w,d0
		subq.w	#4,d0
		move.w	(Camera_X_pos_P2_copy).w,d3
		moveq	#$74-1,d1
		jsr	ApplyDeformation2(pc)
		jmp	Update_VScrollValueP2(pc)
; ---------------------------------------------------------------------------

DPZ_BackgroundEvent:
		jsr	DPZ_Deformation(pc)
		lea	(H_scroll_buffer).w,a1
		move.w	(Camera_X_pos_copy).w,d0
		move.w	(Camera_X_pos_BG_copy).w,d1
		moveq	#$1A,d2
		bsr.s	sub_3A7BA
		move.w	(Camera_X_pos_P2_copy).w,d0
		move.w	(_unkEE70).w,d1
		moveq	#$1C,d2
		bsr.s	sub_3A7BA
		jmp	Update_VScrollValueP2(pc)

; =============== S U B R O U T I N E =======================================


sub_3A7BA:
		neg.w	d0
		swap	d0
		neg.w	d1
		move.w	d1,d0

loc_3A7C2:
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		dbf	d2,loc_3A7C2
		rts
; End of function sub_3A7BA


; =============== S U B R O U T I N E =======================================


ALZ_Deformation:
		move.w	(Camera_Y_pos_copy).w,d0
		bsr.s	sub_3A808
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Camera_Y_pos_P2_copy).w,d0
		bsr.s	sub_3A808
		move.w	d0,(_unkEE74).w
		addq.w	#3,(Events_bg+$00).w
		addi.l	#$1000,(Events_bg+$02).w
		lea	AIZ2_ALZ_BGDeformDelta(pc),a4
		lea	(HScroll_table).w,a1
		move.w	(Events_fg_1).w,d0
		bsr.s	sub_3A81E
		lea	(HScroll_table+$100).w,a1
		move.w	(_unkEEBA).w,d0
		bra.s	sub_3A81E
; End of function ALZ_Deformation


; =============== S U B R O U T I N E =======================================


sub_3A808:
		subi.w	#$148,d0
		swap	d0
		clr.w	d0
		move.l	d0,d1
		asr.l	#2,d1
		sub.l	d1,d0
		swap	d0
		addi.w	#$48,d0
		rts
; End of function sub_3A808


; =============== S U B R O U T I N E =======================================


sub_3A81E:
		swap	d0
		clr.w	d0
		asr.l	#1,d0
		move.l	d0,$90(a1)
		asr.l	#3,d0
		lea	$C(a1),a5
		move.l	d0,d1
		asr.l	#2,d1
		move.l	d1,d2
		move.l	(Events_bg+$02).w,d3
		moveq	#5,d4

loc_3A83A:
		add.l	d3,d1
		swap	d1
		move.w	d1,-(a5)
		swap	d1
		add.l	d2,d1
		dbf	d4,loc_3A83A
		movem.w	(a5),d1-d6
		move.w	d2,(a5)+
		move.w	d6,(a5)+
		move.w	d1,(a5)+
		move.w	d4,(a5)+
		move.w	d3,(a5)+
		move.w	d5,(a5)
		lea	$C(a1),a5
		move.l	d0,d1
		move.l	d1,d2
		asr.l	#1,d2
		moveq	#2,d3

loc_3A864:
		swap	d1
		move.w	d1,(a5)+
		swap	d1
		add.l	d2,d1
		dbf	d3,loc_3A864
		move.w	(Events_bg+$00).w,d1
		lsr.w	#3,d1
		andi.w	#$3E,d1
		lea	(a4,d1.w),a6
		swap	d0
		moveq	#$3E,d1

loc_3A882:
		move.w	(a6)+,d2
		add.w	d0,d2
		move.w	d2,(a5)+
		dbf	d1,loc_3A882
		rts
; End of function sub_3A81E


; =============== S U B R O U T I N E =======================================


BPZ_Deformation:
		move.w	(Camera_Y_pos_copy).w,d0
		bsr.s	sub_3A8B6
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Camera_Y_pos_P2_copy).w,d0
		bsr.s	sub_3A8B6
		move.w	d0,(_unkEE74).w
		lea	(HScroll_table+$00E).w,a1
		move.w	(Events_fg_1).w,d0
		bsr.s	sub_3A8C2
		lea	(HScroll_table+$10E).w,a1
		move.w	(_unkEEBA).w,d0
		bsr.s	sub_3A8C2
; End of function BPZ_Deformation


; =============== S U B R O U T I N E =======================================


sub_3A8B6:
		subi.w	#$2C8,d0
		asr.w	#1,d0
		addi.w	#$90,d0
		rts
; End of function sub_3A8B6


; =============== S U B R O U T I N E =======================================


sub_3A8C2:
		swap	d0
		clr.w	d0
		asr.l	#1,d0
		move.l	d0,d1
		asr.l	#3,d1
		moveq	#6,d2

loc_3A8CE:
		swap	d0
		move.w	d0,-(a1)
		swap	d0
		sub.l	d1,d0
		dbf	d2,loc_3A8CE
		rts
; End of function sub_3A8C2


; =============== S U B R O U T I N E =======================================


DPZ_Deformation:
		move.w	(Camera_Y_pos_copy).w,d0
		bsr.s	sub_3A912
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Camera_Y_pos_P2_copy).w,d0
		bsr.s	sub_3A912
		addi.w	#$80,d0
		move.w	d0,(_unkEE74).w
		move.w	(Events_fg_1).w,d0
		bsr.s	sub_3A91C
		move.w	d0,(Camera_X_pos_BG_copy).w
		move.w	d1,(Events_bg+$10).w
		move.w	(_unkEEBA).w,d0
		bsr.s	sub_3A91C
		move.w	d0,(_unkEE70).w
		move.w	d1,(Events_bg+$12).w
		rts
; End of function DPZ_Deformation


; =============== S U B R O U T I N E =======================================


sub_3A912:
		subi.w	#$148,d0
		asr.w	#4,d0
		addq.w	#8,d0
		rts
; End of function sub_3A912


; =============== S U B R O U T I N E =======================================


sub_3A91C:
		asr.w	#1,d0
		move.w	d0,d1
		asr.w	#2,d1
		rts
; End of function sub_3A91C


; =============== S U B R O U T I N E =======================================


CGZ_Deformation:
		move.w	(Events_bg+$02).w,d0
		bsr.s	sub_3A94C
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Events_bg+$06).w,d0
		bsr.s	sub_3A94C
		move.w	d0,(_unkEE74).w
		lea	(HScroll_table+$00A).w,a1
		move.w	(Events_fg_1).w,d0
		bsr.s	sub_3A95C
		lea	(HScroll_table+$10A).w,a1
		move.w	(_unkEEBA).w,d0
		bsr.s	sub_3A95C
; End of function CGZ_Deformation


; =============== S U B R O U T I N E =======================================


sub_3A94C:
		bmi.s	loc_3A958
		move.w	(Events_bg+$08).w,d1
		mulu.w	d1,d0
		swap	d0
		rts
; ---------------------------------------------------------------------------

loc_3A958:
		moveq	#0,d0
		rts
; End of function sub_3A94C


; =============== S U B R O U T I N E =======================================


sub_3A95C:
		swap	d0
		clr.w	d0
		asr.l	#1,d0
		move.l	d0,d1
		asr.l	#2,d1
		moveq	#3,d2

loc_3A968:
		swap	d0
		move.w	d0,-(a1)
		swap	d0
		sub.l	d1,d0
		dbf	d2,loc_3A968
		asr.l	#2,d1
		swap	d1
		addi.w	#$100,d1
		move.w	d1,-(a1)
		rts
; End of function sub_3A95C


; =============== S U B R O U T I N E =======================================


EMZ_Deformation:
		move.w	(Camera_Y_pos_copy).w,d0
		bsr.s	sub_3A9A8
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Camera_Y_pos_P2_copy).w,d0
		bsr.s	sub_3A9A8
		move.w	d0,(_unkEE74).w
		lea	(HScroll_table).w,a1
		move.w	(Events_fg_1).w,d0
		bsr.s	sub_3A9BE
		lea	(HScroll_table+$100).w,a1
		move.w	(_unkEEBA).w,d0
		bsr.s	sub_3A9BE
; End of function EMZ_Deformation


; =============== S U B R O U T I N E =======================================


sub_3A9A8:
		subi.w	#$148,d0
		swap	d0
		clr.w	d0
		move.l	d0,d1
		asr.l	#2,d1
		sub.l	d1,d0
		swap	d0
		addi.w	#$48,d0
		rts
; End of function sub_3A9A8


; =============== S U B R O U T I N E =======================================


sub_3A9BE:
		swap	d0
		clr.w	d0
		asr.l	#3,d0
		move.l	d0,d1
		swap	d0
		move.w	d0,$E(a1)
		swap	d0
		add.l	d1,d0
		swap	d0
		move.w	d0,$C(a1)
		move.w	d0,$10(a1)
		swap	d0
		add.l	d1,d0
		swap	d0
		move.w	d0,6(a1)
		move.w	d0,$A(a1)
		move.w	d0,$12(a1)
		swap	d0
		add.l	d1,d0
		swap	d0
		move.w	d0,(a1)
		move.w	d0,4(a1)
		move.w	d0,8(a1)
		swap	d0
		add.l	d1,d0
		swap	d0
		move.w	d0,2(a1)
		rts
; End of function sub_3A9BE

; ---------------------------------------------------------------------------
Comp_ScreenInitArray:
		dc.w   $3FF,  $1FF,  $1F0,    $C,  $100,  $100,    $F,   $40
		dc.w   $1FF,  $3FF,  $3F0,   $1C,   $80,  $200,   $1F,   $20
		dc.w   $3FF,  $1FF,  $1F0,    $C,  $100,  $100,    $F,   $40
		dc.w   $3FF,   $FF,   $F0,     4,  $100,  $100,    $F,   $40
		dc.w   $3FF,  $1FF,  $1F0,    $C,  $100,  $100,    $F,   $40
ALZ_BGDeformArray:
		dc.w    $18,     8,     8,     8,     8,     8,   $2E,     6,    $D, $803F, $7FFF
BPZ_BGDeformArray:
		dc.w    $88,   $16,    $A,   $28,   $10,     8, $7FFF
CGZ_BGDeformArray:
		dc.w    $50,     8,   $10,   $10, $7FFF
EMZ_BGDeformArray:
		dc.w    $10,   $10,   $10,   $10,     8,    $C,   $24,   $38,   $20, $7FFF
; ---------------------------------------------------------------------------

AIZ1_ScreenInit:
		jsr	Reset_TileOffsetPositionActual(pc)
		jmp	Refresh_PlaneFull(pc)
; ---------------------------------------------------------------------------

AIZ1_ScreenEvent:
		jsr	DrawTilesAsYouMove(pc)
		move.w	(Events_fg_4).w,d0
		beq.w	locret_3AB48
		cmpi.w	#$2D30,(Camera_X_pos_copy).w		; perform the tree tile manipulation routine when signalled.
		bhs.w	AIZ1SE_ChangeChunk1
		cmpi.w	#$39,d0
		bhs.w	AIZ1SE_ChangeChunk1
		cmpi.w	#$34,d0
		blo.s	loc_3AACC
		bsr.w	AIZ1SE_ChangeChunk2
		bra.s	loc_3AAE2
; ---------------------------------------------------------------------------

loc_3AACC:
		cmpi.w	#$24,d0
		blo.s	loc_3AAD8
		bsr.w	AIZ1SE_ChangeChunk3
		bra.s	loc_3AAE2
; ---------------------------------------------------------------------------

loc_3AAD8:
		cmpi.w	#$14,d0
		blo.s	loc_3AAE2
		bsr.w	AIZ1SE_ChangeChunk4

loc_3AAE2:
		lea	AIZ_TreeRevealArray(pc),a6
		btst	#0,d0
		bne.s	loc_3AAF0
		lea	$10(a6),a6

loc_3AAF0:
		subq.w	#1,d0
		lsr.w	#1,d0
		move.w	d0,(Events_bg+$00).w
		cmpi.w	#3,d0
		blo.s	loc_3AB04
		move.w	#2,(Events_bg+$00).w

loc_3AB04:
		lsl.w	#4,d0
		neg.w	d0
		addi.w	#$470,d0

loc_3AB0C:
		cmp.w	(Camera_Y_pos_rounded).w,d0
		bhs.s	loc_3AB22
		lea	$20(a6),a6
		addi.w	#$10,d0
		subq.w	#1,(Events_bg+$00).w
		bpl.s	loc_3AB0C
		bra.s	AIZ1SE_ChangeChunk1
; ---------------------------------------------------------------------------

loc_3AB22:
		move.w	#$2C80,d1
		moveq	#$10,d6
		move.l	a0,-(sp)
		jsr	Setup_TileRowDraw(pc)
		movea.l	(sp)+,a0
		subi.w	#$280,d0
		moveq	#0,d1
		moveq	#$F,d6
		bsr.s	AIZ_TreeReveal
		lea	$10(a6),a6
		addi.w	#$290,d0
		subq.w	#1,(Events_bg+$00).w
		bpl.s	loc_3AB0C

locret_3AB48:
		rts
; ---------------------------------------------------------------------------

AIZ1SE_ChangeChunk1:
		clr.w	(Events_fg_4).w		; When this is run, all chunks have been changed and the routine need not be run anymore
		movea.w	$14(a3),a1
		movea.w	(a3),a5
		move.b	(a5),$59(a1)
		move.b	1(a5),$5A(a1)

; =============== S U B R O U T I N E =======================================


AIZ1SE_ChangeChunk2:
		movea.w	$18(a3),a1
		movea.w	4(a3),a5
		move.b	(a5),$59(a1)
		move.b	1(a5),$5A(a1)
; End of function AIZ1SE_ChangeChunk2


; =============== S U B R O U T I N E =======================================


AIZ1SE_ChangeChunk3:
		movea.w	$1C(a3),a1
		movea.w	8(a3),a5
		move.b	(a5),$59(a1)
		move.b	1(a5),$5A(a1)
; End of function AIZ1SE_ChangeChunk3


; =============== S U B R O U T I N E =======================================


AIZ1SE_ChangeChunk4:
		movea.w	$20(a3),a1
		movea.w	$C(a3),a5
		move.b	(a5),$59(a1)
		move.b	1(a5),$5A(a1)
		rts
; End of function AIZ1SE_ChangeChunk4


; =============== S U B R O U T I N E =======================================


AIZ_TreeReveal:
		asr.w	#4,d1
		move.w	d1,d2
		asr.w	#3,d1
		add.w	d2,d2
		andi.w	#$E,d2
		addq.w	#4,a0
		movea.l	a0,a1
		lea	$40(a0),a0
		jsr	Get_LevelAddrChunkRow(pc)

loc_3ABAE:
		move.w	(a5,d2.w),d3
		move.w	d3,d4
		andi.w	#$3FF,d3
		lsl.w	#3,d3
		move.l	(a2,d3.w),d5
		move.l	4(a2,d3.w),d3
		btst	#$B,d4
		beq.s	loc_3ABD6
		eori.l	#$10001000,d5
		eori.l	#$10001000,d3
		exg	d3,d5

loc_3ABD6:
		btst	#$A,d4
		beq.s	loc_3ABEC
		eori.l	#$8000800,d5
		eori.l	#$8000800,d3
		swap	d5
		swap	d3

loc_3ABEC:
		tst.b	(a6)+
		beq.s	loc_3ABF2
		move.l	d5,(a1)

loc_3ABF2:
		addq.w	#4,a1
		tst.b	$F(a6)
		beq.s	loc_3ABFC
		move.l	d3,(a0)

loc_3ABFC:
		addq.w	#4,a0
		addq.w	#2,d2
		andi.w	#$E,d2
		bne.s	loc_3AC0C
		addq.w	#1,d1
		jsr	Get_ChunkRow(pc)

loc_3AC0C:
		dbf	d6,loc_3ABAE
		clr.w	(a0)
		rts
; End of function AIZ_TreeReveal

; ---------------------------------------------------------------------------

Obj_AIZ1TreeRevealControl:
		tst.w	$2E(a0)
		beq.s	loc_3AC26
		tst.w	(Events_fg_4).w
		bne.s	loc_3AC26
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_3AC26:
		subq.w	#1,$2E(a0)
		move.w	#$480,d0
		sub.w	(Player_1+y_pos).w,d0
		lsr.w	#3,d0
		addq.w	#3,d0
		cmp.w	(Events_fg_4).w,d0
		bhs.s	loc_3AC44
		btst	#0,$2F(a0)
		beq.s	locret_3AC48

loc_3AC44:
		addq.w	#1,(Events_fg_4).w

locret_3AC48:
		rts
; ---------------------------------------------------------------------------
AIZ_TreeRevealArray:
		dc.b    0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0
		dc.b    0,   0,   0,   0,   0,   1,   1,   1,   1,   1,   1,   0,   0,   0,   0,   0
		dc.b    0,   0,   0,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   0,   0,   0
		dc.b    0,   0,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   0,   0
		dc.b    0,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   0
		dc.b    1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1
		dc.b    1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1
		even
; ---------------------------------------------------------------------------

AIZ1_BackgroundInit:
		cmpi.w	#$1300,(Camera_X_pos_copy).w
		bhs.s	loc_3ACE6
		lea	(HScroll_table).w,a1			; Intro deformation
		moveq	#bytesToLcnt($28),d0

loc_3ACC8:
		clr.l	(a1)+
		dbf	d0,loc_3ACC8
		jsr	AIZ1_IntroDeform(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		jsr	Refresh_PlaneFull(pc)
		lea	AIZ1_IntroDeformArray(pc),a4
		lea	(HScroll_table+$028).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

loc_3ACE6:
		move.w	#8,(Events_routine_bg).w			; If not in the intro
		jsr	AIZ1_Deform(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		clr.l	(HScroll_table).w
		move.w	d2,(HScroll_table+$006).w
		lea	AIZ1_BGDrawArray(pc),a4
		lea	(HScroll_table).w,a5
		jsr	Refresh_PlaneTileDeform(pc)
		jmp	AIZ1_ApplyDeformWater(pc)
; ---------------------------------------------------------------------------

AIZ1_BackgroundEvent:
		move.w	(Events_routine_bg).w,d0
		jmp	.Index(pc,d0.w)
; ---------------------------------------------------------------------------

.Index:
		bra.w	AIZ1BGE_Intro
; ---------------------------------------------------------------------------
		bra.w	AIZ1BGE_NormalRefresh
; ---------------------------------------------------------------------------
		bra.w	AIZ1BGE_Normal
; ---------------------------------------------------------------------------
		bra.w	AIZ1BGE_FireTransition
; ---------------------------------------------------------------------------
		bra.w	AIZ1BGE_FireRefresh
; ---------------------------------------------------------------------------
		bra.w	AIZ1BGE_Finish
; ---------------------------------------------------------------------------

AIZ1BGE_Intro:
		tst.w	(Events_fg_5).w
		beq.s	loc_3AD66
		tst.w	(Kos_decomp_queue_count).w
		bne.w	loc_3AD66
		clr.w	(Events_fg_5).w
		jsr	AIZ1_Deform(pc)							; Set up normal deformation when intro is over
		jsr	Reset_TileOffsetPositionEff(pc)
		clr.l	(HScroll_table).w
		move.w	d2,(HScroll_table+$006).w
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_bg).w				; Next routine
		bra.s	loc_3AD8A
; ---------------------------------------------------------------------------

loc_3AD66:
		jsr	AIZ1_IntroDeform(pc)
		lea	AIZ1_IntroDrawArray(pc),a4
		lea	(HScroll_table).w,a5
		moveq	#$20,d6
		moveq	#$A,d5
		jsr	Draw_BG(pc)
		lea	AIZ1_IntroDeformArray(pc),a4
		lea	(HScroll_table+$028).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

AIZ1BGE_NormalRefresh:
		jsr	AIZ1_Deform(pc)

loc_3AD8A:
		lea	AIZ1_BGDrawArray(pc),a4
		lea	(HScroll_table-$04).w,a5
		move.w	(Camera_Y_pos_BG_copy).w,d1
		jsr	Draw_PlaneVertBottomUpComplex(pc)
		bpl.s	loc_3ADAC
		addq.w	#4,(Events_routine_bg).w
		bra.s	loc_3ADAC
; ---------------------------------------------------------------------------

AIZ1BGE_Normal:
		tst.w	(Events_fg_5).w
		bne.s	AIZ1_AIZ2_Transition		; Wait for signal to start level transition
		jsr	AIZ1_Deform(pc)

loc_3ADAC:
		lea	AIZ1_BGDrawArray(pc),a4
		lea	(HScroll_table).w,a5
		moveq	#$20,d6
		moveq	#2,d5
		jsr	Draw_BG(pc)
		jmp	AIZ1_ApplyDeformWater(pc)
; ---------------------------------------------------------------------------

AIZ1_AIZ2_Transition:
		clr.w	(Events_fg_5).w
		lea	(Normal_palette_line_4+2).w,a1
		move.l	#$4E006E,(a1)+
		move.l	#$AE00CE,(a1)+
		move.l	#$2EE0AEE,(a1)
		move.l	#$200000,(Camera_Y_pos_BG_copy).w
		move.w	#$10,(Camera_Y_pos_BG_rounded).w
		move.w	#$68,(Events_bg+$00).w
		move.w	#4,(Special_V_int_routine).w
		addq.w	#4,(Events_routine_bg).w

AIZ1BGE_FireTransition:
		tst.w	(Events_bg+$02).w
		bne.s	loc_3AE18
		move.w	(Events_bg+$00).w,d0
		swap	d0
		clr.w	d0
		sub.l	(Camera_Y_pos_BG_copy).w,d0
		asr.l	#5,d0
		add.l	d0,(Camera_Y_pos_BG_copy).w
		cmpi.l	#$1400,d0
		bhs.s	loc_3AE1C

loc_3AE18:
		jsr	AIZ1_FireRise(pc)

loc_3AE1C:
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		move.w	#$1000,d1
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)
		cmpi.w	#$190,(Camera_Y_pos_BG_copy).w
		blo.w	loc_3AECA
		movem.l	d7-a0/a2-a3,-(sp)
		lea	(AIZ2_128x128_Kos).l,a1
		lea	(RAM_start).l,a2
		jsr	(Queue_Kos).l
		lea	(AIZ2_16x16_Primary_Kos).l,a1
		lea	(Block_table).w,a2
		jsr	(Queue_Kos).l
		lea	(AIZ2_16x16_Secondary_Kos).l,a1
		lea	(Block_table+$AB8).w,a2
		jsr	(Queue_Kos).l
		lea	(AIZ2_8x8_Primary_KosM).l,a1
		move.w	#tiles_to_bytes($000),d2
		jsr	(Queue_Kos_Module).l
		lea	(AIZ2_8x8_Secondary_KosM).l,a1
		move.w	#tiles_to_bytes($1FC),d2
		jsr	(Queue_Kos_Module).l
		lea	(PLC_SpikesSprings).l,a1
		jsr	(Load_PLC_Raw).l
		movem.l	(sp)+,d7-a0/a2-a3
		jsr	(AllocateObject).l
		bne.s	loc_3AEB8
		move.l	#Obj_AIZTransitionFloor,(a1)
		move.w	#$2FB0,x_pos(a1)
		move.w	#$3A0,y_pos(a1)

loc_3AEB8:
		move.w	#$F0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_bg).w
		bra.s	loc_3AED6
; ---------------------------------------------------------------------------

loc_3AECA:
		jsr	AIZTrans_WavyFlame(pc)
		jmp	PlainDeformation(pc)
; ---------------------------------------------------------------------------

AIZ1BGE_FireRefresh:
		jsr	AIZ1_FireRise(pc)

loc_3AED6:
		lea	(Level_layout_main).w,a3
		move.w	#VRAM_Plane_A_Name_Table,d7
		move.w	#$180,d1
		moveq	#0,d2
		jsr	Draw_PlaneVertBottomUp(pc)	; Refresh main plane
		bpl.s	loc_3AEF6
		addq.w	#2,a3
		move.w	#VRAM_Plane_B_Name_Table,d7
		addq.w	#4,(Events_routine_bg).w
		bra.s	loc_3AF02
; ---------------------------------------------------------------------------

loc_3AEF6:
		jsr	AIZTrans_WavyFlame(pc)
		jmp	PlainDeformation(pc)
; ---------------------------------------------------------------------------

AIZ1BGE_Finish:
		jsr	AIZ1_FireRise(pc)

loc_3AF02:
		tst.b	(Kos_modules_left).w
		bne.w	loc_3AFCA		; Wait for the art to be loaded
		move.w	#1,(Current_zone_and_act).w	; Officially change this to act 2
		clr.b	(Dynamic_resize_routine).w
		clr.b	(Object_load_routine).w
		clr.b	(Rings_manager_routine).w
		clr.b	(Boss_flag).w
		clr.b	(Respawn_table_keep).w
		jsr	Clear_Switches(pc)
		movem.l	d7-a0/a2-a3,-(sp)
		jsr	(Load_Level).l
		jsr	(LoadSolids).l
		jsr	(CheckLevelForWater).l
		moveq	#$B,d0
		jsr	(LoadPalette_Immediate).l
		movem.l	(sp)+,d7-a0/a2-a3
		lea	(Normal_palette_line_4+$2).w,a1
		move.l	#$4E006E,(a1)+
		move.l	#$AE00CE,(a1)+
		move.l	#$2EE0AEE,(a1)
		move.w	#$2F00,d0
		move.w	#$80,d1
		sub.w	d0,(Player_1+x_pos).w
		sub.w	d1,(Player_1+y_pos).w
		sub.w	d0,(Player_2+x_pos).w
		sub.w	d1,(Player_2+y_pos).w
		sub.w	d0,(Camera_X_pos).w
		sub.w	d1,(Camera_Y_pos).w
		sub.w	d0,(Camera_X_pos_copy).w
		sub.w	d1,(Camera_Y_pos_copy).w		; Offset objects and camera positions
		move.l	#$100010,d0
		move.l	#$260,d1
		move.l	d0,(Camera_min_X_pos).w
		move.l	d0,(Camera_target_min_X_pos).w
		move.l	d1,(Camera_min_Y_pos).w
		move.l	d1,(Camera_target_min_Y_pos).w
		move.w	(Camera_X_pos_copy).w,(Events_fg_0).w
		move.w	(Camera_X_pos_copy).w,(Events_fg_1).w
		jsr	Reset_TileOffsetPositionActual(pc)
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		clr.w	(Events_routine_bg).w

loc_3AFCA:
		jsr	AIZTrans_WavyFlame(pc)
		jmp	PlainDeformation(pc)

; =============== S U B R O U T I N E =======================================


AIZ1_IntroDeform:
		move.w	(Camera_Y_pos_copy).w,(Camera_Y_pos_BG_copy).w
		move.w	(Events_fg_1).w,d0
		bmi.s	loc_3AFE2
		move.w	(Camera_X_pos_copy).w,d0

loc_3AFE2:
		asr.w	#1,d0
		lea	(HScroll_table+$028).w,a1
		cmpi.w	#$580,d0
		blt.s	loc_3AFF8
		moveq	#$25-1,d1

loc_3AFF0:
		move.w	d0,(a1)+
		dbf	d1,loc_3AFF0
		bra.s	loc_3B018
; ---------------------------------------------------------------------------

loc_3AFF8:
		move.w	d0,(a1)+
		subi.w	#$580,d0
		swap	d0
		clr.w	d0
		move.l	d0,d1
		asr.l	#5,d1
		moveq	#$24-1,d2

loc_3B008:
		add.l	d1,d0
		move.l	d0,d3
		swap	d3
		addi.w	#$580,d3
		move.w	d3,(a1)+
		dbf	d2,loc_3B008

loc_3B018:
		lea	(HScroll_table+$028).w,a1
		lea	(HScroll_table).w,a5
		move.w	(a1)+,d0
		bpl.s	loc_3B026
		moveq	#0,d0

loc_3B026:
		move.w	d0,(a5)
		addq.w	#4,a5
		moveq	#9-1,d0

loc_3B02C:
		move.w	(a1),d1
		bpl.s	loc_3B032
		moveq	#0,d1

loc_3B032:
		move.w	d1,(a5)
		addq.w	#8,a1
		addq.w	#4,a5
		dbf	d0,loc_3B02C
		rts
; End of function AIZ1_IntroDeform


; =============== S U B R O U T I N E =======================================


AIZ1_Deform:
		move.w	(Camera_Y_pos_copy).w,d0
		asr.w	#1,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Camera_X_pos_copy).w,d0
		subi.w	#$1300,d0
		swap	d0
		clr.w	d0
		asr.l	#5,d0
		move.l	d0,d2
		add.l	d0,d0
		move.l	d0,d1
		lsl.l	#3,d0
		sub.l	d1,d0
		lea	(HScroll_table+$030).w,a1
		swap	d0
		move.w	d0,(a1)
		swap	d0
		add.l	d1,d0
		swap	d0
		move.w	d0,-$2C(a1)
		move.w	d0,2(a1)
		move.w	d0,$A(a1)
		swap	d0
		add.l	d1,d0
		swap	d0
		move.w	d0,4(a1)
		move.w	d0,8(a1)
		swap	d0
		add.l	d1,d0
		swap	d0
		move.w	d0,6(a1)
		lea	(HScroll_table+$016).w,a1
		move.l	d2,d0
		swap	d0
		move.w	d0,-(a1)
		swap	d0
		move.l	(HScroll_table+$03C).w,d3
		addi.l	#$2000,(HScroll_table+$03C).w
		asr.l	#1,d0
		moveq	#5,d1

loc_3B0AE:
		add.l	d3,d0
		swap	d0
		move.w	d0,-(a1)
		swap	d0
		add.l	d2,d0
		dbf	d1,loc_3B0AE
		lea	(HScroll_table+$016).w,a1
		move.l	d2,d0
		asr.l	#3,d2
		moveq	#$C,d1

loc_3B0C6:
		add.l	d2,d0
		swap	d0
		move.w	d0,(a1)+
		swap	d0
		dbf	d1,loc_3B0C6
		rts
; End of function AIZ1_Deform

; ---------------------------------------------------------------------------

AIZ1_ApplyDeformWater:
		lea	AIZ1_DeformArray(pc),a4
		lea	(HScroll_table+$008).w,a5
		move.w	(Water_level).w,d1
		sub.w	(Camera_Y_pos_copy).w,d1
		cmpi.w	#$E0,d1
		blt.s	loc_3B0EE
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

loc_3B0EE:
		subq.w	#1,d1
		jsr	ApplyDeformation3(pc)
		move.l	a1,-(sp)
		lea	(HScroll_table+$040).w,a1
		lea	AIZ1_WaterFGDeformDelta(pc),a6
		move.w	(Water_level).w,d0
		subi.w	#$DE,d1
		neg.w	d1
		move.w	(Level_frame_counter).w,d2
		add.w	d0,d2
		add.w	d0,d2
		andi.w	#$7E,d2
		adda.w	d2,a6
		move.w	(Camera_X_pos_copy).w,d6
		neg.w	d6
		jsr	MakeFGDeformArray(pc)
		movea.l	(sp)+,a1
		lea	(HScroll_table+$040).w,a2
		lea	AIZ1_DeformArray(pc),a4
		lea	(HScroll_table+$008).w,a5
		lea	AIZ1_WaterBGDeformDelta(pc),a6
		move.w	(Water_level).w,d0
		sub.w	(Camera_Y_pos_copy).w,d0
		add.w	(Camera_Y_pos_BG_copy).w,d0
		move.w	(Level_frame_counter).w,d2
		asr.w	#1,d2
		add.w	d0,d2
		add.w	d0,d2
		andi.w	#$7E,d2
		adda.w	d2,a6
		jmp	ApplyFGandBGDeformation(pc)

; =============== S U B R O U T I N E =======================================


AIZ1_FireRise:
		cmpi.b	#6,(Player_1+routine).w
		bcc.s	.locret_3B178
		moveq	#0,d0
		move.w	(Events_bg+$02).w,d0
		addi.w	#$280,d0
		cmpi.w	#$A000,d0
		bcs.s	loc_3B16E
		move.w	#$A000,d0

loc_3B16E:
		move.w	d0,(Events_bg+$02).w
		lsl.l	#4,d0
		add.l	d0,(Camera_Y_pos_BG_copy).w

.locret_3B178:
		rts
; End of function AIZ1_FireRise


; =============== S U B R O U T I N E =======================================


AIZTrans_WavyFlame:
		cmpi.b	#6,(Player_1+routine).w
		bcc.s	.locret_3B1C4
		addq.w	#6,(_unkEE8E).w
		move.w	(_unkEE8E).w,d0
		andi.w	#$60,d0
		addi.w	#$1000,d0
		move.w	d0,(Camera_X_pos_BG_copy).w
		lea	(Vscroll_buffer).w,a1
		lea	AIZ_FlameVScroll(pc),a5
		move.w	(Camera_Y_pos_copy).w,d0
		swap	d0
		move.w	(Camera_Y_pos_BG_copy).w,d1
		move.w	(Level_frame_counter).w,d2
		asr.w	#2,d2
		moveq	#$14-1,d3

loc_3B1B0:
		addq.w	#2,d2
		andi.w	#$F,d2
		move.b	(a5,d2.w),d0
		ext.w	d0
		add.w	d1,d0
		move.l	d0,(a1)+
		dbf	d3,loc_3B1B0

.locret_3B1C4:
		rts
; End of function AIZTrans_WavyFlame

; ---------------------------------------------------------------------------

Obj_AIZTransitionFloor:
		tst.b	(Current_act).w
		beq.s	loc_3B1D8
		move.w	#$7F00,x_pos(a0)
		move.l	#Delete_Current_Sprite,(a0)

loc_3B1D8:
		move.b	#$A0,width_pixels(a0)
		bset	#7,status(a0)
		move.w	#$A0+$B,d1
		moveq	#$10,d2
		moveq	#$10,d3
		move.w	x_pos(a0),d4
		jmp	(SolidObjectFull2).l
; ---------------------------------------------------------------------------
AIZ1_IntroDrawArray:
		dc.w   $3E0,    $10,    $10,    $10,    $10,    $10,    $10,    $10,    $10, $7FFF
AIZ1_IntroDeformArray:
		dc.w   $3E0,     4,     4,     4,     4,     4,     4,     4,     4
		dc.w      4,     4,     4,     4,     4,     4,     4,     4,     4
		dc.w      4,     4,     4,     4,     4,     4,     4,     4,     4
		dc.w      4,     4,     4,     4,     4,     4,     4,     4,     4, $7FFF
AIZ1_BGDrawArray:
		dc.w   $220, $7FFF
AIZ1_DeformArray:
		dc.w    $D0,   $20,   $30,   $30,   $10,   $10,   $10, $800D,    $F,     6,    $E,   $50,   $20, $7FFF
AIZ_FlameVScroll:
		dc.b    0,  -1,  -2,  -5,  -8, -$A, -$D, -$E, -$F, -$E, -$D, -$A,  -7,  -5,  -2,  -1
		even
; ---------------------------------------------------------------------------

AIZ2_ScreenInit:
		jsr	Reset_TileOffsetPositionActual(pc)
		jmp	Refresh_PlaneFull(pc)
; ---------------------------------------------------------------------------

AIZ2_ScreenEvent:
		move.w	(Screen_shake_offset).w,d0
		add.w	d0,(Camera_Y_pos_copy).w
		move.w	(Events_routine_fg).w,d0
		jmp	.Index(pc,d0.w)
; ---------------------------------------------------------------------------

.Index:
		bra.w	AIZ2SE_Normal
; ---------------------------------------------------------------------------
		bra.w	AIZ2SE_ShipRefresh
; ---------------------------------------------------------------------------
		bra.w	AIZ2SE_ShipDraw
; ---------------------------------------------------------------------------
		bra.w	AIZ2SE_EndRefresh
; ---------------------------------------------------------------------------
		bra.w	AIZ2SE_End
; ---------------------------------------------------------------------------

AIZ2SE_Normal:
		tst.w	(Events_fg_4).w
		beq.w	DrawTilesAsYouMove		; Keep drawing as usual while flag isn't set
		clr.w	(Events_fg_4).w
		move.w	#$180,(Draw_delayed_position).w		; Set up redraw memory
		move.w	#5,(Draw_delayed_rowcount).w
		clr.l	(HScroll_table+$1F8).w
		move.w	(Camera_X_pos_copy).w,d0
		andi.w	#$FFF0,d0
		subi.w	#$10,d0
		move.w	d0,(HScroll_table+$1FE).w
		move.b	#1,(Scroll_lock).w				; Camera doesn't follow Sonic
		move.w	#4,(Special_events_routine).w
		addq.w	#4,(Events_routine_fg).w		; Set speed of automatic movement

AIZ2SE_ShipRefresh:
		move.w	#$4380,d1
		move.w	(Camera_Y_pos_copy).w,d2
		subi.w	#$10,d2
		jsr	Draw_PlaneVertBottomUp(pc)
		bpl.w	loc_3B368
		move.w	#$4020,d0
		move.w	d0,(HScroll_table+$1F6).w
		move.w	d0,(_unkEE98).w
		clr.w	(_unkEE98+2).w			; Set up secondary BG camera X
		move.w	(Camera_Y_pos_copy).w,d0
		addi.w	#$8F0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(_unkEE9C).w
		move.w	d0,(_unkEEA2).w		; Set up secondary BG camera Y
		jsr	(AllocateObject).l
		bne.s	loc_3B332
		move.l	#Obj_AIZBattleship,(a1)	; Start battleship sequence

loc_3B332:
		st	(Events_bg+$04).w
		move.l	#HInt6,(H_int_addr).w	; HInt is needed to change Y scroll value to proper amount mid-draw
		clr.b	(Water_flag).w
		move.b	#$40,(H_int_counter).w		; Set HInt position
		addq.w	#4,(Events_routine_fg).w

AIZ2SE_ShipDraw:
		tst.w	(Events_fg_4).w
		bne.s	loc_3B380				; Branch when battleship has gone off-screen
		lea	AIZ2SE_BGShipDrawArray2(pc),a4
		lea	(HScroll_table+$1F4).w,a6
		move.w	(_unkEE98).w,(a6)
		moveq	#2,d5
		move.w	(_unkEEA2).w,d6
		jsr	Draw_BGNoVert(pc)

loc_3B368:
		lea	AIZ2SE_BGShipDrawArray1(pc),a4
		lea	(HScroll_table+$1F8).w,a6
		move.w	(Camera_X_pos_copy).w,4(a6)
		moveq	#2,d5
		move.w	(Camera_Y_pos_rounded).w,d6
		jmp	Draw_BGNoVert(pc)
; ---------------------------------------------------------------------------

loc_3B380:
		clr.w	(Events_fg_4).w
		move.w	#$170,(Draw_delayed_position).w
		move.w	#4,(Draw_delayed_rowcount).w		;Set redraw memory
		addq.w	#4,(Events_routine_fg).w

AIZ2SE_EndRefresh:
		move.w	#$4380,d1
		move.w	(Camera_Y_pos_copy).w,d2
		subi.w	#$10,d2
		jsr	Draw_PlaneVertBottomUp(pc)
		bpl.s	loc_3B368
		move.w	(Camera_X_pos_copy).w,d0
		andi.w	#$FFF0,d0
		subi.w	#$10,d0
		move.w	d0,(Camera_X_pos_rounded).w
		move.w	#$46C0,(Events_bg+$02).w		; Set level X start to 46C0
		clr.w	(Events_bg+$04).w
		move.b	#-1,(H_int_counter).w
		addq.w	#4,(Events_routine_fg).w

AIZ2SE_End:
		jmp	DrawTilesAsYouMove(pc)
; ---------------------------------------------------------------------------

HInt6:
		move.w	#$8AFF,(VDP_control_port).l
		move.l	#vdpComm($0000,VSRAM,WRITE),(VDP_control_port).l
		move.w	(Camera_Y_pos_copy).w,(VDP_data_port).l
		rte
; ---------------------------------------------------------------------------
AIZ2SE_BGShipDrawArray1:
		dc.w   $180
		dc.w  $7FFF
AIZ2SE_BGShipDrawArray2:
		dc.w   $A80
		dc.w  $7FFF
; ---------------------------------------------------------------------------

AIZ2_BackgroundInit:
		move.w	(Camera_X_pos_copy).w,(Events_fg_0).w
		move.w	(Camera_X_pos_copy).w,(Events_fg_1).w
		move.w	#$C,(Events_routine_bg).w
		cmpi.w	#$3E80,(Camera_X_pos_copy).w
		blo.s	loc_3B418
		move.w	#$14,(Events_routine_bg).w
		move.w	#$4440,(Events_bg+$02).w

loc_3B418:
		jsr	AIZ2_Deform(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		moveq	#0,d1
		jsr	Refresh_PlaneFull(pc)
		jmp	AIZ2_ApplyDeform(pc)
; ---------------------------------------------------------------------------

AIZ2_BackgroundEvent:
		lea	(Events_fg_0).w,a1
		move.w	(Camera_X_pos_copy).w,d0
		move.w	#$100,d2
		move.w	#$200,d3
		jsr	Adjust_BGDuringLoop(pc)
		move.w	(Events_routine_bg).w,d0
		jmp	.Index(pc,d0.w)
; ---------------------------------------------------------------------------

.Index:
		bra.w	AIZ2BGE_FireRedraw
; ---------------------------------------------------------------------------
		bra.w	AIZ2BGE_WaitFire
; ---------------------------------------------------------------------------
		bra.w	AIZ2BGE_BGRedraw
; ---------------------------------------------------------------------------
		bra.w	AIZ2BGE_Normal
; ---------------------------------------------------------------------------
		bra.w	AIZ2BGE_ShipRefresh
; ---------------------------------------------------------------------------
		bra.w	AIZ2BGE_ShipMove
; ---------------------------------------------------------------------------

AIZ2BGE_FireRedraw:
		lea	(Level_layout_main).w,a3
		move.w	#VRAM_Plane_A_Name_Table,d7
		move.w	(Camera_X_pos_copy).w,d1
		move.w	(Camera_Y_pos_copy).w,d2
		jsr	Draw_PlaneVertBottomUp(pc)
		bmi.s	loc_3B480
		jsr	AIZ1_FireRise(pc)
		jsr	AIZTrans_WavyFlame(pc)
		jmp	PlainDeformation(pc)
; ---------------------------------------------------------------------------

loc_3B480:
		addq.w	#2,a3
		move.w	#VRAM_Plane_B_Name_Table,d7
		clr.w	(Events_bg+$00).w
		addq.w	#4,(Events_routine_bg).w

AIZ2BGE_WaitFire:
		jsr	AIZ1_FireRise(pc)
		jsr	AIZTrans_WavyFlame(pc)
		tst.w	(Events_bg+$00).w
		bne.s	loc_3B4CC
		move.w	(Camera_Y_pos_BG_copy).w,d0
		andi.w	#$7F,d0
		cmpi.w	#$20,d0
		blo.s	loc_3B4B0
		cmpi.w	#$30,d0
		blo.s	loc_3B4B4

loc_3B4B0:
		jmp	PlainDeformation(pc)
; ---------------------------------------------------------------------------

loc_3B4B4:
		addi.w	#$180,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		and.w	(Camera_Y_pos_mask).w,d0
		subi.w	#$10,d0
		move.w	d0,(Camera_Y_pos_BG_rounded).w
		st	(Events_bg+$00).w

loc_3B4CC:
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		move.w	#$200,d1
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)
		cmpi.w	#$310,(Camera_Y_pos_BG_copy).w
		blo.s	loc_3B544			; If fire hasn't subsided, branch
		movem.l	d7-a0/a2-a3,-(sp)
		moveq	#$C,d0
		jsr	(Load_PLC).l
		jsr	(LoadEnemyArt).l
		movem.l	(sp)+,d7-a0/a2-a3
		lea	(Normal_palette_line_4+$2).w,a1
		move.l	#$8EE00AA,(a1)+
		move.l	#$8E004E,(a1)+
		move.l	#$2E000C,(a1)
		move.w	#$6000,d0
		move.w	d0,(Camera_max_X_pos).w
		move.w	d0,(Camera_target_max_X_pos).w
		jsr	AIZ2_Deform(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w		; Set up Effective BG Y location for screen redraw
		move.w	#$F,(Draw_delayed_rowcount).w		; Set up redraw count
		move.w	#$C,(Special_V_int_routine).w
		addq.w	#4,(Events_routine_bg).w
		bra.s	loc_3B56E
; ---------------------------------------------------------------------------

loc_3B544:
		jsr	AIZ2_ApplyDeform(pc)
		lea	(H_scroll_buffer+2).w,a1
		move.w	(Camera_X_pos_BG_copy).w,d0	; Cancel out background deformation since we're still in the open field
		neg.w	d0
		moveq	#$38-1,d1

loc_3B554:
		move.w	d0,(a1)
		addq.w	#4,a1
		move.w	d0,(a1)
		addq.w	#4,a1
		move.w	d0,(a1)
		addq.w	#4,a1
		move.w	d0,(a1)
		addq.w	#4,a1
		dbf	d1,loc_3B554
		rts
; ---------------------------------------------------------------------------

AIZ2BGE_BGRedraw:
		jsr	AIZ2_Deform(pc)

loc_3B56E:
		moveq	#0,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		jsr	Draw_PlaneVertBottomUp(pc)
		bpl.s	loc_3B5C8
		addq.w	#4,(Events_routine_bg).w
		bra.s	loc_3B5C8
; ---------------------------------------------------------------------------

AIZ2BGE_Normal:
		jsr	AIZ2_Deform(pc)
		tst.w	(Events_fg_5).w
		beq.s	loc_3B5C8
		clr.w	(Events_fg_5).w
		move.w	#$A8,d0
		cmpi.w	#$400,(Camera_Y_pos_copy).w
		blo.s	loc_3B59E
		move.w	#-$198,d0

loc_3B59E:
		move.w	d0,(Events_bg+$16).w
		add.w	d0,(Camera_Y_pos_BG_copy).w
		jsr	Reset_TileOffsetPositionEff(pc)
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		move.w	#$4440,(Events_bg+$02).w
		addq.w	#4,(Events_routine_bg).w
		bra.s	loc_3B5E4
; ---------------------------------------------------------------------------

loc_3B5C8:
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)
		jsr	AIZ2_ApplyDeform(pc)
		jmp	ShakeScreen_Setup(pc)
; ---------------------------------------------------------------------------

AIZ2BGE_ShipRefresh:
		jsr	AIZ2_Deform(pc)

loc_3B5E4:
		moveq	#0,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		jsr	Draw_PlaneVertBottomUp(pc)
		bpl.s	loc_3B5FA
		addq.w	#4,(Events_routine_bg).w
		bra.s	loc_3B5FA
; ---------------------------------------------------------------------------

AIZ2BGE_ShipMove:
		jsr	AIZ2_Deform(pc)

loc_3B5FA:
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)
		jsr	AIZ2_ApplyDeform(pc)
		tst.w	(Events_bg+$04).w
		beq.s	loc_3B622
		move.w	(_unkEE9C).w,(V_scroll_value).w		; Use effective camera position rather than actual camera position
		move.w	(Camera_Y_pos_BG_copy).w,(V_scroll_value_BG).w
		addq.w	#4,sp		; Skip last part of ScreenEvents

loc_3B622:
		jmp	ShakeScreen_Setup(pc)

; =============== S U B R O U T I N E =======================================


AIZ2_Deform:
		move.w	(Camera_Y_pos_copy).w,d0
		move.w	(Screen_shake_offset).w,d1
		sub.w	d1,d0
		asr.w	#1,d0
		add.w	d1,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		cmpi.w	#$10,(Events_routine_bg).w
		bcs.s	loc_3B648
		move.w	(Events_bg+$16).w,d0
		add.w	d0,(Camera_Y_pos_BG_copy).w

loc_3B648:
		move.w	(Events_fg_1).w,d0
		swap	d0
		clr.w	d0
		asr.l	#1,d0
		move.l	d0,d1
		asr.l	#5,d1
		move.l	d1,d2
		add.l	d1,d1
		add.l	d2,d1
		lea	(HScroll_table+$1C0).w,a1
		lea	AIZ2_BGDeformMake(pc),a5
		moveq	#0,d2

loc_3B666:
		move.b	(a5)+,d3
		bmi.s	.locret_3B67E
		ext.w	d3
		swap	d0

loc_3B66E:
		move.b	(a5)+,d2
		move.w	d0,(a1,d2.w)
		dbf	d3,loc_3B66E
		swap	d0
		add.l	d1,d0
		bra.s	loc_3B666
; ---------------------------------------------------------------------------

.locret_3B67E:
		rts
; End of function AIZ2_Deform


; =============== S U B R O U T I N E =======================================


AIZ2_ApplyDeform:
		lea	(HScroll_table).w,a1
		lea	AIZ2_FGDeformDelta(pc),a6
		move.w	(Camera_Y_pos_copy).w,d0
		move.w	#$DF,d1
		move.w	(Level_frame_counter).w,d2
		add.w	d0,d2
		add.w	d0,d2
		moveq	#$3E,d3
		move.w	(Camera_X_pos_copy).w,d6
		neg.w	d6
		move.w	(Water_level).w,d4
		sub.w	d0,d4
		bls.s	loc_3B6CA			; If completely underwater, only do water deformation
		cmp.w	d1,d4
		bhi.s	loc_3B6D0			; If water isn't showing at all, only do non-water deformation
		move.w	d4,d1				; Otherwise, just do both
		subq.w	#1,d1
		and.w	d3,d2
		adda.w	d2,a6
		jsr	MakeFGDeformArray(pc)
		move.w	(Water_level).w,d0
		subi.w	#$DE,d1
		neg.w	d1
		move.w	(Level_frame_counter).w,d2
		add.w	d0,d2
		add.w	d0,d2

loc_3B6CA:
		lea	AIZ1_WaterFGDeformDelta(pc),a6
		moveq	#$7E,d3

loc_3B6D0:
		and.w	d3,d2
		adda.w	d2,a6
		jsr	MakeFGDeformArray(pc)
		lea	(H_scroll_buffer).w,a1
		lea	(HScroll_table).w,a2
		lea	AIZ2_BGDeformArray(pc),a4
		lea	(HScroll_table+$1C0).w,a5
		lea	AIZ2_ALZ_BGDeformDelta(pc),a6
		move.w	(Camera_Y_pos_BG_copy).w,d0
		move.w	#$DF,d1
		move.w	(Level_frame_counter).w,d2
		asr.w	#1,d2
		add.w	d0,d2
		add.w	d0,d2
		moveq	#$3E,d3
		move.w	(Water_level).w,d4
		sub.w	(Camera_Y_pos_copy).w,d4
		bls.s	loc_3B73E			; Same as above, if completely underwater only apply water deformation
		cmp.w	d1,d4
		bhi.s	loc_3B744			; Same as above, if no water is showing, only do above-ground deformation
		move.w	d4,d1				; Otherwise, just do both
		subq.w	#1,d1
		and.w	d3,d2
		adda.w	d2,a6
		jsr	ApplyFGandBGDeformation(pc)
		lea	AIZ2_BGDeformArray(pc),a4
		lea	(HScroll_table+$1C0).w,a5
		move.w	(Water_level).w,d0
		sub.w	(Camera_Y_pos_copy).w,d0
		add.w	(Camera_Y_pos_BG_copy).w,d0
		subi.w	#$DE,d1
		neg.w	d1
		move.w	(Level_frame_counter).w,d2
		asr.w	#1,d2
		add.w	d0,d2
		add.w	d0,d2

loc_3B73E:
		lea	AIZ1_WaterBGDeformDelta(pc),a6
		moveq	#$7E,d3

loc_3B744:
		and.w	d3,d2
		adda.w	d2,a6
		jsr	ApplyFGandBGDeformation(pc)
		tst.w	(Events_bg+$04).w
		beq.s	.locret_3B772
		lea	(H_scroll_buffer).w,a1		; This is for what I assume to be the flying battleship sequence.
		move.w	(_unkEE98).w,d0			; Nullifies the top 8 tiles worth of FG waviness for this effect
		neg.w	d0						; And replaces it with position data from the second BG camera.
		moveq	#$10-1,d1

loc_3B75E:
		move.w	d0,(a1)
		addq.w	#4,a1
		move.w	d0,(a1)
		addq.w	#4,a1
		move.w	d0,(a1)
		addq.w	#4,a1
		move.w	d0,(a1)
		addq.w	#4,a1
		dbf	d1,loc_3B75E

.locret_3B772:
		rts
; End of function AIZ2_ApplyDeform

; ---------------------------------------------------------------------------

AIZ2_DoShipLoop:
		clr.w	(Level_repeat_offset).w
		move.w	(Camera_X_pos).w,d0
		addq.w	#4,d0
		cmp.w	(Events_bg+$02).w,d0
		blo.s	loc_3B7A8
		move.w	#$200,d1			; Do loop
		move.w	d1,(Level_repeat_offset).w
		sub.w	d1,(Player_1+x_pos).w
		sub.w	d1,(Player_2+x_pos).w	; Subtract $200 from X position of Sonic and Tails
		sub.w	d1,d0
		move.w	d0,d1
		andi.w	#$FFF0,d1
		subi.w	#$10,d1
		move.w	d1,(Camera_X_pos_rounded).w
		move.w	d1,(HScroll_table+$1FE).w

loc_3B7A8:
		move.w	d0,(Camera_X_pos).w
		move.w	d0,(Camera_X_pos_copy).w
		move.w	d0,(Camera_min_X_pos).w
		move.w	d0,(Camera_max_X_pos).w	; Set all the camera/start positions
		addi.w	#$18,d0
		cmp.w	(Player_1+x_pos).w,d0
		bls.s	loc_3B7CE
		move.w	d0,(Player_1+x_pos).w			; Make sure Sonic stays on-screen
		move.w	#$400,(Player_1+ground_vel).w		; Set his running velocity to $400 if the left of screen is hit
		bra.s	locret_3B7DC
; ---------------------------------------------------------------------------

loc_3B7CE:
		addi.w	#$88,d0
		cmp.w	(Player_1+x_pos).w,d0
		bhi.s	locret_3B7DC
		move.w	d0,(Player_1+x_pos).w			; Make sure Sonic can't go past a certain point to the right

locret_3B7DC:
		rts
; ---------------------------------------------------------------------------

Obj_AIZBattleship:
		move.l	#Obj_AIZBattleshipMain,(a0)
		move.l	#AIZBattleship_BombScript,$2E(a0)
		move.w	#$1A4,$32(a0)
		move.w	#$3FBC,d1
		moveq	#2-1,d2

loc_3B7F8:
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	loc_3B812
		move.l	#Obj_BattleshipPropeller,(a1)	; Create two propellers, one at the front and one in the back
		move.w	d1,$2E(a1)
		move.w	#$3DCC,d1
		dbf	d2,loc_3B7F8

loc_3B812:
		lea	(Normal_palette_line_2).w,a1
		lea	Pal_AIZBattleship(pc),a5
		moveq	#bytesToLcnt($20),d0

loc_3B81C:
		move.l	(a5)+,(a1)+
		dbf	d0,loc_3B81C

Obj_AIZBattleshipMain:
		subi.l	#$8800,(_unkEE98).w
		move.w	(_unkEE98).w,d0
		cmpi.w	#$3CDC,d0
		bpl.s	loc_3B84E
		move.l	#Obj_AIZ2BossSmall,(a0)
		st	(Events_fg_4).w				; Set for the next screen event
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	locret_3B84C
		move.l	#Obj_AIZ2MakeTree,(a1)

locret_3B84C:
		rts
; ---------------------------------------------------------------------------

loc_3B84E:
		move.w	d0,d1
		subi.w	#$3D5C,d0
		bpl.s	loc_3B864
		neg.w	d0					; Move upwards as the battleship goes offscreen
		asr.w	#1,d0
		add.w	(_unkEEA2).w,d0
		move.w	d0,(_unkEE9C).w
		bra.s	loc_3B87A
; ---------------------------------------------------------------------------

loc_3B864:
		asr.w	#2,d1			; Continue bobbing up and down
		andi.w	#$F,d1
		lea	AIZBattleShip_BobbingMotion(pc),a1
		move.b	(a1,d1.w),d1
		add.w	(_unkEEA2).w,d1
		move.w	d1,(_unkEE9C).w	; Get the bobbing motion delta, apply it to the second camera Y

loc_3B87A:
		move.w	(Level_frame_counter).w,d0
		subq.w	#1,d0
		andi.w	#$F,d0
		bne.s	loc_3B88E
		moveq	#signextendB(sfx_LargeShip),d0			; Replay the battleship flying sound every 16th frame
		jsr	(Play_SFX).l

loc_3B88E:
		subq.w	#1,$32(a0)			; Wait for delay to finish
		bcc.s	locret_3B8B4
		movea.l	$2E(a0),a2
		move.w	(a2)+,$32(a0)		; Get the first word of the bomb script as the new delay
		bmi.s	locret_3B8B4
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	locret_3B8B4
		move.l	#Obj_AIZShipBomb,(a1)		; Create a new bomb
		move.w	(a2)+,$2E(a1)		; Put the X position into $2E so it can be translated
		move.l	a2,$2E(a0)			; Update the script position

locret_3B8B4:
		rts
; ---------------------------------------------------------------------------

Obj_BattleshipPropeller:
		move.l	#Obj_BattleshipPropellerMain,(a0)
		move.b	#4,render_flags(a0)
		move.b	#$20,height_pixels(a0)
		move.b	#8,width_pixels(a0)
		move.w	#$80,priority(a0)
		move.w	#make_art_tile($500,0,0),art_tile(a0)
		move.l	#Map_AIZShipPropeller,mappings(a0)
		move.w	#$A71,$30(a0)

Obj_BattleshipPropellerMain:
		cmpi.w	#$C,(Events_routine_fg).w
		bne.s	loc_3B8F6
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_3B8F6:
		lea	Ani_AIZShipPropeller(pc),a1
		jsr	(Animate_Sprite).l
		jsr	Translate_Camera2ObjPosition(pc)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_AIZShipBomb:
		move.l	#.Main,(a0)
		move.b	#4,render_flags(a0)
		move.b	#$18,width_pixels(a0)
		move.w	#$80,priority(a0)
		move.w	#make_art_tile($500,0,0),art_tile(a0)
		move.l	#Map_AIZ2BombExplode,mappings(a0)
		move.b	#$10,y_radius(a0)
		move.w	#$A60,$30(a0)
		move.w	#6,$32(a0)

.Main:
		moveq	#0,d0
		move.b	routine(a0),d0
		jmp	.Index(pc,d0.w)
; ---------------------------------------------------------------------------

.Index:
		bra.w	AIZShipBomb_ReadyDrop
; ---------------------------------------------------------------------------
		bra.w	AIZShipBomb_Delay
; ---------------------------------------------------------------------------
		bra.w	AIZShipBomb_Drop
; ---------------------------------------------------------------------------

AIZShipBomb_ReadyDrop:
		addq.w	#2,$30(a0)
		cmpi.w	#$A80,$30(a0)		; Put bomb into position before delay
		blo.s	loc_3B97C
		addq.b	#4,routine(a0)
		bra.s	loc_3B97C
; ---------------------------------------------------------------------------

AIZShipBomb_Delay:
		subq.w	#1,$32(a0)
		bne.s	loc_3B97C
		addq.b	#4,routine(a0)
		moveq	#signextendB(sfx_MissileThrow),d0
		jsr	(Play_SFX).l		; Play the drop sound after the delay

loc_3B97C:
		jsr	Translate_Camera2ObjPosition(pc)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

AIZShipBomb_Drop:
		move.l	y_pos(a0),d0
		add.l	y_vel(a0),d0
		move.l	d0,y_pos(a0)			; Drop bomb downwards
		addi.l	#$2000,y_vel(a0)		; Increase acceleration
		swap	d0
		jsr	Translate_Camera2ObjX(pc)
		jsr	(Draw_Sprite).l
		jsr	(ObjCheckFloorDist).l
		cmpi.w	#-8,d1
		bgt.s	locret_3BA04
		move.w	#$10,(Screen_shake_flag).w	; If touching the floor, set up a timed screen shake
		moveq	#signextendB(sfx_MissileExplode),d0
		jsr	(Play_SFX).l		; Play the bomb explosion sound
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	loc_3B9FE
		lea	AIZBombExplodeDat(pc),a2
		moveq	#8-1,d1

loc_3B9CE:
		move.l	#Obj_AIZBombExplosion,(a1)
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		move.w	(a2)+,d2
		add.w	d2,x_pos(a1)
		move.w	(a2)+,d2
		add.w	d2,y_pos(a1)
		move.w	(a2)+,anim(a1)
		move.w	(a2)+,$2E(a1)
		jsr	(CreateNewSprite4).l
		dbne	d1,loc_3B9CE

loc_3B9FE:
		move.l	#Delete_Current_Sprite,(a0)		; Delete the bomb sprite

locret_3BA04:
		rts

; =============== S U B R O U T I N E =======================================


Translate_Camera2ObjPosition:
		move.w	$30(a0),d0
		sub.w	(_unkEE9C).w,d0
		add.w	(Camera_Y_pos_copy).w,d0

Translate_Camera2ObjX:
		sub.w	(Screen_shake_last_offset).w,d0
		add.w	(Screen_shake_offset).w,d0
		move.w	d0,y_pos(a0)
		move.w	$2E(a0),d0
		sub.w	(_unkEE98).w,d0
		add.w	(Camera_X_pos_copy).w,d0
		move.w	d0,x_pos(a0)
		rts
; End of function Translate_Camera2ObjPosition

; ---------------------------------------------------------------------------

Obj_AIZBombExplosion:
		move.w	(Level_repeat_offset).w,d0
		sub.w	d0,x_pos(a0)
		subq.w	#1,$2E(a0)
		bmi.s	loc_3BA40
		rts
; ---------------------------------------------------------------------------

loc_3BA40:
		move.l	#Obj_AIZBombExplosionAnim,(a0)
		move.b	#4,render_flags(a0)
		move.b	#$20,width_pixels(a0)
		move.w	#make_art_tile($500,0,0),art_tile(a0)
		move.l	#Map_AIZ2BombExplode,mappings(a0)
		move.b	#$8B,collision_flags(a0)
		bra.s	loc_3BA70
; ---------------------------------------------------------------------------

Obj_AIZBombExplosionAnim:
		move.w	(Level_repeat_offset).w,d0
		sub.w	d0,x_pos(a0)

loc_3BA70:
		lea	Ani_AIZ2BombExplode(pc),a1
		jsr	(Animate_SpriteIrregularDelay).l
		tst.b	routine(a0)
		beq.s	loc_3BA86
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_3BA86:
		moveq	#4,d0
		add.b	anim(a0),d0
		cmp.b	mapping_frame(a0),d0
		bls.s	loc_3BA98
		jsr	(Add_SpriteToCollisionResponseList).l

loc_3BA98:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_AIZ2MakeTree:
		cmpi.w	#$44D0,(Camera_X_pos_copy).w
		bhs.s	loc_3BAA8
		rts
; ---------------------------------------------------------------------------

loc_3BAA8:
		move.l	#loc_3BABC,(a0)
		move.w	(Events_fg_1).w,$2E(a0)
		move.l	#AIZMakeTreeScript,$30(a0)

loc_3BABC:
		movea.l	$30(a0),a2
		tst.w	(a2)
		bpl.s	loc_3BACA
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_3BACA:
		move.w	(Events_fg_1).w,d0
		sub.w	$2E(a0),d0
		cmp.w	(a2)+,d0
		blo.s	locret_3BAEC
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	locret_3BAEC
		move.l	#Obj_AIZ2BGTree,(a1)
		move.w	(a2)+,8(a1)
		move.l	a2,$30(a0)

locret_3BAEC:
		rts
; ---------------------------------------------------------------------------

Obj_AIZ2BGTree:
		move.l	#Obj_AIZ2BGTreeMove,(a0)
		move.w	#make_art_tile($438,0,0),art_tile(a0)
		move.l	#Map_AIZ2BGTree,mappings(a0)
		move.w	#$E9,y_pos(a0)
		move.w	#$1C0,$2E(a0)
		move.w	(Events_fg_1).w,$30(a0)

Obj_AIZ2BGTreeMove:
		cmpi.w	#$4880,(Camera_X_pos_copy).w
		blo.s	loc_3BB22
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_3BB22:
		move.w	(Events_fg_1).w,d0
		sub.w	$30(a0),d0
		move.w	d0,d1
		asr.w	#2,d0
		sub.w	d0,d1
		move.w	$2E(a0),d0
		sub.w	d1,d0
		move.w	d0,x_pos(a0)
		cmpi.w	#$1C0,d0
		bhs.s	locret_3BB46
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

locret_3BB46:
		rts
; ---------------------------------------------------------------------------

Obj_AIZ2BossSmall:
		move.l	#Obj_AIZ2BossSmallMain,(a0)
		move.w	#$300,priority(a0)
		move.w	#make_art_tile($500,0,0),art_tile(a0)
		move.l	#Map_AIZ2BossSmall,mappings(a0)
		move.w	#$30,x_pos(a0)
		move.w	#$D8,y_pos(a0)
		move.w	#5,x_vel(a0)
		clr.w	$2E(a0)
		lea	(Normal_palette_line_2+$2).w,a1
		lea	Pal_AIZBossSmall(pc),a5
		moveq	#bytesToLcnt($1C),d0

loc_3BB82:
		move.l	(a5)+,(a1)+
		dbf	d0,loc_3BB82

Obj_AIZ2BossSmallMain:
		tst.b	$2E(a0)
		bne.s	loc_3BB9A
		cmpi.w	#$4670,(Camera_X_pos_copy).w
		blo.s	locret_3BC04
		st	$2E(a0)

loc_3BB9A:
		cmpi.w	#$240,x_pos(a0)
		blo.s	loc_3BBBA
		clr.b	(Scroll_lock).w
		clr.w	(Special_events_routine).w
		clr.w	(Level_repeat_offset).w			; Stop repeating scrolling section
		move.w	#$6000,(Camera_max_X_pos).w	; Change level size
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_3BBBA:
		move.l	x_pos(a0),d0
		move.l	x_vel(a0),d1		; Move Robotnik
		add.l	d1,d0
		move.l	d0,x_pos(a0)
		tst.b	$2F(a0)
		bne.s	loc_3BBE0
		subi.l	#$E80,d1		; Phase 1: Slow down until moving slightly to the left
		cmpi.l	#-$10000,d1
		sle	$2F(a0)
		bra.s	loc_3BBE6
; ---------------------------------------------------------------------------

loc_3BBE0:
		addi.l	#$E80,d1		; Phase 2: Speed up till moving off screen

loc_3BBE6:
		move.l	d1,x_vel(a0)
		jsr	(Draw_Sprite).l
		move.w	(Level_frame_counter).w,d0
		subq.w	#1,d0
		andi.w	#$F,d0
		bne.s	locret_3BC04
		moveq	#signextendB(sfx_RobotnikSiren),d0		; Every sixteenth frame, play alarm sound
		jsr	(Play_SFX).l

locret_3BC04:
		rts
; ---------------------------------------------------------------------------
AIZ2_BGDeformArray:
		dc.w    $10,   $20,   $38,   $58,   $28,   $40,   $38,   $18,   $18,   $90,   $48,   $10,   $18
		dc.w    $20,   $38,   $58,   $28,   $40,   $38,   $18,   $18,   $90,   $48,   $10, $7FFF
AIZ2_BGDeformMake:
		dc.b  2-1, $12, $2A
		dc.b  4-1, $10, $14, $28, $2C
		dc.b  4-1,  $E, $16, $26, $2E
		dc.b  5-1,   0,  $C, $18, $24, $30
		dc.b  4-1,   2,  $A, $1A, $22
		dc.b  4-1,   4,   8, $1C, $20
		dc.b  2-1,   6, $1E
		dc.b  $FF
		even
AIZ2_FGDeformDelta:
		dc.w   0,  0,  1,  1,  0,  0,  0,  0,  1,  0,  0,  0,  0,  1,  0,  0
		dc.w   0,  0,  0,  0,  0,  0,  0,  0,  0,  1,  0,  0,  1,  1,  0,  0
		dc.w   0,  0,  1,  1,  0,  0,  0,  0,  1,  0,  0,  0,  0,  1,  0,  0
		dc.w   0,  0,  0,  0,  0,  0,  0,  0,  0,  1,  0,  0,  1,  1,  0,  0
		dc.w   0,  0,  1,  1,  0,  0,  0,  0,  1,  0,  0,  0,  0,  1,  0,  0
		dc.w   0,  0,  0,  0,  0,  0,  0,  0,  0,  1,  0,  0,  1,  1,  0,  0
		dc.w   0,  0,  1,  1,  0,  0,  0,  0,  1,  0,  0,  0,  0,  1,  0,  0
		dc.w   0,  0,  0,  0,  0,  0,  0,  0,  0,  1,  0,  0,  1,  1,  0,  0
		dc.w   0,  0,  1,  1,  0,  0,  0,  0,  1,  0,  0,  0,  0,  1,  0,  0
		dc.w   0,  0,  0,  0,  0,  0,  0,  0,  0,  1,  0,  0,  1,  1,  0,  0
		dc.w   0,  0,  1,  1,  0,  0,  0,  0,  1,  0,  0,  0,  0,  1,  0,  0
		dc.w   0,  0,  0,  0,  0,  0,  0,  0,  0,  1,  0,  0,  1,  1,  0,  0
		dc.w   0,  0,  1,  1,  0,  0,  0,  0,  1,  0,  0,  0,  0,  1,  0,  0
		dc.w   0,  0,  0,  0,  0,  0,  0,  0,  0,  1,  0,  0,  1,  1,  0,  0
		dc.w   0,  0,  1,  1,  0,  0,  0,  0,  1,  0,  0,  0,  0,  1,  0,  0
		dc.w   0,  0,  0,  0,  0,  0,  0,  0,  0,  1,  0,  0,  1,  1,  0,  0
AIZ2_ALZ_BGDeformDelta:
		dc.w  -2,  1,  2,  2, -1,  2,  2,  1,  2, -1, -2, -2, -2,  1, -1, -1
		dc.w  -1,  0, -2,  0,  0,  0, -2,  0, -2,  2,  0, -2,  2,  2, -1, -2
		dc.w  -2,  1,  2,  2, -1,  2,  2,  1,  2, -1, -2, -2, -2,  1, -1, -1
		dc.w  -1,  0, -2,  0,  0,  0, -2,  0, -2,  2,  0, -2,  2,  2, -1, -2
		dc.w  -2,  1,  2,  2, -1,  2,  2,  1,  2, -1, -2, -2, -2,  1, -1, -1
		dc.w  -1,  0, -2,  0,  0,  0, -2,  0, -2,  2,  0, -2,  2,  2, -1, -2
		dc.w  -2,  1,  2,  2, -1,  2,  2,  1,  2, -1, -2, -2, -2,  1, -1, -1
		dc.w  -1,  0, -2,  0,  0,  0, -2,  0, -2,  2,  0, -2,  2,  2, -1, -2
		dc.w  -2,  1,  2,  2, -1,  2,  2,  1,  2, -1, -2, -2, -2,  1, -1, -1
		dc.w  -1,  0, -2,  0,  0,  0, -2,  0, -2,  2,  0, -2,  2,  2, -1, -2
		dc.w  -2,  1,  2,  2, -1,  2,  2,  1,  2, -1, -2, -2, -2,  1, -1, -1
		dc.w  -1,  0, -2,  0,  0,  0, -2,  0, -2,  2,  0, -2,  2,  2, -1, -2
		dc.w  -2,  1,  2,  2, -1,  2,  2,  1,  2, -1, -2, -2, -2,  1, -1, -1
		dc.w  -1,  0, -2,  0,  0,  0, -2,  0, -2,  2,  0, -2,  2,  2, -1, -2
		dc.w  -2,  1,  2,  2, -1,  2,  2,  1,  2, -1, -2, -2, -2,  1, -1, -1
		dc.w  -1,  0, -2,  0,  0,  0, -2,  0, -2,  2,  0, -2,  2,  2, -1, -2
Pal_AIZBattleship:
		binclude "Levels/AIZ/Palettes/Battleship.bin"
		even
Pal_AIZBossSmall:
		binclude "Levels/AIZ/Palettes/Boss Small.bin"
		even
AIZBattleShip_BobbingMotion:
		dc.b    4,   4,   3,   3,   2,   1,   1,   0,   0,   0,   1,   1,   2,   3,   3,   4
		even
AIZBattleship_BombScript:
		dc.w    $20, $3F5C
		dc.w    $20, $3F2C
		dc.w    $20, $3F5C
		dc.w    $20, $3F2C
		dc.w    $20, $3F5C
		dc.w    $38, $3F2C
		dc.w    $20, $3EDC
		dc.w    $20, $3EAC
		dc.w    $20, $3EDC
		dc.w    $20, $3EAC
		dc.w    $20, $3EDC
		dc.w    $38, $3EAC
		dc.w    $20, $3E5C
		dc.w    $20, $3E2C
		dc.w    $20, $3E5C
		dc.w    $20, $3E2C
		dc.w    $20, $3E5C
		dc.w    $38, $3E2C
		dc.w    $40, $3DEC
		dc.w    $40, $3DEC
		dc.w    $40, $3DEC
		dc.w  $FFFF
AIZBombExplodeDat:
		dc.w      0,  -$3C, (0<<8)|0,    $A ; X offset, Y offset, animation number, animation delay
		dc.w      0,   -$C, (1<<8)|1,     9
		dc.w     -4,  -$34, (0<<8)|0,     8
		dc.w     $C,    -4, (1<<8)|1,     7
		dc.w    -$C,    -4, (1<<8)|1,     5
		dc.w      8,  -$24, (0<<8)|0,     4
		dc.w     -8,  -$1C, (0<<8)|0,     2
		dc.w      0,   -$C, (0<<8)|0,     0
AIZMakeTreeScript:
		dc.w      0,  $280
		dc.w    $32,  $380
		dc.w    $8E,  $280
		dc.w   $103,  $380
		dc.w   $179,  $280
		dc.w   $1C6,  $380
		dc.w   $233,  $280
		dc.w   $2A0,  $380
		dc.w   $30A,  $280
		dc.w   $37C,  $380
		dc.w   $3C7,  $280
		dc.w   $401,  $380
		dc.w   $439,  $280
		dc.w   $46E,  $380
		dc.w   $4CA,  $280
		dc.w   $50C,  $380
		dc.w   $557,  $280
		dc.w  $FFFF
Map_AIZShipPropeller:
		include "Levels/AIZ/Misc Object Data/Map - Act 2 Ship Propeller.asm"
Ani_AIZShipPropeller:
		include "Levels/AIZ/Misc Object Data/Anim - Act 2 Ship Propeller.asm"
Map_AIZ2BombExplode:
		include "Levels/AIZ/Misc Object Data/Map - Act 2 Bomb Explosion.asm"
Ani_AIZ2BombExplode:
		include "Levels/AIZ/Misc Object Data/Anim - Act 2 Bomb Explosion.asm"
Map_AIZ2BGTree:
		include "Levels/AIZ/Misc Object Data/Map - Act 2 Background Tree.asm"
Map_AIZ2BossSmall:
		include "Levels/AIZ/Misc Object Data/Map - Act 2 Boss Small.asm"
; ---------------------------------------------------------------------------

HCZ1_ScreenInit:
		clr.w	(Events_bg+$16).w
		jsr	Reset_TileOffsetPositionActual(pc)
		jmp	Refresh_PlaneFull(pc)
; ---------------------------------------------------------------------------

HCZ1_ScreenEvent:
		jmp	DrawTilesAsYouMove(pc)
; ---------------------------------------------------------------------------

HCZ1_BackgroundInit:
		jsr	HCZ1_Deform(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		moveq	#0,d1
		jsr	Refresh_PlaneFull(pc)
		moveq	#$60,d0
		cmp.w	(Events_bg+$10).w,d0
		blt.s	loc_3C2BA
		neg.w	d0
		cmp.w	(Events_bg+$10).w,d0
		bgt.s	loc_3C2BE

loc_3C2BA:
		move.w	d0,(Events_bg+$10).w		; Cap dynamic art reloading value at $60 either way

loc_3C2BE:
		lea	HCZ1_BGDeformArray(pc),a4
		lea	(HScroll_table).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

HCZ1_BackgroundEvent:
		move.w	(Events_routine_bg).w,d0
		jmp	.Index(pc,d0.w)
; ---------------------------------------------------------------------------

.Index:
		bra.w	HCZ1BGE_Normal
; ---------------------------------------------------------------------------
		bra.w	HCZ1BGE_DoTransition
; ---------------------------------------------------------------------------

HCZ1BGE_Normal:
		tst.w	(Events_fg_5).w
		beq.s	loc_3C336
		clr.w	(Events_fg_5).w				; Do transition
		movem.l	d7-a0/a2-a3,-(sp)
		lea	(HCZ2_128x128_Secondary_Kos).l,a1
		lea	(RAM_start+$A00).l,a2
		jsr	(Queue_Kos).l
		lea	(HCZ2_16x16_Secondary_Kos).l,a1
		lea	(Block_table+$558).w,a2
		jsr	(Queue_Kos).l
		lea	(HCZ2_8x8_Secondary_KosM).l,a1	; Load secondary HCZ2 art, blocks, and chunks so as to not compromise current position
		move.w	#tiles_to_bytes($11B),d2
		jsr	(Queue_Kos_Module).l
		moveq	#$10,d0
		jsr	(Load_PLC).l
		moveq	#$11,d0
		jsr	(Load_PLC).l					; load HCZ 2 PLCs
		movem.l	(sp)+,d7-a0/a2-a3
		st	(Events_bg+$16).w
		addq.w	#4,(Events_routine_bg).w

loc_3C336:
		jsr	HCZ1_Deform(pc)
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)
		lea	HCZ1_BGDeformArray(pc),a4
		lea	(HScroll_table).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

HCZ1BGE_DoTransition:
		tst.b	(Kos_modules_left).w
		bne.w	loc_3C3E6			; Don't do anything else until Kos queue has been cleared
		move.w	#$101,(Current_zone_and_act).w	; Change the act
		clr.b	(Dynamic_resize_routine).w		; Reload resize routine counter
		clr.b	(Object_load_routine).w		; Reload sprite manager
		clr.b	(Rings_manager_routine).w		; Reload ring manager
		clr.b	(Boss_flag).w		; Unlock the screen
		clr.b	(Respawn_table_keep).w		; Refresh sprite/ring memory
		jsr	Clear_Switches(pc)
		move.l	#Obj_HCZWaterSplash,(Dynamic_object_RAM+(object_size*2)).w	; Load the splash object
		move.b	#1,(Dynamic_object_RAM+(object_size*2)+subtype).w
		movem.l	d7-a0/a2-a3,-(sp)
		jsr	(Load_Level).l				; Load HCZ2 layout
		jsr	(LoadSolids).l
		jsr	(CheckLevelForWater).l
		move.w	#$6A0,d0
		move.w	d0,(Water_level).w
		move.w	d0,(Mean_water_level).w
		move.w	d0,(Target_water_level).w	; Set the water up
		moveq	#$D,d0
		jsr	(LoadPalette_Immediate).l	; Load HCZ2 palette
		movem.l	(sp)+,d7-a0/a2-a3
		move.w	#$3600,d0
		moveq	#0,d1
		sub.w	d0,(Player_1+x_pos).w
		sub.w	d0,(Player_2+x_pos).w
		jsr	Offset_ObjectsDuringTransition(pc)
		sub.w	d0,(Camera_X_pos).w
		sub.w	d0,(Camera_X_pos_copy).w
		sub.w	d0,(Camera_min_X_pos).w
		sub.w	d0,(Camera_max_X_pos).w		; Offset objects/camera position by specified amount
		jsr	Reset_TileOffsetPositionActual(pc)
		clr.w	(Events_routine_bg).w

loc_3C3E6:
		jsr	HCZ1_Deform(pc)
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)
		lea	HCZ1_BGDeformArray(pc),a4
		lea	(HScroll_table).w,a5
		jmp	ApplyDeformation(pc)

; =============== S U B R O U T I N E =======================================


HCZ1_Deform:
		move.w	(Camera_Y_pos_copy).w,d0		; Get the BG camera Y position
		subi.w	#$610,d0				; Get the difference between that and the water line equilibrium point
		move.w	d0,d1
		asr.w	#2,d0
		move.w	d0,d2
		addi.w	#$190,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w		; The effective BG Y is negative when the BG is above the water line, positive when otherwise
		sub.w	d1,d2					; The difference between the effective BG Y and the actual BG Y difference is what's used to calculate how the water line should be drawn
		move.w	d2,(Events_bg+$10).w
		move.w	(Camera_X_pos_copy).w,d0		; Get the camera BG X
		swap	d0
		clr.w	d0
		tst.w	d2
		beq.w	loc_3C4E2		; If equilibrium point, branch
		move.l	d0,d1
		move.l	d0,d3			; Set up deformation scroll value
		asr.l	#7,d3
		moveq	#$30-1,d4
		cmpi.w	#-$60,d2
		bgt.s	loc_3C45A
		lea	(HScroll_table+$01A).w,a1	; If background is high enough that water line doesn't have to be messed with, just apply the standard formation to it

loc_3C442:
		swap	d1
		move.w	d1,(a1)+
		swap	d1
		sub.l	d3,d1
		swap	d1
		move.w	d1,(a1)+
		swap	d1
		sub.l	d3,d1
		dbf	d4,loc_3C442
		bra.w	loc_3C4E2		; Then finish it up
; ---------------------------------------------------------------------------

loc_3C45A:
		lea	(HScroll_table+$19A).w,a1

loc_3C45E:
		swap	d1				; If background camera is lower, then apply water line deformation backwards
		move.w	d1,-(a1)
		swap	d1
		sub.l	d3,d1
		swap	d1
		move.w	d1,-(a1)
		swap	d1
		sub.l	d3,d1
		dbf	d4,loc_3C45E
		cmpi.w	#$60,d2
		bge.s	loc_3C4E2		; If background camera is low enough that water line doesn't need to be messed with, then end it.
		lea	(HScroll_table+$0DA).w,a1
		lea	(a1),a5
		lea	(HCZ_WaterlineScroll_Data).l,a6
		move.w	d2,d1
		bmi.s	loc_3C4B6
		move.w	d1,d3			; If waterline is displayed below water level
		neg.w	d3
		addi.w	#$60,d3
		lsl.w	#5,d3
		adda.w	d3,a6
		add.w	d3,d3
		adda.w	d3,a6			; Set up area of water line scroll data to use based on position
		subq.w	#1,d1
		moveq	#0,d3
		lsr.w	#1,d1
		bcc.s	loc_3C4A8

loc_3C4A0:
		move.b	(a6)+,d3
		add.w	d3,d3
		move.w	(a5,d3.w),(a1)+

loc_3C4A8:
		move.b	(a6)+,d3
		add.w	d3,d3
		move.w	(a5,d3.w),(a1)+	; Apply scroll data
		dbf	d1,loc_3C4A0
		bra.s	loc_3C4E2
; ---------------------------------------------------------------------------

loc_3C4B6:
		move.w	d1,d3			; If waterline is displayed above water level
		addi.w	#$60,d3
		lsl.w	#5,d3
		adda.w	d3,a6
		add.w	d3,d3
		adda.w	d3,a6			; Set up area of water line scroll data to use based on position
		neg.w	d1
		subq.w	#1,d1
		moveq	#0,d3
		lsr.w	#1,d1
		bcc.s	loc_3C4D6

loc_3C4CE:
		move.b	(a6)+,d3
		add.w	d3,d3
		move.w	(a5,d3.w),-(a1)

loc_3C4D6:
		move.b	(a6)+,d3
		add.w	d3,d3
		move.w	(a5,d3.w),-(a1)	; Apply scroll data
		dbf	d1,loc_3C4CE

loc_3C4E2:
		move.l	d0,d1			; Get BG X again
		asr.l	#2,d0
		asr.l	#5,d1
		lea	(HScroll_table).w,a1
		swap	d0
		move.w	d0,(a1)
		move.w	d0,$18(a1)
		move.w	d0,d3
		swap	d0
		sub.l	d1,d0
		swap	d0
		move.w	d0,2(a1)
		move.w	d0,$16(a1)
		swap	d0
		sub.l	d1,d0
		swap	d0
		move.w	d0,4(a1)
		move.w	d0,$14(a1)
		swap	d0
		sub.l	d1,d0
		swap	d0
		move.w	d0,6(a1)
		move.w	d0,$12(a1)
		swap	d0
		sub.l	d1,d0
		swap	d0
		move.w	d0,8(a1)
		move.w	d0,$10(a1)
		swap	d0
		sub.l	d1,d0
		swap	d0
		move.w	d0,$A(a1)
		move.w	d0,$E(a1)
		swap	d0
		sub.l	d1,d0
		swap	d0
		move.w	d0,$C(a1)
		move.w	d0,$19A(a1)
		move.w	d0,d4
		tst.w	d2
		bpl.s	loc_3C570
		lea	(HScroll_table+$0DA).w,a1	; Water line above water
		moveq	#$30-1,d0

loc_3C556:
		move.w	d4,(a1)+
		move.w	d4,(a1)+
		dbf	d0,loc_3C556
		moveq	#$60-1,d0
		add.w	d2,d0
		bmi.s	locret_3C58E
		lea	(HScroll_table+$01A).w,a1

loc_3C568:
		move.w	d3,(a1)+
		dbf	d0,loc_3C568
		bra.s	locret_3C58E
; ---------------------------------------------------------------------------

loc_3C570:
		lea	(HScroll_table+$01A).w,a1	; Water line below water
		moveq	#$30-1,d0

loc_3C576:
		move.w	d3,(a1)+
		move.w	d3,(a1)+
		dbf	d0,loc_3C576
		moveq	#$60-1,d0
		sub.w	d2,d0
		bmi.s	locret_3C58E
		lea	(HScroll_table+$19A).w,a1

loc_3C588:
		move.w	d4,-(a1)
		dbf	d0,loc_3C588

locret_3C58E:
		rts
; End of function HCZ1_Deform

; ---------------------------------------------------------------------------
HCZ1_BGDeformArray:
		dc.w    $40,     8,     8,     5,     5,     6,   $F0,     6,     5,     5,     8,     8,   $30, $80C0, $7FFF
; ---------------------------------------------------------------------------

HCZ2_ScreenInit:
		jsr	Reset_TileOffsetPositionActual(pc)
		jmp	Refresh_PlaneFull(pc)
; ---------------------------------------------------------------------------

HCZ2_ScreenEvent:
		move.w	(Screen_shake_offset).w,d0
		add.w	d0,(Camera_Y_pos_copy).w
		jmp	DrawTilesAsYouMove(pc)
; ---------------------------------------------------------------------------

HCZ2_BackgroundInit:
		cmpi.w	#$C00,(Camera_X_pos_copy).w
		bhs.s	loc_3C5E8
		cmpi.w	#$500,(Camera_Y_pos_copy).w
		blo.s	loc_3C5E8
		move.w	#4,(Events_routine_bg).w	; Special deformation occurs when camera X is less than $C00 and camera Y is greater than $500
		jsr	HCZ2_WallMove(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		jsr	Refresh_PlaneFull(pc)
		jmp	PlainDeformation(pc)
; ---------------------------------------------------------------------------

loc_3C5E8:
		move.w	#$10,(Events_routine_bg).w			; Normal deformation
		jsr	HCZ2_Deform(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		moveq	#0,d1
		jsr	Refresh_PlaneFull(pc)
		lea	HCZ2_BGDeformArray(pc),a4
		lea	(HScroll_table).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

HCZ2_BackgroundEvent:
		move.w	(Events_routine_bg).w,d0
		jmp	.Index(pc,d0.w)
; ---------------------------------------------------------------------------

.Index:
		bra.w	HCZ2BGE_WallMoveInit
; ---------------------------------------------------------------------------
		bra.w	HCZ2BGE_WallMove
; ---------------------------------------------------------------------------
		bra.w	HCZ2BGE_NormalTransition
; ---------------------------------------------------------------------------
		bra.w	HCZ2BGE_NormalRefresh
; ---------------------------------------------------------------------------
		bra.w	HCZ2BGE_Normal
; ---------------------------------------------------------------------------

HCZ2BGE_WallMoveInit:
		addq.w	#4,(Events_routine_bg).w

HCZ2BGE_WallMove:
		tst.w	(Events_fg_5).w
		bne.s	loc_3C66C
		jsr	HCZ2_WallMove(pc)
		jsr	DrawBGAsYouMove(pc)
		jsr	PlainDeformation(pc)
		jsr	ShakeScreen_Setup(pc)
		jsr	Get_BGActualEffectiveDiff(pc)
		clr.b	(Background_collision_flag).w
		move.w	(Player_1+x_pos).w,d0
		cmpi.w	#$3F0,d0
		blo.s	locret_3C66A
		cmpi.w	#$C10,d0
		bhs.s	locret_3C66A
		move.w	(Player_1+y_pos).w,d0
		cmpi.w	#$600,d0
		blo.s	locret_3C66A
		cmpi.w	#$840,d0
		bhs.s	locret_3C66A
		st	(Background_collision_flag).w			; Only enable BG tile collision if player is within above parameters

locret_3C66A:
		rts
; ---------------------------------------------------------------------------

loc_3C66C:
		clr.w	(Events_fg_5).w
		tst.w	(Screen_shake_flag).w
		bpl.s	loc_3C67A
		clr.w	(Screen_shake_flag).w		; Disable screen shaking if still constant

loc_3C67A:
		clr.b	(Background_collision_flag).w
		move.w	#$F0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_bg).w

HCZ2BGE_NormalTransition:
		move.w	#$400,d1
		moveq	#0,d2
		jsr	Draw_PlaneVertSingleBottomUp(pc)
		bpl.w	PlainDeformation
		jsr	HCZ2_Deform(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_bg).w
		bra.s	loc_3C6C0
; ---------------------------------------------------------------------------

HCZ2BGE_NormalRefresh:
		jsr	HCZ2_Deform(pc)

loc_3C6C0:
		moveq	#0,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		jsr	Draw_PlaneVertBottomUp(pc)
		bpl.s	loc_3C6D6
		addq.w	#4,(Events_routine_bg).w
		bra.s	loc_3C6D6
; ---------------------------------------------------------------------------

HCZ2BGE_Normal:
		jsr	HCZ2_Deform(pc)

loc_3C6D6:
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)
		lea	HCZ2_BGDeformArray(pc),a4
		lea	(HScroll_table).w,a5
		jmp	ApplyDeformation(pc)

; =============== S U B R O U T I N E =======================================


HCZ2_WallMove:
		cmpi.b	#6,(Player_1+routine).w
		bhs.s	loc_3C754			; If player is dead, don't bother
		move.l	#$E000,d0
		cmpi.w	#$A88,(Player_1+x_pos).w
		blo.s	loc_3C70E
		move.l	#$14000,d0			; Speed up if player has passed the end already

loc_3C70E:
		move.w	(Events_bg+$00).w,d1
		beq.s	loc_3C730
		cmpi.w	#-$600,d1
		bgt.s	loc_3C73C
		tst.w	(Screen_shake_flag).w		; When wall has travelled $600 pixels
		bpl.s	loc_3C754
		move.w	#$E,(Screen_shake_flag).w	; Set screen shake to timed
		moveq	#signextendB(sfx_Crash),d0
		jsr	(Play_SFX).l		; Play final crashing sound
		bra.s	loc_3C754
; ---------------------------------------------------------------------------

loc_3C730:
		cmpi.w	#$680,(Player_1+x_pos).w
		blo.s	loc_3C754			; If wall hasn't started moving and player hasn't moved far enough, end.
		st	(Screen_shake_flag).w			; Begin constant screen shake movement

loc_3C73C:
		sub.l	d0,(Events_bg+$00).w	; Subtract speed from BG X offset
		move.w	(Level_frame_counter).w,d0
		subq.w	#1,d0
		andi.w	#$F,d0
		bne.s	loc_3C754
		moveq	#signextendB(sfx_Rumble2),d0
		jsr	(Play_SFX).l		; Play the screen shake sound every 16th frame

loc_3C754:
		move.w	(Camera_Y_pos_copy).w,d0	; Get BG camera Y
		subi.w	#$500,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w	; Offset it by $500 and put it in effective BG Y
		move.w	(Camera_X_pos_copy).w,d0
		subi.w	#$200,d0
		add.w	(Events_bg+$00).w,d0
		move.w	d0,(Camera_X_pos_BG_copy).w	; Do the same with the BG Camera X, offsetting it by the wall movement amount
		rts
; End of function HCZ2_WallMove


; =============== S U B R O U T I N E =======================================


HCZ2_Deform:
		move.w	(Camera_Y_pos_copy).w,d0
		asr.w	#2,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Camera_X_pos_copy).w,d0
		swap	d0
		clr.w	d0
		asr.l	#1,d0
		move.l	d0,d1
		asr.l	#3,d1
		lea	(HScroll_table).w,a1
		lea	HCZ2_BGDeformIndex(pc),a5
		moveq	#0,d2

loc_3C794:
		move.b	(a5)+,d3
		bmi.s	loc_3C7AC
		ext.w	d3
		swap	d0

loc_3C79C:
		move.b	(a5)+,d2
		move.w	d0,(a1,d2.w)
		dbf	d3,loc_3C79C
		swap	d0
		sub.l	d1,d0
		bra.s	loc_3C794
; ---------------------------------------------------------------------------

loc_3C7AC:
		move.w	$12(a1),d0
		sub.w	$A(a1),d0
		move.w	d0,(Events_bg+$10).w
		move.w	6(a1),d0
		sub.w	$12(a1),d0
		move.w	d0,(Events_bg+$12).w
		move.w	4(a1),d0
		sub.w	$12(a1),d0
		move.w	d0,(Events_bg+$14).w
		rts
; End of function HCZ2_Deform

; ---------------------------------------------------------------------------
HCZ2_BGDeformArray:
		dc.w      8,     8,   $90,   $10,     8,   $30,   $18,     8,     8,   $A8,   $30,   $18
		dc.w      8,     8,   $A8,   $30,   $18,     8,     8,   $B0,   $10,     8, $7FFF
HCZ2_BGDeformIndex:
		dc.b  4-1,  $A, $14, $1E, $2C
		dc.b  3-1,  $C, $16, $20
		dc.b  6-1,   0,   8,  $E, $18, $22, $2A
		dc.b  4-1,   2, $10, $1A, $24
		dc.b  2-1, $12, $1C
		dc.b  2-1,   6, $28
		dc.b  2-1,   4, $26
		dc.b  $FF
		even
; ---------------------------------------------------------------------------

MGZ1_ScreenInit:
		clr.w	(Events_bg+$16).w
		jsr	Reset_TileOffsetPositionActual(pc)
		jmp	Refresh_PlaneFull(pc)
; ---------------------------------------------------------------------------

MGZ1_ScreenEvent:
		move.w	(Screen_shake_offset).w,d0
		add.w	d0,(Camera_Y_pos_copy).w
		jsr	Do_ShakeSound(pc)
		jmp	DrawTilesAsYouMove(pc)
; ---------------------------------------------------------------------------

MGZ1_BackgroundInit:
		jsr	MGZ1_Deform(pc)
		moveq	#0,d0
		moveq	#0,d1
		jsr	Refresh_PlaneFull(pc)
		lea	MGZ1_BGDeformArray(pc),a4
		lea	(HScroll_table).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

MGZ1_BackgroundEvent:
		move.w	(Events_routine_bg).w,d0
		jmp	.Index(pc,d0.w)
; ---------------------------------------------------------------------------

.Index:
		bra.w	MGZ1BGE_Normal
; ---------------------------------------------------------------------------
		bra.w	MGZ1BGE_Transition
; ---------------------------------------------------------------------------

MGZ1BGE_Normal:
		tst.w	(Events_fg_5).w
		beq.s	loc_3C8B4
		clr.w	(Events_fg_5).w			; Transition time
		movem.l	d7-a0/a2-a3,-(sp)
		lea	(MGZ2_128x128_Secondary_Kos).l,a1
		lea	(RAM_start+$6B00).l,a2
		jsr	(Queue_Kos).l
		lea	(MGZ2_16x16_Secondary_Kos).l,a1
		lea	(Block_table+$C60).w,a2
		jsr	(Queue_Kos).l
		lea	(MGZ2_8x8_Secondary_KosM).l,a1
		move.w	#tiles_to_bytes($252),d2
		jsr	(Queue_Kos_Module).l		; Queue art, blocks and chunks for act 2
		moveq	#$14,d0
		jsr	(Load_PLC).l					; Load act 2 PLCs
		movem.l	(sp)+,d7-a0/a2-a3
		addq.w	#4,(Events_routine_bg).w

loc_3C8B4:
		jsr	MGZ1_Deform(pc)					; Pretty self-explanatory to be honest
		lea	MGZ1_BGDeformArray(pc),a4
		lea	(HScroll_table).w,a5
		jsr	ApplyDeformation(pc)
		jmp	ShakeScreen_Setup(pc)
; ---------------------------------------------------------------------------

MGZ1BGE_Transition:
		tst.b	(Kos_modules_left).w
		bne.w	loc_3C960				; Wait for Kos queue to finish
		move.w	#$201,(Current_zone_and_act).w		; Change act
		clr.b	(Dynamic_resize_routine).w
		clr.b	(Object_load_routine).w
		clr.b	(Rings_manager_routine).w
		clr.b	(Boss_flag).w
		clr.b	(Respawn_table_keep).w			; Reset various managers
		jsr	Clear_Switches(pc)
		movem.l	d7-a0/a2-a3,-(sp)
		jsr	(Load_Level).l
		jsr	(LoadSolids).l
		moveq	#$F,d0
		jsr	(LoadPalette_Immediate).l
		movem.l	(sp)+,d7-a0/a2-a3
		move.w	#$2E00,d0
		move.w	#$600,d1
		sub.w	d0,(Player_1+x_pos).w
		sub.w	d1,(Player_1+y_pos).w
		sub.w	d0,(Player_2+x_pos).w
		sub.w	d1,(Player_2+y_pos).w
		jsr	Offset_ObjectsDuringTransition(pc)
		sub.w	d0,(Camera_X_pos).w
		sub.w	d1,(Camera_Y_pos).w
		sub.w	d0,(Camera_X_pos_copy).w
		sub.w	d1,(Camera_Y_pos_copy).w
		sub.w	d0,(Camera_min_X_pos).w
		sub.w	d0,(Camera_max_X_pos).w
		sub.w	d1,(Camera_min_Y_pos).w
		sub.w	d1,(Camera_max_Y_pos).w
		move.w	(Camera_max_Y_pos).w,(Camera_target_max_Y_pos).w
		jsr	Reset_TileOffsetPositionActual(pc)
		clr.l	(Events_bg+$10).w
		clr.w	(Events_bg+$14).w
		clr.w	(_unkEEA2).w
		clr.w	(Events_routine_bg).w		; Clear flags/values used for BG stuff in act 2

loc_3C960:
		jsr	MGZ1_Deform(pc)
		lea	MGZ1_BGDeformArray(pc),a4
		lea	(HScroll_table).w,a5
		jmp	ApplyDeformation(pc)

; =============== S U B R O U T I N E =======================================


MGZ1_Deform:
		move.w	(Screen_shake_offset).w,(Camera_Y_pos_BG_copy).w
		move.w	(Camera_X_pos_copy).w,d0
		swap	d0
		clr.w	d0
		asr.l	#2,d0
		move.l	d0,d1
		asr.l	#4,d1
		lea	(HScroll_table+$01C).w,a1
		moveq	#9-1,d2

loc_3C98A:
		swap	d0
		move.w	d0,-(a1)
		swap	d0
		sub.l	d1,d0
		dbf	d2,loc_3C98A
		lea	(HScroll_table).w,a1
		move.l	(HScroll_table+$01C).w,d2
		addi.l	#$500,(HScroll_table+$01C).w
		asr.l	#1,d0
		moveq	#5-1,d3

loc_3C9AA:
		add.l	d2,d0
		addi.l	#$500,d2
		swap	d0
		move.w	d0,(a1)+
		swap	d0
		add.l	d1,d0
		dbf	d3,loc_3C9AA
		move.w	-2(a1),d0
		move.w	-4(a1),-2(a1)
		move.w	d0,-4(a1)
		rts
; End of function MGZ1_Deform


; =============== S U B R O U T I N E =======================================


Do_ShakeSound:
		cmpi.b	#6,(Player_1+routine).w
		bhs.s	.return			; If dying, skip this
		tst.w	(Events_bg+$16).w
		bne.s	.return			; If flag is set, skip this
		tst.w	(Screen_shake_flag).w
		bpl.s	.return			; If screen is not shaking continuously, skip this
		move.w	(Level_frame_counter).w,d0
		subq.w	#1,d0
		andi.w	#$F,d0
		bne.s	.return
		moveq	#signextendB(sfx_Rumble2),d0
		jsr	(Play_SFX).l

.return:
		rts
; End of function Do_ShakeSound

; ---------------------------------------------------------------------------
MGZ1_BGDeformArray:
		dc.w    $10,     4,     4,     8,     8,     8,    $D,   $13,     8,     8,     8,     8,   $18, $7FFF
; ---------------------------------------------------------------------------

MGZ2_ScreenInit:
		clr.l	(Events_bg+$10).w
		clr.l	(Events_bg+$14).w
		jsr	Reset_TileOffsetPositionActual(pc)
		jmp	Refresh_PlaneFull(pc)
; ---------------------------------------------------------------------------

MGZ2_ScreenEvent:
		move.w	(Screen_shake_offset).w,d0
		add.w	d0,(Camera_Y_pos_copy).w
		jsr	Do_ShakeSound(pc)
		move.w	(Events_routine_fg).w,d0
		jmp	.Index(pc,d0.w)
; ---------------------------------------------------------------------------

.Index:
		bra.w	MGZ2SE_Normal
; ---------------------------------------------------------------------------
		bra.w	MGZ2SE_Collapse
; ---------------------------------------------------------------------------
		bra.w	MGZ2SE_MoveBG
; ---------------------------------------------------------------------------

MGZ2SE_Normal:
		tst.w	(Events_fg_4).w
		bne.s	loc_3CA56
		jsr	MGZ2_QuakeEvent(pc)
		jsr	MGZ2_ChunkEvent(pc)
		jmp	DrawTilesAsYouMove(pc)
; ---------------------------------------------------------------------------

loc_3CA56:
		clr.w	(Events_fg_4).w		; Clear background event
		st	(Events_bg+$16).w
		move.w	#$14,(Screen_shake_flag).w
		addq.w	#4,(Events_routine_fg).w

MGZ2SE_Collapse:
		jsr	MGZ2_LevelCollapse(pc)
		tst.w	(Screen_shake_flag).w
		bmi.s	loc_3CA76
		jmp	DrawTilesAsYouMove(pc)
; ---------------------------------------------------------------------------

loc_3CA76:
		lea	MGZ2_FGVScrollArray(pc),a4
		lea	(HScroll_table+$100).w,a5
		moveq	#$F,d6
		moveq	#$A,d5
		jmp	DrawTilesVDeform(pc)
; ---------------------------------------------------------------------------

MGZ2SE_MoveBG:
		move.l	(Events_bg+$08).w,d0
		cmpi.l	#loc_50000,d0
		bhs.s	loc_3CA9C
		addi.l	#$800,d0
		move.l	d0,(Events_bg+$08).w

loc_3CA9C:
		swap	d0
		add.w	d0,(Events_bg+$0C).w	; Apply a movement offset for the BG scrolling during the boss
		jmp	DrawTilesAsYouMove(pc)

; =============== S U B R O U T I N E =======================================


MGZ2_LevelCollapse:
		cmpi.b	#6,(Player_1+routine).w
		bhs.w	locret_3CC00		; If dying, don't do anything else
		tst.w	(Screen_shake_flag).w
		bmi.w	loc_3CB66			; If shaking continuously, branch
		bne.w	locret_3CC00
		movea.w	$38(a3),a1			; Get chunk line at $700 Y
		lea	$79(a1),a1			; Get chunk at $3C80
		move.w	-8(a3),d0			; Get FG level X chunksize
		subq.w	#3,d0
		moveq	#3-1,d1

loc_3CACC:
		clr.b	(a1)+
		clr.b	(a1)+
		clr.b	(a1)+				; Clear the three main chunks on three lines that comprise the boss battle
		adda.w	d0,a1
		dbf	d1,loc_3CACC
		lea	(HScroll_table+$102).w,a1
		lea	(HScroll_table+$13C).w,a5
		lea	$28(a5),a6
		move.w	(Camera_Y_pos_copy).w,d0	; Get BG Y camera
		and.w	(Camera_Y_pos_mask).w,d0	; AND it to get tile position
		moveq	#$A-1,d1

loc_3CAEE:
		move.w	d0,(a1)
		addq.w	#4,a1
		clr.l	(a5)+
		clr.l	(a6)+				; Clear scroll values, etc
		dbf	d1,loc_3CAEE
		jsr	(AllocateObject).l
		bne.s	loc_3CB54
		move.w	#$3C90,d1
		move.l	#$5C00790,d2
		move.l	#HScroll_table+$13C,d3
		moveq	#$A-1,d4

loc_3CB14:
		move.l	#Obj_MGZ2LevelCollapseSolid,(a1)		; Create solid objects that Sonic can stand on as the level collapses
		move.w	d1,x_pos(a1)
		move.w	d2,$2E(a1)
		move.l	d3,$30(a1)
		swap	d2
		jsr	(CreateNewSprite4).l
		bne.s	loc_3CB54
		move.l	#Obj_MGZ2LevelCollapseSolid,(a1)
		move.w	d1,x_pos(a1)
		move.w	d2,$2E(a1)
		move.l	d3,$30(a1)
		addi.w	#$20,d1
		swap	d2
		addq.l	#4,d3
		jsr	(CreateNewSprite4).l
		dbne	d4,loc_3CB14

loc_3CB54:
		st	(Screen_shake_flag).w		; Turn quake on
		clr.w	(Events_bg+$06).w
		st	(_unkEEA2).w			; Turn on special VScroll VInt function
		move.w	#4,(Special_V_int_routine).w

loc_3CB66:
		lea	(HScroll_table+$100).w,a1
		lea	$28(a1),a4
		lea	$14(a4),a5
		lea	MGZ2_CollapseScrollDelay(pc),a6
		move.w	(Events_bg+$06).w,d0
		addq.w	#1,(Events_bg+$06).w
		moveq	#$A,d1
		moveq	#$A-1,d2

loc_3CB82:
		cmp.w	(a6)+,d0		; Get scroll delay for each block
		blo.s	loc_3CB8E
		addi.l	#$500,$64(a1)		; Add $500 to Vscroll velocity for this block when not delayed

loc_3CB8E:
		move.l	$64(a1),d3
		add.l	d3,(a5)+		; Add velocity to actual VScroll
		move.w	-4(a5),d3
		cmpi.w	#$2E0,d3
		blo.s	loc_3CBA4
		move.w	#$2E0,d3		; $2E0 is the maximum scroll
		subq.w	#1,d1			; When maximum scroll is reached, lower amount of "active" scrolling lines

loc_3CBA4:
		move.w	(Camera_Y_pos_copy).w,d4	; Get BG Y
		sub.w	d3,d4
		move.w	d4,(a4)+
		move.w	d4,(a1)				; Subtract from scroll to get... something
		addq.w	#4,a1
		dbf	d2,loc_3CB82			; Repeat until all scrolling parts are off-screen
		move.w	(Level_frame_counter).w,d0
		subq.w	#1,d0
		andi.w	#$F,d0
		bne.s	loc_3CBC8
		moveq	#signextendB(sfx_BigRumble),d0	; Play collapsing sound every 16 frames
		jsr	(Play_SFX).l

loc_3CBC8:
		tst.w	d1
		bne.s	locret_3CC00			; If scrolling chunks still remain, do nothing
		movea.w	$2C(a3),a1			; Get chunk line at $580 Y
		lea	$79(a1),a1			; Get chunk at $3C80 X
		move.w	-8(a3),d0
		subq.w	#3,d0
		moveq	#2,d1

loc_3CBDC:
		clr.b	(a1)+
		clr.b	(a1)+
		clr.b	(a1)+
		adda.w	d0,a1
		dbf	d1,loc_3CBDC
		clr.w	(Screen_shake_flag).w		; Stop quaking
		clr.l	(Events_bg+$08).w		; Stop special tile drawing
		move.w	(Camera_X_pos_copy).w,(Events_bg+$0C).w
		move.w	#$C,(Special_V_int_routine).w	; Set VScroll VInt routine
		addq.w	#4,(Events_routine_fg).w	; Next screen routine

locret_3CC00:
		rts
; End of function MGZ2_LevelCollapse


; =============== S U B R O U T I N E =======================================


MGZ2_QuakeEvent:
		move.w	(Player_1+x_pos).w,d0
		move.w	(Player_1+y_pos).w,d1
		move.w	(Events_bg+$10).w,d2
		jmp	.Index(pc,d2.w)
; End of function MGZ2_QuakeEvent

; ---------------------------------------------------------------------------

.Index:
		bra.w	MGZ2_QuakeEventCheck
; ---------------------------------------------------------------------------
		bra.w	MGZ2_QuakeEvent1
; ---------------------------------------------------------------------------
		bra.w	MGZ2_QuakeEvent2
; ---------------------------------------------------------------------------
		bra.w	MGZ2_QuakeEvent3
; ---------------------------------------------------------------------------
		bra.w	MGZ2_QuakeEvent1Cont
; ---------------------------------------------------------------------------
		bra.w	MGZ2_QuakeEvent2Cont
; ---------------------------------------------------------------------------
		bra.w	MGZ2_QuakeEvent3Cont
; ---------------------------------------------------------------------------

MGZ2_QuakeEventCheck:
		lea	(Events_bg+$12).w,a5		; EEE4-EEE6 are flags to determine whether earthquake event has already completed. There are three
		lea	MGZ2_QuakeEventArray(pc),a1
		moveq	#4,d2
		moveq	#2,d3

loc_3CC3A:
		tst.b	(a5)
		bne.s	loc_3CC82
		cmp.w	(a1),d0
		blo.s	loc_3CC82
		cmp.w	2(a1),d0
		bhs.s	loc_3CC82
		cmp.w	4(a1),d1
		blo.s	loc_3CC82
		cmp.w	6(a1),d1
		bhs.s	loc_3CC82
		move.w	d2,(Events_bg+$10).w
		move.w	8(a1),d0
		move.w	d0,(Camera_max_Y_pos).w
		move.w	d0,(Camera_target_max_Y_pos).w
		move.w	$A(a1),d0
		cmpi.w	#4,d2
		bne.s	loc_3CC78
		move.w	d0,(Camera_max_X_pos).w	; First earthquake event near start of level makes you go right
		move.w	d0,(Camera_target_max_X_pos).w
		rts
; ---------------------------------------------------------------------------

loc_3CC78:
		move.w	d0,(Camera_min_X_pos).w	; The other two make you go left
		move.w	d0,(Camera_target_min_X_pos).w
		rts
; ---------------------------------------------------------------------------

loc_3CC82:
		lea	$C(a1),a1
		addq.w	#1,a5
		addq.w	#4,d2
		dbf	d3,loc_3CC3A
		rts
; ---------------------------------------------------------------------------

MGZ2_QuakeEvent1:
		cmpi.w	#$780,d0
		blo.w	loc_3CD66		; If player retreats, revert to normal camera movement
		move.w	(Camera_max_X_pos).w,d0
		cmp.w	(Camera_X_pos).w,d0
		bhi.s	locret_3CCD2		; If camera X hasn't reached level X end, branch
		move.w	d0,(Camera_min_X_pos).w	; Lock the screen
		move.w	d0,(Camera_target_min_X_pos).w
		st	(Events_bg+$12).w			; Set the earthquake flag for this first one
		addi.w	#$C,(Events_bg+$10).w	; Set next quake event routine
		st	(Screen_shake_flag).w
		jsr	(AllocateObject).l
		bne.s	locret_3CCD2
		move.l	#Obj_MGZ2DrillingRobotnik,(a1)
		move.w	#$8E0,x_pos(a1)
		move.w	#$690,y_pos(a1)		; Create drilling Eggman boss sprite

locret_3CCD2:
		rts
; ---------------------------------------------------------------------------

MGZ2_QuakeEvent2:
		cmpi.w	#$3200,d0
		bhs.w	loc_3CD66
		move.w	(Camera_min_X_pos).w,d0	; If camera X hasn't reached level X start, branch
		cmp.w	(Camera_X_pos).w,d0
		blo.s	locret_3CD1C
		move.w	d0,(Camera_max_X_pos).w	; Lock the screen
		move.w	d0,(Camera_target_max_X_pos).w
		st	(Events_bg+$13).w			; Set this earthquake flag
		addi.w	#$C,(Events_bg+$10).w	; Set next quake event routine
		st	(Screen_shake_flag).w
		jsr	(AllocateObject).l
		bne.s	locret_3CD1C
		move.l	#Obj_MGZ2DrillingRobotnik,(a1)
		bset	#0,render_flags(a1)
		move.w	#$2FA0,x_pos(a1)
		move.w	#$2D0,y_pos(a1)		; Set Robotnik drilling object

locret_3CD1C:
		rts
; ---------------------------------------------------------------------------

MGZ2_QuakeEvent3:
		cmpi.w	#$3480,d0			; Same as above, you know the drill (haha, drill...)
		bhs.s	loc_3CD66
		move.w	(Camera_min_X_pos).w,d0
		cmp.w	(Camera_X_pos).w,d0
		blo.s	locret_3CD64
		move.w	d0,(Camera_max_X_pos).w
		move.w	d0,(Camera_target_max_X_pos).w
		st	(Events_bg+$14).w
		addi.w	#$C,(Events_bg+$10).w
		st	(Screen_shake_flag).w
		jsr	(AllocateObject).l
		bne.s	locret_3CD64
		move.l	#Obj_MGZ2DrillingRobotnik,(a1)
		bset	#0,render_flags(a1)
		move.w	#$3300,x_pos(a1)
		move.w	#$790,y_pos(a1)

locret_3CD64:
		rts
; ---------------------------------------------------------------------------

loc_3CD66:
		move.w	#$1000,d0
		move.w	d0,(Camera_max_Y_pos).w
		move.w	d0,(Camera_target_max_Y_pos).w
		move.l	#$6000,d0
		move.l	d0,(Camera_min_X_pos).w
		move.l	d0,(Camera_target_min_X_pos).w
		clr.w	(Events_bg+$10).w
		rts
; ---------------------------------------------------------------------------

MGZ2_QuakeEvent1Cont:
		cmpi.w	#$980,(Player_1+x_pos).w
		bhs.s	loc_3CDBA			; Reset level Y end when Sonic has travelled past $980 X
		rts
; ---------------------------------------------------------------------------

MGZ2_QuakeEvent2Cont:
		cmpi.w	#$100,(Player_1+y_pos).w
		bhs.s	locret_3CDAE
		cmpi.w	#$2F80,(Player_1+x_pos).w
		blo.s	locret_3CDAE
		move.w	#$6000,d0
		move.w	d0,(Camera_max_X_pos).w
		move.w	d0,(Camera_target_max_X_pos).w
		bra.s	loc_3CDBA
; ---------------------------------------------------------------------------

locret_3CDAE:
		rts
; ---------------------------------------------------------------------------

MGZ2_QuakeEvent3Cont:
		cmpi.w	#$3200,(Player_1+x_pos).w
		blo.s	loc_3CDBA
		rts
; ---------------------------------------------------------------------------

loc_3CDBA:
		move.w	#$1000,d0
		move.w	d0,(Camera_max_Y_pos).w
		move.w	d0,(Camera_target_max_Y_pos).w
		clr.w	(Events_bg+$10).w
		rts

; =============== S U B R O U T I N E =======================================


MGZ2_ChunkEvent:
		move.w	(Events_bg+$04).w,d0
		jmp	.Index(pc,d0.w)
; End of function MGZ2_ChunkEvent

; ---------------------------------------------------------------------------

.Index:
		bra.w	MGZ2_ChunkEventCheck
; ---------------------------------------------------------------------------
		bra.w	MGZ2_ChunkEvent1
; ---------------------------------------------------------------------------
		bra.w	MGZ2_ChunkEvent2_3
; ---------------------------------------------------------------------------
		bra.w	MGZ2_ChunkEvent2_3
; ---------------------------------------------------------------------------
		bra.w	MGZ2_ChunkEventReset
; ---------------------------------------------------------------------------
		rts
; ---------------------------------------------------------------------------

MGZ2_ChunkEventCheck:
		move.w	(Player_1+x_pos).w,d0
		move.w	(Player_1+y_pos).w,d1
		lea	MGZ2_ChunkEventArray(pc),a1
		moveq	#4,d2
		moveq	#3-1,d3

loc_3CDFA:
		cmp.w	(a1),d0
		blo.s	loc_3CE1C
		cmp.w	2(a1),d0
		bhs.s	loc_3CE1C
		cmp.w	4(a1),d1
		blo.s	loc_3CE1C
		cmp.w	6(a1),d1
		bhs.s	loc_3CE1C
		cmpi.w	#4,d2
		bne.s	loc_3CE28
		tst.w	(Screen_shake_flag).w
		bmi.s	loc_3CE28		; Only perform the first layout shift event if screen is continually shaking

loc_3CE1C:
		lea	$C(a1),a1
		addq.w	#4,d2
		dbf	d3,loc_3CDFA
		rts
; ---------------------------------------------------------------------------

loc_3CE28:
		move.w	d2,(Events_bg+$04).w
		clr.w	(Events_bg+$06).w
		clr.w	(Events_bg+$08).w
		move.w	8(a1),(Events_bg+$0A).w
		move.w	$A(a1),(Events_bg+$0C).w

MGZ2_ChunkEvent1:
		move.w	(Events_bg+$06).w,d0
		cmpi.w	#$5C,d0
		blo.s	loc_3CE7C
		clr.w	(Screen_shake_flag).w		; Stop shaking when first chunk event is finished
		clr.w	(Camera_min_X_pos).w		; Reset level height
		clr.w	(Camera_target_min_X_pos).w
		move.w	#$10,(Events_bg+$04).w
		rts
; ---------------------------------------------------------------------------

MGZ2_ChunkEvent2_3:
		move.w	(Events_bg+$06).w,d0
		cmpi.w	#$5C,d0
		blo.s	loc_3CE7C
		move.w	#$6000,d0
		move.w	d0,(Camera_max_X_pos).w	; Reset level end X
		move.w	d0,(Camera_target_max_X_pos).w
		move.w	#$14,(Events_bg+$04).w
		rts
; ---------------------------------------------------------------------------

loc_3CE7C:
		subq.w	#1,(Events_bg+$08).w
		bpl.s	locret_3CEDA
		move.w	#7-1,(Events_bg+$08).w	; Perform the layout change once every seven frames
		move.w	d0,d2
		bsr.s	MGZ2_ModifyChunk
		move.w	(Events_bg+$0A).w,d0
		addi.w	#$80,d0
		sub.w	(Camera_X_pos_copy).w,d0
		bcs.s	locret_3CEDA
		cmpi.w	#$1C0,d0			; Calculate the X position of the screen redraw
		bhs.s	locret_3CEDA
		move.w	(Events_bg+$0C).w,d0
		lea	MGZ2_ScreenRedrawArray(pc),a1
		add.w	(a1,d2.w),d0		; Calculate the Y position
		move.w	2(a1,d2.w),d2		; And the number of lines to write

loc_3CEB0:
		move.w	(Camera_Y_pos_copy).w,d3
		and.w	(Camera_Y_pos_mask).w,d3
		cmp.w	d3,d0
		blo.s	loc_3CED2
		addi.w	#$F0,d3
		cmp.w	d3,d0
		bhs.s	loc_3CED2
		move.w	(Events_bg+$0A).w,d1
		moveq	#8,d6				; Always draw 8 tiles
		swap	d2
		jsr	Setup_TileRowDraw(pc)
		swap	d2

loc_3CED2:
		addi.w	#$10,d0
		dbf	d2,loc_3CEB0

locret_3CEDA:
		rts
; ---------------------------------------------------------------------------

MGZ2_ChunkEventReset:
		cmpi.w	#$2A00,(Player_1+x_pos).w	; When Player has travelled far enough, reset the chunk to its original form
		blo.s	locret_3CEEC
		clr.w	(Events_bg+$04).w
		moveq	#$5C,d0
		bra.s	MGZ2_ModifyChunk
; ---------------------------------------------------------------------------

locret_3CEEC:
		rts

; =============== S U B R O U T I N E =======================================


MGZ2_ModifyChunk:
		lea	MGZ2_ChunkReplaceArray(pc),a1
		lea	($FF5880).l,a5
		bsr.s	sub_3CF00
		lea	($FF7500).l,a5
; End of function MGZ2_ModifyChunk


; =============== S U B R O U T I N E =======================================


sub_3CF00:
		lea	(MGZ2_QuakeChunks).l,a4
		adda.w	(a1,d0.w),a4
		moveq	#8-1,d1

loc_3CF0C:
		move.l	(a4)+,(a5)+
		move.l	(a4)+,(a5)+
		move.l	(a4)+,(a5)+
		move.l	(a4)+,(a5)+
		dbf	d1,loc_3CF0C
		addq.w	#2,d0
		move.w	d0,(Events_bg+$06).w
		rts
; End of function sub_3CF00

; ---------------------------------------------------------------------------

Obj_MGZ2LevelCollapseSolid:
		cmpi.w	#8,(Events_routine_fg).w
		bne.s	loc_3CF2E
		jmp	(Delete_Current_Sprite).l		; Delete control object when next screen event is in effect
; ---------------------------------------------------------------------------

loc_3CF2E:
		movea.l	$30(a0),a1		; Get vertical scroll position for this block
		move.w	$2E(a0),d0		; Get vertical position
		add.w	(a1),d0			; Add it to scroll value to get final Y position
		move.w	d0,y_pos(a0)
		move.b	#$10,width_pixels(a0)	; Set up width
		bset	#7,status(a0)		; Make it invisible
		moveq	#$1B,d1
		moveq	#$40,d2
		moveq	#$40,d3			; Height, etc
		move.w	x_pos(a0),d4		; Position
		jmp	(SolidObjectFull2).l
; ---------------------------------------------------------------------------
MGZ2_QuakeEventArray:
		dc.w   $780,  $7C0,  $580,  $600,  $5A0,  $7E0  ; Player X boundaries, Player Y boundaries, Level size reset val
		dc.w  $31C0, $3200,  $1C0,  $280,  $1E0, $2F60
		dc.w  $3440, $3480,  $680,  $700,  $6A0, $32C0
MGZ2_ChunkEventArray:
		dc.w   $F68,  $F78,  $500,  $580,  $F00,  $500  ; Player X boundaries, Player Y boundaries, Screen redraw area
		dc.w  $3680, $3700,  $2F0,  $380, $3700,  $280
		dc.w  $3000, $3080,  $770,  $800, $3080,  $700
MGZ2_ScreenRedrawArray:
		dc.w   $40,  4-1
		dc.w   $50,  4-1
		dc.w   $50,  5-1
		dc.w   $60,  5-1
		dc.w   $60,  4-1
		dc.w   $70,  3-1
		dc.w   $70,  4-1
		dc.w   $80,  4-1
		dc.w   $80,  4-1
		dc.w   $80,  5-1
		dc.w   $80,  5-1
		dc.w   $80,  5-1
		dc.w   $80,  6-1
		dc.w   $90,  6-1
		dc.w   $A0,  5-1
		dc.w   $90,  7-1
		dc.w   $80,  7-1
		dc.w   $90,  7-1
		dc.w   $A0,  6-1
		dc.w   $B0,  5-1
		dc.w   $C0,  4-1
		dc.w   $D0,  3-1
		dc.w   $E0,  2-1
MGZ2_ChunkReplaceArray:
		dc.w  $100, $500
		dc.w  $180, $580
		dc.w  $200, $600
		dc.w  $280, $680
		dc.w  $300, $700
		dc.w  $380, $780
		dc.w     0, $800
		dc.w     0, $880
		dc.w     0, $900
		dc.w     0, $980
		dc.w     0, $A00
		dc.w     0, $A80
		dc.w     0, $B00
		dc.w     0, $B80
		dc.w     0, $C00
		dc.w     0, $C80
		dc.w     0, $D00
		dc.w     0, $D80
		dc.w     0, $E00
		dc.w     0, $E80
		dc.w     0, $F00
		dc.w     0, $F80
		dc.w     0,$1000
		dc.w   $80, $480
MGZ2_CollapseScrollDelay:
		dc.w     $A,   $10,     2,     8,    $E,     6,     0,    $C,   $12,     4
MGZ2_FGVScrollArray:
		dc.w  $3CA0,   $20,   $20,   $20,   $20,   $20,   $20,   $20,   $20, $7FFF
; ---------------------------------------------------------------------------

MGZ2_BackgroundInit:
		jsr	MGZ2_ClearBottomBG(pc)
		move.w	#4,(Events_routine_bg).w	; Use second background event
		clr.w	(_unkEEA2).w		; Clear VScroll routine flag
		move.w	(Player_1+x_pos).w,d0
		move.w	(Player_1+y_pos).w,d1
		cmpi.w	#$500,d1
		bhs.s	loc_3D0C0
		cmpi.w	#$3800,d0
		blo.s	loc_3D10C
		move.w	#4,(Events_bg+$00).w	; If player is <$500 Y and >$3800 X (Knuckles area presumably)
		move.l	#Obj_MGZ2BGMoveKnux,d1
		cmpi.w	#$3A80,d0
		blo.s	loc_3D102
		move.w	#$220,(Events_bg+$02).w
		bra.s	loc_3D10C
; ---------------------------------------------------------------------------

loc_3D0C0:
		cmpi.w	#$800,d1
		blo.s	loc_3D0E6
		cmpi.w	#$34C0,d0
		blo.s	loc_3D10C
		move.w	#8,(Events_bg+$00).w	; If player is >$800 Y and >$34C0 X
		move.l	#Obj_MGZ2BGMoveSonic,d1
		cmpi.w	#$3800,d0
		blo.s	loc_3D102
		move.w	#$1D0,(Events_bg+$02).w
		bra.s	loc_3D10C
; ---------------------------------------------------------------------------

loc_3D0E6:
		cmpi.w	#$3900,d0
		blo.s	loc_3D10C
		move.w	#$C,(Events_bg+$00).w	; If player is >$3900X and inbetween $500 and $800 Y
		move.w	#$1D0,(Events_bg+$02).w
		st	(Events_bg+$0E).w			; Turn off cloud movement
		clr.l	(HScroll_table+$038).w
		bra.s	loc_3D10C
; ---------------------------------------------------------------------------

loc_3D102:
		jsr	(AllocateObject).l
		bne.s	loc_3D10C
		move.l	d1,(a1)

loc_3D10C:
		jsr	MGZ2_BGDeform(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		clr.l	(HScroll_table).w
		move.w	d2,(HScroll_table+$006).w
		lea	MGZ2_BGDrawArray(pc),a4
		lea	(HScroll_table).w,a5
		jsr	Refresh_PlaneTileDeform(pc)
		lea	MGZ2_BGDeformArray(pc),a4
		lea	(HScroll_table+$008).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

MGZ2_BackgroundEvent:
		move.w	(Events_routine_bg).w,d0
		jmp	.Index(pc,d0.w)
; ---------------------------------------------------------------------------

.Index:
		bra.w	MGZ2BGE_GoRefresh
; ---------------------------------------------------------------------------
		bra.w	MGZ2BGE_Normal
; ---------------------------------------------------------------------------
		bra.w	MGZ2BGE_Refresh
; ---------------------------------------------------------------------------

MGZ2BGE_GoRefresh:
		jsr	MGZ2_ClearBottomBG(pc)
		clr.l	(HScroll_table).w
		addq.w	#4,(Events_routine_bg).w
		bra.s	loc_3D190
; ---------------------------------------------------------------------------

MGZ2BGE_Normal:
		jsr	MGZ2_BGEventTrigger(pc)
		bne.s	loc_3D190		; If BG event has triggered, go refresh the BG
		jsr	MGZ2_BGDeform(pc)

loc_3D160:
		lea	MGZ2_BGDrawArray(pc),a4
		lea	(HScroll_table).w,a5
		moveq	#$20,d6
		moveq	#2,d5
		jsr	Draw_BG(pc)
		lea	MGZ2_BGDeformArray(pc),a4
		lea	(HScroll_table+$008).w,a5
		jsr	ApplyDeformation(pc)
		lea	MGZ2_FGVScrollArray(pc),a4
		lea	(HScroll_table+$126).w,a5
		jsr	Apply_FGVScroll(pc)
		jsr	Get_BGActualEffectiveDiff(pc)
		jmp	ShakeScreen_Setup(pc)
; ---------------------------------------------------------------------------

loc_3D190:
		jsr	MGZ2_BGDeform(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		move.w	d2,(HScroll_table+$006).w
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_bg).w
		bra.s	loc_3D1B8
; ---------------------------------------------------------------------------

MGZ2BGE_Refresh:
		jsr	MGZ2_BGDeform(pc)

loc_3D1B8:
		lea	MGZ2_BGDrawArray(pc),a4
		lea	(HScroll_table-$04).w,a5
		move.w	(Camera_Y_pos_BG_copy).w,d1
		jsr	Draw_PlaneVertBottomUpComplex(pc)
		bpl.s	loc_3D160
		subq.w	#4,(Events_routine_bg).w
		bra.s	loc_3D160

; =============== S U B R O U T I N E =======================================


MGZ2_BGDeform:
		move.w	(Events_bg+$00).w,d0
		jmp	.Index(pc,d0.w)
; End of function MGZ2_BGDeform

; ---------------------------------------------------------------------------

.Index:
		bra.w	loc_3D21E	; 0 - Normal
; ---------------------------------------------------------------------------
		bra.w	loc_3D1F4	; 4 - Knuckles BG move event
; ---------------------------------------------------------------------------
		bra.w	loc_3D1EA	; 8 - Sonic BG move event
; ---------------------------------------------------------------------------
		move.w	#$500,d1	; C - After BG move event
		bra.s	loc_3D220
; ---------------------------------------------------------------------------

loc_3D1EA:
		move.w	#$8F0,d1
		move.w	#$3200,d2
		bra.s	loc_3D1FC
; ---------------------------------------------------------------------------

loc_3D1F4:
		move.w	#$1E0,d1
		move.w	#$3580,d2

loc_3D1FC:
		move.w	(Camera_Y_pos_copy).w,d0
		sub.w	d1,d0
		add.w	(Events_bg+$02).w,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w		; Effective BG Y is offset, but otherwise matched in ratio during the special BG events
		move.w	(Camera_X_pos_copy).w,d0
		sub.w	d2,d0
		move.w	d0,(Camera_X_pos_BG_copy).w
		move.w	d0,(HScroll_table+$004).w
		move.w	d0,(HScroll_table+$036).w
		bra.s	loc_3D24C
; ---------------------------------------------------------------------------

loc_3D21E:
		moveq	#0,d1

loc_3D220:
		move.w	(Camera_Y_pos_copy).w,d0
		move.w	(Screen_shake_offset).w,d2
		sub.w	d2,d0
		sub.w	d1,d0					; Subtract from that and the special offset for MGZ2 events
		swap	d0
		clr.w	d0
		asr.l	#4,d0
		move.l	d0,d1
		add.l	d0,d0
		add.l	d1,d0
		swap	d0
		add.w	d2,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w		; Effective BG Y is normal 3/16ths normal BG Y during normal play
		clr.w	(Camera_X_pos_BG_copy).w
		clr.w	(HScroll_table+$004).w
		clr.w	(HScroll_table+$036).w

loc_3D24C:
		move.w	(Camera_X_pos_copy).w,d0
		cmpi.w	#8,(Events_routine_fg).w
		bne.s	loc_3D25C
		move.w	(Events_bg+$0C).w,d0		; If playing on the boss, use the special camera scrolling set by MGZ2's screen event

loc_3D25C:
		swap	d0
		clr.w	d0
		asr.l	#1,d0
		move.l	d0,d1
		asr.l	#3,d1
		move.l	d1,d2
		asr.l	#2,d2
		lea	(HScroll_table+$036).w,a1
		moveq	#8-1,d3

loc_3D270:
		swap	d0
		move.w	d0,-(a1)
		swap	d0
		sub.l	d1,d0
		dbf	d3,loc_3D270
		tst.w	(Events_bg+$0E).w			; If EEE0 is set, don't bother moving the clouds automatically
		bne.s	loc_3D28A
		addi.l	#$800,(HScroll_table+$038).w

loc_3D28A:
		move.l	(HScroll_table+$038).w,d1
		lea	(HScroll_table+$008).w,a1
		lea	MGZ2_BGDeformIndex(pc),a5
		move.l	d2,d0
		asr.l	#1,d2
		moveq	#$F-1,d3

loc_3D29C:
		move.w	(a5)+,d4
		add.l	d1,d0
		swap	d0
		move.w	d0,(a1,d4.w)
		swap	d0
		add.l	d2,d0
		dbf	d3,loc_3D29C
		lea	MGZ2_BGDeformOffset(pc),a5
		moveq	#$17-1,d0

loc_3D2B4:
		move.w	(a5)+,d1
		add.w	d1,(a1)+
		dbf	d0,loc_3D2B4
		rts

; =============== S U B R O U T I N E =======================================


MGZ2_ClearBottomBG:
		move.w	(a3),d0
		addq.w	#8,d0
		move.w	d0,$74(a3)
		move.w	d0,$78(a3)
		move.w	d0,$7C(a3)
		rts
; End of function MGZ2_ClearBottomBG


; =============== S U B R O U T I N E =======================================


MGZ2_BGEventTrigger:
		tst.w	(_unkEEA2).w
		beq.s	loc_3D2D8
		rts
; ---------------------------------------------------------------------------

loc_3D2D8:
		move.w	(Player_1+x_pos).w,d0
		move.w	(Player_1+y_pos).w,d1
		move.w	(Events_bg+$00).w,d2
		jmp	MGZ2_BGEventTrigger.Index(pc,d2.w)
; End of function MGZ2_BGEventTrigger

; ---------------------------------------------------------------------------

MGZ2_BGEventTrigger.Index:
		bra.w	loc_3D376	; 0 - Normal
; ---------------------------------------------------------------------------
		bra.w	loc_3D348	; 4 - Knuckles BG Move Event
; ---------------------------------------------------------------------------
		bra.w	loc_3D310	; 8 - Sonic BG Move Event
; ---------------------------------------------------------------------------
		clr.b	(Background_collision_flag).w	; C - After BG Move
		cmpi.w	#$800,d1		; Turn off BG collision
		blo.w	loc_3D3C4
		cmpi.w	#$3A40,d0
		blo.w	loc_3D3C4		; If Player (Sonic/Tails) is > $800 Y and > $3A40 X, go back to BG event
		move.w	#8,(Events_bg+$00).w
		rts
; ---------------------------------------------------------------------------

loc_3D310:
		st	(Background_collision_flag).w		; Set BG collision on
		cmpi.w	#$800,d1
		bhs.s	loc_3D32E
		cmpi.w	#$3900,d0
		blo.w	loc_3D3C4
		st	(Events_bg+$0E).w		; If Player < $800 Y and > $3900 X, turn off cloud movement
		clr.l	(HScroll_table+$038).w
		moveq	#$C,d0			; Go to after BG Event trigger
		bra.s	loc_3D340
; ---------------------------------------------------------------------------

loc_3D32E:
		cmpi.w	#$900,d1
		bhs.w	loc_3D3C4
		cmpi.w	#$34C0,d0
		bhs.w	loc_3D3C4		; If player is > $900 Y or > $34C0 X, continue normal deformation
		moveq	#0,d0

loc_3D340:
		move.w	d0,(Events_bg+$00).w	; Otherwise, return to normal BG collision trigger
		moveq	#-1,d0
		rts
; ---------------------------------------------------------------------------

loc_3D348:
		st	(Background_collision_flag).w		; Set BG collision on
		cmpi.w	#$100,d1
		bhs.s	loc_3D35C
		cmpi.w	#$3C00,d0
		blo.s	loc_3D35C
		clr.b	(Background_collision_flag).w	; If Player < $100 Y and > $3C00 X, turn off BG collision

loc_3D35C:
		cmpi.w	#$80,d1
		blo.s	loc_3D3C4
		cmpi.w	#$180,d1
		bhs.s	loc_3D3C4
		cmpi.w	#$3800,d0
		bhs.s	loc_3D3C4		; If player is < $80 Y and > $180 Y and  > $3800 X, continue deformation
		clr.w	(Events_bg+$00).w	; Otherwise
		moveq	#-1,d0
		rts
; ---------------------------------------------------------------------------

loc_3D376:
		clr.b	(Background_collision_flag).w
		cmpi.w	#$80,d1
		blo.s	loc_3D3C4
		cmpi.w	#$180,d1
		bhs.s	loc_3D396
		cmpi.w	#$3800,d0
		blo.s	loc_3D3C4
		moveq	#4,d0			; If between $80 and $180 Y and > $3800 X, use first BG move
		move.l	#Obj_MGZ2BGMoveKnux,d1
		bra.s	loc_3D3B0
; ---------------------------------------------------------------------------

loc_3D396:
		cmpi.w	#$800,d1
		blo.s	loc_3D3C4
		cmpi.w	#$900,d1
		bhs.s	loc_3D3C4
		cmpi.w	#$34C0,d0
		blo.s	loc_3D3C4
		moveq	#8,d0			; If between $800 and $900 Y and > $34C0 X, use second BG move
		move.l	#Obj_MGZ2BGMoveSonic,d1

loc_3D3B0:
		move.w	d0,(Events_bg+$00).w
		clr.w	(Events_bg+$02).w
		jsr	(AllocateObject).l
		bne.s	locret_3D3C2
		move.l	d1,(a1)

locret_3D3C2:
		rts
; ---------------------------------------------------------------------------

loc_3D3C4:
		moveq	#0,d0
		rts
; ---------------------------------------------------------------------------

Obj_MGZ2BGMoveKnux:
		moveq	#4,d0
		move.w	#$400,d1
		move.w	#$38A0,d2
		move.w	#$220,d3
		move.w	#$6000,d4
		bra.s	loc_3D3F2
; ---------------------------------------------------------------------------

Obj_MGZ2BGMoveSonic:
		moveq	#8,d0
		move.w	#$A80,d1
		move.w	#$36D0,d2
		move.w	#$1D0,d3
		move.w	#$6000,d4
		st	$38(a0)

loc_3D3F2:
		cmp.w	(Events_bg+$00).w,d0
		beq.s	loc_3D3FE
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_3D3FE:
		cmp.w	(Player_1+y_pos).w,d1
		bhs.s	locret_3D40A
		cmp.w	(Player_1+x_pos).w,d2
		blo.s	loc_3D40C

locret_3D40A:
		rts
; ---------------------------------------------------------------------------

loc_3D40C:
		move.w	d3,$2E(a0)
		move.w	d4,$32(a0)
		move.w	(Camera_X_pos_copy).w,d0
		move.w	d0,(Camera_min_X_pos).w
		move.w	d0,(Camera_target_min_X_pos).w
		move.l	#loc_3D426,(a0)

loc_3D426:
		move.w	(Events_bg+$02).w,d0
		cmp.w	$2E(a0),d0			; Wait for BG offset to match given value
		blo.s	loc_3D444
		moveq	#signextendB(sfx_Crash),d0				; Play final crashing sound
		jsr	(Play_SFX).l
		move.w	#$E,(Screen_shake_flag).w	; Do final screen shake
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_3D444:
		move.w	(Player_1+x_pos).w,d2
		move.w	(Player_1+y_pos).w,d3
		tst.b	$39(a0)
		beq.s	loc_3D458
		move.w	d0,d1
		addq.w	#1,d1
		bra.s	loc_3D484
; ---------------------------------------------------------------------------

loc_3D458:
		tst.b	$38(a0)
		bne.s	loc_3D46C
		cmpi.w	#$200,d3
		bhs.s	loc_3D476
		cmpi.w	#$3CB0,d2
		blo.s	loc_3D472
		bra.s	loc_3D476
; ---------------------------------------------------------------------------

loc_3D46C:
		cmpi.w	#$3D50,d2	; Second background object check
		blo.s	loc_3D476

loc_3D472:
		st	$39(a0)

loc_3D476:
		move.l	$34(a0),d1
		add.l	$30(a0),d1
		move.l	d1,$34(a0)
		swap	d1

loc_3D484:
		move.w	d1,(Events_bg+$02).w	; Move background offset
		sub.w	d0,d1
		sub.w	d1,(Player_1+y_pos).w
		sub.w	d1,(Player_2+y_pos).w
		rts
; ---------------------------------------------------------------------------
MGZ2_BGDrawArray:
		dc.w   $200, $7FFF
MGZ2_BGDeformArray:
		dc.w    $10,   $10,   $10,   $10,   $10,   $18,     8,   $10,     8,     8,   $10,     8
		dc.w      8,     8,     5,   $2B,    $C,     6,     6,     8,     8,   $18,   $D8, $7FFF
MGZ2_BGDeformIndex:
		dc.w    $1C,   $18,   $1A,    $C,     6,   $14,     2,   $10,   $16,   $12,    $A,     0,     8,     4,    $E
MGZ2_BGDeformOffset:
		dc.w     -5,    -8,     9,    $A,     2,   -$C,     3,   $10,    -1,    $D,   -$F,     6
		dc.w    -$B,    -4,    $E,    -8,   $10,     8,     0,    -8,   $10,     8,     0
; ---------------------------------------------------------------------------

CNZ1_ScreenInit:
		jsr	Reset_TileOffsetPositionActual(pc)
		jmp	Refresh_PlaneFull(pc)
; ---------------------------------------------------------------------------

CNZ1_ScreenEvent:
		tst.w	(Events_bg+$06).w
		beq.s	loc_3D52A
		clr.w	(Events_bg+$06).w
		jmp	Refresh_PlaneScreenDirect(pc)
; ---------------------------------------------------------------------------

loc_3D52A:
		jsr	DrawTilesAsYouMove(pc)
		lea	(Events_bg+$00).w,a5
		tst.l	(a5)
		beq.w	locret_3D5EA
		move.w	(a5)+,d0			; All this below is for removing chunks from the miniboss arena
		move.w	(a5),d1
		clr.l	-2(a5)
		move.w	d0,d2
		move.w	d1,d3
		asr.w	#3,d2
		move.w	d2,d4
		asr.w	#4,d2
		move.w	d3,d5
		asr.w	#5,d3
		and.w	(Layout_row_index_mask).w,d3
		movea.w	(a3,d3.w),a4
		moveq	#-1,d6
		clr.w	d6
		move.b	(a4,d2.w),d6
		lsl.w	#7,d6
		andi.w	#$C,d4
		andi.w	#$60,d5
		add.w	d4,d6
		add.w	d5,d6
		movea.l	d6,a4
		clr.l	(a4)
		clr.l	$10(a4)		; Clear the neccesary parts of the chunks
		asr.w	#2,d0
		andi.w	#$78,d0
		lsl.w	#4,d1
		andi.w	#$E00,d1
		add.w	d1,d0
		add.w	d7,d0
		moveq	#0,d1
		move.w	d0,(a0)+
		move.w	#1,(a0)+
		move.l	d1,(a0)+
		move.l	d1,(a0)+
		move.l	d1,(a0)+
		move.l	d1,(a0)+
		addi.w	#$100,d0
		move.w	d0,(a0)+
		move.w	#1,(a0)+
		move.l	d1,(a0)+
		move.l	d1,(a0)+
		move.l	d1,(a0)+
		move.l	d1,(a0)+		; Add a VRAM write to remove it from the screen
		clr.w	(a0)
		movea.w	$18(a3),a4
		lea	$64(a4),a4			; Level layout $300 Y $3200 X (the boss arena blocks)
		moveq	#0,d1
		clr.w	(Events_bg+$04).w
		moveq	#4-1,d3

loc_3D5B8:
		lea	(a4),a5
		moveq	#2,d2

loc_3D5BC:
		moveq	#-1,d0
		clr.w	d0
		move.b	(a5)+,d0
		lsl.w	#7,d0
		add.w	d1,d0
		movea.l	d0,a6
		tst.l	(a6)+
		bne.s	locret_3D5EA
		tst.l	(a6)+
		bne.s	locret_3D5EA
		tst.l	(a6)+
		bne.s	locret_3D5EA
		tst.l	(a6)
		bne.s	locret_3D5EA
		dbf	d2,loc_3D5BC
		addi.w	#$20,d1			; Basically, if a line of blocks is completely destroyed, the boss is lowered by $20 pixels to compensate.
		addi.w	#$20,(Events_bg+$04).w
		dbf	d3,loc_3D5B8

locret_3D5EA:
		rts
; ---------------------------------------------------------------------------

CNZ1_BackgroundInit:
		jsr	CNZ1_Deform(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		moveq	#0,d1
		jsr	Refresh_PlaneFull(pc)
		lea	CNZ1_BGDeformArray(pc),a4
		lea	(HScroll_table).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

CNZ1_BackgroundEvent:
		move.w	(Events_routine_bg).w,d0
		jmp	.Index(pc,d0.w)
; ---------------------------------------------------------------------------

.Index:
		bra.w	CNZ1BGE_Normal
; ---------------------------------------------------------------------------
		bra.w	CNZ1BGE_BossStart
; ---------------------------------------------------------------------------
		bra.w	CNZ1BGE_Boss
; ---------------------------------------------------------------------------
		bra.w	CNZ1BGE_AfterBoss
; ---------------------------------------------------------------------------
		bra.w	CNZ1BGE_FGRefresh
; ---------------------------------------------------------------------------
		bra.w	CNZ1BGE_FGRefresh2
; ---------------------------------------------------------------------------
		bra.w	CNZ1BGE_DoTransition
; ---------------------------------------------------------------------------

CNZ1BGE_Normal:
		cmpi.w	#$3000,(Camera_X_pos_copy).w
		blo.s	loc_3D678
		cmpi.w	#$54C,(Camera_Y_pos_copy).w
		blo.s	loc_3D652
		move.w	#$700,d0			; This is positional adjustment for Knuckles' path
		sub.w	d0,(Player_1+y_pos).w
		sub.w	d0,(Player_2+y_pos).w
		sub.w	d0,(Camera_Y_pos).w
		sub.w	d0,(Camera_Y_pos_copy).w
		jsr	Reset_TileOffsetPositionActual(pc)

loc_3D652:
		jsr	CNZ1_BossLevelScroll(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		lea	(Pal_CNZMiniboss).l,a1
		jsr	(PalLoad_Line1).l
		move.w	#$1C0,d0
		move.w	d0,(Camera_min_Y_pos).w	; Change level start Y
		move.w	d0,(Camera_target_min_Y_pos).w
		addq.w	#4,(Events_routine_bg).w
		bra.s	loc_3D69C
; ---------------------------------------------------------------------------

loc_3D678:
		jsr	CNZ1_Deform(pc)
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)
		lea	CNZ1_BGDeformArray(pc),a4
		lea	(HScroll_table).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

CNZ1BGE_BossStart:
		jsr	CNZ1_BossLevelScroll(pc)

loc_3D69C:
		jsr	DrawBGAsYouMove(pc)
		jmp	PlainDeformation(pc)
; ---------------------------------------------------------------------------

CNZ1BGE_Boss:
		jsr	CNZ1_BossLevelScroll2(pc)
		lea	(Camera_X_pos_BG_copy).w,a6
		lea	(Camera_X_pos_BG_rounded).w,a5
		move.w	#$200,d1
		moveq	#$10,d6
		jsr	Draw_TileColumn(pc)
		jmp	PlainDeformation(pc)
; ---------------------------------------------------------------------------

CNZ1BGE_AfterBoss:
		tst.w	(Events_fg_5).w
		bne.s	loc_3D6D4
		jsr	CNZ1_BossLevelScroll2(pc)
		jsr	DrawBGAsYouMove(pc)
		jsr	PlainDeformation(pc)
		jmp	Get_BGActualEffectiveDiff(pc)
; ---------------------------------------------------------------------------

loc_3D6D4:
		clr.w	(Events_fg_5).w		; When signalled
		move.w	#$2F0,(Draw_delayed_position).w	; Set refresh position
		move.w	#$F,(Draw_delayed_rowcount).w	; Refresh number
		addq.w	#4,(Events_routine_bg).w

CNZ1BGE_FGRefresh:
		move.w	#VRAM_Plane_A_Name_Table,d7
		moveq	#0,d1
		move.w	#$200,d2
		jsr	Draw_PlaneVertSingleBottomUp(pc)	; Refresh the foreground using BG chunks
		bmi.s	loc_3D70C
		move.w	#VRAM_Plane_B_Name_Table,d7
		jsr	CNZ1_BossLevelScroll2(pc)
		jsr	DrawBGAsYouMove(pc)
		jsr	PlainDeformation(pc)
		jmp	Get_BGActualEffectiveDiff(pc)
; ---------------------------------------------------------------------------

loc_3D70C:
		movea.w	$C(a3),a1		; $180 Y of BG
		addq.w	#4,a1			; $200 X of BG
		move.w	-8(a3),d0		; Get X size of BG
		subq.w	#5,d0
		movea.w	$12(a3),a5		; $280 Y of FG
		lea	$63(a5),a5		; $3180 of FG
		move.w	-$A(a3),d1		; Get X size of FG
		subq.w	#5,d1
		moveq	#6-1,d2

loc_3D728:
		move.b	(a1)+,(a5)+		; Replace 5x5 portion of Foreground with equivalent from BG. Basically,
		move.b	(a1)+,(a5)+		; transferring the actual layout to the FG for use with collision.
		move.b	(a1)+,(a5)+
		move.b	(a1)+,(a5)+
		move.b	(a1)+,(a5)+
		adda.w	d0,a1
		adda.w	d1,a5
		dbf	d2,loc_3D728
		clr.b	(Background_collision_flag).w	; Turn off BG collision
		clr.w	(Events_bg+$08).w	; Turn off scrolling
		move.w	#$1C0,d0
		add.w	d0,(Player_1+y_pos).w	; Move players and camera to position
		add.w	d0,(Player_2+y_pos).w
		add.w	d0,(Camera_Y_pos).w
		add.w	d0,(Camera_Y_pos_copy).w
		jsr	Reset_TileOffsetPositionActual(pc)
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w	; Set up refresh position
		move.w	#$F,(Draw_delayed_rowcount).w	; Refresh amount
		addq.w	#4,(Events_routine_bg).w

CNZ1BGE_FGRefresh2:
		lea	(Level_layout_main).w,a3
		move.w	#VRAM_Plane_A_Name_Table,d7
		move.w	(Camera_X_pos_copy).w,d1
		move.w	(Camera_Y_pos_copy).w,d2
		jsr	Draw_PlaneVertSingleBottomUp(pc)	; Refresh the FG using FG chunks this time
		bmi.s	loc_3D798
		addq.w	#2,a3
		move.w	#VRAM_Plane_B_Name_Table,d7
		jsr	CNZ1_BossLevelScroll2(pc)
		jsr	DrawBGAsYouMove(pc)
		jmp	PlainDeformation(pc)
; ---------------------------------------------------------------------------

loc_3D798:
		addq.w	#2,a3
		move.w	#VRAM_Plane_B_Name_Table,d7
		jsr	(AllocateObject).l
		bne.s	loc_3D7B2
		move.l	#Obj_EndSign,(a1)
		move.w	#$32C0,x_pos(a1)			; Set up the end sign

loc_3D7B2:
		addq.w	#4,(Events_routine_bg).w

CNZ1BGE_DoTransition:
		tst.w	(Events_fg_5).w
		beq.w	loc_3D870				; Don't do anything until signpost lands
		clr.w	(Events_fg_5).w
		movem.l	d7-a0/a2-a3,-(sp)
		moveq	#$18,d0
		jsr	(Load_PLC).l
		moveq	#$19,d0
		jsr	(Load_PLC).l					; Load CNZ 2 PLCs
		move.w	#$301,(Current_zone_and_act).w		; Change to act 2
		clr.b	(Dynamic_resize_routine).w
		clr.b	(Object_load_routine).w
		clr.b	(Rings_manager_routine).w
		clr.b	(Boss_flag).w
		clr.b	(Respawn_table_keep).w			; Reset various managers
		jsr	Clear_Switches(pc)
		jsr	(Load_Level).l
		jsr	(LoadSolids).l
		jsr	(CheckLevelForWater).l		; Level stuff, etc etc
		move.w	#$8014,(VDP_control_port).l		; Turn HInt on for water
		moveq	#$11,d0
		jsr	(LoadPalette_Immediate).l	; Load CNZ palette
		movem.l	(sp)+,d7-a0/a2-a3
		move.w	#$3000,d0
		move.w	#-$200,d1
		sub.w	d0,(Player_1+x_pos).w
		sub.w	d1,(Player_1+y_pos).w
		sub.w	d0,(Player_2+x_pos).w
		sub.w	d1,(Player_2+y_pos).w		; Offset object/player positions
		jsr	Offset_ObjectsDuringTransition(pc)
		sub.w	d0,(Camera_X_pos).w
		sub.w	d1,(Camera_Y_pos).w
		sub.w	d0,(Camera_X_pos_copy).w
		sub.w	d1,(Camera_Y_pos_copy).w		; Offset camera positions
		sub.w	d0,(Camera_min_X_pos).w
		sub.w	d0,(Camera_max_X_pos).w
		sub.w	d1,(Camera_min_Y_pos).w
		sub.w	d1,(Camera_max_Y_pos).w		; Offset level start/ends
		move.w	(Camera_max_Y_pos).w,(Camera_target_max_Y_pos).w
		jsr	Reset_TileOffsetPositionActual(pc)
		move.w	#$2F0,(Draw_delayed_position).w		; Set up refresh
		move.w	#$F,(Draw_delayed_rowcount).w
		clr.w	(Events_routine_bg).w

loc_3D870:
		jsr	CNZ1_BossLevelScroll2(pc)
		jsr	DrawBGAsYouMove(pc)
		jmp	PlainDeformation(pc)

; =============== S U B R O U T I N E =======================================


CNZ1_Deform:
		move.w	(Camera_Y_pos_copy).w,d0
		swap	d0
		clr.w	d0
		asr.l	#4,d0
		move.l	d0,d1
		asr.l	#1,d1
		add.l	d1,d0
		asr.l	#2,d1
		add.l	d1,d0
		swap	d0
		move.w	d0,(Camera_Y_pos_BG_copy).w		; Effective BG Y is about 1/10th (13/128ths to be exact) of camera Y
		move.w	(Camera_X_pos_copy).w,d0
		swap	d0
		clr.w	d0
		asr.l	#1,d0
		move.l	d0,d1
		asr.l	#3,d1
		lea	(HScroll_table+$00A).w,a1
		swap	d0
		move.w	d0,-(a1)
		swap	d0
		sub.l	d1,d0
		swap	d0
		move.w	d0,(Camera_X_pos_BG_copy).w		; Effective BG X is 7/16th speed of normal camera
		move.w	d0,-(a1)
		swap	d0
		sub.l	d1,d0
		sub.l	d1,d0
		swap	d0
		move.w	d0,(Events_bg+$10).w		; Dynamic art reload BG speed is 5/16th of normal camera
		swap	d0
		sub.l	d1,d0
		swap	d0
		move.w	d0,-(a1)
		swap	d0
		sub.l	d1,d0
		sub.l	d1,d0
		swap	d0
		move.w	d0,-(a1)
		swap	d0
		sub.l	d1,d0
		asr.l	#1,d1
		sub.l	d1,d0
		swap	d0
		move.w	d0,-(a1)
		rts
; End of function CNZ1_Deform


; =============== S U B R O U T I N E =======================================


CNZ1_BossLevelScroll:
		cmpi.w	#$1E0,(Camera_Y_pos_BG_copy).w
		blo.s	CNZ1_BossLevelScroll2
		addq.w	#4,(Events_routine_bg).w

CNZ1_BossLevelScroll2:
		move.w	(Camera_Y_pos_copy).w,d0
		subi.w	#$100,d0
		add.w	(Events_bg+$08).w,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Camera_X_pos_copy).w,d0
		subi.w	#$2F80,d0
		move.w	d0,(Camera_X_pos_BG_copy).w
		rts
; End of function CNZ1_BossLevelScroll

; ---------------------------------------------------------------------------

Obj_CNZMinibossScrollControl:
		moveq	#0,d0
		move.b	routine(a0),d0
		jmp	.Index(pc,d0.w)
; ---------------------------------------------------------------------------

.Index:
		bra.w	Obj_CNZMinibossScrollInit
; ---------------------------------------------------------------------------
		bra.w	Obj_CNZMinibossScrollMain
; ---------------------------------------------------------------------------
		bra.w	Obj_CNZMinibossScrollWait
; ---------------------------------------------------------------------------
		bra.w	Obj_CNZMinibossScrollSlow
; ---------------------------------------------------------------------------
		bra.w	Obj_CNZMinibossScrollWait2
; ---------------------------------------------------------------------------
		bra.w	Obj_CNZMinibossScrollWait3
; ---------------------------------------------------------------------------

Obj_CNZMinibossScrollInit:
		lea	(Level_layout_main).w,a3
		movea.w	$14(a3),a1			; $280 Y
		move.b	$63(a1),d0			; $3180 X chunk
		suba.w	-8(a3),a1
		move.b	d0,$63(a1)			; Replace FG layout piece
		addq.w	#2,a3
		movea.w	(a3),a1
		move.b	4(a1),d0
		move.w	-8(a3),d1
		adda.w	d1,a1
		move.b	d0,4(a1)
		adda.w	d1,a1
		move.b	d0,4(a1)			; Replace BG layout piece
		addq.b	#4,routine(a0)

Obj_CNZMinibossScrollMain:
		tst.w	(Events_fg_5).w
		bne.s	loc_3D982
		move.l	(Events_bg+$0C).w,d0	; Speed up scroll
		cmpi.l	#$40000,d0
		bhs.s	loc_3D97C
		addi.l	#$200,d0
		move.l	d0,(Events_bg+$0C).w

loc_3D97C:
		add.l	d0,(Events_bg+$08).w	; Set BG scrolling speed
		rts
; ---------------------------------------------------------------------------

loc_3D982:
		clr.w	(Events_fg_5).w		; When boss is completed
		addq.b	#4,routine(a0)

Obj_CNZMinibossScrollWait:
		move.w	(Events_bg+$08).w,d0
		andi.w	#$FF,d0
		cmpi.w	#4,d0
		blo.s	loc_3D9A2			; Wait until the offset is a multiple of $100
		move.l	(Events_bg+$0C).w,d0
		add.l	d0,(Events_bg+$08).w
		rts
; ---------------------------------------------------------------------------

loc_3D9A2:
		addq.b	#4,routine(a0)

Obj_CNZMinibossScrollSlow:
		move.l	(Events_bg+$0C).w,d0	; Start slowing down the scrolling
		cmpi.l	#$10000,d0
		bls.s	loc_3D9C2
		subi.l	#$400,d0
		move.l	d0,(Events_bg+$0C).w
		add.l	d0,(Events_bg+$08).w
		rts
; ---------------------------------------------------------------------------

loc_3D9C2:
		addq.b	#4,routine(a0)

Obj_CNZMinibossScrollWait2:
		move.w	(Events_bg+$08).w,d0
		andi.w	#$FF,d0
		cmpi.w	#4,d0
		blo.s	loc_3D9DE			; Keep going until offset is a multiple of $100 again
		move.l	(Events_bg+$0C).w,d0
		add.l	d0,(Events_bg+$08).w
		rts
; ---------------------------------------------------------------------------

loc_3D9DE:
		move.w	d0,(Events_bg+$08).w		; Reset scroll offset
		move.w	#$1000,(Camera_target_max_Y_pos).w	; Reset Y end
		st	(Background_collision_flag).w		; BG collision is on
		addq.w	#4,(Events_routine_bg).w		; Next BG Event
		movea.w	(Level_layout_main).w,a1
		lea	$67(a1),a1
		move.w	(Level_layout_header).w,d0
		moveq	#0,d1
		moveq	#6,d2

loc_3DA00:
		move.b	d1,(a1)					; Copy top of FG at $3380 downwards
		adda.w	d0,a1
		dbf	d2,loc_3DA00
		addq.b	#4,routine(a0)

Obj_CNZMinibossScrollWait3:
		cmpi.w	#$1C0,(Events_bg+$08).w		; Wait till scroll offset is $1C0
		bhs.s	loc_3DA1E
		move.l	(Events_bg+$0C).w,d0
		add.l	d0,(Events_bg+$08).w
		rts
; ---------------------------------------------------------------------------

loc_3DA1E:
		st	(Events_fg_5).w				; Set flag to continue next BG event
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------
CNZ1_BGDeformArray:
		dc.w    $80,   $30,   $60,   $C0, $7FFF
; ---------------------------------------------------------------------------

CNZ2_ScreenInit:
		jsr	Reset_TileOffsetPositionActual(pc)
		jmp	Refresh_PlaneFull(pc)
; ---------------------------------------------------------------------------

CNZ2_ScreenEvent:
		move.w	(Screen_shake_offset).w,d0
		add.w	d0,(Camera_Y_pos_copy).w
		tst.w	(Events_bg+$06).w
		beq.s	loc_3DA50
		clr.w	(Events_bg+$06).w
		jmp	Refresh_PlaneScreenDirect(pc)
; ---------------------------------------------------------------------------

loc_3DA50:
		jmp	DrawTilesAsYouMove(pc)
; ---------------------------------------------------------------------------

CNZ2_BackgroundInit:
		move.w	#8,(Events_routine_bg).w
		jsr	CNZ1_Deform(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		moveq	#0,d1
		jsr	Refresh_PlaneFull(pc)
		lea	CNZ1_BGDeformArray(pc),a4
		lea	(HScroll_table).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

CNZ2_BackgroundEvent:
		move.w	(Events_routine_bg).w,d0
		jmp	.Index(pc,d0.w)
; ---------------------------------------------------------------------------

.Index:
		bra.w	loc_3DA88
; ---------------------------------------------------------------------------
		bra.w	loc_3DAB6
; ---------------------------------------------------------------------------
		bra.w	loc_3DACC
; ---------------------------------------------------------------------------

loc_3DA88:
		moveq	#0,d1
		move.w	#$200,d2
		jsr	Draw_PlaneVertSingleBottomUp(pc)
		bpl.w	PlainDeformation
		jsr	CNZ1_Deform(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_bg).w
		bra.s	loc_3DABA
; ---------------------------------------------------------------------------

loc_3DAB6:
		jsr	CNZ1_Deform(pc)

loc_3DABA:
		moveq	#0,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		jsr	Draw_PlaneVertSingleBottomUp(pc)
		bpl.s	loc_3DAD0
		addq.w	#4,(Events_routine_bg).w
		bra.s	loc_3DAD0
; ---------------------------------------------------------------------------

loc_3DACC:
		jsr	CNZ1_Deform(pc)

loc_3DAD0:
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)
		lea	CNZ1_BGDeformArray(pc),a4
		lea	(HScroll_table).w,a5
		jsr	ApplyDeformation(pc)
		jmp	ShakeScreen_Setup(pc)
; ---------------------------------------------------------------------------

ICZ1_ScreenInit:
		move.w	#$7FF,(Screen_Y_wrap_value).w
		move.w	#$7F0,(Camera_Y_pos_mask).w
		move.w	#$3C,(Layout_row_index_mask).w		; We're in a looping level!
		jsr	Reset_TileOffsetPositionActual(pc)
		jmp	Refresh_PlaneFull(pc)
; ---------------------------------------------------------------------------

ICZ1_ScreenEvent:
		move.w	(Events_routine_bg).w,d0
		jmp	.Index(pc,d0.w)
; ---------------------------------------------------------------------------

.Index:
		bra.w	ICZ1SE_Init
; ---------------------------------------------------------------------------
		bra.w	ICZ1SE_WaitQuake
; ---------------------------------------------------------------------------
		bra.w	ICZ1SE_Normal
; ---------------------------------------------------------------------------
		bra.w	ICZ1SE_Normal
; ---------------------------------------------------------------------------
		bra.w	ICZ1SE_Normal
; ---------------------------------------------------------------------------
		bra.w	ICZ1SE_Normal
; ---------------------------------------------------------------------------

ICZ1SE_Init:
		move.w	(Screen_shake_offset).w,d0
		add.w	d0,(Camera_X_pos_copy).w
		bra.s	ICZ1SE_Normal
; ---------------------------------------------------------------------------

ICZ1SE_WaitQuake:
		move.w	(Screen_shake_offset).w,d0
		add.w	d0,(Camera_Y_pos_copy).w

ICZ1SE_Normal:
		jmp	DrawTilesAsYouMove(pc)
; ---------------------------------------------------------------------------

ICZ1_BackgroundInit:
		lea	(a3),a1
		moveq	#8-1,d0

loc_3DB44:
		move.w	(a1),$20(a1)	; Upper $400 of BG is mirrored in lower $400
		addq.w	#4,a1
		dbf	d0,loc_3DB44
		move.w	(Camera_Y_pos_copy).w,(Events_fg_0).w
		move.w	(Camera_Y_pos_copy).w,(Events_fg_1).w		; Camera BG Y is noted in two variables
		cmpi.w	#$3940,(Camera_X_pos_copy).w
		bhs.s	loc_3DB9C
		cmpi.w	#$3600,(Camera_X_pos_copy).w
		blo.s	loc_3DB70
		addi.w	#$2800,(Events_fg_1).w		; If past $3580 X, adjust BG camera

loc_3DB70:
		cmpi.w	#$580,(Camera_Y_pos_copy).w
		bcc.s	loc_3DB9C
		clr.w	(Events_bg+$16).w				; No VScrolling when outside
		jsr	ICZ1_SetIntroPal(pc)
		jsr	ICZ1_IntroDeform(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		move.w	#$1880,d1
		jsr	Refresh_PlaneFull(pc)
		lea	ICZ1_IntroBGDeformArray(pc),a4
		lea	(HScroll_table).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

loc_3DB9C:
		move.w	#$10,(Events_routine_bg).w		; If past $3940 X, we're indoors already
		st	(Events_bg+$16).w				; Go indoors
		jsr	ICZ1_SetIndoorPal(pc)
		jsr	ICZ1_Deform(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		jsr	Refresh_PlaneFull(pc)
		jmp	PlainDeformation(pc)
; ---------------------------------------------------------------------------

ICZ1_BackgroundEvent:
		move.w	(Events_routine_bg).w,d0
		jmp	.Index(pc,d0.w)
; ---------------------------------------------------------------------------

.Index:
		bra.w	ICZ1BGE_Intro
; ---------------------------------------------------------------------------
		bra.w	ICZ1BGE_SnowFall
; ---------------------------------------------------------------------------
		bra.w	ICZ1BGE_Refresh
; ---------------------------------------------------------------------------
		bra.w	ICZ1BGE_Refresh2
; ---------------------------------------------------------------------------
		bra.w	ICZ1BGE_Normal
; ---------------------------------------------------------------------------
		bra.w	ICZ1BGE_Transition
; ---------------------------------------------------------------------------

ICZ1BGE_Intro:
		tst.w	(Events_fg_5).w
		beq.s	loc_3DBFA
		clr.w	(Events_fg_5).w		; If flag is set
		clr.l	(Events_bg+$00).w
		clr.l	(Events_bg+$04).w		; Clear offsets
		jsr	ICZ1_BigSnowFall(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		addq.w	#4,(Events_routine_bg).w
		bra.s	loc_3DC2A
; ---------------------------------------------------------------------------

loc_3DBFA:
		jsr	ICZ1_IntroDeform(pc)		; Deformation is pretty standard during the intro portion
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		move.w	#$1880,d1
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)
		lea	ICZ1_IntroBGDeformArray(pc),a4
		lea	(HScroll_table).w,a5
		jsr	ApplyDeformation(pc)
		jmp	ShakeScreen_Setup(pc)
; ---------------------------------------------------------------------------

ICZ1BGE_SnowFall:
		tst.w	(Events_fg_5).w
		bne.s	loc_3DC36
		jsr	ICZ1_BigSnowFall(pc)

loc_3DC2A:
		jsr	DrawBGAsYouMove(pc)
		jsr	PlainDeformation(pc)
		jmp	ShakeScreen_Setup(pc)
; ---------------------------------------------------------------------------

loc_3DC36:
		clr.w	(Events_fg_5).w
		move.w	#$2E0,(Draw_delayed_position).w		; Set BG refresh position
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_bg).w

ICZ1BGE_Refresh:
		move.w	#$1880,d1
		move.w	#$200,d2
		jsr	Draw_PlaneVertBottomUp(pc)
		bpl.w	PlainDeformation
		jsr	ICZ1_Deform(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_bg).w
		bra.s	loc_3DC7E
; ---------------------------------------------------------------------------

ICZ1BGE_Refresh2:
		jsr	ICZ1_Deform(pc)

loc_3DC7E:
		move.w	(Camera_X_pos_BG_copy).w,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		jsr	Draw_PlaneVertBottomUp(pc)
		bpl.s	loc_3DCEC
		st	(Events_bg+$16).w		; Go indoors
		jsr	ICZ1_SetIndoorPal(pc)	; Set indoor palette
		addq.w	#4,(Events_routine_bg).w
		bra.s	loc_3DCEC
; ---------------------------------------------------------------------------

ICZ1BGE_Normal:
		cmpi.w	#$6900,(Camera_X_pos_copy).w
		blo.s	loc_3DCE8
		movem.l	d7-a0/a2-a3,-(sp)
		lea	(ICZ2_128x128_Secondary_Kos).l,a1
		lea	(RAM_start+$A00).l,a2
		jsr	(Queue_Kos).l
		lea	(ICZ2_16x16_Secondary_Kos).l,a1
		lea	(Block_table+$408).w,a2
		jsr	(Queue_Kos).l
		lea	(ICZ2_8x8_Secondary_KosM).l,a1
		move.w	#tiles_to_bytes($122),d2
		jsr	(Queue_Kos_Module).l
		moveq	#$20,d0
		jsr	(Load_PLC).l
		movem.l	(sp)+,d7-a0/a2-a3
		addq.w	#4,(Events_routine_bg).w

loc_3DCE8:
		jsr	ICZ1_Deform(pc)

loc_3DCEC:
		jsr	DrawBGAsYouMove(pc)
		jmp	PlainDeformation(pc)
; ---------------------------------------------------------------------------

ICZ1BGE_Transition:
		tst.w	(Kos_decomp_queue_count).w
		bne.w	loc_3DDA6
		move.w	#$501,(Current_zone_and_act).w
		clr.b	(Dynamic_resize_routine).w
		clr.b	(Object_load_routine).w
		clr.b	(Rings_manager_routine).w
		clr.b	(Boss_flag).w
		clr.b	(Respawn_table_keep).w
		jsr	Clear_Switches(pc)
		movem.l	d7-a0/a2-a3,-(sp)
		jsr	(Load_Level).l
		jsr	(LoadSolids).l
		jsr	(CheckLevelForWater).l
		move.w	#$8014,(VDP_control_port).l		; Turn on HInt since ICZ2 has water
		moveq	#$15,d0
		jsr	(LoadPalette_Immediate).l
		movem.l	(sp)+,d7-a0/a2-a3
		move.w	#$6880,d0
		move.w	#-$100,d1
		sub.w	d0,(Player_1+x_pos).w
		sub.w	d1,(Player_1+y_pos).w
		sub.w	d0,(Player_2+x_pos).w
		sub.w	d1,(Player_2+y_pos).w
		jsr	Offset_ObjectsDuringTransition(pc)
		sub.w	d0,(Camera_X_pos).w
		sub.w	d1,(Camera_Y_pos).w
		sub.w	d0,(Camera_X_pos_copy).w
		sub.w	d1,(Camera_Y_pos_copy).w
		move.l	#$7000,d0
		move.l	d0,(Camera_min_X_pos).w
		move.l	d0,(Camera_target_min_X_pos).w
		move.l	#$B20,d0
		move.l	d0,(Camera_min_Y_pos).w
		move.l	d0,(Camera_target_min_Y_pos).w
		move.w	#$FFF,(Screen_Y_wrap_value).w
		move.w	#$FF0,(Camera_Y_pos_mask).w
		move.w	#$7C,(Layout_row_index_mask).w
		jsr	Reset_TileOffsetPositionActual(pc)
		clr.w	(Events_routine_bg).w

loc_3DDA6:
		jsr	ICZ1_Deform(pc)
		jmp	PlainDeformation(pc)

; =============== S U B R O U T I N E =======================================


ICZ1_IntroDeform:
		lea	(Events_fg_0).w,a1
		move.w	(Camera_Y_pos_copy).w,d0
		move.w	#$400,d2
		move.w	#$800,d3
		jsr	Adjust_BGDuringLoop(pc)
		move.w	(Events_fg_1).w,d0
		asr.w	#7,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Camera_X_pos_copy).w,d0
		move.w	(Screen_shake_offset).w,d3
		sub.w	d3,d0
		swap	d0
		clr.w	d0
		asr.l	#5,d0
		move.l	d0,d1
		swap	d0
		add.w	d3,d0
		swap	d0
		lea	(HScroll_table).w,a1
		moveq	#5-1,d2			; First five deformation speeds are constant
		bsr.s	sub_3DDF6
		add.l	d1,d0
		move.l	d1,d2
		asr.l	#1,d2
		add.l	d2,d1
		moveq	#9-1,d2			; Last 9 move slowly automatically
; End of function ICZ1_IntroDeform


; =============== S U B R O U T I N E =======================================


sub_3DDF6:
		swap	d0
		move.w	d0,(a1)+
		swap	d0
		add.l	d1,d0
		dbf	d2,sub_3DDF6
		rts
; End of function sub_3DDF6


; =============== S U B R O U T I N E =======================================


ICZ1_BigSnowFall:
		cmpi.w	#-$120,(Events_bg+$00).w
		ble.s	loc_3DE36
		st	(Screen_shake_flag).w
		addi.l	#$2400,(Events_bg+$04).w
		move.l	(Events_bg+$04).w,d0
		sub.l	d0,(Events_bg+$00).w
		move.w	(Level_frame_counter).w,d0
		subq.w	#1,d0
		andi.w	#$F,d0
		bne.s	loc_3DE42
		moveq	#signextendB(sfx_Rumble2),d0
		jsr	(Play_SFX).l
		bra.s	loc_3DE42
; ---------------------------------------------------------------------------

loc_3DE36:
		tst.w	(Screen_shake_flag).w
		bpl.s	loc_3DE42
		move.w	#4,(Screen_shake_flag).w

loc_3DE42:
		move.w	(Camera_Y_pos_copy).w,d0		; Use portion of background to show snow object
		subi.w	#$460,d0
		add.w	(Events_bg+$00).w,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Camera_X_pos_copy).w,d0
		subi.w	#$1D40,d0
		move.w	d0,(Camera_X_pos_BG_copy).w
		rts
; End of function ICZ1_BigSnowFall


; =============== S U B R O U T I N E =======================================


ICZ1_Deform:
		move.w	(Camera_Y_pos_copy).w,d0
		asr.w	#1,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w	; BG moves up/down at half speed
		asr.w	#1,d0
		move.w	d0,(Events_bg+$12).w	; Dynamic BG moves up/down at quarter speed
		move.w	(Camera_X_pos_copy).w,d0
		asr.w	#1,d0
		subi.w	#$1D80,d0
		move.w	d0,(Camera_X_pos_BG_copy).w	; BG moves left/right at half speed
		asr.w	#1,d0
		move.w	d0,(Events_bg+$10).w	; Dynamic BG moves left/right at quarter speed
		rts
; End of function ICZ1_Deform


; =============== S U B R O U T I N E =======================================


ICZ1_SetIntroPal:
		tst.b	(Game_mode).w
		bmi.s	loc_3DE92
		lea	(Normal_palette_line_4+2).w,a1
		bsr.s	sub_3DE96

loc_3DE92:
		lea	(Target_palette_line_4+2).w,a1

sub_3DE96:
		move.l	#$EEE0EEC,(a1)+
		move.l	#$EEA0ECA,(a1)+
		move.l	#$EC80EA6,(a1)+
		move.l	#$E860E64,(a1)+
		move.l	#$E400E00,(a1)+
		move.l	#$C000000,(a1)+
		move.l	#$AEC0CEA,(a1)+
		move.w	#$E80,(a1)
		rts
; End of function ICZ1_SetIntroPal


; =============== S U B R O U T I N E =======================================


ICZ1_SetIndoorPal:
		tst.b	(Game_mode).w
		bmi.s	loc_3DED2
		lea	(Normal_palette_line_4+2).w,a1
		bsr.s	sub_3DED6

loc_3DED2:
		lea	(Target_palette_line_4+2).w,a1

sub_3DED6:
		move.l	#$EC00E40,(a1)+
		move.l	#$E040C00,(a1)+
		move.l	#$6000200,(a1)+
		move.l	#$0000E64,(a1)+
		move.l	#$E240A02,(a1)+
		move.w	#$402,(a1)
		rts
; End of function ICZ1_SetIndoorPal

; ---------------------------------------------------------------------------
ICZ1_IntroBGDeformArray:
		dc.w    $44,    $C,    $B,    $D,   $18,   $50,     2,     6,     8,   $10,   $18,   $20,   $28, $7FFF
; ---------------------------------------------------------------------------

ICZ2_ScreenInit:
		jsr	Reset_TileOffsetPositionActual(pc)
		jmp	Refresh_PlaneFull(pc)
; ---------------------------------------------------------------------------

ICZ2_ScreenEvent:
		jmp	DrawTilesAsYouMove(pc)		; About as straightforward as you can get really
; ---------------------------------------------------------------------------

ICZ2_BackgroundInit:
		move.w	#4,(Events_routine_bg).w
		cmpi.w	#$3600,(Camera_X_pos_copy).w	; Check ranges for either indoor/outdoor BGs
		bhs.s	loc_3DF48
		cmpi.w	#$720,(Camera_Y_pos_copy).w
		bhs.s	loc_3DF76
		cmpi.w	#$1000,(Camera_X_pos_copy).w
		bhs.s	loc_3DF48
		cmpi.w	#$580,(Camera_Y_pos_copy).w
		bhs.s	loc_3DF76

loc_3DF48:
		clr.w	(Events_bg+$16).w			; Outdoors
		cmpi.w	#$720,(Camera_X_pos_copy).w
		bhs.s	loc_3DF5A
		jsr	ICZ2_SetICZ1Pal(pc)
		bra.s	loc_3DF5E
; ---------------------------------------------------------------------------

loc_3DF5A:
		jsr	ICZ2_SetOutdoorsPal(pc)

loc_3DF5E:
		jsr	ICZ2_OutDeform(pc)
		moveq	#0,d0
		moveq	#0,d1
		jsr	Refresh_PlaneFull(pc)
		lea	ICZ2_OutBGDeformArray(pc),a4
		lea	(HScroll_table).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

loc_3DF76:
		st	(Events_bg+$16).w			; Indoors
		jsr	ICZ2_SetIndoorsPal(pc)
		jsr	ICZ2_InDeform(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		moveq	#0,d1
		jsr	Refresh_PlaneFull(pc)
		lea	ICZ2_InBGDeformArray(pc),a4
		lea	(HScroll_table).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

ICZ2_BackgroundEvent:
		move.w	(Events_routine_bg).w,d0
		jmp	.Index(pc,d0.w)
; ---------------------------------------------------------------------------

.Index:
		bra.w	ICZ2BGE_FromICZ1
; ---------------------------------------------------------------------------
		bra.w	ICZ2BGE_Normal
; ---------------------------------------------------------------------------
		bra.w	ICZ2BGE_Refresh
; ---------------------------------------------------------------------------

ICZ2BGE_FromICZ1:
		addq.w	#4,(Events_routine_bg).w		; This only applies when coming from ICZ 1
		cmpi.w	#$580,(Camera_Y_pos_copy).w
		bhs.s	loc_3DFD8
		bra.s	loc_3E036
; ---------------------------------------------------------------------------

ICZ2BGE_Normal:
		tst.w	(Events_bg+$16).w
		bne.s	loc_3E012
		move.w	(Camera_X_pos_copy).w,d0		; If outdoors
		cmpi.w	#$1000,d0
		blo.s	loc_3E002
		cmpi.w	#$3600,d0
		bhs.s	loc_3E002
		cmpi.w	#$720,(Camera_Y_pos_copy).w
		blo.s	loc_3E002

loc_3DFD8:
		st	(Events_bg+$16).w				; Set to go indoors
		jsr	ICZ2_SetIndoorsPal(pc)
		jsr	ICZ2_InDeform(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_bg).w
		bra.w	loc_3E0B0
; ---------------------------------------------------------------------------

loc_3E002:
		jsr	ICZ2_OutDeform(pc)				; No trigger, run normal deformation


loc_3E006:
		lea	ICZ2_OutBGDeformArray(pc),a4
		lea	(HScroll_table).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

loc_3E012:
		move.w	(Camera_X_pos_copy).w,d0		; If indoors
		cmpi.w	#$1900,d0
		blo.s	loc_3E022
		cmpi.w	#$1B80,d0
		blo.s	loc_3E06C

loc_3E022:
		cmpi.w	#$1000,d0
		blo.s	loc_3E06C
		cmpi.w	#$3600,d0
		bhs.s	loc_3E06C
		cmpi.w	#$720,(Camera_Y_pos_copy).w
		bhs.s	loc_3E06C

loc_3E036:
		clr.w	(Events_bg+$16).w
		cmpi.w	#$720,(Camera_X_pos_copy).w
		bhs.s	loc_3E048
		jsr	ICZ2_SetICZ1Pal(pc)
		bra.s	loc_3E04C
; ---------------------------------------------------------------------------

loc_3E048:
		jsr	ICZ2_SetOutdoorsPal(pc)

loc_3E04C:
		jsr	ICZ2_OutDeform(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_bg).w
		bra.s	loc_3E096
; ---------------------------------------------------------------------------

loc_3E06C:
		jsr	ICZ2_InDeform(pc)

loc_3E070:
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)
		lea	ICZ2_InBGDeformArray(pc),a4
		lea	(HScroll_table).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

ICZ2BGE_Refresh:
		tst.w	(Events_bg+$16).w
		bne.s	loc_3E0AC
		jsr	ICZ2_OutDeform(pc)

loc_3E096:
		moveq	#0,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		jsr	Draw_PlaneVertBottomUp(pc)
		bpl.w	loc_3E006
		subq.w	#4,(Events_routine_bg).w
		bra.w	loc_3E006
; ---------------------------------------------------------------------------

loc_3E0AC:
		jsr	ICZ2_InDeform(pc)

loc_3E0B0:
		moveq	#0,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		jsr	Draw_PlaneVertBottomUp(pc)
		bpl.s	loc_3E070
		subq.w	#4,(Events_routine_bg).w
		bra.s	loc_3E070

; =============== S U B R O U T I N E =======================================


ICZ2_OutDeform:
		clr.w	(Camera_Y_pos_BG_copy).w		; Effective Y is always 0
		move.w	(Camera_X_pos_copy).w,d0
		move.w	(Level_frame_counter).w,d1
		asr.w	#1,d1
		add.w	d1,d0
		swap	d0
		clr.w	d0
		asr.l	#1,d0
		andi.l	#$7FFFFF,d0
		move.l	d0,d1
		asr.l	#6,d1
		lea	(HScroll_table+$064).w,a1
		moveq	#$28-1,d2

loc_3E0E8:
		swap	d0
		move.w	d0,-(a1)
		swap	d0
		sub.l	d1,d0
		dbf	d2,loc_3E0E8
		lea	(HScroll_table).w,a1
		move.w	(Camera_X_pos_copy).w,d0
		swap	d0
		clr.w	d0
		asr.l	#1,d0
		move.l	d0,d1
		asr.l	#1,d0
		add.l	d0,d1
		move.l	d1,$64(a1)
		asr.l	#2,d0
		move.l	d0,d1
		swap	d0
		move.w	d0,(a1)+
		swap	d0
		add.l	d1,d0
		swap	d0
		move.w	d0,(a1)+
		move.w	(Level_frame_counter).w,d1
		lsr.w	#2,d1
		andi.w	#$3E,d1
		lea	AIZ2_ALZ_BGDeformDelta(pc),a5
		adda.w	d1,a5
		moveq	#8-1,d1

loc_3E12E:
		move.w	(a5)+,d2
		add.w	d0,d2
		move.w	d2,(a1)+
		dbf	d1,loc_3E12E
		rts
; End of function ICZ2_OutDeform


; =============== S U B R O U T I N E =======================================


ICZ2_InDeform:
		move.w	(Camera_Y_pos_copy).w,d0
		subi.w	#$700,d0
		asr.w	#2,d0
		addi.w	#$118,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		lea	(HScroll_table).w,a1
		move.w	(Camera_X_pos_copy).w,d0
		swap	d0
		clr.w	d0
		asr.l	#1,d0
		move.l	d0,d1
		asr.l	#3,d1
		swap	d0
		move.w	d0,(a1)
		move.w	d0,$10(a1)
		swap	d0
		sub.l	d1,d0
		swap	d0
		move.w	d0,2(a1)
		move.w	d0,$E(a1)
		swap	d0
		sub.l	d1,d0
		swap	d0
		move.w	d0,4(a1)
		move.w	d0,$C(a1)
		swap	d0
		sub.l	d1,d0
		swap	d0
		move.w	d0,6(a1)
		move.w	d0,$A(a1)
		swap	d0
		sub.l	d1,d0
		swap	d0
		move.w	d0,(Camera_X_pos_BG_copy).w
		move.w	d0,8(a1)
		swap	d0
		sub.l	d1,d0
		swap	d0
		move.w	d0,(Events_bg+$10).w
		rts
; End of function ICZ2_InDeform


; =============== S U B R O U T I N E =======================================


ICZ2_SetOutdoorsPal:
		tst.b	(Game_mode).w
		bmi.s	loc_3E1B6
		lea	(Normal_palette_line_4+2).w,a1
		bsr.s	sub_3E1BA

loc_3E1B6:
		lea	(Target_palette_line_4+2).w,a1

sub_3E1BA:
		move.l	#$EEE0EEA,(a1)+
		move.l	#$EC80EA4,(a1)+
		move.l	#$C820C60,(a1)+
		move.l	#$C400E20,(a1)+
		move.l	#$A000E00,(a1)
		rts
; End of function ICZ2_SetOutdoorsPal


; =============== S U B R O U T I N E =======================================


ICZ2_SetIndoorsPal:
		tst.b	(Game_mode).w
		bmi.s	loc_3E1E6
		lea	(Normal_palette_line_4+2).w,a1
		bsr.s	sub_3E1EA

loc_3E1E6:
		lea	(Target_palette_line_4+2).w,a1

sub_3E1EA:
		move.l	#$EE20E24,(a1)+
		move.l	#$E040E02,(a1)+
		move.l	#$4020200,(a1)+
		move.l	#$0000E20,(a1)+
		move.l	#$E400840,(a1)+
		move.w	#$600,(a1)
		rts
; End of function ICZ2_SetIndoorsPal


; =============== S U B R O U T I N E =======================================


ICZ2_SetICZ1Pal:
		tst.b	(Game_mode).w
		bmi.s	loc_3E21A
		lea	(Normal_palette_line_4+2).w,a1
		bsr.s	sub_3E21E

loc_3E21A:
		lea	(Target_palette_line_4+2).w,a1

sub_3E21E:
		move.l	#$EEC0CC6,(a1)+
		move.l	#$C800C60,(a1)+
		move.l	#$C400A40,(a1)+
		move.l	#$8200620,(a1)+
		move.l	#$2000600,(a1)
		rts
; End of function ICZ2_SetICZ1Pal

; ---------------------------------------------------------------------------
ICZ2_OutBGDeformArray:
		dc.w    $5A,   $26, $8030, $7FFF
ICZ2_InBGDeformArray:
		dc.w   $1A0,   $40,   $20,   $18,   $40,     8,     8,   $18, $7FFF
; ---------------------------------------------------------------------------

LBZ1_ScreenInit:
		move.w	4(a3),d0
		subi.w	#$76,d0
		move.w	d0,$70(a3)
		move.w	d0,$74(a3)
		move.w	d0,$78(a3)
		move.w	d0,$7C(a3)
		lea	(HScroll_table+$148).w,a1
		moveq	#$E-1,d0

loc_3E276:
		clr.l	(a1)+		; Clear VScroll
		dbf	d0,loc_3E276
		jsr	LBZ1_EventVScroll(pc)
		lea	(HScroll_table+$100).w,a1
		moveq	#$C-1,d0

loc_3E286:
		move.w	(a1)+,d1
		and.w	(Camera_Y_pos_mask).w,d1
		move.w	d1,(a1)+	; Set up tile offsets for VScroll array
		dbf	d0,loc_3E286
		cmpi.w	#3,(Player_mode).w
		beq.s	loc_3E2B0
		cmpi.w	#$3B60,(Camera_X_pos_copy).w	; Skip this if Knuckles
		blo.s	loc_3E2B4
		jsr	(AllocateObject).l
		bne.s	loc_3E2B0
		move.l	#Obj_LBZ1InvisibleBarrier,(a1)

loc_3E2B0:
		jsr	LBZ1_ModEndingLayout(pc)

loc_3E2B4:
		move.w	(Player_1+x_pos).w,d0
		move.w	(Player_1+y_pos).w,d1
		moveq	#0,d2
		jsr	LBZ1_CheckLayoutMod(pc)
		jsr	Reset_TileOffsetPositionActual(pc)
		jmp	Refresh_PlaneFull(pc)
; ---------------------------------------------------------------------------

LBZ1_ScreenEvent:
		move.w	(Screen_shake_offset).w,d0
		add.w	d0,(Camera_Y_pos_copy).w
		cmpi.w	#$55,(Events_fg_4).w
		bne.s	loc_3E302
		clr.w	(Events_fg_4).w
		cmpi.w	#$540,(Camera_Y_pos_copy).w
		bcc.s	loc_3E2F4
		movea.w	8(a3),a1
		move.b	#$DA,$7D(a1)		; Changes the chunk where the boss appears
		jmp	Refresh_PlaneScreenDirect(pc)
; ---------------------------------------------------------------------------

loc_3E2F4:
		movea.w	$4C(a3),a1
		move.b	#$DB,$79(a1)
		jmp	Refresh_PlaneScreenDirect(pc)
; ---------------------------------------------------------------------------

loc_3E302:
		move.w	(Player_1+x_pos).w,d0	; Normal level operation
		move.w	(Player_1+y_pos).w,d1
		move.w	(Events_bg+$00).w,d2
		bne.s	loc_3E31C
		jsr	LBZ1_CheckLayoutMod(pc)
		tst.w	d3
		bmi.s	loc_3E36E
		jmp	Refresh_PlaneScreenDirect(pc)	; Refresh screen when a layout mod is made
; ---------------------------------------------------------------------------

loc_3E31C:
		lea	LBZ1_LayoutModExitRange-4(pc),a1		; If already in a layout
		adda.w	d2,a1
		cmp.w	(a1)+,d0
		blo.s	loc_3E32C
		cmp.w	(a1)+,d0
		bhi.s	loc_3E32C
		bra.s	loc_3E36E
; ---------------------------------------------------------------------------

loc_3E32C:
		clr.w	(Events_bg+$00).w
		lsr.w	#1,d2
		jsr	loc_3E33A-2(pc,d2.w)
		jmp	Refresh_PlaneScreenDirect(pc)
; ---------------------------------------------------------------------------

loc_3E33A:
		bra.s	LBZ1_LayoutExitMod1
; ---------------------------------------------------------------------------
		bra.s	LBZ1_LayoutExitMod2
; ---------------------------------------------------------------------------
		bra.s	LBZ1_LayoutExitMod3
; ---------------------------------------------------------------------------
		bra.s	LBZ1_LayoutExitMod4
; ---------------------------------------------------------------------------

LBZ1_LayoutExitMod1:
		movea.w	(a3),a5
		lea	$88(a5),a5
		bra.w	LBZ1_DoMod1
; ---------------------------------------------------------------------------

LBZ1_LayoutExitMod2:
		movea.w	$24(a3),a5
		lea	$8A(a5),a5
		bra.w	LBZ1_DoMod2
; ---------------------------------------------------------------------------

LBZ1_LayoutExitMod3:
		movea.w	(a3),a5
		lea	$98(a5),a5
		bra.w	LBZ1_DoMod3
; ---------------------------------------------------------------------------

LBZ1_LayoutExitMod4:
		movea.w	$30(a3),a5
		lea	$9A(a5),a5
		bra.w	LBZ1_DoMod4
; ---------------------------------------------------------------------------

loc_3E36E:
		jsr	LBZ1_EventVScroll(pc)		; Do the vscroll deformation, if necessary
		lea	LBZ1_FGVScrollArray(pc),a4
		lea	(HScroll_table+$100).w,a5
		moveq	#$F,d6
		moveq	#$C,d5
		jmp	DrawTilesVDeform(pc)

; =============== S U B R O U T I N E =======================================


LBZ1_EventVScroll:
		tst.w	(Events_fg_4).w
		beq.w	loc_3E434
		bpl.s	loc_3E3A6
		move.w	#1,(Events_fg_4).w
		move.w	#4,(Special_V_int_routine).w
		jsr	(AllocateObject).l
		bne.s	loc_3E3A6
		move.l	#Obj_LBZ1InvisibleBarrier,(a1)

loc_3E3A6:
		lea	(HScroll_table+$14C).w,a1
		lea	LBZ1_CollapseScrollSpeed(pc),a5
		move.l	$2C(a1),d0
		addi.l	#$100,$2C(a1)
		move.w	$30(a1),d1
		addq.w	#1,$30(a1)
		asr.w	#6,d1
		moveq	#$A,d2
		moveq	#$A-1,d3

loc_3E3C8:
		addq.w	#2,d1
		andi.w	#$E,d1
		move.w	(a5,d1.w),d4
		ext.l	d4
		lsl.l	#4,d4
		move.l	(a1),d5
		sub.l	d4,d5
		sub.l	d0,d5
		swap	d5
		cmpi.w	#-$300,d5
		bgt.s	loc_3E3EA
		move.w	#-$300,d5
		subq.w	#1,d2

loc_3E3EA:
		swap	d5
		move.l	d5,(a1)+
		dbf	d3,loc_3E3C8
		move.w	(Level_frame_counter).w,d0
		subq.w	#1,d0
		andi.w	#$F,d0
		bne.s	loc_3E40A
		tst.w	d2
		beq.s	loc_3E40A
		moveq	#signextendB(sfx_BigRumble),d0
		jsr	(Play_SFX).l

loc_3E40A:
		tst.w	d2
		bne.s	loc_3E434
		clr.w	(Screen_shake_flag).w
		clr.w	(Events_fg_4).w
		move.w	#$C,(Special_V_int_routine).w
		jsr	LBZ1_ModEndingLayout(pc)
		lea	(HScroll_table+$148).w,a1
		moveq	#$E-1,d0

loc_3E426:
		clr.l	(a1)+
		dbf	d0,loc_3E426
		moveq	#signextendB(sfx_Crash),d0
		jsr	(Play_SFX).l

loc_3E434:
		lea	(HScroll_table+$100).w,a1
		lea	(HScroll_table+$130).w,a4
		lea	(HScroll_table+$148).w,a5
		move.w	(Camera_Y_pos_copy).w,d0
		moveq	#$C-1,d1

loc_3E446:
		move.w	(a5),d2
		add.w	d0,d2
		move.w	d2,(a1)
		move.w	d2,(a4)+
		addq.w	#4,a1
		addq.w	#4,a5
		dbf	d1,loc_3E446
		rts
; End of function LBZ1_EventVScroll


; =============== S U B R O U T I N E =======================================


LBZ1_CheckLayoutMod:
		lea	LBZ1_LayoutModRange(pc),a1
		moveq	#4-1,d3

loc_3E45E:
		lea	(a1),a5
		cmp.w	(a5)+,d0
		bcs.s	loc_3E480
		cmp.w	(a5)+,d0
		bhi.s	loc_3E480
		cmp.w	(a5)+,d1
		bcs.s	loc_3E480
		cmp.w	(a5)+,d1
		bhi.s	loc_3E480
		tst.w	d2
		bne.s	loc_3E48A
		cmpi.w	#$1580,d0		; The first layout mod range ignores a small corner on the lower right.
		bcs.s	loc_3E48A
		cmpi.w	#$400,d1
		bcs.s	loc_3E48A

loc_3E480:
		addq.w	#8,a1
		addq.w	#4,d2
		dbf	d3,loc_3E45E
		rts
; ---------------------------------------------------------------------------

loc_3E48A:
		addq.w	#4,d2
		move.w	d2,(Events_bg+$00).w
		lsr.w	#1,d2
		jmp	LBZ1_LayoutModBranch-2(pc,d2.w)
; ---------------------------------------------------------------------------

LBZ1_LayoutModBranch:
		bra.s	LBZ1_LayoutMod1
; ---------------------------------------------------------------------------
		bra.s	LBZ1_LayoutMod2
; ---------------------------------------------------------------------------
		bra.s	LBZ1_LayoutMod3
; ---------------------------------------------------------------------------
		bra.s	LBZ1_LayoutMod4
; ---------------------------------------------------------------------------

LBZ1_LayoutMod1:
		movea.w	(a3),a5
		lea	$80(a5),a5
		bra.w	LBZ1_DoMod1
; ---------------------------------------------------------------------------

LBZ1_LayoutMod2:
		movea.w	$24(a3),a5
		lea	$80(a5),a5
		bra.s	LBZ1_DoMod2
; ---------------------------------------------------------------------------

LBZ1_LayoutMod3:
		tst.w	(Events_bg+$02).w
		beq.s	loc_3E4C0
		clr.w	(Events_bg+$00).w
		moveq	#-1,d3
		rts
; ---------------------------------------------------------------------------

loc_3E4C0:
		movea.w	(a3),a5
		lea	$94(a5),a5
		bra.s	LBZ1_DoMod3
; ---------------------------------------------------------------------------

LBZ1_LayoutMod4:
		movea.w	$30(a3),a5
		lea	$94(a5),a5

LBZ1_DoMod4:
		movea.w	(a3),a1
		lea	$7A(a1),a1
		move.w	-8(a3),d0
		subq.w	#6,d0
		moveq	#6-1,d1

loc_3E4DE:
		move.l	(a5)+,(a1)+
		move.w	(a5)+,(a1)+
		adda.w	d0,a5
		adda.w	d0,a1
		dbf	d1,loc_3E4DE
		rts
; ---------------------------------------------------------------------------

LBZ1_DoMod3:
		movea.w	(a3),a1
		lea	$74(a1),a1
		move.w	-8(a3),d0
		subq.w	#4,d0
		moveq	#$C-1,d1

loc_3E4FA:
		move.l	(a5)+,(a1)+
		adda.w	d0,a5
		adda.w	d0,a1
		dbf	d1,loc_3E4FA
		rts
; ---------------------------------------------------------------------------

LBZ1_DoMod2:
		movea.w	(a3),a1
		lea	$42(a1),a1
		move.w	-8(a3),d0
		subi.w	#$A,d0
		moveq	#$E-1,d1

loc_3E516:
		move.l	(a5)+,(a1)+
		move.l	(a5)+,(a1)+
		move.w	(a5)+,(a1)+
		adda.w	d0,a5
		adda.w	d0,a1
		dbf	d1,loc_3E516
		rts
; ---------------------------------------------------------------------------

LBZ1_DoMod1:
		movea.w	8(a3),a1
		lea	$26(a1),a1
		move.w	-8(a3),d0
		subq.w	#8,d0
		moveq	#9-1,d1

loc_3E536:
		move.l	(a5)+,(a1)+
		move.l	(a5)+,(a1)+
		adda.w	d0,a5
		adda.w	d0,a1
		dbf	d1,loc_3E536
		rts

; End of function LBZ1_CheckLayoutMod


; =============== S U B R O U T I N E =======================================


LBZ1_ModEndingLayout:
		movea.w	(a3),a1			; This ensures that when Sonic starts from the lamppost before the boss the building behind him disappears
		lea	$74(a1),a1			; It also doubles as the layout used by Knuckles in his version of the level
		move.w	-8(a3),d0
		subq.w	#4,d0
		moveq	#$C-1,d1

loc_3E552:
		clr.l	(a1)+
		adda.w	d0,a1
		dbf	d1,loc_3E552
		st	(Events_bg+$02).w		; Disable the layout modding for this area (layoutmod3)
		rts
; End of function LBZ1_ModEndingLayout

; ---------------------------------------------------------------------------

Obj_LBZ1InvisibleBarrier:
		cmpi.w	#$3D80,(Camera_X_pos_copy).w
		blo.s	loc_3E56E
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_3E56E:
		move.w	#$3BC0,d4
		move.w	d4,x_pos(a0)
		move.w	#$100,y_pos(a0)
		move.b	#$40,width_pixels(a0)
		bset	#7,status(a0)
		moveq	#$4B,d1
		move.w	#$100,d2
		move.w	#$100,d3
		jmp	(SolidObjectFull2).l
; ---------------------------------------------------------------------------
LBZ1_FGVScrollArray:
		dc.w  $3B60,   $10,   $10,   $10,   $10,   $10,   $10,   $10,   $10,   $10,   $10, $7FFF
LBZ1_LayoutModRange:
		dc.w  $13E0, $16A0,  $100,  $580
		dc.w  $2160, $2520,     0,  $700
		dc.w  $3A60, $3BA0,     0,  $600
		dc.w  $3DE0, $3FA0,     0,  $300
LBZ1_LayoutModExitRange:
		dc.w  $1376, $170A
		dc.w  $20F6, $258A
		dc.w  $39F6, $3C0A
		dc.w  $3D76, $400A
LBZ1_CollapseScrollSpeed:
		dc.w   $1EE,  $1F2,   $C7,  $1B3,  $1B7,  $198,    $E,  $139
; ---------------------------------------------------------------------------

LBZ1_BackgroundInit:
		jsr	LBZ1_Deform(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		move.w	d2,(HScroll_table+$002).w
		clr.l	(HScroll_table+$004).w
		lea	LBZ1_BGDrawArray(pc),a4
		lea	(HScroll_table).w,a5
		jsr	Refresh_PlaneTileDeform(pc)
		lea	LBZ1_BGDeformArray(pc),a4
		lea	(HScroll_table+$008).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

LBZ1_BackgroundEvent:
		move.w	(Events_routine_bg).w,d0
		jmp	.Index(pc,d0.w)
; ---------------------------------------------------------------------------

.Index:
		bra.w	LBZ1BGE_Normal
; ---------------------------------------------------------------------------
		bra.w	LBZ1BGE_DoTransition
; ---------------------------------------------------------------------------

LBZ1BGE_Normal:
		tst.w	(Events_fg_5).w
		beq.s	loc_3E670
		clr.w	(Events_fg_5).w		; Yeah, normal transition nonsense for the level change
		movem.l	d7-a0/a2-a3,-(sp)
		lea	(LBZ2_128x128_Kos).l,a1
		lea	(RAM_start).l,a2
		jsr	(Queue_Kos).l
		lea	(LBZ2_16x16_Secondary_Kos).l,a1
		lea	(Block_table+$6B8).w,a2
		jsr	(Queue_Kos).l
		lea	(LBZ2_8x8_Secondary_KosM).l,a1
		move.w	#tiles_to_bytes($19D),d2
		jsr	(Queue_Kos_Module).l
		movem.l	(sp)+,d7-a0/a2-a3
		addq.w	#4,(Events_routine_bg).w

loc_3E670:
		jsr	LBZ1_Deform(pc)
		lea	LBZ1_BGDrawArray(pc),a4
		lea	(HScroll_table).w,a5
		moveq	#$20,d6
		moveq	#2,d5
		jsr	Draw_BG(pc)
		lea	LBZ1_BGDeformArray(pc),a4
		lea	(HScroll_table+$008).w,a5
		jsr	ApplyDeformation(pc)
		lea	LBZ1_FGVScrollArray(pc),a4
		lea	(HScroll_table+$12E).w,a5
		jsr	Apply_FGVScroll(pc)
		jmp	ShakeScreen_Setup(pc)
; ---------------------------------------------------------------------------

LBZ1BGE_DoTransition:
		tst.b	(Kos_modules_left).w
		bne.w	loc_3E74A
		move.w	#$601,(Current_zone_and_act).w
		clr.b	(Dynamic_resize_routine).w
		clr.b	(Object_load_routine).w
		clr.b	(Rings_manager_routine).w
		clr.b	(Boss_flag).w
		clr.b	(Respawn_table_keep).w
		jsr	Clear_Switches(pc)
		movem.l	d7-a0/a2-a3,-(sp)
		jsr	(Load_Level).l
		jsr	(LoadSolids).l
		jsr	(CheckLevelForWater).l
		move.w	#$8014,(VDP_control_port).l		; Water in this stage yaaay
		moveq	#$17,d0
		jsr	(LoadPalette_Immediate).l
		movem.l	(sp)+,d7-a0/a2-a3
		move.w	#$3A00,d0
		moveq	#0,d1
		sub.w	d0,(Player_1+x_pos).w
		sub.w	d0,(Player_2+x_pos).w
		jsr	Offset_ObjectsDuringTransition(pc)
		sub.w	d0,(Camera_X_pos).w
		sub.w	d0,(Camera_X_pos_copy).w
		sub.w	d0,(Camera_min_X_pos).w
		sub.w	d0,(Camera_max_X_pos).w
		jsr	Reset_TileOffsetPositionActual(pc)
		clr.l	(Events_bg+$00).w
		clr.l	(Events_bg+$14).w
		clr.w	(_unkEEA0).w
		clr.w	(Event_LBZ2_DeathEgg).w
		move.w	#$40,(Events_bg+$10).w
		cmpi.w	#$540,(Camera_Y_pos_copy).w
		blo.s	loc_3E738
		neg.w	(Events_bg+$10).w

loc_3E738:
		movem.l	d7-a0/a2-a3,-(sp)
		jsr	(sub_273B4).l				; Start LBZ2 tile animation
		movem.l	(sp)+,d7-a0/a2-a3
		clr.w	(Events_routine_bg).w

loc_3E74A:
		lea	LBZ1_BGDeformArray(pc),a4
		lea	(HScroll_table+$008).w,a5
		jmp	ApplyDeformation(pc)

; =============== S U B R O U T I N E =======================================


LBZ1_Deform:
		move.w	(Camera_Y_pos_copy).w,d0
		move.w	(Screen_shake_offset).w,d1
		sub.w	d1,d0
		asr.w	#4,d0
		add.w	d1,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Camera_X_pos_copy).w,d0
		swap	d0
		clr.w	d0
		asr.l	#4,d0
		move.l	d0,d1
		asr.l	#1,d0
		swap	d0
		move.w	d0,(Events_bg+$10).w
		swap	d0
		swap	d1
		move.w	d1,(Camera_X_pos_BG_copy).w
		move.w	d1,(HScroll_table).w
		move.w	d1,(HScroll_table+$008).w
		swap	d1
		lea	(HScroll_table+$00A).w,a1
		add.l	d0,d1
		add.l	d0,d1
		asr.l	#2,d0
		moveq	#4-1,d2

loc_3E79A:
		swap	d1
		move.w	d1,(a1)+
		swap	d1
		add.l	d0,d1
		dbf	d2,loc_3E79A
		moveq	#$A,d0
		add.w	d0,(Events_bg+$10).w
		add.w	d0,(Camera_X_pos_BG_copy).w
		add.w	d0,(HScroll_table).w
		add.w	d0,(HScroll_table+$008).w
		lea	(HScroll_table+$00A).w,a1
		addq.w	#4,(a1)+
		subq.w	#2,(a1)+
		addq.w	#7,(a1)
		rts
; End of function LBZ1_Deform

; ---------------------------------------------------------------------------
LBZ1_BGDrawArray:
		dc.w    $D0, $7FFF
LBZ1_BGDeformArray:
		dc.w    $D0, $18,     8,     8, $7FFF
; ---------------------------------------------------------------------------

LBZ2_ScreenInit:
		move.w	#4,(Events_routine_fg).w
		clr.l	(Events_bg+$14).w
		clr.w	(_unkEEA0).w
		clr.w	(Event_LBZ2_DeathEgg).w
		bsr.s	LBZ2_LayoutMod
		jsr	Reset_TileOffsetPositionActual(pc)
		jmp	Refresh_PlaneFull(pc)
; ---------------------------------------------------------------------------

LBZ2_ScreenEvent:
		move.w	(Screen_shake_offset).w,d0
		add.w	d0,(Camera_Y_pos_copy).w
		move.w	(Events_routine_fg).w,d0
		jmp	.Index(pc,d0.w)
; ---------------------------------------------------------------------------

.Index:
		bra.w	LBZ2SE_FromTransition
; ---------------------------------------------------------------------------
		bra.w	LBZ2SE_Normal
; ---------------------------------------------------------------------------

LBZ2SE_FromTransition:
		cmpi.w	#3,(Player_mode).w		; Only run when going from transition, of course
		beq.s	loc_3E844				; Knuckles adjusts the layout immediately.
		cmpi.w	#$60A,(Player_1+x_pos).w
		blo.s	loc_3E820
		bsr.s	LBZ2_LayoutMod
		addq.w	#4,(Events_routine_fg).w
		jmp	Refresh_PlaneScreenDirect(pc)
; ---------------------------------------------------------------------------

loc_3E820:
		jmp	DrawTilesAsYouMove(pc)

; =============== S U B R O U T I N E =======================================


LBZ2_LayoutMod:
		movea.w	(a3),a5			; Thankfully, this is the only one in the whole level
		lea	$94(a5),a5
		movea.w	(a3),a1
		addq.w	#6,a1
		move.w	-8(a3),d0
		subq.w	#6,d0
		moveq	#6-1,d1

loc_3E836:
		move.l	(a5)+,(a1)+
		move.w	(a5)+,(a1)+
		adda.w	d0,a5
		adda.w	d0,a1
		dbf	d1,loc_3E836
		rts
; End of function LBZ2_LayoutMod

; ---------------------------------------------------------------------------

loc_3E844:
		bsr.s	LBZ2_LayoutMod
		addq.w	#4,(Events_routine_fg).w

LBZ2SE_Normal:
		jmp	DrawTilesAsYouMove(pc)		; Remarkably straightforward
; ---------------------------------------------------------------------------

LBZ2_BackgroundInit:
		move.w	#8,(Events_routine_bg).w
		jsr	LBZ2_Deform(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		moveq	#0,d1
		jsr	Refresh_PlaneFull(pc)
		moveq	#$40,d0
		cmp.w	(Events_bg+$10).w,d0
		blt.s	loc_3E872
		neg.w	d0
		cmp.w	(Events_bg+$10).w,d0
		bgt.s	loc_3E876

loc_3E872:
		move.w	d0,(Events_bg+$10).w		; Keep art reloading in range

loc_3E876:
		lea	LBZ2_BGDeformArray(pc),a4
		lea	(HScroll_table).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

LBZ2_BackgroundEvent:
		move.w	(Events_routine_bg).w,d0
		jmp	.Index(pc,d0.w)
; ---------------------------------------------------------------------------

.Index:
		bra.w	LBZ2BGE_FromTransition
; ---------------------------------------------------------------------------
		bra.w	LBZ2BGE_Refresh
; ---------------------------------------------------------------------------
		bra.w	LBZ2BGE_Normal
; ---------------------------------------------------------------------------
		bra.w	LBZ2BGE_DeathEgg
; ---------------------------------------------------------------------------
		bra.w	LBZ2BGE_PlatformDetach
; ---------------------------------------------------------------------------
		bra.w	LBZ2BGE_Falling
; ---------------------------------------------------------------------------

LBZ2BGE_FromTransition:
		jsr	LBZ2_Deform(pc)						; This and below are only done when transitioning
		jsr	Reset_TileOffsetPositionEff(pc)
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Draw_delayed_position).w
		move.w	#$F,(Draw_delayed_rowcount).w
		addq.w	#4,(Events_routine_bg).w
		bra.s	loc_3E8C6
; ---------------------------------------------------------------------------

LBZ2BGE_Refresh:
		jsr	LBZ2_Deform(pc)

loc_3E8C6:
		moveq	#0,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		jsr	Draw_PlaneVertBottomUp(pc)
		bpl.s	loc_3E8E2
		addq.w	#4,(Events_routine_bg).w
		bra.s	loc_3E8E2
; ---------------------------------------------------------------------------

LBZ2BGE_Normal:
		tst.w	(Events_fg_5).w
		bne.s	loc_3E902		; Wait for flag
		jsr	LBZ2_Deform(pc)

loc_3E8E2:
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)
		lea	LBZ2_BGDeformArray(pc),a4
		lea	(HScroll_table).w,a5
		jsr	ApplyDeformation(pc)
		jmp	ShakeScreen_Setup(pc)
; ---------------------------------------------------------------------------

loc_3E902:
		clr.w	(Events_fg_5).w			; Oh boy, NOW the fun begins
		move.w	8(a3),(a3)
		move.w	$C(a3),4(a3)			; Modify the background slightly
		move.w	#$4390,d0
		move.w	d0,(Camera_max_X_pos).w		; X-end is at $4390
		move.w	d0,(Camera_target_max_X_pos).w
		move.w	#$668,d0
		move.w	d0,(Camera_max_Y_pos).w		; Y-end is $668
		move.w	d0,(Camera_target_max_Y_pos).w
		move.w	#$3C,(Events_bg+$0E).w
		move.w	#$1E00,(_unkEEA2).w
		move.l	#$6200,(_unkEE9C).w
		st	(Scroll_lock).w
		st	(Event_LBZ2_DeathEgg).w
		addq.w	#4,(Events_routine_bg).w

LBZ2BGE_DeathEgg:
		tst.w	(Event_LBZ2_DeathEgg).w
		beq.s	loc_3E96E
		tst.w	(Screen_shake_flag).w
		bne.s	loc_3E95A			; Branch if shaking
		clr.w	(Event_LBZ2_DeathEgg).w
		bra.s	loc_3E96E
; ---------------------------------------------------------------------------

loc_3E95A:
		move.w	(Level_frame_counter).w,d0
		subq.w	#1,d0
		andi.w	#$F,d0
		bne.s	loc_3E96E
		moveq	#signextendB(sfx_DeathEggRiseLoud),d0			; Play Death Egg rumbling sound
		jsr	(Play_SFX).l

loc_3E96E:
		tst.w	(Events_fg_5).w
		beq.w	loc_3EA1C
		jsr	LBZ2_EndFallingAccel(pc)	; When signalled, start the falling of the death egg platform
		tst.w	(_unkEE9C).w
		bpl.w	loc_3EA1C
		clr.w	(Events_fg_5).w			; When movement starts going negative
		move.w	#$1B,(Draw_delayed_rowcount).w
		move.w	#$10,(Special_V_int_routine).w		; Do the first window copy
		addq.w	#4,(Events_routine_bg).w
		bra.w	loc_3EA1C
; ---------------------------------------------------------------------------

LBZ2BGE_PlatformDetach:
		tst.w	(Special_V_int_routine).w
		bne.s	sub_3EA18			; Wait for window copy to finish
		move.w	(Level_frame_counter).w,d0
		andi.w	#3,d0
		bne.s	loc_3E9E6
		move.w	(Events_bg+$16).w,d0	; Only ever four frames
		cmpi.w	#$28,d0
		blo.s	loc_3E9E0
		clr.w	(Events_bg+$16).w		; When scroll A has scrolled off screen
		move.w	#$18,(Special_V_int_routine).w	; Use the next Special VInt function to restore the entire platform
		movea.w	$2A(a3),a1
		lea	$87(a1),a1
		clr.b	(a1)
		clr.b	1(a1)
		clr.b	2(a1)				; Furthermore, clear the entire level layout at $580 Y, $4380 X (3 chunks long, 2 chunks high)
		adda.w	-$A(a3),a1
		clr.b	(a1)+
		clr.b	(a1)+
		clr.b	(a1)				; This is for when the platform scrolls off screen at the end
		addq.w	#4,(Events_routine_bg).w
		bra.s	LBZ2BGE_Falling
; ---------------------------------------------------------------------------

loc_3E9E0:
		addq.w	#1,d0
		move.w	d0,(Events_bg+$16).w	; Increment value

loc_3E9E6:
		bsr.s	sub_3EA18
		move.w	(Camera_Y_pos_copy).w,(V_scroll_value).w
		move.w	(Camera_Y_pos_BG_copy).w,(V_scroll_value_BG).w
		move.w	(Events_bg+$16).w,d0
		add.w	d0,(V_scroll_value).w	; Actual vertical scroll is modified by EEE8.
		addq.w	#4,sp
		rts
; ---------------------------------------------------------------------------

LBZ2BGE_Falling:
		cmpi.w	#$260,(Camera_Y_pos_BG_copy).w
		bcs.s	sub_3EA18		; Continue Death Egg deformation until signal
		st	(Scroll_lock).w		; Set flag so that camera doesn't follow Sonic
		move.w	(Camera_Y_pos).w,(Camera_Y_pos_copy).w		; Scroll screen upwards
		subq.w	#2,(Camera_Y_pos).w
		rts

; =============== S U B R O U T I N E =======================================


sub_3EA18:
		jsr	LBZ2_EndFallingAccel(pc)

loc_3EA1C:
		jsr	LBZ2_DeathEggMoveScreen(pc)
		jsr	LBZ2_DeathEggDeform(pc)
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)
		lea	LBZ2_DEBGDeformArray(pc),a4
		lea	(HScroll_table).w,a5
		jsr	ApplyDeformation(pc)
		jmp	ShakeScreen_Setup(pc)
; End of function sub_3EA18


; =============== S U B R O U T I N E =======================================


LBZ2_Deform:
		move.w	(Camera_Y_pos_copy).w,d0			; Oh hey, it's more waterline fun, wasn't this just so interesting the first timeno
		move.w	(Screen_shake_offset).w,d3
		sub.w	d3,d0
		subi.w	#$5F0,d0
		move.w	d0,d1
		swap	d0
		clr.w	d0
		asr.l	#1,d0
		move.l	d0,d2
		asr.l	#3,d2
		sub.l	d2,d0
		asr.l	#2,d2
		sub.l	d2,d0
		swap	d0
		move.w	d0,d2
		addi.w	#$2C0,d0
		add.w	d3,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w			; Calculate effective Y position
		sub.w	d1,d2
		move.w	d2,(Events_bg+$10).w			; Water line equilibrium point
		move.w	(Camera_X_pos_copy).w,d0
		swap	d0
		clr.w	d0
		tst.w	d2
		beq.w	loc_3EB36					; Equilibrium skips ahead
		move.l	d0,d1
		move.l	d0,d3
		asr.l	#6,d3
		move.l	d3,d4
		asr.l	#3,d4
		sub.l	d4,d3
		moveq	#$20-1,d4
		cmpi.w	#-$40,d2
		bgt.s	loc_3EAB6
		lea	(HScroll_table+$01E).w,a1	; Above water, no art reloading needed

loc_3EA9E:
		swap	d1
		move.w	d1,(a1)+
		swap	d1
		sub.l	d3,d1
		swap	d1
		move.w	d1,(a1)+
		swap	d1
		sub.l	d3,d1
		dbf	d4,loc_3EA9E
		bra.w	loc_3EB36
; ---------------------------------------------------------------------------

loc_3EAB6:
		lea	(HScroll_table+$11E).w,a1	; Below water

loc_3EABA:
		swap	d1
		move.w	d1,-(a1)
		swap	d1
		sub.l	d3,d1
		swap	d1
		move.w	d1,-(a1)
		swap	d1
		sub.l	d3,d1
		dbf	d4,loc_3EABA
		cmpi.w	#$40,d2
		bge.s	loc_3EB36		; No art reloading needed if out of range
		lea	(HScroll_table+$09E).w,a1
		lea	(a1),a5
		lea	(LBZ_WaterlineScroll_Data).l,a6
		move.w	d2,d1
		bmi.s	loc_3EB0E
		move.w	d1,d3			; Below water
		neg.w	d3
		addi.w	#$40,d3
		lsl.w	#6,d3
		adda.w	d3,a6
		subq.w	#1,d1
		moveq	#0,d3
		lsr.w	#1,d1
		bcc.s	loc_3EB00

loc_3EAF8:
		move.b	(a6)+,d3
		add.w	d3,d3
		move.w	(a5,d3.w),(a1)+

loc_3EB00:
		move.b	(a6)+,d3
		add.w	d3,d3
		move.w	(a5,d3.w),(a1)+
		dbf	d1,loc_3EAF8
		bra.s	loc_3EB36
; ---------------------------------------------------------------------------

loc_3EB0E:
		move.w	d1,d3			; Above water
		addi.w	#$40,d3
		lsl.w	#6,d3
		adda.w	d3,a6
		neg.w	d1
		subq.w	#1,d1
		moveq	#0,d3
		lsr.w	#1,d1
		bcc.s	loc_3EB2A

loc_3EB22:
		move.b	(a6)+,d3
		add.w	d3,d3
		move.w	(a5,d3.w),-(a1)

loc_3EB2A:
		move.b	(a6)+,d3
		add.w	d3,d3
		move.w	(a5,d3.w),-(a1)
		dbf	d1,loc_3EB22

loc_3EB36:
		lea	(HScroll_table+$1E2).w,a1			; Below the water area moving up (from Knuckles area of course)
		move.l	d0,d1
		asr.l	#1,d1
		move.l	d1,d3
		asr.l	#3,d3
		swap	d1
		move.w	d1,(Camera_X_pos_BG_copy).w		; Effective X
		move.w	d1,-(a1)
		swap	d1
		sub.l	d3,d1
		swap	d1
		move.w	d1,(Events_bg+$12).w		; Art reloading for the bricks in Knuckles' area
		move.w	d1,-(a1)
		swap	d1
		lea	LBZ2_BGUWDeformRange(pc),a5	; This is an array of counters used for deformation sizes underwater.
		sub.l	d3,d1					; Likely because the underwater wavy effect neccesitates specifying deformation line-by-line
		moveq	#4,d4

loc_3EB60:
		sub.l	d3,d1
		swap	d1
		move.w	(a5)+,d5

loc_3EB66:
		move.w	d1,-(a1)
		move.w	d1,-(a1)
		move.w	d1,-(a1)
		move.w	d1,-(a1)
		dbf	d5,loc_3EB66
		swap	d1
		dbf	d4,loc_3EB60
		moveq	#$40-1,d3
		tst.w	d2
		bmi.s	loc_3EB82
		sub.w	d2,d3					; Only perform as much addition line-by-line deformation as needed
		bcs.s	loc_3EB90

loc_3EB82:
		swap	d1
		lsr.w	#1,d3
		bcc.s	loc_3EB8A

loc_3EB88:
		move.w	d1,-(a1)

loc_3EB8A:
		move.w	d1,-(a1)
		dbf	d3,loc_3EB88

loc_3EB90:
		lea	(HScroll_table).w,a1			; With that overwith, we can actually do some normal stuff
		lea	LBZ2_CloudDeformArray(pc),a5
		move.l	d0,d1
		asr.l	#6,d1
		move.l	d1,d3
		move.l	(HScroll_table+$1E2).w,d4
		addi.l	#$E00,(HScroll_table+$1E2).w		; Move clouds
		moveq	#$D-1,d5

loc_3EBAC:
		move.w	(a5)+,d6
		add.l	d4,d1
		swap	d1
		move.w	d1,(a1,d6.w)
		swap	d1
		add.l	d3,d1
		dbf	d5,loc_3EBAC
		move.l	d0,d1			; And now just do the rest of the deformation
		asr.l	#4,d1
		move.l	d1,d3
		asr.l	#1,d3
		lea	(HScroll_table+$01A).w,a1
		swap	d1
		move.w	d1,(a1)+
		swap	d1
		add.l	d3,d1
		swap	d1
		move.w	d1,(a1)+
		tst.w	d2
		bpl.s	loc_3EBEC		; If below water, just do the full deformation
		moveq	#$40-1,d4
		add.w	d2,d4
		bmi.s	loc_3EC0A		; If above water far enough that entire waterline shows, skip ahead
		cmpi.w	#$30,d4
		blo.s	loc_3EBFE
		subi.w	#$30,d4
		bra.s	loc_3EBEE
; ---------------------------------------------------------------------------

loc_3EBEC:
		moveq	#$10-1,d4

loc_3EBEE:
		moveq	#$18-1,d5

loc_3EBF0:
		move.w	d1,(a1)+		; First $30 pixels have their own deformation
		move.w	d1,(a1)+
		dbf	d5,loc_3EBF0
		swap	d1
		add.l	d3,d1
		swap	d1

loc_3EBFE:
		lsr.w	#1,d4			; As do the last $10 pixels
		bcc.s	loc_3EC04

loc_3EC02:
		move.w	d1,(a1)+

loc_3EC04:
		move.w	d1,(a1)+
		dbf	d4,loc_3EC02

loc_3EC0A:
		moveq	#$3F,d0			; And yet, there's more, cause we now have the wavy effects to go!
		sub.w	d2,d0
		bmi.s	locret_3EC42	; If high enough, no waviness needed
		addi.w	#$60,d0			; Otherwise, keep it up
		cmpi.w	#$E0,d0
		blo.s	loc_3EC1E
		move.w	#$E0-1,d0

loc_3EC1E:
		lea	(HScroll_table+$1DE).w,a1
		lea	LBZ_WaterWaveArray(pc),a5	; Water wave array
		move.w	(Level_frame_counter).w,d1
		asr.w	#1,d1
		andi.w	#$7E,d1
		adda.w	d1,a5
		lsr.w	#1,d0
		bcc.s	loc_3EC3A

loc_3EC36:
		move.w	-(a5),d3
		add.w	d3,-(a1)

loc_3EC3A:
		move.w	-(a5),d3
		add.w	d3,-(a1)
		dbf	d0,loc_3EC36

locret_3EC42:
		rts
; End of function LBZ2_Deform


; =============== S U B R O U T I N E =======================================


LBZ2_DeathEggDeform:
		move.w	(Camera_Y_pos_copy).w,d0		; Oh no, I'm not commenting all of this again.
		move.w	(Screen_shake_offset).w,d3
		sub.w	d3,d0
		subi.w	#$5F0,d0
		sub.w	(Events_bg+$02).w,d0
		sub.w	(Events_bg+$06).w,d0
		move.w	d0,d1
		swap	d0
		clr.w	d0
		asr.l	#1,d0
		move.l	d0,d2
		asr.l	#3,d2
		sub.l	d2,d0
		asr.l	#2,d2
		sub.l	d2,d0
		swap	d0
		move.w	d0,d2
		addi.w	#$2C0,d0
		add.w	d3,d0
		bpl.s	loc_3EC90
		moveq	#0,d3
		move.w	d0,d4

loc_3EC7C:
		addi.w	#$100,d3
		addi.w	#$100,d4
		bmi.s	loc_3EC7C
		cmp.w	(_unkEEA0).w,d3
		blo.s	loc_3EC90
		move.w	d3,(_unkEEA0).w

loc_3EC90:
		add.w	(_unkEEA0).w,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		tst.w	(_unkEEA0).w
		beq.s	loc_3ECAE

loc_3EC9E:
		cmpi.w	#$100,d0
		blo.s	loc_3ECAA
		subi.w	#$100,d0
		bra.s	loc_3EC9E
; ---------------------------------------------------------------------------

loc_3ECAA:
		move.w	d0,(Camera_Y_pos_BG_copy).w

loc_3ECAE:
		tst.w	(_unkEE9C).w
		bmi.s	loc_3ECB8
		sub.w	d1,d2
		bpl.s	loc_3ECBC

loc_3ECB8:
		move.w	#$7FFF,d2

loc_3ECBC:
		move.w	d2,(Events_bg+$10).w
		move.w	(Camera_X_pos_copy).w,d0
		swap	d0
		clr.w	d0
		move.l	d0,d1
		move.l	d0,d3
		asr.l	#6,d3
		move.l	d3,d4
		asr.l	#3,d4
		sub.l	d4,d3
		moveq	#$20-1,d4
		lea	(HScroll_table+$0AC).w,a1

loc_3ECDA:
		swap	d1
		move.w	d1,-(a1)
		swap	d1
		sub.l	d3,d1
		swap	d1
		move.w	d1,-(a1)
		swap	d1
		sub.l	d3,d1
		dbf	d4,loc_3ECDA
		cmpi.w	#$40,d2
		bge.s	loc_3ED2A
		lea	(HScroll_table+$02C).w,a1
		lea	(a1),a5
		lea	(LBZ_WaterlineScroll_Data).l,a6
		move.w	d2,d1
		move.w	d1,d3
		neg.w	d3
		addi.w	#$40,d3
		lsl.w	#6,d3
		adda.w	d3,a6
		subq.w	#1,d1
		moveq	#0,d3
		lsr.w	#1,d1
		bcc.s	loc_3ED1E

loc_3ED16:
		move.b	(a6)+,d3
		add.w	d3,d3
		move.w	(a5,d3.w),(a1)+

loc_3ED1E:
		move.b	(a6)+,d3
		add.w	d3,d3
		move.w	(a5,d3.w),(a1)+
		dbf	d1,loc_3ED16

loc_3ED2A:
		lea	(HScroll_table+$0EC).w,a1
		move.l	d0,d1
		asr.l	#1,d1
		move.l	d1,d3
		asr.l	#3,d3
		moveq	#7-1,d4

loc_3ED38:
		sub.l	d3,d1
		dbf	d4,loc_3ED38
		moveq	#$60-1,d3
		sub.w	d2,d3
		bcs.s	loc_3ED52
		swap	d1
		lsr.w	#1,d3
		bcc.s	loc_3ED4C

loc_3ED4A:
		move.w	d1,-(a1)

loc_3ED4C:
		move.w	d1,-(a1)
		dbf	d3,loc_3ED4A

loc_3ED52:
		lea	(HScroll_table+$00C).w,a1
		lea	LBZ2_CloudDeformArray(pc),a5
		move.l	d0,d1
		asr.l	#6,d1
		move.l	d1,d3
		move.l	(HScroll_table+$1E2).w,d4
		addi.l	#$E00,(HScroll_table+$1E2).w
		moveq	#$D-1,d5

loc_3ED6E:
		move.w	(a5)+,d6
		add.l	d4,d1
		swap	d1
		move.w	d1,(a1,d6.w)
		swap	d1
		add.l	d3,d1
		dbf	d5,loc_3ED6E
		lea	(HScroll_table+$010).w,a1
		lea	(HScroll_table).w,a5
		moveq	#4-1,d1

loc_3ED8A:
		move.l	(a1)+,(a5)+
		dbf	d1,loc_3ED8A
		move.l	d0,d1
		asr.l	#4,d1
		move.l	d1,d3
		asr.l	#1,d3
		lea	(HScroll_table+$026).w,a1
		swap	d1
		move.w	d1,(a1)+
		swap	d1
		add.l	d3,d1
		swap	d1
		move.w	d1,(a1)+
		swap	d1
		add.l	d3,d1
		swap	d1
		move.w	d1,(a1)+
		moveq	#$40-1,d0
		sub.w	d2,d0
		addi.w	#$20,d0
		cmpi.w	#$60,d0
		blo.s	loc_3EDC2
		move.w	#$60-1,d0

loc_3EDC2:
		lea	(HScroll_table+$0EC).w,a1
		lea	LBZ_WaterWaveArray2(pc),a5
		move.w	(Level_frame_counter).w,d1
		asr.w	#1,d1
		andi.w	#$7E,d1
		adda.w	d1,a5
		lsr.w	#1,d0
		bcc.s	loc_3EDDE

loc_3EDDA:
		move.w	-(a5),d3
		add.w	d3,-(a1)

loc_3EDDE:
		move.w	-(a5),d3
		add.w	d3,-(a1)
		dbf	d0,loc_3EDDA
		rts
; End of function LBZ2_DeathEggDeform


; =============== S U B R O U T I N E =======================================


LBZ2_DeathEggMoveScreen:
		cmpi.b	#6,(Player_1+routine).w
		bhs.w	locret_3EEBC		; If dying, don't bother
		tst.b	(Scroll_lock).w
		beq.s	loc_3EE1E			; Skip if flag turned off
		move.w	(Player_1+x_pos).w,d0
		sub.w	(Camera_X_pos).w,d0
		subi.w	#$A0,d0
		bcs.s	loc_3EE0A
		add.w	d0,(Camera_X_pos).w	; Move screen along with player in Robotnik ship

loc_3EE0A:
		cmpi.w	#$4390,(Camera_X_pos).w
		bhs.s	loc_3EE1A
		cmpi.w	#$668,(Camera_Y_pos).w
		blo.s	loc_3EE1E

loc_3EE1A:
		clr.b	(Scroll_lock).w		; Stop movement when screen edge is reached

loc_3EE1E:
		tst.w	(Events_bg+$0E).w
		beq.s	loc_3EE2C
		subq.w	#1,(Events_bg+$0E).w
		bra.w	locret_3EEBC
; ---------------------------------------------------------------------------

loc_3EE2C:
		cmpi.w	#$4390,(Camera_X_pos).w
		blo.s	loc_3EE40
		move.w	(Camera_max_X_pos).w,d0
		move.w	d0,(Camera_min_X_pos).w
		move.w	d0,(Camera_target_min_X_pos).w

loc_3EE40:
		cmpi.w	#$668,(Camera_Y_pos).w
		blo.s	loc_3EE54
		move.w	(Camera_max_Y_pos).w,d0
		move.w	d0,(Camera_min_Y_pos).w		; Lock screen when edges are reached
		move.w	d0,(Camera_target_min_Y_pos).w

loc_3EE54:
		lea	(Events_bg+$02).w,a1
		moveq	#0,d1
		move.w	(_unkEEA2).w,d1		; Speed of Death Egg movement
		add.l	d1,(a1)
		move.w	(a1),d0
		move.w	d0,d1
		sub.w	8(a1),d0
		move.w	d1,8(a1)
		move.w	#$2200,d1
		tst.b	(Scroll_lock).w
		bne.s	loc_3EE7A
		move.l	(_unkEE9C).w,d1		; Get BG movement speed if edge of screen is reached

loc_3EE7A:
		add.l	d1,4(a1)
		move.w	4(a1),d1
		move.w	d1,d2
		sub.w	$A(a1),d1
		move.w	d2,$A(a1)
		tst.b	(Scroll_lock).w
		beq.s	loc_3EE9E
		movea.w	(Events_bg+$00).w,a5	; If movement is still going
		add.w	d0,$14(a5)			; Add Y movement to screen and Robotnik ship
		add.w	d0,(Camera_Y_pos).w

loc_3EE9E:
		move.w	(Target_water_level).w,d2
		add.w	d0,d2
		add.w	d1,d2
		cmpi.w	#$F00,d2
		blo.s	loc_3EEB0
		move.w	#$F80,d2

loc_3EEB0:
		move.w	d2,(Target_water_level).w
		move.w	d0,(Events_bg+$14).w
		add.w	d1,(Events_bg+$14).w

locret_3EEBC:
		rts
; End of function LBZ2_DeathEggMoveScreen


; =============== S U B R O U T I N E =======================================


LBZ2_EndFallingAccel:
		tst.w	(_unkEEA2).w
		beq.s	loc_3EECC
		subi.w	#$100,(_unkEEA2).w
		bra.s	locret_3EEDE
; ---------------------------------------------------------------------------

loc_3EECC:
		cmpi.l	#$FFFE8000,(_unkEE9C).w
		ble.s	locret_3EEDE
		subi.l	#$100,(_unkEE9C).w

locret_3EEDE:
		rts
; End of function LBZ2_EndFallingAccel

; ---------------------------------------------------------------------------
LBZ2_BGDeformArray:
		dc.w    $C0,   $40,   $38,   $18,   $28,   $10,   $10,   $10,   $18
		dc.w    $40,   $20,   $10,   $20,   $70,   $30, $80E0,   $20, $7FFF
LBZ2_DEBGDeformArray:
		dc.w    $38,   $18,   $28,   $10,   $10,   $10,   $18,   $40,   $38,   $18,   $28,   $10
		dc.w    $10,   $10,   $18,   $40,   $20,   $10,   $20,   $70,   $60,   $10, $805F, $7FFF
LBZ2_CloudDeformArray:
		dc.w    $16,  $E,  $A, $14,  $C,   6, $18, $10, $12,   2,   8,   4,   0
LBZ2_BGUWDeformRange:
		dc.w      7,   1,   3,   1,   7
; ---------------------------------------------------------------------------

Gumball_ScreenInit:
		move.w	#$3FF,(Screen_Y_wrap_value).w
		move.w	#$3F0,(Camera_Y_pos_mask).w
		move.w	#$1C,(Layout_row_index_mask).w
		move.w	#4,(Special_V_int_routine).w
		move.w	#$C0,d0
		move.w	d0,d1
		jsr	Gumball_VScroll(pc)
		jsr	Reset_TileOffsetPositionActual(pc)
		move.w	d2,(HScroll_table+$002).w
		move.w	d2,(HScroll_table+$00A).w
		move.w	(HScroll_table+$00E).w,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(HScroll_table+$006).w
		lea	Gumball_VScrollArray(pc),a4
		lea	(HScroll_table).w,a5
		move.w	(Camera_X_pos_rounded).w,d0
		jmp	Refresh_PlaneDirectVScroll(pc)
; ---------------------------------------------------------------------------

Gumball_ScreenEvent:
		jsr	Gumball_SetUpVScroll(pc)
		lea	Gumball_VScrollArray(pc),a4
		lea	(HScroll_table).w,a5
		moveq	#$F,d6
		moveq	#3,d5
		jmp	DrawTilesVDeform(pc)

; =============== S U B R O U T I N E =======================================


Gumball_SetUpVScroll:
		move.w	(Camera_Y_pos_copy).w,d0
		movea.w	(_unkFAA4).w,a5
		move.w	$14(a5),d1
		subi.w	#$C8,d1
		sub.w	d0,d1
		neg.w	d1

Gumball_VScroll:
		lea	(HScroll_table).w,a1
		move.w	d0,(a1)
		move.w	d0,8(a1)
		move.w	d0,$C(a1)
		move.w	d0,$10(a1)
		move.w	d1,4(a1)
		move.w	d1,$E(a1)
		rts
; End of function Gumball_SetUpVScroll

; ---------------------------------------------------------------------------
Gumball_VScrollArray:
		dc.w $C0, $80, $7FFF
; ---------------------------------------------------------------------------

Gumball_BackgroundInit:
		jsr	Gumball_Deform(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		moveq	#0,d1
		jsr	Refresh_PlaneFull(pc)
		jmp	PlainDeformation(pc)
; ---------------------------------------------------------------------------

Gumball_BackgroundEvent:
		jsr	Gumball_Deform(pc)
		jsr	PlainDeformation(pc)
		lea	Gumball_VScrollArray(pc),a4
		lea	(HScroll_table+$00A).w,a5
		jmp	Apply_FGVScroll(pc)

; =============== S U B R O U T I N E =======================================


Gumball_Deform:
		move.w	#$FFE0,(Camera_X_pos_BG_copy).w
		move.w	(Camera_Y_pos_copy).w,d0
		asr.w	#1,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		asr.w	#1,d0
		move.w	d0,(Events_bg+$10).w
		rts
; End of function Gumball_Deform

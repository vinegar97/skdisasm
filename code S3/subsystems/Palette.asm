AnPal_Load:
		bsr.w	SuperSonic_PalCycle
		moveq	#0,d2
		moveq	#0,d0
		move.w	(Current_zone_and_act).w,d0
		ror.b	#1,d0
		lsr.w	#6,d0
		move.w	OffsAnPal(pc,d0.w),d0
		jmp	OffsAnPal(pc,d0.w)
; ---------------------------------------------------------------------------
		rts
; ---------------------------------------------------------------------------
OffsAnPal:
		dc.w AnPal_AIZ1-OffsAnPal
		dc.w AnPal_AIZ2-OffsAnPal
		dc.w AnPal_HCZ1-OffsAnPal
		dc.w AnPal_HCZ2-OffsAnPal
		dc.w AnPal_None-OffsAnPal
		dc.w AnPal_None-OffsAnPal
		dc.w AnPal_CNZ-OffsAnPal
		dc.w AnPal_CNZ-OffsAnPal
		dc.w AnPal_FBZ-OffsAnPal
		dc.w AnPal_FBZ-OffsAnPal
		dc.w AnPal_ICZ-OffsAnPal
		dc.w AnPal_ICZ-OffsAnPal
		dc.w AnPal_LBZ1-OffsAnPal
		dc.w AnPal_LBZ2-OffsAnPal
		dc.w AnPal_None-OffsAnPal
		dc.w AnPal_None-OffsAnPal
		dc.w AnPal_None-OffsAnPal
		dc.w AnPal_None-OffsAnPal
		dc.w AnPal_LRZ1-OffsAnPal
		dc.w AnPal_LRZ2-OffsAnPal
		dc.w AnPal_None-OffsAnPal
		dc.w AnPal_None-OffsAnPal
		dc.w AnPal_None-OffsAnPal
		dc.w AnPal_None-OffsAnPal
		dc.w AnPal_None-OffsAnPal
		dc.w AnPal_None-OffsAnPal
		dc.w AnPal_None-OffsAnPal
		dc.w AnPal_None-OffsAnPal
		dc.w AnPal_None-OffsAnPal
		dc.w AnPal_None-OffsAnPal
		dc.w AnPal_BPZ-OffsAnPal
		dc.w AnPal_BPZ-OffsAnPal
		dc.w AnPal_None-OffsAnPal
		dc.w AnPal_None-OffsAnPal
		dc.w AnPal_CGZ-OffsAnPal
		dc.w AnPal_CGZ-OffsAnPal
		dc.w AnPal_EMZ-OffsAnPal
		dc.w AnPal_EMZ-OffsAnPal
		dc.w AnPal_None-OffsAnPal
		dc.w AnPal_None-OffsAnPal
		dc.w AnPal_None-OffsAnPal
		dc.w AnPal_None-OffsAnPal
		dc.w AnPal_None-OffsAnPal
		dc.w AnPal_None-OffsAnPal
		dc.w AnPal_None-OffsAnPal
		dc.w AnPal_None-OffsAnPal
		dc.w AnPal_None-OffsAnPal
		dc.w AnPal_None-OffsAnPal
; ---------------------------------------------------------------------------

AnPal_None:
		rts
; ---------------------------------------------------------------------------

AnPal_AIZ1:
		move.b	(AIZ1_palette_cycle_flag).w,d0
		bne.s	loc_24A6
		subq.w	#1,(Palette_cycle_counter1).w
		bpl.s	locret_24A4
		move.w	#7,(Palette_cycle_counter1).w
		move.w	(Palette_cycle_counter0).w,d0
		addq.w	#8,(Palette_cycle_counter0).w
		andi.w	#$18,d0
		lea	(AnPal_PalAIZ1_1).l,a0
		move.l	(a0,d0.w),(Normal_palette_line_3+$16).w
		move.l	4(a0,d0.w),(Normal_palette_line_3+$1A).w
		tst.b	(Palette_cycle_counters+$00).w
		bne.s	locret_24A4
		move.w	(Palette_cycle_counters+$02).w,d0
		addq.w	#6,(Palette_cycle_counters+$02).w
		cmpi.w	#$30,(Palette_cycle_counters+$02).w
		blo.s	loc_2492
		move.w	#0,(Palette_cycle_counters+$02).w

loc_2492:
		lea	(AnPal_PalAIZ1_2).l,a0
		move.l	(a0,d0.w),(Normal_palette_line_4+$18).w
		move.w	4(a0,d0.w),(Normal_palette_line_4+$1C).w

locret_24A4:
		rts
; ---------------------------------------------------------------------------

loc_24A6:
		subq.w	#1,(Palette_cycle_counter1).w
		bpl.s	locret_2502
		move.w	#9,(Palette_cycle_counter1).w
		move.w	(Palette_cycle_counter0).w,d0
		addq.w	#8,(Palette_cycle_counter0).w
		cmpi.w	#$50,(Palette_cycle_counter0).w
		blo.s	loc_24C8
		move.w	#0,(Palette_cycle_counter0).w

loc_24C8:
		lea	(AnPal_PalAIZ1_3).l,a0
		move.l	(a0,d0.w),(Normal_palette_line_4+$04).w
		move.l	4(a0,d0.w),(Normal_palette_line_4+$08).w
		move.w	(Palette_cycle_counters+$02).w,d0
		addq.w	#6,(Palette_cycle_counters+$02).w
		cmpi.w	#$3C,(Palette_cycle_counters+$02).w
		blo.s	loc_24F0
		move.w	#0,(Palette_cycle_counters+$02).w

loc_24F0:
		lea	(AnPal_PalAIZ1_4).l,a0
		move.l	(a0,d0.w),(Normal_palette_line_4+$1A).w
		move.w	4(a0,d0.w),(Normal_palette_line_4+$1E).w

locret_2502:
		rts
; ---------------------------------------------------------------------------

AnPal_AIZ2:
		subq.w	#1,(Palette_cycle_counter1).w
		bpl.s	loc_257E
		move.w	#5,(Palette_cycle_counter1).w
		move.w	(Palette_cycle_counter0).w,d0
		addq.w	#8,(Palette_cycle_counter0).w
		andi.w	#$18,d0
		lea	(AnPal_PalAIZ2_1).l,a0
		move.l	(a0,d0.w),(Normal_palette_line_4+$18).w
		move.l	4(a0,d0.w),(Normal_palette_line_4+$1C).w
		move.w	(Palette_cycle_counters+$02).w,d0
		addq.w	#6,(Palette_cycle_counters+$02).w
		cmpi.w	#$30,(Palette_cycle_counters+$02).w
		blo.s	loc_2544
		move.w	#0,(Palette_cycle_counters+$02).w

loc_2544:
		lea	(AnPal_PalAIZ2_2).l,a0
		cmpi.w	#$3800,(Camera_X_pos).w
		blo.s	loc_2558
		lea	(AnPal_PalAIZ2_3).l,a0

loc_2558:
		move.w	(a0,d0.w),(Normal_palette_line_3+$08).w
		move.w	2(a0,d0.w),(Normal_palette_line_3+$10).w
		move.w	4(a0,d0.w),(Normal_palette_line_4+$16).w
		move.w	#$A0E,(Normal_palette_line_3+$1C).w
		cmpi.w	#$1C0,(Camera_X_pos).w
		bhs.s	loc_257E
		move.w	4(a0,d0.w),(Normal_palette_line_3+$1C).w

loc_257E:
		subq.w	#1,(Palette_cycle_counters+$08).w
		bpl.s	locret_25BA
		move.w	#1,(Palette_cycle_counters+$08).w
		move.w	(Palette_cycle_counters+$04).w,d0
		addq.w	#2,(Palette_cycle_counters+$04).w
		cmpi.w	#$34,(Palette_cycle_counters+$04).w
		blo.s	loc_25A0
		move.w	#0,(Palette_cycle_counters+$04).w

loc_25A0:
		lea	(AnPal_PalAIZ2_4).l,a0
		cmpi.w	#$3800,(Camera_X_pos).w
		blo.s	loc_25B4
		lea	(AnPal_PalAIZ2_5).l,a0

loc_25B4:
		move.w	(a0,d0.w),(Normal_palette_line_4+$02).w

locret_25BA:
		rts

; =============== S U B R O U T I N E =======================================


AnPal_HCZ1:
		subq.w	#1,(Palette_cycle_counter1).w
		bpl.s	locret_2608
		move.w	#7,(Palette_cycle_counter1).w
		tst.b	(Palette_cycle_counters+$00).w
		beq.s	loc_25D4
		move.w	#0,(Palette_cycle_counter1).w

loc_25D4:
		lea	(AnPal_PalHCZ1).l,a0
		move.w	(Palette_cycle_counter0).w,d0
		addq.w	#8,(Palette_cycle_counter0).w
		cmpi.w	#$20,(Palette_cycle_counter0).w
		blo.s	loc_25F0
		move.w	#0,(Palette_cycle_counter0).w

loc_25F0:
		move.l	(a0,d0.w),(Normal_palette_line_3+$06).w
		move.l	4(a0,d0.w),(Normal_palette_line_3+$0A).w
		move.l	(a0,d0.w),(Water_palette_line_3+$06).w
		move.l	4(a0,d0.w),(Water_palette_line_3+$0A).w

locret_2608:
		rts
; End of function AnPal_HCZ1

; ---------------------------------------------------------------------------

AnPal_HCZ2:
		rts
; ---------------------------------------------------------------------------

AnPal_CNZ:
		subq.w	#1,(Palette_cycle_counter1).w
		bpl.s	loc_2652
		move.w	#3,(Palette_cycle_counter1).w
		lea	(AnPal_PalCNZ_1).l,a0
		move.w	(Palette_cycle_counter0).w,d0
		addq.w	#6,(Palette_cycle_counter0).w
		cmpi.w	#$60,(Palette_cycle_counter0).w
		blo.s	loc_2634
		move.w	#0,(Palette_cycle_counter0).w

loc_2634:
		move.l	(a0,d0.w),(Normal_palette_line_4+$12).w
		move.w	4(a0,d0.w),(Normal_palette_line_4+$16).w
		lea	(AnPal_PalCNZ_2).l,a0
		move.l	(a0,d0.w),(Water_palette_line_4+$12).w
		move.w	4(a0,d0.w),(Water_palette_line_4+$16).w

loc_2652:
		lea	(AnPal_PalCNZ_3).l,a0
		move.w	(Palette_cycle_counters+$02).w,d0
		addq.w	#6,(Palette_cycle_counters+$02).w
		cmpi.w	#$B4,(Palette_cycle_counters+$02).w
		blo.s	loc_266E
		move.w	#0,(Palette_cycle_counters+$02).w

loc_266E:
		move.l	(a0,d0.w),(Normal_palette_line_3+$12).w
		move.w	4(a0,d0.w),(Normal_palette_line_3+$16).w
		lea	(AnPal_PalCNZ_4).l,a0
		move.l	(a0,d0.w),(Water_palette_line_3+$12).w
		move.w	4(a0,d0.w),(Water_palette_line_3+$16).w
		subq.w	#1,(Palette_cycle_counters+$08).w
		bpl.s	locret_26C6
		move.w	#2,(Palette_cycle_counters+$08).w
		lea	(AnPal_PalCNZ_5).l,a0
		move.w	(Palette_cycle_counters+$04).w,d0
		addq.w	#4,(Palette_cycle_counters+$04).w
		cmpi.w	#$40,(Palette_cycle_counters+$04).w
		blo.s	loc_26B4
		move.w	#0,(Palette_cycle_counters+$04).w

loc_26B4:
		move.l	(a0,d0.w),(Normal_palette_line_3+$E).w
		lea	(AnPal_PalCNZ_5).l,a0
		move.l	(a0,d0.w),(Water_palette_line_3+$E).w

locret_26C6:
		rts
; ---------------------------------------------------------------------------

AnPal_FBZ:
		rts
; ---------------------------------------------------------------------------

AnPal_ICZ:
		subq.w	#1,(Palette_cycle_counter1).w
		bpl.s	loc_26F8
		move.w	#5,(Palette_cycle_counter1).w
		lea	(AnPal_PalICZ_1).l,a0
		move.w	(Palette_cycle_counter0).w,d0
		addq.w	#4,(Palette_cycle_counter0).w
		cmpi.w	#$40,(Palette_cycle_counter0).w
		blo.s	loc_26F2
		move.w	#0,(Palette_cycle_counter0).w

loc_26F2:
		move.l	(a0,d0.w),(Normal_palette_line_3+$1C).w

loc_26F8:
		subq.w	#1,(Palette_cycle_counters+$08).w
		bpl.s	loc_272C
		move.w	#9,(Palette_cycle_counters+$08).w
		lea	(AnPal_PalICZ_2).l,a0
		move.w	(Palette_cycle_counters+$02).w,d0
		addq.w	#4,(Palette_cycle_counters+$02).w
		cmpi.w	#$48,(Palette_cycle_counters+$02).w
		blo.s	loc_2720
		move.w	#0,(Palette_cycle_counters+$02).w

loc_2720:
		tst.w	(Events_bg+$16).w
		beq.s	loc_272C
		move.l	(a0,d0.w),(Normal_palette_line_4+$1C).w

loc_272C:
		subq.w	#1,(Palette_cycle_counters+$0A).w
		bpl.s	locret_2782
		move.w	#7,(Palette_cycle_counters+$0A).w
		lea	(AnPal_PalICZ_3).l,a0
		move.w	(Palette_cycle_counters+$04).w,d0
		addq.w	#4,(Palette_cycle_counters+$04).w
		cmpi.w	#$18,(Palette_cycle_counters+$04).w
		blo.s	loc_2754
		move.w	#0,(Palette_cycle_counters+$04).w

loc_2754:
		tst.w	(Events_bg+$16).w
		beq.s	loc_2760
		move.l	(a0,d0.w),(Normal_palette_line_4+$18).w

loc_2760:
		lea	(AnPal_PalICZ_4).l,a0
		move.w	(Palette_cycle_counters+$06).w,d0
		addq.w	#4,(Palette_cycle_counters+$06).w
		cmpi.w	#$40,(Palette_cycle_counters+$06).w
		blo.s	loc_277C
		move.w	#0,(Palette_cycle_counters+$06).w

loc_277C:
		move.l	(a0,d0.w),(Normal_palette_line_3+$18).w

locret_2782:
		rts
; ---------------------------------------------------------------------------

AnPal_LBZ1:
		lea	(AnPal_PalLBZ1).l,a0
		bra.s	loc_2792
; ---------------------------------------------------------------------------

AnPal_LBZ2:
		lea	(AnPal_PalLBZ2).l,a0

loc_2792:
		subq.w	#1,(Palette_cycle_counter1).w
		bpl.s	locret_27C0
		move.w	#3,(Palette_cycle_counter1).w
		move.w	(Palette_cycle_counter0).w,d0
		addq.w	#6,(Palette_cycle_counter0).w
		cmpi.w	#$12,(Palette_cycle_counter0).w
		blo.s	loc_27B4
		move.w	#0,(Palette_cycle_counter0).w

loc_27B4:
		move.l	(a0,d0.w),(Normal_palette_line_3+$10).w
		move.w	4(a0,d0.w),(Normal_palette_line_3+$14).w

locret_27C0:
		rts
; ---------------------------------------------------------------------------

AnPal_LRZ1:
		subq.w	#1,(Palette_cycle_counter1).w
		bpl.s	locret_2818
		move.w	#$F,(Palette_cycle_counter1).w
		move.w	(Palette_cycle_counter0).w,d0
		addq.w	#8,(Palette_cycle_counter0).w
		cmpi.w	#$80,(Palette_cycle_counter0).w
		blo.s	loc_27E4
		move.w	#0,(Palette_cycle_counter0).w

loc_27E4:
		lea	(AnPal_PalLRZ1_1).l,a0
		move.l	(a0,d0.w),(Normal_palette_line_3+$02).w
		move.l	4(a0,d0.w),(Normal_palette_line_3+$06).w
		move.w	(Palette_cycle_counters+$02).w,d0
		addq.w	#4,(Palette_cycle_counters+$02).w
		cmpi.w	#$1C,(Palette_cycle_counters+$02).w
		blo.s	loc_280C
		move.w	#0,(Palette_cycle_counters+$02).w

loc_280C:
		lea	(AnPal_PalLRZ1_2).l,a0
		move.l	(a0,d0.w),(Normal_palette_line_4+$02).w

locret_2818:
		rts
; ---------------------------------------------------------------------------

AnPal_LRZ2:
		rts
; ---------------------------------------------------------------------------

AnPal_BPZ:
		subq.w	#1,(Palette_cycle_counter1).w
		bpl.s	loc_2850
		move.w	#7,(Palette_cycle_counter1).w
		lea	(AnPal_PalBPZ_1).l,a0
		move.w	(Palette_cycle_counter0).w,d0
		addq.w	#6,(Palette_cycle_counter0).w
		cmpi.w	#$12,(Palette_cycle_counter0).w
		blo.s	loc_2844
		move.w	#0,(Palette_cycle_counter0).w

loc_2844:
		move.l	(a0,d0.w),(Normal_palette_line_3+$1A).w
		move.w	4(a0,d0.w),(Normal_palette_line_3+$1E).w

loc_2850:
		subq.w	#1,(Palette_cycle_counters+$08).w
		bpl.s	locret_2884
		move.w	#$11,(Palette_cycle_counters+$08).w
		lea	(AnPal_PalBPZ_2).l,a0
		move.w	(Palette_cycle_counters+$02).w,d0
		addq.w	#6,(Palette_cycle_counters+$02).w
		cmpi.w	#$7E,(Palette_cycle_counters+$02).w
		blo.s	loc_2878
		move.w	#0,(Palette_cycle_counters+$02).w

loc_2878:
		move.l	(a0,d0.w),(Normal_palette_line_4+$04).w
		move.w	4(a0,d0.w),(Normal_palette_line_4+$08).w

locret_2884:
		rts
; ---------------------------------------------------------------------------

AnPal_CGZ:
		subq.w	#1,(Palette_cycle_counter1).w
		bpl.s	locret_28BA
		move.w	#9,(Palette_cycle_counter1).w
		lea	(AnPal_PalCGZ).l,a0
		move.w	(Palette_cycle_counter0).w,d0
		addq.w	#8,(Palette_cycle_counter0).w
		cmpi.w	#$50,(Palette_cycle_counter0).w
		blo.s	loc_28AE
		move.w	#0,(Palette_cycle_counter0).w

loc_28AE:
		move.l	(a0,d0.w),(Normal_palette_line_3+$04).w
		move.l	4(a0,d0.w),(Normal_palette_line_3+$08).w

locret_28BA:
		rts
; ---------------------------------------------------------------------------

AnPal_EMZ:
		subq.w	#1,(Palette_cycle_counter1).w
		bpl.s	loc_28EA
		move.w	#7,(Palette_cycle_counter1).w
		lea	(AnPal_PalEMZ_1).l,a0
		move.w	(Palette_cycle_counter0).w,d0
		addq.w	#2,(Palette_cycle_counter0).w
		cmpi.w	#$3C,(Palette_cycle_counter0).w
		blo.s	loc_28E4
		move.w	#0,(Palette_cycle_counter0).w

loc_28E4:
		move.w	4(a0,d0.w),(Normal_palette_line_3+$1C).w

loc_28EA:
		subq.w	#1,(Palette_cycle_counters+$08).w
		bpl.s	locret_2918
		move.w	#$1F,(Palette_cycle_counters+$08).w
		lea	(AnPal_PalEMZ_2).l,a0
		move.w	(Palette_cycle_counters+$02).w,d0
		addq.w	#4,(Palette_cycle_counters+$02).w
		cmpi.w	#$34,(Palette_cycle_counters+$02).w
		blo.s	loc_2912
		move.w	#0,(Palette_cycle_counters+$02).w

loc_2912:
		move.l	(a0,d0.w),(Normal_palette_line_4+$12).w

locret_2918:
		rts
; ---------------------------------------------------------------------------
AnPal_PalAIZ1_1:
		dc.w  $EE8, $EE2, $EA4, $E64
		dc.w  $EE2, $EA4, $E64, $EE8
		dc.w  $EA4, $E64, $EE8, $EE2
		dc.w  $E64, $EE8, $EE2, $EA4

AnPal_PalAIZ1_3:
		dc.w  $EEC, $EEE, $EE8, $E40
		dc.w  $EEC, $EE8, $EE8, $EEE
		dc.w  $EEA, $E86, $EE8, $EE8
		dc.w  $EE8, $E40, $EE8, $E86
		dc.w  $EE6, $EEE, $EE8, $E40
		dc.w  $EEA, $EE8, $EE8, $EEE
		dc.w  $EE8, $E86, $EE8, $EE8
		dc.w  $EE8, $E40, $EE8, $E86
		dc.w  $EE6, $EEE, $EE8, $E40
		dc.w  $EE8, $EE8, $EE8, $EEE
		dc.w  $EEA, $E86, $EE8, $EE8
		dc.w  $EEC, $E40, $EE8, $E86
		dc.w  $EEC, $EEE, $EE8, $E40
		dc.w  $EEC, $EE8, $EE8, $EEE
		dc.w  $EEC, $E86, $EE8, $EE8
		dc.w  $EEC, $E40, $EE8, $E86

AnPal_PalAIZ1_4:
		dc.w  $CEC, $CEE, $EEE
		dc.w  $CEE, $EEE, $EEE
		dc.w  $EEE, $EEE, $EEE
		dc.w  $EEE, $EEE, $EEE
		dc.w  $EEE, $EEE, $EEE
		dc.w  $EEE, $EEE, $EEE
		dc.w  $EEE, $EEE, $EEE
		dc.w  $EE8, $EEE, $EEE
		dc.w  $EE8, $EE8, $EEE
		dc.w  $EE8, $EE8, $EE8
		dc.w  $EE8, $EE8, $EE8
		dc.w  $EE8, $EE8, $EE8
		dc.w  $EE8, $EE8, $EE8
		dc.w  $EE8, $EE8, $AEC
		dc.w  $EE8, $AEC, $CEC
		dc.w  $AEC, $CEC, $CEC

AnPal_PalAIZ1_2:
		dc.w  $EA4, $E60, $EE2
		dc.w  $EA4, $EE8, $EA4
		dc.w  $E60, $EE8, $EEE
		dc.w  $E60, $EE2, $EE2
		dc.w  $EE8, $EA4, $EA4
		dc.w  $EE2, $E60, $E60
		dc.w  $EE2, $E60, $EEE
		dc.w  $EE2, $E60, $EE8

AnPal_PalAIZ2_1:
		dc.w  $EE8, $EE2, $EC4, $EA4
		dc.w  $EE2, $EC4, $EA4, $EE8
		dc.w  $EC4, $EA4, $EE8, $EE2
		dc.w  $EA4, $EE8, $EE2, $EC4

AnPal_PalAIZ2_2:
		dc.w   $24,  $44,  $8E
		dc.w   $26,  $46,  $AE
		dc.w   $24,  $48,  $8E
		dc.w   $26,  $4A,  $AE
		dc.w   $24,  $4C,  $8E
		dc.w   $26,  $4A,  $AE
		dc.w   $24,  $48,  $8E
		dc.w   $24,  $46,  $8E

AnPal_PalAIZ2_3:
		dc.w   $24,  $44,   $C
		dc.w   $26,  $46,   $E
		dc.w   $24,  $48,   $C
		dc.w   $26,  $4A,   $E
		dc.w   $24,  $4C,   $C
		dc.w   $26,  $4A,   $E
		dc.w   $24,  $48,   $C
		dc.w   $24,  $46,   $C

AnPal_PalAIZ2_4:
		dc.w   $6E
		dc.w   $6E
		dc.w   $6E
		dc.w   $6E
		dc.w  $28E
		dc.w  $4AE
		dc.w  $6AE
		dc.w  $8CE
		dc.w  $8EE
		dc.w  $AEE
		dc.w  $AEE
		dc.w  $AEE
		dc.w  $AEE
		dc.w  $AEE
		dc.w  $8EE
		dc.w  $8EE
		dc.w  $8EE
		dc.w  $8EE
		dc.w  $8CE
		dc.w  $8CE
		dc.w  $8CE
		dc.w  $6AE
		dc.w  $6AE
		dc.w  $4AE
		dc.w  $4AE
		dc.w  $28E

AnPal_PalAIZ2_5:
		dc.w    $C
		dc.w    $C
		dc.w    $C
		dc.w    $C
		dc.w   $2C
		dc.w    $E
		dc.w   $2E
		dc.w   $4E
		dc.w   $6E
		dc.w   $8E
		dc.w   $8E
		dc.w   $8E
		dc.w   $8E
		dc.w   $8E
		dc.w   $6E
		dc.w   $4E
		dc.w   $4E
		dc.w   $4E
		dc.w   $2E
		dc.w   $2E
		dc.w   $2E
		dc.w    $E
		dc.w    $E
		dc.w   $2C
		dc.w   $2C
		dc.w   $2C

AnPal_PalHCZ1:
		dc.w  $EC8, $EC0, $EA0, $E80
		dc.w  $EC0, $EA0, $E80, $EC8
		dc.w  $EA0, $E80, $EC8, $EC0
		dc.w  $E80, $EC8, $EC0, $EA0

AnPal_PalCNZ_1:
		dc.w     0,  $66,  $EE
		dc.w   $22,  $44,  $CC
		dc.w   $44,  $22,  $AA
		dc.w   $66,    0,  $88
		dc.w   $88,    0,  $66
		dc.w   $AA,  $22,  $44
		dc.w   $CC,  $44,  $22
		dc.w   $EE,  $66,    0
		dc.w   $EE,  $88,    0
		dc.w   $CC,  $AA,  $22
		dc.w   $AA,  $CC,  $44
		dc.w   $88,  $EE,  $66
		dc.w   $66,  $EE,  $88
		dc.w   $44,  $CC,  $AA
		dc.w   $22,  $AA,  $CC
		dc.w     0,  $88,  $EE

AnPal_PalCNZ_3:
		dc.w  $E20,  $8A, $C0E
		dc.w  $C42,  $6C, $E0E
		dc.w  $A64,  $4C, $E0C
		dc.w  $884,  $2E, $E0A
		dc.w  $6A6,   $E, $E08
		dc.w  $4C6, $20E, $E06
		dc.w  $2E8, $40E, $E04
		dc.w   $E8, $60E, $E02
		dc.w   $C8, $80E, $E00
		dc.w   $AA, $A0E, $E00
		dc.w   $8A, $C0E, $E20
		dc.w   $6C, $E0E, $C42
		dc.w   $4C, $E0C, $A64
		dc.w   $2E, $E0A, $884
		dc.w    $E, $E08, $6A6
		dc.w  $20E, $E06, $4C6
		dc.w  $40E, $E04, $2E8
		dc.w  $60E, $E02,  $E8
		dc.w  $80E, $E00,  $C8
		dc.w  $A0E, $E00,  $AA
		dc.w  $C0E, $E20,  $8A
		dc.w  $E0E, $C42,  $6C
		dc.w  $E0C, $A64,  $4C
		dc.w  $E0A, $884,  $2E
		dc.w  $E08, $6A6,   $E
		dc.w  $E06, $4C6, $20E
		dc.w  $E04, $2E8, $40E
		dc.w  $E02,  $E8, $60E
		dc.w  $E00,  $C8, $80E
		dc.w  $E00,  $AA, $A0E

AnPal_PalCNZ_5:
		dc.w  $2E0, $ECE
		dc.w  $4E2, $EAC
		dc.w  $6E4, $E8A
		dc.w  $8E6, $E68
		dc.w  $AE8, $E46
		dc.w  $CEA, $E24
		dc.w  $EEC, $E02
		dc.w  $EEE, $E00
		dc.w  $EEC, $E02
		dc.w  $CEA, $E24
		dc.w  $AE8, $E46
		dc.w  $8E6, $E68
		dc.w  $6E4, $E8A
		dc.w  $4E2, $EAC
		dc.w  $2E0, $ECE
		dc.w   $E0, $EEE

AnPal_PalCNZ_2:
		dc.w  $800, $800, $886
		dc.w  $800, $800, $864
		dc.w  $800, $800, $842
		dc.w  $800, $800, $820
		dc.w  $820, $800, $800
		dc.w  $842, $800, $800
		dc.w  $864, $800, $800
		dc.w  $886, $800, $800
		dc.w  $886, $820, $800
		dc.w  $864, $842, $800
		dc.w  $842, $864, $800
		dc.w  $820, $886, $800
		dc.w  $800, $886, $820
		dc.w  $800, $864, $842
		dc.w  $800, $842, $864
		dc.w  $800, $820, $886

AnPal_PalCNZ_4:
		dc.w  $E20, $E8A, $E0A
		dc.w  $E42, $E6A, $E0A
		dc.w  $E64, $E4A, $E0A
		dc.w  $E84, $E2A, $E0A
		dc.w  $EA6, $E0A, $E08
		dc.w  $EC6, $E0A, $E06
		dc.w  $EE8, $E0A, $E04
		dc.w  $EE8, $E0A, $E02
		dc.w  $EC8, $E0A, $E00
		dc.w  $EAA, $E0A, $E00
		dc.w  $E8A, $E0A, $E20
		dc.w  $E6A, $E0A, $C42
		dc.w  $E4A, $E0A, $E64
		dc.w  $E2A, $E0A, $E84
		dc.w  $E0A, $E08, $EA6
		dc.w  $E0A, $E06, $EC6
		dc.w  $E0A, $E04, $EE8
		dc.w  $E0A, $E02, $EE8
		dc.w  $E0A, $E00, $EC8
		dc.w  $E0A, $E00, $EAA
		dc.w  $E0A, $E20, $E8A
		dc.w  $E0A, $E42, $E6A
		dc.w  $E0A, $E64, $E4A
		dc.w  $E0A, $E84, $E2A
		dc.w  $E08, $EA6, $E0A
		dc.w  $E06, $EC6, $E0A
		dc.w  $E04, $EE8, $E0A
		dc.w  $E02, $EE8, $E0A
		dc.w  $E00, $EC8, $E0A
		dc.w  $E00, $EAA, $E0A

		dc.w  $840, $ECA
		dc.w  $862, $EAA
		dc.w  $884, $E88
		dc.w  $8A6, $E66
		dc.w  $AE8, $E44
		dc.w  $CEA, $E22
		dc.w  $EEC, $E00
		dc.w  $EEC, $E00
		dc.w  $EEC, $E00
		dc.w  $CEA, $E22
		dc.w  $AE8, $E44
		dc.w  $8A6, $E66
		dc.w  $884, $E88
		dc.w  $862, $EAA
		dc.w  $840, $ECA
		dc.w  $822, $ECA

AnPal_PalICZ_1:
		dc.w  $E62, $E20
		dc.w  $E44, $E20
		dc.w  $E44, $E00
		dc.w  $E42, $E00
		dc.w  $E62, $C00
		dc.w  $E82, $A00
		dc.w  $EA2, $C00
		dc.w  $EC0, $E00
		dc.w  $EE0, $E20
		dc.w  $EE4, $E00
		dc.w  $EE4, $C00
		dc.w  $EE4, $A00
		dc.w  $EE0, $800
		dc.w  $EC2, $A00
		dc.w  $EA2, $C00
		dc.w  $E82, $E20

AnPal_PalICZ_2:
		dc.w  $E06, $E08
		dc.w  $E04, $E06
		dc.w  $C04, $E04
		dc.w  $C02, $C04
		dc.w  $A02, $C02
		dc.w  $A00, $A02
		dc.w  $800, $A00
		dc.w  $600, $800
		dc.w  $600, $800
		dc.w  $600, $800
		dc.w  $600, $800
		dc.w  $800, $A00
		dc.w  $A00, $A02
		dc.w  $A02, $C02
		dc.w  $C02, $C04
		dc.w  $C04, $E04
		dc.w  $E04, $E06
		dc.w  $E06, $E08

AnPal_PalICZ_3:
		dc.w  $840, $EEA
		dc.w  $860, $EE0
		dc.w  $A80, $EC0
		dc.w  $EC0, $A80
		dc.w  $A80, $EC0
		dc.w  $860, $EE0

AnPal_PalICZ_4:
		dc.w   $E8, $CEC
		dc.w   $C8, $AEA
		dc.w   $C8, $AEA
		dc.w   $A6, $6E8
		dc.w   $A6, $6E8
		dc.w   $84,  $E8
		dc.w   $84,  $E8
		dc.w   $82,  $C8
		dc.w   $64,  $A6
		dc.w   $64,  $A6
		dc.w   $82,  $C8
		dc.w   $84,  $E8
		dc.w   $A6, $6E8
		dc.w   $C8, $AEA
		dc.w   $E8, $CEC
		dc.w   $E8, $CEC

AnPal_PalLBZ1:
		dc.w  $8E0,  $C0,  $80
		dc.w   $C0,  $80, $8E0
		dc.w   $80, $8E0,  $C0

AnPal_PalLBZ2:
		dc.w  $EEA, $EA4, $C62
		dc.w  $EA4, $C62, $EEA
		dc.w  $C62, $EEA, $EA4

AnPal_PalLRZ1_1:
		dc.w   $EE,  $AE,  $6E,   $E
		dc.w   $AE,  $6E,   $E,  $EE
		dc.w   $6E,   $E,  $EE, $2CE
		dc.w   $2E, $8EE, $4EE,  $6E
		dc.w  $AEE, $6EE,  $8E,  $4E
		dc.w  $4EE,  $6E,  $2E, $8EE
		dc.w   $6E,   $E,  $EE, $2CE
		dc.w    $E,  $EE, $2CE,  $6E
		dc.w   $EE,  $AE,  $6E,   $E
		dc.w   $8E,  $4E,   $C,  $CE
		dc.w   $2E,   $A,  $AC,  $6E
		dc.w     8,  $8E,  $4C,   $C
		dc.w   $AC,  $6E,  $2E,   $A
		dc.w   $8E,  $4E,   $C,  $CE
		dc.w   $6E,   $E,  $EE,  $AE
		dc.w    $E,  $EE,  $AE,  $6E

AnPal_PalLRZ1_2:
		dc.w  $224, $224
		dc.w  $224, $424
		dc.w  $224, $426
		dc.w  $426, $224
		dc.w  $424, $224
		dc.w  $224, $224
		dc.w  $224, $224

		dc.w  $224, $422
		dc.w  $422, $422

AnPal_PalBPZ_1:
		dc.w   $EE,  $AE,  $6C
		dc.w   $AE,  $6E,  $EE
		dc.w   $6E,  $EE,  $AE

AnPal_PalBPZ_2:
		dc.w  $EE0, $E0E,  $EE
		dc.w  $EA0, $A0E,  $EA
		dc.w  $E60, $60E,  $E6
		dc.w  $E20, $20E,  $E2
		dc.w  $E02,  $2E, $2E0
		dc.w  $E06,  $6E, $6E0
		dc.w  $E0A,  $AE, $AE0
		dc.w  $E0E,  $EE, $EE0
		dc.w  $A0E,  $EA, $EA0
		dc.w  $60E,  $E6, $E60
		dc.w  $20E,  $E2, $E20
		dc.w   $2E, $2E0, $E02
		dc.w   $6E, $6E0, $E06
		dc.w   $AE, $AE0, $E0A
		dc.w   $EE, $EE0, $E0E
		dc.w   $EA, $EA0, $A0E
		dc.w   $E6, $E60, $60E
		dc.w   $E2, $E20, $20E
		dc.w  $2E0, $E02,  $2E
		dc.w  $6E0, $E06,  $6E
		dc.w  $AE0, $E0A,  $AE

AnPal_PalCGZ:
		dc.w    $E,    8,    4, $EEE
		dc.w    $C,    6,    2, $CCE
		dc.w    $A,    4,    0, $AAE
		dc.w     8,    2,    0, $88E
		dc.w     6,    0,    0, $66E
		dc.w     4,    0,    0, $44E
		dc.w     6,    0,    0, $66E
		dc.w     8,    2,    0, $88E
		dc.w    $A,    4,    2, $AAE
		dc.w    $C,    6,    4, $CCE

AnPal_PalEMZ_1:
		dc.w     6
		dc.w     8
		dc.w    $A
		dc.w    $C
		dc.w    $E
		dc.w    $E
		dc.w    $E
		dc.w    $E
		dc.w    $C
		dc.w    $A
		dc.w     8
		dc.w     6
		dc.w     6
		dc.w     6
		dc.w     6
		dc.w     8
		dc.w    $A
		dc.w    $C
		dc.w    $E
		dc.w    $E
		dc.w    $E
		dc.w    $C
		dc.w    $A
		dc.w     8
		dc.w     6
		dc.w     8
		dc.w    $A
		dc.w    $A
		dc.w    $A
		dc.w     8

AnPal_PalEMZ_2:
		dc.w     0,   $E
		dc.w     2,   $C
		dc.w     4,   $A
		dc.w     6,    8
		dc.w     8,    6
		dc.w    $A,    4
		dc.w    $C,    2
		dc.w    $E,    0
		dc.w    $C,    2
		dc.w    $A,    4
		dc.w     8,    6
		dc.w     6,    8
		dc.w     4,   $A
		dc.w     2,   $C

; =============== S U B R O U T I N E =======================================


SuperSonic_PalCycle:
		move.b	(Super_palette_status).w,d0	; 0 = off | 1 = fading | -1 = fading done
		beq.s	locret_316A			; return, if player isn't super
		bmi.w	SuperSonic_PalCycle_Normal	; branch, if fade-in is done
		subq.b	#1,d0
		bne.s	SuperSonic_PalCycle_Revert	; branch for values greater than 1

		; fade from Sonic's to Super Sonic's palette
		; run frame timer
		subq.b	#1,(Palette_timer).w
		bpl.s	locret_316A
		move.b	#1,(Palette_timer).w

		; increment palette frame and update Sonic's palette
		lea	(PalCycle_SuperSonic).l,a0
		move.w	(Palette_frame).w,d0
		addq.w	#6,(Palette_frame).w			; 1 palette entry = 1 word, Sonic uses 3 shades of blue
		cmpi.w	#$24,(Palette_frame).w			; has palette cycle reached the 6th frame?
		blo.s	SuperSonic_PalCycle_SonicApply		; if not, branch
		move.b	#-1,(Super_palette_status).w	; mark fade-in as done
		move.b	#0,(Player_1+object_control).w		; restore Sonic's movement

SuperSonic_PalCycle_SonicApply:
		lea	(Normal_palette+$04).w,a1
		move.l	(a0,d0.w),(a1)+	; Write first two palette entries
		move.w	4(a0,d0.w),(a1)	; Write last palette entry

		tst.b	(Water_flag).w
		beq.s	locret_316A
		lea	(PalCycle_SuperSonicUnderwaterAIZICZ).l,a0	; Load underwater fade-in palette
		tst.b	(Current_zone).w				; Is Sonic in Angel Island Zone?
		beq.s	SuperSonic_PalCycle_ApplyUnderwater		; If so, branch
		cmpi.b	#5,(Current_zone).w				; Is Sonic in IceCap Zone?
		beq.s	SuperSonic_PalCycle_ApplyUnderwater		; If so, branch
		lea	(PalCycle_SuperSonicUnderwaterHCZCNZLBZ).l,a0	; Load alternate underwater fade-in palette

SuperSonic_PalCycle_ApplyUnderwater:
		lea	(Water_palette+$04).w,a1
		move.l	(a0,d0.w),(a1)+	; Write first two palette entries
		move.w	4(a0,d0.w),(a1)	; Write last palette entry

locret_316A:
		rts
; ---------------------------------------------------------------------------

SuperSonic_PalCycle_Revert:	; runs the fade in transition backwards
		; run frame timer
		subq.b	#1,(Palette_timer).w
		bpl.s	locret_316A
		move.b	#3,(Palette_timer).w

		; decrement palette frame and update Sonic's palette
		lea	(PalCycle_SuperSonic).l,a0
		move.w	(Palette_frame).w,d0
		subq.w	#6,(Palette_frame).w	; previous frame
		bcc.s	loc_3194		; branch, if it isn't the first frame
		; Bug: this only clears the high byte of Palette_frame, causing subsequent
		; fade-ins to pull color values from Pal_FromBlack
		move.b	#0,(Palette_frame).w
		move.b	#0,(Super_palette_status).w	; 0 = off

loc_3194:
		bra.s	SuperSonic_PalCycle_SonicApply
; ---------------------------------------------------------------------------

SuperSonic_PalCycle_Normal:
		; run frame timer
		subq.b	#1,(Palette_timer).w
		bpl.s	locret_316A
		move.b	#6,(Palette_timer).w

		; increment palette frame and update Sonic's palette
		lea	(PalCycle_SuperSonic).l,a0
		move.w	(Palette_frame).w,d0
		addq.w	#6,(Palette_frame).w	; next frame
		cmpi.w	#$36,(Palette_frame).w	; is it the last frame?
		blo.s	loc_31BE		; if not, branch
		move.w	#$24,(Palette_frame).w	; reset frame counter (Super Sonic's normal palette cycle starts at $24. Everything before that is for the palette fade)

loc_31BE:
		bra.w	SuperSonic_PalCycle_SonicApply
; End of function SuperSonic_PalCycle

; ---------------------------------------------------------------------------
PalCycle_SuperSonic:
		dc.w $E66,$C42,$822
		dc.w $E88,$C66,$844
		dc.w $EAA,$C88,$A66
		dc.w $ECC,$EAA,$C88
		dc.w $EEE,$ECC,$EAA
		dc.w $EEE,$EEE,$EEE
		dc.w $CEE,$CEE,$AEE
		dc.w $AEE,$8EE,$6CC
		dc.w $8EE,$0EE,$0AA
		dc.w $AEE,$8EE,$6CC
PalCycle_SuperSonicUnderwaterAIZICZ:
		dc.w $A82,$860,$640
		dc.w $E88,$C66,$844
		dc.w $EAA,$C88,$A66
		dc.w $ECC,$EAA,$C88
		dc.w $EEE,$ECC,$EAA
		dc.w $EEE,$EEE,$EEE
		dc.w $CEE,$CEC,$AEC
		dc.w $AEC,$8EC,$6CA
		dc.w $8EC,$4EA,$4A8
		dc.w $CEE,$CEC,$AEC
PalCycle_SuperSonicUnderwaterHCZCNZLBZ:
		dc.w $C66,$A44,$624
		dc.w $E88,$C66,$844
		dc.w $EAA,$C88,$A66
		dc.w $ECC,$EAA,$C88
		dc.w $EEE,$ECC,$EAA
		dc.w $EEE,$EEE,$EEE
		dc.w $CEE,$CEC,$AEC
		dc.w $AEC,$8EC,$6CA
		dc.w $8EC,$4EA,$4A8
		dc.w $CEE,$CEC,$AEC

; =============== S U B R O U T I N E =======================================


Pal_FadeFromBlack:
		move.w	#$40-1,(Palette_fade_info).w
		jsr	Pal_FillBlack(pc)
		move.w	#$15,d4

loc_3284:
		move.b	#$12,(V_int_routine).w
		bsr.w	Wait_VSync
		bsr.s	Pal_FromBlack
		bsr.w	Process_Nem_Queue_Init
		dbf	d4,loc_3284
		rts
; End of function Pal_FadeFromBlack


; =============== S U B R O U T I N E =======================================


Pal_FromBlack:
		moveq	#0,d0
		lea	(Normal_palette).w,a0
		lea	(Target_palette).w,a1
		move.b	(Palette_fade_info).w,d0
		adda.w	d0,a0
		adda.w	d0,a1
		move.b	(Palette_fade_count).w,d0

loc_32B0:
		bsr.s	Pal_AddColor
		dbf	d0,loc_32B0
		tst.b	(Water_flag).w
		beq.s	locret_32D8
		moveq	#0,d0
		lea	(Water_palette).w,a0
		lea	(Target_water_palette).w,a1
		move.b	(Palette_fade_info).w,d0
		adda.w	d0,a0
		adda.w	d0,a1
		move.b	(Palette_fade_count).w,d0

loc_32D2:
		bsr.s	Pal_AddColor
		dbf	d0,loc_32D2

locret_32D8:
		rts
; End of function Pal_FromBlack


; =============== S U B R O U T I N E =======================================


Pal_AddColor:
		move.w	(a1)+,d2
		move.w	(a0),d3
		cmp.w	d2,d3
		beq.s	loc_3302
		move.w	d3,d1
		addi.w	#$200,d1
		cmp.w	d2,d1
		bhi.s	loc_32F0
		move.w	d1,(a0)+
		rts
; ---------------------------------------------------------------------------

loc_32F0:
		move.w	d3,d1
		addi.w	#$20,d1
		cmp.w	d2,d1
		bhi.s	loc_32FE
		move.w	d1,(a0)+
		rts
; ---------------------------------------------------------------------------

loc_32FE:
		addq.w	#2,(a0)+
		rts
; ---------------------------------------------------------------------------

loc_3302:
		addq.w	#2,a0
		rts
; End of function Pal_AddColor


; =============== S U B R O U T I N E =======================================


Pal_FillBlack:
		moveq	#0,d0
		lea	(Normal_palette).w,a0
		move.b	(Palette_fade_info).w,d0
		adda.w	d0,a0
		moveq	#0,d1
		move.b	(Palette_fade_count).w,d0

loc_3318:
		move.w	d1,(a0)+
		tst.b	(Water_flag).w
		beq.s	loc_3324
		move.w	d1,(Water_palette-Normal_palette)-2(a0)

loc_3324:
		dbf	d0,loc_3318
		rts
; End of function Pal_FillBlack


; =============== S U B R O U T I N E =======================================


Animate_Palette:
		tst.w	(Palette_fade_timer).w
		beq.s	loc_3338
		subq.w	#1,(Palette_fade_timer).w
		bra.w	Pal_FromBlack
; ---------------------------------------------------------------------------

loc_3338:
		jmp	(AnPal_Load).l
; End of function Animate_Palette


; =============== S U B R O U T I N E =======================================


Pal_FadeToBlack:
		move.w	#$40-1,(Palette_fade_info).w
		move.w	#$15,d4

loc_3348:
		move.b	#$12,(V_int_routine).w
		bsr.w	Wait_VSync
		bsr.s	Pal_ToBlack
		bsr.w	Process_Nem_Queue_Init
		dbf	d4,loc_3348
		rts
; End of function Pal_FadeToBlack


; =============== S U B R O U T I N E =======================================


Pal_ToBlack:
		moveq	#0,d0
		lea	(Normal_palette).w,a0
		move.b	(Palette_fade_info).w,d0
		adda.w	d0,a0
		move.b	(Palette_fade_count).w,d0

loc_336E:
		bsr.s	Pal_DecColor
		dbf	d0,loc_336E
		moveq	#0,d0
		lea	(Water_palette).w,a0
		move.b	(Palette_fade_info).w,d0
		adda.w	d0,a0
		move.b	(Palette_fade_count).w,d0

loc_3384:
		bsr.s	Pal_DecColor
		dbf	d0,loc_3384
		rts
; End of function Pal_ToBlack


; =============== S U B R O U T I N E =======================================


Pal_DecColor:
		move.w	(a0),d2
		beq.s	loc_33B8
		move.w	d2,d1
		andi.w	#$E,d1
		beq.s	loc_339C
		subq.w	#2,(a0)+
		rts
; ---------------------------------------------------------------------------

loc_339C:
		move.w	d2,d1
		andi.w	#$E0,d1
		beq.s	loc_33AA
		subi.w	#$20,(a0)+
		rts
; ---------------------------------------------------------------------------

loc_33AA:
		move.w	d2,d1
		andi.w	#$E00,d1
		beq.s	loc_33B8
		subi.w	#$200,(a0)+
		rts
; ---------------------------------------------------------------------------

loc_33B8:
		addq.w	#2,a0
		rts
; End of function Pal_DecColor


; =============== S U B R O U T I N E =======================================


Pal_FadeFromWhite:
		move.w	#$40-1,(Palette_fade_info).w
		moveq	#0,d0
		lea	(Normal_palette).w,a0
		move.b	(Palette_fade_info).w,d0
		adda.w	d0,a0
		move.w	#$EEE,d1
		move.b	(Palette_fade_count).w,d0

loc_33D6:
		move.w	d1,(a0)+
		dbf	d0,loc_33D6
		move.w	#$15,d4

loc_33E0:
		move.b	#$12,(V_int_routine).w
		bsr.w	Wait_VSync
		bsr.s	Pal_FromWhite
		bsr.w	Process_Nem_Queue_Init
		dbf	d4,loc_33E0
		rts
; End of function Pal_FadeFromWhite


; =============== S U B R O U T I N E =======================================


Pal_FromWhite:
		moveq	#0,d0
		lea	(Normal_palette).w,a0
		lea	(Target_palette).w,a1
		move.b	(Palette_fade_info).w,d0
		adda.w	d0,a0
		adda.w	d0,a1
		move.b	(Palette_fade_count).w,d0

loc_340C:
		bsr.s	Pal_DecColor2
		dbf	d0,loc_340C
		tst.b	(Water_flag).w
		beq.s	locret_3434
		moveq	#0,d0
		lea	(Water_palette).w,a0
		lea	(Target_water_palette).w,a1
		move.b	(Palette_fade_info).w,d0
		adda.w	d0,a0
		adda.w	d0,a1
		move.b	(Palette_fade_count).w,d0

loc_342E:
		bsr.s	Pal_DecColor2
		dbf	d0,loc_342E

locret_3434:
		rts
; End of function Pal_FromWhite


; =============== S U B R O U T I N E =======================================


Pal_DecColor2:
		move.w	(a1)+,d2
		move.w	(a0),d3
		cmp.w	d2,d3
		beq.s	loc_3462
		move.w	d3,d1
		subi.w	#$200,d1
		bcs.s	loc_344E
		cmp.w	d2,d1
		bcs.s	loc_344E
		move.w	d1,(a0)+
		rts
; ---------------------------------------------------------------------------

loc_344E:
		move.w	d3,d1
		subi.w	#$20,d1
		bcs.s	loc_345E
		cmp.w	d2,d1
		bcs.s	loc_345E
		move.w	d1,(a0)+
		rts
; ---------------------------------------------------------------------------

loc_345E:
		subq.w	#2,(a0)+
		rts
; ---------------------------------------------------------------------------

loc_3462:
		addq.w	#2,a0
		rts
; End of function Pal_DecColor2


; =============== S U B R O U T I N E =======================================


Pal_FadeToWhite:
		move.w	#$40-1,(Palette_fade_info).w
		move.w	#$15,d4

loc_3470:
		move.b	#$12,(V_int_routine).w
		bsr.w	Wait_VSync
		bsr.s	Pal_ToWhite
		bsr.w	Process_Nem_Queue_Init
		dbf	d4,loc_3470
		rts
; End of function Pal_FadeToWhite


; =============== S U B R O U T I N E =======================================


Pal_ToWhite:
		moveq	#0,d0
		lea	(Normal_palette).w,a0
		move.b	(Palette_fade_info).w,d0
		adda.w	d0,a0
		move.b	(Palette_fade_count).w,d0

loc_3496:
		bsr.s	Pal_AddColor2
		dbf	d0,loc_3496
		moveq	#0,d0
		lea	(Water_palette).w,a0
		move.b	(Palette_fade_info).w,d0
		adda.w	d0,a0
		move.b	(Palette_fade_count).w,d0

loc_34AC:
		bsr.s	Pal_AddColor2
		dbf	d0,loc_34AC
		rts
; End of function Pal_ToWhite


; =============== S U B R O U T I N E =======================================


Pal_AddColor2:
		move.w	(a0),d2
		cmpi.w	#$EEE,d2
		beq.s	loc_34F0
		move.w	d2,d1
		andi.w	#$E,d1
		cmpi.w	#$E,d1
		beq.s	loc_34CC
		addq.w	#2,(a0)+
		rts
; ---------------------------------------------------------------------------

loc_34CC:
		move.w	d2,d1
		andi.w	#$E0,d1
		cmpi.w	#$E0,d1
		beq.s	loc_34DE
		addi.w	#$20,(a0)+
		rts
; ---------------------------------------------------------------------------

loc_34DE:
		move.w	d2,d1
		andi.w	#$E00,d1
		cmpi.w	#$E00,d1
		beq.s	loc_34F0
		addi.w	#$200,(a0)+
		rts
; ---------------------------------------------------------------------------

loc_34F0:
		addq.w	#2,a0
		rts
; End of function Pal_AddColor2


; =============== S U B R O U T I N E =======================================


LoadPalette:
		lea	(PalPoint).l,a1
		lsl.w	#3,d0
		adda.w	d0,a1
		movea.l	(a1)+,a2
		movea.w	(a1)+,a3
		adda.w	#Target_palette-Normal_palette,a3
		move.w	(a1)+,d7

.loop:
		move.l	(a2)+,(a3)+
		dbf	d7,.loop
		rts
; End of function LoadPalette


; =============== S U B R O U T I N E =======================================


LoadPalette_Immediate:
		lea	(PalPoint).l,a1
		lsl.w	#3,d0
		adda.w	d0,a1
		movea.l	(a1)+,a2
		movea.w	(a1)+,a3
		move.w	(a1)+,d7

.loop:
		move.l	(a2)+,(a3)+
		dbf	d7,.loop
		rts
; End of function LoadPalette_Immediate


; =============== S U B R O U T I N E =======================================


LoadPalette2:
		lea	(PalPoint).l,a1
		lsl.w	#3,d0
		adda.w	d0,a1
		movea.l	(a1)+,a2
		movea.w	(a1)+,a3
		suba.w	#Normal_palette-Water_palette,a3
		move.w	(a1)+,d7

.loop:
		move.l	(a2)+,(a3)+
		dbf	d7,.loop
		rts
; End of function LoadPalette2


; =============== S U B R O U T I N E =======================================


LoadPalette2_Immediate:
		lea	(PalPoint).l,a1
		lsl.w	#3,d0
		adda.w	d0,a1
		movea.l	(a1)+,a2
		movea.w	(a1)+,a3
		suba.w	#Normal_palette-Target_water_palette,a3
		move.w	(a1)+,d7

.loop:
		move.l	(a2)+,(a3)+
		dbf	d7,.loop
		rts
; End of function LoadPalette2_Immediate

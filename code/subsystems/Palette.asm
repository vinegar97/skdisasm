AnPal_Load:
		bsr.w	SuperHyper_PalCycle
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
		dc.w AnPal_SOZ1-OffsAnPal
		dc.w AnPal_SOZ2-OffsAnPal
		dc.w AnPal_LRZ1-OffsAnPal
		dc.w AnPal_LRZ2-OffsAnPal
		dc.w AnPal_None-OffsAnPal
		dc.w AnPal_None-OffsAnPal
		dc.w AnPal_DEZ1-OffsAnPal
		dc.w AnPal_DEZ2-OffsAnPal
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
		dc.w AnPal_Pachinko-OffsAnPal
		dc.w AnPal_Pachinko-OffsAnPal
		dc.w AnPal_Slots-OffsAnPal
		dc.w AnPal_Slots-OffsAnPal
		dc.w AnPal_LRZ3-OffsAnPal
		dc.w AnPal_HPZ-OffsAnPal
		dc.w AnPal_None-OffsAnPal
		dc.w AnPal_HPZ-OffsAnPal
; ---------------------------------------------------------------------------

AnPal_None:
		rts
; ---------------------------------------------------------------------------

AnPal_AIZ1:
		move.b	(AIZ1_palette_cycle_flag).w,d0
		bne.s	++ ;loc_221E
		subq.w	#1,(Palette_cycle_counter1).w
		bpl.s	locret_221C
		move.w	#7,(Palette_cycle_counter1).w
		move.w	(Palette_cycle_counter0).w,d0
		addq.w	#8,(Palette_cycle_counter0).w
		andi.w	#$18,d0
		lea	(AnPal_PalAIZ1_1).l,a0
		move.l	(a0,d0.w),(Normal_palette_line_3+$16).w
		move.l	4(a0,d0.w),(Normal_palette_line_3+$1A).w
		tst.b	(Palette_cycle_counters+$00).w
		bne.s	locret_221C
		move.w	(Palette_cycle_counters+$02).w,d0
		addq.w	#6,(Palette_cycle_counters+$02).w
		cmpi.w	#$30,(Palette_cycle_counters+$02).w
		blo.s	+ ;loc_220A
		move.w	#0,(Palette_cycle_counters+$02).w

+ ;loc_220A:
		lea	(AnPal_PalAIZ1_2).l,a0
		move.l	(a0,d0.w),(Normal_palette_line_4+$18).w
		move.w	4(a0,d0.w),(Normal_palette_line_4+$1C).w

locret_221C:
		rts
; ---------------------------------------------------------------------------

+ ;loc_221E:
		subq.w	#1,(Palette_cycle_counter1).w
		bpl.s	locret_227A
		move.w	#9,(Palette_cycle_counter1).w
		move.w	(Palette_cycle_counter0).w,d0
		addq.w	#8,(Palette_cycle_counter0).w
		cmpi.w	#$50,(Palette_cycle_counter0).w
		blo.s	+ ;loc_2240
		move.w	#0,(Palette_cycle_counter0).w

+ ;loc_2240:
		lea	(AnPal_PalAIZ1_3).l,a0
		move.l	(a0,d0.w),(Normal_palette_line_4+$04).w
		move.l	4(a0,d0.w),(Normal_palette_line_4+$08).w
		move.w	(Palette_cycle_counters+$02).w,d0
		addq.w	#6,(Palette_cycle_counters+$02).w
		cmpi.w	#$3C,(Palette_cycle_counters+$02).w
		blo.s	+ ;loc_2268
		move.w	#0,(Palette_cycle_counters+$02).w

+ ;loc_2268:
		lea	(AnPal_PalAIZ1_4).l,a0
		move.l	(a0,d0.w),(Normal_palette_line_4+$1A).w
		move.w	4(a0,d0.w),(Normal_palette_line_4+$1E).w

locret_227A:
		rts
; ---------------------------------------------------------------------------

AnPal_AIZ2:
		subq.w	#1,(Palette_cycle_counter1).w
		bpl.s	+++ ;loc_22F6
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
		blo.s	+ ;loc_22BC
		move.w	#0,(Palette_cycle_counters+$02).w

+ ;loc_22BC:
		lea	(AnPal_PalAIZ2_2).l,a0
		cmpi.w	#$3800,(Camera_X_pos).w
		blo.s	+ ;loc_22D0
		lea	(AnPal_PalAIZ2_3).l,a0

+ ;loc_22D0:
		move.w	(a0,d0.w),(Normal_palette_line_3+$08).w
		move.w	2(a0,d0.w),(Normal_palette_line_3+$10).w
		move.w	4(a0,d0.w),(Normal_palette_line_4+$16).w
		move.w	#$A0E,(Normal_palette_line_3+$1C).w
		cmpi.w	#$1C0,(Camera_X_pos).w
		bhs.s	+ ;loc_22F6
		move.w	4(a0,d0.w),(Normal_palette_line_3+$1C).w

+ ;loc_22F6:
		subq.w	#1,(Palette_cycle_counters+$08).w
		bpl.s	locret_2332
		move.w	#1,(Palette_cycle_counters+$08).w
		move.w	(Palette_cycle_counters+$04).w,d0
		addq.w	#2,(Palette_cycle_counters+$04).w
		cmpi.w	#$34,(Palette_cycle_counters+$04).w
		blo.s	+ ;loc_2318
		move.w	#0,(Palette_cycle_counters+$04).w

+ ;loc_2318:
		lea	(AnPal_PalAIZ2_4).l,a0
		cmpi.w	#$3800,(Camera_X_pos).w
		blo.s	+ ;loc_232C
		lea	(AnPal_PalAIZ2_5).l,a0

+ ;loc_232C:
		move.w	(a0,d0.w),(Normal_palette_line_4+$02).w

locret_2332:
		rts

; =============== S U B R O U T I N E =======================================


AnPal_HCZ1:
		subq.w	#1,(Palette_cycle_counter1).w
		bpl.s	locret_2380
		move.w	#7,(Palette_cycle_counter1).w
		tst.b	(Palette_cycle_counters+$00).w
		beq.s	+ ;loc_234C
		move.w	#0,(Palette_cycle_counter1).w

+ ;loc_234C:
		lea	(AnPal_PalHCZ1).l,a0
		move.w	(Palette_cycle_counter0).w,d0
		addq.w	#8,(Palette_cycle_counter0).w
		cmpi.w	#$20,(Palette_cycle_counter0).w
		blo.s	+ ;loc_2368
		move.w	#0,(Palette_cycle_counter0).w

+ ;loc_2368:
		move.l	(a0,d0.w),(Normal_palette_line_3+$06).w
		move.l	4(a0,d0.w),(Normal_palette_line_3+$0A).w
		move.l	(a0,d0.w),(Water_palette_line_3+$06).w
		move.l	4(a0,d0.w),(Water_palette_line_3+$0A).w

locret_2380:
		rts
; End of function AnPal_HCZ1

; ---------------------------------------------------------------------------

AnPal_HCZ2:
		rts
; ---------------------------------------------------------------------------

AnPal_CNZ:
		subq.w	#1,(Palette_cycle_counter1).w
		bpl.s	++ ;loc_23CA
		move.w	#3,(Palette_cycle_counter1).w
		lea	(AnPal_PalCNZ_1).l,a0
		move.w	(Palette_cycle_counter0).w,d0
		addq.w	#6,(Palette_cycle_counter0).w
		cmpi.w	#$60,(Palette_cycle_counter0).w
		blo.s	+ ;loc_23AC
		move.w	#0,(Palette_cycle_counter0).w

+ ;loc_23AC:
		move.l	(a0,d0.w),(Normal_palette_line_4+$12).w
		move.w	4(a0,d0.w),(Normal_palette_line_4+$16).w
		lea	(AnPal_PalCNZ_2).l,a0
		move.l	(a0,d0.w),(Water_palette_line_4+$12).w
		move.w	4(a0,d0.w),(Water_palette_line_4+$16).w

+ ;loc_23CA:
		lea	(AnPal_PalCNZ_3).l,a0
		move.w	(Palette_cycle_counters+$02).w,d0
		addq.w	#6,(Palette_cycle_counters+$02).w
		cmpi.w	#$B4,(Palette_cycle_counters+$02).w
		blo.s	+ ;loc_23E6
		move.w	#0,(Palette_cycle_counters+$02).w

+ ;loc_23E6:
		move.l	(a0,d0.w),(Normal_palette_line_3+$12).w
		move.w	4(a0,d0.w),(Normal_palette_line_3+$16).w
		lea	(AnPal_PalCNZ_4).l,a0
		move.l	(a0,d0.w),(Water_palette_line_3+$12).w
		move.w	4(a0,d0.w),(Water_palette_line_3+$16).w
		subq.w	#1,(Palette_cycle_counters+$08).w
		bpl.s	locret_243E
		move.w	#2,(Palette_cycle_counters+$08).w
		lea	(AnPal_PalCNZ_5).l,a0
		move.w	(Palette_cycle_counters+$04).w,d0
		addq.w	#4,(Palette_cycle_counters+$04).w
		cmpi.w	#$40,(Palette_cycle_counters+$04).w
		blo.s	+ ;loc_242C
		move.w	#0,(Palette_cycle_counters+$04).w

+ ;loc_242C:
		move.l	(a0,d0.w),(Normal_palette_line_3+$E).w
		lea	(AnPal_PalCNZ_5).l,a0
		move.l	(a0,d0.w),(Water_palette_line_3+$E).w

locret_243E:
		rts
; ---------------------------------------------------------------------------

AnPal_FBZ:
		tst.b	(Level_frame_counter+1).w
		bne.s	locret_244C
		bchg	#0,(_unkF7C1).w

locret_244C:
		rts
; ---------------------------------------------------------------------------

AnPal_ICZ:
		subq.w	#1,(Palette_cycle_counter1).w
		bpl.s	++ ;loc_247C
		move.w	#5,(Palette_cycle_counter1).w
		lea	(AnPal_PalICZ_1).l,a0
		move.w	(Palette_cycle_counter0).w,d0
		addq.w	#4,(Palette_cycle_counter0).w
		cmpi.w	#$40,(Palette_cycle_counter0).w
		blo.s	+ ;loc_2476
		move.w	#0,(Palette_cycle_counter0).w

+ ;loc_2476:
		move.l	(a0,d0.w),(Normal_palette_line_3+$1C).w

+ ;loc_247C:
		subq.w	#1,(Palette_cycle_counters+$08).w
		bpl.s	++ ;loc_24B0
		move.w	#9,(Palette_cycle_counters+$08).w
		lea	(AnPal_PalICZ_2).l,a0
		move.w	(Palette_cycle_counters+$02).w,d0
		addq.w	#4,(Palette_cycle_counters+$02).w
		cmpi.w	#$48,(Palette_cycle_counters+$02).w
		blo.s	+ ;loc_24A4
		move.w	#0,(Palette_cycle_counters+$02).w

+ ;loc_24A4:
		tst.w	(Events_bg+$16).w
		beq.s	+ ;loc_24B0
		move.l	(a0,d0.w),(Normal_palette_line_4+$1C).w

+ ;loc_24B0:
		subq.w	#1,(Palette_cycle_counters+$0A).w
		bpl.s	locret_2506
		move.w	#7,(Palette_cycle_counters+$0A).w
		lea	(AnPal_PalICZ_3).l,a0
		move.w	(Palette_cycle_counters+$04).w,d0
		addq.w	#4,(Palette_cycle_counters+$04).w
		cmpi.w	#$18,(Palette_cycle_counters+$04).w
		blo.s	+ ;loc_24D8
		move.w	#0,(Palette_cycle_counters+$04).w

+ ;loc_24D8:
		tst.w	(Events_bg+$16).w
		beq.s	+ ;loc_24E4
		move.l	(a0,d0.w),(Normal_palette_line_4+$18).w

+ ;loc_24E4:
		lea	(AnPal_PalICZ_4).l,a0
		move.w	(Palette_cycle_counters+$06).w,d0
		addq.w	#4,(Palette_cycle_counters+$06).w
		cmpi.w	#$40,(Palette_cycle_counters+$06).w
		blo.s	+ ;loc_2500
		move.w	#0,(Palette_cycle_counters+$06).w

+ ;loc_2500:
		move.l	(a0,d0.w),(Normal_palette_line_3+$18).w

locret_2506:
		rts
; ---------------------------------------------------------------------------

AnPal_LBZ1:
		lea	(AnPal_PalLBZ1).l,a0
		bra.s	+ ;loc_2516
; ---------------------------------------------------------------------------

AnPal_LBZ2:
		lea	(AnPal_PalLBZ2).l,a0

+ ;loc_2516:
		subq.w	#1,(Palette_cycle_counter1).w
		bpl.s	locret_2544
		move.w	#3,(Palette_cycle_counter1).w
		move.w	(Palette_cycle_counter0).w,d0
		addq.w	#6,(Palette_cycle_counter0).w
		cmpi.w	#$12,(Palette_cycle_counter0).w
		blo.s	+ ;loc_2538
		move.w	#0,(Palette_cycle_counter0).w

+ ;loc_2538:
		move.l	(a0,d0.w),(Normal_palette_line_3+$10).w
		move.w	4(a0,d0.w),(Normal_palette_line_3+$14).w

locret_2544:
		rts
; ---------------------------------------------------------------------------

AnPal_SOZ1:
		subq.w	#1,(Palette_cycle_counters+$0A).w
		bpl.s	locret_257A
		move.w	#5,(Palette_cycle_counters+$0A).w
		lea	(AnPal_PalSOZ1).l,a0
		move.w	(Palette_cycle_counters+$04).w,d0
		addq.w	#8,(Palette_cycle_counters+$04).w
		cmpi.w	#$20,(Palette_cycle_counters+$04).w
		blo.s	+ ;loc_256E
		move.w	#0,(Palette_cycle_counters+$04).w

+ ;loc_256E:
		move.l	(a0,d0.w),(Normal_palette_line_3+$18).w
		move.l	4(a0,d0.w),(Normal_palette_line_3+$1C).w

locret_257A:
		rts
; ---------------------------------------------------------------------------
		; unused
		move.w	#900-1,(Palette_cycle_counter1).w
		move.b	#0,(_unkF7C3).w
		move.w	(Palette_cycle_counters+$06).w,d0
		neg.b	d0
		move.b	d0,(Palette_cycle_counters+$00).w
		move.w	#0,(Palette_cycle_counters+$08).w

AnPal_SOZ2:
		subq.w	#1,(Palette_cycle_counter1).w
		bpl.s	+ ;loc_25C4
		move.w	#900-1,(Palette_cycle_counter1).w
		cmpi.b	#5,(_unkF7C3).w
		bhs.s	+ ;loc_25C4
		addq.b	#1,(_unkF7C3).w
		btst	#0,(_unkF7C3).w
		bne.s	+ ;loc_25C4
		move.b	#2,(Palette_cycle_counters+$00).w
		move.w	#0,(Palette_cycle_counters+$08).w

+ ;loc_25C4:
		tst.b	(Palette_cycle_counters+$00).w
		beq.s	+++ ;loc_262C
		subq.w	#1,(Palette_cycle_counters+$08).w
		bpl.s	+++ ;loc_262C
		move.w	#3,(Palette_cycle_counters+$08).w
		tst.b	(Palette_cycle_counters+$00).w
		bmi.s	+ ;loc_25EC
		subq.b	#1,(Palette_cycle_counters+$00).w
		addi.w	#$34,(Palette_cycle_counters+$02).w
		addq.w	#1,(Palette_cycle_counters+$06).w
		bra.s	++ ;loc_25FA
; ---------------------------------------------------------------------------

+ ;loc_25EC:
		addq.b	#1,(Palette_cycle_counters+$00).w
		subi.w	#$34,(Palette_cycle_counters+$02).w
		subq.w	#1,(Palette_cycle_counters+$06).w

+ ;loc_25FA:
		move.w	(Palette_cycle_counters+$02).w,d0
		lea	(AnPal_PalSOZ2_Light).l,a0
		lea	(a0,d0.w),a0
		lea	(Normal_palette_line_3+$2).w,a1
		moveq	#$B-1,d0

- ;loc_260E:
		move.w	(a0)+,(a1)+
		dbf	d0,- ;loc_260E
		lea	(Normal_palette_line_4+$2).w,a1
		moveq	#$F-1,d0

- ;loc_261A:
		move.w	(a0)+,(a1)+
		dbf	d0,- ;loc_261A
		move.w	(Palette_cycle_counters+$04).w,d0
		subq.w	#1,(Palette_cycle_counters+$0A).w
		bpl.s	+++ ;loc_264E
		bra.s	++ ;loc_2632
; ---------------------------------------------------------------------------

+ ;loc_262C:
		subq.w	#1,(Palette_cycle_counters+$0A).w
		bpl.s	locret_266A

+ ;loc_2632:
		move.w	#5,(Palette_cycle_counters+$0A).w
		move.w	(Palette_cycle_counters+$04).w,d0
		addq.w	#8,(Palette_cycle_counters+$04).w
		cmpi.w	#$20,(Palette_cycle_counters+$04).w
		blo.s	+ ;loc_264E
		move.w	#0,(Palette_cycle_counters+$04).w

+ ;loc_264E:
		lea	(AnPal_PalSOZ1).l,a0
		move.w	(Palette_cycle_counters+$06).w,d1
		lsl.w	#5,d1
		lea	(a0,d1.w),a0
		move.l	(a0,d0.w),(Normal_palette_line_3+$18).w
		move.l	4(a0,d0.w),(Normal_palette_line_3+$1C).w

locret_266A:
		rts
; ---------------------------------------------------------------------------

AnPal_LRZ1:
		subq.w	#1,(Palette_cycle_counter1).w
		bpl.s	+++ ;loc_26C2
		move.w	#$F,(Palette_cycle_counter1).w
		move.w	(Palette_cycle_counter0).w,d0
		addq.w	#8,(Palette_cycle_counter0).w
		cmpi.w	#$80,(Palette_cycle_counter0).w
		blo.s	+ ;loc_268E
		move.w	#0,(Palette_cycle_counter0).w

+ ;loc_268E:
		lea	(AnPal_PalLRZ12_1).l,a0
		move.l	(a0,d0.w),(Normal_palette_line_3+$02).w
		move.l	4(a0,d0.w),(Normal_palette_line_3+$06).w
		move.w	(Palette_cycle_counters+$02).w,d0
		addq.w	#4,(Palette_cycle_counters+$02).w
		cmpi.w	#$1C,(Palette_cycle_counters+$02).w
		blo.s	+ ;loc_26B6
		move.w	#0,(Palette_cycle_counters+$02).w

+ ;loc_26B6:
		lea	(AnPal_PalLRZ12_2).l,a0
		move.l	(a0,d0.w),(Normal_palette_line_4+$02).w

+ ;loc_26C2:
		subq.w	#1,(Palette_cycle_counters+$08).w
		bpl.s	locret_26F0
		move.w	#7,(Palette_cycle_counters+$08).w
		move.w	(Palette_cycle_counters+$04).w,d0
		addq.w	#2,(Palette_cycle_counters+$04).w
		cmpi.w	#$22,(Palette_cycle_counters+$04).w
		blo.s	+ ;loc_26E4
		move.w	#0,(Palette_cycle_counters+$04).w

+ ;loc_26E4:
		lea	(AnPal_PalLRZ1_3).l,a0
		move.w	(a0,d0.w),(Normal_palette_line_3+$16).w

locret_26F0:
		rts
; ---------------------------------------------------------------------------

AnPal_LRZ2:
		subq.w	#1,(Palette_cycle_counter1).w
		bpl.s	+++ ;loc_2748
		move.w	#$F,(Palette_cycle_counter1).w
		move.w	(Palette_cycle_counter0).w,d0
		addq.w	#8,(Palette_cycle_counter0).w
		cmpi.w	#$80,(Palette_cycle_counter0).w
		blo.s	+ ;loc_2714
		move.w	#0,(Palette_cycle_counter0).w

+ ;loc_2714:
		lea	(AnPal_PalLRZ12_1).l,a0
		move.l	(a0,d0.w),(Normal_palette_line_3+$2).w
		move.l	4(a0,d0.w),(Normal_palette_line_3+$6).w
		move.w	(Palette_cycle_counters+$02).w,d0
		addq.w	#4,(Palette_cycle_counters+$02).w
		cmpi.w	#$1C,(Palette_cycle_counters+$02).w
		blo.s	+ ;loc_273C
		move.w	#0,(Palette_cycle_counters+$02).w

+ ;loc_273C:
		lea	(AnPal_PalLRZ12_2).l,a0
		move.l	(a0,d0.w),(Normal_palette_line_4+$2).w

+ ;loc_2748:
		subq.w	#1,(Palette_cycle_counters+$08).w
		bpl.s	locret_277C
		move.w	#$F,(Palette_cycle_counters+$08).w
		move.w	(Palette_cycle_counters+$04).w,d0
		addq.w	#8,(Palette_cycle_counters+$04).w
		cmpi.w	#$100,(Palette_cycle_counters+$04).w
		blo.s	+ ;loc_276A
		move.w	#0,(Palette_cycle_counters+$04).w

+ ;loc_276A:
		lea	(AnPal_PalLRZ2_3).l,a0
		move.l	(a0,d0.w),(Normal_palette_line_4+$16).w
		move.l	(a0,d0.w),(Normal_palette_line_4+$1A).w

locret_277C:
		rts
; ---------------------------------------------------------------------------

AnPal_DEZ1:
		subq.w	#1,(Palette_cycle_counters+$0A).w
		bpl.s	AnPal_DEZ2
		move.w	#$F,(Palette_cycle_counters+$0A).w
		move.w	(Palette_cycle_counters+$04).w,d0
		addq.w	#8,(Palette_cycle_counters+$04).w
		cmpi.w	#$30,(Palette_cycle_counters+$04).w
		blo.s	+ ;loc_27A0
		move.w	#0,(Palette_cycle_counters+$04).w

+ ;loc_27A0:
		lea	(AnPal_PalDEZ1).l,a0
		move.l	(a0,d0.w),(Normal_palette_line_4+$18).w
		move.l	4(a0,d0.w),(Normal_palette_line_4+$1C).w

AnPal_DEZ2:
		subq.w	#1,(Palette_cycle_counter1).w
		bpl.s	++ ;loc_27E0
		move.w	#4,(Palette_cycle_counter1).w
		move.w	(Palette_cycle_counter0).w,d0
		addq.w	#4,(Palette_cycle_counter0).w
		cmpi.w	#$30,(Palette_cycle_counter0).w
		blo.s	+ ;loc_27D4
		move.w	#0,(Palette_cycle_counter0).w

+ ;loc_27D4:
		lea	(AnPal_PalDEZ12_1).l,a0
		move.l	(a0,d0.w),(Normal_palette_line_3+$1A).w

+ ;loc_27E0:
		subq.w	#1,(Palette_cycle_counters+$08).w
		bpl.s	locret_2818
		move.w	#$13,(Palette_cycle_counters+$08).w
		move.w	(Palette_cycle_counters+$02).w,d0
		addi.w	#$A,(Palette_cycle_counters+$02).w
		cmpi.w	#$28,(Palette_cycle_counters+$02).w
		blo.s	+ ;loc_2804
		move.w	#0,(Palette_cycle_counters+$02).w

+ ;loc_2804:
		lea	(AnPal_PalDEZ12_2).l,a0
		lea	(a0,d0.w),a0
		lea	(Normal_palette_line_3+$10).w,a1
		move.l	(a0)+,(a1)+
		move.l	(a0)+,(a1)+
		move.w	(a0)+,(a1)+

locret_2818:
		rts
; ---------------------------------------------------------------------------

AnPal_BPZ:
		subq.w	#1,(Palette_cycle_counter1).w
		bpl.s	++ ;loc_284E
		move.w	#7,(Palette_cycle_counter1).w
		lea	(AnPal_PalBPZ_1).l,a0
		move.w	(Palette_cycle_counter0).w,d0
		addq.w	#6,(Palette_cycle_counter0).w
		cmpi.w	#$12,(Palette_cycle_counter0).w
		blo.s	+ ;loc_2842
		move.w	#0,(Palette_cycle_counter0).w

+ ;loc_2842:
		move.l	(a0,d0.w),(Normal_palette_line_3+$1A).w
		move.w	4(a0,d0.w),(Normal_palette_line_3+$1E).w

+ ;loc_284E:
		subq.w	#1,(Palette_cycle_counters+$08).w
		bpl.s	locret_2882
		move.w	#$11,(Palette_cycle_counters+$08).w
		lea	(AnPal_PalBPZ_2).l,a0
		move.w	(Palette_cycle_counters+$02).w,d0
		addq.w	#6,(Palette_cycle_counters+$02).w
		cmpi.w	#$7E,(Palette_cycle_counters+$02).w
		blo.s	+ ;loc_2876
		move.w	#0,(Palette_cycle_counters+$02).w

+ ;loc_2876:
		move.l	(a0,d0.w),(Normal_palette_line_4+$04).w
		move.w	4(a0,d0.w),(Normal_palette_line_4+$08).w

locret_2882:
		rts
; ---------------------------------------------------------------------------

AnPal_CGZ:
		subq.w	#1,(Palette_cycle_counter1).w
		bpl.s	locret_28B8
		move.w	#9,(Palette_cycle_counter1).w
		lea	(AnPal_PalCGZ).l,a0
		move.w	(Palette_cycle_counter0).w,d0
		addq.w	#8,(Palette_cycle_counter0).w
		cmpi.w	#$50,(Palette_cycle_counter0).w
		blo.s	+ ;loc_28AC
		move.w	#0,(Palette_cycle_counter0).w

+ ;loc_28AC:
		move.l	(a0,d0.w),(Normal_palette_line_3+$04).w
		move.l	4(a0,d0.w),(Normal_palette_line_3+$08).w

locret_28B8:
		rts
; ---------------------------------------------------------------------------

AnPal_EMZ:
		subq.w	#1,(Palette_cycle_counter1).w
		bpl.s	++ ;loc_28E8
		move.w	#7,(Palette_cycle_counter1).w
		lea	(AnPal_PalEMZ_1).l,a0
		move.w	(Palette_cycle_counter0).w,d0
		addq.w	#2,(Palette_cycle_counter0).w
		cmpi.w	#$3C,(Palette_cycle_counter0).w
		blo.s	+ ;loc_28E2
		move.w	#0,(Palette_cycle_counter0).w

+ ;loc_28E2:
		move.w	4(a0,d0.w),(Normal_palette_line_3+$1C).w

+ ;loc_28E8:
		subq.w	#1,(Palette_cycle_counters+$08).w
		bpl.s	locret_2916
		move.w	#$1F,(Palette_cycle_counters+$08).w
		lea	(AnPal_PalEMZ_2).l,a0
		move.w	(Palette_cycle_counters+$02).w,d0
		addq.w	#4,(Palette_cycle_counters+$02).w
		cmpi.w	#$34,(Palette_cycle_counters+$02).w
		blo.s	+ ;loc_2910
		move.w	#0,(Palette_cycle_counters+$02).w

+ ;loc_2910:
		move.l	(a0,d0.w),(Normal_palette_line_4+$12).w

locret_2916:
		rts
; ---------------------------------------------------------------------------

AnPal_Pachinko:
		subq.w	#1,(Palette_cycle_counter1).w
		bpl.s	++ ;loc_2952
		move.w	#0,(Palette_cycle_counter1).w
		move.w	(Palette_cycle_counter0).w,d0
		addi.w	#$E,(Palette_cycle_counter0).w
		cmpi.w	#$FC,(Palette_cycle_counter0).w
		blo.s	+ ;loc_293C
		move.w	#0,(Palette_cycle_counter0).w

+ ;loc_293C:
		lea	(Chunk_table+$7800).l,a0
		lea	(Normal_palette_line_4+$10).w,a1
		lea	(a0,d0.w),a0
		move.l	(a0)+,(a1)+
		move.l	(a0)+,(a1)+
		move.l	(a0)+,(a1)+
		move.w	(a0)+,(a1)+

+ ;loc_2952:
		subq.w	#1,(Palette_cycle_counters+$08).w
		bpl.s	locret_29A6
		move.w	#3,(Palette_cycle_counters+$08).w
		move.w	(Palette_cycle_counters+$02).w,d0
		addi.w	#$A,(Palette_cycle_counters+$02).w
		cmpi.w	#$3E8,(Palette_cycle_counters+$02).w
		blo.s	+ ;loc_2976
		move.w	#0,(Palette_cycle_counters+$02).w

+ ;loc_2976:
		lea	(Chunk_table+$78FC).l,a0
		lea	(Normal_palette_line_3+$2).w,a1
		lea	(a0,d0.w),a0
		move.l	$50(a0),(a1)+
		move.l	$54(a0),(a1)+
		move.w	$58(a0),(a1)+
		move.l	$28(a0),(a1)+
		move.l	$2C(a0),(a1)+
		move.w	$30(a0),(a1)+
		move.l	(a0),(a1)+
		move.l	4(a0),(a1)+
		move.w	8(a0),(a1)+

locret_29A6:
		rts
; ---------------------------------------------------------------------------

AnPal_Slots:
		tst.b	(Palette_cycle_counters+$00).w
		bmi.s	locret_29F0
		bne.s	++ ;loc_29F2
		subq.w	#1,(Palette_cycle_counter1).w
		bpl.s	locret_29F0
		move.w	#3,(Palette_cycle_counter1).w
		move.w	(Palette_cycle_counter0).w,d0
		addq.w	#8,(Palette_cycle_counter0).w
		cmpi.w	#$40,(Palette_cycle_counter0).w
		blo.s	+ ;loc_29D2
		move.w	#0,(Palette_cycle_counter0).w

+ ;loc_29D2:
		lea	(AnPal_PalSlots_1).l,a0
		move.l	(a0,d0.w),(Normal_palette_line_3+$14).w
		move.l	4(a0,d0.w),(Normal_palette_line_3+$18).w
		move.w	#$E02,(Normal_palette_line_3+$1C).w
		move.w	#$E02,(Normal_palette_line_4+$1C).w

locret_29F0:
		rts
; ---------------------------------------------------------------------------

+ ;loc_29F2:
		subq.w	#1,(Palette_cycle_counters+$08).w
		bpl.s	locret_2A4E
		move.w	#0,(Palette_cycle_counters+$08).w
		move.w	(Palette_cycle_counters+$02).w,d0
		addq.w	#8,(Palette_cycle_counters+$02).w
		cmpi.w	#$78,(Palette_cycle_counters+$02).w
		blo.s	+ ;loc_2A14
		move.w	#0,(Palette_cycle_counters+$02).w

+ ;loc_2A14:
		lea	(AnPal_PalSlots_2).l,a0
		move.l	(a0,d0.w),(Normal_palette_line_3+$14).w
		move.l	4(a0,d0.w),(Normal_palette_line_3+$18).w
		move.w	(Palette_cycle_counters+$04).w,d0
		addq.w	#2,(Palette_cycle_counters+$04).w
		cmpi.w	#$C,(Palette_cycle_counters+$04).w
		blo.s	+ ;loc_2A3C
		move.w	#0,(Palette_cycle_counters+$04).w

+ ;loc_2A3C:
		lea	(AnPal_PalSlots_3).l,a0
		move.w	(a0,d0.w),(Normal_palette_line_3+$1C).w
		move.w	(a0,d0.w),(Normal_palette_line_4+$1C).w

locret_2A4E:
		rts
; ---------------------------------------------------------------------------

AnPal_LRZ3:
		tst.b	(Palette_cycle_counters+$00).w
		bmi.s	locret_2ABE
		subq.w	#1,(Palette_cycle_counter1).w
		bpl.s	++ ;loc_2A8A
		move.w	#$F,(Palette_cycle_counter1).w
		move.w	(Palette_cycle_counter0).w,d0
		addq.w	#8,(Palette_cycle_counter0).w
		cmpi.w	#$80,(Palette_cycle_counter0).w
		blo.s	+ ;loc_2A78
		move.w	#0,(Palette_cycle_counter0).w

+ ;loc_2A78:
		lea	(AnPal_PalLRZ12_1).l,a0
		move.l	(a0,d0.w),(Normal_palette_line_3+$2).w
		move.l	4(a0,d0.w),(Normal_palette_line_3+$6).w

+ ;loc_2A8A:
		tst.b	(Palette_cycle_counters+$00).w
		beq.s	locret_2ABE
		subq.w	#1,(Palette_cycle_counters+$08).w
		bpl.s	locret_2ABE
		move.w	#7,(Palette_cycle_counters+$08).w
		move.w	(Palette_cycle_counters+$04).w,d0
		addq.w	#4,(Palette_cycle_counters+$04).w
		cmpi.w	#$3C,(Palette_cycle_counters+$04).w
		blo.s	+ ;loc_2AB2
		move.w	#0,(Palette_cycle_counters+$04).w

+ ;loc_2AB2:
		lea	(AnPal_PalLRZ3).l,a0
		move.l	(a0,d0.w),(Normal_palette_line_4+$18).w

locret_2ABE:
		rts
; ---------------------------------------------------------------------------

AnPal_HPZ:
		tst.b	(Palette_cycle_counters+$00).w
		bne.s	locret_2AF4
		subq.w	#1,(Palette_cycle_counter1).w
		bpl.s	locret_2AF4
		move.w	#7,(Palette_cycle_counter1).w
		move.w	(Palette_cycle_counter0).w,d0
		addq.w	#4,(Palette_cycle_counter0).w
		cmpi.w	#$28,(Palette_cycle_counter0).w
		blo.s	+ ;loc_2AE8
		move.w	#0,(Palette_cycle_counter0).w

+ ;loc_2AE8:
		lea	(AnPal_PalHPZ).l,a0
		move.l	(a0,d0.w),(Normal_palette_line_4+$2).w

locret_2AF4:
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

AnPal_PalSOZ1:
		dc.w  $2CE, $6CE,  $AE,  $6C
		dc.w   $6C, $2CE, $6CE,  $AE
		dc.w   $AE,  $6C, $2CE, $6CE
		dc.w  $6CE,  $AE,  $6C, $2CE

		dc.w  $28A, $6AC,  $8A,  $48
		dc.w   $48, $28A, $6AC,  $8A
		dc.w   $8A,  $48, $28A, $6AC
		dc.w  $6AC,  $8A,  $48, $28A

		dc.w  $468, $668, $248,  $26
		dc.w   $26, $468, $668, $248
		dc.w  $248,  $26, $468, $668
		dc.w  $668, $248,  $26, $468

		dc.w  $424, $846, $224, $222
		dc.w  $222, $424, $846, $224
		dc.w  $224, $222, $424, $846
		dc.w  $846, $224, $222, $424

		dc.w  $602, $824, $402, $200
		dc.w  $200, $602, $824, $402
		dc.w  $402, $200, $602, $824
		dc.w  $824, $402, $200, $602

AnPal_PalSOZ2_Light:
		dc.w  $EEE, $8EE, $4EE,  $CE, $24C,    6,    0, $CEA, $886, $424,  $E0
AnPal_PalSOZ2_Light_2:
		dc.w  $EEE, $AEE, $6EE, $4AC,  $68,  $46,  $22, $8AA, $468, $224,    2, $28E, $4EE,  $8C,   $C
		dc.w  $8CE, $6CC, $4AC,  $8A, $248,    4,    0, $8A8, $664, $422,  $80
		dc.w  $CEE, $ACC, $6CC, $48A, $266,  $46,  $22, $ACC, $468, $224,    2, $28E, $6EE, $28C, $22C
		dc.w  $2CE, $28A, $268, $246, $224, $202,    0, $464, $222, $200,  $40
		dc.w  $ACE, $8AA, $688, $468, $244,  $24,  $22, $CCC, $468, $224,    2, $26C, $6EE, $28C, $24C
		dc.w  $88A, $668, $646, $424, $224, $202,    0, $444, $222, $200,  $40
		dc.w  $8CE, $888, $666, $446, $222,  $22,  $22, $EEE, $468, $224,    2, $26A, $6EE, $48C, $26C
		dc.w  $C46, $824, $804, $402, $202, $200,    0, $422, $402, $200,  $40
		dc.w  $6AE, $664, $422, $402, $200,    0,    0, $EEE, $466, $224,    0,  $46, $6EE, $48C, $26A

AnPal_PalLRZ12_1:
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

AnPal_PalLRZ12_2:
		dc.w  $224, $224
		dc.w  $224, $424
		dc.w  $224, $426
		dc.w  $426, $224
		dc.w  $424, $224
		dc.w  $224, $224
		dc.w  $224, $224

		dc.w  $224, $422
		dc.w  $422, $422

AnPal_PalLRZ1_3:
		dc.w  $624
		dc.w  $624
		dc.w  $624
		dc.w  $624
		dc.w  $624
		dc.w  $624
		dc.w  $626
		dc.w  $626
		dc.w  $826
		dc.w  $826
		dc.w  $826
		dc.w  $826
		dc.w  $826
		dc.w  $826
		dc.w  $826
		dc.w  $626
		dc.w  $626

AnPal_PalLRZ2_3:
		dc.w  $824, $C44, $E2A, $EAE
		dc.w  $824, $C44, $E2A, $EAE
		dc.w  $824, $C44, $E2A, $EAE
		dc.w  $824, $C44, $E48, $EAC
		dc.w  $822, $C44, $E66, $EAA
		dc.w  $822, $C44, $E66, $EAA
		dc.w  $822, $C44, $E66, $EAA
		dc.w  $842, $C64, $EA4, $EC6
		dc.w  $642, $A82, $CC2, $EE0
		dc.w  $642, $A82, $CC2, $EE0
		dc.w  $642, $A82, $CC2, $EE0
		dc.w  $642, $882, $AC2, $CE0
		dc.w  $642, $682, $8C2, $8E0
		dc.w  $642, $682, $8C2, $8E0
		dc.w  $642, $682, $8C2, $8E0
		dc.w  $642, $486, $4C8, $4E8
		dc.w  $442, $288, $2CA, $2EC
		dc.w  $442, $288, $2CC, $2EE
		dc.w  $442, $288, $2CA, $2EC
		dc.w  $642, $486, $4C8, $4E8
		dc.w  $642, $682, $8C2, $8E0
		dc.w  $642, $882, $AC2, $CE0
		dc.w  $642, $A82, $CC2, $EE0
		dc.w  $842, $C64, $EA4, $EC6
		dc.w  $822, $C44, $E66, $EAA
		dc.w  $824, $C44, $E48, $EAC
		dc.w  $824, $C44, $E2A, $EAE
		dc.w  $826, $C46, $E4A, $E8E
		dc.w  $624, $A48, $C6C, $E6E
		dc.w  $624, $A48, $C6C, $E6E
		dc.w  $624, $A48, $C6C, $E6E
		dc.w  $826, $C46, $E4A, $E8E

AnPal_PalDEZ12_1:
		dc.w   $E0,    0
		dc.w     0, $E0E
		dc.w  $E00,    0
		dc.w     0,  $EE
		dc.w    $E,    0
		dc.w     0, $EE0
		dc.w  $EE0,    0
		dc.w     0,   $E
		dc.w   $EE,    0
		dc.w     0, $E00
		dc.w  $E0E,    0
		dc.w     0,  $E0

AnPal_PalDEZ12_2:
		dc.w   $8E,  $6C,  $4A,  $28, $6AE
		dc.w  $28C, $26A,  $4A, $226, $4AC
		dc.w  $48A, $468, $248, $424, $4AA
		dc.w  $28C, $26A,  $4A, $226, $4AC

AnPal_PalDEZ1:
		dc.w  $8AC, $68A, $468, $246
		dc.w  $246, $8AC, $68A, $468
		dc.w  $468, $246, $8AC, $68A
		dc.w  $68A, $468, $246, $8AC
		dc.w  $468, $246, $8AC, $68A
		dc.w  $246, $8AC, $68A, $468

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

AnPal_PalSlots_1:
		dc.w   $46, $488, $2EE,  $8A
		dc.w   $68, $26A, $EEE,  $AC
		dc.w   $8A,  $46, $488, $2EE
		dc.w   $AC,  $68, $26A, $EEE
		dc.w  $2EE,  $8A,  $46, $488
		dc.w  $EEE,  $AC,  $68, $26A
		dc.w  $48A, $2EE,  $8A,  $46
		dc.w  $268, $EEE,  $AC,  $68

AnPal_PalSlots_2:
		dc.w  $268, $EEE,  $AC,  $68
		dc.w  $EEE, $EEE, $EEE, $EEE
		dc.w  $48A, $2EE,  $8A,  $46
		dc.w   $EE,  $EE,  $EE,  $EE
		dc.w  $EEE,  $AC,  $68, $26A
		dc.w  $EEE, $EEE, $EEE, $EEE
		dc.w  $2EE,  $8A,  $46, $488
		dc.w  $E0E, $E0E, $E0E, $E0E
		dc.w   $AC,  $68, $26A, $EEE
		dc.w  $EEE, $EEE, $EEE, $EEE
		dc.w   $8A,  $46, $488, $2EE
		dc.w  $EE0, $EE0, $EE0, $EE0
		dc.w   $68, $26A, $EEE,  $AC
		dc.w  $EEE, $EEE, $EEE, $EEE
		dc.w   $46, $488, $2EE,  $8A
		dc.w   $E0,  $E0,  $E0,  $E0

AnPal_PalSlots_3:
		dc.w  $E02
		dc.w  $E24
		dc.w  $E46
		dc.w  $E68
		dc.w  $E8A
		dc.w  $EAC

AnPal_PalLRZ3:
		dc.w  $424,  $AE
		dc.w  $424,  $AE
		dc.w  $424,  $AE
		dc.w  $426,  $8E
		dc.w  $428,  $6E
		dc.w  $42A,  $4E
		dc.w  $42C,  $2E
		dc.w  $42E,   $E
		dc.w  $42E,   $E
		dc.w  $42E,   $E
		dc.w  $42C,  $2E
		dc.w  $42A,  $4E
		dc.w  $428,  $6E
		dc.w  $426,  $8E
		dc.w  $424,  $AE

AnPal_PalHPZ:
		dc.w    $E,   $A
		dc.w    $E,   $A
		dc.w    $E,   $A
		dc.w    $E,   $A
		dc.w    $C,    8
		dc.w    $A,    6
		dc.w     8,    4
		dc.w     8,    4
		dc.w    $A,    6
		dc.w    $C,    8

; =============== S U B R O U T I N E =======================================


SuperHyper_PalCycle:
		move.b	(Super_palette_status).w,d0	; 0 = off | 1 = fading | -1 = fading done
		beq.w	locret_37EC			; return, if player isn't super
		bmi.w	SuperHyper_PalCycle_Normal	; branch, if fade-in is done
		subq.b	#1,d0
		bne.w	SuperHyper_PalCycle_Revert	; branch for values greater than 1

		; fade from Sonic's to Super Sonic's palette
		; run frame timer
		subq.b	#1,(Palette_timer).w
		bpl.w	locret_37EC
		move.b	#1,(Palette_timer).w

		; Tails and Knuckles only
		; Only Sonic has a fade-in; Tails and Knuckles just *pop* into their normal Super/Hyper palette cycle
		cmpi.w	#2,(Player_mode).w
		blo.s	SuperHyper_PalCycle_FadeIn
		move.b	#-1,(Super_palette_status).w	; -1 = fading done
		move.w	#0,(Palette_frame).w			; Used by Knuckles and Tails' Super Flickies
		move.b	#0,(Palette_frame_Tails).w		; Used by Tails
		move.b	#0,(Player_1+object_control).w		; restore Player's movement
		rts
; ---------------------------------------------------------------------------

SuperHyper_PalCycle_FadeIn:
		; increment palette frame and update Sonic's palette
		lea	(PalCycle_SuperSonic).l,a0
		move.w	(Palette_frame).w,d0
		addq.w	#6,(Palette_frame).w			; 1 palette entry = 1 word, Sonic uses 3 shades of blue
		cmpi.w	#$24,(Palette_frame).w			; has palette cycle reached the 6th frame?
		blo.s	SuperHyper_PalCycle_SonicApply		; if not, branch
		move.b	#-1,(Super_palette_status).w	; mark fade-in as done
		move.b	#0,(Player_1+object_control).w		; restore Sonic's movement

SuperHyper_PalCycle_SonicApply:
		lea	(Normal_palette+$04).w,a1
		move.l	(a0,d0.w),(a1)+	; Write first two palette entries
		move.w	4(a0,d0.w),(a1)	; Write last palette entry

		tst.b	(Water_flag).w
		beq.s	locret_37EC
		lea	(PalCycle_SuperSonicUnderwaterAIZICZ).l,a0	; Load underwater fade-in palette
		tst.b	(Current_zone).w				; Is Sonic in Angel Island Zone?
		beq.s	SuperHyper_PalCycle_ApplyUnderwater		; If so, branch
		cmpi.b	#5,(Current_zone).w				; Is Sonic in IceCap Zone?
		beq.s	SuperHyper_PalCycle_ApplyUnderwater		; If so, branch
		lea	(PalCycle_SuperSonicUnderwaterHCZCNZLBZ).l,a0	; Load alternate underwater fade-in palette

SuperHyper_PalCycle_ApplyUnderwater:
		lea	(Water_palette+$04).w,a1
		move.l	(a0,d0.w),(a1)+	; Write first two palette entries
		move.w	4(a0,d0.w),(a1)	; Write last palette entry

locret_37EC:
		rts
; ---------------------------------------------------------------------------

SuperHyper_PalCycle_Revert:	; runs the fade in transition backwards
		cmpi.w	#2,(Player_mode).w	; If Tails or Knuckles, branch, making this code Sonic-specific
		bhs.s	SuperHyper_PalCycle_RevertNotSonic

		; run frame timer
		subq.b	#1,(Palette_timer).w
		bpl.s	locret_37EC
		move.b	#3,(Palette_timer).w

		; decrement palette frame and update Sonic's palette
		lea	(PalCycle_SuperSonic).l,a0
		move.w	(Palette_frame).w,d0
		subq.w	#6,(Palette_frame).w	; previous frame
		bhs.s	+ ;loc_381E		; branch, if it isn't the first frame
		; Bug: this only clears the high byte of Palette_frame, causing subsequent
		; fade-ins to pull color values from PalCycle_SuperTails
		move.b	#0,(Palette_frame).w
		move.b	#0,(Super_palette_status).w	; 0 = off

+ ;loc_381E:
		bra.s	SuperHyper_PalCycle_SonicApply
; ---------------------------------------------------------------------------

SuperHyper_PalCycle_RevertNotSonic:
		moveq	#0,d0
		move.w	d0,(Palette_frame).w
		move.b	d0,(Super_palette_status).w	; 0 = off
		move.b	d0,(Palette_frame_Tails).w
		cmpi.w	#3,(Player_mode).w			; If Knuckles, branch, making this code Tails-specific
		bhs.s	SuperHyper_PalCycle_RevertKnuckles

		lea	(PalCycle_SuperTails).l,a0		; Used here because the first set of colours is Tails' normal palette
		bsr.w	SuperHyper_PalCycle_ApplyTails
		lea	(PalCycle_SuperSonic).l,a0		; Why does Tails manipulate Sonic's palette? For his Super-form's Super Flickies
		bra.w	SuperHyper_PalCycle_Apply
; ---------------------------------------------------------------------------

SuperHyper_PalCycle_RevertKnuckles:
		lea	(PalCycle_SuperHyperKnucklesRevert).l,a0
		bra.w	SuperHyper_PalCycle_Apply
; ---------------------------------------------------------------------------

SuperHyper_PalCycle_Normal:
		cmpi.w	#2,(Player_mode).w		; If Tails...
		beq.w	SuperHyper_PalCycle_NormalTails
		cmpi.w	#3,(Player_mode).w		; ...or Knuckles, branch, making this code Sonic-specific
		beq.w	SuperHyper_PalCycle_NormalKnuckles
		tst.b	(Super_Sonic_Knux_flag).w	; If Hyper Sonic, branch
		bmi.s	SuperHyper_PalCycle_HyperSonic

SuperHyper_PalCycle_SuperSonic:	; Tails' code falls back here so the Super Flickies' palette can update
		; run frame timer
		subq.b	#1,(Palette_timer).w
		bpl.w	locret_37EC
		move.b	#6,(Palette_timer).w

		; increment palette frame and update Sonic's palette
		lea	(PalCycle_SuperSonic).l,a0
		move.w	(Palette_frame).w,d0
		addq.w	#6,(Palette_frame).w	; next frame
		cmpi.w	#$36,(Palette_frame).w	; is it the last frame?
		blo.s	+ ;loc_3898		; if not, branch
		move.w	#$24,(Palette_frame).w	; reset frame counter (Super Sonic's normal palette cycle starts at $24. Everything before that is for the palette fade)

+ ;loc_3898:
		bra.w	SuperHyper_PalCycle_SonicApply
; ---------------------------------------------------------------------------

SuperHyper_PalCycle_HyperSonic:
		; run frame timer
		subq.b	#1,(Palette_timer).w
		bpl.w	locret_37EC
		move.b	#4,(Palette_timer).w

		; increment palette frame and update Sonic's palette
		lea	(PalCycle_HyperSonic).l,a0
		move.w	(Palette_frame).w,d0
		addq.w	#6,(Palette_frame).w			; next frame
		cmpi.w	#$48,(Palette_frame).w			; is it the last frame?
		blo.s	SuperHyper_PalCycle_HyperSonicApply	; if not, branch
		move.w	#0,(Palette_frame).w			; reset frame counter

SuperHyper_PalCycle_HyperSonicApply:
		; Redundant. SuperHyper_PalCycle_Apply does the exact same thing
		; and other areas of code do branch to it instead of duplicating the code as seen here
		lea	(Normal_palette+$4).w,a1
		move.l	(a0,d0.w),(a1)+	; Write first two palette entries
		move.w	4(a0,d0.w),(a1)	; Write last palette entry
		tst.b	(Water_flag).w
		beq.w	locret_37EC
		lea	(Water_palette+$4).w,a1
		move.l	(a0,d0.w),(a1)+	; Write first two palette entries
		move.w	4(a0,d0.w),(a1)	; Write last palette entry
		rts
; ---------------------------------------------------------------------------

SuperHyper_PalCycle_NormalTails:
		; run frame timer
		subq.b	#1,(Palette_timer_Tails).w
		bpl.w	SuperHyper_PalCycle_SuperSonic
		move.b	#$B,(Palette_timer_Tails).w

		; increment palette frame and update Tails' palette
		lea	(PalCycle_SuperTails).l,a0
		moveq	#0,d0
		move.b	(Palette_frame_Tails).w,d0
		addq.b	#6,(Palette_frame_Tails).w	; next frame
		cmpi.b	#$24,(Palette_frame_Tails).w	; is it the last frame?
		blo.s	SuperHyper_PalCycle_ApplyTails	; if not, branch
		move.b	#0,(Palette_frame_Tails).w	; reset frame counter
		; go straight to SuperHyper_PalCycle_ApplyTails...
; End of function SuperHyper_PalCycle


; =============== S U B R O U T I N E =======================================


SuperHyper_PalCycle_ApplyTails:
		; Tails gets his own because of the unique location of his palette entries
		lea	(Normal_palette+$10).w,a1
		move.l	(a0,d0.w),(a1)+		; Write first two palette entries
		move.w	4(a0,d0.w),2(a1)	; Write last palette entry
		tst.b	(Water_flag).w
		beq.w	SuperHyper_PalCycle_SuperSonic
		lea	(Water_palette+$10).w,a1
		move.l	(a0,d0.w),(a1)+		; Write first two palette entries
		move.w	4(a0,d0.w),2(a1)	; Write last palette entry
		bra.w	SuperHyper_PalCycle_SuperSonic
; End of function SuperHyper_PalCycle_ApplyTails

; ---------------------------------------------------------------------------

SuperHyper_PalCycle_NormalKnuckles:
		; run frame timer
		subq.b	#1,(Palette_timer).w
		bpl.w	locret_37EC
		move.b	#2,(Palette_timer).w

		; increment palette frame and update Knuckles' palette
		lea	(PalCycle_SuperHyperKnuckles).l,a0
		move.w	(Palette_frame).w,d0
		addq.w	#6,(Palette_frame).w			; next frame
		cmpi.w	#$3C,(Palette_frame).w			; is it the last frame?
		blo.s	SuperHyper_PalCycle_Apply		; if not, branch
		move.w	#0,(Palette_frame).w			; reset frame counter
		move.b	#$E,(Palette_timer).w

SuperHyper_PalCycle_Apply:
		lea	(Normal_palette+$4).w,a1
		move.l	(a0,d0.w),(a1)+	; Write first two palette entries
		move.w	4(a0,d0.w),(a1)	; Write last palette entry
		tst.b	(Water_flag).w
		beq.w	locret_37EC
		lea	(Water_palette+$4).w,a1
		move.l	(a0,d0.w),(a1)+	; Write first two palette entries
		move.w	4(a0,d0.w),(a1)	; Write last palette entry
		rts
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
PalCycle_HyperSonic:
		dc.w $EEC,$ECA,$EA8
		dc.w $EEE,$EEE,$EEE
		dc.w $CEC,$AEA,$2E0
		dc.w $EEE,$EEE,$EEE
		dc.w $AEC,$4EC,$0CC
		dc.w $EEE,$EEE,$EEE
		dc.w $CEE,$8EE,$4CE
		dc.w $EEE,$EEE,$EEE
		dc.w $EEE,$CCE,$AAE
		dc.w $EEE,$EEE,$EEE
		dc.w $EEE,$ECE,$CAC
		dc.w $EEE,$EEE,$EEE
PalCycle_SuperTails:
		dc.w $0AE,$08E,$46A
		dc.w $4CE,$2AE,$46A
		dc.w $8CE,$4CE,$46C
		dc.w $AEE,$8CE,$48E
		dc.w $8CE,$4CE,$46C
		dc.w $4CE,$2AE,$46A
PalCycle_SuperHyperKnuckles:
		dc.w $A6E,$64E,$428
		dc.w $C8E,$86E,$64A
		dc.w $EAE,$A8E,$86C
		dc.w $ECE,$CAE,$A8E
		dc.w $EEE,$ECE,$CAE
		dc.w $ECE,$CAE,$A8E
		dc.w $EAE,$A8E,$86C
		dc.w $C8E,$86E,$64A
		dc.w $A6E,$64E,$428
		dc.w $84E,$40C,$206
PalCycle_SuperHyperKnucklesRevert:
		dc.w $64E,$20C,$206

; =============== S U B R O U T I N E =======================================


Pal_FadeFromBlack:
		move.w	#$40-1,(Palette_fade_info).w
		jsr	Pal_FillBlack(pc)
		move.w	#$15,d4

- ;loc_3AFE:
		move.b	#$12,(V_int_routine).w
		bsr.w	Wait_VSync
		bsr.s	Pal_FromBlack
		bsr.w	Process_Nem_Queue_Init
		dbf	d4,- ;loc_3AFE
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

- ;loc_3B2A:
		bsr.s	Pal_AddColor
		dbf	d0,- ;loc_3B2A
		tst.b	(Water_flag).w
		beq.s	locret_3B52
		moveq	#0,d0
		lea	(Water_palette).w,a0
		lea	(Target_water_palette).w,a1
		move.b	(Palette_fade_info).w,d0
		adda.w	d0,a0
		adda.w	d0,a1
		move.b	(Palette_fade_count).w,d0

- ;loc_3B4C:
		bsr.s	Pal_AddColor
		dbf	d0,- ;loc_3B4C

locret_3B52:
		rts
; End of function Pal_FromBlack


; =============== S U B R O U T I N E =======================================


Pal_AddColor:
		move.w	(a1)+,d2
		move.w	(a0),d3
		cmp.w	d2,d3
		beq.s	+++ ;loc_3B7C
		move.w	d3,d1
		addi.w	#$200,d1
		cmp.w	d2,d1
		bhi.s	+ ;loc_3B6A
		move.w	d1,(a0)+
		rts
; ---------------------------------------------------------------------------

+ ;loc_3B6A:
		move.w	d3,d1
		addi.w	#$20,d1
		cmp.w	d2,d1
		bhi.s	+ ;loc_3B78
		move.w	d1,(a0)+
		rts
; ---------------------------------------------------------------------------

+ ;loc_3B78:
		addq.w	#2,(a0)+
		rts
; ---------------------------------------------------------------------------

+ ;loc_3B7C:
		addq.w	#2,a0
		rts
; End of function Pal_AddColor


; =============== S U B R O U T I N E =======================================


Pal_FillBlack:
		cmpi.w	#$D01,(Current_zone_and_act).w
		beq.w	Pal_FillWhite
		cmpi.w	#$1701,(Current_zone_and_act).w
		beq.w	Pal_FillWhite				; If one of either Sky Sanctuary Knuckles level or the Super Emerald special stage arena, branch
		moveq	#0,d0
		lea	(Normal_palette).w,a0
		move.b	(Palette_fade_info).w,d0
		adda.w	d0,a0
		moveq	#0,d1
		move.b	(Palette_fade_count).w,d0

- ;loc_3BA6:
		move.w	d1,(a0)+
		tst.b	(Water_flag).w
		beq.s	+ ;loc_3BB2
		move.w	d1,(Water_palette-Normal_palette)-2(a0)

+ ;loc_3BB2:
		dbf	d0,- ;loc_3BA6
		rts
; End of function Pal_FillBlack


; =============== S U B R O U T I N E =======================================


Animate_Palette:
		tst.w	(Palette_fade_timer).w
		bmi.s	locret_3BE2
		beq.s	+ ;loc_3BDC
		subq.w	#1,(Palette_fade_timer).w
		cmpi.w	#$D01,(Current_zone_and_act).w
		beq.w	Pal_FromWhite
		cmpi.w	#$1701,(Current_zone_and_act).w
		beq.w	Pal_FromWhite
		bra.w	Pal_FromBlack
; ---------------------------------------------------------------------------

+ ;loc_3BDC:
		jmp	(AnPal_Load).l
; ---------------------------------------------------------------------------

locret_3BE2:
		rts
; End of function Animate_Palette


; =============== S U B R O U T I N E =======================================


Pal_FadeToBlack:
		move.w	#$40-1,(Palette_fade_info).w
		move.w	#$15,d4

- ;loc_3BEE:
		move.b	#$12,(V_int_routine).w
		bsr.w	Wait_VSync
		bsr.s	Pal_ToBlack
		bsr.w	Process_Nem_Queue_Init
		dbf	d4,- ;loc_3BEE
		rts
; End of function Pal_FadeToBlack


; =============== S U B R O U T I N E =======================================


Pal_ToBlack:
		moveq	#0,d0
		lea	(Normal_palette).w,a0
		move.b	(Palette_fade_info).w,d0
		adda.w	d0,a0
		move.b	(Palette_fade_count).w,d0

- ;loc_3C14:
		bsr.s	Pal_DecColor
		dbf	d0,- ;loc_3C14
		moveq	#0,d0
		lea	(Water_palette).w,a0
		move.b	(Palette_fade_info).w,d0
		adda.w	d0,a0
		move.b	(Palette_fade_count).w,d0

- ;loc_3C2A:
		bsr.s	Pal_DecColor
		dbf	d0,- ;loc_3C2A
		rts
; End of function Pal_ToBlack


; =============== S U B R O U T I N E =======================================


Pal_DecColor:
		move.w	(a0),d2
		beq.s	+++ ;loc_3C5E
		move.w	d2,d1
		andi.w	#$E,d1
		beq.s	+ ;loc_3C42
		subq.w	#2,(a0)+
		rts
; ---------------------------------------------------------------------------

+ ;loc_3C42:
		move.w	d2,d1
		andi.w	#$E0,d1
		beq.s	+ ;loc_3C50
		subi.w	#$20,(a0)+
		rts
; ---------------------------------------------------------------------------

+ ;loc_3C50:
		move.w	d2,d1
		andi.w	#$E00,d1
		beq.s	+ ;loc_3C5E
		subi.w	#$200,(a0)+
		rts
; ---------------------------------------------------------------------------

+ ;loc_3C5E:
		addq.w	#2,a0
		rts
; End of function Pal_DecColor


; =============== S U B R O U T I N E =======================================


Pal_FillWhite:
		moveq	#0,d0
		lea	(Normal_palette).w,a0
		move.b	(Palette_fade_info).w,d0
		adda.w	d0,a0
		move.w	#$EEE,d1
		move.b	(Palette_fade_count).w,d0

- ;loc_3C76:
		move.w	d1,(a0)+
		dbf	d0,- ;loc_3C76
		clr.w	(Pal_fade_delay2).w
		rts
; End of function Pal_FillWhite


; =============== S U B R O U T I N E =======================================


Pal_FadeFromWhite:
		move.w	#$40-1,(Palette_fade_info).w
		bsr.s	Pal_FillWhite
		move.w	#$15,d4

- ;loc_3C8E:
		move.b	#$12,(V_int_routine).w
		bsr.w	Wait_VSync
		bsr.s	Pal_FromWhite
		bsr.w	Process_Nem_Queue_Init
		dbf	d4,- ;loc_3C8E
		rts
; End of function Pal_FadeFromWhite


; =============== S U B R O U T I N E =======================================


Pal_FromWhite:
		subq.w	#1,(Pal_fade_delay2).w
		bpl.s	locret_3CEE
		move.w	#2,(Pal_fade_delay2).w
		moveq	#0,d0
		lea	(Normal_palette).w,a0
		lea	(Target_palette).w,a1
		move.b	(Palette_fade_info).w,d0
		adda.w	d0,a0
		adda.w	d0,a1
		move.b	(Palette_fade_count).w,d0

- ;loc_3CC6:
		bsr.s	Pal_DecColor2
		dbf	d0,- ;loc_3CC6
		tst.b	(Water_flag).w
		beq.s	locret_3CEE
		moveq	#0,d0
		lea	(Water_palette).w,a0
		lea	(Target_water_palette).w,a1
		move.b	(Palette_fade_info).w,d0
		adda.w	d0,a0
		adda.w	d0,a1
		move.b	(Palette_fade_count).w,d0

- ;loc_3CE8:
		bsr.s	Pal_DecColor2
		dbf	d0,- ;loc_3CE8

locret_3CEE:
		rts
; End of function Pal_FromWhite


; =============== S U B R O U T I N E =======================================


Pal_DecColor2:
		move.b	(a1)+,d2
		andi.b	#$E,d2
		move.b	(a0),d3
		andi.b	#$E,d3
		cmp.b	d2,d3
		bls.s	+ ;loc_3D02
		subq.b	#2,d3

+ ;loc_3D02:
		move.b	d3,(a0)+
		move.b	(a1)+,d1
		move.b	d1,d2
		andi.b	#$E0,d1
		move.b	(a0),d3
		move.b	d3,d5
		andi.b	#$E0,d3
		cmp.b	d1,d3
		bls.s	+ ;loc_3D1C
		subi.b	#$20,d3

+ ;loc_3D1C:
		andi.b	#$E,d2
		andi.b	#$E,d5
		cmp.b	d2,d5
		bls.s	+ ;loc_3D2A
		subq.b	#2,d5

+ ;loc_3D2A:
		or.b	d5,d3
		move.b	d3,(a0)+
		rts
; End of function Pal_DecColor2


; =============== S U B R O U T I N E =======================================


Pal_FadeToWhite:
		move.w	#$40-1,(Palette_fade_info).w
		move.w	#$15,d4

- ;loc_3D3A:
		move.b	#$12,(V_int_routine).w
		bsr.w	Wait_VSync
		bsr.s	Pal_ToWhite
		bsr.w	Process_Nem_Queue_Init
		dbf	d4,- ;loc_3D3A
		rts
; End of function Pal_FadeToWhite


; =============== S U B R O U T I N E =======================================


Pal_ToWhite:
		moveq	#0,d0
		lea	(Normal_palette).w,a0
		move.b	(Palette_fade_info).w,d0
		adda.w	d0,a0
		move.b	(Palette_fade_count).w,d0

- ;loc_3D60:
		bsr.s	Pal_AddColor2
		dbf	d0,- ;loc_3D60
		moveq	#0,d0
		lea	(Water_palette).w,a0
		move.b	(Palette_fade_info).w,d0
		adda.w	d0,a0
		move.b	(Palette_fade_count).w,d0

- ;loc_3D76:
		bsr.s	Pal_AddColor2
		dbf	d0,- ;loc_3D76
		rts
; End of function Pal_ToWhite


; =============== S U B R O U T I N E =======================================


Pal_AddColor2:
		move.w	(a0),d2
		cmpi.w	#$EEE,d2
		beq.s	+++ ;loc_3DBA
		move.w	d2,d1
		andi.w	#$E,d1
		cmpi.w	#$E,d1
		beq.s	+ ;loc_3D96
		addq.w	#2,(a0)+
		rts
; ---------------------------------------------------------------------------

+ ;loc_3D96:
		move.w	d2,d1
		andi.w	#$E0,d1
		cmpi.w	#$E0,d1
		beq.s	+ ;loc_3DA8
		addi.w	#$20,(a0)+
		rts
; ---------------------------------------------------------------------------

+ ;loc_3DA8:
		move.w	d2,d1
		andi.w	#$E00,d1
		cmpi.w	#$E00,d1
		beq.s	+ ;loc_3DBA
		addi.w	#$200,(a0)+
		rts
; ---------------------------------------------------------------------------

+ ;loc_3DBA:
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

- ;.loop:
		move.l	(a2)+,(a3)+
		dbf	d7,- ;.loop
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

- ;.loop:
		move.l	(a2)+,(a3)+
		dbf	d7,- ;.loop
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

- ;.loop:
		move.l	(a2)+,(a3)+
		dbf	d7,- ;.loop
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

- ;.loop:
		move.l	(a2)+,(a3)+
		dbf	d7,- ;.loop
		rts
; End of function LoadPalette2_Immediate

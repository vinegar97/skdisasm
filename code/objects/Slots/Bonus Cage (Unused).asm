loc_4BF62:
		move.w	#$460,x_pos(a0)
		move.w	#$430,y_pos(a0)
		move.l	#Map_SlotBonusCage,mappings(a0)
		move.w	#make_art_tile($481,0,0),art_tile(a0)
		ori.b	#4,render_flags(a0)
		move.b	#$18,width_pixels(a0)
		move.b	#$10,height_pixels(a0)
		move.w	#$80,priority(a0)
		move.l	#loc_4BF9A,(a0)

loc_4BF9A:
		move.b	(Stat_table).w,d0
		andi.b	#$FC,d0
		jsr	(GetSineCosine).l
		lea	(Player_1).w,a1
		move.w	#$460,d2
		sub.w	x_pos(a1),d2
		move.w	d2,d4
		move.w	#$430,d3
		sub.w	y_pos(a1),d3
		move.w	d3,d5
		muls.w	d0,d4
		muls.w	d0,d5
		muls.w	d1,d2
		muls.w	d1,d3
		add.l	d4,d3
		asr.l	#8,d3
		sub.l	d5,d2
		asr.l	#8,d2
		add.w	x_pos(a1),d2
		add.w	y_pos(a1),d3
		move.w	d2,x_pos(a0)
		move.w	d3,y_pos(a0)
		move.w	d2,(Events_bg+$00).w
		move.w	d3,(Events_bg+$02).w
		lea	$34(a0),a2
		lea	(Player_1).w,a1
		bsr.w	+ ;sub_4C014
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	locret_4C012
		move.b	#1,anim_frame_timer(a0)
		addq.b	#1,mapping_frame(a0)
		cmpi.b	#6,mapping_frame(a0)
		blo.s	locret_4C012
		move.b	#0,mapping_frame(a0)

locret_4C012:
		rts

; =============== S U B R O U T I N E =======================================


+ ;sub_4C014:
		move.w	(a2),d0
		move.w	off_4C01E(pc,d0.w),d0
		jmp	off_4C01E(pc,d0.w)
; End of function sub_4C014

; ---------------------------------------------------------------------------
off_4C01E:
		dc.w loc_4C026-off_4C01E
		dc.w loc_4C21C-off_4C01E
		dc.w loc_4C250-off_4C01E
		dc.w loc_4C292-off_4C01E
; ---------------------------------------------------------------------------

loc_4C026:
		tst.b	object_control(a1)
		bne.s	locret_4C0A8
		tst.w	(SStage_scalar_result_0).w
		bne.s	locret_4C0A8
		move.w	x_pos(a1),d0
		sub.w	x_pos(a0),d0
		addi.w	#$18,d0
		cmpi.w	#$30,d0
		bhs.s	locret_4C0A8
		move.w	y_pos(a1),d0
		sub.w	y_pos(a0),d0
		addi.w	#$18,d0
		cmpi.w	#$30,d0
		bhs.s	locret_4C0A8
		move.w	#$460,x_pos(a1)
		move.w	#$430,y_pos(a1)
		move.w	#0,x_vel(a1)
		move.w	#0,y_vel(a1)
		move.w	#0,ground_vel(a1)
		move.b	#$81,object_control(a1)
		addq.w	#2,(a2)+
		move.w	#$78,(a2)
		move.w	a1,$42(a0)
		move.b	#1,(Palette_cycle_counters+$00).w
		cmpi.b	#$18,(SStage_scalar_result_0+2).w
		bne.s	locret_4C0A8
		move.b	#8,(SStage_scalar_result_0+2).w
		clr.w	$32(a0)
		move.w	#-1,(SStage_scalar_result_0).w
		move.w	#-1,$2E(a0)

locret_4C0A8:
		rts
; ---------------------------------------------------------------------------

loc_4C0AA:
		move.w	(SStage_scalar_result_1+2).w,d0
		bpl.w	loc_4C172
		tst.w	$2E(a0)
		bpl.s	+ ;loc_4C0BE
		move.w	#$64,$2E(a0)

+ ;loc_4C0BE:
		tst.w	$2E(a0)
		beq.w	+ ;loc_4C164
		btst	#0,(Level_frame_counter+1).w
		beq.w	++ ;loc_4C16C
		cmpi.w	#$10,$30(a0)
		bhs.w	++ ;loc_4C16C
		jsr	(AllocateObject).l
		bne.w	++ ;loc_4C16C
		move.l	#Obj_SlotSpike,(a1)
		move.l	#Map_SlotSpike,mappings(a1)
		move.w	#make_art_tile($490,1,0),art_tile(a1)
		move.b	#4,render_flags(a1)
		move.b	#$10,width_pixels(a1)
		move.w	#$200,priority(a1)
		move.w	#$1E,$40(a1)
		move.w	$32(a0),$32(a1)
		addi.w	#$90,$32(a0)
		move.w	x_pos(a0),$3C(a1)
		move.w	y_pos(a0),$3E(a1)
		move.w	$32(a1),d0
		jsr	(GetSineCosine).l
		asr.w	#1,d1
		add.w	$3C(a1),d1
		move.w	d1,$34(a1)
		move.w	d1,x_pos(a1)
		asr.w	#1,d0
		add.w	$3E(a1),d0
		move.w	d0,$38(a1)
		move.w	d0,y_pos(a1)
		lea	$30(a0),a2
		move.l	a2,$2E(a1)
		move.w	$42(a0),$42(a1)
		addq.w	#1,$30(a0)
		subq.w	#1,$2E(a0)

+ ;loc_4C164:
		tst.w	$30(a0)
		beq.w	+++ ;loc_4C23E

+ ;loc_4C16C:
		addq.w	#1,(SStage_scalar_index_2).w
		rts
; ---------------------------------------------------------------------------

loc_4C172:
		beq.w	+ ;loc_4C214
		btst	#0,(Level_frame_counter+1).w
		beq.w	locret_4C21A
		cmpi.w	#$10,$30(a0)
		bhs.w	locret_4C21A
		jsr	(AllocateObject).l
		bne.w	locret_4C21A
		move.l	#Obj_SlotRing,(a1)
		move.l	#Map_Ring,mappings(a1)
		move.w	#make_art_tile(ArtTile_Ring,1,0),art_tile(a1)
		move.b	#4,render_flags(a1)
		move.w	#$180,priority(a1)
		move.b	#8,width_pixels(a1)
		move.w	#$1A,$40(a1)
		move.w	$32(a0),$32(a1)
		addi.w	#$89,$32(a0)
		move.w	x_pos(a0),$3C(a1)
		move.w	y_pos(a0),$3E(a1)
		move.w	$32(a1),d0
		jsr	(GetSineCosine).l
		asr.w	#1,d1
		add.w	$3C(a1),d1
		move.w	d1,$34(a1)
		move.w	d1,x_pos(a1)
		asr.w	#1,d0
		add.w	$3E(a1),d0
		move.w	d0,$38(a1)
		move.w	d0,y_pos(a1)
		lea	$30(a0),a2
		move.l	a2,$2E(a1)
		move.w	$42(a0),$42(a1)
		addq.w	#1,$30(a0)
		subq.w	#1,(SStage_scalar_result_1+2).w

+ ;loc_4C214:
		tst.w	$30(a0)
		beq.s	+ ;loc_4C23E

locret_4C21A:
		rts
; ---------------------------------------------------------------------------

loc_4C21C:
		move.w	a1,$42(a0)
		cmpi.b	#$18,(SStage_scalar_result_0+2).w
		beq.w	loc_4C0AA
		move.b	(V_int_run_count+3).w,d0
		andi.w	#$F,d0
		bne.s	locret_4C23C
		moveq	#signextendB(sfx_SlotMachine),d0
		jsr	(Play_SFX).l

locret_4C23C:
		rts
; ---------------------------------------------------------------------------

+ ;loc_4C23E:
		move.w	#0,$30(a0)
		addq.w	#2,(a2)+
		move.w	#8,(a2)
		clr.b	(Palette_cycle_counters+$00).w
		rts
; ---------------------------------------------------------------------------

loc_4C250:
		move.b	(Stat_table).w,d0
		andi.w	#$3C,d0
		bne.s	locret_4C290
		move.b	(Stat_table).w,d0
		andi.b	#$FC,d0
		jsr	(GetSineCosine).l
		asl.w	#2,d0
		asl.w	#2,d1
		move.w	d0,x_vel(a1)
		move.w	d1,y_vel(a1)
		move.b	#0,object_control(a1)
		bclr	#Status_OnObj,status(a1)
		bset	#Status_InAir,status(a1)
		neg.w	(SStage_scalar_index_1).w
		addq.w	#2,(a2)+
		move.w	#8,(a2)

locret_4C290:
		rts
; ---------------------------------------------------------------------------

loc_4C292:
		subq.w	#1,2(a2)
		bpl.s	locret_4C29E
		clr.w	(a2)
		clr.w	(SStage_scalar_result_0).w

locret_4C29E:
		rts
; ---------------------------------------------------------------------------
Map_SlotBonusCage:
		include "Levels/Slots/Misc Object Data/Map - Bonus Cage (Unused).asm"
; ---------------------------------------------------------------------------

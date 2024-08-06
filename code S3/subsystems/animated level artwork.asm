; =============== S U B R O U T I N E =======================================


Animate_Tiles:
		moveq	#0,d0
		move.w	(Current_zone_and_act).w,d0
		ror.b	#1,d0
		lsr.w	#5,d0
		andi.w	#$FC,d0
		move.w	Offs_AniPLC(pc,d0.w),d1
		lea	Offs_AniFunc(pc,d1.w),a2
		move.w	Offs_AniFunc(pc,d0.w),d0
		jmp	Offs_AniFunc(pc,d0.w)
; End of function Animate_Tiles

; ---------------------------------------------------------------------------
		rts
; ---------------------------------------------------------------------------
Offs_AniFunc:	dc.w AnimateTiles_AIZ1-Offs_AniFunc
Offs_AniPLC:	dc.w AniPLC_AIZ1-Offs_AniFunc
		dc.w AnimateTiles_AIZ2-Offs_AniFunc
		dc.w AniPLC_AIZ2-Offs_AniFunc
		dc.w AnimateTiles_HCZ1-Offs_AniFunc
		dc.w AniPLC_HCZ1-Offs_AniFunc
		dc.w AnimateTiles_HCZ2-Offs_AniFunc
		dc.w AniPLC_HCZ2-Offs_AniFunc
		dc.w AnimateTiles_MGZ-Offs_AniFunc
		dc.w AniPLC_MGZ-Offs_AniFunc
		dc.w AnimateTiles_MGZ-Offs_AniFunc
		dc.w AniPLC_MGZ-Offs_AniFunc
		dc.w AnimateTiles_CNZ-Offs_AniFunc
		dc.w AniPLC_CNZ-Offs_AniFunc
		dc.w AnimateTiles_CNZ-Offs_AniFunc
		dc.w AniPLC_CNZ-Offs_AniFunc
		dc.w AnimateTiles_NULL-Offs_AniFunc
		dc.w AniPLC_ICZ-Offs_AniFunc
		dc.w AnimateTiles_NULL-Offs_AniFunc
		dc.w AniPLC_ICZ-Offs_AniFunc
		dc.w AnimateTiles_ICZ-Offs_AniFunc
		dc.w AniPLC_ICZ-Offs_AniFunc
		dc.w AnimateTiles_ICZ-Offs_AniFunc
		dc.w AniPLC_ICZ-Offs_AniFunc
		dc.w AnimateTiles_LBZ1-Offs_AniFunc
		dc.w AniPLC_LBZ1-Offs_AniFunc
		dc.w AnimateTiles_LBZ2-Offs_AniFunc
		dc.w AniPLC_LBZ2-Offs_AniFunc
		dc.w AnimateTiles_NULL-Offs_AniFunc
		dc.w AniPLC_LRZ1-Offs_AniFunc
		dc.w AnimateTiles_NULL-Offs_AniFunc
		dc.w AniPLC_LRZ1-Offs_AniFunc
		dc.w AnimateTiles_NULL-Offs_AniFunc
		dc.w AniPLC_LRZ1-Offs_AniFunc
		dc.w AnimateTiles_NULL-Offs_AniFunc
		dc.w AniPLC_LRZ1-Offs_AniFunc
		dc.w AnimateTiles_LRZ1-Offs_AniFunc
		dc.w AniPLC_LRZ1-Offs_AniFunc
		dc.w AnimateTiles_NULL-Offs_AniFunc
		dc.w AniPLC_ALZ-Offs_AniFunc
		dc.w AnimateTiles_NULL-Offs_AniFunc
		dc.w AniPLC_ALZ-Offs_AniFunc
		dc.w AnimateTiles_NULL-Offs_AniFunc
		dc.w AniPLC_ALZ-Offs_AniFunc
		dc.w AnimateTiles_NULL-Offs_AniFunc
		dc.w AniPLC_ALZ-Offs_AniFunc
		dc.w AnimateTiles_NULL-Offs_AniFunc
		dc.w AniPLC_ALZ-Offs_AniFunc
		dc.w AnimateTiles_NULL-Offs_AniFunc
		dc.w AniPLC_ALZ-Offs_AniFunc
		dc.w AnimateTiles_NULL-Offs_AniFunc
		dc.w AniPLC_ALZ-Offs_AniFunc
		dc.w AnimateTiles_NULL-Offs_AniFunc
		dc.w AniPLC_ALZ-Offs_AniFunc
		dc.w AnimateTiles_NULL-Offs_AniFunc
		dc.w AniPLC_ALZ-Offs_AniFunc
		dc.w AnimateTiles_DoAniPLC-Offs_AniFunc
		dc.w AniPLC_ALZ-Offs_AniFunc
		dc.w AnimateTiles_DoAniPLC-Offs_AniFunc
		dc.w AniPLC_ALZ-Offs_AniFunc
		dc.w AnimateTiles_DoAniPLC-Offs_AniFunc
		dc.w AniPLC_BPZ-Offs_AniFunc
		dc.w AnimateTiles_DoAniPLC-Offs_AniFunc
		dc.w AniPLC_BPZ-Offs_AniFunc
		dc.w AnimateTiles_DPZ-Offs_AniFunc
		dc.w AniPLC_DPZ-Offs_AniFunc
		dc.w AnimateTiles_DPZ-Offs_AniFunc
		dc.w AniPLC_DPZ-Offs_AniFunc
		dc.w AnimateTiles_NULL-Offs_AniFunc
		dc.w AnimateTiles_NULL3-Offs_AniFunc
		dc.w AnimateTiles_NULL-Offs_AniFunc
		dc.w AnimateTiles_NULL3-Offs_AniFunc
		dc.w AnimateTiles_NULL-Offs_AniFunc
		dc.w AnimateTiles_NULL3-Offs_AniFunc
		dc.w AnimateTiles_NULL-Offs_AniFunc
		dc.w AnimateTiles_NULL3-Offs_AniFunc
		dc.w AnimateTiles_Gumball-Offs_AniFunc
		dc.w AnimateTiles_NULL3-Offs_AniFunc
		dc.w AnimateTiles_Gumball-Offs_AniFunc
		dc.w AnimateTiles_NULL3-Offs_AniFunc
		dc.w AnimateTiles_NULL-Offs_AniFunc
		dc.w AnimateTiles_NULL3-Offs_AniFunc
		dc.w AnimateTiles_NULL-Offs_AniFunc
		dc.w AnimateTiles_NULL3-Offs_AniFunc
		dc.w AnimateTiles_NULL-Offs_AniFunc
		dc.w AnimateTiles_NULL3-Offs_AniFunc
		dc.w AnimateTiles_NULL-Offs_AniFunc
		dc.w AnimateTiles_NULL3-Offs_AniFunc
		dc.w AnimateTiles_NULL-Offs_AniFunc
		dc.w AnimateTiles_NULL3-Offs_AniFunc
		dc.w AnimateTiles_NULL-Offs_AniFunc
		dc.w AnimateTiles_NULL3-Offs_AniFunc
		dc.w AnimateTiles_NULL-Offs_AniFunc
		dc.w AnimateTiles_NULL3-Offs_AniFunc
		dc.w AnimateTiles_NULL-Offs_AniFunc
		dc.w AnimateTiles_NULL3-Offs_AniFunc
; ---------------------------------------------------------------------------

AnimateTiles_NULL:
		rts
; ---------------------------------------------------------------------------

AnimateTiles_AIZ1:
		tst.b	(Boss_flag).w
		bne.s	locret_26B82
		tst.b	(Dynamic_resize_routine).w
		bne.w	AnimateTiles_DoAniPLC

locret_26B82:
		rts
; ---------------------------------------------------------------------------

AnimateTiles_AIZ2:
		tst.b	(Boss_flag).w
		bne.s	locret_26BB8
		cmpi.w	#$1C0,(Camera_X_pos).w
		bhs.w	AnimateTiles_DoAniPLC
		lea	(Anim_Counters).w,a3
		addq.w	#2,a2
		moveq	#0,d6
		bsr.w	AnimateTiles_DoAniPLC_Part2
		clr.l	(a3)
		clr.l	(a3)
		move.l	#ArtUnc_AniAIZ2_FirstTree,d1
		move.w	#tiles_to_bytes($0CA),d2
		move.w	#$230,d3
		jmp	(Add_To_DMA_Queue).l
; ---------------------------------------------------------------------------

locret_26BB8:
		rts
; ---------------------------------------------------------------------------

AnimateTiles_HCZ1:
		tst.b	(Events_bg+$16).w
		beq.s	+ ;loc_26BC2
		rts
; ---------------------------------------------------------------------------
; This section determines which tiles to load at what position to simulate a
; waterline extending into the background
; ---------------------------------------------------------------------------

+ ;loc_26BC2:
		lea	(Anim_Counters+4).w,a3

loc_26BC6:
		moveq	#0,d1
		move.w	(Events_bg+$10).w,d1
		cmp.w	(a3),d1
		beq.w	loc_26CB4
		move.w	d1,(a3)
		tst.w	d1
		beq.w	loc_26CB8
		bpl.w	++ ;loc_26C4C
		addi.w	#$60,d1
		bcc.w	loc_26CB4
		move.w	d1,d0
		add.w	d1,d1
		add.w	d0,d1
		lsl.w	#5,d1
		lea	(Chunk_table+$7C00).l,a4
		lea	(HCZ_WaterlineScroll_Data).l,a5
		adda.w	d1,a5
		move.w	#$60-1,d1

- ;loc_26C00:
		moveq	#0,d0
		move.b	(a5)+,d0
		add.w	d0,d0
		add.w	d0,d0
		lea	(ArtUnc_AniHCZ1_WaterlineBelow).l,a0
		adda.w	d0,a0
		move.l	(a0),(a4)
		lea	$600(a0),a0
		lea	$180(a4),a4
		move.l	(a0),(a4)
		lea	-$17C(a4),a4
		dbf	d1,- ;loc_26C00
		move.l	#Chunk_table+$7C00,d1
		move.w	#tiles_to_bytes($2DC),d2
		move.w	#$180,d3
		jsr	(Add_To_DMA_Queue).l
		tst.w	2(a3)
		bmi.s	+ ;loc_26C48
		move.w	#-1,2(a3)
		bsr.w	AniHCZ_FixLowerBG

+ ;loc_26C48:
		bra.w	loc_26CB4
; ---------------------------------------------------------------------------

+ ;loc_26C4C:
		neg.w	d1
		addi.w	#$60,d1
		bcc.s	loc_26CB4
		move.w	d1,d0
		add.w	d1,d1
		add.w	d0,d1
		lsl.w	#5,d1
		lea	(Chunk_table+$7C00).l,a4
		lea	(HCZ_WaterlineScroll_Data).l,a5
		adda.w	d1,a5
		move.w	#$60-1,d1

- ;loc_26C6E:
		moveq	#0,d0
		move.b	(a5)+,d0
		add.w	d0,d0
		add.w	d0,d0
		lea	(ArtUnc_AniHCZ1_WaterlineAbove).l,a0
		adda.w	d0,a0
		move.l	(a0),(a4)
		lea	$600(a0),a0
		lea	$180(a4),a4
		move.l	(a0),(a4)
		lea	-$17C(a4),a4
		dbf	d1,- ;loc_26C6E
		move.l	#Chunk_table+$7C00,d1
		move.w	#tiles_to_bytes($2F4),d2
		move.w	#$180,d3
		jsr	(Add_To_DMA_Queue).l
		tst.w	2(a3)
		beq.s	loc_26CB4
		move.w	#0,2(a3)
		bsr.s	AniHCZ_FixUpperBG

loc_26CB4:
		bra.w	AnimateTiles_DoAniPLC
; ---------------------------------------------------------------------------

loc_26CB8:
		move.w	#1,(a3)
		bsr.s	AniHCZ_FixLowerBG

; ---------------------------------------------------------------------------
; When the special waterline goes below water, this routine loads tiles to
; fix the background area that was affected when the waterline was above
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


AniHCZ_FixUpperBG:
		move.l	#ArtUnc_FixHCZ1_UpperBG1,d1
		move.w	#tiles_to_bytes($2DC),d2
		move.w	#$C0,d3
		jsr	(Add_To_DMA_Queue).l
		move.l	#ArtUnc_FixHCZ1_UpperBG2,d1
		move.w	#tiles_to_bytes($2E8),d2
		move.w	#$C0,d3
		jmp	(Add_To_DMA_Queue).l
; End of function AniHCZ_FixUpperBG

; ---------------------------------------------------------------------------
; When the special waterline goes above water, this routine loads tiles to
; fix the background area that was affected when the waterline was below
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


AniHCZ_FixLowerBG:
		move.l	#ArtUnc_FixHCZ1_LowerBG1,d1
		move.w	#tiles_to_bytes($2F4),d2
		move.w	#$C0,d3
		jsr	(Add_To_DMA_Queue).l
		move.l	#ArtUnc_FixHCZ1_LowerBG2,d1
		move.w	#tiles_to_bytes($300),d2
		move.w	#$C0,d3
		jmp	(Add_To_DMA_Queue).l
; End of function AniHCZ_FixLowerBG


; =============== S U B R O U T I N E =======================================


sub_26D0E:
		lea	(AniPLC_HCZ1).l,a2
		lea	(Anim_Counters+4).w,a3
		move.w	(Events_bg+$10).w,d1
		beq.s	loc_26CB8
		bpl.s	++ ;loc_26D56
		addi.w	#$60,d1
		bcc.s	+ ;loc_26D2C
		bsr.s	AniHCZ_FixLowerBG
		bra.w	loc_26BC6
; ---------------------------------------------------------------------------

+ ;loc_26D2C:
		bsr.s	AniHCZ_FixLowerBG
		move.l	#ArtUnc_AniHCZ1_WaterlineBelow,d1
		move.w	#tiles_to_bytes($2DC),d2
		move.w	#$C0,d3
		jsr	(Add_To_DMA_Queue).l
		move.l	#ArtUnc_AniHCZ1_WaterlineBelow2,d1
		move.w	#tiles_to_bytes($2E8),d2
		move.w	#$C0,d3
		jmp	(Add_To_DMA_Queue).l
; ---------------------------------------------------------------------------

+ ;loc_26D56:
		neg.w	d1
		addi.w	#$60,d1
		bcc.s	+ ;loc_26D66
		bsr.w	AniHCZ_FixUpperBG
		bra.w	loc_26BC6
; ---------------------------------------------------------------------------

+ ;loc_26D66:
		bsr.w	AniHCZ_FixUpperBG
		move.l	#ArtUnc_AniHCZ1_WaterlineAbove,d1
		move.w	#tiles_to_bytes($2F4),d2
		move.w	#$C0,d3
		jsr	(Add_To_DMA_Queue).l
		move.l	#ArtUnc_AniHCZ1_WaterlineAbove2,d1
		move.w	#tiles_to_bytes($300),d2
		move.w	#$C0,d3
		jmp	(Add_To_DMA_Queue).l
; End of function sub_26D0E

; ---------------------------------------------------------------------------

AnimateTiles_HCZ2:
		lea	(Anim_Counters).w,a3
		moveq	#0,d1
		move.w	(Events_bg+$12).w,d1
		andi.w	#$1F,d1
		cmp.b	1(a3),d1
		beq.s	+ ;loc_26DEE
		move.b	d1,1(a3)
		move.w	d1,d2
		andi.w	#7,d1
		lsl.w	#7,d1
		move.l	d1,d5
		andi.w	#$18,d2
		move.w	d2,d0
		lsl.w	#2,d2
		add.w	d2,d1
		lsr.w	#1,d0
		lea	word_26DF2(pc,d0.w),a4
		lea	(ArtUnc_AniHCZ2_SmallBGLine).l,a0
		move.w	#tiles_to_bytes($2D2),d4
		add.l	a0,d1
		move.w	d4,d2
		move.w	(a4)+,d3
		add.w	d3,d4
		add.w	d3,d4
		jsr	(Add_To_DMA_Queue).l
		move.l	d5,d1
		add.l	a0,d1
		move.w	d4,d2
		move.w	(a4)+,d3
		beq.s	+ ;loc_26DEE
		jsr	(Add_To_DMA_Queue).l

+ ;loc_26DEE:
		addq.w	#2,a3
		bra.s	+ ;loc_26E02
; ---------------------------------------------------------------------------
word_26DF2:
		dc.w    $40
		dc.w      0
		dc.w    $30
		dc.w    $10
		dc.w    $20
		dc.w    $20
		dc.w    $10
		dc.w    $30
; ---------------------------------------------------------------------------

+ ;loc_26E02:
		moveq	#0,d1
		move.w	(Events_bg+$12).w,d1
		andi.w	#$1F,d1
		cmp.b	1(a3),d1
		beq.s	+ ;loc_26E5A
		move.b	d1,1(a3)
		move.w	d1,d2
		andi.w	#7,d1
		lsl.w	#8,d1
		move.l	d1,d5
		andi.w	#$18,d2
		move.w	d2,d0
		lsl.w	#3,d2
		add.w	d2,d1
		lsr.w	#1,d0
		lea	word_26E5E(pc,d0.w),a4
		lea	(ArtUnc_AniHCZ2_2).l,a0
		move.w	#tiles_to_bytes($2D6),d4
		add.l	a0,d1
		move.w	d4,d2
		move.w	(a4)+,d3
		add.w	d3,d4
		add.w	d3,d4
		jsr	(Add_To_DMA_Queue).l
		move.l	d5,d1
		add.l	a0,d1
		move.w	d4,d2
		move.w	(a4)+,d3
		beq.s	+ ;loc_26E5A
		jsr	(Add_To_DMA_Queue).l

+ ;loc_26E5A:
		addq.w	#2,a3
		bra.s	+ ;loc_26E6E
; ---------------------------------------------------------------------------
word_26E5E:
		dc.w    $80
		dc.w      0
		dc.w    $60
		dc.w    $20
		dc.w    $40
		dc.w    $40
		dc.w    $20
		dc.w    $60
; ---------------------------------------------------------------------------

+ ;loc_26E6E:
		moveq	#0,d1
		move.w	(Events_bg+$14).w,d1
		andi.w	#$1F,d1
		cmp.b	1(a3),d1
		beq.s	+ ;loc_26EC6
		move.b	d1,1(a3)
		move.w	d1,d2
		andi.w	#7,d1
		ror.w	#7,d1
		move.l	d1,d5
		andi.w	#$18,d2
		move.w	d2,d0
		lsl.w	#4,d2
		add.w	d2,d1
		lsr.w	#1,d0
		lea	word_26ECA(pc,d0.w),a4
		lea	(ArtUnc_AniHCZ2_3).l,a0
		move.w	#tiles_to_bytes($2DE),d4
		add.l	a0,d1
		move.w	d4,d2
		move.w	(a4)+,d3
		add.w	d3,d4
		add.w	d3,d4
		jsr	(Add_To_DMA_Queue).l
		move.l	d5,d1
		add.l	a0,d1
		move.w	d4,d2
		move.w	(a4)+,d3
		beq.s	+ ;loc_26EC6
		jsr	(Add_To_DMA_Queue).l

+ ;loc_26EC6:
		addq.w	#2,a3
		bra.s	+ ;loc_26EDA
; ---------------------------------------------------------------------------
word_26ECA:
		dc.w   $100
		dc.w      0
		dc.w    $C0
		dc.w    $40
		dc.w    $80
		dc.w    $80
		dc.w    $40
		dc.w    $C0
; ---------------------------------------------------------------------------

+ ;loc_26EDA:
		moveq	#0,d1
		move.w	(Events_bg+$14).w,d1
		andi.w	#$3F,d1
		cmp.b	1(a3),d1
		beq.s	+ ;loc_26F40
		move.b	d1,1(a3)
		neg.w	d1
		move.w	d1,d2
		andi.w	#7,d1
		ror.w	#7,d1
		move.w	d1,d0
		add.w	d0,d0
		add.w	d0,d1
		move.l	d1,d5
		not.w	d2
		andi.w	#$38,d2
		move.w	d2,d0
		lsl.w	#3,d2
		add.w	d2,d1
		add.w	d2,d2
		add.w	d2,d1
		lsr.w	#1,d0
		lea	word_26F46(pc,d0.w),a4
		lea	(ArtUnc_AniHCZ2_4).l,a0
		move.w	#tiles_to_bytes($2EE),d4
		add.l	a0,d1
		move.w	d4,d2
		move.w	(a4)+,d3
		add.w	d3,d4
		add.w	d3,d4
		jsr	(Add_To_DMA_Queue).l
		move.l	d5,d1
		add.l	a0,d1
		move.w	d4,d2
		move.w	(a4)+,d3
		beq.s	+ ;loc_26F40
		jsr	(Add_To_DMA_Queue).l

+ ;loc_26F40:
		addq.w	#2,a3
		bra.w	loc_275F0
; ---------------------------------------------------------------------------
word_26F46:
		dc.w   $300
		dc.w      0
		dc.w   $2A0
		dc.w    $60
		dc.w   $240
		dc.w    $C0
		dc.w   $1E0
		dc.w   $120
		dc.w   $180
		dc.w   $180
		dc.w   $120
		dc.w   $1E0
		dc.w    $C0
		dc.w   $240
		dc.w    $60
		dc.w   $2A0
; ---------------------------------------------------------------------------

AnimateTiles_MGZ:
		tst.b	(Boss_flag).w
		beq.w	AnimateTiles_DoAniPLC
		rts
; ---------------------------------------------------------------------------

AnimateTiles_CNZ:
		lea	(Anim_Counters).w,a3
		moveq	#0,d1
		move.w	(Events_bg+$10).w,d1
		sub.w	(Camera_X_pos_BG_copy).w,d1
		andi.w	#$3F,d1
		cmp.b	1(a3),d1
		beq.s	+ ;loc_26FD0
		move.b	d1,1(a3)
		move.w	d1,d2
		andi.w	#7,d1
		ror.w	#6,d1
		move.l	d1,d5
		andi.w	#$38,d2
		move.w	d2,d0
		lsl.w	#4,d2
		add.w	d2,d1
		lsr.w	#1,d0
		lea	word_26FD6(pc,d0.w),a4
		lea	(ArtUnc_AniCNZ__6).l,a0
		move.w	#tiles_to_bytes($308),d4
		add.l	a0,d1
		move.w	d4,d2
		move.w	(a4)+,d3
		add.w	d3,d4
		add.w	d3,d4
		jsr	(Add_To_DMA_Queue).l
		move.l	d5,d1
		add.l	a0,d1
		move.w	d4,d2
		move.w	(a4)+,d3
		beq.s	+ ;loc_26FD0
		jsr	(Add_To_DMA_Queue).l

+ ;loc_26FD0:
		addq.w	#2,a3
		bra.w	loc_275F0
; ---------------------------------------------------------------------------
word_26FD6:
		dc.w   $200
		dc.w      0
		dc.w   $1C0
		dc.w    $40
		dc.w   $180
		dc.w    $80
		dc.w   $140
		dc.w    $C0
		dc.w   $100
		dc.w   $100
		dc.w    $C0
		dc.w   $140
		dc.w    $80
		dc.w   $180
		dc.w    $40
		dc.w   $1C0
word_26FF6:
		dc.w   $100
		dc.w      0
		dc.w    $C0
		dc.w    $40
		dc.w    $80
		dc.w    $80
		dc.w    $40
		dc.w    $C0
; ---------------------------------------------------------------------------

AnimateTiles_ICZ:
		lea	(Anim_Counters).w,a3
		moveq	#0,d0
		move.w	(Events_bg+$10).w,d0
		sub.w	(Camera_X_pos_BG_copy).w,d0
		andi.w	#$1F,d0
		cmp.b	1(a3),d0
		beq.s	+ ;loc_2706C
		move.b	d0,1(a3)
		move.l	d0,d1
		move.w	d0,d2
		andi.w	#7,d1
		ror.w	#7,d1
		move.l	d1,d5
		andi.w	#$18,d2
		move.w	d2,d0
		lsl.w	#4,d2
		add.w	d2,d1
		lsr.w	#1,d0
		lea	word_26FF6(pc,d0.w),a4
		lea	(ArtUnc_AniICZ__1).l,a0
		move.w	#tiles_to_bytes($10E),d4
		add.l	a0,d1
		move.w	d4,d2
		move.w	(a4)+,d3
		add.w	d3,d4
		add.w	d3,d4
		jsr	(Add_To_DMA_Queue).l
		move.l	d5,d1
		add.l	a0,d1
		move.w	d4,d2
		move.w	(a4)+,d3
		beq.s	+ ;loc_2706C
		add.w	d3,d4
		add.w	d3,d4
		jsr	(Add_To_DMA_Queue).l

+ ;loc_2706C:
		addq.w	#2,a3
		tst.b	(Current_act).w
		bne.w	+ ;loc_27132
		moveq	#0,d1
		move.w	(Camera_Y_pos_BG_copy).w,d1
		sub.w	(Events_bg+$12).w,d1
		neg.w	d1
		andi.w	#$3F,d1
		cmp.b	1(a3),d1
		beq.w	+ ;loc_27132
		move.b	d1,1(a3)
		add.w	d1,d1
		add.w	d1,d1
		addi.l	#ArtUnc_AniICZ__2,d1
		move.w	#tiles_to_bytes($122),d2
		move.w	#$80,d3
		jsr	(Add_To_DMA_Queue).l
		moveq	#0,d1
		move.w	(Camera_Y_pos_BG_copy).w,d1
		move.w	(Events_bg+$12).w,d0
		asr.w	#1,d0
		sub.w	d0,d1
		asr.w	#1,d0
		sub.w	d0,d1
		neg.w	d1
		andi.w	#$1F,d1
		add.w	d1,d1
		add.w	d1,d1
		addi.l	#ArtUnc_AniICZ__3,d1
		move.w	#tiles_to_bytes($12A),d2
		move.w	#$40,d3
		jsr	(Add_To_DMA_Queue).l
		moveq	#0,d1
		move.w	(Camera_Y_pos_BG_copy).w,d1
		move.w	(Events_bg+$12).w,d0
		asr.w	#1,d0
		sub.w	d0,d1
		neg.w	d1
		andi.w	#$F,d1
		add.w	d1,d1
		add.w	d1,d1
		addi.l	#ArtUnc_AniICZ__4,d1
		move.w	#tiles_to_bytes($12E),d2
		move.w	#$20,d3
		jsr	(Add_To_DMA_Queue).l
		moveq	#0,d1
		move.w	(Camera_Y_pos_BG_copy).w,d1
		move.w	(Events_bg+$12).w,d0
		asr.w	#2,d0
		sub.w	d0,d1
		neg.w	d1
		andi.w	#7,d1
		add.w	d1,d1
		add.w	d1,d1
		addi.l	#ArtUnc_AniICZ__5,d1
		move.w	#tiles_to_bytes($130),d2
		move.w	#$10,d3
		jsr	(Add_To_DMA_Queue).l

+ ;loc_27132:
		addq.w	#2,a3
		bra.w	loc_275F0
; ---------------------------------------------------------------------------
		rts
; ---------------------------------------------------------------------------

AnimateTiles_LBZ1:
		lea	(Anim_Counters).w,a3
		subq.b	#1,(a3)
		bcc.s	+ ;loc_2716E
		move.b	#3,(a3)
		moveq	#0,d0
		move.b	1(a3),d0
		addq.b	#1,1(a3)
		andi.b	#$F,1(a3)
		ror.w	#7,d0
		move.l	#ArtUnc_AniLBZ__0,d1
		add.l	d0,d1
		move.w	#tiles_to_bytes($160),d2
		move.w	#$100,d3
		jsr	(Add_To_DMA_Queue).l

+ ;loc_2716E:
		addq.w	#2,a3
		moveq	#0,d0
		move.w	(Events_bg+$10).w,d0
		sub.w	(Camera_X_pos_BG_copy).w,d0
		andi.w	#$1F,d0
		cmp.b	1(a3),d0
		beq.s	++ ;loc_271F6
		move.b	d0,1(a3)
		moveq	#0,d1
		move.w	d0,d2
		andi.w	#7,d0
		move.l	d0,d6
		lsl.w	#7,d0
		move.w	d0,d1
		lsl.w	#2,d0
		add.w	d0,d1
		move.l	d1,d5
		andi.w	#$18,d2
		move.w	d2,d0
		lsl.w	#2,d2
		add.w	d2,d1
		lsl.w	#2,d2
		add.w	d2,d1
		lsr.w	#1,d0
		lea	word_2721A(pc,d0.w),a4
		lea	(ArtUnc_AniLBZ1_1).l,a0
		move.w	#tiles_to_bytes($350),d4
		add.l	a0,d1
		move.w	d4,d2
		move.w	(a4)+,d3
		add.w	d3,d4
		add.w	d3,d4
		jsr	(Add_To_DMA_Queue).l
		move.l	d5,d1
		add.l	a0,d1
		move.w	d4,d2
		move.w	(a4)+,d3
		beq.s	+ ;loc_271DE
		add.w	d3,d4
		add.w	d3,d4
		jsr	(Add_To_DMA_Queue).l

+ ;loc_271DE:
		move.l	d6,d1
		lsl.w	#5,d1
		lea	(ArtUnc_AniLBZ1_2).l,a0
		add.l	a0,d1
		move.w	d4,d2
		move.w	#$10,d3
		jsr	(Add_To_DMA_Queue).l

+ ;loc_271F6:
		addq.w	#2,a3
		tst.w	(a3)+
		bne.s	+ ;loc_27208
		cmpi.b	#1,1(a3)
		beq.s	++ ;loc_2720C
		move.w	#0,(a3)

+ ;loc_27208:
		bsr.w	loc_275F0

+ ;loc_2720C:
		lea	(Anim_Counters+$C).w,a3
		lea	(AniPLC_LBZSpec).l,a2
		bra.w	loc_275F0
; ---------------------------------------------------------------------------
word_2721A:
		dc.w   $140
		dc.w      0
		dc.w    $F0
		dc.w    $50
		dc.w    $A0
		dc.w    $A0
		dc.w    $50
		dc.w    $F0
; ---------------------------------------------------------------------------

AnimateTiles_LBZ2:
		lea	(Anim_Counters).w,a3
		tst.b	$F(a3)
		bne.s	+++ ;loc_2729E
		subq.b	#1,(a3)
		bcc.s	+ ;loc_27264
		move.b	#3,(a3)
		moveq	#0,d0
		move.b	1(a3),d0
		addq.b	#1,1(a3)
		andi.b	#$F,1(a3)
		ror.w	#7,d0
		move.l	#ArtUnc_AniLBZ__0,d1
		add.l	d0,d1
		move.w	#tiles_to_bytes($160),d2
		move.w	#$100,d3
		jsr	(Add_To_DMA_Queue).l

+ ;loc_27264:
		addq.w	#2,a3
		moveq	#0,d1
		move.w	(Events_bg+$12).w,d1
		sub.w	(Camera_X_pos_BG_copy).w,d1
		andi.w	#$F,d1
		cmp.b	1(a3),d1
		beq.s	+ ;loc_27294
		move.b	d1,1(a3)
		lsl.w	#6,d1
		addi.l	#ArtUnc_AniLBZ2_2,d1
		move.w	#tiles_to_bytes($2E3),d2
		move.w	#$20,d3
		jsr	(Add_To_DMA_Queue).l

+ ;loc_27294:
		addq.w	#2,a3
		bsr.s	sub_272A0
		addq.w	#4,a3
		bra.w	loc_275F0
; ---------------------------------------------------------------------------

+ ;loc_2729E:
		addq.w	#4,a3

; =============== S U B R O U T I N E =======================================


sub_272A0:
		moveq	#0,d1
		move.w	(Events_bg+$10).w,d1
		cmp.w	(a3),d1
		beq.w	locret_27382
		move.w	d1,(a3)
		tst.w	d1
		beq.w	loc_27384
		bpl.w	loc_2731E
		addi.w	#$40,d1
		bcc.w	locret_27382
		lsl.w	#6,d1
		lea	(Chunk_table+$7E00).l,a4
		lea	(LBZ_WaterlineScroll_Data).l,a5
		adda.w	d1,a5
		move.w	#$40-1,d1

- ;loc_272D4:
		moveq	#0,d0
		move.b	(a5)+,d0
		add.w	d0,d0
		add.w	d0,d0
		lea	(ArtUnc_AniLBZ2_WaterlineBelow).l,a0
		adda.w	d0,a0
		move.l	(a0),(a4)
		lea	$100(a0),a0
		lea	$100(a4),a4
		move.l	(a0),(a4)
		lea	-$FC(a4),a4
		dbf	d1,- ;loc_272D4
		move.l	#Chunk_table+$7E00,d1
		move.w	#tiles_to_bytes($2C3),d2
		move.w	#$100,d3
		jsr	(Add_To_DMA_Queue).l
		tst.w	2(a3)
		beq.s	locret_2731C
		move.w	#0,2(a3)
		bsr.w	sub_273A0

locret_2731C:
		rts
; ---------------------------------------------------------------------------

loc_2731E:
		neg.w	d1
		addi.w	#$40,d1
		bcc.s	locret_27382
		lsl.w	#6,d1
		lea	(Chunk_table+$7E00).l,a4
		lea	(LBZ_WaterlineScroll_Data).l,a5
		adda.w	d1,a5
		move.w	#$40-1,d1

- ;loc_2733A:
		moveq	#0,d0
		move.b	(a5)+,d0
		add.w	d0,d0
		add.w	d0,d0
		lea	(ArtUnc_AniLBZ2_WaterlineAbove).l,a0
		adda.w	d0,a0
		move.l	(a0),(a4)
		lea	$100(a0),a0
		lea	$100(a4),a4
		move.l	(a0),(a4)
		lea	-$FC(a4),a4
		dbf	d1,- ;loc_2733A
		move.l	#Chunk_table+$7E00,d1
		move.w	#tiles_to_bytes($2D3),d2
		move.w	#$100,d3
		jsr	(Add_To_DMA_Queue).l
		tst.w	2(a3)
		bmi.s	locret_27380
		move.w	#-1,2(a3)
		bsr.s	sub_2738C

locret_27380:
		rts
; ---------------------------------------------------------------------------

locret_27382:
		rts
; ---------------------------------------------------------------------------

loc_27384:
		move.w	#1,2(a3)
		bsr.s	sub_273A0
; End of function sub_272A0


; =============== S U B R O U T I N E =======================================


sub_2738C:
		move.l	#ArtUnc_AniLBZ2_LowerBG,d1
		move.w	#tiles_to_bytes($2C3),d2
		move.w	#$100,d3
		jmp	(Add_To_DMA_Queue).l
; End of function sub_2738C


; =============== S U B R O U T I N E =======================================


sub_273A0:
		move.l	#ArtUnc_AniLBZ2_UpperBG,d1
		move.w	#tiles_to_bytes($2D3),d2
		move.w	#$100,d3
		jmp	(Add_To_DMA_Queue).l
; End of function sub_273A0


; =============== S U B R O U T I N E =======================================


sub_273B4:
		lea	(Anim_Counters+4).w,a3
		move.w	#1,2(a3)
		move.w	(Events_bg+$10).w,d1
		beq.s	loc_27384
		bpl.s	+ ;loc_273CC
		bsr.s	sub_273A0
		bra.w	sub_272A0
; ---------------------------------------------------------------------------

+ ;loc_273CC:
		bsr.s	sub_2738C
		bra.w	sub_272A0
; End of function sub_273B4

; ---------------------------------------------------------------------------

AnimateTiles_LRZ1:
		lea	(Anim_Counters).w,a3
		moveq	#0,d0
		move.w	(Events_bg+$12).w,d0
		sub.w	(Camera_X_pos_BG_copy).w,d0
		divu.w	#$30,d0
		swap	d0
		cmp.b	1(a3),d0
		beq.s	+ ;loc_27440
		move.b	d0,1(a3)
		moveq	#0,d1
		move.w	d0,d2
		andi.w	#7,d0
		lsl.w	#7,d0
		move.w	d0,d1
		lsl.w	#3,d0
		add.w	d0,d1
		move.l	d1,d5
		andi.w	#$38,d2
		move.w	d2,d0
		lsl.w	#3,d2
		add.w	d2,d1
		add.w	d2,d2
		add.w	d2,d1
		lsr.w	#1,d0
		lea	word_27446(pc,d0.w),a4
		lea	(ArtUnc_AniLRZ__BG).l,a0
		move.w	#tiles_to_bytes($301),d4
		add.l	a0,d1
		move.w	d4,d2
		move.w	(a4)+,d3
		add.w	d3,d4
		add.w	d3,d4
		jsr	(Add_To_DMA_Queue).l
		move.l	d5,d1
		add.l	a0,d1
		move.w	d4,d2
		move.w	(a4)+,d3
		beq.s	+ ;loc_27440
		jsr	(Add_To_DMA_Queue).l

+ ;loc_27440:
		addq.w	#2,a3
		bra.w	+ ;loc_2745E
; ---------------------------------------------------------------------------
word_27446:
		dc.w   $240
		dc.w      0
		dc.w   $1E0
		dc.w    $60
		dc.w   $180
		dc.w    $C0
		dc.w   $120
		dc.w   $120
		dc.w    $C0
		dc.w   $180
		dc.w    $60
		dc.w   $1E0
; ---------------------------------------------------------------------------

+ ;loc_2745E:
		moveq	#0,d0
		move.w	(Events_bg+$10).w,d0
		sub.w	(Camera_X_pos_BG_copy).w,d0
		andi.w	#$1F,d0
		cmp.b	1(a3),d0
		beq.s	locret_274BE
		move.b	d0,1(a3)
		moveq	#0,d1
		move.w	d0,d2
		andi.w	#7,d0
		lsl.w	#8,d0
		move.w	d0,d1
		move.l	d1,d5
		andi.w	#$18,d2
		move.w	d2,d0
		lsl.w	#3,d2
		add.w	d2,d1
		lsr.w	#1,d0
		lea	word_274C0(pc,d0.w),a4
		lea	(ArtUnc_AniLRZ__BG2).l,a0
		move.w	#tiles_to_bytes($325),d4
		add.l	a0,d1
		move.w	d4,d2
		move.w	(a4)+,d3
		add.w	d3,d4
		add.w	d3,d4
		jsr	(Add_To_DMA_Queue).l
		move.l	d5,d1
		add.l	a0,d1
		move.w	d4,d2
		move.w	(a4)+,d3
		beq.s	locret_274BE
		jsr	(Add_To_DMA_Queue).l

locret_274BE:
		rts
; ---------------------------------------------------------------------------
word_274C0:
		dc.w    $80
		dc.w      0
		dc.w    $60
		dc.w    $20
		dc.w    $40
		dc.w    $40
		dc.w    $20
		dc.w    $60
; ---------------------------------------------------------------------------

AnimateTiles_DPZ:
		lea	(Anim_Counters).w,a3
		moveq	#0,d1
		move.w	(Events_bg+$10).w,d1
		sub.w	(Camera_X_pos_BG_copy).w,d1
		andi.w	#$3F,d1
		cmp.b	1(a3),d1
		beq.s	+ ;loc_27530
		move.b	d1,1(a3)
		move.w	d1,d2
		andi.w	#7,d1
		ror.w	#6,d1
		move.l	d1,d5
		andi.w	#$38,d2
		move.w	d2,d0
		lsl.w	#4,d2
		add.w	d2,d1
		lsr.w	#1,d0
		lea	word_27534(pc,d0.w),a4
		lea	(ArtUnc_AniDPZ__BG).l,a0
		move.w	#tiles_to_bytes($153),d4
		add.l	a0,d1
		move.w	d4,d2
		move.w	(a4)+,d3
		add.w	d3,d4
		add.w	d3,d4
		jsr	(Add_To_DMA_Queue).l
		move.l	d5,d1
		add.l	a0,d1
		move.w	d4,d2
		move.w	(a4)+,d3
		beq.s	+ ;loc_27530
		jsr	(Add_To_DMA_Queue).l

+ ;loc_27530:
		addq.w	#2,a3
		bra.s	+ ;loc_27554
; ---------------------------------------------------------------------------
word_27534:
		dc.w   $200
		dc.w      0
		dc.w   $1C0
		dc.w    $40
		dc.w   $180
		dc.w    $80
		dc.w   $140
		dc.w    $C0
		dc.w   $100
		dc.w   $100
		dc.w    $C0
		dc.w   $140
		dc.w    $80
		dc.w   $180
		dc.w    $40
		dc.w   $1C0
; ---------------------------------------------------------------------------

+ ;loc_27554:
		moveq	#0,d1
		move.w	(Events_bg+$12).w,d1
		sub.w	(_unkEE70).w,d1
		andi.w	#$3F,d1
		cmp.b	1(a3),d1
		beq.s	+ ;loc_275B0
		move.b	d1,1(a3)
		move.w	d1,d2
		andi.w	#7,d1
		ror.w	#6,d1
		move.l	d1,d5
		andi.w	#$38,d2
		move.w	d2,d0
		lsl.w	#4,d2
		add.w	d2,d1
		lsr.w	#1,d0
		lea	word_27534(pc,d0.w),a4
		lea	(ArtUnc_AniDPZ__BG).l,a0
		move.w	#tiles_to_bytes($173),d4
		add.l	a0,d1
		move.w	d4,d2
		move.w	(a4)+,d3
		add.w	d3,d4
		add.w	d3,d4
		jsr	(Add_To_DMA_Queue).l
		move.l	d5,d1
		add.l	a0,d1
		move.w	d4,d2
		move.w	(a4)+,d3
		beq.s	+ ;loc_275B0
		jsr	(Add_To_DMA_Queue).l

+ ;loc_275B0:
		addq.w	#2,a3
		bra.w	loc_275F0
; ---------------------------------------------------------------------------

AnimateTiles_Gumball:
		lea	(Anim_Counters).w,a3
		moveq	#0,d1
		move.w	(Events_bg+$10).w,d1
		sub.w	(Camera_Y_pos_BG_copy).w,d1
		andi.w	#$1F,d1
		cmp.b	1(a3),d1
		beq.s	locret_275EA
		move.b	d1,1(a3)
		add.w	d1,d1
		add.w	d1,d1
		addi.l	#ArtUnc_AniGumball,d1
		move.w	#tiles_to_bytes($054),d2
		move.w	#$40,d3
		jsr	(Add_To_DMA_Queue).l

locret_275EA:
		rts

; =============== S U B R O U T I N E =======================================


AnimateTiles_DoAniPLC:
		lea	(Anim_Counters).w,a3

loc_275F0:
		move.w	(a2)+,d6			; Get number of scripts in list

AnimateTiles_DoAniPLC_Part2:
		subq.b	#1,(a3)		; Tick down frame duration
		bcc.s	.nextscript	; If frame isn't over, move on to next script

		moveq	#0,d0
		move.b	1(a3),d0	; Get current frame
		cmp.b	6(a2),d0	; Have we processed the last frame in the script?
		blo.s	.notlastframe
		moveq	#0,d0		; If so, reset to first frame
		move.b	d0,1(a3)	; ''

	.notlastframe:
		addq.b	#1,1(a3)	; Consider this frame processed; set counter to next frame
		move.b	(a2),(a3)	; Set frame duration to global duration value
		bpl.s	.globalduration
		; If script uses per-frame durations, use those instead
		add.w	d0,d0
		move.b	9(a2,d0.w),(a3)	; Set frame duration to current frame's duration value

	.globalduration:
	; Prepare for DMA transfer
		; Get relative address of frame's art
		move.b	8(a2,d0.w),d0	; Get tile ID
		lsl.w	#5,d0		; Turn it into an offset
		; Get VRAM destination address
		move.w	4(a2),d2
		; Get ROM source address
		move.l	(a2),d1		; Get start address of animated tile art
		andi.l	#$FFFFFF,d1
		add.l	d0,d1		; Offset into art, to get the address of new frame
		; Get size of art to be transferred
		moveq	#0,d3
		move.b	7(a2),d3
		lsl.w	#4,d3		; Turn it into actual size (in words)
		; Use d1, d2 and d3 to queue art for transfer
		jsr	(Add_To_DMA_Queue).l

	.nextscript:
		move.b	6(a2),d0	; Get total size of frame data
		tst.b	(a2)		; Is per-frame duration data present?
		bpl.s	.globalduration2; If not, keep the current size; it's correct
		add.b	d0,d0		; Double size to account for the additional frame duration data

	.globalduration2:
		addq.b	#1,d0
		andi.w	#$FE,d0		; Round to next even address, if it isn't already
		lea	8(a2,d0.w),a2	; Advance to next script in list
		addq.w	#2,a3		; Advance to next script's slot in a3 (usually Anim_Counters)
		dbf	d6,AnimateTiles_DoAniPLC_Part2
		rts
; End of function AnimateTiles_DoAniPLC

; ===========================================================================
; ZONE ANIMATION SCRIPTS
;
; The AnimateTiles_DoAniPLC subroutine uses these scripts to reload certain tiles,
; thus animating them. All the relevant art must be uncompressed, because
; otherwise the subroutine would spend so much time waiting for the art to be
; decompressed that the VBLANK window would close before all the animating was done.

;	zoneanimdecl -1, ArtUnc_Flowers1, ArtTile_ArtUnc_Flowers1, 6, 2
;	-1			Global frame duration. If -1, then each frame will use its own duration, instead
;	ArtUnc_Flowers1		Source address
;	ArtTile_ArtUnc_Flowers1	Destination VRAM address
;	6			Number of frames
;	2			Number of tiles to load into VRAM for each frame

;	dc.b    0, $7F		; Start of the script proper
;	0			Tile ID of first tile in ArtUnc_Flowers1 to transfer
;	$7F			Frame duration. Only here if global duration is -1

AniPLC_AIZ1: zoneanimstart
	zoneanimdecl  -1, ArtUnc_AniAIZ1_0, $2E6,  9, $C
		dc.b  $3C, $4F
		dc.b  $30,   5
		dc.b  $18,   5
		dc.b   $C,   5
		dc.b    0, $4F
		dc.b   $C,   3
		dc.b  $18,   3
		dc.b  $24,   1
		dc.b  $30,   1
		even
	zoneanimdecl  -1, ArtUnc_AniAIZ1_0, $2F2,  8, $C
		dc.b  $18,   5
		dc.b  $24,   5
		dc.b  $30,   5
		dc.b  $3C, $27
		dc.b    0,   5
		dc.b   $C,   5
		dc.b  $18,   5
		dc.b  $24,   5
		even
	zoneanimdecl  -1, ArtUnc_AniAIZ1_1, $2FE,  8,  6
		dc.b    0,   7
		dc.b    6,   3
		dc.b   $C,   3
		dc.b  $12,   3
		dc.b  $18,   7
		dc.b  $12,   3
		dc.b   $C,   3
		dc.b    6,   3
		even
	zoneanimend

AniPLC_AIZ2: zoneanimstart
	zoneanimdecl   3, ArtUnc_AniAIZ2_0, $0B3,  4,$17
		dc.b    0
		dc.b  $17
		dc.b  $2E
		dc.b  $45
		even
	zoneanimdecl  -1, ArtUnc_AniAIZ2_1, $0CA,  9, $C
		dc.b  $3C, $4F
		dc.b  $30,   5
		dc.b  $18,   5
		dc.b   $C,   5
		dc.b    0, $4F
		dc.b   $C,   3
		dc.b  $18,   3
		dc.b  $24,   1
		dc.b  $30,   1
		even
	zoneanimdecl  -1, ArtUnc_AniAIZ2_1, $0D6,  8, $C
		dc.b  $18,   5
		dc.b  $24,   5
		dc.b  $30,   5
		dc.b  $3C, $27
		dc.b    0,   5
		dc.b   $C,   5
		dc.b  $18,   5
		dc.b  $24,   5
		even
	zoneanimdecl   3, ArtUnc_AniAIZ2_2, $0E2,  4,  4
		dc.b    0
		dc.b    4
		dc.b    8
		dc.b   $C
		even
	zoneanimdecl   3, ArtUnc_AniAIZ2_3, $0E6,  4,$18
		dc.b    0
		dc.b  $18
		dc.b  $30
		dc.b  $48
		even
	zoneanimend

AniPLC_HCZ1: zoneanimstart
	zoneanimdecl  -1, ArtUnc_AniHCZ1_0, $30C,  3,$24
		dc.b    0,   2
		dc.b  $24,   1
		dc.b  $48,   2
		even
	zoneanimdecl  -1, ArtUnc_AniHCZ__1, $115,$10,  6
		dc.b    0,   4
		dc.b    6,   3
		dc.b   $C,   2
		dc.b  $12,   1
		dc.b  $18,   0
		dc.b  $1E,   1
		dc.b  $24,   2
		dc.b  $2A,   3
		dc.b  $30,   4
		dc.b  $2A,   3
		dc.b  $24,   2
		dc.b  $1E,   1
		dc.b  $18,   0
		dc.b  $12,   1
		dc.b   $C,   2
		dc.b    6,   3
		even
	zoneanimend

AniPLC_HCZ2: zoneanimstart
	zoneanimdecl   3, ArtUnc_AniHCZ2_0, $25E,  4,$15
		dc.b    0
		dc.b  $15
		dc.b  $2A
		dc.b  $3F
		even
	zoneanimdecl  -1, ArtUnc_AniHCZ__1, $115,$10,  6
		dc.b    0,   4
		dc.b    6,   3
		dc.b   $C,   2
		dc.b  $12,   1
		dc.b  $18,   0
		dc.b  $1E,   1
		dc.b  $24,   2
		dc.b  $2A,   3
		dc.b  $30,   4
		dc.b  $2A,   3
		dc.b  $24,   2
		dc.b  $1E,   1
		dc.b  $18,   0
		dc.b  $12,   1
		dc.b   $C,   2
		dc.b    6,   3
		even
	zoneanimend

AniPLC_MGZ: zoneanimstart
	zoneanimdecl   9, ArtUnc_AniMGZ__0, $222,  6,$30
		dc.b    0
		dc.b  $30
		dc.b  $60
		dc.b  $90
		dc.b  $C0
		dc.b  $F0
		even
	zoneanimdecl  -1, ArtUnc_AniMGZ__1, $252,  4,  1
		dc.b    0,   7
		dc.b    1,  $E
		dc.b    2,   7
		dc.b    1,  $E
		even
	zoneanimend

AniPLC_CNZ: zoneanimstart
	zoneanimdecl   3, ArtUnc_AniCNZ__0, $2B2,$10,  9
		dc.b    0
		dc.b  $12
		dc.b  $24
		dc.b  $36
		dc.b  $48
		dc.b  $5A
		dc.b  $6C
		dc.b  $7E
		dc.b    9
		dc.b  $1B
		dc.b  $2D
		dc.b  $3F
		dc.b  $51
		dc.b  $63
		dc.b  $75
		dc.b  $87
		even
	zoneanimdecl   3, ArtUnc_AniCNZ__0, $2BB,$10,  9
		dc.b    9
		dc.b  $1B
		dc.b  $2D
		dc.b  $3F
		dc.b  $51
		dc.b  $63
		dc.b  $75
		dc.b  $87
		dc.b    0
		dc.b  $12
		dc.b  $24
		dc.b  $36
		dc.b  $48
		dc.b  $5A
		dc.b  $6C
		dc.b  $7E
		even
	zoneanimdecl   3, ArtUnc_AniCNZ__1, $2C4,$10,$10
		dc.b    0
		dc.b  $10
		dc.b  $20
		dc.b  $30
		dc.b  $40
		dc.b  $50
		dc.b  $60
		dc.b  $70
		dc.b  $80
		dc.b  $90
		dc.b  $A0
		dc.b  $B0
		dc.b  $C0
		dc.b  $D0
		dc.b  $E0
		dc.b  $F0
		even
	zoneanimdecl   3, ArtUnc_AniCNZ__2, $2D4,  8,$20
		dc.b    0
		dc.b  $20
		dc.b  $40
		dc.b  $60
		dc.b  $80
		dc.b  $A0
		dc.b  $C0
		dc.b  $E0
		even
	zoneanimdecl   3, ArtUnc_AniCNZ__3, $2F4,  8,$10
		dc.b    0
		dc.b  $10
		dc.b  $20
		dc.b  $30
		dc.b  $40
		dc.b  $50
		dc.b  $60
		dc.b  $70
		even
	zoneanimdecl   3, ArtUnc_AniCNZ__4, $304,  6,  4
		dc.b    0
		dc.b    4
		dc.b    8
		dc.b    0
		dc.b    4
		dc.b    8
		even
	zoneanimdecl   1, ArtUnc_AniCNZ__5, $328,  4,$14
		dc.b    0
		dc.b  $14
		dc.b  $28
		dc.b  $3C
		even
	zoneanimend

AniPLC_ICZ: zoneanimstart
	zoneanimdecl   3, ArtUnc_AniICZ__0, $11E,  8,  4
		dc.b    0
		dc.b    4
		dc.b    8
		dc.b   $C
		dc.b  $10
		dc.b  $14
		dc.b  $18
		dc.b  $1C
		even
	zoneanimend

AniPLC_LBZ1: zoneanimstart
	zoneanimdecl   2, ArtUnc_AniLBZ1_0, $365,  4,  8
		dc.b    0
		dc.b    8
		dc.b  $10
		dc.b  $18
		even
	zoneanimend

AniPLC_LBZSpec: zoneanimstart
	zoneanimdecl   7, ArtUnc_AniLBZ2_0, $170,  4,  5
		dc.b    0
		dc.b    5
		dc.b   $A
		dc.b   $F
		even
	zoneanimdecl   7, ArtUnc_AniLBZ2_1, $175,  6,  4
		dc.b    0
		dc.b    4
		dc.b    8
		dc.b   $C
		dc.b  $10
		dc.b  $14
		even
	zoneanimend

AniPLC_LBZ2: zoneanimstart
	zoneanimdecl   7, ArtUnc_AniLBZ2_0, $170,  4,  5
		dc.b    0
		dc.b    5
		dc.b   $A
		dc.b   $F
		even
	zoneanimdecl   7, ArtUnc_AniLBZ2_1, $175,  6,  4
		dc.b    0
		dc.b    4
		dc.b    8
		dc.b   $C
		dc.b  $10
		dc.b  $14
		even
	zoneanimend

AniPLC_LRZ1:
AniPLC_ALZ: zoneanimstart
	zoneanimdecl   9, ArtUnc_AniALZ, $238,  3,$10
		dc.b    0
		dc.b  $10
		dc.b  $20
		even
	zoneanimend

AniPLC_BPZ: zoneanimstart
	zoneanimdecl   7, ArtUnc_AniBPZ__0, $118,  6,  7
		dc.b    0
		dc.b    7
		dc.b   $E
		dc.b  $15
		dc.b  $1C
		dc.b  $23
		even
	zoneanimdecl   5, ArtUnc_AniBPZ__1, $11F, $A,  8
		dc.b    0
		dc.b    8
		dc.b  $10
		dc.b  $18
		dc.b  $20
		dc.b    0
		dc.b    8
		dc.b  $10
		dc.b  $18
		dc.b  $20
		even
	zoneanimdecl   2, ArtUnc_AniBPZ__2, $127,  2,  3
		dc.b    0
		dc.b    3
		even
	zoneanimdecl   4, ArtUnc_AniBPZ__3, $12A,  2,  1
		dc.b    0
		dc.b    1
		even
	zoneanimend

AniPLC_DPZ: zoneanimstart
	zoneanimdecl  $B, ArtUnc_AniDPZ, $147,  5, $C
		dc.b    0
		dc.b   $C
		dc.b  $18
		dc.b  $24
		dc.b  $30
		even
	zoneanimend
; ---------------------------------------------------------------------------

AnimateTiles_NULL3:
		rts

; =============== S U B R O U T I N E =======================================


Animate_Init:
		cmpi.w	#$100,(Current_zone_and_act).w
		bne.s	+ ;loc_278C4
		bsr.w	sub_26D0E

+ ;loc_278C4:
		cmpi.w	#$101,(Current_zone_and_act).w
		bne.s	+ ;loc_278D8
		move.b	#$20,(Anim_Counters+1).w
		move.b	#$40,(Anim_Counters+3).w

+ ;loc_278D8:
		cmpi.b	#3,(Current_zone).w
		bne.s	+ ;loc_27910
		move.b	#$40,(Anim_Counters+1).w
		move.b	#0,(Anim_Counters+2).w
		move.b	#0,(Anim_Counters+4).w
		move.b	#0,(Anim_Counters+6).w
		move.b	#2,(Anim_Counters+8).w
		move.b	#2,(Anim_Counters+$A).w
		move.b	#2,(Anim_Counters+$C).w
		move.b	#1,(Anim_Counters+$E).w

+ ;loc_27910:
		cmpi.w	#$600,(Current_zone_and_act).w
		bne.s	+ ;loc_2791E
		move.b	#$20,(Anim_Counters+3).w

+ ;loc_2791E:
		cmpi.w	#$601,(Current_zone_and_act).w
		bne.s	+ ;loc_27930
		bsr.w	sub_273B4
		move.b	#$10,(Anim_Counters+1).w

+ ;loc_27930:
		cmpi.w	#$900,(Current_zone_and_act).w
		bne.s	+ ;loc_27944
		move.b	#-1,(Anim_Counters+1).w
		move.b	#-1,(Anim_Counters+3).w

+ ;loc_27944:
		cmpi.w	#$1000,(Current_zone_and_act).w
		bne.s	locret_27958
		move.b	#$40,(Anim_Counters+1).w
		move.b	#$40,(Anim_Counters+3).w

locret_27958:
		rts
; End of function Animate_Init


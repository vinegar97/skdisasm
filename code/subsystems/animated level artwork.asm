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
		dc.w AnimateTiles_DoAniPLC-Offs_AniFunc
		dc.w AniPLC_FBZ1-Offs_AniFunc
		dc.w AnimateTiles_DoAniPLC-Offs_AniFunc
		dc.w AniPLC_FBZ2-Offs_AniFunc
		dc.w AnimateTiles_ICZ-Offs_AniFunc
		dc.w AniPLC_ICZ-Offs_AniFunc
		dc.w AnimateTiles_ICZ-Offs_AniFunc
		dc.w AniPLC_ICZ-Offs_AniFunc
		dc.w AnimateTiles_LBZ1-Offs_AniFunc
		dc.w AniPLC_LBZ1-Offs_AniFunc
		dc.w AnimateTiles_LBZ2-Offs_AniFunc
		dc.w AniPLC_LBZ2-Offs_AniFunc
		dc.w AnimateTiles_MHZ-Offs_AniFunc
		dc.w AniPLC_MHZ-Offs_AniFunc
		dc.w AnimateTiles_MHZ-Offs_AniFunc
		dc.w AniPLC_MHZ-Offs_AniFunc
		dc.w AnimateTiles_SOZ1-Offs_AniFunc
		dc.w AniPLC_LRZ1-Offs_AniFunc
		dc.w AnimateTiles_SOZ2-Offs_AniFunc
		dc.w AniPLC_LRZ1-Offs_AniFunc
		dc.w AnimateTiles_LRZ1-Offs_AniFunc
		dc.w AniPLC_LRZ1-Offs_AniFunc
		dc.w AnimateTiles_LRZ2-Offs_AniFunc
		dc.w AniPLC_LRZ2-Offs_AniFunc
		dc.w AnimateTiles_DoAniPLC-Offs_AniFunc
		dc.w AniPLC_SSZ-Offs_AniFunc
		dc.w AnimateTiles_NULL-Offs_AniFunc
		dc.w AniPLC_SSZ-Offs_AniFunc
		dc.w AnimateTiles_DoAniPLC-Offs_AniFunc
		dc.w AniPLC_DEZ-Offs_AniFunc
		dc.w AnimateTiles_DoAniPLC-Offs_AniFunc
		dc.w AniPLC_DEZ-Offs_AniFunc
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
		dc.w AniPLC_NULL-Offs_AniFunc
		dc.w AnimateTiles_NULL-Offs_AniFunc
		dc.w AniPLC_NULL-Offs_AniFunc
		dc.w AnimateTiles_NULL-Offs_AniFunc
		dc.w AniPLC_NULL-Offs_AniFunc
		dc.w AnimateTiles_NULL-Offs_AniFunc
		dc.w AniPLC_NULL-Offs_AniFunc
		dc.w AnimateTiles_Gumball-Offs_AniFunc
		dc.w AniPLC_NULL-Offs_AniFunc
		dc.w AnimateTiles_Gumball-Offs_AniFunc
		dc.w AniPLC_NULL-Offs_AniFunc
		dc.w AnimateTiles_Pachinko-Offs_AniFunc
		dc.w AniPLC_Pachinko-Offs_AniFunc
		dc.w AnimateTiles_Pachinko-Offs_AniFunc
		dc.w AniPLC_Pachinko-Offs_AniFunc
		dc.w AnimateTiles_NULL-Offs_AniFunc
		dc.w AniPLC_NULL-Offs_AniFunc
		dc.w AnimateTiles_NULL-Offs_AniFunc
		dc.w AniPLC_NULL-Offs_AniFunc
		dc.w AnimateTiles_LRZ3-Offs_AniFunc
		dc.w AniPLC_NULL-Offs_AniFunc
		dc.w AnimateTiles_DoAniPLC-Offs_AniFunc
		dc.w AniPLC_HPZ-Offs_AniFunc
		dc.w AnimateTiles_NULL-Offs_AniFunc
		dc.w AnimateTiles_NULL3-Offs_AniFunc
		dc.w AnimateTiles_DoAniPLC-Offs_AniFunc
		dc.w AniPLC_HPZ-Offs_AniFunc
; ---------------------------------------------------------------------------

AnimateTiles_NULL:
		rts
; ---------------------------------------------------------------------------

AnimateTiles_AIZ1:
		tst.b	(Boss_flag).w
		bne.s	locret_27848
		tst.b	(Dynamic_resize_routine).w
		bne.w	AnimateTiles_DoAniPLC

locret_27848:
		rts
; ---------------------------------------------------------------------------

AnimateTiles_AIZ2:
		tst.b	(Boss_flag).w
		bne.s	locret_2787E
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

locret_2787E:
		rts
; ---------------------------------------------------------------------------

AnimateTiles_HCZ1:
		tst.b	(Events_bg+$16).w
		beq.s	+ ;loc_27888
		rts
; ---------------------------------------------------------------------------
; This section determines which tiles to load at what position to simulate a
; waterline extending into the background
; ---------------------------------------------------------------------------

+ ;loc_27888:
		lea	(Anim_Counters+4).w,a3

loc_2788C:
		moveq	#0,d1
		move.w	(Events_bg+$10).w,d1
		cmp.w	(a3),d1
		beq.w	loc_2797A
		move.w	d1,(a3)
		tst.w	d1
		beq.w	loc_2797E
		bpl.w	++ ;loc_27912
		addi.w	#$60,d1
		bcc.w	loc_2797A
		move.w	d1,d0
		add.w	d1,d1
		add.w	d0,d1
		lsl.w	#5,d1
		lea	(Chunk_table+$7C00).l,a4
		lea	(HCZ_WaterlineScroll_Data).l,a5
		adda.w	d1,a5
		move.w	#$60-1,d1

- ;loc_278C6:
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
		dbf	d1,- ;loc_278C6
		move.l	#Chunk_table+$7C00,d1
		move.w	#tiles_to_bytes($2DC),d2
		move.w	#$180,d3
		jsr	(Add_To_DMA_Queue).l
		tst.w	2(a3)
		bmi.s	+ ;loc_2790E
		move.w	#-1,2(a3)
		bsr.w	AniHCZ_FixLowerBG

+ ;loc_2790E:
		bra.w	loc_2797A
; ---------------------------------------------------------------------------

+ ;loc_27912:
		neg.w	d1
		addi.w	#$60,d1
		bcc.s	loc_2797A
		move.w	d1,d0
		add.w	d1,d1
		add.w	d0,d1
		lsl.w	#5,d1
		lea	(Chunk_table+$7C00).l,a4
		lea	(HCZ_WaterlineScroll_Data).l,a5
		adda.w	d1,a5
		move.w	#$60-1,d1

- ;loc_27934:
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
		dbf	d1,- ;loc_27934
		move.l	#Chunk_table+$7C00,d1
		move.w	#tiles_to_bytes($2F4),d2
		move.w	#$180,d3
		jsr	(Add_To_DMA_Queue).l
		tst.w	2(a3)
		beq.s	loc_2797A
		move.w	#0,2(a3)
		bsr.s	AniHCZ_FixUpperBG

loc_2797A:
		bra.w	AnimateTiles_DoAniPLC
; ---------------------------------------------------------------------------

loc_2797E:
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


sub_279D4:
		lea	(AniPLC_HCZ1).l,a2
		lea	(Anim_Counters+4).w,a3
		move.w	(Events_bg+$10).w,d1
		beq.s	loc_2797E
		bpl.s	++ ;loc_27A1C
		addi.w	#$60,d1
		bcc.s	+ ;loc_279F2
		bsr.s	AniHCZ_FixLowerBG
		bra.w	loc_2788C
; ---------------------------------------------------------------------------

+ ;loc_279F2:
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

+ ;loc_27A1C:
		neg.w	d1
		addi.w	#$60,d1
		bcc.s	+ ;loc_27A2C
		bsr.w	AniHCZ_FixUpperBG
		bra.w	loc_2788C
; ---------------------------------------------------------------------------

+ ;loc_27A2C:
		bsr.w	AniHCZ_FixUpperBG
		move.l	#ArtUnc_AniHCZ1_WaterlineAbove,d1
		move.w	#tiles_to_bytes($2F4),d2
		move.w	#$C0,d3
		jsr	(Add_To_DMA_Queue).l
		move.l	#ArtUnc_AniHCZ1_WaterlineAbove2,d1
		move.w	#tiles_to_bytes($300),d2
		move.w	#$C0,d3
		jmp	(Add_To_DMA_Queue).l
; End of function sub_279D4

; ---------------------------------------------------------------------------

AnimateTiles_HCZ2:
		lea	(Anim_Counters).w,a3
		moveq	#0,d1
		move.w	(Events_bg+$12).w,d1
		andi.w	#$1F,d1
		cmp.b	1(a3),d1
		beq.s	+ ;loc_27AB4
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
		lea	word_27AB8(pc,d0.w),a4
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
		beq.s	+ ;loc_27AB4
		jsr	(Add_To_DMA_Queue).l

+ ;loc_27AB4:
		addq.w	#2,a3
		bra.s	+ ;loc_27AC8
; ---------------------------------------------------------------------------
word_27AB8:
		dc.w    $40
		dc.w      0
		dc.w    $30
		dc.w    $10
		dc.w    $20
		dc.w    $20
		dc.w    $10
		dc.w    $30
; ---------------------------------------------------------------------------

+ ;loc_27AC8:
		moveq	#0,d1
		move.w	(Events_bg+$12).w,d1
		andi.w	#$1F,d1
		cmp.b	1(a3),d1
		beq.s	+ ;loc_27B20
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
		lea	word_27B24(pc,d0.w),a4
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
		beq.s	+ ;loc_27B20
		jsr	(Add_To_DMA_Queue).l

+ ;loc_27B20:
		addq.w	#2,a3
		bra.s	+ ;loc_27B34
; ---------------------------------------------------------------------------
word_27B24:
		dc.w    $80
		dc.w      0
		dc.w    $60
		dc.w    $20
		dc.w    $40
		dc.w    $40
		dc.w    $20
		dc.w    $60
; ---------------------------------------------------------------------------

+ ;loc_27B34:
		moveq	#0,d1
		move.w	(Events_bg+$14).w,d1
		andi.w	#$1F,d1
		cmp.b	1(a3),d1
		beq.s	+ ;loc_27B8C
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
		lea	word_27B90(pc,d0.w),a4
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
		beq.s	+ ;loc_27B8C
		jsr	(Add_To_DMA_Queue).l

+ ;loc_27B8C:
		addq.w	#2,a3
		bra.s	+ ;loc_27BA0
; ---------------------------------------------------------------------------
word_27B90:
		dc.w   $100
		dc.w      0
		dc.w    $C0
		dc.w    $40
		dc.w    $80
		dc.w    $80
		dc.w    $40
		dc.w    $C0
; ---------------------------------------------------------------------------

+ ;loc_27BA0:
		moveq	#0,d1
		move.w	(Events_bg+$14).w,d1
		andi.w	#$3F,d1
		cmp.b	1(a3),d1
		beq.s	+ ;loc_27C06
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
		lea	word_27C0C(pc,d0.w),a4
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
		beq.s	+ ;loc_27C06
		jsr	(Add_To_DMA_Queue).l

+ ;loc_27C06:
		addq.w	#2,a3
		bra.w	loc_286E8
; ---------------------------------------------------------------------------
word_27C0C:
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
		beq.s	+ ;loc_27C96
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
		lea	word_27C9C(pc,d0.w),a4
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
		beq.s	+ ;loc_27C96
		jsr	(Add_To_DMA_Queue).l

+ ;loc_27C96:
		addq.w	#2,a3
		bra.w	loc_286E8
; ---------------------------------------------------------------------------
word_27C9C:
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
word_27CBC:
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
		beq.s	+ ;loc_27D32
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
		lea	word_27CBC(pc,d0.w),a4
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
		beq.s	+ ;loc_27D32
		add.w	d3,d4
		add.w	d3,d4
		jsr	(Add_To_DMA_Queue).l

+ ;loc_27D32:
		addq.w	#2,a3
		tst.b	(Current_act).w
		bne.w	+ ;loc_27DF8
		moveq	#0,d1
		move.w	(Camera_Y_pos_BG_copy).w,d1
		sub.w	(Events_bg+$12).w,d1
		neg.w	d1
		andi.w	#$3F,d1
		cmp.b	1(a3),d1
		beq.w	+ ;loc_27DF8
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

+ ;loc_27DF8:
		addq.w	#2,a3
		bra.w	loc_286E8
; ---------------------------------------------------------------------------
		rts
; ---------------------------------------------------------------------------

AnimateTiles_LBZ1:
		lea	(Anim_Counters).w,a3
		subq.b	#1,(a3)
		bcc.s	+ ;loc_27E34
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

+ ;loc_27E34:
		addq.w	#2,a3
		moveq	#0,d0
		move.w	(Events_bg+$10).w,d0
		sub.w	(Camera_X_pos_BG_copy).w,d0
		andi.w	#$1F,d0
		cmp.b	1(a3),d0
		beq.s	++ ;loc_27EBC
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
		lea	word_27EE0(pc,d0.w),a4
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
		beq.s	+ ;loc_27EA4
		add.w	d3,d4
		add.w	d3,d4
		jsr	(Add_To_DMA_Queue).l

+ ;loc_27EA4:
		move.l	d6,d1
		lsl.w	#5,d1
		lea	(ArtUnc_AniLBZ1_2).l,a0
		add.l	a0,d1
		move.w	d4,d2
		move.w	#$10,d3
		jsr	(Add_To_DMA_Queue).l

+ ;loc_27EBC:
		addq.w	#2,a3
		tst.w	(a3)+
		bne.s	+ ;loc_27ECE
		cmpi.b	#1,1(a3)
		beq.s	++ ;loc_27ED2
		move.w	#0,(a3)

+ ;loc_27ECE:
		bsr.w	loc_286E8

+ ;loc_27ED2:
		lea	(Anim_Counters+$C).w,a3
		lea	(AniPLC_LBZSpec).l,a2
		bra.w	loc_286E8
; ---------------------------------------------------------------------------
word_27EE0:
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
		bne.s	+++ ;loc_27F64
		subq.b	#1,(a3)
		bcc.s	+ ;loc_27F2A
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

+ ;loc_27F2A:
		addq.w	#2,a3
		moveq	#0,d1
		move.w	(Events_bg+$12).w,d1
		sub.w	(Camera_X_pos_BG_copy).w,d1
		andi.w	#$F,d1
		cmp.b	1(a3),d1
		beq.s	+ ;loc_27F5A
		move.b	d1,1(a3)
		lsl.w	#6,d1
		addi.l	#ArtUnc_AniLBZ2_2,d1
		move.w	#tiles_to_bytes($2E3),d2
		move.w	#$20,d3
		jsr	(Add_To_DMA_Queue).l

+ ;loc_27F5A:
		addq.w	#2,a3
		bsr.s	sub_27F66
		addq.w	#4,a3
		bra.w	loc_286E8
; ---------------------------------------------------------------------------

+ ;loc_27F64:
		addq.w	#4,a3

; =============== S U B R O U T I N E =======================================


sub_27F66:
		moveq	#0,d1
		move.w	(Events_bg+$10).w,d1
		cmp.w	(a3),d1
		beq.w	locret_28048
		move.w	d1,(a3)
		tst.w	d1
		beq.w	loc_2804A
		bpl.w	loc_27FE4
		addi.w	#$40,d1
		bcc.w	locret_28048
		lsl.w	#6,d1
		lea	(Chunk_table+$7E00).l,a4
		lea	(LBZ_WaterlineScroll_Data).l,a5
		adda.w	d1,a5
		move.w	#$40-1,d1

- ;loc_27F9A:
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
		dbf	d1,- ;loc_27F9A
		move.l	#Chunk_table+$7E00,d1
		move.w	#tiles_to_bytes($2C3),d2
		move.w	#$100,d3
		jsr	(Add_To_DMA_Queue).l
		tst.w	2(a3)
		beq.s	locret_27FE2
		move.w	#0,2(a3)
		bsr.w	sub_28066

locret_27FE2:
		rts
; ---------------------------------------------------------------------------

loc_27FE4:
		neg.w	d1
		addi.w	#$40,d1
		bcc.s	locret_28048
		lsl.w	#6,d1
		lea	(Chunk_table+$7E00).l,a4
		lea	(LBZ_WaterlineScroll_Data).l,a5
		adda.w	d1,a5
		move.w	#$40-1,d1

- ;loc_28000:
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
		dbf	d1,- ;loc_28000
		move.l	#Chunk_table+$7E00,d1
		move.w	#tiles_to_bytes($2D3),d2
		move.w	#$100,d3
		jsr	(Add_To_DMA_Queue).l
		tst.w	2(a3)
		bmi.s	locret_28046
		move.w	#-1,2(a3)
		bsr.s	sub_28052

locret_28046:
		rts
; ---------------------------------------------------------------------------

locret_28048:
		rts
; ---------------------------------------------------------------------------

loc_2804A:
		move.w	#1,2(a3)
		bsr.s	sub_28066
; End of function sub_27F66


; =============== S U B R O U T I N E =======================================


sub_28052:
		move.l	#ArtUnc_AniLBZ2_LowerBG,d1
		move.w	#tiles_to_bytes($2C3),d2
		move.w	#$100,d3
		jmp	(Add_To_DMA_Queue).l
; End of function sub_28052


; =============== S U B R O U T I N E =======================================


sub_28066:
		move.l	#ArtUnc_AniLBZ2_UpperBG,d1
		move.w	#tiles_to_bytes($2D3),d2
		move.w	#$100,d3
		jmp	(Add_To_DMA_Queue).l
; End of function sub_28066


; =============== S U B R O U T I N E =======================================


sub_2807A:
		lea	(Anim_Counters+4).w,a3
		move.w	#1,2(a3)
		move.w	(Events_bg+$10).w,d1
		beq.s	loc_2804A
		bpl.s	+ ;loc_280A6
		bsr.s	sub_28066
		move.l	#ArtUnc_AniLBZ2_WaterlineBelow,d1
		move.w	#tiles_to_bytes($2C3),d2
		move.w	#$100,d3
		jsr	(Add_To_DMA_Queue).l
		bra.w	sub_27F66
; ---------------------------------------------------------------------------

+ ;loc_280A6:
		bsr.s	sub_28052
		bra.w	sub_27F66
; End of function sub_2807A

; ---------------------------------------------------------------------------

AnimateTiles_MHZ:
		lea	(Anim_Counters).w,a3
		moveq	#0,d0
		move.w	(Events_bg+$12).w,d0
		sub.w	(Camera_X_pos_BG_copy).w,d0
		andi.w	#$1F,d0
		cmp.b	1(a3),d0
		beq.s	+ ;loc_28110
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
		lea	word_28114(pc,d0.w),a4
		lea	(ArtUnc_AniMHZ__BG).l,a0
		move.w	#tiles_to_bytes($1B8),d4
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
		beq.s	+ ;loc_28110
		jsr	(Add_To_DMA_Queue).l

+ ;loc_28110:
		addq.w	#2,a3
		bra.s	loc_28124
; ---------------------------------------------------------------------------
word_28114:
		dc.w    $80
		dc.w      0
		dc.w    $60
		dc.w    $20
		dc.w    $40
		dc.w    $40
		dc.w    $20
		dc.w    $60
; ---------------------------------------------------------------------------

loc_28124:
		moveq	#0,d1
		move.w	(Events_bg+$10).w,d1
		sub.w	(Camera_X_pos_BG_copy).w,d1
		andi.w	#$3F,d1
		cmp.b	1(a3),d1
		beq.s	+ ;loc_28180
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
		lea	word_28198(pc,d0.w),a4
		lea	(ArtUnc_AniMHZ__BG2).l,a0
		move.w	#tiles_to_bytes($1D5),d4
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
		beq.s	+ ;loc_28180
		jsr	(Add_To_DMA_Queue).l

+ ;loc_28180:
		addq.w	#2,a3
		move.b	(Anim_Counters+$F).w,d0
		addq.b	#2,d0
		cmpi.b	#$58,d0
		blo.s	+ ;loc_28190
		moveq	#0,d0

+ ;loc_28190:
		move.b	d0,(Anim_Counters+$F).w
		bra.w	loc_286E8
; ---------------------------------------------------------------------------
word_28198:
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
word_281B8:
		dc.w    $C0
		dc.w      0
		dc.w    $90
		dc.w    $30
		dc.w    $60
		dc.w    $60
		dc.w    $30
		dc.w    $90
; ---------------------------------------------------------------------------

AnimateTiles_SOZ1:
		lea	(Anim_Counters).w,a3
		moveq	#0,d0
		move.w	(Events_bg+$10).w,d0
		sub.w	(Camera_X_pos_BG_copy).w,d0
		andi.w	#$1F,d0
		cmp.b	1(a3),d0
		beq.s	locret_2825A
		move.b	d0,1(a3)
		moveq	#0,d1
		move.w	d0,d2
		andi.w	#7,d0
		lsl.w	#7,d0
		move.w	d0,d1
		add.w	d0,d0
		add.w	d1,d0
		move.w	d0,d1
		move.l	d1,d5
		andi.w	#$18,d2
		move.w	d2,d0
		lsl.w	#2,d2
		add.w	d2,d1
		add.w	d2,d2
		add.w	d2,d1
		lsr.w	#1,d0
		lea	word_281B8(pc,d0.w),a4
		lea	(ArtUnc_AniSOZ1_BG).l,a0
		move.w	#tiles_to_bytes($330),d4
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
		beq.s	+ ;loc_28236
		jsr	(Add_To_DMA_Queue).l

+ ;loc_28236:
		moveq	#0,d1
		move.b	1(a3),d1
		lsl.w	#6,d1
		move.w	d1,d0
		add.w	d1,d1
		add.w	d0,d1
		lea	(ArtUnc_AniSOZ1_BG2).l,a0
		add.l	a0,d1
		move.w	#tiles_to_bytes($33C),d2
		move.w	#$60,d3
		jsr	(Add_To_DMA_Queue).l

locret_2825A:
		rts
; ---------------------------------------------------------------------------

AnimateTiles_SOZ2:
		lea	(Anim_Counters).w,a3
		subq.b	#1,(a3)
		bpl.s	locret_282B2
		move.b	#7,(a3)
		moveq	#0,d0
		move.b	1(a3),d0
		addq.b	#1,1(a3)
		cmpi.b	#2,d0
		blo.s	+ ;loc_2827E
		move.b	#0,1(a3)

+ ;loc_2827E:
		move.w	(Palette_cycle_counters+$06).w,d1
		andi.w	#6,d1
		move.w	d1,d2
		lsr.w	#1,d2
		add.w	d2,d1
		cmpi.w	#6,d1
		beq.s	+ ;loc_28294
		add.w	d0,d1

+ ;loc_28294:
		lsl.w	#6,d1
		move.w	d1,d0
		add.w	d1,d1
		add.w	d0,d1
		lea	(ArtUnc_AniSOZ2_BG).l,a0
		add.l	a0,d1
		move.w	#$6600,d2
		move.w	#$60,d3
		jsr	(Add_To_DMA_Queue).l

locret_282B2:
		rts
; ---------------------------------------------------------------------------

AnimateTiles_LRZ3:
		move.w	#tiles_to_bytes($170),d4
		move.w	#tiles_to_bytes($194),d6
		bra.s	+ ;loc_282D0
; ---------------------------------------------------------------------------

AnimateTiles_LRZ1:
		move.w	#tiles_to_bytes($320),d4
		move.w	#tiles_to_bytes($344),d6
		bra.s	+ ;loc_282D0
; ---------------------------------------------------------------------------

AnimateTiles_LRZ2:
		move.w	#tiles_to_bytes($320),d4
		move.w	#tiles_to_bytes($344),d6

+ ;loc_282D0:
		lea	(Anim_Counters).w,a3
		moveq	#0,d0
		move.w	(Events_bg+$12).w,d0
		sub.w	(Camera_X_pos_BG_copy).w,d0
		subq.w	#1,d0
		divu.w	#$30,d0
		swap	d0
		cmp.b	1(a3),d0
		beq.s	+ ;loc_2833C
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
		lea	word_2834C(pc,d0.w),a4
		lea	(ArtUnc_AniLRZ__BG).l,a0
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
		beq.s	+ ;loc_2833C
		jsr	(Add_To_DMA_Queue).l

+ ;loc_2833C:
		cmpi.b	#$16,(Current_zone).w
		beq.s	locret_2834A
		addq.w	#2,a3
		bra.w	+ ;loc_28364
; ---------------------------------------------------------------------------

locret_2834A:
		rts
; ---------------------------------------------------------------------------
word_2834C:
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

+ ;loc_28364:
		moveq	#0,d0
		move.w	(Events_bg+$10).w,d0
		sub.w	(Camera_X_pos_BG_copy).w,d0
		andi.w	#$1F,d0
		cmp.b	1(a3),d0
		beq.s	+ ;loc_283CC
		move.b	d0,1(a3)
		moveq	#0,d1
		move.w	d0,d2
		andi.w	#7,d0
		lsl.w	#7,d0
		move.w	d0,d1
		add.w	d0,d0
		add.w	d1,d0
		move.w	d0,d1
		move.l	d1,d5
		andi.w	#$18,d2
		move.w	d2,d0
		lsl.w	#2,d2
		add.w	d2,d1
		add.w	d2,d2
		add.w	d2,d1
		lsr.w	#1,d0
		lea	word_283D2(pc,d0.w),a4
		lea	(ArtUnc_AniLRZ__BG2).l,a0
		move.w	d6,d4
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
		beq.s	+ ;loc_283CC
		jsr	(Add_To_DMA_Queue).l

+ ;loc_283CC:
		addq.w	#2,a3
		bra.w	loc_286E8
; ---------------------------------------------------------------------------
word_283D2:
		dc.w    $C0
		dc.w      0
		dc.w    $90
		dc.w    $30
		dc.w    $60
		dc.w    $60
		dc.w    $30
		dc.w    $90
; ---------------------------------------------------------------------------

AnimateTiles_DPZ:
		lea	(Anim_Counters).w,a3
		moveq	#0,d1
		move.w	(Events_bg+$10).w,d1
		sub.w	(Camera_X_pos_BG_copy).w,d1
		andi.w	#$3F,d1
		cmp.b	1(a3),d1
		beq.s	+ ;loc_28442
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
		lea	word_28446(pc,d0.w),a4
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
		beq.s	+ ;loc_28442
		jsr	(Add_To_DMA_Queue).l

+ ;loc_28442:
		addq.w	#2,a3
		bra.s	+ ;loc_28466
; ---------------------------------------------------------------------------
word_28446:
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

+ ;loc_28466:
		moveq	#0,d1
		move.w	(Events_bg+$12).w,d1
		sub.w	(_unkEE70).w,d1
		andi.w	#$3F,d1
		cmp.b	1(a3),d1
		beq.s	+ ;loc_284C2
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
		lea	word_28446(pc,d0.w),a4
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
		beq.s	+ ;loc_284C2
		jsr	(Add_To_DMA_Queue).l

+ ;loc_284C2:
		addq.w	#2,a3
		bra.w	loc_286E8
; ---------------------------------------------------------------------------

AnimateTiles_Gumball:
		lea	(Anim_Counters).w,a3
		moveq	#0,d1
		move.w	(Events_bg+$10).w,d1
		sub.w	(Camera_Y_pos_BG_copy).w,d1
		andi.w	#$1F,d1
		cmp.b	1(a3),d1
		beq.s	locret_284FC
		move.b	d1,1(a3)
		add.w	d1,d1
		add.w	d1,d1
		addi.l	#ArtUnc_AniGumball,d1
		move.w	#tiles_to_bytes($054),d2
		move.w	#$40,d3
		jsr	(Add_To_DMA_Queue).l

locret_284FC:
		rts
; ---------------------------------------------------------------------------

AnimateTiles_Pachinko:
		lea	(Anim_Counters).w,a4
		tst.b	2(a4)
		bne.w	+ ;loc_285EE
		move.w	4(a4),d0
		subq.w	#4,4(a4)
		andi.w	#$7F,4(a4)
		lea	(RAM_start+$6000).l,a2
		lea	(a2,d0.w),a2
		lea	(Chunk_table+$7000).l,a3
		move.w	#$80,d2
		moveq	#3-1,d1

- ;loc_2852E:
		moveq	#4-1,d0

- ;loc_28530:
	rept 32
		move.l	(a2)+,(a3)+
	endm
		lea	(a2,d2.w),a2
		dbf	d0,- ;loc_28530
		lea	$80(a3),a3
		dbf	d1,-- ;loc_2852E
		lea	(Chunk_table+$7200).l,a3
		moveq	#0,d7
		moveq	#2,d6

- ;loc_2858A:
		moveq	#3,d5

- ;loc_2858C:
		lea	(Chunk_table+$7000).l,a1
		movea.l	a1,a2
		adda.w	word_285CE(pc,d7.w),a1
		adda.w	word_285D6(pc,d7.w),a2
		moveq	#-1,d2
		moveq	#0,d3
		moveq	#8-1,d4

- ;loc_285A2:
		move.l	(a1)+,d0
		and.l	d2,d0
		move.l	(a2)+,d1
		and.l	d3,d1
		or.l	d1,d0
		move.l	d0,(a3)+
		asl.l	#4,d2
		asl.l	#4,d3
		ori.w	#$F,d3
		dbf	d4,- ;loc_285A2
		addq.w	#2,d7
		dbf	d5,-- ;loc_2858C
		lea	$200(a3),a3
		dbf	d6,--- ;loc_2858A
		addq.b	#1,2(a4)
		bra.s	+++ ;loc_28624
; ---------------------------------------------------------------------------
word_285CE:
		dc.w   $180
		dc.w   $120
		dc.w    $C0
		dc.w    $60
word_285D6:
		dc.w   $400
		dc.w   $3A0
		dc.w   $340
		dc.w   $2E0
		dc.w   $680
		dc.w   $620
		dc.w   $5C0
		dc.w   $560
		dc.w   $180
		dc.w   $120
		dc.w    $C0
		dc.w    $60
; ---------------------------------------------------------------------------

+ ;loc_285EE:
		bsr.s	sub_2863E
		addq.b	#1,2(a4)
		cmpi.b	#4,2(a4)
		blo.s	++ ;loc_28624
		move.b	#0,2(a4)
		addi.w	#$280,(a4)
		cmpi.w	#$5000,(a4)
		blo.s	+ ;loc_28610
		move.w	#0,(a4)

+ ;loc_28610:
		move.l	#Chunk_table+$7000,d1
		move.w	#tiles_to_bytes($0E9),d2
		move.w	#$3C0,d3
		jsr	(Add_To_DMA_Queue).l

+ ;loc_28624:
		lea	(AniPLC_Pachinko).l,a2
		lea	(Anim_Counters+6).w,a3
		bra.w	loc_286E8
; ---------------------------------------------------------------------------
byte_28632:
		dc.b  $50
		dc.b    5
		dc.b  $A0
		dc.b   $A
		dc.b    0
		dc.b    0
		dc.b    0
		dc.b    0
		dc.b  $A0
		dc.b   $A
		dc.b  $50
		dc.b    5
		even

; =============== S U B R O U T I N E =======================================


sub_2863E:
		lea	(Chunk_table+$7000).l,a3
		moveq	#0,d0
		move.b	2(a4),d0
		subq.b	#1,d0
		move.w	d0,d3
		lsl.w	#7,d0
		move.w	d0,d1
		lsl.w	#2,d0
		add.w	d1,d0
		adda.w	d0,a3
		lsl.w	#2,d3
		lea	byte_28632(pc,d3.w),a1
		move.b	(a1)+,d3
		move.b	(a1)+,d4
		move.b	(a1)+,d5
		move.b	(a1)+,d6
		lea	(RAM_start+$1000).l,a1
		adda.w	(a4),a1
		move.w	#$200-1,d2

- ;loc_28672:
		move.b	(a1)+,d0
		beq.s	++ ;loc_28694
		move.b	d0,d1
		andi.b	#$F0,d0
		beq.s	+ ;loc_28686
		andi.b	#$F,(a3)
		add.b	d3,d0
		or.b	d0,(a3)

+ ;loc_28686:
		andi.b	#$F,d1
		beq.s	+ ;loc_28694
		andi.b	#$F0,(a3)
		add.b	d4,d1
		or.b	d1,(a3)

+ ;loc_28694:
		addq.w	#1,a3
		dbf	d2,- ;loc_28672
		move.w	#$80-1,d2

- ;loc_2869E:
		move.b	(a1)+,d0
		beq.s	loc_286DC
		move.b	d0,d1
		andi.b	#$F0,d0
		beq.s	++ ;loc_286BE
		bmi.s	+ ;loc_286B6
		andi.b	#$F,(a3)
		add.b	d3,d0
		or.b	d0,(a3)
		bra.s	++ ;loc_286BE
; ---------------------------------------------------------------------------

+ ;loc_286B6:
		andi.b	#$F,(a3)
		sub.b	d5,d0
		or.b	d0,(a3)

+ ;loc_286BE:
		andi.b	#$F,d1
		beq.s	loc_286DC
		btst	#3,d1
		bne.s	+ ;loc_286D4
		andi.b	#$F0,(a3)
		add.b	d4,d1
		or.b	d1,(a3)
		bra.s	loc_286DC
; ---------------------------------------------------------------------------

+ ;loc_286D4:
		andi.b	#$F0,(a3)
		sub.b	d6,d1
		or.b	d1,(a3)

loc_286DC:
		addq.w	#1,a3
		dbf	d2,- ;loc_2869E
		rts
; End of function sub_2863E


; =============== S U B R O U T I N E =======================================


AnimateTiles_DoAniPLC:
		lea	(Anim_Counters).w,a3

loc_286E8:
		move.w	(a2)+,d6			; Get number of scripts in list
		bpl.s	AnimateTiles_DoAniPLC_Part2	; If there are any, continue
		rts

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

AniPLC_FBZ1: zoneanimstart
	zoneanimdecl $3F, ArtUnc_AniFBZ__0, $210,  2,$20
		dc.b    0
		dc.b    0
		even
	zoneanimdecl   7, ArtUnc_AniFBZ__1, $230,  6,  8
		dc.b    0
		dc.b    8
		dc.b  $10
		dc.b    0
		dc.b    8
		dc.b  $10
		even
	zoneanimdecl   1, ArtUnc_AniFBZ__2, $238,  8,$10
		dc.b    0
		dc.b  $10
		dc.b  $20
		dc.b  $30
		dc.b  $40
		dc.b  $50
		dc.b  $60
		dc.b  $70
		even
	zoneanimdecl   7, ArtUnc_AniFBZ__3, $200,  2,  8
		dc.b    0
		dc.b    8
		even
	zoneanimdecl   7, ArtUnc_AniFBZ__4, $208,  6,  8
		dc.b    0
		dc.b    8
		dc.b  $10
		dc.b    0
		dc.b    8
		dc.b  $10
		even
	zoneanimend

AniPLC_FBZ2: zoneanimstart
	zoneanimdecl   1, ArtUnc_AniFBZ__0, $210,  8,$20
		dc.b    0
		dc.b  $20
		dc.b  $40
		dc.b  $60
		dc.b  $80
		dc.b  $A0
		dc.b  $C0
		dc.b  $E0
		even
	zoneanimdecl   7, ArtUnc_AniFBZ__1, $230,  6,  8
		dc.b    0
		dc.b    8
		dc.b  $10
		dc.b    0
		dc.b    8
		dc.b  $10
		even
	zoneanimdecl   1, ArtUnc_AniFBZ__2, $238,  8,$10
		dc.b    0
		dc.b  $10
		dc.b  $20
		dc.b  $30
		dc.b  $40
		dc.b  $50
		dc.b  $60
		dc.b  $70
		even
	zoneanimdecl   7, ArtUnc_AniFBZ__3, $200,  2,  8
		dc.b    0
		dc.b    8
		even
	zoneanimdecl   7, ArtUnc_AniFBZ__4, $208,  6,  8
		dc.b    0
		dc.b    8
		dc.b  $10
		dc.b    0
		dc.b    8
		dc.b  $10
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

AniPLC_MHZ: zoneanimstart
	zoneanimdecl  -1, ArtUnc_AniMHZ__0, $025,$14,  4
		dc.b    0, $18
		dc.b    4,   0
		dc.b    0,   0
		dc.b    4,   0
		dc.b    8,   0
		dc.b    4,   0
		dc.b    8,   0
		dc.b   $C,   0
		dc.b    8,   0
		dc.b   $C,   0
		dc.b    8,   0
		dc.b   $C,   0
		dc.b  $10,   0
		dc.b   $C,   0
		dc.b  $10,   0
		dc.b  $14,   0
		dc.b  $10,   0
		dc.b  $14, $31
		dc.b    0,   0
		dc.b  $14,   0
		even
	zoneanimdecl  -1, ArtUnc_AniMHZ__1, $019, $C,  4
		dc.b    0, $1D
		dc.b    4,   0
		dc.b    0,   0
		dc.b    4,   0
		dc.b    0,   0
		dc.b    4,   0
		dc.b    0,   0
		dc.b    4,   1
		dc.b    8, $1D
		dc.b   $C,   4
		dc.b  $10,   4
		dc.b  $14,   4
		even
	zoneanimdecl  -1, ArtUnc_AniMHZ__2, $05D,  8,  8
		dc.b    0,   4
		dc.b    8,   4
		dc.b  $10,   6
		dc.b    8,   4
		dc.b    0,   4
		dc.b  $18,   4
		dc.b  $20,   6
		dc.b  $18,   4
		even
	zoneanimdecl  -1, ArtUnc_AniMHZ__3, $01D,  8,  8
		dc.b  $10,   6
		dc.b    8,   4
		dc.b    0,   4
		dc.b  $18,   4
		dc.b  $20,   6
		dc.b  $18,   4
		dc.b    0,   4
		dc.b    8,   4
		even
	zoneanimend

AniPLC_LRZ1: zoneanimstart
	zoneanimdecl   5, ArtUnc_AniLRZ1_0, $354,  4,  4
		dc.b    0
		dc.b    4
		dc.b    8
		dc.b   $C
		even
	zoneanimdecl   5, ArtUnc_AniLRZ1_1, $350,  4,  4
		dc.b    0
		dc.b    4
		dc.b    8
		dc.b   $C
		even
	zoneanimend

AniPLC_LRZ2: zoneanimstart
	zoneanimdecl  -1, ArtUnc_AniLRZ2_0, $358,  3,  6
		dc.b    0,   2
		dc.b    6,   2
		dc.b   $C,   1
		even
	zoneanimdecl   1, ArtUnc_AniLRZ2_1, $350,  8,  8
		dc.b    0
		dc.b  $38
		dc.b  $30
		dc.b  $28
		dc.b  $20
		dc.b  $18
		dc.b  $10
		dc.b    8
		even
	zoneanimend

AniPLC_SSZ: zoneanimstart
	zoneanimdecl   7, ArtUnc_AniSSZ__0, $1F3,  4,$24
		dc.b    0
		dc.b  $24
		dc.b  $48
		dc.b  $6C
		even
	zoneanimdecl   7, ArtUnc_AniSSZ__1, $217,  4,  8
		dc.b    0
		dc.b    8
		dc.b  $10
		dc.b  $18
		even
	zoneanimdecl   7, ArtUnc_AniSSZ__2, $21F,  3,  8
		dc.b    0
		dc.b    8
		dc.b  $10
		dc.b  $18	; Unused; frame count is 3. There is no frame 4 in ArtUnc_AniSSZ__2, anyway
		even
	zoneanimdecl   2, ArtUnc_AniSSZ__3, $1D9,  4,  9
		dc.b    0
		dc.b    9
		dc.b  $12
		dc.b  $1B
		even
	zoneanimdecl   2, ArtUnc_AniSSZ__4, $1E2,  4,  4
		dc.b    0
		dc.b    4
		dc.b    8
		dc.b   $C
		even
	zoneanimdecl   2, ArtUnc_AniSSZ__5, $1E6,  4, $D
		dc.b    0
		dc.b   $D
		dc.b  $1A
		dc.b  $27
		even
	zoneanimend

AniPLC_DEZ: zoneanimstart
	zoneanimdecl   0, ArtUnc_AniDEZ__0, $0E4,  2,  2
		dc.b    0
		dc.b    2
		even
	zoneanimdecl   1, ArtUnc_AniDEZ__1, $1F4,  6,$1E
		dc.b    0
		dc.b  $1E
		dc.b  $3C
		dc.b    0
		dc.b  $1E
		dc.b  $3C
		even
	zoneanimdecl   3, ArtUnc_AniDEZ__2, $0EC,  8,  4
		dc.b    0
		dc.b    4
		dc.b    8
		dc.b   $C
		dc.b  $10
		dc.b  $14
		dc.b  $18
		dc.b  $1C
		even
	zoneanimdecl  -1, ArtUnc_AniDEZ__3, $05F,  4,  6
		dc.b    0,   9
		dc.b    6,   4
		dc.b   $C,   9
		dc.b    6,   4
		even
	zoneanimdecl   4, ArtUnc_AniDEZ__4, $04B,  4,  2
		dc.b    0
		dc.b    2
		dc.b    4
		dc.b    2
		even
	zoneanimdecl   4, ArtUnc_AniDEZ__5, $06B,  6,  3
		dc.b    0
		dc.b    3
		dc.b    6
		dc.b    0
		dc.b    3
		dc.b    6
		even
	zoneanimdecl   1, ArtUnc_AniDEZ__6, $028,  2,  8
		dc.b    0
		dc.b    8
		even
	zoneanimdecl   0, ArtUnc_AniDEZ__7, $26D,$84,  5
		dc.b    0
		dc.b  $2D
		dc.b    0
		dc.b  $2D
		dc.b    0
		dc.b  $2D
		dc.b    0
		dc.b  $2D
		dc.b    0
		dc.b  $2D
		dc.b    0
		dc.b  $2D
		dc.b    5
		dc.b  $2D
		dc.b    5
		dc.b  $2D
		dc.b    5
		dc.b  $2D
		dc.b    5
		dc.b  $2D
		dc.b    5
		dc.b  $2D
		dc.b    5
		dc.b  $2D
		dc.b   $A
		dc.b  $2D
		dc.b   $A
		dc.b  $2D
		dc.b   $A
		dc.b  $2D
		dc.b   $A
		dc.b  $2D
		dc.b   $A
		dc.b  $2D
		dc.b   $A
		dc.b  $2D
		dc.b   $F
		dc.b  $2D
		dc.b   $F
		dc.b  $2D
		dc.b   $F
		dc.b  $2D
		dc.b   $F
		dc.b  $2D
		dc.b   $F
		dc.b  $2D
		dc.b   $F
		dc.b  $2D
		dc.b  $14
		dc.b  $2D
		dc.b  $14
		dc.b  $2D
		dc.b  $14
		dc.b  $2D
		dc.b  $14
		dc.b  $2D
		dc.b  $14
		dc.b  $2D
		dc.b  $14
		dc.b  $2D
		dc.b  $19
		dc.b  $2D
		dc.b  $19
		dc.b  $2D
		dc.b  $19
		dc.b  $2D
		dc.b  $19
		dc.b  $2D
		dc.b  $19
		dc.b  $2D
		dc.b  $19
		dc.b  $2D
		dc.b  $1E
		dc.b  $2D
		dc.b  $1E
		dc.b  $2D
		dc.b  $1E
		dc.b  $2D
		dc.b  $1E
		dc.b  $2D
		dc.b  $1E
		dc.b  $2D
		dc.b  $1E
		dc.b  $2D
		dc.b  $23
		dc.b  $2D
		dc.b  $23
		dc.b  $2D
		dc.b  $23
		dc.b  $2D
		dc.b  $23
		dc.b  $2D
		dc.b  $23
		dc.b  $2D
		dc.b  $23
		dc.b  $2D
		dc.b  $28
		dc.b  $2D
		dc.b  $28
		dc.b  $2D
		dc.b  $28
		dc.b  $2D
		dc.b  $28
		dc.b  $2D
		dc.b  $28
		dc.b  $2D
		dc.b  $28
		dc.b  $2D
		dc.b  $28
		dc.b  $2D
		dc.b  $28
		dc.b  $2D
		dc.b  $28
		dc.b  $2D
		dc.b  $28
		dc.b  $2D
		dc.b  $28
		dc.b  $2D
		dc.b  $28
		dc.b  $2D
		dc.b  $28
		dc.b  $2D
		dc.b  $28
		dc.b  $2D
		dc.b  $28
		dc.b  $2D
		dc.b  $28
		dc.b  $2D
		dc.b  $28
		dc.b  $2D
		dc.b  $28
		dc.b  $2D
		even
	zoneanimend

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

AniPLC_Pachinko: zoneanimstart
	zoneanimdecl   0, ArtUnc_AniPachinko, $125,  8,$26
		dc.b  $26
		dc.b    0
		dc.b  $4C
		dc.b    0
		dc.b  $72
		dc.b    0
		dc.b  $98
		dc.b    0
		even
	zoneanimend

AniPLC_NULL: zoneanimstart
	zoneanimend

AniPLC_HPZ: zoneanimstart
	zoneanimdecl   2, ArtUnc_AniHPZ__0, $2D0,  8,  3
		dc.b    0
		dc.b    3
		dc.b    6
		dc.b    9
		dc.b   $C
		dc.b   $F
		dc.b  $12
		dc.b  $15
		even
	zoneanimdecl   3, ArtUnc_AniHPZ__1, $2D3,  6,  2
		dc.b    0
		dc.b    2
		dc.b    4
		dc.b    6
		dc.b    8
		dc.b   $A
		even
	zoneanimdecl   2, ArtUnc_AniHPZ__2, $2D5,  8,  4
		dc.b    0
		dc.b    4
		dc.b    8
		dc.b   $C
		dc.b  $10
		dc.b  $14
		dc.b  $18
		dc.b  $1C
		even
	zoneanimdecl   3, ArtUnc_AniHPZ__3, $2D9,  6,  3
		dc.b    0
		dc.b    3
		dc.b    6
		dc.b    9
		dc.b   $C
		dc.b   $F
		even
	zoneanimend
; ---------------------------------------------------------------------------

AnimateTiles_NULL3:
		rts

; =============== S U B R O U T I N E =======================================


Animate_Init:
		cmpi.w	#$100,(Current_zone_and_act).w
		bne.s	+ ;loc_28C8C
		bsr.w	sub_279D4

+ ;loc_28C8C:
		cmpi.w	#$101,(Current_zone_and_act).w
		bne.s	+ ;loc_28CA0
		move.b	#$20,(Anim_Counters+1).w
		move.b	#$40,(Anim_Counters+3).w

+ ;loc_28CA0:
		cmpi.b	#3,(Current_zone).w
		bne.s	+ ;loc_28CD8
		move.b	#$40,(Anim_Counters+1).w
		move.b	#0,(Anim_Counters+2).w
		move.b	#0,(Anim_Counters+4).w
		move.b	#0,(Anim_Counters+6).w
		move.b	#2,(Anim_Counters+8).w
		move.b	#2,(Anim_Counters+$A).w
		move.b	#2,(Anim_Counters+$C).w
		move.b	#1,(Anim_Counters+$E).w

+ ;loc_28CD8:
		cmpi.w	#$600,(Current_zone_and_act).w
		bne.s	+ ;loc_28CE6
		move.b	#$20,(Anim_Counters+3).w

+ ;loc_28CE6:
		cmpi.w	#$601,(Current_zone_and_act).w
		bne.s	+ ;loc_28CF8
		bsr.w	sub_2807A
		move.b	#$10,(Anim_Counters+1).w

+ ;loc_28CF8:
		cmpi.b	#7,(Current_zone).w
		bne.s	+ ;loc_28D0C
		move.b	#$20,(Anim_Counters+1).w
		move.b	#$40,(Anim_Counters+3).w

+ ;loc_28D0C:
		cmpi.b	#8,(Current_zone).w
		bne.s	+ ;loc_28D1A
		move.b	#-1,(Anim_Counters+1).w

+ ;loc_28D1A:
		cmpi.w	#$900,(Current_zone_and_act).w
		bne.s	+ ;loc_28D2E
		move.b	#-1,(Anim_Counters+1).w
		move.b	#-1,(Anim_Counters+3).w

+ ;loc_28D2E:
		cmpi.w	#$1000,(Current_zone_and_act).w
		bne.s	+ ;loc_28D42
		move.b	#$40,(Anim_Counters+1).w
		move.b	#$40,(Anim_Counters+3).w

+ ;loc_28D42:
		cmpi.b	#$14,(Current_zone).w
		bne.s	+ ;loc_28DA2
		lea	(ArtKos_PachinkoBG1).l,a0
		lea	(RAM_start+$1000).l,a1
		jsr	(Kos_Decomp).l
		lea	(ArtKos_PachinkoBG2).l,a0
		lea	(Chunk_table+$7000).l,a1
		jsr	(Kos_Decomp).l
		lea	(RAM_start+$6000).l,a1
		lea	(Chunk_table+$7000).l,a2
		moveq	#$C-1,d0

- ;loc_28D7C:
		moveq	#$20-1,d1

- ;loc_28D7E:
		move.l	(a2),$80(a1)
		move.l	(a2)+,(a1)+
		dbf	d1,- ;loc_28D7E
		lea	$80(a1),a1
		dbf	d0,-- ;loc_28D7C
		lea	(PalKos_Pachinko).l,a0
		lea	(Chunk_table+$7800).l,a1
		jsr	(Kos_Decomp).l

+ ;loc_28DA2:
		cmpi.w	#$1600,(Current_zone_and_act).w
		bne.s	locret_28DB6
		move.b	#-1,(Anim_Counters+1).w
		move.b	#-1,(Anim_Counters+3).w

locret_28DB6:
		rts
; End of function Animate_Init


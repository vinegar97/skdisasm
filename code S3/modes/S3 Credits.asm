S3Credits:
		moveq	#signextendB(mus_Stop),d0
		jsr	(Play_Music).l
		jsr	(Clear_Nem_Queue).l
		jsr	(Pal_FadeToBlack).l
		lea	(VDP_control_port).l,a6
		move.w	#$8004,(a6)			; Command $8004 - Disable HInt, HV Counter
		move.w	#$8230,(a6)			; Command $8230 - Nametable A at $C000
		move.w	#$8407,(a6)			; Command $8407 - Nametable B at $E000
		move.w	#$8700,(a6)			; Command $8700 - BG color is Pal 0 Color 0
		move.w	#$8B03,(a6)			; Command $8B03 - Vscroll full, HScroll line-based
		move.w	#$8C81,(a6)			; Command $8C81 - 40cell screen size, no interlacing, no s/h
		move.w	#$9011,(a6)			; 128-cell hScroll table size: 64x64
		move.w	#$9200,(a6)			; Command $9200 - Window V position at default
		clr.b	(Water_full_screen_flag).w
		clr.w	(Competition_mode).w
		move	#$2700,sr
		move.w	(VDP_reg_1_command).w,d0
		andi.b	#$BF,d0
		move.w	d0,(VDP_control_port).l
		jsr	(Clear_DisplayData).l
		; Bug: this should be $280
		clearRAM	Sprite_table,$280+4
		; Bug: this should be $400
		clearRAM	H_scroll_buffer,$400+4
		clearRAM	Sprite_table_input,$400
		clearRAM	Player_1,$2000
		clearRAM	RAM_start+$2000,$2000
		clearRAM	_unkFA80,$80
		clr.w	(DMA_queue).w
		move.l	#DMA_queue,(DMA_queue_slot).w
		clr.w	(Player_mode).w
		clr.b	(Current_act_2P).w
		clr.w	(Results_screen_2P).w
		clr.b	(Level_started_flag).w
		clr.w	(Anim_Counters).w
		clr.w	(_unkFF98).w
		clr.w	(Competition_mode).w
		clr.l	(Camera_X_pos).w
		clr.l	(Camera_Y_pos).w
		clr.l	(V_scroll_value).w
		clr.l	(_unkF61A).w
		jsr	(Init_SpriteTable).l
		move.l	#vdpComm(tiles_to_bytes($001),VRAM,WRITE),(VDP_control_port).l
		lea	(ArtNem_S38x16Font).l,a0
		jsr	(Nem_Decomp).l
		move.l	#vdpComm(tiles_to_bytes($029),VRAM,WRITE),(VDP_control_port).l
		lea	(ArtNem_S3CreditsText).l,a0
		jsr	(Nem_Decomp).l
		move.l	#vdpComm(tiles_to_bytes($08E),VRAM,WRITE),(VDP_control_port).l
		lea	(ArtNem_EndingGraphics).l,a0
		jsr	(Nem_Decomp).l
		lea	(ArtKosM_AIZIntroEmeralds).l,a1
		move.w	#tiles_to_bytes($211),d2
		jsr	(Queue_Kos_Module).l
		lea	S3CreditsText_Main(pc),a1
		move.w	(a1),d0
		adda.w	d0,a1
		bsr.w	sub_40A4A
		lea	(Pal_Ending).l,a1
		lea	(Target_palette).w,a2
		moveq	#bytesToLcnt($40),d6

loc_404AC:
		move.l	(a1)+,(a2)+
		dbf	d6,loc_404AC
		moveq	#signextendB(mus_Credits3),d0
		jsr	(Play_Music).l
		move.w	#3*60,(_unkFA82).w
		move.b	#$18,(V_int_routine).w
		jsr	(Wait_VSync).l
		move.w	(VDP_reg_1_command).w,d0
		ori.b	#$40,d0
		move.w	d0,(VDP_control_port).l
		jsr	(Pal_FadeFromBlack).l

loc_404E0:
		move.b	#$18,(V_int_routine).w
		jsr	(Process_Kos_Queue).l
		jsr	(Wait_VSync).l
		addq.w	#1,(Level_frame_counter).w
		jsr	(Process_Sprites).l
		jsr	(Render_Sprites).l
		bsr.w	sub_4051E
		jsr	(Process_Nem_Queue_Init).l
		jsr	(Process_Kos_Module_Queue).l
		cmpi.b	#$20,(Game_mode).w
		beq.w	loc_404E0
		rts

; =============== S U B R O U T I N E =======================================


sub_4051E:
		move.w	(_unkFA86).w,d0
		move.w	off_4052A(pc,d0.w),d0
		jmp	off_4052A(pc,d0.w)
; End of function sub_4051E

; ---------------------------------------------------------------------------
off_4052A:
		dc.w loc_40530-off_4052A
		dc.w loc_405AE-off_4052A
		dc.w locret_4069C-off_4052A
; ---------------------------------------------------------------------------

loc_40530:
		subq.w	#1,(_unkFA82).w
		bmi.s	loc_40538
		rts
; ---------------------------------------------------------------------------

loc_40538:
		move.w	#3*60,(_unkFA82).w
		jsr	(Pal_FadeToBlack).l
		clearRAM	RAM_start+$2000,$1000
		move.w	(_unkFA84).w,d0
		addq.w	#2,d0
		move.w	d0,(_unkFA84).w
		lea	S3CreditsText_Main(pc),a1
		move.w	(a1,d0.w),d0
		beq.w	loc_405FA
		lea	(a1,d0.w),a1
		bsr.w	sub_40A4A
		move.b	#$18,(V_int_routine).w
		jsr	(Wait_VSync).l
		jmp	(Pal_FadeFromBlack).l
; ---------------------------------------------------------------------------
		move.w	#2,(_unkFA86).w
		lea	S3CreditsText_Dummy(pc),a1
		move.w	(a1),d0
		adda.w	d0,a1
		bsr.w	sub_40A4A
		lea	(Target_palette).w,a1
		lea	(Normal_palette).w,a2
		moveq	#bytesToLcnt($80),d6

loc_405A2:
		move.l	(a1)+,(a2)+
		dbf	d6,loc_405A2
		clr.w	(_unkFA84).w
		rts
; ---------------------------------------------------------------------------

loc_405AE:
		move.w	(V_scroll_value).w,d0
		addq.w	#1,d0
		move.w	d0,(V_scroll_value).w
		andi.w	#$FF,d0
		beq.s	loc_405C0
		rts
; ---------------------------------------------------------------------------

loc_405C0:
		move.w	(_unkFA84).w,d0
		addq.w	#2,d0
		move.w	d0,(_unkFA84).w
		lea	(RAM_start+$2000).l,a2
		btst	#1,d0
		bne.s	loc_405DC
		lea	(RAM_start+$3000).l,a2

loc_405DC:
		moveq	#0,d2
		move.w	#bytesToLcnt($1000),d3

loc_405E2:
		move.l	d2,(a2)+
		dbf	d3,loc_405E2
		lea	S3CreditsText_Dummy(pc),a1
		move.w	(a1,d0.w),d0
		beq.s	loc_405FA
		lea	(a1,d0.w),a1
		bra.w	sub_40A4A
; ---------------------------------------------------------------------------

loc_405FA:
		jsr	(Pal_FadeToBlack).l
		move.w	#4,(_unkFA86).w
		lea	Pal_EndingEyecatchKnuckles(pc),a1
		cmpi.w	#7,(Chaos_emerald_count).w
		bne.s	loc_40616
		lea	Pal_EndingS3Logo(pc),a1

loc_40616:
		lea	(Target_palette_line_3).w,a2
		moveq	#bytesToLcnt($40),d0

loc_4061C:
		move.l	(a1)+,(a2)+
		dbf	d0,loc_4061C
		clearRAM	RAM_start+$2000,$2000
		bset	#0,(_unkFA88).w
		clr.l	(V_scroll_value).w
		lea	Child6_EndingS3Logo(pc),a1
		cmpi.w	#7,(Chaos_emerald_count).w
		beq.s	loc_40656
		lea	S3CreditsText_TryAgain(pc),a1
		bsr.w	sub_40A4A
		lea	Child6_EndingTryAgain(pc),a1

loc_40656:
		move.w	(a1)+,d0
		lea	(Dynamic_object_RAM+object_size).w,a2

loc_4065C:
		move.l	(a1)+,(a2)
		lea	next_object(a2),a2
		dbf	d0,loc_4065C
		jsr	(Process_Sprites).l
		jsr	(Render_Sprites).l
		move.b	#$18,(V_int_routine).w
		jsr	(Wait_VSync).l
		jmp	(Pal_FadeFromBlack).l
; ---------------------------------------------------------------------------
Child6_EndingS3Logo:
		dc.w 3-1
		dc.l loc_4069E
		dc.l loc_4078C
		dc.l loc_407FC
Child6_EndingTryAgain:
		dc.w 2-1
		dc.l loc_40896
		dc.l loc_409A2
; ---------------------------------------------------------------------------

locret_4069C:
		rts
; ---------------------------------------------------------------------------

loc_4069E:
		move.l	#loc_406E2,(a0)
		move.w	a0,(_unkFAA4).w
		move.l	#Map_EndingGraphics,mappings(a0)
		move.w	#make_art_tile($08E,2,1),art_tile(a0)
		move.w	#$280,priority(a0)
		move.b	#$40,width_pixels(a0)
		move.b	#$40,height_pixels(a0)
		move.b	#0,mapping_frame(a0)
		move.w	#$120,x_pos(a0)
		move.w	#$40,y_pos(a0)
		move.w	#60,$2E(a0)
		rts
; ---------------------------------------------------------------------------

loc_406E2:
		subq.w	#1,$2E(a0)
		bmi.s	loc_406EA
		rts
; ---------------------------------------------------------------------------

loc_406EA:
		move.l	#loc_406F0,(a0)

loc_406F0:
		jsr	(MoveSprite).l
		cmpi.w	#$F0,y_pos(a0)
		bcs.s	loc_40712
		move.w	y_vel(a0),d0
		bmi.s	loc_40712
		asr.w	#1,d0
		cmpi.w	#$80,d0
		bcs.s	loc_40718
		neg.w	d0
		move.w	d0,y_vel(a0)

loc_40712:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_40718:
		move.l	#loc_40728,(a0)
		move.w	#$F0,y_pos(a0)
		clr.w	$2E(a0)

loc_40728:
		subq.w	#1,$2E(a0)
		bmi.s	loc_40734
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_40734:
		move.w	#1,$2E(a0)
		move.w	$3A(a0),d0
		cmpi.w	#6,d0
		bcc.s	loc_40762
		addq.w	#1,$3A(a0)
		lsl.w	#5,d0
		lea	Pal_EndingS3LogoFlash(pc),a1
		adda.w	d0,a1
		lea	(Normal_palette_line_3).w,a2
		moveq	#bytesToLcnt($20),d0

loc_40756:
		move.l	(a1)+,(a2)+
		dbf	d0,loc_40756
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_40762:
		move.l	#loc_40774,(a0)
		move.w	#6*60,$2E(a0)
		bset	#5,$38(a0)

loc_40774:
		subq.w	#1,$2E(a0)
		bmi.s	loc_40780
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_40780:
		move.b	#0,(Game_mode).w
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_4078C:
		move.l	#loc_407CC,(a0)
		move.l	#Map_EndingGraphics,mappings(a0)
		move.w	#make_art_tile($08E,3,1),art_tile(a0)
		move.w	#$100,priority(a0)
		move.b	#$18,width_pixels(a0)
		move.b	#$18,height_pixels(a0)
		move.b	#1,mapping_frame(a0)
		move.w	#$100,x_pos(a0)
		move.w	#$11C,y_pos(a0)
		move.l	#AniRaw_41932,$30(a0)

loc_407CC:
		bsr.w	sub_407DC
		jsr	(Animate_Raw).l
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_407DC:
		movea.w	(_unkFAA4).w,a1
		btst	#5,$38(a1)
		beq.s	locret_407FA
		clr.b	anim_frame_timer(a0)
		clr.b	anim_frame(a0)
		move.l	#AniRaw_41936,$30(a0)
		move.l	(sp),(a0)

locret_407FA:
		rts
; End of function sub_407DC

; ---------------------------------------------------------------------------

loc_407FC:
		move.l	#loc_40844,(a0)
		move.l	#Map_EndingGraphics,mappings(a0)
		move.w	#make_art_tile($08E,3,1),art_tile(a0)
		move.w	#$100,priority(a0)
		move.b	#$C,width_pixels(a0)
		move.b	#$18,height_pixels(a0)
		move.b	#1,mapping_frame(a0)
		bset	#0,render_flags(a0)
		move.w	#$140,x_pos(a0)
		move.w	#$11C,y_pos(a0)
		lea	ChildObjDat_4192A(pc),a2
		jsr	(CreateChild1_Normal).l

loc_40844:
		lea	AniRaw_41941(pc),a1
		jsr	(Animate_RawNoSST).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_40854:
		move.l	#loc_40886,(a0)
		move.l	#Map_EndingGraphics,mappings(a0)
		move.w	#make_art_tile($08E,3,1),art_tile(a0)
		move.w	#$180,priority(a0)
		move.b	#$C,width_pixels(a0)
		move.b	#$C,height_pixels(a0)
		move.b	#1,mapping_frame(a0)
		bset	#0,render_flags(a0)

loc_40886:
		lea	AniRaw_41945(pc),a1
		jsr	(Animate_RawNoSST).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_40896:
		move.l	#loc_408D6,(a0)
		move.l	#Map_EndingGraphics,mappings(a0)
		move.w	#make_art_tile($08E,2,1),art_tile(a0)
		move.w	#$100,priority(a0)
		move.b	#$10,width_pixels(a0)
		move.b	#$14,height_pixels(a0)
		move.b	#$C,mapping_frame(a0)
		move.w	#$12C,x_pos(a0)
		move.w	#$E8,y_pos(a0)
		move.l	#loc_408E6,$34(a0)

loc_408D6:
		lea	AniRaw_41950(pc),a1
		jsr	(Animate_RawNoSSTMultiDelay).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_408E6:
		move.l	#loc_408F0,(a0)
		bra.w	loc_40A02
; ---------------------------------------------------------------------------

loc_408F0:
		movea.w	$44(a0),a1
		btst	#7,status(a1)
		beq.s	loc_4090A
		move.l	#loc_40910,(a0)
		move.l	#loc_40920,$34(a0)

loc_4090A:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_40910:
		lea	AniRaw_41959(pc),a1
		jsr	(Animate_RawNoSSTMultiDelay).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_40920:
		move.l	#loc_408D6,(a0)
		move.l	#loc_408E6,$34(a0)
		rts
; ---------------------------------------------------------------------------

loc_40930:
		move.l	#loc_40962,(a0)
		move.l	#Map_AIZIntroEmeralds,mappings(a0)
		move.w	#make_art_tile($211,3,1),art_tile(a0)
		move.w	#$80,priority(a0)
		move.b	#4,width_pixels(a0)
		move.b	#4,height_pixels(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		add.w	d0,d0
		move.w	d0,$2E(a0)

loc_40962:
		subq.w	#1,$2E(a0)
		bpl.s	loc_40974
		move.l	#loc_4097A,(a0)
		move.w	#-$300,y_vel(a0)

loc_40974:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_4097A:
		jsr	(MoveSprite_LightGravity).l
		tst.w	y_vel(a0)
		bmi.s	loc_4099C
		movea.w	$46(a0),a1
		move.w	y_pos(a1),d0
		subq.w	#4,d0
		cmp.w	y_pos(a0),d0
		bhi.s	loc_4099C
		jsr	(Go_Delete_Sprite).l

loc_4099C:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_409A2:
		move.l	#loc_409E0,(a0)
		move.l	#Map_EndingGraphics,mappings(a0)
		move.w	#make_art_tile($08E,2,1),art_tile(a0)
		move.w	#$180,priority(a0)
		move.b	#$14,width_pixels(a0)
		move.b	#$1C,height_pixels(a0)
		move.b	#$E,mapping_frame(a0)
		move.w	#$118,x_pos(a0)
		move.w	#$E0,y_pos(a0)
		move.w	#6*60,$2E(a0)

loc_409E0:
		subq.w	#1,$2E(a0)
		bmi.s	loc_409F6
		lea	AniRaw_4194C(pc),a1
		jsr	(Animate_RawNoSST).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_409F6:
		move.b	#0,(Game_mode).w
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_40A02:
		lea	(Collected_emeralds_array).w,a2
		moveq	#0,d1
		moveq	#0,d2
		moveq	#7-1,d3

loc_40A0C:
		tst.b	(a2)+
		bne.s	loc_40A42
		jsr	(AllocateObject).l
		bne.s	loc_40A42
		move.l	#loc_40930,(a1)
		move.b	d1,mapping_frame(a1)
		move.b	d2,subtype(a1)
		move.w	x_pos(a0),d4
		addi.w	#$C,d4
		move.w	d4,x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		move.w	a0,$46(a1)
		addq.b	#2,d2
		move.w	a1,$44(a0)

loc_40A42:
		addq.b	#1,d1
		dbf	d3,loc_40A0C
		rts

; =============== S U B R O U T I N E =======================================


sub_40A4A:
		move.w	(a1)+,d6

loc_40A4C:
		bsr.w	sub_40A5C
		dbf	d6,loc_40A4C
		bset	#0,(_unkFA88).w
		rts
; End of function sub_40A4A


; =============== S U B R O U T I N E =======================================


sub_40A5C:
		lea	(RAM_start+$2000).l,a2
		move.w	(a1)+,d0
		adda.w	d0,a2

loc_40A66:
		moveq	#0,d0
		move.b	(a1)+,d0
		beq.w	loc_40B10
		move.w	d0,d1
		subi.b	#"a",d0
		bcs.s	loc_40A9A
		lea	(S3Credits_PlaneMapSmall).l,a3
		lsl.w	#2,d0
		adda.w	d0,a3
		move.w	(a3)+,(a2)+
		move.l	a2,d2
		addi.w	#$7E,d2
		andi.l	#$FFFF3FFF,d2
		ori.l	#$2000,d2
		movea.l	d2,a4
		move.w	(a3)+,(a4)
		bra.s	loc_40A66
; ---------------------------------------------------------------------------

loc_40A9A:
		cmpi.b	#" ",d1
		bne.s	loc_40AA6
		moveq	#$1D,d1
		bra.w	loc_40ACE
; ---------------------------------------------------------------------------

loc_40AA6:
		cmpi.b	#".",d1
		bne.s	loc_40AB2
		moveq	#$1A,d1
		bra.w	loc_40ACE
; ---------------------------------------------------------------------------

loc_40AB2:
		cmpi.b	#"(",d1
		bne.s	loc_40ABE
		moveq	#$1B,d1
		bra.w	loc_40ACE
; ---------------------------------------------------------------------------

loc_40ABE:
		cmpi.b	#")",d1
		bne.s	loc_40ACA
		moveq	#$1C,d1
		bra.w	loc_40ACE
; ---------------------------------------------------------------------------

loc_40ACA:
		subi.b	#"A",d1

loc_40ACE:
		add.w	d1,d1
		lea	(S3Credits_PlaneMapLarge).l,a3
		move.w	(a3,d1.w),d1
		lea	(a3,d1.w),a3
		move.w	(a3)+,d0
		movea.l	a2,a4
		moveq	#2,d3

loc_40AE4:
		move.w	d0,d1
		movea.l	a4,a5

loc_40AE8:
		move.w	(a3)+,(a5)+
		dbf	d1,loc_40AE8
		move.l	a4,d2
		addi.w	#$80,d2
		andi.l	#$FFFF3FFF,d2
		ori.l	#$2000,d2
		movea.l	d2,a4
		dbf	d3,loc_40AE4
		addq.w	#1,d0
		add.w	d0,d0
		adda.w	d0,a2
		bra.w	loc_40A66
; ---------------------------------------------------------------------------

loc_40B10:
		move.l	a1,d0
		btst	#0,d0
		beq.s	locret_40B1A
		addq.l	#1,a1

locret_40B1A:
		rts
; End of function sub_40A5C

; ---------------------------------------------------------------------------
S3CreditsText_TryAgain:
		dc.w 1-1
		dc.w $996
		dc.b "TRY  AGAIN",0
		even
S3CreditsText_Main:
		dc.w word_40B7C-S3CreditsText_Main
		dc.w word_40B94-S3CreditsText_Main
		dc.w word_40BC2-S3CreditsText_Main
		dc.w word_40BEC-S3CreditsText_Main
		dc.w word_40C16-S3CreditsText_Main
		dc.w word_40C42-S3CreditsText_Main
		dc.w word_40C5E-S3CreditsText_Main
		dc.w word_40C86-S3CreditsText_Main
		dc.w word_40CB8-S3CreditsText_Main
		dc.w word_40CFC-S3CreditsText_Main
		dc.w word_40D1E-S3CreditsText_Main
		dc.w word_40D62-S3CreditsText_Main
		dc.w word_40D90-S3CreditsText_Main
		dc.w word_40DB6-S3CreditsText_Main
		dc.w word_40DDA-S3CreditsText_Main
		dc.w word_40E00-S3CreditsText_Main
		dc.w word_40E34-S3CreditsText_Main
		dc.w word_40E68-S3CreditsText_Main
		dc.w word_40EA4-S3CreditsText_Main
		dc.w word_40EC6-S3CreditsText_Main
		dc.w word_40EF8-S3CreditsText_Main
		dc.w word_40F2A-S3CreditsText_Main
		dc.w word_40F5E-S3CreditsText_Main
		dc.w word_40F88-S3CreditsText_Main
		dc.w word_40FB8-S3CreditsText_Main
		dc.w word_40FF4-S3CreditsText_Main
		dc.w word_41028-S3CreditsText_Main
		dc.w word_4105C-S3CreditsText_Main
		dc.w word_4108C-S3CreditsText_Main
		dc.w word_410D8-S3CreditsText_Main
		dc.w word_41124-S3CreditsText_Main
		dc.w word_4117C-S3CreditsText_Main
		dc.w word_411B0-S3CreditsText_Main
		dc.w word_411F4-S3CreditsText_Main
		dc.w word_41244-S3CreditsText_Main
		dc.w word_41290-S3CreditsText_Main
		dc.w word_412C4-S3CreditsText_Main
		dc.w word_41314-S3CreditsText_Main
		dc.w word_4134C-S3CreditsText_Main
		dc.w 0
word_40B7C:	dc.w 2-1
		dc.w $598
		dc.b "SONIC  III",0
		even
		dc.w $8A2
		dc.b "staff",0
		even
word_40B94:	dc.w 2-1
		dc.w $48E
		dc.b "    executive producer",0
		even
		dc.w $78A
		dc.b "HAYAO  NAKAYAMA",0
		even
word_40BC2:	dc.w 2-1
		dc.w $490
		dc.b "    project manager",0
		even
		dc.w $78E
		dc.b "HISASHI  SUZUKI",0
		even
word_40BEC:	dc.w 2-1
		dc.w $490
		dc.b "    project manager",0
		even
		dc.w $78A
		dc.b "SHINOBU  TOYODA",0
		even
word_40C16:	dc.w 2-1
		dc.w $490
		dc.b "    project manager",0
		even
		dc.w $78A
		dc.b "MASAHARU  YOSHII",0
		even
word_40C42:	dc.w 2-1
		dc.w $4A0
		dc.b "producer",0
		even
		dc.w $798
		dc.b "YUJ I  NAKA",0
		even
word_40C5E:	dc.w 2-1
		dc.w $498
		dc.b "    director",0
		even
		dc.w $786
		dc.b "HIROKAZU  YASUHARA",0
		even
word_40C86:	dc.w 2-1
		dc.w $48C
		dc.b "     lead game designer",0
		even
		dc.w $786
		dc.b "HIROKAZU  YASUHARA",0
		even
word_40CB8:	dc.w 3-1
		dc.w $48A
		dc.b "    senior game designers",0
		even
		dc.w $688
		dc.b "HISAYOSHI YOSHIDA",0
		even
		dc.w $990
		dc.b "TAKASHI  IIZUKA",0
		even
word_40CFC:	dc.w 2-1
		dc.w $498
		dc.b "lead programmer",0
		even
		dc.w $796
		dc.b "YUJ I  NAKA",0
		even
word_40D1E:	dc.w 3-1
		dc.w $48E
		dc.b "    senior programmers",0
		even
		dc.w $688
		dc.b "HIROSHI NIKAIDOH",0
		even
		dc.w $980
		dc.b "MASANOBU YAMAMOTO",0
		even
word_40D62:	dc.w 2-1
		dc.w $496
		dc.b "character designer",0
		even
		dc.w $784
		dc.b "TAKASHI THOMAS YUDA",0
		even
word_40D90:	dc.w 2-1
		dc.w $496
		dc.b "    cg  artist",0
		even
		dc.w $78E
		dc.b "KUNITAKE   AOKI",0
		even
word_40DB6:	dc.w 2-1
		dc.w $4A0
		dc.b "animator",0
		even
		dc.w $784
		dc.b "TAKASHI THOMAS YUDA",0
		even
word_40DDA:	dc.w 2-1
		dc.w $49A
		dc.b "enemy artist",0
		even
		dc.w $786
		dc.b "SATOSHI YOKOKAWA",0
		even
word_40E00:	dc.w 3-1
		dc.w $498
		dc.b "scene artists",0
		even
		dc.w $690
		dc.b "KUNITAKE  AOKI",0
		even
		dc.w $992
		dc.b "CHIE YOSHIDA",0
		even
word_40E34:	dc.w 3-1
		dc.w $49A
		dc.b "scene artists",0
		even
		dc.w $690
		dc.b "TSUNEKO  AOKI",0
		even
		dc.w $990
		dc.b "SHIGERU  OKADA",0
		even
word_40E68:	dc.w 3-1
		dc.w $49A
		dc.b "scene artists",0
		even
		dc.w $684
		dc.b "TAKASHI THOMAS YUDA",0
		even
		dc.w $986
		dc.b "SATOSHI YOKOKAWA",0
		even
word_40EA4:	dc.w 2-1
		dc.w $498
		dc.b "art assistant",0
		even
		dc.w $78E
		dc.b "OSAMU  OHASHI",0
		even
word_40EC6:	dc.w 3-1
		dc.w $498
		dc.b "music composers",0
		even
		dc.w $694
		dc.b "BRAD  BUXER",0
		even
		dc.w $98E
		dc.b "BOBBY BROOKS",0
		even
word_40EF8:	dc.w 3-1
		dc.w $498
		dc.b "music composers",0
		even
		dc.w $692
		dc.b "DARRYL  ROSS",0
		even
		dc.w $992
		dc.b "GEOFF GRACE",0
		even
word_40F2A:	dc.w 3-1
		dc.w $498
		dc.b "music composers",0
		even
		dc.w $68C
		dc.b "DOUG  GRIGSBY III",0
		even
		dc.w $996
		dc.b "SCIROCCO",0
		even
word_40F5E:	dc.w 3-1
		dc.w $498
		dc.b "sega sound team",0
		even
		dc.w $6A2
		dc.b "BO",0
		even
		dc.w $98E
		dc.b "SACHIO  OGAWA",0
		even
word_40F88:	dc.w 3-1
		dc.w $498
		dc.b "sega sound team",0
		even
		dc.w $69C
		dc.b "MILPO",0
		even
		dc.w $986
		dc.b "MASARU  SETSUMARU",0
		even
word_40FB8:	dc.w 3-1
		dc.w $498
		dc.b "sega sound team",0
		even
		dc.w $68A
		dc.b "TATSUYUKI  MAEDA",0
		even
		dc.w $986
		dc.b "TOMONORI  SAWADA",0
		even
word_40FF4:	dc.w 3-1
		dc.w $498
		dc.b "sega sound team",0
		even
		dc.w $68C
		dc.b "MASAYUKI NAGAO",0
		even
		dc.w $994
		dc.b "J UN SENOUE",0
		even
word_41028:	dc.w 2-1
		dc.w $490
		dc.b "sound project coordinator",0
		even
		dc.w $78A
		dc.b "    HISAKI  NIMIYA",0
		even
word_4105C:	dc.w 2-1
		dc.w $490
		dc.b "       marketing      ",0
		even
		dc.w $78A
		dc.b "    PAMELA  KELLY",0
		even
word_4108C:	dc.w 3-1
		dc.w $490
		dc.b " executive management ",0
		even
		dc.w $680
		dc.b " SHOUICHIROU IRIMAJ IRI",0
		even
		dc.w $98A
		dc.b "  TOM  KAL INSKE  ",0
		even
word_410D8:	dc.w 3-1
		dc.w $490
		dc.b " executive coordinator",0
		even
		dc.w $680
		dc.b "     MAMORU  SHIGETA    ",0
		even
		dc.w $98A
		dc.b "  TOMIO  TAKAMI  ",0
		even
word_41124:	dc.w 3-1
		dc.w $490
		dc.b " executive coordinator",0
		even
		dc.w $680
		dc.b "    DIANE  A  FORNASIER   ",0
		even
		dc.w $980
		dc.b "       ROGER  HECTOR      ",0
		even
word_4117C:	dc.w 2-1
		dc.w $490
		dc.b " executive coordinator",0
		even
		dc.w $780
		dc.b " TAKAHARU  UTSUNOMIYA",0
		even
word_411B0:	dc.w 3-1
		dc.w $490
		dc.b " sound special thanks ",0
		even
		dc.w $680
		dc.b " MAYUMI NINA SAKAZAKI",0
		even
		dc.w $98A
		dc.b "        (MRM)",0
		even
word_411F4:	dc.w 3-1
		dc.w $490
		dc.b " sound special thanks ",0
		even
		dc.w $680
		dc.b "         CUBE  CORP.   ",0
		even
		dc.w $980
		dc.b "         OPUS CORP.   ",0
		even
word_41244:	dc.w 3-1
		dc.w $490
		dc.b " sound special thanks ",0
		even
		dc.w $680
		dc.b "  MASANORI  NAKAYAMA",0
		even
		dc.w $980
		dc.b "       (STUDIO WHO) ",0
		even
word_41290:	dc.w 2-1
		dc.w $490
		dc.b " sound special thanks ",0
		even
		dc.w $780
		dc.b "     HOWARD  DROSSIN",0
		even
word_412C4:	dc.w 3-1
		dc.w $490
		dc.b "    special thanks    ",0
		even
		dc.w $680
		dc.b "   DEBORAH MCCRACKEN  ",0
		even
		dc.w $980
		dc.b "       EMI  KAWAMURA  ",0
		even
word_41314:	dc.w 2-1
		dc.w $490
		dc.b "    special thanks    ",0
		even
		dc.w $780
		dc.b "       J INA  ISHIWATARI",0
		even
word_4134C:	dc.w 2-1
		dc.w $490
		dc.b "     presented by",0
		even
		dc.w $78A
		dc.b "          SEGA           ",0
		even
S3CreditsText_Dummy:
		dc.w word_4138C-S3CreditsText_Dummy
		dc.w word_41396-S3CreditsText_Dummy
		dc.w word_413A0-S3CreditsText_Dummy
		dc.w word_413AA-S3CreditsText_Dummy
		dc.w word_413B4-S3CreditsText_Dummy
		dc.w word_413BE-S3CreditsText_Dummy
		dc.w 0
word_4138C:	dc.w 2-1
		dc.w $1310
		dc.b "a",0
		even
		dc.w $1710
		dc.b "A",0
		even
word_41396:	dc.w 2-1
		dc.w $1310
		dc.b "b",0
		even
		dc.w $1710
		dc.b "B",0
		even
word_413A0:	dc.w 2-1
		dc.w $1310
		dc.b "c",0
		even
		dc.w $1710
		dc.b "C",0
		even
word_413AA:	dc.w 2-1
		dc.w $310
		dc.b "d",0
		even
		dc.w $710
		dc.b "D",0
		even
word_413B4:	dc.w 2-1
		dc.w $1310
		dc.b "e",0
		even
		dc.w $1710
		dc.b "E",0
		even
word_413BE:	dc.w 2-1
		dc.w $310
		dc.b "f",0
		even
		dc.w $710
		dc.b "F",0
		even
S3Credits_PlaneMapSmall:
		dc.w    1,   2	; a
		dc.w    3,   4	; b
		dc.w    5,   6	; c
		dc.w    7,   8	; d
		dc.w    9,  $A	; e
		dc.w    9,  $B	; f
		dc.w   $C,   6	; g
		dc.w   $D,   2	; h
		dc.w   $E,  $F	; i
		dc.w  $10,   6	; j
		dc.w  $11, $12	; k
		dc.w  $13, $14	; l
		dc.w  $15, $16	; m
		dc.w  $17, $18	; n
		dc.w  $19,   6	; o
		dc.w  $1A,  $B	; p
		dc.w  $1B, $1C	; q
		dc.w    3,   2	; r
		dc.w  $1D,   6	; s
		dc.w  $1E,  $F	; t
		dc.w  $1F,   6	; u
		dc.w  $1F, $20	; v
		dc.w  $21, $22	; w
		dc.w  $23, $18	; x
		dc.w  $24,  $F	; y
		dc.w  $25, $26	; z
S3Credits_PlaneMapLarge:
		dc.w word_4146C-S3Credits_PlaneMapLarge	; A
		dc.w word_4147A-S3Credits_PlaneMapLarge	; B
		dc.w word_41488-S3Credits_PlaneMapLarge	; C
		dc.w word_41496-S3Credits_PlaneMapLarge	; D
		dc.w word_414A4-S3Credits_PlaneMapLarge	; E
		dc.w word_414B2-S3Credits_PlaneMapLarge	; F
		dc.w word_414C0-S3Credits_PlaneMapLarge	; G
		dc.w word_414CE-S3Credits_PlaneMapLarge	; H
		dc.w word_414DC-S3Credits_PlaneMapLarge	; I
		dc.w word_414E4-S3Credits_PlaneMapLarge	; J
		dc.w word_414EC-S3Credits_PlaneMapLarge	; K
		dc.w word_414FA-S3Credits_PlaneMapLarge	; L
		dc.w word_41502-S3Credits_PlaneMapLarge	; M
		dc.w word_41516-S3Credits_PlaneMapLarge	; N
		dc.w word_41524-S3Credits_PlaneMapLarge	; O
		dc.w word_41538-S3Credits_PlaneMapLarge	; P
		dc.w word_41546-S3Credits_PlaneMapLarge	; Q
		dc.w word_4155A-S3Credits_PlaneMapLarge	; R
		dc.w word_41568-S3Credits_PlaneMapLarge	; S
		dc.w word_41576-S3Credits_PlaneMapLarge	; T
		dc.w word_41584-S3Credits_PlaneMapLarge	; U
		dc.w word_41592-S3Credits_PlaneMapLarge	; V
		dc.w word_415A0-S3Credits_PlaneMapLarge	; W
		dc.w word_415B4-S3Credits_PlaneMapLarge	; X
		dc.w word_415C2-S3Credits_PlaneMapLarge	; Y
		dc.w word_415D0-S3Credits_PlaneMapLarge	; Z
		dc.w word_415DE-S3Credits_PlaneMapLarge	; .
		dc.w word_415E6-S3Credits_PlaneMapLarge	; (
		dc.w word_415F4-S3Credits_PlaneMapLarge	; )
		dc.w word_41602-S3Credits_PlaneMapLarge	; space
word_4146C:	dc.w 2-1
		dc.w  $2029, $202A, $202B, $202C, $202D, $202C
word_4147A:	dc.w 2-1
		dc.w  $202E, $202F, $2030, $2031, $2032, $2033
word_41488:	dc.w 2-1
		dc.w  $2034, $2035, $2036, $2037, $2038, $2039
word_41496:	dc.w 2-1
		dc.w  $203A, $2834, $203B, $2836, $203C, $2838
word_414A4:	dc.w 2-1
		dc.w  $203D, $203E, $202D, $2037, $203F, $2040
word_414B2:	dc.w 2-1
		dc.w  $203D, $203E, $202D, $2037, $202D, $2037
word_414C0:	dc.w 2-1
		dc.w  $2041, $2042, $2043, $202D, $2044, $2045
word_414CE:	dc.w 2-1
		dc.w  $2046, $2047, $202D, $202C, $202D, $202C
word_414DC:	dc.w 1-1
		dc.w  $2048, $203B, $203B
word_414E4:	dc.w 1-1
		dc.w  $2049, $282C, $204A
word_414EC:	dc.w 2-1
		dc.w  $204B, $204C, $204D, $204E, $204F, $2050
word_414FA:	dc.w 1-1
		dc.w  $2048, $203B, $2051
word_41502:	dc.w 3-1
		dc.w  $2052, $2053, $2054, $2055, $2056, $2057, $3855, $2058, $2059
word_41516:	dc.w 2-1
		dc.w  $205A, $2047, $203B, $202C, $203B, $202C
word_41524:	dc.w 3-1
		dc.w  $205B, $205C, $285B, $2043, $2037, $2843, $205D, $205E, $285D
word_41538:	dc.w 2-1
		dc.w  $205F, $2060, $3030, $3031, $2061, $2037
word_41546:	dc.w 3-1
		dc.w  $205B, $205C, $285B, $2043, $2037, $2843, $205D, $2062, $2063
word_4155A:	dc.w 2-1
		dc.w  $205F, $2060, $3030, $3031, $2064, $2065
word_41568:	dc.w 2-1
		dc.w  $2066, $2067, $2068, $2069, $206A, $206B
word_41576:	dc.w 2-1
		dc.w  $206C, $2067, $282D, $2037, $282D, $2037
word_41584:	dc.w 2-1
		dc.w  $206D, $206E, $206F, $2070, $2071, $2072
word_41592:	dc.w 2-1
		dc.w  $2073, $2074, $3055, $2075, $2076, $2077
word_415A0:	dc.w 3-1
		dc.w  $2073, $2078, $2079, $3055, $3056, $3057, $2076, $207A, $207B
word_415B4:	dc.w 2-1
		dc.w  $207C, $207D, $207E, $287E, $207F, $2080
word_415C2:	dc.w 2-1
		dc.w  $2081, $2082, $282C, $2037, $282C, $2037
word_415D0:	dc.w 2-1
		dc.w  $2083, $2084, $2085, $2037, $2086, $2087
word_415DE:	dc.w 1-1
		dc.w  $202F, $2037, $2088
word_415E6:	dc.w 2-1
		dc.w  $2089, $208A, $208B, $2037, $208C, $208D
word_415F4:	dc.w 2-1
		dc.w  $288A, $2889, $2037, $288B, $288D, $288C
word_41602:	dc.w 1-1
		dc.w      0,     0,     0
Pal_Ending:
		binclude "General/Ending/Palettes/S3 Ending.bin"
		even
Pal_EndingS3Logo:
		binclude "General/Ending/Palettes/S3 Logo.bin"
		even
Pal_EndingEyecatchKnuckles:
		binclude "General/Ending/Palettes/S3 Knuckles Eyecatch.bin"
		even
Pal_EndingS3LogoFlash:
		binclude "General/Ending/Palettes/S3 Logo Flash.bin"
		even
Map_EndingGraphics:
		include "General/Ending/Map - S3 Ending Graphics.asm"
ChildObjDat_4192A:
		dc.w 1-1
		dc.l loc_40854
		dc.b  $10,   8
AniRaw_41932:
		dc.b   $F,   1,   2, $FC
AniRaw_41936:
		dc.b    7,   1,   1,   3,   4, $F8,   7, $7F,   4,   4, $FC
AniRaw_41941:
		dc.b   $F,  $A,  $B, $FC
AniRaw_41945:
		dc.b    7,   5,   6,   7,   8,   9, $FC
AniRaw_4194C:
		dc.b   $F,  $C,  $D, $FC
AniRaw_41950:
		dc.b   $E, $1F,  $E, $1F,  $F,   7, $10,   0, $F4
AniRaw_41959:
		dc.b  $10, $1F,  $F,   7,  $E,   0, $F4
		even
ArtNem_EndingGraphics:
		binclude "General/Ending/Nemesis Art/S3 Ending Graphics.bin"
		even

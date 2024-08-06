ContinueScreen:
		jsr	(Pal_FadeToBlack).l
		move	#$2700,sr
		move.w	(VDP_reg_1_command).w,d0
		andi.b	#$BF,d0
		move.w	d0,(VDP_control_port).l
		lea	(VDP_control_port).l,a6
		move.w	#$8004,(a6)
		move.w	#$8700,(a6)
		clr.w	(Kos_decomp_queue_count).w
		clearRAM	Kos_decomp_stored_registers,$6C
		jsr	(Clear_Nem_Queue).l
		jsr	(Clear_DisplayData).l
		move.l	#vdpComm(tiles_to_bytes($001),VRAM,WRITE),(VDP_control_port).l
		lea	(ArtNem_ContinueDigits).l,a0
		jsr	(Nem_Decomp).l
		move.l	#vdpComm(tiles_to_bytes($347),VRAM,WRITE),(VDP_control_port).l
		lea	(ArtNem_CreditsText).l,a0
		jsr	(Nem_Decomp).l
		move.l	#vdpComm(tiles_to_bytes($08C),VRAM,WRITE),(VDP_control_port).l
		lea	(ArtNem_ContinueSprites).l,a0
		jsr	(Nem_Decomp).l
		move.l	#vdpComm(tiles_to_bytes($0D9),VRAM,WRITE),(VDP_control_port).l
		lea	(ArtNem_ContinueIcons).l,a0
		jsr	(Nem_Decomp).l
		clr.b	(Level_started_flag).w
		clr.b	(_unkFAA9).w
		clr.b	(_unkFA88).w
		clearRAM	Player_1,(Kos_decomp_buffer-Player_1)
		moveq	#0,d0
		move.l	d0,(LRZ_rocks_addr_front).w
		move.l	d0,(LRZ_rocks_addr_back).w
		jsr	(Init_SpriteTable).l
		move.w	#(11*60)-1,(Demo_timer).w
		lea	(Pal_ContinueScreen).l,a1
		lea	(Target_palette).w,a2
		moveq	#bytesToLcnt($80),d6

- ;loc_5C3BC:
		move.l	(a1)+,(a2)+
		dbf	d6,- ;loc_5C3BC
		lea	aCONTINUE(pc),a1
		move.w	#$292,d2
		move.w	#$8347,d6
		jsr	(sub_5B318).l
		cmpi.w	#3,(Player_mode).w
		beq.s	++ ;loc_5C3FE
		tst.w	(SK_alone_flag).w
		beq.s	+ ;loc_5C3EE
		move.l	#Obj_Continue_SonicAlone,(Player_1).w
		bra.w	++ ;loc_5C3FE
; ---------------------------------------------------------------------------

+ ;loc_5C3EE:
		move.l	#Obj_Continue_SonicWTails,(Player_1).w
		move.l	#Obj_Continue_TailsWSonic,(Player_2).w

+ ;loc_5C3FE:
		move.l	#loc_5C838,(Reserved_object_3).w
		lea	(Dynamic_object_RAM).w,a1
		move.l	#loc_5C4D6,(a1)
		move.w	a1,(_unkFAA4).w
		move.l	#loc_5C9DC,(Dynamic_object_RAM+object_size).w
		bsr.w	sub_5CB1C
		jsr	(Process_Sprites).l
		jsr	(Render_Sprites).l
		move.b	#$16,(V_int_routine).w
		jsr	(Wait_VSync).l
		move.w	(VDP_reg_1_command).w,d0
		ori.b	#$40,d0
		move.w	d0,(VDP_control_port).l
		moveq	#signextendB(mus_Continue),d0
		jsr	(Play_Music).l
		jsr	(Pal_FadeFromBlack).l

loc_5C454:
		move.b	#$16,(V_int_routine).w
		jsr	(Process_Kos_Queue).l
		jsr	(Wait_VSync).l
		jsr	(Process_Sprites).l
		jsr	(Render_Sprites).l
		jsr	(Process_Kos_Module_Queue).l
		move.b	(_unkFAA9).w,d0
		beq.s	loc_5C454
		subq.b	#1,d0
		beq.s	+ ;loc_5C48A
		move.b	#0,(Game_mode).w
		rts
; ---------------------------------------------------------------------------

+ ;loc_5C48A:
		move.b	#$C,(Game_mode).w
		move.b	#3,(Life_count).w
		move.b	#3,(Life_count_P2).w
		moveq	#0,d0
		move.w	d0,(Ring_count).w
		move.l	d0,(Timer).w
		move.l	d0,(Score).w
		move.w	d0,(Ring_count_P2).w
		move.l	d0,(Timer_P2).w
		move.l	d0,(Score_P2).w
		move.l	#5000,(Next_extra_life_score).w
		move.l	#5000,(Next_extra_life_score_P2).w
		subq.b	#1,(Continue_count).w
		st	(SRAM_mask_interrupts_flag).w
		jsr	(SaveGame_LivesContinues).l

locret_5C4D4:
		rts
; ---------------------------------------------------------------------------

loc_5C4D6:
		move.l	#loc_5C4E6,(a0)
		clr.w	(_unkFA82).w
		move.b	#$A,(_unkFA84).w

loc_5C4E6:
		btst	#button_start,(Ctrl_1_pressed).w
		bne.s	++ ;loc_5C51C
		btst	#button_start,(Ctrl_2_pressed).w
		bne.s	++ ;loc_5C51C
		subq.w	#1,(_unkFA82).w
		bpl.s	locret_5C512
		move.w	#60-1,(_unkFA82).w
		move.b	(_unkFA84).w,d0
		subq.b	#1,d0
		bmi.s	+ ;loc_5C514
		move.b	d0,(_unkFA84).w
		bsr.w	sub_5CAAE

locret_5C512:
		rts
; ---------------------------------------------------------------------------

+ ;loc_5C514:
		move.b	#2,(_unkFAA9).w
		rts
; ---------------------------------------------------------------------------

+ ;loc_5C51C:
		move.l	#locret_5C528,(a0)
		bset	#3,$38(a0)

locret_5C528:
		rts
; ---------------------------------------------------------------------------

Obj_Continue_SonicWTails:
		move.l	#Map_ContinueSprites,mappings(a0)
		move.w	#make_art_tile($08C,0,0),art_tile(a0)
		move.w	#$280,priority(a0)
		move.b	#$C,width_pixels(a0)
		move.b	#$14,height_pixels(a0)
		move.w	#$118,x_pos(a0)
		move.w	#$120,y_pos(a0)
		move.l	#loc_5C55C,(a0)

loc_5C55C:
		movea.w	(_unkFAA4).w,a1
		btst	#3,$38(a1)
		bne.s	++ ;loc_5C582
		move.b	#0,mapping_frame(a0)
		btst	#4,(V_int_run_count+3).w
		beq.s	+ ;loc_5C57C
		move.b	#1,mapping_frame(a0)

+ ;loc_5C57C:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

+ ;loc_5C582:
		move.l	#loc_5C588,(a0)

loc_5C588:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_5C5A2(pc,d0.w),d1
		jsr	off_5C5A2(pc,d1.w)
		jsr	(Sonic_Load_PLC).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
off_5C5A2:
		dc.w loc_5C5AC-off_5C5A2
		dc.w loc_5C5D0-off_5C5A2
		dc.w loc_5C62C-off_5C5A2
		dc.w loc_5C642-off_5C5A2
		dc.w locret_5C65E-off_5C5A2
; ---------------------------------------------------------------------------

loc_5C5AC:
		addq.b	#2,routine(a0)
		move.l	#Map_Sonic,mappings(a0)
		move.w	#make_art_tile(ArtTile_Player_1,0,0),art_tile(a0)
		clr.b	(Player_prev_frame).w
		move.b	#$5A,mapping_frame(a0)
		move.b	#6,anim_frame_timer(a0)
		rts
; ---------------------------------------------------------------------------

loc_5C5D0:
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	locret_5C606
		move.b	#6,anim_frame_timer(a0)
		moveq	#0,d0
		move.b	anim_frame(a0),d0
		addq.w	#2,d0
		cmpi.b	#$A,d0
		bhs.s	+ ;loc_5C608
		move.b	d0,anim_frame(a0)
		lea	RawAni_5C622(pc,d0.w),a2
		move.b	(a2)+,mapping_frame(a0)
		bclr	#0,render_flags(a0)
		tst.b	(a2)
		beq.s	locret_5C606
		bset	#0,render_flags(a0)

locret_5C606:
		rts
; ---------------------------------------------------------------------------

+ ;loc_5C608:
		move.b	#4,routine(a0)
		move.w	#1,anim(a0)
		move.w	#$600,ground_vel(a0)
		move.w	#$F,$2E(a0)
		rts
; ---------------------------------------------------------------------------
RawAni_5C622:
		dc.b  $5A,   1
		dc.b  $59,   1
		dc.b  $55,   0
		dc.b  $56,   0
		dc.b  $57,   0
		even
; ---------------------------------------------------------------------------

loc_5C62C:
		jsr	(Animate_Sonic).l
		subq.w	#1,$2E(a0)
		bmi.s	+ ;loc_5C63A
		rts
; ---------------------------------------------------------------------------

+ ;loc_5C63A:
		move.b	#6,routine(a0)
		rts
; ---------------------------------------------------------------------------

loc_5C642:
		jsr	(Animate_Sonic).l
		addq.w	#6,x_pos(a0)
		cmpi.w	#$1E0,x_pos(a0)
		bhs.s	+ ;loc_5C656
		rts
; ---------------------------------------------------------------------------

+ ;loc_5C656:
		move.b	#8,routine(a0)
		rts
; ---------------------------------------------------------------------------

locret_5C65E:
		rts
; ---------------------------------------------------------------------------

Obj_Continue_SonicAlone:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	.Index(pc,d0.w),d1
		jsr	.Index(pc,d1.w)
		jsr	(Sonic_Load_PLC).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
.Index:
		dc.w loc_5C684-.Index
		dc.w loc_5C6B6-.Index
		dc.w loc_5C6E0-.Index
		dc.w loc_5C6F4-.Index
		dc.w locret_5C716-.Index
; ---------------------------------------------------------------------------

loc_5C684:
		move.b	#2,routine(a0)
		move.l	#Map_Sonic,mappings(a0)
		move.w	#make_art_tile(ArtTile_Player_1,0,0),art_tile(a0)
		move.w	#$280,priority(a0)
		move.b	#$C,width_pixels(a0)
		move.b	#$14,height_pixels(a0)
		move.w	#$120,x_pos(a0)
		move.w	#$120,y_pos(a0)

loc_5C6B6:
		movea.w	(_unkFAA4).w,a1
		btst	#2,$38(a1)
		bne.s	+ ;loc_5C6CC
		lea	byte_5CBC5(pc),a1
		jmp	(Animate_RawNoSSTCheckResult).l
; ---------------------------------------------------------------------------

+ ;loc_5C6CC:
		move.b	#4,routine(a0)
		move.b	#$BA,mapping_frame(a0)
		move.w	#7,$2E(a0)
		rts
; ---------------------------------------------------------------------------

loc_5C6E0:
		subq.w	#1,$2E(a0)
		bpl.s	locret_5C6F2
		move.b	#6,routine(a0)
		move.b	#$21,mapping_frame(a0)

locret_5C6F2:
		rts
; ---------------------------------------------------------------------------

loc_5C6F4:
		addq.w	#6,x_pos(a0)
		cmpi.w	#$1E0,x_pos(a0)
		bhs.s	+ ;loc_5C70A
		lea	byte_5CBB4(pc),a1
		jmp	(Animate_RawNoSSTCheckResult).l
; ---------------------------------------------------------------------------

+ ;loc_5C70A:
		move.b	#8,routine(a0)
		move.b	#1,(_unkFAA9).w

locret_5C716:
		rts
; ---------------------------------------------------------------------------

Obj_Continue_TailsWSonic:
		move.l	#Map_ContinueSprites,mappings(a0)
		move.w	#make_art_tile($08C,0,0),art_tile(a0)
		move.w	#$200,priority(a0)
		move.b	#$10,width_pixels(a0)
		move.b	#$14,height_pixels(a0)
		move.w	#$12C,x_pos(a0)
		move.w	#$120,y_pos(a0)
		move.l	#.loc_5C74A,(a0)

.loc_5C74A:
		movea.w	(_unkFAA4).w,a1
		btst	#3,$38(a1)
		bne.s	++ ;loc_5C770
		move.b	#5,mapping_frame(a0)
		btst	#5,(V_int_run_count+3).w
		beq.s	+ ;loc_5C76A
		move.b	#6,mapping_frame(a0)

+ ;loc_5C76A:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

+ ;loc_5C770:
		move.l	#.loc_5C790,(a0)
		addq.w	#4,y_pos(a0)
		lea	(Tails_tails).w,a1
		move.l	#Obj_Tails_Tail,(a1)
		move.w	a0,$30(a1)
		move.l	#loc_5C82C,(Dust).w

.loc_5C790:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	.index(pc,d0.w),d1
		jsr	.index(pc,d1.w)
		jsr	(Tails_Load_PLC).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
;off_5C7AA:
.index:
		dc.w loc_5C7B2-.index
		dc.w loc_5C7E2-.index
		dc.w loc_5C802-.index
		dc.w loc_5C814-.index
; ---------------------------------------------------------------------------

loc_5C7B2:
		addq.b	#2,routine(a0)
		move.l	#Map_Tails,mappings(a0)
		move.w	#make_art_tile(ArtTile_Player_2,0,0),art_tile(a0)
		move.w	#$280,priority(a0)
		clr.b	(Player_prev_frame_P2).w
		move.w	#5<<8,anim(a0)	; and prev_anim
		move.w	#$AD<<8,mapping_frame(a0)	; and anim_frame
		move.w	#40-1,$2E(a0)
		rts
; ---------------------------------------------------------------------------

loc_5C7E2:
		subq.w	#1,$2E(a0)
		bpl.w	locret_5C4D4
		move.b	#4,routine(a0)
		move.b	#0,anim(a0)
		move.w	#$600,ground_vel(a0)
		move.w	#20-1,$2E(a0)

loc_5C802:
		subq.w	#1,$2E(a0)
		bpl.s	+ ;loc_5C80E
		move.b	#6,routine(a0)

+ ;loc_5C80E:
		jmp	(Animate_Tails).l
; ---------------------------------------------------------------------------

loc_5C814:
		addq.w	#6,x_pos(a0)
		cmpi.w	#$1E0,x_pos(a0)
		blo.s	+ ;loc_5C826
		move.b	#1,(_unkFAA9).w

+ ;loc_5C826:
		jmp	(Animate_Tails).l
; ---------------------------------------------------------------------------

loc_5C82C:
		bclr	#2,(Tails_tails+render_flags).w
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_5C838:
		cmpi.w	#3,(Player_mode).w
		beq.s	+ ;loc_5C854
		lea	loc_5C8C8(pc),a1
		move.l	a1,(a0)
		move.w	#$40,x_pos(a0)
		move.w	#$120,y_pos(a0)
		jmp	(a1)
; ---------------------------------------------------------------------------

+ ;loc_5C854:
		lea	loc_5C85A(pc),a1
		move.l	a1,(a0)

loc_5C85A:
		move.l	#Map_ContinueSprites,mappings(a0)
		move.w	#make_art_tile($08C,3,0),art_tile(a0)
		move.w	#$200,priority(a0)
		move.b	#$10,width_pixels(a0)
		move.b	#$18,height_pixels(a0)
		move.w	#$11C,x_pos(a0)
		move.w	#$120,y_pos(a0)
		move.l	#loc_5C88C,(a0)

loc_5C88C:
		move.w	#$2F,$2E(a0)
		movea.w	(_unkFAA4).w,a1
		btst	#3,$38(a1)
		beq.s	loc_5C8AC
		move.l	#loc_5C8AC,(a0)
		move.l	#loc_5C972,(Dynamic_object_RAM+(object_size*13)).w

loc_5C8AC:
		subq.w	#1,$2E(a0)
		bpl.s	+ ;loc_5C8B8
		move.l	#loc_5C8C8,(a0)

+ ;loc_5C8B8:
		lea	byte_5CBC0(pc),a1
		jsr	(Animate_RawNoSST).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_5C8C8:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_5C8E2(pc,d0.w),d1
		jsr	off_5C8E2(pc,d1.w)
		jsr	(Knuckles_Load_PLC_661E0).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
off_5C8E2:
		dc.w loc_5C8EA-off_5C8E2
		dc.w loc_5C91E-off_5C8E2
		dc.w loc_5C932-off_5C8E2
		dc.w locret_5C970-off_5C8E2
; ---------------------------------------------------------------------------

loc_5C8EA:
		addq.b	#2,routine(a0)
		move.l	#Map_Knuckles,mappings(a0)
		move.w	#make_art_tile(ArtTile_CutsceneKnux,3,0),art_tile(a0)
		move.w	#$80,priority(a0)
		move.b	#7,mapping_frame(a0)
		move.b	#$20,width_pixels(a0)
		move.b	#$30,height_pixels(a0)
		clr.b	anim_frame_timer(a0)
		clr.b	anim_frame(a0)
		rts
; ---------------------------------------------------------------------------

loc_5C91E:
		movea.w	(_unkFAA4).w,a1
		btst	#3,$38(a1)
		bne.s	+ ;loc_5C92C
		rts
; ---------------------------------------------------------------------------

+ ;loc_5C92C:
		move.b	#4,routine(a0)

loc_5C932:
		move.w	x_pos(a0),d0
		addq.w	#6,d0
		move.w	d0,x_pos(a0)
		movea.w	(_unkFAA4).w,a1
		cmpi.w	#$120,d0
		blo.s	loc_5C94C
		bset	#2,$38(a1)

loc_5C94C:
		cmpi.w	#$1E0,d0
		bhs.s	+ ;loc_5C95C
		lea	byte_5CBB4(pc),a1
		jmp	(Animate_RawNoSSTCheckResult).l
; ---------------------------------------------------------------------------

+ ;loc_5C95C:
		move.b	#6,routine(a0)
		cmpi.w	#3,(Player_mode).w
		bne.s	locret_5C970
		move.b	#1,(_unkFAA9).w

locret_5C970:
		rts
; ---------------------------------------------------------------------------

loc_5C972:
		lea	(ObjDat3_919A6).l,a1
		jsr	(SetUp_ObjAttributes).l
		bclr	#2,render_flags(a0)
		bset	#0,render_flags(a0)
		move.l	#Obj_Continue_EggRobo_5C9C4,(a0)
		move.w	#$60,x_pos(a0)
		move.w	#$F0,y_pos(a0)
		move.w	#$600,x_vel(a0)
		jsr	(Swing_Setup1).l
		lea	(ChildObjDat_919D0).l,a2
		jsr	(CreateChild1_Normal).l
		lea	(ArtKosM_EggRoboBadnik).l,a1
		move.w	#tiles_to_bytes($500),d2
		jmp	(Queue_Kos_Module).l
; ---------------------------------------------------------------------------

Obj_Continue_EggRobo_5C9C4:
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		jsr	(sub_91988).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_5C9DC:
		move.l	#Map_ContinueSprites,mappings(a0)
		move.w	#make_art_tile($08C,2,0),art_tile(a0)
		move.w	#$380,priority(a0)
		move.b	#7,mapping_frame(a0)
		move.b	#8,width_pixels(a0)
		move.b	#8,height_pixels(a0)
		move.w	#$120,x_pos(a0)
		move.w	#$F5,y_pos(a0)
		move.l	#loc_5CA14,(a0)

loc_5CA14:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_5CA1A:
		move.l	#Map_ContinueIcons,mappings(a0)
		move.w	#make_art_tile($0D9,0,0),art_tile(a0)
		cmpi.w	#3,(Player_mode).w
		bne.s	+ ;loc_5CA36
		move.w	#make_art_tile($0D9,3,0),art_tile(a0)

+ ;loc_5CA36:
		move.w	#$380,priority(a0)
		move.b	#8,width_pixels(a0)
		move.b	#8,height_pixels(a0)
		bsr.w	sub_5CB4A
		move.w	#$D8,y_pos(a0)
		move.l	#loc_5CA5C,(a0)
		bsr.w	sub_5CB6A

loc_5CA5C:
		moveq	#0,d0
		btst	#4,(V_int_run_count+3).w
		beq.s	+ ;loc_5CA68
		addq.w	#1,d0

+ ;loc_5CA68:
		movea.l	$30(a0),a1
		move.b	(a1,d0.w),mapping_frame(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_5CA78:
		move.l	#Map_ContinueIcons,mappings(a0)
		move.w	#make_art_tile($0D9,0,0),art_tile(a0)
		move.w	#$280,priority(a0)
		move.b	#8,width_pixels(a0)
		move.b	#8,height_pixels(a0)
		move.l	#loc_5CA9E,(a0)

loc_5CA9E:
		lea	byte_5CBBB(pc),a1
		jsr	(Animate_RawNoSST).l
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_5CAAE:
		move.b	(_unkFA84).w,d0
		move.b	d0,d1
		andi.w	#$F0,d0
		lsr.w	#3,d0
		andi.w	#$F,d1
		add.w	d1,d1
		move.w	#1,d2
		lea	(RAM_start+$2000).l,a1
		add.w	d2,d0
		move.w	d0,(a1)+
		add.w	d2,d1
		move.w	d1,(a1)+
		addq.w	#1,d0
		move.w	d0,(a1)+
		addq.w	#1,d1
		move.w	d1,(a1)+
		move	#$2700,sr
		lea	(VDP_data_port).l,a6
		move.w	#VRAM_Plane_A_Name_Table+$726,d2
		swap	d2
		clr.w	d2
		swap	d2
		lsl.l	#2,d2
		lsr.w	#2,d2
		ori.w	#$4000,d2
		swap	d2
		move.l	d2,d3
		addi.l	#$80<<16,d3
		lea	(RAM_start+$2000).l,a1
		move.l	d2,VDP_control_port-VDP_data_port(a6)
		move.w	(a1)+,(a6)
		move.w	(a1)+,(a6)
		move.l	d3,VDP_control_port-VDP_data_port(a6)
		move.w	(a1)+,(a6)
		move.w	(a1)+,(a6)
		move	#$2300,sr
		rts
; End of function sub_5CAAE


; =============== S U B R O U T I N E =======================================


sub_5CB1C:
		moveq	#0,d0
		move.b	(Continue_count).w,d0
		beq.s	+ ;loc_5CB2A
		cmpi.b	#$A,d0
		bls.s	++ ;loc_5CB2C

+ ;loc_5CB2A:
		moveq	#$A,d0

+ ;loc_5CB2C:
		lea	(Dynamic_object_RAM+(object_size*2)).w,a1
		moveq	#0,d1

loc_5CB32:
		subq.b	#1,d0
		beq.w	locret_5C4D4
		move.l	#loc_5CA1A,(a1)
		move.b	d1,subtype(a1)
		addq.w	#2,d1
		lea	next_object(a1),a1
		bra.s	loc_5CB32
; End of function sub_5CB1C


; =============== S U B R O U T I N E =======================================


sub_5CB4A:
		moveq	#0,d0
		move.b	subtype(a0),d0
		move.w	word_5CB58(pc,d0.w),x_pos(a0)
		rts
; End of function sub_5CB4A

; ---------------------------------------------------------------------------
word_5CB58:
		dc.w   $120
		dc.w   $138
		dc.w   $108
		dc.w   $150
		dc.w    $F0
		dc.w   $168
		dc.w    $D8
		dc.w   $180
		dc.w    $C0

; =============== S U B R O U T I N E =======================================


sub_5CB6A:
		move.w	(Player_mode).w,d4
		cmpi.b	#2,d4
		bne.s	+ ;loc_5CB7E
		lea	ChildObjDat_5CB88(pc),a2
		jsr	(CreateChild6_Simple).l

+ ;loc_5CB7E:
		lsl.w	#2,d4
		move.l	off_5CB8E(pc,d4.w),$30(a0)
		rts
; End of function sub_5CB6A

; ---------------------------------------------------------------------------
ChildObjDat_5CB88:
		dc.w 1-1
		dc.l Obj_5CA78
off_5CB8E:
		dc.l byte_5CBAE
		dc.l byte_5CBAE
		dc.l byte_5CBB0
		dc.l byte_5CBB2
aCONTINUE:
		dc.b "C O N T I N U E",0
		even
byte_5CBAE:	dc.b 0
		dc.b 1
byte_5CBB0:	dc.b 2
		dc.b 3
byte_5CBB2:	dc.b 7
		dc.b 8
byte_5CBB4:
		dc.b    2, $21, $22, $23, $24, $FF, $FC
byte_5CBBB:
		dc.b    8,   4,   5,   6, $FC
byte_5CBC0:
		dc.b   $B,   2,   2,   4, $FC
byte_5CBC5:
		dc.b   $B, $BD, $BE, $FF, $FC
		even
Pal_ContinueScreen:
		binclude "General/Sprites/Continue/Palette.bin"
		even
Map_ContinueSprites:
		include "General/Sprites/Continue/Map - Player Sprites.asm"
Map_ContinueIcons:
		include "General/Sprites/Continue/Map - Player Icons.asm"
ArtNem_ContinueSprites:
		binclude "General/Sprites/Continue/Player Sprites.bin"
		even
ArtNem_ContinueIcons:
		binclude "General/Sprites/Continue/Player Icons.bin"
		even
ArtNem_ContinueDigits:
		binclude "General/Sprites/Continue/Digits.bin"
		even

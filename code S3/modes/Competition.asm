Competition_Menu:
		bsr.w	Pal_FadeToBlack
		move	#$2700,sr
		move.w	(VDP_reg_1_command).w,d0
		andi.b	#$BF,d0
		move.w	d0,(VDP_control_port).l
		jsr	(Clear_DisplayData).l
		lea	(VDP_control_port).l,a6
		move.w	#$8004,(a6)			; Command $8004 - Disable HInt, HV Counter
		move.w	#$8230,(a6)			; Command $8230 - Nametable A at $C000
		move.w	#$8407,(a6)			; Command $8407 - Nametable B at $E000
		move.w	#$8730,(a6)
		move.w	#$8B00,(a6)
		move.w	#$8C81,(a6)			; Command $8C81 - 40cell screen size, no interlacing, no s/h
		move.w	#$9011,(a6)			; 128-cell hScroll table size: 64x64
		jsr	sub_B512(pc)
		clearRAM	Sprite_table_input,$400
		clearRAM	Object_RAM,(Kos_decomp_buffer-Object_RAM)
		clr.w	(DMA_queue).w
		move.l	#DMA_queue,(DMA_queue_slot).w
		clr.w	(Level_frame_counter).w
		cmpi.b	#3,(Competition_menu_selection).w
		blo.s	+ ;loc_95AE
		clr.b	(Competition_menu_selection).w

+ ;loc_95AE:
		lea	(MapEni_S3MenuBG).l,a0
		lea	(RAM_start).l,a1
		move.w	#make_art_tile($001,3,0),d0
		jsr	(Eni_Decomp).l
		lea	(RAM_start).l,a1
		move.l	#vdpComm(VRAM_Plane_B_Name_Table,VRAM,WRITE),d0
		moveq	#$28-1,d1
		moveq	#$1C-1,d2
		jsr	(Plane_Map_To_VRAM).l
		lea	(ArtKos_S3MenuBG).l,a0				; Decompress source
		lea	(RAM_start).l,a1				; Decompress destination/Transfer source
		movea.w	#tiles_to_bytes(ArtTile_ArtKos_S3MenuBG),a2	; Transfer destination
		jsr	KosArt_To_VDP(pc)
		move.l	#locret_952E,(_unkEF44_1).w
		move.b	#$1E,(V_int_routine).w
		jsr	(Wait_VSync).l
		lea	(ArtKos_CompetitionLevel).l,a0				; Decompress source
		lea	(RAM_start).l,a1					; Decompress destination/Transfer source, used by the next KosArt_To_VDP also
		movea.w	#tiles_to_bytes(ArtTile_ArtKos_Competition_LevSel),a2	; Transfer destination
		jsr	KosArt_To_VDP(pc)
		lea	(ArtKos_CompetitionMode).l,a0				; Decompress source
		movea.w	#tiles_to_bytes(ArtTile_ArtKos_Competition_ModeSel),a2	; Transfer destination
		jsr	KosArt_To_VDP(pc)
		move.b	#$1E,(V_int_routine).w
		jsr	(Wait_VSync).l
		lea	Pal_Competition1(pc),a0
		lea	(Target_palette).w,a1
		moveq	#bytesToLcnt($60),d0

- ;loc_963A:
		move.l	(a0)+,(a1)+
		dbf	d0,- ;loc_963A
		lea	(Pal_CompetitionMenuBG).l,a0
		moveq	#bytesToLcnt($20),d0

- ;loc_9648:
		move.l	(a0)+,(a1)+
		dbf	d0,- ;loc_9648
		lea	(Object_RAM).w,a0
		lea	ObjDat_9878(pc),a1
		move.w	(a1)+,d0

- ;loc_9658:
		move.l	(a1)+,(a0)
		move.w	#make_art_tile(ArtTile_ArtKos_Competition_ModeSel,0,0),art_tile(a0)
		move.l	#Map_CompetitionObject,mappings(a0)
		move.w	(a1)+,x_pos(a0)
		move.w	(a1)+,y_pos(a0)
		move.b	(a1)+,mapping_frame(a0)
		move.b	(a1)+,$2E(a0)
		lea	next_object(a0),a0
		dbf	d0,- ;loc_9658
		jsr	(Init_SpriteTable).l
		jsr	(Process_Sprites).l
		jsr	(Render_Sprites).l
		moveq	#signextendB(mus_CompetitionMenu),d0
		jsr	(Play_Music).l
		move.b	#$1E,(V_int_routine).w
		jsr	(Wait_VSync).l
		move.w	(VDP_reg_1_command).w,d0
		ori.b	#$40,d0
		move.w	d0,(VDP_control_port).l
		bsr.w	Pal_FadeFromBlack

loc_96B8:
		move.b	#$1E,(V_int_routine).w
		jsr	(Wait_VSync).l
		addq.w	#1,(Level_frame_counter).w
		jsr	(Process_Sprites).l
		jsr	(Render_Sprites).l
		move.b	(Ctrl_1_pressed).w,d0
		or.b	(Ctrl_2_pressed).w,d0
		move.b	d0,d1
		andi.b	#button_A_mask|button_B_mask|button_C_mask|button_start_mask,d1
		beq.w	loc_9776
		btst	#button_B,d1
		bne.s	+ ;loc_96FE
		moveq	#0,d2
		move.b	(Competition_menu_selection).w,d2
		add.w	d2,d2
		jmp	loc_96F8(pc,d2.w)
; ---------------------------------------------------------------------------

loc_96F8:
		bra.s	loc_9706
; ---------------------------------------------------------------------------
		bra.s	loc_9724
; ---------------------------------------------------------------------------
		bra.s	loc_9744
; ---------------------------------------------------------------------------

+ ;loc_96FE:
		move.b	#4,(Game_mode).w
		rts
; ---------------------------------------------------------------------------

loc_9706:
		clr.b	(Competition_type).w
		move.b	(Competition_menu_items).w,(Competition_items).w
		move.b	(Ctrl_2_pressed).w,d0
		andi.b	#button_A_mask|button_C_mask|button_start_mask,d0
		sne	(Not_ghost_flag).w
		move.b	#$3C,(Game_mode).w
		bra.s	+ ;loc_975E
; ---------------------------------------------------------------------------

loc_9724:
		move.b	#3,(Competition_type).w
		move.b	(Competition_menu_items).w,(Competition_items).w
		move.b	(Ctrl_2_pressed).w,d0
		andi.b	#button_A_mask|button_C_mask|button_start_mask,d0
		sne	(Not_ghost_flag).w
		move.b	#$40,(Game_mode).w
		bra.s	+ ;loc_975E
; ---------------------------------------------------------------------------

loc_9744:
		move.b	(Ctrl_1_pressed).w,d2
		andi.w	#button_A_mask|button_C_mask|button_start_mask,d2
		beq.s	loc_9776
		move.w	#-1,(Competition_settings).w
		clr.b	(Not_ghost_flag).w
		move.b	#$C0,(Game_mode).w

+ ;loc_975E:
		lea	($FF7800).l,a1
		moveq	#0,d0
		moveq	#bytesToLcnt($28),d1

- ;loc_9768:
		move.l	d0,(a1)+
		dbf	d1,- ;loc_9768
		moveq	#signextendB(sfx_Starpost),d0
		jmp	(Play_SFX).l
; ---------------------------------------------------------------------------

loc_9776:
		moveq	#0,d2
		move.b	(Competition_menu_selection).w,d1
		lsr.w	#1,d0
		bcc.s	+ ;loc_978A
		moveq	#signextendB(sfx_Switch),d2
		subq.b	#1,d1
		bcc.s	++ ;loc_979A
		moveq	#3,d1
		bra.s	++ ;loc_979A
; ---------------------------------------------------------------------------

+ ;loc_978A:
		lsr.w	#1,d0
		bcc.s	+ ;loc_979A
		moveq	#signextendB(sfx_Switch),d2
		addq.b	#1,d1
		cmpi.b	#3,d1
		bls.s	+ ;loc_979A
		moveq	#0,d1

+ ;loc_979A:
		move.b	d1,(Competition_menu_selection).w
		move.w	d2,d0
		beq.s	+ ;loc_97A8
		jsr	(Play_SFX).l

+ ;loc_97A8:
		bra.w	loc_96B8
; ---------------------------------------------------------------------------

Obj_Competition_97AC:
		move.b	$2E(a0),d0
		bmi.s	++ ;loc_97CA
		andi.w	#$9FFF,art_tile(a0)
		move.w	#$2000,d1
		cmp.b	(Competition_menu_selection).w,d0
		bne.s	+ ;loc_97C6
		move.w	#$4000,d1

+ ;loc_97C6:
		or.w	d1,art_tile(a0)

+ ;loc_97CA:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_Competition_97D0:
		cmpi.b	#1,(Competition_menu_selection).w
		bhi.s	locret_9816
		move.b	(Ctrl_1_pressed).w,d0
		or.b	(Ctrl_2_pressed).w,d0
		andi.w	#button_left_mask|button_right_mask,d0
		beq.s	+ ;loc_97F6
		tst.b	(Competition_menu_items).w
		seq	(Competition_menu_items).w
		moveq	#signextendB(sfx_Switch),d0
		jsr	(Play_SFX).l

+ ;loc_97F6:
		move.w	#$15C,d0
		tst.b	(Competition_menu_items).w
		beq.s	+ ;loc_9804
		addi.w	#$20,d0

+ ;loc_9804:
		move.w	d0,x_pos(a0)
		btst	#3,(Level_frame_counter+1).w
		beq.s	locret_9816
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

locret_9816:
		rts
; ---------------------------------------------------------------------------
Pal_Competition1:
		binclude "General/Competition Menu/Palettes/1.bin"
		even
ObjDat_9878:
		dc.w 7-1
		dc.l Obj_Competition_97AC
		dc.w   $114,   $A0
		dc.b    0,   0
		dc.l Obj_Competition_97AC
		dc.w   $10C,   $C0
		dc.b    1,   1
		dc.l Obj_Competition_97AC
		dc.w   $108,   $E0
		dc.b    2,   2
		dc.l Obj_Competition_97AC
		dc.w   $13C,  $120
		dc.b    3,   3
		dc.l Obj_Competition_97AC
		dc.w   $164,   $B0
		dc.b    4, $FF
		dc.l Obj_Competition_97AC
		dc.w   $184,   $B0
		dc.b    5, $FF
		dc.l Obj_Competition_97D0
		dc.w      0,   $A8
		dc.b    6, $FF
Map_CompetitionObject:
		include "General/Competition Menu/Map - Competition Objects.asm"
; ---------------------------------------------------------------------------

Competition_LevelSelect:
		bsr.w	Pal_FadeToBlack
		move	#$2700,sr
		move.w	(VDP_reg_1_command).w,d0
		andi.b	#$BF,d0
		move.w	d0,(VDP_control_port).l
		jsr	(Clear_DisplayData).l
		lea	(VDP_control_port).l,a6
		move.w	#$8004,(a6)			; Command $8004 - Disable HInt, HV Counter
		move.w	#$8230,(a6)			; Command $8230 - Nametable A at $C000
		move.w	#$8407,(a6)			; Command $8407 - Nametable B at $E000
		move.w	#$8700,(a6)			; Command $8700 - BG color is Pal 0 Color 0
		move.w	#$8B00,(a6)
		move.w	#$8C89,(a6)
		move.w	#$9011,(a6)			; 128-cell hScroll table size: 64x64
		jsr	sub_B512(pc)
		clearRAM	Sprite_table_input,$400
		clearRAM	Object_RAM,(Kos_decomp_buffer-Object_RAM)
		clr.w	(DMA_queue).w
		move.l	#DMA_queue,(DMA_queue_slot).w
		clr.w	(Level_frame_counter).w
		clr.w	(Competition_mode).w
		clr.b	(Level_started_flag).w
		move.w	#-1,(Events_bg+$10).w
		clr.w	(Events_bg+$12).w
		clr.w	(Events_bg+$14).w
		lea	(MapEni_S3MenuBG).l,a0
		lea	(RAM_start).l,a1
		move.w	#make_art_tile($001,0,0),d0
		jsr	(Eni_Decomp).l
		lea	(RAM_start).l,a1
		move.l	#vdpComm(VRAM_Plane_B_Name_Table,VRAM,WRITE),d0
		moveq	#$28-1,d1
		moveq	#$1C-1,d2
		jsr	(Plane_Map_To_VRAM).l
		lea	(MapEni_CompetitionLevBorder).l,a0
		lea	(RAM_start).l,a1
		move.w	#make_art_tile(ArtTile_ArtKos_Competition_LevSel,0,1),d0
		jsr	(Eni_Decomp).l
		lea	(MapEni_CompetitionLevImage).l,a0
		lea	(RAM_start+$1000).l,a1
		move.w	#make_art_tile(ArtTile_ArtKos_Competition_LevSel,3,1),d0
		jsr	(Eni_Decomp).l
		lea	(MapEni_CompetitionLevName).l,a0
		lea	(RAM_start+$2000).l,a1
		move.w	#make_art_tile(ArtTile_ArtKos_Competition_LevSel,1,1),d0
		jsr	(Eni_Decomp).l
		lea	VRAMDatList_CompetitionLevelSelect(pc),a0
		jsr	Copy_Listed_Data_To_VRAM(pc)
		jsr	sub_9E18(pc)
		mulu.w	#$48,d0
		move.w	d0,(V_scroll_value).w
		jsr	sub_9E6C(pc)
		jsr	sub_9E9C(pc)
		lea	(ArtKos_S3MenuBG).l,a0				; Decompress source
		lea	(RAM_start).l,a1				; Decompress destination/Transfer source
		movea.w	#tiles_to_bytes(ArtTile_ArtKos_S3MenuBG),a2	; Transfer destination
		jsr	KosArt_To_VDP(pc)
		move.l	#locret_952E,(_unkEF44_1).w
		move.b	#$1E,(V_int_routine).w
		jsr	(Wait_VSync).l
		lea	(ArtKos_CompetitionLevel).l,a0				; Decompress source
		lea	(RAM_start).l,a1					; Decompress destination/Transfer source, used by the next KosArt_To_VDP also
		movea.w	#tiles_to_bytes(ArtTile_ArtKos_Competition_LevSel),a2	; Transfer destination
		jsr	KosArt_To_VDP(pc)
		lea	(ArtKos_CompetitionPlayer).l,a0				; Decompress source
		movea.w	#tiles_to_bytes(ArtTile_ArtKos_Competition_CharSel),a2	; Transfer destination
		jsr	KosArt_To_VDP(pc)
		move.b	#$1E,(V_int_routine).w
		jsr	(Wait_VSync).l
		lea	(Pal_CompetitionMenuBG).l,a0
		lea	(Target_palette).w,a1
		moveq	#bytesToLcnt($20),d0

- ;loc_9B70:
		move.l	(a0)+,(a1)+
		dbf	d0,- ;loc_9B70
		lea	Pal_Competition2(pc),a0
		moveq	#bytesToLcnt($60),d0

- ;loc_9B7C:
		move.l	(a0)+,(a1)+
		dbf	d0,- ;loc_9B7C
		lea	(Object_RAM).w,a0
		lea	ObjDat_CompetitionMatchRace(pc),a1
		tst.b	(Game_mode).w
		bpl.s	+ ;loc_9B94
		lea	ObjDat_CompetitionTimeAttack(pc),a1

+ ;loc_9B94:
		move.w	(a1)+,d0

- ;loc_9B96:
		move.l	(a1)+,(a0)
		move.l	#Map_CompetitionSelect,mappings(a0)
		move.w	(a1),x_pos(a0)
		move.w	(a1)+,$12(a0)
		move.w	(a1),y_pos(a0)
		move.w	(a1)+,$16(a0)
		move.w	(a1)+,d1
		addi.w	#make_art_tile(ArtTile_ArtKos_Competition_LevSel,0,1),d1
		move.w	d1,art_tile(a0)
		move.b	(a1)+,mapping_frame(a0)
		move.b	(a1)+,$2E(a0)
		lea	next_object(a0),a0
		dbf	d0,- ;loc_9B96
		moveq	#0,d0
		move.b	(P1_character).w,d0
		mulu.w	#$55,d0
		addi.b	#$40,d0
		move.b	d0,(Reserved_object_3+objoff_2E).w
		tst.b	(Game_mode).w
		bmi.s	+ ;loc_9BF4
		moveq	#0,d0
		move.b	(P2_character).w,d0
		mulu.w	#$55,d0
		addi.b	#$40,d0
		move.b	d0,(Dynamic_object_RAM+(object_size*4)+objoff_2E).w

+ ;loc_9BF4:
		jsr	(Init_SpriteTable).l
		jsr	(Process_Sprites).l
		jsr	(Render_Sprites).l
		jsr	sub_B596(pc)
		jsr	(Process_Sprites).l
		jsr	(Render_Sprites).l
		lea	(Dynamic_object_RAM+(object_size*9)).w,a0
		move.l	#loc_9DC2,(a0)
		move.l	#Map_CompetitionSelect,mappings(a0)
		addi.w	#make_art_tile(ArtTile_ArtKos_Competition_LevSel,2,1),art_tile(a0)
		move.w	#$B0,x_pos(a0)
		moveq	#signextendB(mus_CompetitionMenu),d0
		jsr	(Play_Music).l
		move.b	#$1E,(V_int_routine).w
		jsr	(Wait_VSync).l
		move.w	(VDP_reg_1_command).w,d0
		ori.b	#$40,d0
		move.w	d0,(VDP_control_port).l
		jsr	(Pal_FadeFromBlack).l

loc_9C5C:
		move.b	#$1E,(V_int_routine).w
		jsr	(Wait_VSync).l
		addq.w	#1,(Level_frame_counter).w
		jsr	(Process_Sprites).l
		jsr	sub_B596(pc)
		jsr	(Render_Sprites).l
		move.b	(Events_bg+$12).w,d0
		beq.s	+ ;loc_9C88
		move.b	d0,(Game_mode).w
		rts
; ---------------------------------------------------------------------------

+ ;loc_9C88:
		move.w	(Events_bg+$10).w,d0
		tst.b	(Not_ghost_flag).w
		bne.s	+ ;loc_9C94
		lsr.w	#8,d0

+ ;loc_9C94:
		tst.w	d0
		beq.s	++ ;loc_9CB4
		move.w	(H_scroll_buffer).w,d0
		beq.s	loc_9C5C
		cmpi.w	#-$58,d0
		bne.s	+ ;loc_9CAC
		move.l	#loc_9E2E,(_unkEF44_1).w

+ ;loc_9CAC:
		addq.w	#8,d0
		move.w	d0,(H_scroll_buffer).w
		bra.s	loc_9C5C
; ---------------------------------------------------------------------------

+ ;loc_9CB4:
		cmpi.w	#-$58,(H_scroll_buffer).w
		beq.s	+ ;loc_9CC2
		subq.w	#8,(H_scroll_buffer).w
		bra.s	loc_9C5C
; ---------------------------------------------------------------------------

+ ;loc_9CC2:
		moveq	#8,d0
		move.w	(Events_bg+$14).w,d1
		beq.s	++ ;loc_9CD8
		bpl.s	+ ;loc_9CCE
		neg.w	d0

+ ;loc_9CCE:
		add.w	d0,(V_scroll_value).w
		sub.w	d0,(Events_bg+$14).w
		bra.s	loc_9C5C
; ---------------------------------------------------------------------------

+ ;loc_9CD8:
		move.b	(Ctrl_1_pressed).w,d1
		moveq	#0,d2
		tst.b	(Not_ghost_flag).w
		beq.s	+ ;loc_9CE8
		move.b	(Ctrl_2_pressed).w,d2

+ ;loc_9CE8:
		btst	#button_B,d2
		beq.s	+ ;loc_9CF6
		sf	(Dynamic_object_RAM+(object_size*4)+objoff_2F).w
		st	(Events_bg+$11).w

+ ;loc_9CF6:
		btst	#button_B,d1
		beq.s	+ ;loc_9D04
		sf	(Reserved_object_3+objoff_2F).w
		st	(Events_bg+$10).w

+ ;loc_9D04:
		or.b	d2,d1
		move.b	d1,d2
		andi.w	#3,d2
		beq.s	loc_9D5C
		lea	(Competition_menu_zone).w,a0
		lsr.w	#1,d2
		bcs.s	+ ;loc_9D3C
		cmpi.b	#4,(a0)
		beq.s	loc_9D5C
		moveq	#signextendB(sfx_Switch),d0
		jsr	(Play_SFX).l
		addq.b	#1,(a0)
		cmpi.b	#4,(a0)
		beq.s	loc_9D5C
		cmpi.b	#1,(a0)
		beq.s	loc_9D5C
		move.w	#$48,(Events_bg+$14).w
		bra.w	loc_9C5C
; ---------------------------------------------------------------------------

+ ;loc_9D3C:
		tst.b	(a0)
		beq.s	loc_9D5C
		moveq	#signextendB(sfx_Switch),d0
		jsr	(Play_SFX).l
		subq.b	#1,(a0)
		beq.s	loc_9D5C
		cmpi.b	#3,(a0)
		beq.s	loc_9D5C
		move.w	#-$48,(Events_bg+$14).w
		bra.w	loc_9C5C
; ---------------------------------------------------------------------------

loc_9D5C:
		andi.w	#$E0,d1
		beq.w	loc_9C5C
		moveq	#signextendB(sfx_Starpost),d0
		jsr	(Play_SFX).l
		moveq	#0,d0
		move.b	(Competition_menu_zone).w,d0
		move.b	Comp_ZoneList(pc,d0.w),(Current_zone_and_act).w
		clr.b	(Current_act).w
		jsr	sub_B5EC(pc)
		move.b	#$C,(Game_mode).w
		rts
; ---------------------------------------------------------------------------
Comp_ZoneList:
		dc.b   $E
		dc.b   $F
		dc.b  $11
		dc.b  $10
		dc.b  $12
		dc.b  $FF
; ---------------------------------------------------------------------------

Obj_Competition_ZoneSelect:
		cmpi.w	#-$58,(H_scroll_buffer).w
		bne.s	locret_9DC0
		tst.w	(Events_bg+$14).w
		bne.s	locret_9DC0
		moveq	#0,d0
		move.b	(Competition_menu_zone).w,d0
		mulu.w	#$48,d0
		addi.w	#$AC,d0
		sub.w	(V_scroll_value).w,d0
		move.w	d0,y_pos(a0)
		btst	#3,(Level_frame_counter+1).w
		beq.s	locret_9DC0
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

locret_9DC0:
		rts
; ---------------------------------------------------------------------------

loc_9DC2:
		cmpi.w	#-$58,(H_scroll_buffer).w
		bne.s	+ ;loc_9E06
		tst.w	(Events_bg+$14).w
		bne.s	+ ;loc_9E06
		moveq	#0,d0
		move.b	(Competition_menu_zone).w,d0
		mulu.w	#$48,d0
		addi.w	#$A8,d0
		sub.w	(V_scroll_value).w,d0
		move.w	d0,y_pos(a0)
		move.b	(Competition_menu_zone).w,d0
		addq.b	#6,d0
		move.b	d0,mapping_frame(a0)
		jsr	(Draw_Sprite).l
		moveq	#0,d0
		move.b	(Competition_menu_zone).w,d0
		lsl.w	#5,d0
		lea	Pal_Competition4(pc),a1
		adda.w	d0,a1
		bra.s	++ ;loc_9E0A
; ---------------------------------------------------------------------------

+ ;loc_9E06:
		lea	Pal_Competition3(pc),a1

+ ;loc_9E0A:
		lea	(Normal_palette_line_3).w,a2
		moveq	#bytesToLcnt($20),d0

- ;loc_9E10:
		move.l	(a1)+,(a2)+
		dbf	d0,- ;loc_9E10
		rts

; =============== S U B R O U T I N E =======================================


sub_9E18:
		moveq	#0,d0
		move.b	(Competition_menu_zone).w,d0
		subq.w	#1,d0
		bcc.s	+ ;loc_9E24
		moveq	#0,d0

+ ;loc_9E24:
		cmpi.w	#2,d0
		bls.s	locret_9E2C
		moveq	#2,d0

locret_9E2C:
		rts
; End of function sub_9E18

; ---------------------------------------------------------------------------

loc_9E2E:
		move.l	#locret_952E,(_unkEF44_1).w
		move.l	#vdpComm(VRAM_Plane_A_Name_Table+$204,VRAM,WRITE),d0
		lea	(VDP_data_port).l,a6
		move.l	#$80008000,d1
		move.w	#$8F80,VDP_control_port-VDP_data_port(a6)
		moveq	#9-1,d2

- ;loc_9E50:
		moveq	#$13-1,d3
		move.l	d0,VDP_control_port-VDP_data_port(a6)

- ;loc_9E56:
		move.l	d1,(a6)
		dbf	d3,- ;loc_9E56
		addi.l	#2<<16,d0
		dbf	d2,-- ;loc_9E50
		move.w	#$8F02,VDP_control_port-VDP_data_port(a6)

; =============== S U B R O U T I N E =======================================


sub_9E6C:
		bsr.s	sub_9E18
		mulu.w	#$48,d0
		addi.w	#$20,d0
		lsl.w	#4,d0
		addi.w	#VRAM_Plane_A_Name_Table+$004,d0
		move.w	d0,d7
		tst.b	(Game_mode).w
		bmi.s	+ ;loc_9E94
		jsr	sub_B534(pc)
		move.w	d7,d0
		addi.w	#$600,d0
		jmp	sub_B534(pc)
; ---------------------------------------------------------------------------
		rts
; ---------------------------------------------------------------------------

+ ;loc_9E94:
		addi.w	#$300,d0
		jmp	sub_B534(pc)
; End of function sub_9E6C


; =============== S U B R O U T I N E =======================================


sub_9E9C:
		move.w	#VRAM_Plane_A_Name_Table+$2D2,d7
		move.l	(Competition_saved_data).w,d6
		bsr.s	sub_9ECC
		addi.w	#$480,d7
		move.l	(Competition_saved_data+$10).w,d6
		bsr.s	sub_9ECC
		addi.w	#$480,d7
		move.l	(Competition_saved_data+$30).w,d6
		bsr.s	sub_9ECC
		addi.w	#$480,d7
		move.l	(Competition_saved_data+$20).w,d6
		bsr.s	sub_9ECC
		addi.w	#$480,d7
		move.l	(Competition_saved_data+$40).w,d6
; End of function sub_9E9C


; =============== S U B R O U T I N E =======================================


sub_9ECC:
		moveq	#0,d5
		lsl.l	#8,d6
		moveq	#2,d3

- ;loc_9ED2:
		rol.l	#8,d6
		moveq	#0,d0
		move.b	d6,d0
		jsr	(LevResults_GetDecimalScore).l
		move.b	d1,d5
		lsl.l	#8,d5
		dbf	d3,- ;loc_9ED2
		lea	(Plane_buffer).w,a1
		lea	MapUnc_CompetitionNumbers(pc),a2
		moveq	#0,d0
		bsr.s	sub_9F26
		st	d0
		bsr.s	sub_9F26
		moveq	#$A,d1
		bsr.s	sub_9F38
		bsr.s	sub_9F26
		bsr.s	sub_9F26
		moveq	#$B,d1
		bsr.s	sub_9F38
		bsr.s	sub_9F26
		bsr.s	sub_9F26
		lea	(Plane_buffer).w,a1

loc_9F0A:
		move.w	d7,d0
		swap	d0
		clr.w	d0
		swap	d0
		lsl.l	#2,d0
		lsr.w	#2,d0
		ori.w	#$4000,d0
		swap	d0
		moveq	#8-1,d1
		moveq	#2-1,d2
		jmp	(Plane_Map_To_VRAM).l
; End of function sub_9ECC


; =============== S U B R O U T I N E =======================================


sub_9F26:
		rol.l	#4,d5
		move.w	d5,d1
		andi.w	#$F,d1
		bne.s	sub_9F38
		tst.w	d0
		bne.s	sub_9F38
		moveq	#$C,d1
		st	d0
; End of function sub_9F26


; =============== S U B R O U T I N E =======================================


sub_9F38:
		add.w	d1,d1
		add.w	d1,d1
		move.w	(a2,d1.w),(a1)+
		move.w	2(a2,d1.w),$E(a1)
		rts
; End of function sub_9F38


; =============== S U B R O U T I N E =======================================


sub_9F48:
		lea	(byte_373E4).l,a1
		moveq	#0,d0
		move.b	d6,d0
		move.b	(a1,d0.w),d6
		rts
; End of function sub_9F48

; ---------------------------------------------------------------------------
VRAMDatList_CompetitionLevelSelect:
		dc.w $19-1
		dc.l RAM_start+$0000
		dc.w VRAM_Plane_A_Name_Table+$0098, $1B-1, 9-1
		dc.l RAM_start+$0000
		dc.w VRAM_Plane_A_Name_Table+$0518, $1B-1, 9-1
		dc.l RAM_start+$0000
		dc.w VRAM_Plane_A_Name_Table+$0998, $1B-1, 9-1
		dc.l RAM_start+$0000
		dc.w VRAM_Plane_A_Name_Table+$0E18, $1B-1, 9-1
		dc.l RAM_start+$0000
		dc.w VRAM_Plane_A_Name_Table+$1298, $1B-1, 9-1
		dc.l RAM_start+$1180
		dc.w VRAM_Plane_A_Name_Table+$011A,   8-1, 6-1
		dc.l RAM_start+$1120
		dc.w VRAM_Plane_A_Name_Table+$059A,   8-1, 6-1
		dc.l RAM_start+$1000
		dc.w VRAM_Plane_A_Name_Table+$0A1A,   8-1, 6-1
		dc.l RAM_start+$1060
		dc.w VRAM_Plane_A_Name_Table+$0E9A,   8-1, 6-1
		dc.l RAM_start+$10C0
		dc.w VRAM_Plane_A_Name_Table+$131A,   8-1, 6-1
		dc.l RAM_start+$2000
		dc.w VRAM_Plane_A_Name_Table+$01AC,  $F-1, 5-1
		dc.l RAM_start+$2258
		dc.w VRAM_Plane_A_Name_Table+$062C,  $F-1, 5-1
		dc.l RAM_start+$2096
		dc.w VRAM_Plane_A_Name_Table+$0AAC,  $F-1, 5-1
		dc.l RAM_start+$21C2
		dc.w VRAM_Plane_A_Name_Table+$0F2C,  $F-1, 5-1
		dc.l RAM_start+$212C
		dc.w VRAM_Plane_A_Name_Table+$13AC,  $F-1, 5-1
		dc.l MapUnc_CompetitionTimeBorder
		dc.w VRAM_Plane_A_Name_Table+$00CE,  $C-1, 9-1
		dc.l MapUnc_CompetitionTimeBorder
		dc.w VRAM_Plane_A_Name_Table+$054E,  $C-1, 9-1
		dc.l MapUnc_CompetitionTimeBorder
		dc.w VRAM_Plane_A_Name_Table+$09CE,  $C-1, 9-1
		dc.l MapUnc_CompetitionTimeBorder
		dc.w VRAM_Plane_A_Name_Table+$0E4E,  $C-1, 9-1
		dc.l MapUnc_CompetitionTimeBorder
		dc.w VRAM_Plane_A_Name_Table+$12CE,  $C-1, 9-1
		dc.l MapUnc_CompetitionBESTTIME
		dc.w VRAM_Plane_A_Name_Table+$01D0,   9-1, 2-1
		dc.l MapUnc_CompetitionBESTTIME
		dc.w VRAM_Plane_A_Name_Table+$0650,   9-1, 2-1
		dc.l MapUnc_CompetitionBESTTIME
		dc.w VRAM_Plane_A_Name_Table+$0AD0,   9-1, 2-1
		dc.l MapUnc_CompetitionBESTTIME
		dc.w VRAM_Plane_A_Name_Table+$0F50,   9-1, 2-1
		dc.l MapUnc_CompetitionBESTTIME
		dc.w VRAM_Plane_A_Name_Table+$13D0,   9-1, 2-1
ObjDat_CompetitionMatchRace:
		dc.w $C-1
		dc.l Obj_Competition_ZoneSelect
		dc.w    $F4,     0, palette_line_0
		dc.b    2,   0
		dc.l Obj_Competition_StaticSprite
		dc.w    $B0,   $A9, palette_line_1
		dc.b    3,   0
		dc.l Obj_Competition_1PSelect
		dc.w    $B5,   $C1, palette_line_0
		dc.b    0,   0
		dc.l Obj_CompetitionPlayerSprite
		dc.w    $B5,   $D5, palette_line_0
		dc.b    0,   0
		dc.l Obj_CompetitionPlayerSprite
		dc.w    $B5,   $D5, palette_line_0
		dc.b    2,   1
		dc.l Obj_CompetitionPlayerSprite
		dc.w    $B5,   $D5, palette_line_0
		dc.b    1,   2
		dc.l Obj_Competition_StaticSprite
		dc.w    $B2,  $109, palette_line_1
		dc.b    4,   0
		dc.l Obj_Competition_2PSelect
		dc.w    $B5,  $121, palette_line_0
		dc.b    0,   0
		dc.l Obj_CompetitionPlayerSprite2P
		dc.w    $B5,  $135, palette_line_0
		dc.b    0,   0
		dc.l Obj_CompetitionPlayerSprite2P
		dc.w    $B5,  $135, palette_line_0
		dc.b    2,   1
		dc.l Obj_CompetitionPlayerSprite2P
		dc.w    $B5,  $135, palette_line_0
		dc.b    1,   2
		dc.l Obj_Competition_PRESSSTART
		dc.w    $B1,  $126, palette_line_1
		dc.b    5,   0
ObjDat_CompetitionTimeAttack:
		dc.w 6-1
		dc.l Obj_Competition_ZoneSelect
		dc.w    $F4,   $30, palette_line_0
		dc.b    2,   0
		dc.l Obj_Competition_StaticSprite
		dc.w    $B0,     0, palette_line_1
		dc.b    3,   0
		dc.l Obj_Competition_1PSelect
		dc.w    $B5,   $F1, palette_line_0
		dc.b    0,   0
		dc.l Obj_CompetitionPlayerSprite
		dc.w    $B5,  $101, palette_line_0
		dc.b    0,   0
		dc.l Obj_CompetitionPlayerSprite
		dc.w    $B5,  $101, palette_line_0
		dc.b    2,   1
		dc.l Obj_CompetitionPlayerSprite
		dc.w    $B5,  $101, palette_line_0
		dc.b    1,   2
MapUnc_CompetitionNumbers:
		binclude "General/Competition Menu/Uncompressed Map/Numbers.bin"
		even
; ---------------------------------------------------------------------------

Competition_PlayerSelect:
		jsr	(Pal_FadeToBlack).l
		move	#$2700,sr
		move.w	(VDP_reg_1_command).w,d0
		andi.b	#$BF,d0
		move.w	d0,(VDP_control_port).l
		jsr	(Clear_DisplayData).l
		lea	(VDP_control_port).l,a6
		move.w	#$8004,(a6)			; Command $8004 - Disable HInt, HV Counter
		move.w	#$8230,(a6)			; Command $8230 - Nametable A at $C000
		move.w	#$8407,(a6)			; Command $8407 - Nametable B at $E000
		move.w	#$8700,(a6)			; Command $8700 - BG color is Pal 0 Color 0
		move.w	#$8B00,(a6)
		move.w	#$8C89,(a6)
		move.w	#$9011,(a6)			; 128-cell hScroll table size: 64x64
		jsr	sub_B512(pc)
		move.w	#VRAM_Plane_A_Name_Table+$220,d0
		jsr	sub_B534(pc)
		move.w	#VRAM_Plane_A_Name_Table+$820,d0
		jsr	sub_B534(pc)
		clearRAM	Sprite_table_input,$400
		clearRAM	Object_RAM,(Kos_decomp_buffer-Object_RAM)
		clr.w	(DMA_queue).w
		move.l	#DMA_queue,(DMA_queue_slot).w
		clr.w	(Level_frame_counter).w
		move.w	#-1,(Events_bg+$10).w
		clr.w	(Events_bg+$12).w
		lea	(MapEni_S3MenuBG).l,a0
		lea	(RAM_start).l,a1
		move.w	#make_art_tile(ArtTile_ArtKos_S3MenuBG,0,0),d0
		jsr	(Eni_Decomp).l
		lea	(RAM_start).l,a1
		move.l	#vdpComm(VRAM_Plane_B_Name_Table,VRAM,WRITE),d0
		moveq	#$28-1,d1
		moveq	#$1C-1,d2
		jsr	(Plane_Map_To_VRAM).l
		lea	(ArtKos_S3MenuBG).l,a0				; Decompress source
		lea	(RAM_start).l,a1				; Decompress destination/Transfer source
		movea.w	#tiles_to_bytes(ArtTile_ArtKos_S3MenuBG),a2	; Transfer destination
		jsr	KosArt_To_VDP(pc)
		move.l	#locret_952E,(_unkEF44_1).w
		move.b	#$1E,(V_int_routine).w
		jsr	(Wait_VSync).l
		lea	(ArtKos_CompetitionLevel).l,a0				; Decompress source
		lea	(RAM_start).l,a1					; Decompress destination/Transfer source, used by the next KosArt_To_VDP also
		movea.w	#tiles_to_bytes(ArtTile_ArtKos_Competition_LevSel),a2	; Transfer destination
		jsr	KosArt_To_VDP(pc)
		lea	(ArtKos_CompetitionPlayer).l,a0				; Decompress source
		movea.w	#tiles_to_bytes(ArtTile_ArtKos_Competition_CharSel),a2	; Transfer destination
		jsr	KosArt_To_VDP(pc)
		move.b	#$1E,(V_int_routine).w
		jsr	(Wait_VSync).l
		lea	(Pal_CompetitionMenuBG).l,a0
		lea	(Target_palette).w,a1
		moveq	#bytesToLcnt($20),d0

- ;loc_A280:
		move.l	(a0)+,(a1)+
		dbf	d0,- ;loc_A280
		lea	Pal_Competition2(pc),a0
		moveq	#bytesToLcnt($60),d0

- ;loc_A28C:
		move.l	(a0)+,(a1)+
		dbf	d0,- ;loc_A28C
		lea	(Player_2).w,a0
		lea	ObjDat_A65E(pc),a1
		move.w	(a1)+,d0

- ;loc_A29C:
		move.l	(a1)+,(a0)
		move.l	#Map_CompetitionSelect,mappings(a0)
		move.w	(a1),x_pos(a0)
		move.w	(a1)+,$12(a0)
		move.w	(a1),y_pos(a0)
		move.w	(a1)+,$16(a0)
		move.w	(a1)+,d1
		addi.w	#make_art_tile(ArtTile_ArtKos_Competition_LevSel,0,1),d1
		move.w	d1,art_tile(a0)
		move.b	(a1)+,mapping_frame(a0)
		move.b	(a1)+,$2E(a0)
		lea	next_object(a0),a0
		dbf	d0,- ;loc_A29C
		moveq	#0,d0
		move.b	(P1_character).w,d0
		mulu.w	#$55,d0
		addi.b	#$40,d0
		move.b	d0,(Reserved_object_3+objoff_2E).w
		moveq	#0,d0
		move.b	(P2_character).w,d0
		mulu.w	#$55,d0
		addi.b	#$40,d0
		move.b	d0,(Dynamic_object_RAM+(object_size*4)+objoff_2E).w
		jsr	(Init_SpriteTable).l
		jsr	(Process_Sprites).l
		jsr	(Render_Sprites).l
		jsr	sub_B596(pc)
		jsr	(Process_Sprites).l
		jsr	(Render_Sprites).l
		moveq	#signextendB(mus_CompetitionMenu),d0
		jsr	(Play_Music).l
		move.b	#$1E,(V_int_routine).w
		jsr	(Wait_VSync).l
		move.w	(VDP_reg_1_command).w,d0
		ori.b	#$40,d0
		move.w	d0,(VDP_control_port).l
		jsr	(Pal_FadeFromBlack).l

- ;loc_A33E:
		move.b	#$1E,(V_int_routine).w
		jsr	(Wait_VSync).l
		addq.w	#1,(Level_frame_counter).w
		jsr	(Process_Sprites).l
		jsr	sub_B596(pc)
		jsr	(Render_Sprites).l
		move.b	(Events_bg+$12).w,d0
		beq.s	+ ;loc_A36A
		move.b	d0,(Game_mode).w
		rts
; ---------------------------------------------------------------------------

+ ;loc_A36A:
		move.w	(Events_bg+$10).w,d0
		tst.b	(Not_ghost_flag).w
		bne.s	+ ;loc_A376
		lsr.w	#8,d0

+ ;loc_A376:
		tst.w	d0
		bne.s	- ;loc_A33E
		move.w	#$E00,(Current_zone_and_act).w
		jsr	sub_B5EC(pc)
		move.b	#$C,(Game_mode).w
		rts
; ---------------------------------------------------------------------------

Obj_Competition_StaticSprite:
		move.w	$12(a0),d0
		add.w	(H_scroll_buffer).w,d0
		move.w	d0,x_pos(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_Competition_2PSelect:
		lea	(Ctrl_2_pressed).w,a1
		lea	(Events_bg+$11).w,a2
		lea	(P2_character).w,a3
		tst.b	(Not_ghost_flag).w
		bne.s	++ ;loc_A3CE
		tst.w	(Events_bg+$14).w
		bne.s	+ ;loc_A3BC
		tst.b	(a1)
		smi	(Not_ghost_flag).w

+ ;loc_A3BC:
		moveq	#0,d0
		bra.w	loc_A4CE
; ---------------------------------------------------------------------------

Obj_Competition_1PSelect:
		lea	(Ctrl_1_pressed).w,a1
		lea	(Events_bg+$10).w,a2
		lea	(P1_character).w,a3

+ ;loc_A3CE:
		tst.w	(H_scroll_buffer).w
		bne.w	loc_A4BC
		tst.b	$2F(a0)
		beq.s	+ ;loc_A3EE
		btst	#4,(a1)
		beq.w	loc_A4BC
		sf	$2F(a0)
		st	(a2)
		bra.w	loc_A4BC
; ---------------------------------------------------------------------------

+ ;loc_A3EE:
		tst.b	$30(a0)
		bne.s	loc_A466
		move.b	(a1),d0
		andi.w	#$C,d0
		beq.w	loc_A498
		move.l	d0,-(sp)
		moveq	#signextendB(sfx_GravityTunnel),d0
		jsr	(Play_SFX).l
		move.l	(sp)+,d0
		clr.b	$34(a0)
		move.b	$2E(a0),$35(a0)
		btst	#2,d0
		bne.s	loc_A442
		move.b	#1,$30(a0)
		move.b	(a3),d0
		addq.b	#1,d0
		cmpi.b	#2,d0
		bls.s	+ ;loc_A42C
		moveq	#0,d0

+ ;loc_A42C:
		move.b	d0,(a3)
		mulu.w	#$55,d0
		bne.s	+ ;loc_A438
		move.w	#$100,d0

+ ;loc_A438:
		addi.w	#$40,d0
		move.w	d0,$32(a0)
		bra.s	loc_A466
; ---------------------------------------------------------------------------

loc_A442:
		move.b	#-1,$30(a0)
		move.b	(a3),d0
		subq.b	#1,d0
		bcc.s	+ ;loc_A450
		moveq	#2,d0

+ ;loc_A450:
		move.b	d0,(a3)
		mulu.w	#$55,d0
		cmpi.w	#$80,d0
		blo.s	+ ;loc_A45E
		ext.w	d0

+ ;loc_A45E:
		addi.w	#$40,d0
		move.w	d0,$32(a0)

loc_A466:
		move.w	$34(a0),d0
		move.w	$32(a0),d1
		tst.b	$30(a0)
		bmi.s	+ ;loc_A482
		addq.w	#5,d0
		cmp.w	d0,d1
		bgt.s	++ ;loc_A48E
		move.w	d1,d0
		clr.b	$30(a0)
		bra.s	++ ;loc_A48E
; ---------------------------------------------------------------------------

+ ;loc_A482:
		subq.w	#5,d0
		cmp.w	d0,d1
		blt.s	+ ;loc_A48E
		move.w	d1,d0
		clr.b	$30(a0)

+ ;loc_A48E:
		move.w	d0,$34(a0)
		move.b	d0,$2E(a0)
		bra.s	loc_A4BC
; ---------------------------------------------------------------------------

loc_A498:
		btst	#4,(a1)
		beq.s	+ ;loc_A4A6
		move.b	#$38,(Events_bg+$12).w
		bra.s	loc_A4BC
; ---------------------------------------------------------------------------

+ ;loc_A4A6:
		move.b	(a1),d0
		andi.w	#$E0,d0
		beq.s	loc_A4BC
		st	$2F(a0)
		sf	(a2)
		moveq	#signextendB(sfx_Starpost),d0
		jsr	(Play_SFX).l

loc_A4BC:
		moveq	#1,d0
		tst.b	$2F(a0)
		bne.s	loc_A4CE
		move.w	(Level_frame_counter).w,d0
		lsr.w	#3,d0
		andi.w	#1,d0

loc_A4CE:
		move.b	d0,mapping_frame(a0)
		move.w	$12(a0),d0
		add.w	(H_scroll_buffer).w,d0
		move.w	d0,x_pos(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_CompetitionPlayerSprite2P:
		tst.b	(Not_ghost_flag).w
		bne.s	Obj_CompetitionPlayerSprite
		rts
; ---------------------------------------------------------------------------

Obj_CompetitionPlayerSprite:
		move.l	#Map_CompetitionPlayerSprite,mappings(a0)
		move.w	#make_art_tile(ArtTile_ArtKos_Competition_CharSel,1,0),art_tile(a0)
		moveq	#0,d0
		moveq	#-$55,d1
		moveq	#0,d2
		move.b	$2E(a0),d2

- ;loc_A504:
		addi.w	#object_size,d0
		addi.w	#$55,d1
		dbf	d2,- ;loc_A504
		neg.w	d0
		move.b	$2E(a0,d0.w),d0
		add.b	d1,d0
		jsr	(GetSineCosine).l
		asr.w	#4,d1
		add.w	$12(a0),d1
		add.w	(H_scroll_buffer).w,d1
		move.w	d1,x_pos(a0)
		asr.w	#5,d0
		add.w	$16(a0),d0
		move.w	d0,y_pos(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_Competition_PRESSSTART:
		tst.b	(Not_ghost_flag).w
		bne.s	locret_A55C
		btst	#5,(Level_frame_counter+1).w
		beq.s	locret_A55C
		move.w	$12(a0),d0
		add.w	(H_scroll_buffer).w,d0
		move.w	d0,x_pos(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

locret_A55C:
		rts
; ---------------------------------------------------------------------------
Pal_Competition2:
		binclude "General/Competition Menu/Palettes/2.bin"
		even
Pal_Competition3:
		binclude "General/Competition Menu/Palettes/3.bin"
		even
Pal_Competition4:
		binclude "General/Competition Menu/Palettes/4.bin"
		even
ObjDat_A65E:
		dc.w $B-1
		dc.l Obj_Competition_StaticSprite
		dc.w   $120,   $A9, palette_line_1
		dc.b    3,   0
		dc.l Obj_Competition_1PSelect
		dc.w   $125,   $C1, palette_line_0
		dc.b    0,   0
		dc.l Obj_CompetitionPlayerSprite
		dc.w   $125,   $D5, palette_line_0
		dc.b    0,   0
		dc.l Obj_CompetitionPlayerSprite
		dc.w   $125,   $D5, palette_line_0
		dc.b    2,   1
		dc.l Obj_CompetitionPlayerSprite
		dc.w   $125,   $D5, palette_line_0
		dc.b    1,   2
		dc.l Obj_Competition_StaticSprite
		dc.w   $122,  $109, palette_line_1
		dc.b    4,   0
		dc.l Obj_Competition_2PSelect
		dc.w   $125,  $121, palette_line_0
		dc.b    0,   0
		dc.l Obj_CompetitionPlayerSprite2P
		dc.w   $125,  $135, palette_line_0
		dc.b    0,   0
		dc.l Obj_CompetitionPlayerSprite2P
		dc.w   $125,  $135, palette_line_0
		dc.b    2,   1
		dc.l Obj_CompetitionPlayerSprite2P
		dc.w   $125,  $135, palette_line_0
		dc.b    1,   2
		dc.l Obj_Competition_PRESSSTART
		dc.w   $121,  $126, palette_line_1
		dc.b    5,   0
Map_CompetitionSelect:
		include "General/Competition Menu/Map - Competition Select.asm"
; ---------------------------------------------------------------------------

Competition_Results:
		jsr	(Pal_FadeToBlack).l
		move	#$2700,sr
		move.w	(VDP_reg_1_command).w,d0
		andi.b	#$BF,d0
		move.w	d0,(VDP_control_port).l
		jsr	(Clear_DisplayData).l
		lea	(VDP_control_port).l,a6
		move.w	#$8004,(a6)			; Command $8004 - Disable HInt, HV Counter
		move.w	#$8230,(a6)			; Command $8230 - Nametable A at $C000
		move.w	#$8407,(a6)			; Command $8407 - Nametable B at $E000
		move.w	#$8700,(a6)			; Command $8700 - BG color is Pal 0 Color 0
		move.w	#$8B00,(a6)
		move.w	#$8C89,(a6)
		move.w	#$9011,(a6)			; 128-cell hScroll table size: 64x64
		jsr	sub_B512(pc)
		move.w	#VRAM_Plane_A_Name_Table+$1AA,d0
		jsr	sub_B534(pc)
		move.w	#VRAM_Plane_A_Name_Table+$82A,d0
		jsr	sub_B534(pc)
		clearRAM	Sprite_table_input,$400
		clearRAM	Object_RAM,(Kos_decomp_buffer-Object_RAM)
		clr.w	(DMA_queue).w
		move.l	#DMA_queue,(DMA_queue_slot).w
		clr.w	(Level_frame_counter).w
		clr.w	(Competition_mode).w
		clr.b	(Level_started_flag).w
		move.w	#$1E,(Events_bg+$16).w
		lea	(MapEni_S3MenuBG).l,a0
		lea	(RAM_start).l,a1
		move.w	#make_art_tile(ArtTile_ArtKos_S3MenuBG,0,0),d0
		jsr	(Eni_Decomp).l
		lea	MapEni_CompetitionResultsLED(pc),a0
		lea	(RAM_start+$1000).l,a1
		move.w	#make_art_tile(ArtTile_ArtKos_Competition_Results,1,1),d0
		jsr	(Eni_Decomp).l
		lea	VRAMDatList_AE06(pc),a0
		jsr	Copy_Listed_Data_To_VRAM(pc)
		jsr	sub_AC44(pc)
		lea	(ArtKos_S3MenuBG).l,a0				; Decompress source
		lea	(RAM_start).l,a1				; Decompress destination/Transfer source
		movea.w	#tiles_to_bytes(ArtTile_ArtKos_S3MenuBG),a2	; Transfer destination
		jsr	KosArt_To_VDP(pc)
		move.l	#locret_952E,(_unkEF44_1).w
		move.b	#$1E,(V_int_routine).w
		jsr	(Wait_VSync).l
		lea	(ArtKos_CompetitionLevel).l,a0				; Decompress source
		lea	(RAM_start).l,a1					; Decompress destination/Transfer source, used by the next two KosArt_To_VDP also
		movea.w	#tiles_to_bytes(ArtTile_ArtKos_Competition_LevSel),a2	; Transfer destination
		jsr	KosArt_To_VDP(pc)
		lea	(ArtKos_CompetitionResults).l,a0			; Decompress source
		movea.w	#tiles_to_bytes(ArtTile_ArtKos_Competition_Results),a2	; Transfer destination
		jsr	KosArt_To_VDP(pc)
		lea	(ArtKos_CompetitionPlayer).l,a0				; Decompress source
		movea.w	#tiles_to_bytes(ArtTile_ArtKos_Competition_CharSel),a2	; Transfer destination
		jsr	KosArt_To_VDP(pc)
		move.b	#$1E,(V_int_routine).w
		jsr	(Wait_VSync).l
		lea	(Pal_CompetitionMenuBG).l,a0
		lea	(Target_palette).w,a1
		moveq	#bytesToLcnt($20),d0

- ;loc_AACC:
		move.l	(a0)+,(a1)+
		dbf	d0,- ;loc_AACC
		lea	Pal_Competition2(pc),a0
		moveq	#bytesToLcnt($40),d0

- ;loc_AAD8:
		move.l	(a0)+,(a1)+
		dbf	d0,- ;loc_AAD8
		lea	Pal_CompetitionResults(pc),a0
		moveq	#bytesToLcnt($20),d0

- ;loc_AAE4:
		move.l	(a0)+,(a1)+
		dbf	d0,- ;loc_AAE4
		lea	(Object_RAM).w,a0
		lea	ObjDat_ADA4(pc),a1
		move.w	(a1)+,d0

- ;loc_AAF4:
		move.l	(a1)+,(a0)
		move.l	#Map_CompetitionSelect,mappings(a0)
		move.w	(a1),x_pos(a0)
		move.w	(a1)+,$12(a0)
		move.w	(a1),y_pos(a0)
		move.w	(a1)+,$16(a0)
		move.w	(a1)+,d1
		addi.w	#make_art_tile(ArtTile_ArtKos_Competition_LevSel,0,1),d1
		move.w	d1,art_tile(a0)
		move.b	(a1)+,mapping_frame(a0)
		move.b	(a1)+,$2E(a0)
		lea	next_object(a0),a0
		dbf	d0,- ;loc_AAF4
		jsr	(Init_SpriteTable).l
		jsr	(Process_Sprites).l
		jsr	(Render_Sprites).l
		moveq	#signextendB(mus_Continue),d0
		jsr	(Play_Music).l
		move.b	#$1E,(V_int_routine).w
		jsr	(Wait_VSync).l
		move.w	(VDP_reg_1_command).w,d0
		ori.b	#$40,d0
		move.w	d0,(VDP_control_port).l
		jsr	(Pal_FadeFromBlack).l

loc_AB62:
		move.b	#$1E,(V_int_routine).w
		jsr	(Wait_VSync).l
		addq.w	#1,(Level_frame_counter).w
		move.w	(_unkEEA0).w,d7
		beq.s	++ ;loc_AB92
		btst	#3,(Level_frame_counter+1).w
		bne.s	+ ;loc_AB8A
		lea	(Plane_buffer+$20).w,a1
		jsr	loc_9F0A(pc)
		bra.s	++ ;loc_AB92
; ---------------------------------------------------------------------------

+ ;loc_AB8A:
		move.l	(_unkEE98).w,d6
		jsr	sub_9ECC(pc)

+ ;loc_AB92:
		tst.w	(Events_bg+$16).w
		beq.s	+ ;loc_AB9E
		subq.w	#1,(Events_bg+$16).w
		bra.s	loc_ABD6
; ---------------------------------------------------------------------------

+ ;loc_AB9E:
		move.b	(Ctrl_1_pressed).w,d0
		tst.b	(Not_ghost_flag).w
		beq.s	+ ;loc_ABAC
		or.b	(Ctrl_2_pressed).w,d0

+ ;loc_ABAC:
		move.w	(H_scroll_buffer).w,d1
		beq.s	+ ;loc_ABBA
		cmpi.w	#$FF78,d1
		beq.s	+++ ;loc_ABC8
		bra.s	++ ;loc_ABC0
; ---------------------------------------------------------------------------

+ ;loc_ABBA:
		andi.w	#button_start_mask|button_A_mask|button_C_mask,d0
		beq.s	loc_ABD6

+ ;loc_ABC0:
		subq.w	#8,d1
		move.w	d1,(H_scroll_buffer).w
		bra.s	loc_ABD6
; ---------------------------------------------------------------------------

+ ;loc_ABC8:
		andi.w	#button_start_mask|button_A_mask|button_C_mask,d0
		beq.s	loc_ABD6
		move.b	#$38,(Game_mode).w
		rts
; ---------------------------------------------------------------------------

loc_ABD6:
		jsr	(Process_Sprites).l
		jsr	(Render_Sprites).l
		bra.w	loc_AB62
; ---------------------------------------------------------------------------

Obj_Competition_ABE6:
		move.l	#Map_CompetitionPlayerSprite,mappings(a0)
		move.w	#make_art_tile(ArtTile_ArtKos_Competition_CharSel,1,1),art_tile(a0)
		move.b	(P1_character).w,d0
		tst.b	$2E(a0)
		beq.s	+ ;loc_AC02
		move.b	(P2_character).w,d0

+ ;loc_AC02:
		move.b	d0,mapping_frame(a0)
		jmp	Obj_Competition_StaticSprite(pc)
; ---------------------------------------------------------------------------

Obj_Competition_AC0A:
		move.w	#make_art_tile(ArtTile_ArtKos_Competition_Results,1,1),art_tile(a0)
		move.b	(_unkEEA2).w,d0
		move.b	(_unkEEA2+1).w,d1
		tst.b	$2E(a0)
		beq.s	+ ;loc_AC20
		exg	d0,d1

+ ;loc_AC20:
		moveq	#$D,d2
		cmp.b	d0,d1
		beq.s	++ ;loc_AC2C
		bcs.s	+ ;loc_AC2A
		addq.w	#1,d2

+ ;loc_AC2A:
		subq.b	#2,d2

+ ;loc_AC2C:
		move.b	d2,mapping_frame(a0)
		cmpi.b	#$B,d2
		bne.w	Obj_Competition_StaticSprite
		btst	#3,(Level_frame_counter+1).w
		bne.w	Obj_Competition_StaticSprite
		rts

; =============== S U B R O U T I N E =======================================


sub_AC44:
		lea	($FF7800).l,a0
		move.w	#$C15A,d7
		jsr	sub_AD28(pc)
		move.w	#$C7DA,d7
		jsr	sub_AD28(pc)
		lea	($FF7800).l,a0
		jsr	sub_AD3E(pc)
		move.w	#$C65A,d7
		move.l	d6,(_unkEE98).w
		move.w	d7,(_unkEEA0).w
		jsr	sub_9ECC(pc)
		jsr	sub_AD3E(pc)
		move.w	#$CCDA,d7
		cmp.l	(_unkEE98).w,d6
		bhi.s	++ ;loc_AC92
		bne.s	+ ;loc_AC8A
		clr.w	(_unkEEA0).w
		bra.s	++ ;loc_AC92
; ---------------------------------------------------------------------------

+ ;loc_AC8A:
		move.l	d6,(_unkEE98).w
		move.w	d7,(_unkEEA0).w

+ ;loc_AC92:
		jsr	sub_9ECC(pc)
		clr.w	(_unkEEA2).w
		lea	($FF7800).l,a0
		move.l	#vdpComm(VRAM_Plane_A_Name_Table+$148,VRAM,WRITE),d5
		moveq	#5-1,d7

- ;loc_ACA8:
		lea	MapUnc_ResultsWin(pc),a1
		lea	MapUnc_ResultsLose(pc),a2
		addq.b	#1,(_unkEEA2).w
		move.l	(a0)+,d0
		cmp.l	x_pos(a0),d0
		beq.s	+ ;loc_ACCA
		bcs.s	++ ;loc_ACD4
		exg	a1,a2
		subq.b	#1,(_unkEEA2).w
		addq.b	#1,(_unkEEA2+1).w
		bra.s	++ ;loc_ACD4
; ---------------------------------------------------------------------------

+ ;loc_ACCA:
		lea	MapUnc_ResultsTie(pc),a1
		movea.l	a1,a2
		subq.b	#1,(_unkEEA2).w

+ ;loc_ACD4:
		move.l	d5,d0
		moveq	#2-1,d1
		moveq	#2-1,d2
		jsr	(Plane_Map_To_VRAM).l
		movea.l	a2,a1
		move.l	d5,d0
		addi.l	#$680<<16,d0
		moveq	#2-1,d1
		moveq	#2-1,d2
		jsr	(Plane_Map_To_VRAM).l
		addi.l	#$100<<16,d5
		dbf	d7,- ;loc_ACA8
		move.w	(_unkEEA0).w,d7
		beq.s	locret_AD26
		move.l	(_unkEE98).w,d6
		jsr	sub_9ECC(pc)
		lea	(Plane_buffer).w,a0
		lea	$20(a0),a1
		moveq	#$10-1,d0

- ;loc_AD16:
		move.w	(a0)+,d1
		andi.w	#$9FFF,d1
		ori.w	#$6000,d1
		move.w	d1,(a1)+
		dbf	d0,- ;loc_AD16

locret_AD26:
		rts
; End of function sub_AC44


; =============== S U B R O U T I N E =======================================


sub_AD28:
		moveq	#5-1,d0

- ;
loc_AD2A:
		move.w	d0,-(sp)
		move.l	(a0)+,d6
		jsr	sub_9ECC(pc)
		addi.w	#$100,d7
		move.w	(sp)+,d0
		dbf	d0,- ;loc_AD2A
		rts
; End of function sub_AD28


; =============== S U B R O U T I N E =======================================


sub_AD3E:
		clr.l	(_unkEF40_1).w
		moveq	#5-1,d7

- ;loc_AD44:
		move.l	(a0)+,d6
		lea	(_unkEF44_2).w,a1
		add.b	d6,-(a1)
		cmpi.b	#100,(a1)
		blo.s	+ ;loc_AD5A
		subi.b	#100,(a1)
		addq.b	#1,-1(a1)

+ ;loc_AD5A:
		lsr.l	#8,d6
		add.b	d6,-(a1)
		cmpi.b	#60,(a1)
		blo.s	+ ;loc_AD6C
		subi.b	#60,(a1)
		addq.b	#1,-1(a1)

+ ;loc_AD6C:
		lsr.l	#8,d6
		add.b	d6,-(a1)
		cmpi.b	#100,(a1)
		blo.s	+ ;loc_AD7A
		move.b	#99,(a1)

+ ;loc_AD7A:
		dbf	d7,- ;loc_AD44
		move.l	(_unkEF40_1).w,d6
		rts
; End of function sub_AD3E

; ---------------------------------------------------------------------------
Pal_CompetitionResults:
		binclude "General/Competition Menu/Palettes/Results.bin"
		even
ObjDat_ADA4:
		dc.w 8-1
		dc.l Obj_Competition_StaticSprite
		dc.w   $148,   $A1, palette_line_1
		dc.b    3,   0
		dc.l Obj_Competition_StaticSprite
		dc.w   $14D,   $B9, palette_line_0
		dc.b    0,   0
		dc.l Obj_Competition_ABE6
		dc.w   $14D,   $D3, palette_line_0
		dc.b    0,   0
		dc.l Obj_Competition_AC0A
		dc.w    $CC,   $BC, palette_line_0
		dc.b    0,   0
		dc.l Obj_Competition_StaticSprite
		dc.w   $14A,  $109, palette_line_1
		dc.b    4,   0
		dc.l Obj_Competition_StaticSprite
		dc.w   $14D,  $121, palette_line_0
		dc.b    0,   0
		dc.l Obj_Competition_ABE6
		dc.w   $14D,  $13B, palette_line_0
		dc.b    0,   1
		dc.l Obj_Competition_AC0A
		dc.w    $CC,  $124, palette_line_0
		dc.b    0,   1
VRAMDatList_AE06:
		dc.w 9-1
		dc.l RAM_start+$0000
		dc.w VRAM_Plane_B_Name_Table+$000, $28-1, $1C-1
		dc.l RAM_start+$1000
		dc.w VRAM_Plane_A_Name_Table+$204,  $F-1,   6-1
		dc.l RAM_start+$1000
		dc.w VRAM_Plane_A_Name_Table+$884,  $F-1,   6-1
		dc.l MapUnc_CompetitionResultsLetters
		dc.w VRAM_Plane_A_Name_Table+$142,   2-1,  $A-1
		dc.l MapUnc_CompetitionResultsLetters
		dc.w VRAM_Plane_A_Name_Table+$7C2,   2-1,  $A-1
		dc.l MapUnc_CompetitionResultsDividers
		dc.w VRAM_Plane_A_Name_Table+$152,   4-1,  $A-1
		dc.l MapUnc_CompetitionResultsDividers
		dc.w VRAM_Plane_A_Name_Table+$7D2,   4-1,  $A-1
		dc.l MapUnc_CompetitionResultsTOTAL
		dc.w VRAM_Plane_A_Name_Table+$650,   5-1,   2-1
		dc.l MapUnc_CompetitionResultsTOTAL
		dc.w VRAM_Plane_A_Name_Table+$CD0,   5-1,   2-1
MapEni_CompetitionResultsLED:
		binclude "General/Competition Menu/Enigma Map/Menu.bin"
		even
MapUnc_CompetitionResultsLetters:
		binclude "General/Competition Menu/Uncompressed Map/Results Letters.bin"
		even
MapUnc_CompetitionResultsDividers:
		binclude "General/Competition Menu/Uncompressed Map/Results Dividers.bin"
		even
MapUnc_CompetitionResultsTOTAL:
		binclude "General/Competition Menu/Uncompressed Map/Results TOTAL.bin"
		even
MapUnc_ResultsWin:
		binclude "General/Competition Menu/Uncompressed Map/Results Win.bin"
		even
MapUnc_ResultsLose:
		binclude "General/Competition Menu/Uncompressed Map/Results Lose.bin"
		even
MapUnc_ResultsTie:
		binclude "General/Competition Menu/Uncompressed Map/Results Tie.bin"
		even
; ---------------------------------------------------------------------------

TimeAttack_Records:
		jsr	(Pal_FadeToBlack).l
		move	#$2700,sr
		move.w	(VDP_reg_1_command).w,d0
		andi.b	#$BF,d0
		move.w	d0,(VDP_control_port).l
		jsr	(Clear_DisplayData).l
		lea	(VDP_control_port).l,a6
		move.w	#$8004,(a6)			; Command $8004 - Disable HInt, HV Counter
		move.w	#$8230,(a6)			; Command $8230 - Nametable A at $C000
		move.w	#$8407,(a6)			; Command $8407 - Nametable B at $E000
		move.w	#$8700,(a6)			; Command $8700 - BG color is Pal 0 Color 0
		move.w	#$8B00,(a6)
		move.w	#$8C89,(a6)
		move.w	#$9011,(a6)			; 128-cell hScroll table size: 64x64
		jsr	sub_B512(pc)
		move.w	#VRAM_Plane_A_Name_Table+$1AA,d0
		jsr	sub_B534(pc)
		clearRAM	Sprite_table_input,$400
		clearRAM	Object_RAM,(Kos_decomp_buffer-Object_RAM)
		clr.w	(DMA_queue).w
		move.l	#DMA_queue,(DMA_queue_slot).w
		clr.w	(Level_frame_counter).w
		clr.w	(Competition_mode).w
		clr.b	(Level_started_flag).w
		move.w	#$1E,(Events_bg+$16).w
		move.w	#$FF78,(H_scroll_buffer).w
		lea	(MapEni_S3MenuBG).l,a0
		lea	(RAM_start).l,a1
		move.w	#make_art_tile(ArtTile_ArtKos_S3MenuBG,0,0),d0
		jsr	(Eni_Decomp).l
		lea	VRAMDatList_B2CA(pc),a0
		jsr	Copy_Listed_Data_To_VRAM(pc)
		moveq	#0,d0
		move.b	(Current_zone).w,d0
		subi.w	#$E,d0
		lsl.w	#2,d0
		lea	CompTimeAttack_LevelNameMaps(pc),a1
		movea.l	(a1,d0.w),a1
		move.l	#vdpComm(VRAM_Plane_A_Name_Table+$826,VRAM,WRITE),d0
		moveq	#$D-1,d1
		moveq	#2-1,d2
		jsr	(Plane_Map_To_VRAM).l
		jsr	sub_B1C6(pc)
		move.l	#vdpComm(tiles_to_bytes($58D),VRAM,WRITE),(VDP_control_port).l
		lea	(ArtNem_ContinueDigits).l,a0
		jsr	(Nem_Decomp).l
		move.l	#vdpComm(tiles_to_bytes($5A1),VRAM,WRITE),(VDP_control_port).l
		lea	(ArtNem_S38x16Font).l,a0
		jsr	(Nem_Decomp).l
		lea	(ArtKos_S3MenuBG).l,a0				; Decompress source
		lea	(RAM_start).l,a1				; Decompress destination/Transfer source
		movea.w	#tiles_to_bytes(ArtTile_ArtKos_S3MenuBG),a2	; Transfer destination
		jsr	KosArt_To_VDP(pc)
		move.l	#locret_952E,(_unkEF44_1).w
		move.b	#$1E,(V_int_routine).w
		jsr	(Wait_VSync).l
		lea	(ArtKos_CompetitionLevel).l,a0				; Decompress source
		lea	(RAM_start).l,a1					; Decompress destination/Transfer source, used by the next two KosArt_To_VDP also
		movea.w	#tiles_to_bytes(ArtTile_ArtKos_Competition_LevSel),a2	; Transfer destination
		jsr	KosArt_To_VDP(pc)
		lea	(ArtKos_CompetitionResults).l,a0			; Decompress source
		movea.w	#tiles_to_bytes(ArtTile_ArtKos_Competition_Results),a2	; Transfer destination
		jsr	KosArt_To_VDP(pc)
		lea	(ArtKos_CompetitionPlayer).l,a0				; Decompress source
		movea.w	#tiles_to_bytes(ArtTile_ArtKos_Competition_CharSel),a2	; Transfer destination
		jsr	KosArt_To_VDP(pc)
		move.b	#$1E,(V_int_routine).w
		jsr	(Wait_VSync).l
		lea	(ArtKos_SSResultsGeneral).l,a0
		lea	(RAM_start+$20).l,a1
		jsr	(Kos_Decomp).l
		lea	(ArtKos_SSResultsTKIcons).l,a0
		jsr	(Kos_Decomp).l
		move	#$2700,sr
		move.l	#vdpComm(tiles_to_bytes($572),VRAM,WRITE),(VDP_control_port).l
		lea	(RAM_start+$EE0).l,a0
		lea	(VDP_data_port).l,a6
		move.w	#bytesToLcnt(tiles_to_bytes($1B)),d0

- ;loc_B0C2:
		move.l	(a0)+,(a6)
		dbf	d0,- ;loc_B0C2
		lea	(Pal_CompetitionMenuBG).l,a0
		lea	(Target_palette).w,a1
		moveq	#bytesToLcnt($20),d0

- ;loc_B0D4:
		move.l	(a0)+,(a1)+
		dbf	d0,- ;loc_B0D4
		lea	Pal_Competition2(pc),a0
		moveq	#bytesToLcnt($40),d0

- ;loc_B0E0:
		move.l	(a0)+,(a1)+
		dbf	d0,- ;loc_B0E0
		lea	Pal_CompetitionTimeAttack(pc),a0
		moveq	#bytesToLcnt($20),d0

- ;loc_B0EC:
		move.l	(a0)+,(a1)+
		dbf	d0,- ;loc_B0EC
		lea	(Object_RAM).w,a0
		lea	ObjDat_B28C(pc),a1
		move.w	(a1)+,d0

- ;loc_B0FC:
		move.l	(a1)+,(a0)
		move.l	#Map_CompetitionSelect,mappings(a0)
		move.w	(a1),x_pos(a0)
		move.w	(a1)+,$12(a0)
		move.w	(a1),y_pos(a0)
		move.w	(a1)+,$16(a0)
		move.w	(a1)+,d1
		addi.w	#make_art_tile($29F,0,1),d1
		move.w	d1,art_tile(a0)
		move.b	(a1)+,mapping_frame(a0)
		move.b	(a1)+,$2E(a0)
		lea	next_object(a0),a0
		dbf	d0,- ;loc_B0FC
		jsr	(Init_SpriteTable).l
		jsr	(Process_Sprites).l
		jsr	(Render_Sprites).l
		moveq	#signextendB(mus_Continue),d0
		jsr	(Play_Music).l
		move.b	#$1E,(V_int_routine).w
		jsr	(Wait_VSync).l
		move.w	(VDP_reg_1_command).w,d0
		ori.b	#$40,d0
		move.w	d0,(VDP_control_port).l
		jsr	(Pal_FadeFromBlack).l

- ;loc_B16A:
		move.b	#$1E,(V_int_routine).w
		jsr	(Wait_VSync).l
		addq.w	#1,(Level_frame_counter).w
		move.w	(_unkEEA0).w,d7
		beq.s	++ ;loc_B19A
		btst	#3,(Level_frame_counter+1).w
		bne.s	+ ;loc_B192
		lea	(Plane_buffer+$20).w,a1
		jsr	loc_9F0A(pc)
		bra.s	++ ;loc_B19A
; ---------------------------------------------------------------------------

+ ;loc_B192:
		move.l	(_unkEE98).w,d6
		jsr	sub_9ECC(pc)

+ ;loc_B19A:
		tst.w	(Events_bg+$16).w
		beq.s	+ ;loc_B1A6
		subq.w	#1,(Events_bg+$16).w
		bra.s	++ ;loc_B1B8
; ---------------------------------------------------------------------------

+ ;loc_B1A6:
		move.b	(Ctrl_1_pressed).w,d0
		andi.w	#button_start_mask|button_A_mask|button_C_mask,d0
		beq.s	+ ;loc_B1B8
		move.b	#$C0,(Game_mode).w
		rts
; ---------------------------------------------------------------------------

+ ;loc_B1B8:
		jsr	(Process_Sprites).l
		jsr	(Render_Sprites).l
		bra.s	- ;loc_B16A

; =============== S U B R O U T I N E =======================================


sub_B1C6:
		lea	($FF7828).l,a0
		move.w	#VRAM_Plane_A_Name_Table+$15A,d7
		moveq	#6-1,d0
		jsr	loc_AD2A(pc)
		moveq	#0,d0
		move.b	(Current_zone).w,d0
		subi.w	#$E,d0
		lsl.w	#4,d0
		lea	(Competition_saved_data).w,a0
		adda.w	d0,a0
		move.w	#VRAM_Plane_A_Name_Table+$95A,d7
		move.l	(a0)+,d6
		jsr	sub_9ECC(pc)
		addi.w	#$180,d7
		move.l	(a0)+,d6
		jsr	sub_9ECC(pc)
		addi.w	#$180,d7
		move.l	(a0)+,d6
		jsr	sub_9ECC(pc)
		clr.w	(_unkEEA0).w
		rts
; End of function sub_B1C6

; ---------------------------------------------------------------------------

Obj_Competition_B20C:
		move.l	#Map_Results,mappings(a0)
		move.w	#make_art_tile($4FB,1,1),art_tile(a0)
		moveq	#0,d0
		move.b	(Current_zone).w,d0
		subi.w	#$E,d0
		lsl.w	#4,d0
		lea	(Competition_saved_data).w,a1
		lea	$C(a1,d0.w),a1
		moveq	#0,d0
		move.b	$2E(a0),d0
		move.b	(a1,d0.w),d0
		cmpi.w	#2,d0
		bne.s	+ ;loc_B244
		addi.w	#palette_line_1,art_tile(a0)

+ ;loc_B244:
		addi.w	#$29,d0
		move.b	d0,mapping_frame(a0)
		move.l	#loc_B252,(a0)

loc_B252:
		move.b	(Competition_time_attack_new_top_record).w,d0
		cmp.b	$2E(a0),d0
		bne.s	+ ;loc_B264
		btst	#3,(Level_frame_counter+1).w
		beq.s	locret_B26A

+ ;loc_B264:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

locret_B26A:
		rts
; ---------------------------------------------------------------------------
Pal_CompetitionTimeAttack:
		binclude "General/Competition Menu/Palettes/Time Attack.bin"
		even
ObjDat_B28C:
		dc.w 5-1
		dc.l Obj_Competition_StaticSprite
		dc.w   $14D,   $B9, palette_line_0
		dc.b    0,   0
		dc.l Obj_Competition_ABE6
		dc.w   $14D,   $CB, palette_line_0
		dc.b    0,   0
		dc.l Obj_Competition_B20C
		dc.w   $130,  $120, palette_line_0
		dc.b    0,   0
		dc.l Obj_Competition_B20C
		dc.w   $130,  $138, palette_line_0
		dc.b    0,   1
		dc.l Obj_Competition_B20C
		dc.w   $130,  $150, palette_line_0
		dc.b    0,   2
VRAMDatList_B2CA:
		dc.w 9-1
		dc.l RAM_start+$0000
		dc.w VRAM_Plane_B_Name_Table+$000, $28-1, $1C-1
		dc.l MapUnc_CompetitionLAPNum
		dc.w VRAM_Plane_A_Name_Table+$144,   5-1,  $A-1
		dc.l MapUnc_CompetitionResultsDividers
		dc.w VRAM_Plane_A_Name_Table+$152,   4-1,  $A-1
		dc.l MapUnc_CompetitionResultsTOTAL
		dc.w VRAM_Plane_A_Name_Table+$650,   5-1,   2-1
		dc.l MapUnc_CompetitionResultsDividers
		dc.w VRAM_Plane_A_Name_Table+$952,   4-1,   2-1
		dc.l MapUnc_CompetitionResultsDividers
		dc.w VRAM_Plane_A_Name_Table+$AD2,   4-1,   2-1
		dc.l MapUnc_CompetitionResultsDividers
		dc.w VRAM_Plane_A_Name_Table+$C52,   4-1,   2-1
		dc.l MapUnc_CompetitionRECORDS
		dc.w VRAM_Plane_A_Name_Table+$92C,   7-1,   2-1
		dc.l MapUnc_Competition1st2nd3rd
		dc.w VRAM_Plane_A_Name_Table+$944,   3-1,   8-1
MapUnc_CompetitionLAPNum:
		binclude "General/Competition Menu/Uncompressed Map/LAP.bin"
		even
MapUnc_CompetitionRECORDS:
		binclude "General/Competition Menu/Uncompressed Map/RECORDS.bin"
		even
MapUnc_Competition1st2nd3rd:
		binclude "General/Competition Menu/Uncompressed Map/1ST 2ND 3RD.bin"
		even
CompTimeAttack_LevelNameMaps:
		dc.l MapUnc_CompetitionAZURELAKE
		dc.l MapUnc_CompetitionBALLOONPARK
		dc.l MapUnc_CompetitionDESERTPALACE
		dc.l MapUnc_CompetitionCHROMEGADGET
		dc.l MapUnc_CompetitionENDLESSMINE
MapUnc_CompetitionAZURELAKE:
		binclude "General/Competition Menu/Uncompressed Map/AZURE LAKE.bin"
		even
MapUnc_CompetitionBALLOONPARK:
		binclude "General/Competition Menu/Uncompressed Map/BALLOON PARK.bin"
		even
MapUnc_CompetitionCHROMEGADGET:
		binclude "General/Competition Menu/Uncompressed Map/CHROME GADGET.bin"
		even
MapUnc_CompetitionDESERTPALACE:
		binclude "General/Competition Menu/Uncompressed Map/DESERT PALACE.bin"
		even
MapUnc_CompetitionENDLESSMINE:
		binclude "General/Competition Menu/Uncompressed Map/ENDLESS MINE.bin"
		even

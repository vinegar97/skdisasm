; =============== S U B R O U T I N E =======================================


KosArt_To_VDP:
		movea.l	a1,a3		; a1 will be changed by Kos_Decomp, so we're backing it up to a3
		jsr	(Kos_Decomp).l

		move.l	a3,d1		; move the backed-up a1 to d1
		andi.l	#$FFFFFF,d1	; d1 will be used in the DMA transfer as the Source Address

		move.l	a1,d3		; move end address of decompressed art to d3
		sub.l	a3,d3		; subtract 'start address of decompressed art' from 'end address of decompressed art', giving you the size of the decompressed art
		lsr.l	#1,d3		; divide size of decompressed art by two, d3 will be used in the DMA transfer as the Transfer Length (size/2)

		move.w	a2,d2		; move VRAM address to d2, d2 will be used in the DMA transfer as the Destination Address

		movea.l	a1,a3		; backup a1, this allows the same address to be used by multiple calls to KosArt_To_VDP without constant redefining
		jsr	(Add_To_DMA_Queue).l	; transfer *Transfer Length* of data from *Source Address* to *Destination Address*
		movea.l	a3,a1		; restore a1
		rts
; End of function KosArt_To_VDP


; =============== S U B R O U T I N E =======================================


sub_B512:
		move.l	#$80008000,d0
		move.w	#$800-1,d1
		move.l	#vdpComm(VRAM_Plane_A_Name_Table,VRAM,WRITE),(VDP_control_port).l
		lea	(VDP_data_port).l,a6

.loop:
		move.l	d0,(a6)
		dbf	d1,.loop
		rts
; End of function sub_B512


; =============== S U B R O U T I N E =======================================


sub_B534:
		moveq	#8-1,d2
		lea	(VDP_data_port).l,a6
		moveq	#0,d1

.loop:
		move.w	d0,d3
		bsr.s	sub_B550
		addi.w	#$80,d0
		andi.w	#$DFFF,d0
		dbf	d2,.loop
		rts
; End of function sub_B534


; =============== S U B R O U T I N E =======================================


sub_B550:
		swap	d3
		clr.w	d3
		swap	d3
		lsl.l	#2,d3
		lsr.w	#2,d3
		ori.w	#$4000,d3
		swap	d3
		move.l	d3,VDP_control_port-VDP_data_port(a6)
		move.l	d1,(a6)
		move.l	d1,(a6)
		move.l	d1,(a6)
		move.l	d1,(a6)
		move.w	d1,(a6)
		rts
; End of function sub_B550


; =============== S U B R O U T I N E =======================================


Copy_Listed_Data_To_VRAM:
		move.w	(a0)+,d7

.loop:
		movea.l	(a0)+,a1
		move.w	(a0)+,d0
		swap	d0
		clr.w	d0
		swap	d0
		lsl.l	#2,d0
		lsr.w	#2,d0
		ori.w	#$4000,d0
		swap	d0
		move.w	(a0)+,d1
		move.w	(a0)+,d2
		jsr	(Plane_Map_To_VRAM).l
		dbf	d7,.loop
		rts
; End of function Copy_Listed_Data_To_VRAM


; =============== S U B R O U T I N E =======================================


sub_B596:
		lea	(Dynamic_object_RAM).w,a0
		bsr.s	sub_B5A0
		lea	(Dynamic_object_RAM+(object_size*5)).w,a0
; End of function sub_B596


; =============== S U B R O U T I N E =======================================


sub_B5A0:
		lea	next_object(a0),a1
		lea	next_object(a1),a2
		bsr.s	sub_B5D2
		bsr.s	sub_B5D2
		move.w	#$80,priority(a0)
		move.w	#$100,priority(a1)
		move.w	#$180,priority(a2)
		bset	#7,art_tile(a0)
		bclr	#7,art_tile(a1)
		bclr	#7,art_tile(a2)
		rts
; End of function sub_B5A0


; =============== S U B R O U T I N E =======================================


sub_B5D2:
		move.w	y_pos(a0),d0
		cmp.w	y_pos(a1),d0
		bgt.s	loc_B5DE
		exg	a0,a1

loc_B5DE:
		move.w	y_pos(a1),d0
		cmp.w	y_pos(a2),d0
		bgt.s	locret_B5EA
		exg	a1,a2

locret_B5EA:
		rts
; End of function sub_B5D2


; =============== S U B R O U T I N E =======================================


sub_B5EC:
		move.w	#1,(Competition_mode).w
		bra.s	loc_B5F8
; ---------------------------------------------------------------------------

Set_Lives_and_Continues:
		clr.w	(Competition_mode).w

loc_B5F8:
		move.b	#3,(Life_count).w
		move.b	#3,(Life_count_P2).w
		moveq	#0,d0
		move.b	d0,(Last_star_post_hit).w
		move.b	d0,(Special_bonus_entry_flag).w
		move.w	d0,(Ring_count).w
		move.l	d0,(Timer).w
		move.l	d0,(Score).w
		move.w	d0,(Ring_count_P2).w
		move.l	d0,(Timer_P2).w
		move.l	d0,(Score_P2).w
		move.b	d0,(Continue_count).w
		move.l	#5000,(Next_extra_life_score).w
		move.l	#5000,(Next_extra_life_score_P2).w
		rts
; End of function sub_B5EC


; =============== S U B R O U T I N E =======================================


SRAM_Load:
		move.b	#1,(SRAM_access_flag).l
		lea	($200011).l,a0
		lea	($2000BD).l,a1
		lea	(Competition_saved_data).w,a2
		moveq	#$29,d0
		move.w	#$4C44,d1		; RAM integrity value
		jsr	Get_From_SRAM(pc)
		beq.s	loc_B674		; If the data read was successful, branch
		lea	SaveData_GeneralDefault(pc),a0
		lea	(Competition_saved_data).w,a1
		moveq	#$29-1,d0

loc_B66A:
		move.w	(a0)+,(a1)+		; Reset the general save data to the default
		dbf	d0,loc_B66A
		jsr	Write_SaveGeneral(pc)	; Write default data back to SRAM

loc_B674:
		lea	($200169).l,a0
		lea	($2001F5).l,a1
		lea	(Saved_data).w,a2
		moveq	#$19,d0
		move.w	#$4244,d1		; RAM integrity value for save game data
		jsr	Get_From_SRAM(pc)
		beq.s	loc_B6A4		; If the data read was not successful, branch
		lea	SaveData_GameDefault(pc),a0
		lea	(Saved_data).w,a1
		moveq	#bytesToWcnt((8*6)+2),d0

loc_B69A:
		move.w	(a0)+,(a1)+
		dbf	d0,loc_B69A
		jsr	Write_SaveGame(pc)

loc_B6A4:
		clr.w	(Dataselect_nosave_player).w
		move.b	#1,(Dataselect_entry).w
		rts
; End of function SRAM_Load

; ---------------------------------------------------------------------------
SaveData_GeneralDefault:
		dc.w  $8000,     0, $8000,     0, $8000,     0,     1,  $200
		dc.w  $8000,     0, $8000,     0, $8000,     0,     1,  $200
		dc.w  $8000,     0, $8000,     0, $8000,     0,     1,  $200
		dc.w  $8000,     0, $8000,     0, $8000,     0,     1,  $200
		dc.w  $8000,     0, $8000,     0, $8000,     0,     1,  $200
		dc.w  $4C44
SaveData_GameDefault:
		dc.w  $8000,     0,     0,     0
		dc.w  $8000,     0,     0,     0
		dc.w  $8000,     0,     0,     0
		dc.w  $8000,     0,     0,     0
		dc.w  $8000,     0,     0,     0
		dc.w  $8000,     0,     0,     0
		dc.w  $4244

; =============== S U B R O U T I N E =======================================


Get_From_SRAM:
		movea.l	a2,a3
		move.w	d0,d2
		bsr.s	Read_SRAM
		beq.s	.end
		movea.l	a1,a0
		movea.l	a3,a2
		move.w	d2,d0
		bsr.s	Read_SRAM

.end:
		rts
; End of function Get_From_SRAM


; =============== S U B R O U T I N E =======================================


Read_SRAM:
		movea.l	a2,a6
		move.w	d0,d6

loc_B74A:
		movep.w	0(a0),d3
		move.w	d3,(a2)+		; Read data from SRAM
		addq.w	#4,a0
		dbf	d0,loc_B74A
		subq.w	#1,d6
		bsr.s	Create_SRAMChecksum	; Get the checksum of the given data
		cmp.w	(a6),d7		; Compare the result
		bne.s	locret_B762
		cmp.w	-2(a6),d1	; Also compare the data before with the data given in d1

locret_B762:
		rts
; End of function Read_SRAM


; =============== S U B R O U T I N E =======================================


Create_SRAMChecksum:
		moveq	#0,d7

.loop:
		move.w	(a6)+,d5
		eor.w	d5,d7
		lsr.w	#1,d7
		bcc.s	.skip
		eori.w	#$8810,d7

.skip:
		dbf	d6,.loop
		rts
; End of function Create_SRAMChecksum


; =============== S U B R O U T I N E =======================================


Write_SRAM:
		movea.l	a2,a6
		move.w	d0,d6
		subq.w	#1,d6
		bsr.s	Create_SRAMChecksum
		move.w	d7,(a6)
		movea.l	a2,a3
		move.w	d0,d1

loc_B786:
		move.w	(a2)+,d2
		movep.w	d2,0(a0)	; Copy data to SRAM
		addq.w	#4,a0
		dbf	d0,loc_B786

loc_B792:
		move.w	(a3)+,d2
		movep.w	d2,0(a1)	; Copy data to backup SRAM
		addq.w	#4,a1
		dbf	d1,loc_B792
		rts
; End of function Write_SRAM


; =============== S U B R O U T I N E =======================================


Write_SaveGeneral:
		move.l	a0,-(sp)
		move.w	d7,-(sp)
		lea	($200011).l,a0		; Save general SRAM
		lea	($2000BD).l,a1		; Save general Backup SRAM
		lea	(Competition_saved_data).w,a2	; Save general RAM
		moveq	#$2A-1,d0
		bsr.s	Write_SRAM
		move.w	(sp)+,d7
		movea.l	(sp)+,a0
		rts
; End of function Write_SaveGeneral


; =============== S U B R O U T I N E =======================================


Write_SaveGame:
		move.l	a0,-(sp)
		move.w	d7,-(sp)
		lea	($200169).l,a0		; Save game SRAM
		lea	($2001F5).l,a1		; Save game backup SRAM
		lea	(Saved_data).w,a2	; Save game RAM
		moveq	#$1A-1,d0
		bsr.s	Write_SRAM
		move.w	(sp)+,d7
		movea.l	(sp)+,a0
		rts
; End of function Write_SaveGame


; =============== S U B R O U T I N E =======================================


SaveGame:
		tst.b	(Apparent_act).w
		beq.s	locret_B80E
		move.l	(Save_pointer).w,d0
		beq.s	loc_B80A			; If not playing on a save file, get out
		movea.l	d0,a1
		cmpi.b	#6,3(a1)
		bhi.s	loc_B80A
		moveq	#0,d0
		move.b	(Apparent_zone).w,d0
		move.b	SaveGame_NextLevel(pc,d0.w),3(a1)
		clr.b	7(a1)
		clr.b	1(a1)
		jsr	Write_SaveGame(pc)

loc_B80A:
		clr.l	(Collected_special_ring_array).w	; Clear special stage ring collection RAM

locret_B80E:
		rts
; End of function SaveGame

; ---------------------------------------------------------------------------
SaveGame_NextLevel:
		dc.b    1,   2,   3,   5,   5,   6,   7
		even

; =============== S U B R O U T I N E =======================================


SaveGame_SpecialStage:
		move.l	(Save_pointer).w,d0
		beq.s	locret_B858
		movea.l	d0,a1				; Get address of save slot
		move.b	(Current_special_stage).w,4(a1)
		move.b	(Chaos_emerald_count+1).w,5(a1)
		lea	(Collected_emeralds_array).w,a2
		moveq	#0,d0
		moveq	#7-1,d1

loc_B834:
		tst.b	(a2)+
		beq.s	loc_B83C
		ori.w	#1,d0

loc_B83C:
		lsl.b	#1,d0
		dbf	d1,loc_B834
		move.b	d0,6(a1)		; Compress emerald collection RAM and put it into Save Game
		move.l	(Collected_special_ring_array).w,d0	; Special stage entry ring memory is copied as well
		move.b	d0,7(a1)
		lsr.l	#8,d0
		move.b	d0,1(a1)
		jmp	Write_SaveGame(pc)
; ---------------------------------------------------------------------------

locret_B858:
		rts
; End of function SaveGame_SpecialStage

; ---------------------------------------------------------------------------

locret_B85A:
		rts
; ---------------------------------------------------------------------------

SaveScreen:
		jsr	(Pal_FadeToBlack).l
		move	#$2700,sr
		move.w	(VDP_reg_1_command).w,d0
		andi.b	#$BF,d0
		move.w	d0,(VDP_control_port).l
		jsr	(Clear_DisplayData).l

		dmaFillVRAM 0,$D000,$1000

		lea	(VDP_control_port).l,a6
		move.w	#$8004,(a6)			; Command $8004 - Disable HInt, HV Counter
		move.w	#$8238,(a6)
		move.w	#$8338,(a6)
		move.w	#$8406,(a6)
		move.w	#$8700,(a6)			; Command $8700 - BG color is Pal 0 Color 0
		move.w	#$8B00,(a6)
		move.w	#$8C81,(a6)			; Command $8C81 - 40cell screen size, no interlacing, no s/h
		move.w	#$9003,(a6)
		move.w	#$9280,(a6)
		clearRAM	Sprite_table_input,$400
		clearRAM	Object_RAM,(Kos_decomp_buffer-Object_RAM)
		clr.w	(DMA_queue).w
		move.l	#DMA_queue,(DMA_queue_slot).w
		clr.w	(Level_frame_counter).w
		clr.w	(Events_bg+$10).w
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
		lea	(MapEni_SaveScreen_Layout).l,a0
		lea	(RAM_start).l,a1
		move.w	#make_art_tile(ArtTile_ArtKos_Save_Misc,0,1),d0
		jsr	(Eni_Decomp).l
		lea	word_BD16(pc),a0
		jsr	sub_BAE0(pc)
		move.l	#vdpComm(tiles_to_bytes($562),VRAM,WRITE),(VDP_control_port).l
		lea	(ArtNem_S22POptions).l,a0
		jsr	(Nem_Decomp).l
		lea	byte_C7BE(pc),a1
		move.w	#VRAM_Plane_A_Name_Table+$D06,d0
		jsr	sub_C794(pc)
		move.w	#VRAM_Plane_A_Name_Table+$DB8,d0
		jsr	sub_C794(pc)
		lea	(ArtKos_S3MenuBG).l,a0				; Decompress source
		lea	(RAM_start).l,a1				; Decompress destination/Transfer source
		movea.w	#tiles_to_bytes(ArtTile_ArtKos_S3MenuBG),a2	; Transfer destination
		jsr	(KosArt_To_VDP).l
		move.l	#locret_B85A,(_unkEF44_1).w
		move.b	#$1E,(V_int_routine).w
		jsr	(Wait_VSync).l
		lea	(ArtKos_SaveScreenMisc).l,a0			; Decompress source
		lea	(RAM_start).l,a1				; Decompress destination/Transfer source
		movea.w	#tiles_to_bytes(ArtTile_ArtKos_Save_Misc),a2	; Transfer destination
		jsr	KosArt_To_VDP(pc)
		move.b	#$1E,(V_int_routine).w
		jsr	(Wait_VSync).l
		lea	(Pal_SaveMenuBG).l,a0
		lea	(Target_palette).w,a1
		moveq	#bytesToLcnt($20),d0

loc_B9D4:
		move.l	(a0)+,(a1)+
		dbf	d0,loc_B9D4
		lea	Pal_Save_Chars(pc),a0
		moveq	#bytesToLcnt($40),d0

loc_B9E0:
		move.l	(a0)+,(a1)+
		dbf	d0,loc_B9E0
		lea	(Object_RAM).w,a0
		lea	ObjDat_SaveScreen(pc),a1
		move.w	(a1)+,d0

loc_B9F0:
		move.l	(a1)+,(a0)
		move.w	#make_art_tile(ArtTile_ArtKos_Save_Misc,0,1),art_tile(a0)
		move.l	#Map_SaveScreen,mappings(a0)
		move.w	(a1),x_pos(a0)
		move.w	(a1)+,objoff_12(a0)	; copy of object's x_pos
		move.w	(a1)+,y_pos(a0)
		move.b	(a1)+,mapping_frame(a0)
		move.b	(a1)+,objoff_2E(a0)	; used for save slot id
		move.b	#$40,render_flags(a0)	; sets multi-sprite flag
		lea	next_object(a0),a0
		dbf	d0,loc_B9F0
		jsr	(Init_SpriteTable).l
		jsr	(Process_Sprites).l
		jsr	(Render_Sprites).l
		lea	(Normal_palette_line_4).w,a0
		lea	(Target_palette_line_4).w,a1
		moveq	#8-1,d0

loc_BA3E:
		move.l	(a0),(a1)+
		clr.l	(a0)+
		dbf	d0,loc_BA3E
		lea	(ArtKos_SaveScreenS3Zone).l,a0
		lea	(RAM_start).l,a1
		jsr	(Kos_Decomp).l
		moveq	#signextendB(mus_DataSelect),d0
		jsr	(Play_Music).l
		move.l	#loc_BB0A,(_unkEF44_1).w
		move.b	#$1E,(V_int_routine).w
		jsr	(Wait_VSync).l
		move.w	(VDP_reg_1_command).w,d0
		ori.b	#$40,d0
		move.w	d0,(VDP_control_port).l
		jsr	(Pal_FadeFromBlack).l

SaveScreen_MainLoop:
		move.b	#$1E,(V_int_routine).w
		jsr	(Wait_VSync).l
		addq.w	#1,(Level_frame_counter).w
		jsr	(Process_Sprites).l
		move.w	(Camera_X_pos_copy).w,d0
		neg.w	d0
		move.w	d0,(H_scroll_buffer+2).w
		jsr	(Render_Sprites).l
		lea	(Normal_palette_line_3+$2).w,a0
		moveq	#$E,d0
		btst	#0,(Level_frame_counter+1).w
		beq.s	loc_BAC8
		lea	Pal_Save_Emeralds(pc),a1

loc_BAC0:
		move.w	(a1)+,(a0)+
		dbf	d0,loc_BAC0
		bra.s	loc_BAD0
; ---------------------------------------------------------------------------

loc_BAC8:
		move.w	#$CCC,(a0)+
		dbf	d0,loc_BAC8

loc_BAD0:
		cmpi.b	#$4C,(Game_mode).w	; are we still in the savescreen mode?
		beq.s	SaveScreen_MainLoop	; if so, loop
		moveq	#signextendB(sfx_EnterSS),d0
		jmp	(Play_SFX).l

; =============== S U B R O U T I N E =======================================


sub_BAE0:
		move.w	(a0)+,d7

.loop:
		movea.l	(a0)+,a1
		move.w	(a0)+,d0
		bsr.s	sub_BAF8
		move.w	(a0)+,d1
		move.w	(a0)+,d2
		jsr	(Plane_Map_To_VRAM_2).l
		dbf	d7,.loop
		rts
; End of function sub_BAE0


; =============== S U B R O U T I N E =======================================


sub_BAF8:
		swap	d0
		clr.w	d0
		swap	d0
		lsl.l	#2,d0
		lsr.w	#2,d0
		ori.w	#$4000,d0
		swap	d0
		rts
; End of function sub_BAF8

; ---------------------------------------------------------------------------
; selects whether to display the static screen, or new screen
; and is called during vblank
next_SaveSlot = 8

loc_BB0A:
		move.w	(Level_frame_counter).w,d0
		andi.w	#$C,d0
		lea	(MapPtrs_SaveScreenStatic).l,a2
		movea.l	(a2,d0.w),a2
		lea	(Saved_data).w,a0
		move.w	#VRAM_Plane_A_Name_Table+$31A,d7
		moveq	#6-1,d6

loc_BB26:
		lea	(MapUnc_SaveScreenNEW).l,a1
		tst.b	(a0)		; is a game in progress?
		bmi.s	loc_BB32
		movea.l	a2,a1

loc_BB32:
		move.w	d7,d0
		bsr.s	sub_BAF8
		moveq	#$A-1,d1
		moveq	#7-1,d2
		jsr	(Plane_Map_To_VRAM_2).l
		addi.w	#$1A,d7
		addq.w	#next_SaveSlot,a0
		dbf	d6,loc_BB26
		lea	(Saved_data).w,a0
		lea	(Dynamic_object_RAM+object_size).w,a3	; load the first save slot object
		move.w	#VRAM_Plane_A_Name_Table+$B20,d7
		moveq	#6-1,d3

loc_BB58:
		move.w	d7,d0
		subq.w	#2,d0
		jsr	sub_BAF8(pc)
		move.l	d0,VDP_control_port-VDP_data_port(a6)
		move.w	#make_art_tile($2B1,0,1),(a6)
		lea	byte_C7CD(pc),a1
		tst.b	(a0)
		bmi.s	loc_BB98
		lea	byte_C7D9(pc),a1
		cmpi.w	#6,objoff_36(a3)
		bhi.s	loc_BB98
		lea	byte_C7D3(pc),a1
		move.w	d7,d0
		subq.w	#2,d0
		jsr	sub_C794(pc)
		move.w	objoff_36(a3),d0
		move.b	byte_BBAE(pc,d0.w),d0
		addi.w	#make_art_tile($562,1,1),d0
		move.w	d0,(a6)
		bra.s	loc_BB9E
; ---------------------------------------------------------------------------

loc_BB98:
		move.w	d7,d0
		jsr	sub_C794(pc)

loc_BB9E:
		addi.w	#$1A,d7
		addq.w	#next_SaveSlot,a0
		lea	next_object(a3),a3
		dbf	d3,loc_BB58
		rts
; ---------------------------------------------------------------------------
byte_BBAE:
		dc.b 1
		dc.b 2
		dc.b 3
		dc.b 4
		dc.b 5
		dc.b 5
		dc.b 6
		dc.b 0
		even
Pal_Save_Chars:
		binclude "General/Save Menu/Palettes/Chars.bin"
		even
Pal_Save_Emeralds:
		binclude "General/Save Menu/Palettes/Emeralds.bin"
		even
Pal_Save_FinishCard1:
		binclude "General/Save Menu/Palettes/Finish Card 1.bin"
		even
Pal_Save_FinishCard2:
		binclude "General/Save Menu/Palettes/Finish Card 2.bin"
		even
Pal_Save_ZoneCard1:
		binclude "General/Save Menu/Palettes/Zone Card 1.bin"
		even
Pal_Save_ZoneCard2:
		binclude "General/Save Menu/Palettes/Zone Card 2.bin"
		even
Pal_Save_ZoneCard3:
		binclude "General/Save Menu/Palettes/Zone Card 3.bin"
		even
Pal_Save_ZoneCard4:
		binclude "General/Save Menu/Palettes/Zone Card 4.bin"
		even
Pal_Save_ZoneCard8:
		binclude "General/Save Menu/Palettes/Zone Card 8 S3.bin"
		even
Pal_Save_ZoneCard5:
		binclude "General/Save Menu/Palettes/Zone Card 5.bin"
		even
Pal_Save_ZoneCard6:
		binclude "General/Save Menu/Palettes/Zone Card 6.bin"
		even
word_BD16:
		dc.w 8-1
		dc.l RAM_start+$0222
		dc.w VRAM_Plane_A_Name_Table+$202, $B-1,  $C-1
		dc.l RAM_start+$0000
		dc.w VRAM_Plane_A_Name_Table+$218, $D-1, $15-1
		dc.l RAM_start+$0000
		dc.w VRAM_Plane_A_Name_Table+$232, $D-1, $15-1
		dc.l RAM_start+$0000
		dc.w VRAM_Plane_A_Name_Table+$24C, $D-1, $15-1
		dc.l RAM_start+$0000
		dc.w VRAM_Plane_A_Name_Table+$266, $D-1, $15-1
		dc.l RAM_start+$0000
		dc.w VRAM_Plane_A_Name_Table+$280, $D-1, $15-1
		dc.l RAM_start+$0000
		dc.w VRAM_Plane_A_Name_Table+$29A, $D-1, $15-1
		dc.l RAM_start+$0222
		dc.w VRAM_Plane_A_Name_Table+$2B4, $B-1,  $C-1
Map_SaveScreen:
		include "General/Save Menu/Map - Save Screen General S3.asm"
ObjDat_SaveScreen:
		dc.w $A-1
		dc.l Draw_Sprite				; "Data Select" Text
		dc.w   $120						; x_pos, objoff_12 (x_pos copy)
		dc.w   $14C						; y_pos
		dc.b    3						; mapping_frame
		dc.b    0						; unused
		dc.l Obj_SaveScreen_Selector	; Highlights the current selected slot
		dc.w   $120						; x_pos, objoff_12 (x_pos copy)
		dc.w    $E2						; y_pos
		dc.b    1						; mapping_frame
		dc.b    0						; unused
		dc.l Obj_SaveScreen_Delete_Save	; Delete Icon that erases a saved game
		dc.w   $378						; x_pos, objoff_12 (x_pos copy)
		dc.w    $E0						; y_pos
		dc.b   $D						; mapping_frame
		dc.b    0						; unused
		dc.l Obj_SaveScreen_NoSave_Slot	; Slot that starts a non-saving game
		dc.w    $B0						; x_pos, objoff_12 (x_pos copy)
		dc.w    $D0						; y_pos
		dc.b    0						; unused
		dc.b    0						; unused
		dc.l Obj_SaveScreen_Save_Slot	; Save Slot
		dc.w   $110						; x_pos, objoff_12 (x_pos copy)
		dc.w   $118						; y_pos
		dc.b    0						; unused
		dc.b    0						; Save Slot ID Number
		dc.l Obj_SaveScreen_Save_Slot	; Save Slot
		dc.w   $178						; x_pos, objoff_12 (x_pos copy)
		dc.w   $118						; y_pos
		dc.b    0						; unused
		dc.b    1						; Save Slot ID Number
		dc.l Obj_SaveScreen_Save_Slot	; Save Slot
		dc.w   $1E0						; x_pos, objoff_12 (x_pos copy)
		dc.w   $118						; y_pos
		dc.b    0						; unused
		dc.b    2						; Save Slot ID Number
		dc.l Obj_SaveScreen_Save_Slot	; Save Slot
		dc.w   $248						; x_pos, objoff_12 (x_pos copy)
		dc.w   $118						; y_pos
		dc.b    0						; unused
		dc.b    3						; Save Slot ID Number
		dc.l Obj_SaveScreen_Save_Slot	; Save Slot
		dc.w   $2B0						; x_pos, objoff_12 (x_pos copy)
		dc.w   $118						; y_pos
		dc.b    0						; unused
		dc.b    4						; Save Slot ID Number
		dc.l Obj_SaveScreen_Save_Slot	; Save Slot
		dc.w   $318						; x_pos, objoff_12 (x_pos copy)
		dc.w   $118						; y_pos
		dc.b    0						; unused
		dc.b    5						; Save Slot ID Number
; ---------------------------------------------------------------------------

Obj_SaveScreen_Selector:
		move.w	#$A8,d0
		moveq	#0,d1
		moveq	#0,d2
		move.b	(Dataselect_entry).w,d2
		subq.w	#1,d2
		bcs.s	loc_C098

loc_C078:
		moveq	#$D-1,d4

loc_C07A:
		addq.w	#8,d0
		cmpi.w	#$120,d0
		bls.s	loc_C090
		subq.w	#8,d0
		addq.w	#8,d1
		cmpi.w	#$1F0,d1
		bls.s	loc_C090
		subq.w	#8,d1
		addq.w	#8,d0

loc_C090:
		dbf	d4,loc_C07A
		dbf	d2,loc_C078

loc_C098:
		move.w	d0,$12(a0)
		move.w	d1,(Camera_X_pos_copy).w
		neg.w	d1
		move.w	d1,(H_scroll_buffer+2).w
		move.l	#loc_C0AC,(a0)

loc_C0AC:
		tst.w	(Events_bg+$12).w
		bne.s	loc_C0C4
		btst	#button_B,(Ctrl_1_pressed).w
		beq.s	loc_C0C4
		move.b	#4,(Game_mode).w
		bra.w	loc_C180
; ---------------------------------------------------------------------------

loc_C0C4:
		tst.w	(Events_bg+$10).w
		bne.w	loc_C180
		tst.w	$30(a0)
		bne.s	loc_C13C
		moveq	#0,d0
		btst	#button_left,(Ctrl_1_pressed).w
		beq.s	loc_C106
		tst.w	(Events_bg+$12).w
		beq.s	loc_C0EA
		cmpi.b	#1,(Dataselect_entry).w
		beq.s	loc_C106

loc_C0EA:
		tst.b	(Dataselect_entry).w
		beq.s	loc_C106
		subq.b	#1,(Dataselect_entry).w
		moveq	#signextendB(sfx_SlotMachine),d0
		tst.w	(Events_bg+$12).w
		beq.s	loc_C0FE
		moveq	#signextendB(sfx_SmallBumpers),d0

loc_C0FE:
		jsr	(Play_SFX).l
		moveq	#-8,d0

loc_C106:
		btst	#button_right,(Ctrl_1_pressed).w
		beq.s	loc_C12C
		cmpi.b	#7,(Dataselect_entry).w
		beq.s	loc_C12C
		addq.b	#1,(Dataselect_entry).w
		moveq	#signextendB(sfx_SlotMachine),d0
		tst.w	(Events_bg+$12).w
		beq.s	loc_C124
		moveq	#signextendB(sfx_SmallBumpers),d0

loc_C124:
		jsr	(Play_SFX).l
		moveq	#8,d0

loc_C12C:
		move.w	d0,$2E(a0)
		beq.s	loc_C13A
		move.w	#$D,$30(a0)
		bra.s	loc_C13C
; ---------------------------------------------------------------------------

loc_C13A:
		bra.s	loc_C180
; ---------------------------------------------------------------------------

loc_C13C:
		move.w	$12(a0),d0
		move.w	(Camera_X_pos_copy).w,d1
		move.w	$2E(a0),d2
		bmi.s	loc_C162
		add.w	d2,d0
		cmpi.w	#$120,d0
		bls.s	loc_C174
		sub.w	d2,d0
		add.w	d2,d1
		cmpi.w	#$1F0,d1
		bls.s	loc_C174
		sub.w	d2,d1
		add.w	d2,d0
		bra.s	loc_C174
; ---------------------------------------------------------------------------

loc_C162:
		add.w	d2,d0
		cmpi.w	#$120,d0
		bcc.s	loc_C174
		sub.w	d2,d0
		add.w	d2,d1
		bpl.s	loc_C174
		sub.w	d2,d1
		add.w	d2,d0

loc_C174:
		move.w	d0,$12(a0)
		move.w	d1,(Camera_X_pos_copy).w
		subq.w	#1,$30(a0)

loc_C180:
		moveq	#8,d2
		move.b	(Dataselect_entry).w,d1
		beq.s	loc_C192
		neg.w	d2
		cmpi.b	#7,d1
		beq.s	loc_C192
		moveq	#0,d2

loc_C192:
		add.w	$12(a0),d2
		move.w	d2,x_pos(a0)
		moveq	#2,d0
		cmpi.w	#$F0,d2
		bcs.s	loc_C1AA
		cmpi.w	#$148,d2
		bhi.s	loc_C1AA
		moveq	#1,d0

loc_C1AA:
		move.b	d0,mapping_frame(a0)
		btst	#2,(Level_frame_counter+1).w
		beq.s	locret_C1BC
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

locret_C1BC:
		rts
; ---------------------------------------------------------------------------

Obj_SaveScreen_NoSave_Slot:
		move.b	#$F,sub2_mapframe(a0)
		move.w	(Dataselect_nosave_player).w,d0
		addq.w	#4,d0
		move.b	d0,mapping_frame(a0)
		tst.b	(Dataselect_entry).w
		bne.s	loc_C244
		move.w	(Player_2+object_control).w,d0
		or.w	(Events_bg+$12).w,d0
		bne.s	loc_C244
		move.b	(Ctrl_1_pressed).w,d0
		andi.w	#button_A_mask|button_C_mask|button_start_mask,d0
		beq.s	loc_C224
		move.b	#$C,(Game_mode).w
		move.w	(Dataselect_nosave_player).w,(Player_option).w
		clr.w	(Current_zone_and_act).w
		clr.w	(Apparent_zone_and_act).w
		clr.w	(Current_special_stage).w
		clr.w	(Chaos_emerald_count).w
		clr.l	(Collected_emeralds_array).w
		clr.w	(Collected_emeralds_array+4).w
		clr.b	(Collected_emeralds_array+6).w
		clr.l	(Collected_special_ring_array).w
		clr.l	(Save_pointer).w
		jsr	(Set_Lives_and_Continues).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_C224:
		move.w	(Dataselect_nosave_player).w,d0
		jsr	sub_C4CC(pc)
		move.w	d0,(Dataselect_nosave_player).w
		addq.w	#4,d0
		move.b	d0,mapping_frame(a0)
		move.w	#1,mainspr_childsprites(a0)
		btst	#4,(Level_frame_counter+1).w
		bne.s	loc_C248

loc_C244:
		clr.w	mainspr_childsprites(a0)

loc_C248:
		bra.w	Set_ChildSprites
; ---------------------------------------------------------------------------

Obj_SaveScreen_Save_Slot:
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	loc_C25E
		move.l	#Obj_SaveScreen_Emeralds,(a1)
		move.w	a0,parent2(a1)

loc_C25E:
		moveq	#0,d0
		move.b	$2E(a0),d0
		lsl.w	#3,d0
		addi.l	#Saved_data,d0
		move.l	d0,$30(a0)
		movea.l	d0,a1
		move.b	2(a1),$35(a0)
		move.b	3(a1),$37(a0)
		move.l	#loc_C284,(a0)

loc_C284:
		clr.w	mainspr_childsprites(a0)
		movea.l	$30(a0),a1
		move.b	(Dataselect_entry).w,d0
		subq.b	#1,d0
		cmp.b	$2E(a0),d0
		beq.s	Load_Level_Icons
		move.b	3(a1),$37(a0)
		clr.w	$38(a0)

loc_C2A2:
		move.w	$34(a0),d0
		addq.w	#4,d0
		move.b	d0,mapping_frame(a0)
		bra.w	Set_ChildSprites
; ---------------------------------------------------------------------------

Load_Level_Icons:
		tst.b	(a1)
		bmi.w	loc_C40A
		move.w	$36(a0),d1
		jsr	Load_Icon_Art(pc)
		move.b	#$17,sub3_mapframe(a0)
		cmpi.w	#6,$36(a0)
		bls.s	loc_C2DC
		addq.b	#1,sub3_mapframe(a0)
		cmpi.b	#7,5(a1)
		bcs.s	loc_C2DC
		addq.b	#1,sub3_mapframe(a0)

loc_C2DC:
		tst.w	$38(a0)
		bne.s	loc_C2EE
		cmpi.w	#6,$36(a0)
		bls.s	loc_C360
		st	$38(a0)

loc_C2EE:
		tst.w	(Player_2+object_control).w
		bne.s	loc_C2A2
		tst.w	(Events_bg+$12).w
		beq.s	loc_C306
		clr.b	sub2_mapframe(a0)
		move.w	#2,mainspr_childsprites(a0)
		bra.s	loc_C2A2
; ---------------------------------------------------------------------------

loc_C306:
		moveq	#0,d2
		move.w	$36(a0),d1
		move.b	(Ctrl_1_pressed).w,d0
		btst	#1,d0
		beq.s	loc_C32A
		moveq	#signextendB(sfx_Switch),d2
		subq.w	#1,d1
		bpl.s	loc_C320
		moveq	#6,d1
		bra.s	loc_C344
; ---------------------------------------------------------------------------

loc_C320:
		cmpi.w	#4,d1
		bne.s	loc_C344
		subq.w	#1,d1
		bra.s	loc_C344
; ---------------------------------------------------------------------------

loc_C32A:
		btst	#0,d0
		beq.s	loc_C344
		moveq	#signextendB(sfx_Switch),d2
		addq.w	#1,d1
		cmpi.w	#4,d1
		bne.s	loc_C33C
		addq.w	#1,d1

loc_C33C:
		cmpi.w	#6,d1
		bls.s	loc_C344
		moveq	#0,d1

loc_C344:
		move.w	d1,$36(a0)
		move.l	d2,d0
		jsr	(Play_SFX).l
		move.b	#$1A,sub2_mapframe(a0)
		btst	#4,(Level_frame_counter+1).w
		beq.s	loc_C368
		bra.s	loc_C36C
; ---------------------------------------------------------------------------

loc_C360:
		tst.w	(Player_2+object_control).w
		bne.w	loc_C2A2

loc_C368:
		clr.b	sub2_mapframe(a0)

loc_C36C:
		move.w	#2,mainspr_childsprites(a0)
		tst.w	(Events_bg+$12).w
		bne.w	loc_C2A2
		move.b	(Ctrl_1_pressed).w,d0
		andi.w	#button_A_mask|button_C_mask|button_start_mask,d0
		beq.w	loc_C2A2
		move.b	#$C,(Game_mode).w
		clr.l	(Collected_special_ring_array).w
		cmpi.b	#6,3(a1)
		bls.s	loc_C3AE
		move.w	$36(a0),d0
		cmpi.b	#6,d0
		bls.s	loc_C3BE
		move.w	#$601,d0
		move.b	#$20,(Game_mode).w
		bra.s	loc_C3C0
; ---------------------------------------------------------------------------

loc_C3AE:
		move.b	1(a1),(Collected_special_ring_array+2).w
		move.b	7(a1),(Collected_special_ring_array+3).w
		move.b	3(a1),d0

loc_C3BE:
		lsl.w	#8,d0

loc_C3C0:
		move.w	d0,(Current_zone_and_act).w
		move.w	d0,(Apparent_zone_and_act).w
		moveq	#0,d0
		move.b	2(a1),d0
		move.w	d0,(Player_option).w
		move.b	4(a1),(Current_special_stage).w
		moveq	#0,d0
		move.b	5(a1),d0
		move.w	d0,(Chaos_emerald_count).w
		move.b	6(a1),d0
		lea	(Collected_emeralds_array).w,a3
		moveq	#6,d1

loc_C3EC:
		moveq	#0,d2
		lsl.b	#1,d0
		bcc.s	loc_C3F4
		moveq	#1,d2

loc_C3F4:
		move.b	d2,(a3)+
		dbf	d1,loc_C3EC
		move.l	a1,(Save_pointer).w
		jsr	(Set_Lives_and_Continues).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_C40A:
		move.b	#$F,sub2_mapframe(a0)
		clr.b	sub3_mapframe(a0)
		move.w	(Player_2+object_control).w,d0
		or.w	(Events_bg+$12).w,d0
		bne.w	loc_C2A2
		move.b	(Ctrl_1_pressed).w,d0
		andi.w	#button_A_mask|button_C_mask|button_start_mask,d0
		beq.s	loc_C476
		move.b	#$C,(Game_mode).w
		clr.l	(a1)
		clr.l	4(a1)
		move.w	$34(a0),d0
		move.b	d0,2(a1)
		move.w	d0,(Player_option).w
		clr.w	(Current_zone_and_act).w
		clr.w	(Apparent_zone_and_act).w
		clr.w	(Current_special_stage).w
		clr.w	(Chaos_emerald_count).w
		clr.l	(Collected_emeralds_array).w
		clr.w	(Collected_emeralds_array+4).w
		clr.b	(Collected_emeralds_array+6).w
		clr.l	(Collected_special_ring_array).w
		move.l	a1,(Save_pointer).w
		jsr	(Set_Lives_and_Continues).l
		jsr	Write_SaveGame(pc)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_C476:
		move.w	$34(a0),d0
		jsr	sub_C4CC(pc)
		move.w	d0,$34(a0)
		addq.w	#4,d0
		move.b	d0,mapping_frame(a0)
		move.w	#1,mainspr_childsprites(a0)
		btst	#4,(Level_frame_counter+1).w
		bne.s	Set_ChildSprites
		clr.w	mainspr_childsprites(a0)

Set_ChildSprites:
		move.w	$12(a0),d0
		sub.w	(Camera_X_pos_copy).w,d0
		move.w	d0,x_pos(a0)
		move.w	y_pos(a0),d1
		move.w	d0,sub2_x_pos(a0)
		move.w	d1,sub2_y_pos(a0)
		move.w	d0,sub3_x_pos(a0)
		move.w	d1,sub3_y_pos(a0)
		cmpi.b	#$1A,sub2_mapframe(a0)
		bne.s	loc_C4C6
		subq.w	#8,sub2_y_pos(a0)

loc_C4C6:
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_C4CC:
		moveq	#0,d2
		tst.w	(Player_2+objoff_30).w
		bne.s	loc_C4F6
		move.b	(Ctrl_1_pressed).w,d1
		lsr.w	#1,d1
		bcc.s	loc_C4EA
		moveq	#signextendB(sfx_Switch),d2
		addq.w	#1,d0
		cmpi.w	#2,d0
		bls.s	loc_C4F6
		moveq	#0,d0
		bra.s	loc_C4F6
; ---------------------------------------------------------------------------

loc_C4EA:
		lsr.w	#1,d1
		bcc.s	loc_C4F6
		moveq	#signextendB(sfx_Switch),d2
		subq.w	#1,d0
		bpl.s	loc_C4F6
		moveq	#2,d0

loc_C4F6:
		tst.w	d2
		beq.s	locret_C506
		move.l	d0,-(sp)
		move.l	d2,d0
		jsr	(Play_SFX).l
		move.l	(sp)+,d0

locret_C506:
		rts
; End of function sub_C4CC

; ---------------------------------------------------------------------------

Obj_SaveScreen_Emeralds:
		move.b	#$40,render_flags(a0)
		move.w	#make_art_tile(ArtTile_ArtKos_Save_Misc,0,1),art_tile(a0)
		move.l	#Map_SaveScreen,mappings(a0)
		move.b	#$40,width_pixels(a0)
		move.w	#7,mainspr_childsprites(a0)
		movea.w	parent2(a0),a1
		movea.l	$30(a1),a2
		move.b	6(a2),d4
		move.w	x_pos(a1),d0
		move.w	y_pos(a1),d1
		move.w	d0,x_pos(a0)
		move.w	d1,y_pos(a0)
		lea	sub2_x_pos(a0),a1
		moveq	#$10,d2
		moveq	#7-1,d3

loc_C54C:
		clr.b	5(a1)
		lsl.b	#1,d4
		bcc.s	loc_C55E
		move.w	d0,(a1)
		move.w	d1,sub2_y_pos-sub2_x_pos(a1)
		move.b	d2,sub2_mapframe-sub2_x_pos(a1)

loc_C55E:
		addq.w	#1,d2
		addq.w	#6,a1
		dbf	d3,loc_C54C
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_SaveScreen_Delete_Save:
		moveq	#0,d0
		move.b	routine(a0),d0
		jmp	SaveScreen_Delete_Save_Index(pc,d0.w)
; ---------------------------------------------------------------------------

SaveScreen_Delete_Save_Index:
		bra.w	loc_C58E
; ---------------------------------------------------------------------------
		bra.w	loc_C5AA
; ---------------------------------------------------------------------------
		bra.w	loc_C5D4
; ---------------------------------------------------------------------------
		bra.w	loc_C66C
; ---------------------------------------------------------------------------
		bra.w	loc_C68C
; ---------------------------------------------------------------------------
		bra.w	loc_C6AC
; ---------------------------------------------------------------------------

loc_C58E:
		move.b	#$40,render_flags(a0)
		move.b	#$30,width_pixels(a0)
		move.w	#1,mainspr_childsprites(a0)
		move.b	#8,sub2_mapframe(a0)
		addq.b	#4,routine(a0)

loc_C5AA:
		cmpi.b	#7,(Dataselect_entry).w
		bne.w	loc_C688
		move.b	(Ctrl_1_pressed).w,d0
		andi.w	#button_A_mask|button_C_mask|button_start_mask,d0
		beq.w	loc_C688
		moveq	#signextendB(sfx_Starpost),d0
		jsr	(Play_SFX).l
		st	(Events_bg+$12).w
		addq.b	#4,routine(a0)
		bra.w	loc_C688
; ---------------------------------------------------------------------------

loc_C5D4:
		jsr	sub_C6EE(pc)
		jsr	sub_C726(pc)
		tst.w	(Player_2+object_control).w
		bne.s	loc_C624
		move.b	(Ctrl_1_pressed).w,d0
		btst	#button_B,d0
		bne.s	loc_C63C
		andi.w	#button_A_mask|button_C_mask|button_start_mask,d0
		beq.s	loc_C624
		cmpi.b	#7,(Dataselect_entry).w
		beq.s	loc_C63C
		moveq	#0,d0
		move.b	(Dataselect_entry).w,d0
		subq.w	#1,d0
		lsl.w	#3,d0
		addi.l	#Saved_data,d0
		move.l	d0,$2E(a0)
		movea.l	d0,a1
		tst.b	(a1)
		bmi.s	loc_C63C
		moveq	#signextendB(sfx_Starpost),d0
		jsr	(Play_SFX).l
		st	(Events_bg+$10).w
		addq.b	#8,routine(a0)

loc_C624:
		move.w	(Player_2+x_pos).w,d0
		move.w	d0,x_pos(a0)
		move.w	d0,sub2_x_pos(a0)
		move.w	y_pos(a0),sub2_y_pos(a0)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_C63C:
		clr.b	$24(a0)
		clr.b	$23(a0)
		clr.b	$25(a0)
		clr.b	$28(a0)
		move.b	#$D,mapping_frame(a0)
		move.b	#8,sub2_mapframe(a0)
		move.w	(Player_2+x_pos).w,d0
		add.w	(Camera_X_pos_copy).w,d0
		move.w	d0,$12(a0)
		addq.b	#4,routine(a0)
		bra.w	Set_ChildSprites
; ---------------------------------------------------------------------------

loc_C66C:
		clr.w	(Events_bg+$12).w
		move.w	$12(a0),d0
		cmpi.w	#$378,d0
		blo.s	loc_C682
		move.b	#4,routine(a0)
		bra.s	loc_C688
; ---------------------------------------------------------------------------

loc_C682:
		addq.w	#8,d0
		move.w	d0,$12(a0)

loc_C688:
		bra.w	Set_ChildSprites
; ---------------------------------------------------------------------------

loc_C68C:
		jsr	sub_C6EE(pc)
		jsr	sub_C726(pc)
		cmpi.b	#$B,sub2_mapframe(a0)
		bne.s	loc_C6A6
		move.b	#$C,sub2_mapframe(a0)
		addq.b	#4,routine(a0)

loc_C6A6:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_C6AC:
		jsr	sub_C6EE(pc)
		btst	#button_right,(Ctrl_1_pressed).w
		bne.s	loc_C6DA
		btst	#button_left,(Ctrl_1_pressed).w
		beq.s	loc_C6E8
		moveq	#signextendB(sfx_Perfect),d0
		jsr	(Play_SFX).l
		movea.l	$2E(a0),a1
		clr.l	(a1)
		clr.l	4(a1)
		bset	#7,(a1)
		jsr	Write_SaveGame(pc)

loc_C6DA:
		move.b	#8,routine(a0)
		clr.w	(Events_bg+$10).w
		bra.w	loc_C63C
; ---------------------------------------------------------------------------

loc_C6E8:
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_C6EE:
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	locret_C714
		move.b	#5,anim_frame_timer(a0)

loc_C6FA:
		moveq	#0,d0
		move.b	anim_frame(a0),d0
		addq.b	#1,anim_frame(a0)
		move.b	byte_C716(pc,d0.w),d0
		bpl.s	loc_C710
		clr.b	anim_frame(a0)
		bra.s	loc_C6FA
; ---------------------------------------------------------------------------

loc_C710:
		move.b	d0,mapping_frame(a0)

locret_C714:
		rts
; End of function sub_C6EE

; ---------------------------------------------------------------------------
byte_C716:
		dc.b   $D,  $E,  $D,  $E,  $D,  $E,  $D,  $E,  $D,  $E,  $D,  $D,  $D,  $D, $FF
		even

; =============== S U B R O U T I N E =======================================


sub_C726:
		subq.b	#1,$25(a0)
		bpl.s	locret_C744
		move.b	#3,$25(a0)
		addq.b	#1,$28(a0)
		move.b	$28(a0),d0
		andi.b	#3,d0
		addq.b	#8,d0
		move.b	d0,sub2_mapframe(a0)

locret_C744:
		rts
; End of function sub_C726


; =============== S U B R O U T I N E =======================================


Load_Icon_Art:
		cmpi.b	#6,d1
		bhi.s	loc_C772
		move.l	a1,-(sp)
		move.w	d1,-(sp)
		mulu.w	#$8C0,d1
		addi.l	#RAM_start,d1
		move.w	#tiles_to_bytes($5BA),d2
		move.w	#$460,d3
		jsr	(Add_To_DMA_Queue).l
		move.w	(sp)+,d0
		movea.l	(sp)+,a1
		lea	Pal_Save_ZoneCard1(pc),a2
		bra.s	loc_C782
; ---------------------------------------------------------------------------

loc_C772:
		lea	Pal_Save_FinishCard1(pc),a2
		moveq	#0,d0
		cmpi.b	#7,5(a1)
		bcs.s	loc_C782
		moveq	#1,d0

loc_C782:
		lsl.w	#5,d0
		adda.w	d0,a2
		lea	(Normal_palette_line_4).w,a3
		moveq	#bytesToLcnt($20),d0

loc_C78C:
		move.l	(a2)+,(a3)+
		dbf	d0,loc_C78C
		rts
; End of function Load_Icon_Art


; =============== S U B R O U T I N E =======================================


sub_C794:
		lea	(VDP_data_port).l,a6
		jsr	sub_BAF8(pc)
		move.l	d0,VDP_control_port-VDP_data_port(a6)
		move.w	#make_art_tile($552,1,1),d5
		moveq	#0,d6

loc_C7A8:
		move.b	(a1)+,d6
		bne.s	loc_C7B2
		move.w	#$8000,(a6)
		bra.s	loc_C7A8
; ---------------------------------------------------------------------------

loc_C7B2:
		bmi.s	locret_C7BC
		move.w	d5,d4
		add.w	d6,d4
		move.w	d4,(a6)
		bra.s	loc_C7A8
; ---------------------------------------------------------------------------

locret_C7BC:
		rts
; End of function sub_C794

; ---------------------------------------------------------------------------
byte_C7BE:
		dc.b  $2B, $2C,   0, $30, $1E, $33, $22, $FF, $21, $22, $29, $22, $31, $22, $FF
byte_C7CD:
		dc.b    0,   0,   0,   0,   0, $FF
byte_C7D3:
		dc.b  $37, $2C, $2B, $22,   0, $FF
byte_C7D9:
		dc.b  $20, $29, $22, $1E, $2F, $FF
		even
ArtKos_SaveScreenS3Zone:
		binclude "General/Save Menu/Kosinski Art/Zone Art.bin"
		even

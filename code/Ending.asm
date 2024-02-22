Obj_5D86A:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_5D89C(pc,d0.w),d1
		jsr	off_5D89C(pc,d1.w)
		cmpi.w	#2,(Player_mode).w
		bne.s	loc_5D886
		move.b	#$7F,(Palette_timer).w

loc_5D886:
		lea	(Player_1).w,a1
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
off_5D89C:
		dc.w loc_5D8BC-off_5D89C
		dc.w loc_5D9EE-off_5D89C
		dc.w loc_5DA50-off_5D89C
		dc.w loc_5DA74-off_5D89C
		dc.w loc_5DB2C-off_5D89C
		dc.w loc_5DB60-off_5D89C
		dc.w loc_5DB76-off_5D89C
		dc.w loc_5DBBE-off_5D89C
		dc.w loc_5DBDC-off_5D89C
		dc.w loc_5DBF6-off_5D89C
		dc.w loc_5DC2C-off_5D89C
		dc.w loc_5DC98-off_5D89C
		dc.w loc_5DCA6-off_5D89C
		dc.w loc_5DD34-off_5D89C
		dc.w loc_5DD6A-off_5D89C
		dc.w loc_5DE1A-off_5D89C
; ---------------------------------------------------------------------------

loc_5D8BC:
		lea	ObjDat3_600DA(pc),a1
		jsr	(SetUp_ObjAttributes).l
		bclr	#2,render_flags(a0)
		move.b	#2,routine(a0)
		bsr.w	sub_5FE82
		st	(Scroll_lock).w
		clr.b	(_unkFAB8).w
		lea	(Player_1).w,a1
		bclr	#2,render_flags(a1)
		bset	#7,art_tile(a1)
		move.b	#$81,object_control(a1)
		move.b	#$F,anim(a1)
		clr.b	status(a1)
		move.w	#$800,ground_vel(a1)
		clr.l	(Player_2).w
		cmpi.w	#2,(Player_mode).w
		move.w	#$7FFF,(Super_frame_count).w
		move.b	#1,(Update_HUD_timer).w
		tst.b	(_unkFA88).w
		bmi.w	loc_5D96A
		bne.s	loc_5D944
		cmpi.w	#2,(Player_mode).w
		bhs.w	loc_5D96A
		bsr.w	sub_5FC8E
		jsr	(AllocateObject).l
		bne.s	loc_5D940
		move.l	#Obj_Ending_RevertSuperSonic,(a1)

loc_5D940:
		bra.w	loc_5D95C
; ---------------------------------------------------------------------------

loc_5D944:
		clr.b	(Player_1+anim).w
		cmpi.w	#2,(Player_mode).w
		bne.s	loc_5D958
		bsr.w	sub_5FCB4
		bra.w	loc_5D96A
; ---------------------------------------------------------------------------

loc_5D958:
		bsr.w	sub_5FCCE

loc_5D95C:
		move.l	#$EEE0EEE,d0
		move.l	d0,(Normal_palette+$4).w
		move.w	d0,(Normal_palette+$8).w

loc_5D96A:
		move.w	#$100,x_pos(a0)
		move.w	#$E0,y_pos(a0)
		lea	(Dynamic_object_RAM+(object_size*5)).w,a1
		move.w	a1,$44(a0)
		move.l	#Obj_5EA52,(a1)
		st	$2C(a1)
		bset	#2,$38(a1)
		move.w	a0,$46(a1)
		lea	(Dynamic_object_RAM+(object_size*45)).w,a1
		move.l	#Obj_5DE60,(a1)
		move.w	a0,$46(a1)
		move.w	#$11E,x_pos(a1)
		move.w	#$CF,y_pos(a1)
		lea	(Pal_SSZ2+$20).l,a1
		lea	(Target_palette_line_3).w,a2
		moveq	#bytesToLcnt($20),d6

loc_5D9B8:
		move.l	(a1)+,(a2)+
		dbf	d6,loc_5D9B8
		lea	(ArtKosM_EndingMasterEmerald).l,a1
		move.w	#tiles_to_bytes($52E),d2
		jsr	(Queue_Kos_Module).l
		lea	(ArtKosM_SonicPlane).l,a1
		move.w	#tiles_to_bytes($1E3),d2
		jsr	(Queue_Kos_Module).l
		lea	(ArtKosM_SonicPlaneEnding).l,a1
		move.w	#tiles_to_bytes($26E),d2
		jmp	(Queue_Kos_Module).l
; ---------------------------------------------------------------------------

loc_5D9EE:
		cmpi.w	#$EEE,(Normal_palette+$2).w
		bne.s	loc_5DA12
		bset	#7,$38(a0)
		bne.s	loc_5DA12
		move.b	#1,(_unkFAC1).w
		jsr	(AllocateObject).l
		bne.s	loc_5DA12
		move.l	#loc_5DF58,(a1)

loc_5DA12:
		move.l	(_unkEE9C).w,d0
		addi.l	#$8000,d0
		move.l	d0,(_unkEE9C).w
		cmpi.l	#$800000,d0
		blo.s	locret_5DA4E
		move.b	#4,routine(a0)
		jsr	(AllocateObject).l
		bne.s	loc_5DA3C
		move.l	#loc_5F94C,(a1)

loc_5DA3C:
		move.b	#$1F,(_unkFAB9).w
		move.w	#-$100,(_unkFAC2).w
		move.w	#-$100,(_unkFAC4).w

locret_5DA4E:
		rts
; ---------------------------------------------------------------------------

loc_5DA50:
		move.l	(_unkEE9C).w,d0
		addi.l	#$8000,d0
		move.l	d0,(_unkEE9C).w
		cmpi.l	#$1000000,d0
		blo.s	locret_5DA72
		move.b	#6,routine(a0)
		bset	#3,$38(a0)

locret_5DA72:
		rts
; ---------------------------------------------------------------------------

loc_5DA74:
		movea.w	$44(a0),a1
		move.w	x_pos(a1),d0
		addi.w	#$20,d0
		cmp.w	x_pos(a0),d0
		bgt.s	loc_5DA96
		move.l	(_unkEE9C).w,d0
		addi.l	#$8000,d0
		move.l	d0,(_unkEE9C).w
		rts
; ---------------------------------------------------------------------------

loc_5DA96:
		move.b	#8,routine(a0)
		bset	#0,(_unkFAB8).w
		move.w	#$20,$2E(a0)
		moveq	#-$20,d0
		move.b	d0,$42(a1)
		move.w	x_pos(a1),d1
		neg.w	d0
		add.w	d0,d1
		move.w	d1,x_pos(a0)
		moveq	#$2B,d0
		cmpi.w	#2,(Player_mode).w
		bne.s	loc_5DACC
		subq.b	#4,d0
		bclr	#2,(Tails_tails+render_flags).w

loc_5DACC:
		move.b	d0,$43(a1)
		move.w	y_pos(a1),d1
		neg.w	d0
		add.w	d0,d1
		move.w	d1,y_pos(a0)
		move.w	d1,$3A(a0)
		lea	(Player_1).w,a1
		tst.b	(_unkFA88).w
		bmi.s	loc_5DB1C
		beq.s	loc_5DB1C
		move.b	#2,(Super_palette_status).w
		move.w	#$1E,(Palette_frame).w
		move.b	#0,(Super_Sonic_Knux_flag).w
		move.b	#0,(Super_Tails_flag).w
		move.l	#Map_Sonic,mappings(a1)
		cmpi.w	#2,(Player_mode).w
		bne.s	loc_5DB1C
		move.l	#Map_Tails,mappings(a1)

loc_5DB1C:
		move.b	#5,anim(a1)
		move.b	#$83,$2E(a1)
		bsr.w	sub_5FD88

loc_5DB2C:
		subq.w	#1,$2E(a0)
		bne.s	loc_5DB38
		bset	#1,(_unkFAB8).w

loc_5DB38:
		addq.w	#2,x_pos(a0)
		cmpi.w	#$160,x_pos(a0)
		blo.s	loc_5DB5C
		move.b	#$A,routine(a0)
		tst.b	(_unkFA88).w
		bpl.s	loc_5DB5C
		move.b	#$C,routine(a0)
		move.w	#(5*60)-1,$2E(a0)

loc_5DB5C:
		bra.w	sub_60000
; ---------------------------------------------------------------------------

loc_5DB60:
		tst.w	(_unkFAA4).w
		bne.s	loc_5DB6A
		bra.w	sub_60000
; ---------------------------------------------------------------------------

loc_5DB6A:
		move.b	#$C,routine(a0)
		move.w	#(5*60)-1,$2E(a0)

loc_5DB76:
		subq.w	#1,$2E(a0)
		bpl.s	loc_5DBB2
		move.b	#$E,routine(a0)
		move.w	#-$100,(_unkFAC4).w
		clr.b	(_unkFAB9).w
		move.w	#$BF,$2E(a0)
		st	(Events_fg_5).w
		lea	word_5DBB6(pc),a2
		moveq	#$42,d1
		moveq	#2-1,d2
		bsr.w	Create_Continue_Sprite
		lea	(ArtKosM_IslandLiftGfx).l,a1
		move.w	#tiles_to_bytes($2FF),d2
		jsr	(Queue_Kos_Module).l

loc_5DBB2:
		bra.w	sub_60000
; ---------------------------------------------------------------------------
word_5DBB6:
		dc.w   $69C,  $384
		dc.w   $6DC,  $384
; ---------------------------------------------------------------------------

loc_5DBBE:
		addq.w	#2,(_unkEE98).w
		addq.w	#1,(_unkEE9C).w
		subq.w	#1,$2E(a0)
		bpl.s	loc_5DBD8
		move.b	#$10,routine(a0)
		move.w	#(5*60)-1,$2E(a0)

loc_5DBD8:
		bra.w	sub_60000
; ---------------------------------------------------------------------------

loc_5DBDC:
		addq.w	#2,(_unkEE98).w
		subq.w	#1,$2E(a0)
		bpl.s	loc_5DBF2
		move.b	#$12,routine(a0)
		move.w	#$8F,$2E(a0)

loc_5DBF2:
		bra.w	sub_60000
; ---------------------------------------------------------------------------

loc_5DBF6:
		cmpi.w	#$60,x_pos(a0)
		bls.s	loc_5DC02
		subq.w	#2,x_pos(a0)

loc_5DC02:
		addq.w	#2,(_unkEE98).w
		bsr.w	sub_60000
		subq.w	#1,$2E(a0)
		bpl.s	locret_5DC2A
		move.b	#$14,routine(a0)
		bset	#7,status(a0)
		st	(Events_fg_4).w
		move.w	#$8F,$2E(a0)
		clr.b	(Player_1+anim).w

locret_5DC2A:
		rts
; ---------------------------------------------------------------------------

loc_5DC2C:
		addq.w	#2,(_unkEE98).w
		subq.w	#1,$2E(a0)
		bpl.w	locret_5FF1A
		move.b	#$16,routine(a0)
		move.b	#1,mapping_frame(a0)
		move.w	#$40,x_pos(a0)
		move.w	#$110,y_pos(a0)
		move.w	#(2*60)-1,$2E(a0)
		lea	(Player_1).w,a1
		clr.b	mapping_frame(a1)
		move.w	#$100,x_vel(a0)
		bsr.w	sub_6001E
		lea	ChildObjDat_601CA(pc),a2
		jsr	(CreateChild6_Simple).l
		lea	ChildObjDat_601D0(pc),a2
		jsr	(CreateChild1_Normal).l
		lea	ChildObjDat_601D8(pc),a2
		jsr	(CreateChild1_Normal).l
		tst.b	(_unkFA88).w
		bmi.w	locret_5FF1A
		lea	ChildObjDat_601E0(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_5DC98:
		subq.w	#1,$2E(a0)
		bpl.s	locret_5DCA4
		move.b	#$18,routine(a0)

locret_5DCA4:
		rts
; ---------------------------------------------------------------------------

loc_5DCA6:
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		cmpi.w	#$140,x_pos(a0)
		blo.s	loc_5DCC4
		lea	AniRaw_60253(pc),a1
		jsr	(Animate_RawNoSSTMultiDelay).l

loc_5DCC4:
		cmpi.w	#$220,x_pos(a0)
		bls.w	locret_5FF1A
		move.b	#$1A,routine(a0)
		move.w	#make_art_tile($26E,1,0),art_tile(a0)
		bset	#0,render_flags(a0)
		bclr	#7,art_tile(a0)
		bset	#4,$38(a0)
		subq.w	#8,y_pos(a0)
		move.w	#-$80,x_vel(a0)
		clr.w	y_vel(a0)
		move.b	#5,mapping_frame(a0)
		cmpi.w	#2,(Player_mode).w
		bne.s	loc_5DD0E
		move.b	#6,mapping_frame(a0)

loc_5DD0E:
		lea	Pal_EndingSmallPlane(pc),a1
		jsr	(PalLoad_Line1).l
		lea	ChildObjDat_6022E(pc),a2
		jsr	(CreateChild1_Normal).l
		tst.b	(_unkFA88).w
		bmi.w	locret_5FF1A
		lea	ChildObjDat_6020C(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_5DD34:
		jsr	(MoveSprite2).l
		cmpi.w	#$120,x_pos(a0)
		bhs.s	locret_5DD68
		move.b	#$1C,routine(a0)
		move.w	#60-1,$2E(a0)
		bset	#5,$38(a0)
		tst.b	(_unkFA88).w
		bmi.s	locret_5DD68
		jsr	(AllocateObject).l
		bne.s	locret_5DD68
		move.l	#loc_5FC1E,(a1)

locret_5DD68:
		rts
; ---------------------------------------------------------------------------

loc_5DD6A:
		subq.w	#1,$2E(a0)
		bpl.s	locret_5DDD0
		move.b	#$1E,routine(a0)
		st	(Events_fg_4).w
		cmpi.w	#3,(Player_mode).w
		beq.s	locret_5DDD0
		tst.b	(_unkFA88).w
		bmi.s	locret_5DDD0
		lea	word_5DDD2(pc),a2
		moveq	#$41,d1
		moveq	#6-1,d2
		bsr.w	Create_Continue_Sprite
		lea	word_5DDEA(pc),a2
		moveq	#$43,d1
		moveq	#2-1,d2
		bsr.w	Create_Continue_Sprite
		lea	word_5DDF2(pc),a2
		moveq	#$44,d1
		moveq	#4-1,d2
		bsr.w	Create_Continue_Sprite
		lea	word_5DE02(pc),a2
		moveq	#$45,d1
		moveq	#2-1,d2
		bsr.w	Create_Continue_Sprite
		lea	word_5DE0A(pc),a2
		moveq	#$46,d1
		moveq	#2-1,d2
		bsr.w	Create_Continue_Sprite
		lea	word_5DE12(pc),a2
		moveq	#$47,d1
		moveq	#2-1,d2
		bsr.w	Create_Continue_Sprite

locret_5DDD0:
		rts
; ---------------------------------------------------------------------------
word_5DDD2:
		dc.w   $2B0,   $D4
		dc.w   $2D0,   $D4
		dc.w   $2F0,   $D4
		dc.w   $310,   $D4
		dc.w   $330,   $D4
		dc.w   $350,   $D4
word_5DDEA:
		dc.w   $12C,  $11C
		dc.w    $F4,  $11C
word_5DDF2:
		dc.w    $E8,  $12C
		dc.w   $158,  $12C
		dc.w    $B8,  $12C
		dc.w   $188,  $12C
word_5DE02:
		dc.w   $2FC,   $DC
		dc.w   $32C,   $DC
word_5DE0A:
		dc.w   $2C4,   $D8
		dc.w   $2EC,   $D8
word_5DE12:
		dc.w   $304,   $D0
		dc.w   $344,   $D0
; ---------------------------------------------------------------------------

loc_5DE1A:
		jsr	(MoveSprite2).l
		cmpi.w	#$60,x_pos(a0)
		bhs.s	locret_5DE34
		move.l	#loc_5DE36,(a0)
		bset	#1,$38(a0)

locret_5DE34:
		rts
; ---------------------------------------------------------------------------

loc_5DE36:
		tst.b	(_unkFA88).w
		bmi.s	loc_5DE46
		cmpi.w	#$78,(Camera_Y_pos_copy).w
		blo.w	locret_5FF1A

loc_5DE46:
		moveq	#signextendB(mus_FadeOut),d0
		jsr	(Play_Music).l
		clr.b	(_unkFAC1).w
		clr.b	(_unkFAB8).w
		st	(Events_fg_4).w
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

Obj_5DE60:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_5DE74(pc,d0.w),d1
		jsr	off_5DE74(pc,d1.w)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
off_5DE74:
		dc.w loc_5DE80-off_5DE74
		dc.w loc_5DED4-off_5DE74
		dc.w loc_5DEF0-off_5DE74
		dc.w loc_5DF12-off_5DE74
		dc.w loc_5DF34-off_5DE74
		dc.w loc_5DF48-off_5DE74
; ---------------------------------------------------------------------------

loc_5DE80:
		move.b	#2,routine(a0)
		move.l	#Map_SSZMasterEmerald,mappings(a0)
		move.b	#$20,width_pixels(a0)
		move.b	#$18,height_pixels(a0)
		move.b	#2,mapping_frame(a0)
		tst.b	subtype(a0)
		bne.s	loc_5DEC6
		move.w	#make_art_tile($52E,2,1),art_tile(a0)
		move.w	#$280,priority(a0)
		tst.b	(_unkFA88).w
		bpl.s	locret_5DEC4
		move.b	#8,routine(a0)
		move.w	#(2*60)-1,$2E(a0)

locret_5DEC4:
		rts
; ---------------------------------------------------------------------------

loc_5DEC6:
		move.w	#make_art_tile($52E,1,0),art_tile(a0)
		move.w	#$300,priority(a0)
		rts
; ---------------------------------------------------------------------------

loc_5DED4:
		btst	#0,(_unkFAB8).w
		bne.s	loc_5DEDE
		rts
; ---------------------------------------------------------------------------

loc_5DEDE:
		move.b	#4,routine(a0)
		move.w	#-$200,x_vel(a0)
		move.w	#$100,y_vel(a0)

loc_5DEF0:
		move.w	(_unkFAA4).w,d0
		bne.s	loc_5DEFC
		jmp	(MoveSprite2).l
; ---------------------------------------------------------------------------

loc_5DEFC:
		move.b	#6,routine(a0)
		move.w	d0,parent3(a0)
		move.b	#-$20,child_dx(a0)
		move.b	#1,child_dy(a0)

loc_5DF12:
		jsr	(Refresh_ChildPosition).l
		cmpi.w	#$50,x_pos(a0)
		bls.s	loc_5DF2E
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.s	loc_5DF2E
		rts
; ---------------------------------------------------------------------------

loc_5DF2E:
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

loc_5DF34:
		subq.w	#1,$2E(a0)
		bpl.s	locret_5DF46
		move.b	#$A,routine(a0)
		move.w	#-$80,y_vel(a0)

locret_5DF46:
		rts
; ---------------------------------------------------------------------------

loc_5DF48:
		jsr	(MoveSprite2).l
		cmpi.w	#$40,y_pos(a0)
		blo.s	loc_5DF2E
		rts
; ---------------------------------------------------------------------------

loc_5DF58:
		tst.b	(_unkFA88).w
		beq.s	locret_5DF7E
		bmi.s	locret_5DF7E
		move.b	(_unkFAC1).w,d0
		beq.s	locret_5DF7E
		lea	(off_7DD5A).l,a1
		lea	(Normal_palette_line_3+$1C).w,a2
		tst.b	d0
		bpl.s	loc_5DF78
		lea	(Normal_palette_line_2+$1C).w,a2

loc_5DF78:
		jsr	(Run_PalRotationScript2).l

locret_5DF7E:
		rts
; ---------------------------------------------------------------------------

loc_5DF80:
		lea	ObjDat3_60104(pc),a1
		jsr	(SetUp_ObjAttributes).l
		bclr	#2,render_flags(a0)
		move.l	#loc_5DF98,(a0)
		rts
; ---------------------------------------------------------------------------

loc_5DF98:
		btst	#1,(_unkFAB8).w
		beq.s	loc_5DFA6
		move.l	#loc_5DFB2,(a0)

loc_5DFA6:
		jsr	(Refresh_ChildPosition).l
		jmp	(Child_Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_5DFB2:
		move.b	child_dx(a0),d0
		subq.b	#2,d0
		move.b	d0,child_dx(a0)
		cmpi.b	#-$74,d0
		bgt.s	loc_5DFCC
		move.l	#loc_5DFD8,(a0)
		move.w	a0,(_unkFAA4).w

loc_5DFCC:
		jsr	(Refresh_ChildPosition).l
		jmp	(Child_Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_5DFD8:
		jsr	(Refresh_ChildPosition).l
		cmpi.w	#$50,x_pos(a0)
		bls.w	loc_5EC36
		jmp	(Child_Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_5DFEE:
		move.l	#Map_SonicPlaneEnding,mappings(a0)
		move.w	#make_art_tile($26E,0,0),art_tile(a0)
		move.w	#$380,priority(a0)
		move.b	#1,mapping_frame(a0)
		move.b	#$20,width_pixels(a0)
		move.b	#$14,height_pixels(a0)
		move.l	#loc_5E08A,(a0)
		bset	#0,render_flags(a0)
		move.w	#$220,x_pos(a0)
		move.w	#$B0,y_pos(a0)
		move.w	#-$100,x_vel(a0)
		bsr.w	sub_6001E
		moveq	#signextendB(mus_CreditsK),d0
		jsr	(Play_Music).l
		lea	ChildObjDat_601CA(pc),a2
		jsr	(CreateChild6_Simple).l
		lea	ChildObjDat_601D0(pc),a2
		jsr	(CreateChild1_Normal).l
		bclr	#0,(_unkFAB8).w
		jsr	(AllocateObject).l
		bne.s	loc_5E07A
		move.l	#Obj_5DE60,(a1)
		move.w	a0,parent3(a1)
		move.w	#$190,x_pos(a1)
		move.w	#$DC,y_pos(a1)
		st	subtype(a1)

loc_5E07A:
		lea	(ArtKosM_SonicPlaneEnding).l,a1
		move.w	#tiles_to_bytes($26E),d2
		jmp	(Queue_Kos_Module).l
; ---------------------------------------------------------------------------

loc_5E08A:
		cmpi.w	#$EEE,(Normal_palette+$2).w
		bne.s	loc_5E0AC
		bset	#7,$38(a0)
		bne.s	loc_5E0AC
		st	(_unkFAC1).w
		jsr	(AllocateObject).l
		bne.s	loc_5E0AC
		move.l	#loc_5DF58,(a1)

loc_5E0AC:
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		cmpi.w	#$60,x_pos(a0)
		bhs.s	loc_5E0D0
		move.l	#loc_5E0D6,(a0)
		bset	#4,$38(a0)
		clr.b	5(a0)

loc_5E0D0:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_5E0D6:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_5E0F0(pc,d0.w),d1
		jsr	off_5E0F0(pc,d1.w)
		jsr	(Knuckles_Load_PLC_661E0).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
off_5E0F0:
		dc.w loc_5E0F8-off_5E0F0
		dc.w loc_5E142-off_5E0F0
		dc.w loc_5E170-off_5E0F0
		dc.w locret_5E188-off_5E0F0
; ---------------------------------------------------------------------------

loc_5E0F8:
		move.b	#2,routine(a0)
		move.l	#Map_Knuckles,mappings(a0)
		move.w	#make_art_tile($4DA,0,1),art_tile(a0)
		move.w	#$180,priority(a0)
		move.b	#7,mapping_frame(a0)
		move.w	#$1E0,x_pos(a0)
		move.w	#$E0,y_pos(a0)
		move.w	#-$200,x_vel(a0)
		clr.w	y_vel(a0)
		lea	(Pal_ContinueScreen+$60).l,a1
		lea	(Normal_palette).w,a2
		moveq	#bytesToLcnt($20),d6

loc_5E13A:
		move.l	(a1)+,(a2)+
		dbf	d6,loc_5E13A
		rts
; ---------------------------------------------------------------------------

loc_5E142:
		lea	(byte_66824).l,a1
		jsr	(Animate_RawNoSSTCheckResult).l
		jsr	(MoveSprite2).l
		cmpi.w	#$120,x_pos(a0)
		bhs.s	locret_5E16E
		move.b	#4,routine(a0)
		move.b	#$55,mapping_frame(a0)
		move.w	#(2*60)-1,$2E(a0)

locret_5E16E:
		rts
; ---------------------------------------------------------------------------

loc_5E170:
		subq.w	#1,$2E(a0)
		bpl.w	locret_5FF1A
		move.b	#6,routine(a0)
		st	(Events_fg_4).w
		clr.b	(_unkFAC1).w
		rts
; ---------------------------------------------------------------------------

locret_5E188:
		rts
; ---------------------------------------------------------------------------

Obj_Ending:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_5E1AE(pc,d0.w),d1
		jsr	off_5E1AE(pc,d1.w)
		subq.w	#2,(_unkEE98).w
		lea	(Player_1).w,a1
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		rts
; ---------------------------------------------------------------------------
off_5E1AE:
		dc.w loc_5E1C2-off_5E1AE
		dc.w loc_5E288-off_5E1AE
		dc.w loc_5E2C2-off_5E1AE
		dc.w loc_5E334-off_5E1AE
		dc.w loc_5E3EE-off_5E1AE
		dc.w loc_5E412-off_5E1AE
		dc.w loc_5E45A-off_5E1AE
		dc.w loc_5E474-off_5E1AE
		dc.w loc_5E4B6-off_5E1AE
		dc.w loc_5E4E2-off_5E1AE
; ---------------------------------------------------------------------------

loc_5E1C2:
		move.b	#2,routine(a0)
		bset	#0,render_flags(a0)
		move.w	#$C0,x_pos(a0)
		move.w	#$E0,y_pos(a0)
		jsr	(Swing_Setup1).l
		cmpi.b	#2,(_unkFA88).w
		beq.s	loc_5E1F0
		moveq	#signextendB(mus_CreditsK),d0
		jsr	(Play_Music).l

loc_5E1F0:
		lea	(Player_1).w,a1
		bset	#0,render_flags(a1)
		bset	#0,status(a1)
		bclr	#7,art_tile(a1)
		move.b	#$83,$2E(a1)
		move.b	#5,anim(a1)
		cmpi.w	#2,(Player_mode).w
		bne.s	loc_5E228
		lea	(Tails_tails).w,a2
		move.l	#Obj_Tails_Tail,(a2)
		move.w	a1,$30(a2)

loc_5E228:
		bsr.w	sub_5FD88
		lea	ChildObjDat_601BA(pc),a2
		jsr	(CreateChild1_Normal).l
		bne.s	loc_5E23E
		bset	#2,$38(a1)

loc_5E23E:
		tst.b	(_unkFA88).w
		bmi.s	loc_5E258
		lea	ChildObjDat_60214(pc),a2
		jsr	(CreateChild6_Simple).l
		lea	ChildObjDat_6021A(pc),a2
		jsr	(CreateChild6_Simple).l

loc_5E258:
		lea	(ArtKosM_SonicPlane).l,a1
		move.w	#tiles_to_bytes($1E3),d2
		jsr	(Queue_Kos_Module).l
		lea	(ArtKosM_SonicPlaneEnding).l,a1
		move.w	#tiles_to_bytes($26E),d2
		jsr	(Queue_Kos_Module).l
		lea	(ArtKosM_EndingAnimals).l,a1
		move.w	#tiles_to_bytes($2FF),d2
		jmp	(Queue_Kos_Module).l
; ---------------------------------------------------------------------------

loc_5E288:
		bclr	#2,(Tails_tails+render_flags).w
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		tst.b	(_unkFACC).w
		beq.w	locret_5FF1A
		move.b	#4,routine(a0)
		move.w	#$1F,$2E(a0)
		lea	(Player_1).w,a1
		move.b	#$58,mapping_frame(a1)
		clr.b	anim(a1)
		jmp	(Player_Load_PLC).l
; ---------------------------------------------------------------------------

loc_5E2C2:
		subq.w	#1,$2E(a0)
		bpl.w	locret_5FF1A
		move.b	#6,routine(a0)
		bset	#2,$38(a0)
		move.w	#$300,x_vel(a0)
		move.w	#-$600,y_vel(a0)
		lea	(Player_1).w,a1
		bclr	#0,render_flags(a1)
		bclr	#0,status(a1)
		move.b	#$81,$2E(a1)
		move.w	#$200,anim(a1)
		clr.l	(Tails_tails).w
		moveq	#0,d0
		cmpi.w	#2,(Player_mode).w
		beq.s	loc_5E316
		moveq	#4,d0
		tst.b	(_unkFA88).w
		bmi.s	loc_5E316
		moveq	#8,d0

loc_5E316:
		move.w	d0,(Camera_stored_max_X_pos).w
		movea.l	off_5E328(pc,d0.w),a1
		move.w	#tiles_to_bytes($347),d2
		jmp	(Queue_Kos_Module).l
; ---------------------------------------------------------------------------
off_5E328:
		dc.l ArtKosM_TailsEndPose
		dc.l ArtKosM_SonicEndPose
		dc.l ArtKosM_SuperSonicEndPose
; ---------------------------------------------------------------------------

loc_5E334:
		jsr	(MoveSprite).l
		tst.w	y_vel(a0)
		bmi.w	locret_5FF1A
		cmpi.w	#$E0,y_pos(a0)
		blo.w	locret_5FF1A
		move.l	#Map_SonicTailsEndPoses,mappings(a0)
		move.w	#make_art_tile($347,2,0),art_tile(a0)
		move.w	#$100,priority(a0)
		move.b	#$80,width_pixels(a0)
		move.b	#$80,height_pixels(a0)
		cmpi.w	#2,(Player_mode).w
		bne.s	loc_5E37A
		move.b	#3,mapping_frame(a0)

loc_5E37A:
		move.w	(Camera_stored_max_X_pos).w,d0
		movea.l	off_5E3B4(pc,d0.w),a1
		lea	(Normal_palette_line_3).w,a2
		moveq	#bytesToLcnt($20),d0

loc_5E388:
		move.l	(a1)+,(a2)+
		dbf	d0,loc_5E388
		tst.b	(_unkFA88).w
		bmi.s	loc_5E3C0
		bne.s	loc_5E39E
		cmpi.w	#2,(Player_mode).w
		bhs.s	loc_5E3C0

loc_5E39E:
		move.b	#$A,routine(a0)
		move.b	#1,(Update_HUD_timer).w
		clr.w	(Palette_frame).w
		jmp	(Ending_Give_SuperSonic).l
; ---------------------------------------------------------------------------
off_5E3B4:
		dc.l Pal_TailsEndPose
		dc.l Pal_SonicEndPose
		dc.l Pal_SuperSonicEndPose
; ---------------------------------------------------------------------------

loc_5E3C0:
		move.b	#8,routine(a0)
		move.w	#5,$2E(a0)
		cmpi.w	#2,(Player_mode).w
		bne.s	loc_5E3DA
		bset	#0,render_flags(a0)

loc_5E3DA:
		lea	(Player_1).w,a1
		move.b	#$83,$2E(a1)
		clr.b	mapping_frame(a1)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_5E3EE:
		subq.w	#1,$2E(a0)
		bpl.s	loc_5E40C
		move.b	#$12,routine(a0)
		addq.b	#1,mapping_frame(a0)
		jsr	(AllocateObject).l
		bne.s	loc_5E40C
		move.l	#Obj_5EF68,(a1)

loc_5E40C:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_5E412:
		lea	(Player_1).w,a1
		tst.b	$2E(a1)
		bne.s	locret_5E440
		cmpi.w	#2,(Player_mode).w
		beq.s	loc_5E442
		move.b	#$C,routine(a0)
		move.b	#$81,$2E(a1)
		clr.b	anim(a1)
		move.w	#$800,x_vel(a1)
		move.w	#$800,ground_vel(a1)

locret_5E440:
		rts
; ---------------------------------------------------------------------------

loc_5E442:
		jsr	(AllocateObject).l
		bne.s	loc_5E450
		move.l	#loc_5FCDC,(a1)

loc_5E450:
		bset	#0,render_flags(a0)
		bra.w	loc_5E3C0
; ---------------------------------------------------------------------------

loc_5E45A:
		addq.w	#4,x_pos(a0)
		cmpi.w	#$200,x_pos(a0)
		blo.s	locret_5E472
		move.b	#$E,routine(a0)
		move.w	#$1F,$2E(a0)

locret_5E472:
		rts
; ---------------------------------------------------------------------------

loc_5E474:
		subq.w	#1,$2E(a0)
		bpl.s	locret_5E4B4
		move.b	#$10,routine(a0)
		move.b	#2,mapping_frame(a0)
		bclr	#0,render_flags(a0)
		lea	(Player_1).w,a1
		move.b	#$83,$2E(a1)
		clr.b	mapping_frame(a1)
		jsr	(AllocateObject).l
		bne.s	locret_5E4B4
		move.l	#loc_5FCFC,(a1)
		tst.b	(_unkFA88).w
		beq.s	locret_5E4B4
		move.b	#2,subtype(a1)

locret_5E4B4:
		rts
; ---------------------------------------------------------------------------

loc_5E4B6:
		subq.w	#8,x_pos(a0)
		cmpi.w	#$160,x_pos(a0)
		bhi.s	loc_5E4DC
		move.b	#$12,routine(a0)
		move.w	#$160,x_pos(a0)
		jsr	(AllocateObject).l
		bne.s	loc_5E4DC
		move.l	#Obj_5EF68,(a1)

loc_5E4DC:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_5E4E2:
		cmpi.w	#2,(Player_mode).w
		bne.s	loc_5E4F0
		move.b	#$7F,(Palette_timer).w

loc_5E4F0:
		btst	#3,(_unkFAB8).w
		bne.s	loc_5E4FE
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_5E4FE:
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

loc_5E504:
		move.l	#loc_5E568,(a0)
		move.l	#Map_EndingAnimals,mappings(a0)
		move.w	#make_art_tile($2FF,0,0),art_tile(a0)
		move.w	#$380,priority(a0)
		move.b	#2,mapping_frame(a0)
		move.b	#$C,width_pixels(a0)
		move.b	#8,height_pixels(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		add.w	d0,d0
		lea	word_5E554(pc,d0.w),a1
		move.w	(a1)+,x_pos(a0)
		move.w	(a1)+,y_pos(a0)
		lsl.w	#2,d0
		move.w	d0,$2E(a0)
		move.w	x_pos(a0),$3A(a0)
		bra.w	sub_6001E
; ---------------------------------------------------------------------------
word_5E554:
		dc.w   $170,   $B0
		dc.w   $150,   $C0
		dc.w   $190,   $D0
		dc.w   $140,   $E0
		dc.w   $168,   $F0
; ---------------------------------------------------------------------------

loc_5E568:
		btst	#3,(_unkFAB8).w
		bne.w	loc_5EC36
		lea	AniRaw_602A1(pc),a1
		jsr	(Animate_RawNoSST).l
		subq.w	#1,$2E(a0)
		bpl.s	loc_5E58E
		move.l	#loc_5E594,(a0)
		move.w	#-$40,x_vel(a0)

loc_5E58E:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_5E594:
		btst	#3,(_unkFAB8).w
		bne.w	loc_5EC36
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		lea	AniRaw_602A1(pc),a1
		jsr	(Animate_RawNoSST).l
		move.w	$3A(a0),d0
		sub.w	x_pos(a0),d0
		cmpi.w	#$30,d0
		blt.s	loc_5E5D4
		move.l	#loc_5E5DA,(a0)
		move.w	#$80,x_vel(a0)
		move.b	#2,mapping_frame(a0)

loc_5E5D4:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_5E5DA:
		btst	#3,(_unkFAB8).w
		bne.w	loc_5EC36
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		move.w	$3A(a0),d0
		sub.w	x_pos(a0),d0
		bcc.s	loc_5E60C
		move.l	#loc_5E594,(a0)
		move.w	#-$40,x_vel(a0)
		move.w	$3A(a0),x_pos(a0)

loc_5E60C:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_5E612:
		move.l	#loc_5E64A,(a0)
		move.l	#Map_EndingAnimals,mappings(a0)
		move.w	#make_art_tile($2FF,3,0),art_tile(a0)
		move.w	#$280,priority(a0)
		move.b	#$C,width_pixels(a0)
		move.b	#8,height_pixels(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		lsl.w	#3,d0
		addi.w	#$60,d0
		move.w	d0,$2E(a0)
		rts
; ---------------------------------------------------------------------------

loc_5E64A:
		btst	#3,(_unkFAB8).w
		bne.w	loc_5EC36
		subq.w	#1,$2E(a0)
		bpl.s	locret_5E684
		move.l	#loc_5E686,(a0)
		jsr	(Random_Number).l
		andi.w	#$3F,d0
		addi.w	#$180,d0
		move.w	d0,x_pos(a0)
		move.w	#$180,y_pos(a0)
		move.w	#-$300,x_vel(a0)
		move.w	#-$600,y_vel(a0)

locret_5E684:
		rts
; ---------------------------------------------------------------------------

loc_5E686:
		btst	#3,(_unkFAB8).w
		bne.w	loc_5EC36
		jsr	(MoveSprite).l
		clr.b	mapping_frame(a0)
		tst.w	y_vel(a0)
		bmi.s	loc_5E6BA
		move.b	#1,mapping_frame(a0)
		cmpi.w	#$180,y_pos(a0)
		blo.s	loc_5E6BA
		move.l	#loc_5E64A,(a0)
		move.w	#60-1,$2E(a0)

loc_5E6BA:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_5E6C0:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	VInt_TableFC(pc,d0.w),d1
		jsr	VInt_TableFC(pc,d1.w)
		tst.b	(_unkFA88).w
		beq.s	loc_5E6E6
		bmi.s	loc_5E6E6
		lea	(off_7DD5A).l,a1
		lea	(Normal_palette_line_3+$1C).w,a2
		jsr	(Run_PalRotationScript2).l

loc_5E6E6:
		lea	(Player_1).w,a1
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
VInt_TableFC:
		dc.w loc_5E70E-VInt_TableFC
		dc.w loc_5E80A-VInt_TableFC
		dc.w loc_5E832-VInt_TableFC
		dc.w loc_5E86A-VInt_TableFC
		dc.w loc_5E890-VInt_TableFC
		dc.w loc_5E916-VInt_TableFC
		dc.w loc_5E98A-VInt_TableFC
		dc.w loc_5E9C2-VInt_TableFC
		dc.w loc_5E9E2-VInt_TableFC
; ---------------------------------------------------------------------------

loc_5E70E:
		lea	ObjDat3_600C2(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.w	#(5*60)-1,$2E(a0)
		lea	(Player_1).w,a1
		move.b	#$83,$2E(a1)
		clr.b	mapping_frame(a1)
		st	(Scroll_lock).w
		clr.b	(_unkFAB8).w
		clr.b	(Level_started_flag).w
		clr.w	(Screen_shake_flag).w
		clr.l	(Timer).w
		move.w	(Camera_X_pos).w,d0
		addi.w	#$C0,d0
		move.w	d0,x_pos(a0)
		move.w	(Camera_Y_pos).w,d0
		addi.w	#$110,d0
		move.w	d0,y_pos(a0)
		lea	ChildObjDat_601BA(pc),a2
		jsr	(CreateChild1_Normal).l
		move.l	#AniRaw_60236,$30(a0)
		bsr.w	sub_5FE82
		tst.b	(_unkFA88).w
		bmi.s	loc_5E7C0
		move.b	#4,mapping_frame(a0)
		move.l	#AniRaw_6023F,$30(a0)
		lea	ChildObjDat_601B2(pc),a2
		jsr	(CreateChild1_Normal).l
		lea	(ArtKosM_EndingMasterEmerald).l,a1
		move.w	#tiles_to_bytes($52E),d2
		jsr	(Queue_Kos_Module).l
		tst.b	(_unkFA88).w
		beq.s	loc_5E7C0
		move.b	#1,(Update_HUD_timer).w
		move.b	#-1,(Super_palette_status).w
		move.b	#$F,(Palette_timer).w
		move.b	#1,(Super_Sonic_Knux_flag).w
		move.w	#$7FFF,(Super_frame_count).w

loc_5E7C0:
		lea	(Pal_SonicTails).l,a1
		lea	(Target_palette_line_2).w,a2
		moveq	#bytesToLcnt($20),d6

loc_5E7CC:
		move.l	(a1)+,(a2)+
		dbf	d6,loc_5E7CC
		move.l	#$EE0088,(Target_palette_line_2+$A).w
		lea	(ArtKosM_KnuxEnding).l,a1
		move.w	#tiles_to_bytes($310),d2
		jsr	(Queue_Kos_Module).l
		lea	(ArtKosM_SonicPlane).l,a1
		move.w	#tiles_to_bytes($1E3),d2
		jsr	(Queue_Kos_Module).l
		lea	(ArtKosM_SonicPlaneEnding).l,a1
		move.w	#tiles_to_bytes($26E),d2
		jmp	(Queue_Kos_Module).l
; ---------------------------------------------------------------------------

loc_5E80A:
		moveq	#signextendB(sfx_WindQuiet),d0
		jsr	(Play_SFX_Continuous).l
		jsr	(Animate_RawMultiDelay).l
		subq.w	#1,$2E(a0)
		bpl.s	locret_5E830
		move.b	#4,routine(a0)
		move.w	#-$6C0,y_vel(a0)
		jsr	(Restore_LevelMusic).l

locret_5E830:
		rts
; ---------------------------------------------------------------------------

loc_5E832:
		jsr	(Animate_RawMultiDelay).l
		jsr	(MoveSprite_LightGravity).l
		tst.w	y_vel(a0)
		bmi.s	locret_5E868
		move.b	#6,routine(a0)
		jsr	(Swing_Setup1).l
		move.w	#(3*60)-1,$2E(a0)
		tst.b	(_unkFA88).w
		bmi.s	locret_5E868
		lea	(AniRaw_60244).l,a1
		jsr	(Set_Raw_Animation).l

locret_5E868:
		rts
; ---------------------------------------------------------------------------

loc_5E86A:
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		jsr	(Animate_RawMultiDelay).l
		subq.w	#1,$2E(a0)
		bpl.s	locret_5E88E
		move.b	#8,routine(a0)
		move.w	#$400,x_vel(a0)

locret_5E88E:
		rts
; ---------------------------------------------------------------------------

loc_5E890:
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		jsr	(Animate_RawMultiDelay).l
		move.w	(Camera_X_pos).w,d0
		addi.w	#$200,d0
		cmp.w	x_pos(a0),d0
		bhi.w	locret_5FF1A
		move.b	#$A,routine(a0)
		move.l	#Map_SonicPlaneEnding,mappings(a0)
		move.w	#make_art_tile($26E,0,1),art_tile(a0)
		move.b	#1,mapping_frame(a0)
		bset	#0,render_flags(a0)
		bset	#7,status(a0)
		move.w	(Camera_Y_pos).w,d0
		addi.w	#$50,d0
		move.w	d0,y_pos(a0)
		move.w	#-$200,x_vel(a0)
		bsr.w	sub_6001E
		lea	AniRaw_60253(pc),a1
		jsr	(Set_Raw_Animation).l
		lea	ChildObjDat_601D8(pc),a2
		jsr	(CreateChild1_Normal).l
		lea	ChildObjDat_601CA(pc),a2
		jsr	(CreateChild6_Simple).l
		lea	ChildObjDat_601D0(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_5E916:
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		move.w	(Camera_X_pos).w,d3
		addi.w	#$60,d3
		cmp.w	x_pos(a0),d3
		blo.s	loc_5E936
		jsr	(Animate_RawMultiDelay).l

loc_5E936:
		subi.w	#$A0,d3
		cmp.w	x_pos(a0),d3
		blo.w	locret_5FF1A
		move.b	#$C,routine(a0)
		move.w	#make_art_tile($26E,1,0),art_tile(a0)
		move.b	#6,mapping_frame(a0)
		bclr	#0,render_flags(a0)
		bset	#4,$38(a0)
		move.w	(_unkEE9C).w,d0
		addi.w	#$448,d0
		move.w	d0,y_pos(a0)
		move.w	#$100,x_vel(a0)
		clr.w	y_vel(a0)
		lea	ChildObjDat_6022E(pc),a2
		jsr	(CreateChild1_Normal).l
		lea	Pal_EndingSmallPlane(pc),a1
		jmp	(PalLoad_Line1).l
; ---------------------------------------------------------------------------

loc_5E98A:
		jsr	(MoveSprite2).l
		move.w	(Camera_X_pos).w,d0
		addi.w	#$A0,d0
		cmp.w	x_pos(a0),d0
		bhs.s	locret_5E9C0
		move.b	#$E,routine(a0)
		clr.b	mapping_frame(a0)
		st	(Events_fg_4).w
		tst.b	(_unkFA88).w
		bmi.s	locret_5E9C0
		jsr	(AllocateObject).l
		bne.s	locret_5E9C0
		move.l	#loc_5FC1E,(a1)

locret_5E9C0:
		rts
; ---------------------------------------------------------------------------

loc_5E9C2:
		tst.b	(_unkFAA9).w
		beq.s	locret_5E9E0
		move.b	#$10,routine(a0)
		move.b	#$1A,mapping_frame(a0)
		move.w	(_unkEE9C).w,d0
		addi.w	#$448,d0
		move.w	d0,y_pos(a0)

locret_5E9E0:
		rts
; ---------------------------------------------------------------------------

loc_5E9E2:
		jsr	(MoveSprite2).l
		tst.b	render_flags(a0)
		bmi.s	locret_5EA18
		move.l	#loc_5EA1A,(a0)
		move.w	#(6*60)-1,$2E(a0)
		move.b	#2,(Super_palette_status).w
		move.w	#$1E,(Palette_frame).w
		move.b	#0,(Super_Sonic_Knux_flag).w
		move.b	#0,(Super_Tails_flag).w
		bset	#1,$38(a0)

locret_5EA18:
		rts
; ---------------------------------------------------------------------------

loc_5EA1A:
		subq.w	#1,$2E(a0)
		bpl.w	locret_5FF1A
		jsr	(AllocateObject).l
		bne.s	loc_5EA30
		move.l	#loc_5F94C,(a1)

loc_5EA30:
		move.b	#$3F,(_unkFAB9).w
		clr.w	(_unkFAC2).w
		move.w	#-$80,(_unkFAC4).w
		tst.b	(_unkFA88).w
		bmi.s	loc_5EA4C
		move.w	#$80,(_unkFAC4).w

loc_5EA4C:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

Obj_5EA52:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_5EA6A(pc,d0.w),d1
		jsr	off_5EA6A(pc,d1.w)
		bsr.w	sub_60038
		jmp	(Child_Draw_Sprite).l
; ---------------------------------------------------------------------------
off_5EA6A:
		dc.w loc_5EA74-off_5EA6A
		dc.w loc_5EADC-off_5EA6A
		dc.w loc_5EB02-off_5EA6A
		dc.w loc_5EB16-off_5EA6A
		dc.w loc_5EB2E-off_5EA6A
; ---------------------------------------------------------------------------

loc_5EA74:
		lea	ObjDat3_600CE(pc),a1
		jsr	(SetUp_ObjAttributes).l
		bclr	#2,$38(a0)
		beq.s	loc_5EA8C
		bclr	#2,render_flags(a0)

loc_5EA8C:
		tst.b	subtype(a0)
		beq.s	loc_5EABA
		move.b	#4,routine(a0)
		move.w	#$40,x_pos(a0)
		move.w	#$10B,d0
		move.w	d0,y_pos(a0)
		move.w	d0,$3A(a0)
		tst.b	(_unkFA88).w
		bmi.s	loc_5EABA
		lea	ChildObjDat_601E8(pc),a2
		jsr	(CreateChild1_Normal).l

loc_5EABA:
		cmpi.w	#2,(Player_mode).w
		bne.s	loc_5EAC6
		subq.b	#4,$43(a0)

loc_5EAC6:
		bset	#6,render_flags(a0)
		move.w	#2,mainspr_childsprites(a0)
		lea	ChildObjDat_601C2(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_5EADC:
		jsr	(Child_GetPriority).l
		movea.w	parent3(a0),a1
		btst	#2,$38(a1)
		bne.s	loc_5EAF4
		jmp	(Refresh_ChildPositionAdjusted).l
; ---------------------------------------------------------------------------

loc_5EAF4:
		move.b	#8,routine(a0)
		move.w	y_pos(a0),$3A(a0)
		rts
; ---------------------------------------------------------------------------

loc_5EB02:
		movea.w	parent3(a0),a1
		btst	#3,$38(a1)
		beq.s	locret_5EB14
		move.b	#6,routine(a0)

locret_5EB14:
		rts
; ---------------------------------------------------------------------------

loc_5EB16:
		btst	#0,(_unkFAB8).w
		bne.s	loc_5EB26
		addq.w	#2,x_pos(a0)
		bra.w	sub_60000
; ---------------------------------------------------------------------------

loc_5EB26:
		move.b	#2,routine(a0)
		rts
; ---------------------------------------------------------------------------

loc_5EB2E:
		bra.w	sub_60000
; ---------------------------------------------------------------------------

Obj_5EB32:
		move.l	#loc_5EBB4,(a0)
		movea.w	parent3(a0),a1
		move.w	priority(a1),priority(a0)
		move.b	#$20,width_pixels(a0)
		move.b	#$20,height_pixels(a0)
		btst	#2,render_flags(a1)
		beq.s	loc_5EB5C
		bset	#2,render_flags(a0)

loc_5EB5C:
		move.w	(Player_mode).w,d0
		add.w	d0,d0
		move.w	off_5EB6A(pc,d0.w),d0
		jmp	off_5EB6A(pc,d0.w)
; ---------------------------------------------------------------------------
off_5EB6A:
		dc.w loc_5EB72-off_5EB6A
		dc.w loc_5EB72-off_5EB6A
		dc.w loc_5EB88-off_5EB6A
		dc.w loc_5EB9E-off_5EB6A
; ---------------------------------------------------------------------------

loc_5EB72:
		move.l	#Map_SonicPlane,mappings(a0)
		move.w	#make_art_tile($1E3,0,1),art_tile(a0)
		move.b	#$C,mapping_frame(a0)
		rts
; ---------------------------------------------------------------------------

loc_5EB88:
		move.l	#Map_SonicPlaneEnding,mappings(a0)
		move.w	#make_art_tile($26E,0,1),art_tile(a0)
		move.b	#$B,mapping_frame(a0)
		rts
; ---------------------------------------------------------------------------

loc_5EB9E:
		move.l	#Map_SonicPlaneEnding,mappings(a0)
		move.w	#make_art_tile($26E,0,1),art_tile(a0)
		move.b	#$12,mapping_frame(a0)
		rts
; ---------------------------------------------------------------------------

loc_5EBB4:
		jsr	(Child_GetPriority).l
		jsr	(Refresh_ChildPositionAdjusted).l
		jmp	(Child_Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_5EBC6:
		move.l	#loc_5EBE4,(a0)
		lea	(ObjDat3_7D450).l,a1
		jsr	(SetUp_ObjAttributes).l
		addi.w	#make_art_tile($000,2,0),art_tile(a0)
		move.b	#2,mapping_frame(a0)

loc_5EBE4:
		jsr	(Refresh_ChildPosition).l
		jmp	(Child_Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_5EBF0:
		lea	word_600F2(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#loc_5EC14,(a0)

loc_5EC00:
		movea.w	parent3(a0),a1
		btst	#2,render_flags(a1)
		bne.s	locret_5EC12
		bclr	#2,render_flags(a0)

locret_5EC12:
		rts
; ---------------------------------------------------------------------------

loc_5EC14:
		jsr	(Refresh_ChildPositionAdjusted).l
		movea.w	parent3(a0),a1
		btst	#4,$38(a1)
		bne.s	loc_5EC36
		btst	#1,(V_int_run_count+3).w
		bne.w	locret_5FF1A
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_5EC36:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_5EC3C:
		lea	word_600F8(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#loc_5EC4E,(a0)
		bra.s	loc_5EC00
; ---------------------------------------------------------------------------

loc_5EC4E:
		movea.w	parent3(a0),a1
		moveq	#0,d0
		move.b	mapping_frame(a1),d0
		subq.w	#1,d0
		add.w	d0,d0
		move.w	byte_5EC8E(pc,d0.w),child_dx(a0)	; and child_dy
		jsr	(Refresh_ChildPositionAdjusted).l
		movea.w	parent3(a0),a1
		btst	#4,$38(a1)
		bne.s	loc_5EC36
		move.b	#$16,mapping_frame(a0)
		btst	#1,(V_int_run_count+3).w
		beq.s	loc_5EC88
		move.b	#$17,mapping_frame(a0)

loc_5EC88:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
byte_5EC8E:
		dc.b  -$A,  $C
		dc.b   -9,  $B
		dc.b   -8,   9
		even
; ---------------------------------------------------------------------------

loc_5EC94:
		lea	word_600FE(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#loc_5ECA8,(a0)
		bra.w	loc_5EC00
; ---------------------------------------------------------------------------

loc_5ECA8:
		jsr	(Refresh_ChildPositionAdjusted).l
		jmp	(Child_Draw_Sprite2).l
; ---------------------------------------------------------------------------

loc_5ECB4:
		lea	ObjDat3_600E6(pc),a1
		jsr	(SetUp_ObjAttributes).l
		movea.w	parent3(a0),a1
		bclr	#7,art_tile(a0)
		btst	#7,art_tile(a1)
		beq.s	loc_5ECD6
		bset	#7,art_tile(a0)

loc_5ECD6:
		btst	#2,render_flags(a1)
		bne.s	loc_5ECE4
		bclr	#2,render_flags(a0)

loc_5ECE4:
		move.l	#loc_5ED18,(a0)
		move.w	(Player_mode).w,d0
		cmpi.w	#3,d0
		bne.s	loc_5ECFC
		tst.b	(_unkFA88).w
		bmi.s	loc_5ECFC
		addq.w	#1,d0

loc_5ECFC:
		add.w	d0,d0
		tst.b	subtype(a0)
		beq.s	loc_5ED06
		addq.b	#1,d0

loc_5ED06:
		move.b	byte_5ED0E(pc,d0.w),mapping_frame(a0)
		rts
; ---------------------------------------------------------------------------
byte_5ED0E:
		dc.b   $C,  $E
		dc.b   $C,  $E
		dc.b   $D,  $F
		dc.b  $13, $14
		dc.b  $13, $15
; ---------------------------------------------------------------------------

loc_5ED18:
		movea.w	parent3(a0),a1
		btst	#4,$38(a1)
		bne.w	loc_5EC36
		bsr.w	sub_6008A
		jsr	(Refresh_ChildPositionAdjusted).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_5ED36:
		lea	word_60110(pc),a1
		jsr	(SetUp_ObjAttributes2).l
		move.l	#loc_5ED4A,(a0)
		bra.w	loc_5EC00
; ---------------------------------------------------------------------------

loc_5ED4A:
		jsr	(Child_GetPriority).l
		jsr	(Refresh_ChildPositionAdjusted).l
		movea.w	parent3(a0),a1
		btst	#5,$38(a1)
		bne.w	loc_5EC36
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_5ED6A:
		lea	word_600F8(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#loc_5ED7E,(a0)
		bra.w	loc_5EC00
; ---------------------------------------------------------------------------

loc_5ED7E:
		jsr	(Refresh_ChildPositionAdjusted).l
		movea.w	parent3(a0),a1
		btst	#1,$38(a1)
		bne.w	loc_5EC36
		move.b	#$18,mapping_frame(a0)
		btst	#1,(V_int_run_count+3).w
		beq.s	loc_5EDA6
		move.b	#$19,mapping_frame(a0)

loc_5EDA6:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_5EDAC:
		move.l	#Map_IslandLiftGfx,mappings(a0)
		move.w	#make_art_tile($2FF,3,1),art_tile(a0)
		move.w	#$300,priority(a0)
		move.b	#$10,width_pixels(a0)
		move.b	#$10,height_pixels(a0)
		move.w	x_pos(a0),$3A(a0)
		move.w	y_pos(a0),$3C(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		subi.b	#$41,d0
		bcc.s	loc_5EDE6
		moveq	#0,d0

loc_5EDE6:
		add.w	d0,d0
		move.w	off_5EDF0(pc,d0.w),d0
		jmp	off_5EDF0(pc,d0.w)
; ---------------------------------------------------------------------------
off_5EDF0:
		dc.w loc_5EDFE-off_5EDF0
		dc.w loc_5EE18-off_5EDF0
		dc.w loc_5EE3C-off_5EDF0
		dc.w loc_5EE5E-off_5EDF0
		dc.w loc_5EE86-off_5EDF0
		dc.w loc_5EE86-off_5EDF0
		dc.w loc_5EE86-off_5EDF0
; ---------------------------------------------------------------------------

loc_5EDFE:
		move.l	#loc_5EEC4,(a0)
		bset	#2,render_flags(a0)
		move.w	(Camera_Y_pos_copy).w,$3A(a0)
		bclr	#7,art_tile(a0)
		rts
; ---------------------------------------------------------------------------

loc_5EE18:
		move.l	#loc_5EF28,(a0)
		move.b	#4,mapping_frame(a0)
		move.b	$2D(a0),d0
		move.b	d0,$24(a0)
		cmpi.w	#3,(Player_mode).w
		bne.s	locret_5EE3A
		bset	#2,render_flags(a0)

locret_5EE3A:
		rts
; ---------------------------------------------------------------------------

loc_5EE3C:
		move.l	#loc_5EF5C,(a0)
		move.b	#$1A,mapping_frame(a0)
		move.l	#AniRaw_60281,$30(a0)
		tst.b	$2D(a0)
		beq.s	locret_5EE5C
		move.b	#$18,$24(a0)

locret_5EE5C:
		rts
; ---------------------------------------------------------------------------

loc_5EE5E:
		move.l	#loc_5EF5C,(a0)
		move.b	#$1A,mapping_frame(a0)
		move.l	#AniRaw_60289,$30(a0)
		tst.b	subtype(a0)
		cmpi.b	#8,$2D(a0)
		blo.s	locret_5EE84
		move.b	#$10,$24(a0)

locret_5EE84:
		rts
; ---------------------------------------------------------------------------

loc_5EE86:
		bclr	#7,art_tile(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		subi.b	#$45,d0
		lsl.w	#2,d0
		move.l	off_5EEB8(pc,d0.w),$30(a0)
		move.l	#loc_5EF5C,(a0)
		bset	#2,render_flags(a0)
		tst.b	$2D(a0)
		beq.s	locret_5EEB6
		move.b	#$C,$24(a0)

locret_5EEB6:
		rts
; ---------------------------------------------------------------------------
off_5EEB8:
		dc.l AniRaw_6028F
		dc.l AniRaw_60295
		dc.l AniRaw_6029B
; ---------------------------------------------------------------------------

loc_5EEC4:
		move.w	(Camera_Y_pos_copy).w,d0
		sub.w	$3A(a0),d0
		cmpi.w	#$10,d0
		blt.s	loc_5EF04
		move.l	#loc_5EF08,(a0)
		bclr	#2,render_flags(a0)
		move.w	#$10,y_vel(a0)
		move.w	x_pos(a0),d0
		sub.w	(Camera_X_pos_copy).w,d0
		addi.w	#$80,d0
		move.w	d0,x_pos(a0)
		move.w	y_pos(a0),d0
		sub.w	(Camera_Y_pos_copy).w,d0
		addi.w	#$80,d0
		move.w	d0,y_pos(a0)

loc_5EF04:
		bra.w	loc_5EF0E
; ---------------------------------------------------------------------------

loc_5EF08:
		jsr	(MoveSprite2).l

loc_5EF0E:
		lea	AniRaw_60276(pc),a1
		jsr	(Animate_RawNoSST).l
		btst	#0,(V_int_run_count+3).w
		bne.w	locret_5FF1A
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_5EF28:
		lea	AniRaw_6027C(pc),a1
		jsr	(Animate_RawNoSST).l
		cmpi.w	#3,(Player_mode).w
		beq.s	loc_5EF3E
		bsr.w	sub_5FE48

loc_5EF3E:
		btst	#3,(_unkFAB8).w
		bne.s	loc_5EF56
		btst	#6,$38(a0)
		bne.w	locret_5FF1A
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_5EF56:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_5EF5C:
		jsr	(Animate_Raw).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_5EF68:
		move.l	#loc_5F144,(a0)
		move.w	#$1FF,$2E(a0)
		clr.b	(Super_palette_status).w
		move.w	(Player_mode).w,d0
		moveq	#0,d1
		andi.w	#3,d0
		subq.w	#2,d0
		bmi.s	loc_5EF90
		beq.s	loc_5EF8C
		addi.w	#$30,d1

loc_5EF8C:
		addi.w	#$30,d1

loc_5EF90:
		tst.w	(SK_alone_flag).w
		bne.s	loc_5EF9A
		addi.w	#$18,d1

loc_5EF9A:
		tst.b	(_unkFA88).w
		bmi.s	loc_5EFAA
		beq.s	loc_5EFA6
		addi.w	#8,d1

loc_5EFA6:
		addi.w	#8,d1

loc_5EFAA:
		lea	off_5EFB6(pc,d1.w),a1
		movea.l	(a1)+,a2
		move.l	(a1)+,$34(a0)
		jmp	(a2)
; ---------------------------------------------------------------------------
off_5EFB6:
		dc.l loc_5F046, loc_5F0E2
		dc.l loc_5F046, loc_5F106
		dc.l loc_5F046, loc_5F106
		dc.l loc_5F05C, loc_5F0E2
		dc.l loc_5F05C, loc_5F106
		dc.l loc_5F05C, loc_5F116
		dc.l loc_5F05C, loc_5F0E2
		dc.l loc_5F05C, loc_5F106
		dc.l loc_5F05C, loc_5F116
		dc.l loc_5F05C, loc_5F0E2
		dc.l loc_5F05C, loc_5F106
		dc.l loc_5F05C, loc_5F116
		dc.l loc_5F090, loc_5F126
		dc.l loc_5F072, loc_5F0DA
		dc.l loc_5F072, loc_5F0DA
		dc.l loc_5F0C4, loc_5F126
		dc.l loc_5F0A6, loc_5F0DA
		dc.l loc_5F0A6, loc_5F116
; ---------------------------------------------------------------------------

loc_5F046:
		jsr	(AllocateObject).l
		bne.s	locret_5F05A
		move.l	#loc_5F1AC,(a1)
		move.b	#4,subtype(a1)

locret_5F05A:
		rts
; ---------------------------------------------------------------------------

loc_5F05C:
		jsr	(AllocateObject).l
		bne.s	locret_5F070
		move.l	#loc_5F20A,(a1)
		move.b	#4,subtype(a1)

locret_5F070:
		rts
; ---------------------------------------------------------------------------

loc_5F072:
		jsr	(AllocateObject).l
		bne.s	loc_5F080
		move.l	#loc_5F480,(a1)

loc_5F080:
		jsr	(AllocateObject).l
		bne.s	locret_5F08E
		move.l	#loc_5F1AC,(a1)

locret_5F08E:
		rts
; ---------------------------------------------------------------------------

loc_5F090:
		jsr	(AllocateObject).l
		bne.s	locret_5F0A4
		move.l	#loc_5F1AC,(a1)
		move.b	#8,subtype(a1)

locret_5F0A4:
		rts
; ---------------------------------------------------------------------------

loc_5F0A6:
		jsr	(AllocateObject).l
		bne.s	loc_5F0B4
		move.l	#loc_5F480,(a1)

loc_5F0B4:
		jsr	(AllocateObject).l
		bne.s	locret_5F0C2
		move.l	#loc_5F20A,(a1)

locret_5F0C2:
		rts
; ---------------------------------------------------------------------------

loc_5F0C4:
		jsr	(AllocateObject).l
		bne.s	locret_5F0D8
		move.l	#loc_5F20A,(a1)
		move.b	#8,subtype(a1)

locret_5F0D8:
		rts
; ---------------------------------------------------------------------------

loc_5F0DA:
		move.b	#0,(Game_mode).w
		rts
; ---------------------------------------------------------------------------

loc_5F0E2:
		jsr	(AllocateObject).l
		bne.s	loc_5F0F0
		move.l	#loc_5F566,(a1)

loc_5F0F0:
		jsr	(AllocateObject).l
		bne.s	locret_5F104
		move.l	#loc_5F8C6,(a1)
		move.b	#4,subtype(a1)

locret_5F104:
		rts
; ---------------------------------------------------------------------------

loc_5F106:
		jsr	(AllocateObject).l
		bne.s	locret_5F114
		move.l	#loc_5F5C2,(a1)

locret_5F114:
		rts
; ---------------------------------------------------------------------------

loc_5F116:
		jsr	(AllocateObject).l
		bne.s	locret_5F124
		move.l	#loc_5FD5A,(a1)

locret_5F124:
		rts
; ---------------------------------------------------------------------------

loc_5F126:
		jsr	(AllocateObject).l
		bne.s	loc_5F134
		move.l	#loc_5F71E,(a1)

loc_5F134:
		jsr	(AllocateObject).l
		bne.s	locret_5F142
		move.l	#loc_5F8C6,(a1)

locret_5F142:
		rts
; ---------------------------------------------------------------------------

loc_5F144:
		subq.w	#1,$2E(a0)
		bmi.s	loc_5F15A
		cmpi.w	#$40,$2E(a0)
		bne.s	locret_5F158
		bset	#2,(_unkFAB8).w

locret_5F158:
		rts
; ---------------------------------------------------------------------------

loc_5F15A:
		move.l	#loc_5F18A,(a0)
		st	(Palette_cycle_counters+$00).w
		jsr	(AllocateObject).l
		bne.s	locret_5F158
		move.w	a1,$44(a0)
		move.l	#Obj_FadeSelectedToBlack,(a1)
		move.w	#5,$3A(a1)
		move.w	#$3F,$3C(a1)
		move.w	#Normal_palette,$30(a1)
		rts
; ---------------------------------------------------------------------------

loc_5F18A:
		movea.w	$44(a0),a1
		btst	#7,status(a1)
		beq.w	locret_5FF1A
		move.l	#locret_5F1AA,(a0)
		bset	#3,(_unkFAB8).w
		movea.l	$34(a0),a1
		jmp	(a1)
; ---------------------------------------------------------------------------

locret_5F1AA:
		rts
; ---------------------------------------------------------------------------

loc_5F1AC:
		lea	ObjDat3_60118(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_5F1F6,(a0)
		lea	word_5F1EA(pc),a1
		bsr.w	sub_5FF1C
		lea	(Pal_EndingSKLogo).l,a1
		lea	(Target_palette_line_2).w,a2
		moveq	#bytesToLcnt($20),d6

loc_5F1D0:
		move.l	(a1)+,(a2)+
		dbf	d6,loc_5F1D0
		jsr	(AllocateObject).l
		bne.s	locret_5F1E8
		move.l	#loc_5F4FA,(a1)
		move.w	a0,parent3(a1)

locret_5F1E8:
		rts
; ---------------------------------------------------------------------------
word_5F1EA:
		dc.w   $120,   $B0
		dc.w    $E0,   $B8
		dc.w   $120,   $F0
; ---------------------------------------------------------------------------

loc_5F1F6:
		btst	#3,(_unkFAB8).w
		bne.s	loc_5F204
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_5F204:
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

loc_5F20A:
		lea	ObjDat3_60124(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_5F1F6,(a0)
		lea	word_5F260(pc),a1
		bsr.w	sub_5FF1C
		lea	(Pal_EndingS3KLogo).l,a1
		lea	(Target_palette_line_2).w,a2
		moveq	#bytesToLcnt($20),d6

loc_5F22E:
		move.l	(a1)+,(a2)+
		dbf	d6,loc_5F22E
		jsr	(AllocateObject).l
		bne.s	loc_5F246
		move.l	#loc_5F526,(a1)
		move.w	a0,parent3(a1)

loc_5F246:
		jsr	(AllocateObject).l
		bne.s	locret_5F25E
		move.l	#loc_5F4FA,(a1)
		move.w	a0,parent3(a1)
		move.b	#2,subtype(a1)

locret_5F25E:
		rts
; ---------------------------------------------------------------------------
word_5F260:
		dc.w   $120,   $B0
		dc.w    $D0,   $B8
		dc.w   $120,   $F0
; ---------------------------------------------------------------------------

loc_5F26C:
		lea	ObjDat3_60154(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_5F1F6,(a0)
		tst.b	subtype(a0)
		beq.s	loc_5F294
		move.l	#loc_5F2EA,(a0)
		move.w	#$4AF,$2E(a0)
		bclr	#2,(_unkFAB8).w

loc_5F294:
		lea	word_5F2E2(pc),a1
		bsr.w	sub_5FF1C
		lea	(Pal_EndingS3KLogo).l,a1
		lea	(Target_palette_line_2).w,a2
		moveq	#bytesToLcnt($20),d6

loc_5F2A8:
		move.l	(a1)+,(a2)+
		dbf	d6,loc_5F2A8
		jsr	(AllocateObject).l
		bne.s	loc_5F2C6
		move.l	#loc_5F4FA,(a1)
		move.w	a0,parent3(a1)
		move.b	#4,subtype(a1)

loc_5F2C6:
		jsr	(AllocateObject).l
		bne.s	loc_5F2D8
		move.l	#loc_5F546,(a1)
		move.w	a0,parent3(a1)

loc_5F2D8:
		lea	ChildObjDat_601F0(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------
word_5F2E2:
		dc.w   $120,   $F0
		dc.w   $120,   $F0
; ---------------------------------------------------------------------------

loc_5F2EA:
		cmpi.w	#$40,$2E(a0)
		bne.s	loc_5F2F8
		bset	#2,(_unkFAB8).w

loc_5F2F8:
		btst	#button_start,(Ctrl_1_held).w
		bne.s	loc_5F314
		btst	#button_start,(Ctrl_2_held).w
		bne.s	loc_5F314
		subq.w	#1,$2E(a0)
		bmi.s	loc_5F314
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_5F314:
		move.b	#0,(Game_mode).w
		rts
; ---------------------------------------------------------------------------

loc_5F31C:
		lea	word_60160(pc),a1
		jsr	(SetUp_ObjAttributes2).l
		bclr	#2,render_flags(a0)
		move.l	#loc_5F376,(a0)
		lea	byte_5F36E(pc),a1
		bsr.w	sub_5FEFE
		lea	(Pal_SonicTails).l,a1
		lea	(Target_palette).w,a2
		moveq	#bytesToLcnt($20),d6

loc_5F346:
		move.l	(a1)+,(a2)+
		dbf	d6,loc_5F346
		jsr	(AllocateObject).l
		bne.s	locret_5F36C
		move.l	#loc_5FF62,(a1)
		move.w	#Normal_palette+2,$30(a1)
		move.w	#Target_palette+2,$32(a1)
		move.w	#$E,$3A(a1)

locret_5F36C:
		rts
; ---------------------------------------------------------------------------
byte_5F36E:
		dc.b    0, $40
		dc.b    0, $40
		dc.b -$1C, $2C
		dc.b -$1C, $2C
		even
; ---------------------------------------------------------------------------

loc_5F376:
		lea	AniRaw_6025C(pc),a1
		jsr	(Animate_RawNoSST).l
		btst	#2,(_unkFAB8).w
		beq.s	loc_5F398
		move.l	#loc_5F39E,(a0)
		lea	AniRaw_60260(pc),a1
		jsr	(Set_Raw_Animation).l

loc_5F398:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_5F39E:
		jsr	(Animate_Raw).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_5F3AA:
		lea	word_60168(pc),a1
		jsr	(SetUp_ObjAttributes2).l
		bclr	#2,render_flags(a0)
		move.l	#loc_5F3DA,(a0)
		lea	byte_5F3D2(pc),a1
		bsr.w	sub_5FEFE
		lea	ChildObjDat_60204(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------
byte_5F3D2:
		dc.b  $24, $2C
		dc.b  $24, $2C
		dc.b    8, $40
		dc.b  $24, $2C
		even
; ---------------------------------------------------------------------------

loc_5F3DA:
		lea	AniRaw_6026B(pc),a1
		jsr	(Animate_RawNoSST).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_5F3EA:
		lea	word_60170(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		bclr	#2,render_flags(a0)
		move.l	#loc_5F400,(a0)

loc_5F400:
		lea	AniRaw_6026F(pc),a1
		jsr	(Animate_RawNoSST).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_5F410:
		lea	ObjDat3_60176(pc),a1
		jsr	(SetUp_ObjAttributes).l
		bclr	#2,render_flags(a0)
		move.l	#loc_5F46A,(a0)
		lea	byte_5F462(pc),a1
		bsr.w	sub_5FEFE
		lea	(Pal_EndingEyecatchKnuckles).l,a1
		lea	(Target_palette_line_3).w,a2
		moveq	#bytesToLcnt($20),d6

loc_5F43A:
		move.l	(a1)+,(a2)+
		dbf	d6,loc_5F43A
		jsr	(AllocateObject).l
		bne.s	locret_5F460
		move.l	#loc_5FF62,(a1)
		move.w	#Normal_palette_line_3+2,$30(a1)
		move.w	#Target_palette_line_3+2,$32(a1)
		move.w	#$E,$3A(a1)

locret_5F460:
		rts
; ---------------------------------------------------------------------------
byte_5F462:
		dc.b -$1C, $2C
		dc.b -$1C, $2C
		dc.b  $1C, $2C
		dc.b    0, $40
		even
; ---------------------------------------------------------------------------

loc_5F46A:
		lea	(byte_66771).l,a1
		jsr	(Animate_Raw2NoSSTMultiDelay).l
		bsr.w	KnucklesEnding_Load_PLC
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_5F480:
		move.l	#loc_5F4E4,(a0)
		move.l	#Map_KnuxEndPose,mappings(a0)
		move.w	#make_art_tile($2C1,0,0),art_tile(a0)
		move.w	#$100,priority(a0)
		move.b	#$40,width_pixels(a0)
		move.b	#$40,height_pixels(a0)
		move.w	#$120,x_pos(a0)
		move.w	#$108,y_pos(a0)
		move.l	#AniRaw_602CA,$30(a0)
		lea	(Pal_KnuxEndPose).l,a1
		lea	(Normal_palette).w,a2
		moveq	#bytesToLcnt($20),d6

loc_5F4C6:
		move.l	(a1)+,(a2)+
		dbf	d6,loc_5F4C6
		tst.b	(_unkFA88).w
		beq.s	locret_5F4E2
		bmi.s	locret_5F4E2
		jsr	(AllocateObject).l
		bne.s	locret_5F4E2
		move.l	#loc_5FBA0,(a1)

locret_5F4E2:
		rts
; ---------------------------------------------------------------------------

loc_5F4E4:
		btst	#3,(_unkFAB8).w
		bne.w	loc_5F204
		jsr	(Animate_Raw).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_5F4FA:
		tst.b	(Graphics_flags).w
		bpl.w	loc_5EC36
		lea	ObjDat3_60130(pc),a1
		jsr	(SetUp_ObjAttributes).l
		bclr	#2,render_flags(a0)
		move.l	#Child_Draw_Sprite,(a0)
		lea	byte_5F520(pc),a1
		bra.w	loc_5FFD4
; ---------------------------------------------------------------------------
byte_5F520:
		dc.b  $48,   8
		dc.b  $34,-$10
		dc.b  $48,-$34
		even
; ---------------------------------------------------------------------------

loc_5F526:
		lea	ObjDat3_6013C(pc),a1
		jsr	(SetUp_ObjAttributes).l
		bclr	#2,render_flags(a0)
		move.l	#Child_Draw_Sprite,(a0)
		lea	byte_5F544(pc),a1
		bra.w	loc_5FFD4
; ---------------------------------------------------------------------------
byte_5F544:
		dc.b    0, $14
		even
; ---------------------------------------------------------------------------

loc_5F546:
		lea	ObjDat3_60148(pc),a1
		jsr	(SetUp_ObjAttributes).l
		bclr	#2,render_flags(a0)
		move.l	#Child_Draw_Sprite,(a0)
		lea	byte_5F564(pc),a1
		bra.w	loc_5FFD4
; ---------------------------------------------------------------------------
byte_5F564:
		dc.b    0, $48
		even
; ---------------------------------------------------------------------------

loc_5F566:
		lea	ObjDat3_6018E(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_5F5B4,(a0)
		bclr	#2,render_flags(a0)
		move.w	#$110,x_pos(a0)
		move.w	#$F0,y_pos(a0)
		move.w	#$4AF,$2E(a0)
		lea	(Pal_EndingEyecatchEggman).l,a1
		lea	(Target_palette_line_2).w,a2
		moveq	#bytesToLcnt($20),d6

loc_5F59A:
		move.l	(a1)+,(a2)+
		dbf	d6,loc_5F59A
		bsr.w	sub_5FDA4
		lea	(ArtKosM_RobotnikSmug).l,a1
		move.w	#tiles_to_bytes($300),d2
		jmp	(Queue_Kos_Module).l
; ---------------------------------------------------------------------------

loc_5F5B4:
		lea	AniRaw_602C6(pc),a1
		jsr	(Animate_RawNoSST).l
		bra.w	loc_5F2F8
; ---------------------------------------------------------------------------

loc_5F5C2:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_5F5D6(pc,d0.w),d1
		jsr	off_5F5D6(pc,d1.w)
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
off_5F5D6:
		dc.w loc_5F5DE-off_5F5D6
		dc.w loc_5F654-off_5F5D6
		dc.w loc_5F66A-off_5F5D6
		dc.w loc_5F682-off_5F5D6
; ---------------------------------------------------------------------------

loc_5F5DE:
		lea	ObjDat3_6019A(pc),a1
		jsr	(SetUp_ObjAttributes).l
		bclr	#2,render_flags(a0)
		move.w	#$120,x_pos(a0)
		move.w	#$108,y_pos(a0)
		move.w	#$EF,$2E(a0)
		lea	(Pal_EndingEyecatchEggRobo).l,a1
		lea	(Target_palette_line_2).w,a2
		moveq	#bytesToLcnt($20),d6

loc_5F60C:
		move.l	(a1)+,(a2)+
		dbf	d6,loc_5F60C
		bsr.w	sub_5FDA4
		lea	ChildObjDat_60220(pc),a2
		jsr	(CreateChild1_Normal).l
		jsr	(AllocateObject).l
		bne.s	loc_5F644
		move.w	a1,parent3(a1)
		move.l	#loc_862B4,(a1)
		move.w	#$120,x_pos(a1)
		move.w	#$124,y_pos(a1)
		move.b	#$8A,subtype(a1)

loc_5F644:
		lea	(ArtKosM_EggRoboSKEnding).l,a1
		move.w	#tiles_to_bytes($300),d2
		jmp	(Queue_Kos_Module).l
; ---------------------------------------------------------------------------

loc_5F654:
		btst	#2,$38(a0)
		beq.s	locret_5F668
		move.b	#4,routine(a0)
		move.w	#$1F,$2E(a0)

locret_5F668:
		rts
; ---------------------------------------------------------------------------

loc_5F66A:
		subq.w	#1,y_pos(a0)
		subq.w	#1,$2E(a0)
		bpl.s	locret_5F680
		move.b	#6,routine(a0)
		move.w	#$4AF,$2E(a0)

locret_5F680:
		rts
; ---------------------------------------------------------------------------

loc_5F682:
		lea	AniRaw_602C2(pc),a1
		jsr	(Animate_RawNoSST).l
		bra.w	loc_5F2F8
; ---------------------------------------------------------------------------

loc_5F690:
		lea	word_601A6(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#Draw_Sprite,(a0)
		bclr	#2,render_flags(a0)
		rts
; ---------------------------------------------------------------------------

loc_5F6A8:
		lea	word_601AC(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		bclr	#2,render_flags(a0)
		move.l	#loc_5F6C4,(a0)
		move.w	#(2*60)-1,$2E(a0)

loc_5F6C4:
		subq.w	#1,$2E(a0)
		bpl.s	locret_5F6D8
		move.l	#loc_5F6DA,(a0)
		move.l	#loc_5F6EA,$34(a0)

locret_5F6D8:
		rts
; ---------------------------------------------------------------------------

loc_5F6DA:
		lea	AniRaw_602A7(pc),a1
		jsr	(Animate_RawNoSSTMultiDelay).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_5F6EA:
		move.l	#loc_5F6FC,(a0)
		movea.w	parent3(a0),a1
		bset	#2,$38(a1)
		rts
; ---------------------------------------------------------------------------

loc_5F6FC:
		move.b	#-$14,child_dy(a0)
		movea.w	parent3(a0),a1
		tst.b	mapping_frame(a1)
		beq.s	loc_5F712
		move.b	#-$13,child_dy(a0)

loc_5F712:
		jsr	(Refresh_ChildPosition).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_5F71E:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_5F73E(pc,d0.w),d1
		jsr	off_5F73E(pc,d1.w)
		lea	(DPLCPtr_MechaSonic).l,a2
		jsr	(Perform_DPLC).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
off_5F73E:
		dc.w loc_5F74E-off_5F73E
		dc.w loc_5F7CC-off_5F73E
		dc.w loc_5F802-off_5F73E
		dc.w loc_5F82C-off_5F73E
		dc.w loc_5F82C-off_5F73E
		dc.w loc_5F85A-off_5F73E
		dc.w loc_5F82C-off_5F73E
		dc.w loc_5F8A8-off_5F73E
; ---------------------------------------------------------------------------

loc_5F74E:
		clr.w	(Slotted_object_bits).w
		lea	(ObjSlot_MechaSonic).l,a1
		jsr	(SetUp_ObjAttributesSlotted).l
		bclr	#2,render_flags(a0)
		bset	#7,art_tile(a0)
		move.b	#$F,mapping_frame(a0)
		move.w	#$120,x_pos(a0)
		move.w	#$F8,y_pos(a0)
		move.w	#$EF,$2E(a0)
		lea	(Pal_SSZGHZMisc).l,a1
		lea	(Target_palette_line_2).w,a2
		moveq	#bytesToLcnt($20),d6

loc_5F78E:
		move.l	(a1)+,(a2)+
		dbf	d6,loc_5F78E
		bsr.w	sub_5FDA4
		lea	(ChildObjDat_7D48C).l,a2
		jsr	(CreateChild6_Simple).l
		bne.s	loc_5F7AC
		move.b	#$80,subtype(a1)

loc_5F7AC:
		lea	(word_7D842).l,a1
		lea	(Palette_rotation_data).w,a2
		move.l	(a1)+,(a2)+
		move.l	(a1)+,(a2)+
		clr.w	(a2)
		lea	(ArtKosM_MechaSonicExtra).l,a1
		move.w	#tiles_to_bytes($41C),d2
		jmp	(Queue_Kos_Module).l
; ---------------------------------------------------------------------------

loc_5F7CC:
		subq.w	#1,$2E(a0)
		bmi.s	loc_5F7D8
		jmp	(Run_PalRotationScript).l
; ---------------------------------------------------------------------------

loc_5F7D8:
		move.b	#4,routine(a0)
		lea	(Pal_SSZGHZMisc).l,a1
		lea	(Normal_palette_line_2).w,a2
		moveq	#bytesToLcnt($20),d6

loc_5F7EA:
		move.l	(a1)+,(a2)+
		dbf	d6,loc_5F7EA
		bset	#6,$38(a0)
		lea	(ChildObjDat_7D492).l,a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_5F802:
		btst	#6,$38(a0)
		bne.w	locret_5FF1A
		move.b	#6,routine(a0)
		move.b	#$E,mapping_frame(a0)
		move.l	#loc_5F832,$34(a0)
		lea	(byte_7D5EF).l,a1
		jmp	(Set_Raw_Animation).l
; ---------------------------------------------------------------------------

loc_5F82C:
		jmp	(Animate_RawMultiDelay).l
; ---------------------------------------------------------------------------

loc_5F832:
		move.b	#8,routine(a0)
		move.l	#loc_5F84C,$34(a0)
		lea	(byte_7D5F6).l,a1
		jmp	(Set_Raw_Animation).l
; ---------------------------------------------------------------------------

loc_5F84C:
		move.b	#$A,routine(a0)
		move.w	#-$400,y_vel(a0)
		rts
; ---------------------------------------------------------------------------

loc_5F85A:
		jsr	(MoveSprite_LightGravity).l
		tst.w	y_vel(a0)
		bmi.w	locret_5FF1A
		cmpi.w	#$C8,y_pos(a0)
		blo.w	locret_5FF1A
		move.b	#$C,routine(a0)
		move.w	#$CC,y_pos(a0)
		move.l	#loc_5F89A,$34(a0)
		moveq	#signextendB(sfx_MechaLand),d0
		jsr	(Play_SFX).l
		lea	(byte_7D5AB).l,a1
		jmp	(Set_Raw_Animation).l
; ---------------------------------------------------------------------------

loc_5F89A:
		move.b	#$E,routine(a0)
		move.w	#$4AF,$2E(a0)
		rts
; ---------------------------------------------------------------------------

loc_5F8A8:
		btst	#button_start,(Ctrl_1_held).w
		bne.s	loc_5F8BE
		btst	#button_start,(Ctrl_2_held).w
		bne.s	loc_5F8BE
		subq.w	#1,$2E(a0)
		bpl.s	locret_5F8C4

loc_5F8BE:
		move.b	#0,(Game_mode).w

locret_5F8C4:
		rts
; ---------------------------------------------------------------------------

loc_5F8C6:
		lea	ObjDat3_60182(pc),a1
		jsr	(SetUp_ObjAttributes).l
		bclr	#2,render_flags(a0)
		move.l	#loc_5F946,(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		lea	word_5F93E(pc,d0.w),a1
		move.w	(a1)+,x_pos(a0)
		move.w	(a1)+,y_pos(a0)
		lea	(Pal_EndingMasterEmerald).l,a1
		lea	(Target_palette).w,a2
		moveq	#bytesToLcnt($20),d6

loc_5F8FA:
		move.l	(a1)+,(a2)+
		dbf	d6,loc_5F8FA
		jsr	(AllocateObject).l
		bne.s	loc_5F92E
		move.w	a1,$44(a0)
		move.l	#Obj_FadeSelectedFromBlack,(a1)
		moveq	#5,d0
		move.w	d0,$3A(a1)
		move.w	d0,$2E(a1)
		move.w	#$F,$3C(a1)
		move.w	#Normal_palette,$30(a1)
		move.w	#Target_palette,$32(a1)

loc_5F92E:
		lea	(ArtKosM_EndingMasterEmerald).l,a1
		move.w	#tiles_to_bytes($52E),d2
		jmp	(Queue_Kos_Module).l
; ---------------------------------------------------------------------------
word_5F93E:
		dc.w   $120,  $100
		dc.w   $130,   $F4
; ---------------------------------------------------------------------------

loc_5F946:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_5F94C:
		move.l	#loc_5F986,(a0)
		move.l	(V_int_run_count).w,(RNG_seed).w
		lea	(Pal_FBZCloud).l,a1
		lea	(Normal_palette).w,a2
		cmpi.w	#3,(Player_mode).w
		beq.s	loc_5F96E
		lea	(Normal_palette_line_2).w,a2

loc_5F96E:
		moveq	#bytesToLcnt($10),d0

loc_5F970:
		move.l	(a1)+,(a2)+
		dbf	d0,loc_5F970
		lea	(ArtKosM_FBZCloud).l,a1
		move.w	#tiles_to_bytes($3B6),d2
		jmp	(Queue_Kos_Module).l
; ---------------------------------------------------------------------------

loc_5F986:
		tst.b	(_unkFAB9).w
		beq.w	loc_5EC36
		move.b	(V_int_run_count+3).w,d0
		and.b	(_unkFAB9).w,d0
		bne.w	locret_5FA56
		addq.b	#1,$39(a0)
		jsr	(AllocateObject).l
		bne.w	locret_5FA56
		jsr	(Random_Number).l
		move.l	#loc_5FA58,(a1)
		move.b	d0,subtype(a1)
		move.w	(_unkFAC2).w,d2
		beq.s	loc_5F9D0
		move.w	d0,d1
		andi.w	#$3F,d1
		tst.w	d2
		bpl.s	loc_5F9CA
		neg.w	d1

loc_5F9CA:
		add.w	d2,d1
		move.w	d1,x_vel(a1)

loc_5F9D0:
		move.w	(_unkFAC4).w,d3
		beq.s	loc_5F9EA
		move.l	d0,d1
		swap	d1
		andi.w	#$3F,d1
		tst.w	d3
		bpl.s	loc_5F9E4
		neg.w	d1

loc_5F9E4:
		add.w	d3,d1
		move.w	d1,y_vel(a1)

loc_5F9EA:
		tst.w	d2
		beq.s	loc_5FA1C
		tst.w	d3
		beq.s	loc_5F9FA
		btst	#0,$39(a0)
		bne.s	loc_5FA1C

loc_5F9FA:
		move.w	#$50,d1
		tst.w	d2
		bpl.s	loc_5FA06
		move.w	#$1F0,d1

loc_5FA06:
		move.w	d1,x_pos(a1)
		move.w	d0,d1
		andi.w	#$FF,d1
		addi.w	#$80,d1
		move.w	d1,y_pos(a1)
		bra.w	loc_5FA4A
; ---------------------------------------------------------------------------

loc_5FA1C:
		move.w	#$60,d1
		tst.w	d3
		bpl.s	loc_5FA28
		move.w	#$180,d1

loc_5FA28:
		move.w	d1,y_pos(a1)
		move.w	d0,d1
		andi.w	#$1FF,d1
		move.w	d1,d2
		subi.w	#$160,d2
		bcs.s	loc_5FA42
		add.w	d2,d2
		addi.w	#$10,d2
		move.w	d2,d1

loc_5FA42:
		addi.w	#$70,d1
		move.w	d1,x_pos(a1)

loc_5FA4A:
		moveq	#1,d1
		tst.w	d0
		bpl.s	loc_5FA52
		moveq	#3,d1

loc_5FA52:
		move.b	d1,mapping_frame(a1)

locret_5FA56:
		rts
; ---------------------------------------------------------------------------

loc_5FA58:
		move.l	#loc_5FA8C,(a0)
		move.l	#Map_FBZ2Preboss,mappings(a0)
		move.w	#make_art_tile($3B6,0,0),art_tile(a0)
		cmpi.w	#3,(Player_mode).w
		beq.s	loc_5FA7A
		move.w	#make_art_tile($3B6,1,0),art_tile(a0)

loc_5FA7A:
		move.w	#$300,priority(a0)
		move.b	#$20,width_pixels(a0)
		move.b	#$10,height_pixels(a0)

loc_5FA8C:
		move.w	(_unkFAC2).w,d0
		beq.s	loc_5FAA0
		move.w	x_vel(a0),d1
		add.w	d0,d1
		ext.l	d1
		lsl.l	#8,d1
		add.l	d1,x_pos(a0)

loc_5FAA0:
		move.w	(_unkFAC4).w,d2
		beq.s	loc_5FAB4
		move.w	y_vel(a0),d3
		add.w	d2,d3
		ext.l	d3
		lsl.l	#8,d3
		add.l	d3,y_pos(a0)

loc_5FAB4:
		cmpi.w	#$200,x_pos(a0)
		bhs.w	loc_5EC36
		cmpi.w	#$200,y_pos(a0)
		bhs.w	loc_5EC36
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_Difficulty_SKLogo:
		move.l	#Map_SKPoseBanner,mappings(a0)
		move.w	#make_art_tile($180,3,0),art_tile(a0)
		move.w	#$280,priority(a0)
		move.b	#$40,width_pixels(a0)
		move.b	#$14,height_pixels(a0)
		move.l	#loc_5FB14,(a0)
		move.w	#$120,x_pos(a0)
		move.w	#$A0,y_pos(a0)
		jsr	(AllocateObject).l
		bne.s	locret_5FB12
		move.l	#loc_5FB1A,(a1)
		move.w	a0,parent3(a1)

locret_5FB12:
		rts
; ---------------------------------------------------------------------------

loc_5FB14:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_5FB1A:
		tst.b	(Graphics_flags).w
		bpl.w	loc_5EC36
		move.l	#Map_ANDKnuckles,mappings(a0)
		move.w	#make_art_tile($1C8,3,0),art_tile(a0)
		move.w	#$280,priority(a0)
		move.b	#8,width_pixels(a0)
		move.b	#4,height_pixels(a0)
		move.b	#2,mapping_frame(a0)
		move.l	#Child_Draw_Sprite,(a0)
		lea	byte_5F520(pc),a1
		bra.w	loc_5FFD4
; ---------------------------------------------------------------------------

Obj_Difficulty_Eggman:
		move.l	#Map_EndingEyecatchEggman,mappings(a0)
		move.w	#make_art_tile($232,1,0),art_tile(a0)
		bset	#0,render_flags(a0)
		move.w	#$280,priority(a0)
		move.b	#$20,width_pixels(a0)
		move.b	#$20,height_pixels(a0)
		move.l	#loc_5FB90,(a0)
		move.w	#$168,x_pos(a0)
		move.w	#$108,y_pos(a0)
		rts
; ---------------------------------------------------------------------------

loc_5FB90:
		lea	AniRaw_602C6(pc),a1
		jsr	(Animate_RawNoSST).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_5FBA0:
		tst.b	(Palette_cycle_counters+$00).w
		bne.w	loc_5EC36
		subq.b	#1,anim_frame_timer(a0)
		bpl.w	locret_5FBE0
		move.b	#2,anim_frame_timer(a0)
		lea	Pal_KnuxEndPoseSuper(pc),a1
		move.w	$3A(a0),d0
		addq.w	#6,d0
		cmpi.w	#$3C,d0
		blo.s	loc_5FBCE
		moveq	#0,d0
		move.b	#$E,anim_frame_timer(a0)

loc_5FBCE:
		move.w	d0,$3A(a0)
		lea	(Normal_palette+$4).w,a2
		move.l	(a1,d0.w),(a2)+
		move.w	4(a1,d0.w),2(a2)

locret_5FBE0:
		rts
; ---------------------------------------------------------------------------
Pal_KnuxEndPoseSuper:
		binclude "General/Ending/Palettes/Super Knuckles End Pose.bin"
		even
; ---------------------------------------------------------------------------

loc_5FC1E:
		move.b	#2,$39(a0)
		move.l	#loc_5FC2A,(a0)

loc_5FC2A:
		subq.w	#1,$2E(a0)
		bpl.s	locret_5FC4C
		move.w	#5,$2E(a0)
		lea	(Normal_palette_line_3+$2).w,a1
		moveq	#$F-1,d0

loc_5FC3C:
		jsr	(sub_85EB4).l
		dbf	d0,loc_5FC3C
		subq.b	#1,$39(a0)
		bmi.s	loc_5FC4E

locret_5FC4C:
		rts
; ---------------------------------------------------------------------------

loc_5FC4E:
		move.l	#loc_5FC62,(a0)
		move.b	#2,$39(a0)
		move.w	#$13,$2E(a0)
		rts
; ---------------------------------------------------------------------------

loc_5FC62:
		subq.w	#1,$2E(a0)
		bpl.s	locret_5FC4C
		move.w	#3,$2E(a0)
		lea	(Normal_palette_line_3+$2).w,a1
		lea	(Target_palette_line_3+$2).w,a2
		moveq	#$F-1,d0

loc_5FC78:
		jsr	(sub_85F2A).l
		dbf	d0,loc_5FC78
		subq.b	#1,$39(a0)
		bpl.s	locret_5FC4C
		jmp	(Go_Delete_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_5FC8E:
		clr.b	(Player_1+anim).w
		move.w	#$24,(Palette_frame).w
		move.b	#1,(Super_Sonic_Knux_flag).w

loc_5FC9E:
		move.b	#-1,(Super_palette_status).w
		move.b	#0,(Palette_timer).w
		move.l	#Map_SuperSonic,(Player_1+mappings).w
		rts
; End of function sub_5FC8E


; =============== S U B R O U T I N E =======================================


sub_5FCB4:
		move.b	#-1,(Super_palette_status).w
		move.w	#0,(Palette_frame).w
		move.b	#0,(Palette_frame_Tails).w
		move.b	#1,(Super_Tails_flag).w
		rts
; End of function sub_5FCB4


; =============== S U B R O U T I N E =======================================


sub_5FCCE:
		move.b	#-1,(Super_Sonic_Knux_flag).w
		move.w	#0,(Palette_frame).w
		bra.s	loc_5FC9E
; End of function sub_5FCCE

; ---------------------------------------------------------------------------

loc_5FCDC:
		move.l	#loc_5FCEC,(a0)
		lea	PalSPtr_EndingSuperTails(pc),a1
		jsr	(sub_7C678).l

loc_5FCEC:
		btst	#3,(_unkFAB8).w
		bne.w	loc_5EC36
		jmp	(Run_PalRotationScript).l
; ---------------------------------------------------------------------------

loc_5FCFC:
		move.l	#loc_5FD16,(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		move.w	byte_5FD4E(pc,d0.w),$3A(a0)
		add.w	d0,d0
		move.l	off_5FD52(pc,d0.w),$30(a0)

loc_5FD16:
		tst.b	(Palette_cycle_counters+$00).w
		bne.w	loc_5EC36
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	locret_5FD4C
		move.b	$3B(a0),anim_frame_timer(a0)
		moveq	#0,d0
		move.b	anim_frame(a0),d0
		addq.b	#6,d0
		cmp.b	$3A(a0),d0
		blo.s	loc_5FD3A
		moveq	#0,d0

loc_5FD3A:
		move.b	d0,anim_frame(a0)
		movea.l	$30(a0),a1
		adda.w	d0,a1
		lea	(Normal_palette_line_3+$4).w,a2
		move.l	(a1)+,(a2)+
		move.w	(a1)+,(a2)+

locret_5FD4C:
		rts
; ---------------------------------------------------------------------------
byte_5FD4E:
		dc.b  $18,   6
		dc.b  $48,   4
		even
off_5FD52:
		dc.l PalCycle_SuperSonic+$24
		dc.l PalCycle_HyperSonic
; ---------------------------------------------------------------------------

loc_5FD5A:
		move.l	#loc_5FD66,(a0)
		move.w	#32-1,$2E(a0)

loc_5FD66:
		subq.w	#1,$2E(a0)
		bpl.w	locret_5FF1A
		jsr	(AllocateObject).l
		bne.s	loc_5FD82
		move.l	#loc_5F26C,(a1)
		move.b	#4,subtype(a1)

loc_5FD82:
		jmp	(Delete_Current_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_5FD88:
		lea	(Player_1).w,a1
		move.w	(Player_mode).w,d0
		andi.w	#3,d0
		move.b	byte_5FDA0(pc,d0.w),mapping_frame(a1)
		jmp	(Player_Load_PLC).l
; End of function sub_5FD88

; ---------------------------------------------------------------------------
byte_5FDA0:
		dc.b  $BA
		dc.b  $BA
		dc.b  $AD
		dc.b  $56
		even

; =============== S U B R O U T I N E =======================================


sub_5FDA4:
		jsr	(AllocateObject).l
		bne.s	locret_5FDD2
		move.w	a1,$44(a0)
		move.l	#Obj_FadeSelectedFromBlack,(a1)
		moveq	#5,d0
		move.w	d0,$3A(a1)
		move.w	d0,$2E(a1)
		move.w	#$F,$3C(a1)
		move.w	#Normal_palette_line_2,$30(a1)
		move.w	#Target_palette_line_2,$32(a1)

locret_5FDD2:
		rts
; End of function sub_5FDA4

; ---------------------------------------------------------------------------

Obj_Ending_RevertSuperSonic:
		move.w	#(2*60)-1,$2E(a0)
		move.l	#loc_5FDE0,(a0)

loc_5FDE0:
		subq.w	#1,$2E(a0)
		bpl.s	locret_5FE0E
		move.l	#loc_5FE10,(a0)
		lea	(Player_1).w,a1
		move.b	#$F,anim(a1)
		move.b	#2,(Super_palette_status).w
		move.w	#$1E,(Palette_frame).w
		move.b	#0,(Super_Sonic_Knux_flag).w
		move.b	#0,(Super_Tails_flag).w

locret_5FE0E:
		rts
; ---------------------------------------------------------------------------

loc_5FE10:
		move.l	#Map_Sonic,(Player_1+mappings).w
		jmp	(Delete_Current_Sprite).l

; =============== S U B R O U T I N E =======================================


Create_Continue_Sprite:
		moveq	#0,d3

.loop:
		jsr	(AllocateObject).l
		move.l	#loc_5EDAC,(a1)
		move.b	d1,subtype(a1)
		move.b	d3,$2D(a1)
		move.w	(a2,d3.w),x_pos(a1)
		move.w	2(a2,d3.w),y_pos(a1)
		addq.w	#4,d3
		dbf	d2,.loop
		rts
; End of function Create_Continue_Sprite


; =============== S U B R O U T I N E =======================================


sub_5FE48:
		bclr	#6,$38(a0)
		move.w	$3A(a0),d0
		sub.w	(_unkEE98).w,d0
		addi.w	#$80,d0
		move.w	d0,x_pos(a0)
		cmpi.w	#$200,d0
		bhs.s	loc_5FE7A
		move.w	$3C(a0),d0
		sub.w	(_unkEE9C).w,d0
		addi.w	#$80,d0
		move.w	d0,y_pos(a0)
		cmpi.w	#$200,d0
		blo.s	locret_5FE80

loc_5FE7A:
		bset	#6,$38(a0)

locret_5FE80:
		rts
; End of function sub_5FE48


; =============== S U B R O U T I N E =======================================


sub_5FE82:
		moveq	#0,d0
		lea	(_unkFA82).w,a1
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		moveq	#2,d0
		cmpi.b	#7,(Super_emerald_count).w
		beq.s	loc_5FEA2
		moveq	#0,d0
		cmpi.b	#7,(Chaos_emerald_count).w
		beq.s	loc_5FEA2
		moveq	#-2,d0

loc_5FEA2:
		move.b	d0,(_unkFA88).w
		rts
; End of function sub_5FE82


; =============== S U B R O U T I N E =======================================


KnucklesEnding_Load_PLC:
		moveq	#0,d0
		move.b	mapping_frame(a0),d0
		cmp.b	$3A(a0),d0
		beq.s	.end
		move.b	d0,$3A(a0)
		lea	(PLC_Knuckles).l,a2
		add.w	d0,d0
		adda.w	(a2,d0.w),a2
		move.w	(a2)+,d5
		subq.w	#1,d5
		bmi.s	.end
		move.w	#tiles_to_bytes($5E0),d4
		move.l	#ArtUnc_Knux,d6

.loop:
		moveq	#0,d1
		move.w	(a2)+,d1
		move.w	d1,d3
		lsr.w	#8,d3
		andi.w	#$F0,d3
		addi.w	#$10,d3
		andi.w	#$FFF,d1
		lsl.l	#5,d1
		add.l	d6,d1
		move.w	d4,d2
		add.w	d3,d4
		add.w	d3,d4
		jsr	(Add_To_DMA_Queue).l
		dbf	d5,.loop

.end:
		rts
; End of function KnucklesEnding_Load_PLC


; =============== S U B R O U T I N E =======================================


sub_5FEFE:
		move.w	(Player_mode).w,d0
		andi.w	#3,d0
		add.w	d0,d0
		adda.w	d0,a1
		move.b	(a1)+,d0
		ext.w	d0
		add.w	d0,x_pos(a0)
		move.b	(a1)+,d0
		ext.w	d0
		add.w	d0,y_pos(a0)

locret_5FF1A:
		rts
; End of function sub_5FEFE


; =============== S U B R O U T I N E =======================================


sub_5FF1C:
		moveq	#0,d0
		move.b	subtype(a0),d0
		adda.w	d0,a1
		move.w	(a1)+,x_pos(a0)
		move.w	(a1)+,y_pos(a0)
		bclr	#2,render_flags(a0)
		lea	(Normal_palette_line_2).w,a1
		moveq	#0,d0
		moveq	#bytesToLcnt($20),d1

loc_5FF3A:
		move.l	d0,(a1)+
		dbf	d1,loc_5FF3A
		jsr	(AllocateObject).l
		bne.s	locret_5FF60
		move.l	#loc_5FF62,(a1)
		move.w	#Normal_palette_line_2,$30(a1)
		move.w	#Target_palette_line_2,$32(a1)
		move.w	#$F,$3A(a1)

locret_5FF60:
		rts
; End of function sub_5FF1C

; ---------------------------------------------------------------------------

loc_5FF62:
		move.b	#7,$39(a0)
		move.l	#loc_5FF6E,(a0)

loc_5FF6E:
		subq.w	#1,$2E(a0)
		bpl.s	locret_5FF92
		move.w	#3,$2E(a0)
		movea.w	$30(a0),a1
		move.w	$3A(a0),d0

loc_5FF82:
		jsr	(sub_85EB4).l
		dbf	d0,loc_5FF82
		subq.b	#1,$39(a0)
		bmi.s	loc_5FF94

locret_5FF92:
		rts
; ---------------------------------------------------------------------------

loc_5FF94:
		move.l	#loc_5FFA6,(a0)
		move.b	#7,$39(a0)
		move.w	#3,$2E(a0)

loc_5FFA6:
		subq.w	#1,$2E(a0)
		bpl.s	locret_5FF92
		move.w	#3,$2E(a0)
		movea.w	$30(a0),a1
		movea.w	$32(a0),a2
		move.w	$3A(a0),d0

loc_5FFBE:
		jsr	(sub_85F2A).l
		dbf	d0,loc_5FFBE
		subq.b	#1,$39(a0)
		bpl.s	locret_5FF92
		jmp	(Go_Delete_Sprite).l
; ---------------------------------------------------------------------------

loc_5FFD4:
		moveq	#0,d0
		move.b	subtype(a0),d0
		lea	(a1,d0.w),a1
		movea.w	parent3(a0),a2
		move.b	(a1)+,d0
		ext.w	d0
		move.w	x_pos(a2),d1
		add.w	d0,d1
		move.w	d1,x_pos(a0)
		move.b	(a1)+,d0
		ext.w	d0
		move.w	y_pos(a2),d1
		add.w	d0,d1
		move.w	d1,y_pos(a0)
		rts

; =============== S U B R O U T I N E =======================================


sub_60000:
		move.b	$3C(a0),d0
		addq.b	#4,d0
		move.b	d0,$3C(a0)
		jsr	(GetSineCosine).l
		asr.w	#6,d0
		move.w	$3A(a0),d1
		add.w	d0,d1
		move.w	d1,y_pos(a0)
		rts
; End of function sub_60000


; =============== S U B R O U T I N E =======================================


sub_6001E:
		move.w	#$80,d0
		move.w	d0,$3E(a0)
		move.w	d0,y_vel(a0)
		move.w	#8,$40(a0)
		bclr	#0,$38(a0)
		rts
; End of function sub_6001E


; =============== S U B R O U T I N E =======================================


sub_60038:
		lea	byte_6006E(pc),a1
		jsr	(sub_86458).l
		moveq	#0,d0
		move.b	$44(a0),d0
		addq.b	#1,d0
		cmpi.b	#6,d0
		blo.s	loc_60052
		moveq	#0,d0

loc_60052:
		move.b	d0,$44(a0)
		move.b	byte_60072(pc,d0.w),$1D(a0)
		moveq	#6,d0
		btst	#0,(V_int_run_count+3).w
		beq.s	loc_60068
		moveq	#7,d0

loc_60068:
		move.b	d0,$23(a0)
		rts
; End of function sub_60038

; ---------------------------------------------------------------------------
byte_6006E:
		dc.b  $34,   4, $18, $18
byte_60072:
		dc.b    2,   3,   4,   5,   4,   3
		even
; ---------------------------------------------------------------------------
		move.l	d0,(_unkFA82).w
		add.l	d0,(_unkEE98).w
		move.l	d1,(_unkFA84).w
		add.l	d1,(_unkEE9C).w
		rts

; =============== S U B R O U T I N E =======================================


sub_6008A:
		movea.w	parent3(a0),a1
		moveq	#0,d0
		move.b	mapping_frame(a1),d0
		subq.b	#1,d0
		add.w	d0,d0
		move.w	off_600B0(pc,d0.w),d1
		lea	off_600B0(pc,d1.w),a2
		tst.b	subtype(a0)
		beq.s	loc_600A8
		addq.w	#2,a2

loc_600A8:
		move.w	(a2)+,d0
		move.w	d0,child_dx(a0)	; and child_dy
		rts
; End of function sub_6008A

; ---------------------------------------------------------------------------
off_600B0:
		dc.w byte_600B6-off_600B0
		dc.w byte_600BA-off_600B0
		dc.w byte_600BE-off_600B0
byte_600B6:
		dc.b  -4,   -8
		dc.b $10, -$14
byte_600BA:
		dc.b  -4,   -7
		dc.b $10,  -$C
byte_600BE:
		dc.b  -4,   -4
		dc.b $10,  -$A
ObjDat3_600C2:
		dc.l Map_KnuxEnding
		dc.w make_art_tile($310,0,1)
		dc.w   $200
		dc.b  $20, $20,   5,   0
ObjDat3_600CE:
		dc.l Map_SonicPlane
		dc.w make_art_tile($1E3,0,1)
		dc.w   $200
		dc.b  $40, $20,   1,   0
ObjDat3_600DA:
		dc.l Map_SonicPlaneEnding
		dc.w make_art_tile($26E,0,1)
		dc.w   $200
		dc.b  $20, $14,   0,   0
ObjDat3_600E6:
		dc.l Map_SonicPlaneEnding
		dc.w make_art_tile($26E,0,1)
		dc.w   $200
		dc.b  $C,  $C,   0,   0
word_600F2:
		dc.w   $200
		dc.b   4,   8,   4,   0
word_600F8:
		dc.w   $180
		dc.b  $C,   4, $16,   0
word_600FE:
		dc.w   $200
		dc.b  $40, $10,   9,   0
ObjDat3_60104:
		dc.l Map_SonicPlaneEnding
		dc.w make_art_tile($26E,0,1)
		dc.w   $200
		dc.b  $80, $10,   7,   0
word_60110:
		dc.w make_art_tile($26E,2,0)
		dc.w   $200
		dc.b    4,   4, $11,   0
ObjDat3_60118:
		dc.l Map_SKPoseBanner
		dc.w make_art_tile($415,1,1)
		dc.w   $180
		dc.b  $40, $14,   0,   0
ObjDat3_60124:
		dc.l Map_S3PoseBanner
		dc.w make_art_tile($415,1,1)
		dc.w   $180
		dc.b  $30, $10,   0,   0
ObjDat3_60130:
		dc.l Map_ANDKnuckles
		dc.w make_art_tile($3EF,1,1)
		dc.w   $180
		dc.b    8,   4,   2,   0
ObjDat3_6013C:
		dc.l Map_ANDKnuckles
		dc.w make_art_tile($3EF,1,1)
		dc.w   $180
		dc.b  $20,   4,   0,   0
ObjDat3_60148:
		dc.l Map_ANDKnuckles
		dc.w make_art_tile($3EF,1,1)
		dc.w   $300
		dc.b  $38,   8,   1,   0
ObjDat3_60154:
		dc.l Map_S3EndingGraphics
		dc.w make_art_tile($45D,1,1)
		dc.w   $180
		dc.b  $50, $50,   0,   0
word_60160:
		dc.w make_art_tile($45D,0,1)
		dc.w   $100
		dc.b  $20, $20,   1,   0
word_60168:
		dc.w make_art_tile($45D,0,1)
		dc.w   $100
		dc.b  $20, $20,  $A,   0
word_60170:
		dc.w   $100
		dc.b   $C,  $C,  $A,   0
ObjDat3_60176:
		dc.l Map_Knuckles
		dc.w make_art_tile($5E0,2,1)
		dc.w   $100
		dc.b  $20, $20, $D8,   0
ObjDat3_60182:
		dc.l Map_SSZMasterEmerald
		dc.w make_art_tile($52E,0,1)
		dc.w   $300
		dc.b  $20, $18,   2,   0
ObjDat3_6018E:
		dc.l Map_EndingEyecatchEggman
		dc.w make_art_tile($300,1,1)
		dc.w   $200
		dc.b  $38, $20,   0,   0
ObjDat3_6019A:
		dc.l Map_EndingEyecatchEggRobo
		dc.w make_art_tile($300,1,1)
		dc.w   $200
		dc.b $38, $20,   0,   0
word_601A6:
		dc.w   $180
		dc.b $38, $20,   4,   0
word_601AC:
		dc.w   $180
		dc.b   8,   8,   2,   0
ChildObjDat_601B2:
		dc.w 1-1
		dc.l Obj_5EBC6
		dc.b   4,-$10
ChildObjDat_601BA:
		dc.w 1-1
		dc.l Obj_5EA52
		dc.b -$20, $2B
ChildObjDat_601C2:
		dc.w 1-1
		dc.l Obj_5EB32
		dc.b    0,-$10
ChildObjDat_601CA:
		dc.w 2-1
		dc.l loc_5ECB4
ChildObjDat_601D0:
		dc.w 1-1
		dc.l loc_5EBF0
		dc.b  $1C,   0
ChildObjDat_601D8:
		dc.w 1-1
		dc.l loc_5EC3C
		dc.b  -$A,  $C
ChildObjDat_601E0:
		dc.w 1-1
		dc.l loc_5EC94
		dc.b -$22,  -2
ChildObjDat_601E8:
		dc.w 1-1
		dc.l loc_5DF80
		dc.b -$40,  -4
ChildObjDat_601F0:
		dc.w 3-1
		dc.l loc_5F31C
		dc.b    0,   0
		dc.l loc_5F3AA
		dc.b    0,   0
		dc.l loc_5F410
		dc.b    0,   0
ChildObjDat_60204:
		dc.w 1-1
		dc.l loc_5F3EA
		dc.b -$10,   8
ChildObjDat_6020C:
		dc.w 1-1
		dc.l loc_5ED36
		dc.b -$10,   5
ChildObjDat_60214:
		dc.w 5-1
		dc.l loc_5E504
ChildObjDat_6021A:
		dc.w 2-1
		dc.l loc_5E612
ChildObjDat_60220:
		dc.w 2-1
		dc.l loc_5F690
		dc.b    0,-$10
		dc.l loc_5F6A8
		dc.b    0,-$14
ChildObjDat_6022E:
		dc.w 1-1
		dc.l loc_5ED6A
		dc.b   -6,   7
AniRaw_60236:
		dc.b    5,  $B,   6,   5,   7,  $B,   6,  $B, $FC
AniRaw_6023F:
		dc.b    4, $7F,   4, $7F, $FC
AniRaw_60244:
		dc.b    4,   0,   4, $3F,   1,   5,   2,   5,   3, $3F,   4, $7F,   4, $7F, $FC
AniRaw_60253:
		dc.b    1,  $F,   2,  $F,   3, $7F,   3, $7F, $FC
AniRaw_6025C:
		dc.b   $F,   1,   2, $FC
AniRaw_60260:
		dc.b    7,   1,   1,   3,   4, $F8,   7, $7F,   4,   4, $FC
AniRaw_6026B:
		dc.b   $F,  $A,  $B, $FC
AniRaw_6026F:
		dc.b   $B,   5,   6,   7,   8,   9, $FC
AniRaw_60276:
		dc.b    7,   0,   1,   2,   3, $FC
AniRaw_6027C:
		dc.b    7,   4,   5,   6, $FC
AniRaw_60281:
		dc.b    7,   7,   8,   9, $1A, $1A, $1A, $FC
AniRaw_60289:
		dc.b    7,  $A,  $B,  $C,  $D, $FC
AniRaw_6028F:
		dc.b   $B,  $E,  $F, $10, $11, $FC
AniRaw_60295:
		dc.b   $B, $12, $13, $14, $15, $FC
AniRaw_6029B:
		dc.b   $B, $16, $17, $18, $19, $FC
AniRaw_602A1:
		dc.b    5,   2,   3,   4,   3, $FC
AniRaw_602A7:
		dc.b    2,   0,   2,   1,   6,  $F,   2,   1,   6,   7,   2,   1,   6,   3,   2,   1
		dc.b    6,   1,   2,   1,   6,   1,   2, $13,   3, $3F, $F4
AniRaw_602C2:
		dc.b   $E,   0,   1, $FC
AniRaw_602C6:
		dc.b   $B,   0,   1, $FC
AniRaw_602CA:
		dc.b    5,   0,   0,   1,   2, $F8,   7, $7F,   2,   2, $FC
		even
Map_KnuxEnding:
		include "General/Sprites/Knuckles/Cutscene/Map - Ending Cutscene.asm"
Map_SonicPlane:
		include "General/Ending/Map - Sonic Plane.asm"
Map_SonicPlaneEnding:
		include "General/Ending/Map - Sonic Plane Ending.asm"
Map_SKPoseBanner:
		include "General/Ending/Map - Sonic and Knuckles Pose Banner.asm"
Map_S3PoseBanner:
		include "General/Ending/Map - Sonic 3 Pose Banner.asm"
Map_IslandLiftGfx:
		include "General/Ending/Map - Island Lift Sprites.asm"
Map_EndingAnimals:
		include "General/Ending/Map - Ending Pelican and Dolphin.asm"
Map_SonicTailsEndPoses:
		include "General/Ending/Map - Sonic Tails Ending Poses.asm"
Map_ANDKnuckles:
		include "General/Ending/Map - ANDKnuckles Subtitle.asm"
Map_EndingEyecatchEggRobo:
		include "General/Ending/Map - Ending Egg Robo Eyecatch.asm"
Map_EndingEyecatchEggman:
		include "General/Ending/Map - Ending Eggman Eyecatch.asm"
Map_KnuxEndPose:
		include "General/Ending/Map - Knuckles End Pose.asm"
Pal_EndingSmallPlane:
		binclude "General/Ending/Palettes/Small Plane.bin"
		even
Pal_EndingSKLogo:
		binclude "General/Ending/Palettes/SK Logo.bin"
		even
Pal_EndingS3KLogo:
		binclude "General/Ending/Palettes/S3K Logo.bin"
		even
Pal_EndingEyecatchKnuckles:
		binclude "General/Ending/Palettes/Knuckles Eyecatch.bin"
		even
Pal_EndingMasterEmerald:
		binclude "General/Ending/Palettes/Master Emerald.bin"
		even
Pal_FBZCloud:
		binclude "Levels/FBZ/Palettes/FBZ Cloud.bin"
		even
Pal_TailsEndPose:
		binclude "General/Ending/Palettes/Tails End Pose.bin"
		even
Pal_SonicEndPose:
		binclude "General/Ending/Palettes/Sonic End Pose.bin"
		even
Pal_SuperSonicEndPose:
		binclude "General/Ending/Palettes/Super Sonic End Pose.bin"
		even
Pal_EndingEyecatchEggRobo:
		binclude "General/Ending/Palettes/Egg Robo Eyecatch.bin"
		even
Pal_EndingEyecatchEggman:
		binclude "General/Ending/Palettes/Eggman Eyecatch.bin"
		even
Pal_KnuxEndPose:
		binclude "General/Ending/Palettes/Knuckles End Pose.bin"
		even
PalSPtr_EndingSuperTails:
		palscriptptr .header, .data
		dc.w 0
.header	palscripthdr	Normal_palette_line_3+$04, 4, 0
.data	palscriptdata	24,$06C, $08E, $0AE, $8CE
	palscriptdata	8, $28E, $2AE, $2CE, $AEE
	palscriptdata	8, $4AE, $4CE, $4EE, $CEE
	palscriptdata	8, $6CE, $6EE, $6EE, $EEE
	palscriptdata	8, $4AE, $4CE, $4EE, $CEE
	palscriptdata	8, $28E, $2AE, $2CE, $AEE
	palscriptrept

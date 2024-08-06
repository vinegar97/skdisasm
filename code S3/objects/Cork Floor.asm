Obj_CorkFloor:
		move.b	#4,render_flags(a0)
		move.w	#$280,priority(a0)
		move.l	#Map_AIZCorkFloor,mappings(a0)
		move.w	#make_art_tile($001,2,0),art_tile(a0)
		move.b	#$10,width_pixels(a0)
		move.b	#$28,height_pixels(a0)
		move.l	#word_29AF0,$3C(a0)
		cmpi.w	#1,(Current_zone_and_act).w
		bne.s	loc_29684
		move.l	#Map_AIZCorkFloor2,mappings(a0)
		move.w	#make_art_tile($001,2,0),art_tile(a0)
		move.b	#$2C,height_pixels(a0)

loc_29684:
		cmpi.b	#3,(Current_zone).w
		bne.s	loc_296AE
		move.l	#Map_CNZCorkFloor,mappings(a0)
		move.w	#make_art_tile($430,2,0),art_tile(a0)
		move.b	#$20,width_pixels(a0)
		move.b	#$20,height_pixels(a0)
		move.l	#word_29B20,$3C(a0)

loc_296AE:
		cmpi.b	#5,(Current_zone).w
		bne.s	loc_29702
		move.l	#Map_ICZCorkFloor,mappings(a0)
		move.w	#make_art_tile($001,2,0),art_tile(a0)
		move.b	#$10,width_pixels(a0)
		move.b	#$24,height_pixels(a0)
		move.b	subtype(a0),d0
		move.b	d0,d1
		andi.b	#$F,d0
		move.b	d0,mapping_frame(a0)
		andi.b	#$10,d1
		bne.s	loc_296EE
		move.l	#loc_29914,(a0)
		bra.w	loc_29914
; ---------------------------------------------------------------------------

loc_296EE:
		move.l	#word_29AC4,$3C(a0)
		move.w	#make_art_tile($3B6,2,0),art_tile(a0)
		move.b	#$10,height_pixels(a0)

loc_29702:
		cmpi.b	#6,(Current_zone).w
		bne.s	loc_2972C
		move.l	#Map_LBZCorkFloor,mappings(a0)
		move.w	#make_art_tile($001,2,0),art_tile(a0)
		move.b	#$20,width_pixels(a0)
		move.b	#$20,height_pixels(a0)
		move.l	#word_29B20,$3C(a0)

loc_2972C:
		tst.b	subtype(a0)
		bne.s	loc_2973C
		move.l	#loc_29858,(a0)
		bra.w	loc_29858
; ---------------------------------------------------------------------------

loc_2973C:
		move.l	#loc_29742,(a0)

loc_29742:
		move.w	(Chain_bonus_counter).w,$38(a0)
		move.b	(Player_1+anim).w,$34(a0)
		move.b	(Player_2+anim).w,$36(a0)
		moveq	#0,d1
		move.b	width_pixels(a0),d1
		addi.w	#$B,d1
		moveq	#0,d2
		move.b	height_pixels(a0),d2
		move.w	d2,d3
		addq.w	#1,d3
		move.w	x_pos(a0),d4
		jsr	(SolidObjectFull).l
		move.b	status(a0),d0
		andi.w	#standing_mask,d0
		bne.s	loc_29782

loc_2977C:
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------

loc_29782:
		cmpi.b	#p1_standing|p2_standing,d0
		bne.s	loc_297B0
		cmpi.b	#2,$34(a0)
		beq.s	loc_29798
		cmpi.b	#2,$36(a0)
		bne.s	loc_2977C

loc_29798:
		lea	(Player_1).w,a1
		move.b	$34(a0),d0
		bsr.s	sub_297C8
		lea	(Player_2).w,a1
		move.b	$36(a0),d0
		bsr.s	sub_297C8
		bra.w	loc_29818
; ---------------------------------------------------------------------------

loc_297B0:
		move.b	d0,d1
		andi.b	#8,d1
		beq.s	loc_29800
		cmpi.b	#2,$34(a0)
		bne.s	loc_2977C
		lea	(Player_1).w,a1
		bsr.s	sub_297CE
		bra.s	loc_29818

; =============== S U B R O U T I N E =======================================


sub_297C8:
		cmpi.b	#2,d0
		bne.s	loc_297EC
; End of function sub_297C8


; =============== S U B R O U T I N E =======================================


sub_297CE:
		bset	#Status_Roll,status(a1)
		move.b	#$E,y_radius(a1)
		move.b	#7,x_radius(a1)
		move.b	#2,anim(a1)
		move.w	#-$300,y_vel(a1)

loc_297EC:
		bset	#Status_InAir,status(a1)
		bclr	#Status_OnObj,status(a1)
		move.b	#2,routine(a1)
		rts
; End of function sub_297CE

; ---------------------------------------------------------------------------

loc_29800:
		andi.b	#$10,d0
		beq.w	loc_2977C
		cmpi.b	#2,$36(a0)
		bne.w	loc_2977C
		lea	(Player_2).w,a1
		bsr.s	sub_297CE

loc_29818:
		move.w	$38(a0),(Chain_bonus_counter).w
		andi.b	#$E7,status(a0)
		movea.l	$3C(a0),a4
		addq.b	#1,mapping_frame(a0)
		move.l	#loc_29838,(a0)
		jsr	(BreakObjectToPieces).l

loc_29838:
		jsr	(MoveSprite2).l
		addi.w	#$18,y_vel(a0)
		tst.b	render_flags(a0)
		bpl.w	loc_29852
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_29852:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_29858:
		move.w	(Player_1+y_vel).w,$30(a0)
		move.w	(Player_2+y_vel).w,$32(a0)
		moveq	#0,d1
		move.b	width_pixels(a0),d1
		addi.w	#$B,d1
		moveq	#0,d2
		move.b	height_pixels(a0),d2
		move.w	d2,d3
		addq.w	#1,d3
		move.w	x_pos(a0),d4
		jsr	(SolidObjectFull).l
		swap	d6
		andi.w	#4|8,d6
		bne.s	loc_29890
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------

loc_29890:
		move.b	d6,d0
		andi.b	#4,d0
		beq.s	loc_298B4
		lea	(Player_1).w,a1
		move.w	$30(a0),y_vel(a1)
		andi.b	#8,d6
		beq.s	loc_298CC
		lea	(Player_2).w,a1
		move.w	$32(a0),y_vel(a1)
		bra.s	loc_298CC
; ---------------------------------------------------------------------------

loc_298B4:
		andi.b	#8,d6
		beq.s	loc_298C6
		lea	(Player_2).w,a1
		move.w	$32(a0),y_vel(a1)
		bra.s	loc_298CC
; ---------------------------------------------------------------------------

loc_298C6:
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------

loc_298CC:
		btst	#p1_standing_bit,status(a0)
		beq.s	loc_298E4
		lea	(Player_1).w,a1
		bset	#Status_InAir,status(a1)
		bclr	#Status_OnObj,status(a1)

loc_298E4:
		btst	#p2_standing_bit,status(a0)
		beq.s	loc_298FC
		lea	(Player_2).w,a1
		bset	#Status_InAir,status(a1)
		bclr	#Status_OnObj,status(a1)

loc_298FC:
		movea.l	$3C(a0),a4
		addq.b	#1,mapping_frame(a0)
		move.l	#loc_29838,(a0)
		jsr	(BreakObjectToPieces).l
		bra.w	loc_29838
; ---------------------------------------------------------------------------

loc_29914:
		move.w	(Chain_bonus_counter).w,$38(a0)
		move.b	(Player_1+anim).w,$34(a0)
		move.b	(Player_2+anim).w,$36(a0)
		lea	(byte_29AD4).l,a2
		moveq	#0,d1
		move.b	width_pixels(a0),d1
		addi.w	#$B,d1
		moveq	#0,d2
		move.b	height_pixels(a0),d2
		move.w	x_pos(a0),d4
		jsr	(sub_1BB7C).l
		move.b	status(a0),d0
		andi.b	#standing_mask,d0
		bne.s	loc_29956

loc_29950:
		jmp	(Sprite_OnScreen_Test).l
; ---------------------------------------------------------------------------

loc_29956:
		cmpi.b	#p1_standing|p2_standing,d0
		bne.s	loc_299BA
		cmpi.b	#2,$34(a0)
		bne.s	loc_29972
		tst.b	subtype(a0)
		bmi.s	loc_299A2
		cmpi.b	#$E,(Player_1+top_solid_bit).w
		beq.s	loc_299A2

loc_29972:
		move.b	#$C,(Player_1+top_solid_bit).w
		move.b	#$D,(Player_1+lrb_solid_bit).w
		cmpi.b	#2,$36(a0)
		bne.s	loc_29994
		tst.b	subtype(a0)
		bmi.s	loc_299A2
		cmpi.b	#$E,(Player_2+top_solid_bit).w
		beq.s	loc_299A2

loc_29994:
		move.b	#$C,(Player_2+top_solid_bit).w
		move.b	#$D,(Player_2+lrb_solid_bit).w
		bra.s	loc_29950
; ---------------------------------------------------------------------------

loc_299A2:
		lea	(Player_1).w,a1
		move.b	$34(a0),d0
		bsr.s	sub_299F0
		lea	(Player_2).w,a1
		move.b	$36(a0),d0
		bsr.s	sub_299F0
		bra.w	loc_29A56
; ---------------------------------------------------------------------------

loc_299BA:
		move.b	d0,d1
		andi.b	#8,d1
		beq.s	loc_29A22
		cmpi.b	#2,$34(a0)
		bne.s	loc_299D8
		tst.b	subtype(a0)
		bmi.s	loc_299E8
		cmpi.b	#$E,(Player_1+top_solid_bit).w
		beq.s	loc_299E8

loc_299D8:
		move.b	#$C,(Player_1+top_solid_bit).w
		move.b	#$D,(Player_1+lrb_solid_bit).w
		bra.w	loc_29950
; ---------------------------------------------------------------------------

loc_299E8:
		lea	(Player_1).w,a1
		bsr.s	sub_299F6
		bra.s	loc_29A56

; =============== S U B R O U T I N E =======================================


sub_299F0:
		cmpi.b	#2,d0
		bne.s	loc_29A0E
; End of function sub_299F0


; =============== S U B R O U T I N E =======================================


sub_299F6:
		bset	#Status_Roll,status(a1)
		move.b	#$E,y_radius(a1)
		move.b	#7,x_radius(a1)
		move.b	#2,anim(a1)

loc_29A0E:
		bset	#Status_InAir,status(a1)
		bclr	#Status_OnObj,status(a1)
		move.b	#2,routine(a1)
		rts
; End of function sub_299F6

; ---------------------------------------------------------------------------

loc_29A22:
		andi.b	#$10,d0
		beq.w	loc_29950
		cmpi.b	#2,$36(a0)
		bne.s	loc_29A40
		tst.b	subtype(a0)
		bmi.s	loc_29A50
		cmpi.b	#$E,(Player_2+top_solid_bit).w
		beq.s	loc_29A50

loc_29A40:
		move.b	#$C,(Player_2+top_solid_bit).w
		move.b	#$D,(Player_2+lrb_solid_bit).w
		bra.w	loc_29950
; ---------------------------------------------------------------------------

loc_29A50:
		lea	(Player_2).w,a1
		bsr.s	sub_299F6

loc_29A56:
		move.w	$38(a0),(Chain_bonus_counter).w
		andi.b	#$E7,status(a0)
		lea	(word_29A8C).l,a4
		moveq	#0,d0
		move.b	mapping_frame(a0),d0
		addq.b	#1,mapping_frame(a0)
		move.l	d0,d1
		add.w	d0,d0
		add.w	d0,d0
		lea	(a4,d0.w),a4
		move.l	#loc_29838,(a0)
		jsr	(BreakObjectToPieces).l
		bra.w	loc_29838
; ---------------------------------------------------------------------------
word_29A8C:
		dc.w  -$140, -$A00
		dc.w   $140, -$A00
		dc.w  -$120, -$900
		dc.w   $120, -$900
		dc.w  -$100, -$800
		dc.w   $100, -$800
		dc.w   -$E0, -$700
		dc.w    $E0, -$700
		dc.w   -$C0, -$600
		dc.w    $C0, -$600
		dc.w   -$A0, -$580
		dc.w    $A0, -$580
		dc.w   -$80, -$500
		dc.w    $80, -$500
word_29AC4:
		dc.w  -$200, -$200
		dc.w   $200, -$200
		dc.w  -$100, -$100
		dc.w   $100, -$100
byte_29AD4:
		dc.b  $23, $23
		dc.b  $22, $22
		dc.b  $21, $21
		dc.b  $20, $1F
		dc.b  $1F, $1E
		dc.b  $1E, $1D
		dc.b  $1D, $1C
		dc.b  $1B, $1B
		dc.b  $1A, $1A
		dc.b  $19, $19
		dc.b  $17, $16
		dc.b  $15, $15
		dc.b  $14, $14
		dc.b  $13, $13
word_29AF0:
		dc.w  -$100, -$200
		dc.w   $100, -$200
		dc.w   -$E0, -$1C0
		dc.w    $E0, -$1C0
		dc.w   -$C0, -$180
		dc.w    $C0, -$180
		dc.w   -$A0, -$140
		dc.w    $A0, -$140
		dc.w   -$80, -$100
		dc.w    $80, -$100
		dc.w   -$60,  -$C0
		dc.w    $60,  -$C0
word_29B20:
		dc.w  -$400, -$400
		dc.w  -$200, -$400
		dc.w   $200, -$400
		dc.w   $400, -$400
		dc.w  -$3C0, -$3C0
		dc.w  -$1C0, -$3C0
		dc.w   $1C0, -$3C0
		dc.w   $3C0, -$3C0
		dc.w  -$380, -$380
		dc.w  -$180, -$380
		dc.w   $180, -$380
		dc.w   $380, -$380
		dc.w  -$340, -$340
		dc.w  -$140, -$340
		dc.w   $140, -$340
		dc.w   $340, -$340
Map_AIZCorkFloor:
		include "Levels/AIZ/Misc Object Data/Map - Cork Floor.asm"
Map_AIZCorkFloor2:
		include "Levels/AIZ/Misc Object Data/Map - Cork Floor 2.asm"
Map_CNZCorkFloor:
		include "Levels/CNZ/Misc Object Data/Map - Cork Floor.asm"
Map_ICZCorkFloor:
		include "Levels/ICZ/Misc Object Data/Map - Cork Floor.asm"
Map_LBZCorkFloor:
		include "Levels/LBZ/Misc Object Data/Map - Cork Floor.asm"
; ---------------------------------------------------------------------------

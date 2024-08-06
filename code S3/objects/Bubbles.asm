Obj_Bubbler:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	.Index(pc,d0.w),d1
		jmp	.Index(pc,d1.w)
; ---------------------------------------------------------------------------
.Index:
		dc.w loc_2E068-.Index
		dc.w loc_2E0C6-.Index
		dc.w loc_2E0E0-.Index
		dc.w loc_2E142-.Index
		dc.w loc_2E160-.Index
		dc.w loc_2E166-.Index
; ---------------------------------------------------------------------------

loc_2E068:
		addq.b	#2,routine(a0)
		move.l	#Map_Bubbler,mappings(a0)
		move.w	#make_art_tile($45C,0,0),art_tile(a0)
		move.b	#$84,render_flags(a0)
		move.b	#$10,width_pixels(a0)
		move.w	#$80,priority(a0)
		move.b	subtype(a0),d0
		bpl.s	+ ;loc_2E0AC
		addq.b	#8,routine(a0)
		andi.w	#$7F,d0
		move.b	d0,$32(a0)
		move.b	d0,$33(a0)
		move.b	#8,anim(a0)
		bra.w	loc_2E166
; ---------------------------------------------------------------------------

+ ;loc_2E0AC:
		move.b	d0,anim(a0)
		move.w	x_pos(a0),$30(a0)
		move.w	#-$88,y_vel(a0)
		jsr	(Random_Number).l
		move.b	d0,angle(a0)

loc_2E0C6:
		lea	(Ani_Bubbler).l,a1
		jsr	(Animate_Sprite).l
		cmpi.b	#6,mapping_frame(a0)
		bne.s	loc_2E0E0
		move.b	#1,$2E(a0)

loc_2E0E0:
		move.w	(Water_level).w,d0
		cmp.w	y_pos(a0),d0
		blo.s	+ ;loc_2E0F8
		move.b	#6,routine(a0)
		addq.b	#4,anim(a0)
		bra.w	loc_2E142
; ---------------------------------------------------------------------------

+ ;loc_2E0F8:
		move.b	angle(a0),d0
		addq.b	#1,angle(a0)
		andi.w	#$7F,d0
		lea	(AirCountdown_WobbleData).l,a1
		move.b	(a1,d0.w),d0
		ext.w	d0
		add.w	$30(a0),d0
		move.w	d0,x_pos(a0)
		tst.b	$2E(a0)
		beq.s	+ ;loc_2E12A
		bsr.w	sub_2E2BE
		cmpi.b	#6,routine(a0)
		beq.s	loc_2E142

+ ;loc_2E12A:
		jsr	(MoveSprite2).l
		tst.b	render_flags(a0)
		bpl.s	+ ;loc_2E13C
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

+ ;loc_2E13C:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_2E142:
		lea	(Ani_Bubbler).l,a1
		jsr	(Animate_Sprite).l
		tst.b	render_flags(a0)
		bpl.s	+ ;loc_2E15A
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

+ ;loc_2E15A:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_2E160:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_2E166:
		tst.w	$36(a0)
		bne.s	++ ;loc_2E1C8
		move.w	(Water_level).w,d0
		cmp.w	y_pos(a0),d0
		bhs.w	loc_2E272
		tst.b	render_flags(a0)
		bpl.w	loc_2E272
		subq.w	#1,$38(a0)
		bpl.w	loc_2E266
		move.w	#1,$36(a0)

loc_2E18E:
		jsr	(Random_Number).l
		move.w	d0,d1
		andi.w	#7,d0
		cmpi.w	#6,d0
		bhs.s	loc_2E18E
		move.b	d0,$34(a0)
		andi.w	#$C,d1
		lea	(byte_2E2AC).l,a1
		adda.w	d1,a1
		move.l	a1,$3C(a0)
		subq.b	#1,$32(a0)
		bpl.s	+ ;loc_2E1C6
		move.b	$33(a0),$32(a0)
		bset	#7,$36(a0)

+ ;loc_2E1C6:
		bra.s	++ ;loc_2E1D0
; ---------------------------------------------------------------------------

+ ;loc_2E1C8:
		subq.w	#1,$38(a0)
		bpl.w	loc_2E266

+ ;loc_2E1D0:
		jsr	(Random_Number).l
		andi.w	#$1F,d0
		move.w	d0,$38(a0)
		jsr	(AllocateObject).l
		bne.s	++ ;loc_2E24A
		move.l	(a0),(a1)
		move.w	x_pos(a0),x_pos(a1)
		jsr	(Random_Number).l
		andi.w	#$F,d0
		subq.w	#8,d0
		add.w	d0,x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		moveq	#0,d0
		move.b	$34(a0),d0
		movea.l	$3C(a0),a2
		move.b	(a2,d0.w),subtype(a1)
		btst	#7,$36(a0)
		beq.s	++ ;loc_2E24A
		jsr	(Random_Number).l
		andi.w	#3,d0
		bne.s	+ ;loc_2E236
		bset	#6,$36(a0)
		bne.s	++ ;loc_2E24A
		move.b	#2,subtype(a1)

+ ;loc_2E236:
		tst.b	$34(a0)
		bne.s	+ ;loc_2E24A
		bset	#6,$36(a0)
		bne.s	+ ;loc_2E24A
		move.b	#2,subtype(a1)

+ ;loc_2E24A:
		subq.b	#1,$34(a0)
		bpl.s	loc_2E266
		jsr	(Random_Number).l
		andi.w	#$7F,d0
		addi.w	#$80,d0
		add.w	d0,$38(a0)
		clr.w	$36(a0)

loc_2E266:
		lea	(Ani_Bubbler).l,a1
		jsr	(Animate_Sprite).l

loc_2E272:
		move.w	x_pos(a0),d0
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.w	+ ;loc_2E294
		move.w	(Water_level).w,d0
		cmp.w	y_pos(a0),d0
		blo.w	+++ ;loc_2E2A6
		rts
; ---------------------------------------------------------------------------

+ ;loc_2E294:
		move.w	respawn_addr(a0),d0
		beq.s	+ ;loc_2E2A0
		movea.w	d0,a2
		bclr	#7,(a2)

+ ;loc_2E2A0:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

+ ;loc_2E2A6:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
byte_2E2AC:
		dc.b    0
		dc.b    1
		dc.b    0
		dc.b    0
		dc.b    0
		dc.b    0
		dc.b    1
		dc.b    0
		dc.b    0
		dc.b    0
		dc.b    0
		dc.b    1
		dc.b    0
		dc.b    1
		dc.b    0
		dc.b    0
		dc.b    1
		dc.b    0
		even

; =============== S U B R O U T I N E =======================================


sub_2E2BE:
		lea	(Player_1).w,a1
		bsr.s	+ ;sub_2E2C8
		lea	(Player_2).w,a1
; End of function sub_2E2BE


+ ;sub_2E2C8:
		tst.b	object_control(a1)
		bmi.w	locret_2E392
		move.w	x_pos(a1),d0
		move.w	x_pos(a0),d1
		subi.w	#$10,d1
		cmp.w	d0,d1
		bhs.w	locret_2E392
		addi.w	#2*$10,d1
		cmp.w	d0,d1
		blo.w	locret_2E392
		move.w	y_pos(a1),d0
		move.w	y_pos(a0),d1
		cmp.w	d0,d1
		bhs.w	locret_2E392
		addi.w	#$10,d1
		cmp.w	d0,d1
		blo.w	locret_2E392
		btst	#Status_BublShield,status_secondary(a1)
		bne.w	locret_2E392
		jsr	(Player_ResetAirTimer).l
		moveq	#signextendB(sfx_Bubble),d0
		jsr	(Play_SFX).l
		clr.w	x_vel(a1)
		clr.w	y_vel(a1)
		clr.w	ground_vel(a1)
		move.b	#$15,anim(a1)
		move.w	#35,move_lock(a1)
		move.b	#0,jumping(a1)
		bclr	#Status_Push,status(a1)
		bclr	#Status_RollJump,status(a1)
		btst	#Status_Roll,status(a1)
		beq.w	++ ;loc_2E380
		cmpi.l	#Obj_Sonic,(a1)
		bne.s	+ ;loc_2E370
		bclr	#Status_Roll,status(a1)
		move.b	#$13,y_radius(a1)
		move.b	#9,x_radius(a1)
		subq.w	#5,y_pos(a1)
		bra.s	++ ;loc_2E380
; ---------------------------------------------------------------------------

+ ;loc_2E370:
		move.b	#$F,y_radius(a1)
		move.b	#9,x_radius(a1)
		subq.w	#1,y_pos(a1)

+ ;loc_2E380:
		cmpi.b	#6,routine(a0)
		beq.s	locret_2E392
		move.b	#6,routine(a0)
		addq.b	#4,anim(a0)

locret_2E392:
		rts
; ---------------------------------------------------------------------------
Ani_Bubbler:
		include "General/Sprites/Bubbles/Anim - Bubbler.asm"
Map_Bubbler:
		include "General/Sprites/Bubbles/Map - Bubbler.asm"

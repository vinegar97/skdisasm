; ---------------------------------------------------------------------------
; Small bubbles from Sonic's face while underwater
; ---------------------------------------------------------------------------
Obj_AirCountdown:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	.Index(pc,d0.w),d1
		jmp	.Index(pc,d1.w)
; ---------------------------------------------------------------------------
.Index:
		dc.w .Init-.Index
		dc.w AirCountdown_Animate-.Index
		dc.w AirCountdown_ChkWater-.Index
		dc.w AirCountdown_Display-.Index
		dc.w AirCountdown_Delete-.Index
		dc.w AirCountdown_Countdown-.Index
		dc.w AirCountdown_AirLeft-.Index
		dc.w AirCountdown_DisplayNumber-.Index
		dc.w AirCountdown_Delete-.Index
; ---------------------------------------------------------------------------

.Init:
		addq.b	#2,routine(a0)
		move.l	#Map_Bubbler,mappings(a0)
		tst.b	parent+1(a0)
		beq.s	+ ;loc_1819E
		move.l	#Map_Bubbler2,mappings(a0)

+ ;loc_1819E:
		move.w	#make_art_tile($45C,0,0),art_tile(a0)
		move.b	#$84,render_flags(a0)
		move.b	#$10,width_pixels(a0)
		move.w	#$80,priority(a0)
		move.b	subtype(a0),d0
		bpl.s	+ ;loc_181CC
		addq.b	#8,routine(a0)
		andi.w	#$7F,d0
		move.b	d0,$37(a0)
		bra.w	AirCountdown_Countdown
; ---------------------------------------------------------------------------

+ ;loc_181CC:
		move.b	d0,anim(a0)
		move.w	x_pos(a0),$34(a0)
		move.w	#-$100,y_vel(a0)

AirCountdown_Animate:
		lea	(Ani_AirCountdown).l,a1
		jsr	(Animate_Sprite).l

AirCountdown_ChkWater:
		move.w	(Water_level).w,d0
		cmp.w	y_pos(a0),d0		; has bubble reached the water surface?
		blo.s	+ ;AirCountdown_Wobble	; if not, branch
		; pop the bubble:
		move.b	#6,routine(a0)
		addq.b	#7,anim(a0)
		cmpi.b	#$D,anim(a0)
		beq.s	AirCountdown_Display
		bcs.s	AirCountdown_Display
		move.b	#$D,anim(a0)
		bra.s	AirCountdown_Display
; ---------------------------------------------------------------------------

+ ;AirCountdown_Wobble:
		tst.w	(WindTunnel_flag).w
		beq.s	+ ;loc_18218
		addq.w	#4,$34(a0)

+ ;loc_18218:
		move.b	angle(a0),d0
		addq.b	#1,angle(a0)
		andi.w	#$7F,d0
		lea	(AirCountdown_WobbleData).l,a1
		move.b	(a1,d0.w),d0
		ext.w	d0
		add.w	$34(a0),d0
		move.w	d0,x_pos(a0)
		bsr.w	AirCountdown_ShowNumber
		jsr	(MoveSprite2).l
		tst.b	render_flags(a0)
		bpl.s	+ ;loc_1824E
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

+ ;loc_1824E:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------
; AirCountdown_Display and AirCountdown_DisplayNumber were split in this
; game, unlike Sonic 2, to fix a bug where the countdown numbers corrupted
; if they reached the surface of the water.
; (The start of ARZ Act 1 is a good place to see this).


AirCountdown_Display:
		bsr.s	AirCountdown_ShowNumber
		lea	(Ani_AirCountdown).l,a1
		jsr	(Animate_Sprite).l
		bsr.w	AirCountdown_Load_Art
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

AirCountdown_Delete:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

AirCountdown_AirLeft:
		movea.l	$40(a0),a2	; a2=character
		cmpi.b	#12,air_left(a2)	; check air remaining
		bhi.s	+ ;loc_182AC		; if higher than 12, branch
		subq.w	#1,$3C(a0)
		bne.s	AirCountdown_Display2
		move.b	#$E,routine(a0)
		addq.b	#7,anim(a0)
		bra.s	AirCountdown_Display
; ---------------------------------------------------------------------------

AirCountdown_Display2:
		lea	(Ani_AirCountdown).l,a1
		jsr	(Animate_Sprite).l
		bsr.w	AirCountdown_Load_Art
		tst.b	render_flags(a0)
		bpl.s	+ ;loc_182AC
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

+ ;loc_182AC:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

AirCountdown_DisplayNumber:
		movea.l	$40(a0),a2	; a2=character
		cmpi.b	#12,air_left(a2)
		bhi.s	AirCountdown_Delete
		bsr.s	AirCountdown_ShowNumber
		lea	(Ani_AirCountdown).l,a1
		jsr	(Animate_Sprite).l
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


AirCountdown_ShowNumber:
		tst.w	$3C(a0)
		beq.s	locret_1831C
		subq.w	#1,$3C(a0)
		bne.s	locret_1831C
		cmpi.b	#7,anim(a0)
		bhs.s	locret_1831C
		move.w	#$F,$3C(a0)
		clr.w	y_vel(a0)
		move.b	#$80,render_flags(a0)
		move.w	x_pos(a0),d0
		sub.w	(Camera_X_pos).w,d0
		addi.w	#$80,d0
		move.w	d0,x_pos(a0)
		move.w	y_pos(a0),d0
		sub.w	(Camera_Y_pos).w,d0
		addi.w	#$80,d0
		move.w	d0,y_pos(a0)
		move.b	#$C,routine(a0)

locret_1831C:
		rts
; End of function AirCountdown_ShowNumber

; ---------------------------------------------------------------------------
AirCountdown_WobbleData:
		dc.b  0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2
		dc.b  2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3
		dc.b  3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 2
		dc.b  2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0
		dc.b  0,-1,-1,-1,-1,-1,-2,-2,-2,-2,-2,-3,-3,-3,-3,-3
		dc.b -3,-3,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4
		dc.b -4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-3
		dc.b -3,-3,-3,-3,-3,-3,-2,-2,-2,-2,-2,-1,-1,-1,-1,-1

		; Amazing, this S1 leftover is *still* here.
		; This was used by LZ's water ripple effect in REV01.
		dc.b  0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2
		dc.b  2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3
		dc.b  3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 2
		dc.b  2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0
		dc.b  0,-1,-1,-1,-1,-1,-2,-2,-2,-2,-2,-3,-3,-3,-3,-3
		dc.b -3,-3,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4
		dc.b -4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-3
		dc.b -3,-3,-3,-3,-3,-3,-2,-2,-2,-2,-2,-1,-1,-1,-1,-1

; =============== S U B R O U T I N E =======================================


AirCountdown_Load_Art:
		moveq	#0,d1
		move.b	mapping_frame(a0),d1
		cmpi.b	#9,d1
		blo.s	locret_18464
		cmpi.b	#$13,d1
		bhs.s	locret_18464
		cmp.b	$32(a0),d1
		beq.s	locret_18464
		move.b	d1,$32(a0)
		subi.w	#9,d1
		move.w	d1,d0
		add.w	d1,d1
		add.w	d0,d1
		lsl.w	#6,d1
		addi.l	#ArtUnc_AirCountdown,d1
		move.w	#tiles_to_bytes(ArtTile_DashDust),d2
		tst.b	parent+1(a0)
		beq.s	+ ;loc_1845A
		move.w	#tiles_to_bytes(ArtTile_DashDust_P2),d2

+ ;loc_1845A:
		move.w	#$60,d3
		jsr	(Add_To_DMA_Queue).l

locret_18464:
		rts
; End of function AirCountdown_Load_Art

; ---------------------------------------------------------------------------

AirCountdown_Countdown:
		movea.l	$40(a0),a2	; a2=character
		tst.w	$30(a0)
		bne.w	loc_1857C
		cmpi.b	#6,routine(a2)
		bhs.w	locret_18680
		btst	#Status_BublShield,status_secondary(a2)
		bne.w	locret_18680
		tst.b	(Super_Sonic_Knux_flag).w
		bmi.w	locret_18680
		btst	#Status_Underwater,status(a2)
		beq.w	locret_18680
		subq.w	#1,$3C(a0)
		bpl.w	+++ ;loc_18594
		move.w	#60-1,$3C(a0)
		move.w	#1,$3A(a0)
		jsr	(Random_Number).l
		andi.w	#1,d0
		move.b	d0,$38(a0)
		moveq	#0,d0
		move.b	air_left(a2),d0	; check air remaining
		cmpi.w	#25,d0
		beq.s	AirCountdown_WarnSound	; play ding sound if air is 25
		cmpi.w	#20,d0
		beq.s	AirCountdown_WarnSound	; play ding sound if air is 20
		cmpi.w	#15,d0
		beq.s	AirCountdown_WarnSound	; play ding sound if air is 15
		cmpi.w	#12,d0
		bhi.s	AirCountdown_ReduceAir
		bne.s	+ ;loc_184E8
		tst.b	parent+1(a0)
		bne.s	+ ;loc_184E8
		moveq	#signextendB(mus_Drowning),d0
		jsr	(Play_Music).l

+ ;loc_184E8:
		subq.b	#1,$36(a0)
		bpl.s	AirCountdown_ReduceAir
		move.b	$37(a0),$36(a0)
		bset	#7,$3A(a0)
		bra.s	AirCountdown_ReduceAir
; ---------------------------------------------------------------------------

AirCountdown_WarnSound:
		tst.b	parent+1(a0)
		bne.s	AirCountdown_ReduceAir
		moveq	#signextendB(sfx_AirDing),d0
		jsr	(Play_SFX).l

AirCountdown_ReduceAir:
		subq.b	#1,air_left(a2)
		bcc.w	loc_18592
		move.b	#$81,object_control(a2)
		move.w	#sfx_Drown,d0
		jsr	(Play_SFX).l
		move.b	#$A,$38(a0)
		move.w	#1,$3A(a0)
		move.w	#$78,$30(a0)
		movea.l	a2,a1
		bsr.w	Player_ResetAirTimer
		move.l	a0,-(sp)
		movea.l	a2,a0
		bsr.w	Player_TouchFloor
		move.b	#$17,anim(a0)
		bset	#Status_InAir,status(a0)
		bset	#7,art_tile(a0)
		move.w	#0,y_vel(a0)
		move.w	#0,x_vel(a0)
		move.w	#0,ground_vel(a0)
		move.b	#$C,routine(a0)
		movea.l	(sp)+,a0
		cmpa.w	#Player_1,a2
		bne.s	locret_1857A
		move.b	#1,(Deform_lock).w

locret_1857A:
		rts
; ---------------------------------------------------------------------------

loc_1857C:
		move.b	#$17,anim(a2)
		subq.w	#1,$30(a0)
		bne.s	+ ;loc_18590
		move.b	#6,routine(a2)
		rts
; ---------------------------------------------------------------------------

+ ;loc_18590:
		bra.s	+ ;loc_18594
; ---------------------------------------------------------------------------

loc_18592:
		bra.s	AirCountdown_MakeItem
; ---------------------------------------------------------------------------

+ ;loc_18594:
		tst.w	$3A(a0)
		beq.w	locret_18680
		subq.w	#1,$3E(a0)
		bpl.w	locret_18680

AirCountdown_MakeItem:
		jsr	(Random_Number).l
		andi.w	#$F,d0
		addq.w	#8,d0
		move.w	d0,$3E(a0)
		jsr	(AllocateObject).l
		bne.w	locret_18680
		move.l	(a0),(a1)		; load Obj_Air_Countdown
		move.w	x_pos(a2),x_pos(a1)	; match its X position to Sonic
		moveq	#6,d0
		btst	#Status_Facing,status(a2)
		beq.s	+ ;loc_185D8
		neg.w	d0
		move.b	#$40,angle(a1)

+ ;loc_185D8:
		add.w	d0,x_pos(a1)
		move.w	y_pos(a2),y_pos(a1)
		move.l	$40(a0),$40(a1)
		move.b	#6,subtype(a1)
		tst.w	$30(a0)
		beq.w	+ ;loc_1862A
		andi.w	#7,$3E(a0)
		addi.w	#0,$3E(a0)
		move.w	y_pos(a2),d0
		subi.w	#$C,d0
		move.w	d0,y_pos(a1)
		jsr	(Random_Number).l
		move.b	d0,angle(a1)
		move.w	(Level_frame_counter).w,d0
		andi.b	#3,d0
		bne.s	+++ ;loc_18676
		move.b	#$E,subtype(a1)
		bra.s	+++ ;loc_18676
; ---------------------------------------------------------------------------
; has something to do with making bubbles come out less regularly
; when Sonic is almost drowning
+ ;loc_1862A:
		btst	#7,$3A(a0)
		beq.s	++ ;loc_18676
		moveq	#0,d2
		move.b	air_left(a2),d2
		cmpi.b	#12,d2
		bhs.s	++ ;loc_18676
		lsr.w	#1,d2
		jsr	(Random_Number).l
		andi.w	#3,d0
		bne.s	+ ;loc_1865E
		bset	#6,$3A(a0)
		bne.s	++ ;loc_18676
		move.b	d2,subtype(a1)
		move.w	#$1C,$3C(a1)

+ ;loc_1865E:
		tst.b	$38(a0)
		bne.s	+ ;loc_18676
		bset	#6,$3A(a0)
		bne.s	+ ;loc_18676
		move.b	d2,subtype(a1)
		move.w	#$1C,$3C(a1)

+ ;loc_18676:
		subq.b	#1,$38(a0)
		bpl.s	locret_18680
		clr.w	$3A(a0)

locret_18680:
		rts

; =============== S U B R O U T I N E =======================================


Player_ResetAirTimer:
		cmpi.b	#12,air_left(a1)
		bhi.s	loc_186BC		; branch if countdown hasn't started yet
		cmpa.w	#Player_1,a1
		bne.s	loc_186BC		; branch if it isn't player 1
		move.w	(Current_music).w,d0	; prepare to play current level's music
		btst	#Status_Invincible,status_secondary(a1)
		beq.s	+ ;loc_186A0		; branch if Sonic is not invincible
		move.w	#mus_Invincibility,d0	; prepare to play invincibility music

+ ;loc_186A0:
		tst.b	(Super_Sonic_Knux_flag).w
		beq.w	+ ;loc_186AC		; branch if it isn't Super/Hyper
		move.w	#mus_Invincibility,d0	; prepare to play Super Sonic music (same as invincibility in this game)

+ ;loc_186AC:
		tst.b	(Boss_flag).w
		beq.s	+ ;loc_186B6		; branch if not in a boss fight
		move.w	#mus_MinibossK,d0	; prepare to play boss music

+ ;loc_186B6:
		jsr	(Play_Music).l

loc_186BC:
		move.b	#30,air_left(a1)	; reset air to full
		rts
; End of function Player_ResetAirTimer

; ---------------------------------------------------------------------------
Ani_AirCountdown:
		include "General/Sprites/Dash Dust/Anim - Air Countdown.asm"
; ---------------------------------------------------------------------------

Obj_S2Shield:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	.Index(pc,d0.w),d1
		jmp	.Index(pc,d1.w)
; ---------------------------------------------------------------------------
.Index:
		dc.w .Init-.Index
		dc.w .Main-.Index
; ---------------------------------------------------------------------------

.Init:
		addq.b	#2,routine(a0)
		move.l	#Map_S2Shield,mappings(a0)
		move.b	#4,render_flags(a0)
		move.w	#$80,priority(a0)
		move.b	#$18,width_pixels(a0)
		move.w	#make_art_tile(ArtTile_Shield,0,0),art_tile(a0)

.Main:
		movea.w	parent(a0),a2
		btst	#Status_Invincible,status_secondary(a2)
		bne.s	.locret_187D6
		btst	#Status_Shield,status_secondary(a2)
		beq.s	.Destroy
		move.w	x_pos(a2),x_pos(a0)
		move.w	y_pos(a2),y_pos(a0)
		move.b	status(a2),status(a0)
		andi.w	#drawing_mask,art_tile(a0)
		tst.w	art_tile(a2)
		bpl.s	.Display
		ori.w	#high_priority,art_tile(a0)

.Display:
		lea	(Ani_S2Shield).l,a1
		jsr	(Animate_Sprite).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

.locret_187D6:
		rts
; ---------------------------------------------------------------------------

.Destroy:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------
off_187DE:
		dc.l byte_189ED
		dc.b    0,  $B
		dc.l byte_18A02
		dc.b  $16,  $D
		dc.l byte_18A1B
		dc.b  $2C,  $D
; ---------------------------------------------------------------------------

Obj_Invincibility:
		move.l	#ArtUnc_Invincibility,d1
		move.w	#tiles_to_bytes(ArtTile_Shield),d2
		move.w	#$200,d3
		jsr	(Add_To_DMA_Queue).l
		moveq	#0,d2
		lea	off_187DE-6(pc),a2
		lea	(a0),a1
		moveq	#4-1,d1

- ;loc_1880E:
		move.l	#Obj_188E8,(a1)
		move.l	#Map_Invincibility,mappings(a1)
		move.w	#make_art_tile(ArtTile_Shield,0,0),art_tile(a1)
		move.w	#$80,priority(a1)
		move.b	#4,render_flags(a1)
		bset	#6,render_flags(a1)
		move.b	#$10,width_pixels(a1)
		move.w	#2,mainspr_childsprites(a1)
		move.w	parent(a0),parent(a1)
		move.b	d2,$36(a1)
		addq.w	#1,d2
		move.l	(a2)+,$30(a1)
		move.w	(a2)+,$34(a1)
		lea	next_object(a1),a1
		dbf	d1,- ;loc_1880E
		move.l	#loc_18868,(a0)
		move.b	#4,$34(a0)

loc_18868:
		tst.b	(Super_Sonic_Knux_flag).w
		bne.w	Delete_Current_Sprite
		tst.b	(Super_Tails_flag).w
		bne.w	Delete_Current_Sprite
		movea.w	parent(a0),a1
		btst	#Status_Invincible,status_secondary(a1)
		beq.w	Delete_Current_Sprite
		move.w	x_pos(a1),d0
		move.w	d0,x_pos(a0)
		move.w	y_pos(a1),d1
		move.w	d1,y_pos(a0)
		lea	sub2_x_pos(a0),a2
		lea	byte_189E0(pc),a3
		moveq	#0,d5

loc_188A0:
		move.w	$38(a0),d2
		move.b	(a3,d2.w),d5
		bpl.s	+ ;loc_188B0
		clr.w	$38(a0)
		bra.s	loc_188A0
; ---------------------------------------------------------------------------

+ ;loc_188B0:
		addq.w	#1,$38(a0)
		lea	byte_189A0(pc),a6
		move.b	$34(a0),d6
		jsr	sub_1898A(pc)
		move.w	d2,(a2)+
		move.w	d3,(a2)+
		move.w	d5,(a2)+
		addi.w	#$20,d6
		jsr	sub_1898A(pc)
		move.w	d2,(a2)+
		move.w	d3,(a2)+
		move.w	d5,(a2)+
		moveq	#$12,d0
		btst	#Status_Facing,status(a1)
		beq.s	+ ;loc_188E0
		neg.w	d0

+ ;loc_188E0:
		add.b	d0,$34(a0)
		bra.w	Draw_Sprite
; ---------------------------------------------------------------------------

Obj_188E8:
		tst.b	(Super_Sonic_Knux_flag).w
		bne.w	Delete_Current_Sprite
		tst.b	(Super_Tails_flag).w
		bne.w	Delete_Current_Sprite
		movea.w	parent(a0),a1
		btst	#Status_Invincible,status_secondary(a1)
		beq.w	Delete_Current_Sprite
		lea	(Pos_table_index).w,a5
		lea	(Pos_table).w,a6
		move.b	$36(a0),d1
		lsl.b	#2,d1
		move.w	d1,d2
		add.w	d1,d1
		add.w	d2,d1
		move.w	(a5),d0
		sub.b	d1,d0
		lea	(a6,d0.w),a2
		move.w	(a2)+,d0
		move.w	(a2)+,d1
		move.w	d0,x_pos(a0)
		move.w	d1,y_pos(a0)
		lea	sub2_x_pos(a0),a2
		movea.l	$30(a0),a3

loc_18936:
		move.w	$38(a0),d2
		move.b	(a3,d2.w),d5
		bpl.s	+ ;loc_18946
		clr.w	$38(a0)
		bra.s	loc_18936
; ---------------------------------------------------------------------------

+ ;loc_18946:
		swap	d5
		add.b	$35(a0),d2
		move.b	(a3,d2.w),d5
		addq.w	#1,$38(a0)
		lea	byte_189A0(pc),a6
		move.b	$34(a0),d6
		jsr	sub_1898A(pc)
		move.w	d2,(a2)+
		move.w	d3,(a2)+
		move.w	d5,(a2)+
		addi.w	#$20,d6
		swap	d5
		jsr	sub_1898A(pc)
		move.w	d2,(a2)+
		move.w	d3,(a2)+
		move.w	d5,(a2)+
		moveq	#2,d0
		btst	#Status_Facing,status(a1)
		beq.s	+ ;loc_18982
		neg.w	d0

+ ;loc_18982:
		add.b	d0,$34(a0)
		bra.w	Draw_Sprite

; =============== S U B R O U T I N E =======================================


sub_1898A:
		andi.w	#$3E,d6
		move.b	(a6,d6.w),d2
		move.b	1(a6,d6.w),d3
		ext.w	d2
		ext.w	d3
		add.w	d0,d2
		add.w	d1,d3
		rts
; End of function sub_1898A

; ---------------------------------------------------------------------------
byte_189A0:
		dc.b   $F,   0
		dc.b   $F,   3
		dc.b   $E,   6
		dc.b   $D,   8
		dc.b   $B,  $B
		dc.b    8,  $D
		dc.b    6,  $E
		dc.b    3,  $F
		dc.b    0, $10
		dc.b   -4,  $F
		dc.b   -7,  $E
		dc.b   -9,  $D
		dc.b  -$C,  $B
		dc.b  -$E,   8
		dc.b  -$F,   6
		dc.b -$10,   3
		dc.b -$10,   0
		dc.b -$10,  -4
		dc.b  -$F,  -7
		dc.b  -$E,  -9
		dc.b  -$C, -$C
		dc.b   -9, -$E
		dc.b   -7, -$F
		dc.b   -4,-$10
		dc.b   -1,-$10
		dc.b    3,-$10
		dc.b    6, -$F
		dc.b    8, -$E
		dc.b   $B, -$C
		dc.b   $D,  -9
		dc.b   $E,  -7
		dc.b   $F,  -4
byte_189E0:
		dc.b    8,   5,   7,   6,   6,   7,   5,   8,   6,   7,   7,   6, $FF
byte_189ED:
		dc.b    8,   7,   6,   5,   4,   3,   4,   5,   6,   7, $FF,   3,   4,   5,   6,   7,   8,   7,   6,   5
		dc.b    4
byte_18A02:
		dc.b    8,   7,   6,   5,   4,   3,   2,   3,   4,   5,   6,   7, $FF,   2,   3,   4,   5,   6,   7,   8
		dc.b    7,   6,   5,   4,   3
byte_18A1B:
		dc.b    7,   6,   5,   4,   3,   2,   1,   2,   3,   4,   5,   6, $FF,   1,   2,   3,   4,   5,   6,   7
		dc.b    6,   5,   4,   3,   2
		even
Ani_S2Shield:
		include "General/Sprites/Shields/Anim - S2 Shield.asm"
Map_S2Shield:
		include "General/Sprites/Shields/Map - S2 Shield.asm"
Map_Invincibility:
		include "General/Sprites/Shields/Map - Invincibility.asm"
; ---------------------------------------------------------------------------

Obj_DashDust:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	.Index(pc,d0.w),d1
		jmp	.Index(pc,d1.w)
; ---------------------------------------------------------------------------
.Index:
		dc.w loc_18B54-.Index
		dc.w loc_18BAA-.Index
		dc.w loc_18CB2-.Index
		dc.w loc_18CB6-.Index
; ---------------------------------------------------------------------------

loc_18B54:
		addq.b	#2,routine(a0)
		move.l	#Map_DashDust,mappings(a0)
		ori.b	#4,render_flags(a0)
		move.w	#$80,priority(a0)
		move.b	#$10,width_pixels(a0)
		move.w	#make_art_tile(ArtTile_DashDust,0,0),art_tile(a0)
		move.w	#Player_1,parent(a0)
		move.w	#tiles_to_bytes(ArtTile_DashDust),vram_art(a0)
		cmpa.w	#Dust,a0
		beq.s	loc_18BAA
		move.b	#1,$38(a0)
		cmpi.w	#2,(Player_mode).w
		beq.s	loc_18BAA
		move.w	#make_art_tile(ArtTile_DashDust_P2,0,0),art_tile(a0)
		move.w	#Player_2,parent(a0)
		move.w	#tiles_to_bytes(ArtTile_DashDust_P2),vram_art(a0)

loc_18BAA:
		movea.w	parent(a0),a2
		moveq	#0,d0
		move.b	anim(a0),d0
		add.w	d0,d0
		move.w	off_18BBE(pc,d0.w),d1
		jmp	off_18BBE(pc,d1.w)
; ---------------------------------------------------------------------------
off_18BBE:
		dc.w loc_18C94-off_18BBE
		dc.w loc_18BC8-off_18BBE
		dc.w loc_18C20-off_18BBE
		dc.w loc_18C84-off_18BBE
		dc.w loc_18BEC-off_18BBE
; ---------------------------------------------------------------------------

loc_18BC8:
		move.w	(Water_level).w,y_pos(a0)
		tst.b	prev_anim(a0)
		bne.w	loc_18C94
		move.w	x_pos(a2),x_pos(a0)
		move.b	#0,status(a0)
		andi.w	#drawing_mask,art_tile(a0)
		bra.w	loc_18C94
; ---------------------------------------------------------------------------

loc_18BEC:
		tst.b	prev_anim(a0)
		bne.s	+ ;loc_18C04
		move.w	x_pos(a2),x_pos(a0)
		move.b	#0,status(a0)
		andi.w	#drawing_mask,art_tile(a0)

+ ;loc_18C04:
		lea	(Ani_DashSplashDrown).l,a1
		jsr	(Animate_Sprite).l
		move.l	#ArtUnc_SplashDrown,d6
		bsr.w	SplashDrown_Load_DPLC
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_18C20:
		cmpi.b	#12,air_left(a2)
		blo.w	loc_18CAA
		cmpi.b	#4,routine(a2)
		bhs.s	loc_18CAA
		tst.b	spin_dash_flag(a2)
		beq.s	loc_18CAA
		move.w	x_pos(a2),x_pos(a0)
		move.w	y_pos(a2),y_pos(a0)
		move.b	status(a2),status(a0)
		andi.b	#1,status(a0)
		moveq	#4,d1
		tst.b	(Reverse_gravity_flag).w
		beq.s	+ ;loc_18C60
		ori.b	#2,status(a0)
		neg.w	d1

+ ;loc_18C60:
		tst.b	$38(a0)
		beq.s	+ ;loc_18C6A
		sub.w	d1,y_pos(a0)

+ ;loc_18C6A:
		tst.b	prev_anim(a0)
		bne.s	loc_18C94
		andi.w	#drawing_mask,art_tile(a0)
		tst.w	art_tile(a2)
		bpl.s	loc_18C94
		ori.w	#high_priority,art_tile(a0)
		bra.s	loc_18C94
; ---------------------------------------------------------------------------

loc_18C84:
		cmpi.b	#12,air_left(a2)
		blo.s	loc_18CAA
		btst	#6,status(a0)
		bne.s	loc_18CAA

loc_18C94:
		lea	(Ani_DashSplashDrown).l,a1
		jsr	(Animate_Sprite).l
		bsr.w	DashDust_Load_DPLC
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_18CAA:
		move.b	#0,anim(a0)
		rts
; ---------------------------------------------------------------------------

loc_18CB2:
		bra.w	Delete_Current_Sprite
; ---------------------------------------------------------------------------

loc_18CB6:
		movea.w	parent(a0),a2
		moveq	#$10,d1
		cmpi.b	#$D,anim(a2)
		beq.s	++ ;loc_18CE4
		cmpi.b	#2,character_id(a2)
		bne.s	+ ;loc_18CD6
		moveq	#6,d1
		cmpi.b	#3,double_jump_flag(a2)
		beq.s	++ ;loc_18CE4

+ ;loc_18CD6:
		move.b	#2,routine(a0)
		move.b	#0,$36(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_18CE4:
		subq.b	#1,$36(a0)
		bpl.s	+++ ;loc_18D66
		move.b	#3,$36(a0)
		btst	#Status_Underwater,status(a2)
		bne.s	+++ ;loc_18D66
		bsr.w	AllocateObject
		bne.s	+++ ;loc_18D66
		move.l	(a0),(a1)
		move.w	x_pos(a2),x_pos(a1)
		move.w	y_pos(a2),y_pos(a1)
		tst.b	$38(a0)
		beq.s	+ ;loc_18D14
		subq.w	#4,d1

+ ;loc_18D14:
		tst.b	(Reverse_gravity_flag).w
		beq.s	+ ;loc_18D1C
		neg.w	d1

+ ;loc_18D1C:
		add.w	d1,y_pos(a1)
		move.b	#0,status(a1)
		move.b	#3,anim(a1)
		addq.b	#2,routine(a1)
		move.l	mappings(a0),mappings(a1)
		move.b	render_flags(a0),render_flags(a1)
		move.w	#$80,priority(a1)
		move.b	#4,width_pixels(a1)
		move.w	art_tile(a0),art_tile(a1)
		move.w	parent(a0),parent(a1)
		andi.w	#drawing_mask,art_tile(a1)
		tst.w	art_tile(a2)
		bpl.s	+ ;loc_18D66
		ori.w	#high_priority,art_tile(a1)

+ ;loc_18D66:
		bsr.s	DashDust_Load_DPLC
		rts

; =============== S U B R O U T I N E =======================================


DashDust_Load_DPLC:
		move.l	#ArtUnc_DashDust,d6

SplashDrown_Load_DPLC:
		moveq	#0,d0
		move.b	mapping_frame(a0),d0
		cmp.b	$34(a0),d0
		beq.s	locret_18DBE
		move.b	d0,$34(a0)
		lea	(DPLC_DashSplashDrown).l,a2
		add.w	d0,d0
		adda.w	(a2,d0.w),a2
		move.w	(a2)+,d5
		subq.w	#1,d5
		bmi.s	locret_18DBE
		move.w	vram_art(a0),d4

- ;loc_18D96:
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
		dbf	d5,- ;loc_18D96

locret_18DBE:
		rts
; End of function DashDust_Load_DPLC

; ---------------------------------------------------------------------------
Ani_DashSplashDrown:
		include "General/Sprites/Dash Dust/Anim - Dash Dust.asm"
Map_DashDust:
		include "General/Sprites/Dash Dust/Map - Dash Dust.asm"
DPLC_DashSplashDrown:
		include "General/Sprites/Dash Dust/DPLC - Dash Dust.asm"
; ---------------------------------------------------------------------------

Obj_DashDust2P:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	.Index(pc,d0.w),d1
		jmp	.Index(pc,d1.w)
; ---------------------------------------------------------------------------
.Index:
		dc.w loc_18F9C-.Index
		dc.w loc_18FD2-.Index
		dc.w loc_19060-.Index
		dc.w loc_19064-.Index
; ---------------------------------------------------------------------------

loc_18F9C:
		addq.b	#2,routine(a0)
		move.l	#Map_DashDust2P,mappings(a0)
		ori.b	#4,render_flags(a0)
		move.w	#$80,priority(a0)
		move.b	#$10,width_pixels(a0)
		move.w	#make_art_tile(ArtTile_DashDust,0,0),art_tile(a0)
		move.w	#Player_1,parent(a0)
		cmpa.w	#Dust,a0
		beq.s	loc_18FD2
		move.w	#Player_2,parent(a0)

loc_18FD2:
		movea.w	parent(a0),a2
		moveq	#0,d0
		move.b	anim(a0),d0
		add.w	d0,d0
		move.w	off_18FE6(pc,d0.w),d1
		jmp	off_18FE6(pc,d1.w)
; ---------------------------------------------------------------------------
off_18FE6:
		dc.w loc_18FEE-off_18FE6
		dc.w loc_18FEE-off_18FE6
		dc.w loc_18FF6-off_18FE6
		dc.w loc_1903E-off_18FE6
; ---------------------------------------------------------------------------

loc_18FEE:
		move.b	#0,mapping_frame(a0)
		bra.s	+ ;loc_19046
; ---------------------------------------------------------------------------

loc_18FF6:
		cmpi.b	#12,air_left(a2)
		blo.s	++ ;loc_19058
		cmpi.b	#4,routine(a2)
		bhs.s	++ ;loc_19058
		tst.b	spin_dash_flag(a2)
		beq.s	++ ;loc_19058
		move.w	x_pos(a2),x_pos(a0)
		move.w	y_pos(a2),y_pos(a0)
		move.b	status(a2),status(a0)
		andi.b	#1,status(a0)
		tst.b	prev_anim(a0)
		bne.s	+ ;loc_19046
		andi.w	#drawing_mask,art_tile(a0)
		tst.w	art_tile(a2)
		bpl.s	+ ;loc_19046
		ori.w	#high_priority,art_tile(a0)
		bra.s	+ ;loc_19046
; ---------------------------------------------------------------------------

loc_1903E:
		cmpi.b	#12,air_left(a2)
		blo.s	++ ;loc_19058

+ ;loc_19046:
		lea	(Ani_DashDust2P).l,a1
		jsr	(Animate_Sprite).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

+ ;loc_19058:
		move.b	#0,anim(a0)
		rts
; ---------------------------------------------------------------------------

loc_19060:
		bra.w	Delete_Current_Sprite
; ---------------------------------------------------------------------------

loc_19064:
		movea.w	parent(a0),a2
		cmpi.b	#$D,anim(a2)
		beq.s	+ ;loc_1907E
		move.b	#2,routine(a0)
		move.b	#0,$36(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_1907E:
		move.b	#0,mapping_frame(a0)
		subq.b	#1,$36(a0)
		bpl.s	locret_190F0
		move.b	#3,$36(a0)
		bsr.w	AllocateObject
		bne.s	locret_190F0
		move.l	(a0),(a1)
		move.w	x_pos(a2),x_pos(a1)
		move.w	y_pos(a2),y_pos(a1)
		addi.w	#$C,y_pos(a1)
		move.b	#0,status(a1)
		move.b	#3,anim(a1)
		addq.b	#2,routine(a1)
		move.l	mappings(a0),mappings(a1)
		move.b	render_flags(a0),render_flags(a1)
		move.w	#$80,priority(a1)
		move.b	#4,width_pixels(a1)
		move.w	art_tile(a0),art_tile(a1)
		move.w	parent(a0),parent(a1)
		andi.w	#drawing_mask,art_tile(a1)
		tst.w	art_tile(a2)
		bpl.s	locret_190F0
		ori.w	#high_priority,art_tile(a1)

locret_190F0:
		rts
; ---------------------------------------------------------------------------
Ani_DashDust2P:
		include "General/Sprites/Dash Dust/Anim - Dash Dust 2P.asm"
Map_DashDust2P:
		include "General/Sprites/Dash Dust/Map - Dash Dust 2P.asm"
; ---------------------------------------------------------------------------

Obj_SuperSonicKnux_Stars:
		move.l	#ArtUnc_SuperSonic_Stars,d1
		move.w	#tiles_to_bytes(ArtTile_Shield),d2
		move.w	#$1A0,d3
		jsr	(Add_To_DMA_Queue).l
		move.l	#Map_SuperSonic_Stars,mappings(a0)
		move.b	#4,render_flags(a0)
		move.w	#$80,priority(a0)
		move.b	#$18,width_pixels(a0)
		move.b	#$18,height_pixels(a0)
		move.w	#make_art_tile(ArtTile_Shield,0,0),art_tile(a0)
		btst	#7,(Player_1+art_tile).w
		beq.s	+ ;loc_1919E
		bset	#7,art_tile(a0)

+ ;loc_1919E:
		move.l	#loc_191A4,(a0)

loc_191A4:
		tst.b	(Super_Sonic_Knux_flag).w
		beq.w	loc_19230
		tst.b	anim(a0)
		beq.s	+ ;loc_191B6
		bsr.w	sub_19236

+ ;loc_191B6:
		tst.b	$34(a0)
		beq.s	+++ ;loc_19200
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	+ ;loc_191E8
		move.b	#1,anim_frame_timer(a0)
		addq.b	#1,mapping_frame(a0)
		cmpi.b	#6,mapping_frame(a0)
		blo.s	+ ;loc_191E8
		move.b	#0,mapping_frame(a0)
		move.b	#0,$34(a0)
		move.b	#1,$35(a0)
		rts
; ---------------------------------------------------------------------------

+ ;loc_191E8:
		tst.b	$35(a0)
		bne.s	+ ;loc_191FA

loc_191EE:
		move.w	(Player_1+x_pos).w,x_pos(a0)
		move.w	(Player_1+y_pos).w,y_pos(a0)

+ ;loc_191FA:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

+ ;loc_19200:
		tst.b	(Player_1+object_control).w
		bne.s	++ ;loc_19222
		move.w	(Player_1+ground_vel).w,d0
		bpl.s	+ ;loc_1920E
		neg.w	d0

+ ;loc_1920E:
		cmpi.w	#$800,d0
		blo.s	+ ;loc_19222
		move.b	#0,mapping_frame(a0)
		move.b	#1,$34(a0)
		bra.s	loc_191EE
; ---------------------------------------------------------------------------

+ ;loc_19222:
		move.b	#0,$34(a0)
		move.b	#0,$35(a0)
		rts
; ---------------------------------------------------------------------------

loc_19230:
		jmp	(Delete_Current_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_19236:
		move.b	#0,anim(a0)
		lea	(Player_1).w,a2
		moveq	#$10-1,d5
		move.w	#$488,d4

- ;loc_19246:
		bsr.w	AllocateObject
		bne.w	locret_192BE
		move.l	#Obj_SuperSonicKnux_Stars_Timer,(a1)
		move.w	x_pos(a2),x_pos(a1)
		move.w	y_pos(a2),y_pos(a1)
		move.l	#Map_SuperSonic_Stars2,mappings(a1)
		move.w	#make_art_tile($79C,0,1),art_tile(a1)
		move.b	#$84,render_flags(a1)
		move.w	#$380,priority(a1)
		move.b	#8,width_pixels(a1)
		move.b	#8,height_pixels(a1)
		tst.w	d4
		bmi.s	+ ;loc_192AE
		move.w	d4,d0
		jsr	(GetSineCosine).l
		move.w	d4,d2
		lsr.w	#8,d2
		asl.w	d2,d0
		asl.w	d2,d1
		move.w	d0,d2
		move.w	d1,d3
		addi.b	#$10,d4
		bcc.s	+ ;loc_192AE
		subi.w	#$80,d4
		bcc.s	+ ;loc_192AE
		move.w	#$488,d4

+ ;loc_192AE:
		move.w	d2,x_vel(a1)
		move.w	d3,y_vel(a1)
		neg.w	d2
		neg.w	d4
		dbf	d5,- ;loc_19246

locret_192BE:
		rts
; End of function sub_19236

; ---------------------------------------------------------------------------

Obj_SuperSonicKnux_Stars_Timer:
		tst.b	render_flags(a0)
		bmi.s	+ ;loc_192CC
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

+ ;loc_192CC:
		addq.b	#1,mapping_frame(a0)
		andi.b	#3,mapping_frame(a0)
		bsr.w	MoveSprite2
		bra.w	Draw_Sprite
; ---------------------------------------------------------------------------
Map_SuperSonic_Stars:
		include "General/Sprites/Shields/Map - Super Sonic Stars.asm"
; ---------------------------------------------------------------------------

Obj_HyperSonic_Stars:
		lea	(ArtKosM_HyperSonicStars).l,a1
		move.w	#tiles_to_bytes(ArtTile_Shield),d2
		jsr	(Queue_Kos_Module).l
		lea	(a0),a1
		moveq	#0,d0
		moveq	#0,d2
		moveq	#4-1,d1

-	;.createObject:
		move.l	#.Init,(a1)
		move.b	d0,angle(a1)
		addi.b	#$40,d0
		addq.b	#1,d2
		move.b	d2,anim_frame_timer(a1)
		lea	next_object(a1),a1
		dbf	d1,- ;.createObject

.Init:
		; Wait for art to finish loading before we display
		tst.b	(Kos_modules_left).w
		beq.s	.artDoneLoading

	.return:
		rts
; ---------------------------------------------------------------------------

	.artDoneLoading:
		subq.b	#1,anim_frame_timer(a0)
		bne.s	.return
		move.l	#Map_HyperSonicStars,mappings(a0)
		move.b	#4,render_flags(a0)
		move.w	#$80,priority(a0)
		move.b	#$18,width_pixels(a0)
		move.b	#$18,height_pixels(a0)
		move.w	#make_art_tile(ArtTile_Shield,0,0),art_tile(a0)
		move.b	#6,mapping_frame(a0)
		cmpa.w	#Invincibility_stars,a0
		beq.s	.isParent
		move.l	#.child,(a0)
		bra.s	.child
; ---------------------------------------------------------------------------

	.isParent:
		move.l	#.Main,(a0)

.Main:
		tst.b	anim(a0)
		beq.s	.child
		clr.b	anim(a0)
		move.w	(Player_1+x_pos).w,x_pos(a0)
		move.w	(Player_1+y_pos).w,y_pos(a0)
		moveq	#2,d2
		bsr.w	Obj_LightningShield_CreateSpark_Part2
		move.b	#4,(Hyper_Sonic_flash_timer).w

	.child:
		tst.b	(Super_Sonic_Knux_flag).w
		beq.w	loc_19486
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	+ ;loc_1941C
		move.b	#1,anim_frame_timer(a0)
		addq.b	#1,mapping_frame(a0)
		cmpi.b	#3,mapping_frame(a0)
		blo.s	+ ;loc_1941C
		move.b	#0,mapping_frame(a0)
		moveq	#0,d0
		move.w	d0,$30(a0)
		move.w	d0,$34(a0)

+ ;loc_1941C:
		move.b	angle(a0),d0
		addi.b	#-$10,angle(a0)
		jsr	(GetSineCosine).l
		asl.w	#3,d0
		asl.w	#3,d1
		move.w	d0,x_vel(a0)
		move.w	d1,y_vel(a0)
		move.w	x_vel(a0),d0
		add.w	d0,$30(a0)
		move.w	y_vel(a0),d1
		add.w	d1,$34(a0)
		move.b	$30(a0),d2
		ext.w	d2
		btst	#Status_Facing,(Player_1+status).w
		beq.s	+ ;loc_19458
		neg.w	d2

+ ;loc_19458:
		move.b	$34(a0),d3
		ext.w	d3
		add.w	(Player_1+x_pos).w,d2
		add.w	(Player_1+y_pos).w,d3
		move.w	d2,x_pos(a0)
		move.w	d3,y_pos(a0)
		andi.w	#drawing_mask,art_tile(a0)
		tst.b	(Player_1+art_tile).w
		bpl.s	+ ;loc_19480
		ori.w	#high_priority,art_tile(a0)

+ ;loc_19480:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_19486:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------
Map_HyperSonicStars:
		include "General/Sprites/Sonic/Map - Hyper Sonic Stars.asm"
; ---------------------------------------------------------------------------

Obj_InstaShield:
		; Init
		move.l	#Map_InstaShield,mappings(a0)
		move.l	#DPLC_InstaShield,shield_plc(a0)			; Used by PLCLoad_Shields
		move.l	#ArtUnc_InstaShield,shield_art(a0)			; Used by PLCLoad_Shields
		move.b	#4,render_flags(a0)
		move.w	#$80,priority(a0)
		move.b	#$18,width_pixels(a0)
		move.b	#$18,height_pixels(a0)
		move.w	#make_art_tile(ArtTile_Shield,0,0),art_tile(a0)
		move.w	#tiles_to_bytes(ArtTile_Shield),vram_art(a0)	; Used by PLCLoad_Shields
		btst	#7,(Player_1+art_tile).w
		beq.s	+ ;.nothighpriority
		bset	#7,art_tile(a0)

+	;.nothighpriority:
		move.w	#1,anim(a0)			; Clear anim and set prev_anim to 1
		move.b	#-1,shield_prev_frame(a0)	; Reset shield_prev_frame (used by PLCLoad_Shields)
		move.l	#.Main,(a0)

.Main:
		movea.w	parent(a0),a2
		btst	#Status_Invincible,status_secondary(a2)	; Is the player invincible?
		bne.s	.locret_195A4			; If so, return
		move.w	x_pos(a2),x_pos(a0)		; Inherit player's x_pos
		move.w	y_pos(a2),y_pos(a0)		; Inherit player's y_pos
		move.b	status(a2),status(a0)		; Inherit status
		andi.b	#1,status(a0)			; Limit inheritance to 'orientation' bit
		tst.b	(Reverse_gravity_flag).w
		beq.s	+ ;.normalgravity
		ori.b	#2,status(a0)			; Reverse the vertical mirror render flag bit (on if off beforehand and vice versa)

+	;.normalgravity:
		andi.w	#drawing_mask,art_tile(a0)
		tst.w	art_tile(a2)
		bpl.s	+ ;.nothighpriority
		ori.w	#high_priority,art_tile(a0)

+	;.nothighpriority:
		lea	(Ani_InstaShield).l,a1
		jsr	(Animate_Sprite).l
		cmpi.b	#7,mapping_frame(a0)		; Has it reached then end of its animation?
		bne.s	+ ;.notover			; If not, branch
		tst.b	double_jump_flag(a2)		; Is it in its attacking state?
		beq.s	+ ;.notover			; If not, branch
		move.b	#2,double_jump_flag(a2)		; Mark attack as over

+	;.notover:
		tst.b	mapping_frame(a0)		; Is this the first frame?
		beq.s	+ ;.loadnewDPLC			; If so, branch and load the DPLC for this and the next few frames
		cmpi.b	#3,mapping_frame(a0)		; Is this the third frame?
		bne.s	++ ;.skipDPLC			; If not, branch as we don't need to load another DPLC yet

+	;.loadnewDPLC:
		bsr.w	PLCLoad_Shields

+	;.skipDPLC:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

.locret_195A4:
		rts
; ---------------------------------------------------------------------------

Obj_FireShield:
		; Init
		move.l	#Map_FireShield,mappings(a0)
		move.l	#DPLC_FireShield,shield_plc(a0)				; Used by PLCLoad_Shields
		move.l	#ArtUnc_FireShield,shield_art(a0)			; Used by PLCLoad_Shields
		move.b	#4,render_flags(a0)
		move.w	#$80,priority(a0)
		move.b	#$18,width_pixels(a0)
		move.b	#$18,height_pixels(a0)
		move.w	#make_art_tile(ArtTile_Shield,0,0),art_tile(a0)
		move.w	#tiles_to_bytes(ArtTile_Shield),vram_art(a0)	; Used by PLCLoad_Shields
		btst	#7,(Player_1+art_tile).w
		beq.s	+ ;.nothighpriority
		bset	#7,art_tile(a0)

;loc_195F0:
+	;.nothighpriority:
		move.w	#1,anim(a0)				; Clear anim and set prev_anim to 1
		move.b	#-1,shield_prev_frame(a0)		; Reset shield_prev_frame (used by PLCLoad_Shields)
		move.l	#.Main,(a0)

.Main:
		movea.w	parent(a0),a2
		btst	#Status_Invincible,status_secondary(a2)	; Is player invincible?
		bne.w	.locret_19690				; If so, do not display and do not update variables
		cmpi.b	#$1C,anim(a2)				; Is player in their 'blank' animation?
		beq.s	.locret_19690				; If so, do not display and do not update variables
		btst	#Status_Shield,status_secondary(a2)	; Should the player still have a shield?
		beq.w	.Destroy			; If not, change to Insta-Shield
		btst	#Status_Underwater,status(a2)		; Is player underwater?
		bne.s	.DestroyUnderwater	; If so, branch
		move.w	x_pos(a2),x_pos(a0)
		move.w	y_pos(a2),y_pos(a0)
		tst.b	anim(a0)				; Is shield in its 'dashing' state?
		bne.s	++ ;.nothighpriority			; If so, do not update orientation or allow changing of the priority art_tile bit
		move.b	status(a2),status(a0)			; Inherit status
		andi.b	#1,status(a0)				; Limit inheritance to 'orientation' bit
		tst.b	(Reverse_gravity_flag).w
		beq.s	+ ;.normalgravity
		ori.b	#2,status(a0)				; If in reverse gravity, reverse the vertical mirror render flag bit (on if off beforehand and vice versa)

+	;.normalgravity:
		andi.w	#drawing_mask,art_tile(a0)
		tst.w	art_tile(a2)
		bpl.s	+ ;.nothighpriority
		ori.w	#high_priority,art_tile(a0)

+	;.nothighpriority:
		lea	(Ani_FireShield).l,a1
		jsr	(Animate_Sprite).l
		move.w	#$80,priority(a0)		; Layer shield over player sprite
		cmpi.b	#$F,mapping_frame(a0)		; Are these the frames that display in front of the player?
		blo.s	+ ;.overplayer			; If so, branch
		move.w	#$200,priority(a0)		; If not, layer shield behind player sprite

+	;.overplayer:
		bsr.w	PLCLoad_Shields
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

.locret_19690:
		rts
; ---------------------------------------------------------------------------

.DestroyUnderwater:
		andi.b	#$8E,status_secondary(a2)	; Sets Status_Shield, Status_FireShield, Status_LtngShield, and Status_BublShield to 0
		jsr	(AllocateObject).l		; Set up for a new object
		bne.w	.Destroy		; If that can't happen, branch
		move.l	#Obj_FireShield_Dissipate,(a1)	; Create dissipate object
		move.w	x_pos(a0),x_pos(a1)		; Put it at shields' x_pos
		move.w	y_pos(a0),y_pos(a1)		; Put it at shields' y_pos

.Destroy:
		andi.b	#$8E,status_secondary(a2)	; Sets Status_Shield, Status_FireShield, Status_LtngShield, and Status_BublShield to 0
		move.l	#Obj_InstaShield,(a0)		; Replace the Fire Shield with the Insta-Shield
		rts
; ---------------------------------------------------------------------------

Obj_LightningShield:
		; init
		; Load Spark art
		move.l	#ArtUnc_LightningShield_Sparks,d1			; Load art source
		move.w	#tiles_to_bytes(ArtTile_Shield_Sparks),d2		; Load art destination
		move.w	#(ArtUnc_LightningShield_Sparks.end-ArtUnc_LightningShield_Sparks)/2,d3	; Size of art (in words)
		jsr	(Add_To_DMA_Queue).l

		move.l	#Map_LightningShield,mappings(a0)
		move.l	#DPLC_LightningShield,shield_plc(a0)			; Used by PLCLoad_Shields
		move.l	#ArtUnc_LightningShield,shield_art(a0)			; Used by PLCLoad_Shields
		move.b	#4,render_flags(a0)
		move.w	#$80,priority(a0)
		move.b	#$18,width_pixels(a0)
		move.b	#$18,height_pixels(a0)
		move.w	#make_art_tile(ArtTile_Shield,0,0),art_tile(a0)
		move.w	#tiles_to_bytes(ArtTile_Shield),vram_art(a0)	; Used by PLCLoad_Shields
		btst	#7,(Player_1+art_tile).w
		beq.s	+ ;.nothighpriority
		bset	#7,art_tile(a0)

+	;.nothighpriority:
		move.w	#1,anim(a0)				; Clear anim and set prev_anim to 1
		move.b	#-1,shield_prev_frame(a0)		; Reset shield_prev_frame (used by PLCLoad_Shields)
		move.l	#.Main,(a0)

.Main:
		movea.w	parent(a0),a2
		btst	#Status_Invincible,status_secondary(a2)	; Is player invincible?
		bne.w	.locret_197C4				; If so, do not display and do not update variables
		cmpi.b	#$1C,anim(a2)				; Is player in their 'blank' animation?
		beq.s	.locret_197C4				; If so, do not display and do not update variables
		btst	#Status_Shield,status_secondary(a2)	; Should the player still have a shield?
		beq.s	.Destroy		; If not, change to Insta-Shield
		btst	#Status_Underwater,status(a2)		; Is player underwater?
		bne.s	.DestroyUnderwater	; If so, branch
		move.w	x_pos(a2),x_pos(a0)
		move.w	y_pos(a2),y_pos(a0)
		move.b	status(a2),status(a0)			; Inherit status
		andi.b	#1,status(a0)				; Limit inheritance to 'orientation' bit
		tst.b	(Reverse_gravity_flag).w
		beq.s	+ ;.normalgravity
		ori.b	#2,status(a0)				; If in reverse gravity, reverse the vertical mirror render flag bit (on if off beforehand and vice versa)

+	;.normalgravity:
		andi.w	#drawing_mask,art_tile(a0)
		tst.w	art_tile(a2)
		bpl.s	+ ;.nothighpriority
		ori.w	#high_priority,art_tile(a0)

+	;.nothighpriority:
		tst.b	anim(a0)				; Is shield in its 'double jump' state?
		beq.s	.Display		; Is not, branch and display
		bsr.s	.CreateSpark		; Create sparks
		clr.b	anim(a0)				; Once done, return to non-'double jump' state

.Display:
		lea	(Ani_LightningShield).l,a1
		jsr	(Animate_Sprite).l
		move.w	#$80,priority(a0)			; Layer shield over player sprite
		cmpi.b	#$E,mapping_frame(a0)			; Are these the frames that display in front of the player?
		blo.s	+ ;.overplayer				; If so, branch
		move.w	#$200,priority(a0)			; If not, layer shield behind player sprite

+	;.overplayer:
		bsr.w	PLCLoad_Shields
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

.locret_197C4:
		rts
; ---------------------------------------------------------------------------

.DestroyUnderwater:
		tst.w	(Palette_fade_timer).w
		beq.s	.FlashWater

.Destroy:
		andi.b	#$8E,status_secondary(a2)	; Sets Status_Shield, Status_FireShield, Status_LtngShield, and Status_BublShield to 0
		move.l	#Obj_InstaShield,(a0)		; Replace the Lightning Shield with the Insta-Shield
		rts
; ---------------------------------------------------------------------------

.FlashWater:
		move.l	#Obj_LightningShield_DestroyUnderwater2,(a0)
		andi.b	#$8E,status_secondary(a2)	; Sets Status_Shield, Status_FireShield, Status_LtngShield, and Status_BublShield to 0

		; Flashes the underwater palette white
		lea	(Water_palette).w,a1
		lea	(Target_water_palette).w,a2
		move.w	#bytesToLcnt($80),d0			; Size of Water_palette/4-1

- ;loc_197F2:
		move.l	(a1),(a2)+			; Backup palette entries
		move.l	#$0EEE0EEE,(a1)+		; Overwrite palette entries with white
		dbf	d0,- ;loc_197F2			; Loop until entire thing is overwritten

		move.w	#0,-$40(a1)			; Set the first colour in the third palette line to black
		move.b	#3,anim_frame_timer(a0)
		rts

; =============== S U B R O U T I N E =======================================


.CreateSpark:
		moveq	#1,d2

Obj_LightningShield_CreateSpark_Part2:
		lea	(SparkVelocities).l,a2
		moveq	#4-1,d1

- 	;.loop:
		bsr.w	AllocateObject		; Find free object slot
		bne.s	.end			; If one can't be found, return
		move.l	#Obj_LightningShield_Spark,(a1)	; Make new object a Spark
		move.w	x_pos(a0),x_pos(a1)		; (Spark) Inherit x_pos from source object (Lightning Shield, Hyper Sonic Stars)
		move.w	y_pos(a0),y_pos(a1)		; (Spark) Inherit y_pos from source object (Lightning Shield, Hyper Sonic Stars)
		move.l	mappings(a0),mappings(a1)	; (Spark) Inherit mappings from source object (Lightning Shield, Hyper Sonic Stars)
		move.w	art_tile(a0),art_tile(a1)	; (Spark) Inherit art_tile from source object (Lightning Shield, Hyper Sonic Stars)
		move.b	#4,render_flags(a1)
		move.w	#$80,priority(a1)
		move.b	#8,width_pixels(a1)
		move.b	#8,height_pixels(a1)
		move.b	d2,anim(a1)
		move.w	(a2)+,x_vel(a1)			; (Spark) Give x_vel (unique to each of the four Sparks)
		move.w	(a2)+,y_vel(a1)			; (Spark) Give y_vel (unique to each of the four Sparks)
		dbf	d1,- ;.loop

	.end:
		rts
; End of function Obj_LightningShield_CreateSpark

; ---------------------------------------------------------------------------
SparkVelocities:
		dc.w  -$200, -$200
		dc.w   $200, -$200
		dc.w  -$200,  $200
		dc.w   $200,  $200
; ---------------------------------------------------------------------------

Obj_LightningShield_Spark:
		jsr	(MoveSprite2).l
		addi.w	#$18,y_vel(a0)
		lea	(Ani_LightningShield).l,a1
		jsr	(Animate_Sprite).l
		tst.b	routine(a0)			; Changed by Animate_Sprite
		bne.s	.Delete
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

.Delete:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

Obj_LightningShield_DestroyUnderwater2:
		subq.b	#1,anim_frame_timer(a0)		; Is it time to end the white flash?
		bpl.s	.end			; If not, return
		move.l	#Obj_InstaShield,(a0)		; Replace Lightning Shield with Insta-Shield
		lea	(Target_water_palette).w,a1
		lea	(Water_palette).w,a2
		move.w	#bytesToLcnt($80),d0		; Size of Water_palette/4-1

- ;.loop:
		move.l	(a1)+,(a2)+			; Restore backed-up underwater palette
		dbf	d0,- ;.loop			; Loop until entire thing is restored

	.end:
		rts
; ---------------------------------------------------------------------------

Obj_BubbleShield:
		; Init
		move.l	#Map_BubbleShield,mappings(a0)
		move.l	#DPLC_BubbleShield,shield_plc(a0)			; Used by PLCLoad_Shields
		move.l	#ArtUnc_BubbleShield,shield_art(a0)			; Used by PLCLoad_Shields
		move.b	#4,render_flags(a0)
		move.w	#$80,priority(a0)
		move.b	#$18,width_pixels(a0)
		move.b	#$18,height_pixels(a0)
		move.w	#make_art_tile(ArtTile_Shield,0,0),art_tile(a0)
		move.w	#tiles_to_bytes(ArtTile_Shield),vram_art(a0)	; Used by PLCLoad_Shields
		btst	#7,(Player_1+art_tile).w
		beq.s	+ ;.nothighpriority
		bset	#7,art_tile(a0)

+	;.nothighpriority:
		move.w	#1,anim(a0)				; Clear anim and set prev_anim to 1
		move.b	#-1,shield_prev_frame(a0)		; Reset shield_prev_frame (used by PLCLoad_Shields)
		movea.w	parent(a0),a1
		bsr.w	Player_ResetAirTimer
		move.l	#.Main,(a0)

.Main:
		movea.w	parent(a0),a2
		btst	#Status_Invincible,status_secondary(a2)	; Is player invincible?
		bne.s	.locret_1998A				; If so, do not display and do not update variables
		cmpi.b	#$1C,anim(a2)				; Is player in their 'blank' animation?
		beq.s	.locret_1998A				; If so, do not display and do not update variables
		btst	#Status_Shield,status_secondary(a2)	; Should the player still have a shield?
		beq.s	.Destroy		; If not, change to Insta-Shield
		move.w	x_pos(a2),x_pos(a0)
		move.w	y_pos(a2),y_pos(a0)
		move.b	status(a2),status(a0)			; Inherit status
		andi.b	#1,status(a0)				; Limit inheritance to 'orientation' bit
		tst.b	(Reverse_gravity_flag).w
		beq.s	+ ;.normalgravity
		ori.b	#2,status(a0)				; Reverse the vertical mirror render flag bit (on if off beforehand and vice versa)

+	;.normalgravity:
		andi.w	#drawing_mask,art_tile(a0)
		tst.w	art_tile(a2)
		bpl.s	+ ;.nothighpriority
		ori.w	#high_priority,art_tile(a0)

+	;.nothighpriority:
		lea	(Ani_BubbleShield).l,a1
		jsr	(Animate_Sprite).l
		bsr.w	PLCLoad_Shields
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

.locret_1998A:
		rts
; ---------------------------------------------------------------------------

.Destroy:
		andi.b	#$8E,status_secondary(a2)	; Sets Status_Shield, Status_FireShield, Status_LtngShield, and Status_BublShield to 0
		move.l	#Obj_InstaShield,(a0)		; Replace the Bubble Shield with the Insta-Shield
		rts

; =============== S U B R O U T I N E =======================================


PLCLoad_Shields:
		moveq	#0,d0
		move.b	mapping_frame(a0),d0
		cmp.b	shield_prev_frame(a0),d0
		beq.s	.locret_199E8
		move.b	d0,shield_prev_frame(a0)
		movea.l	shield_plc(a0),a2
		add.w	d0,d0
		adda.w	(a2,d0.w),a2
		move.w	(a2)+,d5
		subq.w	#1,d5
		bmi.s	.locret_199E8
		move.w	vram_art(a0),d4

- ;.ReadEntry:
		moveq	#0,d1
		move.w	(a2)+,d1
		move.w	d1,d3
		lsr.w	#8,d3
		andi.w	#$F0,d3
		addi.w	#$10,d3
		andi.w	#$FFF,d1
		lsl.l	#5,d1
		add.l	shield_art(a0),d1
		move.w	d4,d2
		add.w	d3,d4
		add.w	d3,d4
		jsr	(Add_To_DMA_Queue).l
		dbf	d5,- ;.ReadEntry

.locret_199E8:
		rts
; End of function PLCLoad_Shields

; ---------------------------------------------------------------------------
Ani_InstaShield:
		include "General/Sprites/Shields/Anim - Insta-Shield.asm"
Ani_FireShield:
		include "General/Sprites/Shields/Anim - Fire Shield.asm"
Ani_LightningShield:
		include "General/Sprites/Shields/Anim - Lightning Shield.asm"
Ani_BubbleShield:
		include "General/Sprites/Shields/Anim - Bubble Shield.asm"
Map_FireShield:
		include "General/Sprites/Shields/Map - Fire Shield.asm"
DPLC_FireShield:
		include "General/Sprites/Shields/DPLC - Fire Shield.asm"
Map_LightningShield:
		include "General/Sprites/Shields/Map - Lightning Shield.asm"
DPLC_LightningShield:
		include "General/Sprites/Shields/DPLC - Lightning Shield.asm"
Map_BubbleShield:
		include "General/Sprites/Shields/Map - Bubble Shield.asm"
DPLC_BubbleShield:
		include "General/Sprites/Shields/DPLC - Bubble Shield.asm"
Map_InstaShield:
		include "General/Sprites/Shields/Map - Insta-Shield.asm"
DPLC_InstaShield:
		include "General/Sprites/Shields/DPLC - Insta-Shield.asm"
; ---------------------------------------------------------------------------
superTailsBirds_target_found = $30
superTailsBirds_search_delay = $32
superTailsBirds_angle = $34
superTailsBirds_target_address = $42

Obj_SuperTailsBirds:
		lea	(ArtKosM_SuperTailsBirds).l,a1
		move.w	#tiles_to_bytes(ArtTile_Player_1),d2
		jsr	(Queue_Kos_Module).l
		lea	(a0),a1
		moveq	#0,d0
		moveq	#4-1,d1

- ;.loop:
		move.l	#.Init,(a1)
		move.b	d0,superTailsBirds_angle(a1)
		addi.b	#$40,d0	; 90 degrees
		lea	next_object(a1),a1
		dbf	d1,- ;.loop

.Init:
		; Wait for the object's art to finish loading
		tst.b	(Kos_modules_left).w
		beq.s	.art_done_loading
		rts
; ---------------------------------------------------------------------------

	.art_done_loading:
		move.l	#Map_SuperTails_Birds,mappings(a0)
		move.b	#4,render_flags(a0)
		move.w	#$80,priority(a0)
		move.b	#8,width_pixels(a0)
		move.b	#8,height_pixels(a0)
		move.w	#make_art_tile(ArtTile_Player_1,0,1),art_tile(a0)
		move.w	(Player_1+x_pos).w,x_pos(a0)
		move.w	(Player_1+y_pos).w,y_pos(a0)
		subi.w	#$C0,x_pos(a0)
		subi.w	#$C0,y_pos(a0)
		move.w	#0,x_vel(a0)
		move.w	#0,y_vel(a0)
		move.l	#Obj_SuperTailsBirds_Main,(a0)

Obj_SuperTailsBirds_Main:
		tst.b	(Super_Tails_flag).w
		bne.s	.tails_still_super
		; Tails has returned to normal - make the birds fly away
		moveq	#0,d0
		move.w	d0,(Player_2+x_pos).w
		move.w	d0,(Player_2+y_pos).w
		move.b	d0,(Player_2+anim).w
		tst.b	superTailsBirds_target_found(a0)
		beq.s	.no_target
		movea.w	superTailsBirds_target_address(a0),a1
		move.b	d0,$2D(a1)	; Seems to be for indicating whether an object has been 'locked-onto' or not

	.no_target:
		move.b	d0,superTailsBirds_target_found(a0)
		move.b	#60*2,superTailsBirds_search_delay(a0)	; Only search for enemies every two seconds (probably to reduce lag)
		move.l	#.FlyAway,(a0)

	.tails_still_super:
		bsr.s	.GetDestination

	.move:
		bsr.w	Obj_SuperTailsBirds_Move
		addi.b	#2,superTailsBirds_angle(a0)
		; Update which way the sprite faces
		tst.w	x_vel(a0)
		beq.s	.x_flip_done
		bpl.s	.face_right

		bset	#0,render_flags(a0)
		bra.s	.x_flip_done
; ---------------------------------------------------------------------------

	.face_right:
		bclr	#0,render_flags(a0)

	.x_flip_done:
		; Update whether the sprite should be upside down
		andi.b	#~2,render_flags(a0)
		tst.b	(Reverse_gravity_flag).w
		beq.s	+ ;.not_upside_down
		ori.b	#2,render_flags(a0)

+ ;	.not_upside_down:
		subq.b	#1,anim_frame_timer(a0)
		bpl.s	.timer_not_over
		move.b	#1,anim_frame_timer(a0)
		addq.b	#1,mapping_frame(a0)
		andi.b	#1,mapping_frame(a0)

	.timer_not_over:
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

.FlyAway:
		; Set bird's destination to top-left of the screen
		move.w	(Player_1+x_pos).w,d2
		move.w	(Player_1+y_pos).w,d3
		subi.w	#$C0,d2
		subi.w	#$C0,d3

		tst.b	render_flags(a0)
		bmi.s	Obj_SuperTailsBirds_Main.move
		jmp	(Delete_Current_Sprite).l	; If sprite is off-screen, delete it

; =============== S U B R O U T I N E =======================================


.GetDestination:
		tst.b	superTailsBirds_target_found(a0)
		bne.s	.fly_towards_enemy
		tst.b	superTailsBirds_search_delay(a0)
		beq.s	.look_for_target
		subq.b	#1,superTailsBirds_search_delay(a0)
		bra.s	.fly_around_tails
; ---------------------------------------------------------------------------

	.look_for_target:
		bsr.w	Obj_SuperTailsBirds_FindTarget
		tst.w	d1
		bne.s	.fly_towards_enemy

	.fly_around_tails:
		move.b	superTailsBirds_angle(a0),d0
		jsr	(GetSineCosine).l
		asr.w	#3,d0
		asr.w	#4,d1
		move.w	(Player_1+x_pos).w,d2
		move.w	(Player_1+y_pos).w,d3
		subi.w	#$20,d3
		tst.b	(Reverse_gravity_flag).w
		beq.s	+ ;.not_upside_down
		addi.w	#$20*2,d3

+ ;	.not_upside_down:
		add.w	d0,d2
		add.w	d1,d3
		rts
; ---------------------------------------------------------------------------

	.fly_towards_enemy:
		movea.w	superTailsBirds_target_address(a0),a1
		move.w	x_pos(a1),d2
		move.w	y_pos(a1),d3
		tst.b	render_flags(a1)
		bpl.s	.enemy_off_screen
		move.w	x_pos(a0),d0
		sub.w	d2,d0
		addi.w	#$C,d0
		cmpi.w	#$18,d0
		bhs.s	.enemy_out_of_range
		move.w	y_pos(a0),d1
		sub.w	d3,d1
		addi.w	#$C,d1
		cmpi.w	#$18,d1
		bhs.s	.enemy_out_of_range
		bsr.s	.hit_enemy

	.enemy_off_screen:
		move.b	#0,$2D(a1)
		move.b	#0,superTailsBirds_target_found(a0)
		move.b	#60*2,superTailsBirds_search_delay(a0)

	.enemy_out_of_range:
		rts
; End of function Obj_SuperTailsBirds_GetDestination


; =============== S U B R O U T I N E =======================================


	.hit_enemy:
		move.b	collision_flags(a1),d0
		beq.s	.no_collision	; If object has no collision, give up
		andi.b	#$C0,d0
		beq.s	.enemy
		cmpi.b	#$C0,d0
		beq.s	.special

	.no_collision:
		rts
; ---------------------------------------------------------------------------

	.enemy:
		tst.b	collision_property(a1)
		beq.s	.destroy_enemy
		; Boss
		move.b	collision_flags(a1),$25(a1)
		move.w	#Player_2,d0
		move.b	d0,$1C(a1)
		move.b	#0,collision_flags(a1)
		subq.b	#1,collision_property(a1)
		bne.s	.skip
		bset	#7,status(a1)

	.skip:
		bra.s	.done
; ---------------------------------------------------------------------------

	.destroy_enemy:
		jmp	(HyperTouch_DestroyEnemy).l
; ---------------------------------------------------------------------------

	.special:
		ori.b	#2,collision_property(a1)

	.done:
		move.w	x_pos(a0),(Player_2+x_pos).w
		move.w	y_pos(a0),(Player_2+y_pos).w
		move.b	#2,(Player_2+anim).w
		rts
; End of function sub_1A31E


; =============== S U B R O U T I N E =======================================


Obj_SuperTailsBirds_Move:
		; Update the bird's x_vel
		move.w	#$20,d1
		cmp.w	x_pos(a0),d2
		bge.s	.go_right
		neg.w	d1
		tst.w	x_vel(a0)
		bmi.s	.x_vel_done
		; Going the wrong way - make it turn around faster
		add.w	d1,d1
		add.w	d1,d1
		bra.s	.x_vel_done
; ---------------------------------------------------------------------------

	.go_right:
		tst.w	x_vel(a0)
		bpl.s	.x_vel_done
		; Going the wrong way - make it turn around faster
		add.w	d1,d1
		add.w	d1,d1

	.x_vel_done:
		add.w	d1,x_vel(a0)
		; Update the bird's y_vel
		and.w	(Screen_Y_wrap_value).w,d3
		move.w	#$20,d1
		sub.w	y_pos(a0),d3
		bcc.s	+ ;loc_1A3CA
		cmpi.w	#-$500,d3
		ble.s	++ ;loc_1A3D0

loc_1A3B4:
		cmpi.w	#-$1000,y_vel(a0)
		ble.s	+++ ;loc_1A3D8

loc_1A3BC:
		neg.w	d1
		tst.w	y_vel(a0)
		bmi.s	loc_1A3E2
		; Going the wrong way - make it turn around faster
		add.w	d1,d1
		add.w	d1,d1
		bra.s	loc_1A3E2
; ---------------------------------------------------------------------------

+ ;loc_1A3CA:
		cmpi.w	#$500,d3
		bge.s	loc_1A3B4

+ ;loc_1A3D0:
		cmpi.w	#$1000,y_vel(a0)
		bge.s	loc_1A3BC

+ ;loc_1A3D8:
		tst.w	y_vel(a0)
		bpl.s	loc_1A3E2
		; Going the wrong way - make it turn around faster
		add.w	d1,d1
		add.w	d1,d1

loc_1A3E2:
		add.w	d1,y_vel(a0)
		jsr	(MoveSprite2).l
		move.w	(Level_repeat_offset).w,d0
		sub.w	d0,x_pos(a0)
		move.w	(Screen_Y_wrap_value).w,d0
		and.w	d0,y_pos(a0)
		rts
; End of function sub_1A37A


; =============== S U B R O U T I N E =======================================


Obj_SuperTailsBirds_FindTarget:
		moveq	#0,d1
		lea	(Collision_response_list).w,a4
		move.w	(a4)+,d6
		beq.s	.return
		moveq	#0,d0
		addq.b	#2,(_unkF66C).w
		cmp.b	(_unkF66C).w,d6
		bhi.s	.noreset
		move.b	#0,(_unkF66C).w

	.noreset:
		move.b	(_unkF66C).w,d0
		sub.w	d0,d6
		lea	(a4,d0.w),a4

	.loop:
		movea.w	(a4)+,a1
		move.b	collision_flags(a1),d0
		beq.s	.ignore_object
		bsr.s	.check_if_object_valid

	.ignore_object:
		subq.w	#2,d6
		bne.s	.loop

	.return:
		rts
; End of function Obj_SuperTailsBirds_FindTarget


; =============== S U B R O U T I N E =======================================


	.check_if_object_valid:
		tst.b	render_flags(a1)
		bpl.s	.invalid
		tst.b	$2D(a1)
		bne.s	.invalid
		andi.b	#$C0,d0
		beq.s	.valid
		cmpi.b	#$C0,d0
		beq.s	.valid

	.invalid:
		rts
; ---------------------------------------------------------------------------

	.valid:
		move.b	#-1,$2D(a1)
		move.w	a1,superTailsBirds_target_address(a0)
		move.b	#1,superTailsBirds_target_found(a0)
		moveq	#1,d1
		moveq	#2,d6
		rts
; End of function sub_1A434

; ---------------------------------------------------------------------------
Map_SuperTails_Birds:
		include "General/Sprites/Tails/Map - Super Tails birds.asm"
; ---------------------------------------------------------------------------
		dc.l byte_189ED
		dc.b    0,  $B
		dc.l byte_18A02
		dc.b  $16,  $D
		dc.l byte_18A1B
		dc.b  $2C,  $D
; ---------------------------------------------------------------------------

Obj_HyperSonicKnux_Trail:
		; init
		move.l	#Map_Knuckles,mappings(a0)	; Load Knuckles' mappings
		cmpi.w	#3,(Player_mode).w		; Are we playing as Knuckles?
		beq.s	.playingasknux			; If so, branch
		move.l	#Map_SuperSonic,mappings(a0)	; If not, you must be Hyper Sonic, load Super/Hyper Sonic mappings

	.playingasknux:
		move.w	#make_art_tile(ArtTile_Player_1,0,0),art_tile(a0)
		move.w	#$100,priority(a0)
		move.b	#$18,width_pixels(a0)
		move.b	#$18,height_pixels(a0)
		move.b	#4,render_flags(a0)
		move.l	#.Main,(a0)

.Main:
		tst.b	(Super_Sonic_Knux_flag).w	; Are we in non-super/hyper state?
		beq.w	Delete_Current_Sprite		; If so, branch and delete
		moveq	#$C,d1				; This will be subtracted from Pos_table_index, giving the object an older entry
		btst	#0,(Level_frame_counter+1).w	; Even frame? (Think of it as 'every other number' logic)
		beq.s	.evenframe			; If so, branch
		moveq	#$14,d1				; On every other frame, use a different number to subtract, giving the object an even older entry

	.evenframe:
		move.w	(Pos_table_index).w,d0
		lea	(Pos_table).w,a1
		sub.b	d1,d0
		lea	(a1,d0.w),a1
		move.w	(a1)+,x_pos(a0)			; Use previous player x_pos
		move.w	(a1)+,y_pos(a0)			; Use previous player y_pos
		lea	(Stat_table).w,a1
		move.b	3(a1,d0.w),art_tile(a0)
		move.b	(Player_1+mapping_frame).w,mapping_frame(a0)	; Use player's current mapping_frame
		move.b	(Player_1+render_flags).w,render_flags(a0)	; Use player's current render_flags
		move.w	(Player_1+priority).w,priority(a0)		; Use player's current priority
		bra.w	Draw_Sprite

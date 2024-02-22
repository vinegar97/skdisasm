Obj_FBZEggPrison:
		lea	ObjDat_FBZEggPrison(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		move.l	#loc_89C14,(a0)
		lea	ChildObjDat_89EA8(pc),a2
		jsr	CreateChild1_Normal(pc)
		move.w	respawn_addr(a0),d0
		beq.s	locret_89C12
		movea.w	d0,a2
		btst	#0,(a2)
		beq.s	locret_89C12
		move.l	#loc_89C54,(a0)
		move.b	#1,mapping_frame(a0)
		bset	#5,$38(a0)

locret_89C12:
		rts
; ---------------------------------------------------------------------------

loc_89C14:
		btst	#1,$38(a0)
		beq.s	loc_89C54
		move.l	#loc_89C54,(a0)
		move.b	#1,mapping_frame(a0)
		move.w	respawn_addr(a0),d0
		beq.s	loc_89C34
		movea.w	d0,a2
		bset	#0,(a2)

loc_89C34:
		bsr.w	sub_89DAC
		lea	(Child6_CreateBossExplosion).l,a2
		jsr	(CreateChild6_Simple).l
		bne.s	loc_89C4C
		move.b	#8,subtype(a1)

loc_89C4C:
		lea	ChildObjDat_89EB0(pc),a2
		jsr	CreateChild1_Normal(pc)

loc_89C54:
		bsr.w	sub_89D9C
		jmp	Sprite_CheckDeleteTouch(pc)
; ---------------------------------------------------------------------------

loc_89C5C:
		lea	(word_86B3E).l,a1
		jsr	SetUp_ObjAttributes3(pc)
		move.l	#loc_8672A,(a0)
		movea.w	parent3(a0),a1
		btst	#5,$38(a1)
		beq.s	locret_89C84
		move.l	#loc_86754,(a0)
		move.b	#$C,mapping_frame(a0)

locret_89C84:
		rts
; ---------------------------------------------------------------------------

Obj_FBZSpringPlunger:
		lea	ObjDat_FBZSpringPlunger(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		move.b	#5,mapping_frame(a0)
		jsr	(sub_86A3E).l
		move.b	status(a0),d0
		andi.b	#standing_mask,d0
		beq.s	loc_89CDE
		move.b	#6,mapping_frame(a0)
		btst	#p1_standing_bit,d0
		beq.s	loc_89CC4
		move.b	#$C,mapping_frame(a0)
		lea	(Player_1).w,a1
		move.w	#-$A00,d0
		jsr	(sub_8635E).l

loc_89CC4:
		btst	#p2_standing_bit,d0
		beq.s	loc_89CDE
		move.b	#$C,mapping_frame(a0)
		lea	(Player_2).w,a1
		move.w	#-$A00,d0
		jsr	(sub_8635E).l

loc_89CDE:
		jmp	Sprite_CheckDelete(pc)
; ---------------------------------------------------------------------------

loc_89CE2:
		lea	word_89E96(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#loc_89D02,(a0)
		move.b	#8,y_radius(a0)
		bsr.w	sub_89DEE
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_89D02:
		subq.w	#1,$2E(a0)
		bpl.s	loc_89D14
		move.l	#loc_89D18,(a0)
		move.w	#$80,priority(a0)

loc_89D14:
		jmp	Sprite_CheckDelete(pc)
; ---------------------------------------------------------------------------

loc_89D18:
		jsr	MoveSprite_LightGravity(pc)
		jsr	(ObjCheckFloorDist).l
		tst.w	d1
		bpl.s	loc_89D30
		add.w	d1,y_pos(a0)
		move.w	$3E(a0),y_vel(a0)

loc_89D30:
		moveq	#0,d0
		btst	#3,(V_int_run_count+3).w
		bne.s	loc_89D3C
		moveq	#1,d0

loc_89D3C:
		move.b	d0,mapping_frame(a0)
		jmp	Sprite_CheckDelete(pc)
; ---------------------------------------------------------------------------

loc_89D44:
		lea	ObjDat3_89E9C(pc),a1
		jsr	SetUp_ObjAttributes(pc)
		move.l	#Obj_Bouncing_Ring,(a0)
		move.b	#-1,(Ring_spill_anim_counter).w
		move.b	#8,y_radius(a0)
		move.b	#8,x_radius(a0)
		move.b	#$84,render_flags(a0)
		moveq	#4,d0
		jsr	(Set_IndexedVelocity).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_89D78:
		lea	word_89E90(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#Obj_FlickerMove,(a0)
		jsr	(sub_86A64).l
		moveq	#4,d0
		jsr	(Set_IndexedVelocity).l
		jmp	(Draw_Sprite).l

; =============== S U B R O U T I N E =======================================


sub_89D9C:
		moveq	#$2B,d1
		moveq	#$18,d2
		moveq	#$18,d3
		move.w	x_pos(a0),d4
		jmp	(SolidObjectFull).l
; End of function sub_89D9C


; =============== S U B R O U T I N E =======================================


sub_89DAC:
		moveq	#0,d0
		move.b	subtype(a0),d0
		add.w	d0,d0
		move.w	off_89DBC(pc,d0.w),d0
		jmp	off_89DBC(pc,d0.w)
; End of function sub_89DAC

; ---------------------------------------------------------------------------
off_89DBC:
		dc.w loc_89DC4-off_89DBC
		dc.w loc_89DCC-off_89DBC
		dc.w loc_89DDE-off_89DBC
		dc.w loc_8F514-off_89DBC
; ---------------------------------------------------------------------------

loc_89DC4:
		lea	ChildObjDat_89ED0(pc),a2
		jmp	CreateChild1_Normal(pc)
; ---------------------------------------------------------------------------

loc_89DCC:
		move.w	#signextendB(sfx_RingLoss),d0
		jsr	(Play_SFX).l
		lea	ChildObjDat_89EF0(pc),a2
		jmp	CreateChild1_Normal(pc)
; ---------------------------------------------------------------------------

loc_89DDE:
		lea	ChildObjDat_89F16(pc),a2
		jsr	CreateChild1_Normal(pc)
		lea	ChildObjDat_89F24(pc),a2
		jmp	CreateChild1_Normal(pc)

; =============== S U B R O U T I N E =======================================


sub_89DEE:
		moveq	#0,d0
		move.b	subtype(a0),d0
		move.w	d0,d1
		andi.w	#6,d0
		lea	word_89E6C(pc),a1
		move.w	(a1,d0.w),d2
		move.w	d2,y_vel(a0)
		move.w	d2,$3E(a0)
		andi.w	#2,d0
		move.w	d0,d2
		move.w	word_89E74(pc,d2.w),art_tile(a0)
		moveq	#0,d2
		move.b	(Current_zone).w,d2
		add.w	d2,d2
		lea	(byte_2C7BA).l,a1
		adda.w	d2,a1
		lsr.w	#1,d0
		move.b	(a1,d0.w),d0
		lsl.w	#3,d0
		lea	(word_2C7EA).l,a2
		move.l	4(a2,d0.w),mappings(a0)
		lsl.w	#2,d1
		move.w	d1,$2E(a0)
		movea.w	parent3(a0),a1
		move.w	x_pos(a0),d0
		move.w	#$200,d1
		cmp.w	x_pos(a1),d0
		bhs.s	loc_89E54
		neg.w	d1

loc_89E54:
		move.w	d1,x_vel(a0)
		bclr	#0,render_flags(a0)
		tst.w	x_vel(a0)
		bpl.s	locret_89E6A
		bset	#0,render_flags(a0)

locret_89E6A:
		rts
; End of function sub_89DEE

; ---------------------------------------------------------------------------
word_89E6C:
		dc.w  -$380, -$300, -$280, -$200
word_89E74:
		dc.w make_art_tile($580,0,1)
		dc.w make_art_tile($592,0,1)
ObjDat_FBZEggPrison:
		dc.l Map_FBZEggCapsule
		dc.w make_art_tile($000,0,0)
		dc.w   $200
		dc.b  $20, $28,   0,   0
ObjDat_FBZSpringPlunger:
		dc.l Map_FBZEggCapsule
		dc.w make_art_tile($000,0,0)
		dc.w   $180
		dc.b  $10,   8,   5,   0
word_89E90:
		dc.w   $100
		dc.b    8,   8,   2,   0
word_89E96:
		dc.w   $280
		dc.b  $20, $28,   0,   0
ObjDat3_89E9C:
		dc.l Map_Ring
		dc.w make_art_tile(ArtTile_Ring,1,1)
		dc.w   $180
		dc.b    8,   8,   0, $47
ChildObjDat_89EA8:
		dc.w 1-1
		dc.l loc_89C5C
		dc.b    0,-$24
ChildObjDat_89EB0:
		dc.w 5-1
		dc.l loc_89D78
		dc.b    0,  -8
		dc.l loc_89D78
		dc.b -$10,  -8
		dc.l loc_89D78
		dc.b  $10,  -8
		dc.l loc_89D78
		dc.b -$18,  -8
		dc.l loc_89D78
		dc.b  $18,  -8
ChildObjDat_89ED0:
		dc.w 5-1
		dc.l loc_89CE2
		dc.b    0,  -4
		dc.l loc_89CE2
		dc.b  $10,  -4
		dc.l loc_89CE2
		dc.b -$10,  -4
		dc.l loc_89CE2
		dc.b  $1C,  -4
		dc.l loc_89CE2
		dc.b -$1C,  -4
ChildObjDat_89EF0:
		dc.w 6-1
		dc.l loc_89D44
		dc.b   -8,  -4
		dc.l loc_89D44
		dc.b    8,  -4
		dc.l loc_89D44
		dc.b  $10,  -4
		dc.l loc_89D44
		dc.b -$10,  -4
		dc.l loc_89D44
		dc.b  $18,  -4
		dc.l loc_89D44
		dc.b -$18,  -4
ChildObjDat_89F16:
		dc.w 2-1
		dc.l loc_89650
		dc.b -$18,  -4
		dc.l loc_89650
		dc.b  $18,  -4
ChildObjDat_89F24:
		dc.w 2-1
		dc.l loc_89A5A
		dc.b   -8,  -4
		dc.l loc_89A5A
		dc.b    8,  -4
; ---------------------------------------------------------------------------

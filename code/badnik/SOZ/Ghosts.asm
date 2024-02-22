Obj_SOZGhosts:
		move.l	#loc_8F0CA,(a0)
		move.w	#$120,x_pos(a0)
		move.w	#$A0,y_pos(a0)

loc_8F0CA:
		cmpi.b	#2,(Player_1+character_id).w
		beq.s	loc_8F0DA
		tst.b	(Last_star_post_hit).w
		beq.w	locret_8F436

loc_8F0DA:
		moveq	#0,d0
		move.b	(_unkF7C3).w,d0
		beq.s	loc_8F112
		move.b	byte_8F118(pc,d0.w),d0
		move.b	(_unkFAAD).w,d1
		cmp.b	d0,d1
		bhs.w	locret_8F436
		subq.w	#1,$3A(a0)
		bpl.w	locret_8F436
		addq.b	#1,d1
		move.b	d1,(_unkFAAD).w
		cmp.b	d0,d1
		bhs.s	loc_8F108
		move.w	#$3F,$3A(a0)

loc_8F108:
		lea	ChildObjDat_8F674(pc),a2
		jmp	(CreateChild6_Simple).l
; ---------------------------------------------------------------------------

loc_8F112:
		clr.b	(_unkFAAD).w
		rts
; ---------------------------------------------------------------------------
byte_8F118:
		dc.b    0,   1,   2,   2,   3,   3
		even
; ---------------------------------------------------------------------------

loc_8F11E:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_8F19A(pc,d0.w),d1
		jsr	off_8F19A(pc,d1.w)
		lea	DPLCPtr_SOZGhosts(pc),a2
		jsr	(Perform_DPLC).l
		tst.b	render_flags(a0)
		bpl.s	loc_8F16A
		tst.b	(_unkF7C3).w
		beq.s	loc_8F174
		jsr	(Check_PlayerCollision).l
		beq.s	loc_8F15E
		jsr	(Check_PlayerAttack).l
		bne.s	loc_8F174
		tst.b	invulnerability_timer(a1)
		bne.s	loc_8F15E
		jsr	(HurtCharacter_Directly).l

loc_8F15E:
		jsr	(Add_SpriteToCollisionResponseList).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_8F16A:
		subq.b	#1,(_unkFAAD).w
		jmp	(Go_Delete_SpriteSlotted2).l
; ---------------------------------------------------------------------------

loc_8F174:
		move.l	#loc_8F37A,(a0)
		move.l	#loc_8F16A,$34(a0)
		lea	byte_8F6BF(pc),a1
		jsr	(Set_Raw_Animation).l
		moveq	#signextendB(sfx_Bouncy),d0
		jsr	(Play_SFX).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
off_8F19A:
		dc.w loc_8F1AC-off_8F19A
		dc.w loc_8F1DA-off_8F19A
		dc.w loc_8F1FE-off_8F19A
		dc.w loc_8F226-off_8F19A
		dc.w loc_8F26E-off_8F19A
		dc.w loc_8F2BE-off_8F19A
		dc.w loc_8F2E0-off_8F19A
		dc.w loc_8F322-off_8F19A
		dc.w loc_8F36E-off_8F19A
; ---------------------------------------------------------------------------

loc_8F1AC:
		lea	ObjSlot_SOZGhosts(pc),a1
		jsr	(SetUp_ObjAttributesSlotted).l
		bclr	#2,render_flags(a0)
		bset	#7,render_flags(a0)
		move.b	(_unkF7C3).w,child_dx(a0)
		move.b	(_unkFAAD).w,child_dy(a0)
		bsr.w	sub_8F538
		moveq	#signextendB(sfx_GhostAppear),d0
		jsr	(Play_SFX).l

loc_8F1DA:
		jsr	(Animate_RawMultiDelay).l
		tst.w	d2
		beq.s	locret_8F1F2
		cmpi.b	#5,(_unkF7C3).w
		beq.s	loc_8F1F4
		move.b	#4,routine(a0)

locret_8F1F2:
		rts
; ---------------------------------------------------------------------------

loc_8F1F4:
		move.b	#$C,routine(a0)
		bra.w	loc_8F58E
; ---------------------------------------------------------------------------

loc_8F1FE:
		jsr	(Animate_RawMultiDelay).l
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		bsr.w	sub_8F4F0
		move.b	(_unkF7C3).w,d0
		cmp.b	child_dx(a0),d0
		beq.s	locret_8F224
		move.b	#6,routine(a0)

locret_8F224:
		rts
; ---------------------------------------------------------------------------

loc_8F226:
		jsr	(Animate_RawMultiDelay).l
		jsr	(Swing_UpAndDown).l
		tst.w	d3
		bne.s	loc_8F240
		jsr	(MoveSprite2).l
		bra.w	sub_8F4F0
; ---------------------------------------------------------------------------

loc_8F240:
		move.b	#8,routine(a0)
		moveq	#0,d0
		move.b	(_unkF7C3).w,d0
		move.b	byte_8F268(pc,d0.w),d1
		beq.w	locret_8F436
		move.b	d0,child_dx(a0)
		cmpi.b	#5,d0
		beq.s	loc_8F1F4
		move.b	#4,routine(a0)
		bra.w	loc_8F58E
; ---------------------------------------------------------------------------
byte_8F268:
		dc.b    0,   0,   0,   1,   0,   1
		even
; ---------------------------------------------------------------------------

loc_8F26E:
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		bsr.w	sub_8F4F0
		jsr	(Animate_RawMultiDelay).l
		beq.s	locret_8F2B0
		cmpi.b	#2,anim_frame(a0)
		bne.s	locret_8F2B0
		move.b	#$A,routine(a0)
		move.b	(_unkF7C3).w,d0
		move.b	d0,child_dx(a0)
		add.w	d0,d0
		andi.w	#$C,d0
		movea.l	off_8F2B2(pc,d0.w),a1
		move.b	(a1),mapping_frame(a0)
		jsr	(Set_Raw_Animation).l

locret_8F2B0:
		rts
; ---------------------------------------------------------------------------
off_8F2B2:
		dc.l byte_8F6CC
		dc.l byte_8F6CC
		dc.l byte_8F6D4
; ---------------------------------------------------------------------------

loc_8F2BE:
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		bsr.w	sub_8F4F0
		jsr	(Animate_RawMultiDelay).l
		tst.w	d2
		beq.s	locret_8F2DE
		move.b	#4,routine(a0)

locret_8F2DE:
		rts
; ---------------------------------------------------------------------------

loc_8F2E0:
		jsr	(Animate_RawMultiDelay).l
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		move.w	x_pos(a0),d0
		tst.w	x_vel(a0)
		bmi.s	loc_8F304
		cmpi.w	#$1A0,d0
		bhi.s	loc_8F30A
		rts
; ---------------------------------------------------------------------------

loc_8F304:
		cmpi.w	#$A0,d0
		bhs.s	locret_8F320

loc_8F30A:
		move.b	#$E,routine(a0)
		bchg	#0,render_flags(a0)
		neg.w	x_vel(a0)
		move.w	#60-1,$2E(a0)

locret_8F320:
		rts
; ---------------------------------------------------------------------------

loc_8F322:
		jsr	(Animate_RawMultiDelay).l
		subq.w	#1,$2E(a0)
		bpl.w	locret_8F436
		move.b	#$10,routine(a0)
		move.b	#$D7,collision_flags(a0)
		bset	#2,render_flags(a0)
		move.w	(Camera_X_pos).w,d0
		move.w	x_pos(a0),d1
		subi.w	#$80,d1
		add.w	d1,d0
		move.w	d0,x_pos(a0)
		move.w	(Camera_Y_pos).w,d0
		move.w	y_pos(a0),d1
		subi.w	#$80,d1
		add.w	d1,d0
		move.w	d0,y_pos(a0)
		move.w	#$100,y_vel(a0)
		rts
; ---------------------------------------------------------------------------

loc_8F36E:
		jsr	(Animate_RawMultiDelay).l
		jmp	(MoveSprite2).l
; ---------------------------------------------------------------------------

loc_8F37A:
		jsr	(Animate_RawMultiDelay).l
		lea	DPLCPtr_SOZGhosts(pc),a2
		jsr	(Perform_DPLC).l
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

Obj_SOZGhostCapsuleLoadArt:
		moveq	#0,d0
		move.b	subtype(a0),d0
		movea.l	off_8F3BE(pc,d0.w),a1
		jsr	(Check_PlayerInRange).l
		tst.l	d0
		beq.w	locret_8F436
		tst.w	d0
		beq.w	locret_8F436
		moveq	#0,d0
		move.b	subtype(a0),d0
		movea.l	off_8F3C6(pc,d0.w),a1
		jsr	(a1)
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------
off_8F3BE:
		dc.l word_8F3CE
		dc.l word_8F3D6
off_8F3C6:
		dc.l loc_8F3DE
		dc.l loc_8F3F0
word_8F3CE:
		dc.w   -$10,   $20,  -$40,   $80
word_8F3D6:
		dc.w   -$10,   $20,  -$80,  $100
; ---------------------------------------------------------------------------

loc_8F3DE:
		lea	PLC_SOZGhostCapsule(pc),a1
		jmp	(Load_PLC_Raw).l
; ---------------------------------------------------------------------------
PLC_SOZGhostCapsule: plrlistheader
		plreq $536, ArtNem_EggCapsule
PLC_SOZGhostCapsule_End
; ---------------------------------------------------------------------------

loc_8F3F0:
		jmp	(LoadEnemyArt).l
; ---------------------------------------------------------------------------

Obj_SOZGhostCapsule:
		lea	ObjDat_SOZGhostCapsule(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#loc_89C14,(a0)
		move.b	#3,subtype(a0)
		lea	ChildObjDat_8F646(pc),a2
		jsr	(CreateChild1_Normal).l
		tst.b	(Last_star_post_hit).w
		bne.s	loc_8F424
		cmpi.b	#2,(Player_1+character_id).w
		bne.s	locret_8F436

loc_8F424:
		move.l	#loc_89C54,(a0)
		move.b	#1,mapping_frame(a0)
		bset	#5,$38(a0)

locret_8F436:
		rts
; ---------------------------------------------------------------------------

loc_8F438:
		lea	(word_86B3E).l,a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#loc_8672A,(a0)
		tst.b	(Last_star_post_hit).w
		beq.s	locret_8F45C
		move.l	#loc_86754,(a0)
		move.b	#$C,mapping_frame(a0)

locret_8F45C:
		rts
; ---------------------------------------------------------------------------

loc_8F45E:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_8F488(pc,d0.w),d1
		jsr	off_8F488(pc,d1.w)
		tst.b	subtype(a0)
		bne.s	loc_8F482
		lea	DPLCPtr_SOZGhosts(pc),a2
		jsr	(Perform_DPLC).l
		jmp	(Sprite_CheckDeleteSlotted).l
; ---------------------------------------------------------------------------

loc_8F482:
		jmp	(Sprite_CheckDelete).l
; ---------------------------------------------------------------------------
off_8F488:
		dc.w loc_8F48E-off_8F488
		dc.w loc_8F4D8-off_8F488
		dc.w loc_8F4E2-off_8F488
; ---------------------------------------------------------------------------

loc_8F48E:
		moveq	#0,d0
		move.b	subtype(a0),d0
		add.w	d0,d0
		lea	word_8F4C0(pc,d0.w),a1
		move.w	(a1)+,x_vel(a0)
		move.w	(a1)+,$40(a0)
		jsr	(Change_FlipXWithVelocity).l
		tst.w	d0
		bne.s	loc_8F4B6
		lea	ObjSlot_SOZGhosts(pc),a1
		jmp	(SetUp_ObjAttributesSlotted).l
; ---------------------------------------------------------------------------

loc_8F4B6:
		lea	ObjDat3_8F63A(pc),a1
		jmp	(SetUp_ObjAttributes).l
; ---------------------------------------------------------------------------
word_8F4C0:
		dc.w  -$200,  -$20
		dc.w   $200,  -$20
		dc.w  -$280,  -$18
		dc.w   $280,  -$18
		dc.w  -$300,  -$10
		dc.w   $300,  -$10
; ---------------------------------------------------------------------------

loc_8F4D8:
		lea	byte_8F68E(pc),a1
		jsr	(Animate_RawNoSST).l

loc_8F4E2:
		move.w	$40(a0),d0
		add.w	d0,y_vel(a0)
		jmp	(MoveSprite2).l

; =============== S U B R O U T I N E =======================================


sub_8F4F0:
		move.w	x_pos(a0),d0
		tst.w	x_vel(a0)
		bmi.s	loc_8F502
		cmpi.w	#$1A0,d0
		bhi.s	loc_8F508
		rts
; ---------------------------------------------------------------------------

loc_8F502:
		cmpi.w	#$A0,d0
		bhs.s	locret_8F512

loc_8F508:
		bchg	#0,render_flags(a0)
		neg.w	x_vel(a0)

locret_8F512:
		rts
; End of function sub_8F4F0

; ---------------------------------------------------------------------------

loc_8F514:
		move.b	#1,(Last_star_post_hit).w
		lea	(SOZ2_Start).l,a1
		move.w	(a1)+,(Saved_X_pos).w
		move.w	(a1)+,(Saved_Y_pos).w
		jsr	(Save_Level_Data).l
		lea	ChildObjDat_8F64E(pc),a2
		jmp	(CreateChild1_Normal).l

; =============== S U B R O U T I N E =======================================


sub_8F538:
		jsr	(Random_Number).l
		andi.w	#$FF,d0
		subi.w	#$7F,d0
		add.w	d0,x_pos(a0)
		moveq	#0,d1
		move.b	(_unkF7C3).w,d1
		add.w	d1,d1
		move.w	word_8F582(pc,d1.w),d2
		cmpi.w	#$120,d0
		bhs.s	loc_8F564
		bset	#0,render_flags(a0)
		neg.w	d2

loc_8F564:
		move.w	d2,x_vel(a0)
		andi.w	#$C,d1
		move.l	off_8F576(pc,d1.w),$30(a0)
		bra.w	loc_8F58E
; ---------------------------------------------------------------------------
off_8F576:
		dc.l byte_8F682
		dc.l byte_8F695
		dc.l byte_8F6AA
word_8F582:
		dc.w  -$100
		dc.w  -$100
		dc.w  -$100
		dc.w  -$180
		dc.w  -$180
		dc.w  -$200
; ---------------------------------------------------------------------------

loc_8F58E:
		moveq	#0,d0
		move.b	(_unkF7C3).w,d0
		add.w	d0,d0
		move.w	word_8F582(pc,d0.w),d1
		tst.w	x_vel(a0)
		bmi.s	loc_8F5A2
		neg.w	d1

loc_8F5A2:
		move.w	d1,x_vel(a0)
		add.w	d0,d0
		movea.l	off_8F5C8(pc,d0.w),a1
		bclr	#0,$38(a0)
		jsr	(a1)
		tst.w	y_vel(a0)
		bpl.s	loc_8F5C2
		bset	#0,$38(a0)
		neg.w	d0

loc_8F5C2:
		move.w	d0,y_vel(a0)
		rts
; End of function sub_8F538

; ---------------------------------------------------------------------------
off_8F5C8:
		dc.l loc_8F5E0
		dc.l loc_8F5E0
		dc.l loc_8F5E0
		dc.l loc_8F5F0
		dc.l loc_8F5F0
		dc.l loc_8F606
; ---------------------------------------------------------------------------

loc_8F5E0:
		move.w	#$40,d0
		move.w	d0,$3E(a0)
		move.w	#4,$40(a0)
		rts
; ---------------------------------------------------------------------------

loc_8F5F0:
		move.w	#$80,d0
		move.w	d0,$3E(a0)
		move.w	#8,$40(a0)
		bclr	#0,$38(a0)
		rts
; ---------------------------------------------------------------------------

loc_8F606:
		move.w	#$C0,d0
		move.w	d0,$3E(a0)
		move.w	#$10,$40(a0)
		bclr	#0,$38(a0)
		rts
; ---------------------------------------------------------------------------
ObjSlot_SOZGhosts:
		dc.w 3-1
		dc.w make_art_tile($500,1,1)
		dc.w    $12
		dc.w      0
		dc.l Map_SOZGhosts
		dc.w      0
		dc.b  $10, $14,   0,   0
ObjDat_SOZGhostCapsule:
		dc.l Map_EggCapsule
		dc.w make_art_tile($536,0,1)
		dc.w   $180
		dc.b  $30, $20,   0,   0
ObjDat3_8F63A:
		dc.l Map_SOZGhosts
		dc.w make_art_tile($500,1,1)
		dc.w   $200
		dc.b  $30, $20,   0,   0
ChildObjDat_8F646:
		dc.w 1-1
		dc.l loc_8F438
		dc.b    0,-$24
ChildObjDat_8F64E:
		dc.w 6-1
		dc.l loc_8F45E
		dc.b   -8,  -4
		dc.l loc_8F45E
		dc.b    8,  -4
		dc.l loc_8F45E
		dc.b  $10,  -4
		dc.l loc_8F45E
		dc.b -$10,  -4
		dc.l loc_8F45E
		dc.b  $18,  -4
		dc.l loc_8F45E
		dc.b -$18,  -4
ChildObjDat_8F674:
		dc.w 1-1
		dc.l loc_8F11E
DPLCPtr_SOZGhosts:
		dc.l ArtUnc_SOZGhosts
		dc.l DPLC_SOZGhosts
byte_8F682:
		dc.b  $11,   3
		dc.b  $11,   3
		dc.b  $10,   3
		dc.b   $F,   4
		dc.b   $E,   4
		dc.b  $F8,  $C
byte_8F68E:
		dc.b    0,   3,   1,   3,   2,   4, $FC
byte_8F695:
		dc.b  $11,   3
		dc.b  $11,   3
		dc.b  $10,   3
		dc.b   $F,   4
		dc.b   $E,   4
		dc.b   $D,   4
		dc.b  $F8,  $E
		; unused
		dc.b    5,   3
		dc.b    6,   3
		dc.b    7,   4
		dc.b  $FC
byte_8F6AA:
		dc.b  $11,   3
		dc.b  $11,   3
		dc.b  $10,   3
		dc.b   $F,   4
		dc.b   $E,   4
		dc.b   $D,   4
		dc.b  $F8,  $E
		; unused
		dc.b   $A,   3
		dc.b   $B,   3
		dc.b   $C,   4
		dc.b  $FC
byte_8F6BF:
		dc.b   $D,   4
		dc.b   $D,   4
		dc.b   $E,   4
		dc.b   $F,   4
		dc.b  $10,   3
		dc.b  $11,   3
		dc.b  $F4
byte_8F6CC:
		dc.b    3,   7
		dc.b    3,   7
		dc.b    4,   7
		dc.b  $F8, $D7
byte_8F6D4:
		dc.b    8,   7
		dc.b    8,   7
		dc.b    9,   7
		dc.b  $F8, $E4
DPLC_SOZGhosts:
		include "General/Sprites/SOZ Ghosts/DPLC - SOZ Ghosts.asm"
; ---------------------------------------------------------------------------

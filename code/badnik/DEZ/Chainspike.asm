Obj_Chainspike:
		jsr	(Obj_WaitOffscreen).l
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	Chainspike_Index(pc,d0.w),d1
		jsr	Chainspike_Index(pc,d1.w)
		jmp	(Sprite_CheckDeleteTouch).l
; ---------------------------------------------------------------------------
Chainspike_Index:
		dc.w loc_91C62-Chainspike_Index
		dc.w loc_91C9A-Chainspike_Index
		dc.w loc_91CC2-Chainspike_Index
		dc.w loc_91D0C-Chainspike_Index
		dc.w loc_91D20-Chainspike_Index
		dc.w loc_91D36-Chainspike_Index
; ---------------------------------------------------------------------------

loc_91C62:
		lea	ObjDat_Chainspike(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.w	#-$1200,d0
		move.w	#$180,d1
		btst	#0,render_flags(a0)
		beq.s	loc_91C80
		neg.w	d0
		neg.w	d1

loc_91C80:
		move.w	d0,$3E(a0)
		move.w	d1,$3C(a0)
		move.l	#loc_91CA6,$34(a0)
		lea	ChildObjDat_91EEC(pc),a2
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

loc_91C9A:
		jsr	(sub_91E7E).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_91CA6:
		move.b	#4,routine(a0)
		move.w	$3E(a0),x_vel(a0)
		move.w	$3C(a0),$40(a0)
		moveq	#signextendB(sfx_TunnelBooster),d0
		jsr	(Play_SFX).l
		rts
; ---------------------------------------------------------------------------

loc_91CC2:
		jsr	(sub_91E7E).l
		move.w	x_vel(a0),d0
		moveq	#$C,d2
		move.w	$40(a0),d1
		bmi.s	loc_91CD6
		neg.w	d2

loc_91CD6:
		add.w	d2,d1
		move.w	d1,$40(a0)
		add.w	d1,d0
		smi	d2
		tst.w	$3E(a0)
		bpl.s	loc_91CE8
		not.b	d2

loc_91CE8:
		tst.b	d2
		bne.s	loc_91CF6
		move.w	d0,x_vel(a0)
		jmp	(MoveSprite2).l
; ---------------------------------------------------------------------------

loc_91CF6:
		move.b	#2,routine(a0)
		move.w	#(2*60)-1,$2E(a0)
		neg.w	$3E(a0)
		neg.w	$3C(a0)
		rts
; ---------------------------------------------------------------------------

loc_91D0C:
		jmp	(Animate_RawGetFaster).l
; ---------------------------------------------------------------------------

loc_91D12:
		move.b	#8,routine(a0)
		bset	#1,$38(a0)
		rts
; ---------------------------------------------------------------------------

loc_91D20:
		btst	#1,$38(a0)
		bne.s	locret_91D34
		move.b	#$A,routine(a0)
		move.b	#$1F,$39(a0)

locret_91D34:
		rts
; ---------------------------------------------------------------------------

loc_91D36:
		subq.b	#1,$39(a0)
		bpl.s	locret_91D50
		move.b	$3A(a0),routine(a0)
		move.w	$26(a0),$2E(a0)
		move.l	#loc_91CA6,$34(a0)

locret_91D50:
		rts
; ---------------------------------------------------------------------------

loc_91D52:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	off_91D66(pc,d0.w),d1
		jsr	off_91D66(pc,d1.w)
		jmp	(Child_DrawTouch_Sprite).l
; ---------------------------------------------------------------------------
off_91D66:
		dc.w loc_91D6C-off_91D66
		dc.w loc_91D8C-off_91D66
		dc.w loc_91DE2-off_91D66
; ---------------------------------------------------------------------------

loc_91D6C:
		lea	word_91EE6(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.l	#loc_91E46,$34(a0)
		tst.b	subtype(a0)
		beq.s	locret_91D8A
		bset	#1,render_flags(a0)

locret_91D8A:
		rts
; ---------------------------------------------------------------------------

loc_91D8C:
		jsr	(Refresh_ChildPosition).l
		movea.w	parent3(a0),a1
		btst	#1,$38(a1)
		beq.s	locret_91DE0
		btst	#1,render_flags(a1)
		sne	d0
		tst.b	subtype(a0)
		beq.s	loc_91DAE
		not.b	d0

loc_91DAE:
		tst.b	d0
		bne.s	locret_91DE0
		move.b	#4,routine(a0)
		move.b	#$18,collision_flags(a0)
		move.b	#-1,collision_property(a0)
		moveq	#8,d0
		btst	#1,render_flags(a1)
		beq.s	loc_91DD0
		neg.w	d0

loc_91DD0:
		move.w	d0,y_vel(a0)
		move.w	y_pos(a0),$3A(a0)
		move.w	#$17,$2E(a0)

locret_91DE0:
		rts
; ---------------------------------------------------------------------------

loc_91DE2:
		move.w	y_pos(a0),d0
		add.w	y_vel(a0),d0
		move.w	d0,y_pos(a0)
		bsr.w	sub_91EB0
		cmp.w	$3A(a0),d0
		beq.s	loc_91E22
		btst	#1,render_flags(a0)
		sne	d0
		tst.w	y_vel(a0)
		bmi.s	loc_91E08
		not.b	d0

loc_91E08:
		tst.b	d0
		beq.s	loc_91E1C
		jsr	(ObjCheckFloorDist).l
		tst.w	d1
		bmi.s	loc_91E46
		tst.b	collision_flags(a0)
		beq.s	loc_91E40

loc_91E1C:
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

loc_91E22:
		move.b	#2,routine(a0)
		move.b	#$98,collision_flags(a0)
		move.b	#2,mapping_frame(a0)
		movea.w	$46(a0),a1
		bclr	#1,$38(a1)
		rts
; ---------------------------------------------------------------------------

loc_91E40:
		move.b	#$18,collision_flags(a0)

loc_91E46:
		move.w	#$5F,$2E(a0)
		move.w	y_vel(a0),d0
		asr.w	#2,d0
		neg.w	d0
		move.w	d0,y_vel(a0)
		rts
; ---------------------------------------------------------------------------

loc_91E5A:
		move.b	#$98,collision_flags(a0)
		move.b	#8,width_pixels(a0)
		move.b	#8,height_pixels(a0)
		move.l	#loc_91E72,(a0)

loc_91E72:
		jsr	(Refresh_ChildPosition).l
		jmp	(Child_AddToTouchList).l

; =============== S U B R O U T I N E =======================================


sub_91E7E:
		jsr	(Find_SonicTails).l
		cmpi.w	#$10,d2
		bhs.s	locret_91EAE
		move.b	routine(a0),$3A(a0)
		move.b	#6,routine(a0)
		move.w	$2E(a0),$26(a0)
		move.l	#byte_91F06,$30(a0)
		move.l	#loc_91D12,$34(a0)
		addq.w	#4,sp

locret_91EAE:
		rts
; End of function sub_91E7E


; =============== S U B R O U T I N E =======================================


sub_91EB0:
		move.w	$3A(a0),d1
		sub.w	d0,d1
		bpl.s	loc_91EBA
		neg.w	d1

loc_91EBA:
		moveq	#0,d2
		moveq	#$18,d3
		moveq	#4-1,d4

loc_91EC0:
		add.w	d3,d2
		cmp.w	d2,d1
		bls.s	loc_91ECC
		dbf	d4,loc_91EC0
		moveq	#0,d4

loc_91ECC:
		move.b	RawAni_91ED4(pc,d4.w),mapping_frame(a0)
		rts
; End of function sub_91EB0

; ---------------------------------------------------------------------------
RawAni_91ED4:
		dc.b    7,   6,   5,   4,   2
		even
ObjDat_Chainspike:
		dc.l Map_Chainspike
		dc.w make_art_tile($542,1,1)
		dc.w   $280
		dc.b  $18,  $C,   0, $1A
word_91EE6:
		dc.w   $280
		dc.b    8, $80,   2, $98
ChildObjDat_91EEC:
		dc.w 4-1
		dc.l loc_91D52
		dc.b    0, $14
		dc.l loc_91D52
		dc.b    0,-$14
		dc.l loc_91E5A
		dc.b  $14,   0
		dc.l loc_91E5A
		dc.b -$14,   0
byte_91F06:
		dc.b    5,   6
		dc.b    0,   3
		dc.b  $FC, $FF
		even

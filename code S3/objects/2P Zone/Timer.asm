loc_37220:
		move.l	#$FF7000,mappings(a0)
		move.w	#make_art_tile($600,0,1),art_tile(a0)
		move.w	#0,priority(a0)
		move.b	#$40,width_pixels(a0)
		move.b	#$10,height_pixels(a0)
		move.w	#$C8,x_pos(a0)
		move.w	#$90,y_pos(a0)
		bset	#3,render_flags(a0)
		lea	(word_37420).l,a1
		lea	($FF7000).l,a2
		move.w	#bytesToWcnt($34),d0

loc_37262:
		move.w	(a1)+,(a2)+
		dbf	d0,loc_37262
		move.l	#loc_3726E,(a0)

loc_3726E:
		lea	(Score).w,a1
		lea	($FF700A).l,a2
		lea	(Timer_minute).w,a3
		moveq	#0,d1
		move.b	(Competition_lap_count).w,d1
		lea	(Update_HUD_timer).w,a4
		lea	(Competition_time_record).w,a5
		lea	($FF7828).l,a6
		bra.s	loc_3730E
; ---------------------------------------------------------------------------

loc_37292:
		tst.b	(Not_ghost_flag).w
		bne.s	loc_3729E
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

loc_3729E:
		move.l	#$FF7080,mappings(a0)
		move.w	#make_art_tile($600,0,1),art_tile(a0)
		move.w	#0,priority(a0)
		move.b	#$40,width_pixels(a0)
		move.b	#$10,height_pixels(a0)
		move.w	#$C8,x_pos(a0)
		move.w	#$90,y_pos(a0)
		bset	#4,render_flags(a0)
		lea	(word_37420).l,a1
		lea	($FF7080).l,a2
		move.w	#bytesToWcnt($34),d0

loc_372E0:
		move.w	(a1)+,(a2)+
		dbf	d0,loc_372E0
		move.l	#loc_372EC,(a0)

loc_372EC:
		lea	(Score_P2).w,a1
		lea	($FF708A).l,a2
		lea	(Timer_minute_P2).w,a3
		moveq	#0,d1
		move.b	(Competition_lap_count_2P).w,d1
		lea	(Update_HUD_timer_P2).w,a4
		lea	(Competition_time_record_P2).w,a5
		lea	($FF7840).l,a6

loc_3730E:
		tst.b	(a4)
		beq.s	loc_37342
		bmi.s	loc_37342
		cmpi.l	#(9<<16)|(59<<8)|99,(a5)
		blo.s	loc_37328
		move.b	#$80,(a4)
		move.l	#(9<<16)|(59<<8)|99,(a5)
		bra.s	loc_37362
; ---------------------------------------------------------------------------

loc_37328:
		addq.b	#1,-(a1)
		cmpi.b	#60,(a1)
		blo.s	loc_37342
		move.b	#0,(a1)
		addq.b	#1,-(a1)
		cmpi.b	#60,(a1)
		blo.s	loc_37342
		move.b	#0,(a1)
		addq.b	#1,-(a1)

loc_37342:
		move.l	-1(a3),d6
		jsr	(sub_9F48).l
		cmpi.w	#5,d1
		bhs.s	loc_37362
		lsl.w	#2,d1
		move.l	d6,(a6,d1.w)
		move.l	$14(a6),d5
		jsr	sub_36508(pc)
		move.l	d6,(a5)

loc_37362:
		addq.w	#1,a5
		lea	word_373BC(pc),a1
		moveq	#0,d0
		move.b	(a5)+,d0
		lsl.w	#2,d0
		move.l	(a1,d0.w),(a2)+
		addq.w	#8,a2
		moveq	#0,d0
		move.b	(a5)+,d0
		moveq	#0,d2

loc_3737A:
		subi.w	#$A,d0
		bcs.s	loc_37384
		addq.w	#4,d2
		bra.s	loc_3737A
; ---------------------------------------------------------------------------

loc_37384:
		addi.w	#$A,d0
		move.l	(a1,d2.w),(a2)+
		addq.w	#2,a2
		lsl.w	#2,d0
		move.l	(a1,d0.w),(a2)+
		addq.w	#8,a2
		moveq	#0,d0
		move.b	(a5)+,d0
		moveq	#0,d2

loc_3739C:
		subi.w	#$A,d0
		bcs.s	loc_373A6
		addq.w	#4,d2
		bra.s	loc_3739C
; ---------------------------------------------------------------------------

loc_373A6:
		addi.w	#$A,d0
		move.l	(a1,d2.w),(a2)+
		addq.w	#2,a2
		lsl.w	#2,d0
		move.l	(a1,d0.w),(a2)+
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------
word_373BC:
		dc.w  $F805,     8
		dc.w  $F801,    $C
		dc.w  $F805,    $E
		dc.w  $F805,   $12
		dc.w  $F805,   $16
		dc.w  $F805,   $1A
		dc.w  $F805,   $1E
		dc.w  $F805,   $22
		dc.w  $F805,   $26
		dc.w  $F805,   $2A
byte_373E4:
		dc.b    0,   1,   3,   5,   6,   8,  $A,  $B,  $D,  $F, $10, $12, $14, $15, $17, $19, $1A, $1C, $1E, $1F
		dc.b  $21, $23, $24, $26, $28, $29, $2B, $2D, $2E, $30, $32, $33, $35, $37, $38, $3A, $3C, $3D, $3F, $41
		dc.b  $42, $44, $46, $47, $49, $4B, $4C, $4E, $50, $51, $53, $55, $56, $58, $5A, $5B, $5D, $5F, $60, $62
word_37420:
		dc.w word_37422-word_37420
word_37422:	dc.w 8
		dc.b  $F8,  $D,   0,   0, $FF, $C0
		dc.b  $F8,   5,   0,   8, $FF, $E8
		dc.b  $F0,   0,   0, $2E, $FF, $F4
		dc.b  $F8,   5,   0,   8, $FF, $FC
		dc.b  $F8,   5,   0,   8,   0,   8
		dc.b  $F0,   0,   0, $2F,   0, $14
		dc.b  $F8,   5,   0,   8,   0, $1C
		dc.b  $F8,   5,   0,   8,   0, $28
; ---------------------------------------------------------------------------

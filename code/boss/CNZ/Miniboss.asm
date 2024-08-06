Obj_CNZMiniboss:
		move.w	#$31E0,d0
		cmp.w	(Camera_X_pos).w,d0	; Wait for Player to get in range
		bls.s	+ ;loc_6D9A8
		rts
; ---------------------------------------------------------------------------

+ ;loc_6D9A8:
		move.w	(Camera_max_X_pos).w,(Camera_stored_max_X_pos).w	; X end to FFFA92
		move.w	#$1C0,(Camera_min_Y_pos).w
		move.w	d0,(Camera_min_X_pos).w		; Set X start
		addi.w	#$80,d0
		move.w	d0,(Camera_max_X_pos).w		; Set X end
		move.w	#$2B8,(Camera_max_Y_pos).w
		move.w	#$2B8,(Camera_target_max_Y_pos).w		; Set Y end
		move.l	#Obj_Wait,(a0)
		move.w	#2*60,$2E(a0)			; Wait for 2 seconds
		move.l	#Obj_CNZMinibossGo,$34(a0)
		moveq	#signextendB(mus_FadeOut),d0
		jsr	(Play_Music).l				; Fade out music
		move.b	#1,(Boss_flag).w		; Lock screen
		moveq	#$5D,d0
		jsr	(Load_PLC).l					; Load CNZ Miniboss PLC
		lea	Pal_CNZMiniboss(pc),a1		; Load CNZ Miniboss palette
		jmp	(PalLoad_Line1).l
; ---------------------------------------------------------------------------

Obj_CNZMinibossGo:
		move.l	#Obj_CNZMinibossStart,(a0)
		moveq	#signextendB(mus_Miniboss),d0
		jsr	(Play_Music).l			; Play miniboss music
		move.b	#mus_Miniboss,(Current_music+1).w
		jsr	(AllocateObject).l
		bne.s	locret_6DA22
		move.l	#Obj_CNZMinibossScrollControl,(a1)

locret_6DA22:
		rts
; ---------------------------------------------------------------------------

Obj_CNZMinibossStart:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	.Index(pc,d0.w),d1
		jsr	.Index(pc,d1.w)
		bsr.w	CNZMiniboss_MoveDown
		jsr	(Run_PalRotationScript).l
		bsr.w	CNZMiniboss_CheckPlayerHit
		bsr.w	CNZMiniboss_CheckTopHit
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------
.Index:
		dc.w Obj_CNZMinibossInit-.Index
		dc.w Obj_CNZMinibossLower-.Index
		dc.w Obj_CNZMinibossMove-.Index
		dc.w Obj_CNZMinibossMove-.Index
		dc.w Obj_CNZMinibossOpening-.Index
		dc.w Obj_CNZMinibossWaitHit-.Index
		dc.w Obj_CNZMinibossClosing-.Index
		dc.w Obj_CNZMinibossLower2-.Index
; ---------------------------------------------------------------------------

Obj_CNZMinibossInit:
		lea	ObjDat_CNZMiniboss(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.b	#6,collision_property(a0)	; 6 hits (for some reason)
		move.b	#4,$45(a0)
		bset	#3,$38(a0)
		move.w	#$80,y_vel(a0)	; Initial vertical speed
		move.w	#$11F,$2E(a0)	; Wait amount
		move.l	#Obj_CNZMinibossGo2,$34(a0)
		lea	Child1_CNZMinibossMakeTop(pc),a2		; Make the little top
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

Obj_CNZMinibossLower:
		jsr	(MoveSprite2).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

Obj_CNZMinibossGo2:
		move.b	#4,routine(a0)
		clr.w	y_vel(a0)
		bset	#1,$38(a0)
		move.w	#$90,$2E(a0)
		move.l	#Obj_CNZMinibossGo3,$34(a0)
		bra.w	SetUp_CNZMinibossSwing
; ---------------------------------------------------------------------------

Obj_CNZMinibossMove:
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

Obj_CNZMinibossGo3:
		move.w	#$100,x_vel(a0)
		move.w	#$9F,$2E(a0)

Obj_CNZMinibossCloseGo:
		move.b	#6,routine(a0)
		move.l	#Obj_CNZMinibossChangeDir,$34(a0)
		bclr	#3,$38(a0)
		lea	(PalSPtr_CNZMinibossNormal).l,a1
		lea	(Palette_rotation_data).w,a2
		move.l	(a1)+,(a2)+
		move.l	(a1)+,(a2)+
		clr.w	(a2)
		move.l	#CNZMiniboss_MakeTimedSparks,(Palette_rotation_custom).w
		rts
; ---------------------------------------------------------------------------

Obj_CNZMinibossChangeDir:
		neg.w	x_vel(a0)
		move.w	#$13F,$2E(a0)
		rts
; ---------------------------------------------------------------------------

Obj_CNZMinibossOpening:
		jmp	(Animate_RawMultiDelay).l
; ---------------------------------------------------------------------------

Obj_CNZMinibossOpenGo:
		move.b	#$A,routine(a0)
		move.l	#Obj_CNZMinibossChangeDir,$34(a0)
		bset	#6,$38(a0)		; Set Open state
		move.b	#$7F,$3B(a0)
		lea	Child1_CNZCoilOpenSparks(pc),a2		; Create spark objects for coil
		jmp	(CreateChild1_Normal).l
; ---------------------------------------------------------------------------

Obj_CNZMinibossWaitHit:
		btst	#6,status(a0)
		bne.s	loc_6DB4E
		rts
; ---------------------------------------------------------------------------

loc_6DB4E:
		move.b	#$C,routine(a0)
		bclr	#6,$38(a0)
		move.l	#AniRaw_CNZMinibossClosing,$30(a0)
		move.l	#Obj_CNZMinibossCloseGo,$34(a0)
		rts
; ---------------------------------------------------------------------------

Obj_CNZMinibossClosing:
		jmp	(Animate_RawMultiDelay).l
; ---------------------------------------------------------------------------

Obj_CNZMinibossLower2:
		addq.w	#1,y_pos(a0)
		subq.b	#1,$43(a0)
		bmi.s	loc_6DB7E
		rts
; ---------------------------------------------------------------------------

loc_6DB7E:
		move.b	$42(a0),routine(a0)
		rts
; ---------------------------------------------------------------------------

Obj_CNZMinibossEnd:
		move.l	#Obj_Wait,(a0)
		st	(_unkFAA8).w		; Set end of level flag
		bset	#4,$38(a0)
		move.l	#Obj_CNZMinibossEndGo,$34(a0)
		lea	Child6_CNZMinibossMakeDebris(pc),a2
		jmp	(CreateChild6_Simple).l
; ---------------------------------------------------------------------------
		jmp	(Obj_Wait).l
; ---------------------------------------------------------------------------

Obj_CNZMinibossEndGo:
		move.l	#Obj_EndSignControlAwaitStart,(a0)
		clr.b	(Boss_flag).w	; Unlock level
		jsr	(AfterBoss_Cleanup).l
		lea	(PLC_EndSignStuff).l,a1		; Get ready to start act 2 after sign finishes
		jmp	(Load_PLC_Raw).l
; ---------------------------------------------------------------------------

Obj_CNZMinibossTop:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	.Index(pc,d0.w),d1
		jsr	.Index(pc,d1.w)
		jmp	(Draw_And_Touch_Sprite).l
; ---------------------------------------------------------------------------
.Index:
		dc.w Obj_CNZMinibossTopInit-.Index
		dc.w Obj_CNZMinibossTopWait-.Index
		dc.w Obj_CNZMinibossTopWait2-.Index
		dc.w Obj_CNZMinibossTopMain-.Index
; ---------------------------------------------------------------------------

Obj_CNZMinibossTopInit:
		lea	ObjDat3_CNZMinibossTop(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		move.b	#$10,x_radius(a0)
		move.b	#8,y_radius(a0)
		rts
; ---------------------------------------------------------------------------

Obj_CNZMinibossTopWait:
		movea.w	parent3(a0),a1
		btst	#1,$38(a1)
		bne.s	loc_6DC10		; Wait for signal from main boss
		jmp	(Refresh_ChildPosition).l
; ---------------------------------------------------------------------------

loc_6DC10:
		move.b	#4,routine(a0)
		move.l	#AniRaw_CNZMinibossTop,$30(a0)
		move.l	#Obj_CNZMinibossTopGo,$34(a0)
		rts
; ---------------------------------------------------------------------------

Obj_CNZMinibossTopWait2:
		jsr	(Refresh_ChildPosition).l
		jmp	(Animate_RawGetFaster).l
; ---------------------------------------------------------------------------

Obj_CNZMinibossTopGo:
		move.b	#6,routine(a0)
		move.l	#AniRaw_CNZMinibossTop2,$30(a0)
		move.w	#$200,x_vel(a0)
		move.w	#$200,y_vel(a0)		; Set initial speed of top
		rts
; ---------------------------------------------------------------------------

Obj_CNZMinibossTopMain:
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.w	loc_6DDD2			; If parent has been destroyed, destroy this object
		move.w	x_pos(a0),-(sp)
		jsr	(MoveSprite2).l
		moveq	#$13,d1
		moveq	#$C,d2
		moveq	#8,d3
		move.w	(sp)+,d4
		jsr	(SolidObjectFull).l
		jsr	(Animate_Raw).l
		tst.w	x_vel(a0)
		bmi.s	loc_6DCB0
		moveq	#$10,d3		; If moving to the right
		jsr	(ObjCheckRightWallDist).l
		tst.w	d1
		bmi.w	loc_6DD4C	; Reverse direction if block is hit from side
		move.w	x_pos(a0),d0
		addi.w	#$10,d0
		cmpi.w	#$3380,d0
		bhs.w	loc_6DD8E	; Reverse direction if edge of screen is hit
		move.w	y_pos(a0),d1
		bsr.w	CNZMinibossTop_CheckHitBase
		bne.w	loc_6DD8E	; Reverse direction if miniboss base was hit
		bra.w	loc_6DCDA
; ---------------------------------------------------------------------------

loc_6DCB0:
		moveq	#-$10,d3	; If moving to the left
		jsr	(ObjCheckLeftWallDist).l
		tst.w	d1
		bmi.w	loc_6DD4C	; Reverse direction if wall was hit
		move.w	x_pos(a0),d0
		subi.w	#$10,d0
		cmpi.w	#$3200,d0
		blo.w	loc_6DD8E	; Reverse direction if edge of screen is hit
		move.w	y_pos(a0),d1
		bsr.w	CNZMinibossTop_CheckHitBase
		bne.w	loc_6DD8E	; Reverse direction if miniboss base was hit

loc_6DCDA:
		bsr.w	CNZMinibossTop_CheckPlayerBounce
		bne.w	loc_6DDCC	; If bounce was detected, reverse direction
		tst.w	y_vel(a0)
		bmi.s	loc_6DD1E
		jsr	(ObjCheckFloorDist).l		; If moving downward, check for hitting the blocks
		tst.w	d1
		bmi.w	loc_6DD94	; If hit, reverse direction
		move.w	x_pos(a0),d0
		move.w	y_pos(a0),d1
		addq.w	#8,d1
		move.w	(Camera_Y_pos).w,d2
		addi.w	#$E0,d2
		cmp.w	d2,d1
		bhs.w	loc_6DDCC	; If bottom of screen was hit, bounce
		cmpi.w	#$380,d1
		bhi.w	loc_6DDCC	; Maximum lower bound is $380
		bsr.w	CNZMinibossTop_CheckHitBase
		bne.w	loc_6DDCC	; If base was hit, bounce
		rts
; ---------------------------------------------------------------------------

loc_6DD1E:
		jsr	(ObjCheckCeilingDist).l	; If moving upward, check for hitting the blocks from below
		tst.w	d1
		bmi.s	loc_6DD94	; If hit, reverse direction
		move.w	x_pos(a0),d0
		move.w	y_pos(a0),d1
		subq.w	#8,d1
		cmp.w	(Camera_Y_pos).w,d1
		bls.w	loc_6DDCC	; If top of screen was hit, bounce
		cmpi.w	#$240,d1
		bls.w	loc_6DDCC	; Maximum upper bound is $240
		bsr.w	CNZMinibossTop_CheckHitBase
		bne.w	loc_6DDCC	; If base was hit, bounce
		rts
; ---------------------------------------------------------------------------

loc_6DD4C:
		lea	Child1_CNZBounceEffect(pc),a2
		jsr	(CreateChild1_Normal).l
		bne.s	loc_6DD64
		tst.w	x_vel(a0)
		bmi.s	loc_6DD64
		bset	#0,render_flags(a1)

loc_6DD64:
		moveq	#$10,d0
		neg.w	x_vel(a0)	; Change direction
		bmi.s	loc_6DD6E
		neg.w	d0

loc_6DD6E:
		add.w	x_pos(a0),d0
		cmpi.w	#$3200,d0
		bls.s	locret_6DD8C
		cmpi.w	#$3380,d0
		bhs.s	locret_6DD8C	; If the walls were hit somehow, don't do anything
		move.w	d0,(Events_bg+$00).w
		move.w	y_pos(a0),(Events_bg+$02).w	; Move X/Y positions into special variables for removing the blocks from the level layout
		bsr.w	CNZMiniboss_BlockExplosion

locret_6DD8C:
		rts
; ---------------------------------------------------------------------------

loc_6DD8E:
		neg.w	x_vel(a0)		; Simple direction switch
		rts
; ---------------------------------------------------------------------------

loc_6DD94:
		move.w	x_pos(a0),d0
		moveq	#8,d1
		neg.w	y_vel(a0)
		bmi.s	loc_6DDA2
		neg.w	d1

loc_6DDA2:
		add.w	y_pos(a0),d1
		cmpi.w	#$3200,d0
		bls.s	locret_6DD8C
		cmpi.w	#$3380,d0
		bhs.s	locret_6DD8C
		cmpi.w	#$300,d1
		blo.s	locret_6DD8C
		cmpi.w	#$3380,d1
		bhs.s	locret_6DD8C
		move.w	d0,(Events_bg+$00).w		; Move X/Y positions into special variables see above
		move.w	d1,(Events_bg+$02).w
		bsr.w	CNZMiniboss_BlockExplosion
		rts
; ---------------------------------------------------------------------------

loc_6DDCC:
		neg.w	y_vel(a0)		; Simple direction switch
		rts
; ---------------------------------------------------------------------------

loc_6DDD2:
		lea	Child1_CNZMinibossExplosion(pc),a2
		jsr	(CreateChild1_Normal).l
		move.b	#6,subtype(a1)
		clr.b	collision_flags(a0)
		jsr	(Displace_PlayerOffObject).l
		jmp	(Go_Delete_Sprite).l

; =============== S U B R O U T I N E =======================================


CNZMiniboss_BlockExplosion:
		lea	Child1_CNZMinibossExplosion(pc),a2
		jsr	(CreateChild1_Normal).l
		bne.s	locret_6DE24
		move.b	#6,subtype(a1)
		move.w	(Events_bg+$00).w,d0
		andi.w	#$FFE0,d0
		addi.w	#$10,d0
		move.w	d0,x_pos(a1)
		move.w	(Events_bg+$02).w,d0
		andi.w	#$FFE0,d0
		addi.w	#$10,d0
		move.w	d0,y_pos(a1)

locret_6DE24:
		rts
; End of function CNZMiniboss_BlockExplosion

; ---------------------------------------------------------------------------

Obj_CNZMinibossCoil:
		move.l	#Obj_CNZMinibossCoilClose,(a0)
		move.b	#$1A,collision_flags(a0)
		move.b	#$70,collision_property(a0)
		bclr	#2,$38(a0)
		rts
; ---------------------------------------------------------------------------

Obj_CNZMinibossCoilClose:
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.s	loc_6DEB6
		btst	#6,$38(a1)
		bne.s	loc_6DEA8
		jsr	(Refresh_ChildPosition).l		; If base is not open
		movea.w	parent3(a0),a1
		tst.b	collision_flags(a0)
		bne.s	loc_6DE9C		; Skip if collision is set
		bset	#2,$38(a0)
		bne.s	loc_6DE88		; If $38 already set, branch
		move.b	#$10,$3A(a0)
		btst	#2,$38(a1)
		bne.s	loc_6DE88		; If base has been stunned already, branch
		move.b	collision_flags(a1),$25(a1)	; Backup parent collision
		clr.b	collision_flags(a1)		; Unset parent collision
		subq.b	#1,collision_property(a1)	; Remove a hit

loc_6DE88:
		subq.b	#1,$3A(a0)
		bpl.w	locret_6DA22
		bclr	#2,$38(a0)
		move.b	$25(a0),collision_flags(a0)	; Restore collision

loc_6DE9C:
		move.b	#$70,collision_property(a0)
		jmp	(Add_SpriteToCollisionResponseList).l
; ---------------------------------------------------------------------------

loc_6DEA8:
		move.l	#Obj_CNZMinibossCoilOpen,(a0)
		move.b	#$A9,collision_flags(a0)
		rts
; ---------------------------------------------------------------------------

loc_6DEB6:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------

Obj_CNZMinibossCoilOpen:
		jsr	(Refresh_ChildPosition).l
		movea.w	parent3(a0),a1
		btst	#7,status(a1)
		bne.s	loc_6DEB6
		btst	#6,$38(a1)
		beq.w	Obj_CNZMinibossCoil		; If parent closes up
		jmp	(Add_SpriteToCollisionResponseList).l
; ---------------------------------------------------------------------------

loc_6DEDE:
		move.l	#loc_6DEEC,(a0)
		move.b	#$AA,collision_flags(a0)
		rts
; ---------------------------------------------------------------------------

loc_6DEEC:
		jsr	(Refresh_ChildPosition).l
		jmp	(Add_SpriteToCollisionResponseList).l
; ---------------------------------------------------------------------------

Obj_CNZMinibossTimedSparks:
		lea	ObjDat3_CNZMinibossSpark(pc),a1		;Temporary sparks when boss is closed
		jsr	(SetUp_ObjAttributes3).l
		bset	#5,shield_reaction(a0)
		move.l	#Obj_Wait,(a0)
		move.l	#Obj_CNZMinibossTimedSparksGo,$34(a0)
		move.l	#AniRaw_CNZMinibossTimedSparkLeft,$30(a0)
		tst.b	subtype(a0)
		beq.s	locret_6DF32
		move.l	#AniRaw_CNZMinibossTimedSparkRight,$30(a0)
		move.w	#2,$2E(a0)

locret_6DF32:
		rts
; ---------------------------------------------------------------------------

Obj_CNZMinibossTimedSparksGo:
		move.l	#Obj_CNZMinibossTimedSparksMain,(a0)
		move.w	#$7F,$2E(a0)
		move.l	#Go_Delete_Sprite,$34(a0)
		rts
; ---------------------------------------------------------------------------

Obj_CNZMinibossTimedSparksMain:
		jsr	(Refresh_ChildPosition).l
		jsr	(Animate_RawMultiDelay).l
		jsr	(Obj_Wait).l
		jmp	(Child_DrawTouch_Sprite).l
; ---------------------------------------------------------------------------

Obj_CNZMinibossSparks:
		lea	ObjDat3_CNZMinibossSpark(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		bset	#5,shield_reaction(a0)		; Player isn't hurt with Lightning Shield
		move.l	#Obj_CNZMinibossSparksMain,(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		add.w	d0,d0
		move.l	off_6DF88(pc,d0.w),$30(a0)
		rts
; ---------------------------------------------------------------------------
off_6DF88:
		dc.l AniRaw_CNZMinibossSparks1
		dc.l AniRaw_CNZMinibossSparks2
		dc.l AniRaw_CNZMinibossSparks3
; ---------------------------------------------------------------------------

Obj_CNZMinibossSparksMain:
		movea.w	parent3(a0),a1
		btst	#6,$38(a1)
		beq.w	loc_6DEB6
		jsr	(Refresh_ChildPosition).l
		jsr	(Animate_RawMultiDelay).l
		jmp	(Child_DrawTouch_Sprite).l
; ---------------------------------------------------------------------------

Obj_CNZMinibossBounceEffect:
		lea	ObjDat3_CNZMbossBounceEffect(pc),a1
		jsr	(SetUp_ObjAttributes3).l
		bset	#5,shield_reaction(a0)
		move.l	#AnimateRaw_DrawTouch,(a0)
		move.w	#$3208,x_pos(a0)
		btst	#0,render_flags(a0)
		beq.s	loc_6DFDE
		move.w	#$3378,x_pos(a0)

loc_6DFDE:
		move.l	#AniRaw_CNZMBossBoundEffect,$30(a0)
		move.l	#Go_Delete_Sprite,$34(a0)
		rts
; ---------------------------------------------------------------------------

Obj_CNZMinibossDebris:
		lea	ObjDat_CNZMinibossDebris(pc),a1
		jsr	(SetUp_ObjAttributes).l
		move.l	#Obj_FlickerMove,(a0)
		moveq	#0,d0
		move.b	subtype(a0),d0
		move.w	byte_6E022(pc,d0.w),child_dx(a0)	; and child_dy
		lsr.w	#1,d0
		move.b	CNZMinibossDebris_Frames(pc,d0.w),mapping_frame(a0)
		jsr	(Refresh_ChildPosition).l
		moveq	#0,d0
		jmp	(Set_IndexedVelocity).l
; ---------------------------------------------------------------------------
byte_6E022:
		dc.b -$10,   0
		dc.b  $10,   0
		dc.b    0, $14
		dc.b    0, $1C
		dc.b    0, $24
		dc.b    0, $2C
		dc.b    0, $34
		dc.b    0, $3C
		dc.b    0, $48
CNZMinibossDebris_Frames:
		dc.b  $12, $13, $14, $14, $14, $14, $14, $14, $15
		even
; ---------------------------------------------------------------------------

SetUp_CNZMinibossSwing:
		move.w	#$60,d0
		move.w	d0,$3E(a0)
		move.w	d0,y_vel(a0)
		move.w	#8,$40(a0)
		bclr	#0,$38(a0)
		rts

; =============== S U B R O U T I N E =======================================


CNZMiniboss_CheckPlayerHit:
		tst.b	collision_flags(a0)
		bne.s	locret_6E0AE
		bset	#2,$38(a0)		; If boss was hit by Sonic, set flag
		bne.s	loc_6E09C		; If already set earlier, skip ahead
		addq.b	#1,collision_property(a0)	; Don't allow hit to affect him
		move.b	#$10,$3A(a0)
		bset	#3,$38(a0)
		bne.s	loc_6E09C
		move.b	#8,routine(a0)
		move.l	#AniRaw_CNZMinibossOpening,$30(a0)
		move.l	#Obj_CNZMinibossOpenGo,$34(a0)		; Set boss to opening animation/routine
		lea	(PalSPtr_CNZMinibossOpen).l,a1
		lea	(Palette_rotation_data).w,a2		; Reset pal script
		move.l	(a1)+,(a2)+
		move.l	(a1)+,(a2)+

loc_6E09C:
		subq.b	#1,$3A(a0)
		bpl.s	locret_6E0AE
		bclr	#2,$38(a0)
		move.b	$25(a0),collision_flags(a0)	; Restore collision after 16 frames at most while opening

locret_6E0AE:
		rts
; End of function CNZMiniboss_CheckPlayerHit


; =============== S U B R O U T I N E =======================================


CNZMiniboss_CheckTopHit:
		tst.b	$44(a0)
		beq.s	locret_6E0F8		; If not hit by top, don't bother
		tst.b	$20(a0)
		bne.s	loc_6E0D6
		subq.b	#1,$45(a0)			; Subtract 1 from ACTUAL hit count
		beq.s	CNZMiniboss_BossDefeated
		bset	#6,status(a0)			; Set to indicate in hit stun
		move.b	#$20,$20(a0)
		moveq	#signextendB(sfx_BossHit),d0
		jsr	(Play_SFX).l		; Play hit sound

loc_6E0D6:
		moveq	#0,d0
		btst	#0,$20(a0)
		bne.s	loc_6E0E4
		addi.w	#2*5,d0

loc_6E0E4:
		bsr.w	CNZMiniboss_BossFlash	; Do the boss flash
		subq.b	#1,$20(a0)
		bne.s	locret_6E0F8
		bclr	#6,status(a0)
		clr.b	$44(a0)

locret_6E0F8:
		rts
; ---------------------------------------------------------------------------

CNZMiniboss_BossDefeated:
		move.l	#Wait_FadeToLevelMusic,(a0)
		bset	#7,status(a0)				; Boss has been annihilated!
		move.l	#Obj_CNZMinibossEnd,$34(a0)
		move.w	#$20,(Normal_palette_line_2+$14).w		; Set palette properly
		st	(Events_fg_5).w				; Signal BG event
		lea	Child1_CNZMinibossExplosion(pc),a2
		jsr	(CreateChild1_Normal).l
		jmp	(BossDefeated_StopTimer).l
; End of function CNZMiniboss_CheckTopHit


; =============== S U B R O U T I N E =======================================


CNZMiniboss_BossFlash:
		lea	word_6E146(pc),a1
		lea	word_6E150(pc,d0.w),a2
	rept 5
		movea.w	(a1)+,a3
		move.w	(a2)+,(a3)+
	endm
		rts
; End of function CNZMiniboss_BossFlash

; ---------------------------------------------------------------------------
word_6E146:
		dc.w Normal_palette_line_2+$04, Normal_palette_line_2+$06, Normal_palette_line_2+$08
		dc.w Normal_palette_line_2+$0E, Normal_palette_line_2+$1C
word_6E150:
		dc.w   $6E0,  $280,   $40,   $28,  $642
		dc.w   $888,  $AAA,  $CCC,  $888,  $AAA
; ---------------------------------------------------------------------------

CNZMiniboss_MakeTimedSparks:
		lea	(PalSPtr_CNZMinibossSparks).l,a2
		move.l	(a2)+,(a1)+
		move.l	(a2)+,(a1)+
		lea	Child1_CNZMinibossTimedSparks(pc),a2
		jmp	(CreateChild1_Normal).l

; =============== S U B R O U T I N E =======================================


CNZMiniboss_MoveDown:
		move.w	(Events_bg+$04).w,d0
		cmp.w	$3C(a0),d0
		beq.s	locret_6E198
		move.w	d0,$3C(a0)
		move.b	routine(a0),$42(a0)
		move.b	#$E,routine(a0)
		move.b	#$1F,$43(a0)

locret_6E198:
		rts
; End of function CNZMiniboss_MoveDown


; =============== S U B R O U T I N E =======================================


CNZMinibossTop_CheckPlayerBounce:
		lea	(Player_1).w,a1
		bsr.w	sub_6E1A8
		bne.s	locret_6E20E
		lea	(Player_2).w,a1
; End of function CNZMinibossTop_CheckPlayerBounce


; =============== S U B R O U T I N E =======================================


sub_6E1A8:
		tst.w	y_vel(a1)
		bpl.s	loc_6E210		; If player is moving downward, don't bother
		cmpi.b	#2,anim(a1)
		bne.s	loc_6E210		; If player is not in rolling animation, don't bother
		move.w	x_pos(a0),d0
		move.w	y_pos(a0),d1
		addi.w	#$C,d1
		move.w	x_pos(a1),d2
		subi.w	#$10,d2
		cmp.w	d2,d0
		blo.s	loc_6E210		; If player is not within X range, don't bother
		addi.w	#$20,d2
		cmp.w	d2,d0
		bhs.s	loc_6E210		; See above
		move.w	y_pos(a1),d2
		subi.w	#$10,d2
		cmp.w	d2,d1
		blo.s	loc_6E210		; If player is not within Y range, don't bother
		addi.w	#$20,d2
		cmp.w	d2,d1
		bhs.s	loc_6E210		; See above
		tst.w	x_vel(a1)
		bmi.s	loc_6E1FA
		tst.w	x_vel(a0)
		bpl.s	loc_6E204		; If player and top are moving the same direction, don't need to reverse X direction
		bra.w	loc_6E200
; ---------------------------------------------------------------------------

loc_6E1FA:
		tst.w	x_vel(a0)
		bmi.s	loc_6E204		; If player and top are moving the same direction, don't need to reverse X direction

loc_6E200:
		neg.w	x_vel(a0)			; If moving in opposite directions, reverse

loc_6E204:
		tst.w	y_vel(a0)
		bmi.w	loc_6E210
		moveq	#1,d0			; If top is moving downward on collision, set collision flag

locret_6E20E:
		rts
; ---------------------------------------------------------------------------

loc_6E210:
		moveq	#0,d0
		rts
; End of function sub_6E1A8


; =============== S U B R O U T I N E =======================================


CNZMinibossTop_CheckHitBase:
		movea.w	parent3(a0),a1
		lea	CNZMiniboss_BaseRange(pc),a2		; Two hit boxes. First is the slightly wider base
		move.w	x_pos(a1),d2
		add.w	(a2)+,d2
		cmp.w	d2,d0
		blo.s	loc_6E23C
		add.w	(a2)+,d2
		cmp.w	d2,d0
		bhs.s	loc_6E23C
		move.w	y_pos(a1),d2
		add.w	(a2)+,d2
		cmp.w	d2,d1
		blo.s	loc_6E23C
		add.w	(a2)+,d2
		cmp.w	d2,d1
		blo.s	loc_6E270

loc_6E23C:
		lea	CNZMiniboss_CoilRange(pc),a2		; Then it's the coil, different ranges depending on open or close state
		btst	#6,$38(a1)
		beq.s	loc_6E24C
		lea	CNZMiniboss_CoilOpenRange(pc),a2

loc_6E24C:
		move.w	x_pos(a1),d2
		add.w	(a2)+,d2
		cmp.w	d2,d0
		blo.s	loc_6E26C
		add.w	(a2)+,d2
		cmp.w	d2,d0
		bhs.s	loc_6E26C
		move.w	y_pos(a1),d2
		add.w	(a2)+,d2
		cmp.w	d2,d1
		blo.s	loc_6E26C
		add.w	(a2)+,d2
		cmp.w	d2,d1
		blo.s	loc_6E270

loc_6E26C:
		moveq	#0,d2
		rts
; ---------------------------------------------------------------------------

loc_6E270:
		btst	#6,$38(a1)
		beq.s	loc_6E27C
		st	$44(a1)				; Only set hit state if coil was open to begin with

loc_6E27C:
		moveq	#1,d2
		rts
; End of function CNZMinibossTop_CheckHitBase

; ---------------------------------------------------------------------------
CNZMiniboss_BaseRange:
		dc.w   -$18,   $30,  -$10,   $20
CNZMiniboss_CoilRange:
		dc.w    -$C,   $18,   $10,   $18
CNZMiniboss_CoilOpenRange:
		dc.w    -$C,   $18,   $10,   $38
ObjDat_CNZMiniboss:
		dc.l Map_CNZMiniboss
		dc.w make_art_tile($52E,1,1)
		dc.w   $280
		dc.b  $18, $30,   0,  $C
ObjDat3_CNZMinibossTop:
		dc.w   $200
		dc.b  $18, $10,   7, $AA
ObjDat3_CNZMinibossSpark:
		dc.w   $200
		dc.b   $C, $18,  $A, $92
ObjDat3_CNZMbossBounceEffect:
		dc.w   $100
		dc.b    8,   8,  $C,   0
ObjDat_CNZMinibossDebris:
		dc.l Map_CNZMiniboss
		dc.w make_art_tile($52E,1,1)
		dc.w   $100
		dc.b  $10, $10,   0,   0
Child1_CNZMinibossMakeTop:
		dc.w 2-1
		dc.l Obj_CNZMinibossTop
		dc.b    0, $2C
		dc.l Obj_CNZMinibossCoil
		dc.b    0, $1C
Child1_CNZMinibossTimedSparks:
		dc.w 2-1
		dc.l Obj_CNZMinibossTimedSparks
		dc.b -$14, $18
		dc.l Obj_CNZMinibossTimedSparks
		dc.b  $14, $18
		dc.w 1-1
		dc.l loc_6DEDE
		dc.b    0,  -4
Child1_CNZCoilOpenSparks:
		dc.w 3-1
		dc.l Obj_CNZMinibossSparks
		dc.b   -4, $28
		dc.l Obj_CNZMinibossSparks
		dc.b    4, $2C
		dc.l Obj_CNZMinibossSparks
		dc.b   -4, $3C
Child1_CNZBounceEffect:
		dc.w 1-1
		dc.l Obj_CNZMinibossBounceEffect
		dc.b    0,  -4
Child1_CNZMinibossExplosion:
		dc.w 1-1
		dc.l Obj_CreateBossExplosion
		dc.b    0,   0
Child6_CNZMinibossMakeDebris:
		dc.w 9-1
		dc.l Obj_CNZMinibossDebris
AniRaw_CNZMinibossOpening:
		dc.b    0,   3,   1,   3,   2,   3,   3,   3,   4,   3,   5,   3,   6,   3, $F4
AniRaw_CNZMinibossClosing:
		dc.b    6,   3,   5,   3,   4,   3,   3,   3,   2,   3,   1,   3,   0,   3, $F4
AniRaw_CNZMinibossTop:
		dc.b    7,   8,   7,   8,   9, $FC
AniRaw_CNZMinibossTop2:
		dc.b    0,   7,   8,   9, $FC
AniRaw_CNZMinibossTimedSparkLeft:
		dc.b   $A,   0, $11,   2,  $B,   0, $11,   2, $FC
AniRaw_CNZMinibossTimedSparkRight:
		dc.b   $F,   0, $11,   2, $10,   0, $11,   2, $FC
AniRaw_CNZMinibossSparks1:
		dc.b   $A,   0, $11,   7,  $B,   0, $11,   7, $FC
AniRaw_CNZMinibossSparks2:
		dc.b  $11,   0,  $F,   0, $11,   7, $10,   0, $11,   9, $FC
AniRaw_CNZMinibossSparks3:
		dc.b   $A,   0, $11,   7,  $B,   0, $11,  $B, $FC
AniRaw_CNZMBossBoundEffect:
		dc.b   $C,   0,  $D,   1,  $E,   1, $F4
		even
Pal_CNZMiniboss:
		binclude "Levels/CNZ/Palettes/Miniboss.bin"
		even
PalSPtr_CNZMinibossNormal:
		palscriptptr .header, .data
		dc.w 0
.header	palscripthdr	Normal_palette_line_2+$14, 1, 3-1
.data	palscriptdata	1, $EEE
	palscriptdata	1, $A22
	palscriptdata	6, $020
	palscriptloop	.headr2
.headr2	palscripthdr	Normal_palette_line_2+$14, 1, 3-1
	palscriptdata	1, $EEE
	palscriptdata	1, $A22
	palscriptdata	4, $020
	palscriptloop	.headr3
.headr3	palscripthdr	Normal_palette_line_2+$14, 1, 3-1
	palscriptdata	1, $EEE
	palscriptdata	1, $A22
	palscriptdata	2, $020
	palscriptloop	.headr4
.headr4	palscripthdr	Normal_palette_line_2+$14, 1, $B-1
	palscriptdata	1, $EEE
	palscriptdata	1, $A22
	palscriptdata	1, $020
	palscriptrun

PalSPtr_CNZMinibossSparks:
		palscriptptr .header, .data
		dc.w 0
.header	palscripthdr	Normal_palette_line_2+$14, 1, $31-1
.data	palscriptdata	1, $EEE
	palscriptdata	1, $A22
	palscriptdata	1, $020
	palscriptloop	.headr2
.headr2	palscripthdr	Normal_palette_line_2+$14, 1, 3-1
	palscriptdata	1, $EEE
	palscriptdata	1, $A22
	palscriptdata	2, $020
	palscriptloop	.headr3
.headr3	palscripthdr	Normal_palette_line_2+$14, 1, 4-1
	palscriptdata	1, $EEE
	palscriptdata	1, $A22
	palscriptdata	4, $020
	palscriptloop	.headr4
.headr4	palscripthdr	Normal_palette_line_2+$14, 1, 2-1
	palscriptdata	96, $020
	palscriptloop	PalSPtr_CNZMinibossNormal.headr3

PalSPtr_CNZMinibossOpen:
		palscriptptr .header, .data
		dc.w 0
.header	palscripthdr	Normal_palette_line_2+$14, 1, 0
.data	palscriptdata	1, $EEE
	palscriptdata	1, $A22
	palscriptdata	2, $020
	palscriptdata	1, $EEE
	palscriptdata	1, $A22
	palscriptdata	8, $020
	palscriptdata	1, $EEE
	palscriptdata	1, $A22
	palscriptdata	3, $020
	palscriptrept
; ---------------------------------------------------------------------------
word_6E46E:
		dc.w      0,  $300, $4660, $4860
word_6E476:
		dc.w   $240,  $240, $4760, $47E0
; ---------------------------------------------------------------------------

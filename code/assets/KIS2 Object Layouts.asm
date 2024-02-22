	if Sonic3_Complete=0
; Some sprite pointers below point to S2 or S2K data, which we're not dealing with in this disassembly for the time being
; As such, they are intentionally left unlabelled
S2K_Sprite_Lists:
		dc.l S2KSprite_EHZ1		; 0
		dc.l S2KSprite_EHZ2		; 1
		dc.l S2KSprite_NULL		; 2
		dc.l S2KSprite_NULL		; 3
		dc.l S2KSprite_NULL		; 4
		dc.l S2KSprite_NULL		; 5
		dc.l S2KSprite_NULL		; 6
		dc.l S2KSprite_NULL		; 7
		dc.l S2KSprite_MTZ1		; 8
		dc.l S2KSprite_MTZ2		; 9
		dc.l S2KSprite_MTZ3		; 10
		dc.l S2KSprite_MTZ3		; 11
		dc.l S2KSprite_WFZ1		; 12
		dc.l S2KSprite_WFZ2		; 13
		dc.l S2KSprite_HTZ1		; 14
		dc.l S2KSprite_HTZ2		; 15
		dc.l LockOnROM_Start+$E8C80	;Objects_HPZ_1, in Sonic 2 ROM	; 16
		dc.l LockOnROM_Start+$E8D94	;Objects_HPZ_2, in Sonic 2 ROM	; 17
		dc.l S2KSprite_NULL		; 18
		dc.l S2KSprite_NULL		; 19
		dc.l S2KSprite_OOZ1		; 20
		dc.l S2KSprite_OOZ2		; 21
		dc.l S2KSprite_MCZ1		; 22
		dc.l S2KSprite_MCZ2		; 23
		dc.l LockOnROM_Start+$13F06E	;Objects_CNZ_1 in KiS2 UPMEM ROM	; 24
		dc.l LockOnROM_Start+$13F74C	;Objects_CNZ_2 in KiS2 UPMEM ROM	; 25
		dc.l S2KSprite_CPZ1		; 26
		dc.l S2KSprite_CPZ2		; 27
		dc.l LockOnROM_Start+$EB230	;Objects_DEZ_1, in Sonic 2 ROM	; 28
		dc.l LockOnROM_Start+$EB254	;Objects_DEZ_2, in Sonic 2 ROM	; 29
		dc.l S2KSprite_ARZ1		; 30
		dc.l S2KSprite_ARZ2		; 31
		dc.l LockOnROM_Start+$EBBDE	;Objects_SCZ_1, in Sonic 2 ROM	; 32
		dc.l LockOnROM_Start+$EBD4C	;Objects_SCZ_1, in Sonic 2 ROM	; 33

		dc.w $FFFF, 0, 0
S2KSprite_EHZ1:
		binclude "Levels/Misc/S2K Object Pos/EHZ_1.bin"
		even
S2KSprite_EHZ2:
		binclude "Levels/Misc/S2K Object Pos/EHZ_2.bin"
		even
S2KSprite_MTZ1:
		binclude "Levels/Misc/S2K Object Pos/MTZ_1.bin"
		even
S2KSprite_MTZ2:
		binclude "Levels/Misc/S2K Object Pos/MTZ_2.bin"
		even
S2KSprite_MTZ3:
		binclude "Levels/Misc/S2K Object Pos/MTZ_3.bin"
		even
S2KSprite_WFZ1:
		binclude "Levels/Misc/S2K Object Pos/WFZ_1.bin"
		even
S2KSprite_WFZ2:
		binclude "Levels/Misc/S2K Object Pos/WFZ_2.bin"
		even
S2KSprite_HTZ1:
		binclude "Levels/Misc/S2K Object Pos/HTZ_1.bin"
		even
S2KSprite_HTZ2:
		binclude "Levels/Misc/S2K Object Pos/HTZ_2.bin"
		even
S2KSprite_OOZ1:
		binclude "Levels/Misc/S2K Object Pos/OOZ_1.bin"
		even
S2KSprite_OOZ2:
		binclude "Levels/Misc/S2K Object Pos/OOZ_2.bin"
		even
S2KSprite_MCZ1:
		binclude "Levels/Misc/S2K Object Pos/MCZ_1.bin"
		even
S2KSprite_MCZ2:
		binclude "Levels/Misc/S2K Object Pos/MCZ_2.bin"
		even
S2KSprite_CPZ1:
		binclude "Levels/Misc/S2K Object Pos/CPZ_1.bin"
		even
S2KSprite_CPZ2:
		binclude "Levels/Misc/S2K Object Pos/CPZ_2.bin"
		even
S2KSprite_ARZ1:
		binclude "Levels/Misc/S2K Object Pos/ARZ_1.bin"
		even
S2KSprite_ARZ2:
		binclude "Levels/Misc/S2K Object Pos/ARZ_2.bin"
		even
S2KSprite_NULL:
		dc.w $FFFF, 0, 0
	endif

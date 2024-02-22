; ===========================================================================
; Music Banks
; ===========================================================================
	cnop -Size_of_Snd_Bank1, $8000	; aligned to end of bank

; ---------------------------------------------------------------------------
; Music Bank 1
; ---------------------------------------------------------------------------
Snd_Bank1_Start:
Snd_SKCredits:		include	"Sound/Music/Credits (Sonic & Knuckles).asm"
Snd_GameOver:		include	"Sound/Music/Game Over.asm"
Snd_Continue:		include	"Sound/Music/Continue (Sonic & Knuckles).asm"
Snd_Results:		include	"Sound/Music/Level Outro.asm"
Snd_Invic:		include	"Sound/Music/Invincible (Sonic & Knuckles).asm"
Snd_Menu:		include	"Sound/Music/Menu (Sonic & Knuckles).asm"
Snd_FinalBoss:		include	"Sound/Music/Final Boss.asm"
Snd_PresSega:		include	"Sound/Music/Game Complete (Sonic & Knuckles).asm"

Snd_Bank1_End

	if Snd_Bank1_End - Snd_Bank1_Start > $8000
		fatal "Snd_Bank1_Start must fit within $8000 bytes, but was $\{Snd_Bank1_End-Snd_Bank1_Start }. Try moving something to the other bank."
	endif
	if Snd_Bank1_End - Snd_Bank1_Start > Size_of_Snd_Bank1
		fatal "Size_of_Snd_Bank1 = $\{Size_of_Snd_Bank1}, but you have $\{Snd_Bank1_End-Snd_Bank1_Start} bytes of music."
	endif

; ---------------------------------------------------------------------------
; Music Bank 2
; ---------------------------------------------------------------------------
Snd_Bank2_Start:	startBank
Snd_FBZ1:		include	"Sound/Music/FBZ1 (Sonic & Knuckles).asm"
Snd_FBZ2:		include	"Sound/Music/FBZ2.asm"
Snd_MHZ1:		include	"Sound/Music/MHZ1.asm"
Snd_MHZ2:		include	"Sound/Music/MHZ2.asm"
Snd_SOZ1:		include	"Sound/Music/SOZ1.asm"
Snd_SOZ2:		include	"Sound/Music/SOZ2.asm"
Snd_LRZ1:		include	"Sound/Music/LRZ1.asm"
Snd_LRZ2:		include	"Sound/Music/LRZ2.asm"
Snd_SSZ:		include	"Sound/Music/SSZ (Sonic & Knuckles).asm"
Snd_DEZ1:		include	"Sound/Music/DEZ1.asm"
Snd_DEZ2:		include	"Sound/Music/DEZ2.asm"
Snd_Minib_SK:		include	"Sound/Music/Miniboss (Sonic & Knuckles).asm"
Snd_Boss:		include	"Sound/Music/Zone Boss.asm"
Snd_DDZ:		include	"Sound/Music/DDZ.asm"
Snd_PachBonus:		include	"Sound/Music/Pachinko.asm"
Snd_SpecialS:		include	"Sound/Music/Special Stage.asm"
Snd_SlotBonus:		include	"Sound/Music/Slots.asm"
Snd_Knux:		include	"Sound/Music/Knuckles (Sonic & Knuckles).asm"
Snd_Title:		include	"Sound/Music/Title (Sonic & Knuckles).asm"
Snd_1UP:		include	"Sound/Music/1UP (Sonic & Knuckles).asm"
Snd_Emerald:		include	"Sound/Music/Chaos Emerald.asm"

	finishBank

; ---------------------------------------------------------------------------
; ===========================================================================
; DAC Banks
; ===========================================================================
; DAC Bank 1
; ---------------------------------------------------------------------------
DacBank1:			startBank

DAC_Offsets:
		offsetBankTableEntry.w	DAC_81_Setup
		offsetBankTableEntry.w	DAC_82_Setup
		offsetBankTableEntry.w	DAC_83_Setup
		offsetBankTableEntry.w	DAC_84_Setup
		offsetBankTableEntry.w	DAC_85_Setup
		offsetBankTableEntry.w	DAC_86_Setup
		offsetBankTableEntry.w	DAC_87_Setup
		offsetBankTableEntry.w	DAC_88_Setup
		offsetBankTableEntry.w	DAC_89_Setup
		offsetBankTableEntry.w	DAC_8A_Setup
		offsetBankTableEntry.w	DAC_8B_Setup
		offsetBankTableEntry.w	DAC_8C_Setup
		offsetBankTableEntry.w	DAC_8D_Setup
		offsetBankTableEntry.w	DAC_8E_Setup
		offsetBankTableEntry.w	DAC_8F_Setup

		offsetBankTableEntry.w	DAC_90_Setup
		offsetBankTableEntry.w	DAC_91_Setup
		offsetBankTableEntry.w	DAC_92_Setup
		offsetBankTableEntry.w	DAC_93_Setup
		offsetBankTableEntry.w	DAC_94_Setup
		offsetBankTableEntry.w	DAC_95_Setup
		offsetBankTableEntry.w	DAC_96_Setup
		offsetBankTableEntry.w	DAC_97_Setup
		offsetBankTableEntry.w	DAC_98_Setup
		offsetBankTableEntry.w	DAC_99_Setup
		offsetBankTableEntry.w	DAC_9A_Setup
		offsetBankTableEntry.w	DAC_9B_Setup
		offsetBankTableEntry.w	DAC_9C_Setup
		offsetBankTableEntry.w	DAC_9D_Setup
		offsetBankTableEntry.w	DAC_9E_Setup
		offsetBankTableEntry.w	DAC_9F_Setup

		offsetBankTableEntry.w	DAC_A0_Setup
		offsetBankTableEntry.w	DAC_A1_Setup
		offsetBankTableEntry.w	DAC_A2_Setup
		offsetBankTableEntry.w	DAC_A3_Setup
		offsetBankTableEntry.w	DAC_A4_Setup
		offsetBankTableEntry.w	DAC_A5_Setup
		offsetBankTableEntry.w	DAC_A6_Setup
		offsetBankTableEntry.w	DAC_A7_Setup
		offsetBankTableEntry.w	DAC_A8_Setup
		offsetBankTableEntry.w	DAC_A9_Setup
		offsetBankTableEntry.w	DAC_AA_Setup
		offsetBankTableEntry.w	DAC_AB_Setup
		offsetBankTableEntry.w	DAC_AC_Setup
		offsetBankTableEntry.w	DAC_AD_Setup
		offsetBankTableEntry.w	DAC_AE_Setup
		offsetBankTableEntry.w	DAC_AF_Setup

		offsetBankTableEntry.w	DAC_B0_Setup
		offsetBankTableEntry.w	DAC_B1_Setup
		offsetBankTableEntry.w	DAC_B2_Setup
		offsetBankTableEntry.w	DAC_B3_Setup
		offsetBankTableEntry.w	DAC_B4_Setup
		offsetBankTableEntry.w	DAC_B5_Setup
		offsetBankTableEntry.w	DAC_B6_Setup
		offsetBankTableEntry.w	DAC_B7_Setup
		offsetBankTableEntry.w	DAC_B8_B9_Setup
		offsetBankTableEntry.w	DAC_B8_B9_Setup
		offsetBankTableEntry.w	DAC_BA_Setup
		offsetBankTableEntry.w	DAC_BB_Setup
		offsetBankTableEntry.w	DAC_BC_Setup
		offsetBankTableEntry.w	DAC_BD_Setup
		offsetBankTableEntry.w	DAC_BE_Setup
		offsetBankTableEntry.w	DAC_BF_Setup

		offsetBankTableEntry.w	DAC_C0_Setup
		offsetBankTableEntry.w	DAC_C1_Setup
		offsetBankTableEntry.w	DAC_C2_Setup
		offsetBankTableEntry.w	DAC_C3_Setup
		offsetBankTableEntry.w	DAC_C4_Setup

DAC_81_Setup:		DAC_Setup $04,DAC_81_Data
DAC_82_Setup:		DAC_Setup $0E,DAC_82_83_84_85_Data
DAC_83_Setup:		DAC_Setup $14,DAC_82_83_84_85_Data
DAC_84_Setup:		DAC_Setup $1A,DAC_82_83_84_85_Data
DAC_85_Setup:		DAC_Setup $20,DAC_82_83_84_85_Data
DAC_86_Setup:		DAC_Setup $04,DAC_86_Data
DAC_87_Setup:		DAC_Setup $04,DAC_87_Data
DAC_88_Setup:		DAC_Setup $06,DAC_88_Data
DAC_89_Setup:		DAC_Setup $0A,DAC_89_Data
DAC_8A_Setup:		DAC_Setup $14,DAC_8A_8B_Data
DAC_8B_Setup:		DAC_Setup $1B,DAC_8A_8B_Data
DAC_8C_Setup:		DAC_Setup $08,DAC_8C_Data
DAC_8D_Setup:		DAC_Setup $0B,DAC_8D_8E_Data
DAC_8E_Setup:		DAC_Setup $11,DAC_8D_8E_Data
DAC_8F_Setup:		DAC_Setup $08,DAC_8F_Data
DAC_90_Setup:		DAC_Setup $03,DAC_90_91_92_93_Data
DAC_91_Setup:		DAC_Setup $07,DAC_90_91_92_93_Data
DAC_92_Setup:		DAC_Setup $0A,DAC_90_91_92_93_Data
DAC_93_Setup:		DAC_Setup $0E,DAC_90_91_92_93_Data
DAC_94_Setup:		DAC_Setup $06,DAC_94_95_96_97_Data
DAC_95_Setup:		DAC_Setup $0A,DAC_94_95_96_97_Data
DAC_96_Setup:		DAC_Setup $0D,DAC_94_95_96_97_Data
DAC_97_Setup:		DAC_Setup $12,DAC_94_95_96_97_Data
DAC_98_Setup:		DAC_Setup $0B,DAC_98_99_9A_Data
DAC_99_Setup:		DAC_Setup $13,DAC_98_99_9A_Data
DAC_9A_Setup:		DAC_Setup $16,DAC_98_99_9A_Data
DAC_9B_Setup:		DAC_Setup $0C,DAC_9B_Data
DAC_A2_Setup:		DAC_Setup $0A,DAC_A2_Data
DAC_A3_Setup:		DAC_Setup $18,DAC_A3_Data
DAC_A4_Setup:		DAC_Setup $18,DAC_A4_Data
DAC_A5_Setup:		DAC_Setup $0C,DAC_A5_Data
DAC_A6_Setup:		DAC_Setup $09,DAC_A6_Data
DAC_A7_Setup:		DAC_Setup $18,DAC_A7_Data
DAC_A8_Setup:		DAC_Setup $18,DAC_A8_Data
DAC_A9_Setup:		DAC_Setup $0C,DAC_A9_Data
DAC_AA_Setup:		DAC_Setup $0A,DAC_AA_Data
DAC_AB_Setup:		DAC_Setup $0D,DAC_AB_Data
DAC_AC_Setup:		DAC_Setup $06,DAC_AC_Data
DAC_AD_Setup:		DAC_Setup $10,DAC_AD_AE_Data
DAC_AE_Setup:		DAC_Setup $18,DAC_AD_AE_Data
DAC_AF_Setup:		DAC_Setup $09,DAC_AF_Data
DAC_B0_Setup:		DAC_Setup $12,DAC_AF_Data
DAC_B1_Setup:		DAC_Setup $18,DAC_B1_Data
DAC_B2_Setup:		DAC_Setup $16,DAC_B2_B3_Data
DAC_B3_Setup:		DAC_Setup $20,DAC_B2_B3_Data
DAC_B4_Setup:		DAC_Setup $0C,DAC_B4_C1_C2_C3_C4_Data
DAC_B5_Setup:		DAC_Setup $0C,DAC_B5_Data
DAC_B6_Setup:		DAC_Setup $0C,DAC_B6_Data
DAC_B7_Setup:		DAC_Setup $18,DAC_B7_Data
DAC_B8_B9_Setup:	DAC_Setup $0C,DAC_B8_B9_Data
DAC_BA_Setup:		DAC_Setup $18,DAC_BA_Data
DAC_BB_Setup:		DAC_Setup $18,DAC_BB_Data
DAC_BC_Setup:		DAC_Setup $18,DAC_BC_Data
DAC_BD_Setup:		DAC_Setup $0C,DAC_BD_Data
DAC_BE_Setup:		DAC_Setup $0C,DAC_BE_Data
DAC_BF_Setup:		DAC_Setup $1C,DAC_BF_Data
DAC_C0_Setup:		DAC_Setup $0B,DAC_C0_Data
DAC_C1_Setup:		DAC_Setup $0F,DAC_B4_C1_C2_C3_C4_Data
DAC_C2_Setup:		DAC_Setup $11,DAC_B4_C1_C2_C3_C4_Data
DAC_C3_Setup:		DAC_Setup $12,DAC_B4_C1_C2_C3_C4_Data
DAC_C4_Setup:		DAC_Setup $0B,DAC_B4_C1_C2_C3_C4_Data
DAC_9C_Setup:		DAC_Setup $0A,DAC_9C_Data
DAC_9D_Setup:		DAC_Setup $18,DAC_9D_Data
DAC_9E_Setup:		DAC_Setup $18,DAC_9E_Data
DAC_9F_Setup:		DAC_Setup $0C,DAC_9F_Data
DAC_A0_Setup:		DAC_Setup $0C,DAC_A0_Data
DAC_A1_Setup:		DAC_Setup $0A,DAC_A1_Data
; ---------------------------------------------------------------------------

DAC_86_Data:		DACBINCLUDE "Sound/DAC/86.bin"
DAC_81_Data:		DACBINCLUDE "Sound/DAC/81.bin"
DAC_82_83_84_85_Data:	DACBINCLUDE "Sound/DAC/82-85.bin"
DAC_94_95_96_97_Data:	DACBINCLUDE "Sound/DAC/94-97.bin"
DAC_90_91_92_93_Data:	DACBINCLUDE "Sound/DAC/90-93.bin"
DAC_88_Data:		DACBINCLUDE "Sound/DAC/88.bin"
DAC_8A_8B_Data:		DACBINCLUDE "Sound/DAC/8A-8B.bin"
DAC_8C_Data:		DACBINCLUDE "Sound/DAC/8C.bin"
DAC_8D_8E_Data:		DACBINCLUDE "Sound/DAC/8D-8E.bin"
DAC_87_Data:		DACBINCLUDE "Sound/DAC/87.bin"
DAC_8F_Data:		DACBINCLUDE "Sound/DAC/8F.bin"
DAC_89_Data:		DACBINCLUDE "Sound/DAC/89.bin"
DAC_98_99_9A_Data:	DACBINCLUDE "Sound/DAC/98-9A.bin"
DAC_9B_Data:		DACBINCLUDE "Sound/DAC/9B.bin"
DAC_B2_B3_Data:		DACBINCLUDE "Sound/DAC/B2-B3 (Sonic & Knuckles).bin"

	finishBank

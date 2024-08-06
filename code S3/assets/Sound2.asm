; ---------------------------------------------------------------------------
; Dac Bank 2
; ---------------------------------------------------------------------------
DacBank2:	startBank
		offsetBankTableEntry.w	DAC_81_Setup2
		offsetBankTableEntry.w	DAC_82_Setup2
		offsetBankTableEntry.w	DAC_83_Setup2
		offsetBankTableEntry.w	DAC_84_Setup2
		offsetBankTableEntry.w	DAC_85_Setup2
		offsetBankTableEntry.w	DAC_86_Setup2
		offsetBankTableEntry.w	DAC_87_Setup2
		offsetBankTableEntry.w	DAC_88_Setup2
		offsetBankTableEntry.w	DAC_89_Setup2
		offsetBankTableEntry.w	DAC_8A_Setup2
		offsetBankTableEntry.w	DAC_8B_Setup2
		offsetBankTableEntry.w	DAC_8C_Setup2
		offsetBankTableEntry.w	DAC_8D_Setup2
		offsetBankTableEntry.w	DAC_8E_Setup2
		offsetBankTableEntry.w	DAC_8F_Setup2

		offsetBankTableEntry.w	DAC_90_Setup2
		offsetBankTableEntry.w	DAC_91_Setup2
		offsetBankTableEntry.w	DAC_92_Setup2
		offsetBankTableEntry.w	DAC_93_Setup2
		offsetBankTableEntry.w	DAC_94_Setup2
		offsetBankTableEntry.w	DAC_95_Setup2
		offsetBankTableEntry.w	DAC_96_Setup2
		offsetBankTableEntry.w	DAC_97_Setup2
		offsetBankTableEntry.w	DAC_98_Setup2
		offsetBankTableEntry.w	DAC_99_Setup2
		offsetBankTableEntry.w	DAC_9A_Setup2
		offsetBankTableEntry.w	DAC_9B_Setup2
		offsetBankTableEntry.w	DAC_9C_Setup2
		offsetBankTableEntry.w	DAC_9D_Setup2
		offsetBankTableEntry.w	DAC_9E_Setup2
		offsetBankTableEntry.w	DAC_9F_Setup2

		offsetBankTableEntry.w	DAC_A0_Setup2
		offsetBankTableEntry.w	DAC_A1_Setup2
		offsetBankTableEntry.w	DAC_A2_Setup2
		offsetBankTableEntry.w	DAC_A3_Setup2
		offsetBankTableEntry.w	DAC_A4_Setup2
		offsetBankTableEntry.w	DAC_A5_Setup2
		offsetBankTableEntry.w	DAC_A6_Setup2
		offsetBankTableEntry.w	DAC_A7_Setup2
		offsetBankTableEntry.w	DAC_A8_Setup2
		offsetBankTableEntry.w	DAC_A9_Setup2
		offsetBankTableEntry.w	DAC_AA_Setup2
		offsetBankTableEntry.w	DAC_AB_Setup2
		offsetBankTableEntry.w	DAC_AC_Setup2
		offsetBankTableEntry.w	DAC_AD_Setup2
		offsetBankTableEntry.w	DAC_AE_Setup2
		offsetBankTableEntry.w	DAC_AF_Setup2

		offsetBankTableEntry.w	DAC_B0_Setup2
		offsetBankTableEntry.w	DAC_B1_Setup2
		offsetBankTableEntry.w	DAC_B2_Setup2
		offsetBankTableEntry.w	DAC_B3_Setup2
		offsetBankTableEntry.w	DAC_B4_Setup2
		offsetBankTableEntry.w	DAC_B5_Setup2
		offsetBankTableEntry.w	DAC_B6_Setup2
		offsetBankTableEntry.w	DAC_B7_Setup2
		offsetBankTableEntry.w	DAC_B8_B9_Setup2
		offsetBankTableEntry.w	DAC_B8_B9_Setup2
		offsetBankTableEntry.w	DAC_BA_Setup2
		offsetBankTableEntry.w	DAC_BB_Setup2
		offsetBankTableEntry.w	DAC_BC_Setup2
		offsetBankTableEntry.w	DAC_BD_Setup2
		offsetBankTableEntry.w	DAC_BE_Setup2
		offsetBankTableEntry.w	DAC_BF_Setup2

		offsetBankTableEntry.w	DAC_C0_Setup2
		offsetBankTableEntry.w	DAC_C1_Setup2
		offsetBankTableEntry.w	DAC_C2_Setup2
		offsetBankTableEntry.w	DAC_C3_Setup2
		offsetBankTableEntry.w	DAC_C4_Setup2

DAC_81_Setup2:			DAC_Null_Setup 19000
DAC_82_Setup2:			DAC_Null_Setup 11500
DAC_83_Setup2:			DAC_Null_Chain 9000,DAC_82_Setup2
DAC_84_Setup2:			DAC_Null_Chain 7500,DAC_83_Setup2
DAC_85_Setup2:			DAC_Null_Chain 6500,DAC_84_Setup2
DAC_86_Setup2:			DAC_Null_Setup 19000
DAC_87_Setup2:			DAC_Null_Setup 19000
DAC_88_Setup2:			DAC_Null_Setup 17000
DAC_89_Setup2:			DAC_Null_Setup 13500
DAC_8A_Setup2:			DAC_Null_Setup 9000
DAC_8B_Setup2:			DAC_Null_Chain 7375,DAC_8A_Setup2
DAC_8C_Setup2:			DAC_Null_Setup 15000
DAC_8D_Setup2:			DAC_Null_Setup 13000
DAC_8E_Setup2:			DAC_Null_Chain 10000,DAC_8D_Setup2
DAC_8F_Setup2:			DAC_Null_Setup 15000
DAC_90_Setup2:			DAC_Null_Setup 20500
DAC_91_Setup2:			DAC_Null_Chain 16000,DAC_90_Setup2
DAC_92_Setup2:			DAC_Null_Chain 13500,DAC_91_Setup2
DAC_93_Setup2:			DAC_Null_Chain 11100,DAC_92_Setup2
DAC_94_Setup2:			DAC_Null_Setup 17000
DAC_95_Setup2:			DAC_Null_Chain 13500,DAC_94_Setup2
DAC_96_Setup2:			DAC_Null_Chain 12000,DAC_95_Setup2
DAC_97_Setup2:			DAC_Null_Chain 9750,DAC_96_Setup2
DAC_98_Setup2:			DAC_Null_Setup 13000
DAC_99_Setup2:			DAC_Null_Chain 9250,DAC_98_Setup2
DAC_9A_Setup2:			DAC_Null_Chain 8500,DAC_99_Setup2
DAC_9B_Setup2:			DAC_Setup 12500,DAC_9B_Data
DAC_A2_Setup2:			DAC_Setup 13500,DAC_A2_Data
DAC_A3_Setup2:			DAC_Setup 8000,DAC_A3_Data
DAC_A4_Setup2:			DAC_Setup 8000,DAC_A4_Data
DAC_A5_Setup2:			DAC_Setup 12500,DAC_A5_Data
DAC_A6_Setup2:			DAC_Setup 14000,DAC_A6_Data
DAC_A7_Setup2:			DAC_Setup 8000,DAC_A7_Data
DAC_A8_Setup2:			DAC_Setup 8000,DAC_A8_Data
DAC_A9_Setup2:			DAC_Setup 12500,DAC_A9_Data
DAC_AA_Setup2:			DAC_Setup 13500,DAC_AA_Data
DAC_AB_Setup2:			DAC_Null_Setup 12000
DAC_AC_Setup2:			DAC_Null_Setup 17000
DAC_AD_Setup2:			DAC_Null_Setup 10500
DAC_AE_Setup2:			DAC_Null_Chain 8000,DAC_AD_Setup2
DAC_AF_Setup2:			DAC_Null_Setup 14000
DAC_B0_Setup2:			DAC_Null_Chain 9750,DAC_AF_Setup2
DAC_B1_Setup2:			DAC_Null_Setup 8000
DAC_B2_Setup2:			DAC_Null_Setup 8500
DAC_B3_Setup2:			DAC_Null_Chain 6500,DAC_B2_Setup2
DAC_B4_Setup2:			DAC_Null_Setup 12500
DAC_B5_Setup2:			DAC_Null_Setup 12500
DAC_B6_Setup2:			DAC_Null_Setup 12500
DAC_B7_Setup2:			DAC_Null_Setup 8000
DAC_B8_B9_Setup2:		DAC_Null_Setup 12500
DAC_BA_Setup2:			DAC_Null_Setup 8000
DAC_BB_Setup2:			DAC_Null_Setup 8000
DAC_BC_Setup2:			DAC_Null_Setup 8000
DAC_BD_Setup2:			DAC_Null_Setup 12500
DAC_BE_Setup2:			DAC_Null_Setup 12500
DAC_BF_Setup2:			DAC_Null_Setup 7250
DAC_C0_Setup2:			DAC_Null_Setup 13000
DAC_C1_Setup2:			DAC_Null_Chain 11000,DAC_B4_Setup2
DAC_C2_Setup2:			DAC_Null_Chain 10000,DAC_C1_Setup2
DAC_C3_Setup2:			DAC_Null_Chain 9750,DAC_C2_Setup2
DAC_C4_Setup2:			DAC_Null_Chain 13000,DAC_C3_Setup2
DAC_9C_Setup2:			DAC_Setup 13500,DAC_9C_Data
DAC_9D_Setup2:			DAC_Setup 8000,DAC_9D_Data
DAC_9E_Setup2:			DAC_Setup 8000,DAC_9E_Data
DAC_9F_Setup2:			DAC_Setup 12500,DAC_9F_Data
DAC_A0_Setup2:			DAC_Setup 12500,DAC_A0_Data
DAC_A1_Setup2:			DAC_Setup 13500,DAC_A1_Data

DAC_9B_Data:			DACBINCLUDE "Sound/DAC/9B.bin"
DAC_9C_Data:			DACBINCLUDE "Sound/DAC/9C.bin"
DAC_9D_Data:			DACBINCLUDE "Sound/DAC/9D.bin"
DAC_9E_Data:			DACBINCLUDE "Sound/DAC/9E.bin"
DAC_9F_Data:			DACBINCLUDE "Sound/DAC/9F.bin"
DAC_A0_Data:			DACBINCLUDE "Sound/DAC/A0.bin"
DAC_A1_Data:			DACBINCLUDE "Sound/DAC/A1.bin"
DAC_A2_Data:			DACBINCLUDE "Sound/DAC/A2.bin"
DAC_A3_Data:			DACBINCLUDE "Sound/DAC/A3.bin"
DAC_A4_Data:			DACBINCLUDE "Sound/DAC/A4.bin"
DAC_A5_Data:			DACBINCLUDE "Sound/DAC/A5.bin"
DAC_A6_Data:			DACBINCLUDE "Sound/DAC/A6.bin"
DAC_A7_Data:			DACBINCLUDE "Sound/DAC/A7.bin"
DAC_A8_Data:			DACBINCLUDE "Sound/DAC/A8.bin"
DAC_A9_Data:			DACBINCLUDE "Sound/DAC/A9.bin"
DAC_AA_Data:			DACBINCLUDE "Sound/DAC/AA.bin"

	finishBank

; ---------------------------------------------------------------------------
; Dac Bank 3
; ---------------------------------------------------------------------------
DacBank3:	startBank
		offsetBankTableEntry.w	DAC_81_Setup3
		offsetBankTableEntry.w	DAC_82_Setup3
		offsetBankTableEntry.w	DAC_83_Setup3
		offsetBankTableEntry.w	DAC_84_Setup3
		offsetBankTableEntry.w	DAC_85_Setup3
		offsetBankTableEntry.w	DAC_86_Setup3
		offsetBankTableEntry.w	DAC_87_Setup3
		offsetBankTableEntry.w	DAC_88_Setup3
		offsetBankTableEntry.w	DAC_89_Setup3
		offsetBankTableEntry.w	DAC_8A_Setup3
		offsetBankTableEntry.w	DAC_8B_Setup3
		offsetBankTableEntry.w	DAC_8C_Setup3
		offsetBankTableEntry.w	DAC_8D_Setup3
		offsetBankTableEntry.w	DAC_8E_Setup3
		offsetBankTableEntry.w	DAC_8F_Setup3

		offsetBankTableEntry.w	DAC_90_Setup3
		offsetBankTableEntry.w	DAC_91_Setup3
		offsetBankTableEntry.w	DAC_92_Setup3
		offsetBankTableEntry.w	DAC_93_Setup3
		offsetBankTableEntry.w	DAC_94_Setup3
		offsetBankTableEntry.w	DAC_95_Setup3
		offsetBankTableEntry.w	DAC_96_Setup3
		offsetBankTableEntry.w	DAC_97_Setup3
		offsetBankTableEntry.w	DAC_98_Setup3
		offsetBankTableEntry.w	DAC_99_Setup3
		offsetBankTableEntry.w	DAC_9A_Setup3
		offsetBankTableEntry.w	DAC_9B_Setup3
		offsetBankTableEntry.w	DAC_9C_Setup3
		offsetBankTableEntry.w	DAC_9D_Setup3
		offsetBankTableEntry.w	DAC_9E_Setup3
		offsetBankTableEntry.w	DAC_9F_Setup3

		offsetBankTableEntry.w	DAC_A0_Setup3
		offsetBankTableEntry.w	DAC_A1_Setup3
		offsetBankTableEntry.w	DAC_A2_Setup3
		offsetBankTableEntry.w	DAC_A3_Setup3
		offsetBankTableEntry.w	DAC_A4_Setup3
		offsetBankTableEntry.w	DAC_A5_Setup3
		offsetBankTableEntry.w	DAC_A6_Setup3
		offsetBankTableEntry.w	DAC_A7_Setup3
		offsetBankTableEntry.w	DAC_A8_Setup3
		offsetBankTableEntry.w	DAC_A9_Setup3
		offsetBankTableEntry.w	DAC_AA_Setup3
		offsetBankTableEntry.w	DAC_AB_Setup3
		offsetBankTableEntry.w	DAC_AC_Setup3
		offsetBankTableEntry.w	DAC_AD_Setup3
		offsetBankTableEntry.w	DAC_AE_Setup3
		offsetBankTableEntry.w	DAC_AF_Setup3

		offsetBankTableEntry.w	DAC_B0_Setup3
		offsetBankTableEntry.w	DAC_B1_Setup3
		offsetBankTableEntry.w	DAC_B2_Setup3
		offsetBankTableEntry.w	DAC_B3_Setup3
		offsetBankTableEntry.w	DAC_B4_Setup3
		offsetBankTableEntry.w	DAC_B5_Setup3
		offsetBankTableEntry.w	DAC_B6_Setup3
		offsetBankTableEntry.w	DAC_B7_Setup3
		offsetBankTableEntry.w	DAC_B8_B9_Setup3
		offsetBankTableEntry.w	DAC_B8_B9_Setup3
		offsetBankTableEntry.w	DAC_BA_Setup3
		offsetBankTableEntry.w	DAC_BB_Setup3
		offsetBankTableEntry.w	DAC_BC_Setup3
		offsetBankTableEntry.w	DAC_BD_Setup3
		offsetBankTableEntry.w	DAC_BE_Setup3
		offsetBankTableEntry.w	DAC_BF_Setup3

		offsetBankTableEntry.w	DAC_C0_Setup3
		offsetBankTableEntry.w	DAC_C1_Setup3
		offsetBankTableEntry.w	DAC_C2_Setup3
		offsetBankTableEntry.w	DAC_C3_Setup3
		offsetBankTableEntry.w	DAC_C4_Setup3

DAC_81_Setup3:			DAC_Null_Setup 19000
DAC_82_Setup3:			DAC_Null_Setup 11500
DAC_83_Setup3:			DAC_Null_Chain 9000,DAC_82_Setup3
DAC_84_Setup3:			DAC_Null_Chain 7500,DAC_83_Setup3
DAC_85_Setup3:			DAC_Null_Chain 6500,DAC_84_Setup3
DAC_86_Setup3:			DAC_Null_Setup 19000
DAC_87_Setup3:			DAC_Null_Setup 19000
DAC_88_Setup3:			DAC_Null_Setup 17000
DAC_89_Setup3:			DAC_Null_Setup 13500
DAC_8A_Setup3:			DAC_Null_Setup 9000
DAC_8B_Setup3:			DAC_Null_Chain 7375,DAC_8A_Setup3
DAC_8C_Setup3:			DAC_Null_Setup 15000
DAC_8D_Setup3:			DAC_Null_Setup 13000
DAC_8E_Setup3:			DAC_Null_Chain 10000,DAC_8D_Setup3
DAC_8F_Setup3:			DAC_Null_Setup 15000
DAC_90_Setup3:			DAC_Null_Setup 20500
DAC_91_Setup3:			DAC_Null_Chain 16000,DAC_90_Setup3
DAC_92_Setup3:			DAC_Null_Chain 13500,DAC_91_Setup3
DAC_93_Setup3:			DAC_Null_Chain 11100,DAC_92_Setup3
DAC_94_Setup3:			DAC_Null_Setup 17000
DAC_95_Setup3:			DAC_Null_Chain 13500,DAC_94_Setup3
DAC_96_Setup3:			DAC_Null_Chain 12000,DAC_95_Setup3
DAC_97_Setup3:			DAC_Null_Chain 9750,DAC_96_Setup3
DAC_98_Setup3:			DAC_Null_Setup 13000
DAC_99_Setup3:			DAC_Null_Chain 9250,DAC_98_Setup3
DAC_9A_Setup3:			DAC_Null_Chain 8500,DAC_99_Setup3
DAC_9B_Setup3:			DAC_Null_Setup 12500
DAC_A2_Setup3:			DAC_Null_Setup 13500
DAC_A3_Setup3:			DAC_Null_Setup 8000
DAC_A4_Setup3:			DAC_Null_Setup 8000
DAC_A5_Setup3:			DAC_Null_Setup 12500
DAC_A6_Setup3:			DAC_Null_Setup 14000
DAC_A7_Setup3:			DAC_Null_Setup 8000
DAC_A8_Setup3:			DAC_Null_Setup 8000
DAC_A9_Setup3:			DAC_Null_Setup 12500
DAC_AA_Setup3:			DAC_Null_Setup 13500
DAC_AB_Setup3:			DAC_Setup 12000,DAC_AB_Data
DAC_AC_Setup3:			DAC_Setup 17000,DAC_AC_Data
DAC_AD_Setup3:			DAC_Setup 10500,DAC_AD_AE_Data
DAC_AE_Setup3:			DAC_Setup 8000,DAC_AD_AE_Data
DAC_AF_Setup3:			DAC_Setup 14000,DAC_AF_B0_Data
DAC_B0_Setup3:			DAC_Setup 9750,DAC_AF_B0_Data
DAC_B1_Setup3:			DAC_Setup 8000,DAC_B1_Data
DAC_B2_Setup3:			DAC_Setup 8500,DAC_B2_B3_Data
DAC_B3_Setup3:			DAC_Setup 6500,DAC_B2_B3_Data
DAC_B4_Setup3:			DAC_Setup 12500,DAC_B4_C1_C2_C3_C4_Data
DAC_B5_Setup3:			DAC_Setup 12500,DAC_B5_Data
DAC_B6_Setup3:			DAC_Setup 12500,DAC_B6_Data
DAC_B7_Setup3:			DAC_Setup 8000,DAC_B7_Data
DAC_B8_B9_Setup3:		DAC_Setup 12500,DAC_B8_B9_Data
DAC_BA_Setup3:			DAC_Setup 8000,DAC_BA_Data
DAC_BB_Setup3:			DAC_Setup 8000,DAC_BB_Data
DAC_BC_Setup3:			DAC_Setup 8000,DAC_BC_Data
DAC_BD_Setup3:			DAC_Setup 12500,DAC_BD_Data
DAC_BE_Setup3:			DAC_Setup 12500,DAC_BE_Data
DAC_BF_Setup3:			DAC_Setup 7250,DAC_BF_Data
DAC_C0_Setup3:			DAC_Setup 13000,DAC_C0_Data
DAC_C1_Setup3:			DAC_Setup 11000,DAC_B4_C1_C2_C3_C4_Data
DAC_C2_Setup3:			DAC_Setup 10000,DAC_B4_C1_C2_C3_C4_Data
DAC_C3_Setup3:			DAC_Setup 9750,DAC_B4_C1_C2_C3_C4_Data
DAC_C4_Setup3:			DAC_Setup 13000,DAC_B4_C1_C2_C3_C4_Data
DAC_9C_Setup3:			DAC_Null_Setup 13500
DAC_9D_Setup3:			DAC_Null_Setup 8000
DAC_9E_Setup3:			DAC_Null_Setup 8000
DAC_9F_Setup3:			DAC_Null_Setup 12500
DAC_A0_Setup3:			DAC_Null_Setup 12500
DAC_A1_Setup3:			DAC_Null_Setup 13500

DAC_AB_Data:			DACBINCLUDE "Sound/DAC/AB.bin"
DAC_AC_Data:			DACBINCLUDE "Sound/DAC/AC.bin"
DAC_AD_AE_Data:			DACBINCLUDE "Sound/DAC/AD-AE.bin"
DAC_AF_B0_Data:			DACBINCLUDE "Sound/DAC/AF-B0.bin"
DAC_Unused_Data:		DACBINCLUDE "Sound/DAC/Unused.bin"
DAC_B1_Data:			DACBINCLUDE "Sound/DAC/B1.bin"
DAC_B2_B3_Data:			DACBINCLUDE "Sound/DAC/B2-B3 (Sonic 3).bin"
DAC_B4_C1_C2_C3_C4_Data:	DACBINCLUDE "Sound/DAC/B4C1-C4.bin"
DAC_B5_Data:			DACBINCLUDE "Sound/DAC/B5.bin"
DAC_B6_Data:			DACBINCLUDE "Sound/DAC/B6.bin"
DAC_B7_Data:			DACBINCLUDE "Sound/DAC/B7.bin"
DAC_B8_B9_Data:			DACBINCLUDE "Sound/DAC/B8-B9.bin"
DAC_BA_Data:			DACBINCLUDE "Sound/DAC/BA.bin"
DAC_BB_Data:			DACBINCLUDE "Sound/DAC/BB.bin"
DAC_BC_Data:			DACBINCLUDE "Sound/DAC/BC.bin"
DAC_BD_Data:			DACBINCLUDE "Sound/DAC/BD.bin"
DAC_BE_Data:			DACBINCLUDE "Sound/DAC/BE.bin"
DAC_BF_Data:			DACBINCLUDE "Sound/DAC/BF.bin"
DAC_C0_Data:			DACBINCLUDE "Sound/DAC/C0.bin"

	finishBank

; ===========================================================================
; Sound Bank
; ===========================================================================
SndBank:			startBank

SEGA_PCM:	binclude "Sound/Sega PCM.bin"
SEGA_PCM_End
		align 2
Sound_33:	include "Sound/SFX/33.asm"
Sound_34:	include "Sound/SFX/34.asm"
Sound_35:	include "Sound/SFX/35.asm"
Sound_36:	include "Sound/SFX/36.asm"
Sound_37:	include "Sound/SFX/37.asm"
Sound_38:	include "Sound/SFX/38.asm"
Sound_39:	include "Sound/SFX/39.asm"
Sound_3A:	include "Sound/SFX/3A.asm"
Sound_3B:	include "Sound/SFX/3B.asm"
Sound_3C:	include "Sound/SFX/3C.asm"
Sound_3D:	include "Sound/SFX/3D.asm"
Sound_3E:	include "Sound/SFX/3E.asm"
Sound_3F:	include "Sound/SFX/3F.asm"
Sound_40:	include "Sound/SFX/40.asm"
Sound_41:	include "Sound/SFX/41.asm"
Sound_42:	include "Sound/SFX/42.asm"
Sound_43:	include "Sound/SFX/43.asm"
Sound_44:	include "Sound/SFX/44.asm"
Sound_45:	include "Sound/SFX/45.asm"
Sound_46:	include "Sound/SFX/46.asm"
Sound_47:	include "Sound/SFX/47.asm"
Sound_48:	include "Sound/SFX/48.asm"
Sound_49:	include "Sound/SFX/49.asm"
Sound_4A:	include "Sound/SFX/4A.asm"
Sound_4B:	include "Sound/SFX/4B.asm"
Sound_4C:	include "Sound/SFX/4C.asm"
Sound_4D:	include "Sound/SFX/4D.asm"
Sound_4E:	include "Sound/SFX/4E.asm"
Sound_4F:	include "Sound/SFX/4F.asm"
Sound_50:	include "Sound/SFX/50.asm"
Sound_51:	include "Sound/SFX/51.asm"
Sound_52:	include "Sound/SFX/52.asm"
Sound_53:	include "Sound/SFX/53.asm"
Sound_54:	include "Sound/SFX/54.asm"
Sound_55:	include "Sound/SFX/55.asm"
Sound_56:	include "Sound/SFX/56.asm"
Sound_57:	include "Sound/SFX/57.asm"
Sound_58:	include "Sound/SFX/58.asm"
Sound_59:	include "Sound/SFX/59.asm"
Sound_5A:	include "Sound/SFX/5A.asm"
Sound_5B:	include "Sound/SFX/5B.asm"
Sound_5C:	include "Sound/SFX/5C.asm"
Sound_5D:	include "Sound/SFX/5D.asm"
Sound_5E:	include "Sound/SFX/5E.asm"
Sound_5F:	include "Sound/SFX/5F.asm"
Sound_60:	include "Sound/SFX/60.asm"
Sound_61:	include "Sound/SFX/61.asm"
Sound_62:	include "Sound/SFX/62.asm"
Sound_63:	include "Sound/SFX/63.asm"
Sound_64:	include "Sound/SFX/64.asm"
Sound_65:	include "Sound/SFX/65.asm"
Sound_66:	include "Sound/SFX/66.asm"
Sound_67:	include "Sound/SFX/67.asm"
Sound_68:	include "Sound/SFX/68.asm"
Sound_69:	include "Sound/SFX/69.asm"
Sound_6A:	include "Sound/SFX/6A.asm"
Sound_6B:	include "Sound/SFX/6B.asm"
Sound_6C:	include "Sound/SFX/6C.asm"
Sound_6D:	include "Sound/SFX/6D.asm"
Sound_6E:	include "Sound/SFX/6E.asm"
Sound_6F:	include "Sound/SFX/6F.asm"
Sound_70:	include "Sound/SFX/70.asm"
Sound_71:	include "Sound/SFX/71.asm"
Sound_72:	include "Sound/SFX/72.asm"
Sound_73:	include "Sound/SFX/73.asm"
Sound_74:	include "Sound/SFX/74.asm"
Sound_75:	include "Sound/SFX/75.asm"
Sound_76:	include "Sound/SFX/76.asm"
Sound_77:	include "Sound/SFX/77.asm"
Sound_78:	include "Sound/SFX/78.asm"
Sound_79:	include "Sound/SFX/79.asm"
Sound_7A:	include "Sound/SFX/7A.asm"
Sound_7B:	include "Sound/SFX/7B.asm"
Sound_7C:	include "Sound/SFX/7C.asm"
Sound_7D:	include "Sound/SFX/7D.asm"
Sound_7E:	include "Sound/SFX/7E.asm"
Sound_7F:	include "Sound/SFX/7F.asm"
Sound_80:	include "Sound/SFX/80.asm"
Sound_81:	include "Sound/SFX/81.asm"
Sound_82:	include "Sound/SFX/82.asm"
Sound_83:	include "Sound/SFX/83.asm"
Sound_84:	include "Sound/SFX/84.asm"
Sound_85:	include "Sound/SFX/85.asm"
Sound_86:	include "Sound/SFX/86.asm"
Sound_87:	include "Sound/SFX/87.asm"
Sound_88:	include "Sound/SFX/88.asm"
Sound_89:	include "Sound/SFX/89.asm"
Sound_8A:	include "Sound/SFX/8A.asm"
Sound_8B:	include "Sound/SFX/8B.asm"
Sound_8C:	include "Sound/SFX/8C.asm"
Sound_8D:	include "Sound/SFX/8D.asm"
Sound_8E:	include "Sound/SFX/8E.asm"
Sound_8F:	include "Sound/SFX/8F.asm"
Sound_90:	include "Sound/SFX/90.asm"
Sound_91:	include "Sound/SFX/91.asm"
Sound_92:	include "Sound/SFX/92.asm"
Sound_93:	include "Sound/SFX/93.asm"
Sound_94:	include "Sound/SFX/94.asm"
Sound_95:	include "Sound/SFX/95.asm"
Sound_96:	include "Sound/SFX/96.asm"
Sound_97:	include "Sound/SFX/97.asm"
Sound_98:	include "Sound/SFX/98.asm"
Sound_99:	include "Sound/SFX/99.asm"
Sound_9A:	include "Sound/SFX/9A.asm"
Sound_9B:	include "Sound/SFX/9B (Sonic 3).asm"
Sound_9C:	include "Sound/SFX/9C.asm"
Sound_9D:	include "Sound/SFX/9D.asm"
Sound_9E:	include "Sound/SFX/9E.asm"
Sound_9F:	include "Sound/SFX/9F.asm"
Sound_A0:	include "Sound/SFX/A0.asm"
Sound_A1:	include "Sound/SFX/A1.asm"
Sound_A2:	include "Sound/SFX/A2.asm"
Sound_A3:	include "Sound/SFX/A3.asm"
Sound_A4:	include "Sound/SFX/A4.asm"
Sound_A5:	include "Sound/SFX/A5.asm"
Sound_A6:	include "Sound/SFX/A6.asm"
Sound_A7:	include "Sound/SFX/A7.asm"
Sound_A8:	include "Sound/SFX/A8.asm"
Sound_A9:	include "Sound/SFX/A9.asm"
Sound_AA:	include "Sound/SFX/AA.asm"
Sound_AB:	include "Sound/SFX/AB.asm"
Sound_AC:	include "Sound/SFX/AC.asm"
Sound_AD:	include "Sound/SFX/AD (Sonic 3).asm"
Sound_AE:	include "Sound/SFX/AE.asm"
Sound_AF:	include "Sound/SFX/AF.asm"
Sound_B0:	include "Sound/SFX/B0.asm"
Sound_B1:	include "Sound/SFX/B1.asm"
Sound_B2:	include "Sound/SFX/B2.asm"
Sound_B3:	include "Sound/SFX/B3.asm"
Sound_B4:	include "Sound/SFX/B4.asm"
Sound_B5:	include "Sound/SFX/B5.asm"
Sound_B6:	include "Sound/SFX/B6.asm"
Sound_B7:	include "Sound/SFX/B7.asm"
Sound_B8:	include "Sound/SFX/B8.asm"
Sound_B9:	include "Sound/SFX/B9.asm"
Sound_BA:	include "Sound/SFX/BA.asm"
Sound_BB:	include "Sound/SFX/BB.asm"
Sound_BC:	include "Sound/SFX/BC.asm"
Sound_BD:	include "Sound/SFX/BD.asm"
Sound_BE:	include "Sound/SFX/BE.asm"
Sound_BF:	include "Sound/SFX/BF.asm"
Sound_C0:	include "Sound/SFX/C0.asm"
Sound_C1:	include "Sound/SFX/C1.asm"
Sound_C2:	include "Sound/SFX/C2.asm"
Sound_C3:	include "Sound/SFX/C3.asm"
Sound_C4:	include "Sound/SFX/C4.asm"
Sound_C5:	include "Sound/SFX/C5.asm"
Sound_C6:	include "Sound/SFX/C6.asm"
Sound_C7:	include "Sound/SFX/C7.asm"
Sound_C8:	include "Sound/SFX/C8.asm"
Sound_C9:	include "Sound/SFX/C9.asm"
Sound_CA:	include "Sound/SFX/CA.asm"
Sound_CB:	include "Sound/SFX/CB.asm"
Sound_CC:	include "Sound/SFX/CC.asm"
Sound_CD:	include "Sound/SFX/CD.asm"
Sound_CE:	include "Sound/SFX/CE.asm"
Sound_CF:	include "Sound/SFX/CF.asm"
Sound_D0:	include "Sound/SFX/D0.asm"
Sound_D1:	include "Sound/SFX/D1.asm"
Sound_D2:	include "Sound/SFX/D2.asm"
Sound_D3:	include "Sound/SFX/D3.asm"
Sound_D4:	include "Sound/SFX/D4.asm"
Sound_D5:	include "Sound/SFX/D5.asm"
Sound_D6:	include "Sound/SFX/D6.asm"
Sound_D7:	include "Sound/SFX/D7.asm"
Sound_D8:	include "Sound/SFX/D8.asm"
Sound_D9:	include "Sound/SFX/D9.asm"
Sound_DA:	include "Sound/SFX/DA.asm"
Sound_DB:	include "Sound/SFX/DB.asm"

	finishBank

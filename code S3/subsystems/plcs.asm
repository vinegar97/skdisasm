; ---------------------------------------------------------------------------
;	1st PLC		palette                          2nd 8x8 data                                       2nd 16x16 data                                     2nd 128x128 data
;		2nd PLC           1st 8x8 data                                    1st 16x16 data                                      1st 128x128 data
LevelLoadBlock:
	levartptrs $B,  $B,  $A,  AIZ1_8x8_Primary_KosM, AIZ1_8x8_Secondary_KosM, AIZ1_16x16_Primary_Kos,   AIZ1_16x16_Secondary_Kos, AIZ1_128x128_Kos,        AIZ1_128x128_Kos			; ANGEL ISLAND ZONE ACT 1
	levartptrs $C,  $C,  $B,  AIZ2_8x8_Primary_KosM, AIZ2_8x8_Secondary_KosM, AIZ2_16x16_Primary_Kos,   AIZ2_16x16_Secondary_Kos, AIZ2_128x128_Kos,        AIZ2_128x128_Kos			; ANGEL ISLAND ZONE ACT 2
	levartptrs $E,  $F,  $C,  HCZ_8x8_Primary_KosM,  HCZ1_8x8_Secondary_KosM, HCZ_16x16_Primary_Kos,    HCZ1_16x16_Secondary_Kos, HCZ_128x128_Primary_Kos, HCZ1_128x128_Secondary_Kos	; HYDROCITY ZONE ACT 1
	levartptrs $10, $11, $D,  HCZ_8x8_Primary_KosM,  HCZ2_8x8_Secondary_KosM, HCZ_16x16_Primary_Kos,    HCZ2_16x16_Secondary_Kos, HCZ_128x128_Primary_Kos, HCZ2_128x128_Secondary_Kos	; HYDROCITY ZONE ACT 2
	levartptrs $12, $12, $E,  MGZ_8x8_Primary_KosM,  MGZ1_8x8_Secondary_KosM, MGZ_16x16_Primary_Kos,    MGZ1_16x16_Secondary_Kos, MGZ_128x128_Primary_Kos, MGZ1_128x128_Secondary_Kos	; MARBLE GARDEN ZONE ACT 1
	levartptrs $14, $14, $F,  MGZ_8x8_Primary_KosM,  MGZ2_8x8_Secondary_KosM, MGZ_16x16_Primary_Kos,    MGZ2_16x16_Secondary_Kos, MGZ_128x128_Primary_Kos, MGZ2_128x128_Secondary_Kos	; MARBLE GARDEN ZONE ACT 2
	levartptrs $16, $17, $10, CNZ_8x8_KosM,          CNZ_8x8_KosM,            CNZ_16x16_Kos,            CNZ_16x16_Kos,            CNZ_128x128_Kos,         CNZ_128x128_Kos			; CARNIVAL NIGHT ZONE ACT 1
	levartptrs $18, $19, $11, CNZ_8x8_KosM,          CNZ_8x8_KosM,            CNZ_16x16_Kos,            CNZ_16x16_Kos,            CNZ_128x128_Kos,         CNZ_128x128_Kos			; CARNIVAL NIGHT ZONE ACT 2
	levartptrs $1A, $1A, $12, FBZ1_8x8_KosM,         FBZ1_8x8_KosM,           FBZ1_16x16_Kos,           FBZ1_16x16_Kos,           FBZ1_128x128_Kos,        FBZ1_128x128_Kos			; FLYING BATTERY ZONE ACT 1 (unused)
	levartptrs $1C, $1C, $13, FBZ2_8x8_KosM,         FBZ2_8x8_KosM,           FBZ2_16x16_Kos,           FBZ2_16x16_Kos,           FBZ2_128x128_Kos,        FBZ2_128x128_Kos			; FLYING BATTERY ZONE ACT 2 (unused)
	levartptrs $1E, $1E, $14, ICZ_8x8_Primary_KosM,  ICZ1_8x8_Secondary_KosM, ICZ_16x16_Primary_Kos,    ICZ1_16x16_Secondary_Kos, ICZ_128x128_Primary_Kos, ICZ1_128x128_Secondary_Kos	; ICECAP ZONE ACT 1
	levartptrs $20, $20, $15, ICZ_8x8_Primary_KosM,  ICZ2_8x8_Secondary_KosM, ICZ_16x16_Primary_Kos,    ICZ2_16x16_Secondary_Kos, ICZ_128x128_Primary_Kos, ICZ2_128x128_Secondary_Kos	; ICECAP ZONE ACT 2
	levartptrs $22, $22, $16, LBZ_8x8_Primary_KosM,  LBZ1_8x8_Secondary_KosM, LBZ_16x16_Primary_Kos,    LBZ1_16x16_Secondary_Kos, LBZ1_128x128_Kos,        LBZ1_128x128_Kos			; LAUNCH BASE ZONE ACT 1
	levartptrs $24, $25, $17, LBZ_8x8_Primary_KosM,  LBZ2_8x8_Secondary_KosM, LBZ_16x16_Primary_Kos,    LBZ2_16x16_Secondary_Kos, LBZ2_128x128_Kos,        LBZ2_128x128_Kos			; LAUNCH BASE ZONE ACT 2
	levartptrs $26, $26, $18, ArtKosM_MHZ,           ArtKosM_MHZ,             MHZ_16x16_Kos,            MHZ_16x16_Kos,            MHZ_128x128_Kos,         MHZ_128x128_Kos			; MUSHROOM HILL ZONE ACT 1 (unused)
	levartptrs $28, $28, $19, ArtKosM_MHZ,           ArtKosM_MHZ,             MHZ_16x16_Kos,            MHZ_16x16_Kos,            MHZ_128x128_Kos,         MHZ_128x128_Kos			; MUSHROOM HILL ZONE ACT 2 (unused)
	levartptrs $B,  $B,  $A,  AIZ1_8x8_Primary_KosM, AIZ1_8x8_Secondary_KosM, AIZ1_16x16_Secondary_Kos, AIZ1_16x16_Secondary_Kos, AIZ1_128x128_Kos,        AIZ1_128x128_Kos			; SANDOPOLIS ZONE ACT 1 (unused)
	levartptrs $C,  $C,  $B,  AIZ1_8x8_Primary_KosM, AIZ1_8x8_Secondary_KosM, AIZ1_16x16_Secondary_Kos, AIZ1_16x16_Secondary_Kos, AIZ1_128x128_Kos,        AIZ1_128x128_Kos			; SANDOPOLIS ZONE ACT 2 (unused)
	levartptrs $2E, $2E, $1C, ArtKosM_LRZ,           ArtKosM_LRZ,             LRZ_16x16_Kos,            LRZ_16x16_Kos,            LRZ_128x128_Kos,         LRZ_128x128_Kos			; LAVA REEF ZONE ACT 1 (unused)
	levartptrs $30, $30, $1D, ArtKosM_LRZ,           ArtKosM_LRZ,             LRZ_16x16_Kos,            LRZ_16x16_Kos,            LRZ_128x128_Kos,         LRZ_128x128_Kos			; LAVA REEF ZONE ACT 2 (unused)
	levartptrs $B,  $B,  $A,  AIZ1_8x8_Primary_KosM, AIZ1_8x8_Secondary_KosM, AIZ1_16x16_Secondary_Kos, AIZ1_16x16_Secondary_Kos, AIZ1_128x128_Kos,        AIZ1_128x128_Kos			; SKY SANCTUARY ZONE (SONIC/TAILS) (unused)
	levartptrs $C,  $C,  $B,  AIZ1_8x8_Primary_KosM, AIZ1_8x8_Secondary_KosM, AIZ1_16x16_Secondary_Kos, AIZ1_16x16_Secondary_Kos, AIZ1_128x128_Kos,        AIZ1_128x128_Kos			; SKY SANCTUARY ZONE (KNUCKLES) (unused)
	levartptrs $B,  $B,  $A,  AIZ1_8x8_Primary_KosM, AIZ1_8x8_Secondary_KosM, AIZ1_16x16_Secondary_Kos, AIZ1_16x16_Secondary_Kos, AIZ1_128x128_Kos,        AIZ1_128x128_Kos			; DEATH EGG ZONE ACT 1 (unused)
	levartptrs $C,  $C,  $B,  AIZ1_8x8_Primary_KosM, AIZ1_8x8_Secondary_KosM, AIZ1_16x16_Secondary_Kos, AIZ1_16x16_Secondary_Kos, AIZ1_128x128_Kos,        AIZ1_128x128_Kos			; DEATH EGG ZONE ACT 2 (unused)
	levartptrs $B,  $B,  $A,  AIZ1_8x8_Primary_KosM, AIZ1_8x8_Secondary_KosM, AIZ1_16x16_Secondary_Kos, AIZ1_16x16_Secondary_Kos, AIZ1_128x128_Kos,        AIZ1_128x128_Kos			; DOOMSDAY ZONE (unused)
	levartptrs $C,  $C,  $B,  AIZ1_8x8_Primary_KosM, AIZ1_8x8_Secondary_KosM, AIZ1_16x16_Secondary_Kos, AIZ1_16x16_Secondary_Kos, AIZ1_128x128_Kos,        AIZ1_128x128_Kos			; DOOMSDAY ZONE (unused)

	levartptrs $B,  $B,  $2A, AIZ1_8x8_Primary_KosM, AIZ1_8x8_MainLevel_KosM, AIZ1_16x16_Primary_Kos,   AIZ1_16x16_MainLevel_Kos, AIZ1_128x128_Kos,        AIZ1_128x128_Kos			; SONIC/TAILS INTRO (unused)
	levartptrs $C,  $C,  $B,  AIZ1_8x8_Primary_KosM, AIZ1_8x8_Secondary_KosM, AIZ1_16x16_Secondary_Kos, AIZ1_16x16_Secondary_Kos, AIZ1_128x128_Kos,        AIZ1_128x128_Kos			; SONIC/TAILS ENDING (unused)

	levartptrs $42, $42, $26, ALZ_8x8_KosM,          ALZ_8x8_KosM,            ALZ_16x16_Kos,            ALZ_16x16_Kos,            ALZ_128x128_Kos,         ALZ_128x128_Kos			; AZURE LAKE ZONE
	levartptrs $42, $42, $27, ALZ_8x8_KosM,          ALZ_8x8_KosM,            ALZ_16x16_Kos,            ALZ_16x16_Kos,            ALZ_128x128_Kos,         ALZ_128x128_Kos			; AZURE LAKE ZONE (unused)
	levartptrs $43, $43, $28, BPZ_8x8_KosM,          BPZ_8x8_KosM,            BPZ_16x16_Kos,            BPZ_16x16_Kos,            BPZ_128x128_Kos,         BPZ_128x128_Kos			; BALLOON PARK ZONE
	levartptrs $43, $43, $29, BPZ_8x8_KosM,          BPZ_8x8_KosM,            BPZ_16x16_Kos,            BPZ_16x16_Kos,            BPZ_128x128_Kos,         BPZ_128x128_Kos			; BALLOON PARK ZONE (unused)
	levartptrs $44, $44, $34, DPZ_8x8_KosM,          DPZ_8x8_KosM,            DPZ_16x16_Kos,            DPZ_16x16_Kos,            DPZ_128x128_Kos,         DPZ_128x128_Kos			; DESERT PALACE ZONE
	levartptrs $44, $44, $34, DPZ_8x8_KosM,          DPZ_8x8_KosM,            DPZ_16x16_Kos,            DPZ_16x16_Kos,            DPZ_128x128_Kos,         DPZ_128x128_Kos			; DESERT PALACE ZONE (unused)
	levartptrs $45, $45, $35, CGZ_8x8_KosM,          CGZ_8x8_KosM,            CGZ_16x16_Kos,            CGZ_16x16_Kos,            CGZ_128x128_Kos,         CGZ_128x128_Kos			; CHROME GADGET ZONE
	levartptrs $45, $45, $35, CGZ_8x8_KosM,          CGZ_8x8_KosM,            CGZ_16x16_Kos,            CGZ_16x16_Kos,            CGZ_128x128_Kos,         CGZ_128x128_Kos			; CHROME GADGET ZONE (unused)
	levartptrs $46, $46, $36, EMZ_8x8_KosM,          EMZ_8x8_KosM,            EMZ_16x16_Kos,            EMZ_16x16_Kos,            EMZ_128x128_Kos,         EMZ_128x128_Kos			; ENDLESS MINE ZONE
	levartptrs $46, $46, $36, EMZ_8x8_KosM,          EMZ_8x8_KosM,            EMZ_16x16_Kos,            EMZ_16x16_Kos,            EMZ_128x128_Kos,         EMZ_128x128_Kos			; ENDLESS MINE ZONE (unused)

	levartptrs $47, $47, $33, Gumball_8x8_KosM,      Gumball_8x8_KosM,        Gumball_16x16_Kos,        Gumball_16x16_Kos,        Gumball_128x128_Kos,     Gumball_128x128_Kos		; GUMBALL
	levartptrs $47, $47, $33, Gumball_8x8_KosM,      Gumball_8x8_KosM,        Gumball_16x16_Kos,        Gumball_16x16_Kos,        Gumball_128x128_Kos,     Gumball_128x128_Kos		; GUMBALL (unused)
	levartptrs $47, $47, $37, ArtKosM_Pachinko,      ArtKosM_Pachinko,        Pachinko_16x16_Kos,       Pachinko_16x16_Kos,       Pachinko_128x128_Kos,    Pachinko_128x128_Kos		; PACHINKO (unused)
	levartptrs $47, $47, $37, ArtKosM_Pachinko,      ArtKosM_Pachinko,        Pachinko_16x16_Kos,       Pachinko_16x16_Kos,       Pachinko_128x128_Kos,    Pachinko_128x128_Kos		; PACHINKO (unused)
	levartptrs $47, $47, $38, ArtKosM_Slots,         ArtKosM_Slots,           Slots_16x16_Kos,          Slots_16x16_Kos,          Slots_128x128_Kos,       Slots_128x128_Kos		; SLOTS (unused)
	levartptrs $47, $47, $38, ArtKosM_Slots,         ArtKosM_Slots,           Slots_16x16_Kos,          Slots_16x16_Kos,          Slots_128x128_Kos,       Slots_128x128_Kos		; SLOTS (unused)

	levartptrs $B,  $B,  $A,  AIZ1_8x8_Primary_KosM, AIZ1_8x8_Secondary_KosM, AIZ1_16x16_Secondary_Kos, AIZ1_16x16_Secondary_Kos, AIZ1_128x128_Kos,        AIZ1_128x128_Kos			; LAVA REEF ZONE BOSS (unused)
	levartptrs $C,  $C,  $B,  AIZ1_8x8_Primary_KosM, AIZ1_8x8_Secondary_KosM, AIZ1_16x16_Secondary_Kos, AIZ1_16x16_Secondary_Kos, AIZ1_128x128_Kos,        AIZ1_128x128_Kos			; HIDDEN PALACE ZONE (unused)
	levartptrs $B,  $B,  $A,  AIZ1_8x8_Primary_KosM, AIZ1_8x8_Secondary_KosM, AIZ1_16x16_Secondary_Kos, AIZ1_16x16_Secondary_Kos, AIZ1_128x128_Kos,        AIZ1_128x128_Kos			; SONIC/TAILS FINAL BOSS (unused)
	levartptrs $C,  $C,  $B,  AIZ1_8x8_Primary_KosM, AIZ1_8x8_Secondary_KosM, AIZ1_16x16_Secondary_Kos, AIZ1_16x16_Secondary_Kos, AIZ1_128x128_Kos,        AIZ1_128x128_Kos			; SPECIAL STAGE HUB (unused)

; ---------------------------------------------------------------------------
Offs_PLC:
		dc.w PLC_00-Offs_PLC					; Sonic life icon/universal level graphics
		dc.w PLC_01-Offs_PLC					; Sonic life icon/universal level graphics
		dc.w PLC_02-Offs_PLC					; Explosions + Squirrel/Flicky (unused)
		dc.w PLC_03-Offs_PLC					; Game Over text
		dc.w PLC_04-Offs_PLC					; Signpost art (unused)
		dc.w PLC_05-Offs_PLC					; Spikes and springs (unused)
		dc.w PLC_06-Offs_PLC					; 2P mode-specific art
		dc.w PLC_07-Offs_PLC					; Tails life icon/universal level graphics
		dc.w PLC_08-Offs_PLC					; Monitor art only
		dc.w PLC_09-Offs_PLC					; Revolving spheres
		dc.w PLC_0A-Offs_PLC					; AIZ intro graphics
		dc.w PLC_0B-Offs_PLC					; AIZ1
		dc.w PLC_0C_0D-Offs_PLC					; AIZ2
		dc.w PLC_0C_0D-Offs_PLC					; AIZ2 (unused)
		dc.w PLC_0E-Offs_PLC					; HCZ1 part 1
		dc.w PLC_0F-Offs_PLC					; HCZ1 part 2
		dc.w PLC_10-Offs_PLC					; HCZ2 part 1
		dc.w PLC_11-Offs_PLC					; HCZ2 part 2
		dc.w PLC_12_13-Offs_PLC					; MGZ1
		dc.w PLC_12_13-Offs_PLC					; MGZ1 (unused)
		dc.w PLC_14_15-Offs_PLC					; MGZ2
		dc.w PLC_14_15-Offs_PLC					; MGZ2 (unused)
		dc.w PLC_16_17_18_19-Offs_PLC				; CNZ (used for act 1)
		dc.w PLC_16_17_18_19-Offs_PLC				; CNZ (used for act 1)
		dc.w PLC_16_17_18_19-Offs_PLC				; CNZ (used for act 2)
		dc.w PLC_16_17_18_19-Offs_PLC				; CNZ (used for act 2)
		dc.w PLC_1A_1B_1C_1D-Offs_PLC				; FBZ (used for act 1)
		dc.w PLC_1A_1B_1C_1D-Offs_PLC				; FBZ (act 1, unused)
		dc.w PLC_1A_1B_1C_1D-Offs_PLC				; FBZ (used for act 2)
		dc.w PLC_1A_1B_1C_1D-Offs_PLC				; FBZ (act 2, unused)
		dc.w PLC_1E_1F-Offs_PLC					; ICZ1
		dc.w PLC_1E_1F-Offs_PLC					; ICZ1 (unused)
		dc.w PLC_20_21-Offs_PLC					; ICZ2
		dc.w PLC_20_21-Offs_PLC					; ICZ2 (unused)
		dc.w PLC_22_23-Offs_PLC					; LBZ1
		dc.w PLC_22_23-Offs_PLC					; LBZ1 (unused)
		dc.w PLC_24-Offs_PLC					; LBZ2
		dc.w PLC_25-Offs_PLC					; LBZ2 misc art
		dc.w PLC_26_Through_2D-Offs_PLC				; MHZ (used for act 1)
		dc.w PLC_26_Through_2D-Offs_PLC				; MHZ (act 1, unused)
		dc.w PLC_26_Through_2D-Offs_PLC				; MHZ (used for act 2)
		dc.w PLC_26_Through_2D-Offs_PLC				; MHZ (act 2, unused)
		dc.w PLC_26_Through_2D-Offs_PLC				; MHZ (SOZ1, unused)
		dc.w PLC_26_Through_2D-Offs_PLC				; MHZ (SOZ1, unused)
		dc.w PLC_26_Through_2D-Offs_PLC				; MHZ (SOZ2, unused)
		dc.w PLC_26_Through_2D-Offs_PLC				; MHZ (SOZ2, unused)
		dc.w PLC_2E_Through_41-Offs_PLC				; LRZ (used for act 1)
		dc.w PLC_2E_Through_41-Offs_PLC				; LRZ (act 1, unused)
		dc.w PLC_2E_Through_41-Offs_PLC				; LRZ (used for act 2)
		dc.w PLC_2E_Through_41-Offs_PLC				; LRZ (act 2, unused)
		dc.w PLC_2E_Through_41-Offs_PLC				; LRZ (SSZ1, unused)
		dc.w PLC_2E_Through_41-Offs_PLC				; LRZ (SSZ1, unused)
		dc.w PLC_2E_Through_41-Offs_PLC				; LRZ (SSZ2, unused)
		dc.w PLC_2E_Through_41-Offs_PLC				; LRZ (SSZ2, unused)
		dc.w PLC_2E_Through_41-Offs_PLC				; LRZ (DEZ1, unused)
		dc.w PLC_2E_Through_41-Offs_PLC				; LRZ (DEZ1, unused)
		dc.w PLC_2E_Through_41-Offs_PLC				; LRZ (DEZ2, unused)
		dc.w PLC_2E_Through_41-Offs_PLC				; LRZ (DEZ2, unused)
		dc.w PLC_2E_Through_41-Offs_PLC				; LRZ (DDZ1, unused)
		dc.w PLC_2E_Through_41-Offs_PLC				; LRZ (DDZ1, unused)
		dc.w PLC_2E_Through_41-Offs_PLC				; LRZ (DDZ2, unused)
		dc.w PLC_2E_Through_41-Offs_PLC				; LRZ (DDZ2, unused)
		dc.w PLC_2E_Through_41-Offs_PLC				; LRZ (ending 1, unused)
		dc.w PLC_2E_Through_41-Offs_PLC				; LRZ (ending 1, unused)
		dc.w PLC_2E_Through_41-Offs_PLC				; LRZ (ending 2, unused)
		dc.w PLC_2E_Through_41-Offs_PLC				; LRZ (ending 2, unused)
		dc.w PLC_42-Offs_PLC					; ALZ
		dc.w PLC_43-Offs_PLC					; BPZ
		dc.w PLC_44-Offs_PLC					; DPZ
		dc.w PLC_45-Offs_PLC					; CGZ
		dc.w PLC_46-Offs_PLC					; EMZ
		dc.w PLC_47-Offs_PLC					; Gumball Bonus
		dc.w PLC_48_Through_5A-Offs_PLC				; AIZ1 boss (unused)
		dc.w PLC_48_Through_5A-Offs_PLC				; AIZ1 boss (unused)
		dc.w PLC_48_Through_5A-Offs_PLC				; AIZ1 boss (unused)
		dc.w PLC_48_Through_5A-Offs_PLC				; AIZ1 boss (unused)
		dc.w PLC_48_Through_5A-Offs_PLC				; AIZ1 boss (unused)
		dc.w PLC_48_Through_5A-Offs_PLC				; AIZ1 boss (unused)
		dc.w PLC_48_Through_5A-Offs_PLC				; AIZ1 boss (unused)
		dc.w PLC_48_Through_5A-Offs_PLC				; AIZ1 boss (unused)
		dc.w PLC_48_Through_5A-Offs_PLC				; AIZ1 boss (unused)
		dc.w PLC_48_Through_5A-Offs_PLC				; AIZ1 boss (unused)
		dc.w PLC_48_Through_5A-Offs_PLC				; AIZ1 boss (unused)
		dc.w PLC_48_Through_5A-Offs_PLC				; AIZ1 boss (unused)
		dc.w PLC_48_Through_5A-Offs_PLC				; AIZ1 boss (unused)
		dc.w PLC_48_Through_5A-Offs_PLC				; AIZ1 boss (unused)
		dc.w PLC_48_Through_5A-Offs_PLC				; AIZ1 boss (unused)
		dc.w PLC_48_Through_5A-Offs_PLC				; AIZ1 boss (unused)
		dc.w PLC_48_Through_5A-Offs_PLC				; AIZ1 boss (unused)
		dc.w PLC_48_Through_5A-Offs_PLC				; AIZ1 boss (unused)
		dc.w PLC_48_Through_5A-Offs_PLC				; AIZ1 boss
		dc.w PLC_5B-Offs_PLC					; HCZ1 boss
		dc.w PLC_5C_5D-Offs_PLC					; CNZ1 boss (unused)
		dc.w PLC_5C_5D-Offs_PLC					; CNZ1 boss
		dc.w PLC_5E-Offs_PLC					; FBZ1 boss
		dc.w PLC_5F-Offs_PLC					; ICZ1 boss
		dc.w PLC_60-Offs_PLC					; LBZ1 Eggman
		dc.w PLC_61_Through_6A-Offs_PLC				; FBZ2 subboss (unused)
		dc.w PLC_61_Through_6A-Offs_PLC				; FBZ2 subboss (unused)
		dc.w PLC_61_Through_6A-Offs_PLC				; FBZ2 subboss (unused)
		dc.w PLC_61_Through_6A-Offs_PLC				; FBZ2 subboss (unused)
		dc.w PLC_61_Through_6A-Offs_PLC				; FBZ2 subboss (unused)
		dc.w PLC_61_Through_6A-Offs_PLC				; FBZ2 subboss (unused)
		dc.w PLC_61_Through_6A-Offs_PLC				; FBZ2 subboss (unused)
		dc.w PLC_61_Through_6A-Offs_PLC				; FBZ2 subboss (unused)
		dc.w PLC_61_Through_6A-Offs_PLC				; FBZ2 subboss (unused)
		dc.w PLC_61_Through_6A-Offs_PLC				; FBZ2 subboss
		dc.w PLC_6B-Offs_PLC					; AIZ2 boss
		dc.w PLC_6C-Offs_PLC					; HCZ2 boss
		dc.w PLC_6D-Offs_PLC					; MGZ2 boss
		dc.w PLC_6E-Offs_PLC					; CNZ2 boss
		dc.w PLC_6F-Offs_PLC					; FBZ2 end boss
		dc.w PLC_70-Offs_PLC					; ICZ2 boss
		dc.w PLC_71-Offs_PLC					; LBZ2 final boss 1
		dc.w PLC_72_73_74_75_76_77-Offs_PLC			; LBZ2 Eggman (unused)
		dc.w PLC_72_73_74_75_76_77-Offs_PLC			; LBZ2 Eggman (unused)
		dc.w PLC_72_73_74_75_76_77-Offs_PLC			; LBZ2 Eggman (unused)
		dc.w PLC_72_73_74_75_76_77-Offs_PLC			; LBZ2 Eggman (unused)
		dc.w PLC_72_73_74_75_76_77-Offs_PLC			; LBZ2 Eggman (unused)
		dc.w PLC_72_73_74_75_76_77-Offs_PLC			; LBZ2 Eggman
		dc.w PLC_78_79_7A_7B-Offs_PLC				; Boss ship and explosion (unused)
		dc.w PLC_78_79_7A_7B-Offs_PLC				; Boss ship and explosion (unused)
		dc.w PLC_78_79_7A_7B-Offs_PLC				; Boss ship and explosion (unused)
		dc.w PLC_78_79_7A_7B-Offs_PLC				; Boss ship and explosion (unused)

PLC_00: plrlistheader
		plreq $7D4, ArtNem_SonicLifeIcon
		plreq ArtTile_Ring, ArtNem_RingHUDText
		plreq ArtTile_StarPost, ArtNem_EnemyPtsStarPost
		plreq ArtTile_Monitors, ArtNem_Monitors
PLC_00_End

PLC_01: plrlistheader
		plreq $7D4, ArtNem_SonicLifeIcon
		plreq ArtTile_Monitors, ArtNem_Monitors
		plreq ArtTile_Ring, ArtNem_RingHUDText
		plreq ArtTile_StarPost, ArtNem_EnemyPtsStarPost
PLC_01_End

PLC_02: plrlistheader
		plreq ArtTile_Explosion, ArtNem_Explosion
		plreq $580, ArtNem_Squirrel
		plreq $592, ArtNem_BlueFlicky
PLC_02_End

PLC_03: plrlistheader
		plreq ArtTile_Shield, ArtNem_GameOver
PLC_03_End

PLC_04: plrlistheader
		plreq $500, ArtNem_S2Signpost
PLC_04_End

PLC_05: plrlistheader
		plreq $494, ArtNem_SpikesSprings
PLC_05_End

PLC_06: plrlistheader
		plreq $391, ArtNem_2PArt_2
		plreq $3AD, ArtNem_2PArt_1
		plreq $3C6, ArtNem_2PArt_3
PLC_06_End

PLC_07: plrlistheader
		plreq $7D4, ArtNem_TailsLifeIcon
		plreq ArtTile_Monitors, ArtNem_Monitors
		plreq ArtTile_Ring, ArtNem_RingHUDText
		plreq ArtTile_StarPost, ArtNem_EnemyPtsStarPost
PLC_07_End

PLC_08: plrlistheader
		plreq ArtTile_Monitors, ArtNem_Monitors
PLC_08_End

PLC_09: plrlistheader
		plreq $4E0, ArtNem_SphereTest
PLC_09_End

PLC_0A: plrlistheader
		plreq $3D1, ArtNem_AIZIntroSprites
PLC_0A_End

PLC_0B: plrlistheader
		plreq $41B, ArtNem_AIZSwingVine
		plreq $324, ArtNem_AIZSlideRope
		plreq $333, ArtNem_AIZMisc1
		plreq $3CF, ArtNem_AIZFallingLog
		plreq $45C, ArtNem_Bubbles
		plreq $3F7, ArtNem_AIZCorkFloor
PLC_0B_End

PLC_0C_0D: plrlistheader
		plreq $2E9, ArtNem_AIZMisc2
		plreq $41B, ArtNem_AIZSwingVine
		plreq $438, ArtNem_AIZBackgroundTree
		plreq $45C, ArtNem_Bubbles
		plreq $456, ArtNem_GrayButton
		plreq $440, ArtNem_AIZCorkFloor2
PLC_0C_0D_End

PLC_0E: plrlistheader
		plreq $45C, ArtNem_Bubbles
		plreq $3CA, ArtNem_HCZMisc
		plreq $426, ArtNem_HCZButton
		plreq $37A, ArtNem_HCZWaterRush
		plreq $42E, ArtNem_HCZWaveSplash
		plreq $43E, ArtNem_HCZSpikeBall
PLC_0E_End

PLC_0F: plrlistheader
		plreq $44C, ArtNem_HCZDragonfly
PLC_0F_End

PLC_10: plrlistheader
		plreq $45C, ArtNem_Bubbles
		plreq $3CA, ArtNem_HCZMisc
		plreq $426, ArtNem_HCZButton
		plreq $42E, ArtNem_HCZWaveSplash
		plreq $43E, ArtNem_HCZSpikeBall
		plreq $35C, ArtNem_HCZ2Slide
PLC_10_End

PLC_11: plrlistheader
		plreq $350, ArtNem_HCZ2KnuxWall
		plreq  $28, ArtNem_HCZ2BlockPlat
		plreq $44C, ArtNem_HCZDragonfly
PLC_11_End

PLC_12_13: plrlistheader
		plreq $35F, ArtNem_MGZMisc1
		plreq $3FF, ArtNem_MGZMisc2
		plreq $451, ArtNem_MGZSigns
		plreq $478, ArtNem_DiagonalSpring
PLC_12_13_End

PLC_14_15: plrlistheader
		plreq $35F, ArtNem_MGZMisc1
		plreq $3FF, ArtNem_MGZMisc2
		plreq $451, ArtNem_MGZSigns
		plreq $478, ArtNem_DiagonalSpring
PLC_14_15_End

PLC_16_17_18_19: plrlistheader
		plreq $351, ArtNem_CNZMisc
		plreq $45C, ArtNem_Bubbles
		plreq $430, ArtNem_CNZPlatform
PLC_16_17_18_19_End

PLC_1A_1B_1C_1D: plrlistheader
		plreq $43A, ArtNem_DiagonalSpring
PLC_1A_1B_1C_1D_End

PLC_1E_1F: plrlistheader
		plreq $6B8, ArtNem_SnowboardDust
		plreq $43A, ArtNem_DiagonalSpring
		plreq $456, ArtNem_GrayButton
		plreq $3B6, ArtNem_ICZMisc1
		plreq $347, ArtNem_ICZIntroSprites
PLC_1E_1F_End

PLC_20_21: plrlistheader
		plreq $43A, ArtNem_DiagonalSpring
		plreq $456, ArtNem_GrayButton
		plreq $3B6, ArtNem_ICZMisc1
		plreq $377, ArtNem_ICZMisc2
		plreq $45C, ArtNem_Bubbles
PLC_20_21_End

PLC_22_23: plrlistheader
		plreq $3C3, ArtNem_LBZMisc
		plreq $455, ArtNem_LBZTubeTrans
PLC_22_23_End

PLC_24: plrlistheader
		plreq $3C3, ArtNem_LBZMisc
		plreq $45C, ArtNem_Bubbles
PLC_24_End

PLC_25: plrlistheader
		plreq $2EA, ArtNem_LBZ2Misc
PLC_25_End

PLC_26_Through_2D: plrlistheader
		plreq $43A, ArtNem_DiagonalSpring
		plreq $494, ArtNem_SpikesSprings
PLC_26_Through_2D_End

PLC_2E_Through_41: plrlistheader
		plreq $43A, ArtNem_DiagonalSpring
		plreq $494, ArtNem_SpikesSprings
PLC_2E_Through_41_End

PLC_42: plrlistheader
		plreq ArtTile_DashDust, ArtNem_2PDashdust
		plreq $6BC, ArtNem_2PStartPost
		plreq $700, ArtNem_2PLapNum
		plreq $600, ArtNem_2PTime
		plreq $75E, ArtNem_2PPosIcon
		plreq $391, ArtNem_2PArt_2
		plreq $3AD, ArtNem_2PArt_1
		plreq $3C6, ArtNem_2PArt_3
PLC_42_End

PLC_43: plrlistheader
		plreq $300, ArtNem_BPZMisc
		plreq ArtTile_DashDust, ArtNem_2PDashdust
		plreq $6BC, ArtNem_2PStartPost
		plreq $700, ArtNem_2PLapNum
		plreq $600, ArtNem_2PTime
		plreq $75E, ArtNem_2PPosIcon
		plreq $391, ArtNem_2PArt_2
		plreq $3AD, ArtNem_2PArt_1
		plreq $3C6, ArtNem_2PArt_3
PLC_43_End

PLC_44: plrlistheader
		plreq $280, ArtNem_DPZMisc
		plreq ArtTile_DashDust, ArtNem_2PDashdust
		plreq $6BC, ArtNem_2PStartPost
		plreq $700, ArtNem_2PLapNum
		plreq $600, ArtNem_2PTime
		plreq $75E, ArtNem_2PPosIcon
		plreq $391, ArtNem_2PArt_2
		plreq $3AD, ArtNem_2PArt_1
		plreq $3C6, ArtNem_2PArt_3
PLC_44_End

PLC_45: plrlistheader
		plreq $300, ArtNem_CGZMisc
		plreq ArtTile_DashDust, ArtNem_2PDashdust
		plreq $6BC, ArtNem_2PStartPost
		plreq $700, ArtNem_2PLapNum
		plreq $600, ArtNem_2PTime
		plreq $75E, ArtNem_2PPosIcon
		plreq $391, ArtNem_2PArt_2
		plreq $3AD, ArtNem_2PArt_1
		plreq $3C6, ArtNem_2PArt_3
PLC_45_End

PLC_46: plrlistheader
		plreq $300, ArtNem_EMZMisc
		plreq ArtTile_DashDust, ArtNem_2PDashdust
		plreq $6BC, ArtNem_2PStartPost
		plreq $700, ArtNem_2PLapNum
		plreq $600, ArtNem_2PTime
		plreq $75E, ArtNem_2PPosIcon
		plreq $391, ArtNem_2PArt_2
		plreq $3AD, ArtNem_2PArt_1
		plreq $3C6, ArtNem_2PArt_3
PLC_46_End

PLC_47: plrlistheader
		plreq $15B, ArtNem_BonusStage
		plreq $494, ArtNem_SpikesSprings
PLC_47_End

PLC_48_Through_5A: plrlistheader
		plreq $41A, ArtNem_AIZMiniboss
		plreq $474, ArtNem_AIZMinibossSmall
		plreq $482, ArtNem_AIZBossFire
		plreq $4D2, ArtNem_BossExplosion
PLC_48_Through_5A_End

PLC_5B: plrlistheader
		plreq $304, ArtNem_HCZMiniboss
		plreq $500, ArtNem_BossExplosion
PLC_5B_End

PLC_5C_5D: plrlistheader
		plreq $52E, ArtNem_CNZMiniboss
		plreq $500, ArtNem_BossExplosion
PLC_5C_5D_End

PLC_5E: plrlistheader
		plreq $52E, ArtNem_FBZMiniboss
		plreq $44E, ArtNem_EggCapsule
		plreq $500, ArtNem_BossExplosion
		plreq $42E, ArtNem_Squirrel
		plreq $440, ArtNem_BlueFlicky
PLC_5E_End

PLC_5F: plrlistheader
		plreq $4A9, ArtNem_ICZMiniboss
		plreq $500, ArtNem_BossExplosion
PLC_5F_End

PLC_60: plrlistheader
		plreq $52E, ArtNem_RobotnikShip
		plreq $4D6, ArtNem_LBZKnuxBomb
PLC_60_End

PLC_61_Through_6A: plrlistheader
		plreq $52E, ArtNem_FBZ2Subboss
		plreq $466, ArtNem_FBZRobotnikStand
		plreq $4A9, ArtNem_FBZRobotnikRun
		plreq $500, ArtNem_BossExplosion
PLC_61_Through_6A_End

PLC_6B: plrlistheader
		plreq $52E, ArtNem_RobotnikShip
		plreq $4D2, ArtNem_BossExplosion
PLC_6B_End

PLC_6C: plrlistheader
		plreq $320, ArtNem_HCZEndBoss
		plreq $52E, ArtNem_RobotnikShip
		plreq $500, ArtNem_BossExplosion
		plreq $494, ArtNem_EggCapsule
PLC_6C_End

PLC_6D: plrlistheader
		plreq $52E, ArtNem_RobotnikShip
		plreq $500, ArtNem_BossExplosion
		plreq $494, ArtNem_EggCapsule
PLC_6D_End

PLC_6E: plrlistheader
		plreq $430, ArtNem_CNZEndBoss
		plreq $52E, ArtNem_RobotnikShip
		plreq $500, ArtNem_BossExplosion
		plreq $494, ArtNem_EggCapsule
PLC_6E_End

PLC_6F: plrlistheader
		plreq $3E0, ArtNem_FBZEndBoss
		plreq $410, ArtNem_FBZRobotnikHead
		plreq $454, ArtNem_FBZEndBossFlame
		plreq $52E, ArtNem_RobotnikShip
		plreq $500, ArtNem_BossExplosion
		plreq $494, ArtNem_EggCapsule
PLC_6F_End

PLC_70: plrlistheader
		plreq $2A6, ArtNem_ICZEndBoss
		plreq $52E, ArtNem_RobotnikShip
		plreq $500, ArtNem_BossExplosion
		plreq $494, ArtNem_EggCapsule
PLC_70_End

PLC_71: plrlistheader
		plreq $3AA, ArtNem_LBZFinalBoss1
		plreq $500, ArtNem_BossExplosion
PLC_71_End

PLC_72_73_74_75_76_77: plrlistheader
		plreq $52E, ArtNem_RobotnikShip
		plreq $4A9, ArtNem_FBZRobotnikRun
		plreq $500, ArtNem_BossExplosion
PLC_72_73_74_75_76_77_End

PLC_78_79_7A_7B: plrlistheader
		plreq $52E, ArtNem_RobotnikShip
		plreq $500, ArtNem_BossExplosion
PLC_78_79_7A_7B_End

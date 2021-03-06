//// battery
//
// In config ACPI, ACEL._STA to XSTA
// Find:    5F535441 00A02D93
// Replace: 58535441 00A02D93
//
// In config ACPI, GACW to XC12
// Find:     47414357 0070
// Replace:  58433132 0070
//
// In config ACPI, GBAW  to XC13
// Find:     47424157 0070
// Replace:  58433133 0070
//
// In config ACPI, BTIF to XTIF
// Find:     42544946 0979
// Replace:  58544946 0979
//
// In config ACPI, BTST to XTST
// Find:     42545354 0A79
// Replace:  58545354 0A79
//
// In config ACPI, ITLB to XITL
// Find:     49544C42 0077
// Replace:  5849544C 0077
//
// In config ACPI, GBTI to XBTI
// Find:     47425449 0170
// Replace:  58425449 0170
//
// In config ACPI, GBTC to XGBU
// Find:     47425443 0070
// Replace:  58474255 0070
//
// In config ACPI, SBTC to XSBT
// Find:     53425443 0370
// Replace:  58534254 0370
//
// In config ACPI, GCGC to XGCG
// Find:     47434743 0808
// Replace:  58474347 0808
//
DefinitionBlock ("", "SSDT", 2, "OCLT", "BAT0", 0x00000000)
{
    External (_SB_.BTOP, PkgObj)
    External (_SB_.NBST, PkgObj)
    External (_SB_.NBTI, PkgObj)
    External (_SB_.NDBS, PkgObj)
    External (_SB_.PCI0.ACEL, DeviceObj)
    External (_SB_.PCI0.ACEL.XSTA, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.LPCB.EC0_, DeviceObj)
    External (_SB_.PCI0.LPCB.EC0_.BATN, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0_.BATP, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0_.BRCC, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0_.BRCV, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0_.BSEL, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0_.BST_, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0_.BSTA, MethodObj)    // 1 Arguments
    External (_SB_.PCI0.LPCB.EC0_.BTDR, MethodObj)    // 1 Arguments
    External (_SB_.PCI0.LPCB.EC0_.BTMX, MutexObj)
    External (_SB_.PCI0.LPCB.EC0_.ECMX, MutexObj)
    External (_SB_.PCI0.LPCB.EC0_.ECRG, IntObj)
    External (_SB_.PCI0.LPCB.EC0_.GACS, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.LPCB.EC0_.GBMF, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.LPCB.EC0_.GBSS, MethodObj)    // 2 Arguments
    External (_SB_.PCI0.LPCB.EC0_.GCTL, MethodObj)    // 1 Arguments
    External (_SB_.PCI0.LPCB.EC0_.GDCH, MethodObj)    // 1 Arguments
    External (_SB_.PCI0.LPCB.EC0_.GDNM, MethodObj)    // 1 Arguments
    External (_SB_.PCI0.LPCB.EC0_.IDIS, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0_.INAC, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0_.INCH, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0_.LB1_, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0_.LB2_, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0_.NDCB, IntObj)
    External (_SB_.PCI0.LPCB.EC0_.NGBF, IntObj)
    External (_SB_.PCI0.LPCB.EC0_.NGBT, IntObj)
    External (_SB_.PCI0.LPCB.EC0_.NLB1, IntObj)
    External (_SB_.PCI0.LPCB.EC0_.NLB2, IntObj)
    External (_SB_.PCI0.LPCB.EC0_.NLO2, IntObj)
    External (_SB_.PCI0.LPCB.EC0_.PSSB, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0_.PWRS, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0_.XBTI, MethodObj)    // 1 Arguments
    External (_SB_.PCI0.LPCB.EC0_.XC12, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.LPCB.EC0_.XC13, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.LPCB.EC0_.XGBU, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.LPCB.EC0_.XITL, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.LPCB.EC0_.XSBT, MethodObj)    // 3 Arguments
    External (_SB_.PCI0.LPCB.EC0_.XTIF, MethodObj)    // 1 Arguments
    External (_SB_.PCI0.LPCB.EC0_.XTST, MethodObj)    // 2 Arguments
    External (_TZ_.XGCG, MethodObj)    // 0 Arguments

    Method (B1B2, 2, NotSerialized)
    {
        Return ((Arg0 | (Arg1 << 0x08)))
    }

    Scope (\_SB.PCI0.ACEL)
    {
        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            If (_OSI ("Darwin"))
            {
                Return (Zero)
            }
            Else
            {
                Return (XSTA ())
            }
        }
    }

    Scope (_SB.PCI0.LPCB.EC0)
    {
        OperationRegion (ERM2, EmbeddedControl, Zero, 0xFF)
        Field (ERM2, ByteAcc, NoLock, Preserve)
        {
            Offset (0x89), 
            BDC1,   8, 
            BDC2,   8, 
            Offset (0x8D), 
            BFC1,   8, 
            BFC2,   8, 
            BRT1,   8, 
            BRT2,   8, 
            Offset (0x92), 
            BME1,   8, 
            BME2,   8, 
            Offset (0x95), 
            BDV1,   8, 
            BDV2,   8, 
            BC07,   8, 
            BC08,   8, 
            Offset (0x9B), 
            BA01,   8, 
            BA02,   8, 
            BPR1,   8, 
            BPR2,   8, 
            BCR1,   8, 
            BCR2,   8, 
            BRC1,   8, 
            BRC2,   8, 
            BCC1,   8, 
            BCC2,   8, 
            BPV1,   8, 
            BPV2,   8, 
            BC01,   8, 
            BC02,   8, 
            BC03,   8, 
            BC04,   8, 
            BC05,   8, 
            BC06,   8, 
            Offset (0xAF), 
            BA03,   8, 
            BA04,   8, 
            Offset (0xB3), 
            MAX1,   8, 
            MAX2,   8, 
            Offset (0xB7), 
            BST1,   8, 
            BST2,   8, 
            Offset (0xC9), 
            BSN1,   8, 
            BSN2,   8, 
            BDA1,   8, 
            BDA2,   8, 
            Offset (0xDE), 
            CCB1,   8, 
            CCB2,   8, 
            CBT1,   8, 
            CBT2,   8, 
            Offset (0xF9), 
            ACP1,   8, 
            ACP2,   8
        }

        Method (GACW, 0, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                Local0 = Zero
                Acquire (ECMX, 0xFFFF)
                If (\_SB.PCI0.LPCB.EC0.ECRG)
                {
                    Local0 = B1B2 (ACP1, ACP2)
                }

                Release (ECMX)
                Return (Local0)
            }
            Else
            {
                Return (\_SB.PCI0.LPCB.EC0.XC12 ())
            }
        }

        Method (GBAW, 0, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                Local0 = Zero
                Acquire (ECMX, 0xFFFF)
                If (\_SB.PCI0.LPCB.EC0.ECRG)
                {
                    Local1 = B1B2 (BDV1, BDV2)
                    Local2 = B1B2 (BDC1, BDC2)
                    Local0 = (Local1 * Local2)
                    Divide (Local0, 0x000F4240, Local3, Local0)
                    If ((Local3 >= 0x0007A120))
                    {
                        Local0++
                    }
                }

                Release (ECMX)
                Return (Local0)
            }
            Else
            {
                Return (\_SB.PCI0.LPCB.EC0.XC13 ())
            }
        }

        Method (BTIF, 1, Serialized)
        {
            If (_OSI ("Darwin"))
            {
                Local7 = (One << Arg0)
                BTDR (One)
                If ((BSTA (Local7) == 0x0F))
                {
                    Return (0xFF)
                }

                Acquire (BTMX, 0xFFFF)
                Local0 = \_SB.PCI0.LPCB.EC0.NGBF /* External reference */
                Release (BTMX)
                If (((Local0 & Local7) == Zero))
                {
                    Return (Zero)
                }

                NBST [Arg0] = \_SB.NDBS /* External reference */
                Acquire (BTMX, 0xFFFF)
                NGBT |= Local7
                Release (BTMX)
                Acquire (ECMX, 0xFFFF)
                If (\_SB.PCI0.LPCB.EC0.ECRG)
                {
                    BSEL = Arg0
                    Local0 = B1B2 (BFC1, BFC2)
                    DerefOf (NBTI [Arg0]) [One] = Local0
                    DerefOf (NBTI [Arg0]) [0x02] = Local0
                    DerefOf (NBTI [Arg0]) [0x04] = B1B2 (BDV1, BDV2)
                    Local0 = (B1B2 (BFC1, BFC2) * NLB1) /* External reference */
                    Local4 = (Local0 / 0x64)
                    DerefOf (NBTI [Arg0]) [0x05] = Local4
                    Local0 = (B1B2 (BFC1, BFC2) * NLO2) /* External reference */
                    Local4 = (Local0 / 0x64)
                    DerefOf (NBTI [Arg0]) [0x06] = Local4
                    Local0 = B1B2 (BSN1, BSN2)
                    Local1 = B1B2 (BDA1, BDA2)
                }

                Release (ECMX)
                Local2 = GBSS (Local0, Local1)
                DerefOf (NBTI [Arg0]) [0x0A] = Local2
                Acquire (BTMX, 0xFFFF)
                NGBF &= ~Local7
                Release (BTMX)
                Return (Zero)
            }
            Else
            {
                Return (\_SB.PCI0.LPCB.EC0.XTIF (Arg0))
            }
        }

        Method (BTST, 2, Serialized)
        {
            If (_OSI ("Darwin"))
            {
                Local7 = (One << Arg0)
                BTDR (One)
                If ((BSTA (Local7) == 0x0F))
                {
                    NBST [Arg0] = Package (0x04)
                        {
                            Zero, 
                            0xFFFFFFFF, 
                            0xFFFFFFFF, 
                            0xFFFFFFFF
                        }
                    Return (0xFF)
                }

                Acquire (BTMX, 0xFFFF)
                If (Arg1)
                {
                    NGBT = 0xFF
                }

                Local0 = \_SB.PCI0.LPCB.EC0.NGBT /* External reference */
                Release (BTMX)
                If (((Local0 & Local7) == Zero))
                {
                    Return (Zero)
                }

                Acquire (ECMX, 0xFFFF)
                If (\_SB.PCI0.LPCB.EC0.ECRG)
                {
                    BSEL = Arg0
                    Local0 = \_SB.PCI0.LPCB.EC0.BST /* External reference */
                    Local3 = B1B2 (BPR1, BPR2)
                    DerefOf (NBST [Arg0]) [0x02] = B1B2 (BRC1, BRC2)
                    DerefOf (NBST [Arg0]) [0x03] = B1B2 (BPV1, BPV2)
                }

                Release (ECMX)
                If ((GACS () == One))
                {
                    Local0 &= 0xFFFFFFFFFFFFFFFE
                }
                Else
                {
                    Local0 &= 0xFFFFFFFFFFFFFFFD
                }

                If ((Local0 & One))
                {
                    Acquire (BTMX, 0xFFFF)
                    NDCB = Local7
                    Release (BTMX)
                }

                DerefOf (NBST [Arg0]) [Zero] = Local0
                If ((Local0 & One))
                {
                    If (((Local3 < 0x0190) || (Local3 > 0x1964)))
                    {
                        Local5 = DerefOf (DerefOf (NBST [Arg0]) [One])
                        If (((Local5 < 0x0190) || (Local5 > 0x1964)))
                        {
                            Local3 = 0x0D7A
                        }
                        Else
                        {
                            Local3 = Local5
                        }
                    }

                    Local3 = 0xFFFFFFFF
                }
                ElseIf (((Local0 & 0x02) == Zero))
                {
                    Local3 = Zero
                }

                DerefOf (NBST [Arg0]) [One] = Local3
                Acquire (BTMX, 0xFFFF)
                NGBT &= ~Local7
                Release (BTMX)
                Return (Zero)
            }
            Else
            {
                Return (\_SB.PCI0.LPCB.EC0.XTST (Arg0, Arg1))
            }
        }

        Method (ITLB, 0, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                Local0 = (B1B2 (BFC1, BFC2) * NLB1) /* External reference */
                Local4 = (Local0 / 0x64)
                Divide ((Local4 + 0x09), 0x0A, Local0, Local1)
                Local0 = (B1B2 (BFC1, BFC2) * NLB2) /* External reference */
                Local4 = (Local0 / 0x64)
                Divide ((Local4 + 0x09), 0x0A, Local0, Local2)
                If (\_SB.PCI0.LPCB.EC0.ECRG)
                {
                    LB1 = Local1
                    LB2 = Local2
                }
            }
            Else
            {
                \_SB.PCI0.LPCB.EC0.XITL ()
            }
        }

        Method (GBTI, 1, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                Debug = "Enter getbattinfo"
                Acquire (ECMX, 0xFFFF)
                If (\_SB.PCI0.LPCB.EC0.ECRG)
                {
                    If ((BATP & (One << Arg0)))
                    {
                        BSEL = Arg0
                        Local0 = Package (0x02)
                            {
                                Zero, 
                                Buffer (0x6B){}
                            }
                        DerefOf (Local0 [One]) [Zero] = B1B2 (BDC1, BDC2)
                        DerefOf (Local0 [One]) [One] = (B1B2 (BDC1, BDC2) >> 
                            0x08)
                        DerefOf (Local0 [One]) [0x02] = B1B2 (BFC1, BFC2)
                        DerefOf (Local0 [One]) [0x03] = (B1B2 (BFC1, BFC2) >> 
                            0x08)
                        DerefOf (Local0 [One]) [0x04] = B1B2 (BRC1, BRC2)
                        DerefOf (Local0 [One]) [0x05] = (B1B2 (BRC1, BRC2) >> 
                            0x08)
                        DerefOf (Local0 [One]) [0x06] = B1B2 (BME1, BME2)
                        DerefOf (Local0 [One]) [0x07] = (B1B2 (BME1, BME2) >> 
                            0x08)
                        DerefOf (Local0 [One]) [0x08] = B1B2 (BCC1, BCC2)
                        DerefOf (Local0 [One]) [0x09] = (B1B2 (BCC1, BCC2) >> 
                            0x08)
                        Local1 = B1B2 (CBT1, CBT2)
                        Local1 -= 0x0AAC
                        Divide (Local1, 0x0A, Local2, Local3)
                        DerefOf (Local0 [One]) [0x0A] = Local3
                        DerefOf (Local0 [One]) [0x0B] = (Local3 >> 0x08)
                        DerefOf (Local0 [One]) [0x0C] = B1B2 (BPV1, BPV2)
                        DerefOf (Local0 [One]) [0x0D] = (B1B2 (BPV1, BPV2) >> 
                            0x08)
                        Local1 = B1B2 (BPR1, BPR2)
                        If (Local1)
                        {
                            If ((B1B2 (BST1, BST2) & 0x40))
                            {
                                Local1 = (~Local1 + One)
                                Local1 &= 0xFFFF
                            }
                        }

                        DerefOf (Local0 [One]) [0x0E] = Local1
                        DerefOf (Local0 [One]) [0x0F] = (Local1 >> 0x08)
                        DerefOf (Local0 [One]) [0x10] = B1B2 (BDV1, BDV2)
                        DerefOf (Local0 [One]) [0x11] = (B1B2 (BDV1, BDV2) >> 
                            0x08)
                        DerefOf (Local0 [One]) [0x12] = B1B2 (BST1, BST2)
                        DerefOf (Local0 [One]) [0x13] = (B1B2 (BST1, BST2) >> 
                            0x08)
                        DerefOf (Local0 [One]) [0x14] = B1B2 (BC07, BC08)
                        DerefOf (Local0 [One]) [0x15] = (B1B2 (BC07, BC08) >> 
                            0x08)
                        DerefOf (Local0 [One]) [0x16] = B1B2 (BC01, BC02)
                        DerefOf (Local0 [One]) [0x17] = (B1B2 (BC01, BC02) >> 
                            0x08)
                        DerefOf (Local0 [One]) [0x18] = B1B2 (BC03, BC04)
                        DerefOf (Local0 [One]) [0x19] = (B1B2 (BC03, BC04) >> 
                            0x08)
                        DerefOf (Local0 [One]) [0x1A] = B1B2 (BC05, BC06)
                        DerefOf (Local0 [One]) [0x1B] = (B1B2 (BC05, BC06) >> 
                            0x08)
                        CreateField (DerefOf (Local0 [One]), 0xE0, 0x80, BTSN)
                        BTSN = GBSS (B1B2 (BSN1, BSN2), B1B2 (BDA1, BDA2))
                        Local1 = GBMF ()
                        Local2 = SizeOf (Local1)
                        CreateField (DerefOf (Local0 [One]), 0x0160, (Local2 * 0x08), BMAN)
                        BMAN = Local1
                        Local2 += 0x2C
                        CreateField (DerefOf (Local0 [One]), (Local2 * 0x08), 0x80, CLBL)
                        CLBL = GCTL (Zero)
                        Local2 += 0x11
                        CreateField (DerefOf (Local0 [One]), (Local2 * 0x08), 0x38, DNAM)
                        DNAM = GDNM (Zero)
                        Local2 += 0x07
                        CreateField (DerefOf (Local0 [One]), (Local2 * 0x08), 0x20, DCHE)
                        DCHE = GDCH (Zero)
                        Local2 += 0x04
                        CreateField (DerefOf (Local0 [One]), (Local2 * 0x08), 0x10, BMAC)
                        BMAC = Zero
                        Local2 += 0x02
                        CreateField (DerefOf (Local0 [One]), (Local2 * 0x08), 0x10, BMAD)
                        BMAD = B1B2 (BDA1, BDA2)
                        Local2 += 0x02
                        CreateField (DerefOf (Local0 [One]), (Local2 * 0x08), 0x10, BCCU)
                        BCCU = \_SB.PCI0.LPCB.EC0.BRCC /* External reference */
                        Local2 += 0x02
                        CreateField (DerefOf (Local0 [One]), (Local2 * 0x08), 0x10, BCVO)
                        BCVO = \_SB.PCI0.LPCB.EC0.BRCV /* External reference */
                        Local2 += 0x02
                        CreateField (DerefOf (Local0 [One]), (Local2 * 0x08), 0x10, BAVC)
                        Local1 = B1B2 (BCR1, BCR2)
                        If (Local1)
                        {
                            If ((B1B2 (BST1, BST2) & 0x40))
                            {
                                Local1 = (~Local1 + One)
                                Local1 &= 0xFFFF
                            }
                        }

                        BAVC = Local1
                        Local2 += 0x02
                        CreateField (DerefOf (Local0 [One]), (Local2 * 0x08), 0x10, RTTE)
                        RTTE = B1B2 (BRT1, BRT2)
                        Local2 += 0x02
                        CreateField (DerefOf (Local0 [One]), (Local2 * 0x08), 0x10, ATTE)
                        ATTE = B1B2 (BA01, BA02)
                        Local2 += 0x02
                        CreateField (DerefOf (Local0 [One]), (Local2 * 0x08), 0x10, ATTF)
                        ATTF = B1B2 (BA03, BA04)
                        Local2 += 0x02
                        CreateField (DerefOf (Local0 [One]), (Local2 * 0x08), 0x08, NOBS)
                        NOBS = \_SB.PCI0.LPCB.EC0.BATN /* External reference */
                    }
                    Else
                    {
                        Local0 = Package (0x01)
                            {
                                0x34
                            }
                    }
                }
                Else
                {
                    Local0 = Package (0x01)
                        {
                            0x0D
                        }
                }

                Release (ECMX)
                Return (Local0)
            }
            Else
            {
                Return (\_SB.PCI0.LPCB.EC0.XBTI (Arg0))
            }
        }

        Method (GBTC, 0, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                Debug = "Enter GetBatteryControl"
                Acquire (ECMX, 0xFFFF)
                If (\_SB.PCI0.LPCB.EC0.ECRG)
                {
                    Local0 = Package (0x02)
                        {
                            Zero, 
                            Buffer (0x04){}
                        }
                    If ((BATP & One))
                    {
                        BSEL = Zero
                        DerefOf (Local0 [One]) [Zero] = Zero
                        If ((((INAC == Zero) && (INCH == Zero)) && (IDIS == Zero)))
                        {
                            DerefOf (Local0 [One]) [Zero] = Zero
                        }
                        ElseIf (((((INAC == Zero) && (INCH == 0x02)) && (
                            IDIS == One)) && (B1B2 (MAX1, MAX2) == Zero)))
                        {
                            DerefOf (Local0 [One]) [Zero] = One
                        }
                        ElseIf (((INAC == One) && (IDIS == 0x02)))
                        {
                            DerefOf (Local0 [One]) [Zero] = 0x02
                        }
                        ElseIf (((((INAC == Zero) && (INCH == 0x02)) && (
                            IDIS == One)) && (B1B2 (MAX1, MAX2) == 0xFA)))
                        {
                            DerefOf (Local0 [One]) [Zero] = 0x03
                        }
                        ElseIf (((INAC == Zero) && (INCH == 0x03)))
                        {
                            DerefOf (Local0 [One]) [Zero] = 0x04
                        }
                    }
                    Else
                    {
                        DerefOf (Local0 [One]) [Zero] = 0xFF
                    }

                    If ((BATP & 0x02))
                    {
                        BSEL = One
                        DerefOf (Local0 [One]) [One] = Zero
                        If ((((INAC == Zero) && (INCH == Zero)) && (IDIS == Zero)))
                        {
                            DerefOf (Local0 [One]) [One] = Zero
                        }
                        ElseIf (((((INAC == Zero) && (INCH == One)) && (
                            IDIS == 0x02)) && (B1B2 (MAX1, MAX2) == Zero)))
                        {
                            DerefOf (Local0 [One]) [One] = One
                        }
                        ElseIf (((INAC == One) && (IDIS == One)))
                        {
                            DerefOf (Local0 [One]) [One] = 0x02
                        }
                        ElseIf (((((INAC == Zero) && (INCH == One)) && (
                            IDIS == 0x02)) && (B1B2 (MAX1, MAX2) == 0xFA)))
                        {
                            DerefOf (Local0 [One]) [One] = 0x03
                        }
                        ElseIf (((INAC == Zero) && (INCH == 0x03)))
                        {
                            DerefOf (Local0 [One]) [One] = 0x04
                        }
                    }
                    Else
                    {
                        DerefOf (Local0 [One]) [One] = 0xFF
                    }
                }
                Else
                {
                    Local0 = Package (0x02)
                        {
                            0x35, 
                            Zero
                        }
                }

                Release (ECMX)
                Return (Local0)
            }
            Else
            {
                Return (\_SB.PCI0.LPCB.EC0.XGBU ())
            }
        }

        Method (SBTC, 3, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                Debug = "Enter SetBatteryControl"
                Debug = Arg0
                Debug = Arg1
                Debug = Arg2
                Acquire (ECMX, 0xFFFF)
                If (\_SB.PCI0.LPCB.EC0.ECRG)
                {
                    Local0 = Arg2
                    Debug = Local0
                    Local4 = Package (0x01)
                        {
                            0x06
                        }
                    Local1 = Zero
                    Local2 = Zero
                    Local1 = DerefOf (Local0 [Zero])
                    If ((Local1 == Zero))
                    {
                        Debug = "battery 0"
                        If ((BATP & One))
                        {
                            Local2 = DerefOf (Local0 [One])
                            If ((Local2 == Zero))
                            {
                                INCH = Zero
                                IDIS = Zero
                                INAC = Zero
                                B1B2 (MAX1, MAX2) = Zero
                                PSSB = One
                                Local4 = Package (0x01)
                                    {
                                        Zero
                                    }
                            }

                            If ((Local2 == One))
                            {
                                INAC = Zero
                                INCH = 0x02
                                IDIS = One
                                B1B2 (MAX1, MAX2) = Zero
                                PSSB = Zero
                                Local4 = Package (0x01)
                                    {
                                        Zero
                                    }
                            }

                            If ((Local2 == 0x02))
                            {
                                INAC = One
                                INCH = One
                                IDIS = 0x02
                                PSSB = Zero
                                Local4 = Package (0x01)
                                    {
                                        Zero
                                    }
                            }

                            If ((Local2 == 0x03))
                            {
                                INCH = 0x02
                                IDIS = One
                                INAC = Zero
                                B1B2 (MAX1, MAX2) = 0xFA
                                PSSB = Zero
                                Local4 = Package (0x01)
                                    {
                                        Zero
                                    }
                            }

                            If ((Local2 == 0x04))
                            {
                                B1B2 (MAX1, MAX2) = 0xFA
                                Local4 = Package (0x01)
                                    {
                                        Zero
                                    }
                            }

                            If ((Local2 == 0x05))
                            {
                                INAC = Zero
                                INCH = 0x03
                                Local4 = Package (0x01)
                                    {
                                        Zero
                                    }
                            }
                        }
                        Else
                        {
                            Local4 = Package (0x01)
                                {
                                    0x34
                                }
                        }
                    }

                    If ((Local1 == One))
                    {
                        If ((BATP & 0x02))
                        {
                            Debug = "battery 1"
                            Local2 = DerefOf (Local0 [One])
                            If ((Local2 == Zero))
                            {
                                INCH = Zero
                                IDIS = Zero
                                INAC = Zero
                                B1B2 (MAX1, MAX2) = Zero
                                PSSB = One
                                Local4 = Package (0x01)
                                    {
                                        Zero
                                    }
                            }

                            If ((Local2 == One))
                            {
                                INAC = Zero
                                INCH = One
                                IDIS = 0x02
                                B1B2 (MAX1, MAX2) = Zero
                                PSSB = Zero
                                Local4 = Package (0x01)
                                    {
                                        Zero
                                    }
                            }

                            If ((Local2 == 0x02))
                            {
                                INAC = One
                                INCH = 0x02
                                IDIS = One
                                PSSB = Zero
                                Local4 = Package (0x01)
                                    {
                                        Zero
                                    }
                            }

                            If ((Local2 == 0x03))
                            {
                                INCH = One
                                IDIS = 0x02
                                INAC = Zero
                                B1B2 (MAX1, MAX2) = 0xFA
                                PSSB = Zero
                                Local4 = Package (0x01)
                                    {
                                        Zero
                                    }
                            }

                            If ((Local2 == 0x04))
                            {
                                INCH = Zero
                                IDIS = Zero
                                INAC = Zero
                                Local4 = Package (0x01)
                                    {
                                        Zero
                                    }
                            }

                            If ((Local2 == 0x05))
                            {
                                INAC = Zero
                                INCH = 0x03
                                Local4 = Package (0x01)
                                    {
                                        Zero
                                    }
                            }
                        }
                        Else
                        {
                            Local4 = Package (0x01)
                                {
                                    0x34
                                }
                        }
                    }
                }

                Release (ECMX)
                Return (Local4)
            }
            Else
            {
                Return (\_SB.PCI0.LPCB.EC0.XSBT (Arg0, Arg1, Arg2))
            }
        }
    }

    Scope (_TZ)
    {
        Method (GCGC, 0, Serialized)
        {
            If (_OSI ("Darwin"))
            {
                Name (LTMP, Buffer (0x02){})
                If (\_SB.PCI0.LPCB.EC0.ECRG)
                {
                    Acquire (\_SB.PCI0.LPCB.EC0.ECMX, 0xFFFF)
                    LTMP = B1B2 (\_SB.PCI0.LPCB.EC0.BPR1, \_SB.PCI0.LPCB.EC0.BPR2)
                    Release (\_SB.PCI0.LPCB.EC0.ECMX)
                }

                Return (LTMP) /* \_TZ_.GCGC.LTMP */
            }
            Else
            {
                Return (\_TZ.XGCG ())
            }
        }
    }
}



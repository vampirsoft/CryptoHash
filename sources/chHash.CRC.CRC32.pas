/////////////////////////////////////////////////////////////////////////////////
//*****************************************************************************//
//* Project      : CryptoHash                                                 *//
//* Latest Source: https://github.com/vampirsoft/CryptoHash                   *//
//* Unit Name    : CryptoHash.inc                                             *//
//* Author       : Сергей (LordVampir) Дворников                              *//
//* Based on     :                                                            *//
//*              - asm   : http://guildalfa.ru/alsha/node/2                   *//
//*              - delphi: https://create.stephan-brumme.com/crc32/           *//
//* Copyright 2019 LordVampir (https://github.com/vampirsoft)                 *//
//* Licensed under the Apache License, Version 2.0                            *//
//*****************************************************************************//
/////////////////////////////////////////////////////////////////////////////////

unit chHash.CRC.CRC32;

{$INCLUDE CryptoHash.inc}

interface

uses
  chHash, chHash.CRC;

type

{ TchCrc32Algorithm }

  TchCrc32Algorithm = class sealed(TchCrcAlgorithm<Cardinal>)
  strict private
    class function CreateCRC32: TchCrc32Algorithm; static;{$IF DEFINED(USE_INLINE)}inline;{$IFEND}
    class function CreateBZIP2: TchCrc32Algorithm; static;{$IF DEFINED(USE_INLINE)}inline;{$IFEND}
    class function CreateISCSI: TchCrc32Algorithm; static;{$IF DEFINED(USE_INLINE)}inline;{$IFEND}
    class function CreateBASE91D: TchCrc32Algorithm; static;{$IF DEFINED(USE_INLINE)}inline;{$IFEND}
    class function CreateMPEG2: TchCrc32Algorithm; static;{$IF DEFINED(USE_INLINE)}inline;{$IFEND}
    class function CreateCKSUM: TchCrc32Algorithm; static;{$IF DEFINED(USE_INLINE)}inline;{$IFEND}
    class function CreateAIXM: TchCrc32Algorithm; static;{$IF DEFINED(USE_INLINE)}inline;{$IFEND}
    class function CreateJAMCRC: TchCrc32Algorithm; static;{$IF DEFINED(USE_INLINE)}inline;{$IFEND}
    class function CreateXFER: TchCrc32Algorithm; static;{$IF DEFINED(USE_INLINE)}inline;{$IFEND}
    class function CreateAUTOSAR: TchCrc32Algorithm; static;{$IF DEFINED(USE_INLINE)}inline;{$IFEND}
  strict protected
    function ByteToBits(const Value: Byte): Cardinal; override;
    function BitsToByte(const Value: Cardinal): Byte; override;
    function LeftShift(const Value: Cardinal; const Bits: Byte): Cardinal; override;
    function RightShift(const Value: Cardinal; const Bits: Byte): Cardinal; override;
    function BitwiseXor(const Left, Right: Cardinal): Cardinal; override;
    function IsZero(const Value: Cardinal): Boolean; override;
  public
    class function Custom(const Polynomial, Init, XorOut, Check: Cardinal;
      const RefIn, RefOut: Boolean): TchCrc32Algorithm; static;{$IF DEFINED(USE_INLINE)}inline;{$IFEND}
    procedure Calculate(var Current: Cardinal; Data: Pointer; Length: Cardinal); override;
    class property CRC32: TchCrc32Algorithm read CreateCRC32;
    class property BZIP2: TchCrc32Algorithm read CreateBZIP2;
    class property ISCSI: TchCrc32Algorithm read CreateISCSI;
    class property BASE91D: TchCrc32Algorithm read CreateBASE91D;
    class property MPEG2: TchCrc32Algorithm read CreateMPEG2;
    class property CKSUM: TchCrc32Algorithm read CreateCKSUM;
    class property AIXM: TchCrc32Algorithm read CreateAIXM;
    class property JAMCRC: TchCrc32Algorithm read CreateJAMCRC;
    class property XFER: TchCrc32Algorithm read CreateXFER;
    class property AUTOSAR: TchCrc32Algorithm read CreateAUTOSAR;
  end;

implementation

uses
  System.SysUtils,
{$IF DEFINED(USE_JEDY_CORE_LIBRARY)}
  JclLogic;
{$ELSE ~ NOT USE_JEDY_CORE_LIBRARY}
  chHash.Core.Bits;
{$IFEND ~USE_JEDY_CORE_LIBRARY}

{ TchCrc32Algorithm }

class function TchCrc32Algorithm.Custom(const Polynomial, Init, XorOut, Check: Cardinal;
  const RefIn, RefOut: Boolean): TchCrc32Algorithm;
begin
  Result := TchCrc32Algorithm.Create('Custom', Polynomial, Init, XorOut, Check, RefIn, RefOut);
end;

function TchCrc32Algorithm.IsZero(const Value: Cardinal): Boolean;
begin
  Result := Value = 0;
end;

function TchCrc32Algorithm.BitsToByte(const Value: Cardinal): Byte;
begin
  Result := Value and {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}ByteMask{$ELSE}Byte.Mask{$IFEND};
end;

function TchCrc32Algorithm.LeftShift(const Value: Cardinal; const Bits: Byte): Cardinal;
begin
  Result := Value shl Bits;
end;

function TchCrc32Algorithm.RightShift(const Value: Cardinal; const Bits: Byte): Cardinal;
begin
  Result := Value shr Bits;
end;

class function TchCrc32Algorithm.CreateBASE91D: TchCrc32Algorithm;
begin
  Result := TchCrc32Algorithm.Create(
    'CRC-32/BASE91-D', $A833982B,
    {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}CardinalMask{$ELSE}Cardinal.Mask{$IFEND},
    {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}CardinalMask{$ELSE}Cardinal.Mask{$IFEND},
    $87315576, True, True
  );
  Result.FAliases.Add('CRC-32D');
end;

class function TchCrc32Algorithm.CreateBZIP2: TchCrc32Algorithm;
begin
  Result := TchCrc32Algorithm.Create(
    'CRC-32/BZIP2', $04C11DB7,
    {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}CardinalMask{$ELSE}Cardinal.Mask{$IFEND},
    {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}CardinalMask{$ELSE}Cardinal.Mask{$IFEND},
    $FC891918, False, False
  );
  Result.FAliases.Add('CRC-32/AAL5');
  Result.FAliases.Add('CRC-32/DECT-B');
  Result.FAliases.Add('B-CRC-32');
end;

class function TchCrc32Algorithm.CreateCKSUM: TchCrc32Algorithm;
begin
  Result := TchCrc32Algorithm.Create(
    'CRC-32/CKSUM', $04C11DB7, $00000000,
    {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}CardinalMask{$ELSE}Cardinal.Mask{$IFEND},
    $765E7680, False, False
  );
  Result.FAliases.Add('CKSUM');
  Result.FAliases.Add('CRC-32/POSIX');
end;

class function TchCrc32Algorithm.CreateCRC32: TchCrc32Algorithm;
begin
  Result := TchCrc32Algorithm.Create(
    'CRC-32', $04C11DB7,
    {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}CardinalMask{$ELSE}Cardinal.Mask{$IFEND},
    {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}CardinalMask{$ELSE}Cardinal.Mask{$IFEND},
    $CBF43926, True, True
  );
  Result.FAliases.Add('CRC-32/ISO-HDLC');
  Result.FAliases.Add('CRC-32/ADCCP');
  Result.FAliases.Add('CRC-32/V-42');
  Result.FAliases.Add('CRC-32/XZ');
  Result.FAliases.Add('PKZIP');
end;

class function TchCrc32Algorithm.CreateISCSI: TchCrc32Algorithm;
begin
  Result := TchCrc32Algorithm.Create(
    'CRC-32/ISCSI', $1EDC6F41,
    {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}CardinalMask{$ELSE}Cardinal.Mask{$IFEND},
    {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}CardinalMask{$ELSE}Cardinal.Mask{$IFEND},
    $E3069283, True, True
  );
  Result.FAliases.Add('CRC-32/BASE91-C');
  Result.FAliases.Add('CRC-32/CASTAGNOLI');
  Result.FAliases.Add('CRC-32/INTERLAKEN');
  Result.FAliases.Add('CRC-32C');
end;

class function TchCrc32Algorithm.CreateJAMCRC: TchCrc32Algorithm;
begin
  Result := TchCrc32Algorithm.Create(
    'CRC-32/JAMCRC', $04C11DB7,
    {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}CardinalMask{$ELSE}Cardinal.Mask{$IFEND},
    $00000000, $340BC6D9, True, True
  );
  Result.FAliases.Add('JAMCRC');
end;

class function TchCrc32Algorithm.CreateMPEG2: TchCrc32Algorithm;
begin
  Result := TchCrc32Algorithm.Create(
    'CRC-32/MPEG-2', $04C11DB7,
    {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}CardinalMask{$ELSE}Cardinal.Mask{$IFEND},
    $00000000, $0376E6E7, False, False
  );
end;

function TchCrc32Algorithm.BitwiseXor(const Left, Right: Cardinal): Cardinal;
begin
  Result := Left xor Right;
end;

function TchCrc32Algorithm.ByteToBits(const Value: Byte): Cardinal;
begin
  Result := Value;
end;

{$IF DEFINED(USE_ASSEMBLER)}
procedure TchCrc32Algorithm.Calculate(var Current: Cardinal; Data: Pointer; Length: Cardinal);
asm
{$IF DEFINED(CPUX64)}
  PUSH      RSI
  // Start
  // --> RCX    addres Self
  // --> RDX    address Current
  // --> R8     addres Data
  // --> R9     Length
  // <-- EBX -> [RDX]
  TEST      R8,         R8
  JZ        @Ret
  NEG       R9
  JGE       @Ret

@Init:
  MOV       RSI,        R8             // addresss Data -> RSI
  PUSH      RBP
  MOV       RBP,        RCX            // addresss Self -> RBP
  ADD       RBP,        $18            // offset to Self.FTable -> RBP
  PUSH      RCX
  MOV       RCX,        R9             // Length -> RCX
  PUSH      RBX
  MOV       EBX,        [RDX]          // Current -> EBX
  PUSH      RDX
  SUB       RSI,        RCX
{$ELSE ~CPUX86}
  PUSH      ESI
  // Start
  // --> EAX       address Self
  // --> EDX       address Current
  // --> ECX       address Data
  // --> ESP + $0C Length
  // <-- EBX    -> [EDX]
  TEST      ECX,        ECX
  JZ        @Ret
  MOV       ESI,        ECX            // addresss Data -> ESI
  MOV       ECX,        [ESP + $0C]    // Length -> ECX
  NEG       ECX
  JGE       @Ret

@Init:
  PUSH      EBP
  MOV       EBP,        EAX            // addresss Self -> EBP
  ADD       EBP,        $10            // offset to Self.FTable -> EBP
  PUSH      EAX
  PUSH      EBX
  MOV       EBX,        [EDX]          // Current -> EBX
  PUSH      EDX
  SUB       ESI,        ECX
{$IFEND ~CPUX64}
  // Initialized

{$IF DEFINED(CPUX64)}
  ADD       RCX,        8
{$ELSE ~CPUX86}
  ADD       ECX,        8
{$IFEND ~CPUX64}
  JG        @NoBody
{$IF DEFINED(CPUX64)}
  PUSH      RDI
{$ELSE}    // CPUX86
  PUSH      EDI
{$IFEND ~CPUX64}
  MOV       EDX,        EBX

@BodyNext:
{$IF DEFINED(CPUX64)}
  XOR       EDX,        [RSI + RCX - 8]
  MOV       EAX,        [RSI + RCX - 4]
{$ELSE ~CPUX86}
  XOR       EDX,        [ESI + ECX - 8]
  MOV       EAX,        [ESI + ECX - 4]
{$IFEND ~CPUX64}

  MOVZX     EDI,        AL
{$IF DEFINED(CPUX64)}
  MOV       EBX,        [RDI * 4 + RBP + $0C00]      // (255 * 4) * 3
{$ELSE ~CPUX86}
  MOV       EBX,        [EDI * 4 + EBP + $0C00]      // (255 * 4) * 3
{$IFEND ~CPUX64}
  MOVZX     EDI,        AH
{$IF DEFINED(CPUX64)}
  XOR       EBX,        [RDI * 4 + RBP + $0800]      // (255 * 4) * 2
{$ELSE ~CPUX86}
  XOR       EBX,        [EDI * 4 + EBP + $0800]      // (255 * 4) * 2
{$IFEND ~CPUX64}
  SHR       EAX,        16
  MOVZX     EDI,        AL
{$IF DEFINED(CPUX64)}
  XOR       EBX,        [RDI * 4 + RBP + $0400]      // (255 * 4) * 1
{$ELSE ~CPUX86}
  XOR       EBX,        [EDI * 4 + EBP + $0400]      // (255 * 4) * 1
{$IFEND ~CPUX64}
  MOVZX     EDI,        AH
{$IF DEFINED(CPUX64)}
  XOR       EBX,        [RDI * 4 + RBP]              // (255 * 4) * 0
{$ELSE ~CPUX86}
  XOR       EBX,        [EDI * 4 + EBP]              // (255 * 4) * 0
{$IFEND ~CPUX64}

  MOVZX     EDI,        DL
{$IF DEFINED(CPUX64)}
  XOR       EBX,        [RDI * 4 + RBP + $1C00]      // (255 * 4) * 7
{$ELSE ~CPUX86}
  XOR       EBX,        [EDI * 4 + EBP + $1C00]      // (255 * 4) * 7
{$IFEND ~CPUX64}
  MOVZX     EDI,        DH
{$IF DEFINED(CPUX64)}
  XOR       EBX,        [RDI * 4 + RBP + $1800]      // (255 * 4) * 6
{$ELSE ~CPUX86}
  XOR       EBX,        [EDI * 4 + EBP + $1800]      // (255 * 4) * 6
{$IFEND ~CPUX64}
  SHR       EDX,        16
  MOVZX     EDI,        DL
{$IF DEFINED(CPUX64)}
  XOR       EBX,        [RDI * 4 + RBP + $1400]      // (255 * 4) * 5
{$ELSE ~CPUX86}
  XOR       EBX,        [EDI * 4 + EBP + $1400]      // (255 * 4) * 5
{$IFEND ~CPUX64}
  MOVZX     EDI,        DH
{$IF DEFINED(CPUX64)}
  XOR       EBX,        [RDI * 4 + RBP + $1000]      // (255 * 4) * 4
{$ELSE ~CPUX86}
  XOR       EBX,        [EDI * 4 + EBP + $1000]      // (255 * 4) * 4
{$IFEND ~CPUX64}

{$IF DEFINED(CPUX64)}
  ADD       RCX,        8
{$ELSE ~CPUX86}
  ADD       ECX,        8
{$IFEND ~CPUX64}
  JG        @BodyDone

{$IF DEFINED(CPUX64)}
  XOR       EBX,        [RSI + RCX - 8]
  MOV       EAX,        [RSI + RCX - 4]
{$ELSE ~CPUX86}
  XOR       EBX,        [ESI + ECX - 8]
  MOV       EAX,        [ESI + ECX - 4]
{$IFEND ~CPUX64}

  MOVZX     EDI,        AL
{$IF DEFINED(CPUX64)}
  MOV       EDX,        [RDI * 4 + RBP + $0C00]      // (255 * 4) * 3
{$ELSE ~CPUX86}
  MOV       EDX,        [EDI * 4 + EBP + $0C00]      // (255 * 4) * 3
{$IFEND ~CPUX64}
  MOVZX     EDI,        AH
{$IF DEFINED(CPUX64)}
  XOR       EDX,        [RDI * 4 + RBP + $0800]      // (255 * 4) * 2
{$ELSE ~CPUX86}
  XOR       EDX,        [EDI * 4 + EBP + $0800]      // (255 * 4) * 2
{$IFEND ~CPUX64}
  SHR       EAX,        16
  MOVZX     EDI,        AL
{$IF DEFINED(CPUX64)}
  XOR       EDX,        [RDI * 4 + RBP + $0400]      // (255 * 4) * 1
{$ELSE ~CPUX86}
  XOR       EDX,        [EDI * 4 + EBP + $0400]      // (255 * 4) * 1
{$IFEND ~CPUX64}
  MOVZX     EDI,        AH
{$IF DEFINED(CPUX64)}
  XOR       EDX,        [RDI * 4 + RBP]              // (255 * 4) * 0
{$ELSE ~CPUX86}
  XOR       EDX,        [EDI * 4 + EBP]              // (255 * 4) * 0
{$IFEND ~CPUX64}

  MOVZX     EDI,        BL
{$IF DEFINED(CPUX64)}
  XOR       EDX,        [RDI * 4 + RBP + $1C00]      // (255 * 4) * 7
{$ELSE ~CPUX86}
  XOR       EDX,        [EDI * 4 + EBP + $1C00]      // (255 * 4) * 7
{$IFEND ~CPUX64}
  MOVZX     EDI,        BH
{$IF DEFINED(CPUX64)}
  XOR       EDX,        [RDI * 4 + RBP + $1800]      // (255 * 4) * 6
{$ELSE ~CPUX86}
  XOR       EDX,        [EDI * 4 + EBP + $1800]      // (255 * 4) * 6
{$IFEND ~CPUX64}
  SHR       EBX,        16
  MOVZX     EDI,        BL
{$IF DEFINED(CPUX64)}
  XOR       EDX,        [RDI * 4 + RBP + $1400]      // (255 * 4) * 5
{$ELSE ~CPUX86}
  XOR       EDX,        [EDI * 4 + EBP + $1400]      // (255 * 4) * 5
{$IFEND ~CPUX64}
  MOVZX     EDI,        BH
{$IF DEFINED(CPUX64)}
  XOR       EDX,        [RDI * 4 + RBP + $1000]      // (255 * 4) * 4
{$ELSE ~CPUX86}
  XOR       EDX,        [EDI * 4 + EBP + $1000]      // (255 * 4) * 4
{$IFEND ~CPUX64}

{$IF DEFINED(CPUX64)}
  ADD       RCX,        8
{$ELSE ~CPUX86}
  ADD       ECX,        8
{$IFEND ~CPUX64}
  JLE       @BodyNext
  MOV       EBX,        EDX

@BodyDone:
{$IF DEFINED(CPUX64)}
  POP       RDI
{$ELSE ~CPUX86}
  POP       EDI
{$IFEND ~CPUX64}

@NoBody:
{$IF DEFINED(CPUX64)}
  SUB       RCX,        8
{$ELSE ~CPUX86}
  SUB       ECX,        8
{$IFEND ~CPUX64}
  JGE       @Done

@Tail:
{$IF DEFINED(CPUX64)}
  MOVZX     EAX,        [RSI + RCX]
{$ELSE ~CPUX86}
  MOVZX     EAX,        [ESI + ECX]
{$IFEND ~CPUX64}
  XOR       AL,          BL
  SHR       EBX,        8
{$IF DEFINED(CPUX64)}
  XOR       EBX,        [RAX * 4 + RBP]
{$ELSE ~CPUX86}
  XOR       EBX,        [EAX * 4 + EBP]
{$IFEND ~CPUX64}
{$IF DEFINED(CPUX64)}
  INC       RCX
{$ELSE ~CPUX86}
  INC       ECX
{$IFEND ~CPUX64}
  JNZ       @Tail

@Done:
{$IF DEFINED(CPUX64)}
  POP       RDX
  MOV       [RDX],      EBX            // Result -> Current
  POP       RBX
  POP       RCX
  POP       RBP
{$ELSE ~CPUX86}
  POP       EDX
  MOV       [EDX],      EBX            // Result -> Current
  POP       EBX
  POP       EAX
  POP       EBP
{$IFEND ~CPUX64}
@Ret:
  // Finish
{$IF DEFINED(CPUX64)}
  POP       RSI
{$ELSE ~CPUX86}
  POP       ESI
{$IFEND ~NOT CPUX64}
end;
{$ELSE ~USE_FORCE_DELPHI}
procedure TchCrc32Algorithm.Calculate(var Current: Cardinal; Data: Pointer; Length: Cardinal);
begin
  if Length = 0 then Exit;

  var PData: PByte := Data;
  const Unroll: Byte = 4;

  var BytesAtOnce: Byte := Unroll * TABLE_LEVEL_SIZE;
  while Length >= BytesAtOnce do
  begin
    for var I: Byte := 1 to Unroll do
    begin
      var One, Two, Three, Four: Cardinal;
      Move( PData^,        One,   $04);
      Move((PData + $04)^, Two,   $04);
      Move((PData + $08)^, Three, $04);
      Move((PData + $0C)^, Four,  $04);
      One := One xor Current;

      Current :=
        FCrcTable[ 1, (Four shr $18)  and {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}ByteMask{$ELSE}Byte.Mask{$IFEND}] xor
        FCrcTable[ 2, (Four shr $10)  and {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}ByteMask{$ELSE}Byte.Mask{$IFEND}] xor
        FCrcTable[ 3, (Four shr $08)  and {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}ByteMask{$ELSE}Byte.Mask{$IFEND}] xor
        FCrcTable[ 4,  Four           and {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}ByteMask{$ELSE}Byte.Mask{$IFEND}] xor

        FCrcTable[ 5, (Three shr $18) and {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}ByteMask{$ELSE}Byte.Mask{$IFEND}] xor
        FCrcTable[ 6, (Three shr $10) and {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}ByteMask{$ELSE}Byte.Mask{$IFEND}] xor
        FCrcTable[ 7, (Three shr $08) and {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}ByteMask{$ELSE}Byte.Mask{$IFEND}] xor
        FCrcTable[ 8,  Three          and {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}ByteMask{$ELSE}Byte.Mask{$IFEND}] xor

        FCrcTable[ 9, (Two   shr $18) and {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}ByteMask{$ELSE}Byte.Mask{$IFEND}] xor
        FCrcTable[10, (Two   shr $10) and {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}ByteMask{$ELSE}Byte.Mask{$IFEND}] xor
        FCrcTable[11, (Two   shr $08) and {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}ByteMask{$ELSE}Byte.Mask{$IFEND}] xor
        FCrcTable[12,  Two            and {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}ByteMask{$ELSE}Byte.Mask{$IFEND}] xor

        FCrcTable[13, (One   shr $18) and {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}ByteMask{$ELSE}Byte.Mask{$IFEND}] xor
        FCrcTable[14, (One   shr $10) and {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}ByteMask{$ELSE}Byte.Mask{$IFEND}] xor
        FCrcTable[15, (One   shr $08) and {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}ByteMask{$ELSE}Byte.Mask{$IFEND}] xor
        FCrcTable[16,  One            and {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}ByteMask{$ELSE}Byte.Mask{$IFEND}];

      Inc(PData, BytesAtOnce div Unroll);
    end;
    Dec(Length, BytesAtOnce);
  end;

  BytesAtOnce := BytesAtOnce div 2;
  while Length >= BytesAtOnce do
  begin
    for var I: Byte := 1 to Unroll do
    begin
      var One, Two: Cardinal;
      Move( PData^,        One, $04);
      Move((PData + $04)^, Two, $04);
      One := One xor Current;

      Current :=
        FCrcTable[ 1, (Two shr $18) and {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}ByteMask{$ELSE}Byte.Mask{$IFEND}] xor
        FCrcTable[ 2, (Two shr $10) and {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}ByteMask{$ELSE}Byte.Mask{$IFEND}] xor
        FCrcTable[ 3, (Two shr $08) and {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}ByteMask{$ELSE}Byte.Mask{$IFEND}] xor
        FCrcTable[ 4,  Two          and {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}ByteMask{$ELSE}Byte.Mask{$IFEND}] xor

        FCrcTable[ 5, (One shr $18) and {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}ByteMask{$ELSE}Byte.Mask{$IFEND}] xor
        FCrcTable[ 6, (One shr $10) and {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}ByteMask{$ELSE}Byte.Mask{$IFEND}] xor
        FCrcTable[ 7, (One shr $08) and {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}ByteMask{$ELSE}Byte.Mask{$IFEND}] xor
        FCrcTable[ 8,  One          and {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}ByteMask{$ELSE}Byte.Mask{$IFEND}];

      Inc(PData, BytesAtOnce div Unroll);
    end;
    Dec(Length, BytesAtOnce);
  end;

  BytesAtOnce := BytesAtOnce div 4;
  while Length >= BytesAtOnce do
  begin
  var One, Two: Cardinal;
    Move( PData^,         One, $04);
    Move((PData + $04)^,  Two, $04);
    One := One xor Current;

    Current :=
      FCrcTable[ 1, (Two shr $18) and {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}ByteMask{$ELSE}Byte.Mask{$IFEND}] xor
      FCrcTable[ 2, (Two shr $10) and {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}ByteMask{$ELSE}Byte.Mask{$IFEND}] xor
      FCrcTable[ 3, (Two shr $08) and {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}ByteMask{$ELSE}Byte.Mask{$IFEND}] xor
      FCrcTable[ 4,  Two          and {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}ByteMask{$ELSE}Byte.Mask{$IFEND}] xor

      FCrcTable[ 5, (One shr $18) and {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}ByteMask{$ELSE}Byte.Mask{$IFEND}] xor
      FCrcTable[ 6, (One shr $10) and {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}ByteMask{$ELSE}Byte.Mask{$IFEND}] xor
      FCrcTable[ 7, (One shr $08) and {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}ByteMask{$ELSE}Byte.Mask{$IFEND}] xor
      FCrcTable[ 8,  One          and {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}ByteMask{$ELSE}Byte.Mask{$IFEND}];

    Inc(PData, BytesAtOnce);
    Dec(Length, BytesAtOnce);
  end;

  while Length > 0 do
  begin
    Current := (Current shr {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}BitsPerByte{$ELSE}Byte.Bits{$IFEND})
      xor FCrcTable[1, (PData^ xor Current) and {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}ByteMask{$ELSE}Byte.Mask{$IFEND}];
    Inc(PData);
    Dec(Length);
  end;
end;
{$IFEND ~USE_ASSEMBLER}

class function TchCrc32Algorithm.CreateAIXM: TchCrc32Algorithm;
begin
  Result := TchCrc32Algorithm.Create('CRC-32/AIXM', $814141AB, $00000000, $00000000, $3010BF7F, False, False);
  Result.FAliases.Add('CRC-32Q');
end;

class function TchCrc32Algorithm.CreateAUTOSAR: TchCrc32Algorithm;
begin
  Result := TchCrc32Algorithm.Create(
    'CRC-32/AUTOSAR', $F4ACFB13,
    {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}CardinalMask{$ELSE}Cardinal.Mask{$IFEND},
    {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}CardinalMask{$ELSE}Cardinal.Mask{$IFEND},
    $1697D06A, True, True
  );
end;

class function TchCrc32Algorithm.CreateXFER: TchCrc32Algorithm;
begin
  Result := TchCrc32Algorithm.Create('CRC-32/XFER', $000000AF, $00000000, $00000000, $BD0BE338, False, False);
  Result.FAliases.Add('XFER');
end;

end.

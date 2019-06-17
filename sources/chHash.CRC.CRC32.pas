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
    class function CreateCRC32: TchCrc32Algorithm; static;{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}
    class function CreateBZIP2: TchCrc32Algorithm; static;{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}
    class function CreateISCSI: TchCrc32Algorithm; static;{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}
    class function CreateBASE91D: TchCrc32Algorithm; static;{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}
    class function CreateMPEG2: TchCrc32Algorithm; static;{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}
    class function CreateCKSUM: TchCrc32Algorithm; static;{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}
    class function CreateAIXM: TchCrc32Algorithm; static;{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}
    class function CreateJAMCRC: TchCrc32Algorithm; static;{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}
    class function CreateXFER: TchCrc32Algorithm; static;{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}
    class function CreateAUTOSAR: TchCrc32Algorithm; static;{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}
  strict protected
    function ByteToBits(const Value: Byte): Cardinal; override;
    function BitsToByte(const Value: Cardinal): Byte; override;
    function LeftShift(const Value: Cardinal; const Bits: Byte): Cardinal; override;
    function RightShift(const Value: Cardinal; const Bits: Byte): Cardinal; override;
    function BitwiseXor(const Left, Right: Cardinal): Cardinal; override;
    function IsZero(const Value: Cardinal): Boolean; override;
  public
    class function Custom(const Polynomial, Init, XorOut, Check: Cardinal;
      const RefIn, RefOut: Boolean): TchCrc32Algorithm; static;{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}
    procedure Calculate(var Current: Cardinal; const Data: Pointer; const Length: Cardinal); override;
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
{$IF DEFINED(USE_JEDI_CORE_LIBRARY)}
  JclLogic;
{$ELSE ~ NOT USE_JEDI_CORE_LIBRARY}
  chHash.Core.Bits;
{$ENDIF ~ USE_JEDI_CORE_LIBRARY}

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
  Result := Byte(Value);
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
  Result := TchCrc32Algorithm.Create('CRC-32/BASE91-D', $A833982B, CardinalMask, CardinalMask, $87315576, True, True);
  Result.FAliases.Add('CRC-32D');
end;

class function TchCrc32Algorithm.CreateBZIP2: TchCrc32Algorithm;
begin
  Result := TchCrc32Algorithm.Create('CRC-32/BZIP2', $04C11DB7, CardinalMask, CardinalMask, $FC891918, False, False);
  Result.FAliases.Add('CRC-32/AAL5');
  Result.FAliases.Add('CRC-32/DECT-B');
  Result.FAliases.Add('B-CRC-32');
end;

class function TchCrc32Algorithm.CreateCKSUM: TchCrc32Algorithm;
begin
  Result := TchCrc32Algorithm.Create('CRC-32/CKSUM', $04C11DB7, $00000000, CardinalMask, $765E7680, False, False);
  Result.FAliases.Add('CKSUM');
  Result.FAliases.Add('CRC-32/POSIX');
end;

class function TchCrc32Algorithm.CreateCRC32: TchCrc32Algorithm;
begin
  Result := TchCrc32Algorithm.Create('CRC-32', $04C11DB7, CardinalMask, CardinalMask, $CBF43926, True, True);
  Result.FAliases.Add('CRC-32/ISO-HDLC');
  Result.FAliases.Add('CRC-32/ADCCP');
  Result.FAliases.Add('CRC-32/V-42');
  Result.FAliases.Add('CRC-32/XZ');
  Result.FAliases.Add('PKZIP');
end;

class function TchCrc32Algorithm.CreateISCSI: TchCrc32Algorithm;
begin
  Result := TchCrc32Algorithm.Create('CRC-32/ISCSI', $1EDC6F41, CardinalMask, CardinalMask, $E3069283, True, True);
  Result.FAliases.Add('CRC-32/BASE91-C');
  Result.FAliases.Add('CRC-32/CASTAGNOLI');
  Result.FAliases.Add('CRC-32/INTERLAKEN');
  Result.FAliases.Add('CRC-32C');
end;

class function TchCrc32Algorithm.CreateJAMCRC: TchCrc32Algorithm;
begin
  Result := TchCrc32Algorithm.Create('CRC-32/JAMCRC', $04C11DB7, CardinalMask, $00000000, $340BC6D9, True, True);
  Result.FAliases.Add('JAMCRC');
end;

class function TchCrc32Algorithm.CreateMPEG2: TchCrc32Algorithm;
begin
  Result := TchCrc32Algorithm.Create('CRC-32/MPEG-2', $04C11DB7, CardinalMask, $00000000, $0376E6E7, False, False);
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
procedure TchCrc32Algorithm.Calculate(var Current: Cardinal; const Data: Pointer; const Length: Cardinal);
asm
{$IF DEFINED(CPUX64)}
  PUSH      RSI
  // Start
  // --> RCX    addres Self
  //     RDX    address Current
  //     R8     addres Data
  //     R9     Length
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
{$ELSE ~ CPUX86}
  PUSH      ESI
  // Start
  // --> EAX       address Self
  //     EDX       address Current
  //     ECX       address Data
  //     on stack  Length
  // <-- EBX    -> [EDX]
  TEST      ECX,        ECX
  JZ        @Ret
  MOV       ESI,        ECX            // addresss Data -> ESI
  MOV       ECX, DWORD PTR [Length]    // Length -> ECX
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
{$ENDIF ~ CPUX64}
  // Initialized

{$IF DEFINED(CPUX64)}
  ADD       RCX,        8
{$ELSE ~ CPUX86}
  ADD       ECX,        8
{$ENDIF ~ CPUX64}
  JG        @NoBody
{$IF DEFINED(CPUX64)}
  PUSH      RDI
{$ELSE ~ CPUX86}
  PUSH      EDI
{$ENDIF ~ CPUX64}
  MOV       EDX,        EBX

@BodyNext:
{$IF DEFINED(CPUX64)}
  XOR       EDX,        [RSI + RCX - 8]
  MOV       EAX,        [RSI + RCX - 4]
{$ELSE ~ CPUX86}
  XOR       EDX,        [ESI + ECX - 8]
  MOV       EAX,        [ESI + ECX - 4]
{$ENDIF ~ CPUX64}

  MOVZX     EDI,        AL
{$IF DEFINED(CPUX64)}
  MOV       EBX,        [RDI * 4 + RBP + $0C00]      // (255 * 4) * 3
{$ELSE ~ CPUX86}
  MOV       EBX,        [EDI * 4 + EBP + $0C00]      // (255 * 4) * 3
{$ENDIF ~ CPUX64}
  MOVZX     EDI,        AH
{$IF DEFINED(CPUX64)}
  XOR       EBX,        [RDI * 4 + RBP + $0800]      // (255 * 4) * 2
{$ELSE ~ CPUX86}
  XOR       EBX,        [EDI * 4 + EBP + $0800]      // (255 * 4) * 2
{$ENDIF ~ CPUX64}
  SHR       EAX,        16
  MOVZX     EDI,        AL
{$IF DEFINED(CPUX64)}
  XOR       EBX,        [RDI * 4 + RBP + $0400]      // (255 * 4) * 1
{$ELSE ~ CPUX86}
  XOR       EBX,        [EDI * 4 + EBP + $0400]      // (255 * 4) * 1
{$ENDIF ~ CPUX64}
  MOVZX     EDI,        AH
{$IF DEFINED(CPUX64)}
  XOR       EBX,        [RDI * 4 + RBP]              // (255 * 4) * 0
{$ELSE ~ CPUX86}
  XOR       EBX,        [EDI * 4 + EBP]              // (255 * 4) * 0
{$ENDIF ~ CPUX64}

  MOVZX     EDI,        DL
{$IF DEFINED(CPUX64)}
  XOR       EBX,        [RDI * 4 + RBP + $1C00]      // (255 * 4) * 7
{$ELSE ~ CPUX86}
  XOR       EBX,        [EDI * 4 + EBP + $1C00]      // (255 * 4) * 7
{$ENDIF ~ CPUX64}
  MOVZX     EDI,        DH
{$IF DEFINED(CPUX64)}
  XOR       EBX,        [RDI * 4 + RBP + $1800]      // (255 * 4) * 6
{$ELSE ~ CPUX86}
  XOR       EBX,        [EDI * 4 + EBP + $1800]      // (255 * 4) * 6
{$ENDIF ~ CPUX64}
  SHR       EDX,        16
  MOVZX     EDI,        DL
{$IF DEFINED(CPUX64)}
  XOR       EBX,        [RDI * 4 + RBP + $1400]      // (255 * 4) * 5
{$ELSE ~ CPUX86}
  XOR       EBX,        [EDI * 4 + EBP + $1400]      // (255 * 4) * 5
{$ENDIF ~ CPUX64}
  MOVZX     EDI,        DH
{$IF DEFINED(CPUX64)}
  XOR       EBX,        [RDI * 4 + RBP + $1000]      // (255 * 4) * 4
{$ELSE ~ CPUX86}
  XOR       EBX,        [EDI * 4 + EBP + $1000]      // (255 * 4) * 4
{$ENDIF ~ CPUX64}

{$IF DEFINED(CPUX64)}
  ADD       RCX,        8
{$ELSE ~ CPUX86}
  ADD       ECX,        8
{$ENDIF ~ CPUX64}
  JG        @BodyDone

{$IF DEFINED(CPUX64)}
  XOR       EBX,        [RSI + RCX - 8]
  MOV       EAX,        [RSI + RCX - 4]
{$ELSE ~ CPUX86}
  XOR       EBX,        [ESI + ECX - 8]
  MOV       EAX,        [ESI + ECX - 4]
{$ENDIF ~ CPUX64}

  MOVZX     EDI,        AL
{$IF DEFINED(CPUX64)}
  MOV       EDX,        [RDI * 4 + RBP + $0C00]      // (255 * 4) * 3
{$ELSE ~ CPUX86}
  MOV       EDX,        [EDI * 4 + EBP + $0C00]      // (255 * 4) * 3
{$ENDIF ~ CPUX64}
  MOVZX     EDI,        AH
{$IF DEFINED(CPUX64)}
  XOR       EDX,        [RDI * 4 + RBP + $0800]      // (255 * 4) * 2
{$ELSE ~ CPUX86}
  XOR       EDX,        [EDI * 4 + EBP + $0800]      // (255 * 4) * 2
{$ENDIF ~ CPUX64}
  SHR       EAX,        16
  MOVZX     EDI,        AL
{$IF DEFINED(CPUX64)}
  XOR       EDX,        [RDI * 4 + RBP + $0400]      // (255 * 4) * 1
{$ELSE ~ CPUX86}
  XOR       EDX,        [EDI * 4 + EBP + $0400]      // (255 * 4) * 1
{$ENDIF ~ CPUX64}
  MOVZX     EDI,        AH
{$IF DEFINED(CPUX64)}
  XOR       EDX,        [RDI * 4 + RBP]              // (255 * 4) * 0
{$ELSE ~ CPUX86}
  XOR       EDX,        [EDI * 4 + EBP]              // (255 * 4) * 0
{$ENDIF ~ CPUX64}

  MOVZX     EDI,        BL
{$IF DEFINED(CPUX64)}
  XOR       EDX,        [RDI * 4 + RBP + $1C00]      // (255 * 4) * 7
{$ELSE ~ CPUX86}
  XOR       EDX,        [EDI * 4 + EBP + $1C00]      // (255 * 4) * 7
{$ENDIF ~ CPUX64}
  MOVZX     EDI,        BH
{$IF DEFINED(CPUX64)}
  XOR       EDX,        [RDI * 4 + RBP + $1800]      // (255 * 4) * 6
{$ELSE ~ CPUX86}
  XOR       EDX,        [EDI * 4 + EBP + $1800]      // (255 * 4) * 6
{$ENDIF ~ CPUX64}
  SHR       EBX,        16
  MOVZX     EDI,        BL
{$IF DEFINED(CPUX64)}
  XOR       EDX,        [RDI * 4 + RBP + $1400]      // (255 * 4) * 5
{$ELSE ~ CPUX86}
  XOR       EDX,        [EDI * 4 + EBP + $1400]      // (255 * 4) * 5
{$ENDIF ~ CPUX64}
  MOVZX     EDI,        BH
{$IF DEFINED(CPUX64)}
  XOR       EDX,        [RDI * 4 + RBP + $1000]      // (255 * 4) * 4
{$ELSE ~ CPUX86}
  XOR       EDX,        [EDI * 4 + EBP + $1000]      // (255 * 4) * 4
{$ENDIF ~ CPUX64}

{$IF DEFINED(CPUX64)}
  ADD       RCX,        8
{$ELSE ~ CPUX86}
  ADD       ECX,        8
{$ENDIF ~ CPUX64}
  JLE       @BodyNext
  MOV       EBX,        EDX

@BodyDone:
{$IF DEFINED(CPUX64)}
  POP       RDI
{$ELSE ~ CPUX86}
  POP       EDI
{$ENDIF ~ CPUX64}

@NoBody:
{$IF DEFINED(CPUX64)}
  SUB       RCX,        8
{$ELSE ~ CPUX86}
  SUB       ECX,        8
{$ENDIF ~ CPUX64}
  JGE       @Done

@Tail:
{$IF DEFINED(CPUX64)}
  MOVZX     EAX,        [RSI + RCX]
{$ELSE ~ CPUX86}
  MOVZX     EAX,        [ESI + ECX]
{$ENDIF ~ CPUX64}
  XOR       AL,          BL
  SHR       EBX,        8
{$IF DEFINED(CPUX64)}
  XOR       EBX,        [RAX * 4 + RBP]
{$ELSE ~ CPUX86}
  XOR       EBX,        [EAX * 4 + EBP]
{$ENDIF ~ CPUX64}
{$IF DEFINED(CPUX64)}
  INC       RCX
{$ELSE ~ CPUX86}
  INC       ECX
{$ENDIF ~ CPUX64}
  JNZ       @Tail

@Done:
{$IF DEFINED(CPUX64)}
  POP       RDX
  MOV       [RDX],      EBX            // Result -> Current
  POP       RBX
  POP       RCX
  POP       RBP
{$ELSE ~ CPUX86}
  POP       EDX
  MOV       [EDX],      EBX            // Result -> Current
  POP       EBX
  POP       EAX
  POP       EBP
{$ENDIF ~ CPUX64}
@Ret:
  // Finish
{$IF DEFINED(CPUX64)}
  POP       RSI
{$ELSE ~ CPUX86}
  POP       ESI
{$ENDIF ~ CPUX64}
end;
{$ELSE ~ USE_FORCE_DELPHI}
procedure TchCrc32Algorithm.Calculate(var Current: Cardinal; const Data: Pointer; const Length: Cardinal);
begin
  if Length = 0 then Exit;

  var PData: PByte := Data;
  var L: Cardinal := Length;
  const Unroll: Byte = 4;

  var BytesAtOnce: Byte := Unroll * TABLE_LEVEL_SIZE;
  while L >= BytesAtOnce do
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
        FCrcTable[ 1, Byte(Four shr (BitsPerByte * 3))]  xor
        FCrcTable[ 2, Byte(Four shr (BitsPerByte * 2))]  xor
        FCrcTable[ 3, Byte(Four shr  BitsPerByte)]       xor
        FCrcTable[ 4, Byte(Four)]                        xor

        FCrcTable[ 5, Byte(Three shr (BitsPerByte * 3))] xor
        FCrcTable[ 6, Byte(Three shr (BitsPerByte * 2))] xor
        FCrcTable[ 7, Byte(Three shr  BitsPerByte)]      xor
        FCrcTable[ 8, Byte(Three)]                       xor

        FCrcTable[ 9, Byte(Two   shr (BitsPerByte * 3))] xor
        FCrcTable[10, Byte(Two   shr (BitsPerByte * 2))] xor
        FCrcTable[11, Byte(Two   shr  BitsPerByte)]      xor
        FCrcTable[12, Byte(Two)]                         xor

        FCrcTable[13, Byte(One   shr (BitsPerByte * 3))] xor
        FCrcTable[14, Byte(One   shr (BitsPerByte * 2))] xor
        FCrcTable[15, Byte(One   shr  BitsPerByte)]      xor
        FCrcTable[16, Byte(One)];

      Inc(PData, BytesAtOnce div Unroll);
    end;
    Dec(L, BytesAtOnce);
  end;

  BytesAtOnce := BytesAtOnce div 2;
  while L >= BytesAtOnce do
  begin
    for var I: Byte := 1 to Unroll do
    begin
      var One, Two: Cardinal;
      Move( PData^,        One, $04);
      Move((PData + $04)^, Two, $04);
      One := One xor Current;

      Current :=
        FCrcTable[ 1, Byte(Two shr (BitsPerByte * 3))] xor
        FCrcTable[ 2, Byte(Two shr (BitsPerByte * 2))] xor
        FCrcTable[ 3, Byte(Two shr  BitsPerByte)]      xor
        FCrcTable[ 4, Byte(Two)]                       xor

        FCrcTable[ 5, Byte(One shr (BitsPerByte * 3))] xor
        FCrcTable[ 6, Byte(One shr (BitsPerByte * 2))] xor
        FCrcTable[ 7, Byte(One shr  BitsPerByte)]      xor
        FCrcTable[ 8, Byte(One)];

      Inc(PData, BytesAtOnce div Unroll);
    end;
    Dec(L, BytesAtOnce);
  end;

  BytesAtOnce := BytesAtOnce div 4;
  while L >= BytesAtOnce do
  begin
  var One, Two: Cardinal;
    Move( PData^,         One, $04);
    Move((PData + $04)^,  Two, $04);
    One := One xor Current;

    Current :=
      FCrcTable[ 1, Byte(Two shr (BitsPerByte * 3))] xor
      FCrcTable[ 2, Byte(Two shr (BitsPerByte * 2))] xor
      FCrcTable[ 3, Byte(Two shr  BitsPerByte)]      xor
      FCrcTable[ 4, Byte(Two)]                       xor

      FCrcTable[ 5, Byte(One shr (BitsPerByte * 3))] xor
      FCrcTable[ 6, Byte(One shr (BitsPerByte * 2))] xor
      FCrcTable[ 7, Byte(One shr  BitsPerByte)]      xor
      FCrcTable[ 8, Byte(One)];

    Inc(PData, BytesAtOnce);
    Dec(L, BytesAtOnce);
  end;

  while L > 0 do
  begin
    Current := (Current shr BitsPerByte) xor FCrcTable[1, Byte((PData^ xor Current))];
    Inc(PData);
    Dec(L);
  end;
end;
{$ENDIF ~ USE_ASSEMBLER}

class function TchCrc32Algorithm.CreateAIXM: TchCrc32Algorithm;
begin
  Result := TchCrc32Algorithm.Create('CRC-32/AIXM', $814141AB, $00000000, $00000000, $3010BF7F, False, False);
  Result.FAliases.Add('CRC-32Q');
end;

class function TchCrc32Algorithm.CreateAUTOSAR: TchCrc32Algorithm;
begin
  Result := TchCrc32Algorithm.Create('CRC-32/AUTOSAR', $F4ACFB13, CardinalMask, CardinalMask, $1697D06A, True, True);
end;

class function TchCrc32Algorithm.CreateXFER: TchCrc32Algorithm;
begin
  Result := TchCrc32Algorithm.Create('CRC-32/XFER', $000000AF, $00000000, $00000000, $BD0BE338, False, False);
  Result.FAliases.Add('XFER');
end;

end.

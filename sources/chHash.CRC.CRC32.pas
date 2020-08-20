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

function TchCrc32Algorithm.IsZero(const Value: Cardinal): Boolean;
{$IF DEFINED(USE_ASSEMBLER)}
asm
  // --> EDX   Value
  // <--  AL   Result
  CMP       EDX,        $0
  SETZ      AL
end;
{$ELSE ~ USE_FORCE_DELPHI}
begin
  Result := Value = 0;
end;
{$ENDIF ~ USE_ASSEMBLER}

function TchCrc32Algorithm.BitsToByte(const Value: Cardinal): Byte;
{$IF DEFINED(USE_ASSEMBLER)}
asm
  // --> EDX   Value
  // <--  AL   Result
  MOV       AL,         DL
end;
{$ELSE ~ USE_FORCE_DELPHI}
begin
  Result := Byte(Value);
end;
{$ENDIF ~ USE_ASSEMBLER}

function TchCrc32Algorithm.ByteToBits(const Value: Byte): Cardinal;
{$IF DEFINED(USE_ASSEMBLER)}
asm
  // --> EDX   Value
  // <-- EAX   Result
  MOVZX     EAX,        DL
end;
{$ELSE ~ USE_FORCE_DELPHI}
begin
  Result := Value;
end;
{$ENDIF ~ USE_ASSEMBLER}

function TchCrc32Algorithm.LeftShift(const Value: Cardinal; const Bits: Byte): Cardinal;
{$IF DEFINED(USE_ASSEMBLER)}
asm
{$IF DEFINED(X64)}
  // Start
  // --> EDX   Value
  //     R8B   Bits
  // <-- EAX   Result
  MOV       CL,         R8B
{$ELSE ~ X86}
  // Start
  // --> EDX   Value
  //      CL   Bits
  // <-- EAX   Result
{$ENDIF ~ X64}
  // Initialized
  MOV       EAX,        EDX
  SHL       EAX,        CL
  // Finish
end;
{$ELSE ~ USE_FORCE_DELPHI}
begin
  Result := Value shl Bits;
end;
{$ENDIF ~ USE_ASSEMBLER}

function TchCrc32Algorithm.RightShift(const Value: Cardinal; const Bits: Byte): Cardinal;
{$IF DEFINED(USE_ASSEMBLER)}
asm
{$IF DEFINED(X64)}
  // Start
  // --> EDX   Value
  //     R8B   Bits
  // <-- EAX   Result
  MOV       CL,         R8B
{$ELSE ~ X86}
  // Start
  // --> EDX   Value
  //      CL   Bits
  // <-- EAX   Result
{$ENDIF ~ X64}
  // Initialized
  MOV       EAX,        EDX
  SHR       EAX,        CL
  // Finish
end;
{$ELSE ~ USE_FORCE_DELPHI}
begin
  Result := Value shr Bits;
end;
{$ENDIF ~ USE_ASSEMBLER}

function TchCrc32Algorithm.BitwiseXor(const Left, Right: Cardinal): Cardinal;
{$IF DEFINED(USE_ASSEMBLER)}
asm
{$IF DEFINED(X64)}
  // Start
  // --> EDX   Left
  //     R8D   Right
  // <-- EAX   Result
  MOV       EAX,        R8D
{$ELSE ~ X86}
  // Start
  // --> EDX   Left
  //     ECX   Right
  // <-- EAX   Result
  MOV       EAX,        ECX
{$ENDIF ~ X64}
  // Initialized
  XOR       EAX,        EDX
  // Finish
end;
{$ELSE ~ USE_FORCE_DELPHI}
begin
  Result := Left xor Right;
end;
{$ENDIF ~ USE_ASSEMBLER}

{$IF DEFINED(USE_ASSEMBLER)}
procedure TchCrc32Algorithm.Calculate(var Current: Cardinal; const Data: Pointer; const Length: Cardinal);
asm
{$IF DEFINED(X64)}
  // Start
  // --> RCX    addres Self
  //     RDX    address Current
  //      R8    addres Data
  //      R9    Length
  // <-- EBX -> [RDX]
  TEST      R8,         R8
  JZ        @Ret
  NEG       R9
  JGE       @Ret

@Init:
  PUSH      RSI
  MOV       RSI,        R8             // addresss Data -> RSI
  PUSH      RBP
  MOV       RBP,        RCX            // addresss Self -> RBP
  ADD       RBP,        $18            // offset to Self.FTable -> RBP
  MOV       RCX,        R9             // Length -> RCX
  PUSH      RBX
  MOV       EBX,        [RDX]          // Current -> EBX
  PUSH      RDX
  SUB       RSI,        RCX
{$ELSE ~ X86}
  // Start
  // --> EAX       address Self
  //     EDX       address Current
  //     ECX       address Data
  //     on stack  Length
  // <-- EBX    -> [EDX]
  TEST      ECX,        ECX
  JZ        @Ret
  NEG       DWORD PTR [Length]
  JGE       @Ret

@Init:
  PUSH      ESI
  MOV       ESI,        ECX            // addresss Data -> ESI
  MOV       ECX, DWORD PTR [Length]    // Length -> ECX
  PUSH      EBP
  MOV       EBP,        EAX            // addresss Self -> EBP
  ADD       EBP,        $10            // offset to Self.FTable -> EBP
  PUSH      EBX
  MOV       EBX,        [EDX]          // Current -> EBX
  PUSH      EDX
  SUB       ESI,        ECX
{$ENDIF ~ X64}
  // Initialized

{$IF DEFINED(X64)}
  ADD       RCX,        $08
{$ELSE ~ X86}
  ADD       ECX,        $08
{$ENDIF ~ X64}
  JG        @NoBlock
{$IF DEFINED(X64)}
  PUSH      RDI
{$ELSE ~ X86}
  PUSH      EDI
{$ENDIF ~ X64}
  MOV       EDX,        EBX

@BlockNext:
{$IF DEFINED(X64)}
  XOR       EDX,        [RSI + RCX - $08]
  MOV       EAX,        [RSI + RCX - $04]
{$ELSE ~ X86}
  XOR       EDX,        [ESI + ECX - $08]
  MOV       EAX,        [ESI + ECX - $04]
{$ENDIF ~ X64}

  MOVZX     EDI,        AL
{$IF DEFINED(X64)}
  MOV       EBX,        [RBP + $0C00 + RDI * 4]      // (255 * 4) * 3
{$ELSE ~ X86}
  MOV       EBX,        [EBP + $0C00 + EDI * 4]      // (255 * 4) * 3
{$ENDIF ~ X64}
  MOVZX     EDI,        AH
{$IF DEFINED(X64)}
  XOR       EBX,        [RBP + $0800 + RDI * 4]      // (255 * 4) * 2
{$ELSE ~ X86}
  XOR       EBX,        [EBP + $0800 + EDI * 4]      // (255 * 4) * 2
{$ENDIF ~ X64}
  SHR       EAX,        16
  MOVZX     EDI,        AL
{$IF DEFINED(X64)}
  XOR       EBX,        [RBP + $0400 + RDI * 4]      // (255 * 4) * 1
{$ELSE ~ X86}
  XOR       EBX,        [EBP + $0400 + EDI * 4]      // (255 * 4) * 1
{$ENDIF ~ X64}
  MOVZX     EDI,        AH
{$IF DEFINED(X64)}
  XOR       EBX,        [RBP + RDI * 4]              // (255 * 4) * 0
{$ELSE ~ X86}
  XOR       EBX,        [EBP + EDI * 4]              // (255 * 4) * 0
{$ENDIF ~ X64}

  MOVZX     EDI,        DL
{$IF DEFINED(X64)}
  XOR       EBX,        [RBP + $1C00 + RDI * 4]      // (255 * 4) * 7
{$ELSE ~ X86}
  XOR       EBX,        [EBP + $1C00 + EDI * 4]      // (255 * 4) * 7
{$ENDIF ~ X64}
  MOVZX     EDI,        DH
{$IF DEFINED(X64)}
  XOR       EBX,        [RBP + $1800 + RDI * 4]      // (255 * 4) * 6
{$ELSE ~ X86}
  XOR       EBX,        [EBP + $1800 + EDI * 4]      // (255 * 4) * 6
{$ENDIF ~ X64}
  SHR       EDX,        16
  MOVZX     EDI,        DL
{$IF DEFINED(X64)}
  XOR       EBX,        [RBP + $1400 + RDI * 4]      // (255 * 4) * 5
{$ELSE ~ X86}
  XOR       EBX,        [EBP + $1400 + EDI * 4]      // (255 * 4) * 5
{$ENDIF ~ X64}
  MOVZX     EDI,        DH
{$IF DEFINED(X64)}
  XOR       EBX,        [RBP + $1000 + RDI * 4]      // (255 * 4) * 4
{$ELSE ~ X86}
  XOR       EBX,        [EBP + $1000 + EDI * 4]      // (255 * 4) * 4
{$ENDIF ~ X64}

{$IF DEFINED(X64)}
  ADD       RCX,        $08
{$ELSE ~ X86}
  ADD       ECX,        $08
{$ENDIF ~ X64}
  JG        @BlockDone

{$IF DEFINED(X64)}
  XOR       EBX,        [RSI + RCX - $08]
  MOV       EAX,        [RSI + RCX - $04]
{$ELSE ~ X86}
  XOR       EBX,        [ESI + ECX - $08]
  MOV       EAX,        [ESI + ECX - $04]
{$ENDIF ~ X64}

  MOVZX     EDI,        AL
{$IF DEFINED(X64)}
  MOV       EDX,        [RBP + $0C00 + RDI * 4]      // (255 * 4) * 3
{$ELSE ~ X86}
  MOV       EDX,        [EBP + $0C00 + EDI * 4]      // (255 * 4) * 3
{$ENDIF ~ X64}
  MOVZX     EDI,        AH
{$IF DEFINED(X64)}
  XOR       EDX,        [RBP + $0800 + RDI * 4]      // (255 * 4) * 2
{$ELSE ~ X86}
  XOR       EDX,        [EBP + $0800 + EDI * 4]      // (255 * 4) * 2
{$ENDIF ~ X64}
  SHR       EAX,        16
  MOVZX     EDI,        AL
{$IF DEFINED(X64)}
  XOR       EDX,        [RBP + $0400 + RDI * 4]      // (255 * 4) * 1
{$ELSE ~ X86}
  XOR       EDX,        [EBP + $0400 + EDI * 4]      // (255 * 4) * 1
{$ENDIF ~ X64}
  MOVZX     EDI,        AH
{$IF DEFINED(X64)}
  XOR       EDX,        [RBP + RDI * 4]              // (255 * 4) * 0
{$ELSE ~ X86}
  XOR       EDX,        [EBP + EDI * 4]              // (255 * 4) * 0
{$ENDIF ~ X64}

  MOVZX     EDI,        BL
{$IF DEFINED(X64)}
  XOR       EDX,        [RBP + $1C00 + RDI * 4]      // (255 * 4) * 7
{$ELSE ~ X86}
  XOR       EDX,        [EBP + $1C00 + EDI * 4]      // (255 * 4) * 7
{$ENDIF ~ X64}
  MOVZX     EDI,        BH
{$IF DEFINED(X64)}
  XOR       EDX,        [RBP + $1800 + RDI * 4]      // (255 * 4) * 6
{$ELSE ~ X86}
  XOR       EDX,        [EBP + $1800 + EDI * 4]      // (255 * 4) * 6
{$ENDIF ~ X64}
  SHR       EBX,        16
  MOVZX     EDI,        BL
{$IF DEFINED(X64)}
  XOR       EDX,        [RBP + $1400 + RDI * 4]      // (255 * 4) * 5
{$ELSE ~ X86}
  XOR       EDX,        [EBP + $1400 + EDI * 4]      // (255 * 4) * 5
{$ENDIF ~ X64}
  MOVZX     EDI,        BH
{$IF DEFINED(X64)}
  XOR       EDX,        [RBP + $1000 + RDI * 4]      // (255 * 4) * 4
{$ELSE ~ X86}
  XOR       EDX,        [EBP + $1000 + EDI * 4]      // (255 * 4) * 4
{$ENDIF ~ X64}

{$IF DEFINED(X64)}
  ADD       RCX,        $08
{$ELSE ~ X86}
  ADD       ECX,        $08
{$ENDIF ~ X64}
  JLE       @BlockNext
  MOV       EBX,        EDX

@BlockDone:
{$IF DEFINED(X64)}
  POP       RDI
{$ELSE ~ X86}
  POP       EDI
{$ENDIF ~ X64}

@NoBlock:
{$IF DEFINED(X64)}
  SUB       RCX,        $08
{$ELSE ~ X86}
  SUB       ECX,        $08
{$ENDIF ~ X64}
  JGE       @Done

@Tail:
{$IF DEFINED(X64)}
  MOVZX     EAX,        [RSI + RCX]
{$ELSE ~ X86}
  MOVZX     EAX,        [ESI + ECX]
{$ENDIF ~ X64}
  XOR       AL,         BL
  SHR       EBX,        8
{$IF DEFINED(X64)}
  XOR       EBX,        [RBP + RAX * 4]
{$ELSE ~ X86}
  XOR       EBX,        [EBP + EAX * 4]
{$ENDIF ~ X64}
{$IF DEFINED(X64)}
  INC       RCX
{$ELSE ~ X86}
  INC       ECX
{$ENDIF ~ X64}
  JNZ       @Tail

@Done:
{$IF DEFINED(X64)}
  POP       RDX
  MOV       [RDX],      EBX            // Result -> Current
  POP       RBX
  POP       RBP
  POP       RSI
{$ELSE ~ X86}
  POP       EDX
  MOV       [EDX],      EBX            // Result -> Current
  POP       EBX
  POP       EBP
  POP       ESI
{$ENDIF ~ X64}
@Ret:
  // Finish
end;
{$ELSE ~ USE_FORCE_DELPHI}
procedure TchCrc32Algorithm.Calculate(var Current: Cardinal; const Data: Pointer; const Length: Cardinal);
begin
  if (Data = nil) or (Length = 0) then Exit;

  var L := Length;

  var PData: PCardinal := Data;
  while L >= TABLE_LEVEL_SIZE do
  begin
    const Block01 = PData^ xor Current;
    Inc(PData);
    const Block02 = PData^;
    Inc(PData);
    const Block03 = PData^;
    Inc(PData);
    const Block04 = PData^;
    Inc(PData);

    Current :=
      FCrcTable[ 1, Byte(Block04 shr (BitsPerByte * 3))] xor
      FCrcTable[ 2, Byte(Block04 shr (BitsPerByte * 2))] xor
      FCrcTable[ 3, Byte(Block04 shr  BitsPerByte)]      xor
      FCrcTable[ 4, Byte(Block04)]                       xor

      FCrcTable[ 5, Byte(Block03 shr (BitsPerByte * 3))] xor
      FCrcTable[ 6, Byte(Block03 shr (BitsPerByte * 2))] xor
      FCrcTable[ 7, Byte(Block03 shr  BitsPerByte)]      xor
      FCrcTable[ 8, Byte(Block03)]                       xor

      FCrcTable[ 9, Byte(Block02 shr (BitsPerByte * 3))] xor
      FCrcTable[10, Byte(Block02 shr (BitsPerByte * 2))] xor
      FCrcTable[11, Byte(Block02 shr  BitsPerByte)]      xor
      FCrcTable[12, Byte(Block02)]                       xor

      FCrcTable[13, Byte(Block01 shr (BitsPerByte * 3))] xor
      FCrcTable[14, Byte(Block01 shr (BitsPerByte * 2))] xor
      FCrcTable[15, Byte(Block01 shr  BitsPerByte)]      xor
      FCrcTable[16, Byte(Block01)];

    Dec(L, TABLE_LEVEL_SIZE);
  end;

  var PByteData := PByte(PData);
  while L > 0 do
  begin
    Current := (Current shr BitsPerByte) xor FCrcTable[1, Byte((PByteData^ xor Current))];
    Inc(PByteData);
    Dec(L);
  end;
end;
{$ENDIF ~ USE_ASSEMBLER}

end.

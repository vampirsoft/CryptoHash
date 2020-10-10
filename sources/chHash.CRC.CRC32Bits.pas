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

unit chHash.CRC.CRC32Bits;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.Impl;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC;
{$ENDIF ~ SUPPORTS_INTERFACES}

type

{ TchCrc32Bits }

  TchCrc32Bits = class abstract(TchCrc<Cardinal>)
  strict private const
    BLOCK_SIZE = Byte({$IF DEFINED(USE_ASSEMBLER)}$08{$ELSE}$10{$ENDIF});
  strict protected
    constructor Create(const Name: string; const Width: Byte; const Polynomial, Init, XorOut, Check: Cardinal;
      const RefIn, RefOut: Boolean); reintroduce;
  {$IF DEFINED(HASH_TESTS)}
  public
  {$ELSE ~ NOT HASH_TESTS}
  strict protected
  {$ENDIF ~ HASH_TESTS}
    function ByteToBits(const Value: Byte): Cardinal; override;
    function BitsToByte(const Value: Cardinal): Byte; override;
    function LeftShift(const Value: Cardinal; const Bits: Byte): Cardinal; override;
    function RightShift(const Value: Cardinal; const Bits: Byte): Cardinal; override;
    function BitwiseAnd(const Left, Right: Cardinal): Cardinal; override;
    function BitwiseOr(const Left, Right: Cardinal): Cardinal; override;
    function BitwiseXor(const Left, Right: Cardinal): Cardinal; override;
    function Subtract(const Left, Right: Cardinal): Cardinal; override;
    function IsZero(const Value: Cardinal): Boolean; override;
  public
    procedure Calculate(var Current: Cardinal; const Data: Pointer; const Length: Cardinal); override;
  end;

implementation

{$IF NOT DEFINED(USE_ASSEMBLER)}
uses
{$IF DEFINED(USE_JEDI_CORE_LIBRARY)}
  JclLogic;
{$ELSE ~ NOT USE_JEDI_CORE_LIBRARY}
  chHash.Core.Bits;
{$ENDIF ~ USE_JEDI_CORE_LIBRARY}
{$ENDIF ~ NOT USE_ASSEMBLER}

{ TchCrc32Bits }

constructor TchCrc32Bits.Create(const Name: string; const Width: Byte; const Polynomial, Init, XorOut, Check: Cardinal;
  const RefIn, RefOut: Boolean);
begin
  inherited Create(Name, Width, TchCrc32Bits.BLOCK_SIZE, Polynomial, Init, XorOut, Check, RefIn, RefOut);
end;

function TchCrc32Bits.ByteToBits(const Value: Byte): Cardinal;
{$IF DEFINED(USE_ASSEMBLER)}
asm
  // -->  DL   Value
  // <-- EAX   Result
  MOVZX     EAX,        DL
end;
{$ELSE ~ USE_FORCE_DELPHI}
begin
  Result := Value;
end;
{$ENDIF ~ USE_ASSEMBLER}

function TchCrc32Bits.BitsToByte(const Value: Cardinal): Byte;
{$IF DEFINED(USE_ASSEMBLER)}
asm
  // --> EDX   Value
  // <--  AL   Result
  MOV       AL,         DL
end;
{$ELSE ~ USE_FORCE_DELPHI}
begin
  Result := Value;
end;
{$ENDIF ~ USE_ASSEMBLER}

function TchCrc32Bits.LeftShift(const Value: Cardinal; const Bits: Byte): Cardinal;
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

function TchCrc32Bits.RightShift(const Value: Cardinal; const Bits: Byte): Cardinal;
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

function TchCrc32Bits.BitwiseAnd(const Left, Right: Cardinal): Cardinal;
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
  AND       EAX,        EDX
  // Finish
end;
{$ELSE ~ USE_FORCE_DELPHI}
begin
  Result := Left and Right;
end;
{$ENDIF ~ USE_ASSEMBLER}

function TchCrc32Bits.BitwiseOr(const Left, Right: Cardinal): Cardinal;
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
  OR        EAX,        EDX
  // Finish
end;
{$ELSE ~ USE_FORCE_DELPHI}
begin
  Result := Left or Right;
end;
{$ENDIF ~ USE_ASSEMBLER}

function TchCrc32Bits.BitwiseXor(const Left, Right: Cardinal): Cardinal;
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

function TchCrc32Bits.Subtract(const Left, Right: Cardinal): Cardinal;
{$IF DEFINED(USE_ASSEMBLER)}
asm
{$IF DEFINED(X64)}
  // Start
  // --> EDX   Left
  //     R8D   Right
  // <-- EAX   Result
{$ELSE ~ X86}
  // Start
  // --> EDX   Left
  //     ECX   Right
  // <-- EAX   Result
{$ENDIF ~ X64}
  MOV       EAX,        EDX
  // Initialized
{$IF DEFINED(X64)}
  SUB       EAX,        R8D
{$ELSE ~ X86}
  SUB       EAX,        ECX
{$ENDIF ~ X64}
  // Finish
end;
{$ELSE ~ USE_FORCE_DELPHI}
begin
  Result := Left - Right;
end;
{$ENDIF ~ USE_ASSEMBLER}

function TchCrc32Bits.IsZero(const Value: Cardinal): Boolean;
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

{$IF DEFINED(USE_ASSEMBLER)}
procedure TchCrc32Bits.Calculate(var Current: Cardinal; const Data: Pointer; const Length: Cardinal);
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
  MOV       RSI,        R8            // addresss Data -> RSI
  PUSH      RBP
  MOV       RBP,        RCX           // addresss Self -> RBP
{$IF DEFINED(SUPPORTS_INTERFACES)}
  MOV       RBP,        [RBP + $38]   // offset to Self.FTable -> RBP
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  MOV       RBP,        [RBP + $20]   // offset to Self.FTable -> RBP
{$ENDIF ~ SUPPORTS_INTERFACES}
  MOV       RCX,        R9            // Length -> RCX
  PUSH      RBX
  MOV       EBX,        [RDX]         // Current -> EBX
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
  MOV       ESI,        ECX           // addresss Data -> ESI
  MOV       ECX, DWORD PTR [Length]   // Length -> ECX
  PUSH      EBP
  MOV       EBP,        EAX           // addresss Self -> EBP
{$IF DEFINED(SUPPORTS_INTERFACES)}
  MOV       EBP,        [EBP + $1C]   // offset to Self.FTable -> EBP
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  MOV       EBP,        [EBP + $10]   // offset to Self.FTable -> EBP
{$ENDIF ~ SUPPORTS_INTERFACES}
  PUSH      EBX
  MOV       EBX,        [EDX]         // Current -> EBX
  PUSH      EDX
  SUB       ESI,        ECX
{$ENDIF ~ X64}
  // Initialized

{$IF DEFINED(X64)}
  ADD       RCX,        BLOCK_SIZE
{$ELSE ~ X86}
  ADD       ECX,        BLOCK_SIZE
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
  MOV       EBX,        [RBP + $0C00 + RDI * 4]     // (256 * 4) * 3
{$ELSE ~ X86}
  MOV       EBX,        [EBP + $0C00 + EDI * 4]     // (256 * 4) * 3
{$ENDIF ~ X64}
  MOVZX     EDI,        AH
{$IF DEFINED(X64)}
  XOR       EBX,        [RBP + $0800 + RDI * 4]     // (256 * 4) * 2
{$ELSE ~ X86}
  XOR       EBX,        [EBP + $0800 + EDI * 4]     // (256 * 4) * 2
{$ENDIF ~ X64}
  SHR       EAX,        16
  MOVZX     EDI,        AL
{$IF DEFINED(X64)}
  XOR       EBX,        [RBP + $0400 + RDI * 4]     // (256 * 4) * 1
{$ELSE ~ X86}
  XOR       EBX,        [EBP + $0400 + EDI * 4]     // (256 * 4) * 1
{$ENDIF ~ X64}
  MOVZX     EDI,        AH
{$IF DEFINED(X64)}
  XOR       EBX,        [RBP + RDI * 4]             // (256 * 4) * 0
{$ELSE ~ X86}
  XOR       EBX,        [EBP + EDI * 4]             // (256 * 4) * 0
{$ENDIF ~ X64}

  MOVZX     EDI,        DL
{$IF DEFINED(X64)}
  XOR       EBX,        [RBP + $1C00 + RDI * 4]     // (256 * 4) * 7
{$ELSE ~ X86}
  XOR       EBX,        [EBP + $1C00 + EDI * 4]     // (256 * 4) * 7
{$ENDIF ~ X64}
  MOVZX     EDI,        DH
{$IF DEFINED(X64)}
  XOR       EBX,        [RBP + $1800 + RDI * 4]     // (256 * 4) * 6
{$ELSE ~ X86}
  XOR       EBX,        [EBP + $1800 + EDI * 4]     // (256 * 4) * 6
{$ENDIF ~ X64}
  SHR       EDX,        16
  MOVZX     EDI,        DL
{$IF DEFINED(X64)}
  XOR       EBX,        [RBP + $1400 + RDI * 4]     // (256 * 4) * 5
{$ELSE ~ X86}
  XOR       EBX,        [EBP + $1400 + EDI * 4]     // (256 * 4) * 5
{$ENDIF ~ X64}
  MOVZX     EDI,        DH
{$IF DEFINED(X64)}
  XOR       EBX,        [RBP + $1000 + RDI * 4]     // (256 * 4) * 4
{$ELSE ~ X86}
  XOR       EBX,        [EBP + $1000 + EDI * 4]     // (256 * 4) * 4
{$ENDIF ~ X64}

{$IF DEFINED(X64)}
  ADD       RCX,        BLOCK_SIZE
{$ELSE ~ X86}
  ADD       ECX,        BLOCK_SIZE
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
  MOV       EDX,        [RBP + $0C00 + RDI * 4]     // (256 * 4) * 3
{$ELSE ~ X86}
  MOV       EDX,        [EBP + $0C00 + EDI * 4]     // (256 * 4) * 3
{$ENDIF ~ X64}
  MOVZX     EDI,        AH
{$IF DEFINED(X64)}
  XOR       EDX,        [RBP + $0800 + RDI * 4]     // (256 * 4) * 2
{$ELSE ~ X86}
  XOR       EDX,        [EBP + $0800 + EDI * 4]     // (256 * 4) * 2
{$ENDIF ~ X64}
  SHR       EAX,        16
  MOVZX     EDI,        AL
{$IF DEFINED(X64)}
  XOR       EDX,        [RBP + $0400 + RDI * 4]     // (256 * 4) * 1
{$ELSE ~ X86}
  XOR       EDX,        [EBP + $0400 + EDI * 4]     // (256 * 4) * 1
{$ENDIF ~ X64}
  MOVZX     EDI,        AH
{$IF DEFINED(X64)}
  XOR       EDX,        [RBP + RDI * 4]             // (256 * 4) * 0
{$ELSE ~ X86}
  XOR       EDX,        [EBP + EDI * 4]             // (256 * 4) * 0
{$ENDIF ~ X64}

  MOVZX     EDI,        BL
{$IF DEFINED(X64)}
  XOR       EDX,        [RBP + $1C00 + RDI * 4]     // (256 * 4) * 7
{$ELSE ~ X86}
  XOR       EDX,        [EBP + $1C00 + EDI * 4]     // (256 * 4) * 7
{$ENDIF ~ X64}
  MOVZX     EDI,        BH
{$IF DEFINED(X64)}
  XOR       EDX,        [RBP + $1800 + RDI * 4]     // (256 * 4) * 6
{$ELSE ~ X86}
  XOR       EDX,        [EBP + $1800 + EDI * 4]     // (256 * 4) * 6
{$ENDIF ~ X64}
  SHR       EBX,        16
  MOVZX     EDI,        BL
{$IF DEFINED(X64)}
  XOR       EDX,        [RBP + $1400 + RDI * 4]     // (256 * 4) * 5
{$ELSE ~ X86}
  XOR       EDX,        [EBP + $1400 + EDI * 4]     // (256 * 4) * 5
{$ENDIF ~ X64}
  MOVZX     EDI,        BH
{$IF DEFINED(X64)}
  XOR       EDX,        [RBP + $1000 + RDI * 4]     // (256 * 4) * 4
{$ELSE ~ X86}
  XOR       EDX,        [EBP + $1000 + EDI * 4]     // (256 * 4) * 4
{$ENDIF ~ X64}

{$IF DEFINED(X64)}
  ADD       RCX,        BLOCK_SIZE
{$ELSE ~ X86}
  ADD       ECX,        BLOCK_SIZE
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
  SUB       RCX,        BLOCK_SIZE
{$ELSE ~ X86}
  SUB       ECX,        BLOCK_SIZE
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
  MOV       [RDX],      EBX           // Result -> Current
  POP       RBX
  POP       RBP
  POP       RSI
{$ELSE ~ X86}
  POP       EDX
  MOV       [EDX],      EBX           // Result -> Current
  POP       EBX
  POP       EBP
  POP       ESI
{$ENDIF ~ X64}
@Ret:
  // Finish
end;
{$ELSE ~ USE_FORCE_DELPHI}
procedure TchCrc32Bits.Calculate(var Current: Cardinal; const Data: Pointer; const Length: Cardinal);
begin
  if (Data = nil) or (Length = 0) then Exit;

  var L := Length;

  var PData: PCardinal := Data;
  while L >= TchCrc32Bits.BLOCK_SIZE do
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
      FCrcTable[ 0, Byte(Block04 shr (BitsPerByte * 3))] xor
      FCrcTable[ 1, Byte(Block04 shr (BitsPerByte * 2))] xor
      FCrcTable[ 2, Byte(Block04 shr  BitsPerByte)]      xor
      FCrcTable[ 3, Byte(Block04)]                       xor

      FCrcTable[ 4, Byte(Block03 shr (BitsPerByte * 3))] xor
      FCrcTable[ 5, Byte(Block03 shr (BitsPerByte * 2))] xor
      FCrcTable[ 6, Byte(Block03 shr  BitsPerByte)]      xor
      FCrcTable[ 7, Byte(Block03)]                       xor

      FCrcTable[ 8, Byte(Block02 shr (BitsPerByte * 3))] xor
      FCrcTable[ 9, Byte(Block02 shr (BitsPerByte * 2))] xor
      FCrcTable[10, Byte(Block02 shr  BitsPerByte)]      xor
      FCrcTable[11, Byte(Block02)]                       xor

      FCrcTable[12, Byte(Block01 shr (BitsPerByte * 3))] xor
      FCrcTable[13, Byte(Block01 shr (BitsPerByte * 2))] xor
      FCrcTable[14, Byte(Block01 shr  BitsPerByte)]      xor
      FCrcTable[15, Byte(Block01)];

    Dec(L, TchCrc32Bits.BLOCK_SIZE);
  end;

  inherited Calculate(Current, PData, L);
end;
{$ENDIF ~ USE_ASSEMBLER}

end.

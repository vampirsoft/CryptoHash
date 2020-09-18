/////////////////////////////////////////////////////////////////////////////////
//*****************************************************************************//
//* Project      : CryptoHash                                                 *//
//* Latest Source: https://github.com/vampirsoft/CryptoHash                   *//
//* Unit Name    : CryptoHash.inc                                             *//
//* Author       : Сергей (LordVampir) Дворников                              *//
//* Copyright 2019 LordVampir (https://github.com/vampirsoft)                 *//
//* Licensed under the Apache License, Version 2.0                            *//
//*****************************************************************************//
/////////////////////////////////////////////////////////////////////////////////

unit chHash.CRC.CRC8.Impl;

{$INCLUDE CryptoHash.inc}

interface

uses
  chHash.Impl,
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC8,
  chHash.CRC.Impl;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC;
{$ENDIF ~ SUPPORTS_INTERFACES}

type

{ TchCrc8 }

  TchCrc8 = class(TchCrc<Byte>{$IF DEFINED(SUPPORTS_INTERFACES)}, IchCrc8{$ENDIF})
  strict protected
    constructor Create(const Name: string; const Polynomial, Init, XorOut, Check: Byte;
      const RefIn, RefOut: Boolean); reintroduce;
    function ByteToBits(const Value: Byte): Byte; override;
    function BitsToByte(const Value: Byte): Byte; override;
    function LeftShift(const Value: Byte; const Bits: Byte): Byte; override;
    function RightShift(const Value: Byte; const Bits: Byte): Byte; override;
    function BitwiseAnd(const Left, Right: Byte): Byte; override;
    function BitwiseOr(const Left, Right: Byte): Byte; override;
    function BitwiseXor(const Left, Right: Byte): Byte; override;
    function Subtract(const Left, Right: Byte): Byte; override;
    function IsZero(const Value: Byte): Boolean; override;
  public
    procedure Calculate(var Current: Byte; const Data: Pointer; const Length: Cardinal); override;
  end;

implementation

uses
{$IF DEFINED(USE_JEDI_CORE_LIBRARY)}
  JclLogic;
{$ELSE ~ NOT USE_JEDI_CORE_LIBRARY}
  chHash.Core.Bits;
{$ENDIF ~ USE_JEDI_CORE_LIBRARY}

{ TchCrc8 }

constructor TchCrc8.Create(const Name: string; const Polynomial, Init, XorOut, Check: Byte;
  const RefIn, RefOut: Boolean);
begin
  inherited Create(Name, 8, Polynomial, Init, XorOut, Check, RefIn, RefOut);
end;

function TchCrc8.ByteToBits(const Value: Byte): Byte;
{$IF DEFINED(USE_ASSEMBLER)}
asm
  // --> DL   Value
  // <-- AL   Result
  MOV       AL,         DL
end;
{$ELSE ~ USE_FORCE_DELPHI}
begin
  Result := Value;
end;
{$ENDIF ~ USE_ASSEMBLER}

function TchCrc8.BitsToByte(const Value: Byte): Byte;
{$IF DEFINED(USE_ASSEMBLER)}
asm
  // --> DL   Value
  // <-- AL   Result
  MOV       AL,         DL
end;
{$ELSE ~ USE_FORCE_DELPHI}
begin
  Result := Value;
end;
{$ENDIF ~ USE_ASSEMBLER}

function TchCrc8.LeftShift(const Value, Bits: Byte): Byte;
{$IF DEFINED(USE_ASSEMBLER)}
asm
{$IF DEFINED(X64)}
  // Start
  // -->  DL   Value
  //     R8B   Bits
  // <--  AL   Result
  MOV       CL,         R8B
{$ELSE ~ X86}
  // Start
  // -->  DL   Value
  //      CL   Bits
  // <--  AL   Result
{$ENDIF ~ X64}
  // Initialized
  MOV       AL,         DL
  SHL       AL,         CL
  // Finish
end;
{$ELSE ~ USE_FORCE_DELPHI}
begin
  Result := Value shl Bits;
end;
{$ENDIF ~ USE_ASSEMBLER}

function TchCrc8.RightShift(const Value, Bits: Byte): Byte;
{$IF DEFINED(USE_ASSEMBLER)}
asm
{$IF DEFINED(X64)}
  // Start
  // -->  DL   Value
  //     R8B   Bits
  // <--  AL   Result
  MOV       CL,         R8B
{$ELSE ~ X86}
  // Start
  // -->  DL   Value
  //      CL   Bits
  // <--  AL   Result
{$ENDIF ~ X64}
  // Initialized
  MOV       AL,         DL
  SHR       AL,         CL
  // Finish
end;
{$ELSE ~ USE_FORCE_DELPHI}
begin
  Result := Value shr Bits;
end;
{$ENDIF ~ USE_ASSEMBLER}

function TchCrc8.BitwiseAnd(const Left, Right: Byte): Byte;
{$IF DEFINED(USE_ASSEMBLER)}
asm
{$IF DEFINED(X64)}
  // Start
  // -->  DL   Left
  //     R8B   Right
  // <--  AL   Result
  MOV       AL,         R8B
{$ELSE ~ X86}
  // Start
  // -->  DL   Left
  //      CL   Right
  // <--  AL   Result
  MOV       AL,         CL
{$ENDIF ~ X64}
  // Initialized
  AND       AL,         DL
  // Finish
end;
{$ELSE ~ USE_FORCE_DELPHI}
begin
  Result := Left and Right;
end;
{$ENDIF ~ USE_ASSEMBLER}

function TchCrc8.BitwiseOr(const Left, Right: Byte): Byte;
{$IF DEFINED(USE_ASSEMBLER)}
asm
{$IF DEFINED(X64)}
  // Start
  // -->  DL   Left
  //     R8B   Right
  // <--  AL   Result
  MOV       AL,         R8B
{$ELSE ~ X86}
  // Start
  // -->  DL   Left
  //      CL   Right
  // <--  AL   Result
  MOV       AL,         CL
{$ENDIF ~ X64}
  // Initialized
  OR        AL,         DL
  // Finish
end;
{$ELSE ~ USE_FORCE_DELPHI}
begin
  Result := Left or Right;
end;
{$ENDIF ~ USE_ASSEMBLER}

function TchCrc8.BitwiseXor(const Left, Right: Byte): Byte;
{$IF DEFINED(USE_ASSEMBLER)}
asm
{$IF DEFINED(X64)}
  // Start
  // -->  DL   Left
  //     R8B   Right
  // <--  AL   Result
  MOV       AL,         R8B
{$ELSE ~ X86}
  // Start
  // -->  DL   Left
  //      CL   Right
  // <--  AL   Result
  MOV       AL,         CL
{$ENDIF ~ X64}
  // Initialized
  XOR       AL,         DL
  // Finish
end;
{$ELSE ~ USE_FORCE_DELPHI}
begin
  Result := Left xor Right;
end;
{$ENDIF ~ USE_ASSEMBLER}

function TchCrc8.Subtract(const Left, Right: Byte): Byte;
{$IF DEFINED(USE_ASSEMBLER)}
asm
{$IF DEFINED(X64)}
  // Start
  // -->  DL   Left
  //     R8B   Right
  // <--  AL   Result
{$ELSE ~ X86}
  // Start
  // -->  DL   Left
  //      CL   Right
  // <--  AL   Result
{$ENDIF ~ X64}
  MOV       AL,         DL
  // Initialized
{$IF DEFINED(X64)}
  SUB       AL,         R8B
{$ELSE ~ X86}
  SUB       AL,         CL
{$ENDIF ~ X64}
  // Finish
end;
{$ELSE ~ USE_FORCE_DELPHI}
begin
  Result := Left - Right;
end;
{$ENDIF ~ USE_ASSEMBLER}

function TchCrc8.IsZero(const Value: Byte): Boolean;
{$IF DEFINED(USE_ASSEMBLER)}
asm
  // --> DL   Value
  // <-- AL   Result
  CMP       DL,         $0
  SETZ      AL
end;
{$ELSE ~ USE_FORCE_DELPHI}
begin
  Result := Value = 0;
end;
{$ENDIF ~ USE_ASSEMBLER}

{$IF DEFINED(USE_ASSEMBLER)}
procedure TchCrc8.Calculate(var Current: Byte; const Data: Pointer; const Length: Cardinal);
asm
{$IF DEFINED(X64)}
  // Start
  // --> RCX    addres Self
  //     RDX    address Current
  //      R8    addres Data
  //      R9    Length
  // <--  BL -> [RDX]
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
  ADD       RBP,        $38           // offset to Self.FTable -> EBP
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  ADD       RBP,        $20           // offset to Self.FTable -> RBP
{$ENDIF ~ SUPPORTS_INTERFACES}
  MOV       RCX,        R9            // Length -> RCX
  PUSH      RBX
  MOVZX     EBX,        [RDX]         // Current -> BL
  PUSH      RDX
  SUB       RSI,        RCX
{$ELSE ~ X86}
  // Start
  // --> EAX       address Self
  //     EDX       address Current
  //     ECX       address Data
  //     on stack  Length
  // <--  BL    -> [EDX]
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
  ADD       EBP,        $1C           // offset to Self.FTable -> EBP
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  ADD       EBP,        $10           // offset to Self.FTable -> EBP
{$ENDIF ~ SUPPORTS_INTERFACES}
  PUSH      EBX
  MOVZX     EBX,        [EDX]         // Current -> BL
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
  MOVZX     EBX,        [RBP + $0300 + RDI]         // (256 * 1) * 3
{$ELSE ~ X86}
  MOVZX     EBX,        [EBP + $0300 + EDI]         // (256 * 1) * 3
{$ENDIF ~ X64}
  MOVZX     EDI,        AH
{$IF DEFINED(X64)}
  XOR       BL,         [RBP + $0200 + RDI]         // (256 * 1) * 2
{$ELSE ~ X86}
  XOR       BL,         [EBP + $0200 + EDI]         // (256 * 1) * 2
{$ENDIF ~ X64}
  SHR       EAX,        16
  MOVZX     EDI,        AL
{$IF DEFINED(X64)}
  XOR       BL,         [RBP + $0100 + RDI]         // (256 * 1) * 1
{$ELSE ~ X86}
  XOR       BL,         [EBP + $0100 + EDI]         // (256 * 1) * 1
{$ENDIF ~ X64}
  MOVZX     EDI,        AH
{$IF DEFINED(X64)}
  XOR       BL,         [RBP + RDI]                 // (256 * 1) * 0
{$ELSE ~ X86}
  XOR       BL,         [EBP + EDI]                 // (256 * 1) * 0
{$ENDIF ~ X64}

  MOVZX     EDI,        DL
{$IF DEFINED(X64)}
  XOR       BL,         [RBP + $0700 + RDI]         // (256 * 1) * 7
{$ELSE ~ X86}
  XOR       BL,         [EBP + $0700 + EDI]         // (256 * 1) * 7
{$ENDIF ~ X64}
  MOVZX     EDI,        DH
{$IF DEFINED(X64)}
  XOR       BL,         [RBP + $0600 + RDI]         // (256 * 1) * 6
{$ELSE ~ X86}
  XOR       BL,         [EBP + $0600 + EDI]         // (256 * 1) * 6
{$ENDIF ~ X64}
  SHR       EDX,        16
  MOVZX     EDI,        DL
{$IF DEFINED(X64)}
  XOR       BL,         [RBP + $0500 + RDI]         // (256 * 1) * 5
{$ELSE ~ X86}
  XOR       BL,         [EBP + $0500 + EDI]         // (256 * 1) * 5
{$ENDIF ~ X64}
  MOVZX     EDI,        DH
{$IF DEFINED(X64)}
  XOR       BL,         [RBP + $0400 + RDI]         // (256 * 4) * 4
{$ELSE ~ X86}
  XOR       BL,         [EBP + $0400 + EDI]         // (256 * 1) * 4
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
  MOVZX     EDX,        [RBP + $0300 + RDI]         // (256 * 1) * 3
{$ELSE ~ X86}
  MOVZX     EDX,        [EBP + $0300 + EDI]         // (256 * 1) * 3
{$ENDIF ~ X64}
  MOVZX     EDI,        AH
{$IF DEFINED(X64)}
  XOR       DL,         [RBP + $0200 + RDI]         // (256 * 1) * 2
{$ELSE ~ X86}
  XOR       DL,         [EBP + $0200 + EDI]         // (256 * 1) * 2
{$ENDIF ~ X64}
  SHR       EAX,        16
  MOVZX     EDI,        AL
{$IF DEFINED(X64)}
  XOR       DL,         [RBP + $0100 + RDI]         // (256 * 1) * 1
{$ELSE ~ X86}
  XOR       DL,         [EBP + $0100 + EDI]         // (256 * 1) * 1
{$ENDIF ~ X64}
  MOVZX     EDI,        AH
{$IF DEFINED(X64)}
  XOR       DL,         [RBP + RDI]                 // (256 * 1) * 0
{$ELSE ~ X86}
  XOR       DL,         [EBP + EDI]                 // (256 * 1) * 0
{$ENDIF ~ X64}

  MOVZX     EDI,        BL
{$IF DEFINED(X64)}
  XOR       DL,         [RBP + $0700 + RDI]         // (256 * 1) * 7
{$ELSE ~ X86}
  XOR       DL,         [EBP + $0700 + EDI]         // (256 * 1) * 7
{$ENDIF ~ X64}
  MOVZX     EDI,        BH
{$IF DEFINED(X64)}
  XOR       DL,         [RBP + $0600 + RDI]         // (256 * 1) * 6
{$ELSE ~ X86}
  XOR       DL,         [EBP + $0600 + EDI]         // (256 * 1) * 6
{$ENDIF ~ X64}
  SHR       EBX,        16
  MOVZX     EDI,        BL
{$IF DEFINED(X64)}
  XOR       DL,         [RBP + $0500 + RDI]         // (256 * 1) * 5
{$ELSE ~ X86}
  XOR       DL,         [EBP + $0500 + EDI]         // (256 * 1) * 5
{$ENDIF ~ X64}
  MOVZX     EDI,        BH
{$IF DEFINED(X64)}
  XOR       DL,         [RBP + $0400 + RDI]         // (256 * 1) * 4
{$ELSE ~ X86}
  XOR       DL,         [EBP + $0400 + EDI]         // (256 * 1) * 4
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
{$IF DEFINED(X64)}
  MOV       BL,         [RBP + RAX]
{$ELSE ~ X86}
  MOV       BL,         [EBP + EAX]
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
  MOV       [RDX],      BL            // Result -> Current
  POP       RBX
  POP       RBP
  POP       RSI
{$ELSE ~ X86}
  POP       EDX
  MOV       [EDX],      BL            // Result -> Current
  POP       EBX
  POP       EBP
  POP       ESI
{$ENDIF ~ X64}
@Ret:
  // Finish
end;
{$ELSE ~ USE_FORCE_DELPHI}
procedure TchCrc8.Calculate(var Current: Byte; const Data: Pointer; const Length: Cardinal);
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
    Current := FCrcTable[1, Byte((PByteData^ xor Current))];
    Inc(PByteData);
    Dec(L);
  end;
end;
{$ENDIF ~ USE_ASSEMBLER}

end.

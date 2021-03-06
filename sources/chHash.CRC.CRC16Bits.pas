﻿/////////////////////////////////////////////////////////////////////////////////
//*****************************************************************************//
//* Project      : CryptoHash                                                 *//
//* Latest Source: https://github.com/vampirsoft/CryptoHash                   *//
//* Unit Name    : CryptoHash.inc                                             *//
//* Author       : Сергей (LordVampir) Дворников                              *//
//* Copyright 2021 LordVampir (https://github.com/vampirsoft)                 *//
//* Licensed under MIT                                                        *//
//*****************************************************************************//
/////////////////////////////////////////////////////////////////////////////////

unit chHash.CRC.CRC16Bits;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.Impl;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC;
{$ENDIF ~ SUPPORTS_INTERFACES}

type

{ TchCrc16Bits }

  TchCrc16Bits = class abstract(TchCrc<Word>)
  strict private const
    BLOCK_SIZE = Byte($02);
  strict protected
    constructor Create(const Name: string; const Width: Byte; const Polynomial, Init, XorOut, Check: Word;
      const RefIn, RefOut: Boolean; const BlockSize: Byte = TchCrc16Bits.BLOCK_SIZE); reintroduce;
{$IF DEFINED(HASH_TESTS)}
  public
  {$ELSE ~ NOT HASH_TESTS}
  strict protected
  {$ENDIF ~ HASH_TESTS}
    function ByteToBits(const Value: Byte): Word; override;
    function BitsToByte(const Value: Word): Byte; override;
    function LeftShift(const Value: Word; const Bits: Byte): Word; override;
    function RightShift(const Value: Word; const Bits: Byte): Word; override;
    function BitwiseAnd(const Left, Right: Word): Word; override;
    function BitwiseOr(const Left, Right: Word): Word; override;
    function BitwiseXor(const Left, Right: Word): Word; override;
    function Subtract(const Left, Right: Word): Word; override;
    function IsZero(const Value: Word): Boolean; override;
  public
    procedure Calculate(var Current: Word; const Data: Pointer; const Length: Cardinal); override;
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

{ TchCrc16Bits }

constructor TchCrc16Bits.Create(const Name: string; const Width: Byte; const Polynomial, Init, XorOut, Check: Word;
  const RefIn, RefOut: Boolean; const BlockSize: Byte);
begin
  inherited Create(Name, Width, BlockSize, Polynomial, Init, XorOut, Check, RefIn, RefOut);
end;

function TchCrc16Bits.ByteToBits(const Value: Byte): Word;
{$IF DEFINED(USE_ASSEMBLER)}
asm
  // --> DL   Value
  // <-- AX   Result
  MOVZX     AX,         DL
end;
{$ELSE ~ USE_FORCE_DELPHI}
begin
  Result := Value;
end;
{$ENDIF ~ USE_ASSEMBLER}

function TchCrc16Bits.BitsToByte(const Value: Word): Byte;
{$IF DEFINED(USE_ASSEMBLER)}
asm
  // --> DX   Value
  // <-- AL   Result
  MOV       AL,         DL
end;
{$ELSE ~ USE_FORCE_DELPHI}
begin
  Result := Value;
end;
{$ENDIF ~ USE_ASSEMBLER}

function TchCrc16Bits.LeftShift(const Value: Word; const Bits: Byte): Word;
{$IF DEFINED(USE_ASSEMBLER)}
asm
{$IF DEFINED(X64)}
  // Start
  // -->  DX   Value
  //     R8B   Bits
  // <--  AX   Result
  MOV       CL,         R8B
{$ELSE ~ X86}
  // Start
  // -->  DX   Value
  //      CL   Bits
  // <--  AX   Result
{$ENDIF ~ X64}
  // Initialized
  MOV       AX,         DX
  SHL       AX,         CL
  // Finish
end;
{$ELSE ~ USE_FORCE_DELPHI}
begin
  Result := Value shl Bits;
end;
{$ENDIF ~ USE_ASSEMBLER}

function TchCrc16Bits.RightShift(const Value: Word; const Bits: Byte): Word;
{$IF DEFINED(USE_ASSEMBLER)}
asm
{$IF DEFINED(X64)}
  // Start
  // -->  DX   Value
  //     R8B   Bits
  // <--  AX   Result
  MOV       CL,         R8B
{$ELSE ~ X86}
  // Start
  // -->  DX   Value
  //      CL   Bits
  // <--  AX   Result
{$ENDIF ~ X64}
  // Initialized
  MOV       AX,         DX
  SHR       AX,         CL
  // Finish
end;
{$ELSE ~ USE_FORCE_DELPHI}
begin
  Result := Value shr Bits;
end;
{$ENDIF ~ USE_ASSEMBLER}

function TchCrc16Bits.BitwiseAnd(const Left, Right: Word): Word;
{$IF DEFINED(USE_ASSEMBLER)}
asm
{$IF DEFINED(X64)}
  // Start
  // -->  DX   Left
  //     R8W   Right
  // <--  AX   Result
  MOV       AX,         R8W
{$ELSE ~ X86}
  // Start
  // -->  DX   Left
  //      CX   Right
  // <--  AX   Result
  MOV       AX,         CX
{$ENDIF ~ X64}
  // Initialized
  AND       AX,         DX
  // Finish
end;
{$ELSE ~ USE_FORCE_DELPHI}
begin
  Result := Left and Right;
end;
{$ENDIF ~ USE_ASSEMBLER}

function TchCrc16Bits.BitwiseOr(const Left, Right: Word): Word;
{$IF DEFINED(USE_ASSEMBLER)}
asm
{$IF DEFINED(X64)}
  // Start
  // -->  DX   Left
  //     R8W   Right
  // <--  AX   Result
  MOV       AX,         R8W
{$ELSE ~ X86}
  // Start
  // -->  DX   Left
  //      CX   Right
  // <--  AX   Result
  MOV       AX,         CX
{$ENDIF ~ X64}
  // Initialized
  OR        AX,         DX
  // Finish
end;
{$ELSE ~ USE_FORCE_DELPHI}
begin
  Result := Left or Right;
end;
{$ENDIF ~ USE_ASSEMBLER}

function TchCrc16Bits.BitwiseXor(const Left, Right: Word): Word;
{$IF DEFINED(USE_ASSEMBLER)}
asm
{$IF DEFINED(X64)}
  // Start
  // -->  DX   Left
  //     R8W   Right
  // <--  AX   Result
  MOV       AX,         R8W
{$ELSE ~ X86}
  // Start
  // -->  DX   Left
  //      CX   Right
  // <--  AX   Result
  MOV       AX,         CX
{$ENDIF ~ X64}
  // Initialized
  XOR       AX,         DX
  // Finish
end;
{$ELSE ~ USE_FORCE_DELPHI}
begin
  Result := Left xor Right;
end;
{$ENDIF ~ USE_ASSEMBLER}

function TchCrc16Bits.Subtract(const Left, Right: Word): Word;
{$IF DEFINED(USE_ASSEMBLER)}
asm
{$IF DEFINED(X64)}
  // Start
  // -->  DX   Left
  //     R8W   Right
  // <--  AX   Result
{$ELSE ~ X86}
  // Start
  // -->  DX   Left
  //      CX   Right
  // <--  AX   Result
{$ENDIF ~ X64}
  MOV       AX,         DX
  // Initialized
{$IF DEFINED(X64)}
  SUB       AX,         R8W
{$ELSE ~ X86}
  SUB       AX,         CX
{$ENDIF ~ X64}
  // Finish
end;
{$ELSE ~ USE_FORCE_DELPHI}
begin
  Result := Left - Right;
end;
{$ENDIF ~ USE_ASSEMBLER}

function TchCrc16Bits.IsZero(const Value: Word): Boolean;
{$IF DEFINED(USE_ASSEMBLER)}
asm
  // --> DX   Value
  // <-- AL   Result
  CMP       DX,         $0
  SETZ      AL
end;
{$ELSE ~ USE_FORCE_DELPHI}
begin
  Result := Value = 0;
end;
{$ENDIF ~ USE_ASSEMBLER}

{$IF DEFINED(USE_ASSEMBLER)}
procedure TchCrc16Bits.Calculate(var Current: Word; const Data: Pointer; const Length: Cardinal);
asm
{$IF DEFINED(X64)}
  // Start
  // --> RCX    addres Self
  //     RDX    address Current
  //      R8    addres Data
  //      R9    Length
  // <--  BX -> [RDX]
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
  MOVZX     EBX, WORD PTR [RDX]       // Current -> BX
  PUSH      RDX
  SUB       RSI,        RCX
{$ELSE ~ X86}
  // Start
  // --> EAX       address Self
  //     EDX       address Current
  //     ECX       address Data
  //     on stack  Length
  // <--  BX    -> [EDX]
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
  MOVZX     EBX, WORD PTR [EDX]       // Current -> BX
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
  XOR       DX,         [RSI + RCX - $02]
{$ELSE ~ X86}
  XOR       DX,         [ESI + ECX - $02]
{$ENDIF ~ X64}

  MOVZX     EDI,        DL
{$IF DEFINED(X64)}
  MOVZX     EBX, WORD PTR [RBP + $0200 + RDI * 2]   // (256 * 2) * 1
{$ELSE ~ X86}
  MOVZX     EBX, WORD PTR [EBP + $0200 + EDI * 2]   // (256 * 2) * 1
{$ENDIF ~ X64}
  MOVZX     EDI,        DH
{$IF DEFINED(X64)}
  XOR       BX,         [RBP + RDI * 2]             // (256 * 2) * 0
{$ELSE ~ X86}
  XOR       BX,         [EBP + EDI * 2]             // (256 * 2) * 0
{$ENDIF ~ X64}

{$IF DEFINED(X64)}
  ADD       RCX,        BLOCK_SIZE
{$ELSE ~ X86}
  ADD       ECX,        BLOCK_SIZE
{$ENDIF ~ X64}
  JG        @BlockDone

{$IF DEFINED(X64)}
  XOR       BX,         [RSI + RCX - $02]
{$ELSE ~ X86}
  XOR       BX,         [ESI + ECX - $02]
{$ENDIF ~ X64}

  MOVZX     EDI,        BL
{$IF DEFINED(X64)}
  MOV       DX,         [RBP + $0200 + RDI * 2]     // (256 * 2) * 1
{$ELSE ~ X86}
  MOV       DX,         [EBP + $0200 + EDI * 2]     // (256 * 2) * 1
{$ENDIF ~ X64}
  MOVZX     EDI,        BH
{$IF DEFINED(X64)}
  XOR       DX,         [RBP + RDI * 2]             // (256 * 2) * 0
{$ELSE ~ X86}
  XOR       DX,         [EBP + EDI * 2]             // (256 * 2) * 0
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
  XOR       BX,         [RBP + RAX * 2]
{$ELSE ~ X86}
  XOR       BX,         [EBP + EAX * 2]
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
  MOV       [RDX],      BX            // Result -> Current
  POP       RBX
  POP       RBP
  POP       RSI
{$ELSE ~ X86}
  POP       EDX
  MOV       [EDX],      BX            // Result -> Current
  POP       EBX
  POP       EBP
  POP       ESI
{$ENDIF ~ X64}
@Ret:
  // Finish
end;
{$ELSE ~ USE_FORCE_DELPHI}
procedure TchCrc16Bits.Calculate(var Current: Word; const Data: Pointer; const Length: Cardinal);
begin
  if (Data = nil) or (Length = 0) then Exit;

  var L := Length;

  var PData: PWord := Data;
  while L >= TchCrc16Bits.BLOCK_SIZE do
  begin
    const Block = PData^ xor Current;
    Inc(PData);

    Current :=
      FCrcTable[0, Byte(Block shr  BitsPerByte)] xor
      FCrcTable[1, Byte(Block)];

    Dec(L, TchCrc16Bits.BLOCK_SIZE);
  end;

  inherited Calculate(Current, PData, L);
end;
{$ENDIF ~ USE_ASSEMBLER}

end.

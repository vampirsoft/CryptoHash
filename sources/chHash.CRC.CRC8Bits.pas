/////////////////////////////////////////////////////////////////////////////////
//*****************************************************************************//
//* Project      : CryptoHash                                                 *//
//* Latest Source: https://github.com/vampirsoft/CryptoHash                   *//
//* Unit Name    : CryptoHash.inc                                             *//
//* Author       : Сергей (LordVampir) Дворников                              *//
//* Copyright 2021 LordVampir (https://github.com/vampirsoft)                 *//
//* Licensed under the Apache License, Version 2.0                            *//
//*****************************************************************************//
/////////////////////////////////////////////////////////////////////////////////

unit chHash.CRC.CRC8Bits;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.Impl;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC;
{$ENDIF ~ SUPPORTS_INTERFACES}

type

{ TchCrc8Bits }

  TchCrc8Bits = class abstract(TchCrc<Byte>)
  strict private const
    BLOCK_SIZE = Byte($01);
  strict protected
    constructor Create(const Name: string; const Width: Byte; const Polynomial, Init, XorOut, Check: Word;
      const RefIn, RefOut: Boolean; const BlockSize: Byte = TchCrc8Bits.BLOCK_SIZE); reintroduce;
  {$IF DEFINED(HASH_TESTS)}
  public
  {$ELSE ~ NOT HASH_TESTS}
  strict protected
  {$ENDIF ~ HASH_TESTS}
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

{$IF NOT DEFINED(USE_ASSEMBLER)}
uses
{$IF DEFINED(USE_JEDI_CORE_LIBRARY)}
  JclLogic;
{$ELSE ~ NOT USE_JEDI_CORE_LIBRARY}
  chHash.Core.Bits;
{$ENDIF ~ USE_JEDI_CORE_LIBRARY}
{$ENDIF ~ NOT USE_ASSEMBLER}

{ TchCrc8Bits }

constructor TchCrc8Bits.Create(const Name: string; const Width: Byte; const Polynomial, Init, XorOut, Check: Word;
  const RefIn, RefOut: Boolean; const BlockSize: Byte);
begin
  inherited Create(Name, Width, BlockSize, Polynomial, Init, XorOut, Check, RefIn, RefOut);
end;

function TchCrc8Bits.ByteToBits(const Value: Byte): Byte;
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

function TchCrc8Bits.BitsToByte(const Value: Byte): Byte;
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

function TchCrc8Bits.LeftShift(const Value, Bits: Byte): Byte;
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

function TchCrc8Bits.RightShift(const Value, Bits: Byte): Byte;
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

function TchCrc8Bits.BitwiseAnd(const Left, Right: Byte): Byte;
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

function TchCrc8Bits.BitwiseOr(const Left, Right: Byte): Byte;
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

function TchCrc8Bits.BitwiseXor(const Left, Right: Byte): Byte;
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

function TchCrc8Bits.Subtract(const Left, Right: Byte): Byte;
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

function TchCrc8Bits.IsZero(const Value: Byte): Boolean;
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
procedure TchCrc8Bits.Calculate(var Current: Byte; const Data: Pointer; const Length: Cardinal);
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
  MOV       RBP,        [RBP + $38]   // offset to Self.FTable -> RBP
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  MOV       RBP,        [RBP + $20]   // offset to Self.FTable -> RBP
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
  MOV       EBP,        [EBP + $1C]   // offset to Self.FTable -> EBP
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  MOV       EBP,        [EBP + $10]   // offset to Self.FTable -> EBP
{$ENDIF ~ SUPPORTS_INTERFACES}
  PUSH      EBX
  MOVZX     EBX,        [EDX]         // Current -> BL
  PUSH      EDX
  SUB       ESI,        ECX
{$ENDIF ~ X64}
  // Initialized

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
procedure TchCrc8Bits.Calculate(var Current: Byte; const Data: Pointer; const Length: Cardinal);
begin
  if (Data = nil) or (Length = 0) then Exit;

  var L := Length;
  var PData: PByte := Data;
  while L > 0 do
  begin
    Current := FCrcTable[0, Byte(PData^ xor Current)];
    Inc(PData);
    Dec(L);
  end;
end;
{$ENDIF ~ USE_ASSEMBLER}

end.

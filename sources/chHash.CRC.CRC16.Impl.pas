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

unit chHash.CRC.CRC16.Impl;

{$INCLUDE CryptoHash.inc}

interface

uses
  chHash.Impl,
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC16,
  chHash.CRC.Impl;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC;
{$ENDIF ~ SUPPORTS_INTERFACES}

type

{ TchCrc16 }

  TchCrc16 = class(TchCrc<Word>{$IF DEFINED(SUPPORTS_INTERFACES)}, IchCrc16{$ENDIF})
  strict protected
    function ByteToBits(const Value: Byte): Word; override;
    function BitsToByte(const Value: Word): Byte; override;
    function LeftShift(const Value: Word; const Bits: Byte): Word; override;
    function RightShift(const Value: Word; const Bits: Byte): Word; override;
    function BitwiseXor(const Left, Right: Word): Word; override;
    function IsZero(const Value: Word): Boolean; override;
  public
    class function Custom(const Polynomial, Init, XorOut, Check: Word;
      const RefIn, RefOut: Boolean): TchCrc16; static;{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}
    procedure Calculate(var Current: Word; const Data: Pointer; const Length: Cardinal); override;
  end;

implementation

uses
{$IF DEFINED(USE_JEDI_CORE_LIBRARY)}
  JclLogic;
{$ELSE ~ NOT USE_JEDI_CORE_LIBRARY}
  chHash.Core.Bits;
{$ENDIF ~ USE_JEDI_CORE_LIBRARY}

{ TchCrc16 }

class function TchCrc16.Custom(const Polynomial, Init, XorOut, Check: Word; const RefIn, RefOut: Boolean): TchCrc16;
begin
  Result := TchCrc16.Create('Custom', Polynomial, Init, XorOut, Check, RefIn, RefOut);
end;

function TchCrc16.ByteToBits(const Value: Byte): Word;
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

function TchCrc16.BitsToByte(const Value: Word): Byte;
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

function TchCrc16.LeftShift(const Value: Word; const Bits: Byte): Word;
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

function TchCrc16.RightShift(const Value: Word; const Bits: Byte): Word;
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

function TchCrc16.BitwiseXor(const Left, Right: Word): Word;
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

function TchCrc16.IsZero(const Value: Word): Boolean;
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
procedure TchCrc16.Calculate(var Current: Word; const Data: Pointer; const Length: Cardinal);
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
  ADD       RBP,        $30           // offset to Self.FTable -> EBP
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  ADD       RBP,        $18           // offset to Self.FTable -> RBP
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
  ADD       EBP,        $18           // offset to Self.FTable -> EBP
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  ADD       EBP,        $0C           // offset to Self.FTable -> EBP
{$ENDIF ~ SUPPORTS_INTERFACES}
  PUSH      EBX
  MOVZX     EBX, WORD PTR [EDX]       // Current -> BX
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
  MOVZX     EBX, WORD PTR [RBP + $0600 + RDI * 2]   // (256 * 2) * 3
{$ELSE ~ X86}
  MOVZX     EBX, WORD PTR [EBP + $0600 + EDI * 2]   // (256 * 2) * 3
{$ENDIF ~ X64}
  MOVZX     EDI,        AH
{$IF DEFINED(X64)}
  XOR       BX,         [RBP + $0400 + RDI * 2]     // (256 * 2) * 2
{$ELSE ~ X86}
  XOR       BX,         [EBP + $0400 + EDI * 2]     // (256 * 2) * 2
{$ENDIF ~ X64}
  SHR       EAX,        16
  MOVZX     EDI,        AL
{$IF DEFINED(X64)}
  XOR       BX,         [RBP + $0200 + RDI * 2]     // (256 * 2) * 1
{$ELSE ~ X86}
  XOR       BX,         [EBP + $0200 + EDI * 2]     // (256 * 2) * 1
{$ENDIF ~ X64}
  MOVZX     EDI,        AH
{$IF DEFINED(X64)}
  XOR       BX,         [RBP + RDI * 2]             // (256 * 2) * 0
{$ELSE ~ X86}
  XOR       BX,         [EBP + EDI * 2]             // (256 * 2) * 0
{$ENDIF ~ X64}

  MOVZX     EDI,        DL
{$IF DEFINED(X64)}
  XOR       BX,         [RBP + $0E00 + RDI * 2]     // (256 * 2) * 7
{$ELSE ~ X86}
  XOR       BX,         [EBP + $0E00 + EDI * 2]     // (256 * 2) * 7
{$ENDIF ~ X64}
  MOVZX     EDI,        DH
{$IF DEFINED(X64)}
  XOR       BX,         [RBP + $0C00 + RDI * 2]     // (256 * 2) * 6
{$ELSE ~ X86}
  XOR       BX,         [EBP + $0C00 + EDI * 2]     // (256 * 2) * 6
{$ENDIF ~ X64}
  SHR       EDX,        16
  MOVZX     EDI,        DL
{$IF DEFINED(X64)}
  XOR       BX,         [RBP + $0A00 + RDI * 2]     // (256 * 2) * 5
{$ELSE ~ X86}
  XOR       BX,         [EBP + $0A00 + EDI * 2]     // (256 * 2) * 5
{$ENDIF ~ X64}
  MOVZX     EDI,        DH
{$IF DEFINED(X64)}
  XOR       BX,         [RBP + $0800 + RDI * 2]     // (256 * 2) * 4
{$ELSE ~ X86}
  XOR       BX,         [EBP + $0800 + EDI * 2]     // (256 * 2) * 4
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
  MOV       DX,         [RBP + $0600 + RDI * 2]     // (256 * 2) * 3
{$ELSE ~ X86}
  MOV       DX,         [EBP + $0600 + EDI * 2]     // (256 * 2) * 3
{$ENDIF ~ X64}
  MOVZX     EDI,        AH
{$IF DEFINED(X64)}
  XOR       DX,         [RBP + $0400 + RDI * 2]     // (256 * 2) * 2
{$ELSE ~ X86}
  XOR       DX,         [EBP + $0400 + EDI * 2]     // (256 * 2) * 2
{$ENDIF ~ X64}
  SHR       EAX,        16
  MOVZX     EDI,        AL
{$IF DEFINED(X64)}
  XOR       DX,         [RBP + $0200 + RDI * 2]     // (256 * 2) * 1
{$ELSE ~ X86}
  XOR       DX,         [EBP + $0200 + EDI * 2]     // (256 * 2) * 1
{$ENDIF ~ X64}
  MOVZX     EDI,        AH
{$IF DEFINED(X64)}
  XOR       DX,         [RBP + RDI * 2]             // (256 * 2) * 0
{$ELSE ~ X86}
  XOR       DX,         [EBP + EDI * 2]             // (256 * 2) * 0
{$ENDIF ~ X64}

  MOVZX     EDI,        BL
{$IF DEFINED(X64)}
  XOR       DX,         [RBP + $0E00 + RDI * 2]     // (256 * 2) * 7
{$ELSE ~ X86}
  XOR       DX,         [EBP + $0E00 + EDI * 2]     // (256 * 2) * 7
{$ENDIF ~ X64}
  MOVZX     EDI,        BH
{$IF DEFINED(X64)}
  XOR       DX,         [RBP + $0C00 + RDI * 2]     // (256 * 2) * 6
{$ELSE ~ X86}
  XOR       DX,         [EBP + $0C00 + EDI * 2]     // (256 * 2) * 6
{$ENDIF ~ X64}
  SHR       EBX,        16
  MOVZX     EDI,        BL
{$IF DEFINED(X64)}
  XOR       DX,         [RBP + $0A00 + RDI * 2]     // (256 * 2) * 5
{$ELSE ~ X86}
  XOR       DX,         [EBP + $0A00 + EDI * 2]     // (256 * 2) * 5
{$ENDIF ~ X64}
  MOVZX     EDI,        BH
{$IF DEFINED(X64)}
  XOR       DX,         [RBP + $0800 + RDI * 2]     // (256 * 2) * 4
{$ELSE ~ X86}
  XOR       DX,         [EBP + $0800 + EDI * 2]     // (256 * 2) * 4
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
procedure TchCrc16.Calculate(var Current: Word; const Data: Pointer; const Length: Cardinal);
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

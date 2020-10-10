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
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC16,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.CRC16Bits;

type

{ TchCrc16 }

  TchCrc16 = class(TchCrc16Bits{$IF DEFINED(SUPPORTS_INTERFACES)}, IchCrc16{$ENDIF})
  strict private const
    Size       = Byte(16);
    BLOCK_SIZE = Byte($04);
  strict protected
    constructor Create(const Name: string; const Polynomial, Init, XorOut, Check: Word;
      const RefIn, RefOut: Boolean); reintroduce;
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

{ TchCrc16 }

constructor TchCrc16.Create(const Name: string; const Polynomial, Init, XorOut, Check: Word;
  const RefIn, RefOut: Boolean);
begin
  inherited Create(Name, TchCrc16.Size, Polynomial, Init, XorOut, Check, RefIn, RefOut, TchCrc16.BLOCK_SIZE);
end;

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
  XOR       EDX,        [RSI + RCX - $04]
{$ELSE ~ X86}
  XOR       EDX,        [ESI + ECX - $04]
{$ENDIF ~ X64}

  MOVZX     EDI,        DL
{$IF DEFINED(X64)}
  MOVZX     EBX, WORD PTR [RBP + $0600 + RDI * 2]   // (256 * 2) * 3
{$ELSE ~ X86}
  MOVZX     EBX, WORD PTR [EBP + $0600 + EDI * 2]   // (256 * 2) * 3
{$ENDIF ~ X64}
  MOVZX     EDI,        DH
{$IF DEFINED(X64)}
  XOR       BX,         [RBP + $0400 + RDI * 2]     // (256 * 2) * 2
{$ELSE ~ X86}
  XOR       BX,         [EBP + $0400 + EDI * 2]     // (256 * 2) * 2
{$ENDIF ~ X64}
  SHR       EDX,        16
  MOVZX     EDI,        DL
{$IF DEFINED(X64)}
  XOR       BX,         [RBP + $0200 + RDI * 2]     // (256 * 2) * 1
{$ELSE ~ X86}
  XOR       BX,         [EBP + $0200 + EDI * 2]     // (256 * 2) * 1
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
  XOR       EBX,        [RSI + RCX - $04]
{$ELSE ~ X86}
  XOR       EBX,        [ESI + ECX - $04]
{$ENDIF ~ X64}

  MOVZX     EDI,        BL
{$IF DEFINED(X64)}
  MOV       DX,         [RBP + $0600 + RDI * 2]     // (256 * 2) * 3
{$ELSE ~ X86}
  MOV       DX,         [EBP + $0600 + EDI * 2]     // (256 * 2) * 3
{$ENDIF ~ X64}
  MOVZX     EDI,        BH
{$IF DEFINED(X64)}
  XOR       DX,         [RBP + $0400 + RDI * 2]     // (256 * 2) * 2
{$ELSE ~ X86}
  XOR       DX,         [EBP + $0400 + EDI * 2]     // (256 * 2) * 2
{$ENDIF ~ X64}
  SHR       EBX,        16
  MOVZX     EDI,        BL
{$IF DEFINED(X64)}
  XOR       DX,         [RBP + $0200 + RDI * 2]     // (256 * 2) * 1
{$ELSE ~ X86}
  XOR       DX,         [EBP + $0200 + EDI * 2]     // (256 * 2) * 1
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
procedure TchCrc16.Calculate(var Current: Word; const Data: Pointer; const Length: Cardinal);
begin
  if (Data = nil) or (Length = 0) then Exit;

  var L := Length;

  var PData: PCardinal := Data;
  while L >= TchCrc16.BLOCK_SIZE do
  begin
    const Block = PData^ xor Current;
    Inc(PData);

    Current :=
      FCrcTable[0, Byte(Block shr (BitsPerByte * 3))] xor
      FCrcTable[1, Byte(Block shr (BitsPerByte * 2))] xor
      FCrcTable[2, Byte(Block shr  BitsPerByte)]      xor
      FCrcTable[3, Byte(Block)];

    Dec(L, TchCrc16.BLOCK_SIZE);
  end;

  inherited Calculate(Current, PData, L);
end;
{$ENDIF ~ USE_ASSEMBLER}

end.

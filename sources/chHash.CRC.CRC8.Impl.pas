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

unit chHash.CRC.CRC8.Impl;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC8,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.CRC8Bits;

type

{ TchCrc8 }

  TchCrc8 = class(TchCrc8Bits{$IF DEFINED(SUPPORTS_INTERFACES)}, IchCrc8{$ENDIF})
  strict private const
    Size = Byte(8);
    BLOCK_SIZE = Byte($02);
  strict protected
    constructor Create(const Name: string; const Polynomial, Init, XorOut, Check: Byte;
      const RefIn, RefOut: Boolean); reintroduce;
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
  inherited Create(Name, TchCrc8.Size, Polynomial, Init, XorOut, Check, RefIn, RefOut, TchCrc8.BLOCK_SIZE);
end;

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
  MOVZX     EBX,        [RBP + $0100 + RDI]         // (256 * 1) * 1
{$ELSE ~ X86}
  MOVZX     EBX,        [EBP + $0100 + EDI]         // (256 * 1) * 1
{$ENDIF ~ X64}
  MOVZX     EDI,        DH
{$IF DEFINED(X64)}
  XOR       BL,         [RBP + RDI]                 // (256 * 1) * 0
{$ELSE ~ X86}
  XOR       BL,         [EBP + EDI]                 // (256 * 1) * 0
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
  MOVZX     EDX,        [RBP + $0100 + RDI]         // (256 * 1) * 1
{$ELSE ~ X86}
  MOVZX     EDX,        [EBP + $0100 + EDI]         // (256 * 1) * 1
{$ENDIF ~ X64}
  MOVZX     EDI,        BH
{$IF DEFINED(X64)}
  XOR       DL,         [RBP + RDI]                 // (256 * 1) * 0
{$ELSE ~ X86}
  XOR       DL,         [EBP + EDI]                 // (256 * 1) * 0
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

  var PData: PWord := Data;
  while L >= TchCrc8.BLOCK_SIZE do
  begin
    const Block = PData^ xor Current;
    Inc(PData);

    Current :=
      FCrcTable[0, Byte(Block shr  BitsPerByte)] xor
      FCrcTable[1, Byte(Block)];

    Dec(L, TchCrc8.BLOCK_SIZE);
  end;

  inherited Calculate(Current, PData, L);
end;
{$ENDIF ~ USE_ASSEMBLER}

end.

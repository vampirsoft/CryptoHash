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

unit chHash.Core.Bits;

{$INCLUDE CryptoHash.inc}

{$IF NOT DEFINED(CPUX64) AND DEFINED(USE_FORCE_DELPHI)}
  {$DEFINE USE_FORCE_DELPHI_X86}
{$ENDIF ~ NOT CPUX64 OR NOT USE_FORCE_DELPHI}

{$IF NOT DEFINED(CPUX64) AND DEFINED(USE_ASSEMBLER)}
  {$DEFINE LARGE_INT_SPLIT}
{$ENDIF ~ NOT CPUX64 OR USE_FORCE_DELPHI}

interface

uses
  System.SysUtils,
{$IF DEFINED(USE_JEDI_CORE_LIBRARY)}
  JclLogic,
{$ENDIF ~ USE_JEDI_CORE_LIBRARY}
  chHash.Core;

const
{$IF NOT DEFINED(USE_JEDI_CORE_LIBRARY)}
  BitsPerNibble        = Byte(4);
  BitsPerByte          = Byte(8);
  BitsPerShortInt      = Byte(SizeOf(ShortInt)   * BitsPerByte);
  BitsPerWord          = Byte(SizeOf(Word)       * BitsPerByte);
  BitsPerSmallInt      = Byte(SizeOf(SmallInt)   * BitsPerByte);
  BitsPerCardinal      = Byte(SizeOf(Cardinal)   * BitsPerByte);
  BitsPerInteger       = Byte(SizeOf(Integer)    * BitsPerByte);
  BitsPerInt64         = Byte(SizeOf(Int64)      * BitsPerByte);
{$ENDIF ~ NOT USE_JEDI_CORE_LIBRARY}
  BitsPerUInt64        = Byte(SizeOf(UInt64)     * BitsPerByte);
  BitsPerNativeUInt    = Byte(SizeOf(NativeUInt) * BitsPerByte);
  BitsPerNativeInt     = Byte(SizeOf(NativeInt)  * BitsPerByte);

{$IF NOT DEFINED(USE_JEDI_CORE_LIBRARY)}
  NibblesPerByte       = Byte(BitsPerByte div BitsPerNibble);
  NibblesPerShortInt   = Byte(SizeOf(ShortInt)   * NibblesPerByte);
  NibblesPerWord       = Byte(SizeOf(Word)       * NibblesPerByte);
  NibblesPerSmallInt   = Byte(SizeOf(SmallInt)   * NibblesPerByte);
  NibblesPerCardinal   = Byte(SizeOf(Cardinal)   * NibblesPerByte);
  NibblesPerInteger    = Byte(SizeOf(Integer)    * NibblesPerByte);
  NibblesPerInt64      = Byte(SizeOf(Int64)      * NibblesPerByte);
{$ENDIF ~ NOT USE_JEDI_CORE_LIBRARY}
  NibblesPerUInt64     = Byte(SizeOf(UInt64)     * NibblesPerByte);
  NibblesPerNativeUInt = Byte(SizeOf(NativeUInt) * NibblesPerByte);
  NibblesPerNativeInt  = Byte(SizeOf(NativeInt)  * NibblesPerByte);

{$IF NOT DEFINED(USE_JEDI_CORE_LIBRARY)}
  NibbleMask           = Byte($F);
  ByteMask             = Byte($FF);
  ShortIntMask         = ShortInt($FF);
  WordMask             = Word($FFFF);
  SmallIntMask         = SmallInt($FFFF);
  CardinalMask         = Cardinal($FFFFFFFF);
  IntegerMask          = Integer($FFFFFFFF);
  Int64Mask            = Int64($FFFFFFFFFFFFFFFF);
{$ENDIF ~ NOT USE_JEDI_CORE_LIBRARY}
  UInt64Mask           = UInt64($FFFFFFFFFFFFFFFF);
  NativeUIntMask       = NativeUInt($FFFFFFFFFFFFFFFF);
  NativeIntMask        = NativeInt($FFFFFFFFFFFFFFFF);

{$REGION 'Not use JEDI Core Library'}
{$IF NOT DEFINED(USE_JEDI_CORE_LIBRARY)}
function ReverseBits(const Value: Byte): Byte; overload;{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}
function ReverseBits(const Value: ShortInt): ShortInt; overload;{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}
function ReverseBits(const Value: Word): Word; overload;{$IF DEFINED(USE_INLINE) AND DEFINED(USE_FORCE_DELPHI_X86)}inline;{$ENDIF}
function ReverseBits(const Value: SmallInt): SmallInt; overload;{$IF DEFINED(USE_INLINE) AND DEFINED(USE_FORCE_DELPHI_X86)}inline;{$ENDIF}
function ReverseBits(const Value: Cardinal): Cardinal; overload;
function ReverseBits(const Value: Integer): Integer; overload;
function ReverseBits(const Value: Int64): Int64; overload;{$IF DEFINED(USE_INLINE) AND DEFINED(LARGE_INT_SPLIT)}inline;{$ENDIF}
procedure ReverseBits(const Address: Pointer; const Length: NativeUInt); overload;{$IF DEFINED(USE_INLINE) AND NOT DEFINED(CPUX64)}inline;{$ENDIF}
{$ENDIF ~ NOT USE_JEDI_CORE_LIBRARY}
{$ENDREGION 'Not use JEDI Core Library'}
function ReverseBits(const Value: UInt64): UInt64; overload;{$IF DEFINED(USE_INLINE) AND DEFINED(LARGE_INT_SPLIT) AND NOT DEFINED(USE_JEDI_CORE_LIBRARY)}inline;{$ENDIF}
function ReverseBits(const Value: NativeUInt): NativeUInt; overload;{$IF DEFINED(USE_JEDI_CORE_LIBRARY) AND NOT DEFINED(CPUX64)}inline;{$ENDIF}
function ReverseBits(const Value: NativeInt): NativeInt; overload;{$IF DEFINED(USE_JEDI_CORE_LIBRARY) AND NOT DEFINED(CPUX64)}inline;{$ENDIF}
procedure ReverseBits(var Bytes: TBytes; const Length: NativeUInt); overload;{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}

{$REGION 'Not use JEDI Core Library'}
{$IF NOT DEFINED(USE_JEDI_CORE_LIBRARY)}
function ReverseBytes(const Value: Word): Word; overload;{$IF DEFINED(USE_INLINE) AND NOT DEFINED(CPUX64)}inline;{$ENDIF}
function ReverseBytes(const Value: SmallInt): SmallInt; overload;{$IF DEFINED(USE_INLINE) AND NOT DEFINED(CPUX64)}inline;{$ENDIF}
function ReverseBytes(const Value: Cardinal): Cardinal; overload;{$IF DEFINED(USE_INLINE) AND DEFINED(USE_FORCE_DELPHI_X86)}inline;{$ENDIF}
function ReverseBytes(const Value: Integer): Integer; overload;{$IF DEFINED(USE_INLINE) AND DEFINED(USE_FORCE_DELPHI_X86)}inline;{$ENDIF}
function ReverseBytes(const Value: Int64): Int64; overload;{$IF DEFINED(USE_INLINE) AND DEFINED(USE_FORCE_DELPHI_X86)}inline;{$ENDIF}
procedure ReverseBytes(const Address: Pointer; const Length: NativeUInt); overload;{$IF DEFINED(USE_INLINE) AND NOT DEFINED(CPUX64)}inline;{$ENDIF}
{$ENDIF ~ NOT USE_JEDI_CORE_LIBRARY}
{$ENDREGION 'Not use JEDI Core Library'}
function ReverseBytes(const Value: UInt64): UInt64; overload;{$IF DEFINED(USE_INLINE) AND DEFINED(USE_FORCE_DELPHI_X86)}inline;{$ENDIF}
function ReverseBytes(const Value: NativeUInt): NativeUInt; overload;{$IF DEFINED(USE_INLINE) AND DEFINED(USE_FORCE_DELPHI_X86)}inline;{$ENDIF}
function ReverseBytes(const Value: NativeInt): NativeInt; overload;{$IF DEFINED(USE_INLINE) AND DEFINED(USE_FORCE_DELPHI_X86)}inline;{$ENDIF}
procedure ReverseBytes(var Bytes: TBytes; const Length: NativeUInt); overload;{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}

{$REGION 'Not use JEDI Core Library'}
{$IF NOT DEFINED(USE_JEDI_CORE_LIBRARY)}
function TestBit(const Value, Bit: Byte): Boolean; overload;{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}
function TestBit(const Value: ShortInt; const Bit: Byte): Boolean; overload;{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}
function TestBit(const Value: Word; const Bit: Byte): Boolean; overload;{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}
function TestBit(const Value: SmallInt; const Bit: Byte): Boolean; overload;{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}
function TestBit(const Value: Cardinal; const Bit: Byte): Boolean; overload;{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}
function TestBit(const Value: Integer; const Bit: Byte): Boolean; overload;{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}
function TestBit(const Value: Int64; const Bit: Byte): Boolean; overload;{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}
function TestBitBuffer(const Buffer; const Bit: NativeUInt): Boolean; overload;{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}
{$ENDIF ~ NOT USE_JEDI_CORE_LIBRARY}
{$ENDREGION 'Not use JEDI Core Library'}
function TestBit(const Value: UInt64; const Bit: Byte): Boolean; overload;{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}
function TestBit(const Value: NativeUInt; const Bit: Byte): Boolean; overload;{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}
function TestBit(const Value: NativeInt; const Bit: Byte): Boolean; overload;{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}
function TestBit(const Address: Pointer; const Bit: NativeUInt): Boolean; overload;{$IF DEFINED(USE_INLINE) AND DEFINED(USE_FORCE_DELPHI)}inline;{$ENDIF}
function TestBit(const Bytes: TBytes; const Bit: NativeUInt): Boolean; overload;{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}

function ToBytes(const Value: Byte): TBytes; overload;
function ToBytes(const Value: ShortInt): TBytes; overload;
function ToBytes(const Value: Word): TBytes; overload;
function ToBytes(const Value: SmallInt): TBytes; overload;
function ToBytes(const Value: Cardinal): TBytes; overload;
function ToBytes(const Value: Integer): TBytes; overload;
function ToBytes(const Value: UInt64): TBytes; overload;
function ToBytes(const Value: Int64): TBytes; overload;
function ToBytes(const Value: NativeUInt): TBytes; overload;
function ToBytes(const Value: NativeInt): TBytes; overload;
function ToBytes(const Value; const Length: NativeUInt): TBytes; overload;
function ToBytes(const Address: Pointer; const Length: NativeUInt): TBytes; overload;

{$REGION 'Primitive helpers'}
type

{ TByteHelper }

  TByteHelper = record helper for Byte
  private type
    TNibble = record
    public const
      Bits = Byte(BitsPerNibble);
      Mask = Byte(NibbleMask);
    end;
  public const
    Size    = Byte(SizeOf(Byte));
    Bits    = Byte(BitsPerByte);
    Nibbles = Byte(NibblesPerByte);
    Mask    = Byte(ByteMask);
  {$IF NOT DEFINED(USE_JEDI_CORE_LIBRARY)}
  private type
    TReverse = record
    private const
      FTable: array [Byte] of Byte = (
        $00, $80, $40, $C0, $20, $A0, $60, $E0, $10, $90, $50, $D0, $30, $B0, $70, $F0,
        $08, $88, $48, $C8, $28, $A8, $68, $E8, $18, $98, $58, $D8, $38, $B8, $78, $F8,
        $04, $84, $44, $C4, $24, $A4, $64, $E4, $14, $94, $54, $D4, $34, $B4, $74, $F4,
        $0C, $8C, $4C, $CC, $2C, $AC, $6C, $EC, $1C, $9C, $5C, $DC, $3C, $BC, $7C, $FC,
        $02, $82, $42, $C2, $22, $A2, $62, $E2, $12, $92, $52, $D2, $32, $B2, $72, $F2,
        $0A, $8A, $4A, $CA, $2A, $AA, $6A, $EA, $1A, $9A, $5A, $DA, $3A, $BA, $7A, $FA,
        $06, $86, $46, $C6, $26, $A6, $66, $E6, $16, $96, $56, $D6, $36, $B6, $76, $F6,
        $0E, $8E, $4E, $CE, $2E, $AE, $6E, $EE, $1E, $9E, $5E, $DE, $3E, $BE, $7E, $FE,
        $01, $81, $41, $C1, $21, $A1, $61, $E1, $11, $91, $51, $D1, $31, $B1, $71, $F1,
        $09, $89, $49, $C9, $29, $A9, $69, $E9, $19, $99, $59, $D9, $39, $B9, $79, $F9,
        $05, $85, $45, $C5, $25, $A5, $65, $E5, $15, $95, $55, $D5, $35, $B5, $75, $F5,
        $0D, $8D, $4D, $CD, $2D, $AD, $6D, $ED, $1D, $9D, $5D, $DD, $3D, $BD, $7D, $FD,
        $03, $83, $43, $C3, $23, $A3, $63, $E3, $13, $93, $53, $D3, $33, $B3, $73, $F3,
        $0B, $8B, $4B, $CB, $2B, $AB, $6B, $EB, $1B, $9B, $5B, $DB, $3B, $BB, $7B, $FB,
        $07, $87, $47, $C7, $27, $A7, $67, $E7, $17, $97, $57, $D7, $37, $B7, $77, $F7,
        $0F, $8F, $4F, $CF, $2F, $AF, $6F, $EF, $1F, $9F, $5F, $DF, $3F, $BF, $7F, $FF
      );
    end;
  {$ENDIF ~ NOT USE_JEDI_CORE_LIBRARY}
  public
    function ReverseBits: Byte;{$IF DEFINED(USE_INLINE) AND NOT DEFINED(USE_JEDI_CORE_LIBRARY)}inline;{$ENDIF}
    function TestBit(const Bit: Byte): Boolean;{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}
    function ToBytes: TBytes;{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}
  end;

{ TShortIntHelper }

  TShortIntHelper = record helper for ShortInt
  public const
    Size    = Byte(SizeOf(ShortInt));
    Bits    = Byte(BitsPerShortInt);
    Nibbles = Byte(NibblesPerShortInt);
    Mask    = ShortInt(ShortIntMask);
  public
    function ReverseBits: ShortInt;{$IF DEFINED(USE_INLINE) AND NOT DEFINED(USE_JEDI_CORE_LIBRARY)}inline;{$ENDIF}
    function TestBit(const Bit: Byte): Boolean;{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}
    function ToBytes: TBytes;{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}
  end;

{ TWordHelper }

  TWordHelper = record helper for Word
  public const
    Size    = Byte(SizeOf(Word));
    Bits    = Byte(BitsPerWord);
    Nibbles = Byte(NibblesPerWord);
    Mask    = Word(WordMask);
  public
    function ReverseBits: Word;
    function ReverseBytes: Word;
    function TestBit(const Bit: Byte): Boolean;{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}
    function ToBytes: TBytes;{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}
  end;

{ TSmallIntHelper }

  TSmallIntHelper = record helper for SmallInt
  public const
    Size    = Byte(SizeOf(SmallInt));
    Bits    = Byte(BitsPerSmallInt);
    Nibbles = Byte(NibblesPerSmallInt);
    Mask    = SmallInt(SmallIntMask);
  public
    function ReverseBits: SmallInt;
    function ReverseBytes: SmallInt;
    function TestBit(const Bit: Byte): Boolean;{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}
    function ToBytes: TBytes;{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}
  end;

{ TCardinalHelper }

  TCardinalHelper = record helper for Cardinal
  public const
    Size    = Byte(SizeOf(Cardinal));
    Bits    = Byte(BitsPerCardinal);
    Nibbles = Byte(NibblesPerCardinal);
    Mask    = Cardinal(CardinalMask);
  public
    function ReverseBits: Cardinal;
    function ReverseBytes: Cardinal;
    function TestBit(const Bit: Byte): Boolean;{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}
    function ToBytes: TBytes;{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}
  end;

{ TIntegerHelper }

  TIntegerHelper = record helper for Integer
  public const
    Size    = Byte(SizeOf(Integer));
    Bits    = Byte(BitsPerInteger);
    Nibbles = Byte(NibblesPerInteger);
    Mask    = Integer(IntegerMask);
  public
    function ReverseBits: Integer;
    function ReverseBytes: Integer;
    function TestBit(const Bit: Byte): Boolean;{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}
    function ToBytes: TBytes;{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}
  end;

{ TUInt64Helper }

  TUInt64Helper = record helper for UInt64
  public const
    Size    = Byte(SizeOf(UInt64));
    Bits    = Byte(BitsPerUInt64);
    Nibbles = Byte(NibblesPerUInt64);
    Mask    = UInt64(UInt64Mask);
  public
    function ReverseBits: UInt64;
    function ReverseBytes: UInt64;
    function TestBit(const Bit: Byte): Boolean;{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}
    function ToBytes: TBytes;{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}
  end;

{ TInt64Helper }

  TInt64Helper = record helper for Int64
  public const
    Size    = Byte(SizeOf(Int64));
    Bits    = Byte(BitsPerInt64);
    Nibbles = Byte(NibblesPerInt64);
    Mask    = Int64(Int64Mask);
  public
    function ReverseBits: Int64;
    function ReverseBytes: Int64;
    function TestBit(const Bit: Byte): Boolean;{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}
    function ToBytes: TBytes;{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}
  end;

{ TNativeUIntHelper }

  TNativeUIntHelper = record helper for NativeUInt
  public const
    Size    = Byte(SizeOf(NativeUInt));
    Bits    = Byte(BitsPerNativeUInt);
    Nibbles = Byte(NibblesPerNativeUInt);
    Mask    = NativeUInt(NativeUIntMask);
  public
    function ReverseBits: NativeUInt;
    function ReverseBytes: NativeUInt;
    function TestBit(const Bit: Byte): Boolean;{$IF DEFINED(USE_FORCE_DELPHI)}inline;{$ENDIF}
    function ToBytes: TBytes;{$IF DEFINED(USE_FORCE_DELPHI)}inline;{$ENDIF}
  end;

{ TNativeIntHelper }

  TNativeIntHelper = record helper for NativeInt
  public const
    Size    = Byte(SizeOf(NativeInt));
    Bits    = Byte(BitsPerNativeInt);
    Nibbles = Byte(NibblesPerNativeInt);
    Mask    = NativeUInt(NativeIntMask);
  public
    function ReverseBits: NativeInt;
    function ReverseBytes: NativeInt;
    function TestBit(const Bit: Byte): Boolean;{$IF DEFINED(USE_FORCE_DELPHI)}inline;{$ENDIF}
    function ToBytes: TBytes;{$IF DEFINED(USE_FORCE_DELPHI)}inline;{$ENDIF}
  end;

  TPointerHelper = record helper for Pointer
  public
    procedure ReverseBits(const Length: NativeUInt); overload;
    procedure ReverseBytes(const Length: NativeUInt); overload;
    function TestBit(const Bit: NativeUInt): Boolean; overload;
    function ToBytes(const Length: NativeUInt): TBytes; overload;{$IF DEFINED(USE_FORCE_DELPHI)}inline;{$ENDIF}
  end;

const
  Nibble: TByteHelper.TNibble = ();
{$ENDREGION 'Primitive helpers'}

implementation

{$REGION 'ReverseBits'}
{$REGION 'Not use JEDI Core Library'}
{$IF NOT DEFINED(USE_JEDI_CORE_LIBRARY)}
function ReverseBits(const Value: Byte): Byte;
begin
  Result := TByteHelper.TReverse.FTable[Value];
end;

function ReverseBits(const Value: ShortInt): ShortInt;
begin
  Result := ReverseBits(Byte(Value));
end;

function ReverseBits(const Value: Word): Word;
type TReverse = TByteHelper.TReverse;
{$IF DEFINED(USE_ASSEMBLER)}
asm
{$IF DEFINED(CPUX64)}
  // Start
  // --> CX Value
  // <-- AX Result
  MOV       RAX,        $0
  MOV       R8,         offset TReverse.FTable  // address TReverse.FTable -> R8
  // Initialized
  MOVZX     R9,         CL
  MOV       AL,         [R8 + R9]
  MOV       AH,         AL
  MOV       CL,         CH
  MOVZX     R9,         CL
  MOV       AL,         [R8 + R9]
  // Finish
{$ELSE ~ CPUX86}
  // Start
  // --> AX Value
  // <-- AX Result
  MOV       EDX,        EAX   // Value -> EDX
  MOV       EAX,        $0
  // Initialized
  MOVZX     ECX,        DL
  ADD       ECX,        offset TReverse.FTable  // address TReverse.FTable + ECX
  MOV       AH,         [ECX]
  MOVZX     ECX,        DH
  ADD       ECX,        offset TReverse.FTable  // address TReverse.FTable + ECX
  MOV       AL,         [ECX]
  // Finish
{$ENDIF ~ CPUX64}
end;
{$ELSE ~ USE_FORCE_DELPHI}
const Size = Byte(SizeOf(Value));
begin
  Result := 0;
  var V := Value;
  for var I := 1 to Size do
  begin
    Result := (Result shl BitsPerByte) or TReverse.FTable[Byte(V)];
    V := V shr BitsPerByte;
  end;
end;
{$ENDIF ~ USE_ASSEMBLER}

function ReverseBits(const Value: SmallInt): SmallInt;
type TReverse = TByteHelper.TReverse;
{$IF DEFINED(USE_ASSEMBLER)}
asm
{$IF DEFINED(CPUX64)}
  // Start
  // --> CX Value
  // <-- AX Result
  MOV       RAX,        $0
  MOV       R8,         offset TReverse.FTable  // address TReverse.FTable -> R8
  // Initialized
  MOVZX     R9,         CL
  MOV       AL,         [R8 + R9]
  MOV       AH,         AL
  MOV       CL,         CH
  MOVZX     R9,         CL
  MOV       AL,         [R8 + R9]
  // Finish
{$ELSE ~ CPUX86}
  // Start
  // --> AX Value
  // <-- AX Result
  MOV       EDX,        EAX   // Value -> EDX
  MOV       EAX,        $0
  // Initialized
  MOVZX     ECX,        DL
  ADD       ECX,        offset TReverse.FTable  // address TReverse.FTable + ECX
  MOV       AH,         [ECX]
  MOVZX     ECX,        DH
  ADD       ECX,        offset TReverse.FTable  // address TReverse.FTable + ECX
  MOV       AL,         [ECX]
  // Finish
{$ENDIF ~ CPUX64}
end;
{$ELSE ~ USE_FORCE_DELPHI}
const Size = Byte(SizeOf(Value));
begin
  Result := 0;
  var V := Value;
  for var I := 1 to Size do
  begin
    Result := (Result shl BitsPerByte) or TReverse.FTable[Byte(V)];
    V := V shr BitsPerByte;
  end;
end;
{$ENDIF ~ USE_ASSEMBLER}

function ReverseBits(const Value: Cardinal): Cardinal;
const Size = Byte(SizeOf(Value));
type TReverse = TByteHelper.TReverse;
{$IF DEFINED(USE_ASSEMBLER)}
asm
{$IF DEFINED(CPUX64)}
  // Start
  // --> ECX Value
  // <-- EAX Result
  MOV       EDX,        ECX   // Value -> EDX
  MOV       RAX,        $0
  MOV       RCX,        Size
  MOV       R8,         offset TReverse.FTable  // address TReverse.FTable -> R8
  // Initialized
@Body:
  SHL       RAX,        BitsPerByte
  MOV       R9,         RDX
  AND       R9,         ByteMask
  MOV       AL,         [R8 + R9]
  SHR       RDX,        BitsPerByte
  LOOP      @Body
  // Finish
{$ELSE ~ CPUX86}
  PUSH      EBP
  PUSH      EBX
  // Start
  // --> EAX Value
  // <-- EAX Result
  MOV       EDX,        EAX   // Value -> EDX
  MOV       EAX,        $0
  MOV       ECX,        Size
  MOV       EBP,        offset TReverse.FTable  // address TReverse.FTable -> EBP
  // Initialized
@Body:
  SHL       EAX,        BitsPerByte
  MOV       EBX,        EDX
  AND       EBX,        ByteMask
  MOV       AL,         [EBP + EBX]
  SHR       EDX,        BitsPerByte
  LOOP      @Body
  // Finish
  POP       EBX
  POP       EBP
{$ENDIF ~ CPUX64}
end;
{$ELSE ~ USE_FORCE_DELPHI}
begin
  Result := 0;
  var V := Value;
  for var I := 1 to Size do
  begin
    Result := (Result shl BitsPerByte) or TReverse.FTable[Byte(V)];
    V := V shr BitsPerByte;
  end;
end;
{$ENDIF ~ USE_ASSEMBLER}

function ReverseBits(const Value: Integer): Integer;
const Size = Byte(SizeOf(Value));
type TReverse = TByteHelper.TReverse;
{$IF DEFINED(USE_ASSEMBLER)}
asm
{$IF DEFINED(CPUX64)}
  // Start
  // --> ECX Value
  // <-- EAX Result
  MOV       EDX,        ECX   // Value -> EDX
  MOV       RAX,        $0
  MOV       RCX,        Size
  MOV       R8,         offset TReverse.FTable  // address TReverse.FTable -> R8
  // Initialized
@Body:
  SHL       RAX,        BitsPerByte
  MOV       R9,         RDX
  AND       R9,         ByteMask
  MOV       AL,         [R8 + R9]
  SHR       RDX,        BitsPerByte
  LOOP      @Body
  // Finish
{$ELSE ~ CPUX86}
  PUSH      EBP
  PUSH      EBX
  // Start
  // --> EAX Value
  // <-- EAX Result
  MOV       EDX,        EAX   // Value -> EDX
  MOV       EAX,        $0
  MOV       ECX,        Size
  MOV       EBP,        offset TReverse.FTable  // address TReverse.FTable -> EBP
  // Initialized
@Body:
  SHL       EAX,        BitsPerByte
  MOV       EBX,        EDX
  AND       EBX,        ByteMask
  MOV       AL,         [EBP + EBX]
  SHR       EDX,        BitsPerByte
  LOOP      @Body
  // Finish
  POP       EBX
  POP       EBP
{$ENDIF ~ CPUX64}
end;
{$ELSE ~ USE_FORCE_DELPHI}
begin
  Result := 0;
  var V := Value;
  for var I := 1 to Size do
  begin
    Result := (Result shl BitsPerByte) or TReverse.FTable[Byte(V)];
    V := V shr BitsPerByte;
  end;
end;
{$ENDIF ~ USE_ASSEMBLER}

function ReverseBits(const Value: Int64): Int64;
{$IF DEFINED(CPUX64)}
const Size = Byte(SizeOf(Value));
type TReverse = TByteHelper.TReverse;
{$IF DEFINED(USE_ASSEMBLER)}
asm
  // Start
  // --> RCX Value
  // <-- RAX Result
  MOV       RDX,        RCX   // Value -> RDX
  MOV       RAX,        $0
  MOV       RCX,        Size
  MOV       R8,         offset TReverse.FTable  // address TReverse.FTable -> R8
  // Initialized
@Body:
  SHL       RAX,        BitsPerByte
  MOV       R9,         RDX
  AND       R9,         ByteMask
  MOV       AL,         [R8 + R9]
  SHR       RDX,        BitsPerByte
  LOOP      @Body
end;
{$ELSE ~ USE_FORCE_DELPHI}
begin
  Result := 0;
  var V := Value;
  for var I := 1 to Size do
  begin
    Result := (Result shl BitsPerByte) or TReverse.FTable[Byte(V)];
    V := V shr BitsPerByte;
  end;
end;
{$ENDIF ~ USE_ASSEMBLER}
{$ELSE ~ CPUX86}
begin
  TLargeInteger(Result).LowPart := ReverseBits(TLargeInteger(Value).HighPart);
  TLargeInteger(Result).HighPart := ReverseBits(TLargeInteger(Value).LowPart);
end;
{$ENDIF ~ CPUX64}

procedure ReverseBits(const Address: Pointer; const Length: NativeUInt);
type TReverse = TByteHelper.TReverse;
begin
  if (Address = nil) or (Length < 1) then Exit;

  var P1: PByte := Address;
  var P2: PByte := Address;
  Inc(P2, Length - 1);
  while NativeUInt(P1) < NativeUInt(P2) do
  begin
    const V = TReverse.FTable[P1^];
    P1^ := TReverse.FTable[P2^];
    P2^ := V;
    Inc(P1);
    Dec(P2);
  end;
  if P1 = P2 then P1^ := TReverse.FTable[P1^];
end;
{$ENDIF ~ NOT USE_JEDI_CORE_LIBRARY}
{$ENDREGION 'Not use JEDI Core Library'}

function ReverseBits(const Value: UInt64): UInt64;
{$IF DEFINED(USE_JEDI_CORE_LIBRARY)}
begin
  Result := JclLogic.ReverseBits(Int64(Value));
end;
{$ELSE ~ NOT USE_JEDI_CORE_LIBRARY}
{$IF DEFINED(CPUX64)}
const Size = Byte(SizeOf(Value));
type TReverse = TByteHelper.TReverse;
{$IF DEFINED(USE_ASSEMBLER)}
asm
  // Start
  // --> RCX Value
  // <-- RAX Result
  MOV       RDX,        RCX   // Value -> RDX
  MOV       RAX,        $0
  MOV       RCX,        Size
  MOV       R8,         offset TReverse.FTable  // address TReverse.FTable -> R8
  // Initialized
@Body:
  SHL       RAX,        BitsPerByte
  MOV       R9,         RDX
  AND       R9,         ByteMask
  MOV       AL,         [R8 + R9]
  SHR       RDX,        BitsPerByte
  LOOP      @Body
  // Finish
end;
{$ELSE ~ USE_FORCE_DELPHI}
begin
  Result := 0;
  var V := Value;
  for var I := 1 to Size do
  begin
    Result := (Result shl BitsPerByte) or TReverse.FTable[Byte(V)];
    V := V shr BitsPerByte;
  end;
end;
{$ENDIF ~ USE_ASSEMBLER}
{$ELSE ~ CPUX86}
begin
  TULargeInteger(Result).LowPart := ReverseBits(TULargeInteger(Value).HighPart);
  TULargeInteger(Result).HighPart := ReverseBits(TULargeInteger(Value).LowPart);
end;
{$ENDIF ~ CPUX64}
{$ENDIF ~ USE_JEDI_CORE_LIBRARY}

function ReverseBits(const Value: NativeUInt): NativeUInt;
{$IF DEFINED(USE_JEDI_CORE_LIBRARY)}
begin
  Result := JclLogic.ReverseBits({$IF DEFINED(CPUX64)}Int64{$ELSE}Cardinal{$ENDIF}(Value));
end;
{$ELSE ~ NOT USE_JEDI_CORE_LIBRARY}
const Size = Byte(SizeOf(Value));
type TReverse = TByteHelper.TReverse;
{$IF DEFINED(USE_ASSEMBLER)}
asm
{$IF DEFINED(CPUX64)}
  // Start
  // --> RCX Value
  // <-- EAX Result
  MOV       RDX,        RCX   // Value -> RDX
  MOV       RAX,        $0
  MOV       RCX,        Size
  MOV       R8,         offset TReverse.FTable  // address TReverse.FTable -> R8
  // Initialized
@Body:
  SHL       RAX,        BitsPerByte
  MOV       R9,         RDX
  AND       R9,         ByteMask
  MOV       AL,         [R8 + R9]
  SHR       RDX,        BitsPerByte
  LOOP      @Body
  // Finish
{$ELSE ~ CPUX86}
  PUSH      EBP
  PUSH      EBX
  // Start
  // --> EAX Value
  // <-- EAX Result
  MOV       EDX,        EAX   // Value -> EDX
  MOV       EAX,        $0
  MOV       ECX,        Size
  MOV       EBP,        offset TReverse.FTable  // address TReverse.FTable -> EBP
  // Initialized
@Body:
  SHL       EAX,        BitsPerByte
  MOV       EBX,        EDX
  AND       EBX,        ByteMask
  MOV       AL,         [EBP + EBX]
  SHR       EDX,        BitsPerByte
  LOOP      @Body
  // Finish
  POP       EBX
  POP       EBP
{$ENDIF ~ CPUX64}
end;
{$ELSE ~ USE_FORCE_DELPHI}
begin
  Result := 0;
  var V := Value;
  for var I := 1 to Size do
  begin
    Result := (Result shl BitsPerByte) or TReverse.FTable[Byte(V)];
    V := V shr BitsPerByte;
  end;
end;
{$ENDIF ~ USE_ASSEMBLER}
{$ENDIF ~ USE_JEDI_CORE_LIBRARY}

function ReverseBits(const Value: NativeInt): NativeInt;
{$IF DEFINED(USE_JEDI_CORE_LIBRARY)}
begin
  Result := JclLogic.ReverseBits({$IF DEFINED(CPUX64)}Int64{$ELSE}Integer{$ENDIF}(Value));
end;
{$ELSE ~ NOT USE_JEDI_CORE_LIBRARY}
const Size = Byte(SizeOf(Value));
type TReverse = TByteHelper.TReverse;
{$IF DEFINED(USE_ASSEMBLER)}
asm
{$IF DEFINED(CPUX64)}
  // Start
  // --> RCX Value
  // <-- EAX Result
  MOV       RDX,        RCX   // Value -> RDX
  MOV       RAX,        $0
  MOV       RCX,        Size
  MOV       R8,         offset TReverse.FTable  // address TReverse.FTable -> R8
  // Initialized
@Body:
  SHL       RAX,        BitsPerByte
  MOV       R9,         RDX
  AND       R9,         ByteMask
  MOV       AL,         [R8 + R9]
  SHR       RDX,        BitsPerByte
  LOOP      @Body
{$ELSE ~ CPUX86}
  PUSH      EBP
  PUSH      EBX
  // Start
  // --> EAX Value
  // <-- EAX Result
  MOV       EDX,        EAX   // Value -> EDX
  MOV       EAX,        $0
  MOV       ECX,        Size
  MOV       EBP,        offset TReverse.FTable  // address TReverse.FTable -> EBP
  // Initialized
@Body:
  SHL       EAX,        BitsPerByte
  MOV       EBX,        EDX
  AND       EBX,        ByteMask
  MOV       AL,         [EBP + EBX]
  SHR       EDX,        BitsPerByte
  LOOP      @Body
  // Finish
  POP       EBX
  POP       EBP
{$ENDIF ~ CPUX64}
end;
{$ELSE ~ USE_FORCE_DELPHI}
begin
  Result := 0;
  var V := Value;
  for var I := 1 to Size do
  begin
    Result := (Result shl BitsPerByte) or TReverse.FTable[Byte(V)];
    V := V shr BitsPerByte;
  end;
end;
{$ENDIF ~ USE_ASSEMBLER}
{$ENDIF ~ USE_JEDI_CORE_LIBRARY}

procedure ReverseBits(var Bytes: TBytes; const Length: NativeUInt);
begin
  ReverseBits(@Bytes[0], Length);
end;
{$ENDREGION 'ReverseBits'}

{$REGION 'ReverseBytes'}
{$REGION 'Not use JEDI Core Library'}
{$IF NOT DEFINED(USE_JEDI_CORE_LIBRARY)}
function ReverseBytes(const Value: Word): Word; overload;
{$IF DEFINED(CPUX64) AND DEFINED(USE_ASSEMBLER)}
asm
  // Start
  // --> CX Value
  // <-- AX Result
  MOV       AH,         CL
  MOV       AL,         CH
  // Initialized
  // Finish
end;
{$ELSE ~ CPUX86 OR USE_FORCE_DELPHI}
begin
  Result := (Value shl BitsPerByte) or (Value shr BitsPerByte);
end;
{$ENDIF ~ CPUX64 AND USE_ASSEMBLER}

function ReverseBytes(const Value: SmallInt): SmallInt; overload;
{$IF DEFINED(CPUX64) AND DEFINED(USE_ASSEMBLER)}
asm
  // Start
  // --> CX Value
  // <-- AX Result
  MOV       AH,         CL
  MOV       AL,         CH
  // Initialized
  // Finish
end;
{$ELSE ~ CPUX86 OR USE_FORCE_DELPHI}
begin
  Result := (Value shl BitsPerByte) or (Byte(Value shr BitsPerByte));
end;
{$ENDIF ~ CPUX64 AND USE_ASSEMBLER}

function ReverseBytes(const Value: Cardinal): Cardinal; overload;
{$IF DEFINED(USE_ASSEMBLER)}
asm
  // Start
{$IF DEFINED(CPUX64)}
  // --> ECX Value
  // <-- EAX Result
  MOV       EAX,        ECX   // Value -> EAX
{$ELSE ~ CPUX86}
  // --> EAX Value
  // <-- EAX Result
{$ENDIF ~ CPUX64}
  // Initialized
  BSWAP     EAX
  // Finish
end;
{$ELSE ~ USE_FORCE_DELPHI}
begin
  Result :=
    ( Value                shr (BitsPerByte * 3)) or ( Value                shl (BitsPerByte * 3)) or
    ((Value and $00FF0000) shr  BitsPerByte)      or ((Value and $0000FF00) shl  BitsPerByte);
end;
{$ENDIF ~ USE_ASSEMBLER}

function ReverseBytes(const Value: Integer): Integer; overload;
{$IF DEFINED(USE_ASSEMBLER)}
asm
  // Start
{$IF DEFINED(CPUX64)}
  // --> ECX Value
  // <-- EAX Result
  MOV       EAX,        ECX   // Value -> EAX
{$ELSE ~ CPUX86}
  // --> EAX Value
  // <-- EAX Result
{$ENDIF ~ CPUX64}
  // Initialized
  BSWAP     EAX
  // Finish
end;
{$ELSE ~ USE_FORCE_DELPHI}
begin
  Result :=
    ( Value                shr (BitsPerByte * 3)) or ( Value                shl (BitsPerByte * 3)) or
    ((Value and $00FF0000) shr  BitsPerByte)      or ((Value and $0000FF00) shl  BitsPerByte);
end;
{$ENDIF ~ USE_ASSEMBLER}

function ReverseBytes(const Value: Int64): Int64; overload;
{$IF DEFINED(USE_ASSEMBLER)}
asm
{$IF DEFINED(CPUX64)}
  // Start
  // --> RCX Value
  // <-- RAX Result
  MOV       RAX,        RCX   // Value -> RAX
  // Initialized
  BSWAP     RAX
  // Finish
{$ELSE ~ CPUX86}
  // Start
  // --> on stack  Value
  // <-- EAX       Hi 4 bytes of Result
  //     EDX       Lo 4 bytes of Result
  MOV       EDX, DWORD PTR [Value]       // Lo 4 bytes of Value -> EDX
  MOV       EAX, DWORD PTR [Value + $4]  // Hi 4 bytes of Value -> EAX
  // Initialized
  BSWAP     EAX
  BSWAP     EDX
  // Finish
{$ENDIF ~ CPUX64}
end;
{$ELSE ~ USE_FORCE_DELPHI}
{$IF NOT DEFINED(CPUX64)}
type TWrapper = TLargeInteger;
{$ENDIF ~ NOT CPUX64}
begin
{$IF DEFINED(CPUX64)}
  Result :=
    ( Value                        shr (BitsPerByte * 7)) or ( Value                        shl (BitsPerByte * 7)) or
    ((Value and $00FF000000000000) shr (BitsPerByte * 5)) or ((Value and $000000000000FF00) shl (BitsPerByte * 5)) or
    ((Value and $0000FF0000000000) shr (BitsPerByte * 3)) or ((Value and $0000000000FF0000) shl (BitsPerByte * 3)) or
    ((Value and $000000FF00000000) shr  BitsPerByte)      or ((Value and $00000000FF000000) shl  BitsPerByte);
{$ELSE ~ CPUX86}
  TWrapper(Result).HighPart :=
    {$IF DEFINED(USE_JEDI_CORE_LIBRARY)}JclLogic{$ELSE}chHash.Core.Bits{$ENDIF}.ReverseBytes(TWrapper(Value).LowPart);
  TWrapper(Result).LowPart :=
    {$IF DEFINED(USE_JEDI_CORE_LIBRARY)}JclLogic{$ELSE}chHash.Core.Bits{$ENDIF}.ReverseBytes(TWrapper(Value).HighPart);
{$ENDIF ~ CPUX64}
end;
{$ENDIF ~ USE_ASSEMBLER}

procedure ReverseBytes(const Address: Pointer; const Length: NativeUInt); overload;
begin
  if (Address = nil) or (Length < 2) then Exit;

  var P1: PByte := Address;
  var P2: PByte := Address;
  Inc(P2, Length - 1);
  while NativeUInt(P1) < NativeUInt(P2) do
  begin
    const T = P1^;
    P1^ := P2^;
    P2^ := T;
    Inc(P1);
    Dec(P2);
  end;
end;
{$ENDIF ~ NOT USE_JEDI_CORE_LIBRARY}
{$ENDREGION 'Not use JEDI Core Library'}

function ReverseBytes(const Value: UInt64): UInt64; overload;
{$IF DEFINED(USE_ASSEMBLER)}
asm
{$IF DEFINED(CPUX64)}
  // Start
  // --> RCX Value
  // <-- RAX Result
  MOV       RAX,        RCX   // Value -> RAX
  // Initialized
  BSWAP     RAX
  // Finish
{$ELSE ~ CPUX86}
  // Start
  // --> on stack  Value
  // <-- EAX       Hi 4 bytes of Result
  //     EDX       Lo 4 bytes of Result
  MOV       EDX, DWORD PTR [Value]       // Lo 4 bytes of Value -> EDX
  MOV       EAX, DWORD PTR [Value + $4]  // Hi 4 bytes of Value -> EAX
  // Initialized
  BSWAP     EAX
  BSWAP     EDX
  // Finish
{$ENDIF ~ CPUX64}
end;
{$ELSE ~ USE_FORCE_DELPHI}
{$IF NOT DEFINED(CPUX64)}
type TWrapper = TULargeInteger;
{$ENDIF ~ NOT CPUX64}
begin
{$IF DEFINED(CPUX64)}
  Result :=
    ( Value                        shr (BitsPerByte * 7)) or ( Value                        shl (BitsPerByte * 7)) or
    ((Value and $00FF000000000000) shr (BitsPerByte * 5)) or ((Value and $000000000000FF00) shl (BitsPerByte * 5)) or
    ((Value and $0000FF0000000000) shr (BitsPerByte * 3)) or ((Value and $0000000000FF0000) shl (BitsPerByte * 3)) or
    ((Value and $000000FF00000000) shr  BitsPerByte)      or ((Value and $00000000FF000000) shl  BitsPerByte);
{$ELSE ~CPUX86}
  TWrapper(Result).HighPart :=
    {$IF DEFINED(USE_JEDI_CORE_LIBRARY)}JclLogic{$ELSE}chHash.Core.Bits{$ENDIF}.ReverseBytes(TWrapper(Value).LowPart);
  TWrapper(Result).LowPart :=
    {$IF DEFINED(USE_JEDI_CORE_LIBRARY)}JclLogic{$ELSE}chHash.Core.Bits{$ENDIF}.ReverseBytes(TWrapper(Value).HighPart);
{$ENDIF ~ CPUX64}
end;
{$ENDIF ~ USE_ASSEMBLER}

function ReverseBytes(const Value: NativeUInt): NativeUInt; overload;
{$IF DEFINED(USE_ASSEMBLER)}
asm
{$IF DEFINED(CPUX64)}
  // Start
  // --> RCX Value
  // <-- RAX Result
  MOV       RAX,        RCX   // Value -> RAX
  // Initialized
  BSWAP     RAX
  // Finish
{$ELSE ~ CPUX86}
  // --> EAX Value
  // <-- EAX Result
  // Initialized
  BSWAP     EAX
  // Finish
{$ENDIF ~ NOT CPUX64}
end;
{$ELSE ~ USE_FORCE_DELPHI}
begin
{$IF DEFINED(CPUX64)}
  Result :=
    ( Value                        shr (BitsPerByte * 7)) or ( Value                        shl (BitsPerByte * 7)) or
    ((Value and $00FF000000000000) shr (BitsPerByte * 5)) or ((Value and $000000000000FF00) shl (BitsPerByte * 5)) or
    ((Value and $0000FF0000000000) shr (BitsPerByte * 3)) or ((Value and $0000000000FF0000) shl (BitsPerByte * 3)) or
    ((Value and $000000FF00000000) shr  BitsPerByte)      or ((Value and $00000000FF000000) shl  BitsPerByte);
{$ELSE ~ CPUX86}
  Result :=
    ( Value shr                (BitsPerByte * 3)) or ( Value shl                (BitsPerByte * 3)) or
    ((Value and $00FF0000) shr  BitsPerByte)      or ((Value and $0000FF00) shl  BitsPerByte);
{$ENDIF ~ NOT CPUX64}
end;
{$ENDIF ~ USE_ASSEMBLER}

function ReverseBytes(const Value: NativeInt): NativeInt; overload;
{$IF DEFINED(USE_ASSEMBLER)}
asm
{$IF DEFINED(CPUX64)}
  // Start
  // --> RCX Value
  // <-- RAX Result
  MOV       RAX,        RCX   // Value -> RAX
  // Initialized
  BSWAP     RAX
  // Finish
{$ELSE ~ CPUX86}
  // --> EAX Value
  // <-- EAX Result
  // Initialized
  BSWAP     EAX
  // Finish
{$ENDIF ~ NOT CPUX64}
end;
{$ELSE ~ USE_FORCE_DELPHI}
begin
{$IF DEFINED(CPUX64)}
  Result :=
    ( Value                        shr (BitsPerByte * 7)) or ( Value                        shl (BitsPerByte * 7)) or
    ((Value and $00FF000000000000) shr (BitsPerByte * 5)) or ((Value and $000000000000FF00) shl (BitsPerByte * 5)) or
    ((Value and $0000FF0000000000) shr (BitsPerByte * 3)) or ((Value and $0000000000FF0000) shl (BitsPerByte * 3)) or
    ((Value and $000000FF00000000) shr  BitsPerByte)      or ((Value and $00000000FF000000) shl  BitsPerByte);
{$ELSE ~ CPUX86}
  Result :=
    ( Value                shr (BitsPerByte * 3)) or ( Value                shl (BitsPerByte * 3)) or
    ((Value and $00FF0000) shr  BitsPerByte)      or ((Value and $0000FF00) shl  BitsPerByte);
{$ENDIF ~ NOT CPUX64}
end;
{$ENDIF ~ USE_ASSEMBLER}

procedure ReverseBytes(var Bytes: TBytes; const Length: NativeUInt); overload;
begin
  ReverseBytes(@Bytes[0], Length);
end;
{$ENDREGION 'ReverseBytes'}

{$REGION 'TestBit'}
{$REGION 'Not use JEDI Core Library'}
{$IF NOT DEFINED(USE_JEDI_CORE_LIBRARY)}
function TestBit(const Value, Bit: Byte): Boolean;
begin
  Result := (Value shr (Bit and (BitsPerByte - 1))) and 1 <> 0;
end;

function TestBit(const Value: ShortInt; const Bit: Byte): Boolean;
begin
  Result := (Value shr (Bit and (BitsPerShortInt - 1))) and 1 <> 0;
end;

function TestBit(const Value: Word; const Bit: Byte): Boolean;
begin
  Result := (Value shr (Bit and (BitsPerWord - 1))) and 1 <> 0;
end;

function TestBit(const Value: SmallInt; const Bit: Byte): Boolean;
begin
  Result := (Value shr (Bit and (BitsPerSmallInt - 1))) and 1 <> 0;
end;

function TestBit(const Value: Cardinal; const Bit: Byte): Boolean;
begin
  Result := (Value shr (Bit and (BitsPerCardinal - 1))) and 1 <> 0;
end;

function TestBit(const Value: Integer; const Bit: Byte): Boolean;
begin
  Result := (Value shr (Bit and (BitsPerInteger - 1))) and 1 <> 0;
end;

function TestBit(const Value: Int64; const Bit: Byte): Boolean;
begin
{$IF DEFINED(CPUX64)}
  Result := (Value shr (Bit and (BitsPerInt64 - 1))) and 1 <> 0;
{$ELSE ~ CPUX86}
  if Bit > BitsPerInteger - 1 then
  begin
    Exit(TestBit(TLargeInteger(Value).HighPart, Bit - BitsPerInteger));
  end;
  Result := TestBit(TLargeInteger(Value).LowPart, Bit);
{$ENDIF ~ CPUX64}
end;

function TestBitBuffer(const Buffer; const Bit: NativeUInt): Boolean;
begin
  Result := TestBit(@Buffer, Bit);
end;
{$ENDIF ~ NOT USE_JEDI_CORE_LIBRARY}
{$ENDREGION 'Not use JEDI Core Library'}

function TestBit(const Value: UInt64; const Bit: Byte): Boolean;
begin
{$IF DEFINED(CPUX64)}
  Result := (Value shr (Bit and (BitsPerUInt64 - 1))) and 1 <> 0;
{$ELSE ~ CPUX86}
  if Bit > BitsPerCardinal - 1 then
  begin
    Exit(TestBit(TULargeInteger(Value).HighPart, Bit - BitsPerCardinal));
  end;
  Result := TestBit(TULargeInteger(Value).LowPart, Bit);
{$ENDIF ~ CPUX64}
end;

function TestBit(const Value: NativeUInt; const Bit: Byte): Boolean;
begin
  Result := (Value shr (Bit and (BitsPerNativeUInt - 1))) and 1 <> 0;
end;

function TestBit(const Value: NativeInt; const Bit: Byte): Boolean;
begin
  Result := (Value shr (Bit and (BitsPerNativeInt - 1))) and 1 <> 0;
end;

function TestBit(const Address: Pointer; const Bit: NativeUInt): Boolean;
{$IF DEFINED(USE_ASSEMBLER)}
asm
  // Start
{$IF DEFINED(CPUX64)}
  // --> RCX Address
  //     DL  Bit
  // <-- AL  Result
  // Initialized
  BT        [RCX],      Bit
{$ELSE ~ CPUX86}
  // --> EAX Address
  //     DL  Bit
  // <-- AL  Result
  // Initialized
  BT        [EAX],      Bit
{$ENDIF ~ CPUX64}
  SETC      AL
  // Finish
end;
{$ELSE ~ USE_FORCE_DELPHI}
begin
  var P: PByte := Address;
  Inc(P, Bit div BitsPerByte);
  const BitOfs = Bit mod BitsPerByte;
  Result := TestBit(P^, BitOfs);
end;
{$ENDIF ~ USE_ASSEMBLER}

function TestBit(const Bytes: TBytes; const Bit: NativeUInt): Boolean;
begin
  Result := TestBitBuffer(Bytes[0], Bit);
end;
{$ENDREGION 'TestBit'}

{$REGION 'ToBytes'}
function ToBytes(const Value: Byte): TBytes;
const Size = Byte(SizeOf(Value));
begin
  SetLength(Result, Size);
  Result[0] := Value;
end;

function ToBytes(const Value: ShortInt): TBytes;
const Size = Byte(SizeOf(Value));
begin
  SetLength(Result, Size);
  Result[0] := Value;
end;

function ToBytes(const Value: Word): TBytes;
const Size = Byte(SizeOf(Value));
begin
  SetLength(Result, Size);
  var V := Value;
  for var I := Size - 1 downto 0 do
  begin
    Result[I] := V;
    V := V shr BitsPerByte;
  end;
end;

function ToBytes(const Value: SmallInt): TBytes;
const Size = Byte(SizeOf(Value));
begin
  SetLength(Result, Size);
  var V := Value;
  for var I := Size - 1 downto 0 do
  begin
    Result[I] := V;
    V := V shr BitsPerByte;
  end;
end;

function ToBytes(const Value: Cardinal): TBytes;
const Size = Byte(SizeOf(Value));
begin
  SetLength(Result, Size);
  var V := Value;
  for var I := Size - 1 downto 0 do
  begin
    Result[I] := V;
    V := V shr BitsPerByte;
  end;
end;

function ToBytes(const Value: Integer): TBytes;
const Size = Byte(SizeOf(Value));
begin
  SetLength(Result, Size);
  var V := Value;
  for var I := Size - 1 downto 0 do
  begin
    Result[I] := V;
    V := V shr BitsPerByte;
  end;
end;

function ToBytes(const Value: UInt64): TBytes;
const Size = Byte(SizeOf(Value));
{$IF NOT DEFINED(CPUX64)}
const CardinalSize = Byte(SizeOf(Cardinal));
{$ENDIF ~ NOT CPUX64}
begin
  SetLength(Result, Size);
{$IF DEFINED(CPUX64)}
  var V := Value;
  for var I := Size - 1 downto 0 do
  begin
    Result[I] := V;
    V := V shr BitsPerByte;
  end;
{$ELSE ~ CPUX86}
  var V := TULargeInteger(Value).LowPart;
  for var I := CardinalSize - 1 downto 0 do
  begin
    Result[I + CardinalSize] := V;
    V := V shr BitsPerByte;
  end;
  V := TULargeInteger(Value).HighPart;
  for var I := CardinalSize - 1 downto 0 do
  begin
    Result[I] := V;
    V := V shr BitsPerByte;
  end;
{$ENDIF ~ CPUX64}
end;

function ToBytes(const Value: Int64): TBytes;
const Size = Byte(SizeOf(Value));
{$IF NOT DEFINED(CPUX64)}
const CardinalSize = Byte(SizeOf(Cardinal));
{$ENDIF ~ NOT CPUX64}
begin
  SetLength(Result, Size);
{$IF DEFINED(CPUX64)}
  var V := Value;
  for var I := Size - 1 downto 0 do
  begin
    Result[I] := V;
    V := V shr BitsPerByte;
  end;
{$ELSE ~ CPUX86}
  var V := TLargeInteger(Value).LowPart;
  for var I := CardinalSize - 1 downto 0 do
  begin
    Result[I + CardinalSize] := V;
    V := V shr BitsPerByte;
  end;
  V := TLargeInteger(Value).HighPart;
  for var I := CardinalSize - 1 downto 0 do
  begin
    Result[I] := V;
    V := V shr BitsPerByte;
  end;
{$ENDIF ~ CPUX64}
end;

function ToBytes(const Value: NativeUInt): TBytes;
const Size = Byte(SizeOf(Value));
begin
  SetLength(Result, Size);
  var V := Value;
  for var I := Size - 1 downto 0 do
  begin
    Result[I] := V;
    V := V shr BitsPerByte;
  end;
end;

function ToBytes(const Value: NativeInt): TBytes;
const Size = Byte(SizeOf(Value));
begin
  SetLength(Result, Size);
  var V := Value;
  for var I := Size - 1 downto 0 do
  begin
    Result[I] := V;
    V := V shr BitsPerByte;
  end;
end;

function ToBytes(const Value; const Length: NativeUInt): TBytes;
begin
  Result := ToBytes(@Value, Length);
end;

function ToBytes(const Address: Pointer; const Length: NativeUInt): TBytes;
begin
  if Address = nil then Exit;

  SetLength(Result, Length);
  var P: PByte := Address;
  for var I := 0 to Length - 1 do
  begin
    Result[I] := (P + I)^;
  end;
end;
{$ENDREGION 'ToBytes'}

{ TByteHelper }

function TByteHelper.ReverseBits: Byte;
begin
  Result := {$IF DEFINED(USE_JEDI_CORE_LIBRARY)}JclLogic{$ELSE}chHash.Core.Bits{$ENDIF}.ReverseBits(Self);
end;

function TByteHelper.TestBit(const Bit: Byte): Boolean;
begin
  Result := {$IF DEFINED(USE_JEDI_CORE_LIBRARY)}JclLogic{$ELSE}chHash.Core.Bits{$ENDIF}.TestBit(Self, Bit);
end;

function TByteHelper.ToBytes: TBytes;
begin
  Result := chHash.Core.Bits.ToBytes(Self);
end;

{ TShortIntHelper }

function TShortIntHelper.ReverseBits: ShortInt;
begin
  Result := {$IF DEFINED(USE_JEDI_CORE_LIBRARY)}JclLogic{$ELSE}chHash.Core.Bits{$ENDIF}.ReverseBits(Self);
end;

function TShortIntHelper.TestBit(const Bit: Byte): Boolean;
begin
  Result := {$IF DEFINED(USE_JEDI_CORE_LIBRARY)}JclLogic{$ELSE}chHash.Core.Bits{$ENDIF}.TestBit(Self, Bit);
end;

function TShortIntHelper.ToBytes: TBytes;
begin
  Result := chHash.Core.Bits.ToBytes(Self);
end;

{ TWordHelper }

function TWordHelper.ReverseBits: Word;
begin
  Result := {$IF DEFINED(USE_JEDI_CORE_LIBRARY)}JclLogic{$ELSE}chHash.Core.Bits{$ENDIF}.ReverseBits(Self);
end;

function TWordHelper.ReverseBytes: Word;
begin
  Result := {$IF DEFINED(USE_JEDI_CORE_LIBRARY)}JclLogic{$ELSE}chHash.Core.Bits{$ENDIF}.ReverseBytes(Self);
end;

function TWordHelper.TestBit(const Bit: Byte): Boolean;
begin
  Result := {$IF DEFINED(USE_JEDI_CORE_LIBRARY)}JclLogic{$ELSE}chHash.Core.Bits{$ENDIF}.TestBit(Self, Bit);
end;

function TWordHelper.ToBytes: TBytes;
begin
  Result := chHash.Core.Bits.ToBytes(Self);
end;

{ TSmallIntHelper }

function TSmallIntHelper.ReverseBits: SmallInt;
begin
  Result := {$IF DEFINED(USE_JEDI_CORE_LIBRARY)}JclLogic{$ELSE}chHash.Core.Bits{$ENDIF}.ReverseBits(Self);
end;

function TSmallIntHelper.ReverseBytes: SmallInt;
begin
  Result := {$IF DEFINED(USE_JEDI_CORE_LIBRARY)}JclLogic{$ELSE}chHash.Core.Bits{$ENDIF}.ReverseBytes(Self);
end;

function TSmallIntHelper.TestBit(const Bit: Byte): Boolean;
begin
  Result := {$IF DEFINED(USE_JEDI_CORE_LIBRARY)}JclLogic{$ELSE}chHash.Core.Bits{$ENDIF}.TestBit(Self, Bit);
end;

function TSmallIntHelper.ToBytes: TBytes;
begin
  Result := chHash.Core.Bits.ToBytes(Self);
end;

{ TCardinalHelper }

function TCardinalHelper.ReverseBits: Cardinal;
begin
  Result := {$IF DEFINED(USE_JEDI_CORE_LIBRARY)}JclLogic{$ELSE}chHash.Core.Bits{$ENDIF}.ReverseBits(Self);
end;

function TCardinalHelper.ReverseBytes: Cardinal;
begin
  Result := {$IF DEFINED(USE_JEDI_CORE_LIBRARY)}JclLogic{$ELSE}chHash.Core.Bits{$ENDIF}.ReverseBytes(Self);
end;

function TCardinalHelper.TestBit(const Bit: Byte): Boolean;
begin
  Result := {$IF DEFINED(USE_JEDI_CORE_LIBRARY)}JclLogic{$ELSE}chHash.Core.Bits{$ENDIF}.TestBit(Self, Bit);
end;

function TCardinalHelper.ToBytes: TBytes;
begin
  Result := chHash.Core.Bits.ToBytes(Self);
end;

{ TIntegerHelper }

function TIntegerHelper.ReverseBits: Integer;
begin
  Result := {$IF DEFINED(USE_JEDI_CORE_LIBRARY)}JclLogic{$ELSE}chHash.Core.Bits{$ENDIF}.ReverseBits(Self);
end;

function TIntegerHelper.ReverseBytes: Integer;
begin
  Result := {$IF DEFINED(USE_JEDI_CORE_LIBRARY)}JclLogic{$ELSE}chHash.Core.Bits{$ENDIF}.ReverseBytes(Self);
end;

function TIntegerHelper.TestBit(const Bit: Byte): Boolean;
begin
  Result := {$IF DEFINED(USE_JEDI_CORE_LIBRARY)}JclLogic{$ELSE}chHash.Core.Bits{$ENDIF}.TestBit(Self, Bit);
end;

function TIntegerHelper.ToBytes: TBytes;
begin
  Result := chHash.Core.Bits.ToBytes(Self);
end;

{ TUInt64Helper }

function TUInt64Helper.ReverseBits: UInt64;
begin
  Result := chHash.Core.Bits.ReverseBits(Self);
end;

function TUInt64Helper.ReverseBytes: UInt64;
begin
  Result := chHash.Core.Bits.ReverseBytes(Self);
end;

function TUInt64Helper.TestBit(const Bit: Byte): Boolean;
begin
  Result := chHash.Core.Bits.TestBit(Self, Bit);
end;

function TUInt64Helper.ToBytes: TBytes;
begin
  Result := chHash.Core.Bits.ToBytes(Self);
end;

{ TInt64Helper }

function TInt64Helper.ReverseBits: Int64;
begin
  Result := {$IF DEFINED(USE_JEDI_CORE_LIBRARY)}JclLogic{$ELSE}chHash.Core.Bits{$ENDIF}.ReverseBits(Self);
end;

function TInt64Helper.ReverseBytes: Int64;
begin
  Result := {$IF DEFINED(USE_JEDI_CORE_LIBRARY)}JclLogic{$ELSE}chHash.Core.Bits{$ENDIF}.ReverseBytes(Self);
end;

function TInt64Helper.TestBit(const Bit: Byte): Boolean;
begin
  Result := {$IF DEFINED(USE_JEDI_CORE_LIBRARY)}JclLogic{$ELSE}chHash.Core.Bits{$ENDIF}.TestBit(Self, Bit);
end;

function TInt64Helper.ToBytes: TBytes;
begin
  Result := chHash.Core.Bits.ToBytes(Self);
end;

{ TNativeUIntHelper }

function TNativeUIntHelper.ReverseBits: NativeUInt;
begin
  Result := chHash.Core.Bits.ReverseBits(Self);
end;

function TNativeUIntHelper.ReverseBytes: NativeUInt;
begin
  Result := chHash.Core.Bits.ReverseBytes(Self);
end;

function TNativeUIntHelper.TestBit(const Bit: Byte): Boolean;
begin
  Result := chHash.Core.Bits.TestBit(Self, Bit);
end;

function TNativeUIntHelper.ToBytes: TBytes;
begin
  Result := chHash.Core.Bits.ToBytes(Self);
end;

{ TNativeIntHelper }

function TNativeIntHelper.ReverseBits: NativeInt;
begin
  Result := chHash.Core.Bits.ReverseBits(Self);
end;

function TNativeIntHelper.ReverseBytes: NativeInt;
begin
  Result := chHash.Core.Bits.ReverseBytes(Self);
end;

function TNativeIntHelper.TestBit(const Bit: Byte): Boolean;
begin
  Result := chHash.Core.Bits.TestBit(Self, Bit);
end;

function TNativeIntHelper.ToBytes: TBytes;
begin
  Result := chHash.Core.Bits.ToBytes(Self);
end;

{ TPointerHelper }

procedure TPointerHelper.ReverseBits(const Length: NativeUInt);
begin
  {$IF DEFINED(USE_JEDI_CORE_LIBRARY)}JclLogic{$ELSE}chHash.Core.Bits{$ENDIF}.ReverseBits(Self, Length);
end;

procedure TPointerHelper.ReverseBytes(const Length: NativeUInt);
begin
  {$IF DEFINED(USE_JEDI_CORE_LIBRARY)}JclLogic{$ELSE}chHash.Core.Bits{$ENDIF}.ReverseBytes(Self, Length);
end;

function TPointerHelper.TestBit(const Bit: NativeUInt): Boolean;
begin
  Result := chHash.Core.Bits.TestBit(Self, Bit);
end;

function TPointerHelper.ToBytes(const Length: NativeUInt): TBytes;
begin
  Result := chHash.Core.Bits.ToBytes(Self, Length);
end;

end.

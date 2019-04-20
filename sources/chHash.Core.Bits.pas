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

interface

uses
  System.SysUtils,
{$IF DEFINED(USE_JEDY_CORE_LIBRARY)}
  JclLogic,
{$IFEND ~ USE_JEDY_CORE_LIBRARY}
  chHash.Core;

type

{ TByteHelper }

  TByteHelper = record helper for Byte
  {$IF NOT DEFINED(USE_JEDY_CORE_LIBRARY)}
  private type
    TNibble = record
    public const
      Bits = Byte(4);
      Mask = Byte($F);
    end;
  {$IFEND ~ NOTUSE_JEDY_CORE_LIBRARY}
  private const
    FSize = Byte(SizeOf(Byte));
  {$IF NOT DEFINED(USE_JEDY_CORE_LIBRARY)}
  public const
    Bits    = Byte(8);
    Nibbles = Byte(Bits div TNibble.Bits);
    Mask    = Byte($FF);
  private type
    TReverse = record
    private const
      FTable: array [0..Byte.Mask] of Byte = (
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
  {$IFEND ~ NOT USE_JEDY_CORE_LIBRARY}
  public
  {$IF NOT DEFINED(USE_JEDY_CORE_LIBRARY)}
    function ReverseBits: Byte;
      {$IF DEFINED(CPUX86) AND DEFINED(USE_INLINE)}inline;{$IFEND}
    function TestBit(const Bit: Byte): Boolean;
      {$IF DEFINED(USE_FORCE_DELPHI) AND DEFINED(USE_INLINE)}inline;{$IFEND}
  {$IFEND ~ NOT USE_JEDY_CORE_LIBRARY}
    function ToBytes: TBytes;
  end;

{ TShortIntHelper}

  TShortIntHelper = record helper for ShortInt
  private const
    FSize = Byte(SizeOf(ShortInt));
  {$IF NOT DEFINED(USE_JEDY_CORE_LIBRARY)}
  public const
    Bits    = Byte(Byte.Bits * FSize);
    Nibbles = Byte(Byte.Nibbles * FSize);
    Mask    = ShortInt($FF);
  {$IFEND ~ NOT USE_JEDY_CORE_LIBRARY}
  public
  {$IF NOT DEFINED(USE_JEDY_CORE_LIBRARY)}
    function ReverseBits: ShortInt;
      {$IF DEFINED(CPUX86) AND DEFINED(USE_INLINE)}inline;{$IFEND}
    function TestBit(const Bit: Byte): Boolean;
      {$IF DEFINED(USE_FORCE_DELPHI) AND DEFINED(USE_INLINE)}inline;{$IFEND}
  {$IFEND ~ NOT USE_JEDY_CORE_LIBRARY}
    function ToBytes: TBytes;
  end;

{ TWordHelper }

  TWordHelper = record helper for Word
  private const
    FSize = Byte(SizeOf(Word));
  {$IF NOT DEFINED(USE_JEDY_CORE_LIBRARY)}
  public const
    Bits    = Byte(Byte.Bits * FSize);
    Nibbles = Byte(Byte.Nibbles * FSize);
    Mask    = Word($FFFF);
  {$IFEND ~ NOT USE_JEDY_CORE_LIBRARY}
  public
  {$IF NOT DEFINED(USE_JEDY_CORE_LIBRARY)}
    function ReverseBits: Word;
//      {$IF DEFINED(USE_FORCE_DELPHI) AND DEFINED(USE_INLINE)}inline;{$IFEND} // Analize in prev versions
    function ReverseBytes: Word;
//      {$IF DEFINED(USE_FORCE_DELPHI) AND DEFINED(USE_INLINE)}inline;{$IFEND} // Analize in prev versions
    function TestBit(const Bit: Byte): Boolean;
      {$IF DEFINED(USE_FORCE_DELPHI) AND DEFINED(USE_INLINE)}inline;{$IFEND}
  {$IFEND ~ NOT USE_JEDY_CORE_LIBRARY}
    function ToBytes: TBytes;
  end;

{ TSmallIntHelper }

  TSmallIntHelper = record helper for SmallInt
  private const
    FSize = Byte(SizeOf(SmallInt));
  {$IF NOT DEFINED(USE_JEDY_CORE_LIBRARY)}
  public const
    Bits    = Byte(Byte.Bits * FSize);
    Nibbles = Byte(Byte.Nibbles * FSize);
    Mask    = SmallInt($FFFF);
  {$IFEND ~ NOT USE_JEDY_CORE_LIBRARY}
  public
  {$IF NOT DEFINED(USE_JEDY_CORE_LIBRARY)}
    function ReverseBits: SmallInt;
//      {$IF DEFINED(USE_FORCE_DELPHI) AND DEFINED(USE_INLINE)}inline;{$IFEND} // Analize in prev versions
    function ReverseBytes: SmallInt;
//      {$IF DEFINED(USE_FORCE_DELPHI) AND DEFINED(USE_INLINE)}inline;{$IFEND} // Analize in prev versions
    function TestBit(const Bit: Byte): Boolean;
      {$IF DEFINED(USE_FORCE_DELPHI) AND DEFINED(USE_INLINE)}inline;{$IFEND}
  {$IFEND ~ NOT USE_JEDY_CORE_LIBRARY}
    function ToBytes: TBytes;
  end;

{ TCardinalHelper }

  TCardinalHelper = record helper for Cardinal
  private const
    FSize = Byte(SizeOf(Cardinal));
  {$IF NOT DEFINED(USE_JEDY_CORE_LIBRARY)}
  public const
    Bits    = Byte(Byte.Bits * FSize);
    Nibbles = Byte(Byte.Nibbles * FSize);
    Mask    = Cardinal($FFFFFFFF);
  {$IFEND ~ NOT USE_JEDY_CORE_LIBRARY}
  public
  {$IF NOT DEFINED(USE_JEDY_CORE_LIBRARY)}
    function ReverseBits: Cardinal;
//      {$IF DEFINED(USE_FORCE_DELPHI) AND DEFINED(USE_INLINE)}inline;{$IFEND} // Analize in prev versions
    function ReverseBytes: Cardinal;
//      {$IF DEFINED(USE_FORCE_DELPHI) AND DEFINED(USE_INLINE)}inline;{$IFEND} // Analize in prev versions
    function TestBit(const Bit: Byte): Boolean;
      {$IF DEFINED(USE_FORCE_DELPHI) AND DEFINED(USE_INLINE)}inline;{$IFEND}
  {$IFEND ~ NOT USE_JEDY_CORE_LIBRARY}
    function ToBytes: TBytes;
  end;

{ TIntegerHelper }

  TIntegerHelper = record helper for Integer
  private const
    FSize = Byte(SizeOf(Integer));
  {$IF NOT DEFINED(USE_JEDY_CORE_LIBRARY)}
  public const
    Bits    = Byte(Byte.Bits * FSize);
    Nibbles = Byte(Byte.Nibbles * FSize);
    Mask    = Integer($FFFFFFFF);
  {$IFEND ~ NOT USE_JEDY_CORE_LIBRARY}
  public
  {$IF NOT DEFINED(USE_JEDY_CORE_LIBRARY)}
    function ReverseBits: Integer;
//      {$IF DEFINED(USE_FORCE_DELPHI) AND DEFINED(USE_INLINE)}inline;{$IFEND} // Analize in prev versions
    function ReverseBytes: Integer;
//      {$IF DEFINED(USE_FORCE_DELPHI) AND DEFINED(USE_INLINE)}inline;{$IFEND} // Analize in prev versions
    function TestBit(const Bit: Byte): Boolean;
      {$IF DEFINED(USE_FORCE_DELPHI) AND DEFINED(USE_INLINE)}inline;{$IFEND}
  {$IFEND ~ NOT USE_JEDY_CORE_LIBRARY}
    function ToBytes: TBytes;
  end;

{ TUInt64Helper }

  TUInt64Helper = record helper for UInt64
  private const
    FSize = Byte(SizeOf(UInt64));
  {$IF NOT DEFINED(USE_JEDY_CORE_LIBRARY)}
  public const
    Bits    = Byte(Byte.Bits * FSize);
    Nibbles = Byte(Byte.Nibbles * FSize);
    Mask    = UInt64($FFFFFFFFFFFFFFFF);
  {$IFEND ~ NOT USE_JEDY_CORE_LIBRARY}
  public
  {$IF NOT DEFINED(USE_JEDY_CORE_LIBRARY)}
    function ReverseBits: UInt64;
//      {$IF DEFINED(USE_FORCE_DELPHI) OR DEFINED(CPUX86) AND DEFINED(USE_INLINE)}inline;{$IFEND} // Analize in prev versions
    function ReverseBytes: UInt64;
//      {$IF DEFINED(USE_FORCE_DELPHI) OR DEFINED(CPUX86) AND DEFINED(USE_INLINE)}inline;{$IFEND} // Analize in prev versions
    function TestBit(const Bit: Byte): Boolean;
      {$IF DEFINED(USE_INLINE)}{$IF DEFINED(USE_FORCE_DELPHI) OR DEFINED(CPUX86)}inline;{$IFEND}{$IFEND}
  {$IFEND ~ NOT USE_JEDY_CORE_LIBRARY}
    function ToBytes: TBytes;
  end;

{ TInt64Helper }

  TInt64Helper = record helper for Int64
  private const
    FSize = Byte(SizeOf(Int64));
  {$IF NOT DEFINED(USE_JEDY_CORE_LIBRARY)}
  public const
    Bits    = Byte(Byte.Bits * FSize);
    Nibbles = Byte(Byte.Nibbles * FSize);
    Mask    = Int64($FFFFFFFFFFFFFFFF);
  {$IFEND ~ NOT USE_JEDY_CORE_LIBRARY}
  public
  {$IF NOT DEFINED(USE_JEDY_CORE_LIBRARY)}
    function ReverseBits: Int64;
//      {$IF DEFINED(USE_FORCE_DELPHI) OR DEFINED(CPUX86) AND DEFINED(USE_INLINE)}inline;{$IFEND} // Analize in prev versions
    function ReverseBytes: Int64;
//      {$IF DEFINED(USE_FORCE_DELPHI) OR DEFINED(CPUX86) AND DEFINED(USE_INLINE)}inline;{$IFEND} // Analize in prev versions
    function TestBit(const Bit: Byte): Boolean;
      {$IF DEFINED(USE_INLINE)}{$IF DEFINED(USE_FORCE_DELPHI) OR DEFINED(CPUX86)}inline;{$IFEND}{$IFEND}
  {$IFEND ~ NOT USE_JEDY_CORE_LIBRARY}
    function ToBytes: TBytes;
  end;

{ TNativeUIntHelper }

  TNativeUIntHelper = record helper for NativeUInt
  private type
    TWrapper = {$IF DEFINED(CPUX64)}UInt64{$ELSE}Cardinal{$IFEND};
  public const
    Bits    = Byte(
    {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}
      {$IF DEFINED(CPUX64)}BitsPerInt64{$ELSE}BitsPerCardinal{$IFEND}
    {$ELSE ~ NOT USE_JEDY_CORE_LIBRARY}
      TWrapper.Bits
    {$IFEND ~ USE_JEDY_CORE_LIBRARY}
    );
    Nibbles = Byte(
    {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}
      {$IF DEFINED(CPUX64)}NibblesPerInt64{$ELSE}NibblesPerCardinal{$IFEND}
    {$ELSE ~ NOT USE_JEDY_CORE_LIBRARY}
      TWrapper.Nibbles
    {$IFEND ~ USE_JEDY_CORE_LIBRARY}
    );
    Mask    = NativeUInt(
    {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}
      {$IF DEFINED(CPUX64)}Int64Mask{$ELSE}CardinalMask{$IFEND}
    {$ELSE ~ NOT USE_JEDY_CORE_LIBRARY}
      TWrapper.Mask
    {$IFEND ~ USE_JEDY_CORE_LIBRARY}
    );
  public
    function ReverseBits: NativeUInt;
//      {$IF DEFINED(USE_INLINE)}inline;{$IFEND} // Analize in prev versions
    function ReverseBytes: NativeUInt;
//      {$IF DEFINED(USE_INLINE)}inline;{$IFEND} // Analize in prev versions
    function TestBit(const Bit: Byte): Boolean;
      {$IF DEFINED(USE_FORCE_DELPHI)}inline;{$IFEND}
    function ToBytes: TBytes;
  end;

{ TNativeIntHelper }

  TNativeIntHelper = record helper for NativeInt
  private type
    TWrapper = {$IF DEFINED(CPUX64)}Int64{$ELSE}Integer{$IFEND};
  public const
    Bits    = Byte(
    {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}
      {$IF DEFINED(CPUX64)}BitsPerInt64{$ELSE}BitsPerInteger{$IFEND}
    {$ELSE ~ NOT USE_JEDY_CORE_LIBRARY}
      TWrapper.Bits
    {$IFEND ~ USE_JEDY_CORE_LIBRARY}
    );
    Nibbles = Byte(
    {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}
      {$IF DEFINED(CPUX64)}NibblesPerInt64{$ELSE}NibblesPerInteger{$IFEND}
    {$ELSE ~ NOT USE_JEDY_CORE_LIBRARY}
      TWrapper.Nibbles
    {$IFEND ~ USE_JEDY_CORE_LIBRARY}
    );
    Mask    = NativeInt(
    {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}
      {$IF DEFINED(CPUX64)}Int64Mask{$ELSE}IntegerMask{$IFEND}
    {$ELSE ~ NOT USE_JEDY_CORE_LIBRARY}
      TWrapper.Mask
    {$IFEND ~ USE_JEDY_CORE_LIBRARY}
    );
  public
    function ReverseBits: NativeInt;
//      {$IF DEFINED(USE_INLINE)}inline;{$IFEND} // Analize in prev versions
    function ReverseBytes: NativeInt;
//      {$IF DEFINED(USE_INLINE)}inline;{$IFEND} // Analize in prev versions
    function TestBit(const Bit: Byte): Boolean;
      {$IF DEFINED(USE_FORCE_DELPHI)}inline;{$IFEND}
    function ToBytes: TBytes;
  end;

  TPointerHelper = record helper for Pointer
  public
  {$IF NOT DEFINED(USE_JEDY_CORE_LIBRARY)}
    procedure ReverseBits(const Length: Cardinal); overload;
//      {$IF DEFINED(USE_FORCE_DELPHI) AND DEFINED(USE_INLINE)}inline;{$IFEND} // Analize in prev versions
    procedure ReverseBytes(const Length: Cardinal); overload;
//      {$IF DEFINED(USE_FORCE_DELPHI) AND DEFINED(USE_INLINE)}inline;{$IFEND} // Analize in prev versions
    function TestBit(const Bit: Cardinal): Boolean; overload;
      {$IF DEFINED(USE_FORCE_DELPHI) AND DEFINED(USE_INLINE)}inline;{$IFEND} // Analize in prev versions
  {$IFEND ~ NOT USE_JEDY_CORE_LIBRARY}
    function ToBytes(const Length: Cardinal): TBytes; overload;
  {$IF DEFINED(CPUX64)}
  {$IF NOT DEFINED(USE_JEDY_CORE_LIBRARY)}
    procedure ReverseBits(const Length: Int64); overload;
//      {$IF DEFINED(USE_FORCE_DELPHI) AND DEFINED(USE_INLINE)}inline;{$IFEND} // Analize in prev versions
    procedure ReverseBytes(const Length: Int64); overload;
//      {$IF DEFINED(USE_FORCE_DELPHI) AND DEFINED(USE_INLINE)}inline;{$IFEND} // Analize in prev versions
    function TestBit(const Bit: Int64): Boolean; overload;
//      {$IF DEFINED(USE_FORCE_DELPHI) AND DEFINED(USE_INLINE)}inline;{$IFEND} // Analize in prev versions
  {$IFEND ~ NOT USE_JEDY_CORE_LIBRARY}
    function ToBytes(const Length: Int64): TBytes; overload;
  {$IFEND ~CPUX64}
  end;

{$IF NOT DEFINED(USE_JEDY_CORE_LIBRARY)}
const
  Nibble: TByteHelper.TNibble = ();
{$IFEND ~ NOT USE_JEDY_CORE_LIBRARY}

{$IF DEFINED(DELPHIXE4_UP)}
const
{$IF NOT DEFINED(USE_JEDY_CORE_LIBRARY)}
//  BitsPerNibble        = Nibble.Bits;
  BitsPerByte          = Byte.Bits;
//  BitsPerShorInit      = ShortInt.Bits;
//  BitsPerWord          = Word.Bits;
//  BitsPerSmallInt      = SmallInt.Bits;
//  BitsPerCardinal      = Cardinal.Bits;
//  BitsPerInteger       = Integer.Bits;
  BitsPerUInt64        = UInt64.Bits;
  BitsPerInt64         = Int64.Bits;
{$IFEND ~ NOT USE_JEDY_CORE_LIBRARY}
  BitsPerNativeUInt    = NativeUInt.Bits;
  BitsPerNativeInt     = NativeInt.Bits;

{$IF NOT DEFINED(USE_JEDY_CORE_LIBRARY)}
//  NibblesPerByte       = Byte.Nibbles;
//  NibblesPerShorInt    = ShortInt.Nibbles;
//  NibblesPerWord       = Word.Nibbles;
//  NibblesPerSmallInt   = SmallInt.Nibbles;
//  NibblesPerCardinal   = Cardinal.Nibbles;
//  NibblesPerInteger    = Integer.Nibbles;
//  NibblesPerUInt64     = UInt64.Nibbles;
//  NibblesPerInt64      = Int64.Nibbles;
{$IFEND ~ NOT USE_JEDY_CORE_LIBRARY}
  NibblesPerNativeUInt = NativeUInt.Nibbles;
  NibblesPerNativeInt  = NativeInt.Nibbles;

{$IF NOT DEFINED(USE_JEDY_CORE_LIBRARY)}
//  NibbleMask           = Nibble.Mask;
  ByteMask             = Byte.Mask;
//  ShorInitMask         = ShortInt.Mask;
//  WordMask             = Word.Mask;
//  SmallIntMask         = SmallInt.Mask;
//  CardinalMask         = Cardinal.Mask;
//  IntegerMask          = Integer.Mask;
//  UInt64Mask           = UInt64.Mask;
//  Int64Mask            = Int64.Mask;
{$IFEND ~ NOT USE_JEDY_CORE_LIBRARY}
  NativeUIntMask       = NativeUInt.Mask;
  NativeIntMask        = NativeInt.Mask;

{$IF NOT DEFINED(USE_JEDY_CORE_LIBRARY)}
//function ReverseBits(const Value: Byte): Byte; overload; inline;
//function ReverseBits(const Value: ShortInt): ShortInt; overload; inline;
//function ReverseBits(const Value: Word): Word; overload; inline;
//function ReverseBits(const Value: Cardinal): Cardinal; overload; inline;
//function ReverseBits(const Value: Integer): Integer; overload; inline;
//function ReverseBits(const Value: UInt64): UInt64; overload; inline;
//function ReverseBits(const Value: Int64): Int64; overload; inline;
{$IFEND ~ NOT USE_JEDY_CORE_LIBRARY}
//function ReverseBits(const Value: NativeUInt): NativeUInt; overload; inline;
//function ReverseBits(const Value: NativeInt): NativeInt; overload; inline;
{$IF NOT DEFINED(USE_JEDY_CORE_LIBRARY)}
//procedure ReverseBits(const Value: Pointer, const Length: Cardinal); overload; inline;
//procedure ReverseBits(const Value: TBytes, const Length: Cardinal); overload; inline;
//{$IF DEFINED(CPUX64)}
//procedure ReverseBits(const Value: Pointer, const Length: Int64); overload; inline;
//procedure ReverseBits(const Value: TBytes, const Length: Int64); overload; inline;
//{$IFEND}
//
//function ReverseBytes(const Value: Byte): Byte; overload; inline;
//function ReverseBytes(const Value: ShortInt): ShortInt; overload; inline;
//function ReverseBytes(const Value: Word): Word; overload; inline;
//function ReverseBytes(const Value: Cardinal): Cardinal; overload; inline;
//function ReverseBytes(const Value: Integer): Integer; overload; inline;
//function ReverseBytes(const Value: UInt64): UInt64; overload; inline;
//function ReverseBytes(const Value: Int64): Int64; overload; inline;
{$IFEND ~ NOT USE_JEDY_CORE_LIBRARY}
//function ReverseBytes(const Value: NativeUInt): NativeUInt; overload; inline;
//function ReverseBytes(const Value: NativeInt): NativeInt; overload; inline;
{$IF NOT DEFINED(USE_JEDY_CORE_LIBRARY)}
//procedure ReverseBytes(const Value: Pointer, const Length: Cardinal); overload; inline;
//procedure ReverseBytes(const Value: TBytes, const Length: Cardinal); overload; inline;
//{$IF DEFINED(CPUX64)}
//procedure ReverseBytes(const Value: Pointer, const Length: Int64); overload; inline;
//procedure ReverseBytes(const Value: TBytes, const Length: Int64); overload; inline;
//{$IFEND}
//
//function TestBit(const Value, Bit: Byte): Boolean; overload; inline;
//function TestBit(const Value: ShortInt; const Bit: Byte): Boolean; overload; inline;
//function TestBit(const Value: Word; const Bit: Byte): Boolean; overload; inline;
//function TestBit(const Value: SmallInt; const Bit: Byte): Boolean; overload; inline;
//function TestBit(const Value: Cardinal; const Bit: Byte): Boolean; overload; inline;
//function TestBit(const Value: Integer; const Bit: Byte): Boolean; overload; inline;
//function TestBit(const Value: UInt64; const Bit: Byte): Boolean; overload; inline;
//function TestBit(const Value: Int64; const Bit: Byte): Boolean; overload; inline;
{$IFEND ~ NOT USE_JEDY_CORE_LIBRARY}
//function TestBit(const Value: NativeUInt; const Bit: Byte): Boolean; overload; inline;
//function TestBit(const Value: NativeInt; const Bit: Byte): Boolean; overload; inline;
{$IF NOT DEFINED(USE_JEDY_CORE_LIBRARY)}
//function TestBit(const Value: Pointer; const Bit: Cardinal): Boolean; overload; inline;
//function TestBit(const Value: TBytes; const Bit: Cardinal): Boolean; overload; inline;
//{$IF DEFINED(CPUX64)}
//function TestBit(const Value: Pointer; const Bit: Int64): Boolean; overload; inline;
//function TestBit(const Value: TBytes; const Bit: Int64): Boolean; overload; inline;
//{$IFEND}
{$IFEND ~ NOT USE_JEDY_CORE_LIBRARY}
//
//function ToBytes(const Value: Byte): TBytes; overload; inline;
//function ToBytes(const Value: ShortInt): TBytes; overload; inline;
//function ToBytes(const Value: Word): TBytes; overload; inline;
//function ToBytes(const Value: Cardinal): TBytes; overload; inline;
//function ToBytes(const Value: Integer): TBytes; overload; inline;
//function ToBytes(const Value: UInt64): TBytes; overload; inline;
//function ToBytes(const Value: Int64): TBytes; overload; inline;
//function ToBytes(const Value: NativeUInt): TBytes; overload; inline;
//function ToBytes(const Value: NativeInt): TBytes; overload; inline;
//function ToBytes(const Value: Pointer, const Length: Cardinal): TBytes; overload; inline;
//{$IF DEFINED(CPUX64)}
//function ToBytes(const Value: Pointer, const Length: Int64): TBytes; overload; inline;
//{$IFEND}
{$IFEND ~DELPHIXE4_UP}

implementation

{ TByteHelper }

{$IF NOT DEFINED(USE_JEDY_CORE_LIBRARY)}
{$IF DEFINED(USE_ASSEMBLER) AND DEFINED(CPUX64)}
function TByteHelper.ReverseBits: Byte;
asm
  // Start
  // --> RCX address Self
  // <-- RAX Result
  MOVZX     RAX,        [RCX]        // Self -> RAX
  MOV       RCX,        offset TByteHelper.TReverse.FTable    // address TByteHelper.TReverse.FTable -> RCX
  // Initialized
  MOV       RAX,        [RCX + RAX]
  // Finish
end;
{$ELSE ~USE_FORCE_DELPHI OR CPUX86}
function TByteHelper.ReverseBits: Byte;
begin
  Result := TReverse.FTable[Self];
end;
{$IFEND ~USE_ASSEMBLER AND CPUX64}

{$IF DEFINED(USE_ASSEMBLER)}
function TByteHelper.TestBit(const Bit: Byte): Boolean;
asm
  // Start
  // 64 --> RCX address Self
  //        DL  Bit
  //    <-- AL  Result
  // 32 --> EAX address Self
  //        DL  Bit
  //    <-- AL  Result
{$IF DEFINED(CPUX64)}
  MOV       AL,         [RCX]        // Self -> AL
{$ELSE ~CPUX86}
  MOV       AL,         [EAX]        // Self -> AL
{$IFEND ~CPUX64}
  // Initialized
  AND       DX,         Byte.Bits - 1
  BT        EAX,        DX
  SETC      AL
  // Finish
end;
{$ELSE ~USE_FORCE_DELPHI}
function TByteHelper.TestBit(const Bit: Byte): Boolean;
begin
  Result := (Self shr (Bit and (Byte.Bits - 1))) and 1 <> 0;
end;
{$IFEND ~USE_ASSEMBLER}
{$IFEND ~ NOT USE_JEDY_CORE_LIBRARY}

function TByteHelper.ToBytes: TBytes;
begin
  SetLength(Result, FSize);
  Result[0] := Self;
end;

{ TShortIntHelper }

{$IF NOT DEFINED(USE_JEDY_CORE_LIBRARY)}
function TShortIntHelper.ReverseBits: ShortInt;
begin
  Result := Byte.TReverse.FTable[Self and Byte.Mask];
end;

{$IF DEFINED(USE_ASSEMBLER)}
function TShortIntHelper.TestBit(const Bit: Byte): Boolean;
asm
  // Start
  // 64 --> RCX address Self
  //        DL  Bit
  //    <-- AL  Result
  // 32 --> EAX address Self
  //        DL  Bit
  //    <-- AL  Result
{$IF DEFINED(CPUX64)}
  MOV       AL,         [RCX]        // Self -> AL
{$ELSE ~CPUX86}
  MOV       AL,         [EAX]        // Self -> AL
{$IFEND ~CPUX64}
  // Initialized
  AND       DX,         ShortInt.Bits - 1
  BT        EAX,        DX
  SETC      AL
  // Finish
end;
{$ELSE ~USE_FORCE_DELPHI}
function TShortIntHelper.TestBit(const Bit: Byte): Boolean;
begin
  Result := (Self shr (Bit and (ShortInt.Bits - 1))) and 1 <> 0;
end;
{$IFEND ~USE_ASSEMBLER}
{$IFEND ~ NOT USE_JEDY_CORE_LIBRARY}

function TShortIntHelper.ToBytes: TBytes;
begin
  SetLength(Result, FSize);
  Result[0] := Self;
end;

{ TWordHelper }

{$IF NOT DEFINED(USE_JEDY_CORE_LIBRARY)}
{$IF DEFINED(USE_ASSEMBLER)}
function TWordHelper.ReverseBits: Word;
type
  TReverse = TByteHelper.TReverse;

asm
{$IF DEFINED(CPUX64)}
  // Start
  // --> RCX address Self
  // <-- RAX Result
  MOV       RDX,        [RCX]        // Self -> RDX
  MOV       RAX,        $0
  TEST      DX,         DX
  JZ        @Ret                     // if Self = 0
  MOV       R8,         offset TReverse.FTable      // address TByteHelper.TReverse.FTable -> R8
  // Initialized
  MOVZX     R9,         DL
  MOV       AL,         [R8 + R9]
  MOV       AH,         AL
  MOV       DL,         DH
  MOVZX     R9,         DL
  MOV       AL,         [R8 + R9]
@Ret:
  // Finish
{$ELSE ~CPUX86}
  PUSH      EBP
  PUSH      EBX
  // Start
  // --> EAX address Self
  // <-- EAX Result
  MOV       EDX,        [EAX]        // Self -> EDX
  MOV       EAX,        $0
  TEST      DX,         DX
  JZ        @Ret                     // if Self = 0
  // Initialized
  MOVZX     EBP,        DL
  ADD       EBP,        offset TReverse.FTable      // address TByteHelper.TReverse.FTable + EBP
  MOV       AH,         [EBP]
  MOVZX     EBP,        DH
  ADD       EBP,        offset TReverse.FTable      // address TByteHelper.TReverse.FTable + EBP
  MOV       AL,         [EBP]
@Ret:
  // Finish
  POP       EBX
  POP       EBP
{$IFEND ~CPUX64}
end;
{$ELSE ~USE_FORCE_DELPHI}
function TWordHelper.ReverseBits: Word;
begin
  if Self = 0 then Exit(0);

  Result := 0;
  var Value: Word := Self;
  for var I: Byte := 1 to Self.FSize do
  begin
    Result := (Result shl Byte.Bits) or Byte.TReverse.FTable[Value and Byte.Mask];
    Value := Value shr Byte.Bits;
  end;
end;
{$IFEND ~USE_ASSEMBLER}

{$IF DEFINED(USE_ASSEMBLER)}
function TWordHelper.ReverseBytes: Word;
asm
  // Start
{$IF DEFINED(CPUX64)}
  // --> RCX address Self
  // <-- RAX Result
  MOV       AH,         [RCX]
  MOV       AL,         [RCX + $1]
  // Initialized
{$ELSE ~CPUX86}
  // --> EAX address Self
  // <-- EAX Result
  MOV       AX,         [EAX]        // Self -> EAX
  // Initialized
  XCHG      AL,         AH
{$IFEND ~CPUX64}
  // Finish
end;
{$ELSE ~USE_FORCE_DELPHI}
function TWordHelper.ReverseBytes: Word;
begin
  Result := (Self shl 8) or (Self shr 8);
end;
{$IFEND ~USE_ASSEMBLER}

{$IF DEFINED(USE_ASSEMBLER)}
function TWordHelper.TestBit(const Bit: Byte): Boolean;
asm
  // Start
  // 64 --> RCX address Self
  //        DL  Bit
  //    <-- AL  Result
  // 32 --> EAX address Self
  //        DL  Bit
  //    <-- AL  Result
{$IF DEFINED(CPUX64)}
  MOV       AX,         [RCX]        // Self -> AX
{$ELSE ~CPUX86}
  MOV       AX,         [EAX]        // Self -> AX
{$IFEND ~CPUX64}
  // Initialized
  AND       DX,         Word.Bits - 1
  BT        EAX,        DX
  SETC      AL
  // Finish
end;
{$ELSE ~USE_FORCE_DELPHI}
function TWordHelper.TestBit(const Bit: Byte): Boolean;
begin
  Result := (Self shr (Bit and (Word.Bits - 1))) and 1 <> 0;
end;
{$IFEND ~USE_ASSEMBLER}
{$IFEND ~ NOT USE_JEDY_CORE_LIBRARY}

function TWordHelper.ToBytes: TBytes;
begin
  SetLength(Result, Self.FSize);
  var Value: Word := Self;
  for var I: Byte := Self.FSize - 1 downto 0 do
  begin
    Result[I] := Value and {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}ByteMask{$ELSE}Byte.Mask{$IFEND};
    Value := Value shr {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}BitsPerByte{$ELSE}Byte.Bits{$IFEND};
  end;
end;

{ TSmallIntHelper }

{$IF NOT DEFINED(USE_JEDY_CORE_LIBRARY)}
{$IF DEFINED(USE_ASSEMBLER)}
function TSmallIntHelper.ReverseBits: SmallInt;
type
  TReverse = TByteHelper.TReverse;

asm
{$IF DEFINED(CPUX64)}
  // Start
  // --> RCX address Self
  // <-- RAX Result
  MOV       RDX,        [RCX]        // Self -> RDX
  MOV       RAX,        $0
  TEST      DX,         DX
  JZ        @Ret                     // if Self = 0
  MOV       R8,         offset TReverse.FTable      // address TByteHelper.TReverse.FTable -> R8
  // Initialized
  MOVZX     R9,         DL
  MOV       AL,         [R8 + R9]
  MOV       AH,         AL
  MOV       DL,         DH
  MOVZX     R9,         DL
  MOV       AL,         [R8 + R9]
@Ret:
  // Finish
{$ELSE ~CPUX86}
  PUSH      EBP
  PUSH      EBX
  // Start
  // --> EAX address Self
  // <-- EAX Result
  MOV       EDX,        [EAX]        // Self -> EDX
  MOV       EAX,        $0
  TEST      DX,         DX
  JZ        @Ret                     // if Self = 0
  // Initialized
  MOVZX     EBP,        DL
  ADD       EBP,        offset TReverse.FTable      // address TByteHelper.TReverse.FTable + EBP
  MOV       AH,         [EBP]
  MOVZX     EBP,        DH
  ADD       EBP,        offset TReverse.FTable      // address TByteHelper.TReverse.FTable + EBP
  MOV       AL,         [EBP]
@Ret:
  // Finish
  POP       EBX
  POP       EBP
{$IFEND ~CPUX64}
end;
{$ELSE ~USE_FORCE_DELPHI}
function TSmallIntHelper.ReverseBits: SmallInt;
begin
  if Self = 0 then Exit(0);

  Result := 0;
  var Value: SmallInt := Self;
  for var I: Byte := 1 to Self.FSize do
  begin
    Result := (Result shl Byte.Bits) or Byte.TReverse.FTable[Value and Byte.Mask];
    Value := Value shr Byte.Bits;
  end;
end;
{$IFEND ~USE_ASSEMBLER}

{$IF DEFINED(USE_ASSEMBLER)}
function TSmallIntHelper.ReverseBytes: SmallInt;
asm
  // Start
{$IF DEFINED(CPUX64)}
  // --> RCX address Self
  // <-- RAX Result
  MOV       AH,         [RCX]
  MOV       AL,         [RCX + $1]
  // Initialized
{$ELSE ~CPUX86}
  // --> EAX address Self
  // <-- EAX Result
  MOV       AX,         [EAX]        // Self -> EAX
  // Initialized
  XCHG      AL,         AH
{$IFEND ~CPUX64}
  // Finish
end;
{$ELSE ~USE_FORCE_DELPHI}
function TSmallIntHelper.ReverseBytes: SmallInt;
begin
  Result := (Self shl 8) or ((Self shr 8) and Byte.Mask);
end;
{$IFEND ~USE_ASSEMBLER}

{$IF DEFINED(USE_ASSEMBLER)}
function TSmallIntHelper.TestBit(const Bit: Byte): Boolean;
asm
  // Start
  // 64 --> RCX address Self
  //        DL  Bit
  //    <-- AL  Result
  // 32 --> EAX address Self
  //        DL  Bit
  //    <-- AL  Result
{$IF DEFINED(CPUX64)}
  MOV       AX,         [RCX]        // Self -> AX
{$ELSE ~CPUX86}
  MOV       AX,         [EAX]        // Self -> AX
{$IFEND ~CPUX64}
  // Initialized
  AND       DX,         SmallInt.Bits - 1
  BT        EAX,        DX
  SETC      AL
  // Finish
end;
{$ELSE ~USE_FORCE_DELPHI}
function TSmallIntHelper.TestBit(const Bit: Byte): Boolean;
begin
  Result := (Self shr (Bit and (SmallInt.Bits - 1))) and 1 <> 0;
end;
{$IFEND ~USE_ASSEMBLER}
{$IFEND ~ NOT USE_JEDY_CORE_LIBRARY}

function TSmallIntHelper.ToBytes: TBytes;
begin
  SetLength(Result, Self.FSize);
  var Value: SmallInt := Self;
  for var I: Byte := Self.FSize - 1 downto 0 do
  begin
    Result[I] := Value and {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}ByteMask{$ELSE}Byte.Mask{$IFEND};
    Value := Value shr {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}BitsPerByte{$ELSE}Byte.Bits{$IFEND};
  end;
end;

{ TCardinalHelper }

{$IF NOT DEFINED(USE_JEDY_CORE_LIBRARY)}
{$IF DEFINED(USE_ASSEMBLER)}
function TCardinalHelper.ReverseBits: Cardinal;
{$IF NOT DEFINED(DELPHIXE4_UP)}
const
  BitsPerByte = Byte.Bits;
  ByteMask    = Byte.Mask;
{$IFEND ~NOT DELPHIXE4_UP}
type
  TReverse = TByteHelper.TReverse;

asm
{$IF DEFINED(CPUX64)}
  // Start
  // --> RCX address Self
  // <-- RAX Result
  MOV       RDX,        [RCX]        // Self -> RDX
  MOV       RAX,        $0
  TEST      EDX,        EDX
  JZ        @Ret                     // if Self = 0
  MOV       RCX,        TCardinalHelper.FSize
  MOV       R8,         offset TReverse.FTable      // address TByteHelper.TReverse.FTable
  // Initialized
@Body:
  SHL       RAX,        BitsPerByte
  MOV       R9,         RDX
  AND       R9,         ByteMask
  OR        AL,         [R8 + R9]
  SHR       RDX,        BitsPerByte
  LOOP      @Body
@Ret:
  // Finish
{$ELSE ~CPUX86}
  PUSH      EBP
  PUSH      EBX
  // Start
  // --> EAX address Self
  // <-- EAX Result
  MOV       EDX,        [EAX]        // Self -> EDX
  MOV       EAX,        $0
  TEST      EDX,        EDX
  JZ        @Ret                     // if Self = 0
  MOV       ECX,        TCardinalHelper.FSize
  MOV       EBP,        offset TReverse.FTable      // address TByteHelper.TReverse.FTable
  // Initialized
@Body:
  SHL       EAX,        BitsPerByte
  MOV       EBX,        EDX
  AND       EBX,        ByteMask
  OR        AL,         [EBP + EBX]
  SHR       EDX,        BitsPerByte
  LOOP      @Body
@Ret:
  // Finish
  POP       EBX
  POP       EBP
{$IFEND ~CPUX64}
end;
{$ELSE ~USE_FORCE_DELPHI}
function TCardinalHelper.ReverseBits: Cardinal;
begin
  if Self = 0 then Exit(0);

  Result := 0;
  var Value: Cardinal := Self;
  for var I: Byte := 1 to Self.FSize do
  begin
    Result := (Result shl Byte.Bits) or Byte.TReverse.FTable[Value and Byte.Mask];
    Value := Value shr Byte.Bits;
  end;
end;
{$IFEND ~USE_ASSEMBLER}

{$IF DEFINED(USE_ASSEMBLER)}
function TCardinalHelper.ReverseBytes: Cardinal;
asm
  // Start
{$IF DEFINED(CPUX64)}
  // --> RCX address Self
  // <-- RAX Result
  MOV       EAX,        [RCX]        // Self -> EAX
  // Initialized
{$ELSE ~CPUX86}
  // --> EAX address Self
  // <-- EAX Result
  MOV       EAX,        [EAX]        // Self -> EAX
{$IFEND ~CPUX64}
  // Initialized
  BSWAP     EAX
  // Finish
end;
{$ELSE ~USE_FORCE_DELPHI}
function TCardinalHelper.ReverseBytes: Cardinal;
begin
  Result := (Self shr 24) or (Self shl 24) or ((Self and $00FF0000) shr 8) or ((Self and $0000FF00) shl 8);
end;
{$IFEND ~USE_ASSEMBLER}

{$IF DEFINED(USE_ASSEMBLER)}
function TCardinalHelper.TestBit(const Bit: Byte): Boolean;
asm
  // Start
  // 64 --> RCX address Self
  //        DL  Bit
  //    <-- AL  Result
  // 32 --> EAX address Self
  //        DL  Bit
  //    <-- AL  Result
{$IF DEFINED(CPUX64)}
  MOV       EAX,        [RCX]        // Self -> EAX
{$ELSE ~CPUX86}
  MOV       EAX,        [EAX]        // Self -> EAX
{$IFEND ~CPUX64}
  // Initialized
  AND       EDX,        Cardinal.Bits - 1
  BT        EAX,        EDX
  SETC      AL
  // Finish
end;
{$ELSE ~USE_FORCE_DELPHI}
function TCardinalHelper.TestBit(const Bit: Byte): Boolean;
begin
  Result := (Self shr (Bit and (Cardinal.Bits - 1))) and 1 <> 0;
end;
{$IFEND ~USE_ASSEMBLER}
{$IFEND ~ NOT USE_JEDY_CORE_LIBRARY}

function TCardinalHelper.ToBytes: TBytes;
begin
  SetLength(Result, Self.FSize);
  var Value: Cardinal := Self;
  for var I: Byte := Self.FSize - 1 downto 0 do
  begin
    Result[I] := Value and {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}ByteMask{$ELSE}Byte.Mask{$IFEND};
    Value := Value shr {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}BitsPerByte{$ELSE}Byte.Bits{$IFEND};
  end;
end;

{ TIntegerHelper }

{$IF NOT DEFINED(USE_JEDY_CORE_LIBRARY)}
{$IF DEFINED(USE_ASSEMBLER)}
function TIntegerHelper.ReverseBits: Integer;
{$IF NOT DEFINED(DELPHIXE4_UP)}
const
  BitsPerByte = Byte.Bits;
  ByteMask    = Byte.Mask;
{$IFEND ~NOT DELPHIXE4_UP}
type
  TReverse = TByteHelper.TReverse;

asm
{$IF DEFINED(CPUX64)}
  // Start
  // --> RCX address Self
  // <-- RAX Result
  MOV       RDX,        [RCX]        // Self -> RDX
  MOV       RAX,        $0
  TEST      EDX,        EDX
  JZ        @Ret                     // if Self = 0
  MOV       RCX,        TIntegerHelper.FSize
  MOV       R8,         offset TReverse.FTable      // address TByteHelper.TReverse.FTable
  // Initialized
@Body:
  SHL       RAX,        BitsPerByte
  MOV       R9,         RDX
  AND       R9,         ByteMask
  OR        AL,         [R8 + R9]
  SHR       RDX,        BitsPerByte
  LOOP      @Body
@Ret:
  // Finish
{$ELSE ~CPUX86}
  PUSH      EBP
  PUSH      EBX
  // Start
  // --> EAX address Self
  // <-- EAX Result
  MOV       EDX,        [EAX]        // Self -> EDX
  MOV       EAX,        $0
  TEST      EDX,        EDX
  JZ        @Ret                     // if Self = 0
  MOV       ECX,        TIntegerHelper.FSize
  MOV       EBP,        offset TReverse.FTable      // address TByteHelper.TReverse.FTable
  // Initialized
@Body:
  SHL       EAX,        BitsPerByte
  MOV       EBX,        EDX
  AND       EBX,        ByteMask
  OR        AL,         [EBP + EBX]
  SHR       EDX,        BitsPerByte
  LOOP      @Body
@Ret:
  // Finish
  POP       EBX
  POP       EBP
{$IFEND ~CPUX64}
end;
{$ELSE ~USE_FORCE_DELPHI}
function TIntegerHelper.ReverseBits: Integer;
begin
  if Self = 0 then Exit(0);

  Result := 0;
  var Value: Integer := Self;
  for var I: Byte := 1 to Self.FSize do
  begin
    Result := (Result shl Byte.Bits) or Byte.TReverse.FTable[Value and Byte.Mask];
    Value := Value shr Byte.Bits;
  end;
end;
{$IFEND ~USE_ASSEMBLER}

{$IF DEFINED(USE_ASSEMBLER)}
function TIntegerHelper.ReverseBytes: Integer;
asm
  // Start
{$IF DEFINED(CPUX64)}
  // --> RCX address Self
  // <-- RAX Result
  MOV       EAX,        [RCX]        // Self -> EAX
  // Initialized
{$ELSE ~CPUX86}
  // --> EAX address Self
  // <-- EAX Result
  MOV       EAX,        [EAX]        // Self -> EAX
{$IFEND ~CPUX64}
  // Initialized
  BSWAP     EAX
  // Finish
end;
{$ELSE ~USE_FORCE_DELPHI}
function TIntegerHelper.ReverseBytes: Integer;
begin
  Result := (Self shr 24) or (Self shl 24) or ((Self and $00FF0000) shr 8) or ((Self and $0000FF00) shl 8);
end;
{$IFEND ~USE_ASSEMBLER}

{$IF DEFINED(USE_ASSEMBLER)}
function TIntegerHelper.TestBit(const Bit: Byte): Boolean;
asm
  // Start
  // 64 --> RCX address Self
  //        DL  Bit
  //    <-- AL  Result
  // 32 --> EAX address Self
  //        DL  Bit
  //    <-- AL  Result
{$IF DEFINED(CPUX64)}
  MOV       EAX,        [RCX]        // Self -> EAX
{$ELSE ~CPUX86}
  MOV       EAX,        [EAX]        // Self -> EAX
{$IFEND ~CPUX64}
  // Initialized
  AND       EDX,        Integer.Bits - 1
  BT        EAX,        EDX
  SETC      AL
  // Finish
end;
{$ELSE ~USE_FORCE_DELPHI}
function TIntegerHelper.TestBit(const Bit: Byte): Boolean;
begin
  Result := (Self shr (Bit and (Integer.Bits - 1))) and 1 <> 0;
end;
{$IFEND ~USE_ASSEMBLER}
{$IFEND ~ NOT USE_JEDY_CORE_LIBRARY}

function TIntegerHelper.ToBytes: TBytes;
begin
  SetLength(Result, Self.FSize);
  var Value: Integer := Self;
  for var I: Byte := Self.FSize - 1 downto 0 do
  begin
    Result[I] := Value and {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}ByteMask{$ELSE}Byte.Mask{$IFEND};
    Value := Value shr {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}BitsPerByte{$ELSE}Byte.Bits{$IFEND};
  end;
end;

{ TUInt64Helper }

{$IF NOT DEFINED(USE_JEDY_CORE_LIBRARY)}
{$IF DEFINED(CPUX64)}
{$IF DEFINED(USE_ASSEMBLER)}
function TUInt64Helper.ReverseBits: UInt64;
{$IF NOT DEFINED(DELPHIXE4_UP)}
const
  BitsPerByte = Byte.Bits;
  ByteMask    = Byte.Mask;
{$IFEND ~NOT DELPHIXE4_UP}
type
  TReverse = TByteHelper.TReverse;

asm
  // Start
  // --> RCX address Self
  // <-- RAX Result
  MOV       RDX,        [RCX]        // Self -> RDX
  MOV       RAX,        $0
  TEST      EDX,        EDX
  JZ        @Ret                     // if Self = 0
  MOV       RCX,        TUInt64Helper.FSize
  MOV       R8,         offset TReverse.FTable      // address TByteHelper.TReverse.FTable
  // Initialized
@Body:
  SHL       RAX,        BitsPerByte
  MOV       R9,         RDX
  AND       R9,         ByteMask
  OR        AL,         [R8 + R9]
  SHR       RDX,        BitsPerByte
  LOOP      @Body
@Ret:
  // Finish
end;
{$ELSE ~USE_FORCE_DELPHI}
function TUInt64Helper.ReverseBits: UInt64;
begin
  if Self = 0 then Exit(0);

  Result := 0;
  var Value: UInt64 := Self;
  for var I: Byte := 1 to Self.FSize do
  begin
    Result := (Result shl Byte.Bits) or Byte.TReverse.FTable[Value and Byte.Mask];
    Value := Value shr Byte.Bits;
  end;
end;
{$IFEND ~USE_ASSEMBLER}
{$ELSE ~CPUX86}
function TUInt64Helper.ReverseBits: UInt64;
begin
  TULargeInteger(Result).LowPart := TULargeInteger(Self).HighPart.ReverseBits;
  TULargeInteger(Result).HighPart := TULargeInteger(Self).LowPart.ReverseBits;
end;
{$IFEND ~CPUX64}

{$IF DEFINED(USE_ASSEMBLER)}
function TUInt64Helper.ReverseBytes: UInt64;
asm
{$IF DEFINED(CPUX64)}
  // Start
  // --> RCX address Self
  // <-- EAX Hi 4 bytes of Result
  // <-- EDX Lo 4 bytes of Result
  MOV       RAX,        [RCX]        // Self -> RAX
  // Initialized
  BSWAP     RAX
  // Finish
{$ELSE ~CPUX86}
  // Start
  // --> EAX address Self
  // <-- EAX Hi 4 bytes of Result
  // <-- EDX Lo 4 bytes of Result
  MOV       EDX,        [EAX]        // Lo 4 bytes of Self -> EDX
  MOV       EAX,        [EAX + $04]  // Hi 4 bytes of Self -> EAX
  // Initialized
  BSWAP     EAX
  BSWAP     EDX
  // Finish
{$IFEND ~CPUX64}
end;
{$ELSE ~USE_FORCE_DELPHI}
function TUInt64Helper.ReverseBytes: UInt64;
begin
{$IF DEFINED(CPUX64)}
  Result :=
    ( Self                        shr 56) or ( Self                        shl 56) or
    ((Self and $00FF000000000000) shr 40) or ((Self and $000000000000FF00) shl 40) or
    ((Self and $0000FF0000000000) shr 24) or ((Self and $0000000000FF0000) shl 24) or
    ((Self and $000000FF00000000) shr 08) or ((Self and $00000000FF000000) shl 08);
{$ELSE ~CPUX86}
  const Lo = TULargeInteger(Self).HighPart;
  const Hi = TULargeInteger(Self).LowPart;
  TULargeInteger(Result).HighPart :=
    (Hi shr 24) or (Hi shl 24) or ((Hi and $00FF0000) shr 8) or ((Hi and $0000FF00) shl 8);
  TULargeInteger(Result).LowPart :=
    (Lo shr 24) or (Lo shl 24) or ((Lo and $00FF0000) shr 8) or ((Lo and $0000FF00) shl 8);
{$IFEND ~CPUX64}
end;
{$IFEND ~USE_ASSEMBLER}

{$IF DEFINED(USE_ASSEMBLER) AND DEFINED(CPUX64)}
function TUInt64Helper.TestBit(const Bit: Byte): Boolean;
{$IF NOT DEFINED(DELPHIXE4_UP)}
const
  BitsPerUInt64 = Byte.Bits;
{$IFEND ~NOT DELPHIXE4_UP}
asm
  // Start
  // --> RCX address Self
  //     DL  Bit
  // <-- AL  Result
  MOV       RAX,        [RCX]        // Self -> RAX
  // Initialized
  AND       RDX,        BitsPerUInt64 - 1
  BT        RAX,        RDX
  SETC      AL
  // Finish
end;
{$ELSE ~USE_FORCE_DELPHI OR CPUX86}
function TUInt64Helper.TestBit(const Bit: Byte): Boolean;
begin
  Result := (Self shr (Bit and (UInt64.Bits - 1))) and 1 <> 0;
end;
{$IFEND ~USE_ASSEMBLER AND CPUX64}
{$IFEND ~ NOT USE_JEDY_CORE_LIBRARY}

function TUInt64Helper.ToBytes: TBytes;
begin
  SetLength(Result, Self.FSize);
  var Value: UInt64 := Self;
  for var I: Byte := Self.FSize - 1 downto 0 do
  begin
    Result[I] := Value and {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}ByteMask{$ELSE}Byte.Mask{$IFEND};
    Value := Value shr {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}BitsPerByte{$ELSE}Byte.Bits{$IFEND};
  end;
end;

{ TInt64Helper }

{$IF NOT DEFINED(USE_JEDY_CORE_LIBRARY)}
{$IF DEFINED(CPUX64)}
{$IF DEFINED(USE_ASSEMBLER)}
function TInt64Helper.ReverseBits: Int64;
{$IF NOT DEFINED(DELPHIXE4_UP)}
const
  BitsPerByte = Byte.Bits;
  ByteMask    = Byte.Mask;
{$IFEND ~NOT DELPHIXE4_UP}
type
  TReverse = TByteHelper.TReverse;

asm
  // Start
  // --> RCX address Self
  // <-- RAX Result
  MOV       RDX,        [RCX]        // Self -> RDX
  MOV       RAX,        $0
  TEST      EDX,        EDX
  JZ        @Ret                     // if Self = 0
  MOV       RCX,        TInt64Helper.FSize
  MOV       R8,         offset TReverse.FTable      // address TByteHelper.TReverse.FTable
  // Initialized
@Body:
  SHL       RAX,        BitsPerByte
  MOV       R9,         RDX
  AND       R9,         ByteMask
  OR        AL,         [R8 + R9]
  SHR       RDX,        BitsPerByte
  LOOP      @Body
@Ret:
  // Finish
end;
{$ELSE ~USE_FORCE_DELPHI}
function TInt64Helper.ReverseBits: Int64;
begin
  if Self = 0 then Exit(0);

  Result := 0;
  var Value: Int64 := Self;
  for var I: Byte := 1 to Self.FSize do
  begin
    Result := (Result shl Byte.Bits) or Byte.TReverse.FTable[Value and Byte.Mask];
    Value := Value shr Byte.Bits;
  end;
end;
{$IFEND ~USE_ASSEMBLER}
{$ELSE ~CPUX86}
function TInt64Helper.ReverseBits: Int64;
begin
  TLargeInteger(Result).LowPart := TLargeInteger(Self).HighPart.ReverseBits;
  TLargeInteger(Result).HighPart := TLargeInteger(Self).LowPart.ReverseBits;
end;
{$IFEND ~CPUX64}

{$IF DEFINED(USE_ASSEMBLER)}
function TInt64Helper.ReverseBytes: Int64;
asm
{$IF DEFINED(CPUX64)}
  // Start
  // --> RCX address Self
  // <-- EAX Hi 4 bytes of Result
  // <-- EDX Lo 4 bytes of Result
  MOV       RAX,        [RCX]        // Self -> RAX
  // Initialized
  BSWAP     RAX
  // Finish
{$ELSE ~CPUX86}
  // Start
  // --> EAX address Self
  // <-- EAX Hi 4 bytes of Result
  // <-- EDX Lo 4 bytes of Result
  MOV       EDX,        [EAX]        // Lo 4 bytes of Self -> EDX
  MOV       EAX,        [EAX + $04]  // Hi 4 bytes of Self -> EAX
  // Initialized
  BSWAP     EAX
  BSWAP     EDX
  // Finish
{$IFEND ~CPUX64}
end;
{$ELSE ~USE_FORCE_DELPHI}
function TInt64Helper.ReverseBytes: Int64;
begin
{$IF DEFINED(CPUX64)}
  Result :=
    ( Self                        shr 56) or ( Self                        shl 56) or
    ((Self and $00FF000000000000) shr 40) or ((Self and $000000000000FF00) shl 40) or
    ((Self and $0000FF0000000000) shr 24) or ((Self and $0000000000FF0000) shl 24) or
    ((Self and $000000FF00000000) shr 08) or ((Self and $00000000FF000000) shl 08);
{$ELSE ~CPUX86}
  const Lo = TLargeInteger(Self).HighPart;
  const Hi = TLargeInteger(Self).LowPart;
  TLargeInteger(Result).HighPart :=
    (Hi shr 24) or (Hi shl 24) or ((Hi and $00FF0000) shr 8) or ((Hi and $0000FF00) shl 8);
  TLargeInteger(Result).LowPart :=
    (Lo shr 24) or (Lo shl 24) or ((Lo and $00FF0000) shr 8) or ((Lo and $0000FF00) shl 8);
{$IFEND ~CPUX64}
end;
{$IFEND ~USE_ASSEMBLER}

{$IF DEFINED(USE_ASSEMBLER) AND DEFINED(CPUX64)}
function TInt64Helper.TestBit(const Bit: Byte): Boolean;
{$IF NOT DEFINED(DELPHIXE4_UP)}
const
  BitsPerInt64 = Byte.Bits;
{$IFEND ~NOT DELPHIXE4_UP}
asm
  // Start
  // --> RCX address Self
  //     DL  Bit
  // <-- AL  Result
  MOV       RAX,        [RCX]        // Self -> RAX
  // Initialized
  AND       RDX,        BitsPerInt64 - 1
  BT        RAX,        RDX
  SETC      AL
  // Finish
end;
{$ELSE ~USE_FORCE_DELPHI OR CPUX86}
function TInt64Helper.TestBit(const Bit: Byte): Boolean;
begin
  Result := (Self shr (Bit and (Int64.Bits - 1))) and 1 <> 0;
end;
{$IFEND ~USE_ASSEMBLER AND CPUX64}
{$IFEND ~ NOT USE_JEDY_CORE_LIBRARY}

function TInt64Helper.ToBytes: TBytes;
begin
  SetLength(Result, Self.FSize);
  var Value: Int64 := Self;
  for var I: Byte := Self.FSize - 1 downto 0 do
  begin
    Result[I] := Value and {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}ByteMask{$ELSE}Byte.Mask{$IFEND};
    Value := Value shr {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}BitsPerByte{$ELSE}Byte.Bits{$IFEND};
  end;
end;

{ TNativeUIntHelper }

function TNativeUIntHelper.ReverseBits: NativeUInt;
begin
{$IF DEFINED(USE_JEDY_CORE_LIBRARY)}
  Result := JclLogic.ReverseBits(TWrapper(Self));
{$ELSE ~ NOT USE_JEDY_CORE_LIBRARY}
  Result := TWrapper(Self).ReverseBits;
{$IFEND ~USE_JEDY_CORE_LIBRARY}
end;

function TNativeUIntHelper.ReverseBytes: NativeUInt;
begin
{$IF DEFINED(USE_JEDY_CORE_LIBRARY)}
  Result := JclLogic.ReverseBytes(TWrapper(Self));
{$ELSE ~ NOT USE_JEDY_CORE_LIBRARY}
  Result := TWrapper(Self).ReverseBytes;
{$IFEND ~USE_JEDY_CORE_LIBRARY}
end;

function TNativeUIntHelper.TestBit(const Bit: Byte): Boolean;
begin
{$IF DEFINED(USE_JEDY_CORE_LIBRARY)}
  Result := JclLogic.TestBit(TWrapper(Self), Bit);
{$ELSE ~ NOT USE_JEDY_CORE_LIBRARY}
  Result := TWrapper(Self).TestBit(Bit);
{$IFEND ~USE_JEDY_CORE_LIBRARY}
end;

function TNativeUIntHelper.ToBytes: TBytes;
begin
  Result := TWrapper(Self).ToBytes;
end;

{ TNativeIntHelper }

function TNativeIntHelper.ReverseBits: NativeInt;
begin
{$IF DEFINED(USE_JEDY_CORE_LIBRARY)}
  Result := JclLogic.ReverseBits(TWrapper(Self));
{$ELSE ~ NOT USE_JEDY_CORE_LIBRARY}
  Result := TWrapper(Self).ReverseBits;
{$IFEND ~USE_JEDY_CORE_LIBRARY}
end;

function TNativeIntHelper.ReverseBytes: NativeInt;
begin
{$IF DEFINED(USE_JEDY_CORE_LIBRARY)}
  Result := JclLogic.ReverseBytes(TWrapper(Self));
{$ELSE ~ NOT USE_JEDY_CORE_LIBRARY}
  Result := TWrapper(Self).ReverseBytes;
{$IFEND ~USE_JEDY_CORE_LIBRARY}
end;

function TNativeIntHelper.TestBit(const Bit: Byte): Boolean;
begin
{$IF DEFINED(USE_JEDY_CORE_LIBRARY)}
  Result := JclLogic.TestBit(TWrapper(Self), Bit);
{$ELSE ~ NOT USE_JEDY_CORE_LIBRARY}
  Result := TWrapper(Self).TestBit(Bit);
{$IFEND ~USE_JEDY_CORE_LIBRARY}
end;

function TNativeIntHelper.ToBytes: TBytes;
begin
  Result := TWrapper(Self).ToBytes;
end;

{ TPointerHelper }

{$IF NOT DEFINED(USE_JEDY_CORE_LIBRARY)}
procedure TPointerHelper.ReverseBits(const Length: Cardinal);
begin
  if (Self = nil) or (Length = 0) then Exit;

  var P1: PByte := Self;
  var P2: PByte := Self;
  Inc(P2, Length - 1);
  while NativeUInt(P1) < NativeUInt(P2) do
  begin
    const T: Byte = Byte.TReverse.FTable[P1^];
    P1^ := Byte.TReverse.FTable[P2^];
    P2^ := T;
    Inc(P1);
    Dec(P2);
  end;
  if P1 = P2 then P1^ := Byte.TReverse.FTable[P1^];
end;

procedure TPointerHelper.ReverseBytes(const Length: Cardinal);
begin
  if (Self = nil) or (Length = 0) then Exit;

  var P1: PByte := Self;
  var P2: PByte := Self;
  Inc(P2, Length - 1);
  while NativeUInt(P1) < NativeUInt(P2) do
  begin
    const T: Byte = P1^;
    P1^ := P2^;
    P2^ := T;
    Inc(P1);
    Dec(P2);
  end;
end;

{$IF DEFINED(USE_ASSEMBLER)}
function TPointerHelper.TestBit(const Bit: Cardinal): Boolean;
asm
  // Start
{$IF DEFINED(CPUX64)}
  // --> RCX address Self
  //     DL  Bit
  // <-- AL  Result
  MOV       RAX,        [RCX]        // Self -> RAX
  BT        [RAX],      Bit
{$ELSE ~CPUX86}
  // --> EAX address Self
  //     DL  Bit
  // <-- AL  Result
  MOV       EAX,        [EAX]        // Self -> EAX
  BT        [EAX],      Bit
{$IFEND ~CPUX64}
  // Initialized
  SETC      AL
  // Finish
end;
{$ELSE ~USE_FORCE_DELPHI}
function TPointerHelper.TestBit(const Bit: Cardinal): Boolean;
begin
  var P: PByte := Self;
  Inc(P, Bit div Byte.Bits);
  const BitOfs: Byte = Bit mod Byte.Bits;
  Result := (P^).TestBit(BitOfs);
end;
{$IFEND ~USE_ASSEMBLER}
{$IFEND ~ NOT USE_JEDY_CORE_LIBRARY}

function TPointerHelper.ToBytes(const Length: Cardinal): TBytes;
begin
  if Self = nil then Exit;

  SetLength(Result, Length);
  var Value: PByte := Self;
  for var I: Integer := 0 to Length - 1 do
  begin
    Result[I] := (Value + I)^;
  end;
end;

{$IF DEFINED(CPUX64)}
{$IF NOT DEFINED(USE_JEDY_CORE_LIBRARY)}
procedure TPointerHelper.ReverseBits(const Length: Int64);
begin
  if (Self = nil) or (Length < 1) then Exit;

  var P1: PByte := Self;
  var P2: PByte := Self;
  Inc(P2, Length - 1);
  while NativeUInt(P1) < NativeUInt(P2) do
  begin
    const T: Byte = Byte.TReverse.FTable[P1^];
    P1^ := Byte.TReverse.FTable[P2^];
    P2^ := T;
    Inc(P1);
    Dec(P2);
  end;
  if P1 = P2 then P1^ := Byte.TReverse.FTable[P1^];
end;

procedure TPointerHelper.ReverseBytes(const Length: Int64);
begin
  if (Self = nil) or (Length < 1) then Exit;

  var P1: PByte := Self;
  var P2: PByte := Self;
  Inc(P2, Length - 1);
  while NativeUInt(P1) < NativeUInt(P2) do
  begin
    const T: Byte = P1^;
    P1^ := P2^;
    P2^ := T;
    Inc(P1);
    Dec(P2);
  end;
end;

{$IF DEFINED(USE_ASSEMBLER)}
function TPointerHelper.TestBit(const Bit: Int64): Boolean;
asm
  // Start
  // --> RCX address Self
  //     DL  Bit
  // <-- AL  Result
  MOV       RAX,        [RCX]        // Self -> RAX
  BT        [RAX],      Bit
  // Initialized
  SETC      AL
  // Finish
end;
{$ELSE ~USE_FORCE_DELPHI}
function TPointerHelper.TestBit(const Bit: Int64): Boolean;
begin
  var P: PByte := Self;
  Inc(P, Bit div Byte.Bits);
  const BitOfs: Byte = Bit mod Byte.Bits;
  Result := (P^).TestBit(BitOfs);
end;
{$IFEND ~USE_ASSEMBLER}
{$IFEND ~ NOT USE_JEDY_CORE_LIBRARY}

function TPointerHelper.ToBytes(const Length: Int64): TBytes;
begin
  if Self = nil then Exit;

  SetLength(Result, Length);
  var Value: PByte := Self;
  for var I: Integer := 0 to Length - 1 do
  begin
    Result[I] := (Value + I)^;
  end;
end;
{$IFEND}

end.

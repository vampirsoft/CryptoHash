/////////////////////////////////////////////////////////////////////////////////
//*****************************************************************************//
//* Project      : CryptoHash                                                 *//
//* Latest Source: https://github.com/vampirsoft/CryptoHash                   *//
//* Unit Name    : CryptoHash.inc                                             *//
//* Author       : Сергей (LordVampir) Дворников                              *//
//* Based on     :                                                            *//
//*              - http://guildalfa.ru/alsha/node/4                           *//
//*              - https://create.stephan-brumme.com/crc32/                   *//
//*              - https://github.com/meetanthony/crcjava                     *//
//*              - https://stackoverflow.com/questions/29915764/generic-crc-8-16-32-64-combine-implementation
//* Copyright 2019 LordVampir (https://github.com/vampirsoft)                 *//
//* Licensed under the Apache License, Version 2.0                            *//
//*****************************************************************************//
/////////////////////////////////////////////////////////////////////////////////

unit chHash.CRC.Impl;

{$INCLUDE CryptoHash.inc}

interface

uses
  System.SysUtils, System.Generics.Collections,
{$IF DEFINED(USE_JEDI_CORE_LIBRARY)}
  JclLogic,
{$ELSE ~ NOT USE_JEDI_CORE_LIBRARY}
  chHash.Core.Bits,
{$ENDIF ~ USE_JEDI_CORE_LIBRARY}
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC,
  chHash.Impl;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash;
{$ENDIF ~ SUPPORTS_INTERFACES}

type

{ TchCrc<Bits> }

  TchCrc<Bits> = class abstract(TchAlgorithm<Bits, Bits>{$IF DEFINED(SUPPORTS_INTERFACES)}, IchCrc<Bits>{$ENDIF})
  strict private const
    TABLE_RESIDUE_SIZE = Byte(255);
  {$IF DEFINED(HASH_TESTS)}
  public type
  {$ELSE}
  strict private type
  {$ENDIF ~ HASH_TESTS}
    TOneLevelCrcTable = array[0..TABLE_RESIDUE_SIZE] of Bits;
  strict private type
    TCrcTable = TArray<TOneLevelCrcTable>;
  strict protected
    FCrcTable: TCrcTable;      // Only first field
  strict private
    FWidth: Byte;
    FPolynomial: Bits;
    FXorOut: Bits;
    FRefIn: Boolean;
    FRefOut: Boolean;
    FAliases: TList<string>;
  {$IF DEFINED(HASH_TESTS)}
    FBlockSize: Byte;
    function GetCrcTable: TOneLevelCrcTable;{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}
  {$ENDIF ~ HASH_TESTS}
    function Gf2MatrixTimes(const Mat: TArray<Bits>; Vec: Bits): Bits;{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}
    procedure Gf2MatrixSquare(Square: TArray<Bits>; const Mat: TArray<Bits>);{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}
    procedure GenerateTable(const BlockSize: Byte);{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}
  strict protected
    FMask: Bits;
    constructor Create(const Name: string; const Width, BlockSize: Byte; const Polynomial, Init, XorOut, Check: Bits;
      const RefIn, RefOut: Boolean); reintroduce;
  {$IF DEFINED(HASH_TESTS)}
  public
  {$ENDIF ~ HASH_TESTS}
    function ByteToBits(const Value: Byte): Bits; virtual; abstract;
    function BitsToByte(const Value: Bits): Byte; virtual; abstract;
    function LeftShift(const Value: Bits; const Bits: Byte): Bits; virtual; abstract;
    function RightShift(const Value: Bits; const Bits: Byte): Bits; virtual; abstract;
    function BitwiseAnd(const Left, Right: Bits): Bits; virtual; abstract;
    function BitwiseOr(const Left, Right: Bits): Bits; virtual; abstract;
    function BitwiseXor(const Left, Right: Bits): Bits; virtual; abstract;
    function Subtract(const Left, Right: Bits): Bits; virtual; abstract;
    function IsZero(const Value: Bits): Boolean; virtual; abstract;
  public
    destructor Destroy; override;
    procedure Calculate(var Current: Bits; const Data: Pointer; const Length: Cardinal); override;
    function Final(const Current: Bits): Bits; override;
    function Combine(const LeftCrc, RightCrc: Bits; const RightLength: Cardinal): Bits;{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}
    function Polynomial: Bits;{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}
  {$IF DEFINED(SUPPORTS_INTERFACES)}
    function Width: Byte;{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}
    function XorOut: Bits;{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}
    function RefIn: Boolean;{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}
    function RefOut: Boolean;{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}
    function Aliases: TList<string>;{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}
  {$ELSE ~ NOT SUPPORTS_INTERFACES}
    property Width: Byte read FWidth;
    property XorOut: Bits read FXorOut;
    property RefIn: Boolean read FRefIn;
    property RefOut: Boolean read FRefOut;
    property Aliases: TList<string> read FAliases;
  {$ENDIF ~ SUPPORTS_INTERFACES}
    function ToString: string; override;
  {$IF DEFINED(HASH_TESTS)}
    property CrcTable: TOneLevelCrcTable read GetCrcTable;
    property Mask: Bits read FMask;
    property BlockSize: Byte read FBlockSize;
  {$ENDIF ~ HASH_TESTS}
  end;

implementation

{ TchCrc<Bits> }

constructor TchCrc<Bits>.Create(const Name: string; const Width, BlockSize: Byte;
  const Polynomial, Init, XorOut, Check: Bits; const RefIn, RefOut: Boolean);
const
  SizeOfBits = Byte(SizeOf(Bits));

begin
  var I := Init;
  if RefIn then
  begin
    ReverseBits(@I, SizeOfBits);
    if Width < BitsPerByte then I := RightShift(I, BitsPerByte - Width);  // I := I shr (BitsPerByte - Width)
  end;
  inherited Create(Name, I, Check);
  FPolynomial := Polynomial;
  FXorOut := XorOut;
  FRefIn := RefIn;
  FRefOut := RefOut;
  FWidth := Width;

  const OneByte = ByteToBits(1);
// HighBitMask = 1 shl (Width - 1);
// FMask := ((HighBitMask - 1) shl 1) or 1;
  FMask := BitwiseOr(LeftShift(Subtract(LeftShift(OneByte, Width - 1), OneByte), 1), OneByte);

  FAliases := TList<string>.Create;
  GenerateTable(BlockSize);
{$IF DEFINED(HASH_TESTS)}
  FBlockSize := BlockSize;
{$ENDIF ~ HASH_TESTS}
end;

destructor TchCrc<Bits>.Destroy;
begin
  FreeAndNil(FAliases);
end;

procedure TchCrc<Bits>.Calculate(var Current: Bits; const Data: Pointer; const Length: Cardinal);
begin
  if (Data = nil) or (Length = 0) then Exit;

  var L := Length;
  var PData: PByte := Data;
  while L > 0 do
  begin
//    Current := (Current shr BitsPerByte) xor FCrcTable[0, Byte((PData^ xor Current))];
    Current :=
      BitwiseXor(RightShift(Current, BitsPerByte), FCrcTable[0, BitsToByte(BitwiseXor(ByteToBits(PData^), Current))]);
    Inc(PData);
    Dec(L);
  end;
end;

function TchCrc<Bits>.Combine(const LeftCrc, RightCrc: Bits; const RightLength: Cardinal): Bits;
const
  SizeOfBits  = Byte(SizeOf(Bits));
  BitsPerBits = Byte(SizeOfBits * BitsPerByte);

begin
  if RightLength = 0 then Exit(LeftCrc);

  const IsReverse = FRefIn xor FRefOut;
  const ShiftToBits  = BitsPerBits - FWidth;

  var LCrc := BitwiseXor(LeftCrc, FXorOut);     // LCrc := LeftCrc xor FXorOut
  var RCrc := BitwiseXor(RightCrc, FXorOut);    // RCrc := RightCrc xor FXorOut
  if IsReverse then
  begin
    LCrc := LeftShift(LCrc, ShiftToBits);       // LCrc := LCrc shl ShiftToBits
    ReverseBits(@LCrc, SizeOfBits);

    RCrc := LeftShift(RCrc, ShiftToBits);       // RCrc := RCrc shl ShiftToBits
    ReverseBits(@RCrc, SizeOfBits);
  end;

  var Odd := InitArray<Bits>(FWidth);
  var Even := InitArray<Bits>(FWidth);

  Result := BitwiseXor(LCrc, FInit);            // Result := LCrc xor FInit
  const Start = IfThenElse<Byte>(FRefIn, 1, 0);
  const Count = Start + FWidth - 1;
  Odd[IfThenElse<Byte>(FRefIn, 0, Count)] := Polynomial;
  var Col := ByteToBits(2 - Start);
  for var I := Start to Count - 1 do
  begin
    Odd[I] := Col;
    Col := LeftShift(Col, 1);                   //  Col := Col shl 1
  end;

  Gf2MatrixSquare(Even, Odd);
  Gf2MatrixSquare(Odd, Even);

  var Length := RightLength;
  repeat
    Gf2MatrixSquare(Even, Odd);
    if TestBit(Length, 0) then Result := Gf2MatrixTimes(Even, Result);
    Length := Length shr 1;

    if Length = 0 then Break;

    Gf2MatrixSquare(Odd, Even);
    if TestBit(Length, 0) then Result := Gf2MatrixTimes(Odd, Result);
    Length := Length shr 1;
  until Length = 0;

  Result := BitwiseXor(Result, RCrc);           // Result := Result xor RCrc
  if IsReverse then
  begin
    ReverseBits(@Result, SizeOfBits);
    Result := RightShift(Result, ShiftToBits);  // Result := Result shr ShiftToBits
  end;
  Result := BitwiseXor(Result, FXorOut);        // Result := Result xor FXorOut
end;

procedure TchCrc<Bits>.Gf2MatrixSquare(Square: TArray<Bits>; const Mat: TArray<Bits>);
begin
  for var I := 0 to FWidth - 1 do
  begin
    Square[I] := Gf2MatrixTimes(Mat, Mat[I]);
  end;
end;

function TchCrc<Bits>.Gf2MatrixTimes(const Mat: TArray<Bits>; Vec: Bits): Bits;
begin
  Result := ByteToBits(0);
  var I := 0;
  while not IsZero(Vec) do
  begin
    if TestBitBuffer(Vec, 0) then Result := BitwiseXor(Result, Mat[I]); // Result := Result xor Mat[I]
    Vec := RightShift(Vec, 1);
    Inc(I);
  end;
end;

procedure TchCrc<Bits>.GenerateTable(const BlockSize: Byte);
const
  SizeOfByte  = Byte(SizeOf(Byte));
  SizeOfBits  = Byte(SizeOf(Bits));
  BitsPerBits = Byte(SizeOfBits * BitsPerByte);

begin
  SetLength(FCrcTable, BlockSize);

  const IsSmall = FWidth < BitsPerByte;
  const IsShifted = (not FRefIn and IsSmall) or not IsSmall;

  const HighBitMask = IfThenElse<Byte>(IsSmall, BitsPerByte, FWidth) - 1;
  const ShiftToBits  = IfThenElse<Byte>(IsShifted, BitsPerBits, FWidth) - FWidth;
  const ShiftToWidth = Abs(IfThenElse<Byte>(IsShifted, FWidth, BitsPerByte) - BitsPerByte);
  var Poly := FPolynomial;
  if IsSmall then Poly := LeftShift(Poly, BitsPerByte - FWidth);      // Poly := Poly shl (BitsPerByte - FWidth)

  for var I := 0 to TABLE_RESIDUE_SIZE do
  begin
    var Current := ByteToBits(I);
    if FRefIn then ReverseBits(@Current, SizeOfByte);
    if not IsSmall then Current := LeftShift(Current, ShiftToWidth);  // Current := Current shl ShiftToWidth

    for var Bit := 1 to BitsPerByte do
    begin
      const TestBit = TestBitBuffer(Current, HighBitMask);
      Current := LeftShift(Current, 1);                               // Current := Current shl 1
      if TestBit then Current := BitwiseXor(Current, Poly);           // Current := Current xor FPolynomial
    end;

    if FRefIn then
    begin
      Current := LeftShift(Current, ShiftToBits);                     // Current := Current shl ShiftToBits
      ReverseBits(@Current, SizeOfBits);
    end;
    if IsSmall then Current := RightShift(Current, ShiftToWidth);     // Current := Current shr ShiftToWidth
    Current := BitwiseAnd(Current, FMask);                            // Current := Current and FMask
    if not FRefIn then
    begin
      Current := LeftShift(Current, ShiftToBits);                     // Current := Current shl ShiftToBits
      ReverseBytes(@Current, SizeOfBits);
    end;
    FCrcTable[0, I] := Current;
  end;

  if BlockSize > 1 then
  begin
    for var I := 0 to TABLE_RESIDUE_SIZE do
    begin
      var Current := FCrcTable[0, I];
      for var J := 1 to BlockSize - 1 do
      begin
//        Current := (Current shr BitsPerByte) xor FCrcTable[0, Byte(Current)]
        Current := BitwiseXor(RightShift(Current, BitsPerByte), FCrcTable[0, BitsToByte(Current)]);
        FCrcTable[J, I] := Current;
      end;
    end;
  end;
end;

function TchCrc<Bits>.Final(const Current: Bits): Bits;
const
  SizeOfBits  = Byte(SizeOf(Bits));
  BitsPerBits = Byte(SizeOfBits * BitsPerByte);

begin
  Result := Current;

  if not FRefIn then
  begin
    ReverseBytes(@Result, SizeOfBits);
    Result := RightShift(Result, BitsPerBits - FWidth);       // Result := Result shr (BitsPerBits - FWidth)
  end;

  if FRefIn xor FRefOut then
  begin
    Result := LeftShift(Result, BitsPerBits - FWidth);        // Result := Result shl (BitsPerBits - FWidth)
    ReverseBits(@Result, SizeOfBits);
  end;

  Result := BitwiseAnd(BitwiseXor(Result, FXorOut), FMask);   // Result := (Result xor FXorOut) and FMask
end;

function TchCrc<Bits>.Polynomial: Bits;
const
  SizeOfBits  = Byte(SizeOf(Bits));
  BitsPerBits = Byte(SizeOfBits * BitsPerByte);

begin
  Result := FPolynomial;
  if FRefIn then begin
    ReverseBits(@Result, SizeOfBits);
    Result := RightShift(Result, BitsPerBits - FWidth);       // Result := Result shr (BitsPerBits - FWidth);
  end;
end;

{$IF DEFINED(SUPPORTS_INTERFACES)}
function TchCrc<Bits>.Width: Byte;
begin
  Result := FWidth;
end;

function TchCrc<Bits>.XorOut: Bits;
begin
  Result := FXorOut;
end;

function TchCrc<Bits>.RefIn: Boolean;
begin
  Result := FRefIn;
end;

function TchCrc<Bits>.RefOut: Boolean;
begin
  Result := FRefOut;
end;

function TchCrc<Bits>.Aliases: TList<string>;
begin
  Result := FAliases;
end;
{$ENDIF ~ SUPPORTS_INTERFACES}

function TchCrc<Bits>.ToString: string;
begin
  Result := Format('%s (%db)', [Name, FWidth]);
end;

{$IF DEFINED(HASH_TESTS)}
function TchCrc<Bits>.GetCrcTable: TOneLevelCrcTable;
const
  SizeOfBits  = Byte(SizeOf(Bits));
  BitsPerBits = Byte(SizeOfBits * BitsPerByte);

begin
  Result := FCrcTable[0];
  if not FRefIn then
  begin
    const ShiftToBits  = BitsPerBits - FWidth;
    for var I := 0 to TABLE_RESIDUE_SIZE do
    begin
      ReverseBytes(@Result[I], SizeOfBits);
      Result[I] := RightShift(Result[I], ShiftToBits);   // Result := Result shr ShiftToBits;
    end;
  end;
end;
{$ENDIF ~ HASH_TESTS}

end.

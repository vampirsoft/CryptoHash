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

unit chHash.CRC;

{$INCLUDE CryptoHash.inc}

interface

uses
  System.SysUtils, System.Generics.Collections,
{$IF DEFINED(USE_JEDI_CORE_LIBRARY)}
  JclLogic,
{$ELSE ~ NOT USE_JEDI_CORE_LIBRARY}
  chHash.Core.Bits,
{$ENDIF ~ USE_JEDI_CORE_LIBRARY}
  chHash;

type

{ TchCrcAlgorithm<Bits> }

  TchCrcAlgorithm<Bits> = class abstract(TchAlgorithm<Bits, Bits>)
  strict private const
    TABLE_RESIDUE_SIZE = Byte(255);
    TABLE_FIRST_LEVEL  = Byte({$IF DEFINED(USE_ASSEMBLER)}0{$ELSE}1{$ENDIF});
  strict protected const
    TABLE_LEVEL_SIZE   = Byte({$IF DEFINED(USE_ASSEMBLER)}7{$ELSE}16{$ENDIF});
  {$IF DEFINED(HASH_TESTS)}
  public type
  {$ELSE}
  strict private type
  {$ENDIF ~ HASH_TESTS}
    TOneLevelCrcTable = array[0..TABLE_RESIDUE_SIZE] of Bits;
  strict private type
    TCrcTable = array[TABLE_FIRST_LEVEL..TABLE_LEVEL_SIZE] of TOneLevelCrcTable;
  strict protected
    FCrcTable: TCrcTable;      // Only first field
  strict private
    FWidth: Byte;
    FPolynomial: Bits;
    FXorOut: Bits;
    FRefIn: Boolean;
    FRefOut: Boolean;
    function GetPolynomial: Bits;{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}
  {$IF DEFINED(HASH_TESTS)}
    function GetCrcTable: TOneLevelCrcTable; inline;
  {$ENDIF ~ HASH_TESTS}
    function Gf2MatrixTimes(const Mat: TArray<Bits>; Vec: Bits): Bits;{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}
    procedure Gf2MatrixSquare(Square: TArray<Bits>; const Mat: TArray<Bits>);{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}
    procedure GenerateTable;{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}
  strict protected
    FAliases: TList<string>;
    function ByteToBits(const Value: Byte): Bits; virtual; abstract;
    function BitsToByte(const Value: Bits): Byte; virtual; abstract;
    function LeftShift(const Value: Bits; const Bits: Byte): Bits; virtual; abstract;
    function RightShift(const Value: Bits; const Bits: Byte): Bits; virtual; abstract;
    function BitwiseXor(const Left, Right: Bits): Bits; virtual; abstract;
    function IsZero(const Value: Bits): Boolean; virtual; abstract;
  protected
    constructor Create(const Name: string; const Polynomial, Init, XorOut, Check: Bits;
      const RefIn, RefOut: Boolean); reintroduce;
  public
    destructor Destroy; override;
    function Final(const Current: Bits): Bits; override;
    function Combine(const LeftCrc, RightCrc: Bits; const RightLength: Cardinal): Bits;
    function ToString: string; override;
    property Aliases: TList<string> read FAliases;
    property Width: Byte read FWidth;
    property Polynomial: Bits read GetPolynomial;
    property XorOut: Bits read FXorOut;
    property RefIn: Boolean read FRefIn;
    property RefOut: Boolean read FRefOut;
  {$IF DEFINED(HASH_TESTS)}
    property CrcTable: TOneLevelCrcTable read GetCrcTable;
  {$ENDIF ~ HASH_TESTS}
  end;

implementation

{ TchCrcAlgorithm<Bits> }

function TchCrcAlgorithm<Bits>.Combine(const LeftCrc, RightCrc: Bits; const RightLength: Cardinal): Bits;
begin
  if IsZero(RightCrc) or (RightLength = 0) then Exit(LeftCrc);

  var Odd := InitArray<Bits>(FWidth);
  var Even := InitArray<Bits>(FWidth);

  Result := BitwiseXor(LeftCrc, BitwiseXor(Init, FXorOut));
  const Start = IfThenElse<Byte>(FRefIn, 1, 0);
  const Count = Start + FWidth - 1;
  Odd[IfThenElse<Byte>(FRefIn, 0, Count)] := Polynomial;
  var Row := ByteToBits(2 - Start);
  for var I := Start to Count - 1 do
  begin
    Odd[I] := Row;
    Row := LeftShift(Row, 1);
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

  Result := BitwiseXor(Result, RightCrc);
end;

constructor TchCrcAlgorithm<Bits>.Create(const Name: string; const Polynomial, Init, XorOut, Check: Bits;
  const RefIn, RefOut: Boolean);
const SizeOfBits = Byte(SizeOf(Bits));
begin
  inherited Create(Name, Init, Check);
  FAliases := TList<string>.Create;
  FPolynomial := Polynomial;
  FXorOut := XorOut;
  FRefIn := RefIn;
  FRefOut := RefOut;
  FWidth := SizeOfBits * BitsPerByte;
  GenerateTable;
end;

destructor TchCrcAlgorithm<Bits>.Destroy;
begin
  FreeAndNil(FAliases);
end;

function TchCrcAlgorithm<Bits>.Final(const Current: Bits): Bits;
const SizeOfBits = Byte(SizeOf(Bits));
begin
  if not FRefOut then ReverseBytes(@Current, SizeOfBits);
  Result := BitwiseXor(Current, FXorOut);
end;

procedure TchCrcAlgorithm<Bits>.GenerateTable;
const SizeOfBits = Byte(SizeOf(Bits));
begin
  for var I := 0 to TABLE_RESIDUE_SIZE do
  begin
    var Current := ByteToBits(I);
    if FRefIn then ReverseBits(@Current, SizeOfBits) else Current := LeftShift(Current, FWidth - BitsPerByte);
    for var J := 1 to BitsPerByte do
    begin
      const TestBit = TestBitBuffer(Current, FWidth - 1);
      Current := LeftShift(Current, 1);
      if TestBit then Current := BitwiseXor(Current, FPolynomial);
    end;
    if FRefOut then ReverseBits(@Current, SizeOfBits) else ReverseBytes(@Current, SizeOfBits);
    FCrcTable[TABLE_FIRST_LEVEL, I] := Current;
  end;

  for var I := 0 to TABLE_RESIDUE_SIZE do
  begin
    var Current := FCrcTable[TABLE_FIRST_LEVEL, I];
    for var J := TABLE_FIRST_LEVEL + 1 to TABLE_LEVEL_SIZE do
    begin
      Current := BitwiseXor(RightShift(Current, BitsPerByte), FCrcTable[TABLE_FIRST_LEVEL, BitsToByte(Current)]);
      FCrcTable[J, I] := Current;
    end;
  end;
end;

function TchCrcAlgorithm<Bits>.GetPolynomial: Bits;
const SizeOfBits = Byte(SizeOf(Bits));
begin
  Result := FPolynomial;
  if FRefIn then ReverseBits(@Result, SizeOfBits);
end;

procedure TchCrcAlgorithm<Bits>.Gf2MatrixSquare(Square: TArray<Bits>; const Mat: TArray<Bits>);
begin
  for var I := 0 to FWidth - 1 do
  begin
    Square[I] := Gf2MatrixTimes(Mat, Mat[I]);
  end;
end;

function TchCrcAlgorithm<Bits>.Gf2MatrixTimes(const Mat: TArray<Bits>; Vec: Bits): Bits;
begin
  Result := ByteToBits(0);
  var I := 0;
  while not IsZero(Vec) do
  begin
    if TestBitBuffer(Vec, 0) then Result := BitwiseXor(Result, Mat[I]);
    Vec := RightShift(Vec, 1);
    Inc(I);
  end;
end;

{$IF DEFINED(HASH_TESTS)}
function TchCrcAlgorithm<Bits>.GetCrcTable: TOneLevelCrcTable;
const SizeOfBits = Byte(SizeOf(Bits));
begin
  Result := FCrcTable[TABLE_FIRST_LEVEL];
  if not FRefOut then
  begin
    for var I := 0 to TABLE_RESIDUE_SIZE do
    begin
      ReverseBytes(@Result[I], SizeOfBits);
    end;
  end;
end;
{$ENDIF ~ HASH_TESTS}

function TchCrcAlgorithm<Bits>.ToString: string;
begin
  Result := Format('%s (%db)', [FName, FWidth]);
end;

end.

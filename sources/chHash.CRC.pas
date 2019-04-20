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
{$IF DEFINED(USE_JEDY_CORE_LIBRARY)}
  JclLogic,
{$ELSE ~ NOT USE_JEDY_CORE_LIBRARY}
  chHash.Core.Bits,
{$IFEND ~USE_JEDY_CORE_LIBRARY}
  chHash;

type

{ TchCrcAlgorithm<B> }

  TchCrcAlgorithm<B> = class abstract(TchAlgorithm<B, B>)
  strict private const
    TABLE_RESIDUE_SIZE = Byte(255);
    TABLE_FIRST_LEVEL  = Byte({$IF DEFINED(USE_ASSEMBLER)}0{$ELSE}1{$IFEND});
  strict protected const
    TABLE_LEVEL_SIZE   = Byte({$IF DEFINED(USE_ASSEMBLER)}7{$ELSE}16{$IFEND});
  {$IF DEFINED(HASH_TESTS)}
  public type
  {$ELSE}
  strict private type
  {$IFEND ~HASH_TESTS}
    TOneLevelCrcTable = array[0..TABLE_RESIDUE_SIZE] of B;
  strict private type
    TCrcTable = array[TABLE_FIRST_LEVEL..TABLE_LEVEL_SIZE] of TOneLevelCrcTable;
  strict protected
    FCrcTable: TCrcTable;      // Only first field
  strict private
    FWidth: Byte;
    FPolynomial: B;
    FXorOut: B;
    FRefIn: Boolean;
    FRefOut: Boolean;
    function GetPolynomial: B;{$IF DEFINED(USE_INLINE)}inline;{$IFEND}
  {$IF DEFINED(HASH_TESTS)}
    function GetCrcTable: TOneLevelCrcTable; inline;
  {$IFEND ~HASH_TESTS}
    function Gf2MatrixTimes(const Mat: TArray<B>; Vec: B): B;{$IF DEFINED(USE_INLINE)}inline;{$IFEND}
    procedure Gf2MatrixSquare(Square: TArray<B>; const Mat: TArray<B>);{$IF DEFINED(USE_INLINE)}inline;{$IFEND}
    procedure GenerateTable;{$IF DEFINED(USE_INLINE)}inline;{$IFEND}
  strict protected
    FAliases: TList<string>;
    function ByteToBits(const Value: Byte): B; virtual; abstract;
    function BitsToByte(const Value: B): Byte; virtual; abstract;
    function LeftShift(const Value: B; const Bits: Byte): B; virtual; abstract;
    function RightShift(const Value: B; const Bits: Byte): B; virtual; abstract;
    function BitwiseXor(const Left, Right: B): B; virtual; abstract;
    function IsZero(const Value: B): Boolean; virtual; abstract;
  protected
    constructor Create(const Name: string; const Polynomial, Init, XorOut, Check: B;
      const RefIn, RefOut: Boolean); reintroduce;
  public
    destructor Destroy; override;
    function Final(Current: B): B; override;
    function Combine(LeftCrc, RightCrc: B; RightLength: Cardinal): B;{$IF DEFINED(USE_INLINE)}inline;{$IFEND}
    function ToString: string; override;
    property Aliases: TList<string> read FAliases;
    property Width: Byte read FWidth;
    property Polynomial: B read GetPolynomial;
    property XorOut: B read FXorOut;
    property RefIn: Boolean read FRefIn;
    property RefOut: Boolean read FRefOut;
  {$IF DEFINED(HASH_TESTS)}
    property CrcTable: TOneLevelCrcTable read GetCrcTable;
  {$IFEND ~HASH_TESTS}
  end;

implementation

{ TchCrcAlgorithm<B> }

function TchCrcAlgorithm<B>.Combine(LeftCrc, RightCrc: B; RightLength: Cardinal): B;
begin
  if IsZero(RightCrc) or (RightLength = 0) then Exit(LeftCrc);

  var Odd: TArray<B>;
  SetLength(Odd, FWidth);
  var Even: TArray<B>;
  SetLength(Even, FWidth);

  LeftCrc := BitwiseXor(LeftCrc, BitwiseXor(Init, FXorOut));
  const Start: Byte = IfThenElse<Byte>(FRefIn, 1, 0);
  const Count: Byte = Start + FWidth - 1;
  Odd[IfThenElse<Byte>(FRefIn, 0, Count)] := Polynomial;
  var Row: B := ByteToBits(2 - Start);
  for var I: Byte := Start to Count - 1 do
  begin
    Odd[I] := Row;
    Row := LeftShift(Row, 1);
  end;

  Gf2MatrixSquare(Even, Odd);
  Gf2MatrixSquare(Odd, Even);

  repeat
    Gf2MatrixSquare(Even, Odd);
  {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}
    if TestBit(RightLength, 0) then
  {$ELSE ~ NOT USE_JEDY_CORE_LIBRARY}
    if RightLength.TestBit(0) then
  {$IFEND ~USE_JEDY_CORE_LIBRARY}
    begin
      LeftCrc := Gf2MatrixTimes(Even, LeftCrc);
    end;
    RightLength := RightLength shr 1;

    if RightLength = 0 then Break;

    Gf2MatrixSquare(Odd, Even);
  {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}
    if TestBit(RightLength, 0) then
  {$ELSE ~ NOT USE_JEDY_CORE_LIBRARY}
    if RightLength.TestBit(0) then
  {$IFEND ~USE_JEDY_CORE_LIBRARY}
    begin
      LeftCrc := Gf2MatrixTimes(Odd, LeftCrc);
    end;
    RightLength := RightLength shr 1;
  until RightLength = 0;

  Result := BitwiseXor(LeftCrc, RightCrc);
end;

constructor TchCrcAlgorithm<B>.Create(const Name: string; const Polynomial, Init, XorOut, Check: B;
  const RefIn, RefOut: Boolean);
begin
  inherited Create(Name, Init, Check);
  FAliases := TList<string>.Create;
  FPolynomial := Polynomial;
  FXorOut := XorOut;
  FRefIn := RefIn;
  FRefOut := RefOut;
  FWidth := SizeOf(B) * {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}BitsPerByte{$ELSE}Byte.Bits{$IFEND};
  GenerateTable;
end;

destructor TchCrcAlgorithm<B>.Destroy;
begin
  FreeAndNil(FAliases);
end;

function TchCrcAlgorithm<B>.Final(Current: B): B;
begin
  if not FRefOut then
  begin
  {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}
    ReverseBytes(@Current, SizeOf(B));
  {$ELSE ~ NOT USE_JEDY_CORE_LIBRARY}
    (@Current).ReverseBytes(SizeOf(B));
  {$IFEND ~USE_JEDY_CORE_LIBRARY}
  end;
  Result := BitwiseXor(Current, FXorOut);
end;

procedure TchCrcAlgorithm<B>.GenerateTable;
begin
  for var I: Byte := 0 to TABLE_RESIDUE_SIZE do
  begin
    const SizeOfBits: Byte = SizeOf(B);
    var Current: B := ByteToBits(I);
    if  FRefIn then
    begin
    {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}
      ReverseBits(@Current, SizeOfBits);
    {$ELSE ~ NOT USE_JEDY_CORE_LIBRARY}
      (@Current).ReverseBits(SizeOfBits);
    {$IFEND ~USE_JEDY_CORE_LIBRARY}
    end else
    begin
      Current := LeftShift(Current, FWidth - {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}BitsPerByte{$ELSE}Byte.Bits{$IFEND});
    end;
    for var J: Byte := 1 to {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}BitsPerByte{$ELSE}Byte.Bits{$IFEND} do
    begin
    {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}
      if TestBitBuffer(Current, FWidth - 1) then
    {$ELSE ~ NOT USE_JEDY_CORE_LIBRARY}
      if (@Current).TestBit(FWidth - 1) then
    {$IFEND ~USE_JEDY_CORE_LIBRARY}
      begin
        Current := BitwiseXor(LeftShift(Current, 1), FPolynomial);
      end else Current := LeftShift(Current, 1);
    end;
    FCrcTable[TABLE_FIRST_LEVEL, I] := Current;
    if FRefOut then
    begin
    {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}
      ReverseBits(@FCrcTable[TABLE_FIRST_LEVEL, I], SizeOfBits);
    {$ELSE ~ NOT USE_JEDY_CORE_LIBRARY}
      (@FCrcTable[TABLE_FIRST_LEVEL, I]).ReverseBits(SizeOfBits);
    {$IFEND ~USE_JEDY_CORE_LIBRARY}
    end else
    begin
    {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}
      ReverseBytes(@FCrcTable[TABLE_FIRST_LEVEL, I], SizeOfBits);
    {$ELSE ~ NOT USE_JEDY_CORE_LIBRARY}
      (@FCrcTable[TABLE_FIRST_LEVEL, I]).ReverseBytes(SizeOfBits);
    {$IFEND ~USE_JEDY_CORE_LIBRARY}
    end;
  end;

  for var I: Byte := 0 to TABLE_RESIDUE_SIZE do
  begin
    var Current: B := FCrcTable[TABLE_FIRST_LEVEL, I];
    for var J: Byte := TABLE_FIRST_LEVEL + 1 to TABLE_LEVEL_SIZE do
    begin
      Current := BitwiseXor(
        RightShift(Current, {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}BitsPerByte{$ELSE}Byte.Bits{$IFEND}),
        FCrcTable[TABLE_FIRST_LEVEL, BitsToByte(Current)]
      );
      FCrcTable[J, I] := Current;
    end;
  end;
end;

function TchCrcAlgorithm<B>.GetPolynomial: B;
begin
  Result := FPolynomial;
  if FRefIn then
  begin
  {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}
    ReverseBits(@Result, SizeOf(B));
  {$ELSE ~ NOT USE_JEDY_CORE_LIBRARY}
    (@Result).ReverseBits(SizeOf(B));
  {$IFEND ~USE_JEDY_CORE_LIBRARY}
  end;
end;

procedure TchCrcAlgorithm<B>.Gf2MatrixSquare(Square: TArray<B>; const Mat: TArray<B>);
begin
  for var I: Byte := 0 to FWidth - 1 do
  begin
    Square[I] := Gf2MatrixTimes(Mat, Mat[I]);
  end;
end;

function TchCrcAlgorithm<B>.Gf2MatrixTimes(const Mat: TArray<B>; Vec: B): B;
begin
  Result := ByteToBits(0);
  var I: Byte := 0;
  while not IsZero(Vec) do
  begin
  {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}
    if TestBitBuffer(Vec, 0) then
  {$ELSE ~ NOT USE_JEDY_CORE_LIBRARY}
    if (@Vec).TestBit(0) then
  {$IFEND ~USE_JEDY_CORE_LIBRARY}
    begin
      Result := BitwiseXor(Result, Mat[I]);
    end;
    Vec := RightShift(Vec, 1);
    Inc(I);
  end;
end;

{$IF DEFINED(HASH_TESTS)}
function TchCrcAlgorithm<B>.GetCrcTable: TOneLevelCrcTable;
begin
  Result := FCrcTable[TABLE_FIRST_LEVEL];
  if not FRefOut then
  begin
    const SizeOfBits: Byte = SizeOf(B);
    for var I: Byte := 0 to TABLE_RESIDUE_SIZE do
    begin
    {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}
      ReverseBytes(@Result[I], SizeOfBits);
    {$ELSE ~ NOT USE_JEDY_CORE_LIBRARY}
      (@Result[I]).ReverseBytes(SizeOfBits);
    {$IFEND ~USE_JEDY_CORE_LIBRARY}
    end;
  end;
end;
{$IFEND ~HASH_TESTS}

function TchCrcAlgorithm<B>.ToString: string;
begin
  Result := Format('%s (%db)', [FName, FWidth]);
end;

end.

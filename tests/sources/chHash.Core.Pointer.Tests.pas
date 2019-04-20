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

unit chHash.Core.Pointer.Tests;

{$INCLUDE CryptoHash.inc}

interface

uses
  TestFramework,
  System.SysUtils,
{$IF DEFINED(USE_JEDY_CORE_LIBRARY)}
  JclLogic,
{$IFEND ~USE_JEDY_CORE_LIBRARY}
  chHash.Core.Bits,
  chHash.Core.Bits.Tests;

type

{ TPointerHelperTests }

  TPointerHelperTests = class(TBitsHelperTests<TBytes>)
  strict private
    FLength: Cardinal;
  public
    procedure SetUp; override;
  published
    procedure ReverseBitsTest; override;
    procedure ReverseBytesTest; override;
    procedure TestBitTest; override;
    procedure ToBytesTest; override;
  end;

implementation

uses
  System.Generics.Defaults;

{ TPointerHelperTests }

procedure TPointerHelperTests.ReverseBitsTest;
begin
  var Expected: TBytes;
  SetLength(Expected, FLength);
  for var I: Byte := 1 to FLength do
  begin
  {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}
    Expected[FLength - I] := ReverseBits(FValue[I - 1]);
  {$ELSE ~ NOT USE_JEDY_CORE_LIBRARY}
    Expected[FLength - I] := FValue[I - 1].ReverseBits;
  {$IFEND ~USE_JEDY_CORE_LIBRARY}
  end;

  Test(
    procedure(ConvertCount: Cardinal)
    begin
      const Actual: TBytes = FValue;
      while ConvertCount <> 0 do
      begin
      {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}
        ReverseBits(@Actual[0], FLength);
      {$ELSE ~ NOT USE_JEDY_CORE_LIBRARY}
        (@Actual[0]).ReverseBits(FLength);
      {$IFEND ~USE_JEDY_CORE_LIBRARY}
        Dec(ConvertCount);
      end;
      CheckTrue(TEqualityComparer<TBytes>.Default.Equals(Expected, Actual));
    end
  );
end;

procedure TPointerHelperTests.ReverseBytesTest;
begin
  var Expected: TBytes;
  SetLength(Expected, FLength);
  for var I: Byte := 1 to FLength do
  begin
    Expected[FLength - I] := FValue[I - 1];
  end;

  Test(
    procedure(ConvertCount: Cardinal)
    begin
      const Actual: TBytes = FValue;
      while ConvertCount <> 0 do
      begin
      {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}
        ReverseBytes(@Actual[0], FLength);
      {$ELSE ~ NOT USE_JEDY_CORE_LIBRARY}
        (@Actual[0]).ReverseBytes(FLength);
      {$IFEND ~USE_JEDY_CORE_LIBRARY}
        Dec(ConvertCount);
      end;
      CheckTrue(TEqualityComparer<TBytes>.Default.Equals(Expected, Actual));
    end
  );
end;

procedure TPointerHelperTests.SetUp;
begin
  FLength := 5;
  Randomize;
  SetLength(FValue, FLength);
  for var I: Byte := 0 to FLength - 1 do
  begin
    FValue[I] := Random(256);
  end;
  FBytePerConvert := FLength;
end;

procedure TPointerHelperTests.TestBitTest;
begin
  const Bit: Byte = (FLength - 1) * {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}BitsPerByte{$ELSE}Byte.Bits{$IFEND} + 4;
{$IF DEFINED(USE_JEDY_CORE_LIBRARY)}
  const Expected: Boolean = TestBit(FValue[4], 4);
{$ELSE ~ NOT USE_JEDY_CORE_LIBRARY}
  const Expected: Boolean = FValue[4].TestBit(4);
{$IFEND ~USE_JEDY_CORE_LIBRARY}
  Test(
    procedure(ConvertCount: Cardinal)
    begin
      var Actual: Boolean := not Expected;
      while ConvertCount <> 0 do
      begin
      {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}
        Actual := TestBitBuffer(FValue[0], Bit);
      {$ELSE ~ NOT USE_JEDY_CORE_LIBRARY}
        Actual := (@FValue[0]).TestBit(Bit);
      {$IFEND ~USE_JEDY_CORE_LIBRARY}
        Dec(ConvertCount);
      end;
      CheckEquals(Expected, Actual);
    end
  );
end;

procedure TPointerHelperTests.ToBytesTest;
begin
  CheckTrue(TEqualityComparer<TBytes>.Default.Equals(FValue, (@FValue[0]).ToBytes(FLength)));
end;

initialization
  RegisterTest(TPointerHelperTests.Suite);

end.

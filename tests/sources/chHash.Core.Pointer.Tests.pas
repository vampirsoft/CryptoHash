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
  chHash.Core.Bits.Tests;

type

{ TPointerTests }

  TPointerTests = class(TBitsTests<TBytes>)
  strict private
    FLength: Cardinal;
  public
    procedure SetUp; override;
  published
    procedure ReverseBitsTest; override;
    procedure ReverseBytesTest; override;
    procedure TestBitTest; override;
    procedure ToBytesTest; override;
    procedure HelperReverseBitsTest; override;
    procedure HelperReverseBytesTest; override;
    procedure HelperTestBitTest; override;
    procedure HelperToBytesTest; override;
  end;

implementation

uses
  System.Generics.Defaults,
{$IF DEFINED(USE_JEDI_CORE_LIBRARY)}
  JclLogic,
{$ENDIF ~ USE_JEDI_CORE_LIBRARY}
  chHash.Core.Bits;

{ TPointerTests }

procedure TPointerTests.SetUp;
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

procedure TPointerTests.ReverseBitsTest;
begin
  var Expected: TBytes;
  SetLength(Expected, FLength);
  for var I := 1 to FLength do
  begin
    Expected[FLength - I] := ReverseBits(FValue[I - 1]);
  end;

  Test(
    procedure(const ConvertCount: Cardinal)
    begin
      const Actual: TBytes = FValue;
      for var I := 1 to ConvertCount do
      begin
        ReverseBits(Actual, FLength);
      end;
      CheckTrue(TEqualityComparer<TBytes>.Default.Equals(Expected, Actual));
    end
  );
end;

procedure TPointerTests.ReverseBytesTest;
begin
  var Expected: TBytes;
  SetLength(Expected, FLength);
  for var I := 1 to FLength do
  begin
    Expected[FLength - I] := FValue[I - 1];
  end;

  Test(
    procedure(const ConvertCount: Cardinal)
    begin
      const Actual: TBytes = FValue;
      for var I := 1 to ConvertCount do
      begin
        ReverseBytes(Actual, FLength);
      end;
      CheckTrue(TEqualityComparer<TBytes>.Default.Equals(Expected, Actual));
    end
  );
end;

procedure TPointerTests.TestBitTest;
begin
  const Bit = (FLength - 1) * BitsPerByte + 4;
  const Expected = TestBit(FValue[4], 4);
  Test(
    procedure(const ConvertCount: Cardinal)
    begin
      var Actual := not Expected;
      for var I := 1 to ConvertCount do
      begin
        Actual := TestBit(FValue, Bit);
      end;
      CheckEquals(Expected, Actual);
    end
  );
end;

procedure TPointerTests.ToBytesTest;
begin
  CheckTrue(TEqualityComparer<TBytes>.Default.Equals(FValue, ToBytes(@FValue[0], FLength)));
end;

procedure TPointerTests.HelperReverseBitsTest;
begin
  var Expected: TBytes;
  SetLength(Expected, FLength);
  for var I := 1 to FLength do
  begin
    Expected[FLength - I] := ReverseBits(FValue[I - 1]);
  end;

  Test(
    procedure(const ConvertCount: Cardinal)
    begin
      const Actual: TBytes = FValue;
      for var I := 1 to ConvertCount do
      begin
        (@Actual[0]).ReverseBits(FLength);
      end;
      CheckTrue(TEqualityComparer<TBytes>.Default.Equals(Expected, Actual));
    end
  );
end;

procedure TPointerTests.HelperReverseBytesTest;
begin
  var Expected: TBytes;
  SetLength(Expected, FLength);
  for var I := 1 to FLength do
  begin
    Expected[FLength - I] := FValue[I - 1];
  end;

  Test(
    procedure(const ConvertCount: Cardinal)
    begin
      const Actual: TBytes = FValue;
      for var I := 1 to ConvertCount do
      begin
        (@Actual[0]).ReverseBytes(FLength);
      end;
      CheckTrue(TEqualityComparer<TBytes>.Default.Equals(Expected, Actual));
    end
  );
end;

procedure TPointerTests.HelperTestBitTest;
begin
  const Bit = (FLength - 1) * Byte.Bits + 4;
  const Expected = FValue[4].TestBit(4);
  Test(
    procedure(const ConvertCount: Cardinal)
    begin
      var Actual := not Expected;
      for var I := 1 to ConvertCount do
      begin
        Actual := (@FValue[0]).TestBit(Bit);
      end;
      CheckEquals(Expected, Actual);
    end
  );
end;

procedure TPointerTests.HelperToBytesTest;
begin
  CheckTrue(TEqualityComparer<TBytes>.Default.Equals(FValue, (@FValue[0]).ToBytes(FLength)));
end;

initialization
  RegisterTest(TPointerTests.Suite);

end.

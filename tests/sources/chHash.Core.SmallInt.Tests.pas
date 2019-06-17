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

unit chHash.Core.SmallInt.Tests;
{$INCLUDE CryptoHash.inc}

interface

uses
  TestFramework,
  chHash.Core.Bits.Tests;

type

{ TSmallIntTests }

  TSmallIntTests = class(TBitsTests<SmallInt>)
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
  System.SysUtils,
  System.Generics.Defaults,
{$IF DEFINED(USE_JEDI_CORE_LIBRARY)}
  JclLogic,
{$ENDIF ~ USE_JEDI_CORE_LIBRARY}
  chHash.Core.Bits;

{ TSmallIntTests }

procedure TSmallIntTests.SetUp;
begin
  FValue := SmallInt($FEE8);
  FBytePerConvert := SizeOf(FValue);
end;

procedure TSmallIntTests.ReverseBitsTest;
begin
  const Expected = SmallInt($177F);
  Test(
    procedure(const ConvertCount: Cardinal)
    begin
      var Actual := $0;
      for var I := 1 to ConvertCount do
      begin
        Actual := ReverseBits(FValue);
      end;
      CheckEquals(Expected, Actual, Format('Expected = $%s, Actual = $%s', [IntToHex(Expected), IntToHex(Actual)]));
    end
  );
end;

procedure TSmallIntTests.ReverseBytesTest;
begin
  const Expected = SmallInt($E8FE);
  Test(
    procedure(const ConvertCount: Cardinal)
    begin
      var Actual := $0;
      for var I := 1 to ConvertCount do
      begin
        Actual := ReverseBytes(FValue);
      end;
      CheckEquals(Expected, Actual, Format('Expected = $%s, Actual = $%s', [IntToHex(Expected), IntToHex(Actual)]));
    end
  );
end;

procedure TSmallIntTests.TestBitTest;
begin
  const Expected = True;
  Test(
    procedure(const ConvertCount: Cardinal)
    begin
      var Actual := False;
      for var I := 1 to ConvertCount do
      begin
        Actual := TestBit(FValue, 9);
      end;
      CheckEquals(Expected, Actual);
    end
  );
end;

procedure TSmallIntTests.ToBytesTest;
begin
  CheckTrue(TEqualityComparer<TBytes>.Default.Equals([$FE, $E8], ToBytes(FValue)));
end;

procedure TSmallIntTests.HelperReverseBitsTest;
begin
  const Expected = SmallInt($177F);
  Test(
    procedure(const ConvertCount: Cardinal)
    begin
      var Actual := $0;
      for var I := 1 to ConvertCount do
      begin
        Actual := FValue.ReverseBits;
      end;
      CheckEquals(Expected, Actual, Format('Expected = $%s, Actual = $%s', [IntToHex(Expected), IntToHex(Actual)]));
      CheckNotEquals(Expected, FValue, Format('Expected = $%s, Value = $%s', [IntToHex(Expected), IntToHex(FValue)]));
    end
  );
end;

procedure TSmallIntTests.HelperReverseBytesTest;
begin
  const Expected = SmallInt($E8FE);
  Test(
    procedure(const ConvertCount: Cardinal)
    begin
      var Actual := $0;
      for var I := 1 to ConvertCount do
      begin
        Actual := FValue.ReverseBytes;
      end;
      CheckEquals(Expected, Actual, Format('Expected = $%s, Actual = $%s', [IntToHex(Expected), IntToHex(Actual)]));
      CheckNotEquals(Expected, FValue, Format('Expected = $%s, Value = $%s', [IntToHex(Expected), IntToHex(FValue)]));
    end
  );
end;

procedure TSmallIntTests.HelperTestBitTest;
begin
  const Expected = True;
  Test(
    procedure(const ConvertCount: Cardinal)
    begin
      var Actual := False;
      for var I := 1 to ConvertCount do
      begin
        Actual := FValue.TestBit(9);
      end;
      CheckEquals(Expected, Actual);
    end
  );
end;

procedure TSmallIntTests.HelperToBytesTest;
begin
  CheckTrue(TEqualityComparer<TBytes>.Default.Equals([$FE, $E8], FValue.ToBytes));
end;

initialization
  RegisterTest(TSmallIntTests.Suite);

end.

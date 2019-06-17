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

unit chHash.Core.ShortInt.Tests;

{$INCLUDE CryptoHash.inc}

interface

uses
  TestFramework,
  chHash.Core.Bits.Tests;

type

{ TShortIntTests }

  TShortIntTests = class(TBitsTests<ShortInt>)
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

{ TShortIntTests }

procedure TShortIntTests.SetUp;
begin
  FValue := ShortInt($F4);
  FBytePerConvert := SizeOf(FValue);
end;

procedure TShortIntTests.ReverseBitsTest;
begin
  const Expected = ShortInt($2F);
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

procedure TShortIntTests.ReverseBytesTest;
begin
  const Expected = ShortInt($F4);
  Test(
    procedure(const ConvertCount: Cardinal)
    begin
      var Actual := $0;
      for var I := 1 to ConvertCount do
      begin
        Actual := FValue;
      end;
      CheckEquals(Expected, Actual, Format('Expected = $%s, Actual = $%s', [IntToHex(Expected), IntToHex(Actual)]));
    end
  );
end;

procedure TShortIntTests.TestBitTest;
begin
  const Expected = True;
  Test(
    procedure(const ConvertCount: Cardinal)
    begin
      var Actual := False;
      for var I := 1 to ConvertCount do
      begin
        Actual := TestBit(FValue, 2);
      end;
      CheckEquals(Expected, Actual);
    end
  );
end;

procedure TShortIntTests.ToBytesTest;
begin
  CheckTrue(TEqualityComparer<TBytes>.Default.Equals([$F4], ToBytes(FValue)));
end;

procedure TShortIntTests.HelperReverseBitsTest;
begin
  const Expected = ShortInt($2F);
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

procedure TShortIntTests.HelperReverseBytesTest;
begin
  const Expected = ShortInt($F4);
  Test(
    procedure(const ConvertCount: Cardinal)
    begin
      var Actual := $0;
      for var I := 1 to ConvertCount do
      begin
        Actual := FValue;
      end;
      CheckEquals(Expected, Actual, Format('Expected = $%s, Actual = $%s', [IntToHex(Expected), IntToHex(Actual)]));
    end
  );
end;

procedure TShortIntTests.HelperTestBitTest;
begin
  const Expected = True;
  Test(
    procedure(const ConvertCount: Cardinal)
    begin
      var Actual := False;
      for var I := 1 to ConvertCount do
      begin
        Actual := FValue.TestBit(2);
      end;
      CheckEquals(Expected, Actual);
    end
  );
end;

procedure TShortIntTests.HelperToBytesTest;
begin
  CheckTrue(TEqualityComparer<TBytes>.Default.Equals([$F4], FValue.ToBytes));
end;

initialization
  RegisterTest(TShortIntTests.Suite);

end.

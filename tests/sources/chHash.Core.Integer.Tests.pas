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

unit chHash.Core.Integer.Tests;

{$INCLUDE CryptoHash.inc}

interface

uses
  TestFramework,
  chHash.Core.Bits.Tests;

type

{ TIntegerTests }

  TIntegerTests = class(TBitsTests<Integer>)
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

{ TIntegerTests }

procedure TIntegerTests.SetUp;
begin
  FValue := Integer($F4ACFB13);
  FBytePerConvert := SizeOf(FValue);
end;

procedure TIntegerTests.ReverseBitsTest;
begin
  const Expected = Integer($C8DF352F);
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

procedure TIntegerTests.ReverseBytesTest;
begin
  const Expected = Integer($13FBACF4);
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

procedure TIntegerTests.TestBitTest;
begin
  const Expected = True;
  Test(
    procedure(const ConvertCount: Cardinal)
    begin
      var Actual := False;
      for var I := 1 to ConvertCount do
      begin
        Actual := TestBit(FValue, 21);
      end;
      CheckEquals(Expected, Actual);
    end
  );
end;

procedure TIntegerTests.ToBytesTest;
begin
  CheckTrue(TEqualityComparer<TBytes>.Default.Equals([$F4, $AC, $FB, $13], ToBytes(FValue)));
end;

procedure TIntegerTests.HelperReverseBitsTest;
begin
  const Expected = Integer($C8DF352F);
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

procedure TIntegerTests.HelperReverseBytesTest;
begin
  const Expected = Integer($13FBACF4);
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

procedure TIntegerTests.HelperTestBitTest;
begin
  const Expected = True;
  Test(
    procedure(const ConvertCount: Cardinal)
    begin
      var Actual := False;
      for var I := 1 to ConvertCount do
      begin
        Actual := FValue.TestBit(21);
      end;
      CheckEquals(Expected, Actual);
    end
  );
end;

procedure TIntegerTests.HelperToBytesTest;
begin
  CheckTrue(TEqualityComparer<TBytes>.Default.Equals([$F4, $AC, $FB, $13], FValue.ToBytes));
end;

initialization
  RegisterTest(TIntegerTests.Suite);

end.

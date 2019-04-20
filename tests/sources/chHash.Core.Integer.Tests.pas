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
  System.SysUtils,
{$IF DEFINED(USE_JEDY_CORE_LIBRARY)}
  JclLogic,
{$IFEND ~USE_JEDY_CORE_LIBRARY}
  chHash.Core.Bits,
  chHash.Core.Bits.Tests;

type

{ TIntegerHelperTests }

  TIntegerHelperTests = class(TBitsHelperTests<Integer>)
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

{ TIntegerHelperTests }

procedure TIntegerHelperTests.ReverseBitsTest;
begin
  const Expected = Integer($C8DF352F);
  Test(
    procedure(ConvertCount: Cardinal)
    begin
      var Actual := Integer($0);
      while ConvertCount <> 0 do
      begin
      {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}
        Actual := ReverseBits(FValue);
      {$ELSE ~ NOT USE_JEDY_CORE_LIBRARY}
        Actual := FValue.ReverseBits;
      {$IFEND ~USE_JEDY_CORE_LIBRARY}
        Dec(ConvertCount);
      end;
      CheckEquals(Expected, Actual, Format('Expected = $%s, Actual = $%s', [IntToHex(Expected), IntToHex(Actual)]));
    end
  );
end;

procedure TIntegerHelperTests.ReverseBytesTest;
begin
  const Expected = Integer($13FBACF4);
  Test(
    procedure(ConvertCount: Cardinal)
    begin
      var Actual := Integer($0);
      while ConvertCount <> 0 do
      begin
      {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}
        Actual := ReverseBytes(FValue);
      {$ELSE ~ NOT USE_JEDY_CORE_LIBRARY}
        Actual := FValue.ReverseBytes;
      {$IFEND ~USE_JEDY_CORE_LIBRARY}
        Dec(ConvertCount);
      end;
      CheckEquals(Expected, Actual, Format('Expected = $%s, Actual = $%s', [IntToHex(Expected), IntToHex(Actual)]));
    end
  );
end;

procedure TIntegerHelperTests.SetUp;
begin
  FValue := Integer($F4ACFB13);
  FBytePerConvert := SizeOf(FValue);
end;

procedure TIntegerHelperTests.TestBitTest;
begin
  const Expected: Boolean = True;
  Test(
    procedure(ConvertCount: Cardinal)
    begin
      var Actual: Boolean := False;
      while ConvertCount <> 0 do
      begin
      {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}
        Actual := TestBit(FValue, 21);
      {$ELSE ~ NOT USE_JEDY_CORE_LIBRARY}
        Actual := FValue.TestBit(21);
      {$IFEND ~USE_JEDY_CORE_LIBRARY}
        Dec(ConvertCount);
      end;
      CheckEquals(Expected, Actual);
    end
  );
end;

procedure TIntegerHelperTests.ToBytesTest;
begin
  CheckTrue(TEqualityComparer<TBytes>.Default.Equals([$F4, $AC, $FB, $13], FValue.ToBytes));
end;

initialization
  RegisterTest(TIntegerHelperTests.Suite);

end.

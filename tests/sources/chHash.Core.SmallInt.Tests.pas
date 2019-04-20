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
  System.SysUtils,
{$IF DEFINED(USE_JEDY_CORE_LIBRARY)}
  JclLogic,
{$IFEND ~USE_JEDY_CORE_LIBRARY}
  chHash.Core.Bits,
  chHash.Core.Bits.Tests;

type

{ TSmallIntHelperTests }

  TSmallIntHelperTests = class(TBitsHelperTests<SmallInt>)
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

{ TSmallIntHelperTests }

procedure TSmallIntHelperTests.ReverseBitsTest;
begin
  const Expected = SmallInt($177F);
  Test(
    procedure(ConvertCount: Cardinal)
    begin
      var Actual := SmallInt($0);
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

procedure TSmallIntHelperTests.ReverseBytesTest;
begin
  const Expected = SmallInt($E8FE);
  Test(
    procedure(ConvertCount: Cardinal)
    begin
      var Actual := SmallInt($0);
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

procedure TSmallIntHelperTests.SetUp;
begin
  FValue := SmallInt($FEE8);
  FBytePerConvert := SizeOf(FValue);
end;

procedure TSmallIntHelperTests.TestBitTest;
begin
  const Expected: Boolean = True;
  Test(
    procedure(ConvertCount: Cardinal)
    begin
      var Actual: Boolean := False;
      while ConvertCount <> 0 do
      begin
      {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}
        Actual := TestBit(FValue, 9);
      {$ELSE ~ NOT USE_JEDY_CORE_LIBRARY}
        Actual := FValue.TestBit(9);
      {$IFEND ~USE_JEDY_CORE_LIBRARY}
        Dec(ConvertCount);
      end;
      CheckEquals(Expected, Actual);
    end
  );
end;

procedure TSmallIntHelperTests.ToBytesTest;
begin
  CheckTrue(TEqualityComparer<TBytes>.Default.Equals([$FE, $E8], FValue.ToBytes));
end;

initialization
  RegisterTest(TSmallIntHelperTests.Suite);

end.

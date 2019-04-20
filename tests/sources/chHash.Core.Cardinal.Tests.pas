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

unit chHash.Core.Cardinal.Tests;

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

{ TCardinalHelperTests }

  TCardinalHelperTests = class(TBitsHelperTests<Cardinal>)
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

{ TCardinalHelperTests }

procedure TCardinalHelperTests.ReverseBitsTest;
begin
  const Expected: Cardinal = $649C2FD3;
  Test(
    procedure(ConvertCount: Cardinal)
    begin
      var Actual: Cardinal := $0;
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

procedure TCardinalHelperTests.ReverseBytesTest;
begin
  const Expected: Cardinal = $2639F4CB;
  Test(
    procedure(ConvertCount: Cardinal)
    begin
      var Actual: Cardinal := $0;
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

procedure TCardinalHelperTests.SetUp;
begin
  FValue := $CBF43926;
  FBytePerConvert := SizeOf(FValue);
end;

procedure TCardinalHelperTests.TestBitTest;
begin
  const Expected: Boolean = True;
  Test(
    procedure(ConvertCount: Cardinal)
    begin
      var Actual: Boolean := False;
      while ConvertCount <> 0 do
      begin
      {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}
        Actual := TestBit(FValue, 18);
      {$ELSE ~ NOT USE_JEDY_CORE_LIBRARY}
        Actual := FValue.TestBit(18);
      {$IFEND ~USE_JEDY_CORE_LIBRARY}
        Dec(ConvertCount);
      end;
      CheckEquals(Expected, Actual);
    end
  );
end;

procedure TCardinalHelperTests.ToBytesTest;
begin
  CheckTrue(TEqualityComparer<TBytes>.Default.Equals([$CB, $F4, $39, $26], FValue.ToBytes));
end;

initialization
  RegisterTest(TCardinalHelperTests.Suite);

end.

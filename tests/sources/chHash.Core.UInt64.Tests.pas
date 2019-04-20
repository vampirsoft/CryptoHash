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

unit chHash.Core.UInt64.Tests;

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

{ TUInt64HelperTests }

  TUInt64HelperTests = class(TBitsHelperTests<UInt64>)
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

{ TUInt64HelperTests }

procedure TUInt64HelperTests.ReverseBitsTest;
begin
  const Expected: UInt64 = $5F9C98FBDD93BA99;
  Test(
    procedure(ConvertCount: Cardinal)
    begin
      var Actual: UInt64 := $0;
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

procedure TUInt64HelperTests.ReverseBytesTest;
begin
  const Expected: UInt64 = $FA3919DFBBC95D99;
  Test(
    procedure(ConvertCount: Cardinal)
    begin
      var Actual: UInt64 := $0;
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

procedure TUInt64HelperTests.SetUp;
begin
  FValue := $995DC9BBDF1939FA;
  FBytePerConvert := SizeOf(FValue);
end;

procedure TUInt64HelperTests.TestBitTest;
begin
  const Expected: Boolean = True;
  Test(
    procedure(ConvertCount: Cardinal)
    begin
      var Actual: Boolean := False;
      while ConvertCount <> 0 do
      begin
      {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}
        Actual := TestBit(FValue, 40);
      {$ELSE ~ NOT USE_JEDY_CORE_LIBRARY}
        Actual := FValue.TestBit(40);
      {$IFEND ~USE_JEDY_CORE_LIBRARY}
        Dec(ConvertCount);
      end;
      CheckEquals(Expected, Actual);
    end
  );
end;

procedure TUInt64HelperTests.ToBytesTest;
begin
  CheckTrue(TEqualityComparer<TBytes>.Default.Equals([$99, $5D, $C9, $BB, $DF, $19, $39, $FA], FValue.ToBytes));
end;

initialization
  RegisterTest(TUInt64HelperTests.Suite);

end.

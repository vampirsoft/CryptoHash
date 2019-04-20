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

unit chHash.Core.Byte.Tests;

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

{ TByteHelperTests }

  TByteHelperTests = class(TBitsHelperTests<Byte>)
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

{ TByteHelperTests }

procedure TByteHelperTests.ReverseBitsTest;
begin
  const Expected: Byte = $5B;
  Test(
    procedure(ConvertCount: Cardinal)
    begin
      var Actual: Byte := $0;
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

procedure TByteHelperTests.ReverseBytesTest;
begin
  const Expected: Byte = $DA;
  Test(
    procedure(ConvertCount: Cardinal)
    begin
      var Actual: Byte := $0;
      while ConvertCount <> 0 do
      begin
        Actual := FValue;
        Dec(ConvertCount);
      end;
      CheckEquals(Expected, Actual, Format('Expected = $%s, Actual = $%s', [IntToHex(Expected), IntToHex(Actual)]));
    end
  );
end;

procedure TByteHelperTests.SetUp;
begin
  FValue := $DA;
  FBytePerConvert := SizeOf(FValue);
end;

procedure TByteHelperTests.TestBitTest;
begin
  const Expected: Boolean = True;
  Test(
    procedure(ConvertCount: Cardinal)
    begin
      var Actual: Boolean := False;
      while ConvertCount <> 0 do
      begin
      {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}
        Actual := TestBit(FValue, 4);
      {$ELSE ~ NOT USE_JEDY_CORE_LIBRARY}
        Actual := FValue.TestBit(4);
      {$IFEND ~USE_JEDY_CORE_LIBRARY}
        Dec(ConvertCount);
      end;
      CheckEquals(Expected, Actual);
    end
  );
end;

procedure TByteHelperTests.ToBytesTest;
begin
  CheckTrue(TEqualityComparer<TBytes>.Default.Equals([$DA], FValue.ToBytes));
end;

initialization
  RegisterTest(TByteHelperTests.Suite);

end.

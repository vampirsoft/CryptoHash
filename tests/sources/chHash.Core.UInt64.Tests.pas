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
  chHash.Core.Bits.Tests;

type

{ TUInt64Tests }

  TUInt64Tests = class(TBitsTests<UInt64>)
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

{ TUInt64Tests }

procedure TUInt64Tests.SetUp;
begin
  FValue := $995DC9BBDF1939FA;
  FBytePerConvert := SizeOf(FValue);
end;

procedure TUInt64Tests.ReverseBitsTest;
begin
  const Expected = UInt64($5F9C98FBDD93BA99);
  Test(
    procedure(const ConvertCount: Cardinal)
    begin
      var Actual: UInt64 := $0;
      for var I := 1 to ConvertCount do
      begin
        Actual := ReverseBits(FValue);
      end;
      CheckEquals(Expected, Actual, Format('Expected = $%s, Actual = $%s', [IntToHex(Expected), IntToHex(Actual)]));
    end
  );
end;

procedure TUInt64Tests.ReverseBytesTest;
begin
  const Expected = UInt64($FA3919DFBBC95D99);
  Test(
    procedure(const ConvertCount: Cardinal)
    begin
      var Actual: UInt64 := $0;
      for var I := 1 to ConvertCount do
      begin
        Actual := ReverseBytes(FValue);
      end;
      CheckEquals(Expected, Actual, Format('Expected = $%s, Actual = $%s', [IntToHex(Expected), IntToHex(Actual)]));
    end
  );
end;

procedure TUInt64Tests.TestBitTest;
begin
  const Expected = True;
  Test(
    procedure(const ConvertCount: Cardinal)
    begin
      var Actual := False;
      for var I := 1 to ConvertCount do
      begin
        Actual := TestBit(FValue, 40);
      end;
      CheckEquals(Expected, Actual);
    end
  );
end;

procedure TUInt64Tests.ToBytesTest;
begin
  CheckTrue(TEqualityComparer<TBytes>.Default.Equals([$99, $5D, $C9, $BB, $DF, $19, $39, $FA], ToBytes(FValue)));
end;

procedure TUInt64Tests.HelperReverseBitsTest;
begin
  const Expected = UInt64($5F9C98FBDD93BA99);
  Test(
    procedure(const ConvertCount: Cardinal)
    begin
      var Actual: UInt64 := $0;
      for var I := 1 to ConvertCount do
      begin
        Actual := FValue.ReverseBits;
      end;
      CheckEquals(Expected, Actual, Format('Expected = $%s, Actual = $%s', [IntToHex(Expected), IntToHex(Actual)]));
      CheckNotEquals(Expected, FValue, Format('Expected = $%s, Value = $%s', [IntToHex(Expected), IntToHex(FValue)]));
    end
  );
end;

procedure TUInt64Tests.HelperReverseBytesTest;
begin
  const Expected = UInt64($FA3919DFBBC95D99);
  Test(
    procedure(const ConvertCount: Cardinal)
    begin
      var Actual: UInt64 := $0;
      for var I := 1 to ConvertCount do
      begin
        Actual := FValue.ReverseBytes;
      end;
      CheckEquals(Expected, Actual, Format('Expected = $%s, Actual = $%s', [IntToHex(Expected), IntToHex(Actual)]));
      CheckNotEquals(Expected, FValue, Format('Expected = $%s, Value = $%s', [IntToHex(Expected), IntToHex(FValue)]));
    end
  );
end;

procedure TUInt64Tests.HelperTestBitTest;
begin
  const Expected = True;
  Test(
    procedure(const ConvertCount: Cardinal)
    begin
      var Actual := False;
      for var I := 1 to ConvertCount do
      begin
        Actual := FValue.TestBit(40);
      end;
      CheckEquals(Expected, Actual);
    end
  );
end;

procedure TUInt64Tests.HelperToBytesTest;
begin
  CheckTrue(TEqualityComparer<TBytes>.Default.Equals([$99, $5D, $C9, $BB, $DF, $19, $39, $FA], FValue.ToBytes));
end;

initialization
  RegisterTest(TUInt64Tests.Suite);

end.

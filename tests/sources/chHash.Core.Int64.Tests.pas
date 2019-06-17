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

unit chHash.Core.Int64.Tests;

{$INCLUDE CryptoHash.inc}

interface

uses
  TestFramework,
  chHash.Core.Bits.Tests;

type

{ TInt64Tests }

  TInt64Tests = class(TBitsTests<Int64>)
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

{ TInt64Tests }

procedure TInt64Tests.SetUp;
begin
  FValue := Int64($E2CE92D0FAFB0236);
  FBytePerConvert := SizeOf(FValue);
end;

procedure TInt64Tests.ReverseBitsTest;
begin
  const Expected = Int64($6C40DF5F0B497347);
  Test(
    procedure(const ConvertCount: Cardinal)
    begin
      var Actual: Int64 := $0;
      for var I := 1 to ConvertCount do
      begin
        Actual := ReverseBits(FValue);
      end;
      CheckEquals(Expected, Actual, Format('Expected = $%s, Actual = $%s', [IntToHex(Expected), IntToHex(Actual)]));
    end
  );
end;

procedure TInt64Tests.ReverseBytesTest;
begin
  const Expected = Int64($3602FBFAD092CEE2);
  Test(
    procedure(const ConvertCount: Cardinal)
    begin
      var Actual: Int64 := $0;
      for var I := 1 to ConvertCount do
      begin
        Actual := ReverseBytes(FValue);
      end;
      CheckEquals(Expected, Actual, Format('Expected = $%s, Actual = $%s', [IntToHex(Expected), IntToHex(Actual)]));
    end
  );
end;

procedure TInt64Tests.TestBitTest;
begin
  const Expected = True;
  Test(
    procedure(const ConvertCount: Cardinal)
    begin
      var Actual := False;
      for var I := 1 to ConvertCount do
      begin
        Actual := TestBit(FValue, 36);
      end;
      CheckEquals(Expected, Actual);
    end
  );
end;

procedure TInt64Tests.ToBytesTest;
begin
  CheckTrue(TEqualityComparer<TBytes>.Default.Equals([$E2, $CE, $92, $D0, $FA, $FB, $02, $36], ToBytes(FValue)));
end;

procedure TInt64Tests.HelperReverseBitsTest;
begin
  const Expected = Int64($6C40DF5F0B497347);
  Test(
    procedure(const ConvertCount: Cardinal)
    begin
      var Actual: Int64 := $0;
      for var I := 1 to ConvertCount do
      begin
        Actual := FValue.ReverseBits;
      end;
      CheckEquals(Expected, Actual, Format('Expected = $%s, Actual = $%s', [IntToHex(Expected), IntToHex(Actual)]));
      CheckNotEquals(Expected, FValue, Format('Expected = $%s, Value = $%s', [IntToHex(Expected), IntToHex(FValue)]));
    end
  );
end;

procedure TInt64Tests.HelperReverseBytesTest;
begin
  const Expected = Int64($3602FBFAD092CEE2);
  Test(
    procedure(const ConvertCount: Cardinal)
    begin
      var Actual: Int64 := $0;
      for var I := 1 to ConvertCount do
      begin
        Actual := FValue.ReverseBytes;
      end;
      CheckEquals(Expected, Actual, Format('Expected = $%s, Actual = $%s', [IntToHex(Expected), IntToHex(Actual)]));
      CheckNotEquals(Expected, FValue, Format('Expected = $%s, Value = $%s', [IntToHex(Expected), IntToHex(FValue)]));
    end
  );
end;

procedure TInt64Tests.HelperTestBitTest;
begin
  const Expected = True;
  Test(
    procedure(const ConvertCount: Cardinal)
    begin
      var Actual := False;
      for var I := 1 to ConvertCount do
      begin
        Actual := FValue.TestBit(36);
      end;
      CheckEquals(Expected, Actual);
    end
  );
end;

procedure TInt64Tests.HelperToBytesTest;
begin
  CheckTrue(TEqualityComparer<TBytes>.Default.Equals([$E2, $CE, $92, $D0, $FA, $FB, $02, $36], FValue.ToBytes));
end;

initialization
  RegisterTest(TInt64Tests.Suite);

end.

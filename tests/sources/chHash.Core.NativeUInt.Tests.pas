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

unit chHash.Core.NativeUInt.Tests;

{$INCLUDE CryptoHash.inc}

interface

uses
  TestFramework,
  System.SysUtils,
  JclLogic,
  chHash.Core.Bits,
  chHash.Core.Bits.Tests;

type

{ TNativeUIntHelperTests }

  TNativeUIntHelperTests = class(TBitsHelperTests<NativeUInt>)
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
  System.Generics.Defaults,
  System.Diagnostics;

{ TNativeUIntHelperTests }

procedure TNativeUIntHelperTests.ReverseBitsTest;
begin
  const Expected: NativeUInt = {$IF DEFINED(CPUX64)}$5F9C98FBDD93BA99{$ELSE}$649C2FD3{$IFEND};
  Test(
    procedure(ConvertCount: Cardinal)
    begin
      var Actual: NativeUInt := $0;
      while ConvertCount <> 0 do
      begin
        Actual := FValue.ReverseBits;
        Dec(ConvertCount);
      end;
      CheckEquals(Expected, Actual, Format('Expected = $%s, Actual = $%s', [IntToHex(Expected), IntToHex(Actual)]));
    end
  );
end;

procedure TNativeUIntHelperTests.ReverseBytesTest;
begin
  const Expected: NativeUInt = {$IF DEFINED(CPUX64)}$FA3919DFBBC95D99{$ELSE}$2639F4CB{$IFEND};
  Test(
    procedure(ConvertCount: Cardinal)
    begin
      var Actual: NativeUInt := $0;
      while ConvertCount <> 0 do
      begin
        Actual := FValue.ReverseBytes;
        Dec(ConvertCount);
      end;
      CheckEquals(Expected, Actual, Format('Expected = $%s, Actual = $%s', [IntToHex(Expected), IntToHex(Actual)]));
    end
  );
end;

procedure TNativeUIntHelperTests.SetUp;
begin
  FValue := {$IF DEFINED(CPUX64)}$995DC9BBDF1939FA{$ELSE}$CBF43926{$IFEND};
  FBytePerConvert := SizeOf(FValue);
end;

procedure TNativeUIntHelperTests.TestBitTest;
begin
  const Expected: Boolean = True;
  Test(
    procedure(ConvertCount: Cardinal)
    begin
      var Actual: Boolean := False;
      while ConvertCount <> 0 do
      begin
        Actual := FValue.TestBit({$IF DEFINED(CPUX64)}40{$ELSE}18{$IFEND});
        Dec(ConvertCount);
      end;
      CheckEquals(Expected, Actual);
    end
  );
end;

procedure TNativeUIntHelperTests.ToBytesTest;
begin
  CheckTrue(
    TEqualityComparer<TBytes>.Default.Equals(
      {$IF DEFINED(CPUX64)}[$99, $5D, $C9, $BB, $DF, $19, $39, $FA]{$ELSE}[$CB, $F4, $39, $26]{$IFEND},
      FValue.ToBytes
    )
  );
end;

initialization
  RegisterTest(TNativeUIntHelperTests.Suite);

end.

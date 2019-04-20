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

unit chHash.Core.NativeInt.Tests;

{$INCLUDE CryptoHash.inc}

interface

uses
  TestFramework,
  System.SysUtils,
  JclLogic,
  chHash.Core.Bits,
  chHash.Core.Bits.Tests;

type

  TNativeIntHelperTests = class(TBitsHelperTests<NativeInt>)
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

{ TNativeIntHelperTests }

procedure TNativeIntHelperTests.ReverseBitsTest;
begin
  const Expected = NativeInt({$IF DEFINED(CPUX64)}$6C40DF5F0B497347{$ELSE}$C8DF352F{$IFEND});
  Test(
    procedure(ConvertCount: Cardinal)
    begin
      var Actual := NativeInt($0);
      while ConvertCount <> 0 do
      begin
        Actual := FValue.ReverseBits;
        Dec(ConvertCount);
      end;
      CheckEquals(Expected, Actual, Format('Expected = $%s, Actual = $%s', [IntToHex(Expected), IntToHex(Actual)]));
    end
  );
end;

procedure TNativeIntHelperTests.ReverseBytesTest;
begin
  const Expected = NativeInt({$IF DEFINED(CPUX64)}$3602FBFAD092CEE2{$ELSE}$13FBACF4{$IFEND});
  Test(
    procedure(ConvertCount: Cardinal)
    begin
      var Actual := NativeInt($0);
      while ConvertCount <> 0 do
      begin
        Actual := FValue.ReverseBytes;
        Dec(ConvertCount);
      end;
      CheckEquals(Expected, Actual, Format('Expected = $%s, Actual = $%s', [IntToHex(Expected), IntToHex(Actual)]));
    end
  );
end;

procedure TNativeIntHelperTests.SetUp;
begin
  FValue := NativeInt({$IF DEFINED(CPUX64)}$E2CE92D0FAFB0236{$ELSE}$F4ACFB13{$IFEND});
  FBytePerConvert := SizeOf(FValue);
end;

procedure TNativeIntHelperTests.TestBitTest;
begin
  const Expected: Boolean = True;
  Test(
    procedure(ConvertCount: Cardinal)
    begin
      var Actual: Boolean := False;
      while ConvertCount <> 0 do
      begin
        Actual := FValue.TestBit({$IF DEFINED(CPUX64)}36{$ELSE}21{$IFEND});
        Dec(ConvertCount);
      end;
      CheckEquals(Expected, Actual);
    end
  );
end;

procedure TNativeIntHelperTests.ToBytesTest;
begin
  CheckTrue(
    TEqualityComparer<TBytes>.Default.Equals(
      {$IF DEFINED(CPUX64)}[$E2, $CE, $92, $D0, $FA, $FB, $02, $36]{$ELSE}[$F4, $AC, $FB, $13]{$IFEND},
      FValue.ToBytes
    )
  );
end;

initialization
  RegisterTest(TNativeIntHelperTests.Suite);

end.

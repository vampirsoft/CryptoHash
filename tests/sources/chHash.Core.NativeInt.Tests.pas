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
  chHash.Core.Bits.Tests;

type

{ TNativeIntTests }

  TNativeIntTests = class(TBitsTests<NativeInt>)
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

{ TNativeIntTests }

procedure TNativeIntTests.SetUp;
begin
  FValue := NativeInt({$IF DEFINED(CPUX64)}$E2CE92D0FAFB0236{$ELSE}$F4ACFB13{$ENDIF});
  FBytePerConvert := SizeOf(FValue);
end;

procedure TNativeIntTests.ReverseBitsTest;
begin
  const Expected = NativeInt({$IF DEFINED(CPUX64)}$6C40DF5F0B497347{$ELSE}$C8DF352F{$ENDIF});
  Test(
    procedure(const ConvertCount: Cardinal)
    begin
      var Actual: NativeInt := $0;
      for var I := 1 to ConvertCount do
      begin
        Actual := ReverseBits(FValue);
      end;
      CheckEquals(Expected, Actual, Format('Expected = $%s, Actual = $%s', [IntToHex(Expected), IntToHex(Actual)]));
    end
  );
end;

procedure TNativeIntTests.ReverseBytesTest;
begin
  const Expected = NativeInt({$IF DEFINED(CPUX64)}$3602FBFAD092CEE2{$ELSE}$13FBACF4{$ENDIF});
  Test(
    procedure(const ConvertCount: Cardinal)
    begin
      var Actual: NativeInt := $0;
      for var I := 1 to ConvertCount do
      begin
        Actual := ReverseBytes(FValue);
      end;
      CheckEquals(Expected, Actual, Format('Expected = $%s, Actual = $%s', [IntToHex(Expected), IntToHex(Actual)]));
    end
  );
end;

procedure TNativeIntTests.TestBitTest;
begin
  const Expected = True;
  Test(
    procedure(const ConvertCount: Cardinal)
    begin
      var Actual := False;
      for var I := 1 to ConvertCount do
      begin
        Actual := TestBit(FValue, {$IF DEFINED(CPUX64)}36{$ELSE}21{$ENDIF});
      end;
      CheckEquals(Expected, Actual);
    end
  );
end;

procedure TNativeIntTests.ToBytesTest;
begin
  CheckTrue(
    TEqualityComparer<TBytes>.Default.Equals(
      {$IF DEFINED(CPUX64)}[$E2, $CE, $92, $D0, $FA, $FB, $02, $36]{$ELSE}[$F4, $AC, $FB, $13]{$ENDIF},
      ToBytes(FValue)
    )
  );
end;

procedure TNativeIntTests.HelperReverseBitsTest;
begin
  const Expected = NativeInt({$IF DEFINED(CPUX64)}$6C40DF5F0B497347{$ELSE}$C8DF352F{$ENDIF});
  Test(
    procedure(const ConvertCount: Cardinal)
    begin
      var Actual: NativeInt := $0;
      for var I := 1 to ConvertCount do
      begin
        Actual := FValue.ReverseBits;
      end;
      CheckEquals(Expected, Actual, Format('Expected = $%s, Actual = $%s', [IntToHex(Expected), IntToHex(Actual)]));
    end
  );
end;

procedure TNativeIntTests.HelperReverseBytesTest;
begin
  const Expected = NativeInt({$IF DEFINED(CPUX64)}$3602FBFAD092CEE2{$ELSE}$13FBACF4{$ENDIF});
  Test(
    procedure(const ConvertCount: Cardinal)
    begin
      var Actual: NativeInt := $0;
      for var I := 1 to ConvertCount do
      begin
        Actual := FValue.ReverseBytes;
      end;
      CheckEquals(Expected, Actual, Format('Expected = $%s, Actual = $%s', [IntToHex(Expected), IntToHex(Actual)]));
    end
  );
end;

procedure TNativeIntTests.HelperTestBitTest;
begin
  const Expected = True;
  Test(
    procedure(const ConvertCount: Cardinal)
    begin
      var Actual := False;
      for var I := 1 to ConvertCount do
      begin
        Actual := FValue.TestBit({$IF DEFINED(CPUX64)}36{$ELSE}21{$ENDIF});
      end;
      CheckEquals(Expected, Actual);
    end
  );
end;

procedure TNativeIntTests.HelperToBytesTest;
begin
  CheckTrue(
    TEqualityComparer<TBytes>.Default.Equals(
      {$IF DEFINED(CPUX64)}[$E2, $CE, $92, $D0, $FA, $FB, $02, $36]{$ELSE}[$F4, $AC, $FB, $13]{$ENDIF},
      FValue.ToBytes
    )
  );
end;

initialization
  RegisterTest(TNativeIntTests.Suite);

end.

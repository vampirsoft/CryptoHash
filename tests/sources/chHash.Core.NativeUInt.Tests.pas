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
  chHash.Core.Bits.Tests;

type

{ TNativeUIntTests }

  TNativeUIntTests = class(TBitsTests<NativeUInt>)
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

{ TNativeUIntTests }

procedure TNativeUIntTests.SetUp;
begin
  FValue := {$IF DEFINED(CPUX64)}$995DC9BBDF1939FA{$ELSE}$CBF43926{$ENDIF};
  FBytePerConvert := SizeOf(FValue);
end;

procedure TNativeUIntTests.ReverseBitsTest;
begin
  const Expected = NativeUInt({$IF DEFINED(CPUX64)}$5F9C98FBDD93BA99{$ELSE}$649C2FD3{$ENDIF});
  Test(
    procedure(const ConvertCount: Cardinal)
    begin
      var Actual: NativeUInt := $0;
      for var I := 1 to ConvertCount do
      begin
        Actual := ReverseBits(FValue);
      end;
      CheckEquals(Expected, Actual, Format('Expected = $%s, Actual = $%s', [IntToHex(Expected), IntToHex(Actual)]));
    end
  );
end;

procedure TNativeUIntTests.ReverseBytesTest;
begin
  const Expected = NativeUInt({$IF DEFINED(CPUX64)}$FA3919DFBBC95D99{$ELSE}$2639F4CB{$ENDIF});
  Test(
    procedure(const ConvertCount: Cardinal)
    begin
      var Actual: NativeUInt := $0;
      for var I := 1 to ConvertCount do
      begin
        Actual := ReverseBytes(FValue);
      end;
      CheckEquals(Expected, Actual, Format('Expected = $%s, Actual = $%s', [IntToHex(Expected), IntToHex(Actual)]));
    end
  );
end;

procedure TNativeUIntTests.TestBitTest;
begin
  const Expected = True;
  Test(
    procedure(const ConvertCount: Cardinal)
    begin
      var Actual := False;
      for var I := 1 to ConvertCount do
      begin
        Actual := TestBit(FValue, {$IF DEFINED(CPUX64)}40{$ELSE}18{$ENDIF});
      end;
      CheckEquals(Expected, Actual);
    end
  );
end;

procedure TNativeUIntTests.ToBytesTest;
begin
  CheckTrue(
    TEqualityComparer<TBytes>.Default.Equals(
      {$IF DEFINED(CPUX64)}[$99, $5D, $C9, $BB, $DF, $19, $39, $FA]{$ELSE}[$CB, $F4, $39, $26]{$ENDIF},
      ToBytes(FValue)
    )
  );
end;

procedure TNativeUIntTests.HelperReverseBitsTest;
begin
  const Expected = NativeUInt({$IF DEFINED(CPUX64)}$5F9C98FBDD93BA99{$ELSE}$649C2FD3{$ENDIF});
  Test(
    procedure(const ConvertCount: Cardinal)
    begin
      var Actual: NativeUInt := $0;
      for var I := 1 to ConvertCount do
      begin
        Actual := FValue.ReverseBits;
      end;
      CheckEquals(Expected, Actual, Format('Expected = $%s, Actual = $%s', [IntToHex(Expected), IntToHex(Actual)]));
      CheckNotEquals(Expected, FValue, Format('Expected = $%s, Value = $%s', [IntToHex(Expected), IntToHex(FValue)]));
    end
  );
end;

procedure TNativeUIntTests.HelperReverseBytesTest;
begin
  const Expected = NativeUInt({$IF DEFINED(CPUX64)}$FA3919DFBBC95D99{$ELSE}$2639F4CB{$ENDIF});
  Test(
    procedure(const ConvertCount: Cardinal)
    begin
      var Actual: NativeUInt := $0;
      for var I := 1 to ConvertCount do
      begin
        Actual := FValue.ReverseBytes;
      end;
      CheckEquals(Expected, Actual, Format('Expected = $%s, Actual = $%s', [IntToHex(Expected), IntToHex(Actual)]));
      CheckNotEquals(Expected, FValue, Format('Expected = $%s, Value = $%s', [IntToHex(Expected), IntToHex(FValue)]));
    end
  );
end;

procedure TNativeUIntTests.HelperTestBitTest;
begin
  const Expected = True;
  Test(
    procedure(const ConvertCount: Cardinal)
    begin
      var Actual := False;
      for var I := 1 to ConvertCount do
      begin
        Actual := FValue.TestBit({$IF DEFINED(CPUX64)}40{$ELSE}18{$ENDIF});
      end;
      CheckEquals(Expected, Actual);
    end
  );
end;

procedure TNativeUIntTests.HelperToBytesTest;
begin
  CheckTrue(
    TEqualityComparer<TBytes>.Default.Equals(
      {$IF DEFINED(CPUX64)}[$99, $5D, $C9, $BB, $DF, $19, $39, $FA]{$ELSE}[$CB, $F4, $39, $26]{$ENDIF},
      FValue.ToBytes
    )
  );
end;

initialization
  RegisterTest(TNativeUIntTests.Suite);

end.

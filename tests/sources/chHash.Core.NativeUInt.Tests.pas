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

{$INCLUDE CryptoHash.Tests.inc}

interface

uses
  System.SysUtils,
  TestFramework,
  chHash.Core.Bits.Tests;

type

{ TAbstractNativeUIntTests }

  TAbstractNativeUIntTests = class abstract(TBitsTests<NativeUInt>)
  strict protected
    function GetValue: NativeUInt; override;
    function ByteToBits(const Value: Byte): NativeUInt; override;
    function BitsToHex(const Value: NativeUInt): string; override;
    function GetExpectedForReverseBits: NativeUInt; override;
    function GetExpectedForReverseBytes: NativeUInt; override;
    function GetExpectedForBytes: TBytes; override;
  end;

{ TNativeUIntTests }

  TNativeUIntTests = class(TAbstractNativeUIntTests)
  strict protected
    function GetReverseBits: NativeUInt; override;
    function GetReverseBytes: NativeUInt; override;
    function GetTestBit: Boolean; override;
    function GetBytes: TBytes; override;
  end;

{ TNativeUIntHelperTests }

  TNativeUIntHelperTests = class(TAbstractNativeUIntTests)
  strict protected
    function GetReverseBits: NativeUInt; override;
    function GetReverseBytes: NativeUInt; override;
    function GetTestBit: Boolean; override;
    function GetBytes: TBytes; override;
  end;

implementation

uses
{$IF DEFINED(USE_JEDI_CORE_LIBRARY)}
  JclLogic,
{$ENDIF ~ USE_JEDI_CORE_LIBRARY}
  chHash.Core.Bits;

{ TAbstractNativeUIntTests }

function TAbstractNativeUIntTests.GetValue: NativeUInt;
begin
  Result := {$IF DEFINED(X64)}$995DC9BBDF1939FA{$ELSE}$CBF43926{$ENDIF};
end;

function TAbstractNativeUIntTests.ByteToBits(const Value: Byte): NativeUInt;
begin
  Result := Value;
end;

function TAbstractNativeUIntTests.BitsToHex(const Value: NativeUInt): string;
begin
  Result := IntToHex(Value);
end;

function TAbstractNativeUIntTests.GetExpectedForReverseBits: NativeUInt;
begin
  Result := {$IF DEFINED(X64)}$5F9C98FBDD93BA99{$ELSE}$649C2FD3{$ENDIF};
end;

function TAbstractNativeUIntTests.GetExpectedForReverseBytes: NativeUInt;
begin
  Result := {$IF DEFINED(X64)}$FA3919DFBBC95D99{$ELSE}$2639F4CB{$ENDIF};
end;

function TAbstractNativeUIntTests.GetExpectedForBytes: TBytes;
begin
  Result := [{$IF DEFINED(X64)}$99, $5D, $C9, $BB, $DF, $19, $39, $FA{$ELSE}$CB, $F4, $39, $26{$ENDIF}];
end;

{ TNativeUIntTests }

function TNativeUIntTests.GetReverseBits: NativeUInt;
begin
  Result := ReverseBits(FValue);
end;

function TNativeUIntTests.GetReverseBytes: NativeUInt;
begin
  Result := ReverseBytes(FValue);
end;

function TNativeUIntTests.GetTestBit: Boolean;
begin
  Result := TestBit(FValue, {$IF DEFINED(X64)}40{$ELSE}18{$ENDIF});
end;

function TNativeUIntTests.GetBytes: TBytes;
begin
  Result := ToBytes(FValue);
end;

{ TNativeUIntHelperTests }

function TNativeUIntHelperTests.GetReverseBits: NativeUInt;
begin
  Result := FValue.ReverseBits;
end;

function TNativeUIntHelperTests.GetReverseBytes: NativeUInt;
begin
  Result := FValue.ReverseBytes;
end;

function TNativeUIntHelperTests.GetTestBit: Boolean;
begin
  Result := FValue.TestBit({$IF DEFINED(X64)}40{$ELSE}18{$ENDIF});
end;

function TNativeUIntHelperTests.GetBytes: TBytes;
begin
  Result := FValue.ToBytes;
end;

initialization
  RegisterTest(TNativeUIntTests.Suite);
  RegisterTest(TNativeUIntHelperTests.Suite);

end.

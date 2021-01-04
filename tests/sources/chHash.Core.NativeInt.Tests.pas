/////////////////////////////////////////////////////////////////////////////////
//*****************************************************************************//
//* Project      : CryptoHash                                                 *//
//* Latest Source: https://github.com/vampirsoft/CryptoHash                   *//
//* Unit Name    : CryptoHash.inc                                             *//
//* Author       : Сергей (LordVampir) Дворников                              *//
//* Copyright 2021 LordVampir (https://github.com/vampirsoft)                 *//
//* Licensed under the Apache License, Version 2.0                            *//
//*****************************************************************************//
/////////////////////////////////////////////////////////////////////////////////

unit chHash.Core.NativeInt.Tests;

{$INCLUDE CryptoHash.Tests.inc}

interface

uses
  System.SysUtils,
  TestFramework,
  chHash.Core.Bits.Tests;

type

{ TAbstractNativeIntTests }

  TAbstractNativeIntTests = class abstract(TBitsTests<NativeInt>)
  strict protected
    function GetValue: NativeInt; override;
    function ByteToBits(const Value: Byte): NativeInt; override;
    function BitsToHex(const Value: NativeInt): string; override;
    function GetExpectedForReverseBits: NativeInt; override;
    function GetExpectedForReverseBytes: NativeInt; override;
    function GetExpectedForBytes: TBytes; override;
  end;

{ TNativeIntTests }

  TNativeIntTests = class(TAbstractNativeIntTests)
  strict protected
    function GetReverseBits: NativeInt; override;
    function GetReverseBytes: NativeInt; override;
    function GetTestBit: Boolean; override;
    function GetBytes: TBytes; override;
  end;

{ TNativeIntHelperTests }

  TNativeIntHelperTests = class(TAbstractNativeIntTests)
  strict protected
    function GetReverseBits: NativeInt; override;
    function GetReverseBytes: NativeInt; override;
    function GetTestBit: Boolean; override;
    function GetBytes: TBytes; override;
  end;

implementation

uses
{$IF DEFINED(USE_JEDI_CORE_LIBRARY)}
  JclLogic,
{$ENDIF ~ USE_JEDI_CORE_LIBRARY}
  chHash.Core.Bits;

{ TAbstractNativeIntTests }

function TAbstractNativeIntTests.GetValue: NativeInt;
begin
  Result := NativeInt({$IF DEFINED(X64)}$E2CE92D0FAFB0236{$ELSE}$F4ACFB13{$ENDIF});
end;

function TAbstractNativeIntTests.ByteToBits(const Value: Byte): NativeInt;
begin
  Result := Value;
end;

function TAbstractNativeIntTests.BitsToHex(const Value: NativeInt): string;
begin
  Result := IntToHex(Value);
end;

function TAbstractNativeIntTests.GetExpectedForReverseBits: NativeInt;
begin
  Result := {$IF DEFINED(X64)}$6C40DF5F0B497347{$ELSE}$C8DF352F{$ENDIF};
end;

function TAbstractNativeIntTests.GetExpectedForReverseBytes: NativeInt;
begin
  Result := {$IF DEFINED(X64)}$3602FBFAD092CEE2{$ELSE}$13FBACF4{$ENDIF};
end;

function TAbstractNativeIntTests.GetExpectedForBytes: TBytes;
begin
  Result := [{$IF DEFINED(X64)}$E2, $CE, $92, $D0, $FA, $FB, $02, $36{$ELSE}$F4, $AC, $FB, $13{$ENDIF}];
end;

{ TNativeIntTests }

function TNativeIntTests.GetReverseBits: NativeInt;
begin
  Result := ReverseBits(FValue);
end;

function TNativeIntTests.GetReverseBytes: NativeInt;
begin
  Result := ReverseBytes(FValue);
end;

function TNativeIntTests.GetTestBit: Boolean;
begin
  Result := TestBit(FValue, {$IF DEFINED(X64)}36{$ELSE}21{$ENDIF});
end;

function TNativeIntTests.GetBytes: TBytes;
begin
  Result := ToBytes(FValue);
end;

{ TNativeIntHelperTests }

function TNativeIntHelperTests.GetReverseBits: NativeInt;
begin
  Result := FValue.ReverseBits;
end;

function TNativeIntHelperTests.GetReverseBytes: NativeInt;
begin
  Result := FValue.ReverseBytes;
end;

function TNativeIntHelperTests.GetTestBit: Boolean;
begin
  Result := FValue.TestBit({$IF DEFINED(X64)}36{$ELSE}21{$ENDIF});
end;

function TNativeIntHelperTests.GetBytes: TBytes;
begin
  Result := FValue.ToBytes;
end;

initialization
  RegisterTest(TNativeIntTests.Suite);
  RegisterTest(TNativeIntHelperTests.Suite);

end.

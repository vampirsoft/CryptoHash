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

{$INCLUDE CryptoHash.Tests.inc}

interface

uses
  System.SysUtils,
  TestFramework,
  chHash.Core.Bits.Tests;

type

{ TAbstractUInt64Tests }

  TAbstractUInt64Tests = class abstract(TBitsTests<UInt64>)
  strict protected
    function GetValue: UInt64; override;
    function ByteToBits(const Value: Byte): UInt64; override;
    function BitsToHex(const Value: UInt64): string; override;
    function GetExpectedForReverseBits: UInt64; override;
    function GetExpectedForReverseBytes: UInt64; override;
    function GetExpectedForBytes: TBytes; override;
  end;

{ TUInt64Tests }

  TUInt64Tests = class(TAbstractUInt64Tests)
  strict protected
    function GetReverseBits: UInt64; override;
    function GetReverseBytes: UInt64; override;
    function GetTestBit: Boolean; override;
    function GetBytes: TBytes; override;
  end;

{ TUInt64HelperTests }

  TUInt64HelperTests = class(TAbstractUInt64Tests)
  strict protected
    function GetReverseBits: UInt64; override;
    function GetReverseBytes: UInt64; override;
    function GetTestBit: Boolean; override;
    function GetBytes: TBytes; override;
  end;

implementation

uses
{$IF DEFINED(USE_JEDI_CORE_LIBRARY)}
  JclLogic,
{$ENDIF ~ USE_JEDI_CORE_LIBRARY}
  chHash.Core.Bits;

{ TAbstractUInt64Tests }

function TAbstractUInt64Tests.GetValue: UInt64;
begin
  Result := $995DC9BBDF1939FA;
end;

function TAbstractUInt64Tests.ByteToBits(const Value: Byte): UInt64;
begin
  Result := Value;
end;

function TAbstractUInt64Tests.BitsToHex(const Value: UInt64): string;
begin
  Result := IntToHex(Value);
end;

function TAbstractUInt64Tests.GetExpectedForReverseBits: UInt64;
begin
  Result := $5F9C98FBDD93BA99;
end;

function TAbstractUInt64Tests.GetExpectedForReverseBytes: UInt64;
begin
  Result := $FA3919DFBBC95D99;
end;

function TAbstractUInt64Tests.GetExpectedForBytes: TBytes;
begin
  Result := [$99, $5D, $C9, $BB, $DF, $19, $39, $FA];
end;

{ TUInt64Tests }

function TUInt64Tests.GetReverseBits: UInt64;
begin
  Result := ReverseBits(FValue);
end;

function TUInt64Tests.GetReverseBytes: UInt64;
begin
  Result := ReverseBytes(FValue);
end;

function TUInt64Tests.GetTestBit: Boolean;
begin
  Result := TestBit(FValue, 40);
end;

function TUInt64Tests.GetBytes: TBytes;
begin
  Result := ToBytes(FValue);
end;

{ TUInt64HelperTests }

function TUInt64HelperTests.GetReverseBits: UInt64;
begin
  Result := FValue.ReverseBits;
end;

function TUInt64HelperTests.GetReverseBytes: UInt64;
begin
  Result := FValue.ReverseBytes;
end;

function TUInt64HelperTests.GetTestBit: Boolean;
begin
  Result := FValue.TestBit(40);
end;

function TUInt64HelperTests.GetBytes: TBytes;
begin
  Result := FValue.ToBytes;
end;

initialization
  RegisterTest(TUInt64Tests.Suite);
  RegisterTest(TUInt64HelperTests.Suite);

end.

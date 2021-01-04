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

unit chHash.Core.Int64.Tests;

{$INCLUDE CryptoHash.Tests.inc}

interface

uses
  System.SysUtils,
  TestFramework,
  chHash.Core.Bits.Tests;

type

{ TAbstractInt64Tests }

  TAbstractInt64Tests = class abstract(TBitsTests<Int64>)
  strict protected
    function GetValue: Int64; override;
    function ByteToBits(const Value: Byte): Int64; override;
    function BitsToHex(const Value: Int64): string; override;
    function GetExpectedForReverseBits: Int64; override;
    function GetExpectedForReverseBytes: Int64; override;
    function GetExpectedForBytes: TBytes; override;
  end;

{ TInt64Tests }

  TInt64Tests = class(TAbstractInt64Tests)
  strict protected
    function GetReverseBits: Int64; override;
    function GetReverseBytes: Int64; override;
    function GetTestBit: Boolean; override;
    function GetBytes: TBytes; override;
  end;

{ TInt64HelperTests }

  TInt64HelperTests = class(TAbstractInt64Tests)
  strict protected
    function GetReverseBits: Int64; override;
    function GetReverseBytes: Int64; override;
    function GetTestBit: Boolean; override;
    function GetBytes: TBytes; override;
  end;

implementation

uses
{$IF DEFINED(USE_JEDI_CORE_LIBRARY)}
  JclLogic,
{$ENDIF ~ USE_JEDI_CORE_LIBRARY}
  chHash.Core.Bits;

{ TAbstractInt64Tests }

function TAbstractInt64Tests.GetValue: Int64;
begin
  Result := $E2CE92D0FAFB0236;
end;

function TAbstractInt64Tests.ByteToBits(const Value: Byte): Int64;
begin
  Result := Value;
end;

function TAbstractInt64Tests.BitsToHex(const Value: Int64): string;
begin
  Result := IntToHex(Value);
end;

function TAbstractInt64Tests.GetExpectedForReverseBits: Int64;
begin
  Result := $6C40DF5F0B497347;
end;

function TAbstractInt64Tests.GetExpectedForReverseBytes: Int64;
begin
  Result := $3602FBFAD092CEE2;
end;

function TAbstractInt64Tests.GetExpectedForBytes: TBytes;
begin
  Result := [$E2, $CE, $92, $D0, $FA, $FB, $02, $36];
end;

{ TInt64Tests }

function TInt64Tests.GetReverseBits: Int64;
begin
  Result := ReverseBits(FValue);
end;

function TInt64Tests.GetReverseBytes: Int64;
begin
  Result := ReverseBytes(FValue);
end;

function TInt64Tests.GetTestBit: Boolean;
begin
  Result := TestBit(FValue, 36);
end;

function TInt64Tests.GetBytes: TBytes;
begin
  Result := ToBytes(FValue);
end;

{ TInt64HelperTests }

function TInt64HelperTests.GetReverseBits: Int64;
begin
  Result := FValue.ReverseBits;
end;

function TInt64HelperTests.GetReverseBytes: Int64;
begin
  Result := FValue.ReverseBytes;
end;

function TInt64HelperTests.GetTestBit: Boolean;
begin
  Result := FValue.TestBit(36);
end;

function TInt64HelperTests.GetBytes: TBytes;
begin
  Result := FValue.ToBytes;
end;

initialization
  RegisterTest(TInt64Tests.Suite);
  RegisterTest(TInt64HelperTests.Suite);

end.

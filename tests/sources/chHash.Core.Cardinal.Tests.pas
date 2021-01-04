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

unit chHash.Core.Cardinal.Tests;

{$INCLUDE CryptoHash.Tests.inc}

interface

uses
  System.SysUtils,
  TestFramework,
  chHash.Core.Bits.Tests;

type

{ TAbstractCardinalTests }

  TAbstractCardinalTests = class abstract(TBitsTests<Cardinal>)
  strict protected
    function GetValue: Cardinal; override;
    function ByteToBits(const Value: Byte): Cardinal; override;
    function BitsToHex(const Value: Cardinal): string; override;
    function GetExpectedForReverseBits: Cardinal; override;
    function GetExpectedForReverseBytes: Cardinal; override;
    function GetExpectedForBytes: TBytes; override;
  end;

{ TCardinalTests }

  TCardinalTests = class(TAbstractCardinalTests)
  strict protected
    function GetReverseBits: Cardinal; override;
    function GetReverseBytes: Cardinal; override;
    function GetTestBit: Boolean; override;
    function GetBytes: TBytes; override;
  end;

{ TCardinalHelperTests }

  TCardinalHelperTests = class(TAbstractCardinalTests)
  strict protected
    function GetReverseBits: Cardinal; override;
    function GetReverseBytes: Cardinal; override;
    function GetTestBit: Boolean; override;
    function GetBytes: TBytes; override;
  end;

implementation

uses
{$IF DEFINED(USE_JEDI_CORE_LIBRARY)}
  JclLogic,
{$ENDIF ~ USE_JEDI_CORE_LIBRARY}
  chHash.Core.Bits;

{ TAbstractCardinalTests }

function TAbstractCardinalTests.GetValue: Cardinal;
begin
  Result := $CBF43926;
end;

function TAbstractCardinalTests.ByteToBits(const Value: Byte): Cardinal;
begin
  Result := Value;
end;

function TAbstractCardinalTests.BitsToHex(const Value: Cardinal): string;
begin
  Result := IntToHex(Value);
end;

function TAbstractCardinalTests.GetExpectedForReverseBits: Cardinal;
begin
  Result := $649C2FD3;
end;

function TAbstractCardinalTests.GetExpectedForReverseBytes: Cardinal;
begin
  Result := $2639F4CB;
end;

function TAbstractCardinalTests.GetExpectedForBytes: TBytes;
begin
  Result := [$CB, $F4, $39, $26];
end;

{ TCardinalTests }

function TCardinalTests.GetReverseBits: Cardinal;
begin
  Result := ReverseBits(FValue);
end;

function TCardinalTests.GetReverseBytes: Cardinal;
begin
  Result := ReverseBytes(FValue);
end;

function TCardinalTests.GetTestBit: Boolean;
begin
  Result := TestBit(FValue, 18);
end;

function TCardinalTests.GetBytes: TBytes;
begin
  Result := ToBytes(FValue);
end;

{ TCardinalHelperTests }

function TCardinalHelperTests.GetReverseBits: Cardinal;
begin
  Result := FValue.ReverseBits;
end;

function TCardinalHelperTests.GetReverseBytes: Cardinal;
begin
  Result := FValue.ReverseBytes;
end;

function TCardinalHelperTests.GetTestBit: Boolean;
begin
  Result := FValue.TestBit(18);
end;

function TCardinalHelperTests.GetBytes: TBytes;
begin
  Result := FValue.ToBytes;
end;

initialization
  RegisterTest(TCardinalTests.Suite);
  RegisterTest(TCardinalHelperTests.Suite);

end.

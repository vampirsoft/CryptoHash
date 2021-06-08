/////////////////////////////////////////////////////////////////////////////////
//*****************************************************************************//
//* Project      : CryptoHash                                                 *//
//* Latest Source: https://github.com/vampirsoft/CryptoHash                   *//
//* Unit Name    : CryptoHash.inc                                             *//
//* Author       : Сергей (LordVampir) Дворников                              *//
//* Copyright 2021 LordVampir (https://github.com/vampirsoft)                 *//
//* Licensed under MIT                                                        *//
//*****************************************************************************//
/////////////////////////////////////////////////////////////////////////////////

unit chHash.Core.Integer.Tests;

{$INCLUDE CryptoHash.Tests.inc}

interface

uses
  System.SysUtils,
  TestFramework,
  chHash.Core.Bits.Tests;

type

{ TAbstractIntegerTests }

  TAbstractIntegerTests = class abstract(TBitsTests<Integer>)
  strict protected
    function GetValue: Integer; override;
    function ByteToBits(const Value: Byte): Integer; override;
    function BitsToHex(const Value: Integer): string; override;
    function GetExpectedForReverseBits: Integer; override;
    function GetExpectedForReverseBytes: Integer; override;
    function GetExpectedForBytes: TBytes; override;
  end;

{ TIntegerTests }

  TIntegerTests = class(TAbstractIntegerTests)
  strict protected
    function GetReverseBits: Integer; override;
    function GetReverseBytes: Integer; override;
    function GetTestBit: Boolean; override;
    function GetBytes: TBytes; override;
  end;

{ TIntegerHelperTests }

  TIntegerHelperTests = class(TAbstractIntegerTests)
  strict protected
    function GetReverseBits: Integer; override;
    function GetReverseBytes: Integer; override;
    function GetTestBit: Boolean; override;
    function GetBytes: TBytes; override;
  end;

implementation

uses
{$IF DEFINED(USE_JEDI_CORE_LIBRARY)}
  JclLogic,
{$ENDIF ~ USE_JEDI_CORE_LIBRARY}
  chHash.Core.Bits;

{ TAbstractIntegerTests }

function TAbstractIntegerTests.GetValue: Integer;
begin
  Result := $F4ACFB13;
end;

function TAbstractIntegerTests.ByteToBits(const Value: Byte): Integer;
begin
  Result := Value;
end;

function TAbstractIntegerTests.BitsToHex(const Value: Integer): string;
begin
  Result := IntToHex(Value);
end;

function TAbstractIntegerTests.GetExpectedForReverseBits: Integer;
begin
  Result := $C8DF352F;
end;

function TAbstractIntegerTests.GetExpectedForReverseBytes: Integer;
begin
  Result := $13FBACF4;
end;

function TAbstractIntegerTests.GetExpectedForBytes: TBytes;
begin
  Result := [$F4, $AC, $FB, $13];
end;

{ TIntegerTests }

function TIntegerTests.GetReverseBits: Integer;
begin
  Result := ReverseBits(FValue);
end;

function TIntegerTests.GetReverseBytes: Integer;
begin
  Result := ReverseBytes(FValue);
end;

function TIntegerTests.GetTestBit: Boolean;
begin
  Result := TestBit(FValue, 21);
end;

function TIntegerTests.GetBytes: TBytes;
begin
  Result := ToBytes(FValue);
end;

{ TIntegerHelperTests }

function TIntegerHelperTests.GetReverseBits: Integer;
begin
  Result := FValue.ReverseBits;
end;

function TIntegerHelperTests.GetReverseBytes: Integer;
begin
  Result := FValue.ReverseBytes;
end;

function TIntegerHelperTests.GetTestBit: Boolean;
begin
  Result := FValue.TestBit(21);
end;

function TIntegerHelperTests.GetBytes: TBytes;
begin
  Result := FVAlue.ToBytes;
end;

initialization
  RegisterTest(TIntegerTests.Suite);
  RegisterTest(TIntegerHelperTests.Suite);

end.

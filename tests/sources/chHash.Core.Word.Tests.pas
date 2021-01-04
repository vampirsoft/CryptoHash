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

unit chHash.Core.Word.Tests;

{$INCLUDE CryptoHash.Tests.inc}

interface

uses
  System.SysUtils,
  TestFramework,
  chHash.Core.Bits.Tests;

type

{ TAbstractWordTests }

  TAbstractWordTests = class abstract(TBitsTests<Word>)
  strict protected
    function GetValue: Word; override;
    function ByteToBits(const Value: Byte): Word; override;
    function BitsToHex(const Value: Word): string; override;
    function GetExpectedForReverseBits: Word; override;
    function GetExpectedForReverseBytes: Word; override;
    function GetExpectedForBytes: TBytes; override;
  end;

{ TWordTests }

  TWordTests = class(TAbstractWordTests)
  strict protected
    function GetReverseBits: Word; override;
    function GetReverseBytes: Word; override;
    function GetTestBit: Boolean; override;
    function GetBytes: TBytes; override;
  end;

{ TWordHelperTests }

  TWordHelperTests = class(TAbstractWordTests)
  strict protected
    function GetReverseBits: Word; override;
    function GetReverseBytes: Word; override;
    function GetTestBit: Boolean; override;
    function GetBytes: TBytes; override;
  end;

implementation

uses
{$IF DEFINED(USE_JEDI_CORE_LIBRARY)}
  JclLogic,
{$ENDIF ~ USE_JEDI_CORE_LIBRARY}
  chHash.Core.Bits;

{ TAbstractWordTests }

function TAbstractWordTests.GetValue: Word;
begin
  Result := $29B1;
end;

function TAbstractWordTests.ByteToBits(const Value: Byte): Word;
begin
  Result := Value;
end;

function TAbstractWordTests.BitsToHex(const Value: Word): string;
begin
  Result := IntToHex(Value);
end;

function TAbstractWordTests.GetExpectedForReverseBits: Word;
begin
  Result := $8D94;
end;

function TAbstractWordTests.GetExpectedForReverseBytes: Word;
begin
  Result := $B129;
end;

function TAbstractWordTests.GetExpectedForBytes: TBytes;
begin
  Result := [$29, $B1];
end;

{ TWordTests }

function TWordTests.GetReverseBits: Word;
begin
  Result := ReverseBits(FValue);
end;

function TWordTests.GetReverseBytes: Word;
begin
  Result := ReverseBytes(FValue);
end;

function TWordTests.GetTestBit: Boolean;
begin
  Result := TestBit(FValue, 11);
end;

function TWordTests.GetBytes: TBytes;
begin
  Result := ToBytes(FValue);
end;

{ TWordHelperTests }

function TWordHelperTests.GetReverseBits: Word;
begin
  Result := FValue.ReverseBits;
end;

function TWordHelperTests.GetReverseBytes: Word;
begin
  Result := FValue.ReverseBytes;
end;

function TWordHelperTests.GetTestBit: Boolean;
begin
  Result := FValue.TestBit(11);
end;

function TWordHelperTests.GetBytes: TBytes;
begin
  Result := FValue.ToBytes;
end;

initialization
  RegisterTest(TWordTests.Suite);
  RegisterTest(TWordHelperTests.Suite);

end.

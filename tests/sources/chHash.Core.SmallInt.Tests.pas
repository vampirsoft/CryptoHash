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

unit chHash.Core.SmallInt.Tests;

{$INCLUDE CryptoHash.Tests.inc}

interface

uses
  System.SysUtils,
  TestFramework,
  chHash.Core.Bits.Tests;

type

{ TAbstractSmallIntTests }

  TAbstractSmallIntTests = class abstract(TBitsTests<SmallInt>)
  strict protected
    function GetValue: SmallInt; override;
    function ByteToBits(const Value: Byte): SmallInt; override;
    function BitsToHex(const Value: SmallInt): string; override;
    function GetExpectedForReverseBits: SmallInt; override;
    function GetExpectedForReverseBytes: SmallInt; override;
    function GetExpectedForBytes: TBytes; override;
  end;

{ TSmallIntTests }

  TSmallIntTests = class(TAbstractSmallIntTests)
  strict protected
    function GetReverseBits: SmallInt; override;
    function GetReverseBytes: SmallInt; override;
    function GetTestBit: Boolean; override;
    function GetBytes: TBytes; override;
  end;

{ TSmallIntHelperTests }

  TSmallIntHelperTests = class(TAbstractSmallIntTests)
  strict protected
    function GetReverseBits: SmallInt; override;
    function GetReverseBytes: SmallInt; override;
    function GetTestBit: Boolean; override;
    function GetBytes: TBytes; override;
  end;

implementation

uses
{$IF DEFINED(USE_JEDI_CORE_LIBRARY)}
  JclLogic,
{$ENDIF ~ USE_JEDI_CORE_LIBRARY}
  chHash.Core.Bits;

{ TAbstractSmallIntTests }

function TAbstractSmallIntTests.GetValue: SmallInt;
begin
  Result := SmallInt($FEE8);
end;

function TAbstractSmallIntTests.ByteToBits(const Value: Byte): SmallInt;
begin
  Result := Value;
end;

function TAbstractSmallIntTests.BitsToHex(const Value: SmallInt): string;
begin
  Result := IntToHex(Value);
end;

function TAbstractSmallIntTests.GetExpectedForReverseBits: SmallInt;
begin
  Result := $177F;
end;

function TAbstractSmallIntTests.GetExpectedForReverseBytes: SmallInt;
begin
  Result := SmallInt($E8FE);
end;

function TAbstractSmallIntTests.GetExpectedForBytes: TBytes;
begin
  Result := [$FE, $E8];
end;

{ TSmallIntTests }

function TSmallIntTests.GetReverseBits: SmallInt;
begin
  Result := ReverseBits(FValue);
end;

function TSmallIntTests.GetReverseBytes: SmallInt;
begin
  Result := ReverseBytes(FValue);
end;

function TSmallIntTests.GetTestBit: Boolean;
begin
  Result := TestBit(FValue, 9);
end;

function TSmallIntTests.GetBytes: TBytes;
begin
  Result := ToBytes(FValue);
end;

{ TSmallIntHelperTests }

function TSmallIntHelperTests.GetReverseBits: SmallInt;
begin
  Result := FValue.ReverseBits;
end;

function TSmallIntHelperTests.GetReverseBytes: SmallInt;
begin
  Result := FValue.ReverseBytes;
end;

function TSmallIntHelperTests.GetTestBit: Boolean;
begin
  Result := FValue.TestBit(9);
end;

function TSmallIntHelperTests.GetBytes: TBytes;
begin
  Result := FValue.ToBytes;
end;

initialization
  RegisterTest(TSmallIntTests.Suite);
  RegisterTest(TSmallIntHelperTests.Suite);

end.

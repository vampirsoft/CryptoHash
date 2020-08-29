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

unit chHash.Core.ShortInt.Tests;

{$INCLUDE CryptoHash.Tests.inc}

interface

uses
  System.SysUtils,
  TestFramework,
  chHash.Core.Bits.Tests;

type

{ TAbstractShortIntTests }

  TAbstractShortIntTests = class abstract(TBitsTests<ShortInt>)
  strict protected
    function GetValue: ShortInt; override;
    function ByteToBits(const Value: Byte): ShortInt; override;
    function BitsToHex(const Value: ShortInt): string; override;
    function GetExpectedForReverseBits: ShortInt; override;
    function GetExpectedForReverseBytes: ShortInt; override;
    function GetExpectedForBytes: TBytes; override;
  end;

{ TShortIntTests }

  TShortIntTests = class(TAbstractShortIntTests)
  strict protected
    function GetReverseBits: ShortInt; override;
    function GetReverseBytes: ShortInt; override;
    function GetTestBit: Boolean; override;
    function GetBytes: TBytes; override;
  end;

{ TShortIntHelperTests }

  TShortIntHelperTests = class(TAbstractShortIntTests)
  strict protected
    function GetReverseBits: ShortInt; override;
    function GetReverseBytes: ShortInt; override;
    function GetTestBit: Boolean; override;
    function GetBytes: TBytes; override;
  end;

implementation

uses
{$IF DEFINED(USE_JEDI_CORE_LIBRARY)}
  JclLogic,
{$ENDIF ~ USE_JEDI_CORE_LIBRARY}
  chHash.Core.Bits;

{ TAbstractShortIntTests }

function TAbstractShortIntTests.GetValue: ShortInt;
begin
  Result := ShortInt($F4);
end;

function TAbstractShortIntTests.ByteToBits(const Value: Byte): ShortInt;
begin
  Result := Value;
end;

function TAbstractShortIntTests.BitsToHex(const Value: ShortInt): string;
begin
  Result := IntToHex(Value);
end;

function TAbstractShortIntTests.GetExpectedForReverseBits: ShortInt;
begin
  Result := $2F;
end;

function TAbstractShortIntTests.GetExpectedForReverseBytes: ShortInt;
begin
  Result := ShortInt($F4);
end;

function TAbstractShortIntTests.GetExpectedForBytes: TBytes;
begin
  Result := [$F4];
end;

{ TShortIntTests }

function TShortIntTests.GetReverseBits: ShortInt;
begin
  Result := ReverseBits(FValue);
end;

function TShortIntTests.GetReverseBytes: ShortInt;
begin
  Result := ShortInt($F4);
end;

function TShortIntTests.GetTestBit: Boolean;
begin
  Result := TestBit(FValue, 2);
end;

function TShortIntTests.GetBytes: TBytes;
begin
  Result := ToBytes(FValue);
end;

{ TShortIntHelperTests }

function TShortIntHelperTests.GetReverseBits: ShortInt;
begin
  Result := FValue.ReverseBits;
end;

function TShortIntHelperTests.GetReverseBytes: ShortInt;
begin
  Result := ShortInt($F4);
end;

function TShortIntHelperTests.GetTestBit: Boolean;
begin
  Result := FValue.TestBit(2);
end;

function TShortIntHelperTests.GetBytes: TBytes;
begin
  Result := FValue.ToBytes;
end;

initialization
  RegisterTest(TShortIntTests.Suite);
  RegisterTest(TShortIntHelperTests.Suite);

end.

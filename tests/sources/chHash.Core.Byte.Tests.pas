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

unit chHash.Core.Byte.Tests;

{$INCLUDE CryptoHash.Tests.inc}

interface

uses
  System.SysUtils,
  TestFramework,
  chHash.Core.Bits.Tests;

type

{ TAbstractByteTests }

  TAbstractByteTests = class abstract(TBitsTests<Byte>)
  strict protected
    function GetValue: Byte; override;
    function ByteToBits(const Value: Byte): Byte; override;
    function BitsToHex(const Value: Byte): string; override;
    function GetExpectedForReverseBits: Byte; override;
    function GetExpectedForReverseBytes: Byte; override;
    function GetExpectedForBytes: TBytes; override;
  end;

{ TByteTests }

  TByteTests = class(TAbstractByteTests)
  strict protected
    function GetReverseBits: Byte; override;
    function GetReverseBytes: Byte; override;
    function GetTestBit: Boolean; override;
    function GetBytes: TBytes; override;
  end;

{ TByteHelperTests }

  TByteHelperTests = class(TAbstractByteTests)
  strict protected
    function GetReverseBits: Byte; override;
    function GetReverseBytes: Byte; override;
    function GetTestBit: Boolean; override;
    function GetBytes: TBytes; override;
  end;

implementation

uses
{$IF DEFINED(USE_JEDI_CORE_LIBRARY)}
  JclLogic,
{$ENDIF ~ USE_JEDI_CORE_LIBRARY}
  chHash.Core.Bits;

{ TAbstractByteTests }

function TAbstractByteTests.GetValue: Byte;
begin
  Result := $DA;
end;

function TAbstractByteTests.ByteToBits(const Value: Byte): Byte;
begin
  Result := Value;
end;

function TAbstractByteTests.BitsToHex(const Value: Byte): string;
begin
  Result := IntToHex(Value);
end;

function TAbstractByteTests.GetExpectedForReverseBits: Byte;
begin
  Result := $5B;
end;

function TAbstractByteTests.GetExpectedForReverseBytes: Byte;
begin
  Result := $DA;
end;

function TAbstractByteTests.GetExpectedForBytes: TBytes;
begin
  Result := [$DA];
end;

{ TByteTests }

function TByteTests.GetReverseBits: Byte;
begin
  Result := ReverseBits(FValue);
end;

function TByteTests.GetReverseBytes: Byte;
begin
  Result := $DA;
end;

function TByteTests.GetTestBit: Boolean;
begin
  Result := TestBit(FValue, 4);
end;

function TByteTests.GetBytes: TBytes;
begin
  Result := ToBytes(FValue);
end;

{ TByteHelperTests }

function TByteHelperTests.GetReverseBits: Byte;
begin
  Result := FValue.ReverseBits;
end;

function TByteHelperTests.GetReverseBytes: Byte;
begin
  Result := $DA;
end;

function TByteHelperTests.GetTestBit: Boolean;
begin
  Result := FValue.TestBit(4);
end;

function TByteHelperTests.GetBytes: TBytes;
begin
  Result := FValue.ToBytes;
end;

initialization
  RegisterTest(TByteTests.Suite);
  RegisterTest(TByteHelperTests.Suite);

end.

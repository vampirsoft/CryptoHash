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

unit chHash.Core.Pointer.Tests;

{$INCLUDE CryptoHash.Tests.inc}

interface

uses
  System.SysUtils,
  TestFramework,
  chHash.Core.Bits.Tests;

type

{ TAbstractPointerTests }

  TAbstractPointerTests = class abstract(TBitsTests<TBytes>)
  strict protected
    FLength: Cardinal;
    function GetValue: TBytes; override;
    function ByteToBits(const Value: Byte): TBytes; override;
    function BitsToHex(const Value: TBytes): string; override;
    function GetExpectedForReverseBits: TBytes; override;
    function GetExpectedForReverseBytes: TBytes; override;
    function GetExpectedForTestBit: Boolean; override;
    function GetExpectedForBytes: TBytes; override;
  public
    procedure SetUp; override;
  end;

{ TPointerTests }

  TPointerTests = class(TAbstractPointerTests)
  strict protected
    function GetReverseBits: TBytes; override;
    function GetReverseBytes: TBytes; override;
    function GetTestBit: Boolean; override;
    function GetBytes: TBytes; override;
  end;

{ TPointerHelperTests }

  TPointerHelperTests = class(TAbstractPointerTests)
  strict protected
    function GetReverseBits: TBytes; override;
    function GetReverseBytes: TBytes; override;
    function GetTestBit: Boolean; override;
    function GetBytes: TBytes; override;
  end;

implementation

uses
{$IF DEFINED(USE_JEDI_CORE_LIBRARY)}
  JclLogic,
{$ENDIF ~ USE_JEDI_CORE_LIBRARY}
  chHash.Core.Bits;

{ TAbstractPointerTests }

function TAbstractPointerTests.GetValue: TBytes;
begin
  FLength := 5;
  Randomize;
  SetLength(Result, FLength);
  for var I: Byte := 0 to FLength - 1 do
  begin
    Result[I] := Random(256);
  end;
end;

function TAbstractPointerTests.ByteToBits(const Value: Byte): TBytes;
begin
  Result := ToBytes(Value);
end;

function TAbstractPointerTests.BitsToHex(const Value: TBytes): string;
begin
  Result := '';
  for var I := 0 to Length(Value) - 1 do
  begin
    Result := Result + IntToHex(Value[I]);
  end;
end;

function TAbstractPointerTests.GetExpectedForReverseBits: TBytes;
begin
  SetLength(Result, FLength);
  for var I := 1 to FLength do
  begin
    Result[FLength - I] := ReverseBits(FValue[I - 1]);
  end;
end;

function TAbstractPointerTests.GetExpectedForReverseBytes: TBytes;
begin
  SetLength(Result, FLength);
  for var I := 1 to FLength do
  begin
    Result[FLength - I] := FValue[I - 1];
  end;
end;

function TAbstractPointerTests.GetExpectedForTestBit: Boolean;
begin
  Result := TestBit(FValue[4], 4);
end;

function TAbstractPointerTests.GetExpectedForBytes: TBytes;
begin
  Result := FValue;
end;

procedure TAbstractPointerTests.SetUp;
begin
  inherited SetUp;
  FBytePerConvert := FLength;
end;

{ TPointerTests }

function TPointerTests.GetReverseBits: TBytes;
begin
  Result := FValue;
  ReverseBits(Result, FLength);
end;

function TPointerTests.GetReverseBytes: TBytes;
begin
  Result := FValue;
  ReverseBytes(Result, FLength);
end;

function TPointerTests.GetTestBit: Boolean;
begin
  const Bit = (FLength - 1) * BitsPerByte + 4;
  Result := TestBit(FValue, Bit);
end;

function TPointerTests.GetBytes: TBytes;
begin
  Result := ToBytes(@FValue[0], FLength);
end;

{ TPointerHelperTests }

function TPointerHelperTests.GetReverseBits: TBytes;
begin
  Result := FValue;
  (@Result[0]).ReverseBits(FLength);
end;

function TPointerHelperTests.GetReverseBytes: TBytes;
begin
  Result := FValue;
  (@Result[0]).ReverseBytes(FLength);
end;

function TPointerHelperTests.GetTestBit: Boolean;
begin
  const Bit = (FLength - 1) * BitsPerByte + 4;
  Result := (@FValue[0]).TestBit(Bit);
end;

function TPointerHelperTests.GetBytes: TBytes;
begin
  Result := (@FValue[0]).ToBytes(FLength);
end;

initialization
  RegisterTest(TPointerTests.Suite);
  RegisterTest(TPointerHelperTests.Suite);

end.

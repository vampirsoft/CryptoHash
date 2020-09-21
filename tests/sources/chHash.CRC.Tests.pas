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

unit chHash.CRC.Tests;

{$INCLUDE CryptoHash.Tests.inc}

interface

uses
  System.SysUtils,
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.Impl,
  chHash.Tests;

type

{ TchCrcTests<Bits, HA> }

  TchCrcTests<Bits; HA: {$IF DEFINED(SUPPORTS_INTERFACES)}IchCrc<Bits>{$ELSE}TchCrc<Bits>{$ENDIF}> =
    class abstract(TchAlgorithmTests<Bits, Bits, HA>)
  strict private
    function BitsToHex(const Value: Bits): string;{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}
    function FinalControlCalculate(const Value: Bits): Bits;{$IF DEFINED(USE_INLINE)}inline;{$ENDIF}
  strict protected
    FCrcTable: TchCrc<Bits>.TOneLevelCrcTable;
    function GetCount: Cardinal; override;
    function GetMaxLength: Cardinal; override;
    function GetCheckValueForEmpty: Bits; override;
    function GetCheckMessage(const Expected, Actual: Bits): string; override;
    procedure ControlCalculate(var Current: Bits; const Data; const Length: Cardinal); virtual; abstract;
    procedure DataStressTest(const Data: TBytes; const MaxLength, Count: Cardinal); override;
  public
    procedure SetUp; override;
  published
    procedure CheckTest; override;
    procedure CombineTest;
  end;

implementation

uses
{$IF DEFINED(USE_JEDI_CORE_LIBRARY)}
  JclLogic,
{$ENDIF ~ USE_JEDI_CORE_LIBRARY}
  chHash.Core.Bits,
  System.Diagnostics;

{ TchCrcTests<Bits, HA> }

function TchCrcTests<Bits, HA>.GetCount: Cardinal;
begin
  Result := 1024 * 16;
//  Result := 1 * 1;
//  Result := 1024 * 1;
end;

function TchCrcTests<Bits, HA>.GetMaxLength: Cardinal;
begin
  Result := $FFFF;
//  Result := $FFFFFFF;
//  Result := $100000
end;

function TchCrcTests<Bits, HA>.BitsToHex(const Value: Bits): string;
const
  SizeOfBits  = Byte(SizeOf(Bits));

begin
  const Bytes = (@Value).ToBytes(SizeOfBits);
  Result := '';
  for var I := 0 to Length(Bytes) - 1 do
  begin
    Result := Result + IntToHex(Bytes[I]);
  end;
end;

function TchCrcTests<Bits, HA>.FinalControlCalculate(const Value: Bits): Bits;
const
  SizeOfBits  = Byte(SizeOf(Bits));
  BitsPerBits = Byte(SizeOfBits * BitsPerByte);

begin
  const Algorithm = FAlgorithm as TchCrc<Bits>;
  Result := Value;
  if Algorithm.RefIn xor Algorithm.RefOut then
  begin
    ReverseBits(@Result, SizeOfBits);
    Result := Algorithm.RightShift(Result, BitsPerBits - Algorithm.Width);
  end;
  Result := Algorithm.BitwiseXor(Result, Algorithm.XorOut);
  Result := Algorithm.BitwiseAnd(Result, Algorithm.Mask);
end;

function TchCrcTests<Bits, HA>.GetCheckValueForEmpty: Bits;
begin
  Result := FAlgorithm.Final(FAlgorithm.Init);
end;

function TchCrcTests<Bits, HA>.GetCheckMessage(const Expected, Actual: Bits): string;
begin
  Result := Format('%s: Expected = $%s, Actual = $%s', [FAlgorithm.ToString, BitsToHex(Expected), BitsToHex(Actual)]);
end;

procedure TchCrcTests<Bits, HA>.DataStressTest(const Data: TBytes; const MaxLength, Count: Cardinal);
begin
  var Actual := FAlgorithm.Init;
  const Stopwatch = TStopwatch.StartNew;
  for var I := 1 to Count do
  begin
    ControlCalculate(Actual, Data[0], MaxLength);
  end;
  Stopwatch.Stop;
  const S = Stopwatch.Elapsed.TotalSeconds;
  if S = 0 then Status(Format('%s: Control Speed = 0s, %.3f MB/s', [FAlgorithm.ToString, GetMaxLength/1 * Count]))
  else Status(Format('%s: Control Speed = %.3fs, %.3f MB/s', [FAlgorithm.ToString, S, (GetMaxLength/(1024 * 1024)/S) * Count]));

  inherited DataStressTest(Data, MaxLength, Count);
end;

procedure TchCrcTests<Bits, HA>.SetUp;
begin
  inherited SetUp;
  FCrcTable := (FAlgorithm as TchCrc<Bits>).CrcTable;
end;

procedure TchCrcTests<Bits, HA>.CheckTest;
begin
  var Expected := FAlgorithm.Init;
  ControlCalculate(Expected, FTestString[1], Length(FTestString));
  CheckResult(FAlgorithm.Check, FinalControlCalculate(Expected));

  Randomize;
  const TestSize = Random((FAlgorithm as TchCrc<Bits>).TABLE_LEVEL_SIZE * 3 - 1) + 1;
  var Data: TBytes;
  SetLength(Data, TestSize);
  for var I := 0 to TestSize - 1 do
  begin
    Data[I] := Random(256);
  end;

  Expected := FAlgorithm.Init;
  for var I := 0 to 1 do
  begin
    ControlCalculate(Expected, Data[0], TestSize);
  end;

  var Actual := FAlgorithm.Init;
  for var I := 0 to 1 do
  begin
    FAlgorithm.Calculate(Actual, Data[0], TestSize);
  end;
  CheckResult(FinalControlCalculate(Expected), FAlgorithm.Final(Actual));
end;

procedure TchCrcTests<Bits, HA>.CombineTest;
begin
  Randomize;
  const RightLength = Random(10);
  const LeftLength = Length(FTestString) - RightLength;

  var LeftCrc := FAlgorithm.Init;
  FAlgorithm.Calculate(LeftCrc, FTestString[1], LeftLength);
  LeftCrc := FAlgorithm.Final(LeftCrc);

  var RightCrc := FAlgorithm.Init;
  FAlgorithm.Calculate(RightCrc, FTestString[1 + LeftLength], RightLength);
  RightCrc := FAlgorithm.Final(RightCrc);

  const Actual = FAlgorithm.Combine(LeftCrc, RightCrc, RightLength);
  CheckResult(FAlgorithm.Check, Actual);
end;

end.

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

{$INCLUDE CryptoHash.inc}

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
  strict protected
    FCrcTable: TchCrc<Bits>.TOneLevelCrcTable;
    function GetCheckValueForEmpty: Bits; override;
    function GetCheckMessage(const Expected, Actual: Bits): string; override;
    function BitsToHex(const Value: Bits): string; virtual; abstract;
    function FinalControlCalculate(const Value: Bits): Bits; virtual; abstract;
    procedure ControllStressTest(const Data: TBytes); override;
    procedure ControlCalculate(var Current: Bits; const Data; Length: Integer); virtual; abstract;
  public
    procedure SetUp; override;
  published
    procedure CheckTest; override;
    procedure CombineTest;
  end;

implementation

uses
  System.Diagnostics;

{ TchCrcTests<Bits, HA> }

procedure TchCrcTests<Bits, HA>.CheckTest;
begin
  var Expected := FAlgorithm.Init;
  ControlCalculate(Expected, FTestString[1], Length(FTestString));
  CheckResult(FAlgorithm.Check, FinalControlCalculate(Expected));

  Randomize;
  const TestSize = Random(107) + 1;
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

procedure TchCrcTests<Bits, HA>.ControllStressTest(const Data: TBytes);
begin
  var Actual := FAlgorithm.Init;
  const Stopwatch = TStopwatch.StartNew;
  for var I := 1 to GetCount do
  begin
    ControlCalculate(Actual, Data[0], GetMaxLength);
  end;
  Stopwatch.Stop;
  const S = Stopwatch.Elapsed.TotalSeconds;
  if S = 0 then Status(Format('%s: Control Speed = 0s, %.3f MB/s', [FAlgorithm.ToString, GetMaxLength/1 * GetCount]))
  else Status(Format('%s: Control Speed = %.3fs, %.3f MB/s', [FAlgorithm.ToString, S, (GetMaxLength/(1024 * 1024)/S) * GetCount]));
end;

function TchCrcTests<Bits, HA>.GetCheckMessage(const Expected, Actual: Bits): string;
begin
  Result := Format('%s: Expected = $%s, Actual = $%s', [FAlgorithm.ToString, BitsToHex(Expected), BitsToHex(Actual)]);
end;

function TchCrcTests<Bits, HA>.GetCheckValueForEmpty: Bits;
begin
  Result := FAlgorithm.Final(FAlgorithm.Init);
end;

procedure TchCrcTests<Bits, HA>.SetUp;
begin
  inherited SetUp;
  FCrcTable := TchCrc<Bits>(FAlgorithm).CrcTable;
end;

end.

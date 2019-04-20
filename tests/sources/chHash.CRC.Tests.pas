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
  chHash.CRC,
  chHash.Tests;

type

{ TchCrcAlgorithmTests<B, HA> }

  TchCrcAlgorithmTests<B; HA: TchCrcAlgorithm<B>> = class abstract(TchAlgorithmTests<B, B, HA>)
  strict protected
    FCrcTable: TchCrcAlgorithm<B>.TOneLevelCrcTable;
    function GetCheckMessage(const Expected, Actual: B): string; override;
    function BitsToHex(const Value: B): string; virtual; abstract;
    function FinalControlCalculate(const Value: B): B; virtual; abstract;
    procedure ControllStressTest(const Data: TBytes); override;
    procedure ControlCalculate(var Current: B; const Data; Length: Integer); virtual; abstract;
  public
    procedure SetUp; override;
  published
    procedure CheckTest; override;
    procedure CombineTest;
  end;

implementation

uses
  System.Diagnostics;

{ TchCrcAlgorithmTests<B, HA> }

procedure TchCrcAlgorithmTests<B, HA>.CheckTest;
begin
  var Expected: B := FAlgorithm.Init;
  ControlCalculate(Expected, FTestString[1], Length(FTestString));
  CheckResult(FAlgorithm.Check, FinalControlCalculate(Expected));

  Randomize;
  const TestSize = Random(107) + 1;
  var Data: TBytes;
  SetLength(Data, TestSize);
  for var I: Byte := 0 to TestSize - 1 do
  begin
    Data[I] := Random(256);
  end;

  Expected := FAlgorithm.Init;
  for var I: Byte := 0 to 1 do
  begin
    ControlCalculate(Expected, Data[0], TestSize);
  end;

  var Actual: B := FAlgorithm.Init;
  for var I: Byte := 0 to 1 do
  begin
    FAlgorithm.Calculate(Actual, Data[0], TestSize);
  end;
  CheckResult(FinalControlCalculate(Expected), FAlgorithm.Final(Actual));
end;

procedure TchCrcAlgorithmTests<B, HA>.CombineTest;
begin
  Randomize;
  const RightLength: Byte = Random(10);
  const LeftLength: Byte = Length(FTestString) - RightLength;

  var LeftCrc: B := FAlgorithm.Init;
  FAlgorithm.Calculate(LeftCrc, FTestString[1], LeftLength);
  LeftCrc := FAlgorithm.Final(LeftCrc);

  var RightCrc: B := FAlgorithm.Init;
  FAlgorithm.Calculate(RightCrc, FTestString[1 + LeftLength], RightLength);
  RightCrc := FAlgorithm.Final(RightCrc);

  const Actual: B = FAlgorithm.Combine(LeftCrc, RightCrc, RightLength);
  CheckResult(FAlgorithm.Check, Actual);
end;

procedure TchCrcAlgorithmTests<B, HA>.ControllStressTest(const Data: TBytes);
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

function TchCrcAlgorithmTests<B, HA>.GetCheckMessage(const Expected, Actual: B): string;
begin
  Result := Format('%s: Expected = $%s, Actual = $%s', [FAlgorithm.ToString, BitsToHex(Expected), BitsToHex(Actual)]);
end;

procedure TchCrcAlgorithmTests<B, HA>.SetUp;
begin
  inherited SetUp;
  FCrcTable := FAlgorithm.CrcTable;
end;

end.

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

unit chHash.Tests;

{$INCLUDE CryptoHash.Tests.inc}

interface

uses
  System.SysUtils,
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash,
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.Impl,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.Utils,
  TestFramework;

type

{ TchAlgorithmTests<C, R, HA> }

  TchAlgorithmTests<C; R; HA: {$IF DEFINED(SUPPORTS_INTERFACES)}IchAlgorithm<C, R>{$ELSE}TchAlgorithm<C, R>{$ENDIF}> =
    class abstract(TTestCase)
  strict protected const
    FTestString: AnsiString = '123456789';
  strict protected
    FAlgorithm: HA;
    function GetCount: Cardinal; virtual; abstract;
    function GetMaxLength: Cardinal; virtual; abstract;
    function GetCheckValueForEmpty: R; virtual; abstract;
    function CreateAlgorithm: HA; virtual; abstract;
    function GetCheckMessage(const Expected, Actual: R): string; virtual; abstract;
    procedure DataStressTest(const Data: TBytes; const MaxLength, Count: Cardinal); virtual;
    procedure CheckResult(const Expected, Actual: R); virtual;
  public
    procedure SetUp; override;
  published
    procedure EmptyDataTest;
    procedure ShortCheckTest;
    procedure CheckTest; virtual;
  {$IF DEFINED(BENCHMARK)}
    procedure StressTest; virtual;
  {$ENDIF ~ BENCHMARK}
//  Utils
    procedure CalculateTest;
  end;

const MaxWord = Word.MaxValue;

implementation

uses
  System.Classes, System.Generics.Defaults,
  System.Diagnostics,
  chHash.Core.Bits;

{ TchAlgorithmTests<C, R, HA> }

procedure TchAlgorithmTests<C, R, HA>.DataStressTest(const Data: TBytes; const MaxLength, Count: Cardinal);
begin
  var Actual := FAlgorithm.Init;
  var Stopwatch := TStopwatch.StartNew;
  for var I := 1 to Count do
  begin
    FAlgorithm.Calculate(Actual, Data[0], MaxLength);
  end;
  Stopwatch.Stop;
  const S = Stopwatch.Elapsed.TotalSeconds;
  if S = 0 then Status(Format('%s: Speed         = 0s, %.3f MB/s', [FAlgorithm.ToString, MaxLength/1 * Count]))
  else Status(Format('%s: Speed         = %.3fs, %.3f MB/s', [FAlgorithm.ToString, S, (MaxLength/(1024 * 1024)/S) * Count]));
end;

procedure TchAlgorithmTests<C, R, HA>.CheckResult(const Expected, Actual: R);
begin
  CheckTrue(TEqualityComparer<R>.Default.Equals(Expected, Actual), GetCheckMessage(Expected, Actual));
end;

procedure TchAlgorithmTests<C, R, HA>.SetUp;
begin
  FAlgorithm := CreateAlgorithm;
end;

procedure TchAlgorithmTests<C, R, HA>.EmptyDataTest;
begin
  const Expected = GetCheckValueForEmpty;

  var Actual := FAlgorithm.Init;
  FAlgorithm.Calculate(Actual, nil, 9);
  CheckResult(Expected, FAlgorithm.Final(Actual));

  Actual := FAlgorithm.Init;
  FAlgorithm.Calculate(Actual, FTestString[1], 0);
  CheckResult(Expected, FAlgorithm.Final(Actual));
end;

procedure TchAlgorithmTests<C, R, HA>.ShortCheckTest;
begin
  const TestBytes = ToBytes(FTestString[1], 9);
  CheckResult(FAlgorithm.Check, FAlgorithm.Calculate(TestBytes));
end;

procedure TchAlgorithmTests<C, R, HA>.CheckTest;
begin
  var Actual := FAlgorithm.Init;
  FAlgorithm.Calculate(Actual, FTestString[1], 9);
  CheckResult(FAlgorithm.Check, FAlgorithm.Final(Actual));
end;

{$IF DEFINED(BENCHMARK)}
procedure TchAlgorithmTests<C, R, HA>.StressTest;
begin
  const MaxLength = GetMaxLength;
  var Data: TBytes;
  SetLength(Data, MaxLength);
  Randomize;
  for var I := 0 to MaxLength - 1 do
  begin
    Data[I] := Random(256);
  end;

  const Count = GetCount;
  const TestSize = (MaxLength/(1024 * 1024 * 1024)) * Count;
  Status(Format('Test size = %.3f GB', [TestSize]));

  DataStressTest(Data, MaxLength, Count);

  SetLength(Data, 0);
end;
{$ENDIF ~ BENCHMARK}

procedure TchAlgorithmTests<C, R, HA>.CalculateTest;
const
  Count = {$IF DEFINED(BENCHMARK)}16{$ELSE}1{$ENDIF};
  Koef = {$IF DEFINED(BENCHMARK)}1023{$ELSE}1{$ENDIF};

begin
  Randomize;
  const Tail = Random(MaxWord);
  const DataSize = 64 * 1024 * Koef + Tail;
  var Data: TBytes;
  SetLength(Data, DataSize);
  for var I := 0 to DataSize - 1 do
  begin
    Data[I] := Random(256);
  end;

  var Expected := FAlgorithm.Init;
  FAlgorithm.Calculate(Expected, Data, DataSize);

  var DataStream := TMemoryStream.Create;
  DataStream.Write(Data, DataSize);
  SetLength(Data, 0);

  var Actual: R;
  var Stopwatch := TStopwatch.StartNew;
  for var J := 1 to Count do
  begin
    Actual := TchUtils.Calculate<C, R>(DataStream, FAlgorithm);
  end;
  Stopwatch.Stop;
{$IF DEFINED(BENCHMARK)}
  const TestSize = (DataSize/(1024 * 1024 * 1024)) * Count;
  const S = Stopwatch.Elapsed.TotalSeconds;
  Status(Format('Test size = %.3f GB', [TestSize]));
  if S = 0 then Status(Format('%s: Speed         = 0s, %.3f MB/s', [FAlgorithm.ToString, DataSize/1 * Count]))
  else Status(Format('%s: Speed         = %.3fs, %.3f MB/s', [FAlgorithm.ToString, S, (DataSize/(1024 * 1024)/S) * Count]));
{$ENDIF ~ BENCHMARK}
  FreeAndNil(DataStream);
  CheckResult(FAlgorithm.Final(Expected), Actual);
end;

end.

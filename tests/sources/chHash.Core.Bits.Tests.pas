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

unit chHash.Core.Bits.Tests;

{$INCLUDE CryptoHash.Tests.inc}

interface

uses
  System.SysUtils,
  TestFramework;

type

{ TBitsTests<Bits> }

  TBitsTests<Bits> = class abstract(TTestCase)
  strict private type
    TStressTestCallback = reference to function(const ConvertCount: Cardinal): Bits;
  strict protected
    FValue: Bits;
    FBytePerConvert: Byte;
    class function IfThenElse<T>(const Condition: Boolean; const ThenValue, ElseValue: T): T; inline; static;
    function BoolToBits(const Value: Boolean): Bits; inline;
    function GetValue: Bits; virtual; abstract;
    function ByteToBits(const Value: Byte): Bits; virtual; abstract;
    function BitsToHex(const Value: Bits): string; virtual; abstract;
    function GetExpectedForReverseBits: Bits; virtual; abstract;
    function GetReverseBits: Bits; virtual; abstract;
    function GetExpectedForReverseBytes: Bits; virtual; abstract;
    function GetReverseBytes: Bits; virtual; abstract;
    function GetExpectedForTestBit: Boolean; virtual;
    function GetTestBit: Boolean; virtual; abstract;
    function GetExpectedForBytes: TBytes; virtual; abstract;
    function GetBytes: TBytes; virtual; abstract;
    procedure StressTest(const Expected: Bits; const Callback: TStressTestCallback);
    procedure CheckResult(const Expected, Actual: Bits); virtual;
  public
    procedure SetUp; override;
  published
    procedure ReverseBitsTest; virtual;
    procedure ReverseBytesTest; virtual;
    procedure TestBitTest; virtual;
    procedure ToBytesTest; virtual;
  end;

implementation

uses
  System.Generics.Defaults,
  System.Diagnostics;

{ TBitsTests<Bits> }

class function TBitsTests<Bits>.IfThenElse<T>(const Condition: Boolean; const ThenValue, ElseValue: T): T;
begin
  if Condition then Exit(ThenValue);
  Result := ElseValue;
end;

function TBitsTests<Bits>.BoolToBits(const Value: Boolean): Bits;
begin
  Result := IfThenElse<Bits>(Value, ByteToBits(1), ByteToBits(0));
end;

function TBitsTests<Bits>.GetExpectedForTestBit: Boolean;
begin
  Result := True;
end;

procedure TBitsTests<Bits>.StressTest(const Expected: Bits; const Callback: TStressTestCallback);
begin
  const ConvertCount = 536870911; // 536 870 911
  const Stopwatch = TStopwatch.StartNew;
  const Actual = Callback(ConvertCount);
  Stopwatch.Stop;
  CheckResult(Expected, Actual);
  const Size: UInt64 = FBytePerConvert * ConvertCount;
  const S = Stopwatch.Elapsed.TotalSeconds;
  if S = 0 then Status(Format('%s: Test size = %.3f GB, Speed = 0s, %.3f MB/s', [Self.ClassName, Size/(1024 * 1024 * 1024), Size/1]))
  else Status(Format('%s: Test size = %.3f GB, Speed = %.3fs, %.3f MB/s', [Self.ClassName, Size/(1024 * 1024 * 1024), S, (Size/(1024 * 1024))/S]));
end;

procedure TBitsTests<Bits>.CheckResult(const Expected, Actual: Bits);
begin
  CheckTrue(
    TEqualityComparer<Bits>.Default.Equals(Expected, Actual),
    Format('Expected = $%s, Actual = $%s', [BitsToHex(Expected), BitsToHex(Actual)])
  );
end;

procedure TBitsTests<Bits>.SetUp;
begin
  FValue := GetValue;
  FBytePerConvert := SizeOf(FValue);
end;

procedure TBitsTests<Bits>.ReverseBitsTest;
begin
{$IF DEFINED(BENCHMARK)}
  StressTest(
    GetExpectedForReverseBits,
    function(const ConvertCount: Cardinal): Bits
    begin
      Result := ByteToBits($0);
      for var I := 1 to ConvertCount do
      begin
        Result := GetReverseBits;
      end;
    end
  );
{$ELSE ~ NOT BENCHMARK}
  const Expected = GetExpectedForReverseBits;
  const Actual = GetReverseBits;
  CheckResult(Expected, Actual);
{$ENDIF ~ BENCHMARK}
end;

procedure TBitsTests<Bits>.ReverseBytesTest;
begin
{$IF DEFINED(BENCHMARK)}
  StressTest(
    GetExpectedForReverseBytes,
    function(const ConvertCount: Cardinal): Bits
    begin
      Result := ByteToBits($0);
      for var I := 1 to ConvertCount do
      begin
        Result := GetReverseBytes;
      end;
    end
  );
{$ELSE ~ NOT BENCHMARK}
  const Expected = GetExpectedForReverseBytes;
  const Actual = GetReverseBytes;
  CheckResult(Expected, Actual);
{$ENDIF ~ BENCHMARK}
end;

procedure TBitsTests<Bits>.TestBitTest;
begin
{$IF DEFINED(BENCHMARK)}
  StressTest(
    BoolToBits(GetExpectedForTestBit),
    function(const ConvertCount: Cardinal): Bits
    begin
      var Actual := False;
      for var I := 1 to ConvertCount do
      begin
        Actual := GetTestBit;
      end;
      Result := BoolToBits(Actual);
    end
  );
{$ELSE ~ NOT BENCHMARK}
  const Expected = BoolToBits(GetExpectedForTestBit);
  const Actual = BoolToBits(GetTestBit);
  CheckResult(Expected, Actual);
{$ENDIF ~ BENCHMARK}
end;

procedure TBitsTests<Bits>.ToBytesTest;
begin
  const Expected = GetExpectedForBytes;
  const Actual = GetBytes;
  CheckTrue(TEqualityComparer<TBytes>.Default.Equals(Expected, Actual));
end;

end.

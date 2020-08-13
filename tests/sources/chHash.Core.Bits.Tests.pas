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

{$INCLUDE CryptoHash.inc}

interface

uses
  TestFramework;

type

{ TBitsTests<Bits> }

  TBitsTests<Bits> = class abstract(TTestCase)
  strict private type
    TTestCallbask = reference to procedure(const ConvertCount: Cardinal);
  strict protected
    FValue: Bits;
    FBytePerConvert: Byte;
    procedure Test(const TestCallback: TTestCallbask);
  public
    procedure SetUp; override; abstract;
  published
    procedure ReverseBitsTest; virtual; abstract;
    procedure ReverseBytesTest; virtual; abstract;
    procedure TestBitTest; virtual; abstract;
    procedure ToBytesTest; virtual; abstract;
    procedure HelperReverseBitsTest; virtual; abstract;
    procedure HelperReverseBytesTest; virtual; abstract;
    procedure HelperTestBitTest; virtual; abstract;
    procedure HelperToBytesTest; virtual; abstract;
  end;

implementation

uses
  System.SysUtils,
  System.Diagnostics;

{ TBitsTests<Bits> }

procedure TBitsTests<Bits>.Test(const TestCallback: TTestCallbask);
begin
  const Stopwatch = TStopwatch.StartNew;
  const ConvertCount = 536870911; // 536 870 911
  TestCallback(ConvertCount);
  Stopwatch.Stop;
  const Size: UInt64 = FBytePerConvert * ConvertCount;
  const S = Stopwatch.Elapsed.TotalSeconds;
  if S = 0 then Status(Format('%s: Test size = %.3f GB, Speed = 0s, %.3f MB/s', [Self.ClassName, Size/(1024 * 1024 * 1024), Size/1]))
  else Status(Format('%s: Test size = %.3f GB, Speed = %.3fs, %.3f MB/s', [Self.ClassName, Size/(1024 * 1024 * 1024), S, (Size/(1024 * 1024))/S]));
end;

end.

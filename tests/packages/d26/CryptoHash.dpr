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

program CryptoHash;

{$INCLUDE CryptoHash.inc}

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF ~CONSOLE_TESTRUNNER}

uses
  DUnitTestRunner,
{$IF NOT DEFINED(USE_JEDI_CORE_LIBRARY)}
  chHash.Core,
{$ENDIF ~ NOT USE_JEDI_CORE_LIBRARY}
  chHash.Core.Bits,
  chHash,
  chHash.Utils,
  chHash.CRC,
  chHash.CRC.CRC32,
  chHash.Core.Bits.Tests,
  chHash.Core.Byte.Tests,
  chHash.Core.ShortInt.Tests,
  chHash.Core.Word.Tests,
  chHash.Core.SmallInt.Tests,
  chHash.Core.Cardinal.Tests,
  chHash.Core.Integer.Tests,
  chHash.Core.UInt64.Tests,
  chHash.Core.Int64.Tests,
  chHash.Core.NativeUInt.Tests,
  chHash.Core.NativeInt.Tests,
  chHash.Core.Pointer.Tests,
  chHash.Tests,
  chHash.CRC.Tests,
  chHash.CRC.CRC32.Tests;

{$R *.RES}

begin
  DUnitTestRunner.RunRegisteredTests;
{$IFDEF CONSOLE_TESTRUNNER}
  Write('Для завершения нажмите "ENTER"');
  Readln;
{$ENDIF ~CONSOLE_TESTRUNNER}
end.

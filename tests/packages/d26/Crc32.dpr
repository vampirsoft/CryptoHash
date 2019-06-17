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

program Crc32;

{$INCLUDE CryptoHash.inc}

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF ~CONSOLE_TESTRUNNER}

uses
  DUnitTestRunner,
{$IF NOT DEFINED(USE_JEDI_CORE_LIBRARY)}
  chHash.Core,
{$ENDIF ~USE_JEDI_CORE_LIBRARY}
  chHash.Core.Bits,
  chHash,
  chHash.Utils,
  chHash.CRC,
  chHash.CRC.CRC32,
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

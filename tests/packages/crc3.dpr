﻿/////////////////////////////////////////////////////////////////////////////////
//*****************************************************************************//
//* Project      : CryptoHash                                                 *//
//* Latest Source: https://github.com/vampirsoft/CryptoHash                   *//
//* Unit Name    : CryptoHash.inc                                             *//
//* Author       : Сергей (LordVampir) Дворников                              *//
//* Copyright 2021 LordVampir (https://github.com/vampirsoft)                 *//
//* Licensed under MIT                                                        *//
//* Реализовано 02                                                            *//
//*****************************************************************************//
/////////////////////////////////////////////////////////////////////////////////

program crc3;

{$INCLUDE CryptoHash.Tests.inc}

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF ~ CONSOLE_TESTRUNNER}

uses
  DUnitTestRunner,
  {$IF NOT DEFINED(USE_JEDI_CORE_LIBRARY)}
  chHash.Core,
  {$ENDIF ~ USE_JEDI_CORE_LIBRARY}
  chHash.Core.Bits,
  chHash,
  chHash.Impl,
  chHash.CRC,
  chHash.CRC.Impl,
  chHash.CRC.CRC8Bits,
  chHash.CRC.CRC3,
  chHash.CRC.CRC3.Impl,
  chHash.CRC.CRC3.Reverse,
  chHash.CRC.CRC3.GSM,
  chHash.CRC.CRC3.ROHC,
  chHash.CRC.CRC3.GSM.Factory,
  chHash.CRC.CRC3.ROHC.Factory,
  chHash.Utils,
  chHash.Tests,
  chHash.CRC.Tests,
  chHash.CRC.CRC3.Tests;

{$R *.RES}

begin
  ReportMemoryLeaksOnShutdown := True;
  DUnitTestRunner.RunRegisteredTests;
{$IFDEF CONSOLE_TESTRUNNER}
  Write('Для завершения нажмите "ENTER"');
  Readln;
{$ENDIF ~ CONSOLE_TESTRUNNER}
end.

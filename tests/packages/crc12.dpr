/////////////////////////////////////////////////////////////////////////////////
//*****************************************************************************//
//* Project      : CryptoHash                                                 *//
//* Latest Source: https://github.com/vampirsoft/CryptoHash                   *//
//* Unit Name    : CryptoHash.inc                                             *//
//* Author       : Сергей (LordVampir) Дворников                              *//
//* Copyright 2021 LordVampir (https://github.com/vampirsoft)                 *//
//* Licensed under MIT                                                        *//
//* Реализовано 04                                                            *//
//*****************************************************************************//
/////////////////////////////////////////////////////////////////////////////////

program crc12;

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
  chHash.CRC.CRC16Bits,
  chHash.CRC.CRC12,
  chHash.CRC.CRC12.Impl,
  chHash.CRC.CRC12.CDMA2000,
  chHash.CRC.CRC12.DECT,
  chHash.CRC.CRC12.GSM,
  chHash.CRC.CRC12.UMTS,
  chHash.CRC.CRC12.CDMA2000.Factory,
  chHash.CRC.CRC12.DECT.Factory,
  chHash.CRC.CRC12.GSM.Factory,
  chHash.CRC.CRC12.UMTS.Factory,
  chHash.Utils,
  chHash.Tests,
  chHash.CRC.Tests,
  chHash.CRC.CRC16Bits.Tests,
  chHash.CRC.CRC12.Tests;

{$R *.RES}

begin
  ReportMemoryLeaksOnShutdown := True;
  DUnitTestRunner.RunRegisteredTests;
{$IFDEF CONSOLE_TESTRUNNER}
  Write('Для завершения нажмите "ENTER"');
  Readln;
{$ENDIF ~ CONSOLE_TESTRUNNER}
end.

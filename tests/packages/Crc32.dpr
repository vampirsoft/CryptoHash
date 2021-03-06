﻿/////////////////////////////////////////////////////////////////////////////////
//*****************************************************************************//
//* Project      : CryptoHash                                                 *//
//* Latest Source: https://github.com/vampirsoft/CryptoHash                   *//
//* Unit Name    : CryptoHash.inc                                             *//
//* Author       : Сергей (LordVampir) Дворников                              *//
//* Copyright 2021 LordVampir (https://github.com/vampirsoft)                 *//
//* Licensed under MIT                                                        *//
//* Реализовано 11                                                            *//
//*****************************************************************************//
/////////////////////////////////////////////////////////////////////////////////

program crc32;

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
  chHash.CRC.CRC32Bits,
  chHash.CRC.CRC32,
  chHash.CRC.CRC32.Impl,
  chHash.CRC.CRC32.PKZIP,
  chHash.CRC.CRC32.BZIP2,
  chHash.CRC.CRC32.ISCSI,
  chHash.CRC.CRC32.BASE91D,
  chHash.CRC.CRC32.MPEG2,
  chHash.CRC.CRC32.CKSUM,
  chHash.CRC.CRC32.AIXM,
  chHash.CRC.CRC32.JAMCRC,
  chHash.CRC.CRC32.XFER,
  chHash.CRC.CRC32.AUTOSAR,
  chHash.CRC.CRC32.CDROMEDC,
  chHash.CRC.CRC32.PKZIP.Factory,
  chHash.CRC.CRC32.BZIP2.Factory,
  chHash.CRC.CRC32.ISCSI.Factory,
  chHash.CRC.CRC32.BASE91D.Factory,
  chHash.CRC.CRC32.MPEG2.Factory,
  chHash.CRC.CRC32.CKSUM.Factory,
  chHash.CRC.CRC32.AIXM.Factory,
  chHash.CRC.CRC32.JAMCRC.Factory,
  chHash.CRC.CRC32.XFER.Factory,
  chHash.CRC.CRC32.AUTOSAR.Factory,
  chHash.CRC.CRC32.CDROMEDC.Factory,
  chHash.Utils,
  chHash.Tests,
  chHash.CRC.Tests,
  chHash.CRC.CRC32Bits.Tests,
  chHash.CRC.CRC32.Tests;

{$R *.RES}

begin
  ReportMemoryLeaksOnShutdown := True;
  DUnitTestRunner.RunRegisteredTests;
{$IFDEF CONSOLE_TESTRUNNER}
  Write('Для завершения нажмите "ENTER"');
  Readln;
{$ENDIF ~ CONSOLE_TESTRUNNER}
end.

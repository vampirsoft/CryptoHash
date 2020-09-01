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

{$INCLUDE CryptoHash.Tests.inc}

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF ~ CONSOLE_TESTRUNNER}

uses
  DUnitTestRunner,
// core units
  {$IF NOT DEFINED(USE_JEDI_CORE_LIBRARY)}
  chHash.Core,
  {$ENDIF ~ NOT USE_JEDI_CORE_LIBRARY}
  chHash.Core.Bits,
// base units
  chHash,
  chHash.Impl,
// crc units
  chHash.CRC,
  chHash.CRC.Impl,
// crc-8 units
  chHash.CRC.CRC8,
  chHash.CRC.CRC8.Impl,
  chHash.CRC.CRC8.AUTOSAR,
  chHash.CRC.CRC8.BLUETOOTH,
  chHash.CRC.CRC8.CDMA2000,
  chHash.CRC.CRC8.DARC,
  chHash.CRC.CRC8.DVBS2,
  chHash.CRC.CRC8.GSMA,
  chHash.CRC.CRC8.GSMB,
  chHash.CRC.CRC8.I4321,
  chHash.CRC.CRC8.ICODE,
  chHash.CRC.CRC8.LTE,
  chHash.CRC.CRC8.MAXIMDOW,
  chHash.CRC.CRC8.MIFAREMAD,
  chHash.CRC.CRC8.NRSC5,
  chHash.CRC.CRC8.OPENSAFETY,
  chHash.CRC.CRC8.ROHC,
  chHash.CRC.CRC8.SAEJ1850,
  chHash.CRC.CRC8.SMBUS,
  chHash.CRC.CRC8.TECH3250,
  chHash.CRC.CRC8.WCDMA,
  chHash.CRC.CRC8.AUTOSAR.Factory,
  chHash.CRC.CRC8.BLUETOOTH.Factory,
  chHash.CRC.CRC8.CDMA2000.Factory,
  chHash.CRC.CRC8.DARC.Factory,
  chHash.CRC.CRC8.DVBS2.Factory,
  chHash.CRC.CRC8.GSMA.Factory,
  chHash.CRC.CRC8.GSMB.Factory,
  chHash.CRC.CRC8.I4321.Factory,
  chHash.CRC.CRC8.ICODE.Factory,
  chHash.CRC.CRC8.LTE.Factory,
  chHash.CRC.CRC8.MAXIMDOW.Factory,
  chHash.CRC.CRC8.MIFAREMAD.Factory,
  chHash.CRC.CRC8.NRSC5.Factory,
  chHash.CRC.CRC8.OPENSAFETY.Factory,
  chHash.CRC.CRC8.ROHC.Factory,
  chHash.CRC.CRC8.SAEJ1850.Factory,
  chHash.CRC.CRC8.SMBUS.Factory,
  chHash.CRC.CRC8.TECH3250.Factory,
  chHash.CRC.CRC8.WCDMA.Factory,
// crc-32 units
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
// unitls units
  chHash.Utils,
// tests units
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
  chHash.CRC.CRC8.Tests,
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

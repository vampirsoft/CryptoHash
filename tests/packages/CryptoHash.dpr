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
  chHash.CRC.CRC16Bits,
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
// crc-12 units
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
// crc-16 units
  chHash.CRC.CRC16,
  chHash.CRC.CRC16.Impl,
  chHash.CRC.CRC16.Reverse,
  chHash.CRC.CRC16.ARC,
  chHash.CRC.CRC16.CDMA2000,
  chHash.CRC.CRC16.CMS,
  chHash.CRC.CRC16.DDS110,
  chHash.CRC.CRC16.DECTR,
  chHash.CRC.CRC16.DECTX,
  chHash.CRC.CRC16.DNP,
  chHash.CRC.CRC16.EN13757,
  chHash.CRC.CRC16.GENIBUS,
  chHash.CRC.CRC16.GSM,
  chHash.CRC.CRC16.IBM3740,
  chHash.CRC.CRC16.IBMSDLC,
  chHash.CRC.CRC16.ISOIEC144433A,
  chHash.CRC.CRC16.KERMIT,
  chHash.CRC.CRC16.LJ1200,
  chHash.CRC.CRC16.MAXIMDOW,
  chHash.CRC.CRC16.MCRF4XX,
  chHash.CRC.CRC16.MODBUS,
  chHash.CRC.CRC16.NRSC5,
  chHash.CRC.CRC16.OPENSAFETYA,
  chHash.CRC.CRC16.OPENSAFETYB,
  chHash.CRC.CRC16.PROFIBUS,
  chHash.CRC.CRC16.RIELLO,
  chHash.CRC.CRC16.SPIFUJITSU,
  chHash.CRC.CRC16.T10DIF,
  chHash.CRC.CRC16.TELEDISK,
  chHash.CRC.CRC16.TMS37157,
  chHash.CRC.CRC16.UMTS,
  chHash.CRC.CRC16.USB,
  chHash.CRC.CRC16.XMODEM,
  chHash.CRC.CRC16.ARC.Factory,
  chHash.CRC.CRC16.CDMA2000.Factory,
  chHash.CRC.CRC16.CMS.Factory,
  chHash.CRC.CRC16.DDS110.Factory,
  chHash.CRC.CRC16.DECTR.Factory,
  chHash.CRC.CRC16.DECTX.Factory,
  chHash.CRC.CRC16.DNP.Factory,
  chHash.CRC.CRC16.EN13757.Factory,
  chHash.CRC.CRC16.GENIBUS.Factory,
  chHash.CRC.CRC16.GSM.Factory,
  chHash.CRC.CRC16.IBM3740.Factory,
  chHash.CRC.CRC16.IBMSDLC.Factory,
  chHash.CRC.CRC16.ISOIEC144433A.Factory,
  chHash.CRC.CRC16.KERMIT.Factory,
  chHash.CRC.CRC16.LJ1200.Factory,
  chHash.CRC.CRC16.MAXIMDOW.Factory,
  chHash.CRC.CRC16.MCRF4XX.Factory,
  chHash.CRC.CRC16.MODBUS.Factory,
  chHash.CRC.CRC16.NRSC5.Factory,
  chHash.CRC.CRC16.OPENSAFETYA.Factory,
  chHash.CRC.CRC16.OPENSAFETYB.Factory,
  chHash.CRC.CRC16.PROFIBUS.Factory,
  chHash.CRC.CRC16.RIELLO.Factory,
  chHash.CRC.CRC16.SPIFUJITSU.Factory,
  chHash.CRC.CRC16.T10DIF.Factory,
  chHash.CRC.CRC16.TELEDISK.Factory,
  chHash.CRC.CRC16.TMS37157.Factory,
  chHash.CRC.CRC16.UMTS.Factory,
  chHash.CRC.CRC16.USB.Factory,
  chHash.CRC.CRC16.XMODEM.Factory,
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
  chHash.CRC.CRC12.Tests,
  chHash.CRC.CRC16.Tests,
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

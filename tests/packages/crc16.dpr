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

program crc16;

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
  chHash.Utils,
  chHash.Tests,
  chHash.CRC.Tests,
  chHash.CRC.CRC16.Tests;

{$R *.RES}

begin
  ReportMemoryLeaksOnShutdown := True;
  DUnitTestRunner.RunRegisteredTests;
{$IFDEF CONSOLE_TESTRUNNER}
  Write('Для завершения нажмите "ENTER"');
  Readln;
{$ENDIF ~ CONSOLE_TESTRUNNER}
end.

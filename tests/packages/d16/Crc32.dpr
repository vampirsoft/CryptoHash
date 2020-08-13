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
  Forms,
  TestFramework,
  GUITestRunner,
  TextTestRunner,
{$IF NOT DEFINED(USE_JEDY_CORE_LIBRARY)}
  chHash.Core in '..\..\..\sources\chHash.Core.pas',
{$IFEND ~USE_JEDY_CORE_LIBRARY}
  chHash.Core.Bits in '..\..\..\sources\chHash.Core.Bits.pas',
  chHash in '..\..\..\sources\chHash.pas',
  chHash.Utils in '..\..\..\sources\chHash.Utils.pas',
  chHash.CRC in '..\..\..\sources\chHash.CRC.pas',
  chHash.CRC.CRC32 in '..\..\..\sources\chHash.CRC.CRC32.pas',
  chHash.Tests in '..\..\sources\chHash.Tests.pas',
  chHash.CRC.Tests in '..\..\sources\chHash.CRC.Tests.pas',
  chHash.CRC.CRC32.Tests in '..\..\sources\chHash.CRC.CRC32.Tests.pas';

{$R *.RES}

begin
  Application.Initialize;
  if IsConsole then
    TextTestRunner.RunRegisteredTests
  else
    GUITestRunner.RunRegisteredTests;
{$IFDEF CONSOLE_TESTRUNNER}
  Write('Для завершения нажмите "ENTER"');
  Readln;
{$ENDIF ~CONSOLE_TESTRUNNER}
end.

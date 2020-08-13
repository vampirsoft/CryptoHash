program CryptoHash;
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

{$INCLUDE CryptoHash.inc}

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  DUnitTestRunner,
{$IF NOT DEFINED(USE_JEDI_CORE_LIBRARY)}
  chHash.Core in '..\..\..\sources\chHash.Core.pas',
{$IFEND ~ NOT USE_JEDI_CORE_LIBRARY}
  chHash.Core.Bits in '..\..\..\sources\chHash.Core.Bits.pas',
  chHash in '..\..\..\sources\chHash.pas',
  chHash.Utils in '..\..\..\sources\chHash.Utils.pas',
  chHash.CRC in '..\..\..\sources\chHash.CRC.pas',
  chHash.CRC.CRC32 in '..\..\..\sources\chHash.CRC.CRC32.pas',
  chHash.Core.Bits.Tests in '..\..\sources\chHash.Core.Bits.Tests.pas',
  chHash.Core.Byte.Tests in '..\..\sources\chHash.Core.Byte.Tests.pas',
  chHash.Core.ShortInt.Tests in '..\..\sources\chHash.Core.ShortInt.Tests.pas',
  chHash.Core.Word.Tests in '..\..\sources\chHash.Core.Word.Tests.pas',
  chHash.Core.SmallInt.Tests in '..\..\sources\chHash.Core.SmallInt.Tests.pas',
  chHash.Core.Cardinal.Tests in '..\..\sources\chHash.Core.Cardinal.Tests.pas',
  chHash.Core.Integer.Tests in '..\..\sources\chHash.Core.Integer.Tests.pas',
  chHash.Core.UInt64.Tests in '..\..\sources\chHash.Core.UInt64.Tests.pas',
  chHash.Core.Int64.Tests in '..\..\sources\chHash.Core.Int64.Tests.pas',
  chHash.Core.NativeUInt.Tests in '..\..\sources\chHash.Core.NativeUInt.Tests.pas',
  chHash.Core.NativeInt.Tests in '..\..\sources\chHash.Core.NativeInt.Tests.pas',
  chHash.Core.Pointer.Tests in '..\..\sources\chHash.Core.Pointer.Tests.pas',
  chHash.Tests in '..\..\sources\chHash.Tests.pas',
  chHash.CRC.Tests in '..\..\sources\chHash.CRC.Tests.pas',
  chHash.CRC.CRC32.Tests in '..\..\sources\chHash.CRC.CRC32.Tests.pas';

{$R *.RES}

begin
  DUnitTestRunner.RunRegisteredTests;
{$IFDEF CONSOLE_TESTRUNNER}
  Write('Для завершения нажмите "ENTER"');
  Readln;
{$ENDIF ~CONSOLE_TESTRUNNER}
end.

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

unit chHash.CRC.CRC32.Tests;

{$INCLUDE CryptoHash.Tests.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC32,
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC.CRC32.Impl,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.Tests;

type
  TCrc32Algorithm = {$IF DEFINED(SUPPORTS_INTERFACES)}IchCrc32{$ELSE}TchCrc32{$ENDIF};

{ TchCrc32Tests }

  TchCrc32Tests = class abstract(TchCrcWithMultiTableTests<Cardinal, TCrc32Algorithm>)
  end;

{ TchCrc32NormalTests }

  TchCrc32NormalTests = class abstract(TchCrc32Tests)
  strict protected
    procedure ControlCalculate(var Current: Cardinal; const Data; const Length: Cardinal); override;
  end;

{ TchCrc32ReverseTests }

  TchCrc32ReverseTests = class abstract(TchCrc32Tests)
  strict protected
    procedure ControlCalculate(var Current: Cardinal; const Data; const Length: Cardinal); override;
  end;

{ TchCrc32CRC32Tests }

  TchCrc32CRC32Tests = class(TchCrc32ReverseTests)
  strict protected
    function CreateAlgorithm: TCrc32Algorithm; override;
  end;

{ TchCrc32BZip2Tests }

  TchCrc32BZip2Tests = class(TchCrc32NormalTests)
  strict protected
    function CreateAlgorithm: TCrc32Algorithm; override;
  end;

{ TchCrc32ISCSITests }

  TchCrc32ISCSITests = class(TchCrc32ReverseTests)
  strict protected
    function CreateAlgorithm: TCrc32Algorithm; override;
  end;

{ TchCrc32BASE91DTests }

  TchCrc32BASE91DTests = class(TchCrc32ReverseTests)
  strict protected
    function CreateAlgorithm: TCrc32Algorithm; override;
  end;

{ TchCrc32MPEG2Tests }

  TchCrc32MPEG2Tests = class(TchCrc32NormalTests)
  strict protected
    function CreateAlgorithm: TCrc32Algorithm; override;
  end;

{ TchCrc32CKSUMTests }

  TchCrc32CKSUMTests = class(TchCrc32NormalTests)
  strict protected
    function CreateAlgorithm: TCrc32Algorithm; override;
  end;

{ TchCrc32AIXMTests }

  TchCrc32AIXMTests = class(TchCrc32NormalTests)
  strict protected
    function CreateAlgorithm: TCrc32Algorithm; override;
  end;

{ TchCrc32JAMCRCTests }

  TchCrc32JAMCRCTests = class(TchCrc32ReverseTests)
  strict protected
    function CreateAlgorithm: TCrc32Algorithm; override;
  end;

{ TchCrc32XFERTests }

  TchCrc32XFERTests = class(TchCrc32NormalTests)
  strict protected
    function CreateAlgorithm: TCrc32Algorithm; override;
  end;

{ TchCrc32AUTOSARTests }

  TchCrc32AUTOSARTests = class(TchCrc32ReverseTests)
  strict protected
    function CreateAlgorithm: TCrc32Algorithm; override;
  end;

{ TchCrc32CDROMEDCTests }

  TchCrc32CDROMEDCTests = class(TchCrc32ReverseTests)
  strict protected
    function CreateAlgorithm: TCrc32Algorithm; override;
  end;

implementation

uses
{$IF DEFINED(USE_JEDI_CORE_LIBRARY)}
  JclLogic,
{$ELSE ~ NOT USE_JEDI_CORE_LIBRARY}
  chHash.Core.Bits,
{$ENDIF ~ USE_JEDI_CORE_LIBRARY}
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
  TestFramework;

{ TchCrc32NormalTests }

procedure TchCrc32NormalTests.ControlCalculate(var Current: Cardinal; const Data; const Length: Cardinal);
begin
  if Length = 0 then Exit;

  var L := Length;
  var PData: PByte := @Data;
  while L > 0 do
  begin
    Current := (Current shl BitsPerByte) xor FCrcTable[Byte(PData^ xor (Current shr (BitsPerByte * 3)))];
    Inc(PData);
    Dec(L);
  end;
end;

{ TchCrc32ReverseTests }

procedure TchCrc32ReverseTests.ControlCalculate(var Current: Cardinal; const Data; const Length: Cardinal);
begin
  if Length = 0 then Exit;

  var L := Length;
  var PData: PByte := @Data;
  while L > 0 do
  begin
    Current := (Current shr BitsPerByte) xor FCrcTable[Byte(PData^ xor Current)];
    Inc(PData);
    Dec(L);
  end;
end;

{ TchCrc32CRC32Tests }

function TchCrc32CRC32Tests.CreateAlgorithm: TCrc32Algorithm;
begin
  Result := TchCrc32.Instance;
end;

{ TchCrc32BZip2Tests }

function TchCrc32BZip2Tests.CreateAlgorithm: TCrc32Algorithm;
begin
  Result := TchCrc32BZIP2.Instance;
end;

{ TchCrc32ISCSITests }

function TchCrc32ISCSITests.CreateAlgorithm: TCrc32Algorithm;
begin
  Result := TchCrc32ISCSI.Instance;
end;

{ TchCrc32BASE91DTests }

function TchCrc32BASE91DTests.CreateAlgorithm: TCrc32Algorithm;
begin
  Result := TchCrc32BASE91D.Instance;
end;

{ TchCrc32MPEG2Tests }

function TchCrc32MPEG2Tests.CreateAlgorithm: TCrc32Algorithm;
begin
  Result := TchCrc32MPEG2.Instance;
end;

{ TchCrc32CKSUMTests }

function TchCrc32CKSUMTests.CreateAlgorithm: TCrc32Algorithm;
begin
  Result := TchCrc32CKSUM.Instance;
end;

{ TchCrc32AIXMTests }

function TchCrc32AIXMTests.CreateAlgorithm: TCrc32Algorithm;
begin
  Result := TchCrc32AIXM.Instance;
end;

{ TchCrc32JAMCRCTests }

function TchCrc32JAMCRCTests.CreateAlgorithm: TCrc32Algorithm;
begin
  Result := TchCrc32JAMCRC.Instance;
end;

{ TchCrc32XFERTests }

function TchCrc32XFERTests.CreateAlgorithm: TCrc32Algorithm;
begin
  Result := TchCrc32XFER.Instance;
end;

{ TchCrc32AUTOSARTests }

function TchCrc32AUTOSARTests.CreateAlgorithm: TCrc32Algorithm;
begin
  Result := TchCrc32AUTOSAR.Instance;
end;

{ TchCrc32CDROMEDCTests }

function TchCrc32CDROMEDCTests.CreateAlgorithm: TCrc32Algorithm;
begin
  Result := TchCrc32CDROMEDC.Instance;
end;

initialization
  RegisterTest(TchCrc32CRC32Tests.Suite);
  RegisterTest(TchCrc32BZip2Tests.Suite);
  RegisterTest(TchCrc32ISCSITests.Suite);
  RegisterTest(TchCrc32BASE91DTests.Suite);
  RegisterTest(TchCrc32MPEG2Tests.Suite);
  RegisterTest(TchCrc32CKSUMTests.Suite);
  RegisterTest(TchCrc32AIXMTests.Suite);
  RegisterTest(TchCrc32JAMCRCTests.Suite);
  RegisterTest(TchCrc32XFERTests.Suite);
  RegisterTest(TchCrc32AUTOSARTests.Suite);
  RegisterTest(TchCrc32CDROMEDCTests.Suite);

end.

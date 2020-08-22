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

unit chHash.CRC.CRC32.Tests;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC32,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.CRC32.Impl,
  chHash.CRC.Tests;

type
  TAlgorithm = {$IF DEFINED(SUPPORTS_INTERFACES)}IchCrc32Algorithm{$ELSE}TchCrc32Algorithm{$ENDIF};

{ TchCrc32AlgorithmTests }

  TchCrc32AlgorithmTests = class abstract(TchCrcAlgorithmTests<Cardinal, TAlgorithm>)
  strict protected
    function BitsToHex(const Value: Cardinal): string; override;
    function FinalControlCalculate(const Value: Cardinal): Cardinal; override;
    function GetCount: Cardinal; override;
    function GetMaxLength: Cardinal; override;
  end;

{ TchCrc32NormalAlgorithmTest }

  TchCrc32NormalAlgorithmTests = class abstract(TchCrc32AlgorithmTests)
  strict protected
    procedure ControlCalculate(var Current: Cardinal; const Data; Length: Integer); override;
  end;

{ TchCrc32ReverseAlgorithmTests }

  TchCrc32ReverseAlgorithmTests = class abstract(TchCrc32AlgorithmTests)
  strict protected
    procedure ControlCalculate(var Current: Cardinal; const Data; Length: Integer); override;
  end;

{ TchCrc32CRC32Tests }

  TchCrc32CRC32Tests = class(TchCrc32ReverseAlgorithmTests)
  strict protected
    function CreateAlgorithm: TAlgorithm; override;
  end;

{ TchCrc32BZip2Tests }

  TchCrc32BZip2Tests = class(TchCrc32NormalAlgorithmTests)
  strict protected
    function CreateAlgorithm: TAlgorithm; override;
  end;

{ TchCrc32ISCSITests }

  TchCrc32ISCSITests = class(TchCrc32ReverseAlgorithmTests)
  strict protected
    function CreateAlgorithm: TAlgorithm; override;
  end;

{ TchCrc32BASE91DTests }

  TchCrc32BASE91DTests = class(TchCrc32ReverseAlgorithmTests)
  strict protected
    function CreateAlgorithm: TAlgorithm; override;
  end;

{ TchCrc32MPEG2Tests }

  TchCrc32MPEG2Tests = class(TchCrc32NormalAlgorithmTests)
  strict protected
    function CreateAlgorithm: TAlgorithm; override;
  end;

{ TchCrc32CKSUMTests }

  TchCrc32CKSUMTests = class(TchCrc32NormalAlgorithmTests)
  strict protected
    function CreateAlgorithm: TAlgorithm; override;
  end;

{ TchCrc32AIXMTests }

  TchCrc32AIXMTests = class(TchCrc32NormalAlgorithmTests)
  strict protected
    function CreateAlgorithm: TAlgorithm; override;
  end;

{ TchCrc32JAMCRCTests }

  TchCrc32JAMCRCTests = class(TchCrc32ReverseAlgorithmTests)
  strict protected
    function CreateAlgorithm: TAlgorithm; override;
  end;

{ TchCrc32XFERTests }

  TchCrc32XFERTests = class(TchCrc32NormalAlgorithmTests)
  strict protected
    function CreateAlgorithm: TAlgorithm; override;
  end;

{ TchCrc32AUTOSARTests }

  TchCrc32AUTOSARTests = class(TchCrc32ReverseAlgorithmTests)
  strict protected
    function CreateAlgorithm: TAlgorithm; override;
  end;

implementation

uses
{$IF DEFINED(USE_JEDI_CORE_LIBRARY)}
  JclLogic,
{$ELSE ~ NOT USE_JEDI_CORE_LIBRARY}
  chHash.Core.Bits,
{$ENDIF ~ USE_JEDI_CORE_LIBRARY}
  TestFramework,
  System.SysUtils, System.Generics.Collections;

{ TchCrc32AlgorithmTests }

function TchCrc32AlgorithmTests.BitsToHex(const Value: Cardinal): string;
begin
  Result := IntToHex(Value);
end;

function TchCrc32AlgorithmTests.FinalControlCalculate(const Value: Cardinal): Cardinal;
begin
  Result := Value xor FAlgorithm.XorOut;
end;

function TchCrc32AlgorithmTests.GetCount: Cardinal;
begin
  Result := 1024 * 16;
//  Result := 1 * 1;
//  Result := 1024 * 1;
end;

function TchCrc32AlgorithmTests.GetMaxLength: Cardinal;
begin
  Result := $FFFF;
//  Result := $FFFFFFF;
//  Result := $100000
end;

{ TchCrc32NormalAlgorithmTests }

procedure TchCrc32NormalAlgorithmTests.ControlCalculate(var Current: Cardinal; const Data; Length: Integer);
begin
  if Length <= 0 then Exit;

  var PData: PByte := @Data;
  while Length > 0 do
  begin
    Current := (Current shl BitsPerByte) xor FCrcTable[Byte(Ord(PData^) xor (Current shr (BitsPerByte * 3)))];
    Inc(PData);
    Dec(Length);
  end;
end;

{ TchCrc32ReverseAlgorithmTests }

procedure TchCrc32ReverseAlgorithmTests.ControlCalculate(var Current: Cardinal; const Data; Length: Integer);
begin
  if Length <= 0 then Exit;

  var PData: PByte := @Data;
  while Length > 0 do
  begin
    Current := (Current shr BitsPerByte) xor FCrcTable[Byte(PData^ xor Current)];
    Inc(PData);
    Dec(Length);
  end;
end;

{ TchCrc32CRC32Tests }

function TchCrc32CRC32Tests.CreateAlgorithm: TAlgorithm;
begin
  Result := TchCrc32Algorithm.CRC32;
end;

{ TchCrc32BZip2Tests }

function TchCrc32BZip2Tests.CreateAlgorithm: TAlgorithm;
begin
  Result := TchCrc32Algorithm.BZIP2;
end;

{ TchCrc32ISCSITests }

function TchCrc32ISCSITests.CreateAlgorithm: TAlgorithm;
begin
  Result := TchCrc32Algorithm.ISCSI;
end;

{ TchCrc32BASE91DTests }

function TchCrc32BASE91DTests.CreateAlgorithm: TAlgorithm;
begin
  Result := TchCrc32Algorithm.BASE91D;
end;

{ TchCrc32MPEG2Tests }

function TchCrc32MPEG2Tests.CreateAlgorithm: TAlgorithm;
begin
  Result := TchCrc32Algorithm.MPEG2;
end;

{ TchCrc32CKSUMTests }

function TchCrc32CKSUMTests.CreateAlgorithm: TAlgorithm;
begin
  Result := TchCrc32Algorithm.CKSUM;
end;

{ TchCrc32AIXMTests }

function TchCrc32AIXMTests.CreateAlgorithm: TAlgorithm;
begin
  Result := TchCrc32Algorithm.AIXM;
end;

{ TchCrc32JAMCRCTests }

function TchCrc32JAMCRCTests.CreateAlgorithm: TAlgorithm;
begin
  Result := TchCrc32Algorithm.JAMCRC;
end;

{ TchCrc32XFERTests }

function TchCrc32XFERTests.CreateAlgorithm: TAlgorithm;
begin
  Result := TchCrc32Algorithm.XFER;
end;

{ TchCrc32AUTOSARTests }

function TchCrc32AUTOSARTests.CreateAlgorithm: TAlgorithm;
begin
  Result := TchCrc32Algorithm.AUTOSAR;
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

end.

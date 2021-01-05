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

unit chHash.CRC.CRC6.Tests;

{$INCLUDE CryptoHash.Tests.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC6,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.CRC6.Impl,
  chHash.CRC.Tests;

type
  TCrc6Algorithm = {$IF DEFINED(SUPPORTS_INTERFACES)}IchCrc6{$ELSE}TchCrc6{$ENDIF};

{ TchCrc6Tests }

  TchCrc6Tests = class abstract(TchCrcTests<Byte, TCrc6Algorithm>)
  end;

{ TchCrc6CDMA2000ATests }

  TchCrc6CDMA2000ATests = class(TchCrc6Tests)
  strict protected
    function CreateAlgorithm: TCrc6Algorithm; override;
  end;

{ TchCrc6CDMA2000BTests }

  TchCrc6CDMA2000BTests = class(TchCrc6Tests)
  strict protected
    function CreateAlgorithm: TCrc6Algorithm; override;
  end;

{ TchCrc6DARCTests }

  TchCrc6DARCTests = class(TchCrc6Tests)
  strict protected
    function CreateAlgorithm: TCrc6Algorithm; override;
  end;

{ TchCrc6G704Tests }

  TchCrc6G704Tests = class(TchCrc6Tests)
  strict protected
    function CreateAlgorithm: TCrc6Algorithm; override;
  end;

{ TchCrc6GSMTests }

  TchCrc6GSMTests = class(TchCrc6Tests)
  strict protected
    function CreateAlgorithm: TCrc6Algorithm; override;
  end;

implementation

uses
  chHash.CRC.CRC6.CDMA2000A.Factory,
  chHash.CRC.CRC6.CDMA2000B.Factory,
  chHash.CRC.CRC6.DARC.Factory,
  chHash.CRC.CRC6.G704.Factory,
  chHash.CRC.CRC6.GSM.Factory,
  TestFramework;

{ TchCrc6CDMA2000ATests }

function TchCrc6CDMA2000ATests.CreateAlgorithm: TCrc6Algorithm;
begin
  Result := TchCrc6CDMA2000A.Instance;
end;

{ TchCrc6CDMA2000BTests }

function TchCrc6CDMA2000BTests.CreateAlgorithm: TCrc6Algorithm;
begin
  Result := TchCrc6CDMA2000B.Instance;
end;

{ TchCrc6DARCTests }

function TchCrc6DARCTests.CreateAlgorithm: TCrc6Algorithm;
begin
  Result := TchCrc6DARC.Instance;
end;

{ TchCrc6G704Tests }

function TchCrc6G704Tests.CreateAlgorithm: TCrc6Algorithm;
begin
  Result := TchCrc6G704.Instance;
end;

{ TchCrc6GSMTests }

function TchCrc6GSMTests.CreateAlgorithm: TCrc6Algorithm;
begin
  Result := TchCrc6GSM.Instance;
end;

initialization
  RegisterTest(TchCrc6CDMA2000ATests.Suite);
  RegisterTest(TchCrc6CDMA2000BTests.Suite);
  RegisterTest(TchCrc6DARCTests.Suite);
  RegisterTest(TchCrc6G704Tests.Suite);
  RegisterTest(TchCrc6GSMTests.Suite);

end.

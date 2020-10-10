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

unit chHash.CRC.CRC3.Tests;

{$INCLUDE CryptoHash.Tests.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC3,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.CRC3.Impl,
  chHash.CRC.Tests;

type
  TCrc3Algorithm = {$IF DEFINED(SUPPORTS_INTERFACES)}IchCrc3{$ELSE}TchCrc3{$ENDIF};

{ TchCrc3Tests }

  TchCrc3Tests = class abstract(TchCrcTests<Byte, TCrc3Algorithm>)
  end;

{ TchCrc3GSMTests }

  TchCrc3GSMTests = class(TchCrc3Tests)
  strict protected
    function CreateAlgorithm: TCrc3Algorithm; override;
  end;

{ TchCrc3ROHCTests }

  TchCrc3ROHCTests = class(TchCrc3Tests)
  strict protected
    function CreateAlgorithm: TCrc3Algorithm; override;
  end;

implementation

uses
  chHash.CRC.CRC3.GSM.Factory,
  chHash.CRC.CRC3.ROHC.Factory,
  TestFramework;

{ TchCrc3GSMTests }

function TchCrc3GSMTests.CreateAlgorithm: TCrc3Algorithm;
begin
  Result := TchCrc3GSM.Instance;
end;

{ TchCrc3ROHCTests }

function TchCrc3ROHCTests.CreateAlgorithm: TCrc3Algorithm;
begin
  Result := TchCrc3ROHC.Instance;
end;

initialization
  RegisterTest(TchCrc3GSMTests.Suite);
  RegisterTest(TchCrc3ROHCTests.Suite);

end.

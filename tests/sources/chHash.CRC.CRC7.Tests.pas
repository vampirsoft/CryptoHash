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

unit chHash.CRC.CRC7.Tests;

{$INCLUDE CryptoHash.Tests.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC7,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.CRC7.Impl,
  chHash.CRC.Tests;

type
  TCrc7Algorithm = {$IF DEFINED(SUPPORTS_INTERFACES)}IchCrc7{$ELSE}TchCrc7{$ENDIF};

{ TchCrc7Tests }

  TchCrc7Tests = class abstract(TchCrcTests<Byte, TCrc7Algorithm>)
  end;

{ TchCrc7MMCTests }

  TchCrc7MMCTests = class(TchCrc7Tests)
  strict protected
    function CreateAlgorithm: TCrc7Algorithm; override;
  end;

{ TchCrc7ROHCTests }

  TchCrc7ROHCTests = class(TchCrc7Tests)
  strict protected
    function CreateAlgorithm: TCrc7Algorithm; override;
  end;

{ TchCrc7UMTSTests }

  TchCrc7UMTSTests = class(TchCrc7Tests)
  strict protected
    function CreateAlgorithm: TCrc7Algorithm; override;
  end;

implementation

uses
  chHash.CRC.CRC7.MMC.Factory,
  chHash.CRC.CRC7.ROHC.Factory,
  chHash.CRC.CRC7.UMTS.Factory,
  TestFramework;

{ TchCrc7MMCTests }

function TchCrc7MMCTests.CreateAlgorithm: TCrc7Algorithm;
begin
  Result := TchCrc7MMC.Instance;
end;

{ TchCrc7ROHCTests }

function TchCrc7ROHCTests.CreateAlgorithm: TCrc7Algorithm;
begin
  Result := TchCrc7ROHC.Instance;
end;

{ TchCrc7UMTSTests }

function TchCrc7UMTSTests.CreateAlgorithm: TCrc7Algorithm;
begin
  Result := TchCrc7UMTS.Instance;
end;

initialization
  RegisterTest(TchCrc7MMCTests.Suite);
  RegisterTest(TchCrc7ROHCTests.Suite);
  RegisterTest(TchCrc7UMTSTests.Suite);

end.

/////////////////////////////////////////////////////////////////////////////////
//*****************************************************************************//
//* Project      : CryptoHash                                                 *//
//* Latest Source: https://github.com/vampirsoft/CryptoHash                   *//
//* Unit Name    : CryptoHash.inc                                             *//
//* Author       : Сергей (LordVampir) Дворников                              *//
//* Copyright 2021 LordVampir (https://github.com/vampirsoft)                 *//
//* Licensed under MIT                                                        *//
//*****************************************************************************//
/////////////////////////////////////////////////////////////////////////////////

unit chHash.CRC.CRC14.Tests;

{$INCLUDE CryptoHash.Tests.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC14,
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC.CRC14.Impl,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.CRC16Bits.Tests;

type
  TCrc14Algorithm = {$IF DEFINED(SUPPORTS_INTERFACES)}IchCrc14{$ELSE}TchCrc14{$ENDIF};

{ TchCrc14DARCTests }

  TchCrc14DARCTests = class(TchCrc16BitsReverseTests<TCrc14Algorithm>)
  strict protected
    function CreateAlgorithm: TCrc14Algorithm; override;
  end;

{ TchCrc14GSMTests }

  TchCrc14GSMTests = class(TchCrc16BitsNormalTests<TCrc14Algorithm>)
  strict protected
    function CreateAlgorithm: TCrc14Algorithm; override;
  end;

implementation

uses
  chHash.CRC.CRC14.DARC.Factory,
  chHash.CRC.CRC14.GSM.Factory,
  TestFramework;

{ TchCrc14DARCTests }

function TchCrc14DARCTests.CreateAlgorithm: TCrc14Algorithm;
begin
  Result := TchCrc14DARC.Instance;
end;

{ TchCrc14GSMTests }

function TchCrc14GSMTests.CreateAlgorithm: TCrc14Algorithm;
begin
  Result := TchCrc14GSM.Instance;
end;

initialization
  RegisterTest(TchCrc14DARCTests.Suite);
  RegisterTest(TchCrc14GSMTests.Suite);

end.

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

unit chHash.CRC.CRC15.Tests;

{$INCLUDE CryptoHash.Tests.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC15,
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC.CRC15.Impl,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.CRC16Bits.Tests;

type
  TCrc15Algorithm = {$IF DEFINED(SUPPORTS_INTERFACES)}IchCrc15{$ELSE}TchCrc15{$ENDIF};

{ TchCrc15CANTests }

  TchCrc15CANTests = class(TchCrc16BitsNormalTests<TCrc15Algorithm>)
  strict protected
    function CreateAlgorithm: TCrc15Algorithm; override;
  end;

{ TchCrc15MPT1327Tests }

  TchCrc15MPT1327Tests = class(TchCrc16BitsNormalTests<TCrc15Algorithm>)
  strict protected
    function CreateAlgorithm: TCrc15Algorithm; override;
  end;

implementation

uses
  chHash.CRC.CRC15.CAN.Factory,
  chHash.CRC.CRC15.MPT1327.Factory,
  TestFramework;

{ TchCrc15CANTests }

function TchCrc15CANTests.CreateAlgorithm: TCrc15Algorithm;
begin
  Result := TchCrc15CAN.Instance;
end;

{ TchCrc15MPT1327Tests }

function TchCrc15MPT1327Tests.CreateAlgorithm: TCrc15Algorithm;
begin
  Result := TchCrc15MPT1327.Instance;
end;

initialization
  RegisterTest(TchCrc15CANTests.Suite);
  RegisterTest(TchCrc15MPT1327Tests.Suite);

end.

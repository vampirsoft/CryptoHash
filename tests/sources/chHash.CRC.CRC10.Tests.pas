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

unit chHash.CRC.CRC10.Tests;

{$INCLUDE CryptoHash.Tests.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC10,
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC.CRC10.Impl,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.CRC16Bits.Tests;

type
  TCrc10Algorithm = {$IF DEFINED(SUPPORTS_INTERFACES)}IchCrc10{$ELSE}TchCrc10{$ENDIF};

{ TchCrc10ATMTests }

  TchCrc10ATMTests = class(TchCrc16BitsNormalTests<TCrc10Algorithm>)
  strict protected
    function CreateAlgorithm: TCrc10Algorithm; override;
  end;

{ TchCrc10CDMA2000Tests }

  TchCrc10CDMA2000Tests = class(TchCrc16BitsNormalTests<TCrc10Algorithm>)
  strict protected
    function CreateAlgorithm: TCrc10Algorithm; override;
  end;

{ TchCrc10GSMTests }

  TchCrc10GSMTests = class(TchCrc16BitsNormalTests<TCrc10Algorithm>)
  strict protected
    function CreateAlgorithm: TCrc10Algorithm; override;
  end;

implementation

uses
  chHash.CRC.CRC10.ATM.Factory,
  chHash.CRC.CRC10.CDMA2000.Factory,
  chHash.CRC.CRC10.GSM.Factory,
  TestFramework;

{ TchCrc10ATMTests }

function TchCrc10ATMTests.CreateAlgorithm: TCrc10Algorithm;
begin
  Result := TchCrc10ATM.Instance;
end;

{ TchCrc10CDMA2000Tests }

function TchCrc10CDMA2000Tests.CreateAlgorithm: TCrc10Algorithm;
begin
  Result := TchCrc10CDMA2000.Instance;
end;

{ TchCrc10GSMTests }

function TchCrc10GSMTests.CreateAlgorithm: TCrc10Algorithm;
begin
  Result := TchCrc10GSM.Instance;
end;

initialization
  RegisterTest(TchCrc10ATMTests.Suite);
  RegisterTest(TchCrc10CDMA2000Tests.Suite);
  RegisterTest(TchCrc10GSMTests.Suite);

end.

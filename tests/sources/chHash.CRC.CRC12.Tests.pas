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

unit chHash.CRC.CRC12.Tests;

{$INCLUDE CryptoHash.Tests.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC12,
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC.CRC12.Impl,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.CRC16Bits.Tests;

type
  TCrc12Algorithm = {$IF DEFINED(SUPPORTS_INTERFACES)}IchCrc12{$ELSE}TchCrc12{$ENDIF};

{ TchCrc12CDMA2000Tests }

  TchCrc12CDMA2000Tests = class(TchCrc16BitsNormalTests<TCrc12Algorithm>)
  strict protected
    function CreateAlgorithm: TCrc12Algorithm; override;
  end;

{ TchCrc12DECTTests }

  TchCrc12DECTTests = class(TchCrc16BitsNormalTests<TCrc12Algorithm>)
  strict protected
    function CreateAlgorithm: TCrc12Algorithm; override;
  end;

{ TchCrc12GSMTests }

  TchCrc12GSMTests = class(TchCrc16BitsNormalTests<TCrc12Algorithm>)
  strict protected
    function CreateAlgorithm: TCrc12Algorithm; override;
  end;

{ TchCrc12UMTSTests }

  TchCrc12UMTSTests = class(TchCrc16BitsNormalTests<TCrc12Algorithm>)
  strict protected
    function CreateAlgorithm: TCrc12Algorithm; override;
  end;

implementation

uses
  chHash.CRC.CRC12.CDMA2000.Factory,
  chHash.CRC.CRC12.DECT.Factory,
  chHash.CRC.CRC12.GSM.Factory,
  chHash.CRC.CRC12.UMTS.Factory,
  TestFramework;

{ TchCrc12CDMA2000Tests }

function TchCrc12CDMA2000Tests.CreateAlgorithm: TCrc12Algorithm;
begin
  Result := TchCrc12CDMA2000.Instance;
end;

{ TchCrc12DECTTests }

function TchCrc12DECTTests.CreateAlgorithm: TCrc12Algorithm;
begin
  Result := TchCrc12DECT.Instance;
end;

{ TchCrc12GSMTests }

function TchCrc12GSMTests.CreateAlgorithm: TCrc12Algorithm;
begin
  Result := TchCrc12GSM.Instance;
end;

{ TchCrc12UMTSTests }

function TchCrc12UMTSTests.CreateAlgorithm: TCrc12Algorithm;
begin
  Result := TchCrc12UMTS.Instance;
end;

initialization
  RegisterTest(TchCrc12CDMA2000Tests.Suite);
  RegisterTest(TchCrc12DECTTests.Suite);
  RegisterTest(TchCrc12GSMTests.Suite);
  RegisterTest(TchCrc12UMTSTests.Suite);

end.

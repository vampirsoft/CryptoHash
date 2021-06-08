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

unit chHash.CRC.CRC5.Tests;

{$INCLUDE CryptoHash.Tests.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC5,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.CRC5.Impl,
  chHash.CRC.Tests;

type
  TCrc5Algorithm = {$IF DEFINED(SUPPORTS_INTERFACES)}IchCrc5{$ELSE}TchCrc5{$ENDIF};

{ TchCrc5Tests }

  TchCrc5Tests = class abstract(TchCrcTests<Byte, TCrc5Algorithm>)
  end;

{ TchCrc5EPCC1G2Tests }

  TchCrc5EPCC1G2Tests = class(TchCrc5Tests)
  strict protected
    function CreateAlgorithm: TCrc5Algorithm; override;
  end;

{ TchCrc5G704Tests }

  TchCrc5G704Tests = class(TchCrc5Tests)
  strict protected
    function CreateAlgorithm: TCrc5Algorithm; override;
  end;

{ TchCrc5USBTests }

  TchCrc5USBTests = class(TchCrc5Tests)
  strict protected
    function CreateAlgorithm: TCrc5Algorithm; override;
  end;

implementation

uses
  chHash.CRC.CRC5.EPCC1G2.Factory,
  chHash.CRC.CRC5.G704.Factory,
  chHash.CRC.CRC5.USB.Factory,
  TestFramework;

{ TchCrc5EPCC1G2Tests }

function TchCrc5EPCC1G2Tests.CreateAlgorithm: TCrc5Algorithm;
begin
  Result := TchCrc5EPCC1G2.Instance;
end;

{ TchCrc5G704Tests }

function TchCrc5G704Tests.CreateAlgorithm: TCrc5Algorithm;
begin
  Result := TchCrc5G704.Instance;
end;

{ TchCrc5USBTests }

function TchCrc5USBTests.CreateAlgorithm: TCrc5Algorithm;
begin
  Result := TchCrc5USB.Instance;
end;

initialization
  RegisterTest(TchCrc5EPCC1G2Tests.Suite);
  RegisterTest(TchCrc5G704Tests.Suite);
  RegisterTest(TchCrc5USBTests.Suite);

end.

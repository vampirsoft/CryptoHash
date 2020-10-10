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

unit chHash.CRC.CRC8.Tests;

{$INCLUDE CryptoHash.Tests.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC8,
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC.CRC8.Impl,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.Tests;

type
  TCrc8Algorithm = {$IF DEFINED(SUPPORTS_INTERFACES)}IchCrc8{$ELSE}TchCrc8{$ENDIF};

{ TchCrc8Tests }

  TchCrc8Tests = class abstract(TchCrcWithMultiTableTests<Byte, TCrc8Algorithm>)
  strict protected
    procedure ControlCalculate(var Current: Byte; const Data; const Length: Cardinal); override;
  end;

{ TchCrc8AUTOSARTests }

  TchCrc8AUTOSARTests = class(TchCrc8Tests)
  strict protected
    function CreateAlgorithm: TCrc8Algorithm; override;
  end;

{ TchCrc8BLUETOOTHTests }

  TchCrc8BLUETOOTHTests = class(TchCrc8Tests)
  strict protected
    function CreateAlgorithm: TCrc8Algorithm; override;
  end;

{ TchCrc8CDMA2000Tests }

  TchCrc8CDMA2000Tests = class(TchCrc8Tests)
  strict protected
    function CreateAlgorithm: TCrc8Algorithm; override;
  end;

{ TchCrc8DARCTests }

  TchCrc8DARCTests = class(TchCrc8Tests)
  strict protected
    function CreateAlgorithm: TCrc8Algorithm; override;
  end;

{ TchCrc8DVBS2Tests }

  TchCrc8DVBS2Tests = class(TchCrc8Tests)
  strict protected
    function CreateAlgorithm: TCrc8Algorithm; override;
  end;

{ TchCrc8GSMATests }

  TchCrc8GSMATests = class(TchCrc8Tests)
  strict protected
    function CreateAlgorithm: TCrc8Algorithm; override;
  end;

{ TchCrc8GSMBTests }

  TchCrc8GSMBTests = class(TchCrc8Tests)
  strict protected
    function CreateAlgorithm: TCrc8Algorithm; override;
  end;

{ TchCrc8I4321Tests }

  TchCrc8I4321Tests = class(TchCrc8Tests)
  strict protected
    function CreateAlgorithm: TCrc8Algorithm; override;
  end;

{ TchCrc8ICODETests }

  TchCrc8ICODETests = class(TchCrc8Tests)
  strict protected
    function CreateAlgorithm: TCrc8Algorithm; override;
  end;

{ TchCrc8LTETests }

  TchCrc8LTETests = class(TchCrc8Tests)
  strict protected
    function CreateAlgorithm: TCrc8Algorithm; override;
  end;

{ TchCrc8MAXIMDOWTests }

  TchCrc8MAXIMDOWTests = class(TchCrc8Tests)
  strict protected
    function CreateAlgorithm: TCrc8Algorithm; override;
  end;

{ TchCrc8MIFAREMADTests }

  TchCrc8MIFAREMADTests = class(TchCrc8Tests)
  strict protected
    function CreateAlgorithm: TCrc8Algorithm; override;
  end;

{ TchCrc8NRSC5Tests }

  TchCrc8NRSC5Tests = class(TchCrc8Tests)
  strict protected
    function CreateAlgorithm: TCrc8Algorithm; override;
  end;

{ TchCrc8OPENSAFETYTests }

  TchCrc8OPENSAFETYTests = class(TchCrc8Tests)
  strict protected
    function CreateAlgorithm: TCrc8Algorithm; override;
  end;

{ TchCrc8ROHCTests }

  TchCrc8ROHCTests = class(TchCrc8Tests)
  strict protected
    function CreateAlgorithm: TCrc8Algorithm; override;
  end;

{ TchCrc8SAEJ1850Tests }

  TchCrc8SAEJ1850Tests = class(TchCrc8Tests)
  strict protected
    function CreateAlgorithm: TCrc8Algorithm; override;
  end;

{ TchCrc8SMBUSTests }

  TchCrc8SMBUSTests = class(TchCrc8Tests)
  strict protected
    function CreateAlgorithm: TCrc8Algorithm; override;
  end;

{ TchCrc8TECH3250Tests }

  TchCrc8TECH3250Tests = class(TchCrc8Tests)
  strict protected
    function CreateAlgorithm: TCrc8Algorithm; override;
  end;

{ TchCrc8WCDMATests }

  TchCrc8WCDMATests = class(TchCrc8Tests)
  strict protected
    function CreateAlgorithm: TCrc8Algorithm; override;
  end;

implementation

uses
  chHash.CRC.CRC8.AUTOSAR.Factory,
  chHash.CRC.CRC8.BLUETOOTH.Factory,
  chHash.CRC.CRC8.CDMA2000.Factory,
  chHash.CRC.CRC8.DARC.Factory,
  chHash.CRC.CRC8.DVBS2.Factory,
  chHash.CRC.CRC8.GSMA.Factory,
  chHash.CRC.CRC8.GSMB.Factory,
  chHash.CRC.CRC8.I4321.Factory,
  chHash.CRC.CRC8.ICODE.Factory,
  chHash.CRC.CRC8.LTE.Factory,
  chHash.CRC.CRC8.MAXIMDOW.Factory,
  chHash.CRC.CRC8.MIFAREMAD.Factory,
  chHash.CRC.CRC8.NRSC5.Factory,
  chHash.CRC.CRC8.OPENSAFETY.Factory,
  chHash.CRC.CRC8.ROHC.Factory,
  chHash.CRC.CRC8.SAEJ1850.Factory,
  chHash.CRC.CRC8.SMBUS.Factory,
  chHash.CRC.CRC8.TECH3250.Factory,
  chHash.CRC.CRC8.WCDMA.Factory,
  TestFramework;

{ TchCrc8Tests }

procedure TchCrc8Tests.ControlCalculate(var Current: Byte; const Data; const Length: Cardinal);
begin
  if Length = 0 then Exit;

  var L := Length;
  var PData: PByte := @Data;
  while L > 0 do
  begin
    Current := FCrcTable[Byte(PData^ xor Current)];
    Inc(PData);
    Dec(L);
  end;
end;

{ TchCrc8AUTOSARTests }

function TchCrc8AUTOSARTests.CreateAlgorithm: TCrc8Algorithm;
begin
  Result := TchCrc8AUTOSAR.Instance;
end;

{ TchCrc8BLUETOOTHTests }

function TchCrc8BLUETOOTHTests.CreateAlgorithm: TCrc8Algorithm;
begin
  Result := TchCrc8BLUETOOTH.Instance;
end;

{ TchCrc8CDMA2000Tests }

function TchCrc8CDMA2000Tests.CreateAlgorithm: TCrc8Algorithm;
begin
  Result := TchCrc8CDMA2000.Instance;
end;

{ TchCrc8DARCTests }

function TchCrc8DARCTests.CreateAlgorithm: TCrc8Algorithm;
begin
  Result := TchCrc8DARC.Instance;
end;

{ TchCrc8DVBS2Tests }

function TchCrc8DVBS2Tests.CreateAlgorithm: TCrc8Algorithm;
begin
  Result := TchCrc8DVBS2.Instance;
end;

{ TchCrc8GSMATests }

function TchCrc8GSMATests.CreateAlgorithm: TCrc8Algorithm;
begin
  Result := TchCrc8GSMA.Instance;
end;

{ TchCrc8GSMBTests }

function TchCrc8GSMBTests.CreateAlgorithm: TCrc8Algorithm;
begin
  Result := TchCrc8GSMB.Instance;
end;

{ TchCrc8I4321Tests }

function TchCrc8I4321Tests.CreateAlgorithm: TCrc8Algorithm;
begin
  Result := TchCrc8I4321.Instance;
end;

{ TchCrc8ICODETests }

function TchCrc8ICODETests.CreateAlgorithm: TCrc8Algorithm;
begin
  Result := TchCrc8ICODE.Instance;
end;

{ TchCrc8LTETests }

function TchCrc8LTETests.CreateAlgorithm: TCrc8Algorithm;
begin
  Result := TchCrc8LTE.Instance;
end;

{ TchCrc8MAXIMDOWTests }

function TchCrc8MAXIMDOWTests.CreateAlgorithm: TCrc8Algorithm;
begin
  Result := TchCrc8MAXIMDOW.Instance;
end;

{ TchCrc8MIFAREMADTests }

function TchCrc8MIFAREMADTests.CreateAlgorithm: TCrc8Algorithm;
begin
  Result := TchCrc8MIFAREMAD.Instance;
end;

{ TchCrc8NRSC5Tests }

function TchCrc8NRSC5Tests.CreateAlgorithm: TCrc8Algorithm;
begin
  Result := TchCrc8NRSC5.Instance;
end;

{ TchCrc8OPENSAFETYTests }

function TchCrc8OPENSAFETYTests.CreateAlgorithm: TCrc8Algorithm;
begin
  Result := TchCrc8OPENSAFETY.Instance;
end;

{ TchCrc8ROHCTests }

function TchCrc8ROHCTests.CreateAlgorithm: TCrc8Algorithm;
begin
  Result := TchCrc8ROHC.Instance;
end;

{ TchCrc8SAEJ1850Tests }

function TchCrc8SAEJ1850Tests.CreateAlgorithm: TCrc8Algorithm;
begin
  Result := TchCrc8SAEJ1850.Instance;
end;

{ TchCrc8SMBUSTests }

function TchCrc8SMBUSTests.CreateAlgorithm: TCrc8Algorithm;
begin
  Result := TchCrc8SMBUS.Instance;
end;

{ TchCrc8TECH3250Tests }

function TchCrc8TECH3250Tests.CreateAlgorithm: TCrc8Algorithm;
begin
  Result := TchCrc8TECH3250.Instance;
end;

{ TchCrc8WCDMATests }

function TchCrc8WCDMATests.CreateAlgorithm: TCrc8Algorithm;
begin
  Result := TchCrc8WCDMA.Instance;
end;

initialization
  RegisterTest(TchCrc8AUTOSARTests.Suite);
  RegisterTest(TchCrc8BLUETOOTHTests.Suite);
  RegisterTest(TchCrc8CDMA2000Tests.Suite);
  RegisterTest(TchCrc8DARCTests.Suite);
  RegisterTest(TchCrc8DVBS2Tests.Suite);
  RegisterTest(TchCrc8GSMATests.Suite);
  RegisterTest(TchCrc8GSMBTests.Suite);
  RegisterTest(TchCrc8I4321Tests.Suite);
  RegisterTest(TchCrc8ICODETests.Suite);
  RegisterTest(TchCrc8LTETests.Suite);
  RegisterTest(TchCrc8MAXIMDOWTests.Suite);
  RegisterTest(TchCrc8MIFAREMADTests.Suite);
  RegisterTest(TchCrc8NRSC5Tests.Suite);
  RegisterTest(TchCrc8OPENSAFETYTests.Suite);
  RegisterTest(TchCrc8ROHCTests.Suite);
  RegisterTest(TchCrc8SAEJ1850Tests.Suite);
  RegisterTest(TchCrc8SMBUSTests.Suite);
  RegisterTest(TchCrc8TECH3250Tests.Suite);
  RegisterTest(TchCrc8WCDMATests.Suite);

end.

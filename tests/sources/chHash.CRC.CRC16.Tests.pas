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

unit chHash.CRC.CRC16.Tests;

{$INCLUDE CryptoHash.Tests.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC16,
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC.CRC16.Impl,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.Tests;

type
  TCrc16Algorithm = {$IF DEFINED(SUPPORTS_INTERFACES)}IchCrc16{$ELSE}TchCrc16{$ENDIF};

{ TchCrc16Tests }

  TchCrc16Tests = class abstract(TchCrcWithMultiTableTests<Word, TCrc16Algorithm>)
  end;

{ TchCrc16NormalTests }

  TchCrc16NormalTests = class abstract(TchCrc16Tests)
  strict protected
    procedure ControlCalculate(var Current: Word; const Data; const Length: Cardinal); override;
  end;

{ TchCrc16ReverseTests }

  TchCrc16ReverseTests = class abstract(TchCrc16Tests)
  strict protected
    procedure ControlCalculate(var Current: Word; const Data; const Length: Cardinal); override;
  end;

{ TchCrc16ARCTests }

  TchCrc16ARCTests = class(TchCrc16ReverseTests)
  strict protected
    function CreateAlgorithm: TCrc16Algorithm; override;
  end;

{ TchCrc16CDMA2000Tests }

  TchCrc16CDMA2000Tests = class(TchCrc16NormalTests)
  strict protected
    function CreateAlgorithm: TCrc16Algorithm; override;
  end;

{ TchCrc16CMSTests }

  TchCrc16CMSTests = class(TchCrc16NormalTests)
  strict protected
    function CreateAlgorithm: TCrc16Algorithm; override;
  end;

{ TchCrc16DDS110Tests }

  TchCrc16DDS110Tests = class(TchCrc16NormalTests)
  strict protected
    function CreateAlgorithm: TCrc16Algorithm; override;
  end;

{ TchCrc16DECTRTests }

  TchCrc16DECTRTests = class(TchCrc16NormalTests)
  strict protected
    function CreateAlgorithm: TCrc16Algorithm; override;
  end;

{ TchCrc16DECTXTests }

  TchCrc16DECTXTests = class(TchCrc16NormalTests)
  strict protected
    function CreateAlgorithm: TCrc16Algorithm; override;
  end;

{ TchCrc16DNPTests }

  TchCrc16DNPTests = class(TchCrc16ReverseTests)
  strict protected
    function CreateAlgorithm: TCrc16Algorithm; override;
  end;

{ TchCrc16EN13757Tests }

  TchCrc16EN13757Tests = class(TchCrc16NormalTests)
  strict protected
    function CreateAlgorithm: TCrc16Algorithm; override;
  end;

{ TchCrc16GSMTests }

  TchCrc16GSMTests = class(TchCrc16NormalTests)
  strict protected
    function CreateAlgorithm: TCrc16Algorithm; override;
  end;

{ TchCrc16GENIBUSTests }

  TchCrc16GENIBUSTests = class(TchCrc16NormalTests)
  strict protected
    function CreateAlgorithm: TCrc16Algorithm; override;
  end;

{ TchCrc16IBM3740Tests }

  TchCrc16IBM3740Tests = class(TchCrc16NormalTests)
  strict protected
    function CreateAlgorithm: TCrc16Algorithm; override;
  end;

{ TchCrc16IBMSDLCTests }

  TchCrc16IBMSDLCTests = class(TchCrc16ReverseTests)
  strict protected
    function CreateAlgorithm: TCrc16Algorithm; override;
  end;

{ TchCrc16ISOIEC144433ATests }

  TchCrc16ISOIEC144433ATests = class(TchCrc16ReverseTests)
  strict protected
    function CreateAlgorithm: TCrc16Algorithm; override;
  end;

{ TchCrc16KERMITTests }

  TchCrc16KERMITTests = class(TchCrc16ReverseTests)
  strict protected
    function CreateAlgorithm: TCrc16Algorithm; override;
  end;

{ TchCrc16LJ1200Tests }

  TchCrc16LJ1200Tests = class(TchCrc16NormalTests)
  strict protected
    function CreateAlgorithm: TCrc16Algorithm; override;
  end;

{ TchCrc16MAXIMDOWTests }

  TchCrc16MAXIMDOWTests = class(TchCrc16ReverseTests)
  strict protected
    function CreateAlgorithm: TCrc16Algorithm; override;
  end;

{ TchCrc16MCRF4XXTests }

  TchCrc16MCRF4XXTests = class(TchCrc16ReverseTests)
  strict protected
    function CreateAlgorithm: TCrc16Algorithm; override;
  end;

{ TchCrc16MODBUSTests }

  TchCrc16MODBUSTests = class(TchCrc16ReverseTests)
  strict protected
    function CreateAlgorithm: TCrc16Algorithm; override;
  end;

{ TchCrc16NRSC5Tests }

  TchCrc16NRSC5Tests = class(TchCrc16ReverseTests)
  strict protected
    function CreateAlgorithm: TCrc16Algorithm; override;
  end;

{ TchCrc16OPENSAFETYATests }

  TchCrc16OPENSAFETYATests = class(TchCrc16NormalTests)
  strict protected
    function CreateAlgorithm: TCrc16Algorithm; override;
  end;

{ TchCrc16OPENSAFETYBTests }

  TchCrc16OPENSAFETYBTests = class(TchCrc16NormalTests)
  strict protected
    function CreateAlgorithm: TCrc16Algorithm; override;
  end;

{ TchCrc16PROFIBUSTests }

  TchCrc16PROFIBUSTests = class(TchCrc16NormalTests)
  strict protected
    function CreateAlgorithm: TCrc16Algorithm; override;
  end;

{ TchCrc16RIELLOTests }

  TchCrc16RIELLOTests = class(TchCrc16ReverseTests)
  strict protected
    function CreateAlgorithm: TCrc16Algorithm; override;
  end;

{ TchCrc16SPIFUJITSUTests }

  TchCrc16SPIFUJITSUTests = class(TchCrc16NormalTests)
  strict protected
    function CreateAlgorithm: TCrc16Algorithm; override;
  end;

{ TchCrc16T10DIFTests }

  TchCrc16T10DIFTests = class(TchCrc16NormalTests)
  strict protected
    function CreateAlgorithm: TCrc16Algorithm; override;
  end;

{ TchCrc16TELEDISKTests }

  TchCrc16TELEDISKTests = class(TchCrc16NormalTests)
  strict protected
    function CreateAlgorithm: TCrc16Algorithm; override;
  end;

{ TchCrc16TMS37157Tests }

  TchCrc16TMS37157Tests = class(TchCrc16ReverseTests)
  strict protected
    function CreateAlgorithm: TCrc16Algorithm; override;
  end;

{ TchCrc16UMTSTests }

  TchCrc16UMTSTests = class(TchCrc16NormalTests)
  strict protected
    function CreateAlgorithm: TCrc16Algorithm; override;
  end;

{ TchCrc16USBTests }

  TchCrc16USBTests = class(TchCrc16ReverseTests)
  strict protected
    function CreateAlgorithm: TCrc16Algorithm; override;
  end;

{ TchCrc16XMODEMTests }

  TchCrc16XMODEMTests = class(TchCrc16NormalTests)
  strict protected
    function CreateAlgorithm: TCrc16Algorithm; override;
  end;

implementation

uses
{$IF DEFINED(USE_JEDI_CORE_LIBRARY)}
  JclLogic,
{$ELSE ~ NOT USE_JEDI_CORE_LIBRARY}
  chHash.Core.Bits,
{$ENDIF ~ USE_JEDI_CORE_LIBRARY}
  chHash.CRC.CRC16.ARC.Factory,
  chHash.CRC.CRC16.CDMA2000.Factory,
  chHash.CRC.CRC16.CMS.Factory,
  chHash.CRC.CRC16.DDS110.Factory,
  chHash.CRC.CRC16.DECTR.Factory,
  chHash.CRC.CRC16.DECTX.Factory,
  chHash.CRC.CRC16.DNP.Factory,
  chHash.CRC.CRC16.EN13757.Factory,
  chHash.CRC.CRC16.GENIBUS.Factory,
  chHash.CRC.CRC16.GSM.Factory,
  chHash.CRC.CRC16.IBM3740.Factory,
  chHash.CRC.CRC16.IBMSDLC.Factory,
  chHash.CRC.CRC16.ISOIEC144433A.Factory,
  chHash.CRC.CRC16.KERMIT.Factory,
  chHash.CRC.CRC16.LJ1200.Factory,
  chHash.CRC.CRC16.MAXIMDOW.Factory,
  chHash.CRC.CRC16.MCRF4XX.Factory,
  chHash.CRC.CRC16.MODBUS.Factory,
  chHash.CRC.CRC16.NRSC5.Factory,
  chHash.CRC.CRC16.OPENSAFETYA.Factory,
  chHash.CRC.CRC16.OPENSAFETYB.Factory,
  chHash.CRC.CRC16.PROFIBUS.Factory,
  chHash.CRC.CRC16.RIELLO.Factory,
  chHash.CRC.CRC16.SPIFUJITSU.Factory,
  chHash.CRC.CRC16.T10DIF.Factory,
  chHash.CRC.CRC16.TELEDISK.Factory,
  chHash.CRC.CRC16.TMS37157.Factory,
  chHash.CRC.CRC16.UMTS.Factory,
  chHash.CRC.CRC16.USB.Factory,
  chHash.CRC.CRC16.XMODEM.Factory,
  TestFramework;

{ TchCrc16NormalTests }

procedure TchCrc16NormalTests.ControlCalculate(var Current: Word; const Data; const Length: Cardinal);
begin
  if Length = 0 then Exit;

  var L := Length;
  var PData: PByte := @Data;
  while L > 0 do
  begin
    Current := (Current shl BitsPerByte) xor FCrcTable[Byte(PData^ xor (Current shr BitsPerByte))];
    Inc(PData);
    Dec(L);
  end;
end;

{ TchCrc16ReverseTests }

procedure TchCrc16ReverseTests.ControlCalculate(var Current: Word; const Data; const Length: Cardinal);
begin
  if Length = 0 then Exit;

  var L := Length;
  var PData: PByte := @Data;
  while L > 0 do
  begin
    Current := (Current shr BitsPerByte) xor FCrcTable[Byte(PData^ xor Current)];
    Inc(PData);
    Dec(L);
  end;
end;

{ TchCrc16ARCTests }

function TchCrc16ARCTests.CreateAlgorithm: TCrc16Algorithm;
begin
  Result := TchCrc16ARC.Instance;
end;

{ TchCrc16CDMA2000Tests }

function TchCrc16CDMA2000Tests.CreateAlgorithm: TCrc16Algorithm;
begin
  Result := TchCrc16CDMA2000.Instance;
end;

{ TchCrc16CMSTests }

function TchCrc16CMSTests.CreateAlgorithm: TCrc16Algorithm;
begin
  Result := TchCrc16CMS.Instance;
end;

{ TchCrc16DDS110Tests }

function TchCrc16DDS110Tests.CreateAlgorithm: TCrc16Algorithm;
begin
  Result := TchCrc16DDS110.Instance;
end;

{ TchCrc16DECTRTests }

function TchCrc16DECTRTests.CreateAlgorithm: TCrc16Algorithm;
begin
  Result := TchCrc16DECTR.Instance;
end;

{ TchCrc16DECTXTests }

function TchCrc16DECTXTests.CreateAlgorithm: TCrc16Algorithm;
begin
  Result := TchCrc16DECTX.Instance;
end;

{ TchCrc16DNPTests }

function TchCrc16DNPTests.CreateAlgorithm: TCrc16Algorithm;
begin
  Result := TchCrc16DNP.Instance;
end;

{ TchCrc16EN13757Tests }

function TchCrc16EN13757Tests.CreateAlgorithm: TCrc16Algorithm;
begin
  Result := TchCrc16EN13757.Instance;
end;

{ TchCrc16GENIBUSTests }

function TchCrc16GENIBUSTests.CreateAlgorithm: TCrc16Algorithm;
begin
  Result := TchCrc16GENIBUS.Instance;
end;

{ TchCrc16GSMTests }

function TchCrc16GSMTests.CreateAlgorithm: TCrc16Algorithm;
begin
  Result := TchCrc16GSM.Instance;
end;

{ TchCrc16IBM3740Tests }

function TchCrc16IBM3740Tests.CreateAlgorithm: TCrc16Algorithm;
begin
  Result := TchCrc16IBM3740.Instance;
end;

{ TchCrc16IBMSDLCTests }

function TchCrc16IBMSDLCTests.CreateAlgorithm: TCrc16Algorithm;
begin
  Result := TchCrc16IBMSDLC.Instance;
end;

{ TchCrc16ISOIEC144433ATests }

function TchCrc16ISOIEC144433ATests.CreateAlgorithm: TCrc16Algorithm;
begin
  Result := TchCrc16ISOIEC144433A.Instance;
end;

{ TchCrc16KERMITTests }

function TchCrc16KERMITTests.CreateAlgorithm: TCrc16Algorithm;
begin
  Result := TchCrc16KERMIT.Instance;
end;

{ TchCrc16LJ1200Tests }

function TchCrc16LJ1200Tests.CreateAlgorithm: TCrc16Algorithm;
begin
  Result := TchCrc16LJ1200.Instance;
end;

{ TchCrc16MAXIMDOWTests }

function TchCrc16MAXIMDOWTests.CreateAlgorithm: TCrc16Algorithm;
begin
  Result := TchCrc16MAXIMDOW.Instance;
end;

{ TchCrc16MCRF4XXTests }

function TchCrc16MCRF4XXTests.CreateAlgorithm: TCrc16Algorithm;
begin
  Result := TchCrc16MCRF4XX.Instance;
end;

{ TchCrc16MODBUSTests }

function TchCrc16MODBUSTests.CreateAlgorithm: TCrc16Algorithm;
begin
  Result := TchCrc16MODBUS.Instance;
end;

{ TchCrc16NRSC5Tests }

function TchCrc16NRSC5Tests.CreateAlgorithm: TCrc16Algorithm;
begin
  Result := TchCrc16NRSC5.Instance;
end;

{ TchCrc16OPENSAFETYATests }

function TchCrc16OPENSAFETYATests.CreateAlgorithm: TCrc16Algorithm;
begin
  Result := TchCrc16OPENSAFETYA.Instance;
end;

{ TchCrc16OPENSAFETYBTests }

function TchCrc16OPENSAFETYBTests.CreateAlgorithm: TCrc16Algorithm;
begin
  Result := TchCrc16OPENSAFETYB.Instance;
end;

{ TchCrc16PROFIBUSTests }

function TchCrc16PROFIBUSTests.CreateAlgorithm: TCrc16Algorithm;
begin
  Result := TchCrc16PROFIBUS.Instance;
end;

{ TchCrc16RIELLOTests }

function TchCrc16RIELLOTests.CreateAlgorithm: TCrc16Algorithm;
begin
  Result := TchCrc16RIELLO.Instance;
end;

{ TchCrc16SPIFUJITSUTests }

function TchCrc16SPIFUJITSUTests.CreateAlgorithm: TCrc16Algorithm;
begin
  Result := TchCrc16SPIFUJITSU.Instance;
end;

{ TchCrc16T10DIFTests }

function TchCrc16T10DIFTests.CreateAlgorithm: TCrc16Algorithm;
begin
  Result := TchCrc16T10DIF.Instance;
end;

{ TchCrc16TELEDISKTests }

function TchCrc16TELEDISKTests.CreateAlgorithm: TCrc16Algorithm;
begin
  Result := TchCrc16TELEDISK.Instance;
end;

{ TchCrc16TMS37157Tests }

function TchCrc16TMS37157Tests.CreateAlgorithm: TCrc16Algorithm;
begin
  Result := TchCrc16TMS37157.Instance;
end;

{ TchCrc16UMTSTests }

function TchCrc16UMTSTests.CreateAlgorithm: TCrc16Algorithm;
begin
  Result := TchCrc16UMTS.Instance;
end;

{ TchCrc16USBTests }

function TchCrc16USBTests.CreateAlgorithm: TCrc16Algorithm;
begin
  Result := TchCrc16USB.Instance;
end;

{ TchCrc16XMODEMTests }

function TchCrc16XMODEMTests.CreateAlgorithm: TCrc16Algorithm;
begin
  Result := TchCrc16XMODEM.Instance;
end;

initialization
  RegisterTest(TchCrc16ARCTests.Suite);
  RegisterTest(TchCrc16CDMA2000Tests.Suite);
  RegisterTest(TchCrc16CMSTests.Suite);
  RegisterTest(TchCrc16DDS110Tests.Suite);
  RegisterTest(TchCrc16DECTRTests.Suite);
  RegisterTest(TchCrc16DECTXTests.Suite);
  RegisterTest(TchCrc16DNPTests.Suite);
  RegisterTest(TchCrc16EN13757Tests.Suite);
  RegisterTest(TchCrc16GENIBUSTests.Suite);
  RegisterTest(TchCrc16GSMTests.Suite);
  RegisterTest(TchCrc16IBM3740Tests.Suite);
  RegisterTest(TchCrc16IBMSDLCTests.Suite);
  RegisterTest(TchCrc16ISOIEC144433ATests.Suite);
  RegisterTest(TchCrc16KERMITTests.Suite);
  RegisterTest(TchCrc16LJ1200Tests.Suite);
  RegisterTest(TchCrc16MAXIMDOWTests.Suite);
  RegisterTest(TchCrc16MCRF4XXTests.Suite);
  RegisterTest(TchCrc16MODBUSTests.Suite);
  RegisterTest(TchCrc16NRSC5Tests.Suite);
  RegisterTest(TchCrc16OPENSAFETYATests.Suite);
  RegisterTest(TchCrc16OPENSAFETYBTests.Suite);
  RegisterTest(TchCrc16PROFIBUSTests.Suite);
  RegisterTest(TchCrc16RIELLOTests.Suite);
  RegisterTest(TchCrc16SPIFUJITSUTests.Suite);
  RegisterTest(TchCrc16T10DIFTests.Suite);
  RegisterTest(TchCrc16TELEDISKTests.Suite);
  RegisterTest(TchCrc16TMS37157Tests.Suite);
  RegisterTest(TchCrc16UMTSTests.Suite);
  RegisterTest(TchCrc16USBTests.Suite);
  RegisterTest(TchCrc16XMODEMTests.Suite);

end.

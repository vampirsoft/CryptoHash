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

unit chHash.CRC.CRC12.Tests;

{$INCLUDE CryptoHash.Tests.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC12,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.CRC12.Impl,
  chHash.CRC.Tests;

type
  TCrc12Algorithm = {$IF DEFINED(SUPPORTS_INTERFACES)}IchCrc12{$ELSE}TchCrc12{$ENDIF};

{ TchCrc12Tests }

  TchCrc12Tests = class abstract(TchCrcWithMultiTableTests<Word, TCrc12Algorithm>)
  end;

{ TchCrc12NormalTests }

  TchCrc12NormalTests = class abstract(TchCrc12Tests)
  strict protected
    procedure ControlCalculate(var Current: Word; const Data; const Length: Cardinal); override;
  end;

{ TchCrc12ReverseTests }

  TchCrc12ReverseTests = class abstract(TchCrc12Tests)
  strict protected
    procedure ControlCalculate(var Current: Word; const Data; const Length: Cardinal); override;
  end;

{ TchCrc12CDMA2000Tests }

  TchCrc12CDMA2000Tests = class(TchCrc12NormalTests)
  strict protected
    function CreateAlgorithm: TCrc12Algorithm; override;
  end;

{ TchCrc12DECTTests }

  TchCrc12DECTTests = class(TchCrc12NormalTests)
  strict protected
    function CreateAlgorithm: TCrc12Algorithm; override;
  end;

{ TchCrc12GSMTests }

  TchCrc12GSMTests = class(TchCrc12NormalTests)
  strict protected
    function CreateAlgorithm: TCrc12Algorithm; override;
  end;

{ TchCrc12UMTSTests }

  TchCrc12UMTSTests = class(TchCrc12NormalTests)
  strict protected
    function CreateAlgorithm: TCrc12Algorithm; override;
  end;

implementation

uses
{$IF DEFINED(USE_JEDI_CORE_LIBRARY)}
  JclLogic,
{$ELSE ~ NOT USE_JEDI_CORE_LIBRARY}
  chHash.Core.Bits,
{$ENDIF ~ USE_JEDI_CORE_LIBRARY}
  chHash.CRC.CRC12.CDMA2000.Factory,
  chHash.CRC.CRC12.DECT.Factory,
  chHash.CRC.CRC12.GSM.Factory,
  chHash.CRC.CRC12.UMTS.Factory,
  TestFramework;

{ TchCrc12NormalTests }

procedure TchCrc12NormalTests.ControlCalculate(var Current: Word; const Data; const Length: Cardinal);
begin
  if Length = 0 then Exit;

  const Shift = FAlgorithm.Width - BitsPerByte;
  var L := Length;
  var PData: PByte := @Data;
  while L > 0 do
  begin
    Current := (Current shl BitsPerByte) xor FCrcTable[Byte(PData^ xor (Current shr Shift))];
    Inc(PData);
    Dec(L);
  end;
end;

{ TchCrc12ReverseTests }

procedure TchCrc12ReverseTests.ControlCalculate(var Current: Word; const Data; const Length: Cardinal);
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

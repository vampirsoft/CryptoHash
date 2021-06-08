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

unit chHash.CRC.CRC10.Tests;

{$INCLUDE CryptoHash.Tests.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC10,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.CRC10.Impl,
  chHash.CRC.Tests;

type
  TCrc10Algorithm = {$IF DEFINED(SUPPORTS_INTERFACES)}IchCrc10{$ELSE}TchCrc10{$ENDIF};

{ TchCrc10Tests }

  TchCrc10Tests = class abstract(TchCrcWithMultiTableTests<Word, TCrc10Algorithm>)
  end;

{ TchCrc12NormalTests }

  TchCrc12NormalTests = class abstract(TchCrc10Tests)
  strict protected
    procedure ControlCalculate(var Current: Word; const Data; const Length: Cardinal); override;
  end;

{ TchCrc10ATMTests }

  TchCrc10ATMTests = class(TchCrc12NormalTests)
  strict protected
    function CreateAlgorithm: TCrc10Algorithm; override;
  end;

{ TchCrc10CDMA2000Tests }

  TchCrc10CDMA2000Tests = class(TchCrc12NormalTests)
  strict protected
    function CreateAlgorithm: TCrc10Algorithm; override;
  end;

{ TchCrc10GSMTests }

  TchCrc10GSMTests = class(TchCrc12NormalTests)
  strict protected
    function CreateAlgorithm: TCrc10Algorithm; override;
  end;

implementation

uses
{$IF DEFINED(USE_JEDI_CORE_LIBRARY)}
  JclLogic,
{$ELSE ~ NOT USE_JEDI_CORE_LIBRARY}
  chHash.Core.Bits,
{$ENDIF ~ USE_JEDI_CORE_LIBRARY}
  chHash.CRC.CRC10.ATM.Factory,
  chHash.CRC.CRC10.CDMA2000.Factory,
  chHash.CRC.CRC10.GSM.Factory,
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

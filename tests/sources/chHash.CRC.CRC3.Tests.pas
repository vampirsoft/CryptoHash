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

unit chHash.CRC.CRC3.Tests;

{$INCLUDE CryptoHash.Tests.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC3,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.CRC3.Impl,
  chHash.CRC.Tests;

type
  TCrc3Algorithm = {$IF DEFINED(SUPPORTS_INTERFACES)}IchCrc3{$ELSE}TchCrc3{$ENDIF};

{ TchCrc3Tests }

  TchCrc3Tests = class abstract(TchCrcTests<Byte, TCrc3Algorithm>)
  end;

{ TchCrc3NormalTests }

  TchCrc3NormalTests = class abstract(TchCrc3Tests)
  strict protected
    procedure ControlCalculate(var Current: Byte; const Data; const Length: Cardinal); override;
  end;

{ TchCrc3ReverseTests }

  TchCrc3ReverseTests = class abstract(TchCrc3Tests)
  strict protected
    procedure ControlCalculate(var Current: Byte; const Data; const Length: Cardinal); override;
  end;

{ TchCrc3GSMTests }

  TchCrc3GSMTests = class(TchCrc3NormalTests)
  strict protected
    function CreateAlgorithm: TCrc3Algorithm; override;
  end;

{ TchCrc3ROHCTests }

  TchCrc3ROHCTests = class(TchCrc3ReverseTests)
  strict protected
    function CreateAlgorithm: TCrc3Algorithm; override;
  end;

implementation

uses
{$IF DEFINED(USE_JEDI_CORE_LIBRARY)}
  JclLogic,
{$ELSE ~ NOT USE_JEDI_CORE_LIBRARY}
  chHash.Core.Bits,
{$ENDIF ~ USE_JEDI_CORE_LIBRARY}
  chHash.CRC.CRC3.GSM.Factory,
  chHash.CRC.CRC3.ROHC.Factory,
  TestFramework;

{ TchCrc3NormalTests }

procedure TchCrc3NormalTests.ControlCalculate(var Current: Byte; const Data; const Length: Cardinal);
begin
  if Length = 0 then Exit;

  const Shift = BitsPerByte - FAlgorithm.Width;
  var L := Length;
  var PData: PByte := @Data;
  while L > 0 do
  begin
    Current := FCrcTable[Byte(PData^ xor (Current shl Shift))];
    Inc(PData);
    Dec(L);
  end;
end;

{ TchCrc3ReverseTests }

procedure TchCrc3ReverseTests.ControlCalculate(var Current: Byte; const Data; const Length: Cardinal);
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

{ TchCrc3GSMTests }

function TchCrc3GSMTests.CreateAlgorithm: TCrc3Algorithm;
begin
  Result := TchCrc3GSM.Instance;
end;

{ TchCrc3ROHCTests }

function TchCrc3ROHCTests.CreateAlgorithm: TCrc3Algorithm;
begin
  Result := TchCrc3ROHC.Instance;
end;

initialization
  RegisterTest(TchCrc3GSMTests.Suite);
  RegisterTest(TchCrc3ROHCTests.Suite);

end.

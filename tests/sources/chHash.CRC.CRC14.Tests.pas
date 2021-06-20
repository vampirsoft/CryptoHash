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
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.CRC14.Impl,
  chHash.CRC.Tests;

type
  TCrc14Algorithm = {$IF DEFINED(SUPPORTS_INTERFACES)}IchCrc14{$ELSE}TchCrc14{$ENDIF};

{ TchCrc14Tests }

  TchCrc14Tests = class abstract(TchCrcWithMultiTableTests<Word, TCrc14Algorithm>)
  end;

{ TchCrc14NormalTests }

  TchCrc14NormalTests = class abstract(TchCrc14Tests)
  strict protected
    procedure ControlCalculate(var Current: Word; const Data; const Length: Cardinal); override;
  end;

{ TchCrc14ReverseTests }

  TchCrc14ReverseTests = class abstract(TchCrc14Tests)
  strict protected
    procedure ControlCalculate(var Current: Word; const Data; const Length: Cardinal); override;
  end;

{ TchCrc14DARCTests }

  TchCrc14DARCTests = class(TchCrc14ReverseTests)
  strict protected
    function CreateAlgorithm: TCrc14Algorithm; override;
  end;

{ TchCrc14GSMTests }

  TchCrc14GSMTests = class(TchCrc14NormalTests)
  strict protected
    function CreateAlgorithm: TCrc14Algorithm; override;
  end;

implementation

uses
{$IF DEFINED(USE_JEDI_CORE_LIBRARY)}
  JclLogic,
{$ELSE ~ NOT USE_JEDI_CORE_LIBRARY}
  chHash.Core.Bits,
{$ENDIF ~ USE_JEDI_CORE_LIBRARY}
  chHash.CRC.CRC14.DARC.Factory,
  chHash.CRC.CRC14.GSM.Factory,
  TestFramework;

{ TchCrc14NormalTests }

procedure TchCrc14NormalTests.ControlCalculate(var Current: Word; const Data; const Length: Cardinal);
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

{ TchCrc14ReverseTests }

procedure TchCrc14ReverseTests.ControlCalculate(var Current: Word; const Data; const Length: Cardinal);
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

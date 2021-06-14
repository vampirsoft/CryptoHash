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

unit chHash.CRC.CRC13.Tests;

{$INCLUDE CryptoHash.Tests.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC13,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.CRC13.Impl,
  chHash.CRC.Tests;

type
  TCrc13Algorithm = {$IF DEFINED(SUPPORTS_INTERFACES)}IchCrc13{$ELSE}TchCrc13{$ENDIF};

{ TchCrc13Tests }

  TchCrc13Tests = class abstract(TchCrcWithMultiTableTests<Word, TCrc13Algorithm>)
  end;

{ TchCrc13NormalTests }

  TchCrc13NormalTests = class abstract(TchCrc13Tests)
  strict protected
    procedure ControlCalculate(var Current: Word; const Data; const Length: Cardinal); override;
  end;

{ TchCrc13BBCTests }

  TchCrc13BBCTests = class(TchCrc13NormalTests)
  strict protected
    function CreateAlgorithm: TCrc13Algorithm; override;
  end;

implementation

uses
{$IF DEFINED(USE_JEDI_CORE_LIBRARY)}
  JclLogic,
{$ELSE ~ NOT USE_JEDI_CORE_LIBRARY}
  chHash.Core.Bits,
{$ENDIF ~ USE_JEDI_CORE_LIBRARY}
  chHash.CRC.CRC13.BBC.Factory,
  TestFramework;

{ TchCrc13NormalTests }

procedure TchCrc13NormalTests.ControlCalculate(var Current: Word; const Data; const Length: Cardinal);
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

{ TchCrc13BBCTests }

function TchCrc13BBCTests.CreateAlgorithm: TCrc13Algorithm;
begin
  Result := TchCrc13BBC.Instance;
end;

initialization
  RegisterTest(TchCrc13BBCTests.Suite);

end.

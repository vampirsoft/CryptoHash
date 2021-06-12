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

unit chHash.CRC.CRC11.Tests;

{$INCLUDE CryptoHash.Tests.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC11,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.CRC11.Impl,
  chHash.CRC.Tests;

type
  TCrc11Algorithm = {$IF DEFINED(SUPPORTS_INTERFACES)}IchCrc11{$ELSE}TchCrc11{$ENDIF};

{ TchCrc11Tests }

  TchCrc11Tests = class abstract(TchCrcWithMultiTableTests<Word, TCrc11Algorithm>)
  end;

{ TchCrc11NormalTests }

  TchCrc11NormalTests = class abstract(TchCrc11Tests)
  strict protected
    procedure ControlCalculate(var Current: Word; const Data; const Length: Cardinal); override;
  end;

{ TchCrc11FLEXRAYTests }

  TchCrc11FLEXRAYTests = class(TchCrc11NormalTests)
  strict protected
    function CreateAlgorithm: TCrc11Algorithm; override;
  end;

{ TchCrc11UMTSTests }

  TchCrc11UMTSTests = class(TchCrc11NormalTests)
  strict protected
    function CreateAlgorithm: TCrc11Algorithm; override;
  end;

implementation

uses
{$IF DEFINED(USE_JEDI_CORE_LIBRARY)}
  JclLogic,
{$ELSE ~ NOT USE_JEDI_CORE_LIBRARY}
  chHash.Core.Bits,
{$ENDIF ~ USE_JEDI_CORE_LIBRARY}
  chHash.CRC.CRC11.FLEXRAY.Factory,
  chHash.CRC.CRC11.UMTS.Factory,
  TestFramework;

{ TchCrc11NormalTests }

procedure TchCrc11NormalTests.ControlCalculate(var Current: Word; const Data; const Length: Cardinal);
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

{ TchCrc11FLEXRAYTests }

function TchCrc11FLEXRAYTests.CreateAlgorithm: TCrc11Algorithm;
begin
  Result := TchCrc11FLEXRAY.Instance;
end;

{ TchCrc11UMTSTests }

function TchCrc11UMTSTests.CreateAlgorithm: TCrc11Algorithm;
begin
  Result := TchCrc11UMTS.Instance;
end;

initialization
  RegisterTest(TchCrc11FLEXRAYTests.Suite);
  RegisterTest(TchCrc11UMTSTests.Suite);

end.

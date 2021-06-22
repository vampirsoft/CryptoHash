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
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC.CRC13.Impl,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.CRC16Bits.Tests;

type
  TCrc13Algorithm = {$IF DEFINED(SUPPORTS_INTERFACES)}IchCrc13{$ELSE}TchCrc13{$ENDIF};

{ TchCrc13BBCTests }

  TchCrc13BBCTests = class(TchCrc16BitsNormalTests<TCrc13Algorithm>)
  strict protected
    function CreateAlgorithm: TCrc13Algorithm; override;
  end;

implementation

uses
  chHash.CRC.CRC13.BBC.Factory,
  TestFramework;

{ TchCrc13BBCTests }

function TchCrc13BBCTests.CreateAlgorithm: TCrc13Algorithm;
begin
  Result := TchCrc13BBC.Instance;
end;

initialization
  RegisterTest(TchCrc13BBCTests.Suite);

end.

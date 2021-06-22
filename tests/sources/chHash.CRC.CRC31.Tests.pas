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

unit chHash.CRC.CRC31.Tests;

{$INCLUDE CryptoHash.Tests.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC31,
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC.CRC31.Impl,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.CRC32Bits.Tests;

type
  TCrc31Algorithm = {$IF DEFINED(SUPPORTS_INTERFACES)}IchCrc31{$ELSE}TchCrc31{$ENDIF};

{ TchCrc31PHILIPSTests }

  TchCrc31PHILIPSTests = class(TchCrc32BitsNormalTests<TCrc31Algorithm>)
  strict protected
    function CreateAlgorithm: TCrc31Algorithm; override;
  end;

implementation

uses
  chHash.CRC.CRC31.PHILIPS.Factory,
  TestFramework;

{ TchCrc31PHILIPSTests }

function TchCrc31PHILIPSTests.CreateAlgorithm: TCrc31Algorithm;
begin
  Result := TchCrc31PHILIPS.Instance;
end;

initialization
  RegisterTest(TchCrc31PHILIPSTests.Suite);

end.

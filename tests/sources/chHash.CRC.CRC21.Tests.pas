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

unit chHash.CRC.CRC21.Tests;

{$INCLUDE CryptoHash.Tests.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC21,
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC.CRC21.Impl,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.CRC32Bits.Tests;

type
  TCrc21Algorithm = {$IF DEFINED(SUPPORTS_INTERFACES)}IchCrc21{$ELSE}TchCrc21{$ENDIF};

{ TchCrc21CANFDTests }

  TchCrc21CANFDTests = class(TchCrc32BitsNormalTests<TCrc21Algorithm>)
  strict protected
    function CreateAlgorithm: TCrc21Algorithm; override;
  end;

implementation

uses
  chHash.CRC.CRC21.CANFD.Factory,
  TestFramework;

{ TchCrc21CANFDTests }

function TchCrc21CANFDTests.CreateAlgorithm: TCrc21Algorithm;
begin
  Result := TchCrc21CANFD.Instance;
end;

initialization
  RegisterTest(TchCrc21CANFDTests.Suite);

end.

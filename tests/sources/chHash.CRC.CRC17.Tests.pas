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

unit chHash.CRC.CRC17.Tests;

{$INCLUDE CryptoHash.Tests.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC17,
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC.CRC17.Impl,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.CRC32Bits.Tests;

type
  TCrc17Algorithm = {$IF DEFINED(SUPPORTS_INTERFACES)}IchCrc17{$ELSE}TchCrc17{$ENDIF};

{ TchCrc17CANFDTests }

  TchCrc17CANFDTests = class(TchCrc32BitsNormalTests<TCrc17Algorithm>)
  strict protected
    function CreateAlgorithm: TCrc17Algorithm; override;
  end;

implementation

uses
  chHash.CRC.CRC17.CANFD.Factory,
  TestFramework;

{ TchCrc17CANFDTests }

function TchCrc17CANFDTests.CreateAlgorithm: TCrc17Algorithm;
begin
  Result := TchCrc17CANFD.Instance;
end;

initialization
  RegisterTest(TchCrc17CANFDTests.Suite);

end.

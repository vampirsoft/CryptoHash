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
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC.CRC11.Impl,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.CRC16Bits.Tests;

type
  TCrc11Algorithm = {$IF DEFINED(SUPPORTS_INTERFACES)}IchCrc11{$ELSE}TchCrc11{$ENDIF};

{ TchCrc11FLEXRAYTests }

  TchCrc11FLEXRAYTests = class(TchCrc16BitsNormalTests<TCrc11Algorithm>)
  strict protected
    function CreateAlgorithm: TCrc11Algorithm; override;
  end;

{ TchCrc11UMTSTests }

  TchCrc11UMTSTests = class(TchCrc16BitsNormalTests<TCrc11Algorithm>)
  strict protected
    function CreateAlgorithm: TCrc11Algorithm; override;
  end;

implementation

uses
  chHash.CRC.CRC11.FLEXRAY.Factory,
  chHash.CRC.CRC11.UMTS.Factory,
  TestFramework;

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

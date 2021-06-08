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

unit chHash.CRC.CRC10.CDMA2000;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC10.Impl,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.CRC10;

type

{ TchCrc10CDMA2000 }

  TchCrc10CDMA2000 =
    class({$IF DEFINED(SUPPORTS_INTERFACES)}chHash.CRC.CRC10.Impl{$ELSE}chHash.CRC.CRC10{$ENDIF}.TchCrc10)
  public
    constructor Create; reintroduce;
  end;

implementation

{ TchCrc10CDMA2000 }

constructor TchCrc10CDMA2000.Create;
begin
  inherited Create('CRC-10/CDMA2000', $3D9, Bits10Mask, $000, $233, False, False);
end;

end.

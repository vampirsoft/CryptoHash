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

unit chHash.CRC.CRC31.PHILIPS;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC31.Impl,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.CRC31;

type

{ TchCrc31PHILIPS }

  TchCrc31PHILIPS =
    class({$IF DEFINED(SUPPORTS_INTERFACES)}chHash.CRC.CRC31.Impl{$ELSE}chHash.CRC.CRC31{$ENDIF}.TchCrc31)
  public
    constructor Create; reintroduce;
  end;

implementation

{ TchCrc31PHILIPS }

constructor TchCrc31PHILIPS.Create;
begin
  inherited Create('CRC-31/PHILIPS', $04C11DB7, Bits31Mask, Bits31Mask, $0CE9E46C, False, False);
end;

end.

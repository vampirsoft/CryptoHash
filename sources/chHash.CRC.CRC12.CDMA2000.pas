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

unit chHash.CRC.CRC12.CDMA2000;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC12.Impl,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.CRC12;

type

{ TchCrc12CDMA2000 }

  TchCrc12CDMA2000 =
    class({$IF DEFINED(SUPPORTS_INTERFACES)}chHash.CRC.CRC12.Impl{$ELSE}chHash.CRC.CRC12{$ENDIF}.TchCrc12)
  public
    constructor Create; reintroduce;
  end;

implementation

{ TchCrc12CDMA2000 }

constructor TchCrc12CDMA2000.Create;
begin
  inherited Create('CRC-12/CDMA2000', $F13, Bits12Mask, $000, $D4D, False, False);
end;

end.

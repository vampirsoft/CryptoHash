/////////////////////////////////////////////////////////////////////////////////
//*****************************************************************************//
//* Project      : CryptoHash                                                 *//
//* Latest Source: https://github.com/vampirsoft/CryptoHash                   *//
//* Unit Name    : CryptoHash.inc                                             *//
//* Author       : Сергей (LordVampir) Дворников                              *//
//* Copyright 2019 LordVampir (https://github.com/vampirsoft)                 *//
//* Licensed under the Apache License, Version 2.0                            *//
//*****************************************************************************//
/////////////////////////////////////////////////////////////////////////////////

unit chHash.CRC.CRC12.GSM;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC12.Impl,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.CRC12;

type

{ TchCrc12GSM }

  TchCrc12GSM = class({$IF DEFINED(SUPPORTS_INTERFACES)}chHash.CRC.CRC12.Impl{$ELSE}chHash.CRC.CRC12{$ENDIF}.TchCrc12)
  public
    constructor Create; reintroduce;
  end;

implementation

{ TchCrc12GSM }

constructor TchCrc12GSM.Create;
begin
  inherited Create('CRC-12/GSM', $D31, $000, Bits12Mask, $B34, False, False);
end;

end.

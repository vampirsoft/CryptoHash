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

unit chHash.CRC.CRC8.SMBUS;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC8.Impl;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC.CRC8;
{$ENDIF ~ SUPPORTS_INTERFACES}

type

{ TchCrc8SMBUS }

  TchCrc8SMBUS = class({$IF DEFINED(SUPPORTS_INTERFACES)}chHash.CRC.CRC8.Impl{$ELSE}chHash.CRC.CRC8{$ENDIF}.TchCrc8)
  public
    constructor Create; reintroduce;
  end;

implementation

{ TchCrc8SMBUS }

constructor TchCrc8SMBUS.Create;
begin
  inherited Create('CRC-8/SMBUS', $07, $00, $00, $F4, False, False);
  Aliases.Add('CRC-8');
end;

end.

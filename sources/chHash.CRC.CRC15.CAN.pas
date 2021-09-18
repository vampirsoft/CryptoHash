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

unit chHash.CRC.CRC15.CAN;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC15.Impl;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC.CRC15;
{$ENDIF ~ SUPPORTS_INTERFACES}

type

{ TchCrc15CAN }

  TchCrc15CAN = class({$IF DEFINED(SUPPORTS_INTERFACES)}chHash.CRC.CRC15.Impl{$ELSE}chHash.CRC.CRC15{$ENDIF}.TchCrc15)
  public
    constructor Create; reintroduce;
  end;

implementation

{ TchCrc15CAN }

constructor TchCrc15CAN.Create;
begin
  inherited Create('CRC-15/CAN', $4599, $0000, $0000, $059E, False, False);
  Aliases.Add('CRC-15');
end;

end.

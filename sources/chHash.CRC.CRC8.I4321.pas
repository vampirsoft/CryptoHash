﻿/////////////////////////////////////////////////////////////////////////////////
//*****************************************************************************//
//* Project      : CryptoHash                                                 *//
//* Latest Source: https://github.com/vampirsoft/CryptoHash                   *//
//* Unit Name    : CryptoHash.inc                                             *//
//* Author       : Сергей (LordVampir) Дворников                              *//
//* Copyright 2021 LordVampir (https://github.com/vampirsoft)                 *//
//* Licensed under MIT                                                        *//
//*****************************************************************************//
/////////////////////////////////////////////////////////////////////////////////

unit chHash.CRC.CRC8.I4321;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC8.Impl;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC.CRC8;
{$ENDIF ~ SUPPORTS_INTERFACES}

type

{ TchCrc8I4321 }

  TchCrc8I4321 = class({$IF DEFINED(SUPPORTS_INTERFACES)}chHash.CRC.CRC8.Impl{$ELSE}chHash.CRC.CRC8{$ENDIF}.TchCrc8)
  public
    constructor Create; reintroduce;
  end;

implementation

{ TchCrc8I4321 }

constructor TchCrc8I4321.Create;
begin
  inherited Create('CRC-8/I-432-1', $07, $00, $55, $A1, False, False);
  Aliases.Add('CRC-8/ITU');
end;

end.

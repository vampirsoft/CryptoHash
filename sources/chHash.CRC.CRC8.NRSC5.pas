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

unit chHash.CRC.CRC8.NRSC5;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC8.Impl;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC.CRC8;
{$ENDIF ~ SUPPORTS_INTERFACES}

type

{ TchCrc8NRSC5 }

  TchCrc8NRSC5 = class({$IF DEFINED(SUPPORTS_INTERFACES)}chHash.CRC.CRC8.Impl{$ELSE}chHash.CRC.CRC8{$ENDIF}.TchCrc8)
  public
    constructor Create; reintroduce;
  end;

implementation

uses
{$IF DEFINED(USE_JEDI_CORE_LIBRARY)}
  JclLogic;
{$ELSE ~ NOT USE_JEDI_CORE_LIBRARY}
  chHash.Core.Bits;
{$ENDIF ~ USE_JEDI_CORE_LIBRARY}

{ TchCrc8NRSC5 }

constructor TchCrc8NRSC5.Create;
begin
  inherited Create('CRC-8/NRSC-5', $31, ByteMask, $00, $F7, False, False);
end;

end.

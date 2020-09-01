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

unit chHash.CRC.CRC8.TECH3250;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC8.Impl;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC.CRC8;
{$ENDIF ~ SUPPORTS_INTERFACES}

type

{ TchCrc8TECH3250 }

  TchCrc8TECH3250 = class({$IF DEFINED(SUPPORTS_INTERFACES)}chHash.CRC.CRC8.Impl{$ELSE}chHash.CRC.CRC8{$ENDIF}.TchCrc8)
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

{ TchCrc8TECH3250 }

constructor TchCrc8TECH3250.Create;
begin
  inherited Create('CRC-8/TECH-3250', $1D, ByteMask, $00, $97, True, True);
  Aliases.Add('CRC-8/AES');
  Aliases.Add('CRC-8/EBU');
end;

end.

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

unit chHash.CRC.CRC5.USB;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC5.Impl,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.CRC5;

type

{ TchCrc5USB }

  TchCrc5USB = class({$IF DEFINED(SUPPORTS_INTERFACES)}chHash.CRC.CRC5.Impl{$ELSE}chHash.CRC.CRC5{$ENDIF}.TchCrc5)
  public
    constructor Create; reintroduce;
  end;

implementation

{ TchCrc5USB }

constructor TchCrc5USB.Create;
begin
  inherited Create('CRC-5/USB', $05, Bits5Mask, Bits5Mask, $19, True, True);
end;

end.

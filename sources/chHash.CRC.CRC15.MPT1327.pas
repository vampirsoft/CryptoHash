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

unit chHash.CRC.CRC15.MPT1327;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC15.Impl;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC.CRC15;
{$ENDIF ~ SUPPORTS_INTERFACES}

type

{ TchCrc15MPT1327 }

  TchCrc15MPT1327 =
    class({$IF DEFINED(SUPPORTS_INTERFACES)}chHash.CRC.CRC15.Impl{$ELSE}chHash.CRC.CRC15{$ENDIF}.TchCrc15)
  public
    constructor Create; reintroduce;
  end;

implementation

{ TchCrc15MPT1327 }

constructor TchCrc15MPT1327.Create;
begin
  inherited Create('CRC-15/MPT1327', $6815, $0000, $0001, $2566, False, False);
end;

end.

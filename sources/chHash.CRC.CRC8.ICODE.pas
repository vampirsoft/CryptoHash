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

unit chHash.CRC.CRC8.ICODE;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC8.Impl;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC.CRC8;
{$ENDIF ~ SUPPORTS_INTERFACES}

type

{ TchCrc8ICODE }

  TchCrc8ICODE = class({$IF DEFINED(SUPPORTS_INTERFACES)}chHash.CRC.CRC8.Impl{$ELSE}chHash.CRC.CRC8{$ENDIF}.TchCrc8)
  public
    constructor Create; reintroduce;
  end;

implementation

{ TchCrc8ICODE }

constructor TchCrc8ICODE.Create;
begin
  inherited Create('CRC-8/I-CODE', $1D, $FD, $00, $7E, False, False);
end;

end.

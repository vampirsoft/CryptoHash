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

unit chHash.CRC.CRC16.LJ1200;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC16.Impl;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC.CRC16;
{$ENDIF ~ SUPPORTS_INTERFACES}

type

{ TchCrc16LJ1200 }

  TchCrc16LJ1200 =
    class({$IF DEFINED(SUPPORTS_INTERFACES)}chHash.CRC.CRC16.Impl{$ELSE}chHash.CRC.CRC16{$ENDIF}.TchCrc16)
  public
    constructor Create; reintroduce;
  end;

implementation

{ TchCrc16LJ1200 }

constructor TchCrc16LJ1200.Create;
begin
  inherited Create('CRC-16/LJ1200', $6F63, $0000, $0000, $BDF4, False, False);
end;

end.

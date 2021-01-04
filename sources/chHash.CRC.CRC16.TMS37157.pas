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

unit chHash.CRC.CRC16.TMS37157;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC16.Impl;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC.CRC16;
{$ENDIF ~ SUPPORTS_INTERFACES}

type

{ TchCrc16TMS37157 }

  TchCrc16TMS37157 =
    class({$IF DEFINED(SUPPORTS_INTERFACES)}chHash.CRC.CRC16.Impl{$ELSE}chHash.CRC.CRC16{$ENDIF}.TchCrc16)
  public
    constructor Create; reintroduce;
  end;

implementation

{ TchCrc16TMS37157 }

constructor TchCrc16TMS37157.Create;
begin
  inherited Create('CRC-16/TMS37157', $1021, $89EC, $0000, $26B1, True, True);
end;

end.

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

unit chHash.CRC.CRC16.ARC;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC16.Impl;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC.CRC16;
{$ENDIF ~ SUPPORTS_INTERFACES}

type

{ TchCrc16ARC }

  TchCrc16ARC = class({$IF DEFINED(SUPPORTS_INTERFACES)}chHash.CRC.CRC16.Impl{$ELSE}chHash.CRC.CRC16{$ENDIF}.TchCrc16)
  public
    constructor Create; reintroduce;
  end;

implementation

{ TchCrc16ARC }

constructor TchCrc16ARC.Create;
begin
  inherited Create('CRC-16/ARC', $8005, $0000, $0000, $BB3D, True, True);
  Aliases.Add('ARC');
  Aliases.Add('CRC-16');
  Aliases.Add('CRC-16/LHA');
  Aliases.Add('CRC-IBM');
end;

end.

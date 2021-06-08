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

unit chHash.CRC.CRC16.KERMIT;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC16.Impl;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC.CRC16;
{$ENDIF ~ SUPPORTS_INTERFACES}

type

{ TchCrc16KERMIT }

  TchCrc16KERMIT =
    class({$IF DEFINED(SUPPORTS_INTERFACES)}chHash.CRC.CRC16.Impl{$ELSE}chHash.CRC.CRC16{$ENDIF}.TchCrc16)
  public
    constructor Create; reintroduce;
  end;

implementation

{ TchCrc16KERMIT }

constructor TchCrc16KERMIT.Create;
begin
  inherited Create('CRC-16/KERMIT', $1021, $0000, $0000, $2189, True, True);
  Aliases.Add('CRC-16/CCITT');
  Aliases.Add('CRC-16/CCITT-TRUE');
  Aliases.Add('CRC-16/V-41-LSB');
  Aliases.Add('CRC-16/CRC-CCITT');
  Aliases.Add('CRC-16/KERMIT');
end;

end.

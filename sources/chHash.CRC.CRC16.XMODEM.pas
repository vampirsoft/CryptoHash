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

unit chHash.CRC.CRC16.XMODEM;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC16.Impl;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC.CRC16;
{$ENDIF ~ SUPPORTS_INTERFACES}

type

{ TchCrc16XMODEM }

  TchCrc16XMODEM =
    class({$IF DEFINED(SUPPORTS_INTERFACES)}chHash.CRC.CRC16.Impl{$ELSE}chHash.CRC.CRC16{$ENDIF}.TchCrc16)
  public
    constructor Create; reintroduce;
  end;

implementation

{ TchCrc16XMODEM }

constructor TchCrc16XMODEM.Create;
begin
  inherited Create('CRC-16/XMODEM', $1021, $0000, $0000, $31C3, False, False);
  Aliases.Add('CRC-16/ACORN');
  Aliases.Add('CRC-16/LTE');
  Aliases.Add('CRC-16/V-41-MSB');
  Aliases.Add('XMODEM');
  Aliases.Add('ZMODEM');
end;

end.

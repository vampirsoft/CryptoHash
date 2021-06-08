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

unit chHash.CRC.CRC16.SPIFUJITSU;

{$INCLUDE CryptoHash.inc}

interface

uses
  chHash.CRC.CRC16.Reverse;

type

{ TchCrc16SPIFUJITSU }

  TchCrc16SPIFUJITSU = class(TchReverseCrc16)
  public
    constructor Create; reintroduce;
  end;

implementation

{ TchCrc16SPIFUJITSU }

constructor TchCrc16SPIFUJITSU.Create;
begin
  inherited Create('CRC-16/SPI-FUJITSU', $1021, $1D0F, $0000, $E5CC, False, False);
  Aliases.Add('CRC-16/AUG-CCITT');
end;

end.

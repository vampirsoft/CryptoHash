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

unit chHash.CRC.CRC16.DDS110;

{$INCLUDE CryptoHash.inc}

interface

uses
  chHash.CRC.CRC16.Reverse;

type

{ TchCrc16DDS110 }

  TchCrc16DDS110 = class(TchReverseCrc16)
  public
    constructor Create; reintroduce;
  end;

implementation

{ TchCrc16DDS110 }

constructor TchCrc16DDS110.Create;
begin
  inherited Create('CRC-16/DDS-110', $8005, $800D, $0000, $9ECF, False, False);
end;

end.

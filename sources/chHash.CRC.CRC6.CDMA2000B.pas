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

unit chHash.CRC.CRC6.CDMA2000B;

{$INCLUDE CryptoHash.inc}

interface

uses
  chHash.CRC.CRC6.Reverse;

type

{ TchCrc6CDMA2000B }

  TchCrc6CDMA2000B = class(TchReverseCrc6)
  public
    constructor Create; reintroduce;
  end;

implementation

uses
  chHash.CRC.CRC6;

{ TchCrc6CDMA2000B }

constructor TchCrc6CDMA2000B.Create;
begin
  inherited Create('CRC-6/CDMA2000-B', $07, Bits6Mask, $00, $3B, False, False);
end;

end.

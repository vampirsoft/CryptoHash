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

unit chHash.CRC.CRC6.GSM;

{$INCLUDE CryptoHash.inc}

interface

uses
  chHash.CRC.CRC6.Reverse;

type

{ TchCrc6GSM }

  TchCrc6GSM = class(TchReverseCrc6)
  public
    constructor Create; reintroduce;
  end;

implementation

uses
  chHash.CRC.CRC6;

{ TchCrc6GSM }

constructor TchCrc6GSM.Create;
begin
  inherited Create('CRC-6/GSM', $2F, $00, Bits6Mask, $13, False, False);
end;

end.

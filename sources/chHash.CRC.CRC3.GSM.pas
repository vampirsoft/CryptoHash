﻿/////////////////////////////////////////////////////////////////////////////////
//*****************************************************************************//
//* Project      : CryptoHash                                                 *//
//* Latest Source: https://github.com/vampirsoft/CryptoHash                   *//
//* Unit Name    : CryptoHash.inc                                             *//
//* Author       : Сергей (LordVampir) Дворников                              *//
//* Copyright 2019 LordVampir (https://github.com/vampirsoft)                 *//
//* Licensed under the Apache License, Version 2.0                            *//
//*****************************************************************************//
/////////////////////////////////////////////////////////////////////////////////

unit chHash.CRC.CRC3.GSM;

{$INCLUDE CryptoHash.inc}

interface

uses
  chHash.CRC.CRC3.Reverse;

type

{ TchCrc3GSM }

  TchCrc3GSM = class(TchReverseCrc3)
  public
    constructor Create; reintroduce;
  end;

implementation

uses
  chHash.CRC.CRC3;

{ TchCrc3GSM }

constructor TchCrc3GSM.Create;
begin
  inherited Create('CRC-3/GSM', $3, $0, Bits3Mask, $4, False, False);
end;

end.
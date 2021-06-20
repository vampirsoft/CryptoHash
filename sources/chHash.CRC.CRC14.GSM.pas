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

unit chHash.CRC.CRC14.GSM;

{$INCLUDE CryptoHash.inc}

interface

uses
  chHash.CRC.CRC14.Reverse;

type

{ TchCrc14GSM }

  TchCrc14GSM = class(TchReverseCrc14)
  public
    constructor Create; reintroduce;
  end;

implementation

uses
  chHash.CRC.CRC14;

{ TchCrc1GSM }

constructor TchCrc14GSM.Create;
begin
  inherited Create('CRC-14/GSM', $202D, $0000, Bits14Mask, $30AE, False, False);
end;

end.

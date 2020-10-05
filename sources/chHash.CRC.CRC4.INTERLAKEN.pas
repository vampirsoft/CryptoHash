/////////////////////////////////////////////////////////////////////////////////
//*****************************************************************************//
//* Project      : CryptoHash                                                 *//
//* Latest Source: https://github.com/vampirsoft/CryptoHash                   *//
//* Unit Name    : CryptoHash.inc                                             *//
//* Author       : Сергей (LordVampir) Дворников                              *//
//* Copyright 2019 LordVampir (https://github.com/vampirsoft)                 *//
//* Licensed under the Apache License, Version 2.0                            *//
//*****************************************************************************//
/////////////////////////////////////////////////////////////////////////////////

unit chHash.CRC.CRC4.INTERLAKEN;

{$INCLUDE CryptoHash.inc}

interface

uses
  chHash.CRC.CRC4.Reverse;

type

{ TchCrc4INTERLAKEN }

  TchCrc4INTERLAKEN = class(TchReverseCrc4)
  public
    constructor Create; reintroduce;
  end;

implementation

uses
  chHash.CRC.CRC4;

{ TchCrc4INTERLAKEN }

constructor TchCrc4INTERLAKEN.Create;
begin
  inherited Create('CRC-4/INTERLAKEN', $3, Bits4Mask, Bits4Mask, $B, False, False);
end;

end.

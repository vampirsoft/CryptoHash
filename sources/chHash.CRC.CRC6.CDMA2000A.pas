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

unit chHash.CRC.CRC6.CDMA2000A;

{$INCLUDE CryptoHash.inc}

interface

uses
  chHash.CRC.CRC6.Reverse;

type

{ TchCrc6CDMA2000A }

  TchCrc6CDMA2000A = class(TchReverseCrc6)
  public
    constructor Create; reintroduce;
  end;

implementation

uses
  chHash.CRC.CRC6;

{ TchCrc6CDMA2000A }

constructor TchCrc6CDMA2000A.Create;
begin
  inherited Create('CRC-6/CDMA2000-A', $27, Bits6Mask, $00, $0D, False, False);
end;

end.

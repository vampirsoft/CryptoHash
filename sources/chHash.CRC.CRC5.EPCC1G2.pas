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

unit chHash.CRC.CRC5.EPCC1G2;

{$INCLUDE CryptoHash.inc}

interface

uses
  chHash.CRC.CRC5.Reverse;

type

{ TchCrc5EPCC1G2 }

  TchCrc5EPCC1G2 = class(TchReverseCrc5)
  public
    constructor Create; reintroduce;
  end;

implementation

{ TchCrc5EPCC1G2 }

constructor TchCrc5EPCC1G2.Create;
begin
  inherited Create('CRC-5/EPC-C1G2', $09, $09, $00, $00, False, False);
  Aliases.Add('CRC-5/EPC');
end;

end.

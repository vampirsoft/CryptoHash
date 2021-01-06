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

unit chHash.CRC.CRC7.MMC;

{$INCLUDE CryptoHash.inc}

interface

uses
  chHash.CRC.CRC7.Reverse;

type

{ TchCrc7MMC }

  TchCrc7MMC = class(TchReverseCrc7)
  public
    constructor Create; reintroduce;
  end;

implementation

{ TchCrc7MMC }

constructor TchCrc7MMC.Create;
begin
  inherited Create('CRC-7/MMC', $09, $00, $00, $75, False, False);
  Aliases.Add('CRC-7');
end;

end.

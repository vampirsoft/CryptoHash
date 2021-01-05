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

{ TchCrc6GSM }

constructor TchCrc6GSM.Create;
begin
  inherited Create('CRC-6/GSM', $2F, $00, $3F, $13, False, False);
end;

end.

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

unit chHash.CRC.CRC7.UMTS;

{$INCLUDE CryptoHash.inc}

interface

uses
  chHash.CRC.CRC7.Reverse;

type

{ TchCrc7UMTS }

  TchCrc7UMTS = class(TchReverseCrc7)
  public
    constructor Create; reintroduce;
  end;

implementation

{ TchCrc7UMTS }

constructor TchCrc7UMTS.Create;
begin
  inherited Create('CRC-7/UMTS', $45, $00, $00, $61, False, False);
end;

end.

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

unit chHash.CRC.CRC10.GSM;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC10.Impl,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.CRC10;

type

{ TchCrc10GSM }

  TchCrc10GSM = class({$IF DEFINED(SUPPORTS_INTERFACES)}chHash.CRC.CRC10.Impl{$ELSE}chHash.CRC.CRC10{$ENDIF}.TchCrc10)
  public
    constructor Create; reintroduce;
  end;

implementation

{ TchCrc10GSM }

constructor TchCrc10GSM.Create;
begin
  inherited Create('CRC-10/GSM', $175, $000, Bits10Mask, $12A, False, False);
end;

end.

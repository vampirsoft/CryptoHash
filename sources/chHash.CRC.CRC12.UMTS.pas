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

unit chHash.CRC.CRC12.UMTS;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC12.Impl;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC.CRC12;
{$ENDIF ~ SUPPORTS_INTERFACES}

type

{ TchCrc12UMTS }

  TchCrc12UMTS = class({$IF DEFINED(SUPPORTS_INTERFACES)}chHash.CRC.CRC12.Impl{$ELSE}chHash.CRC.CRC12{$ENDIF}.TchCrc12)
  public
    constructor Create; reintroduce;
  end;

implementation

{ TchCrc12UMTS }

constructor TchCrc12UMTS.Create;
begin
  inherited Create('CRC-12/UMTS', $80F, $000, $000, $DAF, False, True);
  Aliases.Add('CRC-12/3GPP');
end;

end.

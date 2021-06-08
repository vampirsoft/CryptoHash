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

unit chHash.CRC.CRC12.DECT;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC12.Impl;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC.CRC12;
{$ENDIF ~ SUPPORTS_INTERFACES}

type

{ TchCrc12DECT }

  TchCrc12DECT = class({$IF DEFINED(SUPPORTS_INTERFACES)}chHash.CRC.CRC12.Impl{$ELSE}chHash.CRC.CRC12{$ENDIF}.TchCrc12)
  public
    constructor Create; reintroduce;
  end;

implementation

{ TchCrc12DECT }

constructor TchCrc12DECT.Create;
begin
  inherited Create('CRC-12/DECT', $80F, $000, $000, $F5B, False, False);
  Aliases.Add('X-CRC-12');
end;

end.

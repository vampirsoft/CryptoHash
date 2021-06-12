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

unit chHash.CRC.CRC11.UMTS;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC11.Impl,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.CRC11;

type

{ TchCrc11UMTS }

  TchCrc11UMTS = class({$IF DEFINED(SUPPORTS_INTERFACES)}chHash.CRC.CRC11.Impl{$ELSE}chHash.CRC.CRC11{$ENDIF}.TchCrc11)
  public
    constructor Create; reintroduce;
  end;

implementation

{ TchCrc11UMTS }

constructor TchCrc11UMTS.Create;
begin
  inherited Create('CRC-11/UMTS', $307, $000, $000, $061, False, False);
end;

end.

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

unit chHash.CRC.CRC14.DARC;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC14.Impl;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC.CRC14;
{$ENDIF ~ SUPPORTS_INTERFACES}

type

{ TchCrc14DARC }

  TchCrc14DARC = class({$IF DEFINED(SUPPORTS_INTERFACES)}chHash.CRC.CRC14.Impl{$ELSE}chHash.CRC.CRC14{$ENDIF}.TchCrc14)
  public
    constructor Create; reintroduce;
  end;

implementation

{ TchCrc14DARC }

constructor TchCrc14DARC.Create;
begin
  inherited Create('CRC-14/DARC', $0805, $0000, $0000, $082D, True, True);
end;

end.

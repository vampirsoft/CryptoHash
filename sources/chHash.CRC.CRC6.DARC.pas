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

unit chHash.CRC.CRC6.DARC;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC6.Impl;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC.CRC6;
{$ENDIF ~ SUPPORTS_INTERFACES}

type

{ TchCrc6DARC }

  TchCrc6DARC = class({$IF DEFINED(SUPPORTS_INTERFACES)}chHash.CRC.CRC6.Impl{$ELSE}chHash.CRC.CRC6{$ENDIF}.TchCrc6)
  public
    constructor Create; reintroduce;
  end;

implementation

{ TchCrc6DARC }

constructor TchCrc6DARC.Create;
begin
  inherited Create('CRC-6/DARC', $19, $00, $00, $26, True, True);
end;

end.

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

unit chHash.CRC.CRC6.G704;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC6.Impl;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC.CRC6;
{$ENDIF ~ SUPPORTS_INTERFACES}

type

{ TchCrc6G704 }

  TchCrc6G704 = class({$IF DEFINED(SUPPORTS_INTERFACES)}chHash.CRC.CRC6.Impl{$ELSE}chHash.CRC.CRC6{$ENDIF}.TchCrc6)
  public
    constructor Create; reintroduce;
  end;

implementation

{ TchCrc6G704 }

constructor TchCrc6G704.Create;
begin
  inherited Create('CRC-6/G-704', $03, $00, $00, $06, True, True);
  Aliases.Add('CRC-6/ITU');
end;

end.

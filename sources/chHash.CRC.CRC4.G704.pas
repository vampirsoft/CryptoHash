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

unit chHash.CRC.CRC4.G704;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC4.Impl;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC.CRC4;
{$ENDIF ~ SUPPORTS_INTERFACES}

type

{ TchCrc4G704 }

  TchCrc4G704 = class({$IF DEFINED(SUPPORTS_INTERFACES)}chHash.CRC.CRC4.Impl{$ELSE}chHash.CRC.CRC4{$ENDIF}.TchCrc4)
  public
    constructor Create; reintroduce;
  end;

implementation

{ TchCrc4G704 }

constructor TchCrc4G704.Create;
begin
  inherited Create('CRC-4/G-704', $3, $0, $0, $7, True, True);
  Aliases.Add('CRC-4/ITU');
end;

end.

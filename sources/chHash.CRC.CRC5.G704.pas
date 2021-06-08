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

unit chHash.CRC.CRC5.G704;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC5.Impl;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC.CRC5;
{$ENDIF ~ SUPPORTS_INTERFACES}

type

{ TchCrc5G704 }

  TchCrc5G704 = class({$IF DEFINED(SUPPORTS_INTERFACES)}chHash.CRC.CRC5.Impl{$ELSE}chHash.CRC.CRC5{$ENDIF}.TchCrc5)
  public
    constructor Create; reintroduce;
  end;

implementation

{ TchCrc5G704 }

constructor TchCrc5G704.Create;
begin
  inherited Create('CRC-5/G-704', $15, $00, $00, $07, True, True);
  Aliases.Add('CRC-5/ITU');
end;

end.

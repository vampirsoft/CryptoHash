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

unit chHash.CRC.CRC10.ATM;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC10.Impl,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.CRC10;

type

{ TchCrc10ATM }

  TchCrc10ATM = class({$IF DEFINED(SUPPORTS_INTERFACES)}chHash.CRC.CRC10.Impl{$ELSE}chHash.CRC.CRC10{$ENDIF}.TchCrc10)
  public
    constructor Create; reintroduce;
  end;

implementation

{ TchCrc10ATM }

constructor TchCrc10ATM.Create;
begin
  inherited Create('CRC-10/ATM', $233, $000, $000, $199, False, False);
  Aliases.Add('CRC-10');
  Aliases.Add('CRC-10/I-610');
end;

end.

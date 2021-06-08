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

unit chHash.CRC.CRC7.ROHC;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC7.Impl,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.CRC7;

type

{ TchCrc7ROHC }

  TchCrc7ROHC = class({$IF DEFINED(SUPPORTS_INTERFACES)}chHash.CRC.CRC7.Impl{$ELSE}chHash.CRC.CRC7{$ENDIF}.TchCrc7)
  public
    constructor Create; reintroduce;
  end;

implementation

{ TchCrc7ROHC }

constructor TchCrc7ROHC.Create;
begin
  inherited Create('CRC-7/ROHC', $4F, Bits7Mask, $00, $53, True, True);
end;

end.

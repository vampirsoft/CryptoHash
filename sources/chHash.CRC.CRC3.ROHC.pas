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

unit chHash.CRC.CRC3.ROHC;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC3.Impl,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.CRC3;

type

{ TchCrc3ROHC }

  TchCrc3ROHC = class({$IF DEFINED(SUPPORTS_INTERFACES)}chHash.CRC.CRC3.Impl{$ELSE}chHash.CRC.CRC3{$ENDIF}.TchCrc3)
  public
    constructor Create; reintroduce;
  end;

implementation

{ TchCrc3ROHC }

constructor TchCrc3ROHC.Create;
begin
  inherited Create('CRC-3/ROHC', $3, Bits3Mask, $0, $6, True, True);
end;

end.

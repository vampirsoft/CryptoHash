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

unit chHash.CRC.CRC17.CANFD;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC17.Impl,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.CRC17;

type

{ TchCrc17CANFD }

  TchCrc17CANFD = class({$IF DEFINED(SUPPORTS_INTERFACES)}chHash.CRC.CRC17.Impl{$ELSE}chHash.CRC.CRC17{$ENDIF}.TchCrc17)
  public
    constructor Create; reintroduce;
  end;

implementation

{ TchCrc17CANFD }

constructor TchCrc17CANFD.Create;
begin
  inherited Create('CRC-17/CAN-FD', $1685B, $00000, $0000, $04F03, False, False);
end;

end.

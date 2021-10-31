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

unit chHash.CRC.CRC21.CANFD;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC21.Impl,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.CRC21;

type

{ TchCrc21CANFD }

  TchCrc21CANFD = class({$IF DEFINED(SUPPORTS_INTERFACES)}chHash.CRC.CRC21.Impl{$ELSE}chHash.CRC.CRC21{$ENDIF}.TchCrc21)
  public
    constructor Create; reintroduce;
  end;

implementation

{ TchCrc21CANFD }

constructor TchCrc21CANFD.Create;
begin
  inherited Create('CRC-21/CAN-FD', $102899, $000000, $000000, $0ED841, False, False);
end;

end.

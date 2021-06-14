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

unit chHash.CRC.CRC13.BBC;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC13.Impl,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.CRC13;

type

{ TchCrc13BBC }

  TchCrc13BBC = class({$IF DEFINED(SUPPORTS_INTERFACES)}chHash.CRC.CRC13.Impl{$ELSE}chHash.CRC.CRC13{$ENDIF}.TchCrc13)
  public
    constructor Create; reintroduce;
  end;

implementation

{ TchCrc13BBC }

constructor TchCrc13BBC.Create;
begin
  inherited Create('CRC-13/BBC', $1CF5, $0000, $0000, $04FA, False, False);
end;

end.

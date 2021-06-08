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

unit chHash.CRC.CRC32.XFER;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC32.Impl;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC.CRC32;
{$ENDIF ~ SUPPORTS_INTERFACES}

type

{ TchCrc32XFER }

  TchCrc32XFER = class({$IF DEFINED(SUPPORTS_INTERFACES)}chHash.CRC.CRC32.Impl{$ELSE}chHash.CRC.CRC32{$ENDIF}.TchCrc32)
  public
    constructor Create; reintroduce;
  end;

implementation

{ TchCrc32XFER }

constructor TchCrc32XFER.Create;
begin
  inherited Create('CRC-32/XFER', $000000AF, $00000000, $00000000, $BD0BE338, False, False);
  Aliases.Add('XFER');
end;

end.

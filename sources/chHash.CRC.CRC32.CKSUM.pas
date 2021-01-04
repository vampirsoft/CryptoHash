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

unit chHash.CRC.CRC32.CKSUM;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC32.Impl;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC.CRC32;
{$ENDIF ~ SUPPORTS_INTERFACES}

type

{ TchCrc32CKSUM }

  TchCrc32CKSUM = class({$IF DEFINED(SUPPORTS_INTERFACES)}chHash.CRC.CRC32.Impl{$ELSE}chHash.CRC.CRC32{$ENDIF}.TchCrc32)
  public
    constructor Create; reintroduce;
  end;

implementation

uses
{$IF DEFINED(USE_JEDI_CORE_LIBRARY)}
  JclLogic;
{$ELSE ~ NOT USE_JEDI_CORE_LIBRARY}
  chHash.Core.Bits;
{$ENDIF ~ USE_JEDI_CORE_LIBRARY}

{ TchCrc32CKSUM }

constructor TchCrc32CKSUM.Create;
begin
  inherited Create('CRC-32/CKSUM', $04C11DB7, $00000000, CardinalMask, $765E7680, False, False);
  Aliases.Add('CKSUM');
  Aliases.Add('CRC-32/POSIX');
end;

end.

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

unit chHash.CRC.CRC32.AUTOSAR;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC32.Impl;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC.CRC32;
{$ENDIF ~ SUPPORTS_INTERFACES}

type

{ TchCrc32AUTOSAR }

  TchCrc32AUTOSAR =
    class({$IF DEFINED(SUPPORTS_INTERFACES)}chHash.CRC.CRC32.Impl{$ELSE}chHash.CRC.CRC32{$ENDIF}.TchCrc32)
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

{ TchCrc32AUTOSAR }

constructor TchCrc32AUTOSAR.Create;
begin
  inherited Create('CRC-32/AUTOSAR', $F4ACFB13, CardinalMask, CardinalMask, $1697D06A, True, True);
end;

end.

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

unit chHash.CRC.CRC32.PKZIP;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC32.Impl;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC.CRC32;
{$ENDIF ~ SUPPORTS_INTERFACES}

type

{ TchCrc32 }

  TchCrc32 = class({$IF DEFINED(SUPPORTS_INTERFACES)}chHash.CRC.CRC32.Impl{$ELSE}chHash.CRC.CRC32{$ENDIF}.TchCrc32)
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

{ TchCrc32Algorithm }

constructor TchCrc32.Create;
begin
  inherited Create('CRC-32', $04C11DB7, CardinalMask, CardinalMask, $CBF43926, True, True);
  Aliases.Add('CRC-32/ISO-HDLC');
  Aliases.Add('CRC-32/ADCCP');
  Aliases.Add('CRC-32/V-42');
  Aliases.Add('CRC-32/XZ');
  Aliases.Add('PKZIP');
end;

end.

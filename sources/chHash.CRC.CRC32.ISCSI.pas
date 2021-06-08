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

unit chHash.CRC.CRC32.ISCSI;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC32.Impl;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC.CRC32;
{$ENDIF ~ SUPPORTS_INTERFACES}

type

{ TchCrc32ISCSI }

  TchCrc32ISCSI = class({$IF DEFINED(SUPPORTS_INTERFACES)}chHash.CRC.CRC32.Impl{$ELSE}chHash.CRC.CRC32{$ENDIF}.TchCrc32)
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

{ TchCrc32ISCSI }

constructor TchCrc32ISCSI.Create;
begin
  inherited Create('CRC-32/ISCSI', $1EDC6F41, CardinalMask, CardinalMask, $E3069283, True, True);
  Aliases.Add('CRC-32/BASE91-C');
  Aliases.Add('CRC-32/CASTAGNOLI');
  Aliases.Add('CRC-32/INTERLAKEN');
  Aliases.Add('CRC-32C');
end;

end.

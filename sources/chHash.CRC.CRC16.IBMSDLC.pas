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

unit chHash.CRC.CRC16.IBMSDLC;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC16.Impl;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC.CRC16;
{$ENDIF ~ SUPPORTS_INTERFACES}

type

{ TchCrc16IBMSDLC }

  TchCrc16IBMSDLC =
    class({$IF DEFINED(SUPPORTS_INTERFACES)}chHash.CRC.CRC16.Impl{$ELSE}chHash.CRC.CRC16{$ENDIF}.TchCrc16)
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

{ TchCrc16IBMSDLC }

constructor TchCrc16IBMSDLC.Create;
begin
  inherited Create('CRC-16/IBM-SDLC', $1021, WordMask, WordMask, $906E, True, True);
  Aliases.Add('CRC-16/ISO-HDLC');
  Aliases.Add('CRC-16/ISO-IEC-14443-3-B');
  Aliases.Add('CRC-16/X-25');
  Aliases.Add('CRC-B');
  Aliases.Add('X-25');
end;

end.

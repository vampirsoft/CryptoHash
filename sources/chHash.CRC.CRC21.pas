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

unit chHash.CRC.CRC21;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC.CRC21.Impl;
{$ENDIF ~ SUPPORTS_INTERFACES}

type
{$IF DEFINED(SUPPORTS_INTERFACES)}
  IchCrc21 = interface(IchCrc<Cardinal>)
    ['{C75D159D-0480-4540-91CE-162EA30E9B03}']
  end;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  TchCrc21 = chHash.CRC.CRC21.Impl.TchCrc21;
{$ENDIF ~ SUPPORTS_INTERFACES}

const
  Bits21Mask = Cardinal($1FFFFF);

implementation

end.

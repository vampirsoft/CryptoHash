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

unit chHash.CRC.CRC17;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC.CRC17.Impl;
{$ENDIF ~ SUPPORTS_INTERFACES}

type
{$IF DEFINED(SUPPORTS_INTERFACES)}
  IchCrc17 = interface(IchCrc<Cardinal>)
    ['{118ADE9F-5861-4E28-8934-676050BF2FFF}']
  end;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  TchCrc17 = chHash.CRC.CRC17.Impl.TchCrc17;
{$ENDIF ~ SUPPORTS_INTERFACES}

const
  Bits17Mask = Cardinal($1FFFF);

implementation

end.

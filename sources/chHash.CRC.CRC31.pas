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

unit chHash.CRC.CRC31;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC.CRC31.Impl;
{$ENDIF ~ SUPPORTS_INTERFACES}

type
{$IF DEFINED(SUPPORTS_INTERFACES)}
  IchCrc31 = interface(IchCrc<Cardinal>)
    ['{C360F519-FCE5-4377-BDBC-3F3BB8CF7AA5}']
  end;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  TchCrc31 = chHash.CRC.CRC31.Impl.TchCrc31;
{$ENDIF ~ SUPPORTS_INTERFACES}

const
  Bits31Mask = Cardinal($7FFFFFFF);

implementation

end.

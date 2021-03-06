﻿/////////////////////////////////////////////////////////////////////////////////
//*****************************************************************************//
//* Project      : CryptoHash                                                 *//
//* Latest Source: https://github.com/vampirsoft/CryptoHash                   *//
//* Unit Name    : CryptoHash.inc                                             *//
//* Author       : Сергей (LordVampir) Дворников                              *//
//* Copyright 2021 LordVampir (https://github.com/vampirsoft)                 *//
//* Licensed under MIT                                                        *//
//*****************************************************************************//
/////////////////////////////////////////////////////////////////////////////////

unit chHash.CRC.CRC4;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC.CRC4.Impl;
{$ENDIF ~ SUPPORTS_INTERFACES}

type
{$IF DEFINED(SUPPORTS_INTERFACES)}
  IchCrc4 = interface(IchCrc<Byte>)
    ['{22D7801F-51AE-4787-83C3-93D246D3F79B}']
  end;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  TchCrc4 = chHash.CRC.CRC4.Impl.TchCrc4;
{$ENDIF ~ SUPPORTS_INTERFACES}

const
  Bits4Mask = Byte($F);

implementation

end.

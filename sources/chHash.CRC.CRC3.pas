/////////////////////////////////////////////////////////////////////////////////
//*****************************************************************************//
//* Project      : CryptoHash                                                 *//
//* Latest Source: https://github.com/vampirsoft/CryptoHash                   *//
//* Unit Name    : CryptoHash.inc                                             *//
//* Author       : Сергей (LordVampir) Дворников                              *//
//* Copyright 2019 LordVampir (https://github.com/vampirsoft)                 *//
//* Licensed under the Apache License, Version 2.0                            *//
//*****************************************************************************//
/////////////////////////////////////////////////////////////////////////////////

unit chHash.CRC.CRC3;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC.CRC3.Impl;
{$ENDIF ~ SUPPORTS_INTERFACES}

type
{$IF DEFINED(SUPPORTS_INTERFACES)}
  IchCrc3 = interface(IchCrc<Byte>)
    ['{590AA9C8-EF54-4445-94A5-58011649D081}']
  end;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  TchCrc3 = chHash.CRC.CRC3.Impl.TchCrc3;
{$ENDIF ~ SUPPORTS_INTERFACES}

const
  Bits3Mask = Byte($7);

implementation

end.

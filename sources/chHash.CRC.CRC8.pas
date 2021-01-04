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

unit chHash.CRC.CRC8;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC.CRC8.Impl;
{$ENDIF ~ SUPPORTS_INTERFACES}

type
{$IF DEFINED(SUPPORTS_INTERFACES)}
  IchCrc8 = interface(IchCrc<Byte>)
    ['{5CFBE9BC-2A8A-4746-9ABE-117BC9E846BA}']
  end;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  TchCrc8 = chHash.CRC.CRC8.Impl.TchCrc8;
{$ENDIF ~ SUPPORTS_INTERFACES}

implementation

end.

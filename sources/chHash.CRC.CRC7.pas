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

unit chHash.CRC.CRC7;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC.CRC7.Impl;
{$ENDIF ~ SUPPORTS_INTERFACES}

type
{$IF DEFINED(SUPPORTS_INTERFACES)}
  IchCrc7 = interface(IchCrc<Byte>)
    ['{AC6EA4D5-E3AC-483C-9E2B-9F629561DC1C}']
  end;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  TchCrc7 = chHash.CRC.CRC7.Impl.TchCrc7;
{$ENDIF ~ SUPPORTS_INTERFACES}

const
  Bits7Mask = Byte($7F);

implementation

end.

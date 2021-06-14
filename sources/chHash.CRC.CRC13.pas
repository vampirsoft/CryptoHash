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

unit chHash.CRC.CRC13;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC.CRC13.Impl;
{$ENDIF ~ SUPPORTS_INTERFACES}

type
{$IF DEFINED(SUPPORTS_INTERFACES)}
  IchCrc13 = interface(IchCrc<Word>)
    ['{1F175589-5E16-4596-871A-8B7424E30731}']
  end;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  TchCrc13 = chHash.CRC.CRC13.Impl.TchCrc13;
{$ENDIF ~ SUPPORTS_INTERFACES}

const
  Bits12Mask = Word($1FFF);

implementation

end.

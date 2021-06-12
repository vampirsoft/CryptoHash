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

unit chHash.CRC.CRC11;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC.CRC11.Impl;
{$ENDIF ~ SUPPORTS_INTERFACES}

type
{$IF DEFINED(SUPPORTS_INTERFACES)}
  IchCrc11 = interface(IchCrc<Word>)
    ['{E6ADB11F-1F4C-4321-9EB4-CC9EFE38D058}']
  end;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  TchCrc11 = chHash.CRC.CRC11.Impl.TchCrc11;
{$ENDIF ~ SUPPORTS_INTERFACES}

const
  Bits10Mask = Word($7FF);

implementation

end.

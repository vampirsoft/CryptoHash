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

unit chHash.CRC.CRC14;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC.CRC14.Impl;
{$ENDIF ~ SUPPORTS_INTERFACES}

type
{$IF DEFINED(SUPPORTS_INTERFACES)}
  IchCrc14 = interface(IchCrc<Word>)
    ['{DD51705D-5C7C-4B82-BBCF-F2A8B5CE3FDD}']
  end;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  TchCrc14 = chHash.CRC.CRC14.Impl.TchCrc14;
{$ENDIF ~ SUPPORTS_INTERFACES}

const
  Bits14Mask = Word($3FFF);

implementation

end.

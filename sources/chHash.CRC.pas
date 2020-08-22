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

unit chHash.CRC;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  System.Generics.Collections,
  chHash;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC.Impl;
{$ENDIF ~ SUPPORTS_INTERFACES}

type
{$IF DEFINED(SUPPORTS_INTERFACES)}
  IchCrcAlgorithm<Bits> = interface(IchAlgorithm<Bits, Bits>)
    ['{F6432F50-8DE2-42AD-B67B-858C9EC7A1FA}']
    function Combine(const LeftCrc, RightCrc: Bits; const RightLength: Cardinal): Bits;
    function Width: Byte;
    function Polynomial: Bits;
    function XorOut: Bits;
    function RefIn: Boolean;
    function RefOut: Boolean;
    function Aliases: TList<string>;
  end;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  TchCrcAlgorithm<Bits> = class abstract(chHash.CRC.Impl.TchCrcAlgorithm<Bits>)
  end;
{$ENDIF ~ SUPPORTS_INTERFACES}

implementation

end.

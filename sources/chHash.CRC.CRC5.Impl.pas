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

unit chHash.CRC.CRC5.Impl;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC5,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.CRC8Bits;

type

{ TchCrc5 }

  TchCrc5 = class(TchCrc8Bits{$IF DEFINED(SUPPORTS_INTERFACES)}, IchCrc5{$ENDIF})
  strict protected const
    Size = Byte(5);
  strict protected
    constructor Create(const Name: string; const Polynomial, Init, XorOut, Check: Word;
      const RefIn, RefOut: Boolean); reintroduce;
  end;

implementation

{ TchCrc5 }

constructor TchCrc5.Create(const Name: string; const Polynomial, Init, XorOut, Check: Word;
  const RefIn, RefOut: Boolean);
begin
  inherited Create(Name, TchCrc5.Size, Polynomial, Init, XorOut, Check, RefIn, RefOut);
end;

end.

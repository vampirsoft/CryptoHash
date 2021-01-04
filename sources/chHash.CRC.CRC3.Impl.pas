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

unit chHash.CRC.CRC3.Impl;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC3,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.CRC8Bits;

type

{ TchCrc3 }

  TchCrc3 = class(TchCrc8Bits{$IF DEFINED(SUPPORTS_INTERFACES)}, IchCrc3{$ENDIF})
  strict protected const
    Size = Byte(3);
  strict protected
    constructor Create(const Name: string; const Polynomial, Init, XorOut, Check: Byte;
      const RefIn, RefOut: Boolean); reintroduce;
  end;

implementation

{ TchCrc3 }

constructor TchCrc3.Create(const Name: string; const Polynomial, Init, XorOut, Check: Byte;
  const RefIn, RefOut: Boolean);
begin
  inherited Create(Name, TchCrc3.Size, Polynomial, Init, XorOut, Check, RefIn, RefOut);
end;

end.

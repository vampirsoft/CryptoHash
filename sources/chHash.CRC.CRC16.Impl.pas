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

unit chHash.CRC.CRC16.Impl;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC16,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.CRC16Bits;

type

{ TchCrc16 }

  TchCrc16 = class(TchCrc16Bits{$IF DEFINED(SUPPORTS_INTERFACES)}, IchCrc16{$ENDIF})
  strict private const
    Size = Byte(16);
  strict protected
    constructor Create(const Name: string; const Polynomial, Init, XorOut, Check: Word;
      const RefIn, RefOut: Boolean); reintroduce;
  end;

implementation

{ TchCrc16 }

constructor TchCrc16.Create(const Name: string; const Polynomial, Init, XorOut, Check: Word;
  const RefIn, RefOut: Boolean);
begin
  inherited Create(Name, TchCrc16.Size, Polynomial, Init, XorOut, Check, RefIn, RefOut);
end;

end.

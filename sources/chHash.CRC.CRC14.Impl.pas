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

unit chHash.CRC.CRC14.Impl;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC14,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.CRC16Bits;

type

{ TchCrc14 }

  TchCrc14 = class(TchCrc16Bits{$IF DEFINED(SUPPORTS_INTERFACES)}, IchCrc14{$ENDIF})
  strict protected const
    Size = Byte(14);
  strict protected
    constructor Create(const Name: string; const Polynomial, Init, XorOut, Check: Word;
      const RefIn, RefOut: Boolean); reintroduce;
  end;

implementation

{ TchCrc14 }

constructor TchCrc14.Create(const Name: string; const Polynomial, Init, XorOut, Check: Word;
  const RefIn, RefOut: Boolean);
begin
  inherited Create(Name, TchCrc14.Size, Polynomial, Init, XorOut, Check, RefIn, RefOut);
end;

end.

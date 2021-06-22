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

unit chHash.CRC.CRC6.Impl;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC6,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.CRC8Bits;

type

{ TchCrc6 }

  TchCrc6 = class(TchCrc8Bits{$IF DEFINED(SUPPORTS_INTERFACES)}, IchCrc6{$ENDIF})
  strict protected const
    Size = Byte(6);
  strict protected
    constructor Create(const Name: string; const Polynomial, Init, XorOut, Check: Byte;
      const RefIn, RefOut: Boolean); reintroduce;
  end;

implementation

{ TchCrc6 }

constructor TchCrc6.Create(const Name: string; const Polynomial, Init, XorOut, Check: Byte;
  const RefIn, RefOut: Boolean);
begin
  inherited Create(Name, TchCrc6.Size, Polynomial, Init, XorOut, Check, RefIn, RefOut);
end;

end.

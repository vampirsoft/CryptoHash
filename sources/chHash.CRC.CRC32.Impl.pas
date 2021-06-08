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

unit chHash.CRC.CRC32.Impl;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC32,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.CRC32Bits;

type

{ TchCrc32 }

  TchCrc32 = class(TchCrc32Bits{$IF DEFINED(SUPPORTS_INTERFACES)}, IchCrc32{$ENDIF})
  strict private const
    Size = Byte(32);
  strict protected
    constructor Create(const Name: string; const Polynomial, Init, XorOut, Check: Cardinal;
      const RefIn, RefOut: Boolean); reintroduce;
  end;

implementation

{ TchCrc32 }

constructor TchCrc32.Create(const Name: string; const Polynomial, Init, XorOut, Check: Cardinal;
  const RefIn, RefOut: Boolean);
begin
  inherited Create(Name, TchCrc32.Size, Polynomial, Init, XorOut, Check, RefIn, RefOut);
end;

end.

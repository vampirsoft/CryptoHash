﻿/////////////////////////////////////////////////////////////////////////////////
//*****************************************************************************//
//* Project      : CryptoHash                                                 *//
//* Latest Source: https://github.com/vampirsoft/CryptoHash                   *//
//* Unit Name    : CryptoHash.inc                                             *//
//* Author       : Сергей (LordVampir) Дворников                              *//
//* Copyright 2021 LordVampir (https://github.com/vampirsoft)                 *//
//* Licensed under MIT                                                        *//
//*****************************************************************************//
/////////////////////////////////////////////////////////////////////////////////

unit chHash.CRC.CRC15.Impl;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC15,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.CRC16Bits;

type

{ TchCrc15 }

  TchCrc15 = class(TchCrc16Bits{$IF DEFINED(SUPPORTS_INTERFACES)}, IchCrc15{$ENDIF})
  strict private const
    Size = Byte(15);
  strict protected
    constructor Create(const Name: string; const Polynomial, Init, XorOut, Check: Word;
      const RefIn, RefOut: Boolean); reintroduce;
  public
    procedure Calculate(var Current: Word; const Data: Pointer; const Length: Cardinal); override;
    function Final(const Current: Word): Word; override;
  end;

implementation

uses
{$IF DEFINED(USE_JEDI_CORE_LIBRARY)}
  JclLogic;
{$ELSE ~ NOT USE_JEDI_CORE_LIBRARY}
  chHash.Core.Bits;
{$ENDIF ~ USE_JEDI_CORE_LIBRARY}

{ TchCrc15 }

constructor TchCrc15.Create(const Name: string; const Polynomial, Init, XorOut, Check: Word;
  const RefIn, RefOut: Boolean);
begin
  inherited Create(Name, TchCrc15.Size, Polynomial, Init, XorOut, Check, RefIn, RefOut);
end;

procedure TchCrc15.Calculate(var Current: Word; const Data: Pointer; const Length: Cardinal);
const
  SizeOfBits  = Byte(SizeOf(Word));
  BitsPerBits = Byte(SizeOfBits * BitsPerByte);
  ShiftToBits = Byte(BitsPerBits - TchCrc15.Size);

begin
  Current := Current shl ShiftToBits;
  ReverseBytes(@Current, SizeOfBits);
  inherited Calculate(Current, Data, Length);
  ReverseBytes(@Current, SizeOfBits);
  Current := Current shr ShiftToBits;
end;

function TchCrc15.Final(const Current: Word): Word;
const
  SizeOfBits  = Byte(SizeOf(Word));
  BitsPerBits = Byte(SizeOfBits * BitsPerByte);
  ShiftToBits = Byte(BitsPerBits - TchCrc15.Size);

begin
  Result := Current shl ShiftToBits;
  ReverseBytes(@Result, SizeOfBits);
  Result := inherited Final(Result);
end;

end.

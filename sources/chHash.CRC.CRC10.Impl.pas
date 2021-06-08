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

unit chHash.CRC.CRC10.Impl;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC10,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.CRC16Bits;

type

{ TchCrc10 }

  TchCrc10 = class(TchCrc16Bits{$IF DEFINED(SUPPORTS_INTERFACES)}, IchCrc10{$ENDIF})
  strict private const
    Size = Byte(10);
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

{ TchCrc10 }

constructor TchCrc10.Create(const Name: string; const Polynomial, Init, XorOut, Check: Word;
  const RefIn, RefOut: Boolean);
begin
  inherited Create(Name, TchCrc10.Size, Polynomial, Init, XorOut, Check, RefIn, RefOut);
end;

procedure TchCrc10.Calculate(var Current: Word; const Data: Pointer; const Length: Cardinal);
const
  SizeOfBits  = Byte(SizeOf(Word));
  BitsPerBits = Byte(SizeOfBits * BitsPerByte);
  ShiftToBits = Byte(BitsPerBits - TchCrc10.Size);

begin
  Current := Current shl ShiftToBits;
  ReverseBytes(@Current, SizeOfBits);
  inherited Calculate(Current, Data, Length);
  ReverseBytes(@Current, SizeOfBits);
  Current := Current shr ShiftToBits;
end;

function TchCrc10.Final(const Current: Word): Word;
const
  SizeOfBits  = Byte(SizeOf(Word));
  BitsPerBits = Byte(SizeOfBits * BitsPerByte);
  ShiftToBits = Byte(BitsPerBits - TchCrc10.Size);

begin
  Result := Current shl ShiftToBits;
  ReverseBytes(@Result, SizeOfBits);
  Result := inherited Final(Result);
end;

end.

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

unit chHash.CRC.CRC14.Reverse;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC14.Impl;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC.CRC14;
{$ENDIF ~ SUPPORTS_INTERFACES}

type

{ TchReverseCrc14 }

  TchReverseCrc14 = class(TchCrc14)
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

{ TchReverseCrc14 }

procedure TchReverseCrc14.Calculate(var Current: Word; const Data: Pointer; const Length: Cardinal);
const
  SizeOfBits  = Byte(SizeOf(Word));
  BitsPerBits = Byte(SizeOfBits * BitsPerByte);
  ShiftToBits = Byte(BitsPerBits - TchCrc14.Size);

begin
  Current := Current shl ShiftToBits;
  ReverseBytes(@Current, SizeOfBits);
  inherited Calculate(Current, Data, Length);
  ReverseBytes(@Current, SizeOfBits);
  Current := Current shr ShiftToBits;
end;

function TchReverseCrc14.Final(const Current: Word): Word;
const
  SizeOfBits  = Byte(SizeOf(Word));
  BitsPerBits = Byte(SizeOfBits * BitsPerByte);
  ShiftToBits = Byte(BitsPerBits - TchCrc14.Size);

begin
  Result := Current shl ShiftToBits;
  ReverseBytes(@Result, SizeOfBits);
  Result := inherited Final(Result);
end;

end.

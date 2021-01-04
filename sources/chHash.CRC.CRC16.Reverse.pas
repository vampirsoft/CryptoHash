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

unit chHash.CRC.CRC16.Reverse;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC16.Impl;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC.CRC16;
{$ENDIF ~ SUPPORTS_INTERFACES}

type

{ TchReverseCrc16 }

  TchReverseCrc16 = class(TchCrc16)
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

{ TchReverseCrc16 }

procedure TchReverseCrc16.Calculate(var Current: Word; const Data: Pointer; const Length: Cardinal);
const
  SizeOfBits = Byte(SizeOf(Word));

begin
  ReverseBytes(@Current, SizeOfBits);
  inherited Calculate(Current, Data, Length);
  ReverseBytes(@Current, SizeOfBits);
end;

function TchReverseCrc16.Final(const Current: Word): Word;
const
  SizeOfBits = Byte(SizeOf(Word));

begin
  Result := Current;
  ReverseBytes(@Result, SizeOfBits);
  Result := inherited Final(Result);
end;

end.

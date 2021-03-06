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

unit chHash.CRC.CRC5.Reverse;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC5.Impl;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC.CRC5;
{$ENDIF ~ SUPPORTS_INTERFACES}

type

{ TchReverseCrc5 }

  TchReverseCrc5 = class(TchCrc5)
  public
    procedure Calculate(var Current: Byte; const Data: Pointer; const Length: Cardinal); override;
    function Final(const Current: Byte): Byte; override;
  end;

implementation

uses
{$IF DEFINED(USE_JEDI_CORE_LIBRARY)}
  JclLogic;
{$ELSE ~ NOT USE_JEDI_CORE_LIBRARY}
  chHash.Core.Bits;
{$ENDIF ~ USE_JEDI_CORE_LIBRARY}

{ TchReverseCrc5 }

procedure TchReverseCrc5.Calculate(var Current: Byte; const Data: Pointer; const Length: Cardinal);
const
  ShiftToBits = Byte(BitsPerByte - TchCrc5.Size);

begin
  Current := Current shl ShiftToBits;
  inherited Calculate(Current, Data, Length);
  Current := Current shr ShiftToBits;
end;

function TchReverseCrc5.Final(const Current: Byte): Byte;
const
  ShiftToBits = Byte(BitsPerByte - TchCrc5.Size);

begin
  Result := inherited Final(Current shl ShiftToBits);
end;

end.

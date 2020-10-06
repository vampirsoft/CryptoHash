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

unit chHash.CRC.CRC3.Reverse;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC3.Impl;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC.CRC3;
{$ENDIF ~ SUPPORTS_INTERFACES}

type

{ TchReverseCrc3 }

  TchReverseCrc3 = class(TchCrc3)
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

{ TchReverseCrc3 }

procedure TchReverseCrc3.Calculate(var Current: Byte; const Data: Pointer; const Length: Cardinal);
const
  ShiftToBits = Byte(BitsPerByte - TchCrc3.Size);

begin
  Current := Current shl ShiftToBits;
  inherited Calculate(Current, Data, Length);
  Current := Current shr ShiftToBits;
end;

function TchReverseCrc3.Final(const Current: Byte): Byte;
const
  ShiftToBits = Byte(BitsPerByte - TchCrc3.Size);

begin
  Result := inherited Final(Current shl ShiftToBits);
end;

end.

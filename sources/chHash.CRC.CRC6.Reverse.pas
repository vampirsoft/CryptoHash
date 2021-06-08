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

unit chHash.CRC.CRC6.Reverse;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC6.Impl;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC.CRC6;
{$ENDIF ~ SUPPORTS_INTERFACES}

type

{ TchReverseCrc6 }

  TchReverseCrc6 = class(TchCrc6)
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

{ TchReverseCrc6 }

procedure TchReverseCrc6.Calculate(var Current: Byte; const Data: Pointer; const Length: Cardinal);
const
  ShiftToBits = Byte(BitsPerByte - TchCrc6.Size);

begin
  Current := Current shl ShiftToBits;
  inherited Calculate(Current, Data, Length);
  Current := Current shr ShiftToBits;
end;

function TchReverseCrc6.Final(const Current: Byte): Byte;
const
  ShiftToBits = Byte(BitsPerByte - TchCrc6.Size);

begin
  Result := inherited Final(Current shl ShiftToBits);
end;

end.

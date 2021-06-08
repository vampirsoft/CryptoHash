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

unit chHash.CRC.CRC31.Impl;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC31,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.CRC32Bits;

type

{ TchCrc31 }

  TchCrc31 = class(TchCrc32Bits{$IF DEFINED(SUPPORTS_INTERFACES)}, IchCrc31{$ENDIF})
  strict private const
    Size = Byte(31);
  strict protected
    constructor Create(const Name: string; const Polynomial, Init, XorOut, Check: Cardinal;
      const RefIn, RefOut: Boolean); reintroduce;
  public
    procedure Calculate(var Current: Cardinal; const Data: Pointer; const Length: Cardinal); override;
    function Final(const Current: Cardinal): Cardinal; override;
  end;

implementation

uses
{$IF DEFINED(USE_JEDI_CORE_LIBRARY)}
  JclLogic;
{$ELSE ~ NOT USE_JEDI_CORE_LIBRARY}
  chHash.Core.Bits;
{$ENDIF ~ USE_JEDI_CORE_LIBRARY}

{ TchCrc31 }

constructor TchCrc31.Create(const Name: string; const Polynomial, Init, XorOut, Check: Cardinal;
  const RefIn, RefOut: Boolean);
begin
  inherited Create(Name, TchCrc31.Size, Polynomial, Init, XorOut, Check, RefIn, RefOut);
end;

procedure TchCrc31.Calculate(var Current: Cardinal; const Data: Pointer; const Length: Cardinal);
const
  ShiftToBits = Byte(SizeOf(Cardinal) * BitsPerByte - TchCrc31.Size);

begin
  Current := ReverseBytes(Current shl ShiftToBits);
  inherited Calculate(Current, Data, Length);
  Current := ReverseBytes(Current) shr ShiftToBits;
end;

function TchCrc31.Final(const Current: Cardinal): Cardinal;
const
  ShiftToBits = Byte(SizeOf(Cardinal) * BitsPerByte - TchCrc31.Size);

begin
  Result := inherited Final(ReverseBytes(Current shl ShiftToBits));
end;

end.

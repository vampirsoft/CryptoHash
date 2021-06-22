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

unit chHash.CRC.CRC16Bits.Tests;

{$INCLUDE CryptoHash.Tests.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC,
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC.CRC16Bits,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.Tests;

type
  TCrc16BitsAlgorithm = {$IF DEFINED(SUPPORTS_INTERFACES)}IchCrc<Word>{$ELSE}TchCrc16Bits{$ENDIF};

{ TchCrc16BitsTests<HA> }

  TchCrc16BitsTests<HA: TCrc16BitsAlgorithm> = class abstract(TchCrcWithMultiTableTests<Word, HA>)
  end;

{ TchCrc16BitsNormalTests<HA> }

  TchCrc16BitsNormalTests<HA: TCrc16BitsAlgorithm> = class abstract(TchCrc16BitsTests<HA>)
  strict protected
    procedure ControlCalculate(var Current: Word; const Data; const Length: Cardinal); override;
  end;

{ TchCrc16BitsReverseTests<HA> }

  TchCrc16BitsReverseTests<HA: TCrc16BitsAlgorithm> = class abstract(TchCrc16BitsTests<HA>)
  strict protected
    procedure ControlCalculate(var Current: Word; const Data; const Length: Cardinal); override;
  end;

implementation

uses
{$IF DEFINED(USE_JEDI_CORE_LIBRARY)}
  JclLogic;
{$ELSE ~ NOT USE_JEDI_CORE_LIBRARY}
  chHash.Core.Bits;
{$ENDIF ~ USE_JEDI_CORE_LIBRARY}

{ TchCrc16BitsNormalTests<HA> }

procedure TchCrc16BitsNormalTests<HA>.ControlCalculate(var Current: Word; const Data; const Length: Cardinal);
begin
  if Length = 0 then Exit;

  const ShiftToWidth = FAlgorithm.Width - BitsPerByte;
  var L := Length;
  var PData: PByte := @Data;
  while L > 0 do
  begin
    Current := (Current shl BitsPerByte) xor FCrcTable[Byte(PData^ xor (Current shr ShiftToWidth))];
    Inc(PData);
    Dec(L);
  end;
end;

{ TchCrc16BitsReverseTests<HA> }

procedure TchCrc16BitsReverseTests<HA>.ControlCalculate(var Current: Word; const Data; const Length: Cardinal);
begin
  if Length = 0 then Exit;

  var L := Length;
  var PData: PByte := @Data;
  while L > 0 do
  begin
    Current := (Current shr BitsPerByte) xor FCrcTable[Byte(PData^ xor Current)];
    Inc(PData);
    Dec(L);
  end;
end;

end.

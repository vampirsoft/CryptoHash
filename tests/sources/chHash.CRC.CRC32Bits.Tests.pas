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

unit chHash.CRC.CRC32Bits.Tests;

{$INCLUDE CryptoHash.Tests.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC,
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.CRC.CRC32Bits,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.Tests;

type
  TCrc32BitsAlgorithm = {$IF DEFINED(SUPPORTS_INTERFACES)}IchCrc<Cardinal>{$ELSE}TchCrc32Bits{$ENDIF};

{ TchCrc32BitsTests<HA> }

  TchCrc32BitsTests<HA: TCrc32BitsAlgorithm> = class abstract(TchCrcWithMultiTableTests<Cardinal, HA>)
  end;

{ TchCrc32BitsNormalTests<HA> }

  TchCrc32BitsNormalTests<HA: TCrc32BitsAlgorithm> = class abstract(TchCrc32BitsTests<HA>)
  strict protected
    procedure ControlCalculate(var Current: Cardinal; const Data; const Length: Cardinal); override;
  end;

{ TchCrc32BitsReverseTests<HA> }

  TchCrc32BitsReverseTests<HA: TCrc32BitsAlgorithm> = class abstract(TchCrc32BitsTests<HA>)
  strict protected
    procedure ControlCalculate(var Current: Cardinal; const Data; const Length: Cardinal); override;
  end;

implementation

uses
{$IF DEFINED(USE_JEDI_CORE_LIBRARY)}
  JclLogic;
{$ELSE ~ NOT USE_JEDI_CORE_LIBRARY}
  chHash.Core.Bits;
{$ENDIF ~ USE_JEDI_CORE_LIBRARY}

{ TchCrc32BitsNormalTests<HA> }

procedure TchCrc32BitsNormalTests<HA>.ControlCalculate(var Current: Cardinal; const Data; const Length: Cardinal);
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

{ TchCrc32BitsReverseTests<HA> }

procedure TchCrc32BitsReverseTests<HA>.ControlCalculate(var Current: Cardinal; const Data; const Length: Cardinal);
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

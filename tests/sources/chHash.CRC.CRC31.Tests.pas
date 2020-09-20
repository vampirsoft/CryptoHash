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

unit chHash.CRC.CRC31.Tests;

{$INCLUDE CryptoHash.Tests.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC31,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.CRC31.Impl,
  chHash.CRC.Tests;

type
  TCrc31Algorithm = {$IF DEFINED(SUPPORTS_INTERFACES)}IchCrc31{$ELSE}TchCrc31{$ENDIF};

{ TchCrc31Tests }

  TchCrc31Tests = class abstract(TchCrcTests<Cardinal, TCrc31Algorithm>)
  strict protected
    function BitsToHex(const Value: Cardinal): string; override;
    function FinalControlCalculate(const Value: Cardinal): Cardinal; override;
    function GetCount: Cardinal; override;
    function GetMaxLength: Cardinal; override;
  end;

{ TchCrc31NormalTests }

  TchCrc31NormalTests = class abstract(TchCrc31Tests)
  strict protected
    procedure ControlCalculate(var Current: Cardinal; const Data; const Length: Cardinal); override;
  end;

{ TchCrc31ReverseTests }

  TchCrc31ReverseTests = class abstract(TchCrc31Tests)
  strict protected
    procedure ControlCalculate(var Current: Cardinal; const Data; const Length: Cardinal); override;
  end;

{ TchCrc31PHILIPSTests }

  TchCrc31PHILIPSTests = class(TchCrc31NormalTests)
  strict protected
    function CreateAlgorithm: TCrc31Algorithm; override;
  end;

implementation

uses
{$IF DEFINED(USE_JEDI_CORE_LIBRARY)}
  JclLogic,
{$ELSE ~ NOT USE_JEDI_CORE_LIBRARY}
  chHash.Core.Bits,
{$ENDIF ~ USE_JEDI_CORE_LIBRARY}
  chHash.CRC.CRC31.PHILIPS.Factory,
  TestFramework,
  System.SysUtils, System.Generics.Collections;

{ TchCrc31Tests }

function TchCrc31Tests.BitsToHex(const Value: Cardinal): string;
begin
  Result := IntToHex(Value);
end;

function TchCrc31Tests.FinalControlCalculate(const Value: Cardinal): Cardinal;
begin
  Result := Value xor FAlgorithm.XorOut;
  Result := Result and (FAlgorithm as TchCrc31).Mask;
end;

function TchCrc31Tests.GetCount: Cardinal;
begin
  Result := 1024 * 16;
//  Result := 1 * 1;
//  Result := 1024 * 1;
end;

function TchCrc31Tests.GetMaxLength: Cardinal;
begin
  Result := $FFFF;
//  Result := $FFFFFFF;
//  Result := $100000
end;

{ TchCrc31NormalTests }

procedure TchCrc31NormalTests.ControlCalculate(var Current: Cardinal; const Data; const Length: Cardinal);
begin
  if Length = 0 then Exit;

  const Shift = FAlgorithm.Width - BitsPerByte;
  var L := Length;
  var PData: PByte := @Data;
  while L > 0 do
  begin
    Current := (Current shl BitsPerByte) xor FCrcTable[Byte(PData^ xor (Current shr Shift))];
    Inc(PData);
    Dec(L);
  end;
end;

{ TchCrc31ReverseTests }

procedure TchCrc31ReverseTests.ControlCalculate(var Current: Cardinal; const Data; const Length: Cardinal);
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

{ TchCrc31PHILIPSTests }

function TchCrc31PHILIPSTests.CreateAlgorithm: TCrc31Algorithm;
begin
  Result := TchCrc31PHILIPS.Instance;
end;

initialization
  RegisterTest(TchCrc31PHILIPSTests.Suite);

end.

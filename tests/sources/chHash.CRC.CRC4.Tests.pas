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

unit chHash.CRC.CRC4.Tests;

{$INCLUDE CryptoHash.Tests.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC4,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.CRC4.Impl,
  chHash.CRC.Tests;

type
  TCrc4Algorithm = {$IF DEFINED(SUPPORTS_INTERFACES)}IchCrc4{$ELSE}TchCrc4{$ENDIF};

{ TchCrc4Tests }

  TchCrc4Tests = class abstract(TchCrcTests<Byte, TCrc4Algorithm>)
  end;

{ TchCrc4NormalTests }

  TchCrc4NormalTests = class abstract(TchCrc4Tests)
  strict protected
    procedure ControlCalculate(var Current: Byte; const Data; const Length: Cardinal); override;
  end;

{ TchCrc4ReverseTests }

  TchCrc4ReverseTests = class abstract(TchCrc4Tests)
  strict protected
    procedure ControlCalculate(var Current: Byte; const Data; const Length: Cardinal); override;
  end;

{ TchCrc4G704Tests }

  TchCrc4G704Tests = class(TchCrc4ReverseTests)
  strict protected
    function CreateAlgorithm: TCrc4Algorithm; override;
  end;

{ TchCrc4INTERLAKENTests }

  TchCrc4INTERLAKENTests = class(TchCrc4NormalTests)
  strict protected
    function CreateAlgorithm: TCrc4Algorithm; override;
  end;

implementation

uses
{$IF DEFINED(USE_JEDI_CORE_LIBRARY)}
  JclLogic,
{$ELSE ~ NOT USE_JEDI_CORE_LIBRARY}
  chHash.Core.Bits,
{$ENDIF ~ USE_JEDI_CORE_LIBRARY}
  chHash.CRC.CRC4.G704.Factory,
  chHash.CRC.CRC4.INTERLAKEN.Factory,
  TestFramework;

{ TchCrc4NormalTests }

procedure TchCrc4NormalTests.ControlCalculate(var Current: Byte; const Data; const Length: Cardinal);
begin
  if Length = 0 then Exit;

  const Shift = BitsPerByte - FAlgorithm.Width;
  var L := Length;
  var PData: PByte := @Data;
  while L > 0 do
  begin
    Current := FCrcTable[Byte(PData^ xor (Current shl Shift))];
    Inc(PData);
    Dec(L);
  end;
end;

{ TchCrc4ReverseTests }

procedure TchCrc4ReverseTests.ControlCalculate(var Current: Byte; const Data; const Length: Cardinal);
begin
  if Length = 0 then Exit;

  var L := Length;
  var PData: PByte := @Data;
  while L > 0 do
  begin
    Current := FCrcTable[Byte(PData^ xor Current)];
    Inc(PData);
    Dec(L);
  end;
end;

{ TchCrc4G704Tests }

function TchCrc4G704Tests.CreateAlgorithm: TCrc4Algorithm;
begin
  Result := TchCrc4G704.Instance;
end;

{ TchCrc4INTERLAKENTests }

function TchCrc4INTERLAKENTests.CreateAlgorithm: TCrc4Algorithm;
begin
  Result := TchCrc4INTERLAKEN.Instance;
end;

initialization
  RegisterTest(TchCrc4G704Tests.Suite);
  RegisterTest(TchCrc4INTERLAKENTests.Suite);

end.

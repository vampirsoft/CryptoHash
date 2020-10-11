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

{ TchCrc4G704Tests }

  TchCrc4G704Tests = class(TchCrc4Tests)
  strict protected
    function CreateAlgorithm: TCrc4Algorithm; override;
  end;

{ TchCrc4INTERLAKENTests }

  TchCrc4INTERLAKENTests = class(TchCrc4Tests)
  strict protected
    function CreateAlgorithm: TCrc4Algorithm; override;
  end;

implementation

uses
  chHash.CRC.CRC4.G704.Factory,
  chHash.CRC.CRC4.INTERLAKEN.Factory,
  TestFramework;

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

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

unit chHash.CRC.CRC32.JAMCRC.Factory;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC32,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.CRC32.JAMCRC;

type

{ TchCrc32JAMCRC }

  TchCrc32JAMCRC = class sealed(chHash.CRC.CRC32.JAMCRC.TchCrc32JAMCRC)
  private type
    TInstance = {$IF DEFINED(SUPPORTS_INTERFACES)}IchCrc32{$ELSE}chHash.CRC.CRC32.JAMCRC.TchCrc32JAMCRC{$ENDIF};
  private
    class var FInstance: TInstance;
  private
    constructor Create; reintroduce;
  public
    class property Instance: TInstance read FInstance;
  end;

implementation

{$IF NOT DEFINED(SUPPORTS_INTERFACES)}
uses
  System.SysUtils;
{$ENDIF ~ NOT SUPPORTS_INTERFACES}

{ TchCrc32JAMCRC }

constructor TchCrc32JAMCRC.Create;
begin
  inherited Create;
end;

initialization
  TchCrc32JAMCRC.FInstance := TchCrc32JAMCRC.Create;

{$IF NOT DEFINED(SUPPORTS_INTERFACES)}
finalization
  FreeAndNil(TchCrc32JAMCRC.FInstance);
{$ENDIF ~ NOT SUPPORTS_INTERFACES}

end.

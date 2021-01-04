/////////////////////////////////////////////////////////////////////////////////
//*****************************************************************************//
//* Project      : CryptoHash                                                 *//
//* Latest Source: https://github.com/vampirsoft/CryptoHash                   *//
//* Unit Name    : CryptoHash.inc                                             *//
//* Author       : Сергей (LordVampir) Дворников                              *//
//* Copyright 2021 LordVampir (https://github.com/vampirsoft)                 *//
//* Licensed under the Apache License, Version 2.0                            *//
//*****************************************************************************//
/////////////////////////////////////////////////////////////////////////////////

unit chHash.CRC.CRC32.AIXM.Factory;

{$INCLUDE CryptoHash.inc}

interface

uses
  chHash.CRC.CRC32,
  chHash.CRC.CRC32.AIXM;

type

{ TchCrc32AIXM }

  TchCrc32AIXM = class sealed(chHash.CRC.CRC32.AIXM.TchCrc32AIXM)
  private type
    TInstance = {$IF DEFINED(SUPPORTS_INTERFACES)}IchCrc32{$ELSE}TchCrc32{$ENDIF};
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

{ TchCrc32AIXM }

constructor TchCrc32AIXM.Create;
begin
  inherited Create;
end;

initialization
  TchCrc32AIXM.FInstance := TchCrc32AIXM.Create;

{$IF NOT DEFINED(SUPPORTS_INTERFACES)}
finalization
  FreeAndNil(TchCrc32AIXM.FInstance);
{$ENDIF ~ NOT SUPPORTS_INTERFACES}

end.

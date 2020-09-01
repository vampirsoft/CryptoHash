﻿/////////////////////////////////////////////////////////////////////////////////
//*****************************************************************************//
//* Project      : CryptoHash                                                 *//
//* Latest Source: https://github.com/vampirsoft/CryptoHash                   *//
//* Unit Name    : CryptoHash.inc                                             *//
//* Author       : Сергей (LordVampir) Дворников                              *//
//* Copyright 2019 LordVampir (https://github.com/vampirsoft)                 *//
//* Licensed under the Apache License, Version 2.0                            *//
//*****************************************************************************//
/////////////////////////////////////////////////////////////////////////////////

unit chHash.CRC.CRC8.GSMB.Factory;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC8,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.CRC8.GSMB;

type

{ TchCrc8GSMB }

  TchCrc8GSMB = class sealed(chHash.CRC.CRC8.GSMB.TchCrc8GSMB)
  private type
    TInstance = {$IF DEFINED(SUPPORTS_INTERFACES)}IchCrc8{$ELSE}chHash.CRC.CRC8.GSMB.TchCrc8GSMB{$ENDIF};
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

{ TchCrc8GSMB }

constructor TchCrc8GSMB.Create;
begin
  inherited Create;
end;

initialization
  TchCrc8GSMB.FInstance := TchCrc8GSMB.Create;

{$IF NOT DEFINED(SUPPORTS_INTERFACES)}
finalization
  FreeAndNil(TchCrc8GSMB.FInstance);
{$ENDIF ~ NOT SUPPORTS_INTERFACES}

end.
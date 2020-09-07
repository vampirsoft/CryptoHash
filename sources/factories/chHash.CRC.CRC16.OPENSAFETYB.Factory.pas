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

unit chHash.CRC.CRC16.OPENSAFETYB.Factory;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC16,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.CRC16.OPENSAFETYB;

type

{ TchCrc16OPENSAFETYB }

  TchCrc16OPENSAFETYB = class sealed(chHash.CRC.CRC16.OPENSAFETYB.TchCrc16OPENSAFETYB)
  private type
    TInstance =
      {$IF DEFINED(SUPPORTS_INTERFACES)}IchCrc16{$ELSE}chHash.CRC.CRC16.OPENSAFETYB.TchCrc16OPENSAFETYB{$ENDIF};
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

{ TchCrc16OPENSAFETYB }

constructor TchCrc16OPENSAFETYB.Create;
begin
  inherited Create;
end;

initialization
  TchCrc16OPENSAFETYB.FInstance := TchCrc16OPENSAFETYB.Create;

{$IF NOT DEFINED(SUPPORTS_INTERFACES)}
finalization
  FreeAndNil(TchCrc16OPENSAFETYB.FInstance);
{$ENDIF ~ NOT SUPPORTS_INTERFACES}

end.

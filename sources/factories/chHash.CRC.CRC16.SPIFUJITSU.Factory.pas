﻿/////////////////////////////////////////////////////////////////////////////////
//*****************************************************************************//
//* Project      : CryptoHash                                                 *//
//* Latest Source: https://github.com/vampirsoft/CryptoHash                   *//
//* Unit Name    : CryptoHash.inc                                             *//
//* Author       : Сергей (LordVampir) Дворников                              *//
//* Copyright 2021 LordVampir (https://github.com/vampirsoft)                 *//
//* Licensed under MIT                                                        *//
//*****************************************************************************//
/////////////////////////////////////////////////////////////////////////////////

unit chHash.CRC.CRC16.SPIFUJITSU.Factory;

{$INCLUDE CryptoHash.inc}

interface

uses
  chHash.CRC.CRC16,
  chHash.CRC.CRC16.SPIFUJITSU;

type

{ TchCrc16SPIFUJITSU }

  TchCrc16SPIFUJITSU = class sealed(chHash.CRC.CRC16.SPIFUJITSU.TchCrc16SPIFUJITSU)
  private type
    TInstance = {$IF DEFINED(SUPPORTS_INTERFACES)}IchCrc16{$ELSE}TchCrc16{$ENDIF};
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

{ TchCrc16SPIFUJITSU }

constructor TchCrc16SPIFUJITSU.Create;
begin
  inherited Create;
end;

initialization
  TchCrc16SPIFUJITSU.FInstance := TchCrc16SPIFUJITSU.Create;

{$IF NOT DEFINED(SUPPORTS_INTERFACES)}
finalization
  FreeAndNil(TchCrc16SPIFUJITSU.FInstance);
{$ENDIF ~ NOT SUPPORTS_INTERFACES}

end.

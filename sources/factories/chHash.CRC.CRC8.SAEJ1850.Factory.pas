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

unit chHash.CRC.CRC8.SAEJ1850.Factory;

{$INCLUDE CryptoHash.inc}

interface

uses
  chHash.CRC.CRC8,
  chHash.CRC.CRC8.SAEJ1850;

type

{ TchCrc8SAEJ1850 }

  TchCrc8SAEJ1850 = class sealed(chHash.CRC.CRC8.SAEJ1850.TchCrc8SAEJ1850)
  private type
    TInstance = {$IF DEFINED(SUPPORTS_INTERFACES)}IchCrc8{$ELSE}TchCrc8{$ENDIF};
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

{ TchCrc8SAEJ1850 }

constructor TchCrc8SAEJ1850.Create;
begin
  inherited Create;
end;

initialization
  TchCrc8SAEJ1850.FInstance := TchCrc8SAEJ1850.Create;

{$IF NOT DEFINED(SUPPORTS_INTERFACES)}
finalization
  FreeAndNil(TchCrc8SAEJ1850.FInstance);
{$ENDIF ~ NOT SUPPORTS_INTERFACES}

end.

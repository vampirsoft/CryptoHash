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

unit chHash.CRC.CRC8.LTE.Factory;

{$INCLUDE CryptoHash.inc}

interface

uses
  chHash.CRC.CRC8,
  chHash.CRC.CRC8.LTE;

type

{ TchCrc8LTE }

  TchCrc8LTE = class sealed(chHash.CRC.CRC8.LTE.TchCrc8LTE)
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

{ TchCrc8LTE }

constructor TchCrc8LTE.Create;
begin
  inherited Create;
end;

initialization
  TchCrc8LTE.FInstance := TchCrc8LTE.Create;

{$IF NOT DEFINED(SUPPORTS_INTERFACES)}
finalization
  FreeAndNil(TchCrc8LTE.FInstance);
{$ENDIF ~ NOT SUPPORTS_INTERFACES}

end.

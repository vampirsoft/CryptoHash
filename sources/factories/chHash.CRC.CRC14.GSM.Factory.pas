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

unit chHash.CRC.CRC14.GSM.Factory;

{$INCLUDE CryptoHash.inc}

interface

uses
  chHash.CRC.CRC14,
  chHash.CRC.CRC14.GSM;

type

{ TchCrc14GSM }

  TchCrc14GSM = class sealed(chHash.CRC.CRC14.GSM.TchCrc14GSM)
  private type
    TInstance = {$IF DEFINED(SUPPORTS_INTERFACES)}IchCrc14{$ELSE}TchCrc14{$ENDIF};
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

{ TchCrc14GSM }

constructor TchCrc14GSM.Create;
begin
  inherited Create;
end;

initialization
  TchCrc14GSM.FInstance := TchCrc14GSM.Create;

{$IF NOT DEFINED(SUPPORTS_INTERFACES)}
finalization
  FreeAndNil(TchCrc14GSM.FInstance);
{$ENDIF ~ NOT SUPPORTS_INTERFACES}

end.

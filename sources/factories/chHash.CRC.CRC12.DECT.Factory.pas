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

unit chHash.CRC.CRC12.DECT.Factory;

{$INCLUDE CryptoHash.inc}

interface

uses
  chHash.CRC.CRC12,
  chHash.CRC.CRC12.DECT;

type

{ TchCrc12DECT }

  TchCrc12DECT = class sealed(chHash.CRC.CRC12.DECT.TchCrc12DECT)
  private type
    TInstance = {$IF DEFINED(SUPPORTS_INTERFACES)}IchCrc12{$ELSE}TchCrc12{$ENDIF};
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

{ TchCrc12DECT }

constructor TchCrc12DECT.Create;
begin
  inherited Create;
end;

initialization
  TchCrc12DECT.FInstance := TchCrc12DECT.Create;

{$IF NOT DEFINED(SUPPORTS_INTERFACES)}
finalization
  FreeAndNil(TchCrc12DECT.FInstance);
{$ENDIF ~ NOT SUPPORTS_INTERFACES}

end.

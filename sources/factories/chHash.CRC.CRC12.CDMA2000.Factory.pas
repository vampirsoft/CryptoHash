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

unit chHash.CRC.CRC12.CDMA2000.Factory;

{$INCLUDE CryptoHash.inc}

interface

uses
  chHash.CRC.CRC12,
  chHash.CRC.CRC12.CDMA2000;

type

{ TchCrc12CDMA2000 }

  TchCrc12CDMA2000 = class sealed(chHash.CRC.CRC12.CDMA2000.TchCrc12CDMA2000)
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

{ TchCrc12CDMA2000 }

constructor TchCrc12CDMA2000.Create;
begin
  inherited Create;
end;

initialization
  TchCrc12CDMA2000.FInstance := TchCrc12CDMA2000.Create;

{$IF NOT DEFINED(SUPPORTS_INTERFACES)}
finalization
  FreeAndNil(TchCrc12CDMA2000.FInstance);
{$ENDIF ~ NOT SUPPORTS_INTERFACES}

end.

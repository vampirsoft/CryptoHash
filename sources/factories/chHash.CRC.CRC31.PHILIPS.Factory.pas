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

unit chHash.CRC.CRC31.PHILIPS.Factory;

{$INCLUDE CryptoHash.inc}

interface

uses
  chHash.CRC.CRC31,
  chHash.CRC.CRC31.PHILIPS;

type

{ TchCrc31PHILIPS }

  TchCrc31PHILIPS = class sealed(chHash.CRC.CRC31.PHILIPS.TchCrc31PHILIPS)
  private type
    TInstance = {$IF DEFINED(SUPPORTS_INTERFACES)}IchCrc31{$ELSE}TchCrc31{$ENDIF};
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

{ TchCrc31PHILIPS }

constructor TchCrc31PHILIPS.Create;
begin
  inherited Create;
end;

initialization
  TchCrc31PHILIPS.FInstance := TchCrc31PHILIPS.Create;

{$IF NOT DEFINED(SUPPORTS_INTERFACES)}
finalization
  FreeAndNil(TchCrc31PHILIPS.FInstance);
{$ENDIF ~ NOT SUPPORTS_INTERFACES}

end.

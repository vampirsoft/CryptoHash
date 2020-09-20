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

unit chHash.CRC.CRC16.IBMSDLC.Factory;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC16,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.CRC16.IBMSDLC;

type

{ TchCrc16IBMSDLC }

  TchCrc16IBMSDLC = class sealed(chHash.CRC.CRC16.IBMSDLC.TchCrc16IBMSDLC)
  private type
    TInstance = {$IF DEFINED(SUPPORTS_INTERFACES)}IchCrc16{$ELSE}chHash.CRC.CRC16.IBMSDLC.TchCrc16IBMSDLC{$ENDIF};
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

{ TchCrc16IBMSDLC }

constructor TchCrc16IBMSDLC.Create;
begin
  inherited Create;
end;

initialization
  TchCrc16IBMSDLC.FInstance := TchCrc16IBMSDLC.Create;

{$IF NOT DEFINED(SUPPORTS_INTERFACES)}
finalization
  FreeAndNil(TchCrc16IBMSDLC.FInstance);
{$ENDIF ~ NOT SUPPORTS_INTERFACES}

end.
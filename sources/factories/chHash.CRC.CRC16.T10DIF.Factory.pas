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

unit chHash.CRC.CRC16.T10DIF.Factory;

{$INCLUDE CryptoHash.inc}

interface

uses
  chHash.CRC.CRC16,
  chHash.CRC.CRC16.T10DIF;

type

{ TchCrc16T10DIF }

  TchCrc16T10DIF = class sealed(chHash.CRC.CRC16.T10DIF.TchCrc16T10DIF)
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

{ TchCrc16T10DIF }

constructor TchCrc16T10DIF.Create;
begin
  inherited Create;
end;

initialization
  TchCrc16T10DIF.FInstance := TchCrc16T10DIF.Create;

{$IF NOT DEFINED(SUPPORTS_INTERFACES)}
finalization
  FreeAndNil(TchCrc16T10DIF.FInstance);
{$ENDIF ~ NOT SUPPORTS_INTERFACES}

end.

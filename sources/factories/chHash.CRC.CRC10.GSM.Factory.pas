/////////////////////////////////////////////////////////////////////////////////
//*****************************************************************************//
//* Project      : CryptoHash                                                 *//
//* Latest Source: https://github.com/vampirsoft/CryptoHash                   *//
//* Unit Name    : CryptoHash.inc                                             *//
//* Author       : Сергей (LordVampir) Дворников                              *//
//* Copyright 2021 LordVampir (https://github.com/vampirsoft)                 *//
//* Licensed under the Apache License, Version 2.0                            *//
//*****************************************************************************//
/////////////////////////////////////////////////////////////////////////////////

unit chHash.CRC.CRC10.GSM.Factory;

{$INCLUDE CryptoHash.inc}

interface

uses
  chHash.CRC.CRC10,
  chHash.CRC.CRC10.GSM;

type

{ TchCrc10GSM }

  TchCrc10GSM = class sealed(chHash.CRC.CRC10.GSM.TchCrc10GSM)
  private type
    TInstance = {$IF DEFINED(SUPPORTS_INTERFACES)}IchCrc10{$ELSE}TchCrc10{$ENDIF};
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

{ TchCrc10GSM }

constructor TchCrc10GSM.Create;
begin
  inherited Create;
end;

initialization
  TchCrc10GSM.FInstance := TchCrc10GSM.Create;

{$IF NOT DEFINED(SUPPORTS_INTERFACES)}
finalization
  FreeAndNil(TchCrc10GSM.FInstance);
{$ENDIF ~ NOT SUPPORTS_INTERFACES}

end.

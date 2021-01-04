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

unit chHash.CRC.CRC3.GSM.Factory;

{$INCLUDE CryptoHash.inc}

interface

uses
  chHash.CRC.CRC3,
  chHash.CRC.CRC3.GSM;

type

{ TchCrc3GSM }

  TchCrc3GSM = class sealed(chHash.CRC.CRC3.GSM.TchCrc3GSM)
  private type
    TInstance = {$IF DEFINED(SUPPORTS_INTERFACES)}IchCrc3{$ELSE}TchCrc3{$ENDIF};
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

{ TchCrc3GSM }

constructor TchCrc3GSM.Create;
begin
  inherited Create;
end;

initialization
  TchCrc3GSM.FInstance := TchCrc3GSM.Create;

{$IF NOT DEFINED(SUPPORTS_INTERFACES)}
finalization
  FreeAndNil(TchCrc3GSM.FInstance);
{$ENDIF ~ NOT SUPPORTS_INTERFACES}

end.

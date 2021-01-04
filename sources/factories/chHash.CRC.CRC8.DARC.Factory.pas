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

unit chHash.CRC.CRC8.DARC.Factory;

{$INCLUDE CryptoHash.inc}

interface

uses
  chHash.CRC.CRC8,
  chHash.CRC.CRC8.DARC;

type

{ TchCrc8DARC }

  TchCrc8DARC = class sealed(chHash.CRC.CRC8.DARC.TchCrc8DARC)
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

{ TchCrc8DARC }

constructor TchCrc8DARC.Create;
begin
  inherited Create;
end;

initialization
  TchCrc8DARC.FInstance := TchCrc8DARC.Create;

{$IF NOT DEFINED(SUPPORTS_INTERFACES)}
finalization
  FreeAndNil(TchCrc8DARC.FInstance);
{$ENDIF ~ NOT SUPPORTS_INTERFACES}

end.

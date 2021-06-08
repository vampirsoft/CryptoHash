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

unit chHash.CRC.CRC10.ATM.Factory;

{$INCLUDE CryptoHash.inc}

interface

uses
  chHash.CRC.CRC10,
  chHash.CRC.CRC10.ATM;

type

{ TchCrc10ATM }

  TchCrc10ATM = class sealed(chHash.CRC.CRC10.ATM.TchCrc10ATM)
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

{ TchCrc10ATM }

constructor TchCrc10ATM.Create;
begin
  inherited Create;
end;

initialization
  TchCrc10ATM.FInstance := TchCrc10ATM.Create;

{$IF NOT DEFINED(SUPPORTS_INTERFACES)}
finalization
  FreeAndNil(TchCrc10ATM.FInstance);
{$ENDIF ~ NOT SUPPORTS_INTERFACES}

end.

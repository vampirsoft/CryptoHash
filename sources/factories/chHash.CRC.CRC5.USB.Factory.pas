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

unit chHash.CRC.CRC5.USB.Factory;

{$INCLUDE CryptoHash.inc}

interface

uses
  chHash.CRC.CRC5,
  chHash.CRC.CRC5.USB;

type

{ TchCrc5USB }

  TchCrc5USB = class sealed(chHash.CRC.CRC5.USB.TchCrc5USB)
  private type
    TInstance = {$IF DEFINED(SUPPORTS_INTERFACES)}IchCrc5{$ELSE}TchCrc5{$ENDIF};
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

{ TchCrc5USB }

constructor TchCrc5USB.Create;
begin
  inherited Create;
end;

initialization
  TchCrc5USB.FInstance := TchCrc5USB.Create;

{$IF NOT DEFINED(SUPPORTS_INTERFACES)}
finalization
  FreeAndNil(TchCrc5USB.FInstance);
{$ENDIF ~ NOT SUPPORTS_INTERFACES}

end.

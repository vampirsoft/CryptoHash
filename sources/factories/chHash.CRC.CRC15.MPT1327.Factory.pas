/////////////////////////////////////////////////////////////////////////////////
//*****************************************************************************//
//* Project      : CryptoHash                                                 *//
//* Latest Source: https://github.com/vampirsoft/CryptoHash                   *//
//* Unit Name    : CryptoHash.inc                                             *//
//* Author       : Сергей (LordVampir) Дворников                              *//
//* Copyright 2021 LordVampir (https://github.com/vampirsoft)                 *//
//* Licensed under MIT                                                        *//
//*****************************************************************************//
/////////////////////////////////////////////////////////////////////////////////

unit chHash.CRC.CRC15.MPT1327.Factory;

{$INCLUDE CryptoHash.inc}

interface

uses
  chHash.CRC.CRC15,
  chHash.CRC.CRC15.MPT1327;

type

{ TchCrc15MPT1327 }

  TchCrc15MPT1327 = class sealed(chHash.CRC.CRC15.MPT1327.TchCrc15MPT1327)
  private type
    TInstance = {$IF DEFINED(SUPPORTS_INTERFACES)}IchCrc15{$ELSE}TchCrc15{$ENDIF};
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

{ TchCrc15MPT1327 }

constructor TchCrc15MPT1327.Create;
begin
  inherited Create;
end;

initialization
  TchCrc15MPT1327.FInstance := TchCrc15MPT1327.Create;

{$IF NOT DEFINED(SUPPORTS_INTERFACES)}
finalization
  FreeAndNil(TchCrc15MPT1327.FInstance);
{$ENDIF ~ NOT SUPPORTS_INTERFACES}

end.

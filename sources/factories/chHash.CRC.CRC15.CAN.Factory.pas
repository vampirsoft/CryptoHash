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

unit chHash.CRC.CRC15.CAN.Factory;

{$INCLUDE CryptoHash.inc}

interface

uses
  chHash.CRC.CRC15,
  chHash.CRC.CRC15.CAN;

type

{ TchCrc15CAN }

  TchCrc15CAN = class sealed(chHash.CRC.CRC15.CAN.TchCrc15CAN)
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

{ TchCrc15CAN }

constructor TchCrc15CAN.Create;
begin
  inherited Create;
end;

initialization
  TchCrc15CAN.FInstance := TchCrc15CAN.Create;

{$IF NOT DEFINED(SUPPORTS_INTERFACES)}
finalization
  FreeAndNil(TchCrc15CAN.FInstance);
{$ENDIF ~ NOT SUPPORTS_INTERFACES}

end.

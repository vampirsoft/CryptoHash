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

unit chHash.CRC.CRC16.TMS37157.Factory;

{$INCLUDE CryptoHash.inc}

interface

uses
  chHash.CRC.CRC16,
  chHash.CRC.CRC16.TMS37157;

type

{ TchCrc16TMS37157 }

  TchCrc16TMS37157 = class sealed(chHash.CRC.CRC16.TMS37157.TchCrc16TMS37157)
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

{ TchCrc16TMS37157 }

constructor TchCrc16TMS37157.Create;
begin
  inherited Create;
end;

initialization
  TchCrc16TMS37157.FInstance := TchCrc16TMS37157.Create;

{$IF NOT DEFINED(SUPPORTS_INTERFACES)}
finalization
  FreeAndNil(TchCrc16TMS37157.FInstance);
{$ENDIF ~ NOT SUPPORTS_INTERFACES}

end.

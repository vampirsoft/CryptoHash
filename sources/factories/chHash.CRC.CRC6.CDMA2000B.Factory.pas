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

unit chHash.CRC.CRC6.CDMA2000B.Factory;

{$INCLUDE CryptoHash.inc}

interface

uses
  chHash.CRC.CRC6,
  chHash.CRC.CRC6.CDMA2000B;

type

{ TchCrc6CDMA2000B }

  TchCrc6CDMA2000B = class sealed(chHash.CRC.CRC6.CDMA2000B.TchCrc6CDMA2000B)
  private type
    TInstance = {$IF DEFINED(SUPPORTS_INTERFACES)}IchCrc6{$ELSE}TchCrc6{$ENDIF};
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

{ TchCrc6CDMA2000B }

constructor TchCrc6CDMA2000B.Create;
begin
  inherited Create;
end;

initialization
  TchCrc6CDMA2000B.FInstance := TchCrc6CDMA2000B.Create;

{$IF NOT DEFINED(SUPPORTS_INTERFACES)}
finalization
  FreeAndNil(TchCrc6CDMA2000B.FInstance);
{$ENDIF ~ NOT SUPPORTS_INTERFACES}

end.

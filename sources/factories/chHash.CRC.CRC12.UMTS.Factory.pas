/////////////////////////////////////////////////////////////////////////////////
//*****************************************************************************//
//* Project      : CryptoHash                                                 *//
//* Latest Source: https://github.com/vampirsoft/CryptoHash                   *//
//* Unit Name    : CryptoHash.inc                                             *//
//* Author       : Сергей (LordVampir) Дворников                              *//
//* Copyright 2019 LordVampir (https://github.com/vampirsoft)                 *//
//* Licensed under the Apache License, Version 2.0                            *//
//*****************************************************************************//
/////////////////////////////////////////////////////////////////////////////////

unit chHash.CRC.CRC12.UMTS.Factory;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC12,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.CRC12.UMTS;

type

{ TchCrc12UMTS }

  TchCrc12UMTS = class sealed(chHash.CRC.CRC12.UMTS.TchCrc12UMTS)
  private type
    TInstance = {$IF DEFINED(SUPPORTS_INTERFACES)}IchCrc12{$ELSE}chHash.CRC.CRC12.UMTS.TchCrc12UMTS{$ENDIF};
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

{ TchCrc12UMTS }

constructor TchCrc12UMTS.Create;
begin
  inherited Create;
end;

initialization
  TchCrc12UMTS.FInstance := TchCrc12UMTS.Create;

{$IF NOT DEFINED(SUPPORTS_INTERFACES)}
finalization
  FreeAndNil(TchCrc12UMTS.FInstance);
{$ENDIF ~ NOT SUPPORTS_INTERFACES}

end.

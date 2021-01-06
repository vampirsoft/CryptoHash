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

unit chHash.CRC.CRC7.UMTS.Factory;

{$INCLUDE CryptoHash.inc}

interface

uses
  chHash.CRC.CRC7,
  chHash.CRC.CRC7.UMTS;

type

{ TchCrc7UMTS }

  TchCrc7UMTS = class sealed(chHash.CRC.CRC7.UMTS.TchCrc7UMTS)
  private type
    TInstance = {$IF DEFINED(SUPPORTS_INTERFACES)}IchCrc7{$ELSE}TchCrc7{$ENDIF};
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

{ TchCrc7UMTS }

constructor TchCrc7UMTS.Create;
begin
  inherited Create;
end;

initialization
  TchCrc7UMTS.FInstance := TchCrc7UMTS.Create;

{$IF NOT DEFINED(SUPPORTS_INTERFACES)}
finalization
  FreeAndNil(TchCrc7UMTS.FInstance);
{$ENDIF ~ NOT SUPPORTS_INTERFACES}

end.

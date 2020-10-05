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

unit chHash.CRC.CRC4.INTERLAKEN.Factory;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC4,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.CRC4.INTERLAKEN;

type

{ TchCrc4INTERLAKEN }

  TchCrc4INTERLAKEN = class sealed(chHash.CRC.CRC4.INTERLAKEN.TchCrc4INTERLAKEN)
  private type
    TInstance = {$IF DEFINED(SUPPORTS_INTERFACES)}IchCrc4{$ELSE}chHash.CRC.CRC4.INTERLAKEN.TchCrc4INTERLAKEN{$ENDIF};
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

{ TchCrc4INTERLAKEN }

constructor TchCrc4INTERLAKEN.Create;
begin
  inherited Create;
end;

initialization
  TchCrc4INTERLAKEN.FInstance := TchCrc4INTERLAKEN.Create;

{$IF NOT DEFINED(SUPPORTS_INTERFACES)}
finalization
  FreeAndNil(TchCrc4INTERLAKEN.FInstance);
{$ENDIF ~ NOT SUPPORTS_INTERFACES}

end.

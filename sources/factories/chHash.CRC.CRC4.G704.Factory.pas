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

unit chHash.CRC.CRC4.G704.Factory;

{$INCLUDE CryptoHash.inc}

interface

uses
  chHash.CRC.CRC4,
  chHash.CRC.CRC4.G704;

type

{ TchCrc4G704 }

  TchCrc4G704 = class sealed(chHash.CRC.CRC4.G704.TchCrc4G704)
  private type
    TInstance = {$IF DEFINED(SUPPORTS_INTERFACES)}IchCrc4{$ELSE}TchCrc4{$ENDIF};
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

{ TchCrc4G704 }

constructor TchCrc4G704.Create;
begin
  inherited Create;
end;

initialization
  TchCrc4G704.FInstance := TchCrc4G704.Create;

{$IF NOT DEFINED(SUPPORTS_INTERFACES)}
finalization
  FreeAndNil(TchCrc4G704.FInstance);
{$ENDIF ~ NOT SUPPORTS_INTERFACES}

end.

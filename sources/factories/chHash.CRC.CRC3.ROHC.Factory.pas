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

unit chHash.CRC.CRC3.ROHC.Factory;

{$INCLUDE CryptoHash.inc}

interface

uses
  chHash.CRC.CRC3,
  chHash.CRC.CRC3.ROHC;

type

{ TchCrc3ROHC }

  TchCrc3ROHC = class sealed(chHash.CRC.CRC3.ROHC.TchCrc3ROHC)
  private type
    TInstance = {$IF DEFINED(SUPPORTS_INTERFACES)}IchCrc3{$ELSE}TchCrc3{$ENDIF};
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

{ TchCrc3ROHC }

constructor TchCrc3ROHC.Create;
begin
  inherited Create;
end;

initialization
  TchCrc3ROHC.FInstance := TchCrc3ROHC.Create;

{$IF NOT DEFINED(SUPPORTS_INTERFACES)}
finalization
  FreeAndNil(TchCrc3ROHC.FInstance);
{$ENDIF ~ NOT SUPPORTS_INTERFACES}

end.

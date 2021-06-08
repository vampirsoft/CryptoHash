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

unit chHash.CRC.CRC5.EPCC1G2.Factory;

{$INCLUDE CryptoHash.inc}

interface

uses
  chHash.CRC.CRC5,
  chHash.CRC.CRC5.EPCC1G2;

type

{ TchCrc5EPCC1G2 }

  TchCrc5EPCC1G2 = class sealed(chHash.CRC.CRC5.EPCC1G2.TchCrc5EPCC1G2)
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

{ TchCrc5EPCC1G2 }

constructor TchCrc5EPCC1G2.Create;
begin
  inherited Create;
end;

initialization
  TchCrc5EPCC1G2.FInstance := TchCrc5EPCC1G2.Create;

{$IF NOT DEFINED(SUPPORTS_INTERFACES)}
finalization
  FreeAndNil(TchCrc5EPCC1G2.FInstance);
{$ENDIF ~ NOT SUPPORTS_INTERFACES}

end.

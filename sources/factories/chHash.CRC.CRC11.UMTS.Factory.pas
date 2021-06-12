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

unit chHash.CRC.CRC11.UMTS.Factory;

{$INCLUDE CryptoHash.inc}

interface

uses
  chHash.CRC.CRC11,
  chHash.CRC.CRC11.UMTS;

type

{ TchCrc11UMTS }

  TchCrc11UMTS = class sealed(chHash.CRC.CRC11.UMTS.TchCrc11UMTS)
  private type
    TInstance = {$IF DEFINED(SUPPORTS_INTERFACES)}IchCrc11{$ELSE}TchCrc11{$ENDIF};
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

{ TchCrc11UMTS }

constructor TchCrc11UMTS.Create;
begin
  inherited Create;
end;

initialization
  TchCrc11UMTS.FInstance := TchCrc11UMTS.Create;

{$IF NOT DEFINED(SUPPORTS_INTERFACES)}
finalization
  FreeAndNil(TchCrc11UMTS.FInstance);
{$ENDIF ~ NOT SUPPORTS_INTERFACES}

end.

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

unit chHash.CRC.CRC13.BBC.Factory;

{$INCLUDE CryptoHash.inc}

interface

uses
  chHash.CRC.CRC13,
  chHash.CRC.CRC13.BBC;

type

{ TchCrc13BBC }

  TchCrc13BBC = class sealed(chHash.CRC.CRC13.BBC.TchCrc13BBC)
  private type
    TInstance = {$IF DEFINED(SUPPORTS_INTERFACES)}IchCrc13{$ELSE}TchCrc13{$ENDIF};
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

{ TchCrc13BBC }

constructor TchCrc13BBC.Create;
begin
  inherited Create;
end;

initialization
  TchCrc13BBC.FInstance := TchCrc13BBC.Create;

{$IF NOT DEFINED(SUPPORTS_INTERFACES)}
finalization
  FreeAndNil(TchCrc13BBC.FInstance);
{$ENDIF ~ NOT SUPPORTS_INTERFACES}

end.

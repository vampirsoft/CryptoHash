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

unit chHash.CRC.CRC6.GSM.Factory;

{$INCLUDE CryptoHash.inc}

interface

uses
  chHash.CRC.CRC6,
  chHash.CRC.CRC6.GSM;

type

{ TchCrc6GSM }

  TchCrc6GSM = class sealed(chHash.CRC.CRC6.GSM.TchCrc6GSM)
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

{ TchCrc6GSM }

constructor TchCrc6GSM.Create;
begin
  inherited Create;
end;

initialization
  TchCrc6GSM.FInstance := TchCrc6GSM.Create;

{$IF NOT DEFINED(SUPPORTS_INTERFACES)}
finalization
  FreeAndNil(TchCrc6GSM.FInstance);
{$ENDIF ~ NOT SUPPORTS_INTERFACES}

end.

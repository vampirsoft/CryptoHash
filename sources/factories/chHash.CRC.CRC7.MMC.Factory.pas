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

unit chHash.CRC.CRC7.MMC.Factory;

{$INCLUDE CryptoHash.inc}

interface

uses
  chHash.CRC.CRC7,
  chHash.CRC.CRC7.MMC;

type

{ TchCrc7MMC }

  TchCrc7MMC = class sealed(chHash.CRC.CRC7.MMC.TchCrc7MMC)
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

{ TchCrc7MMC }

constructor TchCrc7MMC.Create;
begin
  inherited Create;
end;

initialization
  TchCrc7MMC.FInstance := TchCrc7MMC.Create;

{$IF NOT DEFINED(SUPPORTS_INTERFACES)}
finalization
  FreeAndNil(TchCrc7MMC.FInstance);
{$ENDIF ~ NOT SUPPORTS_INTERFACES}

end.

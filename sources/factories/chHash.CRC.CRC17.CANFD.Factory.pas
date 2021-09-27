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

unit chHash.CRC.CRC17.CANFD.Factory;

{$INCLUDE CryptoHash.inc}

interface

uses
  chHash.CRC.CRC17,
  chHash.CRC.CRC17.CANFD;

type

{ TchCrc17CANFD }

  TchCrc17CANFD = class sealed(chHash.CRC.CRC17.CANFD.TchCrc17CANFD)
  private type
    TInstance = {$IF DEFINED(SUPPORTS_INTERFACES)}IchCrc17{$ELSE}TchCrc17{$ENDIF};
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

{ TchCrc17CANFD }

constructor TchCrc17CANFD.Create;
begin
  inherited Create;
end;

initialization
  TchCrc17CANFD.FInstance := TchCrc17CANFD.Create;

{$IF NOT DEFINED(SUPPORTS_INTERFACES)}
finalization
  FreeAndNil(TchCrc17CANFD.FInstance);
{$ENDIF ~ NOT SUPPORTS_INTERFACES}

end.

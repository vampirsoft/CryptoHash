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

unit chHash.CRC.CRC21.CANFD.Factory;

{$INCLUDE CryptoHash.inc}

interface

uses
  chHash.CRC.CRC21,
  chHash.CRC.CRC21.CANFD;

type

{ TchCrc21CANFD }

  TchCrc21CANFD = class sealed(chHash.CRC.CRC21.CANFD.TchCrc21CANFD)
  private type
    TInstance = {$IF DEFINED(SUPPORTS_INTERFACES)}IchCrc21{$ELSE}TchCrc21{$ENDIF};
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

{ TchCrc21CANFD }

constructor TchCrc21CANFD.Create;
begin
  inherited Create;
end;

initialization
  TchCrc21CANFD.FInstance := TchCrc21CANFD.Create;

{$IF NOT DEFINED(SUPPORTS_INTERFACES)}
finalization
  FreeAndNil(TchCrc21CANFD.FInstance);
{$ENDIF ~ NOT SUPPORTS_INTERFACES}

end.

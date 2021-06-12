/////////////////////////////////////////////////////////////////////////////////
//*****************************************************************************//
//* Project      : CryptoHash                                                 *//
//* Latest Source: https://github.com/vampirsoft/CryptoHash                   *//
//* Unit Name    : CryptoHash.inc                                             *//
//* Author       : ҥ񤦩 (LordVampir) Ţﱭ髮ޠ                            *//
//* Copyright 2021 LordVampir (https://github.com/vampirsoft)                 *//
//* Licensed under MIT                                                        *//
//*****************************************************************************//
/////////////////////////////////////////////////////////////////////////////////

unit chHash.CRC.CRC11.FLEXRAY.Factory;

{$INCLUDE CryptoHash.inc}

interface

uses
  chHash.CRC.CRC11,
  chHash.CRC.CRC11.FLEXRAY;

type

{ TchCrc11FLEXRAY }

  TchCrc11FLEXRAY = class sealed(chHash.CRC.CRC11.FLEXRAY.TchCrc11FLEXRAY)
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

{ TchCrc11FLEXRAY }

constructor TchCrc11FLEXRAY.Create;
begin
  inherited Create;
end;

initialization
  TchCrc11FLEXRAY.FInstance := TchCrc11FLEXRAY.Create;

{$IF NOT DEFINED(SUPPORTS_INTERFACES)}
finalization
  FreeAndNil(TchCrc11FLEXRAY.FInstance);
{$ENDIF ~ NOT SUPPORTS_INTERFACES}

end.

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

unit chHash.CRC.CRC32.XFER.Factory;

{$INCLUDE CryptoHash.inc}

interface

uses
  chHash.CRC.CRC32,
  chHash.CRC.CRC32.XFER;

type

{ TchCrc32XFER }

  TchCrc32XFER = class sealed(chHash.CRC.CRC32.XFER.TchCrc32XFER)
  private type
    TInstance = {$IF DEFINED(SUPPORTS_INTERFACES)}IchCrc32{$ELSE}TchCrc32{$ENDIF};
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

{ TchCrc32XFER }

constructor TchCrc32XFER.Create;
begin
  inherited Create;
end;

initialization
  TchCrc32XFER.FInstance := TchCrc32XFER.Create;

{$IF NOT DEFINED(SUPPORTS_INTERFACES)}
finalization
  FreeAndNil(TchCrc32XFER.FInstance);
{$ENDIF ~ NOT SUPPORTS_INTERFACES}

end.

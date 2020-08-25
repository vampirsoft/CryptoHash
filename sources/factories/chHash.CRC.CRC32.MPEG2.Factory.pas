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

unit chHash.CRC.CRC32.MPEG2.Factory;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC32,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.CRC32.MPEG2;

type

{ TchCrc32MPEG2 }

  TchCrc32MPEG2 = class sealed(chHash.CRC.CRC32.MPEG2.TchCrc32MPEG2)
  private type
    TInstance = {$IF DEFINED(SUPPORTS_INTERFACES)}IchCrc32{$ELSE}chHash.CRC.CRC32.MPEG2.TchCrc32MPEG2{$ENDIF};
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

{ TchCrc32MPEG2 }

constructor TchCrc32MPEG2.Create;
begin
  inherited Create;
end;

initialization
  TchCrc32MPEG2.FInstance := TchCrc32MPEG2.Create;

{$IF NOT DEFINED(SUPPORTS_INTERFACES)}
finalization
  FreeAndNil(TchCrc32MPEG2.FInstance);
{$ENDIF ~ NOT SUPPORTS_INTERFACES}

end.

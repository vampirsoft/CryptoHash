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

unit chHash.CRC.CRC32.CKSUM.Factory;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC32,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.CRC32.CKSUM;

type

{ TchCrc32CKSUM }

  TchCrc32CKSUM = class sealed(chHash.CRC.CRC32.CKSUM.TchCrc32CKSUM)
  private type
    TInstance = {$IF DEFINED(SUPPORTS_INTERFACES)}IchCrc32{$ELSE}chHash.CRC.CRC32.CKSUM.TchCrc32CKSUM{$ENDIF};
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

{ TchCrc32CKSUM }

constructor TchCrc32CKSUM.Create;
begin
  inherited Create;
end;

initialization
  TchCrc32CKSUM.FInstance := TchCrc32CKSUM.Create;

{$IF NOT DEFINED(SUPPORTS_INTERFACES)}
finalization
  FreeAndNil(TchCrc32CKSUM.FInstance);
{$ENDIF ~ NOT SUPPORTS_INTERFACES}

end.

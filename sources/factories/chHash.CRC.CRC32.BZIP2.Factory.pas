﻿/////////////////////////////////////////////////////////////////////////////////
//*****************************************************************************//
//* Project      : CryptoHash                                                 *//
//* Latest Source: https://github.com/vampirsoft/CryptoHash                   *//
//* Unit Name    : CryptoHash.inc                                             *//
//* Author       : Сергей (LordVampir) Дворников                              *//
//* Copyright 2021 LordVampir (https://github.com/vampirsoft)                 *//
//* Licensed under MIT                                                        *//
//*****************************************************************************//
/////////////////////////////////////////////////////////////////////////////////

unit chHash.CRC.CRC32.BZIP2.Factory;

{$INCLUDE CryptoHash.inc}

interface

uses
  chHash.CRC.CRC32,
  chHash.CRC.CRC32.BZIP2;

type

{ TchCrc32BZIP2 }

  TchCrc32BZIP2 = class sealed(chHash.CRC.CRC32.BZIP2.TchCrc32BZIP2)
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

{ TchCrc32BZIP2 }

constructor TchCrc32BZIP2.Create;
begin
  inherited Create;
end;

initialization
  TchCrc32BZIP2.FInstance := TchCrc32BZIP2.Create;

{$IF NOT DEFINED(SUPPORTS_INTERFACES)}
finalization
  FreeAndNil(TchCrc32BZIP2.FInstance);
{$ENDIF ~ NOT SUPPORTS_INTERFACES}

end.

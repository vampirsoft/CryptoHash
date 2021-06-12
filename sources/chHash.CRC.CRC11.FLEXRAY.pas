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

unit chHash.CRC.CRC11.FLEXRAY;

{$INCLUDE CryptoHash.inc}

interface

uses
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash.CRC.CRC11.Impl,
{$ENDIF ~ SUPPORTS_INTERFACES}
  chHash.CRC.CRC11;

type

{ TchCrc11FLEXRAY }

  TchCrc11FLEXRAY =
    class({$IF DEFINED(SUPPORTS_INTERFACES)}chHash.CRC.CRC11.Impl{$ELSE}chHash.CRC.CRC11{$ENDIF}.TchCrc11)
  public
    constructor Create; reintroduce;
  end;

implementation

{ TchCrc11FLEXRAY }

constructor TchCrc11FLEXRAY.Create;
begin
  inherited Create('CRC-11/FLEXRAY', $385, $01A, $000, $5A3, False, False);
  Aliases.Add('CRC-11');
end;

end.

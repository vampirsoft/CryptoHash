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

unit chHash.Utils;

{$INCLUDE CryptoHash.inc}

interface

uses
  System.Classes, System.SysUtils,
{$IF DEFINED(SUPPORTS_INTERFACES)}
  chHash;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.Impl;
{$ENDIF ~ SUPPORTS_INTERFACES}

type
  TchUtils = class sealed
  strict private
  {$HINTS OFF}
    constructor Create;
  {$HINTS ON}
  public
    class function Calculate<C, R>(const Stream: TStream;
      const Algorithm: {$IF DEFINED(SUPPORTS_INTERFACES)}IchAlgorithm<C, R>{$ELSE}TchAlgorithm<C, R>{$ENDIF}): R; static;
  end;

implementation

{ TchUtils }

class function TchUtils.Calculate<C, R>(const Stream: TStream;
  const Algorithm: {$IF DEFINED(SUPPORTS_INTERFACES)}IchAlgorithm<C, R>{$ELSE}TchAlgorithm<C, R>{$ENDIF}): R;
begin
  var Current := Algorithm.Init;

  const SavedPosition = Stream.Position;
  var Buffer: TBytes;
  try
    SetLength(Buffer, Word.MaxValue);
    Stream.Position := 0;
    var Length := Word.MaxValue;
    while Length = Word.MaxValue do
    begin
      Length := Stream.Read(Buffer, Word.MaxValue);
      Algorithm.Calculate(Current, Buffer, Length);
    end;
  finally
    SetLength(Buffer, 0);
    Stream.Position := SavedPosition;
  end;

  Result := Algorithm.Final(Current);
end;

constructor TchUtils.Create;
begin
end;

end.

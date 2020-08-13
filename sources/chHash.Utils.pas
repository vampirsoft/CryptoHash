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

unit chHash.Utils;

{$INCLUDE CryptoHash.inc}

interface

uses
  System.Classes, System.SysUtils,
  chHash;

type
  TchUtils = class sealed
  strict private
  {$HINTS OFF}
    constructor Create;
  {$HINTS ON}
  public
    class function Calculate<C, R>(const Stream: TStream; const Algorithm: TchAlgorithm<C, R>): R; static;
  end;

implementation

{ TchUtils }

class function TchUtils.Calculate<C, R>(const Stream: TStream; const Algorithm: TchAlgorithm<C, R>): R;
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

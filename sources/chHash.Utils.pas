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

uses
{$IF DEFINED(USE_JEDY_CORE_LIBRARY)}
  JclLogic;
{$ELSE ~ NOT USE_JEDY_CORE_LIBRARY}
  chHash.Core.Bits;
{$IFEND ~USE_JEDY_CORE_LIBRARY}

{ TchUtils }

class function TchUtils.Calculate<C, R>(const Stream: TStream; const Algorithm: TchAlgorithm<C, R>): R;
begin
  var Current: C := Algorithm.Init;

  const SavedPosition: Int64 = Stream.Position;
  var Buffer: TBytes;
  try
    const BufferSize: Word = {$IF DEFINED(USE_JEDY_CORE_LIBRARY)}WordMask{$ELSE}Word.Mask{$IFEND};
    SetLength(Buffer, BufferSize);
    Stream.Position := 0;
    var Length: Word := BufferSize;
    while Length = BufferSize do
    begin
      Length := Stream.Read(Buffer, BufferSize);
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

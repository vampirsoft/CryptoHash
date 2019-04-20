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

unit chHash;

{$INCLUDE CryptoHash.inc}

interface

uses
  System.SysUtils;

type

{ TchAlgorithm<C, R> }

  TchAlgorithm<C, R> = class abstract
  strict private
    FInit: C;
    FCheck: R;
  strict protected
    FName: string;
    constructor Create(const Name: string; const Init: C; const Check: R); reintroduce;
    function IfThenElse<T>(const Condition: Boolean; const ThenValue, ElseValue: T): T; inline;
  public
    procedure Calculate(var Current: C; Data: TBytes; Length: Cardinal); overload; inline;
    procedure Calculate(var Current: C; const Data; Length: Cardinal); overload; inline;
    procedure Calculate(var Current: C; Data: Pointer; Length: Cardinal); overload; virtual; abstract;
    function Final(Current: C): R; virtual; abstract;
    function ToString: string; override; abstract;
    property Name: string read FName;
    property Init: C read FInit;
    property Check: R read FCheck;
  end;

implementation

{ TchAlgorithm<C, R> }

procedure TchAlgorithm<C, R>.Calculate(var Current: C; Data: TBytes; Length: Cardinal);
begin
  Calculate(Current, Data[0], Length);
end;

procedure TchAlgorithm<C, R>.Calculate(var Current: C; const Data; Length: Cardinal);
begin
  Calculate(Current, @Data, Length);
end;

constructor TchAlgorithm<C, R>.Create(const Name: string; const Init: C; const Check: R);
begin
  FName := Name;
  FInit := Init;
  FCheck := Check;
end;

function TchAlgorithm<C, R>.IfThenElse<T>(const Condition: Boolean; const ThenValue, ElseValue: T): T;
begin
  if Condition then Exit(ThenValue);
  Result := ElseValue;
end;

end.


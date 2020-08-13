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
    class function IfThenElse<T>(const Condition: Boolean; const ThenValue, ElseValue: T): T; inline; static;
    class function InitArray<T>(const Length: Cardinal): TArray<T>; inline; static;
  public
    function Calculate(const Data: TBytes): R; overload; inline;
    function Calculate(const Data; const Length: Cardinal): R; overload; inline;
    function Calculate(const Data: Pointer; const Length: Cardinal): R; overload; inline;
    procedure Calculate(var Current: C; const Data: TBytes); overload; inline;
    procedure Calculate(var Current: C; const Data: TBytes; const Length: Cardinal); overload; inline;
    procedure Calculate(var Current: C; const Data; const Length: Cardinal); overload; inline;
    procedure Calculate(var Current: C; const Data: Pointer; const Length: Cardinal); overload; virtual; abstract;
    function Final(const Current: C): R; virtual; abstract;
    function ToString: string; override; abstract;
    property Name: string read FName;
    property Init: C read FInit;
    property Check: R read FCheck;
  end;

implementation

{ TchAlgorithm<C, R> }

function TchAlgorithm<C, R>.Calculate(const Data: TBytes): R;
begin
  Result := Calculate(Data[0], Length(Data));
end;

function TchAlgorithm<C, R>.Calculate(const Data; const Length: Cardinal): R;
begin
  Result := Calculate(@Data, Length);
end;

function TchAlgorithm<C, R>.Calculate(const Data: Pointer; const Length: Cardinal): R;
begin
  var Current := Init;
  Calculate(Current, Data, Length);
  Result := Final(Current);
end;

procedure TchAlgorithm<C, R>.Calculate(var Current: C; const Data: TBytes);
begin
  Calculate(Current, Data, Length(Data));
end;

procedure TchAlgorithm<C, R>.Calculate(var Current: C; const Data: TBytes; const Length: Cardinal);
begin
  Calculate(Current, Data[0], Length);
end;

procedure TchAlgorithm<C, R>.Calculate(var Current: C; const Data; const Length: Cardinal);
begin
  Calculate(Current, @Data, Length);
end;

constructor TchAlgorithm<C, R>.Create(const Name: string; const Init: C; const Check: R);
begin
  FName := Name;
  FInit := Init;
  FCheck := Check;
end;

class function TchAlgorithm<C, R>.IfThenElse<T>(const Condition: Boolean; const ThenValue, ElseValue: T): T;
begin
  if Condition then Exit(ThenValue);
  Result := ElseValue;
end;

class function TchAlgorithm<C, R>.InitArray<T>(const Length: Cardinal): TArray<T>;
begin
  SetLength(Result, Length);
end;

end.

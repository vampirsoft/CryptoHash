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
{$IF DEFINED(SUPPORTS_INTERFACES)}
  System.SysUtils;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  chHash.Impl;
{$ENDIF ~ SUPPORTS_INTERFACES}

type
{$IF DEFINED(SUPPORTS_INTERFACES)}
  IchAlgorithm<C, R> = interface
    ['{D210C023-E513-42EB-B87F-4ADFF2CB68A8}']
    function Init: C;
    function Calculate(const Data: TBytes): R; overload;
    function Calculate(const Data; const Length: Cardinal): R; overload;
    function Calculate(const Data: Pointer; const Length: Cardinal): R; overload;
    procedure Calculate(var Current: C; const Data: TBytes); overload;
    procedure Calculate(var Current: C; const Data: TBytes; const Length: Cardinal); overload;
    procedure Calculate(var Current: C; const Data; const Length: Cardinal); overload;
    procedure Calculate(var Current: C; const Data: Pointer; const Length: Cardinal); overload;
    function Final(const Current: C): R;
    function Name: string;
    function Check: R;
    function ToString: string;
  end;
{$ELSE ~ NOT SUPPORTS_INTERFACES}
  TchAlgorithm<C, R> = class abstract(chHash.Impl.TchAlgorithm<C, R>)
  end;
{$ENDIF ~ SUPPORTS_INTERFACES}

implementation

end.

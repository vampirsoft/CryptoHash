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

unit chHash.Core;

{$INCLUDE CryptoHash.inc}

interface

type
  TLargeInteger = record
  case Integer of
  0: (
    LowPart: LongWord;
    HighPart: LongInt
  );
  1: (
    QuadPart: Int64
  );
  end;

  TULargeInteger = record
  case Integer of
  0: (
    LowPart: LongWord;
    HighPart: LongWord
  );
  1: (
    QuadPart: UInt64
  );
  end;

implementation

end.

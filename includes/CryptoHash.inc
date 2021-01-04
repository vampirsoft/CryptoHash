/////////////////////////////////////////////////////////////////////////////////
//*****************************************************************************//
//* Project      : CryptoHash                                                 *//
//* Latest Source: https://github.com/vampirsoft/CryptoHash                   *//
//* Unit Name    : CryptoHash.inc                                             *//
//* Author       : Сергей (LordVampir) Дворников                              *//
//* Copyright 2021 LordVampir (https://github.com/vampirsoft)                 *//
//* Licensed under the Apache License, Version 2.0                            *//
//*****************************************************************************//
/////////////////////////////////////////////////////////////////////////////////

{$IF NOT DEFINED(CRYPTO_HASH_INC)}
{$DEFINE CRYPTO_HASH_INC}

// Используется для принудительного включения delphi-реализации, если по какой-то
// причине нет возможности использовать реализацию на ассемблере
{$DEFINE USE_FORCE_DELPHI}

// Указывается, что в приоритете будет использоваться реализация на ассемблере
// (Если не указана опция USE_FORCE_DELPHI, то для компиляции под Windows desktop
// принудительно будет выставляться эта опция.
{$DEFINE USE_ASSEMBLER}

// Если необходима поддержка интерфейсов, активируйте эту опцию
{$DEFINE SUPPORTS_INTERFACES}

// Если используется JEDI Core Lybrary (https://github.com/project-jedi/jcl),
// имеет смысл включить эту опцию
//{$DEFINE USE_JEDI_CORE_LIBRARY}



// ВНИМАНИЕ!!!
// =============================================================================
// КОД СЛЕДУЮЩИЙ НИЖЕ НЕ ПРЕДНАЗНАЧЕН ДЛЯ ИЗМЕНЕНИЯ ПРОГРАММИСТОМ И
// СОДЕРЖИТ КРИТИЧЕСКИЕ НАСТРОЙКИ ДЛЯ БИБЛИОТЕКИ CryptoHash

{$IF DEFINED(MSWINDOWS)}
  {$IF NOT DEFINED(USE_FORCE_DELPHI)}
    {$DEFINE USE_ASSEMBLER}
  {$ENDIF ~ USE_FORCE_DELPHI}
{$ELSE ~ NOT MSWINDOWS}
  {$DEFINE USE_FORCE_DELPHI}
  {$UNDEF USE_JEDI_CORE_LIBRARY}  // JEDI Core Library поддерживает только Windows
{$ENDIF ~ MSWINDOWS}
{$IF DEFINED(USE_FORCE_DELPHI)}
  {$UNDEF USE_ASSEMBLER}
{$ENDIF ~ USE_FORCE_DELPHI}
{$IF NOT DEFINED(USE_ASSEMBLER)}
  {$DEFINE USE_FORCE_DELPHI}
{$ENDIF ~ USE_ASSEMBLER}

{$IF NOT DEFINED(CPU64BITS)}
  {$DEFINE X32}
{$ENDIF}
{$IF NOT DEFINED(X32)}
  {$DEFINE X64}
{$ENDIF}

{$WRITEABLECONST OFF}     // {$J-}
{$OVERFLOWCHECKS OFF}     // {$Q-}
{$RANGECHECKS OFF}        // {$R-}
{$TYPEDADDRESS ON}        // {$T+}
{$BOOLEVAL OFF}           // {$B-}
{$SAFEDIVIDE OFF}         // {$U-}

{$IF DEFINED(DEBUG)}
  {$DEBUGINFO ON}         // {$D+}
  {$LOCALSYMBOLS ON}      // {$L+}
  {$OPTIMIZATION OFF}     // {$O-}
  {$ASSERTIONS ON}        // {$C+}
  {$STACKFRAMES ON}       // {$W+}
{$ELSE ~ NOT DEBUG}
  {$DEBUGINFO OFF}        // {$D-}
  {$LOCALSYMBOLS OFF}     // {$L-}
  {$OPTIMIZATION ON}      // {$O+}
  {$ASSERTIONS OFF}       // {$C-}
  {$STACKFRAMES OFF}      // {$W-}
{$ENDIF ~ DEBUG}

{$IF NOT DEFINED(DEBUG)}
  {$DEFINE USE_INLINE}
{$ENDIF}

{$ENDIF ~ CRYPTO_HASH_INC}

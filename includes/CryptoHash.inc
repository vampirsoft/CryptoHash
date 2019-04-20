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

{$IF NOT DEFINED(CRYPTO_HASH_INC)}
{$DEFINE CRYPTO_HASH_INC}

// Используется для принудительного включения delphi-реализации, если по какой-то
// причине нет возможности использовать реализацию на ассемблере
{$DEFINE USE_FORCE_DELPHI}

// Указывается, что в приоритете будет использоваться реализация на ассемблере
// (Если не указана опция USE_FORCE_DELPHI, то для компиляции под Windows desktop
// принудительно будет выставляться эта опция. Так же для delphi ниже версии
// XE2 принудительно будет выставляться эта опция)
{$DEFINE USE_ASSEMBLER}

// Если используется Jedy Core Lybrary (https://github.com/project-jedi/jcl),
// имеет смысл включить эту опцию
//{$DEFINE USE_JEDY_CORE_LIBRARY}

// Если используется OmniThreadLibrary (https://github.com/gabr42/OmniThreadLibrary),
// то рекомендуется активировать эту опцию
//{$DEFINE USE_OMNI_THREAD_LIBRARY}



// ВНИМАНИЕ!!!
// =============================================================================
// КОД СЛЕДУЮЩИЙ НИЖЕ НЕ ПРЕДНАЗНАЧЕН ДЛЯ ИЗМЕНЕНИЯ ПРОГРАММИСТОМ И
// СОДЕРЖИТ КРИТИЧЕСКИЕ НАСТРОЙКИ ДЛЯ БИБЛИОТЕКИ CryptoHash

{$INCLUDE jedi\jedi.inc}

{$IF DEFINED(DELPHIXE3_UP)}
  {$LEGACYIFEND ON}
{$IFEND}

{$IF NOT DEFINED(DELPHIXE2_UP)}
  {$DEFINE USE_ASSEMBLER}
  {$UNDEF USE_FORCE_DELPHI}
{$IFEND ~DELPHIXE2_UP}
{$IF DEFINED(MSWINDOWS) AND NOT DEFINED(USE_FORCE_DELPHI)}
  {$DEFINE USE_ASSEMBLER}
{$ELSE}
  {$DEFINE USE_FORCE_DELPHI}
{$IFEND ~MSWINDOWS AND ~NOT USE_FORCE_DELPHI}
{$IF DEFINED(USE_FORCE_DELPHI)}
  {$UNDEF USE_ASSEMBLER}
{$IFEND ~USE_FORCE_DELPHI}
{$IF NOT DEFINED(USE_ASSEMBLER)}
  {$DEFINE USE_FORCE_DELPHI}
{$IFEND ~USE_ASSEMBLER}

{$WRITEABLECONST OFF}    // {$J-}
{$OVERFLOWCHECKS OFF}    // {$Q-}
{$RANGECHECKS OFF}       // {$R-}
{$TYPEDADDRESS ON}       // {$T+}

{$IF NOT DEFINED(DEBUG)}
  {$DEFINE USE_INLINE}
{$IFEND}

{$IFEND ~CRYPTO_HASH_INC}


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

{$IF NOT DEFINED(CRYPTO_HASH_TESTS_INC)}
{$DEFINE CRYPTO_HASH_TESTS_INC}

// Теты в коносле
{$DEFINE CONSOLE_TESTRUNNER}

// Тесты на нагрузку
//{$DEFINE BENCHMARK}

// Отключение лишних сообщений при компиляции
{$HINTS OFF}
{$WARNINGS OFF}

// ВНИМАНИЕ!!!
// =============================================================================
// НАСТРОЙКИ БИБЛИОТЕКИ
{$INCLUDE CryptoHash.inc}

{$ENDIF ~ CRYPTO_HASH_TESTS_INC}

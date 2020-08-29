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

{$IF NOT DEFINED(CRYPTO_HASH_TESTS_INC)}
{$DEFINE CRYPTO_HASH_TESTS_INC}

// Теты в коносле
{$DEFINE CONSOLE_TESTRUNNER}

// Тесты на нагрузку
//{$DEFINE BENCHMARK}

// Настройки библиотеки
{$INCLUDE CryptoHash.inc}

// Отключение лишних сообщений при компиляции
{$HINTS OFF}
{$WARNINGS OFF}

{$ENDIF ~ CRYPTO_HASH_TESTS_INC}

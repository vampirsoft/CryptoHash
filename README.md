# CryptoHash
- Автор:		Сергей (LordVampir) Дворников
- Репозиторий:	https://github.com/vampirsoft/CryptoHash
- mailto:		lordvampir@ymail.com

## Краткое описание
Библиотека предназначена для получения различных хеш-сумм в Delphi

## Возможности
- Поддержка **Delphi 10.3.3 Rio Community Edition** (предыдущие версии официально не поддерживаются)
- Официальная поддержка *Win32* и *Win64*, неофициальная поддержка остальных платформ доступных в текущей верии delphi
- Быстрый (ускорение вплоть до 8.5-ми раз на asm и до 6.3-ти раз на delphi) подсчёт **crc-8**, как по прямому, так и по обратному алогоритмам
- Быстрый (ускорение вплоть до 10-ти раз на asm и до 5.6-ми раз на delphi) подсчёт **crc-16**, как по прямому, так и по обратному алогоритмам
- Быстрый (ускорение вплоть до 10-ти раз на asm и до 8-ми раз на delphi) подсчёт **crc-32**, как по прямому, так и по обратному алогоритмам

## Зависимости
### Необязательные [1]
- [JEDI Core Lybrary](https://github.com/project-jedi/jcl): могут использоваться методы из модуля *JclLogic* [2]

[1] Переключение возможно в [CryptoHash.inc](/includes/CryptoHash.inc) с помощью соответствующего ключа<br>
[2] Присутствует ошибка в методах *ReverseBytes(Value: Word): Word;* и *ReverseBytes(Value: Smallint): Smallint;* на платформе *Win64* в режиме компиляции asm

## Использование
- Библиотеку можно использовать, как отдельныем модули, так и в качастве интегрируемого в IDE [пакета](/packages)
- Для управления настройками используется [CryptoHash.inc](/includes/CryptoHash.inc)
- Модули **.Impl.pas* не рекомендованы к использованию во всём проекте, исключение составляют проекты, в которых по каким-либо причинам используется ключ **SUPPORTS_INTERFACES**, но не используется синглтон-схема
- Модули **.Factory.pas* не рекомендованы к использованию, они были добавленны только для тех проектов, в которых нет собственного единого механизма по управлению синглтонами
- В качестве примеров использования могут служить [тесты](/tests)

## Дополнительные ссылки
- [Catalogue of parametrised CRC algorithms](https://reveng.sourceforge.io/crc-catalogue/)
- [CRC Calculation](http://www.zorc.breitbandkatze.de/crc.html)
- [Параллельное вычисление CRC32](http://guildalfa.ru/alsha/node/2)
- [Параллельное вычисление CRC64](http://guildalfa.ru/alsha/node/4)
- [Fast CRC32](https://create.stephan-brumme.com/crc32/)
- [meetanthony / crcjava](https://github.com/meetanthony/crcjava)
- [dearblue / ruby-crc](https://github.com/dearblue/ruby-crc)
- [CRC Calculation Of A Mostly Static Data Stream](https://stackoverflow.com/questions/23122312/crc-calculation-of-a-mostly-static-data-stream)
- [Generic CRC (8/16/32/64) combine implementation](https://stackoverflow.com/questions/29915764/generic-crc-8-16-32-64-combine-implementation)
- [CRC calculations](https://www.miscel.dk/MiscEl/CRCcalculations.html)
- [Начальное значение CCITT CRC 16 бит 0xffff](https://overcoder.net/q/911124/%D0%BD%D0%B0%D1%87%D0%B0%D0%BB%D1%8C%D0%BD%D0%BE%D0%B5-%D0%B7%D0%BD%D0%B0%D1%87%D0%B5%D0%BD%D0%B8%D0%B5-ccitt-crc-16-%D0%B1%D0%B8%D1%82-0xffff)
- [CRC16-CCITT](http://srecord.sourceforge.net/crc16-ccitt.html)
- [CRC Calculator (Javascript)](http://www.sunshine2k.de/coding/javascript/crc/crc_js.html)

### [История изменений](/CHANGELOG.md)

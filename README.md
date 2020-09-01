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
- Быстрый (ускорение вплоть до 10-ти раз на asm и до 8-ми раз на delphi) подсчёт **crc-32**, как по прямому, так и по обратному алогоритмам

## Использование
- Библиотеку можно использовать, как отдельныем модули, так и в качастве интегрируемого в IDE [пакета](/packages)
- Для управления настройками используется [CryptoHash.inc](/includes/CryptoHash.inc)
- Модули **.Impl.pas* не рекомендованы к использованию во всём проекте, исключение составляют проекты, в которых по каким-либо причинам используется ключ **SUPPORTS_INTERFACES**, но не используется синглтон-схема
- Модули **.Factory.pas* не рекомендованы к использованию, они были добавленны только для тех проектов, в которых нет собственного единого механизма по управлению синглтонами
- В качестве примеров использования могут служить [тесты](/tests)

## Дополнительные ссылки
- [Catalogue of parametrised CRC algorithms](https://reveng.sourceforge.io/crc-catalogue/)
- [Параллельное вычисление CRC32](http://guildalfa.ru/alsha/node/2)
- [Параллельное вычисление CRC64](http://guildalfa.ru/alsha/node/4)
- [Fast CRC32](https://create.stephan-brumme.com/crc32/)
- [meetanthony / crcjava](https://github.com/meetanthony/crcjava)
- [Generic CRC (8/16/32/64) combine implementation](https://stackoverflow.com/questions/29915764/generic-crc-8-16-32-64-combine-implementation)
- [CRC calculations](https://www.miscel.dk/MiscEl/CRCcalculations.html)

## [История изменений](/CHANGELOG.md)

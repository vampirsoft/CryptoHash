# CryptoHash
- �����:		������ (LordVampir) ���������
- �����������:	https://github.com/vampirsoft/CryptoHash
- mailto:		lordvampir@ymail.com

## ������� ��������
���������� ������������� ��� ��������� ��������� ���-���� � Delphi

## �����������
- ��������� **Delphi 10.3.3 Rio Community Edition** (���������� ������ ���������� �� ��������������)
- ����������� ��������� *Win32* � *Win64*, ������������� ��������� ��������� �������� ��������� � ������� ����� delphi
- ������� (��������� ������ �� 8.5-�� ��� �� asm � �� 6.3-�� ��� �� delphi) ������� **crc-8**, ��� �� �������, ��� � �� ��������� �����������
- ������� (��������� ������ �� 10-�� ��� �� asm � �� 5.6-�� ��� �� delphi) ������� **crc-16**, ��� �� �������, ��� � �� ��������� �����������
- ������� (��������� ������ �� 10-�� ��� �� asm � �� 8-�� ��� �� delphi) ������� **crc-32**, ��� �� �������, ��� � �� ��������� �����������

## �����������
### �������������� [1]
- [JEDI Core Lybrary](https://github.com/project-jedi/jcl): ����� �������������� ������ �� ������ *JclLogic* [2]

[1] ������������ �������� � [CryptoHash.inc](/includes/CryptoHash.inc) � ������� ���������������� �����<br>
[2] ������������ ������ � ������� *ReverseBytes(Value: Word): Word;* � *ReverseBytes(Value: Smallint): Smallint;* �� ��������� *Win64* � ������ ���������� asm

## �������������
- ���������� ����� ������������, ��� ���������� ������, ��� � � �������� �������������� � IDE [������](/packages)
- ��� ���������� ����������� ������������ [CryptoHash.inc](/includes/CryptoHash.inc)
- ������ **.Impl.pas* �� ������������� � ������������� �� ��� �������, ���������� ���������� �������, � ������� �� �����-���� �������� ������������ ���� **SUPPORTS_INTERFACES**, �� �� ������������ ��������-�����
- ������ **.Factory.pas* �� ������������� � �������������, ��� ���� ���������� ������ ��� ��� ��������, � ������� ��� ������������ ������� ��������� �� ���������� �����������
- � �������� �������� ������������� ����� ������� [�����](/tests)

## �������������� ������
- [Catalogue of parametrised CRC algorithms](https://reveng.sourceforge.io/crc-catalogue/)
- [CRC Calculation](http://www.zorc.breitbandkatze.de/crc.html)
- [������������ ���������� CRC32](http://guildalfa.ru/alsha/node/2)
- [������������ ���������� CRC64](http://guildalfa.ru/alsha/node/4)
- [Fast CRC32](https://create.stephan-brumme.com/crc32/)
- [meetanthony / crcjava](https://github.com/meetanthony/crcjava)
- [dearblue / ruby-crc](https://github.com/dearblue/ruby-crc)
- [CRC Calculation Of A Mostly Static Data Stream](https://stackoverflow.com/questions/23122312/crc-calculation-of-a-mostly-static-data-stream)
- [Generic CRC (8/16/32/64) combine implementation](https://stackoverflow.com/questions/29915764/generic-crc-8-16-32-64-combine-implementation)
- [CRC calculations](https://www.miscel.dk/MiscEl/CRCcalculations.html)
- [��������� �������� CCITT CRC 16 ��� 0xffff](https://overcoder.net/q/911124/%D0%BD%D0%B0%D1%87%D0%B0%D0%BB%D1%8C%D0%BD%D0%BE%D0%B5-%D0%B7%D0%BD%D0%B0%D1%87%D0%B5%D0%BD%D0%B8%D0%B5-ccitt-crc-16-%D0%B1%D0%B8%D1%82-0xffff)
- [CRC16-CCITT](http://srecord.sourceforge.net/crc16-ccitt.html)
- [CRC Calculator (Javascript)](http://www.sunshine2k.de/coding/javascript/crc/crc_js.html)

### [������� ���������](/CHANGELOG.md)

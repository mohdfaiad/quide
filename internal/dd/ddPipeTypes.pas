//..........................................................................................................................................................................................................................................................
unit ddPipeTypes;
{ ��������� ���� ��� ���� }
{ ������ 15.05.2003 }

{ $Id: ddPipeTypes.pas,v 1.4 2013/04/11 16:46:28 lulin Exp $ }

// $Log: ddPipeTypes.pas,v $
// Revision 1.4  2013/04/11 16:46:28  lulin
// - ���������� ��� XE3.
//
// Revision 1.3  2006/03/07 12:27:34  narry
// - ���������: ����� ���������� �������� �������
//
// Revision 1.2  2005/02/16 17:10:41  narry
// - update: Delphi 2005
//
// Revision 1.1  2003/05/28 11:54:33  narry
// - ���� ������ � ������� ��� ������ �������� ��������-���������� ����
//

interface

type
 TddTopicEvent = procedure (aTopicNo: Longint; aMessage: AnsiString) of object;

implementation

end.

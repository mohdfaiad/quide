{ $Id: DtDefine.inc,v 1.5 2010/03/10 13:57:24 narry Exp $ }

// $Log: DtDefine.inc,v $
// Revision 1.5  2010/03/10 13:57:24  narry
// - �� ����������
//
// Revision 1.4  2008/10/24 15:03:12  lulin
// - bug fix: �� ���������� ����������.
//
// Revision 1.3  2008/10/13 12:39:27  narry
// - ������������� ����������
//
// Revision 1.2  2008/08/26 06:31:52  narry
// - ����������
//
// Revision 1.1  2008/02/26 12:30:57  lulin
// - ������� �� ������� �������� �����.
//
// Revision 1.6  2006/10/04 08:40:31  voba
// - merge with b_archi_ht64
//
// Revision 1.5.14.1  2006/09/19 08:37:54  voba
// - ������� �� HTStub
//
// Revision 1.5  2006/03/20 12:56:10  voba
// no message
//
// Revision 1.4  2005/11/21 13:07:39  step
// ������ �������������� "NOFORMS"
//
// Revision 1.3  2005/11/21 10:11:30  step
// ����� ��������� TestDb
//
// Revision 1.2  2005/03/18 13:05:44  fireton
// - change: ��������� �� ����� ����� ������ WSocket
//
// Revision 1.1  2004/08/03 08:52:51  step
// ������ dt_def.pas �� DtDefine.inc
//
// Revision 1.5  2002/11/21 17:14:54  law
// - bug fix: ����������� �������������� ��������� MonoUser.
//
// Revision 1.4  2002/05/15 13:48:23  law
// - new unit: DT_AsyncBroadcast.
//
// Revision 1.3  2000/12/15 15:36:18  law
// - ��������� ��������� Log.
//

{$Include HTDefine.inc}
{$Include l3Define.inc }

{$A-,B-,F+,K-,U-,V-,W-,X+}

{$WriteableConst On}

{.$DEFINE TestDb} // ��������� ������ ��������� ������ �� ���������� �� (�.�. �� � ������ <db_path>\testing)
{$IFDEF UseProjectDefine}
 {$I ProjectDefine.inc}
{$ENDIF}


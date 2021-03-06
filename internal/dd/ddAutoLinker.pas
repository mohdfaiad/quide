unit ddAutoLinker;

{ $Id: ddAutoLinker.pas,v 1.15 2013/03/22 04:37:49 fireton Exp $ }

// $Log: ddAutoLinker.pas,v $
// Revision 1.15  2013/03/22 04:37:49  fireton
// - �� �������� ��������������� �� �������
//
// Revision 1.14  2013/02/15 10:34:10  fireton
// - ��������� ������� � �������� ���������� ��� ��������������� ������
//
// Revision 1.13  2012/11/02 08:19:55  lulin
// - ������ �� �����.
//
// Revision 1.12  2012/11/01 09:43:24  lulin
// - ����� ����� � �������.
//
// Revision 1.11  2012/11/01 07:45:49  lulin
// - ������ ����������� ����������� �������� �������� �������.
//
// Revision 1.10  2012/10/31 18:38:03  kostitsin
// ������������ ������ Notify �� ���� �����������
//
// Revision 1.9  2012/10/26 08:37:29  narry
// ����������
//
// Revision 1.8  2011/11/24 09:23:56  fireton
// - ��� ����������� � ������� ������ ���������� ������� ������ �������
//
// Revision 1.7  2011/11/14 12:45:50  fireton
// - ������� ��������������� ������ � ��������� ������, �� �������
//
// Revision 1.6  2010/09/24 12:10:35  voba
// - k : 235046326
//
// Revision 1.5  2010/09/23 11:30:53  fireton
// - ��� ������ �������� �� ������ �����
// - �� ������ ������ �� ��������� ��� ���������, ���� �� ���� ��� � ������
//
// Revision 1.4  2010/01/13 13:40:23  fireton
// - ����������� �� ������������ ������ �������� � ��
// - ����������� ����������� �� ���������
//
// Revision 1.3  2009/12/24 14:49:34  fireton
// - ���������� ����������� ������
//
// Revision 1.2  2009/12/04 09:01:10  fireton
// - ����������� ������ � ��������
//
// Revision 1.1  2009/12/02 08:31:37  fireton
// - �������������� �������� ����������
//

interface
uses
 l3Base,
 l3Types,
 l3Interfaces,

 DT_Types,
 DT_Const,
 DT_IFltr,
 DT_Sab,

 m3DBInterfaces,
 m3DB,

 k2TagGen,

 evdHyperlinkEliminator,

 SewerPipe,
 ddImportPipeKernel,
 ddAutoLinkFilter,
 ddProgressObj;

type
 TddAutoLinker = class(Tl3Base, Il3ItemNotifyRecipient)
 private
  f_OutPipe: TSewerPipe;
  f_InPipe : TddImportPipeFilter;
  f_LastClearLinks: Boolean;
  f_LinkFilter: TddAutoLinkFilter;
  f_HyperlinkEliminator: TevdHyperlinkEliminator;
  procedure KillPipe;
  procedure MakePipe(aClearLinks: Boolean);
 protected
  procedure Cleanup; override;
  procedure Notify(const aNotifier: Il3ChangeNotifier; aOperation: Integer; aIndex: Integer);
 public
  constructor Create;
  procedure SetLinks(aDocList: ISab; aProgressor: TddProgressObject = nil; aClearLinks: Boolean = False);
  // aClearLinks - ������� �� ��� ������ ����� ����������������
 end;

function GetAutoLinker: TddAutoLinker;

implementation
uses
 dt_AttrSchema,
 DT_Serv,
 Dt_Fam,
 DT_UserConst,

 evdWriter,
 evEvdRd,

 k2Reader, evdLeafParaFilter;

const
 g_AutoLinker: TddAutoLinker = nil;

function GetAutoLinker: TddAutoLinker;
begin
 if g_AutoLinker = nil then
  g_AutoLinker := TddAutoLinker.Create;
 Result := g_AutoLinker;
end;


constructor TddAutoLinker.Create;
begin
 inherited Create(nil);
 Il3ChangeNotifier(GlobalHtServer).Subscribe(Il3ItemNotifyRecipient(Self));
end;

procedure TddAutoLinker.Cleanup;
begin
 KillPipe;
 inherited;
end;

procedure TddAutoLinker.KillPipe;
begin
 l3Free(f_InPipe);
 l3Free(f_OutPipe);
 l3Free(f_LinkFilter);
 l3Free(f_HyperlinkEliminator);
end;

procedure TddAutoLinker.MakePipe(aClearLinks: Boolean);
begin
 f_OutPipe := TSewerPipe.Create(nil);
 f_InPipe  := TddImportPipeFilter.Create(CurrentFamily);
 f_LinkFilter := GetAutoLinkFilter.Use;

 if aClearLinks then
 begin
  f_HyperlinkEliminator := TevdHyperlinkEliminator.Create;
  f_OutPipe.Writer := f_HyperlinkEliminator;
  f_HyperlinkEliminator.Generator := f_LinkFilter;
 end
 else
  f_OutPipe.Writer := f_LinkFilter;

 f_LinkFilter.Generator := f_InPipe;

 //f_OutPipe.Writer := f_InPipe; debug code
 f_InPipe.UpdateTables:= False;
 f_InPipe.CheckDocuments:= False;
 f_InPipe.NeedLockBase:= False;
 f_InPipe.DocumentReaction:= sdrDelete;
 f_InPipe.DeleteConditions := [dcAny];
 f_InPipe.InternalFormat:= False;
 f_InPipe.UserID:= usServerService;
 f_InPipe.ImportFilter.ExcludeAttr := CctAllAttributes - [ctHLink];
 f_InPipe.ImportFilter.ExcludeMainRec := True;

 f_OutPipe.ExportDocument:= True;
 f_OutPipe.ExportReferences:= False;
 f_OutPipe.ExportAnnotation:= False;
end;

procedure TddAutoLinker.Notify(const aNotifier: Il3ChangeNotifier; aOperation: Integer; aIndex: Integer);
begin
 if aOperation = sni_Destroy then
  KillPipe;
end;

procedure TddAutoLinker.SetLinks(aDocList: ISab; aProgressor: TddProgressObject = nil; aClearLinks: Boolean = False);
var
 l_DR: TDiapasonRec;
begin
 if f_LastClearLinks <> aClearLinks then
  KillPipe;
 f_LastClearLinks := aClearLinks; 
 if f_OutPipe = nil then
  MakePipe(aClearLinks);
 f_LinkFilter.UseInternalNumForLink(False);
 f_OutPipe.DocSab:= aDocList;
 f_OutPipe.Progressor := aProgressor;
 f_OutPipe.Execute([atDateNums, atHLink, atSub]);
end;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\dd\ddAutoLinker.pas initialization enter'); {$EndIf}

{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\dd\ddAutoLinker.pas initialization leave'); {$EndIf}
finalization
 l3Free(g_AutoLinker);
end.

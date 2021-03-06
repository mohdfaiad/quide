unit quideScenarios;

interface

uses
  SysUtils, Windows, Generics.Collections, Classes,
  quideObject, quideVariables, quideSteps, quideInventory, quideLocations;

type
  TquideScenario = class(TquideObject)
  private
    //1 ������ ���� ��������
    f_Chapters: TObjectList<TquideChapter>;
    f_LocationsNames: TStrings;
    f_VariablesNames: TStrings;
    function pm_GetChapters(Index: Integer): TquideChapter;
    function pm_GetChaptersCount: Integer;
    function pm_GetInventory(Index: Integer): TquideInventoryItem;
    function pm_GetInventoryItemsCount: Integer;
    function pm_GetLocationsNames: TStrings;
    function pm_GetVariables(Index: Integer): TquideVariable;
    function pm_GetVariablesCount: Integer;
    function pm_GetVariablesNames: TStrings;
    procedure UpdateChapters;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    procedure Clear; override;
    //1 ������� ����� � ��������� � ������
    function AddChapter: TquideChapter;
    function AddVariable(const aAlias, aHint: String; aVarType:
        TquideVariableType; aValue: string): TquideVariable; overload;
    function AddVariable: TquideVariable; overload;
    //1 �������� ��������� �����
    procedure Delete(Index: Integer);
    function IsValidLocation(const aCaption: String): TquideLocation;
    //1 ��������� ������ ���������� �� ������� � ��� ������ � ���������� ��
    function IsValidVariable(const aCaption: String): TquideVariable;
    procedure SaveToFile(const aFileName: String);
    procedure LoadFromFile(const aFileName: String);
    property Chapters[Index: Integer]: TquideChapter read pm_GetChapters;
        default;
    property ChaptersCount: Integer read pm_GetChaptersCount;
    property Inventory[Index: Integer]: TquideInventoryItem read
        pm_GetInventory;
    property InventoryItemsCount: Integer read pm_GetInventoryItemsCount;
    property LocationsNames: TStrings read pm_GetLocationsNames;
    property Variables[Index: Integer]: TquideVariable read pm_GetVariables;
    //1 ���������� ���������� � ��������
    property VariablesCount: Integer read pm_GetVariablesCount;
    //1 ������ ���� ���������� ��� ������������� � �������
    property VariablesNames: TStrings read pm_GetVariablesNames;
  end;


implementation

Uses
 XMLDoc, XMLIntf,
 Propertys, PropertyUtils;

{
******************************** TquideScenario ********************************
}
function TquideScenario.AddVariable: TquideVariable;
begin
 Assert(False, '����� ������������ �������� ����������')
 (*
 Result:= TquideVariable.Create(nil);
 f_Variables.Add(Result);
 *)
end;

procedure TquideScenario.Clear;
begin
  inherited;
  // ���������� ������ � ���������...
  f_Chapters.Clear;
  f_LocationsNames.Clear;
//  f_VariablesNames.Clear;
end;

constructor TquideScenario.Create;
begin
  inherited Create(aOwner);
  f_LocationsNames := TStringList.Create;
  f_Chapters := TObjectList<TquideChapter>.Create();
  Define('Author', '�����', ptString);
  DefineChoice('Start', '��������� �������');

  DefineList('Variables', '����������', True,
    NewProperty('Caption', '��������', ptString,
    {$IFDEF VarType}
    NewChoiceProperty('VarType', '���',  // vtNumeric, vtText, vtBoolean, vtEnum
      NewChoice(0, '�����',
      NewChoice(1, '������',
      NewChoice(2, '������',
      NewChoice(3, '������������',
      nil)))),
    {$ENDIF}
    NewProperty('Value', '��������', ptString,
    nil){$IFDEF VarType}){$ENDIF})
  );
  DefineList('Inventory', '���������', True,
    NewProperty('Caption', '��������', ptString,
    NewProperty('Count', '����������', ptString,
    nil))
  );
  Changed:= False;
end;

destructor TquideScenario.Destroy;
begin
  FreeAndNil(f_Chapters);
  FreeAndNil(f_LocationsNames);
  FreeAndNil(f_VariablesNames);
  inherited Destroy;
end;

function TquideScenario.AddChapter: TquideChapter;
begin
  Result := TquideChapter.Create(nil);
  f_Chapters.Add(Result);
  UpdateChapters;
  Changed:= False;

end;

function TquideScenario.AddVariable(const aAlias, aHint: String; aVarType:
    TquideVariableType; aValue: string): TquideVariable;
begin
 // ������ ��������� ���������� � ����������� �������
 if IsValidVariable(aAlias) = nil then
 begin
   Result:= AddVariable;
   Result.Caption:= aAlias;
   Result.Hint:= aHint;
   Result.VarType:= aVarType;
   VariablesNames.Add(aAlias);
 end
 else
   Result:= nil; // ��� Exception?
 //Result.Value:= aValue; ���� ��� ������ �� ���������
end;

procedure TquideScenario.Delete(Index: Integer);
begin
 //����� ��������� ����� ������ �� ��������� ��� ������� �� �������������
 f_Chapters.Delete(Index);
 UpdateChapters;
 Changed:= True;
end;

function TquideScenario.IsValidLocation(const aCaption: String): TquideLocation;
var
  i: Integer;
  l_Loc: TquideLocation;
begin
  Result:= nil;

  for i:= 0 to Pred(ChaptersCount) do
  begin
   l_Loc:= Chapters[i].IsValidLocation(aCaption);
   if l_Loc <> nil then
   begin
    Result:= l_Loc;
    break;
   end;
  end;
end;

function TquideScenario.IsValidVariable(const aCaption: String): TquideVariable;
var
  i: Integer;
begin
  Result:= nil;
  for i:= 0 to Pred(VariablesCount) do
   if Variables[i].ItsMe(aCaption) then
   begin
    Result:= Variables[i];
    break;
   end;
end;

procedure TquideScenario.LoadFromFile(const aFileName: String);
var
 l_Root, l_Node: IXMLNode;
 l_Doc: IXMLDocument;
 i: Integer;
begin
 // ������� �������� ���������
 f_Chapters.Clear;
 // �������� �� �����
 l_Doc:= TXMLDocument.Create(nil);
 l_Doc.Options:= l_Doc.Options + [doNodeAutoIndent];
 l_Doc.Active:= True;
 l_Doc.LoadFromFile(aFileName);
 l_Root:= l_Doc.ChildNodes.FindNode('Scenario');
 if l_Root <> nil then
 begin
   LoadFromXML(l_Root.ChildNodes.FindNode('Meta'), False);
   // �����
   l_Node:= l_Root.ChildNodes.FindNode('Chapters');
   if l_Node <> nil then
    for I := 0 to l_Node.ChildNodes.Count-1 do
     AddChapter.LoadFromXML(l_Node.ChildNodes.Get(i));
   //����������
   (*
   l_Node:= l_Root.ChildNodes.FindNode('Variables');
   if l_Node <> nil then
    for I := 0 to l_Node.ChildNodes.Count-1 do
     AddVariable.LoadFromXML(l_Node.ChildNodes.Get(i), False);
   *)
 end;
end;

function TquideScenario.pm_GetChapters(Index: Integer): TquideChapter;
begin
 Result:= TquideChapter(f_Chapters[Index])
end;

function TquideScenario.pm_GetChaptersCount: Integer;
begin
 Result:= f_Chapters.Count;
end;

function TquideScenario.pm_GetInventory(Index: Integer): TquideInventoryItem;
begin
 Assert(False, '������������ ������ � ����������');
 //Result:= TquideInventoryItem(f_Inventory[Index]);
end;

function TquideScenario.pm_GetInventoryItemsCount: Integer;
begin
  Assert(False, '������������ ������ � ����������');
 //Result:= f_Inventory.Count;
end;

function TquideScenario.pm_GetLocationsNames: TStrings;
var
 i, j: Integer;
 l_Chap: TquideChapter;
begin
  f_LocationsNames.Clear;
  for I := 0 to ChaptersCount-1 do
  begin
   l_Chap:= Chapters[i];
   for j := 0 to l_Chap.LocationsCount-1 do
    f_LocationsNames.Add(l_Chap.Locations[j].Caption);
  end;
  Result := f_LocationsNames;
end;

function TquideScenario.pm_GetVariables(Index: Integer): TquideVariable;
begin
  Assert(False, '������������ ������ � �����������');
 //Result:= TquideVariable(f_Variables[index]);
end;

function TquideScenario.pm_GetVariablesCount: Integer;
begin
  Assert(False, '������������ ������ � �����������');
 //Result:= f_Variables.Count;
end;

function TquideScenario.pm_GetVariablesNames: TStrings;
begin
  Result := ChoiceItems['Variables']
end;

procedure TquideScenario.SaveToFile(const aFileName: String);
var
 l_Scenario,
 l_Node: IXMLNode;
 l_Doc: IXMLDocument;
 i: Integer;
begin
 l_Doc:= TXMLDocument.Create(nil);
 l_Doc.Options:= l_Doc.Options + [doNodeAutoIndent];
 l_Doc.Active:= True;
 l_Doc.Encoding:= 'UTF-8';//'Windows-1251';
 l_Scenario:= l_Doc.AddChild('Scenario');
 // ����������� ��������
 l_Node:= l_Scenario.AddChild('Meta');
 SaveToXML(l_Node, False);
 // �����
 l_Node:= l_Scenario.AddChild('Chapters');
 for I := 0 to ChaptersCount-1 do
  Chapters[i].SaveToXML(l_Node.AddChild('Chapter'));
 // ����������
 l_Doc.SaveToFile(aFileName);
 // ������������
 PropertyUtils.SaveToFile(ChangeFileExt(aFileName, '.dat'), Self)
end;

procedure TquideScenario.UpdateChapters;
var
  l_Chapter: TquideChapter;
  i, j: Integer;
begin
 f_LocationsNames.Clear;
 for i:= 0 to Pred(ChaptersCount) do
 begin
  l_Chapter:= Chapters[i];
  for j:= 0 to Pred(l_Chapter.LocationsCount) do
   f_LocationsNames.Add(l_Chapter[j].Caption);
 end;
end;



end.

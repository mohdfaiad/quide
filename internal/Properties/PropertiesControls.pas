unit PropertiesControls;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls, Forms, Dialogs, stdCtrls, ExtCtrls,
  Propertys, Contnrs, Menus, QuestModeler, PropertyIntf;

type
  TPropertiesMemo = class(TMemo, IPropertyControl)
  private
    f_LineHeight: Integer;
    f_OnSizeChanged: TNotifyEvent;
    function pm_GetOnSizeChanged: TNotifyEvent; stdcall;
    function pm_GetValue: Variant; stdcall;
    procedure pm_SetOnSizeChanged(aValue: TNotifyEvent); stdcall;
    procedure pm_SetValue(const Value: Variant); stdcall;
  public
    constructor Create(aOwner: TComponent); override;
    procedure TextChanged(Sender: TObject);
    property LineHeight: Integer read f_LineHeight write f_LineHeight;
    property Value: Variant read pm_GetValue write pm_SetValue;
    property OnSizeChanged: TNotifyEvent read pm_GetOnSizeChanged write
        pm_SetOnSizeChanged;
  end;

  TControlAlign = (caNewLine, caInline);
  TControlRec = record
    ControlClass: TControlClass;
    Align: TControlAlign;
    Height: Integer;
  end;

  TControlsArray = array of TControlRec;
  //1 ������ ��� �������������� ������ �������
  TPropertiesPanel = class(TPanel, IControlContainer, IPropertyControlValue)
  private
    f_Controls: TList;
    f_OnSizeChanged: TNotifyEvent;
    f_Properties: TProperties;
    f_PropertyObject: TPropertyObject;
    procedure AddControl(aControl: TControl); stdcall;
    function pm_GetOnSizeChanged: TNotifyEvent; stdcall;
    function pm_GetValue: Variant; stdcall;
    procedure pm_SetOnSizeChanged(aValue: TNotifyEvent); stdcall;
    procedure pm_SetProperties(aValue: TProperties);
    procedure pm_SetPropertyObject(const Value: TPropertyObject);
    procedure pm_SetValue(const Value: Variant); stdcall;
  protected
    procedure MyControlResized(Sender: TObject);
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    procedure CreateControl(aProp: TProperty);
    procedure GetPropertyControls(aProp: TProperty; var l_Controls:
        TControlsArray); virtual;
    procedure GetValues;
    procedure ResizeControls;
    procedure SetValues;
    property Properties: TProperties read f_Properties write pm_SetProperties;
    property PropertyObject: TPropertyObject read f_PropertyObject write
        pm_SetPropertyObject;
    property Value: Variant read pm_GetValue write pm_SetValue;
    property OnSizeChanged: TNotifyEvent read pm_GetOnSizeChanged write
        pm_SetOnSizeChanged;
  end;

  TTextButton = class(TPanel)
  end;

type
  TPropertiesScrollBox = class(TScrollBox, IControlContainer)
  private
    f_EnableResize: Boolean;
    f_OnSizeChanged: TNotifyEvent;
    procedure AddControl(aControl: TControl); stdcall;
    function pm_GetOnSizeChanged: TNotifyEvent; stdcall;
    function pm_GetValue: Variant; stdcall;
    procedure pm_SetOnSizeChanged(aValue: TNotifyEvent); stdcall;
    procedure pm_SetValue(const Value: Variant); stdcall;
  protected
    procedure ControlResize(Sender: TObject);
  public
    constructor Create(aOwner: TComponent); override;
    procedure SelfResize(Sender: TObject);
    property Value: Variant read pm_GetValue write pm_SetValue;
    property OnSizeChanged: TNotifyEvent read pm_GetOnSizeChanged write
        pm_SetOnSizeChanged;
  end;

  TPropertiesEdit = class(TEdit, IPropertyControl)
  private
    f_OnSizeChanged: TNotifyEvent;
    function pm_GetOnSizeChanged: TNotifyEvent; stdcall;
    function pm_GetValue: Variant; stdcall;
    procedure pm_SetOnSizeChanged(aValue: TNotifyEvent); stdcall;
    procedure pm_SetValue(const Value: Variant); stdcall;
  public
    property Value: Variant read pm_GetValue write pm_SetValue;
    property OnSizeChanged: TNotifyEvent read pm_GetOnSizeChanged write
        pm_SetOnSizeChanged;
  end;

  TPropertiesComboBox = class(TComboBox, IPropertyControl)
  private
    f_OnSizeChanged: TNotifyEvent;
    function pm_GetOnSizeChanged: TNotifyEvent; stdcall;
    function pm_GetValue: Variant; stdcall;
    procedure pm_SetOnSizeChanged(aValue: TNotifyEvent); stdcall;
    procedure pm_SetValue(const Value: Variant); stdcall;
  public
    property Value: Variant read pm_GetValue write pm_SetValue;
    property OnSizeChanged: TNotifyEvent read pm_GetOnSizeChanged write
        pm_SetOnSizeChanged;
  end;

const
 cDefaultHeight = -1;

implementation

uses
 Math;

{
******************************* TPropertiesMemo ********************************
}
constructor TPropertiesMemo.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  OnChange:= TextChanged;
  LineHeight:= 16;
  Height:= 2*LineHeight + 4;
end;

function TPropertiesMemo.pm_GetOnSizeChanged: TNotifyEvent;
begin
  Result := f_OnSizeChanged;
end;

function TPropertiesMemo.pm_GetValue: Variant;
begin
  Result:= Text;
end;

procedure TPropertiesMemo.pm_SetOnSizeChanged(aValue: TNotifyEvent);
begin
  f_OnSizeChanged := aValue;
end;

procedure TPropertiesMemo.pm_SetValue(const Value: Variant);
begin
  Text:= Value;
end;

procedure TPropertiesMemo.TextChanged(Sender: TObject);
begin
  if Parent <> nil then
   Height:= (Lines.Count+1)*LineHeight;
  if Assigned(f_OnSizeChanged) then
   f_OnSizeChanged(Self);
end;

{
******************************* TPropertiesPanel *******************************
}
constructor TPropertiesPanel.Create(aOwner: TComponent);
begin
  inherited ;
  BevelOuter:= bvNone;
  Caption:= '';
  Color:= clGreen;
  Height:= 12;
  f_Controls := TList.Create();
end;

destructor TPropertiesPanel.Destroy;
begin
  FreeAndNil(f_Controls);
  inherited Destroy;
end;

procedure TPropertiesPanel.AddControl(aControl: TControl);
var
  l_IC: IPropertyControl;
begin
  f_Controls.Add(aControl);
  if aControl.GetInterface(IPropertyControl, l_IC) then
  begin
   l_IC.OnSizeChanged:= MyControlResized;
  end;
end;

procedure TPropertiesPanel.CreateControl(aProp: TProperty);
var
  l_Controls: TControlsArray;
  l_C: TControl;
  i: Integer;
begin
  if aProp.Visible then
  begin
   GetPropertyControls(aProp, l_Controls);
   for i:= 0 to Length(l_Controls)-1 do
   begin
    { TODO : ����� ��������� �������� ������������ }
    l_C:= l_Controls[i].ControlClass.Create(Self);
    l_C.Name:= l_C.ClassName + IntToStr(Succ(ControlCount));
    l_C.Top:= Height - 4;
    l_C.Left:= 8;
    if l_C is TLabel then
     TLabel(l_C).Caption:= aProp.Caption;
    l_C.Tag:= aProp.Index;
    l_C.Width:= Width - 8;
    Height:= l_C.Top + l_C.Height + 8;
    AddControl(l_C);
    InsertControl(l_C);
   end; // for i
  end; // aProp.Visible
end;

procedure TPropertiesPanel.GetPropertyControls(aProp: TProperty; var
    l_Controls: TControlsArray);
var
  i: Integer;
begin
  if aProp.PropertyType in [ptInteger, ptString, ptText, ptBoolean] then
  begin
   if aProp.Caption <> '' then
   begin
    SetLength(l_Controls, 2);
    l_Controls[0].ControlClass:= TLabel;
    l_Controls[0].Height:= cDefaultHeight;
   end
   else
    SetLength(l_Controls, 1);
   i:= Pred(Length(l_Controls));
   l_Controls[i].Height:= cDefaultHeight;
   case aProp.PropertyType of
    ptInteger: l_Controls[i].ControlClass:= TPropertiesEdit;
    ptString : l_Controls[i].ControlClass:= TPropertiesEdit;
    ptText   :
     begin
      l_Controls[i].ControlClass:= TPropertiesMemo;
      l_Controls[i].Height:= 32;
     end;
    ptBoolean: l_Controls[i].ControlClass:= TPropertiesComboBox;
   end;
  end
  else
   SetLength(l_Controls, 0);
end;

procedure TPropertiesPanel.GetValues;
var
  i: Integer;
  l_I: IPropertyControlValue;
begin
  for i:= 0 to ControlCount-1 do
  begin
   if Controls[i].GetInterface(IPropertyControlValue, l_I) then
    Properties[Controls[i].Tag].Value:= l_I.Value
  end;
end;

procedure TPropertiesPanel.MyControlResized(Sender: TObject);
var
  l_Index, l_Start: Integer;
  l_Delta, l_Height: Integer;
begin
  // ����� �������� ���� ���, ��� ���� ������� � ��������� ����������� ������
  l_Start:= f_Controls.IndexOf(Sender);
  if l_Start <> -1 then
  begin
   l_Height:= TControl(f_Controls[l_Start]).Top + TControl(f_Controls[l_Start]).Height;
   if f_Controls.Count > 1 then
   begin
    if l_Start < Pred(f_Controls.Count) then
     l_Delta:= l_Height - TControl(f_Controls[Succ(l_Start)]).Top + 8
    else
     l_Delta:= l_Height - Height;
    Height:= Height + l_Delta;
    for l_Index:= l_Start+1 to f_Controls.Count-1 do
    begin
     TControl(f_Controls[l_Index]).Top:= TControl(f_Controls[l_Index-1]).Top + l_Delta
    end;
   end
   else
   begin
    Height:= l_Height + 8;
    l_Delta:= 0;
   end;
   if Assigned(f_OnSizeChanged) then
    f_OnSizeChanged(Self);
  end; // l_Start <> -1
end;

function TPropertiesPanel.pm_GetOnSizeChanged: TNotifyEvent;
begin
  Result := f_OnSizeChanged;
end;

function TPropertiesPanel.pm_GetValue: Variant;
begin
  // TODO -cMM: TPropertiesPanel.pm_GetValue ���������� �������� ����������
end;

procedure TPropertiesPanel.pm_SetOnSizeChanged(aValue: TNotifyEvent);
begin
  f_OnSizeChanged := aValue;
end;

procedure TPropertiesPanel.pm_SetProperties(aValue: TProperties);
var
  i: Integer;
begin
  f_Properties := aValue;
  for i:= 0 to Pred(f_Properties.Count) do
  begin
   CreateControl(TProperty(f_Properties.Items[i]));
  end;
end;

procedure TPropertiesPanel.pm_SetPropertyObject(const Value: TPropertyObject);
begin
  f_PropertyObject := Value;
  Properties:= f_PropertyObject.Properties;
end;

procedure TPropertiesPanel.pm_SetValue(const Value: Variant);
begin
  // TODO -cMM: TPropertiesPanel.pm_SetValue ���������� �������� ����������
end;

procedure TPropertiesPanel.ResizeControls;
var
  i: Integer;
begin
  // ��������� ����� ����� �� ������������ �������
  if Parent <> nil then
  begin
   for i:= 0 to Pred(ControlCount) do
    if not (Controls[i] is TButton) then
     Controls[i].Width:= ClientWidth - 16;
  end;
end;

procedure TPropertiesPanel.SetValues;
var
  i: Integer;
  l_I: IPropertyControlValue;
begin
  for i:= 0 to ControlCount-1 do
  begin
   if Controls[i].GetInterface(IPropertyControlValue, l_I) then
    l_I.value:= Properties[Controls[i].Tag].Value
  end;
end;

{ TPropertiesScrollBox }

{
***************************** TPropertiesScrollBox *****************************
}
constructor TPropertiesScrollBox.Create(aOwner: TComponent);
begin
  inherited;
  Constraints.MinHeight:= 24;
  Constraints.MinWidth:= 100;
  OnResize:= SelfResize;
end;

procedure TPropertiesScrollBox.AddControl(aControl: TControl);
begin
  // TODO -cMM: TPropertiesScrollBox.AddControl ���������� �������� ����������
end;

procedure TPropertiesScrollBox.ControlResize(Sender: TObject);
var
  i: Integer;
  l_Move: Boolean;
  l_Delta: Integer;
begin
  // ���� �� ��������� ���������. ����� �������� ���� ����, ������� �� ���
  if f_EnableResize then
  begin
   l_Move:= False;
   l_Delta:= 0;
   for i:= 0 to ControlCount-1 do
   begin
    if l_Move then
     Controls[i].Top:= Controls[i].Top + l_Delta
    else
    if Controls[i] = Sender then
    begin
     l_Move:= True;
     if i < Pred(ControlCount) then
      l_Delta:= Controls[i].Top + Controls[i].Height - Controls[i+1].Top;
    end;
    if Controls[i] is TPropertiesPanel then
     TPropertiesPanel(Controls[i]).ResizeControls;
   end;
  end;
end;

function TPropertiesScrollBox.pm_GetOnSizeChanged: TNotifyEvent;
begin
  Result:= f_OnSizeChanged;
end;

function TPropertiesScrollBox.pm_GetValue: Variant;
begin
  Result:= Text;
end;

procedure TPropertiesScrollBox.pm_SetOnSizeChanged(aValue: TNotifyEvent);
begin
  f_OnSizeChanged:= aValue;
end;

procedure TPropertiesScrollBox.pm_SetValue(const Value: Variant);
begin
  Text:= Value;
end;

procedure TPropertiesScrollBox.SelfResize(Sender: TObject);
var
  i: Integer;
begin
  for i:= 0 to ControlCount-1 do
  begin
   Controls[i].Width:= ClientWidth;
   (Controls[i] as TPropertiesPanel).ResizeControls;
  end;
  if Assigned(f_OnSizeChanged) then
   f_OnSizeChanged(Self);
end;

{
******************************* TPropertiesEdit ********************************
}
function TPropertiesEdit.pm_GetOnSizeChanged: TNotifyEvent;
begin
  Result := f_OnSizeChanged;
end;

function TPropertiesEdit.pm_GetValue: Variant;
begin
  Result:= Text;
end;

procedure TPropertiesEdit.pm_SetOnSizeChanged(aValue: TNotifyEvent);
begin
  f_OnSizeChanged := aValue;
end;

procedure TPropertiesEdit.pm_SetValue(const Value: Variant);
begin
  Text := Value;
end;

{
***************************** TPropertiesComboBox ******************************
}
function TPropertiesComboBox.pm_GetOnSizeChanged: TNotifyEvent;
begin
  Result := f_OnSizeChanged;
end;

function TPropertiesComboBox.pm_GetValue: Variant;
begin
  Result:= ItemIndex;
end;

procedure TPropertiesComboBox.pm_SetOnSizeChanged(aValue: TNotifyEvent);
begin
  f_OnSizeChanged := aValue;
end;

procedure TPropertiesComboBox.pm_SetValue(const Value: Variant);
begin
  ItemIndex:= Value;
end;



end.
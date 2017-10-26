unit PropertiesDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  PropertiesControls, Propertys;

type
  TPropDialog = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
  private
    f_WorkPanel: TPropertiesPanel;
    procedure SetProperties(const Value: TProperties);
    procedure ResizePanel;
    function GetProperties: TProperties;
    function pm_GetLabelTop: Boolean;
    procedure pm_Setf_LabelTop(const Value: Boolean);
    { Private declarations }
  public
    { Public declarations }
    function Execute(var aProp: TProperties): Boolean;
    property LabelTop: Boolean read pm_GetLabelTop write pm_Setf_LabelTop;
    property WorkPanel: TPropertiesPanel read f_WorkPanel;
    property Properties: TProperties read GetProperties write SetProperties;
  end;

var
  PropDialog: TPropDialog;

implementation

Uses
 Math;

{$R *.dfm}

function TPropDialog.Execute(var aProp: TProperties): Boolean;
begin
 Result:= False;
 Properties:= aProp;
 if IsPositiveResult(ShowModal) then
 begin
   Result:= True;
   //��� ��� ������
   aProp:= Properties;
 end;
end;

procedure TPropDialog.FormCreate(Sender: TObject);
begin
  // �������� ������� ������
  f_WorkPanel:= TPropertiesPanel.Create(Self);
  InsertControl(f_WorkPanel);
  f_WorkPanel.Caption:= '';
  f_WorkPanel.Left:= 0;
  f_WorkPanel.Top:= 0;
  //f_WorkPanel.Height:= ClientHeight;
  f_WorkPanel.Width:= Button1.Left - 10;
end;

function TPropDialog.GetProperties: TProperties;
begin
 f_WorkPanel.GetValues;
 Result:= f_WorkPanel.Properties;
end;

function TPropDialog.pm_GetLabelTop: Boolean;
begin
 Result:= f_WorkPanel.LabelTop
end;

procedure TPropDialog.pm_Setf_LabelTop(const Value: Boolean);
begin
 f_WorkPanel.LabelTop:= Value;
end;

procedure TPropDialog.ResizePanel;
begin
 // ��������� ������ � ������ ��� ��������
 { TODO : ����� �����������, ����� �����, � �� ������ }
   Height:= Max(f_WorkPanel.Height, Height);
end;

procedure TPropDialog.SetProperties(const Value: TProperties);
begin
  F_WorkPanel.Properties := Value;
  ResizePanel;
end;

end.

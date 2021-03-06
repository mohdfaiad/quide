unit Rtf_api;

{ $Id: RTF_API.PAS,v 1.7 2013/04/11 16:46:26 lulin Exp $ }

// $Log: RTF_API.PAS,v $
// Revision 1.7  2013/04/11 16:46:26  lulin
// - ���������� ��� XE3.
//
// Revision 1.6  2007/08/14 19:31:52  lulin
// - ������������ ������� ������.
//
// Revision 1.5  2007/08/14 14:30:05  lulin
// - ������������ ����������� ������ ������.
//
// Revision 1.4  2003/04/19 12:30:36  law
// - new file: ddDefine.inc.
//
// Revision 1.3  2000/12/15 15:29:53  law
// - ��������� ��������� Log � Id.
//

{$I ddDefine.inc }

interface

function InitRTF(var H: Pointer; aFileName: PAnsiChar): Boolean; export;
{ ������� ���������� ������ }

function DoneRTF(var H: Pointer): Boolean; export;
{ ���������� ���������� ������ }

function RTFStatus(H: Pointer): Integer; export;
{ ���������� ���������� ��������� ������� }

function RTFObjID(H: Pointer): Byte; export;
{ ���������� ������������� �������� ������� }


function SetDocAttributes(H: Pointer; Coding: Integer; Language: Integer;
             Paper: Byte; { 0 - A4, 1 - A5, 2 - Letter, 3 - Legal, 4 - Executive}
             Before, After, Left, Right: Real; IndentMeasureUnit: Byte): Boolean; export;



function OpenFontTable(H: Pointer): Boolean; export;
{ ��������� ������ � ��������� ������ �������}

function CloseFontTable(H: Pointer): Boolean; export;
{ ��������� ��������� ������ �������. ��������� ����� OpenFontTable ��������
� ������ }

function InsertFont(H: Pointer; FNumber: Integer;     {\fN}
    FFontName: PAnsiChar): Boolean; export;
{ ��������� ����� ���� � ��������� �������. ���� ����� � ����� �������
��� ����������, �������� ��������� �� ������ }
function AddFont(H: Pointer; FNumber: Integer;     {\fN}
    FFamily: Byte; {\fnil\froman\fswiss\fmodern\fscript\fdecor\ftech\fbidi}
    FCharSet: Word;    {\fcharset}
    FPitch  : Byte;    {\fprq}
    FPanose : Longint; {\panose}
    FFontName: AnsiString;
    FAlternate: AnsiString;  {\falt}
    FFontType: Byte;{\ftnil\fttruetype}
    FCodePage: Integer {\cpg}): Integer;
{ ��������� ��������� ����� �� ���������� ��������� � ���������� ��� �����,
  ���� �� �� ��� ������ ����� �������. � ������ ���������� ������ �����
  �� ����������� � ������������ ��������� ������ ecDuplicateID.
  ���������� ������ �������� ������ � ����� ������ ���������.
  ����� ������������� ������ �� ������� (��������, ����������� ����� ���
  ����� ������), ������� ���������� ������ ������������. }

function CheckFont(H: Pointer; aFontName: PAnsiChar): Integer; export;
{ ��������� ������� ���������� ������ � �������. ���������� ���� ��� �����,
  ���� -1 }

function OpenColorTable(H: Pointer): Boolean; export;
{ ��������� ������� ������ ��� ������ ������ }

function CloseColorTable(H: Pointer): Boolean; export;
{��������� ������� �������}
function AddColor(H: Pointer; Color: Longint; var No: Byte): Boolean; export;
{��������� ����, �������� ����������� �������-�������-����� � ������� ������  }
function AddRGBColor(H: Pointer; Red, Green, Blue: Byte; var No: Byte): Boolean; export;
{��������� ����, �������� �������, ������� � ����� ������������� � ������� ������}

function OpenStyleTable(H: Pointer): Boolean; export;
{ ��������� ������� ������ }
function CloseStyleTable(H: Pointer): Boolean; export;
{ ��������� ������� ������ }
function AddParagraphStyle(H: Pointer; StyleNo: Byte; StyleName: PAnsiChar;
             Align: Byte; First, Before, After, Left, Right: Real; IndentMeasureUnit: Byte;
             InterLine: Real; ILMeasureUnit: Byte;
             FontNo: Byte; FontSize: Byte; Bold, Italic, Underline: Boolean;
             ForegroundColor, BackgroundColor: Byte; CharPosition: Byte): Boolean; export;
{ ��������� ����� ����� ��������� � ������� ������.
    StyleNo: Byte;      ����� ������������ �����
    StyleName: AnsiString;  ��� ������������ �����
    Align: Byte;        ������������ (0 - �����, 1 - ������, 2 - �� ������, 3 - �� ������)
    First,              ������ ������ ������ (������������� �������� - ������)
    Before,             �������� �� ������
    After,              �������� ����� ������
    Left,               ������ �����
    Right: Real;        ������ ������
    IndentMeasureUnit: Byte; ������� ��������� ��� ���������� � ��������(0- �����, 1 - ����������)
    InterLine: Real;    ���������� ����� ��������
    ILMeasureUnit: Byte; ������� ��������� ��� ������������ ��������� (0 - ������, 1- �����, 2 - ����������)
    FontNo: Byte;       ����� ������ ������
    FontSize: Byte;     ������ ������ � �������
    Bold,               ���������� ����������
    Italic,             ��������� ����������
    Underline: Boolean; �������������
    ForegroundColor,    ����� ����� �������� � ������� ������
    BackgroundColor: Byte; ����� ����� ���� � ������� ������
    CharPosition: Byte  ������� �������� (0 - �������, 1 -������� ������, 2 - ������}

function AddCharacterStyle(H: Pointer; StyleNo: Byte; StyleName: PAnsiChar;
             FontNo: Byte; FontSize: Byte; Bold, Italic, Underline: Boolean;
             ForegroundColor, BackgroundColor: Byte; CharPosition: Byte): Boolean; export;
{ ��������� ����� ����� �������� � ������� ������.
    StyleNo: Byte;      ����� ������������ �����
    StyleName: AnsiString;  ��� ������������ �����
    FontNo: Byte;       ����� ������ ������
    FontSize: Byte;     ������ ������ � �������
    Bold,               ���������� ����������
    Italic,             ��������� ����������
    Underline: Boolean; �������������
    ForegroundColor,    ����� ����� �������� � ������� ������
    BackgroundColor: Byte; ����� ����� ���� � ������� ������
    CharPosition: Byte  ������� �������� (0 - �������, 1 -������� ������, 2 - ������ }

function WriteParagraph(H: Pointer; ParaStyle: Byte;
                        Buffer: Pointer; BufferLen: Word): Boolean; export;
{ ���������� ��������� ���� ��� ������ ��������, ���������� ��� ��������� ����� }
function OpenParagraph(H: Pointer; ParaStyle: Byte): Boolean; export;
{ ��������� �������� � ��������� ������ }
function OpenParagraphAttr(H: Pointer; Align: Byte; First, Before, After,
                           Left, Right: Real; IndentMeasureUnit: Byte;
                           InterLine: Real; ILMeasureUnit: Byte): Boolean; export;
{ ��������� �������� � ���������������� ������� ��� ��������� }
function CloseParagraph(H: Pointer): Boolean; export;
{ ��������� �������� }
function SetParagraphAttr(H: Pointer; Align: Byte; First, Before, After,
                           Left, Right: Real; IndentMeasureUnit: Byte;
                           InterLine: Real; ILMeasureUnit: Byte): Boolean; export;
{ ������������� �������� ��������� }
function AddTab(H: Pointer; Size: Real; MeasureUnit: Byte;
                TabKind: Byte; TabLead: Byte): Boolean; export;
{ ��������� � �������� ��������� ��������� ��������� ���������
  Size    - ������� � ������ ��� �����������
  TabKind - ������������ ������ ������������ ������� ���������
            (0-�����, 1-������, 2-�� ������, 3-�� ���������� �����)
  TabLead - ����������� ���������
            (0-���, 1-�����, 2-�������, 3-�������������, 4-������ �����, 5-���� �����)
   }


function SetCharacterAttr(H: Pointer;
             FontNo: Byte; FontSize: Byte; Bold, Italic, Underline: Boolean;
             ForegroundColor, BackgroundColor: Byte; CharPosition: Byte): Boolean; export;
{ ������������� �������� ������� }


procedure WriteText(H: Pointer; aText: PAnsiChar); export;
{ ������� ��������� ����� � ����. ���������� �� ������������� }

procedure WriteTextAttr(H: Pointer; aText: PAnsiChar; FontNumber: Integer;
                         FontSize: Integer;
                         ColorF: Integer;
                         ColorB: Integer;
                         Bold: Boolean;
                         Italic: Boolean;
                         Underline: Boolean;
                         Striked: Byte;
                         CharPos: Byte;
                         Scale: Integer;
                         Expan: Integer;
                         KerningSize: Integer); export;
{ ������� �������� ����� ������ � ��������� �����������. ���������� ���������
  ������ � ������� ���������� ��������� }

function OpenTable(H: Pointer): Boolean; export;
{ ������������� ��������� �������. ����� ����� �������� ����� ����
  CloseTable, ���� OpenRow }

function CloseTable(H: Pointer): Boolean; export;
{ �������� ������� ������� }
function SetTableAttr(H: Pointer; BorderUp, BorderLeft, BorderBottom, BorderRight: Boolean;
                      BorderWidth: Real): Boolean;
{������������� �������� ���� ������� - ������� ������� ����� � �� �������}
function OpenRow(H: Pointer): Boolean; export;
{��������� ������ �������}
function CloseRow(H: Pointer): Boolean; export;
{��������� ������ ������� }
function SetRowAttr(H: Pointer): Boolean;
{������������� �������� ������ ������� ???}
function AddCell(H: Pointer; aWidth: Real; MeasureUnit: Byte): Boolean; export;
{��������� �������� ������ ������ - �� ������ � ������� �����}
function OpenCell(H: Pointer): Boolean; export;
{��������� ������ ��� ������ � ��� ������}
function CloseCell(H: Pointer): Boolean; export;
{��������� ������ }

function StartNumbering(H: Pointer; Style: Byte; StartNo: Byte; Text: PAnsiChar): Boolean; export;
{ �������� ����� ������������ �������. Style - 0 ������, 1  }

function ContinueNumbering(H: Pointer; Text: PAnsiChar): Boolean; export;
{ ���������� ������, ������� ������� StartNumbering }


{ ��������� � �������� ��� ����������� ������������� }
procedure StartObject(H: Pointer; objID: Integer; Default: Boolean);
{ �������� ����� ������. �� ��������� ������� �������� ��������� �����.
  ������� �������, ���� �� ��������� ���� ������ ����� �� ��������
  StartObject(H, objPara) }

procedure FinishObject(H: Pointer; objID: Integer);
{ ����������� ������� ������. ���� ������� �������� ������� �����,
  �� ������������� ���������� ����� �����. }

procedure SetProperty(H: Pointer; objID: Integer; propID: Integer; propValue: Longint);
{������������� ���������� ������ �������� �������� � ��������� ��������.
 ���� ��� ��������, ���������� ������������ � ����, ����� �������������
 �� ���������� ���������� }

procedure ClearProperties(H: Pointer; objID: Integer);
{ ���������� ��� ���������� ���������� ������� � �������� �� ��������� }



implementation

Uses RTF_w, RTFTypes, SysUtils;

function InitRTF(var H: Pointer; aFileName: PAnsiChar): Boolean;
{ ������� ���������� ������ }
begin
  try
    H:= TRTFWriter.Create;
    TRTFWriter(H).FileName:= StrPas(aFileName);

    Result:= TRTFWriter(H).Status = ecOk;
  except
    Result:= False;
  end;
end;

function DoneRTF(var H: Pointer): Boolean;
{ ���������� ���������� ������ }
begin
  try
    TRTFWriter(H).Destroy;
    Result:= True;
  except
    Result:= False;
  end;
end;

function RTFStatus(H: Pointer): Integer;
{ ���������� ���������� ��������� ������� }
begin
  try
    Result:= Ord(TRTFWriter(H).Status)
  except
    Result:= -1;
  end;
end;

function RTFObjID(H: Pointer): Byte;
begin
  try
    Result:= TRTFWriter(H).ObjID;
  except
    Result:= 255;
  end;
end;

function OpenFontTable(H: Pointer): Boolean;
{ ��������� ������ � ��������� ������ �������}
begin
  try
    TRTFWriter(H).OpenFontTable;
    Result:= TRTFWriter(H).Status = ecOk;
  except
    Result:= False;
  end;
end;

function CloseFontTable(H: Pointer): Boolean;
{ ��������� ��������� ������ �������. ��������� ����� OpenFontTable ��������
� ������ }
begin
  try
    TRTFWriter(H).CloseFontTable;
    Result:= TRTFWriter(H).Status = ecOk;
  except
    Result:= False;
  end;
end;

function InsertFont(H: Pointer; FNumber: Integer;     {\fN}
    FFontName: PAnsiChar): Boolean;
begin
  Result:= TRTFWriter(H).InsertFont(FNumber, StrPas(FFontName)) <> -1;
end;

function AddFont(H: Pointer; FNumber: Integer;     {\fN}
    FFamily: Byte; {\fnil\froman\fswiss\fmodern\fscript\fdecor\ftech\fbidi}
    FCharSet: Word;    {\fcharset}
    FPitch  : Byte;    {\fprq}
    FPanose : Longint; {\panose}
    FFontName: AnsiString;
    FAlternate: AnsiString;  {\falt}
    FFontType: Byte;{\ftnil\fttruetype}
    FCodePage: Integer {\cpg}): Integer;
{ ��������� ��������� ����� �� ���������� ��������� � ���������� ��� �����,
  ���� �� �� ��� ������ ����� �������. � ������ ���������� ������ �����
  �� ����������� � ������������ ��������� ������ ecDuplicateID.
  ���������� ������ �������� ������ � ����� ������ ���������.
  ����� ������������� ������ �� ������� (��������, ����������� ����� ���
  ����� ������), ������� ���������� ������ ������������. }
begin
end;

function CheckFont(H: Pointer; aFontName: PAnsiChar): Integer;
{ ��������� ������� ���������� ������ � �������. ���������� ���� ��� �����,
  ���� -1 }
begin
  try
    Result:= TRTFWriter(H).CheckFont(StrPas(aFontname));
  except
    Result:= -1;
  end;
end;

procedure SetDocProperty(H: Pointer; propID: Integer; propValue: Longint);
begin
  case propID of
    ipropName: TRTFWriter(H).FileName:= String(Pointer(propValue)^);
  end;
end;

procedure SetParaProperty(H: Pointer; propID: Integer; propValue: Longint);
begin
end;

procedure SetCharProperty(H: Pointer; propID: Integer; propValue: Longint);
begin
  TRTFWriter(H).SetCharProperty(propID, propValue, True);
end;

procedure SetProperty(H: Pointer; objID: Integer; propID: Integer; propValue: Longint);
{������������� ���������� ������ �������� �������� � ��������� ��������.
 ���� ��� ��������, ���������� ������������ � ����, ����� �������������
 �� ���������� ���������� }
begin
  begin
    case objID of
      rsDocument : SetDocProperty(H, propID, propValue);
      rsParagraph: SetParaProperty(H, propID, propValue);
      rsChar: SetCharProperty(H, propID, propValue);
    end;
  end;
end;

procedure ClearProperties(H: Pointer; objID: Integer);
{ ���������� ��� ���������� ���������� ������� � �������� �� ��������� }
begin
end;


procedure WriteText(H: Pointer; aText: PAnsiChar);
{ ������� ��������� ����� � ����. ���������� �� ������������� }
begin
  TRTFWriter(H).WriteBlock(aText);
end;

procedure WriteTextAttr(H: Pointer; aText: PAnsiChar; FontNumber: Integer;
                         FontSize: Integer;
                         ColorF: Integer;
                         ColorB: Integer;
                         Bold: Boolean;
                         Italic: Boolean;
                         Underline: Boolean;
                         Striked: Byte;
                         CharPos: Byte;
                         Scale: Integer;
                         Expan: Integer;
                         KerningSize: Integer);
{ ������� �������� ����� ������ � ��������� �����������. ���������� ���������
  ������ � ������� ���������� ��������� }
begin
  TRTFWriter(H).WriteToFile(aText, FontNumber, FontSize, ColorF, ColorB,
                         Bold, Italic, Underline, TStrikeType(Striked),
                         TCharPosition(CharPos), Scale, Expan,
                         KerningSize);
end;

procedure StartObject(H: Pointer; objID: Integer; Default: Boolean);
{ �������� ����� ������. �� ��������� ������� �������� ��������� �����.
  ������� �������, ���� �� ��������� ���� ������ ����� �� ��������
  StartObject(H, objPara) }
begin
  TRTFWriter(H).StartObject(objID);
  if Default then
    TRTFWriter(H).ClearProperties(objID);
end;


procedure FinishObject(H: Pointer; objID: Integer);
{ ����������� ������� ������. ���� ������� �������� ������� �����,
  �� ������������� ���������� ����� �����. }
begin
  TRTFWriter(H).EndObject(objID);
end;


function OpenColorTable(H: Pointer): Boolean;
begin
  TRTFWriter(H).OpenColorTable;
  Result:= TRTFWriter(H).Status = ecOk;
end;

function CloseColorTable(H: Pointer): Boolean;
begin
  TRTFWriter(H).CloseColorTable;
  Result:= TRTFWriter(H).Status = ecOk;
end;


function AddColor(H: Pointer; Color: Longint; var No: Byte): Boolean;
begin
  TRTFWriter(H).InsertColor(Color, No);
  Result:= TRTFWriter(H).Status = ecOk;
end;


function AddRGBColor(H: Pointer; Red, Green, Blue: Byte; var No: Byte): Boolean;
begin
  TRTFWriter(H).InsertRGBColor(Red, Green, Blue, No);
  Result:= TRTFWriter(H).Status = ecOk;
end;

function OpenStyleTable(H: Pointer): Boolean;
begin
  TRTFWriter(H).OpenStyleTable;
  Result:= TRTFWriter(H).Status = ecOk;
end;

function CloseStyleTable(H: Pointer): Boolean;
begin
  tRTFWriter(H).CloseStyleTable;
  Result:= TRTFWriter(H).Status = ecOk;
end;

function AddParagraphStyle(H: Pointer; StyleNo: Byte; StyleName: PAnsiChar;
             Align: Byte; First, Before, After, Left, Right: Real; IndentMeasureUnit: Byte;
             InterLine: Real; ILMeasureUnit: Byte;
             FontNo: Byte; FontSize: Byte; Bold, Italic, Underline: Boolean;
             ForegroundColor, BackgroundColor: Byte; CharPosition: Byte): Boolean;
begin
  tRTFWriter(H).AddParagraphStyle(StyleNo, StrPas(StyleName),
             Align, First, Before, After, Left, Right, IndentMeasureUnit,
             InterLine, ILMeasureUnit, FontNo, FontSize, Bold, Italic, Underline,
             ForegroundColor, BackgroundColor, CharPosition);
  Result:= TRTFWriter(H).Status = ecOk;
end;

function AddCharacterStyle(H: Pointer; StyleNo: Byte; StyleName: PAnsiChar;
             FontNo: Byte; FontSize: Byte; Bold, Italic, Underline: Boolean;
             ForegroundColor, BackgroundColor: Byte; CharPosition: Byte): Boolean;
begin
  tRTFWriter(H).AddCharacterStyle(StyleNo, StrPas(StyleName),
             FontNo, FontSize, Bold, Italic, Underline,
             ForegroundColor, BackgroundColor, CharPosition);
  Result:= TRTFWriter(H).Status = ecOk;
end;


function WriteParagraph(H: Pointer; ParaStyle: Byte;
                        Buffer: Pointer; BufferLen: Word): Boolean;
var
  C: PAnsiChar;
begin
  try
    if OpenParagraph(H, ParaStyle) then
    begin
      GetMem(C, BufferLen+1);
      l3FillChar(C[0], BufferLen+1, 0);
      l3Move(Buffer^, C[0], BufferLen);
      WriteText(H, C);
      FreeMem(C, BufferLen+1);
      CloseParagraph(H);
      Result:= True;
    end
    else
      Result:= False;
   except
     Result:= False;
   end;
end;

function OpenParagraph(H: Pointer; ParaStyle: Byte): Boolean;
begin
  try
    TRTFWriter(H).OpenParagraph(ParaStyle);
    Result:= TRTFWriter(H).Status = ecOk;
  except
    Result:= False;
  end;
end;

function OpenParagraphAttr(H: Pointer; Align: Byte; First, Before, After,
                           Left, Right: Real; IndentMeasureUnit: Byte;
                           InterLine: Real; ILMeasureUnit: Byte): Boolean;
begin
  try
    TRTFWriter(H).OpenParagraphAttr(Align, First, Before, After,
                           Left, Right, IndentMeasureUnit,
                           InterLine, ILMeasureUnit);
    Result:= TRTFWriter(H).Status = ecOk;
  except
    Result:= False;
  end;
end;

function CloseParagraph(H: Pointer): Boolean;
begin
  try
    TRTFWriter(H).CloseParagraph;
    Result:= TRTFWriter(H).Status = ecOk;
  except
    Result:= False;
  end;
end;

function SetParagraphAttr(H: Pointer; Align: Byte; First, Before, After,
                           Left, Right: Real; IndentMeasureUnit: Byte;
                           InterLine: Real; ILMeasureUnit: Byte): Boolean;
begin
  try
    TRTFWriter(H).SetParagraphAttr(Align, First, Before, After,
                           Left, Right, IndentMeasureUnit,
                           InterLine, ILMeasureUnit);
    Result:= TRTFWriter(H).Status = ecOk;
  except
    Result:= False;
  end;
end;

function SetCharacterAttr(H: Pointer;
             FontNo: Byte; FontSize: Byte; Bold, Italic, Underline: Boolean;
             ForegroundColor, BackgroundColor: Byte; CharPosition: Byte): Boolean;
begin
  try
    TRTFWriter(H).SetCharacterAttr(FontNo, FontSize, Bold, Italic, Underline,
             ForegroundColor, BackgroundColor, CharPosition);
    Result:= TRTFWriter(H).Status = ecOk;
  except
    Result:= False;
  end;
end;

function SetDocAttributes(H: Pointer; Coding: Integer; Language: Integer;
             Paper: Byte; { 0 - A4, 1 - A5, 2 - Letter, 3 - Legal, 4 - Executive}
             Before, After, Left, Right: Real; IndentMeasureUnit: Byte): Boolean;
begin
  try
    TRTFWriter(H).SetDocAttributes(Coding, Language, Paper,
                  Before, After, Left, Right, IndentMeasureUnit);
    Result:= TRTFWriter(H).Status = ecOk;
  except
    Result:= False;
  end;
end;

function OpenTable(H: Pointer): Boolean;
begin
  try
    TRTFWriter(H).OpenTable;
    Result:= TRTFWriter(H).Status = ecOk;
  except
    Result:= False
  end;
end;

function CloseTable(H: Pointer): Boolean;
begin
  try
    TRTFWriter(H).CloseTable;
    Result:= TRTFWriter(H).Status = ecOk;
  except
    Result:= False
  end;
end;

function SetTableAttr(H: Pointer; BorderUp, BorderLeft, BorderBottom, BorderRight: Boolean;
                      BorderWidth: Real): Boolean;
begin
  try
    TRTFWriter(H).SetTableAttr(BorderUp, BorderLeft, BorderBottom, BorderRight,
                      BorderWidth);
    Result:= TRTFWriter(H).Status = ecOk;
  except
    Result:= False
  end;
end;

function OpenRow(H: Pointer): Boolean;
begin
  try
    TRTFWriter(H).OpenRow;
    Result:= TRTFWriter(H).Status = ecOk;
  except
    Result:= False
  end;
end;

function CloseRow(H: Pointer): Boolean;
begin
  try
    TRTFWriter(H).CloseRow;
    Result:= TRTFWriter(H).Status = ecOk;
  except
    Result:= False
  end;
end;

function SetRowAttr(H: Pointer): Boolean;
begin
  try
    TRTFWriter(H).SetRowAttr;
    Result:= TRTFWriter(H).Status = ecOk;
  except
    Result:= False
  end;
end;

function AddCell(H: Pointer; aWidth: Real; MeasureUnit: Byte): Boolean;
begin
  try
    TRTFWriter(H).AddCell(aWidth, MeasureUnit);
    Result:= TRTFWriter(H).Status = ecOk;
  except
    Result:= False
  end;
end;

function OpenCell(H: Pointer): Boolean;
begin
  try
    TRTFWriter(H).OpenCell;
    Result:= TRTFWriter(H).Status = ecOk;
  except
    Result:= False
  end;
end;

function CloseCell(H: Pointer): Boolean;
begin
  try
    TRTFWriter(H).CloseCell;
    Result:= TRTFWriter(H).Status = ecOk;
  except
    Result:= False
  end;
end;

function AddTab(H: Pointer; Size: Real; MeasureUnit: Byte;
                TabKind: Byte; TabLead: Byte): Boolean; 
{ ��������� � �������� ��������� ��������� ��������� ���������
  Size    - ������� � ������ ��� �����������
  TabKind - ������������ ������ ������������ ������� ���������
            (0-�����, 1-������, 2-�� ������, 3-�� ���������� �����)
  TabLead - ����������� ���������
            (0-���, 1-�����, 2-�������, 3-�������������, 4-������ �����, 5-���� �����)
   }
begin
  try
   TRTFWriter(H).AddTab(Size, MeasureUnit, TabKind, TabLead);
   Result:= TRTFWriter(H).Status = ecOk;
  except
    Result:= False;
  end;
end;

function StartNumbering(H: Pointer; Style: Byte; StartNo: Byte; Text: PAnsiChar): Boolean;
{ �������� ����� ������������ �������. Style - 0 ������, 1  }
begin
  try
   TRTFWriter(H).StartNumbering(Style, StartNo, Text);
   Result:= TRTFWriter(H).Status = ecOk;
  except
    Result:= False;
  end;
end;

function ContinueNumbering(H: Pointer; Text: PAnsiChar): Boolean;
{ ���������� ������, ������� ������� StartNumbering }
begin
  try
   TRTFWriter(H).ContinueNumbering(Text);
   Result:= TRTFWriter(H).Status = ecOk;
  except
    Result:= False;
  end;
end;


end.

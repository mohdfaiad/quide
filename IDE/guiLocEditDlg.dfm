object LocationDlg: TLocationDlg
  Left = 295
  Top = 168
  Caption = #1053#1086#1074#1072#1103' '#1083#1086#1082#1072#1094#1080#1103
  ClientHeight = 482
  ClientWidth = 726
  Color = clBtnFace
  Constraints.MinHeight = 408
  Constraints.MinWidth = 635
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    726
    482)
  PixelsPerInch = 96
  TextHeight = 17
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 629
    Height = 468
    Anchors = [akLeft, akTop, akRight, akBottom]
    Shape = bsFrame
  end
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 57
    Height = 17
    Caption = #1053#1072#1079#1074#1072#1085#1080#1077
  end
  object OKBtn: TButton
    Left = 643
    Top = 8
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
    OnClick = OKBtnClick
  end
  object CancelBtn: TButton
    Left = 643
    Top = 39
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object editCaption: TEdit
    Left = 96
    Top = 16
    Width = 532
    Height = 25
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 2
    OnChange = editCaptionChange
  end
  object ActionsPanel: TPanel
    Left = 16
    Top = 48
    Width = 612
    Height = 273
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 3
    DesignSize = (
      612
      273)
    object EditPanel: TPanel
      Left = 144
      Top = 40
      Width = 460
      Height = 225
      Anchors = [akLeft, akTop, akRight, akBottom]
      TabOrder = 0
    end
    object ToolBar1: TToolBar
      Left = 1
      Top = 1
      Width = 610
      Height = 29
      Caption = 'ActionEditToolbar'
      Images = ImageList1
      TabOrder = 1
      object Label3: TLabel
        Left = 0
        Top = 0
        Width = 145
        Height = 22
        AutoSize = False
        Caption = '  '#1057#1087#1080#1089#1086#1082' '#1076#1077#1081#1089#1090#1074#1080#1081
        Layout = tlCenter
      end
      object ToolButton1: TToolButton
        Left = 145
        Top = 0
        Action = NewAction
        DropdownMenu = TypeDropDown
        Style = tbsDropDown
      end
      object ToolButton2: TToolButton
        Left = 183
        Top = 0
        Action = DelAction
      end
      object ToolButton3: TToolButton
        Left = 206
        Top = 0
        Action = MoveUpAction
      end
      object ToolButton4: TToolButton
        Left = 229
        Top = 0
        Action = MoveDownAction
      end
    end
    object treeActions: TTreeView
      Left = 8
      Top = 40
      Width = 129
      Height = 225
      Indent = 19
      TabOrder = 2
      OnChange = treeActionsChange
    end
  end
  object Panel1: TPanel
    Left = 16
    Top = 320
    Width = 617
    Height = 153
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 4
    object ToolBar2: TToolBar
      Left = 1
      Top = 1
      Width = 615
      Height = 29
      Caption = 'ActionEditToolbar'
      Images = ImageList1
      TabOrder = 0
      object Label2: TLabel
        Left = 0
        Top = 0
        Width = 145
        Height = 22
        AutoSize = False
        Caption = '  '#1050#1085#1086#1087#1082#1080
        Layout = tlCenter
      end
      object ToolButton5: TToolButton
        Left = 145
        Top = 0
        Action = ButtonAction
      end
      object ToolButton6: TToolButton
        Left = 168
        Top = 0
        Action = ButtonDelete
      end
      object ToolButton7: TToolButton
        Left = 191
        Top = 0
        Action = ButtonUp
      end
      object ToolButton8: TToolButton
        Left = 214
        Top = 0
        Action = ButtonDown
      end
    end
    object ButtonsListBox: TListBox
      Left = 8
      Top = 32
      Width = 129
      Height = 113
      ItemHeight = 17
      TabOrder = 1
      OnClick = ButtonsListBoxClick
    end
    object ButtonsPanel: TPanel
      Left = 144
      Top = 32
      Width = 465
      Height = 113
      TabOrder = 2
    end
  end
  object TypeDropDown: TPopupMenu
    Images = ImageList1
    Left = 560
    Top = 88
    object N1: TMenuItem
      Action = TextAction
      Default = True
    end
    object N3: TMenuItem
      Action = InventaryAction
    end
    object N4: TMenuItem
      Action = VariableAction
    end
    object N5: TMenuItem
      Action = LogicalAction
    end
    object N2: TMenuItem
      Action = GotoAction
    end
  end
  object ActionList1: TActionList
    Images = ImageList1
    Left = 544
    Top = 160
    object TextAction: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1103
      Caption = #1058#1077#1082#1089#1090
      Hint = #1042#1099#1074#1086#1076' '#1090#1077#1082#1089#1090#1072
      OnExecute = TextActionExecute
    end
    object DelAction: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1103
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Enabled = False
      Hint = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 1
      ShortCut = 46
      OnExecute = DelButtonClick
    end
    object MoveUpAction: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1103
      Caption = #1042#1099#1096#1077
      Enabled = False
      Hint = #1055#1077#1088#1077#1084#1077#1089#1090#1080#1090#1100' '#1076#1077#1081#1089#1090#1074#1080#1077' '#1074#1074#1077#1088#1093
      ImageIndex = 2
      OnExecute = MoveUpActionExecute
    end
    object MoveDownAction: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1103
      Caption = #1053#1080#1078#1077
      Enabled = False
      Hint = #1055#1077#1088#1077#1084#1077#1089#1090#1080#1090#1100' '#1076#1077#1081#1089#1090#1074#1080#1077' '#1085#1080#1078#1077
      ImageIndex = 3
      OnExecute = MoveDownActionExecute
    end
    object NewAction: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1103
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      ImageIndex = 0
      OnExecute = TextActionExecute
    end
    object GotoAction: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1103
      Caption = #1055#1077#1088#1077#1093#1086#1076
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1087#1077#1088#1077#1093#1086#1076' '#1085#1072' '#1083#1086#1082#1072#1094#1080#1102
      OnExecute = GotoActionExecute
    end
    object InventaryAction: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1103
      Caption = #1048#1085#1074#1077#1085#1090#1072#1088#1100
    end
    object VariableAction: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1103
      Caption = #1055#1077#1088#1077#1084#1077#1085#1085#1072#1103
      OnExecute = VariableActionExecute
    end
    object LogicalAction: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1103
      Caption = #1059#1089#1083#1086#1074#1080#1077
    end
    object ButtonAction: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1103
      Caption = #1050#1085#1086#1087#1082#1072
      ImageIndex = 0
      OnExecute = ButtonActionExecute
    end
    object ButtonDelete: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1103
      Enabled = False
      ImageIndex = 1
    end
    object ButtonUp: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1103
      Caption = 'ButtonUp'
      Enabled = False
      ImageIndex = 2
    end
    object ButtonDown: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1103
      Caption = 'ButtonDown'
      Enabled = False
      ImageIndex = 3
    end
  end
  object ImageList1: TImageList
    Left = 552
    Top = 240
    Bitmap = {
      494C010104000900080010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080000000000000000000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      0000FFFFFF0000FFFF0000000000808080000000000000000000FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      0000FFFFFF0000FFFF0000000000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF00FFFF
      FF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000000000C0C0
      C00000000000FFFFFF000000000080808000808080000000000000FFFF00FFFF
      FF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000000000C0C0
      C00000000000FFFFFF0000000000808080000000000000000000000000000000
      0000000000000000000080800000808000008080000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000808000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000000000FF
      FF00C0C0C0000000000000000000808080000000800000000000FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000000000FF
      FF00C0C0C0000000000000000000808080000000000000000000000000000000
      0000000000000000000080800000808000008080000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080800000808000008080000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF00FFFF
      FF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF00000000000000
      000000000000000000000000000080808000000080000000800000FFFF00FFFF
      FF0000FFFF00FFFFFF00808080000000800000FFFF00FFFFFF00000000000000
      0000000000000000000000000000808080000000000000000000000000000000
      0000000000000000000080800000808000008080000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008080000080800000808000008080000080800000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF008080
      800000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF0000FFFF00FFFFFF0000FF
      FF00FFFFFF0000FFFF00000000008080800080808000000080008080800000FF
      FF00FFFFFF00808080000000800080808000FFFFFF0000FFFF00FFFFFF0000FF
      FF00FFFFFF0000FFFF0000000000808080000000000000000000000000000000
      0000000000000000000080800000808000008080000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808000008080000080800000808000008080000080800000808000000000
      0000000000000000000000000000000000008080800000FFFF0000FFFF008080
      8000FFFFFF0000FFFF008080800000FFFF00FFFFFF00FFFFFF0000FFFF00FFFF
      FF0000FFFF00FFFFFF0000000000808080000000000000008000000080008080
      800000FFFF000000800000008000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFF
      FF0000FFFF00FFFFFF0000000000808080000000000000000000000000000000
      0000808000008080000080800000808000008080000080800000808000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080800000808000008080000000000000000000000000
      0000000000000000000000000000000000000000000080808000FFFFFF008080
      800000FFFF008080800000FFFF00FFFFFF0000FFFF0000FFFF00FFFFFF0000FF
      FF00FFFFFF0000FFFF0000000000808080000000000080808000000080000000
      80000000800000008000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF00FFFFFF0000FFFF0000000000808080000000000000000000000000000000
      0000000000008080000080800000808000008080000080800000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080800000808000008080000000000000000000000000
      000000000000000000000000000000000000808080008080800080808000FFFF
      FF0080808000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFF
      FF0000FFFF00FFFFFF0000000000808080000000000080808000000080000000
      800000008000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFF
      FF0000FFFF00FFFFFF0000000000808080000000000000000000000000000000
      0000000000000000000080800000808000008080000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080800000808000008080000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF008080800000FF
      FF00FFFFFF008080800080808000808080008080800000000000000000000000
      0000000000000000000000000000000000008080800000008000000080000000
      8000000080008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000808000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080800000808000008080000000000000000000000000
      000000000000000000000000000000000000000000008080800000FFFF008080
      800000FFFF008080800000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000800000008000808080000000
      0000000080000000800080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800000FFFF00000000008080
      800000000000000000008080800000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000800000008000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000000000000000008080
      800000FFFF000000000000000000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000008000000080008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFFFFFFFFFFFFFFC000C000FFFFFFFF
      80008000FFFFFFFF80008000F83FFEFF80000000F83FFC7F80000000F83FF83F
      80000000F83FF01F80000000C007E00F00008000E00FC00780008000F01FF83F
      00008000F83FF83F80010001FC7FF83F81FF11FFFEFFF83F2CFFF8FFFFFFFFFF
      66FFFC7FFFFFFFFFEFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
end

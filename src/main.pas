unit Main;

{$mode objfpc}{$H+}
{$WARN 6058 off : Call to subroutine "$1" marked as inline is not inlined}
interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, ExtCtrls,
  ActnList, StdCtrls, SynHighlighterPas, SynEdit, uPSComponent, Variants;

type

  { TMainForm }

  TMainForm = class(TForm)
    LogList: TListBox;
    PSScript1: TPSScript;
    Splitter1: TSplitter;
    ScriptRun: TAction;
    FileSave: TAction;
    FileOpen: TAction;
    FileNew: TAction;
    ActionList1: TActionList;
    SynEdit1: TSynEdit;
    SynPasSyn1: TSynPasSyn;
    ImageList1: TImageList;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    procedure FileNewExecute(Sender: TObject);
    procedure FileOpenExecute(Sender: TObject);
    procedure FileSaveExecute(Sender: TObject);
    procedure PSScript1Compile(Sender: TPSScript);
    procedure ScriptRunExecute(Sender: TObject);
  private
    procedure Write(AData: Variant);
  public
    procedure LoadFile(AFileName: String);
    procedure SaveFile(AFileName: String);
  end;

var
  MainForm: TMainForm;

implementation

{$R *.lfm}

{ TMainForm }

procedure TMainForm.FileNewExecute(Sender: TObject);
begin
  if MessageDlg('Are you sure?', mtInformation, [mbOK, mbCancel], 0, mbOK) = mrOK then
    SynEdit1.Text:='';
end;

procedure TMainForm.FileOpenExecute(Sender: TObject);
var OFN: TOpenDialog;
begin
  OFN := TOpenDialog.Create(Self);
  try
    OFN.Filter:='Pascal File|*.pas';
    if OFN.Execute then LoadFile(OFN.FileName);
  finally
    OFN.Free;
  end;
end;

procedure TMainForm.FileSaveExecute(Sender: TObject);
var OSN: TSaveDialog;
begin
  OSN := TSaveDialog.Create(Self);
  try
    OSN.Filter:='Pascal File|*.pas';
    if OSN.Execute then SaveFile(OSN.FileName);
  finally
    OSN.Free;
  end;
end;

procedure TMainForm.ScriptRunExecute(Sender: TObject);
var
  c: Boolean;
  i: Integer;
begin
  LogList.Items.Clear;
  PSScript1.Script.Clear;
  PSScript1.Script.Add('program test;');
  if not SynEdit1.Text.Contains('begin') then PSScript1.Script.Add('begin');
  PSScript1.Script.AddStrings(SynEdit1.Text.Split([#13#10]));
  if not SynEdit1.Text.Contains('end.') then PSScript1.Script.Add('end.');
  c := PSScript1.Compile;
  for i := 0 to PSScript1.CompilerMessageCount - 1 do
    LogList.Items.Add(PSScript1.CompilerMessages[i].MessageToString);
  if c then
  begin
    if not PSScript1.Execute then
      MessageDlg('Runtime Error',PSScript1.ExecErrorToString, mtError, [mbOK], 0)
  end
  else
    MessageDlg('error', 'Compile Error', mtError, [mbOK], 0)
end;

procedure TMainForm.PSScript1Compile(Sender: TPSScript);
begin
  Sender.AddMethod(Self, @TMainForm.Write, 'procedure Write(AData: Variant);');
end;

{ Script Methods }

procedure TMainForm.Write(AData: Variant);
var TextList: String;
begin
  case VarType(AData) of
    varsingle: TextList:= FloatToStr(AData);
    vardouble: TextList:= FloatToStr(AData);
    vardecimal: TextList:= FloatToStr(AData);
    varcurrency: TextList:= FloatToStr(AData);
    vardate: TextList:= DateToStr(AData);
    varolestr: TextList:= AData;
    varstrarg: TextList:= AData;
    varstring: TextList:= AData;
    varboolean: TextList:= BoolToStr(AData, True);
    varshortint: TextList:= intToStr(AData);
    varsmallint: TextList:= intToStr(AData);
    varinteger: TextList:= intToStr(AData);
    varint64: TextList:= intToStr(AData);
    varbyte: TextList:= intToStr(AData);
    varword: TextList:= intToStr(AData);
    varqword: TextList:= intToStr(AData);
    varlongword: TextList:= intToStr(AData);
  else
    TextList:='Unknown Data';
  end;
  LogList.Items.Add(TextList);
end;

{ Methods }

procedure TMainForm.LoadFile(AFileName: String);
var SL: TStringList;
begin
  SL := TStringList.Create;
  try
    SL.LoadFromFile(AFileName);
    SynEdit1.Text:=SL.Text;
  finally
    SL.Free;
  end;
end;

procedure TMainForm.SaveFile(AFileName: String);
var SL: TStringList;
begin
  SL := TStringList.Create;
  try
    SL.Text:= SynEdit1.Text;
    SL.SaveToFile(AFileName);
  finally
    SL.Free;
  end;
end;

end.


unit MainUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons, LCLType, ActnList, Clipbrd, Menus;

type

  { TMainForm }

  TMainForm = class(TForm)
    CopyMenuItem: TMenuItem;
    HistoryLabel: TLabel;
    MCAction: TAction;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    MMinusAction: TAction;
    MPlusAction: TAction;
    MRAction: TAction;
    MSAction: TAction;
    PasteMenuItem: TMenuItem;
    ReverseDivisionAction: TAction;
    PlusMinusButtonAction: TAction;
    CEButtonAction: TAction;
    CalcMenu: TMainMenu;
    EditSubMenu: TMenuItem;
    HelpSubMenu: TMenuItem;
    HelpMenuItem: TMenuItem;
    AboutMenuItem: TMenuItem;
    CtrlVAction: TAction;
    CtrlCAction: TAction;
    ShortcutsActionList: TActionList;
    BackspaceButton: TSpeedButton;
    OutputEdit: TEdit;
    EqualButton: TSpeedButton;
    PlusButton: TSpeedButton;
    PercentButton: TSpeedButton;
    ReverseDivisionButton: TSpeedButton;
    MinusButton: TSpeedButton;
    DigButton3: TSpeedButton;
    DigButton2: TSpeedButton;
    DigButton1: TSpeedButton;
    CommaButton: TSpeedButton;
    PlusMinusButton: TSpeedButton;
    MultiplicationButton: TSpeedButton;
    DigButton0: TSpeedButton;
    DigButton6: TSpeedButton;
    DigButton5: TSpeedButton;
    DigButton4: TSpeedButton;
    DigButton7: TSpeedButton;
    DigButton8: TSpeedButton;
    DigButton9: TSpeedButton;
    DivisionButton: TSpeedButton;
    SqrtButton: TSpeedButton;
    CEButton: TSpeedButton;
    CButton: TSpeedButton;
    ButtonsPanel: TPanel;
    procedure AboutMenuItemClick(Sender: TObject);
    procedure CEButtonActionExecute(Sender: TObject);
    procedure CtrlCActionExecute(Sender: TObject);
    procedure BackspaceButtonClick(Sender: TObject);
    procedure CtrlVActionExecute(Sender: TObject);
    procedure CommaAndDigitsClick(Sender: TObject);
    procedure CButtonClick(Sender: TObject);
    procedure CEButtonClick(Sender: TObject);
    procedure EqualButtonClick(Sender: TObject);
    procedure HelpMenuItemClick(Sender: TObject);
    procedure KeyboardInput(Sender: TObject; var Key: char);
    procedure PercentButtonClick(Sender: TObject);
    procedure ArithmeticButtonsClick(Sender: TObject);
    procedure PlusMinusButtonClick(Sender: TObject);
    procedure PlusMinusButtonActionExecute(Sender: TObject);
    procedure ReverseDivisionActionExecute(Sender: TObject);
    procedure ReverseDivisionButtonClick(Sender: TObject);
    procedure SqrtButtonClick(Sender: TObject);
  private
    double1,double2, double2BAK: extended;
    MathOperationButton,PrevMathButton: string;
    PreviousButtonWasEqual, PreviousButtonWasAction: boolean;
  public
    { public declarations }
  end;

var
  MainForm: TMainForm;
implementation

{$R *.lfm}
uses
  AboutUnit, HelpUnit;

{ TMainForm }

procedure TMainForm.CommaAndDigitsClick(Sender: TObject);
var
  button: string;
begin
  if (pos('E',OutputEdit.Text) <> 0) THEN CEButton.Click;
  button := TButton(Sender).Caption;
  if (StrToIntDef(button,10) < 10) AND (length(OutputEdit.Text)>14) THEN exit;
  if (button = ',') AND (pos(',',OutputEdit.Text) <> 0) THEN exit;
  if (OutputEdit.Text='0') AND (button <> ',') THEN
    OutputEdit.Text := FloatToStr(StrToFloat(OutputEdit.Text + button))
  else
    OutputEdit.Text := OutputEdit.Text + button;
end;

procedure TMainForm.BackspaceButtonClick(Sender: TObject);
var
  s: string;
begin
  if (pos('E',OutputEdit.Text) <> 0) THEN exit;
  s := OutputEdit.Text;
  if (length(s) = 1) OR ((length(s)=2) AND (s[1]='-')) THEN s := '0' else
    delete(s,length(s),1);
  OutputEdit.Text := s;
end;

procedure TMainForm.CtrlVActionExecute(Sender: TObject);
var
  i: integer;
  s: string;
begin
  if (Clipboard.AsText <> '') THEN
    begin
      s := '';
      for i := 1 to Length(Clipboard.AsText) do
        if (ord(Clipboard.AsText[i])>=48) AND (ord(Clipboard.AsText[i])<=57) THEN s := s + Clipboard.AsText[i];
      if (s <> '') THEN OutputEdit.Text := s;
    end;
end;

procedure TMainForm.CtrlCActionExecute(Sender: TObject);
begin
  Clipboard.AsText := OutputEdit.Text;
end;

procedure TMainForm.CEButtonActionExecute(Sender: TObject);
begin
  CEButton.Click;
end;

procedure TMainForm.AboutMenuItemClick(Sender: TObject);
begin
  AboutForm.ShowModal;
end;

procedure TMainForm.CButtonClick(Sender: TObject);
begin
  double1 := 0;
  double2 := 0;
  OutputEdit.Text := '0';
  HistoryLabel.Caption := '';
  MathOperationButton := '';
  PreviousButtonWasEqual := false;
  PreviousButtonWasAction := false;
  double2BAK := 0;
  PrevMathButton := '';
end;

procedure TMainForm.CEButtonClick(Sender: TObject);
begin
  OutputEdit.Text := '0';
end;

procedure TMainForm.EqualButtonClick(Sender: TObject);
begin
  PrevMathButton := '';
  if (PreviousButtonWasEqual = false) THEN
    double2 := StrToFloatDef(OutputEdit.Text,0)
  else
    double2 := double2BAK;
  if (OutputEdit.Text = '') THEN double2 := double1;
  double2BAK := double2;
  if (MathOperationButton<>'') THEN
  begin
    try
      begin
        case MathOperationButton of
          '/':
            begin
                if (double2 <> 0) THEN OutputEdit.Text := FloatToStr(double1 / double2)
                else
                  begin
                    CButton.Click;
                    OutputEdit.Text := 'Error: division by zero';
                  end;
            end;
          '*': OutputEdit.Text := FloatToStr(double1 * double2);
          '-': OutputEdit.Text := FloatToStr(double1 - double2);
          '+': OutputEdit.Text := FloatToStr(double1 + double2);
          '%': OutputEdit.Text := FloatToStr((double1/100)*double2);
        end;
        HistoryLabel.Caption := '';
        double1 := StrToFloatDef(OutputEdit.Text,0);
        double2 := 0;
      end;
    except
      on Exception do
      begin
        OutputEdit.Text := 'Exception: out of range';
      end;
    end;
  end;
  PreviousButtonWasEqual := true;
  PreviousButtonWasAction := false;
end;

procedure TMainForm.HelpMenuItemClick(Sender: TObject);
begin
  HelpForm.ShowModal;
end;

//нажатие кнопок на клавиатуре
procedure TMainForm.KeyboardInput(Sender: TObject; var Key: char);
begin
  case key of
  chr(VK_BACK): BackspaceButton.Click;
  '*': MultiplicationButton.Click;
  '+': PlusButton.Click;
  '-': MinusButton.Click;
  '/': DivisionButton.Click;
  ':': DivisionButton.Click;
  '.': CommaButton.Click;
  ',': CommaButton.Click;
  '0': DigButton0.Click;
  '1': DigButton1.Click;
  '2': DigButton2.Click;
  '3': DigButton3.Click;
  '4': DigButton4.Click;
  '5': DigButton5.Click;
  '6': DigButton6.Click;
  '7': DigButton7.Click;
  '8': DigButton8.Click;
  '9': DigButton9.Click;
  chr(VK_RETURN): EqualButton.Click;
  chr(VK_ESCAPE): CButton.Click;
  end;
end;


//кнопка процента
procedure TMainForm.PercentButtonClick(Sender: TObject);
var
  temp: double;
begin
  if (MathOperationButton <> '') THEN
  begin
    if (OutputEdit.Text = '') THEN OutputEdit.Text := FloatToStr(double1);
    temp := double1/100*StrToFloat(OutputEdit.Text);
    case MathOperationButton of
    '+': OutputEdit.Text := FloatToStr(double1 + temp);
    '-': OutputEdit.Text := FloatToStr(double1 - temp);
    '*': OutputEdit.Text := FloatToStr(temp);
    '/':
      begin
          if (temp <> 0) THEN
            OutputEdit.Text := FloatToStr(double1 / temp)
          else
            begin
              CButton.Click;
              OutputEdit.Text := 'Error: division by zero or unhandled division';
            end;
      end;
    end;
    HistoryLabel.Caption := '';
    double1 := StrToFloatDef(OutputEdit.Text,0);
    double2 := 0;
  end;
end;


//обработчик арифметических действий
procedure TMainForm.ArithmeticButtonsClick(Sender: TObject);
begin
  if (PrevMathButton <> TButton(Sender).Caption) OR (OutputEdit.Text <> '') then
  begin
    if (PreviousButtonWasAction = true) AND (OutputEdit.Text <> '') THEN EqualButton.Click;
    MathOperationButton := TButton(Sender).Caption;
    PrevMathButton:= TButton(Sender).Caption;
    if (PreviousButtonWasAction = false) THEN
      double1 := StrToFloatDef(OutputEdit.Text,0);
    HistoryLabel.Caption := FloatToStr(double1) + ' ' + MathOperationButton + ' ';
    OutputEdit.Text := '';
    PreviousButtonWasEqual := false;
    PreviousButtonWasAction := true;
  end;
end;

procedure TMainForm.PlusMinusButtonClick(Sender: TObject);
begin
  OutputEdit.Text := FloatToStr(-StrToFloatDef(OutputEdit.Text,0));
end;

procedure TMainForm.PlusMinusButtonActionExecute(Sender: TObject);
begin
  PlusMinusButton.Click;
end;

procedure TMainForm.ReverseDivisionActionExecute(Sender: TObject);
begin
  ReverseDivisionButton.Click;
end;

procedure TMainForm.ReverseDivisionButtonClick(Sender: TObject);
begin
  if (StrToFloatDef(OutputEdit.Text,0) <> 0) THEN
    OutputEdit.Text := FloatToStr(1/StrToFloatDef(OutputEdit.Text,0))
  else
    begin
      CButton.Click;
      OutputEdit.Text := 'Error: division by zero';
    end;
end;

procedure TMainForm.SqrtButtonClick(Sender: TObject);
begin
  try
    OutputEdit.Text := FloatToStr(sqrt(StrToFloat(OutputEdit.Text)));
  except
    on Exception do
    begin
      CButton.Click;
      OutputEdit.Text := 'Error: invalid input';
    end;
  end;
end;

end.


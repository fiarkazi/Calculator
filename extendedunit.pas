unit extendedunit;

{$mode objfpc}{$H+}

interface

uses
   Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons, LCLType, ActnList, Clipbrd, Menus, ButtonPanel, DefaultTranslator, LCLTranslator;

type

  { TExtendedForm }

  TExtendedForm = class(TForm)
    absButton: TButton;
    atanButton: TButton;
    BackspaceButton: TSpeedButton;
    CButton: TSpeedButton;
    CEButton: TSpeedButton;
    CommaButton: TBitBtn;
    cosButton: TButton;
    DigButton0: TBitBtn;
    DigButton1: TBitBtn;
    DigButton2: TBitBtn;
    DigButton3: TBitBtn;
    DigButton4: TBitBtn;
    DigButton5: TBitBtn;
    DigButton6: TBitBtn;
    DigButton7: TBitBtn;
    DigButton8: TBitBtn;
    DigButton9: TBitBtn;
    DivisionButton: TBitBtn;
    EqualButton: TBitBtn;
    factButton: TButton;
    Image1: TImage;
    Label1: TLabel;
    lnButton: TButton;
    logButton: TButton;
    MinusButton: TBitBtn;
    MultiplicationButton: TBitBtn;
    PercentButton: TBitBtn;
    PlusButton: TBitBtn;
    PlusMinusButton: TBitBtn;
    Edit1: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    sButton2: TBitBtn;
    sButton3: TBitBtn;
    sButton4: TBitBtn;
    sButton5: TBitBtn;
    sButton6: TBitBtn;
    sButton7: TBitBtn;
    sButton8: TBitBtn;
    sinButton: TButton;
    SqrButton: TBitBtn;
    SqrtButton: TBitBtn;
    CopyMenuItem: TMenuItem;
    HistoryLabel: TLabel;
    ModeSubMenu: TMenuItem;
    ChildMenuItem: TMenuItem;
    BasicMenuItem: TMenuItem;
    ProMenuItem: TMenuItem;
    LangSubMenu: TMenuItem;
    RusMenuItem: TMenuItem;
    EngMenuItem: TMenuItem;
    tgButton: TButton;
    ThemeSubMenu: TMenuItem;
    name1MenuItem: TMenuItem;
    name2MenuItem: TMenuItem;
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
    OutputEdit: TEdit;
    varpowerButton: TButton;
    procedure AboutMenuItemClick(Sender: TObject);
    procedure atanButtonClick(Sender: TObject);
    procedure ChildMenuItemClick(Sender: TObject);
    procedure EngMenuItemClick(Sender: TObject);
    procedure lnButtonClick(Sender: TObject);
    procedure name1MenuItemClick(Sender: TObject);
    procedure name2MenuItemClick(Sender: TObject);
    procedure RusMenuItemClick(Sender: TObject);
    procedure s1ButtonClick(Sender: TObject);
    procedure varpowerButtonClick(Sender: TObject);
    procedure tgButtonClick(Sender: TObject);
    procedure cosButtonClick(Sender: TObject);
    procedure sinButtonClick(Sender: TObject);
    procedure ButtonPanel1Click(Sender: TObject);
    procedure ButtonsPanelClick(Sender: TObject);
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
    procedure BasicMenuItemClick(Sender: TObject);
    procedure PercentButtonClick(Sender: TObject);
    procedure ArithmeticButtonsClick(Sender: TObject);
    procedure PlusMinusButtonClick(Sender: TObject);
    procedure PlusMinusButtonActionExecute(Sender: TObject);
    procedure ProMenuItemClick(Sender: TObject);
    procedure SqrButtonClick(Sender: TObject);
    procedure SqrtButtonClick(Sender: TObject);

    procedure AnotherButtonClick(Sender: TObject);
    procedure SystemClick(Sender: TObject);
  private
    double1,double2, double2BAK: extended;
    MathOperationButton,PrevMathButton: string;
    PreviousButtonWasEqual, PreviousButtonWasAction: boolean;

  public

  end;

var
  ExtendedForm: TExtendedForm;
  childProp: boolean;
  lang: String;

implementation

{$R *.lfm}
uses
  AboutUnit, HelpUnit, MainUnit, math;
{ TExtendedForm }

procedure TExtendedForm.CommaAndDigitsClick(Sender: TObject);
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

procedure TExtendedForm.BackspaceButtonClick(Sender: TObject);
var
  s: string;
begin
  if (pos('E',OutputEdit.Text) <> 0) THEN exit;
  s := OutputEdit.Text;
  if (length(s) = 1) OR ((length(s)=2) AND (s[1]='-')) THEN s := '0' else
    delete(s,length(s),1);
  OutputEdit.Text := s;
end;

procedure TExtendedForm.CtrlVActionExecute(Sender: TObject);
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

procedure TExtendedForm.CtrlCActionExecute(Sender: TObject);
begin
  Clipboard.AsText := OutputEdit.Text;
end;

procedure TExtendedForm.CEButtonActionExecute(Sender: TObject);
begin
  CEButton.Click;
end;

procedure TExtendedForm.AboutMenuItemClick(Sender: TObject);
begin
  AboutForm.ShowModal;
end;

procedure TExtendedForm.atanButtonClick(Sender: TObject);
begin

end;

procedure TExtendedForm.ChildMenuItemClick(Sender: TObject);
begin
  childProp:= True;
  Image1.Picture.LoadFromFile('img/nine.png');
  DigButton9.Margin:= 0;
  DigButton9.Glyph:= Image1.Picture.Bitmap;

  Image1.Picture.LoadFromFile('img/eight.png');
  DigButton8.Margin:= 0;
  DigButton8.Glyph:= Image1.Picture.Bitmap;

  Image1.Picture.LoadFromFile('img/seven.png');
  DigButton7.Margin:= 0;
  DigButton7.Glyph:= Image1.Picture.Bitmap;

  Image1.Picture.LoadFromFile('img/six.png');
  DigButton6.Margin:= 0;
  DigButton6.Glyph:= Image1.Picture.Bitmap;

  Image1.Picture.LoadFromFile('img/five.png');
  DigButton5.Margin:= 0;
  DigButton5.Glyph:= Image1.Picture.Bitmap;

  Image1.Picture.LoadFromFile('img/eight.png');
  DigButton8.Margin:= 0;
  DigButton8.Glyph:= Image1.Picture.Bitmap;

  Image1.Picture.LoadFromFile('img/four.png');
  DigButton4.Margin:= 0;
  DigButton4.Glyph:= Image1.Picture.Bitmap;

  Image1.Picture.LoadFromFile('img/eight.png');
  DigButton8.Margin:= 0;
  DigButton8.Glyph:= Image1.Picture.Bitmap;

  Image1.Picture.LoadFromFile('img/three.png');
  DigButton3.Margin:= 0;
  DigButton3.Glyph:= Image1.Picture.Bitmap;

  Image1.Picture.LoadFromFile('img/eight.png');
  DigButton8.Margin:= 0;
  DigButton8.Glyph:= Image1.Picture.Bitmap;

  Image1.Picture.LoadFromFile('img/two.png');
  DigButton2.Margin:= 0;
  DigButton2.Glyph:= Image1.Picture.Bitmap;

  Image1.Picture.LoadFromFile('img/one.png');
  DigButton1.Margin:= 0;
  DigButton1.Glyph:= Image1.Picture.Bitmap;

  Image1.Picture.LoadFromFile('img/zero.png');
  DigButton0.Margin:= 0;
  DigButton0.Glyph:= Image1.Picture.Bitmap;

  Image1.Picture.LoadFromFile('img/two.png');
  sButton2.Margin:= 0;
  sButton2.Glyph:= Image1.Picture.Bitmap;

  Image1.Picture.LoadFromFile('img/three.png');
  sButton3.Margin:= 0;
  sButton3.Glyph:= Image1.Picture.Bitmap;

  Image1.Picture.LoadFromFile('img/four.png');
  sButton4.Margin:= 0;
  sButton4.Glyph:= Image1.Picture.Bitmap;

  Image1.Picture.LoadFromFile('img/five.png');
  sButton5.Margin:= 0;
  sButton5.Glyph:= Image1.Picture.Bitmap;

  Image1.Picture.LoadFromFile('img/six.png');
  sButton6.Margin:= 0;
  sButton6.Glyph:= Image1.Picture.Bitmap;

  Image1.Picture.LoadFromFile('img/seven.png');
  sButton7.Margin:= 0;
  sButton7.Glyph:= Image1.Picture.Bitmap;

  Image1.Picture.LoadFromFile('img/eight.png');
  sButton8.Margin:= 0;
  sButton8.Glyph:= Image1.Picture.Bitmap;


  Image1.Picture.LoadFromFile('img/childbg.jpg');
end;

procedure TExtendedForm.EngMenuItemClick(Sender: TObject);
begin
  SetDefaultLang('en');
  AboutUnit.langch('en');
  HelpUnit.langch('en');
end;

procedure TExtendedForm.lnButtonClick(Sender: TObject);
begin

end;

procedure TExtendedForm.name1MenuItemClick(Sender: TObject);
begin
  if childProp = True then
    begin
      DigButton9.Glyph:= nil;
      DigButton9.Margin:= -1;
      DigButton8.Glyph:= nil;
      DigButton8.Margin:= -1;
      DigButton7.Glyph:= nil;
      DigButton7.Margin:= -1;
      DigButton6.Glyph:= nil;
      DigButton6.Margin:= -1;
      DigButton5.Glyph:= nil;
      DigButton5.Margin:= -1;
      DigButton4.Glyph:= nil;
      DigButton4.Margin:= -1;
      DigButton3.Glyph:= nil;
      DigButton3.Margin:= -1;
      DigButton2.Glyph:= nil;
      DigButton2.Margin:= -1;
      DigButton1.Glyph:= nil;
      DigButton1.Margin:= -1;
      DigButton0.Glyph:= nil;
      DigButton0.Margin:= -1;
      sButton2.Glyph:= nil;
      sButton2.Margin:= -1;
      sButton3.Glyph:= nil;
      sButton3.Margin:= -1;
      sButton4.Glyph:= nil;
      sButton4.Margin:= -1;
      sButton5.Glyph:= nil;
      sButton5.Margin:= -1;
      sButton6.Glyph:= nil;
      sButton6.Margin:= -1;
      sButton7.Glyph:= nil;
      sButton7.Margin:= -1;
      sButton8.Glyph:= nil;
      sButton8.Margin:= -1;
      Image1.Picture:= nil;
    end;
  ExtendedForm.Color:= clGradientInactiveCaption;
end;

procedure TExtendedForm.name2MenuItemClick(Sender: TObject);
begin
  ExtendedForm.Color:= clGradientActiveCaption;
  BackspaceButton.Color:= clTeal;
  if childProp = True then
    begin
        DigButton9.Glyph:= nil;
        DigButton9.Margin:= -1;
        DigButton8.Glyph:= nil;
        DigButton8.Margin:= -1;
        DigButton7.Glyph:= nil;
        DigButton7.Margin:= -1;
        DigButton6.Glyph:= nil;
        DigButton6.Margin:= -1;
        DigButton5.Glyph:= nil;
        DigButton5.Margin:= -1;
        DigButton4.Glyph:= nil;
        DigButton4.Margin:= -1;
        DigButton3.Glyph:= nil;
        DigButton3.Margin:= -1;
        DigButton2.Glyph:= nil;
        DigButton2.Margin:= -1;
        DigButton1.Glyph:= nil;
        DigButton1.Margin:= -1;
        DigButton0.Glyph:= nil;
        DigButton0.Margin:= -1;
        sButton2.Glyph:= nil;
        sButton2.Margin:= -1;
        sButton3.Glyph:= nil;
        sButton3.Margin:= -1;
        sButton4.Glyph:= nil;
        sButton4.Margin:= -1;
        sButton5.Glyph:= nil;
        sButton5.Margin:= -1;
        sButton6.Glyph:= nil;
        sButton6.Margin:= -1;
        sButton7.Glyph:= nil;
        sButton7.Margin:= -1;
        sButton8.Glyph:= nil;
        sButton8.Margin:= -1;
        Image1.Picture:= nil;
      end;
end;

procedure TExtendedForm.RusMenuItemClick(Sender: TObject);
begin
  SetDefaultLang('ru');
  AboutUnit.langch('ru');
  HelpUnit.langch('ru');
end;

procedure TExtendedForm.s1ButtonClick(Sender: TObject);
begin

end;


function Sym (n : integer) : char; {функия перевода десятичного числа в символьное представление}
  begin
      case n of
      0..9:   Sym := chr(48+n);
      10..36: Sym := chr(55+n); {10-A, 11-B, 12-C, 13-D, 14-E, 15-F и так далее}
      end;
  end;
function DecToX (n : longint; k : integer) : string; {из десятиричной в произвольную c основанием 2<=k<=36}
var st : string;
begin
    st := '';
    if n = 0 then st := '0' else
    begin
        while n>=1 do
        begin
            st := Sym (n mod k) + st;
            n := n div k;
        end;
    end;
 DecToX := st;
end;
procedure TExtendedForm.SystemClick(Sender: TObject);
var n:longint;
k:integer;
begin
  Label3.Caption:= TButton(Sender).Caption;


  n:= StrToInt(OutputEdit.Text);
  k:= StrToInt(TButton(Sender).Caption);
  Edit1.Text:= DecTox(N, k);
end;




procedure TExtendedForm.varpowerButtonClick(Sender: TObject);
begin

end;

procedure TExtendedForm.tgButtonClick(Sender: TObject);
begin

end;

procedure TExtendedForm.cosButtonClick(Sender: TObject);
begin

end;

procedure TExtendedForm.sinButtonClick(Sender: TObject);
begin

end;

procedure TExtendedForm.ButtonPanel1Click(Sender: TObject);
begin

end;

procedure TExtendedForm.ButtonsPanelClick(Sender: TObject);
begin

end;

procedure TExtendedForm.CButtonClick(Sender: TObject);
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

procedure TExtendedForm.CEButtonClick(Sender: TObject);
begin
  OutputEdit.Text := '0';
end;

procedure TExtendedForm.EqualButtonClick(Sender: TObject);
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
          'x^y': OutputEdit.Text:= FloatToStr(Power(double1, double2));

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

procedure TExtendedForm.AnotherButtonClick(Sender: TObject);
var i,n: byte;
  temp: double;
begin
  MathOperationButton:= TButton(Sender).Caption;
  if (MathOperationButton <> '') THEN
  begin
    try
      begin
        case MathOperationButton of
          'sin':  OutputEdit.Text:= FloatToStr(sin(StrToFloat(OutputEdit.Text)));
          'cos':  OutputEdit.Text:= FloatToStr(cos(StrToFloat(OutputEdit.Text)));
          'tan':  OutputEdit.Text:= FloatToStr(sin(StrToFloat(OutputEdit.Text))/cos(StrToFloat(OutputEdit.Text)));
          'arctan': OutputEdit.Text:= FloatToStr(arctan(StrToFloat(OutputEdit.Text)));
          'log':  begin
                  temp:= StrToFloat(OutputEdit.Text);
                  if temp < 0 then
                  OutputEdit.Text := 'Ошибка: дано отрицательное число!'
                  else
                  OutputEdit.Text:= FloatToStr(log10(temp));
          end;
          'ln':   begin
                  temp:= StrToFloat(OutputEdit.Text);
                  if temp < 0 then
                  OutputEdit.Text := 'Ошибка: дано отрицательное число!'
                  else
                  OutputEdit.Text:= FloatToStr(logn(temp, 2.71));
          end;
          'abs':  OutputEdit.Text:= FloatToStr(-1*(StrToFloat(OutputEdit.Text)));
          '!': begin
            if (Frac(StrToFloat(OutputEdit.Text))=0) then
               begin
                 if (StrToFloat(OutputEdit.Text)>1) then
                   begin
                     temp:= 1;
                     n:= Trunc(StrToFloat(OutputEdit.Text));
                     for i:=2 to n do
                       temp:= temp*i;
                   end
                 else
                     temp:= 1;
                 OutputEdit.Text:= FloatToStr(temp);
               end;

          end;
        end;
        HistoryLabel.Caption := '';
        double1 := StrToFloatDef(OutputEdit.Text,0);
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



procedure TExtendedForm.HelpMenuItemClick(Sender: TObject);
begin
  HelpForm.ShowModal;
end;

//нажатие кнопок на клавиатуре
procedure TExtendedForm.KeyboardInput(Sender: TObject; var Key: char);
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

procedure TExtendedForm.BasicMenuItemClick(Sender: TObject);
begin
  MainForm.Show;
  ExtendedForm.Visible:= False;
end;



procedure TExtendedForm.ProMenuItemClick(Sender: TObject);
begin
  //ProForm.ShowModal
end;





//кнопка процента
procedure TExtendedForm.PercentButtonClick(Sender: TObject);
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
procedure TExtendedForm.ArithmeticButtonsClick(Sender: TObject);
begin
  if (PrevMathButton <> TButton(Sender).Caption) OR (OutputEdit.Text <> '') then
  begin
    if (PreviousButtonWasAction = true) AND (OutputEdit.Text <> '') THEN EqualButton.Click;
    MathOperationButton := TButton(Sender).Caption;
    PrevMathButton:= TButton(Sender).Caption;
    if (PreviousButtonWasAction = false) THEN
      double1 := StrToFloatDef(OutputEdit.Text,0);
    if (MathOperationButton = 'x^y') then HistoryLabel.Caption:= FloatToStr(double1)+' ^ '
    else HistoryLabel.Caption := FloatToStr(double1) + ' ' + MathOperationButton + ' ';
    OutputEdit.Text := '';
    PreviousButtonWasEqual := false;
    PreviousButtonWasAction := true;
  end;
end;

procedure TExtendedForm.PlusMinusButtonClick(Sender: TObject);
begin
  OutputEdit.Text := FloatToStr(-StrToFloatDef(OutputEdit.Text,0));
end;

procedure TExtendedForm.PlusMinusButtonActionExecute(Sender: TObject);
begin
  PlusMinusButton.Click;
end;

procedure TExtendedForm.SqrButtonClick(Sender: TObject);
begin
  try
     OutputEdit.Text := FloatToStr(sqr(StrToFloat(OutputEdit.Text)));
  except
    on Exception do
    begin
      CButton.Click;
      OutputEdit.Text := 'Error: invalid input';
    end;
  end;
end;

procedure TExtendedForm.SqrtButtonClick(Sender: TObject);
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


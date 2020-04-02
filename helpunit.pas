unit HelpUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { THelpForm }

  THelpForm = class(TForm)
    OkButton: TButton;
    HepMemo: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);

  private
    { private declarations }
  public
    { public declarations }
  end;
  procedure langch(lang: String);
  resourcestring
     sHelpText = 'Этот каклькулятор имеет несколько режимов.' +#10+ 'Основные возможности:' +#10+ '- Поддержка ввода с клавиатуры (Esc, Пробел и тд)' +#10+#10+ '- Горячие клавиши' +#10+ 'Горячие клавиши:' +#10+ 'CTRL+C: копирование результата' +#10+ 'CTRL+V: вставка числа (текущее будет удалено)' +#10+ 'r: 1/x' +#10+ 'F9: +/-';

var
  HelpForm: THelpForm;

implementation

{$R *.lfm}

{ THelpForm }

procedure THelpForm.OkButtonClick(Sender: TObject);
begin
  HelpForm.Close;
end;

procedure THelpForm.FormCreate(Sender: TObject);
begin
  HepMemo.Text:= sHelpText;
end;

procedure langch(lang: String);
begin
  if lang='ru' then
     HelpForm.HepMemo.Text:= 'Этот каклькулятор имеет несколько режимов.' +#10+ 'Основные возможности:' +#10+ '- Поддержка ввода с клавиатуры (Esc, Пробел и тд)' +#10+#10+ '- Горячие клавиши' +#10+ 'Горячие клавиши:' +#10+ 'CTRL+C: копирование результата' +#10+ 'CTRL+V: вставка числа (текущее будет удалено)' +#10+ 'r: 1/x' +#10+ 'F9: +/-'
  else
     HelpForm.HepMemo.Text:= 'This calculator has only Simple mode.'+#10+'Main features:'+#10+'-keyboard input (with Esc, Backspace, etc.);'+#10+'-shortcuts and hotkeys;'+#10+#10+'Shortcuts and hotkeys:'+#10+'-Ctrl+C: copy the number;'+#10+'-Crtl+V: paste the number (the existing number is deleted);'+#10+'-r: 1/x;'+#10+'-F9: +/-.';
end;

end.


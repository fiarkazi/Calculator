unit AboutUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,lclintf;

type

  { TAboutForm }

  TAboutForm = class(TForm)
    OkButton: TButton;
    LicenseMemo: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure LicenseMemoChange(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);

  private
    { private declarations }
  public
    { public declarations }
  end;
  procedure langch(lang: String);
resourcestring
  sLicenseText = 'Программа создана при поддержке студентов';

var
  AboutForm: TAboutForm;
  lang: String;

implementation

{$R *.lfm}

{ TAboutForm }

procedure TAboutForm.FormCreate(Sender: TObject);
begin
  LicenseMemo.Text:= sLicenseText;
end;

procedure TAboutForm.LicenseMemoChange(Sender: TObject);
begin

end;

procedure TAboutForm.OkButtonClick(Sender: TObject);
begin
  AboutForm.Close;
end;

procedure langch(lang: String);
begin
  if lang = 'ru' then
     AboutForm.LicenseMemo.Text:= 'Программа создана при поддержке студентов.'
  else
     AboutForm.LicenseMemo.Text:= 'The program was created with the support of students.';
end;

end.


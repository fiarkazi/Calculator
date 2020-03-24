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
    procedure OkButtonClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  AboutForm: TAboutForm;

implementation

{$R *.lfm}

{ TAboutForm }

procedure TAboutForm.OkButtonClick(Sender: TObject);
begin
  AboutForm.Close;
end;

end.


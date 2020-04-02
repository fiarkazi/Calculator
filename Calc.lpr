program Calc;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, MainUnit, AboutUnit, HelpUnit, extendedunit
  { you can add units after this };

{$R *.res}

begin
  Application.Title:='fpcCalc';
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAboutForm, AboutForm);
  Application.CreateForm(THelpForm, HelpForm);
  Application.CreateForm(TExtendedForm, ExtendedForm);
  Application.Run;
end.


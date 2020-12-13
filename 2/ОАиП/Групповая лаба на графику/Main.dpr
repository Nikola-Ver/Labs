program Main;

uses
  Forms,
  PowerPeople in 'PowerPeople.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.

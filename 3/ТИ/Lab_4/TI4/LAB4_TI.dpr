program LAB4_TI;

uses
  Forms,
  Main in 'Main.pas' {fmMain},
  EDS in 'EDS.pas',
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  TStyleManager.TrySetStyle('Amakrits');
  Application.Title := '';
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.

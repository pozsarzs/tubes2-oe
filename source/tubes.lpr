{ +--------------------------------------------------------------------------+ }
{ | Tubes 2.0 Trial * Electrontube catalogue                                 | }
{ | Copyright (C) 2008-2012 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | tubes.lpr                                                                | }
{ | Project file.                                                            | }
{ +--------------------------------------------------------------------------+ }

{
   This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by the
 Free Software Foundation, either version 3 of the License, or (at your
 option) any later version.

   This program is distributed in the hope that it will be useful, but
 WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 General Public License for more details.

   You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.
}

program tubes;
{$MODE OBJFPC}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}cthreads, {$ENDIF}{$ENDIF}
  Interfaces, Forms,
  {$IFNDEF UseFHS} DefaultTranslator,{$ENDIF}
  // own forms:
  frmmain, frmabout, frmsort, frmparsearch, frmconfig,
  frmtextview, frmprogressbar
  // own units:
{$IFDEF UseFHS}, unttranslator{$ENDIF};
  
{$R *.res}

begin
  if (Application.Params[1]='-h') or (Application.Params[1]='--help')
  then
  begin
    writeln('Useable parameters:');
    writeln(#9+'"-o" or "--offline"'+#9+'full off-line mode;');
    writeln(#9+'"-v" or "--version"'+#9+'version information.');
    Halt(0);
  end;
  if (Application.Params[1]='-v') or (Application.Params[1]='--version') then
  begin
    writeln('Tubes v'+frmmain.VERSION+' Trial');
    Halt(0);
  end;
  Application.Title:='Tubes';
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm5, Form5);
  Application.CreateForm(TForm7, Form7);
  Application.CreateForm(TForm8, Form8);
  Application.CreateForm(TForm9, Form9);
  Application.Run;
end.

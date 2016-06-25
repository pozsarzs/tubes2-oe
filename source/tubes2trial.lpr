{ +--------------------------------------------------------------------------+ }
{ | Tubes2 2.2 trial * Electrontube catalogue                                | }
{ | Copyright (C) 2008-2016 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | tubes2trial.lpr                                                          | }
{ | project file                                                             | }
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

program tubes2trial;
{$MODE OBJFPC}{$H+}
uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}cthreads, {$ENDIF}{$ENDIF}
  Dialogs, Forms, Interfaces, Sysutils, crt,
  // own forms:
  frmabout, frmconfig, frmmain, frmparsearch, frmprogressbar, frmsort,
  frmtextview, frmupgrade, frmtester;
var
  fe, fn: string;
  appmode: byte;
const
  commands: array[1..4,1..2] of string=
  (
    ('(none)','start catalogue application;'),
    ('tester','start tubetester tool;'),
    ('drawer','start characteristic drawer tool;'),
    ('viewer','start characteristic drawer in viewer mode;')
  );
  params: array[1..4,1..3] of string=
  (
    ('-d','--dontcheckupdate','on-line mode, but do not check updates'),
    ('-h','--help','show help'),
    ('-o','--offline','full off-line mode'),
    ('-v','--version','show version and build information')
  );

{$R *.res}

procedure help(mode: boolean);
var
 b: byte;
begin
  if mode then
    showmessage('There are one or more bad parameter in command line.') else
    begin
      writeln('Usage:');
      writeln(' ',fn,{$IFDEF WIN32}'.',fe,{$ENDIF}' [command] [parameter] [input.csv]');
      writeln;
      writeln('commands:');
      for b:=1 to 4 do
      begin
        write('  ',commands[b,1]);
        gotoxy(30,wherey); writeln(commands[b,2]);
      end;
      writeln;
      writeln('parameters:');
      for b:=1 to 4 do
      begin
        write('  ',params[b,1]);
        gotoxy(8,wherey); write(params[b,2]);
        gotoxy(30,wherey); writeln(params[b,3]);
      end;
      writeln;
      write('input.csv:');
      gotoxy(30,wherey); writeln('input data file in viewer mode');
      writeln;
    end;
  halt(0);
end;

procedure verinfo;
begin
  writeln(frmmain.APPNAME+' v'+frmmain.VERSION);
  writeln;
  writeln('This application was compiled at ',{$I %TIME%},' on ',{$I %DATE%},
    ' by ',{$I %USER%});
  writeln('FPC version: ',{$I %FPCVERSION%});
  writeln('Target OS:   ',{$I %FPCTARGETOS%});
  writeln('Target CPU:  ',{$I %FPCTARGETCPU%});
  halt(0);
end;

begin
  fn:=extractfilename(paramstr(0));
  appmode:=0;
  frmmain.cmdpnocheckupdate:=false;
  frmmain.cmdpoffline:=false;
  if length(paramstr(1))=0 then appmode:=1 else
  begin
    for b:=2 to 4 do
      if paramstr(1)=commands[b,1] then appmode:=b;
    for b:=1 to 4 do
      if paramstr(1)=params[b,1] then appmode:=10*b;
    for b:=1 to 4 do
      if paramstr(1)=params[b,2] then appmode:=10*b;
  end;
  case appmode of
     0: help(true);
//     4: frmdrawer.viewer:=true;
    10: frmmain.cmdpnocheckupdate:=true;
    20: help(false);
    30: frmmain.cmdpoffline:=true;
    40: verinfo;
    50: frmmain.cmdpnocheckupdate:=true;
    60: help(false);
    70: frmmain.cmdpoffline:=true;
    80: verinfo;
  end;
  Application.Title:=frmmain.APPNAME;
  Application.Initialize;
  case appmode of
    2: Application.CreateForm(TForm4, Form4);
//    3: Application.CreateForm(TForm10, Form10);
//    4: Application.CreateForm(TForm10, Form10);
  else
    begin
      Application.CreateForm(TForm1, Form1);
      Application.CreateForm(TForm2, Form2);
      Application.CreateForm(TForm3, Form3);
      Application.CreateForm(TForm4, Form4);
      Application.CreateForm(TForm5, Form5);
      Application.CreateForm(TForm6, Form6);
      Application.CreateForm(TForm7, Form7);
      Application.CreateForm(TForm8, Form8);
      Application.CreateForm(TForm9, Form9);
//      Application.CreateForm(TForm10, Form10);
    end;
  end;
  Application.Run;
end.


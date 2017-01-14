{ +--------------------------------------------------------------------------+ }
{ | Tubes2 Open edition 2.2 * Electrontube catalogue                         | }
{ | Copyright (C) 2008-2017 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | tubes2oe.lpr                                                             | }
{ | Project file                                                             | }
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

program tubes2oe;
{$MODE OBJFPC}{$H+}
uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}cthreads, {$ENDIF}{$ENDIF}
  Dialogs, Forms, printer4lazarus, Interfaces, Sysutils, crt,
  // own forms:
  frmabout, frmconfig, frmmain, frmparsearch, frmprogressbar, frmsort,
  frmtextview, frmupgrade, frmdrawer, frmsubst;
var
  fe, fn: string;
  appmode: byte;
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
      writeln(' ',fn,{$IFDEF WIN32}'.',fe,{$ENDIF}' [parameter]');
      writeln;
      writeln('parameters:');
      for b:=1 to 4 do
      begin
        write('  ',params[b,1]);
        gotoxy(8,wherey); write(params[b,2]);
        gotoxy(30,wherey); writeln(params[b,3]);
      end;
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
    for b:=1 to 4 do
      if paramstr(1)=params[b,1] then appmode:=10*b;
    for b:=1 to 4 do
      if paramstr(1)=params[b,2] then appmode:=10*b;
  end;
  case appmode of
     0: help(true);
    10: frmmain.cmdpnocheckupdate:=true;
    20: help(false);
    30: frmmain.cmdpoffline:=true;
    40: verinfo;
    50: frmmain.cmdpnocheckupdate:=true;
    60: help(false);
    70: frmmain.cmdpoffline:=true;
    80: verinfo;
  end;
  Application.Title:='Tubes2 Open edition';
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm5, Form5);
  Application.CreateForm(TForm6, Form6);
  Application.CreateForm(TForm7, Form7);
  Application.CreateForm(TForm8, Form8);
  Application.CreateForm(TForm9, Form9);
  Application.CreateForm(TForm10, Form10);
  Application.CreateForm(TForm11, Form11);
  Application.Run;
end.


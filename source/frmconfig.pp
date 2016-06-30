{ +--------------------------------------------------------------------------+ }
{ | Tubes2 2.2 trial * Electrontube catalogue                                | }
{ | Copyright (C) 2008-2016 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | frmconfig.pp                                                             | }
{ | Settings window                                                          | }
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

unit frmconfig;
{$MODE OBJFPC}{$H+}
interface
uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons;
type
  { TForm7 }
  TForm7 = class(TForm)
    Bevel1: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    OpenDialog1: TOpenDialog;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 
var
  Form7: TForm7;
  defbrowser, defmailer: string;

Resourcestring
  MESSAGE01='Settings';
  MESSAGE02='Mailer application';
  MESSAGE03='Browser application';
  MESSAGE04='Disable search new version on internet';
  MESSAGE05='Full off-line mode';
  MESSAGE06='Browse..';
  MESSAGE07='Save';
  MESSAGE08='Cancel';
  MESSAGE09='Select browser application';
  MESSAGE10='Select mailer application';
  MESSAGE11='executables|*.exe|all files|*.*';
  MESSAGE12='all files|*.*';
  MESSAGE13='Default';

implementation
{$R *.lfm}
uses frmmain;

{ TForm7 }

//-- save data -----------------------------------------------------------------
procedure TForm7.Button3Click(Sender: TObject);
var tf: textfile;
begin
  frmmain.browserprogramme:=Edit1.Text;
  frmmain.mailerprogramme:=Edit2.Text;
  frmmain.offline:=CheckBox1.Checked;
  frmmain.nocheckupdate:=CheckBox2.Checked;

  assignfile(tf,userdir+DIR_CONFIG+'tubes2.cfg');
  rewrite(tf);
    write(tf,'# +'); for b:=4 to 79 do write(tf,'-'); writeln(tf,'+');
  writeln(tf,'# | Tubes2 2.1 * Electrontube catalogue                                        |');
  writeln(tf,'# | Copyright (C) 2008-2016 Pozsar Zsolt <pozsarzs@gmail.com                   |');
  writeln(tf,'# | tubes2.cfg                                                                 |');
  writeln(tf,'# | Configuration file                                                         |');
  write(tf,'# +'); for b:=4 to 79 do write(tf,'-'); writeln(tf,'+');
  writeln(tf,'BP='+Edit1.Text);
  writeln(tf,'MP='+Edit2.Text);
  write(tf,'FO='); if offline=true then writeln(tf,'1') else writeln(tf,'0');
  write(tf,'DF='); if nocheckupdate=true then writeln(tf,'1') else writeln(tf,'0');
  closefile(tf);
  Form1.MenuItem31.Enabled:=not frmmain.offline;
  Form1.MenuItem62.Enabled:=not frmmain.offline;
  Form1.ComboBox2.Enabled:=not frmmain.offline;
  Form7.Close;
end;

//-- select browser programme --------------------------------------------------
procedure TForm7.Button1Click(Sender: TObject);
begin
  OpenDialog1.InitialDir:=frmmain.userdir;
  OpenDialog1.Title:=MESSAGE09;
  {$IFDEF LINUX}
  Opendialog1.Filter:=MESSAGE12;
  {$ENDIF}
  {$IFDEF WINDOWS}
  Opendialog1.Filter:=MESSAGE11;
  {$ENDIF}
  if OpenDialog1.Execute=false then exit;
  Edit1.Text:=OpenDialog1.FileName;
end;

//-- select mailer programme --------------------------------------------------
procedure TForm7.Button2Click(Sender: TObject);
begin
  OpenDialog1.InitialDir:=frmmain.userdir;
  OpenDialog1.Title:=MESSAGE10;
  {$IFDEF LINUX}
  Opendialog1.Filter:=MESSAGE12;
  {$ENDIF}
  {$IFDEF WINDOWS}
  Opendialog1.Filter:=MESSAGE11;
  {$ENDIF}
  if OpenDialog1.Execute=false then exit;
  Edit2.Text:=OpenDialog1.FileName;
end;

//-- close without save --------------------------------------------------------
procedure TForm7.Button4Click(Sender: TObject);
begin
  Form7.Close;
end;

//-- set default values --------------------------------------------------------
procedure TForm7.Button5Click(Sender: TObject);
begin
  Edit1.Text:=defbrowser;
  Edit2.Text:=defmailer;
  CheckBox1.Checked:=false;
  CheckBox1.Checked:=false;
end;

//-- CheckBox change event -----------------------------------------------------
procedure TForm7.CheckBox1Change(Sender: TObject);
begin
end;

//-- OnShow event --------------------------------------------------------------
procedure TForm7.FormShow(Sender: TObject);
begin
  Form7.Caption:=MESSAGE01;
  Label1.Caption:=MESSAGE03;
  Label2.Caption:=MESSAGE02;
  CheckBox1.Caption:=MESSAGE05;
  CheckBox2.Caption:=MESSAGE04;
  Button1.Caption:=MESSAGE06;
  Button2.Caption:=MESSAGE06;
  Button3.Caption:=MESSAGE07;
  Button4.Caption:=MESSAGE08;
  Button5.Caption:=MESSAGE13;
  {$IFDEF LINUX}
    defbrowser:='xdg-open';
    defmailer:='xdg-email';
  {$ENDIF}
  {$IFDEF WINDOWS}
    defbrowser:='rundll32.exe url.dll,FileProtocolHandler';
    defmailer:='rundll32.exe url.dll,FileProtocolHandler mailto:';
  {$ENDIF}
  Edit1.Text:=frmmain.browserprogramme;
  if Edit1.Text='' then Edit1.Text:=defbrowser;
  Edit2.Text:=frmmain.mailerprogramme;
  if Edit2.Text='' then Edit2.Text:=defmailer;
  CheckBox1.Checked:=frmmain.offline;
  CheckBox2.Checked:=frmmain.nocheckupdate;
end;
end.


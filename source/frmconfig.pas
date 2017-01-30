{ +--------------------------------------------------------------------------+ }
{ | Tubes2 Open edition 2.2 * Electron tube catalog                          | }
{ | Copyright (C) 2008-2017 Pozsar Zsolt <info@pozsarzs.hu>                  | }
{ | frmconfig.pas                                                            | }
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
  Buttons,
  Classes,
  ComCtrls,
  Controls,
  Dialogs,
  ExtCtrls,
  Forms,
  Graphics,
  INIFiles,
  LResources,
  StdCtrls,
  SysUtils;
type
  { TForm7 }
  TForm7 = class(TForm)
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Image1: TImage;
    ImageList1: TImageList;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    OpenDialog1: TOpenDialog;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 
var
  Form7: TForm7;
const
  {$IFDEF UNIX}
    DEFBROWSER='xdg-open';                        // default browser application
    DEFMAILER='xdg-email';                         // default mailer application
  {$ENDIF}
  {$IFDEF WINDOWS}
    DEFBROWSER='rundll32.exe url.dll,FileProtocolHandler';
    DEFMAILER='rundll32.exe url.dll,FileProtocolHandler mailto:';
  {$ENDIF}
  INIFILE: string=('tubes2.ini');                               // settings file
  WSNAME: array[1..6] of string=('Bing',
                                 'DuckDuckGo',
                                 'Google',
                                 'Yahoo',
                                 'Yandex',
                                 '(User)');

  WSURL: array[1..6] of string= ('http://www.bing.com/search?q=',
                                 'https://duckduckgo.com/?q=',
                                 'https://www.google.hu/search?q=',
                                 'https://search.yahoo.com/search?p=',
                                 'https://yandex.ru/search/?text=',
                                 '');

procedure loadsettings;
procedure savedefaultsettings;

Resourcestring
  MESSAGE01='black';
  MESSAGE02='blue';
  MESSAGE03='green';
  MESSAGE04='red';
  MESSAGE05='white';
  MESSAGE06='yellow';
  {...}
  MESSAGE09='Select browser application';
  MESSAGE10='Select mailer application';
  MESSAGE11='executables|*.exe|all files|*.*';
  MESSAGE12='all files|*.*';

implementation
uses
  frmdrawer,
  frmmain;

{$R *.lfm}
{ TForm7 }

procedure loadsettings;                                          // load setting
var
  ini: TINIFile;
begin
  ini:=TIniFile.Create(userdir+DIR_CONFIG+INIFILE);
  try
    offline:=ini.ReadBool('General','OffLineMode',false);
    nocheckupdate:=ini.ReadBool('General','NoCheckUpdate',false);
    browserprogramme:=ini.ReadString('Applications','Browser','');
    mailerprogramme:=ini.ReadString('Applications','Mailer','');
    websearchurl:=ini.ReadString('Applications','SearcherURL','');
    Form1.MenuItem50.Checked:=ini.ReadBool('Display','ShowLines',false);
    Form1.MenuItem28.Checked:=ini.ReadBool('Display','ShowDescription',true);
    frmdrawer.grid:=ini.ReadBool('Display','CharDrawShowGrid',true);
    frmdrawer.header:=ini.ReadBool('Display','CharDrawShowInfo',true);
    displaycolors:=ini.ReadInteger('Display','CharDrawColour',2);
    ini.Free;
  except
  end;
end;

procedure savedefaultsettings;                           // save default setting
begin
  assignfile(tf,userdir+DIR_CONFIG+INIFILE);
  try
    rewrite(tf);
    writeln(tf,'; '+APPNAME+' v'+VERSION+' - Default settings');
    writeln(tf,'');
    writeln(tf,'[General]');
    writeln(tf,'OffLineMode=0');
    writeln(tf,'NoCheckUpdate=0');
    writeln(tf,'');
    writeln(tf,'[Applications]');
    writeln(tf,'Browser='+defbrowser);
    writeln(tf,'Mailer='+defmailer);
    writeln(tf,'SearcherName='+WSNAME[1]);
    writeln(tf,'SearcherURL='+WSURL[1]);
    writeln(tf,'');
    writeln(tf,'[Display]');
    writeln(tf,'ShowLines=0');
    writeln(tf,'ShowDescription=1');
    writeln(tf,'CharDrawShowGrid=1');
    writeln(tf,'CharDrawShowInfo=1');
    writeln(tf,'CharDrawColour=2');
    closefile(tf);
  except
  end;
end;

procedure TForm7.Button3Click(Sender: TObject);                 // save settings
var
  ini: textfile;
begin
  frmmain.browserprogramme:=Edit1.Text;
  frmmain.displaycolors:=ComboBox1.ItemIndex+1;
  frmmain.mailerprogramme:=Edit2.Text;
  frmmain.nocheckupdate:=CheckBox2.Checked;
  frmmain.offline:=CheckBox1.Checked;
  frmmain.websearchurl:=Edit3.Text;

  assignfile(ini,userdir+DIR_CONFIG+INIFILE);
  try
    rewrite(ini);
    writeln(ini,'; '+APPNAME+' v'+VERSION);
    writeln(ini,'');
    writeln(ini,'[General]');
    write(  ini,'OffLineMode=');
    if offline=true then writeln(ini,'1') else writeln(ini,'0');
    write(  ini,'NoCheckUpdate=');
    if nocheckupdate=true then writeln(ini,'1') else writeln(ini,'0');
    writeln(ini,'');
    writeln(ini,'[Applications]');
    writeln(ini,'Browser=',browserprogramme);
    writeln(ini,'Mailer=',mailerprogramme);
    writeln(ini,'SearcherName=',ComboBox2.Items.Strings[ComboBox2.ItemIndex]);
    writeln(ini,'SearcherURL=',websearchurl);
    writeln(ini,'');
    writeln(ini,'[Display]');
    write(  ini,'ShowLines=');
    if Form1.MenuItem50.Checked=true
      then writeln(ini,'1')
      else writeln(ini,'0');
    write(  ini,'ShowDescription=');
    if Form1.MenuItem28.Checked=true
      then writeln(ini,'1')
      else writeln(ini,'0');
    write(  ini,'CharDrawShowGrid=');
    if frmdrawer.grid=true
      then writeln(ini,'1')
      else writeln(ini,'0');
    write(  ini,'CharDrawShowInfo=');
    if frmdrawer.header=true
      then writeln(ini,'1')
      else writeln(ini,'0');
    write(  ini,'CharDrawColour=',inttostr(displaycolors));
    closefile(ini);
  except
  end;

  Form1.MenuItem31.Enabled:=not frmmain.offline;
  Form1.MenuItem38.Enabled:=not frmmain.offline;
  Form1.MenuItem39.Enabled:=not frmmain.offline;
  Form1.MenuItem40.Enabled:=not frmmain.offline;
  Form1.MenuItem62.Enabled:=not frmmain.offline;
  Form1.ComboBox2.Enabled:=not frmmain.offline;
  Form1.ToolButton8.Enabled:=not frmmain.offline;
  Form7.Close;
end;

procedure TForm7.Button1Click(Sender: TObject);                // select browser
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

procedure TForm7.Button2Click(Sender: TObject);                 // select mailer
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

procedure TForm7.Button4Click(Sender: TObject);            // close without save
begin
  Form7.Close;
end;

procedure TForm7.Button5Click(Sender: TObject);            // set default values
begin
  Edit1.Text:=DEFBROWSER;
  Edit2.Text:=DEFMAILER;
  CheckBox1.Checked:=false;
  CheckBox2.Checked:=false;
  ComboBox2.ItemIndex:=0; ComboBox2Change(Sender);
  ComboBox1.ItemIndex:=1; ComboBox1Change(Sender);
end;

//-- Change events -------------------------------------------------------------
procedure TForm7.CheckBox1Change(Sender: TObject);
begin
  CheckBox2.Enabled:=not CheckBox1.Checked;
end;

procedure TForm7.ComboBox1Change(Sender: TObject);
begin
  Image1.Picture.Bitmap:= nil;
  ImageList1.GetBitmap(ComboBox1.ItemIndex, Image1.Picture.Bitmap);
end;

procedure TForm7.ComboBox2Change(Sender: TObject);
begin
  for b:=1 to 6 do
    if WSNAME[b]=ComboBox2.Items.Strings[ComboBox2.ItemIndex] then break;
  Edit3.Text:=wsurl[b];
  if length(WSURL[b])=0 then Edit3.ReadOnly:=false else Edit3.ReadOnly:=true;
end;

//-- OnShow event --------------------------------------------------------------
procedure TForm7.FormShow(Sender: TObject);
begin
  // general settings
  Edit1.Text:=frmmain.browserprogramme;
  if Edit1.Text='' then Edit1.Text:=defbrowser;
  Edit2.Text:=frmmain.mailerprogramme;
  if Edit2.Text='' then Edit2.Text:=defmailer;
  CheckBox1.Checked:=frmmain.offline;
  CheckBox2.Checked:=frmmain.nocheckupdate;
  // searchers
  ComboBox2.Clear;
  for b:=1 to 6 do
    ComboBox2.Items.Add(WSNAME[b]);
  Edit3.Text:=frmmain.websearchurl;
  for b:=1 to 6 do
    if WSURL[b]=Edit3.Text then break;
  ComboBox2.ItemIndex:=b-1;
  if (b>0) and (b<6) then ComboBox2Change(Sender);
  // colours
  ComboBox1.Clear;
  ComboBox1.Items.Add(MESSAGE01);
  ComboBox1.Items.Add(MESSAGE02);
  ComboBox1.Items.Add(MESSAGE03);
  ComboBox1.Items.Add(MESSAGE04);
  ComboBox1.Items.Add(MESSAGE05);
  ComboBox1.Items.Add(MESSAGE06);
  if displaycolors=0 then displaycolors:=2;
  ComboBox1.ItemIndex:=displaycolors-1;
  ComboBox1Change(Sender);
end;

end.


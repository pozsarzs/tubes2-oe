{ +--------------------------------------------------------------------------+ }
{ | Tubes2 Open edition 2.2 * Electrontube catalogue                         | }
{ | Copyright (C) 2008-2017 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | frmupgrade.pas                                                           | }
{ | Upgrade                                                                  | }
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

unit frmupgrade;
{$MODE OBJFPC}{$H+}
interface
uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  ComCtrls, Buttons, StdCtrls, HTTPSend, unzip51g, dos;
type
  { TForm6 }
  TForm6 = class(TForm)
    Bevel1: TBevel;
    Bevel2: TBevel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    OpenDialog1: TOpenDialog;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;
var
  Form6: TForm6;
  usersdatadir: string;

Resourcestring
  {...}
  MESSAGE07='Open ZIP file';
  MESSAGE08='There is no new version of database!';
  MESSAGE09='Download error!';
  MESSAGE10='Datafile is installed.';
  MESSAGE11='Install error!';
  MESSAGE12='Datafile corrupt!';
  MESSAGE13='File read/write error!';
  {...}
  MESSAGE16='Remove error!';
  MESSAGE17='Tubes2 needs restart to use new or preinstalled database. Press OK to close application.';
  MESSAGE18='ZIP archives|*.zip|all files|*.*';

implementation
uses frmmain;
{$R *.lfm}
{ TForm6 }
var
  restart: boolean;

//-- close box -----------------------------------------------------------------
procedure TForm6.Button3Click(Sender: TObject);
begin
  Form6.Close;
end;

procedure TForm6.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  if restart=true then
  begin
   showmessage(MESSAGE17);
   Application.Terminate;
  end;
  CanClose:=true;
end;

//-- remove user-installed datafiles -------------------------------------------
procedure TForm6.Button4Click(Sender: TObject);
var
  searchresult: searchrec;
  f: file;
begin
  restart:=true;
  findfirst(userdir+DIR_PICS+'*.*',anyfile,searchresult);
  while doserror=0 do
  begin
    with searchresult do
    begin
      assignfile(f,userdir+DIR_PICS+name);
      {$I-}
      if (name<>'.') and (name<>'..') then erase(f);
      {$I+}
      if ioresult<>0 then showmessage(MESSAGE16);
    end;
    findnext(searchresult);
  end;

  findfirst(usersdatadir+'*.*',anyfile,searchresult);
  while doserror=0 do
  begin
    with searchresult do
    begin
      assignfile(f,usersdatadir+name);
      {$I-}
      if (name<>'.') and (name<>'..') and (name<>'base') then erase(f);
      {$I+}
      if ioresult<>0 then showmessage(MESSAGE16);
    end;
    findnext(searchresult);
  end;
end;

//-- check file ----------------------------------------------------------------
function checkdatafile(filename: string): boolean;
begin
  checkdatafile:=true;
end;

//-- unzip file ----------------------------------------------------------------
function unzipdatafile(filename: string): boolean;
var
  zresult: integer;
  zipfile: string;
begin
  zipfile:=usersdatadir+'xedf-tubes2-current-'+frmmain.dbln+'.zip';
  {$IFDEF UNIX}
  chdir(usersdatadir);
  zresult:=FileUnzipEx(@zipfile[1],'./','');
  {$ENDIF}
  {$IFDEF WIN32}
  chdir(usersdatadir);
  zresult:=FileUnzipEx(@zipfile[1],'.\','');
  {$ENDIF}
  if zresult<=0 then unzipdatafile:=false else unzipdatafile:=true;
  if unzipdatafile=false then ShowMessage(MESSAGE11);
end;

//-- from file -----------------------------------------------------------------
procedure TForm6.Button1Click(Sender: TObject);
var
  fi, fo: file of byte;
  b: byte;
begin
  OpenDialog1.InitialDir:=frmmain.userdir;
  OpenDialog1.Title:=MESSAGE07;
  Opendialog1.Filter:=MESSAGE18;
  if OpenDialog1.Execute=false then exit;
  restart:=true;
  AssignFile(fi,OpenDialog1.FileName);
  AssignFile(fo,usersdatadir+'xedf-tubes2-current-'+frmmain.dbln+'.zip');
  try
    reset(fi);
    rewrite(fo);
    repeat
      read(fi,b);
      write(fo,b);
    until eof(fi);
    CloseFile(fi);
    CloseFile(fo);
  except
    ShowMessage(MESSAGE13);
    restart:=false;
    exit;
  end;
  if checkdatafile(usersdatadir+'xedf-tubes2-current-'+frmmain.dbln+'.zip')
  then
    if unzipdatafile(usersdatadir+'xedf-tubes2-current-'+frmmain.dbln+'.zip')
    then showmessage(MESSAGE10) else
    begin
      showmessage(MESSAGE11);
      restart:=false;
      exit;
    end
  else
  begin
   showmessage(MESSAGE12);
   restart:=false;
   exit;
  end;
end;

//-- from internet -------------------------------------------------------------
procedure TForm6.Button2Click(Sender: TObject);
var
  bin: TFileStream;
begin
 restart:=true;
  if frmmain.thereisnewversion=false then
  begin
    showmessage(MESSAGE08);
    restart:=false;
    exit;
  end;
  Button1.Enabled:=false;
  Button2.Enabled:=false;
  Button3.Enabled:=false;
  Button4.Enabled:=false;
  restart:=true;
  bin:=TFileStream.Create(usersdatadir+'xedf-tubes2-current-'+frmmain.dbln+'.zip',fmCreate);
  with THTTPSend.Create do
  begin
    if HttpGetBinary(frmmain.checkupdateurl+'xedf-tubes2-current-'+frmmain.dbln+'.zip',bin) then
    try
    except
      showmessage(MESSAGE09);
      restart:=true;
      Button1.Enabled:=true;
      Button2.Enabled:=true;
      Button3.Enabled:=true;
      Button4.Enabled:=true;
      exit;
    end;
    Button1.Enabled:=true;
    Button2.Enabled:=true;
    Button3.Enabled:=true;
    Button4.Enabled:=true;
    Free;
  end;
  bin.Free;
  if checkdatafile(usersdatadir+'xedf-tubes2-current-'+frmmain.dbln+'.zip')
  then
    if unzipdatafile(usersdatadir+'xedf-tubes2-current-'+frmmain.dbln+'.zip')
    then showmessage(MESSAGE10) else
    begin
      showmessage(MESSAGE11);
      restart:=false;
      exit;
    end
  else showmessage(MESSAGE12);
end;

//-- OnShow event --------------------------------------------------------------
procedure TForm6.FormShow(Sender: TObject);
begin
  usersdatadir:=frmmain.userdir+DIR_DATA;
  restart:=false;
  Button2.Enabled:=not frmmain.offline=true;
end;
end.

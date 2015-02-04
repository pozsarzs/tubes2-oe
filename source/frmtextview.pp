{ +--------------------------------------------------------------------------+ }
{ | Tubes2 2.0.2 trial * Electrontube catalogue                              | }
{ | Copyright (C) 2008-2015 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | frmtextview.pp                                                           | }
{ | Text viewer                                                              | }
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

unit frmtextview;
{$mode objfpc}{$H+}
interface
uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ExtCtrls;
type
  { TForm8 }
  TForm8 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 
var
  Form8: TForm8; 

Resourcestring
  MESSAGE01='&Close';

implementation
{$R *.lfm}
{ TForm8 }

//-- FormCreate event ----------------------------------------------------------
procedure TForm8.FormCreate(Sender: TObject);
begin
  Button1.Caption:=MESSAGE01;
end;

//-- Resize event --------------------------------------------------------------
procedure TForm8.FormResize(Sender: TObject);
begin
  Memo1.Width:=Width-9;
  Memo1.Height:=Height-46;
  Button1.Top:=Height-29;
  Button1.Left:=Width-79;
end;

//-- Close window --------------------------------------------------------------
procedure TForm8.Button1Click(Sender: TObject);
begin
  Form8.Close;
end;
end.

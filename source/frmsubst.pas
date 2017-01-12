{ +--------------------------------------------------------------------------+ }
{ | Tubes2 Open edition 2.2 * Electrontube catalogue                         | }
{ | Copyright (C) 2008-2017 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | frmsubst.pas                                                             | }
{ | Type substitution                                                        | }
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

unit frmsubst;
{$MODE OBJFPC}{$H+}
interface
uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls;
type
  { TForm11 }
  TForm11 = class(TForm)
    Bevel1: TBevel;
    Edit1: TEdit;
    Label1: TLabel;
    Memo1: TMemo;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioGroup1: TRadioGroup;
    StatusBar1: TStatusBar;
    procedure Button1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RadioButton1Change(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;
var
  Form11: TForm11;

Resourcestring
  MESSAGE01='Not found.';

implementation
{$R *.lfm}
uses frmmain;
{ TForm11 }

procedure TForm11.Edit1Change(Sender: TObject);
var
  i: integer;
  ct: integer;
begin
  Memo1.Clear;
  ct:=0;
  for i:=1 to 5000 do
    if pos(Label1.Caption+Edit1.Text,frmmain.substdata[i,1])>0 then
    begin
      Memo1.Lines.Add(frmmain.substdata[i,1]+': '+frmmain.substdata[i,2]);
      ct:=ct+1;
    end;
  if ct=0 then Memo1.Lines.Add(MESSAGE01);
end;

procedure TForm11.RadioButton1Change(Sender: TObject);
begin
  if RadioButton1.Checked then Label1.Caption:=RadioButton1.Caption;
  if RadioButton2.Checked then Label1.Caption:=RadioButton2.Caption;
  if RadioButton3.Checked then Label1.Caption:=RadioButton3.Caption+'-';
  Edit1.Clear;
  Edit1Change(Sender);
end;

//-- close box -----------------------------------------------------------------
procedure TForm11.Button1Click(Sender: TObject);
begin
  Form11.Close;
end;

//-- OnCreate event --------------------------------------------------------------
procedure TForm11.FormCreate(Sender: TObject);
begin
  RadioButton1Change(Sender);
  Edit1Change(Sender);
end;

end.


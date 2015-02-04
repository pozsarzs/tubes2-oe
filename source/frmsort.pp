{ +--------------------------------------------------------------------------+ }
{ | Tubes2 2.0.2 trial * Electrontube catalogue                              | }
{ | Copyright (C) 2008-2015 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | frmsort.pp                                                               | }
{ | Sort                                                                     | }
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

unit frmsort;
{$MODE OBJFPC}{$H+}
interface
uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons;
type
  { TForm5 }
  TForm5 = class(TForm)
    Bevel1: TBevel;
    Button1: TButton;
    Button2: TButton;
    ComboBox1: TComboBox;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form5: TForm5; 
  b: byte;
  s: string;
  
Resourcestring
  MESSAGE01='Base column';
  MESSAGE02='&Start sort';
  MESSAGE03='Sort';
  MESSAGE04='&Close';

implementation
{$R *.lfm}
uses frmMain;

{ TForm5 }

//-- start sort ----------------------------------------------------------------
procedure TForm5.Button1Click(Sender: TObject);
var
  i,j: integer;
begin
  Form1.StringGrid1.RowCount:=Form1.StringGrid1.RowCount+1;
  for i:=1 to Form1.StringGrid1.RowCount-3 do
    for j:=i+1 to Form1.StringGrid1.RowCount-2 do
      if Form1.StringGrid1.Cells[ComboBox1.ItemIndex,i]>Form1.StringGrid1.Cells[ComboBox1.ItemIndex,j] then
      begin
        for b:=0 to Form1.StringGrid1.ColCount-1 do
        begin
          Form1.StringGrid1.Cells[b,Form1.StringGrid1.RowCount-1]:=Form1.StringGrid1.Cells[b,i];
          Form1.StringGrid1.Cells[b,i]:=Form1.StringGrid1.Cells[b,j];
          Form1.StringGrid1.Cells[b,j]:=Form1.StringGrid1.Cells[b,Form1.StringGrid1.RowCount-1];
        end;
        frmmain.pinout[800]:=frmmain.pinout[i];
        frmmain.pinout[i]:=frmmain.pinout[j];
        frmmain.pinout[j]:=frmmain.pinout[800];
        frmmain.cpld[800]:=frmmain.cpld[i];
        frmmain.cpld[i]:=frmmain.cpld[j];
        frmmain.cpld[j]:=frmmain.cpld[800];
      end;
  Form1.StringGrid1.RowCount:=Form1.StringGrid1.RowCount-1;
  Form1.StringGrid1.Row:=1;
end;

//-- close box -----------------------------------------------------------------
procedure TForm5.Button2Click(Sender: TObject);
begin
  Form5.Close;
end;

//-- OnShow event --------------------------------------------------------------
procedure TForm5.FormShow(Sender: TObject);
begin
  Label1.Caption:=MESSAGE01;
  Button1.Caption:=MESSAGE02;
  Form5.Caption:=MESSAGE03;
  Button2.Caption:=MESSAGE04;
  ComboBox1.Items.Clear;
  for b:=0 to Form1.StringGrid1.ColCount-1
    do ComboBox1.Items.Add(Form1.StringGrid1.Cells[b,0]);
  ComboBox1.ItemIndex:=0;
end;
end.

{ +--------------------------------------------------------------------------+ }
{ | Tubes2 Open edition 2.2 * Electron tube catalog                          | }
{ | Copyright (C) 2008-2017 Pozsar Zsolt <info@pozsarzs.hu>                  | }
{ | frmsort.pas                                                              | }
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
  Buttons,
  Classes,
  Controls,
  ExtCtrls,
  Forms,
  LResources,
  StdCtrls,
  SysUtils;
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

implementation
uses
  frmmain;

{$R *.lfm}
{TForm5}

procedure TForm5.Button1Click(Sender: TObject);                    // start sort
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

procedure TForm5.Button2Click(Sender: TObject);                  // close window
begin
  Form5.Close;
end;

//-- Other event --------------------------------------------------------------
procedure TForm5.FormShow(Sender: TObject);
begin
  ComboBox1.Items.Clear;
  for b:=0 to Form1.StringGrid1.ColCount-1
    do ComboBox1.Items.Add(Form1.StringGrid1.Cells[b,0]);
  ComboBox1.ItemIndex:=0;
end;
end.

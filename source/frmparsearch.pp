{ +--------------------------------------------------------------------------+ }
{ | Tubes2 2.1 trial * Electrontube catalogue                                | }
{ | Copyright (C) 2008-2016 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | frmparsearch.pp                                                          | }
{ | Parameter search                                                         | }
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

unit frmparsearch;
{$mode objfpc}{$H+}
interface
uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, Buttons,
  StdCtrls, ExtCtrls, Spin;
type
  { TForm3 }
  TForm3 = class(TForm)
    Bevel1: TBevel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ListBox1: TListBox;
    ListBox2: TListBox;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    SpinEdit3: TSpinEdit;
    SpinEdit4: TSpinEdit;
    SpinEdit5: TSpinEdit;
    SpinEdit6: TSpinEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;
var
  Form3: TForm3;
  i: integer;

Resourcestring
  MESSAGE01='Parameter search';
  MESSAGE02='parameter/unit';
  MESSAGE03='min.';
  MESSAGE04='max.';
  MESSAGE05='&Search';
  MESSAGE06='&Close';
  MESSAGE07='&Reset';
  MESSAGE08='result list';
  MESSAGE09='Not found!';
  MESSAGE10='&Jump';

implementation
{$R *.lfm}
uses frmmain;

{ TForm3 }

procedure TForm3.CheckBox3Click(Sender: TObject);
begin
  SpinEdit5.Enabled:=CheckBox3.Checked;
  SpinEdit6.Enabled:=CheckBox3.Checked;
  ComboBox3.Enabled:=CheckBox3.Checked;
end;

procedure TForm3.CheckBox2Click(Sender: TObject);
begin
  SpinEdit3.Enabled:=CheckBox2.Checked;
  SpinEdit4.Enabled:=CheckBox2.Checked;
  ComboBox2.Enabled:=CheckBox2.Checked;
  CheckBox3.Enabled:=CheckBox2.Checked;
  if CheckBox2.Checked=false then
  begin
   SpinEdit5.Enabled:=false;
   SpinEdit6.Enabled:=false;
   ComboBox3.Enabled:=false;
   CheckBox3.Checked:=false;;
  end;
end;

//-- close ---------------------------------------------------------------------
procedure TForm3.Button2Click(Sender: TObject);
begin
  Form3.Close;
end;

//-- reset ---------------------------------------------------------------------
procedure TForm3.Button3Click(Sender: TObject);
begin
  SpinEdit1.Value:=0;;
  SpinEdit2.Value:=0;
  SpinEdit3.Value:=0;
  SpinEdit4.Value:=0;
  SpinEdit5.Value:=0;
  SpinEdit6.Value:=0;
  ListBox1.Clear;
  ComboBox1.ItemIndex:=0;
  ComboBox2.ItemIndex:=0;
  ComboBox3.ItemIndex:=0;
  Button4.Enabled:=false;
end;

//-- jump ----------------------------------------------------------------------
procedure TForm3.Button4Click(Sender: TObject);
begin
  for i:=1 to 32000 do
  begin
    if i=Form1.StringGrid1.RowCount then
    begin
      showmessage(MESSAGE26);
      exit;
    end;
    if Form1.StringGrid1.Cells[0,i]=ListBox1.Items[ListBox1.ItemIndex] then
    begin
      Form1.StringGrid1.Row:=i;
      exit;
    end;
  end;

end;

//-- search --------------------------------------------------------------------
procedure TForm3.Button1Click(Sender: TObject);
var
  v: extended;
begin
  Button4.Enabled:=false;
  if SpinEdit1.Value>SpinEdit2.Value then
  begin
    v:=SpinEdit1.Value;
    SpinEdit1.Value:=SpinEdit2.Value;
    SpinEdit2.Value:=v;
  end;
  if SpinEdit1.Value>SpinEdit2.Value then
  begin
    v:=SpinEdit3.Value;
    SpinEdit3.Value:=SpinEdit4.Value;
    SpinEdit4.Value:=v;
  end;
  if SpinEdit1.Value>SpinEdit2.Value then
  begin
    v:=SpinEdit5.Value;
    SpinEdit5.Value:=SpinEdit6.Value;
    SpinEdit6.Value:=v;
  end;
  ListBox1.Clear;
  // step 1
  for b:=0 to 255 do
    if Form1.StringGrid1.Cells[b,0]=ComboBox1.Items[ComboBox1.ItemIndex] then break;
  for i:=1 to Form1.StringGrid1.RowCount-1 do
  begin
    v:=StrToFloat(Form1.StringGrid1.Cells[b,i]);
    if (SpinEdit1.Value<v) and (SpinEdit2.Value>v)
      then ListBox1.Items.Add(Form1.StringGrid1.Cells[0,i]);
  end;
  // step 2
  if CheckBox2.Checked=true then
  begin
    for b:=0 to 255 do
      if Form1.StringGrid1.Cells[b,0]=ComboBox2.Items[ComboBox2.ItemIndex] then break;
    for i:=1 to Form1.StringGrid1.RowCount-1 do
    begin
      v:=StrToFloat(Form1.StringGrid1.Cells[b,i]);
      if (SpinEdit3.Value<v) and (SpinEdit4.Value>v)
      then ListBox1.Items.Add(Form1.StringGrid1.Cells[0,i]);
    end;
  end;
  // step 3
  if CheckBox3.Checked=true then
  begin
    for b:=0 to 255 do
      if Form1.StringGrid1.Cells[b,0]=ComboBox3.Items[ComboBox3.ItemIndex] then break;
    for i:=1 to Form1.StringGrid1.RowCount-1 do
    begin
      v:=StrToFloat(Form1.StringGrid1.Cells[b,i]);
      if (SpinEdit5.Value<v) and (SpinEdit6.Value>v)
      then ListBox1.Items.Add(Form1.StringGrid1.Cells[0,i]);
    end;
  end;
  if (CheckBox3.Checked=true) and (CheckBox2.Checked=true) then
  begin
    ListBox2.Clear;
    for i:=0 to ListBox1.Items.Count-3 do
    begin
      s:=ListBox1.Items[i];
      if (ListBox1.Items[i+1]=s) and (ListBox1.Items[i+2]=s) then ListBox2.Items.Add(s);
    end;
    ListBox1.Clear;
    for i:=0 to ListBox2.Items.Count-1 do
      ListBox1.Items.Add(ListBox2.Items[i]);
  end;
  if (CheckBox2.Checked=true) and  (CheckBox3.Checked=false) then
  begin
    ListBox2.Clear;
    for i:=0 to ListBox1.Items.Count-2 do
    begin
      s:=ListBox1.Items[i];
      if ListBox1.Items[i+1]=s then ListBox2.Items.Add(s);
    end;
    ListBox1.Clear;
    for i:=0 to ListBox2.Items.Count-1 do
      ListBox1.Items.Add(ListBox2.Items[i]);
  end;
  if ListBox1.Items.Count=0 then ShowMessage(MESSAGE09) else Button4.Enabled:=true;
end;

//-- OnShow event --------------------------------------------------------------
procedure TForm3.FormShow(Sender: TObject);
begin
  SpinEdit1.Value:=0;
  SpinEdit2.Value:=0;
  SpinEdit3.Value:=0;
  SpinEdit4.Value:=0;
  SpinEdit5.Value:=0;
  SpinEdit6.Value:=0;
  ListBox1.Clear;
  CheckBox2.Checked:=false;
  CheckBox3.Checked:=false;
  Form3.Caption:=MESSAGE01;
  Label1.Caption:=MESSAGE02;
  Label2.Caption:=MESSAGE03;
  Label3.Caption:=MESSAGE04;
  Label4.Caption:=MESSAGE08;
  Button1.Caption:=MESSAGE05;
  Button2.Caption:=MESSAGE06;
  Button3.Caption:=MESSAGE07;
  Button4.Caption:=MESSAGE10;
  ComboBox1.Clear;
  ComboBox2.Clear;
  ComboBox3.Clear;
  for b:=3 to Form1.StringGrid1.ColCount-1 do ComboBox1.Items.Add(Form1.StringGrid1.Cells[b,0]);
  for b:=3 to Form1.StringGrid1.ColCount-1 do ComboBox2.Items.Add(Form1.StringGrid1.Cells[b,0]);
  for b:=3 to Form1.StringGrid1.ColCount-1 do ComboBox3.Items.Add(Form1.StringGrid1.Cells[b,0]);
  ComboBox1.ItemIndex:=0;
  ComboBox2.ItemIndex:=0;
  ComboBox3.ItemIndex:=0;
end;
end.


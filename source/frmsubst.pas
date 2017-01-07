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
  ExtCtrls, StdCtrls;
type

  { TForm11 }

  TForm11 = class(TForm)
    Bevel1: TBevel;
    Button1: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    Memo1: TMemo;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioGroup1: TRadioGroup;
    procedure Edit1Change(Sender: TObject);
    procedure RadioGroup1ChangeBounds(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;
var
  Form11: TForm11;

implementation
{$R *.lfm}

{ TForm11 }

procedure TForm11.RadioGroup1ChangeBounds(Sender: TObject);
begin

end;

procedure TForm11.Edit1Change(Sender: TObject);
begin

end;

end.


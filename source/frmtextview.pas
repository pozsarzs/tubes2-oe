{ +--------------------------------------------------------------------------+ }
{ | Tubes2 Open edition 2.2 * Electron tube catalog                          | }
{ | Copyright (C) 2008-2017 Pozsar Zsolt <info@pozsarzs.hu>                  | }
{ | frmtextview.pas                                                          | }
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
{$MODE OBJFPC}{$H+}
interface
uses
  Classes,
  Forms,
  StdCtrls;
type
  { TForm8 }
  TForm8 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 
var
  Form8: TForm8; 

implementation

{$R *.lfm}
{ TForm8 }

procedure TForm8.Button1Click(Sender: TObject);                  // close window
begin
  Form8.Close;
end;
end.

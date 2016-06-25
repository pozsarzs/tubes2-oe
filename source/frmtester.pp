{ +--------------------------------------------------------------------------+ }
{ | Tubes2 2.2 trial * Electrontube catalogue                                | }
{ | Copyright (C) 2008-2016 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | frmtester.pp                                                             | }
{ | Tube tester tool                                                         | }
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

unit frmtester;
{$MODE OBJFPC}
interface
uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls;
type
  { TForm4 }
  TForm4 = class(TForm)
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
  private
    { private declarations }
  public
    { public declarations }
  end;
var
  Form4: TForm4;

implementation
{$R *.lfm}
initialization

end.


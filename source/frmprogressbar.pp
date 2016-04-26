{ +--------------------------------------------------------------------------+ }
{ | Tubes2 2.1 trial * Electrontube catalogue                                | }
{ | Copyright (C) 2008-2016 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | frmprogressbar.pp                                                        | }
{ | Progress bar                                                             | }
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

unit frmprogressbar;
{$mode objfpc}{$H+}
interface
uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls;
type
  { TForm9 }
  TForm9 = class(TForm)
    Bevel1: TBevel;
    ProgressBar1: TProgressBar;
  private
    { private declarations }
  public
    { public declarations }
  end;
var
  Form9: TForm9;

implementation
{$R *.lfm}
{ TForm9 }
end.

{ +--------------------------------------------------------------------------+ }
{ | Tubes 2.0 Trial * Electrontube catalogue                                 | }
{ | Copyright (C) 2008-2012 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | frmabout.pp                                                              | }
{ | About                                                                    | }
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

unit frmabout;
{$MODE OBJFPC}{$H+}
interface
uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, Buttons,
  ExtCtrls, StdCtrls;
type
  { TForm2 }
  TForm2 = class(TForm)
    Bevel1: TBevel;
    Button1: TButton;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Form2Show(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure Label5MouseEnter(Sender: TObject);
    procedure Label5MouseLeave(Sender: TObject);
    procedure Label6Click(Sender: TObject);
    procedure Label6MouseEnter(Sender: TObject);
    procedure Label6MouseLeave(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 
var
  Form2: TForm2; 

Resourcestring
  MESSAGE01='About';
  MESSAGE02='&Close';
  MESSAGE03='Electrontube catalogue';
  MESSAGE04='Licence: GNU GPL 3.0 or later.';
  MESSAGE05='Sorry, there is off-line mode.';

implementation
uses frmmain;
{$R *.lfm}
{ TForm2 }

//-- close windows -------------------------------------------------------------
procedure TForm2.Button1Click(Sender: TObject);
begin
  Form2.Close;
end;

//-- click on e-mail address ---------------------------------------------------
procedure TForm2.Label5Click(Sender: TObject);
begin
  if frmmain.offline=false
  then runmailer(Label5.Caption)
  else showmessage(MESSAGE05);
end;

procedure TForm2.Label5MouseEnter(Sender: TObject);
begin
  Label5.Font.Color:=clMaroon;
end;

procedure TForm2.Label5MouseLeave(Sender: TObject);
begin
  Label5.Font.Color:=clSkyBlue;
end;

//-- click on webaddress -------------------------------------------------------
procedure TForm2.Label6Click(Sender: TObject);
begin
  if frmmain.offline=false
  then runbrowser(Label6.Caption)
  else showmessage(MESSAGE05);
end;

procedure TForm2.Label6MouseEnter(Sender: TObject);
begin
  Label6.Font.Color:=clMaroon;
end;

procedure TForm2.Label6MouseLeave(Sender: TObject);
begin
  Label6.Font.Color:=clSkyBlue;
end;

//-- OnShow event --------------------------------------------------------------
procedure TForm2.Form2Show(Sender: TObject);
begin
  Form2.Caption:=MESSAGE01;
  Label1.Caption:='Tubes '+frmmain.VERSION+' Trial';
  Label2.Caption:=MESSAGE03;
  Label4.Caption:=MESSAGE04;
  Button1.Caption:=MESSAGE02;
end;
end.

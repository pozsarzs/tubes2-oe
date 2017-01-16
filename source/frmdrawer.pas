{ +--------------------------------------------------------------------------+ }
{ | Tubes2 Open edition 2.2 * Electrontube catalogue                         | }
{ | Copyright (C) 2008-2017 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | frmdrawer.pas                                                            | }
{ | Characteristic drawer                                                    | }
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

unit frmdrawer;
{$MODE OBJFPC}{$H+}
interface
uses
 {$IFDEF LINUX} Types, {$ENDIF}{$IFDEF WIN32} Windows, {$ENDIF}
  Classes, SysUtils, FileUtil, LResources, Forms,
  Controls, Graphics, Dialogs, Menus, ComCtrls, ExtCtrls, StdCtrls,
  Grids, Buttons, DOM, dos, GraphUtil, ExtDlgs, convert, process;
  type
{  t2crec=record
    title: string;
    d1xres

  end;}
  { TForm10 }
  TForm10 = class(TForm)
    Bevel4: TBevel;
    Bevel5: TBevel;
    BitBtn7: TBitBtn;
    Button10: TButton;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    Edit1: TEdit;
    Image2: TImage;
    Image3: TImage;
    ImageList1: TImageList;
    OpenDialog1: TOpenDialog;
    PageControl1: TPageControl;
    SaveDialog1: TSaveDialog;
    StatusBar1: TStatusBar;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    TabSheet2: TTabSheet;
    TabSheet4: TTabSheet;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Image2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image2MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Image3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image3MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure PageControl1Change(Sender: TObject);
    procedure StringGrid1EditingDone(Sender: TObject);
    procedure ToolButton10Click(Sender: TObject);
    procedure ToolButton11Click(Sender: TObject);
    procedure ToolButton14Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;
var
  Form10: TForm10;
  b: byte;                                                       // general byte
  unsaved: boolean;                                               // data change
  fg, d1, d2, bg: TColor;                              // colors of the displays
  g1xdiv, g1ydiv, g2xdiv, g2ydiv: integer;                       // graph. ?/div
  g1xpix, g1ypix, g2xpix, g2ypix: single;                   // graph. resolution
  grid, header: boolean;                                             //show/hide
  i: byte;                                                    // general integer
  s: string;                                          // general string variable
  t: text;                                         // general text file variable
  tdir,tname,textn: shortstring;
  filename: string;                                              // filename.t2c
const
  PAL: array [1..6,1..4] of string = (
                                ('$000000','$999999','$CCCCCC','$FFFFFF'),
                                ('$75DDFF','$5EB1CC','$468599','$000052'),
                                ('$63FF63','$50CD50','$3C9A3C','$005200'),
                                ('$FF6363','$CD5050','$9A3C3C','$520000'),
                                ('$FFFFFF','$CCCCCC','$999999','$000000'),
                                ('$FFF474','$CCC35D','$999246','$574A03')
                                     );

Resourcestring
  MESSAGE01='Characteristic drawer';
  MESSAGE02='Create new project';
  MESSAGE03='Load project';
  MESSAGE04='Save project';
  MESSAGE05='Save actual diplay to BMP file';
  MESSAGE06='Import actual table from CSV file';
  MESSAGE07='Export actual table to CSV file';
  MESSAGE08='Are you sure? Project is not saved.';
  MESSAGE09='File is exist. Replace?';
  MESSAGE10='Tubes2 characteristic data files (*.t2c)|*.t2c|';
  MESSAGE11='Bitmap files (*.bmp)|*.bmp|';
  MESSAGE12='CSV files (*.csv)|*.csv|';
  MESSAGE13='Cannot write file!';
  MESSAGE14='Cannot read file!';
  {...}
  MESSAGE35='Set aside...';
  MESSAGE36='X: ';
  MESSAGE37='Y: ';
  MESSAGE38='resolution: ';
  MESSAGE39='marker: ';
  MESSAGE40='Bipolar transistor input characteristic';
  MESSAGE41='Bipolar transistor output characteristic';

implementation
uses frmmain;
{$R *.lfm}
{ TForm10 }

procedure writetodisplay;forward;

//-- other procedures #1 -------------------------------------------------------
procedure unsavedsign;
begin
  if unsaved
  then Form10.StatusBar1.Panels.Items[0].Text:='  *'
  else Form10.StatusBar1.Panels.Items[0].Text:='';
end;

// clear display(s)
procedure cleardisplay(m: byte);
var
  rx1, rx2, ry1, ry2: integer;
  i: integer;
begin
  rx1:=8; ry1:=29;
  rx2:=508;ry2:=379;
  if (m=1) or (m=9) then
    with Form10.Image2.Picture.Bitmap do
    begin
      Clear;
      Width:=Form10.Image2.Width;
      Height:=Form10.Image2.Height;
      Canvas.Brush.Color:= bg;
      Canvas.FillRect(0,0,Form10.Image2.Width,Form10.Image2.Height);
      if header=true then
      begin
        Canvas.Font.Size:=8;
        Canvas.Font.Color:=fg;
        Canvas.TextOut(8,2,MESSAGE36);
        Canvas.TextOut(8,14,MESSAGE37);
        Canvas.TextOut(23,2,'Ube');
        Canvas.TextOut(23,14,'Ib');
        Canvas.TextOut(58,2,MESSAGE38+inttostr(g1xdiv)+' mV/div');
        Canvas.TextOut(58,14,MESSAGE38+inttostr(g1ydiv)+' uA/div');
        Canvas.TextOut(200,2, MESSAGE39+'- mV');
        Canvas.TextOut(200,14, MESSAGE39+'- uA');
      end;
      if grid=true then
      begin
        Canvas.Pen.Width:=1;
        // finom
        Canvas.Pen.Color:=d2;
        i:=ry2;
        repeat
          Canvas.Line(rx1,i,rx2,i);
          i:=i-5;
        until i=ry1-5;
        i:=rx1;
        repeat
          Canvas.Line(i,ry1,i,ry2);
          i:=i+5;
        until i=rx2+5;
        // durva
        Canvas.Pen.Color:=d1;
        i:=ry2;
        repeat
          Canvas.Line(rx1,i,rx2,i);
          i:=i-25;
        until i=ry1-25;
        i:=rx1;
        repeat
          Canvas.Line(i,ry1,i,ry2);
          i:=i+25;
        until i=rx2+25;
      end;
    end;
  if (m=2) or (m=9) then
    with Form10.Image3.Picture.Bitmap do
    begin
      Width:=Form10.Image3.Width;
      Height:=Form10.Image3.Height;
      Canvas.Brush.Color:= bg;
      Canvas.FillRect(0, 0, Form10.Image3.Width, Form10.Image3.Height);
      if header=true then
      begin
        Canvas.Font.Size:=8;
        Canvas.Font.Color:=fg;
        Canvas.TextOut(8,2,MESSAGE36);
        Canvas.TextOut(8,14,MESSAGE37);
        Canvas.TextOut(23,2,'Uce');
        Canvas.TextOut(23,14,'Ic');
        Canvas.TextOut(58,2,MESSAGE38+inttostr(g2xdiv)+' mV/div');
        Canvas.TextOut(58,14,MESSAGE38+inttostr(g2ydiv)+' mA/div');
        Canvas.TextOut(216,2, MESSAGE39+': - V');
        Canvas.TextOut(216,14, MESSAGE39+': - mA');
      end;
      if grid=true then
      begin
        Canvas.Pen.Width:=1;
        // finom
        Canvas.Pen.Color:=d2;
        i:=ry2;
        repeat
          Canvas.Line(rx1,i,rx2,i);
          i:=i-5;
        until i=ry1-5;
        i:=rx1;
        repeat
          Canvas.Line(i,ry1,i,ry2);
          i:=i+5;
        until i=rx2+5;
        // durva
        Canvas.Pen.Color:=d1;
        i:=ry2;
        repeat
          Canvas.Line(rx1,i,rx2,i);
          i:=i-25;
        until i=ry1-25;
        i:=rx1;
        repeat
          Canvas.Line(i,ry1,i,ry2);
          i:=i+25;
        until i=rx2+25;
      end;
    end;
end;

// set display colors
procedure setdisplaycolors;
var
 foreground, dark1, dark2, background: string;
 hu,lu,sa: byte;
begin
  foreground:=PAL[frmmain.displaycolors,1];
  background:=PAL[frmmain.displaycolors,4];
  dark1:=PAL[frmmain.displaycolors,2];
  dark2:=PAL[frmmain.displaycolors,3];

  RGBtoHLS(strtoint(hextodez(background[2]+background[3])),
           strtoint(hextodez(background[4]+background[5])),
           strtoint(hextodez(background[6]+background[7])),
           hu,lu,sa);
  bg:= HLStoColor(hu,lu,sa);
  RGBtoHLS(strtoint(hextodez(foreground[2]+foreground[3])),
           strtoint(hextodez(foreground[4]+foreground[5])),
           strtoint(hextodez(foreground[6]+foreground[7])),
           hu,lu,sa);
  fg:= HLStoColor(hu,lu,sa);
  RGBtoHLS(strtoint(hextodez(dark1[2]+dark1[3])),
           strtoint(hextodez(dark1[4]+dark1[5])),
           strtoint(hextodez(dark1[6]+dark1[7])),
           hu,lu,sa);
  d1:= HLStoColor(hu,lu,sa);
  RGBtoHLS(strtoint(hextodez(dark2[2]+dark2[3])),
           strtoint(hextodez(dark2[4]+dark2[5])),
           strtoint(hextodez(dark2[6]+dark2[7])),
           hu,lu,sa);
  d2:= HLStoColor(hu,lu,sa);
  cleardisplay(9);
  writetodisplay;
end;

// write and draw data to displays
procedure writetodisplay;
var
  b: byte;

procedure drawgraph1(xpix,ypix,a1,a2,a3,a4: single);
var
  xx1, yy1, xx2, yy2: longint;
begin
  xx1:=trunc(a1/xpix)+8;
  yy1:=trunc(((a2/ypix)-387)*-1)-8;
  xx2:=trunc(a3/xpix)+8;
  yy2:=trunc(((a4/ypix)-387)*-1)-8;
  Form10.Image2.Canvas.Pen.Color:=fg;
  Form10.Image2.Canvas.Pen.Width:=2;
  Form10.Image2.Canvas.Line(xx1,yy1,xx2,yy2);
end;

procedure drawgraph2(xpix,ypix,a1,a2,a3,a4: single);
var
  xx1, yy1, xx2, yy2: longint;
begin
  xx1:=trunc(a1/xpix)+8;
  yy1:=trunc(((a2/ypix)-387)*-1)-8;
  xx2:=trunc(a3/xpix)+8;
  yy2:=trunc(((a4/ypix)-387)*-1)-8;
  Form10.Image3.Canvas.Pen.Color:=fg;
  Form10.Image3.Canvas.Pen.Width:=2;
  Form10.Image3.Canvas.Line(xx1,yy1,xx2,yy2);
end;

begin
  // 2nd page
  b:=7;
  repeat
//    drawgraph1(g1xpix,g1ypix,strtofloat(mdata[b]),strtofloat(mdata[b+1]),strtofloat(mdata[b+2]),strtofloat(mdata[b+3]));
  b:=b+2
  until b=45;
  // 3rd page
  b:=47;
  repeat
  //  drawgraph2(g2xpix,g2ypix,strtofloat(mdata[b]),strtofloat(mdata[b+1]),strtofloat(mdata[b+2]),strtofloat(mdata[b+3]));
    b:=b+2
  until b=85;
  b:=87;
  repeat
//    drawgraph2(g2xpix,g2ypix,strtofloat(mdata[b]),strtofloat(mdata[b+1]),strtofloat(mdata[b+2]),strtofloat(mdata[b+3]));
    b:=b+2
  until b=125;
  b:=127;
  repeat
  //  drawgraph2(g2xpix,g2ypix,strtofloat(mdata[b]),strtofloat(mdata[b+1]),strtofloat(mdata[b+2]),strtofloat(mdata[b+3]));
    b:=b+2
  until b=165;
  b:=167;
  repeat
//    drawgraph2(g2xpix,g2ypix,strtofloat(mdata[b]),strtofloat(mdata[b+1]),strtofloat(mdata[b+2]),strtofloat(mdata[b+3]));
    b:=b+2
  until b=205;
end;

//-- ToolBar -------------------------------------------------------------------
// new project
procedure TForm10.ToolButton1Click(Sender: TObject);
begin
  if unsaved
  then
    if MessageDlg(MESSAGE08,mtConfirmation, [mbYes, mbNo],0)=mrNo
    then exit;
  StringGrid1.Clean;
  StringGrid2.Clean;
  cleardisplay(9);
  unsaved:=false; unsavedsign;
end;

// open project
procedure TForm10.ToolButton2Click(Sender: TObject);
var
  filename: string;
begin
  if unsaved
  then
    if MessageDlg(MESSAGE08,mtConfirmation, [mbYes, mbNo],0)=mrNo
    then exit;
  OpenDialog1.InitialDir:=userdir;
  OpenDialog1.Title:=MESSAGE03;
  OpenDialog1.Filter:=MESSAGE10;
  OpenDialog1.FilterIndex:=0;
  if OpenDialog1.Execute=false then exit;
  cleardisplay(9);
  unsaved:=false; unsavedsign;
  if PageControl1.ActivePageIndex=0
    then StringGrid1.Clean
    else StringGrid2.Clean;
  filename:=OpenDialog1.Filename;
  try
    // betöltés
  except
    showmessage(MESSAGE14);
  end;
end;

// save project
procedure TForm10.ToolButton3Click(Sender: TObject);
var
  filename: string;
begin
  SaveDialog1.InitialDir:=userdir;
  SaveDialog1.Title:=MESSAGE04;
  SaveDialog1.Filename:='noname.t2c';
  SaveDialog1.Filter:=MESSAGE10;
  SaveDialog1.FilterIndex:=0;
  if SaveDialog1.Execute=false then exit;
  filename:=SaveDialog1.Filename;
  i:=length(filename);
  if filename[i-3]+filename[i-2]+filename[i-1]+filename[i]<>'.t2c' then filename:=filename+'.t2c';
  fsplit(filename,tdir,tname,textn);
  if FSearch(tname+textn,tdir)<>'' then
  if MessageDlg(MESSAGE09,mtConfirmation, [mbYes, mbNo],0)=mrNo then exit;
  if length(filename)=0 then exit;
  try
    // mentés
    unsaved:=false; unsavedsign;
  except
    showmessage(MESSAGE13);
  end;
end;

// save actual image to BMP file
procedure TForm10.ToolButton4Click(Sender: TObject);
var
  filename: string;
begin
  SaveDialog1.InitialDir:=userdir;
  SaveDialog1.Title:=MESSAGE05;
  SaveDialog1.Filename:='noname.bmp';
  SaveDialog1.Filter:=MESSAGE11;
  SaveDialog1.FilterIndex:=0;
  if SaveDialog1.Execute=false then exit;
  filename:=SaveDialog1.Filename;
  i:=length(filename);
  if filename[i-3]+filename[i-2]+filename[i-1]+filename[i]<>'.bmp' then filename:=filename+'.bmp';
  fsplit(filename,tdir,tname,textn);
  if FSearch(tname+textn,tdir)<>'' then
  if MessageDlg(MESSAGE09,mtConfirmation, [mbYes, mbNo],0)=mrNo then exit;
  if length(filename)=0 then exit;
  try
    if PageControl1.ActivePageIndex=0 then Image2.Picture.SaveToFile(filename);
    if PageControl1.ActivePageIndex=1 then Image3.Picture.SaveToFile(filename);
  except
    showmessage(MESSAGE13);
  end;
end;

// import actual table from CSV
procedure TForm10.ToolButton5Click(Sender: TObject);
var
  filename: string;
begin
  if unsaved
  then
    if MessageDlg(MESSAGE08,mtConfirmation, [mbYes, mbNo],0)=mrNo
    then exit;
  OpenDialog1.InitialDir:=userdir;
  OpenDialog1.Title:=MESSAGE07;
  OpenDialog1.Filter:=MESSAGE12;
  OpenDialog1.FilterIndex:=0;
  if OpenDialog1.Execute=false then exit;
  cleardisplay(9);
  unsaved:=false; unsavedsign;
  if PageControl1.ActivePageIndex=0
    then StringGrid1.Clean
    else StringGrid2.Clean;
  filename:=OpenDialog1.Filename;
  try
    if PageControl1.ActivePageIndex=0
      then StringGrid1.LoadFromCSVFile(filename)
      else StringGrid2.LoadFromCSVFile(filename);
  except
    showmessage(MESSAGE14);
  end;
end;

// export actual table to CSV
procedure TForm10.ToolButton14Click(Sender: TObject);
var
  filename: string;
begin
  SaveDialog1.InitialDir:=userdir;
  SaveDialog1.Title:=MESSAGE07;
  SaveDialog1.Filename:='noname.csv';
  SaveDialog1.Filter:=MESSAGE12;
  SaveDialog1.FilterIndex:=0;
  if SaveDialog1.Execute=false then exit;
  filename:=SaveDialog1.Filename;
  i:=length(filename);
  if filename[i-3]+filename[i-2]+filename[i-1]+filename[i]<>'.csv' then filename:=filename+'.csv';
  fsplit(filename,tdir,tname,textn);
  if FSearch(tname+textn,tdir)<>'' then
  if MessageDlg(MESSAGE09,mtConfirmation, [mbYes, mbNo],0)=mrNo then exit;
  if length(filename)=0 then exit;
  try
    if PageControl1.ActivePageIndex=0
      then StringGrid1.SaveToCSVFile(filename)
      else StringGrid2.SaveToCSVFile(filename);
  except
    showmessage(MESSAGE13);
  end;
end;

// grid show/hide
procedure TForm10.ToolButton6Click(Sender: TObject);
begin
  grid:=not grid;
  ToolButton6.Down:=grid;
  cleardisplay(9);
  writetodisplay;
end;

// header show/hide
procedure TForm10.ToolButton7Click(Sender: TObject);
begin
  header:=not header;
  ToolButton7.Down:=header;
  cleardisplay(9);
  writetodisplay;
end;

// clear all display
procedure TForm10.ToolButton11Click(Sender: TObject);
begin
  cleardisplay(9);
end;

// refresh all display;
procedure TForm10.ToolButton10Click(Sender: TObject);
begin
  writetodisplay;
end;

//-- 1st diagram ---------------------------------------------------------------
// cursor
procedure TForm10.Image2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if (x>=8) and (y>=29) and (x<=508) and (y<=379)
  then Image2.Cursor:=1 else Image2.Cursor:=crDefault;
end;

//marker position
procedure TForm10.Image2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  with Image2 do
  begin
    Canvas.Font.Size:=8;
    Canvas.Brush.Color:= bg;
    Canvas.Font.Color:=fg;
    Canvas.FillRect(200,2,Width,28);
    if (x>=8) and (y>=29) and (x<=508) and (y<=379) then
    begin
      if header=true then
      begin
        Canvas.TextOut(200,2, MESSAGE39+floattostr((x-8)*g1xpix)+' mV');
        Canvas.TextOut(200,14, MESSAGE39+floattostr((y-379)*(-1)*g1ypix)+' uA');
      end;
    end else
    begin
     if header=true then
     begin
       Canvas.TextOut(200,2, MESSAGE39+'- mV');
       Canvas.TextOut(200,14, MESSAGE39+'- uA');
     end;
    end;
  end;
end;

//-- 2nd diagram ---------------------------------------------------------------
// cursor
procedure TForm10.Image3MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if (x>=8) and (y>=29) and (x<=508) and (y<=379)
  then Image3.Cursor:=1 else Image3.Cursor:=crDefault;
end;


// marker position
procedure TForm10.Image3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  with Image3 do
  begin
    Canvas.Font.Size:=8;
    Canvas.Brush.Color:= bg;
    Canvas.Font.Color:=fg;
    Canvas.FillRect(200,2,Width,28);
    if (x>=8) and (y>=29) and (x<=508) and (y<=379) then
    begin
      if header=true then
      begin
        Canvas.TextOut(200,2, MESSAGE39+floattostr((x-8)*g1xpix)+' mV');
        Canvas.TextOut(200,14, MESSAGE39+floattostr((y-379)*(-1)*g1ypix)+' uA');
      end;
    end else
    begin
     if header=true then
     begin
       Canvas.TextOut(200,2, MESSAGE39+'- mV');
       Canvas.TextOut(200,14, MESSAGE39+'- uA');
     end;
    end;
  end;
end;

// -- Events -------------------------------------------------------------------

// on change events
procedure TForm10.PageControl1Change(Sender: TObject);
begin
  if PageControl1.ActivePageIndex=0
    then Caption:=MESSAGE01+' - '+TabSheet2.Caption
    else Caption:=MESSAGE01+' - '+TabSheet4.Caption;
end;

procedure TForm10.StringGrid1EditingDone(Sender: TObject);
begin
  unsaved:=true; unsavedsign;
end;

// on close query
procedure TForm10.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  if not unsaved
  then canclose:=true
  else
    if MessageDlg(MESSAGE08,mtConfirmation, [mbYes, mbNo],0)=mrNo
    then canclose:=false
    else canclose:=true;
end;

// on create event
procedure TForm10.FormCreate(Sender: TObject);
begin
  Screen.Cursors[1] := LoadCursorFromLazarusResource('haircross');
  ToolButton1.Hint:=MESSAGE02;
  ToolButton2.Hint:=MESSAGE03;
  ToolButton3.Hint:=MESSAGE04;
  ToolButton4.Hint:=MESSAGE05;
  ToolButton5.Hint:=MESSAGE06;
  ToolButton14.Hint:=MESSAGE07;
  // default resolutions
  g1xdiv:=100;       // x: 100mV/div
  g1ydiv:=50;        // y: 50uA/div
  g1xpix:=g1xdiv/25;
  g1ypix:=g1ydiv/25;
  g2xdiv:=1000;      // x: 1000mV/div
  g2ydiv:=100;       // y: 100mA/div
  g2xpix:=g2xdiv/25;
  g2ypix:=g2ydiv/25;
end;

// on show event
procedure TForm10.FormShow(Sender: TObject);
begin
  ToolButton6.Down:=grid;
  ToolButton7.Down:=header;
  PageControl1Change(Sender);
  StringGrid1.Clean;
  StringGrid2.Clean;
  setdisplaycolors;
  unsaved:=false; unsavedsign;
end;

initialization
  {$I haircross.lrs}
end.


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
  Classes, SysUtils, FileUtil, PrintersDlgs, LResources, Forms,
  Controls, Graphics, Dialogs, Menus, ComCtrls, ExtCtrls, StdCtrls,
  Grids, Buttons, DOM, dos, Printers,  GraphUtil, ExtDlgs, convert, process;
  type
  { TForm10 }
  TForm10 = class(TForm)
    Bevel4: TBevel;
    Bevel5: TBevel;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    Button1: TButton;
    Button10: TButton;
    Image2: TImage;
    Image3: TImage;
    ImageList1: TImageList;
    Memo1: TMemo;
    Memo2: TMemo;
    OpenDialog1: TOpenDialog;
    PageControl1: TPageControl;
    PrintDialog1: TPrintDialog;
    SaveDialog1: TSaveDialog;
    TabSheet2: TTabSheet;
    TabSheet4: TTabSheet;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure Image2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image2MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Image3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image3MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure ToolButton10Click(Sender: TObject);
    procedure ToolButton11Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
  private
    { private declarations }
    procedure DrawGraphic(X,Y,AWidth,AHeight:Integer; Graphic: TGraphic);
    function CM(Avalue: Double; VertRes:boolean=true): Integer;
    function MM(AValue: Double; VertRes:boolean=true): Integer;
    function Inch(AValue: Double; VertRes:boolean=true): Integer;
    function Per(AValue: Double; VertRes:boolean=true): Integer;
    procedure CenterText(const X,Y: Integer; const AText: string);
  public
    { public declarations }
  end;
var
  Form10: TForm10;
  grid, header: boolean;
  i: byte;
  tdir,tname,textn: shortstring;
  b: byte;                                              // general byte variable
  displaycolor: string;                                         // display color
  fg, d1, d2, bg: TColor;                              // colors of the displays
  g1xdiv, g1ydiv, g2xdiv, g2ydiv: integer;                       // graph. ?/div
  g1xpix, g1ypix, g2xpix, g2ypix: single;                   // graph. resolution
  mdata: array[1..206] of string;                               // measured data
  s: string;                                          // general string variable
  t: text;                                         // general text file variable
  viewer: boolean;

Resourcestring
  MESSAGE09='File is exist. Replace?';
  MESSAGE21='Missing files! Please reinstall CTT!';
  MESSAGE23='(description)';
  MESSAGE26='(unknown)';
  MESSAGE28='Save actual diagram in BMP format';
  MESSAGE29='Save actual diagram in TXT format';
  MESSAGE30='Bitmap files (*.bmp)|*.bmp|';
  MESSAGE31='Text files (*.txt)|*.txt|';
  MESSAGE32='Cannot save this file!';
  MESSAGE35='Set aside...';
  MESSAGE36='X: ';
  MESSAGE37='Y: ';
  MESSAGE38='resolution: ';
  MESSAGE39='marker: ';
  MESSAGE40='Bipolar transistor input characteristic';
  MESSAGE41='Bipolar transistor output characteristic';
  MESSAGE42='new diagram';
  MESSAGE43='Print error!';
  MESSAGE44='Print actual diagram';


implementation
uses frmmain;
{$R *.lfm}
{ TForm10 }

procedure writetodisplay;forward;

//-- other procedures #1 -------------------------------------------------------
// clear display(s)
procedure cleardisplay(m: byte);
var
  rx1, rx2, ry1, ry2: integer;
  i: integer;
begin
  rx1:=8; ry1:=29;
  rx2:=508;ry2:=379;
  if m=8 then mdata[6]:='0';
  if m=6 then
    for b:=7 to 46 do mdata[b]:='0';
  if m=7 then
    for b:=47 to 206 do mdata[b]:='0';
  if (m=6) or (m=7) or (m=99) then
  begin
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
end;


// set display colors
procedure setdisplaycolors;
var
 foreground, dark1, dark2, background: string;
 hu,lu,sa: byte;
begin
  foreground:='';
  background:='';
  dark1:='';
  dark2:='';
  {$IFDEF LINUX}
  assignfile(t,'palettes/blue.pal');
  {$ENDIF}
  {$IFDEF WIN32}
  assignfile(t,'palettes\'+displaycolor+'.pal');
  {$ENDIF}
  {$I-}
  reset(t);
  repeat
    readln(t,s);
    s:=lowercase(s);
    if s[1]+s[2]+s[3]='fg=' then for b:=4 to length(s) do foreground:=foreground+s[b];
    if s[1]+s[2]+s[3]='d1=' then for b:=4 to length(s) do dark1:=dark1+s[b];
    if s[1]+s[2]+s[3]='d2=' then for b:=4 to length(s) do dark2:=dark2+s[b];
    if s[1]+s[2]+s[3]='bg=' then for b:=4 to length(s) do background:=background+s[b];
  until(eof(t));
  {$I+}
  if ioresult<>0 then
  begin
    ShowMessage(MESSAGE21);
    foreground:='$ffffff';
    background:='$000000';
    dark1:='$cccccc';
    dark2:='$999999';
  end
  else closefile(t);
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
  cleardisplay(99);
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
    drawgraph1(g1xpix,g1ypix,strtofloat(mdata[b]),strtofloat(mdata[b+1]),strtofloat(mdata[b+2]),strtofloat(mdata[b+3]));
  b:=b+2
  until b=45;
  // 3rd page
  b:=47;
  repeat
    drawgraph2(g2xpix,g2ypix,strtofloat(mdata[b]),strtofloat(mdata[b+1]),strtofloat(mdata[b+2]),strtofloat(mdata[b+3]));
    b:=b+2
  until b=85;
  b:=87;
  repeat
    drawgraph2(g2xpix,g2ypix,strtofloat(mdata[b]),strtofloat(mdata[b+1]),strtofloat(mdata[b+2]),strtofloat(mdata[b+3]));
    b:=b+2
  until b=125;
  b:=127;
  repeat
    drawgraph2(g2xpix,g2ypix,strtofloat(mdata[b]),strtofloat(mdata[b+1]),strtofloat(mdata[b+2]),strtofloat(mdata[b+3]));
    b:=b+2
  until b=165;
  b:=167;
  repeat
    drawgraph2(g2xpix,g2ypix,strtofloat(mdata[b]),strtofloat(mdata[b+1]),strtofloat(mdata[b+2]),strtofloat(mdata[b+3]));
    b:=b+2
  until b=205;
end;

//-- other procedures #2 -------------------------------------------------------
procedure TForm10.DrawGraphic(X, Y, AWidth, Aheight: Integer; Graphic: TGraphic);
var
  Ratio: Double;
begin
  if (AWidth<=0) or (AHeight<=0) then
  begin
    if Graphic.Width=0 then ratio:=1 else ratio:=Graphic.Height/Graphic.Width;
    if AWidth<=0 then AWidth:=round(AHeight/ratio) else
      if AHeight<=0 then AHeight:=round(AWidth * ratio);
  end;
  if (AWidth>0) and (AHeight>0)
  then Printer.Canvas.StretchDraw(Bounds(X,Y,AWidth,AHeight), Graphic);
end;

function TForm10.CM(Avalue: Double; VertRes: boolean=true): Integer;
begin
  result := MM(AValue*10, vertRes);
end;

function TForm10.MM(AValue: Double; VertRes:boolean=true): Integer;
begin
  if VertRes then
    result := Round(AValue*Printer.YDPI/25.4)
  else
    result := Round(AValue*Printer.XDPI/25.4);
end;

function TForm10.Inch(AValue: Double; VertRes:boolean=true): Integer;
begin
  if VertRes then
    result := Round(AValue*Printer.YDPI)
  else
    result := Round(AValue*Printer.XDPI);
end;

function TForm10.Per(AValue: Double; VertRes:boolean=true): Integer;
begin
  if VertRes then
    result := Round(AValue*Printer.PageHeight/100)
  else
    result := Round(AValue*Printer.PageWidth/100);
end;

procedure TForm10.CenterText(const X, Y: Integer; const AText: string);
var
  Sz: TSize;
begin
  Sz := Printer.Canvas.TextExtent(AText);
  Printer.Canvas.TextOut(X - Sz.cx div 2, Y - Sz.cy div 2, AText);
end;

//-- ToolBar -------------------------------------------------------------------
// refresh all display;
procedure TForm10.ToolButton10Click(Sender: TObject);
begin
  writetodisplay;
end;

// clear all display
procedure TForm10.ToolButton11Click(Sender: TObject);
begin
  cleardisplay(99);
end;

// new diagram
procedure TForm10.ToolButton1Click(Sender: TObject);
begin

end;

// open file
procedure TForm10.ToolButton2Click(Sender: TObject);
begin

end;

// save as txt
procedure TForm10.ToolButton3Click(Sender: TObject);
var
  filename: string;
begin
  SaveDialog1.InitialDir:=userdir;
  SaveDialog1.Title:=MESSAGE29;
  SaveDialog1.Filename:=MESSAGE42+'.txt';
  SaveDialog1.Filter:=MESSAGE31;
  SaveDialog1.FilterIndex:=0;
  if SaveDialog1.Execute=false then exit;
  filename:=SaveDialog1.Filename;
  i:=length(filename);
  if filename[i-3]+filename[i-2]+filename[i-1]+filename[i]<>'.txt' then filename:=filename+'.txt';
  fsplit(filename,tdir,tname,textn);
  if FSearch(tname+textn,tdir)<>'' then
  if MessageDlg(MESSAGE09,mtConfirmation, [mbYes, mbNo],0)=mrNo then exit;
  if length(filename)=0 then exit;
  try
    if PageControl1.ActivePageIndex=1 then Memo1.Lines.SaveToFile(filename);
    if PageControl1.ActivePageIndex=2 then Memo2.Lines.SaveToFile(filename);
  except
    showmessage(MESSAGE32);
  end;
end;

// save as bmp
procedure TForm10.ToolButton4Click(Sender: TObject);
var
  filename: string;
begin
  SaveDialog1.InitialDir:=userdir;
  SaveDialog1.Title:=MESSAGE28;
  SaveDialog1.Filename:=MESSAGE42+'.bmp';
  SaveDialog1.Filter:=MESSAGE30;
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
    if PageControl1.ActivePageIndex=1 then Image2.Picture.SaveToFile(filename);
    if PageControl1.ActivePageIndex=2 then Image3.Picture.SaveToFile(filename);
  except
    showmessage(MESSAGE32);
  end;
end;

// print diagram
procedure TForm10.ToolButton5Click(Sender: TObject);
var
  Pic: TPicture;
  x1, x2, y1, y2: integer;
  rx1, rx2, ry1, ry2: integer;
  i: integer;

procedure printgraph(xpix,ypix,a1,a2,a3,a4: single);
var
  xx1, yy1, xx2, yy2: longint;
begin
  xx1:=trunc(a1/xpix)+8;
  yy1:=trunc(((a2/ypix)-387)*-1)-8;
  xx2:=trunc(a3/xpix)+8;
  yy2:=trunc(((a4/ypix)-387)*-1)-8;
  Pic.Bitmap.Canvas.Pen.Color:=clBlack;
  Pic.Bitmap.Canvas.Pen.Width:=2;
  Pic.Bitmap.Canvas.Line(xx1,yy1,xx2,yy2);
end;

begin
  rx1:=8; ry1:=29;
  rx2:=508;ry2:=379;
  Printer.Orientation:=poLandscape;
  x1:=cm(1);
  x2:=Printer.PageWidth-mm(5);
  y1:=cm(2);
  y2:=Printer.PageHeight-cm(1);
  PrintDialog1.Title:=MESSAGE44;
  if PrintDialog1.Execute then
  try
    Printer.Title:=MESSAGE44;
    Printer.BeginDoc;
    Printer.Canvas.Font.Color:=clBlack;
    Printer.Canvas.Font.Size:=12;
    Printer.Canvas.Font.Bold:=true;
    Printer.Canvas.Pen.Color:=clBlack;
    Printer.canvas.Pen.Width:=1;
    if PageControl1.ActivePageIndex=1 then
    begin
//      CenterText(Printer.PageWidth div 2, y1,MESSAGE40+' ('+Edit2.Text+')');
      Pic:=TPicture.Create;
      Pic.Bitmap.Height:=Image2.Picture.Bitmap.Height;
      Pic.Bitmap.Width:=Image2.Picture.Width;
      Pic.Bitmap.Canvas.Pen.Color:=clBlack;
      Pic.Bitmap.Canvas.Pen.Width:=1;
      Pic.Bitmap.Canvas.Rectangle(1,1,Pic.Bitmap.Width,Pic.Bitmap.Height);
      // grid / text
      with Pic.Bitmap do
      begin
        if header=true then
        begin
          Canvas.Font.Size:=8;
          Canvas.Font.Color:=clBlack;
          Canvas.TextOut(8,2,MESSAGE36);
          Canvas.TextOut(8,14,MESSAGE37);
          Canvas.TextOut(23,2,'Ube');
          Canvas.TextOut(23,14,'Ib');
          Canvas.TextOut(58,2,MESSAGE38+inttostr(g1xdiv)+' mV/div');
          Canvas.TextOut(58,14,MESSAGE38+inttostr(g1ydiv)+' uA/div');
        end;
        if grid=true then
        begin
          Canvas.Pen.Color:=clGray;
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
          Canvas.Pen.Color:=clBlack;
          Canvas.Pen.Width:=1;
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
          b:=7;
          repeat
            printgraph(g1xpix,g1ypix,strtofloat(mdata[b]),strtofloat(mdata[b+1]),strtofloat(mdata[b+2]),strtofloat(mdata[b+3]));
            b:=b+2
          until b=45;
        end;
        DrawGraphic(x1+mm(35), y1+cm(1), mm(205), 0, Pic.Graphic);
        Pic.Free;
      end;
      if PageControl1.ActivePageIndex=2 then
      begin
//        CenterText(Printer.PageWidth div 2, y1,MESSAGE41+' ('+Edit2.Text+')');
        Pic:=TPicture.Create;
        Pic.Bitmap.Height:=Image3.Picture.Bitmap.Height;
        Pic.Bitmap.Width:=Image3.Picture.Width;
        Pic.Bitmap.Canvas.Pen.Color:=clBlack;
        Pic.Bitmap.Canvas.Pen.Width:=1;
        Pic.Bitmap.Canvas.Rectangle(1,1,Pic.Bitmap.Width,Pic.Bitmap.Height);
        // grid / text
        with Pic.Bitmap do
        begin
          if header=true then
          begin
            Canvas.Font.Size:=8;
            Canvas.Font.Color:=clBlack;
            Canvas.TextOut(8,2,MESSAGE36);
            Canvas.TextOut(8,14,MESSAGE37);
            Canvas.TextOut(23,2,'Ube');
            Canvas.TextOut(23,14,'Ib');
            Canvas.TextOut(58,2,MESSAGE38+inttostr(g2xdiv)+' mV/div');
            Canvas.TextOut(58,14,MESSAGE38+inttostr(g2ydiv)+' uA/div');
          end;
          if grid=true then
          begin
            Canvas.Pen.Color:=clGray;
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
            Canvas.Pen.Color:=clBlack;
            Canvas.Pen.Width:=1;
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
        b:=47;
        repeat
          printgraph(g2xpix,g2ypix,strtofloat(mdata[b]),strtofloat(mdata[b+1]),strtofloat(mdata[b+2]),strtofloat(mdata[b+3]));
          b:=b+2;
        until b=85;
        b:=87;
        repeat
         printgraph(g2xpix,g2ypix,strtofloat(mdata[b]),strtofloat(mdata[b+1]),strtofloat(mdata[b+2]),strtofloat(mdata[b+3]));
          b:=b+2;
        until b=125;
        b:=127;
        repeat
          printgraph(g2xpix,g2ypix,strtofloat(mdata[b]),strtofloat(mdata[b+1]),strtofloat(mdata[b+2]),strtofloat(mdata[b+3]));
          b:=b+2;
        until b=165;
        b:=167;
        repeat
          printgraph(g2xpix,g2ypix,strtofloat(mdata[b]),strtofloat(mdata[b+1]),strtofloat(mdata[b+2]),strtofloat(mdata[b+3]));
          b:=b+2;
        until b=205;
      end;
      DrawGraphic(x1+mm(35), y1+cm(1), mm(205), 0, Pic.Graphic);
      Pic.Free;
    end;
    Printer.Canvas.Pen.Color:=clBlack;
    Printer.canvas.Pen.Width:=2;
    Printer.Canvas.Line(x1, y2-38,x2,y2-38);
    Printer.Canvas.Font.Size:=10;
    Printer.Canvas.TextOut(x1,y2-25,UpperCase(APPNAME)+' v'+VERSION+' (C)2010-2012 Pozsár Zsolt <http://www.pozsarzs.hu>');
    Printer.EndDoc;
  except
    Printer.Abort;
    MessageDlg(MESSAGE43,mtError,[mbOk],0);
  end;
end;

// grid show/hide
procedure TForm10.ToolButton6Click(Sender: TObject);
begin
  grid:=not grid;
  ToolButton6.Down:=grid;
  cleardisplay(99);
  writetodisplay;
end;

// header show/hide
procedure TForm10.ToolButton7Click(Sender: TObject);
begin
  header:=not header;
  ToolButton7.Down:=header;
  cleardisplay(99);
  writetodisplay;
end;

//-- Buttons -------------------------------------------------------------------
// clear 1st display
procedure TForm10.BitBtn6Click(Sender: TObject);
begin
  cleardisplay(6);
  Memo1.Clear;
end;

// clear 2nd display
procedure TForm10.BitBtn7Click(Sender: TObject);
begin
  cleardisplay(7);
  Memo2.Clear;
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
// on close query
procedure TForm10.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  canclose:=true;
end;

// on create event
procedure TForm10.FormCreate(Sender: TObject);
begin
  grid:=true; header:=true;
  for b:=1 to 206 do mdata[b]:='0';
  // default
  g1xdiv:=100;       // x: 100mV/div
  g1ydiv:=50;        // y: 50uA/div
  g1xpix:=g1xdiv/25;
  g1ypix:=g1ydiv/25;
  g2xdiv:=1000;      // x: 1000mV/div
  g2ydiv:=100;       // y: 100mA/div
  g2xpix:=g2xdiv/25;
  g2ypix:=g2ydiv/25;
 setdisplaycolors;
  Screen.Cursors[1] := LoadCursorFromLazarusResource('haircross');
end;

initialization
  {$I haircross.lrs}
end.


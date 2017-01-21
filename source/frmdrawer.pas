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
  Buttons,
  Classes,
  ComCtrls,
  Controls,
  Dialogs,
  DOM,
  ExtCtrls,
  ExtDlgs,
  FileUtil,
  Forms,
  Graphics,
  GraphUtil,
  Grids,
  LResources,
  Menus,
  StdCtrls,
  SysUtils,
  {$IFDEF UNIX} Types, {$ENDIF}
  {$IFDEF WIN32} Windows, {$ENDIF}
  convert,
  dos;
type
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
    StringGrid3: TStringGrid;
    TabSheet2: TTabSheet;
    TabSheet4: TTabSheet;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
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
    procedure ComboBox1Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
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
    procedure StringGrid1Selection(Sender: TObject; aCol, aRow: Integer);
    procedure StringGrid1SetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
    procedure StringGrid2Selection(Sender: TObject; aCol, aRow: Integer);
    procedure StringGrid2SetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
    procedure ToolButton11Click(Sender: TObject);
    procedure ToolButton13Click(Sender: TObject);
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
  t2crec=record
    id: string[3];
    title: string[255];
    g1x: array[1..255] of single;
    g1y: array[1..255] of single;
    g1z: array[1..255] of byte;
    g2x: array[1..255] of single;
    g2y: array[1..255] of single;
    g2z: array[1..255] of byte;
  end;
var
  Form10: TForm10;
  b: byte;
  datafile: file of t2crec;                                          // t2c file
  fg, d1, d2, bg: TColor;                              // colors of the displays
  g1xdiv, g1ydiv, g2xdiv, g2ydiv: single;                        // graph. ?/div
  g1xpix, g1ypix, g2xpix, g2ypix: single;                   // graph. resolution
  grid, header: boolean;                                             //show/hide
  i: byte;
  initialvalue: string;                // value for detect change in stringgrids
  s: string;
  t: text;
  t2c: t2crec;                                                     // t2c record
  tdir,tname,textn: shortstring;
  unsaved: boolean;                                               // data change
const
  NNF: string='noname.t2c';                         // default project file name
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
  MESSAGE15='Subject or note';
  MESSAGE16='Resolution of Ug/Ia diagram''s X axis';
  MESSAGE17='Resolution of Ug/Ia diagram''s Y axis';
  MESSAGE18='Resolution of Ua/Ia diagram''s X axis';
  MESSAGE19='Resolution of Ua/Ia diagram''s Y axis';
  MESSAGE20='X: -Ug1 ';
  MESSAGE21='Y: Ia';
  MESSAGE22='X: Ua';
  MESSAGE23='Y: Ia';
  MESSAGE24='resolution: ';
  MESSAGE25='marker: ';
  MESSAGE26='Show/hide grid';
  MESSAGE27='Show/hide header';
  MESSAGE28='Clear all displays';
  MESSAGE29='Correct value is -9999..9999';
  MESSAGE30='Start drawing';
  MESSAGE31='This is not number!';
  MESSAGE32='Correct value is 1..16!';
  MESSAGE33='-Ug1 [V]';
  MESSAGE34='Ua [V]';
  MESSAGE35='Ia [mA]';

implementation
uses
  frmmain;

{$R *.lfm}
{ TForm10 }

procedure writetodisplay;forward;

//-- other procedures #1 -------------------------------------------------------
function checkvalues(ac: integer; v: string): boolean;           // check values
var
  sl: single;
begin
  checkvalues:=true;
  if v<>'' then
  begin
    try
      sl:=strtofloat(v);
    except
      showmessage(MESSAGE31);
      checkvalues:=false;
      exit;
    end;
    if (ac=2) and ((sl<1) or (sl>16)) then
    begin
      showmessage(MESSAGE32);
      checkvalues:=false;
    end;
    if ((ac=0) or (ac=1)) and ((sl<-9999) or (sl>9999)) then
    begin
      showmessage(MESSAGE29);
      checkvalues:=false;
    end;
  end;
end;

procedure unsavedsign;                    // show/hide unsaved sign in statusbar
begin
  if unsaved
  then Form10.StatusBar1.Panels.Items[0].Text:='  *'
  else Form10.StatusBar1.Panels.Items[0].Text:='';
end;

procedure cleardisplay(m: byte);                             // clear display(s)
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
        Canvas.TextOut(8,2,MESSAGE20);
        Canvas.TextOut(8,14,MESSAGE21);
        Canvas.TextOut(68,2,MESSAGE24+
          floattostrf(g1xdiv,ffFixed,20,2)+' V/div');
        Canvas.TextOut(68,14,MESSAGE24+
          floattostrf(g1ydiv,ffFixed,20,2)+' mA/div');
        Canvas.TextOut(236,2, MESSAGE25+'- V');
        Canvas.TextOut(236,14, MESSAGE25+'- mA');
      end;
      if grid=true then
      begin
        Canvas.Pen.Width:=1;
        // thin
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
        // thick
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
        Canvas.TextOut(8,2,MESSAGE22);
        Canvas.TextOut(8,14,MESSAGE23);
        Canvas.TextOut(68,2,MESSAGE24+
          floattostrf(g2xdiv,ffFixed,20,2)+' V/div');
        Canvas.TextOut(68,14,MESSAGE24+
          floattostrf(g2ydiv,ffFixed,20,2)+' mA/div');
        Canvas.TextOut(236,2, MESSAGE25+'- V');
        Canvas.TextOut(236,14, MESSAGE25+'- mA');
      end;
      if grid=true then
      begin
        Canvas.Pen.Width:=1;
        // thin
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
        // thick
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

procedure setdisplaycolors;                                // set display colors
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

procedure writetodisplay;                     // write and draw data to displays
var
  line: byte;
  p1, p2, p3, p4: single;
  count: byte;
  line3: byte;

procedure drawgraph1(xpix,ypix,a1,a2,a3,a4: single);
var
  xx1, yy1, xx2, yy2: longint;
begin
  xx1:=508-trunc(a1/xpix);
  yy1:=trunc(((a2/ypix)-387)*-1)-8;
  xx2:=508-trunc(a3/xpix);
  yy2:=trunc(((a4/ypix)-387)*-1)-8;
  Form10.Image2.Canvas.Pen.Color:=fg;
  Form10.Image2.Canvas.Pen.Width:=2;
  if yy1<30 then yy1:=30;
  if yy2<30 then yy2:=30;
  if xx1>508 then xx1:=508;
  if xx2>508 then xx2:=508;
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
  if yy1<30 then yy1:=30;
  if yy2<30 then yy2:=30;
  if xx1>508 then xx1:=508;
  if xx2>508 then xx2:=508;
  Form10.Image3.Canvas.Line(xx1,yy1,xx2,yy2);
end;

begin
  // diagram #1
  for count:=1 to 16 do
  begin
    line3:=1;
    Form10.StringGrid3.Clear;
    Form10.StringGrid3.RowCount:=256;
    for line:=1 to 254 do
      if Form10.StringGrid1.Cells[2,line]<>'' then
        if Form10.StringGrid1.Cells[2,line]=inttostr(count) then
        begin
          Form10.StringGrid3.Cells[0,line3]:=Form10.StringGrid1.Cells[0,line];
          Form10.StringGrid3.Cells[1,line3]:=Form10.StringGrid1.Cells[1,line];
          line3:=line3+1;
        end;
    for line:=1 to 254 do
    begin
      if not ((Form10.StringGrid3.Cells[0,line]='') or
              (Form10.StringGrid3.Cells[1,line]='') or
              (Form10.StringGrid3.Cells[0,line+1]='') or
              (Form10.StringGrid3.Cells[1,line+1]='')) then
      begin
        p1:=strtofloat(Form10.StringGrid3.Cells[0,line]);
        p2:=strtofloat(Form10.StringGrid3.Cells[1,line]);
        p3:=strtofloat(Form10.StringGrid3.Cells[0,line+1]);
        p4:=strtofloat(Form10.StringGrid3.Cells[1,line+1]);
        drawgraph1(g1xpix,g1ypix,p1,p2,p3,p4);
      end;
    end;
  end;
  // diagram #2
  for count:=1 to 16 do
  begin
    line3:=1;
    Form10.StringGrid3.Clear;
    Form10.StringGrid3.RowCount:=256;
    for line:=1 to 254 do
      if Form10.StringGrid2.Cells[2,line]<>'' then
        if Form10.StringGrid2.Cells[2,line]=inttostr(count) then
        begin
          Form10.StringGrid3.Cells[0,line3]:=Form10.StringGrid2.Cells[0,line];
          Form10.StringGrid3.Cells[1,line3]:=Form10.StringGrid2.Cells[1,line];
          line3:=line3+1;
        end;
    for line:=1 to 254 do
    begin
      if not ((Form10.StringGrid3.Cells[0,line]='') or
              (Form10.StringGrid3.Cells[1,line]='') or
              (Form10.StringGrid3.Cells[0,line+1]='') or
              (Form10.StringGrid3.Cells[1,line+1]='')) then
      begin
        p1:=strtofloat(Form10.StringGrid3.Cells[0,line]);
        p2:=strtofloat(Form10.StringGrid3.Cells[1,line]);
        p3:=strtofloat(Form10.StringGrid3.Cells[0,line+1]);
        p4:=strtofloat(Form10.StringGrid3.Cells[1,line+1]);
        drawgraph2(g2xpix,g2ypix,p1,p2,p3,p4);
      end;
    end;
  end;
end;

//-- ToolBar -------------------------------------------------------------------
procedure TForm10.ToolButton1Click(Sender: TObject);              // new project
begin
  if unsaved
  then
    if MessageDlg(MESSAGE08,mtConfirmation, [mbYes, mbNo],0)=mrNo
    then exit;
  Edit1.Clear;
  StringGrid1.Clean;
  StringGrid1.RowCount:=256;
  StringGrid2.Clean;
  StringGrid2.RowCount:=256;
  cleardisplay(9);
  StatusBar1.Panels.Items[1].Text:=' '+NNF;
  unsaved:=false; unsavedsign;
end;

procedure TForm10.ToolButton2Click(Sender: TObject);             // open project
var
  filename: string;
  line: byte;
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
  Edit1.Clear;
  StringGrid1.Clean;
  StringGrid1.RowCount:=256;
  StringGrid2.Clean;
  StringGrid2.RowCount:=256;
  filename:=OpenDialog1.Filename;
  try
    assignfile(datafile,filename);
    reset(datafile);
    read(datafile,t2c);
    closefile(datafile);
    with t2c do
    begin
      Edit1.Text:=title;
      for line:=1 to 255 do
      begin
        if g1x[line]=999999
          then StringGrid1.Cells[0,line]:=''
          else StringGrid1.Cells[0,line]:=floattostrf(g1x[line],ffFixed,20,2);
        if g1y[line]=999999
          then StringGrid1.Cells[1,line]:=''
          else StringGrid1.Cells[1,line]:=floattostrf(g1y[line],ffFixed,20,2);
        if g1z[line]=99
          then StringGrid1.Cells[2,line]:=''
          else StringGrid1.Cells[2,line]:=floattostrf(g1z[line],ffFixed,20,0);

        if g2x[line]=999999
          then StringGrid2.Cells[0,line]:=''
          else StringGrid2.Cells[0,line]:=floattostrf(g2x[line],ffFixed,20,2);
        if g2y[line]=999999
          then StringGrid2.Cells[1,line]:=''
          else StringGrid2.Cells[1,line]:=floattostrf(g2y[line],ffFixed,20,2);
        if g2z[line]=99
          then StringGrid2.Cells[2,line]:=''
          else StringGrid2.Cells[2,line]:=floattostrf(g2z[line],ffFixed,20,0);
      end;
    end;
  except
    showmessage(MESSAGE14);
    StatusBar1.Panels.Items[1].Text:=' '+NNF;
  end;
  StatusBar1.Panels.Items[1].Text:=' '+filename;
  unsaved:=false; unsavedsign;
end;

procedure TForm10.ToolButton3Click(Sender: TObject);             // save project
var
  filename: string;
  line: byte;
begin
  SaveDialog1.InitialDir:=userdir;
  SaveDialog1.Title:=MESSAGE04;
  SaveDialog1.Filename:=StatusBar1.Panels.Items[1].Text;
  SaveDialog1.Filter:=MESSAGE10;
  SaveDialog1.FilterIndex:=0;
  if SaveDialog1.Execute=false then exit;
  filename:=SaveDialog1.Filename;
  i:=length(filename);
  if filename[i-3]+filename[i-2]+filename[i-1]+filename[i]<>'.t2c'
    then filename:=filename+'.t2c';
  fsplit(filename,tdir,tname,textn);
  if FSearch(tname+textn,tdir)<>'' then
  if MessageDlg(MESSAGE09,mtConfirmation, [mbYes, mbNo],0)=mrNo then exit;
  if length(filename)=0 then exit;
  with t2c do
  begin
   id:='T2C';
   title:=Edit1.Text;
   for line:=1 to 255 do
   begin
     if StringGrid1.Cells[0,line]=''
       then g1x[line]:=999999
       else g1x[line]:=strtofloat(StringGrid1.Cells[0,line]);
     if StringGrid1.Cells[1,line]=''
       then g1y[line]:=999999
       else g1y[line]:=strtofloat(StringGrid1.Cells[1,line]);
     if StringGrid1.Cells[2,line]=''
       then g1z[line]:=99
       else g1z[line]:=strtoint(StringGrid1.Cells[2,line]);

     if StringGrid2.Cells[0,line]=''
       then g2x[line]:=999999
       else g2x[line]:=strtofloat(StringGrid2.Cells[0,line]);
     if StringGrid2.Cells[1,line]=''
       then g2y[line]:=999999
       else g2y[line]:=strtofloat(StringGrid2.Cells[1,line]);
     if StringGrid2.Cells[2,line]=''
       then g2z[line]:=99
       else g2z[line]:=strtoint(StringGrid2.Cells[2,line]);
    end;
  end;
  try
    assignfile(datafile,filename);
    rewrite(datafile);
    write(datafile,t2c);
    closefile(datafile);
    unsaved:=false; unsavedsign;
  except
    showmessage(MESSAGE13);
  end;
end;

procedure TForm10.ToolButton4Click(Sender: TObject);      // save display to BMP
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

procedure TForm10.ToolButton5Click(Sender: TObject);    // import table from CSV
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

procedure TForm10.ToolButton14Click(Sender: TObject);     // export table to CSV
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
  if filename[i-3]+filename[i-2]+filename[i-1]+filename[i]<>'.csv'
    then filename:=filename+'.csv';
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

procedure TForm10.ToolButton6Click(Sender: TObject);           // grid show/hide
begin
  grid:=not grid;
  ToolButton6.Down:=grid;
  cleardisplay(9);
  writetodisplay;
end;

procedure TForm10.ToolButton7Click(Sender: TObject);         // header show/hide
begin
  header:=not header;
  ToolButton7.Down:=header;
  cleardisplay(9);
  writetodisplay;
end;

procedure TForm10.ToolButton11Click(Sender: TObject);       // clear all display
begin
  cleardisplay(9);
end;

procedure TForm10.ToolButton13Click(Sender: TObject);           // start drawing
begin
  cleardisplay(9);
  writetodisplay;
end;

//-- 1st diagram ---------------------------------------------------------------
procedure TForm10.Image2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);                                                         // cursor
begin
  if (x>=8) and (y>=29) and (x<=508) and (y<=379)
  then Image2.Cursor:=1 else Image2.Cursor:=crDefault;
end;

procedure TForm10.Image2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);                         // marker position
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
//        Canvas.TextOut(200,2, MESSAGE25+'-'+floattostr((x-8)*g1xpix)+' V');
        Canvas.TextOut(236,14, MESSAGE25+
          floattostrf((y-379)*(-1)*g1ypix,ffFixed,20,2)+' mA');
        Canvas.TextOut(236,2, MESSAGE25+'-'+
          floattostrf((508-x)*g1xpix,ffFixed,20,2)+' V');
      end;
    end else
    begin
     if header=true then
     begin
       Canvas.TextOut(236,2, MESSAGE25+'- V');
       Canvas.TextOut(236,14, MESSAGE25+'- mA');
     end;
    end;
  end;
end;

//-- 2nd diagram ---------------------------------------------------------------
procedure TForm10.Image3MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);                                                         // cursor
begin
  if (x>=8) and (y>=29) and (x<=508) and (y<=379)
  then Image3.Cursor:=1 else Image3.Cursor:=crDefault;
end;

procedure TForm10.Image3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);                         // marker position
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
        Canvas.TextOut(236,2, MESSAGE25+
          floattostrf((x-8)*g2xpix,ffFixed,20,2)+' V');
        Canvas.TextOut(236,14, MESSAGE25+
          floattostrf((y-379)*(-1)*g2ypix,ffFixed,20,2)+' mA');
      end;
    end else
    begin
     if header=true then
     begin
       Canvas.TextOut(236,2, MESSAGE25+'- V');
       Canvas.TextOut(236,14, MESSAGE25+'- mA');
     end;
    end;
  end;
end;

// -- OnChange events ----------------------------------------------------------
procedure TForm10.PageControl1Change(Sender: TObject);
begin
  if PageControl1.ActivePageIndex=0
    then Caption:=MESSAGE01+' - '+TabSheet2.Caption
    else Caption:=MESSAGE01+' - '+TabSheet4.Caption;
  cleardisplay(9);
  writetodisplay;
end;

procedure TForm10.ComboBox1Change(Sender: TObject);
begin
  case ComboBox1.ItemIndex of
    0: g1xdiv:=0.5;
    1: g1xdiv:=1;
    2: g1xdiv:=1.5;
    3: g1xdiv:=2;
    4: g1xdiv:=2.5;
  end;
  case ComboBox2.ItemIndex of
    0: g1ydiv:=0.1;
    1: g1ydiv:=0.5;
    2: g1ydiv:=1;
    3: g1ydiv:=5;
    4: g1ydiv:=10;
    5: g1ydiv:=50;
    6: g1ydiv:=100;
  end;
  case ComboBox3.ItemIndex of
    0: g2xdiv:=5;
    1: g2xdiv:=10;
    2: g2xdiv:=15;
    3: g2xdiv:=20;
    4: g2xdiv:=25;
  end;
  case ComboBox4.ItemIndex of
    0: g2ydiv:=0.1;
    1: g2ydiv:=0.5;
    2: g2ydiv:=1;
    3: g2ydiv:=5;
    4: g2ydiv:=10;
    5: g2ydiv:=50;
    6: g2ydiv:=100;
  end;
  g1xpix:=g1xdiv/25;
  g1ypix:=g1ydiv/25;
  g2xpix:=g2xdiv/25;
  g2ypix:=g2ydiv/25;
  cleardisplay(9);
  writetodisplay;
end;

// check changes in stringgrids and edit
procedure TForm10.Edit1Change(Sender: TObject);
begin
  unsaved:=true;
  unsavedsign;
end;

procedure TForm10.StringGrid1Selection(Sender: TObject; aCol, aRow: Integer);
begin
  initialvalue:=StringGrid1.Cells[aCol,aRow];
end;

procedure TForm10.StringGrid1SetEditText(Sender: TObject; ACol, ARow: Integer;
  const Value: string);
begin
  if value<>initialvalue then unsaved:=true;
  unsavedsign;
  if not checkvalues(aCol,value) then StringGrid1.Cells[aCol,aRow]:='';
end;

procedure TForm10.StringGrid2Selection(Sender: TObject; aCol, aRow: Integer);
begin
  initialvalue:=StringGrid2.Cells[aCol,aRow];
end;

procedure TForm10.StringGrid2SetEditText(Sender: TObject; ACol, ARow: Integer;
  const Value: string);
begin
  if value<>initialvalue then unsaved:=true;
  unsavedsign;
  if not checkvalues(aCol,value) then StringGrid2.Cells[aCol,aRow]:='';
end;

// -- Other events -------------------------------------------------------------
procedure TForm10.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  if not unsaved
  then canclose:=true
  else
    if MessageDlg(MESSAGE08,mtConfirmation, [mbYes, mbNo],0)=mrNo
    then canclose:=false
    else canclose:=true;
end;

procedure TForm10.FormCreate(Sender: TObject);
begin
  Screen.Cursors[1] := LoadCursorFromLazarusResource('haircross');
  ComboBox1.Hint:=MESSAGE16;
  ComboBox2.Hint:=MESSAGE17;
  ComboBox3.Hint:=MESSAGE18;
  ComboBox4.Hint:=MESSAGE19;
  Edit1.Hint:=MESSAGE15;
  ToolButton1.Hint:=MESSAGE02;
  ToolButton11.Hint:=MESSAGE28;
  ToolButton13.Hint:=MESSAGE30;
  ToolButton14.Hint:=MESSAGE07;
  ToolButton2.Hint:=MESSAGE03;
  ToolButton3.Hint:=MESSAGE04;
  ToolButton4.Hint:=MESSAGE05;
  ToolButton5.Hint:=MESSAGE06;
  ToolButton6.Hint:=MESSAGE26;
  ToolButton7.Hint:=MESSAGE27;
  StringGrid1.Columns[0].Title.Caption:=MESSAGE33;
  StringGrid2.Columns[0].Title.Caption:=MESSAGE34;
  StringGrid1.Columns[1].Title.Caption:=MESSAGE35;
  StringGrid2.Columns[1].Title.Caption:=MESSAGE35;
  StringGrid1.Columns[2].Title.Caption:='#';
  StringGrid2.Columns[2].Title.Caption:='#';
  ComboBox1Change(Sender);
end;

procedure TForm10.FormShow(Sender: TObject);
begin
  ToolButton6.Down:=grid;
  ToolButton7.Down:=header;
  PageControl1Change(Sender);
  Edit1.Clear;
  StringGrid1.Clean;
  StringGrid1.RowCount:=256;
  StringGrid2.Clean;
  StringGrid2.RowCount:=256;
  setdisplaycolors;
  StatusBar1.Panels.Items[1].Text:=' '+NNF;
  unsaved:=false; unsavedsign;
end;

initialization
  {$I haircross.lrs}
end.


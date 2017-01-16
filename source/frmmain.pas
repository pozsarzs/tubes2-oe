{ +--------------------------------------------------------------------------+ }
{ | Tubes2 Open edition 2.2 * Electrontube catalogue                         | }
{ | Copyright (C) 2008-2017 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | frmmain.pas                                                              | }
{ | Main window                                                              | }
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

unit frmmain;
{$MODE OBJFPC}{$H+}
interface
uses
  {$IFDEF WIN32}Windows,{$ENDIF}
  Buttons, Classes, ComCtrls, Controls, Dialogs, ExtCtrls, Forms, Graphics,
  Grids, HelpIntfs, IniFiles, LazHelpHTML, LCLIntF, LResources, Menus,
  PairSplitter, Process, StdCtrls, SysUtils, Types,
  dos, gettext, httpsend,
  frmabout, frmconfig, frmdrawer, frmparsearch, frmprogressbar, frmsort,
  frmsubst, frmtextview, frmupgrade, untstrconv;
type
  { TForm1 }
  TForm1 = class(TForm)
    Bevel1: TBevel;
    Bevel3: TBevel;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    HTMLBrowserHelpViewer1: THTMLBrowserHelpViewer;
    HTMLHelpDatabase1: THTMLHelpDatabase;
    Image1: TImage;
    ImageList1: TImageList;
    ListBox1: TListBox;
    MainMenu1: TMainMenu;
    Memo1: TMemo;
    Memo2: TMemo;
    Memo3: TMemo;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem19: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem20: TMenuItem;
    MenuItem21: TMenuItem;
    MenuItem22: TMenuItem;
    MenuItem23: TMenuItem;
    MenuItem24: TMenuItem;
    MenuItem25: TMenuItem;
    MenuItem26: TMenuItem;
    MenuItem27: TMenuItem;
    MenuItem28: TMenuItem;
    MenuItem29: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem30: TMenuItem;
    MenuItem31: TMenuItem;
    MenuItem32: TMenuItem;
    MenuItem33: TMenuItem;
    MenuItem34: TMenuItem;
    MenuItem35: TMenuItem;
    MenuItem36: TMenuItem;
    MenuItem37: TMenuItem;
    MenuItem38: TMenuItem;
    MenuItem39: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem40: TMenuItem;
    MenuItem41: TMenuItem;
    MenuItem42: TMenuItem;
    MenuItem44: TMenuItem;
    MenuItem45: TMenuItem;
    MenuItem46: TMenuItem;
    MenuItem47: TMenuItem;
    MenuItem48: TMenuItem;
    MenuItem49: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem50: TMenuItem;
    MenuItem51: TMenuItem;
    MenuItem52: TMenuItem;
    MenuItem57: TMenuItem;
    MenuItem58: TMenuItem;
    MenuItem59: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem60: TMenuItem;
    MenuItem61: TMenuItem;
    MenuItem62: TMenuItem;
    MenuItem63: TMenuItem;
    MenuItem64: TMenuItem;
    MenuItem65: TMenuItem;
    MenuItem66: TMenuItem;
    MenuItem67: TMenuItem;
    MenuItem68: TMenuItem;
    MenuItem69: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem70: TMenuItem;
    MenuItem71: TMenuItem;
    MenuItem72: TMenuItem;
    MenuItem73: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    PageControl1: TPageControl;
    PairSplitter1: TPairSplitter;
    PairSplitterSide1: TPairSplitterSide;
    PairSplitterSide2: TPairSplitterSide;
    PopupMenu1: TPopupMenu;
    PopupMenu2: TPopupMenu;
    PopupMenu3: TPopupMenu;
    PopupMenu4: TPopupMenu;
    Process1: TProcess;
    Process2: TProcess;
    Process3: TProcess;
    SaveDialog1: TSaveDialog;
    SpeedButton1: TSpeedButton;
    StatusBar1: TStatusBar;
    StringGrid1: TStringGrid;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet4: TTabSheet;
    Timer1: TTimer;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    ToolButton17: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    procedure ComboBox1Change;
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormResize(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Memo3ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure MenuItem13Click(Sender: TObject);
    procedure MenuItem31Click(Sender: TObject);
    procedure MenuItem35Click(Sender: TObject);
    procedure MenuItem38Click(Sender: TObject);
    procedure MenuItem39Click(Sender: TObject);
    procedure MenuItem41Click(Sender: TObject);
    procedure MenuItem43Click(Sender: TObject);
    procedure MenuItem44Click(Sender: TObject);
    procedure MenuItem51Click(Sender: TObject);
    procedure MenuItem57Click(Sender: TObject);
    procedure MenuItem58Click(Sender: TObject);
    procedure MenuItem59Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem12Click(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem14Click(Sender: TObject);
    procedure MenuItem15Click(Sender: TObject);
    procedure MenuItem18Click(Sender: TObject);
    procedure MenuItem20Click(Sender: TObject);
    procedure MenuItem26Click(Sender: TObject);
    procedure MenuItem28Click(Sender: TObject);
    procedure MenuItem46Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem50Click(Sender: TObject);
    procedure MenuItem60Click(Sender: TObject);
    procedure MenuItem61Click(Sender: TObject);
    procedure MenuItem62Click(Sender: TObject);
    procedure MenuItem64Click(Sender: TObject);
    procedure MenuItem65Click(Sender: TObject);
    procedure MenuItem66Click(Sender: TObject);
    procedure MenuItem69Click(Sender: TObject);
    procedure MenuItem70Click(Sender: TObject);
    procedure MenuItem71Click(Sender: TObject);
    procedure MenuItem72Click(Sender: TObject);
    procedure MenuItem73Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure StringGrid1Selection;
  private
    { private declarations }
  public
    { public declarations }
  end;
  indata=record
    name1: string[16];
    name2: string[16];
  end;
var
  // general
  Form1: TForm1;
  bin: TFileStream;
  firstload: boolean;                                              // first load
  b, bb, bbb: byte;                                          // general variable
  i: integer;                                                // general variable
  n1, n2, n3, n4, n5: integer;                                      // XML nodes
  s, ss, sss: string;                                          // general string
  searchresult: searchrec;
  tf: textfile;                                              // general textfile
  xmlfile: textfile;
  // settings
  lang: string[2];                                                   // language
  datafileversion: string;                            // version of the database
  dbln: string;                                          // language of database
  cmdpoffline: boolean;                                  // computer is off-line
  cmdpnocheckupdate: boolean;                                // no check upgrade
  offline: boolean;                                      // computer is off-line
  nocheckupdate: boolean;                                    // no check upgrade
  displaycolors: byte;                                        // display colours
  // data
  cpnm,cppn: array of string;                              // name and pin-names
  nodatabase: boolean;                                  // there is not database
  pinout: array[1..800] of widestring;                                 // pinout
  cpld: array[1..800] of widestring;                         // long description
  cpws: array[1..800] of widestring;                                  // website
  cpwd: array[1..800] of widestring;                         // datasheet on web
  thereisnewversion: boolean;    // it's true if there's new version on internet
  xedfname, xedfdscr: array[1..64] of string;           //xedf filename and desc
  compnumall, compnumcat: integer;                        // components' numbers
  sponsors: array[0..1,0..63] of string;         // sponsors name and webaddress
  substdata: array[1..5000,1..2] of string[16];                     // type list
  // paths, files
  xedfpath: string;                                        // path of xedf files
  picspath: string;                                     // path of base pictures
  exepath, p: shortstring;                                 // path of executable
  userdir: string;                                   // directory of actual user
  copyfile: string;                                              // copying file
  helpfile: string;                                                 // help file
  browserprogramme: string;                       // browser programme with path
  mailerprogramme: string;                         // mailer programme with path
  //urls
  checkupdateurl: string;                                          // update url
  websearchurl: string;                                         // websearch url

{$IFDEF WIN32}
const
  CSIDL_PROFILE = 40;
  SHGFP_TYPE_CURRENT = 0;
{$ENDIF}

{$I config.inc}

Resourcestring
  MESSAGE01='Sort';
  MESSAGE02='Base';
  MESSAGE03='Search selected type on internet';
  MESSAGE04='Type search';
  {...}
  MESSAGE10='Missing files! Please reinstall application.';
  MESSAGE11='Type';
  {...}
  MESSAGE19='File exists, overwrite?';
  MESSAGE20='Write error!';
  MESSAGE21='Electrontube datasheet';
  MESSAGE22='Pinout';
  MESSAGE23='Category';
  MESSAGE24='Parameters';
  MESSAGE25='Electrontube';
  MESSAGE26='Not found';
  MESSAGE27='Sorry, there is not help viewer!';
  MESSAGE28='Save';
  MESSAGE29='Save to file';
  MESSAGE30='Type search';
  MESSAGE31='Function';
  MESSAGE32='Add selected type to bookmarks';
  MESSAGE33='Version';
  MESSAGE34='Database is corrupt!';
  MESSAGE35='New version of database is available, click on ''Upgrade database'' to install it.';
  MESSAGE36='Original size';
  MESSAGE37='Characteristic drawer';
  MESSAGE38='Type substitution';
  MESSAGE39='Electrontubes';
  MESSAGE40='Description';
  MESSAGE41='New version of Tubes2 Open edition is available.';
  MESSAGE42='(This message does not show again.)';
  MESSAGE43='Homepage';
  MESSAGE44='HTML files (*.html)|*.html| text files (*.txt)|*.txt|';
  MESSAGE45='Show description';
  MESSAGE46='Parameter search';
  MESSAGE47='Open manufacturer''s website';
  MESSAGE48='Open manufacturer''s datasheet';
  MESSAGE49='Categories of electrontubes';
  MESSAGE50='Save datasheet in TXT or HTML format';
  MESSAGE51='Sorry, there is off-line mode.';
  MESSAGE52='Tube designation systems';
  MESSAGE53='Cannot run browser!';
  MESSAGE54='Cannot run mailer!';
  MESSAGE55='Parameters';
  MESSAGE56='Show lines';
  MESSAGE57='Please visit http://www.pozsarzs.hu for download it.';
  MESSAGE58='pinout';
  MESSAGE59='On-line pinout searcher';
  {...}
  MESSAGE61='Go to website';
  MESSAGE62='Search in all category';
  MESSAGE63='Package information';
  MESSAGE64='File is not readable.';
  {...}
  MESSAGE67='Licence';
  {...}
  MESSAGE70='Index file is corrupt!';
  MESSAGE71='Loading...';
  {...}
  MESSAGE77='Bookmarks';
  MESSAGE78='Useful websites';
  MESSAGE79='Pozsi''s homepage';
  MESSAGE80='Pozsi''s webshop';
  MESSAGE81='Electrontube pinouts';
  MESSAGE82='http://www.pozsarzs.hu/en/index.php';
  MESSAGE83='http://webshop.pozsarzs.hu/index.php?language=en';
  MESSAGE84='http://pinout.pozsarzs.hu';
  MESSAGE85='Datasheet';
  MESSAGE86='Website';

function searchnewversion: boolean;
procedure runbrowser(url: string);
procedure runmailer(url: string);
{$IFDEF WIN32}
function SHGetFolderPath(hwndOwner: HWND; nFolder: Integer; hToken: THandle;
         dwFlags: DWORD; pszPath: LPTSTR): HRESULT; stdcall;
         external 'Shell32.dll' name 'SHGetFolderPathA';
{$ENDIF}

implementation
{$R *.lfm}
{ TForm1 }

//******************* GENERAL PROCEDURES AND FUNCTIONS 1. **********************
//-- run browser ---------------------------------------------------------------
procedure runbrowser(url: string);
begin
  if length(browserprogramme)=0
  then Form7.ShowModal else
  begin
    Form1.Process2.CommandLine:=browserprogramme+' '+url;
    try
      Form1.Process2.Execute;
    except
      ShowMessage(MESSAGE53);
    end;
  end;
end;

//-- run mailer ----------------------------------------------------------------
procedure runmailer(url: string);
begin
  if length(mailerprogramme)=0
  then Form7.ShowModal else
  begin
    Form1.Process3.CommandLine:=mailerprogramme+' '+url;
    try
      Form1.Process3.Execute;
    except
      ShowMessage(MESSAGE54);
    end;
  end;
end;

//-- search new version of programme -------------------------------------------
function searchnewprogversion: boolean;
var
  txt: TStringList;
  newversion: string;
  storedversion: string;
begin
  searchnewprogversion:=false;
  assign(tf,userdir+DIR_CACHE+'prog_version.txt');
  txt:=TStringList.Create;
  with THTTPSend.Create do
  begin
    if HttpGetText(checkupdateurl+'prog_version.txt', txt) then
    try
      newversion:=txt.Strings[0];
      try
        reset(tf);
        readln(tf,storedversion);
        closefile(tf);
      except
      end;
      if (VERSION<>newversion) and (newversion<>storedversion) then
      begin
        try
          rewrite(tf);
          writeln(tf,newversion);
          closefile(tf);
        except
        end;
        searchnewprogversion:=true;
      end;
      if VERSION<>newversion then Form1.StatusBar1.Panels.Items[1].Text:=' '+MESSAGE41;
    except
    end;
    Free;
  end;
  txt.Free;
end;

//-- search new version of database --------------------------------------------
function searchnewversion: boolean;
var
  b: byte;
  dbi, nvi, e: integer;
  txt: TStringList;
  newversion: string;                                 // new version of database
begin
  searchnewversion:=false;
  txt:=TStringList.Create;
  s:=datafileversion;
  with THTTPSend.Create do
  begin

  Timeout:=3;
    if HttpGetText(checkupdateurl+'version.txt', txt)=true then
    begin
    try
      for b:=0 to txt.Count-1 do
      if txt.Strings[b][length(txt.Strings[b])-1]+txt.Strings[b][length(txt.Strings[b])]=
         s[length(s)-1]+s[length(s)] then
      begin
        newversion:=txt.Strings[b];
        delete(newversion,7,3);
        delete(s,7,3);
        val(newversion,nvi,e);
        val(s,dbi,e);
        if nvi>dbi then searchnewversion:=true;
        break;
      end;
    except
    end;
    end;
    Free;
  end;
  txt.Free;
end;

//****************************** FILE MENU *************************************
// -- save to file -------------------------------------------------------------
procedure TForm1.MenuItem12Click(Sender: TObject);
var
  tfdir, tfname, tfext: shortstring;

// save in html format
function savetohtml(filename: string): boolean;
begin
  assignfile(tf,s);
  {$IFDEF LINUX}
  {$I-}mkdir(tfdir+'/pics/');{$I+} ioresult;
  {$ENDIF}
  {$IFDEF WIN32}
  {$I-}mkdir(tfdir+'\pics\');{$I+} ioresult;
  {$ENDIF}
  try
    rewrite(tf);
    writeln(tf,'<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">');
    writeln(tf,'<html>');
    writeln(tf,'<head>');
    writeln(tf,'<meta http-equiv="content-type" content="text/html; charset=utf-8">');
    writeln(tf,'<title>'+MESSAGE21+' - '+StringGrid1.Cells[0,StringGrid1.Row]+'</title>');
    writeln(tf,'<meta name="generator" content="'+APPNAME+' '+VERSION+'">');
    writeln(tf,'</head>');
    writeln(tf,'<body>');
    writeln(tf,'<font face="freemono, monospace" size=3>');
    writeln(tf,'<table border=1 cellpadding=2 cellspacing=0><col width=492><col width=200>');
    writeln(tf,'<tr>');
    writeln(tf,'<td colspan=2 width=696 valign=top><font size=5><center><b>');
    writeln(tf,MESSAGE21);
    writeln(tf,'</b></center></font></td>');
    writeln(tf,'</tr>');
    writeln(tf,'<tr valign=top>');
    writeln(tf,'<td width=492>');
    writeln(tf,'<b>'+MESSAGE11+': </b>'+StringGrid1.Cells[0,StringGrid1.Row]+'<br>');
    writeln(tf,'<b>'+MESSAGE31+': </b>'+StringGrid1.Cells[1,StringGrid1.Row]+'<br>');
    writeln(tf,'<b>'+MESSAGE02+': </b>'+StringGrid1.Cells[2,StringGrid1.Row]+'<br>');
    writeln(tf,'</td>');
    writeln(tf,'<td width=200>');
    writeln(tf,'<img src="pics/'+lowercase(StringGrid1.Cells[2,StringGrid1.Row])+'.png" name="" alt="" align=bottom width=200 height=200 border=0>');
    writeln(tf,'</td>');
    writeln(tf,'</tr>');
    writeln(tf,'<tr valign=top>');
    writeln(tf,'<td width=492>');

    writeln(tf,'<b>'+MESSAGE24+':</b><br>');
    for b:=3 to StringGrid1.ColCount-1 do
      writeln(tf,StringGrid1.Cells[b,0]+': '+StringGrid1.Cells[b,StringGrid1.Row]+'<br>');

    writeln(tf,'<br>');

    writeln(tf,'<b>'+MESSAGE40+':</b><br>');
    for b:=0 to Memo2.Lines.Count do
      writeln(tf,Memo2.Lines.Strings[b]+'<br>');

    writeln(tf,'</td>');
    writeln(tf,'<td width=200>');
    writeln(tf,'<b>'+MESSAGE22+':</b><br>');
    for b:=0 to Memo1.Lines.Count do
      writeln(tf,Memo1.Lines.Strings[b]+'<br>');
    writeln(tf,'</td>');
    writeln(tf,'</tr>');
    writeln(tf,'</table>');
    writeln(tf,'<font size=2>'+APPNAME+' v'+VERSION+', <a href="http://www.pozsarzs.hu">'+MESSAGE43+'</a>,');
    writeln(tf,'<a href="http://'+MESSAGE58+'.pozsarzs.hu">'+MESSAGE59+'</a></font>');
    writeln(tf,'</font>');
    writeln(tf,'</body>');
    writeln(tf,'</html>');
    closefile(tf);
    // save picture
    try
      {$IFDEF LINUX}
      Image1.Picture.SaveToFile(tfdir+'/pics/'+lowercase(StringGrid1.Cells[2,StringGrid1.Row])+'.png')
      {$ENDIF}
      {$IFDEF WIN32}
      Image1.Picture.SaveToFile(tfdir+'\pics\'+lowercase(StringGrid1.Cells[2,StringGrid1.Row])+'.png')
      {$ENDIF}
    except
      result:=false;
      exit;
    end;
    result:=true;
  except
    result:=false
  end;
end;

// save in plain text format
function savetotxt(filename: string): boolean;
begin
  assignfile(tf,s);
  try
    rewrite(tf);
    writeln(tf,MESSAGE21);
    for b:=1 to 80 do write(tf,'=');
    writeln(tf,'');
    writeln(tf,MESSAGE11+': '+StringGrid1.Cells[0,StringGrid1.Row]);
    writeln(tf,MESSAGE31+': '+StringGrid1.Cells[1,StringGrid1.Row]);
    writeln(tf,MESSAGE02+': '+StringGrid1.Cells[2,StringGrid1.Row]);
    for b:=1 to 80 do write(tf,'-');
    writeln(tf,'');
    writeln(tf,MESSAGE24+':');
    for b:=3 to StringGrid1.ColCount-1 do
      writeln(tf,StringGrid1.Cells[b,0]+': '+StringGrid1.Cells[b,StringGrid1.Row]);
    for b:=1 to 80 do write(tf,'-');
    writeln(tf,'');
    writeln(tf,MESSAGE40+':');
    writeln(tf,cpld[StringGrid1.Row]);
    for b:=1 to 80 do write(tf,'-');
    writeln(tf,'');
    writeln(tf,MESSAGE22+':');
    write(tf,pinout[StringGrid1.Row]);
    for b:=1 to 80 do write(tf,'-');
    writeln(tf,'');
    writeln(tf,APPNAME+' v'+VERSION+', '+MESSAGE43+': <http://www.pozsarzs.hu>,');
    writeln(tf,MESSAGE59+': <http://'+MESSAGE58+'.pozsarzs.hu>');
    closefile(tf);
    result:=true;
  except
    result:=false
  end;
end;

begin
  SaveDialog1.Title:=MESSAGE28;
  SaveDialog1.InitialDir:=userdir;
  SaveDialog1.Filename:=StringGrid1.Cells[0,StringGrid1.Row];
  SaveDialog1.Filter:=MESSAGE44;
  SaveDialog1.FilterIndex:=1;
  if SaveDialog1.Execute=false then exit;
  case SaveDialog1.FilterIndex of
    1:  begin
          s:= SaveDialog1.FileName;
          i:=length(s);
          if (s[i-4]+s[i-3]+s[i-2]+s[i-1]+s[i]<>'.html') and (s[i-3]+s[i-2]+s[i-1]+s[i]<>'.htm')
          then s:=s+'.html';
        end;
    2:  begin
          s:= SaveDialog1.FileName;
          i:=length(s);
          if (s[i-3]+s[i-2]+s[i-1]+s[i]<>'.txt')
          then s:=s+'.txt';
        end;
  end;
  fsplit(s,tfdir,tfname,tfext);
  if FSearch(tfname+tfext,tfdir)<>'' then
    if MessageDlg(MESSAGE19,mtConfirmation, [mbYes, mbNo],0)=mrNo then exit;
  if length(s)=0 then exit;
  case SaveDialog1.FilterIndex of
    1: if savetohtml(s)=false then showmessage(MESSAGE20);
    2: if savetotxt(s)=false then showmessage(MESSAGE20);
  end;
end;

// -- print datasheet ----------------------------------------------------------
procedure TForm1.MenuItem43Click(Sender: TObject);
begin
  //print
end;

//-- open update window --------------------------------------------------------
procedure TForm1.MenuItem13Click(Sender: TObject);
begin
  Form6.ShowModal;
end;

//-- view package information --------------------------------------------------
procedure TForm1.MenuItem60Click(Sender: TObject);
begin
  Form8.Caption:=MESSAGE63;
  Form8.Memo1.Clear;
  try
    Form8.Memo1.Lines.LoadFromFile(xedfpath+'news.txt');
  except
    Form8.Memo1.Lines.Add(MESSAGE64);
  end;
  Form8.Show;
end;

//-- open settings window ------------------------------------------------------
procedure TForm1.MenuItem15Click(Sender: TObject);
begin
  Form7.ShowModal;
end;

//-- exit ----------------------------------------------------------------------
procedure TForm1.MenuItem46Click(Sender: TObject);
begin
  Form1.Close;
  Application.Terminate;
end;

//****************************** SEARCH MENU ***********************************
//-- type search on internet ---------------------------------------------------
procedure TForm1.MenuItem38Click(Sender: TObject);
begin
  runbrowser(websearchurl+StringGrid1.Cells[0,StringGrid1.Row]);
end;

//-- type search ---------------------------------------------------------------
procedure TForm1.MenuItem11Click(Sender: TObject);
begin
  s:=uppercase(StringGrid1.Cells[0,StringGrid1.Row]);
  if inputquery(MESSAGE04,MESSAGE25,s)=false then exit;
  s:=uppercase(s);
  for i:=1 to 800 do
  begin
    if i=StringGrid1.RowCount then
    begin
      showmessage(MESSAGE26); // Not found.
      exit;
    end;
    if uppercase(StringGrid1.Cells[0,i])=s then
    begin
      StringGrid1.Row:=i;
      exit;
    end;
  end;
end;

//-- parameter search ----------------------------------------------------------
procedure TForm1.MenuItem5Click(Sender: TObject);
begin
  Form3.ShowModal;
end;

//-- search in all database ----------------------------------------------------
procedure TForm1.MenuItem57Click(Sender: TObject);
var
  ftype, catnum: string;

  function getcategory(reqtype: string): string;
  var
    itype, icat: string;
  begin
    result:='';
    {$IFDEF LINUX}
      assignfile(tf,xedfpath+'../index.csv');
    {$ENDIF}
    {$IFDEF WIN32}
      assignfile(tf,xedfpath+'..\index.csv');
    {$ENDIF}
    try
      reset(tf);
      repeat
        itype:='';
        icat:='';
        readln(tf,ss);
        ss:=rmchr3(ss);
        for b:=2 to length(ss) do
          if ss[b]<>'"' then itype:=itype+ss[b] else break;
        for b:=b+1 to length(ss) do
          if ss[b]='"' then break;
        for b:=b+1 to length(ss) do
          if ss[b]<>'"' then icat:=icat+ss[b] else break;
        if uppercase(itype)=reqtype then result:=icat;
      until eof(tf);
      closefile(tf);
    except
      showmessage(MESSAGE70);
    end;
  end;

begin
  s:=uppercase(StringGrid1.Cells[0,StringGrid1.Row]);
  if inputquery(MESSAGE62,MESSAGE25,s)=false then exit;
  ftype:=uppercase(s);
  catnum:=getcategory(ftype);
  if catnum='' then
  begin
    showmessage(MESSAGE26); // Not found.
    exit;
  end;
  for b:=1 to 64 do
    if xedfname[b]=catnum+'.xedf' then break;
  for bb:=0 to ComboBox1.Items.Count do
    if ComboBox1.Items.Strings[bb]=xedfdscr[b] then break;
  ComboBox1.ItemIndex:=bb;
  ComboBox1Change;
  for i:=1 to 800 do
  begin
    if i=StringGrid1.RowCount then
    begin
      showmessage(MESSAGE26); // Not found.
      exit;
    end;
    if uppercase(StringGrid1.Cells[0,i])=ftype then
    begin
      StringGrid1.Row:=i;
      exit;
    end;
  end;
end;

//-- sort ----------------------------------------------------------------------
procedure TForm1.MenuItem18Click(Sender: TObject);
begin
  Form5.ShowModal;
end;

//****************************** VIEW MENU *************************************
//-- open manufacturer's website -----------------------------------------------
procedure TForm1.MenuItem44Click(Sender: TObject);
begin
  if frmmain.offline=false
  then runbrowser(cpws[StringGrid1.Row])
  else showmessage(MESSAGE51);
end;

//-- open datasheet ------------------------------------------------------------
procedure TForm1.MenuItem51Click(Sender: TObject);
begin
  if frmmain.offline=false
  then runbrowser(cpwd[StringGrid1.Row])
  else showmessage(MESSAGE51);
end;

//-- auto fill -----------------------------------------------------------------
procedure TForm1.MenuItem9Click(Sender: TObject);
begin
  StringGrid1.AutoFillColumns:=true;
  StringGrid1.AutoFillColumns:=false;
end;

//-- auto column size ----------------------------------------------------------
procedure TForm1.MenuItem14Click(Sender: TObject);
begin
  StringGrid1.AutoSizeColumns;
end;

//**************************** BOOKMARKS MENU **********************************
//-- show bookmarks ------------------------------------------------------------
procedure TForm1.MenuItem64Click(Sender: TObject);
begin
  TabSheet4.Show;
  TabSheet4.SetFocus;
end;

//-- add type to bookmark ------------------------------------------------------
procedure TForm1.MenuItem66Click(Sender: TObject);
begin
  ListBox1.Items.Add(StringGrid1.Cells[0,StringGrid1.Row]);
end;

//****************************** TOOLS MENU ************************************
// -- open characteristic drawer window ----------------------------------------
procedure TForm1.MenuItem41Click(Sender: TObject);
begin
  Form10.Show;
end;

// -- open type substitution window --------------------------------------------
procedure TForm1.MenuItem35Click(Sender: TObject);
begin
  Form11.Show;
end;

procedure TForm1.MenuItem58Click(Sender: TObject);
begin
  ShowHelpOrErrorForKeyword('','HTML/sign_brimar.html');
end;

procedure TForm1.MenuItem59Click(Sender: TObject);
begin
  ShowHelpOrErrorForKeyword('','HTML/sign_cv.html');
end;

procedure TForm1.MenuItem69Click(Sender: TObject);
begin
  ShowHelpOrErrorForKeyword('','HTML/sign_euro.html');
end;

procedure TForm1.MenuItem70Click(Sender: TObject);
begin
  ShowHelpOrErrorForKeyword('','HTML/sign_mazda.html');
end;

procedure TForm1.MenuItem71Click(Sender: TObject);
begin
  ShowHelpOrErrorForKeyword('','HTML/sign_philips.html');
end;

procedure TForm1.MenuItem72Click(Sender: TObject);
begin
  ShowHelpOrErrorForKeyword('','HTML/sign_soviet.html');
end;

procedure TForm1.MenuItem73Click(Sender: TObject);
begin
  ShowHelpOrErrorForKeyword('','HTML/sign_usa.html');
end;

//****************************** HELP MENU *************************************
//-- show help -----------------------------------------------------------------
procedure TForm1.MenuItem4Click(Sender: TObject);
begin
  ShowHelpOrErrorForKeyword('','HTML/index.html');
end;

//-- send a bugreport ----------------------------------------------------------
procedure TForm1.MenuItem31Click(Sender: TObject);
begin
  if lang='hu' then runbrowser(URL_BUGREPORT_HU)
  else runbrowser(URL_BUGREPORT);
end;

//-- order commercial release --------------------------------------------------
procedure TForm1.MenuItem39Click(Sender: TObject);
begin
  if lang='hu' then runbrowser(URL_ORDER_HU)
  else runbrowser(URL_ORDER);
end;

 //-- open homepage -------------------------------------------------------------
procedure TForm1.MenuItem62Click(Sender: TObject);
begin
  if lang='hu' then runbrowser(URL_HOMEPAGE_HU)
  else runbrowser(URL_HOMEPAGE);
end;

//-- view licence --------------------------------------------------------------
procedure TForm1.MenuItem61Click(Sender: TObject);
begin
  Form8.Caption:=MESSAGE67;
  Form8.Memo1.Clear;
  try
  Form8.Memo1.Lines.LoadFromFile(copyfile);
  except
    Form8.Memo1.Lines.Add(MESSAGE64);
  end;
  Form8.Show;
end;

//-- show about ----------------------------------------------------------------
procedure TForm1.MenuItem7Click(Sender: TObject);
begin
  Form2.ShowModal;
end;

//****************************** POPUP MENU 1 **********************************
//-- show/hide stringgrids lines -----------------------------------------------
procedure TForm1.MenuItem50Click(Sender: TObject);
begin
  MenuItem50.Checked:=not MenuItem50.Checked;
  MenuItem48.Checked:=MenuItem50.Checked;
  if MenuItem50.Checked=true
  then StringGrid1.GridLineWidth:=1
  else StringGrid1.GridLineWidth:=0;
end;

//****************************** POPUP MENU 2 **********************************
//-- copy pinout to clipboard --------------------------------------------------
procedure TForm1.MenuItem20Click(Sender: TObject);
begin
  Memo1.SelectAll;
  Memo1.CopyToClipboard;
end;

//****************************** POPUP MENU 3 **********************************
//-- copy description to clipboard ---------------------------------------------
procedure TForm1.MenuItem26Click(Sender: TObject);
begin
  Memo2.SelectAll;
  Memo2.CopyToClipboard;
end;

//-- show/hide description -----------------------------------------------------
procedure TForm1.MenuItem28Click(Sender: TObject);
begin
  MenuItem28.Checked:=not MenuItem28.Checked;
  MenuItem30.Checked:=MenuItem28.Checked;
  MenuItem49.Checked:=MenuItem28.Checked;
  if MenuItem28.Checked=true
  then PairSplitter1.Position:=Height-150
  else PairSplitter1.Position:=PairSplitter1.Top+PairSplitter1.Height;
end;

//****************************** POPUP MENU 4 **********************************
//-- remove type to bookmark ---------------------------------------------------
procedure TForm1.MenuItem65Click(Sender: TObject);
begin
  if ListBox1.Count>0 then
    if ListBox1.ItemIndex>=0
    then ListBox1.Items.Delete(ListBox1.ItemIndex);
end;

//******************* GENERAL PROCEDURES AND FUNCTIONS 2. **********************
//-- resize window -------------------------------------------------------------
procedure TForm1.FormResize(Sender: TObject);
begin
  StatusBar1.Panels.Items[1].Width:=Width-297;
end;

//-- load text and picture of selected component -------------------------------
procedure TForm1.StringGrid1Selection;
begin
  Memo1.Lines.Clear;
  Memo1.Lines.Add(pinout[StringGrid1.Row]);
  Memo1.Lines.Delete(Memo1.Lines.Count-1);
  Memo1.Lines.Insert(0,'');
  Memo1.Lines.Delete(0);

  Memo2.Lines.Clear;
  Memo2.Lines.Add(cpld[StringGrid1.Row]);
  if length(cpwd[StringGrid1.Row])=0
  then ToolButton16.Enabled:=false else
  begin
    Memo2.Lines.Add(MESSAGE85+': '+cpwd[StringGrid1.Row]);
    ToolButton16.Enabled:=true;
  end;
  MenuItem51.Enabled:=ToolButton16.Enabled;
  if length(cpws[StringGrid1.Row])=0
  then ToolButton15.Enabled:=false else
  begin
    Memo2.Lines.Add(MESSAGE86+': '+cpws[StringGrid1.Row]);
    ToolButton15.Enabled:=true;
  end;
  MenuItem44.Enabled:=ToolButton15.Enabled;
  Memo2.Lines.Insert(0,'');
  Memo2.Lines.Delete(0);
  try
    {$IFDEF LINUX}
    Image1.Picture.LoadFromFile(picspath+lowercase(StringGrid1.Cells[2,StringGrid1.Row])+'.png');
    {$ENDIF}
    {$IFDEF WIN32}
    Image1.Picture.LoadFromFile(picspath+lowercase(StringGrid1.Cells[2,StringGrid1.Row])+'.png');
    {$ENDIF}
  except
    Image1.Picture.Clear;
  end;
end;

//-- select another category -----------------------------------------------------
procedure TForm1.ComboBox1Change;
var
  compnumcatdiv2, compnumcatdiv4: integer;
  xmlfilename: string;
  col: byte;
  row: integer;
  pinnum: byte;
begin
  if firstload=false then
  begin
    Form1.Cursor:=crHourGlass;
    Form9.Show;
    Form9.Caption:=MESSAGE71;
    Form9.ProgressBar1.Position:=0;   // ProgressBar -> 0%
  end;
  Application.ProcessMessages;
  for i:=1 to 800 do pinout[i]:='';
  for i:=1 to 800 do cpld[i]:='';
  for i:=1 to 800 do cpwd[i]:='';
  for i:=1 to 800 do cpws[i]:='';
  for b:=1 to 64 do
    if xedfdscr[b]=ComboBox1.Items.Strings[ComboBox1.ItemIndex]
    then
      begin
        Memo3.Lines.Clear;
        try
          s:=xedfpath+xedfname[b];
          delete(s,length(s)-3,4);
          Memo3.Lines.LoadFromFile(s+'txt');
          xmlfilename:=s+'xedf';
        except
        end;
        Memo3.Lines.Insert(0,'');
        Memo3.Lines.Delete(0);
      end;

  StringGrid1.ColCount:=2;
  StringGrid1.ColCount:=4;
  StringGrid1.Clean;
  StringGrid1.Cells[0,0]:=MESSAGE11;
  StringGrid1.Cells[1,0]:=MESSAGE31;
  StringGrid1.Cells[2,0]:=MESSAGE02;
  // load name and unit of parameters
  assignfile(xmlfile,xmlfilename);
  try
    n1:=1;
    reset(xmlfile);
    repeat
      readln(xmlfile,s); s:=rmchr3(s);
      if s='<xedf>' then
      repeat
        readln(xmlfile,s); s:=rmchr3(s);
        if s='<header>' then
        begin
          repeat
            readln(xmlfile,s); s:=rmchr3(s);

            if s[2..4]='noc' then
            begin
              ss:='';
              for b:=6 to length(s) do
              begin
                if s[b]='<' then break;
                ss:=ss+s[b];
              end;
              str(compnumall,sss);
              StatusBar1.Panels.Items[2].Text:=' '+sss+'/';
              val(ss,compnumcat,i);
              str(compnumcat,sss);
              StatusBar1.Panels.Items[2].Text:=StatusBar1.Panels.Items[2].Text+sss;
            end;

            if s[2..5]='prmt' then
            begin
              ss:='';
              for b:=7 to length(s) do
                if s[b]='>' then break;
              for b:=b+1 to length(s) do
              begin
                if s[b]='<' then break;
                ss:=ss+s[b];
              end;
              StringGrid1.Cells[StringGrid1.ColCount-1,0]:=ss;
              StringGrid1.ColCount:=StringGrid1.ColCount+1;
              n1:=n1+1;
            end;
          until (eof(xmlfile)) or (s='</header>') or (n1=63);
        end;
      until (eof(xmlfile));
    until (eof(xmlfile)) or (s='</xedf>');
    closefile(xmlfile);
  except
    ShowMessage(MESSAGE34);
  end;
  StringGrid1.ColCount:=StringGrid1.ColCount-1;
  StringGrid1.RowCount:=800;
  compnumcatdiv4:=compnumcat div 4;
  compnumcatdiv2:=compnumcat div 2;

  assignfile(xmlfile,xmlfilename);
  try
    row:=1;
    col:=1;
    reset(xmlfile);
    repeat
      readln(xmlfile,s); s:=rmchr3(s);
      if s='<xedf>' then
      repeat
       // refresh progressbar
       if row = (compnumcatdiv4+compnumcatdiv2) then
        begin
          if firstload=false then Form9.ProgressBar1.Position:=6;
          Application.ProcessMessages;
        end;
        if row = compnumcatdiv2 then
        begin
          if firstload=false then Form9.ProgressBar1.Position:=4;
          Application.ProcessMessages;
        end;
        if row = compnumcatdiv4 then
        begin
          if firstload=false then Form9.ProgressBar1.Position:=2;
          Application.ProcessMessages;
        end;
        // load data
        readln(xmlfile,s); s:=rmchr3(s);
        if s='<component>' then
        begin
          col:=1; pinnum:=1;
          repeat
            readln(xmlfile,s); s:=rmchr3(s);

            if s[2..5]='cpnm' then
            begin
              ss:='';
              for b:=7 to length(s) do
              begin
                if s[b]='<' then break;
                ss:=ss+s[b];
              end;
              StringGrid1.Cells[0,row]:=ss;
            end;

            if s[2..5]='cpds' then
            begin
              ss:='';
              for b:=7 to length(s) do
              begin
                if s[b]='<' then break;
                ss:=ss+s[b];
              end;
              StringGrid1.Cells[1,row]:=ss;
            end;

            if s[2..5]='cppc' then
            begin
              ss:='';
              for b:=7 to length(s) do
              begin
                if s[b]='<' then break;
                ss:=ss+s[b];
              end;
              StringGrid1.Cells[2,row]:=ss;
            end;

            if s[2..5]='cpld' then
            begin
              ss:='';
              for b:=7 to length(s) do
              begin
                if s[b]='<' then break;
                ss:=ss+s[b];
              end;
              cpld[row]:=stringconverter(ss);

            // links
            for i:=1 to length(cpld[row]) do
              if cpld[row][i]+cpld[row][i+1]='[h' then break;
            for i:=i+1 to length(cpld[row]) do
              if cpld[row][i]=']' then break else cpws[row]:=cpws[row]+cpld[row][i];

            for i:=i+1 to length(cpld[row]) do
              if cpld[row][i]+cpld[row][i+1]='[h' then break;
            for i:=i+1 to length(cpld[row]) do
              if cpld[row][i]=']' then break else cpwd[row]:=cpwd[row]+cpld[row][i];

            for i:=1 to length(cpld[row]) do
              if cpld[row][i]+cpld[row][i+1]='[h' then break;
            if cpld[row][i]+cpld[row][i+1]='[h' then delete(cpld[row],i,length(cpld[row]));
            end;
            if s[2..5]='cppn' then
            begin
              ss:='';
              for b:=7 to length(s) do
                if s[b]='>' then break;
              for b:=b+1 to length(s) do
              begin
                if s[b]='<' then break;
                ss:=ss+s[b];
              end;
              str(pinnum,sss);
              if length(sss)=1 then sss:='0'+sss;
              pinout[row]:=pinout[row]+' '+sss
              +':'+#9+ss{$IFDEF WIN32}+#13{$ENDIF}+#10;
              pinnum:=pinnum+1;
            end;

            if s[2..5]='prmt' then
            begin
              ss:='';
              for b:=7 to length(s) do
              begin
                if s[b]='<' then break;
                ss:=ss+s[b];
              end;
              col:=col+1;
              StringGrid1.Cells[1+col,row]:=stringconverter(ss);
            end;

          until (eof(xmlfile)) or (s='</component>') or (row=800);
          row:=row+1;
        end;
      until (eof(xmlfile));
    until (eof(xmlfile)) or (s='</xedf>');
    closefile(xmlfile);
  except
    ShowMessage(MESSAGE34);
  end;
  if firstload=false then Form9.ProgressBar1.Position:=8;   // ProgressBar -> 100%
  StringGrid1.Rowcount:=row-1; // :=n1
  i:=0;
  for b:=1 to StringGrid1.ColCount do
   i:=i+StringGrid1.ColWidths[i];
  if StringGrid1.Width-20<=i
  then MenuItem14.Click
  else MenuItem9.Click;
  Application.ProcessMessages;
  Form1.Caption:=APPNAME+' v'+VERSION+' - '+ComboBox1.Items.Strings[ComboBox1.ItemIndex];
  StringGrid1Selection;
  Form1.Cursor:=crDefault;
  if firstload=false then
  begin
    Form9.Close;
    StringGrid1.SetFocus;
    StringGrid1.Row:=1;
  end;
  firstload:=false;
end;

// open useful links
procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  for b:=0 to 63 do
    if sponsors[0,b]=ComboBox2.Items.Strings[ComboBox2.ItemIndex] then break;
  runbrowser(sponsors[1,b]);
end;

//-- save bookmarks before exit ------------------------------------------------
procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  try
    ListBox1.Items.SaveToFile(userdir+DIR_CONFIG+'tubes2.bmk');
  except
  end;
  CanClose:=true;
end;

//-- dummy popup menu ----------------------------------------------------------
procedure TForm1.Memo3ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin
  Handled:=true;
end;

//-- select a bookmark----------------------------------------------------------
procedure TForm1.ListBox1Click(Sender: TObject);
var
  ftype, catnum: string;

  function getcategory(reqtype: string): string;
  var
    itype, icat: string;
  begin
    result:='';
    {$IFDEF UNIX}
      assignfile(tf,xedfpath+'../index.csv');
    {$ENDIF}
    {$IFDEF WIN32}
      assignfile(tf,xedfpath+'..\index.csv');
    {$ENDIF}
    try
      reset(tf);
      repeat
        itype:='';
        icat:='';
        readln(tf,ss);
        ss:=rmchr3(ss);
        for b:=2 to length(ss) do
          if ss[b]<>'"' then itype:=itype+ss[b] else break;
        for b:=b+1 to length(ss) do
          if ss[b]='"' then break;
        for b:=b+1 to length(ss) do
          if ss[b]<>'"' then icat:=icat+ss[b] else break;
        if uppercase(itype)=reqtype then result:=icat;
      until eof(tf);
      closefile(tf);
    except
      showmessage(MESSAGE70);
    end;
  end;

begin
  ftype:=uppercase(ListBox1.Items.Strings[ListBox1.ItemIndex]);
  catnum:=getcategory(ftype);
  if catnum='' then
  begin
    showmessage(MESSAGE26); // Not found.
    exit;
  end;
  for b:=1 to 64 do
    if xedfname[b]=catnum+'.xedf' then break;
  for bb:=0 to ComboBox1.Items.Count do
    if ComboBox1.Items.Strings[bb]=xedfdscr[b] then break;
  ComboBox1.ItemIndex:=bb;
  ComboBox1Change;
  for i:=1 to 800 do
  begin
    if i=StringGrid1.RowCount then
    begin
      showmessage(MESSAGE26); // Not found.
      exit;
    end;
    if uppercase(StringGrid1.Cells[0,i])=ftype then
    begin
      StringGrid1.Row:=i;
      exit;
    end;
  end;
end;

//-- watch scroll-lock button --------------------------------------------------
procedure TForm1.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  scrlckstate: boolean;

  function LowOrderBitSet( Value: integer ): boolean;
  begin
   Result := (Value and 1 > 0);
  end;

begin
  scrlckstate:=LowOrderBitSet(GetKeyState($91));
  if scrlckstate then
  begin
    StatusBar1.Panels.Items[3].Text:=' SCR';
    StringGrid1.Options:=StringGrid1.Options+[goScrollKeepVisible];
  end else
  begin
    StatusBar1.Panels.Items[3].Text:='';
    StringGrid1.Options:=StringGrid1.Options-[goScrollKeepVisible];
  end;
end;

// -- OnCreate event -----------------------------------------------------------
procedure TForm1.FormCreate(Sender: TObject);
{$IFDEF WIN32}
var
  Buffer : PChar;
  Size : integer;
{$ENDIF}

{$IFDEF WIN32}
  function GetUserProfile: string;
  var
    Buffer: array[0..MAX_PATH] of Char;
  begin
    FillChar(Buffer, SizeOf(Buffer), 0);
    SHGetFolderPath(0, CSIDL_PROFILE, 0, SHGFP_TYPE_CURRENT, Buffer);
    Result := String(PChar(@Buffer));
  end;
{$ENDIF}

procedure loadsubstdata;
var
  id: indata;
  rf: file of indata;
  i: integer;

begin
  {$IFDEF UNIX}
    assignfile(rf,xedfpath+'../subst.dat');
  {$ENDIF}
  {$IFDEF WIN32}
    assignfile(rf,xedfpath+'..\subst.dat');
  {$ENDIF}
  try
    reset(rf);
    i:=1;
    repeat
      read(rf,id);
      substdata[i,1]:=id.name1; substdata[i,2]:=id.name2;
      i:=i+1;
    until eof(rf);
    closefile(rf);
  except
    ShowMessage(MESSAGE10); // No datafile!
    nodatabase:=true;
    halt;
  end;
end;

procedure loadsponsorsaddress;
var
  bin: TFileStream;
  tb: byte;
begin
  if offline=false then
  begin
    // download new list
    bin:=TFileStream.Create(userdir+DIR_CACHE+'sponsors.csv',fmCreate);
    try    
      with THTTPSend.Create do
        HttpGetBinary(URL_SPONSORS,bin);
    except
    end;
    bin.Free;
  end;
  // load to array
  assignfile(tf,userdir+DIR_CACHE+'sponsors.csv');
  try
    reset(tf);
    tb:=3;
    repeat
      readln(tf,ss);
      ss:=rmchr3(ss);
      for b:=2 to length(ss) do
        if ss[b]<>'"' then sponsors[0,tb]:=sponsors[0,tb]+ss[b] else break;
      for b:=b+1 to length(ss) do
        if ss[b]='"' then break;
      for b:=b+1 to length(ss) do
        if ss[b]<>'"' then sponsors[1,tb]:=sponsors[1,tb]+ss[b] else break;
      if tb<63 then tb:=tb+1;
    until eof(tf) or (tb=63);
    closefile(tf);
  except;
  end;
end;

begin
  // path of executable / binary file
  fsplit(paramstr(0),exepath,p,p);

  // home directory
  {$IFDEF UNIX}
  userdir:=getenvironmentvariable('HOME');
  {$ENDIF}
  {$IFDEF WIN32}
  userdir:=getuserprofile;
  {$ENDIF}

  // user's datadirectory
  ForceDirectories(userdir+DIR_CACHE);
  ForceDirectories(userdir+DIR_CONFIG);
  ForceDirectories(userdir+DIR_DATA);
  ForceDirectories(userdir+DIR_PICS);

  // language
  {$IFDEF UNIX}
  s:=getenv('LANG');
  {$ENDIF}
  {$IFDEF WIN32}
  Size:=GetLocaleInfo (LOCALE_USER_DEFAULT, LOCALE_SABBREVLANGNAME, nil, 0);
  GetMem(Buffer, Size);
  try
    GetLocaleInfo (LOCALE_USER_DEFAULT, LOCALE_SABBREVLANGNAME, Buffer, Size);
    s:=string(Buffer);
  finally
    FreeMem(Buffer);
  end;
  {$ENDIF}
  if length(s)=0 then s:='en';
  lang:=lowercase(s[1..2]);

    // messages
  {$IFDEF UNIX}
    {$IFDEF UseFHS}
      translateresourcestrings(instpath+'share/locale/'+lang+'/LC_MESSAGES/tubes2oe.mo');
    {$ELSE}
      translateresourcestrings(exepath+'languages/'+lang+'/tubes2oe.mo');
    {$ENDIF}
  {$ENDIF}
  {$IFDEF WIN32}
    translateresourcestrings(exepath+'languages\'+lang+'\tubes2oe.mo');
  {$ENDIF}
  ToolButton11.Hint:=MESSAGE37;
  ToolButton13.Hint:=MESSAGE38;
  ToolButton14.Hint:=MESSAGE52;
  ToolButton15.Hint:=MESSAGE47;
  ToolButton16.Hint:=MESSAGE48;
  ToolButton2.Hint:=MESSAGE30;
  ToolButton3.Hint:=MESSAGE46;
  ToolButton4.Hint:=MESSAGE62;
  ToolButton5.Hint:=MESSAGE50;
  ToolButton7.Hint:=MESSAGE01;
  ToolButton8.Hint:=MESSAGE03;
  ToolButton9.Hint:=MESSAGE32;
  SpeedButton1.Hint:=MESSAGE61;
  ComboBox1.Hint:=MESSAGE49;
  ComboBox2.Hint:=MESSAGE78;

  // set copying file
  {$IFDEF UNIX}
    {$IFDEF UseFHS}
      copyfile:=instpath+'share/doc/tubes2oe/COPYING';
    {$ELSE}
      copyfile:=exepath+'documents/COPYING';
    {$ENDIF}
  {$ENDIF}
  {$IFDEF WIN32}
    copyfile:=exepath+'documents\copying.txt';
  {$ENDIF}

  // set help file
  {$IFDEF UNIX}
    {$IFDEF UseFHS}
      if FSearch('index.html',instpath+'share/tubes2oe/help_'+lang)<>''
      then helpfile:=instpath+'share/tubes2oe/help_'+lang+'/'
      else helpfile:=instpath+'share/tubes2oe/help_en/';
    {$ELSE}
      if FSearch('index.html',exepath+'help/help_'+lang)<>''
      then helpfile:=exepath+'help/help_'+lang+'/'
      else helpfile:=exepath+'help/help_en/';
    {$ENDIF}
  {$ENDIF}
  {$IFDEF WIN32}
    if FSearch('index.html',exepath+'help\help_'+lang)<>''
    then helpfile:=exepath+'help\help_'+lang+'\'
    else helpfile:=exepath+'help\help_en\';
  {$ENDIF}
  HTMLHelpDatabase1.AutoRegister:=true;
  HTMLHelpDatabase1.KeywordPrefix:='HTML/';
  HTMLHelpDatabase1.BaseURL:='file://'+helpfile;
  HTMLBrowserHelpViewer1.AutoRegister:=true;

  // search datafile - in original folder
  {$IFDEF UNIX}
    {$IFDEF UseFHS}
      picspath:=instpath+'share/tubes2oe/base/';
      if FSearch('version.txt',instpath+'share/tubes2oe/library_'+lang)<>''
      then xedfpath:=instpath+'share/tubes2oe/library_'+lang+'/'
      else xedfpath:=instpath+'share/tubes2oe/library_en/';
    {$ELSE}
      picspath:=exepath+'library/base/';
      if FSearch('version.txt',exepath+'library/library_'+lang)<>''
      then xedfpath:=exepath+'library/library_'+lang+'/'
      else xedfpath:=exepath+'library/library_en/';
    {$ENDIF}
  {$ENDIF}
  {$IFDEF WIN32}
  picspath:=exepath+'library\base\';
  if FSearch('version.txt',exepath+'library\library_'+lang)<>''
  then xedfpath:=exepath+'library\library_'+lang+'\'
  else xedfpath:=exepath+'library\library_en\';
  {$ENDIF}

  //search datafile - in user folder
  if FSearch('version.txt',userdir+DIR_DATA)<>'' then
  begin
    xedfpath:=userdir+DIR_DATA;
    picspath:=userdir+DIR_PICS;
  end;

  // save default setting
  if FSearch(frmconfig.INIFILE,userdir+DIR_CONFIG)='' then savedefaultsettings;

  // load settings
  loadsettings;
  MenuItem48.Checked:=MenuItem50.Checked;
  if MenuItem50.Checked=true
    then StringGrid1.GridLineWidth:=1
    else StringGrid1.GridLineWidth:=0;
  MenuItem30.Checked:=MenuItem28.Checked;
  MenuItem49.Checked:=MenuItem28.Checked;
  if MenuItem28.Checked=true
    then PairSplitter1.Position:=Height-180
    else PairSplitter1.Position:=PairSplitter1.Top+PairSplitter1.Height;
  MenuItem31.Enabled:=not offline;
  MenuItem62.Enabled:=not offline;
  if cmdpnocheckupdate then nocheckupdate:=true;
  if cmdpoffline then offline:=true;
  Form1.MenuItem31.Enabled:=not frmmain.offline;
  Form1.MenuItem38.Enabled:=not frmmain.offline;
  Form1.MenuItem39.Enabled:=not frmmain.offline;
  Form1.MenuItem40.Enabled:=not frmmain.offline;
  Form1.MenuItem62.Enabled:=not frmmain.offline;
  Form1.ToolButton8.Enabled:=not frmmain.offline;
  Form1.ComboBox2.Enabled:=not frmmain.offline;

  // count components
  compnumall:=0;
  {$IFDEF UNIX}
    assignfile(xmlfile,xedfpath+'../index.csv');
  {$ENDIF}
  {$IFDEF WIN32}
    assignfile(xmlfile,xedfpath+'..\index.csv');
  {$ENDIF}
  try
    reset(xmlfile);
    repeat
      readln(xmlfile,s);
      compnumall:=compnumall+1;
    until eof(xmlfile);
    closefile(xmlfile);
  except
  end;

  // load categories
  compnumcat:=0;
  for b:=1 to 64 do xedfname[b]:='';
  for b:=1 to 64 do xedfdscr[b]:='';
  b:=0;
  findfirst(xedfpath+'*.xedf',anyfile,searchresult);
  while doserror=0 do
  begin
    with searchresult do
    begin
      xedfname[b+1]:=name;
      if b<64 then b:=b+1;
    end;
    findnext(searchresult);
  end;
  nodatabase:=false;
  if b=0 then
  begin
    ShowMessage(MESSAGE10); // No database!
    nodatabase:=true;
    halt;
  end;
  ComboBox1.Clear;
  for b:=1 to 64 do
  begin
    if xedfname[b]='' then break;
    assignfile(xmlfile,xedfpath+xedfname[b]);
    try
      reset(xmlfile);
      repeat
        readln(xmlfile,s); s:=rmchr3(s);
        if s='<xedf>' then
        repeat
          readln(xmlfile,s); s:=rmchr3(s);
          if s='<header>' then
          repeat
            readln(xmlfile,s); s:=rmchr3(s);
            if s[2..5]='dscr' then
            begin
              ss:='';
              for bb:=7 to length(s) do
              begin
                if s[bb]='<' then break;
                ss:=ss+s[bb];
              end;
              xedfdscr[b]:=ss;
              ComboBox1.Items.Add(xedfdscr[b]);
            end;

          until (eof(xmlfile)) or (s='</header>');
        until (eof(xmlfile));
      until (eof(xmlfile)) or (s='</xedf>');
      closefile(xmlfile);
    except
    end;
  end;
  firstload:=true;
  ComboBox1.ItemIndex:=0;
  if nodatabase=false then
  begin
    ComboBox1Change;
    try
      AssignFile(tf,xedfpath+'version.txt');
      Reset(tf);
      readln(tf,datafileversion);
      readln(tf,checkupdateurl);
    except
      ShowMessage(MESSAGE34); // Bad database!
      exit;
    end;
    CloseFile(tf);
    StatusBar1.Panels.Items[0].Text:=' '+MESSAGE33+': '+datafileversion;
    str(compnumall,s);
    StatusBar1.Panels.Items[2].Text:=' '+s+'/';
    str(compnumcat,s);
    StatusBar1.Panels.Items[2].Text:=StatusBar1.Panels.Items[2].Text+s;
    dbln:=datafileversion[length(datafileversion)-1]+datafileversion[length(datafileversion)];

    if cmdpoffline then offline:=true;
    if cmdpnocheckupdate then nocheckupdate:=true;

    // search new database version on internet
    if (offline=false) and (nocheckupdate=false)
     then frmmain.thereisnewversion:=searchnewversion
     else thereisnewversion:=false;
    if thereisnewversion=true then showmessage(MESSAGE35);

    // search new programme version on internet
    if (offline=false) and (nocheckupdate=false) then
      if searchnewprogversion=true then showmessage(MESSAGE41+' '+MESSAGE57+' '+MESSAGE42); // New version is available!

    ToolButton2.Enabled:=true;
    MenuItem2.Enabled:=true;
    MenuItem19.Enabled:=true;
    MenuItem22.Enabled:=true;
  end else
  begin
    ToolButton2.Enabled:=false;
    MenuItem2.Enabled:=false;
    MenuItem19.Enabled:=false;
    MenuItem22.Enabled:=false;
  end;

  // load bookmarks
  try
  ListBox1.Items.LoadFromFile(userdir+DIR_CONFIG+'tubes2.bmk');
  except
  end;

  // load useful links
  for b:=0 to 63 do
  begin
    sponsors[0,0]:='';
    sponsors[1,0]:='';
  end;
  // my links
  sponsors[0,0]:=MESSAGE79;
  sponsors[0,1]:=MESSAGE80;
  sponsors[0,2]:=MESSAGE81;
  sponsors[1,0]:=MESSAGE82;
  sponsors[1,1]:=MESSAGE83;
  sponsors[1,2]:=MESSAGE84;
  ComboBox2.Items.Add(MESSAGE79);
  ComboBox2.Items.Add(MESSAGE80);
  ComboBox2.Items.Add(MESSAGE81);
  // other links
  loadsponsorsaddress;
  for b:=3 to 63 do
    if (length(sponsors[0,b])>0) and (length(sponsors[1,b])>0)
       then ComboBox2.Items.Add(sponsors[0,b]);
  ComboBox2.ItemIndex:=0;

  // load substitution data
  loadsubstdata;
end;

end.


{ +--------------------------------------------------------------------------+ }
{ | Tubes 2.0 Trial * Electrontube catalogue                                 | }
{ | Copyright (C) 2008-2012 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | strconv.pp                                                               | }
{ | String converter                                                         | }
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

unit strconv;
interface
var
  s: widestring;
  b,bb: integer;
const 
  sign: array[1..2] of string = ('-+','+-');
  mean: array[1..2] of char = ('<','>');

function stringconverter(input: widestring): widestring;
Function rmchr3(input: widestring): widestring;

implementation

function stringconverter(input: widestring): widestring;
begin
  for b:=1 to length(input) do
  begin
    for bb:=1 to 2 do
     if input[b]+input[b+1]=sign[bb] then
       begin
         input[b]:=mean[bb];
         input[b+1]:='@';
       end;
  end;
  s:='';
  for b:=1 to length(input) do
    if input[b]<>'@' then s:=s+input[b] else s:=s;
  stringconverter := s;

  s:='';
  for b:=1 to length(input) do
    if input[b]<>'?' then s:=s+input[b] else s:=s+' ';
  stringconverter := s;

  {$IFDEF WIN32}
  s:='';
  for b:=1 to length(stringconverter) do
    if stringconverter[b]<>#10 then s:=s+stringconverter[b] else s:=s+#13+#10;
  {$ENDIF}
end;

//-- Remove space and tabulator from start of line -----------------------------
Function rmchr3(input: widestring): widestring;
Begin
  rmchr3 := '';
  While (input[1]=#9) or (input[1]=#32) Do delete(input,1,1);
  rmchr3 := input;
End;

end.

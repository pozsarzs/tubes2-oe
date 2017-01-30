'+-----------------------------------------------------------------------------+
'| Tubes2 Open edition 2.2 * Electron tube catalog                             |
'| Copyright (C) 2008-2017 Pozsar Zsolt info@pozsarzs.hu                       |
'| mkshortcut.vbs                                                              |
'| Make shortcut                                                               |
'+-----------------------------------------------------------------------------+

set WshShell = WScript.CreateObject("WScript.Shell" )
set oShellLink = WshShell.CreateShortcut(Wscript.Arguments.Named("shortcut") & ".lnk")
oShellLink.TargetPath = Wscript.Arguments.Named("target")
oShellLink.WindowStyle = 1
oShellLink.Save


# +----------------------------------------------------------------------------+
# | Tubes2 2.2 Open edition * Electron tube catalog                            |
# | Copyright (C) 2008-2017 Pozsar Zsolt <info@pozsarzs.hu>                    |
# | Makefile                                                                   |
# | Makefile for other files                                                   |
# +----------------------------------------------------------------------------+

include ../Makefile.global

desktopfiles= `ls *.desktop`
iconfiles = `ls *.xpm`

all:

clean:

install:
	@echo -n "- Installing desktop files..."
	@$(install) -d $(datarootdir)/applications
	@for x in $(desktopfiles); do \
	  if [ -e $$x ]; then $(install) -m $(txtmode) $$x $(datarootdir)/applications/; fi; \
	done
	@echo "done."
	@echo -n "- Installing icon files..."
	@$(install) -d $(datarootdir)/pixmaps
	@for x in $(iconfiles); do \
	  if [ -e $$x ]; then $(install) -m $(txtmode) $$x $(datarootdir)/pixmaps/; fi; \
	done
	@echo "done."

uninstall:
	@echo -n "- Removing desktop files..."
	@for x in $(desktopfiles); do \
	  if [ -e $$x ]; then $(rm) $(datarootdir)/applications/$$x; fi; \
	done
	@echo "done."
	@echo -n "- Removing icon files..."
	@for x in $(iconfiles); do \
	  if [ -e $$x ]; then $(rm) $(datarootdir)/pixmaps/$$x; fi; \
	done
	@echo "Done."


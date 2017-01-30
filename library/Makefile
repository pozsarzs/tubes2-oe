# +----------------------------------------------------------------------------+
# | Tubes2 2.2 Open edition * Electron tube catalog                            |
# | Copyright (C) 2008-2017 Pozsar Zsolt <info@pozsarzs.hu>                    |
# | Makefile                                                                   |
# | Make file                                                                  |
# +----------------------------------------------------------------------------+

include ../Makefile.global

all:

clean:

install:
	@echo -n "- Installing datafiles..."
	@$(install) -d $(datarootdir)/$(name)/library_en
	@$(install) -d $(datarootdir)/$(name)/library_hu
	@$(install) -d $(datarootdir)/$(name)/base
	@$(install) -m $(txtmode) library_en/* $(datarootdir)/$(name)/library_en/
	@$(install) -m $(txtmode) library_hu/* $(datarootdir)/$(name)/library_hu/
	@$(install) -m $(txtmode) base/* $(datarootdir)/$(name)/base/
	@$(install) -m $(txtmode) index.csv $(datarootdir)/$(name)/
	@$(install) -m $(txtmode) subst.dat $(datarootdir)/$(name)/
	@echo "done."

uninstall:
	@echo -n "- Removing datafiles..."
	@$(rm) $(datarootdir)/$(name)/library_en/*
	@$(rm) $(datarootdir)/$(name)/library_hu/*
	@$(rm) $(datarootdir)/$(name)/base/*
	@$(rm) $(datarootdir)/$(name)/index.csv
	@$(rm) $(datarootdir)/$(name)/subst.dat
	@rmdir $(datarootdir)/$(name)/library_en
	@rmdir $(datarootdir)/$(name)/library_hu
	@rmdir $(datarootdir)/$(name)/base
	@rmdir $(datarootdir)/$(name)/
	@echo "done."


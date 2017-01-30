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
	@$(install) --directory $(datarootdir)/$(name)/library_en
	@$(install) --directory $(datarootdir)/$(name)/library_hu
	@$(install) --directory $(datarootdir)/$(name)/base
	@$(install) --mode $(txtmode) library_en/* $(datarootdir)/$(name)/library_en/
	@$(install) --mode $(txtmode) library_hu/* $(datarootdir)/$(name)/library_hu/
	@$(install) --mode $(txtmode) base/* $(datarootdir)/$(name)/base/
	@$(install) --mode $(txtmode) index.csv $(datarootdir)/$(name)/
	@$(install) --mode $(txtmode) subst.dat $(datarootdir)/$(name)/
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


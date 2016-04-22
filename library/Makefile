# +----------------------------------------------------------------------------+
# | Tubes2 2.1 trial * Electrontube catalogue                                  |
# | Copyright (C) 2008-2016 Pozsar Zsolt <pozsarzs@gmail.com>                  |
# | Makefile                                                                   |
# | Make file                                                                  |
# +----------------------------------------------------------------------------+

include ../Makefile.global

all:

clean:

install:
	@echo -n Installing datafiles...
	@$(install) --directory $(datadir)/$(name)/library_en
	@$(install) --directory $(datadir)/$(name)/library_hu
	@$(install) --directory $(datadir)/$(name)/base
	@$(install) --mode $(txtmode) library_en/* $(datadir)/$(name)/library_en/
	@$(install) --mode $(txtmode) library_hu/* $(datadir)/$(name)/library_hu/
	@$(install) --mode $(txtmode) base/* $(datadir)/$(name)/base/
	@$(install) --mode $(txtmode) index.csv $(datadir)/$(name)/
	@echo "done."

uninstall:
	@echo -n Removing datafiles...
	@$(rm) $(datadir)/$(name)/library_en/*
	@$(rm) $(datadir)/$(name)/library_hu/*
	@$(rm) $(datadir)/$(name)/base/*
	@$(rm) $(datadir)/$(name)/index.csv
	@rmdir $(datadir)/$(name)/library_en
	@rmdir $(datadir)/$(name)/library_hu
	@rmdir $(datadir)/$(name)/base
	@rmdir $(datadir)/$(name)/
	@echo "Done."


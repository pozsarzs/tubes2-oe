# +----------------------------------------------------------------------------+
# | Tubes2 Open edition 2.2 * Electrontube catalogue                           |
# | Copyright (C) 2008-2017 Pozsar Zsolt <pozsarzs@gmail.com>                  |
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
	@$(install) --directory $(datadir)/$(name1)/library_en
	@$(install) --directory $(datadir)/$(name1)/library_hu
	@$(install) --directory $(datadir)/$(name1)/base
	@$(install) --mode $(txtmode) library_en/* $(datadir)/$(name1)/library_en/
	@$(install) --mode $(txtmode) library_hu/* $(datadir)/$(name1)/library_hu/
	@$(install) --mode $(txtmode) base/* $(datadir)/$(name1)/base/
	@$(install) --mode $(txtmode) index.csv $(datadir)/$(name1)/
	@echo "done."

uninstall:
	@echo -n Removing datafiles...
	@$(rm) $(datadir)/$(name1)/library_en/*
	@$(rm) $(datadir)/$(name1)/library_hu/*
	@$(rm) $(datadir)/$(name1)/base/*
	@$(rm) $(datadir)/$(name1)/index.csv
	@rmdir $(datadir)/$(name1)/library_en
	@rmdir $(datadir)/$(name1)/library_hu
	@rmdir $(datadir)/$(name1)/base
	@rmdir $(datadir)/$(name1)/
	@echo "Done."


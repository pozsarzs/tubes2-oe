# +----------------------------------------------------------------------------+
# | Tubes 2.0 * Electrontube catalogue                                         |
# | Copyright (C) 2008-2012 Pozsar Zsolt <pozsarzs@gmail.com>                  |
# | Makefile                                                                   |
# | Make file                                                                  |
# +----------------------------------------------------------------------------+

include ../Makefile.global

all:

clean:

install:
	@echo -n Installing help files...
	@$(install) --directory $(datadir)/$(name)/help_en/pics
	@$(install) --directory $(datadir)/$(name)/help_hu/pics
	@$(install) --mode $(txtmode) help_en/*.html $(datadir)/$(name)/help_en/
	@$(install) --mode $(txtmode) help_hu/*.html $(datadir)/$(name)/help_hu/
	@$(install) --mode $(txtmode) help_en/pics/* $(datadir)/$(name)/help_en/pics
	@$(install) --mode $(txtmode) help_hu/pics/* $(datadir)/$(name)/help_hu/pics
	@echo "done."

uninstall:
	@echo -n Removing help files...
	@$(rm) $(datadir)/$(name)/help_en/pics/*
	@$(rm) $(datadir)/$(name)/help_hu/pics/*
	@$(rm) $(datadir)/$(name)/help_en/*.html
	@$(rm) $(datadir)/$(name)/help_hu/*.html
	@rmdir $(datadir)/$(name)/help_en/pics
	@rmdir $(datadir)/$(name)/help_hu/pics
	@rmdir $(datadir)/$(name)/help_en
	@rmdir $(datadir)/$(name)/help_hu
	@echo "Done."


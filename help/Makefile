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
	@echo -n Installing help files...
	@$(install) --directory $(datadir)/$(name1)/help_en/pics
	@$(install) --directory $(datadir)/$(name1)/help_hu/pics
	@$(install) --mode $(txtmode) help_en/*.html $(datadir)/$(name1)/help_en/
	@$(install) --mode $(txtmode) help_hu/*.html $(datadir)/$(name1)/help_hu/
	@$(install) --mode $(txtmode) help_en/pics/* $(datadir)/$(name1)/help_en/pics
	@$(install) --mode $(txtmode) help_hu/pics/* $(datadir)/$(name1)/help_hu/pics
	@echo "done."

uninstall:
	@echo -n Removing help files...
	@$(rm) $(datadir)/$(name1)/help_en/pics/*
	@$(rm) $(datadir)/$(name1)/help_hu/pics/*
	@$(rm) $(datadir)/$(name1)/help_en/*.html
	@$(rm) $(datadir)/$(name1)/help_hu/*.html
	@rmdir $(datadir)/$(name1)/help_en/pics
	@rmdir $(datadir)/$(name1)/help_hu/pics
	@rmdir $(datadir)/$(name1)/help_en
	@rmdir $(datadir)/$(name1)/help_hu
	@echo "Done."


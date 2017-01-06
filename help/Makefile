# +----------------------------------------------------------------------------+
# | Tubes2 Open edition 2.2 * Electrontube catalogue                           |
# | Copyright (C) 2008-2017 Pozsar Zsolt <pozsarzs@gmail.com>                  |
# | Makefile                                                                   |
# | Make file                                                                  |
# +----------------------------------------------------------------------------+

include ../Makefile.global

all:

clean:

install:
	@echo -n "- Installing help files..."
	@$(install) --directory $(datarootdir)/$(name)/help_en/pics
	@$(install) --directory $(datarootdir)/$(name)/help_hu/pics
	@$(install) --mode $(txtmode) help_en/*.html $(datarootdir)/$(name)/help_en/
	@$(install) --mode $(txtmode) help_hu/*.html $(datarootdir)/$(name)/help_hu/
	@$(install) --mode $(txtmode) help_en/pics/* $(datarootdir)/$(name)/help_en/pics
	@$(install) --mode $(txtmode) help_hu/pics/* $(datarootdir)/$(name)/help_hu/pics
	@echo "done."

uninstall:
	@echo -n "- Removing help files..."
	@$(rm) $(datarootdir)/$(name)/help_en/pics/*
	@$(rm) $(datarootdir)/$(name)/help_hu/pics/*
	@$(rm) $(datarootdir)/$(name)/help_en/*.html
	@$(rm) $(datarootdir)/$(name)/help_hu/*.html
	@rmdir $(datarootdir)/$(name)/help_en/pics
	@rmdir $(datarootdir)/$(name)/help_hu/pics
	@rmdir $(datarootdir)/$(name)/help_en
	@rmdir $(datarootdir)/$(name)/help_hu
	@echo "Done."


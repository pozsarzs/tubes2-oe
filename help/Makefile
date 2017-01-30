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
	@echo -n "- Installing help files..."
	@$(install) -d $(datarootdir)/$(name)/help_en
	@$(install) -d $(datarootdir)/$(name)/help_hu
	@$(install) -m $(txtmode) help_en/*.html $(datarootdir)/$(name)/help_en/
	@$(install) -m $(txtmode) help_hu/*.html $(datarootdir)/$(name)/help_hu/
	@echo "done."

uninstall:
	@echo -n "- Removing help files..."
	@$(rm) $(datarootdir)/$(name)/help_en/*.html
	@$(rm) $(datarootdir)/$(name)/help_hu/*.html
	@rmdir $(datarootdir)/$(name)/help_en
	@rmdir $(datarootdir)/$(name)/help_hu
	@echo "Done."


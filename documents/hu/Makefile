# +----------------------------------------------------------------------------+
# | Tubes2 2.1 trial * Electrontube catalogue                                  |
# | Copyright (C) 2008-2016 Pozsar Zsolt <pozsarzs@gmail.com>                  |
# | Makefile                                                                   |
# | Make file                                                                  |
# +----------------------------------------------------------------------------+

include ../../Makefile.global

docfiles= `ls -I ?? | grep -v Makefile`
lang=hu

all:

clean:

install:
	@echo -n Installing document files...
	@$(install) --directory $(datadir)/doc/$(name1)/$(lang)
	@for x in $(docfiles); do \
	  if [ -e $$x ]; then $(install) --mode $(txtmode) $$x $(datadir)/doc/$(name1)/$(lang); fi; \
	done
	@echo "done."

uninstall:
	@echo -n Removing document files...
	@for x in $(docfiles); do \
	  if [ -e $$x ]; then $(rm) $(datadir)/doc/$(name1)/$(lang)/$$x; fi; \
	done
	@rmdir $(datadir)/doc/$(name1)/$(lang)
	@echo "done."


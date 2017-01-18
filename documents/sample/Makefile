# +----------------------------------------------------------------------------+
# | Tubes2 Open edition 2.2 * Electrontube catalogue                           |
# | Copyright (C) 2008-2017 Pozsar Zsolt <pozsarzs@gmail.com>                  |
# | Makefile                                                                   |
# | Makefile for documents                                                     |
# +----------------------------------------------------------------------------+

include ../../Makefile.global

docfiles= `ls | grep -v Makefile | grep -v ??`
lang=

all:

clean:

install:
	@echo -n "- Installing document files..."
	@$(install) -d $(datarootdir)/doc/$(name)/sample
	@for x in $(docfiles); do \
	  if [ -e $$x ]; then $(install) -m $(txtmode) $$x $(datarootdir)/doc/$(name)/sample; fi; \
	done
	@echo "done."

uninstall:
	@echo -n "- Removing document files..."
	@for x in $(docfiles); do \
	  if [ -e $$x ]; then $(rm) $(datarootdir)/doc/$(name)/sample/$$x; fi; \
	done
	@rmdir $(datarootdir)/doc/$(name)/sample
	@echo "done."


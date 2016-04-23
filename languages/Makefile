# +----------------------------------------------------------------------------+
# | Tubes2 2.1 trial * Electrontube catalogue                                  |
# | Copyright (C) 2008-2016 Pozsar Zsolt <pozsarzs@gmail.com>                  |
# | Makefile                                                                   |
# | Make file                                                                  |
# +----------------------------------------------------------------------------+

include ../Makefile.global

languages = hu

all:

clean:

install:
	@echo -n Installing message files...
	@for x in $(languages); do \
	  if [ -e $(name)_$$x.mo ]; \
	  then \
	    $(install) --directory $(localedir)/$$x/LC_MESSAGES; \
	    $(install) --mode $(txtmode) $(name)_$$x.mo $(localedir)/$$x/LC_MESSAGES; \
	    mv $(localedir)/$$x/LC_MESSAGES/$(name)_$$x.mo $(localedir)/$$x/LC_MESSAGES/$(name).mo ; \
	  fi; \
	done
	@echo "done."

uninstall:
	@echo -n Removing message files...
	@for x in $(languages); do \
	  if [ -e $(name)_$$x.mo ]; \
	  then \
	    $(rm) $(localedir)/$$x/LC_MESSAGES/$(name).mo; \
	  fi; \
	done
	@echo "done."


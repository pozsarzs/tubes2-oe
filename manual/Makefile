# +----------------------------------------------------------------------------+
# | Tubes2 2.0.2 trial * Electrontube catalogue                                |
# | Copyright (C) 2008-2015 Pozsar Zsolt <pozsarzs@gmail.com>                  |
# | Makefile                                                                   |
# | Make file                                                                  |
# +----------------------------------------------------------------------------+

include ../Makefile.global

languages = en hu

all:

clean:

install:
	@echo -n Installing manual files...
	@for x in $(languages); do \
	  if [ -e $(name)_$$x.7 ]; \
	  then \
	    $(install) --directory $(mandir)/$$x/man7; \
	    $(install) --mode $(txtmode) $(name)_$$x.7 $(mandir)/$$x/man7; \
	    mv $(mandir)/$$x/man7/$(name)_$$x.7 $(mandir)/$$x/man7/$(name).7 ; \
	  fi; \
	done
	@$(install) --directory $(mandir)/man7;
	@mv $(mandir)/en/man7/* $(mandir)/man7
	@rmdir $(mandir)/en/man7/
	@rmdir $(mandir)/en
	@for x in $(languages); do \
	  if [ -e xedf_$$x.5 ]; \
	  then \
	    $(install) --directory $(mandir)/$$x/man5; \
	    $(install) --mode $(txtmode) xedf_$$x.5 $(mandir)/$$x/man5; \
	    mv $(mandir)/$$x/man5/xedf_$$x.5 $(mandir)/$$x/man5/xedf.5 ; \
	  fi; \
	done
	@for x in $(languages); do \
	  if [ -e cxedf_$$x.5 ]; \
	  then \
	    $(install) --directory $(mandir)/$$x/man5; \
	    $(install) --mode $(txtmode) cxedf_$$x.5 $(mandir)/$$x/man5; \
	    mv $(mandir)/$$x/man5/cxedf_$$x.5 $(mandir)/$$x/man5/cxedf.5 ; \
	  fi; \
	done
	@$(install) --directory $(mandir)/man5;
	@mv $(mandir)/en/man5/* $(mandir)/man5
	@rmdir $(mandir)/en/man5/
	@rmdir $(mandir)/en
	@echo "done."

uninstall:
	@echo -n Removing manual files...
	@for x in $(languages); do \
	  if [ -e $(name)_$$x.7 ]; \
	  then \
	    $(rm) $(mandir)/$$x/man7/$(name).7; \
	  fi; \
	done
	@$(rm) $(mandir)/man7/$(name).7;
	@for x in $(languages); do \
	  if [ -e xedf_$$x.5 ]; \
	  then \
	    $(rm) $(mandir)/$$x/man5/xedf.5; \
	    $(rm) $(mandir)/$$x/man5/cxedf.5; \
	  fi; \
	done
	@$(rm) $(mandir)/man5/xedf.5;
	@$(rm) $(mandir)/man5/cxedf.5;
	@echo "done."


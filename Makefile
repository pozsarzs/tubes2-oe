# +----------------------------------------------------------------------------+
# | Tubes2 2.1.1 trial * Electrontube catalogue                                |
# | Copyright (C) 2008-2016 Pozsar Zsolt <pozsarzs@gmail.com>                  |
# | Makefile                                                                   |
# | Makefile                                                                   |
# +----------------------------------------------------------------------------+

include ./Makefile.global

dirs1 =	source
dirs2 =	desktop documents/hu documents help languages library manual source

all:
	@echo Compiling $(name):
	@for dir in $(dirs1); do \
	  if [ -e Makefile ]; then make -s -C $$dir all; fi; \
	done
	@echo "Source code is compiled."

clean:
	@for dir in $(dirs1); do \
	  if [ -e Makefile ]; then make -s -C $$dir clean; fi; \
	done
	@echo "Source code is cleaned."

install:
	@echo Installing $(name):
	@for dir in $(dirs2); do \
	  if [ -e Makefile ]; then make -s -C $$dir install; fi; \
	done
	@echo "Application is installed."

uninstall:
	@echo Removing $(name):
	@for dir in $(dirs2); do \
	  if [ -e Makefile ]; then make -s -C $$dir uninstall; fi; \
	done
	@echo "Application is removed."


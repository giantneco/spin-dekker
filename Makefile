SUBDIR = nolock prototype1 prototype2 prototype3 prototype4 dekker

all:
	for dir in $(SUBDIR); do \
		(cd $$dir && $(MAKE) $@) || exit 1; \
	done

clean: 
	for dir in $(SUBDIR); do \
		(cd $$dir && $(MAKE) $@) \
	done

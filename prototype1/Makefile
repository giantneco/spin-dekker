.PHONY: all clean run trail

.SUFFIXES:

CPPFLAGS =
CFLAGS = 

all: pan.isExclusive pan.isCooperative pan.isFare pan

pan: pan.c
	gcc $(CPPFLAGS) $(CFLAGS) -o $@ $<
pan.isExclusive: pan1.c
	gcc $(CPPFLAGS) $(CFLAGS) -o $@ $<
pan.isCooperative: pan2.c
	gcc $(CPPFLAGS) $(CFLAGS) -o $@ $<
pan.isFare: pan3.c
	gcc $(CPPFLAGS) $(CFLAGS) -o $@ $<

pan.c: main.pml
	spin -a main.pml

pan1.c: main.pml
	spin -N ../exclusive.rule -a main.pml
	mv pan.c pan1.c

pan2.c: main.pml
	spin -N ../cooperation.rule -a main.pml
	mv pan.c pan2.c

pan3.c: main.pml
	spin -N ../faireness.rule -a main.pml
	mv pan.c pan3.c

clean:
	rm -f pan* *.trail

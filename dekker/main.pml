#include "../common.pml"
#include "../never.pml"

int favored = 1;
int Thread1WantsToEnter = 0;
int Thread2WantsToEnter = 0;

active proctype Thread1() {
  do
    :: Thread1WantsToEnter = 1;
       do
	 :: Thread2WantsToEnter != 1 -> break;
	 :: Thread2WantsToEnter == 1 ->
	    if
	      :: favored == 2 ->
		 Thread1WantsToEnter = 0;
		 favored == 2; /* spin wait */
		 Thread1WantsToEnter = 1;
	    fi
       od;
       CriticalSection1();
       favored = 2;
       Thread1WantsToEnter = 0;
       skip;
  od;
}

active proctype Thread2() {
  do
    :: Thread2WantsToEnter = 1;
       do
	 :: Thread1WantsToEnter != 1 -> break;
	 :: Thread1WantsToEnter == 1 ->
	    if
	      :: favored == 1 ->
		 Thread2WantsToEnter = 0;
		 favored == 1; /* spin wait */
		 Thread2WantsToEnter = 1;
	    fi
       od;
       CriticalSection2();
       Thread2WantsToEnter = 0;
       skip;
  od;
}

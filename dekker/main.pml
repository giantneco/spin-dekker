#include "../common.pml"

int favored = 1;
int Thread1WantsToEnter = 0;
int Thread2WantsToEnter = 0;

active proctype Thread1() {
  do
    :: Thread1WantsToEnter = 1;
       do
	 :: Thread2WantsToEnter == 1 -> {
	   if
	     :: favored == 2 ->
		Thread1WantsToEnter = 0;
		favored != 2; /* spin wait */
		/* atomic { Locked1(); d_step { favored != 2; state1 = OUT } };/\* spin wait *\/ */
		/* atomic { Locked1(); favored != 2};/\* spin wait *\/ */
		Thread1WantsToEnter = 1;
	   fi
	 }
	 :: else -> break
       od;
       CriticalSection1();
       favored = 2;
       Thread1WantsToEnter = 0;
  od;
}

active proctype Thread2() {
  do
    :: Thread2WantsToEnter = 1;
       do
	 :: Thread1WantsToEnter == 1 -> {
	   if
	     :: favored == 1 ->
		Thread2WantsToEnter = 0;
		favored != 1; /* spin wait */
		/* atomic { Locked2(); d_step { favored != 1; state2 = OUT } };/\* spin wait *\/ */
		/* atomic { Locked2(); favored != 1};/\* spin wait *\/ */
		Thread2WantsToEnter = 1;
	   fi
	 }
	 :: else -> break
       od;
       CriticalSection2();
       favored = 1;
       Thread2WantsToEnter = 0;
  od;
}

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
		atomic { Locked1(); d_step { favored == 1; state1 = OUT } };/* spin wait */
		Thread1WantsToEnter = 1;
	   fi
	 }
	 :: else -> break
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
	 :: Thread1WantsToEnter == 1 -> {
	   if
	     :: favored == 1 ->
		Thread2WantsToEnter = 0;
		atomic { Locked2(); d_step { favored == 2; state2 = OUT } };/* spin wait */
		Thread2WantsToEnter = 1;
	   fi
	 }
	 :: else -> break
       od;
       CriticalSection2();
       favored = 1;
       Thread2WantsToEnter = 0;
       skip;
  od;
}

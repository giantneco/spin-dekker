#include "../common.pml"

int Thread1WantsToEnter = 0;
int Thread2WantsToEnter = 0;

active proctype Thread1() {
  do
    :: Thread1WantsToEnter = 1;
       do
	 :: Thread2WantsToEnter != 1 -> break;
	 :: Thread2WantsToEnter == 1 ->
	    Thread1WantsToEnter = 0;
	    skip;
	    Thread1WantsToEnter = 1;
       od;
       CriticalSection1();
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
	    Thread2WantsToEnter = 0;
	    skip;
	    Thread2WantsToEnter = 1;
       od;
       CriticalSection2();
       Thread2WantsToEnter = 0;
       skip;
  od;
}
#include "../common.pml"

int Thread1WantsToEnter = 0;
int Thread2WantsToEnter = 0;

inline delay_random() { skip }; /* Cannot implement! */

active proctype Thread1() {
  do
    :: Thread1WantsToEnter = 1;
       do
	 :: atomic {Thread2WantsToEnter != 1; CriticalSection1()} -> break;
	 :: atomic {Locked1(); Thread2WantsToEnter == 1} ->
	    Thread1WantsToEnter = 0;
	    delay_random();
	    Thread1WantsToEnter = 1;
       od;
       Thread1WantsToEnter = 0;
       skip;
  od;
}

active proctype Thread2() {
  do
    :: Thread2WantsToEnter = 1;
       do
	 :: atomic {Thread1WantsToEnter != 1; CriticalSection2()} -> break;
	 :: atomic {Locked2(); Thread1WantsToEnter == 1} ->
	    Thread2WantsToEnter = 0;
	    delay_random();
	    Thread2WantsToEnter = 1;
       od;
       Thread2WantsToEnter = 0;
       skip;
  od;
}

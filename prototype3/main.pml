#include "../common.pml"

int Thread1WantsToEnter = 0;
int Thread2WantsToEnter = 0;

active proctype Thread1() {
  do
    :: Thread1WantsToEnter = 1;
       atomic { Locked1() ; Thread2WantsToEnter == 0};
       CriticalSection1();
       Thread1WantsToEnter = 0;
  od;
}

active proctype Thread2() {
  do
    :: Thread2WantsToEnter = 1;
       atomic { Locked2() ; Thread1WantsToEnter == 0};
       CriticalSection2();
       Thread2WantsToEnter = 0;
  od;
}

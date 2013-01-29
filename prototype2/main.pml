#include "../common.pml"

int Thread1Inside = 0;
int Thread2Inside = 0;

active proctype Thread1() {
  do
    :: do
	 :: atomic { Locked1() ; Thread2Inside != 1} -> break;
       od;
       Thread1Inside = 0;
       CriticalSection1();
       Thread1Inside = 1;
       skip;
  od;
}

active proctype Thread2() {
  do
    :: do
	 :: atomic { Locked2() ; Thread1Inside != 1} -> break;
       od;
       Thread2Inside = 0;
       CriticalSection2();
       Thread2Inside = 1;
       skip;
  od;
}

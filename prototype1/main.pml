#include "../common.pml"

int current = 0;
int op1 = 0;

active proctype Thread1() {
  do
    :: atomic{ Locked1(); current == 0} ->
       CriticalSection1();
       current = 1;
       OtherStuf1();
  od;
}

active proctype Thread2() {
  do
    :: atomic{ Locked2(); current == 1} ->
       CriticalSection2();
       current = 0;
       OtherStuf2();
  od;
}

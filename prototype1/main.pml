#include "../common.pml"

int current = 0;
int op1 = 1;
int op2 = 1;

active proctype Thread1() {
  do
    :: current == 0 ->
       CriticalSection1();
       current = 1;
       OtherStuf1();
       break;
    :: Locked1();
  od;
}

active proctype Thread2() {
  do
    :: current == 1 ->
       CriticalSection2();
       current = 0;
       OtherStuf2();
    :: Locked2();
  od;
}

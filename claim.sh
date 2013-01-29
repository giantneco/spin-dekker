#!/bin/sh

rm -f *rule
spin -f '!(([] !( insideCriticalSection1 && insideCriticalSection2)))' >> exclusive.rule
spin -f '!( [] (( outsideCriticalSection2 && X outsideCriticalSection2) -> (X (! isLocked1))))' >> cooperation.rule
spin -f '!(([] <> insideCriticalSection1))' >> fairness.rule

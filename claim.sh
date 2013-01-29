#!/bin/sh

spin -f '!(([] !( insideCriticalSection1 && insideCriticalSection2)))' >> exclusive.rule
spin -f '!( [] (( outsideCriticalSection2 && X ! insideCriticalSection2) -> (X (! isLocked1))))' >> cooperation.rule
spin -f '!(([] <> insideCriticalSection1))' >> faireness.rule

mtype = {IN, OUT, LOCKED};

mtype state1 = OUT;
mtype state2 = OUT;

inline CriticalSection1() {state1 = IN; skip; state1 = OUT}
inline CriticalSection2() {state2 = IN; skip; state2 = OUT}

inline Locked1() {state1 == LOCKED;}
inline Locked2() {state2 == LOCKED;}

inline OtherStuf1() { skip; skip; skip;}
inline OtherStuf2() { skip; skip; skip;}

#define insideCriticalSection1 (state1 == IN)
#define insideCriticalSection2 (state2 == IN)

#define outsideCriticalSection1 (state1 == OUT)
#define outsideCriticalSection2 (state2 == OUT)

#define isLocked1 (state1 == LOCKED)
#define isLocked2 (state2 == LOCKED)


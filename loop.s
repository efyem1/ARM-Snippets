; Looping in ARM is quite simple. Similar to if statements, you
; can check the opposite of the loop condition, and branch out
; of it if its true. At the end of each loop iteration, you want
; branch back to the condition.

; For loops can be broken down into while loops, with 3 distinct
; sections: initialistion, loop condition, updating.
; for (int i = 0; i < 20; i++) { // Some code }
; can be turned into:
; int i = 0;
; while (i < 10) {
;    // Some code
;    i++;
; }



; while (true) {
;     // Code A
; }
; // Code B

; Infinite loops are trivial in ARM
loop
        ; Code A
        B loop

        ; Code B

; while (a != 13) {
;     // Code A
; }
; // Code B

cond    CMP a, #13
        BEQ endloop
        ; Code A
        B cond
endloop
        ; Code B


; for (int i = 32; i >= 0; i--) {
;     // Code A
; }
; // Code B

        MOV R1, #32
cond    CMP R1, #0
        BLT endloop
        ; Code A
        SUB R1, R1, #1
        B cond
endloop 
        ; Code B



; do {
;     // Code A
; } while (b > 4);
// Code B

; This time we can check the actual condition
do
        ; Code A
        CMP R1, #4
        BGT do

        ; Code B



; Imitating the behaviour of 'break' is quite simple. We just
; need to branch out of the loop

; while (a != 5) {
;     ...
;     if (b == 7) { break; }
;     ...
; }
; // More code

cond    CMP R1, #5
        BEQ endloop
        ; ...
        CMP R2, #7
        BEQ endloop
        ; ...
        B cond
endloop
        ; More code



; Imitating the behaviour of 'continue' is also quite simple.
; Instead of branching out of the loop, we branch back to the
; condition. In the case of for loops, we must execute the update
; section first.

; while (a != 5) {
;     // Code A
;     if (b == 7) { continue; }
;     // Code B
; }
; // Code C

cond    CMP R1, #5
        BEQ endloop
        ; Code A
        CMP R2, #7
        BEQ cond
        ; Code B
        B cond
endloop
        ; Code C



; for (int i = 32; i >= 0; i--) {
;     // Code A
;     if (a == 23) { continue; }
;     // Code B
; }
; // Code B

        MOV R1, #32
cond    CMP R1, #0
        BLT endloop
        ; Code A
        CMP R2, #23
        BEQ update
        ; Code B
update  SUB R1, R1, #1
        B cond
endloop 
        ; Code C
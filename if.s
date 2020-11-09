; These snippets are for situations, where an if satement contains
; more than one line of code. For simpler cases, like conditional
; assignments, just use conditonal instructions (e.g. MOVEQ R1, #4)

; if (a < 10) {
;     // Code A
; }
; // Code B

; Check the opposite condition, and skip the code if its true
; If its false, then 'Code A' is executed, followed by 'Code B'
if      CMP R1, #10
        BGE endif
        ; Code A

endif
        ; Code B



; if (a < 10) {
;     // Code A
; }
; else {
;     // Code B
; }
; // Code C

; This time, we want to skip execution of 'Code B', if
; 'a' IS less than 10. Still checking opposite condition
if      CMP R1, #10
        BGE else
        ; Code A
        B endif  ; Don't want 'Code B' to execute
else
        ; Code B
endif
        ; Code C



; if (a < 10) {
;     // Code A
; }
; else if (a == 20) {
;     // Code B
; }
; // Code C

if      CMP R1, #10
        BGE elseif
        ; Code A
        B endif
elseif  CMP R1, #20
        BNE endif
        ; Code B
endif   
        ; Code C



; if (a < 10) {
;     // Code A
; }
; else if (a == 20) {
;     // Code B
; }
; else if (b >= 8) {
;     // Code C
; }
; else {
;     // Code D
; }
; // Code E

if      CMP R1, #10
        BGE elseif0
        ; Code A
        B endif
elseif0 CMP R1, #20
        BNE elseif1
        ; Code B
        B endif
elseif1 CMP R2, #8
        BLT endif
        ; Code C
        B endif
else 
        ; Code D
endif   
        ; Code E
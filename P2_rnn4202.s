    .global main
    .func main

main:
    BL _scanf              
    MOV R4, R0                          
    BL _scanf              
    MOV R5, R0 
    MOV R1, R4
    MOV R2, R5                    
    BL  _count_partitions  
    MOV R1, R6            
    MOV R2, R4           
    MOV R3, R5            
    BL  _printf             
    B   main               
_scanf:
    PUSH {LR}               @ store the return address
    PUSH {R1}               @ backup regsiter value
    LDR R0, =format_str     @ R0 contains address of format string
    SUB SP, SP, #4          @ make room on stack
    MOV R1, SP              @ move SP to R1 to store entry on stack
    BL scanf                @ call scanf
    LDR R0, [SP]            @ load value at SP into R0
    ADD SP, SP, #4          @ remove value from stack
    POP {R1}                @ restore register value
    POP {PC}                @ restore the stack pointer and return
_printf:
    PUSH {LR}               @ store the return address
    LDR R0, =printf_str     @ R0 contains formatted string address
    MOV R1, R1              @ R1 contains printf argument (redundant line)
    BL printf               @ call printf
    POP {PC}                @ restore the stack pointer and return

_count_partitions:
    PUSH {LR}              
    CMP R1, #0        
    MOVEQ R0, #1          
    POPEQ {PC}              
    CMP R1, #0          
    MOVLT R0, #0         
    POPLT {PC}           
    CMP R2, #0        
    MOVEQ R0, #0           
    POPEQ {PC}             
    PUSH {R1}            
    PUSH {R2} 		   
    SUB R1, R1, R2          
    BL _count_partitions    
    POP {R2}           
    POP {R1}               
    PUSH {R0}           
    SUB R2, R2, #1         
    BL _count_partitions  
    MOV R10, R0           
    POP {R0}              
    ADD R0, R0, R10        
    POP  {PC}              

.data
format_str:     .asciz      "%d"
printf_str:     .asciz      "There are %d partitions of %d using integers upto %d . \n"
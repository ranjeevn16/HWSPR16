@ Name : Ranjeev Neurekar
@ID:1001104202
@ Program #3 to generate array and dispay in ascending order

        .global main
	.func main
	
main:
	BL _scanf
	MOV R4, R0		@ input value n will be stored in R4
	MOV R0, #0		@ initialize value of i to 0 in R0
	BL _generate
	MOV R0, #0		@ initialize value of i to 0 in R0	
	BL _sortorder
	MOV R0, #0              @ initialize value of i to 0 in R0
	BL _printarrays
	BL _minmax
	B _exit
	
_scanf:
	PUSH {LR}
    	SUB SP, SP, #4          @ make room on stack
    	LDR R0, =format_str     @ R0 contains address of format string
    	MOV R1, SP              @ move SP to R1 to store entry on stack
    	BL scanf                @ call scanf
    	LDR R0, [SP]            @ load value at SP into R0
    	ADD SP, SP, #4          @ restore the stack pointer
    	POP {PC}	        @ return
	
_generate:
	CMP R0, #10		@ check to see if we are done iterating
	MOVEQ PC,LR		@ exit loop if done
	LDR R1, =array_a	@ get address of a
	LSL R2, R0, #2		@ multiply index * 4 to get array offset
	ADD R2, R1, R2		@ R2 now has the element address
	LDR R3, =array_b	@ get address of b
	LSL R5, R0, #2		@ multiply index * 4 to get array offset
	ADD R5, R3, R5		@ R5 now has the element address
	PUSH {R0}
	PUSH {R1}
	MOV R6, R0
	ADD R10, R10, R6
	POP {R1}
	POP {R0}		@ restore register
	STR R6, [R2]
	STR R6, [R5]
	ADD R0, R0, #1		@ increment index 
	B _generate	
	
_printarrays:
	CMP R0, #0
	PUSHEQ {LR}
	CMP R0, #20		@ check to see if we are done iterating
	POPEQ {PC}		@ exit loop if done
	LDR R1, =array_a	@ get address of a
	LDR R3, =array_b	
	LSL R2, R0, #2		@ multiply index * 4 to get array offset
	LSL R5, R0, #2		@ multiply index * 4 to get array offset
	ADD R2, R1, R2		@ R2 now has the element address
	ADD R5, R3, R5		@ R5 now has the element address
	LDR R1, [R2]		@ read the array at address
	LDR R3, [R5]		@ read the array at address
	PUSH {R0} 		@ backup register before printf
	PUSH {R1}		@ backup register before printf
	PUSH {R2} 		@ backup register before printf
	PUSH {R3}	        @ backup register before printf
	MOV R2, R1		@ move array value to R2 for printf
	MOV R1, R0		@ move array index to R1 for printf
	BL _printA		@ branch to _printA 
	POP {R3}		@ restore register
	POP {R2}		@ restore register
	POP {R1}		@ restore register
	POP {R0}		@ restore register		
	ADD R0, R0, #1		@ increment index
	B _printarrays
	MOV R1,R10
	BL _printsum
_sortorder:
	PUSH {LR}
loop1:
	CMP R0, #9	
	POPEQ {PC} 
	LDR R3, =array_b	
	LSL R2, R0, #2   	
	ADD R2, R3, R2
	LDR R2, [R2]		
	PUSH {R2}
	ADD R1, R0, #1		
loop2:
	CMP R1, #10
	BEQ sort
	LSL R7, R1, #2
	ADD R7, R3, R7
	LDR R7, [R7]		 		
	CMP R7, R2		
	MOVLT R2, R7	
	MOVLT R10, R1		
	ADD R1, R1, #1
	B loop2
sort:
	POP {R5}
	CMP R2, R5
	MOV R8, R2
	MOV R2, R5
	MOV R5, R8
	LSL R11, R0, #2
	ADD R11, R11, R3
	STR R5, [R11]
	LSL R9, R10, #2
	ADD R9, R9, R3
	STR R2, [R9]
	ADD R0, R0, #1
	B loop1
_minmax:
	PUSH {LR}
	LDR R3, =array_b
	ADD R7, R3, #0	
	LDR R8, [R7]		
	PUSH {R7}
	PUSH {R3}
	MOV R1, R8	
	LDR R0, =print_min
	BL _printmin		
	POP {R3}
	POP {R7}
	ADD R7, R7, #36
	LDR R9, [R7]
	MOV R1, R9
	LDR R0, =print_max
	BL printmax
	POP {PC}
_printA:
	PUSH {LR}		@ store the return address
	LDR R0, =print_strA	@ R0 contains formatted string address
	BL printf		@ call printf
	POP {PC}		@ restore the stack pointer and return
_printsum:
	PUSH {LR}		@ store the return address
	LDR R0, =print_sum	@ R0 contains formatted string address
	BL printf		@ call printf
	POP {PC}		@ restore the stack pointer and return
_printmin:
   	PUSH {LR}               @ store the return address
    	LDR R0, =print_min      @ R0 contains formatted string address
    	BL printf               @ call printf
    	POP {PC}                @ restore the stack pointer and return

_printmax:
	PUSH {LR}               @ store the return address
    	LDR R0, =print_max      @ R0 contains formatted string address
    	BL printf               @ call printf
    	POP {PC}                @ restore the stack pointer and return
_exit:
	MOV R7, #4		@ write syscall, 4
	MOV R0, #1		@ output stream to monitor, 1
	MOV R2, #21		@ print string length
	LDR R1, =exit_str 	@ string at label exit_str:
	SWI 0			@ execute syscall
	MOV R7, #1		@ terminate syscall, 1
	SWI 0			@ execute syscall
.data

.balign	4
array_a:	.skip		200
array_b:	.skip		200
print_strA: 	.asciz		"a[%d] = %d,"
print_sum:	.asciz		"sum = %d\n"
print_min:      .asciz		"minimum = %d\n"
print_max:      .asciz		"maximum = %d\n"
exit_str:	.ascii		"Exiting program.\n"
format_str:	.asciz		"%d"
@ Name: Ranjeev Neurekar
@ ID Number: 1001104202



.global main
.func main

 main:
	BL _prompt1	
	BL _scanf             
	MOV R4,R0
	BL _prompt2
	BL _getchar
    	MOV R5, R0           
	BL _prompt1		
	BL _scanf
	MOV R6, R0
	MOV R1, R4
	MOV R2, R5
	MOV R3, R6
	BL _compare
	MOV R1, R0
    	BL _printf   
      	B main

_prompt1 :
    	MOV R7, #4           
    	MOV R0, #1            
    	MOV R2, #31           
    	LDR R1, =prompt_str    
    	SWI 0                  
    	MOV PC, LR             

_scanf:
	SUB SP, SP, #4         
    	LDR R0, =format_str    
    	MOV R1, SP             
    	BL scanf              
    	LDR R0, [SP]           
    	ADD SP, SP, #4          
    	MOV PC, LR

_prompt2 :
    	MOV R7, #4            
    	MOV R0, #1           
    	MOV R2, #31            
    	LDR R1, =prompt2_str     
    	SWI 0                  
    	MOV PC, LR              

_getchar:
    	MOV R7, #3              
    	MOV R0, #0            
    	MOV R2, #1             
    	LDR R1, =read_char     
    	SWI 0                 
    	LDR R0, [R1]            
    	AND R0, #0xFF          
    	MOV PC, LR              
	
_compare:
	CMP  R2, #'+'		
	BEQ _sum		
	CMP  R2, #'-'		
        BEQ _sub		
	CMP  R2, #'*'		
        BEQ _mul	
	CMP  R2, #'M'
        BEQ _max	
	MOV  PC, LR	
	
_sum:      
        ADD R0,R1, R3     
        MOV PC, LR    
     
_sub:
	SUB R0, R1, R3         
        MOV PC, LR     
 
_mul        
        MUL R0,R1, R3  
        MOV PC, LR   
     
_max:
	CMP R1,R3
	MOVLE R1,R3
	MOV PC, LR

_print_val:
        MOV R4, LR        
        LDR R0,=result_str
	MOV R1, R1            
        BL printf         
        MOV LR, R4          
        MOV PC, LR          

.data
format_str:
.asciz	"%d"
prompt_str:
.ascii	"Enter the number : "
prompt2_str:
.ascii	"Enter enter a symbol from +, _, *, M : "
read_char:
.ascii " "
result_str:     
.asciz "The answer is : %d\n"

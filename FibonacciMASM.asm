	

    TITLE CS271 Program 2    (Program2holkeboj.asm)
     
     ; Author: Jack Holkeboer
     ; CS271 Program #2                Date: 1/23/15
     ; Description: Program for counting Fibonacci sequence up to a 
	; user-defined n.
     
    INCLUDE Irvine32.inc  ;requires Irvine32 MASM libraries
     
    ; (insert constant definitions here)
	UPPERLIMIT 	EQU		<47>		;definition of constant for maximum n
     
    .data
     
    ; (insert variable definitions here)	
     n					DWORD	?	;user-defined n, the number of Fibonacci iterations
	username		DWORD	?	;string input for user's name
	
	
	total				DWORD	?	;holds fibonacci number for current step
	prev				DWORD	?	;holds fibonacci number for previous step
	step				WORD	0	;track steps of sequence	
	
	; pre-defined string messages to print to console
	msg_title		BYTE	"Fibonacci Calculator",0
	msg_author		BYTE	"Programmed by Jack Holkeboer",0
	
	
	msg_q1			BYTE	"What is your name? ",0
	msg_hello		BYTE	"Hello, ",0
	
	msg_inst1		BYTE	"Enter the number of Fibonacci terms you want to calculate.",0
	msg_inst2		BYTE	"Your input should be an integer between 1 and 46.",0
	msg_q2			BYTE	"How many Fibonacci terms do you want? ",0
	
	msg_error		BYTE	"Out of range. Please enter an integer between 1 and 46: ",0
	
	msg_tab			BYTE	"     ",0
	
	msg_bye1		BYTE	"Results certified by Jack Holkeboer",0
	msg_bye2		BYTE	"Goodbye, ",0
	
     
    .code
    main PROC
    
;introduction
		mov		edx, OFFSET msg_title
		call		WriteString
		call		CrLf
		
		mov		edx, OFFSET msg_author
		call		WriteString
		call		CrLf
		call		CrLf
		
		;print "What is your name?"
		mov		edx, OFFSET msg_q1
		call		WriteString
		
		;get string input
		mov		edx, OFFSET username	; location to store string input
		mov		ecx, 50						; maximum string length
		call		ReadString
		
		;print Hello
		call		CrLf
		mov		edx, OFFSET msg_hello
		call		WriteString
		
		;print user's name
		mov		edx, OFFSET username
		call 		WriteString
		call 		CrLf
		
	
	;userInstructions
		mov		edx, OFFSET msg_inst1
		call		WriteString
		call		CrLf
		mov		edx, OFFSET msg_inst2
		call		WriteString
		call		CrLf
		

	
;getUserData
GETINPUT:	
		mov		edx, OFFSET msg_q2
		call		WriteString
	
		mov		eax, 0
		call		ReadInt		;read integer from user
		mov		n, eax		;store user input in n
		dec		n				;subtract 1 from n
		
		;validate upper limit
		mov		ebx, UPPERLIMIT
		cmp		eax, ebx
		jnb		ERROR		;jump if n is not below 47
		
		;validate lower limit
		cmp		n, 0
		jbe		ERROR		;jump if n is below or equal to zero
		
		
		;if nothing triggers a jump to ERROR, program will continue at INPUTSUCCESS
		jmp		INPUTSUCCESS	
		
	ERROR:
		mov		edx, OFFSET msg_error		;print error message
		call		WriteString
		call		CrLf
		jmp		GETINPUT						;try getting input again
		

		
		
INPUTSUCCESS:
;displayFibs
		;reset registers
		mov		eax, 0
		mov		ebx, 0
		mov		ecx, 0
		
		mov		ecx, n				;set loop counter
		mov		total, 1
		mov		prev, 0
		
		;print first Fib. number
		mov		  eax, total
		call		WriteDec
		mov		  edx, OFFSET msg_tab
		call		WriteString
		
		
	PRINTLOOP:
		;calculate next Fib. number
		mov		eax, total
		mov		ebx, total
		
		add		eax, prev		  ;add previous value
		mov		prev, ebx		  ;put old total in prev
		mov		total, eax		;put new total in total variable
		
		;print next Fib. number
		call		WriteDec			;print total value which is currently in eax
		mov		  edx, OFFSET msg_tab
		call		WriteString		;print tab after each number
		inc		  step				  ;increment step variable
		
		;check to see if it's time to change lines
		mov		  ax, step
		mov		  bl, 5
		div		  bl
		cmp		  AH, 0				;compare remainder with zero
		jz			LINESKIP		;If remainder is zero, go to LINESKIP
		
		loop		PRINTLOOP		;go back to PRINTLOOP if ecx != 0

;farewell
		;print "Results certified..."
		call		CrLf
		mov		  edx, OFFSET msg_bye1
		call		WriteString
		call		CrLf
		
		;print "Goodbye, "
		mov		  edx, OFFSET msg_bye2
		call		WriteString
		
		;print user's name
		mov		  edx, 0						    ;reset edx
		mov		  edx, OFFSET username	;move user's name to edx
		call		WriteString					;print user's name
		call		CrLf
		call		CrLf
		jmp		  ENDING
		
LINESKIP:
		call		CrLf			;skip line
		jmp		PRINTLOOP	  ;skips a line and goes back to PRINTLOOP	
		
ENDING:
		
        exit    ; exit to operating system
    main ENDP
     
    ; (insert additional procedures here)
     
    END main

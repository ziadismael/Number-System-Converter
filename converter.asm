.global __start

__start:
	.data
currentSystem: .word    
number:        .space 50  	 # Reserve 50 bytes for the second string
newSystem:     .word    
introductionMessage: .asciiz "Hello, This is Numbering System Converter. Please enter the current system, number and new system: \n"

	.text
main:
    li $v0, 4
    la $a0, introductionMessage
    syscall

    # Read current system
    li $v0, 5       
    syscall
    sw $v0, currentSystem	 # Store the first input in memory

    # Read number
    li $v0, 8       		 
    la $a0, number 	         # Load address of the buffer
    li $a1, 50      		 # Maximum length of the string
    syscall
    
    # Read new system
    li $v0, 5           	
    syscall
    sw $v0, newSystem  		# Store the third input in memory
    
    
    # Exit
    li $v0, 10       # Syscall code for exit
    syscall

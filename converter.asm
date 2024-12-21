.data
	
currentSystem: .word    
number:        .space 50  	 # Reserve 50 bytes for the second string
newSystem:     .word    
introductionMessage: .asciiz "Hello, This is Numbering System Converter. Please enter the current system, number and new system: \n"
currentSystemMsg: .asciiz "Enter The Current System: "
currentNumberMsg: .asciiz "Enter The Number: "
newSystemMsg: .asciiz "Enter The New System: "

.text
.globl main

main:
    la $a0, introductionMessage
    jal printMessage

    # Read current system
    la $a0, currentSystemMsg
    jal printMessage
    li $v0, 5       
    syscall
    sw $v0, currentSystem	 # Store the first input in memory

    # Read number
    la $a0, currentNumberMsg
    jal printMessage
    li $v0, 8       		 
    la $a0, number 	         # Load address of the buffer
    li $a1, 50      		 # Maximum length of the string
    syscall
    
    # Read new system
    la $a0, newSystemMsg
    jal printMessage
    li $v0, 5           	
    syscall
    sw $v0, newSystem  		# Store the third input in memory
    
    
    # Exit
    li $v0, 10       # Syscall code for exit
    syscall
    
printMessage:
    li $v0, 4
    syscall
    jr $ra
    
decimalToOctal:

decimalToHexa:

octalToDecimal:

octalToHexa:

hexaToDecimal:

hexaToOctal:

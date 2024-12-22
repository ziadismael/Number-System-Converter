.data
	
#Variables
currentSystem: .word    
number:        .space 32  	 # Reserve 32 bytes for the number
newSystem:     .word  
newNumber:     .space 32

remainder: .word

#UI Messages  
introductionMessage: .asciiz "Hello, This is Numbering System Converter. Please enter the current system, number and new system: \n"
currentSystemMsg: .asciiz "Enter The Current System: "
currentNumberMsg: .asciiz "Enter The Number: "
newSystemMsg: .asciiz "Enter The New System: "
outputMsg: .asciiz "\nThe Output Number: "

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
    li $a1, 32      		 # Maximum length of the string
    syscall
    
    # Read new system
    la $a0, newSystemMsg
    jal printMessage
    
    li $v0, 5           	
    syscall
    sw $v0, newSystem  		# Store the third input in memory
    
    
    # Load the value of currentSystem into a register
    lw $t0, currentSystem     # Load currentSystem into $t0
    lw $t1, newSystem

    # Check if currentSystem > newSystem
    bgt $t0, $t1, divideByBase
    
    # Check if currentSystem < newSystem
    blt $t0, $t1, multiplyByBase

    # Check if same system -> return number
    beq $t0, $t1, returnNumber


    # Printing The Result
    la $a0, outputMsg
    jal printMessage
    la $a0, newNumber
    jal printMessage
    
    
    
    # Exit
    li $v0, 10                  # Syscall code for exit
    syscall
    
printMessage:
    li $v0, 4
    syscall
    jr $ra


multiplyByBase:
    

divideByBase:
    blez $t0, exit_loop  # checks if the number <= 0    
    
    la $t2, newSystem    # load base to $t2 to be divisor              
    div $t0, $t2               
    mfhi $t3             # move remainder from HI to $t3   HI: remainder, LO: quotient      

    # Check if we've exceeded the buffer size or encountered null terminator
    bge $t1, 32, exit_loop  # Exit if index exceeds buffer size
    lb $t4, newNumber($t1)  # Load the current byte in newNumber
    beq $t4, 0, exit_loop  # Exit if null terminator is encountered
    
    addi $t3, $t3, 48    # convert it to ascii chars 0 + 48 = '0'
    sb $t3, newNumber($t1)# add remainder to arr of quotient (the new number)
         
    addi $t1, $t1, 1     # increment counter at $t1      
    mflo $t0             # number = number / newSystem     

    #loop again
    j divideByBase

exit_loop:
    jr $ra

returnNumber:
    # Load the value of 'number' into a register (e.g., $t0)
    lw $t0, number          # Load value of 'number' into register $t0
    
    # Store the value in $t0 (which is 'number') into 'newNumber'
    sw $t0, newNumber       # Store value of $t0 into 'newNumber'
    
    jr $ra

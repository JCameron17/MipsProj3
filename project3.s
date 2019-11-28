.data
  myString: .space 10000
  invalid: .asciiz "NaN"
  val1: .word 1     #31^0
  val2: .word 31    #31^1
  val3: .word 961   #31^2
  val4: .word 29791 #31^3

.text
  main:
    li $v0, 8
    la $a0, myString  #ask for user input
    li $a1, 1001      #allocate space for input
    syscall

    #get input ready to split substrings and calculate decimal
    la $s2, myString  #move string to $s2 register
    li $s0, 0
    li $s1, 0

    loadSubstrings:
      la $s0, ($s1)   #substrings

      handleInput:
      la $a0, ($s0)
      la $a1, ($s1)
      jal takeInput
      jal callNested

    takeInput:
      la $s3, ($ra)	      #jump to address in $ra when subprogram finishes
      la $t0, ($a0)	      #load value from $a0 to $t0
      addi $t1, $a1, 0    #store end of user input string
      la $t2, myString   #load beginning of user input string

    #call nested subroutines
    callNested:
  	   lw $t1, ($sp)
  	   addi $sp, $sp, 4
  	   lw $t2, ($sp)
  	   beq $t1, 0, invalidMessage #empty string is invalid

    invalidMessage:
      li $v0, 4
      la $t0, invalid   #load message to print for invalid input

    decideLoop:
      blt $a0, 48, notAccepted  #character with ascii value < 48 is not accepted
      blt $a0, 58, Accepted     #accept digits
      blt $a0, 65, notAccepted  #special characters not accepted
    	blt $a0, 87, Accepted     #accept chars a-v
      blt $a0, 97, notAccepted  #do not accept special characters
      blt $a0, 119, Accepted     #accept characters a-v
      bgt $a0, 118, notAccepted     #characters above V not accepted

    Accepted:
      li $v0, 1         #print integer
      jr $ra

    notAccepted:
      li $v0, 0
      jr $ra

    exit:
      li $v0, 10
      syscall

.data
  myString: .space 10000
  invalid: .asciiz "NaN"

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

    invalidMessage:
      li $v0, 4
      la $t0, invalid   #load message to print for invalid input

    decideLoop:
      blt $a0, 48, notAccepted  #character with ascii value < 48 is not accepted
      blt $a0, 58, Accepted     #accept digits
      blt $a0, 65, notAccepted  #special characters not accepted

    Accepted:
      li $v0, 1         #print integer
      jr $ra

    notAccepted:
      li $v0, 0
      jr $ra

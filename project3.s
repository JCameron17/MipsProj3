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

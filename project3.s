.data
  myString: .space 10000
  invalid: .asciiz "NaN"

.text
  main:
    li $v0, 8
    la $a0, myString  #ask for user input
    li $a1, 1001      #allocate space for input
    syscall

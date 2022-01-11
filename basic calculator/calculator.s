

	.globl	xlessy# Make sure you change the name of this function - see XX function below
	.globl	plus
	.globl	minus
	.globl	mul

# x in edi, y in esi

xlessy: # Change the name of this function to something more descriptive and add a description
	xorl	%eax, %eax
  #sets the returm value 0
	cmpl	%esi, %edi
  #compares x-y > 0 or x-y <0 or ... basically compares x and y
	setl	%al       
  #sets the lowest bit of regiiter return to 0 if x isnt lower but 1 if it is lower than 1
    # See Section 3.6.2 of our textbook for a description of the set* instructions
	ret

# performs integer addition
# Requirement:
plus:
	leal (%edi,%esi), %eax 
  #use leal to add basically x + y goes to register return
	ret
# - you cannot use add* instruction

# performs integer subtraction
# Requirement:
# - you cannot use sub* instruction
# x in edi, y in esi

minus:
  negl %esi
  #makes y negatve makes it the oposite sign
  leal (%edi, %esi), %eax
  #then we plus it
  ret
# x in edi, y in esi
mul:
  movl $0, %eax # eax = 0
  cmpl $0, %esi # y-0 != 0 then call mul
  je .done #if equal its the base case jump to done
  pushq %rbx #pushing a calle saved register since its the calle
  movl %edi, %ebx #ebx or rbx = x

  decl %esi #%esi is caller saved to so it can get updated by calle so we decrease it to get closer to base case y--
  call mul #calls itself
  addl %ebx, %eax #when reaches the base case and pops the return now we add eax = eax + x 
  #eax is caller saved too so it cn be overwriten and save the progress and return 
  popq %rbx
  .done:
    ret
  






  

 # performs integer multiplication - when both operands are non-negative!
# You can assume that both operands are non-negative.
# Requirements:
# - you cannot use imul* instruction 
#   (or any kind of instruction that multiplies such as mul)
# - you must use a loop



# algorithm:
# used jump to middle

# for(int i = y; i !=0; i--) temp = temp * x

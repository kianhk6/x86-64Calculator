	.globl	copy
copy:
# A in rdi, C in rsi, N in edx
	xorl %eax, %eax			# set eax to 0
# since this function is a leaf function, no need to save caller-saved registers rcx and r8
	xorl %ecx, %ecx			# row number i is in ecx -> i = 0
# For each row
rowLoop:
	movl $0, %r8d			# column number j in r8d -> j = 0
	cmpl %edx, %ecx			# loop as long as i - N < 0
	jge doneWithRows

# For each cell of this row
colLoop:
	cmpl %edx, %r8d			# loop as long as j - N < 0
	jge doneWithCells
# Compute the address of current cell that is copied from A to C
# since this function is a leaf function, no need to save caller-saved registers r10 and r11
	movl %edx, %r10d        # r10d = N 
  imull %ecx, %r10d		# r10d = i*N
	addl %r8d, %r10d        # j + i*N
	imull $1, %r10d         # r10 = L * (j + i*N) -> L is char (1Byte)
	movq %r10, %r11			# r11 = L * (j + i*N) 
	addq %rdi, %r10			# r10 = A + L * (j + i*N)
	addq %rsi, %r11			# r11 = C + L * (j + i*N)
# Copy A[L * (j + i*N)] to C[L * (j + i*N)]
	movb (%r10), %r9b       # temp = A[L * (j + i*N)]
	movb %r9b, (%r11)       # C[L * (j + i*N)] = temp
	incl %r8d				# column number j++ (in r8d)
	jmp colLoop				# go to next cell

# Go to next row
doneWithCells:
	incl %ecx				# row number i++ (in ecx)
	jmp rowLoop				# Play it again, Sam!

doneWithRows:				# bye! bye!
	ret
#####################


#####################
	.globl	transpose
transpose:
# C in rdi, N in esi
	xorl %eax, %eax			# set eax to 0
# since this function is a leaf function, no need to save caller-saved registers rcx and r8
	xorl %ecx, %ecx			# row number i is in ecx -> i = 0
# For each row
rowLoop1:
	movl $0, %r8d			# column number j in r8d -> j = 0
	cmpl %esi, %ecx			# loop as long as i - N < 0
	jge doneWithRows1
# For each cell of this row
colLoop1:
	cmpl %ecx, %r8d			# loop as long as j - i < 0
	jge doneWithCells1
# Compute the address of current cell that is copied from A to C
#r11 -> &A[j][i] #r10->&A[i][j]
# since this function is a leaf function, no need to save caller-saved registers r10 and r11
	movl %esi, %r10d        # r10d = N
  movl %esi, %r11d        #r11d = N 

  imull %ecx, %r10d		# r10d = i*N
  imull %r8d, %r11d   #r11d = j*N

	addl %r8d, %r10d        # r10d = j + i*N
  addl %ecx, %r11d        # r11d = i + j*N

	imull $1, %r10d         # r10 = L * (j + i*N) -> L is char (1Byte)
  #since its 1 no need to multiply

	addq %rdi, %r10			# r10 = A + L * (j + i*N)
  addq %rdi, %r11     # r10 = A + L * (i + j*N)

  #swap A[i][j] with A[j][i]
  movb (%r10), %r9b     #r9b = value of %r10 A[i][j]
  movb (%r11), %al     #r8b = value of %r11 A[j][i]
  movb %al, (%r10) 
  movb %r9b, (%r11)
  
	incl %r8d				# column number j++ (in r8d)
	jmp colLoop1				# go to next cell

# Go to next row
doneWithCells1:
	incl %ecx				# row number i++ (in ecx)
	jmp rowLoop1			# Play it again, Sam!

doneWithRows1:				# bye! bye!
	ret

	
  
  .globl	reverseColumns
reverseColumns:
# C in rdi, N in esi
	xorl %eax, %eax			# set eax to 0
# since this function is a leaf function, no need to save caller-saved registers rcx and r8
	xorl %ecx, %ecx			# row number i is in ecx -> i = 0

  

# For each row
rowLoop2:
	movl $0, %r8d			# column number j in r8d -> j = 0
	cmpl %esi, %ecx			# loop as long as i - N < 0
	jge doneWithRows2

# For each cell of this row
colLoop2:
  movl %esi, %edx #edx = N
  sarl $1, %edx #edx = N/2
	cmpl %edx, %r8d			# loop as long as j - N/2 < 0
	jge doneWithCells2

# r11 -> &A[i][N-j-1] r10-> &A[i][j]
# since this function is a leaf function, no need to save caller-saved registers r10 and r11
	movl %esi, %r10d        # r10d = N
  movl %esi, %r11d        #r11d = N 
  imull %ecx, %r10d		# r10d = i*N
  imull %ecx, %r11d   #r11d = i*N

	addl %r8d, %r10d        # r10d = j + i*N
  addl %esi, %r11d        # r11d = N + i*N
  subl $1, %r11d  #%r11d = N -1 + j*N
  subl %r8d, %r11d #%r11d = N-j -1 + j*N
	
  imull $1, %r10d         # r10 = L * (j + i*N) -> L is char (1Byte)

	addq %rdi, %r10			# r10 = A + L * (j + i*N)
  addq %rdi, %r11     # r10 = A + L * (i + j*N)

  #swap A[i][N-j-1] and A[i][j]
  movb (%r10), %r9b     #r9b = value of %r10
  movb (%r11), %al     #r8b = value of %r11
  movb %al, (%r10) 
  movb %r9b, (%r11)

	incl %r8d				# column number j++ (in r8d)
	jmp colLoop2				# go to next cell

# Go to next row
doneWithCells2:
	incl %ecx				# row number i++ (in ecx)
	jmp rowLoop2			# Play it again, Sam!

doneWithRows2:				# bye! bye!
	ret

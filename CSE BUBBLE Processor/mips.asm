# Name: Danish Mehmood
# Roll No.: 210297


.data
AskArraySize: .asciiz "Please input Size of Array: "
AskBucketNumber: .asciiz "Please input Number of Buckets: "
AskArrayValues: .asciiz "Please input values to be stored in the array: "
newline: .asciiz "\n"

.text
.globl main
main:
# Print "Please input Size of Array: "
li $v0, 4      # syscall number 4 will print string whose address is in $a0   
la $a0, AskArraySize      # "load address" of the string
syscall        # actually print the string

# Now read in the size
li $v0, 5      # syscall number 5 will read an int
syscall        # actually read the int
move $s0, $v0  # save result in $s1 for later

# Print "Please input Number of Buckets: "
li $v0, 4      # syscall number 4 will print string whose address is in $a0   
la $a0, AskBucketNumber      # "load address" of the string
syscall        # actually print the string

# Now read in the number
li $v0, 5      # syscall number 5 will read an int
syscall        # actually read the int
move $s1, $v0  # save result in $s1 for later

sll $t0 , $s0 , 2
sub $sp , $sp , $t0
move $s2 , $sp  # address of arr[p]

mul $t0 , $s0 , $s1
sll $t0 , $t0 , 2
sub $sp , $sp , $t0
move $s4 , $sp  # address of mat[n][p]

sll $t0 , $s1 , 2
move $t1 , $sp
sub $sp , $sp , $t0
move $s3 , $sp  # address of size[n]
move $t0 , $sp  
Loop1:  sw $zero, 0($t0)
        addi $t0 , $t0 , 4
        bne $t0 , $t1 , Loop1

# Print "Please input values to be stored in the array: "
li $v0, 4      # syscall number 4 will print string whose address is in $a0   
la $a0, AskArrayValues      # "load address" of the string
syscall        # actually print the string

move $t0, $s2
sll $t1, $s0, 2
add $t1 , $t1, $t0
# $t0:start address of arr(current addresss) $t1:end addres
Loop2:  li $v0, 6
        syscall # $f0 has value of arr[i]
        swc1 $f0, 0($t0)

        # Code to multiply $f0 and $s1, store in $t2
        # $t2: b_no
        mtc1 $s1, $f1
        cvt.s.w $f1, $f1        #convert $s1 to float and store in $f1. $f1=n
        mul.s $f3, $f0, $f1     #$f3 = arr[i]*n
        trunc.w.s $f3, $f3
        mfc1 $t2, $f3

        mul $t3, $t2, $s0       #$t3= b_no*p
        sll $t2, $t2, 2         #$t2=4*b_n0
        add $t2, $t2, $s3       #$t2=size+4*b_no
        lw $t4, 0($t2)          #$t4=curr_size
        add $t3, $t3, $t4       #$t3=b_no*p + curr_size
        sll $t3, $t3, 2
        add $t3, $t3, $s4       #$t3=mat+4*(b_no*p + curr_size)
        swc1 $f0, 0($t3)
        addi $t4,$t4,1
        sw $t4, 0($t2)

        addi $t0, $t0, 4

        bne $t0, $t1 , Loop2

move $t0, $zero
Loop3:  sll $t2, $t0, 2         # $t2 = 4i
        add $t3, $s3, $t2       # $t3 = size+4i
        lw $a1, 0($t3)          # $a1 = *(size+4i)
        mul $t2, $t2, $s0       # $t2 = 4i*p
        add $a0, $s4, $t2       # $a0 = mat+4*i*p
        
        addi $sp, $sp, -24
        sw $s0, 20($sp)
        sw $s1, 16($sp)
        sw $s2, 12($sp)
        sw $s3, 8($sp)
        sw $s4, 4($sp)
        sw $t0, 0($sp)        

        jal insertion_sort

        lw $s0, 20($sp)
        lw $s1, 16($sp)
        lw $s2, 12($sp)
        lw $s3, 8($sp)
        lw $s4, 4($sp)
        lw $t0, 0($sp) 
        addi $sp, $sp, 24  

        addi $t0, $t0, 1
        slt $t1, $t0, $s1	# $t1 = ($t0 < $s1) ? 1 : 0
        bne $t1, $zero, Loop3

move $t0, $zero #$t0=i
move $t1, $s2   #$t1 = ptr of arr

Loop4:  sll $t2, $t0, 2         #$t2=4i
        add $t3, $t2, $s3       #$t3=size+4i
        lw $t4, 0($t3)          #$t4=size[i]
        sll $t4, $t4, 2
        mul $t2, $t2, $s0       #$t2=4*i*p
        add $t2, $t2, $s4       #$t2=mat+4*i*p
        add $t3, $t2, $t4       #$t3=end of mat[i]

        Loop5:  beq $t2, $t3, exit5
                lwc1 $f0, 0($t2)        #$t5= mat[i][j]
                swc1 $f0, 0($t1)        #arr[k]=$t5
                addi $t1, $t1, 4        #k++
                addi $t2, $t2, 4        #increment $t2
                j Loop5              

        exit5:  addi $t0, $t0, 1
                slt $t2, $t0, $s1       #if t0<s1, t1=1
                bne $t2, $zero, Loop4
        

move $t0, $zero
move $s6, $s2

For_n_print:
    li $v0, 2
    lwc1 $f12, 0($s6)
    syscall
    li $v0, 4
    la $a0, newline
    syscall
    addi $s6, $s6, 4
    addi $t0, $t0, 1
    slt $t1, $t0, $s0   #$t0=i,$s1=p
    bne $t1, $0, For_n_print

# STEP 5 -- exit
li $v0, 10  # Syscall number 10 is to terminate the program
syscall     # exit now


.text
    insertion_sort: li $s0,1    # int i = 1
                    slt $t0,$s0,$a1     # set t0 if i < n
                    bne $t0,$0,For_i    # if i < n goto for_i
                    jr $ra  # else return

                    For_i:
                        move $s1,$s0  # int j = i
                        slt $t0,$0,$s1 # set t0 if 0 < j
                        bne $t0,$0,For_j # if 0 < j goto for_j
                        beq $t0,$0,Exit_j
                        
                        For_j:
                            # arr[j] in f1 with address in s5 and arr[j-1] in f0 with address in s3
                            move $s3, $a0   #loaded arr in s3
                            addi $t0, $s1, -1   #loaded j-1 in t0
                            add $s3, $s3, $t0
                            add $s3, $s3, $t0
                            add $s3, $s3, $t0
                            add $s3, $s3, $t0 #set the arr[j-1]
                            lwc1 $f0, 0($s3) # s2 has arr[j-1]

                            move $s5, $a0 #loaded arr
                            add $s5, $s5, $s1
                            add $s5, $s5, $s1
                            add $s5, $s5, $s1
                            add $s5, $s5, $s1 # set arr + j
                            lwc1 $f1, 0($s5) # s4 has arr[j]

                            c.lt.s $f1, $f0 #t0 shows arr[j] < arr[j-1]
                            bc1t swap #if true goto swap
                            bc1f Exit_j
                            swap:
                                swc1 $f1, 0($s3) # store arr[j] in add of arr[j-1]
                                swc1 $f0, 0($s5) #store arr[j-1] in addr of arr[j]

                            addi $s1,$s1,-1  #j--
                            slt $t0,$0,$s1 #check for loop j
                            bne $t0,$0,For_j
                        Exit_j:

                        addi $s0,$s0,1  # i++
                        slt $t0,$s0,$a1     # set t0 if i < n
                        bne $t0,$0,For_i    # if i < n goto for_i
                    
                    jr $ra




#Lab Assignment 2
Write a program using MIPS assembly language to create two random arrays A and B of size N (where N is the input provided by the user) and then compute the product of the elements of these arrays (pairwise).

Each element in these arrays A and B is some random unsigned integer in range of (1 to 216 – 1). Since their range is small, so there should be no problem with overflow and the product of two elements Ai and Bi can be stored within 32 bits. The product is to be computed using repeated addition and not by using MULT instruction of the MIPS. The algorithm is trivially simple and does not need any explanation. As such, you may also refer to Section 3.3 of Hennessy & Patterson book “Computer Organization and design” (4th Edition). Write the subroutine to compute the product of two numbers and use that (you must call jal) N times for computing the product of each ith pair of elements: Ai and Bi. For generating random numbers, you may refer to<br>
* http://www.tjhsst.edu/~dhyatt/arch/random.html
* http://courses.missouristate.edu/kenvollmar/mars/help/syscallhelp.html (syscall 40-42)

The user should be able to enter a number N between 0 and 255 after the appropriate prompt (like “Enter N”) is displayed on the screen. For the given input N, you create two unsigned integer arrays (randomly generated values, each within a specific range) and display these arrays on the screen. Then, you display the elements pairwise and their product value.
If input N provided is not a positive integer, your console shall mention an error message and shall ask for the input again


----------------------------------------------------------------------------

###Sample Run as shown below

Enter N (the size of random arrays A and B) = 4<br>

Array A = [ 214, 9, 34, 108]<br>
Array B = [2, 40, 27, 12]<br>
214 * 2 = 428<br>
9 * 40 = 360<br>
34 * 27 = 918<br>
108 * 12 = 1296<br>

-----------------------------------------------------------------------------

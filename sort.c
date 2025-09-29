#include "types.h"
#include "user.h"
// #include <limits.h>
// #include <stdio.h>
// #include <stdlib.h>
// #include <string.h>


/*
    sorting algorithm used: merge sort
    technique: (D&C)
    1. Divide: divide the array into two halves
    2. Conquer: recursively sort both halves
    3. Combine: merge the two sorted halves into one sorted array

    time complexity: O(nlogn) 
        (logn levels of splitting
        each level takes O(n) work to merge)
    space complexity: O(n) -> for extra temp arrays used during merging
*/


// merge and mergeSort declared and defined in ulib.c because their usage is needed in other user programs

int main(int argc, char *argv[])
{
    // check input
    // if argument count is less than 2, no numbers to sort, so display proper usage of the command
    if(argc < 2) 
    {
        printf(1, "Incorrect input. The proper syntax is: sort num1 num2 ...\n");
        exit();
    }

    int n = argc - 1;
    float nums[64]; // maximum 64 numbers for now

    // convert arguments into floats
    for(int i = 1; i < argc; i++)
    {
        nums[i-1] = atof(argv[i]);
    }

    // apply merge sort
    mergeSort(nums, 0, n-1);

    // printing the sorted results
    printf(1, "Sorted: ");
    for(int i = 0; i < n; i++)
    {
        printf(1, "%f", nums[i]); // prints with 2 d.p
	printf(1, ",\t");
    }
    printf(1, "\n");
    exit();
}

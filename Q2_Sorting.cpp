// #include "kernel/types.h"
// #include "user/user.h"
#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


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


// function to merge two sorted halves
void merge(float arr[], int left, int mid, int right) 
{
    // calculate sizes of the two halves
    int n1 = mid - left + 1;
    int n2 = right - mid;
    
    // temporary arrays for left and right halves
    float L[n1], R[n2];
    
    // copy data to temporary arrays L[] and R[]
    for (int i = 0; i < n1; i++)
    {
        L[i] = arr[left + i];
    }
    
    for (int j = 0; j < n2; j++)
    {
        R[j] = arr[mid + 1 + j];
    }
    
    int i = 0, j = 0, k = left;

    // merge the temporary arrays back into arr
    while (i < n1 && j < n2) 
    {
        if (L[i] <= R[j]) // pick from left array if smaller
        {
            arr[k] = L[i];
            i++;
        } 
        else // pick from right array if smaller
        {
            arr[k] = R[j];
            j++;
        }
        k++;
    }
    
    // copy remaining elements of L[] (if any still remain)
    while (i < n1) 
    {
        arr[k] = L[i];
        i++;
        k++;
    }
    
    // copy remaining elements of R[] (if any still remain)
    while (j < n2) 
    {
        arr[k] = R[j];
        j++;
        k++;
    }
}

// recursive merge sort function
void mergeSort(float arr[], int left, int right) 
{
    if (left < right) 
    {
        // find the midpoint
        int mid = left + (right - left) / 2;

        // sort the first half
        mergeSort(arr, left, mid);

        // sort the second half
        mergeSort(arr, mid + 1, right);

        // merge the two sorted halves
        merge(arr, left, mid, right);
    }
}

int main(int argc, char *argv[])
{
    // check input
    // if argument count is less than 2, no numbers to sort, so display proper usage of the command
    if(argc < 2) 
    {
        printf("Incorrect input. The proper syntax is: sort num1 num2 ...\n");
        exit(0);
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
    printf("Sorted: ");
    for(int i = 0; i < n; i++)
    {
        printf("%.2f ", nums[i]); // prints with 2 d.p
    }
    printf("\n");
    exit(0);
}

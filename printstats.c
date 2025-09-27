#include <stdio.h>
#include <string.h>

float median(float arr[], int n) {
    sort(arr, n);
    if (n % 2 == 1)
        return arr[n/2];
    else
        return (arr[n/2 - 1] + arr[n/2]) / 2.0;
}

float stddev(float arr[], int n, float mean) {
    float sumsq = 0;
    for (int i = 0; i < n; i++) {
        float diff = arr[i] - mean;
        sumsq += diff * diff;
    }
    return mysqrt(sumsq / n);
}
void printstats(int argc, char* argv[]){
    float numbers[argc - 1];
    float avg_val, stdv_val, median_val, min_val, max_val;
    int n = argc - 1;
    // argv[0] is the program name 'printstats' so we skip to argv[1]
    // Parse input numbers into an int array for later calculations *******NEED TO IMPLEMENT ATOF IN ULIB.C AND ADD FLOAT FUNCTIONALITY TO PRINTF
    for(int i = 0; i < argc; i = i + 1){
        numbers[i] = atof(argv[i + 1]);
    }

    // Using the functions added to ulib.c to calculate the statistics  
    min_val = min(numbers, argc - 1);
    max_val = max(numbers, argc - 1);
    avg_val = avg(numbers, argc - 1);
    median_val = median(numbers, n);
    stdv_val = stddev(numbers, n, avg_val);

    printf(1, "Average: ");
    print_float(1, avg_val, 3);  
    printf(1, "\n");

    printf(1, "Std Dev: ");
    print_float(1, stdv_val, 3);
    printf(1, "\n");

    printf(1, "Median: ");
    print_float(1, median_val, 3);
    printf(1, "\n");

    printf(1, "Min: ");
    print_float(1, min_val, 3);
    printf(1, "\n");

    printf(1, "Max: ");
    print_float(1, max_val, 3);
    printf(1, "\n");

    exit();



}

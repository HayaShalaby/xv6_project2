#include "types.h"
#include "user.h"
float min(float array[], int count){
    mergeSort(array, 0, count - 1);

    return array[0];
}

float max(float array[], int count){
    mergeSort(array, 0, count - 1);

    return array[count - 1];
}

float avg(float array[], int count){
    // A function to calculate the average of a given float array of numbers 
    float sum, avg; 
    sum = 0;

    for(int i = 0; i < count; i = i + 1){
        sum = sum + array[i];
    }


    avg = sum / count;

    return avg;
}

float median(float arr[], int n) {
    mergeSort(arr, 0, n - 1);
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
    // Parse input numbers into an int array for later calculations 
    for(int i = 0; i < argc; i = i + 1){
        numbers[i] = atof(argv[i + 1]);
    }

    // Using the functions added to ulib.c to calculate the statistics  
    min_val = min(numbers, argc - 1);
    max_val = max(numbers, argc - 1);
    avg_val = avg(numbers, argc - 1);
    median_val = median(numbers, n);
    stdv_val = stddev(numbers, n, avg_val);

    // Formatted output of stats
    printf(1, "Average: ");
    printfloat(1, avg_val);  
    printf(1, "\n");

    printf(1, "Std Dev: ");
    printfloat(1, stdv_val);
    printf(1, "\n");

    printf(1, "Median: ");
    printfloat(1, median_val);
    printf(1, "\n");

    printf(1, "Min: ");
    printfloat(1, min_val);
    printf(1, "\n");

    printf(1, "Max: ");
    printfloat(1, max_val);
    printf(1, "\n");

    exit();
}

int main(int argc, char* argv[]) {
    if (argc < 2) {
        printf(1, "Usage: printstats num1 num2 ...\n");
        exit();
    }

    printstats(argc, argv);

    exit();
}

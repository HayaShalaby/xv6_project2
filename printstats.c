#include <stdio.h>
#include <string.h>

void printstats(int argc, char* argv[]){
    float numbers[argc - 1];
    float avg_val, stdv_val, median_val, min_val, max_val;

    // argv[0] is the program name 'printstats' so we skip to argv[1]
    // Parse input numbers into an int array for later calculations *******NEED TO IMPLEMENT ATOF IN ULIB.C AND ADD FLOAT FUNCTIONALITY TO PRINTF
    for(int i = 0; i < argc; i = i + 1){
        numbers[i] = atof(argv[i + 1]);
    }

    // Using the functions added to ulib.c to calculate the statistics  
    min_val = min(numbers, argc - 1);
    max_val = max(numbers, argc - 1);
    avg_val = avg(numbers, argc - 1);
    // add median and stdv here

    // Formatted output of stats


}

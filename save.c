#include "types.h"
#include "user.h"
#include "stat.h"
#include "fcntl.h"

void save(int argc, char*argv[]){
	//If true it will store a +ve number if false it will store -1 
	int file = open(argv[1], O_WRONLY); // if the file exists then open and write
	//to it directly
	if(file < 0){
	 file = open(argv[1], O_CREATE | O_WRONLY); // if it doesnt exist create it (in the writing mode )and open it
	}
	
	//file cannot be opened
	if(file < 0){
	printf(2, "cannot open the file %s from the save command \n", argv[1]);
	exit();
	}
	
	//starting from the first word that comes after the file name
	for(int i = 2; i <argc; i++)
	{
		write(file, argv[i],strlen(argv[i]));
		//if i does not equate to the size of the array
		if(i != argc - 1)
		{
	         //add a space
		 write(file, " ",1);
		}
	}
	close(file);
	exit();
}

int main(int argc, char*argv[])
{
	//if the amount of parameters written in the command is less than
	//3 then there is a parameter that is missing 
	if(argc<3){
	//state 2 is for the sake of sterr (an error message)
	printf(2, "there is a missing arguement\n");
	exit();
	}
	save(argc,argv);
}

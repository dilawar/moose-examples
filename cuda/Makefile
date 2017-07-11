CC=nvcc
CFLAGS=-w -arch sm_30

all:
	$(CC) $(CFLAGS) testCuda.cu -o testCuda
	$(CC) $(CFLAGS) -lcusparse testCusparse.cu -o testCusparse
	

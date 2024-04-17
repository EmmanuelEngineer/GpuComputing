#include <iostream>
#include <math.h>
#define ThreadsperBlock 64 //We have a maximum of 64 cuda cores/real threads in a block
#define BlocksToUse 1 // the system has a maximum of 56 Streaming multiprocessor/real blocks

// Kernel function to add the elements of two arrays
__global__ void add(int n, float *x, float *y)
{
	for (int i = 0; i < n; i++)
	y[i] = x[i] + y[i];
}


int main(int argc, char **argv)
{
	int N;
	N = atoi(argv[1]);
	N = N<<20;
	printf("N:%d\n",N);
	float *x, *y;
	cudaEvent_t start,stop;
// Allocate Unified Memory accessible from CPU or GPU
	cudaMallocManaged(&x, N*sizeof(float));
	cudaMallocManaged(&y, N*sizeof(float));
// initialize x and y arrays on the host
	for (int i = 0; i < N; i++) {
		x[i] = rand()/100*0.5f;
		y[i] = rand()/100*0.3f;
	}
// Separate threads per block each threds has to compute N/(tpb*b)
    int arrayBlockSize = N/ BlocksToUse*ThreadsperBlock;
    


// Run kernel on 1M elements on the GPU
	cudaEventCreate(&start);
	add<<<BlocksToUse,ThreadsperBlock>>>(N, x, y);
	cudaEventCreate(&stop);

// Wait for GPU to finish before accessing on host
	cudaDeviceSynchronize();
// Check for errors (all values should be 3.0f)
	float milliseconds;
	cudaEventElapsedTime(&milliseconds,start,stop);
	printf("Kernel Time: %f ms\n",milliseconds);
	float maxError = 0.0f;
	for (int  i = 0; i < N; i++)
		maxError = fmax(maxError, fabs(y[i]-3.0f));
	std::cout << "Max error: " << maxError << std::endl;
// Free memory
	cudaFree(x);
	cudaFree(y);
	cudaEventDestroy(start);
	cudaEventDestroy(stop);
}

#include <stdio.h>
#include <cstdio>
#include <cuda_runtime.h>

#define CUDA_ERROR_CHECK
#define cudaSafeCall( err ) __cudaSafeCall( err, __FILE__, __LINE__ )

 
inline void __cudaSafeCall( cudaError err, const char *file, const int line )
{
#ifdef CUDA_ERROR_CHECK
   
    if ( cudaSuccess != err )
    {
        fprintf( stderr, "cudaSafeCall() failed at %s:%i : %s\n",
                 file, line, cudaGetErrorString( err ) );
        exit( -1 );
    }
#endif
 
    return;
}

__global__
void saxpy(int n, float a, float *x, float *y)
{
  int i = blockIdx.x*blockDim.x + threadIdx.x;
  if (i < n) y[i] = a*x[i] + y[i];
}

int main(void)
{
  int N = 1<<20;
  float *x, *y, *d_x, *d_y;
  x = (float*)malloc(N*sizeof(float));
  y = (float*)malloc(N*sizeof(float));

  cudaSafeCall(cudaMalloc(&d_x, N*sizeof(float))); 
  cudaSafeCall(cudaMalloc(&d_y, N*sizeof(float)));

  for (int i = 0; i < N; i++) {
    x[i] = 1.0f;
    y[i] = 2.0f;
  }

  cudaSafeCall(cudaMemcpy(d_x, x, N*sizeof(float), cudaMemcpyHostToDevice));
  cudaSafeCall(cudaMemcpy(d_y, y, N*sizeof(float), cudaMemcpyHostToDevice));

// Perform SAXPY on 1M elements
  saxpy<<<(N+255)/256, 256>>>(N, 2.0f, d_x, d_y);

  cudaSafeCall(cudaMemcpy(y, d_y, N*sizeof(float), cudaMemcpyDeviceToHost));

  float maxError = 0.0f;
  for (int i = 0; i < N; i++)
    maxError = max(maxError, abs(y[i]-4.0f));
  printf("Max error: %f\n", maxError);

  cudaFree(d_x);
  cudaFree(d_y);
  free(x);
  free(y);

}

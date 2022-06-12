#include <iostream>
#include "cuda.h"

__global__ void AddIntsCUDA(int*a, int *b)
{
    for (int ii = 0; ii < 10000005; ii++){
        a[0] += b[0];
    }
}

int main(int argc, char **argv){
    
    int a = 0, b = 1;
    int *d_a, *d_b;

    cudaMalloc(&d_a, sizeof(int));
    cudaMalloc(&d_b, sizeof(int));

    cudaMemcpy(d_a, &a, sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, &b, sizeof(int), cudaMemcpyHostToDevice);

    AddIntsCUDA<<<1,1>>>(d_a,d_b);

    cudaMemcpy(&a, d_a, sizeof(int), cudaMemcpyDeviceToHost);

    std::cout << "The answer is " << a << std::endl;

    cudaFree(d_a);
    cudaFree(d_b);
    
    return 0;
}

#include <iostream>
#include <random>
#include "cuda.h"
#include <stdlib.h>

__global__ void sumVectorCUDA(int *a, int *b, int count){
    int id = blockIdx.x*blockDim.x + threadIdx.x;
    if(id < count){
        a[id] += b[id];
    }
}

int main(int argc,char **argv){
    
    std::random_device rd;
    std::mt19937 gen(0);
    std::uniform_real_distribution<double> un_dis(0,1000);
    
    int count = 10; //Size of each array
    int *h_a = nullptr;
    int *h_b = nullptr;
    h_a = new int[count]; //Memory 
    h_b = new int[count]; //Host version

    for (int ii =0; ii < count; ++ii){
        h_a[ii] = un_dis(gen);
        h_b[ii] = un_dis(gen);
    }
    for (int pp =0; pp < 5; ++pp){
        std::cout << h_a[pp] << "\t" << h_b[pp] << std::endl;
    }

    //Here we go
    
    int *d_a, *d_b; //Device
    //Memory allocation on device
    if(cudaMalloc(&d_a, sizeof(int)*count) != cudaSuccess){
        std::cout << "error" << std::endl;
        return 0;
    }
    if(cudaMalloc(&d_b, sizeof(int)*count) != cudaSuccess){
        std::cout << "error" << std::endl;
        return 0;
    }
    //Copy array values
    cudaMemcpy(d_a, h_a, sizeof(int)*count,cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, h_b, sizeof(int)*count,cudaMemcpyHostToDevice);

    sumVectorCUDA<<<5,2>>>(d_a,d_b,count);

    cudaMemcpy(h_a, d_a, sizeof(int)*count,cudaMemcpyDeviceToHost);

    for (int ff =0; ff < 5; ++ff){
        std::cout << h_a[ff] << std::endl;
    }
    
    cudaFree(d_a);
    cudaFree(d_b);
    
    delete[] h_a;
    delete[] h_b;
    
    return 0;
    
}

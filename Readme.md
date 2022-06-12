# CUDA Pre-Project

Hi! In this repo I'm gonna share some codes from the CUDA Introduction Playlist [link](https://www.youtube.com/watch?v=m0nhePeHwFs&list=PLKK11Ligqititws0ZOoGk3SW-TZCar4dK) as an exercise before submitting the Final Project.


# Files

In order to properly compile and run the codes; **Check your GPU's Compute Capability** and run:
 -nvcc file.cu --arch compute_xy -code sm_xy
Where *xy* is the Compute capability without the **.**
 For example, for my old GeForce 930M, *xy* = 50
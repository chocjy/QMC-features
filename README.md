# QMC Feature Maps
Codes for quasi-Monte Carlo feature maps for Gaussian kernels in MATLAB.

## About
Given any pair of points *x* and *y*, compute a feature map *z(x)* and *z(y)* such that *k(x,y)* is approximated by the inner product between *z(x)* and *z(y)* where in this case *k* is the Gaussian kernel.

## Usage
See `qmc_faeture_maps_complex.m` for usage.
See `demo.m` for a simple example.

## References
J. Yang, V. Sindhwani, H. Avron, and M. W. Mahoney, [Quasi-Monte Carlo Feature Maps for Shift-Invariant Kernels](http://web.stanford.edu/~jiyan/publications/qmc_icml.pdf). *International Conference on Machine Learning (ICML), 2014*. 

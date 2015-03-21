% generating random test matrices
X = randn(1000,20);
Xt = randn(500,20);

% setting parameters
sigma = 0.1;
s = 200;
sequence = 'halton';

% constructing new QMC features for X
[Z, W] = random_fourier_qmc_complex(X, sigma, s, sequence);

% construting QMC feature for Xt using W 
Zt = random_fourier_qmc_complex(X, sigma, s, sequence, W);
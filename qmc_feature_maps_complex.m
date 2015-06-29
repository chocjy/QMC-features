% computing quasi-Monte Carlo feature maps for Gaussian kernel
% Inputs:
%   X: input matrix with size n by d
%   sigma: bandwidth in Gaussian kernel
%   s: size of the feature map
%   sequence: a string that denotes which low-discrepancy sequence to use
%   W: build features maps using points from previous constructions (ignore it to compute new feature maps)
%   scram: scramble the sequence or not
%   skip, leap: properties in sequences that might affect the final accuracy
% Outputs:
%   Z: new feature matrix with size n by s and the elements are complex
%   W: points used in the construction that can be used in future construction

function [Z, W] = random_fourier_qmc_complex(X, sigma, s, sequence, W, scram, skip, leap)

if nargin < 8
    leap = 700;
end
if nargin < 7
    skip = 1000;
end
if nargin < 6
    scram = 1;
end
if nargin < 5
    W = [];
end

[n,d] = size(X);
 
if isempty(W)
    if strcmp(sequence, 'unif')  % this case reduces to standard random Fourier feature maps
        W = randn(d,s);
    else
        switch sequence
          case 'halton'
            p = haltonset(d,'Skip',skip,'Leap',leap);
            if scram p = scramble(p,'RR2'); end
            points = p(1:s,1:d);
        case 'sobol'
            p = sobolset(d,'Skip',skip,'Leap',leap);
            if scram p = scramble(p,'MatousekAffineOwen'); end
            points = p(1:s,1:d);
        case 'lattice'
            latticeseq_b2('initskip'); % see http://people.cs.kuleuven.be/~dirk.nuyens/qmc-generators/
            points = latticeseq_b2(d,s)';
            if scram points = mod1shift(points', rand(d,1)); points = points'; end
        case 'digit'
            load new-joe-kuo-5.21201.Cmat % see http://people.cs.kuleuven.be/~dirk.nuyens/qmc-generators/
            digitalseq_b2g('initskip', 18, new_joe_kuo_5_21201); 
            points = digitalseq_b2g(d,s)';
            if scram points = digitalshift(points', rand(d,1)); points = points'; end
        end

        W = norminv(points', 0, 1);
    end
end

X = X/sigma;

Z = (cos(X*W) - i*sin(X*W))*sqrt(1/s);

end


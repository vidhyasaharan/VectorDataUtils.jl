# Running Mean, Variance and Covariance

The following functions are provided to estimate the mean, covariance and variance along each dimension of a set of vectors. These are estimated as running statistics as per [Welford, 1962](https://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.302.7503&rep=rep1&type=pdf).

## Running Mean
```@docs
running_mean
running_mean!
update_running_mean!
```

## Running Mean and Variance
```@docs
running_meanvar
running_meanvar!
update_running_meanvar!
```

## Running Mean and Covariance
```@docs
running_meancov
running_meancov!
update_running_meancov!
```
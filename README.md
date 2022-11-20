
<!-- README.md is generated from README.Rmd. Please edit that file -->

# BIOSTAT625ttest

<!-- badges: start -->

[![R-CMD-check](https://github.com/ashkembi/BIOSTAT625ttest/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/ashkembi/BIOSTAT625ttest/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/ashkembi/BIOSTAT625ttest/branch/master/graph/badge.svg)](https://app.codecov.io/gh/ashkembi/BIOSTAT625ttest?branch=master)
<!-- badges: end -->

The goal of BIOSTAT625ttest is to mimick a one-sample t-test similar to
`stats::t.test()` using the function `test_t()`.

## Installation

You can install the development version of BIOSTAT625ttest from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("ashkembi/BIOSTAT625ttest")
```

## When to use this package

``` r
library(BIOSTAT625ttest)
## basic example code
```

This package contains a function `test_t()` that allows users to run a
one-sample, Student’s t-test on a vector of data.

The purpose of a one-sample t-test is to examine how similar a sample of
data is to a null hypothesis (often the population mean).

Let
![x](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;x
"x") be a sample of data of size
![N](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;N
"N"), where
![x\_i](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;x_i
"x_i") is the
![i](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;i
"i")-th sample. If
![\\overline{X}](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Coverline%7BX%7D
"\\overline{X}") is the sample mean,
![S](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;S
"S") is the sample standard deviation, and
![\\mu](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Cmu
"\\mu") is the true population mean, then the t-statistic,
![T](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;T
"T") can be calculated as follows:

  
![T = \\frac{\\overline{X} -
\\mu}{\\frac{S}{\\sqrt{N}}}](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;T%20%3D%20%5Cfrac%7B%5Coverline%7BX%7D%20-%20%5Cmu%7D%7B%5Cfrac%7BS%7D%7B%5Csqrt%7BN%7D%7D%7D
"T = \\frac{\\overline{X} - \\mu}{\\frac{S}{\\sqrt{N}}}")  

  
![&#10;\\begin{cases}&#10; H\_0 = \\mu \\text{ and } H\_a \\neq \\mu ,&
\\text{if two-tailed}\\\\&#10; H\_0 \\leq \\mu \\text{ and } H\_a \>
\\mu ,& \\text{if right-tailed}\\\\&#10; H\_0 \\geq \\mu \\text{ and }
H\_a \< \\mu ,& \\text{if
left-tailed}&#10;\\end{cases}&#10;](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%0A%5Cbegin%7Bcases%7D%0A%20%20H_0%20%3D%20%5Cmu%20%5Ctext%7B%20and%20%7D%20H_a%20%5Cneq%20%5Cmu%20%2C%26%20%5Ctext%7Bif%20two-tailed%7D%5C%5C%0A%20%20H_0%20%5Cleq%20%5Cmu%20%5Ctext%7B%20and%20%7D%20H_a%20%3E%20%5Cmu%20%2C%26%20%5Ctext%7Bif%20right-tailed%7D%5C%5C%0A%20%20H_0%20%5Cgeq%20%5Cmu%20%5Ctext%7B%20and%20%7D%20H_a%20%3C%20%5Cmu%20%2C%26%20%5Ctext%7Bif%20left-tailed%7D%0A%5Cend%7Bcases%7D%0A
"
\\begin{cases}
  H_0 = \\mu \\text{ and } H_a \\neq \\mu ,& \\text{if two-tailed}\\\\
  H_0 \\leq \\mu \\text{ and } H_a \> \\mu ,& \\text{if right-tailed}\\\\
  H_0 \\geq \\mu \\text{ and } H_a \< \\mu ,& \\text{if left-tailed}
\\end{cases}
")  

## Example scenario

You have taken 100 samples of noise measurements during a worker’s
shift. The US government has set a regulation that noise samples cannot
be above 90 A-weighted decibels (dBA) over an 8 hour period. You want to
examine whether the samples are significantly less than the regulatory
level of 90 dBA.

First, we simulate the 100 noise samples.

``` r
set.seed(123); x <- round(rnorm(100, mean = 85, sd = 10), 1)
head(x)
#> [1]  79.4  82.7 100.6  85.7  86.3 102.2
```

#### Left-tailed t-test

In the first case, we will perform a left-tailed t-test, where ![H\_0
\\geq 90 \\text{
dBA}](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;H_0%20%5Cgeq%2090%20%5Ctext%7B%20dBA%7D
"H_0 \\geq 90 \\text{ dBA}") and ![H\_a \< 90 \\text{
dBA}](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;H_a%20%3C%2090%20%5Ctext%7B%20dBA%7D
"H_a \< 90 \\text{ dBA}") at the significance level of ![\\alpha
= 0.05](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Calpha%20%3D%200.05
"\\alpha = 0.05").

``` r
# input x
# set the null hypothesis to 90 (h0 = 90)
# set the alternative hypothesis as left-tailed (default; alternative = "less")
# set the significance level to 0.05 (conf.level = 0.95)
test_t(x, h0 = 90, alternative = "less", conf.level = 0.95)
#> 
#>  One Sample t-test
#> 
#> data:  x
#> t = -4.4861, df = 99, p-value = 9.79e-06
#> alternative hypothesis: true mean is less than 90
#> 95 percent confidence interval:
#>      -Inf 87.41811
#> sample estimates:
#> mean of x 
#>    85.901
```

At the significance level of ![\\alpha
= 0.05](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Calpha%20%3D%200.05
"\\alpha = 0.05"), we can reject the null hypothesis that the sample
mean of the 100 noise samples are greater than or equal to 90 dBA.

#### Right-tailed t-test

In the second case, we will perform a left-tailed t-test, where ![H\_0
\\leq 90 \\text{
dBA}](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;H_0%20%5Cleq%2090%20%5Ctext%7B%20dBA%7D
"H_0 \\leq 90 \\text{ dBA}") and ![H\_a \> 90 \\text{
dBA}](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;H_a%20%3E%2090%20%5Ctext%7B%20dBA%7D
"H_a \> 90 \\text{ dBA}") at the significance level of ![\\alpha
= 0.05](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Calpha%20%3D%200.05
"\\alpha = 0.05").

``` r
# input x
# set the null hypothesis to 90 (h0 = 90)
# set the alternative hypothesis as right-tailed (default; alternative = "greater")
# set the significance level to 0.05 (conf.level = 0.95)
test_t(x, h0 = 90, alternative = "greater", conf.level = 0.95)
#> 
#>  One Sample t-test
#> 
#> data:  x
#> t = -4.4861, df = 99, p-value = 1
#> alternative hypothesis: true mean is greater than 90
#> 95 percent confidence interval:
#>  84.38389      Inf
#> sample estimates:
#> mean of x 
#>    85.901
```

At the significance level of ![\\alpha
= 0.05](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Calpha%20%3D%200.05
"\\alpha = 0.05"), we fail to reject the null hypothesis that the sample
mean of the 100 noise samples are less than or equal to 90 dBA.

#### Two-tailed t-test

In the last case, we will perform a two-tailed, one-sample t-test, where
![H\_0 = 90 \\text{
dBA}](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;H_0%20%3D%2090%20%5Ctext%7B%20dBA%7D
"H_0 = 90 \\text{ dBA}") and ![H\_a \\neq 90 \\text{
dBA}](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;H_a%20%5Cneq%2090%20%5Ctext%7B%20dBA%7D
"H_a \\neq 90 \\text{ dBA}") at the significance level of ![\\alpha
= 0.05](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Calpha%20%3D%200.05
"\\alpha = 0.05").

``` r
# input x
# set the null hypothesis to 90 (h0 = 90)
# set the alternative hypothesis as two-tailed (default; alternative = "two.sided")
# set the significance level to 0.05 (conf.level = 0.95)
two.sided.t <- test_t(x, h0 = 90, alternative = "two.sided", conf.level = 0.95)
two.sided.t
#> 
#>  One Sample t-test
#> 
#> data:  x
#> t = -4.4861, df = 99, p-value = 1.958e-05
#> alternative hypothesis: true mean is not equal to 90
#> 95 percent confidence interval:
#>  84.08801 87.71399
#> sample estimates:
#> mean of x 
#>    85.901
```

At the significance level of ![\\alpha
= 0.05](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Calpha%20%3D%200.05
"\\alpha = 0.05"), we can reject the null hypothesis that the sample
mean of the 100 noise samples are not equal to 90 dBA.

We can also extract the values generated by performing the t-test.

``` r
# t-statistic
two.sided.t$statistic
#>         t 
#> -4.486127

# degrees of freedom
two.sided.t$parameter
#> df 
#> 99

# p-value
two.sided.t$p.value
#> [1] 1.958004e-05

# confidence interval (in this case, 95%)
two.sided.t$conf.int
#> [1] 84.08801 87.71399
#> attr(,"conf.level")
#> [1] 0.95

# sample mean
two.sided.t$estimate
#> mean of x 
#>    85.901

# null hypothesis
two.sided.t$null.value
#> mean 
#>   90

# sample standard error
two.sided.t$stderr
#> [1] 0.9137054

# alternative hypothesis
two.sided.t$alternative
#> [1] "two.sided"

# prints the t-test method
two.sided.t$method
#> [1] "One Sample t-test"

# inputted data name
two.sided.t$data.name
#> [1] "x"
```

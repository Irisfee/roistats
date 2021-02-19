
<!-- README.md is generated from README.Rmd. Please edit that file -->

# roistats

<!-- badges: start -->

[![R-CMD-check](https://github.com/Irisfee/roistats/workflows/R-CMD-check/badge.svg)](https://github.com/Irisfee/roistats/actions)
[![Codecov test
coverage](https://codecov.io/gh/Irisfee/roistats/branch/main/graph/badge.svg)](https://codecov.io/gh/Irisfee/roistats?branch=main)
<!-- badges: end -->

The goal of this package is to apply t-tests and basic data description
across several sub-groups, with the output being a nice arranged
`data.frame` instead of detailed listed information. Multiple comparison
and significance symbols are wrapped in as options.

This kind of analyses are commonly seen in ROI (Region-of-interest)
analyses for brain imaging data and this is why the package is called
`roistats`.

## Installation

You can install the released version of roistats from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("roistats")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("Irisfee/roistats")
```

## Usage

**See [Get
Started](https://irisfee.github.io/roistats/articles/get_started.html)
page for detailed usage**

### Get some basic description about the data

``` r
library(roistats)
df_sem(color_index, color_index) 
#> # A tibble: 8 x 5
#>   roi_id  mean_color_index     sd     n      se
#>   <chr>              <dbl>  <dbl> <int>   <dbl>
#> 1 AnG              0.00537 0.0507    29 0.00942
#> 2 dLatIPS          0.0159  0.0510    29 0.00946
#> 3 LO               0.0181  0.0428    29 0.00796
#> 4 pIPS             0.0102  0.0297    29 0.00552
#> 5 V1               0.00955 0.0421    29 0.00782
#> 6 vIPS             0.0162  0.0327    29 0.00607
#> 7 vLatIPS          0.0162  0.0514    29 0.00955
#> 8 VTC              0.00468 0.0218    29 0.00405
```

### One-sample t-tests for all sub-groups

``` r
t_test_one_sample(color_index, "color_index", mu = 0)
#> # A tibble: 8 x 5
#> # Groups:   roi_id [8]
#>   roi_id  tvalue    df      p p_bonferroni
#>   <chr>    <dbl> <dbl>  <dbl>        <dbl>
#> 1 AnG      0.570    28 0.573        1     
#> 2 dLatIPS  1.68     28 0.104        0.835 
#> 3 LO       2.27     28 0.0311       0.249 
#> 4 pIPS     1.85     28 0.0752       0.601 
#> 5 V1       1.22     28 0.232        1     
#> 6 vIPS     2.67     28 0.0124       0.0991
#> 7 vLatIPS  1.69     28 0.101        0.811 
#> 8 VTC      1.16     28 0.257        1
```

### With significance symbol as output

``` r
library(dplyr)
color_index_one_sample_t_with_sig <- color_index %>% 
  t_test_one_sample("color_index", mu = 0, p_adjust = c("bonferroni","fdr")) %>% 
  mutate(sig_origin_p = p_range(p))
knitr::kable(color_index_one_sample_t_with_sig, digits = 3)
```

| roi\_id | tvalue | df |     p | p\_bonferroni | p\_fdr | sig\_origin\_p |
| :------ | -----: | -: | ----: | ------------: | -----: | :------------- |
| AnG     |  0.570 | 28 | 0.573 |         1.000 |  0.573 |                |
| dLatIPS |  1.678 | 28 | 0.104 |         0.835 |  0.167 |                |
| LO      |  2.270 | 28 | 0.031 |         0.249 |  0.124 | \*             |
| pIPS    |  1.848 | 28 | 0.075 |         0.601 |  0.167 |                |
| V1      |  1.221 | 28 | 0.232 |         1.000 |  0.294 |                |
| vIPS    |  2.673 | 28 | 0.012 |         0.099 |  0.099 | \*             |
| vLatIPS |  1.694 | 28 | 0.101 |         0.811 |  0.167 |                |
| VTC     |  1.156 | 28 | 0.257 |         1.000 |  0.294 |                |

### Two-sample t-tests for all sub-groups

``` r
t_test_two_sample(color_index_two_sample, x = "color_effect", y = "group", paired = TRUE)
#> # A tibble: 8 x 5
#> # Groups:   roi_id [8]
#>   roi_id  tvalue    df      p p_bonferroni
#>   <chr>    <dbl> <dbl>  <dbl>        <dbl>
#> 1 AnG      0.570    28 0.573        1     
#> 2 dLatIPS  1.68     28 0.104        0.835 
#> 3 LO       2.27     28 0.0311       0.249 
#> 4 pIPS     1.85     28 0.0752       0.601 
#> 5 V1       1.22     28 0.232        1     
#> 6 vIPS     2.67     28 0.0124       0.0991
#> 7 vLatIPS  1.69     28 0.101        0.811 
#> 8 VTC      1.16     28 0.257        1
```

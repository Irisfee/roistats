
<!-- README.md is generated from README.Rmd. Please edit that file -->

# roistats

<!-- badges: start -->

[![R-CMD-check](https://github.com/Irisfee/roistats/workflows/R-CMD-check/badge.svg)](https://github.com/Irisfee/roistats/actions)
[![Codecov test
coverage](https://codecov.io/gh/Irisfee/roistats/branch/main/graph/badge.svg)](https://codecov.io/gh/Irisfee/roistats?branch=main)
<!-- badges: end -->

The goal of this package is for easily applying same t-tests/basic data
description across several sub-groups, with the output as a nice
arranged `data.frame` instead of the detailed listed information.
Multiple comparison and the significance symbols are also provided.

This kind of analysis is commonly seen in ROI (Region-of-interest)
analysis of brain imaging data. That’s why the package is called
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

### Get some basic description about the data

``` r
library(roistats)
str(color_index)
#> Classes 'grouped_df', 'tbl_df', 'tbl' and 'data.frame':  232 obs. of  3 variables:
#>  $ subj_id    : chr  "01" "01" "01" "01" ...
#>  $ roi_id     : chr  "AnG" "dLatIPS" "LO" "pIPS" ...
#>  $ color_index: num  -0.03238 -0.04252 -0.03264 -0.01476 -0.00126 ...
#>  - attr(*, "groups")=Classes 'tbl_df', 'tbl' and 'data.frame':   8 obs. of  2 variables:
#>   ..$ roi_id: chr [1:8] "AnG" "dLatIPS" "LO" "pIPS" ...
#>   ..$ .rows :List of 8
#>   .. ..$ : int [1:29] 1 9 17 25 33 41 49 57 65 73 ...
#>   .. ..$ : int [1:29] 2 10 18 26 34 42 50 58 66 74 ...
#>   .. ..$ : int [1:29] 3 11 19 27 35 43 51 59 67 75 ...
#>   .. ..$ : int [1:29] 4 12 20 28 36 44 52 60 68 76 ...
#>   .. ..$ : int [1:29] 5 13 21 29 37 45 53 61 69 77 ...
#>   .. ..$ : int [1:29] 6 14 22 30 38 46 54 62 70 78 ...
#>   .. ..$ : int [1:29] 7 15 23 31 39 47 55 63 71 79 ...
#>   .. ..$ : int [1:29] 8 16 24 32 40 48 56 64 72 80 ...
#>   .. ..- attr(*, "ptype")= int(0) 
#>   .. ..- attr(*, "class")= chr [1:3] "vctrs_list_of" "vctrs_vctr" "list"
#>   ..- attr(*, ".drop")= logi TRUE
head(color_index)
#>   subj_id  roi_id  color_index
#> 1      01     AnG -0.032384500
#> 2      01 dLatIPS -0.042524083
#> 3      01      LO -0.032643250
#> 4      01    pIPS -0.014760833
#> 5      01      V1 -0.001259167
#> 6      01    vIPS -0.023800500
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

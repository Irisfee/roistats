
<!-- README.md is generated from README.Rmd. Please edit that file -->

# roistats

<!-- badges: start -->

[![R-CMD-check](https://github.com/Irisfee/roistats/workflows/R-CMD-check/badge.svg)](https://github.com/Irisfee/roistats/actions)
[![Codecov test
coverage](https://codecov.io/gh/Irisfee/roistats/branch/main/graph/badge.svg)](https://codecov.io/gh/Irisfee/roistats?branch=main)
[![CRAN
status](https://www.r-pkg.org/badges/version/roistats)](https://CRAN.R-project.org/package=roistats)
<!-- badges: end -->
While working on my first grad school project, I found in our research field, the analysis of multiple testing is involved in almost every project, since we need to compute same analysis over multiple brain regions. Thus, we need to apply same basic descriptive statistics, different variants of t-tests, and multiple comparison correction to multiple groups.

Quickly I got tedious about writing similar long pipelines of doing the multiple testing analysis, so I decided to wrap up my pipeline into functions, and combine functions into a package, and {roistats} came out! All functions from the package can be used in combination with dplyr.

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

### Get some basic description about the data by brain region

``` r
library(roistats)
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
color_index %>% 
  group_by(roi_id) %>%   
  df_sem(color_index) 
#> # A tibble: 8 x 5
#>   roi_id  mean_color_index         sd     n          se
#>   <chr>              <dbl>      <dbl> <int>       <dbl>
#> 1 AnG          0.005370652 0.05071557    29 0.009417644
#> 2 dLatIPS      0.01588446  0.05096974    29 0.009464843
#> 3 LO           0.01806413  0.04284959    29 0.007956968
#> 4 pIPS         0.01019600  0.02971026    29 0.005517056
#> 5 V1           0.009550089 0.04211448    29 0.007820463
#> 6 vIPS         0.01623826  0.03271157    29 0.006074385
#> 7 vLatIPS      0.01617011  0.05141337    29 0.009547223
#> 8 VTC          0.004683526 0.02181639    29 0.004051201
```

### One-sample t-tests for all sub-groups

``` r
color_index %>% 
  group_by(roi_id) %>% 
  t_test_one_sample(color_index)
#> # A tibble: 8 x 5
#> # Groups:   roi_id [8]
#>   roi_id     tvalue    df          p p_bonferroni
#>   <chr>       <dbl> <dbl>      <dbl>        <dbl>
#> 1 AnG     0.5702755    28 0.5730390    1         
#> 2 dLatIPS 1.678259     28 0.1044252    0.8354017 
#> 3 LO      2.270227     28 0.03108491   0.2486792 
#> 4 pIPS    1.848088     28 0.07517831   0.6014264 
#> 5 V1      1.221167     28 0.2322062    1         
#> 6 vIPS    2.673234     28 0.01238958   0.09911667
#> 7 vLatIPS 1.693697     28 0.1014206    0.8113652 
#> 8 VTC     1.156083     28 0.2574165    1
```

### With significance symbol as output

``` r
color_index_one_sample_t_with_sig <- color_index %>% 
  group_by(roi_id) %>% 
  t_test_one_sample(color_index, p_adjust = c("bonferroni","fdr")) %>% 
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
color_index_two_sample %>% 
  group_by(roi_id) %>% 
  t_test_two_sample(x = color_effect, y = group, paired = TRUE)
#> # A tibble: 8 x 5
#> # Groups:   roi_id [8]
#>   roi_id     tvalue    df          p p_bonferroni
#>   <chr>       <dbl> <dbl>      <dbl>        <dbl>
#> 1 AnG     0.5702755    28 0.5730390    1         
#> 2 dLatIPS 1.678259     28 0.1044252    0.8354017 
#> 3 LO      2.270227     28 0.03108491   0.2486792 
#> 4 pIPS    1.848088     28 0.07517831   0.6014264 
#> 5 V1      1.221167     28 0.2322062    1         
#> 6 vIPS    2.673234     28 0.01238958   0.09911667
#> 7 vLatIPS 1.693697     28 0.1014206    0.8113652 
#> 8 VTC     1.156083     28 0.2574165    1
```

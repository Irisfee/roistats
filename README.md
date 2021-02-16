
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

% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/p_range.R
\name{p_range}
\alias{p_range}
\title{Create significant symbols for p-values}
\usage{
p_range(p)
}
\arguments{
\item{p}{A numeric \code{p} value (usually yielded from a statistical test).}
}
\value{
A \code{character} significant symbol. \code{*} represents the p is within the range of (0.05, 0.01],
\code{**} for (0.01, 0.001], and \code{***} for (0.001, +inf]
}
\description{
Create significant symbols for p-values
}
\examples{
p_range(0.02)

library(dplyr)
t_test_one_sample(color_index, "color_index", mu = 0) \%>\% mutate(sig = p_range(p))
}

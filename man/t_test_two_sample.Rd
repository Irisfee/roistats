% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/t_test.R
\name{t_test_two_sample}
\alias{t_test_two_sample}
\title{Generate two-sample t-test results for multiple sub-groups}
\usage{
t_test_two_sample(data, x, y, paired = FALSE, p_adjust = "bonferroni")
}
\arguments{
\item{data}{A grouped data frame. It should be grouped by the intended sub-groups which you want to do the
same t-test.}

\item{x}{Column name of the variable which contains data values that you want to test (see \link[stats]{t.test} and details).}

\item{y}{Column name of the variable which contains data values of group assignments for the test values (see \link[stats]{t.test} and details).}

\item{paired}{a logical indicating whether you want a paired t-test.}

\item{p_adjust}{\code{character} indicating which method should be used for
adjusting multiple comparisons (see \link[stats]{p.adjust} and details).
The default \code{"bonferroni"} corresponds to Bonferroni adjustment.}
}
\value{
A \code{data.frame} with the t-statistics table
consisting of characters. The columns that are always present are:
\code{group variable(s)}, \code{tvalue}, \code{df} (degrees of freedom), \code{p}, and \code{p_adjustmethod(s)}.
}
\description{
This function produce two-sample t-test (two-tailed with confident interval at 0.95) results for multiple sub-groups and provides with
a nice output in a table format. It can also add adjusted p values for multiple comparison
issue.
}
\examples{
t_test_two_sample(color_index_two_sample, x = "color_effect", y = "group", paired = TRUE)

# use bonferroni and fdr method for adjusted p values.
library(magrittr)
color_index_two_sample \%>\%
  t_test_two_sample(
  x = "color_effect", y = "group", paired = TRUE, p_adjust = c("bonferroni","fdr")
  )
}

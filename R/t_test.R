#' Generate one-sample t-test results for multiple sub-groups
#'
#' This function produce one-sample t-test (two-tailed with confident interval at 0.95) results for multiple sub-groups and provides with
#' a nice output in a table format. It can also add adjusted p values for multiple comparison
#' issue.
#' @param data A grouped data frame. It should be grouped by the intended sub-groups which you want to do the
#' same t-test.
#' @param x Column name of the variable which contains data values that you want to test (see \link[stats]{t.test} and details).
#' @param mu A number indicating the true value of the mean (or difference in means
#' if you are performing a two sample test).
#' @param p_adjust \code{character} indicating which method should be used for
#'   adjusting multiple comparisons (see \link[stats]{p.adjust} and details).
#'   The default \code{"bonferroni"} corresponds to Bonferroni adjustment.
#'
#' @return A \code{data.frame} with the t-statistics table
#' consisting of characters. The columns that are always present are:
#' \code{group variable(s)}, \code{tvalue}, \code{df} (degrees of freedom), \code{p}, and \code{p_adjustmethod(s)}.
#'
#' @export
#'
#' @examples
#' t_test_one_sample(color_index, "color_index", mu = 0)
#'
#' # use bonferroni and fdr method for adjusted p values.
#' library(magrittr)
#' color_index %>%
#'   t_test_one_sample("color_index", mu = 0, p_adjust = c("bonferroni","fdr"))
t_test_one_sample <- function(data, x, mu, p_adjust = "bonferroni") {
  if (!dplyr::is.grouped_df(data))  stop('Data must be a grouped data frame.')
  t_results <- data %>%
    tidyr::nest() %>%
    dplyr::mutate(
      ttest = purrr::map(.data$data, ~ stats::t.test(.x[[x]], mu = mu)),
      tvalue = purrr::map_dbl(.data$ttest, ~ magrittr::extract2(.x, 1)),
      df = purrr::map_dbl(.data$ttest, ~ magrittr::extract2(.x, 2)),
      p = purrr::map_dbl(.data$ttest, ~ magrittr::extract2(.x, 3))
    ) %>%
    dplyr::select(-.data$ttest, -.data$data)

  adjust_p_df <- purrr::map_dfc(p_adjust, ~ p_adjust_func(method = .x, data = t_results))
  t_results <- t_results %>%
    dplyr::bind_cols(adjust_p_df)
  return(t_results)
}



#' Generate two-sample t-test results for multiple sub-groups
#'
#' This function produce two-sample t-test (two-tailed with confident interval at 0.95) results for multiple sub-groups and provides with
#' a nice output in a table format. It can also add adjusted p values for multiple comparison
#' issue.
#' @param data A grouped data frame. It should be grouped by the intended sub-groups which you want to do the
#' same t-test.
#' @param x Column name of the variable which contains data values that you want to test (see \link[stats]{t.test} and details).
#' @param y Column name of the variable which contains data values of group assignments for the test values (see \link[stats]{t.test} and details).
#' @param paired a logical indicating whether you want a paired t-test.
#' @param p_adjust \code{character} indicating which method should be used for
#'   adjusting multiple comparisons (see \link[stats]{p.adjust} and details).
#'   The default \code{"bonferroni"} corresponds to Bonferroni adjustment.
#'
#' @return A \code{data.frame} with the t-statistics table
#' consisting of characters. The columns that are always present are:
#' \code{group variable(s)}, \code{tvalue}, \code{df} (degrees of freedom), \code{p}, and \code{p_adjustmethod(s)}.
#'
#' @export
#'
#' @examples
#' t_test_two_sample(color_index_two_sample, x = "color_effect", y = "group", paired = TRUE)
#'
#' # use bonferroni and fdr method for adjusted p values.
#' library(magrittr)
#' color_index_two_sample %>%
#'   t_test_two_sample(
#'   x = "color_effect", y = "group", paired = TRUE, p_adjust = c("bonferroni","fdr")
#'   )



t_test_two_sample <- function(data, x, y, paired = FALSE, p_adjust = "bonferroni") {
  if (!dplyr::is.grouped_df(data))  stop('Data must be a grouped data frame.')
  t_results <- data %>%
    tidyr::nest() %>%
    dplyr::mutate(
      ttest = purrr::map(.data$data, ~ stats::t.test(.x[[x]] ~ .x[[y]], paired = paired)),
      tvalue = purrr::map_dbl(.data$ttest, ~ magrittr::extract2(.x, 1)),
      df = purrr::map_dbl(.data$ttest, ~ magrittr::extract2(.x, 2)),
      p = purrr::map_dbl(.data$ttest, ~ magrittr::extract2(.x, 3))
    ) %>%
    dplyr::select(-.data$ttest, -data)

  adjust_p_df <- purrr::map_dfc(p_adjust, ~ p_adjust_func(method = .x, data = t_results))
  t_results <- t_results %>%
    dplyr::bind_cols(adjust_p_df)
  return(t_results)
}


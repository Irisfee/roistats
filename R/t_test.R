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
t_test_one_sample <- function(data, x, mu = 0, p_adjust = "bonferroni") {
  if (!is.grouped_df(data)) {
    warning("The `t_test_one_sample()` function expects a grouped data frame (i.e., from `dplyr::group_by()`). Returning statistics for the overall column.",
            call. = FALSE)
  }
  t_results <- data %>%
    nest() %>%
    mutate(
      ttest = map(.data$data, ~ t.test(.x[[as_name(enquo(x))]], mu = mu)),
      tvalue = map_dbl(.data$ttest, ~ extract2(.x, 1)),
      df = map_dbl(.data$ttest, ~ extract2(.x, 2)),
      p = map_dbl(.data$ttest, ~ extract2(.x, 3))
    ) %>%
    select(everything(), -.data$ttest, -.data$data)

  adjust_p_df <- map_dfc(p_adjust, ~ p_adjust_func(method = .x, data = t_results))
  t_results <- t_results %>%
    bind_cols(adjust_p_df)

  t_results
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
  if (!is.grouped_df(data)) {
    warning("The `t_test_two_sample()` function expects a grouped data frame (i.e., from `dplyr::group_by()`). Returning statistics for the overall comparison",
            call. = FALSE)
  }
  t_results <- data %>%
    nest() %>%
    mutate(
      ttest = map(.data$data, ~ t.test(
        .x[[as_name(enquo(x))]] ~ .x[[as_name(enquo(y))]],
        paired = paired
        )
      ),
      tvalue = map_dbl(.data$ttest, ~ extract2(.x, 1)),
      df = map_dbl(.data$ttest, ~ extract2(.x, 2)),
      p = map_dbl(.data$ttest, ~ extract2(.x, 3))
    ) %>%
    select(-.data$ttest, -data)

  adjust_p_df <- map_dfc(p_adjust, ~ p_adjust_func(method = .x, data = t_results))
  t_results <- t_results %>%
    bind_cols(adjust_p_df)

  t_results
}


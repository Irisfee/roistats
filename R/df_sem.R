#' Generate standard error of mean
#'
#' @param data A data frame, generally grouped by the intended sub-groups which you want to compare for the
#' same t-test.
#' @param x A (bare) column name of the variable which you want to get the mean, sd, and standard error of the mean (SEM).
#'
#' @return A \code{data.frame} with
#' consisting of characters. The columns that are always present are:
#' \code{group variable(s)}, \code{mean}, \code{sd}, \code{n}, and \code{se}(SEM).
#'
#' @export
#'
#' @examples
#' df_sem(color_index, color_index)
#'
#' library(magrittr)
#' color_index %>%
#'   df_sem(color_index)
df_sem <- function(data, x) {
  if (!is.grouped_df(data)) {
    warning("The `df_sem()` function expects a grouped data frame (i.e., from `dplyr::group_by()`). Returning the overall mean, sd, n and se.",
            call. = FALSE)
  }

  x <- enquo(x)
  df <- data %>%
    summarise(
      mean_x = mean(!!x, na.rm = T),
      sd = sd(!!x, na.rm = T),
      n = n()
    ) %>%
    mutate(se = .data$sd / sqrt(.data$n)) %>%
    ungroup()

  names(df)[names(df) == "mean_x"] <- paste0("mean_", as_label(x))

  df
}


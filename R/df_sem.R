#' Generate standard error of mean
#'
#' @param data A grouped data frame. It should be grouped by the intended sub-groups which you want to do the
#' same t-test.
#' @param x Column name of the variable which you want to get the mean, sd, and standard error of the mean (SEM).
#'
#' @return A \code{data.frame} with
#' consisting of characters. The columns that are always present are:
#' \code{group variable(s)}, \code{mean}, \code{sd}, \code{n}, and \code{se}(SEM).
#'
#' @importFrom magrittr %>%
#' @export
#'
#' @examples
#' df_sem(color_index, color_index)
#'
#' library(magrittr)
#' color_index %>%
#'   df_sem(color_index)
df_sem <- function(data, x) {
  if (!dplyr::is.grouped_df(data)) stop("Data must be a grouped data frame.")
  x <- dplyr::enquo(x)
  df <- data %>%
    dplyr::summarise(
      mean_x = mean(!!x, na.rm = T),
      sd = stats::sd(!!x, na.rm = T),
      n = dplyr::n()
    ) %>%
    dplyr::mutate(se = sd / sqrt(n)) %>%
    dplyr::ungroup()
  names(df)[names(df) == "mean_x"] <- paste0("mean_", dplyr::as_label(x))
  return(df)
}

#' Create significant symbols for p-values
#'
#' @param p A numeric \code{p} value (usually yielded from a statistical test).
#'
#' @return A \code{character} significant symbol. \code{*} represents the p is within the range of (0.05, 0.01],
#' \code{**} for (0.01, 0.001], and \code{***} for (0.001, +inf]
#' @export
#'
#' @examples
#' p_range(0.02)
#'
#' library(dplyr)
#' t_test_one_sample(color_index, "color_index", mu = 0) %>% mutate(sig = p_range(p))

p_range <- function(p) {
  if (!is.numeric(p))  stop('P values should be numeric.')
  if (p >= 0.05) {
    star_note <- ""
  }
  else if (p >= 0.01) {
    star_note <- "*"
  }
  else if (p >= 0.001) {
    star_note <- "**"
  }
  else {
    star_note <- "***"
  }
  return(star_note)
}

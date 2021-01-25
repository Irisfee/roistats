p_adjust_func <- function(method, data) {
  stats::setNames(data.frame(stats::p.adjust(data[["p"]], method = method)), paste0("p_", method))
}

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

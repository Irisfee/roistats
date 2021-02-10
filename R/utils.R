p_adjust_func <- function(method, data) {
  stats::setNames(data.frame(stats::p.adjust(data[["p"]], method = method)), paste0("p_", method))
}


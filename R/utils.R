p_adjust_func <- function(method, data) {
  setNames(data.frame(p.adjust(data[["p"]], method = method)), paste0("p_", method))
}


#' @export
#' @importFrom magrittr %>%
t_test_one_sample <- function(data, x, mu, p_adjust = "bonferroni") {
  if (!dplyr::is.grouped_df(data))  stop('Data must be a grouped data frame.')
  t_results <- data %>%
    tidyr::nest() %>%
    dplyr::mutate(
      ttest = purrr::map(data, ~ stats::t.test(.x[[x]], mu = mu)),
      tvalue = purrr::map_dbl(ttest, ~ magrittr::extract2(.x, 1)),
      df = purrr::map_dbl(ttest, ~ magrittr::extract2(.x, 2)),
      p = purrr::map_dbl(ttest, ~ magrittr::extract2(.x, 3))
    ) %>%
    dplyr::select(-ttest, -data)

  adjust_p_df <- purrr::map_dfc(p_adjust, ~ p_adjust_func(method = .x, data = t_results))
  # c("holm", "hochberg", "hommel", "bonferroni", "BH", "BY",
  #   "fdr", "none")
  t_results <- t_results %>%
    dplyr::bind_cols(adjust_p_df)
  return(t_results)
}



t_test_two_sample <- function(data, x, y, paired = FALSE, p_adjust = "bonferroni") {
  if (!dplyr::is.grouped_df(data))  stop('Data must be a grouped data frame.')
  t_results <- data %>%
    tidyr::nest() %>%
    dplyr::mutate(
      ttest = purrr::map(data, ~ stats::t.test(.x[[x]] ~ .x[[y]], paired = paired)),
      tvalue = purrr::map_dbl(ttest, ~ magrittr::extract2(.x, 1)),
      df = purrr::map_dbl(ttest, ~ magrittr::extract2(.x, 2)),
      p = purrr::map_dbl(ttest, ~ magrittr::extract2(.x, 3))
    ) %>%
    dplyr::select(-ttest, -data)

  adjust_p_df <- purrr::map_dfc(p_adjust, ~ p_adjust_func(method = .x, data = t_results))
  # c("holm", "hochberg", "hommel", "bonferroni", "BH", "BY",
  #   "fdr", "none")
  t_results <- t_results %>%
    dplyr::bind_cols(adjust_p_df)
  return(t_results)
}


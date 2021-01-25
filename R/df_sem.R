#' @export
#' @importFrom magrittr %>%
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

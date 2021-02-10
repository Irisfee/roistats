#' Color index
#'
#' The pre-processed data for identifying which brain regions is sensitive to the color memory of learned objects.
#'
#' @format A tibble with 232 rows and 3 variables with one group attribute:
#' \describe{
#' \item{subj_id}{Subjuct identity number}
#' \item{roi_id}{Brain sub-region that of interest for the analysis. Served as the grouping variable here.}
#' \item{color_index}{A value we want to test if it is significantly different from 0 across subjects.}
#' }
#' @references Zhao, Y., Chanales, A.J.H. & Kuhl, B.A. (2021). Adaptive memory distortions are predicted by feature representations in parietal cortex. Journal of Neuroscience
#' @examples
#' color_index
"color_index"

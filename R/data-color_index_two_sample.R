#' Color effect data for each group
#'
#' The pre-processed data for identifying which brain regions is sensitive to the color memory of learned objects.
#'
#' @format A tibble with 464 rows and 4 variables with one group attribute:
#' \describe{
#' \item{subj_id}{Subjuct identity number}
#' \item{roi_id}{Brain sub-region that of interest for the analysis. Served as the grouping variable here.}
#' \item{group}{A within-group variable for each subject. Indicating whether the color effect value is for the Paired or Control condition}
#' \item{color_effect}{A value we want to test between the two groups (Paired vs Control).}
#' }
#' @references Zhao, Y., Chanales, A.J.H. & Kuhl, B.A. (2021). Adaptive memory distortions are predicted by feature representations in parietal cortex. Journal of Neuroscience
#' @examples
#' color_index_two_sample
"color_index_two_sample"

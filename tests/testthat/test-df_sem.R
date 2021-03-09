test_that("t-test-one-sample output", {
  expect_length(df_sem(dplyr::group_by(color_index, roi_id), color_index), 5)
  expect_equal(
    NROW(t_test_one_sample(dplyr::group_by(color_index, roi_id), color_index)),
    8
  )
})

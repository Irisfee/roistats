test_that("t-test-one-sample output", {
  expect_length(df_sem(color_index, color_index), 5)
  expect_equal(NROW(na.omit(t_test_one_sample(color_index, "color_index", mu = 0))), 8)
})

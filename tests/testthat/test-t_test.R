test_that("t-test-one-sample output", {
  expect_length(t_test_one_sample(color_index, "color_index", mu = 0), 5)
  expect_equal(NROW(na.omit(t_test_one_sample(color_index, "color_index", mu = 0))), 8)
})


test_that("t-test-two-sample output", {
  expect_length(t_test_two_sample(color_index_two_sample, "color_effect", "group", paired = TRUE), 5)
  expect_equal(NROW(na.omit(t_test_one_sample(color_index, "color_index", mu = 0))), 8)
})

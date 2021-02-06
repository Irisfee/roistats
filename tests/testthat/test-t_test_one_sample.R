test_that("t-test-one-sample output", {
  expect_length(t_test_one_sample(test, "color_index", mu = 0), 5)
})

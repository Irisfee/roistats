test_that("p_range output correct signs", {
  expect_equal(p_range(0.0003), "***")
  expect_equal(p_range(0.003), "**")
  expect_equal(p_range(0.03), "*")
})

test_that("p_range throws an error", {
  expect_error(p_range("0.03"))
  expect_error(p_range("t"))
})

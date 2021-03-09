test_that("t-test-one-sample output", {
  expect_warning(
    expect_warning(
      t_test_one_sample(color_index, color_index)
      )
  )

  expect_length(
    t_test_one_sample(dplyr::group_by(color_index, roi_id), color_index),
    5
  )

  expect_equal(NROW(
    t_test_one_sample(dplyr::group_by(color_index, roi_id), color_index)),
    8
  )
})


test_that("t-test-two-sample output", {
  expect_length(t_test_two_sample(
    dplyr::group_by(color_index_two_sample, roi_id),
    color_effect,
    group,
    paired = TRUE
    ),
    5
  )
  expect_equal(NROW(t_test_one_sample(dplyr::group_by(color_index, roi_id), color_index)), 8)
})

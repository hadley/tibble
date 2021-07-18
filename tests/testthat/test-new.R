test_that("new_tibble() with deprecated subclass argument", {
  scoped_lifecycle_silence()

  tbl <- new_tibble(
    data.frame(a = 1:3),
    names = "b",
    attr1 = "value1",
    attr2 = 2,
    nrow = 3,
    subclass = "nt"
  )

  # Can't compare directly due to dplyr:::all.equal.tbl_df()
  expect_identical(class(tbl), c("nt", "tbl_df", "tbl", "data.frame"))
  expect_equal(
    unclass(tbl),
    structure(
      list(b = 1:3),
      attr1 = "value1",
      attr2 = 2,
      .Names = "b",
      row.names = .set_row_names(3L)
    )
  )
})

test_that("new_tibble() with new class argument", {
  tbl <- new_tibble(
    data.frame(a = 1:3),
    names = "b",
    attr1 = "value1",
    attr2 = 2,
    nrow = 3,
    class = c("nt", "data.frame")
  )

  # Can't compare directly due to dplyr:::all.equal.tbl_df()
  expect_identical(class(tbl), c("nt", "tbl_df", "tbl", "data.frame"))
  expect_equal(
    unclass(tbl),
    structure(
      list(b = 1:3),
      attr1 = "value1",
      attr2 = 2,
      .Names = "b",
      row.names = .set_row_names(3L)
    )
  )
})

test_that("new_tibble() with additional attributes", {
  df <- data.frame(a = 1:3)
  foo <- df
  attr(foo, "foo") <- "bar"

  tbl_df <- new_tibble(df, nrow = 3, foo = "baz")
  tbl_foo <- new_tibble(foo, nrow = 3, foo = "baz")
  expect_identical(tbl_df, tbl_foo)
})

test_that("new_tibble() doesn't retain any `x` attributes besides names", {
  x <- new_tibble(list(a = 1), foo = "bar", nrow = 1L, class = "subtbl")

  result <- new_tibble(x, nrow = 1L)

  expect_named(result, "a")
  expect_null(attr(result, "foo"))
  expect_s3_class(result, class(tibble()), exact = TRUE)
})

test_that("new_tibble checks", {
  scoped_lifecycle_errors()

  expect_identical(new_tibble(list(), nrow = 0), tibble())
  expect_identical(new_tibble(list(), nrow = 5), tibble(.rows = 5))
  expect_identical(new_tibble(list(a = 1:3, b = 4:6), nrow = 3), tibble(a = 1:3, b = 4:6))
  expect_tibble_error(
    new_tibble(1:3, nrow = 1),
    error_new_tibble_must_be_list()
  )
  expect_error(
    new_tibble(list(a = 1)),
    class = get_defunct_error_class()
  )
  expect_tibble_error(
    new_tibble(list(1), nrow = NULL),
    error_new_tibble_needs_nrow()
  )
  expect_tibble_error(
    new_tibble(list(1), nrow = 1),
    error_names_must_be_non_null()
  )
  expect_error(
    new_tibble(set_names(list(1), NA_character_), nrow = 1),
    NA
  )
  expect_error(
    new_tibble(set_names(list(1), ""), nrow = 1),
    NA
  )
  expect_error(
    new_tibble(list(a = 1, b = 2:3), nrow = 1),
    NA
  )
  expect_error(
    new_tibble(
      structure(list(a = 1, b = 2), row.names = .set_row_names(2)),
      nrow = 1
    ),
    NA
  )
})

test_that("validate_tibble() checks", {
  expect_tibble_error(
    validate_tibble(new_tibble(list(a = 1, b = 2:3), nrow = 1)),
    error_incompatible_size(1, c("a", "b"), 1:2, "Requested with `nrow` argument")
  )
})

test_that("output test", {
  expect_snapshot_with_error({
    new_tibble(1:3, nrow = 1)
    new_tibble(as.list(1:3))
  })
})

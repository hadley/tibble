test_that("tibble returns correct number of rows with all combinatinos", {
  expect_equal(nrow(tibble(value = 1:10)), 10L)
  expect_equal(nrow(tibble(value = 1:10, name = "recycle_me")), 10L)
  expect_equal(nrow(tibble(name = "recycle_me", value = 1:10)), 10L)
  expect_equal(nrow(tibble(name = "recycle_me", value = 1:10, value2 = 11:20)), 10L)
  expect_equal(nrow(tibble(value = 1:10, name = "recycle_me", value2 = 11:20)), 10L)
})

test_that("NULL is ignored (#580)", {
  expect_identical(tibble(a = NULL), tibble())
  expect_identical(tibble(a = NULL, a = 1), tibble(a = 1))
  expect_identical(tibble(a = NULL, b = 1, c = 2:3), tibble(b = 1, c = 2:3))
  expect_identical(tibble(b = 1, NULL, c = 2:3), tibble(b = 1, c = 2:3))
})

test_that("NULL is ignored when passed by value (#895, #900)", {
  expect_identical(tibble(a = c()), tibble(a = NULL))
  expect_identical(tibble(a = c(), a = 1), tibble(a = 1))
})

test_that("bogus columns raise an error", {
  expect_tibble_error(
    tibble(a = new.env()),
    error_column_scalar_type("a", 1, "an environment")
  )
  expect_tibble_error(
    tibble(a = quote(a)),
    error_column_scalar_type("a", 1, "a symbol")
  )
})

test_that("length 1 vectors are recycled", {
  expect_equal(nrow(tibble(x = 1:10)), 10)
  expect_equal(nrow(tibble(x = 1:10, y = 1)), 10)
  expect_tibble_error(
    tibble(x = 1:10, y = 1:2),
    error_incompatible_size(10, "y", 2, "Existing data")
  )
})

test_that("length 1 vectors in hierarchical data frames are recycled (#502)", {
  expect_identical(
    tibble(x = 1:10, y = tibble(z = 1)),
    tibble(x = 1:10, y = tibble(z = rep(1, 10)))
  )
  expect_identical(
    tibble(y = tibble(z = 1), x = 1:10),
    tibble(y = tibble(z = rep(1, 10)), x = 1:10)
  )
  expect_identical(
    tibble(x = 1, y = tibble(z = 1:10)),
    tibble(x = rep(1, 10), y = tibble(z = 1:10))
  )
  expect_identical(
    tibble(y = tibble(z = 1:10), x = 1),
    tibble(y = tibble(z = 1:10), x = rep(1, 10))
  )
})

test_that("missing names are imputed from call", {
  x <- 1:10
  df <- tibble(x, y = x)
  expect_equal(names(df), c("x", "y"))
})

test_that("empty input makes 0 x 0 tbl_df", {
  zero <- tibble()
  expect_s3_class(zero, "tbl_df")
  expect_equal(dim(zero), c(0L, 0L))
  expect_identical(attr(zero, "names"), character(0L))
})

test_that("SE version", {
  scoped_lifecycle_silence()
  expect_identical(tibble_(list(a = ~1:10)), tibble(a = 1:10))
})

test_that("names are maintained vectors (#630)", {
  foo <- tibble(x = c(y = 1, z = 2))
  expect_equal(names(foo), "x")
  expect_equal(names(foo$x), c("y", "z"))
})

test_that("names in list columns are maintained (#630)", {
  foo <- tibble(x = list(y = 1:3, z = 4:5))
  expect_equal(names(foo), "x")
  expect_equal(names(foo$x), c("y", "z"))
})

test_that("can create a tibble with an expression column (#657)", {
  foo <- tibble(x = expression(1 + 2))
  expect_equal(as.list(foo$x), as.list(expression(1 + 2)))
})

test_that("unknown attributes are not preserved", {
  df <- structure(
    data.frame(x = 1:10, g1 = rep(1:2, each = 5), g2 = rep(1:5, 2)),
    meta = "this is extra"
  )
  res <- as_tibble(df)

  expect_identical(attr(res, "meta"), NULL)
})

test_that(".data pronoun", {
  expect_identical(tibble(a = 1, b = .data$a), tibble(a = 1, b = 1))
})

test_that("tibble aliases", {
  scoped_lifecycle_silence()
  expect_identical(data_frame(a = 1), tibble(a = 1))
  expect_identical(data_frame_(list(a = ~1)), tibble_(list(a = ~1)))
})

# Validation --------------------------------------------------------------

test_that("NULL isn't a valid column", {
  expect_tibble_error(
    check_valid_cols(list(a = NULL)),
    error_column_scalar_type("a", 1, "NULL")
  )
})

test_that("mutate() semantics for tibble() (#213)", {
  expect_equal(
    tibble(a = 1:2, b = 1, c = b / sum(b)),
    tibble(a = 1:2, b = c(1, 1), c = c(0.5, 0.5))
  )

  expect_equal(
    tibble(b = 1, a = 1:2, c = b / sum(b)),
    tibble(b = c(1, 1), a = 1:2, c = c(0.5, 0.5))
  )

  expect_equal(
    tibble(b = 1, c = b / sum(b), a = 1:2),
    tibble(b = c(1, 1), c = c(1, 1), a = 1:2)
  )
})

test_that("types preserved when recycling in tibble() (#284)", {
  expect_equal(
    tibble(a = 1:2, b = as.difftime(1, units = "hours")),
    tibble(a = 1:2, b = as.difftime(c(1, 1), units = "hours"))
  )

  expect_equal(
    tibble(b = as.difftime(1, units = "hours"), a = 1:2),
    tibble(b = as.difftime(c(1, 1), units = "hours"), a = 1:2)
  )
})

# Data frame and matrix columns -------------------------------------------

test_that("can make tibble containing data.frame or array (#416)", {
  expect_identical(
    tibble(mtcars = remove_rownames(mtcars)),
    new_tibble(list(mtcars = remove_rownames(mtcars)), nrow = nrow(mtcars))
  )
  expect_identical(
    tibble(diag(5)),
    new_tibble(list(`diag(5)` = diag(5)), nrow = 5)
  )
})

test_that("auto-splicing anonymous tibbles (#581)", {
  df <- tibble(a = 1, b = 2)
  expect_identical(
    tibble(df),
    df
  )
  expect_identical(
    tibble(df, c = b),
    add_column(df, c = 2)
  )
})

test_that("can coerce list data.frame or array (#416)", {
  expect_identical(
    as_tibble(list(x = iris)),
    new_tibble(list(x = iris), nrow = nrow(iris))
  )
  expect_identical(
    as_tibble(list(x = diag(5))),
    new_tibble(list(x = diag(5)), nrow = 5)
  )
})

test_that("susbsetting returns the correct number of rows", {
  expect_identical(
    tibble(x = mtcars)[1:3, ],
    tibble(x = mtcars[1:3, ])
  )
  expect_identical(
    tibble(y = diag(5))[1:3, ],
    tibble(y = diag(5)[1:3, ])
  )
})

test_that("subsetting one row retains columns", {
  expect_identical(
    tibble(y = diag(5))[1, ],
    tibble(y = diag(5)[1, , drop = FALSE])
  )
})

test_that("package_version is a vector (#690)", {
  ver <- utils::packageVersion("tibble")

  expect_identical(tibble(x = ver)$x, ver)
})


# tibble_row() ------------------------------------------------------------

test_that("returns a single row (#416)", {
  model <- lm(Petal.Width ~ Petal.Length + Species, data = iris)
  expect_identical(
    tibble_row(a = 1, b = vctrs::list_of(2:3), lm = model),
    tibble(a = 1, b = vctrs::list_of(2:3), lm = list(model))
  )
  expect_equal(
    tibble_row(iris[1, ]),
    tibble(iris[1, ])
  )
  expect_tibble_error(
    tibble_row(a = 1, b = 2:3),
    error_tibble_row_size_one(2, "b", 2)
  )
  expect_tibble_error(
    tibble_row(iris[2:3, ]),
    error_tibble_row_size_one(1, "", 2)
  )
})

# is_tibble ---------------------------------------------------------------

test_that("is_tibble", {
  expect_false(is_tibble(iris))
  expect_true(is_tibble(as_tibble(iris)))
  expect_false(is_tibble(NULL))
  expect_false(is_tibble(0))
})

test_that("is_tibble", {
  scoped_lifecycle_silence()
  expect_identical(is.tibble(iris), is_tibble(iris))
})

test_that("output test", {
  expect_snapshot_with_error({
    tibble(a = 1, a = 1)
    tibble(a = new_environment())
    tibble(a = 1, b = 2:3, c = 4:6, d = 7:10)
  })
})

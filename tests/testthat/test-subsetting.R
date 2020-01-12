# [ -----------------------------------------------------------------------

test_that("[ never drops", {
  mtcars2 <- as_tibble(mtcars)

  expect_is(mtcars2[, 1], "data.frame")
  expect_is(mtcars2[, 1], "tbl_df")
  expect_equal(mtcars2[, 1], mtcars2[1])
})

test_that("[ retains class", {
  mtcars2 <- as_tibble(mtcars)

  expect_identical(class(mtcars2), class(mtcars2[1:5, ]))
  expect_identical(class(mtcars2), class(mtcars2[, 1:5]))
  expect_identical(class(mtcars2), class(mtcars2[1:5, 1:5]))
})

test_that("[ and as_tibble commute", {
  mtcars2 <- as_tibble(mtcars)
  expect_identical(mtcars2, as_tibble(mtcars))
  expect_identical(mtcars2[], remove_rownames(as_tibble(mtcars[])))
  expect_identical(mtcars2[1:5, ], remove_rownames(as_tibble(mtcars[1:5, ])))
  expect_identical(mtcars2[, 1:5], remove_rownames(as_tibble(mtcars[, 1:5])))
  expect_equal(mtcars2[1:5, 1:5], remove_rownames(as_tibble(mtcars[1:5, 1:5])))
  expect_identical(mtcars2[1:5], remove_rownames(as_tibble(mtcars[1:5])))
})

test_that("[ with 0 cols creates correct row names (#656)", {
  zero_row <- as_tibble(iris)[, 0]
  expect_is(zero_row, "tbl_df")
  expect_equal(nrow(zero_row), 150)
  expect_equal(ncol(zero_row), 0)

  expect_identical(zero_row, as_tibble(iris)[0])
})

test_that("[ with 0 cols returns correct number of rows", {
  iris_tbl <- as_tibble(iris)
  nrow_iris <- nrow(iris_tbl)

  expect_equal(nrow(iris_tbl[0]), nrow_iris)
  expect_equal(nrow(iris_tbl[, 0]), nrow_iris)

  expect_equal(nrow(iris_tbl[, 0][1:10, ]), 10)
  expect_equal(nrow(iris_tbl[0][1:10, ]), 10)
  expect_equal(nrow(iris_tbl[1:10, ][, 0]), 10)
  expect_equal(nrow(iris_tbl[1:10, ][0]), 10)
  expect_equal(nrow(iris_tbl[1:10, 0]), 10)

  expect_equal(nrow(iris_tbl[, 0][-(1:10), ]), nrow_iris - 10)
  expect_equal(nrow(iris_tbl[0][-(1:10), ]), nrow_iris - 10)
  expect_equal(nrow(iris_tbl[-(1:10), ][, 0]), nrow_iris - 10)
  expect_equal(nrow(iris_tbl[-(1:10), ][0]), nrow_iris - 10)
  expect_equal(nrow(iris_tbl[-(1:10), 0]), nrow_iris - 10)
})

test_that("[ with explicit NULL works as expected (#696)", {
  iris_tbl <- as_tibble(iris)

  expect_identical(iris_tbl[NULL], iris_tbl[0])
  expect_identical(iris_tbl[, NULL], iris_tbl[, 0])
  expect_identical(iris_tbl[NULL, ], iris_tbl[0, ])
  expect_identical(iris_tbl[NULL, NULL], tibble())
})

test_that("[.tbl_df is careful about names (#1245)", {
  foo <- tibble(x = 1:10, y = 1:10)
  expect_tibble_error(
    foo["z"],
    error_unknown_column_names("z")
  )
  expect_tibble_error(
    foo[c("x", "y", "z")],
    error_unknown_column_names("z")
  )

  expect_tibble_error(
    foo[, "z"],
    error_unknown_column_names("z")
  )
  expect_tibble_error(
    foo[, c("x", "y", "z")],
    error_unknown_column_names("z")
  )

  expect_error(
    foo[as.matrix("x")],
    "."
  )
  expect_error(
    foo[array("x", dim = c(1, 1, 1))],
    "."
  )
})

test_that("[.tbl_df is careful about column indexes (#83)", {
  foo <- tibble(x = 1:10, y = 1:10, z = 1:10)
  expect_identical(foo[1:3], foo)

  expect_tibble_error(
    foo[0.5],
    error_unsupported_column_index()
  )
  expect_tibble_error(
    foo[1:5],
    error_large_column_index(3, 4:5)
  )

  # Message from base R
  expect_error(foo[-1:1])
  expect_error(foo[c(-1, 1)])

  expect_tibble_error(
    foo[-4],
    error_small_column_index(3, -4)
  )
  expect_error(foo[c(-1, 2)], ".")
  expect_tibble_error(
    foo[c(1:3, NA)],
    error_na_column_index(4)
  )

  expect_error(foo[as.matrix(1)])
  expect_error(
    foo[array(1, dim = c(1, 1, 1))],
    class = "vctrs_error_incompatible_cast"
  )
})

test_that("[.tbl_df is careful about column flags (#83)", {
  foo <- tibble(x = 1:10, y = 1:10, z = 1:10)
  expect_identical(foo[TRUE], foo)
  expect_identical(foo[c(TRUE, TRUE, TRUE)], foo)
  expect_identical(foo[FALSE], foo[integer()])
  expect_identical(foo[c(FALSE, TRUE, FALSE)], foo[2])

  expect_error(
    foo[c(TRUE, TRUE)],
    "."
  )
  expect_error(
    foo[c(TRUE, TRUE, FALSE, FALSE)],
    "."
  )
  expect_tibble_error(
    foo[c(TRUE, TRUE, NA)],
    error_na_column_index(3)
  )

  expect_error(
    foo[as.matrix(TRUE)],
    "."
  )
  expect_error(
    foo[array(TRUE, dim = c(1, 1, 1))],
    "."
  )
})

test_that("[.tbl_df rejects unknown column indexes (#83)", {
  foo <- tibble(x = 1:10, y = 1:10, z = 1:10)
  expect_tibble_error(
    foo[list(1:3)],
    error_unsupported_column_index()
  )
  expect_tibble_error(
    foo[as.list(1:3)],
    error_unsupported_column_index()
  )
  expect_tibble_error(
    foo[factor(1:3)],
    error_unknown_column_names(as.character(1:3))
  )
  expect_tibble_error(
    foo[Sys.Date()],
    error_unsupported_column_index()
  )
  expect_tibble_error(
    foo[Sys.time()],
    error_unsupported_column_index()
  )
})

test_that("[.tbl_df supports character subsetting (#312)", {
  foo <- tibble(x = 1:10, y = 1:10, z = 1:10)
  expect_identical(foo[as.character(2:4), ], foo[2:4, ])

  scoped_lifecycle_silence()

  expect_identical(foo[as.character(9:12), ], foo[c(9:10, NA, NA), ])
  expect_identical(foo[letters, ], foo[rlang::rep_along(letters, NA_integer_), ])
  expect_identical(foo["9a", ], foo[NA_integer_, ])
})

test_that("[.tbl_df emits lifecycle warnings with invalid character subsetting", {
  scoped_lifecycle_errors()

  foo <- tibble(x = 1:10, y = 1:10, z = 1:10)
  expect_error(foo[as.character(9:12), ])
  expect_error(foo[letters, ])
  expect_error(foo["9a", ])
})

test_that("[.tbl_df supports integer subsetting (#312)", {
  foo <- tibble(x = 1:10, y = 1:10, z = 1:10)
  expect_identical(foo[2:4, ], as_tibble(as.data.frame(foo)[2:4, ]))
  expect_identical(foo[-3:-5, ], foo[c(1:2, 6:10), ])

  scoped_lifecycle_silence()

  expect_identical(foo[9:12, ], foo[c(9:10, NA, NA), ])
  expect_identical(foo[-(9:12), ], foo[1:8, ])
})

test_that("[.tbl_df emits lifecycle warnings with invalid integer subsetting", {
  scoped_lifecycle_errors()

  foo <- tibble(x = 1:10, y = 1:10, z = 1:10)
  expect_error(foo[9:12, ])
  expect_error(foo[-(9:12), ])
})

test_that("[.tbl_df supports character subsetting if row names are present (#312)", {
  foo <- as_tibble(mtcars, rownames = NA)
  idx <- function(x) rownames(mtcars)[x]

  expect_identical(foo[idx(2:4), ], foo[2:4, ])
  expect_identical(foo[idx(-3:-5), ], foo[-3:-5, ])
  expect_identical(foo[idx(29:34), ], foo[c(29:32, NA, NA), ])

  scoped_lifecycle_silence()

  expect_identical(foo[letters, ], foo[rlang::rep_along(letters, NA_integer_), ])
  expect_identical(foo["9a", ], foo[NA_integer_, ])
})

test_that("[.tbl_df emits lifecycle warnings with invalid character subsetting", {
  scoped_lifecycle_errors()

  foo <- as_tibble(mtcars, rownames = NA)
  idx <- function(x) rownames(mtcars)[x]

  expect_error(foo[letters, ])
  expect_error(foo["9a", ])
})

test_that("[.tbl_df supports logical subsetting (#318)", {
  foo <- tibble(x = 1:10, y = 1:10, z = 1:10)
  expect_identical(foo[c(FALSE, rep(TRUE, 3), rep(F, 6)), ], foo[2:4, ])
  expect_identical(foo[TRUE, ], foo)
  expect_identical(foo[FALSE, ], foo[0L, ])

  expect_error(foo[c(TRUE, FALSE), ], ".")
})

test_that("[.tbl_df is no-op if args missing", {
  expect_identical(df_all[], df_all)
})

test_that("[.tbl_df supports drop argument (#311)", {
  expect_identical(df_all[, 2, drop = TRUE], df_all[[2]])
  expect_identical(df_all[1, 2, drop = TRUE], df_all[[2]][[1]])
  expect_identical(df_all[1, , drop = TRUE], df_all[1, , ])
})

test_that("[.tbl_df ignores drop argument (with warning) without j argument (#307)", {
  expect_warning(expect_identical(df_all[1, drop = TRUE], df_all[1]))
})


test_that("[.tbl_df is careful about attributes (#155)", {
  df <- tibble(x = 1:2, y = x)
  attr(df, "along for the ride") <- "still here"

  expect_identical(attr(df[names(df)], "along for the ride"), "still here")
  expect_identical(attr(df["x"], "along for the ride"), "still here")
  expect_identical(attr(df[1:2], "along for the ride"), "still here")
  expect_identical(attr(df[2], "along for the ride"), "still here")
  expect_identical(attr(df[c(TRUE, FALSE)], "along for the ride"), "still here")
  expect_identical(attr(df[, names(df)], "along for the ride"), "still here")
  expect_identical(attr(df[, "x"], "along for the ride"), "still here")
  expect_identical(attr(df[, 1:2], "along for the ride"), "still here")
  expect_identical(attr(df[, 2], "along for the ride"), "still here")
  expect_identical(attr(df[, c(TRUE, FALSE)], "along for the ride"), "still here")
  expect_identical(attr(df[1, names(df)], "along for the ride"), "still here")
  expect_identical(attr(df[1, "x"], "along for the ride"), "still here")
  expect_identical(attr(df[1, 1:2], "along for the ride"), "still here")
  expect_identical(attr(df[1, 2], "along for the ride"), "still here")
  expect_identical(attr(df[1, c(TRUE, FALSE)], "along for the ride"), "still here")

  expect_identical(attr(df[1:2, ], "along for the ride"), "still here")
  expect_identical(attr(df[-1, ], "along for the ride"), "still here")

  expect_identical(attr(df[, ], "along for the ride"), "still here")
  expect_identical(attr(df[], "along for the ride"), "still here")
})

# [[ ----------------------------------------------------------------------

test_that("[[.tbl_df ignores exact argument", {
  foo <- tibble(x = 1:10, y = 1:10)
  expect_warning(foo[["x"]], NA)
  expect_warning(foo[["x", exact = FALSE]], "ignored")
  expect_identical(getElement(foo, "y"), 1:10)
})

test_that("[[.tbl_df throws error with NA index", {
  foo <- tibble(x = 1:10, y = 1:10)
  expect_error(foo[[NA]])
  expect_error(foo[[NA_integer_]])
  expect_error(foo[[NA_real_]])
  expect_error(foo[[NA_character_]])
})

test_that("can use recursive indexing with [[", {
  scoped_lifecycle_silence()

  foo <- tibble(x = list(y = 1:3, z = 4:5))
  expect_equal(foo[[c(1, 1)]], 1:3)

  # [[ with a matrix seems broken, despite an implementation in [[.data.frame
})

test_that("[[ returns NULL if name doesn't exist", {
  scoped_lifecycle_silence()

  df <- tibble(x = 1)
  expect_null(df[["y"]])
  expect_null(df[[1, "y"]])
})

test_that("can use two-dimensional indexing with [[", {
  iris2 <- as_tibble(iris)
  expect_equal(iris2[[1, 2]], iris[[1, 2]])
  expect_equal(iris2[[2, 3]], iris[[2, 3]])
})

test_that("can use two-dimensional indexing with matrix and data frame columns (#440)", {
  df <- tibble::tibble(
    x = 1:3,
    y = matrix(9:1, ncol = 3),
    z = tibble::tibble(a = 1:3, b = 3:1)
  )

  expect_identical(df[[1, "y"]], df[1, ]$y)
  expect_identical(df[[1, "z"]], df[1, ]$z)
})

# $ -----------------------------------------------------------------------

test_that("$ throws warning if name doesn't exist", {
  df <- tibble(x = 1)
  expect_warning(
    expect_null(df$y),
    "Unknown or uninitialised column: `y`",
    fixed = TRUE
  )
})

test_that("$ doesn't do partial matching", {
  df <- tibble(partial = 1)
  expect_warning(
    expect_null(df$p),
    "Unknown or uninitialised column: `p`",
    fixed = TRUE
  )
  expect_warning(
    expect_null(df$part),
    "Unknown or uninitialised column: `part`",
    fixed = TRUE
  )
  expect_error(df$partial, NA)
})

# [[<- --------------------------------------------------------------------

test_that("[[<-.tbl_df can remove columns (#666)", {
  df <- tibble(x = 1:2, y = x)
  df[["x"]] <- NULL
  expect_identical(df, tibble(y = 1:2))
  df[["z"]] <- NULL
  expect_identical(df, tibble(y = 1:2))
})

# [<- ---------------------------------------------------------------------

test_that("[<-.tbl_df throws an error with duplicate indexes (#658)", {
  df <- tibble(x = 1:2, y = x)
  expect_tibble_error(
    df[c(1, 1)] <- 3,
    error_duplicate_column_subscript_for_assignment(c(1, 1))
  )
  expect_tibble_error(
    df[, c(1, 1)] <- 3,
    error_duplicate_column_subscript_for_assignment(c(1, 1))
  )
  expect_tibble_error(
    df[c(1, 1), ] <- 3,
    error_duplicate_row_subscript_for_assignment(c(1, 1))
  )
})

test_that("[<-.tbl_df supports adding new rows with [i, j] (#651)", {
  df <- tibble(x = 1:2, y = x)
  df[3, "x"] <- 3
  expect_identical(df, tibble(x = 1:3, y = c(1:2, NA)))
})

test_that("[<-.tbl_df supports adding new columns with [i, j] (#651)", {
  df <- tibble(x = 1:2, y = x)
  df[2, "z"] <- 3
  expect_identical(df, tibble(x = 1:2, y = x, z = c(NA, 3)))
})

test_that("[<-.tbl_df supports adding new rows and columns with [i, j] (#651)", {
  df <- tibble(x = 1:2, y = x)
  df[3, "z"] <- 3
  expect_identical(df, tibble(x = c(1:2, NA), y = x, z = c(NA, NA, 3)))
})

test_that("[<- with explicit NULL doesn't change anything (#696)", {
  iris_tbl_orig <- as_tibble(iris)

  iris_tbl <- iris_tbl_orig
  iris_tbl[NULL] <- NA
  expect_identical(iris_tbl, iris_tbl_orig)

  iris_tbl <- iris_tbl_orig
  iris_tbl[, NULL] <- NA
  expect_identical(iris_tbl, iris_tbl_orig)

  iris_tbl <- iris_tbl_orig
  iris_tbl[NULL, ] <- NA
  expect_identical(iris_tbl, iris_tbl_orig)

  iris_tbl <- iris_tbl_orig
  iris_tbl[NULL, NULL] <- NA
  expect_identical(iris_tbl, iris_tbl_orig)
})

# $<- ---------------------------------------------------------------------

test_that("$<- doesn't throw warning if name doesn't exist", {
  df <- tibble(x = 1)
  expect_warning(
    df$y <- 2,
    NA
  )
  expect_identical(df, tibble(x = 1, y = 2))
})

test_that("$<- throws different warning if attempting a partial initialization (#199)", {
  df <- tibble(x = 1:3)
  expect_warning(
    df$y[1] <- 2,
    "Unknown or uninitialised column: `y`",
    fixed = TRUE
  )

  expect_tibble_error(
    expect_warning(
      df$z[1:2] <- 2,
      "Unknown or uninitialised column: `z`",
      fixed = TRUE
    ),
    error_inconsistent_cols(3, "z", 2, "Existing data")
  )
})

test_that("$<- recycles only values of length one", {
  df <- tibble(x = 1:3)

  df$y <- 4
  expect_identical(df, tibble(x = 1:3, y = 4))

  df$z <- 5:7
  expect_identical(df, tibble(x = 1:3, y = 4, z = 5:7))

  expect_tibble_error(
    df$w <- 8:9,
    error_inconsistent_cols(3, "w", 2, "Existing data")
  )

  expect_tibble_error(
    df$a <- character(),
    error_inconsistent_cols(3, "a", 0, "Existing data")
  )
})

test_that("[[<- restores class", {
  # Requires r-lib/vctrs#690
  skip("r-lib/vctrs#690")

  df <- dplyr::group_by(mtcars, cyl)
  df[[1]] <- mtcars$cyl
  expect_is(df, "grouped_df")

  df <- dplyr::group_by(mtcars, cyl)
  df[[2]] <- mtcars$vs
  expect_is(df, "grouped_df")
  expect_identical(dplyr::group_data(df)$cyl, c(0, 1))
})

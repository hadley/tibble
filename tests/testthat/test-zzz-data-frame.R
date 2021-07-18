test_that("tibble returns correct number of rows with all combinatinos", {
  expect_equal(nrow(tibble(value = 1:10)), 10L)
  expect_equal(nrow(tibble(value = 1:10, name = "recycle_me")), 10L)
  expect_equal(nrow(tibble(name = "recycle_me", value = 1:10)), 10L)
  expect_equal(nrow(tibble(name = "recycle_me", value = 1:10, value2 = 11:20)), 10L)
  expect_equal(nrow(tibble(value = 1:10, name = "recycle_me", value2 = 11:20)), 10L)
})

test_that("dim attribute is stripped of 1D array (#84)", {
  skip_brk_inner_dim_not_stripped()
  expect_null(dim(tibble(x = array(1:3))$x))
})

test_that("bogus columns raise an error", {
  skip_enh_tibble_null()
  expect_error(
    tibble(a = NULL),
    error_column_scalar_type("a", "NULL"),
    fixed = TRUE
  )
})

test_that("bogus columns raise an error", {
  expect_legacy_error(
    tibble(a = new.env()),
    error_column_scalar_type("a", "environment"),
    fixed = TRUE
  )
  expect_legacy_error(
    tibble(a = quote(a)),
    error_column_scalar_type("a", "name"),
    fixed = TRUE
  )
})

test_that("length 1 vectors are recycled", {
  expect_equal(nrow(tibble(x = 1:10)), 10)
  expect_equal(nrow(tibble(x = 1:10, y = 1)), 10)
  expect_legacy_error(
    tibble(x = 1:10, y = 1:2),
    error_inconsistent_cols(NULL, c("x", "y"), c(10, 2), NA),
    fixed = TRUE
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

test_that("names are stripped from vectors", {
  skip_brk_inner_names_not_stripped()
  foo <- tibble(x = c(y = 1, z = 2))
  expect_equal(names(foo), "x")
  expect_null(names(foo$x))
})

test_that("names in list columns are preserved", {
  foo <- tibble(x = list(y = 1:3, z = 4:5))
  expect_equal(names(foo), "x")
  expect_equal(names(foo$x), c("y", "z"))
})

test_that("unknown attributes are not preserved", {
  df <- structure(
    data.frame(x = 1:10, g1 = rep(1:2, each = 5), g2 = rep(1:5, 2)),
    meta = "this is extra"
  )
  res <- as_tibble(df)

  expect_identical(attr(res, "meta"), NULL)
})

test_that("tibble aliases", {
  scoped_lifecycle_silence()
  expect_identical(data_frame(a = 1), tibble(a = 1))

  skip_int_data_frame_tibble_diff()
  expect_identical(data_frame_, tibble_)
})


# as_tibble -----------------------------------------------------------

test_that("columns are recycled to common length", {
  expect_identical(
    as_tibble(list(x = 1, y = 1:3)),
    tibble(x = rep(1, 3), y = 1:3)
  )
  expect_identical(
    as_tibble(list(x = 1:3, y = 1)),
    tibble(x = 1:3, y = rep(1, 3))
  )
  expect_identical(
    as_tibble(list(x = character(), y = 1)),
    tibble(x = character(), y = numeric())
  )
})

test_that("columns must be same length", {
  expect_legacy_error(
    as_tibble(list(x = 1:2, y = 1:3)),
    error_inconsistent_cols(NULL,  c("x", "y"), 2:3, NA),
    fixed = TRUE
  )
  expect_legacy_error(
    as_tibble(list(x = 1:2, y = 1:3, z = 1:4)),
    error_inconsistent_cols(
      NULL,
      c("x", "y", "z"),
      2:4,
      NA
    ),
    fixed = TRUE
  )
  expect_legacy_error(
    as_tibble(list(x = 1:4, y = 1:2, z = 1:2)),
    error_inconsistent_cols(
      NULL,
      c("x", "y", "z"),
      c(4, 2, 2),
      NA
    ),
    fixed = TRUE
  )
  expect_legacy_error(
    as_tibble(list(x = 1, y = 1:4, z = 1:2)),
    error_inconsistent_cols(
      NULL,
      c("y", "z"),
      c(4, 2),
      NA
    ),
    fixed = TRUE
  )
  expect_legacy_error(
    as_tibble(list(x = 1:2, y = 1:4, z = 1)),
    error_inconsistent_cols(
      NULL,
      c("x", "y"),
      c(2, 4),
      NA
    ),
    fixed = TRUE
  )
})

test_that("empty list() makes 0 x 0 tbl_df", {
  zero <- as_tibble(list())
  expect_s3_class(zero, "tbl_df")
  expect_equal(dim(zero), c(0L, 0L))
})


test_that("NULL makes 0 x 0 tbl_df", {
  nnnull <- as_tibble(NULL)
  expect_s3_class(nnnull, "tbl_df")
  expect_equal(dim(nnnull), c(0L, 0L))
})


test_that("as_tibble.tbl_df() leaves classes unchanged (#60)", {
  df <- tibble()
  expect_equal(
    class(df),
    c("tbl_df", "tbl", "data.frame")
  )
  expect_equal(
    class(structure(df, class = c("my_df", class(df)))),
    c("my_df", "tbl_df", "tbl", "data.frame")
  )
})


test_that("Can convert tables to data frame", {
  mtcars_table <- xtabs(mtcars, formula = ~vs + am + cyl)

  mtcars2 <- as_tibble(mtcars_table)
  expect_equal(names(mtcars2), c(names(dimnames(mtcars_table)), "n"))

  expect_warning(
    mtcars2 <- as_tibble(mtcars_table, "Freq"),
    "named argument",
    fixed = TRUE
  )
  expect_equal(names(mtcars2), c(names(dimnames(mtcars_table)), "Freq"))

  mtcars2 <- as_tibble(mtcars_table, n = "Freq")
  expect_equal(names(mtcars2), c(names(dimnames(mtcars_table)), "Freq"))
})


test_that("Can convert unnamed atomic vectors to tibble by default", {
  skip_enh_as_tibble_retired()

  scoped_lifecycle_warnings()
  expect_warning(
    expect_equal(as_tibble(1:3), tibble(value = 1:3)),
    "discouraged",
    fixed = TRUE
  )

  expect_warning(
    expect_equal(as_tibble(c(TRUE, FALSE, NA)), tibble(value = c(TRUE, FALSE, NA))),
    "discouraged",
    fixed = TRUE
  )

  expect_warning(
    expect_equal(as_tibble(1.5:3.5), tibble(value = 1.5:3.5)),
    "discouraged",
    fixed = TRUE
  )

  expect_warning(
    expect_equal(as_tibble(letters), tibble(value = letters)),
    "discouraged",
    fixed = TRUE
  )
})


test_that("Can convert named atomic vectors to data frame", {
  skip("Do we want an .as_row argument?")
  expect_equal(as_tibble(setNames(nm = 1:3)), tibble(`1` = 1L, `2` = 2L, `3` = 3L))
  expect_equal(as_tibble(setNames(nm = c(TRUE, FALSE))), tibble(`TRUE` = TRUE, `FALSE` = FALSE))
  expect_equal(as_tibble(setNames(nm = 1.5:3.5)), tibble(`1.5` = 1.5, `2.5` = 2.5, `3.5` = 3.5))
  expect_equal(as_tibble(setNames(nm = letters)), tibble(!!!setNames(nm = letters)))

  expect_error(
    as_tibble(setNames(nm = c(TRUE, FALSE, NA))),
    invalid_df("must be named", 3),
    fixed = TRUE
  )
})

test_that("as_tibble() checks for `unique` names by default (#278)", {
  l1 <- list(1:10)
  expect_legacy_error(
    as_tibble(l1),
    error_column_must_be_named(1, repair_hint = TRUE),
    fixed = TRUE
  )

  l2 <- list(x = 1, 2)
  expect_legacy_error(
    as_tibble(l2),
    error_column_must_be_named(2, repair_hint = TRUE),
    fixed = TRUE
  )

  l3 <- list(x = 1, ... = 2)
  expect_legacy_error(
    as_tibble(l3),
    error_column_must_not_be_dot_dot(2, repair_hint = TRUE),
    fixed = TRUE
  )

  l4 <- list(x = 1, ..1 = 2)
  expect_legacy_error(
    as_tibble(l4),
    error_column_must_not_be_dot_dot(2, repair_hint = TRUE),
    fixed = TRUE
  )

  df <- list(a = 1, b = 2)
  names(df) <- c("", NA)
  df <- new_tibble(df, nrow = 1)
  expect_legacy_error(
    as_tibble(df),
    error_column_must_be_named(1:2, repair_hint = TRUE),
    fixed = TRUE
  )
})

test_that("as_tibble() makes names `minimal`, even if not fixing names", {
  invalid_df <- as_tibble(list(3, 4, 5), .name_repair = "minimal")
  expect_equal(length(invalid_df), 3)
  expect_equal(nrow(invalid_df), 1)
  expect_equal(names(invalid_df), rep("", 3))
})

test_that("as_tibble() implements unique names", {
  suppressMessages(
    invalid_df <- as_tibble(list(3, 4, 5), .name_repair = "unique")
  )
  expect_equal(length(invalid_df), 3)
  expect_equal(nrow(invalid_df), 1)
  expect_equal(names(invalid_df), unique_names(rep("", 3)))
})

test_that("as_tibble() implements universal names", {
  suppressMessages(
    invalid_df <- as_tibble(list(3, 4, 5), .name_repair = "universal")
  )
  expect_equal(length(invalid_df), 3)
  expect_equal(nrow(invalid_df), 1)
  expect_equal(names(invalid_df), universal_names(rep("", 3)))
})


test_that("as_tibble() implements custom name repair", {
  invalid_df <- as_tibble(
    list(3, 4, 5),
    .name_repair = function(x) make.names(x, unique = TRUE)
  )
  expect_equal(length(invalid_df), 3)
  expect_equal(nrow(invalid_df), 1)
  expect_equal(names(invalid_df), make.names(rep("", 3), unique = TRUE))

  invalid_df_purrr <- as_tibble(
    list(3, 4, 5),
    .name_repair = ~make.names(., unique = TRUE)
  )
  expect_identical(invalid_df_purrr, invalid_df)
})

test_that("as_tibble.matrix() supports validate (with warning) (#558)", {
  scoped_lifecycle_silence()

  expect_identical(
    as_tibble(diag(3), validate = TRUE),
    tibble(
      V1 = c(1, 0, 0),
      V2 = c(0, 1, 0),
      V3 = c(0, 0, 1)
    )
  )
})

test_that("as_tibble.matrix() supports .name_repair", {
  scoped_lifecycle_errors() # When removing this, double-check error messages below.

  x <- matrix(1:6, nrow = 3)

  skip_int_lifecycle()

  expect_error(
    as_tibble(x),
    class = get_defunct_error_class(),
    "name",
    fixed = TRUE
  )
})

test_that("as_tibble.matrix() supports .name_repair", {
  scoped_lifecycle_errors() # When removing this, double-check error messages below.

  x <- matrix(1:6, nrow = 3)

  expect_identical(
    names(as_tibble(x, .name_repair = "minimal")),
    rep("", 2)
  )
  expect_identical(
    names(suppressMessages(as_tibble(x, .name_repair = "universal"))),
    paste0("...", 1:2)
  )

  x <- matrix(1:6, nrow = 3, dimnames = list(x = LETTERS[1:3], y = c("if", "when")))

  expect_identical(
    names(as_tibble(x)),
    c("if", "when")
  )
  expect_identical(
    names(as_tibble(x, .name_repair = "minimal")),
    c("if", "when")
  )
  expect_identical(
    names(suppressMessages(as_tibble(x, .name_repair = "universal"))),
    c(".if", "when")
  )
})

test_that("as_tibble.poly() supports .name_repair", {
  x <- poly(1:6, 3)

  expect_identical(
    names(as_tibble(x)),
    as.character(1:3)
  )
  expect_identical(
    names(as_tibble(x, .name_repair = "minimal")),
    as.character(1:3)
  )
  expect_identical(
    names(suppressMessages(as_tibble(x, .name_repair = "universal"))),
    paste0("...", 1:3)
  )
})

test_that("as_tibble.table() supports .name_repair", {
  x <- table(a = c(1, 1, 1, 2, 2, 2), a = c(3, 4, 5, 3, 4, 5))

  expect_legacy_error(
    as_tibble(x),
    error_column_names_must_be_unique("a")
  )
  expect_identical(
    names(as_tibble(x, .name_repair = "minimal")),
    c("a", "a", "n")
  )
  expect_identical(
    names(suppressMessages(as_tibble(x, .name_repair = "universal"))),
    c("a...1", "a...2", "n")
  )

  x <- table("if" = c(1, 1, 1, 2, 2, 2), "when" = c(3, 4, 5, 3, 4, 5))

  expect_identical(
    names(as_tibble(x)),
    c("if", "when", "n")
  )
  expect_identical(
    names(as_tibble(x, .name_repair = "minimal")),
    c("if", "when", "n")
  )
  expect_identical(
    names(suppressMessages(as_tibble(x, .name_repair = "universal"))),
    c(".if", "when", "n")
  )

  x <- table("m" = c(1, 1, 1, 2, 2, 2), "n" = c(3, 4, 5, 3, 4, 5))

  expect_identical(
    names(as_tibble(x, .name_repair = "minimal")),
    c("m", "n", "n")
  )
  expect_identical(
    names(suppressMessages(as_tibble(x, .name_repair = "universal"))),
    c("m", "n...2", "n...3")
  )
})

test_that("as_tibble.ts() supports .name_repair, minimal by default (#537)", {
  x <- ts(matrix(rnorm(6), nrow = 3), start = c(1961, 1), frequency = 12, names = NULL)

  expect_identical(
    names(as_tibble(x)),
    rep("", 2)
  )
  expect_identical(
    names(as_tibble(x, .name_repair = "minimal")),
    rep("", 2)
  )
  expect_identical(
    names(suppressMessages(as_tibble(x, .name_repair = "universal"))),
    paste0("...", 1:2)
  )

  x <- ts(matrix(rnorm(6), nrow = 3), start = c(1961, 1), frequency = 12, names = c("if", "when"))

  expect_identical(
    names(as_tibble(x)),
    c("if", "when")
  )
  expect_identical(
    names(as_tibble(x, .name_repair = "minimal")),
    c("if", "when")
  )
  expect_identical(
    names(suppressMessages(as_tibble(x, .name_repair = "universal"))),
    c(".if", "when")
  )
})

test_that("as_tibble() can convert row names", {
  df <- data.frame(a = 1:3, b = 2:4, row.names = letters[5:7])

  expect_identical(
    as_tibble(df, rownames = NULL),
    tibble(a = 1:3, b = 2:4)
  )
  expect_identical(
    as_tibble(df, rownames = "id"),
    tibble(id = letters[5:7], a = 1:3, b = 2:4)
  )
  tbl_df <- as_tibble(df, rownames = NA)
  expect_identical(rownames(tbl_df), rownames(df))
  expect_identical(unclass(tbl_df), unclass(df))
})

test_that("as_tibble() can convert row names for zero-row tibbles", {
  df <- data.frame(a = 1:3, b = 2:4, row.names = letters[5:7])[0, ]

  expect_identical(
    as_tibble(df, rownames = NULL),
    tibble(a = integer(), b = integer())
  )
  expect_identical(
    as_tibble(df, rownames = "id"),
    tibble(id = character(), a = integer(), b = integer())
  )
  tbl_df <- as_tibble(df, rownames = NA)
  expect_identical(rownames(tbl_df), rownames(df))
  expect_identical(unclass(tbl_df), unclass(df))
})

test_that("as_tibble() throws an error when user turns missing row names into column", {
  skip_enh_as_tibble_rownames()

  df <- data.frame(a = 1:3, b = 2:4)
  expect_legacy_error(
    as_tibble(df, rownames = "id"),
    error_as_tibble_needs_rownames(),
    fixed = TRUE
  )
  expect_legacy_error(
    as_tibble(df[0, ], rownames = "id"),
    error_as_tibble_needs_rownames(),
    fixed = TRUE
  )
})

test_that("as_data_frame is an alias of as_tibble", {
  scoped_lifecycle_silence()
  expect_identical(as_data_frame(NULL), as_tibble(NULL))
})

test_that("as.tibble is an alias of as_tibble", {
  scoped_lifecycle_silence()
  expect_identical(as.tibble(NULL), as_tibble(NULL))
})

# Validation --------------------------------------------------------------

test_that("POSIXlt isn't a valid column", {
  skip_enh_posixlt_supported()
  expect_legacy_error(
    check_valid_cols(list(x = as.POSIXlt(Sys.time()))),
    error_time_column_must_be_posixct("x"),
    fixed = TRUE
  )
})

test_that("NULL isn't a valid column", {
  expect_legacy_error(
    check_valid_cols(list(a = NULL)),
    error_column_scalar_type("a", "NULL"),
    fixed = TRUE
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

test_that("`validate` triggers deprecation message, but then works", {
  scoped_lifecycle_warnings()

  expect_legacy_error(
    expect_warning(
      as_tibble(list(a = 1, "hi"), validate = TRUE),
      "deprecated",
      fixed = TRUE
    ),
    error_column_must_be_named(2, repair_hint = TRUE)
  )

  expect_warning(
    df <- as_tibble(list(a = 1, "hi", a = 2), validate = FALSE),
    "deprecated",
    fixed = TRUE
  )
  expect_identical(names(df), c("a", "", "a"))

  df <- data.frame(a = 1, "hi", a = 2)
  names(df) <- c("a", "", "a")
  expect_warning(
    df <- as_tibble(df, validate = FALSE),
    "deprecated",
    fixed = TRUE
  )
  expect_identical(names(df), c("a", "", "a"))

  df <- data.frame(a = 1, "hi")
  names(df) <- c("a", "")
  expect_legacy_error(
    expect_warning(
      as_tibble(df, validate = TRUE),
      "deprecated",
      fixed = TRUE
    ),
    error_column_must_be_named(2, repair_hint = TRUE)
  )
})

test_that("Consistent `validate` and `.name_repair` used together keep silent.", {
  skip_legacy()

  scoped_lifecycle_warnings()

  expect_legacy_error(
    expect_warning(
      as_tibble(list(a = 1, "hi"), validate = TRUE, .name_repair = "check_unique"),
      NA
    ),
    error_column_must_be_named(2, repair_hint = TRUE)
  )

  expect_warning(
    df <- as_tibble(list(a = 1, "hi", a = 2), validate = FALSE, .name_repair = "minimal"),
    NA
  )
  expect_identical(names(df), c("a", "", "a"))

  df <- data.frame(a = 1, "hi", a = 2)
  names(df) <- c("a", "", "a")
  expect_warning(
    df <- as_tibble(df, validate = FALSE, .name_repair = "minimal"),
    NA
  )
  expect_identical(names(df), c("a", "", "a"))

  df <- data.frame(a = 1, "hi")
  names(df) <- c("a", "")
  expect_legacy_error(
    expect_warning(
      as_tibble(df, validate = TRUE, .name_repair = "check_unique"),
      NA
    ),
    error_column_must_be_named(2, repair_hint = TRUE)
  )
})

test_that("Inconsistent `validate` and `.name_repair` used together raise a warning.", {
  skip_legacy()

  expect_legacy_error(
    expect_warning(
      as_tibble(list(a = 1, "hi"), validate = FALSE, .name_repair = "check_unique"),
      "precedence"
    ),
    error_column_must_be_named(2, repair_hint = TRUE)
  )

  expect_warning(
    df <- as_tibble(list(a = 1, "hi", a = 2), validate = TRUE, .name_repair = "minimal"),
    "precedence"
  )
  expect_identical(names(df), c("a", "", "a"))

  df <- data.frame(a = 1, "hi", a = 2)
  names(df) <- c("a", "", "a")
  expect_warning(
    df <- as_tibble(df, validate = TRUE, .name_repair = "minimal"),
    "precedence"
  )
  expect_identical(names(df), c("a", "", "a"))

  df <- data.frame(a = 1, "hi")
  names(df) <- c("a", "")
  expect_legacy_error(
    expect_warning(
      as_tibble(df, validate = FALSE, .name_repair = "check_unique"),
      "precedence"
    ),
    error_column_must_be_named(2, repair_hint = TRUE)
  )
})


# Data frame and matrix columns -------------------------------------------

test_that("can make tibble containing data.frame or array (#416)", {
  skip_brk_auto_splice_anonymous()
  expect_identical(
    tibble(mtcars),
    new_tibble(list(mtcars = remove_rownames(mtcars)), nrow = nrow(mtcars))
  )
})

test_that("can make tibble containing data.frame or array (#416)", {
  expect_identical(
    tibble(diag(5)),
    new_tibble(list(`diag(5)` = diag(5)), nrow = 5)
  )
})

test_that("can coerce list data.frame or array (#416)", {
  skip_brk_inner_data_frames()
  expect_identical(
    as_tibble(list(x = mtcars)),
    new_tibble(list(x = remove_rownames(mtcars)), nrow = nrow(mtcars))
  )
})

test_that("can coerce list data.frame or array (#416)", {
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

#' Coerce lists, matrices, and more to data frames
#'
#' @description
#' \lifecycle{maturing}
#'
#' `as_tibble()` turns an existing object, such as a data frame or
#' matrix, into a so-called tibble, a data frame with class [`tbl_df`]. This is
#' in contrast with [tibble()], which builds a tibble from individual columns.
#' `as_tibble()` is to [`tibble()`] as [base::as.data.frame()] is to
#' [base::data.frame()].
#'
#' `as_tibble()` is an S3 generic, with methods for:
#' * [`data.frame`][base::data.frame()]: Thin wrapper around the `list` method
#'   that implements tibble's treatment of [rownames].
#' * [`matrix`][methods::matrix-class], [`poly`][stats::poly()],
#'   [`ts`][stats::ts()], [`table`][base::table()]
#' * Default: Other inputs are first coerced with [base::as.data.frame()].
#'
#' @section Row names:
#' The default behavior is to silently remove row names.
#'
#' New code should explicitly convert row names to a new column using the
#' `rownames` argument.
#'
#' For existing code that relies on the retention of row names, call
#' `pkgconfig::set_config("tibble::rownames" = NA)` in your script or in your
#' package's [.onLoad()]  function.
#'
#' @seealso [tibble()] constructs a tibble from individual columns. [enframe()]
#'   converts a named vector to a tibble with a column of names and column of
#'   values. Name repair is implemented using [vctrs::vec_as_names()].
#'
#' @param x A data frame, list, matrix, or other object that could reasonably be
#'   coerced to a tibble.
#' @param ... Other arguments passed on to individual methods.
#' @inheritParams tibble
#' @param rownames How to treat existing row names of a data frame or matrix:
#'   * `NULL`: remove row names. This is the default.
#'   * `NA`: keep row names.
#'   * A string: the name of a new column. Existing rownames are transferred
#'     into this column and the `row.names` attribute is deleted.
#'  Read more in [rownames].

#' @param _n,validate
#'   \lifecycle{soft-deprecated}
#'
#'   For compatibility only, do not use for new code.
#' @export
#' @examples
#' m <- matrix(rnorm(50), ncol = 5)
#' colnames(m) <- c("a", "b", "c", "d", "e")
#' df <- as_tibble(m)
#'
#' # Prefer enframe() for vectors
#' enframe(1:3)
#' enframe(1:3, name = NULL)
as_tibble <- function(x, ...,
                      .rows = NULL,
                      .name_repair = c("check_unique", "unique", "universal", "minimal"),
                      rownames = pkgconfig::get_config("tibble::rownames", NULL)) {
  UseMethod("as_tibble")
}

#' @export
#' @rdname as_tibble
as_tibble.data.frame <- function(x, validate = NULL, ...,
                                 .rows = NULL,
                                 .name_repair = c("check_unique", "unique", "universal", "minimal"),
                                 rownames = pkgconfig::get_config("tibble::rownames", NULL)) {

  .name_repair <- compat_name_repair(.name_repair, validate)

  old_rownames <- raw_rownames(x)
  if (is.null(.rows)) {
    .rows <- nrow(x)
  }

  result <- lst_to_tibble(unclass(x), .rows, .name_repair)

  if (is.null(rownames)) {
    result
  } else if (is.na(rownames)) {
    attr(result, "row.names") <- old_rownames
    result
  } else {
    if (length(old_rownames) > 0 && is.na(old_rownames[1L])) {  # if implicit rownames
      old_rownames <- seq_len(abs(old_rownames[2L]))
    }
    old_rownames <- as.character(old_rownames)
    add_column(result, !!rownames := old_rownames, .before = 1L)
  }
}

#' @export
#' @rdname as_tibble
as_tibble.list <- function(x, validate = NULL, ..., .rows = NULL,
                           .name_repair = c("check_unique", "unique", "universal", "minimal")) {

  .name_repair <- compat_name_repair(.name_repair, validate)

  lst_to_tibble(x, .rows, .name_repair, col_lengths(x))
}

lst_to_tibble <- function(x, .rows, .name_repair, lengths = NULL) {
  x <- unclass(x)
  x <- set_repaired_names(x, .name_repair)
  x <- check_valid_cols(x)
  recycle_columns(x, .rows, lengths)
}

compat_name_repair <- function(.name_repair, validate) {
  if (is.null(validate)) return(.name_repair)

  name_repair <- if (isTRUE(validate)) "check_unique" else "minimal"

  if (!has_length(.name_repair, 1)) {
    signal_soft_deprecated("The `validate` argument to `as_tibble()` is deprecated. Please use `.name_repair` to control column names.")
  } else if (.name_repair != name_repair) {
    warn("The `.name_repair` argument to `as_tibble()` takes precedence over the deprecated `validate` argument.")
    return(.name_repair)
  }

  name_repair
}

check_valid_cols <- function(x) {
  names_x <- names2(x)

  is_xd <- which(!map_lgl(x, is_valid_col))
  if (has_length(is_xd)) {
    classes <- map_chr(x[is_xd], function(x) class(x)[[1]])
    abort(error_column_must_be_vector(names_x[is_xd], attr(x, "pos")[is_xd], classes))
  }

  # 657
  x[] <- map(x, make_valid_col)
  invisible(x)
}

make_valid_col <- function(x) {
  if (is.expression(x)) {
    x <- as.list(x)
  }
  x
}

check_valid_col <- function(x, name, pos) {
  if (name == "") {
    ret <- check_valid_cols(structure(list(x), pos = pos))
  } else {
    ret <- check_valid_cols(list2(!!name := x))
  }
  invisible(ret[[1]])
}

is_valid_col <- function(x) {
  # 657
  vec_is(x) || is.expression(x)
}

recycle_columns <- function(x, .rows, lengths) {
  nrow <- guess_nrow(lengths, .rows)

  # Shortcut if all columns have the requested or implied length
  different_len <- which(lengths != nrow)
  if (is_empty(different_len)) return(new_tibble(x, nrow = nrow, subclass = NULL))

  if (any(lengths[different_len] != 1)) {
    abort(error_inconsistent_cols(.rows, names(x), lengths, "Requested with `.rows` argument"))
  }

  if (nrow != 1L) {
    short <- which(lengths == 1L)
    if (has_length(short)) {
      x[short] <- map(x[short], vec_recycle, nrow)
    }
  }

  new_tibble(x, nrow = nrow, subclass = NULL)
}

guess_nrow <- function(lengths, .rows) {
  if (!is.null(.rows)) {
    return(.rows)
  }
  if (is_empty(lengths)) {
    return(0)
  }

  nontrivial_lengths <- lengths[lengths != 1L]
  if (is_empty(nontrivial_lengths)) {
    return(1)
  }

  max(nontrivial_lengths)
}

#' @export
#' @rdname as_tibble
as_tibble.matrix <- function(x, ..., validate = NULL, .name_repair = NULL) {
  m <- matrixToDataFrame(x)
  names <- colnames(x)
  if (is.null(.name_repair)) {
    if ((is.null(names) || any(bad_names <- duplicated(names) | names == "")) && has_length(x)) {
      signal_soft_deprecated('`as_tibble.matrix()` requires a matrix with column names or a `.name_repair` argument. Using compatibility `.name_repair`.')
      compat_names <- paste0("V", seq_along(m))
      if (is.null(names)) {
        names <- compat_names
      } else {
        names[bad_names] <- compat_names[bad_names]
      }
      .name_repair <- function(x) names
    } else {
      .name_repair <- "check_unique"
    }
    validate <- NULL
  }

  colnames(m) <- names
  as_tibble(m, ..., validate = validate, .name_repair = .name_repair)
}

#' @export
as_tibble.poly <- function(x, ...) {
  m <- matrixToDataFrame(unclass(x))
  colnames(m) <- colnames(x)
  as_tibble(m, ...)
}

#' @export
as_tibble.ts <- function(x, ..., .name_repair = "minimal") {
  df <- as.data.frame(x)
  if (length(dim(x)) == 2) {
    colnames(df) <- colnames(x)
  }
  as_tibble(df, ..., .name_repair = .name_repair)
}

#' @export
#' @param n Name for count column, default: `"n"`.
#' @rdname as_tibble
as_tibble.table <- function(x, `_n` = "n", ..., n = `_n`) {
  if (!missing(`_n`)) {
    warn("Please pass `n` as a named argument to `as_tibble.table()`.")
  }

  df <- as.data.frame(x, stringsAsFactors = FALSE)
  names(df) <- c(names2(dimnames(x)), n)

  as_tibble(df, ...)
}

#' @export
#' @rdname as_tibble
as_tibble.NULL <- function(x, ...) {
  if (missing(x)) {
    signal_soft_deprecated(error_as_tibble_needs_argument())
  }

  new_tibble(list(), nrow = 0)
}

#' @export
#' @rdname as_tibble
as_tibble.default <- function(x, ...) {
  value <- x
  if (is_atomic(value)) {
    signal_soft_deprecated("Calling `as_tibble()` on a vector is discouraged, because the behavior is likely to change in the future. Use `tibble::enframe(name = NULL)` instead.")
  }
  as_tibble(as.data.frame(value, stringsAsFactors = FALSE), ...)
}

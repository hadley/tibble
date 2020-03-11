#' Tibble constructor and validator
#'
#' @description
#' \lifecycle{maturing}
#'
#' Creates or validates a subclass of a tibble.
#' These function is mostly useful for package authors that implement subclasses
#' of a tibble, like \pkg{sf} or \pkg{tsibble}.
#'
#' `new_tibble()` creates a new object as a subclass of `tbl_df`, `tbl` and `data.frame`.
#' This function is optimized for performance, checks are reduced to a minimum.
#'
#' @param x A tibble-like object.
#' @param ... Name-value pairs of additional attributes.
#' @param nrow The number of rows, required.
#' @param class Subclasses to assign to the new object, default: none.
#' @param subclass Deprecated, retained for compatibility. Please use the `class` argument.
#'
#' @seealso
#' [tibble()] and [as_tibble()] for ways to construct a tibble
#' with recycling of scalars and automatic name repair.
#'
#' @export
#' @examples
#' # The nrow argument is always required:
#' new_tibble(list(a = 1:3, b = 4:6), nrow = 3)
#'
#' # Existing row.names attributes are ignored:
#' try(new_tibble(iris, nrow = 3))
#'
#' # The length of all columns must be consistent with the nrow argument:
#' try(new_tibble(list(a = 1:3, b = 4:6), nrow = 2))
new_tibble <- function(x, ..., nrow, class = NULL, subclass = NULL) {
  # For compatibility with tibble < 2.0.0
  if (is.null(class) && !is.null(subclass)) {
    deprecate_soft("2.0.0", "new_tibble(subclass = )", "new_tibble(class = )")
    class <- subclass
  }

  #' @section Construction:
  #'
  #' For `new_tibble()`, `x` must be a list.
  x <- unclass(x)

  if (!is.list(x)) {
    abort(error_new_tibble_must_be_list())
  }

  #' An `nrow` argument is required.
  if (missing(nrow)) {
    cnd <- error_new_tibble_needs_nrow()
    if (length(x) >= 1) {
      deprecate_soft("2.0.0", "new_tibble(nrow = 'can\\'t be missing')",
        details = cnd$message)
      nrow <- NROW(x[[1]])
    } else {
      cnd_signal(cnd)
    }
  }
  #' This should be an integer of length 1,
  #' and every element of the list `x` should have [NROW()]
  #' equal to this value.
  #' (But this is not checked by the constructor).
  #' This takes the place of the "row.names" attribute in a data frame.
  if (is_integerish(nrow, 1)) {
    nrow <- as.integer(nrow)
  } else {
    abort(error_new_tibble_needs_nrow())
  }

  args <- attributes(x)

  if (is.null(args)) {
    args <- list()
  }

  new_attrs <- pairlist2(...)
  nms <- names(new_attrs)

  for (i in seq_along(nms)) {
    nm <- nms[[i]]

    if (nm == "") {
      next
    }

    args[[nm]] <- new_attrs[[i]]
  }

  #' `x` must have names (or be empty),
  #' but the names are not checked for correctness.
  if (length(x) == 0) {
    # Leaving this because creating a named list of length zero seems difficult
    args[["names"]] <- character()
  } else if (is.null(args[["names"]])) {
    abort(error_names_must_be_non_null())
  }

  if (is.null(class)) {
    class <- tibble_class_no_data_frame
  } else {
    class <- c(setdiff(class, tibble_class), tibble_class_no_data_frame)
  }

  slots <- c("x", "n", "class")
  args[slots] <- list(x, nrow, class)

  # `new_data_frame()` restores compact row names
  args[["row.names"]] <- NULL

  do.call(new_data_frame, args)
}

#' @description
#' `validate_tibble()` checks a tibble for internal consistency.
#' Correct behavior can be guaranteed only if this function
#' runs without raising an error.
#'
#' @rdname new_tibble
#' @export
validate_tibble <- function(x) {
  #' @section Validation:
  #' `validate_tibble()` checks for "minimal" names
  check_minimal_names(x)

  #' and that all columns are vectors, data frames or matrices.
  check_valid_cols(unclass(x))

  #' It also makes sure that all columns have the same length,
  #' and that [NROW()] is consistent with the data.
  validate_nrow(names(x), col_lengths(x), NROW(x))

  x
}

col_lengths <- function(x) {
  map_int(x, vec_size)
}

validate_nrow <- function(names, lengths, nrow) {
  # Validate column lengths, don't recycle
  bad_len <- which(lengths != nrow)
  if (has_length(bad_len)) {
    abort(error_inconsistent_cols(nrow, names, lengths, "Requested with `nrow` argument"))
  }
}

tibble_class <- c("tbl_df", "tbl", "data.frame")
tibble_class_no_data_frame <- c("tbl_df", "tbl")

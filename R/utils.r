
has_dim <- function(x) {
  length(dim(x)) > 0L || is_named(x)
}

needs_dim <- function(x) {
  length(dim(x)) > 1L
}

set_class <- `class<-`

is_1d <- function(x) {
  # dimension check is for matrices and data.frames
  is_vector(x) && !needs_dim(x)
}

strip_dim <- function(x) {
  # Careful update only if necessary, to avoid copying which is checked by
  # the "copying" test in dplyr
  if (is_atomic(x) && has_dim(x)) {
    dim(x) <- NULL
  }
  x
}

needs_list_col <- function(x) {
  is_list(x) || length(x) != 1L
}

# Work around bug in R 3.3.0
safe_match <- function(x, table) {
  # nocov start
  if (getRversion() == "3.3.0") {
    match(x, table, incomparables = character())
  } else {
    match(x, table)
  }
  # nocov end
}

stopc <- function(...) {
  stop(..., call. = FALSE, domain = NA)
}

warningc <- function(...) {
  warning(..., call. = FALSE, domain = NA)
}

nchar_width <- function(x) {
  nchar(x, type = "width")
}

cat_line <- function(...) {
  cat(..., "\n", sep = "")
}

is_syntactic <- function(x) {
  ret <- make.names(x) == x
  ret[is.na(x)] <- FALSE
  ret
}

tickit <- function(x) {
  needs_ticks <- !is_syntactic(x)
  x[needs_ticks] <- paste0("`", gsub("`", "\\\\`", x[needs_ticks]), "`")
  x
}

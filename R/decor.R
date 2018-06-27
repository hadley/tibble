#' Decorate a column
#'
#' If the default data output in a tibble doesn't work for you,
#' the `decor_()` family of functions allows overriding it
#' on a column-by-column basis. Call `guess_decor()` for a
#' tibble to guess decorations for all (undecorated)
#' columns in a tibble.
#'
#' Use the scoped functions in \pkg{dplyr} to apply decorations
#' to multiple columns.
#'
#' @section Lifecycle:
#' These functions are experimental.
#'
#' @param x The column data.
#' @param signif The number of significant digits.
#'
#' @export
#' @name decor
decor_num <- function(x, sigfig = getOption("pillar.sigfig", 3)) {
  stopifnot(is.numeric(x))
  stopifnot(is.numeric(sigfig), sigfig >= 0)

  new_decor(x, sigfig = sigfig, subclass = "decor_num")
}

#' @param min_width Avoid shortening the column below this
#'   width.
#' @export
#' @rdname decor
decor_chr <- function(x, min_width = 3L) {
  stopifnot(is.character(x))
  stopifnot(is.numeric(min_width), min_width >= 0)

  new_decor(x, min_width = min_width, subclass = "decor_chr")
}

new_decor <- function(x, ..., subclass) {
  stopifnot(is.character(subclass), length(subclass) > 0)

  structure(
    x,
    ...,
    # TODO: Is this class name sufficient, or use tibble_decor?
    class = c(subclass, "decor")
  )
}

#' @export
`[.decor` <- function(x, i) {
  # TODO: Is this a pattern worth extracting to vctrs or rlang?
  invoke(structure, c(list(unclass(x)[i]), attributes(x)))
}

#' @export
type_sum.decor_num <- function(x) {
  paste0("num", attr(x, "sigfig"))
}

#' @export
type_sum.decor <- function(x) {
  type_sum(unclass(x))
}

#' @importFrom pillar pillar_shaft
#' @export
pillar_shaft.decor_num <- function(x, ...) {
  pillar_shaft(unclass(x), sigfig = attr(x, "sigfig"))
}

#' @export
pillar_shaft.decor_chr <- function(x, ...) {
  pillar_shaft(unclass(x), min_width = attr(x, "min_width"))
}

# TODO: Blog post, image candidate:
# https://images.unsplash.com/photo-1515627043029-d5fcda8b150d?ixlib=rb-0.3.5&q=85&fm=jpg&crop=entropy&cs=srgb&dl=fabio-ballasina-509521-unsplash.jpg&s=064aaad847b663bc033ee6d0b4c83bec

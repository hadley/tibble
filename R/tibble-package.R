#' @useDynLib tibble, .registration = TRUE
#' @importFrom utils head tail
#' @importFrom pkgconfig set_config
#' @import rlang
#' @import lifecycle
#' @importFrom vctrs vec_as_location vec_as_location2 vec_as_names vec_as_names_legacy vec_c
#' @importFrom vctrs vec_is vec_rbind vec_recycle vec_size vec_slice vec_slice<-
#' @importFrom vctrs unspecified
#' @importFrom vctrs new_data_frame
#' @aliases NULL tibble-package
#' @details
#' \lifecycle{stable}
#'
#' The tibble package provides utilities for handling __tibbles__, where
#' "tibble" is a colloquial term for the S3 [`tbl_df`] class. The [`tbl_df`]
#' class is a special case of the base [`data.frame`][base::data.frame()].
#' class, developed in response to lessons learned over many years of data
#' analysis with data frames.
#'
#' Tibble is the central data structure for the set of packages known as the
#' [tidyverse](https://www.tidyverse.org/packages/), including
#' [dplyr](http://dplyr.tidyverse.org/),
#' [ggplot2](http://ggplot2.tidyverse.org/),
#' [tidyr](http://tidyr.tidyverse.org/), and
#' [readr](http://readr.tidyverse.org/).
#'
#' General resources:
#'   * Website for the tibble package: <https://tibble.tidyverse.org>
#'   * [Tibbles chapter](http://r4ds.had.co.nz/tibbles.html) in *R for Data
#'     Science*
#'
#' Resources on specific topics:
#'   * Create a tibble: [tibble()], [as_tibble()], [tribble()], [enframe()]
#'   * Inspect a tibble: [print.tbl()], [glimpse()]
#'   * Details on the S3 `tbl_df` class: [`tbl_df-class`]
"_PACKAGE"

## user-facing docs kept in `formatting` topic; see utils-format.r
op.tibble <- list(
  tibble.print_max = 20L,
  tibble.print_min = 10L,
  tibble.width = NULL,
  tibble.max_extra_cols = 100L
)

tibble_opt <- function(x) {
  x_tibble <- paste0("tibble.", x)
  res <- getOption(x_tibble)
  if (!is.null(res)) {
    return(res)
  }

  x_dplyr <- paste0("dplyr.", x)
  res <- getOption(x_dplyr)
  if (!is.null(res)) {
    return(res)
  }

  op.tibble[[x_tibble]]
}

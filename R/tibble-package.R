#' @useDynLib tibble, .registration = TRUE
#' @importFrom utils head tail
#' @importFrom pkgconfig set_config
#' @import rlang
#' @import lifecycle
#' @import ellipsis
#' @importFrom vctrs vec_as_location vec_as_location2 vec_as_names vec_as_names_legacy vec_c
#' @importFrom vctrs vec_is vec_rbind vec_recycle vec_size vec_slice vec_assign
#' @importFrom vctrs vec_cbind
#' @importFrom vctrs unspecified vec_as_subscript2 num_as_location vec_ptype_abbr
#' @importFrom vctrs vec_names2 vec_set_names
#' @aliases NULL tibble-package
#' @details
#' `r lifecycle::badge("stable")`
#'
#' The tibble package provides utilities for handling __tibbles__, where
#' "tibble" is a colloquial term for the S3 [`tbl_df`] class. The [`tbl_df`]
#' class is a special case of the base [`data.frame`][base::data.frame()].
#' class, developed in response to lessons learned over many years of data
#' analysis with data frames.
#'
#' Tibble is the central data structure for the set of packages known as the
#' [tidyverse](https://www.tidyverse.org/packages/), including
#' [dplyr](https://dplyr.tidyverse.org/),
#' [ggplot2](https://ggplot2.tidyverse.org/),
#' [tidyr](https://tidyr.tidyverse.org/), and
#' [readr](https://readr.tidyverse.org/).
#'
#' General resources:
#'   * Website for the tibble package: <https://tibble.tidyverse.org>
#'   * [Tibbles chapter](https://r4ds.had.co.nz/tibbles.html) in *R for Data
#'     Science*
#'
#' Resources on specific topics:
#'   * Create a tibble: [tibble()], [as_tibble()], [tribble()], [enframe()]
#'   * Inspect a tibble: [print.tbl()], [glimpse()]
#'   * Details on the S3 `tbl_df` class: [`tbl_df-class`]
#' @inheritSection formatting Package options
#' @section Package options:
#' The following option is used for viewing tabular data with `view()`:
#' - `tibble.view_max`: Maximum number of rows shown if the input is not a
#'   data frame. Default: 1000.
"_PACKAGE"

# anomalize

<details>

* Version: 0.2.0
* Source code: https://github.com/cran/anomalize
* URL: https://github.com/business-science/anomalize
* BugReports: https://github.com/business-science/anomalize/issues
* Date/Publication: 2019-09-21 04:10:03 UTC
* Number of recursive dependencies: 161

Run `revdep_details(,"anomalize")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    Attaching package: ‘dplyr’
    
    The following objects are masked from ‘package:stats’:
    
        filter, lag
    
    The following objects are masked from ‘package:base’:
    
        intersect, setdiff, setequal, union
    
    > 
    > # Needed to pass CRAN check / This is loaded by default
    > set_time_scale_template(time_scale_template())
    > 
    > data(tidyverse_cran_downloads)
    > 
    > tidyverse_cran_downloads %>%
    +     time_decompose(count, method = "stl") %>%
    +     anomalize(remainder, method = "iqr")
    Error: `.data` is a corrupt grouped_df, the `"groups"` attribute must be a data frame
    Execution halted
    ```

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 23 | SKIPPED: 0 | WARNINGS: 0 | FAILED: 25 ]
      1. Error: gesd can handle low variance data (@test-anomalize.R#142) 
      2. Error: iqr_grouped_df works (@test-anomalize.R#153) 
      3. Error: gesd_grouped_df works (@test-anomalize.R#166) 
      4. Error: (unknown) (@test-clean_anomalies.R#3) 
      5. Error: returns a ggplot (@test-plot_anomalies.R#8) 
      6. Error: returns a ggplot (@test-plot_anomaly_decomposition.R#10) 
      7. Error: grouped_tbl_time works (@test-time_apply.R#11) 
      8. Error: tbl_time works (@test-time_apply.R#17) 
      9. Error: single tbl_df (@test-time_decompose.R#14) 
      1. ...
      
      Error: testthat unit tests failed
      Execution halted
    ```

# dplyr

<details>

* Version: 0.8.5
* Source code: https://github.com/cran/dplyr
* URL: http://dplyr.tidyverse.org, https://github.com/tidyverse/dplyr
* BugReports: https://github.com/tidyverse/dplyr/issues
* Date/Publication: 2020-03-07 12:20:02 UTC
* Number of recursive dependencies: 94

Run `revdep_details(,"dplyr")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      `res` not equal to "this is important".
      target is NULL, current is character
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 3401 | SKIPPED: 14 | WARNINGS: 7 | FAILED: 5 ]
      1. Failure: filter, slice and arrange preserves attributes (#1064) (@test-filter.r#245) 
      2. Failure: filter, slice and arrange preserves attributes (#1064) (@test-filter.r#248) 
      3. Failure: filter, slice and arrange preserves attributes (#1064) (@test-filter.r#251) 
      4. Failure: filter, slice and arrange preserves attributes (#1064) (@test-filter.r#254) 
      5. Failure: filter, slice and arrange preserves attributes (#1064) (@test-filter.r#257) 
      
      Error: testthat unit tests failed
      In addition: Warning message:
      call dbDisconnect() when finished working with a connection 
      Execution halted
    ```

## In both

*   checking installed package size ... NOTE
    ```
      installed size is 31.1Mb
      sub-directories of 1Mb or more:
        libs  28.7Mb
    ```

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 4 marked UTF-8 strings
    ```

# fable

<details>

* Version: 0.2.0
* Source code: https://github.com/cran/fable
* URL: https://fable.tidyverts.org, https://github.com/tidyverts/fable
* BugReports: https://github.com/tidyverts/fable/issues
* Date/Publication: 2020-04-22 13:12:08 UTC
* Number of recursive dependencies: 99

Run `revdep_details(,"fable")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    Error: The `key` attribute must be a data frame with its last column called `.rows`.
    Backtrace:
         █
      1. ├─fit %>% forecast() %>% autoplot(luteinizing_hormones)
      2. │ ├─base::withVisible(eval(quote(`_fseq`(`_lhs`)), env, env))
      3. │ └─base::eval(quote(`_fseq`(`_lhs`)), env, env)
      4. │   └─base::eval(quote(`_fseq`(`_lhs`)), env, env)
      5. │     └─`_fseq`(`_lhs`)
      6. │       └─magrittr::freduce(value, `_function_list`)
      7. │         └─function_list[[i]](value)
      8. │           ├─fabletools::forecast(.)
      9. │           └─fabletools:::forecast.mdl_df(.)
     10. │             └─dplyr::mutate_at(...)
     11. │               ├─dplyr::mutate(.tbl, !!!funs)
     12. │               └─dplyr:::mutate.tbl_df(.tbl, !!!funs)
     13. │                 └─dplyr:::mutate_impl(.data, dots, caller_env())
     14. ├─(function (object, ...) ...
     15. └─fabletools:::forecast.lst_mdl(...)
     16.   └─fabletools:::map2(...)
     17.    
    Execution halted
    ```

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 31 | SKIPPED: 1 | WARNINGS: 0 | FAILED: 18 ]
      1. Error: Manual ARIMA selection (@test-arima.R#46) 
      2. Error: Manual ARIMA selection (@test-arima.R#32) 
      3. Error: (unknown) (@test-arima.R#32) 
      4. Error: Manual ETS selection (@test-ets.R#35) 
      5. Error: Manual ETS selection (@test-ets.R#21) 
      6. Error: (unknown) (@test-ets.R#21) 
      7. Error: LM (@test-lm.R#29) 
      8. Error: LM (@test-lm.R#3) 
      9. Error: (unknown) (@test-lm.R#3) 
      1. ...
      
      Error: testthat unit tests failed
      Execution halted
    ```

# fabletools

<details>

* Version: 0.1.3
* Source code: https://github.com/cran/fabletools
* URL: http://fabletools.tidyverts.org/, https://github.com/tidyverts/fabletools
* BugReports: https://github.com/tidyverts/fabletools/issues
* Date/Publication: 2020-03-24 07:10:02 UTC
* Number of recursive dependencies: 92

Run `revdep_details(,"fabletools")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    
    Error: The `key` attribute must be a data frame with its last column called `.rows`.
    Backtrace:
         █
      1. ├─fit %>% forecast(h = "5 years")
      2. │ ├─base::withVisible(eval(quote(`_fseq`(`_lhs`)), env, env))
      3. │ └─base::eval(quote(`_fseq`(`_lhs`)), env, env)
      4. │   └─base::eval(quote(`_fseq`(`_lhs`)), env, env)
      5. │     └─`_fseq`(`_lhs`)
      6. │       └─magrittr::freduce(value, `_function_list`)
      7. │         ├─base::withVisible(function_list[[k]](value))
      8. │         └─function_list[[k]](value)
      9. │           ├─fabletools::forecast(., h = "5 years")
     10. │           └─fabletools:::forecast.mdl_df(., h = "5 years")
     11. │             └─dplyr::mutate_at(...)
     12. │               ├─dplyr::mutate(.tbl, !!!funs)
     13. │               └─dplyr:::mutate.tbl_df(.tbl, !!!funs)
     14. │                 └─dplyr:::mutate_impl(.data, dots, caller_env())
     15. ├─(function (object, ...) ...
     16. └─fab
    Execution halted
    ```

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
        1. ├─testthat::test_check("fabletools")
        2. │ └─testthat:::test_package_dir(...)
        3. │   └─testthat::test_dir(...)
        4. │     └─testthat::source_test_setup(path, env)
        5. │       └─testthat::source_dir(path, "^setup.*\\.[rR]$", env = env, wrap = FALSE)
        6. │         └─base::lapply(files, source_file, env = env, chdir = chdir, wrap = wrap)
        7. │           └─testthat:::FUN(X[[i]], ...)
        8. │             └─base::eval(exprs, env)
        9. │               └─base::eval(exprs, env)
       10. │                 └─mbl %>% forecast(h = 12) setup-data.R:13:0
       11. │                   ├─base::withVisible(eval(quote(`_fseq`(`_lhs`)), env, env))
       12. │                   └─base::eval(quote(`_fseq`(`_lhs`)), env, env)
       13. │                     └─base::eval(quote(`_fseq`(`_lhs`)), env, env)
       14. │                       └
      Execution halted
    ```

# feasts

<details>

* Version: 0.1.3
* Source code: https://github.com/cran/feasts
* URL: http://feasts.tidyverts.org/, https://github.com/tidyverts/feasts/
* BugReports: https://github.com/tidyverts/feasts/issues
* Date/Publication: 2020-03-18 07:00:11 UTC
* Number of recursive dependencies: 92

Run `revdep_details(,"feasts")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    
        intersect, setdiff, setequal, union
    
    > 
    > vic_elec %>% ACF(Temperature)
    Error: The `key` attribute must be a data frame with its last column called `.rows`.
    Backtrace:
         █
      1. └─vic_elec %>% ACF(Temperature)
      2.   ├─base::withVisible(eval(quote(`_fseq`(`_lhs`)), env, env))
      3.   └─base::eval(quote(`_fseq`(`_lhs`)), env, env)
      4.     └─base::eval(quote(`_fseq`(`_lhs`)), env, env)
      5.       └─`_fseq`(`_lhs`)
      6.         └─magrittr::freduce(value, `_function_list`)
      7.           ├─base::withVisible(function_list[[k]](value))
      8.           └─function_list[[k]](value)
      9.             └─feasts::ACF(., Temperature)
     10.               └─feasts:::build_cf(...)
     11.                 └─tsibble::new_tsibble(...)
     12.                   └─tsibble:::assert_key_data(attr(x, "key"))
    Execution halted
    ```

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 47 | SKIPPED: 0 | WARNINGS: 0 | FAILED: 16 ]
      1. Error: ACF (@test-cf.R#6) 
      2. Error: PACF (@test-cf.R#36) 
      3. Error: CCF (@test-cf.R#67) 
      4. Error: Additive classical decomposition (@test-classical.R#5) 
      5. Error: Additive classical decomposition (@test-classical.R#3) 
      6. Error: (unknown) (@test-classical.R#3) 
      7. Error: gg_tsdisplay() plots (@test-graphics.R#174) 
      8. Error: X-13ARIMA-SEATS decomposition (@test-seats.R#30) 
      9. Error: X-13ARIMA-SEATS decomposition (@test-seats.R#29) 
      1. ...
      
      Error: testthat unit tests failed
      Execution halted
    ```

# fgdr

<details>

* Version: 1.0.1
* Source code: https://github.com/cran/fgdr
* URL: https://github.com/uribo/fgdr
* BugReports: https://github.com/uribo/fgdr/issues
* Date/Publication: 2020-05-06 16:20:07 UTC
* Number of recursive dependencies: 102

Run `revdep_details(,"fgdr")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    > # Administrative Area
    > read_fgd(system.file("extdata/FG-GML-000000-AdmPt-dummy.xml", package = "fgdr"))
    Error: Must extract column with a single valid subscript.
    ✖ The subscript `attr(obj, "sf_column")` has size 0 but must be size 1.
    Backtrace:
         █
      1. └─fgdr::read_fgd(...)
      2.   ├─res[, names(res)[!names(res) %in% attr(res, "sf_column")]]
      3.   └─sf:::`[.sf`(res, , names(res)[!names(res) %in% attr(res, "sf_column")])
      4.     ├─sf::st_geometry(x)
      5.     └─sf:::st_geometry.sf(x)
      6.       ├─obj[[attr(obj, "sf_column")]]
      7.       └─tibble:::`[[.tbl_df`(obj, attr(obj, "sf_column"))
      8.         └─tibble:::tbl_subset2(x, j = i, j_arg = substitute(i))
      9.           └─tibble:::vectbl_as_col_location2(j, length(x), names(x), j_arg = j_arg)
     10.             ├─tibble:::subclass_col_index_errors(...)
     11.             │ ├─base::tryCatch(...)
     12.             │ │ └─base:::tryCatchList(expr, classes, parentenv, handlers)
     13.             │ │   └─base:::tryCatchOne(expr, names, parentenv, handlers[[1L]])
     14.             
    Execution halted
    ```

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
        1. fgdr::read_fgd(...)
        3. sf:::`[.sf`(res, , names(res)[!names(res) %in% attr(res, "sf_column")])
        5. sf:::st_geometry.sf(x)
        7. tibble:::`[[.tbl_df`(obj, attr(obj, "sf_column"))
        8. tibble:::tbl_subset2(x, j = i, j_arg = substitute(i))
        9. tibble:::vectbl_as_col_location2(j, length(x), names(x), j_arg = j_arg)
       16. vctrs::vec_as_location2(j, n, names, arg = as_label(j_arg))
       17. vctrs:::result_get(...)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 39 | SKIPPED: 0 | WARNINGS: 0 | FAILED: 1 ]
      1. Error: Successd on dummies (@test-read_fgd.R#4) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# haven

<details>

* Version: 2.2.0
* Source code: https://github.com/cran/haven
* URL: http://haven.tidyverse.org, https://github.com/tidyverse/haven, https://github.com/WizardMac/ReadStat
* BugReports: https://github.com/tidyverse/haven/issues
* Date/Publication: 2019-11-08 06:20:22 UTC
* Number of recursive dependencies: 60

Run `revdep_details(,"haven")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      
      ── 5. Failure: can roundtrip file labels (@test-write-dta.R#120)  ──────────────
      attr(roundtrip_dta(df, label = "abcd"), "label") not equal to "abcd".
      target is NULL, current is character
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 265 | SKIPPED: 0 | WARNINGS: 0 | FAILED: 5 ]
      1. Failure: file label and notes stored as attributes (@test-read-stata.R#52) 
      2. Failure: file label and notes stored as attributes (@test-read-stata.R#53) 
      3. Failure: can roundtrip file labels (@test-write-dta.R#116) 
      4. Failure: can roundtrip file labels (@test-write-dta.R#119) 
      5. Failure: can roundtrip file labels (@test-write-dta.R#120) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

## In both

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘dplyr’
    ```

*   checking for GNU extensions in Makefiles ... NOTE
    ```
    GNU make is a SystemRequirements.
    ```

# healthcareai

<details>

* Version: 2.4.0
* Source code: https://github.com/cran/healthcareai
* URL: http://docs.healthcare.ai
* BugReports: https://github.com/HealthCatalyst/healthcareai-r/issues
* Date/Publication: 2020-02-28 18:00:05 UTC
* Number of recursive dependencies: 119

Run `revdep_details(,"healthcareai")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    Running examples in ‘healthcareai-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: evaluate
    > ### Title: Get model performance metrics
    > ### Aliases: evaluate evaluate.predicted_df evaluate.model_list
    > 
    > ### ** Examples
    > 
    > models <- machine_learn(pima_diabetes[1:40, ],
    +                        patient_id,
    +                        outcome = diabetes,
    +                        models = c("XGB", "RF"),
    +                        tune = FALSE,
    +                        n_folds = 3)
    Training new data prep recipe...
    
    Error in setup_training(d, rlang::enquo(outcome), model_class, models,  : 
      data must be prepped before training models. If you want to prep data yourself (not recommended), use `prep_data(..., no_prep = TRUE)`
    Calls: machine_learn -> flash_models -> setup_training
    Execution halted
    ```

*   checking tests ... ERROR
    ```
    ...
      Running ‘testthat-2.R’
      Running ‘testthat-3.R’
      Running ‘testthat-4.R’
      Running ‘testthat-5.R’
    Running the tests in ‘tests/testthat-5.R’ failed.
    Last 13 lines of output:
      healthcareai version 2.4.0
      Please visit https://docs.healthcare.ai for full documentation and vignettes. Join the community at https://healthcare-ai.slack.com
      ── 1. Error: the fundamentals work (@test-cran_only.R#4)  ──────────────────────
      data must be prepped before training models. If you want to prep data yourself (not recommended), use `prep_data(..., no_prep = TRUE)`
      Backtrace:
       1. healthcareai::machine_learn(...)
       2. healthcareai::flash_models(...)
       3. healthcareai:::setup_training(...)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 0 | SKIPPED: 0 | WARNINGS: 0 | FAILED: 1 ]
      1. Error: the fundamentals work (@test-cran_only.R#4) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# impactflu

<details>

* Version: 0.1.0
* Source code: https://github.com/cran/impactflu
* Date/Publication: 2020-01-14 11:00:02 UTC
* Number of recursive dependencies: 38

Run `revdep_details(,"impactflu")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      
      ── 5. Failure: simulation works with no lag (@test-sim.R#68)  ──────────────────
      attr(pop, "lag") not equal to 0L.
      target is NULL, current is numeric
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 27 | SKIPPED: 0 | WARNINGS: 0 | FAILED: 5 ]
      1. Error: method1 works (@test-methods.R#32) 
      2. Error: method3 works (@test-methods.R#58) 
      3. Failure: simulation works with no lag (@test-sim.R#66) 
      4. Failure: simulation works with no lag (@test-sim.R#67) 
      5. Failure: simulation works with no lag (@test-sim.R#68) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# infer

<details>

* Version: 0.5.1
* Source code: https://github.com/cran/infer
* URL: https://github.com/tidymodels/infer, https://infer.netlify.com/
* BugReports: https://github.com/tidymodels/infer/issues
* Date/Publication: 2019-11-19 10:30:02 UTC
* Number of recursive dependencies: 115

Run `revdep_details(,"infer")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘infer-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: calculate
    > ### Title: Calculate summary statistics
    > ### Aliases: calculate
    > 
    > ### ** Examples
    > 
    > 
    > # calculate a null distribution of hours worked per week under
    > # the null hypothesis that the mean is 40
    > gss %>%
    +  specify(response = hours) %>%
    +  hypothesize(null = "point", mu = 40) %>%
    +  generate(reps = 1000, type = "bootstrap") %>%
    +  calculate(stat = "mean")
    Warning: Removed 1244 rows containing missing values.
    Error: The response variable is not set. Make sure to `specify()` it first.
    Execution halted
    ```

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Complete output:
      > library(testthat)
      > library(infer)
      > 
      > test_check("infer")
      Setting `type = "NULL"` in `generate()`.
      Error in switch(type, bootstrap = bootstrap(x, reps, ...), permute = { : 
        EXPR must be a length 1 vector
      Calls: test_check ... eval -> _fseq -> freduce -> <Anonymous> -> generate
      Execution halted
    ```

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘lifecycle’
      All declared Imports should be used.
    ```

# jpmesh

<details>

* Version: 1.2.1
* Source code: https://github.com/cran/jpmesh
* URL: https://uribo.github.io/jpmesh
* BugReports: https://github.com/uribo/jpmesh/issues
* Date/Publication: 2020-05-06 12:20:03 UTC
* Number of recursive dependencies: 126

Run `revdep_details(,"jpmesh")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    > export_meshes("4128")
    Error: Must extract column with a single valid subscript.
    ✖ The subscript `attr(obj, "sf_column")` has size 0 but must be size 1.
    Backtrace:
         █
      1. ├─(function (x, ...) ...
      2. └─sf:::print.sf(x)
      3.   ├─base::print(...)
      4.   ├─sf::st_geometry(x)
      5.   └─sf:::st_geometry.sf(x)
      6.     ├─obj[[attr(obj, "sf_column")]]
      7.     └─tibble:::`[[.tbl_df`(obj, attr(obj, "sf_column"))
      8.       └─tibble:::tbl_subset2(x, j = i, j_arg = substitute(i))
      9.         └─tibble:::vectbl_as_col_location2(j, length(x), names(x), j_arg = j_arg)
     10.           ├─tibble:::subclass_col_index_errors(...)
     11.           │ ├─base::tryCatch(...)
     12.           │ │ └─base:::tryCatchList(expr, classes, parentenv, handlers)
     13.           │ │   └─base:::tryCatchOne(expr, names, parentenv, handlers[[1L]])
     14.           │ │     └─base:::doTryCatch(return(expr), name, parentenv, handler)
     15.           │ └─base::force(expr)
    Execution halted
    ```

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 152 | SKIPPED: 1 | WARNINGS: 0 | FAILED: 12 ]
      1. Error: multiplication works (@test-administration_mesh.R#4) 
      2. Error: scale up (@test-converter.R#9) 
      3. Error: scale down (@test-converter.R#30) 
      4. Error: Input XY sfg (@test-coords_to_meshcode.R#81) 
      5. Error: vectorize (@test-coords_to_meshcode.R#104) 
      6. Error: japan rectangle sf (@test-data.R#9) 
      7. Error: Convert include meshcode dataframe to sf (@test-export_mesh.R#17) 
      8. Error: neighborhood meshes (@test-find.R#9) 
      9. Error: Separate more fine mesh order (@test-fine_separate.R#10) 
      1. ...
      
      Error: testthat unit tests failed
      Execution halted
    ```

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 176 marked UTF-8 strings
    ```

# keyholder

<details>

* Version: 0.1.4
* Source code: https://github.com/cran/keyholder
* URL: https://echasnovski.github.io/keyholder/, https://github.com/echasnovski/keyholder/
* BugReports: https://github.com/echasnovski/keyholder/issues/
* Date/Publication: 2020-03-01 20:00:02 UTC
* Number of recursive dependencies: 57

Run `revdep_details(,"keyholder")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      
          filter
      
      > 
      > test_check("keyholder")
      ── 1. Failure: restore_keys.default preserves class (@test-keys-manip.R#104)  ──
      class(output_3) not equal to c("keyed_df", "tbl_df", "tbl", "data.frame").
      Lengths differ: 3 is not 4
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 313 | SKIPPED: 0 | WARNINGS: 0 | FAILED: 1 ]
      1. Failure: restore_keys.default preserves class (@test-keys-manip.R#104) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# observer

<details>

* Version: 0.1.2
* Source code: https://github.com/cran/observer
* URL: https://github.com/paulponcet/observer
* BugReports: https://github.com/paulponcet/observer/issues
* Date/Publication: 2017-01-29 22:03:43
* Number of recursive dependencies: 67

Run `revdep_details(,"observer")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    > df <- data.frame(id = c("a", "b", "c"), x = 1:3, y = 2:4, z = c(1.1, 10, 5))
    > df <- df %>% 
    +   observe_if(z==floor(z), 
    +              y-x==1, 
    +              x < 3) %>% 
    +   observe_if(y < 4, 
    +              x > 1)
    >   
    > print(obs(df))
    # A tibble: 2 x 8
         Id Predicate Passed Failed Missing Rows         Status Number_of_trials
      <int> <chr>      <int>  <int>   <int> <named list> <chr>             <int>
    1     1 y < 4          2      1       0 <bit [1]>    failed                1
    2     2 x > 1          2      1       0 <bit [1]>    failed                1
    > 
    > df1 <- df %>%  
    +   inspect(ob = 5, cols="most")
    Error in if (ob[["Status"]] == "passed") { : 
      missing value where TRUE/FALSE needed
    Calls: %>% ... _fseq -> freduce -> withVisible -> <Anonymous> -> inspect
    Execution halted
    ```

## In both

*   checking Rd cross-references ... NOTE
    ```
    Packages unavailable to check Rd xrefs: ‘ensurer’, ‘validate’
    ```

# pammtools

<details>

* Version: 0.2.2
* Source code: https://github.com/cran/pammtools
* URL: https://github.com/adibender/pammtools
* BugReports: https://github.com/adibender/pammtools/issues
* Date/Publication: 2020-03-12 21:00:02 UTC
* Number of recursive dependencies: 101

Run `revdep_details(,"pammtools")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
        7. pammtools:::int_info.ped(ped)
        9. pammtools:::int_info.default(attr(x, "breaks"), ...)
       10. checkmate::assert_numeric(x, lower = 0, any.missing = FALSE)
       11. checkmate::makeAssertion(x, res, .var.name, add)
       12. checkmate:::mstop(...)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 296 | SKIPPED: 0 | WARNINGS: 0 | FAILED: 4 ]
      1. Error: Interval info returned for ped objects (@test-interval-functions.R#17) 
      2. Error: Sample info returned for ped objects (@test-interval-functions.R#29) 
      3. Error: Sample info returned for grouped ped objects (@test-interval-functions.R#33) 
      4. Error: ped info returned for (grouped) ped objects (@test-interval-functions.R#40) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# panelr

<details>

* Version: 0.7.2
* Source code: https://github.com/cran/panelr
* URL: https://panelr.jacob-long.com
* BugReports: https://github.com/jacob-long/panelr
* Date/Publication: 2020-03-08 22:10:02 UTC
* Number of recursive dependencies: 168

Run `revdep_details(,"panelr")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘panelr-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: are_varying
    > ### Title: Check if variables are constant or variable over time.
    > ### Aliases: are_varying
    > 
    > ### ** Examples
    > 
    > 
    > wages <- panel_data(WageData, id = id, wave = t)
    > wages %>% are_varying(occ, ind, fem, blk)
    Error: `.data` is a corrupt grouped_df, the `"groups"` attribute must be a data frame
    Execution halted
    ```

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 1 | SKIPPED: 0 | WARNINGS: 0 | FAILED: 17 ]
      1. Error: dplyr functions return panel_data objects (@test-utils.R#9) 
      2. Error: widen_panel works (@test-utils.R#46) 
      3. Error: long_panel works (basic case) (@test-utils.R#72) 
      4. Error: long_panel works (unbalanced data) (@test-utils.R#96) 
      5. Error: long_panel works (unbalanced data, numeric waves not begin w/ 1) (@test-utils.R#120) 
      6. Error: long_panel works (character periods) (@test-utils.R#146) 
      7. Error: long_panel works (beginning label) (@test-utils.R#171) 
      8. Error: long_panel works (beginning label/character periods) (@test-utils.R#198) 
      9. Error: long_panel works (prefix and suffix/character periods) (@test-utils.R#225) 
      1. ...
      
      Error: testthat unit tests failed
      Execution halted
    ```

## In both

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘AER’
    ```

# pmdplyr

<details>

* Version: 0.3.1
* Source code: https://github.com/cran/pmdplyr
* URL: https://nickch-k.github.io/pmdplyr, https://github.com/NickCH-K/pmdplyr
* BugReports: https://github.com/NickCH-K/pmdplyr/issues
* Date/Publication: 2020-03-09 19:30:02 UTC
* Number of recursive dependencies: 101

Run `revdep_details(,"pmdplyr")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
                pred_degree_awarded_ipeds year earnings_med count_not_working
    100654-2007                         3 2007        36600               116
    100654-2009                         3 2009        32600               202
    100654-2011                         3 2011        31400               214
    100654-2012                         3 2012        30300               239
    100654-2013                         3 2013        29900               246
    100654-2014                         3 2014        31000               212
                count_working repay_rate
    100654-2007          1139         NA
    100654-2009          1410         NA
    100654-2011          1532         NA
    100654-2012          1601         NA
    100654-2013          1741  0.5118364
    100654-2014          1784  0.4202658
    > 
    > # And finally panel_data
    > if ("panelr" %in% pkgs) {
    +   head(panel_convert(S_pibble, to = "panelr"))
    + }
    Error: `.data` is a corrupt grouped_df, the `"groups"` attribute must be a data frame
    Execution halted
    ```

## In both

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      Backtrace:
        1. testthat::expect_equal(panel_convert(pd, to = "pibble"), pb)
        4. pmdplyr::panel_convert(pd, to = "pibble")
        7. sjlabelled:::as_labelled.default(data[[panel_convert_id]])
        8. sjlabelled:::as_labelled_helper(x, add.labels, add.class, skip.strings)
       10. sjlabelled:::get_na.default(x)
       11. sjlabelled:::get_na_helper(x, as.tag)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 301 | SKIPPED: 0 | WARNINGS: 13 | FAILED: 2 ]
      1. Error: pibble to plm to tsibble (@test-panel_convert.R#72) 
      2. Error: pibble pdata.frame conversion (@test-panel_convert.R#86) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# readr

<details>

* Version: 1.3.1
* Source code: https://github.com/cran/readr
* URL: http://readr.tidyverse.org, https://github.com/tidyverse/readr
* BugReports: https://github.com/tidyverse/readr/issues
* Date/Publication: 2018-12-21 09:40:02 UTC
* Number of recursive dependencies: 59

Run `revdep_details(,"readr")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘spelling.R’
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 726 | SKIPPED: 6 | WARNINGS: 1 | FAILED: 9 ]
      1. Failure: nuls are dropped with a warning (@test-melt-csv.R#62) 
      2. Failure: nuls are dropped with a warning (@test-melt-csv.R#63) 
      3. Failure: ragged last column shrunk with warning (@test-melt-fwf.R#63) 
      4. Failure: ragged last column shrunk with warning (@test-melt-fwf.R#65) 
      5. Failure: check for line breaks in between widths (@test-melt-fwf.R#114) 
      6. Failure: check for line breaks in between widths (@test-melt-fwf.R#115) 
      7. Failure: check for line breaks in between widths (@test-melt-fwf.R#123) 
      8. Failure: check for line breaks in between widths (@test-melt-fwf.R#124) 
      9. Failure: melt_table can read a truncated file without crashing (@test-melt-table.R#35) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

## In both

*   checking installed package size ... NOTE
    ```
      installed size is 14.6Mb
      sub-directories of 1Mb or more:
        libs  13.8Mb
    ```

*   checking for GNU extensions in Makefiles ... NOTE
    ```
    GNU make is a SystemRequirements.
    ```

# rio

<details>

* Version: 0.5.16
* Source code: https://github.com/cran/rio
* URL: https://github.com/leeper/rio
* BugReports: https://github.com/leeper/rio/issues
* Date/Publication: 2018-11-26 05:30:03 UTC
* Number of recursive dependencies: 68

Run `revdep_details(,"rio")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘test-all.R’
    Running the tests in ‘tests/test-all.R’ failed.
    Last 13 lines of output:
      
      
      2. Import from EViews (@test_format_eviews.R#5) - Skipping boilerplate variable
      
      
      ══ Failed ══════════════════════════════════════════════════════════════════════
      ── 1. Failure: Gather attrs from Stata (@test_gather_attrs.R#10)  ──────────────
      length(attributes(e)) == 5 isn't true.
      
      ── 2. Failure: Gather attrs from Stata (@test_gather_attrs.R#11)  ──────────────
      length(attributes(g)) == 8 isn't true.
      
      ══ DONE ════════════════════════════════════════════════════════════════════════
      Error: Test failures
      Execution halted
    ```

# rstatix

<details>

* Version: 0.5.0
* Source code: https://github.com/cran/rstatix
* URL: https://rpkgs.datanovia.com/rstatix/
* BugReports: https://github.com/kassambara/rstatix/issues
* Date/Publication: 2020-04-28 10:40:02 UTC
* Number of recursive dependencies: 127

Run `revdep_details(,"rstatix")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    
    > ### Name: get_pwc_label
    > ### Title: Extract Label Information from Statistical Tests
    > ### Aliases: get_pwc_label get_test_label create_test_label
    > 
    > ### ** Examples
    > 
    > # Load data
    > #:::::::::::::::::::::::::::::::::::::::
    > data("ToothGrowth")
    > df <- ToothGrowth
    > 
    > # One-way ANOVA test
    > #:::::::::::::::::::::::::::::::::::::::::
    > anov <- df %>% anova_test(len ~ dose)
    Coefficient covariances computed by hccm()
    > get_test_label(anov, detailed = TRUE, type = "text")
    Error in switch(stat.method, t_test = "t", wilcox_test = "W", wilcox_test_paired = "V",  : 
      EXPR must be a length 1 vector
    Calls: get_test_label -> get_statistic_text
    Execution halted
    ```

# RTL

<details>

* Version: 0.1.1
* Source code: https://github.com/cran/RTL
* URL: https://github.com/risktoollib/RTL
* Date/Publication: 2020-02-23 18:50:02 UTC
* Number of recursive dependencies: 138

Run `revdep_details(,"RTL")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    > chart_zscore(df = ng_storage, title = "NG Storage Z Score",
    + per = "yearweek", output = "stl", chart = "seasons")
    Error: The `key` attribute must be a data frame with its last column called `.rows`.
    Backtrace:
         █
      1. └─RTL::chart_zscore(...)
      2.   └─df %>% tsibble::as_tsibble(key = series, index = date) %>% tsibble::group_by_key()
      3.     ├─base::withVisible(eval(quote(`_fseq`(`_lhs`)), env, env))
      4.     └─base::eval(quote(`_fseq`(`_lhs`)), env, env)
      5.       └─base::eval(quote(`_fseq`(`_lhs`)), env, env)
      6.         └─RTL:::`_fseq`(`_lhs`)
      7.           └─magrittr::freduce(value, `_function_list`)
      8.             ├─base::withVisible(function_list[[k]](value))
      9.             └─function_list[[k]](value)
     10.               └─tsibble::group_by_key(.)
     11.                 ├─dplyr::group_by(.data, !!!key(.data), .drop = .drop)
     12.                 └─tsibble:::group_by.tbl_ts(.data, !!!key(.data), .drop = .drop)
     13.                   └─tsibble::build_tsibble(...)
     14.                     └─tsibble::build_tsibble_meta(...)
     15.  
    Execution halted
    ```

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘quantmod’
      All declared Imports should be used.
    ```

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 15456 marked UTF-8 strings
    ```

# ruler

<details>

* Version: 0.2.2
* Source code: https://github.com/cran/ruler
* URL: https://echasnovski.github.io/ruler/, https://github.com/echasnovski/ruler
* BugReports: https://github.com/echasnovski/ruler/issues
* Date/Publication: 2020-03-02 21:20:03 UTC
* Number of recursive dependencies: 59

Run `revdep_details(,"ruler")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    Error: Can't subset columns that don't exist.
    ✖ The column `id` doesn't exist.
    Backtrace:
         █
      1. ├─`%>%`(...)
      2. │ ├─base::withVisible(eval(quote(`_fseq`(`_lhs`)), env, env))
      3. │ └─base::eval(quote(`_fseq`(`_lhs`)), env, env)
      4. │   └─base::eval(quote(`_fseq`(`_lhs`)), env, env)
      5. │     └─`_fseq`(`_lhs`)
      6. │       └─magrittr::freduce(value, `_function_list`)
      7. │         └─function_list[[i]](value)
      8. │           └─ruler::expose(., cell_packs(improper_pack, proper_pack))
      9. │             ├─`%>%`(...)
     10. │             │ └─base::eval(lhs, parent, parent)
     11. │             │   └─base::eval(lhs, parent, parent)
     12. │             └─base::lapply(...)
     13. │               ├─ruler:::FUN(X[[i]], ...)
     14. │               └─ruler:::expose_single.cell_pack(X[[i]], ...)
     15. │                 └─`%>%`(...)
     16. │                   ├─base::withVisible(eval(quote(`_fseq`(
    Execution halted
    ```

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
       47. testthat:::failure_summary(result, self$n_fail)
       50. testthat:::format.expectation(x)
       51. testthat:::format_with_trace(x)
       53. rlang:::format.rlang_trace(...)
       54. rlang:::trace_format_branch(x, max_frames, dir, srcrefs)
       55. rlang:::branch_uncollapse_pipe(trace)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 222 | SKIPPED: 1 | WARNINGS: 0 | FAILED: 3 ]
      1. Error: expose works (@test-expose.R#136) 
      2. Error: expose works (@test-expose.R#134) 
      3. Error: (unknown) (@test-expose.R#134) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# RWDataPlyr

<details>

* Version: 0.6.4
* Source code: https://github.com/cran/RWDataPlyr
* URL: https://github.com/BoulderCodeHub/RWDataPlyr
* BugReports: https://github.com/BoulderCodeHub/RWDataPlyr/issues
* Date/Publication: 2020-04-17 08:20:06 UTC
* Number of recursive dependencies: 65

Run `revdep_details(,"RWDataPlyr")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 648 | SKIPPED: 0 | WARNINGS: 0 | FAILED: 11 ]
      1. Failure: test rdf_aggregate() structure (@test_rdf_aggregate.R#42) 
      2. Failure: test rdf_aggregate() structure (@test_rdf_aggregate.R#46) 
      3. Failure: test rdf_aggregate() structure (@test_rdf_aggregate.R#50) 
      4. Failure: test rdf_aggregate() structure (@test_rdf_aggregate.R#54) 
      5. Failure: test rdf_aggregate() structure (@test_rdf_aggregate.R#58) 
      6. Failure: test rdf_aggregate() structure (@test_rdf_aggregate.R#63) 
      7. Failure: test rdf_aggregate() structure (@test_rdf_aggregate.R#67) 
      8. Failure: test rdf_aggregate() structure (@test_rdf_aggregate.R#71) 
      9. Failure: test rdf_aggregate() structure (@test_rdf_aggregate.R#75) 
      1. ...
      
      Error: testthat unit tests failed
      Execution halted
    ```

# scrubr

<details>

* Version: 0.3.2
* Source code: https://github.com/cran/scrubr
* URL: https://github.com/ropensci/scrubr (devel) https://docs.ropensci.org/scrubr (docs)
* BugReports: https://github.com/ropensci/scrubr/issues
* Date/Publication: 2020-04-07 17:10:02 UTC
* Number of recursive dependencies: 134

Run `revdep_details(,"scrubr")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘test-all.R’
    Running the tests in ‘tests/test-all.R’ failed.
    Last 13 lines of output:
      
      ── 2. Failure: dedup works correctly with number heavy dups (@test-dedup.R#34)  
      Names of attributes(dp) ('names', 'row.names', 'class', 'dups') don't match 'names', 'row.names', '.internal.selfref', 'class', 'dups'
      
      ── 3. Failure: dedup works correctly with iris dups (@test-dedup.R#50)  ────────
      Names of attributes(dp) ('names', 'row.names', 'class', 'dups') don't match 'names', 'row.names', '.internal.selfref', 'class', 'dups'
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 43 | SKIPPED: 7 | WARNINGS: 0 | FAILED: 3 ]
      1. Failure: dedup works correctly (@test-dedup.R#17) 
      2. Failure: dedup works correctly with number heavy dups (@test-dedup.R#34) 
      3. Failure: dedup works correctly with iris dups (@test-dedup.R#50) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 57 marked UTF-8 strings
    ```

# tibbletime

<details>

* Version: 0.1.3
* Source code: https://github.com/cran/tibbletime
* URL: https://github.com/business-science/tibbletime
* BugReports: https://github.com/business-science/tibbletime/issues
* Date/Publication: 2019-09-20 05:00:02 UTC
* Number of recursive dependencies: 64

Run `revdep_details(,"tibbletime")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
     8 FB     2013-04-08  27.2  27.2  26.6  26.8 27256000     26.8
     9 FB     2013-04-22  25.8  26.4  25.7  26.0 25687600     26.0
    10 FB     2013-05-06  28.3  28.5  27.5  27.6 43939400     27.6
    # … with 95 more rows
    > 
    > # FB is daily data, aggregate to minute?
    > # Not allowed for Date class indices, an error is thrown
    > # as_period(FB, "minute")
    > 
    > # Grouped usage -------------------------------------------------------------
    > 
    > # FANG contains Facebook, Amazon, Netflix and Google stock prices
    > data(FANG)
    > FANG <- as_tbl_time(FANG, date)
    > 
    > FANG <- dplyr::group_by(FANG, symbol)
    > 
    > # Respects groups
    > as_period(FANG, "yearly")
    Error: `.data` is a corrupt grouped_df, the `"groups"` attribute must be a data frame
    Execution halted
    ```

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
       20. dplyr:::group_vars.grouped_df(x)
       22. dplyr:::group_data.grouped_df(x)
       23. dplyr:::group_data_grouped_df(.data)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 130 | SKIPPED: 0 | WARNINGS: 0 | FAILED: 6 ]
      1. Error: Groups are respected (@test_as_period.R#71) 
      2. Error: nest() with index creates tbl_df (@test_compat-tidyr.R#22) 
      3. Error: unnest() with index goes back to tbl_time (@test_compat-tidyr.R#47) 
      4. Error: unnest() with `...` is deprecated but works (@test_compat-tidyr.R#62) 
      5. Error: Groups are respected (@test_filter_time.R#53) 
      6. Error: Groups are still printed (@test_print.R#23) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# tsibble

<details>

* Version: 0.8.6
* Source code: https://github.com/cran/tsibble
* URL: https://tsibble.tidyverts.org
* BugReports: https://github.com/tidyverts/tsibble/issues
* Date/Publication: 2020-01-31 06:20:11 UTC
* Number of recursive dependencies: 93

Run `revdep_details(,"tsibble")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    > pedestrian %>%
    +   build_tsibble(
    +     key = !!key_vars(.), index = !!index(.), index2 = Date,
    +     interval = interval(.)
    +   )
    Error: The `key` attribute must be a data frame with its last column called `.rows`.
    Backtrace:
         █
      1. └─`%>%`(...)
      2.   ├─base::withVisible(eval(quote(`_fseq`(`_lhs`)), env, env))
      3.   └─base::eval(quote(`_fseq`(`_lhs`)), env, env)
      4.     └─base::eval(quote(`_fseq`(`_lhs`)), env, env)
      5.       └─`_fseq`(`_lhs`)
      6.         └─magrittr::freduce(value, `_function_list`)
      7.           ├─base::withVisible(function_list[[k]](value))
      8.           └─function_list[[k]](value)
      9.             └─tsibble::build_tsibble(...)
     10.               └─tsibble::build_tsibble_meta(...)
     11.                 └─tsibble::new_tsibble(x, groups = grp_data, class = cls)
     12.                   └─tsibble:::assert_key_data(attr(x, "key"))
    Execution halted
    ```

*   checking tests ... ERROR
    ```
      Running ‘spelling.R’
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 535 | SKIPPED: 2 | WARNINGS: 0 | FAILED: 22 ]
      1. Error: (unknown) (@test-append.R#31) 
      2. Error: (unknown) (@test-dplyr.R#5) 
      3. Error: dplyr verbs for empty tsibble (@test-empty.R#16) 
      4. Error: (unknown) (@test-empty.R#36) 
      5. Error: (unknown) (@test-gaps.R#93) 
      6. Error: group_split() (@test-groups.R#9) 
      7. Error: group_trim() (@test-groups.R#19) 
      8. Error: illegal input in index_by() (@test-indexby.R#15) 
      9. Error: From seconds to higher date (@test-indexby.R#25) 
      1. ...
      
      Error: testthat unit tests failed
      Execution halted
    ```

## In both

*   checking Rd cross-references ... NOTE
    ```
    Packages unavailable to check Rd xrefs: ‘dtplyr’, ‘dbplyr’
    ```

# vroom

<details>

* Version: 1.2.0
* Source code: https://github.com/cran/vroom
* URL: https://github.com/r-lib/vroom
* BugReports: https://github.com/r-lib/vroom/issues
* Date/Publication: 2020-01-13 22:40:02 UTC
* Number of recursive dependencies: 88

Run `revdep_details(,"vroom")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    > ## End(Not run)
    > 
    > # Or directly from a string (must contain a trailing newline)
    > vroom("x,y\n1,2\n3,4\n")
    # A tibble: 2 x 2
          x     y
      <dbl> <dbl>
    1     1     2
    2     3     4
    > 
    > # Column selection ----------------------------------------------------------
    > # Pass column names or indexes directly to select them
    > vroom(input_file, col_select = c(model, cyl, gear))
    Error: Can't select within an unnamed vector.
    Backtrace:
        █
     1. └─vroom::vroom(input_file, col_select = c(model, cyl, gear))
     2.   └─vroom:::vroom_select(out, col_select, id)
     3.     └─tidyselect::vars_select(c(id, names(spec(x)$cols)), !!!col_select)
     4.       └─tidyselect:::eval_select_impl(...)
    Execution halted
    ```

*   checking tests ... ERROR
    ```
      Running ‘spelling.R’
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      `obj` not equal to `exp`.
      target is NULL, current is col_spec
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 676 | SKIPPED: 5 | WARNINGS: 0 | FAILED: 7 ]
      1. Error: col_select works (@test-select.R#4) 
      2. Error: col_select with negations works (@test-select.R#16) 
      3. Error: col_select with renaming (@test-select.R#42) 
      4. Error: col_select works with vroom_fwf (@test-select.R#51) 
      5. Error: col_select can select the id column (@test-select.R#65) 
      6. Failure: Can return the spec object (@test-vroom.R#401) 
      7. Failure: Can return the spec object (@test-vroom.R#404) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

## In both

*   checking installed package size ... NOTE
    ```
      installed size is 16.1Mb
      sub-directories of 1Mb or more:
        libs  14.4Mb
    ```

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘usethis’
    ```


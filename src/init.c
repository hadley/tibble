#include <stddef.h>
#include "tibble.h"

#include <R_ext/Rdynload.h>

// According to the C standard, names starting with underscore are reserved
static const R_CallMethodDef CallEntries[] = {
  {"tibble_matrixToDataFrame", (DL_FUNC) &tibble_matrixToDataFrame, 1},
  {"tibble_string_to_indices", (DL_FUNC) &tibble_string_to_indices, 1},
  {"tibble_restore_impl", (DL_FUNC) &tibble_restore_impl, 2},

  {NULL, NULL, 0}
};

void R_init_tibble(DllInfo *dll) {
  R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
  R_useDynamicSymbols(dll, FALSE);
  R_forceSymbols(dll, TRUE);
}

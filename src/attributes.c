#include "tibble.h"

SEXP tibble_restore_impl(SEXP xo, SEXP x) {
  xo = PROTECT(Rf_shallow_duplicate(xo));

  // copy over all attributes except `names` and `row.names`
  SEXP attr_x = ATTRIB(x);
  while(attr_x != R_NilValue) {
    SEXP tag = TAG(attr_x);
    if (tag != R_NamesSymbol && tag != R_RowNamesSymbol) {
      Rf_setAttrib(xo, tag, CAR(attr_x));
    }
    attr_x = CDR(attr_x);
  }

  UNPROTECT(1);
  return xo;
}

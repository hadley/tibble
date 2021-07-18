#include "tibble.h"

SEXP tibble_update_attrs(SEXP x, SEXP dots) {
  x = PROTECT(Rf_shallow_duplicate(x));

  // Strip all attributes except for names
  SEXP names = Rf_getAttrib(x, R_NamesSymbol);
  SET_ATTRIB(x, R_NilValue);
  Rf_setAttrib(x, R_NamesSymbol, names);

  while(dots != R_NilValue) {
    SEXP tag = TAG(dots);
    if (tag != R_NilValue) {
      Rf_setAttrib(x, tag, CAR(dots));
    }
    dots = CDR(dots);
  }
  UNPROTECT(1);
  return x;
}

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

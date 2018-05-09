/*
 * File: testeps.c
 *
 * MATLAB Coder version            : 2.7
 * C/C++ source code generated on  : 29-Mar-2018 20:22:04
 */

/* Include Files */
#include "rt_nonfinite.h"
#include "testeps.h"

/* Function Definitions */

/*
 * 2012.04.03
 *  xialulee
 * Arguments    : double x
 * Return Type  : double
 */
double testeps(double x)
{
  double y;
  double absxk;
  int exponent;

  /*  y = eps(x); */
  absxk = fabs(x);
  if ((!rtIsInf(absxk)) && (!rtIsNaN(absxk))) {
    if (absxk <= 2.2250738585072014E-308) {
      y = 4.94065645841247E-324;
    } else {
      frexp(absxk, &exponent);
      y = ldexp(1.0, exponent - 53);
    }
  } else {
    y = rtNaN;
  }

  return y;
}

/*
 * File trailer for testeps.c
 *
 * [EOF]
 */

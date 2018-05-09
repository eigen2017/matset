/* 
 * File: _coder_testeps_api.h 
 *  
 * MATLAB Coder version            : 2.7 
 * C/C++ source code generated on  : 29-Mar-2018 20:22:04 
 */

#ifndef ___CODER_TESTEPS_API_H__
#define ___CODER_TESTEPS_API_H__
/* Include Files */ 
#include <stdlib.h>
#include <string.h>
#include <math.h>

#include "tmwtypes.h"
#include "mex.h"
#include "emlrt.h"

/* Function Declarations */ 
extern void testeps_initialize(emlrtContext *aContext);
extern void testeps_terminate(void);
extern void testeps_atexit(void);
extern void testeps_api(const mxArray * const prhs[1], const mxArray *plhs[1]);
extern real_T testeps(real_T x);
extern void testeps_xil_terminate(void);

#endif
/* 
 * File trailer for _coder_testeps_api.h 
 *  
 * [EOF] 
 */

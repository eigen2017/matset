/*
 * re_data.c
 *
 * Code generation for model "re".
 *
 * Model version              : 1.1
 * Simulink Coder version : 8.7 (R2014b) 08-Sep-2014
 * C source code generated on : Fri May 20 10:53:30 2016
 *
 * Target selection: grt.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: 32-bit Generic
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */
#include "re.h"
#include "re_private.h"

/* Block parameters (auto storage) */
P_re_T re_P = {
  100.0,                               /* Mask Parameter: ChirpSignal_T
                                        * Referenced by: '<S1>/targetTime'
                                        */
  0.1,                                 /* Mask Parameter: ChirpSignal_f1
                                        * Referenced by:
                                        *   '<S1>/deltaFreq'
                                        *   '<S1>/initialFreq'
                                        */
  1.0,                                 /* Mask Parameter: ChirpSignal_f2
                                        * Referenced by: '<S1>/deltaFreq'
                                        */
  2U,                                  /* Mask Parameter: NSampleEnable_ActiveLevel
                                        * Referenced by: '<S2>/N-Sample Enable'
                                        */
  5U,                                  /* Mask Parameter: NSampleSwitch_N
                                        * Referenced by: '<S2>/N-Sample Enable'
                                        */
  2.0,                                 /* Expression: 2
                                        * Referenced by: '<Root>/Gain'
                                        */
  0.5,                                 /* Expression: 0.5
                                        * Referenced by: '<S1>/Gain'
                                        */
  1.0,                                 /* Expression: 1
                                        * Referenced by: '<Root>/Sine Wave'
                                        */
  0.0,                                 /* Expression: 0
                                        * Referenced by: '<Root>/Sine Wave'
                                        */
  1.0,                                 /* Expression: 1
                                        * Referenced by: '<Root>/Sine Wave'
                                        */
  0.0                                  /* Expression: 0
                                        * Referenced by: '<Root>/Sine Wave'
                                        */
};

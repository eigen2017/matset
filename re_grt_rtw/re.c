/*
 * re.c
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
#include "re_dt.h"

/* Block signals (auto storage) */
B_re_T re_B;

/* Block states (auto storage) */
DW_re_T re_DW;

/* Real-time model */
RT_MODEL_re_T re_M_;
RT_MODEL_re_T *const re_M = &re_M_;

/* Model step function */
void re_step(void)
{
  /* local block i/o variables */
  real_T rtb_Clock1;

  /* Clock: '<S1>/Clock1' */
  rtb_Clock1 = re_M->Timing.t[0];

  /* Gain: '<S1>/Gain' incorporates:
   *  Constant: '<S1>/deltaFreq'
   *  Constant: '<S1>/targetTime'
   *  Product: '<S1>/Product'
   */
  re_B.Gain = (re_P.ChirpSignal_f2 - re_P.ChirpSignal_f1) * 6.2831853071795862 /
    re_P.ChirpSignal_T * re_P.Gain_Gain_m;

  /* DSP System Toolbox N-Sample Enable  (sdspnsamp2) - '<S2>/N-Sample Enable' */
  {
    {
      if (re_DW.NSampleEnable_Counter == re_P.NSampleSwitch_N) {
        re_B.NSampleEnable = (boolean_T)(2 - re_P.NSampleEnable_ActiveLevel);
      } else {
        re_B.NSampleEnable = (boolean_T)(re_P.NSampleEnable_ActiveLevel - 1);
        (re_DW.NSampleEnable_Counter)++;
      }
    }
  }

  /* Switch: '<S2>/Switch' incorporates:
   *  Constant: '<S1>/initialFreq'
   *  Gain: '<Root>/Gain'
   *  Product: '<S1>/Product1'
   *  Product: '<S1>/Product2'
   *  Sin: '<Root>/Sine Wave'
   *  Sum: '<S1>/Sum'
   *  Trigonometry: '<S1>/Output'
   */
  if (re_B.NSampleEnable) {
    re_B.Switch = sin((rtb_Clock1 * re_B.Gain + 6.2831853071795862 *
                       re_P.ChirpSignal_f1) * rtb_Clock1);
  } else {
    re_B.Switch = (sin(re_P.SineWave_Freq * re_M->Timing.t[0] +
                       re_P.SineWave_Phase) * re_P.SineWave_Amp +
                   re_P.SineWave_Bias) * re_P.Gain_Gain;
  }

  /* End of Switch: '<S2>/Switch' */

  /* Matfile logging */
  rt_UpdateTXYLogVars(re_M->rtwLogInfo, (re_M->Timing.t));

  /* External mode */
  rtExtModeUploadCheckTrigger(2);

  {                                    /* Sample time: [0.0s, 0.0s] */
    rtExtModeUpload(0, re_M->Timing.t[0]);
  }

  {                                    /* Sample time: [0.1s, 0.0s] */
    rtExtModeUpload(1, (((re_M->Timing.clockTick1+re_M->Timing.clockTickH1*
                          4294967296.0)) * 0.1));
  }

  /* signal main to stop simulation */
  {                                    /* Sample time: [0.0s, 0.0s] */
    if ((rtmGetTFinal(re_M)!=-1) &&
        !((rtmGetTFinal(re_M)-re_M->Timing.t[0]) > re_M->Timing.t[0] *
          (DBL_EPSILON))) {
      rtmSetErrorStatus(re_M, "Simulation finished");
    }

    if (rtmGetStopRequested(re_M)) {
      rtmSetErrorStatus(re_M, "Simulation finished");
    }
  }

  /* Update absolute time for base rate */
  /* The "clockTick0" counts the number of times the code of this task has
   * been executed. The absolute time is the multiplication of "clockTick0"
   * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
   * overflow during the application lifespan selected.
   * Timer of this task consists of two 32 bit unsigned integers.
   * The two integers represent the low bits Timing.clockTick0 and the high bits
   * Timing.clockTickH0. When the low bit overflows to 0, the high bits increment.
   */
  if (!(++re_M->Timing.clockTick0)) {
    ++re_M->Timing.clockTickH0;
  }

  re_M->Timing.t[0] = re_M->Timing.clockTick0 * re_M->Timing.stepSize0 +
    re_M->Timing.clockTickH0 * re_M->Timing.stepSize0 * 4294967296.0;

  {
    /* Update absolute timer for sample time: [0.1s, 0.0s] */
    /* The "clockTick1" counts the number of times the code of this task has
     * been executed. The resolution of this integer timer is 0.1, which is the step size
     * of the task. Size of "clockTick1" ensures timer will not overflow during the
     * application lifespan selected.
     * Timer of this task consists of two 32 bit unsigned integers.
     * The two integers represent the low bits Timing.clockTick1 and the high bits
     * Timing.clockTickH1. When the low bit overflows to 0, the high bits increment.
     */
    re_M->Timing.clockTick1++;
    if (!re_M->Timing.clockTick1) {
      re_M->Timing.clockTickH1++;
    }
  }
}

/* Model initialize function */
void re_initialize(void)
{
  /* Registration code */

  /* initialize non-finites */
  rt_InitInfAndNaN(sizeof(real_T));

  /* initialize real-time model */
  (void) memset((void *)re_M, 0,
                sizeof(RT_MODEL_re_T));

  {
    /* Setup solver object */
    rtsiSetSimTimeStepPtr(&re_M->solverInfo, &re_M->Timing.simTimeStep);
    rtsiSetTPtr(&re_M->solverInfo, &rtmGetTPtr(re_M));
    rtsiSetStepSizePtr(&re_M->solverInfo, &re_M->Timing.stepSize0);
    rtsiSetErrorStatusPtr(&re_M->solverInfo, (&rtmGetErrorStatus(re_M)));
    rtsiSetRTModelPtr(&re_M->solverInfo, re_M);
  }

  rtsiSetSimTimeStep(&re_M->solverInfo, MAJOR_TIME_STEP);
  rtsiSetSolverName(&re_M->solverInfo,"FixedStepDiscrete");
  rtmSetTPtr(re_M, &re_M->Timing.tArray[0]);
  rtmSetTFinal(re_M, 10.0);
  re_M->Timing.stepSize0 = 0.1;

  /* Setup for data logging */
  {
    static RTWLogInfo rt_DataLoggingInfo;
    re_M->rtwLogInfo = &rt_DataLoggingInfo;
  }

  /* Setup for data logging */
  {
    rtliSetLogXSignalInfo(re_M->rtwLogInfo, (NULL));
    rtliSetLogXSignalPtrs(re_M->rtwLogInfo, (NULL));
    rtliSetLogT(re_M->rtwLogInfo, "tout");
    rtliSetLogX(re_M->rtwLogInfo, "");
    rtliSetLogXFinal(re_M->rtwLogInfo, "");
    rtliSetLogVarNameModifier(re_M->rtwLogInfo, "rt_");
    rtliSetLogFormat(re_M->rtwLogInfo, 0);
    rtliSetLogMaxRows(re_M->rtwLogInfo, 1000);
    rtliSetLogDecimation(re_M->rtwLogInfo, 1);
    rtliSetLogY(re_M->rtwLogInfo, "");
    rtliSetLogYSignalInfo(re_M->rtwLogInfo, (NULL));
    rtliSetLogYSignalPtrs(re_M->rtwLogInfo, (NULL));
  }

  /* External mode info */
  re_M->Sizes.checksums[0] = (3519241150U);
  re_M->Sizes.checksums[1] = (138030141U);
  re_M->Sizes.checksums[2] = (87362707U);
  re_M->Sizes.checksums[3] = (1381397002U);

  {
    static const sysRanDType rtAlwaysEnabled = SUBSYS_RAN_BC_ENABLE;
    static RTWExtModeInfo rt_ExtModeInfo;
    static const sysRanDType *systemRan[3];
    re_M->extModeInfo = (&rt_ExtModeInfo);
    rteiSetSubSystemActiveVectorAddresses(&rt_ExtModeInfo, systemRan);
    systemRan[0] = &rtAlwaysEnabled;
    systemRan[1] = &rtAlwaysEnabled;
    systemRan[2] = &rtAlwaysEnabled;
    rteiSetModelMappingInfoPtr(re_M->extModeInfo, &re_M->SpecialInfo.mappingInfo);
    rteiSetChecksumsPtr(re_M->extModeInfo, re_M->Sizes.checksums);
    rteiSetTPtr(re_M->extModeInfo, rtmGetTPtr(re_M));
  }

  /* block I/O */
  (void) memset(((void *) &re_B), 0,
                sizeof(B_re_T));

  /* states (dwork) */
  (void) memset((void *)&re_DW, 0,
                sizeof(DW_re_T));

  /* data type transition information */
  {
    static DataTypeTransInfo dtInfo;
    (void) memset((char_T *) &dtInfo, 0,
                  sizeof(dtInfo));
    re_M->SpecialInfo.mappingInfo = (&dtInfo);
    dtInfo.numDataTypes = 14;
    dtInfo.dataTypeSizes = &rtDataTypeSizes[0];
    dtInfo.dataTypeNames = &rtDataTypeNames[0];

    /* Block I/O transition table */
    dtInfo.B = &rtBTransTable;

    /* Parameters transition table */
    dtInfo.P = &rtPTransTable;
  }

  /* Matfile logging */
  rt_StartDataLoggingWithStartTime(re_M->rtwLogInfo, 0.0, rtmGetTFinal(re_M),
    re_M->Timing.stepSize0, (&rtmGetErrorStatus(re_M)));

  /* DSP System Toolbox N-Sample Enable  (sdspnsamp2) - '<S2>/N-Sample Enable' */
  re_DW.NSampleEnable_Counter = (uint32_T) 0;
}

/* Model terminate function */
void re_terminate(void)
{
  /* (no terminate code required) */
}

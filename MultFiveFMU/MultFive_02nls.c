/* Non Linear Systems */
/* Simulation code for MultFive generated by the OpenModelica Compiler 1.9.1 Beta2 (r19512) (RML version). */

#include "openmodelica.h"
#include "openmodelica_func.h"
#include "simulation_data.h"
#include "simulation/simulation_info_xml.h"
#include "simulation/simulation_runtime.h"
#include "util/omc_error.h"
#include "simulation/solver/model_help.h"
#include "simulation/solver/delay.h"
#include "simulation/solver/linearSystem.h"
#include "simulation/solver/nonlinearSystem.h"
#include "simulation/solver/mixedSystem.h"

#include <assert.h>
#include <string.h>

#include "MultFive_functions.h"
#include "MultFive_model.h"
#include "MultFive_literals.h"



#if defined(HPCOM) && !defined(_OPENMP)
  #error "HPCOM requires OpenMP or the results are wrong"
#endif
#if defined(_OPENMP)
  #include <omp.h>
#else
  /* dummy omp defines */
  #define omp_get_max_threads() 1
#endif

#define threadData data->threadData

/* dummy REAL_ATTRIBUTE */
const REAL_ATTRIBUTE dummyREAL_ATTRIBUTE = omc_dummyRealAttribute;
#include "MultFive_12jac.h"

/* funtion initialize non-linear systems */
void MultFive_initialNonLinearSystem(NONLINEAR_SYSTEM_DATA* nonLinearSystemData)
{
}



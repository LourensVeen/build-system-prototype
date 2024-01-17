AC_CONFIG_MACRO_DIRS([m4])
AC_INIT([amuse], [1.0])

# The standard compiler checks AC_PROG_* crash if the compiler is not found, which is
# not what we want here. Also, we only support specific compilers. So we use
# AC_CHECK_TOOL instead. If the user sets the corresponding variable explicitly, then
# this will just assume that it's a working compiler.
AC_CHECK_TOOL(CC, gcc)
AC_CHECK_TOOL(CXX, g++)
AC_CHECK_TOOL(FC, gfortran)
AC_CHECK_TOOL(JAVAC, javac)

AX_MPI()
AX_OPENMP([HAVE_OPENMP="yes"])
AX_CUDA()
AX_CHECK_CL()
AX_LAPACK()
AX_PATH_GSL(1.0, [FOUND_GSL=yes])
AX_GMP()
AX_MPFR()
AX_FFTW()
AX_LIB_HDF5()
AX_LIB_NETCDF4()

# TODO: detect Sapporo using pkg-config



# Create the FEATURES variable used by amuse.mk to decide what to build

# This macro adds its first argument to FEATURES if the variable
# in the second argument is defined.
m4_define([ENABLE_FEATURE_IF_DEFINED],
          [AS_IF([test "x" != "x${$2}"], [FEATURES="${FEATURES} $1"])])

# Add the first argument to FEATURES if the variable in the second argument
# has the value specified in the third argument.
m4_define([ENABLE_FEATURE_IF_EQUALS],
          [AS_IF([test "x${$2}" = "x$3"], [FEATURES="${FEATURES} $1"])])

FEATURES="forsockets"

ENABLE_FEATURE_IF_DEFINED([gcc], [CC])
ENABLE_FEATURE_IF_DEFINED([g++], [CXX])
ENABLE_FEATURE_IF_DEFINED([gfortran], [FC])
ENABLE_FEATURE_IF_DEFINED([java], [JAVAC])
ENABLE_FEATURE_IF_DEFINED([mpi], [MPICC])
ENABLE_FEATURE_IF_DEFINED([openmp], [HAVE_OPENMP])
ENABLE_FEATURE_IF_DEFINED([blas], [LAPACK_LIBS])
ENABLE_FEATURE_IF_DEFINED([lapack], [LAPACK_LIBS])
ENABLE_FEATURE_IF_DEFINED([gsl], [FOUND_GSL])
ENABLE_FEATURE_IF_EQUALS([gmp], [FOUND_GMP], [yes])
ENABLE_FEATURE_IF_EQUALS([mpfr], [FOUND_MPFR], [yes])
ENABLE_FEATURE_IF_EQUALS([fftw], [FOUND_FFTW], [yes])
ENABLE_FEATURE_IF_EQUALS([hdf5], [with_hdf5], [yes])
ENABLE_FEATURE_IF_EQUALS([netcdf4], [FOUND_NETCDF], [yes])

AC_SUBST(FEATURES)

AC_CONFIG_FILES([features.mk])
AC_OUTPUT


include paths.mk
include defs.mk

ifeq ($(OS),Windows_NT)
TARGETS=objs$(ARCH_SUFF) $(SOURCES)
CFLAGS=-g
else
TARGETS=objs$(ARCH_SUFF) $(SOURCES)
CFLAGS=-g3 -ggdb -Og
endif
ARCH_OBJS=./Memory/alloc$(OBJ_SUFF) ./Memory/contig$(OBJ_SUFF) ./Memory/free$(OBJ_SUFF) \
./Molecule/molecule$(OBJ_SUFF) ./Input_Output/input$(OBJ_SUFF) ./Input_Output/output$(OBJ_SUFF) \
./Calculations/calculations$(OBJ_SUFF) ./Calculations/calculations2$(OBJ_SUFF) ./Calculations/calculations3$(OBJ_SUFF) \
./Calculations/calculations4$(OBJ_SUFF) ./Windows_Linking/linker$(OBJ_SUFF)

ARCH_CPP_OBJS=./Molecule/molecule_cpp$(OBJ_SUFF) ./Molecule/molecule_data_cpp$(OBJ_SUFF) ./Arrays/arrays$(OBJ_SUFF)

ARCH_C= ./Memory/alloc.c ./Memory/contig.c ./Memory/free.c ./Molecule/molecule.c ./Input_Output/input.c ./Input_Output/output.c \
./Calculations/calculations.c ./Calculations/calculations2.c ./Calculations/calculations3.c ./Calculations/calculations4.c \
./Windows_Linking/linker.c

ARCH_CPP=./Molecule/molecule_cpp.cpp ./Molecule/molecule_data_cpp.cpp ./Arrays/arrays.cpp


EXECS=./Geometry/geometry$(EXEC_SUFF) ./CCSD/ccsd$(EXEC_SUFF) ./DIIS/diis$(EXEC_SUFF) ./Harmonics/harmonics$(EXEC_SUFF)\
./MP2/mp2$(EXEC_SUFF) ./SCF/scf$(EXEC_SUFF)


SOURCES=./Geometry/geometry.c ./CCSD/ccsd.c ./DIIS/diis.c ./Harmonics/harmonics.c ./MP2/mp2.c ./SCF/scf.c


OUTPUTS=objs$(ARCH_SUFF)

EXEC_DEPS=objs$(ARCH_SUFF)
DLLS=$(LAPACKE_LIB_PATH) $(CBLAS_LIB_PATH) $(LAPACK_LIB_PATH) $(BLAS_LIB_PATH) $(OTHER_LIBS)
LDFLAGS=$(LAPACKE_ARCH_PATH) $(CBLAS_ARCH_PATH) $(LAPACK_ARCH_PATH) $(BLAS_ARCH_PATH) $(OTHER_FLAGS) $(DLLS) -lm
DEFINES=-D'DLLS="$(subst ",\",$(DLLS))"'
INCLUDES=-I $(LAPACKE_HEADER_PATH) -I $(CBLAS_HEADER_PATH) -include $(LAPACKE_HEADER_NAME) -include $(CBLAS_HEADER_NAME)

ifeq ($(OS),Windows_NT)

L1_REMOVE=$(subst /,\\,$(ARCH_OBJS)) a.out
L2_REMOVE=$(L1_REMOVE) $(OUTPUTS)
else
L1_REMOVE=$(ARCH_OBJS) a.out
L2_REMOVE=$(L1_REMOVE) $(OUTPUTS)
endif
export
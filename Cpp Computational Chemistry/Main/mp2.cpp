/*
 * mp2.cpp
 *
 *  Created on: Apr 30, 2018
 *      Author: Connor
 */


#include <stdio.h>
#include <stdlib.h>
#include "../compchem.hpp"

using namespace compchem;
using namespace std;

int main(int argc, char **argv) {
	linkDLLs();
	Molecule *mol;
	initialize(&mol, argc, argv);
	mol->computeSCF();
	mol->computeMOTEI();
	mol->computeMP2();
	printMP2(*mol);
	delete mol;
	unlinkDLLs();
	return (0);
}

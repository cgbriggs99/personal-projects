/*
 * mandelbrot.cpp
 *
 *  Created on: Oct 24, 2018
 *      Author: cgbri
 */


#include "./mandelbrot.hpp"
#include <complex.h>

using namespace std;

static color_t pallette(long int count) {
	return (hsvToRGB(2.0F * expl(-count * count / (2.0F * 200)) / 3, 1, 1.0F - expl(-count), 1));
}

static color_t interpolate(long int count1, long int count2, long double value) {
	color_t color1 = pallette(count1), color2 = pallette(count2);
	color_t out;
	out.a = 1;
	out.b = (value - count1) * (color2.b - color1.b) / (count2 - count1) + color1.b;
	out.g = (value - count1) * (color2.g - color1.g) / (count2 - count1) + color1.g;
	out.r = (value - count1) * (color2.r - color1.r) / (count2 - count1) + color1.r;
	return (out);
}

color_t mandelbrot(complex<long double> z, complex<long double> c, int max_count) {
	complex<long double> z0, z1;
	z0 = z;
	z1 = z * z + c;
	int count = 0;
	while(abs(z1) <= 2 && count != max_count) {
		z0 = z1;
		z1 = z0 * z0 + c;
		count++;
	}

	if(count == max_count) {
		return (makeColor4i(0, 0, 0, 255));
	}
//	if(count == 0) {
//		return (makeColor4i(0, 0, 0, 255));
//	}
	long double log_zn = logl(z1.real() * z1.real() + z1.imag() * z1.imag()) / 2;
	long double nu = logl(log_zn / logl(2.0F)) / logl(2.0f);
	long double normal_count = count + 1 - nu;

	return (interpolate(floor(normal_count), floor(normal_count) + 1, normal_count));
}


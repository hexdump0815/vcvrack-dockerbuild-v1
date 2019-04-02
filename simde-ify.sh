#!/bin/bash

sed -i 's,<mmintrin\.h,<x86/sse2.h,g;s,xmmintrin\.h,x86/sse2.h,g;s,pmmintrin\.h,x86/sse2.h,g;s,emmintrin\.h,x86/sse2.h,g;s,^_m,simde_m,g;s,^__m,simde__m,g;s,\ _m, simde_m,g;s,\ __m, simde__m,g;s,\t_m,\tsimde_m,g;s,\t__m,\tsimde__m,g;s,(_m,(simde_m,g;s,(__m,(simde__m,g;s,\,_m,\,simde_m,g;s,\,__m,\,simde__m,g;s,~_m,~simde_m,g;s,~__m,~simde__m,g;s,:_m,:simde_m,g;s,:__m,:simde__m,g;s,\._m,.simde_m,g;s,\.__m,.simde__m,g;s,simde_mode,_mode,g;s,simde_msgCount,_msgCount,g' $1

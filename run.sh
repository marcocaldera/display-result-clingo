#!/bin/bash

clear
clingo -n 1 --outf=3 pp.lp progetto_ialab_2.cl

# why does clingo not exit cleanly...
true
#!/bin/bash

clear
# --outf=3 option to disable all output from clingo

clingo -n 1 --outf=3 pp.lp progetto_ialab_2.cl

# why does clingo not exit cleanly...
true
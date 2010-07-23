#! /bin/sh

ruby autoproj_bootstrap git http://gitorious.org/orocos-toolchain/build.git
autoproj update
autoproj fast-build


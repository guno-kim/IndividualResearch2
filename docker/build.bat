@echo off
docker build -t java-compile-run:1.0 ./build
docker build -t java-build:1.0 ./submit/build
docker build -t java-run:1.0 ./submit/run
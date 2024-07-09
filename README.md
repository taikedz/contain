# Container Helper

Small wrapper for making containers easier to use instinctively on the command line.

This is typically to support my usage of containers as an experimentation utility.

All containers started with `run` will have `$PWD` mounted into `/root/hostdata`, and the default workdir set to the latter as well.

## Usage

see [src/HELP.md](src/HELP.md)

## Language

This utility uses the [bash-builder](https://github.com/taikedz/bash-builder) system to compile from bash-builder-script to bash script.

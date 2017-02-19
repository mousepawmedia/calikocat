# Building CalikoCat

## Building Basics

CMake is used to build CalikoCat and CalikoCat Tester. For your convenience,
we've included Makefiles to automate all common build scenarios on Linux.
Type "make" in the root of this repository for more information.

At this time, the Makefiles are only designed for Linux. If you are building
on another system, you can interact with CMake directly.

Currently, CalikoCat is only designed to be built by GCC (5.3 or later) or
Clang (3.4 or later).

## Ready-To-Use Build

If you just want to build CalikoCat to use in your own project, the fastest way
is to run "make ready". This will build CalikoCat and place it in a folder
called `calikocat`, then point your compiler and linker to "calikocat/include"
and "calikocat/lib" respectively. Our other repositories point to this by
default.

## Building HTML Docs

If you want the HTML documentation, run "make docs". Then, grab the
'docs/build/html' folder, or just open 'docs/build/html/index.html' in
your favorite web browser.

## Building Tester

If you want to test out CalikoCat directly, run "make tester". Then, look
for the 'calikocat-tester' executable in 'calikocat-tester/bin/[Debug/Release]'.
Alternatively, you may use the symbolic link 'tester' or 'tester_debug'
in the root of this repository.

## Code::Blocks

CalikoCat was written and built in CodeBlocks. The projects (.cbp) in this
repository are pre-configured to build directly in the repository.

## Source Directories

- The '/docs' folder contains the Sphinx documentation for CalikoCat.
- The '/calikocat-source' folder contains the source code for the CalikoCat
  library.
- The '/calikocat-tester' folder contains the console application for testing
  the CalikoCat library.

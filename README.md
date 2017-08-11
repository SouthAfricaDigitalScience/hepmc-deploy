[![Build Status](https://ci.sagrid.ac.za/buildStatus/icon?job=hepmc-deploy&build=9)](https://ci.sagrid.ac.za/job/hepmc-deploy/9/)

# hepmc-deploy

Build, test and deploy scripts for  [HEPMC](http://hepmc.web.cern.ch/hepmc/)[1](#hep-cite) , an event record for High-Energy Physics Monte-Carlo events.

# Configuration

This build is done in "stand-alone" mode, although HEPMC can be configured to link against ROOT and Pythia8.
However, since these represent circular dependencies, we first build the HEPMC standalone libs, then link the others against those later.

## Dependencies

  * GCC
    * 5.4.0
    * 6.3.0
  * cmake

## Versions

We build versions :

  1. 3.0.0
  2. 2.6.9
  3. 2.07-beta00

# Usage

This packages goes under the `HEP` category. In order to use  HEPMC, you need to add the `hepmc` module, with the compiler of your choice, _e.g._ :

```
module avail hepmc

------------- /cvmfs/code-rade.africa-grid.org//modules/libraries --------------
hepmc/3.0.0-gcc-5.4.0 hepmc/3.0.0-gcc-6.3.0

module add hepmc/3.0.0-gcc-6.3.0
which basic_tree.exe
/cvmfs/code-rade.africa-grid.org//generic/u1610/x86_64/hepmc/3.0.0-gcc-6.3.0/bin/basic_tree.exe
```

You get the `$HEPMC_DIR` variable added to your shell in this module, which you can use in your scripts to link  HEPMC applications.

# References



# Citing

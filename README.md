
<!-- README.md is generated from README.Rmd. Please edit that file -->

# britmort

This repository contains the R code for the modelling and graphs of
Section 5 of the paper

> Zhang JL, Bryant J. Forthcoming. Fully Bayesian benchmarking of small
> area estimation models.

In Section 5, we estimate age-sex-area-specific mortality rates that are
consistent with life expectancies for eight large regions in England and
Wales.

The model and graphs in the paper can be reproduced by running the code
in file “run\_all.R”, which in turn runs code in the “src” folder.

For the code to run, you will need to have the packages **coda**,
**dplyr**, and **latticeExtra** installed on your computer. These can
all be installed from CRAN.

You will also need to have the packages **dembase**, **demdata**,
**demest**, and **demlife**. These can be installed from GitHub using

``` r
devtools::install_github("dembase")
devtools::install_github("demdata")
devtools::install_github("demest")
devtools::install_github("demlife")
```

Running the code creates output, including graphs as PDF files, in the
folder “out”.

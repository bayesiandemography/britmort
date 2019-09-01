
<!-- README.md is generated from README.Rmd. Please edit that file -->

# cambodia

This repository contains the R code for modelling and creating graphs
for the paper

> Zhang JL, Bryant J. Forthcoming. Fully Bayesian benchmarking of small
> area estimation models.

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



## Format input data

source("src/deaths.R")

source("src/popn.R")

source("src/conc.R")

source("src/conc_region_long_short.R")



## Calculate direct estimates of life expectancy

source("src/life_exp_direct.R")


## Fit models without and with benchmarking

source("src/model_none.R")

source("src/model_bench.R")


## Extract and format results

source("src/mx_modelled.R")

source("src/regions_ordered_by_life.R")

source("src/life_sample.R")


## Make graphs

source("src/mortality_mx_examples.R")

source("src/mortality_lx_change.R")

source("src/mortality_life_exp_regions.R")

source("src/mortality_mx_change.R")




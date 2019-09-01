
library(demest)

deaths <- readRDS("out/deaths.rds")
popn <- readRDS("out/popn.rds")
conc <- readRDS("out/conc.rds")
life.exp <- readRDS("out/life_exp_direct.rds")

set.seed(0)

aggregate <- AgLife(value = life.exp,
                    sd = 0.005,
                    concordances = list(region = conc))
model <- Model(y ~ Poisson(mean ~ age * sex + region),
               age ~ DLM(damp = NULL,
                         error = Error(robust = TRUE)),
               aggregate = aggregate,
               jump = 0.11) 
filename <- "out/model_bench.est"
estimateModel(model,
              y = deaths,
              exposure = popn,
              filename = filename,
              nBurnin = 40000,
              nSim = 40000,
              nChain = 4,
              nThin = 80)
s <- fetchSummary(filename)
print(s)



library(demest)

deaths <- readRDS("out/deaths.rds")
popn <- readRDS("out/popn.rds")

set.seed(0)

model <- Model(y ~ Poisson(mean ~ age * sex + region),
               age ~ DLM(damp = NULL,
                         error = Error(robust = TRUE)),
               jump = 0.11)
filename <- "out/model_none.est"
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


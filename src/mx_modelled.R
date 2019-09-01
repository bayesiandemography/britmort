
library(methods)
library(demest)

popn <- readRDS("out/popn.rds")
mx_none <- fetch(file = "out/model_none.est",
                 where = c("model", "likelihood", "rate"))
mx_bench <- fetch(file = "out/model_bench.est",
                  where = c("model", "likelihood", "rate"))
mx_modelled <- dbind(None = mx_none,
                     Benchmarks = mx_bench,
                     along = "variant")
saveRDS(mx_modelled,
        file = "out/mx_modelled.rds")

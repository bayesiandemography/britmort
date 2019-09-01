#!/usr/local/bin/Rscript

library(dembase)
library(demlife)
library(latticeExtra)

conc <- readRDS("out/mortality/conc.rds")
popn <- readRDS("out/mortality/popn.rds")
life.exp.direct <- readRDS("out/mortality/life.exp.direct.rds")
mx.none <- fetch(file = "out/mortality/model.none.est",
                 where = c("model", "likelihood", "rate"))
mx.bench <- fetch(file = "out/mortality/model.bench.est",
                  where = c("model", "likelihood", "rate"))
mx.none <- collapseCategories(mx.none,
                              dimension = "region",
                              concordance = conc,
                              weights = popn)
mx.bench <- collapseCategories(mx.bench,
                              dimension = "region",
                              concordance = conc,
                              weights = popn)
lt.none <- LifeTable(mx.none)
lt.bench <- LifeTable(mx.bench)
life.exp.none <- lifeExpectancy(lt.none)
life.exp.bench <- lifeExpectancy(lt.bench)
life.exp.none <- collapseIterations(life.exp.none,
                                    prob = c(0.025, 0.25, 0.5, 0.75, 0.975))
life.exp.bench <- collapseIterations(life.exp.bench,
                                     prob = c(0.025, 0.25, 0.5, 0.75, 0.975))
life.exp.direct <- as.data.frame(life.exp.direct,
                                 direction = "long")
life.exp.none <- as.data.frame(life.exp.none,
                               direction = "long")
life.exp.bench <- as.data.frame(life.exp.bench,
                                direction = "long")
life.exp.direct$quantile <- "50%"
life.exp.direct$variant <- "Direct"
life.exp.none$variant <- "None"
life.exp.bench$variant <- "Benchmarked"
life.exp <- rbind(life.exp.direct,
                  life.exp.none,
                  life.exp.bench)




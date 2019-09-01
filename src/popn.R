
library(methods)
library(dembase)
library(demdata)

popn <- demdata::england.wales.popn

popn <- Counts(popn)
popn <- collapseCategories(popn,
                           dimension = "region",
                           old = c("Cornwall", "Isles of Scilly"),
                           new = "Cornwall and Isles of Scilly")
popn <- collapseIntervals(popn,
                          dimension = "age",
                          breaks = c(0, 1, seq(5, 90, 5)))

saveRDS(popn,
        file = "out/popn.rds")


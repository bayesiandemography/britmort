
library(methods)
library(dembase)
library(demlife)

conc <- readRDS("out/conc.rds")
popn <- readRDS("out/popn.rds")
mx_modelled <- readRDS("out/mx_modelled.rds")

mx <- subarray(mx_modelled,
               subarray = variant == "None")
mx <- collapseDimension(mx,
                        dimension = "sex",
                        weights = popn)
mx <- collapseCategories(mx,
                         dimension = "region",
                         concordance = conc,
                         weights = popn)
lt <- LifeTable(mx)
life <- lifeExpectancy(lt)
life <- collapseIterations(life,
                           FUN = median)
life <- sort(life)
regions_ordered_by_life <- dimnames(life)$region
saveRDS(regions_ordered_by_life,
        file = "out/regions_ordered_by_life.rds")


library(dembase)
library(demlife)

conc <- readRDS("out/conc.rds")
deaths <- readRDS("out/deaths.rds")
popn <- readRDS("out/popn.rds")

deaths <- collapseCategories(deaths,
                             dimension = "region",
                             concordance = conc)
popn <- collapseCategories(popn,
                           dimension = "region",
                           concordance = conc)
mx <- deaths / popn
life_table <- LifeTable(mx)
life_exp <- lifeExpectancy(life_table)

saveRDS(life_exp,
        file = "out/life_exp_direct.rds")

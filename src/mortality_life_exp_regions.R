
library(dembase)
library(demlife)
library(latticeExtra)

conc <- readRDS("out/conc.rds")
popn <- readRDS("out/popn.rds")
life.exp.direct <- readRDS("out/life_exp_direct.rds")
mx.modelled <- readRDS("out/mx_modelled.rds")
regions.ordered.by.life <- readRDS("out/regions_ordered_by_life.rds")

mx.modelled <- collapseCategories(mx.modelled,
                                  dimension = "region",
                                  concordance = conc,
                                  weights = popn)
life.table.modelled <- LifeTable(mx.modelled)
life.exp.modelled <- lifeExpectancy(life.table.modelled)
life.exp.modelled <- collapseIterations(life.exp.modelled,
                                        FUN = median)
life.exp.direct <- as.data.frame(life.exp.direct,
                                 direction = "long")
life.exp.modelled <- as.data.frame(life.exp.modelled,
                                   direction = "long")
life.exp.direct$variant <- "Direct"
life.exp <- rbind(life.exp.direct,
                  life.exp.modelled)
life.exp$variant <- factor(life.exp$variant,
                           levels = c("Direct",
                                      "None",
                                      "Benchmarks"))
life.exp$region <- factor(life.exp$region,
                          levels = regions.ordered.by.life)

pch <- c(3, 1, 4)
col <- "black"
p <- stripplot(region ~ value | sex,
               data = life.exp,
               groups = variant,
               scales = list(x = list(relation = "free")),
               par.settings = list(fontsize = list(text = 8, points = 8),
                                   strip.background = list(col = "grey90")),
               col = col,
               pch = pch,
               xlab = "Years",
               key = list(text = list(c("Benchmarks",
                                        "No benchmarks",
                                        "With benchmarks")),
                          points = list(pch = pch,
                                        col = col,
                                        cex = 0.8),
                          space = "right"))
pdf(file = "out/mortality_life_exp_regions.pdf",
    width = 6,
    height = 2)
plot(p)
dev.off()


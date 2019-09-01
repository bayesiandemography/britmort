#!/usr/local/bin/Rscript

library(methods)
library(dembase)
library(demlife)

mx <- readRDS("out/mortality/mx.modelled.rds")

## widths of intervals for log mx

logmx <- log(mx)
logmx <- collapseIterations(logmx,
                            prob = c(0.025, 0.975))
upper.logmx <- slab(logmx,
                    dimension = "quantile",
                    elements = 2)
lower.logmx <- slab(logmx,
                    dimension = "quantile",
                    elements = 1)
width.logmx <- upper.logmx - lower.logmx
width.logmx <- as.data.frame(width.logmx,
                             direction = "long")
tapply(width.logmx$value,
       width.logmx$variant,
       mean)


## widths of intervals for life expectancy

lt <- LifeTable(mx)
life <- lifeExpectancy(lt)
life <- collapseIterations(life,
                           prob = c(0.025, 0.975))
upper.life <- slab(life,
                   dimension = "quantile",
                   elements = 2)
lower.life <- slab(life,
                   dimension = "quantile",
                   elements = 1)
width.life <- upper.life - lower.life
width.life <- as.data.frame(width.life,
                            direction = "long")
tapply(width.life$value,
       width.life$variant,
       mean)




    


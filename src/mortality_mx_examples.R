
library(dembase)
library(demdata)
library(latticeExtra)

deaths <- demdata::england.wales.deaths
popn <- demdata::england.wales.popn
deaths <- Counts(deaths)
popn <- Counts(popn)

set.seed(0)
deaths <- subarray(deaths,
                   subarray = region != "Usual residence outside England and Wales")
exposure <- collapseIntervals(popn,
                              dimension = "age",
                              breaks = c(0, 1, seq(5, 90, 5)))
direct <- deaths / exposure
regions <- dimnames(direct)$region
sample.regions <- sample(regions, size = 5)
direct <- subarray(direct,
                   subarray = region %in% sample.regions)
direct <- as.data.frame(direct,
                        midpoints = "age",
                        direction = "long")
direct$sex <- factor(direct$sex,
                     levels = c("Females", "Males"))
col <- c("black", "grey50")
lty <- "solid"
p <- xyplot(value ~ age | region,
            data = direct,
            groups = sex,
            type = "b",
            layout = c(5, 1),
            scales = list(y = list(log = TRUE),
                          x = list(tck = 0.4)),
            col = col,
            lty = lty,
            as.table = TRUE,
            xlab = "Age",
            ylab = "",
            yscale.components = yscale.components.log10ticks,
            par.settings = list(fontsize = list(text = 6, points = 6),
                                strip.background = list(col = "grey90")),
            key = list(text = list(levels(direct$sex)),
                       lines = list(col = col,
                                    lty = lty,
                                    type = "b",
                                    pch = 1),
                       space = "right"))
pdf(file = "out/mortality_mx_examples.pdf",
    w = 6,
    h = 2.2)
plot(p)
dev.off()



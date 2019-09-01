
library(methods)
library(dembase)
library(latticeExtra)

mx <- readRDS("out/mx_modelled.rds")

set.seed(0)

mx <- collapseIterations(mx,
                         FUN = median)
mx.bench <- subarray(mx,
                     subarray = variant == "Benchmarks")
mx.none <- subarray(mx,
                    subarray = variant == "None")
diff.mx <- 100 * (mx.bench / mx.none - 1)
diff.mx <- as.data.frame(diff.mx,
                         direction = "long",
                         midpoints = "age")
mean.value <- tapply(diff.mx$value,
                     diff.mx$region,
                     mean)
region.ordered.by.val <- names(sort(mean.value))
diff.mx$region <- factor(diff.mx$region,
                         levels = region.ordered.by.val)
regions <- levels(diff.mx$region)
sample.regions <- sample(regions, size = 9)


col <- c("black", "grey50")
lty <- "solid"
p <- xyplot(value ~ age | region,
            data = diff.mx,
            groups = sex,
            col = col,
            lty = lty,
            layout = c(3, 3),
            xlab = "Age",
            ylab = "Percent difference",
            type = "l",
            as.table = TRUE,
            scales = list(tck = 0.6),
            subset = region %in% sample.regions,
            par.settings = list(fontsize = list(text = 7),
                                strip.background = list(col = "grey90")),
                        key = list(text = list(levels(diff.mx$sex)),
                       lines = list(col = col,
                                    lty = lty,
                                    pch = 1),
                       space = "right"))
p <- p + layer(panel.abline(h = 0,
                            col = "grey"),
               under = TRUE)

pdf(file = "out/mortality_mx_change.pdf",
    width = 6,
    height = 3.2)
plot(p)
dev.off()


library(latticeExtra)

life_sample <- readRDS("out/life_sample.rds")

panel.special <- function(x, y, subscripts, ...) {
    is_low <- life_sample$quantile[subscripts] == "2.5%"
    is_med <- life_sample$quantile[subscripts] == "50%"
    is_high <- life_sample$quantile[subscripts] == "97.5%"
    is_bench <- life_sample$variant[subscripts] == "Benchmarks"
    panel.segments(x0 = seq(4, 44, 10) + 2 * is_bench[is_low],
                   x1 = seq(4, 44, 10) + 2 * is_bench[is_low],
                   y0 = y[is_low],
                   y1 = y[is_high],
                   col = "black")
    panel.xyplot(x = seq(4, 44, 10) + 2 * is_bench[is_med],
                 y = y[is_med],
                 pch = ifelse(is_bench[is_med], 4, 1),
                 col = "black",
                 cex = 0.5)
}

for (SEX in c("Females", "Males")) {

    p <- xyplot(value ~ region | ag,
                data = life_sample,
                subset = sex == SEX,
                groups = variant,
                as.table = TRUE,
                xlab = "",
                ylab = "",
                layout = c(10, 1),
                par.settings = list(fontsize = list(text = 7),
                                    strip.background = list(col = "grey90"),
                                    plot.symbol = list(fill = "white")),
                scales = list(x = list(draw = FALSE),
                              y = list(rot = 0,
                                       tck = 0.4)),
                panel = panel.special,
                key = list(text = list(c("No benchmarks", "With benchmarks")),
                           points = list(pch = c(1, 4), cex = 0.7),
                           columns = 2,
                           space = "top"))

    file <- sprintf("out/mortality_lx_change_%s.pdf",
                    tolower(SEX))
    pdf(file = file,
        width = 6,
        height = 1.7)
    plot(p)
    dev.off()

}       

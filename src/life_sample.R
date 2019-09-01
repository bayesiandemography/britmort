
library(methods)
library(dembase)
library(demlife)

mx <- readRDS("out/mx_modelled.rds")
conc <- readRDS("out/conc.rds")
popn <- readRDS("out/popn.rds")
conc_rgn_long_short <- readRDS("out/conc_region_long_short.rds")
rgn_ordered_by_life <- readRDS("out/regions_ordered_by_life.rds")

set.seed(0)

codes_lad <- codes(conc, classification = "lad")
codes_rgn <- codes(conc, classification = "rgn")
i_cornwall <- match("Cornwall", codes_lad) # 'mx' uses "Cornwall and Isles of Scilly"
codes_lad <- codes_lad[-i_cornwall]
codes_rgn <- codes_rgn[-i_cornwall]
choose_lad <- function(name) {
    x <- codes_lad[codes_rgn == name]
    sample(x, size = 5, replace = FALSE)
}
sample_lad <- lapply(rgn_ordered_by_life, choose_lad)
sample_lad <- unlist(sample_lad)

rgn_short_ordered_by_life <- translate(rgn_ordered_by_life,
                                       conc = conc_rgn_long_short)

mx_order_lad <- subarray(mx,
                         subarray = (region %in% sample_lad
                             & variant == "None"))
mx_order_lad <- collapseDimension(mx_order_lad,
                                  dimension = "sex",
                                  weights = popn)
lt_order_lad <- LifeTable(mx_order_lad)
life_order_lad <- lifeExpectancy(lt_order_lad)
life_order_lad <- collapseIterations(life_order_lad,
                                     FUN = median)
life_order_lad <- sort(life_order_lad)
lad_ordered_by_life <- dimnames(life_order_lad)$region

mx <- subarray(mx,
               subarray = region %in% sample_lad)
lt <- LifeTable(mx)
life <- lifeExpectancy(lt)
life <- collapseIterations(life,
                           prob = c(0.025, 0.5, 0.975))
life <- as.data.frame(life)
life$region <- factor(life$region,
                      levels = lad_ordered_by_life)
life$ag <- translate(life$region,
                     conc = conc)
life$ag <- translate(life$ag,
                     conc = conc_rgn_long_short)
life$ag <- factor(life$ag,
                  levels = rgn_short_ordered_by_life)
life_sample <- life[order(life$variant, life$quantile, life$region, life$ag, life$sex), ]

saveRDS(life_sample,
        file = "out/life_sample.rds")

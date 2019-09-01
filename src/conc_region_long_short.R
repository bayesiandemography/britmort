
library(dembase)

conc_region_long_short <- data.frame(long = c("North East",
                                              "North West",
                                              "Wales",
                                              "Yorkshire and The Humber",
                                              "West Midlands",
                                              "East Midlands",
                                              "East of England",
                                              "South West",
                                              "South East",
                                              "London"),
                                     short = c("North East",
                                               "North West",
                                               "Wales",
                                               "Yorkshire",
                                               "W. Midlands",
                                               "E. Midlands",
                                               "East Engl.",
                                               "South West",
                                               "South East",
                                               "London"))
conc_region_long_short <- Concordance(conc_region_long_short)
saveRDS(conc_region_long_short,
        file = "out/conc_region_long_short.rds")


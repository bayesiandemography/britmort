
library(dembase)
library(demdata)

deaths <- demdata::england.wales.deaths

deaths <- Counts(deaths)
deaths <- subarray(deaths,
                   subarray = region != "Usual residence outside England and Wales")
saveRDS(deaths,
        file = "out/deaths.rds")


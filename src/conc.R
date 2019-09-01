
library(methods)
library(dembase)
library(demdata)

conc <- demdata::england.wales.conc

conc <- Concordance(conc)
conc.cornwall <- data.frame(lad = "Cornwall and Isles of Scilly",
                            rgn = "South West")
conc.cornwall <- Concordance(conc.cornwall)
conc <- splice(conc, conc.cornwall)

saveRDS(conc,
        file = "out/conc.rds")


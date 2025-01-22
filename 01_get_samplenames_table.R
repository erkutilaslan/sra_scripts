#!usr/bin/Rscript

# dependencies
library(tidyverse)

# import table
sra_runtable <- read.table("./SraRunTable.txt", sep = ",",
                           header = TRUE)

# filter columns
sra_runtable <- sra_runtable[, c("Run", "chip_antibody", "Developmental_stage")]
colnames(sra_runtable)[1] <- "run"

# change chip_antibody None values to Input
sra_runtable[sra_runtable == "None"] <- "Input"

# format rows
#sra_runtable$chip_antibody <- gsub(" ", "-", sra_runtable$chip_antibody)
#sra_runtable$chip_antibody <- gsub("\\.", "", sra_runtable$chip_antibody)

# merge rows
sra_runtable$samplename <- paste(sra_runtable$Developmental_stage, "_",
                                 sra_runtable$chip_antibody, "_",
                                 sra_runtable$run)

# format rows
sra_runtable$samplename <- gsub(" ", "", sra_runtable$samplename)
sra_runtable$samplename <- gsub("\\.", "", sra_runtable$samplename)
sra_runtable$samplename <- gsub("\\(", "-", sra_runtable$samplename)
sra_runtable$samplename <- gsub("\\)", "", sra_runtable$samplename)

# remove unnnecessary columns
sra_runtable <- sra_runtable[, c(1, 4)]

# export table
write.csv(sra_runtable, "./SRA_samplenames.csv",
          row.names = FALSE,
          quote = FALSE)

library(microseq)
fname <- "LIB058683_GEN00257658_day0-HC_S1_L001_R1_001.fastq.gz"
in.file <- paste("data/all_data", fname, sep="/")
data <- readFastq(in.file)
print(data)

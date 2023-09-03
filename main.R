file <- "data/seq.txt"
data <- read.table(file,              # TXT data file indicated as string or full path to the file
           header = FALSE,    # Whether to display the header (TRUE) or not (FALSE)
           sep = "\n")         # Character used to separate decimals of the numbers in the file
path <- "/Users/yd973/Dropbox (Partners HealthCare)/danni/results"
for (i in seq(1, dim(data)[1])) {
    fname <- paste0(path, "/", data[i, 1], ".clones_IGH.tsv")
    df <- as.data.frame(data.table::fread(fname))
    cols <- columns(df)
}

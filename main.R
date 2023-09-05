file <- "data/seq.txt"
data <- read.table(file,              # TXT data file indicated as string or full path to the file
           header = FALSE,    # Whether to display the header (TRUE) or not (FALSE)
           sep = "\n")         # Character used to separate decimals of the numbers in the file
path <- "/Users/yd973/Dropbox (Partners HealthCare)/danni/results"
n.arr <- seq(1, dim(data)[1])
# n.arr <- c(1, 2, 3)
res.final <- c()
for (i in n.arr) {
    label <- data[i, 1]
    code <- strsplit(label, "_")[[1]][3]
    mice <- strsplit(code, "-")[[1]][1]
    pop <- strsplit(code, "-")[[1]][2]

    fname <- paste0(path, "/", label, ".clones_IGH.tsv")
    df <- as.data.frame(data.table::fread(fname))
    # cols <- colnames(df)
    sel.col <- "allCHitsWithScore"
    arr <- df[[sel.col]]
    arr.new <- unlist(stringr::str_split(arr,","))
    # length(arr.new) > length(arr)
    arr.ig <- sub("\\*.*", "", arr.new)
    res <- data.frame(table(arr.ig))
    res <- res[2:dim(res)[1], ]
    res$mice <- mice
    res$pop <- pop
    colnames(res)[1] <- "ig"
    row.names(res) <- NULL
    res.final <- rbind(res.final, res)
}
# print(res.final)
outpath <- "./result/seq_res.xlsx"
writexl::write_xlsx(res.final, outpath)

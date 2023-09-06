library(dplyr)
rm(list = ls())
fname <-
  "/Users/yd973/Documents/research/sequencing/result/seq_res.xlsx"
outdir <- "/Users/yd973/Documents/research/sequencing/figs"
df <- readxl::read_excel(fname)
print(df)
# remove IgD and IgE
df <- df[!df$ig %in% c("IGHE", "IGHD"), ]

df.day0 <- df[df$mice == "day0", ]
df <- df[df$mice != "day0", ]
df.day0$pop <- df.day0$mice

df.ctrl <- c()
for (m in unique(df$mice)) {
  df.m <- df.day0
  df.m$mice <- m
  df.ctrl <- rbind(df.ctrl, df.m)
}
df <- rbind(df, df.ctrl)

x.order <- c("day0", "ASC", "FOB", "CD21lo", "GC")
df$ig <- factor(df$ig, levels = c("IGHA", "IGHM", "IGHG1", "IGHG2B", "IGHG2C", "IGHG3"))
df$pop <- factor(df$pop, levels = x.order)
# global
df.glob <-
  df %>% dplyr::group_by(ig, pop) %>% dplyr::summarise(count = sum(Freq))
df1 <-
  df.glob %>% dplyr::group_by(pop) %>% dplyr::mutate(norm.freq = count / sum(count))

my.pal <- c(
  IGHA = "#8ed3c7",
  IGHM = "#feffb2",
  IGHG1 = "#bfbada",
  IGHG2B = "#f68073",
  IGHG2C = "#7fb1d3",
  IGHG3 = "#f8b463"
)
fig <-
  ggplot2::ggplot(df1, ggplot2::aes(x = pop, y = norm.freq, fill = ig)) +
  ggplot2::geom_bar(stat = "identity", colour = "black") +
  ggplot2::labs(x = "Subset", y = "Frequency", fill = "Isotype") +
  # ggplot2::scale_x_discrete(labels = x.order) +
  ggplot2::theme_classic() +
  ggplot2::scale_fill_manual(values = my.pal)
print(fig)
fig.fname <- paste(outdir, "global.pdf", sep = "/")
ggplot2::ggsave(fig.fname, fig, width = 5, height = 6)

# per mouse
df.mice <-
  df %>% dplyr::group_by(mice, ig, pop) %>% dplyr::summarise(count = sum(Freq))
df2 <-
  df.mice %>% dplyr::group_by(mice, pop) %>% dplyr::mutate(norm.freq = count / sum(count))

fig <-
  ggplot2::ggplot(df2, ggplot2::aes(x = pop, y = norm.freq, fill = ig)) +
  ggplot2::geom_bar(stat = "identity", colour = "black") +
  ggplot2::labs(x = "Subset", y = "Frequency", fill = "Isotype") +
  # ggplot2::scale_x_discrete(labels = x.order) +
  ggplot2::theme_classic() +
  ggplot2::facet_grid( ~ mice) +
  ggplot2::scale_fill_manual(values = my.pal)
print(fig)
fig.fname <- paste(outdir, "per_mice.pdf", sep = "/")
ggplot2::ggsave(fig.fname, fig, width = 12, height = 5)

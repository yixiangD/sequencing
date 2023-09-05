library(dplyr)
fname <- "./result/seq_res.xlsx"
outdir <- "./figs"
df <- readxl::read_excel(fname)
print(df)
# global
df.glob <- df %>% dplyr::group_by(ig, pop) %>% dplyr::summarise(count = sum(Freq))
df1 <- df.glob %>% dplyr::group_by(pop) %>% dplyr::mutate(norm.freq = count / sum(count))

fig <- ggplot2::ggplot(df1, ggplot2::aes(x = pop, y = norm.freq, fill = ig)) +
  ggplot2::geom_bar(stat = "identity", colour="black") +
  ggplot2::labs(x = "Subset", y = "Frequency", fill = "Isotype")+
  ggplot2::theme_classic() +
  ggplot2::scale_fill_brewer(palette = "Set3")
print(fig)
fig.fname <- paste(outdir, "global.pdf", sep = "/")
ggplot2::ggsave(fig.fname, fig, width = 5, height = 6)

# per mouse
df.mice <- df %>% dplyr::group_by(mice, ig, pop) %>% dplyr::summarise(count = sum(Freq))
df2 <- df.mice %>% dplyr::group_by(mice, pop) %>% dplyr::mutate(norm.freq = count / sum(count))

fig <- ggplot2::ggplot(df2, ggplot2::aes(x = pop, y = norm.freq, fill = ig)) +
  ggplot2::geom_bar(stat = "identity", colour="black") +
  ggplot2::labs(x = "Subset", y = "Frequency", fill = "Isotype")+
  ggplot2::theme_classic() +
  ggplot2::facet_grid(~mice) +
  ggplot2::scale_fill_brewer(palette = "Set3")
print(fig)
fig.fname <- paste(outdir, "per_mice.pdf", sep = "/")
ggplot2::ggsave(fig.fname, fig, width = 12, height = 5)

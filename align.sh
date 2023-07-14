fd_name="data/all_data"
out="LIB058683_GEN00257688_M4-CD21lo-HC_S16"
mixcr analyze rnaseq-bcr-full-length --species mouse \
    $fd_name/${out}_L001_R1_001.fastq.gz \
    $fd_name/${out}_L001_R2_001.fastq.gz \
    result/$out
mixcr exportQc align \
    result/${out}.contigs.clns \
    figs/alignQc.pdf
mixcr exportQc chainUsage \
    result/${out}.contigs.clns \
    figs/chainUsage.pdf

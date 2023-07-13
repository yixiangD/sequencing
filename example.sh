fd_name="data/all_data"
out="test2"
mixcr analyze rnaseq-bcr-full-length --species mouse \
$fd_name/LIB058683_GEN00257658_day0-HC_S1_L001_R1_001.fastq.gz \
$fd_name/LIB058683_GEN00257658_day0-HC_S1_L001_R2_001.fastq.gz \
result/$out

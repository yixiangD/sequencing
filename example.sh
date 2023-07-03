fd_name="data/drive-download-20230530T162830Z-001"
out="20230530T162830Z-001"
mixcr analyze milab-human-bcr-multiplex-cdr3 \
$fd_name/LIB058683_GEN00257672_M2-CD21lo-HC_S8_L001_R1_001.fastq.gz \
$fd_name/LIB058683_GEN00257672_M2-CD21lo-HC_S8_L001_R2_001.fastq.gz \
result/$out

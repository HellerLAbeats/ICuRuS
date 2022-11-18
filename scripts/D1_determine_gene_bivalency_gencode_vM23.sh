#!/bin/sh

cd /Users/szhang32/Desktop/INTACT6/bivalency

annotation="/Users/szhang32/ref/mm10/gencode_vM23_name_conversion.txt"
K4="/Users/szhang32/Desktop/INTACT5/peak/D1_H3K4me3_peaks.narrowPeak"
#K27="/Users/szhang32/Desktop/INTACT6/peak/D1_27me3_Active_S45_duplicate_removed.sorted-W200-G600-FDR0.01-island.bed"
K27="/Users/szhang32/Desktop/INTACT6/peak/D1_27me3_Active_merged-W200-G600-FDR0.01-island.bed"
geneExpression="/Users/szhang32/Desktop/public_RNA_seq/RiboTag_MSN/D1_D2_cuffdiff/genes.fpkm_tracking"
outfile="D1_RPKM_bivalency_gencode_vM23.txt"

### extract ensemble ID and D1 FPKM
riboD1FPKM="ribo_D1_FPKM.txt"
cut -f 1,10 $geneExpression > $riboD1FPKM

python3 scripts/determine_gene_bivalency.py $annotation $K4 $K27 $riboD1FPKM $outfile

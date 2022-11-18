#!/bin/sh

cd /Users/szhang32/Desktop/INTACT6/bivalency

annotation="/Users/szhang32/ref/mm10/gencode_vM23_name_conversion.txt"
K4="/Users/szhang32/Desktop/INTACT7/peak/A2a_H3K4me3_peaks.narrowPeak"
K27="/Users/szhang32/Desktop/INTACT6/peak/A2a_27me3_Active_merged-W200-G600-FDR0.01-island.bed"
geneExpression="/Users/szhang32/Desktop/public_RNA_seq/RiboTag_MSN/D1_D2_cuffdiff/genes.fpkm_tracking"
outfile="A2a_RPKM_bivalency_gencode_vM23.txt"

### extract ensemble ID and A2a FPKM
riboD2FPKM="ribo_D2_FPKM.txt"
cut -f 1,14 $geneExpression > $riboD2FPKM

python3 scripts/determine_gene_bivalency.py $annotation $K4 $K27 $riboD2FPKM $outfile

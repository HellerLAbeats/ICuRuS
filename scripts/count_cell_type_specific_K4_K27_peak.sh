#!/bin/sh
cd /Users/szhang32/Desktop/INTACT6/bivalency

annotation="/Users/szhang32/ref/mm10/gencode_vM23_name_conversion.txt"

D1_gene="D1_upregulated_genes.txt"
D1_K4="/Users/szhang32/Desktop/INTACT5/peak/D1_H3K4me3_peaks.narrowPeak"
D1_K27="/Users/szhang32/Desktop/INTACT6/peak/D1_27me3_Active_merged-W200-G600-FDR0.01-island.bed"

A2a_gene="A2a_upregulated_genes.txt"
A2a_K4="/Users/szhang32/Desktop/INTACT7/peak/A2a_H3K4me3_peaks.narrowPeak"
A2a_K27="/Users/szhang32/Desktop/INTACT6/peak/A2a_27me3_Active_merged-W200-G600-FDR0.01-island.bed"


python3 scripts/count_cell_type_specific_K4_K27_peak.py $D1_gene $D1_K4 $D1_K27 $A2a_gene $A2a_K4 $A2a_K27



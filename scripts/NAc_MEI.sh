#!/bin/sh
cd /Users/szhang32/Desktop/INTACT6/Mutually_exclusive_index

NAcK4Peak="/Users/szhang32/Desktop/public_ChIP_seq/H3K4me3/peak/NAc_H3K4me3_saline_no_input_top_20000_peaks.narrowPeak"
NAcK27Peak="/Users/szhang32/Desktop/public_ChIP_seq/H3K27me3/peak/N2a_H3K27me3_merged-W200-G600-FDR0.01-island.bed"
cut -f 1-3 $NAcK4Peak > NAc_K4.bed
cut -f 1-3 $NAcK27Peak > NAc_K27.bed

### get K4me3 only peaks
bedtools intersect -a NAc_K4.bed -b NAc_K27.bed -v > NAc_K4_only.bed
nK4me3=`cat NAc_K4_only.bed | wc -l`

### get K27me3 only peaks
bedtools intersect -a NAc_K27.bed -b NAc_K4.bed -v > NAc_K27_only.bed
nK27me3=`cat NAc_K27_only.bed | wc -l`

### totle is the number of the fragments that are enriched with eithere k4 or k27
# merge, sort and merge
cat NAc_K4.bed NAc_K27.bed > NAc_non_unique_both.bed
sort -k1,1 -k2,2n NAc_non_unique_both.bed > NAc_non_unique_both.sorted.bed
bedtools merge -i NAc_non_unique_both.sorted.bed > NAc_both_merged.bed
ntotal=`cat NAc_both_merged.bed | wc -l`


### nbivalent is the number of the fragments that are enriched with both K4 and K27
bedtools intersect -a NAc_K4.bed -b NAc_K27.bed > NAc_overlaped.bed
Bv=`cat NAc_overlaped.bed | wc -l`

MEI=`echo ${nK4me3}*${nK27me3}/${ntotal}/${Bv} | bc -l`
echo "NAc mutually exclusive index is: $MEI"

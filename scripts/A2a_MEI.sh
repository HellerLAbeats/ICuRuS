#!/bin/sh
cd /Users/szhang32/Desktop/INTACT6/Mutually_exclusive_index

A2aK4Peak="/Users/szhang32/Desktop/INTACT7/peak/A2a_H3K4me3_peaks.narrowPeak"
A2aK27Peak="/Users/szhang32/Desktop/INTACT6/peak/A2a_27me3_Active_merged-W200-G600-FDR0.01-island.bed"
cut -f 1-3 $A2aK4Peak > A2a_K4.bed
cut -f 1-3 $A2aK27Peak > A2a_K27.bed

### get K4me3 only peaks
bedtools intersect -a A2a_K4.bed -b A2a_K27.bed -v > A2a_K4_only.bed
nK4me3=`cat A2a_K4_only.bed | wc -l`

### get K27me3 only peaks
bedtools intersect -a A2a_K27.bed -b A2a_K4.bed -v > A2a_K27_only.bed
nK27me3=`cat A2a_K27_only.bed | wc -l`

### totle is the number of the fragments that are enriched with eithere k4 or k27
# merge, sort and merge
cat A2a_K4.bed A2a_K27.bed > A2a_non_unique_both.bed
sort -k1,1 -k2,2n A2a_non_unique_both.bed > A2a_non_unique_both.sorted.bed
bedtools merge -i A2a_non_unique_both.sorted.bed > A2a_both_merged.bed
ntotal=`cat A2a_both_merged.bed | wc -l`


### nbivalent is the number of the fragments that are enriched with both K4 and K27
bedtools intersect -a A2a_K4.bed -b A2a_K27.bed > A2a_overlaped.bed
Bv=`cat A2a_overlaped.bed | wc -l`

MEI=`echo ${nK4me3}*${nK27me3}/${ntotal}/${Bv} | bc -l`
echo "A2a mutually exclusive index is: $MEI"

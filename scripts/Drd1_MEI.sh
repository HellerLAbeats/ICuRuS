#!/bin/sh
cd /Users/szhang32/Desktop/INTACT6/Mutually_exclusive_index

D1K4Peak="/Users/szhang32/Desktop/INTACT5/peak/D1_H3K4me3_peaks.narrowPeak"
D1K27Peak="/Users/szhang32/Desktop/INTACT6/peak/D1_27me3_Active_merged-W200-G600-FDR0.01-island.bed"
cut -f 1-3 $D1K4Peak > D1_K4.bed
cut -f 1-3 $D1K27Peak > D1_K27.bed

### get K4me3 only peaks
bedtools intersect -a D1_K4.bed -b D1_K27.bed -v > D1_K4_only.bed
nK4me3=`cat D1_K4_only.bed | wc -l`

### get K27me3 only peaks
bedtools intersect -a D1_K27.bed -b D1_K4.bed -v > D1_K27_only.bed
nK27me3=`cat D1_K27_only.bed | wc -l`

### totle is the number of the fragments that are enriched with eithere k4 or k27
# merge, sort and merge
cat D1_K4.bed D1_K27.bed > D1_non_unique_both.bed
sort -k1,1 -k2,2n D1_non_unique_both.bed > D1_non_unique_both.sorted.bed
bedtools merge -i D1_non_unique_both.sorted.bed > D1_both_merged.bed
ntotal=`cat D1_both_merged.bed | wc -l`


### nbivalent is the number of the fragments that are enriched with both K4 and K27
bedtools intersect -a D1_K4.bed -b D1_K27.bed > D1_overlaped.bed
Bv=`cat D1_overlaped.bed | wc -l`

MEI=`echo ${nK4me3}*${nK27me3}/${ntotal}/${Bv} | bc -l`
echo "D1 mutually exclusive index is: $MEI"

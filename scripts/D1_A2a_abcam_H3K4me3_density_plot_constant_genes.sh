#!/bin/sh
#BSUB -J D1_A2a_K4_const_TSS_density_plot
#BSUB -oo D1_A2a_K4_const_TSS_density_plot.o
#BSUB -eo D1_A2a_K4_const_TSS_density_plot.e
#BSUB -B
#BSUB -N
#BSUB -M 10000
#BSUB -u Shuo.Zhang@Pennmedicine.upenn.edu
#BSUB -W 20:00


date


cd /project/eheller_itmat_lab/shuo/INTACT5/density_plot

regions="/project/eheller_itmat_lab/shuo/INTACT5/CHPIN_normalization/D1_A2a_merged_K4_constant_genes.bed"


A2a="/project/eheller_itmat_lab/shuo/INTACT5/CHPIN_normalization/QNA2a_K4_ABCAM_merged_CPM.bw"
D1="/project/eheller_itmat_lab/shuo/INTACT5/CHPIN_normalization/QND1_K4_abcam_merged_CPM.bw"

D1IgG="/project/eheller_itmat_lab/shuo/INTACT4/bigwig_duplicate_removed/D1_IgG_S21_CPM.bw"
A2aIgG="/project/eheller_itmat_lab/shuo/INTACT4/bigwig_duplicate_removed/A2a_IgG_S26_CPM.bw"



name="Drd1_A2a_K4_QN"


matrix="${name}_const_TSS__matrix.gz"
outPDF="${name}_const_TSS_.pdf"

#/home/szhang32/my_python3.6.3/bin/deepTools/computeMatrix reference-point --referencePoint center -S $D1 $A2a $D1IgG $A2aIgG -R $regions -a 5000 -b 5000 -o $matrix

#/home/szhang32/my_python3.6.3/bin/deepTools/plotProfile --refPointLabel "TSS" --samplesLabel "D1_K4" "A2a_K4" "D1_IgG" "A2a_IgG" --plotTitle "D1 and A2a QN H3K4me3 signal TSS" --yAxisLabel "Normalized read count" -m $matrix -o $outPDF --perGroup

/home/szhang32/my_python3.6.3/bin/deepTools/computeMatrix reference-point --referencePoint center -S $D1 $A2a -R $regions -a 5000 -b 5000 -o $matrix

/home/szhang32/my_python3.6.3/bin/deepTools/plotProfile --refPointLabel "TSS" --samplesLabel "D1_K4" "A2a_K4" --plotTitle "D1 and A2a QN H3K4me3 signal TSS" --yAxisLabel "Normalized read count" -m $matrix -o $outPDF --perGroup

# heatmap figure
heatmap="${name}_const_TSS_heatmap.pdf"
/home/szhang32/my_python3.6.3/bin/deepTools/plotHeatmap --colorMap bwr -m $matrix -o $heatmap


date

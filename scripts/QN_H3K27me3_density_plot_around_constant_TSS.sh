#!/bin/sh
#BSUB -J merged_QN_H3K27me3_const_TSS_density_plot
#BSUB -oo merged_QN_H3K27me3_const_TSS_density_plot.o
#BSUB -eo merged_QN_H3K27me3_const_TSS_density_plot.e
#BSUB -B
#BSUB -N
#BSUB -M 10000
#BSUB -u Shuo.Zhang@Pennmedicine.upenn.edu
#BSUB -W 20:00


date


cd /project/eheller_itmat_lab/shuo/INTACT6/density_plot

regions="/project/eheller_itmat_lab/shuo/INTACT5/CHPIN_normalization/D1_A2a_merged_K4_constant_genes.bed"

D1K27="/project/eheller_itmat_lab/shuo/INTACT5/CHPIN_normalization/QND1_27me3_Active_merged_CPM.bw"
A2aK27="/project/eheller_itmat_lab/shuo/INTACT5/CHPIN_normalization/QNA2a_27me3_Active_merged_CPM.bw"

D1IgG="/project/eheller_itmat_lab/shuo/INTACT4/bigwig_duplicate_removed/D1_IgG_S21_CPM.bw"
A2aIgG="/project/eheller_itmat_lab/shuo/INTACT4/bigwig_duplicate_removed/A2a_IgG_S26_CPM.bw"


name="D1_A2a_merged_QN_K27me3"


matrix="${name}_const_TSS_matrix.gz"
outPDF="${name}_density_plot_const_TSS.pdf"

# compute matrix

/home/szhang32/my_python3.6.3/bin/deepTools/computeMatrix scale-regions --startLabel start --endLabel end -S $D1K27 $A2aK27 -R $regions -a 5000 -b 5000 -o $matrix

/home/szhang32/my_python3.6.3/bin/deepTools/plotProfile --startLabel start --endLabel end --samplesLabel "D1_K27" "A2a_K27" --plotTitle "CUTandRun H3K27me3 signal around peaks" --yAxisLabel "Normalized read count" -m $matrix -o $outPDF --perGroup

# heatmap
outHM="${name}_const_TSS.pdf"
/home/szhang32/my_python3.6.3/bin/deepTools/plotHeatmap --colorMap bwr -m $matrix -o $outHM

date

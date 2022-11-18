#!/bin/sh

cd /Users/szhang32/Desktop/INTACT6/bivalency

annotation="/Users/szhang32/ref/mm10/gencode_vM23_name_conversion.txt"


### A2a
geneExpression="ribo_D2_FPKM.txt"
outHigh="A2a_high_gene.bed"
outMedium="A2a_medium_gene.bed"
outLow="A2a_low_gene.bed"

python3 scripts/categorize_gene_expression.py $geneExpression $annotation $outHigh $outMedium $outLow



### D1
geneExpression="ribo_D1_FPKM.txt"
outHigh="D1_high_gene.bed"
outMedium="D1_medium_gene.bed"
outLow="D1_low_gene.bed"

python3 scripts/categorize_gene_expression.py $geneExpression $annotation $outHigh $outMedium $outLow


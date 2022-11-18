library(CHIPIN)

setwd("/Users/szhang32/Desktop/INTACT5/CHPIN_normalization")
RPKM <- "/Users/szhang32/Desktop/public_RNA_seq/RiboTag_MSN/D1_D2_cuffdiff/CHIPIN_in_gene_expression.txt"
organism <- 'mm10'


#### using RPKM values with CPM normalized bigwig
## H3K4me3
path_to_bw <- c("/Users/szhang32/Desktop/Dropbox/INTACT/pygenome/D1_K4_abcam_merged_CPM.bw","/Users/szhang32/Desktop/Dropbox/INTACT/pygenome/A2a_K4_ABCAM_merged_CPM.bw")
# quantile normalization
CHIPIN_normalize(path_to_bw, type_norm="quantile", TPM=NULL, RPKM, raw_read_count=NULL, organism='mm10', sample_name = 'D1_A2a_merged_K4')


### H3K27me3
path_to_bw <- c("/Users/szhang32/Desktop/Dropbox/INTACT/pygenome/D1_27me3_Active_merged_CPM.bw","/Users/szhang32/Desktop/Dropbox/INTACT/pygenome/A2a_27me3_Active_merged_CPM.bw")
CHIPIN_normalize(path_to_bw, type_norm="quantile", TPM=NULL, RPKM, raw_read_count=NULL, organism='mm10', sample_name = 'D1_A2a_K4')

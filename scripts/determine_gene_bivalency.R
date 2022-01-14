setwd("~/Desktop/INTACT6/bivalency/")

library(ggplot2)
library(reshape)

### riboTag GRCm38.90 published D1 RPKM
bivalency <- read.table("D1_RPKM_bivalency.txt", header = TRUE)
bivalency$bivalency_status <- factor(bivalency$bivalency_status, levels = c("none", "H3K4me3", "H3K27me3", "Bivalent"))

ggplot(bivalency, aes(x = bivalency_status, y = log2(D1_male_average_RPKM+1))) +
  geom_boxplot(width = 0.6, outlier.shape = 1) +
  #facet_grid(~H3K27me3$cutoff)+
  ggtitle("\n")+
  theme_classic()+
  theme(plot.title = element_text(size = 20, hjust = 0.5), line = element_blank(), plot.background = element_blank(), panel.grid.major = element_blank()) + #set the background
  theme(panel.border = element_blank()) +   #set the border
  theme(axis.text.x = element_text()) + 
  theme(axis.title = element_text(size = 20), axis.text.x = element_text(size=16, angle=0, hjust = 0.5), axis.text.y = element_text(size=16)) + #set the x and y lab
  ylab("Gene expression log2(RPKM+1)") + xlab("") +     #set the name of x-axis and y-axis
  theme( legend.title = element_blank(),  legend.position = c(0.85, 0.980), legend.text = element_text(size = 12), legend.key.width = unit(0.5, "cm")) + #set legend
  theme(axis.line.x = element_line(color="black", size = .6),  
        axis.line.y = element_line(color="black", size = .6),
        axis.ticks.x = element_line(size = 0.5),
        axis.ticks.y = element_line(size = 0.5),
        axis.ticks.length = unit(0.2, "cm")) 
scale_y_continuous(breaks = seq(0,6,2), limits=c(0, 6))
t.test(subset(bivalency, bivalency$bivalency_status == "H3K4me3")$D1_male_average_RPKM, subset(bivalency, bivalency$bivalency_status == "H3K27me3")$D1_male_average_RPKM)
### END of riboTag GRCm38.90 published D1 RPKM

#######
### riboTag D1 gencode vM23 cuffdiff
D1_bivalency <- read.table("D1_RPKM_bivalency_gencode_vM23.txt", header = TRUE)
D1_bivalency$bivalency_status <- factor(D1_bivalency$bivalency_status, levels = c("none", "H3K4me3", "H3K27me3", "Bivalent"))

ggplot(D1_bivalency, aes(x = bivalency_status, y = log2(FPKM+1))) +
  geom_boxplot(width = 0.6, outlier.shape = 1) +
  #facet_grid(~H3K27me3$cutoff)+
  ggtitle("D1\n")+
  theme_classic()+
  theme(plot.title = element_text(size = 20, hjust = 0.5), line = element_blank(), plot.background = element_blank(), panel.grid.major = element_blank()) + #set the background
  theme(panel.border = element_blank()) +   #set the border
  theme(axis.text.x = element_text()) + 
  theme(axis.title = element_text(size = 20), axis.text.x = element_text(size=16, angle=0, hjust = 0.5), axis.text.y = element_text(size=16)) + #set the x and y lab
  ylab("Gene expression log2(FPKM+1)\n") + xlab("") +     #set the name of x-axis and y-axis
  theme( legend.title = element_blank(),  legend.position = c(0.85, 0.980), legend.text = element_text(size = 12), legend.key.width = unit(0.5, "cm")) + #set legend
  theme(axis.line.x = element_line(color="black", size = .6),  
        axis.line.y = element_line(color="black", size = .6),
        axis.ticks.x = element_line(size = 0.5),
        axis.ticks.y = element_line(size = 0.5),
        axis.ticks.length = unit(0.2, "cm")) +
scale_y_continuous(breaks = seq(0,20, 5), limits=c(0, 20))

D1.aov <- aov(FPKM ~ bivalency_status, data = D1_bivalency)
summary(D1.aov)
TukeyHSD(D1.aov)
pairwise.t.test(D1_bivalency$FPKM, D1_bivalency$bivalency_status, p.adjust.method = "BH")

# non parametric test
kruskal.test(FPKM ~ bivalency_status, data = D1_bivalency)
pairwise.wilcox.test(D1_bivalency$FPKM, D1_bivalency$bivalency_status, p.adjust.method = "BH")

### END of riboTag D1 gencode vM23 cuffdiff
######




#######
### riboTag D2 gencode vM23 cuffdiff
### D2 is biologically same as A2a
A2a_bivalency <- read.table("A2a_RPKM_bivalency_gencode_vM23.txt", header = TRUE)
A2a_bivalency$bivalency_status <- factor(A2a_bivalency$bivalency_status, levels = c("none", "H3K4me3", "H3K27me3", "Bivalent"))

ggplot(A2a_bivalency, aes(x = bivalency_status, y = log2(FPKM+1))) +
  geom_boxplot(width = 0.6, outlier.shape = 1) +
  #facet_grid(~H3K27me3$cutoff)+
  ggtitle("A2a\n")+
  theme_classic()+
  theme(plot.title = element_text(size = 20, hjust = 0.5), line = element_blank(), plot.background = element_blank(), panel.grid.major = element_blank()) + #set the background
  theme(panel.border = element_blank()) +   #set the border
  theme(axis.text.x = element_text()) + 
  theme(axis.title = element_text(size = 20), axis.text.x = element_text(size=16, angle=0, hjust = 0.5), axis.text.y = element_text(size=16)) + #set the x and y lab
  ylab("Gene expression log2(FPKM+1)\n") + xlab("") +     #set the name of x-axis and y-axis
  theme( legend.title = element_blank(),  legend.position = c(0.85, 0.980), legend.text = element_text(size = 12), legend.key.width = unit(0.5, "cm")) + #set legend
  theme(axis.line.x = element_line(color="black", size = .6),  
        axis.line.y = element_line(color="black", size = .6),
        axis.ticks.x = element_line(size = 0.5),
        axis.ticks.y = element_line(size = 0.5),
        axis.ticks.length = unit(0.2, "cm")) +
scale_y_continuous(breaks = seq(0,20,5), limits=c(0, 20))

A2a.aov <- aov(FPKM ~ bivalency_status, data = A2a_bivalency)
summary(A2a.aov)
TukeyHSD(A2a.aov)

### nonparametric test
kruskal.test(FPKM ~ bivalency_status, data = A2a_bivalency)
pairwise.wilcox.test(A2a_bivalency$FPKM, A2a_bivalency$bivalency_status, p.adjust.method = "BH")

### END of riboTag D2 gencode vM23 cuffdiff
######



### calculate mutually exclusive index

# A2a
A2a_K4_only_gene <- 13896
A2a_K27_only_gene <- 7962
A2a_bivalent_gene <- 2732
ntotal <- A2a_K4_only_gene + A2a_K27_only_gene + A2a_bivalent_gene
Br <- A2a_K4_only_gene * A2a_K27_only_gene
Br/ntotal/A2a_bivalent_gene


# D1
D1_K4_only_gene <- 14186
D1_K27_only_gene <- 5692
D1_bivalent_gene <- 1582
ntotal <- D1_K4_only_gene + D1_K27_only_gene + D1_bivalent_gene
Br <-D1_K4_only_gene * D1_K27_only_gene
 Br/ntotal/D1_bivalent_gene

# NAc
NAc_K4_only_gene <- 9436
NAc_K27_only_gene <- 9800
NAc_bivalent_gene <- 4124
ntotal <- NAc_K4_only_gene + NAc_K27_only_gene + NAc_bivalent_gene
Br <-NAc_K4_only_gene * NAc_K27_only_gene
MEI <- Br/ntotal/NAc_bivalent_gene

# N2a 
N2a_K4_only_gene <- 14135
N2a_K27_only_gene <- 9139
N2a_bivalent_gene <- 1921
ntotal <- N2a_K4_only_gene + N2a_K27_only_gene + N2a_bivalent_gene
Br <-N2a_K4_only_gene * N2a_K27_only_gene
Br/ntotal/N2a_bivalent_gene


import os
import sys

def main(argv):
    (geneExp, gene_annotation, outHigh, outMedium, outLow) = argv
    outHighFH = open(outHigh, 'w')
    outMediumFH = open(outMedium, 'w')
    outLowFH = open(outLow, 'w')
    annotation = read_gene_annotation(gene_annotation)

    with open(geneExp) as f:
        for line in f:
            (id, FPKM) = line.strip().split()
            if id != "tracking_id":
                if float(FPKM) >= 10:
                    outHighFH.write(annotation[id][1] + '\t' + str(annotation[id][2]) + '\t' + \
                                    str(annotation[id][3]) + '\t' + annotation[id][0] + '\t0\t' + annotation[id][4] + '\n')
                elif float(FPKM) < 1:
                    outLowFH.write(annotation[id][1] + '\t' + str(annotation[id][2]) + '\t' + \
                                    str(annotation[id][3]) + '\t' + annotation[id][0] + '\t0\t' + annotation[id][4] + '\n')
                else:
                    outMediumFH.write(annotation[id][1] + '\t' + str(annotation[id][2]) + '\t' + \
                                    str(annotation[id][3]) + '\t' + annotation[id][0] + '\t0\t' + annotation[id][4] + '\n')

def read_gene_annotation(gene_annotation):
    """
    get the transcription start site for each gene
    :param gene_annotation: gene_id gene_name chrom start end, strand
    :return: a dictionary, in which key is gene_id, value is [gene_name, chrom, TSS]
    """
    annotation = {}
    with open(gene_annotation) as f:
        for line in f:
            (gene_id, gene_name, chrom, start, end, strand) = line.strip().split()
            if gene_id == "gene_id":
                continue
            annotation[gene_id] = [gene_name, chrom, int(start), int(end), strand]
    return annotation


if __name__ == "__main__":
    main(sys.argv[1:])
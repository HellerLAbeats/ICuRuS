import sys
from collections import defaultdict

def main(argv):
    (in_gene_annotation, H3K4me3_peak_file, H3K27me3_peak_file, gene_expression, outfile) = argv
    outfh = open(outfile, 'w')
    outfh.write("gene\tFPKM\tbivalency_status\n")
    K4_peaks = readPeak(H3K4me3_peak_file)
    K27_peaks = readPeak(H3K27me3_peak_file)
    annotation = read_gene_annotation(in_gene_annotation)

    with open(gene_expression) as f:
        for line in f:
            (gene, RPKM) = line.strip().split()
            if gene == "gene" or gene == "tracking_id":
                continue
            (chrom, start, end) = get_region(annotation, gene)
            K4_status = is_overlapped(K4_peaks, chrom, start, end)
            K27_status = is_overlapped(K27_peaks, chrom, start, end)
            bivalency = "none"
            if (K4_status and K27_status):
                bivalency = "Bivalent"
            elif K4_status:
                bivalency = "H3K4me3"
            elif K27_status:
                bivalency = "H3K27me3"
            #if annotation[gene][0] == "Ptms":
            #    print(chrom + ':' + str(start) + '-' + str(end))
            #    print(K4_status)
            #    print(K27_status)
            #    print(K4_peaks[chrom])
            #    exit(0)

            outfh.write(annotation[gene][0] + '\t' + RPKM + '\t' + bivalency + '\n')


def readPeak(peak_file):
    peaks = defaultdict(list)
    with open(peak_file) as f:
        for line in f:
            (chr, start, end) = line.strip().split()[0:3]
            peaks[chr].append([int(start), int(end)])
    return peaks


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


def get_region(annotation, gene_id):
    upstream_len = 2000
    downstream_len = 1000
    if annotation[gene_id][4] == '+':
        start = annotation[gene_id][2] - upstream_len
        end = annotation[gene_id][2] + downstream_len
    else:
        start = annotation[gene_id][3] - downstream_len
        end = annotation[gene_id][3] + upstream_len
    return (annotation[gene_id][1], start, end)


def is_overlapped(peaks, chrom, start, end):
    """
    check if the promoter of a gene is overlapped with a called peak
    :param peaks:
    :param chrom:
    :param start:
    :param end:
    :return:
    """
    for temp_list in peaks[chrom]:
        if (temp_list[0] <= start and start <= temp_list[1] ) or (temp_list[0] <= end and end <= temp_list[1]) or \
                (start <= temp_list[0] and temp_list[1] <= end):
            return True
    return False

if __name__ == "__main__":
    main(sys.argv[1:])

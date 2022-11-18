import sys
from collections import defaultdict

def main(argv):
    (D1_gene_file, D1_K4_peak_file, D1_K27_peak_file, A2a_gene_file, A2a_K4_peak_file, A2a_K27_peak_file) = argv

    D1_K4 = readPeak(D1_K4_peak_file)
    D1_K27 = readPeak(D1_K27_peak_file)
    A2a_K4 = readPeak(A2a_K4_peak_file)
    A2a_K27 = readPeak(A2a_K27_peak_file)


    ### D1 count
    D1_K4_expected = 0
    D1_K4_both = 0
    D1_K4_opposite = 0
    D1_K27_opposite = 0
    D1_count = 0
    with open(D1_gene_file) as f:
        for line in f:
            D1_count += 1
            (chr, start, end) = get_promoter(line)
            if is_overlapped(D1_K4, chr, start, end) and not is_overlapped(A2a_K4, chr, start, end):
                D1_K4_expected += 1
            elif is_overlapped(D1_K4, chr, start, end) and is_overlapped(A2a_K4, chr, start, end):
                D1_K4_both += 1
            elif not is_overlapped(D1_K4, chr, start, end) and is_overlapped(A2a_K4, chr, start, end):
                D1_K4_opposite += 1
            elif is_overlapped(D1_K4, chr, start, end) and is_overlapped(A2a_K4, chr, start, end) \
                and is_overlapped(A2a_K27, chr, start, end):
                D1_K27_opposite += 1

    print("There are " + str(D1_count) + " D1 cell type specific genes ")
    print("The number of D1 cell type genes with D1_K4 peak, but not A2a_K4: " + str(D1_K4_expected))
    print("The number of D1 cell type genes with D1_K4 and A2a_K4: " + str(D1_K4_both))
    print("The number of D1 cell type genes with without D1_K4, but with A2a_K4: " + str(D1_K4_opposite))
    print("The number of D1 cell type genes with D1_K4 and A2a_K4, and A2a_K27: " + str(D1_K27_opposite))
    print()
    ### D1 count
    A2a_K4_expected = 0
    A2a_K4_both = 0
    A2a_K4_opposite = 0
    A2a_K27_opposite = 0
    A2a_count = 0
    with open(A2a_gene_file) as f:
        for line in f:
            A2a_count += 1
            (chr, start, end) = get_promoter(line)
            if is_overlapped(A2a_K4, chr, start, end) and not is_overlapped(D1_K4, chr, start, end):
                A2a_K4_expected += 1
            elif is_overlapped(A2a_K4, chr, start, end) and is_overlapped(D1_K4, chr, start, end):
                A2a_K4_both += 1
            elif not is_overlapped(A2a_K4, chr, start, end) and is_overlapped(D1_K4, chr, start, end):
                A2a_K4_opposite += 1
            elif is_overlapped(A2a_K4, chr, start, end) and is_overlapped(D1_K4, chr, start, end) \
                and is_overlapped(D1_K27, chr, start, end):
                A2a_K27_opposite += 1

    print("There are " + str(A2a_count) + " A2a cell type specific genes ")
    print("The number of A2a cell type genes with A2a_K4 peak, but not D1_K4: " + str(A2a_K4_expected))
    print("The number of A2a cell type genes with A2a_K4 and D1_K4: " + str(A2a_K4_both))
    print("The number of A2a cell type genes with without A2a_K4, but with D1_K4: " + str(A2a_K4_opposite))
    print("The number of A2a cell type genes with A2a_K4 and D1_K4, and D1_K27: " + str(A2a_K27_opposite))


def get_promoter(line):
    (chr, gene_start, gene_end, gene, score, strand) = line.strip().split()
    upstream_len = 2000
    downstream_len = 1000
    if strand == '+':
        start = int(gene_start) - upstream_len
        end = int(gene_start) + downstream_len
    else:
        start = int(gene_end) - downstream_len
        end = int(gene_end) + upstream_len
    return (chr, start, end)


def readPeak(peak_file):
    peaks = defaultdict(list)
    with open(peak_file) as f:
        for line in f:
            (chr, start, end) = line.strip().split()[0:3]
            peaks[chr].append([int(start), int(end)])
    return peaks


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




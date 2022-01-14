import sys
import os

def main(argv):
    (sampleID, bam, bed, outfile) = argv
    total_mapped_reads = count_total_mapped_reads(bam)
    outfh = open(outfile, 'w')
    outfh.write("sampleID\ttotal_mapped_reads\tread_count_in_peak\tFRiP\n")
    with open(bed) as f:
        count = 0
        for line in f:
            (chrom, start, end) = line.strip().split()[0:3]
            region = chrom + ':' + str(start) + '-' + str(end)
            count += count_a_region(bam, region)
        FRiP = count / total_mapped_reads
        outfh.write(sampleID+ '\t' + str(total_mapped_reads) + '\t' + str(count) + '\t' + str(FRiP) + '\n')


def count_total_mapped_reads(bam):
    """
    count total reads from sorted bam
    :param bam: must be sorted
    :return: the total read count
    """
    cmd = "samtools view -c " + bam
    stream = os.popen(cmd)
    return int(stream.read().strip())

def count_a_region(bam, region):
    cmd = "samtools view -c " + bam + ' ' + region
    stream = os.popen(cmd)
    return int(stream.read().strip())


if __name__ == "__main__":
    main(sys.argv[1:])
import sys

def main(argv):
    (inGTF, outfile) = argv
    outfh = open(outfile, 'w')
    outfh.write("gene_id\tgene_name\tchr\tstart\tend\tstrand\n")
    with open(inGTF) as f:
        for line in f:
            line = line.strip()
            if line.startswith("#!") or line.startswith("##"):
                continue

            (chr, source, feature, start, end, score, strand) = line.split()[0:7]
            if feature == "gene":
                names = line.split('\t')[-1]
                (gene_id, gene_version, gene_name) = names.split(';')[0:3]
                #print(gene_id + '\t' + gene_name)
                gene_id = gene_id.split()[1]
                gene_id = gene_id.strip('"')
                gene_name = gene_name.split()[1]
                gene_name = gene_name.strip('"')
                outfh.write(gene_id + '\t' + gene_name + '\t' + chr + '\t' + start + '\t' + end + '\t' + strand + '\n')

    outfh.close()

if __name__ == "__main__":
    main(sys.argv[1:])

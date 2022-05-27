"""
this script it to pull out barcodes for Jessica's experiment
from the McAllister lab
"""
from argparse import ArgumentParser
import regex as re
import numpy as np
import toolz as tz

def stream_fastq(file_handler):
    """"
    Generator which gives all four lines if a fastq read as one string
    (snagged from https://github.com/vals/umis)
    """
    next_element = ''
    for i, line in enumerate(file_handler):
        if i % 4 == 1:
            yield line
        if i % 4 == 3:
            qualities = [ord(x) - 33 for x in line.strip()]
            yield qualities

if __name__ == "__main__":
    parser = ArgumentParser()
    parser.add_argument("fastq")
    args = parser.parse_args()
    parser_re = re.compile(""".*(CTGCAG)(?P<barcode>\w{24})(ACGCGT).*""")
    sample_re = re.compile(""".*(?P<sample>GEN\w*)_S.*""")
    match = sample_re.match(args.fastq)
    sample = match.group('sample')
    print "barcode", "barcodeq", "sample"
    fq_handle = stream_fastq(open(args.fastq))
    for rq in tz.partition(2, fq_handle):
    	read = rq[0]
    	quals = rq[1]
        match = parser_re.match(read)
        if match:
            barcode = match.group('barcode')
    	    barcodeq = np.mean(quals[match.start('barcode'):match.end('barcode')])
            print barcode, barcodeq, sample
